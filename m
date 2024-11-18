Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A708D4921D
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680DB8946D;
	Mon, 18 Nov 2024 15:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d9aq5FUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A371388D61; Mon, 18 Nov 2024 15:42:08 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6634389474
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43193678216so39350945e9.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940924; x=1732545724; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K81RfnTz7Jtw5NTlpf2tRB/xR47ro2+2dJNWT5cvRUE=;
 b=d9aq5FUSFdxI2hwN+mKeWIqLydbLoUinp01PWR5dABTuuuQxqOtIPWZiaEDa6OSseI
 BYuvYj0e8OEtarTRQbQN2jrO+OfK9cEvaVY1eTrOzgOsmLvLI5LE+AGGhkeBZzl0EF0M
 e8KOHUDu2XxlopbnRTg7R4XzWAm7+wWq8+iIuuZ0a4K3QjzUFrIODOz+COG9UPV6ITnE
 E/rbcrbxiF03h8elkp77BJsNaDW9t2coxgmCv4NZrRvNO34MjbZcHAUL0ZfkdTC4HTZ8
 XjlZaiDfXwgzSH0odGINDk1DKO42TffLuiTsp/cXRlYIsB0j7V7UQ3ZKLODqISGKMcQr
 qrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940924; x=1732545724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K81RfnTz7Jtw5NTlpf2tRB/xR47ro2+2dJNWT5cvRUE=;
 b=c5angHc1hWKhOaGxQXmzuvYy0XOGq7ACK47w1ARIJhHUoLx/oS285RNQbiK8Avi4NK
 40c/OJs6EjICbGBt5pJs7MqFEL+d6gyUbbuy4yUU457fQKyuwP/pkHYbkKzyXM7PKyy0
 PMLFqp/Fy8tcFhq0ZddrnsFeokq65U/DfyvNfPvBn10d4lmWkjLvWGtBX1SDaKfVZ9Uv
 F0ORIXQ+aMlzecLfpS2JugmlxVCbUoRQPlaHl7yGBx+PxF9GbQMjbDNeNRhdBgHzGYCj
 c6pfEC06757mYmigHsAmKpfW6iFWCamLzLdjgNbq5lWvvolBgFvqBy0MNzftBzRhroy4
 gTdg==
X-Gm-Message-State: AOJu0YwUROvzeZJbhzoZCDzCHhzxFz5x+Zpi1kbA/ZjJPIHLfZnKs5sE
 +3Xzkx1+hC+UZpbZfXeVkHsp7raPo1GXjlU/dnDJrF0fbEXqMDTXZbyCYsf3j4w=
X-Google-Smtp-Source: AGHT+IE3amw95KpjGcsxpjMiY7xTXUOGVArfxZx1m3EpSoSDvL19s8kSg2atZEJKmlu7erXd34iWng==
X-Received: by 2002:a05:600c:5124:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-432df72a7cemr111327585e9.14.1731940923794; 
 Mon, 18 Nov 2024 06:42:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab788e1sm156906495e9.15.2024.11.18.06.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:42:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Nov 2024 15:42:00 +0100
Subject: [PATCH 1/2] clk: qcom: Add X1E80100 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-topic-x1e80100-clk-v1-1-8841e87ad81f@linaro.org>
References: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
In-Reply-To: <20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14115;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HaZ5OgEYzMFj0ZdDTNl6fM2X3OoN1qQZZD8g3xtYo3Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnO1I5+sHW/jiZ6P1IAP7UQp65jDwuEwfSUTPUdO5h
 U5mJ3KOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZztSOQAKCRB33NvayMhJ0a2CD/
 0aJOhWYCcByNDtsMMxnGqqt1F1IeWY4OBVwFhachWVGo6uxivatOBqRbzz6hgyBEf9lNILyDw1dbBv
 l1zUcc+5V0VZeUfi54P0b1HI56QcDPSEBNT0eVvtXaE4CX6UAVzNF4ufOILaSN99S8cxUGESpKnfx9
 1rfMFibMdj2+apjcH0/NVYbV+qKl50K3x8aD+zs2ssUFn09a93mfFa9K3logp9QXb2XUFOwLr/5Mml
 NW0FkDgspTR2w80OjMwjvtBR5BoA2iLKZnDJ15I7r7y4R/bRSsE60RvnadXqXSRV6jqATbUQuX+hDE
 qAU0ZWXGPuw+qwX8fnMEK/5xQPzly0FG38uWc9HGegWGqCvgvjsnBI7fogP8Qtk5XHpogChju6LAKV
 A8mFt9Do6l46sYXMQHe7EPHMM+gitlDV77FcnGDFmwcdWYBLFB6lWbfigjnycAbXsZo0cXoX1/XgXo
 uMq1UjLS5QoJQcc0L/fhQBmDxVuOgBHpiYnR9D+sQPESTIJ9cj6S9ezroM1gYy2sAi6ldWCHuuKBhR
 StbA0JgIwEuyeAMU0oSLTEXQRreqrVRKVECpIlfb69Gv4omowkREoHh+V6KdxfjusyZDBgs26+3d9r
 WkJOZR1vKR0P14p3WnPgnVQwn/W4lQ4VlZXUVpBHZHoprZhsWxz17NIaqGYg==
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

