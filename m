Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786E2CD1299
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CDE88400;
	Thu,  4 Apr 2024 18:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NS4G6mdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A0D883F3; Thu,  4 Apr 2024 18:46:54 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4F2883FE
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34373f95c27so796931f8f.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712249212; x=1712854012; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t7XTAXVop9MdRSoJ4bh8rFbBlwVLuCjC3Utz59Ptsoo=;
 b=NS4G6mdC5r7JblrN1LvS4fRvptkSJLGfNGhnKO0XfVFeW38E2oYqplaNlZsUAbPkam
 7L4rO5pOQGj+6odGf9ftQ6ZjRAgVf6j7+I+cWIoDph95ittK+eufByv8hB8lfIQ0Zb+n
 EHgx/lHc7rBsHMV1lwpkm4Up1lYNLrWWXNaRlsa4hxdQxGFRHOTLcLqaH24h31aksm+J
 SsFvvDC0MiLI5N4u840VTRgTa2M7x5LpVL+Bo+C/83SYELrrbOSOx5X/VGCg6HMpFGNe
 B25LkXzdopcZIwPleXXWGs+x3kGEq5ouNMr65qchkT54s1q3nbLkihaQSb6YE0fE32xI
 /IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712249212; x=1712854012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7XTAXVop9MdRSoJ4bh8rFbBlwVLuCjC3Utz59Ptsoo=;
 b=E9LgQBWA6Ft949n1o94WmUI1Mji6EaK2pZpKsFw+hOHVIKlNXwtFCKvFKD7lJE5cmK
 0jHKmHlTxrznGy/DdbldgzCNZXuWySfes/S5hMlKkUTYEBCri+r0zuU2aLwC2z6BVJle
 4NkCDzrkJtqadXhxtxjByozc+XD/Gw0/ibm5WWNRAPOl2IBvbR/g64zYc2QFS5Np780a
 miva+DeFyYNyDEQi0JKrA0CWql4A3BX0vF8ZzOha/q3snkaXRKUvZNx0+dHAyX/6n+fl
 vfK/nYZaUID7UIZQJ5Y8Z0PBmjEBZte/h9bfgBQWqvbOWQ/wG/TOs92HaNkLcnBTcIUr
 07cw==
X-Gm-Message-State: AOJu0YwQlCXduJB58OQTCYLGRs5FH1XOZcN6KxyC8SApZK9f6CFkwpnU
 bSEwVJ4E5cAeOLyBzYVwVV3UdnFQD4QM6dcVm97Whcgh/13MCvNutRRAsbk+RR8AkzQGHoAlrxw
 odtw=
X-Google-Smtp-Source: AGHT+IHQy0qisOaTjWIlfPTG6qvOqBkGF5yr11uP92ePwj6FNEYs83OuO/g9BQqHwego3VwlQ2vIvQ==
X-Received: by 2002:adf:fd11:0:b0:343:96b2:c12e with SMTP id
 e17-20020adffd11000000b0034396b2c12emr2478203wrr.15.1712249211485; 
 Thu, 04 Apr 2024 09:46:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a5d4561000000b00343c0c24a65sm2152930wrc.89.2024.04.04.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 09:46:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Apr 2024 18:46:39 +0200
