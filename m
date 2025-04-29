Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE1EC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFAD8215E;
	Tue, 29 Apr 2025 15:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DNzQidEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFEC826B2; Tue, 29 Apr 2025 15:23:32 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A5A82145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72a4793d4e2so4420602a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933008; x=1746537808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nmRvYGcckwV579c+oSQ4yWA2JWlmDcVI1DJ3nuhAk0=;
 b=DNzQidEXBb7qGsycHzhj4lpqgWijXHAYF6YBoB6cmqkGjjy7OG6b97fQJ+auvWFXCy
 ItwUpyAn0zCjH53a9r6613SIX1Lc/cfppFEqNr5qCR0WMJ9ujFKgL9xo1JB6amYfTZIV
 aYgfJBxmzZJqRgfONkjl0EFxolayeMcfWwIu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933008; x=1746537808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nmRvYGcckwV579c+oSQ4yWA2JWlmDcVI1DJ3nuhAk0=;
 b=gzvKvp4rdu2dbrv0tsTfuUUetNZ2hU5wIvWJf0FfWpcU0L+vyQUHbOeUmr4xkiMeyU
 BsAajuq5GSz7W8r7T7pTe4zAElvBobm8gsRLfHMu0PV62dTDAHXVlDG9RKd1O4gyGZUj
 rtcohzPDyVSc28WY1Nb/Q+wMpoqBFx083f6S/yAkxsNutgQgxTr5ABxnGdecPo+nYKIe
 UPWdmr3ewy0uyuMMIzme5Xih7oHAVsNGYhHQ/NKTbysbmBQKG2eJrBw00uFk8JDLJK6u
 4pBlI4GAeHWbGCCF8CLmxAACD7WvpHZYnSBAryfWtulGyL2e/H5lWs995NG6xitDPOww
 ONjQ==
X-Gm-Message-State: AOJu0Yxt74fm6mIj4Odi2S5clh4qu8XDUOUmSD1uqResRdBBQR4vy3lp
 XtPW9kJ/j10WvmwIw9qfQGBkWA4VROcUpoJzxa/1dLY8Jr5M6JYDyPEJMZ4dla2MrX0w83kVeQw
 =
X-Gm-Gg: ASbGncvPVR+Di/vNEA9Ve3ntBMCtCqZ7TbzjY1wV7YZaezgQEu9iS8aNvCH7IXU+y6Y
 RAIUMq+iyO7iRjyckObV3GpGstjTOVNHJ9m5f5bwg+CEA95Z3m63jbZyWh/k2PFXxi7JOCVIFcn
 uTd9x+sud7OwubdPvr0pt//SVWhRKYcHlFm2MAW+A5RdL3kXDUgEGUpo7eG9Son2VeZNkfzoZMQ
 AoEmbNpkBe5WwafRmMBQU6lN6Bsl+ozfyZwhLKt72kKOmdci+rmWLF570wrGsDZ4dqxCvVtgych
 JJ3vnsP87rAFTOwHRGrGG+8q2FNAHF8PGrkec5ZAYl6G9ka2qvV9r2NacRO+7daxGmyUQqJ3Wom
 NsA==
X-Google-Smtp-Source: AGHT+IHb2WSdExmUdY/+aTVq8l3e0h2ItMEP/kFFrlMwO61QUV/wVOMVg6LZRFZhPyok9Q4pXnKsKQ==
X-Received: by 2002:a05:6830:630d:b0:72a:e8b:a849 with SMTP id
 46e09a7af769-730897b8eaemr2101629a34.27.1745933007852; 
 Tue, 29 Apr 2025 06:23:27 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/30] patman: Move all non-test logic into control module
Date: Tue, 29 Apr 2025 07:21:58 -0600
Message-ID: <20250429132239.251756-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

It is easier for tests if the top-level control logic is all in one
module. Create a new do_patman() function to handle this. Move the
existing code into it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 49 ++----------------------------------
 tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 36f1c08507c..0d08a53cbab 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -6,15 +6,8 @@
 
 """See README for more information"""
 
-try:
-    from importlib import resources
-except ImportError:
-    # for Python 3.6
-    import importlib_resources as resources
 import os
-import re
 import sys
