Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F9CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A59708499C;
	Wed, 10 Jun 2026 16:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jGJ+zIjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFAD8495B; Wed, 10 Jun 2026 16:40:54 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A09849CB
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68c1f35b15dso900104a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102451; x=1781707251; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iI6beZOsyTufByuX53MxtqvHitgGFWlbfu4IeMVM95c=;
 b=jGJ+zIjp9ilQ8YHQ60UnW/cILDx8UcoU7ytOqHPEtg/VBpzLssM7VVsBMZGyBgv5Bg
 2O0+sGbukcuNis9P0Gx2aNvkOY+2+pVDKE8dpwFNM1/SrY94ctcNmTMQ/dtkXVOZcTio
 zMvYRY/1k8n3mjG8SdWlpFSY68Sb2AQHvdloKvNbHWnROj3JEosDdu+w7dkpY+V3MMS6
 LW6nNDBOg+Vd+IUbi5kiFULDU4fVDjRXzHRs8H9DJQntjkCAzfQkFX32khM7mXRoJza0
 AjkNQ4/mjiCgnXkz/KvuSmLIptPsanJVqJ8kt9QDTKplRAmugtvko1xvBc+Qr3HwUHPx
 A+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102451; x=1781707251;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iI6beZOsyTufByuX53MxtqvHitgGFWlbfu4IeMVM95c=;
 b=H0QFFjCYYdubBc8ymaobV9Wcl0eXwgueJ/oBCTdRa3HBIv/HvsOFuTxrZrKcsHTiYa
 43mVBjn7eW5h/orXFfHMct+JE1spYLX4lcRftZ11V2CK1heZYJsshYn4tnjM4vGXdYlr
 3NDbfLJ3HZ1Vjx5+txOOvIyuAeJbixfTitGSB1lheYwsHCf0LldO90R5HKBeK7DTmgO8
 PpqbjjEdwg0ZJTr5avZwEHmWJ8/PPnHWe6KB8GFg8EfhbaaquNijbCMdTMWDRxyZ3UTG
 I34W+/3pTbTWXY+Mw1RSPQA8vLb9+i3cmHa99oHmsi46zBskezzrX46V3Uy81iUPdvuL
 frtQ==
X-Gm-Message-State: AOJu0Yxtiq5xAUZRsLPUij7Ka/2wuJ5/jmJQY67G/WbAJ8drBImtMyQL
 hJ3WJZqs6WwhM7xg9RPYcERsbmENibgUg+CGGSm0WUmD3BcQyTIjudQA4yxocg==
X-Gm-Gg: Acq92OHag333eIKncTpEFWDAyF/0Q1RFRu5WqzZu9CS/yUCIVMwZvePzBJ1NJIzBVB/
 J2b9zO44XXUV954aTGYfyH+FpXxawFNtD0AHYleQM9IsGNMCU38V9GXy6PpEcFY2u1tGVTIIMHN
 yQ2n9ae8MFzBpxA6JD7rckjU/1IqaxaLCRMbZSCjJjul/8BgO8vVzXLn3pkQtN/zyLojxvoHcfO
 IE4HuaBsUFu+ibTxvG1kb+0E4s0ubtehxmhwi4aT5OKz1bM3gk5K5GMJt0AeLS2gzJvbQBG4xmS
 ZIMC7ciokQThQEScrFdEmG/O8QW88TnkW8pwoiacmi/ysgzkhUcoW5wbM/x21lIpBnbcNf5ceYJ
 V4eReqSyzmLhvYXTVxZdz2Qvly9NYtxLKiJ74QzXOLNHxWYRfWi/Csy0jXSe6xi62wkeJrGvOxy
 58dO0wlRV89mhNuY6nPmvmkRKIuq4dxqIYkq4eywx66RHioGplKB78gBlkTTT4LrNcWzbVs+9m
X-Received: by 2002:a05:6402:13d5:b0:691:af8c:7ac0 with SMTP id
 4fb4d7f45d1cf-69237747523mr2003807a12.1.1781102451250; 
 Wed, 10 Jun 2026 07:40:51 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-691afe82416sm4553462a12.13.2026.06.10.07.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:40:50 -0700 (PDT)
