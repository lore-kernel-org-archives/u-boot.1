Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F70FCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DE0883F4;
	Thu,  4 Apr 2024 18:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aWMxSvzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AD488424; Thu,  4 Apr 2024 18:46:54 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD92D883F3
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3438f079ff5so781220f8f.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712249211; x=1712854011; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dEYJY6N48pk9482lrUKAs+QT31JOtoZDZ20bc+cTL0c=;
 b=aWMxSvzPlsEdB1ohRjEIZbENb3DHRUDkZoownNPgkRdC+VX0LKDM7AbsrfcZdOTAmZ
 LCyac7POd56vxMUoEMirgn/lmY+8u3lTwis+GCrbirQ66PAgYeZZr98uixyri9/TzY4a
 6VHNwjEJXOEE94gDtclE0s2JV/eoZNSdqzvvnfvYKZpMRCuCPwESK4ex72g5bI//W6tq
 07tbwwXA+SSw/pT5kAKnQGfP0oSu4Y5uaI6LZspnQjVNazXZhKk1QHvPE3GjgJePQjRN
 AfL+TMy+uGIYKPhaQBLWwpR3KjbMoX6b+EnsHMJHM75137gZlGxVZznKN5MERHirl3qd
 0VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712249211; x=1712854011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEYJY6N48pk9482lrUKAs+QT31JOtoZDZ20bc+cTL0c=;
 b=NKlhV/zKzOOoFUhpaI1/Mw1k7PAjACSvkyJv0plsPeDLvFnOqnlIL+buC3rOTgxG3g
 sPBoVLYqXUQBrYMwZ4Me4N0pGZwCkDhIW1VR2fMa5gyaT1nHrrL1D1MYEtlC0LnGF0zN
 +TJx0EQKTO0ij9JEfMtO8MZWzHhR39/iPGt4PiqCO1B3Sr1x/kL6sgLeq2nIAG6L7mCp
 lLhIUz3dSz7uJfBAkMQf5dDlFIDKwRYTAYwd+FTRPF9CY1zLSMVzIYZsTlJ4ZAnYnwgH
 8ZvTjjUKiecmK4wVOp5v7MCGHyul31ldGkGjxmun3o0hWwOqCwLFlQAAJo0WgG3q9bY1
 8xAw==
X-Gm-Message-State: AOJu0YwsZj5iUx6RZPzy9gmGVXl9jK240a6KVzvL0DLnAfopyR4wptJF
 qbeShtXuogQfGM6bep+a+AzEApUnSnvvOF8/rxhHGpOQOWTf5u7RylzFwUFMTkYsu6hFlIwSy/j
 9J9A=
X-Google-Smtp-Source: AGHT+IFhyjjb2+NThSWSWdJM6Xqe150eT1brsngHJ0My/W2u7Vb6u0k2z/QigyMeVVOiSeBK/hrI3w==
X-Received: by 2002:a5d:4dcf:0:b0:343:b9e4:9baf with SMTP id
 f15-20020a5d4dcf000000b00343b9e49bafmr1928274wru.12.1712249210744; 
 Thu, 04 Apr 2024 09:46:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a5d4561000000b00343c0c24a65sm2152930wrc.89.2024.04.04.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 09:46:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Apr 2024 18:46:38 +0200
Subject: [PATCH 1/3] clk: qcom: Add SM8550 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-topic-sm8x50-clock-v1-1-0c8ea7fad003@linaro.org>
References: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
In-Reply-To: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14432;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SXPZuzJbR1/YhI53PPgX9/9zdesmCz6Yew1rEyPtoRQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDtl4Hd1IVv4N7YhjfEV+O1OFy8AC9ov1UyooyGwf
 5nG1QYuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg7ZeAAKCRB33NvayMhJ0Rr8EA
 DBiw28Eqd7DPjbv0KnoBKJ8evOQ0vtSPpO6KpvHZaxu5b1FHGXQRdriuS4tinPmCxtce2e3Aa7wWzi
 Q3Y3UY/P4izflGszVZvqBOIjGz72Z/VrnbWLUHsCjwspe3+EpyzJhJFlO/z9nUcb1E4vTf22xCo7rT
 ZrC+yNWQJ2cW7G/Il1zKD6mJnf7+5FppiA37prPkSKGnAH/334Ar3rIr0vgwKDA47mVD2qdgKFGMg6
 LxlaDH1eK+jSW3JVVMzw8C9d7kPdSwgnzCW9Fqonk8aNkipNlDcFzLzVCG5Eh03ck9cunutJPCM6P+
 50IC9LrD01zLbCIYTfNZxZcdw/UU3wkZq7G1v0Eo/iFnOJmlrXKvEjl/xF1fUp+xNOJEpojeq809Dx
 7frNQ5M+2oUHQbyolthT6qRGmOJSkSyg+ZAHrljCnlSFQ+mMVa08m1a7UZsrvrU+lv+PTwqbVw/BOd
 MKbOWriSU09or4CogyVppd+NwCPDOWzL+ccMeJTopVqisfXwmmmkqjRUpnhmuribRWvcxeKCiKa4Jd
 /qUHYwAc8SE+39Q5mc2KlJaQNrusfm8xgnFyvoI6YC+WvF4IxJhTjiWmK7EKnh21+9YBjOIuBox/sb
 aI/k6luwO7GiOnU/bcrJ9HoSdejOD9qCUDtCrR81dXD/bhnBcN4+/fveAOiA==
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

