Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8D7C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8A282A55;
	Sun,  4 May 2025 15:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F+fVeQ6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6EF182A55; Sun,  4 May 2025 15:24:29 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DF982A7B
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so462552466b.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365066; x=1746969866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ON2DGbEI8KDhF120d98NWKl//BFcjM5fS0MtAbR/VsA=;
 b=F+fVeQ6k2goq5yvRKPxaD9pLiTxSRsD2o8337q2LymuZsOJmizLAxzSC5MAfay2bmA
 yd7uPtBRd+ccCaKNXs0xpf5nOSZQHJs3A1ahNy5L9xP+/6Zg/Uh+30wrrrjxrJLBpwqY
 BVgGWI1FTHfm72NwvhHW1gc9bKZ/yhMLUdgJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365066; x=1746969866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ON2DGbEI8KDhF120d98NWKl//BFcjM5fS0MtAbR/VsA=;
 b=nH46YQuSmEShwLdDghpcXF6chZHrYDGzyST5YXY7wjYkcWZ/s396b+srjZS1wYgv0O
 h9FYzG+vGOgjj10vhPTa9vB56yuvoSxnnbs1dusgEigYhhwBokvbOBHQs0Avt5UNqY7N
 8wDgDC/+ExP1n2LcLGXQSdKPJt7lcfHv5wIVfUaF9j7rezuJCUXoyuHlTqZbxW4XuBtC
 +Evv/s2I7b8+zVNktPHDv4MAehsMIcPUZzg9N2l0olbCT2e063AGSRYuX6pK3nYgK9Pt
 osEWLCZa1mfEq6VH92xi6HUQEUmVG+IPqZKTMfK7FiUurW6XKrGv8GwbOD8WxmkTWuBJ
 xzdQ==
X-Gm-Message-State: AOJu0YxlOMovXN9ROdthvkZy/2txoy+SwH7GIllcgP/w+lN5WwThnIT0
 4sFhcpwNZm/Sl+EqX1nHAOIr2cOr3xCE3IbqR2Zz5r2xHIU/Rqtz3+Cc0O0CLFyFIBPocHlNFe3
 Qiot/rLk=
X-Gm-Gg: ASbGncuwQ1ist97bKuw8TzDi0Q2AjLTcW8TVbSvtxjWdfkYF9Uj2PCa95dUAPM0QUfi
 e298JnQIOKHJupH/nfnZzdO0YM4z1Qwr2yurTJ5LuXutImlAmfxsGWi0rQ4iBpywT2Hn8ILaNwv
 d49mtGnOFlL0uJZkLPEIOLFALTVRoUggaIWyVe6ZWX/y9Iq4J521+JbGZZZl4uWlHV8661I9BvI
 xnuI06XOLXBKb2jbJlgdgy2S1/9LhubbsJ3Pzrc588mnGRPtUHh7kBHouZ2xQeMTz0DmB3Q+4dn
 BK+UIkjBlAQjC95MXxGVTt1iZVejymZQ7cyk0W8CkLVkfbU=
X-Google-Smtp-Source: AGHT+IHWur+NGwiDBN/oyZhqM+i94t0RCz7kmfGJ6913UcojSBTa00I+ragUQLkEa2tucgp4N90lsQ==
X-Received: by 2002:a17:907:3da5:b0:ac7:738c:996f with SMTP id
 a640c23a62f3a-ad1a490c4abmr292960066b.15.1746365066259; 
 Sun, 04 May 2025 06:24:26 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/30] patman: Support extra test features
Date: Sun,  4 May 2025 15:23:29 +0200
Message-ID: <20250504132356.2317305-14-sjg@chromium.org>
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

Provide support for the -X flag, which preserves the working directory
used by tests. Also support -N which shows captured output for tests.

Finally, allow selection of a particular test to run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/__main__.py  |  4 +++-
 tools/patman/cmdline.py   |  6 ++++++
 tools/patman/func_test.py | 24 +++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 6aadf767eca..1d1eaa19125 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -40,8 +40,10 @@ def run_patman():
         from patman import func_test
         from patman import test_checkpatch
 
+        to_run = args.testname if args.testname not in [None, 'test'] else None
         result = test_util.run_test_suites(
-            'patman', False, False, False, False, None, None, None,
+            'patman', False, args.verbose, args.no_capture,
+            args.test_preserve_dirs, None, to_run, None,
             [test_checkpatch.TestPatch, func_test.TestFunctional,
              'settings'])
 
diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 562bc823f60..a7327a20665 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -41,6 +41,9 @@ def parse_args():
         help='Commits to skip at end of patch list')
     parser.add_argument('-D', '--debug', action='store_true',
         help='Enabling debugging (provides a full traceback on error)')
+    parser.add_argument(
+        '-N', '--no-capture', action='store_true',
+        help='Disable capturing of console output in tests')
     parser.add_argument('-p', '--project', default=project.detect_project(),
                         help="Project name; affects default option values and "
                         "aliases [default: %(default)s]")
@@ -52,6 +55,9 @@ def parse_args():
     parser.add_argument(
         '-v', '--verbose', action='store_true', dest='verbose', default=False,
         help='Verbose output of errors and warnings')
+    parser.add_argument(
+        '-X', '--test-preserve-dirs', action='store_true',
+        help='Preserve and display test-created directories')
     parser.add_argument(
         '-H', '--full-help', action='store_true', dest='full_help',
         default=False, help='Display the README file')
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 161b5ad4288..85e7b475d90 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -53,6 +53,25 @@ class TestFunctional(unittest.TestCase):
     mary = 'Mary Bloggs <mary@napierwallies.co.nz>'
     commits = None
     patches = None
+    verbosity = False
+    preserve_outdirs = False
+
+    @classmethod
+    def setup_test_args(cls, preserve_indir=False, preserve_outdirs=False,
+                        toolpath=None, verbosity=None, no_capture=False):
+        """Accept arguments controlling test execution
+
+        Args:
+            preserve_indir: not used
+            preserve_outdir: Preserve the output directories used by tests.
+                Each test has its own, so this is normally only useful when
+                running a single test.
+            toolpath: not used
+        """
+        cls.preserve_outdirs = preserve_outdirs
+        cls.toolpath = toolpath
+        cls.verbosity = verbosity
+        cls.no_capture = no_capture
 
     def setUp(self):
         self.tmpdir = tempfile.mkdtemp(prefix='patman.')
@@ -60,7 +79,10 @@ class TestFunctional(unittest.TestCase):
         self.repo = None
 
     def tearDown(self):
-        shutil.rmtree(self.tmpdir)
+        if self.preserve_outdirs:
+            print(f'Output dir: {self.tmpdir}')
+        else:
+            shutil.rmtree(self.tmpdir)
         terminal.set_print_test_mode(False)
 
     @staticmethod
-- 
2.43.0

