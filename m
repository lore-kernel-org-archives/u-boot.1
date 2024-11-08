Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F172ED5C0EE
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6118922D;
	Fri,  8 Nov 2024 16:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FuEobVuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F7A8904E; Fri,  8 Nov 2024 16:24:03 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 565F288B1F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83aad8586d3so87896339f.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079439; x=1731684239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEeNJbZDGa87fyaIERpCmjw7s+dAzEmcBw2rxxmhDIg=;
 b=FuEobVuXyhwUSaewlhIhOiGwUoza8SwYgf+LdxLFecOhfTlN0DTWnVVMIxdHdlt3Fn
 j9LyStzKNqpRJqxQyPigzaHxlzu29tZk8LYk6xAhPgudG7OOPwjQBANU2oOLZ1ZkkjhC
 g1cWnESGn7qosuxIZP6PPmyeswP0a6e48wVFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079439; x=1731684239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEeNJbZDGa87fyaIERpCmjw7s+dAzEmcBw2rxxmhDIg=;
 b=KGuTK/JvSeg7tiHdVhzSqkG+/tnEhw9PSKn5MjqcsHg1dtYQIZs+XWzuUJKGjbtNTd
 e0BG1uSsd+OD1xPxJdoaRO25/k2JGIwTtM5XskNiRfNeQbfegK5USlTT4HmWqLX0vQzM
 i89GZdfrNmjkOkMUZDK2MHMA5wHB5yQCCcctEqmvrgoN+NNsMp5cnTYRvwWMVyMe93X8
 EA4zSkAQG2Xx7jaO67GQDnA7IaiMRuT2Xt/F6qyk6GHX4dIq0RNt6xRxhPpQO9HXG+Nx
 hXz+Ld1B9pr1b9hh7vrCen+bVL4k1Sqla1YuZD0vmRP36dNndh8tRTgVQRj6ZC4cZnGy
 PcCQ==
X-Gm-Message-State: AOJu0YxoWIizYSp+2iByGf0iTIi2PBIaZbyneJAfQhQtzZ4a1IVw9P46
 xCGEGkTDkP88W1cvzlfBCAAsYD9FGNoVcGS7wV3gNXSZSmzxW0n2+FIYV9LV/ChYNMfWG/myXng
 =
X-Google-Smtp-Source: AGHT+IGh51ZmvtXFpJ03DisOJW1m2tBNN+B45pdVUtxvWGbUHdpl6rYGQ/DYumdJ5ZGYtzyMxufQBw==
X-Received: by 2002:a05:6602:6402:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83e032b3656mr366974239f.5.1731079439183; 
 Fri, 08 Nov 2024 07:23:59 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:23:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 3/9] buildman: Support #include files in defconfigs
Date: Fri,  8 Nov 2024 08:23:44 -0700
Message-Id: <20241108152350.3686274-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

This is used by some boards in U-Boot and is a convenient way to deal
with common settings where using a Kconfig files is not desirable.

Detect #include files and process them as if they were part of the
original file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/30
---

 tools/buildman/boards.py    | 25 ++++++++++++++++++++++++-
 tools/buildman/buildman.rst | 24 ++++++++++++++++++++++++
 tools/buildman/func_test.py | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 3c2822715f3..9e7b486656b 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -19,7 +19,10 @@ import time
 from buildman import board
 from buildman import kconfiglib
 
+from u_boot_pylib import command
 from u_boot_pylib.terminal import print_clear, tprint
+from u_boot_pylib import tools
+from u_boot_pylib import tout
 
 ### constant variables ###
 OUTPUT_FILE = 'boards.cfg'
@@ -202,6 +205,7 @@ class KconfigScanner:
         os.environ['KCONFIG_OBJDIR'] = ''
         self._tmpfile = None
         self._conf = kconfiglib.Kconfig(warn=False)
