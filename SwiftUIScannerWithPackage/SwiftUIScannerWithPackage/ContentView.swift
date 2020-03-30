//
//  ContentView.swift
//  SwiftUIScannerWithPackage
//
//  Created by Rafael Adolfo on 30/03/20.
//  Copyright © 2020 Rafael Adolfo. All rights reserved.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @State var scannedCode = ""
    @State var scannerIsActive = false
    
    //Função que interpreta o resultado do package
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.scannerIsActive = false
        switch result {
        case .success(let code):
            self.scannedCode = "Resultado:" + code
        case .failure( _):
            print("Scanning failed")
        }
    }
    
    var body: some View {
        VStack {
            //Variável que recebe o código escaneado
            Text(scannedCode)
                .fontWeight(Font.Weight.semibold)
                .lineLimit(nil)
            
            //Botão para iniciar escanemento
            Button(action: {
                self.scannerIsActive = true
            }) {
                   HStack {
                       Image(systemName: "faceid")
                       Text("Escanear")
                   }
                .padding(.all, 12)
                .foregroundColor(.white)
                .background(Color.blue)
            }
            .sheet(isPresented: $scannerIsActive) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "It's alive!", completion: self.handleScan)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
