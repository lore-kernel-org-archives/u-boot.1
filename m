Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1665DC48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBF287B71;
	Wed, 31 Jan 2024 07:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NghvwtDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D6187C46; Wed, 31 Jan 2024 07:57:48 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5888799C
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51109060d6aso4729821e87.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684266; x=1707289066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ht6/Qe6+9/9PP9uR5Z+NET/sVf+lZbOIgbl2Townhjk=;
 b=NghvwtDHEiFaPLRLdJoSC8bBXTzy4+HocvT8RQnN8lEtDPF/OyG6mo24wZgf96YHYh
 9cwQHuv2/nGqj7xSWF7dosvUhtS4j+t4A4944EY5kecD+x2SJtasaog7UuoWKCTU7A1i
 pWE8bhl0aPFcCLSkpIa90lZQESjwD8oD/WKGj2geULlZHefLBaZje2VHpti7Ea4mdiSd
 Cp2eL5jal+4qNSdfcTZr319oYwG6XgJX4T+bZL3749zY5BhDXvELKv+DEp3//Q7wMdAx
 jF87I6FPDzGyFF+LnqrQa+2OyFgk+Kdcl++Wqn43waRFJKqmPV/2bWHC5WqQlH8jMr+u
 PDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684266; x=1707289066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ht6/Qe6+9/9PP9uR5Z+NET/sVf+lZbOIgbl2Townhjk=;
 b=MljcJwyo6APPHpdak7i7DTwd0+9dl624tMfQyJi881d2EcF1+skPnjs07Z8MgHV9uu
 GMfPpS4QB0MSl+f9b01YhsneYhqxM33qUh7Ixx5LqEia+M6PEZMoSdO32RE21yuDDdyC
 3p5P4ZQIPtqrssLbdowJj+diiCf8eIxl+qqrwvzgWA7syOdSLcyfEUItBhCgWhVEhEN3
 29AdkN9C+MTaDUzL2/EBkExNH4R7Uht1JCRcRQd0FYNVBu6/66lX1VeSGigQTYaOzjuY
 oh7XDFLaJnFFEUP5cu8kg6nJ31AUBseXOwi+iBk90U1oeYjlC2KfiMeDl6Yc+Jxh/fHF
 ocEQ==
X-Gm-Message-State: AOJu0YyLM6G3cQqly6zqAqh8LVmb/NFPhFx22BZeQZnm+jQkc/UHE7fD
 9j0oYurhExY1ewfaK7CmssboSGwIK/QL3Nja+d/pHPTDPEvfnZE0
X-Google-Smtp-Source: AGHT+IEJDQiD8MZjchIfrd3Dl5ZQuWuefxWobA+bHFSxMkzxM8o0i6woqlCOV5pCsvdQcUPb+a/fLA==
X-Received: by 2002:ac2:428a:0:b0:511:e75:7fae with SMTP id
 m10-20020ac2428a000000b005110e757faemr521692lfh.66.1706684265689; 
 Tue, 30 Jan 2024 22:57:45 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX/R8lvFGK7M6bdaiovPCJNYZGxzaKvXpvxg6vIc3g1NRsd63KF9UjddO22KMZkU2WMpjeT7IoMRoV4mLXk8gS6OxxI3k5y2ElTN0Q6MpS6aahxYTUVIvTucvQlSKNXHZs6gvSyLB6p74Ix0gZLGdbWLFUxoa+cHsISbtqu130bVuxxqIrTGiXEPHBV/cUdcMGFRae51Q==
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 s11-20020a19770b000000b0051023c2e95asm1760796lfc.209.2024.01.30.22.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 22:57:45 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/7] video: bridge: add basic support for the Parade DP501
 transmitter
Date: Wed, 31 Jan 2024 08:57:18 +0200
Message-Id: <20240131065721.4245-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240131065721.4245-1-clamor95@gmail.com>
References: <20240131065721.4245-1-clamor95@gmail.com>
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

The Parade DP501 is a DP & DVI/HDMI dual-mode transmitter. It
enables an RGB/Parallel SOC output to be converted, packed and
serialized into either DP or TMDS output device. Only DisplayPort
functionality of this transmitter has been implemented and tested.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/Kconfig  |  10 +
 drivers/video/bridge/Makefile |   1 +
 drivers/video/bridge/dp501.c  | 579 ++++++++++++++++++++++++++++++++++
 3 files changed, 590 insertions(+)
 create mode 100644 drivers/video/bridge/dp501.c

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 6a9e7c1454..ab91727372 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -7,6 +7,16 @@ config VIDEO_BRIDGE
 	  requires LVDS, an eDP->LVDS bridge chip can be used to provide the
 	  necessary conversion. This option enables support for these devices.
 
