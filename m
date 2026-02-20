Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B02C5AD57
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 19:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D1D83DEB;
	Fri, 20 Feb 2026 20:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NHMOvI5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DE1B83DC9; Fri, 20 Feb 2026 20:34:02 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E4983C39
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463960df4f9so1466136b6e.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771616037; x=1772220837;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jvt5JwbunROfM9WlRyo6ciQET3RlwdkGTedGz1nklBQ=;
 b=NHMOvI5FkzhVeOnbUzXCPS9m8kyKlIvXYmyIUcN8LihjvuPsqAivSHQ5M4QYNLEjAu
 p4p8XWO0BFpWQT5AEbF2fiRxf14AFUKBj3McenFrSpPHZxBJNoNHWAk9CHanEP29nrOX
 0hQoPGjJ5Lyhbe6o1/dIMopuCjpnZoMW4IIW8tdnhSMOHn+cuz72rzzyanboVECv0i34
 L/aZhLrRGoknRbSuFHEiTb7CLOM84t6shdsPEzVwJADM473ccgCuT8z9CCkdshK6n/EB
 Eu2Z+ciXzp4Mrh6xRrfIQ33wEWSdP6U6Mft7QfpqLfcSMSQYT3Mq5eVgjzu1d4tQWS4y
 rIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616037; x=1772220837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jvt5JwbunROfM9WlRyo6ciQET3RlwdkGTedGz1nklBQ=;
 b=XTpMcisQv+L9GqeQ4YqbfGwPwrQc86VzrjHsj1VjuGdQqRjJLrr6P5MvDMB3d3ikJV
 I9tIqODEufgnbXUvAVdEPRDaCHjmN6oJ2P6S69pLlwdCLD4bxvfXvC3zRTkwU82YK9DE
 dDIBIk3chMtILhfU+cWSXWySibhYHYToqhcA/R9mqtOL0mQjquqnfMiWlYAS9pEGN9QR
 gwNFyCt9MlzCyyjsc5KtgNI1eiNU8U8CDtPgvegS+oPqvPNUyFkSInvYeF5FEzT/suQb
 +6GE9L5FVe4agtFW7er8zPH9PWJyncDVyk1J+p/a1eFEKqI6eO8Gj1QQthEywk2ZE4B5
 09FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz1ijM+2TcjkRZFjRWOE+mNlqwJWk5LExr+5bOp1+3a2ARnkw4GzxEEp3RiN+i8dZAYeldOfU=@lists.denx.de
X-Gm-Message-State: AOJu0YwjP7TmoIzSUgj+k7oYZ8h4Xz3uftMSC9ztXB98tnttZ/z9xkav
 RtFe2NbP3gf38AMt346PztQIw3GxZpjh1SxdaVh9nOFfowYb8V+tJtzSVbzkHUjvh5Q=
X-Gm-Gg: AZuq6aIBD4MK0uLBTeposfdptfQV9giOGA0MzxzvuZA6P9N+xqtukWe011OqsSrbY52
 65XnowY351NLGzxZ3NHrkwG2SIH4DVyGSGK7GkELi+4yeun1CPA7UKLpIEs017/6tzgF7pV3a7M
 jSk4QO8nhJuHVALe/z1wjwvAVwESb9XtAlEdPFLogAvnmfAoGEWHRnK4R3yzWFsB2mGF2GIebwW
 BiE2ifEcaudKX6V2hYOxiTAmyAkcIVQzMJuJSqnnwSLFdZX5sui8X66V4UAgQAnAvaaMaDymSJK
 vDTzIeoZjg9AE4kSUIhdDMtAAIhhTq/UzL/g4GTLsifKZ/xUchPZs0aAdWClt2A9/zsQNzt0Wpp
 N9emGViZfknfgmOKt2JCPeLeOWEzOEodwSzbKtLouJghdkIzi+5QXWng/UKNwpp8rQKPZrBSCwn
 0S7MixZlZ/tkbUc1we2IfdCRVAydE=
X-Received: by 2002:a05:6808:6718:b0:45e:e15e:4ab2 with SMTP id
 5614622812f47-464463a0bccmr635739b6e.45.1771616037144; 
 Fri, 20 Feb 2026 11:33:57 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:339f:eabc:8753:3aa4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm52370b6e.6.2026.02.20.11.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 11:33:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Feb 2026 13:33:03 -0600
