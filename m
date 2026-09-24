Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BD8C98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 16:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AEBF607A1;
	Thu, 24 Sep 2026 16:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CAFLubihsZZm; Thu, 24 Sep 2026 16:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD7E960B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790266389;
	b=V5xgj84xmULk6aC415GPnhwM11SLM2R8JERuPa0HRaBNTmMF+RpqILmHrhtXC6wLAAYB
	 hytDP022tIKB3DqcVb2HBEdKoy+hapdFxENPZZGyypBCL4XtkmhgvFV7xqVfkgerP+oYo
	 8y5u54ssmyItH0Ce4sF2IXrS8IJ1NHB0aqto7L8CLd6lfmMBrJi1/J3f3dkSmdNp2MRR9
	 0kOvi3HSYooAIJJGKUUreQsNPICpZJPkZAfW6iP+60djlREAWGo8gSNSZhYe6eUXeHzx1
	 emiCndi4hHSG6EApAi4mIaXbjlWdUDLNOy6oERhTBiR1Hqq6WHIL1YYcxtp60yS0jEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790266389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+7kDFRV6lBVbirunnyqdowyepuh2vI79qImfNWcsuD0=;
	b=oGmR35WK4fwN5xRNPe27ixV/aKUXRT5W6/5IQQDg48vlXZPwfznMrURtE1/pm6EdwghT
	 y+vvy/kwXNBFafreogtqLVV3sPpnprkRHWu1gGN6sFxO7wIaR2idm6ZNNJ5vEXbR0nHse
	 oo0Pguz1MXl/T3xvC6PZ4DivWJFu9krnRFb1rEjhPXT/An4uonzvH7Ys8zH/Ok8N9uNU8
	 D+iwSgt0nJbfEIcNj21v1SnH79s+vTDQRlGgyWGgaC/qv9U6wfTY15ko4TPT4xk7jWivD
	 Vzap7i0bG68LEUG+d1lBdoXVRy+sNvKTIjM2A8QuGGRQQzEbPK7Wviri9b4tVynLYzw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790266389;
	bh=+7kDFRV6lBVbirunnyqdowyepuh2vI79qImfNWcsuD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9fqxiQ27kSfMGyf/y3OjAlX+BN5yGUZcAt7SBcK7Q+/3CtON5UFjOe6EpMMpfVFt
	 jGVXNqx/f5KTfk727ZtvEGjCdIIfTMsSXuAI64w2tbhpbvZkCjvRUYaEE0zADIcN8/
	 JgFxSEsAdUTdLvRDfjfW4ZudlWVHV4WrUDx5o1ritXDFTMww2NQB/LzM9iW1XjxNhe
	 6v4ysZy65TB2Xxz3QMNEP4MYrmB4D5F9em5fDG76obQBSNaAeZL9n2cm8fCYmxBFoA
	 lwQr8SbSyXplhaBFZ5evAKOhXsERLfhLKZqXVRwz9zuzOKUFR3lA8zku7BfwkPYhxb
	 OvFazphMl/fxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD7E960B26;
	Thu, 24 Sep 2026 16:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 706B213B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DCFC40765
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBaTmnVfQovY for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 16:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82C0840835
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790266380;
 b=nzB4gVHJ7c5I/pcgFJAXO/wxec8Mvx96+sanjnm+b6Q3nkuv6HK/mb89ffIB+7mJfWgZ
 vH17EtWpXC6df9MYc0mfGY1Xllec9Ac+lblJY6oWoGSB/0scaXtVCAf3aq+AY0R/3bKE2
 xT5yFX7cdggl/MXKiBV+6ZEfQabg40gr9m+yUyXJpaQwGK8KAuub4pZyCoKUusnCSLOtx
 gnwKtCWmq1NDye32nTMpT8xi4zPV0AvBXYd5ItkKEYwuUg9A/ftK+cggOVhTFJj1BjEJF
 RdGY/6habEFdW8BCOUqoxpkDTFnGHkn/GAJzWHzgcQwHFrGl1pjzUzzqRASBA3vEqMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790266380;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=+7kDFRV6lBVbirunnyqdowyepuh2vI79qImfNWcsuD0=;
 b=nC0YLmUmqoWO9fhGDB6R1WcTw0lgUF1qoxRbfdlJ193JvjSBAYAemPQv7o2XEF9fUOkz
 J2owoIwG0NFgyYw5Oxyxt9n9JO3OMTpnFAoW/J7QhdU3lpTe9dgr4hHXYmO33pdFIpgkC
 F5pjZvRpbJZZ7u+k33EzooBjiEBRM/ORs+Ua7jOY8EPBgAoJGEwTdQ4dPmaFDuzxNMWXL
 4pcLAcbS1yl558Fdk7VIQw6pvUawKV+P9f25nCGwIJms8RE0r99ENhh39ISgFFOS9QSBL
 wPrmy+/3CfQIr5fHaZsINmtC+K+kxRMXEArwB1Jzi4lzY+dDlf7MX69lnVrwhJLW+SA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=L0tWfPUD; 
 arc=none smtp.remote-ip=148.251.105.195
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.251.105.195;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=L0tWfPUD
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82C0840835
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790265774;
 bh=/BLrQkzcPOJa4k1cDVAfsEaXdHe8flT3Irxs33I+sh0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=L0tWfPUD96AJulOPtnCsYQfHy9qxHYs3i2eBDW8a5b8N1781dfxSCNeet68oZkHX+
 V2dUDE7dQ3Z2yeh3yeoYUgjKiwLNQr1k7+DncXDMjvdMn548U0VLCG/wIV0wg6jcQ3
 cP+dksaYyOamBaPAIeR9jMf6eqLSTMWqdXzcS8GQf2K0U9J6KBed736x6ZUZ7kON/1
 CYdZwVRPpjKqGwv97D1IG/Mwbe+uWyMHBi+cecHIfUCZ/NvfZ5iOzg88BHroJ51hpE
 qWGYUlNnO7/UDslkEGx9GOERXewECv4locLBX2Hv2FB+5DMIKNnJzkFVK03ScOhmI6
 nhqH7GU6eIDRw==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 345E117E0B0F;
 Thu, 24 Sep 2026 18:02:53 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Thu, 24 Sep 2026 18:02:51 +0200
