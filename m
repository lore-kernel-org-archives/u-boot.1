Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E02E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FE3801FB;
	Tue, 17 Dec 2024 14:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SS0qvlU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0EF8020C; Tue, 17 Dec 2024 14:26:25 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AC1801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so15421085ab.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734441980; x=1735046780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EyzBfNWygeipma5ELHFryRFbf8rmb6EigatW7DJILuc=;
 b=SS0qvlU3TtnslihpBVn5X1HIMLDZRhsQZ7HIYQOl53VmQaxhenoE9TvoyccEsK4pK5
 cYVuNnVT4nDK55RFUm1VhDxQr4/PJTgotwIxfIZlhuF1K2CJKfrp4C3V5EYmSeVaJO4I
 07xPShuYp1JsGDnVbZsGNExsAqg7bNiSxzPbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734441980; x=1735046780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyzBfNWygeipma5ELHFryRFbf8rmb6EigatW7DJILuc=;
 b=NmYWDDjHscNUW2ATYALm5mhUTEft0RSD6jDPX0BFNJi+mCDouckpZ5vyDAToGezTCx
 CfmYn0rflK4K1wgsn0Xl+fSG63saYiHSa+roPs7d2xBrncF1xVcsSErZszrMvGzskHE8
 Uh2J3gmnYxytfjYS7PB23gy6mLDlydGTGTh7oqh/Fpffa2fFmBxARL3yx7yBMQJQ1CXv
 e5m1hpow0qUNMGoM8bK1VXUFeDBdnXV5GWtweOjepVwoG1iTuJve0ECMUbNBYPNtUKO2
 jO7TzhTrK6MlgwplEFeMlm5S2+J6b0nv2Qj79porjBNMNsFNxKwQw+rQRANgY/XAu3+7
 Y8sQ==
X-Gm-Message-State: AOJu0YzeclmbJABLBcYN/CUA4Ok3azFdUfHMNS+xLNnklVdWduHDHS+W
 Vcp+uHObp/DrbWiL1lkCgtV8KcRgdH++6Y3pPPis7HbyJa79lNYAG5hAY1DlTDK5vFCJxvppZLg
 =
X-Gm-Gg: ASbGncsMKwA40wYGi1VKEGT2EiW4Z08s9Uq7SzFIDhVsMD1IFkYUmhqJ8IkEObn3ntG
 MawH6Af/H9YP/Id81UqPHQ6scX8VBhJCoCbwX9Qa5gomkDb2WSfvXkE35CfhaAVfZQNqY6oOn3o
 35TL1oVdWYT8HXBH9TW+uJUs4C5AJ/V2d5xriLJvsNJYVaP5MVLtOgLWYKLJBSaJIg1seWdX1V4
 6Ed5zd+arjVTvJTSRG4RDuTpFyCdDy/sKCtXiBedIxfT8hkKapqmXY35EgfAmdCJAuGK6sSVBKR
 UEgFXl+eMwf8nHbH6g==
X-Google-Smtp-Source: AGHT+IF2RUlshfJAo+PIL8RbqDS3Hp9Giaxahu7pT3a/haalYXbzot0AK9+pGzKa8EIB/TWBWwi57w==
X-Received: by 2002:a05:6e02:1a2d:b0:3a7:8720:9deb with SMTP id
 e9e14a558f8ab-3aff5b520damr136539925ab.11.1734441980234; 
 Tue, 17 Dec 2024 05:26:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b24e557df0sm21033055ab.80.2024.12.17.05.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 05:26:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] buildman: Add a way to build a particular target
Date: Tue, 17 Dec 2024 06:26:16 -0700
Message-Id: <20241217132616.3708573-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

At present buildman only supports building the default target. Generally
this is what is wanted, but in some cases boards erroneously have a
different target for product extra files.

Add a --target option to help. Also add a comment indicating which
letters are free for new options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py       |  4 +++-
 tools/buildman/builderthread.py |  2 ++
 tools/buildman/buildman.rst     |  4 ++++
 tools/buildman/cmdline.py       |  3 +++
 tools/buildman/control.py       |  5 ++++-
 tools/buildman/func_test.py     | 10 ++++++++++
 6 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index cbf1345281b..380c4057613 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -265,7 +265,7 @@ class Builder:
                  reproducible_builds=False, force_build=False,
                  force_build_failures=False, force_reconfig=False,
                  in_tree=False, force_config_on_failure=False, make_func=None,
