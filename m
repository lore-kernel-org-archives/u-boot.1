Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAE7C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC6484AE9;
	Tue,  7 Jul 2026 17:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YWmuHEtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F45849F6; Tue,  7 Jul 2026 17:32:58 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E0784AF2
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43bf9548df4so2538568fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438375; x=1784043175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1v5a/NxTp4iQRpAgEnOuVz6BQ4N31bXBp+SLMfpQdc8=;
 b=YWmuHEtOk64aKJakatQKLA6WJKFDdCeUH4boTEpSfH8L1czVa7+5frh+gG5O8JIwe2
 6gj4zi0Lo82XvMqwXwsE2q57dnCxs4JDaok7PQX2bb13WRPof+IQOkfBWRVWkE80YsaT
 ZMjQjZNejJipYyjCKUvmO/UQsQfKdAJz5Sj+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438375; x=1784043175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1v5a/NxTp4iQRpAgEnOuVz6BQ4N31bXBp+SLMfpQdc8=;
 b=h7A6H0naN2pxb2x7E/j8LrSiFTfvAyYNZhlE3JF70zmnK+zWjlt5iPngXJAcSQIDII
 3TOmkmni0Ruyytm3by19xtYh2bSx/F6Ea7D2OTRn8n/7+QSC+NMEh3jhMct03dbJrzbW
 uT0oXG0dWYTs1SViTOLoouLexJPrHjXgEJ0ikiuXLSJ3zFHXcGEkmWhxZwvJmqkybi6a
 6v4Ihi1qFSnLKa2MF4mLNE1axzSMY8DEytqcuh+nTbnTOKD3K5Sy1NMGsUg8MXYlZ5Mn
 ryl1Y+bg6pcrw9pdVhwX2Cl/7Qeq4hgPG3CK1Nn7TGCAbf6np1EtlPX48zznl1owLqaO
 xOHQ==
X-Gm-Message-State: AOJu0YzcaKDUeYbZ/goKJsB85wPPh9UfixXkxf9EEnmSCVeNerBfeRNa
 kz9vPBa/QhhzyRfYVohELVuAk03RO+coqm3Fwv0dVxWUCtyGMTlTyTmnNt5u9yfzd6jz+IPYg6p
 SBejohw==
X-Gm-Gg: AfdE7clihjI7YdfPLvnLcVnuehOJisrhDbxy9rrpANSqbVQxItjnAuMlRo1F1dvN4Wm
 MmYy3PrAMJDVAtLNAp+fNi7W16+a1SmYqCj2IYpRdrm0cDfEvZZ6fTFMX+d0FwQZKmDswmHEbYG
 rVsYGCx38yoKoUndpbB+jU7Cp8S6OddxYaOyXflExNxq6k8VMtEq+PW/sf5K9Ne13yQnwsA12lj
 8vWtygs7xK/qmAv/vL4/zRN8tmWxTYnfSKn62ak83Xs1zgEsMqhuj4y/j1r7lDdXONeNTsbkM1e
 WVhc61KgGveRLygoRhb54QjKO0JsjHDRpRBbORvGBXzYdYTTX3D/9VkW+qmkuRnPMwt6svDbabF
 ef1wtlxEHNuLKEz+KMHtDTXxgTdh8cHmW4BxGit4jOqPJPhq4qr9opPQBkqpd0J4/HH2/3pAxT9
 2D6L+Ou4I=
X-Received: by 2002:a05:6808:3c4d:b0:497:d512:db10 with SMTP id
 5614622812f47-49fdea08843mr4432630b6e.33.1783438374678; 
 Tue, 07 Jul 2026 08:32:54 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Ye Zhang <ye.zhang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 10/15] pinctrl: rockchip: Add RV1106 support
Date: Tue,  7 Jul 2026 09:31:08 -0600
Message-ID: <20260707153135.2048115-11-sjg@chromium.org>
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

Add the pinctrl driver for the RV1106, based on the driver in the
Rockchip vendor tree, converted to use regmap_update_bits() so that
the pin configuration in the devicetree cannot overflow the register
fields.

The RV1103 is a package variant of the RV1106 and shares this driver.
Unlike most Rockchip SoCs, the GPIO0 IOC block lives in the PMU, so
the driver selects the PMU regmap for bank 0

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/pinctrl/rockchip/Makefile         |   1 +
 drivers/pinctrl/rockchip/pinctrl-rv1106.c | 320 ++++++++++++++++++++++
 2 files changed, 321 insertions(+)
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1106.c

