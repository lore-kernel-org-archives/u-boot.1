Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3867BC531CF
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D422740956;
	Thu, 23 Jul 2026 13:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MkDuj0oSKpp; Thu, 23 Jul 2026 13:49:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC1E8409A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784814554;
	bh=zdQbgTCDNIoBV85419MoX/npw15n1Vnu3fMq03fei20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aCqJPPtFy5f3bnLoiF2GLSE/bOtgIVxDUdlBz3rw+TIuZhAhnIWpYu3odo3yDXYmo
	 LGWDpmoeQxVbguX8FN6UelMZKDuoRu5oZzexrpsmH7TRWLDBcy2mlggf8/moct45d8
	 L9/aZid1mHRNxWccqLHw9GePmXhJBkIOCUmoFwb/CqIbRjD8LQJKqbiwvVWABW+izb
	 nVNW4+/fjR2HsqxGfMFJiCORbh8SFEPsFx8+3Eu1RzHYItGuaqyycSZEJG4192Wz4c
	 0RD0tg7ijhBYDG8/i3OLCu5c2t3oF5XI3wySOIVdsDCCjDVFl5VilHzdBKgSOwXpMk
	 XPoj9++phL2qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC1E8409A8;
	Thu, 23 Jul 2026 13:49:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E7F390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7098608F1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUjkwysX7FHU for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:49:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.146;
 helo=mail-d17.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 86929608F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86929608F0
Received: from mail-d17.seohost-mail.eu (mail-d17.seohost-mail.eu
 [153.92.25.146])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86929608F0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:49:10 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=krzysztof-drobinski-HP-EliteBook-660-16-inch-G11-Notebook-PC.lan)
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wmtnQ-00000007jrj-28S5; Thu, 23 Jul 2026 15:49:08 +0200
From: =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Subject: [PATCH 1/2] power: pmic: ADD PMIC PF9453 support
Date: Thu, 23 Jul 2026 15:21:56 +0200
Message-ID: <20260723134051.452817-2-krzysztof@kd-solutions.pl>
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
 bh=zdQbgTCDNIoBV85419MoX/npw15n1Vnu3fMq03fei20=; b=a3JC7Yvpa6gYIqsibl6UF4iRUf
 ke5fXLKfRJeN7pUCgEwU3Q6T28W7JtOI+FCayqQ/lCUtSzvGsEVICCRC0sw567MI62B1TBU6EBBq1
 Q006modYLbXJFJYvq/sspRmv2Rv2HorbM+NuVlOD8rpDKqVtPL8p6LLV9VIYdDcMJi1ZQKNZgvLTC
 bt+5U9PhpZTaVnk5lvU4PCq2ts1GwylONVEpuFCkO0/YsA6P+cOwYJZ6M5h+QCAIjdhwyGTZrERzz
 uWmVUHHLPlA6ZGFhLkz1E8q3lw5L3OLAPimOL477AOaoSnE3/DaiKtY/UI6xyPcGqJ17lwB7AIqq9
 0YnLxSqw==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=a3JC7Yvp
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

Support NXP PMIC pf9453.

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Rebased [1] on main and checkpatch fixed. See also [2]
[1] https://patchwork.ozlabs.org/project/uboot/patch/20240930035531.27079-3-peng.fan@oss.nxp.com/
[2] https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625613.html
Signed-off-by: Krzysztof Drobiński <krzysztof@kd-solutions.pl>
---
 drivers/power/pmic/Kconfig  |  15 ++++
 drivers/power/pmic/Makefile |   1 +
 drivers/power/pmic/pf9453.c | 170 ++++++++++++++++++++++++++++++++++++
 include/power/pf9453.h      |  71 +++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 drivers/power/pmic/pf9453.c
 create mode 100644 include/power/pf9453.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index d45869cb30f..95687d0bdfd 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -171,6 +171,21 @@ config SPL_DM_PMIC_PCA9450
 	  This config enables implementation of driver-model pmic uclass features
 	  for PMIC PCA9450 in SPL. The driver implements read/write operations.
 
