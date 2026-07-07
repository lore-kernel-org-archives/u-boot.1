Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE72C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539A084AA1;
	Tue,  7 Jul 2026 17:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZO72v6g9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185EB84A6F; Tue,  7 Jul 2026 17:10:47 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA4184942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a190528769so1593979eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437044; x=1784041844; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=An61PYHigeqX3NfNAdnR3p1a6iTo4NVVdrplE/Enkn8=;
 b=ZO72v6g9nC137rqD8bXMctbdicYPY11XuK4ke3+OjvRU6c/VpVi4xhsxwO2RO3dZES
 AxKc6nFAgG1uGQdQYiitzmMeC9cDYRmuVGGeEeXP6SH3I9DKbnW6SOtkUm4n+WojVCdJ
 KTfmtdQtQe3fMXFmXc1STmXEFGElNd5feoAJTnBtmLWDDPiICXYb7+s6owHmvxHpKJuB
 nP7ClwyksBMfbgvw8QaemliBb3hktR52SoGudE8X0IX9uO6s57ZLNpACbTdAUEi3hr8y
 mtbnob4S8eigURvMMXEqN1nuggmQ/F9RhX4EeaWQNgzLyIsIDnrQ/QRhXuMILF33bUam
 ztKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437044; x=1784041844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=An61PYHigeqX3NfNAdnR3p1a6iTo4NVVdrplE/Enkn8=;
 b=Ogfrx4Vw7MIwnVOl6g/0DYkj2zANUdhtxWFCqPOxOVSAjiskDIHpcA8WGJVo/0d86g
 02oFS7h36KBU13iM4w/aO2H9FNje4ls7M2EtCnN7/Axd+f23jQvxT4iKwKLmszNlUf/w
 NT8aoKCO+7bln3uUk1/4exgke9g5sdxau6+XzwzEpUU46tiz381pUi9pnglZfg8jmivu
 y0M5nj5XyJhse2CGXx/pxYJPtOf3Gn5RwdwO1uob8dK0CHttMWZ2KRbFuxKNUpZiCLKB
 230Bq+I5ozFHIbsqNWsU6JOYopOqxC6tWL95dafroH61UzdcnGGVjc39DLpNw9pUIZOk
 zd9w==
X-Gm-Message-State: AOJu0YxqlLS+mRNkyblVzGYjYU5cehyhJQw01UcSkveIaeqwrirKXg+U
 Ebx/2tZba0qW3j7jQOuwgkdSg7AeAd3mS2fPNjqa016wpSAF/tch5eVtIT1iFGbSb2E=
X-Gm-Gg: AfdE7ckQepK0TFXqCQhl14OliHBrfcvLbtItUiqmDTllisnQrDqKIIiquyznfddYx3w
 HdoQ7XNygbA288fpD8/rKmQ0e3+Xo/2ci4uq8UpuVTv6n4AvvsUSyeU/EjPmRcwuqHOrEkhf1Fm
 /97Z860W//VT7ZGMiHJFnInQuUYw5kdfr/NpD0GEekO/Q43SyUWN6xy/DXtCkHFNKs/obxuTKY9
 uU2R9CL3qcffycsqKXDz8Et1Y6N7LrCe72OzF17F2ZmOIwfm0EusgQ3HY/DXRURRQqpbk3MlSoU
 Pb29hjML8kC+n7FXmlHnIJH7Ki+WotH+JZc6D/MxWCGamwsCeyKBQFNdcpX3R+t3UgscMaXa+e8
 8ShOS8vk5OAAK2eOmoYalfAKaIZYHN45T104JYoZc60Das+D7ZPApcNNfCKIUcc/UUXSbz000my
 JVNG1DqyoXbip/m+6NJVGUlTTC55T3
X-Received: by 2002:a05:6820:4d08:b0:6a1:8606:44c2 with SMTP id
 006d021491bc7-6a35572fe4bmr3136162eaf.54.1783437043703; 
 Tue, 07 Jul 2026 08:10:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:35 -0500
Subject: [PATCH 15/24] clk: mediaTek: mt8512: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-15-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=AX9yZqWIWQM1c9UUJwCauymIxTHrHjkzB8RJNdZF0eY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRaUGgXAdCrzZ+lNLJ/hGU6Kix9kVwnS/n1Gq
 WNNYYAhxR2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WlBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmWsIAIzYBK96fLyz6y1WA2Em7lbeYr11oTyDMF/Sl4f
 nltj97mxKkFmNrb3v/mjJKa0mcqTyMelhgMgXJRSwVOrYYzM4kLNRXGDb64hWyO+HRu7gxkwNwu
 dHd3uN63/GJ7HiNS7WUXNV8pvsxfHCFhs3I7+brvZQl9ho/YHAs3Q8XJHC5+jW+5EuaG9b0hmzS
 p4br7deYQYvGntwDHnE91Lf+QAV4dwjHO2NuRSVep8UzRwuTIojM6o6QvskrFAR3/O/PpIhbEzh
 jaqvGB/2Hn4TiR/2n5tbg7lAutwvbo8WFqSVKxy1ngI9ILGQCnmOgUN7IdcTlIXeiAf73YJJbH4
 sbss=
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

Add clock tree type flags to the mt8512 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index d6e58be8e22..2b0f0a38f81 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -792,30 +792,42 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA5(CLK_INFRA_USB_XHCI, CLK_TOP_SSUSB_XHCI_SEL, 11),
 };
 
-static const struct mtk_clk_tree mt8512_clk_tree = {
+static const struct mtk_clk_tree mt8512_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8512_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_SYSPLL1_D2,
 	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt8512_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8512_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8512_clk_tree);
+	return mtk_common_clk_init(dev, &mt8512_apmixed_clk_tree);
 }
 
 static int mt8512_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8512_clk_tree);
+	return mtk_common_clk_init(dev, &mt8512_topckgen_clk_tree);
 }
 
 static int mt8512_topckgen_cg_probe(struct udevice *dev)

-- 
2.43.0

