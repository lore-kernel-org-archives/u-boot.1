Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E24AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 22:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB9D87A02;
	Mon, 30 Oct 2023 23:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XcQJXGfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A44B87A3D; Mon, 30 Oct 2023 23:23:36 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D9487514
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 23:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso74127231fa.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698704612; x=1699309412; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A0sn4Z7K57yFWV1Xk7Rw9uRXrJoFQGRWobdd0cx7ucU=;
 b=XcQJXGfjmnTROcUBtI96io9zR397ipZAfFVfuJM0PvUi+Ht/28OBDB1zRXO+JZd5xS
 y9bpnqQkT1rAaAYPdEI8roEQZTExafH4/sf5wqp4YhuRR6W1yZSNS+4W7jYbDTGsrG1+
 ItAEGuKfPW9Q3OW0YAmez0OLOScbc4pX8W4eW7JErjQtRzQQud0GZlQwta08kF8p7Gy9
 uQkjHfWwefcglRaB3Mpg+7R53I7T5PujLjmTrxEcj4bv1BYJEJBRvsROoScYndrIwUQ4
 +XM9WqYF3UuWUUffr4xOgmNexmYGDTmQuIZVDUhS+5ViiCDN3rFbSJfbFYTbiYD7pDPy
 pKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698704612; x=1699309412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0sn4Z7K57yFWV1Xk7Rw9uRXrJoFQGRWobdd0cx7ucU=;
 b=vOCujD1uHJ+1CVfp+V6nYFQy6IZXrgZ5TJmEJ5spyrQsCavRKiqpicGKS/Gte9qMOs
 CNzlO6XH+ckPLkTNCQtRwdLs9Pzyhg5DmNLt0gl0yNj5ol6U5t8jxnFigXwg8UF5K7/C
 vDT32ZiKzZ7o2bYPwYTVpVPvTxzoaRtPIy9/CMmCnYVHQGx/5KqoTbHoiVD0bzYkFXkn
 6Ofp+CJfC+3KHqgskxS7wae7T0/S7PGpvaq110D+juWm4Ksk+O9DJIzzitDBR6Ewo1B7
 4G/oj744ivC3Of6AsAJhy+9ejVY8ElimTjssNlmqhtWHpqflFJIuukiJKK7zwRzcJdQ2
 SY9Q==
X-Gm-Message-State: AOJu0YyNwtYw+91Bm3/xLid1vpyY+txLZc8CBreVFCIjNDUE/CiKSksu
 jGKW8FSJeBqH1GJKLbu9ErDuHA==
X-Google-Smtp-Source: AGHT+IE89q7lSqzIoipCj3Otw4Xmp2gYB4nesmd81prNP12QybgBUEETh4l9q0z3JrJDauM6eMI98A==
X-Received: by 2002:a2e:7e0e:0:b0:2c0:34ed:b5ea with SMTP id
 z14-20020a2e7e0e000000b002c034edb5eamr7898997ljc.45.1698704612130; 
 Mon, 30 Oct 2023 15:23:32 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c465400b0040588d85b3asm6651wmo.15.2023.10.30.15.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 15:23:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 30 Oct 2023 22:23:26 +0000
Subject: [PATCH v2 4/7] clk/qcom: sdm845: add register map for simple gate
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v2-4-6572bc2be690@linaro.org>
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=7901;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HGfy9OgJOKC9JAbcEH4DNq46X+DuHz/RECF2B1p2/QA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQHnft/jl5VPmxya3vZonoGnklXNY52+e2RlgzbG7f0k
 eftTfyZHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiR1cw/I9VTd7jUHo9h/n1
 Ug17hxLTZ4mv5ZQddWSO7Cpy3bhYM5Lhv3N+oYfW3dZ7i5Yz9oTJBTltv7ywPmOeWFD5idjXSU8
 +rwMA
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

Many gate clocks can be enabled with a single register write, add support
for defining these simple gate clocks and add the ones found on SDM845.

