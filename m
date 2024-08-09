Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E39BC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027B488A10;
	Fri,  9 Aug 2024 02:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="maxscBQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042C288ADE; Fri,  9 Aug 2024 02:48:55 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D932688ADE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so19600941fa.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164531; x=1723769331; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8jvqKG35APvsOl9/RSPAT4kuVZTZIqevrqhittT/SaE=;
 b=maxscBQGX3BjKLPTWUApssA8KU8AVoCe74AjGfQACs9e/eJsyIdhrpZYmB+pDpPyN2
 JWEkOSvw0edT0UfQL7+0iSZmHHF9cnkVO4+exsbmHnsJIdeOivuQKVQq9IpQG31JPqMq
 VGTGxX9H2y+jaxJzLen6MoudWATDhNXM0gjj9UEXrxlsS3WEw83Zzq56BIli6UWt054N
 iKduYpqkE4DH89WvyLEZNb16KDFNujUNj76IaU72Cwo6RfEm/Y1vMHv5ebFELcoTDzIZ
 uQRcujqsltOR8kUqA9wBgK57hyN3MD2sTEzEccfCppTBUP1UAlqZgASyCuBtOYn3NeEo
 Ri/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164531; x=1723769331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jvqKG35APvsOl9/RSPAT4kuVZTZIqevrqhittT/SaE=;
 b=w2vNm33HjuDKWBG8Q3tDLHVCmtsYgu8p8vOeAGGK5VwU9hZ+Q7LMU+J6zKY/SsFojW
 HmcaGIRKmXYfsIPb2TeXIBVcHISiQQiYrpMXChc7Swus2XIwbqfWM8ONvj1UvFvVPAtb
 FEVIFTyNcikLchmyEjYu5qH/p8A6gQubNLdFVWU5ZsXwAdz3e3k5L0BWwqzljPoHYNvG
 dXAGa43kU35lxPOZJrZHCL+YM4xgDZo8RNtxqCmgybPeZ9cC/H34tbyvVdH3Yu63knig
 UY0mQ2Rp0qm7ulklj1hs8tpJHpYp8AD7nl6hvp8VyTEq1E5eLVccxhLKxSsoqJuc/i34
 1b/Q==
X-Gm-Message-State: AOJu0YyXfCWLgSfJUFJzyVB+NwCPYbLZGR1SjOu6dkjuT4QJbTmDSWTl
 SeR8RplDGUpsIoM+b8XJbgdgeoMasAcCtvWUHfDwPwEjhGZB0d90Axhgv5q/+SA=
X-Google-Smtp-Source: AGHT+IF6XLSq4IjmeFGWoomkftwpzODSgreLZKmP7CTuCC2aZPVFw4MVqVaDZUPP1bRAZdMTXffEGg==
X-Received: by 2002:a05:6512:6d1:b0:52c:e09c:b747 with SMTP id
 2adb3069b0e04-530ee98d67cmr2185e87.27.1723164530750; 
 Thu, 08 Aug 2024 17:48:50 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:44 +0200
Subject: [PATCH 1/7] clk/qcom: add initial clock driver for sc7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-1-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6553;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vNVYHzG/GpDqOALmDhAq+wjFOy+RwgKs/59qQShLJJs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdvkSqew5Fqvgdu78XjbkAH/L1NZSv/5U0NI
 FW0iNqaIjiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVnbwAKCRAFgzErGV9k
 tuHiEACckJJt/qaDr1eZBmVMg5fQ1UZ/jfq0mFaAlR0OwPIlrqCMzR5/L8IYKeQ5t9qOFIZ5+XB
 AwGivBTo3p5l1+Qe7qDYF80/UOxmw1kgMq9MwfRkJY8qY+npylO1C+AZeS1Y6Riyc/RfQJ9TyIR
 xYVBnLmlwkaAn5lLgBC7ACBEUZrSYcMuW7WTvdySX6yVRt25fW4FQn/KxK+ZIkt25zew6xe/oma
 +ERp426+/lZHUwOP1MJ7qcmM8lsCDLi5DYVjQKDzBLamI/v/doeI8KowYV3KyRVdT3qHJ+zrm0g
 KAoGjCi+VCWe4luEZ6C/ex9EmEdsuQBjdefhZR/826jynCcKAyvonE7ev/Uuw3HrFGuejzYTERO
 FVd4vP8LzDaVKqpFbP4JSAgo4bWkdbMhh+oeLh/TBiGyNpYwJNqUgMixIR61Q247UNFzTGtBafL
 YvkyeeEIE0rBcOLH2reJY7qJ/XedYoB5R47BTuxK6pGSUzqygqWzgvrs/wy8rMmJ1wuxIuhIFKZ
 dADFPL43yUSqPzP+5ah6hJGSrIgxD0VR5Te6Wlw6ul0VleN7pf9nKzWt7dXvi7QCDRHUrJkS8kx
 mkinSwMmsdjoo831mHEkDVB7eTA9qdvLQb/CWbZkSIW32+Z2TbvNJACj5s6HYrqgAEWDjPJlsHr
 rKlCzLiXCmJ+GIg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

We don't actually need any clocks to get UFS up and running, resets are
useful though.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/Kconfig        |   8 +++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-qcom.h   |   1 +
 drivers/clk/qcom/clock-sc7280.c | 132 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 45d63c6d6dbf..0d2c0ac225c5 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -85,7 +85,15 @@ config CLK_QCOM_SM8650
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8650 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SC7280
+	bool "Qualcomm SC7280 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SC7280 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index dec20e4b5943..e223c131ee4d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -8,8 +8,9 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
 obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index f6445c8f566f..7aa6ca59aad5 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -10,8 +10,9 @@
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
+#define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
 #define CFG_CLK_SRC_GPLL7 (3 << 8)
 #define CFG_CLK_SRC_GPLL4 (5 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
new file mode 100644
index 000000000000..5d343f120519
--- /dev/null
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm sc7280
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sc7280.h>
+
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+
+static ulong sc7280_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return rate;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
+		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sc7280_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, 1),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, 1),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
+};
+
+static int sc7280_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, sc7280_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sc7280_gcc_resets[] = {
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_1_BCR] = { 0x8d000 },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC1_BCR] = { 0x75000 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB30_SEC_BCR] = { 0x9e000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct qcom_power_map sc7280_gdscs[] = {
+	[GCC_UFS_PHY_GDSC] = { 0x77004 },
+	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
+};
+
+static struct msm_clk_data qcs404_gcc_data = {
+	.resets = sc7280_gcc_resets,
+	.num_resets = ARRAY_SIZE(sc7280_gcc_resets),
+	.clks = sc7280_clks,
+	.num_clks = ARRAY_SIZE(sc7280_clks),
+
+	.power_domains = sc7280_gdscs,
+	.num_power_domains = ARRAY_SIZE(sc7280_gdscs),
+
+	.enable = sc7280_enable,
+	.set_rate = sc7280_set_rate,
+};
+
+static const struct udevice_id gcc_sc7280_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sc7280",
+		.data = (ulong)&qcs404_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sc7280) = {
+	.name		= "gcc_sc7280",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sc7280_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.46.0

