import UIKit

class Context {
    
    private var state: State
    
    init(_ state: State) {
        self.state = state
    }
    
    func changeStatus(_ state: State) {
        self.state = state
    }
    
    func requestFirst() {
        state.handleFirst()
    }
    
    func requestSecond() {
        state.handleSecond()
    }
}

protocol State: class {
    func update(context: Context)
    func handleFirst()
    func handleSecond()
}

class BaseState: State {
    private(set) weak var context: Context?
    
    func update(context: Context) {
        self.context = context
    }
    
    func handleFirst() {
        print("base State first request")
    }
    
    func handleSecond() {
        print("base State first request")
    }
}

class StateA: BaseState {
    override func handleFirst() {
        super.handleFirst()
        print("Handle first function state A")
    }
    
    override func handleSecond() {
        super.handleSecond()
        print("Handle second function state A")
    }
}

class StateB: BaseState {
    override func handleFirst() {
        print("Handle first function state B")
        if let context = context {
            let stateA = StateA()
            context.changeStatus(stateA)
            stateA.update(context: context)
        }
    }
    
    override func handleSecond() {
        print("Handle second function state B")
        if let context = context {
            let stateA = StateA()
            context.changeStatus(stateA)
            stateA.update(context: context)
        }
    }
}

let stateB = StateB()
let context = Context(stateB)
stateB.update(context: context)

context.requestFirst()
context.requestSecond()

