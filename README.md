# Auto_Update.ahk AHKv2_Self-Updating-Application-Lib
AHKv2 Self Updating Application Library
This library is off the back of my github.ahk update, and dive into ahkv2.
credit to Json Native.ahk creator viewtopic.php?t=100602

repo: https://github.com/samfisherirl/Auto-Update.ahk-AHKv2_Self-Updating-Application-Lib

This solution does the following:
- Takes configuration for an app ( public releases) that needs remote updates, ill use "github.ahk" as an example.
- Connect to Github's API, returns release Tag (version), release download url, and release updates
- stores version data in a local json log file
- Everytime the function calls are made in the example, the json file is imported and github API redownloads the latest version data
- If version doesn't match local version, a download prompt is offered (customizable)
- if Zip, Rar, 7z file, 7zip command line utility invokes extraction of the release and overwrites the existing application path set by the user
- if Exe, a simple move file operation happens
- Version data is stored for future use

keep in mind this works but may have an error or two upon various use cases and if reported, I will fix asap.

Try, Catch need to be implemented as a code feature (I dont self-referentially update for you so make sure to check the github for updates ;)
!Important for now, releases must be in the zip's main directory. I dont have a function to handle zips with the main app in a folder.

```autohotkey
myApp := defineApp("samfisherirl", "Github.ahk")
; this example refers to my repo http://github.com/samfisherirl/github.ahk

path_of_app := A_ScriptDir "\github.ahk"
; set where my application is stored on the local computer

myApp.setPath(path_of_app)

myApp.connectGithubAPI()

update := myApp.checkforUpdate()

if (update) {
    ;update stores all json data, you can see some details below. Look at "defineApp" class for more details
    msg := update["repo"] . " version number " . update["version"] . " needs an update. Release notes include:`n" . update["releaseNotes"]
    Msgbox(msg)

    myApp.update()
    ;gets file from repo, if zip/7zip, extract
    ;then overwrite existing app
    ;updates log
}
else {
    msgbox("You're up to date!")
}
```

full code does not include native.ahk and github.ahk, both needed. find the full code here:

 
