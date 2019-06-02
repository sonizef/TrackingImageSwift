//
//  ViewController.swift
//  ARTrackingImage
//
//  Created by Joris ZEFIRINI on 01/06/2019.
//  Copyright © 2019 Joris ZEFIRINI. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/object.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        guard let container = sceneView.scene.rootNode.childNode(withName: "container", recursively: false) else { return }
        container.runAction(SCNAction.scale(by: 0.1, duration: 0.1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        guard let arImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        
        configuration.trackingImages = arImage
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARImageAnchor else { return }
        
        //container
        guard let container = sceneView.scene.rootNode.childNode(withName: "container", recursively: false) else { return }
        
        let actIn = SCNAction.scale(by: 10, duration: 0.5)
        actIn.timingMode = SCNActionTimingMode.easeInEaseOut
        
        node.addChildNode(container)
        container.isHidden = false
        
        container.runAction(actIn)
    }
    

}
