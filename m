Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8ADC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE1184A0B;
	Tue,  7 Jul 2026 17:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WhAzfH8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849A484A27; Tue,  7 Jul 2026 17:32:31 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195FD8497A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb3865ea6fso3255083a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438348; x=1784043148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t21EZV0VOIJY2OstbTSgCqn6WAyxC1AkmRr4L05N5g=;
 b=WhAzfH8ziPwuy2yFW28MtZi9mWOheC7MmsE7xoKIFA6+6U/TcUDO1kpAlr2hnz1O4q
 6aBb/ZLVgCJBY3WWmbXW7sjR/q9v46p8086WlE7sWIa1HV2Bf4VNfYETlgfheixKpQpX
 /83ARYmMUSwPRqOW9+NL8+GZL/URsZ+OJixSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438348; x=1784043148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6t21EZV0VOIJY2OstbTSgCqn6WAyxC1AkmRr4L05N5g=;
 b=W3SrEwFS1T02uWIEsv0PyP9Yq2+vySN9G/38T8v4cSW8GXW9B6Z/AllQJ64lBfseJj
 Mi60x3gNZM5ki4epxOieTyM9qurOJx7o7cqjbuLjtmTdvLZmWvc/dcgbzZz/o+Up/RNa
 0740QCUVIRIokt4mSWwNbeElEemKonEhPHXQqsFlh1O5/XpkVviQ/EwHoeA3x44UMd8O
 8XrxTH1O4WwBY4UD4Y7FGaAkiJw2IGJ8uRBicu5HFbX3ochwcy65k5Cy+Bh2cPnQDqNT
 3jJdJSFMmkT/8QN/kvnh2FdxaAYuq2kYdX4Vw+xmRalW70yzF4IQxMvu3m3QFKiPy7mX
 O7dA==
X-Gm-Message-State: AOJu0YxrfhbRun/cAoLluaz4JcNUKJniRqJ2PLh2cMlagaU+TOcwOCxS
 P06JNy4YesE6nDOWsCvVKeRLduNd4GD/Id6l9jxfgYevtG/W7wwKwpd74VBptp04iMSq/wpOXQv
 g3nlJZg==
X-Gm-Gg: AfdE7cm+aqbMkGVFXOUJdYOoOBxmwl4diuZ04jmlFegSAsUjvq/MZ7p0HIMut1DcSXL
 wwjUqZb14oMERty3ppBEqkIU4uAZs7x5u3Ci9bgZ8JPCrkf8aAF3d4HK6bLXS/YoJytFjjky3mp
 pMOKeSUZDHPi/FEWw8wDMhYAcdlLyDv7GxJzviVGmRW2JZiTYxMdXxqla6cKA94uSTyibZttI6a
 E1yuwsVIxq0qqXis9d3PY6q06K16EIJQChK5WC4tCOcMHOwx2jelHgpOfQYr4eez0t7E++lmYrf
 7yRWDK61MBLmcFPB7ocIlNGrasMTbYqVo/x/SLVYMTKhQRH4KM9BTevClzM00URWqA1ktl853TP
 iR6bj/v4jlT+zrKhmDrBww2fdbCHJyL56qNyH2r8nTWcJ4bVH6E2CwlSbFtPv3NR5nkQdRC2PlH
 pG1NZRb1s=
X-Received: by 2002:a05:6808:c3e9:b0:486:503a:ce99 with SMTP id
 5614622812f47-49fddad584dmr3958979b6e.27.1783438347740; 
 Tue, 07 Jul 2026 08:32:27 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Ye Zhang <ye.zhang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 02/15] pinctrl: rockchip: Add RV1103B support
Date: Tue,  7 Jul 2026 09:31:00 -0600
Message-ID: <20260707153135.2048115-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

Add the pinctrl driver for the RV1103B.

Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use regmap_update_bits() in all the remaining places (Jonas)
- Align continuation lines with the open parenthesis (checkpatch)

Changes in v2:
- Use the original author from Rockchip's vendor U-Boot tree
- Use regmap_update_bits()
- Remove unneeded blank lines
- Remove unneeded logging functions

 drivers/pinctrl/rockchip/Makefile          |   1 +
 drivers/pinctrl/rockchip/pinctrl-rv1103b.c | 402 +++++++++++++++++++++
 2 files changed, 403 insertions(+)
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103b.c

diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
index 0405df128df..b7ce6402ea3 100644
--- a/drivers/pinctrl/rockchip/Makefile
+++ b/drivers/pinctrl/rockchip/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += pinctrl-rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
+obj-$(CONFIG_ROCKCHIP_RV1103B) += pinctrl-rv1103b.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1103b.c b/drivers/pinctrl/rockchip/pinctrl-rv1103b.c
new file mode 100644
index 00000000000..4bd74312c8c
--- /dev/null
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1103b.c
@@ -0,0 +1,402 @@
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
+			     int pin_num, int strength)
+{
+	struct regmap *regmap;
+	int reg, ret, i;
+	u32 data, rmask;
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
+	rmask = data | (data >> 16);
+	data |= (ret << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
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
+					 int pin_num, struct regmap **regmap,
+					 int *reg, u8 *bit)
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
+			    int pin_num, int pull)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u8 bit, type;
+	u32 data, rmask;
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
+	rmask = data | (data >> 16);
+	data |= (ret << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
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
+					    int pin_num,
+					    struct regmap **regmap,
+					    int *reg, u8 *bit)
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
+			       int pin_num, int enable)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data, rmask, mask;
+	u8 bit;
+
+	ret = rv1103b_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	mask = (1 << RV1103_SMT_BITS_PER_PIN) - 1;
+	if (bank->bank_num == 2 && pin_num >= 12) {
+		mask = 0x3;
+		enable = enable ? 0x3 : 0;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = mask << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (enable << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
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
2.43.0

