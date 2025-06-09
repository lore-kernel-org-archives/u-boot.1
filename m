Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39378C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C05A82C8D;
	Mon,  9 Jun 2025 21:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R7kRsDT+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hRvDZDJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A07382B20; Mon,  9 Jun 2025 21:27:31 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BA682C4C
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bGMPr5B87z9tH5;
 Mon,  9 Jun 2025 21:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3GgYgK/QB/xcOS1x+g/qTwGtMLHowYVm4wrn4Cm9lY=;
 b=R7kRsDT+43Aj3kAPX2xnUdfE71lH92mUdb4rK31KNiN+kNRx5nun8qeuTdGD++3NeUfG82
 5IKqcwMmmfMG8g7YK16zLNQmrFgCaSROBUpDRtBSrVpTPjQmqRuWphJTN1kBVnrX9a4yoU
 5K5gm/3xzS8lqtGMxVU84xf6i836jByRe+JdSFb+FAinprPQld5yowczENN8jDvHyVKSMr
 K/HXRHPSPZ5T4NjB5ujjAaP/przjmbsT4/UZALq43EpLsow0BXmZl4U6NTeDVqNBpNdRz/
 Oy+LTdZmO92HFcZoJEzw4tNoBfcfCYZ8VM/LBIk4R5GKXPb95CidbzYegy69Pg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3GgYgK/QB/xcOS1x+g/qTwGtMLHowYVm4wrn4Cm9lY=;
 b=hRvDZDJNpka1rVuR2jz07qfa2+0O9UFwtGWjO02D0ETZPRcmshWGR68Rvva+EgUfutaKSD
 HtA1iCAUU1ENhJBj01+0R6tD4d9QfeBgi36RQqFrLPi3+knOPR3j6xxx5HADakqwKzLrmy
 VSWedHZkAIN1TLcnayX2Db3E2BKuPU0z5A4o5JeprkZD9NOurEq0LEOXAFyGboC2MwSazL
 Rqb04gNwDYxJoNvW3L9IPrXhlhrt3zGaWZ0d3b3927fSRj1HB/MYlkKg4X5OePidSA9OoC
 rYGoBtmugXIHt19z8NeheiLViViOr+QkNv6dTHaLQXADl2qGRSMcEDARA4MJEg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/8] env: Rename DEFAULT_ENV_FILE to
 ENV_DEFAULT_ENV_TEXT_FILE
Date: Mon,  9 Jun 2025 21:26:42 +0200
Message-ID: <20250609192701.20260-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n8rzoqqbjqbr7e5xbbcx9e4iskq7hw3i
X-MBO-RS-ID: 050a5d0326bcf4f5b38
X-Rspamd-Queue-Id: 4bGMPr5B87z9tH5
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

Rename the variable and add ENV_ prefix, so that all configuration
options which are related to environment would have an CONFIG_ENV_
prefix. No functional change.

Also rename USE_DEFAULT_ENV_FILE to USE_ENV_DEFAULT_ENV_TEXT_FILE .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Rebase on u-boot/next
---
 Makefile                           | 4 ++--
 board/qualcomm/qcom-phone.config   | 2 +-
 boot/Kconfig                       | 6 +++---
 configs/qcom_defconfig             | 4 ++--
 configs/qcom_ipq9574_mmc_defconfig | 4 ++--
 doc/usage/environment.rst          | 4 ++--
 env/Kconfig                        | 6 +++---
 include/env_default.h              | 4 ++--
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index c7b82299c19..c9c0d4646a9 100644
--- a/Makefile
+++ b/Makefile
@@ -1973,7 +1973,7 @@ ifeq ($(wildcard $(LDSCRIPT)),)
 	@/bin/false
 endif
 
-ifeq ($(CONFIG_USE_DEFAULT_ENV_FILE),y)
+ifeq ($(CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE),y)
 prepare1: $(defaultenv_h)
 
 envtools: $(defaultenv_h)
@@ -2053,7 +2053,7 @@ $(timestamp_h): $(srctree)/Makefile FORCE
 $(dt_h): $(srctree)/Makefile FORCE
 	$(call filechk,dt.h)
 
-$(defaultenv_h): $(CONFIG_DEFAULT_ENV_FILE:"%"=%) FORCE
+$(defaultenv_h): $(CONFIG_ENV_DEFAULT_ENV_TEXT_FILE:"%"=%) FORCE
 	$(call filechk,defaultenv.h)
 
 # ---------------------------------------------------------------------------
diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
index 913c91757c1..d24094eefdd 100644
--- a/board/qualcomm/qcom-phone.config
+++ b/board/qualcomm/qcom-phone.config
@@ -1,5 +1,5 @@
 # Settings for phones
-CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/qcom-phone.env"
 # Hang on panic so the error message can be read
 CONFIG_PANIC_HANG=y
 # We use pause in various places to allow text to be read
diff --git a/boot/Kconfig b/boot/Kconfig
index 30eb5b328d7..01349e9096b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1845,7 +1845,7 @@ config USE_BOOTARGS
 
 config BOOTARGS
 	string "Boot arguments"
-	depends on USE_BOOTARGS && !USE_DEFAULT_ENV_FILE
+	depends on USE_BOOTARGS && !ENV_USE_DEFAULT_ENV_TEXT_FILE
 	help
 	  This can be used to pass arguments to the bootm command. The value of
 	  CONFIG_BOOTARGS goes into the environment value "bootargs". Note that
@@ -1880,7 +1880,7 @@ config USE_BOOTCOMMAND
 
 config BOOTCOMMAND
 	string "bootcmd value"
-	depends on USE_BOOTCOMMAND && !USE_DEFAULT_ENV_FILE
+	depends on USE_BOOTCOMMAND && !ENV_USE_DEFAULT_ENV_TEXT_FILE
 	default "bootflow scan -lb" if BOOTSTD_DEFAULTS && CMD_BOOTFLOW_FULL
 	default "bootflow scan" if BOOTSTD_DEFAULTS && !CMD_BOOTFLOW_FULL
 	default "run distro_bootcmd" if !BOOTSTD_BOOTCOMMAND && DISTRO_DEFAULTS
@@ -1903,7 +1903,7 @@ config USE_PREBOOT
 
 config PREBOOT
 	string "preboot default value"
-	depends on USE_PREBOOT && !USE_DEFAULT_ENV_FILE
+	depends on USE_PREBOOT && !ENV_USE_DEFAULT_ENV_TEXT_FILE
 	default "usb start" if USB_KEYBOARD
 	default ""
 	help
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..5eb027ba27b 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -42,8 +42,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
-CONFIG_USE_DEFAULT_ENV_FILE=y
-CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_STUB=y
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 8d7d3d92c73..c7ce4f5c237 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -28,8 +28,8 @@ CONFIG_CMD_PART=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_USE_DEFAULT_ENV_FILE=y
-CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
+CONFIG_USE_ENV_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ9574=y
 CONFIG_MSM_GPIO=y
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 7e2f2863d06..bb6c351b441 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -562,8 +562,8 @@ only effect after the next boot (yes, that's just like Windows).
 External environment file
 -------------------------
 
-The `CONFIG_USE_DEFAULT_ENV_FILE` option provides a way to bypass the
-environment generation in U-Boot. If enabled, then `CONFIG_DEFAULT_ENV_FILE`
+The `CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE` option provides a way to bypass the
+environment generation in U-Boot. If enabled, then `CONFIG_ENV_DEFAULT_ENV_TEXT_FILE`
 provides the name of a file which is converted into the environment,
 completely bypassing the standard environment variables in `env_default.h`.
 
diff --git a/env/Kconfig b/env/Kconfig
index 52f5cb86584..65ab8b6392d 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -749,7 +749,7 @@ config SCSI_ENV_PART_UUID
 	help
 	  UUID of the SCSI partition that you want to store the environment in.
 
-config USE_DEFAULT_ENV_FILE
+config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
 	help
 	  Normally, the default environment is automatically generated
@@ -758,9 +758,9 @@ config USE_DEFAULT_ENV_FILE
 	  you can instead define the entire default environment in an
 	  external file.
 
-config DEFAULT_ENV_FILE
+config ENV_DEFAULT_ENV_TEXT_FILE
 	string "Path to default environment file"
-	depends on USE_DEFAULT_ENV_FILE
+	depends on ENV_USE_DEFAULT_ENV_TEXT_FILE
 	help
 	  The path containing the default environment. The format is
 	  the same as accepted by the mkenvimage tool: lines
diff --git a/include/env_default.h b/include/env_default.h
index 6e8f2ea90e7..9caf22cdd1d 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -27,7 +27,7 @@ char default_environment[] = {
 #else
 const char default_environment[] = {
 #endif
-#ifndef CONFIG_USE_DEFAULT_ENV_FILE
+#ifndef CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE
 #ifdef	CONFIG_ENV_CALLBACK_LIST_DEFAULT
 	ENV_CALLBACK_VAR "=" CONFIG_ENV_CALLBACK_LIST_DEFAULT "\0"
 #endif
@@ -136,7 +136,7 @@ const char default_environment[] = {
 	"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
 #endif
 	"\0"
-#else /* CONFIG_USE_DEFAULT_ENV_FILE */
+#else /* CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE */
 #include "generated/defaultenv_autogenerated.h"
 #endif
 #ifdef DEFAULT_ENV_INSTANCE_EMBEDDED
-- 
2.47.2