Subject: [PATCH 2/3] clk: qcom: Add SM8650 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-topic-sm8x50-clock-v1-2-0c8ea7fad003@linaro.org>
References: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
In-Reply-To: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14280;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1jjhZdQWmypdO7lv9cQ/+NXy5/5ZYaOpbuZUSrPaup8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDtl4BKid3S91Q0NLY6lrNbtFqBA/0FgcyJNrrOag
 ksrIpCqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg7ZeAAKCRB33NvayMhJ0SVrD/
 wPrmNNGFQiW4ZCtiSXjZDFAf0DrANg4U/Vrmie5/zW1GxTf/mQ/JTzbhe7AFomkdlUqPF1tPV9Uj9f
 zGd7GgT6LDd7n2JEvM4y/IWC8LY/vBXdFQ5M/OpVmKWkppawNKBlP9JoLwlSAAjz4R/7tGJ0mutO7i
 U6jzsh9O9q3boohvGrYGOKePW5M2DqwBUJ/1RDyOgwQbim85V0bO9iGwbTA7+NYuTkt9rib91Y6zIz
 /osRRwEzzO41B0mIomOtWXAt8w8RpAyBY5PHe2ICSXJqSsvXd4BFP0nGwT3EJj86XBV7bIC1a4I5G/
 u8z/BvbqCbftGk469757hROpxsWDjP3jHOZOKF6Xhfn4SC5BqFKzsHTNmkusKtPkZXMmmNjVqx2Vt2
 Kb9THzdErsJpRf6W3ZEpPIdhE/k6w6kgFlw75dviaY6GTyl6IyaoRoIeNS09+WqEb9AYxVfZKLT+JP
 xZwOML7dJLz8/ZzoATd0erbnGGZIZxCiPEOHDxHjhv9EN0bKRx74wXelrkTvPoxVu5Pw0rG9mFLk8o
 92XE6pj/8S4mtmHNqt7V+wlQFxj7ECqsefoSjENJH4ou59yT5F4VauvXB06TZPUNYLNzB/o/85aL+j
 rcGQOOoa4GxsXax8vpq2VoLdHed313D/evasnWpxV+gq5yJ6JvncBZCvoTYQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add the GCC and TCSRCC clock driver for the SM8650 SoC.

The GCC driver uses the clk-qcom infrastructure to support GDSCs,
Resets and gates. While the TCSRCC is a simpler clock driver which
only supports gates.

The GCC enable and set_rate callbacks contains some tweaks to
setup clocks for Debug UART, SDCard controller and USB.

The TCSRCC gates returns the XO frequency, which is used by the
Synopsys eUSB2 driver to determine the PHY configuration.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/Kconfig        |   8 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sm8650.c | 332 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index c908a3d19c9..a9216ea30d4 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_SM8550
 	  on the Snapdragon SM8550 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SM8650
