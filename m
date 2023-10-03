Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C80EE75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF48A87237;
	Tue,  3 Oct 2023 08:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bmWbm2zv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B8C78721C; Tue,  3 Oct 2023 08:29:57 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A9787226
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50435a9f800so596563e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314594; x=1696919394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG574f5YiaQTZ2IGJ5dgZmzkuDJBwyJNt5F58zcoNo4=;
 b=bmWbm2zvpMq0SGWiI3LReqaOXSTsMgqzlrVxjmS60xkKRPPhaSwChifm2tG1sbFah7
 qjHip+TnUp9hG/ziviglNjY5ex65hXQFV5Ssxf8SS+ZErCPOHcffmBgUPsdDESx6F+gZ
 9BNbtlUo1XEVhevvy0uximWPEGmfZ7x1mE+ejbldcnCNoYoDjcqmpmZ7BsW0IHnu50R/
 xtpb6jZuUJqw9BrnXs6Gkll2LEu0cuNdyRHf4W4VSIDVXsSgA/8Xbft3JaF4kefzdwC+
 QFy4mYGBCmbfW5vQV/TdGIYGvYIHXQ+A7jB6lr06dk8PDimWWUIPGE7WHJdirp6J/Ifn
 cAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314594; x=1696919394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG574f5YiaQTZ2IGJ5dgZmzkuDJBwyJNt5F58zcoNo4=;
 b=bixyv4fOo1vz48IiUKxesb2NhBkz+AB+1nngkPRHURlm72x2r0QL51g55497D+cgpB
 PK/tynIsI66K5QcJIwcQJm4t+KsSFYwjLEUMlQCTyR0Mw4SHNzbxO5Wqea8Km+vim7yO
 okLf8WFe/NFF3tO5YUH9LpZQo6zy6uiU4yutQqjCTmDXo5Awo7T7vOx/w0SVl3djmNbP
 whLXa+j6qnb2A3gjokb2fqcdQdadCnmFbxNpjwamN/FpoYNbcgEXinbDUoxKqccEzZ4P
 xY0b3wPBw69+n3It1IvJ7Taf4aVbP3Gmh0qV+h0og2qGiz1r3MVM85nuwBkjuD16pgj7
 RAnA==
X-Gm-Message-State: AOJu0YzVphhg/dGCfCBPPRClfOYrq1m/Z1hpIrAzckz1aoA8O2f0Qswh
 HfkU4ZnvrMjui0l2alsF6sA=
X-Google-Smtp-Source: AGHT+IFhr3UsuFPfxo6r2sZOGS88+hPsCrNzc/WSC5Suv08HN+Y5e5t323CHfgWSXi7msuZJtHT0XA==
X-Received: by 2002:a05:6512:10d0:b0:503:293a:dc1b with SMTP id
 k16-20020a05651210d000b00503293adc1bmr13598146lfg.30.1696314593734; 
 Mon, 02 Oct 2023 23:29:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 6/8] power: regulator: tps80031: add regulator support
Date: Tue,  3 Oct 2023 09:29:39 +0300
Message-Id: <20231003062941.42501-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062941.42501-1-clamor95@gmail.com>
References: <20231003062941.42501-1-clamor95@gmail.com>
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

The driver provides regulator set/get voltage enable/disable
functions for TI TPS80031/TPS80032 PMICs.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/regulator/Kconfig              |   8 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/tps80031_regulator.c | 350 +++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/power/regulator/tps80031_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 581816294c..6454c54855 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -356,6 +356,14 @@ config DM_REGULATOR_TPS62360
 	implements the get/set api for value only, as the power line is
 	always on.
 
+config DM_REGULATOR_TPS80031
+	bool "Enable driver for TPS80031/TPS80032 PMIC regulators"
+	depends on DM_PMIC_TPS80031
+	---help---
+	This enables implementation of driver-model regulator uclass
+	features for TPS80031/TPS80032 PMICs. The driver implements
+	get/set api for: value and enable.
+
 config DM_REGULATOR_STPMIC1
 	bool "Enable driver for STPMIC1 regulators"
 	depends on DM_REGULATOR && PMIC_STPMIC1
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 8d73169b50..3ef55dc534 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_$(SPL_)DM_REGULATOR_LP87565) += lp87565_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_DM_REGULATOR_TPS65910) += tps65910_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS62360) += tps62360_regulator.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
 obj-$(CONFIG_DM_REGULATOR_TPS65941) += tps65941_regulator.o
 obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
