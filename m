Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B18BCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3ABE86B6D;
	Sat, 23 Sep 2023 21:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j4ZXDaqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFF38694A; Sat, 23 Sep 2023 21:44:41 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAF786B29
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so120881639f.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498278; x=1696103078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgCYT4XBf74RWpawUwrZ/2bCz4Wbk+l5ZUE0FaNKvek=;
 b=j4ZXDaqgtLjsaTVQRoHI3naftLVrqWgSq7VOpGmbDJjN5358YAE8k8Xxd3FnIg+OVS
 syh63Aurkxmi2bHuBrStAAh8BtnEyvnpWtOjQL8g0ExzGDei4S12w2lZ2jt4jynDTBQe
 aowjDYqY7YEcA0qwZPee53Kq+mfNMcluDSrxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498278; x=1696103078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgCYT4XBf74RWpawUwrZ/2bCz4Wbk+l5ZUE0FaNKvek=;
 b=OC6U8xlc5o9qz1fv+LpHR8WLEv40kUw1jf36pOGRgUDVJkoESXDMutCsPMycxZq/jl
 o7/AoS7QX2XE07q505HV7wGzzbSUDaWQ/bE92T+eFmbYcJxtUVdgGuCLOIy8b8GoIzeN
 HElAXIEaiuzTpYEQZq4FYlNfDVMcYKLI0DOT43XdLx9B5YGnafGmTL5nghb1EuXn9ILh
 3OA5CVY5KvWI3an62JDMkQcphxYmNsIWwDMMdZYhn/hw4SLMS6Dve+7hVtX9wS5tS5aq
 8XZmonXqsii86X9huKtxEF8Dsb2oRNNinPsxtUAisEf17vAF8ZmlPnpBnj2I7aCsrUXp
 wGyA==
X-Gm-Message-State: AOJu0Yxzs55TtBnXzxZq7mxApaKyaKtJCXCv+WMY10JPoqTQDtNkhtMJ
 oB+3ahI9aOtL7dA60OtvMLTPLR5raNAOKx//en8=
X-Google-Smtp-Source: AGHT+IG7k401SamF1Qp5dOowzjKhQBzYyFvYJgeWfgCFJaFJJ0i2Z1kS2yuKFxbaGao/H27n/DoeZA==
X-Received: by 2002:a05:6602:72d:b0:79f:ba15:6b9c with SMTP id
 g13-20020a056602072d00b0079fba156b9cmr945755iox.4.1695498277998; 
 Sat, 23 Sep 2023 12:44:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 09/27] moveconfig: Correct parameter-type warnings
Date: Sat, 23 Sep 2023 13:43:58 -0600
Message-ID: <20230923194424.1739224-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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
2.42.0.515.g380fc7ccd1-goog

