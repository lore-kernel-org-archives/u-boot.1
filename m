Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79818CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE12A847B0;
	Tue, 19 May 2026 00:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="htdPVxqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEF6846A4; Tue, 19 May 2026 00:32:15 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C8A8465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2bcd3ac3307so15794725ad.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143531; x=1779748331;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e3yQ8Z0Y7YETofAnL1svs7IjF1hiO1KO/fQ1o6JgNCE=;
 b=htdPVxqj17dWlMOenK11sILMWswznpiLOLchqr3tn2e8XdDofn8FwRT+U6ND5DMy7E
 QJYeXjkRRfr4YkHRIpvpBNkHAPKpd+VfxcV7+wxKfv4jAbz/NHnlweLNdb+b5MKTo2y/
 rYLsmZDpjJSpo6/QjDQKajWC0q83LqerQoeids5e4awNAZQx6dsw4efy9vM4xj3t8+h9
 7NPeKivDHZ9nakul5H4uTQeeLm2l5bGc1ZVKbBYHMT7AhxSOEf1L5NVNP9TumRLVoD2c
 pwtC8YBHcj/1WHKM4lQu87UoXNSdx+O/QEgjCVPx4MYPyfvP/75bdl9Iia9B5JQHnpb3
 //Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143531; x=1779748331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e3yQ8Z0Y7YETofAnL1svs7IjF1hiO1KO/fQ1o6JgNCE=;
 b=oPETQCZqstfMar4nGFN11zXgCQQhDo0w3GeVHyViC5O3QnY17PGC+iai4xvpyy6zZ4
 A7h3Phos4tqmdalUwQJERZL2yvIaIqvVRcuuWbmCvI6Wma2G0XCdG77Mu2N96ZTmffdG
 XFPvdWsLRfKbJiOnqvfHrvo9BijRzyu2QBf6iX9naLj+Rnbs4TUfPYaEW0ofYG288AcG
 MLKG2R5WFd4geNx0EyMmGwNp6iGHkX7Hm8a3p+9uTLUmqv68C8ccQHWO9H8DQshyXKoN
 At+eGI2V35C50yzjajKTf6tfykQnsTEqb/winVj+Ewy1RNNrT7IQ9s7B0z/+1JOlOWkU
 MMFA==
X-Gm-Message-State: AOJu0Yw6Xph4fytAGc7NKx0cwQqT1LnR/VESMyZ1ooPpUroel+OuOMFR
 eR09mp6pfghR4EITnvCCpqlsuGl3u7WzJkAWZuQ1egHn7K6V4ffPbF4WX6bZFoQLKOuUqAWOSQ1
 5EBj09Occ6ijW
X-Gm-Gg: Acq92OGxAiIywETlGVXs3cjYuuIP/I+U97blAYR7ol3cEI3Qk0Flcfghr0U7w7ZERzX
 sQ2Z1aKrV/sg5q8OsKZE6QbE16G5tD4lkygwpFD6Zbs8RS2F19jtARWv2gzM3uKl3cxcAw2SbDq
 9RyxLgzeEJ37NbxGa9hXuHgSj+hpzic1urQVz9fmdfD735OvhUxWJRqSFJGN6vhUMc4hwEMzcUh
 uZDyUZ2Oofu/30IckHGCb1MPLbKGoeX+U7SMPtJ5Lz7MfN2MkE4VChnSTwxu5sP8+rGcV8VYGsP
 5SKHizJ/T6kYsPCkwUWh2553pJ8VvRLCT9APSd6X4hGyK3uyeL6cj39MLC8Tc8OgB66d9jJeNOL
 8Fas1gAGm+Qc+SliRNd59oOCOudcHpk1RGnAire7sKFxMgMfP6Icx5qwOczz/3AHa4bQTMUYwS6
 J0Z5iPKyJ7Ote2I8pgnKfYP4S7X4k/d+ZfAZBPvLg1g2i1UxsbYAi/gQ==
X-Received: by 2002:a17:903:2a8f:b0:2b2:57f3:8d07 with SMTP id
 d9443c01a7336-2bd7e8ae696mr174704295ad.7.1779143531305; 
 Mon, 18 May 2026 15:32:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:32:10 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:29 -0400
