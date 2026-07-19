Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF2BC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92A384A4C;
	Sun, 19 Jul 2026 20:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rjTUhUKp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pBBn1rPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE7184A29; Sun, 19 Jul 2026 20:13:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 563E384A29
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h3BbC0xT0zMlGd;
 Sun, 19 Jul 2026 20:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SJI4dyAj/O4wrfQef434zEjYMhXYGcUp3jpsXXWvRMo=;
 b=rjTUhUKpImyynuGA2USYr6kvme7dhB0zkCDjifN5fVCCuLdh5sasyFTfqpZSgW1U3zB/aY
 MmB4rjBq5noBFSI8mEbGFB3ePbZY20W0WP9ESkL2wrCCxLqLntAN/NpyFtP5vnYswf6Wbe
 n82vkrE+UNuWr2fJFMUuO3N7Fo5ATNgolK+ZA7lUQjzRph886GfzWewGgWcPEC8gPRslyL
 xDMP9smvWrO1vXWMNx9wzlW4bImaYhcZZeoB/LA4tLyzAgx19g0MzX1bODV0aKYHBV3g73
 h03HmeHZ/IEkPCMQBF30hEJjlXoNsZ6qyOsTRHA8kSJhyISEZdUwUCTt+ot9uQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SJI4dyAj/O4wrfQef434zEjYMhXYGcUp3jpsXXWvRMo=;
 b=pBBn1rPNRWof6OxWrWhGYIYdfYuEhJILW/ecBNYQVsrm6dtD/WP1YBsehQCUJ/oY0/h+hZ
 asdxWam7qf5mNgKXQ+m6317gPJ8v/6eRDoWew5pd20cwuItp2PdX2dg5FYGrHPH5J8Pg9e
 psmXaRGTRLUPEK2KGhrI6qI6aHx2xjw9yf4C/PhHN5uQiR3C4DzLFIpYLCLGOeLByZruGk
 MUaO7QqEd5ORCltP7+dh87EP3rK8MLh5hj2k9cpe2oem+QZAF5KSPhWHrkDQVcjfVhlA45
 5CCg8zPNcSorSJhMGq5E9IQ22mEi3CIRQAKx7DsGZouz+TniAXmSz0gLmQ/wlA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] clk: rs9: Add Renesas 9-series PCIe clock generator driver
Date: Sun, 19 Jul 2026 20:11:49 +0200
Message-ID: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a86f0e85984112f8b91
X-MBO-RS-META: agdpioq5macwzo3h3nbznec8bywqfftb
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

Add driver for Renesas 9-series PCIe clock generators. This driver
is designed to support 9FGV/9DBV/9DMV/9FGL/9DML/9QXL/9SQ series I2C
PCIe clock generators.

The driver is capable of configuring per-chip spread spectrum mode
and output amplitude, as well as per-output slew rate.

Losely based on Linux 7.1 commit
5ec820fc28d0 ("clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/Kconfig            |   7 +
 drivers/clk/Makefile           |   1 +
 drivers/clk/clk-renesas-pcie.c | 327 +++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+)
 create mode 100644 drivers/clk/clk-renesas-pcie.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e69b0543817..382d7871230 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -215,6 +215,13 @@ config CLK_HSDK
 	  Enable this to support the cgu clocks on Synopsys ARC HSDK and
 	  Synopsys ARC HSDK-4xD boards
 
+config CLK_RS9_PCIE
+	tristate "Clock driver for Renesas 9-series PCIe clock generators"
+	depends on CLK
+	help
+	  This driver supports the Renesas 9-series PCIe clock generator
+	  models 9FGV/9DBV/9DMV/9FGL/9DML/9QXL/9SQ.
+
 config CLK_VERSACLOCK
 	bool "Enable VersaClock 5/6 devices"
 	depends on CLK
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c37ef75d420..1bc25924acb 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
 obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
+obj-$(CONFIG_$(PHASE_)CLK_RS9_PCIE) += clk-renesas-pcie.o
 obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
