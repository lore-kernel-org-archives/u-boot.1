Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE89BC5AD69
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 19:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB9183AC5;
	Fri, 20 Feb 2026 20:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QC76Zter";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAAE83D0F; Fri, 20 Feb 2026 20:34:05 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECFF83D17
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-4638fe85a7eso891775b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771616038; x=1772220838;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+32/AILsQfp6qlZkc7U6kHeWLL8rqstKglmpWI4Hdrw=;
 b=QC76Zterkl35kPFOSw8E+TPNha7csRFuzCw9eO4bK+ZXDmy0qaCpAUHh+oVpIQnKln
 GPwjwWdRUlNpb6iVDiLMnc8QlFF3wPyUIWyS5fdzQALNtduQlkgiOR/Rb6dNXvNmo2k+
 EUXDU4jcQzzC/5iQt+iKECkcaJxTERS45fWBCUyUkt8NI76oOIjAEqKIjeG+gVlihvIW
 ymqB/tWAHnjBhv4n7M9KuR8bt1p6fdjUD6YLniiRGRquXi1AYPKab20MloMNk1AxHZo7
 dX47g3VCIo63RSwmSV+nERTGgJzADP/NtGPTdnMCJXeTCQj3qyzpWtefOpopqHmXNZ4L
 IVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616038; x=1772220838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+32/AILsQfp6qlZkc7U6kHeWLL8rqstKglmpWI4Hdrw=;
 b=pfmd9fOdtfMorlTaw7iV/038NCHftQ6O+hWk9HC95ZjkdBnf9pynQvP+bnrbRIeP4u
 ZZfWTaVRaqk8S0Gj1GKHPeuMo5BoL4VpRM/IB4+j/2u8aoPBErWv6UU/a4plauYs9vCA
 SX5HbF5qzoYnsaBK+6xVFcQrAHRl/SSHCLz0y2/N57ptJn76Hos5UUngQHFWP4kL1Ui1
 v+U864WfOcHtp0cMNQeDnwL5RLHj3y2ol/FOXeqEt++Odtln/Ab/BViT7mMAteNbXYLP
 w33IMGgX9WpaMQlLcGZHcpUbJoyPBa1vbw7VjkfEhc1yY2AHr8t+xLdeReoVbb53bxIQ
 +M/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaqMsiyZneu/v/ZScHoGXaLyWcJF/oosOgrK2fRAyAchEjFHkjBuUOJNbti2zANiFqdlf9h5s=@lists.denx.de
X-Gm-Message-State: AOJu0YzUwCwhTlPVEF/hmfDwgV+CSdHhYsZaB3oK3Frtur/Jbd1YXZu8
 TWqrZVbUn1B3OM04tlVc/btPeXPwbY9KYCrY0zrrZxUabLHBGlL/S4d7wyiy06f/vUo=
X-Gm-Gg: AZuq6aLvwMFpgrbV5SNXj+gxiIuPF4eBmTQcKBdV+bYgs0kbl0hVYntCR9+NCFm5D4z
 lDh0zG/Sxm5TRfoP8Dfx4C9ElP5dskig33nqwZrxFrfkO9CPsiGG3Q3OtGxJXD0KuULcVXMgqY3
 awmXA/bolDQJOgbE5m53+565qpEuRDnm3wYptXl2FMHZpfWE3tYXUnWOLEutDrguV/0b5y2gIRk
 zE8rHfzr3U3eXOd8ClajPcM8e1lxIaoAwtGyxiNmR9mFVZTupjiRK5Rp3GTxY/y8TtDYcHzaqPs
 191ph10RUHIViBRuq/JxLhLe/2h8i5Nrd0cPSNZeUuowg4r2UPoZ77O1EBEIbF1Dzd5+rWa7N2I
 66a+mUFfCLXgEPo0gZIlW5WBWVn/ptgqq8KW15yeis5XOd5xRFXPjjLuSXjVCbBkyuLbxNcFLZs
 eQH91wSCBC0ZGauQKvir2QsFckRWk=
X-Received: by 2002:a05:6808:1315:b0:45f:8be:d983 with SMTP id
 5614622812f47-4644614133dmr660817b6e.12.1771616038104; 
 Fri, 20 Feb 2026 11:33:58 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:339f:eabc:8753:3aa4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm52370b6e.6.2026.02.20.11.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 11:33:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Feb 2026 13:33:04 -0600
Subject: [PATCH 2/4] power: regulator: mt6359: add driver for MT6359P
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-mtk-pmic-pwrap-support-v1-2-a345ea3b4294@baylibre.com>
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
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=48652;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=SH95ttX6tU7ABObf/vPGz4O+ho/VwPzeTF50tnQGAFQ=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpmLcNayxCg0ArgWRBiLYhtJ+cQD+qr1FpbuuCo
 +QJKofwHaaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZi3DRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUC8H+wVkc9gK88HSIoLXoynPS4POKEpCp3Pt8TR45lf
 d7fklX7vJho0q03tM8onlyvg1HvVb1IwEGq7S2sAT3lTsO8PlmT/lA5/tuNSdDkBzW8fbW3MMdW
 AX3nXMkECFPJNI+rSOiwz/VL9ULmt5xrFW1Ca6wxnltpeDfQ6T033MwCsgM6L07ItlQyDMDllgK
 Gm6Jv4HH/sKGmlEqpDdI/vciwapFzkv2ty8MQgKd28s8ZZmy8g7tr2xy/MuRcF8JBIFp1enyei0
 m1Nh+z0KUOt1qLggszq7K/qwdSvYVJy1z10ts3bpDK8X8y0v7K8ujGE/FQMKiXZC0KzUSshilZc
 ujCo=
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

From: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Add a new regulator driver for MT6359P and similar PMIC chips.

The MT6359P is a eco version for MT6359 regulator. For the MT8391
platform, we use the MT6359P (MT6365) as the main PMIC. The MT6359 and
MT6359P have different register maps. Therefore, on the MT8391 platform,
we only provide support for the MT6359P. If support for the MT6359 PMIC
it can be added later.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/regulator/Kconfig            |   9 +
 drivers/power/regulator/Makefile           |   1 +
 drivers/power/regulator/mt6359_regulator.c | 711 +++++++++++++++++++++++++++++
 include/power/mt6359.h                     | 225 +++++++++
 include/power/mt6359p.h                    | 230 ++++++++++
 5 files changed, 1176 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 60f20213bad..2c982873a92 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -530,3 +530,12 @@ config DM_REGULATOR_MT6357
 	  MediaTek MT6357 PMIC.
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
+
+config DM_REGULATOR_MT6359
+	bool "Enable driver for MediaTek MT6359 PMIC regulators"
+	depends on DM_REGULATOR && DM_PMIC_MTK_PWRAP
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6359 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 72acea28859..9e303d4f7f8 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
 obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MT6357) += mt6357_regulator.o
