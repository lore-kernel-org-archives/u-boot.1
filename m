Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5919FC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683A4834BC;
	Sat, 24 May 2025 19:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hq2ZON1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B2F835AA; Sat, 24 May 2025 19:07:27 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BD082ED0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-86a55400913so19512639f.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106442; x=1748711242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktoK+FhsiBGO9SMx9MoYWujHWCKSlqg6JoXlypaYyuU=;
 b=Hq2ZON1xpBPKRFVwkLGku4IvicfmeeUetDpfYNQqgR3FWklzoZ3vzkSWJWobSPBlVd
 d/KXQm10r1cVcU0PGMshcb9Ma0JKBIA5OowmZUkRv41vubrZFvN8ejc8pEwl8EvUXNew
 kbSDVwKHhCSzyiMJB5hFp+9h3Mb6sFDHOzd08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106442; x=1748711242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktoK+FhsiBGO9SMx9MoYWujHWCKSlqg6JoXlypaYyuU=;
 b=RSX33MdMqaUdnOGZPQ9Xa0OBXOkNF1aLEqTaUWMMKtfwxxUMkqnyuSHeBndLPePr1k
 2AXG1+Ja5aBC9qcKgDjYX6f3n/FwbCGwNyCTgyUrv66o8/XWl0ZCPA+MUm+y4fqZp0tP
 Z/Xdybpr5hR/yW7ILwcxJrokD3BOmbOpxGU3yIihHSoc/8U8SNxtUrgAFBOIKZD2kbY2
 rId75Gr0Z9b4nODmSjCWeI7sAKvp89DlkOdWjMl0PQsZ+kwiydDGRcjv57ALeBQz85r8
 bx4++qEpRFgj+Zp3VelqDq8Fc1WdnlvE/8GcyXGTemdXnDMvuLcRJ3zZpfwhhln7RwNQ
 K9jw==
X-Gm-Message-State: AOJu0Yxzf0ywrNvOo/oT7XfRCfBMdmyyK1qaAMnOj9zDUtGT7Plqnts6
 f+pP6CEXM2KfzmX0ygZtjMQ2xD+o0wx4JzmWjBpiayB0FU7URDem52UbaTW011KlVV9G1fTwlCg
 U9yW+BYlW/R0=
X-Gm-Gg: ASbGnct8YSRsxV1CA0NUgJRabRB3im1ucVNMxtNVtfoQPBSY3AOiH2EuMKBXDLuNkDg
 MCedO1PuSxozbnSI7usGALBSTYBxRldmQSVxPF/gr4QkOSMl7Rb8NhG96mElJNtdvWoKzR2e16z
 Q1uLI+R9Da3uQWVG8yEipUqhVHSIoH/OxTOLLRK27BZOPgOwSjrJLoY0uuy1PDb5d71PVaFpwso
 osqRGzCsbMXBR/+FREhcrjgM8gRa9ytD3RfSi3CVGxYO2EQGnip3LbLA3keFlf0q7fr7M9AzzR6
 fAqNQprE/AGFE2HFka39VIgaOQLaO/67hCGp2Ejvawd7wvQhYxjWsG0mXsVcSLwHqu8FbT5HC01
 sSulwKJ7y4Ys4
X-Google-Smtp-Source: AGHT+IGCGeZcL/LR332iGLBHM/5JZOnNIntLFyPRb/X4st0XAqZdhx92+4f32HQblp2cEWTw4X+BOw==
X-Received: by 2002:a05:6e02:1a4d:b0:3dc:8b29:30bc with SMTP id
 e9e14a558f8ab-3dc9b7739d3mr30699725ab.21.1748106441871; 
 Sat, 24 May 2025 10:07:21 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] patman: Allow using the first commit as series description
Date: Sat, 24 May 2025 11:06:53 -0600
Message-ID: <20250524170701.1238642-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524170701.1238642-1-sjg@chromium.org>
References: <20250524170701.1238642-1-sjg@chromium.org>
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

Sometimes series don't have a cover letter. Add a --use-commit option to
easily use the first commit's subject instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py      |  3 +++
 tools/patman/control.py      |  2 +-
 tools/patman/cseries.py      | 17 ++++++++++++----
 tools/patman/test_cseries.py | 38 +++++++++++++++++++++++++++++++++---
 4 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 3095b67e009..f80323b7853 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -229,6 +229,9 @@ def add_series_subparser(subparsers):
     add = series_subparsers.add_parser('add')
     add.add_argument('-D', '--desc',
                      help='Series description / cover-letter title')
+    add.add_argument(
+        '-u', '--use-commit', action='store_true',
+        help="Use the first commit's subject as series description if needed")
     add.add_argument(
         '-f', '--force-version', action='store_true',
         help='Change the Series-version on a series to match its branch')
diff --git a/tools/patman/control.py b/tools/patman/control.py
index 57d2dbe8edd..7d679ea02d6 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -147,7 +147,7 @@ def do_series(args, test_db=None, pwork=None, cser=None):
         if args.subcmd == 'add':
             cser.add(args.series, args.desc, mark=args.mark,
                      allow_unmarked=args.allow_unmarked, end=args.upstream,
-                     dry_run=args.dry_run)
+                     use_commit=args.use_commit, dry_run=args.dry_run)
         elif args.subcmd == 'archive':
             cser.archive(args.series)
         elif args.subcmd == 'autolink':
