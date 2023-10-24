Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C461EC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F423D879A9;
	Tue, 24 Oct 2023 22:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z6GiFljo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8240C87973; Tue, 24 Oct 2023 22:24:09 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CE08798C
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so38439895e9.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179044; x=1698783844; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pO//yXCY6NLloEJik+qFyzQjnLPFARA2mTCdLdnOm7A=;
 b=Z6GiFljo+zq3vJ7kOt7DoJcoOfY/xhVu8YqcuW0sf2IIIzw/3Crs1Uo7/9wuzHib/C
 wJepIzSK0VeyufzTsogDBx8Oml7DWa4axfUe9RIYT713KJiPpuUYIz2Q3ECuy7oZ/r8h
 3cJl5aiPKG+HpMFnrLC3BBuuAMmgNiNRTZDUv8lAYy5rkx6bebhi8ugCfw/dYKx3BtFa
 bpCCCBqACIlpE3rWMRMwFSIe7WeyS78kAgVrUYNmbvnwC1sPAdx3dhCsSJMCzgxNF8Y/
 tfyitcfkIt5Ug1Xk8JZk3Hq1o7ZZh5bH2pNIAQWNOpv/qRwdxeDw1tDkc8Fi/xRGgvi3
 djmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179044; x=1698783844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO//yXCY6NLloEJik+qFyzQjnLPFARA2mTCdLdnOm7A=;
 b=ZuvvAgwVj9Xf3GySF340p2Jm0jDJYeXeqAMVO6nqY0esZMksN0APxXHwt6LP68hFJo
 bTLzLGyx8fV2Xj9S0Oy7d8OzhKC+VfTw1k9/mmaSEQx36IQgHASQs+z8qQ47KkW/iEvO
 W+V98b69/9aXZbXiGpZLrXRTv44y78tQwl29F4qVnaKR1HdxeJPzcyiTFYtXh1jU16h1
 B9NOyLabZVQlFFci8V2viuPUQWxsZJSzew3bZOH38wUWs6BOPnzLabWmDcTzYOs7vmXK
 GoVEEu878py8HfQ+QiTQNjb8kcpt0wmjPA/ouXPKtdoUIWClDqsW4aESEmozMoejcmDg
 ZFyQ==
X-Gm-Message-State: AOJu0YzDyBqJ88FCp5glrUugN215ubiA/b4GQDCVMg/TqcSiuAaRSyms
 s22wnZnIZIc1/Ee6vJI2SBn3qw==
X-Google-Smtp-Source: AGHT+IHi31A5zxYy3vUgFlTnEThnZekm+eX1nRd2rpu6IgOjSdKvhYmi0iGhZGWFeZDKSrrD9XBTYQ==
X-Received: by 2002:adf:e6cb:0:b0:32d:d848:8efd with SMTP id
 y11-20020adfe6cb000000b0032dd8488efdmr9455424wrm.57.1698179043740; 
 Tue, 24 Oct 2023 13:24:03 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:24:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 21:23:56 +0100
Subject: [PATCH 5/8] clk/qcom: sdm845: add register map for simple gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v1-5-9d96359b9a82@linaro.org>
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=11979;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1+5PQfPqzQ+T0jZjI1xwMwWAmFAVz14tCIwJO8F/xNk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9VveemER0VJ78xnXmyQf+aHqI7Nm4+tvPuvOVZW/S
 51yxfFjRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIhscM/xT+fa76fqR8YZwN
 Z1jPlcxCmy/Tt/Tama0rPfnBLSqKN5bhr+SjB63PP7ow2D18YWZ+kD2U8eKOk6VBjxLSX0wruOY
 cdBsA
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
 .../mach-snapdragon/include/mach/sysmap-sdm845.h   |   3 +
 drivers/clk/qcom/clock-qcom.h                      |  22 +++
 drivers/clk/qcom/clock-sdm845.c                    | 163 +++++++++++++++++++--
 3 files changed, 176 insertions(+), 12 deletions(-)

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
index a77a94b6ea06..7b3bcf41f421 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -30,6 +30,18 @@ struct bcr_regs {
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
@@ -38,6 +50,8 @@ struct qcom_reset_map {
 struct qcom_cc_data {
 	const struct qcom_reset_map	*resets;
 	unsigned long			num_resets;
+	const struct gate_clk		*clks;
+	unsigned long			num_clks;
 };
 
 struct qcom_cc_priv {
@@ -55,4 +69,12 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
 void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
 		      int source);
 
+static inline void qcom_gate_clk_en(const struct qcom_cc_priv *priv, unsigned long id)
+{
+	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0)
+		return;
+
+	setbits_le32(priv->base + priv->data->clks[id].reg, priv->data->clks[id].en_val);
+}
+
 #endif
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index eab88a40c09d..ccad73b6ff15 100644
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
@@ -71,30 +72,166 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
 	return f - 1;
 }
 
