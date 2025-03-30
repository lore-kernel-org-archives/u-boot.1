Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78A2C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4512481F6B;
	Sun, 30 Mar 2025 11:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BAnhxuWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FEC817C4; Sun, 30 Mar 2025 11:36:20 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3626481E8C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac25520a289so591280366b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327378; x=1743932178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rg969Wc06fVpkNp8frlbO/T6tKY3KyJMDU22EdhcOk=;
 b=BAnhxuWY+2SINnBVgXtew9y1blF1ghdur9ZxJ43jdk3EAhcjXk22D6T4z+zJcjjqDA
 ONytPlCUgTHGgf+0zaXs2ZsyTaVDntf9/FLwApU3Vz/jNO2RkOW3na8nwiRua6wUrxsY
 Y/nndUbMNPHcjv+oc02Sorp1yn2oJsrikZRyHrh/DuBqI4Hox1AezJ+i6Yr9gs51950u
 J50TZzysXe8g9QzPDujZKWCrm+egYUykJHHwQDtSANt2UWhcjjJ2GrGW6LjuLikVbptk
 ZM1Cnlv3JJhleiI0ykGr2qqHa+i+IHvlv0P5dgztPB733mWnGiuEEQhn3n5UmVDRdMIk
 RSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327378; x=1743932178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rg969Wc06fVpkNp8frlbO/T6tKY3KyJMDU22EdhcOk=;
 b=GkS03Rk9e4HITy7lax9HzxnipwGz0B0y4CFGLsU3tatinzbu9TPIWsm8lmSB7tz/Us
 3cj1DUIwYX2ad9eFaUo8SwlV/GLGOYNiAhXKiMCbv3JzCOGjrCes1j+f8rdz7MWw8oMR
 RrdbQx64/Jc4d+gd5bG6AXQmAjwJi2XRjYHvbEZgrhgGvC6VSYur6ZM4ApAL+SXKQUu5
 ieeJgJ5Kk1TeSNxHDdU89nc8X8fGD4cqNoTRMDiMant9gqYZMR2Qv2UfrCg0/bHm32fk
 8e4+98FkJPHuFx3D6W1g/2zZ1aJCnd6AKxg4iPsnRZN66nDf5vOxZRQwOFiolcZ121Es
 ODhg==
X-Gm-Message-State: AOJu0YyNhDoSeMUBRIKTv3nZXsehQV2s+RbcKNhZQY58SdTfoQwkFC/A
 iHaf3ZSICM2ivrHIYRt62v/J+Xl5j2c2UKn3jQ7jjbDeaoyodYh8
X-Gm-Gg: ASbGncsFhqqwfuqwyQomKQFBiXmmE3wGVh6wYdlbkaS4XPhzguOFcCWcQBa5A2kxt5d
 IKnZgs1vhHWJ+Wbi8GI5GMQr3iMW/L/a6pnlgIntCzQVk/vMdjFsq0oe/la0Fbxe93Y+2uzBT3k
 hz7ycMdGW78EU54JDlyiprJZ47e9OAN5RpQ6bzf948NlXUf/+zQfflN4cAD+4i3Io2FJvSOv38p
 uYnTbUYmBf5/l8fw8WxnpHdbjTmpehZ9M1n1+GejFi50gCEiyPV5ACSz5/wjfmKXEJWz81OCQSB
 0q5sIrjNJXRIUzFc+qVR6wnljsv2XtY8chbe
X-Google-Smtp-Source: AGHT+IFDs9p4QxbirZ6q64lYW4REZ3InI63tYeStEs7S8RhMUlqEzBmCy1aptDVVxDRCCFQ+f6tc+Q==
X-Received: by 2002:a17:906:6a0e:b0:ac3:3fe8:df61 with SMTP id
 a640c23a62f3a-ac738c16128mr411326266b.57.1743327377501; 
 Sun, 30 Mar 2025 02:36:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971b7cfsm455273866b.183.2025.03.30.02.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:36:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, Thierry Reding <treding@nvidia.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] video: tegra: adjust DC and DSI config names
Date: Sun, 30 Mar 2025 12:36:00 +0300
Message-ID: <20250330093600.10871-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330093600.10871-1-clamor95@gmail.com>
References: <20250330093600.10871-1-clamor95@gmail.com>
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

