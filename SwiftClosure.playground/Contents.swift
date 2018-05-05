//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Closure Expressions

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reverseNames = names.sorted(by: backward)

print(reverseNames)

//: Closure Expression Syntax
/*:
    { (parameters) -> return type in
        statements
    }
 */

reverseNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})

print(reverseNames)

//: Inferring Type From Context
/*:
    It is always possible to infer the parameter types and return type
    when passing a closure to a function or method as an inline closure expression.
 */

reverseNames = names.sorted(by: {s1, s2 in
    return s1 > s2
})

print(reverseNames)

//: Implicit Returns from Single-Expression Closures
/*:
    Single-expression closures can implicitly return the result of their single expression
    by omitting the return keyword from their declaration, as in this version of the previous example
 */

reverseNames = names.sorted(by: {s1, s2 in s1 > s2})

print(reverseNames)

//: Shorthand Argument Names
/*:
    If you use these shorthand argument names within your closure expression,
    you can omit the closure’s argument list from its definition, and the number and type
    of the shorthand argument names will be inferred from the expected function type
 */

reverseNames = names.sorted(by: {$0 > $1})

print(reverseNames)

//: Operator Methods
/*:
    Swift’s String type defines its string-specific implementation of the greater-than operator (>)
    as a method that has two parameters of type String, and returns a value of type Bool.
    This exactly matches the method type needed by the sorted(by:) method.
 */

reverseNames = names.sorted(by: >)

print(reverseNames)

//: Trailing Closures
/*:
    A trailing closure is written after the function call’s parentheses,
    even though it is still an argument to the function.
 */

func someFunctionThatTakesAClosure(closure: () -> Void) {
    closure()
}

someFunctionThatTakesAClosure(closure: {
    print("I am a function taking a closure parameter")
})

/*:
    When you use the trailing closure syntax,
    you don’t write the argument label for the closure as part of the function call
 */

someFunctionThatTakesAClosure {
    print("Closure without argument label")
}

/*:
    Here’s how you can use the map(_:) method with a trailing closure
    to convert an array of Int values into an array of String values.
 */

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

print(strings)

//: Capturing Values
/*:
    In this example, the nesteed function "increment" captures two values,
    *runningTotal* and *amount*, from its surrounding context.
 */

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 2
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incermenter = makeIncrementer(forIncrement: 4)

print(incermenter())

//: Escaping Closures
/*:
    A closure is said to escape a function when the closure is passed as an argument
    to the function, but is called after the function returns.
 
    The function returns after it starts the operation, but the closure isn’t called
    until the operation is completed—the closure needs to escape, to be called later. For example
 */

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//: Marking a closure with @escaping means you have to refer to self explicitly within the closure

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200

completionHandlers.first?()
print(instance.x)
// Prints "100"
























