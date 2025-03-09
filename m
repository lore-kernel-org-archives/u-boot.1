Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FBFC28B30
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 14:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328048122F;
	Sun,  9 Mar 2025 15:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q1aQIY49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1468144F; Sun,  9 Mar 2025 15:07:29 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6EB809A4
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 15:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so26714925e9.0
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741529247; x=1742134047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e4NmYMD4gQF/oDvTMwjneqL6Rn7XTSwZirWltQbiJlg=;
 b=Q1aQIY49daDYiSEYf4Qebz7htRASqc7DeQSpYxB6aRTV6UNIuQwm1ML/ybrK/RCj0I
 PbV0jRj890AL35npK4hE4K8I32y6HqC3TEaL2vGTKUyNyE8Wnq1qAQGsOgQPFahxBbtD
 7sjoaG+KVK9MKdBAnoNxLnGKzpiVbvKoFGC4QHNNqpZKaxxM6NzeRGv2M7YG89wxIzzK
 qxB11rE+DMVY1+OLxAvjrhDhXhmYFpXtvgS7hGMWddUOdvrNjcDYDqtO7eulFWwsCyAY
 +5r398wiFPhNHPNR3mFEp/gNfDeT741xQDDQaLgiTxDtrmC+24fz5o28rNLL1tWFhwMa
 9MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741529247; x=1742134047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4NmYMD4gQF/oDvTMwjneqL6Rn7XTSwZirWltQbiJlg=;
 b=m3jJhmNRwA+sewDfN4z5hmCwQsTlr+M4PaiscsoC+1eeTijc4eum05KJDVTYrETjzL
 fiVROkcNZPHi8z2MRWgYiIYSUnHw7sKCdEjQ3OZ/lLQa8ozQ3ICDXfB21/a1zBHgo/n3
 kdYoiqmoMZ2KiqyODkB27iiSn7wK3nMEVADdKRZHSPm4q1Mb6RSk9mI+LhqqZo1FQ5wx
 MXkfHCPMqTBxtUYnyPOKKP0Ynmck2/e2c6y2RFCHo60eIguIbR2NyamQqMK0GaI7pWYQ
 7mq1TOfwUNVSowtiLiJJd53T2fYIXbUituAEc9BILrlyCl/5eR7ODJW6l3ZqlI4qNEuW
 bnog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWicp68pCIR3q7XjWIsFLtlZPhO5y6IB/nMm29+a8H1H3oZjAe/tL8rwAgzK3EfRTh49inVybU=@lists.denx.de
X-Gm-Message-State: AOJu0YwynBII3wh2h/GprluMD8+E2KCxyDT78OXB806qhhpFCtRRUHI4
 SL7x8w/5CvsPllDU1s32YGrDi1HAfDqS7uU5galh8lOJHATzS1WSF+Nalw==
X-Gm-Gg: ASbGncvaHXZLE1nJNrff+mths8w3aeslHYvKVkaWCrQFuMDHXQkQerPlJmzr+3X8xfp
 xM6QkpC4kH3gF3auupUi8kotg4FKxk41oZ0NTL0gmGMF01Fk/ymkmq3HnrYTOHmvfZL+2Ppe13W
 k5yp5+qmobYFWEAKKxmk9QNk3B7Ii9azl/6tGYBqqMBxFP5Z2QYwh6ccFYSgvUfzQ0P179lOqpE
 LkXdJXB2M4qOMzH80xwRIrnnf7gwPrpAdD4TVu50v/gaMKlWuBgPHBz3/QgrLNQvTshX+ppgKbE
 cbm4bWFlf73g1bnNvvMfbkNuqVHc1DVwOsw8ZyjgdQuDf0+5B9NzU5R3xzaIFrZW+nD5HI9qyvQ
 CG4Lrf6SQ7WSfiw==
X-Google-Smtp-Source: AGHT+IG5qeJhQ8f2Ed1Ue4OdcMe+ldEGJiEI161EgYxmyIEHiV8siG0SCXR3JWWF8PUoFH1nA5lt3w==
X-Received: by 2002:a05:600c:3556:b0:43c:ec27:8de1 with SMTP id
 5b1f17b1804b1-43cec278ef4mr27012765e9.10.1741529246537; 
 Sun, 09 Mar 2025 07:07:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3912bee262esm11946816f8f.0.2025.03.09.07.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 07:07:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 3/4] reset: airoha: Add driver for controlling reset line of
 AN7581
