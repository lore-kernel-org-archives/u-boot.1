Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27D8C531CF
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36459409EC;
	Thu, 23 Jul 2026 13:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ny8dkb6H4HrB; Thu, 23 Jul 2026 13:49:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3991409DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784814558;
	bh=ixLqUnFSKJggFuVJrA5lsrfmNf5bIyv2vDHmAs2SAqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=icqxxsibmiR2+goLt5s0C2C2hQBHKtv9ju4ArvQeSsU8aYVENouZ/ehiXqBJiPk/x
	 a0Ch+rOKC5s8LtJuAJ8FrLRPUQeeZ+TZHq927HFyBS2Uzt9OW7W/1WojhWx73SFTcd
	 sdkwuaNEPne1AtVU8uhkBANyE0C3NQsUNAdDt5ciRQTmaqrAr/RvAP0y6MwFp//uhk
	 mjC2FwfiEnS842rh9W5RBg/d6rtriUBhg5Mc5CqHhKg5dYkOAf4JSkYGr6MQXSsE1Z
	 ZPe3I8Vm8MGiXfqvs25im7X1cJ1fWd1ay1n5icZ848HC7rEjljPMaRsT3SpaVzfmGG
	 fb0bC3Kpn26HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3991409DE;
	Thu, 23 Jul 2026 13:49:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84A133B1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75FF2403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKgUgE6kuUmC for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:49:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.146;
 helo=mail-d17.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3A31A40152
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A31A40152
Received: from mail-d17.seohost-mail.eu (mail-d17.seohost-mail.eu
 [153.92.25.146])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A31A40152
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:49:14 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=krzysztof-drobinski-HP-EliteBook-660-16-inch-G11-Notebook-PC.lan)
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wmtnU-00000007jrj-0vMJ; Thu, 23 Jul 2026 15:49:12 +0200
From: =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Subject: [PATCH 2/2] power: regulator: ADD PMIC PF9453 support
Date: Thu, 23 Jul 2026 15:21:57 +0200
Message-ID: <20260723134051.452817-3-krzysztof@kd-solutions.pl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134051.452817-1-krzysztof@kd-solutions.pl>
References: <20260723134051.452817-1-krzysztof@kd-solutions.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=kd-solutions.pl; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixLqUnFSKJggFuVJrA5lsrfmNf5bIyv2vDHmAs2SAqc=; b=TRPd2v1TyY0jFm/TguNmapcwHu
 87+WoZtYQcKN2tMYbK0YRshCJdRiNc1+pc0HkyC1YRxgOWVZUNYAdpI2KiGzFRz0xyXyKYdr0Ag+j
 n4r/axqE3h+wMxkhu1WYM0w2IMm312E1Z7+20yKNvq2LNxB0yXIRsCCNqLQ8520+Ay8zzC4yl/0Il
 Z6IXFJlbvfBlAPxic+VZSeuodnmxlrbQQWuESvNsEqrthvo69B0ESuFzSqIp2Fxbs3kr145y1AmBO
 PI/pA8W8wkmavzCQZxOCchuoAy7BKVHK4tl9y4TyLj1ksjhfDpY1LtPR+kIuVkHWYAqHZXJVnuYrV
 BFudS9pg==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=TRPd2v1T
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Joy Zou <joy.zou@nxp.com>

Add regulator support for NXP PMIC pf9453 for imx91 qsb.

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Rebased [1] on main and LDO SNVS access / checkpatch fixed. See also [2]
[1] https://patchwork.ozlabs.org/project/uboot/patch/20240930035531.27079-4-peng.fan@oss.nxp.com/
[2] https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625613.html
Signed-off-by: Krzysztof Drobiński <krzysztof@kd-solutions.pl>
---
 drivers/power/regulator/Kconfig  |  15 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/pf9453.c | 256 +++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/power/regulator/pf9453.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index c3dc5d6f97b..00a25acfdf9 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -103,6 +103,21 @@ config SPL_DM_REGULATOR_PCA9450
 	  This config enables implementation of driver-model regulator uclass
 	  features for regulators on ROHM PCA9450 in SPL.
 
