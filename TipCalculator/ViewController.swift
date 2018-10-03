//
//  ViewController.swift
//  TipCalculator
//
//  Created by minami on 2018-10-02.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var numOfPeople: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var tipPercentage: UILabel!
    @IBAction func billField(_ sender: UITextField) {
        if let textBill = sender.text, textBill.count > 0 {
            bill = Int(textBill)!
        }
    }
    
    @IBAction func peopleField(_ sender: UITextField) {
        if let textPeople = sender.text, textPeople.count > 0 {
            people = Int(textPeople)!
        }
    }
    var percent = 15 {
        didSet {
            cal()
        }
    }
    
    var bill = 0 {
        didSet {
            cal()
        }
    }
    
    var people = 1 {
        didSet {
            cal()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmount.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: ViewController.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: ViewController.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if view.frame.origin.y == 0 { // origin.y is the top of our view
                view.frame.origin.y -= keyboardHeight // or you can set any number like 150
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if view.frame.origin.y != 0 { // origin.y is the top of our view
                view.frame.origin.y += keyboardHeight
            }
            
        }
    }
    
    // delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // textField == billAmount
        textField.resignFirstResponder() // go away when you press the enter key
        return true
    }
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        billAmount.resignFirstResponder() // go away when you tap the view
        numOfPeople.resignFirstResponder()
    }
    
    @IBAction func tipSlider(_ sender: UISlider) {
        percent = Int(sender.value)
        tipPercentage.text = "\(percent) %"
    }
    
    
    fileprivate func cal() {
        if let bill = billAmount.text, bill.count > 0, let nPeople = numOfPeople.text {
            var total = Double(bill)!
            var num = 1
            if nPeople.count > 0, Int(nPeople)! > 1 {
                num = Int(nPeople)!
            }
            if percent > 0 {
                total += total * Double(percent) / 100
            }
            total = total / Double(num)
            tipAmount.text = "$ \(total)"
        }
    }
    
    @IBAction func calculateTip(_ sender: UIButton) {
        cal()
    }


}

