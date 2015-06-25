//
//  ViewController.swift
//  Psychologist
//
//  Created by liubin on 15/6/25.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var happiness = 50
        if let id = segue.identifier {
            switch id {
            case "showGoldenBear":
                happiness = 25
            case "showDancingTree":
                happiness = 75
            case "showBuckeye":
                happiness = 100
            default:
                break
            }
            
            if let nc = segue.destinationViewController as? UINavigationController {
                if let hvc = nc.visibleViewController as? HappinessViewController {
                    hvc.happiness = happiness
                }
            }
        }
    }

    @IBAction func showBuckeye(sender: AnyObject) {
        performSegueWithIdentifier("showBuckeye", sender: nil)
        
    }
}

