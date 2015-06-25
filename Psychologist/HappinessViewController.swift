//
//  HappinessViewController.swift
//  Happiness
//
//  Created by liubin on 15/6/23.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource, UIPopoverPresentationControllerDelegate {
    
    private let happinessHistoryStore = NSUserDefaults.standardUserDefaults()
    
    var happinessHistory: [Int] {
        get {
            println("userDefaults: \(happinessHistoryStore.objectForKey(Constants.HappinessHistoryKey))")
            return happinessHistoryStore.objectForKey(Constants.HappinessHistoryKey) as? [Int] ?? []
        }
        set {
            happinessHistoryStore.setObject(newValue, forKey: Constants.HappinessHistoryKey)
        }
    }
    

    // 0 - 100
    var happiness: Int = 75 {
        didSet {
            happiness = max(min(happiness, 100), 0)
            println("happiness: \(happiness)")
            updateUI()
            happinessHistory += [happiness]
        }
    }
    
    struct Constants {
        static let HappinessHistoryKey = "HappinessHistoryKey"
    }
    
    
    func updateUI() {
        faceView?.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Changed: fallthrough
        case .Ended:
            let point = gesture.translationInView(faceView)
            println("point.y in pan: \(point.y)")
            let happinessChange = -Int(point.y) / 4
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let hvc = segue.destinationViewController as? HistoryViewController {
            if let id = segue.identifier {
                switch id {
                case "showHistory":
                    hvc.text = happinessHistory.description
                    if let ppc = hvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                default:
                    break
                }
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
