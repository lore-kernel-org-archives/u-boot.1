Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0C3C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302F78295C;
	Sun,  4 May 2025 15:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e+8jJx1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6204482952; Sun,  4 May 2025 15:24:06 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52773828F8
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so576459066b.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365043; x=1746969843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysnArQ/YjWmpsaJcT85dfr9bv7ppzWVEboJyvH7a7JY=;
 b=e+8jJx1WaEolN36NsrA8mf/h2njTaawP+S1+6bfe+P3Pg4BNdZpp44kDmQUstozA0j
 RtMvnvFlTJ6GPh2qolqn9PamAzAcVEgfvf9CIMEz/j7mJPn3wmYOwjVBjetUSXI184w9
 +wDZudD0pIQwA1LjN8tQ4FViiAcdQxjVboQA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365043; x=1746969843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysnArQ/YjWmpsaJcT85dfr9bv7ppzWVEboJyvH7a7JY=;
 b=UwCEi2kMTSxcvrzICAUJR9/cHtj2vA1N49YEXZ62yujWOSnAd4UVXkxPpvAyrF39uz
 0pbLLxyKYKvCkWlB8Slld3ZH1beItPm2BrAhZA60nQFOL0wusXuxQCxVppFFxiBJuyS1
 gsR+EaCgiKOvERX4Dfw8iZSPApD0me61V+NPl9pM4VWioh7BM1S/nyTvS9NSAlkK2EXE
 +N2P7Qkh8cECaEby479IwBtFg8WvAe9PkulY4cN2nTudBekEJ1aPDstbDriHuzvX+7nF
 fiGbq3VWTGYpxDy6PxIPPf14j12Ercd1qmoIliFG1JAONjMFsnahfDZgV3O/ZuCSrXDG
 U8Gg==
X-Gm-Message-State: AOJu0YzqW5i9AviZ03BugMJViQdk886DS1GnyeEWwC0/QGK/cXFzJc/1
 qguJPA2CyHmoQK/MUex9e+Pg5rzXd/PIz1rME4mwkGMqbuAeGtWlmJo0l6666aZm0qKsMQHQzI5
 UTLpHTn0=
X-Gm-Gg: ASbGncsZAQGOiZKG7RHv0CkZDNYnu36IjI7sP5ygRXmU3dwo8/EofgiIBkIZYIbgiZM
 qWH3He/S8xBq1jMxaNSyrWJswXW67WbjYdrULf1YN95U1eLcqnPjCo6Ev6/a5bmP6/BnK4QY1sV
 R+0ZNZ8lcnO43NCFBs6ThDg2cF8O+BI3dFF6KVQT23PTBApHutul6jS/mVDvM1SN0m2E0d04hgX
 a9k6WD7RikHM5tldRYI/Zzq8EOUYF2Nd8FAeBeW+TwVQLrPuFUD7KRPdCESu0RbSOL2zHTib4hE
 paQhJcLPdfIf+pPkie8YB31oQ/zcw1J+dW90
X-Google-Smtp-Source: AGHT+IFsyDch20tLyz8bStxkFK1n7XLDzsZ3FPblkeCGzr25xk99Ztrk7KzNQ24pA/QpWhaB2M6X1w==
X-Received: by 2002:a17:907:c80f:b0:aca:a539:be04 with SMTP id
 a640c23a62f3a-ad1a4896b68mr360915166b.4.1746365043242; 
 Sun, 04 May 2025 06:24:03 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/30] patman: Move all non-test logic into control module
Date: Sun,  4 May 2025 15:23:17 +0200
Message-ID: <20250504132356.2317305-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

