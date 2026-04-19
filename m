Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC72F588C1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CA28439F;
	Mon, 20 Apr 2026 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="M2jSKKFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F2284258; Mon, 20 Apr 2026 13:11:54 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F322883E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so1700406a91.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776683510; x=1777288310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9tQ5M7bQZVPhVWxFdc+UhBM2yIaWLQR+xBXil3n/Pw=;
 b=M2jSKKFa9CILpZ0wQ5g5KTRPcH1Ott0lRuW5pXIlapueC3agPmUdu2rdGLOzVCD08I
 MPv5zJOGajDPKwGVRa3Ed2Cw6DE0dId4OFKOZw9rfi2zDJT+FcrqgwuVpTNgOhBlPL4A
 xhCRtV3u9uOblHR0wD8oq3AxZJ+QcycQH378g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776683510; x=1777288310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9tQ5M7bQZVPhVWxFdc+UhBM2yIaWLQR+xBXil3n/Pw=;
 b=eJUWovLk4yYBNjZLQQzFzIVpk7JJQY4cHZuj59a+ozdmK64Xdpr7MPlE3RRsm1lHjV
 IXutkqdBLOrguL86r7rpXBxcyPg2yxixHWMwjpugIY2H8eldV5uSaYezs0GvENoKbXmJ
 7G23Pj7sX4QQ/OHKNjhbcc1WO/irWdprBWbF/mfcct+1w9NRSN3fwTcgzwKxbTgRXQeM
 d87Ii1Ap71Z8qMmk3DWh/JohBqjkwQBWHbPM9aF5roZ8yDcl5oEZQ3O8dUEzMWYAYnyc
 H6icipdFBr4C6AfB5/sjGNLVkwI2FUo5tSNq1f1XohbQ5F/IjrgL+JPAwlaic9+kkLFx
 tZaQ==
X-Gm-Message-State: AOJu0Yw+yX5Fz3Pq7GqdWOcNnVDt/hz0Kz3Ki1kYo3U0D/s7K/8Hk2XS
 KfY3FI0B3sJKU2cGl2NqM8OtpMYSePkHyJXB+F6VKn4EXUSccoL/dhm9C6vkl8N/ilW1Er7qheM
 iOUap8wA=
X-Gm-Gg: AeBDietbYIbvw+if/ocRjgfURtffaZdM/QdE71fGaj3VUD5Moz/Q8Y9p7HykdCZuYl4
 s2zyNj2oA23sirSNNmtk7XGYb/i1SXFK4HI8DSpjOdOz74U3AS5xwjsPrx/Mp3lKEx/y1nBYxyv
 E4mB8+gtzbV+VQPiiNLOk7VLdgrCif5jb8o7spdDOBQlOMELBb+5PdPCawa3nNlQ2L2UhcmMWNb
 UF4sGvtHUf3ISaTGaGyN61FSW6PvE9ftovt2tKw3wVDujWio93mR9rz5vD9v5w7DhqG4K2eW+Nc
 KzvyhQaubDpzzfT/gQZxh+susJI5xlSTmLV6kARcSQL4h0Ms+8zIM+9rKZh9wawC/v+PMGuif80
 MxR2uhGVoZeXOofu0g6UZzTMEa6AGiX/dt4L0glJ+gCwwb0t3c0CjSwQfubfiGyNn5OqXqr49aS
 6zhuYLFNsF76NxcPSpkSyqQTO44yZ4J6w1uXjHAGZGDfWqDB3uZQheKaUeAMNuK63EtVVOkwIPW
 m4xn2swgMu0KKb7dD/UvF05q4eeNeYy
