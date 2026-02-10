Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3D7EA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E260983E48;
	Tue, 10 Feb 2026 16:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MZjKL36X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86BD883CEE; Tue, 10 Feb 2026 16:15:54 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4180F83E36
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8c70daf9c94so408940685a.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736551; x=1771341351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vw10v5iT+joynmG/o1nypBreNeuPyz6M7jhyql+M1kU=;
 b=MZjKL36XunMXUOdccBVRQy+1yEyGvXnzAemZKBgPCVWT0fkLJcyfROPBLULixV2Iqk
 JC8RZRDdyOj7TiHOeuvj+BX1t+U0+YBfIWY/YRh/vF7vLhSvZ0gPHzt06actU/OO/bwC
 8VVY/FXhhSqwf5+9dk7VpAAQ100/CjZkf/wd1TWbny730Jpbt7Hv4WKMtQDvuv+NLhP8
 2Olfjr9k2/+L1yxmN/lDkZ9CVL6lQsdjAhG5Ifs05CDbvf2ZbHA+wtIGg9jGkpaMYf0S
 Lmha3tdiQSfYWWpPkViBRLateikdAAYOADJ34op3DVZAC/WBK+whM4UgxQleup3mWKOJ
 0Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736551; x=1771341351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vw10v5iT+joynmG/o1nypBreNeuPyz6M7jhyql+M1kU=;
 b=RSoGoJqAmkL+EIfjT1rKu1YxXYOEFYZn4DRtWIGSFfTwZvgEwp4Zbqn+R6ufIwutHT
 VIxNXVPoZbfM0ma5ExCCg5OxfCFmpfMfUpAMIDrRuCySE+Ct0dvqTJuKY2o2A58ApUd9
 Q40Kzkf71svC4n6NkidO5ygpgNSge0PGATjfWhwNt4NiF4tAa7D27y0v/d9JynfoA35O
 hnky1svH6o3+UzsP0WoIheyPLCT9aIrmmcP1CrS/VaxPmbz4m74nkObvYX75T9bXtiWv
 kZuKss6wmqjUrciwuKdX8vroeRsuZAHmoiqiV0WWuvIbOnLai0yXTmXE2jMQNxW/CnnZ
 /Yew==
X-Gm-Message-State: AOJu0YzMfXPyQWho2H7LhwWjYOZC9m4rXref0RWVSNHfLS15uczPIIvN
 iy7+YEiR3pNzI8y+X+ssmbsD7qn/rnJZPgFO6Fz9r0UkpEwhrrpfJn7X0M7+5Q==
X-Gm-Gg: AZuq6aKG2WbsvcC2GAeH5XBWx4Ne04rRGG16sg3uaLtbzNYjE0jMlSqrLKIjnrq/vFA
 Ua2ZGDrISwr6x6M77OtqFwbtWsr9ArT6YCqwW2qx8RpDZGRCqPYhkHq3OY785diT6rs+2PeuKdF
 dQU7mUOJihDyEfUa2MzBBATzXURvmnBwaaNweY/y4eFO1q/DR3gNaGeIvTAFFr7arF/C0nJE4ml
 lv853Vgv0TuEMI7vyOiLOKt8r1hEzKOXnZAqUtq/BjAqNUU1O5Gc2j7FylY+Fm7LSYKKVsFh9aX
 8WTqmaeCipY790PInCegd9NklfTELggyzqlXpkVS/nVttgCV8VhP2EKlkkiIVvrRr9/+oA5ttt4
 snwZFD2ynKsYin08M3fbbLbj/naWw6Lum1nR8YBpI6VZGPjrvGaBMrjt5mbi77eEqgRvly0lI6L
 tfv4kbvZsthJTgXvlcolQ4eDlOR00CPgDcWrsSbWO7RJD1cYemegJmvPwCbgqwj84RlzxJoUrY+
 n9IrK7z7O8=
X-Received: by 2002:a05:620a:1a11:b0:8c5:c99d:b2c with SMTP id
 af79cd13be357-8caef40934bmr1938046285a.34.1770736550653; 
 Tue, 10 Feb 2026 07:15:50 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:50 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v2 14/16] power: pmic: add support for Spacemit P1 PMIC
Date: Tue, 10 Feb 2026 10:14:57 -0500
Message-Id: <20260210151459.2348758-15-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Spacemit's PMIC is used by Spacemit K1 SoC. It contains voltage
regulators, GPIOs and Watchdog.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>
---
 drivers/power/pmic/Kconfig            |  17 +++
 drivers/power/pmic/Makefile           |   1 +
 drivers/power/pmic/pmic_spacemit_p1.c |  94 +++++++++++++++
 include/power/spacemit_p1.h           | 163 ++++++++++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
 create mode 100644 include/power/spacemit_p1.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index b1a5b1c2a1f..19a0c4a77dd 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -433,6 +433,23 @@ config PMIC_RAA215300
 	  support and several voltage regulators. For now, this driver simply
 	  allows register access and will bind the sysreset driver
 	  (CONFIG_SYSRESET_RAA215300) if it is enabled.
+
+config PMIC_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 power management chip"
+	depends on DM_PMIC
+	help
+	  The P1 PMIC integrates multiple functions including
+	  voltage regulators, a watchdog timer, GPIO interfaces, and a
+	  real-time clock.
+
+config SPL_PMIC_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 power management chip in SPL"
+	depends on SPL_DM_PMIC
+	help
+	  The P1 PMIC integrates multiple functions including
+	  voltage regulators, a watchdog timer, GPIO interfaces, and a
+	  real-time clock.
+
 endif
 
 config PMIC_TPS65217
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 6bebffb05a6..dfe60223f00 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
 obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_CPCAP) += cpcap.o
+obj-$(CONFIG_$(PHASE_)PMIC_SPACEMIT_P1) += pmic_spacemit_p1.o
 
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
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
2.25.1