+	bool "Qualcomm SM8650 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SM8650 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index d9ac5719f49..3ccb4ffae76 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
new file mode 100644
index 00000000000..0ce83e9b243
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm sm8650
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,sm8650-gcc.h>
+#include <dt-bindings/clock/qcom,sm8650-tcsr.h>
+
+#include "clock-qcom.h"
+
+/* On-board TCXO, TOFIX get from DT */
+#define TCXO_RATE	38400000
+
+/* bi_tcxo_div2 divided after RPMh output */
+#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s3_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	/* TOFIX F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0), */
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static ulong sm8650_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP2_S7_CLK: /* UART15 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x1e898,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x14018,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x3902c,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, 0x39044, 0, 0);
+		return TCXO_DIV2_RATE;
+	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
+		clk_rcg_set_rate(priv->base, 0x39070, 0, 0);
+		return TCXO_DIV2_RATE;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sm8650_clks[] = {
+	GATE_CLK(GCC_AGGRE_NOC_PCIE_AXI_CLK,		0x52000, BIT(12)),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK,	0x770e4, BIT(1)),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
+	GATE_CLK(GCC_CNOC_PCIE_SF_AXI_CLK,		0x52008, BIT(6)),
+	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,			0x71154, BIT(0)),
+	GATE_CLK(GCC_DDRSS_PCIE_SF_QTB_CLK,		0x52000, BIT(19)),
+	GATE_CLK(GCC_PCIE_0_AUX_CLK,			0x52008, BIT(3)),
+	GATE_CLK(GCC_PCIE_0_CFG_AHB_CLK,		0x52008, BIT(2)),
+	GATE_CLK(GCC_PCIE_0_MSTR_AXI_CLK,		0x52008, BIT(1)),
+	GATE_CLK(GCC_PCIE_0_PHY_RCHNG_CLK,		0x52000, BIT(22)),
+	GATE_CLK(GCC_PCIE_0_PIPE_CLK,			0x52008, BIT(4)),
+	GATE_CLK(GCC_PCIE_0_SLV_AXI_CLK,		0x52008, BIT(0)),
+	GATE_CLK(GCC_PCIE_0_SLV_Q2A_AXI_CLK,		0x52008, BIT(5)),
+	GATE_CLK(GCC_PCIE_1_AUX_CLK,			0x52000, BIT(29)),
+	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK,		0x52000, BIT(28)),
+	GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK,		0x52000, BIT(27)),
+	GATE_CLK(GCC_PCIE_1_PHY_AUX_CLK,		0x52000, BIT(24)),
+	GATE_CLK(GCC_PCIE_1_PHY_RCHNG_CLK,		0x52000, BIT(23)),
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK,			0x52000, BIT(30)),
+	GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK,		0x52000, BIT(26)),
+	GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK,		0x52000, BIT(25)),
+	GATE_CLK(GCC_QUPV3_I2C_CORE_CLK,		0x52008, BIT(8)),
+	GATE_CLK(GCC_QUPV3_I2C_S0_CLK,			0x52008, BIT(10)),
+	GATE_CLK(GCC_QUPV3_I2C_S1_CLK,			0x52008, BIT(11)),
+	GATE_CLK(GCC_QUPV3_I2C_S2_CLK,			0x52008, BIT(12)),
+	GATE_CLK(GCC_QUPV3_I2C_S3_CLK,			0x52008, BIT(13)),
+	GATE_CLK(GCC_QUPV3_I2C_S4_CLK,			0x52008, BIT(14)),
+	GATE_CLK(GCC_QUPV3_I2C_S5_CLK,			0x52008, BIT(15)),
+	GATE_CLK(GCC_QUPV3_I2C_S6_CLK,			0x52008, BIT(16)),
+	GATE_CLK(GCC_QUPV3_I2C_S7_CLK,			0x52008, BIT(17)),
+	GATE_CLK(GCC_QUPV3_I2C_S8_CLK,			0x52010, BIT(14)),
+	GATE_CLK(GCC_QUPV3_I2C_S9_CLK,			0x52010, BIT(15)),
+	GATE_CLK(GCC_QUPV3_I2C_S_AHB_CLK,		0x52008, BIT(7)),
+	GATE_CLK(GCC_QUPV3_WRAP1_CORE_2X_CLK,		0x52008, BIT(18)),
+	GATE_CLK(GCC_QUPV3_WRAP1_CORE_CLK,		0x52008, BIT(19)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x52008, BIT(22)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x52008, BIT(23)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK,		0x52008, BIT(24)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x52008, BIT(25)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x52008, BIT(26)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x52008, BIT(27)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,		0x52008, BIT(28)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,		0x52010, BIT(16)),
+	GATE_CLK(GCC_QUPV3_WRAP2_CORE_2X_CLK,		0x52010, BIT(3)),
+	GATE_CLK(GCC_QUPV3_WRAP2_CORE_CLK,		0x52010, BIT(0)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK,		0x52010, BIT(4)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK,		0x52010, BIT(5)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK,		0x52010, BIT(6)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK,		0x52010, BIT(7)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK,		0x52010, BIT(8)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK,		0x52010, BIT(9)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK,		0x52010, BIT(10)),
+	GATE_CLK(GCC_QUPV3_WRAP2_S7_CLK,		0x52010, BIT(17)),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x52008, BIT(20)),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x52008, BIT(21)),
+	GATE_CLK(GCC_QUPV3_WRAP_2_M_AHB_CLK,		0x52010, BIT(2)),
+	GATE_CLK(GCC_QUPV3_WRAP_2_S_AHB_CLK,		0x52010, BIT(1)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14010, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77024, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x77018, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AXI_HW_CTL_CLK,		0x77018, BIT(1)),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77074, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK,	0x77074, BIT(1)),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x770b0, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK,	0x770b0, BIT(1)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x7702c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770cc, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77028, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77068, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK,	0x77068, BIT(1)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x39018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x39028, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x39024, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x39060, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x39064, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x39068, BIT(0)),
+};
+
+static int sm8650_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
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
+static const struct qcom_reset_map sm8650_gcc_resets[] = {
+	[GCC_CAMERA_BCR] = { 0x26000 },
+	[GCC_DISPLAY_BCR] = { 0x27000 },
+	[GCC_GPU_BCR] = { 0x71000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
+	[GCC_PCIE_1_BCR] = { 0x8d000 },
+	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0x8e014 },
+	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0x8e020 },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0x8e024 },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x6f00c },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
+	[GCC_QUPV3_WRAPPER_3_BCR] = { 0x19000 },
+	[GCC_QUPV3_WRAPPER_I2C_BCR] = { 0x17000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0x39000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x32024, 2 },
+	[GCC_VIDEO_BCR] = { 0x32000 },
+};
+
+static const struct qcom_power_map sm8650_gdscs[] = {
+	[PCIE_0_GDSC] = { 0x6b004 },
+	[PCIE_0_PHY_GDSC] = { 0x6c000 },
+	[PCIE_1_GDSC] = { 0x8d004 },
+	[PCIE_1_PHY_GDSC] = { 0x8e000 },
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
+	[USB30_PRIM_GDSC] = { 0x39004 },
+	[USB3_PHY_GDSC] = { 0x50018 },
+};
+
+static struct msm_clk_data sm8650_gcc_data = {
+	.resets = sm8650_gcc_resets,
+	.num_resets = ARRAY_SIZE(sm8650_gcc_resets),
+	.clks = sm8650_clks,
+	.num_clks = ARRAY_SIZE(sm8650_clks),
+	.power_domains = sm8650_gdscs,
+	.num_power_domains = ARRAY_SIZE(sm8650_gdscs),
+
+	.enable = sm8650_enable,
+	.set_rate = sm8650_set_rate,
+};
+
+static const struct udevice_id gcc_sm8650_of_match[] = {
+	{
+		.compatible = "qcom,sm8650-gcc",
+		.data = (ulong)&sm8650_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sm8650) = {
+	.name		= "gcc_sm8650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sm8650_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+/* TCSRCC */
+
+static const struct gate_clk sm8650_tcsr_clks[] = {
+	GATE_CLK(TCSR_PCIE_0_CLKREF_EN,		0x31100, BIT(0)),
+	GATE_CLK(TCSR_PCIE_1_CLKREF_EN,		0x31114, BIT(0)),
+	GATE_CLK(TCSR_UFS_CLKREF_EN,		0x31110, BIT(0)),
+	GATE_CLK(TCSR_UFS_PAD_CLKREF_EN,	0x31104, BIT(0)),
+	GATE_CLK(TCSR_USB2_CLKREF_EN,		0x31118, BIT(0)),
+	GATE_CLK(TCSR_USB3_CLKREF_EN,		0x31108, BIT(0)),
+};
+
+static struct msm_clk_data sm8650_tcsrcc_data = {
+	.clks = sm8650_tcsr_clks,
+	.num_clks = ARRAY_SIZE(sm8650_tcsr_clks),
+};
+
+static int tcsrcc_sm8650_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static ulong tcsrcc_sm8650_clk_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int tcsrcc_sm8650_clk_probe(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	struct msm_clk_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->data = data;
+
+	return 0;
+}
+
+static struct clk_ops tcsrcc_sm8650_clk_ops = {
+	.enable = tcsrcc_sm8650_clk_enable,
+	.get_rate = tcsrcc_sm8650_clk_get_rate,
+};
+
+static const struct udevice_id tcsrcc_sm8650_of_match[] = {
+	{
+		.compatible = "qcom,sm8650-tcsr",
+		.data = (ulong)&sm8650_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(tcsrcc_sm8650) = {
+	.name		= "tcsrcc_sm8650",
+	.id		= UCLASS_CLK,
+	.of_match	= tcsrcc_sm8650_of_match,
+	.ops		= &tcsrcc_sm8650_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= tcsrcc_sm8650_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