Add the GCC and TCSRCC clock driver for the SM8550 SoC.

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
 drivers/clk/qcom/clock-sm8550.c | 335 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8dae635ac2c..c908a3d19c9 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
 	  on the Snapdragon 845 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SM8550
+	bool "Qualcomm SM8550 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SM8550 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index cb179fdac58..d9ac5719f49 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
new file mode 100644
index 00000000000..c0249925cc7
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm sm8550
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
+#include <dt-bindings/clock/qcom,sm8550-gcc.h>
+#include <dt-bindings/clock/qcom,sm8550-tcsr.h>
+
+#include "clock-qcom.h"
+
+/* On-board TCXO, TOFIX get from DT */
+#define TCXO_RATE	38400000
+
+/* bi_tcxo_div2 divided after RPMh output */
+#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s2_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(51200000, CFG_CLK_SRC_GPLL0_EVEN, 1, 64, 375),
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
+	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
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
+static ulong sm8550_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S7_CLK: /* UART7 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x18898,
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
+static const struct gate_clk sm8550_clks[] = {
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
+static int sm8550_enable(struct clk *clk)
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
+static const struct qcom_reset_map sm8550_gcc_resets[] = {
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
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x32024, 2 },
+	[GCC_VIDEO_BCR] = { 0x32000 },
+};
+
+static const struct qcom_power_map sm8550_gdscs[] = {
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
+static struct msm_clk_data sm8550_gcc_data = {
+	.resets = sm8550_gcc_resets,
+	.num_resets = ARRAY_SIZE(sm8550_gcc_resets),
+	.clks = sm8550_clks,
+	.num_clks = ARRAY_SIZE(sm8550_clks),
+	.power_domains = sm8550_gdscs,
+	.num_power_domains = ARRAY_SIZE(sm8550_gdscs),
+
+	.enable = sm8550_enable,
+	.set_rate = sm8550_set_rate,
+};
+
+static const struct udevice_id gcc_sm8550_of_match[] = {
+	{
+		.compatible = "qcom,sm8550-gcc",
+		.data = (ulong)&sm8550_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sm8550) = {
+	.name		= "gcc_sm8550",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sm8550_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+/* TCSRCC */
+
+static const struct gate_clk sm8550_tcsr_clks[] = {
+	GATE_CLK(TCSR_PCIE_0_CLKREF_EN,		0x15100, BIT(0)),
+	GATE_CLK(TCSR_PCIE_1_CLKREF_EN,		0x15114, BIT(0)),
+	GATE_CLK(TCSR_UFS_CLKREF_EN,		0x15110, BIT(0)),
+	GATE_CLK(TCSR_UFS_PAD_CLKREF_EN,	0x15104, BIT(0)),
+	GATE_CLK(TCSR_USB2_CLKREF_EN,		0x15118, BIT(0)),
+	GATE_CLK(TCSR_USB3_CLKREF_EN,		0x15108, BIT(0)),
+};
+
+static struct msm_clk_data sm8550_tcsrcc_data = {
+	.clks = sm8550_tcsr_clks,
+	.num_clks = ARRAY_SIZE(sm8550_tcsr_clks),
+};
+
+static int tcsrcc_sm8550_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static ulong tcsrcc_sm8550_clk_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int tcsrcc_sm8550_clk_probe(struct udevice *dev)
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
+static struct clk_ops tcsrcc_sm8550_clk_ops = {
+	.enable = tcsrcc_sm8550_clk_enable,
+	.get_rate = tcsrcc_sm8550_clk_get_rate,
+};
+
+static const struct udevice_id tcsrcc_sm8550_of_match[] = {
+	{
+		.compatible = "qcom,sm8550-tcsr",
+		.data = (ulong)&sm8550_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(tcsrcc_sm8550) = {
+	.name		= "tcsrcc_sm8550",
+	.id		= UCLASS_CLK,
+	.of_match	= tcsrcc_sm8550_of_match,
+	.ops		= &tcsrcc_sm8550_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= tcsrcc_sm8550_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

