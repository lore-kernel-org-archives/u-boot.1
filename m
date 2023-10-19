Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B30CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF2987476;
	Thu, 19 Oct 2023 17:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qsj+RjkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFDA87436; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24508743F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7c95b8d14so103155887b3.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727681; x=1698332481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdtmRj74UXVK3HIryDZa/0xggu4HNjhJontGrzKLEEQ=;
 b=Qsj+RjkT4iS5EBjMuh1Wm+/3gfZRiWeBzAt1HoOnDuCzS9y59SaxpSJXB5NKVzHTUh
 iThToInH5fX21stgIDrTQhVHpyqJdltmWfW6lIZtvM5dWF6cmSXV8ZOBRVTv5RbX2UIA
 II2eYEjoBC0jW+5SNSpOZyzO0bjJM+6o97J4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727681; x=1698332481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdtmRj74UXVK3HIryDZa/0xggu4HNjhJontGrzKLEEQ=;
 b=q8PtJDJ6qxwceYhCbYqMQX0ZnWnykXKSlM8qXkVdRe+lTzrx2WkBzAdBYLHRCGuItr
 gKl6CmYL8qH0zt56COtsKtbrFb/e1/Cn5p1Dv2G0lfaSd38b5XgH2aJyfupTKkz7BZAk
 QvH44+6juNloMRjvEJ//IDmoWcKOY9/Ub9J/hy5/bXKtkyY8rC+z4wAUe6JPsm8hEgF9
 RCN9cq9BUI2nANZ7jhWknjAuv1BdVAivI1JwVnalDehGNdvKlixVfrPNJhwoQ9N+9huP
 3d4H1VCIIDvrY/4xj2NwgYJoPDI/gHxOzL9DfLnfJSntHuNrjsz7zqCM/YNrq/FFWUNy
 76uw==
X-Gm-Message-State: AOJu0Yw57C+WHRDhEhNVPVPyKduyj7L/w1G2XMZy86YwuKsZGmbZb2W8
 MmOvCFlLB/daEd0k5d1ayYiWQ4lRE7V5UwQdWH0zKg==
X-Google-Smtp-Source: AGHT+IEqtn9sVpZdoshePKgZ5aC/P4RbTg7/JN0Uvj5WnvDw5iCUJNCQgAKDjzkTLDBipRuuaxqvUw==
X-Received: by 2002:a81:7241:0:b0:599:b570:2db7 with SMTP id
 n62-20020a817241000000b00599b5702db7mr2741430ywc.30.1697727680966; 
 Thu, 19 Oct 2023 08:01:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4 13/24] autoboot: Correct dependencies on CMDLINE
Date: Thu, 19 Oct 2023 11:00:54 -0400
Message-Id: <20231019150105.714407-13-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Make AUTOBOOT depend on CMDLINE since it is mostly meaningless without it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e0ded3249343..0dbd10a93469 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1162,14 +1162,16 @@ menu "Autoboot options"
 
 config AUTOBOOT
 	bool "Autoboot"
+	depends on CMDLINE
 	default y
 	help
 	  This enables the autoboot.  See doc/README.autoboot for detail.
 
+if AUTOBOOT
+
 config BOOTDELAY
 	int "delay in seconds before automatically booting"
 	default 2
-	depends on AUTOBOOT
 	help
 	  Delay before automatically running bootcmd;
 	  set to 0 to autoboot with no delay, but you can stop it by key input.
@@ -1191,9 +1193,11 @@ config AUTOBOOT_KEYED
 	  U-Boot automatic booting process and bring the device
 	  to the U-Boot prompt for user input.
 
+if AUTOBOOT_KEYED
+
 config AUTOBOOT_FLUSH_STDIN
 	bool "Enable flushing stdin before starting to read the password"
-	depends on AUTOBOOT_KEYED && !SANDBOX
+	depends on !SANDBOX
 	help
 	  When this option is enabled stdin buffer will be flushed before
 	  starting to read the password.
