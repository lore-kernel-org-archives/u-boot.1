Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C77C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE00781FF5;
	Fri, 14 Mar 2025 20:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZUH6Ojw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB3B81F5D; Fri, 14 Mar 2025 20:00:22 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F70981F5D
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso575835e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978820; x=1742583620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XjKZJBz8UtPbgoK4eC92nbSMjZ0bvXfS43W1gDdmwqU=;
 b=PZUH6OjwnV4UdTCvge6uRUlxEZUePHiTZHVoi3GXzxGFaiZ/AOj56SKvzvOXifONB0
 C9Kq79yAQNIPYa5WtqC9gqtQxEfIMWwUe394tSiNKagL7uowj2d3t4sIKbKIvc+I+jRP
 gFaUsFp95eoqLiMaU+IWQDF+bWTrjIlWE78IxzydMobwHsGbLvqqpAscZAcngnigzUHJ
 AEmKhsivrCRKLlk2+N30zHEB160BzXUJQThGn/UH6mQjmRXtqyGMcPygAsQV1pxZOA04
 BMXHXa1sWQW5GH/eHsAGZBleRs/sxtwhqMinSsc5Eegv4PSgskYUmQpXAcodBTnZ2tZO
 5l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978820; x=1742583620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjKZJBz8UtPbgoK4eC92nbSMjZ0bvXfS43W1gDdmwqU=;
 b=iN0JW7u1hRCgTCZtJAc62KEwUzPsogkhqhb42Zos8MJaZktBj8a52Ki/R47gY9gtOi
 Mea8WUnM2OpFmSnTXG7b7g+snn3bZ0Hi5zlzOSMV3r5a3LHRyDBC2HtVgayCRSKRLyZm
 wJ38D68LyLSQQsvvV+Eh7aQgTym93A1F4V5dYEnNKfu2HnpAaS3VU8ZN6OKBDANpJS2L
 5uUa0WnKCADptvtbD1zKbPzA3dowF77v+ySgDZVy0nDHAZXBCbWPcgdjfNeujaPEwzmC
 egD4r2Fp8yQtki9TVm1wC0jfRmnuHKbtUAs35f8JkniDe3nUdYnnws7ux9QHeXHPtm9v
 UHHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsa87RF85tjQhujjIgxpjk2ymxxf5fZ4dlnjqw1HdHReWT3L5C22cT6VXTi8MJO83NCanM9+U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/9hhNjMgIDSct/QrOcoW2VvU3Yy1G1Uz7GdIVKeTlLxTsb/Rn
 fuJgoGihpp30naK75M+NJBXOFWddYN+deHKwUWLCXjeErHY0ioYq
X-Gm-Gg: ASbGncsvKPDhHi31y6WRkZPnsOY+DhDzOJ607gvyBAJruLY+Tt5ZFQcp8Mmt1JUYppR
 jpqAVzckhKw+2dDJyPlTDWEMD3dKXOlIOngSlVz3CMTKbOBw5BYZ+uOEu/dGqoRe+57AxkIIgqP
 GCNwAIsP7zgb8rZLztqedoHshWcuBEFEq0mKFIZZOOU7HmBuGqhZ+htwtT7RM1zyonoPQx6P1xZ
 NB0Q9eyFicmlMF5OafqBtuzXA3ADsbY0S7WcuZ86xBGMfdkr7SWQxhD1p/bD6abMeFAqsap6Gas
 nc7DQ2WZ8bCcFmxrK/jKDTNfDYXNPt9YfCs+bG7pLtRO/4K2DmHemQJy/htaq14w1PR3ckSvCQi
 KtO1VXI3T/gSMrA==
X-Google-Smtp-Source: AGHT+IEm/1rfReyATNjTfz7+TG5x230p+6F3PyL+/XziWxEbAxz9xlvAsjYHiiMHqfGhHjPlghHeTg==
X-Received: by 2002:a05:600c:4fd4:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43d1ec8e682mr47922165e9.18.1741978819739; 
 Fri, 14 Mar 2025 12:00:19 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 3/6] reset: airoha: Add driver for controlling reset line
 of AN7581
Date: Fri, 14 Mar 2025 19:59:23 +0100
Message-ID: <20250314185941.27834-4-ansuelsmth@gmail.com>
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

