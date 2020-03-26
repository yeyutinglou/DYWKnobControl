//
//  DYWKnob.swift
//  KnobShowcase
//
//  Created by jyd on 2020/3/26.
//  Copyright © 2020 jyd. All rights reserved.
//

import UIKit


@IBDesignable public class DYWKnob: UIControl {
    
    public var minimumValue: Float = 0
    
    public var maximumValue: Float = 1
    
    public private (set) var value: Float = 0
    
    public func setValue(_ newValue: Float, animated: Bool = true) {
        value = min(maximumValue, max(minimumValue, newValue))
        
        let angleRange = endAngle - startAngle
        let valueRange = maximumValue - minimumValue
        let angleValue = CGFloat(value - minimumValue) / CGFloat(valueRange) * angleRange + startAngle
        
        renderer.setPointerAngle(angleValue, animated: animated)
        
    }
    
    public var isContinuous = true
    
     let renderer = DYWKnobRenderer()
    
    /** defaults to 2 */
    @IBInspectable public var lineWidth: CGFloat {
        get { return renderer.lineWidth }
        set { renderer.lineWidth = newValue }
    }
    
    /** defaults to -11π/8 */
    public  var startAngle: CGFloat {
        get { return renderer.startAngle }
        set { renderer.startAngle = newValue }
    }
    
    /** defaults to 3π/8 */
    public var endAngle: CGFloat {
        get { return renderer.endAngle }
        set { renderer.endAngle = newValue }
    }
    
    /** defaults to 6 */
    @IBInspectable public var pointerLength: CGFloat {
        get { return renderer.pointerLenth }
        set { renderer.pointerLenth = newValue }
    }
    
    /** defaults to blue */
    @IBInspectable public var color: UIColor {
        get { return renderer.color }
        set { renderer.color = newValue }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func tintColorDidChange() {
        renderer.color = tintColor
    }
    
    
    private func commonInit() {
        renderer.updateBounds(bounds)
        renderer.color = tintColor
        renderer.setPointerAngle(renderer.startAngle)
        
        layer.addSublayer(renderer.trackLayer)
        layer.addSublayer(renderer.pointerLayer)
        
        let gestureRecognizer = DYWRotationGestureReconizer(target: self, action: #selector(handleGesture(_:)))
        addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc private func handleGesture(_ gesture: DYWRotationGestureReconizer) {
        // 1
           let midPointAngle = (2 * CGFloat(Double.pi) + startAngle - endAngle) / 2 + endAngle
           // 2
           var boundedAngle = gesture.touchAngle
           if boundedAngle > midPointAngle {
             boundedAngle -= 2 * CGFloat(Double.pi)
           } else if boundedAngle < (midPointAngle - 2 * CGFloat(Double.pi)) {
             boundedAngle -= 2 * CGFloat(Double.pi)
           }

           // 3
           boundedAngle = min(endAngle, max(startAngle, boundedAngle))

           // 4
           let angleRange = endAngle - startAngle
           let valueRange = maximumValue - minimumValue
           let angleValue = Float(boundedAngle - startAngle) / Float(angleRange) * valueRange + minimumValue

           // 5
           setValue(angleValue)

           if isContinuous {
             sendActions(for: .valueChanged)
           } else {
             if gesture.state == .ended || gesture.state == .cancelled {
               sendActions(for: .valueChanged)
             }
           }
    }
    
    
    
}


extension DYWKnob {
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        renderer.updateBounds(bounds)
    }
}

