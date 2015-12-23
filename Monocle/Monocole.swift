//
//  Monocole.swift
//  Monocle
//
//  Created by Quentin Ribierre on 12/23/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import Foundation

public final class Monocole<T>
{
    //MARK: Properties
    
    private(set) var value: T {
        didSet {
            self.runObserversCompletionClosures(value)
        }
    }
    
    lazy private var observers: [((T) -> ())] = {
        return Array()
    }()
    
    //MARK: Init
    
    public init(initValue: T)
    {
        self.value = initValue
    }
    
    //MARK: Public Methods
    
    public func next(value: T)
    {
        self.value = value
    }
    
    public func addObserver(observerClosure: (T) -> ())
    {
        self.observers.append(observerClosure)
    }
    
    public func bindTo(bindedMonocole: Monocole<T>)
    {
        bindedMonocole.addObserver { (newValue: T) -> () in
            self.next(newValue)
        }
    }
    
    public func biDirectionalBindingTo(bindedMonocole: Monocole<T>)
    {
        self.bindTo(bindedMonocole)
        bindedMonocole.bindTo(self)
    }
    
    //MARK: Private Methods
    
    private func runObserversCompletionClosures(value: T)
    {
        for observerClosure in self.observers
        {
            observerClosure(value)
        }
    }
}
