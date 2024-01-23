Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74581C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD54287DA0;
	Tue, 23 Jan 2024 18:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SklgdlUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3A187D54; Tue, 23 Jan 2024 18:17:11 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D69B87CA7
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so473518966b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030225; x=1706635025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tjdip6QRLOHoRLZQVFONHn4AuyM6OVXy1mU+IRFPxKI=;
 b=SklgdlUycH8gwGCAb8K7NXbqjo2rbCnbLWjW7hgOn2TZMXreZhkDS3oLWKXJDUwNv8
 XJ6sdTjR6Rd+aqmQMHi7BEqVFPdQV/BDCn5AiNGqC95iRZqEszk+XxL9HW9DT0iyWL2y
 n2K1G9ZnXbV+9pTTLWLMss3LNm6JQitoasLDHi5+QSCAhpIu4HaUkBV/NzEJ+L3Ez1rZ
 p5a5SPEY8rr1CCMf0mJR3dIpe7uQgwU7LbX0y83RABSlYgPQIHoVpkNu6uOnN30dYGzW
 x85Y8r+inP7vPZYEfNJia57e7mNuk5BxwfO9Ozh6nzt3K8MxKNyx1F9GhVrkXNZYyJRX
 iD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030225; x=1706635025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjdip6QRLOHoRLZQVFONHn4AuyM6OVXy1mU+IRFPxKI=;
 b=vZYrK1sMrHt+7r+ybz6196os6stuFlZgl6DT6rkN/tV9Dcc9OYlTgklDzO1PPpdGac
 2oJRqAuyS8y2rCbSAuzOOocWPYW6abnUKx5W/doDirWBaDTHen5ozThPpYfnhPDV7lYP
 af4s0nv5kTxzwOw/yZNBln5MyQfAmdkht34KDCYsz308qhhrTfe2mHRblgPWUhyqaGOA
 M2Bfkk6DhweRt4t09FJ2998MG/BSkX8fzsEky9oU/JWRxBtr40Hil1kSiSfhmr45bbWE
 IfymiT4C6KxDORt1oJsfZfx4p/0kPIfJYFCmzaHF3H/viY1wBpwR7i0jCqw9tJZ4rz4s
 tgMQ==
X-Gm-Message-State: AOJu0Yz6UuDla+tFwXKueRsmzk307o5kSeiVd9w1jDrmxTSHMWjRRB47
 XNKaKq0S1VzdCMgabWvNYGnzArwPDr40Mt8Skz5BBrWDjWmpgGWI
X-Google-Smtp-Source: AGHT+IGUmIXEGZ2HG40icOcx0azostbgvvDLKXXRnw5w4Tto75616sn/uBllTuP5HtEecoWCUcuFsQ==
X-Received: by 2002:a17:906:830a:b0:a2d:5f58:e7cd with SMTP id
 j10-20020a170906830a00b00a2d5f58e7cdmr61615ejx.105.1706030224969; 
 Tue, 23 Jan 2024 09:17:04 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 01/18] video: tegra20: dc: diverge DC per-SOC
Date: Tue, 23 Jan 2024 19:16:16 +0200
Message-Id: <20240123171633.246057-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

Diverge DC driver setup to better fit each of supported generations
of Tegra SOC.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra114-u-boot.dtsi            |  13 +++
 arch/arm/dts/tegra114.dtsi                   |   4 +-
 arch/arm/dts/tegra30-u-boot.dtsi             |   4 +
 arch/arm/dts/tegra30.dtsi                    |   2 +-
 arch/arm/include/asm/arch-tegra114/display.h |  28 +++++
 arch/arm/include/asm/arch-tegra114/pwm.h     |  13 +++
 drivers/video/tegra20/tegra-dc.c             | 107 +++++++++++++------
 7 files changed, 133 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/display.h
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h

diff --git a/arch/arm/dts/tegra114-u-boot.dtsi b/arch/arm/dts/tegra114-u-boot.dtsi
index 7c11972552..6a02714a25 100644
--- a/arch/arm/dts/tegra114-u-boot.dtsi
+++ b/arch/arm/dts/tegra114-u-boot.dtsi
@@ -1,3 +1,16 @@
 #include <config.h>
 
 #include "tegra-u-boot.dtsi"
