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
    var dotCount = 0
    
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
            if digit == "." { // for type ".1234", display "0.1234"
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
        let operation = sender.currentTitle!
        if userIsInTheMiddleTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "×": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        case "π": displayValue = M_PI
            enter()
        default:break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleTypingANumber = false
        dotCount = 0
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }

    var operandStack = Array<Double>()
    
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
        operandStack.removeAll(keepCapacity: false)
    }
}

