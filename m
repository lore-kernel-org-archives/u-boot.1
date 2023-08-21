Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC67BEE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63BC87082;
	Mon, 21 Aug 2023 15:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LXQ9F9oF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC358709F; Mon, 21 Aug 2023 15:51:58 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E5887094
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso19328245e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625915; x=1693230715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4KbQNgBgg/jRM/b8KJaE0YjvGZTzMRikT8MXE6mjwI=;
 b=LXQ9F9oF17Es3W44Ien7NWJ7ymwABfjmSOFUn1nlvsBdcyw9b3O/o8ulQCpUwqhXho
 Lsoff11Pmwlo87siidtGiRDX/BRiaZ8rBVWjS3jgK+U6RDPcwNCfR7otgNlLLaNyAd4w
 BCXHT1+90WvAX/9alOvPUYlvUkP1t/S15/C+bUJWxok5Nf6l5iGthuNMWvZFFiUdQ8yR
 02AJastvoFpsYlAJI+JY69q6OhIhuxvdeDVc81dEOKzKkkEOdENJDmT6pJI4fiWlgwEE
 iSJz97xC4lCSs+y5RPJTJfxE97zWwduKphPAN75dLRw0vnBYyqeXIo4ERx4uO7ku2jHf
 8feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625915; x=1693230715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4KbQNgBgg/jRM/b8KJaE0YjvGZTzMRikT8MXE6mjwI=;
 b=VOZaSadRyfgFoQTc22AZ+r/0BSY4/MskC2GhVnMFg1gAc1bBAg7PJOyNu3x0V3ICuX
 w68LWLVRLSaTmnF46xARtATTh8hJhyj7k3/oD4mNclUIyfmx/9vTSXJLn1MsG6m3TL8z
 l5QNyUjNlgAK+YeuYH6zQl/yp5lmAF4EaOg5ITz+eLN2lf10QPYS18/bVbvNQ0Q2cwIN
 FH+i7NhTRVoeExDFNVEFO11ZI3CJiAzpMC4WhI6OucHDWGIzEGcQKOYu9FfgwOfF5dVY
 Yc6qjX3w9zhbwV3LA/grMncdSA9joMxVkWJwvFFD+6AlVLgin7DH8EDaIOtENT/RD/qq
 Hjvw==
X-Gm-Message-State: AOJu0YyYX84n+767GB59OryFC5m/WbElRHO2Ix8D2HaL8Wnef45wnjme
 9nuXLuU5B1juuVwSn7QqTlnSVvjWNGQ=
X-Google-Smtp-Source: AGHT+IER2mHBuKBsYnQ3qf+DOtUzSQystkj8v17bWgFVK+zSLUhwLW9BOExvB2cO0RXSrx1vnjzR/w==
X-Received: by 2002:adf:e711:0:b0:317:e542:80a8 with SMTP id
 c17-20020adfe711000000b00317e54280a8mr4968619wrm.15.1692625915025; 
 Mon, 21 Aug 2023 06:51:55 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:54 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v5 13/13] video: Enable VIDEO_DAMAGE for drivers that need it
Date: Mon, 21 Aug 2023 16:51:10 +0300
Message-Id: <20230821135111.3558478-14-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
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

From: Alexander Graf <agraf@csgraf.de>

Some drivers call video_set_flush_dcache() to indicate that they want to
have the dcache flushed for the frame buffer. These drivers benefit from
our new video damage control, because we can reduce the amount of memory
that gets flushed significantly.

This patch enables video damage control for all device drivers that call
video_set_flush_dcache() to make sure they benefit from it.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
[Alper: Add to VIDEO_TIDSS, imply instead of select]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Imply VIDEO_DAMAGE for video drivers instead of selecting it
- Imply VIDEO_DAMAGE also for VIDEO_TIDSS

Changes in v4:
- Add patch "video: Enable VIDEO_DAMAGE for drivers that need it"

 arch/arm/mach-omap2/omap3/Kconfig | 1 +
 arch/arm/mach-sunxi/Kconfig       | 1 +
 drivers/video/Kconfig             | 8 ++++++++
 drivers/video/exynos/Kconfig      | 1 +
 drivers/video/imx/Kconfig         | 1 +
 drivers/video/meson/Kconfig       | 1 +
 drivers/video/rockchip/Kconfig    | 1 +
 drivers/video/stm32/Kconfig       | 1 +
 drivers/video/tegra20/Kconfig     | 1 +
 drivers/video/tidss/Kconfig       | 1 +
 10 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index 671e4791c67f..fd858f7b50f2 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -113,6 +113,7 @@ config TARGET_NOKIA_RX51
 	select CMDLINE_TAG
 	select INITRD_TAG
 	select REVISION_TAG
+	imply VIDEO_DAMAGE
 
 config TARGET_TAO3530
 	bool "TAO3530"
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 9d5df2c10273..fb4478ea32e8 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -813,6 +813,7 @@ config VIDEO_SUNXI
 	depends on !SUN50I_GEN_H6
 	select VIDEO
 	select DISPLAY
+	imply VIDEO_DAMAGE
 	imply VIDEO_DT_SIMPLEFB
 	default y
 	---help---
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index b3fbd9d7d9ca..185dbb1f8390 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -499,6 +499,7 @@ config VIDEO_LCD_ANX9804
 
 config ATMEL_LCD
 	bool "Atmel LCD panel support"
+	imply VIDEO_DAMAGE
 	depends on ARCH_AT91
 
 config ATMEL_LCD_BGR555
@@ -508,6 +509,7 @@ config ATMEL_LCD_BGR555
 
 config VIDEO_BCM2835
 	bool "Display support for BCM2835"
