Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B564986F04;
	Tue, 17 Oct 2023 00:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VMqpE5CG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3C986E37; Tue, 17 Oct 2023 00:29:49 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B55786D18
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d093265dfso32824516d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495371; x=1698100171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZiJtMf2reKdxJGCOwFwNqlVMWJHI7ZB+dbbjKXubvY=;
 b=VMqpE5CGFfAF4xt+xI1nAvF6LkkXGQrP7WNb4VOobA6ZzFYujpESmfVT7pRM2u2zg7
 ZiZ7Oc2gkZbxs5ek9MkTydqDo447lghGjephFZRQClVpFT5HcYrcV5MjzlkRXNtq0Ib2
 Keia5Od2nWgxT/bAPfS+K6PrG8LfGGyTX5TsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495371; x=1698100171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZiJtMf2reKdxJGCOwFwNqlVMWJHI7ZB+dbbjKXubvY=;
 b=Gsj0y2IE8nPBfaO3G1tXuHUjJXX9yx4xRkh1iXq0AAAtSnqi4FyL/xo9B4gqhtDnUD
 jMrW1BnFcw24Gd1itO9x2+tZJ+4uP/xqFK+l9I2teHVIH3+J7KZL/MQj5krbukmDj0pM
 m8B/s14qNBuTpw9jIkm9ctwegcEnflBlnoq6QE5bVTmXuOITaWnhZN0qb4YIpbkVnSDp
 ImQRcj63lUx6Mf17KOO3vcuwZo4Ep9g6fi9W7pIxHWReAQduCeKm58E0y/2OTpodA2l8
 o2Nhnq0kSaqcYsvuui4zAywmG3KF3XH6XHWr5cITuTE/x/+nfKdzHS4f8EQ6siV5fyKg
 h+9g==
X-Gm-Message-State: AOJu0YxcNJeD4L17Hg0tGOVbhZtxrg2lNl9hA7H8Lq7fQcxX8tZ0riBf
 TAKcDY3HRJLEs+lEtYXXMLDHmjZdVVY3hTRx0sy5cg==
X-Google-Smtp-Source: AGHT+IHT+eZ9t69NaLuFkuGNBjvgucLAJdbk60HeFTsZjRs5Z8UcWqjRH0btR/q2NBCIomhQmekieg==
X-Received: by 2002:a05:6214:2a89:b0:66d:38e3:4ff7 with SMTP id
 jr9-20020a0562142a8900b0066d38e34ff7mr741053qvb.10.1697495371120; 
 Mon, 16 Oct 2023 15:29:31 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/32] autoboot: Correct dependencies on CMDLINE
Date: Mon, 16 Oct 2023 16:27:54 -0600
Message-ID: <20231016222835.596572-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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
2.42.0.655.g421f12c284-goog

