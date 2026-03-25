Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CBF109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6227F84106;
	Wed, 25 Mar 2026 23:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KMVqcBn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A21A840ED; Wed, 25 Mar 2026 23:33:27 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4404B84109
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso38068485a.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774478003; x=1775082803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHWqJTO5RKHPRSjwCX6MGlGWvFUe+FalV4Oj2qn48hE=;
 b=KMVqcBn8p+bMKDg+IGIhrsoYn8eiAeqTKMlL1cd1gzCvdejbArQm05WNAF0DfMQYTc
 dClVijz9jtu+b86ff4Za7c7/BqvLeYe91/CJETWEiEw/Hxqprq2G9Ppaw6+U1GjY0DTr
 g+kvYkQg2gflDxLjgHF1QBHM4akfmubbnUFbx5UIh88Cw46tDQSPLriodWvSE/1Ut0p4
 KjnH1Lt4sRWw3MQzPXR+7MnL/dGx+C4/EFml4khfKM1PdOSe6S+NBM6R+1dywaG+X9yU
 UP1a9gmkm9XOlYCRpNx+BBayrdktpGReTYkuaXbctO1AFOhWh/v2hZYGDfSRSs+aFudj
 zIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774478003; x=1775082803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHWqJTO5RKHPRSjwCX6MGlGWvFUe+FalV4Oj2qn48hE=;
 b=ZpN6qmgmPStgW14rxEmGmkS+QgvggHi5+WGJ9asmStIjlq3OrRFCr5dFS7VL/9keBK
 l4tHvQinY0c4U6lwe4SHHC8t6wKJJKI9Lo3xCh2TCfehJvgDqgPbQ8oZsUrX5v5vcVA1
 c3ZS0B5vv7R7fTJU72ttwM3hLHP6CmJWNXV8hZNxX4M7wrD9QSYXgCg5dauu31NGPmp+
 IqwRypAAKQ+2mInp/XbfO9kGZJfgluszP+UjJZEIUzAf7hZS/ZIATGM2IAdie/gWSMtj
 T0TzxLmHrwWZ5/sgG/ajlBtguG/NtRxt66PPh+xbAx9vsHgEA9DcAULPNQ8Nfro3nNgl
 rE0A==
X-Gm-Message-State: AOJu0YysZV/Pgqha3t/kwc3Z5D65EdTe01ckN7SXO+m8R0TXKbDKaOxj
 uwMwmGTYpGDFLfpgfr9JXUAyoudaipce0ZTPd7CLNu4XHpdotc7OgZUPOtbXIrU/
X-Gm-Gg: ATEYQzw/dOJBRwTAuvT87OZ49Yhw2raKl09TwuTWRvegH6ve2lKcUHG9V3RzdmVj940
 H0fjwnap2Jo43HZ9LDfQ+H5jCDv9pTlvYZAKcFVxkmWzk9wp9XNKoPiP0FOWJbMr7XXRHqBFSCc
 OGM7L7GY782/YBtXkF3AVdFn6gUzjiJucRpH3Q+MxDrj6f8XgmQkKX52fT+trE6a3Nc60cdf6EW
 IrmyoDwWa7XqJzNkLP1NZegxRptCNq3RlNZ1TXuL2eQbB/QEWcBeNVTiVFyHKnlChE9cOmpCtrU
 AWp6mJuhPKvZviJNNUg2ouP+0j/W38UOh/hruMIBn39UIMsW7vostCqh7nkdGnFLRx/KcX63IHe
 Bp+5UVKCMQ7t0uXyq5KLA6dOkOpimjx5UVoPSnPBPZC9Sso9Ds5FzaYKwr2kl8/1ncTLWJg2k04
 IV98ogo4VDRAkDMoZpEEXjm7Q1scfv+hJ86f6UuoImVyiZ68hBb5JWPYd4AVlpbkQHYWVNV/iIW
 Nym6+RGxtU=
X-Received: by 2002:a05:620a:4050:b0:8cd:827a:2ab3 with SMTP id
 af79cd13be357-8d00103ba9emr716796285a.55.1774478002582; 
 Wed, 25 Mar 2026 15:33:22 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:22 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v3 14/16] power: pmic: add support for Spacemit P1 PMIC
Date: Wed, 25 Mar 2026 18:32:30 -0400
Message-Id: <20260325223232.1553212-15-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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
Acked-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Drop SPL_PMIC_SPACEMIT_P1 Kconfig

 drivers/power/pmic/Kconfig            |   8 ++
 drivers/power/pmic/Makefile           |   1 +
 drivers/power/pmic/pmic_spacemit_p1.c |  94 +++++++++++++++
 include/power/spacemit_p1.h           | 163 ++++++++++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
 create mode 100644 include/power/spacemit_p1.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 345b7c92263..fea9185791d 100644
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
2.25.1

