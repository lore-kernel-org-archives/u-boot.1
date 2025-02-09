Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0802C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D59680821;
	Sun,  9 Feb 2025 22:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PoxwczVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA740809A4; Sun,  9 Feb 2025 22:27:27 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0026803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce85545983so11629235ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739136442; x=1739741242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hjux5RVVOlScxDkR7POf7SbE/e/7qKzCk0ch9TiazMA=;
 b=PoxwczVaJL+pzpLqKp4wV+Phe9NPolqHzXl3c0N+NwrTAEn4DoSNSYKqNUru81qKvz
 0fFtiPfr8mK30L1iQ6jSBb9jDqCIIcpOjUTTsufCS/CkPLvQUkJ3R8oPsPZ1OPr7fZUo
 /PV7+g5Yi8G6u5wQ72QeZSwWushSgefoWvTU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739136442; x=1739741242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hjux5RVVOlScxDkR7POf7SbE/e/7qKzCk0ch9TiazMA=;
 b=Ysj0XswR59ATaiDpihkteWnPP1uBT+iUmZ/Zlq7Sx2r/nlX8A+Gcno11lBw0fovzuL
 NDmzp5qUG3wp6o2VzEg3jZH6nJflNxbYOQbmhm/hgGhPP8QKP6gef2cGbZMc3UJCaZmR
 VlpnSRIcGkZ492T661HlMnelTd+QBsvsEXrtxnzcHY7fO3KT0Ir11POMFjq0M6mdgxbq
 mFuO+QWEpn9VHGC4P/1vA7Dm3HRQhHdI+k6vHvbiuHw2283akdX+O7k1eBhAg3BP+q8D
 fB3mYHtzFo0bIW7gY5jVcVRcbpJl5Y0RGZPtRpV4k70OrTMlqw5V6YTkXMWCxOlM6TKw
 k+1w==
X-Gm-Message-State: AOJu0YxRsrkpaRW8Lqo7SnBtLJ/sXQdYGnwA9XgCm7hioURURujhCAQ4
 bxsjb67YOI7njbllXHT+mI4N1ydlpeyy2E9OR3+uMsoPjGRo0NuwfHUbJXHHsNXUVF3f1Ep4c5M
 =
X-Gm-Gg: ASbGncusAgSXsobWaCx2NlQ7tSi4kcn24E5zRU7+I7Loy9CH/D8ug9mkQB0grQiZE37
 NJcsxPz/neUAZ8InZUT1Nqnj8Cn5nXYBGgr3BqJksFbs2knnceG1eIkmjO7kjmN2xSbOZqVMJi9
 ykErQf8sXM80qilLylIpBV4MtvYvmNc+ZuSv6L9akmxEfpcxgwQ/Zsf53HZrNfRpeEaqlNenTfa
 qiaTsOBqs1XY7s7AxpcHvVcpzoA8M6tDquXkN6a4r8OU3sWCnMOfdnRz6OoF71AILMgrCY6pfc/
 vWIqT+7bw7id8/sHTcakXsCtoW79zrHDm3N4UWMj3l8jMMqAVxQh
X-Google-Smtp-Source: AGHT+IGKjqzuubp6rPcwuGc9BULywpyfE3VFjZcMUSqjlxGoTxCyfE0R52LlBIoscwjmKB0hIrx7YA==
X-Received: by 2002:a05:6e02:1c86:b0:3ce:7da0:6fe2 with SMTP id
 e9e14a558f8ab-3d13dfa7e85mr92692865ab.0.1739136441106; 
 Sun, 09 Feb 2025 13:27:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d1586ba972sm5986835ab.43.2025.02.09.13.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:27:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/2] u_boot_pylib: Move gitutil into the library
Date: Sun,  9 Feb 2025 14:26:00 -0700
Message-ID: <20250209212714.2317040-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Move this file into U-Boot's Python library, so that it is no-longer
part of patman.

