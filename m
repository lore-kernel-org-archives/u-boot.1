Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C3CAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834C7836A7;
	Wed, 17 Sep 2025 18:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="i0h4OveA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32E780C93; Wed, 17 Sep 2025 14:47:52 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DB58354B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b07e3a77b72so131684766b.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113270; x=1758718070; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3uqagii7EbdvgpChhJMMSmGvZH7VzpNhR1tu/Q8qEyo=;
 b=i0h4OveAVee3Xe6KwCjNWSUAGpHKGWY0DS5LGwiIQc1G3C291bla1k7ETaP1A4X/8P
 KMMQjN9j5Ijmvm1lC8fuG8WX7xIiGZEMUoK+0B6K+FR7VZNg+SMilZormoGnUgmhPTIy
 AYQfrRki5+TO6sD0vTqHjtH2bVrvWvG9RvLGeHWkY/Pjs5GfhBx5LheZm5FtLwV1G1Jw
 dcO3HXQemvM4AYVHNgr2/gd/Gkj76NIfCQmDTdNHkJsaWexynwUg7PDO09tFJaY71Z27
 F16FZVJo/K+5rlD233foFrnM0BzjTMNxgA9oGZ8wmQkyv2pP9KvTp9+vvh8sA/E57O+3
 Q+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113270; x=1758718070;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uqagii7EbdvgpChhJMMSmGvZH7VzpNhR1tu/Q8qEyo=;
 b=ki+00/nY2Vi4hPf55V52yFd/xepkeCq/P5jk08MmqtAz/9JAGpXRR4gFSaLPx/7T6W
 jZyvHEoWlkZeq4E5k9QVCElPgSmYVxmiaiCQ36W0u28ZLGJpBCc8HMAqYDVCCPqJpgE6
 qGEO3K7UqGCCzj41qR3UoLt+ek3b+OQOLprWnzWUjbkdvtk9ZXaSguL8Nxfzg4Tl9zrO
 6NKe7bHVpndjvWj3Elenb/MlupWIQveGqW/S+6HZbjiSy5cCs53F8WDHScOwP+Zjc8FQ
 5eGKkOh3iZR6Yim5NRVSihNYtI56TeD7cSv5o2+gc14aqeR1sBfNh5BuyJ8lHeqFEs04
 wilw==
X-Gm-Message-State: AOJu0YyaxtOKBMhboPkpZ8uozZVdqeLjW2ABBRHe7M9FrDxhyE822lAS
 0+4Nudw2/pe+RgxFRY/EINtdY8p6xnovi6dH+xd1+3cI469fjOcvUllOaZCN/JImP/k=
X-Gm-Gg: ASbGnctlxPTGas+a0eLRjwTmk44EYfoJW8WQjpkcS52Qgue922msy6nm/LoxsdPVr/U
 he3gqH9TEJ/0CUat00ifmQNVXkrzkVgC2iXBcRIqavTl5NoiXCQHG90M5EUsvD5sygjvQN7q+fP
 di0dt2OEPNYy2yKMr36ZwY+Z9hGqt2T1wGamgep5+qMpPAbVcfBC+QotJ+I/1dWT+s4vbI+oHm9
 FZcV5xX9AXzFRLaZpto04ecMU5Aj/NvQk+u3Gd8dT3uE8n3KOywIHPAamVG2+kFJqU87HaYmGrs
 9DIvotlJptj+jlZs0+AzjDK93A2/JUQ9x8xCxaHoNRSl5kUyRRIXIAtyRfi1PmjZ7s6uLBqSmsr
 xTOZdlaPChuW2ZUVCbaK/xms641OZx9Qs4IVYEEYxJegc5Kc4HNX9fM613Bj/9WIASpoUujy5j8
 RPp2+U
X-Google-Smtp-Source: AGHT+IEGs5ut+xqyqxCEBUoLIqa8icA997Ka06mlTYgSRUypCJCpLlc/jEuaytDnFgE93CBu+GKpsQ==
X-Received: by 2002:a17:907:d8f:b0:b04:38f2:9060 with SMTP id
 a640c23a62f3a-b1beac69edamr248259366b.18.1758113269999; 
 Wed, 17 Sep 2025 05:47:49 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:34 +0200
Subject: [PATCH v2 1/9] clk/qcom: Add SM6350 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-1-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=8749;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=/RlLoqn2HVjdRKTTSQMc7GPebn43NAhNOg6cexr7qk0=;
 b=nJD5D2CxG/HXjgC4kdIEpEfUjIlON0ueAopc0xW5Pn/ZCoU2vc3jSNerQ3yGm5T3vEHm0DWjv
 alfyhy5lZEuATAyRXLPUhIAGuovL/88MAPFP5lmLKT61FVNrtRQR4rL
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sm6350.c | 193 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 34e41461e72cf7135a0ab79bc15a573383ace5f1..347d16de3db51cafec580af322e232a39ee8caac 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -103,6 +103,14 @@ config CLK_QCOM_SM6115
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
index b3d95b0faa3011372a0aeecabeb6ee8da2be6233..a85c77ad1e7baef131202888cdbd569e6e38f4a9 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
 obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
 obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
 obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/clock-sm6350.c
new file mode 100644
index 0000000000000000000000000000000000000000..ee6653848c7b92d0d116a5a8db22e2effd319114
--- /dev/null
+++ b/drivers/clk/qcom/clock-sm6350.c
@@ -0,0 +1,193 @@
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
2.51.0

