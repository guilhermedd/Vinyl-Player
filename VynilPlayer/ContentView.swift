//
//  ContentView.swift
//  TrainApp
//
//  Created by Gabriela dos Santos on 01/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var is_spinning = false
    @State private var angle = 0.0
    @State private var screen_proportion = 0.8
    @State private var last_update = Date()
    
    
    var body: some View {
        VStack {
            Button {
                is_spinning.toggle()
                last_update = Date()
            } label: {
                Label(is_spinning ? "Parar" : "Começar a girar",
                      systemImage: is_spinning ? "pause.fill" : "play.fill")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(is_spinning ? .red : .green)
            
            TimelineView(.animation) { timeline in
                
                GeometryReader { geo in
                    
                    Image("vynil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(.degrees(angle))
                        .position(x: 0, y: geo.size.height *  screen_proportion)
                        .onChange(of: timeline.date) { _, now in
                            guard is_spinning else { return }
                            let delta = now.timeIntervalSince(last_update)
                            angle += delta * 70
                            last_update = now
                        }
                }
            }
            .padding(.horizontal)
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