diff --git a/drivers/pinctrl/rockchip/Makefile b/drivers/pinctrl/rockchip/Makefile
index b7ce6402ea3..6d7a2548af5 100644
--- a/drivers/pinctrl/rockchip/Makefile
+++ b/drivers/pinctrl/rockchip/Makefile
@@ -20,5 +20,6 @@ obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += pinctrl-rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += pinctrl-rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1103B) += pinctrl-rv1103b.o
+obj-$(CONFIG_ROCKCHIP_RV1106) += pinctrl-rv1106.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += pinctrl-rv1126.o
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1106.c b/drivers/pinctrl/rockchip/pinctrl-rv1106.c
new file mode 100644
index 00000000000..5c3ad3ed09d
--- /dev/null
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1106.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2022 Rockchip Electronics Co., Ltd
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
+static int rv1106_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+	int iomux_num = (pin / 8);
+	struct regmap *regmap;
+	u32 data, rmask;
+	int reg, mask;
+	u8 bit;
+
+	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
+		regmap = priv->regmap_pmu;
+	else
+		regmap = priv->regmap_base;
+
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
+#define RV1106_DRV_BITS_PER_PIN		8
+#define RV1106_DRV_PINS_PER_REG		2
+#define RV1106_DRV_GPIO0_OFFSET		0x10
+#define RV1106_DRV_GPIO1_OFFSET		0x80
+#define RV1106_DRV_GPIO2_OFFSET		0x100c0
+#define RV1106_DRV_GPIO3_OFFSET		0x20100
+#define RV1106_DRV_GPIO4_OFFSET		0x30020
+
+static int rv1106_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				       int pin_num, struct regmap **regmap,
+				       int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+
+	/* GPIO0_IOC is located in the PMU */
+	switch (bank->bank_num) {
+	case 0:
+		*regmap = priv->regmap_pmu;
+		*reg = RV1106_DRV_GPIO0_OFFSET;
+		break;
+	case 1:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_DRV_GPIO1_OFFSET;
+		break;
+	case 2:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_DRV_GPIO2_OFFSET;
+		break;
+	case 3:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_DRV_GPIO3_OFFSET;
+		break;
+	case 4:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_DRV_GPIO4_OFFSET;
+		break;
+	default:
+		printf("unsupported bank_num %d\n", bank->bank_num);
+		return -EINVAL;
+	}
+
+	*reg += ((pin_num / RV1106_DRV_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1106_DRV_PINS_PER_REG;
+	*bit *= RV1106_DRV_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rv1106_set_drive(struct rockchip_pin_bank *bank,
+			    int pin_num, int strength)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data, rmask;
+	u8 bit;
+	int drv = (1 << (strength + 1)) - 1;
+
+	ret = rv1106_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RV1106_DRV_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (drv << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RV1106_PULL_BITS_PER_PIN	2
+#define RV1106_PULL_PINS_PER_REG	8
+#define RV1106_PULL_GPIO0_OFFSET	0x38
+#define RV1106_PULL_GPIO1_OFFSET	0x1c0
+#define RV1106_PULL_GPIO2_OFFSET	0x101d0
+#define RV1106_PULL_GPIO3_OFFSET	0x201e0
+#define RV1106_PULL_GPIO4_OFFSET	0x30070
+
+static int rv1106_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+					int pin_num, struct regmap **regmap,
+					int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+
+	/* GPIO0_IOC is located in the PMU */
+	switch (bank->bank_num) {
+	case 0:
+		*regmap = priv->regmap_pmu;
+		*reg = RV1106_PULL_GPIO0_OFFSET;
+		break;
+	case 1:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_PULL_GPIO1_OFFSET;
+		break;
+	case 2:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_PULL_GPIO2_OFFSET;
+		break;
+	case 3:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_PULL_GPIO3_OFFSET;
+		break;
+	case 4:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_PULL_GPIO4_OFFSET;
+		break;
+	default:
+		printf("unsupported bank_num %d\n", bank->bank_num);
+		return -EINVAL;
+	}
+
+	*reg += ((pin_num / RV1106_PULL_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1106_PULL_PINS_PER_REG;
+	*bit *= RV1106_PULL_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rv1106_set_pull(struct rockchip_pin_bank *bank,
+			   int pin_num, int pull)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u8 bit, type;
+	u32 data, rmask;
+
+	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
+		return -ENOTSUPP;
+
+	ret = rv1106_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	if (ret)
+		return ret;
+
+	type = bank->pull_type[pin_num / 8];
+	ret = rockchip_translate_pull_value(type, pull);
+	if (ret < 0) {
+		debug("unsupported pull setting %d\n", pull);
+		return ret;
+	}
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RV1106_PULL_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (ret << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+#define RV1106_SMT_BITS_PER_PIN		1
+#define RV1106_SMT_PINS_PER_REG		8
+#define RV1106_SMT_GPIO0_OFFSET		0x40
+#define RV1106_SMT_GPIO1_OFFSET		0x280
+#define RV1106_SMT_GPIO2_OFFSET		0x10290
+#define RV1106_SMT_GPIO3_OFFSET		0x202a0
+#define RV1106_SMT_GPIO4_OFFSET		0x300a0
+
+static int rv1106_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					   int pin_num,
+					   struct regmap **regmap,
+					   int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl_priv *priv = bank->priv;
+
+	/* GPIO0_IOC is located in the PMU */
+	switch (bank->bank_num) {
+	case 0:
+		*regmap = priv->regmap_pmu;
+		*reg = RV1106_SMT_GPIO0_OFFSET;
+		break;
+	case 1:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_SMT_GPIO1_OFFSET;
+		break;
+	case 2:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_SMT_GPIO2_OFFSET;
+		break;
+	case 3:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_SMT_GPIO3_OFFSET;
+		break;
+	case 4:
+		*regmap = priv->regmap_base;
+		*reg = RV1106_SMT_GPIO4_OFFSET;
+		break;
+	default:
+		printf("unsupported bank_num %d\n", bank->bank_num);
+		return -EINVAL;
+	}
+
+	*reg += ((pin_num / RV1106_SMT_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1106_SMT_PINS_PER_REG;
+	*bit *= RV1106_SMT_BITS_PER_PIN;
+
+	return 0;
+}
+
+static int rv1106_set_schmitt(struct rockchip_pin_bank *bank,
+			      int pin_num, int enable)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data, rmask;
+	u8 bit;
+
+	ret = rv1106_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg,
+					      &bit);
+	if (ret)
+		return ret;
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RV1106_SMT_BITS_PER_PIN) - 1) << (bit + 16);
+	rmask = data | (data >> 16);
+	data |= (enable << bit);
+
+	return regmap_update_bits(regmap, reg, rmask, data);
+}
+
+static struct rockchip_pin_bank rv1106_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0",
+			     IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
+			     IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
+			     IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
+			     IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0, 0x08, 0x10, 0x18),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(2, 32, "gpio2",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x10020, 0x10028, 0, 0),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(3, 32, "gpio3",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0x20040, 0x20048, 0x20050, 0x20058),
+	PIN_BANK_IOMUX_FLAGS_OFFSET(4, 24, "gpio4",
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    0,
+				    0x30000, 0x30008, 0x30010, 0),
+};
+
+static const struct rockchip_pin_ctrl rv1106_pin_ctrl = {
+	.pin_banks		= rv1106_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rv1106_pin_banks),
+	.grf_mux_offset		= 0x0,
+	.pmu_mux_offset		= 0x0,
+	.set_mux		= rv1106_set_mux,
+	.set_pull		= rv1106_set_pull,
+	.set_drive		= rv1106_set_drive,
+	.set_schmitt		= rv1106_set_schmitt,
+};
+
+static const struct udevice_id rv1106_pinctrl_ids[] = {
+	{
+		.compatible = "rockchip,rv1106-pinctrl",
+		.data = (ulong)&rv1106_pin_ctrl
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_rv1106) = {
+	.name		= "rockchip_rv1106_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= rv1106_pinctrl_ids,
+	.priv_auto	= sizeof(struct rockchip_pinctrl_priv),
+	.ops		= &rockchip_pinctrl_ops,
+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
+	.bind		= dm_scan_fdt_dev,
+#endif
+	.probe		= rockchip_pinctrl_probe,
+};
-- 
2.43.0

