Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83560CA0FED
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 00:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FE1839D5;
	Sat,  6 Sep 2025 02:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V+BrHkQT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qtUgkMo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21A1839F0; Sat,  6 Sep 2025 02:05:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D93C83919
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 02:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cJYQ40N7vz9tHG;
 Sat,  6 Sep 2025 02:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757117132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2Keck1jdpVHrRDzVc1pyH7cdb4DQSvaQ2BPBUNm05zw=;
 b=V+BrHkQTIgsU0xyCpUmIdVvJgtSTyscaWfZAyuAMYIZgJTL3brmNLj1WfBmo1duZaLbL7g
 +5tz0cnRc5ZPYipSmQI8UYJZ9NCG9vluLPoujjIC4Vod15wY8lr1Yh3B5ZFKMj374GJAfL
 7mF7xDdhD3lT+KXvrlEzZRqGxlz+jIxoWH5zKf0UjA7XAMaSGxvaFA4sPaQjxetTDCVAK0
 eLZmhLKoCdZoeWuU8kg7B74NW+yaRkwCNQud2JtILAiJA6pkEhzSEoIbMAfp05RtpZ4ndt
 +fk+O5eZmkQUsfXwF3UGjHNwfMJeuGf/8EqZI9DKIfjTbQNALLsF37HHr/QeWw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757117130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2Keck1jdpVHrRDzVc1pyH7cdb4DQSvaQ2BPBUNm05zw=;
 b=qtUgkMo3NYOJNx2vh6VEP0Dm7Ek/7RurOMcBh3BhPUsQlb2poWTyW44uzvMY7lMycG7ocX
 1Hh9Jrn0BwfILUbLNvnzCCct8CT9dhg+bnZ0sznb8p0xW9cTTOEwRlRpVufIlUD4BFGzGN
 j4Sb/eThrFQFe9zxpFJ5bmX/LX0IFcWba1eSB0B8uM9DD7eRk6E/NGbrgRtCaUg63/UR12
 WBWg3c1JIEnYfcWCPE9UiaAZ1kszsqpD/2jwfHDczTcULAZDpIE/AkH00QtP3jZSrmpLXa
 CezI/JaHrGHsOBAvXE04XIRhHeb4HeBlwR838POrc8tgRQFoluUtfK/v2mvM0g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] thermal: rcar_gen3: Add Renesas R-Car Gen3/Gen4 and RZ/G2
 thermal driver
Date: Sat,  6 Sep 2025 02:04:19 +0200
Message-ID: <20250906000507.284853-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b2778648c80aa563c0a
X-MBO-RS-META: scc4xj5bz9eu5u9ynzwf7cbacr4g1e8k
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

Add support for R-Car Gen3/Gen4 and RZ/G2 thermal sensors.
Fuse readout support is present, including fallback trimming.

Example usage using the 'temperature' command on R-Car V4H Sparrow Hawk:

"
=> temperature list
| Device                        | Driver                        | Parent
| thermal-rcar-gen3-tsc.0       | thermal-rcar-gen3-tsc         | thermal@e6198000
| thermal-rcar-gen3-tsc.1       | thermal-rcar-gen3-tsc         | thermal@e6198000
| thermal-rcar-gen3-tsc.2       | thermal-rcar-gen3-tsc         | thermal@e6198000
| thermal-rcar-gen3-tsc.3       | thermal-rcar-gen3-tsc         | thermal@e6198000

=> for i in 0 1 2 3 ; do temperature get thermal-rcar-gen3-tsc.$i ; done
thermal-rcar-gen3-tsc.0: 56 C
thermal-rcar-gen3-tsc.1: 50 C
thermal-rcar-gen3-tsc.2: 48 C
thermal-rcar-gen3-tsc.3: 52 C
"

Ported from Linux 6.16-rc6 commit
9e1dc0360fcf ("thermal/drivers/rcar_gen3: Add support for R-Car V4H default trim values")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/thermal/Kconfig             |   8 +
 drivers/thermal/Makefile            |   1 +
 drivers/thermal/rcar_gen3_thermal.c | 468 ++++++++++++++++++++++++++++
 3 files changed, 477 insertions(+)
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 440eb64a566..91c39aa4dee 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -35,6 +35,14 @@ config IMX_TMU
 	  The boot is hold to the cool device to throttle CPUs when the
 	  passive trip is crossed
 
