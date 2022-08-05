//
//  ContentView.swift
//  AnimatableData
//
//  Created by Skorobogatow, Christian on 4/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
//            RoundedRectangle(cornerRadius: animate ? 60 : 0)
//            RectanglWithSingleCornerAnimation(cornerRadius: animate ? 60 :0)
            Pacman(offSetAmount: animate ? 20 : 0)
                .frame(width: 250, height: 250)
                .foregroundColor(.yellow)
                
        }
        .onAppear {
            withAnimation(.easeInOut.repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct RectanglWithSingleCornerAnimation: Shape {
    
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            
        }
    }
}

struct Pacman: Shape {
    
    var offSetAmount: CGFloat
    
    
    var animatableData: Double {
        get { offSetAmount }
        set { offSetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.minY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: offSetAmount),
                        endAngle: Angle(degrees: 360 - offSetAmount),
                        clockwise: false)
        }
    }
}