Add driver for controlling the reset lines of AN7581. This is a detached
version of the clock controller driver present in Linux only used to
control reset lines. Driver gets loaded with the bind of the clock
driver and doesn't require a compatible. This is needed as they share
the same registers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/airoha/clk-airoha.c |  16 +++
 drivers/reset/Kconfig           |   7 ++
 drivers/reset/Makefile          |   1 +
 drivers/reset/reset-airoha.c    | 173 ++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/reset/reset-airoha.c

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 96d120feba7..1b2c4c98de5 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -416,6 +416,21 @@ static int airoha_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int airoha_clk_bind(struct udevice *dev)
+{
+	struct udevice *rst_dev;
+	int ret = 0;
+
+	if (CONFIG_IS_ENABLED(RESET_AIROHA)) {
+		ret = device_bind_driver_to_node(dev, "airoha-reset", "reset",
+						 dev_ofnode(dev), &rst_dev);
+		if (ret)
+			debug("Warning: failed to bind reset controller\n");
+	}
+
+	return ret;
+}
+
 static const struct airoha_clk_soc_data en7581_data = {
 	.num_clocks = ARRAY_SIZE(en7581_base_clks),
 	.descs = en7581_base_clks,
@@ -433,6 +448,7 @@ U_BOOT_DRIVER(airoha_clk) = {
 	.id = UCLASS_CLK,
 	.of_match = airoha_clk_ids,
 	.probe = airoha_clk_probe,
+	.bind = airoha_clk_bind,
 	.priv_auto = sizeof(struct airoha_clk_priv),
 	.ops = &airoha_clk_ops,
 };
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index fe5c1214f57..ee923c19f41 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -49,6 +49,13 @@ config TEGRA186_RESET
 	  Enable support for manipulating Tegra's on-SoC reset signals via IPC
 	  requests to the BPMP (Boot and Power Management Processor).
 
+config RESET_AIROHA
+	bool "Reset controller driver for Airoha SoCs"
+	depends on DM_RESET && ARCH_AIROHA
+	default y
+	help
+	  Support for reset controller on Airoha SoCs.
+
 config RESET_TI_SCI
 	bool "TI System Control Interface (TI SCI) reset driver"
 	depends on DM_RESET && TI_SCI_PROTOCOL
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index d99a78c9828..524fc064417 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_STI_RESET) += sti-reset.o
 obj-$(CONFIG_STM32_RESET) += stm32-reset.o
 obj-$(CONFIG_TEGRA_CAR_RESET) += tegra-car-reset.o
 obj-$(CONFIG_TEGRA186_RESET) += tegra186-reset.o
