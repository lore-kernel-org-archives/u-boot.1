Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9E7C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18DE82E28;
	Sat, 24 May 2025 19:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nCwILD8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3C6835AA; Sat, 24 May 2025 19:07:22 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D0A82CD2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3da8e1259dfso7332815ab.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106436; x=1748711236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NB1G6lwkJl510gbGouWs+2GtEXE1te8Lxk0jC2ddqaA=;
 b=nCwILD8ZjuwtV36B8LRnCpL4PL2GaoeZ4owzj0Mf6CnoA8mdKU8Cm9j8/9qJq/N88A
 b7MFEfj5+4t/HY/qVIG9XEt0V8iB4EYM+tdGa1L0obSBO6EMCwRRbtRVwhWmOnnuNHn+
 uheSw0vzNIrGiKgGTpBQfBR0MY8OnV2YF2G8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106436; x=1748711236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NB1G6lwkJl510gbGouWs+2GtEXE1te8Lxk0jC2ddqaA=;
 b=hZBoQ9uGYb61zjCcvpiNDw1G0goKzqkqH8NbLlRZmN8X1EOdZH4CRxD/Hgs1tNH+3c
 0Xpzx19EoywIG5ikmVxje8uvxG/nol2tWKDUK7xYonFSfUYxd4+rxLgCTdZcv7qJPzr/
 udiY/Pm7al7NJw59sjcpt8TpBryZf0vpLt/ywaurw9VDKSwRnEVR/WmleqJrluBnZMaY
 +NvDJOon2mV1BxeUiVVN7WO9HNQvqfTvQXNZN7k26S3CewB/WLhkwxiEVryrP5PJom4K
 18jPfzN+7qoMa8Yy18JEq2IxU+65fZqPQtDbDNG1YM0jU5XA8wRpo0L95m56iQolnxjt
 qm6Q==
X-Gm-Message-State: AOJu0Yy/9f0BtfRz/pGIuYp4dvAvJJE47d9fMPEShPSQvn9jwj4T8Iuz
 PIzMsNgK4W7SbogOZ96QHTQZGBV+xMK77JXhxK9/RVyEba2x1ziDZQp5KZQY82A8ootfGBZa8XT
 bj/P437Oj
X-Gm-Gg: ASbGncvECvs4b3IvTnXtGPX7T+EKKoJ6Tq44cZmMkyE/4dVimCnEiAEgxONoRmQEByy
 bEMhmquuke0p+FxBH1ejBZBKSuLkkYQdS4grYUUWPRJGJCFl4cazRDyyneCx0aDgat4cHDCIo1Z
 zzpsg7Izw4XfgGjsXk5LNaNF787pKHpHEdao6JXPB70CJk+ZTqzwb39FfynheF0woCnjkI38kSQ
 L2BNdL5NSmtBbLijyK31PhGUzqMJRYIL7nibAux6iI7jIwZ3POeAzGC+pptQb7UhSKv0kXFvGTD
 Yft2jdTZ5QScsNlG5WAfZ+debrZaCaJAiAD8mfRzUePEim+TStzts18aGrlvSv5ZMj+vPtGDP/s
 xv+OJbrv27qXz
X-Google-Smtp-Source: AGHT+IHUoJn1AYygtRNma1D8rw5z59kMKjteYEf2LrHB1wH9nACFEHDmlVzIeLHkgaYULQkRtLYcyg==
X-Received: by 2002:a05:6e02:3083:b0:3dc:7bc9:5058 with SMTP id
 e9e14a558f8ab-3dc9b6a5668mr30612535ab.7.1748106436306; 
 Sat, 24 May 2025 10:07:16 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] patman: Allow listing archived series
Date: Sat, 24 May 2025 11:06:51 -0600
Message-ID: <20250524170701.1238642-3-sjg@chromium.org>
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

Sometimes it is useful to include archived series in the listing so you
can see which series could potentially be unarchived. Add a flag for
this.

