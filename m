Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90C9C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F94F87AEC;
	Wed, 25 Oct 2023 16:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B758B86D05; Wed, 25 Oct 2023 15:40:24 +0200 (CEST)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D33F87AC8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: ekiU7g/Lam3G8LqnD1Txgi0vWvrpU6Ls+qaw4ljlQ59Qsgnrdm/j9b+wNSvjWk0W2yW6aTcEDr
 2gFoa966obTw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 25 Oct 2023 19:10:14 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: jh80.chung@samsung.com,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 2/2] driver: power: regulator: add support for TPS65224
 regulator
Date: Wed, 25 Oct 2023 19:10:01 +0530
Message-Id: <20231025134001.120916-3-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025134001.120916-1-bhargav.r@ltts.com>
References: <20231025134001.120916-1-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Oct 2023 16:20:24 +0200
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

Added support for PMIC TPS65224 regulators. Includes driver for
buck and ldo.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/power/regulator/Kconfig              |  10 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/tps65224_regulator.c | 472 +++++++++++++++++++
 include/power/tps65224.h                     |   6 +-
 4 files changed, 487 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/regulator/tps65224_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index eb5aa38c1c..cb86025a22 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -408,6 +408,16 @@ config DM_REGULATOR_TPS65941
 	be configured in multi phase modes & 4 LDOs. The driver implements
 	get/set api for value and enable.
 
+config DM_REGULATOR_TPS65224
+	bool "Enable driver for TPS65224 PMIC regulators"
+        depends on PMIC_TPS65224
+	help
+	This enables implementation of driver-model regulator uclass
+	features for REGULATOR TPS65224 and the family of TPS65224 PMICs.
+	TPS65224 series of PMICs have 4 single phase BUCKs that can also
+	be configured in multi phase modes & 3 LDOs. The driver implements
+	get/set api for value and enable.
+
 config DM_REGULATOR_SCMI
 	bool "Enable driver for SCMI voltage domain regulators"
 	depends on DM_REGULATOR
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index d9e0cd5949..d4b9b7233f 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_DM_REGULATOR_TPS65910) += tps65910_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS62360) += tps62360_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
 obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
+obj-$(CONFIG_DM_REGULATOR_TPS65224) += tps65224_regulator.o
 obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
