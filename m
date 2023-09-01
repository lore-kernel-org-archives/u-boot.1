Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5095BCA0FF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC9F8678A;
	Fri,  1 Sep 2023 22:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2tnZ/fm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D068675B; Fri,  1 Sep 2023 22:04:15 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55CC866CF
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so24145465e9.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598652; x=1694203452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLt/k2jfppd558tZuRkQGTwbhBX5TEWbxVq56iIr2Oo=;
 b=i2tnZ/fmTHAMl7g2wcJ9j2SQHJpQfp2cCWQWOD480+Pzl9BY7wHTLFLmCQuVh5dNK9
 Oz5+mbMaD9M01rCAhMR+6MIyJH/SiHn4X7aE0k0y4Yzw+nGIv9K53NA2BFmchZ9jmLZ/
 df/sYTSp7Flf5krrv0/Q3/s0xkZ4dyAuoB98sR8SxxasXISf2ZDzp33RL0P274BpdjjO
 N21cZERvZI3LssgCTKFrE9en8/oDHlJ5nf5L6lfANaPPD99rnFmM5+lAJgJ05APKEskH
 I5BE3lw2n2oi/iKz7mznnA4pxOXL0Z7ELZg37SQ1mh5J0c4pW9yp23Lvz9ejpXKwSyOB
 PyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598652; x=1694203452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLt/k2jfppd558tZuRkQGTwbhBX5TEWbxVq56iIr2Oo=;
 b=U4Z8SHpiKempCXDUk+vDVfSJqZKO5o27TxHgBN4qjHp9Bb2OLtB+ISqI489dZyGa50
 yKv/GTMWMk1P9FD1rgcERmQTgprWVgSLOluxiTjJ/+HqSQ9HOPyV6VGTfSURe318Xpa8
 GT448g1OiyBT+p/1SwGw0lENxHZYnwt2EGezr5QJcrUH6QI3Gu+Knet3FrObRy96eD/S
 l9YAT2ZT05H3oq6hhTuFNaYq7Y+gIVCKLJWGT4V97kzttpsA6hCMnSL1QusKP5bpzCY2
 IcKiiHbtXtHWiAm5qJBduV+NhFDbCu5Xx8bW9HWjrU1lYxmp1/ivZmY/v7/oSlS+Hfuu
 i6ZA==
X-Gm-Message-State: AOJu0Yw+iPjBfh7MYXiK404+8qyn+nbbwRO1x+P6qux8gDL3Mxs2+UDE
 T/42d9HW0ofHXfD0uQynEeE0mjzUysh4bRRX
X-Google-Smtp-Source: AGHT+IGyGQhf713wckKuctaKOXoQexRbA+3WjluTqaXMEZPHxUk9aVQIutWPdGdw+chPkgYyiTEs7g==
X-Received: by 2002:adf:f144:0:b0:317:648c:3895 with SMTP id
 y4-20020adff144000000b00317648c3895mr2537045wro.33.1693598651801; 
 Fri, 01 Sep 2023 13:04:11 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:11 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 1/6] scripts: Port Linux's gen_compile_commands.py to U-Boot
Date: Fri,  1 Sep 2023 22:03:48 +0200
Message-ID: <20230901200353.90290-2-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901200353.90290-1-jmcosta944@gmail.com>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This script generates a database of compiler flags, namely
compile_commands.json. It is quite useful for text editors that use
clangd LSP (e.g. Vim, Neovim).

It was ported from Linux's sources:
- tag: v6.4
- revision 6995e2de6891c724bfeb2db33d7b87775f913ad1

