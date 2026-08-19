Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD13C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D09F780E38;
	Wed, 19 Aug 2026 08:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yAWs9mrbNc3A; Wed, 19 Aug 2026 08:54:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129665;
	bh=JFlzXqsx5nqJMi/CXpdX/INeOmut1zWZFJHM/ZpIsBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=buSsqRNW/hao2zcOEn/f7/JJ+aotFlENc9af3MT4jv2egGHNZ0WmlQW6bbcRuHqlH
	 zSxBLg06YPOVpJag6hX9O0jfQyQ0mzc1bUkh8KEsHxGuL1BCub9oz72Mk9kU7pN5F9
	 nFsukc+IfgCS06q58x4YM/c7nkt+HDqOrrKypR1R+Yfh4Bz5+tRYy1w5ycgNpU90sF
	 VZQ6fOKxt1ujEd1IBlpi1G5sUAlaA1Szds/q2B8pOX/P4jmbcBYjrX4bSSgdaFeSF2
	 6BdZm+d0EQciL1DNF0d3mm7smTbY4Noh8YxWDylJHyUsmifdCbG43Tkj9D7Qml6C2h
	 lf2/h94URQVSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FC7E80E0E;
	Wed, 19 Aug 2026 08:54:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65EF2265
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BCB840694
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0VuS6OIkJsV for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B7oWs4Pf
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 390234064B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27D5C60A5B;
 Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65971F00A3A;
 Wed, 19 Aug 2026 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129659;
 bh=JFlzXqsx5nqJMi/CXpdX/INeOmut1zWZFJHM/ZpIsBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=B7oWs4PfMlxeDNInLA475WlQX8uBTyw6aANSO25SKIPpApoxNa7zCTUE2J6s/ewx4
 BeDBeQ1p7vLhOjOpj4Q95FqXF2GYrH89zsX11OPrRTihEsBihDWfj7/yfTnI1g68PV
 T6dI5yI1H8tSVBr1tcdIIyaw5AWRRS+eZc6pzoIR8Or+VVm9MiPThA+24G9XcE5KYk
 tyx//vbsgqNyV1LW61gbRBZci4W/EBHpKNNMFHKiSus/vDxbZSdV3zgP57paRKHpZp
 v4rBEHEMkDuO1d2iE0WaO8QR27l6uocf4RNFn8oCcfsMBFgZAuH97sAxLSm/QoLtRd
 BoaZwgDqOb+OA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:11 +0200
Subject: [PATCH v4 06/12] power: regulator: Add AB8500 AUX3 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-6-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Add regulator support for LDO AUX3 on AB8500 and AB8505 PMICs.
AUX3 supplies the removable SD card on the upstream Ux500 Samsung
device trees, and both PMIC variants use the same control registers.

Imply the regulator core for ARCH_U8500 so the driver can instantiate
from the upstream device trees.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                      |   1 +
 arch/arm/Kconfig                 |   2 +
 drivers/power/pmic/ab8500.c      |   1 +
 drivers/power/regulator/Kconfig  |   7 +++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/ab8500.c | 107 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5d6b5be29dc..8e78a7f224fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -790,6 +790,7 @@ F:	drivers/gpio/nmk_gpio.c
 F:	drivers/pinctrl/pinctrl-nomadik.c
 F:	drivers/phy/phy-ab8500-usb.c
 F:	drivers/power/pmic/ab8500.c
+F:	drivers/power/regulator/ab8500.c
 F:	drivers/timer/nomadik-mtu-timer.c
 F:	drivers/usb/musb-new/ux500.c
 F:	drivers/video/mcde_simple.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b02ff18bd0e..62aa9e8cc565 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1275,6 +1275,7 @@ config ARCH_U8500
 	imply ARM_PL180_MMCI
 	imply CLK
 	imply DM_PMIC
+	imply DM_REGULATOR
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER
@@ -1283,6 +1284,7 @@ config ARCH_U8500
 	imply PHY
 	imply PL01X_SERIAL
 	imply PMIC_AB8500
+	imply REGULATOR_AB8500
 	imply RTC_PL031
 	imply SYS_THUMB_BUILD
 	imply SYSRESET_SYSCON
diff --git a/drivers/power/pmic/ab8500.c b/drivers/power/pmic/ab8500.c
index 9ba096711e14..b9fae7000b78 100644
--- a/drivers/power/pmic/ab8500.c
+++ b/drivers/power/pmic/ab8500.c
@@ -253,6 +253,7 @@ static int ab8500_probe(struct udevice *dev)
 
 static const struct udevice_id ab8500_ids[] = {
 	{ .compatible = "stericsson,ab8500" },
+	{ .compatible = "stericsson,ab8505" },
 	{ }
 };
 
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 00a25acfdf99..a27fe4925cf9 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -16,6 +16,13 @@ config DM_REGULATOR
 	  for this purpose if PMIC I/O driver is implemented or dm_scan_fdt_dev()
 	  otherwise. Detailed information can be found in the header file.
 
