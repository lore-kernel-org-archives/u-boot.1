Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A39CC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F49B81F7B;
	Fri, 14 Mar 2025 20:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iY8F/kbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B007780F9A; Fri, 14 Mar 2025 20:00:21 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677D580F9A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso427195e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978819; x=1742583619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A5KKhX/RUnWHtYstF0fEdvmlKGZNGHo5qayTshecuHg=;
 b=iY8F/kbK+wIh0loOmGFnoph6ujdAY55mSdc4tBDuc4YgbfiWbuq6fSTMwycLgm0aMG
 9Hewu1SUlcTm0XD3TNChpb+HdEh1980+VzwYMCfMnG8qw0InjGRpTPXduFBcj8QBbyH4
 LexnWyDdMIhfxxxVBc4NEKQraXqAa1Fu5dZO1HW8wmyyr3CQvojcAGaiwBtv8As/j+oF
 0yUZ5pVaXf9T/6Ov7lFhhV1eij1L8EVMI33M63dtm+ciUh2hupFtxZKECyORQEFhusqP
 mW+ApNIClZrVlh7koxmVudjEewPvngf8XeR65G+nR1hg2EQqDS7KGTjkn2rOpfSBw76H
 FpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978819; x=1742583619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5KKhX/RUnWHtYstF0fEdvmlKGZNGHo5qayTshecuHg=;
 b=VTgB6q6BXbM+dh0xod3KjoopUHqhA45q3OKJnev1JSTdSFRfoxk9PWf9jAtmTuQONg
 Gb8LVa8H22vXuCc2fbKg3PJMfVYVPT4/Znt+PJe3y80P1fb6PUGt4vn/y6U29AthICY1
 ZFxl6EFDl9kI8BNcqmnvUDGH/9X/BinqCdlXCxXQW5af0auRZDN3nESYvq9MdP3w6mFJ
 VRcHJKWY6kpgmNZXlbO50G4VRPYk1w/SHdz3QrsxL0Cbdk3fk9ukcQKZaA5hmoOmCcjP
 zmQfUXYE+/zuqieEsRttMHS63YId/XZgo2TSzGpTv6dR5cSLLNLWl7Yyd/OdHcEsMRaL
 eo1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsGEGe6sZXoEcXp+fQ+OIkh3OkvU6zf5O9LCxpofQ+oU5l9a5IVxGOS2+c6hOKOu+bY1VB358=@lists.denx.de
X-Gm-Message-State: AOJu0YyveQVOKc/QBM1JMniCViSjXGONbaO36LAkF7gLP43FGMQfctqE
 /6cYx7IT33KjEegR3j89+aMlGAmdXLHRzwzn0Lz081c3CVjxy/dZ
X-Gm-Gg: ASbGncsoUAEps6YXGtpHlUsFryJLX0269Weo+sBQLX7eK0uWYca8gLffIknhOme40gA
 Litks099Q8kvPsJBWFTNePE7gjfZKDHtnl+juwzQ46IwKJZarCebXmK4NuyUXIpgPDWgNjJ9qh3
 blIHt3ut6++Xs1MoVJrmHGxlrZZN9DBVPGuOnUlBoOfWiR8ymZnN9dVuKjnfOYVWtP2OrbV2sIg
 zKPDBc2Fvz1Y9jZh3eTdiex21tzT0kyGAxgMImXsmJ5KK0xHv9+wbxV+ZW1GvB5FtnC+rvCWxg5
 3/XSICNm7YbjLVwfEE4HMO5WV8Pyw9rMnbRwF2Nq9CsdR1UOSFxKwavjrubWWAl/l25De7rd1s3
 ipt4SsS/BDjJhZQ==
X-Google-Smtp-Source: AGHT+IEixBC26RUsW3GvZY/4UhYjmZrEgR6sLtu/QGxSSdH79a0TpXO5IhUoGWhrjh7DeKLeYnaKFA==
X-Received: by 2002:a05:6000:400f:b0:390:d82d:6d4f with SMTP id
 ffacd0b85a97d-39720d47024mr3723243f8f.52.1741978818553; 
 Fri, 14 Mar 2025 12:00:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/6] clk: airoha: Add support for Airoha AN7581 SoC clock
Date: Fri, 14 Mar 2025 19:59:22 +0100
Message-ID: <20250314185941.27834-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
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
 drivers/clk/Makefile            |   1 +
 drivers/clk/airoha/Makefile     |   3 +
 drivers/clk/airoha/clk-airoha.c | 438 ++++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+)
 create mode 100644 drivers/clk/airoha/Makefile
 create mode 100644 drivers/clk/airoha/clk-airoha.c

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
-- 
2.48.1

