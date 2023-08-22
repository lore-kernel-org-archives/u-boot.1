Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92395EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 06:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9DF8727F;
	Tue, 22 Aug 2023 08:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xw54wGGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070588726F; Tue, 22 Aug 2023 08:32:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BFBB871DB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so4887150a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 23:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692685967; x=1693290767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFECjWNCTNIXdNVKOdlbK/s4Wr46IvqmBZkGkvXEyvc=;
 b=Xw54wGGDmSg+8heVOsf0gne7nBeUFGg2Asag0AX/NTRu0WXiG4DFv372Vfmbf7NE+7
 83enefyZOrwQ2cWojAqypHdvFj0QRV3sfBeU0cf5lPhHqPlSNu26ZN3b/vNjiE8ff0/4
 FjqgpoEMhZ7kO62DZDZmSOQnkOygk4yi7rBDUsWaaOOKf222u5Ua3RTOC+KBKMs6SJU/
 CB+m09osphPcrsRxBYBV3iWV7XBzgLBUF2UmeZMapcSKUqQhUCCRUfOwlnKk4PQpzZSS
 QR5ODmrdbCTKbcnWMA259jyXf6WS1RGpJjbOC7VExEytwz0sgN6HNWHy5uO0zc/XHUPE
 JCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692685967; x=1693290767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFECjWNCTNIXdNVKOdlbK/s4Wr46IvqmBZkGkvXEyvc=;
 b=IHUDRyG9x0/C/kZlYoxeivF2RPDOBPD6TSZOss8qzC27GNcx4OqM5BU8CVq8dSnM87
 Oze6Zeooq6NU20KLgeJvax5uFGkRqMZvWRKc7oot5TtJap+oQ8bQrRZamgHQVcx0hmIr
 BwuyVaYGv7KvAKWX1X1VDxhqncDgA4myvnJFcl+h5XiTkkGnfgSivzTGlZSii3x1Cab2
 yuQhFOXYr0pcy6ZNTEAIyk6ZjakPpxcxtMwcDr2bZ9XODc4EWEZanZ+OGw57MsIOk1nZ
 3NBEttpkLTT0VubCtpbWg8q6R1VDMxzfBCRf1ltWy7TBkirW36ET7gudJvJJ3oV/mSHN
 xQJw==
X-Gm-Message-State: AOJu0Yzu8MZ/A46HM4MfejUjZY2zy7k5niKAEUvAwl8OYIGlT1p80SNU
 Mjq12Xo9C+A5kzBv9VkPODs=
X-Google-Smtp-Source: AGHT+IGJd7Fh1F2SmWg9D+G+7tz+Jnw5MgDU1xzUV18KFNPJhdL9jdU4196wmBvMHoxvV68jz6Fl2w==
X-Received: by 2002:aa7:c30d:0:b0:522:3a37:a463 with SMTP id
 l13-20020aa7c30d000000b005223a37a463mr6700793edq.20.1692685967113; 
 Mon, 21 Aug 2023 23:32:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 dy21-20020a05640231f500b0052a19a75372sm784320edb.90.2023.08.21.23.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 23:32:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 8/8] power: regulator: tps65911: add regulator support
Date: Tue, 22 Aug 2023 09:32:20 +0300
Message-Id: <20230822063220.5191-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822063220.5191-1-clamor95@gmail.com>
References: <20230822063220.5191-1-clamor95@gmail.com>
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

