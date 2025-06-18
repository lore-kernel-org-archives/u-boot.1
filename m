Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4113BC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC7C82D32;
	Wed, 18 Jun 2025 16:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="y8W/PxtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962FA82D83; Wed, 18 Jun 2025 16:25:33 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE9182C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so1273957666b.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256730; x=1750861530; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AxZvMvBoGN6mnrSfEtRBpHB1UGk25bATkSRIix9nsno=;
 b=y8W/PxtM5l1ZO21zqAi1P16OA+s1qZotivO9L7Z0+pWgTNXJ+XqIlcsTr1KG7270Xu
 8qLNqUlFSwvzi26yOMQm8UoEYXoM6q7CEa6qFxluUVgjzdwK6jmVzDPAKEB5rejCpPsi
 zKZ1aqED2zrDIeBuAF7ZH3p3ocpT614M42Dg2lEYH6tMpb6E67sm+bbKgEfDIcHU2wYL
 nS3A4q2IC6+kDtfa2VA6tlH7T4DlZpPTv/3DTykotW0EFjGPYIBeVFOtx6ZJgLd4ETF9
 q4iUrjXfVuSEveqwuewp9QPdwWYiBFQVP/nW87SPN1kni66O0Z9v4cCbMccJhLOWvtyx
 G4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256730; x=1750861530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxZvMvBoGN6mnrSfEtRBpHB1UGk25bATkSRIix9nsno=;
 b=B0yX5VTp6IlfQjYCLiP97s9Knr+IoJ3u/VElGCw0CBae1ggTui5FDw8F/1lQ05VE/u
 WjsroYWC5GdtGFI2yS1bRfKGT6yr+AgzevSNsPDDE4Dmgq8ykR1wp/BIOi6/gYRTHNQp
 YoqWf4VAnB99V75IABufMnRKiVYJlgEKQzOzWWVBW3aRodomkdc0EITIeb7dWqDztgnE
 ajKEVvHo8GeM1djbWw1TQ6jazQ2ofpqc2yL8jHMNKPhh9d8ek4+lAk+lg0UcCv7gKp/k
 Qpm5v7Xj1nTITT6I+JG76NexTcfBQU/aupAyH4NToH1efiXwiOa6yVN/Fl7G2dCcG10+
 IIhQ==
X-Gm-Message-State: AOJu0YwrfubbWR1iycCliotdBCh/BGyY1a3llmrQdimMZTbbjPmRWOV/
 35mdqOaLPJsjw3ivGDbVnM5IQurGujRFHXnA2KswAPSbWSg/PHum+K3vYA5ivdHNfKg=
X-Gm-Gg: ASbGncuaycPNQVSJaDS1my8iPZvqsyE0xu5WOKz0Z65vsUk6hvjPvv8y2j8EJRDt2Vh
 QsPwMQzwoLuKHy+yLzQQ3aAYcTUUQprjW2/LLltS0YmH+uG4KqLsfapGSgOXfdANTnfWoeLEEzW
 KwPNlNgAw9xEaJkOmnx2SJPpF1k6LqDCmFRcjGqk6a3ndGi7icQI0xxuVWigF5pcjT54gHcHfjb
 GL7TTNsb4LyLzBcLyTJvDZ2RDPFFP/jgT74nGripQ1Kju58DKdsRPxQbLDVBF5cfnEXwkiiTH5Y
 WvKg/XnHEwljUVEsCMdqHuXn6uE1nLYd+W85HJuOB66Yo5QCdlqiF2rSPuei/Rd5Txtm4ibiKOw
 4IxR7trpq1+7jGl4YuO2K8ECMXt+ieY+O
X-Google-Smtp-Source: AGHT+IHulR2KDrGblqSAcHb5RLYVZqpSt7g9iSKRw+KIPguVaP2eADnbuWt4pqXiROGq0vTM4Az6ww==
X-Received: by 2002:a17:907:728b:b0:ad8:9a3b:b26e with SMTP id
 a640c23a62f3a-adfad50a3a5mr1805989466b.56.1750256729428; 
 Wed, 18 Jun 2025 07:25:29 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:29 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:17 +0200
Subject: [PATCH 1/8] clk/qcom: Add SM6350 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=8688;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=pWTwoJl79TAlLaIlzwI52h/39q7gQudueDP5NJrTj9o=;
 b=dvl1eungw+rqmVGZ4g40dld9LcSNKu+0uRa+uymgD+Uaj/Y6EbtecC8X+r6paTqVT3Jd82nl1
 +0iW8AzkF6bB0V0wT4jKno50lmITTBrknXI1aN5ToA4QU5dCbbidC66
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

