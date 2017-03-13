//
//  GameScene.swift
//  pong
//
//  Created by Shayne Wang on 1/24/17.
//  Copyright © 2017 Shayne Wang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var PlayerPaddlebot = SKSpriteNode()
    var PlayerPaddletop = SKSpriteNode()
    var playerScore = SKLabelNode()
    var botScore = SKLabelNode()
    struct scores {
        var player = 0
        var bot = 0
    }
    var scoreBoard = scores()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        PlayerPaddlebot = self.childNode(withName: "PlayerPaddlebot") as! SKSpriteNode
        PlayerPaddletop = self.childNode(withName: "PlayerPaddletop") as! SKSpriteNode
        botScore = self.childNode(withName: "BotScore") as! SKLabelNode
        playerScore = self.childNode(withName: "PlayerScore") as! SKLabelNode
        //ball.physicsBody?.applyImpulse(CGVector(dx:20,dy: -20))
        let boarder = SKPhysicsBody(edgeLoopFrom:self.frame)
        boarder.friction = 0
        boarder.restitution = 1
        self.physicsBody = boarder

    }
    
    func reset(){
        ball.position.x = 0
        ball.position.y = 0
        ball.physicsBody?.velocity = CGVector.zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            PlayerPaddlebot.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
        if ball.physicsBody?.velocity == CGVector.zero {
            ball.physicsBody?.applyImpulse(CGVector(dx:20,dy: -20))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            PlayerPaddlebot.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
        if ball.physicsBody?.velocity == CGVector.zero {
            ball.physicsBody?.applyImpulse(CGVector(dx:20,dy: -20))
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("a:")
        print(contact.bodyA.node?.name ?? " ")
        print("b:")
        print(contact.bodyB.node?.name ?? " ")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if ball.position.y >= PlayerPaddletop.position.y {
            self.scoreBoard.player += 1
            playerScore.text = "\(self.scoreBoard.player)"
            self.reset()
                    ball.speed = 0
        }
        else if ball.position.y <= PlayerPaddlebot.position.y {
            self.scoreBoard.bot += 1
            botScore.text = "\(self.scoreBoard.bot)"
            self.reset()
            sleep(1)
                    ball.speed = 0
        }
    }
}
