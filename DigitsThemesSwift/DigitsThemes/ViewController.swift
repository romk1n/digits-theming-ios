//
//  ViewController.swift
//  DigitsThemes
//
//  Created by Valentin Polouchkine  on 8/12/15.
//  Copyright (c) 2015 Fabric. All rights reserved.
//
// Background pattern from subtlepatterns.com

import UIKit
import DigitsKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            btnLogin.hidden = true
        }
    }
    
    weak var authButton: DGTAuthenticateButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Digits.sharedInstance().logOut()
        
        
        self.createButton(UIColor.greenColor())
        
        // NONE of those colors work
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(update
            ), userInfo: nil, repeats: true)

    }
    
    func update() {
        
        let customGreen = UIColor(red:79/255, green:195/255, blue:150/255, alpha:1)
        let customBlue = UIColor(red:126/255, green:177/255, blue:230/255, alpha:1)
        
        let colors = [UIColor.greenColor(), customGreen, customBlue, UIColor.yellowColor()]
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        self.authButton.removeFromSuperview()
        self.createButton(colors[index])
    }
    
    func createButton(color: UIColor) {
        
        let authButton = DGTAuthenticateButton(authenticationCompletion: { (session: DGTSession?, error: NSError?) in
            if (session != nil) {
                // TODO: associate the session userID with your user model
                let message = "Phone number: \(session!.phoneNumber)"
                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: .None))
                self.presentViewController(alertController, animated: true, completion: .None)
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        })
        self.authButton = authButton
        self.authButton.center = self.view.center
        self.authButton.digitsAppearance = {
            
            let config = DGTAppearance()
            config.backgroundColor = UIColor.whiteColor()
            config.accentColor = color
            
            return config
        }()
        self.view.addSubview(self.authButton)
    }

    
    @IBAction func didTapButton(sender: UIButton) {

   }
}