+        self._srctree = srctree
 
     def __del__(self):
         """Delete a leftover temporary file before exit.
@@ -239,7 +243,26 @@ class KconfigScanner:
         expect_target, match, rear = leaf.partition('_defconfig')
         assert match and not rear, f'{leaf} : invalid defconfig'
 
-        self._conf.load_config(defconfig)
+        temp = None
+        if b'#include' in tools.read_file(defconfig):
+            cmd = [
+                os.getenv('CPP', 'cpp'),
+                '-nostdinc', '-P',
+                '-I', self._srctree,
+                '-undef',
+                '-x', 'assembler-with-cpp',
+                defconfig]
+            result = command.run_pipe([cmd], capture=True, capture_stderr=True)
+            temp = tempfile.NamedTemporaryFile(prefix='buildman-')
+            tools.write_file(temp.name, result.stdout, False)
+            fname = temp.name
+            tout.info(f'Processing #include to produce {defconfig}')
+        else:
+            fname = defconfig
+
+        self._conf.load_config(fname)
+        if temp:
+            del temp
         self._tmpfile = None
 
         params = {}
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index e873611e596..8acf236f2b3 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1112,6 +1112,30 @@ The -U option uses the u-boot.env files which are produced by a build.
 Internally, buildman writes out an out-env file into the build directory for
 later comparison.
 
+defconfig fragments
+-------------------
+
+Buildman provides some initial support for configuration fragments. It can scan
+these when present in defconfig files and handle the resuiting Kconfig
+correctly. Thus it is possible to build a board which has a ``#include`` in the
+defconfig file.
+
+For now, Buildman simply includes the files to produce a single output file,
+using the C preprocessor. It does not call the ``merge_config.sh`` script. The
+redefined/redundant logic in that script could fairly easily be repeated in
+Buildman, to detect potential problems. For now it is not clear that this is
+useful.
+
+To specify the C preprocessor to use, set the ``CPP`` environment variable. The
+default is ``cpp``.
+
+Note that Buildman does not support adding fragments to existing boards, e.g.
+like::
+
+    make qemu_riscv64_defconfig acpi.config
+
+This is partly because there is no way for Buildman to know which fragments are
+valid on which boards.
 
 Building with clang
 -------------------
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index db3c9d63ec4..4e12c671a3d 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -2,8 +2,10 @@
 # Copyright (c) 2014 Google, Inc
 #
 
+import io
 import os
 from pathlib import Path
+import re
 import shutil
 import sys
 import tempfile
@@ -373,6 +375,22 @@ class TestFunctional(unittest.TestCase):
     def _HandleCommandSize(self, args):
         return command.CommandResult(return_code=0)
 
+    def _HandleCommandCpp(self, args):
+        # args ['-nostdinc', '-P', '-I', '/tmp/tmp7f17xk_o/src', '-undef',
+        # '-x', 'assembler-with-cpp', fname]
+        fname = args[7]
+        buf = io.StringIO()
+        for line in tools.read_file(fname, False).splitlines():
+            if line.startswith('#include'):
+                # Example: #include <configs/renesas_rcar2.config>
+                m_incfname = re.match('#include <(.*)>', line)
+                data = tools.read_file(m_incfname.group(1), False)
+                for line in data.splitlines():
+                    print(line, file=buf)
+            else:
+                print(line, file=buf)
+        return command.CommandResult(stdout=buf.getvalue(), return_code=0)
+
     def _HandleCommand(self, **kwargs):
         """Handle a command execution.
 
@@ -406,6 +424,8 @@ class TestFunctional(unittest.TestCase):
             return self._HandleCommandObjcopy(args)
         elif cmd.endswith( 'size'):
             return self._HandleCommandSize(args)
+        elif cmd.endswith( 'cpp'):
+            return self._HandleCommandCpp(args)
 
         if not result:
             # Not handled, so abort
@@ -1118,3 +1138,17 @@ CONFIG_SOC="fred"
             'config': '-',
             'target': 'board0'},
             ['WARNING: board0_defconfig: No TARGET_BOARD0 enabled']), res)
+
+        # check handling of #include files; see _HandleCommandCpp()
+        inc = os.path.join(src, 'common')
+        tools.write_file(inc, b'CONFIG_TARGET_BOARD0=y\n')
+        tools.write_file(norm, f'#include <{inc}>', False)
+        res = scanner.scan(norm, True)
+        self.assertEqual(({
+            'arch': 'arm',
+            'cpu': 'armv7',
+            'soc': '-',
+            'vendor': 'Tester',
+            'board': 'ARM Board 0',
+            'config': 'config0',
+            'target': 'board0'}, []), res)
-- 
2.34.1

