//
//  ViewController.swift
//  Jeb
//
//  Created by Mark Pizzutillo on 12/16/17.
//  Copyright © 2017 Mark Pizzutillo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let bushNum = 911
    
    var jebCount = 0 {
        didSet {
            jebLabel.text = "Jeb Count: \(jebCount)"
        }
    }
    
    var audioPlayer:AVAudioPlayer!
    
    var audioFiles = ["pleaseclap","excusemejeb","jebisamess","jebisawaste","steadyhand","standardop"]
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var jebLabel: UILabel!
    @IBOutlet weak var jebView: UIView!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    
    @IBAction func handleTap(_ sender: Any) {
        //Update jeb Count variable
        jebCount += 1
        
        var imageName = "jebface"
        
        if (jebCount == bushNum) {
            imageName = "george"
        }
        
        //Using this image:
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        //Random x and y coordinates
        let xCord = (Int(arc4random_uniform(UInt32(self.jebView.frame.width))) - 398/2)
        let yCord = (Int(arc4random_uniform(UInt32(self.jebView.frame.height))) - 209/2)
        
        if (jebCount == bushNum) {
            imageView.frame = CGRect(x: xCord, y: yCord, width: 326, height: 435)
        } else {
            imageView.frame = CGRect(x: xCord, y: yCord, width: 398, height: 209)
        }
        jebView.addSubview(imageView)
        
        //Play sound
        
        if (soundSwitch.isOn) {
            var path: String?
            
            if (jebCount == bushNum) {
                path = Bundle.main.path(forResource: "nationaltragedy", ofType: "wav")
            } else {
                //Get index of sound file to play
                let soundIndex = Int(arc4random_uniform(UInt32(audioFiles.count)))
                
                //Get path of file
                path = Bundle.main.path(forResource: audioFiles[soundIndex], ofType: "wav")
            }
            
            let url = URL(fileURLWithPath: path!)
            
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                // Error: File not loaded
                print("Error...")
            }
            
            audioPlayer.play()
        }
        
    }
}

