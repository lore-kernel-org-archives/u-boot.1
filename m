Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F5ED711C8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533E783A26;
	Fri, 19 Dec 2025 00:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GJK2DCXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E25D283106; Fri, 19 Dec 2025 00:24:49 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B768389A
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-455dc1cf59aso751841b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100286; x=1766705086;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BrhrNhhQ9am0QvXc2JFCqbybgkpuC9TB78cOz9amKcc=;
 b=GJK2DCXX7PVPzAnqv3+b7JJkWSCcn2cNgNb3X9M6t6UMfvpuftY3fkRE7ahVLmjeFf
 jza//NEKeieaW6i15CLeINT1gINxKY5C3GMB6RNkdzj0kYlZkf9GtZtEfBRa9VkyzZbB
 wpt3Zw1/IJk1uLw/NA15PhzQ8rBOJQnFwMYqg0m/0QWQPi2YgXwTGnEb5/eEGvXn5woK
 tRAv2Fz9CkwWl9NTIg9Bd5HcXolacko/Vj5Aokn7Md0YWrbVIZyHhB0K7CPhYtFUkgpl
 HMiJwwwz7e2QzTvvwjyBXsch+7J0hf7Edxoul0rGHdc7CgbylhGX9og4k8MzUTQ9rKXH
 5R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100286; x=1766705086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BrhrNhhQ9am0QvXc2JFCqbybgkpuC9TB78cOz9amKcc=;
 b=nvq0EGgsxzzIZaOGtcz0XYekuPYDeh27TmkJVaYpnbogTmTpE6Y0TMzTe/qKInvop1
 lAjP4u1PFx9IUkGoSWmJfpBuF+mH0nylo0vSeIhoJ7vkJ4zKAhrOI4q8k5MBiVQrGO/k
 iJZFo12qKLbkh00C6QD3+jS23DKqRN/YeourntzIPz+mQMVO0ijoNbJpfYqTY2pmr3WY
 tKQIUWze0NHfLxP0pLuMEC6DOxgDeG8t7p7TawXXVXf2/CX8/d0UgmgWuq0dxc2NQaht
 wIoS2i080MC6lUUv7MSomNyc0Zr3DQ8At1l3xv775PdPp1nvRgNGnWOg6fMebWb+7p2O
 9aDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+YQMRgh+1ZanfV5DQ/nYn1SrkTn8ZM5A+5rbN8Hp+9GWC3NUhBZyXEI6cmxYH1LBsqt0SB7c=@lists.denx.de
X-Gm-Message-State: AOJu0YyksjOtbtELY9lJPRtmUWvLrEKe3T6z4kliODy7KCxowN0FzTv9
 WI+jbz4QE2PCyEV4QUU7kpmhaHsrmQW7eSHxY1hGIovyFhDrw9Dowl/+/1y7t1psvA4=
X-Gm-Gg: AY/fxX7EIsIsWdTvAPFzScW2f6leNa1xlu/563ggHmM/0dHqo+cRVNKxLehqKMxpr78
 zAdyDjZN+DOdPD+koHwqhfSFLYp0cqu+Wdsi2m+2yYj1efUEIWTN2I/3keNkeZTZ16TcMY69leB
 On1EpKeTnYXLaeRlUWjuTqZtNXQ0AgtNQ6pEox5PQrb/CN0e7oww6SEpGEwFluN200sAD3YYLB+
 waFTTZkLDtnh0tOT08INlBcSjXxB0aBSwr8hKpaRBxFs4BLezEwKzomE+yJlXttjcGdMp9nt9q8
 ZCP3QhO95ovdpfAPgpqPdK8k3W5cz8dv+9DEEbxyjsvBv1Egv3xHDqV5zJTKKsTPnkM5DxUY3z0
 7vMEd8Db23O8EXkMdTD/2gqTplsUy6E2/qooiPwg9F4Umlbj40SVINBBbGdE3MGJRuO3zz+ne1S
 LVCBqDfUS0v8jJugk=
X-Google-Smtp-Source: AGHT+IETb683QL/JwLNh6jYUnaXAUe7xw2+DM5Do8cKUgbt6nig2KMEhe8WYPmADLxF4G1gDEbqjZw==
X-Received: by 2002:a05:6808:8915:20b0:450:7df:e90b with SMTP id
 5614622812f47-457b20fa95emr515092b6e.52.1766100286210; 
 Thu, 18 Dec 2025 15:24:46 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:45 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:29 -0600
