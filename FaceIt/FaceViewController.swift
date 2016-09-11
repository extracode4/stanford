//
//  ViewController.swift
//  FaceIt
//
//  Created by extrabass4 on 06/09/16.
//  Copyright © 2016 extrabass4. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController
{
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smile) {
        didSet {
            updateUI() // Model changed, so update the View
        }
    }
    
    // didSet work once, when outlets are sets, because in expression = FacialExpression(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smile)  если вы устанавливаете значение в процессе инициализации, didSet { } не вызывается. Он вызывается, если вы будете устанавливать expression позже. Почему так? Потому что вы знаете, что когда вещи инициализируются в Swift, они должны быть полностью инициализированы, прежде, чем вы сможете с ними что-то делать.
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
            target: faceView, action: #selector(FaceView.changeScale(_:))
            ))
            updateUI()
        }
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0 ]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]

}