Add Clock driver for the GCC block found in the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sm6350.c | 194 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c969a3456a7c2ebf731b8b74b66d93f96..e0e91dadd854e6e3a7beb1ef351734a5ab77787f 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -79,6 +79,14 @@ config CLK_QCOM_SM6115
 	  on the Snapdragon SM6115 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SM6350
+	bool "Qualcomm SM6350 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SM6350 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SM8150
 	bool "Qualcomm SM8150 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e13fc8c107176000e14e3a2c56fcd25dac8b9df4..5807caa7e040cb3ea494943b1077a50e684b88f4 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
 obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
 obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/clock-sm6350.c
new file mode 100644
index 0000000000000000000000000000000000000000..2218d81f1532b38f9b9759dc4d1304504657439a
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm6350.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm sm6350
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sm6350.h>
+
+#include "clock-qcom.h"
+
+#undef CFG_CLK_SRC_GPLL0_ODD
+#define CFG_CLK_SRC_GPLL0_ODD (2 << 8)
+#define CFG_CLK_SRC_GPLL6_EVEN (2 << 8)
+
+#define GCC_SE12_UART_RCG_REG 0x223a8
+#define GCC_SDCC2_APPS_CLK_SRC_REG 0x2000c
+
+#define APCS_GPLL7_STATUS 0x7000
+#define APCS_GPLLX_ENA_REG 0x52010
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
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6_EVEN, 3, 0, 0),
+	{}
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_ODD, 8, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_ODD, 4, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_ODD, 2, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	{}
+};
+
+static struct pll_vote_clk gpll7_vote_clk = {
+	.status = APCS_GPLL7_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = APCS_GPLLX_ENA_REG,
+	.vote_bit = BIT(7),
+};
+
+static ulong sm6350_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S3_CLK: /*UART9*/
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     16);
+
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		/* Enable GPLL7 so that we can point SDCC2_APPS_CLK_SRC at it */
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		printf("%s: got freq %u\n", __func__, freq->freq);
+		WARN(freq->src != CFG_CLK_SRC_GPLL7,
+		     "SDCC2_APPS_CLK_SRC not set to GPLL7, requested rate %lu\n",
+		     rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_SRC_REG,
+				     freq->pre_div, freq->m, freq->n,
+				     CFG_CLK_SRC_GPLL7, 8);
+
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sm6350_clks[] = {
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x3e014, 0x00000001),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x3e010, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1101c, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x52000, 0x00800000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x52000, 0x00040000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x52000, 0x00080000),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x20008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x20004, 0x00000001),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x3a00c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x3a034, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x3a0a4, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x3a0ac, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x3a014, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x3a018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x3a010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x3a09c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a00c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c010, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1a050, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, 0x00000001),
+};
+
+static int sm6350_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, sm6350_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	}
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map sm6350_gcc_resets[] = {
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1d000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x1e000 },
+	[GCC_SDCC1_BCR] = { 0x4b000 },
+	[GCC_SDCC2_BCR] = { 0x20000 },
+	[GCC_UFS_PHY_BCR] = { 0x3a000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x1c008 },
+};
+
+static const struct qcom_power_map sm6350_gdscs[] = {
+	[USB30_PRIM_GDSC] = { 0x1a004 },
+	[UFS_PHY_GDSC] = { 0x3a004 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0xb7040 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0xb7044 },
+};
+
+static struct msm_clk_data sm6350_gcc_data = {
+	.resets = sm6350_gcc_resets,
+	.num_resets = ARRAY_SIZE(sm6350_gcc_resets),
+	.clks = sm6350_clks,
+	.num_clks = ARRAY_SIZE(sm6350_clks),
+	.power_domains = sm6350_gdscs,
+	.num_power_domains = ARRAY_SIZE(sm6350_gdscs),
+
+	.enable = sm6350_enable,
+	.set_rate = sm6350_set_rate,
+};
+
+static const struct udevice_id gcc_sm6350_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sm6350",
+		.data = (ulong)&sm6350_gcc_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_sm6350) = {
+	.name = "gcc_sm6350",
+	.id = UCLASS_NOP,
+	.of_match = gcc_sm6350_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.50.0

