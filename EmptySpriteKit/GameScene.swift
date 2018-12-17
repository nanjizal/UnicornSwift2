//
//  GameScene.swift
//  EmptySpriteKit
//
//  Created by justin on 06/09/2016.
//  Copyright (c) 2016 justin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var unicorn : SKSpriteNode!
    var gallopFrames : [SKTexture]!
    // canvas size for the positioning
    let canvasWidth: UInt32 = 800
    let canvasHeight: UInt32 = 800
    override func didMoveToView(view: SKView) {
        
        // we live in a world with gravity on the y axis
        self.physicsWorld.gravity = CGVectorMake(0, -6)
        // we put contraints on the top, left, right, bottom so that our balls can bounce off them
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        // we set the body defining the physics to our scene
        self.physicsBody = physicsBody
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        let frame = self.frame
        myLabel.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        
        self.addChild(myLabel)
        setupGallopFrames()
        let firstFrame = gallopFrames[0]
        unicorn = SKSpriteNode(texture: firstFrame)
        unicorn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(unicorn)
        gallop()
        
        unicorn.physicsBody = SKPhysicsBody(texture: firstFrame, size:unicorn.size)
        // this defines the mass, roughness and bounciness
        unicorn.physicsBody?.friction = 0.3
        unicorn.physicsBody?.restitution = 0.8
        unicorn.physicsBody?.mass = 0.5
        // this will allow the balls to rotate when bouncing off each other
        unicorn.physicsBody?.allowsRotation = false
        

        // let's create 20 bouncing balls
        for i in 1...30 {

            // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
            // it has built in support for primitives like a circle, so we pass a radius
            let shape = SKShapeNode(circleOfRadius: 20)
            // we set the color and line style
            shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
            shape.lineWidth = 4
            // we create a text node to embed text in our ball
            let text = SKLabelNode(text: String(i))
            // we set the font
            text.fontSize = 9.0
            // we nest the text label in our ball
            shape.addChild(text)

            // we set initial random positions
            shape.position = CGPoint (x: CGFloat(arc4random()%canvasWidth)
                                    , y: CGFloat(arc4random()%canvasHeight))
            // we add each circle to the display list
            self.addChild(shape)

            // this is the most important line, we define the body
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            // this defines the mass, roughness and bounciness
            shape.physicsBody?.friction = 0.3
            shape.physicsBody?.restitution = 0.8
            shape.physicsBody?.mass = 0.5
            // this will allow the balls to rotate when bouncing off each other
            shape.physicsBody?.allowsRotation = true
        }
        
        
    }
    func setupGallopFrames(){
        let unicornSequence = SKTextureAtlas(named: "unicornGallop")
        gallopFrames = [SKTexture]()
        
        let numImages = unicornSequence.textureNames.count
        for i in 1...numImages {
            let unicornTextureName = "unicornAnimation000\(i)"
            gallopFrames.append( unicornSequence.textureNamed(unicornTextureName))
        }
        
    }
    func gallop() {
        //This is our general runAction method to make our unicorn gallop.
        unicorn.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(gallopFrames,
                timePerFrame: 0.05,
                resize: false,
                restore: true)),
                       withKey:"galloping")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            unicorn.position = location
            //unicorn.removeActionForKey("galloping")
            /*
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
            */
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if unicorn != nil { 
            //unicorn.physicsBody = SKPhysicsBody(texture: unicorn.!texture, size: unicorn.size)
            //print( unicorn.texture )
        }
       // if unicorn != nil { unicorn.zRotation += CGFloat(M_PI/30) }
        /* Called before each frame is rendered */
    }
}