Add a --include-archived option to the 'series ls' command for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py      |  8 +++++++-
 tools/patman/control.py      |  2 +-
 tools/patman/cseries.py      |  9 ++++++---
 tools/patman/test_cseries.py | 24 ++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 924f0ad4e42..18bcece211f 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -138,6 +138,11 @@ def _add_show_cover_comments(parser):
                         help='Show comments from the cover letter')
 
 
+def _add_archived(parser):
+    parser.add_argument('-A', '--include-archived', action='store_true',
+                        help='Show archived series as well')
+
+
 def add_patchwork_subparser(subparsers):
     """Add the 'patchwork' subparser
 
@@ -262,7 +267,8 @@ def add_series_subparser(subparsers):
 
     series_subparsers.add_parser('get-link')
     series_subparsers.add_parser('inc')
-    series_subparsers.add_parser('ls')
+    ls = series_subparsers.add_parser('ls')
+    _add_archived(ls)
 
     mar = series_subparsers.add_parser('mark')
     mar.add_argument('-m', '--allow-marked', action='store_true',
diff --git a/tools/patman/control.py b/tools/patman/control.py
index 1250fa10c62..d898a4482af 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -174,7 +174,7 @@ def do_series(args, test_db=None, pwork=None, cser=None):
         elif args.subcmd == 'inc':
             cser.increment(args.series, args.dry_run)
         elif args.subcmd == 'ls':
-            cser.series_list()
+            cser.series_list(args.include_archived)
         elif args.subcmd == 'open':
             cser.open(pwork, args.series, args.version)
         elif args.subcmd == 'mark':
diff --git a/tools/patman/cseries.py b/tools/patman/cseries.py
index f2a6ae61ba9..717a2504962 100644
--- a/tools/patman/cseries.py
+++ b/tools/patman/cseries.py
@@ -386,13 +386,16 @@ class Cseries(cser_helper.CseriesHelper):
 
         return summary
 
-    def series_list(self):
+    def series_list(self, include_archived=False):
         """List all series
 
         Lines all series along with their description, number of patches
-        accepted and  the available versions
+        accepted and the available versions
+
+        Args:
+            include_archived (bool): True to include archived series also
         """
-        sdict = self.db.series_get_dict()
+        sdict = self.db.series_get_dict(include_archived)
         print(f"{'Name':15}  {'Description':40}  Accepted  Versions")
         border = f"{'-' * 15}  {'-' * 40}  --------  {'-' * 15}"
         print(border)
diff --git a/tools/patman/test_cseries.py b/tools/patman/test_cseries.py
index c761e0e1f9a..d6cd042e990 100644
--- a/tools/patman/test_cseries.py
+++ b/tools/patman/test_cseries.py
@@ -737,6 +737,30 @@ Tested-by: Mary Smith <msmith@wibble.com>   # yak
             '     1/3  1 2', lines[3])
         self.assertTrue(lines[4].startswith('--'))
 
+    def test_series_list_archived(self):
+        """Archive a series and test listing it"""
+        self.setup_second()
+        self.cser.archive('first')
+        with terminal.capture() as (out, _):
+            self.run_args('series', 'ls', pwork=True)
+        lines = out.getvalue().splitlines()
+        self.assertEqual(4, len(lines))
+        self.assertEqual(
+            'second           Series for my board                       '
+            '     1/3  1 2', lines[2])
+
+        # Now list including archived series
+        with terminal.capture() as (out, _):
+            self.run_args('series', 'ls', '--include-archived', pwork=True)
+        lines = out.getvalue().splitlines()
+        self.assertEqual(5, len(lines))
+        self.assertEqual(
+            'first                                                      '
+            '     -/2  1', lines[2])
+        self.assertEqual(
+            'second           Series for my board                       '
+            '     1/3  1 2', lines[3])
+
     def test_do_series_add(self):
         """Add a new cseries"""
         self.make_git_tree()
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