diff --git a/drivers/power/regulator/tps65224_regulator.c b/drivers/power/regulator/tps65224_regulator.c
new file mode 100644
index 0000000000..2f8c803778
--- /dev/null
+++ b/drivers/power/regulator/tps65224_regulator.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023
+ * Texas Instruments Incorporated, <www.ti.com>
+ *
+ */
+#include <fdtdec.h>
+#include <errno.h>
+#include <dm.h>
+#include <log.h>
+#include <linux/delay.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/tps65224.h>
+
+static const char tps65224_buck_ctrl[TPS65224_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA};
+static const char tps65224_buck_vout[TPS65224_BUCK_NUM] = {0xE, 0x10, 0x12,
+								0x14};
+static const char tps65224_ldo_ctrl[TPS65224_BUCK_NUM] = {0x1D, 0x1E, 0x1F};
+static const char tps65224_ldo_vout[TPS65224_BUCK_NUM] = {0x23, 0x24, 0x25};
+
+static int tps65224_buck_enable(struct udevice *dev, int op, bool *enable)
+{
+	int ret;
+	unsigned int adr;
+	struct dm_regulator_uclass_plat *uc_pdata;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+	adr = uc_pdata->ctrl_reg;
+
+	ret = pmic_reg_read(dev->parent, adr);
+	if (ret < 0)
+		return ret;
+
+	if (op == PMIC_OP_GET) {
+		ret &= TPS65224_BUCK_MODE_MASK;
+
+		if (ret)
+			*enable = true;
+		else
+			*enable = false;
+
+		return 0;
+	} else if (op == PMIC_OP_SET) {
+		if (*enable)
+			ret |= TPS65224_BUCK_MODE_MASK;
+		else
+			ret &= ~TPS65224_BUCK_MODE_MASK;
+		ret = pmic_reg_write(dev->parent, adr, ret);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tps65224_buck_volt2val(int idx, int uV)
+{
+	if (uV > TPS65224_BUCK_VOLT_MAX)
+		return -EINVAL;
+
+	if (idx > 0) {
+		if (uV >= 1200000)
+			return (uV - 1200000) / 50000 + 0x1B;
+		else if (uV >= 500000)
+			return (uV - 500000) / 25000;
+		else
+			return -EINVAL;
+	}
+
+	if (uV >= 1660000)
+		return (uV - 1660000) / 20000 + 0xAB;
+	else if (uV >= 1100000)
+		return (uV - 1100000) / 10000 + 0x73;
+	else if (uV >= 600000)
+		return (uV - 600000) / 5000 + 0x0F;
+	else if (uV >= 500000)
+		return (uV - 500000) / 20000 + 0x0A;
+	else
+		return -EINVAL;
+}
+
+static int tps65224_buck_val2volt(int idx, int val)
+{
+	if (idx > 0) {
+		if (val > TPS65224_BUCK234_VOLT_MAX_HEX)
+			return -EINVAL;
+		else if (val >= 0x1B)
+			return 1200000 + (val - 0x1B) * 50000;
+		else if (val >= 0x00)
+			return 500000 + (val - 0x00) * 25000;
+		else
+			return -EINVAL;
+	}
+
+	if (val > TPS65224_BUCK1_VOLT_MAX_HEX)
+		return -EINVAL;
+	else if (val >= 0xAB)
+		return 1660000 + (val - 0xAB) * 20000;
+	else if (val >= 0x73)
+		return 1100000 + (val - 0x73) * 10000;
+	else if (val >= 0xF)
+		return 600000 + (val - 0xF) * 5000;
+	else if (val >= 0xA)
+		return 500000 + (val - 0xA) * 20000;
+	else
+		return -EINVAL;
+}
+
+int tps65224_lookup_slew(int id)
+{
+	switch (id) {
+	case 0:
+		return 10000;
+	case 1:
+		return 5000;
+	case 2:
+		return 2500;
+	case 3:
+		return 1250;
+	default:
+		return -1;
+	}
+}
+
+static int tps65224_buck_val(struct udevice *dev, int op, int *uV)
+{
+	unsigned int hex, adr;
+	int ret, idx, delta, uwait, slew;
+	struct dm_regulator_uclass_plat *uc_pdata;
+
+	idx = dev->driver_data;
+	idx = (idx == 12) ? 0 : (idx - 1);
+
+	uc_pdata = dev_get_uclass_plat(dev);
+
+	if (op == PMIC_OP_GET)
+		*uV = 0;
+
+	adr = uc_pdata->volt_reg;
+
+	ret = pmic_reg_read(dev->parent, adr);
+	if (ret < 0)
+		return ret;
+
+	ret &= TPS65224_BUCK_VOLT_MASK;
+	ret = tps65224_buck_val2volt(idx, ret);
+	if (ret < 0)
+		return ret;
+
+	if (op == PMIC_OP_GET) {
+		*uV = ret;
+		return 0;
+	}
+
+	/*
+	 * Compute the delta voltage, find the slew rate and wait
+	 * for the appropriate amount of time after voltage switch
+	 */
+	if (*uV > ret)
+		delta = *uV - ret;
+	else
+		delta = ret - *uV;
+
+	slew = pmic_reg_read(dev->parent, uc_pdata->ctrl_reg + 1);
+	if (slew < 0)
+		return ret;
+
+	slew &= TP65224_BUCK_CONF_SLEW_MASK;
+	slew = tps65224_lookup_slew(slew);
+	if (slew <= 0)
+		return ret;
+
+	uwait = delta / slew;
+
+	hex = tps65224_buck_volt2val(idx, *uV);
+	if (hex < 0)
+		return hex;
+
+	ret &= 0x0;
+	ret = hex;
+
+	ret = pmic_reg_write(dev->parent, adr, ret);
+
+	udelay(uwait);
+
+	return ret;
+}
+
+static int tps65224_ldo_enable(struct udevice *dev, int op, bool *enable)
+{
+	int ret;
+	unsigned int adr;
+	struct dm_regulator_uclass_plat *uc_pdata;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+	adr = uc_pdata->ctrl_reg;
+
+	ret = pmic_reg_read(dev->parent, adr);
+	if (ret < 0)
+		return ret;
+
+	if (op == PMIC_OP_GET) {
+		ret &= TPS65224_LDO_MODE_MASK;
+
+		if (ret)
+			*enable = true;
+		else
+			*enable = false;
+
+		return 0;
+	} else if (op == PMIC_OP_SET) {
+		if (*enable)
+			ret |= TPS65224_LDO_MODE_MASK;
+		else
+			ret &= ~TPS65224_LDO_MODE_MASK;
+		ret = pmic_reg_write(dev->parent, adr, ret);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tps65224_ldo_volt2val(int idx, int uV)
+{
+	int base = TPS65224_LDO1_VOLT_MIN;
+	int max = TPS65224_LDO1_VOLT_MAX;
+	int offset = TPS65224_LDO1_VSET_MIN;
+	int step = TPS65224_LDO123_STEP;
+
+	if (idx > 0) {
+		base = TPS65224_LDO23_VOLT_MIN;
+		max = TPS65224_LDO23_VOLT_MAX;
+		offset = TPS65224_LDO23_VSET_MIN;
+		step = TPS65224_LDO123_STEP;
+	}
+
+	if (uV > max)
+		return -EINVAL;
+	else if (uV >= base)
+		return (uV - base) / step + offset;
+	else
+		return -EINVAL;
+}
+
+static int tps65224_ldo_val2volt(int idx, int val)
+{
+	int reg_base = TPS65224_LDO1_VSET_MIN;
+	int reg_max = TPS65224_LDO1_VSET_MAX;
+	int base = TPS65224_LDO1_VOLT_MIN;
+	int max = TPS65224_LDO1_VOLT_MAX;
+	int step = TPS65224_LDO123_STEP;
+	int mask = TPS65224_LDO_VOLT_MASK >> 1;
+
+	if (idx > 0) {
+		base = TPS65224_LDO23_VOLT_MIN;
+		max = TPS65224_LDO23_VOLT_MAX;
+		reg_base = TPS65224_LDO123_VSET_MIN;
+		reg_max = TPS65224_LDO23_VSET_MAX;
+		step = TPS65224_LDO123_STEP;
+	}
+
+	val = val >> 1;
+	if (val > mask || val < 0)
+		return -EINVAL;
+	else if (val >= reg_max)
+		return max;
+	else if (val <= reg_base)
+		return base;
+	else if (val >= 0)
+		return base + (step * (val - reg_base));
+	else
+		return -EINVAL;
+}
+
+static int tps65224_ldo_val(struct udevice *dev, int op, int *uV)
+{
+	unsigned int hex, adr;
+	int ret, ret_volt;
+	struct dm_regulator_uclass_plat *uc_pdata;
+	int idx;
+
+	idx = dev->driver_data - 1;
+	uc_pdata = dev_get_uclass_plat(dev);
+
+	if (op == PMIC_OP_GET)
+		*uV = 0;
+
+	adr = uc_pdata->volt_reg;
+
+	ret = pmic_reg_read(dev->parent, adr);
+	if (ret < 0)
+		return ret;
+
+	ret &= TPS65224_LDO_VOLT_MASK;
+
+	ret_volt = tps65224_ldo_val2volt(idx, ret);
+
+	if (ret_volt < 0)
+		return ret_volt;
+
+	if (op == PMIC_OP_GET) {
+		*uV = ret_volt;
+		return 0;
+	}
+
+	/* LDO1 in BYPASS mode only supports 2.2V min to 3.6V max */
+	if (idx == 0 && (ret & BIT(TPS65224_LDO123_BYP_CONFIG)) &&
+	    *uV < TPS65224_LDO1_VOLT_BYP_MIN)
+		return -EINVAL;
+
+	/* LDO2 & LDO3 in BYPASS mode supports 1.5V min to 5.5V max */
+	if (idx > 0 && (ret & BIT(TPS65224_LDO123_BYP_CONFIG)) &&
+	    *uV < TPS65224_LDO23_VOLT_BYP_MIN)
+		return -EINVAL;
+
+	hex = tps65224_ldo_volt2val(idx, *uV);
+	if (hex < 0)
+		return hex;
+
+	hex = hex << TPS65224_LDO_MODE_MASK;
+
+	ret &= ~TPS65224_LDO_VOLT_MASK;
+	ret |= hex;
+
+	ret = pmic_reg_write(dev->parent, adr, ret);
+
+	return ret;
+}
+
+static int tps65224_ldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata;
+	int idx;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+
+	idx = dev->driver_data;
+	if (idx == 1 || idx == 2 || idx == 3) {
+		debug("Single phase regulator\n");
+	} else {
+		printf("Wrong ID for regulator\n");
+		return -EINVAL;
+	}
+
+	uc_pdata->ctrl_reg = tps65224_ldo_ctrl[idx - 1];
+	uc_pdata->volt_reg = tps65224_ldo_vout[idx - 1];
+
+	return 0;
+}
+
+static int tps65224_buck_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata;
+	int idx;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+	uc_pdata->type = REGULATOR_TYPE_BUCK;
+
+	idx = dev->driver_data;
+	if (idx == 1 || idx == 2 || idx == 3 || idx == 4) {
+		debug("Single phase regulator\n");
+	} else if (idx == 12) {
+		idx = 1;
+	} else {
+		printf("Wrong ID for regulator\n");
+		return -EINVAL;
+	}
+
+	uc_pdata->ctrl_reg = tps65224_buck_ctrl[idx - 1];
+	uc_pdata->volt_reg = tps65224_buck_vout[idx - 1];
+
+	return 0;
+}
+
+static int ldo_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = tps65224_ldo_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int ldo_set_value(struct udevice *dev, int uV)
+{
+	return tps65224_ldo_val(dev, PMIC_OP_SET, &uV);
+}
+
+static int ldo_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = tps65224_ldo_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int ldo_set_enable(struct udevice *dev, bool enable)
+{
+	return tps65224_ldo_enable(dev, PMIC_OP_SET, &enable);
+}
+
+static int buck_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = tps65224_buck_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int buck_set_value(struct udevice *dev, int uV)
+{
+	return tps65224_buck_val(dev, PMIC_OP_SET, &uV);
+}
+
+static int buck_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = tps65224_buck_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int buck_set_enable(struct udevice *dev, bool enable)
+{
+	return tps65224_buck_enable(dev, PMIC_OP_SET, &enable);
+}
+
+static const struct dm_regulator_ops tps65224_ldo_ops = {
+	.get_value  = ldo_get_value,
+	.set_value  = ldo_set_value,
+	.get_enable = ldo_get_enable,
+	.set_enable = ldo_set_enable,
+};
+
+U_BOOT_DRIVER(tps65224_ldo) = {
+	.name = TPS65224_LDO_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &tps65224_ldo_ops,
+	.probe = tps65224_ldo_probe,
+};
+
+static const struct dm_regulator_ops tps65224_buck_ops = {
+	.get_value  = buck_get_value,
+	.set_value  = buck_set_value,
+	.get_enable = buck_get_enable,
+	.set_enable = buck_set_enable,
+};
+
+U_BOOT_DRIVER(tps65224_buck) = {
+	.name = TPS65224_BUCK_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &tps65224_buck_ops,
+	.probe = tps65224_buck_probe,
+};
diff --git a/include/power/tps65224.h b/include/power/tps65224.h
index 7b52796a64..8236b72bd5 100644
--- a/include/power/tps65224.h
+++ b/include/power/tps65224.h
@@ -33,8 +33,10 @@
 /* BYPASS is bit7 of VOUT TPS65224_LDO_BYP_MASK */
 #define TPS65224_LDO123_BYP_CONFIG        7
 
-#define TPS65224_LDO123_VOLT_BYP_MIN      2200000
-#define TPS65224_LDO123_VOLT_BYP_MAX      3600000
+#define TPS65224_LDO1_VOLT_BYP_MIN        2200000
+#define TPS65224_LDO1_VOLT_BYP_MAX        3600000
+#define TPS65224_LDO23_VOLT_BYP_MIN       1500000
+#define TPS65224_LDO23_VOLT_BYP_MAX       5500000
 #define TPS65224_LDO1_VOLT_MIN            1200000
 #define TPS65224_LDO23_VOLT_MIN           600000
 #define TPS65224_LDO4_VOLT_MIN            1200000
-- 
2.25.1

