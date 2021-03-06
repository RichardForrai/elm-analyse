module Docs.Page exposing (Page(Changelog, Configuration, Features, Home, Messages, NotFound), hash, nextPage)

import Navigation exposing (Location)
import String.Extra
import UrlParser as Url exposing ((</>), Parser)


type Page
    = Home
    | Messages (Maybe String)
    | Changelog
    | Features
    | Configuration
    | NotFound


route : Parser (Page -> a) a
route =
    Url.oneOf
        [ Url.map Home Url.top
        , Url.map (String.Extra.nonEmpty >> Messages) (Url.s "messages" </> Url.string)
        , Url.map (Messages Nothing) (Url.s "messages")
        , Url.map Changelog (Url.s "changelog")
        , Url.map Features (Url.s "features")
        , Url.map Configuration (Url.s "configuration")
        ]


nextPage : Location -> Page
nextPage =
    Url.parseHash route >> Maybe.withDefault NotFound


hash : Page -> String
hash p =
    case p of
        Home ->
            "#"

        Messages Nothing ->
            "#/messages"

        Messages (Just s) ->
            "#/messages/" ++ s

        NotFound ->
            "#"

        Changelog ->
            "#/changelog"

        Features ->
            "#/features"

        Configuration ->
            "#/configuration"
