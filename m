Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2D9C28B2F
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 14:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFAE812C8;
	Sun,  9 Mar 2025 15:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e6eH4VuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA3A81101; Sun,  9 Mar 2025 15:07:27 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A868801DE
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 15:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so2566178f8f.3
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741529245; x=1742134045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GeLaq9v6L8I39PqvhO5lKb/ufurt4+YiBi41MSuRhhE=;
 b=e6eH4VuRSdNxFE9611iC5abxs86HnmbZTkLatZAHzVuqQwD36ADa0MEeSmk/5Y2qVU
 UoHOFwj2DmiR7kjzLuUWO5jioxeoYurF22sCo3Zcj63jIXT3GKQqDnH+NA0kTM/ApATM
 088lncx5Z269d6kScyvgijby9ZiVYrHnvjaWt8ugshaPysFELz/D0f4w5UjP7ygr2JLd
 0DAer8ONCcyKr+Bz460X4JmrmnrGDqs43QqybPu5ydqetGrUlYnqCfAvabWaXkhQ8O5i
 h2jlbJdaYHI3tkjqKYQphR3oYMxMjHsmNv6awGR7fiqgp0gTRAB5iBrjwZFeuTd7lBt9
 ZSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741529245; x=1742134045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeLaq9v6L8I39PqvhO5lKb/ufurt4+YiBi41MSuRhhE=;
 b=KsUqonmufcEbtUQ1vA2P/TzlyBJtjvqA4qvOGpM1BMGVK/EQhBOdTRKHiMGHlcCGa8
 ugMR2G9RO84FSbzSf8Sy/Z16UxRN7MZo/Dlupx3UnZscYU5KSBHU6BQy7jCxsJl7sVAe
 5sXBykIrlVwyhj44mlRwbZ7OUxsQiiRpr1Fio3Ehcv5K4zq63juWlgCz6NGROtXiEHVO
 fPMflS3wBifYBpExjuLUC1zDcTcWy8Ct5srwNMwiFW/F89Z0IgZjUwneYgUTqoyeYaQr
 z1333uFjg3nmBrlq2ymibKyrOXkoDfD1LDapsNNcU0fH8qFDqYiPjHm6JEkyqH29+CYb
 vTeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBHGvI70y3xKzikaLs8WCXFv+btFHWGw96p26vIZdV6MpYSvHtS8x9XeMs0xxI6ay9EwlOg2w=@lists.denx.de
X-Gm-Message-State: AOJu0YwzxyXGGT2Y6EsTTK4w3/axvMdgY7wp0Q1NQxaeUCVMlqWIoK1u
 5vHjsc38zkSQbvFtf0n3+Qs+wXEReH9jFgjkmXZKjq3r9jEslWef
X-Gm-Gg: ASbGncvj1AZSMoRktM6NeTpm4JNAFRw4p8mCRih0KWwyIMX7gonFOMUyDool1TMTHTb
 VFI9zl7GkUCSUdbS8Wr7q+TAh+KqiCXL46AfsF48cesifur69mQXL4z7xQOCT5lpSujBMTM7E04
 0kHSmdwPhSLzU28/XKeaJ7XCI7aiM/Et0LX6+NH6Frh0TQBOJkIQPQtYmcR7L/dwDUKHJk70Ot1
 Qd1SratsJvpjOUb5GcuP4zhc0MQ4LyLB3wrGu4YTZHYY9bmZ+/gsJj2MOk5WsuIWE60mQHAOSok
 B5Thb6To0ffZiQyVfp/UbiKGkd7viJuc2wlux6egaWM3pFr9Ejb9OTTWilq8b7VTWOLj1FV9vXS
 Xd3AzyWVRZx4XCw==
X-Google-Smtp-Source: AGHT+IGSTiKpH32o1KfqrV2b1kmONKmpNij07kL6NcV4eyZdXp7huQCsJMN2rsdgIsR/LdGOJNx5dg==
X-Received: by 2002:a5d:6d0c:0:b0:390:de33:b0ef with SMTP id
 ffacd0b85a97d-39132d7084emr8437804f8f.30.1741529244398; 
 Sun, 09 Mar 2025 07:07:24 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm11946816f8f.0.2025.03.09.07.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 07:07:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 2/4] clk: airoha: Add support for Airoha AN7581 SoC clock
Date: Sun,  9 Mar 2025 15:06:44 +0100
Message-ID: <20250309140652.23543-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309140652.23543-1-ansuelsmth@gmail.com>
References: <20250309140652.23543-1-ansuelsmth@gmail.com>
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

Add support for Airoha AN7581 SoC clock driver. This mainly needed for
eMMC support to correctly get the current clock applied.