-import traceback
 
 # Allow 'from patman import xxx to work'
 # pylint: disable=C0413
@@ -24,9 +17,7 @@ sys.path.append(os.path.join(our_path, '..'))
 # Our modules
 from patman import cmdline
 from patman import control
-from u_boot_pylib import terminal
 from u_boot_pylib import test_util
-from u_boot_pylib import tools
 
 
 def run_patman():
@@ -54,44 +45,8 @@ def run_patman():
         sys.exit(0 if result.wasSuccessful() else 1)
 
     # Process commits, produce patches files, check them, email them
-    elif args.cmd == 'send':
-        # Called from git with a patch filename as argument
-        # Printout a list of additional CC recipients for this patch
-        if args.cc_cmd:
-            re_line = re.compile(r'(\S*) (.*)')
-            with open(args.cc_cmd, 'r', encoding='utf-8') as inf:
-                for line in inf.readlines():
-                    match = re_line.match(line)
-                    if match and match.group(1) == args.patchfiles[0]:
-                        for cca in match.group(2).split('\0'):
-                            cca = cca.strip()
-                            if cca:
-                                print(cca)
-
-        elif args.full_help:
-            with resources.path('patman', 'README.rst') as readme:
-                tools.print_full_help(str(readme))
-        else:
-            # If we are not processing tags, no need to warning about bad ones
-            if not args.process_tags:
-                args.ignore_bad_tags = True
-            control.send(args)
-
-    # Check status of patches in patchwork
-    elif args.cmd == 'status':
-        ret_code = 0
-        try:
-            control.patchwork_status(args.branch, args.count, args.start, args.end,
-                                     args.dest_branch, args.force,
-                                     args.show_comments, args.patchwork_url)
-        except Exception as exc:
-            terminal.tprint(f'patman: {type(exc).__name__}: {exc}',
-                            colour=terminal.Color.RED)
-            if args.debug:
-                print()
-                traceback.print_exc()
-            ret_code = 1
-        sys.exit(ret_code)
+    else:
+        control.do_patman(args)
 
 
 if __name__ == "__main__":
diff --git a/tools/patman/control.py b/tools/patman/control.py
index b8a45912058..990e07f8766 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -9,12 +9,21 @@ the features of patman.
 """
 
 import os
+import re
 import sys
+import traceback
+
+try:
+    from importlib import resources
+except ImportError:
+    # for Python 3.6
+    import importlib_resources as resources
 
-from patman import checkpatch
-from patman import patchstream
 from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
+from u_boot_pylib import tools
+from patman import checkpatch
+from patman import patchstream
 
 
 def setup():
@@ -245,3 +254,44 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     from patman import status
     status.check_patchwork_status(series, found[0], branch, dest_branch, force,
                                   show_comments, url)
+
+
+def do_patman(args):
+    if args.cmd == 'send':
+        # Called from git with a patch filename as argument
+        # Printout a list of additional CC recipients for this patch
+        if args.cc_cmd:
+            re_line = re.compile(r'(\S*) (.*)')
+            with open(args.cc_cmd, 'r', encoding='utf-8') as inf:
+                for line in inf.readlines():
+                    match = re_line.match(line)
+                    if match and match.group(1) == args.patchfiles[0]:
+                        for cca in match.group(2).split('\0'):
+                            cca = cca.strip()
+                            if cca:
+                                print(cca)
+
+        elif args.full_help:
+            with resources.path('patman', 'README.rst') as readme:
+                tools.print_full_help(str(readme))
+        else:
+            # If we are not processing tags, no need to warning about bad ones
+            if not args.process_tags:
+                args.ignore_bad_tags = True
+            send(args)
+
+    # Check status of patches in patchwork
+    elif args.cmd == 'status':
+        ret_code = 0
+        try:
+            patchwork_status(args.branch, args.count, args.start, args.end,
+                             args.dest_branch, args.force, args.show_comments,
+                             args.patchwork_url)
+        except Exception as exc:
+            terminal.tprint(f'patman: {type(exc).__name__}: {exc}',
+                            colour=terminal.Color.RED)
+            if args.debug:
+                print()
+                traceback.print_exc()
+            ret_code = 1
+        sys.exit(ret_code)
-- 
2.43.0

