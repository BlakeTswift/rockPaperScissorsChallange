//
//  ContentView.swift
//  rockPaperScissorsChallange
//
//  Created by Trytten, Blake - Student on 10/15/25.
//

import SwiftUI
import AudioToolbox


struct ContentView: View {
    private var Options = ["🪨","📄","✂️"]
    
    @State private var playerChoice = "❓"
    @State private var computerChoice = "❓"
    
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    @State private var tieBrakerActive = false
    
    @State private var tieScoring: [Int]  = []
    @State private var recentWinner = 0
    
    
    
    
    var body: some View {
        VStack {
            Text("🪨 📄 ✂️")
                .font(.system(size: 72))
                .padding(.top, 50)
            Text("Rock Paper \nScissors")
                .multilineTextAlignment(.center)
                .font(.system(size: 70).bold())
            
            
        }
        .opacity(tieBrakerActive ? 0 : 1)
        .frame(height: tieBrakerActive ? 0 : .infinity)
        Spacer()

        VStack{
            
            Text ("Tie Breaker")
                .font(.system(size: 30).bold())
                .foregroundStyle(.white)
            HStack{
                
                Circle()
                    .stroke(lineWidth: 4)
                    .frame(width: 50)
                    .background(Circle().fill(.white))
                    .padding(.horizontal, 20)
                Circle()
                    .stroke(lineWidth: 4)
                    .frame(width: 50)
                    .background(Circle().fill(.white))
                    .padding(.horizontal, 20)
                Circle()
                    .stroke(lineWidth: 4)
                    .frame(width: 50)
                    .background(Circle().fill(.white))
                    .padding(.horizontal, 20)
                
            }
        }
        .frame(height: tieBrakerActive ? .infinity : 0)
        .padding(.bottom, 50)
        .background(.purple)
        .cornerRadius(20)
        .opacity(tieBrakerActive ? 1 : 0)
        .animation(.easeInOut, value: tieBrakerActive)
        
        
        
        
        
        Spacer()
        VStack {
            HStack {
                Spacer()
                Circle()
                    .stroke(lineWidth: 10)
                    .fill(Color.blue)
                    .frame(width: 200)
                    .overlay{
                        Text(playerChoice)
                            .font(.system(size: 120))
                    }
                Spacer()
                Text("VS")
                    .font(.system(size: 100).bold())
                Spacer()
                Circle()
                    .stroke(lineWidth: 10)
                    .fill(Color.red)
                    .frame(width: 200)
                    .overlay{
                        Text(computerChoice)
                            .font(.system(size: 120))
                    }
                Spacer()
                
            }
            Button{
                if playerChoice != "❓" {
                    computerChoice = Options.randomElement() ?? "❌"
                    
                    
                }
                
                
                if tieBrakerActive {
                    TieBreaker()
                }
                else {
                    DecideWhoWins()
                }
                
            }
            label:{
                Text("Start")
                    .font(.system(size: 60).bold())
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(20)
                
            }
            HStack {
                Button {
                    playerChoice = Options[0]
                }
                label:{
                    Circle()
                        .stroke(lineWidth: 7)
                        .fill(Color.yellow)
                        .frame(width: 125)
                        .padding(.horizontal,30)
                        .padding(.vertical,20)
                        .overlay{
                            Text("🪨")
                                .font(.system(size: 75))
                            
                        }
                }
                Button {
                    playerChoice = Options[1]
                }
                label:{
                    Circle()
                        .stroke(lineWidth: 7)
                        .fill(Color.yellow)
                        .frame(width: 125)
                        .padding(.horizontal,30)
                        .padding(.vertical,20)
                        .overlay{
                            Text("📄")
                                .font(.system(size: 75))
                            
                        }
                }
                Button {
                    playerChoice = Options[2]
                }
                label:{
                    Circle()
                        .stroke(lineWidth: 7)
                        .fill(Color.yellow)
                        .frame(width: 125)
                        .padding(.horizontal,30)
                        .padding(.vertical,20)
                        .overlay{
                            Text("✂️")
                                .font(.system(size: 75))
                            
                        }
                }
                
            }
            HStack {
                Spacer()
                VStack{
                    Text("Player")
                        .font(.system(size: 50).bold())
                    Text("\(playerScore)")
                        .font(.system(size: 100).bold())
                }
                Spacer()
                VStack{
                    Text("Computer")
                        .font(.system(size: 50).bold())
                    Text("\(computerScore)")
                        .font(.system(size: 100).bold())
                }
                Spacer()
            }
            Button{
                playerScore = 0
                computerScore = 0
                playerChoice = "❓"
                computerChoice = "❓"
                
                tieBrakerActive = false
                
                tieScoring.removeAll()
            }label:{
                Image(systemName:"arrow.trianglehead.counterclockwise")
                    .foregroundStyle(.white)
                    .font(.system(size: 100))
                    .padding(.horizontal,50)
                    .background(RoundedRectangle(cornerRadius: 50).fill(Color.blue))
                
                
            }
            
            
            Spacer()
            
        }
    }
    func DecideWhoWins(){
        if playerChoice == Options[0] && computerChoice == Options[2]{
            playerScore += 1
        }
        else if playerChoice == Options[1] && computerChoice == Options[0]{
            playerScore += 1
        }
        else if playerChoice == Options[2] && computerChoice == Options[1]{
            playerScore += 1
        }
        else if playerChoice == computerChoice && playerChoice != "❓"{
            tieBrakerActive = true
        }
        else {
            computerScore += 1
        }
        
        
        
        
        
        
    }
    func TieBreaker(){
        let soundID: SystemSoundID = 1325
        AudioServicesPlaySystemSound(soundID)
        
        var seenElements: Set<Int> = []
        
        let repeatingElements = tieScoring.filter { element in
            if seenElements.contains(element) {
                return true
            } else {
                seenElements.insert(element)
                return false
            }
        }
        
        if repeatingElements.isEmpty{
            
            
            if playerChoice == Options[0] && computerChoice == Options[2]{
                recentWinner = 1
                tieScoring.append(recentWinner)
            }
            else if playerChoice == Options[1] && computerChoice == Options[0]{
                recentWinner = 1
                tieScoring.append(recentWinner)
            }
            else if playerChoice == Options[2] && computerChoice == Options[1]{
                recentWinner = 1
                tieScoring.append(recentWinner)
            }
            else if playerChoice == computerChoice {
                recentWinner = 0
                print("tie")
            }
            else {
                recentWinner = 2
                tieScoring.append(recentWinner)
            }
            
        }
        else if repeatingElements.contains(1) {
            tieBrakerActive = false
            playerScore += 1
            print("player won")
        }
        else {
            tieBrakerActive = false
            computerScore += 1
            print("computer won")
        }
        
        
    }
}
#Preview {
    ContentView()
}