Date: Sun,  9 Mar 2025 15:06:45 +0100
Message-ID: <20250309140652.23543-4-ansuelsmth@gmail.com>
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

Add driver for controlling the reset lines of AN7581. This is a detached
version of the clock controller driver present in Linux only used to
control reset lines. Driver gets loaded with the bind of the clock
driver and doesn't require a compatible. This is needed as they share
the same registers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/airoha/clk-airoha.c               |  16 ++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-airoha.c                  | 173 ++++++++++++++++++
 .../dt-bindings/reset/airoha,en7581-reset.h   |  66 +++++++
 5 files changed, 263 insertions(+)
 create mode 100644 drivers/reset/reset-airoha.c
 create mode 100644 include/dt-bindings/reset/airoha,en7581-reset.h

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
diff --git a/include/dt-bindings/reset/airoha,en7581-reset.h b/include/dt-bindings/reset/airoha,en7581-reset.h
new file mode 100644
index 00000000000..ac4a3fee4c3
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,en7581-reset.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7581_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7581_H_
+
+/* RST_CTRL2 */
+#define EN7581_XPON_PHY_RST		 0
+#define EN7581_CPU_TIMER2_RST		 1
+#define EN7581_HSUART_RST		 2
+#define EN7581_UART4_RST		 3
+#define EN7581_UART5_RST		 4
+#define EN7581_I2C2_RST			 5
+#define EN7581_XSI_MAC_RST		 6
+#define EN7581_XSI_PHY_RST		 7
+#define EN7581_NPU_RST			 8
+#define EN7581_I2S_RST			 9
+#define EN7581_TRNG_RST			10
+#define EN7581_TRNG_MSTART_RST		11
+#define EN7581_DUAL_HSI0_RST		12
+#define EN7581_DUAL_HSI1_RST		13
+#define EN7581_HSI_RST			14
+#define EN7581_DUAL_HSI0_MAC_RST	15
+#define EN7581_DUAL_HSI1_MAC_RST	16
+#define EN7581_HSI_MAC_RST		17
+#define EN7581_WDMA_RST			18
+#define EN7581_WOE0_RST			19
+#define EN7581_WOE1_RST			20
+#define EN7581_HSDMA_RST		21
+#define EN7581_TDMA_RST			22
+#define EN7581_EMMC_RST			23
+#define EN7581_SOE_RST			24
+#define EN7581_PCIE2_RST		25
+#define EN7581_XFP_MAC_RST		26
+#define EN7581_USB_HOST_P1_RST		27
+#define EN7581_USB_HOST_P1_U3_PHY_RST	28
+/* RST_CTRL1 */
+#define EN7581_PCM1_ZSI_ISI_RST		29
+#define EN7581_FE_PDMA_RST		30
+#define EN7581_FE_QDMA_RST		31
+#define EN7581_PCM_SPIWP_RST		32
+#define EN7581_CRYPTO_RST		33
+#define EN7581_TIMER_RST		34
+#define EN7581_PCM1_RST			35
+#define EN7581_UART_RST			36
+#define EN7581_GPIO_RST			37
+#define EN7581_GDMA_RST			38
+#define EN7581_I2C_MASTER_RST		39
+#define EN7581_PCM2_ZSI_ISI_RST		40
+#define EN7581_SFC_RST			41
+#define EN7581_UART2_RST		42
+#define EN7581_GDMP_RST			43
+#define EN7581_FE_RST			44
+#define EN7581_USB_HOST_P0_RST		45
+#define EN7581_GSW_RST			46
+#define EN7581_SFC2_PCM_RST		47
+#define EN7581_PCIE0_RST		48
+#define EN7581_PCIE1_RST		49
+#define EN7581_CPU_TIMER_RST		50
+#define EN7581_PCIE_HB_RST		51
+#define EN7581_XPON_MAC_RST		52
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7581_H_ */
-- 
2.48.1

