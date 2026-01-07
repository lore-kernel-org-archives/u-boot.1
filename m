Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48855CFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3E8840B0;
	Wed,  7 Jan 2026 17:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NcVYeC3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E5283A26; Wed,  7 Jan 2026 17:22:36 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1080883AAC
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-455bef556a8so1482633b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802953; x=1768407753;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4MuN6Hvv8jVbvqA1L1JHE1NIXi9jmpWE+FpnqiZpoNw=;
 b=NcVYeC3WQcSOPVvzrrNE5h/m+MZhY7b7DCdhkfK23foz+kJVObILx7XrCkrPWvpRUt
 Bk9ma3+AmAFnBvxJ/ekcU0J+JYrMwhiWjJ2wFDkzw/YZHWXdOkfA8C+Z96weNiqYFOUz
 vDMDIBvFGfTROKrGUfXBXdt8gu42SAlPRzmIyrF4F/neTQ2XdUk42GldcHIi5lHcOHDQ
 9D6tjywP4KODbYGlGmj+Oee0u7b6khFmb9t4FYh/Dh459ObH9aHS/hknHtrBoIGyC6RY
 DPMKnjFWBjFi/nSl2qhSjNvWyn94eiOKWSrFWSmpxv61c2aC2IVOhHCWtL4jiTOR06Sa
 EKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802953; x=1768407753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4MuN6Hvv8jVbvqA1L1JHE1NIXi9jmpWE+FpnqiZpoNw=;
 b=L6zQXuuwlHfxK7wgwX9pebvnMSP4YwgwnNOHIuM0JGYBEZNJYGDOm3DIw0HAaVuVmM
 HGgWb50w7IzFE9VRNY5dzapoWs+/LzdEoS11d80jbl4HOv68KxgaqZBuQKRBVOhJ/upH
 xd0WxVwNB+jL/SB+Cl8Y5MI1nC41dtQYG0fLPFIbeJtbg/yfWZlIA9x8DhwsQNja6l1R
 JZC/R0rfBJthtVx8FANr/oTndizqySC/1Mg1DF96bkfXOrf6tF+U7rNRUFZVCf0P1A6H
 SuvlQjrBedefiSu5omzhjeU25ZLyOfj3TG6cu/z+NfSe52c1I7sx2A6AKWpbSs9Sqh1g
 5EPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ5/wSU+0ONuH07QVXI3rWyuvR7zeiB6vYehK8JBBFYl3qoP624Y928eN9+lhRR0LFL6k6mFM=@lists.denx.de
X-Gm-Message-State: AOJu0YxNd2S3WUw/NY2lODi85pSlBJake4DSYQPDtvW2lKANBpPd5Oyy
 g4EOtkpEOcBpZwi9iEixRfBW6RAZyfiHGGeF2z/QnpRAjLZ7QVOpSof06P2zSD9n22k=
X-Gm-Gg: AY/fxX7KJKRl5/LfeEz8T9EBN6bH4NxL+eW7amP2bXfaq3P1QVdbUdo6OYo8tt/SGeB
 BE5eB9MIEAEDXlzwOSx//x2/Nw3tllLdBp+3D5mbAEiw+tZriynV/KqxmOMORvVK7gOuJgmyWfI
 rKTiVldGLi9xPTH9+p8a6g9MGm+Dh19g8nnYstS1Nqoa1FwNg0VZjnwmR2g0k2aIgeqhrQQyDdw
 hLaIBNMdLMw/wrFpAoPMDv/EemOPrtJBPk7nr1B+S1ZOdnXnxWCIPrkvtcuEhI+xD7/B2AGjMQ0
 z3+MsvMnH+YZdQWQSm2WsvIV1RbgdCSvrsyotbGQeVpDN0yOnmLArN4lYoFPm2XlXNJSaX7JCte
 sqW6can2gS1vFWtGitqfXPi0uyYsHIEaKoJfF0CBq9g4wNdDbE1u7aN6PeMZvFWEI09LddnLbX1
 JBgDuMFvArXNaOF94=