Subject: [PATCH 1/4] power: regulator: add MediaTek MT6357 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-mtk-pmic-pwrap-support-v1-1-a345ea3b4294@baylibre.com>
References: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
In-Reply-To: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=22575;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=9yuMSWmyDZMgjgXHaFtzpZEQ2zeBDZaqvenLp2ECLDg=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpmLcGZegmoHPatDI6LwGmkCQJrduXZkRQ2Z489
 oezKGhLt56JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZi3BhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnhUIAIBruoaXeQTk0hhYptdlgAluqr8+FUO4oe+emeu
 O5ZsmKxNpiMTk87RWkKoHVBzFcEw96pV8e4KBHteS5zHOlgQAJjkrs0Gm9czGYaU6mQoozCVVEN
 rqZHyzH3+krtnQRCvx1gU7uAAJUVsuGhJ3IDJudr2OULz5jDl7Jq0ewSK1qxzLouApChKvxUaYg
 4+gT2+/Cpo/QzXBOjUXgp1jyADOMxlY7nVojZkvc4K/P6GHAk9rzyYHV0l9DeGYu4v6wTRZVUdJ
 re/KaMBCiWsIrtnRCQRoWaS/X2DefWGaCgyCtBlCYgSgVV0/S3dor//cHjH2nzaGMnA0yki6/ZS
 SOHU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Julien Masson <jmasson@baylibre.com>

Add a driver for the power regulators of the MediaTek MT6357 PMIC chip.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Co-developed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS                                |   2 +
 drivers/power/regulator/Kconfig            |   9 +
 drivers/power/regulator/Makefile           |   1 +
 drivers/power/regulator/mt6357_regulator.c | 512 +++++++++++++++++++++++++++++
 include/power/mt6357.h                     | 159 +++++++++
 5 files changed, 683 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 288b892f19b..479d328f50d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -432,6 +432,7 @@ F:	drivers/net/phy/mediatek/
 F:	drivers/phy/phy-mtk-*
 F:	drivers/pinctrl/mediatek/
 F:	drivers/power/domain/mtk-power-domain.c
+F:	drivers/power/regulator/mt*.c
 F:	drivers/pci/pcie_mediatek_gen3.c
 F:	drivers/pci/pcie_mediatek.c
 F:	drivers/pwm/pwm-mtk.c
@@ -448,6 +449,7 @@ F:	drivers/reset/reset-mediatek.c
 F:	drivers/serial/serial_mtk.c
 F:	include/dt-bindings/clock/mediatek,*
 F:	include/dt-bindings/power/mediatek,*
+F:	include/power/mt*.h
 F:	tools/mtk_image.c
 F:	tools/mtk_image.h
 F:	tools/mtk_nand_headers.c
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index bd9ccd26981..60f20213bad 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -521,3 +521,12 @@ config DM_REGULATOR_CPCAP
 	REGULATOR CPCAP. The driver supports both DC-to-DC Step-Down Switching
 	(SW) Regulators and Low-Dropout Linear (LDO) Regulators	found in CPCAP
 	PMIC and implements get/set api for voltage and state.
