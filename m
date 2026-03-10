Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CE5EB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF59584120;
	Tue, 10 Mar 2026 16:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cgpecKMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62C284127; Tue, 10 Mar 2026 16:34:27 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EB6840D8
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-466f1c3c627so2098572b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156863; x=1773761663;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4gxOIMYE1kxJWBetm6Erx+aEDHZ/M++93cospCrkUVA=;
 b=cgpecKMUYniKBPAkQkvrqhVSRX3IadbFSe3AnVUTDQxg6uwk4QXzA22W3VPCNDfCw/
 JwmMfbzzr0k0OIXiiahEESTbSCEK/KN0MOopy4RIoePgToPmbhW84LI1mYScRk8mMS6g
 xZg4U7sA9lNlRAMDA8VFpbwb5ZAPQS3FlJHqTGx4mwpAxajrocX4/EFt0OiZVmjS17S1
 w0xaasn42tu/qby3NYyXd2o093TxHj9las3mfQxH5ZRvz9Pzj+j7k4PS8NenWn1YGJqu
 7zPWuRaoEdzC7NzcZ0qHEZY98Ay1vigevAQHe/JNbF2DxxJaJgXS19l1gMR5Ygm6/Xah
 AjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156863; x=1773761663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4gxOIMYE1kxJWBetm6Erx+aEDHZ/M++93cospCrkUVA=;
 b=dlHCfwtIENy24qHabchr8WZOO9SEKdFlU4qiV60BnQWFaT/u8EO3RQ2mUdR7AD+z8y
 Dk+bA00X5PChRpjdcR9dFT3eDTk6ZHUpY0t5X1RKZHeODctcoQYZtPaRQaqTC9lRmtVw
 1/kgtMGivHkYmsVlXa6ki4dP+KIy30hzp6oIroLY1WFj+qWZXaCKToIc6lQKLwr6Abks
 BvkS4lJ0nIPlRGZTiKtuNloXQd6FvYmk2UfTn1mMa62rJhU6ix9fnEfH2J2TWpw/QJQx
 Ylw6GOzCV1GfZmJ/xSwDbF24f5jBpzhJsN2G513ssK+a1Xg3PRQGhrI8uwyr/UIYKO+A
 Ikgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm61Pl0+G09GtQH7jMq4CuB5dWwOJ7xd1sBxI+Pl4XHI0y8fJWgdTwK/2jc+r4sH0KPpX+JO8=@lists.denx.de
X-Gm-Message-State: AOJu0YyCd5NeUcUAPjS/RwHR25lMwqN6iDZ38yEH9zfDPZB5zBTp/zvf
 KoKVoyi5E6vmd2pmL2Mo/JOO0QxOA7+s8NLtnlgfzm/wBob439+cjrnkdAcsPSrn9yo=
X-Gm-Gg: ATEYQzzpISl69iwG6Z4GWW+pMrvqOl3/ru/7o6gAedn2Z+sGTnD0lqfWCzIY2n+XVXq
 jDPbM6O/SCYboBwlyvy8N94+SOy6HjUARVkZY90evfcN4R40wwEq48JI/isTck6xsuNZmAWUUaN
 +NijiZG2tJ6Ucf333+8IMTksEbQ+/pHBvhshg3+PW9DcS6as/VMO3oav3tfIqpFabFGVt0S9M9P
 PtZu0VCcYhHRUIsoy0fgY1wuFsRKnoyZ+a+4zDfsK9jLZsskVRZ9ffHMjhaIarvmNk4u9GY/6Bm
 Gk4P4Ekf7MtmG6LfCdYrpvZFfF3eT2Md4TnSPYkvtzl42w8T67HhONKpAk12S1Hh62+w7R8e9VD
 ebN4801Gakn44JbTa3GBIGP6C2JGHr+d3ziRS2N3R/bYkseZYSy9ogtP32nFAhfq0cDOFWfgpBx
 vnL6J8HFUrmV2fi/Kb1SrP+DvRqk8cqNjBix6cgSE=
X-Received: by 2002:a05:6808:2217:b0:463:8fba:5df5 with SMTP id
 5614622812f47-466dca5823cmr9443712b6e.24.1773156863153; 
 Tue, 10 Mar 2026 08:34:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:20 -0500
Subject: [PATCH 07/16] clk: mediatek: mt7987: convert CLK_XTAL to
 CLK_PAD_CLK40M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-7-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5885; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fPYsjgC42Oe0TeAXnD4rr02TuN7Et2E7LiB1HjjLxdA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmyAPS1NsH4Pde1jCAa0cOIQbZuwbXw8m6mz
 v/9HymqWoeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5shYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Al1cH/2x2HFwy/cC1ZfLfgLCZAaUsQIyWQ9y1AqRLxfV
 tGP46TCM2JK76GwJLZA20DhK1Hn0OUPJhzXxmjmmejvzlZJLrxAUpSvwKRl6c9de7u2eFJixx0a
 mckLPmkO7+ACkY7STEkpbfmHbzlgyAe99eK7O4YFziahFDaRuy/r1pqABAVTquc5haEO8jmjHM1
 IUBq/dKmY7aT6THBm8rwRPc0/6xpoKA97KIgbZMoNp43aVVU/7tObgc9o7RcEAcswqX9fCY/fUr
 u48eUhN0UE0hxLv/LSBivth8IcPId0O01oxTaHLn8SzvrrdyZqmpkQsWxc50LKXzwTVeHeXjkzz
 QoWU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK40M.

This will eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 2fdd0fd20c9..5f102636079 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -15,15 +15,22 @@
 
 #include "clk-mtk.h"
 