Fix DC and DSI config names to reflect more generic nature of existing
Tegra video drivers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/toradex/colibri_t20/colibri_t20.c |  2 +-
 configs/endeavoru_defconfig             |  2 +-
 configs/grouper_defconfig               |  2 +-
 configs/harmony_defconfig               |  2 +-
 configs/ideapad-yoga-11_defconfig       |  2 +-
 configs/medcom-wide_defconfig           |  2 +-
 configs/mocha_defconfig                 |  2 +-
 configs/paz00_defconfig                 |  2 +-
 configs/picasso_defconfig               |  2 +-
 configs/qc750_defconfig                 |  2 +-
 configs/seaboard_defconfig              |  2 +-
 configs/surface-rt_defconfig            |  2 +-
 configs/tec_defconfig                   |  2 +-
 configs/transformer_t20_defconfig       |  2 +-
 configs/transformer_t30_defconfig       |  2 +-
 configs/ventana_defconfig               |  2 +-
 configs/x3_t30_defconfig                |  2 +-
 drivers/video/tegra/Kconfig             | 39 ++++++++++++++-----------
 drivers/video/tegra/Makefile            |  4 +--
 19 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibri_t20/colibri_t20.c
index 6425fa881ea..d432fd2b843 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -147,7 +147,7 @@ void pin_mux_usb(void)
 }
 #endif
 
