Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A98EB3641
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF1F83FAD;
	Tue,  3 Mar 2026 01:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D6sqIIKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29D483F70; Tue,  3 Mar 2026 01:05:15 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C0583F80
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-413d8b8e98aso120226fac.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496311; x=1773101111;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y5NX5IE7386ORPyQtswGGKsBGRG0ebDpjCxbOxwsjBI=;
 b=D6sqIIKGII/9+Zl7C5GbIEQXg4wMtXgh1bQQt3z9/IWr+CG3ukP9xSYnyArTO+G1rN
 VTWKk3rVMccfW2t8oJaz8U+56tLMDjD9yGYsy2Vc7J6lMajSiWeE+R9nLX7OXs35m/Xz
 x/aBgYaGRGRMAWEeVgJgUzh3tH2UV4oqRh7ap2sf4C7Pdvai3K9PrZHhUd11ER3iPovh
 MTc48p3fDNDDcDgqEcQnyEZxVl9CxQKGJ5++S2bvtzmYpz8wiOhpk6dkhd5B9/IKtZVE
 8ZwreTiBRDEQ5ETL4l265Sg69dONbG94vWVDorm0vmsdthFbSJ+9wU2t/5NN19GnX/Ab
 0Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496311; x=1773101111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y5NX5IE7386ORPyQtswGGKsBGRG0ebDpjCxbOxwsjBI=;
 b=RkWZ6YLj2/Lr7FqQJEopLdJoUMX78i6iVEb1AAJTtDqT4eHCZATVdHTmMEQGof6ZCM
 CG+6lS+OU+oYzqWtUe0nSstlree9j5S63ndkt1bNfcZWYRE+UcbYh/Aw1Jb+/6h4nsXH
 5zUh2fTSw9ErfMgCDIhbSGAVnBYWdtpqkFUV48QXrTkBQYRsoAinho1XhWY7bLqnZP4y
 ZuYSwR0VCfMseVsWFBjlrPHQVtFEjLFUb0FgOqFle7fDtRAzzXFLdRglv4yth4OH2RUe
 1YZ0szC/Gq2OedDePq9YtWkBcfm5yl6UOcu36wzgZracf7IRp2Y5EYwVxiKOk61uNr43
 cSfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI1xvu2v1yTbzHkv/6YwvTgjuEt5ikC/9F1xe8lxkt/tRCnLkE1e/clobJXbxEJDedBvCWUN0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzedovxi9cpR13eYluKZ3OXh6kH2fsADoxegwiC3GhvkfYJ7pw9
 RkRlR1ybghjwTFKqXZwCWmuemkNbfN3Y2aAsnQsnT9Lc57yMdj1bdf2onA9We5ImAPk=
X-Gm-Gg: ATEYQzxHwgeVfjNdHdmN8wytlOn5LfbRdXZu/DQiNdgtKMV80/YjWdmkL1hM7QiFye9
 HqCiujzo4rES6VVRSAU2dPXkMqPs56qAt78vA1vnt9ofEhvkoJ2zakNWd9SDSySuiqN034WtCXR
 pO46/OJgit5WpoA5Q0rKv6rpweuaB7bsc7d7LyofmfAAttKcfjs5F8TujXjZ0M05YFUG9Gbf//7
 fdeRnQV7bcf+vo7VidN7ONew7gsQxWGrTqTT8xX3wX3NMaatjB6Og7KPn0x4j14qg9YW8YUe7T6
 BG2efJsd4RsjCXf6zaBt2eyHquGvtZPdi3qLug+K7OppHo89jiK1mcuNWKcEnVTN86eVGY7wj7Q
 dBzFEGZCOUR4oErJXkclrPUhHH/vIiUkY9XcfSsNSeRxJBvrK/p9/i9kXmrMh/sgWK656w/yoYR
 7H4Rv0Njzn8W1jf3hVE/rnuD6t8Pdh
X-Received: by 2002:a05:6871:3326:b0:3ec:3534:56e1 with SMTP id
 586e51a60fabf-41627039c0fmr9187174fac.30.1772496310666; 
 Mon, 02 Mar 2026 16:05:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:20 -0600