Subject: [PATCH v4 11/14] power: pmic: add support for Spacemit P1 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-11-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

From: Raymond Mao <raymond.mao@riscstar.com>

Spacemit's PMIC is used by Spacemit K1 SoC. It contains voltage
regulators, GPIOs and Watchdog.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Acked-by: Peng Fan <peng.fan@nxp.com>

---
v4:
- No change.
---
 drivers/power/pmic/Kconfig            |   8 ++
 drivers/power/pmic/Makefile           |   1 +
 drivers/power/pmic/pmic_spacemit_p1.c |  94 ++++++++++++++++++++
 include/power/spacemit_p1.h           | 163 ++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 5bc14842e66..aaae3eacc14 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -434,6 +434,14 @@ config PMIC_RAA215300
 	  allows register access and will bind the sysreset driver
 	  (CONFIG_SYSRESET_RAA215300) if it is enabled.
 
+config PMIC_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 power management chip"
+	depends on DM_PMIC
+	help
+	  The P1 PMIC integrates multiple functions including
+	  voltage regulators, a watchdog timer, GPIO interfaces, and a
+	  real-time clock.
+
 config DM_PMIC_MTK_PWRAP
 	bool "Enable driver for MediaTek PMIC Wrapper Support"
 	help
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 2cda5a892fd..0ac92084221 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)DM_PMIC_TPS80031) += tps80031.o
 obj-$(CONFIG_$(PHASE_)PMIC_PALMAS) += palmas.o
 obj-$(CONFIG_$(PHASE_)PMIC_LP873X) += lp873x.o
 obj-$(CONFIG_$(PHASE_)PMIC_LP87565) += lp87565.o
+obj-$(CONFIG_PMIC_SPACEMIT_P1) += pmic_spacemit_p1.o
 obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
 obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
