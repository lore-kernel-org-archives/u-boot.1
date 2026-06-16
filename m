Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A348ACD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDC0848A6;
	Tue, 16 Jun 2026 16:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B6lUuVDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880CE848F0; Tue, 16 Jun 2026 16:29:50 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2384F84869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e904193a5fso350232a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620187; x=1782224987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSJNQ5Iac2O6LWrs2kEHPB5JrCufAW7119tssbZXVNY=;
 b=B6lUuVDj05VG+I1kclvw5NsFkY+2zf+d8AKvCnUylTCI+FEf2/ejZMmsp1QTYUqXtd
 beJakTBi9J2TOTuQybz3nl9qvR1HaR8vM6XMRJD65IU4t4QCOgwFKKdVq4ftu/9Ju5dA
 clVlacyfoofuMHuxXJVDIIjiEWd8+6JcLWXm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620187; x=1782224987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSJNQ5Iac2O6LWrs2kEHPB5JrCufAW7119tssbZXVNY=;
 b=BBSglrDLbOenWQZhpVUQ4wjdzKfKtdpPuMNO1JmQhCGf2vptvKvY5HEKSlLHYJd3G0
 vReERdQB75PvcCAX0bnwvS/f6oNl9/AWqJtwDWINXEbe9Nf1VaCYM3QN/PO2sAxVfvga
 xAqHYgWY6NZe+vyWjP9SfGikh39VANSatIiyfTVdFkVJyYq9T9YQXDSXQsN3oL7GDWcc
 fYi7gqksH3/9HqvR82u+mDHZO9je7lo6g0HKvYRhurBq/tcBBihhK4/ncOwr1hgcTugn
 higdG67pFWioLu85n1blH+1RoEVBp1g1Zs0RMqnyzvwlZo5UYRYTO6Nd7jDUfwzoW9KX
 Wuwg==
X-Gm-Message-State: AOJu0YycmCN89Ob0ZAgdu3eD+GhU+ZHmHU4NppZ5+/sc/yTTkY/EiLyL
 wP9hQ1kBk9qzr10MyWFvOHYNFUwxOnln77I4ED7g9XJ+luD2AOokM0qOohRxM450aBJAl6H9Z58
 FRgA=
X-Gm-Gg: Acq92OEHhBk6K0S5XK+GH2L4+L282+APb8Y/Xxuz45GsAEBzw3QPq1oof1nX/QD6S4Q
 x0iSoGyGXRIeAIO6++w3H0jSS4q4hkCqJj7aGTtcdx0Yob4f5HKmklcfKsOwO/f/9MrPUF0xGlk
 Af3TC2uwalvKL/feCVuJWtLvl4uaIpVwMG2DqhvS+7PjFqet/uoCX1wEzf5sAtQEPtK5WN8DvTq
 pEJ9dfjVAj1T+ii9swB1j5vSMNnErkUGNFnPad3424A0K/iWJ6I/dI9989ng6OJEj3wS+ilu1ks
 y4caGCGgABmfsQpfRspFfM+jGHz/y90Xax4dc6q/z+Npu3dYGxoiXZFkhZKlI3SZCrPXw9+fmBp
 PfPBDdYd7aeLDy14U4RqBh2qjoGG+Zli9hy1/bKceiyAmVFdEIqThW2ce+dO3HLou4evCxskbf6
 R6YdLjht8UhbcV8jLp7g==
X-Received: by 2002:a05:6808:1242:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4880c3adf7dmr3282952b6e.4.1781620186537; 
 Tue, 16 Jun 2026 07:29:46 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:29:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/9] patman: Replace the tool with a stub for patch-manager
Date: Tue, 16 Jun 2026 08:28:41 -0600
Message-ID: <20260616142859.54136-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142859.54136-1-sjg@chromium.org>
References: <20260616142859.54136-1-sjg@chromium.org>
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

patman is now maintained as a standalone 'patch-manager' package, rather
than in the U-Boot tree. Replace the command with a small stub which
tells people how to install it.

buildman still uses the shared modules commit and patchstream (and their
dependencies), so leave those in place; the patches that follow remove
the patch-management code itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 68 +++++++++++++---------------------------
 1 file changed, 21 insertions(+), 47 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index edfb1b5927c..a497f6ced7e 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -4,56 +4,30 @@
 # Copyright (c) 2011 The Chromium OS Authors.
 #
 
-"""See README for more information"""
+"""Stub for the former in-tree patman tool
 
-import os
-import sys
-
-# Allow 'from patman import xxx to work'
-# pylint: disable=C0413
-our_path = os.path.dirname(os.path.realpath(__file__))
-sys.path.append(os.path.join(our_path, '..'))
-
-# Our modules
-from u_boot_pylib import test_util
-from u_boot_pylib import tout
-from patman import cmdline
-from patman import control
-
-
-def run_patman():
-    """Run patamn
+patman is now maintained as a standalone 'patch-manager' package, rather
+than living in the U-Boot tree. This stub just tells the user how to get
+it.
+"""
 
-    This is the main program. It collects arguments and runs either the tests or
-    the control module.
-    """
-    args = cmdline.parse_args()
-
-    if not args.debug:
-        sys.tracebacklimit = 0
-
-    tout.init(tout.INFO if args.verbose else tout.WARNING)
-
-    # Run our reasonably good tests
-    if args.cmd == 'test':
-        # pylint: disable=C0415
-        from patman import func_test
-        from patman import test_checkpatch
-        from patman import test_cseries
+import sys
 
-        to_run = args.testname if args.testname not in [None, 'test'] else None
-        result = test_util.run_test_suites(
-            'patman', False, args.verbose, args.no_capture,
-            args.test_preserve_dirs, None, to_run, None,
-            [test_checkpatch.TestPatch, func_test.TestFunctional, 'settings',
-             test_cseries.TestCseries])
-        sys.exit(0 if result.wasSuccessful() else 1)
 
-    # Process commits, produce patches files, check them, email them
-    else:
-        exit_code = control.do_patman(args)
-        sys.exit(exit_code)
+def main():
+    """Print instructions for installing the patch-manager package"""
+    print(
+        'patman is no longer part of U-Boot. It is now maintained as a\n'
+        "separate package called 'patch-manager'.\n"
+        '\n'
+        'Install it with:\n'
+        '\n'
+        '    pip install patch-manager\n'
+        '\n'
+        'Documentation: https://deinde.dev/patman\n',
+        file=sys.stderr)
+    return 1
 
 
-if __name__ == "__main__":
-    sys.exit(run_patman())
+if __name__ == '__main__':
+    sys.exit(main())
-- 
2.43.0