+
+/ {
+	host1x@50000000 {
+		bootph-all;
+		dc@54200000 {
+			bootph-all;
+		};
+
+		dc@54240000 {
+			bootph-all;
+		};
+	};
+};
diff --git a/arch/arm/dts/tegra114.dtsi b/arch/arm/dts/tegra114.dtsi
index 68ee7f3165..250d692f6b 100644
--- a/arch/arm/dts/tegra114.dtsi
+++ b/arch/arm/dts/tegra114.dtsi
@@ -42,7 +42,7 @@
 		};
 
 		dc@54200000 {
-			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
+			compatible = "nvidia,tegra114-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA114_CLK_DISP1>,
@@ -61,7 +61,7 @@
 		};
 
 		dc@54240000 {
-			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
+			compatible = "nvidia,tegra114-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA114_CLK_DISP2>,
diff --git a/arch/arm/dts/tegra30-u-boot.dtsi b/arch/arm/dts/tegra30-u-boot.dtsi
index 3038227dbe..6a02714a25 100644
--- a/arch/arm/dts/tegra30-u-boot.dtsi
+++ b/arch/arm/dts/tegra30-u-boot.dtsi
@@ -8,5 +8,9 @@
 		dc@54200000 {
 			bootph-all;
 		};
+
+		dc@54240000 {
+			bootph-all;
+		};
 	};
 };
