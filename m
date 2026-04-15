Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47562F433D0
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 00:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A2A84214;
	Thu, 16 Apr 2026 01:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="OA66VIs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5834083B99; Wed, 15 Apr 2026 21:03:38 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BBDD83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 21:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so34307035ad.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776279813; x=1776884613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0zmzh+p+i1uf3NCJK8YNpCw+27Psm4ZyhOVuEEH7kbM=;
 b=OA66VIs5LAkPEsvf5Pz6lHDdNS11fHASJgt2a5lbjiKyTECFre0YF8J8M2/sUp/kF+
 ClLTQ9hpuPchdRl3RIBqjkYIEoIE9znDfRS+l0DiwnK64Gn9FqtkUlefI6a4XpCBq0Cw
 F517NDh61c3i0BQPLFVwsZKm48QIN3qrBN6Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776279813; x=1776884613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zmzh+p+i1uf3NCJK8YNpCw+27Psm4ZyhOVuEEH7kbM=;
 b=B8TJtBzmzQManR505nE0TqYuM/nTzYI+p3BYj0F9N8XSrUHmcQ9eeJxZxmplGK+uYv
 /b2Xsc1vy1YI+HlYuei2qfismx1SPURCds96qip6laAI69saJWF3lZpvsQ7k5Evbibrp
 XansOinheJ1QAJ6rKEKiZf8ES7j77cI56nQ7Kb6uo1XA7pvfZB8vp2W5lt/euFLS+a7V
 LKHEV/xoHwIO7kHhcg58osQJPjcZK/nVQlgbYcDvoxUw/6oG/2zkLpfOf39eYQl4RpRL
 rnqTpM8HZ8FaVw0I3URBl1FcnQNBrwMj2EFxlWYYGr3zi2LLmSeHa30X8BQfyPIpD/mC
 MC8w==
X-Gm-Message-State: AOJu0YzI+odSRGQzV+mCYLJtD2USEJ36zvLpgfguCDCZ1qFtDVbt8BI2
 s2i2a6QrTNZg11t3tsZa7MAUAm63ppV/cQ1HcTbURRW5Wvld8hAqR/Us8NzBTd12HSf2cjpGyRt
 2v+XeQiY=
X-Gm-Gg: AeBDievog926Os9fkMBVoGpeaFHHRMwphBGAg/8pcM9jJ/ojujphEFzDaL+TovCf5og
 B7ajSTCIbjH7dWaUEaNOLC/fL3BSn6YslhoBlvPe89rljngPt9yxROALW+1IviJwpUCphEzYTpe
 hPfueueK8hiZP6oIinDSC4EnQzTG7VXp1X0mfPwXPuuPGrzIYF++paAEOJJUcI8FUkxRX011ZS8
 cBRcMjzQrXwfMczVeVdkiIJ/mFFXNAmvjBl5zjP8KO7PmJFUtESaRicLro6q6CWTK/wwiFlrXrl
 16ROmDcF+heiivPNioHuM5MRmlKzSyI4HZqmW9dtZH9nfKk2pUNZCsiUGLS5QHOzjrdcX/iooWe
 6i18RXjRNitKwHOK37HhAQsJBySo5aPYnZcyv4hTQjY2miP0WvNWucQqrvskG9oNCSCzc8N1cpX
 2mqaQvaSRFDmjypK9BSSdMWEChqi0BSkYkCLzFJjUWB6WlzZ7OHb+rScpkHfbO04HmEgG+Yav1U
 QWpK0okRB8hnIQU9A31+G80CXz7wVbi