Modifications for U-Boot compatibility will be added in a follow-up
commit.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 228 ++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100755 scripts/gen_compile_commands.py

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
new file mode 100755
index 0000000000..15ba56527a
--- /dev/null
+++ b/scripts/gen_compile_commands.py
@@ -0,0 +1,228 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) Google LLC, 2018
+#
+# Author: Tom Roeder <tmroeder@google.com>
+#
+"""A tool for generating compile_commands.json in the Linux kernel."""
+
+import argparse
+import json
+import logging
+import os
+import re
+import subprocess
+import sys
+
+_DEFAULT_OUTPUT = 'compile_commands.json'
+_DEFAULT_LOG_LEVEL = 'WARNING'
+
+_FILENAME_PATTERN = r'^\..*\.cmd$'
+_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
+_VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
+# The tools/ directory adopts a different build system, and produces .cmd
+# files in a different format. Do not support it.
+_EXCLUDE_DIRS = ['.git', 'Documentation', 'include', 'tools']
+
+def parse_arguments():
+    """Sets up and parses command-line arguments.
+
+    Returns:
+        log_level: A logging level to filter log output.
+        directory: The work directory where the objects were built.
+        ar: Command used for parsing .a archives.
+        output: Where to write the compile-commands JSON file.
+        paths: The list of files/directories to handle to find .cmd files.
+    """
+    usage = 'Creates a compile_commands.json database from kernel .cmd files'
+    parser = argparse.ArgumentParser(description=usage)
+
+    directory_help = ('specify the output directory used for the kernel build '
+                      '(defaults to the working directory)')
+    parser.add_argument('-d', '--directory', type=str, default='.',
+                        help=directory_help)
+
+    output_help = ('path to the output command database (defaults to ' +
+                   _DEFAULT_OUTPUT + ')')
+    parser.add_argument('-o', '--output', type=str, default=_DEFAULT_OUTPUT,
+                        help=output_help)
+
+    log_level_help = ('the level of log messages to produce (defaults to ' +
+                      _DEFAULT_LOG_LEVEL + ')')
+    parser.add_argument('--log_level', choices=_VALID_LOG_LEVELS,
+                        default=_DEFAULT_LOG_LEVEL, help=log_level_help)
+
+    ar_help = 'command used for parsing .a archives'
+    parser.add_argument('-a', '--ar', type=str, default='llvm-ar', help=ar_help)
+
+    paths_help = ('directories to search or files to parse '
+                  '(files should be *.o, *.a, or modules.order). '
+                  'If nothing is specified, the current directory is searched')
+    parser.add_argument('paths', type=str, nargs='*', help=paths_help)
+
+    args = parser.parse_args()
+
+    return (args.log_level,
+            os.path.abspath(args.directory),
+            args.output,
+            args.ar,
+            args.paths if len(args.paths) > 0 else [args.directory])
+
+
+def cmdfiles_in_dir(directory):
+    """Generate the iterator of .cmd files found under the directory.
+
+    Walk under the given directory, and yield every .cmd file found.
+
+    Args:
+        directory: The directory to search for .cmd files.
+
+    Yields:
+        The path to a .cmd file.
+    """
+
+    filename_matcher = re.compile(_FILENAME_PATTERN)
+    exclude_dirs = [ os.path.join(directory, d) for d in _EXCLUDE_DIRS ]
+
+    for dirpath, dirnames, filenames in os.walk(directory, topdown=True):
+        # Prune unwanted directories.
+        if dirpath in exclude_dirs:
+            dirnames[:] = []
+            continue
+
+        for filename in filenames:
+            if filename_matcher.match(filename):
+                yield os.path.join(dirpath, filename)
+
+
+def to_cmdfile(path):
+    """Return the path of .cmd file used for the given build artifact
+
+    Args:
+        Path: file path
+
+    Returns:
+        The path to .cmd file
+    """
+    dir, base = os.path.split(path)
+    return os.path.join(dir, '.' + base + '.cmd')
+
+
+def cmdfiles_for_a(archive, ar):
+    """Generate the iterator of .cmd files associated with the archive.
+
+    Parse the given archive, and yield every .cmd file used to build it.
+
+    Args:
+        archive: The archive to parse
+
+    Yields:
+        The path to every .cmd file found
+    """
+    for obj in subprocess.check_output([ar, '-t', archive]).decode().split():
+        yield to_cmdfile(obj)
+
+
+def cmdfiles_for_modorder(modorder):
+    """Generate the iterator of .cmd files associated with the modules.order.
+
+    Parse the given modules.order, and yield every .cmd file used to build the
+    contained modules.
+
+    Args:
+        modorder: The modules.order file to parse
+
+    Yields:
+        The path to every .cmd file found
+    """
+    with open(modorder) as f:
+        for line in f:
+            obj = line.rstrip()
+            base, ext = os.path.splitext(obj)
+            if ext != '.o':
+                sys.exit('{}: module path must end with .o'.format(obj))
+            mod = base + '.mod'
+            # Read from *.mod, to get a list of objects that compose the module.
+            with open(mod) as m:
+                for mod_line in m:
+                    yield to_cmdfile(mod_line.rstrip())
+
+
+def process_line(root_directory, command_prefix, file_path):
+    """Extracts information from a .cmd line and creates an entry from it.
+
+    Args:
+        root_directory: The directory that was searched for .cmd files. Usually
+            used directly in the "directory" entry in compile_commands.json.
+        command_prefix: The extracted command line, up to the last element.
+        file_path: The .c file from the end of the extracted command.
+            Usually relative to root_directory, but sometimes absolute.
+
+    Returns:
+        An entry to append to compile_commands.
+
+    Raises:
+        ValueError: Could not find the extracted file based on file_path and
+            root_directory or file_directory.
+    """
+    # The .cmd files are intended to be included directly by Make, so they
+    # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
+    # kernel version). The compile_commands.json file is not interepreted
+    # by Make, so this code replaces the escaped version with '#'.
+    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+
+    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
+    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
+    if not os.path.exists(abs_path):
+        raise ValueError('File %s not found' % abs_path)
+    return {
+        'directory': root_directory,
+        'file': abs_path,
+        'command': prefix + file_path,
+    }
+
+
+def main():
+    """Walks through the directory and finds and parses .cmd files."""
+    log_level, directory, output, ar, paths = parse_arguments()
+
+    level = getattr(logging, log_level)
+    logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
+
+    line_matcher = re.compile(_LINE_PATTERN)
+
+    compile_commands = []
+
+    for path in paths:
+        # If 'path' is a directory, handle all .cmd files under it.
+        # Otherwise, handle .cmd files associated with the file.
+        # built-in objects are linked via vmlinux.a
+        # Modules are listed in modules.order.
+        if os.path.isdir(path):
+            cmdfiles = cmdfiles_in_dir(path)
+        elif path.endswith('.a'):
+            cmdfiles = cmdfiles_for_a(path, ar)
+        elif path.endswith('modules.order'):
+            cmdfiles = cmdfiles_for_modorder(path)
+        else:
+            sys.exit('{}: unknown file type'.format(path))
+
+        for cmdfile in cmdfiles:
+            with open(cmdfile, 'rt') as f:
+                result = line_matcher.match(f.readline())
+                if result:
+                    try:
+                        entry = process_line(directory, result.group(1),
+                                             result.group(2))
+                        compile_commands.append(entry)
+                    except ValueError as err:
+                        logging.info('Could not add line from %s: %s',
+                                     cmdfile, err)
+
+    with open(output, 'wt') as f:
+        json.dump(compile_commands, f, indent=2, sort_keys=True)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.41.0

