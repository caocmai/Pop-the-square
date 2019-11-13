//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by Jonathan Kopp on 9/29/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //Initialize score starting at 0
    var score = 0
    
    //Set up properties of the scoreLabel
    var scoreLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.text = "0"
        label.color = .white
        label.fontSize = 50
        
        return label
    }()
    
    override func didMove(to view: SKView) {
        //Called when the scene has been displayed
        
        //TODO: Create three squares with the names one,two,three
        self.createSquares(name: "one")
        self.createSquares(name: "two")
        self.createSquares(name: "three")
        
        //Setup the scoreLabel
        labelSetUp()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func labelSetUp() {
        scoreLabel.position.x = view!.bounds.width / 2
        scoreLabel.position.y = view!.bounds.height - 80
        addChild(scoreLabel)
    }
    
    func randomNumber()-> CGFloat {
        //Width of the SKScene's view
        let viewsWidth = self.view!.bounds.width
        //Creates a random number from 0 to the viewsWidth
        let randomNumber = CGFloat.random(in: 0 ... viewsWidth)
        
        return randomNumber
    }
    
    func createSquares(name: String) {
        //TODO: Set up square properties
        //1. Create a CGSize for the square with (width: 80, height: 80)
        //2. Create a Square node with a texture of nil. a color of .green and the size we created above
        //3. Set the squares name to the name we pass into this function
        let squareSize = CGSize(width: 80, height: 80)

        let square = SKSpriteNode(texture: nil, color: .green, size: squareSize)
        square.name = name
        
        
        //TODO: Set up the Squares x and y positions
        //1. Squares y positions shoud start at 40
        //2. Squares x positon should use the randomNumber generator provided above
        square.position.x = randomNumber()
        square.position.y = 40
        
        
        //Create an action to move the square up the screen
    
        let action = SKAction.customAction(withDuration: 2.0, actionBlock: { (square, _) in
            //TODO: Set up the squares animation
            //1. The squares y position should increase by 10
            //2. Create an if statement that checks if the squares y position is >= to the screens height
            //If it is remove the square and create a new square with the same name
            square.position.y += 3
            
            // Why is view optional? Why all this line of code just to determind the screen's height
            if square.position.y >= self.view!.frame.height {
                square.removeFromParent()
                self.score -= 1
                self.scoreLabel.text = ("\(self.score)")
                // Why optional for name?
                self.createSquares(name: square.name!)
            }
        }
        )
        
        
        //TODO: Have the square run the above animation forever and add the square to the SKScene!
        
        if score < 0 {
            self.scoreLabel.text = ("Game Over")
        } else {
            square.run(SKAction.repeatForever(action))
            addChild(square)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Loop through an array of touch values
        for touch in touches {
            
            //Grab the position of that touch value
            let positionInScene = touch.location(in: self)
            
            //Find the name for the node in that location
            // I think, finding the node
            let node = self.atPoint(positionInScene)
            
            //Check if there is an node there.
            // I think, finding the name in that node
            if node.name != nil {
                //TODO: Remove the square
                //Remove node from parent view
                //Increase the score by one
                //Create the square again with the same name
                node.removeFromParent()
                score += 1
                scoreLabel.text = ("\(score)")
                createSquares(name: node.name!)
            }
        }
    }
    
}
