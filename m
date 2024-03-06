Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52BDC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32F887FE3;
	Wed,  6 Mar 2024 14:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B826888019; Wed,  6 Mar 2024 14:40:21 +0100 (CET)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4060E87DA1
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: Mi3uu5ljjNkPwlvMTZyVPkxgsxWvDPmCH5Yxf9Bdr64kNWA+wcdv0Aqx3zkx/QCnJAptaGkX28
 VQhORr7cUmNA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 06 Mar 2024 19:10:02 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: jh80.chung@samsung.com, sjg@chromium.org, bhargav.r@ltts.com,
 m.nirmaladevi@ltts.com, trini@konsulko.com, d-gole@ti.com,
 dan.carpenter@linaro.org
Subject: [PATCH v2 4/5] power: regulator: tps65941: use function callbacks for
 conversion ops
Date: Wed,  6 Mar 2024 19:09:46 +0530
Message-Id: <20240306133947.160354-5-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306133947.160354-1-bhargav.r@ltts.com>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
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

Use function callbacks for volt2val, val2volt and slewrate lookups.
This makes it easier to add support for TPS65224 PMIC regulators.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/power/regulator/tps65941_regulator.c | 61 +++++++++++++++-----
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index cf54e30df5..d879c2301b 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -35,6 +35,17 @@
 #define TPS65941_LDO_ID_3         3
 #define TPS65941_LDO_ID_4         4
 
+#define TPS65941_BUCK_CONV_OPS_IDX  0
+#define TPS65941_LDO_CONV_OPS_IDX   0
+
+struct tps65941_reg_conv_ops {
+	int volt_mask;
+	int (*volt2val)(int idx, int uV);
+	int (*val2volt)(int idx, int volt);
+	int slew_mask;
+	int (*lookup_slew)(int id);
+};
+
 static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
 								0xC};
 static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
@@ -79,7 +90,7 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
 	return 0;
 }
 
-static int tps65941_buck_volt2val(int uV)
+static int tps65941_buck_volt2val(__maybe_unused int idx, int uV)
 {
 	if (uV > TPS65941_BUCK_VOLT_MAX)
 		return -EINVAL;
@@ -95,7 +106,7 @@ static int tps65941_buck_volt2val(int uV)
 		return -EINVAL;
 }
 
-static int tps65941_buck_val2volt(int val)
+static int tps65941_buck_val2volt(__maybe_unused int idx, int val)
 {
 	if (val > TPS65941_BUCK_VOLT_MAX_HEX)
 		return -EINVAL;
@@ -135,12 +146,25 @@ int tps65941_lookup_slew(int id)
 	}
 }
 
+static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
+	[TPS65941_BUCK_CONV_OPS_IDX] = {
+		.volt_mask = TPS65941_BUCK_VOLT_MASK,
+		.volt2val = tps65941_buck_volt2val,
+		.val2volt = tps65941_buck_val2volt,
+		.slew_mask = TP65941_BUCK_CONF_SLEW_MASK,
+		.lookup_slew = tps65941_lookup_slew,
+	},
+};
+
 static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
 {
 	unsigned int hex, adr;
-	int ret, delta, uwait, slew;
+	int ret, delta, uwait, slew, idx;
 	struct dm_regulator_uclass_plat *uc_pdata;
+	const struct tps65941_reg_conv_ops *conv_ops;
 
+	idx = dev->driver_data;
+	conv_ops = &buck_conv_ops[TPS65941_BUCK_CONV_OPS_IDX];
 	uc_pdata = dev_get_uclass_plat(dev);
 
 	if (op == PMIC_OP_GET)
@@ -152,8 +176,8 @@ static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
 	if (ret < 0)
 		return ret;
 
-	ret &= TPS65941_BUCK_VOLT_MASK;
-	ret = tps65941_buck_val2volt(ret);
+	ret &= conv_ops->volt_mask;
+	ret = conv_ops->val2volt(idx, ret);
 	if (ret < 0)
 		return ret;
 
@@ -175,14 +199,14 @@ static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
 	if (slew < 0)
 		return ret;
 
-	slew &= TP65941_BUCK_CONF_SLEW_MASK;
-	slew = tps65941_lookup_slew(slew);
+	slew &= conv_ops->slew_mask;
+	slew = conv_ops->lookup_slew(slew);
 	if (slew <= 0)
 		return ret;
 
 	uwait = delta / slew;
 
-	hex = tps65941_buck_volt2val(*uV);
+	hex = conv_ops->volt2val(idx, *uV);
 	if (hex < 0)
 		return hex;
 
@@ -231,7 +255,7 @@ static int tps65941_ldo_enable(struct udevice *dev, int op, bool *enable)
 	return 0;
 }
 
-static int tps65941_ldo_val2volt(int val)
+static int tps65941_ldo_val2volt(__maybe_unused int idx, int val)
 {
 	if (val > TPS65941_LDO_VOLT_MAX_HEX || val < TPS65941_LDO_VOLT_MIN_HEX)
 		return -EINVAL;
@@ -241,12 +265,23 @@ static int tps65941_ldo_val2volt(int val)
 		return -EINVAL;
 }
 
+static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
+	[TPS65941_LDO_CONV_OPS_IDX] = {
+		.volt_mask = TPS65941_LDO_VOLT_MASK,
+		.volt2val = tps65941_buck_volt2val,
+		.val2volt = tps65941_ldo_val2volt,
+	},
+};
+
 static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 {
 	unsigned int hex, adr;
-	int ret;
+	int ret, idx;
 	struct dm_regulator_uclass_plat *uc_pdata;
+	const struct tps65941_reg_conv_ops *conv_ops;
 
+	idx = dev->driver_data;
+	conv_ops = &ldo_conv_ops[TPS65941_LDO_CONV_OPS_IDX];
 	uc_pdata = dev_get_uclass_plat(dev);
 
 	if (op == PMIC_OP_GET)
@@ -258,8 +293,8 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 	if (ret < 0)
 		return ret;
 
-	ret &= TPS65941_LDO_VOLT_MASK;
-	ret = tps65941_ldo_val2volt(ret);
+	ret &= conv_ops->volt_mask;
+	ret = conv_ops->val2volt(idx, ret);
 	if (ret < 0)
 		return ret;
 
@@ -268,7 +303,7 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 		return 0;
 	}
 
-	hex = tps65941_buck_volt2val(*uV);
+	hex = conv_ops->volt2val(idx, *uV);
 	if (hex < 0)
 		return hex;
 
-- 
2.25.1

