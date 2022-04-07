workspace "3D Development"
    architecture "x86"
    configurations {"Debug", "Release"}
    startproject "Game"
    platforms {"x64"}

    flags {
        "MultiProcessorCompile"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group "Dependencies"
    include "vendor/GLFW"
    include "vendor/GLAD"
group ""

project "Game"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    prebuildcommands { 
        
    }

    defines {
		"_CRT_SECURE_NO_WARNINGS",
		"GLFW_INCLUDE_NONE"
	}

    files {
        "src/**.h",
        "src/**.hpp",
        "src/**.c",
        "src/**.cxx",
        "src/**.cpp"
        --[["vendor/imgui/**.cpp"]]
    }

    includedirs {
        "vendor/entt/include",
        "vendor/glfw/include",
        "vendor/glad/include"
    }
    
    libdirs {
        --[["vendor/sfml/lib",]]
        --[["vendor/imgui/lib",]]
        "vendor/glfw/bin/" .. outputdir .. "/GLFW",
        "vendor/glad/bin/" .. outputdir .. "/Glad",
        os.findlib("opengl32")
    }

    links {
        "GLFW.lib",
        "GLAD.lib",
        "opengl32",
    }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