Add Clock driver for the GCC block found in the X1E80100 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/Kconfig          |   8 +
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/clock-x1e80100.c | 348 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d76fca5dba41312561406f8193fa45c59fb06dd9..c69eb7d11679a3b7c65a5e69d2b4aef04fc9f8e1 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -103,6 +103,14 @@ config CLK_QCOM_SC7280
 	  on the Snapdragon SC7280 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon X1E80100 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ab33f1c5faf987f1dd2f66eead56921a4eee5396..0189e053f23cbce190b5dd3649640cba1f25b8ec 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
 obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
 obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
new file mode 100644
index 0000000000000000000000000000000000000000..6bcd705f6c8d40dc477c55fe1f594df70e1187ad
--- /dev/null
+++ b/drivers/clk/qcom/clock-x1e80100.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm x1e80100
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
+#include <dt-bindings/clock/qcom,x1e80100-gcc.h>
+#include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
+
+#include "clock-qcom.h"
+
+/* On-board TCXO, TOFIX get from DT */
+#define TCXO_RATE	38400000
+
+/* bi_tcxo_div2 divided after RPMh output */
+#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s4_clk_src[] = {
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
+static ulong x1e80100_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP2_S5_CLK: /* UART21 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s4_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x1e500,
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
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk x1e80100_clks[] = {
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
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
+	GATE_CLK(GCC_QUPV3_WRAP_2_M_AHB_CLK,		0x52010, BIT(2)),
+	GATE_CLK(GCC_QUPV3_WRAP_2_S_AHB_CLK,		0x52010, BIT(1)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x39018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x39028, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x39024, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x39060, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x39064, BIT(0)),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x39068, BIT(0)),
+};
+
+static int x1e80100_enable(struct clk *clk)
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
+static const struct qcom_reset_map x1e80100_gcc_resets[] = {
+	[GCC_AV1E_BCR] = { 0x4a000 },
+	[GCC_CAMERA_BCR] = { 0x26000 },
+	[GCC_DISPLAY_BCR] = { 0x27000 },
+	[GCC_GPU_BCR] = { 0x71000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
+	[GCC_PCIE_0_TUNNEL_BCR] = { 0xa0000 },
+	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0x8e014 },
+	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0x8e020 },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0x8e024 },
+	[GCC_PCIE_1_TUNNEL_BCR] = { 0x2c000 },
+	[GCC_PCIE_2_LINK_DOWN_BCR] = { 0xa5014 },
+	[GCC_PCIE_2_NOCSR_COM_PHY_BCR] = { 0xa5020 },
+	[GCC_PCIE_2_PHY_BCR] = { 0xa501c },
+	[GCC_PCIE_2_PHY_NOCSR_COM_PHY_BCR] = { 0xa5028 },
+	[GCC_PCIE_2_TUNNEL_BCR] = { 0x13000 },
+	[GCC_PCIE_3_BCR] = { 0x58000 },
+	[GCC_PCIE_3_LINK_DOWN_BCR] = { 0xab014 },
+	[GCC_PCIE_3_NOCSR_COM_PHY_BCR] = { 0xab020 },
+	[GCC_PCIE_3_PHY_BCR] = { 0xab01c },
+	[GCC_PCIE_3_PHY_NOCSR_COM_PHY_BCR] = { 0xab024 },
+	[GCC_PCIE_4_BCR] = { 0x6b000 },
+	[GCC_PCIE_4_LINK_DOWN_BCR] = { 0xb3014 },
+	[GCC_PCIE_4_NOCSR_COM_PHY_BCR] = { 0xb3020 },
+	[GCC_PCIE_4_PHY_BCR] = { 0xb301c },
+	[GCC_PCIE_4_PHY_NOCSR_COM_PHY_BCR] = { 0xb3028 },
+	[GCC_PCIE_5_BCR] = { 0x2f000 },
+	[GCC_PCIE_5_LINK_DOWN_BCR] = { 0xaa014 },
+	[GCC_PCIE_5_NOCSR_COM_PHY_BCR] = { 0xaa020 },
+	[GCC_PCIE_5_PHY_BCR] = { 0xaa01c },
+	[GCC_PCIE_5_PHY_NOCSR_COM_PHY_BCR] = { 0xaa028 },
+	[GCC_PCIE_6A_BCR] = { 0x31000 },
+	[GCC_PCIE_6A_LINK_DOWN_BCR] = { 0xac014 },
+	[GCC_PCIE_6A_NOCSR_COM_PHY_BCR] = { 0xac020 },
+	[GCC_PCIE_6A_PHY_BCR] = { 0xac01c },
+	[GCC_PCIE_6A_PHY_NOCSR_COM_PHY_BCR] = { 0xac024 },
+	[GCC_PCIE_6B_BCR] = { 0x8d000 },
+	[GCC_PCIE_6B_LINK_DOWN_BCR] = { 0xb5014 },
+	[GCC_PCIE_6B_NOCSR_COM_PHY_BCR] = { 0xb5020 },
+	[GCC_PCIE_6B_PHY_BCR] = { 0xb501c },
+	[GCC_PCIE_6B_PHY_NOCSR_COM_PHY_BCR] = { 0xb5024 },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x6f00c },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
+	[GCC_PCIE_RSCC_BCR] = { 0xa4000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x42000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
+	[GCC_QUSB2PHY_HS0_MP_BCR] = { 0x1200c },
+	[GCC_QUSB2PHY_HS1_MP_BCR] = { 0x12010 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_QUSB2PHY_TERT_BCR] = { 0x12008 },
+	[GCC_QUSB2PHY_USB20_HS_BCR] = { 0x12014 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB20_PRIM_BCR] = { 0x29000 },
+	[GCC_USB30_MP_BCR] = { 0x17000 },
+	[GCC_USB30_PRIM_BCR] = { 0x39000 },
+	[GCC_USB30_SEC_BCR] = { 0xa1000 },
+	[GCC_USB30_TERT_BCR] = { 0xa2000 },
+	[GCC_USB3_MP_SS0_PHY_BCR] = { 0x19008 },
+	[GCC_USB3_MP_SS1_PHY_BCR] = { 0x54008 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x2a000 },
+	[GCC_USB3_PHY_TERT_BCR] = { 0xa3000 },
+	[GCC_USB3_UNIPHY_MP0_BCR] = { 0x19000 },
+	[GCC_USB3_UNIPHY_MP1_BCR] = { 0x54000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x2a004 },
+	[GCC_USB3PHY_PHY_TERT_BCR] = { 0xa3004 },
+	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x19004 },
+	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x54004 },
+	[GCC_USB4_0_BCR] = { 0x9f000 },
+	[GCC_USB4_0_DP0_PHY_PRIM_BCR] = { 0x50010 },
+	[GCC_USB4_1_DP0_PHY_SEC_BCR] = { 0x2a010 },
+	[GCC_USB4_2_DP0_PHY_TERT_BCR] = { 0xa3010 },
+	[GCC_USB4_1_BCR] = { 0x2b000 },
+	[GCC_USB4_2_BCR] = { 0x11000 },
+	[GCC_USB_0_PHY_BCR] = { 0x50020 },
+	[GCC_USB_1_PHY_BCR] = { 0x2a020 },
+	[GCC_USB_2_PHY_BCR] = { 0xa3020 },
+	[GCC_VIDEO_BCR] = { 0x32000 },
+};
+
+static const struct qcom_power_map x1e80100_gdscs[] = {
+	[GCC_PCIE_0_TUNNEL_GDSC] = { 0xa0004 },
+	[GCC_PCIE_1_TUNNEL_GDSC] = { 0x2c004 },
+	[GCC_PCIE_2_TUNNEL_GDSC] = { 0x13004 },
+	[GCC_PCIE_3_GDSC] = { 0x58004 },
+	[GCC_PCIE_3_PHY_GDSC] = { 0x3e000 },
+	[GCC_PCIE_4_GDSC] = { 0x6b004 },
+	[GCC_PCIE_4_PHY_GDSC] = { 0x6c000 },
+	[GCC_PCIE_5_GDSC] = { 0x2f004 },
+	[GCC_PCIE_5_PHY_GDSC] = { 0x30000 },
+	[GCC_PCIE_6_PHY_GDSC] = { 0x8e000 },
+	[GCC_PCIE_6A_GDSC] = { 0x31004 },
+	[GCC_PCIE_6B_GDSC] = { 0x8d004 },
+	[GCC_UFS_MEM_PHY_GDSC] = { 0x9e000 },
+	[GCC_UFS_PHY_GDSC] = { 0x77004 },
+	[GCC_USB20_PRIM_GDSC] = { 0x29004 },
+	[GCC_USB30_MP_GDSC] = { 0x17004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x39004 },
+	[GCC_USB30_SEC_GDSC] = { 0xa1004 },
+	[GCC_USB30_TERT_GDSC] = { 0xa2004 },
+	[GCC_USB3_MP_SS0_PHY_GDSC] = { 0x1900c },
+	[GCC_USB3_MP_SS1_PHY_GDSC] = { 0x5400c },
+	[GCC_USB4_0_GDSC] = { 0x9f004 },
+	[GCC_USB4_1_GDSC] = { 0x2b004 },
+	[GCC_USB4_2_GDSC] = { 0x11004 },
+	[GCC_USB_0_PHY_GDSC] = { 0x50024 },
+	[GCC_USB_1_PHY_GDSC] = { 0x2a024 },
+	[GCC_USB_2_PHY_GDSC] = { 0xa3024 },
+};
+
+static struct msm_clk_data x1e80100_gcc_data = {
+	.resets = x1e80100_gcc_resets,
+	.num_resets = ARRAY_SIZE(x1e80100_gcc_resets),
+	.clks = x1e80100_clks,
+	.num_clks = ARRAY_SIZE(x1e80100_clks),
+	.power_domains = x1e80100_gdscs,
+	.num_power_domains = ARRAY_SIZE(x1e80100_gdscs),
+
+	.enable = x1e80100_enable,
+	.set_rate = x1e80100_set_rate,
+};
+
+static const struct udevice_id gcc_x1e80100_of_match[] = {
+	{
+		.compatible = "qcom,x1e80100-gcc",
+		.data = (ulong)&x1e80100_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_x1e80100) = {
+	.name		= "gcc_x1e80100",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_x1e80100_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+/* TCSRCC */
+
+static const struct gate_clk x1e80100_tcsr_clks[] = {
+	GATE_CLK(TCSR_PCIE_2L_4_CLKREF_EN,	0x15100, BIT(0)),
+	GATE_CLK(TCSR_PCIE_2L_5_CLKREF_EN,	0x15104, BIT(0)),
+	GATE_CLK(TCSR_PCIE_8L_CLKREF_EN,	0x15108, BIT(0)),
+	GATE_CLK(TCSR_USB3_MP0_CLKREF_EN,	0x1510c, BIT(0)),
+	GATE_CLK(TCSR_USB3_MP1_CLKREF_EN,	0x15110, BIT(0)),
+	GATE_CLK(TCSR_USB2_1_CLKREF_EN,		0x15114, BIT(0)),
+	GATE_CLK(TCSR_UFS_PHY_CLKREF_EN,	0x15118, BIT(0)),
+	GATE_CLK(TCSR_USB4_1_CLKREF_EN,		0x15120, BIT(0)),
+	GATE_CLK(TCSR_USB4_2_CLKREF_EN,		0x15124, BIT(0)),
+	GATE_CLK(TCSR_USB2_2_CLKREF_EN,		0x15128, BIT(0)),
+	GATE_CLK(TCSR_PCIE_4L_CLKREF_EN,	0x1512c, BIT(0)),
+	GATE_CLK(TCSR_EDP_CLKREF_EN,		0x15130, BIT(0)),
+};
+
+static struct msm_clk_data x1e80100_tcsrcc_data = {
+	.clks = x1e80100_tcsr_clks,
+	.num_clks = ARRAY_SIZE(x1e80100_tcsr_clks),
+};
+
+static int tcsrcc_x1e80100_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static ulong tcsrcc_x1e80100_clk_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int tcsrcc_x1e80100_clk_probe(struct udevice *dev)
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
+static struct clk_ops tcsrcc_x1e80100_clk_ops = {
+	.enable = tcsrcc_x1e80100_clk_enable,
+	.get_rate = tcsrcc_x1e80100_clk_get_rate,
+};
+
+static const struct udevice_id tcsrcc_x1e80100_of_match[] = {
+	{
+		.compatible = "qcom,x1e80100-tcsr",
+		.data = (ulong)&x1e80100_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(tcsrcc_x1e80100) = {
+	.name		= "tcsrcc_x1e80100",
+	.id		= UCLASS_CLK,
+	.of_match	= tcsrcc_x1e80100_of_match,
+	.ops		= &tcsrcc_x1e80100_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= tcsrcc_x1e80100_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

