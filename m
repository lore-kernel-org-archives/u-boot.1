Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E751AC35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDC181DF6;
	Sat, 22 Mar 2025 22:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tEE7LHK+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AJcGz/+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305C981A0E; Sat, 22 Mar 2025 22:56:55 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F335C819B1
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZKtSg54Fvz9sjB;
 Sat, 22 Mar 2025 22:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4LZ6GwqE5IuFWWxlBN/gKEaugFE9xsxua6TUY+y3wg=;
 b=tEE7LHK+nbJv8NX4b7iz3KqhsIf+xMjblxnEyzuG/lonEpfXILAjtpWy66wIrlM28AQV8B
 xvY/h2NEiGVhH9sjnsQXZGrYEBAMPXBBvmT/wDuUx1s8vK4evaBCd26VSDQZ9BPQt2h4p/
 C4Gnz1/ovmvisl8atJKjC4XWQ8qwjERC4AJ2czmjdWuhPCDrxyFg60oKDMqmmc6K5+s4IA
 heUhd3ZcBpAQDcZevCu3nBphj6vDOMdr0mXqxwTRLE7D4erCK6jIU1okprjvCMGaeePXgh
 llnBI3GIZosVAJTZBJXwuJM+A5aFshurMLdD5u5evf2EvuUmzI34kDxdtXkqNw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4LZ6GwqE5IuFWWxlBN/gKEaugFE9xsxua6TUY+y3wg=;
 b=AJcGz/+rA4MtDsTq8x2rxQc7Mfnb9Q7ryHouHabS3BOmgkIGbiAFyNWAWiT1qV7tLe2T7z
 P5bi4cZk55rHukTHkOAlE6i7bntDjI3Fvyog38/Ytvc6Az7PxtHi6aYMS9d1lM+t4Eehdx
 cdTABGT+zfKnUHn4SphjAk43UFS2aswwtM0ZIaHu1IPKZw/xKV6HeLcD9SnIZ2yhJLfnLD
 dedgdIKHkaGVBB9iMPRYkXEB660VWdpI5gyJvWgT6lzwfUyEv9/6dpv7KlWf7Z12TUmYI7
 qteKbZxLtMcsWoGhBnx3GJZjTLGPQyDzDw9Tu4HtcFp0uDRlsYrv/Lpqe3jk2A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] env: Rename DEFAULT_ENV_FILE to ENV_DEFAULT_ENV_TEXT_FILE
Date: Sat, 22 Mar 2025 22:55:27 +0100
Message-ID: <20250322215624.18994-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 685aebf41a8896f967f
X-MBO-RS-META: o8ekucbti986kwnmcizskskdxxbfp1eu
X-Rspamd-Queue-Id: 4ZKtSg54Fvz9sjB
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
 Makefile                  | 4 ++--
 boot/Kconfig              | 6 +++---
 configs/qcom_defconfig    | 4 ++--
 doc/usage/environment.rst | 4 ++--
 env/Kconfig               | 6 +++---
 include/env_default.h     | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index ea6ca427496..2bbf45c91fd 100644
--- a/Makefile
+++ b/Makefile
@@ -1967,7 +1967,7 @@ ifeq ($(wildcard $(LDSCRIPT)),)
 	@/bin/false
 endif
 
-ifeq ($(CONFIG_USE_DEFAULT_ENV_FILE),y)
+ifeq ($(CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE),y)
 prepare1: $(defaultenv_h)
 
 envtools: $(defaultenv_h)
@@ -2047,7 +2047,7 @@ $(timestamp_h): $(srctree)/Makefile FORCE
 $(dt_h): $(srctree)/Makefile FORCE
 	$(call filechk,dt.h)
 
-$(defaultenv_h): $(CONFIG_DEFAULT_ENV_FILE:"%"=%) FORCE
+$(defaultenv_h): $(CONFIG_ENV_DEFAULT_ENV_TEXT_FILE:"%"=%) FORCE
 	$(call filechk,defaultenv.h)
 
 # ---------------------------------------------------------------------------
diff --git a/boot/Kconfig b/boot/Kconfig
index c09a98c3233..5426594b5ca 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1846,7 +1846,7 @@ config USE_BOOTARGS
 
 config BOOTARGS
 	string "Boot arguments"
-	depends on USE_BOOTARGS && !USE_DEFAULT_ENV_FILE
+	depends on USE_BOOTARGS && !ENV_USE_DEFAULT_ENV_TEXT_FILE
 	help
 	  This can be used to pass arguments to the bootm command. The value of
 	  CONFIG_BOOTARGS goes into the environment value "bootargs". Note that
@@ -1881,7 +1881,7 @@ config USE_BOOTCOMMAND
 
 config BOOTCOMMAND
 	string "bootcmd value"
-	depends on USE_BOOTCOMMAND && !USE_DEFAULT_ENV_FILE
+	depends on USE_BOOTCOMMAND && !ENV_USE_DEFAULT_ENV_TEXT_FILE
 	default "bootflow scan -lb" if BOOTSTD_DEFAULTS && CMD_BOOTFLOW_FULL
 	default "bootflow scan" if BOOTSTD_DEFAULTS && !CMD_BOOTFLOW_FULL
 	default "run distro_bootcmd" if !BOOTSTD_BOOTCOMMAND && DISTRO_DEFAULTS
@@ -1904,7 +1904,7 @@ config USE_PREBOOT
 
 config PREBOOT
 	string "preboot default value"
-	depends on USE_PREBOOT && !USE_DEFAULT_ENV_FILE
+	depends on USE_PREBOOT && !ENV_USE_DEFAULT_ENV_TEXT_FILE
 	default "usb start" if USB_KEYBOARD
 	default ""
 	help
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 661a484f7bf..5685a8a275c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -41,8 +41,8 @@ CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
-CONFIG_USE_DEFAULT_ENV_FILE=y
-CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_STUB=y
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
index 19bc34f8663..d951ec190f7 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -711,7 +711,7 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
-config USE_DEFAULT_ENV_FILE
+config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
 	help
 	  Normally, the default environment is automatically generated
@@ -720,9 +720,9 @@ config USE_DEFAULT_ENV_FILE
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
index 83a715c74f7..e6e95184bad 100644
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

