Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1723EC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 636F760A7F;
	Fri,  7 Aug 2026 16:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwM42JpOOk5I; Fri,  7 Aug 2026 16:02:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 412036061B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118546;
	bh=ByNScWYdAm+kMZkiKotKDq60+ngWKpa6tG0YX4e9BRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ivm2lX7kxQsW097ocUC+LDC7ru9l5t6jLJcOCizD+til3xw7MZCVfM1XK4uMg0o9s
	 mncTYrzRJRzKgsZI9Y48pVlRW8HwTWuM8kMT/nFyWBLGw4PeqHGiSCRnnq9z3jqI5y
	 XyG2HSlodQ+ka5HvaJK89SbWxf8F1LwdKWcjOBuxS538P/YrRmpncTtMH3JxivaX9w
	 9zsqNdrp/id/O4+Rs5taOUaeq1rXSmOsYC2Tva07V5vb/MIU6EhhSFYPBllNABCzhp
	 X0Oyf1f+VjuSk3L5ZNCgndbK4AiWUMxTk0zrFUUbD9PfoQPVxN+xncjGIRePEFcvCM
	 Gf1q5PSMsD/Ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 412036061B;
	Fri,  7 Aug 2026 16:02:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5DE82F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6F048130B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0XtdkG91h0t for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:02:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 779C8812F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 779C8812F1
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 779C8812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:02:20 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-456f7012050so1792095fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118539; x=1786723339;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ByNScWYdAm+kMZkiKotKDq60+ngWKpa6tG0YX4e9BRU=;
 b=VxJCVqmLJFuk8aFlYb+1spq8vMzSJaW+LJECJosU0Tn0U5NM0k8zDduN3ArihDTmqg
 MEWTKbkonNaz1K5pfuk5WXi9TMIIAHYlziKJTMDtODc8zxxU6uul0LPkKPahkOJ2FSAb
 CqcYjkoU6kJblxL3JEhPXxaZLoSEEHY9OjRO/ylne4gvr9JECmm+9C2GHMQ5Z57UWAKn
 aK1/GtSU0WIdjN2HgAVCDmccFriVopvxKUb69SRvOvrBpI06i8QZb3tRNPQMo+LYc7Z2
 sddalGUtf+aQ92FGqPUZ/U2RnxECPiKu51yDD4IdKkz7xNHwUp3IKAGTu94FzR6xgfoD
 x+Yw==
X-Gm-Message-State: AOJu0YyT0gLGTX6Wb4Thm1dGC7t4E2SAsbwi4GTQPM4QL3clvIRAmqBR
 QXwIBa3B9NI12ntRvedQP924ORwvUul9e5Q8degk9+pCZlr3ZL33FOdzqyiwgVdqL2g=
X-Gm-Gg: AR+sD10gnpHN17BObMfNcUnuKXmD7VZ/ng9sVeZCYLq2SYw8KQRvk7rViDrygV8tko1
 bH6oXAGQxl0oWMJOJ5Euc7hNU4l+tWFYjaRqVxQcGppLYFw5h3iwds6lqTsQYyVou6YW9uqQpKL
 dAURmo3V7Un7OlW8Em4s/K/t6BB6XRKDBWrQXMwQlvqIZzBweuv77+fF8tazZH/sTN8TTWtOuqV
 dcBllGm0nWF4xk3CMj+FM6Kg4dMHRYxTyanzRQSEnH4U+6TrImBJ4rLDm921vDDIxNnfsG+8BGy
 7iAf6n5e2SOIYP1pjqTra5LfTch4bOBxdUjVzuwJnYCmJgnH9+5dndJKIsbi4zk6iVUPZ0pSfEM
 8wRR/kiHiXsvzrkVbnrRz0i4Lb5szLdrpNFHIhnLSUD2EEWXvqZsowiLAysXMYHBlCn/969Jaa3
 kg3ZXAw8Mu7LtlE3RNF6RTetExsuHMTgLRxWWrwLN0KKr0ZKgjE3j/7DCKXehknD1S