Message-ID: <6b62c5b0-1f0e-47af-96ca-9e221667234f@gmail.com>
Date: Wed, 10 Jun 2026 16:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 15/18] Kconfig: video: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "video":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/video/Kconfig          | 178 ++++++++++++++++-----------------
 drivers/video/bridge/Kconfig   |   4 +-
 drivers/video/imx/Kconfig      |   2 +-
 drivers/video/rockchip/Kconfig |   4 +-
 drivers/video/tegra/Kconfig    |  42 ++++----
 drivers/video/ti/Kconfig       |   2 +-
 drivers/video/zynqmp/Kconfig   |   6 +-
 7 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c0..497e8e2c2228 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -247,10 +247,10 @@ config SYS_WHITE_ON_BLACK
 	bool "Display console as white on a black background"
 	default y if ARCH_AT91 || ARCH_EXYNOS || ARCH_ROCKCHIP || ARCH_TEGRA || X86 || ARCH_SUNXI
 	help
-	 Normally the display is black on a white background, Enable this
-	 option to invert this, i.e. white on a black background. This can be
-	 better in low-light situations or to reduce eye strain in some
-	 cases.
+	  Normally the display is black on a white background, Enable this
+	  option to invert this, i.e. white on a black background. This can be
+	  better in low-light situations or to reduce eye strain in some
+	  cases.

 config NO_FB_CLEAR
 	bool "Skip framebuffer clear"
@@ -508,10 +508,10 @@ config FRAMEBUFFER_VESA_MODE

 config VIDEO_LCD_ANX9804
 	bool "ANX9804 bridge chip"
-	---help---
-	Support for the ANX9804 bridge chip, which can take pixel data coming
-	from a parallel LCD interface and translate it on the fy into a DP
-	interface for driving eDP TFT displays. It uses I2C for configuration.
+	help
+	  Support for the ANX9804 bridge chip, which can take pixel data coming
+	  from a parallel LCD interface and translate it on the fy into a DP
+	  interface for driving eDP TFT displays. It uses I2C for configuration.

 config ATMEL_LCD
 	bool "Atmel LCD panel support"
@@ -549,8 +549,8 @@ config VIDEO_LCD_HIMAX_HX8394
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Himax HX8394
-	dsi 4dl panel.
+	  Say Y here if you want to enable support for Himax HX8394
+	  dsi 4dl panel.

 config VIDEO_LCD_ILITEK_ILI9806E
 	bool "Ilitek ILI9806E-based panels"
@@ -574,15 +574,15 @@ config VIDEO_LCD_NOVATEK_NT35510
 	bool "Novatek NT35510 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Novatek nt35510
-	dsi panel.
+	  Say Y here if you want to enable support for Novatek nt35510
+	  dsi panel.

 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Orise Technology
-	otm8009a 480x800 dsi 2dl panel.
+	  Say Y here if you want to enable support for Orise Technology
+	  otm8009a 480x800 dsi 2dl panel.

 config VIDEO_LCD_LG_LD070WX3
 	bool "LD070WX3 DSI LCD panel support"
@@ -604,8 +604,8 @@ config VIDEO_LCD_RAYDIUM_RM68200
 	bool "RM68200 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Raydium RM68200
-	720x1280 DSI video mode panel.
+	  Say Y here if you want to enable support for Raydium RM68200
+	  720x1280 DSI video mode panel.

 config VIDEO_LCD_RENESAS_R61307
 	tristate "Renesas R61307 DSI video mode panel"
@@ -654,38 +654,38 @@ config VIDEO_LCD_SHARP_LQ101R1SX01

 config VIDEO_LCD_SSD2828
 	bool "SSD2828 bridge chip"
-	---help---
-	Support for the SSD2828 bridge chip, which can take pixel data coming
-	from a parallel LCD interface and translate it on the fly into MIPI DSI
-	interface for driving a MIPI compatible LCD panel. It uses SPI for
-	configuration.
+	help
+	  Support for the SSD2828 bridge chip, which can take pixel data coming
+	  from a parallel LCD interface and translate it on the fly into MIPI DSI
+	  interface for driving a MIPI compatible LCD panel. It uses SPI for
+	  configuration.

 config VIDEO_LCD_SSD2828_TX_CLK
 	int "SSD2828 TX_CLK frequency (in MHz)"
 	depends on VIDEO_LCD_SSD2828
 	default 0
