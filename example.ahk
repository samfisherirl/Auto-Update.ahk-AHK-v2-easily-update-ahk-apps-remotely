; this is example.ahk
#Include %A_ScriptDir%\64bit\Native.ahk
#Include %A_ScriptDir%\64bit\github.ahk
#Include %A_ScriptDir%\64bit\auto_update.ahk

;necessary files can be found here: https://github.com/samfisherirl/Auto-Update.ahk-AHK-v2-easily-update-ahk-apps-remotely

/*
This solution does the following:
- Takes settings for an app (likely for public release) that needs remote updates, ill use "github.ahk" as an example.
- Github's API returns release Tag (version), download url, and release updates
- Library connects to the github API and stores version data in a local json temp file
- Everytime the function calls are made in the example the json files is imported and github API redownloads the latest version data
- If version doesn't match local version, a download prompt is offered (customizable)
- 7zip command line utility invokes extraction of the release and overwrites the existing application path set by the user
- Version data is stored for future use

 keep in mind this works but may have an error or two upon various use cases and if reported, I will fix asap.

Try, Catch need to be implimented as a code feature (I dont self-referentially update for you so make sure to check the github  for updates ;)

*/
myApp := defineApp("samfisherirl", "Github.ahk")
; this example refers to my repo http://github.com/samfisherirl/github.ahk

path_of_app := A_MyDocuments "\github.ahk"
; set where my application is stored on the local computer

myApp.setPath(path_of_app)

myApp.connectGithubAPI()

update := myApp.checkforUpdate()

if (update = 1) {
	msgbox("this is your first time running! thanks for using " myApp.repo)
    ;update stores all json data, you can see some details below. Look at "defineApp" class for more details
	}
else if (update) {
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
