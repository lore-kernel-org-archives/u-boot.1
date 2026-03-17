Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2681AFF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D590D843FF;
	Wed, 18 Mar 2026 00:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kaAAMpuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC278430F; Wed, 18 Mar 2026 00:26:42 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46633842D2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-41708f6c3feso4122495fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789998; x=1774394798;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YXVy4y2U7WIi70r8/CaOva3XDjE6AxoM1i+a6o2Kk10=;
 b=kaAAMpuVnOmGdMfLxUpVk/Y0eP44nUW3U7+Yalb4ZAedl15guZcjyct1+sw5lEK06v
 16GTPYAxr0+/oLGK4AgFes55iPbOyPi4R6AdoJuK33e1tJGEzdZXni6BvII3ic4Z9WFr
 +lPFZJ5EsA4Ef0ebZyQvnwBr4Gn6lD3wifk6UIxB2Lq560Opu1NvjmY2zcLWb5r7PEpE
 WcqjHctMGDhZZm+oztJkFyv7S0RErvTBe9dQd2/HQHfNOjx6QEoZUDRgpQRwoMoMsJfw
 Sj3iQXji6iE7bLHDIm3H+Ne6GeYmCYhgsWaqOZTHlbeY1McTT7GHU8HZ04gmB4gfeOZK
 Kihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789998; x=1774394798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YXVy4y2U7WIi70r8/CaOva3XDjE6AxoM1i+a6o2Kk10=;
 b=mq86hy+PLRQMoJ82KHLb6N3aCckReZzlfp0GeqO09AnkFq2Fuebu5+3uDJbMdB+82Y
 hXEg/+EkRD8h1bjeiUKl28a1lwuF337l1SLZ/fD+ATP00faKccqV7SsQfvOJmWxPVhDl
 LBUG7p8av6mrMS/rHrr3/VaV27xCO6KvwawYziSqdE2bpb8/3goXb9hllJ9NJAT80vNJ
 j/8CRDFMFzTEmE/ujtAx7HDjIF6HttFapMkSWoOlBFTq8P3JttWU8ORJSueNC9dAi3Ei
 JZVOq7lxklDhi/Zx1hWvH6OXS43iP2yUZmzm2lvxXmsCVBvckUB+LrGD0p/46iCSh1B1
 BRQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFmiJxNGr0o8/kPJNRB1tcKIe2lvktLwul4NyVc1ucbuP4ZpFhnNtC2RDhFEvM/PJcd/gMfvc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgg3GFdhacoGORfVS9jW7VMxxmlpslehHs2YRR8YlTCrSCXqpg
 Sud4gse2MEaauQPnBVkdg2V7usJBVl4pnU/HNqf26DQIW4//nUQA0dw+Ap3sSx3qLjs=
X-Gm-Gg: ATEYQzzCaVOuLOOJl5AhnJykfkhpbLVffB3bEa70/6IGpJItlVGA+MtzTkPpm9QSb/p
 8rW3eQQr+EXKNzeg0jRN2/xq0Wn1Fx6o9qJtWw9Ek9TBwJ7XBD+fUvyfvAAAljCGDDFWypb4AfU
 ywXpml1OeWqa2YOwFzYvDpla4Qhkzp7YmQtsmyDkOpZrxgRk+57LuN9D/ZSpMoN9snK4Zhg3ph9
 0bWyd4YyoRPOeOmoFfU2KVhJi8chSb5v483utsmUt0bWniSQKWLHls7qh1BslxZe9yS8BWWEF+X
 DR2kUgN2bV0xw8ymELnAYQMUEqzgrTUUSW6nF9SdToY9kblVCnvk9caNAN6UXfAkntMMZmH9WIG
 6k8CkfVsm6iaiYLcVwYeKTXbVtbNC7uAcxRwc6vvYIgto2YBL1YfQlZN9Z8EOKnzuWZ9BE/CBVL
 QAaSE9L/45zVa7BvcOploibO/hDw==
X-Received: by 2002:a05:6871:7282:b0:409:9a0b:b733 with SMTP id
 586e51a60fabf-41bd3e412e2mr887366fac.10.1773789997526; 
 Tue, 17 Mar 2026 16:26:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:25 -0500
Subject: [PATCH v3 12/16] clk: mediatek: mt8516: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-12-a4760f5b0a80@baylibre.com>
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25250;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=m6KQFXHqx+YYxNACYNVy2hpSjdXQePSuG5mUddY5ZVI=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGm54wGiN9ujDMB5VuuNYqu/GSknFLyiQohlBXs+u3uwSN9FG
 IkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJpueMBFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8CVvwf/YRLgOlRW30bfVcyaQ3rh4xFPv5Pad22A7XJkmDgEGeXidzq
 7fqwKu0z1CP9wgWYAZVtVrXcZ/zUGtuTvO6duDqEH21CGqrGt3KDUiwiA3DhApo2wcW+AIujaD+
 ppwiHNyr0nM0pPfjP53XJu+urJD/9QsqjWRPrHaXKfeEY6k5PjQIHGNpwT8H35990S067J2CRux
 TSk00958AnyAa1uT/UArI+5tOvhsfuG/HDV7JCeJPP0Mu276TIisplioMUbiJyP33tmBpY93MaH
 HQkNg/ZoP3gfvplghC5P3olN8M2TEJymK+COBKoNrIcGiU0dTjRyRGcOYqDmJrn8ZZ0PzQ==
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
index 9d03e245886..bf62a4aa3a4 100644
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

