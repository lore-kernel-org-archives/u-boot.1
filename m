Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB0CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF79386F48;
	Tue, 17 Oct 2023 00:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vm8j2jpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6517486E7C; Tue, 17 Oct 2023 00:33:20 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8D586F38
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d1ef93284so27987986d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495555; x=1698100355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHJY0VPCR645CVpau8EtYSrLiLuHSgNRjiQaLHCkawY=;
 b=Vm8j2jpThT62v+5zV0chIH1tOqQs7tGgkcue5q9z1VCAcoW2DiKPU+4mq/de1wp2Wk
 cAAZZEIvPl2LCBfIDz2rSgSB7Zpboo3HE76MSfXi7RFYWE5BHFkF7eD+4nw5JCybCA9r
 3nRa+lfT0eluvMBZPW3H4mZIrlDqzHm78e9Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495555; x=1698100355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHJY0VPCR645CVpau8EtYSrLiLuHSgNRjiQaLHCkawY=;
 b=Z3MOBMKPNaqXP+nbpmZoMdRqtHyWkxazrcO0z+GPPxDJMzh9uLq3dAGw6ljRh2Q9DT
 XA9nrQVIWJZGSgTeOMN1ikrmKNC1sy2EgXZBqu1GCy+SP4x9ZfQr1w9UkyuE+7bivWah
 q/4e2yGryuIwh4g+K04V5+ISbyz6KGIFgDij00sjRYuUhZja0KuqSF7KncCbHL553hvD
 3sN2mqY5F2tHtJ17piyZM1nQlxtZBtFAv0kBgHwrYpmlGSANXTsWbjM6yY+FQMiA04vg
 IhNpzedR8vJClxuSqyev6gFpjH1GOpOjiQKcD0HYyrxGfUktvwz4EzDqDZDYl26Y7Vk0
 faAw==
X-Gm-Message-State: AOJu0Yy+4aZZ4CnorE8L9HSJ9iZl66kDzq2hqn2HQHYzva7GG8zm2Me8
 wip8KxGrYXaV5S6+nqTHSx8PeG1X2KXzdavA0zlv9w==
X-Google-Smtp-Source: AGHT+IG8rTn7OJoCmDvX90FaYMJQIPq5GEU3qXVVYQACBSUrXXSl/w5FKDCrJbbu5sEEtezKMf7iWA==
X-Received: by 2002:a05:6214:300a:b0:658:49bb:f78f with SMTP id
 ke10-20020a056214300a00b0065849bbf78fmr751549qvb.39.1697495555599; 
 Mon, 16 Oct 2023 15:32:35 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:32:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 26/32] sandbox: Disable CONFIG_DISTRO_DEFAULTS
Date: Mon, 16 Oct 2023 16:28:17 -0600
Message-ID: <20231016222835.596572-27-sjg@chromium.org>
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

This is not used for sandbox, so drop it. Enable the things that it
controls to avoid dstrastic changes in the config settings for
sandbox builds.

The end result is that these are enabled:

   BOOTMETH_DISTRO
   BOOTSTD_DEFAULTS

and these are disabled:

   USE_BOOTCOMMAND
   BOOTCOMMAND (was "run distro_bootcmd")
   DISTRO_DEFAULTS

Note that the tools-only build has already disabled DISTRO_DEFAULTS
and BOOTSTD_FULL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/Kconfig                       | 5 +++++
 boot/Kconfig                       | 6 +++---
 configs/sandbox64_defconfig        | 1 -
 configs/sandbox_defconfig          | 1 -
 configs/sandbox_flattree_defconfig | 1 -
 configs/sandbox_noinst_defconfig   | 1 -
 configs/sandbox_spl_defconfig      | 1 -
 configs/sandbox_vpl_defconfig      | 1 -
 8 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 19f2891ba1c5..64d0a5548942 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -208,6 +208,11 @@ config SANDBOX
 	imply PHYSMEM
 	imply GENERATE_ACPI_TABLE
 	imply BINMAN
+	imply SYSRESET_CMD_POWEROFF
+	imply SUPPORT_EXTENSION_SCAN
+	imply BOOTSTD_DEFAULTS if BOOTSTD_FULL && CMDLINE
+	imply BOOTMETH_DISTRO if BOOTSTD_FULL && CMDLINE
+	imply CMD_SYSBOOT if BOOTSTD_FULL
 
 config SH
 	bool "SuperH architecture"
diff --git a/boot/Kconfig b/boot/Kconfig
index e71de0647bc5..bab646bcac34 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -433,8 +433,8 @@ config BOOTSTD_FULL
 config BOOTSTD_DEFAULTS
 	bool "Select some common defaults for standard boot"
 	depends on BOOTSTD
-	imply USE_BOOTCOMMAND
-	select BOOT_DEFAULTS
+	imply USE_BOOTCOMMAND if !SANDBOX
+	select BOOT_DEFAULTS if CMDLINE
 	select BOOTMETH_DISTRO
 	help
 	  These are not required but are commonly needed to support a good
@@ -443,7 +443,7 @@ config BOOTSTD_DEFAULTS
 
 config BOOTSTD_BOOTCOMMAND
 	bool "Use bootstd to boot"
-	default y if !DISTRO_DEFAULTS
+	default y if !DISTRO_DEFAULTS && !SANDBOX
 	help
 	  Enable this to select a default boot-command suitable for booting
 	  with standard boot. This can be overridden by the board if needed,
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a033b22018b..ff895b930170 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -14,7 +14,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 47417cb0391d..5230b81be2c4 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -14,7 +14,6 @@ CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 29ae4532c508..8df2a82c521c 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -12,7 +12,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index d39e54f98d25..263cc013d68e 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -20,7 +20,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 4a67af2f088f..a84c6d2ba248 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -20,7 +20,6 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 8d76f19729b9..60fb1701708a 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -27,7 +27,6 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
-- 
2.42.0.655.g421f12c284-goog

