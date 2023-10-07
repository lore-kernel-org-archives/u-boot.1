Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D464AE95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663CC86EE6;
	Sun,  8 Oct 2023 01:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHJuJ9/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E622186EFA; Sun,  8 Oct 2023 01:13:35 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A6486E08
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35133097583so13986755ab.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720388; x=1697325188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QlcfbZtbZxYHeF5PFWB9VyeGVxDvZaxkZrW7BG3QUo=;
 b=EHJuJ9/ZP39gVQrUrjWHFAcGxsV/nwFPdnFpRE7jlleFdmYOL6/LDaMfO0wVUvKZle
 hzV+ijT5/AsJHnLFkYiropMzlPfHEQszRcUUFpM6feQ287mosb0aPHoSZ4QFWhCy5K+D
 XKwdieiKKTxcX8Kk+mHUesKTDRS9rrYztvW0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720388; x=1697325188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QlcfbZtbZxYHeF5PFWB9VyeGVxDvZaxkZrW7BG3QUo=;
 b=VHDkp+aQmuCRfNR/7l4bvMn6NpSg5d2W3+nG+zMqK/Ot07LpwkSwuXlFlJbcosVfRb
 XM3oXxBYXxfozZSjubSbpjrAlG5FXK+ITVns8CRisBaalxoqptDhDK2qKzCDlAzs/GY0
 1oZb7HcfpGLJlMwFlgSXNTIt/g4AV/c71FFlTC+Y8W5+bbOT3FqpH0Iyynx1dz/IusXw
 JIRzRSJMB2XUOVefWpZ9HG13yNhNah+/BSR8Z8+AjmHjwZ6Aa5Pak2EazAXmrjYN/xp0
 vNKc/XA8KSnRwv320Nj5Uf+ryGlhSQUNB8jviqLr7IUIZiYmehURFFa3YVmEkmQ5bQ3c
 JHZg==
X-Gm-Message-State: AOJu0Yyafc0N415L91dcH6EInCzbrotRqUErlI5NG75VfQs+aMb2eGX/
 uhWQhRx6czCaDdAll30uQeEQXcx4IG/aLIoQd3o=
X-Google-Smtp-Source: AGHT+IF53EGebIhANc3181CttEL4RpE4Be4m4GDbt2WyMNLkTLMJsSGLKFLzGjRXoQ/qEGHdsvUkvA==
X-Received: by 2002:a92:c24b:0:b0:34f:c7f7:18b with SMTP id
 k11-20020a92c24b000000b0034fc7f7018bmr14951963ilo.2.1696720388567; 
 Sat, 07 Oct 2023 16:13:08 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/27] autoboot: Correct dependencies on CMDLINE
Date: Sat,  7 Oct 2023 17:12:24 -0600
Message-ID: <20231007231255.277623-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

Make AUTOBOOT depend on CMDLINE since it is mostly meaningless without it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Move AUTOBOOT_USE_MENUKEY under AUTOBOOT

 boot/Kconfig | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f74ac7e9cc72..6461f7ebd040 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1167,14 +1167,16 @@ menu "Autoboot options"
 
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
@@ -1196,9 +1198,11 @@ config AUTOBOOT_KEYED
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
@@ -1207,7 +1211,6 @@ config AUTOBOOT_FLUSH_STDIN
 
 config AUTOBOOT_PROMPT
 	string "Autoboot stop prompt"
-	depends on AUTOBOOT_KEYED
 	default "Autoboot in %d seconds\\n"
 	help
 	  This string is displayed before the boot delay selected by
@@ -1223,7 +1226,6 @@ config AUTOBOOT_PROMPT
 
 config AUTOBOOT_ENCRYPTION
 	bool "Enable encryption in autoboot stopping"
-	depends on AUTOBOOT_KEYED
 	help
 	  This option allows a string to be entered into U-Boot to stop the
 	  autoboot.
@@ -1250,7 +1252,7 @@ config AUTOBOOT_SHA256_FALLBACK
 
 config AUTOBOOT_DELAY_STR
 	string "Delay autobooting via specific input key / string"
-	depends on AUTOBOOT_KEYED && !AUTOBOOT_ENCRYPTION
+	depends on !AUTOBOOT_ENCRYPTION
 	help
 	  This option delays the automatic boot feature by issuing
 	  a specific input key or string. If CONFIG_AUTOBOOT_DELAY_STR
@@ -1262,7 +1264,7 @@ config AUTOBOOT_DELAY_STR
 
 config AUTOBOOT_STOP_STR
 	string "Stop autobooting via specific input key / string"
-	depends on AUTOBOOT_KEYED && !AUTOBOOT_ENCRYPTION
+	depends on !AUTOBOOT_ENCRYPTION
 	help
 	  This option enables stopping (aborting) of the automatic
 	  boot feature only by issuing a specific input key or
@@ -1274,7 +1276,7 @@ config AUTOBOOT_STOP_STR
 
 config AUTOBOOT_KEYED_CTRLC
 	bool "Enable Ctrl-C autoboot interruption"
-	depends on AUTOBOOT_KEYED && !AUTOBOOT_ENCRYPTION
+	depends on !AUTOBOOT_ENCRYPTION
 	help
 	  This option allows for the boot sequence to be interrupted
 	  by ctrl-c, in addition to the "bootdelaykey" and "bootstopkey".
@@ -1283,7 +1285,7 @@ config AUTOBOOT_KEYED_CTRLC
 
 config AUTOBOOT_NEVER_TIMEOUT
 	bool "Make the password entry never time-out"
-	depends on AUTOBOOT_KEYED && AUTOBOOT_ENCRYPTION && CRYPT_PW
+	depends on AUTOBOOT_ENCRYPTION && CRYPT_PW
 	help
 	  This option removes the timeout from the password entry
 	  when the user first presses the <Enter> key before entering
@@ -1291,7 +1293,7 @@ config AUTOBOOT_NEVER_TIMEOUT
 
 config AUTOBOOT_STOP_STR_ENABLE
 	bool "Enable fixed string to stop autobooting"
-	depends on AUTOBOOT_KEYED && AUTOBOOT_ENCRYPTION
+	depends on AUTOBOOT_ENCRYPTION
 	help
 	  This option enables the feature to add a fixed stop
 	  string that is defined at compile time.
@@ -1322,9 +1324,12 @@ config AUTOBOOT_STOP_STR_SHA256
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
@@ -1339,6 +1344,10 @@ config AUTOBOOT_MENUKEY
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
2.42.0.609.gbb76f46606-goog

