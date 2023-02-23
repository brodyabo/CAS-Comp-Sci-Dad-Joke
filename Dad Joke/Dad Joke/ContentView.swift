//
//  ContentView.swift
//  Dad Joke
//
//  Created by Brody Abowitz on 12/15/22.
//

import SwiftUI

struct ContentView: View {
    @State var joke:Joke = Joke(id:"", joke:"")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(joke.joke)
            Button("Get a Dad Joke", action:{
                loadJoke()
            })
        }
        .padding()
    }
    
    
    
    func loadJoke(){
        let url = URL(string: "https://icanhazdadjoke.com/")!
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            if let data = data{
                joke = try! JSONDecoder().decode(Joke.self, from: data)
                print(joke)
            } else if let error = error{
                print("HTTP Request Failed \(error)")
            }
            
        }
        task.resume()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