diff --git a/arch/arm/dts/tegra30.dtsi b/arch/arm/dts/tegra30.dtsi
index f198bc0edb..1177e2ab1f 100644
--- a/arch/arm/dts/tegra30.dtsi
+++ b/arch/arm/dts/tegra30.dtsi
@@ -158,7 +158,7 @@
 		};
 
 		dc@54200000 {
-			compatible = "nvidia,tegra30-dc", "nvidia,tegra20-dc";
+			compatible = "nvidia,tegra30-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
diff --git a/arch/arm/include/asm/arch-tegra114/display.h b/arch/arm/include/asm/arch-tegra114/display.h
new file mode 100644
index 0000000000..9411525799
--- /dev/null
+++ b/arch/arm/include/asm/arch-tegra114/display.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  (C) Copyright 2010
+ *  NVIDIA Corporation <www.nvidia.com>
+ */
+
+#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
+#define __ASM_ARCH_TEGRA_DISPLAY_H
+
+#include <asm/arch-tegra/dc.h>
+
+/* This holds information about a window which can be displayed */
+struct disp_ctl_win {
+	enum win_color_depth_id fmt;	/* Color depth/format */
+	unsigned int	bpp;		/* Bits per pixel */
+	phys_addr_t	phys_addr;	/* Physical address in memory */
+	unsigned int	x;		/* Horizontal address offset (bytes) */
+	unsigned int	y;		/* Veritical address offset (bytes) */
+	unsigned int	w;		/* Width of source window */
+	unsigned int	h;		/* Height of source window */
+	unsigned int	stride;		/* Number of bytes per line */
+	unsigned int	out_x;		/* Left edge of output window (col) */
+	unsigned int	out_y;		/* Top edge of output window (row) */
+	unsigned int	out_w;		/* Width of output window in pixels */
+	unsigned int	out_h;		/* Height of output window in pixels */
+};
+
+#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
diff --git a/arch/arm/include/asm/arch-tegra114/pwm.h b/arch/arm/include/asm/arch-tegra114/pwm.h
new file mode 100644
index 0000000000..af39151803
--- /dev/null
+++ b/arch/arm/include/asm/arch-tegra114/pwm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Tegra pulse width frequency modulator definitions
+ *
+ * Copyright (c) 2011 The Chromium OS Authors.
+ */
+
+#ifndef __ASM_ARCH_TEGRA114_PWM_H
+#define __ASM_ARCH_TEGRA114_PWM_H
+
+#include <asm/arch-tegra/pwm.h>
+
+#endif	/* __ASM_ARCH_TEGRA114_PWM_H */
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index f53ad46397..7605e77bc1 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <backlight.h>
 #include <dm.h>
 #include <fdtdec.h>
@@ -23,10 +22,15 @@
 #include <asm/arch/pinmux.h>
 #include <asm/arch/pwm.h>
 #include <asm/arch/display.h>
-#include <asm/arch-tegra/timer.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* Holder of Tegra per-SOC DC differences */
+struct tegra_dc_soc_info {
+	bool has_timer;
+	bool has_rgb;
+};
+
 /* Information about the display controller */
 struct tegra_lcd_priv {
 	int width;			/* width in pixels */
@@ -35,6 +39,7 @@ struct tegra_lcd_priv {
 	struct display_timing timing;
 	struct udevice *panel;
 	struct dc_ctlr *dc;		/* Display controller regmap */
+	const struct tegra_dc_soc_info *soc;
 	fdt_addr_t frame_buffer;	/* Address of frame buffer */
 	unsigned pixel_clock;		/* Pixel clock in Hz */
 	int dc_clk[2];			/* Contains clk and its parent */
@@ -43,8 +48,8 @@ struct tegra_lcd_priv {
 
 enum {
 	/* Maximum LCD size we support */
-	LCD_MAX_WIDTH		= 1920,
-	LCD_MAX_HEIGHT		= 1200,
+	LCD_MAX_WIDTH		= 2560,
+	LCD_MAX_HEIGHT		= 1600,
 	LCD_MAX_LOG2_BPP	= VIDEO_BPP16,
 };
 
@@ -110,9 +115,9 @@ static void update_window(struct tegra_lcd_priv *priv,
 	writel(val, &dc->cmd.state_ctrl);
 }
 
-static int update_display_mode(struct dc_disp_reg *disp,
-			       struct tegra_lcd_priv *priv)
+static int update_display_mode(struct tegra_lcd_priv *priv)
 {
+	struct dc_disp_reg *disp = &priv->dc->disp;
 	struct display_timing *dt = &priv->timing;
 	unsigned long val;
 	unsigned long rate;
@@ -128,14 +133,16 @@ static int update_display_mode(struct dc_disp_reg *disp,
 	       &disp->front_porch);
 	writel(dt->hactive.typ | (dt->vactive.typ << 16), &disp->disp_active);
 
-	val = DE_SELECT_ACTIVE << DE_SELECT_SHIFT;
-	val |= DE_CONTROL_NORMAL << DE_CONTROL_SHIFT;
-	writel(val, &disp->data_enable_opt);
+	if (priv->soc->has_rgb) {
+		val = DE_SELECT_ACTIVE << DE_SELECT_SHIFT;
+		val |= DE_CONTROL_NORMAL << DE_CONTROL_SHIFT;
+		writel(val, &disp->data_enable_opt);
 
-	val = DATA_FORMAT_DF1P1C << DATA_FORMAT_SHIFT;
-	val |= DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
-	val |= DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
-	writel(val, &disp->disp_interface_ctrl);
+		val = DATA_FORMAT_DF1P1C << DATA_FORMAT_SHIFT;
+		val |= DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
+		val |= DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
+		writel(val, &disp->disp_interface_ctrl);
+	}
 
 	/*
 	 * The pixel clock divider is in 7.1 format (where the bottom bit
@@ -147,7 +154,8 @@ static int update_display_mode(struct dc_disp_reg *disp,
 	div = ((rate * 2 + priv->pixel_clock / 2) / priv->pixel_clock) - 2;
 	debug("Display clock %lu, divider %lu\n", rate, div);
 
-	writel(0x00010001, &disp->shift_clk_opt);
+	if (priv->soc->has_rgb)
+		writel(0x00010001, &disp->shift_clk_opt);
 
 	val = PIXEL_CLK_DIVIDER_PCD1 << PIXEL_CLK_DIVIDER_SHIFT;
 	val |= div << SHIFT_CLK_DIVIDER_SHIFT;
@@ -174,6 +182,7 @@ static void basic_init(struct dc_cmd_reg *cmd)
 	writel(val, &cmd->disp_pow_ctrl);
 
 	val = readl(&cmd->disp_cmd);
+	val &= ~CTRL_MODE_MASK;
 	val |= CTRL_MODE_C_DISPLAY << CTRL_MODE_SHIFT;
 	writel(val, &cmd->disp_cmd);
 }
@@ -229,8 +238,8 @@ static void rgb_enable(struct dc_com_reg *com)
 		writel(rgb_sel_tab[i], &com->pin_output_sel[i]);
 }
 
-static int setup_window(struct disp_ctl_win *win,
-			struct tegra_lcd_priv *priv)
+static int setup_window(struct tegra_lcd_priv *priv,
+			struct disp_ctl_win *win)
 {
 	if (priv->rotation) {
 		win->x = priv->width * 2;
@@ -274,12 +283,11 @@ static int setup_window(struct disp_ctl_win *win,
  * You should pass in the U-Boot address here, and check the contents of
  * struct tegra_lcd_priv to see what was actually chosen.
  *
- * @param blob			Device tree blob
  * @param priv			Driver's private data
  * @param default_lcd_base	Default address of LCD frame buffer
  * Return: 0 if ok, -1 on error (unsupported bits per pixel)
  */
-static int tegra_display_probe(const void *blob, struct tegra_lcd_priv *priv,
+static int tegra_display_probe(struct tegra_lcd_priv *priv,
 			       void *default_lcd_base)
 {
 	struct disp_ctl_win window;
@@ -288,7 +296,7 @@ static int tegra_display_probe(const void *blob, struct tegra_lcd_priv *priv,
 	priv->frame_buffer = (u32)default_lcd_base;
 
 	/*
-	 * We halve the rate if DISP1 paret is PLLD, since actual parent
+	 * We halve the rate if DISP1 parent is PLLD, since actual parent
 	 * is plld_out0 which is PLLD divided by 2.
 	 */
 	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY)
@@ -303,13 +311,17 @@ static int tegra_display_probe(const void *blob, struct tegra_lcd_priv *priv,
 			       rate);
 
 	basic_init(&priv->dc->cmd);
-	basic_init_timer(&priv->dc->disp);
-	rgb_enable(&priv->dc->com);
+
+	if (priv->soc->has_timer)
+		basic_init_timer(&priv->dc->disp);
+
+	if (priv->soc->has_rgb)
+		rgb_enable(&priv->dc->com);
 
 	if (priv->pixel_clock)
-		update_display_mode(&priv->dc->disp, priv);
+		update_display_mode(priv);
 
-	if (setup_window(&window, priv))
+	if (setup_window(priv, &window))
 		return -1;
 
 	update_window(priv, &window);
@@ -322,7 +334,6 @@ static int tegra_lcd_probe(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct tegra_lcd_priv *priv = dev_get_priv(dev);
-	const void *blob = gd->fdt_blob;
 	int ret;
 
 	/* Initialize the Tegra display controller */
@@ -330,8 +341,8 @@ static int tegra_lcd_probe(struct udevice *dev)
 	funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
 #endif
 
-	if (tegra_display_probe(blob, priv, (void *)plat->base)) {
-		printf("%s: Failed to probe display driver\n", __func__);
+	if (tegra_display_probe(priv, (void *)plat->base)) {
+		debug("%s: Failed to probe display driver\n", __func__);
 		return -1;
 	}
 
@@ -383,6 +394,8 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	priv->soc = (struct tegra_dc_soc_info *)dev_get_driver_data(dev);
+
 	ret = clock_decode_pair(dev, priv->dc_clk);
 	if (ret < 0) {
 		debug("%s: Cannot decode clocks for '%s' (ret = %d)\n",
@@ -464,19 +477,43 @@ static int tegra_lcd_bind(struct udevice *dev)
 static const struct video_ops tegra_lcd_ops = {
 };
 
+static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
+	.has_timer = true,
+	.has_rgb = true,
+};
+
+static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
+	.has_timer = false,
+	.has_rgb = true,
+};
+
+static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
+	.has_timer = false,
+	.has_rgb = false,
+};
+
 static const struct udevice_id tegra_lcd_ids[] = {
-	{ .compatible = "nvidia,tegra20-dc" },
-	{ .compatible = "nvidia,tegra30-dc" },
-	{ }
+	{
+		.compatible = "nvidia,tegra20-dc",
+		.data = (ulong)&tegra20_dc_soc_info
+	}, {
+		.compatible = "nvidia,tegra30-dc",
+		.data = (ulong)&tegra30_dc_soc_info
+	}, {
+		.compatible = "nvidia,tegra114-dc",
+		.data = (ulong)&tegra114_dc_soc_info
+	}, {
+		/* sentinel */
+	}
 };
 
 U_BOOT_DRIVER(tegra_lcd) = {
-	.name	= "tegra_lcd",
-	.id	= UCLASS_VIDEO,
-	.of_match = tegra_lcd_ids,
-	.ops	= &tegra_lcd_ops,
-	.bind	= tegra_lcd_bind,
-	.probe	= tegra_lcd_probe,
+	.name		= "tegra_lcd",
+	.id		= UCLASS_VIDEO,
+	.of_match	= tegra_lcd_ids,
+	.ops		= &tegra_lcd_ops,
+	.bind		= tegra_lcd_bind,
+	.probe		= tegra_lcd_probe,
 	.of_to_plat	= tegra_lcd_of_to_plat,
 	.priv_auto	= sizeof(struct tegra_lcd_priv),
 };
-- 
2.40.1

