Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE373C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 14:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595AB810EA;
	Sun,  2 Mar 2025 15:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="N2kxxIC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC661810ED; Sun,  2 Mar 2025 15:53:21 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBC4806FC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1740927197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+kCpEiBBAtgdJhbj6t4tZZyiOCZxtvG/AtAM7K5TLVA=;
 b=N2kxxIC9W7o27mQMqwr4FjhaftbSXIqTYaiALsG4QsTpdOkOxUTePGK8yuIzIgd5VzBvPc
 6VozLDIFmRP355g9ko9212ScYLbR3RfwBiwkHJ+VXAYLzEmzYvT95ruhllP8Z7K8bKp+o4
 KJEfMnT/hIPGPScVfCNtur4h3boz6OaT9RjiC2QiP0PlvkJhZCSRfQ/ayw+IlIhD8rWDkF
 oPFs4NFB00qa1R30pfZqinlI+ZI/A8A0iHv0ueHB2swzA1rSYcimnbW+F+PaZ7m2ykH4vh
 mO+ey2LT0/3MgNfy1NVwX7gIqYGunJoJ7b3BlfKa8gRVdBRLN8Zd9UB1fukInA==
To: u-boot@lists.denx.de
Cc: marex@denx.de, clamor95@gmail.com, alexander.sverdlin@siemens.com,
 kever.yang@rock-chips.com, mkorpershoek@baylibre.com,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jenneron@protonmail.com,
 jonasschwoebel@yahoo.de, Anatolij Gustschin <agust@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] common: console: Delete obsolete VIDCONSOLE_AS_{LCD,
 NAME} options
Date: Sun,  2 Mar 2025 15:52:57 +0100
Message-Id: <bea64d2913c5c768989d7fcf5201449997187016.1740927024.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

The configuration options CONFIG_VIDCONSOLE_AS_LCD and CONFIG_VIDCONSOLE_AS_
NAME have been marked as obsolete and scheduled for deletion in late 2020.

That's already long overdue and the last remaining consumers of these options
have already migrated to using "vidconsole" in their "stdout" and "stderr"
environment variables, so let's delete these two configuration options.

Cc: Anatolij Gustschin <agust@denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Soeren Moch <smoch@web.de>
Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 common/console.c            | 11 -----------
 configs/peach-pi_defconfig  |  1 -
 configs/peach-pit_defconfig |  1 -
 configs/snow_defconfig      |  1 -
 configs/spring_defconfig    |  1 -
 configs/tbs2910_defconfig   |  1 -
 drivers/video/Kconfig       | 21 ---------------------
 7 files changed, 37 deletions(-)

diff --git a/common/console.c b/common/console.c
index 863ac6aa9dc4..26812b2ccbef 100644
--- a/common/console.c
+++ b/common/console.c
@@ -942,11 +942,6 @@ struct stdio_dev *console_search_dev(int flags, const char *name)
 	struct stdio_dev *dev;
 
 	dev = stdio_get_by_name(name);
-#ifdef CONFIG_VIDCONSOLE_AS_LCD
-	if (!dev && !strcmp(name, CONFIG_VIDCONSOLE_AS_NAME))
-		dev = stdio_get_by_name("vidconsole");
-#endif
-
 	if (dev && (dev->flags & flags))
 		return dev;
 
@@ -1154,12 +1149,6 @@ done:
 	if (!IS_ENABLED(CONFIG_SYS_CONSOLE_INFO_QUIET))
 		stdio_print_current_devices();
 
-#ifdef CONFIG_VIDCONSOLE_AS_LCD
-	if (strstr(stdoutname, CONFIG_VIDCONSOLE_AS_NAME))
-		printf("Warning: Please change '%s' to 'vidconsole' in stdout/stderr environment vars\n",
-		       CONFIG_VIDCONSOLE_AS_NAME);
-#endif
-
 	if (IS_ENABLED(CONFIG_SYS_CONSOLE_ENV_OVERWRITE)) {
 		/* set the environment variables (will overwrite previous env settings) */
 		for (i = 0; i < MAX_FILES; i++)
diff --git a/configs/peach-pi_defconfig b/configs/peach-pi_defconfig
index 594af5136e36..247df4c9036a 100644
--- a/configs/peach-pi_defconfig
+++ b/configs/peach-pi_defconfig
@@ -81,7 +81,6 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDCONSOLE_AS_LCD=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_EXYNOS=y
 CONFIG_EXYNOS_DP=y
diff --git a/configs/peach-pit_defconfig b/configs/peach-pit_defconfig
index 2b34c25556a5..df72be8047b5 100644
--- a/configs/peach-pit_defconfig
+++ b/configs/peach-pit_defconfig
@@ -80,7 +80,6 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDCONSOLE_AS_LCD=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_EXYNOS=y
 CONFIG_EXYNOS_DP=y
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 7a1dc80b1cc0..977e3298046a 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -96,7 +96,6 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDCONSOLE_AS_LCD=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_EXYNOS=y
 CONFIG_EXYNOS_DP=y
diff --git a/configs/spring_defconfig b/configs/spring_defconfig
index 43846e3cad9e..d3b6656d6312 100644
--- a/configs/spring_defconfig
+++ b/configs/spring_defconfig
@@ -92,7 +92,6 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDCONSOLE_AS_LCD=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_EXYNOS=y
 CONFIG_EXYNOS_DP=y
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index 99fe65d31098..c307d8c23d0d 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -110,7 +110,6 @@ CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP32 is not set
 CONFIG_SYS_WHITE_ON_BLACK=y
 # CONFIG_PANEL is not set
-CONFIG_VIDCONSOLE_AS_LCD=y
 CONFIG_I2C_EDID=y
 CONFIG_VIDEO_IPUV3=y
 CONFIG_IMX_VIDEO_SKIP=y
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c3cebaacd02..5fcbbd41e4a9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -293,27 +293,6 @@ config PANEL_HX8238D
 
 source "drivers/video/fonts/Kconfig"
 
-config VIDCONSOLE_AS_LCD
-	bool "Use 'vidconsole' when CONFIG_VIDCONSOLE_AS_NAME string is seen in stdout"
-	help
-	  This is a work-around for boards which have 'lcd' or 'vga' in their
-	  stdout environment variable, but have moved to use driver model for
-	  video. In this case the console will no-longer work. While it is
-	  possible to update the environment, the breakage may be confusing for
-	  users. This option will be removed around the end of 2020.
-
-config VIDCONSOLE_AS_NAME
-	string "Use 'vidconsole' when string defined here is seen in stdout"
-	depends on VIDCONSOLE_AS_LCD
-	default "lcd" if LCD || TEGRA_COMMON
-	default "vga" if !LCD
-	help
-	  This is a work-around for boards which have 'lcd' or 'vga' in their
-	  stdout environment variable, but have moved to use driver model for
-	  video. In this case the console will no-longer work. While it is
-	  possible to update the environment, the breakage may be confusing for
-	  users. This option will be removed around the end of 2020.
-
 config VIDEO_BOCHS
 	bool "Enable Bochs video emulation for QEMU"
 	help
