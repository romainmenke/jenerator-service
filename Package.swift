import PackageDescription
let package = Package(
    name: "JeneratorService",
    dependencies: [
        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-simple-http-client-swift.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/czechboy0/Jay.git", majorVersion: 0)
    ]
)