diff --git a/drivers/power/regulator/tps80031_regulator.c b/drivers/power/regulator/tps80031_regulator.c
new file mode 100644
index 0000000000..f0b5a0b65b
--- /dev/null
+++ b/drivers/power/regulator/tps80031_regulator.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <fdtdec.h>
+#include <errno.h>
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/tps80031.h>
+
+static const char tps80031_smps_reg[][TPS80031_SMPS_NUM] = {
+	{   0x54,   0x5a,   0x66,   0x42,   0x48 },
+	{   0x56,   0x5c,   0x68,   0x44,   0x4a },
+	{ BIT(3), BIT(4), BIT(6), BIT(0), BIT(1) },
+};
+
+static const char tps80031_ldo_reg[][TPS80031_LDO_NUM] = {
+	{ 0x9e, 0x86, 0x8e, 0x8a, 0x9a, 0x92, 0xa6, 0x96, 0xa2 },
+	{ 0x9f, 0x87, 0x8f, 0x8b, 0x9b, 0x93, 0xa7, 0x97, 0xa3 },
+};
+
+static int tps80031_regulator_enable(struct udevice *dev, int op, bool *enable)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->ctrl_reg;
+	int val, ret;
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		if (val & REGULATOR_MODE_ON)
+			*enable = true;
+		else
+			*enable = false;
+
+		return 0;
+	} else if (op == PMIC_OP_SET) {
+		val &= ~REGULATOR_STATUS_MASK;
+
+		if (*enable)
+			val |= REGULATOR_MODE_ON;
+
+		ret = pmic_reg_write(dev->parent, adr, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tps80031_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = tps80031_regulator_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int tps80031_set_enable(struct udevice *dev, bool enable)
+{
+	return tps80031_regulator_enable(dev, PMIC_OP_SET, &enable);
+}
+
+/**
+ * tps80031_ldo_volt2hex() - convert voltage in uV into
+ *			     applicable to register hex value
+ *
+ * @uV:		voltage in uV
+ *
+ * Return: voltage in hex on success, -ve on failure
+ */
+static int tps80031_ldo_volt2hex(int uV)
+{
+	if (uV > LDO_VOLT_MAX)
+		return -EINVAL;
+
+	if (uV < LDO_VOLT_MIN)
+		uV = LDO_VOLT_MIN;
+
+	return DIV_ROUND_UP(uV - LDO_VOLT_BASE, 102000);
+}
+
+/**
+ * tps80031_ldo_hex2volt() - convert register hex value into
+ *			     actual voltage in uV
+ *
+ * @hex:	hex value of register
+ *
+ * Return: voltage in uV on success, -ve on failure
+ */
+static int tps80031_ldo_hex2volt(int hex)
+{
+	if (hex > LDO_VOLT_MAX_HEX)
+		return -EINVAL;
+
+	if (hex < LDO_VOLT_MIN_HEX)
+		hex = LDO_VOLT_MIN_HEX;
+
+	return LDO_VOLT_BASE + hex * 102000;
+}
+
+static int tps80031_ldo_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->volt_reg;
+	int val, hex, ret;
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		*uV = 0;
+
+		ret = tps80031_ldo_hex2volt(val & LDO_VOLT_MASK);
+		if (ret < 0)
+			return ret;
+
+		*uV = ret;
+		return 0;
+	}
+
+	hex = tps80031_ldo_volt2hex(*uV);
+	if (hex < 0)
+		return hex;
+
+	val &= ~LDO_VOLT_MASK;
+
+	return pmic_reg_write(dev->parent, adr, val | hex);
+}
+
+static int tps80031_ldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+
+	/* check for ldoln and ldousb cases */
+	if (!strcmp("ldoln", dev->name)) {
+		uc_pdata->ctrl_reg = tps80031_ldo_reg[CTRL][7];
+		uc_pdata->volt_reg = tps80031_ldo_reg[VOLT][7];
+		return 0;
+	}
+
+	if (!strcmp("ldousb", dev->name)) {
+		uc_pdata->ctrl_reg = tps80031_ldo_reg[CTRL][8];
+		uc_pdata->volt_reg = tps80031_ldo_reg[VOLT][8];
+		return 0;
+	}
+
+	if (dev->driver_data > 0) {
+		u8 idx = dev->driver_data - 1;
+
+		uc_pdata->ctrl_reg = tps80031_ldo_reg[CTRL][idx];
+		uc_pdata->volt_reg = tps80031_ldo_reg[VOLT][idx];
+	}
+
+	return 0;
+}
+
+static int ldo_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = tps80031_ldo_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int ldo_set_value(struct udevice *dev, int uV)
+{
+	return tps80031_ldo_val(dev, PMIC_OP_SET, &uV);
+}
+
+static const struct dm_regulator_ops tps80031_ldo_ops = {
+	.get_value  = ldo_get_value,
+	.set_value  = ldo_set_value,
+	.get_enable = tps80031_get_enable,
+	.set_enable = tps80031_set_enable,
+};
+
+U_BOOT_DRIVER(tps80031_ldo) = {
+	.name = TPS80031_LDO_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &tps80031_ldo_ops,
+	.probe = tps80031_ldo_probe,
+};
+
+struct tps80031_smps_priv {
+	int flags;
+};
+
+/* DCDC voltages for the selector of 0x39 to 0x3F */
+static int tps80031_dcdc_voltages[5] = {
+	1350000, 1500000, 1800000, 1900000, 2100000
+};
+
+/**
+ * tps80031_smps_volt2hex() - convert voltage in uV into
+ *			      applicable to register hex value
+ *
+ * @base:	base voltage in uV
+ * @uV:		voltage in uV
+ *
+ * Return: voltage in hex on success, -ve on failure
+ */
+static int tps80031_smps_volt2hex(u32 base, int uV)
+{
+	int i;
+
+	if (uV < base)
+		return 1;
+
+	if (uV > SMPS_VOLT_LINEAR) {
+		for (i = 0; i < ARRAY_SIZE(tps80031_dcdc_voltages); i++)
+			if (uV <= tps80031_dcdc_voltages[i])
+				break;
+
+		return SMPS_VOLT_NLINEAR_HEX + i;
+	}
+
+	return DIV_ROUND_UP(uV - base, 12500);
+}
+
+/**
+ * tps80031_smps_hex2volt() - convert register hex value into
+ *			      actual voltage in uV
+ *
+ * @base:	base voltage in uV
+ * @hex:	hex value of register
+ *
+ * Return: voltage in uV on success, -ve on failure
+ */
+static int tps80031_smps_hex2volt(u32 base, int hex)
+{
+	if (!hex)
+		return 0;
+
+	/* if reg value exceeds linear scale use table */
+	if (hex > SMPS_VOLT_LINEAR_HEX)
+		return tps80031_dcdc_voltages[hex - SMPS_VOLT_LINEAR_HEX];
+	else
+		return base + hex * 12500;
+}
+
+static int tps80031_smps_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	struct tps80031_smps_priv *priv = dev_get_priv(dev);
+	u32 adr = uc_pdata->volt_reg;
+	int base, val, hex, ret;
+
+	/* If offset flag was set then base voltage is higher */
+	if (priv->flags & TPS80031_OFFSET_FLAG)
+		base = SMPS_VOLT_BASE_OFFSET;
+	else
+		base = SMPS_VOLT_BASE;
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		*uV = 0;
+
+		ret = tps80031_smps_hex2volt(base, val & SMPS_VOLT_MASK);
+		if (ret < 0)
+			return ret;
+
+		*uV = ret;
+		return 0;
+	}
+
+	hex = tps80031_smps_volt2hex(base, *uV);
+	if (hex < 0)
+		return hex;
+
+	val &= ~SMPS_VOLT_MASK;
+
+	return pmic_reg_write(dev->parent, adr, val | hex);
+}
+
+static int tps80031_smps_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	struct tps80031_smps_priv *priv = dev_get_priv(dev);
+	int idx = dev->driver_data - 1;
+	int val;
+
+	uc_pdata->type = REGULATOR_TYPE_BUCK;
+
+	uc_pdata->ctrl_reg = tps80031_smps_reg[CTRL][idx];
+	uc_pdata->volt_reg = tps80031_smps_reg[VOLT][idx];
+
+	/* Determine if smps regulator uses higher voltage */
+	val = pmic_reg_read(dev->parent, TPS80031_SMPS_OFFSET);
+	if (val & tps80031_smps_reg[OFFSET][idx])
+		priv->flags |= TPS80031_OFFSET_FLAG;
+
+	return 0;
+}
+
+static int smps_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = tps80031_smps_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int smps_set_value(struct udevice *dev, int uV)
+{
+	return tps80031_smps_val(dev, PMIC_OP_SET, &uV);
+}
+
+static const struct dm_regulator_ops tps80031_smps_ops = {
+	.get_value  = smps_get_value,
+	.set_value  = smps_set_value,
+	.get_enable = tps80031_get_enable,
+	.set_enable = tps80031_set_enable,
+};
+
+U_BOOT_DRIVER(tps80031_smps) = {
+	.name = TPS80031_SMPS_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &tps80031_smps_ops,
+	.probe = tps80031_smps_probe,
+	.priv_auto = sizeof(struct tps80031_smps_priv),
+};
-- 
2.39.2