+config REGULATOR_AB8500
+	bool "ST-Ericsson AB8500/AB8505 regulator support"
+	depends on DM_REGULATOR && PMIC_AB8500
+	help
+	  Enable LDO AUX3 regulator support for AB8500 and AB8505 PMICs.
+	  This supply is used to power removable SD cards on Ux500 boards.
+
 config SPL_DM_REGULATOR
 	bool "Enable regulators for SPL"
 	depends on DM_REGULATOR && SPL_POWER
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index a40c9d340d98..a500a3da98d4 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR) += regulator-uclass.o
+obj-$(CONFIG_REGULATOR_AB8500) += ab8500.o
 obj-$(CONFIG_REGULATOR_ACT8846) += act8846.o
 obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_AXP) += axp_regulator.o
diff --git a/drivers/power/regulator/ab8500.c b/drivers/power/regulator/ab8500.c
new file mode 100644
index 000000000000..1939504c1c24
--- /dev/null
+++ b/drivers/power/regulator/ab8500.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* ST-Ericsson AB8500/AB8505 LDO AUX3 regulator */
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <linux/errno.h>
+#include <power/ab8500.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#define AB8500_VAUX3_REGU	AB8500_REGU_CTRL2(0x0a)
+#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
+#define AB8500_VAUX3_EN_MASK	GENMASK(1, 0)
+#define AB8500_VAUX3_REGU_EN	BIT(0)
+#define AB8500_VAUX3_SEL_MASK	GENMASK(2, 0)
+
+static const int ab8500_vaux3_voltages[] = {
+	1200000, 1500000, 1800000, 2100000,
+	2500000, 2750000, 2790000, 2910000,
+};
+
+static struct udevice *ab8500_regulator_pmic(struct udevice *dev)
+{
+	return dev->parent->parent;
+}
+
+static int ab8500_regulator_get_value(struct udevice *dev)
+{
+	int ret;
+
+	ret = pmic_reg_read(ab8500_regulator_pmic(dev), AB8500_VAUX3_SEL);
+	if (ret < 0)
+		return ret;
+	ret &= AB8500_VAUX3_SEL_MASK;
+
+	return ab8500_vaux3_voltages[ret];
+}
+
+static int ab8500_regulator_set_value(struct udevice *dev, int uV)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_vaux3_voltages); i++) {
+		if (ab8500_vaux3_voltages[i] == uV)
+			return pmic_clrsetbits(ab8500_regulator_pmic(dev),
+					       AB8500_VAUX3_SEL,
+					       AB8500_VAUX3_SEL_MASK, i);
+	}
+
+	return -EINVAL;
+}
+
+static int ab8500_regulator_get_enable(struct udevice *dev)
+{
+	int ret;
+
+	ret = pmic_reg_read(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU);
+	if (ret < 0)
+		return ret;
+
+	return (ret & AB8500_VAUX3_EN_MASK) == AB8500_VAUX3_REGU_EN;
+}
+
+static int ab8500_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	return pmic_clrsetbits(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU,
+			       AB8500_VAUX3_EN_MASK,
+			       enable ? AB8500_VAUX3_REGU_EN : 0);
+}
+
+static const struct dm_regulator_ops ab8500_regulator_ops = {
+	.get_value = ab8500_regulator_get_value,
+	.set_value = ab8500_regulator_set_value,
+	.get_enable = ab8500_regulator_get_enable,
+	.set_enable = ab8500_regulator_set_enable,
+};
+
+U_BOOT_DRIVER(ab8500_ldo_aux3) = {
+	.name = "ab8500_ldo_aux3",
+	.id = UCLASS_REGULATOR,
+	.ops = &ab8500_regulator_ops,
+};
+
+static int ab8500_regulators_bind(struct udevice *dev)
+{
+	ofnode node;
+
+	node = dev_read_subnode(dev, "ab8500_ldo_aux3");
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	return device_bind_driver_to_node(dev, "ab8500_ldo_aux3",
+					  ofnode_get_name(node), node, NULL);
+}
+
+static const struct udevice_id ab8500_regulator_ids[] = {
+	{ .compatible = "stericsson,ab8500-regulator" },
+	{ .compatible = "stericsson,ab8505-regulator" },
+	{ }
+};
+
+U_BOOT_DRIVER(ab8500_regulators) = {
+	.name = "ab8500_regulators",
+	.id = UCLASS_NOP,
+	.of_match = ab8500_regulator_ids,
+	.bind = ab8500_regulators_bind,
+};

-- 
2.55.0