Subject: [PATCH 11/14] clk: mediatek: mt8516: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-11-32f45085f4d0@baylibre.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=25250;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=2RTJ0V961UoMQj39GZW2j2zT1V7nBzSA4h2/k7lq8mA=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiWSrcEy/yRv6fFSq93c9p1Xl9BhQMNCkaV7S
 +6t+YGdhGKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlkhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4QoH/3OyK38N5GKlpNJDCYrnmXCBy3HZ0uwPsjqufmC
 eF/m61VKBddoncN5iBZZqPti8OjwYdLNWgmUpC3y4UE660x7BZxvNkSGIWGW+6+6CqRg64QxkfT
 KhuNCpdQWoTkI0k1fmwXkDMGpXub2xwBgclJ9ZWJ6WLf0XDuWUOQAqwg+v6GdLZpn76icVPO69X
 r+hEujnEVOdVOZfY+2VrSbG7WFg/O/nduuOoeVsvpar7vsObo7LdGKmbWMXui71blfGAAC3ge9d
 fES75OJitqljEfVehknN4cbl1t/WmcZ2SatzLF1t30zAlRSDPS3Th8sXsJdhwi+vODT5Vdu1xda
 7JHs=
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 786 +++++++++++++++++++-------------------
 1 file changed, 393 insertions(+), 393 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index dac4aad61ef..fe796f3f4a7 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -116,432 +116,432 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_ETH_D2, CLK_TOP_ETH_SEL, 1, 2),
 };
 
-static const int uart0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D24,
+static const struct mtk_parent uart0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
 };
 