X-Received: by 2002:a17:903:320e:b0:2b0:606b:6fd3 with SMTP id
 d9443c01a7336-2b2d591d2e8mr212095075ad.5.1776279812772; 
 Wed, 15 Apr 2026 12:03:32 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com
 ([14.139.108.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780efa9fsm27667505ad.12.2026.04.15.12.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:03:32 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: u-boot@lists.denx.de
Cc: jd@denx.de, tl@denx.de, trini@konsulko.com,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
Date: Thu, 16 Apr 2026 00:33:21 +0530
Message-Id: <20260415190321.120706-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 01:59:51 +0200
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

Add support for the ITE IT66121 DPI-to-HDMI bridge chip. The IT66121
converts parallel RGB/DPI video input to HDMI output. It is found on
boards like the BeaglePlay where the TI AM625 SoC's DPI output is
routed to an HDMI connector through this chip.

The driver is based on the IT66121 Programmer Guide and the Linux
kernel driver drivers/gpu/drm/bridge/ite-it66121.c.

Tested on BeaglePlay hardware with HDMI output via TI TIDSS.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 drivers/video/bridge/Kconfig   |  10 +
 drivers/video/bridge/Makefile  |   1 +
 drivers/video/bridge/it66121.c | 535 +++++++++++++++++++++++++++++++++
 3 files changed, 546 insertions(+)
 create mode 100644 drivers/video/bridge/it66121.c

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 5322a002928..175e836e2f3 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -44,6 +44,16 @@ config VIDEO_BRIDGE_ANALOGIX_ANX6345
 	 The Analogix ANX6345 is RGB-to-DP converter. It enables an eDP LCD
 	 panel to be connected to an parallel LCD interface.
 
+config VIDEO_BRIDGE_ITE_IT66121
+	bool "Support ITE IT66121 DPI->HDMI bridge"
+	depends on VIDEO_BRIDGE
+	select DM_I2C
+	help
+	 The ITE IT66121 is a DPI-to-HDMI bridge chip. It converts a parallel
+	 RGB/DPI video input to an HDMI output. This is used on boards like
+	 the BeaglePlay where the SoC's DPI output is connected to an HDMI
+	 connector via this bridge chip.
+
 config VIDEO_BRIDGE_SOLOMON_SSD2825
 	bool "Solomon SSD2825 bridge driver"
 	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
diff --git a/drivers/video/bridge/Makefile b/drivers/video/bridge/Makefile
index 520f36a7a6f..bd048b7333e 100644
--- a/drivers/video/bridge/Makefile
+++ b/drivers/video/bridge/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_VIDEO_BRIDGE_PARADE_DP501) += dp501.o
 obj-$(CONFIG_VIDEO_BRIDGE_PARADE_PS862X) += ps862x.o
 obj-$(CONFIG_VIDEO_BRIDGE_NXP_PTN3460) += ptn3460.o
 obj-$(CONFIG_VIDEO_BRIDGE_ANALOGIX_ANX6345) += anx6345.o
+obj-$(CONFIG_VIDEO_BRIDGE_ITE_IT66121) += it66121.o
 obj-$(CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825) += ssd2825.o
 obj-$(CONFIG_VIDEO_BRIDGE_TOSHIBA_TC358768) += tc358768.o
 obj-$(CONFIG_VIDEO_BRIDGE_LVDS_CODEC) += lvds-codec.o
diff --git a/drivers/video/bridge/it66121.c b/drivers/video/bridge/it66121.c
new file mode 100644
index 00000000000..11c46768341
--- /dev/null
+++ b/drivers/video/bridge/it66121.c
@@ -0,0 +1,535 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <edid.h>
+#include <log.h>
+#include <video_bridge.h>
+#include <linux/delay.h>
+
+#define IT66121_VENDOR_ID0		0x00
+#define IT66121_VENDOR_ID1		0x01
+#define IT66121_DEVICE_ID0		0x02
+#define IT66121_DEVICE_ID1		0x03
+
+#define IT66121_VENDOR_ID0_VAL		0x54
+#define IT66121_VENDOR_ID1_VAL		0x49
+#define IT66121_DEVICE_ID0_VAL		0x12
+#define IT66121_DEVICE_ID1_MASK		0x0F
+#define IT66121_DEVICE_ID1_VAL		0x06
+
+#define IT66121_SW_RST			0x04
+#define IT66121_SW_RST_REF		BIT(5)
+#define IT66121_SW_RST_AREF		BIT(4)
+#define IT66121_SW_RST_VID		BIT(3)
+#define IT66121_SW_RST_AUD		BIT(2)
+#define IT66121_SW_RST_HDCP		BIT(0)
+
+#define IT66121_CLK_BANK_REG		0x0F
+#define IT66121_CLK_BANK_PWROFF_RCLK	BIT(6)
+#define IT66121_CLK_BANK_PWROFF_TXCLK	BIT(4)
+#define IT66121_CLK_BANK_SEL		0x03
+
+#define IT66121_SYS_STATUS		0x0E
+#define IT66121_SYS_STATUS_HPD		BIT(6)
+
+#define IT66121_INT_MASK1		0x09
+#define IT66121_INT_MASK2		0x0A
+#define IT66121_INT_MASK3		0x0B
+
+#define IT66121_PCLK_CNT_REG		0x05
+
+#define IT66121_DDC_MASTER_SEL		0x10
+#define IT66121_DDC_HEADER		0x11
+#define IT66121_DDC_REQOFF		0x12
+#define IT66121_DDC_REQCOUNT		0x13
+#define IT66121_DDC_EDIDSEG		0x14
+#define IT66121_DDC_CMD			0x15
+#define IT66121_DDC_STATUS		0x16
+#define IT66121_DDC_READFIFO		0x17
+
+#define IT66121_DDC_STATUS_DONE		BIT(7)
+#define IT66121_DDC_STATUS_ERROR_MASK	(BIT(5) | BIT(4) | BIT(3))
+
+#define IT66121_DDC_CMD_EDID_RD		0x03
+#define IT66121_DDC_CMD_FIFO_CLR	0x09
+#define IT66121_DDC_CMD_ABORT		0x0F
+
+#define IT66121_INPUT_MODE		0x70
+#define IT66121_INPUT_MODE_RGB		0x00
+
+#define IT66121_INPUT_CSC		0x72
+#define IT66121_INPUT_CSC_NO_CONV	0x00
+
+#define IT66121_AFE_DRV_REG		0x61
+#define IT66121_AFE_DRV_RST		BIT(4)
+#define IT66121_AFE_XP_REG		0x62
+#define IT66121_AFE_IP_REG		0x64
+#define IT66121_AFE_XP_EC1		0x68
+
+#define IT66121_HDMI_MODE		0xC0
+#define IT66121_HDMI_MODE_HDMI		BIT(0)
+
+#define IT66121_AV_MUTE		0xC1
+#define IT66121_AV_MUTE_ON		BIT(0)
+
+#define IT66121_PKT_GEN_CTRL		0xC6
+#define IT66121_PKT_GEN_CTRL_RPT	BIT(1)
+#define IT66121_PKT_GEN_CTRL_EN		BIT(0)
+
+#define IT66121_DDC_FIFO_SIZE		32
+#define IT66121_EDID_SLAVE_ADDR		0xA0
+#define IT66121_EDID_BUF_SIZE		EDID_EXT_SIZE
+
+struct it66121_priv {
+	u8 edid[IT66121_EDID_BUF_SIZE];
+	int edid_len;
+};
+
+static int it66121_reg_read(struct udevice *dev, u8 reg, u8 *val)
+{
+	return dm_i2c_read(dev, reg, val, 1);
+}
+
+static int it66121_reg_write(struct udevice *dev, u8 reg, u8 val)
+{
+	return dm_i2c_write(dev, reg, &val, 1);
+}
+
+static int it66121_reg_set(struct udevice *dev, u8 reg, u8 mask, u8 val)
+{
+	u8 orig;
+	int ret;
+
+	ret = it66121_reg_read(dev, reg, &orig);
+	if (ret)
+		return ret;
+
+	orig = (orig & ~mask) | (val & mask);
+
+	return it66121_reg_write(dev, reg, orig);
+}
+
+static int it66121_identify(struct udevice *dev)
+{
+	u8 v0, v1, d0, d1;
+	int ret;
+
+	ret = it66121_reg_read(dev, IT66121_VENDOR_ID0, &v0);
+	if (ret)
+		return ret;
+	ret = it66121_reg_read(dev, IT66121_VENDOR_ID1, &v1);
+	if (ret)
+		return ret;
+	ret = it66121_reg_read(dev, IT66121_DEVICE_ID0, &d0);
+	if (ret)
+		return ret;
+	ret = it66121_reg_read(dev, IT66121_DEVICE_ID1, &d1);
+	if (ret)
+		return ret;
+
+	if (v0 != IT66121_VENDOR_ID0_VAL || v1 != IT66121_VENDOR_ID1_VAL ||
+	    d0 != IT66121_DEVICE_ID0_VAL ||
+	    (d1 & IT66121_DEVICE_ID1_MASK) != IT66121_DEVICE_ID1_VAL) {
+		debug("IT66121: chip not found (vendor=%02x%02x dev=%02x%02x)\n",
+		      v1, v0, d1, d0);
+		return -ENODEV;
+	}
+
+	debug("IT66121: found chip (vendor=%02x%02x dev=%02x%02x)\n",
+	      v1, v0, d1, d0);
+	return 0;
+}
+
+static int it66121_hw_init(struct udevice *dev)
+{
+	int ret;
+
+	ret = it66121_reg_set(dev, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_RCLK, 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_SEL, 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_PCLK_CNT_REG, BIT(0), 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AFE_DRV_REG, BIT(5), 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, BIT(6) | BIT(2), 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, BIT(6), 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AFE_DRV_REG, BIT(4), 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, BIT(3), BIT(3));
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, BIT(2), BIT(2));
+	if (ret)
+		return ret;
+
+	/* Keep AREF/VID/AUD/HDCP in reset, leave REF clock running. */
+	ret = it66121_reg_write(dev, IT66121_SW_RST,
+				IT66121_SW_RST_AREF | IT66121_SW_RST_VID |
+				IT66121_SW_RST_AUD | IT66121_SW_RST_HDCP);
+	if (ret)
+		return ret;
+
+	mdelay(5);
+
+	ret = it66121_reg_write(dev, IT66121_HDMI_MODE, 0x00);
+	if (ret)
+		return ret;
+	ret = it66121_reg_write(dev, IT66121_AV_MUTE, 0x00);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_write(dev, IT66121_INT_MASK1, 0xFF);
+	if (ret)
+		return ret;
+	ret = it66121_reg_write(dev, IT66121_INT_MASK2, 0xFF);
+	if (ret)
+		return ret;
+	ret = it66121_reg_write(dev, IT66121_INT_MASK3, 0xFF);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int it66121_ddc_wait(struct udevice *dev)
+{
+	u8 status;
+	int i, ret;
+
+	for (i = 0; i < 200; i++) {
+		ret = it66121_reg_read(dev, IT66121_DDC_STATUS, &status);
+		if (ret)
+			return ret;
+
+		if (status & IT66121_DDC_STATUS_DONE)
+			return 0;
+
+		if (status & IT66121_DDC_STATUS_ERROR_MASK) {
+			debug("IT66121: DDC error status=0x%02x\n", status);
+			return -EIO;
+		}
+
+		mdelay(2);
+	}
+
+	debug("IT66121: DDC timeout\n");
+	return -ETIMEDOUT;
+}
+
+static int it66121_ddc_fifo_clear(struct udevice *dev)
+{
+	int ret;
+
+	ret = it66121_reg_write(dev, IT66121_DDC_CMD,
+				IT66121_DDC_CMD_FIFO_CLR);
+	if (ret)
+		return ret;
+
+	return it66121_ddc_wait(dev);
+}
+
+static int it66121_read_edid_block(struct udevice *dev, u8 *buf,
+				   int offset, int segment, int len)
+{
+	int ret, i, bytes_read = 0;
+
+	while (bytes_read < len) {
+		int chunk = len - bytes_read;
+
+		if (chunk > IT66121_DDC_FIFO_SIZE)
+			chunk = IT66121_DDC_FIFO_SIZE;
+
+		ret = it66121_reg_write(dev, IT66121_DDC_MASTER_SEL, 0x01);
+		if (ret)
+			return ret;
+
+		ret = it66121_ddc_fifo_clear(dev);
+		if (ret)
+			return ret;
+
+		ret = it66121_reg_write(dev, IT66121_DDC_HEADER,
+					IT66121_EDID_SLAVE_ADDR);
+		if (ret)
+			return ret;
+
+		ret = it66121_reg_write(dev, IT66121_DDC_REQOFF,
+					(offset + bytes_read) & 0xFF);
+		if (ret)
+			return ret;
+
+		ret = it66121_reg_write(dev, IT66121_DDC_REQCOUNT, chunk);
+		if (ret)
+			return ret;
+
+		ret = it66121_reg_write(dev, IT66121_DDC_EDIDSEG, segment);
+		if (ret)
+			return ret;
+
+		ret = it66121_reg_write(dev, IT66121_DDC_CMD,
+					IT66121_DDC_CMD_EDID_RD);
+		if (ret)
+			return ret;
+
+		ret = it66121_ddc_wait(dev);
+		if (ret) {
+			debug("IT66121: EDID read failed at offset %d\n",
+			      offset + bytes_read);
+			it66121_reg_write(dev, IT66121_DDC_CMD,
+					  IT66121_DDC_CMD_ABORT);
+			return ret;
+		}
+
+		for (i = 0; i < chunk; i++) {
+			ret = it66121_reg_read(dev, IT66121_DDC_READFIFO,
+					       &buf[bytes_read + i]);
+			if (ret)
+				return ret;
+		}
+
+		bytes_read += chunk;
+	}
+
+	return bytes_read;
+}
+
+static int it66121_setup_afe(struct udevice *dev, unsigned long pclk_khz)
+{
+	int ret;
+
+	ret = it66121_reg_write(dev, IT66121_AFE_DRV_REG, IT66121_AFE_DRV_RST);
+	if (ret)
+		return ret;
+
+	if (pclk_khz > 80000) {
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, 0x90, 0x80);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, 0x89, 0x80);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_EC1, 0x10, 0x00);
+		if (ret)
+			return ret;
+	} else {
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_REG, 0x90, 0x10);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_IP_REG, 0x89, 0x09);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_EC1, 0x10, 0x10);
+		if (ret)
+			return ret;
+	}
+
+	ret = it66121_reg_set(dev, IT66121_SW_RST,
+			      IT66121_SW_RST_REF | IT66121_SW_RST_VID, 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_write(dev, IT66121_AFE_DRV_REG, 0x00);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Basic HDMI RGB output; AVI InfoFrame programming is not implemented. */
+static int it66121_setup_video(struct udevice *dev, unsigned long pclk_khz)
+{
+	int ret;
+
+	ret = it66121_reg_set(dev, IT66121_AV_MUTE,
+			      IT66121_AV_MUTE_ON, IT66121_AV_MUTE_ON);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_write(dev, IT66121_HDMI_MODE,
+				IT66121_HDMI_MODE_HDMI);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_TXCLK,
+			      IT66121_CLK_BANK_PWROFF_TXCLK);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_write(dev, IT66121_INPUT_MODE,
+				IT66121_INPUT_MODE_RGB);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_write(dev, IT66121_INPUT_CSC,
+				IT66121_INPUT_CSC_NO_CONV);
+	if (ret)
+		return ret;
+
+	ret = it66121_setup_afe(dev, pclk_khz);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_TXCLK, 0);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_write(dev, IT66121_PKT_GEN_CTRL,
+				IT66121_PKT_GEN_CTRL_RPT |
+				IT66121_PKT_GEN_CTRL_EN);
+	if (ret)
+		return ret;
+
+	ret = it66121_reg_set(dev, IT66121_AV_MUTE, IT66121_AV_MUTE_ON, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int it66121_attach(struct udevice *dev)
+{
+	struct it66121_priv *priv = dev_get_priv(dev);
+	unsigned long pclk_khz;
+	u8 status;
+	int ret;
+
+	ret = video_bridge_set_active(dev, true);
+	if (ret) {
+		debug("IT66121: set_active failed: %d\n", ret);
+		return ret;
+	}
+
+	mdelay(50);
+
+	ret = it66121_identify(dev);
+	if (ret)
+		return ret;
+
+	ret = it66121_hw_init(dev);
+	if (ret) {
+		debug("IT66121: hw_init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = it66121_reg_read(dev, IT66121_SYS_STATUS, &status);
+	if (ret)
+		return ret;
+
+	if (!(status & IT66121_SYS_STATUS_HPD)) {
+		debug("IT66121: no HPD, skipping EDID read\n");
+		return 0;
+	}
+
+	ret = it66121_read_edid_block(dev, priv->edid, 0, 0, 128);
+	if (ret < 0) {
+		debug("IT66121: EDID block 0 read failed: %d\n", ret);
+		return ret;
+	}
+
+	priv->edid_len = 128;
+
+	if (priv->edid[0x7E] > 0) {
+		ret = it66121_read_edid_block(dev, priv->edid + 128,
+					      128, 0, 128);
+		if (ret < 0)
+			debug("IT66121: EDID block 1 read failed: %d\n", ret);
+		else
+			priv->edid_len = 256;
+	}
+
+	/* Preferred DTD pixel clock: bytes 54-55, units of 10 kHz. */
+	pclk_khz = ((unsigned long)priv->edid[55] << 8 |
+		     priv->edid[54]) * 10;
+	if (pclk_khz > 0) {
+		debug("IT66121: configuring video for %lu kHz pclk\n",
+		      pclk_khz);
+		ret = it66121_setup_video(dev, pclk_khz);
+		if (ret)
+			debug("IT66121: setup_video failed: %d\n", ret);
+	}
+
+	return 0;
+}
+
+static int it66121_check_attached(struct udevice *dev)
+{
+	u8 status;
+	int ret;
+
+	ret = it66121_reg_read(dev, IT66121_SYS_STATUS, &status);
+	if (ret)
+		return ret;
+
+	if (status & IT66121_SYS_STATUS_HPD)
+		return 0;
+
+	return -ENOTCONN;
+}
+
+static int it66121_read_edid(struct udevice *dev, u8 *buf, int buf_size)
+{
+	struct it66121_priv *priv = dev_get_priv(dev);
+	int size;
+
+	if (!priv->edid_len)
+		return -ENODATA;
+
+	size = min_t(int, buf_size, priv->edid_len);
+	memcpy(buf, priv->edid, size);
+
+	return size;
+}
+
+static int it66121_probe(struct udevice *dev)
+{
+	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
+		return -EPROTONOSUPPORT;
+
+	debug("IT66121: probed on I2C bus\n");
+	return 0;
+}
+
+static const struct video_bridge_ops it66121_ops = {
+	.attach		= it66121_attach,
+	.check_attached	= it66121_check_attached,
+	.read_edid	= it66121_read_edid,
+};
+
+static const struct udevice_id it66121_ids[] = {
+	{ .compatible = "ite,it66121" },
+	{ }
+};
+
+U_BOOT_DRIVER(ite_it66121) = {
+	.name		= "ite_it66121",
+	.id		= UCLASS_VIDEO_BRIDGE,
+	.of_match	= it66121_ids,
+	.probe		= it66121_probe,
+	.ops		= &it66121_ops,
+	.priv_auto	= sizeof(struct it66121_priv),
+};
-- 
2.34.1

