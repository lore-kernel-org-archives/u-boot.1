Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282B0F51416
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2D583F86;
	Fri,  6 Mar 2026 23:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IRAZv65Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9C283FE9; Fri,  6 Mar 2026 23:07:12 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC1083FC1
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d556c1a79eso11175530a34.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834828; x=1773439628;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rYp6XxeMiJDD7l1lifsa5G5jvqkEEkKyfDBgvd55uko=;
 b=IRAZv65YLlS7LjbowrfI0GeO+RayS4d6fa9cVQZtzCZKvJlOS0bayBjmvzZZkTVaLZ
 ys4lOeClK02v47uUikKNMF1DL61aVFbkqSndT6NUN5/5ShbLNrXJuApUz/T6sSG3QjmR
 l+MtG05qJw3odlySEwMNw8qX3PTIpOzIbfv47S8N+SFxISYTHJwlPORHzBZUIj6a5tF+
 Po+EQtajs6Oro/Dp2NkoNmmyEXDHTXaXBBdTBPARDi8AEpTlsmlYkfq3Ow6Cx8GMD/vZ
 sqKbvGEZzqGqDbRcQivHYPScRhilNVXMcDyBTOvV9KjCu4WE4v9/lyVzKK/R3xaiouKg
 sprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834828; x=1773439628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rYp6XxeMiJDD7l1lifsa5G5jvqkEEkKyfDBgvd55uko=;
 b=Ff6lylnO2mvQpIQbMnBNA/6ORKdDwWIg2Scpu3tCvZcNi+2AiCcZLyh/ToFOHt9zK+
 eX8yTythydD2DDsFtQUuwYJRowXMPqGzqejSweyzEUev0CEIzuVRowjxP0ddTqjZotkf
 QWr49Y9OydLBucE6Ba9XvSCX6pT0eAGARc4ZB4cm0jKSnQiLAd30dF1QOgM0/LM3sCKf
 7ahpFi5dh4V576MXGI7qaDQrcvfjDA8pSVRI2MdRNyro6c40+uXKQQRaJw6PhCrbOaDb
 oZKAdcQVNI0egMQawwY2Y6hDO23KOQJXmVYx45ttRRTZ2oe1fW46ZbT+kHlzgCPug+l5
 Q/xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeMbYEzY16wiZUIEW59bmFFTMU3o5OFeOLWZt3fdPstVWXl4oXmarcFes4vGmN0CEc2cwG4fw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6xU2sSu8EDBDUlV99SE278vdIEIh7V9ZkDxzkR646STPjr/ZQ
 uEwRF0gt3sh26+Bp0/EBuxJckO8svro3BXPozFEQMfbUL4MGkKnUZS7h6Vyb+CvxWKI=
X-Gm-Gg: ATEYQzxV1o5Ap0bjmLCFFnLfrJP7zF/Jw08hje7e3znoKtw/GuFMqYVmVPQV0nwrJwf
 WdlY+7Wq8is1alkpg6LZPGgZyAjlvc0LawavuhbghfvtoKTedAqfik3kIxPGOq/r9BaA6vloR1g
 nKSMSEmfVz5mw9RaqfbbggueJRCGZy9zXj3qRSi+77OFztMIiSXj1sYdTYNGRe2BiuXXczZWCeX
 zqGey82t/RB3n+iBpfdAz/7TJB5nsdoagbw+lCTnwTGhGF+AR8SHhttNCq//bg2FDMOTz9dUs5b
 kwp9IQYXVjle4l1dA2zXwZM12vWOO6naPN9xpE0JOcEu9q6lcsZqmgH6wcQgh2LkC3gR8IPYuWm
 nS0Dli86jX/E6WKVfxzMvFxHJ8aK8bXKwyV2+0CD8Ayj8gIgAhC1F88doxe3C1wG2ctY6LlSelu
 2artPtFQBxgv9mEpUYHiz5pHitBA2D4ybFaePTDwg=
X-Received: by 2002:a05:6830:442b:b0:7d4:c288:10e0 with SMTP id
 46e09a7af769-7d726e972e8mr2660771a34.8.1772834828168; 
 Fri, 06 Mar 2026 14:07:08 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:52 -0600