-                 dtc_skip=False):
+                 dtc_skip=False, build_target=None):
         """Create a new Builder object
 
         Args:
@@ -315,6 +315,7 @@ class Builder:
                 retrying a failed build
             make_func (function): Function to call to run 'make'
             dtc_skip (bool): True to skip building dtc and use the system one
+            build_target (str): Build target to use (None to use the default)
         """
         self.toolchains = toolchains
         self.base_dir = base_dir
@@ -363,6 +364,7 @@ class Builder:
                 raise ValueError('Cannot find dtc')
         else:
             self.dtc = None
+        self.build_target = build_target
 
         if not self.squash_config_y:
             self.config_filenames += EXTRA_CONFIG_FILENAMES
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 29e6cf32af1..5c61d9c81bd 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -286,6 +286,8 @@ class BuilderThread(threading.Thread):
         """
         if config_only:
             args.append('cfg')
+        elif self.builder.build_target:
+            args.append(self.builder.build_target)
         result = self.make(commit, brd, 'build', cwd, *args, env=env)
         cmd_list.append([self.builder.gnu_make] + args)
         if (result.return_code == 2 and
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 924564b5700..a6a44d8f3ba 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1329,6 +1329,10 @@ sometimes useful to have buildman wait until the others have finished. Use the
 --process-limit option for this: --process-limit 1 will allow only one buildman
 to process jobs at a time.
 
+To build a particular target, rather than the default U-Boot target, use the
+`--target` option. This is unlikely to be useful unless you are building a
+single board.
+
 Build summary
 -------------
 
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 7573e5bdfe8..9236d6187cf 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -22,6 +22,7 @@ def add_upto_m(parser):
 
     This is split out to avoid having too many statements in one function
     """
+    # Available JqzZ
     parser.add_argument('-a', '--adjust-cfg', type=str, action='append',
           help='Adjust the Kconfig settings in .config before building')
     parser.add_argument('-A', '--print-prefix', action='store_true',
@@ -153,6 +154,8 @@ def add_after_m(parser):
     parser.add_argument('-T', '--threads', type=int,
           default=None,
           help='Number of builder threads to use (0=single-thread)')
+    parser.add_argument('--target', type=str,
+          default=None, help='Build target to use')
     parser.add_argument('-u', '--show_unknown', action='store_true',
           default=False, help='Show boards with unknown build result')
     parser.add_argument('-U', '--show-environment', action='store_true',
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 55d4d770c5c..fb7bcbc43bf 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -785,6 +785,9 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
                      args.verbose)
         return 0
 
+    if args.config_only and args.target:
+        raise ValueError('Cannot use --config-only with --target')
+
     # Create a new builder with the selected args
     builder = Builder(toolchains, output_dir, git_dir,
             args.threads, args.jobs, checkout=True,
@@ -810,7 +813,7 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
             force_build_failures = args.force_build_failures,
             force_reconfig = args.force_reconfig, in_tree = args.in_tree,
             force_config_on_failure=not args.quick, make_func=make_func,
-            dtc_skip=args.dtc_skip)
+            dtc_skip=args.dtc_skip, build_target=args.target)
 
     TEST_BUILDER = builder
 
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 4e12c671a3d..03a4536d69c 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -1152,3 +1152,13 @@ CONFIG_SOC="fred"
             'board': 'ARM Board 0',
             'config': 'config0',
             'target': 'board0'}, []), res)
+
+    def testTarget(self):
+        """Test that the --target flag works"""
+        lines = self.check_command('--target', 'u-boot.dtb')[0]
+
+        # It should not affect the defconfig line
+        self.assertNotIn(b'u-boot.dtb', lines[0])
+
+        # It should appear at the end of the build line
+        self.assertEqual(b'u-boot.dtb', lines[1].split()[-1])
-- 
2.34.1