+	imply VIDEO_DAMAGE
 	help
 	  The graphics processor already sets up the display so this driver
 	  simply checks the resolution and then sets up the frame buffer with
@@ -654,6 +656,7 @@ source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
 	bool "Armada XP LCD controller"
+	imply VIDEO_DAMAGE
 	---help---
 	Support for the LCD controller integrated in the Marvell
 	Armada XP SoC.
@@ -688,6 +691,7 @@ config NXP_TDA19988
 
 config ATMEL_HLCD
 	bool "Enable ATMEL video support using HLCDC"
+	imply VIDEO_DAMAGE
 	help
 	   HLCDC supports video output to an attached LCD panel.
 
@@ -764,6 +768,7 @@ source "drivers/video/tidss/Kconfig"
 
 config VIDEO_TEGRA124
 	bool "Enable video support on Tegra124"
+	imply VIDEO_DAMAGE
 	help
 	   Tegra124 supports many video output options including eDP and
 	   HDMI. At present only eDP is supported by U-Boot. This option
@@ -778,6 +783,7 @@ source "drivers/video/imx/Kconfig"
 
 config VIDEO_MXS
 	bool "Enable video support on i.MX28/i.MX6UL/i.MX7 SoCs"
+	imply VIDEO_DAMAGE
 	help
 	  Enable framebuffer driver for i.MX28/i.MX6UL/i.MX7 processors
 
@@ -840,6 +846,7 @@ config VIDEO_DW_MIPI_DSI
 
 config VIDEO_SIMPLE
 	bool "Simple display driver for preconfigured display"
+	imply VIDEO_DAMAGE
 	help
 	  Enables a simple generic display driver which utilizes the
 	  simple-framebuffer devicetree bindings.
@@ -858,6 +865,7 @@ config VIDEO_DT_SIMPLEFB
 
 config VIDEO_MCDE_SIMPLE
 	bool "Simple driver for ST-Ericsson MCDE with preconfigured display"
+	imply VIDEO_DAMAGE
 	help
 	  Enables a simple display driver for ST-Ericsson MCDE
 	  (Multichannel Display Engine), which reads the configuration from
diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfig
index 599d19d5ecc2..a2cf752aac03 100644
--- a/drivers/video/exynos/Kconfig
+++ b/drivers/video/exynos/Kconfig
@@ -12,6 +12,7 @@ config EXYNOS_DP
 
 config EXYNOS_FB
 	bool "Exynos FIMD support"
+	imply VIDEO_DAMAGE
 
 config EXYNOS_MIPI_DSIM
 	bool "Exynos MIPI DSI support"
diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
index 34e8b640595b..5db3e5c0499e 100644
--- a/drivers/video/imx/Kconfig
+++ b/drivers/video/imx/Kconfig
@@ -2,6 +2,7 @@
 config VIDEO_IPUV3
 	bool "i.MX IPUv3 Core video support"
 	depends on VIDEO && (MX5 || MX6)
+	imply VIDEO_DAMAGE
 	help
 	  This enables framebuffer driver for i.MX processors working
 	  on the IPUv3(Image Processing Unit) internal graphic processor.
diff --git a/drivers/video/meson/Kconfig b/drivers/video/meson/Kconfig
index 3c2d72d019b8..fcf486ca0a3a 100644
--- a/drivers/video/meson/Kconfig
+++ b/drivers/video/meson/Kconfig
@@ -8,5 +8,6 @@ config VIDEO_MESON
 	bool "Enable Amlogic Meson video support"
 	depends on VIDEO
 	select DISPLAY
+	imply VIDEO_DAMAGE
 	help
 	  Enable Amlogic Meson Video Processing Unit video support.
diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 01804dcb1cc8..0f4550a29e38 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -11,6 +11,7 @@
 menuconfig VIDEO_ROCKCHIP
 	bool "Enable Rockchip Video Support"
 	depends on VIDEO
+	imply VIDEO_DAMAGE
 	help
 	  Rockchip SoCs provide video output capabilities for High-Definition
 	  Multimedia Interface (HDMI), Low-voltage Differential Signalling
diff --git a/drivers/video/stm32/Kconfig b/drivers/video/stm32/Kconfig
index 48066063e4c5..c354c402c288 100644
--- a/drivers/video/stm32/Kconfig
+++ b/drivers/video/stm32/Kconfig
@@ -8,6 +8,7 @@
 menuconfig VIDEO_STM32
 	bool "Enable STM32 video support"
 	depends on VIDEO
+	imply VIDEO_DAMAGE
 	help
 	  STM32 supports many video output options including RGB and
 	  DSI. This option enables these supports which can be used on
diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra20/Kconfig
index f5c4843e1191..2232b0b3ff53 100644
--- a/drivers/video/tegra20/Kconfig
+++ b/drivers/video/tegra20/Kconfig
@@ -1,6 +1,7 @@
 config VIDEO_TEGRA20
 	bool "Enable Display Controller support on Tegra20 and Tegra 30"
 	depends on OF_CONTROL
+	imply VIDEO_DAMAGE
 	help
 	   T20/T30 support video output to an attached LCD panel as well as
 	   other options such as HDMI. Only the LCD is supported in U-Boot.
diff --git a/drivers/video/tidss/Kconfig b/drivers/video/tidss/Kconfig
index 95086f3a5d66..3291b3ceb8d5 100644
--- a/drivers/video/tidss/Kconfig
+++ b/drivers/video/tidss/Kconfig
@@ -11,6 +11,7 @@
 menuconfig VIDEO_TIDSS
 	bool "Enable TIDSS video support"
 	depends on VIDEO
+	imply VIDEO_DAMAGE
 	help
 	  TIDSS supports  video output options LVDS and
 	  DPI . This option enables these supports which can be used on
-- 
2.40.1