X-Google-Smtp-Source: AGHT+IEAzjfL8zbUA7FpUECkn2ucn9EdyJIX58SQ6xSXPzRLrUmVRXE+UqlJpPFJ+xUzgIrHVn4ngQ==
X-Received: by 2002:a05:6808:34e:b0:45a:76e1:2c11 with SMTP id
 5614622812f47-45a76e12dacmr312837b6e.34.1767802952771; 
 Wed, 07 Jan 2026 08:22:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:12 -0600
Subject: [PATCH v2 6/9] clk: mediatek: mt8365: split struct mtk_clk_tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-6-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ve+V2OV3jyDD/6JOGRQ4KNDZf0TvPIifKcboeOXWXLw=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDLjOjTNdab7cV2x+viga8Lc4vOs9u86ti2Zt0vwyIKHe
 axmZZ5xnYxeLAyMXAwmYoosbyRuzkvia74250bGDJhBrEwgU8RkUnJSkzPyUosckhIrczKTilL1
 kvNzGbg4BWAKI3TY/6kKcNWpcAr62c+Tjb+Y2NJsx86XKzORI1Cte+5t5T0ufCZHj3KUxq7fESc
 W+2F+E3PO8vuHthdI//+bWXDqvApXT2j7hJjqW2FishoB8kwhGvXcsqbyp5h2OlhJf2K8uHPDNi
 tx9w/Wr1+qdc/6fujxGSX7Eys6H5tsKi8Vu6l6zfC7uOSBjgCW4jZ/vidhsjqhO23uFaULH2uOl
 OrqCzeKbNnzIz0tLSx152M52Y3vbs6Tn6j2ZeH1Q9oLIuef2phYtOnEDfNL080YbvybtrNkUf/t
 hNNtvnaNoj9FmQRvS28KDpscyt2izXXb4b1p04W6Mz2MCQEzmiYHH8kvEl/StkTqx8NstWZJ1/U A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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

Split the struct mtk_clk_tree for MT8365 into separate structures for
the apmixedsys, topckgen and infracfg clock controllers. This is needed
to support moving the topckgen gates into the struct mtk_clk_tree. Since
apmixedsys can also have gates, we need separate structures.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 4d0a0487b57..eaa5c2cf0dc 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -67,6 +67,13 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	    0x03A4, 0, 0, 0),
 };
 
+static const struct mtk_clk_tree mt8365_apmixed_tree = {
+	.xtal_rate = 26 * MHZ,
+	.xtal2_rate = 26 * MHZ,
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+};
+
 /* topckgen */
 #define FIXED_CLK0(_id, _rate)						\
 	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
@@ -493,16 +500,13 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
 };
 
-static const struct mtk_clk_tree mt8365_clk_tree = {
+static const struct mtk_clk_tree mt8365_topckgen_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
 	.fdivs_offs = CLK_TOP_MFGPLL,
 	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_divs,
 	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
@@ -707,26 +711,30 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR6(CLK_IFR_SSUSB_XHCI, CLK_TOP_SSUSB_XHCI_SEL, 11),
 };
 
+static const struct mtk_clk_tree mt8365_infracfg_tree = {
+	.xtal_rate = 26 * MHZ,
+};
+
 static int mt8365_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8365_clk_tree);
+	return mtk_common_clk_init(dev, &mt8365_apmixed_tree);
 }
 
 static int mt8365_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8365_clk_tree);
+	return mtk_common_clk_init(dev, &mt8365_topckgen_tree);
 }
 
 static int mt8365_topckgen_cg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, top_clk_gates,
+	return mtk_common_clk_gate_init(dev, &mt8365_topckgen_tree, top_clk_gates,
 					ARRAY_SIZE(top_clk_gates),
 					CLK_TOP_AUD_I2S0_M);
 }
 
 static int mt8365_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, ifr_clks,
+	return mtk_common_clk_gate_init(dev, &mt8365_infracfg_tree, ifr_clks,
 					ARRAY_SIZE(ifr_clks), 0);
 }
 

-- 
2.43.0

