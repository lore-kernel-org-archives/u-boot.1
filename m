Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF82C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D159B870BC;
	Sat,  4 Nov 2023 17:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U5XWLFI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B5087115; Sat,  4 Nov 2023 17:25:41 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BA287084
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 17:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a93df91813so111333839f.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699115133; x=1699719933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AK4WUS08A+jpapEz1MOcF2EgJLlZk0u4+3/cRUoVJVs=;
 b=U5XWLFI7TLfPSA64eyr/bTYm81wlEibqMdzz2W0LT2yp3+j0GtL5GNx3HTK05Y3qlA
 rSG84/wNHTZGbInoUX6CUbyKWL2+J8TF16wnJ6KL0CAWTftWKyYhOpY4KodTGKqBgDzW
 YzgPckUfx0Bm7UPDX+hU9DpwnYXjYbIk+qFXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699115133; x=1699719933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AK4WUS08A+jpapEz1MOcF2EgJLlZk0u4+3/cRUoVJVs=;
 b=Xu6ooitgvdZQWpWcPeHYW8RQNuX7YcqRXqh8f7NAaYFxBuLcouMhqTT2G2cJHzyZJE
 htuP9JnmI4EaMzFx8ZSj8mEpXwIsUcS17N5zE3RkobkiECwXp/l1o/yQTnTix5YFAaRC
 DyXKo3WFBaZkk4Vbj8SPb8zawOiZ6OvUY6Q3N6/kvbSNHnh3SsA0FBR3XossRlOk1BlU
 gijmQXVpKKYR/+BnydySuj0f9iqafN97q+OKzfWfQwyTT/oBIRGvRhFu/6txXUlOdkA3
 W/FaGxf9qyeXNlcv6QzUxITeFWCqf5nR+T5Bji7ohnDd9mYZp5G8uZ/LMiqalTm1PUkr
 eXSQ==
X-Gm-Message-State: AOJu0Yx+D8C5/hSUDAuMSjoCKcMxUV04c7rmRdgTDh2OYxwqMa2umFYF
 viAdgi76s123QVKRqq0n8pe2VZY2s8VSfSui8q+FAA==
X-Google-Smtp-Source: AGHT+IHrERasBZLOJ1JzpR2Mt4Nv5Et1XLt6ft3F1g0wBgpihSSzjaf+kGSn8sk4Fb26KWb+1MXQXg==
X-Received: by 2002:a05:6602:2c51:b0:792:8d16:91ef with SMTP id
 x17-20020a0566022c5100b007928d1691efmr32531611iov.18.1699115133483; 
 Sat, 04 Nov 2023 09:25:33 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a028784000000b0042bb296863asm1119013jai.56.2023.11.04.09.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 09:25:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/5] patman: Move the main program into a function
Date: Sat,  4 Nov 2023 10:25:21 -0600
Message-ID: <20231104162527.1736401-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104162527.1736401-1-sjg@chromium.org>
References: <20231104162527.1736401-1-sjg@chromium.org>
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

Add a new run_patman() function to hold the main logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 127 +++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 0e559b5810be..87850295e704 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -30,63 +30,70 @@ from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
 
-if __name__ != "__main__":
-    pass
-
-args = cmdline.parse_args()
-
-if not args.debug:
-    sys.tracebacklimit = 0
-
-# Run our meagre tests
-if args.cmd == 'test':
-    from patman import func_test
-    from patman import test_checkpatch
-
-    result = test_util.run_test_suites(
-        'patman', False, False, False, None, None, None,
-        [test_checkpatch.TestPatch, func_test.TestFunctional,
-         'gitutil', 'settings'])
-
-    sys.exit(0 if result.wasSuccessful() else 1)
-
-# Process commits, produce patches files, check them, email them
-elif args.cmd == 'send':
-    # Called from git with a patch filename as argument
-    # Printout a list of additional CC recipients for this patch
-    if args.cc_cmd:
-        fd = open(args.cc_cmd, 'r')
-        re_line = re.compile('(\S*) (.*)')
-        for line in fd.readlines():
-            match = re_line.match(line)
-            if match and match.group(1) == args.patchfiles[0]:
-                for cc in match.group(2).split('\0'):
-                    cc = cc.strip()
-                    if cc:
-                        print(cc)
-        fd.close()
-
-    elif args.full_help:
-        with importlib.resources.path('patman', 'README.rst') as readme:
-            tools.print_full_help(str(readme))
-    else:
-        # If we are not processing tags, no need to warning about bad ones
-        if not args.process_tags:
-            args.ignore_bad_tags = True
-        control.send(args)
-
-# Check status of patches in patchwork
-elif args.cmd == 'status':
-    ret_code = 0
-    try:
-        control.patchwork_status(args.branch, args.count, args.start, args.end,
-                                 args.dest_branch, args.force,
-                                 args.show_comments, args.patchwork_url)
-    except Exception as e:
-        terminal.tprint('patman: %s: %s' % (type(e).__name__, e),
-                        colour=terminal.Color.RED)
-        if args.debug:
-            print()
-            traceback.print_exc()
-        ret_code = 1
-    sys.exit(ret_code)
+def run_patman():
+    """Run patamn
+
+    This is the main program. It collects arguments and runs either the tests or
+    the control module.
+    """
+    args = cmdline.parse_args()
+
+    if not args.debug:
+        sys.tracebacklimit = 0
+
+    # Run our meagre tests
+    if args.cmd == 'test':
+        from patman import func_test
+        from patman import test_checkpatch
+
+        result = test_util.run_test_suites(
+            'patman', False, False, False, None, None, None,
+            [test_checkpatch.TestPatch, func_test.TestFunctional,
+             'gitutil', 'settings'])
+
+        sys.exit(0 if result.wasSuccessful() else 1)
+
+    # Process commits, produce patches files, check them, email them
+    elif args.cmd == 'send':
+        # Called from git with a patch filename as argument
+        # Printout a list of additional CC recipients for this patch
+        if args.cc_cmd:
+            fd = open(args.cc_cmd, 'r')
+            re_line = re.compile('(\S*) (.*)')
+            for line in fd.readlines():
+                match = re_line.match(line)
+                if match and match.group(1) == args.patchfiles[0]:
+                    for cc in match.group(2).split('\0'):
+                        cc = cc.strip()
+                        if cc:
+                            print(cc)
+            fd.close()
+
+        elif args.full_help:
+            with importlib.resources.path('patman', 'README.rst') as readme:
+                tools.print_full_help(str(readme))
+        else:
+            # If we are not processing tags, no need to warning about bad ones
+            if not args.process_tags:
+                args.ignore_bad_tags = True
+            control.send(args)
+
+    # Check status of patches in patchwork
+    elif args.cmd == 'status':
+        ret_code = 0
+        try:
+            control.patchwork_status(args.branch, args.count, args.start, args.end,
+                                     args.dest_branch, args.force,
+                                     args.show_comments, args.patchwork_url)
+        except Exception as e:
+            terminal.tprint('patman: %s: %s' % (type(e).__name__, e),
+                            colour=terminal.Color.RED)
+            if args.debug:
+                print()
+                traceback.print_exc()
+            ret_code = 1
+        sys.exit(ret_code)
+
+
+if __name__ == "__main__":
+    sys.exit(run_patman())
-- 
2.42.0.869.gea05f2083d-goog

