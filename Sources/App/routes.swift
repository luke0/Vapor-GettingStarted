import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("hello", "vapor") { req in
        return "Hello Vapor"
    }
    
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name") ?? ""
        return "Hello \(name)"
    }
    
    app.post("info") { req -> InfoResponse in
        let data = try req.content.decode(InfoData.self)
        return InfoResponse(response: data)
    }
    
    app.get("date") { req -> String in
        let currentDate: Date = Date(timeIntervalSinceNow: 0)
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: currentDate)
    }
    
    app.get("counter", ":count") { req -> Counter in
        let count = req.parameters.get("count") ?? 0
        return Counter(count: count)
    }
    
    app.post("user-info") { req -> String  in
        let userInfo = try req.content.decode(InfoData.self)
        return "Hello my name is \(userInfo.name) and my age is \(userInfo.age)"
    }
}

struct InfoData: Content {
    let name: String
    let age: Int
}

struct InfoResponse: Content {
    let response: InfoData
}

struct Counter: Content {
    let count: Int
}
