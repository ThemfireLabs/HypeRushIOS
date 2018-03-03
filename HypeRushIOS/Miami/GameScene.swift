import SpriteKit
import GameplayKit
import AudioToolbox

class GameScene: BaseGameScene, SKPhysicsContactDelegate {
    
   
    override func sceneDidLoad() {
        

        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == ColliderType.Ground.rawValue || contact.bodyB.categoryBitMask == ColliderType.Ground.rawValue {
            jumpCounter = 0
        } else  if contact.bodyA.categoryBitMask == ColliderType.Coin.rawValue || contact.bodyB.categoryBitMask == ColliderType.Coin.rawValue {
            
            if let coin = contact.bodyA.node {
                coin.removeFromParent()
            } else if let coinB = contact.bodyB.node {
                coinB.removeFromParent()
            }
            
        }
        
    }
    
    
    override func didMove(to view: SKView) {
        //                    rockTileMap.removeFromParent()
        self.physicsWorld.contactDelegate = self
        let pauseTexture = SKTexture(image: #imageLiteral(resourceName: "pause_button"))
        self.pauseNode = SKSpriteNode(texture: pauseTexture )
        
        self.pauseNode.position = CGPoint(x: (-self.frame.width/2) + 80, y: (self.frame.height/2) - 80)
        self.pauseNode.name = "pauseButton"
        self.addChild(pauseNode)
        self.setupGame()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if jumpCounter != 1 {
            hypeBeast.physicsBody?.isDynamic = true
            hypeBeast.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            hypeBeast.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 60))
            jumpCounter += 1
        }
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        resumeClicked = false
        
        let array = [tapToPlayLabel]
        self.removeChildren(in: array)
        
        if let name = touchedNode.name
        {
            if name == "pauseButton" {
                self.pause()
            } else if name == "resumeButton" || name == "resumeLabel" {
                self.resume()
            } else if name == "restartButton" || name == "restartLabel" {
                self.restart()
            } else if name == "quitButton" || name == "quitLabel" {
                self.quit()
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
 
    
}


