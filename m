Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FFFE7C6F6
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87F783B85;
	Sun,  1 Feb 2026 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JnD421ix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166F383AA9; Sun,  1 Feb 2026 01:45:17 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F5C683AA9
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7927b1620ddso48066637b3.0
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906710; x=1770511510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71IHb8Zapeh1PQMmWU89I7LCxcSzug2sZyo+upJy2DA=;
 b=JnD421ixWgJG5XUH+jkhw3h7MUHRbwdZ7geyf5lnU1z1Mf4qPMVicwF2Xxqcir5kxi
 jE6t251U1iKg7XGc0fUHnVJR1aRMaHG2jqBEyVSfPeqwcIqKbZwo25pRq6GpDG6XRywc
 9YALjTHSEof7qu0O36kweHKX04II2jLTZEIQQKGVGDT6ivt1zHFssxN0Cf6VVIIbHjmc
 Sn9IhU73M9qWaFs+ZG9fvuqAhM+Eo8uN6W8tY7hbcNhWDfDnNFcq7jpx7t1KZ1xwkpWK
 bMKD+EPB/3LSv77YzzWKPoYWZMOr+l//S0T5OMwYqHyDBZioxAwC1tvg4JjUBCy8b7Qv
 y+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906710; x=1770511510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71IHb8Zapeh1PQMmWU89I7LCxcSzug2sZyo+upJy2DA=;
 b=jtzowyCaR7yW09jTPWk/2IIGBMtyOP6NMutelkwGE3G/5Gbqg/WrA47onZ6lYiPcje
 u67sXEhzgnJ1m2HiNyMdPOyL+bxLndmza0mY7lkbCqLu/PtArpDV2CllmC1qnRRX96n3
 SUvXKB0zmRcR6FZsq2nnrIrqFpkCOQ5dhomCigImejE22TE22gYpBW9NbD2Ovlgg0a/j
 u1ZRZ2Gv2e77TqzrcYoM4SoDyt0G1J0woXq2wCBOqLS35+ksBuwPuHZiJ4b6jIsBxWIs
 aJ3dyYEaEtGJhrXvxs5NB3L5FTkMCb5H0poSjOudu1lpT1s/tGpgLmZraATORulMWqiO
 0npA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPViOYNlBkUNoKuL84se0unJyIjDySbhPxTr92ogPznX8Pc60r/n34FosP/tKp8jIyjGnCKeE=@lists.denx.de
X-Gm-Message-State: AOJu0YxMxnjtn1s0HQy51WFaNza0mMZpV+AiJrpkjkE0vlb8gJSbIgkK
 F7i9MLBQRmMdah9F0ZuolNF4kWiNNd4yGrkkFqqn5LDX0ESpo3OR7C5xo0ACMw==
X-Gm-Gg: AZuq6aIkBGjx1nte3cVbAbxQ569Wm9BrdIJvn75awEqUzSQFFza5dJLREQ+oYBo4PtE
 u4/9vKe50cRuBwKFAy3wN9K76Ybc7ri/I81HYkmr1woSRfz0Wcgpm65ENUjHWE0WhG4y9NRL+Au
 ZCZcFqRToMBeF58EoiT+K/8kPedEdQX1EhAyP6xrcoGchxJlE/HqncS0XKn8itOg0GS1mbigYmL
 dulF06BeYNs3YULFoViaDF7hw7E+j5YfTXPblhl6LV6/nnOu/w2bx3XrME3jSQ5HAeWOouCGsyv
 8RnneH35GmmiMkjg3HG78EuANGcHHuWD7l7AYojmxA5UqJ2Bex8z8kDMO+9lvVQxvdiMqDrh6NO
 v12AQQWeNShvJTlBIrrzC9p7hGVBAIlQM4F8NRD3vTDW0kurAwQ8up4YTWPixoGH7/36AZmNvJ2
 hqLoQ/4w5I9LhYERhHLQoxwDa5
X-Received: by 2002:a05:690c:3383:b0:794:c58e:2d97 with SMTP id
 00721157ae682-794c58e336amr8407957b3.8.1769906710038; 
 Sat, 31 Jan 2026 16:45:10 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:09 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 1/7] pinctrl: rockchip: Add support for RV1103