+config VIDEO_BRIDGE_PARADE_DP501
+	bool "Support Parade DP501 DP & DVI/HDMI dual mode transmitter"
+	depends on PANEL && DM_GPIO
+	select DM_I2C
+	help
+	  The Parade DP501 is a DP & DVI/HDMI dual-mode transmitter. It
+	  enables an RGB/Parallel SOC output to be converted, packed and
+	  serialized into either DP or TMDS output device. Only DisplayPort
+	  functionality of this transmitter has been implemented and tested.
+
 config VIDEO_BRIDGE_PARADE_PS862X
 	bool "Support Parade PS862X DP->LVDS bridge"
 	depends on VIDEO_BRIDGE
diff --git a/drivers/video/bridge/Makefile b/drivers/video/bridge/Makefile
index ed3e7e9ce1..58697e3cbe 100644
--- a/drivers/video/bridge/Makefile
+++ b/drivers/video/bridge/Makefile
@@ -4,6 +4,7 @@
 #  Written by Simon Glass <sjg@chromium.org>
 
 obj-$(CONFIG_VIDEO_BRIDGE) += video-bridge-uclass.o
+obj-$(CONFIG_VIDEO_BRIDGE_PARADE_DP501) += dp501.o
 obj-$(CONFIG_VIDEO_BRIDGE_PARADE_PS862X) += ps862x.o
 obj-$(CONFIG_VIDEO_BRIDGE_NXP_PTN3460) += ptn3460.o
 obj-$(CONFIG_VIDEO_BRIDGE_ANALOGIX_ANX6345) += anx6345.o
