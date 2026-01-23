Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688CFD72361
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 09:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F23839DF;
	Fri, 23 Jan 2026 10:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="socWNikV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E289383B0B; Fri, 23 Jan 2026 10:41:13 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCE083B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 10:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1193727f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769161271; x=1769766071;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JcYmIkFLOtwDBFLn8iCOHFsUjgw2KIB1aON6xheoZRc=;
 b=socWNikV+XMXrTyyIpVYOCm41Rnq9MI+Q9kCChMcSKUN5dMtwOIJt1VQsWLCcaaKfN
 g6mYjflN87WFp4GOL5f8Eo5OWW7gmU1mzuZsjUXLtuuPMBkMmTdXa8i/Mk3XPPGZsZMM
 7fTp9+69jM7GjCMvnWSSAn0XnAPlHw/POsaJk0R3ZBhphpi5/voVuFMCrcVKnARbDAuK
 7sUxos9AfS8CTV9wS/CIRgAgVUnYaNy9S8VgQqQJETFD4KGPET447oDVfiF0uoD78U7w
 s3Xgw0la9ML0n5vNA+QuL6fTfSD40YWHqi+Wy2qviDrMvAcGfG5XtFOmsioS7Hs+paBR
 o/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769161271; x=1769766071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JcYmIkFLOtwDBFLn8iCOHFsUjgw2KIB1aON6xheoZRc=;
 b=pxOLxyO7PrwserkZGEA3MoIeyDYOE48ZheEg2lfOjwGHf/e05VHlqx1HnWbudN+WtC
 6VeG/hGuRMN70W9SRE/BMwbtZMe3qrN9TGVdjY9hNek/rp6WXB0k5fYCRvA/omeEF8ET
 ICoApwF6bdTrNnd4hdfkDkFraSlBtEq9Q1WccNJRADyfIRuaC8MksUqfzL1Gb7mj+WW8
 I36eiPrJRtGD/3iEgEF3jaQvypdouuvTd0z3ac9gmwW/c/DcEXUgbadTn3pUppxoQsFf
 LXp0l/sxuJtGTmCmdMajFBr4OAt82i0CdrWJ6OfLyQ+KsvZrCIl4AA496EAfbEwX4hA3
 H8YQ==
X-Gm-Message-State: AOJu0YztPrh79+5psK4Lca2v7QmxG+yN3U2OnkPWC7Bzzvy1R3Jhr/pS
 r0k1AEYxp94wpgV6SQtLqq2BbDvHhbOSKAfutGfuHDjyvK7EY3rmYrWBfDje/UwdTls=
X-Gm-Gg: AZuq6aKBLV9NrxS1PaYVZG4O5PkIthTxNJu4kTsje5+HlTZtZIVwzzopzkftD6j/vLm
 fz5bpvO0tcw6MfhlpoHYI8s30tHNFZEMOPR5tVIiSIDLpN75aLJdjlAoUYTctnF9q97ld7BPnfB
 lLvH6YkZisorN5/3WN3DFUsoz5Rw+MGeX64ZYOLfWQW/O4g1JMzRX/+Re1MhgaeE4xU5XbMBjuH
 wSEIIqLMDOhm0R26cK16E5a184ZKvIgRePvdG4dJ9XCLS5I0UYzOe3spBGXAIb88MaLA5KeyKjO
 j0pYiA0uJHdNlHY2Z6mqXy0F4o+NUxW3cHTRXKyc1v0Wb816olqjYiQVJjeJzMxo7v7ZvqdbLCo
 vsb8JA/pA9qy4lZkK4KNQLPTyPZ7Zx8ueciWjSvK3I+/gD/co6GDOalS3PEXqvgULm9n2JPIKbL
 omfnWiP6cokLIIPnVEz2t6VVNq/KJPtALYycPNh8JiXErHRF8KYYZ17gVMX4sEaOf2U5flBVDP1
 MawPMgT9A==
X-Received: by 2002:a05:6000:4013:b0:431:1ae:a3be with SMTP id
 ffacd0b85a97d-435b158a451mr3953618f8f.3.1769161271041; 
 Fri, 23 Jan 2026 01:41:11 -0800 (PST)
Received: from [192.168.1.60]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e7156dsm5147411f8f.20.2026.01.23.01.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 01:41:10 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 23 Jan 2026 10:41:09 +0100
Subject: [PATCH 1/5] clk: mediatek: mt8188: remove separate topckgen-cg driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-mt8188-fix-clock-v1-1-e355352bf405@baylibre.com>
References: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
In-Reply-To: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
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