-	---help---
-	The frequency of the crystal, which is clocking SSD2828. It may be
-	anything in the 8MHz-30MHz range and the exact value should be
-	retrieved from the board schematics. Or in the case of Allwinner
-	hardware, it can be usually found as 'lcd_xtal_freq' variable in
-	FEX files. It can be also set to 0 for selecting PCLK from the
-	parallel LCD interface instead of TX_CLK as the PLL clock source.
+	help
+	  The frequency of the crystal, which is clocking SSD2828. It may be
+	  anything in the 8MHz-30MHz range and the exact value should be
+	  retrieved from the board schematics. Or in the case of Allwinner
+	  hardware, it can be usually found as 'lcd_xtal_freq' variable in
+	  FEX files. It can be also set to 0 for selecting PCLK from the
+	  parallel LCD interface instead of TX_CLK as the PLL clock source.

 config VIDEO_LCD_SSD2828_RESET
 	string "RESET pin of SSD2828"
 	depends on VIDEO_LCD_SSD2828
 	default ""
-	---help---
-	The reset pin of SSD2828 chip. This takes a string in the format
-	understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.
+	help
+	  The reset pin of SSD2828 chip. This takes a string in the format
+	  understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_TDO_TL070WSH30
 	bool "TDO TL070WSH30 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for TDO TL070WSH30
-	1024x600 DSI video mode panel.
+	  Say Y here if you want to enable support for TDO TL070WSH30
+	  1024x600 DSI video mode panel.

 config VIDEO_LCD_HITACHI_TX10D07VM0BAA
 	tristate "Hitachi TX10D07VM0BAA 480x800 MIPI DSI video mode panel"
@@ -697,10 +697,10 @@ config VIDEO_LCD_HITACHI_TX10D07VM0BAA

 config VIDEO_LCD_HITACHI_TX18D42VM
 	bool "Hitachi tx18d42vm LVDS LCD panel support"
-	---help---
-	Support for Hitachi tx18d42vm LVDS LCD panels, these panels have a
-	lcd controller which needs to be initialized over SPI, once that is
-	done they work like a regular LVDS panel.
+	help
+	  Support for Hitachi tx18d42vm LVDS LCD panels, these panels have a
+	  lcd controller which needs to be initialized over SPI, once that is
+	  done they work like a regular LVDS panel.

 config VIDEO_LCD_SONY_L4F00430T01
 	tristate "Sony L4F00430T01 480x800 LCD panel support"
@@ -723,44 +723,44 @@ config VIDEO_LCD_SPI_CS
 	string "SPI CS pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
 	default ""
-	---help---
-	This is one of the SPI communication pins, involved in setting up a
-	working LCD configuration. The exact role of SPI may differ for
-	different hardware setups. The option takes a string in the format
-	understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.
+	help
+	  This is one of the SPI communication pins, involved in setting up a
+	  working LCD configuration. The exact role of SPI may differ for
+	  different hardware setups. The option takes a string in the format
+	  understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_SPI_SCLK
 	string "SPI SCLK pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
 	default ""
-	---help---
-	This is one of the SPI communication pins, involved in setting up a
-	working LCD configuration. The exact role of SPI may differ for
-	different hardware setups. The option takes a string in the format
-	understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.
+	help
+	  This is one of the SPI communication pins, involved in setting up a
+	  working LCD configuration. The exact role of SPI may differ for
+	  different hardware setups. The option takes a string in the format
+	  understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_SPI_MOSI
 	string "SPI MOSI pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
 	default ""
-	---help---
-	This is one of the SPI communication pins, involved in setting up a
-	working LCD configuration. The exact role of SPI may differ for
-	different hardware setups. The option takes a string in the format
-	understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.
+	help
+	  This is one of the SPI communication pins, involved in setting up a
+	  working LCD configuration. The exact role of SPI may differ for
+	  different hardware setups. The option takes a string in the format
+	  understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_SPI_MISO
 	string "SPI MISO pin for LCD related config job (optional)"
 	depends on VIDEO_LCD_SSD2828
 	default ""