+config DM_REGULATOR_PF9453
+	bool "Enable Driver Model for NXP PF9453 regulators"
+	depends on DM_REGULATOR && DM_PMIC_PF9453
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for regulators on NXP PF9453 PMICs. PF9453 contains 6 bucks
+	  and 5 LDOS. The driver implements get/set api for value and enable.
+
+config SPL_DM_REGULATOR_PF9453
+	bool "Enable Driver Model for NXP PF9453 regulators in SPL"
+	depends on DM_REGULATOR_PF9453 && SPL
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for regulators on ROHM PF9453 in SPL.
+
 config DM_REGULATOR_DA9063
 	bool "Enable Driver Model for REGULATOR DA9063"
 	depends on DM_REGULATOR && DM_PMIC_DA9063
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 3a148545387..a40c9d340d9 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_BD71837) += bd71837.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PCA9450) += pca9450.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PF9453) += pf9453.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_PWM) += pwm_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_COMMON) += regulator_common.o
diff --git a/drivers/power/regulator/pf9453.c b/drivers/power/regulator/pf9453.c
new file mode 100644
index 00000000000..6ecde09bafa
--- /dev/null
+++ b/drivers/power/regulator/pf9453.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP PF9453 regulator driver
+ * Copyright 2024 NXP
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <linux/bitops.h>
+#include <power/pf9453.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+/**
+ * struct pf9453_vrange - describe linear range of voltages
+ *
+ * @min_volt:	smallest voltage in range
+ * @step:	how much voltage changes at each selector step
+ * @min_sel:	smallest selector in the range
+ * @max_sel:	maximum selector in the range
+ */
+struct pf9453_vrange {
+	unsigned int	min_volt;
+	unsigned int	step;
+	u8		min_sel;
+	u8		max_sel;
+};
+
+/**
+ * struct pf9453_plat - describe regulator control registers
+ *
+ * @name:	name of the regulator. Used for matching the dt-entry
+ * @enable_reg:	register address used to enable/disable regulator
+ * @enablemask:	register mask used to enable/disable regulator
+ * @volt_reg:	register address used to configure regulator voltage
+ * @volt_mask:	register mask used to configure regulator voltage
+ * @ranges:	pointer to ranges of regulator voltages and matching register
+ *		values
+ * @numranges:	number of voltage ranges pointed by ranges
+ */
+struct pf9453_plat {
+	const char		*name;
+	u8			enable_reg;
+	u8			enablemask;
+	u8			volt_reg;
+	u8			volt_mask;
+	struct pf9453_vrange	*ranges;
+	unsigned int		numranges;
+};
+
+#define PCA_RANGE(_min, _vstep, _sel_low, _sel_hi) \
+{ \
+	.min_volt = (_min), .step = (_vstep), \
+	.min_sel = (_sel_low), .max_sel = (_sel_hi), \
+}
+
+#define PCA_DATA(_name, enreg, enmask, vreg, vmask, _range, _numranges) \
+{ \
+	.name = (_name), .enable_reg = (enreg), .enablemask = (enmask), \
+	.volt_reg = (vreg), .volt_mask = (vmask), .ranges = (_range), \
+	.numranges = _numranges \
+}
+
+static struct pf9453_vrange pf9453_buck134_vranges[] = {
+	PCA_RANGE(600000, 25000, 0, 0x7f),
+};
+
+static struct pf9453_vrange pf9453_buck2_vranges[] = {
+	PCA_RANGE(600000, 12500, 0, 0x7f),
+};
+
+static struct pf9453_vrange pf9453_ldo1_vranges[] = {
+	PCA_RANGE(800000, 25000, 0x0, 0x64),
+};
+
+static struct pf9453_vrange pf9453_ldo2_vranges[] = {
+	PCA_RANGE(500000, 25000, 0x0, 0x3a),
+};
+
+static struct pf9453_vrange pf9453_ldosnvs_vranges[] = {
+	PCA_RANGE(800000, 25000, 0x0, 0x58),
+};
+
+static struct pf9453_plat pf9453_reg_data[] = {
+	PCA_DATA("BUCK1", PF9453_BUCK1CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK1OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck134_vranges, ARRAY_SIZE(pf9453_buck134_vranges)),
+	PCA_DATA("BUCK2", PF9453_BUCK2CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK2OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck2_vranges, ARRAY_SIZE(pf9453_buck2_vranges)),
+	PCA_DATA("BUCK3", PF9453_BUCK3CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK3OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck134_vranges, ARRAY_SIZE(pf9453_buck134_vranges)),
+	PCA_DATA("BUCK4", PF9453_BUCK4CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK4OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck134_vranges, ARRAY_SIZE(pf9453_buck134_vranges)),
+	/* LDOs */
+	PCA_DATA("LDO1", PF9453_LDO1CFG, PF9453_EN_MODE_MASK,
+		 PF9453_LDO1OUT_H, PF9453_LDO1_MASK,
+		 pf9453_ldo1_vranges, ARRAY_SIZE(pf9453_ldo1_vranges)),
+	PCA_DATA("LDO2", PF9453_LDO2CFG, PF9453_EN_MODE_MASK,
+		 PF9453_LDO2OUT, PF9453_LDO2_MASK,
+		 pf9453_ldo2_vranges, ARRAY_SIZE(pf9453_ldo2_vranges)),
+	PCA_DATA("LDO-SNVS", PF9453_LDOSNVS_CFG2, PF9453_EN_MODE_MASK,
+		 PF9453_LDOSNVS_CFG1, PF9453_LDOSNVS_MASK,
+		 pf9453_ldosnvs_vranges, ARRAY_SIZE(pf9453_ldosnvs_vranges)),
+};
+
+static int vrange_find_value(struct pf9453_vrange *r, unsigned int sel,
+			     unsigned int *val)
+{
+	if (!val || sel < r->min_sel || sel > r->max_sel)
+		return -EINVAL;
+
+	*val = r->min_volt + r->step * (sel - r->min_sel);
+	return 0;
+}
+
+static int vrange_find_selector(struct pf9453_vrange *r, int val,
+				unsigned int *sel)
+{
+	int ret = -EINVAL;
+	int num_vals = r->max_sel - r->min_sel + 1;
+
+	if (val >= r->min_volt &&
+	    val <= r->min_volt + r->step * (num_vals - 1)) {
+		if (r->step) {
+			*sel = r->min_sel + ((val - r->min_volt) / r->step);
+			ret = 0;
+		} else {
+			*sel = r->min_sel;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+
+static int pf9453_get_enable(struct udevice *dev)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	int val;
+
+	val = pmic_reg_read(dev->parent, plat->enable_reg);
+	if (val < 0)
+		return val;
+
+	return (val & plat->enablemask);
+}
+
+static int pf9453_set_enable(struct udevice *dev, bool enable)
+{
+	int val = 0;
+	struct pf9453_plat *plat = dev_get_plat(dev);
+
+	if (enable)
+		val = plat->enablemask;
+
+	return pmic_clrsetbits(dev->parent, plat->enable_reg, plat->enablemask,
+			       val);
+}
+
+static int pf9453_get_value(struct udevice *dev)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	unsigned int reg, tmp;
+	int i, ret;
+
+	ret = pmic_reg_read(dev->parent, plat->volt_reg);
+	if (ret < 0)
+		return ret;
+
+	reg = ret;
+	reg &= plat->volt_mask;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf9453_vrange *r = &plat->ranges[i];
+
+		if (!vrange_find_value(r, reg, &tmp))
+			return tmp;
+	}
+
+	pr_err("Unknown voltage value read from pmic\n");
+
+	return -EINVAL;
+}
+
+static int pf9453_set_value(struct udevice *dev, int uvolt)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	unsigned int sel;
+	int i, found = 0;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf9453_vrange *r = &plat->ranges[i];
+
+		found = !vrange_find_selector(r, uvolt, &sel);
+		if (found) {
+			unsigned int tmp;
+
+			/*
+			 * We require exactly the requested value to be
+			 * supported - this can be changed later if needed
+			 */
+			found = !vrange_find_value(r, sel, &tmp);
+			if (found && tmp == uvolt)
+				break;
+			found = 0;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return pmic_clrsetbits(dev->parent, plat->volt_reg,
+			       plat->volt_mask, sel);
+}
+
+static int pf9453_regulator_probe(struct udevice *dev)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	int i, type;
+
+	type = dev_get_driver_data(dev_get_parent(dev));
+
+	if (type != NXP_CHIP_TYPE_PF9453) {
+		debug("Unknown PMIC type\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pf9453_reg_data); i++) {
+		if (strcmp(dev->name, pf9453_reg_data[i].name))
+			continue;
+		*plat = pf9453_reg_data[i];
+		return 0;
+	}
+
+	pr_err("Unknown regulator '%s'\n", dev->name);
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops pf9453_regulator_ops = {
+	.get_value	= pf9453_get_value,
+	.set_value	= pf9453_set_value,
+	.get_enable	= pf9453_get_enable,
+	.set_enable	= pf9453_set_enable,
+};
+
+U_BOOT_DRIVER(pf9453_regulator) = {
+	.name		= PF9453_REGULATOR_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &pf9453_regulator_ops,
+	.probe		= pf9453_regulator_probe,
+	.plat_auto	= sizeof(struct pf9453_plat),
+};
-- 
2.53.0

