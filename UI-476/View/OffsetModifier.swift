//
//  OffsetModifier.swift
//  UI-476
//
//  Created by nyannyan0328 on 2022/02/23.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    var cooordinateSpace : String = ""
    var rect : (CGRect) -> ()
    func body(content: Content) -> some View {
        content
            .overlay {
                
                
                GeometryReader{proxy in
                    
                    Color.clear
                        
                        .preference(key: OffetKey.self, value: proxy.frame(in: .named(cooordinateSpace)))
                    
                    
                }
                
                
                
            }
            .onPreferenceChange(OffetKey.self) { rect in
                
                
                self.rect(rect)
            }
    }
}

struct OffetKey : PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        
        value = nextValue()
    }
    
    
}