@@ -1202,7 +1206,6 @@ config AUTOBOOT_FLUSH_STDIN
 
 config AUTOBOOT_PROMPT
 	string "Autoboot stop prompt"
-	depends on AUTOBOOT_KEYED
 	default "Autoboot in %d seconds\\n"
 	help
 	  This string is displayed before the boot delay selected by
@@ -1218,7 +1221,6 @@ config AUTOBOOT_PROMPT
 
 config AUTOBOOT_ENCRYPTION
 	bool "Enable encryption in autoboot stopping"
-	depends on AUTOBOOT_KEYED
 	help
 	  This option allows a string to be entered into U-Boot to stop the
 	  autoboot.
@@ -1245,7 +1247,7 @@ config AUTOBOOT_SHA256_FALLBACK
 
 config AUTOBOOT_DELAY_STR
 	string "Delay autobooting via specific input key / string"
-	depends on AUTOBOOT_KEYED && !AUTOBOOT_ENCRYPTION
+	depends on !AUTOBOOT_ENCRYPTION
 	help
 	  This option delays the automatic boot feature by issuing
 	  a specific input key or string. If CONFIG_AUTOBOOT_DELAY_STR
@@ -1257,7 +1259,7 @@ config AUTOBOOT_DELAY_STR
 
 config AUTOBOOT_STOP_STR
 	string "Stop autobooting via specific input key / string"
-	depends on AUTOBOOT_KEYED && !AUTOBOOT_ENCRYPTION
+	depends on !AUTOBOOT_ENCRYPTION
 	help
 	  This option enables stopping (aborting) of the automatic
 	  boot feature only by issuing a specific input key or
@@ -1269,7 +1271,7 @@ config AUTOBOOT_STOP_STR
 
 config AUTOBOOT_KEYED_CTRLC
 	bool "Enable Ctrl-C autoboot interruption"
-	depends on AUTOBOOT_KEYED && !AUTOBOOT_ENCRYPTION
+	depends on !AUTOBOOT_ENCRYPTION
 	help
 	  This option allows for the boot sequence to be interrupted
 	  by ctrl-c, in addition to the "bootdelaykey" and "bootstopkey".
@@ -1278,7 +1280,7 @@ config AUTOBOOT_KEYED_CTRLC
 
 config AUTOBOOT_NEVER_TIMEOUT
 	bool "Make the password entry never time-out"
-	depends on AUTOBOOT_KEYED && AUTOBOOT_ENCRYPTION && CRYPT_PW
+	depends on AUTOBOOT_ENCRYPTION && CRYPT_PW
 	help
 	  This option removes the timeout from the password entry
 	  when the user first presses the <Enter> key before entering
@@ -1286,7 +1288,7 @@ config AUTOBOOT_NEVER_TIMEOUT
 
 config AUTOBOOT_STOP_STR_ENABLE
 	bool "Enable fixed string to stop autobooting"
-	depends on AUTOBOOT_KEYED && AUTOBOOT_ENCRYPTION
+	depends on AUTOBOOT_ENCRYPTION
 	help
 	  This option enables the feature to add a fixed stop
 	  string that is defined at compile time.
@@ -1317,9 +1319,12 @@ config AUTOBOOT_STOP_STR_SHA256
 	  includes a ":", the portion prior to the ":" will be treated
 	  as a salt value.
 
+endif  # AUTOBOOT_KEYED
+
+if !AUTOBOOT_KEYED
+
 config AUTOBOOT_USE_MENUKEY
 	bool "Allow a specify key to run a menu from the environment"
-	depends on !AUTOBOOT_KEYED
 	help
 	  If a specific key is pressed to stop autoboot, then the commands in
 	  the environment variable 'menucmd' are executed before boot starts.
@@ -1334,6 +1339,10 @@ config AUTOBOOT_MENUKEY
 	  For example, 33 means "!" in ASCII, so pressing ! at boot would take
 	  this action.
 
+endif
+
+endif  # AUTOBOOT
+
 config AUTOBOOT_MENU_SHOW
 	bool "Show a menu on boot"
 	depends on CMD_BOOTMENU
-- 
2.34.1