+
+config DM_REGULATOR_MT6357
+	bool "Enable driver for MediaTek MT6357 PMIC regulators"
+	depends on DM_REGULATOR && DM_PMIC_MTK_PWRAP
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6357 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index ee8f56ea3b9..72acea28859 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_$(PHASE_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
 obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
+obj-$(CONFIG_DM_REGULATOR_MT6357) += mt6357_regulator.o
diff --git a/drivers/power/regulator/mt6357_regulator.c b/drivers/power/regulator/mt6357_regulator.c
new file mode 100644
index 00000000000..533cc22b93a
--- /dev/null
+++ b/drivers/power/regulator/mt6357_regulator.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MT6357 regulator driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm.h>
+#include <power/regulator.h>
+#include <power/mt6357.h>
+#include <power/pmic.h>
+
+enum mt6357_regulator_type {
+	MT6357_REG_TYPE_RANGE,
+	MT6357_REG_TYPE_TABLE,
+	MT6357_REG_TYPE_FIXED,
+};
+
+struct mt6357_linear_range {
+	unsigned int min;
+	unsigned int min_sel;
+	unsigned int max_sel;
+	unsigned int step;
+};
+
+struct mt6357_regulator_desc {
+	const char *name;
+	const char *of_match;
+	enum mt6357_regulator_type type;
+	int id;
+	unsigned int n_voltages;
+	const unsigned int *volt_table;
+	const struct mt6357_linear_range *linear_ranges;
+	int n_linear_ranges;
+	unsigned int min_uV;
+	unsigned int vsel_reg;
+	unsigned int vsel_mask;
+	unsigned int enable_reg;
+	unsigned int enable_mask;
+};
+
+struct mt6357_regulator_info {
+	struct mt6357_regulator_desc desc;
+	const u32 *index_table;
+	unsigned int n_table;
+	u32 vsel_shift;
+	u32 da_vsel_reg;
+	u32 da_vsel_mask;
+	u32 da_vsel_shift;
+};
+
+/* Initialize struct mt6357_linear_range for regulators */
+#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
+{									\
+	.min		= _min_uV,					\
+	.min_sel	= _min_sel,					\
+	.max_sel	= _max_sel,					\
+	.step		= _step_uV,					\
+}
+
+#define MT6357_BUCK(match, vreg, min, max, step,			\
+		    volt_ranges, vosel_reg, vosel_mask, _da_vsel_mask)	\
+	[MT6357_ID_##vreg] = {						\
+		.desc = {						\
+			.name = #vreg,					\
+			.of_match = of_match_ptr(match),		\
+			.type = MT6357_REG_TYPE_RANGE,			\
+			.id = MT6357_ID_##vreg,				\
+			.n_voltages = ((max) - (min)) / (step) + 1,	\
+			.linear_ranges = volt_ranges,			\
+			.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+			.vsel_reg = vosel_reg,				\
+			.vsel_mask = vosel_mask,			\
+			.enable_reg = MT6357_BUCK_##vreg##_CON0,	\
+			.enable_mask = BIT(0),				\
+		},							\
+		.da_vsel_reg = MT6357_BUCK_##vreg##_DBG0,		\
+		.da_vsel_mask = _da_vsel_mask,				\
+		.da_vsel_shift = 0,					\
+	}
+
+#define MT6357_LDO(match, vreg, ldo_volt_table,				\
+		   ldo_index_table, enreg, vosel,			\
+		   vosel_mask)						\
+	[MT6357_ID_##vreg] = {						\
+		.desc = {						\
+			.name = #vreg,					\
+			.of_match = of_match_ptr(match),		\
+			.type = MT6357_REG_TYPE_TABLE,			\
+			.id = MT6357_ID_##vreg,				\
+			.n_voltages = ARRAY_SIZE(ldo_volt_table),	\
+			.volt_table = ldo_volt_table,			\
+			.vsel_reg = vosel,				\
+			.vsel_mask = vosel_mask << 8,			\
+			.enable_reg = enreg,				\
+			.enable_mask = BIT(0),				\
+		},							\
+		.index_table = ldo_index_table,				\
+		.n_table = ARRAY_SIZE(ldo_index_table),			\
+	}
+
+#define MT6357_LDO1(match, vreg, min, max, step, volt_ranges,		\
+		    enreg, vosel, vosel_mask)				\
+	[MT6357_ID_##vreg] = {						\
+		.desc = {						\
+			.name = #vreg,					\
+			.of_match = of_match_ptr(match),		\
+			.type = MT6357_REG_TYPE_RANGE,			\
+			.id = MT6357_ID_##vreg,				\
+			.n_voltages = ((max) - (min)) / (step) + 1,	\
+			.linear_ranges = volt_ranges,			\
+			.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+			.vsel_reg = vosel,				\
+			.vsel_mask = vosel_mask,			\
+			.enable_reg = enreg,				\
+			.enable_mask = BIT(0),				\
+		},							\
+		.da_vsel_reg = MT6357_LDO_##vreg##_DBG0,		\
+		.da_vsel_mask = 0x7f,					\
+		.da_vsel_shift = 8,					\
+	}
+
+#define MT6357_REG_FIXED(match, vreg, volt)				\
+	[MT6357_ID_##vreg] = {						\
+		.desc = {						\
+			.name = #vreg,					\
+			.of_match = of_match_ptr(match),		\
+			.type = MT6357_REG_TYPE_FIXED,			\
+			.id = MT6357_ID_##vreg,				\
+			.n_voltages = 1,				\
+			.enable_reg = MT6357_LDO_##vreg##_CON0,		\
+			.enable_mask = BIT(0),				\
+			.min_uV = volt,					\
+		},							\
+	}
+
+static int mt6357_range_find_value(const struct mt6357_linear_range *r,
+				   unsigned int sel,
+				   unsigned int *val)
+{
+	if (!val || sel < r->min_sel || sel > r->max_sel)
+		return -EINVAL;
+
+	*val = r->min + r->step * (sel - r->min_sel);
+
+	return 0;
+}
+
+static int mt6357_range_find_selector(const struct mt6357_linear_range *r,
+				      int val, unsigned int *sel)
+{
+	int num_vals = r->max_sel - r->min_sel + 1;
+	int ret = -EINVAL;
+
+	if (val >= r->min && val <= r->min + r->step * (num_vals - 1)) {
+		if (r->step) {
+			*sel = r->min_sel + ((val - r->min) / r->step);
+			ret = 0;
+		} else {
+			*sel = r->min_sel;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+
+static int mt6357_get_enable(struct udevice *dev)
+{
+	struct mt6357_regulator_info *info = dev_get_priv(dev);
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, info->desc.enable_reg);
+	if (ret < 0)
+		return ret;
+
+	return ret & info->desc.enable_mask ? true : false;
+}
+
+static int mt6357_set_enable(struct udevice *dev, bool enable)
+{
+	struct mt6357_regulator_info *info = dev_get_priv(dev);
+
+	return pmic_clrsetbits(dev->parent, info->desc.enable_reg,
+			       info->desc.enable_mask,
+			       enable ? info->desc.enable_mask : 0);
+}
+
+static int mt6357_get_value(struct udevice *dev)
+{
+	struct mt6357_regulator_info *info = dev_get_priv(dev);
+	unsigned int val_uV;
+	int selector, idx, ret;
+	const u32 *pvol;
+
+	switch (info->desc.type) {
+	case MT6357_REG_TYPE_RANGE:
+		selector = pmic_reg_read(dev->parent, info->da_vsel_reg);
+		if (selector < 0)
+			return selector;
+
+		selector = (selector & info->da_vsel_mask) >> info->da_vsel_shift;
+		ret = mt6357_range_find_value(info->desc.linear_ranges, selector, &val_uV);
+		if (ret < 0)
+			return ret;
+
+		return val_uV;
+	case MT6357_REG_TYPE_TABLE:
+		selector = pmic_reg_read(dev->parent, info->desc.vsel_reg);
+		if (selector < 0)
+			return selector;
+
+		selector = (selector & info->desc.vsel_mask) >> 8;
+		pvol = info->index_table;
+
+		for (idx = 0; idx < info->desc.n_voltages; idx++) {
+			if (pvol[idx] == selector)
+				return info->desc.volt_table[idx];
+		}
+
+		return -EINVAL;
+	case MT6357_REG_TYPE_FIXED:
+		return info->desc.min_uV;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt6357_set_value(struct udevice *dev, int uvolt)
+{
+	struct mt6357_regulator_info *info = dev_get_priv(dev);
+	int selector, idx, ret;
+	const u32 *pvol;
+
+	switch (info->desc.type) {
+	case MT6357_REG_TYPE_RANGE:
+		ret = mt6357_range_find_selector(info->desc.linear_ranges, uvolt,
+						 &selector);
+		if (ret < 0)
+			return ret;
+
+		return pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
+				       info->desc.vsel_mask, selector);
+	case MT6357_REG_TYPE_TABLE:
+		pvol = info->desc.volt_table;
+
+		for (idx = 0; idx < info->desc.n_voltages; idx++) {
+			if (pvol[idx] == uvolt) {
+				selector = info->index_table[idx];
+
+				return pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
+						       info->desc.vsel_mask, selector << 8);
+			}
+		}
+
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const int vxo22_voltages[] = {
+	2200000,
+	2400000,
+};
+
+static const int vefuse_voltages[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+	2800000,
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vcn33_voltages[] = {
+	3300000,
+	3400000,
+	3500000,
+};
+
+static const int vcama_voltages[] = {
+	2500000,
+	2800000,
+};
+
+static const int vcamd_voltages[] = {
+	1000000,
+	1100000,
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+};
+
+static const int vldo28_voltages[] = {
+	2800000,
+	3000000,
+};
+
+static const int vdram_voltages[] = {
+	1100000,
+	1200000,
+};
+
+static const int vsim_voltages[] = {
+	1700000,
+	1800000,
+	2700000,
+	3000000,
+	3100000,
+};
+
+static const int vibr_voltages[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+	2000000,
+	2800000,
+	3000000,
+	3300000,
+};
+
+static const int vmc_voltages[] = {
+	1800000,
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vmch_voltages[] = {
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vemc_voltages[] = {
+	2900000,
+	3000000,
+	3300000,
+};
+
+static const int vusb_voltages[] = {
+	3000000,
+	3100000,
+};
+
+static const int vmc_idx[] = {
+	4, 10, 11, 13,
+};
+
+static const int vmch_idx[] = {
+	2, 3, 5,
+};
+
+static const int vemc_idx[] = {
+	2, 3, 5,
+};
+
+static const int vusb_idx[] = {
+	3, 4,
+};
+
+static const int vxo22_idx[] = {
+	0, 2,
+};
+
+static const int vefuse_idx[] = {
+	0, 1, 2, 4, 9, 10, 11, 13,
+};
+
+static const int vcn33_idx[] = {
+	1, 2, 3,
+};
+
+static const int vcama_idx[] = {
+	7, 10,
+};
+
+static const int vcamd_idx[] = {
+	4, 5, 6, 7, 9, 12,
+};
+
+static const int vldo28_idx[] = {
+	1, 3,
+};
+
+static const int vdram_idx[] = {
+	1, 2,
+};
+
+static const int vsim_idx[] = {
+	3, 4, 8, 11, 12,
+};
+
+static const int vibr_idx[] = {
+	0, 1, 2, 4, 5, 9, 11, 13,
+};
+
+static const struct mt6357_linear_range buck_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(518750, 0, 0x7f, 6250),
+};
+
+static const struct mt6357_linear_range buck_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
+};
+
+static const struct mt6357_linear_range buck_volt_range3[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
+};
+
+static const struct mt6357_linear_range buck_volt_range4[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 0x7f, 12500),
+};
+
+/* The array is indexed by id(MT6357_ID_XXX) */
+static struct mt6357_regulator_info mt6357_regulators[] = {
+	/* Bucks */
+	MT6357_BUCK("buck-vcore", VCORE, 518750, 1312500, 6250,
+		    buck_volt_range1, MT6357_BUCK_VCORE_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vproc", VPROC, 518750, 1312500, 6250,
+		    buck_volt_range1, MT6357_BUCK_VPROC_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vmodem", VMODEM, 500000, 1293750, 6250,
+		    buck_volt_range2, MT6357_BUCK_VMODEM_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vpa", VPA, 500000, 3650000, 50000,
+		    buck_volt_range3, MT6357_BUCK_VPA_CON1, 0x3f, 0x3f),
+	MT6357_BUCK("buck-vs1", VS1, 1200000, 2787500, 12500,
+		    buck_volt_range4, MT6357_BUCK_VS1_ELR0, 0x7f, 0x7f),
+
+	/* LDOs */
+	MT6357_LDO("ldo-vcama", VCAMA, vcama_voltages, vcama_idx,
+		   MT6357_LDO_VCAMA_CON0, MT6357_VCAMA_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vcamd", VCAMD, vcamd_voltages, vcamd_idx,
+		   MT6357_LDO_VCAMD_CON0, MT6357_VCAMD_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vcn33-bt", VCN33_BT, vcn33_voltages, vcn33_idx,
+		   MT6357_LDO_VCN33_CON0_0, MT6357_VCN33_ANA_CON0, 0x3),
+	MT6357_LDO("ldo-vcn33-wifi", VCN33_WIFI, vcn33_voltages, vcn33_idx,
+		   MT6357_LDO_VCN33_CON0_1, MT6357_VCN33_ANA_CON0, 0x3),
+	MT6357_LDO("ldo-vdram", VDRAM, vdram_voltages, vdram_idx,
+		   MT6357_LDO_VDRAM_CON0, MT6357_VDRAM_ELR_2, 0x3),
+	MT6357_LDO("ldo-vefuse", VEFUSE, vefuse_voltages, vefuse_idx,
+		   MT6357_LDO_VEFUSE_CON0, MT6357_VEFUSE_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vemc", VEMC, vemc_voltages, vemc_idx,
+		   MT6357_LDO_VEMC_CON0, MT6357_VEMC_ANA_CON0, 0x7),
+	MT6357_LDO("ldo-vibr", VIBR, vibr_voltages, vibr_idx,
+		   MT6357_LDO_VIBR_CON0, MT6357_VIBR_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vldo28", VLDO28, vldo28_voltages, vldo28_idx,
+		   MT6357_LDO_VLDO28_CON0_0, MT6357_VLDO28_ANA_CON0, 0x3),
+	MT6357_LDO("ldo-vmc", VMC, vmc_voltages, vmc_idx,
+		   MT6357_LDO_VMC_CON0, MT6357_VMC_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vmch", VMCH, vmch_voltages, vmch_idx,
+		   MT6357_LDO_VMCH_CON0, MT6357_VMCH_ANA_CON0, 0x7),
+	MT6357_LDO("ldo-vsim1", VSIM1, vsim_voltages, vsim_idx,
+		   MT6357_LDO_VSIM1_CON0, MT6357_VSIM1_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vsim2", VSIM2, vsim_voltages, vsim_idx,
+		   MT6357_LDO_VSIM2_CON0, MT6357_VSIM2_ANA_CON0, 0xf),
+	MT6357_LDO("ldo-vusb33", VUSB33, vusb_voltages, vusb_idx,
+		   MT6357_LDO_VUSB33_CON0_0, MT6357_VUSB33_ANA_CON0, 0x7),
+	MT6357_LDO("ldo-vxo22", VXO22, vxo22_voltages, vxo22_idx,
+		   MT6357_LDO_VXO22_CON0, MT6357_VXO22_ANA_CON0, 0x3),
+
+	MT6357_LDO1("ldo-vsram-proc", VSRAM_PROC, 518750, 1312500, 6250,
+		    buck_volt_range1, MT6357_LDO_VSRAM_PROC_CON0,
+		    MT6357_LDO_VSRAM_CON0, 0x7f),
+	MT6357_LDO1("ldo-vsram-others", VSRAM_OTHERS, 518750, 1312500, 6250,
+		    buck_volt_range1, MT6357_LDO_VSRAM_OTHERS_CON0,
+		    MT6357_LDO_VSRAM_CON1, 0x7f),
+
+	MT6357_REG_FIXED("ldo-vaud28", VAUD28, 2800000),
+	MT6357_REG_FIXED("ldo-vaux18", VAUX18, 1800000),
+	MT6357_REG_FIXED("ldo-vcamio18", VCAMIO, 1800000),
+	MT6357_REG_FIXED("ldo-vcn18", VCN18, 1800000),
+	MT6357_REG_FIXED("ldo-vcn28", VCN28, 2800000),
+	MT6357_REG_FIXED("ldo-vfe28", VFE28, 2800000),
+	MT6357_REG_FIXED("ldo-vio18", VIO18, 1800000),
+	MT6357_REG_FIXED("ldo-vio28", VIO28, 2800000),
+	MT6357_REG_FIXED("ldo-vrf12", VRF12, 1200000),
+	MT6357_REG_FIXED("ldo-vrf18", VRF18, 1800000),
+};
+
+static int mt6357_regulator_probe(struct udevice *dev)
+{
+	struct mt6357_regulator_info *priv = dev_get_priv(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mt6357_regulators); i++) {
+		if (!strcmp(dev->name, mt6357_regulators[i].desc.of_match)) {
+			*priv = mt6357_regulators[i];
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops mt6357_regulator_ops = {
+	.get_value  = mt6357_get_value,
+	.set_value  = mt6357_set_value,
+	.get_enable = mt6357_get_enable,
+	.set_enable = mt6357_set_enable,
+};
+
+U_BOOT_DRIVER(mt6357_regulator) = {
+	.name	   = MT6357_REGULATOR_DRIVER,
+	.id	   = UCLASS_REGULATOR,
+	.ops	   = &mt6357_regulator_ops,
+	.probe	   = mt6357_regulator_probe,
+	.priv_auto = sizeof(struct mt6357_regulator_info),
+};
diff --git a/include/power/mt6357.h b/include/power/mt6357.h
new file mode 100644
index 00000000000..b7ee9d64386
--- /dev/null
+++ b/include/power/mt6357.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#ifndef _REGULATOR_MT6357_H_
+#define _REGULATOR_MT6357_H_
+
+#define MT6357_REGULATOR_DRIVER	"mt6357_regulator"
+
+enum {
+	/* Bucks */
+	MT6357_ID_VCORE,
+	MT6357_ID_VMODEM,
+	MT6357_ID_VPA,
+	MT6357_ID_VPROC,
+	MT6357_ID_VS1,
+
+	/* LDOs */
+	MT6357_ID_VAUX18,
+	MT6357_ID_VAUD28,
+	MT6357_ID_VCAMA,
+	MT6357_ID_VCAMD,
+	MT6357_ID_VCAMIO,
+	MT6357_ID_VCN18,
+	MT6357_ID_VCN28,
+	MT6357_ID_VCN33_BT,
+	MT6357_ID_VCN33_WIFI,
+	MT6357_ID_VDRAM,
+	MT6357_ID_VEFUSE,
+	MT6357_ID_VEMC,
+	MT6357_ID_VFE28,
+	MT6357_ID_VIBR,
+	MT6357_ID_VIO18,
+	MT6357_ID_VIO28,
+	MT6357_ID_VLDO28,
+	MT6357_ID_VMC,
+	MT6357_ID_VMCH,
+	MT6357_ID_VRF12,
+	MT6357_ID_VRF18,
+	MT6357_ID_VSIM1,
+	MT6357_ID_VSIM2,
+	MT6357_ID_VSRAM_OTHERS,
+	MT6357_ID_VSRAM_PROC,
+	MT6357_ID_VUSB33,
+	MT6357_ID_VXO22,
+};
+
+/* PMIC Registers */
+#define MT6357_BUCK_TOP_CLK_CON0		0x140c
+#define MT6357_BUCK_TOP_CLK_HWEN_CON0		0x1412
+#define MT6357_BUCK_TOP_CLK_MISC_CON0		0x1418
+#define MT6357_BUCK_TOP_INT_CON0		0x141a
+#define MT6357_BUCK_TOP_INT_MASK_CON0		0x1420
+#define MT6357_BUCK_TOP_SLP_CON0		0x142c
+#define MT6357_BUCK_TOP_OC_CON0			0x1434
+#define MT6357_BUCK_TOP_K_CON0			0x1436
+#define MT6357_BUCK_VPROC_CON0			0x1488
+#define MT6357_BUCK_VPROC_DBG0			0x14a2
+#define MT6357_BUCK_VPROC_ELR0			0x14aa
+#define MT6357_BUCK_VCORE_CON0			0x1508
+#define MT6357_BUCK_VCORE_DBG0			0x1522
+#define MT6357_BUCK_VCORE_ELR0			0x152a
+#define MT6357_BUCK_VMODEM_CON0			0x1588
+#define MT6357_BUCK_VMODEM_DBG0			0x15a2
+#define MT6357_BUCK_VMODEM_ELR0			0x15aa
+#define MT6357_BUCK_VS1_CON0			0x1608
+#define MT6357_BUCK_VS1_DBG0			0x1622
+#define MT6357_BUCK_VS1_ELR0			0x1632
+#define MT6357_BUCK_VPA_CON0			0x1688
+#define MT6357_BUCK_VPA_CON1			0x168a
+#define MT6357_BUCK_VPA_DBG0			0x1692
+#define MT6357_BUCK_VPA_DLC_CON0		0x1698
+#define MT6357_BUCK_VPA_MSFG_CON0		0x169e
+#define MT6357_LDO_TOP_CLK_DCM_CON0		0x188c
+#define MT6357_LDO_TOP_CLK_VIO28_CON0		0x188e
+#define MT6357_LDO_TOP_CLK_VIO18_CON0		0x1890
+#define MT6357_LDO_TOP_CLK_VAUD28_CON0		0x1892
+#define MT6357_LDO_TOP_CLK_VDRAM_CON0		0x1894
+#define MT6357_LDO_TOP_CLK_VSRAM_PROC_CON0	0x1896
+#define MT6357_LDO_TOP_CLK_VSRAM_OTHERS_CON0	0x1898
+#define MT6357_LDO_TOP_CLK_VAUX18_CON0		0x189a
+#define MT6357_LDO_TOP_CLK_VUSB33_CON0		0x189c
+#define MT6357_LDO_TOP_CLK_VEMC_CON0		0x189e
+#define MT6357_LDO_TOP_CLK_VXO22_CON0		0x18a0
+#define MT6357_LDO_TOP_CLK_VSIM1_CON0		0x18a2
+#define MT6357_LDO_TOP_CLK_VSIM2_CON0		0x18a4
+#define MT6357_LDO_TOP_CLK_VCAMD_CON0		0x18a6
+#define MT6357_LDO_TOP_CLK_VCAMIO_CON0		0x18a8
+#define MT6357_LDO_TOP_CLK_VEFUSE_CON0		0x18aa
+#define MT6357_LDO_TOP_CLK_VCN33_CON0		0x18ac
+#define MT6357_LDO_TOP_CLK_VCN18_CON0		0x18ae
+#define MT6357_LDO_TOP_CLK_VCN28_CON0		0x18b0
+#define MT6357_LDO_TOP_CLK_VIBR_CON0		0x18b2
+#define MT6357_LDO_TOP_CLK_VFE28_CON0		0x18b4
+#define MT6357_LDO_TOP_CLK_VMCH_CON0		0x18b6
+#define MT6357_LDO_TOP_CLK_VMC_CON0		0x18b8
+#define MT6357_LDO_TOP_CLK_VRF18_CON0		0x18ba
+#define MT6357_LDO_TOP_CLK_VLDO28_CON0		0x18bc
+#define MT6357_LDO_TOP_CLK_VRF12_CON0		0x18be
+#define MT6357_LDO_TOP_CLK_VCAMA_CON0		0x18c0
+#define MT6357_LDO_TOP_CLK_TREF_CON0		0x18c2
+#define MT6357_LDO_TOP_INT_CON0			0x18c4
+#define MT6357_LDO_TOP_INT_MASK_CON0		0x18d0
+#define MT6357_LDO_TEST_CON0			0x18e4
+#define MT6357_LDO_TOP_WDT_CON0			0x18e6
+#define MT6357_LDO_TOP_RSV_CON0			0x18e8
+#define MT6357_LDO_VXO22_CON0			0x1908
+#define MT6357_LDO_VAUX18_CON0			0x191c
+#define MT6357_LDO_VAUD28_CON0			0x1930
+#define MT6357_LDO_VIO28_CON0			0x1944
+#define MT6357_LDO_VIO18_CON0			0x1958
+#define MT6357_LDO_VDRAM_CON0			0x196c
+#define MT6357_LDO_VEMC_CON0			0x1988
+#define MT6357_LDO_VUSB33_CON0_0		0x199c
+#define MT6357_LDO_VSRAM_PROC_CON0		0x19b2
+#define MT6357_LDO_VSRAM_PROC_DBG0		0x19cc
+#define MT6357_LDO_VSRAM_OTHERS_CON0		0x19d0
+#define MT6357_LDO_VSRAM_OTHERS_DBG0		0x19ea
+#define MT6357_LDO_VSRAM_WDT_DBG0		0x19f6
+#define MT6357_LDO_VSRAM_CON0			0x19fa
+#define MT6357_LDO_VSRAM_CON1			0x19fc
+#define MT6357_LDO_VFE28_CON0			0x1a08
+#define MT6357_LDO_VRF18_CON0			0x1a1c
+#define MT6357_LDO_VRF12_CON0			0x1a30
+#define MT6357_LDO_VEFUSE_CON0			0x1a44
+#define MT6357_LDO_VCN18_CON0			0x1a58
+#define MT6357_LDO_VCAMA_CON0			0x1a6c
+#define MT6357_LDO_VCAMD_CON0			0x1a88
+#define MT6357_LDO_VCAMIO_CON0			0x1a9c
+#define MT6357_LDO_VMC_CON0			0x1ab0
+#define MT6357_LDO_VMCH_CON0			0x1ac4
+#define MT6357_LDO_VSIM1_CON0			0x1ad8
+#define MT6357_LDO_VSIM2_CON0			0x1aec
+#define MT6357_LDO_VIBR_CON0			0x1b08
+#define MT6357_LDO_VCN33_CON0_0			0x1b1c
+#define MT6357_LDO_VCN33_CON0_1			0x1b2a
+#define MT6357_LDO_VLDO28_CON0_0		0x1b32
+#define MT6357_LDO_GOFF2_RSV_CON0		0x1b48
+#define MT6357_LDO_VCN28_CON0			0x1b88
+#define MT6357_LDO_TREF_CON0			0x1b9e
+#define MT6357_LDO_GOFF3_RSV_CON0		0x1bae
+#define MT6357_VXO22_ANA_CON0			0x1c18
+#define MT6357_VCN33_ANA_CON0			0x1c1c
+#define MT6357_VEMC_ANA_CON0			0x1c20
+#define MT6357_VLDO28_ANA_CON0			0x1c24
+#define MT6357_VIBR_ANA_CON0			0x1c2c
+#define MT6357_VSIM1_ANA_CON0			0x1c30
+#define MT6357_VSIM2_ANA_CON0			0x1c34
+#define MT6357_VMCH_ANA_CON0			0x1c38
+#define MT6357_VMC_ANA_CON0			0x1c3c
+#define MT6357_VUSB33_ANA_CON0			0x1c88
+#define MT6357_VCAMA_ANA_CON0			0x1c8c
+#define MT6357_VEFUSE_ANA_CON0			0x1c90
+#define MT6357_VCAMD_ANA_CON0			0x1c94
+#define MT6357_VDRAM_ELR_2			0x1cac
+
+#endif

-- 
2.43.0