-	---help---
-	This is one of the SPI communication pins, involved in setting up a
-	working LCD configuration. The exact role of SPI may differ for
-	different hardware setups. If wired up, this pin may provide additional
-	useful functionality. Such as bi-directional communication with the
-	hardware and LCD panel id retrieval (if the panel can report it). The
-	option takes a string in the format understood by 'sunxi_name_to_gpio'
-	function, e.g. PH1 for pin 1 of port H.
+	help
+	  This is one of the SPI communication pins, involved in setting up a
+	  working LCD configuration. The exact role of SPI may differ for
+	  different hardware setups. If wired up, this pin may provide additional
+	  useful functionality. Such as bi-directional communication with the
+	  hardware and LCD panel id retrieval (if the panel can report it). The
+	  option takes a string in the format understood by 'sunxi_name_to_gpio'
+	  function, e.g. PH1 for pin 1 of port H.

 source "drivers/video/meson/Kconfig"

@@ -768,9 +768,9 @@ config VIDEO_MVEBU
 	bool "Armada XP LCD controller"
 	depends on ARCH_MVEBU
 	imply VIDEO_DAMAGE
-	---help---
-	Support for the LCD controller integrated in the Marvell
-	Armada XP SoC.
+	help
+	  Support for the LCD controller integrated in the Marvell
+	  Armada XP SoC.

 config VIDEO_OMAP3
 	bool "Enable OMAP3+ DSS Support"
@@ -781,23 +781,23 @@ config VIDEO_OMAP3
 config I2C_EDID
 	bool "Enable EDID library"
 	help
-	   This enables library for accessing EDID data from an LCD panel.
+	  This enables library for accessing EDID data from an LCD panel.

 config I2C_EDID_STANDARD
 	bool "Enable standard timings EDID library expansion"
 	depends on I2C_EDID
 	help
-	   This enables standard timings expansion for EDID data from an LCD panel.
+	  This enables standard timings expansion for EDID data from an LCD panel.

 config DISPLAY
 	bool "Enable Display support"
 	depends on DM
 	select I2C_EDID
 	help
-	   This supports drivers that provide a display, such as eDP (Embedded
-	   DisplayPort) and HDMI (High Definition Multimedia Interface).
-	   The devices provide a simple interface to start up the display,
-	   read display information and enable it.
+	  This supports drivers that provide a display, such as eDP (Embedded
+	  DisplayPort) and HDMI (High Definition Multimedia Interface).
+	  The devices provide a simple interface to start up the display,
+	  read display information and enable it.

 config NXP_TDA19988
 	bool "Enable NXP TDA19988 support"
@@ -811,7 +811,7 @@ config ATMEL_HLCD
 	depends on ARCH_AT91
 	imply VIDEO_DAMAGE
 	help
-	   HLCDC supports video output to an attached LCD panel.
+	  HLCDC supports video output to an attached LCD panel.

 config BACKLIGHT_AAT2870
 	bool "Backlight Driver for AAT2870"
@@ -930,9 +930,9 @@ config VIDEO_NX
 	bool "Enable video support on Nexell SoC"
 	depends on ARCH_S5P6818 || ARCH_S5P4418
 	help
-	   Nexell SoC supports many video output options including eDP and
-	   HDMI. This option enables this support which can be used on devices
-	   which have an eDP display connected.
+	  Nexell SoC supports many video output options including eDP and
+	  HDMI. This option enables this support which can be used on devices
+	  which have an eDP display connected.

 config VIDEO_SEPS525
 	bool "Enable video support for Seps525"
@@ -1018,9 +1018,9 @@ config OSD
 	bool "Enable OSD support"
 	depends on DM
 	help
-	   This supports drivers that provide a OSD (on-screen display), which
-	   is a (usually text-oriented) graphics buffer to show information on
-	   a display.
+	  This supports drivers that provide a OSD (on-screen display), which
+	  is a (usually text-oriented) graphics buffer to show information on
+	  a display.

 config SANDBOX_OSD
 	bool "Enable sandbox OSD"
@@ -1213,10 +1213,10 @@ config SPL_SPLASH_SCREEN
 config SPL_SYS_WHITE_ON_BLACK
 	bool "Display console as white on a black background at SPL"
 	help
-	 Normally the display is black on a white background, Enable this
-	 option to invert this, i.e. white on a black background at spl stage.
-	 This can be better in low-light situations or to reduce eye strain in
-	 some cases.
+	  Normally the display is black on a white background, Enable this
+	  option to invert this, i.e. white on a black background at spl stage.
+	  This can be better in low-light situations or to reduce eye strain in
+	  some cases.

 config SPL_VIDEO_PCI_DEFAULT_FB_SIZE
 	hex "Default framebuffer size to use if no drivers request it at SPL"
