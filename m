Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDE1C369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2758205B;
	Mon, 14 Apr 2025 08:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Npau0CeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC6C81F54; Mon, 14 Apr 2025 08:01:09 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81BD981F7B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso223640466b.2
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610467; x=1745215267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5nbyEWLYBN4PTwO5YuqYVDvHcrOherQnnmppcza6yc=;
 b=Npau0CeWSP9Nby9Hu05IWErKwJC98dz0coBnnUSpOdp65SUOj+yJPTRSZHXB4eQYNa
 qGiVtqNaZtD8V7zNLzOKkBEyiI/Tw26zxVMA0ppumrqNoZRUZ9ySXqMZOkC1bdy/iD2e
 Zb+SNvH/OFeJHlh3RA9kdy3hQKjC1gUCRfu7HiIZPjh7z3Ho/zL1JlQKdvMQSOvG/UNV
 bEH6ZSQeIS4WJUKcIttRKS34uyyADtzQEwf+r1dkkBKzeSToHqMsxJeNWvGD8sxu3MnB
 HvhUAXdG8IZHSpgl3KSQAW/jHBhwFs+//lEWZZ/44CXMOjdX6CH6tCeU66qezeZGkGJW
 uXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610467; x=1745215267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5nbyEWLYBN4PTwO5YuqYVDvHcrOherQnnmppcza6yc=;
 b=cqiTpyGfwvQff83Zir502EOmJnlC+6LSdsPprgRGAdjNFrtQpH3Jte2ZJdF5kmzSmk
 n+FtiYTPbrrfa+1dEVmgPlw9uYma1WUJoXPprCNGwzVBClF3gT/bWW00CnTiA7sWlXo7
 XEBcL2uxlcroXVNjOyR7AZUjEo7W2tTXpjtlglT7bwB3lKZnCI5uLkii6KLTHo/06lkd
 C347QJ3REPQju/MqE4EMB6SRNFo+/QboZgS29n8mtCoAk3DegcxUHZuqC+GnRpcqXWUl
 MAwm3wjJxGIX7Czvjj47jwy7cKcmSQzKH9BXQWf0ai56sp/aWN/gt8nvciK1qrLTBJ27
 wiRg==
X-Gm-Message-State: AOJu0Yw50cgRSPNOZ/d7JrBDMywt1npoUib7gKoWN92g6ex2mD3nTgGf
 7PKJvcR+1hU97orwywGDfqAEUqbz1wiZqy1MUpaJLgD5RC1IoXGw
X-Gm-Gg: ASbGnct3rSC70K319o8bYX23/Zk99VNRMh6zi3MgjtvAgk5siK9bOe6WJunfiz5JpnH
 h27N8O+0v3dB/lfa+3/Lb5hnXWI/CmJoNsHi1tq9j37oW3b7FoAtHoTArnpxNw2jVvdiMAeZDQY
 yn7AxP0MguRTUFn/Z4+D0EH21cu7VY6TC1gyoNgj5hV82qUlBrC6llGbht+tdI8OkfAfWm/WUvN
 FEcWBKFdU/F4xq0HDAzI+GRKs6/NAF47qGb2jwqNdtCshWdLxo+pu6U0S4JCVzgsbe6p63m0pTV
 LGlvzvw3jnulPyO3UjxwdDpc2iurVjOC
X-Google-Smtp-Source: AGHT+IHc3YQOqdUjq/C+b/98t5Kc6jrlZ0wpvv+eZW+L8obyCzEFY5SYtVoD4Q2z7GsYrXKAcCaJzQ==
X-Received: by 2002:a17:907:9408:b0:ac7:edc7:d0a5 with SMTP id
 a640c23a62f3a-acad3445ecfmr1005915566b.12.1744610466556; 
 Sun, 13 Apr 2025 23:01:06 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:06 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/9] power: regulator: max9807: add regulator support
Date: Mon, 14 Apr 2025 09:00:13 +0300
Message-ID: <20250414060021.14545-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

Added a new regulator driver for the MAXIM MAX8907 PMIC, providing
essential regulator functionalities and incorporated the necessary binding
framework within the core PMIC driver.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/max8907.c                |  29 +++
 drivers/power/regulator/Kconfig             |   9 +
 drivers/power/regulator/Makefile            |   1 +
 drivers/power/regulator/max8907_regulator.c | 249 ++++++++++++++++++++
 include/power/max8907.h                     |  73 ++++++
 5 files changed, 361 insertions(+)
 create mode 100644 drivers/power/regulator/max8907_regulator.c
 create mode 100644 include/power/max8907.h

diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
index aeb6fe734e6..5d35957bf40 100644
--- a/drivers/power/pmic/max8907.c
+++ b/drivers/power/pmic/max8907.c
@@ -6,6 +6,13 @@
 #include <dm.h>
 #include <dm/lists.h>
 #include <power/pmic.h>
+#include <power/max8907.h>
+
+static const struct pmic_child_info pmic_children_info[] = {
+	{ .prefix = "ldo", .driver = MAX8907_LDO_DRIVER },
+	{ .prefix = "sd", .driver = MAX8907_SD_DRIVER },
+	{ },
+};
 
 static int max8907_write(struct udevice *dev, uint reg, const uint8_t *buff, int len)
 {
@@ -35,6 +42,27 @@ static int max8907_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return 0;
 }
 
+static int max8907_bind(struct udevice *dev)
+{
+	ofnode regulators_node;
+	int children;
+
+	regulators_node = dev_read_subnode(dev, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		log_err("%s regulators subnode not found!\n", dev->name);
+		return -ENXIO;
+	}
+
+	log_debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
+
+	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
+	if (!children)
+		log_err("%s - no child found\n", dev->name);
+
+	/* Always return success for this device */
+	return 0;
+}
+
 static struct dm_pmic_ops max8907_ops = {
 	.read = max8907_read,
 	.write = max8907_write,
@@ -49,5 +77,6 @@ U_BOOT_DRIVER(pmic_max8907) = {
 	.name = "max8907_pmic",
 	.id = UCLASS_PMIC,
 	.of_match = max8907_ids,
+	.bind = max8907_bind,
 	.ops = &max8907_ops,
 };
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index bec2d2d7d49..8d971ed708a 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -141,6 +141,15 @@ config SPL_REGULATOR_PWM
 	  This config enables implementation of driver-model regulator uclass
 	  features for PWM regulators in SPL.
 
+config DM_REGULATOR_MAX8907
+	bool "Enable Driver Model for REGULATOR MAX8907"
+	depends on DM_REGULATOR && DM_PMIC_MAX8907
+	---help---
+	This config enables implementation of driver-model regulator uclass
+	features for REGULATOR MAX8907. The driver supports both DC-to-DC
+	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
+	found in MAX8907 PMIC and implements get/set api for value and enable.
+
 config DM_REGULATOR_MAX77663
 	bool "Enable Driver Model for REGULATOR MAX77663"
 	depends on DM_REGULATOR && DM_PMIC_MAX77663
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 99affa235f3..c8d17a7ed1e 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_$(PHASE_)REGULATOR_AXP) += axp_regulator.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_DA9063) += da9063.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX77663) += max77663_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX8907) += max8907_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_PFUZE100) += pfuze100.o
diff --git a/drivers/power/regulator/max8907_regulator.c b/drivers/power/regulator/max8907_regulator.c
new file mode 100644
index 00000000000..00ecd4b808b
--- /dev/null
+++ b/drivers/power/regulator/max8907_regulator.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/max8907.h>
+
+static const char max8907_regmap[] = {
+	0x00, MAX8907_REG_SDCTL1, MAX8907_REG_SDCTL2, MAX8907_REG_SDCTL3,
+	 MAX8907_REG_LDOCTL1,  MAX8907_REG_LDOCTL2,  MAX8907_REG_LDOCTL3,
+	 MAX8907_REG_LDOCTL4,  MAX8907_REG_LDOCTL5,  MAX8907_REG_LDOCTL6,
+	 MAX8907_REG_LDOCTL7,  MAX8907_REG_LDOCTL8,  MAX8907_REG_LDOCTL9,
+	MAX8907_REG_LDOCTL10, MAX8907_REG_LDOCTL11, MAX8907_REG_LDOCTL12,
+	MAX8907_REG_LDOCTL13, MAX8907_REG_LDOCTL14, MAX8907_REG_LDOCTL15,
+	MAX8907_REG_LDOCTL16, MAX8907_REG_LDOCTL17, MAX8907_REG_LDOCTL18,
+	MAX8907_REG_LDOCTL19, MAX8907_REG_LDOCTL20
+};
+
+static int max8907_enable(struct udevice *dev, int op, bool *enable)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	int val, ret = 0;
+
+	if (op == PMIC_OP_GET) {
+		val = pmic_reg_read(dev->parent, uc_pdata->ctrl_reg);
+		if (val < 0)
+			return val;
+
+		if (val & MAX8907_MASK_LDO_EN)
+			*enable = true;
+		else
+			*enable = false;
+	} else if (op == PMIC_OP_SET) {
+		if (*enable) {
+			ret = pmic_clrsetbits(dev->parent,
+					      uc_pdata->ctrl_reg,
+					      MAX8907_MASK_LDO_EN |
+					      MAX8907_MASK_LDO_SEQ,
+					      MAX8907_MASK_LDO_EN |
+					      MAX8907_MASK_LDO_SEQ);
+		} else {
+			ret = pmic_clrsetbits(dev->parent,
+					      uc_pdata->ctrl_reg,
+					      MAX8907_MASK_LDO_EN |
+					      MAX8907_MASK_LDO_SEQ,
+					      MAX8907_MASK_LDO_SEQ);
+		}
+	}
+
+	return ret;
+}
+
+static int max8907_get_enable(struct udevice *dev)
+{
+	bool enable = false;
+	int ret;
+
+	ret = max8907_enable(dev, PMIC_OP_GET, &enable);
+	if (ret)
+		return ret;
+
+	return enable;
+}
+
+static int max8907_set_enable(struct udevice *dev, bool enable)
+{
+	return max8907_enable(dev, PMIC_OP_SET, &enable);
+}
+
+/**
+ * max8907_volt2hex() - convert voltage in uV into
+ *			applicable to register hex value
+ *
+ * @idx:	regulator index
+ * @uV:		voltage in uV
+ *
+ * Return: voltage in hex on success, -ve on failure
+ */
+static int max8907_volt2hex(int idx, int uV)
+{
+	switch (idx) {
+	case 1: /* SD1 */
+		if (uV > SD1_VOLT_MAX || uV < SD1_VOLT_MIN)
+			break;
+
+		return (uV - SD1_VOLT_MIN) / SD1_VOLT_STEP;
+
+	case 2: /* SD2 */
+		if (uV > SD2_VOLT_MAX || uV < SD2_VOLT_MIN)
+			break;
+
+		return (uV - SD2_VOLT_MIN) / SD2_VOLT_STEP;
+
+	case 3: /* SD3 */
+		if (uV > SD2_VOLT_MAX || uV < SD2_VOLT_MIN)
+			break;
+
+		return (uV - SD2_VOLT_MIN) / SD2_VOLT_STEP;
+
+	case 5: /* LDO2 */
+	case 6: /* LDO3 */
+	case 20: /* LDO17 */
+	case 21: /* LDO18 */
+		if (uV > LDO_650_VOLT_MAX || uV < LDO_650_VOLT_MIN)
+			break;
+
+		return (uV - LDO_650_VOLT_MIN) / LDO_650_VOLT_STEP;
+
+	default: /* LDO1, 4..16, 19..20 */
+		if (uV > LDO_750_VOLT_MAX || uV < LDO_750_VOLT_MIN)
+			break;
+
+		return (uV - LDO_750_VOLT_MIN) / LDO_750_VOLT_STEP;
+	};
+
+	return -EINVAL;
+}
+
+/**
+ * max8907_hex2volt() - convert register hex value into
+ *			actual voltage in uV
+ *
+ * @idx:	regulator index
+ * @hex:	hex value of register
+ *
+ * Return: voltage in uV on success, -ve on failure
+ */
+static int max8907_hex2volt(int idx, int hex)
+{
+	switch (idx) {
+	case 1:
+		return hex * SD1_VOLT_STEP + SD1_VOLT_MIN;
+
+	case 2:
+		return hex * SD2_VOLT_STEP + SD2_VOLT_MIN;
+
+	case 3:
+		return hex * SD3_VOLT_STEP + SD3_VOLT_MIN;
+
+	case 5: /* LDO2 */
+	case 6: /* LDO3 */
+	case 20: /* LDO17 */
+	case 21: /* LDO18 */
+		return hex * LDO_650_VOLT_STEP + LDO_650_VOLT_MIN;
+
+	default: /* LDO1, 4..16, 19..20 */
+		return hex * LDO_750_VOLT_STEP + LDO_750_VOLT_MIN;
+	};
+
+	return -EINVAL;
+}
+
+static int max8907_val(struct udevice *dev, int op, int *uV)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	int idx = dev->driver_data;
+	int hex, ret;
+
+	if (op == PMIC_OP_GET) {
+		hex = pmic_reg_read(dev->parent, uc_pdata->volt_reg);
+		if (hex < 0)
+			return hex;
+
+		*uV = 0;
+
+		ret = max8907_hex2volt(idx, hex);
+		if (ret < 0)
+			return ret;
+		*uV = ret;
+
+		return 0;
+	}
+
+	hex = max8907_volt2hex(idx, *uV);
+	if (hex < 0)
+		return hex;
+
+	return pmic_reg_write(dev->parent, uc_pdata->volt_reg, hex);
+}
+
+static int max8907_get_value(struct udevice *dev)
+{
+	int uV;
+	int ret;
+
+	ret = max8907_val(dev, PMIC_OP_GET, &uV);
+	if (ret)
+		return ret;
+
+	return uV;
+}
+
+static int max8907_set_value(struct udevice *dev, int uV)
+{
+	return max8907_val(dev, PMIC_OP_SET, &uV);
+}
+
+static const struct dm_regulator_ops max8907_regulator_ops = {
+	.get_value  = max8907_get_value,
+	.set_value  = max8907_set_value,
+	.get_enable = max8907_get_enable,
+	.set_enable = max8907_set_enable,
+};
+
+static int max8907_sd_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	int idx = dev->driver_data;
+
+	uc_pdata->type = REGULATOR_TYPE_BUCK;
+	uc_pdata->ctrl_reg = max8907_regmap[idx];
+	uc_pdata->volt_reg = uc_pdata->ctrl_reg + MAX8907_VOUT;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(max8907_sd) = {
+	.name = MAX8907_SD_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &max8907_regulator_ops,
+	.probe = max8907_sd_probe,
+};
+
+static int max8907_ldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata =
+					dev_get_uclass_plat(dev);
+	/* LDO regulator id is shifted by number for SD regulators */
+	int idx = dev->driver_data + 3;
+
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+	uc_pdata->ctrl_reg = max8907_regmap[idx];
+	uc_pdata->volt_reg = uc_pdata->ctrl_reg + MAX8907_VOUT;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(max8907_ldo) = {
+	.name = MAX8907_LDO_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &max8907_regulator_ops,
+	.probe = max8907_ldo_probe,
+};
diff --git a/include/power/max8907.h b/include/power/max8907.h
new file mode 100644
index 00000000000..a19b25f44c0
--- /dev/null
+++ b/include/power/max8907.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright(C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef _MAX8907_H_
+#define _MAX8907_H_
+
+#define MAX8907_LDO_NUM			20
+#define MAX8907_SD_NUM			3
+
+/* Drivers name */
+#define MAX8907_LDO_DRIVER		"max8907_ldo"
+#define MAX8907_SD_DRIVER		"max8907_sd"
+
+/* MAX8907 register map */
+#define MAX8907_REG_SDCTL1		0x04
+#define MAX8907_REG_SDCTL2		0x07
+#define MAX8907_REG_SDCTL3		0x0A
+
+#define MAX8907_REG_LDOCTL16		0x10
+#define MAX8907_REG_LDOCTL17		0x14
+#define MAX8907_REG_LDOCTL1		0x18
+#define MAX8907_REG_LDOCTL2		0x1C
+#define MAX8907_REG_LDOCTL3		0x20
+#define MAX8907_REG_LDOCTL4		0x24
+#define MAX8907_REG_LDOCTL5		0x28
+#define MAX8907_REG_LDOCTL6		0x2C
+#define MAX8907_REG_LDOCTL7		0x30
+#define MAX8907_REG_LDOCTL8		0x34
+#define MAX8907_REG_LDOCTL9		0x38
+#define MAX8907_REG_LDOCTL10		0x3C
+#define MAX8907_REG_LDOCTL11		0x40
+#define MAX8907_REG_LDOCTL12		0x44
+#define MAX8907_REG_LDOCTL13		0x48
+#define MAX8907_REG_LDOCTL14		0x4C
+#define MAX8907_REG_LDOCTL15		0x50
+#define MAX8907_REG_LDOCTL19		0x5C
+#define MAX8907_REG_LDOCTL18		0x72
+#define MAX8907_REG_LDOCTL20		0x9C
+
+/* MAX8907 configuration values */
+#define MAX8907_CTL			0
+#define MAX8907_SEQCNT			1
+#define MAX8907_VOUT			2
+
+/* mask bit fields */
+#define MAX8907_MASK_LDO_SEQ		0x1C
+#define MAX8907_MASK_LDO_EN		0x01
+
+/* Step-Down (SD) Regulator calculations */
+#define SD1_VOLT_MAX			2225000
+#define SD1_VOLT_MIN			650000
+#define SD1_VOLT_STEP			25000
+
+#define SD2_VOLT_MAX			1425000
+#define SD2_VOLT_MIN			637500
+#define SD2_VOLT_STEP			12500
+
+#define SD3_VOLT_MAX			3900000
+#define SD3_VOLT_MIN			750000
+#define SD3_VOLT_STEP			50000
+
+/* Low-Dropout Linear (LDO) Regulator calculations */
+#define LDO_750_VOLT_MAX		3900000
+#define LDO_750_VOLT_MIN		750000
+#define LDO_750_VOLT_STEP		50000
+
+#define LDO_650_VOLT_MAX		2225000
+#define LDO_650_VOLT_MIN		650000
+#define LDO_650_VOLT_STEP		25000
+
+#endif /* _MAX8907_H_ */
-- 
2.43.0