X-Received: by 2002:a17:90b:5106:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-361403d5c41mr11887522a91.4.1776683509846; 
 Mon, 20 Apr 2026 04:11:49 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com
 ([14.139.108.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm98792685ad.68.2026.04.20.04.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 04:11:49 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: u-boot@lists.denx.de
Cc: jd@denx.de, tl@denx.de, trini@konsulko.com, sjg@chromium.org,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v2 1/2] video: bridge: add ITE IT66121 DPI-to-HDMI bridge
 driver
Date: Sun, 19 Apr 2026 23:05:39 +0530
Message-ID: <20260419173541.31592-2-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
References: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:39 +0200
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
Changes in v2:
 - Use lowercase hex literals consistently.
 - Include <linux/bitops.h> explicitly for BIT().
 - Replace bare AFE mask/value magic numbers with named
   IT66121_AFE_{XP,IP,XP_EC1}_PCLK_{MASK,HIGH,LOW} defines and add a
   block comment referencing the Programmer Guide "AFE Setting" section.
 - Switch EDID pixel-clock extraction from hand-rolled byte 54/55
   parsing to edid_get_timing().
 - Add a comment in it66121_attach() explaining that the
   video_bridge_set_active() call is a no-op on BeaglePlay (no
   reset/enable GPIOs in DT); the chip relies on its internal POR
   plus the software reset sequence in it66121_hw_init().
 - Propagate it66121_setup_video() failure instead of swallowing it.
---
 drivers/video/bridge/Kconfig   |  10 +
 drivers/video/bridge/Makefile  |   1 +
 drivers/video/bridge/it66121.c | 580 +++++++++++++++++++++++++++++++++
 3 files changed, 591 insertions(+)
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
index 00000000000..79bef2f23e1
--- /dev/null
+++ b/drivers/video/bridge/it66121.c
@@ -0,0 +1,580 @@
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
+#include <linux/bitops.h>
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
+#define IT66121_DEVICE_ID1_MASK		0x0f
+#define IT66121_DEVICE_ID1_VAL		0x06
+
+#define IT66121_SW_RST			0x04
+#define IT66121_SW_RST_REF		BIT(5)
+#define IT66121_SW_RST_AREF		BIT(4)
+#define IT66121_SW_RST_VID		BIT(3)
+#define IT66121_SW_RST_AUD		BIT(2)
+#define IT66121_SW_RST_HDCP		BIT(0)
+
+#define IT66121_CLK_BANK_REG		0x0f
+#define IT66121_CLK_BANK_PWROFF_RCLK	BIT(6)
+#define IT66121_CLK_BANK_PWROFF_TXCLK	BIT(4)
+#define IT66121_CLK_BANK_SEL		0x03
+
+#define IT66121_SYS_STATUS		0x0e
+#define IT66121_SYS_STATUS_HPD		BIT(6)
+
+#define IT66121_INT_MASK1		0x09
+#define IT66121_INT_MASK2		0x0a
+#define IT66121_INT_MASK3		0x0b
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
+#define IT66121_DDC_CMD_ABORT		0x0f
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
+/*
+ * IT66121 AFE (Analog Front End) PLL settings depend on the pixel
+ * clock. The values below program the XP/IP/EC1 registers for pclks
+ * above and up to 80 MHz, as described in the IT66121 Programmer
+ * Guide, "AFE Setting" section.
+ */
+#define IT66121_AFE_XP_PCLK_MASK	0x90
+#define IT66121_AFE_XP_PCLK_HIGH	0x80	/* pclk > 80 MHz */
+#define IT66121_AFE_XP_PCLK_LOW		0x10	/* pclk <= 80 MHz */
+
+#define IT66121_AFE_IP_PCLK_MASK	0x89
+#define IT66121_AFE_IP_PCLK_HIGH	0x80
+#define IT66121_AFE_IP_PCLK_LOW		0x09
+
+#define IT66121_AFE_XP_EC1_PCLK_MASK	0x10
+#define IT66121_AFE_XP_EC1_PCLK_HIGH	0x00
+#define IT66121_AFE_XP_EC1_PCLK_LOW	0x10
+
+#define IT66121_AFE_PCLK_HIGH_THRESHOLD	80000	/* kHz */
+
+#define IT66121_HDMI_MODE		0xc0
+#define IT66121_HDMI_MODE_HDMI		BIT(0)
+
+#define IT66121_AV_MUTE			0xc1
+#define IT66121_AV_MUTE_ON		BIT(0)
+
+#define IT66121_PKT_GEN_CTRL		0xc6
+#define IT66121_PKT_GEN_CTRL_RPT	BIT(1)
+#define IT66121_PKT_GEN_CTRL_EN		BIT(0)
+
+#define IT66121_DDC_FIFO_SIZE		32
+#define IT66121_EDID_SLAVE_ADDR		0xa0
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
+	ret = it66121_reg_write(dev, IT66121_INT_MASK1, 0xff);
+	if (ret)
+		return ret;
+	ret = it66121_reg_write(dev, IT66121_INT_MASK2, 0xff);
+	if (ret)
+		return ret;
+	ret = it66121_reg_write(dev, IT66121_INT_MASK3, 0xff);
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
+	if (pclk_khz > IT66121_AFE_PCLK_HIGH_THRESHOLD) {
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_REG,
+				      IT66121_AFE_XP_PCLK_MASK,
+				      IT66121_AFE_XP_PCLK_HIGH);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_IP_REG,
+				      IT66121_AFE_IP_PCLK_MASK,
+				      IT66121_AFE_IP_PCLK_HIGH);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_EC1,
+				      IT66121_AFE_XP_EC1_PCLK_MASK,
+				      IT66121_AFE_XP_EC1_PCLK_HIGH);
+		if (ret)
+			return ret;
+	} else {
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_REG,
+				      IT66121_AFE_XP_PCLK_MASK,
+				      IT66121_AFE_XP_PCLK_LOW);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_IP_REG,
+				      IT66121_AFE_IP_PCLK_MASK,
+				      IT66121_AFE_IP_PCLK_LOW);
+		if (ret)
+			return ret;
+		ret = it66121_reg_set(dev, IT66121_AFE_XP_EC1,
+				      IT66121_AFE_XP_EC1_PCLK_MASK,
+				      IT66121_AFE_XP_EC1_PCLK_LOW);
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
+	struct display_timing timing;
+	unsigned long pclk_khz;
+	int bpp;
+	u8 status;
+	int ret;
+
+	/*
+	 * Toggle reset-gpios / enable-gpios if present in DT. With no such
+	 * GPIOs configured (as on BeaglePlay) this is a no-op and we rely
+	 * on the chip's internal power-on reset plus the software reset
+	 * sequence performed in it66121_hw_init().
+	 */
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
+	if (priv->edid[0x7e] > 0) {
+		ret = it66121_read_edid_block(dev, priv->edid + 128,
+					      128, 0, 128);
+		if (ret < 0)
+			debug("IT66121: EDID block 1 read failed: %d\n", ret);
+		else
+			priv->edid_len = 256;
+	}
+
+	ret = edid_get_timing(priv->edid, priv->edid_len, &timing, &bpp);
+	if (ret) {
+		debug("IT66121: edid_get_timing failed: %d\n", ret);
+		return ret;
+	}
+
+	pclk_khz = timing.pixelclock.typ / 1000;
+	debug("IT66121: configuring video for %lu kHz pclk\n", pclk_khz);
+
+	ret = it66121_setup_video(dev, pclk_khz);
+	if (ret) {
+		debug("IT66121: setup_video failed: %d\n", ret);
+		return ret;
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

