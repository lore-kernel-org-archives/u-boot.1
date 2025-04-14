Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D69C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DB3820DE;
	Mon, 14 Apr 2025 08:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gBRzwkPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B648205B; Mon, 14 Apr 2025 08:01:12 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D789681F7B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso712708466b.2
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610469; x=1745215269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOEA32acGemnyXVp7B14W0KGkMhMCMc1fqPRlmgYp04=;
 b=gBRzwkPcqnawvpOOXE7UA7jNqzfi7zJUd9YVo+eF4CIrcUrPOicmreSTtNEWp2b+m6
 VdpILgsJu1FYqwLA7AIYSAq1a6CDDjMfoAx337LDKpCt+xUnpT+RzQnM7LL71qpceA7f
 gYtiDgLysHEccV81mKUcjrLBTfyRKD5b7RIRNRl/Dx5HgQG6uc/cai+Q7/tHco0fr5TD
 ESDH0W6WhZFJToB/ljAX9Y45ypJ9ZTaPfcdrx9NduWXBtGG++Ko6airGlNHmypZT/Y8e
 qmOe1Esce4UMAjrJ0u+t5Xl72ZjJTi0FxZJ3dFTBjeCoTcf4FSlHecDUqOTrsB7h8FvO
 O2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610469; x=1745215269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOEA32acGemnyXVp7B14W0KGkMhMCMc1fqPRlmgYp04=;
 b=vVU5XzDZbDEhGDGGbL/fRFYwSCgFQc/Maz6/mw7aW4rFcn/Byi52KMRGLJttuQiW6k
 MWCilv2eVMb9XlGe/38Q+m3qWlkFw2ondpOtP+8itmo3moHnMU68KeyKaK8mlYltSVWZ
 s3iYc/rXZzrmpVkd1IkeXPB+g8gvrIxKLkpHraU+x9odCi/h6Yo1ac1/oxr0A4DXzc5i
 7LY8elNC0u8ASWw597Wd0N5Esf/22r6+UnUd2YYwsEjyTbhP62DJGwPbkL/WIlz9QOfS
 Sm9jKq9zkp2rL1t9ImWXcBS9FXFd5qrjBV1vTSKsikEOby9umDBv29ds6eDJOC2vL+HL
 a/eA==
X-Gm-Message-State: AOJu0YzNAJ/QDZterymXpm/jZWvvO9po10ICfXrYws3oaK5xSmOYl41q
 UxlxHjz0VinUSDOFpFP3IKpyOp2cKXYmq8mVpCbFJEuuqIT+OmhE
X-Gm-Gg: ASbGncs9B02/SpOnYMLI93c99OBZ0NpHUCS2xczWwpVoWH+/QAANjEe5HhaihwPVfrP
 7xTliBs8I98Z+CI/uFlozXDEKiAIKTkfFwj07fEQcVLOSvZ6+BU0rxMvqIScpjVfQ+0tsWIy00C
 04yqANhCOEru5ugzj3k0XQa3X2MHNqGEExLHl1HM4ZYVKxCuC8LlYzZYerO2mCOwGi3wNu1HpdJ
 qzqeBq6h3csunPT/2FUlIqoNPMfJ42bBHYnJSRog57jmhRS4NgQJ2lujRikij1fMvHnpXQ7xU4y
 HLFlQqxR49lz5Pp7O4ZIFmZ7ozspAy0n
X-Google-Smtp-Source: AGHT+IEKsIPXvzB1FEqrzw9r1kk+y4eCTGKhboipcXgBYVaXAOR1C3O6p9fwGI96LqCGndcnelOiyQ==
X-Received: by 2002:a17:907:7250:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-acad343b25dmr969841966b.7.1744610468980; 
 Sun, 13 Apr 2025 23:01:08 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/9] video: tegra: add 8-bit CPU driven protocol
Date: Mon, 14 Apr 2025 09:00:15 +0300
Message-ID: <20250414060021.14545-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

Add support for 8-bit CPU driven (primary and secondary) display signal
interface found in Tegra 2 and Tegra 3 SoC.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/dc.h |  48 ++++
 drivers/video/tegra/Kconfig          |  10 +
 drivers/video/tegra/Makefile         |   1 +
 drivers/video/tegra/cpu-bridge.c     | 325 +++++++++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/video/tegra/cpu-bridge.c

