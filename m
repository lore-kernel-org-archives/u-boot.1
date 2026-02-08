Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322BDEF06EC
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F4A83C14;
	Sun,  8 Feb 2026 22:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LtsZtArb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDBA83C14; Sun,  8 Feb 2026 22:26:41 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8777083BC9
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso1033741d50.3
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770585998; x=1771190798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLqJgUH96NzxOqmi0YVc5whF0s7w61fNF0agGhVqkmo=;
 b=LtsZtArbdyy5aLrLLZfMWNdLIgm2rQFXBLwN6dZMtCVjlX3ajZDkVvMC3ZPRIA1ywl
 VEyLs/qeNfyPSGUx02szekjrrwgf2n2cUCMOapoe+ARKcmG9MLQ6siCAbCKB0Y3B3DkL
 yJHDdHuT7OiAQbwp+8/w18RX9P/ijuKa4N+U0k66opF+AhPHheqh/Qiwxl8XBKy0dBEo
 IO9rUc3IuMgk7+Xi5H4llw3WKqsVm9pQA7e6mSWinK9odcAxQo6x+qbE6dvufS76GD5T
 aKKPiO6kVTKcSt0MP10zB4/xNcu4gRj+iheaqU/58qMPaupVswxVECsXj1EkP8189zfp
 E0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770585998; x=1771190798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLqJgUH96NzxOqmi0YVc5whF0s7w61fNF0agGhVqkmo=;
 b=hM89COVDNWCoZ43FqMp6cgjT62pbJEG28CA1aYLt1T9YwsQA3ISR0Hh+7nd5fqkqZ9
 WFyPAGF00iMGWX6liQEM8JLSgJkNSGld6rIsj23ndYKhaxixAAIPvYrTTZCRZ4rtVwvQ
 rntZD/NUJfuviC/u5VBTEABzln9QmbjAmx5N/mWjqPMooOSnXemuGJs/1VCmEruAPbkG
 4uilI16zlKeC+zc1nkjcTzlyfaN8tzRIwTK83C1XxwVNtd/ab0YMZuj/jefkGO4DFcoJ
 7LcDmnfVm+kay5RrdGDOHB8eFsvnUdLOC71gD4OZmu8hlIxCzFmat0pu1EaBD6EMsiIB
 pHVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7fj5T8QcmKA7xqlZbDIIqOsbJsTfcqIlyF8Rf2ligyI1aLnyR8EzoZGlSqEgzgEa+ovd1WFY=@lists.denx.de
X-Gm-Message-State: AOJu0YwMtw1bDHnIg/B5WdUouyVsCkj+FspSseR2qtkb+H3kFfwVwlI6
 gKGnVPJhtzZ4GTBS3blUQUdHzQpjbE3C5cfwTQrLBBqX8cZyMzvBcTJW
X-Gm-Gg: AZuq6aIyhxQ+yKv3Tu9LmM9ch03DAp15S8HMjLpmhjIvNF+NOzH3hGKDBxgQ76Pdsss
 5jTFeSgLwdXbc1WTLvOVNlVIgRGzHQZAmstjGjEf7IOyMT06elTgGGGMf+9pgAWiVoPPzFNi4DJ
 OP5TZZ/OqL/gSy5zMObk2VbARKoFEA2qnWh9D24l1RRuQvvANG9HWAslSirY0eOEVbrHzjzhdtK
 g4YWsWaOnlb8mKDsXBq6AymNRSD+Mhy9evAunmH0DWVBV3cKQRrgE4X7lZ5CQLl0NZqqFhl1gg5
 FaLnTa7TxylVUqAion9AtxEaXNkyX5GnJD+SWcFrAx3al7nn/p5yFyX8+m3MBKDSFIPPskvzbZl
 9L2W+4ob1a0j85vp9hv3eF4AVC/fyeYbZqZ3yI/1hQQtMM2ZXxbDThhTNhIZksqZemYmspF+ouY
 NfBHoREG8QDhi46CHwD5DbT3b/
