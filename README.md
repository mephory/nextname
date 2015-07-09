# nextname
Generates a unique filename by counting up a number if the given name already exists

# Usage

    nextname PATTERN

Prints the next available filename by counting up a number.
The first `#` in the PATTERN will be replaced by the number that is counted up. If there is no `#` in the pattern, ` (#)` is automatically inserted at the end of the PATTERN (but before any filename extension).

# Examples:

    nextname file.txt

Prints `file (1).txt`, or `file (2).txt` if the first one already exists.

    nextname file-#.txt

Prints `file-1.txt`, or `file-2.txt` if the first one already exists.

# TODO

- Make it possible to escape `#`s in the PATTERN (so that I can write `nextname "file\#\#-#"` which becomes `file##-1`).
- Add the option to have multiple `#`s next to each other in the PATTERN in order to have the generated number be preceded by zeroes.