Subject: [PATCH 3/3] drivers: power: regulator: add driver for the
 regulators of MT6373
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-mt8196-spmi-v1-3-dd2263403691@collabora.com>
References: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
In-Reply-To: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Guodong Xu <guodong@riscstar.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=29018;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=/BLrQkzcPOJa4k1cDVAfsEaXdHe8flT3Irxs33I+sh0=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtUmq+y58DyZdDEgdsHJ7Bpv5FN8qWjpL7wyM1
 f5iIp6XaaKJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarVJqgAKCRDT67WWa7mR
 lmRgD/wK5XpRKzzpAxnvvOB8jGsQBjB7xaioTsth7mvBTmWMN0tU9N3oIS+6bXF6z133iw+SyKa
 zt6ehnbhAd2mZAU4Jak5r8fXlYsMkmBOE1BLdRHhZ5om9Vz4TPK8rQfm7WlRGt+tu0tLQLFR355
 hjzkpfADVxJVlSFTXO7Hf7y3RSEQDnlZxwV8MSmKtwXkhnuDIIPuuiEaTPHS3tv06EM4QZRcCmU
 8e84SJvRwr/i6YZOL82bdnrApwLYZNZcDIzd/zxh7Suov2Vz2HvqyDZx6P94XlWkkOue1syarxE
 QTnC3NVWX0D1rhT2wAJPXY0FEfdmua7XA0wGdZ/sMwlJrc39fX6LDwEXRaI+WPwUCwXTmkMa5xa
 TtlBAZzINzQL766KQpQLzmzw721bKjx/PfmcHoZsIYwr2ubSTGnnPuX+b6pBbQUTDSisL1a60Vg
 +7HvG1YSW6U5sZa5q/Udlu1ZoFlqGzvg5F/glpG7eR5V2c4bw/weMwbKm5LPESUXEVmqlCUi3CU
 j4RhHin0WhkG/t9aZrCtbPQ2vlOwqKmoO3uD8YLMmpCjKrcRV+lCXuQhi7rm1+oo0QX6JpCExSc
 +bK5E5gdR5CSJH4ezbl+loaxMEYhNDL8sDSb5wZboKrgtBZxs0nP9Giqyg//MoXErMvTXjaezw7
 33z3kLpy6ynPRbg==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

This driver supports basic operations (get/set voltage, enable/disable)
for regulators found in the MediaTek MT6373 PMIC.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 drivers/power/regulator/Kconfig            |   9 +
 drivers/power/regulator/Makefile           |   1 +
 drivers/power/regulator/mt6373_regulator.c | 797 +++++++++++++++++++++++++++++
 3 files changed, 807 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 428689702c8..b529285cfd7 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -581,6 +581,15 @@ config DM_REGULATOR_MT6359
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config DM_REGULATOR_MT6373
+	bool "Enable driver for MediaTek MT6373 PMIC regulators"
+	depends on DM_REGULATOR && PMIC_MTK
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6373 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config DM_REGULATOR_PMBUS_HELPER
 	bool "Shared regulator helpers for PMBus chip drivers"
 	depends on DM_REGULATOR && PMBUS && DM_I2C
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index e17937f4c26..ce8b465afc4 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_$(PHASE_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_DA9063) += da9063.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX77663) += max77663_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX8907) += max8907_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MT6373) += mt6373_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
 obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PFUZE100) += pfuze100.o