-static const int gfmux_emi1x_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DMPLL,
-};
-
-static const int emi_ddrphy_parents[] = {
-	CLK_TOP_GFMUX_EMI1X_SEL,
-	CLK_TOP_GFMUX_EMI1X_SEL,
-};
-
-static const int ahb_infra_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D11,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D12,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D10,
-};
-
-static const int csw_mux_mfg_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D24,
-	CLK_TOP_MMPLL380M,
-};
-
-static const int msdc0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D8,
-	CLK_TOP_UNIVPLL_D8,
-	CLK_TOP_MAINPLL_D16,
-	CLK_TOP_MMPLL_200M,
-	CLK_TOP_MAINPLL_D12,
-	CLK_TOP_MMPLL_D2,
-};
-
-static const int pwm_mm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D12,
-};
-
-static const int uart1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D24,
-};
-
-static const int msdc1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D8,
-	CLK_TOP_UNIVPLL_D8,
-	CLK_TOP_MAINPLL_D16,
-	CLK_TOP_MMPLL_200M,
-	CLK_TOP_MAINPLL_D12,
-	CLK_TOP_MMPLL_D2,
-};
-
-static const int spm_52m_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D24,
-};
-
-static const int pmicspi_parents[] = {
-	CLK_TOP_UNIVPLL_D20,
-	CLK_TOP_USB_PHY48M,
-	CLK_TOP_UNIVPLL_D16,
-	CLK_TOP_CLK26M,
-};
-
-static const int qaxi_aud26m_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_AHB_INFRA_SEL,
-};
-
-static const int aud_intbus_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D22,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D11,
-};
-
-static const int nfi2x_pad_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D12,
-	CLK_TOP_MAINPLL_D8,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D10,
-	CLK_TOP_MAINPLL_D7,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D5
-};
-
-static const int nfi1x_pad_parents[] = {
-	CLK_TOP_AHB_INFRA_SEL,
-	CLK_TOP_NFI1X,
-};
-
-static const int mfg_mm_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CSW_MUX_MFG_SEL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D5,
-	CLK_TOP_MAINPLL_D7,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D14
-};
-
-static const int ddrphycfg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D16
-};
-
-static const int usb_78m_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D16,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D20,
-};
-
-static const int spinor_parents[] = {
-	CLK_TOP_CLK26M_D2,
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D40,
-	CLK_TOP_UNIVPLL_D24,
-	CLK_TOP_UNIVPLL_D20,
-	CLK_TOP_MAINPLL_D20,
-	CLK_TOP_MAINPLL_D16,
-	CLK_TOP_UNIVPLL_D12
-};
-
-static const int msdc2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D8,
-	CLK_TOP_UNIVPLL_D8,
-	CLK_TOP_MAINPLL_D16,
-	CLK_TOP_MMPLL_200M,
-	CLK_TOP_MAINPLL_D12,
-	CLK_TOP_MMPLL_D2
-};
-
-static const int eth_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D40,
-	CLK_TOP_UNIVPLL_D24,
-	CLK_TOP_UNIVPLL_D20,
-	CLK_TOP_MAINPLL_D20
-};
-
-static const int axi_mfg_in_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D11,
-	CLK_TOP_UNIVPLL_D24,
-	CLK_TOP_MMPLL380M,
-};
-
-static const int slow_mfg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D12,
-	CLK_TOP_UNIVPLL_D24
+static const struct mtk_parent gfmux_emi1x_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent emi_ddrphy_parents[] = {
+	TOP_PARENT(CLK_TOP_GFMUX_EMI1X_SEL),
+	TOP_PARENT(CLK_TOP_GFMUX_EMI1X_SEL),
+};
+
+static const struct mtk_parent ahb_infra_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D11),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D12),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D10),
+};
+
+static const struct mtk_parent csw_mux_mfg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
+	TOP_PARENT(CLK_TOP_MMPLL380M),
+};
+
+static const struct mtk_parent msdc0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D16),
+	TOP_PARENT(CLK_TOP_MMPLL_200M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D12),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent pwm_mm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D12),
+};
+
+static const struct mtk_parent uart1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
+};
+
+static const struct mtk_parent msdc1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D16),
+	TOP_PARENT(CLK_TOP_MMPLL_200M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D12),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent spm_52m_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
+};
+
+static const struct mtk_parent pmicspi_parents[] = {
+	TOP_PARENT(CLK_TOP_UNIVPLL_D20),
+	TOP_PARENT(CLK_TOP_USB_PHY48M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D16),
+	TOP_PARENT(CLK_TOP_CLK26M),
+};
+
+static const struct mtk_parent qaxi_aud26m_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_AHB_INFRA_SEL),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D22),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D11),
+};
+
+static const struct mtk_parent nfi2x_pad_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D12),
+	TOP_PARENT(CLK_TOP_MAINPLL_D8),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D10),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+};
+
+static const struct mtk_parent nfi1x_pad_parents[] = {
+	TOP_PARENT(CLK_TOP_AHB_INFRA_SEL),
+	TOP_PARENT(CLK_TOP_NFI1X),
+};
+
+static const struct mtk_parent mfg_mm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CSW_MUX_MFG_SEL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D14),
+};
+
+static const struct mtk_parent ddrphycfg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D16),
+};
+
+static const struct mtk_parent usb_78m_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D16),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D20),
+};
+
+static const struct mtk_parent spinor_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D40),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D20),
+	TOP_PARENT(CLK_TOP_MAINPLL_D20),
+	TOP_PARENT(CLK_TOP_MAINPLL_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D12),
+};
+
+static const struct mtk_parent msdc2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D16),
+	TOP_PARENT(CLK_TOP_MMPLL_200M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D12),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent eth_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D40),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D20),
+	TOP_PARENT(CLK_TOP_MAINPLL_D20),
+};
+
+static const struct mtk_parent axi_mfg_in_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D11),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
+	TOP_PARENT(CLK_TOP_MMPLL380M),
+};
+
+static const struct mtk_parent slow_mfg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D12),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
 };
-
-static const int aud1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1
-};
-
-static const int aud2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2
-};
-
-static const int aud_engen1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_RG_APLL1_D2_EN,
-	CLK_TOP_RG_APLL1_D4_EN,
-	CLK_TOP_RG_APLL1_D8_EN
+
+static const struct mtk_parent aud1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+};
+
+static const struct mtk_parent aud2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2),
+};
+
+static const struct mtk_parent aud_engen1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_RG_APLL1_D2_EN),
+	TOP_PARENT(CLK_TOP_RG_APLL1_D4_EN),
+	TOP_PARENT(CLK_TOP_RG_APLL1_D8_EN),
 };
 
