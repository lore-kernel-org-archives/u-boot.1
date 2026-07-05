Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AFFC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3A78484C;
	Sun,  5 Jul 2026 21:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VEqQTBD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFFF84105; Sun,  5 Jul 2026 21:33:24 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE7084997
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6a18e363d52so1895377eaf.0
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783280000; x=1783884800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3+Uge9rRvWz/nvH8RQ3aWuuuAZzRcoX1/xVZH6fGeI=;
 b=VEqQTBD1Sh1wjTDszayUekdze+bZyvfmqQjgjA0FR47ToqrWCz4GLQIR2IuD23M4Z0
 oHj9NZr0Fx6bYQbO2cjf1/G1JzD25ynmnLW40uKpcOzx3WH1VasiUI4QcPstn0wkbAlM
 cfgZd9ncx2cbf9OZ8oHRIwHq6AOJ+W/05obsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280000; x=1783884800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3+Uge9rRvWz/nvH8RQ3aWuuuAZzRcoX1/xVZH6fGeI=;
 b=mlArViYDzd8z/dialLLK45KMdto63VNlR5b84WRpAzT2LnSNsIcGDdt7DkBZUnh3pD
 VVmZjYw4a/R+HfQIkCFERqUI7ZO+g1WG5KUO6D8nqJTpjyYRdx7XoflJq7ZBHg/YnB2q
 IMUZn62cQRCiA3bgSPgyEr1Z5qg4CCnMq9Ngc1Jh/3w4IPJtcPI7oTePtkn42wUowm0Y
 z1B3Ad4cXTdr6eOkiAY1q/6XDYAr6I9fybw1UQHM/a3cL0jjU8UvgzyHrQW01ZqRnb90
 22rxE3qOe1QNgcEzxmTHeI3fAu/LvsiOqfyVbNK5awWFG8MQaofpHu6nf25aLhup9tpr
 LgBg==
X-Gm-Message-State: AOJu0Yz2d3we7UeC56CQekjkS26cwGhZRxEowNlryI564alfptQSCHGo
 tX/kqzg3VPvXt4CTsZfSXzhDt3w9ehTd8OoNCMOyw33n59GxX/ti60hCayznAEQWAy/HkqTVWQb
 HxVL2HA==
X-Gm-Gg: AfdE7clzsxWbNkaVAKhrX7neU4t0QiFzX0m4DVUCXYzKUdPXrmhytdHG6e1+j3Gh7wH
 EY+lK726Lu/e//mZJq7TF9EqnUQZWg6SRPOt5cg+tC4NiUdUpvF80emVimFgllwQu2ENRkaLRq1
 hhey+Eha1Frny2ksouNahst1Ak7ckZbg2/WxZdI1QzpzUOkRU0FI43cPrhMjtfU8/wW5QtGiVNe
 mAJmJu/ya6dDTOeVgnDHUJGcfhlDiZaQsipEm8PH7qPjhYBZvHuZ5DtSUEEcaE+unMn2qDxViVR
 xwlIR+ZN8odLSKkX7P6P/u/w98KVajt0QTTFELRHZ+WtlTzlGs1oiOQ+ym7g8aW4zkLvSI6To1Z
 j7A14L8Jr41K+ciZlsIYP0H+3gz4UrwzgDg+sjd4E/aY89YTcn3fRqIcfCMBX8cMeYNw7IRFdDf
 DReFhQEaU=
X-Received: by 2002:a05:6820:822:b0:696:1a98:bd5 with SMTP id
 006d021491bc7-6a32f65d99bmr3676916eaf.19.1783280000515; 
 Sun, 05 Jul 2026 12:33:20 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/11] patman: Replace the tool with a stub for
 patch-manager
Date: Sun,  5 Jul 2026 13:32:15 -0600
Message-ID: <20260705193251.2190705-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

(no changes since v1)

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

