Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF72FCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225AE83FF9;
	Tue, 10 Mar 2026 01:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VTKT0gxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA07183FDE; Tue, 10 Mar 2026 01:55:21 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF2383FF9
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773104117; bh=L+Y0WMg+1X5F2QwUTilxbmw37aR+N69UzD/VjeYj1vE=;
 b=VTKT0gxFZ+flxFvCpmdh9KIwpZF2DCmA5LyAr9wQY8cbXUGnQ2wCDt2NspM1WQ/sddb4FNoPQ
 46GFOOgtgXby1Gzdf9AFoNlKpKg3oB9X6+smJAQb9nvPlJWayFEN30hHqZ4wUHX8gLgILIprqMZ
 GdNkoJ58hR4gdwqVpxnZg1ExUneLDggKv0uk8X7vd+dPUFJIxyAMwBn+5oaHi7DSZTVdWb89EjQ
 QPOW9HM/v+Hpx1adTEsd1FzI37mQ9jki+g/8ws1cAPdApk1Gp1HN2j+CrfPlW8wpUuRP4Z040/q
 7iD6Gb2SRuSFzaWZ/1gBbQKRoKxcpCrz4UZGpZG9xeLA==
X-Forward-Email-ID: 69af6bf073a8189bec327806
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Ye Zhang <ye.zhang@rock-chips.com>
Subject: [PATCH v3 08/12] pinctrl: rockchip: Add support for RK3506
Date: Tue, 10 Mar 2026 00:53:03 +0000
Message-ID: <20260310005326.606079-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005326.606079-1-jonas@kwiboo.se>
References: <20260310005326.606079-1-jonas@kwiboo.se>
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

From: Ye Zhang <ye.zhang@rock-chips.com>

Add pinctrl driver for RK3506.

Imported from vendor U-Boot linux-6.1-stan-rkr6 tag with adjustments
to use regmap_update_bits().

Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v3:
- Remove and add blank lines
- Collect r-b tag
Changes in v3:
- Collect t-b tag
---
 drivers/pinctrl/rockchip/Makefile             |   1 +
 drivers/pinctrl/rockchip/pinctrl-rk3506.c     | 462 ++++++++++++++++++
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  |   9 +
 drivers/pinctrl/rockchip/pinctrl-rockchip.h   |   1 +
 4 files changed, 473 insertions(+)
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3506.c

diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
index e17415e1ca68..0405df128dfa 100644
--- a/drivers/pinctrl/rockchip/Makefile
+++ b/drivers/pinctrl/rockchip/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += pinctrl-rk3308.o
 obj-$(CONFIG_ROCKCHIP_RK3328) += pinctrl-rk3328.o
 obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
+obj-$(CONFIG_ROCKCHIP_RK3506) += pinctrl-rk3506.o
 obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3506.c b/drivers/pinctrl/rockchip/pinctrl-rk3506.c