-static const int aud_engen2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_RG_APLL2_D2_EN,
-	CLK_TOP_RG_APLL2_D4_EN,
-	CLK_TOP_RG_APLL2_D8_EN
+static const struct mtk_parent aud_engen2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_RG_APLL2_D2_EN),
+	TOP_PARENT(CLK_TOP_RG_APLL2_D4_EN),
+	TOP_PARENT(CLK_TOP_RG_APLL2_D8_EN),
 };
 
-static const int i2c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D20,
-	CLK_TOP_UNIVPLL_D16,
-	CLK_TOP_UNIVPLL_D12
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D20),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D12),
 };
 
-static const int aud_i2s0_m_parents[] = {
-	CLK_TOP_RG_AUD1,
-	CLK_TOP_RG_AUD2
+static const struct mtk_parent aud_i2s0_m_parents[] = {
+	TOP_PARENT(CLK_TOP_RG_AUD1),
+	TOP_PARENT(CLK_TOP_RG_AUD2),
 };
 
-static const int pwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D12
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D12),
 };
 
-static const int spi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D12,
-	CLK_TOP_UNIVPLL_D8,
-	CLK_TOP_UNIVPLL_D6
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D12),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 };
 
-static const int aud_spdifin_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2
+static const struct mtk_parent aud_spdifin_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
 };
 
-static const int uart2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D24
+static const struct mtk_parent uart2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D24),
 };
 
-static const int bsi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D10,
-	CLK_TOP_MAINPLL_D12,
-	CLK_TOP_MAINPLL_D20
+static const struct mtk_parent bsi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D10),
+	TOP_PARENT(CLK_TOP_MAINPLL_D12),
+	TOP_PARENT(CLK_TOP_MAINPLL_D20),
 };
 
-static const int dbg_atclk_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D5,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_UNIVPLL_D5
+static const struct mtk_parent dbg_atclk_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
 };
 
-static const int csw_nfiecc_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D7,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_MAINPLL_D5
+static const struct mtk_parent csw_nfiecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
 };
 
-static const int nfiecc_parents[] = {
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_NFI2X_PAD_SEL,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_CLK_NULL,
-	CLK_TOP_CSW_NFIECC_SEL,
+static const struct mtk_parent nfiecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_NFI2X_PAD_SEL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_CLK_NULL),
+	TOP_PARENT(CLK_TOP_CSW_NFIECC_SEL),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_MUX_SEL0 */
-	MUX(CLK_TOP_UART0_SEL, uart0_parents, 0x000, 0, 1),
-	MUX(CLK_TOP_GFMUX_EMI1X_SEL, gfmux_emi1x_parents, 0x000, 1, 1),
-	MUX(CLK_TOP_EMI_DDRPHY_SEL, emi_ddrphy_parents, 0x000, 2, 1),
-	MUX(CLK_TOP_AHB_INFRA_SEL, ahb_infra_parents, 0x000, 4, 4),
-	MUX(CLK_TOP_CSW_MUX_MFG_SEL, csw_mux_mfg_parents, 0x000, 8, 3),
-	MUX(CLK_TOP_MSDC0_SEL, msdc0_parents, 0x000, 11, 3),
-	MUX(CLK_TOP_PWM_MM_SEL, pwm_mm_parents, 0x000, 18, 1),
-	MUX(CLK_TOP_UART1_SEL, uart1_parents, 0x000, 19, 1),
-	MUX(CLK_TOP_MSDC1_SEL, msdc1_parents, 0x000, 20, 3),
-	MUX(CLK_TOP_SPM_52M_SEL, spm_52m_parents, 0x000, 23, 1),
-	MUX(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x000, 24, 2),
-	MUX(CLK_TOP_QAXI_AUD26M_SEL, qaxi_aud26m_parents, 0x000, 26, 1),
-	MUX(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x000, 27, 3),
+	MUX_MIXED(CLK_TOP_UART0_SEL, uart0_parents, 0x000, 0, 1),
+	MUX_MIXED(CLK_TOP_GFMUX_EMI1X_SEL, gfmux_emi1x_parents, 0x000, 1, 1),
+	MUX_MIXED(CLK_TOP_EMI_DDRPHY_SEL, emi_ddrphy_parents, 0x000, 2, 1),
+	MUX_MIXED(CLK_TOP_AHB_INFRA_SEL, ahb_infra_parents, 0x000, 4, 4),
+	MUX_MIXED(CLK_TOP_CSW_MUX_MFG_SEL, csw_mux_mfg_parents, 0x000, 8, 3),
+	MUX_MIXED(CLK_TOP_MSDC0_SEL, msdc0_parents, 0x000, 11, 3),
+	MUX_MIXED(CLK_TOP_PWM_MM_SEL, pwm_mm_parents, 0x000, 18, 1),
+	MUX_MIXED(CLK_TOP_UART1_SEL, uart1_parents, 0x000, 19, 1),
+	MUX_MIXED(CLK_TOP_MSDC1_SEL, msdc1_parents, 0x000, 20, 3),
+	MUX_MIXED(CLK_TOP_SPM_52M_SEL, spm_52m_parents, 0x000, 23, 1),
+	MUX_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x000, 24, 2),
+	MUX_MIXED(CLK_TOP_QAXI_AUD26M_SEL, qaxi_aud26m_parents, 0x000, 26, 1),
+	MUX_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x000, 27, 3),
 	/* CLK_MUX_SEL1 */