diff --git a/arch/arm/include/asm/arch-tegra/dc.h b/arch/arm/include/asm/arch-tegra/dc.h
index 2fd07403bdf..ab12cc9c7d0 100644
--- a/arch/arm/include/asm/arch-tegra/dc.h
+++ b/arch/arm/include/asm/arch-tegra/dc.h
@@ -448,10 +448,19 @@ enum win_color_depth_id {
 #define LVS_OUTPUT_POLARITY_LOW		BIT(28)
 #define LSC0_OUTPUT_POLARITY_LOW	BIT(24)
 
+/* DC_COM_PIN_OUTPUT_SELECT6 0x31a */
+#define LDC_OUTPUT_SELECT_V_PULSE1	BIT(14) /* 100b */
+
 /* DC_DISP_DISP_SIGNAL_OPTIONS0 0x400 */
 #define H_PULSE0_ENABLE		BIT(8)
 #define H_PULSE1_ENABLE		BIT(10)
 #define H_PULSE2_ENABLE		BIT(12)
+#define V_PULSE0_ENABLE		BIT(16)
+#define V_PULSE1_ENABLE		BIT(18)
+#define V_PULSE2_ENABLE		BIT(19)
+#define V_PULSE3_ENABLE		BIT(20)
+#define M0_ENABLE		BIT(24)
+#define M1_ENABLE		BIT(26)
 
 /* DC_DISP_DISP_WIN_OPTIONS 0x402 */
 #define	CURSOR_ENABLE		BIT(16)
@@ -525,6 +534,28 @@ enum {
 	BASE_COLOR_SIZE_888,
 };
 
+/* DC_DISP_SHIFT_CLOCK_OPTIONS 0x431 */
+#define SC0_H_QUALIFIER_SHIFT	0
+#define SC1_H_QUALIFIER_SHIFT	16
+enum {
+	SC_H_QUALIFIER_DISABLE,
+	SC_H_QUALIFIER_NONE,
+	SC_H_QUALIFIER_HACTIVE,
+	SC_H_QUALIFIER_EXT_HACTIVE,
+	SC_H_QUALIFIER_HPULSE,
+	SC_H_QUALIFIER_EXT_HPULSE,
+};
+#define SC0_V_QUALIFIER_SHIFT	3
+#define SC1_V_QUALIFIER_SHIFT	19
+enum {
+	SC_V_QUALIFIER_NONE,
+	SC_V_QUALIFIER_RSVD,
+	SC_V_QUALIFIER_VACTIVE,
+	SC_V_QUALIFIER_EXT_VACTIVE,
+	SC_V_QUALIFIER_VPULSE,
+	SC_V_QUALIFIER_EXT_VPULSE,
+};
+
 /* DC_DISP_DATA_ENABLE_OPTIONS 0x432 */
 #define DE_SELECT_SHIFT		0
 #define DE_SELECT_MASK		(0x3 << DE_SELECT_SHIFT)
@@ -541,6 +572,23 @@ enum {
 	DE_CONTROL_ACTIVE_BLANK,
 };
 
+/* DC_DISP_INIT_SEQ_CONTROL 0x442 */
+#define SEND_INIT_SEQUENCE		BIT(0)
+#define INIT_SEQUENCE_MODE_SPI		BIT(1)
+#define INIT_SEQUENCE_MODE_PLCD		0x0
+#define INIT_SEQ_DC_SIGNAL_SHIFT	4
+#define INIT_SEQ_DC_SIGNAL_MASK		(0x7 << INIT_SEQ_DC_SIGNAL_SHIFT)
+enum {
+	NO_DC_SIGNAL,
+	DC_SIGNAL_VSYNC,
+	DC_SIGNAL_VPULSE0,
+	DC_SIGNAL_VPULSE1,
+	DC_SIGNAL_VPULSE2,
+	DC_SIGNAL_VPULSE3,
+};
+#define INIT_SEQ_DC_CONTROL_SHIFT	7
+#define FRAME_INIT_SEQ_CYCLES_SHIFT	8
+
 /* DC_WIN_WIN_OPTIONS 0x700 */
 #define H_DIRECTION		BIT(0)
 enum {
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
index d3b8dbb2826..88607e0498b 100644
--- a/drivers/video/tegra/Kconfig
+++ b/drivers/video/tegra/Kconfig
@@ -42,6 +42,16 @@ config TEGRA_BACKLIGHT_PWM
 	   Enable support for the Display Controller dependent PWM backlight
 	   found in the Tegra SoC and usually used with DSI panels.
 
+config TEGRA_8BIT_CPU_BRIDGE
+	bool "Enable 8 bit panel communication protocol for Tegra 20/30"
+	depends on VIDEO_BRIDGE && DM_GPIO
+	select VIDEO_TEGRA
+	select VIDEO_MIPI_DSI
+	help
+	   Tegra 20 and Tegra 30 feature 8 bit CPU driver panel control
+	   protocol. This option allows use it as a MIPI DSI bridge to
+	   set up and control compatible panel.
+
 config VIDEO_TEGRA124
 	bool "Enable video support on Tegra124"
 	help
diff --git a/drivers/video/tegra/Makefile b/drivers/video/tegra/Makefile
index 3c50a0ba3c3..4995c93a8af 100644
--- a/drivers/video/tegra/Makefile
+++ b/drivers/video/tegra/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_VIDEO_TEGRA) += dc.o
 obj-$(CONFIG_VIDEO_DSI_TEGRA) += dsi.o mipi.o mipi-phy.o
 obj-$(CONFIG_VIDEO_HDMI_TEGRA) += hdmi.o
 obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += dc-pwm-backlight.o
+obj-$(CONFIG_TEGRA_8BIT_CPU_BRIDGE) += cpu-bridge.o
 
 obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
diff --git a/drivers/video/tegra/cpu-bridge.c b/drivers/video/tegra/cpu-bridge.c
new file mode 100644
index 00000000000..e5fefe028f0
--- /dev/null
+++ b/drivers/video/tegra/cpu-bridge.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ *
+ * This driver uses 8-bit CPU interface found in Tegra 2
+ * and Tegra 3 to drive MIPI DSI panel.
+ */
+
+#include <dm.h>
+#include <dm/ofnode_graph.h>
+#include <log.h>
+#include <mipi_display.h>
+#include <mipi_dsi.h>
+#include <backlight.h>
+#include <panel.h>
+#include <video_bridge.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+
+#include "dc.h"
+
+struct tegra_cpu_bridge_priv {
+	struct dc_ctlr *dc;
+
+	struct mipi_dsi_host host;
+	struct mipi_dsi_device device;
+
+	struct udevice *panel;
+	struct display_timing timing;
+
+	struct gpio_desc dc_gpio;
+	struct gpio_desc rw_gpio;
+	struct gpio_desc cs_gpio;
+
+	struct gpio_desc data_gpios[8];
+
+	u32 pixel_format;
+	u32 spi_init_seq[4];
+};
+
+#define TEGRA_CPU_BRIDGE_COMM 0
+#define TEGRA_CPU_BRIDGE_DATA 1
+
+static void tegra_cpu_bridge_write(struct tegra_cpu_bridge_priv *priv,
+				   u8 type, u8 value)
+{
+	int i;
+
+	dm_gpio_set_value(&priv->dc_gpio, type);
+
+	dm_gpio_set_value(&priv->cs_gpio, 0);
+	dm_gpio_set_value(&priv->rw_gpio, 0);
+
+	for (i = 0; i < 8; i++)
+		dm_gpio_set_value(&priv->data_gpios[i],
+				  (value >> i) & 0x1);
+
+	dm_gpio_set_value(&priv->cs_gpio, 1);
+	dm_gpio_set_value(&priv->rw_gpio, 1);
+
+	udelay(10);
+
+	log_debug("%s: type 0x%x, val 0x%x\n",
+		  __func__, type, value);
+}
+
+static ssize_t tegra_cpu_bridge_transfer(struct mipi_dsi_host *host,
+					 const struct mipi_dsi_msg *msg)
+{
+	struct udevice *dev = (struct udevice *)host->dev;
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+	u8 command = *(u8 *)msg->tx_buf;
+	const u8 *data = msg->tx_buf;
+	int i;
+
+	tegra_cpu_bridge_write(priv, TEGRA_CPU_BRIDGE_COMM, command);
+
+	for (i = 1; i < msg->tx_len; i++)
+		tegra_cpu_bridge_write(priv, TEGRA_CPU_BRIDGE_DATA, data[i]);
+
+	return 0;
+}
+
+static const struct mipi_dsi_host_ops tegra_cpu_bridge_host_ops = {
+	.transfer	= tegra_cpu_bridge_transfer,
+};
+
+static int tegra_cpu_bridge_get_format(enum mipi_dsi_pixel_format format, u32 *fmt)
+{
+	switch (format) {
+	case MIPI_DSI_FMT_RGB888:
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		*fmt = BASE_COLOR_SIZE_888;
+		break;
+
+	case MIPI_DSI_FMT_RGB666:
+		*fmt = BASE_COLOR_SIZE_666;
+		break;
+
+	case MIPI_DSI_FMT_RGB565:
+		*fmt = BASE_COLOR_SIZE_565;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tegra_cpu_bridge_attach(struct udevice *dev)
+{
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+	struct dc_disp_reg *disp = &priv->dc->disp;
+	struct dc_cmd_reg *cmd = &priv->dc->cmd;
+	struct dc_com_reg *com = &priv->dc->com;
+	u32 value;
+	int ret;
+
+	writel(CTRL_MODE_STOP << CTRL_MODE_SHIFT, &cmd->disp_cmd);
+	writel(0, &disp->disp_win_opt);
+	writel(GENERAL_UPDATE, &cmd->state_ctrl);
+	writel(GENERAL_ACT_REQ, &cmd->state_ctrl);
+
+	/* TODO: parametrize if needed */
+	writel(V_PULSE1_ENABLE, &disp->disp_signal_opt0);
+	writel(PULSE_POLARITY_LOW, &disp->v_pulse1.v_pulse_ctrl);
+
+	writel(PULSE_END(1), &disp->v_pulse1.v_pulse_pos[V_PULSE0_POSITION_A]);
+	writel(0, &disp->v_pulse1.v_pulse_pos[V_PULSE0_POSITION_B]);
+	writel(0, &disp->v_pulse1.v_pulse_pos[V_PULSE0_POSITION_C]);
+
+	ret = dev_read_u32_array(dev, "nvidia,init-sequence", priv->spi_init_seq, 4);
+	if (!ret) {
+		value = 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
+			DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
+			INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
+		writel(value, &disp->seq_ctrl);
+
+		writel(priv->spi_init_seq[0], &disp->spi_init_seq_data_a);
+		writel(priv->spi_init_seq[1], &disp->spi_init_seq_data_b);
+		writel(priv->spi_init_seq[2], &disp->spi_init_seq_data_c);
+		writel(priv->spi_init_seq[3], &disp->spi_init_seq_data_d);
+	}
+
+	value = readl(&cmd->disp_cmd);
+	value &= ~CTRL_MODE_MASK;
+	value |= CTRL_MODE_C_DISPLAY << CTRL_MODE_SHIFT;
+	writel(value, &cmd->disp_cmd);
+
+	/* set LDC pin to V Pulse 1 */
+	value = readl(&com->pin_output_sel[6]) | LDC_OUTPUT_SELECT_V_PULSE1;
+	writel(value, &com->pin_output_sel[6]);
+
+	value = readl(&disp->disp_interface_ctrl);
+	value |= DATA_ALIGNMENT_LSB << DATA_ALIGNMENT_SHIFT;
+	writel(value, &disp->disp_interface_ctrl);
+
+	value = SC_H_QUALIFIER_NONE << SC1_H_QUALIFIER_SHIFT |
+		SC_V_QUALIFIER_VACTIVE << SC0_V_QUALIFIER_SHIFT |
+		SC_H_QUALIFIER_HACTIVE << SC0_H_QUALIFIER_SHIFT;
+	writel(value, &disp->shift_clk_opt);
+
+	value = readl(&disp->disp_color_ctrl);
+	value |= priv->pixel_format;
+	writel(value, &disp->disp_color_ctrl);
+
+	/* Perform panel setup */
+	panel_enable_backlight(priv->panel);
+
+	dm_gpio_set_value(&priv->cs_gpio, 0);
+
+	dm_gpio_free(dev, &priv->dc_gpio);
+	dm_gpio_free(dev, &priv->rw_gpio);
+	dm_gpio_free(dev, &priv->cs_gpio);
+
+	gpio_free_list(dev, priv->data_gpios, 8);
+
+	return 0;
+}
+
+static int tegra_cpu_bridge_set_panel(struct udevice *dev, int percent)
+{
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+
+	return panel_set_backlight(priv->panel, percent);
+}
+
+static int tegra_cpu_bridge_panel_timings(struct udevice *dev,
+					  struct display_timing *timing)
+{
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->timing, sizeof(*timing));
+
+	return 0;
+}
+
+static int tegra_cpu_bridge_hw_init(struct udevice *dev)
+{
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+
+	dm_gpio_set_value(&priv->cs_gpio, 1);
+
+	dm_gpio_set_value(&priv->rw_gpio, 1);
+	dm_gpio_set_value(&priv->dc_gpio, 0);
+
+	return 0;
+}
+
+static int tegra_cpu_bridge_get_links(struct udevice *dev)
+{
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+	int i, ret;
+
+	u32 num = ofnode_graph_get_port_count(dev_ofnode(dev));
+
+	for (i = 0; i < num; i++) {
+		ofnode remote = ofnode_graph_get_remote_node(dev_ofnode(dev), i, -1);
+
+		/* Look for DC source */
+		if (ofnode_name_eq(remote, "rgb")) {
+			ofnode dc = ofnode_get_parent(remote);
+
+			priv->dc = (struct dc_ctlr *)ofnode_get_addr(dc);
+			if (!priv->dc) {
+				log_err("%s: failed to get DC controller\n", __func__);
+				return -EINVAL;
+			}
+		}
+
+		/* Look for driven panel */
+		ret = uclass_get_device_by_ofnode(UCLASS_PANEL, remote, &priv->panel);
+		if (!ret)
+			return 0;
+	}
+
+	/* If this point is reached, no panels were found */
+	return -ENODEV;
+}
+
+static int tegra_cpu_bridge_probe(struct udevice *dev)
+{
+	struct tegra_cpu_bridge_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_device *device = &priv->device;
+	struct mipi_dsi_panel_plat *mipi_plat;
+	int ret;
+
+	ret = tegra_cpu_bridge_get_links(dev);
+	if (ret) {
+		log_debug("%s: links not found, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	panel_get_display_timing(priv->panel, &priv->timing);
+
+	mipi_plat = dev_get_plat(priv->panel);
+	mipi_plat->device = device;
+
+	priv->host.dev = (struct device *)dev;
+	priv->host.ops = &tegra_cpu_bridge_host_ops;
+
+	device->host = &priv->host;
+	device->lanes = mipi_plat->lanes;
+	device->format = mipi_plat->format;
+	device->mode_flags = mipi_plat->mode_flags;
+
+	tegra_cpu_bridge_get_format(device->format, &priv->pixel_format);
+
+	/* get control gpios */
+	ret = gpio_request_by_name(dev, "dc-gpios", 0,
+				   &priv->dc_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not decode dc-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "rw-gpios", 0,
+				   &priv->rw_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not decode rw-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "cs-gpios", 0,
+				   &priv->cs_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not decode cs-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	/* get data gpios */
+	ret = gpio_request_list_by_name(dev, "data-gpios",
+					priv->data_gpios, 8,
+					GPIOD_IS_OUT);
+	if (ret < 0) {
+		log_debug("%s: could not decode data-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	return tegra_cpu_bridge_hw_init(dev);
+}
+
+static const struct video_bridge_ops tegra_cpu_bridge_ops = {
+	.attach			= tegra_cpu_bridge_attach,
+	.set_backlight		= tegra_cpu_bridge_set_panel,
+	.get_display_timing	= tegra_cpu_bridge_panel_timings,
+};
+
+static const struct udevice_id tegra_cpu_bridge_ids[] = {
+	{ .compatible = "nvidia,tegra-8bit-cpu" },
+	{ }
+};
+
+U_BOOT_DRIVER(tegra_8bit_cpu) = {
+	.name		= "tegra_8bit_cpu",
+	.id		= UCLASS_VIDEO_BRIDGE,
+	.of_match	= tegra_cpu_bridge_ids,
+	.ops		= &tegra_cpu_bridge_ops,
+	.bind		= dm_scan_fdt_dev,
+	.probe		= tegra_cpu_bridge_probe,
+	.priv_auto	= sizeof(struct tegra_cpu_bridge_priv),
+};
-- 
2.43.0

