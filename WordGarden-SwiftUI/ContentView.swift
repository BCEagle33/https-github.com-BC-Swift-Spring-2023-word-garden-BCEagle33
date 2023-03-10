//
//  ContentView.swift
//  WordGarden-SwiftUI
//
//  Created by Tyler on 2/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var gameStatusMessage = "How many Guesses to Uncover the Hidden Word?"
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
    
    private let wordsToGuess = ["AT", "DOG", "CAT"]
    
    var body: some View {
        VStack {
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Words Guessed: \(wordsGuessed)")
                    Text("Words Missed: \(wordsMissed)")
                }
                
                Spacer()
                
                VStack (alignment: .leading) {
                    Text("Words to Guess: \(wordsToGuess.count - wordsGuessed + wordsMissed)")
                    Text("Words in Game: \(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
            
            Spacer()
            Text(gameStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Text(revealedWord)
                .font(.title)
            
            if playAgainHidden {
                HStack{
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) { _ in
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else{
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .onSubmit {
                            guard guessedLetter != "" else {
                                return
                            }
                            guessALetter()
                        }
                        .focused($textFieldIsFocused)
                        
                
                Button("Guess a Letter") {
                   guessALetter()
                }
                .buttonStyle(.bordered)
                .tint(.mint)
                .disabled(guessedLetter.isEmpty)
            }
        } else {
                
                Button("Another Word?") {
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            
            
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
            
            
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear() {
            wordToGuess = wordToGuess[currentWordIndex]
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        }
    }
    func guessALetter() {
        textFieldIsFocused = false
        lettersGuessed = lettersGuessed + guessedLetter
        revealedWord = ""
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + "\(letter)"
            } else {
                revealedWord = revealedWord + "_ "
            }
        }
        revealedWord.removeLast()
        guessedLetter = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
