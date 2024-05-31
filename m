Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6F0C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 05:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACB88875A;
	Fri, 31 May 2024 07:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N5/f5y4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B1B88763; Fri, 31 May 2024 07:51:05 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57637882C4
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V5owMX106449;
 Fri, 31 May 2024 00:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717134658;
 bh=3g0ZEo0OnEWfGU6DJPZwKrHB71KSrldVbQS92EXPVYA=;
 h=From:To:CC:Subject:Date;
 b=N5/f5y4dxvnXo0hoBkSLsjBnEkZM6Y4BKe0TI2pHv0kWPNnzqnkY9ojEQBxXsh0eP
 x8XBx305Y4UnmgsKWMbeYa93/+VEd2WjFJlnBdS5JeXDPXg6+ViRhrWTyGFJH27zn8
 +ygRrxNsM1SKlGZpVgKqGCeolb3HYtt8pbVqWhKU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V5owAw035686
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 00:50:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 00:50:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 00:50:57 -0500
Received: from ubuntu.dhcp.ti.com (ltpw09g681.dhcp.ti.com [172.24.28.144])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V5os1W009636;
 Fri, 31 May 2024 00:50:55 -0500
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <sjg@chromium.org>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH] power: regulator: tps6287x: Add driver for TPS6287x step down
 convertors
Date: Fri, 31 May 2024 11:20:41 +0530
Message-ID: <20240531055041.32636-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add driver for TPS6287x step down convertors

Data sheet: https://www.ti.com/lit/ds/slvsgc5a/slvsgc5a.pdf

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/power/regulator/Kconfig              |  18 ++
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/tps6287x_regulator.c | 172 +++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 drivers/power/regulator/tps6287x_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 102ec7bc5f..db4b40c35e 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -375,6 +375,15 @@ config DM_REGULATOR_TPS80031
 	features for TPS80031/TPS80032 PMICs. The driver implements
 	get/set api for: value and enable.
 
+config DM_REGULATOR_TPS6287X
+	bool "Enable driver for TPS6287x Power Regulator"
+	depends on DM_REGULATOR
+	help
+	The TPS6287X is a step down converter with a fast transient
+	response. This driver supports all four variants of the chip
+	(TPS62870, TPS62871, TPS62872, TPS62873). It implements the
+	get/set api for value only, as the power line is always on.
+
 config DM_REGULATOR_STPMIC1
 	bool "Enable driver for STPMIC1 regulators"
 	depends on DM_REGULATOR && PMIC_STPMIC1
@@ -394,6 +403,15 @@ config DM_REGULATOR_ANATOP
 	regulators. It is recommended that this option be enabled on
 	i.MX6 platform.
 
+config SPL_DM_REGULATOR_TPS6287X
+	bool "Enable driver for TPS6287x Power Regulator"
+	depends on SPL_DM_REGULATOR
+	help
+	The TPS6287X is a step down converter with a fast transient
+	response. This driver supports all four variants of the chip
+	(TPS62870, TPS62871, TPS62872, TPS62873). It implements the
+	get/set api for value only, as the power line is always on.
+
 config SPL_DM_REGULATOR_STPMIC1
 	bool "Enable driver for STPMIC1 regulators in SPL"
 	depends on SPL_DM_REGULATOR && PMIC_STPMIC1
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index f79932d833..6335e5566d 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_$(SPL_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_DM_REGULATOR_TPS65910) += tps65910_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS65911) += tps65911_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS62360) += tps62360_regulator.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS6287X) += tps6287x_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
 obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
