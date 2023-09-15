Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7ACEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5AA869C3;
	Fri, 15 Sep 2023 02:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PfQu+DWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2648698E; Fri, 15 Sep 2023 02:22:58 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF07864C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso59684439f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737374; x=1695342174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8OCyMwZsvoOjP4kM1/XE5v2J6/7tL6Ih7ZBU/T91X0=;
 b=PfQu+DWCMmoq+JMGnAGVpHOzFQQi5u6gKcKvUcs2oFJnuprXcrbjgHUKBZ1QE92xGY
 MdhWORct6u9RXHnjnhiaDCHzlIClOdRYFAnS8nTJuho3GB25egyTRqnUReAqmV8H4J7k
 Bx8Fuz00adU9n6Z31Ket9jW7XdDHJ3DkBq+c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737374; x=1695342174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8OCyMwZsvoOjP4kM1/XE5v2J6/7tL6Ih7ZBU/T91X0=;
 b=O18JYaTZkaGT1qHlrrZDo2wrEHrPj6upytfCmKMaPDsGiAR/VJG1sZuiSV13QiHfEq
 fTGgbjNf3Lf4k/NS+V/RlRzNYNDwnVuIlyGuIXOomjOlTWBC4DqijaU5efEZMXq/oyeB
 kw5xius7ujrQbEwHCjC/W2OT7/hy4Vz1ioiKr9hEfzpheg9EE9SARscViOn/R5BayDyy
 xxVTOuSX/H0J8SbNWHgIfZot9F+GFHqbdMztRkwnhPGnLCa/HL6YaX518gLQ2WA/rO/f
 fPses5uwe8LCtBJjQMP7uetnvvoXJQl67NI2t+YUZi63ApY8d+xvCuoHgY7zqTufZwUy
 t7oA==
X-Gm-Message-State: AOJu0YzAaNl27OkC0IWYBxUCp8PKj6cYlk2UEkeCIPaJ9afKC0o1WWsg
 HS5S6J8LOWGrEzhzzpaJ6QSDYDo/H8ifBR86sXs=
X-Google-Smtp-Source: AGHT+IHmHJ8rhzzJ58H4eGykaWsar+345DmFLjycs4K4py5peiVZNm6z7WENltM5S16HrcX7mApS7A==
X-Received: by 2002:a05:6602:210f:b0:794:c9a2:5fe3 with SMTP id
 x15-20020a056602210f00b00794c9a25fe3mr61016iox.4.1694737374710; 
 Thu, 14 Sep 2023 17:22:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/27] moveconfig: Correct parameter-type warnings
Date: Thu, 14 Sep 2023 18:22:11 -0600
Message-ID: <20230915002236.798760-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Fix pylint warnings related to parameter types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 0b0ce64e81fe..689018d46d06 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -218,7 +218,7 @@ def read_file(fname, as_lines=True, skip_unicode=False):
 
     Args:
         fname (str): Filename to read from
-        as_lines: Return file contents as a list of lines
+        as_lines (bool): Return file contents as a list of lines
         skip_unicode (bool): True to report unicode errors and continue
 
     Returns:
@@ -434,7 +434,7 @@ class Slot:
         the slot is occupied (i.e. the current subprocess is still running).
 
         Args:
-          defconfig: defconfig name.
+          defconfig (str): defconfig name.
 
         Returns:
           Return True on success or False on failure
@@ -574,7 +574,7 @@ class Slot:
         """Display log along with progress and go to the idle state.
 
         Args:
-          success: Should be True when the defconfig was processed
+          success (bool): Should be True when the defconfig was processed
                    successfully, or False when it fails.
         """
         # output at least 30 characters to hide the "* defconfigs out of *".
@@ -628,7 +628,7 @@ class Slots:
         """Add a new subprocess if a vacant slot is found.
 
         Args:
-          defconfig: defconfig name to be put into.
+          defconfig (str): defconfig name to be put into.
 
         Returns:
           Return True on success or False on failure
@@ -717,9 +717,9 @@ def move_config(toolchains, args, db_queue):
     """Build database or sync config options to defconfig files.
 
     Args:
-      toolchains: Toolchains to use
-      args: Program arguments
-      db_queue: Queue for database updates
+      toolchains (Toolchains): Toolchains to use
+      args (Namespace): Program arguments
+      db_queue (Queue): Queue for database updates
     """
     if args.force_sync:
         print('Syncing defconfigs', end=' ')
@@ -761,10 +761,10 @@ def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
 
     Args:
-        kconf: Kconfiglib.Kconfig object
-        config: Name of config to check (without CONFIG_ prefix)
-        imply_config: Implying config (without CONFIG_ prefix) which may or
-            may not have an 'imply' for 'config')
+        kconf (Kconfiglib.Kconfig): Kconfig object
+        config (str): Name of config to check (without CONFIG_ prefix)
+        imply_config (str): Implying config (without CONFIG_ prefix) which may
+            or may not have an 'imply' for 'config')
 
     Returns:
         Symbol object for 'config' if found, else None
@@ -783,16 +783,17 @@ def check_imply_rule(kconf, config, imply_config):
     to add an 'imply' for 'config' to that part of the Kconfig.
 
     Args:
-        kconf: Kconfiglib.Kconfig object
-        config: Name of config to check (without CONFIG_ prefix)
-        imply_config: Implying config (without CONFIG_ prefix) which may or
-            may not have an 'imply' for 'config')
+        kconf (Kconfiglib.Kconfig): Kconfig object
+        config (str): Name of config to check (without CONFIG_ prefix)
+        imply_config (str): Implying config (without CONFIG_ prefix) which may
+            or may not have an 'imply' for 'config')
 
     Returns:
         tuple:
-            filename of Kconfig file containing imply_config, or None if none
-            line number within the Kconfig file, or 0 if none
-            message indicating the result
+            str: filename of Kconfig file containing imply_config, or None if
+                none
+            int: line number within the Kconfig file, or 0 if none
+            str: message indicating the result
     """
     sym = kconf.syms.get(imply_config)
     if not sym:
@@ -815,9 +816,9 @@ def add_imply_rule(config, fname, linenum):
     """Add a new 'imply' option to a Kconfig
 
     Args:
-        config: config option to add an imply for (without CONFIG_ prefix)
-        fname: Kconfig filename to update
-        linenum: Line number to place the 'imply' before
+        config (str): config option to add an imply for (without CONFIG_ prefix)
+        fname (str): Kconfig filename to update
+        linenum (int): Line number to place the 'imply' before
 
     Returns:
         Message indicating the result
-- 
2.42.0.459.ge4e396fd5e-goog