diff --git a/tools/patman/cseries.py b/tools/patman/cseries.py
index 7064c33b6ee..38fedebbc3f 100644
--- a/tools/patman/cseries.py
+++ b/tools/patman/cseries.py
@@ -38,7 +38,7 @@ class Cseries(cser_helper.CseriesHelper):
         super().__init__(topdir, colour)
 
     def add(self, branch_name, desc=None, mark=False, allow_unmarked=False,
-            end=None, force_version=False, dry_run=False):
+            end=None, use_commit=False, force_version=False, dry_run=False):
         """Add a series (or new version of a series) to the database
 
         Args:
@@ -47,6 +47,10 @@ class Cseries(cser_helper.CseriesHelper):
             mark (str): True to mark each commit with a change ID
             allow_unmarked (str): True to not require each commit to be marked
             end (str): Add only commits up to but exclu
+            use_commit (bool)): True to use the first commit's subject as the
+                series description, if none is available in the series or
+                provided in 'desc')
+
             force_version (bool): True if ignore a Series-version tag that
                 doesn't match its branch name
             dry_run (bool): True to do a dry run
@@ -58,9 +62,14 @@ class Cseries(cser_helper.CseriesHelper):
             tout.info(msg)
         if desc is None:
             if not ser.cover:
-                raise ValueError(f"Branch '{name}' has no cover letter - "
-                                 'please provide description')
-            desc = ser['cover'][0]
+                if use_commit and ser.commits:
+                    desc = ser.commits[0].subject
+                    tout.info(f"Using description from first commit: '{desc}'")
+                else:
+                    raise ValueError(f"Branch '{name}' has no cover letter - "
+                                    'please provide description')
+            if not desc:
+                desc = ser['cover'][0]
 
         ser = self._handle_mark(name, ser, version, mark, allow_unmarked,
                                 force_version, dry_run)
diff --git a/tools/patman/test_cseries.py b/tools/patman/test_cseries.py
index ab59ae7c9a3..1189a1344e8 100644
--- a/tools/patman/test_cseries.py
+++ b/tools/patman/test_cseries.py
@@ -199,7 +199,7 @@ class TestCseries(unittest.TestCase, TestCommon):
             Pcommit(2, 1, 'spi: SPI fixes', 1, None, None, None, None),
             pclist[2])
 
-    def test_series_not_checked_out(self):
+    def test_series_add_not_checked_out(self):
         """Test adding a new cseries when a different one is checked out"""
         cser = self.get_cser()
         self.assertFalse(cser.db.series_get_dict())
@@ -442,6 +442,38 @@ class TestCseries(unittest.TestCase, TestCommon):
         series = patchstream.get_metadata('first', 0, 2, git_dir=self.gitdir)
         self.assertNotIn('version', series)
 
+    def test_series_add_no_desc(self):
+        """Test adding a cseries with no cover letter"""
+        cser = self.get_cser()
+        self.assertFalse(cser.db.series_get_dict())
+
+        with self.assertRaises(ValueError) as exc:
+            with terminal.capture() as (out, _):
+                cser.add('first', allow_unmarked=True)
+        self.assertEqual(
+            "Branch 'first' has no cover letter - please provide description",
+            str(exc.exception))
+
+        with terminal.capture() as (out, _):
+            self.run_args('series', '-s', 'first', 'add', '--use-commit',
+                        '--allow-unmarked', pwork=True)
+        lines = out.getvalue().splitlines()
+        self.assertEqual(
+            "Adding series 'first' v1: mark False allow_unmarked True",
+            lines[0])
+        self.assertEqual(
+            "Using description from first commit: 'i2c: I2C things'",
+            lines[1])
+        self.assertEqual("Added series 'first' v1 (2 commits)", lines[2])
+        self.assertEqual(3, len(lines))
+
+        sdict = cser.db.series_get_dict()
+        self.assertEqual(1, len(sdict))
+        ser = sdict.get('first')
+        self.assertTrue(ser)
+        self.assertEqual('first', ser.name)
+        self.assertEqual('i2c: I2C things', ser.desc)
+
     def _fake_patchwork_cser(self, subpath):
         """Fake Patchwork server for the function below
 
@@ -766,7 +798,7 @@ Tested-by: Mary Smith <msmith@wibble.com>   # yak
         self.make_git_tree()
         args = Namespace(subcmd='add', desc='my-description', series='first',
                          mark=False, allow_unmarked=True, upstream=None,
-                         dry_run=False)
+                         use_commit=False, dry_run=False)
         with terminal.capture() as (out, _):
             control.do_series(args, test_db=self.tmpdir, pwork=True)
 
@@ -814,7 +846,7 @@ Tested-by: Mary Smith <msmith@wibble.com>   # yak
                          force=True)
         args = Namespace(subcmd='add', series=None, mark=False,
                          allow_unmarked=True, upstream=None, dry_run=False,
-                         desc=None)
+                         desc=None, use_commit=False)
         with terminal.capture():
             control.do_series(args, test_db=self.tmpdir, pwork=True)
 
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