diff --git a/drivers/power/regulator/tps6287x_regulator.c b/drivers/power/regulator/tps6287x_regulator.c
new file mode 100644
index 0000000000..6d18571919
--- /dev/null
+++ b/drivers/power/regulator/tps6287x_regulator.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
+ * Keerthy <j-keerthy@ti.com>
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <dm/device_compat.h>
+#include <power/regulator.h>
+
+#define TPS6287X_REG_VSET			0x0
+#define TPS6287X_REG_CONTROL1			0x1
+#define TPS6287X_REG_CONTROL2			0x2
+#define TPS6287X_REG_CONTROL3			0x3
+#define TPS6287X_REG_STATUS			0x4
+#define TPS6287X_REG_VSET_VSET_MASK		0xff
+#define TPS6287X_REG_CONTROL2_VRANGE_MASK	0xc
+
+struct tps6287x_regulator_config {
+	u32 vmin;
+	u32 vmax;
+};
+
+struct tps6287x_regulator_pdata {
+	u8 vsel_offset;
+	struct udevice *i2c;
+	struct tps6287x_regulator_config *config;
+};
+
+static struct tps6287x_regulator_config tps6287x_data = {
+	.vmin = 400000,
+	.vmax = 3350000,
+};
+
+static int tps6287x_regulator_set_value(struct udevice *dev, int uV)
+{
+	struct tps6287x_regulator_pdata *pdata = dev_get_plat(dev);
+	u8 regval, vset;
+	int ret;
+
+	if (uV < pdata->config->vmin || uV > pdata->config->vmax)
+		return -EINVAL;
+	/*
+	 * Based on the value of VRANGE bit field of CONTROL2 reg the range
+	 * varies.
+	 */
+	ret = dm_i2c_read(pdata->i2c, TPS6287X_REG_CONTROL2, &regval, 1);
+	if (ret) {
+		dev_err(dev, "CTRL2 reg read failed: %d\n", ret);
+		return ret;
+	}
+
+	regval &= TPS6287X_REG_CONTROL2_VRANGE_MASK;
+	regval >>= ffs(TPS6287X_REG_CONTROL2_VRANGE_MASK) - 1;
+
+	/*
+	 * VRANGE = 0. Increment step 1250 uV starting with 0 --> 400000 uV
+	 * VRANGE = 1. Increment step 2500 uV starting with 0 --> 400000 uV
+	 * VRANGE = 2. Increment step 5000 uV starting with 0 --> 400000 uV
+	 * VRANGE = 3. Increment step 10000 uV starting with 0 --> 800000 uV
+	 */
+	switch (regval) {
+	case 0:
+		vset = (uV - 400000) / 1250;
+		break;
+	case 1:
+		vset = (uV - 400000) / 2500;
+		break;
+	case 2:
+		vset = (uV - 400000) / 5000;
+		break;
+	case 3:
+		vset = (uV - 800000) / 10000;
+		break;
+	default:
+		pr_err("%s: invalid regval %d\n", dev->name, regval);
+		return -EINVAL;
+	}
+
+	return dm_i2c_write(pdata->i2c, TPS6287X_REG_VSET, &vset, 1);
+}
+
+static int tps6287x_regulator_get_value(struct udevice *dev)
+{
+	u8 regval, vset;
+	int uV;
+	int ret;
+	struct tps6287x_regulator_pdata *pdata = dev_get_plat(dev);
+
+	/*
+	 * Based on the value of VRANGE bit field of CONTROL2 reg the range
+	 * varies.
+	 */
+	ret = dm_i2c_read(pdata->i2c, TPS6287X_REG_CONTROL2, &regval, 1);
+	if (ret) {
+		dev_err(dev, "i2c read failed: %d\n", ret);
+		return ret;
+	}
+
+	regval &= TPS6287X_REG_CONTROL2_VRANGE_MASK;
+	regval >>= ffs(TPS6287X_REG_CONTROL2_VRANGE_MASK) - 1;
+
+	ret = dm_i2c_read(pdata->i2c, TPS6287X_REG_VSET, &vset, 1);
+	if (ret) {
+		dev_err(dev, "i2c VSET read failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * VRANGE = 0. Increment step 1250 uV starting with 0 --> 400000 uV
+	 * VRANGE = 1. Increment step 2500 uV starting with 0 --> 400000 uV
+	 * VRANGE = 2. Increment step 5000 uV starting with 0 --> 400000 uV
+	 * VRANGE = 3. Increment step 10000 uV starting with 0 --> 800000 uV
+	 */
+	switch (regval) {
+	case 0:
+		uV = 400000 + vset * 1250;
+		break;
+	case 1:
+		uV = 400000 + vset * 2500;
+		break;
+	case 2:
+		uV = 400000 + vset * 5000;
+		break;
+	case 3:
+		uV = 800000 + vset * 10000;
+		break;
+	default:
+		pr_err("%s: invalid regval %d\n", dev->name, regval);
+		return -EINVAL;
+	}
+
+	return uV;
+}
+
+static int tps6287x_regulator_probe(struct udevice *dev)
+{
+	struct tps6287x_regulator_pdata *pdata = dev_get_plat(dev);
+	int ret, slave_id;
+
+	pdata->config = (void *)dev_get_driver_data(dev);
+
+	slave_id = devfdt_get_addr_index(dev, 0);
+
+	ret = i2c_get_chip(dev->parent, slave_id, 1, &pdata->i2c);
+	if (ret) {
+		dev_err(dev, "i2c dev get failed.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dm_regulator_ops tps6287x_regulator_ops = {
+	.get_value  = tps6287x_regulator_get_value,
+	.set_value  = tps6287x_regulator_set_value,
+};
+
+static const struct udevice_id tps6287x_regulator_ids[] = {
+	{ .compatible = "ti,tps62873", .data = (ulong)&tps6287x_data },
+	{ },
+};
+
+U_BOOT_DRIVER(tps6287x_regulator) = {
+	.name = "tps6287x_regulator",
+	.id = UCLASS_REGULATOR,
+	.ops = &tps6287x_regulator_ops,
+	.of_match = tps6287x_regulator_ids,
+	.plat_auto	= sizeof(struct tps6287x_regulator_pdata),
+	.probe = tps6287x_regulator_probe,
+};
-- 
2.17.1