-	MUX(CLK_TOP_NFI2X_PAD_SEL, nfi2x_pad_parents, 0x004, 0, 7),
-	MUX(CLK_TOP_NFI1X_PAD_SEL, nfi1x_pad_parents, 0x004, 7, 1),
-	MUX(CLK_TOP_MFG_MM_SEL, mfg_mm_parents, 0x004, 8, 6),
-	MUX(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x004, 15, 1),
-	MUX(CLK_TOP_USB_78M_SEL, usb_78m_parents, 0x004, 20, 3),
+	MUX_MIXED(CLK_TOP_NFI2X_PAD_SEL, nfi2x_pad_parents, 0x004, 0, 7),
+	MUX_MIXED(CLK_TOP_NFI1X_PAD_SEL, nfi1x_pad_parents, 0x004, 7, 1),
+	MUX_MIXED(CLK_TOP_MFG_MM_SEL, mfg_mm_parents, 0x004, 8, 6),
+	MUX_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x004, 15, 1),
+	MUX_MIXED(CLK_TOP_USB_78M_SEL, usb_78m_parents, 0x004, 20, 3),
 	/* CLK_MUX_SEL8 */
-	MUX(CLK_TOP_SPINOR_SEL, spinor_parents, 0x040, 0, 3),
-	MUX(CLK_TOP_MSDC2_SEL, msdc2_parents, 0x040, 3, 3),
-	MUX(CLK_TOP_ETH_SEL, eth_parents, 0x040, 6, 3),
-	MUX(CLK_TOP_AXI_MFG_IN_SEL, axi_mfg_in_parents, 0x040, 18, 2),
-	MUX(CLK_TOP_SLOW_MFG_SEL, slow_mfg_parents, 0x040, 20, 2),
-	MUX(CLK_TOP_AUD1_SEL, aud1_parents, 0x040, 22, 1),
-	MUX(CLK_TOP_AUD2_SEL, aud2_parents, 0x040, 23, 1),
-	MUX(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x040, 24, 2),
-	MUX(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x040, 26, 2),
-	MUX(CLK_TOP_I2C_SEL, i2c_parents, 0x040, 28, 2),
+	MUX_MIXED(CLK_TOP_SPINOR_SEL, spinor_parents, 0x040, 0, 3),
+	MUX_MIXED(CLK_TOP_MSDC2_SEL, msdc2_parents, 0x040, 3, 3),
+	MUX_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x040, 6, 3),
+	MUX_MIXED(CLK_TOP_AXI_MFG_IN_SEL, axi_mfg_in_parents, 0x040, 18, 2),
+	MUX_MIXED(CLK_TOP_SLOW_MFG_SEL, slow_mfg_parents, 0x040, 20, 2),
+	MUX_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0x040, 22, 1),
+	MUX_MIXED(CLK_TOP_AUD2_SEL, aud2_parents, 0x040, 23, 1),
+	MUX_MIXED(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x040, 24, 2),
+	MUX_MIXED(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x040, 26, 2),
+	MUX_MIXED(CLK_TOP_I2C_SEL, i2c_parents, 0x040, 28, 2),
 	/* CLK_MUX_SEL9 */