@@ -1279,10 +1279,10 @@ config SPL_SIMPLE_PANEL
 config SPL_SYS_WHITE_ON_BLACK
 	bool "Display console as white on a black background at SPL"
 	help
-	 Normally the display is black on a white background, Enable this
-	 option to invert this, i.e. white on a black background at spl stage.
-	 This can be better in low-light situations or to reduce eye strain in
-	 some cases.
+	  Normally the display is black on a white background, Enable this
+	  option to invert this, i.e. white on a black background at spl stage.
+	  This can be better in low-light situations or to reduce eye strain in
+	  some cases.

 config SPL_VIDEO_REMOVE
 	bool "Remove video driver after SPL stage"
@@ -1408,11 +1408,11 @@ config SPL_VIDEO_BPP32
 	  will be empty.

 config SPL_HIDE_LOGO_VERSION
-    bool "Hide the version information on the splash screen at SPL"
-    help
-      Normally the U-Boot version string is shown on the display when the
-      splash screen is enabled. This information is not otherwise visible
-      since video starts up after U-Boot has displayed the initial banner.
+	bool "Hide the version information on the splash screen at SPL"
+	help
+	  Normally the U-Boot version string is shown on the display when the
+	  splash screen is enabled. This information is not otherwise visible
+	  since video starts up after U-Boot has displayed the initial banner.

       Enable this option to hide this information.
 endif
diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 5322a0029285..81261c610059 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -41,8 +41,8 @@ config VIDEO_BRIDGE_ANALOGIX_ANX6345
 	depends on VIDEO_BRIDGE
 	select DM_I2C
 	help
-	 The Analogix ANX6345 is RGB-to-DP converter. It enables an eDP LCD
-	 panel to be connected to an parallel LCD interface.
+	  The Analogix ANX6345 is RGB-to-DP converter. It enables an eDP LCD
+	  panel to be connected to an parallel LCD interface.

 config VIDEO_BRIDGE_SOLOMON_SSD2825
 	bool "Solomon SSD2825 bridge driver"
diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
index c25f209629ec..0c386595559b 100644
--- a/drivers/video/imx/Kconfig
+++ b/drivers/video/imx/Kconfig
@@ -20,7 +20,7 @@ config IPU_CLK_LEGACY
 	depends on VIDEO_IPUV3 && !CLK
 	default y
 	help
-	 Use legacy clock management instead of Common Clock Framework.
+	  Use legacy clock management instead of Common Clock Framework.

 config IMX_LDB
 	bool "Freescale i.MX8MP LDB bridge"
diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 96af6d28ef0b..41d249cb90c2 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -21,7 +21,7 @@ menuconfig VIDEO_ROCKCHIP
 	  Rockchip RK3288 and RK3399.

 config VIDEO_ROCKCHIP_MAX_XRES
-        int "Maximum horizontal resolution (for memory allocation purposes)"
+	int "Maximum horizontal resolution (for memory allocation purposes)"
 	depends on VIDEO_ROCKCHIP
 	default 3840 if DISPLAY_ROCKCHIP_HDMI
 	default 1920
@@ -31,7 +31,7 @@ config VIDEO_ROCKCHIP_MAX_XRES
 	  framebuffer during device-model binding/probing.

 config VIDEO_ROCKCHIP_MAX_YRES
-        int "Maximum vertical resolution (for memory allocation purposes)"
+	int "Maximum vertical resolution (for memory allocation purposes)"
 	depends on VIDEO_ROCKCHIP
 	default 2160 if DISPLAY_ROCKCHIP_HDMI
 	default 1080
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
index 8bc29f2838bd..125504024fcd 100644
--- a/drivers/video/tegra/Kconfig
+++ b/drivers/video/tegra/Kconfig
@@ -9,13 +9,13 @@ config VIDEO_TEGRA
 	depends on OF_CONTROL && ARCH_TEGRA
 	select HOST1X_TEGRA
 	help
-	   Enable support for Display Controller found in Tegra SoC. The
-	   Display Controller Complex integrates two independent display
-	   controllers. Each display controller is capable of interfacing
-	   to an external display device, which can be a parallel interface
-	   or SPI LCD, DVI, an HDMI HDTV, RGB monitor or a MIPI DSI LCD.
-	   Direct interface is supported directly to most LCD displays with
-	   TFT or TFT-like interface.
+	  Enable support for Display Controller found in Tegra SoC. The
+	  Display Controller Complex integrates two independent display
+	  controllers. Each display controller is capable of interfacing
+	  to an external display device, which can be a parallel interface
+	  or SPI LCD, DVI, an HDMI HDTV, RGB monitor or a MIPI DSI LCD.
+	  Direct interface is supported directly to most LCD displays with
+	  TFT or TFT-like interface.

 config VIDEO_DSI_TEGRA
 	bool "Enable DSI controller support on Tegra devices"
