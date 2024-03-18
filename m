Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D031DC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F378387F64;
	Mon, 18 Mar 2024 10:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1D387DDF; Mon, 18 Mar 2024 10:30:23 +0100 (CET)
Received: from esa2.ltts.com (unknown [14.140.155.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FCD87DFA
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: hllnxlF1IvzGvSKqoIL5JKQ27NA+rj+Rkhfr5XYzMf2n0LcMUiabfSzSwuaqftgRnVe55rpxu9
 VKLDaDw6T9nQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa2.ltts.com with ESMTP; 18 Mar 2024 15:00:15 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com,
 m.nirmaladevi@ltts.com, sjg@chromium.org, trini@konsulko.com,
 Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v3 5/5] power: regulator: tps65941: Add TPS65224 PMIC
 regulator support
Date: Mon, 18 Mar 2024 14:59:59 +0530
Message-Id: <20240318092959.373356-6-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240318092959.373356-1-bhargav.r@ltts.com>
References: <20240318092959.373356-1-bhargav.r@ltts.com>
MIME-Version: 1.0
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

Reuse TPS65941 regulator driver to adds support for
TPS65224 PMIC's regulators. 4 BUCKs and 3 LDOs, where
BUCK1 and BUCK2 can be configured in dual phase mode.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/power/regulator/tps65941_regulator.c | 280 ++++++++++++++++++-
 1 file changed, 267 insertions(+), 13 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index d879c2301b..826bc0c63e 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -37,6 +37,8 @@
 
 #define TPS65941_BUCK_CONV_OPS_IDX  0
 #define TPS65941_LDO_CONV_OPS_IDX   0
+#define TPS65224_LDO_CONV_OPS_IDX   1
+#define TPS65224_BUCK_CONV_OPS_IDX  1
 
 struct tps65941_reg_conv_ops {
 	int volt_mask;
@@ -55,6 +57,11 @@ static const char tps65941_ldo_ctrl[TPS65941_BUCK_NUM] = {0x1D, 0x1E, 0x1F,
 static const char tps65941_ldo_vout[TPS65941_BUCK_NUM] = {0x23, 0x24, 0x25,
 								0x26};
 
+static inline int tps65941_get_chip_id(struct udevice *dev)
+{
+	return dev->parent->driver_data;
+}
+
 static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
 {
 	int ret;
@@ -146,6 +153,112 @@ int tps65941_lookup_slew(int id)
 	}
 }
 
+static int tps65224_buck_volt2val(int idx, int uV)
+{
+	/* This functions maps a value which is in micro Volts to the VSET value.
+	 * The mapping is as per the datasheet of TPS65224.
+	 */
+
+	if (uV > TPS65224_BUCK_VOLT_MAX)
+		return -EINVAL;
+
+	if (idx > 0) {
+		/* Buck2, Buck3 and Buck4 of TPS65224 has a different schema in
+		 * converting b/w micro_volt and VSET hex values
+		 *
+		 * VSET value starts from 0x00 for 0.5V, and for every increment
+		 * in VSET value the output voltage increases by 25mV. This is upto
+		 * 1.15V where VSET is 0x1A.
+		 *
+		 * For 0x1B the output voltage is 1.2V, and for every increment of
+		 * VSET the output voltage increases by 50mV upto the max voltage of
+		 * 3.3V
+		 *
+		 * | Voltage Ranges  | VSET Ranges  | Voltage Step |
+		 * +-----------------+--------------+--------------+
+		 * | 0.5V to 1.50V   | 0x00 to 0x1A |  25mV        |
+		 * | 1.2V to 3.3V    | 0x1B to 0x45 |  50mV        |
+		 */
+		if (uV >= 1200000)
+			return (uV - 1200000) / 50000 + 0x1B;
+		else if (uV >= 500000)
+			return (uV - 500000) / 25000;
+		else
+			return -EINVAL;
+	}
+
+	/* Buck1 and Buck12(dual phase) has a different mapping b/w output
+	 * voltage and VSET value.
+	 *
+	 * | Voltage Ranges  | VSET Ranges  | Voltage Step |
+	 * +-----------------+--------------+--------------+
+	 * | 0.5V to 0.58V   | 0xA to 0xE   |  20mV        |
+	 * | 0.6V to 1.095V  | 0xF to 0x72  |  5mV         |
+	 * | 1.1V to 1.65V   | 0x73 to 0xAA |  10mV        |
+	 * | 1.6V to 3.3V    | 0xAB to 0xFD |  20mV        |
+	 *
+	 */
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
+	/* This function does the opposite to the tps65224_buck_volt2val function
+	 * described above.
+	 * This maps the VSET value to micro volts. Please refer to the ranges
+	 * mentioned the comments of tps65224_buck_volt2val.
+	 */
+
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
 static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
 	[TPS65941_BUCK_CONV_OPS_IDX] = {
 		.volt_mask = TPS65941_BUCK_VOLT_MASK,
@@ -154,6 +267,13 @@ static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
 		.slew_mask = TP65941_BUCK_CONF_SLEW_MASK,
 		.lookup_slew = tps65941_lookup_slew,
 	},
+	[TPS65224_BUCK_CONV_OPS_IDX] = {
+		.volt_mask = TPS65941_BUCK_VOLT_MASK,
+		.volt2val = tps65224_buck_volt2val,
+		.val2volt = tps65224_buck_val2volt,
+		.slew_mask = TPS65224_BUCK_CONF_SLEW_MASK,
+		.lookup_slew = tps65224_lookup_slew,
+	},
 };
 
 static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
@@ -162,9 +282,23 @@ static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
 	int ret, delta, uwait, slew, idx;
 	struct dm_regulator_uclass_plat *uc_pdata;
 	const struct tps65941_reg_conv_ops *conv_ops;
+	ulong chip_id;
 
 	idx = dev->driver_data;
-	conv_ops = &buck_conv_ops[TPS65941_BUCK_CONV_OPS_IDX];
+	chip_id = tps65941_get_chip_id(dev);
+	if (chip_id == TPS65224) {
+		/* idx is the buck id number as per devicetree node which will be same
+		 * as the regulator name in the datasheet.
+		 * The idx for buck1. buck2, buck3, buck4, buck12 will be 1, 2, 3, 4
+		 * and 12 respectively.
+		 * In the driver the numbering is from 0. Hence the -1.
+		 */
+		idx = (idx == TPS65941_BUCK_ID_12) ? 0 : (idx - 1);
+		conv_ops = &buck_conv_ops[TPS65224_BUCK_CONV_OPS_IDX];
+	} else {
+		conv_ops = &buck_conv_ops[TPS65941_BUCK_CONV_OPS_IDX];
+	}
+
 	uc_pdata = dev_get_uclass_plat(dev);
 
 	if (op == PMIC_OP_GET)
@@ -265,23 +399,96 @@ static int tps65941_ldo_val2volt(__maybe_unused int idx, int val)
 		return -EINVAL;
 }
 
+static int tps65224_ldo_volt2val(int idx, int uV)
+{
+	int base = TPS65224_LDO1_VOLT_MIN;
+	int max = TPS65224_LDO1_VOLT_MAX;
+	int offset = TPS65224_LDO1_VOLT_MIN_HEX;
+	int step = TPS65224_LDO_STEP;
+
+	if (idx > 0) {
+		base = TPS65224_LDO23_VOLT_MIN;
+		max = TPS65224_LDO23_VOLT_MAX;
+		offset = TPS65224_LDO23_VOLT_MIN_HEX;
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
+	int reg_base = TPS65224_LDO1_VOLT_MIN_HEX;
+	int reg_max = TPS65224_LDO1_VOLT_MAX_HEX;
+	int base = TPS65224_LDO1_VOLT_MIN;
+	int max = TPS65224_LDO1_VOLT_MAX;
+	int step = TPS65224_LDO_STEP;
+	/* In LDOx_VOUT reg the BIT0 is reserved and the
+	 * vout value is stored from BIT1 to BIT7.
+	 * Hence the below bit shit is done.
+	 */
+	int mask = TPS65224_LDO_VOLT_MASK >> 1;
+
+	if (idx > 0) {
+		base = TPS65224_LDO23_VOLT_MIN;
+		max = TPS65224_LDO23_VOLT_MAX;
+		reg_base = TPS65224_LDO23_VOLT_MIN_HEX;
+		reg_max = TPS65224_LDO23_VOLT_MAX_HEX;
+	}
+
+	val = val >> 1;
+
+	if (val < 0 || val > mask)
+		return -EINVAL;
+
+	if (val <= reg_base)
+		return base;
+
+	if (val >= reg_max)
+		return max;
+
+	return base + (step * (val - reg_base));
+}
+
 static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
 	[TPS65941_LDO_CONV_OPS_IDX] = {
 		.volt_mask = TPS65941_LDO_VOLT_MASK,
 		.volt2val = tps65941_buck_volt2val,
 		.val2volt = tps65941_ldo_val2volt,
 	},
+	[TPS65224_LDO_CONV_OPS_IDX] = {
+		.volt_mask = TPS65224_LDO_VOLT_MASK,
+		.volt2val = tps65224_ldo_volt2val,
+		.val2volt = tps65224_ldo_val2volt,
+	},
 };
 
 static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 {
 	unsigned int hex, adr;
-	int ret, idx;
+	int ret, ret_volt, idx;
 	struct dm_regulator_uclass_plat *uc_pdata;
 	const struct tps65941_reg_conv_ops *conv_ops;
+	ulong chip_id;
 
+	chip_id = tps65941_get_chip_id(dev);
 	idx = dev->driver_data;
-	conv_ops = &ldo_conv_ops[TPS65941_LDO_CONV_OPS_IDX];
+	if (chip_id == TPS65224) {
+		/* idx is the ldo id number as per devicetree node which will be same
+		 * as the regulator name in the datasheet.
+		 * The idx for ldo1, ldo2, ldo3 will be 1, 2 & 3 respectively.
+		 * In the driver the numbering is from 0. Hence the -1.
+		 */
+		idx = idx - 1;
+		conv_ops = &ldo_conv_ops[TPS65224_LDO_CONV_OPS_IDX];
+	} else {
+		conv_ops = &ldo_conv_ops[TPS65941_LDO_CONV_OPS_IDX];
+	}
+
 	uc_pdata = dev_get_uclass_plat(dev);
 
 	if (op == PMIC_OP_GET)
@@ -294,21 +501,36 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 		return ret;
 
 	ret &= conv_ops->volt_mask;
-	ret = conv_ops->val2volt(idx, ret);
-	if (ret < 0)
-		return ret;
+	ret_volt = conv_ops->val2volt(idx, ret);
+	if (ret_volt < 0)
+		return ret_volt;
 
 	if (op == PMIC_OP_GET) {
-		*uV = ret;
+		*uV = ret_volt;
 		return 0;
 	}
 
+	/* TPS65224 LDO1 in BYPASS mode only supports 2.2V min to 3.6V max */
+	if (chip_id == TPS65224 && idx == 0 && (ret & BIT(TPS65224_LDO_BYP_CONFIG)) &&
+	    *uV < TPS65224_LDO1_VOLT_BYP_MIN)
+		return -EINVAL;
+
+	/* TPS65224 LDO2 & LDO3 in BYPASS mode supports 1.5V min to 5.5V max */
+	if (chip_id == TPS65224 && idx > 0 && (ret & BIT(TPS65224_LDO_BYP_CONFIG)) &&
+	    *uV < TPS65224_LDO23_VOLT_BYP_MIN)
+		return -EINVAL;
+
 	hex = conv_ops->volt2val(idx, *uV);
 	if (hex < 0)
 		return hex;
 
-	ret &= 0x0;
-	ret = hex;
+	if (chip_id == TPS65224) {
+		hex = hex << TPS65941_LDO_MODE_MASK;
+		ret &= ~TPS65224_LDO_VOLT_MASK;
+		ret |= hex;
+	} else {
+		ret = hex;
+	}
 
 	ret = pmic_reg_write(dev->parent, adr, ret);
 
@@ -319,6 +541,9 @@ static int tps65941_ldo_probe(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
 	int idx;
+	ulong chip_id;
+
+	chip_id = tps65941_get_chip_id(dev);
 
 	uc_pdata = dev_get_uclass_plat(dev);
 	uc_pdata->type = REGULATOR_TYPE_LDO;
@@ -328,9 +553,16 @@ static int tps65941_ldo_probe(struct udevice *dev)
 	case TPS65941_LDO_ID_1:
 	case TPS65941_LDO_ID_2:
 	case TPS65941_LDO_ID_3:
-	case TPS65941_LDO_ID_4:
 		debug("Single phase regulator\n");
 		break;
+	case TPS65941_LDO_ID_4:
+		if (chip_id != TPS65224) {
+			debug("Single phase regulator\n");
+		} else {
+			printf("Wrong ID for regulator\n");
+			return -EINVAL;
+		}
+		break;
 	default:
 		pr_err("Wrong ID for regulator\n");
 		return -EINVAL;
@@ -346,6 +578,9 @@ static int tps65941_buck_probe(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
 	int idx;
+	ulong chip_id;
+
+	chip_id = tps65941_get_chip_id(dev);
 
 	uc_pdata = dev_get_uclass_plat(dev);
 	uc_pdata->type = REGULATOR_TYPE_BUCK;
@@ -356,16 +591,35 @@ static int tps65941_buck_probe(struct udevice *dev)
 	case TPS65941_BUCK_ID_2:
 	case TPS65941_BUCK_ID_3:
 	case TPS65941_BUCK_ID_4:
-	case TPS65941_BUCK_ID_5:
 		debug("Single phase regulator\n");
 		break;
+	case TPS65941_BUCK_ID_5:
+		if (chip_id != TPS65224) {
+			debug("Single phase regulator\n");
+		} else {
+			printf("Wrong ID for regulator\n");
+			return -EINVAL;
+		}
+		break;
 	case TPS65941_BUCK_ID_12:
+		idx = 1;
+		break;
 	case TPS65941_BUCK_ID_123:
 	case TPS65941_BUCK_ID_1234:
-		idx = 1;
+		if (chip_id != TPS65224) {
+			idx = 1;
+		} else {
+			printf("Wrong ID for regulator\n");
+			return -EINVAL;
+		}
 		break;
 	case TPS65941_BUCK_ID_34:
-		idx = 3;
+		if (chip_id != TPS65224) {
+			idx = 3;
+		} else {
+			printf("Wrong ID for regulator\n");
+			return -EINVAL;
+		}
 		break;
 	default:
 		pr_err("Wrong ID for regulator\n");
-- 
2.25.1