While we're here, inline clk_init_uart() into msm_set_rate().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../mach-snapdragon/include/mach/sysmap-sdm845.h   |  3 +
 drivers/clk/qcom/clock-qcom.h                      | 26 +++++++
 drivers/clk/qcom/clock-sdm845.c                    | 87 +++++++++++++++++++---
 3 files changed, 104 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h b/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
index 7165985bcd1e..a0010d71594e 100644
--- a/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
+++ b/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
@@ -39,4 +39,7 @@
 #define SE9_UART_APPS_N		(0x18154)
 #define SE9_UART_APPS_D		(0x18158)
 
+#define USB30_SEC_GDSCR		(0x10004)
+#define USB30_PRIM_GDSCR	(0xf004)
+
 #endif
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index a9f895c2422e..6d399db987b6 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -5,6 +5,8 @@
 #ifndef _CLOCK_QCOM_H
 #define _CLOCK_QCOM_H
 
+#include <asm/io.h>
+
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
@@ -30,6 +32,18 @@ struct bcr_regs {
 	uintptr_t D;
 };
 
+struct gate_clk {
+	uintptr_t reg;
+	u32 en_val;
+	const char *name;
+};
+
+#ifdef DEBUG
+#define GATE_CLK(clk, reg, val) [clk] = { reg, val, #clk }
+#else
+#define GATE_CLK(clk, reg, val) [clk] = { reg, val, NULL }
+#endif
+
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
@@ -38,6 +52,8 @@ struct qcom_reset_map {
 struct msm_clk_data {
 	const struct qcom_reset_map	*resets;
 	unsigned long			num_resets;
+	const struct gate_clk		*clks;
+	unsigned long			num_clks;
 };
 
 struct msm_clk_priv {
@@ -55,4 +71,14 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 		      int source);
 
+static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
+{
+	u32 val;
+	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0)
+		return;
+
+	val = readl(priv->base + priv->data->clks[id].reg);
+	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
+}
+
 #endif
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index a7a43f69b9b3..57124e2a661a 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -11,6 +11,7 @@
 #include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
+#include <linux/delay.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
@@ -71,30 +72,90 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
 	return f - 1;
 }
 
-static int clk_init_uart(struct msm_clk_priv *priv, uint rate)
-{
-	const struct freq_tbl *freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
-
-	clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
-						freq->pre_div, freq->m, freq->n, freq->src);
-
-	return 0;
-}
-
 ulong msm_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	switch (clk->id) {
-	case GCC_QUPV3_WRAP1_S1_CLK: /*UART2*/
-		return clk_init_uart(priv, rate);
+	case GCC_QUPV3_WRAP1_S1_CLK: /* UART9 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
+				     freq->pre_div, freq->m, freq->n, freq->src);
+
+		return freq->freq;
 	default:
 		return 0;
 	}
 }
 
+static const struct gate_clk sdm845_clks[] = {
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK,		0x5200c, 0x00010000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK,		0x5200c, 0x00020000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,		0x5200c, 0x10000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,		0x5200c, 0x20000000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
+	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
+	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
+	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AHB_CLK,			0x75010, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_AXI_CLK,			0x7500c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_CLKREF_CLK,		0x8c004, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK,		0x75058, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK,		0x7508c, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK,		0x75018, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750a8, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75014, 0x00000001),
+	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75054, 0x00000001),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x77018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770a8, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77014, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77054, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MASTER_CLK,		0x1000c, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK,		0x10014, 0x00000001),
+	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK,		0x10010, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_CLKREF_CLK,		0x8c028, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK,		0x1004c, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK,		0x10054, 0x00000001),
+	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK,		0x10050, 0x00000001),
+	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,		0x6a004, 0x00000001),
+};
+
 int msm_enable(struct clk *clk)
 {
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
+
+	qcom_gate_clk_en(priv, clk->id);
+
 	return 0;
 }
 
@@ -121,6 +182,8 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 static const struct msm_clk_data qcs404_gcc_data = {
 	.resets = sdm845_gcc_resets,
 	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
+	.clks = sdm845_clks,
+	.num_clks = ARRAY_SIZE(sdm845_clks),
 };
 
 static const struct udevice_id gcc_sdm845_of_match[] = {

-- 
2.42.0