Subject: [PATCH 9/9] clk: mediatek: mt8365: fix missing topckgen IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-9-4f8ff0de3268@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7408; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=g3NUKP4hQnIsAL/5Bxbiv+YqlA2RgtEBuEugq6lUz/s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0p4oLdHq72n0nCa53DF1HwS4rxT7ntzwtSn
 NIh1rZfzzqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNKRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2YAIAJqEDQIwnBSNNydq2KEvR3+0odHvTFDEaG+FN6j
 YEjbwvscdyItEpN3PdrBVdJN+1Jg6ff6UQ+WZa67WAmlKIme+E15mpqW+UeYLciBIkqoafs506k
 oMqlas5idpagQdzk7N8vYPU8f5446PwrbBdF4U8V7aIq+NDNZ3UoaUqsCThxdgsuX1tcgHSEo/w
 cgjV6qSrUljoFI8dPSSkBMKrD0UZNlsh4X+eftquFs//UVWUoAUcQawShs8hBNRpju8vIoJosVi
 jNxnK/O8d7dhERX3n3NLroukckxQHNEf5QU1rV0LuhLOJBWMzqnPbeNaeE7jATJ88vQibouKld7
 wqf4=
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

Use a ID map to add clocks for the missing CLK_TOP_CLK32K and
CLK_TOP_CLK26M that were not included in the devicetree definitions.

This fixes getting the rate of any clock that had one of these as a
parent.

CLK_TOP_UNIVPLL does not appear to be a real clock, so it is omitted
now since we can do that with the ID map as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 151 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index a28547a0cf8..6ba464097ae 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -75,6 +75,146 @@ static const struct mtk_clk_tree mt8365_apmixed_tree = {
 };
 
 /* topckgen */
