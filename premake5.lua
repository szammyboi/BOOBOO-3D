workspace "3D Development"
    architecture "x86"
    configurations {"Debug", "Release"}
    startproject "Game"

    flags {
        "MultiProcessorCompile"
    }

group "Dependencies"
    --[[include "vendor/Box2D"]]
group ""

project "Game"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    targetdir ("%{wks.location}/bin/%{prj.name}")
	objdir ("%{wks.location}/bin-int/%{prj.name}")

    prebuildcommands { 
        
    }

    files {
        "src/**.h",
        "src/**.hpp",
        "src/**.c",
        "src/**.cxx",
        --[["vendor/imgui/**.cpp"]]
    }

    includedirs {
        
    }
    
    libdirs {
        --[["vendor/sfml/lib",]]
        --[["vendor/imgui/lib",]]
        os.findlib("opengl32")
    }

    links {
        "opengl32",
    }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

