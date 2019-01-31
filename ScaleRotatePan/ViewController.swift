//
//  ViewController.swift
//  ScaleRotatePan
//
//  Created by Pankaj Kulkarni on 31/01/19.
//  Copyright © 2019 Pankaj Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueImageView: UIImageView!
    @IBOutlet weak var redImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addGestureRecognizers(toFrames: [blueImageView, redImageView])
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
        
    }

    func addGestureRecognizers(toFrames views: [UIView]) {
        for view in views {
            view.isUserInteractionEnabled = true
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            view.addGestureRecognizer(pan)
            pan.delegate = self
            
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(hadlePinch(_:)))
            view.addGestureRecognizer(pinch)
            pinch.delegate = self
            
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
            view.addGestureRecognizer(rotate)
            rotate.delegate = self
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == view {
            let tapPosition = sender.location(in: view)
            let randomSize = CGSize(width: 50.0 + CGFloat.random(in: 50.0...100.0), height: 30.0 + CGFloat.random(in: 30.0...60.0))
            let newImageView = UIImageView(frame: CGRect(origin: tapPosition, size: randomSize))
            newImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 0.5)
            view.addSubview(newImageView)
            addGestureRecognizers(toFrames: [newImageView])
        }
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let translation = sender.translation(in: view)
        card.center = CGPoint(x: card.center.x + translation.x, y:  card.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func handleRotation(_ sender: UIRotationGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.rotated(by: sender.rotation))!
        sender.rotation = 0
    }
    
    @objc func hadlePinch(_ sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
    }

}


extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
