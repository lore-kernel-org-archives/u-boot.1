Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0ECC3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4218788789;
	Mon,  8 Jul 2024 14:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uD6QD6m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA25788444; Mon,  8 Jul 2024 09:52:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965B4886A8
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4687qEuA054872;
 Mon, 8 Jul 2024 02:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720425134;
 bh=OuV8gU2kWNOKAvaqDjswt90scU2tQyPYT7E/pYMW/UI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uD6QD6m2MCwDM7qhzyIshjyiIwn9F8C0H7wE2yn7vFiPRcPQVD8J4uAD7hsfJr+8+
 x1cR6OQxt7BKAb3TrY/1YYyfrvH/C8yp0Axe+BVPFGxcW3aRrZzo3c2SCPFwT95UhQ
 NcKss5h6RqItuZkY3Jlh/FwSJoxDBCG2UL83zins=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4687qE0V010794
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 02:52:14 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 02:52:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 02:52:14 -0500
Received: from localhost (scaria-hp-zbook-15-g5.dhcp.ti.com [172.24.31.134])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4687qCvP115944;
 Mon, 8 Jul 2024 02:52:13 -0500
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <s-kochidanadu@ti.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: [PATCH 2/6] sound: ti: Add TLV320AIC3106 Codec
Date: Mon, 8 Jul 2024 13:22:03 +0530
Message-ID: <20240708075207.37207-3-s-kochidanadu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708075207.37207-1-s-kochidanadu@ti.com>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

This patch adds driver for  TLV320AIC3106 audio Codec.
Initialize and start the codec[1] with appropriate settings and
hardware parameters according to the audio data and the sound card
defined in the devicetree. The codec audio data bus is
programmable for I2S, DSP or TDM modes, and it also has a programmable
PLL for clock generation.
Below default settings are used as u-boot doesn't support file playback:
Codec being the clock and frame master, using the I2S audio format,
sampling rate and width of audio data in one slot.

The data sheet for the codec can be obtained here for further details
about its settings and working-

Link: https://www.ti.com/product/TLV320AIC3106 [1]

The driver is based on the kernel codec driver[2].
Link:
https://gitlab.com/linux-kernel/linux-next/-/blob/master/sound/soc/codecs/tlv320aic3x.c
[2]

Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
---
 MAINTAINERS                   |   2 +
 drivers/sound/Kconfig         |   8 +
 drivers/sound/Makefile        |   1 +
 drivers/sound/tlv320aic3106.c | 758 ++++++++++++++++++++++++++++++++++
 drivers/sound/tlv320aic3106.h | 336 +++++++++++++++
 5 files changed, 1105 insertions(+)
 create mode 100644 drivers/sound/tlv320aic3106.c
 create mode 100644 drivers/sound/tlv320aic3106.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 785afff1a7..5d7c260bfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -739,6 +739,8 @@ F:	drivers/rtc/davinci.c
 F:	drivers/serial/serial_omap.c
 F:	drivers/soc/ti/
 F:	drivers/sound/ti_sound.c
+F:	drivers/sound/tlv320aic3106.c
+F:	drivers/sound/tlv320aic3106.h
 F:	drivers/sysreset/sysreset-ti-sci.c
 F:	drivers/thermal/ti-bandgap.c
 F:	drivers/timer/omap-timer.c
diff --git a/drivers/sound/Kconfig b/drivers/sound/Kconfig
index be9f18b6c7..3f124cfb2b 100644
--- a/drivers/sound/Kconfig
+++ b/drivers/sound/Kconfig
@@ -158,4 +158,12 @@ config I2S_TI
           option provides an implementation for sound_init() and
           sound_play().
 
+config SOUND_TLV320AIC3106
+        bool "Support TLV320AIC3106 audio codec"
+        depends on I2S_TI
+        help
+          Enable the TLV320AIC3106 audio codec. This is connected via I2S for
+          audio data and I2C for codec control. At present it only works
+          with the MCASP driver.
+
 endmenu
diff --git a/drivers/sound/Makefile b/drivers/sound/Makefile
index 95aaa8521c..1e9fbd1000 100644
--- a/drivers/sound/Makefile
+++ b/drivers/sound/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_SOUND_RT5677)	+= rt5677.o
 obj-$(CONFIG_INTEL_BROADWELL)	+= broadwell_i2s.o broadwell_sound.o
 obj-$(CONFIG_SOUND_IVYBRIDGE)	+= ivybridge_sound.o
 obj-$(CONFIG_I2S_TI)    += ti_sound.o