Date: Sat, 31 Jan 2026 21:44:50 -0300
Message-Id: <20260201004456.763107-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add pinctrl driver for RV1103.

Imported from Rockchip U-Boot 2017.09 next-dev branch.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 drivers/pinctrl/Kconfig                   |  10 +
 drivers/pinctrl/rockchip/Makefile         |   1 +
 drivers/pinctrl/rockchip/pinctrl-rv1103.c | 411 ++++++++++++++++++++++
 3 files changed, 422 insertions(+)
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index ea90713ec6ca..e204d9880d83 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -254,6 +254,16 @@ config PINCTRL_QE
 	  This option is to enable the QE pinctrl driver for QE based io
 	  controller.
 
+config PINCTRL_ROCKCHIP_RV1103
+	bool "Rockchip rv1103 pin control driver"
+	depends on DM
+	help
+	  Support pin multiplexing control on Rockchip rv1103 SoC.
+
+	  The driver is controlled by a device tree node which contains
+	  both the GPIO definitions and pin control functions for each
+	  available multiplex function.
+
 config PINCTRL_ROCKCHIP_RV1108
 	bool "Rockchip rv1108 pin control driver"
 	depends on DM
diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
index e17415e1ca68..f0ffd2b5fe86 100644
--- a/drivers/pinctrl/rockchip/Makefile
+++ b/drivers/pinctrl/rockchip/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
+obj-$(CONFIG_ROCKCHIP_RV1103) += pinctrl-rv1103.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1103.c b/drivers/pinctrl/rockchip/pinctrl-rv1103.c
new file mode 100644
index 000000000000..362c520212ee
--- /dev/null
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1103.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Rockchip Electronics Co., Ltd
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <dm/pinctrl.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <linux/bitops.h>
+
+#include "pinctrl-rockchip.h"
+
+static int rv1103_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int iomux_num = (pin / 8);
+	struct regmap *regmap;
+	int reg, ret, mask;
+	u8 bit;
+	u32 data;
+
+	debug("setting mux of GPIO%d-%d to %d\n", bank->bank_num, pin, mux);
+
+	if (bank->bank_num == 2 && pin >= 12)
+		return 0;
+
+	regmap = priv->regmap_base;
+	reg = bank->iomux[iomux_num].offset;
+	if ((pin % 8) >= 4)
+		reg += 0x4;
+	bit = (pin % 4) * 4;
+	mask = 0xf;
+
+	if (bank->recalced_mask & BIT(pin))
+		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
+	data = (mask << (bit + 16));
+	data |= (mux & mask) << bit;
+
+	debug("iomux write reg = %x data = %x\n", reg, data);
+
+	ret = regmap_write(regmap, reg, data);
+
+	return ret;
+}
+
+#define RV1103_DRV_BITS_PER_PIN		8
+#define RV1103_DRV_PINS_PER_REG		2
+#define RV1103_DRV_GPIO0_A_OFFSET		0x40100
+#define RV1103_DRV_GPIO0_B_OFFSET		0x50110
+#define RV1103_DRV_GPIO1_A01_OFFSET		0x140
+#define RV1103_DRV_GPIO1_A67_OFFSET		0x1014C
+#define RV1103_DRV_GPIO2_OFFSET		0x30180
+#define RV1103_DRV_GPIO2_SARADC_OFFSET		0x3080C
+
+static int rv1103_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				       int pin_num, struct regmap **regmap,
+				       int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int ret = 0;
+
+	*regmap = priv->regmap_base;
+	switch (bank->bank_num) {
+	case 0:
+		if (pin_num < 7)
+			*reg = RV1103_DRV_GPIO0_A_OFFSET;
+		else if (pin_num > 7 && pin_num < 14)
+			*reg = RV1103_DRV_GPIO0_B_OFFSET - 0x10;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 1:
+		if (pin_num < 6)
+			*reg = RV1103_DRV_GPIO1_A01_OFFSET;
+		else if (pin_num >= 6 && pin_num < 23)
+			*reg = RV1103_DRV_GPIO1_A67_OFFSET - 0xc;
+		else if (pin_num >= 24 && pin_num < 30)
+			*reg = RV1103_DRV_GPIO1_A67_OFFSET - 0xc;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 2:
+		if (pin_num < 12) {
+			*reg = RV1103_DRV_GPIO2_OFFSET;
+		} else if (pin_num >= 16) {
+			ret = -EINVAL;
+		} else {
+			*reg = RV1103_DRV_GPIO2_SARADC_OFFSET;
+			*bit = 10;
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
+		printf("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
+
+		return ret;
+	}
+
+	*reg += ((pin_num / RV1103_DRV_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1103_DRV_PINS_PER_REG;
+	*bit *= RV1103_DRV_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rv1103_set_drive(struct rockchip_pin_bank *bank,
+			    int pin_num, int strength)
+{
+	struct regmap *regmap;
+	int reg, ret, i;
+	u32 data;
+	u8 bit;
+	int rmask_bits = RV1103_DRV_BITS_PER_PIN;
+
+	ret = rv1103_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	for (i = 0, ret = 1; i < strength; i++)
+		ret = (ret << 1) | 1;
+
+	if (bank->bank_num == 2 && pin_num >= 12) {
+		rmask_bits = 2;
+		ret = strength;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << rmask_bits) - 1) << (bit + 16);
+	data |= (ret << bit);
+	ret = regmap_write(regmap, reg, data);
+
+	return ret;
+}
+
+#define RV1103_PULL_BITS_PER_PIN		2
+#define RV1103_PULL_PINS_PER_REG		8
+#define RV1103_PULL_GPIO0_A_OFFSET		0x40200
+#define RV1103_PULL_GPIO0_B_OFFSET		0x50204
+#define RV1103_PULL_GPIO1_A01_OFFSET		0x210
+#define RV1103_PULL_GPIO1_A67_OFFSET		0x10210
+#define RV1103_PULL_GPIO2_OFFSET		0x30220
+#define RV1103_PULL_GPIO2_SARADC_OFFSET	0x3080C
+
+static int rv1103_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+					int pin_num, struct regmap **regmap,
+					int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int ret = 0;
+
+	*regmap = priv->regmap_base;
+	switch (bank->bank_num) {
+	case 0:
+		if (pin_num < 7)
+			*reg = RV1103_PULL_GPIO0_A_OFFSET;
+		else if (pin_num > 7 && pin_num < 14)
+			*reg = RV1103_PULL_GPIO0_B_OFFSET - 0x4;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 1:
+		if (pin_num < 6)
+			*reg = RV1103_PULL_GPIO1_A01_OFFSET;
+		else if (pin_num >= 6 && pin_num < 23)
+			*reg = RV1103_PULL_GPIO1_A67_OFFSET;
+		else if (pin_num >= 24 && pin_num < 30)
+			*reg = RV1103_PULL_GPIO1_A67_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 2:
+		if (pin_num < 12) {
+			*reg = RV1103_PULL_GPIO2_OFFSET;
+		} else if (pin_num >= 16) {
+			ret = -EINVAL;
+		} else {
+			*reg = RV1103_PULL_GPIO2_SARADC_OFFSET;
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
+		printf("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
+
+		return ret;
+	}
+
+	*reg += ((pin_num / RV1103_PULL_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1103_PULL_PINS_PER_REG;
+	*bit *= RV1103_PULL_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rv1103_set_pull(struct rockchip_pin_bank *bank,
+			   int pin_num, int pull)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u8 bit, type;
+	u32 data;
+
+	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
+		return -EINVAL;
+
+	ret = rv1103_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+	type = bank->pull_type[pin_num / 8];
+
+	if (bank->bank_num == 2 && pin_num >= 12)
+		type = 1;
+
+	ret = rockchip_translate_pull_value(type, pull);
+	if (ret < 0) {
+		debug("unsupported pull setting %d\n", pull);
+
+		return ret;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RV1103_PULL_BITS_PER_PIN) - 1) << (bit + 16);
+
+	data |= (ret << bit);
+	ret = regmap_write(regmap, reg, data);
+
+	return ret;
+}
+
+#define RV1103_SMT_BITS_PER_PIN		1
+#define RV1103_SMT_PINS_PER_REG		8
+#define RV1103_SMT_GPIO0_A_OFFSET		0x40400
+#define RV1103_SMT_GPIO0_B_OFFSET		0x50404
+#define RV1103_SMT_GPIO1_A01_OFFSET		0x410
+#define RV1103_SMT_GPIO1_A67_OFFSET		0x10410
+#define RV1103_SMT_GPIO2_OFFSET		0x30420
+#define RV1103_SMT_GPIO2_SARADC_OFFSET		0x3080C
+
+static int rv1103_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					   int pin_num,
+					   struct regmap **regmap,
+					   int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int ret = 0;
+
+	*regmap = priv->regmap_base;
+	switch (bank->bank_num) {
+	case 0:
+		if (pin_num < 7)
+			*reg = RV1103_SMT_GPIO0_A_OFFSET;
+		else if (pin_num > 7 && pin_num < 14)
+			*reg = RV1103_SMT_GPIO0_B_OFFSET - 0x4;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 1:
+		if (pin_num < 6)
+			*reg = RV1103_SMT_GPIO1_A01_OFFSET;
+		else if (pin_num >= 6 && pin_num < 23)
+			*reg = RV1103_SMT_GPIO1_A67_OFFSET;
+		else if (pin_num >= 24 && pin_num < 30)
+			*reg = RV1103_SMT_GPIO1_A67_OFFSET;
+		else
+			ret = -EINVAL;
+		break;
+
+	case 2:
+		if (pin_num < 12) {
+			*reg = RV1103_SMT_GPIO2_OFFSET;
+		} else if (pin_num >= 16) {
+			ret = -EINVAL;
+		} else {
+			*reg = RV1103_SMT_GPIO2_SARADC_OFFSET;
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
+		printf("unsupported bank_num %d pin_num %d\n", bank->bank_num, pin_num);
+
+		return ret;
+	}
+
+	*reg += ((pin_num / RV1103_SMT_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1103_SMT_PINS_PER_REG;
+	*bit *= RV1103_SMT_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rv1103_set_schmitt(struct rockchip_pin_bank *bank,
+			      int pin_num, int enable)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data;
+	u8 bit;
+
+	ret = rv1103_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RV1103_SMT_BITS_PER_PIN) - 1) << (bit + 16);
+	data |= (enable << bit);
+
+	if (bank->bank_num == 2 && pin_num >= 12) {
+		data = 0x3 << (bit + 16);
+		data |= ((enable ? 0x3 : 0) << bit);
+	}
+	ret = regmap_write(regmap, reg, data);
+
+	return ret;
+}
+
+static struct rockchip_mux_recalced_data rv1103_mux_recalced_data[] = {
+	{
+		.num = 1,
+		.pin = 6,
+		.reg = 0x10024,
+		.bit = 8,
+		.mask = 0xf
+	}, {
+		.num = 1,
+		.pin = 7,
+		.reg = 0x10024,
+		.bit = 12,
+		.mask = 0xf
+	},
+};
+
+static struct rockchip_pin_bank rv1103_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x40000, 0x50008, 0x50010, 0x50018),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x20, 0x10028, 0x10030, 0x10038),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x30040, 0x30048, 0x30050, 0x30058),
+};
+
+static const struct rockchip_pin_ctrl rv1103_pin_ctrl = {
+	.pin_banks		= rv1103_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rv1103_pin_banks),
+	.iomux_recalced		= rv1103_mux_recalced_data,
+	.niomux_recalced	= ARRAY_SIZE(rv1103_mux_recalced_data),
+	.set_mux		= rv1103_set_mux,
+	.set_pull		= rv1103_set_pull,
+	.set_drive		= rv1103_set_drive,
+	.set_schmitt		= rv1103_set_schmitt,
+};
+
+static const struct udevice_id rv1103_pinctrl_ids[] = {
+	{
+		.compatible = "rockchip,rv1103-pinctrl",
+		.data = (ulong)&rv1103_pin_ctrl
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_rv1103) = {
+	.name		= "rockchip_rv1103_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= rv1103_pinctrl_ids,
+	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
+	.ops		= &rockchip_pinctrl_ops,
+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
+	.bind		= dm_scan_fdt_dev,
+#endif
+	.probe		= rockchip_pinctrl_probe,
+};
-- 
2.34.1