-#define MT7987_XTAL_RATE	(40 * MHZ)
 #define MT7987_CLK_PDN		0x250
 #define MT7987_CLK_PDN_EN_WRITE	BIT(31)
 
+enum {
+	CLK_PAD_CLK40M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK40M] = 40 * MHZ,
+};
+
 #define FIXED_CLK0(_id, _rate)                                                 \
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK40M, CLK_PARENT_EXT, _rate)
 
-#define XTAL_FACTOR(_id, _name, _parent, _mult, _div)                          \
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+#define EXT_FACTOR(_id, _name, _parent, _mult, _div)                           \
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -47,11 +54,12 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 };
 
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
-	.xtal_rate = 40 * MHZ,
 };
 
 static const struct udevice_id mt7987_fixed_pll_compat[] = {
@@ -104,7 +112,7 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 	PLL_FACTOR(CLK_TOP_NET2_D7_D2, "net2_d7_d2", CLK_APMIXED_NET2PLL, 1, 14),
 	PLL_FACTOR(CLK_TOP_CB_NET2_D8, "cb_net2_d8", CLK_APMIXED_NET2PLL, 1, 8),
 	PLL_FACTOR(CLK_TOP_MSDC_D2, "msdc_d2", CLK_APMIXED_MSDCPLL, 1, 2),
-	XTAL_FACTOR(CLK_TOP_CB_CKSQ_40M, "cb_cksq_40m", CLK_XTAL, 1, 1),
+	EXT_FACTOR(CLK_TOP_CB_CKSQ_40M, "cb_cksq_40m", CLK_PAD_CLK40M, 1, 1),
 	TOP_FACTOR(CLK_TOP_CKSQ_40M_D2, "cksq_40m_d2", CLK_TOP_CB_CKSQ_40M, 1, 2),
 	TOP_FACTOR(CLK_TOP_CB_RTC_32K, "cb_rtc_32k", CLK_TOP_CB_CKSQ_40M, 1, 1250),
 	TOP_FACTOR(CLK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CLK_TOP_CB_CKSQ_40M, 1, 1221),
@@ -441,13 +449,14 @@ static const struct mtk_composite topckgen_mtk_muxes[] = {
 };
 
 static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.muxes_offs = CLK_TOP_NETSYS_SEL,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
-	.xtal_rate = MT7987_XTAL_RATE,
 };
 
 static const struct udevice_id mt7987_topckgen_compat[] = {
@@ -639,8 +648,8 @@ static const struct mtk_gate_regs infra_3_cg_regs = {
 	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_INFRASYS)
 #define GATE_INFRA3_TOP(_id, _name, _parent, _shift) \
 	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
-#define GATE_INFRA3_XTAL(_id, _name, _parent, _shift) \
-	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
+#define GATE_INFRA3_EXT(_id, _name, _parent, _shift) \
+	GATE_INFRA3(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_EXT)
 
 /* INFRA GATE */
 static const struct mtk_gate infracfg_mtk_gates[] = {
@@ -741,20 +750,20 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 			CLK_TOP_CB_CKSQ_40M, 7),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_FRMCNT_CK_P1,
 			"infra_usb_frmcnt_ck_p1", CLK_TOP_CKSQ_40M_D2, 9),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_PIPE_CK_P1,
-			 "infra_usb_pipe_ck_p1", CLK_XTAL, 11),
-	GATE_INFRA3_XTAL(CLK_INFRA_USB_UTMI_CK_P1,
-			 "infra_usb_utmi_ck_p1", CLK_XTAL, 13),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_PIPE_CK_P1,
+			"infra_usb_pipe_ck_p1", CLK_PAD_CLK40M, 11),
+	GATE_INFRA3_EXT(CLK_INFRA_USB_UTMI_CK_P1,
+			"infra_usb_utmi_ck_p1", CLK_PAD_CLK40M, 13),
 	GATE_INFRA3_TOP(CLK_INFRA_USB_XHCI_CK_P1,
 			"infra_usb_xhci_ck_p1", CLK_TOP_USB_XHCI_P1_SEL, 15),
 	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P0,
 			  "infra_pcie_gfmux_tl_ck_p0", CLK_INFRA_PCIE_GFMUX_TL_O_P0_SEL, 20),
 	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P1,
 			  "infra_pcie_gfmux_tl_ck_p1", CLK_INFRA_PCIE_GFMUX_TL_O_P1_SEL, 21),
-	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P0,
-			 "infra_pcie_pipe_ck_p0", CLK_XTAL, 24),
-	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P1,
-			 "infra_pcie_pipe_ck_p1", CLK_XTAL, 25),
+	GATE_INFRA3_EXT(CLK_INFRA_PCIE_PIPE_P0,
+			"infra_pcie_pipe_ck_p0", CLK_PAD_CLK40M, 24),
+	GATE_INFRA3_EXT(CLK_INFRA_PCIE_PIPE_P1,
+			"infra_pcie_pipe_ck_p1", CLK_PAD_CLK40M, 25),
 	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P0,
 			"infra_133m_pcie_ck_p0", CLK_TOP_SYSAXI_SEL, 28),
 	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P1,
@@ -766,13 +775,14 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 };
 
 static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.muxes_offs = CLK_INFRA_MUX_UART0_SEL,
 	.gates_offs = CLK_INFRA_66M_GPT_BCK,
 	.muxes = infracfg_mtk_mux,
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.xtal_rate = MT7987_XTAL_RATE,
 };
 
 static const struct udevice_id mt7987_infracfg_compat[] = {

-- 
2.43.0