-static int clk_init_uart(struct qcom_cc_priv *priv, uint rate)
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
 	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
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
+	GATE_CLK(GCC_AGGRE_NOC_PCIE_TBU_CLK,		0x90014, 0x00000001),
+	GATE_CLK(GCC_AGGRE_UFS_CARD_AXI_CLK,		0x82028, 0x00000001),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x82024, 0x00000001),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x8201c, 0x00000001),
+	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x82020, 0x00000001),
+	GATE_CLK(GCC_BOOT_ROM_AHB_CLK,			0x52004, 0x00000400),
+	GATE_CLK(GCC_CAMERA_AHB_CLK,			0x0b008, 0x00000001),
+	GATE_CLK(GCC_CAMERA_AXI_CLK,			0x0b020, 0x00000001),
+	GATE_CLK(GCC_CAMERA_XO_CLK,			0x0b02c, 0x00000001),
+	GATE_CLK(GCC_CE1_AHB_CLK,			0x52004, 0x00000008),
+	GATE_CLK(GCC_CE1_AXI_CLK,			0x52004, 0x00000010),
+	GATE_CLK(GCC_CE1_CLK,				0x52004, 0x00000020),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x0502c, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,		0x05030, 0x00000001),
+	GATE_CLK(GCC_CPUSS_AHB_CLK,			0x52004, 0x00200000),
+	GATE_CLK(GCC_CPUSS_RBCPR_CLK,			0x48008, 0x00000001),
+	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,			0x44038, 0x00000001),
+	GATE_CLK(GCC_DISP_AHB_CLK,			0x0b00c, 0x00000001),
+	GATE_CLK(GCC_DISP_AXI_CLK,			0x0b024, 0x00000001),
+	GATE_CLK(GCC_DISP_GPLL0_CLK_SRC,		0x52004, 0x00040000),
+	GATE_CLK(GCC_DISP_GPLL0_DIV_CLK_SRC,		0x52004, 0x00080000),
+	GATE_CLK(GCC_DISP_XO_CLK,			0x0b030, 0x00000001),
+	GATE_CLK(GCC_GP1_CLK,				0x64000, 0x00000001),
+	GATE_CLK(GCC_GP2_CLK,				0x65000, 0x00000001),
+	GATE_CLK(GCC_GP3_CLK,				0x66000, 0x00000001),
+	GATE_CLK(GCC_GPU_CFG_AHB_CLK,			0x71004, 0x00000001),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC,			0x52004, 0x00008000),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC,		0x52004, 0x00010000),
+	GATE_CLK(GCC_GPU_MEMNOC_GFX_CLK,		0x7100c, 0x00000001),
+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK,		0x71018, 0x00000001),
+	GATE_CLK(GCC_MSS_AXIS2_CLK,			0x8a008, 0x00000001),
+	GATE_CLK(GCC_MSS_CFG_AHB_CLK,			0x8a000, 0x00000001),
+	GATE_CLK(GCC_MSS_GPLL0_DIV_CLK_SRC,		0x52004, 0x00020000),
+	GATE_CLK(GCC_MSS_MFAB_AXIS_CLK,			0x8a004, 0x00000001),
+	GATE_CLK(GCC_MSS_Q6_MEMNOC_AXI_CLK,		0x8a154, 0x00000001),
+	GATE_CLK(GCC_MSS_SNOC_AXI_CLK,			0x8a150, 0x00000001),
+	GATE_CLK(GCC_PCIE_0_AUX_CLK,			0x5200c, 0x00000008),
+	GATE_CLK(GCC_PCIE_0_CFG_AHB_CLK,		0x5200c, 0x00000004),
+	GATE_CLK(GCC_PCIE_0_CLKREF_CLK,			0x8c00c, 0x00000001),
+	GATE_CLK(GCC_PCIE_0_MSTR_AXI_CLK,		0x5200c, 0x00000002),
+	GATE_CLK(GCC_PCIE_0_PIPE_CLK,			0x5200c, 0x00000010),
+	GATE_CLK(GCC_PCIE_0_SLV_AXI_CLK,		0x5200c, 0x00000001),
+	GATE_CLK(GCC_PCIE_0_SLV_Q2A_AXI_CLK,		0x5200c, 0x00000020),
+	GATE_CLK(GCC_PCIE_1_AUX_CLK,			0x52004, 0x20000000),
+	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK,		0x52004, 0x10000000),
+	GATE_CLK(GCC_PCIE_1_CLKREF_CLK,			0x8c02c, 0x00000001),
+	GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK,		0x52004, 0x08000000),
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK,			0x52004, 0x40000000),
+	GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK,		0x52004, 0x04000000),
+	GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK,		0x52004, 0x02000000),
+	GATE_CLK(GCC_PCIE_PHY_AUX_CLK,			0x6f004, 0x00000001),
+	GATE_CLK(GCC_PCIE_PHY_REFGEN_CLK,		0x6f02c, 0x00000001),
+	GATE_CLK(GCC_PDM2_CLK,				0x3300c, 0x00000001),
+	GATE_CLK(GCC_PDM_AHB_CLK,			0x33004, 0x00000001),
+	GATE_CLK(GCC_PDM_XO4_CLK,			0x33008, 0x00000001),
+	GATE_CLK(GCC_PRNG_AHB_CLK,			0x52004, 0x00002000),
+	GATE_CLK(GCC_QMIP_CAMERA_AHB_CLK,		0x0b014, 0x00000001),
+	GATE_CLK(GCC_QMIP_DISP_AHB_CLK,			0x0b018, 0x00000001),
+	GATE_CLK(GCC_QMIP_VIDEO_AHB_CLK,		0x0b010, 0x00000001),
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
+	GATE_CLK(GCC_SYS_NOC_CPUSS_AHB_CLK,		0x52004, 0x00000001),
+	GATE_CLK(GCC_TSIF_AHB_CLK,			0x36004, 0x00000001),
+	GATE_CLK(GCC_TSIF_INACTIVITY_TIMERS_CLK,	0x3600c, 0x00000001),
+	GATE_CLK(GCC_TSIF_REF_CLK,			0x36008, 0x00000001),
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
+	GATE_CLK(GCC_VIDEO_AHB_CLK,			0x0b004, 0x00000001),
+	GATE_CLK(GCC_VIDEO_AXI_CLK,			0x0b01c, 0x00000001),
+	GATE_CLK(GCC_VIDEO_XO_CLK,			0x0b028, 0x00000001),
+	GATE_CLK(GCC_GPU_IREF_CLK,			0x8c010, 0x00000001),
+	GATE_CLK(GCC_APC_VS_CLK,			0x7a050, 0x00000001),
+	GATE_CLK(GCC_GPU_VS_CLK,			0x7a04c, 0x00000001),
+	GATE_CLK(GCC_MSS_VS_CLK,			0x7a048, 0x00000001),
+	GATE_CLK(GCC_VDDA_VS_CLK,			0x7a00c, 0x00000001),
+	GATE_CLK(GCC_VDDCX_VS_CLK,			0x7a004, 0x00000001),
+	GATE_CLK(GCC_VDDMX_VS_CLK,			0x7a008, 0x00000001),
+	GATE_CLK(GCC_VS_CTRL_AHB_CLK,			0x7a014, 0x00000001),
+	GATE_CLK(GCC_VS_CTRL_CLK,			0x7a010, 0x00000001),
+	GATE_CLK(GCC_CPUSS_DVM_BUS_CLK,			0x48190, 0x00000001),
+};
+
 int msm_enable(struct clk *clk)
 {
+	struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
+
+	debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
+
+	qcom_gate_clk_en(priv, clk->id);
+
 	return 0;
 }
 
@@ -130,6 +267,8 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 static const struct qcom_cc_data qcs404_gcc_data = {
 	.resets = sdm845_gcc_resets,
 	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
+	.clks = sdm845_clks,
+	.num_clks = ARRAY_SIZE(sdm845_clks),
 };
 
 static const struct udevice_id gcc_sdm845_of_match[] = {

-- 
2.42.0

