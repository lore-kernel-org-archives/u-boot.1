Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1854CC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F6188D9B;
	Wed, 21 Aug 2024 15:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BpF9pRLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A7E88D9B; Wed, 21 Aug 2024 15:41:58 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896B7887D4
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5333b2fbedaso4381657e87.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247715; x=1724852515; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vYpvXZhAM0wjWc6QeTnHyYsF2xjKAb2Bg/9VNGJ7oC4=;
 b=BpF9pRLArbhamTTSvF+LPOjqIaruq3137+Td+Y4qA32sBPKjZN2zyabjh/Rafnr5O1
 9d/0nOcXmbKi3CTtdUN3qV19169r8d2lAuPiUwXoxGf4v9wPlXv1TnQilC0/IpdephxJ
 oRj9+5DwMh1C/THNGdn6N9M7PrZ33uVwOawlqlGPGaBUlZzEtdpeQt8mGBT72vsWTwEc
 g9XIuP7GYNy3Ztzy8JMYfvFT0MCUQmkDb9anAIfRkARVMxMTI3X0lz9nXqhgNHGXF/vc
 tw9UbbFQc5bsonufEXl0cg3x4yHX3dzV2NcPvnGJWBUgHbNoQ1dUvmUD8ivz8xpCGh95
 /uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247715; x=1724852515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYpvXZhAM0wjWc6QeTnHyYsF2xjKAb2Bg/9VNGJ7oC4=;
 b=F/jmt2BY3txUp2Xo6ouNkmlNd7uQWuOBEkIGKUIwLL3jKl7uBJ/Ptt5k5n2REXJ3RX
 qQv2x7FQlJXgvIfdnyr82QJx4EA7lV3SciLcJsTQMrrE0URCNMdIzUgMi0Su+QUw2rkH
 3F6BNFc2AUknW7ohrfLBnJWKHecIEJy7NbLcVve5RxNTga9md5WoIqlyL0PMo+pbTH/P
 t4upinI57g3mt/aAFxlETKF7TY9fUiDnKfmp6NNkTAYVemvziHPE4LO78hHLLRggdYJE
 li/V+pZa6jdmhd9c2wPO7Qlhlw3i48ti0LmA6PBMgebLO+YTAXf2pUpLQl4gdayX4WJr
 21qA==
X-Gm-Message-State: AOJu0YzCxBg0ApyZrMj/flKnSEzT/WdNXsTISMZEYTB2A2c9+9pYoTt8
 Y4o4D/Wn7JKEhGJS9pejsVJGp3BVDAbME2fz2uL63aeV9h8aeA7aQIfST443wEE=
X-Google-Smtp-Source: AGHT+IHwtmpvp1KyCpCFrQ9m8b9mZocGdoGZKOOBbCOdWXgPOOaJpvIzD+wO9cPMXI0xJJ299Vb3aw==
X-Received: by 2002:a05:6512:2526:b0:533:4b07:a8dc with SMTP id
 2adb3069b0e04-5334b07a924mr853860e87.35.1724247714485; 
 Wed, 21 Aug 2024 06:41:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:41:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:46 +0200
Subject: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6610;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Ml3U758Os52kpw+GNgmPmB5Bs0weI+7Cu8LeGmVUjJs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6dj9dkbc0E3zPhQL/6lm1ahALcexDRPoBcO
 ng26jm+QUiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXunQAKCRAFgzErGV9k
 ttaKD/9DtqMqfY7Do5CxJU3qRYk5ZmdeMIF9JTXN0APLu1fGGMznfgoUn93safNuzgw/exm5CNI
 rSoCXHGtBpKM+SWjYe9ir4C7PQqdJt0J5vgdUOHVqfy87jgC4RQkE6HUDCtd9s1HitZNCtiZGrs
 BeJ7SVOrAakL3QgXCssgvhDmNmQoMDd5l1lTXL9p5RQTVAZuQuihQJ1fcVtXVH9DlYidlvNdwKZ
 wLXps20Hc7uStWohI/+MtDq5OzwxfEXVLBOktJ8cR26UZ1N5pFItdarRZpmJCJFtWU4ORyamCKW
 EcPSjaDo7r2GT7CbiILoXpsQLGX5SNrEWFAFQJKUjAyHe0x2H0394aVGd4Yt9kFBG8KSvhzwsVq
 tVzpKmy0oe/2CCcVsRHhT4b1j7H+MiudmxYpUByqcljtWKm/0Nd6C42oqHSs4NP+DRHHPzDGpxm
 Bzaex1Y5tkwivXqgISlHEX99R605X8KWM3LJnKMPBU5qdHN7x1/8tdcpsnCHd/+AobL+Ty7gaH4
 CXqmB2zZY/1VAhboMRJnDaOooBlBlGfaiMu9/sOpQJo0xWPYtANjyli/9TIsBSBkctEAa4rv0WN
 ruiueb3HXdDqzPGpcaVMnApPjkNEUGiMlhaJKTJPcBuIDaC0uNwquaRv7fmLRE5oqWlX1uQ7Seu
 fUzYzzESEzLWSGg==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

