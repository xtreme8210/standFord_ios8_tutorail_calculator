//
//  ViewController.swift
//  Calculator
//
//  Created by York on 2015/4/13.
//  Copyright (c) 2015年 York. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variable
    var userIsInTheMiddleOfTypingANumber = false
    var operandStack = Array<Double>()
    
    //MARK: - IBOutlet
    @IBOutlet weak var display: UILabel!
    
    //MARK: - IBAction
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
            case "×": performOperation { (op1, op2) in op1 * op2 }
            case "÷": performOperation { (op1, op2) in op2 / op1 }
            case "+": performOperation { (op1, op2) in op1 + op2 }
            case "−": performOperation { (op1, op2) in op2 - op1 }
            case "√": performOperationOne { op1 in sqrt(op1) }
        default: break
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append((display.text! as NSString).doubleValue)
        println("operandStack = \(operandStack)")
    }
    
    //MARK: - Function
    func performOperation(operation: (Double, Double) -> Double) {
        
        var displayValue = (display.text! as NSString).doubleValue
        
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            display.text = displayValue.description
            enter()
        }
    }
    
    func performOperationOne(operation: Double -> Double) {
        
        var displayValue = (display.text! as NSString).doubleValue
        
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            display.text = displayValue.description
            enter()
        }
    }
    
    func multiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    //MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}