+obj-$(CONFIG_RESET_AIROHA) += reset-airoha.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
new file mode 100644
index 00000000000..e878af6167c
--- /dev/null
+++ b/drivers/reset/reset-airoha.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Based on Linux drivers/clk/clk-en7523.c reworked
+ * and detached to a dedicated driver
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org> (original driver)
+ *	   Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <dm.h>
+#include <linux/io.h>
+#include <reset-uclass.h>
+
+#include <dt-bindings/reset/airoha,en7581-reset.h>
+
+#define RST_NR_PER_BANK			32
+
+#define REG_RESET_CONTROL2		0x830
+#define REG_RESET_CONTROL1		0x834
+
+struct airoha_reset_priv {
+	const u16 *bank_ofs;
+	const u16 *idx_map;
+	void __iomem *base;
+};
+
+static const u16 en7581_rst_ofs[] = {
+	REG_RESET_CONTROL2,
+	REG_RESET_CONTROL1,
+};
+
+static const u16 en7581_rst_map[] = {
+	/* RST_CTRL2 */
+	[EN7581_XPON_PHY_RST]		= 0,
+	[EN7581_CPU_TIMER2_RST]		= 2,
+	[EN7581_HSUART_RST]		= 3,
+	[EN7581_UART4_RST]		= 4,
+	[EN7581_UART5_RST]		= 5,
+	[EN7581_I2C2_RST]		= 6,
+	[EN7581_XSI_MAC_RST]		= 7,
+	[EN7581_XSI_PHY_RST]		= 8,
+	[EN7581_NPU_RST]		= 9,
+	[EN7581_I2S_RST]		= 10,
+	[EN7581_TRNG_RST]		= 11,
+	[EN7581_TRNG_MSTART_RST]	= 12,
+	[EN7581_DUAL_HSI0_RST]		= 13,
+	[EN7581_DUAL_HSI1_RST]		= 14,
+	[EN7581_HSI_RST]		= 15,
+	[EN7581_DUAL_HSI0_MAC_RST]	= 16,
+	[EN7581_DUAL_HSI1_MAC_RST]	= 17,
+	[EN7581_HSI_MAC_RST]		= 18,
+	[EN7581_WDMA_RST]		= 19,
+	[EN7581_WOE0_RST]		= 20,
+	[EN7581_WOE1_RST]		= 21,
+	[EN7581_HSDMA_RST]		= 22,
+	[EN7581_TDMA_RST]		= 24,
+	[EN7581_EMMC_RST]		= 25,
+	[EN7581_SOE_RST]		= 26,
+	[EN7581_PCIE2_RST]		= 27,
+	[EN7581_XFP_MAC_RST]		= 28,
+	[EN7581_USB_HOST_P1_RST]	= 29,
+	[EN7581_USB_HOST_P1_U3_PHY_RST]	= 30,
+	/* RST_CTRL1 */
+	[EN7581_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[EN7581_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[EN7581_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[EN7581_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[EN7581_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[EN7581_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[EN7581_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[EN7581_UART_RST]		= RST_NR_PER_BANK + 12,
+	[EN7581_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[EN7581_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[EN7581_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[EN7581_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[EN7581_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[EN7581_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[EN7581_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[EN7581_FE_RST]			= RST_NR_PER_BANK + 21,
+	[EN7581_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[EN7581_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[EN7581_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[EN7581_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[EN7581_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[EN7581_CPU_TIMER_RST]		= RST_NR_PER_BANK + 28,
+	[EN7581_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
+static int airoha_reset_update(struct airoha_reset_priv *priv,
+			       unsigned long id, bool assert)
+{
+	void __iomem *addr = priv->base + priv->bank_ofs[id / RST_NR_PER_BANK];
+	u32 val;
+
+	val = readl(addr);
+	if (assert)
+		val |= BIT(id % RST_NR_PER_BANK);
+	else
+		val &= ~BIT(id % RST_NR_PER_BANK);
+	writel(val, addr);
+
+	return 0;
+}
+
+static int airoha_reset_assert(struct reset_ctl *reset_ctl)
+{
+	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+	int id = reset_ctl->id;
+
+	return airoha_reset_update(priv, id, true);
+}
+
+static int airoha_reset_deassert(struct reset_ctl *reset_ctl)
+{
+	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+	int id = reset_ctl->id;
+
+	return airoha_reset_update(priv, id, false);
+}
+
+static int airoha_reset_status(struct reset_ctl *reset_ctl)
+{
+	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+	int id = reset_ctl->id;
+	void __iomem *addr;
+
+	addr = priv->base + priv->bank_ofs[id / RST_NR_PER_BANK];
+
+	return !!(readl(addr) & BIT(id % RST_NR_PER_BANK));
+}
+
+static int airoha_reset_xlate(struct reset_ctl *reset_ctl,
+			      struct ofnode_phandle_args *args)
+{
+	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+
+	if (args->args[0] >= ARRAY_SIZE(en7581_rst_map))
+		return -EINVAL;
+
+	reset_ctl->id = priv->idx_map[args->args[0]];
+
+	return 0;
+}
+
+static struct reset_ops airoha_reset_ops = {
+	.of_xlate = airoha_reset_xlate,
+	.rst_assert = airoha_reset_assert,
+	.rst_deassert = airoha_reset_deassert,
+	.rst_status = airoha_reset_status,
+};
+
+static int airoha_reset_probe(struct udevice *dev)
+{
+	struct airoha_reset_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -ENOMEM;
+
+	priv->bank_ofs = en7581_rst_ofs;
+	priv->idx_map = en7581_rst_map;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(airoha_reset) = {
+	.name = "airoha-reset",
+	.id = UCLASS_RESET,
+	.probe = airoha_reset_probe,
+	.ops = &airoha_reset_ops,
+	.priv_auto = sizeof(struct airoha_reset_priv),
+};
-- 
2.48.1

