//
//  ViewController.swift
//  BullsEye
//
//  Created by Myko.k on 22/06/2020.
//  Copyright © 2020 Myko.k. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var clickMeButton: UIButton!
    
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var roundValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleGameReset()
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = calculateEarnedPoints(basedOn: difference)
        let alertMessage =  "The value of the slider is: \(currentValue)" +
                            "\nThe target value is \(targetValue)" +
                            "\n You've earnned \(points) points"

        let alert = UIAlertController(title: processAlertTitle(basedOn: difference), message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.score += points
            self.startNewRound()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func slideMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    
    @IBAction func handleGameReset() {
        score = 0
        round = 0
        startNewRound()
    }
    

    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
    }
    
    func updateLabels() {
        randomNumberLabel.text = String(targetValue)
        scoreValueLabel.text = String(score)
        roundValueLabel.text = String(round)
    }
    
    func calculateEarnedPoints(basedOn difference: Int) -> Int {
        return 100 - difference
    }
    
    func processAlertTitle(basedOn difference: Int) -> String {
        let title: String

        if (difference == 0) {
            title = "Perfect!"
        } else if (difference < 5) {
            title = "You almost nailed it!"
        } else if (difference < 10) {
           title = "Pretty good!"
        } else {
            title = "Not even close!"
        }
        
        return title
    }
}

