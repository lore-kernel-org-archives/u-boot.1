Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24190E7315E
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3874183E83;
	Mon,  2 Feb 2026 13:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RqCYVakW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D8783E81; Mon,  2 Feb 2026 13:42:00 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F86483DFF
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432755545fcso2716586f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770036118; x=1770640918;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JcYmIkFLOtwDBFLn8iCOHFsUjgw2KIB1aON6xheoZRc=;
 b=RqCYVakWtzW4hFHwACKuBp/u39Wqa1EMs12X9rQ/URpfgIz8awP5i26Hmu61IsrGnp
 A7Pxul9P7fU1xs/4d4+gkIhNQrF05wE5IUG71C0RN0J0BAAMKusZXWD0ZRDPlX/Qh0+G
 5yEouCPnkcMyk6E54P8PiygVe8CxBfYmGgKQ0c85ce9LA3BRYB3zvINArZtfudpkBbMQ
 isfwYogDoKJHc7TuTV0Ifys7To9tSzznmdSgDI0mfj9sxcMhekzpK99iTQqTNLKi53WL
 nGDBJGCF5XMNsslZSUJEGffeXFd3vuJCt13+kKiELMLcEDCd4jooiRchbd0jtC8GkxRa
 OoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036118; x=1770640918;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JcYmIkFLOtwDBFLn8iCOHFsUjgw2KIB1aON6xheoZRc=;
 b=SfPTNYOIodESOOK3Y8pEgy/LJc2O4hlfOlBSuOOVMNIt7kDhfnER9QNMLGBDG4r/Kz
 qRqtfBhfyxLdYWA7pasYGPqPQwWzT0r/p0s1FUkiy6x6guklDea9HPQWppzWzfixGMEg
 LKtBl0j61w4+6EyrVqdp7JpyLicU6HRai/s2lZZMQkuypCGNYzm9veuU+ucw6xOuHF1i
 2VsxxB0Zfh1h1UQWQj8Wty3vmzp4/5Jvunp1XPTAKQtWeLHe914njPeQx92RjE+fgIbQ
 EKQcBt1uskd4T/ZYUf2eGPEAnQMwHpMPwQ/zKc5Jkvu2BtedwuPOJTDcjHvWJF/rFkYT
 n5vw==
X-Gm-Message-State: AOJu0YylxDO6dL9O3xiJAFyVm9HJdwde29ShF35XuVDuU24arcvZ0/tN
 JkbxSHzzG+0fY5AI3zf1ZuiZBDu3Ygs3XMlDTxFtlbFxbECbw97emmxuG8HvbUVXCNA=
X-Gm-Gg: AZuq6aKCC8e4V6lXmW9MSi7nYSovFA06gYVsfIjk8yTcQ00jaSL0jr2RYlJsBBerTrj
 vWjYawrsPm1HW1H+/FhmphdpS0PLzlt3S4NMi/3JB2SkVc15c6NhXqYQ8lkW8xP39mEwjL+6z4a
 qhbLpD67LJRfUrbnc93rnjTkemSAQ2Rcuy96accrkMZfT/RBdEOyOfubHoXH0Yhxrj2ZcDu7nGV
 rO9dIGhFEO8dki3t7/kuKOXX0a2tH6TEkQ6CzxBlmkJ0ugEmD9IjASEN7MiynhRM8s8gqR63zX/
 vl5m69VkVIn1bHMOAucXDKmxUbzSfH/lAdMoPdg7Q2VaCi/SWaH44x2pLrrnmmaoTOxRz6zlpb4
 zXYjXbdltbGloDPkzqfZEMEK2FRFIsHP9dKkkGU3rPStmwIktH25EalhmhN04B4zzEF3rnLUdxV
 4CUE5SGF5/tXeP+9cGpWqf3ac68evcAvtZbqBs9SfBOzHwwETw805esel7dk30El0d6gq8sWPJr
 pYLRvDwVA==
