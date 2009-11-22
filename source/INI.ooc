import iniparser, dictionary
import io/File

fclose: extern func(FILE*)
INI: class {

    fileName: String
    dict: DictPtr
    section = null: String

    init: func(=fileName) {
        dict = iniparser_load(fileName)
    }

    dumpINI: func ~explicitFile(file: String) {
        fptr := fopen(file, "w")
        iniparser_dump_ini(dict, fptr)
        fclose(fptr)
    }
    
    dumpINI: func() {
        fptr := fopen(fileName, "w")
        iniparser_dump_ini(dict, fptr)
        fclose(fptr)
    }

    dump: func ~explicitFile(fptr: FILE*) {
        iniparser_dump(dict, fptr)
    }

    dump: func() {
        fptr := fopen(fileName, "w")
        iniparser_dump(dict, fptr)
        fclose(fptr)
    }

    setCurrentSection: func(=section) {}

    getEntry: func<T> (key: String, def: T) -> T {
        entry: String
        result: T // Without extra var ooc uses char* to the match
        match section {
            case null => entry = key; "ERROR: No section chosen" println() // TODO: add `verbose` mode
            case      => entry = section + ":" + key
        }
        match T { 
            case String => result = iniparser_getstring(dict, entry, def)
            case Bool   => result = iniparser_getboolean(dict, entry, def)
            case Int    => result = iniparser_getint(dict, entry, def)
            case Double => result = iniparser_getdouble(dict, entry, def)
        } 
        return result
    }

    setEntry: func<T> (key: String, val:T) -> Int {
        entry: String
        tmp := val
        match section {
            case null => entry = key
            case      => entry = section + ":" + key
            
        }
        iniparser_setstring(dict, entry, tmp class toString())
    }
        
            
}


 