diff --git a/drivers/video/bridge/dp501.c b/drivers/video/bridge/dp501.c
new file mode 100644
index 0000000000..095e3e71fe
--- /dev/null
+++ b/drivers/video/bridge/dp501.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Jonas Schwöbel <jonasschwoebel@yahoo.de>
+ * Copyright (C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <backlight.h>
+#include <panel.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <power/regulator.h>
+
+#include <asm/gpio.h>
+
+/* TOP */
+#define TOPCFG0			0x00
+#define ROMI2C_PRESCALE		0x01
+#define HDCPI2C_PRESCALE	0x02
+#define GPIO			0x03
+#define GPIO_OUT_ENB		0x04
+#define TESTI2C_CTL		0x05
+#define I2CMTIMEOUT		0x06
+#define TOPCFG1			0x07
+#define TOPCFG2			0x08
+#define TOPCFG3			0x09
+#define TOPCFG4			0x0A
+#define CLKSWRST		0x0B
+#define CADETB_CTL		0x0C
+
+/* Video Attribute */
+#define HTOTAL_L		0x10
+#define HTOTAL_H		0x11
+#define HSTART_L		0x12
+#define HSTART_H		0x13
+#define HWIDTH_L		0x14
+#define HWIDTH_H		0x15
+#define VTOTAL_L		0x16
+#define VTOTAL_H		0x17
+#define VSTART_L		0x18
+#define VSTART_H		0x19
+#define VHEIGHT_L		0x1A
+#define VHEIGHT_H		0x1B
+#define HSPHSW_L		0x1C
+#define HSPHSW_H		0x1D
+#define VSPVSW_L		0x1E
+#define VSPVSW_H		0x1F
+#define MISC0			0x20
+#define MISC1			0x21
+
+/* Video Capture */
+#define VCAPCTRL0		0x24
+#define VCAPCTRL1		0x25
+#define VCAPCTRL2		0x26
+#define VCAPCTRL3		0x27
+#define VCAPCTRL4		0x28
+#define VCAP_MEASURE		0x29
+
+/* Main Link Control */
+#define NVID_L			0x2C
+#define NVID_M			0x2D
+#define NVID_H			0x2E
+#define LINK_CTRL0		0x2F
+#define LINK_CTRL1		0x30
+#define LINK_DEBUG		0x31
+#define ERR_POS			0x32
+#define ERR_PAT			0x33
+#define LINK_DEB_SEL		0x34
+#define IDLE_PATTERN		0x35
+#define TU_SIZE			0x36
+#define CRC_CTRL		0x37
+#define CRC_OUT			0x38
+
+/* AVI-2 InfoFrame */
+#define SD_CTRL0		0x3A
+#define SD_CTRL1		0x3B
+#define SD_HB0			0x3C
+#define SD_HB1			0x3D
+#define SD_HB2			0x3E
+#define SD_HB3			0x3F
+#define SD_DB0			0x40
+#define SD_DB1			0x41
+#define SD_DB2			0x42
+#define SD_DB3			0x43
+#define SD_DB4			0x44
+#define SD_DB5			0x45
+#define SD_DB6			0x46
+#define SD_DB7			0x47
+#define SD_DB8			0x48
+#define SD_DB9			0x49
+#define SD_DB10			0x4A
+#define SD_DB11			0x4B
+#define SD_DB12			0x4C
+#define SD_DB13			0x4D
+#define SD_DB14			0x4E
+#define SD_DB15			0x4F
+
+/* Aux Channel and PCS */
+#define DPCD_REV		0X50
+#define MAX_LINK_RATE		0x51
+#define MAX_LANE_COUNT		0x52
+#define MAX_DOWNSPREAD		0x53
+#define NORP			0x54
+#define DOWNSTRMPORT_PRE	0x55
+#define MLINK_CH_CODING		0x56
+#define RCV_P0_CAP0		0x58
+#define RCV_P0_CAP1		0x59
+#define RCV_P1_CAP0		0x5A
+#define RCV_P1_CAP1		0x5B
+#define DOWNSPREAD_CTL		0x5C
+#define LINK_BW			0x5D
+#define LANE_CNT		0x5E
+#define TRAINING_CTL		0x5F
+#define QUALTEST_CTL		0x60
+#define SINK_COUNT		0x61
+#define DEV_SERVICE_IRQ		0x62
+#define LANE01_STATUS		0x63
+#define LANE23_STATUS		0x64
+#define LANE_STATUS_UPDATE	0x65
+#define SINK_STATUS		0x66
+#define AUX_NOISE		0x67
+#define TEST_MODE		0x69
+#define TEST_PATTERN0		0x6A
+#define TEST_PATTERN1		0x6B
+#define TEST_PATTERN2		0x6C
+#define SIGNATURE		0x6D
+#define PCSCFG			0x6E
+#define AUXCTRL0		0x6f
+#define AUXCTRL2		0x70
+#define AUXCTRL1		0x71
+#define HPDCTL0			0x72
+#define HPDCTL1			0x73
+#define LINK_STATE_CTRL		0x74
+#define SWRST			0x75
+#define LINK_IRQ		0x76
+#define AUXIRQ_CTRL		0x77
+#define HPD2_IRQ_CTRL		0x78
+#define SW_TRAIN_CTRL		0x79
+#define SW_DRV_SET		0x7A
+#define SW_PRE_SET		0x7B
+#define DPCD_ADDR_L		0x7D
+#define DPCD_ADDR_M		0x7E
+#define DPCD_ADDR_H		0x7F
+#define DPCD_LENGTH		0x80
+#define DPCD_WDATA		0x81
+#define DPCD_RDATA		0x82
+#define DPCD_CTL		0x83
+#define DPCD_STATUS		0x84
+#define AUX_STATUS		0x85
+#define I2CTOAUX_RELENGTH	0x86
+#define AUX_RETRY_CTRL		0x87
+#define TIMEOUT_CTRL		0x88
+#define I2CCMD_OPT1		0x89
+#define AUXCMD_ERR_IRQ		0x8A
+#define AUXCMD_OPT2		0x8B
+#define HDCP_Reserved		0x8C
+
+/* Audio InfoFrame */
+#define TX_MVID0		0x90
+#define TX_MVID1		0x91
+#define TX_MVID2		0x92
+#define TX_MVID_OFF		0x93
+#define TX_MAUD0		0x94
+#define TX_MAUD1		0x95
+#define TX_MAUD2		0x96
+#define TX_MAUD_OFF		0x97
+#define MN_CTRL			0x98
+#define MOUT0			0x99
+#define MOUT1			0x9A
+#define MOUT2			0x9B
+
+/* Audio Control */
+#define NAUD_L			0x9F
+#define NAUD_M			0xA0
+#define NAUD_H			0xA1
+#define AUD_CTRL0		0xA2
+#define AUD_CTRL1		0xA3
+#define LANE_POL		0xAA
+#define LANE_EN			0xAB
+#define LANE_MAP		0xAC
+#define SCR_POLY0		0xAD
+#define SCR_POLY1		0xAE
+#define PRBS7_POLY		0xAF
+
+/* Video Pre-process */
+#define MISC_SHDOW		0xB0
+#define VCAPCPCTL0		0xB1
+#define VCAPCPCTL1		0xB2
+#define VCAPCPCTL2		0xB3
+#define CSCPAR			0xB4
+#define I2CTODPCDSTATUS2	0xBA
+#define AUXCTL_REG		0xBB
+
+/*   Page 2   */
+#define SEL_PIO1		0x24
+#define SEL_PIO2		0x25
+#define SEL_PIO3		0x26
+#define CHIP_VER_L		0x82
+
+struct dp501_priv {
+	struct udevice *panel;
+	struct display_timing timing;
+
+	struct udevice *chip2;
+
+	struct udevice *vdd;
+	struct gpio_desc reset_gpio;
+	struct gpio_desc enable_gpio;
+};
+
+static int dp501_sw_init(struct udevice *dev)
+{
+	struct dp501_priv *priv = dev_get_priv(dev);
+	int i;
+	u8 val;
+
+	dm_i2c_reg_write(dev, TOPCFG4, 0x30);
+	udelay(200);
+	dm_i2c_reg_write(dev, TOPCFG4, 0x0c);
+	dm_i2c_reg_write(dev, 0x8f, 0x02);
+
+	/* check for connected panel during 1 msec */
+	for (i = 0; i < 5; i++)	{
+		val = dm_i2c_reg_read(dev, 0x8d);
+		val &= BIT(2);
+		if (val)
+			break;
+
+		udelay(200);
+	}
+
+	if (!val) {
+		log_debug("%s: panel is not connected!\n", __func__);
+		return -ENODEV;
+	}
+
+	dm_i2c_reg_write(priv->chip2, SEL_PIO1, 0x02);
+	dm_i2c_reg_write(priv->chip2, SEL_PIO2, 0x04);
+	dm_i2c_reg_write(priv->chip2, SEL_PIO3, 0x10);
+
+	dm_i2c_reg_write(dev, LINK_STATE_CTRL, 0xa0);
+	dm_i2c_reg_write(dev, 0x8f, 0x02);
+	dm_i2c_reg_write(dev, TOPCFG1, 0x16);
+	dm_i2c_reg_write(dev, TOPCFG0, 0x24);
+	dm_i2c_reg_write(dev, HPD2_IRQ_CTRL, 0x30);
+	dm_i2c_reg_write(dev, AUXIRQ_CTRL, 0xff);
+	dm_i2c_reg_write(dev, LINK_IRQ, 0xff);
+
+	/* auto detect DVO timing */
+	dm_i2c_reg_write(dev, VCAPCTRL3, 0x30);
+
+	/* reset tpfifo at v blank */
+	dm_i2c_reg_write(dev, LINK_CTRL0, 0x82);
+
+	dm_i2c_reg_write(dev, VCAPCTRL4, 0x07);
+	dm_i2c_reg_write(dev, AUX_RETRY_CTRL, 0x7f);
+	dm_i2c_reg_write(dev, TIMEOUT_CTRL, 0x1e);
+	dm_i2c_reg_write(dev, AUXCTL_REG, 0x06);
+
+	/* DPCD readable */
+	dm_i2c_reg_write(dev, HPDCTL0, 0xa9);
+
+	/* Scramble on */
+	dm_i2c_reg_write(dev, QUALTEST_CTL, 0x00);
+
+	dm_i2c_reg_write(dev, 0x8f, 0x02);
+
+	dm_i2c_reg_write(dev, VCAPCTRL0, 0xc4);
+
+	/* set color depth 8bit (0x00: 6bit; 0x20: 8bit; 0x40: 10bit) */
+	dm_i2c_reg_write(dev, MISC0, 0x20);
+
+	dm_i2c_reg_write(dev, VCAPCPCTL2, 0x01);
+
+	/* check if bridge returns ready status */
+	for (i = 0; i < 5; i++)	{
+		val = dm_i2c_reg_read(dev, LINK_IRQ);
+		val &= BIT(0);
+		if (val)
+			break;
+
+		udelay(200);
+	}
+
+	if (!val) {
+		log_debug("%s: bridge is not ready\n", __func__);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void dpcd_configure(struct udevice *dev, u32 config, bool write)
+{
+	dm_i2c_reg_write(dev, DPCD_ADDR_L, (u8)(config >> 8));
+	dm_i2c_reg_write(dev, DPCD_ADDR_M, (u8)(config >> 16));
+	dm_i2c_reg_write(dev, DPCD_ADDR_H, (u8)((config >> 24) | BIT(7)));
+	dm_i2c_reg_write(dev, DPCD_LENGTH, 0x00);
+	dm_i2c_reg_write(dev, LINK_IRQ, 0x20);
+
+	if (write)
+		dm_i2c_reg_write(dev, DPCD_WDATA, (u8)(config & 0xff));
+
+	dm_i2c_reg_write(dev, DPCD_CTL, 0x01);
+
+	udelay(10);
+}
+
+static int dump_dpcd_data(struct udevice *dev, u32 config, u8 *data)
+{
+	int i;
+	u8 value;
+
+	dpcd_configure(dev, config, false);
+
+	value = dm_i2c_reg_read(dev, DPCD_CTL);
+	if (value)
+		return -ENODATA;
+
+	for (i = 0; i < 5; i++) {
+		value = dm_i2c_reg_read(dev, LINK_IRQ);
+		value &= BIT(5);
+		if (value)
+			break;
+
+		udelay(100);
+	}
+
+	if (!value)
+		return -ENODATA;
+
+	value = dm_i2c_reg_read(dev, DPCD_STATUS);
+	if (!(value & 0xe0))
+		*data = dm_i2c_reg_read(dev, DPCD_RDATA);
+	else
+		return -ENODATA;
+
+	return 0;
+}
+
+static int dp501_dpcd_dump(struct udevice *dev, u32 config, u8 *data)
+{
+	int i, ret;
+
+	for (i = 0; i < 5; i++) {
+		ret = dump_dpcd_data(dev, config, data);
+		if (!ret)
+			break;
+
+		udelay(100);
+	}
+
+	return ret;
+}
+
+static int dp501_reset_link(struct udevice *dev)
+{
+	dm_i2c_reg_write(dev, TRAINING_CTL, 0x00);
+	dm_i2c_reg_write(dev, SWRST, 0xf8);
+	dm_i2c_reg_write(dev, SWRST, 0x00);
+
+	return -ENODEV;
+}
+
+static int dp501_link_training(struct udevice *dev)
+{
+	int i, ret;
+	u8 lane, link, link_out;
+	u8 lane_cnt, lane01, lane23;
+
+	dpcd_configure(dev, 0x030000, true);
+	dpcd_configure(dev, 0x03011c, true);
+	dpcd_configure(dev, 0x0301f8, true);
+
+	ret = dp501_dpcd_dump(dev, 0x90000100, &link);
+	if (ret) {
+		log_debug("%s: link dump failed %d\n", __func__, ret);
+		return dp501_reset_link(dev);
+	}
+
+	ret = dp501_dpcd_dump(dev, 0x90000200, &lane);
+	if (ret) {
+		log_debug("%s: lane dump failed %d\n", __func__, ret);
+		return dp501_reset_link(dev);
+	}
+
+	/* Software trainig */
+	for (i = 10; i > 0; i--) {
+		dm_i2c_reg_write(dev, LINK_BW, link);
+		dm_i2c_reg_write(dev, LANE_CNT, lane | BIT(7));
+
+		link_out = dm_i2c_reg_read(dev, LINK_BW);
+		lane_cnt = dm_i2c_reg_read(dev, LANE_CNT);
+
+		if (link_out == link &&
+		    (lane_cnt == (lane | BIT(7))))
+			break;
+
+		udelay(500);
+	}
+
+	if (!i)
+		return dp501_reset_link(dev);
+
+	dm_i2c_reg_write(dev, LINK_STATE_CTRL, 0x00);
+	dm_i2c_reg_write(dev, TRAINING_CTL, 0x0d);
+
+	/* check if bridge returns link ready status */
+	for (i = 0; i < 100; i++) {
+		link_out = dm_i2c_reg_read(dev, LINK_IRQ);
+		link_out &= BIT(1);
+		if (link_out) {
+			dm_i2c_reg_write(dev, LINK_IRQ, 0xff);
+			break;
+		}
+
+		udelay(100);
+	}
+
+	if (!link_out) {
+		log_debug("%s: link prepare failed %d\n",
+			  __func__, link_out);
+		return dp501_reset_link(dev);
+	}
+
+	lane01 = dm_i2c_reg_read(dev, LANE01_STATUS);
+	lane23 = dm_i2c_reg_read(dev, LANE23_STATUS);
+
+	switch (lane_cnt & 0xf) {
+	case 4:
+		if (lane01 == 0x77 &&
+		    lane23 == 0x77)
+			return 0;
+		break;
+
+	case 2:
+		if (lane01 == 0x77)
+			return 0;
+		break;
+
+	default:
+		if ((lane01 & 7) == 7)
+			return 0;
+		break;
+	}
+
+	return dp501_reset_link(dev);
+}
+
+static int dp501_attach(struct udevice *dev)
+{
+	struct dp501_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dp501_sw_init(dev);
+	if (ret)
+		return ret;
+
+	mdelay(90);
+
+	ret = dp501_link_training(dev);
+	if (ret)
+		return ret;
+
+	/* Perform panel HW setup */
+	return panel_enable_backlight(priv->panel);
+}
+
+static int dp501_set_backlight(struct udevice *dev, int percent)
+{
+	struct dp501_priv *priv = dev_get_priv(dev);
+
+	return panel_set_backlight(priv->panel, percent);
+}
+
+static int dp501_panel_timings(struct udevice *dev,
+			       struct display_timing *timing)
+{
+	struct dp501_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->timing, sizeof(*timing));
+	return 0;
+}
+
+static void dp501_hw_init(struct dp501_priv *priv)
+{
+	dm_gpio_set_value(&priv->reset_gpio, 1);
+
+	regulator_set_enable_if_allowed(priv->vdd, 1);
+	dm_gpio_set_value(&priv->enable_gpio, 1);
+
+	udelay(100);
+
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+	mdelay(80);
+}
+
+static int dp501_setup(struct udevice *dev)
+{
+	struct dm_i2c_chip *chip = dev_get_parent_plat(dev);
+	struct dp501_priv *priv = dev_get_priv(dev);
+	struct udevice *bus = dev_get_parent(dev);
+	int ret;
+
+	/* get panel */
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL, dev,
+					   "panel", &priv->panel);
+	if (ret) {
+		log_debug("%s: Cannot get panel: ret=%d\n", __func__, ret);
+		return log_ret(ret);
+	}
+
+	/* get regulators */
+	ret = device_get_supply_regulator(dev, "power-supply", &priv->vdd);
+	if (ret) {
+		log_debug("%s: vddc regulator error: %d\n", __func__, ret);
+		if (ret != -ENOENT)
+			return log_ret(ret);
+	}
+
+	/* get gpios */
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: Could not decode reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0,
+				   &priv->enable_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: Could not decode enable-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = i2c_get_chip(bus, chip->chip_addr + 2, 1, &priv->chip2);
+	if (ret) {
+		log_debug("%s: cannot get second PMIC I2C chip (err %d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	dp501_hw_init(priv);
+
+	/* get EDID */
+	return panel_get_display_timing(priv->panel, &priv->timing);
+}
+
+static int dp501_probe(struct udevice *dev)
+{
+	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
+		return -EPROTONOSUPPORT;
+
+	return dp501_setup(dev);
+}
+
+struct panel_ops dp501_ops = {
+	.enable_backlight	= dp501_attach,
+	.set_backlight		= dp501_set_backlight,
+	.get_display_timing	= dp501_panel_timings,
+};
+
+static const struct udevice_id dp501_ids[] = {
+	{ .compatible = "parade,dp501" },
+	{ }
+};
+
+U_BOOT_DRIVER(dp501) = {
+	.name		= "dp501",
+	.id		= UCLASS_PANEL,
+	.of_match	= dp501_ids,
+	.ops		= &dp501_ops,
+	.probe		= dp501_probe,
+	.priv_auto	= sizeof(struct dp501_priv),
+};
-- 
2.40.1