-	MUX(CLK_TOP_AUD_I2S0_M_SEL, aud_i2s0_m_parents, 0x044, 12, 1),
-	MUX(CLK_TOP_AUD_I2S1_M_SEL, aud_i2s0_m_parents, 0x044, 13, 1),
-	MUX(CLK_TOP_AUD_I2S2_M_SEL, aud_i2s0_m_parents, 0x044, 14, 1),
-	MUX(CLK_TOP_AUD_I2S3_M_SEL, aud_i2s0_m_parents, 0x044, 15, 1),
-	MUX(CLK_TOP_AUD_I2S4_M_SEL, aud_i2s0_m_parents, 0x044, 16, 1),
-	MUX(CLK_TOP_AUD_I2S5_M_SEL, aud_i2s0_m_parents, 0x044, 17, 1),
-	MUX(CLK_TOP_AUD_SPDIF_B_SEL, aud_i2s0_m_parents, 0x044, 18, 1),
+	MUX_MIXED(CLK_TOP_AUD_I2S0_M_SEL, aud_i2s0_m_parents, 0x044, 12, 1),
+	MUX_MIXED(CLK_TOP_AUD_I2S1_M_SEL, aud_i2s0_m_parents, 0x044, 13, 1),
+	MUX_MIXED(CLK_TOP_AUD_I2S2_M_SEL, aud_i2s0_m_parents, 0x044, 14, 1),
+	MUX_MIXED(CLK_TOP_AUD_I2S3_M_SEL, aud_i2s0_m_parents, 0x044, 15, 1),
+	MUX_MIXED(CLK_TOP_AUD_I2S4_M_SEL, aud_i2s0_m_parents, 0x044, 16, 1),
+	MUX_MIXED(CLK_TOP_AUD_I2S5_M_SEL, aud_i2s0_m_parents, 0x044, 17, 1),
+	MUX_MIXED(CLK_TOP_AUD_SPDIF_B_SEL, aud_i2s0_m_parents, 0x044, 18, 1),
 	/* CLK_MUX_SEL13 */
-	MUX(CLK_TOP_PWM_SEL, pwm_parents, 0x07c, 0, 1),
-	MUX(CLK_TOP_SPI_SEL, spi_parents, 0x07c, 1, 2),
-	MUX(CLK_TOP_AUD_SPDIFIN_SEL, aud_spdifin_parents, 0x07c, 3, 1),
-	MUX(CLK_TOP_UART2_SEL, uart2_parents, 0x07c, 4, 1),
-	MUX(CLK_TOP_BSI_SEL, bsi_parents, 0x07c, 5, 2),
-	MUX(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents, 0x07c, 7, 3),
-	MUX(CLK_TOP_CSW_NFIECC_SEL, csw_nfiecc_parents, 0x07c, 10, 3),
-	MUX(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x07c, 13, 3),
+	MUX_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x07c, 0, 1),
+	MUX_MIXED(CLK_TOP_SPI_SEL, spi_parents, 0x07c, 1, 2),
+	MUX_MIXED(CLK_TOP_AUD_SPDIFIN_SEL, aud_spdifin_parents, 0x07c, 3, 1),
+	MUX_MIXED(CLK_TOP_UART2_SEL, uart2_parents, 0x07c, 4, 1),
+	MUX_MIXED(CLK_TOP_BSI_SEL, bsi_parents, 0x07c, 5, 2),
+	MUX_MIXED(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents, 0x07c, 7, 3),
+	MUX_MIXED(CLK_TOP_CSW_NFIECC_SEL, csw_nfiecc_parents, 0x07c, 10, 3),
+	MUX_MIXED(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x07c, 13, 3),
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {

-- 
2.43.0