+
+/*
+ * The devicetree bindings missed a few clocks and can't be changed, so we need
+ * to provide a mapping to fix the omissions.
+ */
+static const int mt8365_topckgen_id_map[] = {
+	[0 ... CLK_TOP_NR_CLK - 1]	= -1,
+	/* FIXED */
+	/* Fixed 32K oscillator is not available in devicetree definitions */
+	[CLK_TOP_CLK32K]		= 0,
+	[CLK_TOP_CLK_NULL]		= 1,
+	[CLK_TOP_I2S0_BCK]		= 2,
+	[CLK_TOP_DSI0_LNTC_DSICK]	= 3,
+	[CLK_TOP_VPLL_DPIX]		= 4,
+	[CLK_TOP_LVDSTX_CLKDIG_CTS]	= 5,
+	/* FACTOR */
+	[CLK_TOP_MFGPLL]		= 6,
+	[CLK_TOP_SYSPLL_D2]		= 7,
+	[CLK_TOP_SYSPLL1_D2]		= 8,
+	[CLK_TOP_SYSPLL1_D4]		= 9,
+	[CLK_TOP_SYSPLL1_D8]		= 10,
+	[CLK_TOP_SYSPLL1_D16]		= 11,
+	[CLK_TOP_SYSPLL_D3]		= 12,
+	[CLK_TOP_SYSPLL2_D2]		= 13,
+	[CLK_TOP_SYSPLL2_D4]		= 14,
+	[CLK_TOP_SYSPLL2_D8]		= 15,
+	[CLK_TOP_SYSPLL_D5]		= 16,
+	[CLK_TOP_SYSPLL3_D2]		= 17,
+	[CLK_TOP_SYSPLL3_D4]		= 18,
+	[CLK_TOP_SYSPLL_D7]		= 19,
+	[CLK_TOP_SYSPLL4_D2]		= 20,
+	[CLK_TOP_SYSPLL4_D4]		= 21,
+	/* Skipping CLK_TOP_UNIVPLL since isn't a real clock. */
+	[CLK_TOP_UNIVPLL_D2]		= 22,
+	[CLK_TOP_UNIVPLL1_D2]		= 23,
+	[CLK_TOP_UNIVPLL1_D4]		= 24,
+	[CLK_TOP_UNIVPLL_D3]		= 25,
+	[CLK_TOP_UNIVPLL2_D2]		= 26,
+	[CLK_TOP_UNIVPLL2_D4]		= 27,
+	[CLK_TOP_UNIVPLL2_D8]		= 28,
+	[CLK_TOP_UNIVPLL2_D32]		= 29,
+	[CLK_TOP_UNIVPLL_D5]		= 30,
+	[CLK_TOP_UNIVPLL3_D2]		= 31,
+	[CLK_TOP_UNIVPLL3_D4]		= 32,
+	[CLK_TOP_MMPLL]			= 33,
+	[CLK_TOP_MMPLL_D2]		= 34,
+	[CLK_TOP_LVDSPLL_D2]		= 35,
+	[CLK_TOP_LVDSPLL_D4]		= 36,
+	[CLK_TOP_LVDSPLL_D8]		= 37,
+	[CLK_TOP_LVDSPLL_D16]		= 38,
+	[CLK_TOP_USB20_192M]		= 39,
+	[CLK_TOP_USB20_192M_D4]		= 40,
+	[CLK_TOP_USB20_192M_D8]		= 41,
+	[CLK_TOP_USB20_192M_D16]	= 42,
+	[CLK_TOP_USB20_192M_D32]	= 43,
+	[CLK_TOP_APLL1]			= 44,
+	[CLK_TOP_APLL1_D2]		= 45,
+	[CLK_TOP_APLL1_D4]		= 46,
+	[CLK_TOP_APLL1_D8]		= 47,
+	[CLK_TOP_APLL2]			= 48,
+	[CLK_TOP_APLL2_D2]		= 49,
+	[CLK_TOP_APLL2_D4]		= 50,
+	[CLK_TOP_APLL2_D8]		= 51,
+	/* Fixed 26M oscillator is not available in devicetree definitions */
+	[CLK_TOP_CLK26M]		= 52,
+	[CLK_TOP_SYS_26M_D2]		= 53,
+	[CLK_TOP_MSDCPLL]		= 54,
+	[CLK_TOP_MSDCPLL_D2]		= 55,
+	[CLK_TOP_DSPPLL]		= 56,
+	[CLK_TOP_DSPPLL_D2]		= 57,
+	[CLK_TOP_DSPPLL_D4]		= 58,
+	[CLK_TOP_DSPPLL_D8]		= 59,
+	[CLK_TOP_APUPLL]		= 60,
+	[CLK_TOP_CLK26M_D52]		= 61,
+	/* MUX */
+	[CLK_TOP_AXI_SEL]		= 62,
+	[CLK_TOP_MEM_SEL]		= 63,
+	[CLK_TOP_MM_SEL]		= 64,
+	[CLK_TOP_SCP_SEL]		= 65,
+	[CLK_TOP_MFG_SEL]		= 66,
+	[CLK_TOP_ATB_SEL]		= 67,
+	[CLK_TOP_CAMTG_SEL]		= 68,
+	[CLK_TOP_CAMTG1_SEL]		= 69,
+	[CLK_TOP_UART_SEL]		= 70,
+	[CLK_TOP_SPI_SEL]		= 71,
+	[CLK_TOP_MSDC50_0_HC_SEL]	= 72,
+	[CLK_TOP_MSDC2_2_HC_SEL]	= 73,
+	[CLK_TOP_MSDC50_0_SEL]		= 74,
+	[CLK_TOP_MSDC50_2_SEL]		= 75,
+	[CLK_TOP_MSDC30_1_SEL]		= 76,
+	[CLK_TOP_AUDIO_SEL]		= 77,
+	[CLK_TOP_AUD_INTBUS_SEL]	= 78,
+	[CLK_TOP_AUD_1_SEL]		= 79,
+	[CLK_TOP_AUD_2_SEL]		= 80,
+	[CLK_TOP_AUD_ENGEN1_SEL]	= 81,
+	[CLK_TOP_AUD_ENGEN2_SEL]	= 82,
+	[CLK_TOP_AUD_SPDIF_SEL]		= 83,
+	[CLK_TOP_DISP_PWM_SEL]		= 84,
+	[CLK_TOP_DXCC_SEL]		= 85,
+	[CLK_TOP_SSUSB_SYS_SEL]		= 86,
+	[CLK_TOP_SSUSB_XHCI_SEL]	= 87,
+	[CLK_TOP_SPM_SEL]		= 88,
+	[CLK_TOP_I2C_SEL]		= 89,
+	[CLK_TOP_PWM_SEL]		= 90,
+	[CLK_TOP_SENIF_SEL]		= 91,
+	[CLK_TOP_AES_FDE_SEL]		= 92,
+	[CLK_TOP_CAMTM_SEL]		= 93,
+	[CLK_TOP_DPI0_SEL]		= 94,
+	[CLK_TOP_DPI1_SEL]		= 95,
+	[CLK_TOP_DSP_SEL]		= 96,
+	[CLK_TOP_NFI2X_SEL]		= 97,
+	[CLK_TOP_NFIECC_SEL]		= 98,
+	[CLK_TOP_ECC_SEL]		= 99,
+	[CLK_TOP_ETH_SEL]		= 100,
+	[CLK_TOP_GCPU_SEL]		= 101,
+	[CLK_TOP_GCPU_CPM_SEL]		= 102,
+	[CLK_TOP_APU_SEL]		= 103,
+	[CLK_TOP_APU_IF_SEL]		= 104,
+	/* GATE */
+	[CLK_TOP_AUD_I2S0_M]		= 105,
+	[CLK_TOP_AUD_I2S1_M]		= 106,
+	[CLK_TOP_AUD_I2S2_M]		= 107,
+	[CLK_TOP_AUD_I2S3_M]		= 108,
+	[CLK_TOP_AUD_TDMOUT_M]		= 109,
+	[CLK_TOP_AUD_TDMOUT_B]		= 110,
+	[CLK_TOP_AUD_TDMIN_M]		= 111,
+	[CLK_TOP_AUD_TDMIN_B]		= 112,
+	[CLK_TOP_AUD_SPDIF_M]		= 113,
+	[CLK_TOP_USB20_48M_EN]		= 114,
+	[CLK_TOP_UNIVPLL_48M_EN]	= 115,
+	[CLK_TOP_LVDSTX_CLKDIG_EN]	= 116,
+	[CLK_TOP_VPLL_DPIX_EN]		= 117,
+	[CLK_TOP_SSUSB_TOP_CK_EN]	= 118,
+	[CLK_TOP_SSUSB_PHY_CK_EN]	= 119,
+	[CLK_TOP_CONN_32K]		= 120,
+	[CLK_TOP_CONN_26M]		= 121,
+	[CLK_TOP_DSP_32K]		= 122,
+	[CLK_TOP_DSP_26M]		= 123,
+};
+
 #define FIXED_CLK0(_id, _rate)						\
 	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
 