X-Received: by 2002:a05:690c:4990:b0:796:349f:5aef with SMTP id
 00721157ae682-796349f5eb5mr38558107b3.69.1770585998234; 
 Sun, 08 Feb 2026 13:26:38 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:37 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Ye Zhang <ye.zhang@rock-chips.com>, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 2/7] pinctrl: rockchip: Add RV1103B support
Date: Sun,  8 Feb 2026 18:26:19 -0300
Message-Id: <20260208212624.3413494-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
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

Add pinctrl driver for RV1103.

Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Use the original author from Rockchip's vendor U-Boot tree.
- Use regmap_update_bits()
- Removed unneeded blank lines.
- Removed unneeded logging functions.

 drivers/pinctrl/rockchip/Makefile          |   1 +
 drivers/pinctrl/rockchip/pinctrl-rv1103b.c | 398 +++++++++++++++++++++
 2 files changed, 399 insertions(+)
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103b.c

diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
index e17415e1ca68..2bbee66bd3ca 100644
--- a/drivers/pinctrl/rockchip/Makefile
+++ b/drivers/pinctrl/rockchip/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
+obj-$(CONFIG_ROCKCHIP_RV1103B) += pinctrl-rv1103b.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1103b.c b/drivers/pinctrl/rockchip/pinctrl-rv1103b.c
new file mode 100644
index 000000000000..fb946b036661
--- /dev/null
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1103b.c
@@ -0,0 +1,398 @@
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
+static int rv1103b_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int iomux_num = (pin / 8);
+	struct regmap *regmap;
+	u32 data, rmask;
+	int reg, mask;
+	u8 bit;
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
+	rmask = data | (data >> 16);
+	data |= (mux & mask) << bit;
+
+	return regmap_update_bits(regmap, reg, rmask, data);
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
+static int rv1103b_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
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
+static int rv1103b_set_drive(struct rockchip_pin_bank *bank,
+			    int pin_num, int strength)
+{
+	struct regmap *regmap;
+	int reg, ret, i;
+	u32 data;
+	u8 bit;
+	int rmask_bits = RV1103_DRV_BITS_PER_PIN;
+
+	ret = rv1103b_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
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
+	/* Enable the write to the equivalent lower bits */
+	data = ((1 << rmask_bits) - 1) << (bit + 16);
+	data |= (ret << bit);
+	return regmap_write(regmap, reg, data);
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
+static int rv1103b_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
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
+static int rv1103b_set_pull(struct rockchip_pin_bank *bank,
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
+	ret = rv1103b_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
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
+		return ret;
+	}
+
+	/* Enable the write to the equivalent lower bits */
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
+static int rv1103b_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
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
+static int rv1103b_set_schmitt(struct rockchip_pin_bank *bank,
+			      int pin_num, int enable)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data;
+	u8 bit;
+
+	ret = rv1103b_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
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
+	return regmap_write(regmap, reg, data);
+}
+
+static struct rockchip_mux_recalced_data rv1103b_mux_recalced_data[] = {
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
+static struct rockchip_pin_bank rv1103b_pin_banks[] = {
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
+static const struct rockchip_pin_ctrl rv1103b_pin_ctrl = {
+	.pin_banks		= rv1103b_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rv1103b_pin_banks),
+	.iomux_recalced		= rv1103b_mux_recalced_data,
+	.niomux_recalced	= ARRAY_SIZE(rv1103b_mux_recalced_data),
+	.set_mux		= rv1103b_set_mux,
+	.set_pull		= rv1103b_set_pull,
+	.set_drive		= rv1103b_set_drive,
+	.set_schmitt		= rv1103b_set_schmitt,
+};
+
+static const struct udevice_id rv1103b_pinctrl_ids[] = {
+	{
+		.compatible = "rockchip,rv1103b-pinctrl",
+		.data = (ulong)&rv1103b_pin_ctrl
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_rv1103b) = {
+	.name		= "rockchip_rv1103b_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= rv1103b_pinctrl_ids,
+	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
+	.ops		= &rockchip_pinctrl_ops,
+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
+	.bind		= dm_scan_fdt_dev,
+#endif
+	.probe		= rockchip_pinctrl_probe,
+};
-- 
2.34.1