X-Received: by 2002:a05:6000:2c01:b0:432:c05b:d8c7 with SMTP id
 ffacd0b85a97d-435f3ab002dmr14666914f8f.49.1770036117755; 
 Mon, 02 Feb 2026 04:41:57 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm43593588f8f.18.2026.02.02.04.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:41:57 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:41:49 +0100
Subject: [PATCH v2 1/5] clk: mediatek: mt8188: remove separate topckgen-cg
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-mt8188-fix-clock-v2-1-b39bddfcac66@baylibre.com>
References: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
In-Reply-To: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Remove the separate topckgen-cg driver for handling clock gates in the
topckgen address space.
Commit 8aeeeff50d46 ("clk: mediatek: allow gates in topckgen drivers")
added support for gates in topckgen driver.
This commit fixes MT8188 driver, the same way commit ba207d7f54f9 ("clk:
mediatek: mt8365: remove separate topckgen-cg driver") does for MT8365.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 177 ++++++++++++++++----------------------
 1 file changed, 76 insertions(+), 101 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 64aeaa5949f..4317dd253bb 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1328,26 +1328,26 @@ static const int mt8188_id_offs_map[] = {
 	-1, /* CLK_TOP_APLL12_CK_DIV3 */
 	-1, /* CLK_TOP_APLL12_CK_DIV4 */
 	-1, /* CLK_TOP_APLL12_CK_DIV9 */
-	-1, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
-	-1, /* CLK_TOP_CFGREG_CLOCK_EN_VPP1 */
-	-1, /* CLK_TOP_CFGREG_CLOCK_EN_VDO0 */
-	-1, /* CLK_TOP_CFGREG_CLOCK_EN_VDO1 */
-	-1, /* CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS */
-	-1, /* CLK_TOP_CFGREG_F26M_VPP0 */
-	-1, /* CLK_TOP_CFGREG_F26M_VPP1 */
-	-1, /* CLK_TOP_CFGREG_F26M_VDO0 */
-	-1, /* CLK_TOP_CFGREG_F26M_VDO1 */
-	-1, /* CLK_TOP_CFGREG_AUD_F26M_AUD */
-	-1, /* CLK_TOP_CFGREG_UNIPLL_SES */
-	-1, /* CLK_TOP_CFGREG_F_PCIE_PHY_REF */
-	-1, /* CLK_TOP_SSUSB_TOP_REF */
-	-1, /* CLK_TOP_SSUSB_PHY_REF */
-	-1, /* CLK_TOP_SSUSB_TOP_P1_REF */
-	-1, /* CLK_TOP_SSUSB_PHY_P1_REF */
-	-1, /* CLK_TOP_SSUSB_TOP_P2_REF */
-	-1, /* CLK_TOP_SSUSB_PHY_P2_REF */
-	-1, /* CLK_TOP_SSUSB_TOP_P3_REF */
-	-1, /* CLK_TOP_SSUSB_PHY_P3_REF */
+	187, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
+	188, /* CLK_TOP_CFGREG_CLOCK_EN_VPP1 */
+	189, /* CLK_TOP_CFGREG_CLOCK_EN_VDO0 */
+	190, /* CLK_TOP_CFGREG_CLOCK_EN_VDO1 */
+	191, /* CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS */
+	192, /* CLK_TOP_CFGREG_F26M_VPP0 */
+	193, /* CLK_TOP_CFGREG_F26M_VPP1 */
+	194, /* CLK_TOP_CFGREG_F26M_VDO0 */
+	195, /* CLK_TOP_CFGREG_F26M_VDO1 */
+	196, /* CLK_TOP_CFGREG_AUD_F26M_AUD */
+	197, /* CLK_TOP_CFGREG_UNIPLL_SES */
+	198, /* CLK_TOP_CFGREG_F_PCIE_PHY_REF */
+	199, /* CLK_TOP_SSUSB_TOP_REF */
+	200, /* CLK_TOP_SSUSB_PHY_REF */
+	201, /* CLK_TOP_SSUSB_TOP_P1_REF */
+	202, /* CLK_TOP_SSUSB_PHY_P1_REF */
+	203, /* CLK_TOP_SSUSB_TOP_P2_REF */
+	204, /* CLK_TOP_SSUSB_PHY_P2_REF */
+	205, /* CLK_TOP_SSUSB_TOP_P3_REF */
+	223, /* CLK_TOP_SSUSB_PHY_P3_REF */
 	-1, /* CLK_TOP_NR_CLK */
 	-1, /* CLK_TOP_ADSPPLL */
 	-1, /* CLK_TOP_CLK13M */
@@ -1359,6 +1359,59 @@ static const int mt8188_id_offs_map[] = {
 	-1, /* CLK_TOP_ULPOSC_CK1 */
 };
 
+static const struct mtk_gate_regs top0_cg_regs = {
+	.set_ofs = 0x238,
+	.clr_ofs = 0x238,
+	.sta_ofs = 0x238,
+};
+
+static const struct mtk_gate_regs top1_cg_regs = {
+	.set_ofs = 0x250,
+	.clr_ofs = 0x250,
+	.sta_ofs = 0x250,
+};
+
+#define GATE_TOP0(_id, _parent, _shift) {			   \
+		.id = _id,					   \
+		.parent = _parent,				   \
+		.regs = &top0_cg_regs,				   \
+		.shift = _shift,				   \
+		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_TOPCKGEN, \
+	}
+
+#define GATE_TOP1(_id, _parent, _shift) {			       \
+		.id = _id,					       \
+		.parent = _parent,				       \
+		.regs = &top1_cg_regs,				       \
+		.shift = _shift,				       \
+		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
+	}
+
+static const struct mtk_gate topckgen_cg_clks[] = {
+	/* TOP0 */
+	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VPP0, CLK_TOP_VPP, 0),
+	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VPP1, CLK_TOP_VPP, 1),
+	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VDO0, CLK_TOP_VPP, 2),
+	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VDO1, CLK_TOP_VPP, 3),
+	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS, CLK_TOP_VPP, 4),
+	GATE_TOP0(CLK_TOP_CFGREG_F26M_VPP0, CLK_TOP_CLK26M, 5),
+	GATE_TOP0(CLK_TOP_CFGREG_F26M_VPP1, CLK_TOP_CLK26M, 6),
+	GATE_TOP0(CLK_TOP_CFGREG_F26M_VDO0, CLK_TOP_CLK26M, 7),
+	GATE_TOP0(CLK_TOP_CFGREG_F26M_VDO1, CLK_TOP_CLK26M, 8),
+	GATE_TOP0(CLK_TOP_CFGREG_AUD_F26M_AUD, CLK_TOP_CLK26M, 9),
+	GATE_TOP0(CLK_TOP_CFGREG_UNIPLL_SES, CLK_TOP_UNIVPLL_D2, 15),
+	GATE_TOP0(CLK_TOP_CFGREG_F_PCIE_PHY_REF, CLK_TOP_CLK26M, 18),
+	/* TOP1 */
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_REF, CLK_TOP_CLK26M, 0),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, CLK_TOP_CLK26M, 1),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_P1_REF, CLK_TOP_CLK26M, 2),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, CLK_TOP_CLK26M, 3),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_P2_REF, CLK_TOP_CLK26M, 4),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, CLK_TOP_CLK26M, 5),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_P3_REF, CLK_TOP_CLK26M, 6),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, CLK_TOP_CLK26M, 7),
+};
+
 static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
