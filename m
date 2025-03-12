Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3097C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 17:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D52F81951;
	Wed, 12 Mar 2025 18:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1q1/7oL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748D08056A; Wed, 12 Mar 2025 18:59:27 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED408003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so22585666b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802364; x=1742407164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOMAZpw7TJhZunXEogYUGoblZuOnS2eVFiEMcKnk8Ls=;
 b=N1q1/7oLsB8jlcs6hf8LbhuF7/60cIVvVEtROvwNLnD7ByZJQZGbXkHL/ivfsxXkTv
 /hqJ9384Y77I+dKXXPBMsUGBtaXFNC6xdl7ZzbiI111DNakgkd0U76Nmf37lzov5zybX
 GwsAHnYwGyGb0naRVqDlG+vGIljENZq41u8NApZNwYTj8aGQsoBQJt7W7KCvRfymPItu
 Z4DJ5ME/tey/Idz4eLqQIoV4bmtA7L6iX7qTCCjfuoCWumq5HueYge7aGTJAdHip+0Dn
 k5aPBHbTgcwp7BJK9nrDqgS3wyJygUtGtDyAluS2UGNjgQILJCHlFnOCOBZvxI2JZiKf
 spvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802364; x=1742407164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOMAZpw7TJhZunXEogYUGoblZuOnS2eVFiEMcKnk8Ls=;
 b=Jql57hHMKXI8qqkGM8EYQJcRDbIVHZkPKOwH7dQxQBfCi/y9p42gwb2PeXR+VoPm+i
 sD+svmjFqbq8k6CbnDOTbcngP+sPoEO54Cg3N3ELdivVQS4Y/ywvQyx2AUiF16E9XfvF
 9vWtqb0ylj180FSVkpJ8gKc2vSR8ygoRWklucKH5FMXvngTPOrusyL85r+PgFN41Uvez
 V3KPT1UXWoZf/j8eKEpiMkG46V/qY+tlhIigvyGg8Ejq0auC+5Tco/dguW3a/+bwTGr/
 MKatfBy29fcvSsZ26uUdcO7DNnwF6ZvUpP30qxRI8QP1yKUM5rQ+VsSwZaeqaNIS4utP
 Ygug==
X-Gm-Message-State: AOJu0Yz9RrGek8wRoa+Xk4co/I1r5qF8qA//AKeT5ozrZjCQ1kcxfN7s
 SO5vqXDt8mSkjYGyZ9iscXTxpZUkeuqR31S+/nvk6ccfVH29CA/g
X-Gm-Gg: ASbGnct/kTOGARzT8Q1ck+5/xzSjilb252m9zVBZl/OtsrcCgp3OqtY2GbjOH2ACeHc
 Gs3u3bTNj/6MOy4XEw13xRt2FaDa/DfQQ0+DI/yTb3acIphLlwjs76DQUwpsyZmARiAOEINLLlt
 71Oqx3VzgM5IK4xcH4ap1IsnQbLsPMdeB2FEXO2mKayUBN2/2h7vQsxXHKvhaRKiTjIYdX+hGaF
 emD+/hNjihyBuE5nfh7+Z0htfDRR18FYtwtyv2xrRJRLGiK9x6mdygjsZYu+tJ/3i604sZsFSUE
 0wuvcHS1wfwNXRFrQIvXlYu4TcWBLuOynTjX
X-Google-Smtp-Source: AGHT+IGLNe+6jsDRfpE8/x7WKQiHG1CR5iqYRrqQgDYRf7txPQgZ73BHqLZW9AsZ0Lp8dQo0pXyHJA==
X-Received: by 2002:a17:907:34d5:b0:ac2:cdcb:6a85 with SMTP id
 a640c23a62f3a-ac2cdcb7301mr588148766b.22.1741802363048; 
 Wed, 12 Mar 2025 10:59:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 02/10] video: tegra20: provide driver support for the HDMI
 controller
Date: Wed, 12 Mar 2025 19:58:49 +0200
Message-ID: <20250312175857.120313-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tegra platforms feature native HDMI support. Implement a driver to enable
functionality. This driver will initially support Tegra 2 and 3, with
future extensibility.

Co-developed-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/dc.h |  46 +-
 drivers/video/tegra20/Kconfig        |   9 +
 drivers/video/tegra20/Makefile       |   1 +
 drivers/video/tegra20/tegra-hdmi.c   | 623 +++++++++++++++++++++++++
 drivers/video/tegra20/tegra-hdmi.h   | 652 +++++++++++++++++++++++++++
 5 files changed, 1328 insertions(+), 3 deletions(-)
 create mode 100644 drivers/video/tegra20/tegra-hdmi.c
 create mode 100644 drivers/video/tegra20/tegra-hdmi.h

