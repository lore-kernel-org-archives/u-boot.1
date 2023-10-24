Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D28C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59F287157;
	Tue, 24 Oct 2023 09:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xf/ilIEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B3E87149; Tue, 24 Oct 2023 09:41:42 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F44C870E0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5079f9ec8d9so4768710e87.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698133299; x=1698738099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OO3ZwahjOR5yAJKI7TdybD2mMXIYhgOSrEOQo04RxeM=;
 b=Xf/ilIEqf7iU8KAO234WkxGlO27/mmcITTNiqjY2n2gMJsKhUYaDliFcRIo5cuFaZX
 /naWxqRR5we6E3n9b7qIZRmC034vsowWBHwjYA0gEfJJE+k1KhkDdifl0GGeTAgC2J0g
 UDcW6iE2TFUV70DIq3BTSKGl4BMkfxez8byy9us3ABk9R0FP7QCWdkjEgqDqH/KZQQIu
 2Kni/aCtWHQiNyAJPPplhKF5lu/pdTZsfoqZM0RoReWltb2O6vBenfFkGL+r+d5p36bi
 EWbBszB0W18hkxcYfpbbZ2jNW7paPxguP4IQFxPZDDOhVT+EVhcsn5IIe1zhoeh9LLOl
 oPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133299; x=1698738099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OO3ZwahjOR5yAJKI7TdybD2mMXIYhgOSrEOQo04RxeM=;
 b=qNgypX9FhQ68NBohdl7Y04TKYtamc7+wlG0jf45kQjPOTCWOKkOkQc8Y2ZG5bsdCOf
 k24KRIH/7ifu3uYp5jtPTdn1SfGHoFA3jbPEUZmrhuGpQQtljRIvulqes/HLqEOJAH5t
 eWg4gBUHhV84xi7SVJGjRWHwd18FQm+Ya/XffuzIsi2eR+D8Iytn0Mm4SdzGaWIdcU01
 AqO0PnT8wfq3ONwJmutcaJZC75aUzSgD8Oot0z505wWJ+ncF87pesyG+z7amWWR/yI6s
 I/bum3IwPk6Cf0oCz+JFLS8kiKS+XWB/r8hIOGZ/BYnnq04IHr4fS3nlpd/UZSy4fAad
 DMOQ==
X-Gm-Message-State: AOJu0Yz3PHNeAd6zwd0RZ6YVPixx2pJrqew4f7D7G/vysbtjG2dnrPRf
 D8WnudjIfk2oGYzQEpxLEgTmWrj2oHs=
X-Google-Smtp-Source: AGHT+IEHVa1Z9Us49fHw78pnPn+QazcSR2pqZE8320SlOzJ3x2yUkQGU4hajK2lj+UtqaoKkBdy0jQ==
X-Received: by 2002:a19:4f11:0:b0:503:224f:9c55 with SMTP id
 d17-20020a194f11000000b00503224f9c55mr3396722lfb.8.1698133299324; 
 Tue, 24 Oct 2023 00:41:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac25e6a000000b00507a089caf6sm2017580lfr.219.2023.10.24.00.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:41:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v8 4/8] power: regulator: max77663: add regulator support
Date: Tue, 24 Oct 2023 10:41:06 +0300
Message-Id: <20231024074110.199623-5-clamor95@gmail.com>
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

The driver provides regulator set/get voltage
enable/disable functions for MAXIM MAX77663 PMICs.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/regulator/Kconfig              |   9 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/max77663_regulator.c | 378 +++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 drivers/power/regulator/max77663_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index eb5aa38c1c..581816294c 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -141,6 +141,15 @@ config SPL_REGULATOR_PWM
 	  This config enables implementation of driver-model regulator uclass
 	  features for PWM regulators in SPL.
 
+config DM_REGULATOR_MAX77663
+	bool "Enable Driver Model for REGULATOR MAX77663"
+	depends on DM_REGULATOR && DM_PMIC_MAX77663
+	---help---
+	This config enables implementation of driver-model regulator uclass
+	features for REGULATOR MAX77663. The driver supports both DC-to-DC
+	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
+	found in MAX77663 PMIC and implements get/set api for value and enable.
+
 config DM_REGULATOR_MAX77686
 	bool "Enable Driver Model for REGULATOR MAX77686"
 	depends on DM_REGULATOR && DM_PMIC_MAX77686
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index d9e0cd5949..8d73169b50 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
 obj-$(CONFIG_$(SPL_)REGULATOR_AXP) += axp_regulator.o
 obj-$(CONFIG_$(SPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_DA9063) += da9063.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_MAX77663) += max77663_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