+config DM_PMIC_PF9453
+	bool "Enable Driver Model for PMIC PF9453"
+	depends on DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF9453. The driver implements read/write operations.
+
+config SPL_DM_PMIC_PF9453
+	bool "Enable Driver Model for PMIC PF9453 in SPL"
+	depends on SPL_DM_PMIC
+	depends on SPL_DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF9453 in SPL. The driver implements read/write operations.
+
 config DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100"
 	help
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 0ac92084221..da9b810de90 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_$(PHASE_)DM_PMIC_BD71837) += bd71837.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_MP5416) += mp5416.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_PCA9450) += pca9450.o
+obj-$(CONFIG_$(PHASE_)DM_PMIC_PF9453) += pf9453.o
 obj-$(CONFIG_PMIC_S2MPS11) += s2mps11.o
 obj-$(CONFIG_DM_PMIC_SANDBOX) += sandbox.o i2c_pmic_emul.o
 obj-$(CONFIG_PMIC_AB8500) += ab8500.o
diff --git a/drivers/power/pmic/pf9453.c b/drivers/power/pmic/pf9453.c
new file mode 100644
index 00000000000..71d766bce5b
--- /dev/null
+++ b/drivers/power/pmic/pf9453.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <asm/global_data.h>
+#include <asm-generic/gpio.h>
+#include <fdtdec.h>
+#include <errno.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <linux/err.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/pf9453.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const struct pmic_child_info pmic_children_info[] = {
+	/* buck */
+	{ .prefix = "b", .driver = PF9453_REGULATOR_DRIVER},
+	{ .prefix = "B", .driver = PF9453_REGULATOR_DRIVER},
+	/* ldo */
+	{ .prefix = "l", .driver = PF9453_REGULATOR_DRIVER},
+	{ .prefix = "L", .driver = PF9453_REGULATOR_DRIVER},
+	{ },
+};
+
+struct pf9453_priv {
+	struct gpio_desc *sd_vsel_gpio;
+};
+
+static int pf9453_reg_count(struct udevice *dev)
+{
+	return PF9453_REG_NUM;
+}
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_BUCK1OUT:
+	case PF9453_BUCK2OUT:
+	case PF9453_BUCK3OUT:
+	case PF9453_BUCK4OUT:
+	case PF9453_LDO1OUT_L:
+	case PF9453_LDO1OUT_H:
+	case PF9453_LDO2OUT:
+	case PF9453_LDOSNVS_CFG1:
+	case PF9453_BUCK2OUT_MAX_LIMIT:
+	case PF9453_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_write(struct udevice *dev, uint reg, const uint8_t *buff, int len)
+{
+	bool is_pro;
+	u32 val = PF9453_UNLOCK_KEY;
+
+	is_pro = is_reg_protect(reg);
+	if (is_pro) {
+		if (dm_i2c_write(dev, PF9453_REG_LOCK, (uint8_t *)&val, 1)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+
+		if (dm_i2c_write(dev, reg, buff, len)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+
+		val = PF9453_LOCK_KEY;
+		if (dm_i2c_write(dev, PF9453_REG_LOCK, (uint8_t *)&val, 1)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+	} else {
+		if (dm_i2c_write(dev, reg, buff, len)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int pf9453_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
+{
+	if (dm_i2c_read(dev, reg, buff, len)) {
+		pr_err("read error from device: %p register: %#x!\n", dev, reg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int pf9453_bind(struct udevice *dev)
+{
+	int children;
+	ofnode regulators_node;
+
+	regulators_node = dev_read_subnode(dev, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		debug("%s: %s regulators subnode not found!", __func__,
+		      dev->name);
+		return -ENXIO;
+	}
+
+	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
+
+	children = pmic_bind_children(dev, regulators_node,
+				      pmic_children_info);
+	if (!children)
+		debug("%s: %s - no child found\n", __func__, dev->name);
+
+	/* Always return success for this device */
+	return 0;
+}
+
+static int pf9453_probe(struct udevice *dev)
+{
+	struct pf9453_priv *priv = dev_get_priv(dev);
+	unsigned int reset_ctrl;
+	int ret = 0;
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(DM_REGULATOR_PF9453)) {
+		priv->sd_vsel_gpio = devm_gpiod_get_optional(dev, "sd-vsel",
+							     GPIOD_IS_OUT |
+							     GPIOD_IS_OUT_ACTIVE);
+		if (IS_ERR(priv->sd_vsel_gpio)) {
+			ret = PTR_ERR(priv->sd_vsel_gpio);
+			dev_err(dev, "Failed to request SD_VSEL GPIO: %d\n", ret);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
+		reset_ctrl = PF9453_PMIC_RESET_WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = PF9453_PMIC_RESET_WDOG_B_CFG_COLD;
+
+	return pmic_clrsetbits(dev, PF9453_RESET_CTRL,
+			       PF9453_PMIC_RESET_WDOG_B_CFG_MASK, reset_ctrl);
+}
+
+static struct dm_pmic_ops pf9453_ops = {
+	.reg_count = pf9453_reg_count,
+	.read = pf9453_read,
+	.write = pf9453_write,
+};
+
+static const struct udevice_id pf9453_ids[] = {
+	{ .compatible = "nxp,pf9453", .data = NXP_CHIP_TYPE_PF9453, },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_pf9453) = {
+	.name = "pf9453 pmic",
+	.id = UCLASS_PMIC,
+	.of_match = pf9453_ids,
+	.bind = pf9453_bind,
+	.probe = pf9453_probe,
+	.ops = &pf9453_ops,
+	.priv_auto = sizeof(struct pf9453_priv),
+};
diff --git a/include/power/pf9453.h b/include/power/pf9453.h
new file mode 100644
index 00000000000..f33b839cde0
--- /dev/null
+++ b/include/power/pf9453.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef PF9453_H_
+#define PF9453_H_
+
+#define PF9453_REGULATOR_DRIVER "pf9453_regulator"
+
+enum {
+	PF9453_REG_DEV_ID          = 0x00,
+	PF9453_OTP_VER             = 0x01,
+	PF9453_INT1                = 0x02,
+	PF9453_INT1_MSK            = 0x03,
+	PF9453_INT1_STATUS         = 0x04,
+	PF9453_VRFLT1_INT          = 0x05,
+	PF9453_VRFLT1_MASK         = 0x06,
+	PF9453_PWRON_STAT          = 0x07,
+	PF9453_RESET_CTRL          = 0x08,
+	PF9453_SW_RST              = 0x09,
+	PF9453_PWR_CTRL            = 0x0a,
+	PF9453_CONFIG1             = 0x0b,
+	PF9453_CONFIG2             = 0x0c,
+	PF9453_32K_CONFIG          = 0x0d,
+	PF9453_BUCK1CTRL           = 0x10,
+	PF9453_BUCK1OUT            = 0x11,
+	PF9453_BUCK2CTRL           = 0x14,
+	PF9453_BUCK2OUT            = 0x15,
+	PF9453_BUCK2OUT_STBY       = 0x1D,
+	PF9453_BUCK2OUT_MAX_LIMIT  = 0x1F,
+	PF9453_BUCK2OUT_MIN_LIMIT  = 0x20,
+	PF9453_BUCK3CTRL           = 0x21,
+	PF9453_BUCK3OUT            = 0x22,
+	PF9453_BUCK4CTRL           = 0x2e,
+	PF9453_BUCK4OUT            = 0x2f,
+	PF9453_LDO1OUT_L          = 0x36,
+	PF9453_LDO1CFG            = 0x37,
+	PF9453_LDO1OUT_H          = 0x38,
+	PF9453_LDOSNVS_CFG1        = 0x39,
+	PF9453_LDOSNVS_CFG2        = 0x3a,
+	PF9453_LDO2CFG            = 0x3b,
+	PF9453_LDO2OUT            = 0x3c,
+	PF9453_BUCK_POK            = 0x3d,
+	PF9453_LSW_CTRL1           = 0x40,
+	PF9453_LSW_CTRL2           = 0x41,
+	PF9453_REG_LOCK            = 0x4e,
+	PF9453_REG_NUM,
+};
+
+int power_pf9453_init(unsigned char bus, unsigned char addr);
+
+enum {
+	NXP_CHIP_TYPE_PF9453 = 0,
+	NXP_CHIP_TYPE_AMOUNT
+};
+
+#define PF9453_UNLOCK_KEY		0x5c
+#define PF9453_LOCK_KEY			0x0
+
+#define PF9453_EN_MODE_MASK		0x3
+#define PF9453_BUCK_RUN_MASK		0x7f
+#define PF9453_LDO1_MASK		0x7f
+#define PF9453_LDO2_MASK		0x3f
+#define PF9453_LDOSNVS_MASK		0x7f
+
+#define PF9453_PMIC_RESET_WDOG_B_CFG_MASK		0xc0
+#define PF9453_PMIC_RESET_WDOG_B_CFG_WARM		0x40
+#define PF9453_PMIC_RESET_WDOG_B_CFG_COLD		0x80
+
+#endif
-- 
2.53.0

