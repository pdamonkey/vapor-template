//import Authentication
//import FluentSQLite
import Leaf
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(LeafProvider())
    //try services.register(FluentSQLiteProvider())
    //try services.register(AuthenticationProvider())
    
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    /// Use Leaf for rendering views
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(SessionsMiddleware.self) // Enables sessions.
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    /*
    /// Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.enableLogging(on: .sqlite)
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)
    */
    
    /*
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: UserToken.self, database: .sqlite)
    migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)
    */
}