@@ -23,9 +23,9 @@ config VIDEO_DSI_TEGRA
 	select VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
-	   Enable support for the Display Serial Interface (DSI) found in
-	   Tegra SoC. It is a MIPI standard serial bitstream, intended to
-	   provide a low pin count interface to a display panel.
+	  Enable support for the Display Serial Interface (DSI) found in
+	  Tegra SoC. It is a MIPI standard serial bitstream, intended to
+	  provide a low pin count interface to a display panel.

 config VIDEO_HDMI_TEGRA
 	bool "Enable HDMI support on Tegra devices"
@@ -33,31 +33,31 @@ config VIDEO_HDMI_TEGRA
 	select I2C_EDID
 	select VIDEO_TEGRA
 	help
-	   Enable support for the High-Definition Multimedia Interface (HDMI)
-	   found in Tegra SoC.
+	  Enable support for the High-Definition Multimedia Interface (HDMI)
+	  found in Tegra SoC.

 config TEGRA_BACKLIGHT_PWM
 	bool "Enable Tegra DC PWM backlight support"
 	depends on BACKLIGHT && VIDEO_TEGRA
 	help
-	   Enable support for the Display Controller dependent PWM backlight
-	   found in the Tegra SoC and usually used with DSI panels.
+	  Enable support for the Display Controller dependent PWM backlight
+	  found in the Tegra SoC and usually used with DSI panels.

 config TEGRA_8BIT_CPU_BRIDGE
 	bool "Enable 8 bit panel communication protocol for Tegra 20/30"
 	depends on VIDEO_BRIDGE && DM_GPIO && VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
-	   Tegra 20 and Tegra 30 feature 8 bit CPU driver panel control
-	   protocol. This option allows use it as a MIPI DSI bridge to
-	   set up and control compatible panel.
+	  Tegra 20 and Tegra 30 feature 8 bit CPU driver panel control
+	  protocol. This option allows use it as a MIPI DSI bridge to
+	  set up and control compatible panel.

 config VIDEO_TEGRA124
 	bool "Enable video support on Tegra124"
 	depends on ARCH_TEGRA
 	imply VIDEO_DAMAGE
 	help
-	   Tegra124 supports many video output options including eDP and
-	   HDMI. At present only eDP is supported by U-Boot. This option
-	   enables this support which can be used on devices which
-	   have an eDP display connected.
+	  Tegra124 supports many video output options including eDP and
+	  HDMI. At present only eDP is supported by U-Boot. This option
+	  enables this support which can be used on devices which
+	  have an eDP display connected.
diff --git a/drivers/video/ti/Kconfig b/drivers/video/ti/Kconfig
index 0483f760ea19..a3cbefef0ded 100644
--- a/drivers/video/ti/Kconfig
+++ b/drivers/video/ti/Kconfig
@@ -6,4 +6,4 @@ config AM335X_LCD
 	bool "Enable AM335x video support"
 	depends on ARCH_OMAP2PLUS
 	help
-	   Supports video output to an attached LCD panel.
+	  Supports video output to an attached LCD panel.
diff --git a/drivers/video/zynqmp/Kconfig b/drivers/video/zynqmp/Kconfig
index b35cd1fb3429..2c7377106395 100644
--- a/drivers/video/zynqmp/Kconfig
+++ b/drivers/video/zynqmp/Kconfig
@@ -3,6 +3,6 @@ config VIDEO_ZYNQMP_DPSUB
 	bool "Enable video support for ZynqMP Display Port"
 	depends on ZYNQMP_POWER_DOMAIN
 	help
-	Enable support for Xilinx ZynqMP Display Port. Currently this file
-	is used as placeholder for driver. The main reason is to record
-	compatible string and calling power domain driver.
+	  Enable support for Xilinx ZynqMP Display Port. Currently this file
+	  is used as placeholder for driver. The main reason is to record
+	  compatible string and calling power domain driver.
--
2.39.5