+obj-$(CONFIG_SOUND_TLV320AIC3106)       += tlv320aic3106.o
diff --git a/drivers/sound/tlv320aic3106.c b/drivers/sound/tlv320aic3106.c
new file mode 100644
index 0000000000..b80bdddd70
--- /dev/null
+++ b/drivers/sound/tlv320aic3106.c
@@ -0,0 +1,758 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Scaria M Kochidanadu, s-kochidanadu@ti.com
+ *
+ * based on the linux tlv320aic3x codec driver, which is
+ *
+ * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
+ * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ */
+
+#include <asm/u-boot.h> /* boot information for Linux kernel */
+/* Pull in stuff for the build system */
+#ifdef DO_DEPS_ONLY
+#include <env_internal.h>
+#endif
+#include <audio_codec.h>
+#include <dm.h>
+#include <div64.h>
+#include <fdtdec.h>
+#include <i2c.h>
+#include <i2s.h>
+#include <log.h>
+#include <sound.h>
+#include <linux/delay.h>
+#include "tlv320aic3106.h"
+
+enum aic3x_micbias_voltage {
+	AIC3X_MICBIAS_OFF = 0,
+	AIC3X_MICBIAS_2_0V = 1,
+	AIC3X_MICBIAS_2_5V = 2,
+	AIC3X_MICBIAS_AVDDV = 3,
+};
+
+enum snd_soc_bias_level {
+	SND_SOC_BIAS_OFF = 0,
+	SND_SOC_BIAS_STANDBY = 1,
+	SND_SOC_BIAS_PREPARE = 2,
+	SND_SOC_BIAS_ON = 3,
+};
+
+struct reg_values {
+	unsigned int reg;
+	unsigned int def;
+};
+
+static const struct reg_values aic3x_default[] = {
+	{   0, 0x00 }, {   1, 0x00 }, {   2, 0x00 }, {   3, 0x10 },
+	{   4, 0x04 }, {   5, 0x00 }, {   6, 0x00 }, {   7, 0x00 },
+	{   8, 0x00 }, {   9, 0x00 }, {  10, 0x00 }, {  11, 0x01 },
+	{  12, 0x00 }, {  13, 0x00 }, {  14, 0x00 }, {  15, 0x80 },
+	{  16, 0x80 }, {  17, 0xff }, {  18, 0xff }, {  19, 0x78 },
+	{  20, 0x78 }, {  21, 0x78 }, {  22, 0x78 }, {  23, 0x78 },
+	{  24, 0x78 }, {  25, 0x00 }, {  26, 0x00 }, {  27, 0xfe },
+	{  28, 0x00 }, {  29, 0x00 }, {  30, 0xfe }, {  31, 0x00 },
+	{  32, 0x18 }, {  33, 0x18 }, {  34, 0x00 }, {  35, 0x00 },
+	{  36, 0x00 }, {  37, 0x00 }, {  38, 0x00 }, {  39, 0x00 },
+	{  40, 0x00 }, {  41, 0x00 }, {  42, 0x00 }, {  43, 0x80 },
+	{  44, 0x80 }, {  45, 0x00 }, {  46, 0x00 }, {  47, 0x00 },
+	{  48, 0x00 }, {  49, 0x00 }, {  50, 0x00 }, {  51, 0x04 },
+	{  52, 0x00 }, {  53, 0x00 }, {  54, 0x00 }, {  55, 0x00 },
+	{  56, 0x00 }, {  57, 0x00 }, {  58, 0x04 }, {  59, 0x00 },
+	{  60, 0x00 }, {  61, 0x00 }, {  62, 0x00 }, {  63, 0x00 },
+	{  64, 0x00 }, {  65, 0x04 }, {  66, 0x00 }, {  67, 0x00 },
+	{  68, 0x00 }, {  69, 0x00 }, {  70, 0x00 }, {  71, 0x00 },
+	{  72, 0x04 }, {  73, 0x00 }, {  74, 0x00 }, {  75, 0x00 },
+	{  76, 0x00 }, {  77, 0x00 }, {  78, 0x00 }, {  79, 0x00 },
+	{  80, 0x00 }, {  81, 0x00 }, {  82, 0x00 }, {  83, 0x00 },
+	{  84, 0x00 }, {  85, 0x00 }, {  86, 0x00 }, {  87, 0x00 },
+	{  88, 0x00 }, {  89, 0x00 }, {  90, 0x00 }, {  91, 0x00 },
+	{  92, 0x00 }, {  93, 0x00 }, {  94, 0x00 }, {  95, 0x00 },
+	{  96, 0x00 }, {  97, 0x00 }, {  98, 0x00 }, {  99, 0x00 },
+	{ 100, 0x00 }, { 101, 0x00 }, { 102, 0x02 }, { 103, 0x00 },
+	{ 104, 0x00 }, { 105, 0x00 }, { 106, 0x00 }, { 107, 0x00 },
+	{ 108, 0x00 }, { 109, 0x00 },
+};
+
+/* codec private data */
+struct tlv320aic3106_priv {
+	struct udevice *dev;
+	enum aic3x_micbias_voltage micbias_vg;
+	unsigned int sysclk;
+	unsigned int dai_fmt;
+	unsigned int tdm_delay;
+	unsigned int slot_width;
+	int master;
+	int power;
+	bool bias_level;
+	/*output common voltage*/
+	u8 ocmv;
+};
+
+static int aic3106_i2c_write(struct tlv320aic3106_priv *priv, unsigned int reg, unsigned char data)
+{
+	unsigned char val[1];
+
+	val[0] = data;
+	debug("Write Addr : 0x%04X, Data :  0x%04X\n", reg, data);
+
+	return dm_i2c_write(priv->dev, reg, val, 1);
+}
+
+static unsigned int aic3106_i2c_read(struct tlv320aic3106_priv *priv, unsigned int reg,
+				     unsigned char *data)
+{
+	unsigned char val[1];
+	int ret;
+
+	ret = dm_i2c_read(priv->dev, reg, val, 1);
+	if (ret != 0) {
+		debug("%s: Error while reading register %#04x\n",
+		      __func__, reg);
+		return -1;
+	}
+	*data = val[0];
+
+	return 0;
+}
+
+static int aic3106_i2c_update_bits(struct tlv320aic3106_priv *priv, unsigned int reg,
+				   unsigned char mask, unsigned char data)
+{
+	unsigned char reg_data;
+
+	int ret = aic3106_i2c_read(priv, reg - 1, &reg_data);
+
+	if (ret < 0) {
+		debug("failed to read ID register\n");
+		return ret;
+	}
+
+	unsigned char final_data = (reg_data & (~mask)) | data;
+
+	ret = aic3106_i2c_write(priv, reg, final_data);
+	if (ret < 0) {
+		debug("failed to write ID register\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int aic3106_set_dai_sysclk(struct tlv320aic3106_priv *priv, int clk_id, unsigned int freq)
+{
+	int ret;
+
+	ret = aic3106_i2c_update_bits(priv, AIC3X_CLKGEN_CTRL_REG, PLLCLK_IN_MASK,
+				      clk_id << PLLCLK_IN_SHIFT);
+	ret |= aic3106_i2c_update_bits(priv, AIC3X_CLKGEN_CTRL_REG, CLKDIV_IN_MASK,
+				       clk_id << CLKDIV_IN_SHIFT);
+
+	priv->sysclk = freq;
+
+	if (ret < 0) {
+		debug("%s sysclk failed", __func__);
+		return ret;
+	}
+	return 0;
+}
+
+static int aic3106_set_dai_fmt(struct tlv320aic3106_priv *priv, unsigned int fmt)
+{
+	int ret;
+	u8 iface_areg, iface_breg;
+
+	ret = aic3106_i2c_read(priv, AIC3X_ASD_INTF_CTRLA - 1, &iface_areg);
+	if (ret < 0)
+		debug("%s error reading reg\n", __func__);
+	iface_areg &= 0x3f;
+
+	ret = aic3106_i2c_read(priv, AIC3X_ASD_INTF_CTRLB - 1, &iface_breg);
+	if (ret < 0)
+		debug("%s error reading reg\n", __func__);
+	iface_breg &= 0x3f;
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
+		priv->master = 1;
+		iface_areg |= BIT_CLK_MASTER | WORD_CLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBC_CFC:
+		priv->master = 0;
+		iface_areg &= ~(BIT_CLK_MASTER | WORD_CLK_MASTER);
+		break;
+	case SND_SOC_DAIFMT_CBP_CFC:
+		priv->master = 1;
+		iface_areg |= BIT_CLK_MASTER;
+		iface_areg &= ~WORD_CLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBC_CFP:
+		priv->master = 1;
+		iface_areg |= WORD_CLK_MASTER;
+		iface_areg &= ~BIT_CLK_MASTER;
+		break;
+	default:
+		return -EINVAL;
+	}
+	/*
+	 * match both interface format and signal polarities since they
+	 * are fixed
+	 */
+	switch (fmt & (SND_SOC_DAIFMT_FORMAT_MASK |
+		       SND_SOC_DAIFMT_INV_MASK)) {
+	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF_UBT):
+		break;
+	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
+	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
+		iface_breg |= (0x01 << 6);
+		break;
+	case (SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_NB_NF_UBT):
+		iface_breg |= (0x02 << 6);
+		break;
+	case (SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF_UBT):
+		iface_breg |= (0x03 << 6);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	priv->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+
+	ret = aic3106_i2c_write(priv, AIC3X_ASD_INTF_CTRLA, iface_areg);
+	ret |= aic3106_i2c_write(priv, AIC3X_ASD_INTF_CTRLB, iface_breg);
+
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int aic3106_hw_params(struct tlv320aic3106_priv *priv, int rate)
+{
+	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
+	u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
+
+	u16 d, pll_d = 1;
+	int clk;
+	int width = priv->slot_width;
+
+	if (!width)
+		width = 16;
+
+	int ret = aic3106_i2c_read(priv, AIC3X_ASD_INTF_CTRLB - 1, &data);
+
+	if (ret < 0)
+		return ret;
+
+	data &= (~(0x3 << 4));
+
+	switch (width) {
+	case 16:
+		break;
+	case 20:
+		data |= (0x01 << 4);
+		break;
+	case 24:
+		data |= (0x02 << 4);
+		break;
+	case 32:
+		data |= (0x03 << 4);
+		break;
+	}
+
+	aic3106_i2c_write(priv, AIC3X_ASD_INTF_CTRLB, data);
+
+	fsref = (rate % 11025 == 0) ? 44100 : 48000;
+
+	/* Try to find a value for Q which allows us to bypass the PLL and
+	 * generate CODEC_CLK directly.
+	 */
+	for (pll_q = 2; pll_q < 18; pll_q++)
+		if (priv->sysclk / (128 * pll_q) == fsref) {
+			bypass_pll = 1;
+			break;
+		}
+
+	if (bypass_pll) {
+		pll_q &= 0xf;
+		aic3106_i2c_write(priv, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
+		aic3106_i2c_write(priv, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
+		/* disable PLL if it is bypassed */
+		aic3106_i2c_update_bits(priv, AIC3X_PLL_PROGA_REG, PLL_ENABLE, 0);
+
+	} else {
+		aic3106_i2c_write(priv, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
+		/* enable PLL when it is used */
+		aic3106_i2c_update_bits(priv, AIC3X_PLL_PROGA_REG,
+					PLL_ENABLE, PLL_ENABLE);
+	}
+
+	/* Route Left DAC to left channel input and
+	 * right DAC to right channel input
+	 */
+	data = (LDAC2LCH | RDAC2RCH);
+	data |= (fsref == 44100) ? FSREF_44100 : FSREF_48000;
+
+	if (rate >= 64000)
+		data |= DUAL_RATE_MODE;
+	aic3106_i2c_write(priv, AIC3X_CODEC_DATAPATH_REG, data);
+
+	/* codec sample rate select */
+	data = (fsref * 20) / rate;
+	if (rate < 64000)
+		data /= 2;
+	data /= 5;
+	data -= 2;
+	data |= (data << 4);
+	aic3106_i2c_write(priv, AIC3X_SAMPLE_RATE_SEL_REG, data);
+
+	if (bypass_pll)
+		return 0;
+
+	/* Use PLL, compute appropriate setup for j, d, r and p, the closest
+	 * one wins the game. Try with d==0 first, next with d!=0.
+	 * Constraints for j are according to the datasheet.
+	 * The sysclk is divided by 1000 to prevent integer overflows.
+	 */
+
+	codec_clk = (2048 * fsref) / (priv->sysclk / 1000);
+
+	for (r = 1; r <= 16; r++)
+		for (p = 1; p <= 8; p++) {
+			for (j = 4; j <= 55; j++) {
+				/* This is actually 1000*((j+(d/10000))*r)/p
+				 * The term had to be converted to get
+				 * rid of the division by 10000; d = 0 here
+				 */
+				int tmp_clk = (1000 * j * r) / p;
+
+				/* Check whether this values get closer than
+				 * the best ones we had before
+				 */
+				if (abs(codec_clk - tmp_clk) <
+					abs(codec_clk - last_clk)) {
+					pll_j = j; pll_d = 0;
+					pll_r = r; pll_p = p;
+					last_clk = tmp_clk;
+				}
+
+				/* Early exit for exact matches */
+				if (tmp_clk == codec_clk)
+					goto found;
+			}
+		}
+
+	/* try with d != 0 */
+	for (p = 1; p <= 8; p++) {
+		j = codec_clk * p / 1000;
+
+		if (j < 4 || j > 11)
+			continue;
+
+		/* do not use codec_clk here since we'd loose precision */
+		d = ((2048 * p * fsref) - j * priv->sysclk)
+			* 100 / (priv->sysclk / 100);
+
+		clk = (10000 * j + d) / (10 * p);
+
+		/* check whether this values get closer than the best
+		 * ones we had before
+		 */
+		if (abs(codec_clk - clk) < abs(codec_clk - last_clk)) {
+			pll_j = j; pll_d = d; pll_r = 1; pll_p = p;
+			last_clk = clk;
+		}
+
+		/* Early exit for exact matches */
+		if (clk == codec_clk)
+			goto found;
+	}
+
+	if (last_clk == 0) {
+		printf("%s(): unable to setup PLL\n", __func__);
+		return -EINVAL;
+	}
+
+found:
+	aic3106_i2c_update_bits(priv, AIC3X_PLL_PROGA_REG, PLLP_MASK, pll_p);
+	aic3106_i2c_write(priv, AIC3X_OVRF_STATUS_AND_PLLR_REG,
+			  pll_r << PLLR_SHIFT);
+	aic3106_i2c_write(priv, AIC3X_PLL_PROGB_REG, pll_j << PLLJ_SHIFT);
+	aic3106_i2c_write(priv, AIC3X_PLL_PROGC_REG,
+			  (pll_d >> 6) << PLLD_MSB_SHIFT);
+	aic3106_i2c_write(priv, AIC3X_PLL_PROGD_REG,
+			  (pll_d & 0x3F) << PLLD_LSB_SHIFT);
+
+	return 0;
+}
+
+static int aic3106_prepare(struct tlv320aic3106_priv *priv)
+{
+	int delay = 0;
+	int width = priv->slot_width;
+
+	if (!width)
+		width = 16;
+
+	/* TDM slot selection only valid in DSP_A/_B mode */
+	if (priv->dai_fmt == SND_SOC_DAIFMT_DSP_A)
+		delay += (priv->tdm_delay * width + 1);
+	else if (priv->dai_fmt == SND_SOC_DAIFMT_DSP_B)
+		delay += priv->tdm_delay * width;
+
+	/* Configure data delay */
+	int ret = aic3106_i2c_write(priv, AIC3X_ASD_INTF_CTRLC, delay);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int aic3106_mute(struct tlv320aic3106_priv *priv, int mute)
+{
+	u8 ldac_reg, rdac_reg;
+	int ret;
+
+	ret = aic3106_i2c_read(priv, LDAC_VOL - 1, &ldac_reg);
+	if (ret < 0)
+		debug("%s error in reading reg\n", __func__);
+	ret = aic3106_i2c_read(priv, RDAC_VOL - 1, &rdac_reg);
+	if (ret < 0)
+		debug("%s error in reading reg\n", __func__);
+
+	ldac_reg &= ~MUTE_ON;
+	rdac_reg &= ~MUTE_ON;
+
+	if (mute) {
+		aic3106_i2c_write(priv, LDAC_VOL, ldac_reg | MUTE_ON);
+		aic3106_i2c_write(priv, RDAC_VOL, rdac_reg | MUTE_ON);
+	} else {
+		aic3106_i2c_write(priv, LDAC_VOL, ldac_reg);
+		aic3106_i2c_write(priv, RDAC_VOL, rdac_reg);
+	}
+
+	return 0;
+}
+
+static int aic3106_set_power(struct tlv320aic3106_priv *priv, bool power)
+{
+	u8 pll_c, pll_d;
+	int ret;
+
+	if (power) {
+		priv->power = 1;
+
+		/* Rewrite paired PLL D registers in case cached sync skipped
+		 * writing one of them and thus caused other one also not
+		 * being written
+		 */
+		ret = aic3106_i2c_read(priv, AIC3X_PLL_PROGC_REG - 1, &pll_c);
+		ret |= aic3106_i2c_read(priv, AIC3X_PLL_PROGD_REG - 1, &pll_d);
+		if (pll_c == aic3x_default[AIC3X_PLL_PROGC_REG].def ||
+		    pll_d == aic3x_default[AIC3X_PLL_PROGD_REG].def) {
+			ret |= aic3106_i2c_write(priv, AIC3X_PLL_PROGC_REG, pll_c);
+			ret |= aic3106_i2c_write(priv, AIC3X_PLL_PROGD_REG, pll_d);
+		}
+
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Delay is needed to reduce pop-noise after syncing back the
+		 * registers
+		 */
+		udelay(50 * 1000);
+
+	} else {
+		/*
+		 * Do soft reset to this codec instance in order to clear
+		 * possible VDD leakage currents in case the supply regulators
+		 * remain on
+		 */
+		ret = aic3106_i2c_write(priv, AIC3X_RESET, SOFT_RESET);
+		if (ret < 0)
+			return ret;
+
+		priv->power = 0;
+	}
+	return 0;
+}
+
+static int aic3106_set_bias_level(struct tlv320aic3106_priv *priv, bool level)
+{
+	int ret;
+
+	if (level && !priv->bias_level && priv->master) {
+		ret = aic3106_set_power(priv, 1);
+		/*enable PLL */
+		ret |= aic3106_i2c_update_bits(priv, AIC3X_PLL_PROGA_REG, PLL_ENABLE, PLL_ENABLE);
+		if (ret < 0)
+			return ret;
+
+		priv->bias_level = true;
+	}
+
+	if (!level && priv->bias_level && priv->master) {
+		/*disable PLL */
+		ret = aic3106_i2c_update_bits(priv, AIC3X_PLL_PROGA_REG, PLL_ENABLE, 0);
+		priv->bias_level = false;
+		ret |= aic3106_set_power(priv, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void aic3106_mono_init(struct tlv320aic3106_priv *priv)
+{
+	aic3106_i2c_write(priv, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	aic3106_i2c_write(priv, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	/* unmute all outputs */
+	aic3106_i2c_update_bits(priv, MONOLOPM_CTRL, UNMUTE, UNMUTE);
+
+	/* PGA to Mono Line Out default volume, disconnect from Output Mixer */
+	aic3106_i2c_write(priv, PGAL_2_MONOLOPM_VOL, DEFAULT_VOL);
+
+	aic3106_i2c_write(priv, PGAR_2_MONOLOPM_VOL, DEFAULT_VOL);
+
+	/* Line2 to Mono Out default volume, disconnect from Output Mixer */
+	aic3106_i2c_write(priv, LINE2L_2_MONOLOPM_VOL, DEFAULT_VOL);
+
+	aic3106_i2c_write(priv, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
+}
+
+static int tlv320aic3106_init(struct tlv320aic3106_priv *priv)
+{
+	int ret = aic3106_i2c_write(priv, AIC3X_PAGE_SELECT, PAGE0_SELECT);
+
+	ret |= aic3106_i2c_write(priv, AIC3X_RESET, SOFT_RESET);
+
+	/*Powering up LDAC and RDAC*/
+	ret |= aic3106_i2c_write(priv, 37, 0xc0);
+
+	/* DAC default volume and mute */
+	/* Increasing the Volume since default volume is low */
+	ret |= aic3106_i2c_write(priv, LDAC_VOL, 0x0d | MUTE_ON);
+
+	ret |= aic3106_i2c_write(priv, RDAC_VOL, 0x0d | MUTE_ON);
+
+	/* DAC to HP default volume and route to Output mixer */
+	ret |= aic3106_i2c_write(priv, DACL1_2_HPLOUT_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	ret |= aic3106_i2c_write(priv, DACR1_2_HPROUT_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	ret |= aic3106_i2c_write(priv, DACL1_2_HPLCOM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	ret |= aic3106_i2c_write(priv, DACR1_2_HPRCOM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	/* DAC to Line Out default volume and route to Output mixer */
+	ret |= aic3106_i2c_write(priv, DACL1_2_LLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	ret |= aic3106_i2c_write(priv, DACR1_2_RLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	/* Powering on the outputs*/
+	ret |= aic3106_i2c_update_bits(priv, HPLOUT_CTRL, HPLOUT_PWR_ON, HPLOUT_PWR_ON);
+
+	ret |= aic3106_i2c_update_bits(priv, HPLCOM_CTRL, HPLCOM_PWR_ON, HPLCOM_PWR_ON);
+
+	ret |= aic3106_i2c_update_bits(priv, HPROUT_CTRL, HPROUT_PWR_ON, HPROUT_PWR_ON);
+
+	ret |= aic3106_i2c_update_bits(priv, HPRCOM_CTRL, HPRCOM_PWR_ON, HPRCOM_PWR_ON);
+
+	/* unmute all outputs */
+	ret |= aic3106_i2c_update_bits(priv, LLOPM_CTRL, UNMUTE, UNMUTE);
+
+	ret |= aic3106_i2c_update_bits(priv, RLOPM_CTRL, UNMUTE, UNMUTE);
+
+	ret |= aic3106_i2c_update_bits(priv, HPLOUT_CTRL, UNMUTE, UNMUTE);
+
+	ret |= aic3106_i2c_update_bits(priv, HPROUT_CTRL, UNMUTE, UNMUTE);
+
+	ret |= aic3106_i2c_update_bits(priv, HPLCOM_CTRL, UNMUTE, UNMUTE);
+
+	ret |= aic3106_i2c_update_bits(priv, HPRCOM_CTRL, UNMUTE, UNMUTE);
+
+	/* ADC default volume and unmute */
+	ret |= aic3106_i2c_write(priv, LADC_VOL, 0x6b);
+
+	ret |= aic3106_i2c_write(priv, RADC_VOL, 0x6b);
+
+	/* Some changes*/
+
+	ret |= aic3106_i2c_write(priv, MIC3LR_2_LADC_CTRL, 0xf0);
+
+	ret |= aic3106_i2c_write(priv, MIC3LR_2_RADC_CTRL, 0xf0);
+
+	/* By default route Line1 to ADC PGA mixer */
+	ret |= aic3106_i2c_write(priv, LINE1L_2_LADC_CTRL, 0x0);
+
+	ret |= aic3106_i2c_write(priv, LINE1R_2_RADC_CTRL, 0x0);
+
+	/* PGA to HP Bypass default volume, disconnect from Output Mixer */
+	ret |= aic3106_i2c_write(priv, PGAL_2_HPLOUT_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, PGAR_2_HPROUT_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, PGAL_2_HPLCOM_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, PGAR_2_HPRCOM_VOL, DEFAULT_VOL);
+	/* PGA to Line Out default volume, disconnect from Output Mixer */
+
+	ret |= aic3106_i2c_write(priv, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
+
+	/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
+	ret |= aic3106_i2c_write(priv, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
+
+	/* Line2 Line Out default volume, disconnect from Output Mixer */
+	ret |= aic3106_i2c_write(priv, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
+
+	ret |= aic3106_i2c_write(priv, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+
+	aic3106_mono_init(priv);
+
+	ret |= aic3106_i2c_update_bits(priv, HPOUT_SC, HPOUT_SC_OCMV_MASK,
+			    priv->ocmv << HPOUT_SC_OCMV_SHIFT);
+
+	if (ret) {
+		debug("error in init()\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tlv320aic3106_set_params(struct udevice *dev, int interface, int rate,
+				    int mclk_freq, int bits_per_sample, uint channels)
+{
+	struct tlv320aic3106_priv *priv = dev_get_priv(dev);
+
+	int ret;
+
+	ret = aic3106_set_dai_sysclk(priv, interface, mclk_freq);
+	if (ret) {
+		debug(" %s failure in setting sysclk\n", __func__);
+		return ret;
+	}
+
+	int fmt = SND_SOC_DAIFMT_CBP_CFP | SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
+
+	ret = aic3106_set_dai_fmt(priv, fmt);
+	if (ret) {
+		debug(" %s failure in setting dai format\n", __func__);
+		return ret;
+	}
+
+	ret = aic3106_hw_params(priv, rate);
+	if (ret) {
+		debug(" %s failure in setting hw params\n", __func__);
+		return ret;
+	}
+
+	ret = aic3106_prepare(priv);
+	if (ret) {
+		debug(" %s failure\n", __func__);
+		return ret;
+	}
+
+	ret = aic3106_set_bias_level(priv, 1);
+	if (ret) {
+		debug(" %s failure\n", __func__);
+		return ret;
+	}
+
+	ret = aic3106_mute(priv, 0);
+	if (ret) {
+		debug(" %s failure\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tlv320aic3106_probe(struct udevice *dev)
+{
+	struct tlv320aic3106_priv *priv = dev_get_priv(dev);
+	int ret, value;
+
+	priv->dev = dev;
+
+	/* Getting Micbias volage and OCMV value from DT */
+	if (!dev_read_u32u(dev, "ai3x-micbias-vg", &value)) {
+		switch (value) {
+		case 1:
+			priv->micbias_vg = AIC3X_MICBIAS_2_0V;
+			break;
+		case 2:
+			priv->micbias_vg = AIC3X_MICBIAS_2_5V;
+			break;
+		case 3:
+			priv->micbias_vg = AIC3X_MICBIAS_AVDDV;
+			break;
+		default:
+			priv->micbias_vg = AIC3X_MICBIAS_OFF;
+			debug("Unsuitable MicBias voltage found in DT\n");
+		}
+	} else {
+		priv->micbias_vg = AIC3X_MICBIAS_OFF;
+	}
+
+	if (!dev_read_u32u(dev, "ai3x-ocmv", &value)) {
+		/* OCMV setting is forced by DT */
+		if (value <= 3)
+			priv->ocmv = value;
+	}
+
+	ret = tlv320aic3106_init(priv);
+	if (ret < 0) {
+		printf("error in init()\n");
+		return ret;
+	}
+
+	switch (priv->micbias_vg) {
+	case AIC3X_MICBIAS_2_0V:
+	case AIC3X_MICBIAS_2_5V:
+	case AIC3X_MICBIAS_AVDDV:
+		aic3106_i2c_update_bits(priv, MICBIAS_CTRL,
+					MICBIAS_LEVEL_MASK,
+					(priv->micbias_vg) << MICBIAS_LEVEL_SHIFT);
+		break;
+	case AIC3X_MICBIAS_OFF:
+		/*
+		 * noting to do. target won't enter here. This is just to avoid
+		 * compile time warning "warning: enumeration value
+		 * 'AIC3X_MICBIAS_OFF' not handled in switch"
+		 */
+		break;
+	}
+
+	return 0;
+}
+
+static const struct audio_codec_ops tlv320aic3106_ops = {
+	.set_params	= tlv320aic3106_set_params,
+};
+
+static const struct udevice_id tlv320aic3106_ids[] = {
+	{ .compatible = "ti,tlv320aic3106" },
+	{ }
+};
+
+U_BOOT_DRIVER(tlv320aic3106) = {
+	.name		= "tlv320aic3106",
+	.id		= UCLASS_AUDIO_CODEC,
+	.of_match	= tlv320aic3106_ids,
+	.probe		= tlv320aic3106_probe,
+	.ops		= &tlv320aic3106_ops,
+	.priv_auto	= sizeof(struct tlv320aic3106_priv),
+};
diff --git a/drivers/sound/tlv320aic3106.h b/drivers/sound/tlv320aic3106.h
new file mode 100644
index 0000000000..55dc497a7e
--- /dev/null
+++ b/drivers/sound/tlv320aic3106.h
@@ -0,0 +1,336 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ALSA SoC TLV320AIC3X codec driver
+ *
+ * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
+ * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ */
+
+#ifndef _TLV320AIC3106_H
+#define _TLV320AIC3106_H
+
+#define AIC3X_MODEL_3X 0
+#define AIC3X_MODEL_33 1
+#define AIC3X_MODEL_3007 2
+#define AIC3X_MODEL_3104 3
+#define AIC3X_MODEL_3106 4
+
+/* AIC3X register space */
+#define AIC3X_CACHEREGNUM		110
+
+/* Page select register */
+#define AIC3X_PAGE_SELECT		0
+/* Software reset register */
+#define AIC3X_RESET			1
+/* Codec Sample rate select register */
+#define AIC3X_SAMPLE_RATE_SEL_REG	2
+/* PLL progrramming register A */
+#define AIC3X_PLL_PROGA_REG		3
+/* PLL progrramming register B */
+#define AIC3X_PLL_PROGB_REG		4
+/* PLL progrramming register C */
+#define AIC3X_PLL_PROGC_REG		5
+/* PLL progrramming register D */
+#define AIC3X_PLL_PROGD_REG		6
+/* Codec datapath setup register */
+#define AIC3X_CODEC_DATAPATH_REG	7
+/* Audio serial data interface control register A */
+#define AIC3X_ASD_INTF_CTRLA		8
+/* Audio serial data interface control register B */
+#define AIC3X_ASD_INTF_CTRLB		9
+/* Audio serial data interface control register C */
+#define AIC3X_ASD_INTF_CTRLC		10
+/* Audio overflow status and PLL R value programming register */
+#define AIC3X_OVRF_STATUS_AND_PLLR_REG	11
+/* Audio codec digital filter control register */
+#define AIC3X_CODEC_DFILT_CTRL		12
+/* Headset/button press detection register */
+#define AIC3X_HEADSET_DETECT_CTRL_A	13
+#define AIC3X_HEADSET_DETECT_CTRL_B	14
+/* ADC PGA Gain control registers */
+#define LADC_VOL			15
+#define RADC_VOL			16
+/* MIC3 control registers */
+#define MIC3LR_2_LADC_CTRL		17
+#define MIC3LR_2_RADC_CTRL		18
+/* Line1 Input control registers */
+#define LINE1L_2_LADC_CTRL		19
+#define LINE1R_2_LADC_CTRL		21
+#define LINE1R_2_RADC_CTRL		22
+#define LINE1L_2_RADC_CTRL		24
+/* Line2 Input control registers */
+#define LINE2L_2_LADC_CTRL		20
+#define LINE2R_2_RADC_CTRL		23
+/* MICBIAS Control Register */
+#define MICBIAS_CTRL			25
+
+/* AGC Control Registers A, B, C */
+#define LAGC_CTRL_A			26
+#define LAGC_CTRL_B			27
+#define LAGC_CTRL_C			28
+#define RAGC_CTRL_A			29
+#define RAGC_CTRL_B			30
+#define RAGC_CTRL_C			31
+
+/* DAC Power and Left High Power Output control registers */
+#define DAC_PWR				37
+#define HPLCOM_CFG			37
+/* Right High Power Output control registers */
+#define HPRCOM_CFG			38
+/* High Power Output Stage Control Register */
+#define HPOUT_SC			40
+/* DAC Output Switching control registers */
+#define DAC_LINE_MUX			41
+/* High Power Output Driver Pop Reduction registers */
+#define HPOUT_POP_REDUCTION		42
+/* DAC Digital control registers */
+#define LDAC_VOL			43
+#define RDAC_VOL			44
+/* Left High Power Output control registers */
+#define LINE2L_2_HPLOUT_VOL		45
+#define PGAL_2_HPLOUT_VOL		46
+#define DACL1_2_HPLOUT_VOL		47
+#define LINE2R_2_HPLOUT_VOL		48
+#define PGAR_2_HPLOUT_VOL		49
+#define DACR1_2_HPLOUT_VOL		50
+#define HPLOUT_CTRL			51
+/* Left High Power COM control registers */
+#define LINE2L_2_HPLCOM_VOL		52
+#define PGAL_2_HPLCOM_VOL		53
+#define DACL1_2_HPLCOM_VOL		54
+#define LINE2R_2_HPLCOM_VOL		55
+#define PGAR_2_HPLCOM_VOL		56
+#define DACR1_2_HPLCOM_VOL		57
+#define HPLCOM_CTRL			58
+/* Right High Power Output control registers */
+#define LINE2L_2_HPROUT_VOL		59
+#define PGAL_2_HPROUT_VOL		60
+#define DACL1_2_HPROUT_VOL		61
+#define LINE2R_2_HPROUT_VOL		62
+#define PGAR_2_HPROUT_VOL		63
+#define DACR1_2_HPROUT_VOL		64
+#define HPROUT_CTRL			65
+/* Right High Power COM control registers */
+#define LINE2L_2_HPRCOM_VOL		66
+#define PGAL_2_HPRCOM_VOL		67
+#define DACL1_2_HPRCOM_VOL		68
+#define LINE2R_2_HPRCOM_VOL		69
+#define PGAR_2_HPRCOM_VOL		70
+#define DACR1_2_HPRCOM_VOL		71
+#define HPRCOM_CTRL			72
+/* Mono Line Output Plus/Minus control registers */
+#define LINE2L_2_MONOLOPM_VOL		73
+#define PGAL_2_MONOLOPM_VOL		74
+#define DACL1_2_MONOLOPM_VOL		75
+#define LINE2R_2_MONOLOPM_VOL		76
+#define PGAR_2_MONOLOPM_VOL		77
+#define DACR1_2_MONOLOPM_VOL		78
+#define MONOLOPM_CTRL			79
+/* Class-D speaker driver on tlv320aic3007 */
+#define CLASSD_CTRL			73
+/* Left Line Output Plus/Minus control registers */
+#define LINE2L_2_LLOPM_VOL		80
+#define PGAL_2_LLOPM_VOL		81
+#define DACL1_2_LLOPM_VOL		82
+#define LINE2R_2_LLOPM_VOL		83
+#define PGAR_2_LLOPM_VOL		84
+#define DACR1_2_LLOPM_VOL		85
+#define LLOPM_CTRL			86
+/* Right Line Output Plus/Minus control registers */
+#define LINE2L_2_RLOPM_VOL		87
+#define PGAL_2_RLOPM_VOL		88
+#define DACL1_2_RLOPM_VOL		89
+#define LINE2R_2_RLOPM_VOL		90
+#define PGAR_2_RLOPM_VOL		91
+#define DACR1_2_RLOPM_VOL		92
+#define RLOPM_CTRL			93
+/* GPIO/IRQ registers */
+#define AIC3X_STICKY_IRQ_FLAGS_REG	96
+#define AIC3X_RT_IRQ_FLAGS_REG		97
+#define AIC3X_GPIO1_REG			98
+#define AIC3X_GPIO2_REG			99
+#define AIC3X_GPIOA_REG			100
+#define AIC3X_GPIOB_REG			101
+/* Clock generation control register */
+#define AIC3X_CLKGEN_CTRL_REG		102
+/* New AGC registers */
+#define LAGCN_ATTACK			103
+#define LAGCN_DECAY			104
+#define RAGCN_ATTACK			105
+#define RAGCN_DECAY			106
+/* New Programmable ADC Digital Path and I2C Bus Condition Register */
+#define NEW_ADC_DIGITALPATH		107
+/* Passive Analog Signal Bypass Selection During Powerdown Register */
+#define PASSIVE_BYPASS			108
+/* DAC Quiescent Current Adjustment Register */
+#define DAC_ICC_ADJ			109
+
+/* Page select register bits */
+#define PAGE0_SELECT		0
+#define PAGE1_SELECT		1
+
+/* Audio serial data interface control register A bits */
+#define BIT_CLK_MASTER          0x80
+#define WORD_CLK_MASTER         0x40
+#define DOUT_TRISTATE		0x20
+
+/* Codec Datapath setup register 7 */
+#define FSREF_44100		BIT(7)
+#define FSREF_48000		(0 << 7)
+#define DUAL_RATE_MODE		((1 << 5) | (1 << 6))
+#define LDAC2LCH		(0x1 << 3)
+#define RDAC2RCH		(0x1 << 1)
+#define LDAC2RCH		(0x2 << 3)
+#define RDAC2LCH		(0x2 << 1)
+#define LDAC2MONOMIX		(0x3 << 3)
+#define RDAC2MONOMIX		(0x3 << 1)
+
+/* PLL registers bitfields */
+#define PLLP_SHIFT		0
+#define PLLP_MASK		7
+#define PLLQ_SHIFT		3
+#define PLLR_SHIFT		0
+#define PLLJ_SHIFT		2
+#define PLLD_MSB_SHIFT		0
+#define PLLD_LSB_SHIFT		2
+
+/* Clock generation register bits */
+#define CODEC_CLKIN_PLLDIV	0
+#define CODEC_CLKIN_CLKDIV	1
+#define PLL_CLKIN_SHIFT		4
+#define MCLK_SOURCE		0x0
+#define PLL_CLKDIV_SHIFT	0
+#define PLLCLK_IN_MASK		0x30
+#define PLLCLK_IN_SHIFT		4
+#define CLKDIV_IN_MASK		0xc0
+#define CLKDIV_IN_SHIFT		6
+/* clock in source */
+#define CLKIN_MCLK		0
+#define CLKIN_GPIO2		1
+#define CLKIN_BCLK		2
+
+/* Software reset register bits */
+#define SOFT_RESET		0x80
+
+/* PLL progrramming register A bits */
+#define PLL_ENABLE		0x80
+
+/* Route bits */
+#define ROUTE_ON		0x80
+
+/* Mute bits */
+#define UNMUTE			0x08
+#define MUTE_ON			0x80
+
+/* Power bits */
+#define LADC_PWR_ON		0x04
+#define RADC_PWR_ON		0x04
+#define LDAC_PWR_ON		0x80
+#define RDAC_PWR_ON		0x40
+#define HPLOUT_PWR_ON		0x01
+#define HPROUT_PWR_ON		0x01
+#define HPLCOM_PWR_ON		0x01
+#define HPRCOM_PWR_ON		0x01
+#define MONOLOPM_PWR_ON		0x01
+#define LLOPM_PWR_ON		0x01
+#define RLOPM_PWR_ON	0x01
+
+#define INVERT_VOL(val)   (0x7f - (val))
+
+/* Default output volume (inverted) */
+#define DEFAULT_VOL     INVERT_VOL(0x50)
+/* Default input volume */
+#define DEFAULT_GAIN    0x20
+
+/* MICBIAS Control Register */
+#define MICBIAS_LEVEL_SHIFT	(6)
+#define MICBIAS_LEVEL_MASK	(3 << 6)
+
+/* HPOUT_SC */
+#define HPOUT_SC_OCMV_MASK	(3 << 6)
+#define HPOUT_SC_OCMV_SHIFT	(6)
+#define HPOUT_SC_OCMV_1_35V	0
+#define HPOUT_SC_OCMV_1_5V	1
+#define HPOUT_SC_OCMV_1_65V	2
+#define HPOUT_SC_OCMV_1_8V	3
+
+/* headset detection / button API */
+
+/* The AIC3x supports detection of stereo headsets (GND + left + right signal)
+ * and cellular headsets (GND + speaker output + microphone input).
+ * It is recommended to enable MIC bias for this function to work properly.
+ * For more information, please refer to the datasheet.
+ */
+enum {
+	AIC3X_HEADSET_DETECT_OFF	= 0,
+	AIC3X_HEADSET_DETECT_STEREO	= 1,
+	AIC3X_HEADSET_DETECT_CELLULAR   = 2,
+	AIC3X_HEADSET_DETECT_BOTH	= 3
+};
+
+enum {
+	AIC3X_HEADSET_DEBOUNCE_16MS	= 0,
+	AIC3X_HEADSET_DEBOUNCE_32MS	= 1,
+	AIC3X_HEADSET_DEBOUNCE_64MS	= 2,
+	AIC3X_HEADSET_DEBOUNCE_128MS	= 3,
+	AIC3X_HEADSET_DEBOUNCE_256MS	= 4,
+	AIC3X_HEADSET_DEBOUNCE_512MS	= 5
+};
+
+enum {
+	AIC3X_BUTTON_DEBOUNCE_0MS	= 0,
+	AIC3X_BUTTON_DEBOUNCE_8MS	= 1,
+	AIC3X_BUTTON_DEBOUNCE_16MS	= 2,
+	AIC3X_BUTTON_DEBOUNCE_32MS	= 3
+};
+
+#define AIC3X_HEADSET_DETECT_ENABLED	0x80
+#define AIC3X_HEADSET_DETECT_SHIFT	5
+#define AIC3X_HEADSET_DETECT_MASK	3
+#define AIC3X_HEADSET_DEBOUNCE_SHIFT	2
+#define AIC3X_HEADSET_DEBOUNCE_MASK	7
+#define AIC3X_BUTTON_DEBOUNCE_SHIFT	0
+#define AIC3X_BUTTON_DEBOUNCE_MASK	3
+
+/* from soc-dai.h*/
+
+#define SND_SOC_DAIFMT_FORMAT_MASK		0x000f
+#define SND_SOC_DAIFMT_CLOCK_MASK		0x00f0
+#define SND_SOC_DAIFMT_INV_MASK			0x0f00
+#define SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK	0xf000
+
+#define SND_SOC_DAIFMT_CBP_CFP		BIT(12) /* codec clk provider & frame provider */
+#define SND_SOC_DAIFMT_CBC_CFP		(2 << 12) /* codec clk consumer & frame provider */
+#define SND_SOC_DAIFMT_CBP_CFC		(3 << 12) /* codec clk provider & frame consumer */
+#define SND_SOC_DAIFMT_CBC_CFC		(4 << 12) /* codec clk consumer & frame consumer */
+
+/*
+ * DAI hardware signal polarity.
+ *
+ * Specifies whether the DAI can also support inverted clocks for the specified
+ * format.
+ *
+ * BCLK:
+ * - "normal" polarity means signal is available at rising edge of BCLK
+ * - "inverted" polarity means signal is available at falling edge of BCLK
+ *
+ * FSYNC "normal" polarity depends on the frame format:
+ * - I2S: frame consists of left then right channel data. Left channel starts
+ *      with falling FSYNC edge, right channel starts with rising FSYNC edge.
+ * - Left/Right Justified: frame consists of left then right channel data.
+ *      Left channel starts with rising FSYNC edge, right channel starts with
+ *      falling FSYNC edge.
+ * - DSP A/B: Frame starts with rising FSYNC edge.
+ * - AC97: Frame starts with rising FSYNC edge.
+ *
+ * "Negative" FSYNC polarity is the one opposite of "normal" polarity.
+ */
+
+#define SND_SOC_DAIFMT_NB_NF_UBT		(0 << 8) /* normal bit clock + frame */
+#define SND_SOC_DAIFMT_NB_IF		(2 << 8) /* normal BCLK + inv FRM */
+#define SND_SOC_DAIFMT_IB_NF		(3 << 8) /* invert BCLK + nor FRM */
+#define SND_SOC_DAIFMT_IB_IF		(4 << 8) /* invert BCLK + FRM */
+
+#define	EINVAL		22	/* Invalid argument */
+
+#endif /* _AIC3X_H */
-- 
2.34.1

