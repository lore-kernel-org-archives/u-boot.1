Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0570FC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7E2B60745;
	Tue,  1 Sep 2026 09:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkf7yjN41e5v; Tue,  1 Sep 2026 09:13:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254004;
	bh=NFWH3x12362yi9XxBziA2cHCbZ62+vW2EFd9mOlMgzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eToIB3EBuDqe/hRRm1ndIS73O85f/dQp9sbzkDwaFTgOSQlAJGbfX2EJagd4DwEuo
	 9tc6ueJNqEqB/4spQvgQK3hLe3L5vW/BuPMq57HassrMtsJsrjhYTt3fWS51C0b548
	 M6+Ihfk7drEO6snmqt15a/gK+GOMVRLE295toxtDFCXPF3sJn8mxS48ihpF3za/wxt
	 v8mIw9xdkZWWvgsCz1etkaPcFN35oVti8FB3qPF2YpZwYlMkQrnY6zpDwO1vMNR0Uh
	 3IfxCmNgF6xnGgGnmnU2mWmANYAI0uOKNB59O4YeNuRn2q2UjL5lAbqbU5OeAAbGzz
	 KELH0nz0FZNKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB58660743;
	Tue,  1 Sep 2026 09:13:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E7381D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CF8A4018C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id enRFS1pxFg81 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RyFy6Bj3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28EA1400A8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C887D602D4;
 Tue,  1 Sep 2026 09:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCE41F000E9;
 Tue,  1 Sep 2026 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253999;
 bh=NFWH3x12362yi9XxBziA2cHCbZ62+vW2EFd9mOlMgzQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RyFy6Bj3P8qpc38KSjTcZaLYS0MbyUTXbEQv7oLFVqmcOskJRNuqRgw9OFaRAWQ+a
 HJETK7EheQpTMjeV9ifRRNKdYV651aWdraLS2XO2SDKFGlaPSMhhoNa5urwgq0QEl4
 XdP/uNKTU6sbQv6q1Qjk9RszRn5ntkb9Nljp5+MvWhaClwOMBzWORIH0DS13upWecU
 6hfYU1xElX4pI5XxyPoRQ9LJiHt/hTEjArNMYPJwDVH4zV+JsyNgnZv1RbDd2A9NPx
 FLf343E85K9IRf3ktfxRr9Abd6z/aPCKdEmfduvAWxke6Zx/R2IXsUDVKdCqJtcRIJ
 DzRBQCaTHXTow==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:05 +0200
Subject: [PATCH v7 07/13] power: regulator: Add AB8500 AUX3 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-7-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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
device trees.

Support the AB8505-specific 3.05 V selector override and clear it after
programming an ordinary voltage. Treat both normal and low-power modes
as enabled and select the supported voltage closest to a requested
target. AB8500 cut 2.0 or later is assumed.

Imply the regulator core for ARCH_U8500 so the driver can instantiate
from the upstream device trees.

Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                      |   1 +
 arch/arm/Kconfig                 |   2 +
 drivers/power/pmic/ab8500.c      |   1 +
 drivers/power/regulator/Kconfig  |   7 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/ab8500.c | 171 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 337293d6f8b0..09a8ddcee0e5 100644
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
index 000000000000..4cd15c5fcf86
--- /dev/null
+++ b/drivers/power/regulator/ab8500.c
@@ -0,0 +1,171 @@
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
+#define AB8500_VAUX3_REGU		AB8500_REGU_CTRL2(0x0a)
+#define AB8500_VAUX3_REGU_EN_MASK	GENMASK(1, 0)
+#define AB8500_VAUX3_REGU_EN		BIT(0)
+
+#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
+#define AB8500_VAUX3_SEL_MASK	GENMASK(2, 0)
+
+#define AB8505_VAUX3_SEL3	AB8500_REGU_CTRL2(0x01)
+
+#define AB8505_VAUX3_SEL3_MASK	BIT(4)
+#define AB8505_VAUX3_SEL3_UV	3050000
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
+	struct udevice *pmic = ab8500_regulator_pmic(dev);
+	int ret;
+
+	if (device_is_compatible(pmic, "stericsson,ab8505")) {
+		ret = pmic_reg_read(pmic, AB8505_VAUX3_SEL3);
+		if (ret < 0)
+			return ret;
+		if (ret & AB8505_VAUX3_SEL3_MASK)
+			return AB8505_VAUX3_SEL3_UV;
+	}
+
+	ret = pmic_reg_read(pmic, AB8500_VAUX3_SEL);
+	if (ret < 0)
+		return ret;
+	ret &= AB8500_VAUX3_SEL_MASK;
+
+	return ab8500_vaux3_voltages[ret];
+}
+
+static int ab8500_regulator_set_value(struct udevice *dev, int uV)
+{
+	struct udevice *pmic = ab8500_regulator_pmic(dev);
+	bool is_ab8505 = device_is_compatible(pmic, "stericsson,ab8505");
+	int ret;
+	int i;
+
+	if (uV == AB8505_VAUX3_SEL3_UV) {
+		if (!is_ab8505)
+			return -EINVAL;
+
+		return pmic_clrsetbits(pmic, AB8505_VAUX3_SEL3,
+				       AB8505_VAUX3_SEL3_MASK,
+				       AB8505_VAUX3_SEL3_MASK);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_vaux3_voltages); i++) {
+		if (ab8500_vaux3_voltages[i] != uV)
+			continue;
+
+		ret = pmic_clrsetbits(pmic, AB8500_VAUX3_SEL,
+				      AB8500_VAUX3_SEL_MASK, i);
+		if (ret || !is_ab8505)
+			return ret;
+
+		return pmic_clrsetbits(pmic, AB8505_VAUX3_SEL3,
+				       AB8505_VAUX3_SEL3_MASK, 0);
+	}
+
+	return -EINVAL;
+}
+
+static int ab8500_regulator_set_value_clamp(struct udevice *dev, int min_uV,
+					    int target_uV, int max_uV)
+{
+	struct udevice *pmic = ab8500_regulator_pmic(dev);
+	int best_uV = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_vaux3_voltages); i++) {
+		int uV = ab8500_vaux3_voltages[i];
+
+		if (uV < min_uV || uV > max_uV)
+			continue;
+		if (best_uV < 0 || abs(uV - target_uV) <
+				   abs(best_uV - target_uV))
+			best_uV = uV;
+	}
+
+	if (device_is_compatible(pmic, "stericsson,ab8505") &&
+	    min_uV <= AB8505_VAUX3_SEL3_UV &&
+	    max_uV >= AB8505_VAUX3_SEL3_UV &&
+	    (best_uV < 0 || abs(AB8505_VAUX3_SEL3_UV - target_uV) <
+	     abs(best_uV - target_uV)))
+		best_uV = AB8505_VAUX3_SEL3_UV;
+
+	if (best_uV < 0)
+		return best_uV;
+
+	return ab8500_regulator_set_value(dev, best_uV);
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
+	return !!(ret & AB8500_VAUX3_REGU_EN_MASK);
+}
+
+static int ab8500_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	return pmic_clrsetbits(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU,
+			       AB8500_VAUX3_REGU_EN_MASK,
+			       enable ? AB8500_VAUX3_REGU_EN : 0);
+}
+
+static const struct dm_regulator_ops ab8500_regulator_ops = {
+	.get_value = ab8500_regulator_get_value,
+	.set_value = ab8500_regulator_set_value,
+	.set_value_clamp = ab8500_regulator_set_value_clamp,
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

