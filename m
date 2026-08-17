Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0827C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6105407E9;
	Mon, 17 Aug 2026 13:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9q33Z-18SDgX; Mon, 17 Aug 2026 13:34:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82894407D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973650;
	bh=JDs0QzXnw6uktvOtK8cHncbCmLKEi3ok6Pvbu1srUfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yrb4hUevknG2vj510Co1r+kwqd2kJKBe6HMAxxQpBl4760PVGoH7cdtfaco05m0Xx
	 SX38ABAcWhdMZVeIMfwEQkFwg0Kfly1tmwIcUuDyvVymSdmGOQssZloK+FjDJc/DPu
	 ls0FDqNjq/CQCZQyEkmv/n2ADn5t0Wxi4fTzu+p21i1A/mUAX1Z69Hd2+OB76kBCLA
	 9XSIWmRJvhA/WF76yV7RG1HL4SlXo1N8l5lNxYuj7N4UYS/kQpOCDAOGwUhIY+gMWW
	 +rzD8wS1JgNkNEcCLmGmsSN6N/t96y5iDGDxgI6dgDIUTKPnV0J5LITrNpaLQU6duN
	 ugWG3L/z1RNTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82894407D8;
	Mon, 17 Aug 2026 13:34:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF08E2B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A522E40728
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BVjfrIha-KhL for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B102440723
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B102440723
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Hr/C0a5s
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B102440723
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C886404AF;
 Mon, 17 Aug 2026 08:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BDE1F000E9;
 Mon, 17 Aug 2026 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956262;
 bh=JDs0QzXnw6uktvOtK8cHncbCmLKEi3ok6Pvbu1srUfk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Hr/C0a5sQYdLdXjjR+uylPSYKiIunO0/ltmhqeM4uw7dxdfcVgZGS+MbjjVubgxfj
 OO7eyz4det9pc+iQX4QC5BuzTIN+TMCKX0aHjfe0Aj6W3ttJJWPrVGb7FXc8JThDVb
 YbTSNUmYdiyy7pPkpohaRqmuhdEOfKQdjKg7obIS0R2Rvnl/7PO5+mZSgs8hqEiiqE
 JFj/Pr9/4Fk6GsH9vFaw783zAyBmXWUrcAlUAOV/0NsGWW/TzPLB+XIYMp7zCCf8xP
 3Cphy1y3XAt/0a+QSlodzCMWPgFJ/WgH5Oqp5vtyxyfAKm8xl04iL7h2Ihz7pn+UGn
 SL93rQYDO2INg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:08 +0200
Subject: [PATCH 4/8] power: regulator: Add AB8500 AUX3 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-4-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:57 +0000
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
 drivers/power/regulator/ab8500.c | 111 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 123 insertions(+)

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
index 000000000000..03beb0834d53
--- /dev/null
+++ b/drivers/power/regulator/ab8500.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* ST-Ericsson AB8500/AB8505 LDO AUX3 regulator */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/errno.h>
+#include <power/ab8500.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#define AB8500_VAUX3_REGU	AB8500_REGU_CTRL2(0x0a)
+#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
+#define AB8500_VAUX3_EN_MASK	GENMASK(1, 0)
+#define AB8500_VAUX3_EN		BIT(0)
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
+	return (ret & AB8500_VAUX3_EN_MASK) == AB8500_VAUX3_EN;
+}
+
+static int ab8500_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	return pmic_clrsetbits(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU,
+			       AB8500_VAUX3_EN_MASK,
+			       enable ? AB8500_VAUX3_EN : 0);
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
+	struct driver *drv = lists_driver_lookup_name("ab8500_ldo_aux3");
+	ofnode node;
+
+	dev_for_each_subnode(node, dev) {
+		if (!strcmp(ofnode_get_name(node), "ab8500_ldo_aux3"))
+			return device_bind_with_driver_data(dev, drv,
+						    ofnode_get_name(node), 0,
+						    node, NULL);
+	}
+
+	return -ENODEV;
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

