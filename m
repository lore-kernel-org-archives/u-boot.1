Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36509C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64E387162;
	Tue, 24 Oct 2023 09:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JrD0nAhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB728713C; Tue, 24 Oct 2023 09:41:48 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C146D870E0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507c78d258fso5965030e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133304; x=1698738104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFECjWNCTNIXdNVKOdlbK/s4Wr46IvqmBZkGkvXEyvc=;
 b=JrD0nAhc3wsbX56ZHghBS2lcTDRhNitYrkZNlsoUwF1+y64Rhlah0fb0wq5xv6UMv/
 Pv0ra+R8iTER5Ii7+imeXWKj1ZnD1XcqA6ih4ASObEswfIKTA/SKkXw+xdQXPYxV3QgB
 YgmV4A8PfhbhF2H2xKNPqz1yRjlgN452wHvo5MckjePVeb8apcaarCROO9nguIgAGJQM
 AiIafdexdEFgDawnm8h9vgwqCLzGKU2/vqV8p3JGGEyVIiqnpm8Rbr6i8URYX6EZ04T5
 PSNfbbJ0wUiOEAxbZdvi2j9insISsW/bc6uC8wglTpXqBgVN4SR/0SJlh3V2iqQSI4vK
 3zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133304; x=1698738104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFECjWNCTNIXdNVKOdlbK/s4Wr46IvqmBZkGkvXEyvc=;
 b=QgB+n58+nQEb1sU3EdIgyEy7H6vojNPPwETrUlA3E7m/VcsHNqcwHOxIuiAeTmlg5f
 yrVa/LGRLxCstEhGLC8daoDh+ZwVN2opd3g0hxoBXFhyF4IsUjZpuVH1ri+jH8EsHW8r
 Q9332NR9nXKP4FP+zrDFdJp4OKJ0Z16INKcsoE+C8zQl95jaYH5klw4HtxyOH8D3/ex6
 b1Uvq73+bkWRzCTay8intyRS9Tq8G7G9n7sMgpMjO4KVN80umd4FxEbw20akPK0i/O0s
 npqRKUM8HI8KHlvJJC6+8sPFAUfx8S7GPUp7LISRiFFHnuE/jyN4nbfHokJYwVFULlxt
 HjXA==
X-Gm-Message-State: AOJu0YxlQT9wZDb3br6LUQanGM7fb0MzwR2VJcWw0PqUHIzqoNHaAxyj
 2zGEwgKhyVtJeL4No1QZ5OK95M4MFoA=
X-Google-Smtp-Source: AGHT+IHIzAoJldVMoGIvj6Zg2KVZx36qaifXDs84XKFX32s01JwI5K98jiNh9pnyXvnnusfYQHt4Mg==
X-Received: by 2002:a19:5f5e:0:b0:500:7fc7:8521 with SMTP id
 a30-20020a195f5e000000b005007fc78521mr7822422lfj.64.1698133304298; 
 Tue, 24 Oct 2023 00:41:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac25e6a000000b00507a089caf6sm2017580lfr.219.2023.10.24.00.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:41:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v8 8/8] power: regulator: tps65911: add regulator support
Date: Tue, 24 Oct 2023 10:41:10 +0300
Message-Id: <20231024074110.199623-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024074110.199623-1-clamor95@gmail.com>
References: <20231024074110.199623-1-clamor95@gmail.com>
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
functions for TI TPS5911 PMIC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/regulator/Kconfig              |  11 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/tps65911_regulator.c | 397 +++++++++++++++++++
 3 files changed, 409 insertions(+)
 create mode 100644 drivers/power/regulator/tps65911_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 6454c54855..102ec7bc5f 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -346,6 +346,17 @@ config DM_REGULATOR_TPS65910
 	regulator types of the TPS65910 (BUCK, BOOST and LDO). It implements
 	the get/set api for value and enable.
 