+config RCAR_GEN3_THERMAL
+	bool "Renesas R-Car Gen3/Gen4 and RZ/G2 thermal driver"
+	depends on ARCH_RENESAS
+	depends on RCAR_64
+	help
+	  Enable this to plug the R-Car Gen3/Gen4 or RZ/G2 thermal sensor
+	  driver into the U-Boot thermal framework.
+
 config TI_DRA7_THERMAL
         bool "Temperature sensor driver for TI dra7xx SOCs"
         help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 18ad453f9b1..b6f06c00ed9 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DM_THERMAL) += thermal-uclass.o
 obj-$(CONFIG_IMX_SCU_THERMAL) += imx_scu_thermal.o
 obj-$(CONFIG_IMX_THERMAL) += imx_thermal.o
 obj-$(CONFIG_IMX_TMU) += imx_tmu.o
+obj-$(CONFIG_RCAR_GEN3_THERMAL) += rcar_gen3_thermal.o
 obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
 obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
 obj-$(CONFIG_TI_LM74_THERMAL) += ti-lm74.o
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
new file mode 100644
index 00000000000..83433e8d8f0
--- /dev/null
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
+ *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
+ *  Based on 
+ *
+ * Copyright (C) 2016 Renesas Electronics Corporation.
+ * Copyright (C) 2016 Sang Engineering
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/delay.h>
+#include <thermal.h>
+
+/* Register offsets */
+#define REG_GEN3_IRQSTR		0x04
+#define REG_GEN3_IRQMSK		0x08
+#define REG_GEN3_IRQCTL		0x0c
+#define REG_GEN3_IRQEN		0x10
+#define REG_GEN3_IRQTEMP1	0x14
+#define REG_GEN3_IRQTEMP2	0x18
+#define REG_GEN3_IRQTEMP3	0x1c
+#define REG_GEN3_THCTR		0x20
+#define REG_GEN3_TEMP		0x28
+#define REG_GEN3_THCODE1	0x50
+#define REG_GEN3_THCODE2	0x54
+#define REG_GEN3_THCODE3	0x58
+#define REG_GEN3_PTAT1		0x5c
+#define REG_GEN3_PTAT2		0x60
+#define REG_GEN3_PTAT3		0x64
+#define REG_GEN3_THSCP		0x68
+#define REG_GEN4_THSFMON00	0x180
+#define REG_GEN4_THSFMON01	0x184
+#define REG_GEN4_THSFMON02	0x188
+#define REG_GEN4_THSFMON15	0x1bc
+#define REG_GEN4_THSFMON16	0x1c0
+#define REG_GEN4_THSFMON17	0x1c4
+
+/* IRQ{STR,MSK,EN} bits */
+#define IRQ_TEMP1		BIT(0)
+#define IRQ_TEMP2		BIT(1)
+#define IRQ_TEMP3		BIT(2)
+#define IRQ_TEMPD1		BIT(3)
+#define IRQ_TEMPD2		BIT(4)
+#define IRQ_TEMPD3		BIT(5)
+
+/* THCTR bits */
+#define THCTR_PONM	BIT(6)
+#define THCTR_THSST	BIT(0)
+
+/* THSCP bits */
+#define THSCP_COR_PARA_VLD	(BIT(15) | BIT(14))
+
+#define CTEMP_MASK	0xfff
+
+#define MCELSIUS(temp)	((temp) * 1000)
+#define GEN3_FUSE_MASK	0xfff
+#define GEN4_FUSE_MASK	0xfff
+
+#define TSC_MAX_NUM	5
+
+struct rcar_gen3_thermal_priv;
+
+struct rcar_gen3_thermal_fuse_info {
+	u32 ptat[3];
+	u32 thcode[3];
+	u32 mask;
+};
+
+struct rcar_gen3_thermal_fuse_default {
+	u32 ptat[3];
+	u32 thcodes[TSC_MAX_NUM][3];
+};
+
+struct rcar_thermal_info {
+	int scale;
+	int adj_below;
+	int adj_above;
+	const struct rcar_gen3_thermal_fuse_info *fuses;
+	const struct rcar_gen3_thermal_fuse_default *fuse_defaults;
+};
+
+struct equation_set_coef {
+	int a;
+	int b;
+};
+
+struct rcar_gen3_thermal_tsc {
+	void __iomem *base;
+	/* Different coefficients are used depending on a threshold. */
+	struct {
+		struct equation_set_coef below;
+		struct equation_set_coef above;
+	} coef;
+	int thcode[3];
+};
+
+struct rcar_gen3_thermal_priv {
+	struct rcar_gen3_thermal_tsc tscs[TSC_MAX_NUM];
+	unsigned int num_tscs;
+	int ptat[3];
+};
+
+static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
+					 u32 reg)
+{
+	return readl(tsc->base + reg);
+}
+
+static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
+					   u32 reg, u32 data)
+{
+	writel(data, tsc->base + reg);
+}
+
+/*
+ * Linear approximation for temperature
+ *
+ * [temp] = ((thadj - [reg]) * a) / b + adj
+ * [reg] = thadj - ([temp] - adj) * b / a
+ *
+ * The constants a and b are calculated using two triplets of int values PTAT
+ * and THCODE. PTAT and THCODE can either be read from hardware or use hard
+ * coded values from the driver. The formula to calculate a and b are taken from
+ * the datasheet. Different calculations are needed for a and b depending on
+ * if the input variables ([temp] or [reg]) are above or below a threshold. The
+ * threshold is also calculated from PTAT and THCODE using formulas from the
+ * datasheet.
+ *
+ * The constant thadj is one of the THCODE values, which one to use depends on
+ * the threshold and input value.
+ *
+ * The constants adj is taken verbatim from the datasheet. Two values exists,
+ * which one to use depends on the input value and the calculated threshold.
+ * Furthermore different SoC models supported by the driver have different sets
+ * of values. The values for each model are stored in the device match data.
+ */
+static void rcar_gen3_thermal_tsc_coefs(struct udevice *dev,
+					struct rcar_gen3_thermal_tsc *tsc)
+{
+	struct rcar_thermal_info *info = (struct rcar_thermal_info *)dev_get_driver_data(dev);
+	struct rcar_gen3_thermal_priv *priv = dev_get_plat(dev);
+
+	tsc->coef.below.a = info->scale * (priv->ptat[2] - priv->ptat[1]);
+	tsc->coef.above.a = info->scale * (priv->ptat[0] - priv->ptat[1]);
+
+	tsc->coef.below.b = (priv->ptat[2] - priv->ptat[0]) * (tsc->thcode[2] - tsc->thcode[1]);
+	tsc->coef.above.b = (priv->ptat[0] - priv->ptat[2]) * (tsc->thcode[1] - tsc->thcode[0]);
+}
+
+static int rcar_gen3_thermal_get_temp(struct udevice *dev, int *temp)
+{
+	struct rcar_thermal_info *info = (struct rcar_thermal_info *)dev_get_driver_data(dev->parent);
+	struct rcar_gen3_thermal_priv *priv = dev_get_plat(dev->parent);
+	unsigned int tsc_id = dev_get_driver_data(dev);
+	struct rcar_gen3_thermal_tsc *tsc = &(priv->tscs[tsc_id]);
+	const struct equation_set_coef *coef;
+	int adj, decicelsius, reg, thcode;
+
+	/* Read register and convert to degree Celsius */
+	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
+
+	if (reg < tsc->thcode[1]) {
+		adj = info->adj_below;
+		coef = &tsc->coef.below;
+		thcode = tsc->thcode[2];
+	} else {
+		adj = info->adj_above;
+		coef = &tsc->coef.above;
+		thcode = tsc->thcode[0];
+	}
+
+	/*
+	 * The dividend can't be grown as it might overflow, instead shorten the
+	 * divisor to convert to decidegree Celsius. If we convert after the
+	 * division precision is lost as we will scale up from whole degrees
+	 * Celsius.
+	 */
+	decicelsius = DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b / 10);
+
+	/* Guaranteed operating range is -40C to 125C. */
+
+	/* Reporting is done in degree Celsius */
+	*temp = (decicelsius * 100 + adj * 1000) / 1000;
+
+	return 0;
+}
+
+static const struct dm_thermal_ops rcar_gen3_thermal_ops = {
+	.get_temp	= rcar_gen3_thermal_get_temp,
+};
+
+static void rcar_gen3_thermal_fetch_fuses(struct udevice *dev)
+{
+	struct rcar_thermal_info *info = (struct rcar_thermal_info *)dev_get_driver_data(dev);
+	struct rcar_gen3_thermal_priv *priv = dev_get_plat(dev);
+	const struct rcar_gen3_thermal_fuse_info *fuses = info->fuses;
+
+	/*
+	 * Set the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSCs but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+	priv->ptat[0] = rcar_gen3_thermal_read(&(priv->tscs[0]), fuses->ptat[0])
+		& fuses->mask;
+	priv->ptat[1] = rcar_gen3_thermal_read(&(priv->tscs[0]), fuses->ptat[1])
+		& fuses->mask;
+	priv->ptat[2] = rcar_gen3_thermal_read(&(priv->tscs[0]), fuses->ptat[2])
+		& fuses->mask;
+
+	for (unsigned int i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = &(priv->tscs[i]);
+
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, fuses->thcode[0])
+			& fuses->mask;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, fuses->thcode[1])
+			& fuses->mask;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, fuses->thcode[2])
+			& fuses->mask;
+	}
+}
+
+static bool rcar_gen3_thermal_read_fuses(struct udevice *dev)
+{
+	struct rcar_thermal_info *info = (struct rcar_thermal_info *)dev_get_driver_data(dev);
+	struct rcar_gen3_thermal_priv *priv = dev_get_plat(dev);
+	const struct rcar_gen3_thermal_fuse_default *fuse_defaults = info->fuse_defaults;
+	unsigned int i;
+	u32 thscp;
+
+	/* If fuses are not set, fallback to pseudo values. */
+	thscp = rcar_gen3_thermal_read(&(priv->tscs[0]), REG_GEN3_THSCP);
+	if (!info->fuses ||
+	    (thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
+		/* Default THCODE values in case FUSEs are not set. */
+		priv->ptat[0] = fuse_defaults->ptat[0];
+		priv->ptat[1] = fuse_defaults->ptat[1];
+		priv->ptat[2] = fuse_defaults->ptat[2];
+
+		for (i = 0; i < priv->num_tscs; i++) {
+			struct rcar_gen3_thermal_tsc *tsc = &(priv->tscs[i]);
+
+			tsc->thcode[0] = fuse_defaults->thcodes[i][0];
+			tsc->thcode[1] = fuse_defaults->thcodes[i][1];
+			tsc->thcode[2] = fuse_defaults->thcodes[i][2];
+		}
+
+		return false;
+	}
+
+	rcar_gen3_thermal_fetch_fuses(dev);
+
+	return true;
+}
+
+static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
+				   struct rcar_gen3_thermal_tsc *tsc)
+{
+	u32 reg_val;
+
+	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
+	reg_val &= ~THCTR_PONM;
+	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+
+	udelay(1000);
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+
+	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
+	reg_val |= THCTR_THSST;
+	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+
+	udelay(1000);
+}
+
+static int rcar_gen3_thermal_probe(struct udevice *dev)
+{
+	struct rcar_gen3_thermal_priv *priv = dev_get_plat(dev);
+	unsigned int i;
+
+	if (!rcar_gen3_thermal_read_fuses(dev))
+		dev_dbg(dev, "No calibration values fused, fallback to driver values\n");
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = &(priv->tscs[i]);
+
+		rcar_gen3_thermal_init(priv, tsc);
+		rcar_gen3_thermal_tsc_coefs(dev, tsc);
+	}
+
+	return 0;
+}
+
+static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen3 = {
+	.ptat = { REG_GEN3_PTAT1, REG_GEN3_PTAT2, REG_GEN3_PTAT3 },
+	.thcode = { REG_GEN3_THCODE1, REG_GEN3_THCODE2, REG_GEN3_THCODE3 },
+	.mask = GEN3_FUSE_MASK,
+};
+
+static const struct rcar_gen3_thermal_fuse_info rcar_gen3_thermal_fuse_info_gen4 = {
+	.ptat = { REG_GEN4_THSFMON16, REG_GEN4_THSFMON17, REG_GEN4_THSFMON15 },
+	.thcode = { REG_GEN4_THSFMON01, REG_GEN4_THSFMON02, REG_GEN4_THSFMON00 },
+	.mask = GEN4_FUSE_MASK,
+};
+
+static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_gen3 = {
+	.ptat = { 2631, 1509, 435 },
+	.thcodes = {
+		{ 3397, 2800, 2221 },
+		{ 3393, 2795, 2216 },
+		{ 3389, 2805, 2237 },
+		{ 3415, 2694, 2195 },
+		{ 3356, 2724, 2244 },
+	},
+};
+
+static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_v4h = {
+	.ptat = { 3274, 2164, 985 },
+	.thcodes = { /* All four THS units share the same trimming */
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+	}
+};
+
+static const struct rcar_thermal_info rcar_m3w_thermal_info = {
+	.scale = 157,
+	.adj_below = -41,
+	.adj_above = 116,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
+};
+
+static const struct rcar_thermal_info rcar_gen3_thermal_info = {
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen3,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
+};
+
+static const struct rcar_thermal_info rcar_gen4_thermal_info = {
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
+};
+
+static const struct rcar_thermal_info rcar_v4h_thermal_info = {
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_v4h,
+};
+
+static const struct udevice_id rcar_gen3_thermal_ids[] = {
+	{
+		.compatible = "renesas,r8a774a1-thermal",
+		.data = (ulong)&rcar_m3w_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a774b1-thermal",
+		.data = (ulong)&rcar_gen3_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a774e1-thermal",
+		.data = (ulong)&rcar_gen3_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a7795-thermal",
+		.data = (ulong)&rcar_gen3_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a7796-thermal",
+		.data = (ulong)&rcar_m3w_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a77961-thermal",
+		.data = (ulong)&rcar_m3w_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a77965-thermal",
+		.data = (ulong)&rcar_gen3_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a77980-thermal",
+		.data = (ulong)&rcar_gen3_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a779a0-thermal",
+		.data = (ulong)&rcar_gen3_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a779f0-thermal",
+		.data = (ulong)&rcar_gen4_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a779g0-thermal",
+		.data = (ulong)&rcar_v4h_thermal_info,
+	},
+	{
+		.compatible = "renesas,r8a779h0-thermal",
+		.data = (ulong)&rcar_gen4_thermal_info,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(thermal_rcar_gen3_tsc) = {
+	.name		= "thermal-rcar-gen3-tsc",
+	.id		= UCLASS_THERMAL,
+	.ops		= &rcar_gen3_thermal_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static int rcar_gen3_thermal_bind(struct udevice *dev)
+{
+	/*
+	 * We use dev_get_plat() here, because plat data are available
+	 * in bind, while private data are not allocated yet.
+	 */
+	struct rcar_gen3_thermal_priv *priv = dev_get_plat(dev);
+	struct udevice *tdev;
+	struct driver *tdrv;
+	char name[32];
+	void *addr;
+	int i, ret;
+
+	tdrv = lists_driver_lookup_name("thermal-rcar-gen3-tsc");
+	if (!tdrv)
+		return -ENOENT;
+
+	for (i = 0; i < TSC_MAX_NUM; i++) {
+		addr = dev_read_addr_index_ptr(dev, i);
+		if (!addr)
+			break;
+
+		priv->tscs[i].base = addr;
+
+		tdev = NULL;
+		snprintf(name, sizeof(name), "thermal-rcar-gen3-tsc.%d", i);
+		ret = device_bind_with_driver_data(dev, tdrv, strdup(name), i,
+						   dev_ofnode(dev), &tdev);
+		if (ret)
+			return ret;
+	}
+
+	priv->num_tscs = i;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(thermal_rcar_gen3) = {
+	.name		= "thermal-rcar-gen3",
+	.id		= UCLASS_NOP,
+	.of_match	= rcar_gen3_thermal_ids,
+	.bind		= rcar_gen3_thermal_bind,
+	.probe		= rcar_gen3_thermal_probe,
+	.plat_auto	= sizeof(struct rcar_gen3_thermal_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.50.1