X-Received: by 2002:a05:6820:160d:b0:6ae:aa9b:b8f1 with SMTP id
 006d021491bc7-6b042ea72c1mr263000eaf.10.1786118538992; 
 Fri, 07 Aug 2026 09:02:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2679993eaf.5.2026.08.07.09.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:02:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:01:28 -0500
Subject: [PATCH v2 1/5] power: regulator: add MT6358 driver with MT6366 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pmic-mt6366-v2-1-d9fdef581fb1@baylibre.com>
References: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
In-Reply-To: <20260807-mtk-pmic-mt6366-v2-0-d9fdef581fb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19318;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=jF1UR+VRhOW1iQAAAFWNhvSdZze8XHCoRT4xldKMey4=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgFoG2Bel0PonP/G2WaEf6J5/O9AVzVreUmAa
 MbAUJ5y6J6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYBaBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwcQH/jwAiu6zt3zI5hJ2Yz7TeAYu2hdqbdr+DEazfjE
 k4Q4RgxujUiR8uo45gH74i5LzrADODHz2FBhFfEPXm9rEQOYToUOeBFA1w4YzqGgTZtm7OQf4NB
 5/KHAehpUZbpAZApqNwcJoE80yPuWjQl1EmWlQsS1YOO2q1npRlktAVSQV2lKh2thfabtpGZWNR
 iyeB0LaEbAk0Svi66BiqXd76wLUeCq5fzUIMS3srhcmoVXqUdxQHhScGDJ633IpnoWqZsET2/Zq
 l3t+2FTI5Yvsgz3jqpcstEFODkS36DsMMHqUozBlXUQvMeMHt5RnAS342koYxfXpuDghn7EGbdd
 ifUQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786118539; x=1786723339;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ByNScWYdAm+kMZkiKotKDq60+ngWKpa6tG0YX4e9BRU=;
 b=C4pRSzT9SBbpVFYTpoq9DQmuzuBGqP1wFHbXkKvxU2IuH7qt4j3y7+bZm8RzeDLGQu
 YfhReVO9oVyAn+tw4jeDC7bhRPOhSW+DY1oMG/Z8BYr7MAfgb2uv8lle3Ws2ptFp0qqU
 Hb26fAbnA2j/FgOcHbu+e6I86JIH1YD+nZHjcBS82Cqea6NGq7T93YeoJflBmh2fo2cC
 HjfQP2/JC2vPAcEV83AOgZ08l4Y0lXNeeapWWD68HecCmff3H6UpjJk+4klx/i1rKzPu
 M1mLV/T158G5aUA0MzbZ7y/TWAxdWYImhHR2y5T147+RuqBkNhARHV3JFwciEDb3TnNY
 XPQg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C4pRSzT9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a new driver for MediaTek MT6366 PMIC regulators. The register
layout is compatible with MT6358, so the driver itself is called
"mt6358". Only support for MT6366 is added currently for use with
the MediaTek Genio 360 EVK.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/regulator/Kconfig            |   8 +
 drivers/power/regulator/Makefile           |   1 +
 drivers/power/regulator/mt6358_regulator.c | 371 +++++++++++++++++++++++++++++
 include/power/mt6358.h                     | 130 ++++++++++
 4 files changed, 510 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 00a25acfdf9..56f07931c3d 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -564,6 +564,14 @@ config DM_REGULATOR_MT6357
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config DM_REGULATOR_MT6358
+	bool "Enable driver for MediaTek MT6358-family PMIC regulators"
+	depends on DM_REGULATOR && DM_PMIC_MTK_PWRAP
+	help
+	  Say y here to select this option to enable the power regulator path
+	  used by MT6358-family PMICs, including the MT6366 rail model used on
+	  MT8366 Genio 360.
+
 config DM_REGULATOR_MT6359
 	bool "Enable driver for MediaTek MT6359 PMIC regulators"
 	depends on DM_REGULATOR && DM_PMIC_MTK_PWRAP
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index a40c9d340d9..e17937f4c26 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
 obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MT6357) += mt6357_regulator.o
+obj-$(CONFIG_DM_REGULATOR_MT6358) += mt6358_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MT6359) += mt6359_regulator.o
 obj-$(CONFIG_DM_REGULATOR_PMBUS_HELPER)  += pmbus_helper.o
 obj-$(CONFIG_DM_REGULATOR_PMBUS_GENERIC) += pmbus_generic.o
