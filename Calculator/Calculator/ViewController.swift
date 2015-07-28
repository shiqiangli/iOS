//
//  ViewController.swift
//  Calculator
//
//  Created by lishiqiang on 15/7/27.
//  Copyright (c) 2015年 lishiqiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleTypingANumber: Bool = false
    var brain = CalculatorBrain()
    var dotCount = 0;
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if digit == "." {
            dotCount++
        }
        
        if userIsInTheMiddleTypingANumber {
            if dotCount > 1 && digit == "." {
                display.text = display.text!
            } else {
                display.text = display.text! + digit
            }
        } else {
            if digit == "." {
                display.text = "0" + digit
            } else {
                display.text = digit
            }
            userIsInTheMiddleTypingANumber = true
        }
        
    }
    
    @IBAction func backSpace() {
        if !display.text!.isEmpty {
            clear()
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleTypingANumber = false
        dotCount = 0
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleTypingANumber = false
        }
    }
        
    @IBAction func clear() {
        userIsInTheMiddleTypingANumber = false
        display.text = "0"
        dotCount = 0
        brain.clear()
    }
}