+config DM_REGULATOR_TPS65911
+	bool "Enable driver for TPS65911 PMIC regulators"
+	depends on DM_PMIC_TPS65910
+	---help---
+	This config enables implementation of driver-model regulator
+	uclass features for the TPS65911 PMIC. The driver supports Step-Down
+	DC-DC Converters for Processor Cores (VDD1 and VDD2), Step-Down DC-DC
+	Converter for I/O Power (VIO), Controller for External FETs (VDDCtrl)
+	and LDO Voltage Regulators found in TPS65911 PMIC and implements
+	get/set api for value and enable.
+
 config DM_REGULATOR_TPS62360
 	bool "Enable driver for TPS6236x Power Regulator"
 	depends on DM_REGULATOR
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 3ef55dc534..f79932d833 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_$(SPL_)DM_REGULATOR_LP873X) += lp873x_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_LP87565) += lp87565_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_DM_REGULATOR_TPS65910) += tps65910_regulator.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS65911) += tps65911_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS62360) += tps62360_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_TPS80031) += tps80031_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_STPMIC1) += stpmic1.o
diff --git a/drivers/power/regulator/tps65911_regulator.c b/drivers/power/regulator/tps65911_regulator.c
new file mode 100644
index 0000000000..ba80ed7c54
--- /dev/null
+++ b/drivers/power/regulator/tps65911_regulator.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/tps65910_pmic.h>
+
+/* fist row is control registers, second is voltage registers */
+static const char tps65911_vdd_reg[][TPS65911_VDD_NUM] = {
+	{ TPS65911_REG_VDD1, TPS65911_REG_VDD2,
+	  TPS65911_REG_VDDCTRL, TPS65911_REG_VIO },
+	{ TPS65911_REG_VDD1_OP, TPS65911_REG_VDD2_OP,
+	  TPS65911_REG_VDDCTRL_OP, 0x00 },
+};
+
+static const char tps65911_ldo_reg[TPS65911_LDO_NUM] = {
+	TPS65911_REG_LDO1, TPS65911_REG_LDO2, TPS65911_REG_LDO3,
+	TPS65911_REG_LDO4, TPS65911_REG_LDO5, TPS65911_REG_LDO6,
+	TPS65911_REG_LDO7, TPS65911_REG_LDO8
+};
+
+static int tps65911_regulator_enable(struct udevice *dev, int op, bool *enable)
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
+		if (val & TPS65910_SUPPLY_STATE_ON)
+			*enable = true;
+		else
+			*enable = false;
+
+		return 0;
+	} else if (op == PMIC_OP_SET) {
+		val &= ~TPS65910_SUPPLY_STATE_MASK;
+
+		if (*enable)
+			val |= TPS65910_SUPPLY_STATE_ON;
+
+		ret = pmic_reg_write(dev->parent, adr, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tps65911_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = tps65911_regulator_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int tps65911_set_enable(struct udevice *dev, bool enable)
+{
+	return tps65911_regulator_enable(dev, PMIC_OP_SET, &enable);
+}
+
+/**
+ * tps65911_vdd_volt2hex() - convert voltage in uV into
+ *			     applicable to register hex value
+ *
+ * @uV:		voltage in uV
+ *
+ * Return: voltage in hex on success, -ve on failure
+ */
+static int tps65911_vdd_volt2hex(int uV)
+{
+	if (uV > TPS65911_VDD_VOLT_MAX)
+		return -EINVAL;
+
+	if (uV < TPS65911_VDD_VOLT_MIN)
+		uV = TPS65911_VDD_VOLT_MIN;
+
+	return (uV - TPS65911_VDD_VOLT_BASE) / 12500;
+}
+
+/**
+ * tps65911_vdd_hex2volt() - convert register hex value into
+ *			     actual voltage in uV
+ *
+ * @hex:	hex value of register
+ *
+ * Return: voltage in uV on success, -ve on failure
+ */
+static int tps65911_vdd_hex2volt(int hex)
+{
+	if (hex > TPS65910_VDD_SEL_MAX)
+		return -EINVAL;
+
+	if (hex < TPS65910_VDD_SEL_MIN)
+		hex = TPS65910_VDD_SEL_MIN;
+
+	return TPS65911_VDD_VOLT_BASE + hex * 12500;
+}
+
+static int tps65911_vio_range[4] = {
+	1500000, 1800000, 2500000, 3300000
+};
+
+static int tps65911_vio_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->volt_reg;
+	int i, val;
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		*uV = 0;
+
+		val &= TPS65910_SEL_MASK;
+
+		*uV = tps65911_vio_range[val >> 2];
+
+		return 0;
+	}
+
+	val &= ~TPS65910_SEL_MASK;
+
+	for (i = 0; i < ARRAY_SIZE(tps65911_vio_range); i++)
+		if (*uV <= tps65911_vio_range[i])
+			break;
+
+	return pmic_reg_write(dev->parent, adr, val | i << 2);
+}
+
+static int tps65911_vdd_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->volt_reg;
+	int val, ret;
+
+	/* in case vdd is vio */
+	if (!adr)
+		return tps65911_vio_val(dev, op, uV);
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		*uV = 0;
+
+		ret = tps65911_vdd_hex2volt(val);
+		if (ret < 0)
+			return ret;
+
+		*uV = ret;
+		return 0;
+	}
+
+	val = tps65911_vdd_volt2hex(*uV);
+	if (val < 0)
+		return val;
+
+	return pmic_reg_write(dev->parent, adr, val);
+}
+
+static int tps65911_vdd_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+
+	uc_pdata->type = REGULATOR_TYPE_BUCK;
+
+	/* check for vddctrl and vddio cases */
+	if (!strcmp("vddctrl", dev->name)) {
+		uc_pdata->ctrl_reg = tps65911_vdd_reg[0][2];
+		uc_pdata->volt_reg = tps65911_vdd_reg[1][2];
+		return 0;
+	}
+
+	if (!strcmp("vddio", dev->name)) {
+		uc_pdata->ctrl_reg = tps65911_vdd_reg[0][3];
+		uc_pdata->volt_reg = tps65911_vdd_reg[1][3];
+		return 0;
+	}
+
+	if (dev->driver_data > 0) {
+		u8 idx = dev->driver_data - 1;
+
+		uc_pdata->ctrl_reg = tps65911_vdd_reg[0][idx];
+		uc_pdata->volt_reg = tps65911_vdd_reg[1][idx];
+	}
+
+	return 0;
+}
+
+static int vdd_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = tps65911_vdd_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int vdd_set_value(struct udevice *dev, int uV)
+{
+	return tps65911_vdd_val(dev, PMIC_OP_SET, &uV);
+}
+
+static const struct dm_regulator_ops tps65911_vdd_ops = {
+	.get_value  = vdd_get_value,
+	.set_value  = vdd_set_value,
+	.get_enable = tps65911_get_enable,
+	.set_enable = tps65911_set_enable,
+};
+
+U_BOOT_DRIVER(tps65911_vdd) = {
+	.name = TPS65911_VDD_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &tps65911_vdd_ops,
+	.probe = tps65911_vdd_probe,
+};
+
+/**
+ * tps65911_ldo_volt2hex() - convert voltage in uV into
+ *			     applicable to register hex value
+ *
+ * @idx:	regulator index
+ * @uV:		voltage in uV
+ *
+ * Return: voltage in hex on success, -ve on failure
+ */
+static int tps65911_ldo_volt2hex(int idx, int uV)
+{
+	int step;
+
+	if (uV > TPS65911_LDO_VOLT_MAX)
+		return -EINVAL;
+
+	if (uV < TPS65911_LDO_VOLT_BASE)
+		uV = TPS65911_LDO_VOLT_BASE;
+
+	switch (idx) {
+	case 1:
+	case 2:
+	case 4:
+		step = TPS65911_LDO124_VOLT_STEP;
+		break;
+	case 3:
+	case 5:
+	case 6:
+	case 7:
+	case 8:
+		step = TPS65911_LDO358_VOLT_STEP;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return ((uV - TPS65911_LDO_VOLT_BASE) / step) << 2;
+}
+
+/**
+ * tps65911_ldo_hex2volt() - convert register hex value into
+ *			     actual voltage in uV
+ *
+ * @idx:	regulator index
+ * @hex:	hex value of register
+ *
+ * Return: voltage in uV on success, -ve on failure
+ */
+static int tps65911_ldo_hex2volt(int idx, int hex)
+{
+	int step;
+
+	switch (idx) {
+	case 1:
+	case 2:
+	case 4:
+		if (hex > TPS65911_LDO124_VOLT_MAX_HEX)
+			return -EINVAL;
+
+		step = TPS65911_LDO124_VOLT_STEP;
+		break;
+	case 3:
+	case 5:
+	case 6:
+	case 7:
+	case 8:
+		if (hex > TPS65911_LDO358_VOLT_MAX_HEX)
+			return -EINVAL;
+
+		if (hex < TPS65911_LDO358_VOLT_MIN_HEX)
+			hex = TPS65911_LDO358_VOLT_MIN_HEX;
+
+		step = TPS65911_LDO358_VOLT_STEP;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return TPS65911_LDO_VOLT_BASE + hex * step;
+}
+
+static int tps65911_ldo_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->ctrl_reg;
+	int idx = dev->driver_data;
+	int val, hex, ret;
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		*uV = 0;
+		val &= TPS65911_LDO_SEL_MASK;
+
+		ret = tps65911_ldo_hex2volt(idx, val >> 2);
+		if (ret < 0)
+			return ret;
+
+		*uV = ret;
+		return 0;
+	}
+
+	hex = tps65911_ldo_volt2hex(idx, *uV);
+	if (hex < 0)
+		return hex;
+
+	val &= ~TPS65911_LDO_SEL_MASK;
+
+	return pmic_reg_write(dev->parent, adr, val | hex);
+}
+
+static int tps65911_ldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u8 idx = dev->driver_data - 1;
+
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+	uc_pdata->ctrl_reg = tps65911_ldo_reg[idx];
+
+	return 0;
+}
+
+static int ldo_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = tps65911_ldo_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int ldo_set_value(struct udevice *dev, int uV)
+{
+	return tps65911_ldo_val(dev, PMIC_OP_SET, &uV);
+}
+
+static const struct dm_regulator_ops tps65911_ldo_ops = {
+	.get_value  = ldo_get_value,
+	.set_value  = ldo_set_value,
+	.get_enable = tps65911_get_enable,
+	.set_enable = tps65911_set_enable,
+};
+
+U_BOOT_DRIVER(tps65911_ldo) = {
+	.name = TPS65911_LDO_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &tps65911_ldo_ops,
+	.probe = tps65911_ldo_probe,
+};
-- 
2.39.2

