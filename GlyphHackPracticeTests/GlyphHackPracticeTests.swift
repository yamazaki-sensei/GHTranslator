//
//  GlyphHackPracticeTests.swift
//  GlyphHackPracticeTests
//
//  Created by Hiraku Ohno on 2015/01/31.
//  Copyright (c) 2015年 Hiraku Ohno. All rights reserved.
//

import UIKit
import XCTest

class GlyphHackPracticeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEqual() {
        let paths1: Set<GlyphPath> = [GlyphPath(point1: 0, point2: 10)]
        let glyph1 = try! GlyphGenerator.sharedGenerator().createGlyphWithType("", path: paths1)
        
        let paths2: Set<GlyphPath> = [GlyphPath(point1: 0, point2: 5),
                                            GlyphPath(point1: 5, point2: 10)]
        let glyph2 = try! GlyphGenerator.sharedGenerator().createGlyphWithType("", path: paths2)
        
        XCTAssert(glyph1.isEqual(glyph2), "")
    }
    
    func testCreatingChaosGlyph() {
        let chaos = try! GlyphGenerator.sharedGenerator().createGlyphWithType("Chaos", path: nil)
        
        let inputPath: Set<GlyphPath> = [
                                               GlyphPath(point1: 0, point2: 1),
                                               GlyphPath(point1: 1, point2: 8),
                                               GlyphPath(point1: 0, point2: 2),
                                               GlyphPath(point1: 2, point2: 6),
                                               GlyphPath(point1: 6, point2: 10),
                                              ]
        let inputGlyph = try! GlyphGenerator.sharedGenerator().createGlyphWithType("", path: inputPath)
        XCTAssert(chaos.isEqual(inputGlyph), "")
    }
    
    func testIfNilGlyphExists() {
        let allGlyphSequences:[[[String]]] = GlyphSequenceProvider.sharedProvider().provideAllSequence()
        for sequence1:[[String]] in allGlyphSequences {
            for sequence2:[String] in sequence1 {
                for type in sequence2 {
                    let glyph: Glyph? = try! GlyphGenerator.sharedGenerator().createGlyphWithType(type)
                    XCTAssert(glyph != nil, "")
                }
            }
        }
    }
    
    func testFetchingItems() {
        
        let expectation = self.expectationWithDescription("fetch done");
        
        GlyphFetcher.sharedFetcher().fetchGlyphs().continueWithSuccessBlock { (task) -> AnyObject? in
            Log.d("\(task.result)")
            
            guard let result = task.result else {
                return nil
            }
            
            var resultDictionary = result as! Dictionary<String, AnyObject>
            
            try! GlyphGenerator.sharedGenerator().overwriteGlyphs(resultDictionary[GlyphFetcher.itemsName] as! Array<Dictionary<String, AnyObject>>)
            resultDictionary.removeValueForKey(GlyphFetcher.itemsName);
            try! GlyphSequenceProvider.sharedProvider().overwriteSequences(resultDictionary)
            
            
            let allGlyphSequences:[[[String]]] = GlyphSequenceProvider.sharedProvider().provideAllSequence()
            for sequence1:[[String]] in allGlyphSequences {
                for sequence2:[String] in sequence1 {
                    for type in sequence2 {
                        let glyph: Glyph? = try! GlyphGenerator.sharedGenerator().createGlyphWithType(type)
                        XCTAssert(glyph != nil, "")
                    }
                }
            }
            expectation.fulfill()
            return nil
        }
        
        let chaos = try! GlyphGenerator.sharedGenerator().createGlyphWithType("Chaos", path: nil)
        
        let inputPath: Set<GlyphPath> = [
                                               GlyphPath(point1: 0, point2: 1),
                                               GlyphPath(point1: 1, point2: 8),
                                               GlyphPath(point1: 0, point2: 2),
                                               GlyphPath(point1: 2, point2: 6),
                                               GlyphPath(point1: 6, point2: 10),
                                              ]
        let inputGlyph = try! GlyphGenerator.sharedGenerator().createGlyphWithType("", path: inputPath)
        XCTAssert(chaos.isEqual(inputGlyph), "")
        
        self.waitForExpectationsWithTimeout(10) { (error) -> Void in
        }
    }
}
