Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC64DC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4744A8399A;
	Thu, 31 Jul 2025 23:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="qxALLoJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2FF83948; Thu, 31 Jul 2025 21:37:19 +0200 (CEST)
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org
 [IPv6:2001:67c:2050:103:465::111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 412AC83938
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4btK990NCmz9y8X;
 Thu, 31 Jul 2025 21:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753990637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gXWMuX/qUfIK3PphMc6+4HgUyWhfgVi8woe3MQhyp0=;
 b=qxALLoJZQON2xSUALmr6dGDH9WxnI39DjzZg6SaomSzH8H/V37L2HDdW3CxstpOtLkk/YS
 9MuOwc6k00DVQ3eqgzt+qyqKDLdH2/yTii95qy41citd4nWijDQC7S21fPTDwJjzj6hzVv
 XJabjVxqA9/pvj3Z4WNgUstIY68AsLgsqykgyjKS+zEimYz9QqGT4FITe8l0R15+trEkPK
 RpOdnVdOMLOK2K1btPRuWltfKOswk3NsGD4xgGmL9lLraVKR7IoWLzKuj1i4Dbxez6SN4D
 75ni/YDMh92OFfjpYCUTB5WuvXdeQ78dZTvBIiL+OBLny6Hk6AakBz2IM3hB8Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ion@agorria.com designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ion@agorria.com
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] video: panel: add Samsung S6E63M0 panel driver
Date: Thu, 31 Jul 2025 21:36:54 +0200
Message-ID: <20250731193656.286806-4-ion@agorria.com>
In-Reply-To: <20250731193656.286806-1-ion@agorria.com>
References: <20250731193656.286806-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4btK990NCmz9y8X
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

Samsung S6E63M0 controller is found in some OLED panels like one used in
the Samsung Captivate Glide. Currently only DBI C panel is implemented.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 drivers/video/Kconfig           |   8 +
 drivers/video/Makefile          |   1 +
 drivers/video/samsung-s6e63m0.c | 393 ++++++++++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 drivers/video/samsung-s6e63m0.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1e405e743ae..a02501583eb 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -700,6 +700,14 @@ config VIDEO_LCD_SONY_L4F00430T01
 	  WVGA resolution (480x800) and is setup over SPI, video
 	  data comes from RGB.
 
+config VIDEO_LCD_SAMSUNG_S6E63M0
+	tristate "Samsung S6E63M0 controller based panel support"
+	depends on PANEL && BACKLIGHT
+	help
+	  Say Y here if you want to enable support for Samsung S6E63M0
+	  controller found in some panels like on Samsung Captivate Glide.
+	  Currently only DBI C panel is implemented.
+
 config VIDEO_LCD_SPI_CS
 	string "SPI CS pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 2151353551d..040333fb3a6 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01) += sharp-lq101r1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) += sony-l4f00430t01.o
