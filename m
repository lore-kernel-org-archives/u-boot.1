Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B28D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87807839D5;
	Fri, 19 Dec 2025 00:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="il4GsIR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4B4835FD; Fri, 19 Dec 2025 00:24:46 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1DD3836A3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450be85b7d9so719405b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100282; x=1766705082;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4MuN6Hvv8jVbvqA1L1JHE1NIXi9jmpWE+FpnqiZpoNw=;
 b=il4GsIR5XHYSL7gJ8UtP27MjXhgj/pgpzUOy7/2Admo0gLxgE5CLyhBRi394EWOnZT
 w8GY3qns/R6Pot1VA/X4zxcDkrHeBz6dEpV2pjlal2YDiIYuMWDsFBCDgqvpcIm/rfAg
 2UsLicix/oUs7glTnaVF/4T98tI0x50cJAAYea5SLlecfYofzNfOhaw3TKKAGmWSH5Yi
 tRQVRkfrbEN66ILUJohDvtKPeePOMGwS78/84XXNYutUvinisVzrqU/iJYsMKHf5SS8H
 E3eFNzSH0pke309f6ZHiDYEDhYDaPJ6cIHcCb3hOZvEqDLVhrs9JjjufEiJMwNUjOE9Q
 on7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100282; x=1766705082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4MuN6Hvv8jVbvqA1L1JHE1NIXi9jmpWE+FpnqiZpoNw=;
 b=Yl1i7AONg4GScAM9EEIEDazG7LMqlFRm+A7gHxzquh86Urx92jpG+X3xKzWFCqnKM2
 Myypuvc01J08S7HH0KaueDyO/P93IgwVJWpvHj2k2T/vJtwTMLnDIvNJGzN5ExOMf3u9
 6yDmqA3syo/D5bnId0MYRV0VPot4sdqFo1byWsIArap8LhyT5nsucNGmlx6+9B2uEBLT
 e1/p/6/QgjfMdcNGjq1j4uvFYmqU0D9plNmue3jpvXe+ZZAEfVI3b11MiOapkECl6zeU
 2NppwifA2e7+a4gajuMukjlAnNBNmCsPEyf7VI0/mby3QKzw9chXWIByIKFNPP4jAd8U
 FcRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3TwKZk7zAkYs87dz4oR+k3umSHK1jTB9tb/5fknrwaSaUoGxCPSqL/RJDQJ/N/Yf71VJOJX4=@lists.denx.de
X-Gm-Message-State: AOJu0YxC34CfGFEto+NX57qM1Mbx4bjmbd/IbPVbCvXJA1S0FqzCJd44
 l0/msEy4wrceORYo7eHo2aYMtuAb9nT5wvc3E/oWUK46E+fVWCrzyZu1HX/tzv1NF34=
X-Gm-Gg: AY/fxX66kAP139czAnjlHzZZkPIhdsgkRfsZDg1W4nRe27UBwXtZ9pDA913b4nnE8mW
 qBpqgN79781mphLaDWMkXN25xYG+ONso6L4YhRYJVlTSl75Lgy3oqIVI5ycFWT66D/lMLHzVtMK
 ZpnLSt56Oe3NhGX0G/3GD+nVpM0QGYoqLJrLZBOOIgiB3e1lFZYZ4NfBbAVhbM87/D+NJhBvzhv
 BjPAsCIAo064SOxUZ9TngMeeG8QTOQcxmIQ1NarqqyJXut3QJpsYHLXMVz4buLQgJaZy1jOZvek
 byJ6FOIgN66ZsH7mVH8DZ72ldV1JpG3fhSkz/J3wAq33T5GmU1XbkU5Nev6m8oweUpcOQUbVyT7
 xvcXCkak/hLvnmkBiTpbv1zPjimCQ2+jAdS4Hrx5dZPGoB9La0KC69hkwuNDTCMW7JjPjnBgC6k
 IODatWMNnWpmgHfS0=
X-Google-Smtp-Source: AGHT+IF/Oaex2fEg2wg4C9E9/P7jEY77AmF/xEaA5CFYWkOjx8/cCUanuzys/e5qAeGrM9iuifDPFg==
X-Received: by 2002:a05:6808:218b:b0:450:c423:205d with SMTP id
 5614622812f47-457b22238camr611878b6e.46.1766100282500; 
 Thu, 18 Dec 2025 15:24:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:42 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:26 -0600
Subject: [PATCH 6/9] clk: mediatek: mt8365: split struct mtk_clk_tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-6-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0WmceCNjksN6sjaXW+9UAH9IBBRH53+WPJu
 UlcFRPty3yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNFhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqXcH/210vqNkzF8dbXL2FtBqUd8H9R8EkTEgR0cHc7V
 /5sDyoXjkUH8KPUkK9goKGaDIJOVV10h0ZvarxGRGrHFTfUe1MP2gNCW9V19LQAGqXUX5oyUZ0x
 9IYPBk4HthtG7gOD8WoyfxDsPQKcbOwliT91kSncK9qx7NlyiQf2JpkARg1CQRnEu2KlPGRL3Uw
 B7U2ATeHRRzp5piOy63OriVx7f+rNJx/elIuzutGmH18DkrIyV5S0lRLcyaNtC0M25XQ/EC/W6H
 hARtuyU3xRmUgeGh13t2xheg1xqJ6bxxjzCiZZSBlM3K9qv2MCX/9LhK/m0Zb5G+6XquOHF6kRb
 hNis=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

