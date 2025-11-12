Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2508CD4841
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D068783D6C;
	Wed, 12 Nov 2025 21:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fj+jDv+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570FB83D6C; Wed, 12 Nov 2025 21:03:28 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F4C83D40
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3e12fd71984so780726fac.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977805; x=1763582605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iP/zfW7DBdKbuKl1imuFeCNV0fYIFEoczaJuBRBDLo=;
 b=Fj+jDv+FSv++vaeVIMk0T1eL5w6pz+8jH/RIwh7cipqlpTUfSN9c4kWUZ+zkfhZyhM
 ugwE5ROrSRaylKKTiMqMKKnxO2jlexInPfsav1V9rDDktAEiPZYSYvXfVXGQAaEAFrNj
 xObwbN2v7/ZKRygxlXyfHNVWcMy7rmSKJZSQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977805; x=1763582605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5iP/zfW7DBdKbuKl1imuFeCNV0fYIFEoczaJuBRBDLo=;
 b=GQJfyhVM8ZqoorrqSKpSIIt6k+NIqsxCWdTHevhBrdZuUDFOh1eKu9+JpT0B9qstwo
 Qj0j50wQF34vU0mbyTzuKuFaD2Ue1gkZ0PsUfMSSxbKq0dcPRLjTEtFgZI0CfgfNTWxm
 tIfvvw5RqUqT35mi197/06C46nLXkZB8mY6YUXmRJl8TiP7bWIqU94oMKZy6S8NQ2q9/
 8DXye261OBF1YKvgBvEEwR1w2/2/08yKbzA3knQpR8hGih2fCYIDNDsyJAj4u+29SrBY
 ZQlrIigYZ0eBLtaqPabjAPAsX7hI0sxgBPntT4TgxtDVhfajn0mdmgX0E6JOhgR+D79q
 VR3g==
X-Gm-Message-State: AOJu0YwSn78zn5pCnFgSQs7h2OLAa2S8pedJ8wCezZVaUpAHloCxEWic
 pkD1VkC3E/xTxy5NJQwFNqaF1as+1BfyncjjnHbKWvZ7XdrJQKYTKM+jpBfMgAyxszMVxipEcIP
 dZyXohhGbzQ==
X-Gm-Gg: ASbGncsiFdX2TotQwKnWIgwDv40WBC+AmK2xeTC8kZ8IARZjFkZ2Tmk0dbTaAWKL6Vy
 eanHE9DWJQ6v5awd2t9CGuaqOjyi2yzYPHf9SGZzbjKFIVmjUcoWvNiwg2Si12TWM/5V9KgTurl
 RufMeCgMpkqY2ZFZOrB/AUGBn5CpbYOGMmUR5OXq68bydV36Fbpsmp8GljHnhWiJQ1iruSQ74IH
 DghQVw7JUKomhgt1cmqiBH3wxadkHitfh7FUfJC5eZY/ev7JivRp3Zo3uxFZkT4FiaKp98aRKh/
 yfkTgNVLXNmJfOMmXd2twnjcB3X8aY4XosmgTbn1Hi+vcYpzQxtHIlxvLAsmPl5adPkB3ZE/a62
 NQqyXH119ZP3RRB6OMFzq/aYmT7fDaQXXcTWeodRgJO4GMSnEuBd2ql642WX/SAoTucD+3hiwja
 58GN6ZXaVBOFJVKroYUWRTMv64mzFj4yCksXOdoV3bZw==
X-Google-Smtp-Source: AGHT+IHyjMs+N8N8UFUhGfpLHfYji8I13VStVbXRObN4MVt1vLqomgGESDX6Dl67PatFjSnf2vsfig==
X-Received: by 2002:a05:6871:332a:b0:307:b1b1:aeb9 with SMTP id
 586e51a60fabf-3e834217b1dmr2341953fac.35.1762977804643; 
 Wed, 12 Nov 2025 12:03:24 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCHv2 3/7] video: Tighten some video driver dependencies
Date: Wed, 12 Nov 2025 14:00:04 -0600
Message-ID: <20251112200315.1111980-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
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

A few video drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/Kconfig          | 4 ++++
 drivers/video/bridge/Kconfig   | 2 +-
 drivers/video/exynos/Kconfig   | 2 +-
 drivers/video/imx/Kconfig      | 1 +
 drivers/video/meson/Kconfig    | 2 +-
 drivers/video/rockchip/Kconfig | 2 +-
 drivers/video/stm32/Kconfig    | 1 -
 drivers/video/ti/Kconfig       | 1 +
 8 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a12df55f84ff..0fc1c161541e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -523,6 +523,7 @@ config ATMEL_LCD_BGR555
 
 config VIDEO_BCM2835
 	bool "Display support for BCM2835"
