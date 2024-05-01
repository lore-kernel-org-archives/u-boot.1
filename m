Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B532AC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 23:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B85788B30;
	Thu,  2 May 2024 01:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YtOD90G4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9856488B36; Thu,  2 May 2024 01:17:04 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1CB88189
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 01:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b44071a07so70624806d6.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714605420; x=1715210220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O3X++bT5HqzoquWE7450HcTM1/RHcx9ZPDZgiT5pqtQ=;
 b=YtOD90G4TsCMTvdgrbtbysjSkpwjD5mqIACOY1w6/Z07ciuLjqD7XEsh4dKFkyrjO6
 iHjTEBAi3nWQZJDSnSA+dCZJa1sXg3kt2viz1LpE+nm55MA25j8BALwyIIj/pB7e3xfH
 ErEJfX47UEBx9TPVkSzGZIvmNLwrHg4gM2LbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714605420; x=1715210220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3X++bT5HqzoquWE7450HcTM1/RHcx9ZPDZgiT5pqtQ=;
 b=cD+OfQeMpIRvt3E8ZYXemwpsbYmD3PZa017QY7MiX/92w1LNUkLX2i1F+Mgm08BVSL
 YxryTkwlxVcdjRjbGWNbHZNPB8jJm7SEpPwRzEgrG5542vyaU0D+VLiN+r9w/ceiS5v3
 f6as4wo/6XOioTbbHu6KuhP77QHuTdOruZkRC2GYlkTzdW1bfJm3WtwgAJuFpfEjhjhQ
 2Ob6npHBrOgT/JnMdVulI68gG4svDNQKAUpGFJ89Tnsd9SodD5s1OOa/hTygOlj2MDfR
 ZEc1QQMVjQUW0wLfpoupuRnN1OlzXKYO3mPJ6gZIq7d3eqEF6HA+fPWqY+V+loV/GW6v
 y1xA==
X-Gm-Message-State: AOJu0YxeJp+NLy8fLG+TWo7AgQ7vz0gLjwAxv7FwONimSCKoq0/Z1hG6
 hzXrb75mIqgs9oT11kBrdo+7X5UIZ8szg7UJriK7mfn/oaNM1H2nYhUk7RLgJTVMXvrGGJC8XoX
 tUPIufH8y
X-Google-Smtp-Source: AGHT+IHy+R35rcVDndU41sRGfPwhbEa5LT1D/l0AcD0Fzi4UB+XJoQXBjlOiQpswqsJBDoZKe3Lp4g==
X-Received: by 2002:ad4:5746:0:b0:6a0:d52f:67b4 with SMTP id
 q6-20020ad45746000000b006a0d52f67b4mr4926024qvx.30.1714605420393; 
 Wed, 01 May 2024 16:17:00 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a0ce6a7000000b006a0cc19f870sm3447109qvn.9.2024.05.01.16.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 16:16:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Add flag to filter out missing binary blobs
Date: Wed,  1 May 2024 17:16:57 -0600
Message-Id: <20240501231657.2088609-1-trini@konsulko.com>
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

When doing builds of a number of platforms and not intending to run the
resulting binaries, we have an option already to tell buildman to just
make fake binaries for linking only. Add another option to filter this
from the output, to make parsing build logs easier.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/buildman/builder.py | 13 ++++++++++++-
 tools/buildman/cmdline.py |  3 +++
 tools/buildman/control.py |  3 ++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index f35175b4598d..d72dbc3e8bfb 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -368,6 +368,9 @@ class Builder:
         self._re_note = re.compile('(.*):(\d*):(\d*): note: this is the location of the previous.*')
         self._re_migration_warning = re.compile(r'^={21} WARNING ={22}\n.*\n=+\n',
                                                 re.MULTILINE | re.DOTALL)
+        self._re_missing_blobs = re.compile(r'Image.*is missing.*blobs.*\n.*\nSome images are invalid',
+                                                re.MULTILINE | re.DOTALL)
+
 
         self.thread_exceptions = []
         self.test_thread_exceptions = test_thread_exceptions
@@ -409,7 +412,8 @@ class Builder:
                           show_detail=False, show_bloat=False,
                           list_error_boards=False, show_config=False,
                           show_environment=False, filter_dtb_warnings=False,
-                          filter_migration_warnings=False, ide=False):
+                          filter_migration_warnings=False,
+                          filter_missing_blobs=False, ide=False):
         """Setup display options for the builder.
 
         Args:
@@ -424,6 +428,8 @@ class Builder:
                 compiler
             filter_migration_warnings: Filter out any warnings about migrating
                 a board to driver model
+            filter_missing_blobs: Filter out any warnings about missing binary
+                blobs
             ide: Create output that can be parsed by an IDE. There is no '+' prefix on
                 error lines and output on stderr stays on stderr.
         """
@@ -436,6 +442,7 @@ class Builder:
         self._show_environment = show_environment
         self._filter_dtb_warnings = filter_dtb_warnings
         self._filter_migration_warnings = filter_migration_warnings
+        self._filter_missing_blobs = filter_missing_blobs
         self._ide = ide
 
     def _add_timestamp(self):
@@ -672,6 +679,10 @@ class Builder:
             text = '\n'.join(lines)
             text = self._re_migration_warning.sub('', text)
             lines = text.splitlines()
+        if self._filter_missing_blobs:
+            text = '\n'.join(lines)
+            text = self._re_missing_blobs.sub('', text)
+            lines = text.splitlines()
         for line in lines:
             if self.re_make_err.search(line):
                 continue
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 03211bd5aa5f..6e5263b40747 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -168,6 +168,9 @@ def add_after_m(parser):
     parser.add_argument('-Y', '--filter-migration-warnings', action='store_true',
           default=False,
           help='Filter out migration warnings from output')
+    parser.add_argument('--filter-missing-blobs', action='store_true',
+          default=False,
+          help='Filter out missing binary blob warnings from output')
 
 
 def parse_args():
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 8f6850c52113..cd6c47bd2993 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -539,7 +539,8 @@ def run_builder(builder, commits, board_selected, args):
     builder.set_display_options(
         args.show_errors, args.show_sizes, args.show_detail, args.show_bloat,
         args.list_error_boards, args.show_config, args.show_environment,
-        args.filter_dtb_warnings, args.filter_migration_warnings, args.ide)
+        args.filter_dtb_warnings, args.filter_migration_warnings,
+        args.filter_missing_blobs, args.ide)
     if args.summary:
         builder.show_summary(commits, board_selected)
     else:
-- 
2.34.1

