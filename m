Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B6CC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 15:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C235087037;
	Fri,  3 Nov 2023 16:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eU1kGPZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B126687480; Fri,  3 Nov 2023 16:39:41 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B210B86FA2
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 16:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40853c639abso16592795e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025975; x=1699630775; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TL8pGhUOm4oSqsu9B3FNFUdsCcrqCr/10daTxm3efdQ=;
 b=eU1kGPZVpmU/ph3KEcVzgTeZC/4rufNbdjTBpUE0QQsPAqyMkcOpoUH2wa0PJCDOJR
 9d69GPJL/fNmNMknYH8w00tL+VqfEUbd6i3Jhd38qAOfKV6hggSmO03ZqMAzdMNIfj9U
 H6qzqNgFMt9AYnzxtFR36foZ4kn1sWrmQpv7QNrD53okWq6fCNeb7MBKk8jfaXYekTW+
 wYhdKG4YhM6fJLGFig6u8TRt6SjgBl9z1hBEHn0qrTtmnkycFehkUuA7kvc6pCKfVMvK
 k+8ar21N3Kmil9v+5DkM0PzMohb15aw4hR/iMN6HXPuksKuUkZcAlZISn3sM+uBeUJ0V
 iWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025975; x=1699630775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL8pGhUOm4oSqsu9B3FNFUdsCcrqCr/10daTxm3efdQ=;
 b=GnihyZXO1eJtv5TOlfys5s/pSJ6R7rrMpUlNSVi99MyXW1fCySURN9liOpKWvFTaYi
 Gt7B5CKFoyf+v5xNyaqnbW56WPEvfwoJKsUDha1wjSlBDK1/vUeGlCcaEJ2NW2gcwN/0
 1y6pYDQ3+/C3DPgrCr/C08lC5abOBl4gAGHOHIzXzrlC1MgDQ7NQyIZpJVra/0TgkwZF
 KamKGrrlgYTKl0ClPh1yFzdo+jCYLNklCw0k7/JOJYTmANiz88y0RSUCo3OecpH7YWzm
 rmEhKOMwAkYPU6qCwmt2KYUPN5Yk56AJuTdFiWkt/GLjcXilfzz9m3N50a97yM/clEu4
 N8/g==
X-Gm-Message-State: AOJu0Yzm1N1KPSYFz+ckRyu0q0PbV1CeONEDx07o2FFDF3UYii+Vp/Vm
 l5rXO+YYVnlpmR8ZQCc0Q/VnbQ==
X-Google-Smtp-Source: AGHT+IGf+U8BCq290B9i4GUYHwZlZajY6mSEbKUcqh7IcsCVK0KB1UNNj2pkhCA26farzFOYkymQ9A==
X-Received: by 2002:a05:600c:4ecb:b0:407:5ad0:ab5b with SMTP id
 g11-20020a05600c4ecb00b004075ad0ab5bmr18227375wmq.8.1699025975176; 
 Fri, 03 Nov 2023 08:39:35 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm2928334wmb.41.2023.11.03.08.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:39:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 03 Nov 2023 15:39:28 +0000
Subject: [PATCH v3 4/7] clk/qcom: sdm845: add register map for simple gate
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-b4-qcom-clk-v3-4-8d2d460ece84@linaro.org>
References: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
In-Reply-To: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=7408;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=E/nZc7E17Ykir35ydpDJEkFvOGJwbjw9RvWljfPBdvE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRXEcNLlyd2bp9Uezr/lcamiMZjebPr5Rw73m1687jvj
 0KN2n61jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRfScY/kpwMxrsZjsRcHLK
 42Oz/vvw/zrUuGamN28Lg0bI1qsG8fsZfrPrRc2Yv2R2iHw723YutpRWds0J0t9qJ37xO67I+yq
 15Q4A
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.h   | 26 ++++++++++++
 drivers/clk/qcom/clock-sdm845.c | 87 +++++++++++++++++++++++++++++++++++------
 2 files changed, 101 insertions(+), 12 deletions(-)

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

