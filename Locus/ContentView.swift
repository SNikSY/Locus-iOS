import SwiftUI

// Модель данных для постов
struct Post: Identifiable {
    let id = UUID()
    let author: String
    let timeAgo: String
    let title: String
    let content: String
    let imageName: String? // Новое свойство для имени изображения
}

struct ContentView: View {
    @State private var isPresentingProfile = false
    @State private var isPresentingCreatePost = false
    @State private var posts: [Post] = [
        Post(author: "Денис Мартынов", timeAgo: "3ч", title: "В Люблино все еще проблемы с транспортной инфраструктурой. Что можно предпринять?", content: "В Люблино остро стоит проблема с пробками. Узкие улицы, постоянные заторы и вечная нехватка парковочных мест.", imageName: "busImage"),
        Post(author: "Амир Банкер", timeAgo: "4ч", title: "Как современная архитектура меняет облик современной Москвы", content: "Москва активно меняется, и эти изменения особенно заметны в ее архитектурном облике. Старин против небоскребов.", imageName: "cityScape")
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                                        
                                        Spacer()
                                        
                                        Text("МОЙ ГОРОД")
                                            .font(.system(size: 16, weight: .medium))
                                        
                                        Spacer()
                                        
            
                                    }
                                    .padding(.top, 16)
                    // Лента публикаций
                    ScrollView {
                        ForEach(posts) { post in
                            VStack(alignment: .leading) {
                                HStack {
                                    Image("denis")
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                        
                                        
                                    VStack(alignment: .leading) {
                                        Text(post.author)
                                            .font(.system(size: 16, weight: .semibold))
                                        Text(post.timeAgo)
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                
                                Text(post.title)
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.vertical, 4)
                                
                                Text(post.content)
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                                
                                // Добавление изображения, если оно задано
                                if let imageName = post.imageName {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                        .clipped()
                                }
                                
                                HStack {
                                    Image(systemName: "heart")
                                    Text("884")
                                    Spacer()
                                    Image(systemName: "text.bubble")
                                    Text("234")
                                    Spacer()
                                    Image(systemName: "arrowshape.turn.up.right")
                                    Text("32")
                                    Spacer()
                                    Text("1тыс")
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 4)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                    
                    // Bottom navigation bar
                    HStack {
                        Spacer()
                        Button(action: {
                        }){
                            Image("house")
                                .font(.system(size: 24))
                        }
                        Spacer()
                        Button(action: {
                        }){
                            Image("bubble")
                                .font(.system(size: 24))
                        }
                        Spacer()
                        Button(action: {
                            isPresentingCreatePost.toggle()
                        }) {
                            Image("staroflife")
                                .font(.system(size: 24))
                        }
                        .sheet(isPresented: $isPresentingCreatePost) {
                            CreatePostView(posts: $posts)
                        }
                        Spacer()
                        Button(action: {
                            isPresentingProfile.toggle()
                        }) {
                            Image("person")
                                .font(.system(size: 24))
                        }
                        .sheet(isPresented: $isPresentingProfile) {
                            ProfileView()
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.black))
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Интерфейс CreatePostView для создания поста
struct CreatePostView: View {
    @Binding var posts: [Post]
    @State private var title: String = ""
    @State private var content: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    publishPost()
                }) {
                    Text("Опубликовать пост")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            HStack {
                Image("denis")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Действие для выбора тегов
                }) {
                    Text("Выбрать теги ⌄")
                        .font(.system(size: 14))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {
                    // Действие для указания города
                }) {
                    Text("Указать город")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            
            TextField("Заголовок", text: $title)
                .font(.system(size: 22, weight: .bold))
                .padding(.horizontal)
            
            TextEditor(text: $content)
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .padding(.horizontal)
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    // Действие для прикрепления файла
                }) {
                    Image(systemName: "paperclip")
                        .font(.system(size: 24))
                        .foregroundColor(.green)
                }
                .padding()
            }
        }
        .background(Color(UIColor.systemGray6))
        .ignoresSafeArea()
    }
    
    private func publishPost() {
        let newPost = Post(author: "Денис Мартынов", timeAgo: "Только что", title: title, content: content, imageName: "busImage")
        posts.insert(newPost, at: 0)
        presentationMode.wrappedValue.dismiss()
    }
}

// Интерфейс ProfileView для профиля пользователя
struct ProfileView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Мартиновс Денис")
                            .font(.system(size: 22, weight: .bold))
                        
                        Text("deniss.mart")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image("denis2")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                        .overlay(
                            Image(systemName: "plus.circle.fill")
                                .offset(x: 15, y: 15)
                                .foregroundColor(.green)
                        )
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    HStack {
                        Image(systemName: "person.2")
                        Text("123 подписчика")
                            .font(.system(size: 14))
                    }
                    
                    HStack {
                        Image(systemName: "doc.text")
                        Text("42 публикации")
                            .font(.system(size: 14))
                    }
                }
                .foregroundColor(.gray)
                .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ваш рейтинг")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.orange)
                        
                        HStack {
                            Text("Звезда 82/100")
                                .font(.system(size: 14))
                            Spacer()
                            ProgressView(value: 0.82)
                                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                                .frame(width: 100)
                        }
                    }
                    .padding(8)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text("Персонализация профиля")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        ProgressView(value: 0.5)
                            .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                            .frame(width: 100)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding(.top)
            
            HStack {
                Text("Публикации")
                    .font(.system(size: 16, weight: .bold))
                
                Spacer()
                
                Text("Ответы")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Репосты")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(UIColor.systemGray5))
            
            ScrollView {
                                // First article
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image("denis")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Денис Мартынов")
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("Урбанистика Статья 3ч")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    Text("В Люблино все еще проблемы с транспортной инфраструктурой. Что можно предпринять?")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.vertical, 4)
                                    
                                    Text("В Люблино остро стоит проблема с пробками. Узкие улицы, постоянные заторы и вечная нехватка парковочных мест.")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 8)
                                    
                                    Image("busImage") // Add your image here
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                        .clipped()
                                    
                                    HStack {
                                        Image(systemName: "text.bubble")
                                        Text("34")
                                        Spacer()
                                        Text("1тыс")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.top, 4)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white) // Фон карточки статьи
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .padding(.horizontal)
                                
                                Divider()
                                
                                // Second article
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image("denis")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Денис Мартынов")
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("Архитектура Статья 4ч")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    Text("Как современная архитектура меняет облик современной Москвы")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.vertical, 4)
                                    
                                    Text("Москва активно меняется, и эти изменения особенно заметны в ее архитектурном облике. Старин против небоскребов.")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 8)
                                    
                                    Image("cityScape") // Add your image here
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                        .clipped()
                                    
                                    HStack {
                                        Image(systemName: "text.bubble")
                                        Text("34")
                                        Spacer()
                                        Text("1тыс")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.top, 4)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white) // Фон карточки статьи
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .padding(.horizontal)
                                
                            }
            
            Spacer()
        }
        .background(Color(UIColor.systemGray6))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
