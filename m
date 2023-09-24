Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FD8CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA34686AE9;
	Sun, 24 Sep 2023 22:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QjU2vReI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9438386A43; Sun, 24 Sep 2023 22:40:26 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD09869CD
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fa891b645so113498739f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588023; x=1696192823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuDP5Ve9G3OdUpfb+0nUqxiBd95vko0BAmsC5Ui4/Ys=;
 b=QjU2vReI3nCg5SMfZVyDv96gT8z1edrRgcZZNHHgy2gsRkd7ka8HKGk8Xnd6SVFDZX
 6NLSbi9h7mccw/WxCCOgF0gLsNvCi8YxqkHiBaaeJakstoeuKBBKG/tRYJ3bmeJjzk56
 r+Nwxt9Lvioebyv3T8dgttqOBaHjeB/Ctt2sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588023; x=1696192823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuDP5Ve9G3OdUpfb+0nUqxiBd95vko0BAmsC5Ui4/Ys=;
 b=gN2xYNhhP+6Jxp3DmfVyxiIWijakPzCi/VYvIDm7k/vBfn2NIr2viIRhB4qmCF4Qd0
 Xa35XypANm3+iJzQxUgXOxlXeEkDT2Wsgmrr5Dio64oAt7ZPhQ82VIIs1nL0pOdRu9ic
 UwwCNJ/m24NEybtIm9jTjjT3AA9q4Y5nYt/Kx80Nm5OCqzIsanlYVbX7uOJ9iK9ABI+n
 m+U096AFuyXs1XAYWvFeL6dJ/SFS+Jou94BsL9qp23aQ+1fmStPPh9hAl/WLTABq/2Ov
 Ld6e7+74tH96uQm+VriJlIgTaCf0JIxLm/A6LIAgrd3cKKL5diuVuReXfBVGPsur48t7
 zu3w==
X-Gm-Message-State: AOJu0YytuhdQstduNmhRESnk5JqryyB8m2H6yMEvf1yEPPxbLs2wvETu
 ubEfgr10H4a2x8CRLTERPXvumTg/esvlSZRbZcg=
X-Google-Smtp-Source: AGHT+IHnFEwTV7o7/+pwvbDnAgx+9quZ0sNY9yPtjOWGSROnVBEWimGKQ5cXBSx8jTAe5QmLXkYSVA==
X-Received: by 2002:a05:6602:1687:b0:79f:cd15:7d02 with SMTP id
 s7-20020a056602168700b0079fcd157d02mr1468622iow.17.1695588023098; 
 Sun, 24 Sep 2023 13:40:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/25] autoboot: Correct dependencies on CMDLINE
Date: Sun, 24 Sep 2023 14:39:21 -0600
Message-ID: <20230924203953.1829820-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

 boot/Kconfig | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f74ac7e9cc72..41ec2c34bf74 100644
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
@@ -1322,6 +1324,9 @@ config AUTOBOOT_STOP_STR_SHA256
 	  includes a ":", the portion prior to the ":" will be treated
 	  as a salt value.
 
+endif  # AUTOBOOT_KEYED
+endif  # AUTOBOOT
+
 config AUTOBOOT_USE_MENUKEY
 	bool "Allow a specify key to run a menu from the environment"
 	depends on !AUTOBOOT_KEYED
-- 
2.42.0.515.g380fc7ccd1-goog

