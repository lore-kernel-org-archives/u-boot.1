Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F250CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B66087B89;
	Mon,  8 Apr 2024 15:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qdcjG3Kk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C0187A80; Mon,  8 Apr 2024 15:07:19 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41466875E9
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so474312a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712581637; x=1713186437; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fXjsBy0pcBjWlichBxHZiLe7dfuI2wIzWhGL+rcrZlQ=;
 b=qdcjG3Kkdh81MJg/shnPYEZQ4pPCDvXv5QzHWogh9IbtM+smNbK6Lq/qSJ7/GWaEcG
 Sg1WAZoFmD+ozq/Aa3ALK6WAxi1gPikDZouR/AsB4JoVaNj7HOuKGV+M3YCuo6fwcwE9
 XSzleJYeBb4EHDBul8mVN7d7dwRyPBcynnhbzRUyWmhYSpjPi2wlHyg0OSKBDBP6QIgS
 MaZoWpjZxYOjvgiFYHskjql7dpFkZKeXwQYd0u+BK+oc8aF+uiQYWqTmsHyxfQY2AABn
 1S7irh0DItrKrildQPhvmys/9gxmSG6RHa25/nX5EG8dNtZnxpRuRV2vB/eJ8Rs1rXsl
 P5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581637; x=1713186437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXjsBy0pcBjWlichBxHZiLe7dfuI2wIzWhGL+rcrZlQ=;
 b=GJephs9c1AlOqeB2uZH7Im7KCEQZrKrfszt57yE7JpO13GZ8sVImB9Rx1r8MBewUem
 y3Fn+XJ1USeW6vqvXKNTHVHeuylSg0ASHSLh0DE6ZarLPJ6udF19QN04lB7mhPb//zPl
 tM8EuiYpa6bMcoSjH72t5dwx3ZOs7BOxRJ4TBM6SWmYediWdo8y3T9MX14+CVOZq4Vxg
 Vbvie1EIhcV1i0isCLk+jKOjjouLpOXOxCNxfrzrJv5/QaMdVZQUcUSiwMKCvqPNkjUM
 927oadX1NXfpRan1b5RBwiDldnBM0LbqmTlsbDY+7+EnS3pmSzT1gmAsQDGOP6ZFZW9x
 3XCQ==
X-Gm-Message-State: AOJu0YyfKZ6eieXcXra0D60cNtcPjDJk5AaGNmPEgnsmgdMpMAPRhYsF
 PmfGLctmW+xnsbVFQLK5R0SIVk307xJm4E4u+aNYpiZ9VW1SnUmMBIUEwHjZjVc=
X-Google-Smtp-Source: AGHT+IFED1rlZTATzfulQmYs6MUyQ2HIr6epOh31hyI+ZLnB1D2LV3jl8kMtZjB36f9VLzcNayq+rA==
X-Received: by 2002:a17:906:3086:b0:a4e:66d6:8a0e with SMTP id
 6-20020a170906308600b00a4e66d68a0emr6697904ejv.58.1712581636717; 
 Mon, 08 Apr 2024 06:07:16 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906338a00b00a51ce37a708sm1998981eja.94.2024.04.08.06.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 06:07:16 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Apr 2024 15:06:50 +0200
Subject: [PATCH 2/4] clk/qcom: add driver for sm6115 GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-b4-qcom-rbx-soc-v1-2-2db1d3658660@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8829;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=o2MRdHJ5bTepPpeA7u2wT9aicRLbaAjk1cD2R2ZPXwk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmE+wB/ZkqgJ8vHUUMMpx9mkp3kuo8ecGNGu2vT
 dMZtP99BaGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhPsAQAKCRAFgzErGV9k
 tpNpD/48N4BmD6X91rPfRQghJaw3gaTiFURorql/NgyI1la9HhWXy9yG/qHgKVguPIgJS2QgnKh
 A33mKLvbBqGWft2futVKV5AaxgQBklbwDgJUxBrVynCtV+Ir/OQUg/nQCaga/XsGJj4kkaDu/hP
 bB6h34zNb62wmA0l27HWN9w8KKibynrIrDQVbB6M9dRfDprBOu9+K+30L+o8cdJrwYQ4t9sH6q9
 05k3X28lTdMECgaJ2WZtdK4HxTeLBYQZ20E9kdDuVkwA/EGWcjtPQDcJy2/Uiwsv72WYDOL+9uk
 +J9s49+DSFk9EZrpO3k9uotk0exuvPXh/fcKGILGdFHPFz5AbznjjrD/KEtEIq7SXYs15iVeqRK
 P7rrvINEht8kqUiwVwTVPXwS1lR/3ppPRmxrzHnuS7esgY/0A2Ssk/yLkevpxh9+8Gwmv4buXnq
 o/Zi9rEm8OG0HW5fcflFABD6P0ktooisSLLm+1r6lX08jGBo+3anf4tra6pI3ecXSHYjvaUeQKh
 r3Iqg/rtpS4miyVXXUKfIBJnGlZOtU7KOsQtVavA+ytuvg1FsQUFZ5k0g68WwKHL+chiiXD3rsA
 Oqf0vKf9/CDcS9T1tFA5/9tlEuOpc4aqqd84n+HA2PjWswDNxnumHJ7bV0+jaudCUx8yiNSka+I
 Q/ZOMyXHq9qMeHA==
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