diff --git a/arch/arm/include/asm/arch-tegra/dc.h b/arch/arm/include/asm/arch-tegra/dc.h
index ca3718411ab..2fd07403bdf 100644
--- a/arch/arm/include/asm/arch-tegra/dc.h
+++ b/arch/arm/include/asm/arch-tegra/dc.h
@@ -448,6 +448,11 @@ enum win_color_depth_id {
 #define LVS_OUTPUT_POLARITY_LOW		BIT(28)
 #define LSC0_OUTPUT_POLARITY_LOW	BIT(24)
 
+/* DC_DISP_DISP_SIGNAL_OPTIONS0 0x400 */
+#define H_PULSE0_ENABLE		BIT(8)
+#define H_PULSE1_ENABLE		BIT(10)
+#define H_PULSE2_ENABLE		BIT(12)
+
 /* DC_DISP_DISP_WIN_OPTIONS 0x402 */
 #define	CURSOR_ENABLE		BIT(16)
 #define	SOR_ENABLE		BIT(25)
@@ -504,6 +509,22 @@ enum {
 	DATA_ORDER_BLUE_RED,
 };
 
+/* DC_DISP_DISP_COLOR_CONTROL 0x430 */
+#define DITHER_CONTROL_DISABLE	(0 << 8)
+#define DITHER_CONTROL_ORDERED	(2 << 8)
+#define DITHER_CONTROL_ERRDIFF	(3 << 8)
+enum {
+	BASE_COLOR_SIZE_666,
+	BASE_COLOR_SIZE_111,
+	BASE_COLOR_SIZE_222,
+	BASE_COLOR_SIZE_333,
+	BASE_COLOR_SIZE_444,
+	BASE_COLOR_SIZE_555,
+	BASE_COLOR_SIZE_565,
+	BASE_COLOR_SIZE_332,
+	BASE_COLOR_SIZE_888,
+};
+
 /* DC_DISP_DATA_ENABLE_OPTIONS 0x432 */
 #define DE_SELECT_SHIFT		0
 #define DE_SELECT_MASK		(0x3 << DE_SELECT_SHIFT)
@@ -570,8 +591,27 @@ enum {
 #define V_DDA_INC_SHIFT		16
 #define V_DDA_INC_MASK		(0xFFFF << V_DDA_INC_SHIFT)
 
-#define DC_POLL_TIMEOUT_MS		50
-#define DC_N_WINDOWS			5
-#define DC_REG_SAVE_SPACE		(DC_N_WINDOWS + 5)
+#define DC_POLL_TIMEOUT_MS	50
+#define DC_N_WINDOWS		5
+#define DC_REG_SAVE_SPACE	(DC_N_WINDOWS + 5)
+
+#define PULSE_MODE_NORMAL	(0 << 3)
+#define PULSE_MODE_ONE_CLOCK	(1 << 3)
+#define PULSE_POLARITY_HIGH	(0 << 4)
+#define PULSE_POLARITY_LOW	(1 << 4)
+#define PULSE_QUAL_ALWAYS	(0 << 6)
+#define PULSE_QUAL_VACTIVE	(2 << 6)
+#define PULSE_QUAL_VACTIVE1	(3 << 6)
+#define PULSE_LAST_START_A	(0 << 8)
+#define PULSE_LAST_END_A	(1 << 8)
+#define PULSE_LAST_START_B	(2 << 8)
+#define PULSE_LAST_END_B	(3 << 8)
+#define PULSE_LAST_START_C	(4 << 8)
+#define PULSE_LAST_END_C	(5 << 8)
+#define PULSE_LAST_START_D	(6 << 8)
+#define PULSE_LAST_END_D	(7 << 8)
+
+#define PULSE_START(x)		(((x) & 0xfff) <<  0)
+#define PULSE_END(x)		(((x) & 0xfff) << 16)
 
 #endif /* __ASM_ARCH_TEGRA_DC_H */
diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra20/Kconfig
index d7c402e95fd..ce990b4481f 100644
--- a/drivers/video/tegra20/Kconfig
+++ b/drivers/video/tegra20/Kconfig
@@ -21,6 +21,15 @@ config VIDEO_DSI_TEGRA30
 	   T30 has native support for DSI panels. This option enables support
 	   for such panels which can be used on endeavoru and tf600t.
 
+config VIDEO_HDMI_TEGRA
+	bool "Enable Tegra HDMI support"
+	depends on VIDEO_BRIDGE && DM_I2C
+	select I2C_EDID
+	select VIDEO_TEGRA20
+	help
+	   Tegra has native support for HDMI. This option enables support
+	   for such connection and can be used for any supported device.
+
 config TEGRA_BACKLIGHT_PWM
 	bool "Enable Tegra DC PWM backlight support"
 	depends on BACKLIGHT
diff --git a/drivers/video/tegra20/Makefile b/drivers/video/tegra20/Makefile
index c0fd42a72d5..78521405749 100644
--- a/drivers/video/tegra20/Makefile
+++ b/drivers/video/tegra20/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_HOST1X_TEGRA) += tegra-host1x.o
 obj-$(CONFIG_VIDEO_TEGRA20) += tegra-dc.o
 obj-$(CONFIG_VIDEO_DSI_TEGRA30) += tegra-dsi.o tegra-mipi.o mipi-phy.o
+obj-$(CONFIG_VIDEO_HDMI_TEGRA) += tegra-hdmi.o
 obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += tegra-pwm-backlight.o
diff --git a/drivers/video/tegra20/tegra-hdmi.c b/drivers/video/tegra20/tegra-hdmi.c
new file mode 100644
index 00000000000..bda69919d92
--- /dev/null
+++ b/drivers/video/tegra20/tegra-hdmi.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2013 NVIDIA Corporation
+ * Copyright (c) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <edid.h>
+#include <i2c.h>
+#include <log.h>
+#include <misc.h>
+#include <panel.h>
+#include <reset.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/time.h>
+#include <power/regulator.h>
+#include <video_bridge.h>
+
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+
+#include "tegra-dc.h"
+#include "tegra-hdmi.h"
+
+#define DDCCI_ENTRY_ADDR	0x37
+#define DDCCI_SOURSE_ADDR	0x51
+#define DDCCI_COMMAND_WRITE	0x03
+#define DDCCI_CTRL_BRIGHTNESS	0x10
+
+#define HDMI_EDID_I2C_ADDR	0x50
+#define HDMI_REKEY_DEFAULT	56
+
+static const char * const hdmi_supplies[] = {
+	"hdmi-supply", "pll-supply", "vdd-supply"
+};
+
+struct tmds_config {
+	unsigned int pclk;
+	u32 pll0;
+	u32 pll1;
+	u32 pe_current;
+	u32 drive_current;
+	u32 peak_current;
+};
+
+struct tegra_hdmi_config {
+	const struct tmds_config *tmds;
+	unsigned int num_tmds;
+	unsigned int max_pclk;
+
+	/* to be filled */
+};
+
+struct tegra_hdmi_priv {
+	struct hdmi_ctlr *hdmi_regmap;
+
+	struct udevice *supplies[ARRAY_SIZE(hdmi_supplies)];
+	struct udevice *hdmi_ddc;
+
+	struct gpio_desc hpd; /* hotplug detection gpio */
+	struct display_timing timing;
+
+	struct clk *clk;
+	struct clk *clk_parent;
+
+	int panel_bits_per_colourp;
+	const struct tegra_hdmi_config *config;
+};
+
+/* 1280x720p 60hz: EIA/CEA-861-B Format 4 */
+static struct display_timing default_720p_timing = {
+	.pixelclock.typ		= 74250000,
+	.hactive.typ		= 1280,
+	.hfront_porch.typ	= 110,
+	.hback_porch.typ	= 220,
+	.hsync_len.typ		= 40,
+	.vactive.typ		= 720,
+	.vfront_porch.typ	= 5,
+	.vback_porch.typ	= 20,
+	.vsync_len.typ		= 5,
+	.flags			= DISPLAY_FLAGS_HSYNC_HIGH |
+				  DISPLAY_FLAGS_VSYNC_HIGH,
+};
+
+static const struct tmds_config tegra20_tmds_config[] = {
+	{ /* slow pixel clock modes */
+		.pclk = 27000000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(0) |
+			SOR_PLL_TX_REG_LOAD(3),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE,
+		.pe_current = PE_CURRENT0(PE_CURRENT_0_0_mA) |
+			PE_CURRENT1(PE_CURRENT_0_0_mA) |
+			PE_CURRENT2(PE_CURRENT_0_0_mA) |
+			PE_CURRENT3(PE_CURRENT_0_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_7_125_mA),
+	},
+	{ /* high pixel clock modes */
+		.pclk = UINT_MAX,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(1) |
+			SOR_PLL_TX_REG_LOAD(3),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_6_0_mA) |
+			PE_CURRENT1(PE_CURRENT_6_0_mA) |
+			PE_CURRENT2(PE_CURRENT_6_0_mA) |
+			PE_CURRENT3(PE_CURRENT_6_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_7_125_mA),
+	},
+};
+
+static const struct tmds_config tegra30_tmds_config[] = {
+	{ /* 480p modes */
+		.pclk = 27000000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(0) |
+			SOR_PLL_TX_REG_LOAD(0),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE,
+		.pe_current = PE_CURRENT0(PE_CURRENT_0_0_mA) |
+			PE_CURRENT1(PE_CURRENT_0_0_mA) |
+			PE_CURRENT2(PE_CURRENT_0_0_mA) |
+			PE_CURRENT3(PE_CURRENT_0_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_5_250_mA),
+	}, { /* 720p modes */
+		.pclk = 74250000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(1) |
+			SOR_PLL_TX_REG_LOAD(0),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_5_0_mA) |
+			PE_CURRENT1(PE_CURRENT_5_0_mA) |
+			PE_CURRENT2(PE_CURRENT_5_0_mA) |
+			PE_CURRENT3(PE_CURRENT_5_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_5_250_mA),
+	}, { /* 1080p modes */
+		.pclk = UINT_MAX,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(3) |
+			SOR_PLL_TX_REG_LOAD(0),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_5_0_mA) |
+			PE_CURRENT1(PE_CURRENT_5_0_mA) |
+			PE_CURRENT2(PE_CURRENT_5_0_mA) |
+			PE_CURRENT3(PE_CURRENT_5_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_5_250_mA),
+	},
+};
+
+static void tegra_dc_enable_controller(struct udevice *dev)
+{
+	struct tegra_dc_plat *dc_plat = dev_get_plat(dev);
+	struct dc_ctlr *dc = dc_plat->dc;
+	u32 value;
+
+	value = readl(&dc->disp.disp_win_opt);
+	value |= HDMI_ENABLE;
+	writel(value, &dc->disp.disp_win_opt);
+
+	writel(GENERAL_UPDATE, &dc->cmd.state_ctrl);
+	writel(GENERAL_ACT_REQ, &dc->cmd.state_ctrl);
+}
+
+static void tegra_hdmi_setup_tmds(struct tegra_hdmi_priv *priv,
+				  const struct tmds_config *tmds)
+{
+	struct hdmi_ctlr *hdmi = priv->hdmi_regmap;
+	u32 value;
+
+	writel(tmds->pll0, &hdmi->nv_pdisp_sor_pll0);
+	writel(tmds->pll1, &hdmi->nv_pdisp_sor_pll1);
+	writel(tmds->pe_current, &hdmi->nv_pdisp_pe_current);
+
+	writel(tmds->drive_current, &hdmi->nv_pdisp_sor_lane_drive_current);
+
+	value = readl(&hdmi->nv_pdisp_sor_lane_drive_current);
+	value |= BIT(31);
+	writel(value, &hdmi->nv_pdisp_sor_lane_drive_current);
+}
+
+static int tegra_hdmi_encoder_enable(struct udevice *dev)
+{
+	struct tegra_dc_plat *dc_plat = dev_get_plat(dev);
+	struct tegra_hdmi_priv *priv = dev_get_priv(dev);
+	struct dc_ctlr *dc = dc_plat->dc;
+	struct display_timing *dt = &priv->timing;
+	struct hdmi_ctlr *hdmi = priv->hdmi_regmap;
+	unsigned long rate, div82;
+	unsigned int pulse_start, rekey;
+	int retries = 1000;
+	u32 value;
+	int i;
+
+	/* power up sequence */
+	value = readl(&hdmi->nv_pdisp_sor_pll0);
+	value &= ~SOR_PLL_PDBG;
+	writel(value, &hdmi->nv_pdisp_sor_pll0);
+
+	udelay(20);
+
+	value = readl(&hdmi->nv_pdisp_sor_pll0);
+	value &= ~SOR_PLL_PWR;
+	writel(value, &hdmi->nv_pdisp_sor_pll0);
+
+	writel(VSYNC_H_POSITION(1), &dc->disp.disp_timing_opt);
+	writel(DITHER_CONTROL_DISABLE | BASE_COLOR_SIZE_888,
+	       &dc->disp.disp_color_ctrl);
+
+	/* video_preamble uses h_pulse2 */
+	pulse_start = 1 + dt->hsync_len.typ + dt->hback_porch.typ - 10;
+
+	writel(H_PULSE2_ENABLE, &dc->disp.disp_signal_opt0);
+
+	value = PULSE_MODE_NORMAL | PULSE_POLARITY_HIGH |
+		PULSE_QUAL_VACTIVE | PULSE_LAST_END_A;
+	writel(value, &dc->disp.h_pulse[H_PULSE2].h_pulse_ctrl);
+
+	value = PULSE_START(pulse_start) | PULSE_END(pulse_start + 8);
+	writel(value, &dc->disp.h_pulse[H_PULSE2].h_pulse_pos[H_PULSE0_POSITION_A]);
+
+	value = VSYNC_WINDOW_END(0x210) | VSYNC_WINDOW_START(0x200) |
+		VSYNC_WINDOW_ENABLE;
+	writel(value, &hdmi->nv_pdisp_hdmi_vsync_window);
+
+	if (dc_plat->pipe)
+		value = HDMI_SRC_DISPLAYB;
+	else
+		value = HDMI_SRC_DISPLAYA;
+
+	if (dt->hactive.typ == 720 && (dt->vactive.typ == 480 ||
+				       dt->vactive.typ == 576))
+		writel(value | ARM_VIDEO_RANGE_FULL,
+		       &hdmi->nv_pdisp_input_control);
+	else
+		writel(value | ARM_VIDEO_RANGE_LIMITED,
+		       &hdmi->nv_pdisp_input_control);
+
+	rate = clock_get_periph_rate(priv->clk->id, priv->clk_parent->id);
+	div82 = rate / USEC_PER_SEC * 4;
+	value = SOR_REFCLK_DIV_INT(div82 >> 2) | SOR_REFCLK_DIV_FRAC(div82);
+	writel(value, &hdmi->nv_pdisp_sor_refclk);
+
+	rekey = HDMI_REKEY_DEFAULT;
+	value = HDMI_CTRL_REKEY(rekey);
+	value |= HDMI_CTRL_MAX_AC_PACKET((dt->hsync_len.typ + dt->hback_porch.typ +
+					  dt->hfront_porch.typ - rekey - 18) / 32);
+	writel(value, &hdmi->nv_pdisp_hdmi_ctrl);
+
+	/* TMDS CONFIG */
+	for (i = 0; i < priv->config->num_tmds; i++) {
+		if (dt->pixelclock.typ <= priv->config->tmds[i].pclk) {
+			tegra_hdmi_setup_tmds(priv, &priv->config->tmds[i]);
+			break;
+		}
+	}
+
+	writel(SOR_SEQ_PU_PC(0) | SOR_SEQ_PU_PC_ALT(0) | SOR_SEQ_PD_PC(8) |
+	       SOR_SEQ_PD_PC_ALT(8), &hdmi->nv_pdisp_sor_seq_ctl);
+
+	value = SOR_SEQ_INST_WAIT_TIME(1) | SOR_SEQ_INST_WAIT_UNITS_VSYNC |
+		SOR_SEQ_INST_HALT | SOR_SEQ_INST_PIN_A_LOW |
+		SOR_SEQ_INST_PIN_B_LOW | SOR_SEQ_INST_DRIVE_PWM_OUT_LO;
+
+	writel(value, &hdmi->nv_pdisp_sor_seq_inst0);
+	writel(value, &hdmi->nv_pdisp_sor_seq_inst8);
+
+	value = readl(&hdmi->nv_pdisp_sor_cstm);
+
+	value &= ~SOR_CSTM_ROTCLK(~0);
+	value |= SOR_CSTM_ROTCLK(2);
+	value |= SOR_CSTM_PLLDIV;
+	value &= ~SOR_CSTM_LVDS_ENABLE;
+	value &= ~SOR_CSTM_MODE_MASK;
+	value |= SOR_CSTM_MODE_TMDS;
+
+	writel(value, &hdmi->nv_pdisp_sor_cstm);
+
+	/* start SOR */
+	writel(SOR_PWR_NORMAL_STATE_PU | SOR_PWR_NORMAL_START_NORMAL |
+	       SOR_PWR_SAFE_STATE_PD | SOR_PWR_SETTING_NEW_TRIGGER,
+	       &hdmi->nv_pdisp_sor_pwr);
+	writel(SOR_PWR_NORMAL_STATE_PU | SOR_PWR_NORMAL_START_NORMAL |
+	       SOR_PWR_SAFE_STATE_PD | SOR_PWR_SETTING_NEW_DONE,
+	       &hdmi->nv_pdisp_sor_pwr);
+
+	do {
+		if (--retries < 0)
+			return -ETIME;
+		value = readl(&hdmi->nv_pdisp_sor_pwr);
+	} while (value & SOR_PWR_SETTING_NEW_PENDING);
+
+	value = SOR_STATE_ASY_CRCMODE_COMPLETE |
+		SOR_STATE_ASY_OWNER_HEAD0 |
+		SOR_STATE_ASY_SUBOWNER_BOTH |
+		SOR_STATE_ASY_PROTOCOL_SINGLE_TMDS_A |
+		SOR_STATE_ASY_DEPOL_POS;
+
+	/* setup sync polarities */
+	if (dt->flags & DISPLAY_FLAGS_HSYNC_HIGH)
+		value |= SOR_STATE_ASY_HSYNCPOL_POS;
+
+	if (dt->flags & DISPLAY_FLAGS_HSYNC_LOW)
+		value |= SOR_STATE_ASY_HSYNCPOL_NEG;
+
+	if (dt->flags & DISPLAY_FLAGS_VSYNC_HIGH)
+		value |= SOR_STATE_ASY_VSYNCPOL_POS;
+
+	if (dt->flags & DISPLAY_FLAGS_VSYNC_LOW)
+		value |= SOR_STATE_ASY_VSYNCPOL_NEG;
+
+	writel(value, &hdmi->nv_pdisp_sor_state2);
+
+	value = SOR_STATE_ASY_HEAD_OPMODE_AWAKE | SOR_STATE_ASY_ORMODE_NORMAL;
+	writel(value, &hdmi->nv_pdisp_sor_state1);
+
+	writel(0, &hdmi->nv_pdisp_sor_state0);
+	writel(SOR_STATE_UPDATE, &hdmi->nv_pdisp_sor_state0);
+	writel(value | SOR_STATE_ATTACHED,
+	       &hdmi->nv_pdisp_sor_state1);
+	writel(0, &hdmi->nv_pdisp_sor_state0);
+
+	tegra_dc_enable_controller(dev);
+
+	return 0;
+}
+
+/* DDC/CI backlight control */
+static int tegra_hdmi_set_connector(struct udevice *dev, int percent)
+{
+	struct tegra_hdmi_priv *priv = dev_get_priv(dev);
+	struct udevice *ddc_entry;
+	struct i2c_msg msg[1];
+	u8 checksum = DDCCI_ENTRY_ADDR << 1;
+	int i, ret;
+
+	ret = dm_i2c_probe(priv->hdmi_ddc, DDCCI_ENTRY_ADDR, 0, &ddc_entry);
+	if (ret) {
+		log_debug("%s: cannot probe DDC/CI entry: error %d\n",
+			  __func__, ret);
+		return 0;
+	}
+
+	/*
+	 * payload[1] is length: hithest bit OR last 4 bits indicate
+	 * the number of following bytes (excluding checksum)
+	 */
+	u8 payload[7] = { DDCCI_SOURSE_ADDR, BIT(7) | (sizeof(payload) - 3),
+			  DDCCI_COMMAND_WRITE, DDCCI_CTRL_BRIGHTNESS,
+			  (u8)(percent & 0xff), (u8)(percent & 0xff), 0 };
+
+	/* DDC/CI checksum is a simple XOR of all preceding bytes */
+	for (i = 0; i < (sizeof(payload) - 1); i++)
+		checksum ^= payload[i];
+
+	payload[6] = checksum;
+
+	msg->addr = DDCCI_ENTRY_ADDR;
+	msg->flags = 0;
+	msg->len = sizeof(payload);
+	msg->buf = payload;
+
+	dm_i2c_xfer(ddc_entry, msg, 1);
+
+	return 0;
+}
+
+static int tegra_hdmi_timings(struct udevice *dev,
+			      struct display_timing *timing)
+{
+	struct tegra_hdmi_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->timing, sizeof(*timing));
+
+	return 0;
+}
+
+static void tegra_hdmi_init_clocks(struct udevice *dev)
+{
+	struct tegra_hdmi_priv *priv = dev_get_priv(dev);
+	u32 n = priv->timing.pixelclock.typ * 2 / USEC_PER_SEC;
+
+	switch (clock_get_osc_freq()) {
+	case CLOCK_OSC_FREQ_12_0: /* OSC is 12Mhz */
+	case CLOCK_OSC_FREQ_48_0: /* OSC is 48Mhz */
+		clock_set_rate(priv->clk_parent->id, n, 12, 0, 8);
+		break;
+
+	case CLOCK_OSC_FREQ_26_0: /* OSC is 26Mhz */
+		clock_set_rate(priv->clk_parent->id, n, 26, 0, 8);
+		break;
+
+	case CLOCK_OSC_FREQ_13_0: /* OSC is 13Mhz */
+	case CLOCK_OSC_FREQ_16_8: /* OSC is 16.8Mhz */
+		clock_set_rate(priv->clk_parent->id, n, 13, 0, 8);
+		break;
+
+	case CLOCK_OSC_FREQ_19_2:
+	case CLOCK_OSC_FREQ_38_4:
+	default:
+		/*
+		 * These are not supported.
+		 */
+		break;
+	}
+
+	clock_start_periph_pll(priv->clk->id, priv->clk_parent->id,
+			       priv->timing.pixelclock.typ);
+}
+
+static bool tegra_hdmi_mode_valid(void *hdmi_priv, const struct display_timing *timing)
+{
+	struct tegra_hdmi_priv *priv = hdmi_priv;
+
+	if (timing->pixelclock.typ > priv->config->max_pclk)
+		return false;
+
+	return true;
+}
+
+static int tegra_hdmi_decode_edid(struct udevice *dev)
+{
+	struct tegra_hdmi_priv *priv = dev_get_priv(dev);
+	struct udevice *hdmi_edid;
+	uchar edid_buf[EDID_SIZE] = { 0 };
+	int i, ret;
+
+	/* Poll for 1 sec in case EDID is not ready right after hpd */
+	for (i = 0; i < 10; i++) {
+		ret = dm_i2c_probe(priv->hdmi_ddc, HDMI_EDID_I2C_ADDR, 0,
+				   &hdmi_edid);
+		if (!ret)
+			break;
+
+		mdelay(100);
+	}
+	if (ret) {
+		log_debug("%s: cannot probe EDID: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dm_i2c_read(hdmi_edid, 0, edid_buf, sizeof(edid_buf));
+	if (ret) {
+		log_debug("%s: cannot dump EDID buffer: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = edid_get_timing_validate(edid_buf, sizeof(edid_buf), &priv->timing,
+				       &priv->panel_bits_per_colourp,
+				       tegra_hdmi_mode_valid, priv);
+	if (ret) {
+		log_debug("%s: cannot decode EDID info: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tegra_hdmi_wait_hpd(struct tegra_hdmi_priv *priv)
+{
+	int i;
+
+	/* Poll 1 second for HPD signal */
+	for (i = 0; i < 10; i++) {
+		if (dm_gpio_get_value(&priv->hpd))
+			return 0;
+
+		mdelay(100);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int tegra_hdmi_probe(struct udevice *dev)
+{
+	struct tegra_hdmi_priv *priv = dev_get_priv(dev);
+	struct reset_ctl reset_ctl;
+	int i, ret;
+
+	priv->hdmi_regmap = (struct hdmi_ctlr *)dev_read_addr_ptr(dev);
+	if (!priv->hdmi_regmap) {
+		log_debug("%s: no display controller address\n", __func__);
+		return -EINVAL;
+	}
+
+	priv->config = (struct tegra_hdmi_config *)dev_get_driver_data(dev);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_debug("%s: Could not get HDMI clock: %ld\n",
+			  __func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->clk_parent = devm_clk_get(dev, "parent");
+	if (IS_ERR(priv->clk_parent)) {
+		log_debug("%s: Could not get HDMI clock parent: %ld\n",
+			  __func__, PTR_ERR(priv->clk_parent));
+		return PTR_ERR(priv->clk_parent);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_supplies); i++) {
+		ret = device_get_supply_regulator(dev, hdmi_supplies[i],
+						  &priv->supplies[i]);
+		if (ret) {
+			log_debug("%s: cannot get %s %d\n", __func__,
+				  hdmi_supplies[i], ret);
+			if (ret != -ENOENT)
+				return log_ret(ret);
+		}
+
+		ret = regulator_set_enable_if_allowed(priv->supplies[i], true);
+		if (ret && ret != -ENOSYS) {
+			log_debug("%s: cannot enable %s: error %d\n",
+				  __func__, hdmi_supplies[i], ret);
+			return ret;
+		}
+	}
+
+	ret = reset_get_by_name(dev, "hdmi", &reset_ctl);
+	if (ret) {
+		log_debug("%s: reset_get_by_name() failed: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_I2C, dev,
+					   "nvidia,ddc-i2c-bus",
+					   &priv->hdmi_ddc);
+	if (ret) {
+		log_debug("%s: cannot get hdmi ddc i2c bus: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "nvidia,hpd-gpio", 0,
+				   &priv->hpd, GPIOD_IS_IN);
+	if (ret) {
+		log_debug("%s: Could not decode hpd-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/* wait for connector */
+	ret = tegra_hdmi_wait_hpd(priv);
+	if (ret) {
+		/* HPD failed, use default timings */
+		memcpy(&priv->timing, &default_720p_timing,
+		       sizeof(default_720p_timing));
+	} else {
+		ret = tegra_hdmi_decode_edid(dev);
+		if (ret)
+			memcpy(&priv->timing, &default_720p_timing,
+			       sizeof(default_720p_timing));
+	}
+
+	reset_assert(&reset_ctl);
+	tegra_hdmi_init_clocks(dev);
+
+	mdelay(2);
+	reset_deassert(&reset_ctl);
+
+	return 0;
+}
+
+static const struct tegra_hdmi_config tegra20_hdmi_config = {
+	.tmds = tegra20_tmds_config,
+	.num_tmds = ARRAY_SIZE(tegra20_tmds_config),
+	.max_pclk = 148500000, /* 1080p */
+};
+
+static const struct tegra_hdmi_config tegra30_hdmi_config = {
+	.tmds = tegra30_tmds_config,
+	.num_tmds = ARRAY_SIZE(tegra30_tmds_config),
+	.max_pclk = 148500000, /* 1080p */
+};
+
+static const struct video_bridge_ops tegra_hdmi_ops = {
+	.attach			= tegra_hdmi_encoder_enable,
+	.set_backlight		= tegra_hdmi_set_connector,
+	.get_display_timing	= tegra_hdmi_timings,
+};
+
+static const struct udevice_id tegra_hdmi_ids[] = {
+	{
+		.compatible = "nvidia,tegra20-hdmi",
+		.data = (ulong)&tegra20_hdmi_config
+	}, {
+		.compatible = "nvidia,tegra30-hdmi",
+		.data = (ulong)&tegra30_hdmi_config
+	}, {
+		/* sentinel */
+	}
+};
+
+U_BOOT_DRIVER(tegra_hdmi) = {
+	.name		= "tegra_hdmi",
+	.id		= UCLASS_VIDEO_BRIDGE,
+	.of_match	= tegra_hdmi_ids,
+	.ops		= &tegra_hdmi_ops,
+	.probe		= tegra_hdmi_probe,
+	.plat_auto	= sizeof(struct tegra_dc_plat),
+	.priv_auto	= sizeof(struct tegra_hdmi_priv),
+};
diff --git a/drivers/video/tegra20/tegra-hdmi.h b/drivers/video/tegra20/tegra-hdmi.h
new file mode 100644
index 00000000000..eecafe628ca
--- /dev/null
+++ b/drivers/video/tegra20/tegra-hdmi.h
@@ -0,0 +1,652 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  (C) Copyright 2010
+ *  NVIDIA Corporation <www.nvidia.com>
+ */
+
+#ifndef _TEGRA_HDMI_H
+#define _TEGRA_HDMI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+/* Register definitions for the Tegra high-definition multimedia interface */
+
+/* High-Definition Multimedia Interface (HDMI_) regs */
+struct hdmi_ctlr {
+	/* Address 0x000 ~ 0x0d2 */
+	uint ctxsw;						/* _CTXSW */  /* 0x00 */
+
+	uint nv_pdisp_sor_state0;				/* _NV_PDISP_SOR_STATE0 */
+	uint nv_pdisp_sor_state1;				/* _NV_PDISP_SOR_STATE1 */
+	uint nv_pdisp_sor_state2;				/* _NV_PDISP_SOR_STATE2 */
+
+	uint nv_pdisp_rg_hdcp_an_msb;				/* _NV_PDISP_RG_HDCP_AN_MSB */
+	uint nv_pdisp_rg_hdcp_an_lsb;				/* _NV_PDISP_RG_HDCP_AN_LSB */
+	uint nv_pdisp_rg_hdcp_cn_msb;				/* _NV_PDISP_RG_HDCP_CN_MSB */
+	uint nv_pdisp_rg_hdcp_cn_lsb;				/* _NV_PDISP_RG_HDCP_CN_LSB */
+	uint nv_pdisp_rg_hdcp_aksv_msb;				/* _NV_PDISP_RG_HDCP_AKSV_MSB */
+	uint nv_pdisp_rg_hdcp_aksv_lsb;				/* _NV_PDISP_RG_HDCP_AKSV_LSB */
+	uint nv_pdisp_rg_hdcp_bksv_msb;				/* _NV_PDISP_RG_HDCP_BKSV_MSB */
+	uint nv_pdisp_rg_hdcp_bksv_lsb;				/* _NV_PDISP_RG_HDCP_BKSV_LSB */
+	uint nv_pdisp_rg_hdcp_cksv_msb;				/* _NV_PDISP_RG_HDCP_CKSV_MSB */
+	uint nv_pdisp_rg_hdcp_cksv_lsb;				/* _NV_PDISP_RG_HDCP_CKSV_LSB */
+	uint nv_pdisp_rg_hdcp_dksv_msb;				/* _NV_PDISP_RG_HDCP_DKSV_MSB */
+	uint nv_pdisp_rg_hdcp_dksv_lsb;				/* _NV_PDISP_RG_HDCP_DKSV_LSB */
+	uint nv_pdisp_rg_hdcp_ctrl;				/* _NV_PDISP_RG_HDCP_CTRL */  /* 0x10 */
+	uint nv_pdisp_rg_hdcp_cmode;				/* _NV_PDISP_RG_HDCP_CMODE */
+	uint nv_pdisp_rg_hdcp_mprime_msb;			/* _NV_PDISP_RG_HDCP_MPRIME_MSB */
+	uint nv_pdisp_rg_hdcp_mprime_lsb;			/* _NV_PDISP_RG_HDCP_MPRIME_LSB */
+	uint nv_pdisp_rg_hdcp_sprime_msb;			/* _NV_PDISP_RG_HDCP_SPRIME_MSB */
+	uint nv_pdisp_rg_hdcp_sprime_lsb2;			/* _NV_PDISP_RG_HDCP_SPRIME_LSB2 */
+	uint nv_pdisp_rg_hdcp_sprime_lsb1;			/* _NV_PDISP_RG_HDCP_SPRIME_LSB1 */
+	uint nv_pdisp_rg_hdcp_ri;				/* _NV_PDISP_RG_HDCP_RI */
+	uint nv_pdisp_rg_hdcp_cs_msb;				/* _NV_PDISP_RG_HDCP_CS_MSB */
+	uint nv_pdisp_rg_hdcp_cs_lsb;				/* _NV_PDISP_RG_HDCP_CS_LSB */
+
+	uint nv_pdisp_hdmi_audio_emu0;				/* _NV_PDISP_HDMI_AUDIO_EMU0 */
+	uint nv_pdisp_hdmi_audio_emu_rdata0;			/* _NV_PDISP_HDMI_AUDIO_EMU_RDATA0 */
+	uint nv_pdisp_hdmi_audio_emu1;				/* _NV_PDISP_HDMI_AUDIO_EMU1 */
+	uint nv_pdisp_hdmi_audio_emu2;				/* _NV_PDISP_HDMI_AUDIO_EMU2 */
+	uint nv_pdisp_hdmi_audio_infoframe_ctrl;		/* _NV_PDISP_HDMI_AUDIO_INFOFRAME_CTRL */
+	uint nv_pdisp_hdmi_audio_infoframe_status;		/* _NV_PDISP_HDMI_AUDIO_INFOFRAME_STATUS */
+	uint nv_pdisp_hdmi_audio_infoframe_header;		/* _NV_PDISP_HDMI_AUDIO_INFOFRAME_HEADER */  /* 0x20 */
+	uint nv_pdisp_hdmi_audio_infoframe_subpack0_low;	/* _NV_PDISP_HDMI_AUDIO_INFOFRAME_SUBPACK0_LOW */
+	uint nv_pdisp_hdmi_audio_infoframe_subpack0_high;	/* _NV_PDISP_HDMI_AUDIO_INFOFRAME_SUBPACK0_HIGH */
+
+	uint nv_pdisp_hdmi_avi_infoframe_ctrl;			/* _NV_PDISP_HDMI_AVI_INFOFRAME_CTRL */
+	uint nv_pdisp_hdmi_avi_infoframe_status;		/* _NV_PDISP_HDMI_AVI_INFOFRAME_STATUS */
+	uint nv_pdisp_hdmi_avi_infoframe_header;		/* _NV_PDISP_HDMI_AVI_INFOFRAME_HEADER */
+	uint nv_pdisp_hdmi_avi_infoframe_subpack0_low;		/* _NV_PDISP_HDMI_AVI_INFOFRAME_SUBPACK0_LOW */
+	uint nv_pdisp_hdmi_avi_infoframe_subpack0_high;		/* _NV_PDISP_HDMI_AVI_INFOFRAME_SUBPACK0_HIGH */
+	uint nv_pdisp_hdmi_avi_infoframe_subpack1_low;		/* _NV_PDISP_HDMI_AVI_INFOFRAME_SUBPACK1_LOW */
+	uint nv_pdisp_hdmi_avi_infoframe_subpack1_high;		/* _NV_PDISP_HDMI_AVI_INFOFRAME_SUBPACK1_HIGH */
+
+	uint nv_pdisp_hdmi_generic_ctrl;			/* _NV_PDISP_HDMI_GENERIC_CTRL */
+	uint nv_pdisp_hdmi_generic_status;			/* _NV_PDISP_HDMI_GENERIC_STATUS */
+	uint nv_pdisp_hdmi_generic_header;			/* _NV_PDISP_HDMI_GENERIC_HEADER */
+	uint nv_pdisp_hdmi_generic_subpack0_low;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK0_LOW */
+	uint nv_pdisp_hdmi_generic_subpack0_high;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK0_HIGH */
+	uint nv_pdisp_hdmi_generic_subpack1_low;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK1_LOW */
+	uint nv_pdisp_hdmi_generic_subpack1_high;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK1_HIGH */
+	uint nv_pdisp_hdmi_generic_subpack2_low;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK2_LOW */
+	uint nv_pdisp_hdmi_generic_subpack2_high;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK2_HIGH */
+	uint nv_pdisp_hdmi_generic_subpack3_low;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK3_LOW */
+	uint nv_pdisp_hdmi_generic_subpack3_high;		/* _NV_PDISP_HDMI_GENERIC_SUBPACK3_HIGH */
+
+	uint nv_pdisp_hdmi_acr_ctrl;				/* _NV_PDISP_HDMI_ACR_CTRL */
+	uint nv_pdisp_hdmi_acr_0320_subpack_low;		/* _NV_PDISP_HDMI_ACR_0320_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_0320_subpack_high;		/* _NV_PDISP_HDMI_ACR_0320_SUBPACK_HIGH */
+	uint nv_pdisp_hdmi_acr_0441_subpack_low;		/* _NV_PDISP_HDMI_ACR_0441_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_0441_subpack_high;		/* _NV_PDISP_HDMI_ACR_0441_SUBPACK_HIGH */
+	uint nv_pdisp_hdmi_acr_0882_subpack_low;		/* _NV_PDISP_HDMI_ACR_0882_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_0882_subpack_high;		/* _NV_PDISP_HDMI_ACR_0882_SUBPACK_HIGH */
+	uint nv_pdisp_hdmi_acr_1764_subpack_low;		/* _NV_PDISP_HDMI_ACR_1764_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_1764_subpack_high;		/* _NV_PDISP_HDMI_ACR_1764_SUBPACK_HIGH */
+	uint nv_pdisp_hdmi_acr_0480_subpack_low;		/* _NV_PDISP_HDMI_ACR_0480_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_0480_subpack_high;		/* _NV_PDISP_HDMI_ACR_0480_SUBPACK_HIGH */
+	uint nv_pdisp_hdmi_acr_0960_subpack_low;		/* _NV_PDISP_HDMI_ACR_0960_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_0960_subpack_high;		/* _NV_PDISP_HDMI_ACR_0960_SUBPACK_HIGH */
+	uint nv_pdisp_hdmi_acr_1920_subpack_low;		/* _NV_PDISP_HDMI_ACR_1920_SUBPACK_LOW */
+	uint nv_pdisp_hdmi_acr_1920_subpack_high;		/* _NV_PDISP_HDMI_ACR_1920_SUBPACK_HIGH */
+
+	uint nv_pdisp_hdmi_ctrl;				/* _NV_PDISP_HDMI_CTRL */
+	uint nv_pdisp_hdmi_vsync_keepout;			/* _NV_PDISP_HDMI_VSYNC_KEEPOUT */
+	uint nv_pdisp_hdmi_vsync_window;			/* _NV_PDISP_HDMI_VSYNC_WINDOW */
+	uint nv_pdisp_hdmi_gcp_ctrl;				/* _NV_PDISP_HDMI_GCP_CTRL */
+	uint nv_pdisp_hdmi_gcp_status;				/* _NV_PDISP_HDMI_GCP_STATUS */
+	uint nv_pdisp_hdmi_gcp_subpack;				/* _NV_PDISP_HDMI_GCP_SUBPACK */
+	uint nv_pdisp_hdmi_channel_status1;			/* _NV_PDISP_HDMI_CHANNEL_STATUS1 */
+	uint nv_pdisp_hdmi_channel_status2;			/* _NV_PDISP_HDMI_CHANNEL_STATUS2 */
+	uint nv_pdisp_hdmi_emu0;				/* _NV_PDISP_HDMI_EMU0 */
+	uint nv_pdisp_hdmi_emu1;				/* _NV_PDISP_HDMI_EMU1 */
+	uint nv_pdisp_hdmi_emu1_rdata;				/* _NV_PDISP_HDMI_EMU1_RDATA */
+	uint nv_pdisp_hdmi_spare;				/* _NV_PDISP_HDMI_SPARE */
+	uint nv_pdisp_hdmi_spdif_chn_status1;			/* _NV_PDISP_HDMI_SPDIF_CHN_STATUS1 */
+	uint nv_pdisp_hdmi_spdif_chn_status2;			/* _NV_PDISP_HDMI_SPDIF_CHN_STATUS2 */
+
+	uint nv_pdisp_hdcprif_rom_ctrl;				/* _NV_PDISP_HDCPRIF_ROM_CTRL */
+
+	uint unused;
+
+	uint nv_pdisp_sor_cap;					/* _NV_PDISP_SOR_CAP */
+	uint nv_pdisp_sor_pwr;					/* _NV_PDISP_SOR_PWR */
+	uint nv_pdisp_sor_test;					/* _NV_PDISP_SOR_TEST */
+	uint nv_pdisp_sor_pll0;					/* _NV_PDISP_SOR_PLL0 */
+	uint nv_pdisp_sor_pll1;					/* _NV_PDISP_SOR_PLL1 */
+	uint nv_pdisp_sor_pll2;					/* _NV_PDISP_SOR_PLL2 */
+	uint nv_pdisp_sor_cstm;					/* _NV_PDISP_SOR_CSTM */
+	uint nv_pdisp_sor_lvds;					/* _NV_PDISP_SOR_LVDS */
+	uint nv_pdisp_sor_crca;					/* _NV_PDISP_SOR_CRCA */
+	uint nv_pdisp_sor_crcb;					/* _NV_PDISP_SOR_CRCB */
+	uint nv_pdisp_sor_blank;				/* _NV_PDISP_SOR_BLANK */
+
+	uint nv_pdisp_sor_seq_ctl;				/* _NV_PDISP_SOR_SEQ_CTL */
+	uint nv_pdisp_sor_seq_inst0;				/* _NV_PDISP_SOR_SEQ_INST0 */
+	uint nv_pdisp_sor_seq_inst1;				/* _NV_PDISP_SOR_SEQ_INST1 */
+	uint nv_pdisp_sor_seq_inst2;				/* _NV_PDISP_SOR_SEQ_INST2 */
+	uint nv_pdisp_sor_seq_inst3;				/* _NV_PDISP_SOR_SEQ_INST3 */
+	uint nv_pdisp_sor_seq_inst4;				/* _NV_PDISP_SOR_SEQ_INST4 */
+	uint nv_pdisp_sor_seq_inst5;				/* _NV_PDISP_SOR_SEQ_INST5 */
+	uint nv_pdisp_sor_seq_inst6;				/* _NV_PDISP_SOR_SEQ_INST6 */
+	uint nv_pdisp_sor_seq_inst7;				/* _NV_PDISP_SOR_SEQ_INST7 */
+	uint nv_pdisp_sor_seq_inst8;				/* _NV_PDISP_SOR_SEQ_INST8 */
+	uint nv_pdisp_sor_seq_inst9;				/* _NV_PDISP_SOR_SEQ_INST9 */
+	uint nv_pdisp_sor_seq_insta;				/* _NV_PDISP_SOR_SEQ_INSTA */
+	uint nv_pdisp_sor_seq_instb;				/* _NV_PDISP_SOR_SEQ_INSTB */
+	uint nv_pdisp_sor_seq_instc;				/* _NV_PDISP_SOR_SEQ_INSTC */
+	uint nv_pdisp_sor_seq_instd;				/* _NV_PDISP_SOR_SEQ_INSTD */
+	uint nv_pdisp_sor_seq_inste;				/* _NV_PDISP_SOR_SEQ_INSTE */
+	uint nv_pdisp_sor_seq_instf;				/* _NV_PDISP_SOR_SEQ_INSTF */
+
+	uint unused1[2];
+
+	uint nv_pdisp_sor_vcrca0;				/* _NV_PDISP_SOR_VCRCA0 */
+	uint nv_pdisp_sor_vcrca1;				/* _NV_PDISP_SOR_VCRCA1 */
+	uint nv_pdisp_sor_ccrca0;				/* _NV_PDISP_SOR_CCRCA0 */
+	uint nv_pdisp_sor_ccrca1;				/* _NV_PDISP_SOR_CCRCA1 */
+
+	uint nv_pdisp_sor_edataa0;				/* _NV_PDISP_SOR_EDATAA0 */
+	uint nv_pdisp_sor_edataa1;				/* _NV_PDISP_SOR_EDATAA1 */
+
+	uint nv_pdisp_sor_counta0;				/* _NV_PDISP_SOR_COUNTA0 */
+	uint nv_pdisp_sor_counta1;				/* _NV_PDISP_SOR_COUNTA1 */
+
+	uint nv_pdisp_sor_debuga0;				/* _NV_PDISP_SOR_DEBUGA0 */
+	uint nv_pdisp_sor_debuga1;				/* _NV_PDISP_SOR_DEBUGA1 */
+
+	uint nv_pdisp_sor_trig;					/* _NV_PDISP_SOR_TRIG */
+	uint nv_pdisp_sor_mscheck;				/* _NV_PDISP_SOR_MSCHECK */
+	uint nv_pdisp_sor_lane_drive_current;			/* _NV_PDISP_SOR_LANE_DRIVE_CURRENT */
+
+	uint nv_pdisp_audio_debug0;				/* _NV_PDISP_AUDIO_DEBUG0 0x7f */
+	uint nv_pdisp_audio_debug1;				/* _NV_PDISP_AUDIO_DEBUG1 0x80 */
+	uint nv_pdisp_audio_debug2;				/* _NV_PDISP_AUDIO_DEBUG2 0x81 */
+
+	uint nv_pdisp_audio_fs1;				/* _NV_PDISP_AUDIO_FS1 0x82 */
+	uint nv_pdisp_audio_fs2;				/* _NV_PDISP_AUDIO_FS2 */
+	uint nv_pdisp_audio_fs3;				/* _NV_PDISP_AUDIO_FS3 */
+	uint nv_pdisp_audio_fs4;				/* _NV_PDISP_AUDIO_FS4 */
+	uint nv_pdisp_audio_fs5;				/* _NV_PDISP_AUDIO_FS5 */
+	uint nv_pdisp_audio_fs6;				/* _NV_PDISP_AUDIO_FS6 */
+	uint nv_pdisp_audio_fs7;				/* _NV_PDISP_AUDIO_FS7 0x88 */
+
+	uint nv_pdisp_audio_pulse_width;			/* _NV_PDISP_AUDIO_PULSE_WIDTH */
+	uint nv_pdisp_audio_threshold;				/* _NV_PDISP_AUDIO_THRESHOLD */
+	uint nv_pdisp_audio_cntrl0;				/* _NV_PDISP_AUDIO_CNTRL0 */
+	uint nv_pdisp_audio_n;					/* _NV_PDISP_AUDIO_N */
+	uint nv_pdisp_audio_nval[7];				/* _NV_PDISP_AUDIO_NVAL */
+
+	uint nv_pdisp_hdcprif_rom_timing;			/* _NV_PDISP_HDCPRIF_ROM_TIMING */
+	uint nv_pdisp_sor_refclk;				/* _NV_PDISP_SOR_REFCLK */
+	uint nv_pdisp_crc_control;				/* _NV_PDISP_CRC_CONTROL */
+	uint nv_pdisp_input_control;				/* _NV_PDISP_INPUT_CONTROL */
+	uint nv_pdisp_scratch;					/* _NV_PDISP_SCRATCH */
+	uint nv_pdisp_pe_current;				/* _NV_PDISP_PE_CURRENT */
+
+	uint nv_pdisp_key_ctrl;					/* _NV_PDISP_KEY_CTRL */
+	uint nv_pdisp_key_debug0;				/* _NV_PDISP_KEY_DEBUG0 */
+	uint nv_pdisp_key_debug1;				/* _NV_PDISP_KEY_DEBUG1 */
+	uint nv_pdisp_key_debug2;				/* _NV_PDISP_KEY_DEBUG2 */
+	uint nv_pdisp_key_hdcp_key_0;				/* _NV_PDISP_KEY_HDCP_KEY_0 */
+	uint nv_pdisp_key_hdcp_key_1;				/* _NV_PDISP_KEY_HDCP_KEY_1 */
+	uint nv_pdisp_key_hdcp_key_2;				/* _NV_PDISP_KEY_HDCP_KEY_2 */
+	uint nv_pdisp_key_hdcp_key_3;				/* _NV_PDISP_KEY_HDCP_KEY_3 */
+	uint nv_pdisp_key_hdcp_key_trig;			/* _NV_PDISP_KEY_HDCP_KEY_3 */
+	uint nv_pdisp_key_skey_index;				/* _NV_PDISP_KEY_HDCP_KEY_3 */ /* 0xa3 */
+
+	uint unused2[8];
+
+	uint nv_pdisp_sor_audio_cntrl0;				/* _NV_PDISP_SOR_AUDIO_CNTRL0 */ /* 0xac */
+	uint nv_pdisp_sor_audio_debug;				/* _NV_PDISP_SOR_AUDIO_DEBUG */
+	uint nv_pdisp_sor_audio_spare0;				/* _NV_PDISP_SOR_AUDIO_SPARE0 */
+	uint nv_pdisp_sor_audio_nval[7];			/* _NV_PDISP_SOR_AUDIO_NVAL 0xaf ~ 0xb5 */
+	uint nv_pdisp_sor_audio_hda_scratch[4];			/* _NV_PDISP_SOR_AUDIO_HDA_SCRATCH 0xb6 ~ 0xb9 */
+	uint nv_pdisp_sor_audio_hda_codec_scratch[2];		/* _NV_PDISP_SOR_AUDIO_HDA_CODEC_SCRATCH 0xba ~ 0xbb */
+
+	uint nv_pdisp_sor_audio_hda_eld_bufwr;			/* _NV_PDISP_SOR_AUDIO_HDA_ELD_BUFWR */
+	uint nv_pdisp_sor_audio_hda_presense;			/* _NV_PDISP_SOR_AUDIO_HDA_PRESENSE */
+	uint nv_pdisp_sor_audio_hda_cp;				/* _NV_PDISP_SOR_AUDIO_HDA_CP */
+	uint nv_pdisp_sor_audio_aval[8];			/* _NV_PDISP_SOR_AUDIO_AVAL */
+	uint nv_pdisp_sor_audio_gen_ctrl;			/* _NV_PDISP_SOR_AUDIO_GEN_CTRL */
+
+	uint unused3[4];
+
+	uint nv_pdisp_int_status;				/* _NV_PDISP_INT_STATUS */
+	uint nv_pdisp_int_mask;					/* _NV_PDISP_INT_MASK */
+	uint nv_pdisp_int_enable;				/* _NV_PDISP_INT_ENABLE */
+
+	uint unused4[2];
+
+	uint nv_pdisp_sor_io_peak_current;			/* _NV_PDISP_SOR_IO_PEAK_CURRENT */
+	uint nv_pdisp_sor_pad_ctls0;				/* _NV_PDISP_SOR_PAD_CTLS0 */
+};
+
+/* HDMI_NV_PDISP_SOR_STATE0	0x01 */
+#define SOR_STATE_UPDATE			BIT(0)
+
+/* HDMI_NV_PDISP_SOR_STATE1	0x02 */
+#define SOR_STATE_ASY_HEAD_OPMODE_AWAKE		BIT(1)
+#define SOR_STATE_ASY_ORMODE_NORMAL		BIT(2)
+#define SOR_STATE_ATTACHED			BIT(3)
+
+/* HDMI_NV_PDISP_SOR_STATE2	0x03 */
+#define SOR_STATE_ASY_OWNER_NONE		(0 << 0)
+#define SOR_STATE_ASY_OWNER_HEAD0		(1 << 0)
+#define SOR_STATE_ASY_SUBOWNER_NONE		(0 << 4)
+#define SOR_STATE_ASY_SUBOWNER_SUBHEAD0		(1 << 4)
+#define SOR_STATE_ASY_SUBOWNER_SUBHEAD1		(2 << 4)
+#define SOR_STATE_ASY_SUBOWNER_BOTH		(3 << 4)
+#define SOR_STATE_ASY_CRCMODE_ACTIVE		(0 << 6)
+#define SOR_STATE_ASY_CRCMODE_COMPLETE		(1 << 6)
+#define SOR_STATE_ASY_CRCMODE_NON_ACTIVE	(2 << 6)
+#define SOR_STATE_ASY_PROTOCOL_SINGLE_TMDS_A	(1 << 8)
+#define SOR_STATE_ASY_PROTOCOL_CUSTOM		(15 << 8)
+#define SOR_STATE_ASY_HSYNCPOL_POS		(0 << 12)
+#define SOR_STATE_ASY_HSYNCPOL_NEG		(1 << 12)
+#define SOR_STATE_ASY_VSYNCPOL_POS		(0 << 13)
+#define SOR_STATE_ASY_VSYNCPOL_NEG		(1 << 13)
+#define SOR_STATE_ASY_DEPOL_POS			(0 << 14)
+#define SOR_STATE_ASY_DEPOL_NEG			(1 << 14)
+
+#define INFOFRAME_CTRL_ENABLE			BIT(0)
+#define INFOFRAME_HEADER_TYPE(x)		(((x) & 0xff) <<  0)
+#define INFOFRAME_HEADER_VERSION(x)		(((x) & 0xff) <<  8)
+#define INFOFRAME_HEADER_LEN(x)			(((x) & 0x0f) << 16)
+
+/* HDMI_NV_PDISP_HDMI_GENERIC_CTRL	0x2a */
+#define GENERIC_CTRL_ENABLE			BIT(0)
+#define GENERIC_CTRL_OTHER			BIT(4)
+#define GENERIC_CTRL_SINGLE			BIT(8)
+#define GENERIC_CTRL_HBLANK			BIT(12)
+#define GENERIC_CTRL_AUDIO			BIT(16)
+
+/* HDMI_NV_PDISP_HDMI_ACR_* */
+#define ACR_SUBPACK_CTS(x)			(((x) & 0xffffff) << 8)
+#define ACR_SUBPACK_N(x)			(((x) & 0xffffff) << 0)
+#define ACR_ENABLE				BIT(31)
+
+/* HDMI_NV_PDISP_HDMI_CTRL	0x44 */
+#define HDMI_CTRL_REKEY(x)			(((x) & 0x7f) <<  0)
+#define HDMI_CTRL_MAX_AC_PACKET(x)		(((x) & 0x1f) << 16)
+#define HDMI_CTRL_ENABLE			BIT(30)
+
+/* HDMI_NV_PDISP_HDMI_VSYNC_* */
+#define VSYNC_WINDOW_END(x)			(((x) & 0x3ff) <<  0)
+#define VSYNC_WINDOW_START(x)			(((x) & 0x3ff) << 16)
+#define VSYNC_WINDOW_ENABLE			BIT(31)
+
+/* HDMI_NV_PDISP_HDMI_SPARE	0x4f */
+#define SPARE_HW_CTS				BIT(0)
+#define SPARE_FORCE_SW_CTS			BIT(1)
+#define SPARE_CTS_RESET_VAL(x)			(((x) & 0x7) << 16)
+
+/* HDMI_NV_PDISP_SOR_PWR	0x55 */
+#define SOR_PWR_NORMAL_STATE_PD			(0 <<  0)
+#define SOR_PWR_NORMAL_STATE_PU			(1 <<  0)
+#define SOR_PWR_NORMAL_START_NORMAL		(0 <<  1)
+#define SOR_PWR_NORMAL_START_ALT		(1 <<  1)
+#define SOR_PWR_SAFE_STATE_PD			(0 << 16)
+#define SOR_PWR_SAFE_STATE_PU			(1 << 16)
+#define SOR_PWR_SETTING_NEW_DONE		(0 << 31)
+#define SOR_PWR_SETTING_NEW_PENDING		(1 << 31)
+#define SOR_PWR_SETTING_NEW_TRIGGER		(1 << 31)
+
+/* HDMI_NV_PDISP_SOR_PLL0	0x57 */
+#define SOR_PLL_PWR				BIT(0)
+#define SOR_PLL_PDBG				BIT(1)
+#define SOR_PLL_VCAPD				BIT(2)
+#define SOR_PLL_PDPORT				BIT(3)
+#define SOR_PLL_RESISTORSEL			BIT(4)
+#define SOR_PLL_PULLDOWN			BIT(5)
+#define SOR_PLL_VCOCAP(x)			(((x) & 0xf) <<  8)
+#define SOR_PLL_BG_V17_S(x)			(((x) & 0xf) << 12)
+#define SOR_PLL_FILTER(x)			(((x) & 0xf) << 16)
+#define SOR_PLL_ICHPMP(x)			(((x) & 0xf) << 24)
+#define SOR_PLL_TX_REG_LOAD(x)			(((x) & 0xf) << 28)
+
+/* HDMI_NV_PDISP_SOR_PLL1	0x58 */
+#define SOR_PLL_TMDS_TERM_ENABLE		BIT(8)
+#define SOR_PLL_TMDS_TERMADJ(x)			(((x) & 0xf) <<  9)
+#define SOR_PLL_LOADADJ(x)			(((x) & 0xf) << 20)
+#define SOR_PLL_PE_EN				BIT(28)
+#define SOR_PLL_HALF_FULL_PE			BIT(29)
+#define SOR_PLL_S_D_PIN_PE			BIT(30)
+
+/* HDMI_NV_PDISP_SOR_CSTM	0x5a */
+#define SOR_CSTM_ROTCLK(x)			(((x) & 0xf) << 24)
+#define SOR_CSTM_PLLDIV				BIT(21)
+#define SOR_CSTM_LVDS_ENABLE			BIT(16)
+#define SOR_CSTM_MODE_LVDS			(0 << 12)
+#define SOR_CSTM_MODE_TMDS			(1 << 12)
+#define SOR_CSTM_MODE_MASK			(3 << 12)
+
+/* HDMI_NV_PDISP_SOR_SEQ_CTL	0x5f */
+#define SOR_SEQ_PU_PC(x)			(((x) & 0xf) <<  0)
+#define SOR_SEQ_PU_PC_ALT(x)			(((x) & 0xf) <<  4)
+#define SOR_SEQ_PD_PC(x)			(((x) & 0xf) <<  8)
+#define SOR_SEQ_PD_PC_ALT(x)			(((x) & 0xf) << 12)
+#define SOR_SEQ_PC(x)				(((x) & 0xf) << 16)
+#define SOR_SEQ_STATUS				BIT(28)
+#define SOR_SEQ_SWITCH				BIT(30)
+
+/* HDMI_NV_PDISP_SOR_SEQ_INST(x)	(0x60 + (x)) */
+#define SOR_SEQ_INST_WAIT_TIME(x)		(((x) & 0x3ff) << 0)
+#define SOR_SEQ_INST_WAIT_UNITS_VSYNC		(2 << 12)
+#define SOR_SEQ_INST_HALT			(1 << 15)
+#define SOR_SEQ_INST_PIN_A_LOW			(0 << 21)
+#define SOR_SEQ_INST_PIN_A_HIGH			(1 << 21)
+#define SOR_SEQ_INST_PIN_B_LOW			(0 << 22)
+#define SOR_SEQ_INST_PIN_B_HIGH			(1 << 22)
+#define SOR_SEQ_INST_DRIVE_PWM_OUT_LO		(1 << 23)
+
+/* HDMI_NV_PDISP_SOR_LANE_DRIVE_CURRENT	0x7e */
+#define DRIVE_CURRENT_LANE0(x)			(((x) & 0x3f) <<  0)
+#define DRIVE_CURRENT_LANE1(x)			(((x) & 0x3f) <<  8)
+#define DRIVE_CURRENT_LANE2(x)			(((x) & 0x3f) << 16)
+#define DRIVE_CURRENT_LANE3(x)			(((x) & 0x3f) << 24)
+#define DRIVE_CURRENT_LANE0_T114(x)		(((x) & 0x7f) <<  0)
+#define DRIVE_CURRENT_LANE1_T114(x)		(((x) & 0x7f) <<  8)
+#define DRIVE_CURRENT_LANE2_T114(x)		(((x) & 0x7f) << 16)
+#define DRIVE_CURRENT_LANE3_T114(x)		(((x) & 0x7f) << 24)
+
+/* Drive current list */
+enum {
+	DRIVE_CURRENT_1_500_mA,
+	DRIVE_CURRENT_1_875_mA,
+	DRIVE_CURRENT_2_250_mA,
+	DRIVE_CURRENT_2_625_mA,
+	DRIVE_CURRENT_3_000_mA,
+	DRIVE_CURRENT_3_375_mA,
+	DRIVE_CURRENT_3_750_mA,
+	DRIVE_CURRENT_4_125_mA,
+	DRIVE_CURRENT_4_500_mA,
+	DRIVE_CURRENT_4_875_mA,
+	DRIVE_CURRENT_5_250_mA,
+	DRIVE_CURRENT_5_625_mA,
+	DRIVE_CURRENT_6_000_mA,
+	DRIVE_CURRENT_6_375_mA,
+	DRIVE_CURRENT_6_750_mA,
+	DRIVE_CURRENT_7_125_mA,
+	DRIVE_CURRENT_7_500_mA,
+	DRIVE_CURRENT_7_875_mA,
+	DRIVE_CURRENT_8_250_mA,
+	DRIVE_CURRENT_8_625_mA,
+	DRIVE_CURRENT_9_000_mA,
+	DRIVE_CURRENT_9_375_mA,
+	DRIVE_CURRENT_9_750_mA,
+	DRIVE_CURRENT_10_125_mA,
+	DRIVE_CURRENT_10_500_mA,
+	DRIVE_CURRENT_10_875_mA,
+	DRIVE_CURRENT_11_250_mA,
+	DRIVE_CURRENT_11_625_mA,
+	DRIVE_CURRENT_12_000_mA,
+	DRIVE_CURRENT_12_375_mA,
+	DRIVE_CURRENT_12_750_mA,
+	DRIVE_CURRENT_13_125_mA,
+	DRIVE_CURRENT_13_500_mA,
+	DRIVE_CURRENT_13_875_mA,
+	DRIVE_CURRENT_14_250_mA,
+	DRIVE_CURRENT_14_625_mA,
+	DRIVE_CURRENT_15_000_mA,
+	DRIVE_CURRENT_15_375_mA,
+	DRIVE_CURRENT_15_750_mA,
+	DRIVE_CURRENT_16_125_mA,
+	DRIVE_CURRENT_16_500_mA,
+	DRIVE_CURRENT_16_875_mA,
+	DRIVE_CURRENT_17_250_mA,
+	DRIVE_CURRENT_17_625_mA,
+	DRIVE_CURRENT_18_000_mA,
+	DRIVE_CURRENT_18_375_mA,
+	DRIVE_CURRENT_18_750_mA,
+	DRIVE_CURRENT_19_125_mA,
+	DRIVE_CURRENT_19_500_mA,
+	DRIVE_CURRENT_19_875_mA,
+	DRIVE_CURRENT_20_250_mA,
+	DRIVE_CURRENT_20_625_mA,
+	DRIVE_CURRENT_21_000_mA,
+	DRIVE_CURRENT_21_375_mA,
+	DRIVE_CURRENT_21_750_mA,
+	DRIVE_CURRENT_22_125_mA,
+	DRIVE_CURRENT_22_500_mA,
+	DRIVE_CURRENT_22_875_mA,
+	DRIVE_CURRENT_23_250_mA,
+	DRIVE_CURRENT_23_625_mA,
+	DRIVE_CURRENT_24_000_mA,
+	DRIVE_CURRENT_24_375_mA,
+	DRIVE_CURRENT_24_750_mA,
+};
+
+/* Drive current list for T114 */
+enum {
+	DRIVE_CURRENT_0_000_mA_T114,
+	DRIVE_CURRENT_0_400_mA_T114,
+	DRIVE_CURRENT_0_800_mA_T114,
+	DRIVE_CURRENT_1_200_mA_T114,
+	DRIVE_CURRENT_1_600_mA_T114,
+	DRIVE_CURRENT_2_000_mA_T114,
+	DRIVE_CURRENT_2_400_mA_T114,
+	DRIVE_CURRENT_2_800_mA_T114,
+	DRIVE_CURRENT_3_200_mA_T114,
+	DRIVE_CURRENT_3_600_mA_T114,
+	DRIVE_CURRENT_4_000_mA_T114,
+	DRIVE_CURRENT_4_400_mA_T114,
+	DRIVE_CURRENT_4_800_mA_T114,
+	DRIVE_CURRENT_5_200_mA_T114,
+	DRIVE_CURRENT_5_600_mA_T114,
+	DRIVE_CURRENT_6_000_mA_T114,
+	DRIVE_CURRENT_6_400_mA_T114,
+	DRIVE_CURRENT_6_800_mA_T114,
+	DRIVE_CURRENT_7_200_mA_T114,
+	DRIVE_CURRENT_7_600_mA_T114,
+	DRIVE_CURRENT_8_000_mA_T114,
+	DRIVE_CURRENT_8_400_mA_T114,
+	DRIVE_CURRENT_8_800_mA_T114,
+	DRIVE_CURRENT_9_200_mA_T114,
+	DRIVE_CURRENT_9_600_mA_T114,
+	DRIVE_CURRENT_10_000_mA_T114,
+	DRIVE_CURRENT_10_400_mA_T114,
+	DRIVE_CURRENT_10_800_mA_T114,
+	DRIVE_CURRENT_11_200_mA_T114,
+	DRIVE_CURRENT_11_600_mA_T114,
+	DRIVE_CURRENT_12_000_mA_T114,
+	DRIVE_CURRENT_12_400_mA_T114,
+	DRIVE_CURRENT_12_800_mA_T114,
+	DRIVE_CURRENT_13_200_mA_T114,
+	DRIVE_CURRENT_13_600_mA_T114,
+	DRIVE_CURRENT_14_000_mA_T114,
+	DRIVE_CURRENT_14_400_mA_T114,
+	DRIVE_CURRENT_14_800_mA_T114,
+	DRIVE_CURRENT_15_200_mA_T114,
+	DRIVE_CURRENT_15_600_mA_T114,
+	DRIVE_CURRENT_16_000_mA_T114,
+	DRIVE_CURRENT_16_400_mA_T114,
+	DRIVE_CURRENT_16_800_mA_T114,
+	DRIVE_CURRENT_17_200_mA_T114,
+	DRIVE_CURRENT_17_600_mA_T114,
+	DRIVE_CURRENT_18_000_mA_T114,
+	DRIVE_CURRENT_18_400_mA_T114,
+	DRIVE_CURRENT_18_800_mA_T114,
+	DRIVE_CURRENT_19_200_mA_T114,
+	DRIVE_CURRENT_19_600_mA_T114,
+	DRIVE_CURRENT_20_000_mA_T114,
+	DRIVE_CURRENT_20_400_mA_T114,
+	DRIVE_CURRENT_20_800_mA_T114,
+	DRIVE_CURRENT_21_200_mA_T114,
+	DRIVE_CURRENT_21_600_mA_T114,
+	DRIVE_CURRENT_22_000_mA_T114,
+	DRIVE_CURRENT_22_400_mA_T114,
+	DRIVE_CURRENT_22_800_mA_T114,
+	DRIVE_CURRENT_23_200_mA_T114,
+	DRIVE_CURRENT_23_600_mA_T114,
+	DRIVE_CURRENT_24_000_mA_T114,
+	DRIVE_CURRENT_24_400_mA_T114,
+	DRIVE_CURRENT_24_800_mA_T114,
+	DRIVE_CURRENT_25_200_mA_T114,
+	DRIVE_CURRENT_25_400_mA_T114,
+	DRIVE_CURRENT_25_800_mA_T114,
+	DRIVE_CURRENT_26_200_mA_T114,
+	DRIVE_CURRENT_26_600_mA_T114,
+	DRIVE_CURRENT_27_000_mA_T114,
+	DRIVE_CURRENT_27_400_mA_T114,
+	DRIVE_CURRENT_27_800_mA_T114,
+	DRIVE_CURRENT_28_200_mA_T114,
+};
+
+/* HDMI_NV_PDISP_AUDIO_FS */
+#define AUDIO_FS_LOW(x)				(((x) & 0xfff) <<  0)
+#define AUDIO_FS_HIGH(x)			(((x) & 0xfff) << 16)
+
+/* HDMI_NV_PDISP_AUDIO_CNTRL0	0x8b */
+#define AUDIO_CNTRL0_ERROR_TOLERANCE(x)		(((x) & 0xff) << 0)
+#define AUDIO_CNTRL0_SOURCE_SELECT_AUTO		(0 << 20)
+#define AUDIO_CNTRL0_SOURCE_SELECT_SPDIF	(1 << 20)
+#define AUDIO_CNTRL0_SOURCE_SELECT_HDAL		(2 << 20)
+#define AUDIO_CNTRL0_FRAMES_PER_BLOCK(x)	(((x) & 0xff) << 24)
+
+/* HDMI_NV_PDISP_AUDIO_N	0x8c */
+#define AUDIO_N_VALUE(x)			(((x) & 0xfffff) << 0)
+#define AUDIO_N_RESETF				(1 << 20)
+#define AUDIO_N_GENERATE_NORMAL			(0 << 24)
+#define AUDIO_N_GENERATE_ALTERNATE		(1 << 24)
+
+/* HDMI_NV_PDISP_SOR_REFCLK	0x95 */
+#define SOR_REFCLK_DIV_INT(x)			(((x) & 0xff) << 8)
+#define SOR_REFCLK_DIV_FRAC(x)			(((x) & 0x03) << 6)
+
+/* HDMI_NV_PDISP_INPUT_CONTROL	0x97 */
+#define HDMI_SRC_DISPLAYA			(0 << 0)
+#define HDMI_SRC_DISPLAYB			(1 << 0)
+#define ARM_VIDEO_RANGE_FULL			(0 << 1)
+#define ARM_VIDEO_RANGE_LIMITED			(1 << 1)
+
+/* HDMI_NV_PDISP_PE_CURRENT	0x99 */
+#define PE_CURRENT0(x)				(((x) & 0xf) << 0)
+#define PE_CURRENT1(x)				(((x) & 0xf) << 8)
+#define PE_CURRENT2(x)				(((x) & 0xf) << 16)
+#define PE_CURRENT3(x)				(((x) & 0xf) << 24)
+
+enum {
+	PE_CURRENT_0_0_mA,
+	PE_CURRENT_0_5_mA,
+	PE_CURRENT_1_0_mA,
+	PE_CURRENT_1_5_mA,
+	PE_CURRENT_2_0_mA,
+	PE_CURRENT_2_5_mA,
+	PE_CURRENT_3_0_mA,
+	PE_CURRENT_3_5_mA,
+	PE_CURRENT_4_0_mA,
+	PE_CURRENT_4_5_mA,
+	PE_CURRENT_5_0_mA,
+	PE_CURRENT_5_5_mA,
+	PE_CURRENT_6_0_mA,
+	PE_CURRENT_6_5_mA,
+	PE_CURRENT_7_0_mA,
+	PE_CURRENT_7_5_mA,
+};
+
+enum {
+	PE_CURRENT_0_mA_T114,
+	PE_CURRENT_1_mA_T114,
+	PE_CURRENT_2_mA_T114,
+	PE_CURRENT_3_mA_T114,
+	PE_CURRENT_4_mA_T114,
+	PE_CURRENT_5_mA_T114,
+	PE_CURRENT_6_mA_T114,
+	PE_CURRENT_7_mA_T114,
+	PE_CURRENT_8_mA_T114,
+	PE_CURRENT_9_mA_T114,
+	PE_CURRENT_10_mA_T114,
+	PE_CURRENT_11_mA_T114,
+	PE_CURRENT_12_mA_T114,
+	PE_CURRENT_13_mA_T114,
+	PE_CURRENT_14_mA_T114,
+	PE_CURRENT_15_mA_T114,
+};
+
+/* HDMI_NV_PDISP_SOR_AUDIO_CNTRL0	0xac */
+#define SOR_AUDIO_CNTRL0_SOURCE_SELECT_AUTO	(0 << 20)
+#define SOR_AUDIO_CNTRL0_SOURCE_SELECT_SPDIF	(1 << 20)
+#define SOR_AUDIO_CNTRL0_SOURCE_SELECT_HDAL	(2 << 20)
+#define SOR_AUDIO_CNTRL0_INJECT_NULLSMPL	(1 << 29)
+
+/* HDMI_NV_PDISP_SOR_AUDIO_SPARE0	0xae */
+#define SOR_AUDIO_SPARE0_HBR_ENABLE		BIT(27)
+
+/* HDMI_NV_PDISP_SOR_AUDIO_HDA_CODEC_SCRATCH0	0xba */
+#define SOR_AUDIO_HDA_CODEC_SCRATCH0_VALID	BIT(30)
+#define SOR_AUDIO_HDA_CODEC_SCRATCH0_FMT_MASK	0xffff
+
+/* HDMI_NV_PDISP_SOR_AUDIO_HDA_PRESENSE	0xbd */
+#define SOR_AUDIO_HDA_PRESENSE_VALID		BIT(1)
+#define SOR_AUDIO_HDA_PRESENSE_PRESENT		BIT(0)
+
+/* HDMI_NV_PDISP_INT_STATUS		0xcc */
+#define INT_SCRATCH				BIT(3)
+#define INT_CP_REQUEST				BIT(2)
+#define INT_CODEC_SCRATCH1			BIT(1)
+#define INT_CODEC_SCRATCH0			BIT(0)
+
+/* HDMI_NV_PDISP_SOR_IO_PEAK_CURRENT	0xd1 */
+#define PEAK_CURRENT_LANE0(x)			(((x) & 0x7f) <<  0)
+#define PEAK_CURRENT_LANE1(x)			(((x) & 0x7f) <<  8)
+#define PEAK_CURRENT_LANE2(x)			(((x) & 0x7f) << 16)
+#define PEAK_CURRENT_LANE3(x)			(((x) & 0x7f) << 24)
+
+enum {
+	PEAK_CURRENT_0_000_mA,
+	PEAK_CURRENT_0_200_mA,
+	PEAK_CURRENT_0_400_mA,
+	PEAK_CURRENT_0_600_mA,
+	PEAK_CURRENT_0_800_mA,
+	PEAK_CURRENT_1_000_mA,
+	PEAK_CURRENT_1_200_mA,
+	PEAK_CURRENT_1_400_mA,
+	PEAK_CURRENT_1_600_mA,
+	PEAK_CURRENT_1_800_mA,
+	PEAK_CURRENT_2_000_mA,
+	PEAK_CURRENT_2_200_mA,
+	PEAK_CURRENT_2_400_mA,
+	PEAK_CURRENT_2_600_mA,
+	PEAK_CURRENT_2_800_mA,
+	PEAK_CURRENT_3_000_mA,
+	PEAK_CURRENT_3_200_mA,
+	PEAK_CURRENT_3_400_mA,
+	PEAK_CURRENT_3_600_mA,
+	PEAK_CURRENT_3_800_mA,
+	PEAK_CURRENT_4_000_mA,
+	PEAK_CURRENT_4_200_mA,
+	PEAK_CURRENT_4_400_mA,
+	PEAK_CURRENT_4_600_mA,
+	PEAK_CURRENT_4_800_mA,
+	PEAK_CURRENT_5_000_mA,
+	PEAK_CURRENT_5_200_mA,
+	PEAK_CURRENT_5_400_mA,
+	PEAK_CURRENT_5_600_mA,
+	PEAK_CURRENT_5_800_mA,
+	PEAK_CURRENT_6_000_mA,
+	PEAK_CURRENT_6_200_mA,
+	PEAK_CURRENT_6_400_mA,
+	PEAK_CURRENT_6_600_mA,
+	PEAK_CURRENT_6_800_mA,
+	PEAK_CURRENT_7_000_mA,
+	PEAK_CURRENT_7_200_mA,
+	PEAK_CURRENT_7_400_mA,
+	PEAK_CURRENT_7_600_mA,
+	PEAK_CURRENT_7_800_mA,
+	PEAK_CURRENT_8_000_mA,
+	PEAK_CURRENT_8_200_mA,
+	PEAK_CURRENT_8_400_mA,
+	PEAK_CURRENT_8_600_mA,
+	PEAK_CURRENT_8_800_mA,
+	PEAK_CURRENT_9_000_mA,
+	PEAK_CURRENT_9_200_mA,
+	PEAK_CURRENT_9_400_mA,
+};
+
+#define HDMI_PIXELCLOCK_148_5			148500000
+#define HDMI_PIXELCLOCK_74_25			74250000
+#define HDMI_PIXELCLOCK_27_0			27000000
+
+#endif /* _TEGRA_HDMI_H */
-- 
2.43.0

