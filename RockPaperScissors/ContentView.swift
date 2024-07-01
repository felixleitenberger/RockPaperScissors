//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Felix Leitenberger on 01.08.23.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock = "🪨"
    case paper = "📃"
    case scissors = "✂️"
}

struct ContentView: View {

    @State private var computerChoice = Move.allCases.randomElement()!
    @State private var playerChoice: Move?
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 0
    @State private var showGameOver = false

    let winnermoves: [Move:Move] = [.rock : .paper, .paper : .scissors, .scissors : .rock]

    var body: some View {
        VStack {
           Text("Score: \(score)")
                .font(.largeTitle).bold()

            Text(computerChoice.rawValue)
                .font(.system(size: 100))

            Text(shouldWin ? "WIN!" : "LOOSE")
                .font(.largeTitle).bold()

            HStack {
                Button {
                    playerChoice = .rock
                    evaluate()
                } label: {
                    Text(Move.rock.rawValue)
                        .rpsButtonStyle()
                }

                Button {
                    playerChoice = .paper
                    evaluate()
                } label: {
                    Text(Move.paper.rawValue)
                        .rpsButtonStyle()
                }

                Button {
                    playerChoice = .scissors
                    evaluate()
                } label: {
                    Text(Move.scissors.rawValue)
                        .rpsButtonStyle()
                }

            }
        }
        .padding()
        .alert(isPresented: $showGameOver) {
            Alert(title: Text("Game Over"), message: Text("You scored \(score) points."), dismissButton: .default(Text("New Game"), action: newGame))
        }
    }

    func evaluate() {
        if playerChoice == winnermoves[computerChoice] && shouldWin {
            score += 1
        } else if playerChoice != winnermoves[computerChoice] && !shouldWin {
            score += 1
        } else {
            score -= 1
        }

        if round < 10 {
            newRound()
        } else {
            showGameOver = true
            newGame()
        }
    }

    func newRound() {
        computerChoice = Move.allCases.randomElement()!
        playerChoice = nil
        shouldWin.toggle()
        round+=1
    }

    func newGame() {
        round = 0
        score = 0
        newRound()
    }
}



struct RPSButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 80))
            .background(Color.yellow)
            .clipShape(Circle())
    }
}

extension View {
    func rpsButtonStyle() -> some View {
        modifier(RPSButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