@@ -82,6 +222,7 @@ static const struct mtk_clk_tree mt8365_apmixed_tree = {
 	FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
+	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 0),
 	FIXED_CLK1(CLK_TOP_I2S0_BCK, 26000000),
 	FIXED_CLK0(CLK_TOP_DSI0_LNTC_DSICK, 75000000),
@@ -115,7 +256,6 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", CLK_APMIXED_MAINPLL, 1, 7),
 	PLL_FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", CLK_APMIXED_MAINPLL, 1, 14),
 	PLL_FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", CLK_APMIXED_MAINPLL, 1, 28),
-	PLL_FACTOR(CLK_TOP_UNIVPLL, "univpll", CLK_APMIXED_UNIV_EN, 1, 2),
 	PLL_FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", CLK_APMIXED_UNIVPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", CLK_APMIXED_UNIVPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", CLK_APMIXED_UNIVPLL, 1, 8),
@@ -146,6 +286,7 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR1(CLK_TOP_APLL2_D2, "apll2_d2", CLK_TOP_APLL2, 1, 2),
 	PLL_FACTOR1(CLK_TOP_APLL2_D4, "apll2_d4", CLK_TOP_APLL2, 1, 4),
 	PLL_FACTOR1(CLK_TOP_APLL2_D8, "apll2_d8", CLK_TOP_APLL2, 1, 8),
+	PLL_FACTOR2(CLK_TOP_CLK26M, "clk26m_ck", CLK_XTAL, 1, 1),
 	PLL_FACTOR2(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
 	PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL, 1, 2),
@@ -567,9 +708,11 @@ static const struct mtk_gate top_clk_gates[] = {
 
 static const struct mtk_clk_tree mt8365_topckgen_tree = {
 	.xtal_rate = 26 * MHZ,
-	.fdivs_offs = CLK_TOP_MFGPLL,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.gates_offs = CLK_TOP_AUD_I2S0_M,
+	.id_offs_map = mt8365_topckgen_id_map,
+	.id_offs_map_size = ARRAY_SIZE(mt8365_topckgen_id_map),
+	.fdivs_offs = mt8365_topckgen_id_map[CLK_TOP_MFGPLL],
+	.muxes_offs = mt8365_topckgen_id_map[CLK_TOP_AXI_SEL],
+	.gates_offs = mt8365_topckgen_id_map[CLK_TOP_AUD_I2S0_M],
 	.fclks = top_fixed_clks,
 	.fdivs = top_divs,
 	.muxes = top_muxes,

-- 
2.43.0

