Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A2EE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A57787239;
	Tue,  3 Oct 2023 08:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DEMeMiC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38429870BB; Tue,  3 Oct 2023 08:29:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB0F871B9
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5041cc983f9so587359e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314592; x=1696919392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OO3ZwahjOR5yAJKI7TdybD2mMXIYhgOSrEOQo04RxeM=;
 b=DEMeMiC451OSeDn/FvWmxOpquEphDHu5ZKZibg8LT6rMjORcejWzZKnA60HtGoLdzz
 xUDPyo3qksNTCE0TSmZZYF5RpZmJ5sBF24GdfXZ4NB++PaEu8FAjxSGKKqogW4DxMLTn
 Hl1sja2Jxeni2vw9S8yk2Dn8X5xtYjymXsYUILyopDjks2dvIzkCa3dvIvIKphVfkWzf
 FKry4LmesXCu12iZG1lA57kq72BAJOaIPEj0m/c7EWxCLShr8/aTNZJrKac4wYspEILh
 8WXOUfRRlDI1sH4+oS0FMM/CWhmViK2S8crIHdwrK3jS5ZhiQNmh60DF6wiSftW1Fh/a
 nEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314592; x=1696919392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OO3ZwahjOR5yAJKI7TdybD2mMXIYhgOSrEOQo04RxeM=;
 b=MG6fPB18soxyKU4+QgtJOwyw9fzSujvd4/R82SsZJj519fhzg9CLh9aVD5VwAc7Z4y
 /Mpl0uNQrkZbTJzOk0g1KyLSsUEYT4k2pSIa9T3w0hmSbaTsXyZP7u8mIX5eHXrbMlKA
 ZwMyKGPN1KKGirJTCRJdzYVhot/UVrNwWIWvnZCDgxoIZTBb4PoNKwIuL3vZk2tSpsM0
 yr6+XNge149HWXWm39D0QaSl71le38x9vRlH1if9uDjMd7ALxexj0QX/upAQi3CDwrUl
 S8bnqxnu67zDknl3+hhwwxP5A2AHoNXYao6Mi8jKaAhFCrEdjMWhay0B7iVBmZ6bBvTg
 31Qw==
X-Gm-Message-State: AOJu0YwOPbC6JTA2m37ufZvtzIGdl/N45aQhAChZrtP+VR1b0ajC46az
 LSNwANO1cDHaI4YYVoxzK3c=
X-Google-Smtp-Source: AGHT+IGbb90MRzE52kHzr3gxGB2fkwilwZ73V1zNpW42TalcwE5J0i78EbV6m6Xx6KEToUOLyArxYw==
X-Received: by 2002:ac2:5f9a:0:b0:4fb:780d:2a49 with SMTP id
 r26-20020ac25f9a000000b004fb780d2a49mr9654732lfe.5.1696314592355; 
 Mon, 02 Oct 2023 23:29:52 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 j27-20020ac253bb000000b005009aa86582sm78583lfh.55.2023.10.02.23.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:29:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 4/8] power: regulator: max77663: add regulator support
Date: Tue,  3 Oct 2023 09:29:37 +0300
Message-Id: <20231003062941.42501-5-clamor95@gmail.com>
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

