# Rust language support.
# Copyright (C) 2011-2014 Free Software Foundation, Inc.
# Copyright (C) 2014, Pierre Langlois

# This program is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Under Section 7 of GPL version 3, you are granted additional
# permissions described in the Autoconf Configure Script Exception,
# version 3.0, as published by the Free Software Foundation.
#
# You should have received a copy of the GNU General Public License
# and a copy of the Autoconf Configure Script Exception along with
# this program; see the files COPYINGv3 and COPYING.EXCEPTION
# respectively.  If not, see <http://www.gnu.org/licenses/>.

# ------------------- #
# Language selection.
# ------------------- #

# AC_LANG(Rust)
# -----------
AC_LANG_DEFINE([Rust], [rust], [RUST], [RUSTC], [],
[
ac_ext=rs
ac_compile='$RUSTC $RUSTFLAGS conftest.$ac_ext >&AS_MESSAGE_LOG_FD'
ac_link='$RUSTC $RUSTFLAGS conftest.$ac_ext >&AS_MESSAGE_LOG_FD'
ac_compiler_gnu=no
])

# AC_LANG_RUST
# ----------
AU_DEFUN([AC_LANG_RUST], AC_LANG(Rust))

# ------------------- #
# Producing programs.
# ------------------- #

# AC_LANG_PROGRAM(Rust)([PROLOGUE], [BODY])
# ---------------------------------------
m4_define([AC_LANG_PROGRAM(Rust)],
[$1
fn main() {
$2
}])

# _AC_LANG_IO_PROGRAM(Rust)
# -----------------------
# Produce source that performs I/O.
m4_define([_AC_LANG_IO_PROGRAM(Rust)],
[AC_LANG_PROGRAM([use std::path::Path;use std::old_io::fs::File;],
[match File::create(&Path::new("conftest.out")) {
    Ok(_) => {},
    Err(_) => {panic!("")}
  }
])])

# ---------------------- #
# Looking for compilers. #
# ---------------------- #

# AC_LANG_COMPILER(Rust)
# --------------------
AC_DEFUN([AC_LANG_COMPILER(Rust)],
[AC_REQUIRE([AC_PROG_RUST])])

# AC_PROG_RUST
# ----------
AN_MAKEVAR([RUSTC], [AC_PROG_RUST])
AN_PROGRAM([rustc], [AC_PROG_RUST])
AC_DEFUN([AC_PROG_RUST],
[AC_LANG_PUSH(Rust)dnl
AC_ARG_VAR([RUSTC], [Rust compiler command])dnl
AC_ARG_VAR([RUSTFLAGS], [Rust compiler flags])dnl
AC_CHECK_PROG(RUSTC, rustc, rustc, , , false)

# Provide some information about the compiler.
_AS_ECHO_LOG([checking for _AC_LANG compiler version])
set X $ac_compile
ac_compiler=$[2]
_AC_DO_LIMIT([$ac_compiler --version  >&AS_MESSAGE_LOG_FD])
_AC_COMPILER_EXEEXT
_AC_COMPILER_OBJEXT
RUSTFLAGS="-g -O "
AC_LANG_POP(Rust)dnl
])
