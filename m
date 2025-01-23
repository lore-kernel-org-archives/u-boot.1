Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88005C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065F9807DC;
	Thu, 23 Jan 2025 23:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="e1+bbUZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34B7807FE; Thu, 23 Jan 2025 23:49:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C92D807E0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737672551; bh=vBNpTy08g9MA50YcqSMwY1LpptMFHmxJfW+bmNbAwV4=;
 b=e1+bbUZ9LzS0MPkExJlsgwvyF7Ay9Kl5f2hawZ1tGb87Ee6EiEIRsTk62CaTMr8CbNs+bKa7X
 U3fagAZhDj9Z8KYKNbhXc90vSnZIwxhe5ugO97xw+9zjT41ByJwpB5Xo7ZX2h6cudDpEzk17AGF
 T7Kp1u8s1XwvYQkJ7IErcBSlqCcGZVKfjs0l8CqhV0a4BuR4XJzbjpOeGogJNj87RLfzpOeVbPu
 7vsZ9AgrAYkrGBNmjkiaxeBuDClA2EQXWd8Q0iyeH5B6jI4alvH6iVkulEnaBgfNezVFQdzBdOh
 INeg+duVCC+ypUbRikWeo91fcwHo9ZmWUay+AH6+mnCQ==
X-Forward-Email-ID: 6792c763f07771e5c89e0157
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Steven Liu <steven.liu@rock-chips.com>
Subject: [PATCH 05/13] pinctrl: rockchip: Add support for RK3528
Date: Thu, 23 Jan 2025 22:48:17 +0000
Message-ID: <20250123224844.3104592-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123224844.3104592-1-jonas@kwiboo.se>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
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

From: Steven Liu <steven.liu@rock-chips.com>

Add pinctrl driver for RK3528.

Imported from vendor U-Boot linux-6.1-stan-rkr5 tag with adjustments
to use regmap_update_bits().

Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/pinctrl/rockchip/Makefile         |   1 +
 drivers/pinctrl/rockchip/pinctrl-rk3528.c | 292 ++++++++++++++++++++++
 2 files changed, 293 insertions(+)
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3528.c

diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
index c91f650b0434..df6c97d6234b 100644
--- a/drivers/pinctrl/rockchip/Makefile
+++ b/drivers/pinctrl/rockchip/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += pinctrl-rk3308.o
 obj-$(CONFIG_ROCKCHIP_RK3328) += pinctrl-rk3328.o
 obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
+obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3528.c b/drivers/pinctrl/rockchip/pinctrl-rk3528.c
new file mode 100644
index 000000000000..e8e2703b5e97
--- /dev/null
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3528.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <regmap.h>
+#include <syscon.h>
+
+#include "pinctrl-rockchip.h"
+#include <dt-bindings/pinctrl/rockchip.h>
+
+static int rk3528_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int iomux_num = (pin / 8);
+	struct regmap *regmap;
+	int reg, mask;
+	u8 bit;
+	u32 data, rmask;
+
+	regmap = priv->regmap_base;
+	reg = bank->iomux[iomux_num].offset;
+	if ((pin % 8) >= 4)
+		reg += 0x4;
+	bit = (pin % 4) * 4;
+	mask = 0xf;
+
+	data = (mask << (bit + 16));
+	rmask = data | (data >> 16);
+	data |= (mux & mask) << bit;
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RK3528_DRV_BITS_PER_PIN		8
+#define RK3528_DRV_PINS_PER_REG		2
+#define RK3528_DRV_GPIO0_OFFSET		0x100
+#define RK3528_DRV_GPIO1_OFFSET		0x20120
+#define RK3528_DRV_GPIO2_OFFSET		0x30160
+#define RK3528_DRV_GPIO3_OFFSET		0x20190
+#define RK3528_DRV_GPIO4_OFFSET		0x101C0
+
+static void rk3528_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+					int pin_num, struct regmap **regmap,
+					int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+
+	*regmap = priv->regmap_base;
+	switch (bank->bank_num) {
+	case 0:
+		*reg = RK3528_DRV_GPIO0_OFFSET;
+		break;
+	case 1:
+		*reg = RK3528_DRV_GPIO1_OFFSET;
+		break;
+	case 2:
+		*reg = RK3528_DRV_GPIO2_OFFSET;
+		break;
+	case 3:
+		*reg = RK3528_DRV_GPIO3_OFFSET;
+		break;
+	case 4:
+		*reg = RK3528_DRV_GPIO4_OFFSET;
+		break;
+	default:
+		*reg = 0;
+		debug("unsupported bank_num %d\n", bank->bank_num);
+		break;
+	}
+
+	*reg += ((pin_num / RK3528_DRV_PINS_PER_REG) * 4);
+	*bit = pin_num % RK3528_DRV_PINS_PER_REG;
+	*bit *= RK3528_DRV_BITS_PER_PIN;
+}
+
+static int rk3528_set_drive(struct rockchip_pin_bank *bank,
+			    int pin_num, int strength)
+{
+	struct regmap *regmap;
+	int reg;
+	u32 data, rmask;
+	u8 bit;
+	int drv = (1 << (strength + 1)) - 1;
+
+	rk3528_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RK3528_DRV_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (drv << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RK3528_PULL_BITS_PER_PIN		2
+#define RK3528_PULL_PINS_PER_REG		8
+#define RK3528_PULL_GPIO0_OFFSET		0x200
+#define RK3528_PULL_GPIO1_OFFSET		0x20210
+#define RK3528_PULL_GPIO2_OFFSET		0x30220
+#define RK3528_PULL_GPIO3_OFFSET		0x20230
+#define RK3528_PULL_GPIO4_OFFSET		0x10240
+
+static void rk3528_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+					 int pin_num, struct regmap **regmap,
+					 int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+
+	*regmap = priv->regmap_base;
+	switch (bank->bank_num) {
+	case 0:
+		*reg = RK3528_PULL_GPIO0_OFFSET;
+		break;
+	case 1:
+		*reg = RK3528_PULL_GPIO1_OFFSET;
+		break;
+	case 2:
+		*reg = RK3528_PULL_GPIO2_OFFSET;
+		break;
+	case 3:
+		*reg = RK3528_PULL_GPIO3_OFFSET;
+		break;
+	case 4:
+		*reg = RK3528_PULL_GPIO4_OFFSET;
+		break;
+	default:
+		*reg = 0;
+		debug("unsupported bank_num %d\n", bank->bank_num);
+		break;
+	}
+
+	*reg += ((pin_num / RK3528_PULL_PINS_PER_REG) * 4);
+	*bit = pin_num % RK3528_PULL_PINS_PER_REG;
+	*bit *= RK3528_PULL_BITS_PER_PIN;
+}
+
+static int rk3528_set_pull(struct rockchip_pin_bank *bank,
+			   int pin_num, int pull)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u8 bit, type;
+	u32 data, rmask;
+
+	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
+		return -EOPNOTSUPP;
+
+	rk3528_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	type = bank->pull_type[pin_num / 8];
+	ret = rockchip_translate_pull_value(type, pull);
+	if (ret < 0) {
+		debug("unsupported pull setting %d\n", pull);
+		return ret;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RK3528_PULL_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (ret << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RK3528_SMT_BITS_PER_PIN		1
+#define RK3528_SMT_PINS_PER_REG		8
+#define RK3528_SMT_GPIO0_OFFSET		0x400
+#define RK3528_SMT_GPIO1_OFFSET		0x20410
+#define RK3528_SMT_GPIO2_OFFSET		0x30420
+#define RK3528_SMT_GPIO3_OFFSET		0x20430
+#define RK3528_SMT_GPIO4_OFFSET		0x10440
+
+static int rk3528_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					   int pin_num,
+					   struct regmap **regmap,
+					   int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+
+	*regmap = priv->regmap_base;
+	switch (bank->bank_num) {
+	case 0:
+		*reg = RK3528_SMT_GPIO0_OFFSET;
+		break;
+	case 1:
+		*reg = RK3528_SMT_GPIO1_OFFSET;
+		break;
+	case 2:
+		*reg = RK3528_SMT_GPIO2_OFFSET;
+		break;
+	case 3:
+		*reg = RK3528_SMT_GPIO3_OFFSET;
+		break;
+	case 4:
+		*reg = RK3528_SMT_GPIO4_OFFSET;
+		break;
+	default:
+		*reg = 0;
+		debug("unsupported bank_num %d\n", bank->bank_num);
+		break;
+	}
+
+	*reg += ((pin_num / RK3528_SMT_PINS_PER_REG) * 4);
+	*bit = pin_num % RK3528_SMT_PINS_PER_REG;
+	*bit *= RK3528_SMT_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rk3528_set_schmitt(struct rockchip_pin_bank *bank,
+			      int pin_num, int enable)
+{
+	struct regmap *regmap;
+	int reg;
+	u32 data, rmask;
+	u8 bit;
+
+	rk3528_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RK3528_SMT_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (enable << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+static struct rockchip_pin_bank rk3528_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0, 0, 0, 0),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x20020, 0x20028, 0x20030, 0x20038),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x30040, 0, 0, 0),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(3, 32, "gpio3",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x20060, 0x20068, 0x20070, 0),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(4, 32, "gpio4",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x10080, 0x10088, 0x10090, 0x10098),
+};
+
+static const struct rockchip_pin_ctrl rk3528_pin_ctrl = {
+	.pin_banks		= rk3528_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rk3528_pin_banks),
+	.nr_pins		= 160,
+	.grf_mux_offset		= 0x0,
+	.set_mux		= rk3528_set_mux,
+	.set_pull		= rk3528_set_pull,
+	.set_drive		= rk3528_set_drive,
+	.set_schmitt		= rk3528_set_schmitt,
+};
+
+static const struct udevice_id rk3528_pinctrl_ids[] = {
+	{
+		.compatible = "rockchip,rk3528-pinctrl",
+		.data = (ulong)&rk3528_pin_ctrl
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3528_pinctrl) = {
+	.name		= "rockchip_rk3528_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= rk3528_pinctrl_ids,
+	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
+	.ops		= &rockchip_pinctrl_ops,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind		= dm_scan_fdt_dev,
+#endif
+	.probe		= rockchip_pinctrl_probe,
+};
-- 
2.48.1