diff --git a/drivers/power/pmic/pmic_spacemit_p1.c b/drivers/power/pmic/pmic_spacemit_p1.c
new file mode 100644
index 00000000000..46c5926874c
--- /dev/null
+++ b/drivers/power/pmic/pmic_spacemit_p1.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/spacemit_p1.h>
+
+static int pmic_p1_reg_count(struct udevice *dev)
+{
+	return P1_MAX_REGS;
+}
+
+static int pmic_p1_write(struct udevice *dev, uint reg, const u8 *buffer,
+			 int len)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, buffer, len);
+	if (ret)
+		pr_err("%s write error on register %02x\n", dev->name, reg);
+
+	return ret;
+}
+
+static int pmic_p1_read(struct udevice *dev, uint reg, u8 *buffer,
+			int len)
+{
+	int ret;
+
+	ret = dm_i2c_read(dev, reg, buffer, len);
+	if (ret)
+		pr_err("%s read error on register %02x\n", dev->name, reg);
+
+	return ret;
+}
+
+static const struct pmic_child_info p1_children_info[] = {
+	{ .prefix = "buck",		.driver = P1_BUCK_DRIVER },
+	{ .prefix = "aldo",		.driver = P1_ALDO_DRIVER },
+	{ .prefix = "dldo",		.driver = P1_DLDO_DRIVER },
+	{ },
+};
+
+static int pmic_p1_bind(struct udevice *dev)
+{
+	const struct pmic_child_info *p1_children_info =
+			(struct pmic_child_info *)dev_get_driver_data(dev);
+	ofnode regulators_node;
+	int children;
+
+	regulators_node = dev_read_subnode(dev, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		debug("%s regulators subnode not found\n", dev->name);
+		return -EINVAL;
+	}
+
+	children = pmic_bind_children(dev, regulators_node,
+				      p1_children_info);
+	if (!children)
+		debug("%s has no children (regulators)\n", dev->name);
+
+	return 0;
+}
+
+static int pmic_p1_probe(struct udevice *dev)
+{
+	return 0;
+}
+
+static struct dm_pmic_ops pmic_p1_ops = {
+	.reg_count	= pmic_p1_reg_count,
+	.read		= pmic_p1_read,
+	.write		= pmic_p1_write,
+};
+
+static const struct udevice_id pmic_p1_match[] = {
+	{
+		.compatible = "spacemit,p1",
+		.data = (ulong)&p1_children_info,
+	}, {
+		/* sentinel */
+	}
+};
+
+U_BOOT_DRIVER(pmic_p1) = {
+	.name		= "pmic_p1",
+	.id		= UCLASS_PMIC,
+	.of_match	= pmic_p1_match,
+	.bind		= pmic_p1_bind,
+	.probe		= pmic_p1_probe,
+	.ops		= &pmic_p1_ops,
+};
diff --git a/include/power/spacemit_p1.h b/include/power/spacemit_p1.h
new file mode 100644
index 00000000000..ef5a45e8cec
--- /dev/null
+++ b/include/power/spacemit_p1.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+#ifndef __SPACEMIT_P1_H_
+#define __SPACEMIT_P1_H_
+
+#define P1_MAX_REGS			0xA8
+
+#define P1_REG_ID			0x0
+
+#define P1_ID				0x2
+
+#define P1_REG_BUCK1_CTRL		0x47
+#define P1_REG_BUCK2_CTRL		0x4a
+#define P1_REG_BUCK3_CTRL		0x4d
+#define P1_REG_BUCK4_CTRL		0x50
+#define P1_REG_BUCK5_CTRL		0x53
+#define P1_REG_BUCK6_CTRL		0x56
+
+#define P1_REG_BUCK1_VSEL		0x48
+#define P1_REG_BUCK2_VSEL		0x4b
+#define P1_REG_BUCK3_VSEL		0x4e
+#define P1_REG_BUCK4_VSEL		0x51
+#define P1_REG_BUCK5_VSEL		0x54
+#define P1_REG_BUCK6_VSEL		0x57
+
+#define P1_REG_BUCK1_SVSEL		0x49
+#define P1_REG_BUCK2_SVSEL		0x4c
+#define P1_REG_BUCK3_SVSEL		0x4f
+#define P1_REG_BUCK4_SVSEL		0x52
+#define P1_REG_BUCK5_SVSEL		0x55
+#define P1_REG_BUCK6_SVSEL		0x58
+
+#define P1_BUCK_CTRL(x)			(0x47 + ((x) - 1) * 3)
+#define P1_BUCK_VSEL(x)			(0x48 + ((x) - 1) * 3)
+#define P1_BUCK_SVSEL(x)		(0x49 + ((x) - 1) * 3)
+
+#define BUCK_VSEL_MASK			0xff
+#define BUCK_EN_MASK			0x1
+#define BUCK_SVSEL_MASK			0xff
+
+#define P1_REG_ALDO1_CTRL		0x5b
+#define P1_REG_ALDO2_CTRL		0x5e
+#define P1_REG_ALDO3_CTRL		0x61
+#define P1_REG_ALDO4_CTRL		0x64
+
+#define P1_REG_ALDO1_VOLT		0x5c
+#define P1_REG_ALDO2_VOLT		0x5f
+#define P1_REG_ALDO3_VOLT		0x62
+#define P1_REG_ALDO4_VOLT		0x65
+
+#define P1_REG_ALDO1_SVOLT		0x5d
+#define P1_REG_ALDO2_SVOLT		0x60
+#define P1_REG_ALDO3_SVOLT		0x63
+#define P1_REG_ALDO4_SVOLT		0x66
+
+#define P1_ALDO_CTRL(x)			(0x5b + ((x) - 1) * 3)
+#define P1_ALDO_VOLT(x)			(0x5c + ((x) - 1) * 3)
+#define P1_ALDO_SVOLT(x)		(0x5d + ((x) - 1) * 3)
+
+#define ALDO_SVSEL_MASK			0x7f
+#define ALDO_EN_MASK			0x1
+#define ALDO_VSEL_MASK			0x7f
+
+#define P1_REG_DLDO1_CTRL		0x67
+#define P1_REG_DLDO2_CTRL		0x6a
+#define P1_REG_DLDO3_CTRL		0x6d
+#define P1_REG_DLDO4_CTRL		0x70
+#define P1_REG_DLDO5_CTRL		0x73
+#define P1_REG_DLDO6_CTRL		0x76
+#define P1_REG_DLDO7_CTRL		0x79
+
+#define P1_REG_DLDO1_VOLT		0x68
+#define P1_REG_DLDO2_VOLT		0x6b
+#define P1_REG_DLDO3_VOLT		0x6e
+#define P1_REG_DLDO4_VOLT		0x71
+#define P1_REG_DLDO5_VOLT		0x74
+#define P1_REG_DLDO6_VOLT		0x77
+#define P1_REG_DLDO7_VOLT		0x7a
+
+#define P1_REG_DLDO1_SVOLT		0x69
+#define P1_REG_DLDO2_SVOLT		0x6c
+#define P1_REG_DLDO3_SVOLT		0x6f
+#define P1_REG_DLDO4_SVOLT		0x72
+#define P1_REG_DLDO5_SVOLT		0x75
+#define P1_REG_DLDO6_SVOLT		0x78
+#define P1_REG_DLDO7_SVOLT		0x7b
+
+#define P1_DLDO_CTRL(x)			(0x67 + ((x) - 1) * 3)
+#define P1_DLDO_VOLT(x)			(0x68 + ((x) - 1) * 3)
+#define P1_DLDO_SVOLT(x)		(0x69 + ((x) - 1) * 3)
+
+#define DLDO_SVSEL_MASK			0x7f
+#define DLDO_EN_MASK			0x1
+#define DLDO_VSEL_MASK			0x7f
+
+#define P1_REG_SWITCH_CTRL		0x59
+#define P1_SWTICH_EN_MASK		0x1
+
+#define P1_REG_SWITCH_PWRKEY_EVENT_CTRL	0x97
+#define P1_SWITCH_PWRKEY_EVENT_EN_MSK	0xf
+
+#define P1_REG_SWITCH_PWRKEY_INIT_CTRL	0x9e
+#define P1_SWITCH_PWRKEY_INT_EN_MSK	0xf
+
+/* Watchdog Timer Registers */
+#define P1_WDT_CTRL			0x44
+#define P1_PWR_CTRL0			0x7C
+#define P1_PWR_CTRL2			0x7E
+#define P1_PWR_CTRL2_MSK		0xff
+
+/* Watchdog Timer Control Bits */
+#define P1_WDT_CLEAR_STATUS		0x1
+#define P1_SW_RST			0x2
+#define P1_WDT_RESET_ENABLE		0x80
+#define P1_WDT_ENABLE			0x8
+#define P1_WDT_TIMEOUT_1S		0x0
+#define P1_WDT_TIMEOUT_4S		0x1
+#define P1_WDT_TIMEOUT_8S		0x2
+#define P1_WDT_TIMEOUT_16S		0x3
+
+#define P1_RTC_TICK_CTRL		0x1d
+#define P1_RTC_TICK_CTRL_MSK		0x7f
+
+#define P1_RTC_TICK_EVENT		0x92
+#define P1_RTC_TICK_EVENT_MSK		0x3f
+
+#define P1_RTC_TICK_IRQ			0x99
+#define P1_RTC_TICK_IRQ_MSK		0x3f
+
+#define P1_REG_ALIVE			0xab
+#define P1_ALIVE_MSK			0x7
+#define SYS_REBOOT_FLAG_BIT		0x2
+
+/* SWITCH ID */
+enum {
+	P1_ID_SWITCH1,
+	P1_ID_SWITCH1_PWRKEY_EVENT,
+	P1_ID_SWITCH1_PWRKEY_INT,
+	P1_ID_SWITCH_RTC_TICK_CTRL,
+	P1_ID_SWITCH_RTC_TICK_EVENT,
+	P1_ID_SWITCH_RTC_TCK_IRQ,
+	P1_ID_SWITCH_POWER_DOWN,
+	P1_ID_SWITCH_CHARGING_FLAG,
+};
+
+/* POWERKEY events */
+enum {
+	PWRKEY_RISING_EVENT = 1,
+	PWRKEY_FAILING_EVENT = 2,
+	PWRKEY_SHORT_PRESS_EVENT = 4,
+	PWRKEY_LONG_PRESS_EVENT = 8,
+};
+
+#define P1_BUCK_DRIVER			"p1_buck"
+#define P1_ALDO_DRIVER			"p1_aldo"
+#define P1_DLDO_DRIVER			"p1_dldo"
+#define P1_SWITCH_DRIVER		"p1_switch"
+#define P1_WDT_DRIVER			"p1_wdt"
+
+#endif /* __SPACEMIT_P1_H_ */

-- 
2.43.0