new file mode 100644
index 000000000000..e809e882c788
--- /dev/null
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3506.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
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
+static int rk3506_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int iomux_num = (pin / 8);
+	struct regmap *regmap;
+	int reg, mask;
+	u8 bit;
+	u32 data, rmask;
+
+	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
+		regmap = priv->regmap_pmu;
+	else
+		regmap = priv->regmap_base;
+
+	if (bank->bank_num == 1)
+		regmap = priv->regmap_ioc1;
+	else if (bank->bank_num == 4)
+		return 0;
+
+	reg = bank->iomux[iomux_num].offset;
+	if ((pin % 8) >= 4)
+		reg += 0x4;
+	bit = (pin % 4) * 4;
+	mask = 0xf;
+
+	if (bank->recalced_mask & BIT(pin))
+		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
+
+	data = (mask << (bit + 16));
+	rmask = data | (data >> 16);
+	data |= (mux & mask) << bit;
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RK3506_DRV_BITS_PER_PIN		8
+#define RK3506_DRV_PINS_PER_REG		2
+#define RK3506_DRV_GPIO0_A_OFFSET	0x100
+#define RK3506_DRV_GPIO0_D_OFFSET	0x830
+#define RK3506_DRV_GPIO1_OFFSET		0x140
+#define RK3506_DRV_GPIO2_OFFSET		0x180
+#define RK3506_DRV_GPIO3_OFFSET		0x1c0
+#define RK3506_DRV_GPIO4_OFFSET		0x840
+
+static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				       int pin_num, struct regmap **regmap,
+				       int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int ret = 0;
+
+	switch (bank->bank_num) {
+	case 0:
+		*regmap = priv->regmap_pmu;
+		if (pin_num > 24) {
+			ret = -EINVAL;
+		} else if (pin_num < 24) {
+			*reg = RK3506_DRV_GPIO0_A_OFFSET;
+		} else {
+			*reg = RK3506_DRV_GPIO0_D_OFFSET;
+			*bit = 3;
+
+			return 0;
+		}
+		break;
+
+	case 1:
+		*regmap = priv->regmap_ioc1;
+		if (pin_num < 28)
+			*reg = RK3506_DRV_GPIO1_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 2:
+		*regmap = priv->regmap_base;
+		if (pin_num < 17)
+			*reg = RK3506_DRV_GPIO2_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 3:
+		*regmap = priv->regmap_base;
+		if (pin_num < 15)
+			*reg = RK3506_DRV_GPIO3_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 4:
+		*regmap = priv->regmap_base;
+		if (pin_num < 8 || pin_num > 11) {
+			ret = -EINVAL;
+		} else {
+			*reg = RK3506_DRV_GPIO4_OFFSET;
+			*bit = 10;
+			return 0;
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret) {
+		debug("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
+		return ret;
+	}
+
+	*reg += ((pin_num / RK3506_DRV_PINS_PER_REG) * 4);
+	*bit = pin_num % RK3506_DRV_PINS_PER_REG;
+	*bit *= RK3506_DRV_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rk3506_set_drive(struct rockchip_pin_bank *bank,
+			    int pin_num, int strength)
+{
+	struct regmap *regmap;
+	int reg, ret, i;
+	u32 data, rmask;
+	u8 bit;
+	int rmask_bits = RK3506_DRV_BITS_PER_PIN;
+
+	ret = rk3506_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	for (i = 0, ret = 1; i < strength; i++)
+		ret = (ret << 1) | 1;
+
+	if ((bank->bank_num == 0 && pin_num == 24) || bank->bank_num == 4) {
+		rmask_bits = 2;
+		ret = strength;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << rmask_bits) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (ret << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RK3506_PULL_BITS_PER_PIN	2
+#define RK3506_PULL_PINS_PER_REG	8
+#define RK3506_PULL_GPIO0_A_OFFSET	0x200
+#define RK3506_PULL_GPIO0_D_OFFSET	0x830
+#define RK3506_PULL_GPIO1_OFFSET	0x210
+#define RK3506_PULL_GPIO2_OFFSET	0x220
+#define RK3506_PULL_GPIO3_OFFSET	0x230
+#define RK3506_PULL_GPIO4_OFFSET	0x840
+
+static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+					int pin_num, struct regmap **regmap,
+					int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int ret = 0;
+
+	switch (bank->bank_num) {
+	case 0:
+		*regmap = priv->regmap_pmu;
+		if (pin_num > 24) {
+			ret = -EINVAL;
+		} else if (pin_num < 24) {
+			*reg = RK3506_PULL_GPIO0_A_OFFSET;
+		} else {
+			*reg = RK3506_PULL_GPIO0_D_OFFSET;
+			*bit = 5;
+
+			return 0;
+		}
+		break;
+
+	case 1:
+		*regmap = priv->regmap_ioc1;
+		if (pin_num < 28)
+			*reg = RK3506_PULL_GPIO1_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 2:
+		*regmap = priv->regmap_base;
+		if (pin_num < 17)
+			*reg = RK3506_PULL_GPIO2_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 3:
+		*regmap = priv->regmap_base;
+		if (pin_num < 15)
+			*reg = RK3506_PULL_GPIO3_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 4:
+		*regmap = priv->regmap_base;
+		if (pin_num < 8 || pin_num > 11) {
+			ret = -EINVAL;
+		} else {
+			*reg = RK3506_PULL_GPIO4_OFFSET;
+			*bit = 13;
+
+			return 0;
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret) {
+		debug("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
+		return ret;
+	}
+
+	*reg += ((pin_num / RK3506_PULL_PINS_PER_REG) * 4);
+	*bit = pin_num % RK3506_PULL_PINS_PER_REG;
+	*bit *= RK3506_PULL_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rk3506_set_pull(struct rockchip_pin_bank *bank,
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
+	ret = rk3506_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	type = bank->pull_type[pin_num / 8];
+
+	if ((bank->bank_num == 0 && pin_num == 24) || bank->bank_num == 4)
+		type = 1;
+
+	ret = rockchip_translate_pull_value(type, pull);
+	if (ret < 0) {
+		debug("unsupported pull setting %d\n", pull);
+		return ret;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RK3506_PULL_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (ret << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RK3506_SMT_BITS_PER_PIN		1
+#define RK3506_SMT_PINS_PER_REG		8
+#define RK3506_SMT_GPIO0_A_OFFSET	0x400
+#define RK3506_SMT_GPIO0_D_OFFSET	0x830
+#define RK3506_SMT_GPIO1_OFFSET		0x410
+#define RK3506_SMT_GPIO2_OFFSET		0x420
+#define RK3506_SMT_GPIO3_OFFSET		0x430
+#define RK3506_SMT_GPIO4_OFFSET		0x840
+
+static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					   int pin_num,
+					   struct regmap **regmap,
+					   int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int ret = 0;
+
+	switch (bank->bank_num) {
+	case 0:
+		*regmap = priv->regmap_pmu;
+		if (pin_num > 24) {
+			ret = -EINVAL;
+		} else if (pin_num < 24) {
+			*reg = RK3506_SMT_GPIO0_A_OFFSET;
+		} else {
+			*reg = RK3506_SMT_GPIO0_D_OFFSET;
+			*bit = 9;
+
+			return 0;
+		}
+		break;
+
+	case 1:
+		*regmap = priv->regmap_ioc1;
+		if (pin_num < 28)
+			*reg = RK3506_SMT_GPIO1_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 2:
+		*regmap = priv->regmap_base;
+		if (pin_num < 17)
+			*reg = RK3506_SMT_GPIO2_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 3:
+		*regmap = priv->regmap_base;
+		if (pin_num < 15)
+			*reg = RK3506_SMT_GPIO3_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 4:
+		*regmap = priv->regmap_base;
+		if (pin_num < 8 || pin_num > 11) {
+			ret = -EINVAL;
+		} else {
+			*reg = RK3506_SMT_GPIO4_OFFSET;
+			*bit = 8;
+
+			return 0;
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret) {
+		debug("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
+		return ret;
+	}
+
+	*reg += ((pin_num / RK3506_SMT_PINS_PER_REG) * 4);
+	*bit = pin_num % RK3506_SMT_PINS_PER_REG;
+	*bit *= RK3506_SMT_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rk3506_set_schmitt(struct rockchip_pin_bank *bank,
+			      int pin_num, int enable)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data, rmask;
+	u8 bit;
+
+	ret = rk3506_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RK3506_SMT_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (enable << bit);
+
+	if ((bank->bank_num == 0 && pin_num == 24) || bank->bank_num == 4) {
+		data = 0x3 << (bit + 16);
+		rmask = data | (data >> 16);
+		data |= ((enable ? 0x3 : 0) << bit);
+	}
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+static struct rockchip_mux_recalced_data rk3506_mux_recalced_data[] = {
+	{
+		.num = 0,
+		.pin = 24,
+		.reg = 0x830,
+		.bit = 0,
+		.mask = 0x3
+	},
+};
+
+static struct rockchip_pin_bank rk3506_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
+				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
+				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
+				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
+				    IOMUX_8WIDTH_2BIT | IOMUX_SOURCE_PMU,
+				    0x0, 0x8, 0x10, 0x830),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x20, 0x28, 0x30, 0x38),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x40, 0x48, 0x50, 0x58),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(3, 32, "gpio3",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x60, 0x68, 0x70, 0x78),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(4, 32, "gpio4",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x80, 0x88, 0x90, 0x98),
+};
+
+static const struct rockchip_pin_ctrl rk3506_pin_ctrl = {
+	.pin_banks		= rk3506_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rk3506_pin_banks),
+	.iomux_recalced		= rk3506_mux_recalced_data,
+	.niomux_recalced	= ARRAY_SIZE(rk3506_mux_recalced_data),
+	.set_mux		= rk3506_set_mux,
+	.set_pull		= rk3506_set_pull,
+	.set_drive		= rk3506_set_drive,
+	.set_schmitt		= rk3506_set_schmitt,
+};
+
+static const struct udevice_id rk3506_pinctrl_ids[] = {
+	{
+		.compatible = "rockchip,rk3506-pinctrl",
+		.data = (ulong)&rk3506_pin_ctrl
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3506_pinctrl) = {
+	.name		= "rockchip_rk3506_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= rk3506_pinctrl_ids,
+	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
+	.ops		= &rockchip_pinctrl_ops,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind		= dm_scan_fdt_dev,
+#endif
+	.probe		= rockchip_pinctrl_probe,
+};
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 273e356e7c02..957dcb520591 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -659,6 +659,15 @@ int rockchip_pinctrl_probe(struct udevice *dev)
 		}
 	}
 
+	if (dev_read_bool(dev, "rockchip,ioc1")) {
+		priv->regmap_ioc1 =
+			syscon_regmap_lookup_by_phandle(dev, "rockchip,ioc1");
+		if (IS_ERR(priv->regmap_ioc1)) {
+			debug("unable to find rockchip,ioc1 regmap\n");
+			return PTR_ERR(priv->regmap_ioc1);
+		}
+	}
+
 	ctrl = rockchip_pinctrl_get_soc_data(dev);
 	if (!ctrl) {
 		debug("driver data not available\n");
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
index ba684baed24d..568e6024b78c 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
@@ -528,6 +528,7 @@ struct rockchip_pinctrl_priv {
 	struct rockchip_pin_ctrl	*ctrl;
 	struct regmap			*regmap_base;
 	struct regmap			*regmap_pmu;
+	struct regmap			*regmap_ioc1;
 };
 
 extern const struct pinctrl_ops rockchip_pinctrl_ops;
-- 
2.53.0