new file mode 100644
index 00000000000..ad57cd4fd28
--- /dev/null
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Renesas 9-series PCIe clock generator driver
+ *
+ * The following series can be supported:
+ *   - 9FGV/9DBV/9DMV/9FGL/9DML/9QXL/9SQ
+ * Currently supported:
+ *   - 9FGV0241
+ *   - 9FGV0441
+ *   - 9FGV0841
+ *
+ * Copyright (C) 2022-2026 Marek Vasut
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <i2c.h>
+#include <linux/bitops.h>
+
+#define RS9_REG_OE				0x0
+#define RS9_REG_SS				0x1
+#define RS9_REG_SS_AMP_0V6			0x0
+#define RS9_REG_SS_AMP_0V7			0x1
+#define RS9_REG_SS_AMP_0V8			0x2
+#define RS9_REG_SS_AMP_0V9			0x3
+#define RS9_REG_SS_AMP_DEFAULT			RS9_REG_SS_AMP_0V8
+#define RS9_REG_SS_AMP_MASK			0x3
+#define RS9_REG_SS_SSC_100			0
+#define RS9_REG_SS_SSC_M025			(1 << 3)
+#define RS9_REG_SS_SSC_M050			(3 << 3)
+#define RS9_REG_SS_SSC_DEFAULT			RS9_REG_SS_SSC_100
+#define RS9_REG_SS_SSC_MASK			(3 << 3)
+#define RS9_REG_SS_SSC_LOCK			BIT(5)
+#define RS9_REG_SR				0x2
+#define RS9_REG_REF				0x3
+#define RS9_REG_REF_OE				BIT(4)
+#define RS9_REG_REF_OD				BIT(5)
+#define RS9_REG_REF_SR_SLOWEST			0
+#define RS9_REG_REF_SR_SLOW			(1 << 6)
+#define RS9_REG_REF_SR_FAST			(2 << 6)
+#define RS9_REG_REF_SR_FASTER			(3 << 6)
+#define RS9_REG_VID				0x5
+#define RS9_REG_DID				0x6
+#define RS9_REG_BCP				0x7
+
+#define RS9_REG_VID_MASK			GENMASK(3, 0)
+#define RS9_REG_VID_IDT				0x01
+
+#define RS9_REG_DID_TYPE_FGV			(0x0 << RS9_REG_DID_TYPE_SHIFT)
+#define RS9_REG_DID_TYPE_DBV			(0x1 << RS9_REG_DID_TYPE_SHIFT)
+#define RS9_REG_DID_TYPE_DMV			(0x2 << RS9_REG_DID_TYPE_SHIFT)
+#define RS9_REG_DID_TYPE_SHIFT			0x6
+
+/* Structure to describe features of a particular 9-series model */
+struct rs9_chip_info {
+	unsigned int		num_clks;
+	u8			outshift;
+	u8			did;
+};
+
+struct rs9_driver_data {
+	struct udevice		*i2c;
+	struct rs9_chip_info	*chip_info;
+	unsigned long		rate;
+	u8			pll_amplitude;
+	u8			pll_ssc;
+	u8			clk_dif_sr;
+};
+
+static int clk_rs9_request(struct clk *clk)
+{
+	struct rs9_driver_data *rs9 = dev_get_priv(clk->dev);
+
+	if (clk->id > rs9->chip_info->num_clks)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ulong clk_rs9_get_rate(struct clk *clk)
+{
+	struct rs9_driver_data *rs9 = dev_get_priv(clk->dev);
+
+	return rs9->rate * 4;
+}
+
+static const struct clk_ops clk_rs9_ops = {
+	.request = clk_rs9_request,
+	.get_rate = clk_rs9_get_rate,
+};
+
+static int rs9_write(struct udevice *dev, u8 reg, u8 val)
+{
+	u8 data[2] = { 1, val };
+
+	return dm_i2c_write(dev, reg, data, 2);
+}
+
+static int rs9_read(struct udevice *dev, u8 reg, u8 *val)
+{
+	struct dm_i2c_chip *chip = dev_get_parent_plat(dev);
+	struct i2c_msg xfer[2];
+	u8 txdata = reg;
+	u8 rxdata[2];
+	int ret;
+
+	xfer[0].addr = chip->chip_addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 1;
+	xfer[0].buf = (void *)&txdata;
+
+	xfer[1].addr = chip->chip_addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 2;
+	xfer[1].buf = (void *)rxdata;
+
+	ret = dm_i2c_xfer(dev, xfer, 2);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Byte 0 is transfer length, which is always 1 due
+	 * to BCP register programming to 1 in rs9_probe(),
+	 * ignore it and use data from Byte 1.
+	 */
+	*val = rxdata[1];
+	return 0;
+}
+
+static u8 rs9_calc_dif(const struct rs9_driver_data *rs9, int idx)
+{
+	/*
+	 * On 9FGV0241, the DIF OE0 is BIT(1) and DIF OE(1) is BIT(2),
+	 * on 9FGV0441 and 9FGV0841 the DIF OE0 is BIT(0) and so on.
+	 * Increment the index in the 9FGV0241 special case here.
+	 */
+	return BIT(idx + rs9->chip_info->outshift);
+}
+
+static int rs9_get_output_config(struct rs9_driver_data *rs9, int idx)
+{
+	struct udevice *dev = rs9->i2c;
+	u8 dif = rs9_calc_dif(rs9, idx);
+	unsigned char name[5] = "DIF0";
+	ofnode np;
+	u32 sr;
+
+	/* Set defaults */
+	rs9->clk_dif_sr |= dif;
+
+	snprintf(name, 5, "DIF%d", idx);
+	np = dev_read_subnode(dev, name);
+	if (!ofnode_valid(np))
+		return 0;
+
+	/* Output clock slew rate */
+	sr = ofnode_read_u32_default(np, "renesas,slew-rate", 3000000);
+	if (sr == 2000000) {		/* 2V/ns */
+		rs9->clk_dif_sr &= ~dif;
+	} else if (sr == 3000000) {	/* 3V/ns (default) */
+		rs9->clk_dif_sr |= dif;
+	} else {
+		dev_err(dev, "Invalid renesas,slew-rate value\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rs9_get_common_config(struct rs9_driver_data *rs9)
+{
+	struct udevice *dev = rs9->i2c;
+	unsigned int amp, ssc;
+
+	/* Set defaults */
+	rs9->pll_amplitude = RS9_REG_SS_AMP_DEFAULT;
+	rs9->pll_ssc = RS9_REG_SS_SSC_DEFAULT;
+
+	/* Output clock amplitude */
+	amp = dev_read_u32_default(dev, "renesas,out-amplitude-microvolt", 700000);
+	if (amp == 600000) {	/* 0.6V */
+		rs9->pll_amplitude = RS9_REG_SS_AMP_0V6;
+	} else if (amp == 700000) {	/* 0.7V (default) */
+		rs9->pll_amplitude = RS9_REG_SS_AMP_0V7;
+	} else if (amp == 800000) {	/* 0.8V */
+		rs9->pll_amplitude = RS9_REG_SS_AMP_0V8;
+	} else if (amp == 900000) {	/* 0.9V */
+		rs9->pll_amplitude = RS9_REG_SS_AMP_0V9;
+	} else {
+		dev_err(dev, "Invalid renesas,out-amplitude-microvolt value\n");
+		return -EINVAL;
+	}
+
+	/* Output clock spread spectrum */
+	ssc = dev_read_u32_default(dev, "renesas,out-spread-spectrum", 100000);
+	if (ssc == 100000) {	/* 100% ... no spread (default) */
+		rs9->pll_ssc = RS9_REG_SS_SSC_100;
+	} else if (ssc == 99750) {	/* -0.25% ... down spread */
+		rs9->pll_ssc = RS9_REG_SS_SSC_M025;
+	} else if (ssc == 99500) {	/* -0.50% ... down spread */
+		rs9->pll_ssc = RS9_REG_SS_SSC_M050;
+	} else {
+		dev_err(dev, "Invalid renesas,out-spread-spectrum value\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rs9_update_config(struct rs9_driver_data *rs9)
+{
+	struct udevice *dev = rs9->i2c;
+	int i;
+
+	/* If amplitude is non-default, update it. */
+	if (rs9->pll_amplitude != RS9_REG_SS_AMP_DEFAULT) {
+		dm_i2c_reg_clrset(dev, RS9_REG_SS, RS9_REG_SS_AMP_MASK,
+				  rs9->pll_amplitude);
+	}
+
+	/* If SSC is non-default, update it. */
+	if (rs9->pll_ssc != RS9_REG_SS_SSC_DEFAULT) {
+		dm_i2c_reg_clrset(dev, RS9_REG_SS, RS9_REG_SS_SSC_MASK,
+				  rs9->pll_ssc);
+	}
+
+	for (i = 0; i < rs9->chip_info->num_clks; i++) {
+		u8 dif = rs9_calc_dif(rs9, i);
+
+		if (rs9->clk_dif_sr & dif)
+			continue;
+
+		dm_i2c_reg_clrset(dev, RS9_REG_SR, dif,
+				  rs9->clk_dif_sr & dif);
+	}
+}
+
+static int clk_rs9_probe(struct udevice *dev)
+{
+	struct rs9_driver_data *rs9 = dev_get_priv(dev);
+	struct clk *clk;
+	u8 vid, did;
+	int i, ret;
+
+	rs9->i2c = dev;
+	rs9->chip_info = (struct rs9_chip_info *)dev_get_driver_data(dev);
+	if (!rs9->chip_info)
+		return -EINVAL;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rs9->rate = clk_get_rate(clk);
+
+	/* Fetch common configuration from DT (if specified) */
+	ret = rs9_get_common_config(rs9);
+	if (ret)
+		return ret;
+
+	/* Fetch DIFx output configuration from DT (if specified) */
+	for (i = 0; i < rs9->chip_info->num_clks; i++) {
+		ret = rs9_get_output_config(rs9, i);
+		if (ret)
+			return ret;
+	}
+
+	/* Always read back 1 Byte via I2C */
+	ret = rs9_write(dev, RS9_REG_BCP, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = rs9_read(dev, RS9_REG_VID, &vid);
+	if (ret < 0)
+		return ret;
+
+	ret = rs9_read(dev, RS9_REG_DID, &did);
+	if (ret < 0)
+		return ret;
+
+	vid &= RS9_REG_VID_MASK;
+	if (vid != RS9_REG_VID_IDT || did != rs9->chip_info->did) {
+		dev_err(dev, "Incorrect VID/DID: %#02x, %#02x. Expected %#02x, %#02x\n",
+			vid, did, RS9_REG_VID_IDT, rs9->chip_info->did);
+		return -ENODEV;
+	}
+
+	rs9_update_config(rs9);
+
+	return 0;
+}
+
+static const struct rs9_chip_info renesas_9fgv0241_info = {
+	.num_clks	= 2,
+	.outshift	= 1,
+	.did		= RS9_REG_DID_TYPE_FGV | 0x02,
+};
+
+static const struct rs9_chip_info renesas_9fgv0441_info = {
+	.num_clks	= 4,
+	.outshift	= 0,
+	.did		= RS9_REG_DID_TYPE_FGV | 0x04,
+};
+
+static const struct rs9_chip_info renesas_9fgv0841_info = {
+	.num_clks	= 8,
+	.outshift	= 0,
+	.did		= RS9_REG_DID_TYPE_FGV | 0x08,
+};
+
+static const struct udevice_id clk_rs9_of_match[] = {
+	{ .compatible = "renesas,9fgv0241", .data = (ulong)&renesas_9fgv0241_info },
+	{ .compatible = "renesas,9fgv0441", .data = (ulong)&renesas_9fgv0441_info },
+	{ .compatible = "renesas,9fgv0841", .data = (ulong)&renesas_9fgv0841_info },
+	{ /* sentinel */ },
+};
+
+U_BOOT_DRIVER(clk_rs9) = {
+	.name = "clk-renesas-pcie-9series",
+	.id = UCLASS_CLK,
+	.of_match = clk_rs9_of_match,
+	.ops = &clk_rs9_ops,
+	.probe = clk_rs9_probe,
+	.priv_auto = sizeof(struct rs9_driver_data),
+};
-- 
2.53.0