-#ifdef CONFIG_VIDEO_TEGRA20
+#ifdef CONFIG_VIDEO_TEGRA
 /*
  * Routine: pin_mux_display
  * Description: setup the pin muxes/tristate values for the LCD interface)
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index fb3d7fc6238..c85994b44b8 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -83,5 +83,5 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_BRIDGE=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_VIDEO_LCD_ENDEAVORU=y
-CONFIG_VIDEO_DSI_TEGRA30=y
+CONFIG_VIDEO_DSI_TEGRA=y
 CONFIG_TEGRA_BACKLIGHT_PWM=y
diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index b98f23a4baf..016fc60b41a 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -88,4 +88,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x4e41
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_LOGO is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/harmony_defconfig b/configs/harmony_defconfig
index fa8fe24ca38..9fa9c12918b 100644
--- a/configs/harmony_defconfig
+++ b/configs/harmony_defconfig
@@ -64,5 +64,5 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_CONSOLE_SCROLL_LINES=10
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index bc7f615cdf0..b77110ed840 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -83,4 +83,4 @@ CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_VIDEO_BRIDGE_PARADE_DP501=y
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/medcom-wide_defconfig b/configs/medcom-wide_defconfig
index 737a0613ce1..d99addadf86 100644
--- a/configs/medcom-wide_defconfig
+++ b/configs/medcom-wide_defconfig
@@ -53,4 +53,4 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
index 0cbedb21797..55a0eb2948e 100644
--- a/configs/mocha_defconfig
+++ b/configs/mocha_defconfig
@@ -88,4 +88,4 @@ CONFIG_VIDEO_FONT_16X32=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01=y
 CONFIG_BACKLIGHT_LP855x=y
-CONFIG_VIDEO_DSI_TEGRA30=y
+CONFIG_VIDEO_DSI_TEGRA=y
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index b8645d66619..af2cb712e06 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -53,5 +53,5 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_I2C_EDID=y
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_CONSOLE_SCROLL_LINES=10
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index fe1eeb6ed10..6a83df919b5 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -81,4 +81,4 @@ CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_LOGO is not set
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index a42860dc9ba..9104cc084be 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -80,4 +80,4 @@ CONFIG_USB_GADGET=y
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_LOGO is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index eeb911a7805..21375f233f0 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -60,5 +60,5 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_CONSOLE_SCROLL_LINES=10
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index 24fca755dc5..da19b34e64a 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -79,4 +79,4 @@ CONFIG_USB_GADGET=y
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_LOGO is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/tec_defconfig b/configs/tec_defconfig
index 2f686105700..7cb13f9f5af 100644
--- a/configs/tec_defconfig
+++ b/configs/tec_defconfig
@@ -53,4 +53,4 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index 50b5885bb09..c934e1a2410 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -81,4 +81,4 @@ CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_LOGO is not set
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 3e2db0cb7d0..828634dc590 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -93,5 +93,5 @@ CONFIG_VIDEO=y
 CONFIG_VIDEO_BRIDGE=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_VIDEO_BRIDGE_TOSHIBA_TC358768=y
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_VIDEO_HDMI_TEGRA=y
diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
index c24fdcad533..3afa04dd10a 100644
--- a/configs/ventana_defconfig
+++ b/configs/ventana_defconfig
@@ -53,5 +53,5 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_CONSOLE_SCROLL_LINES=10
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index e738bd232d0..4252526992d 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -87,4 +87,4 @@ CONFIG_VIDEO_BRIDGE=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_BACKLIGHT_LM3533=y
 CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825=y
-CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_TEGRA=y
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
index 3d610036a1f..d3b8dbb2826 100644
--- a/drivers/video/tegra/Kconfig
+++ b/drivers/video/tegra/Kconfig
@@ -2,40 +2,45 @@ config HOST1X_TEGRA
 	bool "NVIDIA Tegra host1x BUS support"
 	depends on SIMPLE_BUS
 
-config VIDEO_TEGRA20
-	bool "Enable Display Controller support on Tegra20 and Tegra 30"
+config VIDEO_TEGRA
+	bool "Enable Display Controller support on Tegra devices"
 	depends on OF_CONTROL
 	select HOST1X_TEGRA
 	help
-	   T20/T30 support video output to an attached LCD panel as well as
-	   other options such as HDMI. Only the LCD is supported in U-Boot.
-	   This option enables this support which can be used on devices which
-	   have an LCD display connected.
+	   Enable support for Display Controller found in Tegra SoC. The
+	   Display Controller Complex integrates two independent display
+	   controllers. Each display controller is capable of interfacing
+	   to an external display device, which can be a parallel interface
+	   or SPI LCD, DVI, an HDMI HDTV, RGB monitor or a MIPI DSI LCD.
+	   Direct interface is supported directly to most LCD displays with
+	   TFT or TFT-like interface.
 
-config VIDEO_DSI_TEGRA30
-	bool "Enable Tegra 30 DSI support"
+config VIDEO_DSI_TEGRA
+	bool "Enable DSI controller support on Tegra devices"
 	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
-	select VIDEO_TEGRA20
+	select VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
-	   T30 has native support for DSI panels. This option enables support
-	   for such panels which can be used on endeavoru and tf600t.
+	   Enable support for the Display Serial Interface (DSI) found in
+	   Tegra SoC. It is a MIPI standard serial bitstream, intended to
+	   provide a low pin count interface to a display panel.
 
 config VIDEO_HDMI_TEGRA
-	bool "Enable Tegra HDMI support"
+	bool "Enable HDMI support on Tegra devices"
 	depends on VIDEO_BRIDGE && DM_I2C
 	select I2C_EDID
-	select VIDEO_TEGRA20
+	select VIDEO_TEGRA
 	help
-	   Tegra has native support for HDMI. This option enables support
-	   for such connection and can be used for any supported device.
+	   Enable support for the High-Definition Multimedia Interface (HDMI)
+	   found in Tegra SoC.
 
 config TEGRA_BACKLIGHT_PWM
 	bool "Enable Tegra DC PWM backlight support"
 	depends on BACKLIGHT
-	select VIDEO_TEGRA20
+	select VIDEO_TEGRA
 	help
-	   Tegra DC dependent backlight.
+	   Enable support for the Display Controller dependent PWM backlight
+	   found in the Tegra SoC and usually used with DSI panels.
 
 config VIDEO_TEGRA124
 	bool "Enable video support on Tegra124"
diff --git a/drivers/video/tegra/Makefile b/drivers/video/tegra/Makefile
index 4602b49ee73..3c50a0ba3c3 100644
--- a/drivers/video/tegra/Makefile
+++ b/drivers/video/tegra/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_HOST1X_TEGRA) += host1x.o
-obj-$(CONFIG_VIDEO_TEGRA20) += dc.o
-obj-$(CONFIG_VIDEO_DSI_TEGRA30) += dsi.o mipi.o mipi-phy.o
+obj-$(CONFIG_VIDEO_TEGRA) += dc.o
+obj-$(CONFIG_VIDEO_DSI_TEGRA) += dsi.o mipi.o mipi-phy.o
 obj-$(CONFIG_VIDEO_HDMI_TEGRA) += hdmi.o
 obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += dc-pwm-backlight.o
 
-- 
2.43.0

