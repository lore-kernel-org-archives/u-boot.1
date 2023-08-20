Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470B3EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 19:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA20486E8E;
	Sun, 20 Aug 2023 21:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvT5g7sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809A386E8E; Sun, 20 Aug 2023 21:04:27 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FCF869E9
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 21:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso26362385e9.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692558264; x=1693163064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLt/k2jfppd558tZuRkQGTwbhBX5TEWbxVq56iIr2Oo=;
 b=HvT5g7sm0Pr3ZtmifY6eTFd4gWf+qur8wt867tCIGK6FazQrpVmPFcKyyZFAMFZu+6
 U+CXq93iS75XfRbCpM9APbLxkZT+7tluNjkPnMRJsc1Uh2AiupFEHdXxjCkXouQQJI65
 dC10PaUPkdNA23D/TgNnyF//XeXoflzdJKa35DoRZ86iZYcnk6IEt6AsKZxDn/Xgv8ox
 Xw3XgzXm/Xzj4lqdzzTvRcAOv+ReZBve9wAp1njceUPkPt/oH9oElMEop3BHi60nrOuT
 4B4FL2J+cR72nVgvZAnZ+RXsHtJowWxUKQLdZDlGBsdTX5HusCEQwU1Dvpaf9u6X4e7E
 YOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692558264; x=1693163064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLt/k2jfppd558tZuRkQGTwbhBX5TEWbxVq56iIr2Oo=;
 b=O23/IfOxxpLGEtL4bDU7+3xD91aAHggptQjmluaZ28wpcR2xz7sl4WnJSWSnS/aNZp
 PuxBy+avQZEq3Mm5tSV0JfjETymveAYSFuB+4/qX5c6244T9SCV1a/pqxMZIn0f4C5Ey
 tVGGCCsd1p136cixyyUzokEtUvrl4PvG9S3WkrZ84rfcqqZxWEfY6u6eBO1382EyzSUf
 1uGOOWFVsSsG6g9kRipo+h4b6YbASCARNJTZva2rB3qzycYQbk+/+lSmm99EkEoAYyJb
 3gzCa4D4DPLA6J4CbRn3Mfqp2nOMaV1SVk1WN5lo0ZbfdKpOUwgwUWOQeDLCFCR3UEtg
 +xEA==
X-Gm-Message-State: AOJu0YyIyWAPCY9yNk75xjS7dSIE4PCR1M//C66ky/htH2sKp8Xmg6x4
 XESrx3PRA85WjH53fwyjhDIYHeR4RYP0ryW4
X-Google-Smtp-Source: AGHT+IFHt4jstFGb7x+Akqg/HR/DiOe6OKdTzWCyJqx+2mke5dDq8qqIwb7sQ/BvkUB8WaPzQvrzbg==
X-Received: by 2002:a7b:c38e:0:b0:3fe:10d8:e7fa with SMTP id
 s14-20020a7bc38e000000b003fe10d8e7famr3492789wmj.41.1692558263750; 
 Sun, 20 Aug 2023 12:04:23 -0700 (PDT)
Received: from fedora.. (cust-west-pareq2-46-193-56-152.wb.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm8253797wmc.20.2023.08.20.12.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 12:04:23 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v1 1/4] scripts: Port Linux's gen_compile_commands.py to U-Boot
Date: Sun, 20 Aug 2023 21:04:09 +0200
Message-ID: <20230820190412.21266-2-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820190412.21266-1-jmcosta944@gmail.com>
References: <20230820190412.21266-1-jmcosta944@gmail.com>
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