diff --git a/drivers/power/regulator/mt6358_regulator.c b/drivers/power/regulator/mt6358_regulator.c
new file mode 100644
index 00000000000..00e714c9338
--- /dev/null
+++ b/drivers/power/regulator/mt6358_regulator.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ *
+ * MediaTek MT6358-family regulator driver used for MT6366 rails.
+ */
+
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <power/mt6358.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+enum mt6358_regulator_type {
+	MT6358_REG_TYPE_LINEAR,
+	MT6358_REG_TYPE_TABLE,
+	MT6358_REG_TYPE_FIXED,
+};
+
+struct mt6358_regulator_desc {
+	const char *name;
+	const char *of_match;
+	enum mt6358_regulator_type type;
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
+struct mt6358_regulator_info {
+	struct mt6358_regulator_desc desc;
+	const u32 *index_table;
+	unsigned int n_table;
+	u32 da_vsel_reg;
+	u32 da_vsel_mask;
+};
+
+#define MT6366_BUCK(match, _name, _min, _max, _step, _enable_reg, _vsel_reg, \
+		    _vsel_mask, _da_vsel_reg, _da_vsel_mask) \
+	[MT6366_ID_##_name] = { \
+		.desc = { \
+			.name = #_name, \
+			.of_match = match, \
+			.type = MT6358_REG_TYPE_LINEAR, \
+			.id = MT6366_ID_##_name, \
+			.uV_step = (_step), \
+			.n_voltages = ((_max) - (_min)) / (_step) + 1, \
+			.min_uV = (_min), \
+			.vsel_reg = (_vsel_reg), \
+			.vsel_mask = (_vsel_mask), \
+			.enable_reg = (_enable_reg), \
+			.enable_mask = BIT(0), \
+		}, \
+		.da_vsel_reg = (_da_vsel_reg), \
+		.da_vsel_mask = (_da_vsel_mask), \
+	}
+
+#define MT6366_LDO(match, _name, _volt_table, _index_table, _enable_reg, \
+		   _vsel_reg, _vsel_mask) \
+	[MT6366_ID_##_name] = { \
+		.desc = { \
+			.name = #_name, \
+			.of_match = match, \
+			.type = MT6358_REG_TYPE_TABLE, \
+			.id = MT6366_ID_##_name, \
+			.n_voltages = ARRAY_SIZE(_volt_table), \
+			.volt_table = (_volt_table), \
+			.vsel_reg = (_vsel_reg), \
+			.vsel_mask = (_vsel_mask), \
+			.enable_reg = (_enable_reg), \
+			.enable_mask = BIT(0), \
+		}, \
+		.index_table = (_index_table), \
+		.n_table = ARRAY_SIZE(_index_table), \
+	}
+
+#define MT6366_LDO1(match, _name, _min, _max, _step, _enable_reg, _vsel_reg, \
+		    _vsel_mask, _da_vsel_reg, _da_vsel_mask) \
+	[MT6366_ID_##_name] = { \
+		.desc = { \
+			.name = #_name, \
+			.of_match = match, \
+			.type = MT6358_REG_TYPE_LINEAR, \
+			.id = MT6366_ID_##_name, \
+			.uV_step = (_step), \
+			.n_voltages = ((_max) - (_min)) / (_step) + 1, \
+			.min_uV = (_min), \
+			.vsel_reg = (_vsel_reg), \
+			.vsel_mask = (_vsel_mask), \
+			.enable_reg = (_enable_reg), \
+			.enable_mask = BIT(0), \
+		}, \
+		.da_vsel_reg = (_da_vsel_reg), \
+		.da_vsel_mask = (_da_vsel_mask), \
+	}
+
+#define MT6366_REG_FIXED(match, _name, _enable_reg, _fixed_uV) \
+	[MT6366_ID_##_name] = { \
+		.desc = { \
+			.name = #_name, \
+			.of_match = match, \
+			.type = MT6358_REG_TYPE_FIXED, \
+			.id = MT6366_ID_##_name, \
+			.n_voltages = 1, \
+			.enable_reg = (_enable_reg), \
+			.enable_mask = BIT(0), \
+			.fixed_uV = (_fixed_uV), \
+		}, \
+	}
+
+static const unsigned int vdram2_voltages[] = {
+	600000, 1800000
+};
+
+static const unsigned int vsim_voltages[] = {
+	1700000, 1800000, 2700000, 3000000, 3100000
+};
+
+static const unsigned int vibr_voltages[] = {
+	1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 3300000
+};
+
+static const unsigned int vusb_voltages[] = {
+	3000000, 3100000
+};
+
+static const unsigned int vefuse_voltages[] = {
+	1700000, 1800000, 1900000
+};
+
+static const unsigned int vmch_vemc_voltages[] = {
+	2900000, 3000000, 3300000
+};
+
+static const unsigned int vcn33_voltages[] = {
+	3300000, 3400000, 3500000
+};
+
+static const unsigned int vmc_voltages[] = {
+	1800000, 2900000, 3000000, 3300000
+};
+
+static const u32 vdram2_idx[] = { 0, 12 };
+static const u32 vsim_idx[] = { 3, 4, 8, 11, 12 };
+static const u32 vibr_idx[] = { 0, 1, 2, 4, 5, 9, 11, 13 };
+static const u32 vusb_idx[] = { 3, 4 };
+static const u32 vefuse_idx[] = { 11, 12, 13 };
+static const u32 vmch_vemc_idx[] = { 2, 3, 5 };
+static const u32 vcn33_idx[] = { 1, 2, 3 };
+static const u32 vmc_idx[] = { 4, 10, 11, 13 };
+
+static int mt6358_set_voltage_sel_regmap(struct udevice *dev,
+					 struct mt6358_regulator_info *info,
+					 unsigned int sel)
+{
+	return pmic_clrsetbits(dev->parent, info->desc.vsel_reg,
+			       info->desc.vsel_mask,
+			       field_prep(info->desc.vsel_mask, sel));
+}
+
+static int mt6358_get_voltage_sel(struct udevice *dev,
+				  struct mt6358_regulator_info *info)
+{
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, info->desc.vsel_reg);
+	if (ret < 0)
+		return ret;
+
+	return field_get(info->desc.vsel_mask, ret);
+}
+
+static int mt6358_get_enable(struct udevice *dev)
+{
+	struct mt6358_regulator_info *info = dev_get_priv(dev);
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, info->desc.enable_reg);
+	if (ret < 0)
+		return ret;
+
+	return field_get(info->desc.enable_mask, ret) ? true : false;
+}
+
+static int mt6358_set_enable(struct udevice *dev, bool enable)
+{
+	struct mt6358_regulator_info *info = dev_get_priv(dev);
+
+	return pmic_clrsetbits(dev->parent, info->desc.enable_reg,
+			       info->desc.enable_mask,
+			       field_prep(info->desc.enable_mask, enable));
+}
+
+static int mt6358_get_value(struct udevice *dev)
+{
+	struct mt6358_regulator_info *info = dev_get_priv(dev);
+	int ret, idx;
+	u32 selector;
+
+	switch (info->desc.type) {
+	case MT6358_REG_TYPE_LINEAR:
+		ret = pmic_reg_read(dev->parent, info->da_vsel_reg);
+		if (ret < 0)
+			return ret;
+
+		selector = field_get(info->da_vsel_mask, ret);
+		if (selector >= info->desc.n_voltages)
+			return -EINVAL;
+
+		return info->desc.min_uV + (info->desc.uV_step * selector);
+	case MT6358_REG_TYPE_TABLE:
+		ret = mt6358_get_voltage_sel(dev, info);
+		if (ret < 0)
+			return ret;
+
+		selector = ret;
+
+		for (idx = 0; idx < info->n_table; idx++) {
+			if (info->index_table[idx] == selector)
+				return info->desc.volt_table[idx];
+		}
+
+		return -EINVAL;
+	case MT6358_REG_TYPE_FIXED:
+		return info->desc.fixed_uV;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt6358_set_value(struct udevice *dev, int uvolt)
+{
+	struct mt6358_regulator_info *info = dev_get_priv(dev);
+	u32 selector;
+	int idx;
+
+	switch (info->desc.type) {
+	case MT6358_REG_TYPE_LINEAR:
+		if (uvolt < (int)info->desc.min_uV)
+			return -EINVAL;
+
+		selector = DIV_ROUND_UP(uvolt - info->desc.min_uV,
+					info->desc.uV_step);
+		if (selector >= info->desc.n_voltages)
+			return -EINVAL;
+
+		return mt6358_set_voltage_sel_regmap(dev, info, selector);
+	case MT6358_REG_TYPE_TABLE:
+		for (idx = 0; idx < info->desc.n_voltages; idx++) {
+			if (info->desc.volt_table[idx] == (u32)uvolt)
+				return mt6358_set_voltage_sel_regmap(dev, info,
+							info->index_table[idx]);
+		}
+
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct mt6358_regulator_info mt6366_regulators[] = {
+	MT6366_BUCK("vdram1", VDRAM1, 500000, 2087500, 12500,
+		    MT6358_BUCK_VDRAM1_CON0, MT6358_BUCK_VDRAM1_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VDRAM1_DBG0, GENMASK(6, 0)),
+	MT6366_BUCK("vcore", VCORE, 500000, 1293750, 6250,
+		    MT6358_BUCK_VCORE_CON0, MT6358_BUCK_VCORE_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VCORE_DBG0, GENMASK(6, 0)),
+	MT6366_BUCK("vpa", VPA, 500000, 3650000, 50000,
+		    MT6358_BUCK_VPA_CON0, MT6358_BUCK_VPA_CON1, GENMASK(5, 0),
+		    MT6358_BUCK_VPA_DBG0, GENMASK(5, 0)),
+	MT6366_BUCK("vproc11", VPROC11, 500000, 1293750, 6250,
+		    MT6358_BUCK_VPROC11_CON0, MT6358_BUCK_VPROC11_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VPROC11_DBG0, GENMASK(6, 0)),
+	MT6366_BUCK("vproc12", VPROC12, 500000, 1293750, 6250,
+		    MT6358_BUCK_VPROC12_CON0, MT6358_BUCK_VPROC12_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VPROC12_DBG0, GENMASK(6, 0)),
+	MT6366_BUCK("vgpu", VGPU, 500000, 1293750, 6250,
+		    MT6358_BUCK_VGPU_CON0, MT6358_BUCK_VGPU_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VGPU_ELR0, GENMASK(6, 0)),
+	MT6366_BUCK("vs2", VS2, 500000, 2087500, 12500,
+		    MT6358_BUCK_VS2_CON0, MT6358_BUCK_VS2_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VS2_DBG0, GENMASK(6, 0)),
+	MT6366_BUCK("vmodem", VMODEM, 500000, 1293750, 6250,
+		    MT6358_BUCK_VMODEM_CON0, MT6358_BUCK_VMODEM_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VMODEM_DBG0, GENMASK(6, 0)),
+	MT6366_BUCK("vs1", VS1, 1000000, 2587500, 12500,
+		    MT6358_BUCK_VS1_CON0, MT6358_BUCK_VS1_ELR0, GENMASK(6, 0),
+		    MT6358_BUCK_VS1_DBG0, GENMASK(6, 0)),
+	MT6366_REG_FIXED("vrf12", VRF12, MT6358_LDO_VRF12_CON0, 1200000),
+	MT6366_REG_FIXED("vio18", VIO18, MT6358_LDO_VIO18_CON0, 1800000),
+	MT6366_REG_FIXED("vcn18", VCN18, MT6358_LDO_VCN18_CON0, 1800000),
+	MT6366_REG_FIXED("vfe28", VFE28, MT6358_LDO_VFE28_CON0, 2800000),
+	MT6366_REG_FIXED("vcn28", VCN28, MT6358_LDO_VCN28_CON0, 2800000),
+	MT6366_REG_FIXED("vxo22", VXO22, MT6358_LDO_VXO22_CON0, 2200000),
+	MT6366_REG_FIXED("vaux18", VAUX18, MT6358_LDO_VAUX18_CON0, 1800000),
+	MT6366_REG_FIXED("vbif28", VBIF28, MT6358_LDO_VBIF28_CON0, 2800000),
+	MT6366_REG_FIXED("vio28", VIO28, MT6358_LDO_VIO28_CON0, 2800000),
+	MT6366_REG_FIXED("va12", VA12, MT6358_LDO_VA12_CON0, 1200000),
+	MT6366_REG_FIXED("vrf18", VRF18, MT6358_LDO_VRF18_CON0, 1800000),
+	MT6366_REG_FIXED("vaud28", VAUD28, MT6358_LDO_VAUD28_CON0, 2800000),
+	MT6366_LDO("vdram2", VDRAM2, vdram2_voltages, vdram2_idx,
+		   MT6358_LDO_VDRAM2_CON0, MT6358_LDO_VDRAM2_ELR0, GENMASK(3, 0)),
+	MT6366_LDO("vsim1", VSIM1, vsim_voltages, vsim_idx,
+		   MT6358_LDO_VSIM1_CON0, MT6358_VSIM1_ANA_CON0, GENMASK(11, 8)),
+	MT6366_LDO("vibr", VIBR, vibr_voltages, vibr_idx,
+		   MT6358_LDO_VIBR_CON0, MT6358_VIBR_ANA_CON0, GENMASK(11, 8)),
+	MT6366_LDO("vusb", VUSB, vusb_voltages, vusb_idx,
+		   MT6358_LDO_VUSB_CON0_0, MT6358_VUSB_ANA_CON0, GENMASK(10, 8)),
+	MT6366_LDO("vefuse", VEFUSE, vefuse_voltages, vefuse_idx,
+		   MT6358_LDO_VEFUSE_CON0, MT6358_VEFUSE_ANA_CON0, GENMASK(11, 8)),
+	MT6366_LDO("vmch", VMCH, vmch_vemc_voltages, vmch_vemc_idx,
+		   MT6358_LDO_VMCH_CON0, MT6358_VMCH_ANA_CON0, GENMASK(10, 8)),
+	MT6366_LDO("vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
+		   MT6358_LDO_VEMC_CON0, MT6358_VEMC_ANA_CON0, GENMASK(10, 8)),
+	MT6366_LDO("vcn33", VCN33, vcn33_voltages, vcn33_idx,
+		   MT6358_LDO_VCN33_CON0_0, MT6358_VCN33_ANA_CON0, GENMASK(9, 8)),
+	MT6366_LDO("vmc", VMC, vmc_voltages, vmc_idx,
+		   MT6358_LDO_VMC_CON0, MT6358_VMC_ANA_CON0, GENMASK(11, 8)),
+	MT6366_LDO("vsim2", VSIM2, vsim_voltages, vsim_idx,
+		   MT6358_LDO_VSIM2_CON0, MT6358_VSIM2_ANA_CON0, GENMASK(11, 8)),
+	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, 500000, 1293750, 6250,
+		    MT6358_LDO_VSRAM_PROC11_CON0, MT6358_LDO_VSRAM_CON0,
+		    GENMASK(6, 0), MT6358_LDO_VSRAM_PROC11_DBG0, GENMASK(14, 8)),
+	MT6366_LDO1("vsram-others", VSRAM_OTHERS, 500000, 1293750, 6250,
+		    MT6358_LDO_VSRAM_OTHERS_CON0, MT6358_LDO_VSRAM_CON2,
+		    GENMASK(6, 0), MT6358_LDO_VSRAM_OTHERS_DBG0, GENMASK(14, 8)),
+	MT6366_LDO1("vsram-gpu", VSRAM_GPU, 500000, 1293750, 6250,
+		    MT6358_LDO_VSRAM_GPU_CON0, MT6358_LDO_VSRAM_CON3,
+		    GENMASK(6, 0), MT6358_LDO_VSRAM_GPU_DBG0, GENMASK(14, 8)),
+	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, 500000, 1293750, 6250,
+		    MT6358_LDO_VSRAM_PROC12_CON0, MT6358_LDO_VSRAM_CON1,
+		    GENMASK(6, 0), MT6358_LDO_VSRAM_PROC12_DBG0, GENMASK(14, 8)),
+};
+
+static int mt6358_regulator_probe(struct udevice *dev)
+{
+	struct mt6358_regulator_info *priv = dev_get_priv(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mt6366_regulators); i++) {
+		if (!strcmp(dev->name, mt6366_regulators[i].desc.of_match)) {
+			*priv = mt6366_regulators[i];
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops mt6358_regulator_ops = {
+	.get_value = mt6358_get_value,
+	.set_value = mt6358_set_value,
+	.get_enable = mt6358_get_enable,
+	.set_enable = mt6358_set_enable,
+};
+
+U_BOOT_DRIVER(mt6358_regulator) = {
+	.name = MT6358_REGULATOR_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &mt6358_regulator_ops,
+	.probe = mt6358_regulator_probe,
+	.priv_auto = sizeof(struct mt6358_regulator_info),
+};
diff --git a/include/power/mt6358.h b/include/power/mt6358.h
new file mode 100644
index 00000000000..7621ad6f951
--- /dev/null
+++ b/include/power/mt6358.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ */
+
+#ifndef __MT6358_H_
+#define __MT6358_H_
+
+#define MT6358_REGULATOR_DRIVER	"mt6358_regulator"
+
+enum {
+	MT6366_ID_VDRAM1 = 0,
+	MT6366_ID_VCORE,
+	MT6366_ID_VPA,
+	MT6366_ID_VPROC11,
+	MT6366_ID_VPROC12,
+	MT6366_ID_VGPU,
+	MT6366_ID_VS2,
+	MT6366_ID_VMODEM,
+	MT6366_ID_VS1,
+	MT6366_ID_VDRAM2,
+	MT6366_ID_VSIM1,
+	MT6366_ID_VIBR,
+	MT6366_ID_VRF12,
+	MT6366_ID_VIO18,
+	MT6366_ID_VUSB,
+	MT6366_ID_VCN18,
+	MT6366_ID_VFE28,
+	MT6366_ID_VSRAM_PROC11,
+	MT6366_ID_VCN28,
+	MT6366_ID_VSRAM_OTHERS,
+	MT6366_ID_VSRAM_GPU,
+	MT6366_ID_VXO22,
+	MT6366_ID_VEFUSE,
+	MT6366_ID_VAUX18,
+	MT6366_ID_VMCH,
+	MT6366_ID_VBIF28,
+	MT6366_ID_VSRAM_PROC12,
+	MT6366_ID_VEMC,
+	MT6366_ID_VIO28,
+	MT6366_ID_VA12,
+	MT6366_ID_VRF18,
+	MT6366_ID_VCN33,
+	MT6366_ID_VMC,
+	MT6366_ID_VAUD28,
+	MT6366_ID_VSIM2,
+	MT6366_ID_RG_MAX,
+};
+
+#define MT6358_BUCK_VPROC11_CON0		0x1388
+#define MT6358_BUCK_VPROC11_DBG0		0x139e
+#define MT6358_BUCK_VPROC11_ELR0		0x13a6
+#define MT6358_BUCK_VPROC12_CON0		0x1408
+#define MT6358_BUCK_VPROC12_DBG0		0x141e
+#define MT6358_BUCK_VPROC12_ELR0		0x1426
+#define MT6358_BUCK_VCORE_CON0			0x1488
+#define MT6358_BUCK_VCORE_DBG0			0x149e
+#define MT6358_BUCK_VCORE_ELR0			0x14aa
+#define MT6358_BUCK_VGPU_CON0			0x1508
+#define MT6358_BUCK_VGPU_ELR0			0x1526
+#define MT6358_BUCK_VMODEM_CON0			0x1588
+#define MT6358_BUCK_VMODEM_DBG0			0x159e
+#define MT6358_BUCK_VMODEM_ELR0			0x15a6
+#define MT6358_BUCK_VDRAM1_CON0			0x1608
+#define MT6358_BUCK_VDRAM1_DBG0			0x161e
+#define MT6358_BUCK_VDRAM1_ELR0			0x1626
+#define MT6358_BUCK_VS1_CON0			0x1688
+#define MT6358_BUCK_VS1_DBG0			0x169e
+#define MT6358_BUCK_VS1_ELR0			0x16ae
+#define MT6358_BUCK_VS2_CON0			0x1708
+#define MT6358_BUCK_VS2_DBG0			0x171e
+#define MT6358_BUCK_VS2_ELR0			0x172e
+#define MT6358_BUCK_VPA_CON0			0x1788
+#define MT6358_BUCK_VPA_CON1			0x178a
+#define MT6358_BUCK_VPA_DBG0			0x1792
+
+#define MT6358_LDO_VXO22_CON0			0x1a88
+#define MT6358_LDO_VA12_CON0			0x1a9c
+#define MT6358_LDO_VAUX18_CON0			0x1ab0
+#define MT6358_LDO_VAUD28_CON0			0x1ac4
+#define MT6358_LDO_VIO28_CON0			0x1ad8
+#define MT6358_LDO_VIO18_CON0			0x1aec
+#define MT6358_LDO_VDRAM2_CON0			0x1b08
+#define MT6358_LDO_VDRAM2_ELR0			0x1b78
+#define MT6358_LDO_VEMC_CON0			0x1b1c
+#define MT6358_LDO_VUSB_CON0_0			0x1b30
+#define MT6358_LDO_VSRAM_PROC11_CON0		0x1b46
+#define MT6358_LDO_VSRAM_PROC11_DBG0		0x1b60
+#define MT6358_LDO_VSRAM_PROC12_CON0		0x1b88
+#define MT6358_LDO_VSRAM_PROC12_DBG0		0x1ba2
+#define MT6358_LDO_VSRAM_OTHERS_CON0		0x1ba6
+#define MT6358_LDO_VSRAM_OTHERS_DBG0		0x1bc0
+#define MT6358_LDO_VSRAM_GPU_CON0		0x1bc8
+#define MT6358_LDO_VSRAM_GPU_DBG0		0x1be2
+#define MT6358_LDO_VSRAM_CON0			0x1bee
+#define MT6358_LDO_VSRAM_CON1			0x1bf0
+#define MT6358_LDO_VSRAM_CON2			0x1bf2
+#define MT6358_LDO_VSRAM_CON3			0x1bf4
+#define MT6358_LDO_VFE28_CON0			0x1c08
+#define MT6358_LDO_VRF18_CON0			0x1c1c
+#define MT6358_LDO_VRF12_CON0			0x1c30
+#define MT6358_LDO_VEFUSE_CON0			0x1c44
+#define MT6358_LDO_VCN18_CON0			0x1c58
+#define MT6358_LDO_VMC_CON0			0x1cc4
+#define MT6358_LDO_VMCH_CON0			0x1cd8
+#define MT6358_LDO_VIBR_CON0			0x1d08
+#define MT6358_LDO_VCN33_CON0_0			0x1d1c
+#define MT6358_LDO_VSIM1_CON0			0x1d48
+#define MT6358_LDO_VSIM2_CON0			0x1d5c
+#define MT6358_LDO_VCN28_CON0			0x1d88
+#define MT6358_LDO_VBIF28_CON0			0x1d9e
+
+#define MT6358_VSIM1_ANA_CON0			0x1e2c
+#define MT6358_VSIM2_ANA_CON0			0x1e30
+#define MT6358_VUSB_ANA_CON0			0x1e34
+#define MT6358_VEMC_ANA_CON0			0x1e38
+#define MT6358_VIO28_ANA_CON0			0x1e40
+#define MT6358_VIBR_ANA_CON0			0x1e44
+#define MT6358_VMCH_ANA_CON0			0x1e48
+#define MT6358_VMC_ANA_CON0			0x1e4c
+#define MT6358_VRF18_ANA_CON0			0x1e88
+#define MT6358_VCN18_ANA_CON0			0x1e8c
+#define MT6358_VIO18_ANA_CON0			0x1e94
+#define MT6358_VEFUSE_ANA_CON0			0x1e98
+#define MT6358_VRF12_ANA_CON0			0x1e9c
+#define MT6358_VDRAM2_ANA_CON0			0x1eaa
+#define MT6358_VA12_ANA_CON0			0x1eb2
+#define MT6358_VCN33_ANA_CON0			0x1e28
+
+#endif

-- 
2.43.0

