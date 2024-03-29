//
//  ResultNode.swift
//  GlyphHackPractice
//
//  Created by OhnoHiraku on 2015/04/01.
//  Copyright (c) 2015年 Hiraku Ohno. All rights reserved.
//

import UIKit
import SpriteKit

class ResultNode: SKSpriteNode {
    
    let answerGlyph:Glyph
    let inputGlyph:Glyph
    
    init(texture: SKTexture!, color: UIColor!, size: CGSize, answerGlyph:Glyph, inputGlyph:Glyph) {
        self.answerGlyph = answerGlyph
        self.inputGlyph = inputGlyph
        super.init(texture: nil, color: color, size: size)
        
        self.prepareAnswerNode()
        self.prepareInputNode()
        self.prepareGlyphNameNode()
        self.prepareOKorNGNode()
    }
    
    private func prepareAnswerNode() {
        let node = self.createGlyphNode()
        node.showGlyph(self.answerGlyph, autoRemove: false, completion: nil)
        node.position = CGPointMake(self.size.width * 3.0 / 4.0, 0)
        self.addChild(node)
    }
    
    private func prepareInputNode() {
        let node = self.createGlyphNode()
        node.showGlyph(self.inputGlyph, autoRemove: false, completion: nil)
        node.position = CGPointMake(self.size.width / 4.0, 0)
        self.addChild(node)
    }
    
    private func prepareOKorNGNode() {
        let resultText = self.answerGlyph.isEqual(self.inputGlyph) ? "OK" : "NG"
        let resultLabel = GeneralLabelNode(text: resultText)
        resultLabel.position = CGPointMake(self.size.width / 2.0, -self.size.height / 5)
        resultLabel.fontSize = 20.0
        self.addChild(resultLabel)
    }
    
    private func prepareGlyphNameNode() {
        Log.d("self.size = \(self.size)")
        let glyphName = self.answerGlyph.type
        let glyphNameLabel = GeneralLabelNode(text: glyphName)
        glyphNameLabel.position = CGPointMake(self.size.width / 2.0, self.size.height / 6)
        glyphNameLabel.fontColor = SKColor.cyanColor()
        glyphNameLabel.fontName = "ArialHebrew-Bold"
        glyphNameLabel.fontSize = 20.0
        glyphNameLabel.alpha = 0.5
        self.addChild(glyphNameLabel)
    }
    
    private func createGlyphNode() -> RootNode {
        let rootNode = RootNode(color: SKColor.blackColor(), size: CGSizeMake(self.size.height, self.size.height))
        rootNode.particleScale = 0.3
        rootNode.vertexScale = 0.5
        rootNode.spaceBetweenParticles = 5
        rootNode.particleColor = UIColor.redColor()
        rootNode.prepare()
        return rootNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