+obj-$(CONFIG_DM_REGULATOR_MT6359) += mt6359_regulator.o
diff --git a/drivers/power/regulator/mt6359_regulator.c b/drivers/power/regulator/mt6359_regulator.c
new file mode 100644
index 00000000000..cdafcfcb25e
--- /dev/null
+++ b/drivers/power/regulator/mt6359_regulator.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 MediaTek Inc. All Rights Reserved.
+ * Author: Bo-Chen Chen <rex-bc.chen@mediatek.com>
+ */
+
+#include <dm.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <power/mt6359.h>
+#include <power/mt6359p.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#include <dm/device.h>
+#include <dm/device_compat.h>
+
+enum mt6359_regulator_type {
+	MT6359_REG_TYPE_LINEAR,
+	MT6359_REG_TYPE_TABLE,
+	MT6359_REG_TYPE_FIXED,
+	MT6359_REG_TYPE_VEMC,
+};
+
+struct regulator_desc {
+	const char *name;
+	const char *of_match;
+	enum mt6359_regulator_type type;
+	int id;
+	unsigned int uV_step;
+	unsigned int n_voltages;
+	const unsigned int *volt_table;
+	unsigned int min_uV;
+	unsigned int vsel_reg;
+	unsigned int vsel_mask;
+	unsigned int enable_reg;
+	unsigned int enable_mask;
+	unsigned int fixed_uV;
+};
+
+/*
+ * MT6359 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @status_reg: for query status of regulators.
+ * @qi: Mask for query enable signal status of regulators.
+ * @modeset_reg: for operating AUTO/PWM mode register.
+ * @modeset_mask: MASK for operating modeset register.
+ */
+struct mt6359_regulator_info {
+	struct regulator_desc desc;
+	u32 status_reg;
+	u32 qi;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 lp_mode_reg;
+	u32 lp_mode_mask;
+};
+
+#define MT6359_BUCK(match, _name, _min, _max, _step,		\
+	_enable_reg, _status_reg,				\
+	_vsel_reg, _vsel_mask,					\
+	_lp_mode_reg, _lp_mode_shift,				\
+	_modeset_reg, _modeset_shift)				\
+[MT6359_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.type = MT6359_REG_TYPE_LINEAR,			\
+		.id = MT6359_ID_##_name,			\
+		.uV_step = (_step),				\
+		.n_voltages = ((_max) - (_min)) / (_step) + 1,	\
+		.min_uV = (_min),				\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(0),				\
+	},							\
+	.status_reg = _status_reg,				\
+	.qi = BIT(0),						\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(_lp_mode_shift),			\
+	.modeset_reg = _modeset_reg,				\
+	.modeset_mask = BIT(_modeset_shift),			\
+}
+
+#define MT6359_LDO_LINEAR(match, _name, _min, _max, _step,	\
+	_enable_reg, _status_reg, _vsel_reg, _vsel_mask)	\
+[MT6359_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.type = MT6359_REG_TYPE_LINEAR,			\
+		.id = MT6359_ID_##_name,			\
+		.uV_step = (_step),				\
+		.n_voltages = ((_max) - (_min)) / (_step) + 1,	\
+		.min_uV = (_min),				\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(0),				\
+	},							\
+	.status_reg = _status_reg,				\
+	.qi = BIT(0),						\
+}
+
+#define MT6359_LDO(match, _name, _tmp_volt_table,		\
+	_enable_reg, _enable_mask, _status_reg,			\
+	_vsel_reg, _vsel_mask, _en_delay)			\
+[MT6359_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.type = MT6359_REG_TYPE_TABLE,			\
+		.id = MT6359_ID_##_name,			\
+		.n_voltages = ARRAY_SIZE(_tmp_volt_table),	\
+		.volt_table = _tmp_volt_table,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(_enable_mask),		\
+	},							\
+	.status_reg = _status_reg,				\
+	.qi = BIT(0),						\
+}
+
+#define MT6359_REG_FIXED(match, _name, _enable_reg,		\
+	_status_reg, _fixed_volt)				\
+[MT6359_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.type = MT6359_REG_TYPE_FIXED,			\
+		.id = MT6359_ID_##_name,			\
+		.n_voltages = 1,				\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(0),				\
+		.fixed_uV = (_fixed_volt),			\
+	},							\
+	.status_reg = _status_reg,				\
+	.qi = BIT(0),						\
+}
+
+#define MT6359P_LDO1(match, _name, _type, _tmp_volt_table,	\
+	_enable_reg, _enable_mask, _status_reg,			\
+	_vsel_reg, _vsel_mask)					\
+[MT6359_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.type = _type,					\
+		.id = MT6359_ID_##_name,			\
+		.n_voltages = ARRAY_SIZE(_tmp_volt_table),	\
+		.volt_table = _tmp_volt_table,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(_enable_mask),		\
+	},							\
+	.status_reg = _status_reg,				\
+	.qi = BIT(0),						\
+}
+
+static const unsigned int vsim1_voltages[] = {
+	0, 0, 0, 1700000, 1800000, 0, 0, 0, 2700000, 0, 0, 3000000, 3100000,
+};
+
+static const unsigned int vibr_voltages[] = {
+	1200000, 1300000, 1500000, 0, 1800000, 2000000, 0, 0, 2700000, 2800000,
+	0, 3000000, 0, 3300000,
+};
+
+static const unsigned int vrf12_voltages[] = {
+	0, 0, 1100000, 1200000,	1300000,
+};
+
+static const unsigned int volt18_voltages[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1700000, 1800000, 1900000,
+};
+
+static const unsigned int vcn13_voltages[] = {
+	900000, 1000000, 0, 1200000, 1300000,
+};
+
+static const unsigned int vcn33_voltages[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 2800000, 0, 0, 0, 3300000, 3400000, 3500000,
+};
+
+static const unsigned int vefuse_voltages[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1700000, 1800000, 1900000, 2000000,
+};
+
+static const unsigned int vxo22_voltages[] = {
+	1800000, 0, 0, 0, 2200000,
+};
+
+static const unsigned int vrfck_voltages_1[] = {
+	1240000, 1600000,
+};
+
+static const unsigned int vio28_voltages[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 2800000, 2900000, 3000000, 3100000, 3300000,
+};
+
+static const unsigned int vemc_voltages_1[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 2500000, 2800000, 2900000, 3000000, 3100000,
+	3300000,
+};
+
+static const unsigned int va12_voltages[] = {
+	0, 0, 0, 0, 0, 0, 1200000, 1300000,
+};
+
+static const unsigned int va09_voltages[] = {
+	0, 0, 800000, 900000, 0, 0, 1200000,
+};
+
+static const unsigned int vrf18_voltages[] = {
+	0, 0, 0, 0, 0, 1700000, 1800000, 1810000,
+};
+
+static const unsigned int vbbck_voltages[] = {
+	0, 0, 0, 0, 1100000, 0, 0, 0, 1150000, 0, 0, 0, 1200000,
+};
+
+static const unsigned int vsim2_voltages[] = {
+	0, 0, 0, 1700000, 1800000, 0, 0, 0, 2700000, 0, 0, 3000000, 3100000,
+};
+
+static int mt6359_set_voltage_sel_regmap(struct udevice *dev,
+					 struct mt6359_regulator_info *info,
+					 unsigned int sel)
+{
+	sel <<= ffs(info->desc.vsel_mask) - 1;
+
+	return pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
+			       info->desc.vsel_mask, sel);
+}
+
+static int mt6359p_vemc_set_voltage_sel(struct udevice *dev,
+					struct mt6359_regulator_info *info, unsigned int sel)
+{
+	int ret;
+
+	sel <<= ffs(info->desc.vsel_mask) - 1;
+	ret = pmic_reg_write(dev->parent, MT6359P_TMA_KEY_ADDR, MT6359P_TMA_KEY);
+	if (ret)
+		return ret;
+
+	ret = pmic_reg_read(dev->parent, MT6359P_VM_MODE_ADDR);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case 0:
+		/* If HW trapping is 0, use VEMC_VOSEL_0 */
+		ret = pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
+				      info->desc.vsel_mask, sel);
+		if (ret)
+			return ret;
+
+		break;
+	case 1:
+		/* If HW trapping is 1, use VEMC_VOSEL_1 */
+		ret = pmic_clrsetbits(dev->parent, info->desc.vsel_reg + 0x2,
+				      info->desc.vsel_mask, sel);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return pmic_reg_write(dev->parent, MT6359P_TMA_KEY_ADDR, 0);
+}
+
+static int mt6359_get_voltage_sel(struct udevice *dev, struct mt6359_regulator_info *info)
+{
+	int selector;
+
+	selector = pmic_reg_read(dev->parent, info->desc.vsel_reg);
+	if (selector < 0)
+		return selector;
+
+	selector &= info->desc.vsel_mask;
+	selector >>= ffs(info->desc.vsel_mask) - 1;
+
+	return selector;
+}
+
+static int mt6359p_vemc_get_voltage_sel(struct udevice *dev, struct mt6359_regulator_info *info)
+{
+	int selector;
+
+	switch (pmic_reg_read(dev->parent, MT6359P_VM_MODE_ADDR)) {
+	case 0:
+		/* If HW trapping is 0, use VEMC_VOSEL_0 */
+		selector = pmic_reg_read(dev->parent, info->desc.vsel_reg);
+		break;
+	case 1:
+		/* If HW trapping is 1, use VEMC_VOSEL_1 */
+		selector = pmic_reg_read(dev->parent, info->desc.vsel_reg + 0x2);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (selector < 0)
+		return selector;
+
+	selector &= info->desc.vsel_mask;
+	selector >>= ffs(info->desc.vsel_mask) - 1;
+
+	return selector;
+}
+
+static int mt6359_get_enable(struct udevice *dev)
+{
+	struct mt6359_regulator_info *info = dev_get_priv(dev);
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, info->desc.enable_reg);
+	if (ret < 0)
+		return ret;
+
+	return ret & info->desc.enable_mask ? true : false;
+}
+
+static int mt6359_set_enable(struct udevice *dev, bool enable)
+{
+	struct mt6359_regulator_info *info = dev_get_priv(dev);
+
+	return pmic_clrsetbits(dev->parent, info->desc.enable_reg,
+			       info->desc.enable_mask,
+			       enable ? info->desc.enable_mask : 0);
+}
+
+static int mt6359_get_value(struct udevice *dev)
+{
+	struct mt6359_regulator_info *info = dev_get_priv(dev);
+	int selector;
+
+	switch (info->desc.type) {
+	case MT6359_REG_TYPE_LINEAR:
+		/* Get selection */
+		selector = mt6359_get_voltage_sel(dev, info);
+		if (selector < 0)
+			return -EINVAL;
+
+		/* Get voltage value */
+		if (selector >= info->desc.n_voltages)
+			return -EINVAL;
+
+		return info->desc.min_uV + (info->desc.uV_step * selector);
+	case MT6359_REG_TYPE_TABLE:
+		/* Get selection */
+		selector = mt6359_get_voltage_sel(dev, info);
+		if (selector < 0)
+			return -EINVAL;
+
+		/* Get voltage value */
+		if (!info->desc.volt_table) {
+			dev_err(dev, "invalid voltage table for %s\n", info->desc.name);
+			return -EINVAL;
+		}
+
+		if (selector >= info->desc.n_voltages)
+			return -EINVAL;
+
+		return info->desc.volt_table[selector];
+	case MT6359_REG_TYPE_FIXED:
+		return info->desc.fixed_uV;
+	case MT6359_REG_TYPE_VEMC:
+		/* Get selection */
+		selector = mt6359p_vemc_get_voltage_sel(dev, info);
+		if (selector < 0)
+			return -EINVAL;
+
+		/* Get voltage value */
+		if (!info->desc.volt_table) {
+			dev_err(dev, "invalid voltage table for %s\n", info->desc.name);
+			return -EINVAL;
+		}
+
+		if (selector >= info->desc.n_voltages)
+			return -EINVAL;
+
+		return info->desc.volt_table[selector];
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt6359_set_value(struct udevice *dev, int uvolt)
+{
+	struct mt6359_regulator_info *info = dev_get_priv(dev);
+	int selector;
+	int i;
+
+	switch (info->desc.type) {
+	case MT6359_REG_TYPE_LINEAR:
+		/* Find selection */
+		if (uvolt < info->desc.min_uV)
+			return -EINVAL;
+		selector = DIV_ROUND_UP(uvolt - info->desc.min_uV, info->desc.uV_step);
+		if (selector < 0)
+			return -EINVAL;
+
+		/* Set selection */
+		return mt6359_set_voltage_sel_regmap(dev, info, selector);
+	case MT6359_REG_TYPE_TABLE:
+		/* Find selection */
+		for (i = 0; i < info->desc.n_voltages; i++) {
+			if (info->desc.volt_table[i] == uvolt)
+				return mt6359_set_voltage_sel_regmap(dev, info, i);
+		}
+
+		return -EINVAL;
+	case MT6359_REG_TYPE_VEMC:
+		/* Find selection */
+		for (i = 0; i < info->desc.n_voltages; i++) {
+			if (info->desc.volt_table[i] == uvolt)
+				return mt6359p_vemc_set_voltage_sel(dev, info, i);
+		}
+
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct mt6359_regulator_info mt6359p_regulators[] = {
+	MT6359_BUCK("buck_vs1", VS1, 800000, 2200000, 12500,
+		    MT6359_RG_BUCK_VS1_EN_ADDR,
+		    MT6359_DA_VS1_EN_ADDR, MT6359_RG_BUCK_VS1_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VS1_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VS1_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VS1_LP_ADDR, MT6359_RG_BUCK_VS1_LP_SHIFT,
+		    MT6359_RG_VS1_FPWM_ADDR, MT6359_RG_VS1_FPWM_SHIFT),
+	MT6359_BUCK("buck_vgpu11", VGPU11, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VGPU11_EN_ADDR,
+		    MT6359_DA_VGPU11_EN_ADDR, MT6359P_RG_BUCK_VGPU11_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VGPU11_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VGPU11_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VGPU11_LP_ADDR,
+		    MT6359_RG_BUCK_VGPU11_LP_SHIFT,
+		    MT6359_RG_VGPU11_FCCM_ADDR, MT6359_RG_VGPU11_FCCM_SHIFT),
+	MT6359_BUCK("buck_vmodem", VMODEM, 400000, 1100000, 6250,
+		    MT6359_RG_BUCK_VMODEM_EN_ADDR,
+		    MT6359_DA_VMODEM_EN_ADDR, MT6359_RG_BUCK_VMODEM_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VMODEM_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VMODEM_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VMODEM_LP_ADDR,
+		    MT6359_RG_BUCK_VMODEM_LP_SHIFT,
+		    MT6359_RG_VMODEM_FCCM_ADDR, MT6359_RG_VMODEM_FCCM_SHIFT),
+	MT6359_BUCK("buck_vpu", VPU, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPU_EN_ADDR,
+		    MT6359_DA_VPU_EN_ADDR, MT6359_RG_BUCK_VPU_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VPU_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VPU_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VPU_LP_ADDR, MT6359_RG_BUCK_VPU_LP_SHIFT,
+		    MT6359_RG_VPU_FCCM_ADDR, MT6359_RG_VPU_FCCM_SHIFT),
+	MT6359_BUCK("buck_vcore", VCORE, 506250, 1300000, 6250,
+		    MT6359_RG_BUCK_VCORE_EN_ADDR,
+		    MT6359_DA_VCORE_EN_ADDR, MT6359P_RG_BUCK_VCORE_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VCORE_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VCORE_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VCORE_LP_ADDR, MT6359_RG_BUCK_VCORE_LP_SHIFT,
+		    MT6359_RG_VCORE_FCCM_ADDR, MT6359_RG_VCORE_FCCM_SHIFT),
+	MT6359_BUCK("buck_vs2", VS2, 800000, 1600000, 12500,
+		    MT6359_RG_BUCK_VS2_EN_ADDR,
+		    MT6359_DA_VS2_EN_ADDR, MT6359_RG_BUCK_VS2_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VS2_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VS2_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VS2_LP_ADDR, MT6359_RG_BUCK_VS2_LP_SHIFT,
+		    MT6359_RG_VS2_FPWM_ADDR, MT6359_RG_VS2_FPWM_SHIFT),
+	MT6359_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
+		    MT6359_RG_BUCK_VPA_EN_ADDR,
+		    MT6359_DA_VPA_EN_ADDR, MT6359_RG_BUCK_VPA_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VPA_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VPA_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VPA_LP_ADDR, MT6359_RG_BUCK_VPA_LP_SHIFT,
+		    MT6359_RG_VPA_MODESET_ADDR, MT6359_RG_VPA_MODESET_SHIFT),
+	MT6359_BUCK("buck_vproc2", VPROC2, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPROC2_EN_ADDR,
+		    MT6359_DA_VPROC2_EN_ADDR, MT6359_RG_BUCK_VPROC2_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VPROC2_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VPROC2_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VPROC2_LP_ADDR,
+		    MT6359_RG_BUCK_VPROC2_LP_SHIFT,
+		    MT6359_RG_VPROC2_FCCM_ADDR, MT6359_RG_VPROC2_FCCM_SHIFT),
+	MT6359_BUCK("buck_vproc1", VPROC1, 400000, 1193750, 6250,
+		    MT6359_RG_BUCK_VPROC1_EN_ADDR,
+		    MT6359_DA_VPROC1_EN_ADDR, MT6359_RG_BUCK_VPROC1_VOSEL_ADDR,
+		    MT6359_RG_BUCK_VPROC1_VOSEL_MASK <<
+		    MT6359_RG_BUCK_VPROC1_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VPROC1_LP_ADDR,
+		    MT6359_RG_BUCK_VPROC1_LP_SHIFT,
+		    MT6359_RG_VPROC1_FCCM_ADDR, MT6359_RG_VPROC1_FCCM_SHIFT),
+	MT6359_BUCK("buck_vgpu11_sshub", VGPU11_SSHUB, 400000, 1193750, 6250,
+		    MT6359P_RG_BUCK_VGPU11_SSHUB_EN_ADDR,
+		    MT6359_DA_VGPU11_EN_ADDR,
+		    MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_ADDR,
+		    MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_MASK <<
+		    MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_SHIFT,
+		    MT6359_RG_BUCK_VGPU11_LP_ADDR,
+		    MT6359_RG_BUCK_VGPU11_LP_SHIFT,
+		    MT6359_RG_VGPU11_FCCM_ADDR, MT6359_RG_VGPU11_FCCM_SHIFT),
+	MT6359_REG_FIXED("ldo_vaud18", VAUD18, MT6359P_RG_LDO_VAUD18_EN_ADDR,
+			 MT6359P_DA_VAUD18_B_EN_ADDR, 1800000),
+	MT6359_LDO("ldo_vsim1", VSIM1, vsim1_voltages,
+		   MT6359P_RG_LDO_VSIM1_EN_ADDR, MT6359P_RG_LDO_VSIM1_EN_SHIFT,
+		   MT6359P_DA_VSIM1_B_EN_ADDR, MT6359P_RG_VSIM1_VOSEL_ADDR,
+		   MT6359_RG_VSIM1_VOSEL_MASK << MT6359_RG_VSIM1_VOSEL_SHIFT,
+		   480),
+	MT6359_LDO("ldo_vibr", VIBR, vibr_voltages,
+		   MT6359P_RG_LDO_VIBR_EN_ADDR, MT6359P_RG_LDO_VIBR_EN_SHIFT,
+		   MT6359P_DA_VIBR_B_EN_ADDR, MT6359P_RG_VIBR_VOSEL_ADDR,
+		   MT6359_RG_VIBR_VOSEL_MASK << MT6359_RG_VIBR_VOSEL_SHIFT,
+		   240),
+	MT6359_LDO("ldo_vrf12", VRF12, vrf12_voltages,
+		   MT6359P_RG_LDO_VRF12_EN_ADDR, MT6359P_RG_LDO_VRF12_EN_SHIFT,
+		   MT6359P_DA_VRF12_B_EN_ADDR, MT6359P_RG_VRF12_VOSEL_ADDR,
+		   MT6359_RG_VRF12_VOSEL_MASK << MT6359_RG_VRF12_VOSEL_SHIFT,
+		   480),
+	MT6359_REG_FIXED("ldo_vusb", VUSB, MT6359P_RG_LDO_VUSB_EN_0_ADDR,
+			 MT6359P_DA_VUSB_B_EN_ADDR, 3000000),
+	MT6359_LDO_LINEAR("ldo_vsram_proc2", VSRAM_PROC2, 500000, 1293750, 6250,
+			  MT6359P_RG_LDO_VSRAM_PROC2_EN_ADDR,
+			  MT6359P_DA_VSRAM_PROC2_B_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_PROC2_VOSEL_ADDR,
+			  MT6359_RG_LDO_VSRAM_PROC2_VOSEL_MASK <<
+			  MT6359_RG_LDO_VSRAM_PROC2_VOSEL_SHIFT),
+	MT6359_LDO("ldo_vio18", VIO18, volt18_voltages,
+		   MT6359P_RG_LDO_VIO18_EN_ADDR, MT6359P_RG_LDO_VIO18_EN_SHIFT,
+		   MT6359P_DA_VIO18_B_EN_ADDR, MT6359P_RG_VIO18_VOSEL_ADDR,
+		   MT6359_RG_VIO18_VOSEL_MASK << MT6359_RG_VIO18_VOSEL_SHIFT,
+		   960),
+	MT6359_LDO("ldo_vcamio", VCAMIO, volt18_voltages,
+		   MT6359P_RG_LDO_VCAMIO_EN_ADDR,
+		   MT6359P_RG_LDO_VCAMIO_EN_SHIFT,
+		   MT6359P_DA_VCAMIO_B_EN_ADDR, MT6359P_RG_VCAMIO_VOSEL_ADDR,
+		   MT6359_RG_VCAMIO_VOSEL_MASK << MT6359_RG_VCAMIO_VOSEL_SHIFT,
+		   1290),
+	MT6359_REG_FIXED("ldo_vcn18", VCN18, MT6359P_RG_LDO_VCN18_EN_ADDR,
+			 MT6359P_DA_VCN18_B_EN_ADDR, 1800000),
+	MT6359_REG_FIXED("ldo_vfe28", VFE28, MT6359P_RG_LDO_VFE28_EN_ADDR,
+			 MT6359P_DA_VFE28_B_EN_ADDR, 2800000),
+	MT6359_LDO("ldo_vcn13", VCN13, vcn13_voltages,
+		   MT6359P_RG_LDO_VCN13_EN_ADDR, MT6359P_RG_LDO_VCN13_EN_SHIFT,
+		   MT6359P_DA_VCN13_B_EN_ADDR, MT6359P_RG_VCN13_VOSEL_ADDR,
+		   MT6359_RG_VCN13_VOSEL_MASK << MT6359_RG_VCN13_VOSEL_SHIFT,
+		   240),
+	MT6359_LDO("ldo_vcn33_1_bt", VCN33_1_BT, vcn33_voltages,
+		   MT6359P_RG_LDO_VCN33_1_EN_0_ADDR,
+		   MT6359_RG_LDO_VCN33_1_EN_0_SHIFT,
+		   MT6359P_DA_VCN33_1_B_EN_ADDR, MT6359P_RG_VCN33_1_VOSEL_ADDR,
+		   MT6359_RG_VCN33_1_VOSEL_MASK <<
+		   MT6359_RG_VCN33_1_VOSEL_SHIFT, 240),
+	MT6359_LDO("ldo_vcn33_1_wifi", VCN33_1_WIFI, vcn33_voltages,
+		   MT6359P_RG_LDO_VCN33_1_EN_1_ADDR,
+		   MT6359P_RG_LDO_VCN33_1_EN_1_SHIFT,
+		   MT6359P_DA_VCN33_1_B_EN_ADDR, MT6359P_RG_VCN33_1_VOSEL_ADDR,
+		   MT6359_RG_VCN33_1_VOSEL_MASK <<
+		   MT6359_RG_VCN33_1_VOSEL_SHIFT, 240),
+	MT6359_REG_FIXED("ldo_vaux18", VAUX18, MT6359P_RG_LDO_VAUX18_EN_ADDR,
+			 MT6359P_DA_VAUX18_B_EN_ADDR, 1800000),
+	MT6359_LDO_LINEAR("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
+			  MT6359P_RG_LDO_VSRAM_OTHERS_EN_ADDR,
+			  MT6359P_DA_VSRAM_OTHERS_B_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_OTHERS_VOSEL_ADDR,
+			  MT6359_RG_LDO_VSRAM_OTHERS_VOSEL_MASK <<
+			  MT6359_RG_LDO_VSRAM_OTHERS_VOSEL_SHIFT),
+	MT6359_LDO("ldo_vefuse", VEFUSE, vefuse_voltages,
+		   MT6359P_RG_LDO_VEFUSE_EN_ADDR,
+		   MT6359P_RG_LDO_VEFUSE_EN_SHIFT,
+		   MT6359P_DA_VEFUSE_B_EN_ADDR, MT6359P_RG_VEFUSE_VOSEL_ADDR,
+		   MT6359_RG_VEFUSE_VOSEL_MASK << MT6359_RG_VEFUSE_VOSEL_SHIFT,
+		   240),
+	MT6359_LDO("ldo_vxo22", VXO22, vxo22_voltages,
+		   MT6359P_RG_LDO_VXO22_EN_ADDR, MT6359P_RG_LDO_VXO22_EN_SHIFT,
+		   MT6359P_DA_VXO22_B_EN_ADDR, MT6359P_RG_VXO22_VOSEL_ADDR,
+		   MT6359_RG_VXO22_VOSEL_MASK << MT6359_RG_VXO22_VOSEL_SHIFT,
+		   480),
+	MT6359_LDO("ldo_vrfck", VRFCK, vrfck_voltages_1,
+		   MT6359P_RG_LDO_VRFCK_EN_ADDR, MT6359P_RG_LDO_VRFCK_EN_SHIFT,
+		   MT6359P_DA_VRFCK_B_EN_ADDR, MT6359P_RG_VRFCK_VOSEL_ADDR,
+		   MT6359_RG_VRFCK_VOSEL_MASK << MT6359_RG_VRFCK_VOSEL_SHIFT,
+		   480),
+	MT6359_LDO("ldo_vrfck_1", VRFCK, vrfck_voltages_1,
+		   MT6359P_RG_LDO_VRFCK_EN_ADDR, MT6359P_RG_LDO_VRFCK_EN_SHIFT,
+		   MT6359P_DA_VRFCK_B_EN_ADDR, MT6359P_RG_VRFCK_VOSEL_ADDR,
+		   MT6359_RG_VRFCK_VOSEL_MASK << MT6359_RG_VRFCK_VOSEL_SHIFT,
+		   480),
+	MT6359_REG_FIXED("ldo_vbif28", VBIF28, MT6359P_RG_LDO_VBIF28_EN_ADDR,
+			 MT6359P_DA_VBIF28_B_EN_ADDR, 2800000),
+	MT6359_LDO("ldo_vio28", VIO28, vio28_voltages,
+		   MT6359P_RG_LDO_VIO28_EN_ADDR, MT6359P_RG_LDO_VIO28_EN_SHIFT,
+		   MT6359P_DA_VIO28_B_EN_ADDR, MT6359P_RG_VIO28_VOSEL_ADDR,
+		   MT6359_RG_VIO28_VOSEL_MASK << MT6359_RG_VIO28_VOSEL_SHIFT,
+		   1920),
+	MT6359P_LDO1("ldo_vemc_1", VEMC, MT6359_REG_TYPE_VEMC, vemc_voltages_1,
+		     MT6359P_RG_LDO_VEMC_EN_ADDR, MT6359P_RG_LDO_VEMC_EN_SHIFT,
+		     MT6359P_DA_VEMC_B_EN_ADDR,
+		     MT6359P_RG_LDO_VEMC_VOSEL_0_ADDR,
+		     MT6359P_RG_LDO_VEMC_VOSEL_0_MASK <<
+		     MT6359P_RG_LDO_VEMC_VOSEL_0_SHIFT),
+	MT6359_LDO("ldo_vcn33_2_bt", VCN33_2_BT, vcn33_voltages,
+		   MT6359P_RG_LDO_VCN33_2_EN_0_ADDR,
+		   MT6359P_RG_LDO_VCN33_2_EN_0_SHIFT,
+		   MT6359P_DA_VCN33_2_B_EN_ADDR, MT6359P_RG_VCN33_2_VOSEL_ADDR,
+		   MT6359_RG_VCN33_2_VOSEL_MASK <<
+		   MT6359_RG_VCN33_2_VOSEL_SHIFT, 240),
+	MT6359_LDO("ldo_vcn33_2_wifi", VCN33_2_WIFI, vcn33_voltages,
+		   MT6359P_RG_LDO_VCN33_2_EN_1_ADDR,
+		   MT6359_RG_LDO_VCN33_2_EN_1_SHIFT,
+		   MT6359P_DA_VCN33_2_B_EN_ADDR, MT6359P_RG_VCN33_2_VOSEL_ADDR,
+		   MT6359_RG_VCN33_2_VOSEL_MASK <<
+		   MT6359_RG_VCN33_2_VOSEL_SHIFT, 240),
+	MT6359_LDO("ldo_va12", VA12, va12_voltages,
+		   MT6359P_RG_LDO_VA12_EN_ADDR, MT6359P_RG_LDO_VA12_EN_SHIFT,
+		   MT6359P_DA_VA12_B_EN_ADDR, MT6359P_RG_VA12_VOSEL_ADDR,
+		   MT6359_RG_VA12_VOSEL_MASK << MT6359_RG_VA12_VOSEL_SHIFT,
+		   960),
+	MT6359_LDO("ldo_va09", VA09, va09_voltages,
+		   MT6359P_RG_LDO_VA09_EN_ADDR, MT6359P_RG_LDO_VA09_EN_SHIFT,
+		   MT6359P_DA_VA09_B_EN_ADDR, MT6359P_RG_VA09_VOSEL_ADDR,
+		   MT6359_RG_VA09_VOSEL_MASK << MT6359_RG_VA09_VOSEL_SHIFT,
+		   960),
+	MT6359_LDO("ldo_vrf18", VRF18, vrf18_voltages,
+		   MT6359P_RG_LDO_VRF18_EN_ADDR, MT6359P_RG_LDO_VRF18_EN_SHIFT,
+		   MT6359P_DA_VRF18_B_EN_ADDR, MT6359P_RG_VRF18_VOSEL_ADDR,
+		   MT6359_RG_VRF18_VOSEL_MASK << MT6359_RG_VRF18_VOSEL_SHIFT,
+		   240),
+	MT6359_LDO_LINEAR("ldo_vsram_md", VSRAM_MD, 500000, 1293750, 6250,
+			  MT6359P_RG_LDO_VSRAM_MD_EN_ADDR,
+			  MT6359P_DA_VSRAM_MD_B_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_MD_VOSEL_ADDR,
+			  MT6359_RG_LDO_VSRAM_MD_VOSEL_MASK <<
+			  MT6359_RG_LDO_VSRAM_MD_VOSEL_SHIFT),
+	MT6359_LDO("ldo_vufs", VUFS, volt18_voltages,
+		   MT6359P_RG_LDO_VUFS_EN_ADDR, MT6359P_RG_LDO_VUFS_EN_SHIFT,
+		   MT6359P_DA_VUFS_B_EN_ADDR, MT6359P_RG_VUFS_VOSEL_ADDR,
+		   MT6359_RG_VUFS_VOSEL_MASK << MT6359_RG_VUFS_VOSEL_SHIFT,
+		   1920),
+	MT6359_LDO("ldo_vm18", VM18, volt18_voltages,
+		   MT6359P_RG_LDO_VM18_EN_ADDR, MT6359P_RG_LDO_VM18_EN_SHIFT,
+		   MT6359P_DA_VM18_B_EN_ADDR, MT6359P_RG_VM18_VOSEL_ADDR,
+		   MT6359_RG_VM18_VOSEL_MASK << MT6359_RG_VM18_VOSEL_SHIFT,
+		   1920),
+	MT6359_LDO("ldo_vbbck", VBBCK, vbbck_voltages,
+		   MT6359P_RG_LDO_VBBCK_EN_ADDR, MT6359P_RG_LDO_VBBCK_EN_SHIFT,
+		   MT6359P_DA_VBBCK_B_EN_ADDR, MT6359P_RG_VBBCK_VOSEL_ADDR,
+		   MT6359P_RG_VBBCK_VOSEL_MASK << MT6359P_RG_VBBCK_VOSEL_SHIFT,
+		   480),
+	MT6359_LDO_LINEAR("ldo_vsram_proc1", VSRAM_PROC1, 500000, 1293750, 6250,
+			  MT6359P_RG_LDO_VSRAM_PROC1_EN_ADDR,
+			  MT6359P_DA_VSRAM_PROC1_B_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_PROC1_VOSEL_ADDR,
+			  MT6359_RG_LDO_VSRAM_PROC1_VOSEL_MASK <<
+			  MT6359_RG_LDO_VSRAM_PROC1_VOSEL_SHIFT),
+	MT6359_LDO("ldo_vsim2", VSIM2, vsim2_voltages,
+		   MT6359P_RG_LDO_VSIM2_EN_ADDR, MT6359P_RG_LDO_VSIM2_EN_SHIFT,
+		   MT6359P_DA_VSIM2_B_EN_ADDR, MT6359P_RG_VSIM2_VOSEL_ADDR,
+		   MT6359_RG_VSIM2_VOSEL_MASK << MT6359_RG_VSIM2_VOSEL_SHIFT,
+		   480),
+	MT6359_LDO_LINEAR("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB,
+			  500000, 1293750, 6250,
+			  MT6359P_RG_LDO_VSRAM_OTHERS_SSHUB_EN_ADDR,
+			  MT6359P_DA_VSRAM_OTHERS_B_EN_ADDR,
+			  MT6359P_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_ADDR,
+			  MT6359_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_MASK <<
+			  MT6359_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_SHIFT),
+};
+
+static int mt6359_regulator_probe(struct udevice *dev)
+{
+	struct mt6359_regulator_info *priv = dev_get_priv(dev);
+	int i, hw_ver;
+
+	hw_ver = pmic_reg_read(dev->parent, MT6359P_HWCID);
+	if (hw_ver < MT6359P_CHIP_VER) {
+		dev_err(dev, "mt6359 is not supported. Only support mt6359p, hw_ver(%d)\n",
+			hw_ver);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mt6359p_regulators); i++) {
+		if (!strcmp(dev->name, mt6359p_regulators[i].desc.of_match)) {
+			*priv = mt6359p_regulators[i];
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops mt6359_regulator_ops = {
+	.get_value  = mt6359_get_value,
+	.set_value  = mt6359_set_value,
+	.get_enable = mt6359_get_enable,
+	.set_enable = mt6359_set_enable,
+};
+
+U_BOOT_DRIVER(mt6359_regulator) = {
+	.name	   = MT6359_REGULATOR_DRIVER,
+	.id	   = UCLASS_REGULATOR,
+	.ops	   = &mt6359_regulator_ops,
+	.probe	   = mt6359_regulator_probe,
+	.priv_auto = sizeof(struct mt6359_regulator_info),
+};
diff --git a/include/power/mt6359.h b/include/power/mt6359.h
new file mode 100644
index 00000000000..1e0380e87b0
--- /dev/null
+++ b/include/power/mt6359.h
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 MediaTek Inc. All Rights Reserved.
+ * Author: Bo-Chen Chen <rex-bc.chen@mediatek.com>
+ */
+
+#ifndef __MT6359_H_
+#define __MT6359_H_
+
+#define MT6359_REGULATOR_DRIVER	"mt6359_regulator"
+
+enum {
+	MT6359_ID_VS1 = 0,
+	MT6359_ID_VGPU11,
+	MT6359_ID_VMODEM,
+	MT6359_ID_VPU,
+	MT6359_ID_VCORE,
+	MT6359_ID_VS2,
+	MT6359_ID_VPA,
+	MT6359_ID_VPROC2,
+	MT6359_ID_VPROC1,
+	MT6359_ID_VCORE_SSHUB,
+	MT6359_ID_VGPU11_SSHUB = MT6359_ID_VCORE_SSHUB,
+	MT6359_ID_VAUD18 = 10,
+	MT6359_ID_VSIM1,
+	MT6359_ID_VIBR,
+	MT6359_ID_VRF12,
+	MT6359_ID_VUSB,
+	MT6359_ID_VSRAM_PROC2,
+	MT6359_ID_VIO18,
+	MT6359_ID_VCAMIO,
+	MT6359_ID_VCN18,
+	MT6359_ID_VFE28,
+	MT6359_ID_VCN13,
+	MT6359_ID_VCN33_1_BT,
+	MT6359_ID_VCN33_1_WIFI,
+	MT6359_ID_VAUX18,
+	MT6359_ID_VSRAM_OTHERS,
+	MT6359_ID_VEFUSE,
+	MT6359_ID_VXO22,
+	MT6359_ID_VRFCK,
+	MT6359_ID_VBIF28,
+	MT6359_ID_VIO28,
+	MT6359_ID_VEMC,
+	MT6359_ID_VCN33_2_BT,
+	MT6359_ID_VCN33_2_WIFI,
+	MT6359_ID_VA12,
+	MT6359_ID_VA09,
+	MT6359_ID_VRF18,
+	MT6359_ID_VSRAM_MD,
+	MT6359_ID_VUFS,
+	MT6359_ID_VM18,
+	MT6359_ID_VBBCK,
+	MT6359_ID_VSRAM_PROC1,
+	MT6359_ID_VSIM2,
+	MT6359_ID_VSRAM_OTHERS_SSHUB,
+	MT6359_ID_RG_MAX,
+};
+
+
+/* PMIC Registers */
+#define MT6359_BUCK_VPU_CON0			0x1488
+#define MT6359_BUCK_VPU_DBG1			0x14a8
+#define MT6359_BUCK_VPU_ELR0			0x14ac
+#define MT6359_BUCK_VCORE_CON0			0x1508
+#define MT6359_BUCK_VCORE_DBG1			0x1528
+#define MT6359_BUCK_VGPU11_CON0			0x1588
+#define MT6359_BUCK_VGPU11_DBG1			0x15a8
+#define MT6359_BUCK_VMODEM_CON0			0x1688
+#define MT6359_BUCK_VMODEM_DBG1			0x16a8
+#define MT6359_BUCK_VMODEM_ELR0			0x16ae
+#define MT6359_BUCK_VPROC1_CON0			0x1708
+#define MT6359_BUCK_VPROC1_DBG1			0x1728
+#define MT6359_BUCK_VPROC1_ELR0			0x172e
+#define MT6359_BUCK_VPROC2_CON0			0x1788
+#define MT6359_BUCK_VPROC2_DBG1			0x17a8
+#define MT6359_BUCK_VPROC2_ELR0			0x17b2
+#define MT6359_BUCK_VS1_CON0			0x1808
+#define MT6359_BUCK_VS1_DBG1			0x1828
+#define MT6359_BUCK_VS1_ELR0			0x1834
+#define MT6359_BUCK_VS2_CON0			0x1888
+#define MT6359_BUCK_VS2_DBG1			0x18a8
+#define MT6359_BUCK_VS2_ELR0			0x18b4
+#define MT6359_BUCK_VPA_CON0			0x1908
+#define MT6359_BUCK_VPA_CON1			0x190e
+#define MT6359_BUCK_VPA_DBG1			0x1916
+#define MT6359_VGPUVCORE_ANA_CON2		0x198e
+#define MT6359_VGPUVCORE_ANA_CON13		0x19a4
+#define MT6359_VPROC1_ANA_CON3			0x19b2
+#define MT6359_VPROC2_ANA_CON3			0x1a0e
+#define MT6359_VMODEM_ANA_CON3			0x1a1a
+#define MT6359_VPU_ANA_CON3			0x1a26
+#define MT6359_VS1_ANA_CON0			0x1a2c
+#define MT6359_VS2_ANA_CON0			0x1a34
+#define MT6359_VPA_ANA_CON0			0x1a3c
+
+#define MT6359_RG_BUCK_VPU_EN_ADDR			MT6359_BUCK_VPU_CON0
+#define MT6359_RG_BUCK_VPU_LP_ADDR			MT6359_BUCK_VPU_CON0
+#define MT6359_RG_BUCK_VPU_LP_SHIFT			1
+#define MT6359_DA_VPU_EN_ADDR				MT6359_BUCK_VPU_DBG1
+#define MT6359_RG_BUCK_VPU_VOSEL_ADDR			MT6359_BUCK_VPU_ELR0
+#define MT6359_RG_BUCK_VPU_VOSEL_MASK			0x7F
+#define MT6359_RG_BUCK_VPU_VOSEL_SHIFT			0
+#define MT6359_RG_BUCK_VCORE_EN_ADDR			MT6359_BUCK_VCORE_CON0
+#define MT6359_RG_BUCK_VCORE_LP_ADDR			MT6359_BUCK_VCORE_CON0
+#define MT6359_RG_BUCK_VCORE_LP_SHIFT			1
+#define MT6359_DA_VCORE_EN_ADDR				MT6359_BUCK_VCORE_DBG1
+#define MT6359_RG_BUCK_VCORE_VOSEL_MASK			0x7F
+#define MT6359_RG_BUCK_VCORE_VOSEL_SHIFT		0
+#define MT6359_RG_BUCK_VGPU11_EN_ADDR			MT6359_BUCK_VGPU11_CON0
+#define MT6359_RG_BUCK_VGPU11_LP_ADDR			MT6359_BUCK_VGPU11_CON0
+#define MT6359_RG_BUCK_VGPU11_LP_SHIFT			1
+#define MT6359_DA_VGPU11_EN_ADDR			MT6359_BUCK_VGPU11_DBG1
+#define MT6359_RG_BUCK_VGPU11_VOSEL_MASK		0x7F
+#define MT6359_RG_BUCK_VGPU11_VOSEL_SHIFT		0
+#define MT6359_RG_BUCK_VMODEM_EN_ADDR			MT6359_BUCK_VMODEM_CON0
+#define MT6359_RG_BUCK_VMODEM_LP_ADDR			MT6359_BUCK_VMODEM_CON0
+#define MT6359_RG_BUCK_VMODEM_LP_SHIFT			1
+#define MT6359_DA_VMODEM_EN_ADDR			MT6359_BUCK_VMODEM_DBG1
+#define MT6359_RG_BUCK_VMODEM_VOSEL_ADDR		MT6359_BUCK_VMODEM_ELR0
+#define MT6359_RG_BUCK_VMODEM_VOSEL_MASK		0x7F
+#define MT6359_RG_BUCK_VMODEM_VOSEL_SHIFT		0
+#define MT6359_RG_BUCK_VPROC1_EN_ADDR			MT6359_BUCK_VPROC1_CON0
+#define MT6359_RG_BUCK_VPROC1_LP_ADDR			MT6359_BUCK_VPROC1_CON0
+#define MT6359_RG_BUCK_VPROC1_LP_SHIFT			1
+#define MT6359_DA_VPROC1_EN_ADDR			MT6359_BUCK_VPROC1_DBG1
+#define MT6359_RG_BUCK_VPROC1_VOSEL_ADDR		MT6359_BUCK_VPROC1_ELR0
+#define MT6359_RG_BUCK_VPROC1_VOSEL_MASK		0x7F
+#define MT6359_RG_BUCK_VPROC1_VOSEL_SHIFT		0
+#define MT6359_RG_BUCK_VPROC2_EN_ADDR			MT6359_BUCK_VPROC2_CON0
+#define MT6359_RG_BUCK_VPROC2_LP_ADDR			MT6359_BUCK_VPROC2_CON0
+#define MT6359_RG_BUCK_VPROC2_LP_SHIFT			1
+#define MT6359_DA_VPROC2_EN_ADDR			MT6359_BUCK_VPROC2_DBG1
+#define MT6359_RG_BUCK_VPROC2_VOSEL_ADDR		MT6359_BUCK_VPROC2_ELR0
+#define MT6359_RG_BUCK_VPROC2_VOSEL_MASK		0x7F
+#define MT6359_RG_BUCK_VPROC2_VOSEL_SHIFT		0
+#define MT6359_RG_BUCK_VS1_EN_ADDR			MT6359_BUCK_VS1_CON0
+#define MT6359_RG_BUCK_VS1_LP_ADDR			MT6359_BUCK_VS1_CON0
+#define MT6359_RG_BUCK_VS1_LP_SHIFT			1
+#define MT6359_DA_VS1_EN_ADDR				MT6359_BUCK_VS1_DBG1
+#define MT6359_RG_BUCK_VS1_VOSEL_ADDR			MT6359_BUCK_VS1_ELR0
+#define MT6359_RG_BUCK_VS1_VOSEL_MASK			0x7F
+#define MT6359_RG_BUCK_VS1_VOSEL_SHIFT			0
+#define MT6359_RG_BUCK_VS2_EN_ADDR			MT6359_BUCK_VS2_CON0
+#define MT6359_RG_BUCK_VS2_LP_ADDR			MT6359_BUCK_VS2_CON0
+#define MT6359_RG_BUCK_VS2_LP_SHIFT			1
+#define MT6359_DA_VS2_EN_ADDR				MT6359_BUCK_VS2_DBG1
+#define MT6359_RG_BUCK_VS2_VOSEL_ADDR			MT6359_BUCK_VS2_ELR0
+#define MT6359_RG_BUCK_VS2_VOSEL_MASK			0x7F
+#define MT6359_RG_BUCK_VS2_VOSEL_SHIFT			0
+#define MT6359_RG_BUCK_VPA_EN_ADDR			MT6359_BUCK_VPA_CON0
+#define MT6359_RG_BUCK_VPA_LP_ADDR			MT6359_BUCK_VPA_CON0
+#define MT6359_RG_BUCK_VPA_LP_SHIFT			1
+#define MT6359_RG_BUCK_VPA_VOSEL_ADDR			MT6359_BUCK_VPA_CON1
+#define MT6359_RG_BUCK_VPA_VOSEL_MASK			0x3F
+#define MT6359_RG_BUCK_VPA_VOSEL_SHIFT			0
+#define MT6359_DA_VPA_EN_ADDR				MT6359_BUCK_VPA_DBG1
+#define MT6359_RG_VGPU11_FCCM_ADDR			MT6359_VGPUVCORE_ANA_CON2
+#define MT6359_RG_VGPU11_FCCM_SHIFT			9
+#define MT6359_RG_VCORE_FCCM_ADDR			MT6359_VGPUVCORE_ANA_CON13
+#define MT6359_RG_VCORE_FCCM_SHIFT			5
+#define MT6359_RG_VPROC1_FCCM_ADDR			MT6359_VPROC1_ANA_CON3
+#define MT6359_RG_VPROC1_FCCM_SHIFT			1
+#define MT6359_RG_VPROC2_FCCM_ADDR			MT6359_VPROC2_ANA_CON3
+#define MT6359_RG_VPROC2_FCCM_SHIFT			1
+#define MT6359_RG_VMODEM_FCCM_ADDR			MT6359_VMODEM_ANA_CON3
+#define MT6359_RG_VMODEM_FCCM_SHIFT			1
+#define MT6359_RG_VPU_FCCM_ADDR				MT6359_VPU_ANA_CON3
+#define MT6359_RG_VPU_FCCM_SHIFT			1
+#define MT6359_RG_VS1_FPWM_ADDR				MT6359_VS1_ANA_CON0
+#define MT6359_RG_VS1_FPWM_SHIFT			3
+#define MT6359_RG_VS2_FPWM_ADDR				MT6359_VS2_ANA_CON0
+#define MT6359_RG_VS2_FPWM_SHIFT			3
+#define MT6359_RG_VPA_MODESET_ADDR			MT6359_VPA_ANA_CON0
+#define MT6359_RG_VPA_MODESET_SHIFT			1
+#define MT6359_RG_LDO_VSRAM_PROC1_VOSEL_MASK		0x7F
+#define MT6359_RG_LDO_VSRAM_PROC1_VOSEL_SHIFT		0
+#define MT6359_RG_LDO_VSRAM_PROC2_VOSEL_MASK		0x7F
+#define MT6359_RG_LDO_VSRAM_PROC2_VOSEL_SHIFT		0
+#define MT6359_RG_LDO_VSRAM_OTHERS_VOSEL_MASK		0x7F
+#define MT6359_RG_LDO_VSRAM_OTHERS_VOSEL_SHIFT		0
+#define MT6359_RG_LDO_VSRAM_MD_VOSEL_MASK		0x7F
+#define MT6359_RG_LDO_VSRAM_MD_VOSEL_SHIFT		0
+#define MT6359_RG_LDO_VCN33_1_EN_0_SHIFT		0
+#define MT6359_RG_LDO_VCN33_2_EN_1_SHIFT		15
+#define MT6359_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_MASK	0x7F
+#define MT6359_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_SHIFT	1
+#define MT6359_RG_VCN33_1_VOSEL_MASK			0xF
+#define MT6359_RG_VCN33_1_VOSEL_SHIFT			8
+#define MT6359_RG_VCN33_2_VOSEL_MASK			0xF
+#define MT6359_RG_VCN33_2_VOSEL_SHIFT			8
+#define MT6359_RG_VSIM1_VOSEL_MASK			0xF
+#define MT6359_RG_VSIM1_VOSEL_SHIFT			8
+#define MT6359_RG_VSIM2_VOSEL_MASK			0xF
+#define MT6359_RG_VSIM2_VOSEL_SHIFT			8
+#define MT6359_RG_VIO28_VOSEL_MASK			0xF
+#define MT6359_RG_VIO28_VOSEL_SHIFT			8
+#define MT6359_RG_VIBR_VOSEL_MASK			0xF
+#define MT6359_RG_VIBR_VOSEL_SHIFT			8
+#define MT6359_RG_VRF18_VOSEL_MASK			0xF
+#define MT6359_RG_VRF18_VOSEL_SHIFT			8
+#define MT6359_RG_VEFUSE_VOSEL_MASK			0xF
+#define MT6359_RG_VEFUSE_VOSEL_SHIFT			8
+#define MT6359_RG_VCAMIO_VOSEL_MASK			0xF
+#define MT6359_RG_VCAMIO_VOSEL_SHIFT			8
+#define MT6359_RG_VIO18_VOSEL_MASK			0xF
+#define MT6359_RG_VIO18_VOSEL_SHIFT			8
+#define MT6359_RG_VM18_VOSEL_MASK			0xF
+#define MT6359_RG_VM18_VOSEL_SHIFT			8
+#define MT6359_RG_VUFS_VOSEL_MASK			0xF
+#define MT6359_RG_VUFS_VOSEL_SHIFT			8
+#define MT6359_RG_VRF12_VOSEL_MASK			0xF
+#define MT6359_RG_VRF12_VOSEL_SHIFT			8
+#define MT6359_RG_VCN13_VOSEL_MASK			0xF
+#define MT6359_RG_VCN13_VOSEL_SHIFT			8
+#define MT6359_RG_VA09_VOSEL_MASK			0xF
+#define MT6359_RG_VA09_VOSEL_SHIFT			8
+#define MT6359_RG_VA12_VOSEL_MASK			0xF
+#define MT6359_RG_VA12_VOSEL_SHIFT			8
+#define MT6359_RG_VXO22_VOSEL_MASK			0xF
+#define MT6359_RG_VXO22_VOSEL_SHIFT			8
+#define MT6359_RG_VRFCK_VOSEL_MASK			0xF
+#define MT6359_RG_VRFCK_VOSEL_SHIFT			8
+
+#endif
diff --git a/include/power/mt6359p.h b/include/power/mt6359p.h
new file mode 100644
index 00000000000..506b5d38c68
--- /dev/null
+++ b/include/power/mt6359p.h
@@ -0,0 +1,230 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 MediaTek Inc. All Rights Reserved.
+ * Author: Bo-Chen Chen <rex-bc.chen@mediatek.com>
+ */
+
+#ifndef __MT6359P_H_
+#define __MT6359P_H_
+
+#define MT6359P_CHIP_VER 0x5930
+
+/* PMIC Registers */
+#define MT6359P_HWCID				0x8
+#define MT6359P_TOP_TRAP			0x50
+#define MT6359P_TOP_TMA_KEY			0x3a8
+#define MT6359P_BUCK_VCORE_ELR0			0x152c
+#define MT6359P_BUCK_VGPU11_SSHUB_CON0		0x15aa
+#define MT6359P_BUCK_VGPU11_ELR0		0x15b4
+#define MT6359P_LDO_VSRAM_PROC1_ELR		0x1b44
+#define MT6359P_LDO_VSRAM_PROC2_ELR		0x1b46
+#define MT6359P_LDO_VSRAM_OTHERS_ELR		0x1b48
+#define MT6359P_LDO_VSRAM_MD_ELR		0x1b4a
+#define MT6359P_LDO_VEMC_ELR_0			0x1b4c
+#define MT6359P_LDO_VFE28_CON0			0x1b88
+#define MT6359P_LDO_VFE28_MON			0x1b8c
+#define MT6359P_LDO_VXO22_CON0			0x1b9a
+#define MT6359P_LDO_VXO22_MON			0x1b9e
+#define MT6359P_LDO_VRF18_CON0			0x1bac
+#define MT6359P_LDO_VRF18_MON			0x1bb0
+#define MT6359P_LDO_VRF12_CON0			0x1bbe
+#define MT6359P_LDO_VRF12_MON			0x1bc2
+#define MT6359P_LDO_VEFUSE_CON0			0x1bd0
+#define MT6359P_LDO_VEFUSE_MON			0x1bd4
+#define MT6359P_LDO_VCN33_1_CON0		0x1be2
+#define MT6359P_LDO_VCN33_1_MON			0x1be6
+#define MT6359P_LDO_VCN33_1_MULTI_SW		0x1bf4
+#define MT6359P_LDO_VCN33_2_CON0		0x1c08
+#define MT6359P_LDO_VCN33_2_MON			0x1c0c
+#define MT6359P_LDO_VCN33_2_MULTI_SW		0x1c1a
+#define MT6359P_LDO_VCN13_CON0			0x1c1c
+#define MT6359P_LDO_VCN13_MON			0x1c20
+#define MT6359P_LDO_VCN18_CON0			0x1c2e
+#define MT6359P_LDO_VCN18_MON			0x1c32
+#define MT6359P_LDO_VA09_CON0			0x1c40
+#define MT6359P_LDO_VA09_MON			0x1c44
+#define MT6359P_LDO_VCAMIO_CON0			0x1c52
+#define MT6359P_LDO_VCAMIO_MON			0x1c56
+#define MT6359P_LDO_VA12_CON0			0x1c64
+#define MT6359P_LDO_VA12_MON			0x1c68
+#define MT6359P_LDO_VAUX18_CON0			0x1c88
+#define MT6359P_LDO_VAUX18_MON			0x1c8c
+#define MT6359P_LDO_VAUD18_CON0			0x1c9a
+#define MT6359P_LDO_VAUD18_MON			0x1c9e
+#define MT6359P_LDO_VIO18_CON0			0x1cac
+#define MT6359P_LDO_VIO18_MON			0x1cb0
+#define MT6359P_LDO_VEMC_CON0			0x1cbe
+#define MT6359P_LDO_VEMC_MON			0x1cc2
+#define MT6359P_LDO_VSIM1_CON0			0x1cd0
+#define MT6359P_LDO_VSIM1_MON			0x1cd4
+#define MT6359P_LDO_VSIM2_CON0			0x1ce2
+#define MT6359P_LDO_VSIM2_MON			0x1ce6
+#define MT6359P_LDO_VUSB_CON0			0x1d08
+#define MT6359P_LDO_VUSB_MON			0x1d0c
+#define MT6359P_LDO_VRFCK_CON0			0x1d1c
+#define MT6359P_LDO_VRFCK_MON			0x1d20
+#define MT6359P_LDO_VBBCK_CON0			0x1d2e
+#define MT6359P_LDO_VBBCK_MON			0x1d32
+#define MT6359P_LDO_VBIF28_CON0			0x1d40
+#define MT6359P_LDO_VBIF28_MON			0x1d44
+#define MT6359P_LDO_VIBR_CON0			0x1d52
+#define MT6359P_LDO_VIBR_MON			0x1d56
+#define MT6359P_LDO_VIO28_CON0			0x1d64
+#define MT6359P_LDO_VIO28_MON			0x1d68
+#define MT6359P_LDO_VM18_CON0			0x1d88
+#define MT6359P_LDO_VM18_MON			0x1d8c
+#define MT6359P_LDO_VUFS_CON0			0x1d9a
+#define MT6359P_LDO_VUFS_MON			0x1d9e
+#define MT6359P_LDO_VSRAM_PROC1_CON0		0x1e88
+#define MT6359P_LDO_VSRAM_PROC1_MON		0x1e8c
+#define MT6359P_LDO_VSRAM_PROC2_CON0		0x1ea8
+#define MT6359P_LDO_VSRAM_PROC2_MON		0x1eac
+#define MT6359P_LDO_VSRAM_OTHERS_CON0		0x1f08
+#define MT6359P_LDO_VSRAM_OTHERS_MON		0x1f0c
+#define MT6359P_LDO_VSRAM_OTHERS_SSHUB		0x1f28
+#define MT6359P_LDO_VSRAM_MD_CON0		0x1f2e
+#define MT6359P_LDO_VSRAM_MD_MON		0x1f32
+#define MT6359P_VCN33_1_ANA_CON0		0x1f98
+#define MT6359P_VCN33_2_ANA_CON0		0x1f9c
+#define MT6359P_VSIM1_ANA_CON0			0x1fa2
+#define MT6359P_VSIM2_ANA_CON0			0x1fa6
+#define MT6359P_VIO28_ANA_CON0			0x1faa
+#define MT6359P_VIBR_ANA_CON0			0x1fae
+#define MT6359P_VFE28_ELR_4			0x1fc0
+#define MT6359P_VRF18_ANA_CON0			0x2008
+#define MT6359P_VEFUSE_ANA_CON0			0x200c
+#define MT6359P_VCAMIO_ANA_CON0			0x2014
+#define MT6359P_VIO18_ANA_CON0			0x201c
+#define MT6359P_VM18_ANA_CON0			0x2020
+#define MT6359P_VUFS_ANA_CON0			0x2024
+#define MT6359P_VRF12_ANA_CON0			0x202a
+#define MT6359P_VCN13_ANA_CON0			0x202e
+#define MT6359P_VRF18_ELR_3			0x204e
+#define MT6359P_VXO22_ANA_CON0			0x2088
+#define MT6359P_VRFCK_ANA_CON0			0x208c
+#define MT6359P_VBBCK_ANA_CON0			0x2096
+
+#define MT6359P_RG_BUCK_VCORE_VOSEL_ADDR		MT6359P_BUCK_VCORE_ELR0
+#define MT6359P_RG_BUCK_VGPU11_SSHUB_EN_ADDR		MT6359P_BUCK_VGPU11_SSHUB_CON0
+#define MT6359P_RG_BUCK_VGPU11_VOSEL_ADDR		MT6359P_BUCK_VGPU11_ELR0
+#define MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_ADDR		MT6359P_BUCK_VGPU11_SSHUB_CON0
+#define MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_MASK		0x7F
+#define MT6359P_RG_BUCK_VGPU11_SSHUB_VOSEL_SHIFT	4
+#define MT6359P_RG_LDO_VSRAM_PROC1_VOSEL_ADDR		MT6359P_LDO_VSRAM_PROC1_ELR
+#define MT6359P_RG_LDO_VSRAM_PROC2_VOSEL_ADDR		MT6359P_LDO_VSRAM_PROC2_ELR
+#define MT6359P_RG_LDO_VSRAM_OTHERS_VOSEL_ADDR		MT6359P_LDO_VSRAM_OTHERS_ELR
+#define MT6359P_RG_LDO_VSRAM_MD_VOSEL_ADDR		MT6359P_LDO_VSRAM_MD_ELR
+#define MT6359P_RG_LDO_VEMC_VOSEL_0_ADDR		MT6359P_LDO_VEMC_ELR_0
+#define MT6359P_RG_LDO_VEMC_VOSEL_0_MASK		0xF
+#define MT6359P_RG_LDO_VEMC_VOSEL_0_SHIFT		0
+#define MT6359P_RG_LDO_VFE28_EN_ADDR			MT6359P_LDO_VFE28_CON0
+#define MT6359P_DA_VFE28_B_EN_ADDR			MT6359P_LDO_VFE28_MON
+#define MT6359P_RG_LDO_VXO22_EN_ADDR			MT6359P_LDO_VXO22_CON0
+#define MT6359P_RG_LDO_VXO22_EN_SHIFT			0
+#define MT6359P_DA_VXO22_B_EN_ADDR			MT6359P_LDO_VXO22_MON
+#define MT6359P_RG_LDO_VRF18_EN_ADDR			MT6359P_LDO_VRF18_CON0
+#define MT6359P_RG_LDO_VRF18_EN_SHIFT			0
+#define MT6359P_DA_VRF18_B_EN_ADDR			MT6359P_LDO_VRF18_MON
+#define MT6359P_RG_LDO_VRF12_EN_ADDR			MT6359P_LDO_VRF12_CON0
+#define MT6359P_RG_LDO_VRF12_EN_SHIFT			0
+#define MT6359P_DA_VRF12_B_EN_ADDR			MT6359P_LDO_VRF12_MON
+#define MT6359P_RG_LDO_VEFUSE_EN_ADDR			MT6359P_LDO_VEFUSE_CON0
+#define MT6359P_RG_LDO_VEFUSE_EN_SHIFT			0
+#define MT6359P_DA_VEFUSE_B_EN_ADDR			MT6359P_LDO_VEFUSE_MON
+#define MT6359P_RG_LDO_VCN33_1_EN_0_ADDR		MT6359P_LDO_VCN33_1_CON0
+#define MT6359P_DA_VCN33_1_B_EN_ADDR			MT6359P_LDO_VCN33_1_MON
+#define MT6359P_RG_LDO_VCN33_1_EN_1_ADDR		MT6359P_LDO_VCN33_1_MULTI_SW
+#define MT6359P_RG_LDO_VCN33_1_EN_1_SHIFT		15
+#define MT6359P_RG_LDO_VCN33_2_EN_0_ADDR		MT6359P_LDO_VCN33_2_CON0
+#define MT6359P_RG_LDO_VCN33_2_EN_0_SHIFT		0
+#define MT6359P_DA_VCN33_2_B_EN_ADDR			MT6359P_LDO_VCN33_2_MON
+#define MT6359P_RG_LDO_VCN33_2_EN_1_ADDR		MT6359P_LDO_VCN33_2_MULTI_SW
+#define MT6359P_RG_LDO_VCN13_EN_ADDR			MT6359P_LDO_VCN13_CON0
+#define MT6359P_RG_LDO_VCN13_EN_SHIFT			0
+#define MT6359P_DA_VCN13_B_EN_ADDR			MT6359P_LDO_VCN13_MON
+#define MT6359P_RG_LDO_VCN18_EN_ADDR			MT6359P_LDO_VCN18_CON0
+#define MT6359P_DA_VCN18_B_EN_ADDR			MT6359P_LDO_VCN18_MON
+#define MT6359P_RG_LDO_VA09_EN_ADDR			MT6359P_LDO_VA09_CON0
+#define MT6359P_RG_LDO_VA09_EN_SHIFT			0
+#define MT6359P_DA_VA09_B_EN_ADDR			MT6359P_LDO_VA09_MON
+#define MT6359P_RG_LDO_VCAMIO_EN_ADDR			MT6359P_LDO_VCAMIO_CON0
+#define MT6359P_RG_LDO_VCAMIO_EN_SHIFT			0
+#define MT6359P_DA_VCAMIO_B_EN_ADDR			MT6359P_LDO_VCAMIO_MON
+#define MT6359P_RG_LDO_VA12_EN_ADDR			MT6359P_LDO_VA12_CON0
+#define MT6359P_RG_LDO_VA12_EN_SHIFT			0
+#define MT6359P_DA_VA12_B_EN_ADDR			MT6359P_LDO_VA12_MON
+#define MT6359P_RG_LDO_VAUX18_EN_ADDR			MT6359P_LDO_VAUX18_CON0
+#define MT6359P_DA_VAUX18_B_EN_ADDR			MT6359P_LDO_VAUX18_MON
+#define MT6359P_RG_LDO_VAUD18_EN_ADDR			MT6359P_LDO_VAUD18_CON0
+#define MT6359P_DA_VAUD18_B_EN_ADDR			MT6359P_LDO_VAUD18_MON
+#define MT6359P_RG_LDO_VIO18_EN_ADDR			MT6359P_LDO_VIO18_CON0
+#define MT6359P_RG_LDO_VIO18_EN_SHIFT			0
+#define MT6359P_DA_VIO18_B_EN_ADDR			MT6359P_LDO_VIO18_MON
+#define MT6359P_RG_LDO_VEMC_EN_ADDR			MT6359P_LDO_VEMC_CON0
+#define MT6359P_RG_LDO_VEMC_EN_SHIFT			0
+#define MT6359P_DA_VEMC_B_EN_ADDR			MT6359P_LDO_VEMC_MON
+#define MT6359P_RG_LDO_VSIM1_EN_ADDR			MT6359P_LDO_VSIM1_CON0
+#define MT6359P_RG_LDO_VSIM1_EN_SHIFT			0
+#define MT6359P_DA_VSIM1_B_EN_ADDR			MT6359P_LDO_VSIM1_MON
+#define MT6359P_RG_LDO_VSIM2_EN_ADDR			MT6359P_LDO_VSIM2_CON0
+#define MT6359P_RG_LDO_VSIM2_EN_SHIFT			0
+#define MT6359P_DA_VSIM2_B_EN_ADDR			MT6359P_LDO_VSIM2_MON
+#define MT6359P_RG_LDO_VUSB_EN_0_ADDR			MT6359P_LDO_VUSB_CON0
+#define MT6359P_DA_VUSB_B_EN_ADDR			MT6359P_LDO_VUSB_MON
+#define MT6359P_RG_LDO_VRFCK_EN_ADDR			MT6359P_LDO_VRFCK_CON0
+#define MT6359P_RG_LDO_VRFCK_EN_SHIFT			0
+#define MT6359P_DA_VRFCK_B_EN_ADDR			MT6359P_LDO_VRFCK_MON
+#define MT6359P_RG_LDO_VBBCK_EN_ADDR			MT6359P_LDO_VBBCK_CON0
+#define MT6359P_RG_LDO_VBBCK_EN_SHIFT			0
+#define MT6359P_DA_VBBCK_B_EN_ADDR			MT6359P_LDO_VBBCK_MON
+#define MT6359P_RG_LDO_VBIF28_EN_ADDR			MT6359P_LDO_VBIF28_CON0
+#define MT6359P_DA_VBIF28_B_EN_ADDR			MT6359P_LDO_VBIF28_MON
+#define MT6359P_RG_LDO_VIBR_EN_ADDR			MT6359P_LDO_VIBR_CON0
+#define MT6359P_RG_LDO_VIBR_EN_SHIFT			0
+#define MT6359P_DA_VIBR_B_EN_ADDR			MT6359P_LDO_VIBR_MON
+#define MT6359P_RG_LDO_VIO28_EN_ADDR			MT6359P_LDO_VIO28_CON0
+#define MT6359P_RG_LDO_VIO28_EN_SHIFT			0
+#define MT6359P_DA_VIO28_B_EN_ADDR			MT6359P_LDO_VIO28_MON
+#define MT6359P_RG_LDO_VM18_EN_ADDR			MT6359P_LDO_VM18_CON0
+#define MT6359P_RG_LDO_VM18_EN_SHIFT			0
+#define MT6359P_DA_VM18_B_EN_ADDR			MT6359P_LDO_VM18_MON
+#define MT6359P_RG_LDO_VUFS_EN_ADDR			MT6359P_LDO_VUFS_CON0
+#define MT6359P_RG_LDO_VUFS_EN_SHIFT			0
+#define MT6359P_DA_VUFS_B_EN_ADDR			MT6359P_LDO_VUFS_MON
+#define MT6359P_RG_LDO_VSRAM_PROC1_EN_ADDR		MT6359P_LDO_VSRAM_PROC1_CON0
+#define MT6359P_DA_VSRAM_PROC1_B_EN_ADDR		MT6359P_LDO_VSRAM_PROC1_MON
+#define MT6359P_RG_LDO_VSRAM_PROC2_EN_ADDR		MT6359P_LDO_VSRAM_PROC2_CON0
+#define MT6359P_DA_VSRAM_PROC2_B_EN_ADDR		MT6359P_LDO_VSRAM_PROC2_MON
+#define MT6359P_RG_LDO_VSRAM_OTHERS_EN_ADDR		MT6359P_LDO_VSRAM_OTHERS_CON0
+#define MT6359P_DA_VSRAM_OTHERS_B_EN_ADDR		MT6359P_LDO_VSRAM_OTHERS_MON
+#define MT6359P_RG_LDO_VSRAM_OTHERS_SSHUB_EN_ADDR	MT6359P_LDO_VSRAM_OTHERS_SSHUB
+#define MT6359P_RG_LDO_VSRAM_OTHERS_SSHUB_VOSEL_ADDR	MT6359P_LDO_VSRAM_OTHERS_SSHUB
+#define MT6359P_RG_LDO_VSRAM_MD_EN_ADDR			MT6359P_LDO_VSRAM_MD_CON0
+#define MT6359P_DA_VSRAM_MD_B_EN_ADDR			MT6359P_LDO_VSRAM_MD_MON
+#define MT6359P_RG_VCN33_1_VOSEL_ADDR			MT6359P_VCN33_1_ANA_CON0
+#define MT6359P_RG_VCN33_2_VOSEL_ADDR			MT6359P_VCN33_2_ANA_CON0
+#define MT6359P_RG_VSIM1_VOSEL_ADDR			MT6359P_VSIM1_ANA_CON0
+#define MT6359P_RG_VSIM2_VOSEL_ADDR			MT6359P_VSIM2_ANA_CON0
+#define MT6359P_RG_VIO28_VOSEL_ADDR			MT6359P_VIO28_ANA_CON0
+#define MT6359P_RG_VIBR_VOSEL_ADDR			MT6359P_VIBR_ANA_CON0
+#define MT6359P_RG_VRF18_VOSEL_ADDR			MT6359P_VRF18_ANA_CON0
+#define MT6359P_RG_VEFUSE_VOSEL_ADDR			MT6359P_VEFUSE_ANA_CON0
+#define MT6359P_RG_VCAMIO_VOSEL_ADDR			MT6359P_VCAMIO_ANA_CON0
+#define MT6359P_RG_VIO18_VOSEL_ADDR			MT6359P_VIO18_ANA_CON0
+#define MT6359P_RG_VM18_VOSEL_ADDR			MT6359P_VM18_ANA_CON0
+#define MT6359P_RG_VUFS_VOSEL_ADDR			MT6359P_VUFS_ANA_CON0
+#define MT6359P_RG_VRF12_VOSEL_ADDR			MT6359P_VRF12_ANA_CON0
+#define MT6359P_RG_VCN13_VOSEL_ADDR			MT6359P_VCN13_ANA_CON0
+#define MT6359P_RG_VA09_VOSEL_ADDR			MT6359P_VRF18_ELR_3
+#define MT6359P_RG_VA12_VOSEL_ADDR			MT6359P_VFE28_ELR_4
+#define MT6359P_RG_VXO22_VOSEL_ADDR			MT6359P_VXO22_ANA_CON0
+#define MT6359P_RG_VRFCK_VOSEL_ADDR			MT6359P_VRFCK_ANA_CON0
+#define MT6359P_RG_VBBCK_VOSEL_ADDR			MT6359P_VBBCK_ANA_CON0
+#define MT6359P_RG_VBBCK_VOSEL_MASK			0xF
+#define MT6359P_RG_VBBCK_VOSEL_SHIFT			4
+#define MT6359P_VM_MODE_ADDR				MT6359P_TOP_TRAP
+#define MT6359P_TMA_KEY_ADDR				MT6359P_TOP_TMA_KEY
+
+#define MT6359P_TMA_KEY 0x9CA6
+
+#endif

-- 
2.43.0

