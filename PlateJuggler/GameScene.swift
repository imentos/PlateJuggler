//
//  GameScene.swift
//  PlateJuggler
//
//  Created by i818292 on 3/29/18.
//  Copyright © 2018 i818292. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var label: SKLabelNode?
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//levelLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0), completion: {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                self.initPlates()
            })
        }
    }
    
    func initPlates() {
        let w = CGFloat(80.0)
        let plate = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: 0)
        plate.name = "plate"
        plate.lineWidth = 2.5
        plate.physicsBody = SKPhysicsBody(circleOfRadius: w)
        plate.physicsBody?.mass = 10.1
        plate.physicsBody?.pinned = true
        //        spinnyNode.physicsBody?.affectedByGravity = true
        plate.physicsBody?.isDynamic = true
        plate.physicsBody?.angularDamping = 1.0
        plate.physicsBody?.angularVelocity = -3.0
        
        cloneNode(node: plate, atPoint: CGPoint(x:0, y:0))
        cloneNode(node: plate, atPoint: CGPoint(x:100, y:0))
        cloneNode(node: plate, atPoint: CGPoint(x:200, y:0))
    }
    
    func cloneNode(node: SKShapeNode, atPoint pos : CGPoint) {
        guard let n = node.copy() as? SKShapeNode else {
            return
        }
        n.position = pos
        addChild(n)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        enumerateChildNodes(withName: "plate") { (child, err) in
            if child.contains(pos) {
                child.physicsBody?.applyAngularImpulse(-0.5)
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        enumerateChildNodes(withName: "plate") { (child, err) in
            guard let node = child as? SKShapeNode else {
                return
            }
            node.physicsBody?.applyAngularImpulse(0.02)
            if (node.physicsBody?.angularVelocity)! > CGFloat(0.05) {
                //                node.physicsBody?.angularVelocity = 0.0
                //                node.strokeColor = UIColor.red
            } else {
                //                node.strokeColor = UIColor.blue
                
            }
        }
    }
}