@@ -1366,12 +1419,15 @@ static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.id_offs_map_size = ARRAY_SIZE(mt8188_id_offs_map),
 	.fdivs_offs = 8, /* CLK_TOP_MAINPLL_D3 */
 	.muxes_offs = 87, /* CLK_TOP_AXI */
+	.gates_offs = 187, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
+	.gates = topckgen_cg_clks,
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.num_gates = ARRAY_SIZE(topckgen_cg_clks),
 };
 
 static const struct mtk_gate_regs infra_ao0_cg_regs = {
@@ -1574,64 +1630,6 @@ static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
 };
 
-static const struct mtk_gate_regs top0_cg_regs = {
-	.set_ofs = 0x238,
-	.clr_ofs = 0x238,
-	.sta_ofs = 0x238,
-};
-
-static const struct mtk_gate_regs top1_cg_regs = {
-	.set_ofs = 0x250,
-	.clr_ofs = 0x250,
-	.sta_ofs = 0x250,
-};
-
-#define GATE_TOP0(_id, _parent, _shift) {			   \
-		.id = _id,					   \
-		.parent = _parent,				   \
-		.regs = &top0_cg_regs,				   \
-		.shift = _shift,				   \
-		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_TOPCKGEN, \
-	}
-
-#define GATE_TOP1(_id, _parent, _shift) {			       \
-		.id = _id,					       \
-		.parent = _parent,				       \
-		.regs = &top1_cg_regs,				       \
-		.shift = _shift,				       \
-		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
-	}
-
-static const struct mtk_gate topckgen_cg_clks[] = {
-	/* TOP0 */
-	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VPP0, CLK_TOP_VPP, 0),
-	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VPP1, CLK_TOP_VPP, 1),
-	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VDO0, CLK_TOP_VPP, 2),
-	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VDO1, CLK_TOP_VPP, 3),
-	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS, CLK_TOP_VPP, 4),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VPP0, CLK_TOP_CLK26M, 5),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VPP1, CLK_TOP_CLK26M, 6),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VDO0, CLK_TOP_CLK26M, 7),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VDO1, CLK_TOP_CLK26M, 8),
-	GATE_TOP0(CLK_TOP_CFGREG_AUD_F26M_AUD, CLK_TOP_CLK26M, 9),
-	GATE_TOP0(CLK_TOP_CFGREG_UNIPLL_SES, CLK_TOP_UNIVPLL_D2, 15),
-	GATE_TOP0(CLK_TOP_CFGREG_F_PCIE_PHY_REF, CLK_TOP_CLK26M, 18),
-	/* TOP1 */
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_REF, CLK_TOP_CLK26M, 0),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, CLK_TOP_CLK26M, 1),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_P1_REF, CLK_TOP_CLK26M, 2),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, CLK_TOP_CLK26M, 3),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_P2_REF, CLK_TOP_CLK26M, 4),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, CLK_TOP_CLK26M, 5),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_P3_REF, CLK_TOP_CLK26M, 6),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, CLK_TOP_CLK26M, 7),
-};
-
-static const struct mtk_clk_tree mt8188_topckgen_cg_clk_tree = {
-	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
-};
-
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 	.set_ofs = 0xe08,
 	.clr_ofs = 0xe04,
@@ -1687,14 +1685,6 @@ static int mt8188_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
 }
 
-static int mt8188_topckgen_cg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_tree,
-					topckgen_cg_clks,
-					ARRAY_SIZE(topckgen_cg_clks),
-					CLK_TOP_CFGREG_CLOCK_EN_VPP0);
-}
-
 static int mt8188_infracfg_ao_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tree,
@@ -1740,11 +1730,6 @@ static const struct udevice_id mt8188_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8188_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8188-topckgen-cg", },
-	{ }
-};
-
 static const struct udevice_id mt8188_infracfg_ao_compat[] = {
 	{ .compatible = "mediatek,mt8188-infracfg-ao", },
 	{ }
@@ -1790,16 +1775,6 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
-	.name = "mt8188-topckgen-cg",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_topckgen_cg_compat,
-	.probe = mt8188_topckgen_cg_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mtk_clk_infracfg_ao) = {
 	.name = "mt8188-infracfg-ao",
 	.id = UCLASS_CLK,

-- 
2.52.0

