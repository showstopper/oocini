use oocini
import oocini/INI

main: func {

    file := "twisted.ini"
    a := INI new(file)
    a setCurrentSection("quotes")
    b := a getEntry("h1", "blub")
    b println()

}