diff --git a/drivers/power/regulator/max77663_regulator.c b/drivers/power/regulator/max77663_regulator.c
new file mode 100644
index 0000000000..bccfb4ccf9
--- /dev/null
+++ b/drivers/power/regulator/max77663_regulator.c
@@ -0,0 +1,378 @@
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
+#include <power/max77663.h>
+
+/* fist row is control registers, second is voltage registers */
+static const char max77663_sd_reg[][MAX77663_SD_NUM] = {
+	{ 0x1d, 0x1e, 0x1f, 0x20, 0x21 },
+	{ 0x16, 0x17, 0x18, 0x19, 0x2a },
+};
+
+static const char max77663_ldo_reg[MAX77663_LDO_NUM] = {
+	0x23, 0x25, 0x27, 0x29, 0x2b, 0x2d, 0x2f, 0x31, 0x33
+};
+
+static int max77663_sd_enable(struct udevice *dev, int op, bool *enable)
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
+		if (val & SD_STATUS_MASK)
+			*enable = true;
+		else
+			*enable = false;
+
+		return 0;
+	} else if (op == PMIC_OP_SET) {
+		val &= ~SD_STATUS_MASK;
+
+		if (*enable)
+			val |= SD_STATUS_MASK;
+
+		ret = pmic_reg_write(dev->parent, adr, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * max77663_*_volt2hex() - convert voltage in uV into
+ *			   applicable to register hex value
+ *
+ * @idx:	regulator index
+ * @uV:		voltage in uV
+ *
+ * Return: voltage in hex on success, -ve on failure
+ */
+static int max77663_sd_volt2hex(int idx, int uV)
+{
+	switch (idx) {
+	case 0:
+		/* SD0 has max voltage 1.4V */
+		if (uV > SD0_VOLT_MAX)
+			return -EINVAL;
+		break;
+	case 1:
+		/* SD1 has max voltage 1.55V */
+		if (uV > SD1_VOLT_MAX)
+			return -EINVAL;
+		break;
+	default:
+		/* SD2 and SD3 have max voltage 3.79V */
+		if (uV > SD_VOLT_MAX)
+			return -EINVAL;
+		break;
+	};
+
+	if (uV < SD_VOLT_MIN)
+		uV = SD_VOLT_MIN;
+
+	return (uV - SD_VOLT_BASE) / 12500;
+}
+
+/**
+ * max77663_*_hex2volt() - convert register hex value into
+ *			   actual voltage in uV
+ *
+ * @idx:	regulator index
+ * @hex:	hex value of register
+ *
+ * Return: voltage in uV on success, -ve on failure
+ */
+static int max77663_sd_hex2volt(int idx, int hex)
+{
+	switch (idx) {
+	case 0:
+		/* SD0 has max voltage 1.4V */
+		if (hex > SD0_VOLT_MAX_HEX)
+			return -EINVAL;
+		break;
+	case 1:
+		/* SD1 has max voltage 1.55V */
+		if (hex > SD1_VOLT_MAX_HEX)
+			return -EINVAL;
+		break;
+	default:
+		/* SD2 and SD3 have max voltage 3.79V */
+		if (hex > SD_VOLT_MAX_HEX)
+			return -EINVAL;
+		break;
+	};
+
+	if (hex < SD_VOLT_MIN_HEX)
+		hex = SD_VOLT_MIN_HEX;
+
+	return SD_VOLT_BASE + hex * 12500;
+}
+
+static int max77663_sd_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->volt_reg;
+	int idx = dev->driver_data;
+	int hex, ret;
+
+	if (op == PMIC_OP_GET) {
+		hex = pmic_reg_read(dev->parent, adr);
+		if (hex < 0)
+			return hex;
+
+		*uV = 0;
+
+		ret = max77663_sd_hex2volt(idx, hex);
+		if (ret < 0)
+			return ret;
+		*uV = ret;
+
+		return 0;
+	}
+
+	/* SD regulators use entire register for voltage */
+	hex = max77663_sd_volt2hex(idx, *uV);
+	if (hex < 0)
+		return hex;
+
+	return pmic_reg_write(dev->parent, adr, hex);
+}
+
+static int max77663_sd_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	int idx = dev->driver_data;
+
+	uc_pdata->type = REGULATOR_TYPE_BUCK;
+	uc_pdata->ctrl_reg = max77663_sd_reg[0][idx];
+	uc_pdata->volt_reg = max77663_sd_reg[1][idx];
+
+	return 0;
+}
+
+static int sd_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = max77663_sd_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int sd_set_value(struct udevice *dev, int uV)
+{
+	return max77663_sd_val(dev, PMIC_OP_SET, &uV);
+}
+
+static int sd_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = max77663_sd_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int sd_set_enable(struct udevice *dev, bool enable)
+{
+	return max77663_sd_enable(dev, PMIC_OP_SET, &enable);
+}
+
+static const struct dm_regulator_ops max77663_sd_ops = {
+	.get_value  = sd_get_value,
+	.set_value  = sd_set_value,
+	.get_enable = sd_get_enable,
+	.set_enable = sd_set_enable,
+};
+
+U_BOOT_DRIVER(max77663_sd) = {
+	.name = MAX77663_SD_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &max77663_sd_ops,
+	.probe = max77663_sd_probe,
+};
+
+static int max77663_ldo_enable(struct udevice *dev, int op, bool *enable)
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
+		if (val & LDO_STATUS_MASK)
+			*enable = true;
+		else
+			*enable = false;
+
+		return 0;
+	} else if (op == PMIC_OP_SET) {
+		val &= ~LDO_STATUS_MASK;
+
+		if (*enable)
+			val |= LDO_STATUS_MASK;
+
+		ret = pmic_reg_write(dev->parent, adr, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int max77663_ldo_volt2hex(int idx, int uV)
+{
+	switch (idx) {
+	case 0:
+	case 1:
+		if (uV > LDO01_VOLT_MAX)
+			return -EINVAL;
+
+		return (uV - LDO_VOLT_BASE) / 25000;
+	case 4:
+		if (uV > LDO4_VOLT_MAX)
+			return -EINVAL;
+
+		return (uV - LDO_VOLT_BASE) / 12500;
+	default:
+		if (uV > LDO_VOLT_MAX)
+			return -EINVAL;
+
+		return (uV - LDO_VOLT_BASE) / 50000;
+	};
+}
+
+static int max77663_ldo_hex2volt(int idx, int hex)
+{
+	if (hex > LDO_VOLT_MAX_HEX)
+		return -EINVAL;
+
+	switch (idx) {
+	case 0:
+	case 1:
+		return (hex * 25000) + LDO_VOLT_BASE;
+	case 4:
+		return (hex * 12500) + LDO_VOLT_BASE;
+	default:
+		return (hex * 50000) + LDO_VOLT_BASE;
+	};
+}
+
+static int max77663_ldo_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	u32 adr = uc_pdata->ctrl_reg;
+	int idx = dev->driver_data;
+	int hex, val, ret;
+
+	val = pmic_reg_read(dev->parent, adr);
+	if (val < 0)
+		return val;
+
+	if (op == PMIC_OP_GET) {
+		*uV = 0;
+
+		ret = max77663_ldo_hex2volt(idx, val & LDO_VOLT_MASK);
+		if (ret < 0)
+			return ret;
+
+		*uV = ret;
+		return 0;
+	}
+
+	hex = max77663_ldo_volt2hex(idx, *uV);
+	if (hex < 0)
+		return hex;
+
+	val &= ~LDO_VOLT_MASK;
+
+	return pmic_reg_write(dev->parent, adr, val | hex);
+}
+
+static int max77663_ldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	int idx = dev->driver_data;
+
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+	uc_pdata->ctrl_reg = max77663_ldo_reg[idx];
+
+	return 0;
+}
+
+static int ldo_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = max77663_ldo_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int ldo_set_value(struct udevice *dev, int uV)
+{
+	return max77663_ldo_val(dev, PMIC_OP_SET, &uV);
+}
+
+static int ldo_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = max77663_ldo_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int ldo_set_enable(struct udevice *dev, bool enable)
+{
+	return max77663_ldo_enable(dev, PMIC_OP_SET, &enable);
+}
+
+static const struct dm_regulator_ops max77663_ldo_ops = {
+	.get_value  = ldo_get_value,
+	.set_value  = ldo_set_value,
+	.get_enable = ldo_get_enable,
+	.set_enable = ldo_set_enable,
+};
+
+U_BOOT_DRIVER(max77663_ldo) = {
+	.name = MAX77663_LDO_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &max77663_ldo_ops,
+	.probe = max77663_ldo_probe,
+};
-- 
2.39.2