diff --git a/drivers/power/regulator/mt6373_regulator.c b/drivers/power/regulator/mt6373_regulator.c
new file mode 100644
index 00000000000..7927a620fb6
--- /dev/null
+++ b/drivers/power/regulator/mt6373_regulator.c
@@ -0,0 +1,797 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Copyright (c) 2025-2026 Collabora Ltd
+ * Authors: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *          Arnaud Ferraris <arnaud.ferraris@collabora.com>
+ */
+
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+/**
+ * struct linear_range - table of selector - value pairs
+ *
+ * Define a lookup-table for range of values. Intended to help when looking
+ * for a register value matching certaing physical measure (like voltage).
+ * Usable when increment of one in register always results a constant increment
+ * of the physical measure (like voltage).
+ *
+ * @min:  Lowest value in range
+ * @min_sel: Lowest selector for range
+ * @max_sel: Highest selector for range
+ * @step: Value step size
+ */
+struct linear_range {
+	unsigned int min;
+	unsigned int min_sel;
+	unsigned int max_sel;
+	unsigned int step;
+};
+
+/* Initialize struct linear_range for regulators */
+#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
+{									\
+	.min		= _min_uV,					\
+	.min_sel	= _min_sel,					\
+	.max_sel	= _max_sel,					\
+	.step		= _step_uV,					\
+}
+
+/* MT6373 registers */
+#define MT6373_TOP_CFG_ELR5			0x117
+#define MT6373_TOP_CFG_ELR5_SHUTDOWN		BIT(0)
+
+#define MT6373_PMIC_RG_BUCK0_EN_ADDR		0x210
+#define MT6373_PMIC_RG_BUCK_VBUCK0_EN_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK1_EN_BIT	1
+#define MT6373_PMIC_RG_BUCK_VBUCK2_EN_BIT	2
+#define MT6373_PMIC_RG_BUCK_VBUCK3_EN_BIT	3
+#define MT6373_PMIC_RG_BUCK_VBUCK4_EN_BIT	4
+#define MT6373_PMIC_RG_BUCK_VBUCK5_EN_BIT	5
+#define MT6373_PMIC_RG_BUCK_VBUCK6_EN_BIT	6
+#define MT6373_PMIC_RG_BUCK_VBUCK7_EN_BIT	7
+
+#define MT6373_PMIC_RG_BUCK1_EN_ADDR		0x213
+#define MT6373_PMIC_RG_BUCK_VBUCK8_EN_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK9_EN_BIT	1
+
+#define MT6373_PMIC_RG_BUCK0_LP_ADDR		0x216
+#define MT6373_PMIC_RG_BUCK_VBUCK0_LP_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK1_LP_BIT	1
+#define MT6373_PMIC_RG_BUCK_VBUCK2_LP_BIT	2
+#define MT6373_PMIC_RG_BUCK_VBUCK3_LP_BIT	3
+#define MT6373_PMIC_RG_BUCK_VBUCK4_LP_BIT	4
+#define MT6373_PMIC_RG_BUCK_VBUCK5_LP_BIT	5
+#define MT6373_PMIC_RG_BUCK_VBUCK6_LP_BIT	6
+#define MT6373_PMIC_RG_BUCK_VBUCK7_LP_BIT	7
+
+#define MT6373_PMIC_RG_BUCK1_LP_ADDR		0x219
+#define MT6373_PMIC_RG_BUCK_VBUCK8_LP_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK9_LP_BIT	1
+
+#define MT6373_PMIC_RG_BUCK_VBUCK0_VOSEL_ADDR	0x21c
+#define MT6373_PMIC_RG_BUCK_VBUCK1_VOSEL_ADDR	0x21d
+#define MT6373_PMIC_RG_BUCK_VBUCK2_VOSEL_ADDR	0x21e
+#define MT6373_PMIC_RG_BUCK_VBUCK3_VOSEL_ADDR	0x21f
+#define MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_ADDR	0x220
+#define MT6373_PMIC_RG_BUCK_VBUCK5_VOSEL_ADDR	0x221
+#define MT6373_PMIC_RG_BUCK_VBUCK6_VOSEL_ADDR	0x222
+#define MT6373_PMIC_RG_BUCK_VBUCK7_VOSEL_ADDR	0x223
+#define MT6373_PMIC_RG_BUCK_VBUCK8_VOSEL_ADDR	0x224
+#define MT6373_PMIC_RG_BUCK_VBUCK9_VOSEL_ADDR	0x225
+#define MT6373_PMIC_RG_BUCK_VOSEL_MASK		GENMASK(7, 0)
+
+#define MT6373_PLG_CFG_ELR1			0x37b
+#define MT6373_ELR_VARIANT_MASK			GENMASK(3, 2)
+#define MT6373_ELR_VARIANT_MT6373CW		1
+#define MT6373_RG_RSV_SWREG_H			0x9d9
+#define MT6373_RG_RSV_SWREG_VBUCK4_HW_CTRL	BIT(0)
+
+#define MT6373_BUCK_TOP_KEY_PROT_LO		0x13fa
+
+#define MT6373_PMIC_RG_BUCK1_FCCM_ADDR		0x196d
+#define MT6373_PMIC_RG_VBUCK8_FCCM_BIT		6
+#define MT6373_PMIC_RG_VBUCK9_FCCM_BIT		7
+
+#define MT6373_PMIC_RG_BUCK0_FCCM_ADDR		0x1a02
+#define MT6373_PMIC_RG_VBUCK0_FCCM_BIT		0
+#define MT6373_PMIC_RG_VBUCK1_FCCM_BIT		1
+#define MT6373_PMIC_RG_VBUCK2_FCCM_BIT		2
+#define MT6373_PMIC_RG_VBUCK3_FCCM_BIT		3
+
+#define MT6373_PMIC_RG_BUCK0_1_FCCM_ADDR	0x1a82
+#define MT6373_PMIC_RG_VBUCK4_FCCM_BIT		0
+#define MT6373_PMIC_RG_VBUCK5_FCCM_BIT		1
+#define MT6373_PMIC_RG_VBUCK6_FCCM_BIT		2
+#define MT6373_PMIC_RG_VBUCK7_FCCM_BIT		3
+
+#define MT6373_PMIC_RG_VSRAM_DIGRF_AIF_VOSEL_ADDR 0x1b09
+#define MT6373_PMIC_RG_VSRAM_DIGRF_AIF_VOSEL_MASK GENMASK(6, 0)
+
+#define MT6373_PMIC_RG_LDO_VAUD18_ADDR		0x1b57
+#define MT6373_PMIC_RG_LDO_VUSB_ADDR		0x1b65
+#define MT6373_PMIC_RG_LDO_VAUX18_ADDR		0x1b73
+#define MT6373_PMIC_RG_LDO_VRF13_AIF_ADDR	0x1b81
+#define MT6373_PMIC_RG_LDO_VRF18_AIF_ADDR	0x1b8f
+#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_ADDR	0x1b9d
+#define MT6373_PMIC_RG_LDO_VCN33_1_ADDR		0x1bd7
+#define MT6373_PMIC_RG_LDO_VCN33_2_ADDR		0x1be5
+#define MT6373_PMIC_RG_LDO_VCN33_3_ADDR		0x1bf3
+#define MT6373_PMIC_RG_LDO_VCN18IO_ADDR		0x1c01
+#define MT6373_PMIC_RG_LDO_VRF09_AIF_ADDR	0x1c0f
+#define MT6373_PMIC_RG_LDO_VRF12_AIF_ADDR	0x1c1d
+#define MT6373_PMIC_RG_LDO_VANT18_ADDR		0x1c57
+#define MT6373_PMIC_RG_LDO_VEFUSE_ADDR		0x1c73
+#define MT6373_PMIC_RG_LDO_VMCH_ADDR		0x1c81
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR	0x1c8f
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_HIGH_ADDR	MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_LOW_ADDR	MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT	BIT(2)
+#define MT6373_PMIC_RG_LDO_VMC_ADDR		0x1c90
+#define MT6373_PMIC_RG_LDO_VIBR_ADDR		0x1c9e
+#define MT6373_PMIC_RG_LDO_VIO28_ADDR		0x1cd7
+#define MT6373_PMIC_RG_LDO_VFP_ADDR		0x1ce5
+#define MT6373_PMIC_RG_LDO_VTP_ADDR		0x1cf3
+#define MT6373_PMIC_RG_LDO_VSIM1_ADDR		0x1d01
+#define MT6373_PMIC_RG_LDO_VSIM2_ADDR		0x1d10
+#define MT6373_PMIC_RG_LDO_VSIM2_LP_ADDR	0x1d10
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_ADDR	0x1d57
+#define MT6373_PMIC_RG_VAUX18_VOCAL_ADDR	0x1dd8
+#define MT6373_PMIC_RG_VAUX18_VOSEL_ADDR	0x1dd9
+#define MT6373_PMIC_RG_VUSB_VOCAL_ADDR		0x1ddc
+#define MT6373_PMIC_RG_VUSB_VOSEL_ADDR		0x1ddd
+#define MT6373_PMIC_RG_VCN33_1_VOCAL_ADDR	0x1de0
+#define MT6373_PMIC_RG_VCN33_1_VOSEL_ADDR	0x1de1
+#define MT6373_PMIC_RG_VCN33_2_VOCAL_ADDR	0x1de4
+#define MT6373_PMIC_RG_VCN33_2_VOSEL_ADDR	0x1de5
+#define MT6373_PMIC_RG_VCN33_3_VOCAL_ADDR	0x1de8
+#define MT6373_PMIC_RG_VCN33_3_VOSEL_ADDR	0x1de9
+#define MT6373_PMIC_RG_VMCH_VOCAL_ADDR		0x1dec
+#define MT6373_PMIC_RG_VMCH_VOSEL_ADDR		0x1ded
+#define MT6373_PMIC_RG_VMCH_EINT_HIGH_VOSEL_ADDR MT6373_PMIC_RG_VMCH_VOSEL_ADDR
+#define MT6373_PMIC_RG_VMCH_EINT_LOW_VOSEL_ADDR	MT6373_PMIC_RG_VMCH_VOSEL_ADDR
+#define MT6373_PMIC_RG_VEFUSE_VOCAL_ADDR	0x1df0
+#define MT6373_PMIC_RG_VEFUSE_VOSEL_ADDR	0x1df1
+#define MT6373_PMIC_RG_VMC_VOCAL_ADDR		0x1df4
+#define MT6373_PMIC_RG_VMCH_EINT_HIGH_VOCAL_ADDR MT6373_PMIC_RG_VMC_VOCAL_ADDR
+#define MT6373_PMIC_RG_VMCH_EINT_LOW_VOCAL_ADDR	MT6373_PMIC_RG_VMC_VOCAL_ADDR
+#define MT6373_PMIC_RG_VMC_VOSEL_ADDR		0x1df5
+#define MT6373_PMIC_RG_VIBR_VOCAL_ADDR		0x1df8
+#define MT6373_PMIC_RG_VIBR_VOSEL_ADDR		0x1df9
+#define MT6373_PMIC_RG_VIO28_VOCAL_ADDR		0x1dfc
+#define MT6373_PMIC_RG_VIO28_VOSEL_ADDR		0x1dfd
+#define MT6373_PMIC_RG_VFP_VOCAL_ADDR		0x1e00
+#define MT6373_PMIC_RG_VFP_VOSEL_ADDR		0x1e01
+#define MT6373_PMIC_RG_VTP_VOCAL_ADDR		0x1e04
+#define MT6373_PMIC_RG_VTP_VOSEL_ADDR		0x1e05
+#define MT6373_PMIC_RG_VSIM1_VOCAL_ADDR		0x1e08
+#define MT6373_PMIC_RG_VSIM1_VOSEL_ADDR		0x1e09
+#define MT6373_PMIC_RG_VSIM2_VOCAL_ADDR		0x1e0c
+#define MT6373_PMIC_RG_VSIM2_VOSEL_ADDR		0x1e0d
+#define MT6373_PMIC_RG_VAUD18_VOCAL_ADDR	0x1e58
+#define MT6373_PMIC_RG_VAUD18_VOSEL_ADDR	0x1e59
+#define MT6373_PMIC_RG_VRF18_AIF_VOCAL_ADDR	0x1e5c
+#define MT6373_PMIC_RG_VRF18_AIF_VOSEL_ADDR	0x1e5d
+#define MT6373_PMIC_RG_VCN18IO_VOCAL_ADDR	0x1e60
+#define MT6373_PMIC_RG_VCN18IO_VOSEL_ADDR	0x1e61
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_ADDR	0x1e64
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_ADDR	0x1e65
+#define MT6373_PMIC_RG_VANT18_VOCAL_ADDR	0x1e68
+#define MT6373_PMIC_RG_VANT18_VOSEL_ADDR	0x1e69
+#define MT6373_PMIC_RG_VRF13_AIF_VOCAL_ADDR	0x1ed8
+#define MT6373_PMIC_RG_VRF13_AIF_VOSEL_ADDR	0x1ed9
+#define MT6373_PMIC_RG_VRF12_AIF_VOCAL_ADDR	0x1edc
+#define MT6373_PMIC_RG_VRF12_AIF_VOSEL_ADDR	0x1edd
+#define MT6373_PMIC_RG_VRF09_AIF_VOCAL_ADDR	0x1f58
+#define MT6373_PMIC_RG_VRF09_AIF_VOSEL_ADDR	0x1f59
+#define MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK	GENMASK(7, 0)
+
+#define EN_SET_OFFSET			0x1
+#define EN_CLR_OFFSET			0x2
+
+enum {
+	MT6373_ID_VBUCK0,
+	MT6373_ID_VBUCK1,
+	MT6373_ID_VBUCK2,
+	MT6373_ID_VBUCK3,
+	MT6373_ID_VBUCK4,
+	MT6373_ID_VBUCK5,
+	MT6373_ID_VBUCK6,
+	MT6373_ID_VBUCK7,
+	MT6373_ID_VBUCK8,
+	MT6373_ID_VBUCK9,
+	MT6373_ID_VANT18,
+	MT6373_ID_VAUD18,
+	MT6373_ID_VAUX18,
+	MT6373_ID_VCN18IO,
+	MT6373_ID_VCN33_1,
+	MT6373_ID_VCN33_2,
+	MT6373_ID_VCN33_3,
+	MT6373_ID_VEFUSE,
+	MT6373_ID_VFP,
+	MT6373_ID_VIBR,
+	MT6373_ID_VIO28,
+	MT6373_ID_VMC,
+	MT6373_ID_VMCH,
+	MT6373_ID_VMCH_EINT_HIGH,
+	MT6373_ID_VMCH_EINT_LOW,
+	MT6373_ID_VRF09_AIF,
+	MT6373_ID_VRF12_AIF,
+	MT6373_ID_VRF13_AIF,
+	MT6373_ID_VRF18_AIF,
+	MT6373_ID_VRFIO18_AIF,
+	MT6373_ID_VSRAM_DIGRF_AIF,
+	MT6373_ID_VTP,
+	MT6373_ID_VUSB,
+};
+
+/**
+ * struct mt6373_regulator_info - MT6373 regulators information
+ */
+struct mt6373_regulator_info {
+	int id;
+	char *name;
+	char *supply_name;
+	u16 enable_reg;
+	u8  enable_mask;
+	u16 vsel_reg;
+	u8  vsel_mask;
+	u16 vsel_range_reg;
+	u8  vsel_range_mask;
+	const struct linear_range *linear_ranges;
+	int n_linear_ranges;
+};
+
+struct mt6373_regulator_data {
+	u16 base;
+	struct udevice *pmic;
+};
+
+struct mt6373_regulator {
+	struct mt6373_regulator_data *data;
+	const struct mt6373_regulator_info *info;
+};
+
+#define MT6373_BUCK(match, vreg, en_reg)			\
+[MT6373_ID_##vreg] = {						\
+	.id = MT6373_ID_##vreg,					\
+	.name = match,						\
+	.supply_name = "vsys-"match,				\
+	.enable_reg = en_reg,					\
+	.enable_mask = BIT(MT6373_PMIC_RG_BUCK_##vreg##_EN_BIT),\
+	.vsel_reg = MT6373_PMIC_RG_BUCK_##vreg##_VOSEL_ADDR,	\
+	.vsel_mask = MT6373_PMIC_RG_BUCK_VOSEL_MASK,		\
+	.linear_ranges = buck_volt_ranges,			\
+	.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),	\
+}
+
+#define MT6373_LDO_L(match, vreg, in_sup)			\
+[MT6373_ID_##vreg] = {						\
+	.id = MT6373_ID_##vreg,					\
+	.name = match,						\
+	.supply_name = in_sup,					\
+	.enable_reg = MT6373_PMIC_RG_LDO_##vreg##_ADDR,		\
+	.enable_mask = BIT(0),					\
+	.vsel_reg = MT6373_PMIC_RG_##vreg##_VOSEL_ADDR,		\
+	.vsel_mask = MT6373_PMIC_RG_##vreg##_VOSEL_MASK,	\
+	.linear_ranges = ldo_linear_volt_ranges,		\
+	.n_linear_ranges = ARRAY_SIZE(ldo_linear_volt_ranges),	\
+}
+
+#define MT6373_LDO_VT(match, vreg, in_sup, vrnum)		\
+[MT6373_ID_##vreg] = {						\
+	.id = MT6373_ID_##vreg,					\
+	.name = match,						\
+	.supply_name = in_sup,					\
+	.enable_reg = MT6373_PMIC_RG_LDO_##vreg##_ADDR,		\
+	.enable_mask = BIT(0),					\
+	.vsel_reg = MT6373_PMIC_RG_##vreg##_VOCAL_ADDR,		\
+	.vsel_mask = MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK,	\
+	.vsel_range_reg = MT6373_PMIC_RG_##vreg##_VOSEL_ADDR,	\
+	.vsel_range_mask = MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK,	\
+	.linear_ranges = ldo_volt_ranges##vrnum,		\
+	.n_linear_ranges = ARRAY_SIZE(ldo_volt_ranges##vrnum),	\
+}
+
+static const struct linear_range buck_volt_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 191, 6250),
+};
+
+static const struct linear_range ldo_volt_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges3[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges4[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges5[] = {
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+};
+
+static const struct linear_range ldo_linear_volt_ranges[] = {
+	REGULATOR_LINEAR_RANGE(400000, 0, 127, 6250),
+};
+
+/* The array is indexed by id(MT6373_ID_XXX) */
+static struct mt6373_regulator_info mt6373_regulators_info[] = {
+	MT6373_BUCK("vbuck0", VBUCK0, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck1", VBUCK1, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck2", VBUCK2, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck3", VBUCK3, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck4", VBUCK4, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck5", VBUCK5, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck6", VBUCK6, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck7", VBUCK7, MT6373_PMIC_RG_BUCK0_EN_ADDR),
+	MT6373_BUCK("vbuck8", VBUCK8, MT6373_PMIC_RG_BUCK1_EN_ADDR),
+	MT6373_BUCK("vbuck9", VBUCK9, MT6373_PMIC_RG_BUCK1_EN_ADDR),
+	MT6373_LDO_VT("vant18", VANT18, "vs1-ldo1", 3),
+	MT6373_LDO_VT("vaud18", VAUD18, "vs1-ldo1", 3),
+	MT6373_LDO_VT("vaux18", VAUX18, "vsys-ldo2", 2),
+	MT6373_LDO_VT("vcn18io", VCN18IO, "vs1-ldo1", 3),
+	MT6373_LDO_VT("vcn33-1", VCN33_1, "vsys-ldo1", 4),
+	MT6373_LDO_VT("vcn33-2", VCN33_2, "vsys-ldo1", 4),
+	MT6373_LDO_VT("vcn33-3", VCN33_3, "vsys-ldo2", 4),
+	MT6373_LDO_VT("vefuse", VEFUSE, "vsys-ldo2", 1),
+	MT6373_LDO_VT("vfp", VFP, "vsys-ldo2", 1),
+	MT6373_LDO_VT("vibr", VIBR, "vsys-ldo2", 1),
+	MT6373_LDO_VT("vio28", VIO28, "vsys-ldo2", 1),
+	MT6373_LDO_VT("vmc", VMC, "vsys-ldo1", 1),
+	MT6373_LDO_VT("vmch", VMCH, "vsys-ldo3", 4),
+	MT6373_LDO_VT("vmch-eint-high", VMCH_EINT_HIGH, "vsys-ldo3", 4),
+	MT6373_LDO_VT("vmch-eint-low", VMCH_EINT_LOW, "vsys-ldo3", 4),
+	MT6373_LDO_VT("vrf09-aif", VRF09_AIF, "vs3-ldo1", 3),
+	MT6373_LDO_VT("vrf12-aif", VRF12_AIF, "vs2-ldo1", 5),
+	MT6373_LDO_VT("vrf13-aif", VRF13_AIF, "vs2-ldo1", 3),
+	MT6373_LDO_VT("vrf18-aif", VRF18_AIF, "vs1-ldo1", 3),
+	MT6373_LDO_VT("vrfio18-aif", VRFIO18_AIF, "vs1-ldo1", 3),
+	MT6373_LDO_L("vsram-digrf-aif", VSRAM_DIGRF_AIF, "vs3-ldo1"),
+	MT6373_LDO_VT("vtp", VTP, "vsys-ldo2", 1),
+	MT6373_LDO_VT("vusb", VUSB, "vsys-ldo2", 1),
+};
+
+static u8 mt6373_read(struct mt6373_regulator *reg, u16 addr, u8 *value)
+{
+	return pmic_read(reg->data->pmic, reg->data->base + addr, value, 1);
+}
+
+static int mt6373_write(struct mt6373_regulator *reg, u16 addr, u8 value)
+{
+	return pmic_write(reg->data->pmic, reg->data->base + addr, &value, 1);
+}
+
+static int mt6373_clear_bits(struct mt6373_regulator *reg, u16 addr, u8 mask)
+{
+	int ret;
+	u8 val;
+
+	ret = mt6373_read(reg, addr, &val);
+	if (ret)
+		return ret;
+
+	return mt6373_write(reg, addr, val & ~mask);
+}
+
+static int mt6373_set_bits(struct mt6373_regulator *reg, u16 addr, u8 mask)
+{
+	int ret;
+	u8 val;
+
+	ret = mt6373_read(reg, addr, &val);
+	if (ret)
+		return ret;
+
+	return mt6373_write(reg, addr, val | mask);
+}
+
+static int mt6373_regulator_get_value(struct udevice *dev)
+{
+	struct mt6373_regulator *plat = dev_get_plat(dev);
+	const struct linear_range *range;
+	int ret, nranges = plat->info->n_linear_ranges;
+	u8 val;
+
+	if (nranges > 1) {
+		ret = mt6373_read(plat, plat->info->vsel_range_reg, &val);
+		if (ret < 0)
+			return ret;
+
+		if (val >= nranges) {
+			dev_err(dev,
+				"Read value (%u) out of available ranges (%d)\n",
+				val, nranges);
+			return -EINVAL;
+		}
+
+		range = &plat->info->linear_ranges[val];
+	} else {
+		range = plat->info->linear_ranges;
+	}
+
+	ret = mt6373_read(plat, plat->info->vsel_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= plat->info->vsel_mask;
+
+	return (range->min + range->step * val);
+}
+
+static int mt6373_regulator_set_value(struct udevice *dev, int uV)
+{
+	struct mt6373_regulator *plat = dev_get_plat(dev);
+	const struct linear_range *range = NULL;
+	int i, max, ret, nranges = plat->info->n_linear_ranges;
+	unsigned int vsel;
+
+	if (nranges > 1) {
+		for (i = 0; i < nranges; i++) {
+			if (uV < plat->info->linear_ranges[i].min) {
+				if (i) {
+					i--;
+					range = &plat->info->linear_ranges[i];
+					break;
+				}
+
+				dev_err(dev,
+					"Requested voltage (%d) is lower than"
+					" minimum regulator voltage (%d)\n",
+					uV, plat->info->linear_ranges[0].min);
+				return -EINVAL;
+			}
+		}
+
+		if (!range) {
+			i = nranges - 1;
+			max = plat->info->linear_ranges[i].min
+				+ (plat->info->linear_ranges[i].max_sel
+					* plat->info->linear_ranges[i].step);
+
+			if (uV > max)
+				dev_err(dev,
+					"Requested voltage (%d) is higher than"
+					" maximum regulator voltage (%d)\n",
+					uV, max);
+			else
+				range = &plat->info->linear_ranges[i];
+		}
+
+		if (!range) {
+			dev_err(dev,
+				"Unable to determine proper range for value (%d)\n",
+				uV);
+			return -EINVAL;
+		}
+
+		ret = mt6373_write(plat, plat->info->vsel_range_reg,
+				   (u8)i & plat->info->vsel_range_mask);
+		if (ret)
+			return ret;
+	} else {
+		range = plat->info->linear_ranges;
+	}
+
+	vsel = (uV - range->min) / range->step;
+	return mt6373_write(plat, plat->info->vsel_reg,
+			    (u8)vsel & plat->info->vsel_mask);
+}
+
+static int mt6373_vmch_eint_enable(struct mt6373_regulator *reg)
+{
+	int ret;
+
+	if (reg->info->id == MT6373_ID_VMCH_EINT_HIGH) {
+		ret = mt6373_set_bits(reg, MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR,
+				      MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT);
+	} else {
+		ret = mt6373_clear_bits(reg, MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR,
+					MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT);
+	}
+
+	if (ret)
+		return ret;
+
+	ret = mt6373_set_bits(reg, MT6373_PMIC_RG_LDO_VMCH_ADDR,
+			      reg->info->enable_mask);
+	if (ret)
+		return ret;
+
+	return mt6373_set_bits(reg, reg->info->enable_reg, reg->info->enable_mask);
+}
+
+static int mt6373_vmch_eint_disable(struct mt6373_regulator *reg)
+{
+	int ret;
+
+	ret = mt6373_clear_bits(reg, MT6373_PMIC_RG_LDO_VMCH_ADDR,
+				reg->info->enable_mask);
+	if (ret)
+		return ret;
+
+	/* Wait for VMCH discharging */
+	udelay(1500);
+
+	return mt6373_clear_bits(reg, reg->info->enable_reg,
+				 reg->info->enable_mask);
+}
+
+static int mt6373_regulator_get_enable(struct udevice *dev)
+{
+	struct mt6373_regulator *plat = dev_get_plat(dev);
+	int ret;
+	u8 val;
+
+	ret = mt6373_read(plat, plat->info->enable_reg, &val);
+	if (ret < 0) {
+		dev_err(dev, "Unable to read enable status\n");
+		return ret;
+	}
+
+	return !!(val & plat->info->enable_mask);
+}
+
+static int mt6373_regulator_buck_set_enable(struct udevice *dev, bool enable)
+{
+	struct mt6373_regulator *plat = dev_get_plat(dev);
+	u16 addr = plat->info->enable_reg;
+
+	if (enable)
+		addr += EN_SET_OFFSET;
+	else
+		addr += EN_CLR_OFFSET;
+
+	return mt6373_write(plat, addr, plat->info->enable_mask);
+}
+
+static int mt6373_regulator_ldo_set_enable(struct udevice *dev, bool enable)
+{
+	struct mt6373_regulator *plat = dev_get_plat(dev);
+
+	if (plat->info->id == MT6373_ID_VMCH_EINT_LOW ||
+	    plat->info->id == MT6373_ID_VMCH_EINT_HIGH) {
+		return enable ? mt6373_vmch_eint_enable(plat)
+			      : mt6373_vmch_eint_disable(plat);
+	}
+
+	if (enable)
+		return mt6373_set_bits(plat, plat->info->enable_reg,
+				       plat->info->enable_mask);
+
+	return mt6373_clear_bits(plat, plat->info->enable_reg,
+				 plat->info->enable_mask);
+}
+
+static struct dm_regulator_ops mt6373_regulator_buck_ops = {
+	.get_enable = mt6373_regulator_get_enable,
+	.set_enable = mt6373_regulator_buck_set_enable,
+	.get_value = mt6373_regulator_get_value,
+	.set_value = mt6373_regulator_set_value,
+};
+
+static struct dm_regulator_ops mt6373_regulator_ldo_ops = {
+	.get_enable = mt6373_regulator_get_enable,
+	.set_enable = mt6373_regulator_ldo_set_enable,
+	.get_value = mt6373_regulator_get_value,
+	.set_value = mt6373_regulator_set_value,
+};
+
+static int mt6373_regulator_bind(struct udevice *dev)
+{
+	struct mt6373_regulator *reg = dev_get_plat(dev);
+	struct mt6373_regulator *drv_data;
+
+	drv_data = (struct mt6373_regulator *)dev_get_driver_data(dev);
+	if (!drv_data) {
+		dev_err(dev, "Unable to get driver data\n");
+		return -EINVAL;
+	}
+
+	reg->data = drv_data->data;
+	reg->info = drv_data->info;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(mt6373_regulator_buck) = {
+	.name = "mt6373_regulator_buck",
+	.id = UCLASS_REGULATOR,
+	.bind = mt6373_regulator_bind,
+	.plat_auto = sizeof(struct mt6373_regulator),
+	.ops = &mt6373_regulator_buck_ops,
+};
+
+U_BOOT_DRIVER(mt6373_regulator_ldo) = {
+	.name = "mt6373_regulator_ldo",
+	.id = UCLASS_REGULATOR,
+	.bind = mt6373_regulator_bind,
+	.plat_auto = sizeof(struct mt6373_regulator),
+	.ops = &mt6373_regulator_ldo_ops,
+};
+
+/* This driver intentionally only supports a subset of the available regulators.
+ * This function checks to see if a given regulator node in DT matches a regulator
+ * defined in the driver.
+ */
+static const struct mt6373_regulator_info *mt6373_get_regulator_info(ofnode node)
+{
+	int i, max = ARRAY_SIZE(mt6373_regulators_info);
+
+	for (i = 0; i < max; i++) {
+		if (!strcmp(mt6373_regulators_info[i].name, ofnode_get_name(node)))
+			return &mt6373_regulators_info[i];
+	}
+
+	return NULL;
+}
+
+static int mt6373_regulators_probe(struct udevice *dev)
+{
+	int ret;
+	u8 val;
+
+	ret = pmic_read(dev->parent, 0xb, (u8 *)&val, 1);
+	if (ret < 0)
+		ret = pmic_read(dev->parent, 0xb, (u8 *)&val, 1);
+	if (ret < 0) {
+		dev_err(dev, "Unable to read device ID\n");
+		return ret;
+	}
+
+	if (val != 0x73) {
+		dev_err(dev, "Device ID doesn't match: 0x%02x != 0x73\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mt6373_regulators_bind(struct udevice *dev)
+{
+	struct mt6373_regulator_data *data = dev_get_plat(dev);
+	struct driver *drv;
+	char *name;
+	ofnode child, node = dev_ofnode(dev);
+	int ret;
+	size_t namelen;
+	u32 addr;
+
+	ret = ofnode_read_u32_index(node, "reg", 0, &addr);
+	if (ret < 0)
+		return -EINVAL;
+
+	data->base = (u16)addr;
+	data->pmic = dev->parent;
+
+	ofnode_for_each_subnode(child, node) {
+		struct mt6373_regulator reg;
+
+		reg.data = data;
+		reg.info = mt6373_get_regulator_info(child);
+		if (!reg.info)
+			continue;
+
+		namelen = strlen("reg-mt6373-") + strlen(reg.info->name) + 1;
+		name = devm_kzalloc(dev, namelen, GFP_KERNEL);
+		ret = snprintf(name, namelen, "reg-mt6373-%s", reg.info->name);
+		if (ret < 0 || ret >= namelen) {
+			dev_err(dev, "Failed to create MT6373 regulator name\n");
+			return -ENOMEM;
+		}
+
+		if (reg.info->id <= MT6373_ID_VBUCK9)
+			drv = DM_DRIVER_GET(mt6373_regulator_buck);
+		else
+			drv = DM_DRIVER_GET(mt6373_regulator_ldo);
+
+		ret = device_bind_with_driver_data(dev, drv, name, (ulong)&reg,
+						   child, NULL);
+		if (ret < 0) {
+			dev_err(dev, "Failed to bind MT6373 regulator %s: %d\n",
+				name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct udevice_id mt6373_regulators_ids[] = {
+	{ .compatible = "mediatek,mt6373-regulator" },
+	{ /* sentinel */ }
+};
+
+/*
+ * Driver for a 'bank' of regulators. This creates devices for each
+ * individual regulator
+ */
+U_BOOT_DRIVER(mt6373_regulators) = {
+	.name = "mt6373_regulators",
+	.id = UCLASS_MISC,
+	.bind = mt6373_regulators_bind,
+	.probe = mt6373_regulators_probe,
+	.of_match = mt6373_regulators_ids,
+	.ops = &mt6373_regulator_ldo_ops,
+	.plat_auto = sizeof(struct mt6373_regulator_data),
+};

-- 
2.53.0