Based on the Linux clk-en7523.c but majorly reworked for U-Boot that
doesn't require CCF subsystem.

Major modification, support for set_rate, realtime get_rate and split
for reset part to a different driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/Makefile                   |   1 +
 drivers/clk/airoha/Makefile            |   3 +
 drivers/clk/airoha/clk-airoha.c        | 438 +++++++++++++++++++++++++
 include/dt-bindings/clock/en7523-clk.h |  17 +
 4 files changed, 459 insertions(+)
 create mode 100644 drivers/clk/airoha/Makefile
 create mode 100644 drivers/clk/airoha/clk-airoha.c
 create mode 100644 include/dt-bindings/clock/en7523-clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index fe0e49f6112..8411205ee04 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 obj-y += adi/
+obj-y += airoha/
 obj-y += analogbits/
 obj-y += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
diff --git a/drivers/clk/airoha/Makefile b/drivers/clk/airoha/Makefile
new file mode 100644
index 00000000000..1744c5f7236
--- /dev/null
+++ b/drivers/clk/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# Core
+obj-$(CONFIG_ARCH_AIROHA) += clk-airoha.o
diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
new file mode 100644
index 00000000000..96d120feba7
--- /dev/null
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Based on the Linux clk-en7523.c but majorly reworked
+ * for U-Boot that doesn't require CCF subsystem.
+ *
+ * Major modification, support for set_rate, realtime
+ * get_rate and split for reset part to a different driver.
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org> (original driver)
+ *	   Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/devres.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <regmap.h>
+#include <syscon.h>
+
+#include <dt-bindings/clock/en7523-clk.h>
+
+#define REG_GSW_CLK_DIV_SEL		0x1b4
+#define REG_EMI_CLK_DIV_SEL		0x1b8
+#define REG_BUS_CLK_DIV_SEL		0x1bc
+#define REG_SPI_CLK_DIV_SEL		0x1c4
+#define REG_SPI_CLK_FREQ_SEL		0x1c8
+#define REG_NPU_CLK_DIV_SEL		0x1fc
+
+#define REG_NP_SCU_PCIC			0x88
+#define REG_NP_SCU_SSTR			0x9c
+#define REG_PCIE_XSI0_SEL_MASK		GENMASK(14, 13)
+#define REG_PCIE_XSI1_SEL_MASK		GENMASK(12, 11)
+#define REG_CRYPTO_CLKSRC2		0x20c
+
+#define EN7581_MAX_CLKS			9
+
+struct airoha_clk_desc {
+	int id;
+	const char *name;
+	u32 base_reg;
+	u8 base_bits;
+	u8 base_shift;
+	union {
+		const unsigned int *base_values;
+		unsigned int base_value;
+	};
+	size_t n_base_values;
+
+	u16 div_reg;
+	u8 div_bits;
+	u8 div_shift;
+	u16 div_val0;
+	u8 div_step;
+	u8 div_offset;
+};
+
+struct airoha_clk_priv {
+	struct regmap *chip_scu_map;
+	struct airoha_clk_soc_data *data;
+};
+
+struct airoha_clk_soc_data {
+	u32 num_clocks;
+	const struct airoha_clk_desc *descs;
+};
+
+static const u32 gsw_base[] = { 400000000, 500000000 };
+static const u32 slic_base[] = { 100000000, 3125000 };
+
+static const u32 emi7581_base[] = { 540000000, 480000000, 400000000, 300000000 };
+static const u32 bus7581_base[] = { 600000000, 540000000 };
+static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
+static const u32 crypto_base[] = { 540000000, 480000000 };
+static const u32 emmc7581_base[] = { 200000000, 150000000 };
+
+static const struct airoha_clk_desc en7581_base_clks[EN7581_MAX_CLKS] = {
+	[EN7523_CLK_GSW] = {
+		.id = EN7523_CLK_GSW,
+		.name = "gsw",
+
+		.base_reg = REG_GSW_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = gsw_base,
+		.n_base_values = ARRAY_SIZE(gsw_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_EMI] = {
+		.id = EN7523_CLK_EMI,
+		.name = "emi",
+
+		.base_reg = REG_EMI_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = emi7581_base,
+		.n_base_values = ARRAY_SIZE(emi7581_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_BUS] = {
+		.id = EN7523_CLK_BUS,
+		.name = "bus",
+
+		.base_reg = REG_BUS_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = bus7581_base,
+		.n_base_values = ARRAY_SIZE(bus7581_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_SLIC] = {
+		.id = EN7523_CLK_SLIC,
+		.name = "slic",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = slic_base,
+		.n_base_values = ARRAY_SIZE(slic_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 24,
+		.div_val0 = 20,
+		.div_step = 2,
+	},
+	[EN7523_CLK_SPI] = {
+		.id = EN7523_CLK_SPI,
+		.name = "spi",
+
+		.base_reg = REG_SPI_CLK_DIV_SEL,
+
+		.base_value = 400000000,
+
+		.div_bits = 5,
+		.div_shift = 8,
+		.div_val0 = 40,
+		.div_step = 2,
+	},
+	[EN7523_CLK_NPU] = {
+		.id = EN7523_CLK_NPU,
+		.name = "npu",
+
+		.base_reg = REG_NPU_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = npu7581_base,
+		.n_base_values = ARRAY_SIZE(npu7581_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_CRYPTO] = {
+		.id = EN7523_CLK_CRYPTO,
+		.name = "crypto",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = crypto_base,
+		.n_base_values = ARRAY_SIZE(crypto_base),
+	},
+	[EN7581_CLK_EMMC] = {
+		.id = EN7581_CLK_EMMC,
+		.name = "emmc",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 12,
+		.base_values = emmc7581_base,
+		.n_base_values = ARRAY_SIZE(emmc7581_base),
+	}
+};
+
+static u32 airoha_clk_get_base_rate(const struct airoha_clk_desc *desc, u32 val)
+{
+	if (!desc->base_bits)
+		return desc->base_value;
+
+	val >>= desc->base_shift;
+	val &= (1 << desc->base_bits) - 1;
+
+	if (val >= desc->n_base_values)
+		return 0;
+
+	return desc->base_values[val];
+}
+
+static u32 airoha_clk_get_div(const struct airoha_clk_desc *desc, u32 val)
+{
+	if (!desc->div_bits)
+		return 1;
+
+	val >>= desc->div_shift;
+	val &= (1 << desc->div_bits) - 1;
+
+	if (!val && desc->div_val0)
+		return desc->div_val0;
+
+	return (val + desc->div_offset) * desc->div_step;
+}
+
+static int airoha_clk_enable(struct clk *clk)
+{
+	struct airoha_clk_priv *priv = dev_get_priv(clk->dev);
+	struct airoha_clk_soc_data *data = priv->data;
+	int id = clk->id;
+
+	if (id > data->num_clocks)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int airoha_clk_disable(struct clk *clk)
+{
+	return 0;
+}
+
+static ulong airoha_clk_get_rate(struct clk *clk)
+{
+	struct airoha_clk_priv *priv = dev_get_priv(clk->dev);
+	struct airoha_clk_soc_data *data = priv->data;
+	const struct airoha_clk_desc *desc;
+	struct regmap *map = priv->chip_scu_map;
+	int id = clk->id;
+	u32 reg, val;
+	ulong rate;
+	int ret;
+
+	if (id > data->num_clocks) {
+		dev_err(clk->dev, "Invalid clk ID %d\n", id);
+		return 0;
+	}
+
+	desc = &data->descs[id];
+
+	ret = regmap_read(map, desc->base_reg, &val);
+	if (ret) {
+		dev_err(clk->dev, "Failed to read reg for clock %s\n",
+			desc->name);
+		return 0;
+	}
+
+	rate = airoha_clk_get_base_rate(desc, val);
+
+	reg = desc->div_reg ? desc->div_reg : desc->base_reg;
+	ret = regmap_read(map, reg, &val);
+	if (ret) {
+		dev_err(clk->dev, "Failed to read reg for clock %s\n",
+			desc->name);
+		return 0;
+	}
+
+	rate /= airoha_clk_get_div(desc, val);
+
+	return rate;
+}
+
+static int airoha_clk_search_rate(const struct airoha_clk_desc *desc, int div,
+				  ulong rate)
+{
+	int i;
+
+	/* Single base rate */
+	if (!desc->base_bits) {
+		if (rate != desc->base_value / div)
+			goto err;
+
+		return 0;
+	}
+
+	/* Check every base rate with provided divisor */
+	for (i = 0; i < desc->n_base_values; i++)
+		if (rate == desc->base_values[i] / div)
+			return i;
+
+err:
+	return -EINVAL;
+}
+
+static ulong airoha_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct airoha_clk_priv *priv = dev_get_priv(clk->dev);
+	struct airoha_clk_soc_data *data = priv->data;
+	const struct airoha_clk_desc *desc;
+	struct regmap *map = priv->chip_scu_map;
+	int div_val, base_val;
+	u32 reg, val, mask;
+	int id = clk->id;
+	int div;
+	int ret;
+
+	if (id > data->num_clocks) {
+		dev_err(clk->dev, "Invalid clk ID %d\n", id);
+		return 0;
+	}
+
+	desc = &data->descs[id];
+
+	if (!desc->base_bits && !desc->div_bits) {
+		dev_err(clk->dev, "Can't set rate for fixed clock %s\n",
+			desc->name);
+		return 0;
+	}
+
+	if (!desc->div_bits) {
+		/* Divisor not supported, just search in base rate */
+		div_val = 0;
+		base_val = airoha_clk_search_rate(desc, 1, rate);
+		if (base_val < 0) {
+			dev_err(clk->dev, "Invalid rate for clock %s\n",
+				desc->name);
+			return 0;
+		}
+	} else {
+		div_val = 0;
+
+		/* Check if div0 satisfy the request */
+		if (desc->div_val0) {
+			base_val = airoha_clk_search_rate(desc, desc->div_val0,
+							  rate);
+			if (base_val >= 0) {
+				div_val = 0;
+				goto apply;
+			}
+
+			/* Skip checking first divisor val */
+			div_val = 1;
+		}
+
+		/* Simulate rate with every divisor supported */
+		for (div_val = div_val + desc->div_offset;
+		     div_val < BIT(desc->div_bits) - 1; div_val++) {
+			div = div_val * desc->div_step;
+
+			base_val = airoha_clk_search_rate(desc, div, rate);
+			if (base_val >= 0)
+				break;
+		}
+
+		if (div_val == BIT(desc->div_bits) - 1) {
+			dev_err(clk->dev, "Invalid rate for clock %s\n",
+				desc->name);
+			return 0;
+		}
+	}
+
+apply:
+	if (desc->div_bits) {
+		reg = desc->div_reg ? desc->div_reg : desc->base_reg;
+
+		mask = (BIT(desc->div_bits) - 1) << desc->div_shift;
+		val = div_val << desc->div_shift;
+
+		ret = regmap_update_bits(map, reg, mask, val);
+		if (ret) {
+			dev_err(clk->dev, "Failed to update div reg for clock %s\n",
+				desc->name);
+			return 0;
+		}
+	}
+
+	if (desc->base_bits) {
+		mask = (BIT(desc->base_bits) - 1) << desc->base_shift;
+		val = base_val << desc->base_shift;
+
+		ret = regmap_update_bits(map, desc->base_reg, mask, val);
+		if (ret) {
+			dev_err(clk->dev, "Failed to update reg for clock %s\n",
+				desc->name);
+			return 0;
+		}
+	}
+
+	return rate;
+}
+
+const struct clk_ops airoha_clk_ops = {
+	.enable = airoha_clk_enable,
+	.disable = airoha_clk_disable,
+	.get_rate = airoha_clk_get_rate,
+	.set_rate = airoha_clk_set_rate,
+};
+
+static int airoha_clk_probe(struct udevice *dev)
+{
+	struct airoha_clk_priv *priv = dev_get_priv(dev);
+	ofnode chip_scu_node;
+
+	chip_scu_node = ofnode_by_compatible(ofnode_null(),
+					     "airoha,en7581-chip-scu");
+	if (!ofnode_valid(chip_scu_node))
+		return -EINVAL;
+
+	priv->chip_scu_map = syscon_node_to_regmap(chip_scu_node);
+	if (IS_ERR(priv->chip_scu_map))
+		return PTR_ERR(priv->chip_scu_map);
+
+	priv->data = (void *)dev_get_driver_data(dev);
+
+	return 0;
+}
+
+static const struct airoha_clk_soc_data en7581_data = {
+	.num_clocks = ARRAY_SIZE(en7581_base_clks),
+	.descs = en7581_base_clks,
+};
+
+static const struct udevice_id airoha_clk_ids[] = {
+	{ .compatible = "airoha,en7581-scu",
+	  .data = (ulong)&en7581_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(airoha_clk) = {
+	.name = "clk-airoha",
+	.id = UCLASS_CLK,
+	.of_match = airoha_clk_ids,
+	.probe = airoha_clk_probe,
+	.priv_auto = sizeof(struct airoha_clk_priv),
+	.ops = &airoha_clk_ops,
+};
diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
new file mode 100644
index 00000000000..edfa64045f5
--- /dev/null
+++ b/include/dt-bindings/clock/en7523-clk.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_
+#define _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_
+
+#define EN7523_CLK_GSW		0
+#define EN7523_CLK_EMI		1
+#define EN7523_CLK_BUS		2
+#define EN7523_CLK_SLIC		3
+#define EN7523_CLK_SPI		4
+#define EN7523_CLK_NPU		5
+#define EN7523_CLK_CRYPTO	6
+#define EN7523_CLK_PCIE		7
+
+#define EN7581_CLK_EMMC		8
+
+#endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.48.1