Add a driver for the clock controller in the SM6115 SoC, this is used in
the QRB4210 RB2 board.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sm6115.c | 199 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index d7dfe4c0d5fc..6afa62e19879 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -54,7 +54,15 @@ config CLK_QCOM_SDM845
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon 845 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SM6115 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 83aa8a920348..d38c5a9fb849 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
 obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/clock-sm6115.c
new file mode 100644
index 000000000000..8314a0deb348
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm6115.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm sm6115 (and sm4250/qrb4210)
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <dt-bindings/clock/qcom,gcc-sm6115.h>
+
+#include "clock-qcom.h"
+
+#define QUPV3_WRAP0_S4_CMD_RCGR 0x1f608
+#define SDCC1_APPS_CLK_CMD_RCGR 0x38028
+#define SDCC2_APPS_CLK_CMD_RCGR 0x1e00c
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{}
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	{}
+};
+
+static const struct pll_vote_clk gpll0_clk = {
+	.status = 0,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(0),
+};
+
+static const struct gate_clk sm6115_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a084, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x7900c, 0x00000200),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_CLK, 0x7900c, 0x00000100),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x7900c, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x7900c, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x7900c, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x7900c, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x7900c, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x7900c, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x7900c, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x7900c, 0x00000080),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x38008, 0x00000001),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x38004, 0x00000001),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, 0x00000001),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x1e008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x1e004, 0x00000001),
+	GATE_CLK(GCC_SYS_NOC_CPUSS_AHB_CLK, 0x79004, 0x00000001),
+	GATE_CLK(GCC_SYS_NOC_UFS_PHY_AXI_CLK, 0x45098, 0x00000001),
+	GATE_CLK(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a080, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x45014, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x45010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x45044, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x45078, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x4501c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x45018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x45040, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x9f000, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, 0x00000001),
+	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, 0x00000001),
+	GATE_CLK(GCC_UFS_CLKREF_CLK, 0x8c000, 0x00000001),
+};
+
+static ulong sm6115_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	debug("%s: clk %s rate %lu\n", __func__, sm6115_clks[clk->id].name,
+	      rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S4_CLK: /*UART2*/
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     16);
+		return 0;
+	case GCC_SDCC2_APPS_CLK:
+		/* Enable GPLL7 so we can point SDCC2_APPS_CLK_SRC RCG at it */
+		clk_enable_gpll0(priv->base, &gpll0_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		WARN(freq->src != CFG_CLK_SRC_GPLL0,
+		     "SDCC2_APPS_CLK_SRC not set to GPLL0, requested rate %lu\n",
+		     rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     8);
+		return freq->freq;
+	case GCC_SDCC1_APPS_CLK:
+		/* The firmware turns this on for us and always sets it to this rate */
+		return 384000000;
+	default:
+		return rate;
+	}
+}
+
+static int sm6115_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, sm6115_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sm6115_gcc_resets[] = {
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x1c004 },
+	[GCC_SDCC1_BCR] = { 0x38000 },
+	[GCC_SDCC2_BCR] = { 0x1e000 },
+	[GCC_UFS_PHY_BCR] = { 0x45000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
+	[GCC_VCODEC0_BCR] = { 0x58094 },
+	[GCC_VENUS_BCR] = { 0x58078 },
+	[GCC_VIDEO_INTERFACE_BCR] = { 0x6e000 },
+};
+
+static const struct qcom_power_map sm6115_gdscs[] = {
+	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
+};
+
+static struct msm_clk_data sm6115_gcc_data = {
+	.resets = sm6115_gcc_resets,
+	.num_resets = ARRAY_SIZE(sm6115_gcc_resets),
+	.clks = sm6115_clks,
+	.num_clks = ARRAY_SIZE(sm6115_clks),
+	.power_domains = sm6115_gdscs,
+	.num_power_domains = ARRAY_SIZE(sm6115_gdscs),
+
+	.enable = sm6115_enable,
+	.set_rate = sm6115_set_rate,
+};
+
+static const struct udevice_id gcc_sm6115_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sm6115",
+		.data = (ulong)&sm6115_gcc_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_sm6115) = {
+	.name = "gcc_sm6115",
+	.id = UCLASS_NOP,
+	.of_match = gcc_sm6115_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.44.0