Subject: [PATCH v2 5/9] clk: mediatek: mt7622: change to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-5-b253b49f17b2@baylibre.com>
References: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
In-Reply-To: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13396;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=fUhQbdowlAfC+BuRp5BL1MIdbGpdBLPYXAUuAzIaDdI=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/lt6VF2zYu46voKss4DlnGsfP0Fox9k16NI
 W14icAnIDSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP5RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5/wH/0OxuWBzDEbttsCg+Hybw57l6D62qCNKLMkZXiA
 99Fs2rph+1gzRpNkHv1hVHx66VC+AypoggWtf61Qt0m1hzAikw6gflxqRKrTM85F23vpBNqVl/F
 WiXYQ/Y5IGheXOelcPduYLTkAz7v9g7/bb7CUphyn82esPq1Ao/mXWeTnlOalQ+1YgNrfXND/Pt
 dE79AtwMsnQEB7tM+WZhjHvQ/dTNqZ+Uoz+i9RjRdQCVjPeyx/cyPqnT2fszXLT8ArVtBhQRRu0
 5/F+NTCjYYgOPqcCEG/+lnSVjhQJx9/CgJhVkNpPknXsOlD7pmrrMXpqSmvGYkWodLZwUgodYJ5
 CysQ=
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

Change mux parents to use struct mtk_parent instead of int. Since these
clocks have mixed parents, we should be using struct mtk_parent which
specifically handles this case.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 326 +++++++++++++++++++-------------------
 1 file changed, 163 insertions(+), 163 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 9b62d964318..27663549928 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -159,231 +159,231 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_ETH_500M, CLK_APMIXED_ETH1PLL, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL_D7
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
-static const int mem_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_DMPLL
+static const struct mtk_parent mem_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_DMPLL),
 };
 
-static const int ddrphycfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent ddrphycfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int eth_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	-1,
-	CLK_TOP_UNIVPLL_D7
+static const struct mtk_parent eth_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int f10m_ref_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D16
+static const struct mtk_parent f10m_ref_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
 };
 
-static const int nfi_infra_parents[] = {
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D4
+static const struct mtk_parent nfi_infra_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
-static const int flash_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D80_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent flash_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int spi0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent spi0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int spi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent spi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int msdc30_0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M
+static const struct mtk_parent msdc30_0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
 };
 
-static const int a1sys_hp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL,
-	CLK_TOP_AUD2PLL,
-	CLK_XTAL
+static const struct mtk_parent a1sys_hp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL),
+	TOP_PARENT(CLK_TOP_AUD2PLL),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int intdir_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_SGMIIPLL
+static const struct mtk_parent intdir_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_SGMIIPLL),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL3_D2
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 };
 
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	-1,
-	-1,
-	-1,
-	-1,
-	CLK_TOP_UNIVPLL2_D16
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	VOID_PARENT,
+	VOID_PARENT,
+	VOID_PARENT,
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
 };
 
-static const int atb_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5
+static const struct mtk_parent atb_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
-static const int audio_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_UNIVPLL1_D16
+static const struct mtk_parent audio_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D16),
 };
 
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int aud1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL
+static const struct mtk_parent aud1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL),
 };
 
-static const int asm_l_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent asm_l_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int apll1_ck_parents[] = {
-	CLK_TOP_AUD1_SEL,
-	CLK_TOP_AUD2_SEL
+static const struct mtk_parent apll1_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD1_SEL),
+	TOP_PARENT(CLK_TOP_AUD2_SEL),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
 
 	/* CLK_CFG_1 */
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
-	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
 	/* CLK_CFG_2 */
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
-	MUX_GATE(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
 
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
-	MUX_GATE(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
-	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
-	MUX_GATE(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
 
 	/* CLK_AUDDIV_0 */
-	MUX(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
-	MUX(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
-	MUX(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
-	MUX(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
-	MUX(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
-	MUX(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
+	MUX_MIXED(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
+	MUX_MIXED(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
+	MUX_MIXED(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
+	MUX_MIXED(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
+	MUX_MIXED(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
+	MUX_MIXED(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
 };
 
 /* infracfg */

-- 
2.43.0

