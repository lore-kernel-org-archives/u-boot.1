Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9AEC41535
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8771F87252;
	Tue,  7 Nov 2023 13:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/uvrBQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4BF83414; Tue,  7 Nov 2023 13:41:21 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4FE871E9
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so42061875e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699360876; x=1699965676; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TL8pGhUOm4oSqsu9B3FNFUdsCcrqCr/10daTxm3efdQ=;
 b=b/uvrBQmTxjXCfCzMX5IkOOBOmhVvVu1twh/LDMA7TzHbZrGKhcOPgC2F9w7GPG34B
 RXabMMYzwq6HoRT5fkVtTK99aMwttiCWueiK26Qs6T6v8ic+7CBFuktM0j1998GQNql8
 nzFVaXEoeWhRvyg3nUvjPhGZEXkQZpt9UUjDxvTOaf9JxgteOTEt8wMpolsCuIJzwJ+N
 gG6gPtjAI2P6QZ8mJgAS1UlerlQg/BWSVbZEink62JYZnt9fSL4kVAF3ozjGdkW+IHxE
 qFG/pnBpUALLg1N74x5wPkYdQnz7XxrIw4tWKpbdvHnjI8bfuwtMdwlz01X9prLBF1n8
 lQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360876; x=1699965676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL8pGhUOm4oSqsu9B3FNFUdsCcrqCr/10daTxm3efdQ=;
 b=IUnAOqLRCGt6cgAG6u8ohV9Mu2v1wo+9cdb+TIf7cBCyOCZG0D9gYbrhGdWWbl78Hz
 sa6cQ7GbS+n8RNt+U4T5B15VsiUP/cJGn13dyMTEbBH8ziSXwj1/2XgkA8AFXWpWLUjE
 7ipnEmdVMRP4lYBsvD2BoyT1Uz2QMmefDua8BVWX6PhpZBNPuLENq76rLe72XiIBYtCL
 gRsXGgj13EBx5hlwiHoY1B4yTnSo4kPGPx96MrzAruLzI80yGnaMDXNyEEYzNQ+15KwX
 zNdUtRUIfTWEXxOhTOB4u5tl+qo8VLyHFqVaiXjajeSlIukspl64390iaCHqNgaJT/lk
 xWsQ==
X-Gm-Message-State: AOJu0YwJFxbouPY68D3XwJm4RdR5X2OfrGvJQeMlPJxwqsqpcp/NmMeX
 wMYvTummjNonQetDPn09wA2QZw==
X-Google-Smtp-Source: AGHT+IGinh2MeIaXfD2upAiayUW64K5dQsf6MisBO5EPG6ZK6Hd6YpOrAELvHeBBZ1cv3KsgMEJfuQ==
X-Received: by 2002:a05:600c:3c82:b0:409:6edc:6e5c with SMTP id
 bg2-20020a05600c3c8200b004096edc6e5cmr2183756wmb.0.1699360876498; 
 Tue, 07 Nov 2023 04:41:16 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm2285333wrt.18.2023.11.07.04.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:41:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 07 Nov 2023 12:41:02 +0000
Subject: [PATCH v4 4/7] clk/qcom: sdm845: add register map for simple gate
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-b4-qcom-clk-v4-4-82bbaf1a796d@linaro.org>
References: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
In-Reply-To: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQvg/SVvEq/J9vcWXrL+iK7oXjOvByTy0JnFmzZW7zk1
 MXw1oeJHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiTEsY/ilO23FtS+ONL73H
 l89Z42Lia6X3cMXSaq7Gpz/7CrvupK1iZNiY/jfz6q3mynClB0sFpiyWY1+lu928dc5rHuH9x/b
 fYpwDAA==
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