This makes a start on:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/35

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py                 | 2 +-
 tools/buildman/builderthread.py           | 2 +-
 tools/buildman/control.py                 | 2 +-
 tools/buildman/func_test.py               | 2 +-
 tools/buildman/main.py                    | 3 +--
 tools/patman/__init__.py                  | 4 ++--
 tools/patman/__main__.py                  | 2 +-
 tools/patman/checkpatch.py                | 2 +-
 tools/patman/cmdline.py                   | 2 +-
 tools/patman/control.py                   | 2 +-
 tools/patman/func_test.py                 | 2 +-
 tools/patman/get_maintainer.py            | 2 +-
 tools/patman/patchstream.py               | 2 +-
 tools/patman/project.py                   | 2 +-
 tools/patman/series.py                    | 2 +-
 tools/patman/settings.py                  | 2 +-
 tools/patman/test_checkpatch.py           | 2 +-
 tools/u_boot_pylib/__init__.py            | 4 ++--
 tools/u_boot_pylib/__main__.py            | 1 -
 tools/{patman => u_boot_pylib}/gitutil.py | 0
 20 files changed, 20 insertions(+), 22 deletions(-)
 rename tools/{patman => u_boot_pylib}/gitutil.py (100%)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index 3f5ddd8e722..68e9872663c 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -19,8 +19,8 @@ import time
 
 from buildman import builderthread
 from buildman import toolchain
-from patman import gitutil
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
 from u_boot_pylib.terminal import tprint
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index dc8a24d898c..b4cb66397bb 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -17,8 +17,8 @@ import sys
 import threading
 
 from buildman import cfgutil
-from patman import gitutil
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 from u_boot_pylib import tools
 
 RETURN_CODE_RETRY = -1
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index fb7bcbc43bf..4c9489126c1 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -20,9 +20,9 @@ from buildman import bsettings
 from buildman import cfgutil
 from buildman import toolchain
 from buildman.builder import Builder
-from patman import gitutil
 from patman import patchstream
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
 from u_boot_pylib.terminal import print_clear, tprint
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index d38aea7a405..6d3aaf1ce02 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -18,8 +18,8 @@ from buildman import bsettings
 from buildman import cmdline
 from buildman import control
 from buildman import toolchain
-from patman import gitutil
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
diff --git a/tools/buildman/main.py b/tools/buildman/main.py
index a948f36d9c0..72571b226d9 100755
--- a/tools/buildman/main.py
+++ b/tools/buildman/main.py
@@ -50,8 +50,7 @@ def run_tests(skip_net_tests, debug, verbose, args):
     # 'entry' module.
     result = test_util.run_test_suites(
         'buildman', debug, verbose, False, args.threads, test_name, [],
-        [test.TestBuild, func_test.TestFunctional,
-         'buildman.toolchain', 'patman.gitutil'])
+        [test.TestBuild, func_test.TestFunctional, 'buildman.toolchain'])
 
     return (0 if result.wasSuccessful() else 1)
 
diff --git a/tools/patman/__init__.py b/tools/patman/__init__.py
index 08eeffdf6d2..6de0e9fba10 100644
--- a/tools/patman/__init__.py
+++ b/tools/patman/__init__.py
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 __all__ = ['checkpatch', 'commit', 'control', 'func_test', 'get_maintainer',
-           'gitutil', '__main__', 'patchstream', 'project', 'series',
-           'settings','setup', 'status', 'test_checkpatch', 'test_settings']
+           '__main__', 'patchstream', 'project', 'series',
+           'settings', 'setup', 'status', 'test_checkpatch', 'test_settings']
diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index f645b38b647..36f1c08507c 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -49,7 +49,7 @@ def run_patman():
         result = test_util.run_test_suites(
             'patman', False, False, False, None, None, None,
             [test_checkpatch.TestPatch, func_test.TestFunctional,
-             'gitutil', 'settings'])
+             'settings'])
 
         sys.exit(0 if result.wasSuccessful() else 1)
 
diff --git a/tools/patman/checkpatch.py b/tools/patman/checkpatch.py
index e03cac115e4..2975881705c 100644
--- a/tools/patman/checkpatch.py
+++ b/tools/patman/checkpatch.py
@@ -8,8 +8,8 @@ import os
 import re
 import sys
 
-from patman import gitutil
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 
 EMACS_PREFIX = r'(?:[0-9]{4}.*\.patch:[0-9]+: )?'
diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index d6496c0cb78..562bc823f60 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -13,8 +13,8 @@ import os
 import pathlib
 import sys
 
-from patman import gitutil
 from patman import project
+from u_boot_pylib import gitutil
 from patman import settings
 
 PATMAN_DIR = pathlib.Path(__file__).parent
diff --git a/tools/patman/control.py b/tools/patman/control.py
index b292da9dc27..fb5a4246ced 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -12,8 +12,8 @@ import os
 import sys
 
 from patman import checkpatch
-from patman import gitutil
 from patman import patchstream
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 
 
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index af6c025a441..bf333dc557b 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -18,11 +18,11 @@ import unittest
 
 from patman.commit import Commit
 from patman import control
-from patman import gitutil
 from patman import patchstream
 from patman.patchstream import PatchStream
 from patman.series import Series
 from patman import settings
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
 from u_boot_pylib.test_util import capture_sys_output
diff --git a/tools/patman/get_maintainer.py b/tools/patman/get_maintainer.py
index 8df3d124bac..200ee96551d 100644
--- a/tools/patman/get_maintainer.py
+++ b/tools/patman/get_maintainer.py
@@ -7,8 +7,8 @@ import os
 import shlex
 import shutil
 
-from patman import gitutil
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 
 
 def find_get_maintainer(script_file_name):
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 940b50ca8d4..490d382045b 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -15,9 +15,9 @@ import shutil
 import tempfile
 
 from patman import commit
-from patman import gitutil
 from patman.series import Series
 from u_boot_pylib import command
+from u_boot_pylib import gitutil
 
 # Tags that we detect and remove
 RE_REMOVE = re.compile(r'^BUG=|^TEST=|^BRANCH=|^Review URL:'
diff --git a/tools/patman/project.py b/tools/patman/project.py
index 4459042b5d4..d6143a67066 100644
--- a/tools/patman/project.py
+++ b/tools/patman/project.py
@@ -4,7 +4,7 @@
 
 import os.path
 
-from patman import gitutil
+from u_boot_pylib import gitutil
 
 def detect_project():
     """Autodetect the name of the current project.
diff --git a/tools/patman/series.py b/tools/patman/series.py
index 6866e1dbd08..d7f2f010f5d 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -12,8 +12,8 @@ import sys
 import time
 
 from patman import get_maintainer
-from patman import gitutil
 from patman import settings
+from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
 
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 68c93e313b3..d66b22be1df 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -12,7 +12,7 @@ import argparse
 import os
 import re
 
-from patman import gitutil
+from u_boot_pylib import gitutil
 
 """Default settings per-project.
 
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index db7860f551d..11d003bc4e7 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -11,10 +11,10 @@ import tempfile
 import unittest
 
 from patman import checkpatch
-from patman import gitutil
 from patman import patchstream
 from patman import series
 from patman import commit
+from u_boot_pylib import gitutil
 
 
 class Line:
diff --git a/tools/u_boot_pylib/__init__.py b/tools/u_boot_pylib/__init__.py
index 63c88e85ec0..807a62e0743 100644
--- a/tools/u_boot_pylib/__init__.py
+++ b/tools/u_boot_pylib/__init__.py
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-__all__ = ['command', 'cros_subprocess','terminal', 'test_util', 'tools',
-	   'tout']
+__all__ = ['command', 'cros_subprocess', 'gitutil', 'terminal', 'test_util',
+           'tools', 'tout']
diff --git a/tools/u_boot_pylib/__main__.py b/tools/u_boot_pylib/__main__.py
index 8f98d7bd9f8..c0762bca733 100755
--- a/tools/u_boot_pylib/__main__.py
+++ b/tools/u_boot_pylib/__main__.py
@@ -13,7 +13,6 @@ if __name__ == "__main__":
     sys.path.append(os.path.join(our_path, '..'))
 
     # Run tests
-    from u_boot_pylib import terminal
     from u_boot_pylib import test_util
 
     result = test_util.run_test_suites(
diff --git a/tools/patman/gitutil.py b/tools/u_boot_pylib/gitutil.py
similarity index 100%
rename from tools/patman/gitutil.py
rename to tools/u_boot_pylib/gitutil.py
-- 
2.43.0