+	depends on ARCH_BCM283X
 	imply VIDEO_DAMAGE
 	help
 	  The graphics processor already sets up the display so this driver
@@ -755,6 +756,7 @@ source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
 	bool "Armada XP LCD controller"
+	depends on ARCH_MVEBU
 	imply VIDEO_DAMAGE
 	---help---
 	Support for the LCD controller integrated in the Marvell
@@ -796,6 +798,7 @@ config NXP_TDA19988
 
 config ATMEL_HLCD
 	bool "Enable ATMEL video support using HLCDC"
+	depends on ARCH_AT91
 	imply VIDEO_DAMAGE
 	help
 	   HLCDC supports video output to an attached LCD panel.
@@ -907,6 +910,7 @@ source "drivers/video/imx/Kconfig"
 
 config VIDEO_MXS
 	bool "Enable video support on i.MX28/i.MX6UL/i.MX7 SoCs"
+	depends on MACH_IMX
 	imply VIDEO_DAMAGE
 	help
 	  Enable framebuffer driver for i.MX28/i.MX6UL/i.MX7 processors
diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index a48cec7a1384..5322a0029285 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -53,7 +53,7 @@ config VIDEO_BRIDGE_SOLOMON_SSD2825
 
 config VIDEO_BRIDGE_TOSHIBA_TC358768
 	bool "Support Toshiba TC358768 MIPI DSI bridge"
-	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO && !64BIT
 	select VIDEO_MIPI_DSI
 	select DM_I2C
 	help
diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfig
index a2cf752aac03..1fffec5c9c5e 100644
--- a/drivers/video/exynos/Kconfig
+++ b/drivers/video/exynos/Kconfig
@@ -1,7 +1,7 @@
 
 menuconfig VIDEO_EXYNOS
 	bool "Enable Exynos video support"
-	depends on VIDEO
+	depends on VIDEO && ARCH_EXYNOS
 	help
 	  Enable support for various video output options on Exynos SoCs.
 
diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
index 4a1927c66d7d..b35ba965efc3 100644
--- a/drivers/video/imx/Kconfig
+++ b/drivers/video/imx/Kconfig
@@ -23,3 +23,4 @@ config IMX_LDB
 
 config IMX_LCDIF
 	bool "i.MX LCDIFv3 LCD controller"
+	depends on MACH_IMX
diff --git a/drivers/video/meson/Kconfig b/drivers/video/meson/Kconfig
index fcf486ca0a3a..77c3017382eb 100644
--- a/drivers/video/meson/Kconfig
+++ b/drivers/video/meson/Kconfig
@@ -6,7 +6,7 @@
 
 config VIDEO_MESON
 	bool "Enable Amlogic Meson video support"
-	depends on VIDEO
+	depends on VIDEO && ARCH_MESON
 	select DISPLAY
 	imply VIDEO_DAMAGE
 	help
diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 0f4550a29e38..96af6d28ef0b 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -10,7 +10,7 @@
 
 menuconfig VIDEO_ROCKCHIP
 	bool "Enable Rockchip Video Support"
-	depends on VIDEO
+	depends on VIDEO && ARCH_ROCKCHIP
 	imply VIDEO_DAMAGE
 	help
 	  Rockchip SoCs provide video output capabilities for High-Definition
diff --git a/drivers/video/stm32/Kconfig b/drivers/video/stm32/Kconfig
index c354c402c288..ea4ce6799fda 100644
--- a/drivers/video/stm32/Kconfig
+++ b/drivers/video/stm32/Kconfig
@@ -7,7 +7,6 @@
 
 menuconfig VIDEO_STM32
 	bool "Enable STM32 video support"
-	depends on VIDEO
 	imply VIDEO_DAMAGE
 	help
 	  STM32 supports many video output options including RGB and
diff --git a/drivers/video/ti/Kconfig b/drivers/video/ti/Kconfig
index 3081e9e8c09b..0483f760ea19 100644
--- a/drivers/video/ti/Kconfig
+++ b/drivers/video/ti/Kconfig
@@ -4,5 +4,6 @@
 #
 config AM335X_LCD
 	bool "Enable AM335x video support"
+	depends on ARCH_OMAP2PLUS
 	help
 	   Supports video output to an attached LCD panel.
-- 
2.43.0

