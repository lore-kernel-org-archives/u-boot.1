Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427C4C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C291829EF;
	Tue, 29 Apr 2025 15:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YJjtdA9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4898829C7; Tue, 29 Apr 2025 15:24:18 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553148215E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7301c227512so3650082a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933054; x=1746537854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnhPvcmaySbd3O8fshOaEFTDSpcMZXIUG1mG8ts84Zc=;
 b=YJjtdA9Dr3P29Xg0OXwcVfcUxxYrkqVnKs5cgL7wHJecxIzJ59HHRXCD4Bz3DL+ea8
 vsGGjBL5ejuaKcsGtfJVd5OYbXRcM6qX6GGrosRX734tIl4N2u94G174+rgV8fB3LZi+
 K1r+B94pUNN0zNK/7UamQx7+yYyfU19S9HHPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933054; x=1746537854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PnhPvcmaySbd3O8fshOaEFTDSpcMZXIUG1mG8ts84Zc=;
 b=BOEsPkkOnLAf+gBsoCWGInpQq1f5D+zejwp8oBzHBd4hRik9l769ylfiNldLopFCOM
 SJ7a1odFQkk3SmEzNvEWIeNtMM4vSmUxmO/0upsegZTCwv44pgg0feHvSGfWzykKCXgo
 TJXDUeRCIZmYXejppueu/5ajR7Xg340XpWYY+xR7jl9zkEqTkzATCZXv7H+/LTNEiW0X
 ZYUIHoGe8kpVNLnqEyxTOPajVMp2AZj70pgLy6BwSBHQknliVZIs1JkUK621kj727VMo
 ATiiX5OOXItuc7sQ9e6E1hRaw/eNmgkbo5hS35otzBybD0jgcypWacql9RG8a4+ekgeX
 CrNA==
X-Gm-Message-State: AOJu0YwzObjPfaK0z9v3hUA4YhVcN5Z3p07GKjWpTbt2wNdyiIIABEkR
 3kyk4sVu19hIAxtyla50ODZDWQ7HzVewES50cVZK8lK1W2wjGpE3YOL7BCcmwYf+K8CPRHwY8gU
 =
X-Gm-Gg: ASbGncs/wV72DV12XtD6vL/QFwktLF2NMx0qj4SA+SrGsDVsTt8hT53935qcYBMVAFZ
 h/X6QwuO1xT5SZkCB5NnJzgbGnO95JsN7Xq/3Yk1q1AFAPbNbedcFwdP/kEmiJsTT1QjjtewKRc
 1gAFfSdL2K55tgKLuRTpknHcJ5vnZ6JTTCBFf+bACEny76tcZa8uuRfW0e9sUON6xJ4mYV6Yhnu
 a0RbOSNYP3hBoCK/GX6rM1gctncHqtm4SAGAfRFzlnolFrtHSqogBFqlyarZqBKNXjZXqhV89CY
 ODlcYfjeWlUXj8Uy4QQ+zVQ6hHSnaoCHZBM06Lasy6D/COVpZ4McWj1oE4e+XVQ/5Llyi6jifBS
 qm/U5O8tC+osp
X-Google-Smtp-Source: AGHT+IEgEq7CPSA8r8uya7h3flBN5yL03mZxEseeuZlL4xwcnaHdzMWCai3oLQY9GrteoqCqk15VGw==
X-Received: by 2002:a05:6830:d0b:b0:72b:8889:8222 with SMTP id
 46e09a7af769-7308a51443emr1797939a34.8.1745933054441; 
 Tue, 29 Apr 2025 06:24:14 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/30] patman: Support extra test features
Date: Tue, 29 Apr 2025 07:22:10 -0600
Message-ID: <20250429132239.251756-14-sjg@chromium.org>
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

Provide support for the -X flag, which preserves the working directory
used by tests. Also support -N which shows captured output for tests.

Finally, allow selection of a particular test to run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