+obj-$(CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0) += samsung-s6e63m0.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/samsung-s6e63m0.c b/drivers/video/samsung-s6e63m0.c
new file mode 100644
index 00000000000..7497fc0f53a
--- /dev/null
+++ b/drivers/video/samsung-s6e63m0.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Ion Agorria <ion@agorria.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <mipi_display.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+#include <asm/gpio.h>
+
+#define S6E63M0_DCS_CMD			0
+#define S6E63M0_DCS_DATA		1
+
+#define S6E63M0_INFO_FLAG_PGAMMACTL	BIT(0)
+#define S6E63M0_INFO_FLAG_GAMMA_DELTA	BIT(1)
+
+#define S6E63M0_GTCON_FLAG_FLIP_H	BIT(0)
+#define S6E63M0_GTCON_FLAG_FLIP_V	BIT(1)
+
+/* Manufacturer Command Set */
+#define MCS_PENTILE_1			0xb3
+#define MCS_GAMMA_DELTA_Y_RED		0xb5
+#define MCS_GAMMA_DELTA_X_RED		0xb6
+#define MCS_GAMMA_DELTA_Y_GREEN		0xb7
+#define MCS_GAMMA_DELTA_X_GREEN		0xb8
+#define MCS_GAMMA_DELTA_Y_BLUE		0xb9
+#define MCS_GAMMA_DELTA_X_BLUE		0xba
+#define MCS_DISCTL			0xf2
+#define MCS_SRCCTL			0xf6
+#define MCS_IFCTL			0xf7
+#define MCS_PANELCTL			0xf8
+#define MCS_PGAMMACTL			0xfa
+
+#define MCS_PANELCTL_LEN		14
+#define MCS_IFCTL_LEN			3
+#define MCS_PGAMMACTL_LEN		22
+#define MCS_GAMMA_DELTA_Y_LEN		32
+#define MCS_GAMMA_DELTA_X_LEN		16
+
+struct s6e63m0_priv {
+	struct udevice *vdd3;
+	struct udevice *vci;
+
+	struct s6e63m0_info *info;
+
+	struct gpio_desc reset_gpio;
+
+	u8 gtcon;
+};
+
+struct s6e63m0_info {
+	const u32 flags;
+	struct display_timing timing;
+	const u8 cmd_mcs_panelctl[MCS_PANELCTL_LEN];
+	const u8 cmd_mcs_pgammactl_1[MCS_PGAMMACTL_LEN];
+	const u8 cmd_mcs_pgammactl_2;
+	const u8 cmd_mcs_gamma_delta_y[MCS_GAMMA_DELTA_Y_LEN];
+	const u8 cmd_mcs_gamma_delta_x[MCS_GAMMA_DELTA_X_LEN];
+};
+
+static const struct s6e63m0_info s6e63m0_generic_info = {
+	.flags = S6E63M0_INFO_FLAG_GAMMA_DELTA,
+	.timing = {
+		.pixelclock.typ		= 25628,
+		.hactive.typ		= 480,
+		.hfront_porch.typ	= 16,
+		.hback_porch.typ	= 16,
+		.hsync_len.typ		= 2,
+		.vactive.typ		= 800,
+		.vfront_porch.typ	= 28,
+		.vback_porch.typ	= 1,
+		.vsync_len.typ		= 2,
+		.flags			= DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+	},
+	.cmd_mcs_panelctl = {
+		0x01,	/* DOCT */	0x27,	/* CLWEA */
+		0x27,	/* CLWEB*/	0x07,	/* CLTE */
+		0x07,	/* SHE */	0x54,	/* FLTE */
+		0x9F,	/* FLWE */	0x63,	/* SCTE */
+		0x8F,	/* SCWE */	0x1A,	/* INTE */
+		0x33,	/* INWE */	0x0D,	/* EMPS */
+		0x00,	/* E_INTE */	0x00	/* E_INWE */
+	},
+	.cmd_mcs_pgammactl_1 = {
+		0x00, 0x18, 0x08, 0x24, 0x64, 0x56, 0x33, 0xb6,
+		0xba, 0xa8, 0xac, 0xb1, 0x9d, 0xc1, 0xc1, 0xb7,
+		0x00, 0x9c, 0x00, 0x9f, 0x00, 0xd6
+	},
+	.cmd_mcs_pgammactl_2 = 0x01,
+	.cmd_mcs_gamma_delta_y = {
+		0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17, 0x13,
+		0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b, 0x1a, 0x17,
+		0x2b, 0x26, 0x22, 0x20, 0x3a, 0x34, 0x30, 0x2c,
+		0x29, 0x26, 0x25, 0x23, 0x21, 0x20, 0x1e, 0x1e
+	},
+	.cmd_mcs_gamma_delta_x = {
+		0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44, 0x44,
+		0x55, 0x55, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66
+	},
+};
+
+static const struct s6e63m0_info samsung_bose_panel_info = {
+	.flags = S6E63M0_INFO_FLAG_PGAMMACTL | S6E63M0_INFO_FLAG_GAMMA_DELTA,
+	.timing = {
+		.pixelclock.typ		= 24000000,
+		.hactive.typ		= 480,
+		.hfront_porch.typ	= 16,
+		.hback_porch.typ	= 14,
+		.hsync_len.typ		= 2,
+		.vactive.typ		= 800,
+		.vfront_porch.typ	= 28,
+		.vback_porch.typ	= 1,
+		.vsync_len.typ		= 2,
+		.flags			= DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+					  DISPLAY_FLAGS_DE_LOW | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+	},
+	.cmd_mcs_panelctl = {
+		0x01,	/* DOCT */	0x27,	/* CLWEA */
+		0x27,	/* CLWEB*/	0x07,	/* CLTE */
+		0x07,	/* SHE */	0x54,	/* FLTE */
+		0x9F,	/* FLWE */	0x63,	/* SCTE */
+		0x86,	/* SCWE */	0x1A,	/* INTE */
+		0x33,	/* INWE */	0x0D,	/* EMPS */
+		0x00,	/* E_INTE */	0x00	/* E_INWE */
+	},
+	.cmd_mcs_pgammactl_1 = {
+		0x02, 0x18, 0x08, 0x24, 0x70, 0x6e, 0x4e, 0xbc,
+		0xc0, 0xaf, 0xb3, 0xb8, 0xa5, 0xc5, 0xc7, 0xbb,
+		0x00, 0xb9, 0x00, 0xb8, 0x00, 0xfc
+	},
+	.cmd_mcs_pgammactl_2 = 0x03,
+	.cmd_mcs_gamma_delta_y = {
+		0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17, 0x13,
+		0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b, 0x1a, 0x17,
+		0x2b, 0x26, 0x22, 0x20, 0x3a, 0x34, 0x30, 0x2c,
+		0x29, 0x26, 0x25, 0x23, 0x21, 0x20, 0x1e, 0x1e
+	},
+	.cmd_mcs_gamma_delta_x = {
+		0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44, 0x44,
+		0x55, 0x55, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66
+	},
+};
+
+static int s6e63m0_dcs_write(struct udevice *dev, u8 cmd, const u8 *seq, size_t len)
+{
+	int ret;
+	u8 data[2];
+	int i;
+
+	data[0] = S6E63M0_DCS_CMD;
+	data[1] = cmd;
+
+	ret = dm_spi_xfer(dev, 9, &data, NULL, SPI_XFER_ONCE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < len; i++) {
+		data[0] = S6E63M0_DCS_DATA;
+		data[1] = seq[i];
+
+		ret = dm_spi_xfer(dev, 9, &data, NULL, SPI_XFER_ONCE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+#define s6e63m0_dcs_write_seq_static(dev, cmd, seq ...) ({	\
+	static const u8 d[] = { seq };				\
+	ret = s6e63m0_dcs_write(dev, cmd, d, ARRAY_SIZE(d));	\
+	if (ret)						\
+		return ret;					\
+})
+
+static int s6e63m0_enable_backlight(struct udevice *dev)
+{
+	struct s6e63m0_priv *priv = dev_get_priv(dev);
+	struct s6e63m0_info *info = priv->info;
+	u8 cmd_mcs_ifctl[MCS_IFCTL_LEN];
+	int ret;
+
+	ret = s6e63m0_dcs_write(dev, MCS_PANELCTL, info->cmd_mcs_panelctl, MCS_PANELCTL_LEN);
+	if (ret)
+		return ret;
+
+	s6e63m0_dcs_write_seq_static(dev, MCS_DISCTL,
+				     0x02,	/* Number of Line */
+				     0x03,	/* VBP */
+				     0x1c,	/* VFP */
+				     0x10,	/* HBP */
+				     0x10);	/* HFP */
+
+	cmd_mcs_ifctl[0] = priv->gtcon;	/* GTCON */
+	cmd_mcs_ifctl[1] = 0x00;	/* Display Mode */
+	cmd_mcs_ifctl[2] = 0x00;	/* Vsync/Hsync, DOCCLK, RGB mode */
+	ret = s6e63m0_dcs_write(dev, MCS_IFCTL, cmd_mcs_ifctl, MCS_IFCTL_LEN);
+	if (ret)
+		return ret;
+
+	if (info->flags & S6E63M0_INFO_FLAG_PGAMMACTL) {
+		ret = s6e63m0_dcs_write(dev, MCS_PGAMMACTL, info->cmd_mcs_pgammactl_1,
+					MCS_PGAMMACTL_LEN);
+		if (ret)
+			return ret;
+
+		s6e63m0_dcs_write(dev, MCS_PGAMMACTL, &info->cmd_mcs_pgammactl_2, 1);
+	}
+
+	s6e63m0_dcs_write_seq_static(dev, MCS_SRCCTL, 0x00, 0x8e, 0x07);
+	s6e63m0_dcs_write_seq_static(dev, MCS_PENTILE_1, 0x6c);
+
+	if (info->flags & S6E63M0_INFO_FLAG_GAMMA_DELTA) {
+		ret = s6e63m0_dcs_write(dev, MCS_GAMMA_DELTA_Y_RED, info->cmd_mcs_gamma_delta_y,
+					MCS_GAMMA_DELTA_Y_LEN);
+		if (ret)
+			return ret;
+
+		ret = s6e63m0_dcs_write(dev, MCS_GAMMA_DELTA_X_RED, info->cmd_mcs_gamma_delta_x,
+					MCS_GAMMA_DELTA_X_LEN);
+		if (ret)
+			return ret;
+
+		ret = s6e63m0_dcs_write(dev, MCS_GAMMA_DELTA_Y_GREEN, info->cmd_mcs_gamma_delta_y,
+					MCS_GAMMA_DELTA_Y_LEN);
+		if (ret)
+			return ret;
+
+		ret = s6e63m0_dcs_write(dev, MCS_GAMMA_DELTA_X_GREEN, info->cmd_mcs_gamma_delta_x,
+					MCS_GAMMA_DELTA_X_LEN);
+		if (ret)
+			return ret;
+
+		ret = s6e63m0_dcs_write(dev, MCS_GAMMA_DELTA_Y_BLUE, info->cmd_mcs_gamma_delta_y,
+					MCS_GAMMA_DELTA_Y_LEN);
+		if (ret)
+			return ret;
+
+		ret = s6e63m0_dcs_write(dev, MCS_GAMMA_DELTA_X_BLUE, info->cmd_mcs_gamma_delta_x,
+					MCS_GAMMA_DELTA_X_LEN);
+		if (ret)
+			return ret;
+	}
+
+	s6e63m0_dcs_write_seq_static(dev, MIPI_DCS_EXIT_SLEEP_MODE);
+	s6e63m0_dcs_write_seq_static(dev, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
+static int s6e63m0_set_backlight(struct udevice *dev, int percent)
+{
+	return 0;
+}
+
+static int s6e63m0_get_display_timing(struct udevice *dev, struct display_timing *timing)
+{
+	struct s6e63m0_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->info->timing, sizeof(*timing));
+
+	return 0;
+}
+
+static int s6e63m0_of_to_plat(struct udevice *dev)
+{
+	struct s6e63m0_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "vdd3-supply", &priv->vdd3);
+	if (ret) {
+		log_debug("%s: cannot get vdd3-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vci-supply", &priv->vci);
+	if (ret) {
+		log_debug("%s: cannot get vci-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: cannot decode reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	if (dev_read_bool(dev, "flip-horizontal"))
+		priv->gtcon |= S6E63M0_GTCON_FLAG_FLIP_H;
+
+	if (dev_read_bool(dev, "flip-vertical"))
+		priv->gtcon |= S6E63M0_GTCON_FLAG_FLIP_V;
+
+	return 0;
+}
+
+static int s6e63m0_hw_init(struct udevice *dev)
+{
+	struct s6e63m0_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error entering reset (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->vdd3, 1);
+	if (ret) {
+		log_debug("%s: enabling vdd3-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(1);
+
+	ret = regulator_set_enable_if_allowed(priv->vci, 1);
+	if (ret) {
+		log_debug("%s: enabling vci-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(26);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error exiting reset (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(10);
+
+	return 0;
+}
+
+static int s6e63m0_probe(struct udevice *dev)
+{
+	struct s6e63m0_priv *priv = dev_get_priv(dev);
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+	int ret;
+
+	if (device_get_uclass_id(dev->parent) != UCLASS_SPI)
+		return -EPROTONOSUPPORT;
+
+	ret = spi_claim_bus(slave);
+	if (ret) {
+		log_err("SPI bus allocation failed (%d)\n", ret);
+		return ret;
+	}
+
+	priv->info = (struct s6e63m0_info *)dev_get_driver_data(dev);
+
+	return s6e63m0_hw_init(dev);
+}
+
+static const struct panel_ops s6e63m0_ops = {
+	.enable_backlight	= s6e63m0_enable_backlight,
+	.set_backlight		= s6e63m0_set_backlight,
+	.get_display_timing	= s6e63m0_get_display_timing,
+};
+
+static const struct udevice_id s6e63m0_ids[] = {
+	{
+		.compatible = "samsung,s6e63m0",
+		.data = (ulong)&s6e63m0_generic_info
+	},
+	{
+		.compatible = "samsung,bose-panel",
+		.data = (ulong)&samsung_bose_panel_info
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(samsung_s6e63m0) = {
+	.name		= "samsung_s6e63m0",
+	.id		= UCLASS_PANEL,
+	.of_match	= s6e63m0_ids,
+	.ops		= &s6e63m0_ops,
+	.of_to_plat	= s6e63m0_of_to_plat,
+	.probe		= s6e63m0_probe,
+	.priv_auto	= sizeof(struct s6e63m0_priv),
+};
-- 
2.50.0

