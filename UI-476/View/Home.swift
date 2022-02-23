//
//  Home.swift
//  UI-476
//
//  Created by nyannyan0328 on 2022/02/23.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    
    @State var widht : CGFloat = 1
    
    @State var height = UIScreen.main.bounds.height
    
    @State var cardOffset : [CGFloat] = [0,0,0,0]
    var body: some View {
        VStack{
            
            TopBar()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                let leftValue : CGFloat = (2.3 / (widht / (widht - 390)))
                
                let value : CGFloat = 2.3 + (leftValue < -5 ? 0 : leftValue)
                
                let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
                
                VStack{
                    
                    
                    Text("Wallet")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)
                        .frame(height: getScreenBounds().height / 4)
                    
                    
                    
                    Wallet(content: {
                        
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            
                            
                            
                            Text("Carry\nonething.\nEverything.")
                                .font(.system(size: 50, weight: .bold))
                                .padding(.leading,15)

                            Text("The Wallet app lives right on your iPhone. It’s where you securely keep your credit and debit cards, driver’s license or state ID, transit cards, event tickets, keys, and more — all in one place. And it all works with iPhone or Apple Watch, so you can take less with you but always bring more.")
                                .font(.title.weight(.semibold))
                                .frame(height:400,alignment: .top)
                                .padding(15)
                            
                            
                            SampleCard(color: Color("Blue"))
                            SampleCard(color: Color("Yellow"),index: 1)
                            SampleCard(color: Color("Green"),index: 2)
                            SampleCard(color: Color("Orange"),index: 3)
                            
                            
                        }
                        
                        
                        
                    })
                       // .offset(y:offset < 0 ? -offset : 0)
                    
                }
                .frame(maxWidth:.infinity)
                .mask({
                    
                    Rectangle()
                        .padding(.horizontal,-offset > (maxHeight + (widht < 390 ? 8 : 4)) ? 15 : 0)
                    
                })
                .modifier(OffsetModifier(cooordinateSpace: "SCROLL", rect: { rect in
                    
                    
                    
                    self.offset = (rect.minY < 0 ? rect.minY : 0)
                    
                    if widht == 1{
                        
                        self.widht = rect.width
                        
                    }
                    
                    
                    
                    
                }))
                .padding(.bottom,getScreenBounds().height * 2)
                
                
            }
            .coordinateSpace(name: "SCROLL")
            
            
            
            
        }
        .background(Color("BG"))
    }
    @ViewBuilder
    func Wallet<Content : View>(@ViewBuilder content : @escaping()->Content)->some View{
        
      
        
        let leftValue : CGFloat = (2.3 / (widht / (widht - 390)))
        
        let value : CGFloat = 2.3 + (leftValue < -5 ? 0 : leftValue)
        
           
        let scale : CGFloat = -(offset / 200) < value ? (offset / 200) : -(value + (widht > 390 ? 0.1 : 0.001))
        
        let scaleOffset : CGFloat = (offset + (200 * value))
        
        let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
        
        
        let exhastHeight : CGFloat = -(200 * value)
        
        GeometryReader{proxy in
            
            ZStack{
                
                
                RoundedRectangle(cornerRadius: 35)
                    .offset(y: -scale > value ? -scaleOffset / 6 : 0)
                
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("BG"))
                    .padding(.horizontal,25)
                    .padding(.vertical,25)
                    .offset(y: -scale > value ? -scaleOffset / 10 : 0)
                
                
                
                ZStack{
                    
                    WalletCardView(color: Color("Blue"), VPadding: 45, HPadding: 35)
                    WalletCardView(color: Color("Green"), VPadding: 55, HPadding: 35,index: 1)
                    WalletCardView(color: Color("Yellow"), VPadding: 65, HPadding: 35,index: 2)
                    WalletCardView(color: Color("Orange"), VPadding: 75, HPadding: 35,index: 3)
                    
                    
                    Rectangle()
                        .fill(Color("BG"))
                        .padding(.vertical,65)
                        .padding(.horizontal,30)
                       .offset(y:25)
                    
                    
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(Color("Orange"))
                        .frame(width: 40, height: 40)
                        .offset(y: -0.5)
                }
                
                
                
                    
            }
            .onAppear(perform: {
                
                
                self.height -= proxy.frame(in: .global).minY
            })
           
            
        }
        .frame(width: 190, height: 180)
        .scaleEffect(1 - scale)
        .offset(y: -offset)
        .offset(y: -offset < maxHeight ? (-scale > value ? -scaleOffset : 0) : maxHeight + exhastHeight)
        .zIndex(100)
      
      content()
            .padding(.top,maxHeight)
        
       
        
        
    }
    
    
    @ViewBuilder
    func SampleCard(color : Color,index : Int = 0)->some View{
        
        
        GeometryReader{proxy in
            
            Text("Travel\nYoure Even more\nMobile Device")
                .font(.system(size: 40, weight: .bold))
                .padding(.top,50)
                .padding(.bottom,20)
                .padding(.horizontal,15)
                .frame(maxWidth:.infinity,alignment: .leading)
                .modifier(OffsetModifier(cooordinateSpace: "SCROLL", rect: { rect in
                    
                    
                    cardOffset[index] = rect.minY
                }))
            
            
        }
        .frame(height: 260, alignment: .top)
        .background(color,in: RoundedRectangle(cornerRadius: 35))
        .padding(.horizontal,15)
        
    }
    
    @ViewBuilder
    func WalletCardView(color : Color,VPadding : CGFloat,HPadding : CGFloat,index : Int = 0) -> some View{
        
        
        GeometryReader{proxy in
            
            
            let minY = proxy.frame(in: .named("SCROLL")).minY - 20
            
            let paddleWidth = proxy.frame(in: .named("SCROLL")).width
            
            
            let scale = paddleWidth / widht
            
            let leftValue : CGFloat = (2.3 / (widht / (widht - 390)))
            
            let value : CGFloat = 2.3 + (leftValue < -5 ? 0 : leftValue)
            
            let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
            
            
            
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
             
                .opacity(cardOffset[index] < minY ? 0  : 1)
                .scaleEffect(-offset > maxHeight ? scale : 1)
        
            
        }
        .padding(.horizontal,HPadding)
        .padding(.vertical,VPadding)
        
            
            
          
        
        
        
    }
    @ViewBuilder
    func TopBar()->some View{
        
        
        HStack{
            
            Button {
                
            } label: {
                
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .bold))
                    
            }
            
            Spacer()
            
            Button {
                
            } label: {
                
                Image(systemName: "bag.fill")
                    .font(.system(size: 20, weight: .bold))
                    
            }
            

            
        }
        .padding()
        .overlay(Image(systemName: "applelogo").font(.title))
        .foregroundColor(.white)
        .background(Color("TopBar"))
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
extension View{
    
    func getScreenBounds()->CGRect{
        
        return UIScreen.main.bounds
    }
}
