Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED2EEB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5477A83F93;
	Tue,  3 Mar 2026 01:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MrSiXrGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7ABD83F9B; Tue,  3 Mar 2026 01:05:17 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C074283F63
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-414ffb4c0a0so213499fac.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496307; x=1773101107;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BtJUfaQqgxYZpqIvTMsaQLVOyl+mi1JoATK8kXgxei0=;
 b=MrSiXrGn0RALhTprVvBXWuxhey8m1hpJz+7tvIzA1mNq0QjezVdJ7tj79R8uuff/F7
 uVrEjuYaW8pdb+hd/qHzEDnz6xOlletHTCJ3SJbhnpbbMtLjdlJe7/WiFgpcy/Okpgga
 P6ct/LaSIliFPftm5qeHoX49WPPTx2B5Dm7utJwTjWmPYJVka75BFFV1kDYD4HRFvH0Z
 wIXB8Lp8K9idzocJMVaipZePdOGAuXDQfdur7cxX5zXx3qlJzcnRVqdCZvKUcGP6nNXP
 Ly1Gtu0fyABvVM9rAMNtPMQLC3VIGhQXlBLzmSnPG6EHUuLWZf6wH8s+51tIi1qkV85H
 GP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496307; x=1773101107;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BtJUfaQqgxYZpqIvTMsaQLVOyl+mi1JoATK8kXgxei0=;
 b=FkNdppC98JIXGLUJZxaQ40O+pxCeCmXghl8KNXi9SikhifRvOEqy052EHg8km/rONa
 SUiav+j6YBUsxWVMXQu20zdq8kuuF2FU/uYXMc33hyNrUqUZSy3WPjGejfGnjiWeCUva
 2EXuxXG2WUhbDQa1iWKl/pQRZ8cwJvKxSkXWjrPsVFsPUjPmKCqjwD2eZSATyUOCDnlY
 UngZGmx8jFEwhfoNCMbdqEbdiYwwgxpGuHylSbYf6NEtPFOfCupmF1o7LONeRBzs53Xf
 OGc3tUPicUowsxy9tRGZjSDJx6W6t8PMdMg6O1R0ICTpnR1CY7+/SFXOTPNzKMQokawa
 fxVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3jdYY4/O2AXwrm3erqiBi0NlWXCgYbMeF1hCgouJFN0ZytG8VMTjQw8lCL08lVDx8J0ZFqVk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3Njygve7ncrUtaRqq8o9ZUPdv+AE1GYKRbzWa9Ii09zujG8yQ
 oSDFS/sQcC/BxbimG+kqBj+YdRG+kW/LHpwNW4VGgHg7Ax6Kcay9Hjrn4rISJWML/MQ=
X-Gm-Gg: ATEYQzzdlRiPH2cZIb2kUDvGrA829EJ5bcGZ88R3DQg8ycpfL65ZXF9LG903LZ8aFU/
 B1KPl2TSGIerHDlYda5HtxSOv290Lo4HFzjocjQ+oPM15Qpv3ZVhWl4TJptf2WrJM5s1VZvRp4q
 NAotJyVVyIIHfTnze9hIwfYBXL6WBO8jvztfDKsYSpygNlLqNcuznNRoyA4BGJf4IYA+DPm43pe
 o19yjuF6HNi3uUnKC/u3vBe9DR8lhthhH1FvynHY/7iO2Qn53c6o0P9kS4Aur6GsCS9VKqB9bCt
 oiM2CsgQxueQysz/QyEQ+i1uPZJ82pmeuwXX/JgKs2HCKlIZF8MgFywmycflhsmu/Y7COl0i7V6
 PnIPGRocIE8qmQQimSRaYGpfhG6RoVfmYpJ28ABWTo3GWTQww5VjRZdemF9wxzIDaOceKIfqoar
 2HB8lAm1yD/WiK55QVFxQxv1gyVYJo
X-Received: by 2002:a05:6871:28a3:b0:409:b5a3:42bb with SMTP id
 586e51a60fabf-41627055cb8mr8847772fac.31.1772496307126; 
 Mon, 02 Mar 2026 16:05:07 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:16 -0600
Subject: [PATCH 07/14] clk: mediatek: mt8188: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-7-32f45085f4d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=55294;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=yf3zWqxMUn0PJBW0leYASgs8GXapP+GCp/Xdxul6WLM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiV43ax0/14FwSQp2u96zOi5GOP32nKkJATGm
 MqwVypurFiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYleBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsvwH/jtFfYE0wmhpnezlYxlmonGt0B0/10qYuX0VOBd
 G5oYKZYRZ6ykNpIL+Ax+u+VHZLn3nZCko2VCuQCZ6z1EFhLl2Qzh0V8E74L93FegmBJa/TVf7PE
 vSb+lEMaDy1e+YJ9LpzehNEUetZlUkP+76qxwby5O7gH4L+lWGAGEErRB5W7ehPSDu7QK+43gmX
 fSBZXVgucvTAR4arCDCDDb0XbnN1fHQ/MvBSXmOT/2pvGw9/bWfoe5NZTQBnjZ13EVo3gTBu8zF
 Q4Ps2+ENyUsMabjYQRzBF9sSA7uNjKstqAzVZc8rCyHME+K6T8ftUDJVytxTt+hrYgpvPJSfkiF
 tpl8=
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
 drivers/clk/mediatek/clk-mt8188.c | 1704 ++++++++++++++++++-------------------
 1 file changed, 852 insertions(+), 852 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 9d1da23d066..22764e744f6 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -190,375 +190,375 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_ULPOSC1_D16, CLK_TOP_ULPOSC1, 1, 16),
 };
 
-static const int axi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_ULPOSC1_D4
-};
-
-static const int spm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_MAINPLL_D7_D4,
-	CLK_TOP_CLK32K
-};
-
-static const int scp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_MAINPLL_D3
-};
-
-static const int bus_aximem_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D6
-};
-
-static const int vpp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MMPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_MMPLL_D5,
-	CLK_TOP_TVDPLL1,
-	CLK_TOP_TVDPLL2,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4
-};
-
-static const int ethdr_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MMPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_MMPLL_D5_D4,
-	CLK_TOP_TVDPLL1,
-	CLK_TOP_TVDPLL2,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4
-};
-
-static const int ipe_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_IMGPLL,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MMPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_MAINPLL_D7
-};
-
-static const int cam_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TVDPLL1,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_IMGPLL
-};
-
-static const int ccu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D7
-};
-
-static const int ccu_ahb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D7
-};
-
-static const int img_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_IMGPLL,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int camtm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D6_D4
-};
-
-static const int dsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D5,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D5,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp3_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D5,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp4_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp5_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp6_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dsp7_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int mfg_core_tmp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_UNIVPLL_D7
-};
-
-static const int camtg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_192M_D8,
-	CLK_TOP_UNIVPLL_D6_D8,
-	CLK_TOP_UNIVPLL_192M_D4,
-	CLK_TOP_UNIVPLL_192M_D10,
-	CLK_TOP_CLK13M,
-	CLK_TOP_UNIVPLL_192M_D16,
-	CLK_TOP_UNIVPLL_192M_D32
-};
-
-static const int camtg2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_192M_D8,
-	CLK_TOP_UNIVPLL_D6_D8,
-	CLK_TOP_UNIVPLL_192M_D4,
-	CLK_TOP_UNIVPLL_192M_D10,
-	CLK_TOP_CLK13M,
-	CLK_TOP_UNIVPLL_192M_D16,
-	CLK_TOP_UNIVPLL_192M_D32
-};
-
-static const int camtg3_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_192M_D8,
-	CLK_TOP_UNIVPLL_D6_D8,
-	CLK_TOP_UNIVPLL_192M_D4,
-	CLK_TOP_UNIVPLL_192M_D10,
-	CLK_TOP_CLK13M,
-	CLK_TOP_UNIVPLL_192M_D16,
-	CLK_TOP_UNIVPLL_192M_D32
-};
-
-static const int uart_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D8
-};
-
-static const int spi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D5_D4,
-	CLK_TOP_MAINPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D5_D4
-};
-
-static const int msdc5hclk_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6_D2
-};
-
-static const int msdc50_0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D2
-};
-
-static const int msdc30_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MSDCPLL_D2
-};
-
-static const int msdc30_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MSDCPLL_D2
-};
+static const struct mtk_parent axi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
+};
+
+static const struct mtk_parent spm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent scp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+};
+
+static const struct mtk_parent bus_aximem_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+};
+
+static const struct mtk_parent vpp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D5),
+	TOP_PARENT(CLK_TOP_TVDPLL1),
+	TOP_PARENT(CLK_TOP_TVDPLL2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+};
+
+static const struct mtk_parent ethdr_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL1),
+	TOP_PARENT(CLK_TOP_TVDPLL2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+};
+
+static const struct mtk_parent ipe_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_IMGPLL),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+};
+
+static const struct mtk_parent cam_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL1),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_IMGPLL),
+};
+
+static const struct mtk_parent ccu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+};
+
+static const struct mtk_parent ccu_ahb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+};
+
+static const struct mtk_parent img_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_IMGPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent camtm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent dsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp3_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp4_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp5_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp6_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dsp7_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent mfg_core_tmp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+};
+
+static const struct mtk_parent camtg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
+};
+
+static const struct mtk_parent camtg2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
+};
+
+static const struct mtk_parent camtg3_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+};
+
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+};
+
+static const struct mtk_parent msdc5hclk_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+};
+
+static const struct mtk_parent msdc50_0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent msdc30_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent msdc30_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
 
-static const int intdir_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D4
-};
-
-static const int aud_intbus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D7_D4
+static const struct mtk_parent intdir_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
 };
 
-static const int audio_h_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2
+static const struct mtk_parent audio_h_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
 };
 
-static const int pwrap_ulposc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_ULPOSC1_D7,
-	CLK_TOP_ULPOSC1_D8,
-	CLK_TOP_ULPOSC1_D16,
-	CLK_TOP_MAINPLL_D4_D8,
-	CLK_TOP_UNIVPLL_D5_D8,
-	CLK_TOP_TVDPLL1_D16
+static const struct mtk_parent pwrap_ulposc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D16),
 };
 
-static const int atb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D5_D2
+static const struct mtk_parent atb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
-static const int sspm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D9,
-	CLK_TOP_MAINPLL_D4_D2
+static const struct mtk_parent sspm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D9),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 };
 
 /*
@@ -566,580 +566,580 @@ static const int sspm_parents[] = {
  * TVDPLL1 on eDP and TVDPLL2 on DP to avoid changing the "other" PLL rate
  * in dual output case, which would lead to corruption of functionality loss.
  */
-static const int dp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TVDPLL2_D2,
-	CLK_TOP_TVDPLL2_D4,
-	CLK_TOP_TVDPLL2_D8,
-	CLK_TOP_TVDPLL2_D16
+static const struct mtk_parent dp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D16),
 };
-
-static const int edp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TVDPLL1_D2,
-	CLK_TOP_TVDPLL1_D4,
-	CLK_TOP_TVDPLL1_D8,
-	CLK_TOP_TVDPLL1_D16
+
+static const struct mtk_parent edp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D16),
 };
-
-static const int dpi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TVDPLL1_D2,
-	CLK_TOP_TVDPLL2_D2,
-	CLK_TOP_TVDPLL1_D4,
-	CLK_TOP_TVDPLL2_D4,
-	CLK_TOP_TVDPLL1_D8,
-	CLK_TOP_TVDPLL2_D8,
-	CLK_TOP_TVDPLL1_D16,
-	CLK_TOP_TVDPLL2_D16
-};
-
-static const int disp_pwm0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_ULPOSC1_D2,
-	CLK_TOP_ULPOSC1_D4,
-	CLK_TOP_ULPOSC1_D16,
-	CLK_TOP_ETHPLL_D4
-};
-
-static const int disp_pwm1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_ULPOSC1_D2,
-	CLK_TOP_ULPOSC1_D4,
-	CLK_TOP_ULPOSC1_D16
-};
-
-static const int usb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int ssusb_xhci_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int usb_2p_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int ssusb_xhci_2p_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int usb_3p_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int ssusb_xhci_3p_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int i2c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D8,
-	CLK_TOP_UNIVPLL_D5_D4
-};
-
-static const int seninf_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_UNIVPLL_D5
-};
-
-static const int seninf1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_UNIVPLL_D5
-};
-
-static const int gcpu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MMPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int venc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MMPLL_D9,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_MAINPLL_D5
-};
-
-static const int vdec_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MMPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D5,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_TVDPLL2,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_IMGPLL,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MMPLL_D9
-};
-
-static const int pwm_parents[] = {
-	CLK_TOP_CLK32K,
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D8,
-	CLK_TOP_UNIVPLL_D6_D4
-};
-
-static const int mcupm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D7_D4
-};
-
-static const int spmi_p_mst_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK13M,
-	CLK_TOP_ULPOSC1_D8,
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_ULPOSC1_D16,
-	CLK_TOP_ULPOSC1_D7,
-	CLK_TOP_CLK32K,
-	CLK_TOP_MAINPLL_D7_D8,
-	CLK_TOP_MAINPLL_D6_D8,
-	CLK_TOP_MAINPLL_D5_D8
-};
-
-static const int spmi_m_mst_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK13M,
-	CLK_TOP_ULPOSC1_D8,
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_ULPOSC1_D16,
-	CLK_TOP_ULPOSC1_D7,
-	CLK_TOP_CLK32K,
-	CLK_TOP_MAINPLL_D7_D8,
-	CLK_TOP_MAINPLL_D6_D8,
-	CLK_TOP_MAINPLL_D5_D8
-};
-
-static const int dvfsrc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_UNIVPLL_D6_D8,
-	CLK_TOP_MSDCPLL_D16
-};
-
-static const int tl_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_MAINPLL_D4_D4
-};
-
-static const int aes_msdcfde_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D6
-};
-
-static const int dsi_occ_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D4_D2
-};
-
-static const int wpe_vpp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MMPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D5,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_TVDPLL1,
-	CLK_TOP_UNIVPLL_D4
-};
-
-static const int hdcp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D8,
-	CLK_TOP_MAINPLL_D5_D8,
-	CLK_TOP_UNIVPLL_D6_D4
+
+static const struct mtk_parent dpi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D16),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D16),
+};
+
+static const struct mtk_parent disp_pwm0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
+	TOP_PARENT(CLK_TOP_ETHPLL_D4),
+};
+
+static const struct mtk_parent disp_pwm1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
+};
+
+static const struct mtk_parent usb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent ssusb_xhci_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent usb_2p_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent ssusb_xhci_2p_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent usb_3p_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent ssusb_xhci_3p_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+};
+
+static const struct mtk_parent seninf_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent seninf1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent gcpu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+};
+
+static const struct mtk_parent venc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D9),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+};
+
+static const struct mtk_parent vdec_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_IMGPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D9),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK32K),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent mcupm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+};
+
+static const struct mtk_parent spmi_p_mst_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
+	TOP_PARENT(CLK_TOP_CLK32K),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
+};
+
+static const struct mtk_parent spmi_m_mst_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
+	TOP_PARENT(CLK_TOP_CLK32K),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
+};
+
+static const struct mtk_parent dvfsrc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D16),
+};
+
+static const struct mtk_parent tl_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+};
+
+static const struct mtk_parent aes_msdcfde_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+};
+
+static const struct mtk_parent dsi_occ_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent wpe_vpp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL1),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+};
+
+static const struct mtk_parent hdcp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 };
 
-static const int hdcp_24m_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_192M_D4,
-	CLK_TOP_UNIVPLL_192M_D8,
-	CLK_TOP_UNIVPLL_D6_D8
+static const struct mtk_parent hdcp_24m_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
-static const int hdmi_apb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_MSDCPLL_D2
+static const struct mtk_parent hdmi_apb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 };
 
-static const int snps_eth_250m_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_ETHPLL_D2
+static const struct mtk_parent snps_eth_250m_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D2),
 };
 
-static const int snps_eth_62p4m_ptp_parents[] = {
-	CLK_TOP_APLL2_D3,
-	CLK_TOP_APLL1_D3,
-	CLK_TOP_CLK26M,
-	CLK_TOP_ETHPLL_D8
-};
-
-static const int snps_eth_50m_rmii_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_ETHPLL_D10
+static const struct mtk_parent snps_eth_62p4m_ptp_parents[] = {
+	TOP_PARENT(CLK_TOP_APLL2_D3),
+	TOP_PARENT(CLK_TOP_APLL1_D3),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D8),
+};
+
+static const struct mtk_parent snps_eth_50m_rmii_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D10),
 };
 
-static const int adsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK13M,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_ULPOSC1_D2,
-	CLK_TOP_ULPOSC1,
-	CLK_TOP_ADSPPLL,
-	CLK_TOP_ADSPPLL_D2,
-	CLK_TOP_ADSPPLL_D4,
-	CLK_TOP_ADSPPLL_D8
+static const struct mtk_parent adsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
+	TOP_PARENT(CLK_TOP_ULPOSC1),
+	TOP_PARENT(CLK_TOP_ADSPPLL),
+	TOP_PARENT(CLK_TOP_ADSPPLL_D2),
+	TOP_PARENT(CLK_TOP_ADSPPLL_D4),
+	TOP_PARENT(CLK_TOP_ADSPPLL_D8),
 };
 
-static const int audio_local_bus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK13M,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D7,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_ULPOSC1,
-	CLK_TOP_ULPOSC1_D4,
-	CLK_TOP_ULPOSC1_D2
+static const struct mtk_parent audio_local_bus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_ULPOSC1),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
 };
 
-static const int asm_h_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2
+static const struct mtk_parent asm_h_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
-static const int asm_l_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2
+static const struct mtk_parent asm_l_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
-static const int apll1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1_D4
+static const struct mtk_parent apll1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
 };
 
-static const int apll2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2_D4
+static const struct mtk_parent apll2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
-static const int apll3_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL3_D4
+static const struct mtk_parent apll3_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL3_D4),
 };
 
-static const int apll4_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL4_D4
+static const struct mtk_parent apll4_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL4_D4),
 };
 
-static const int apll5_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL5_D4
+static const struct mtk_parent apll5_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
-static const int i2so1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5
+static const struct mtk_parent i2so1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
 };
 
-static const int i2so2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5
+static const struct mtk_parent i2so2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
 };
 
-static const int i2si1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5
+static const struct mtk_parent i2si1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
 };
 
-static const int i2si2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5
+static const struct mtk_parent i2si2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
 };
 
-static const int dptx_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5
+static const struct mtk_parent dptx_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
 };
 
-static const int aud_iec_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5
+static const struct mtk_parent aud_iec_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
 };
 
-static const int a1sys_hp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1_D4
+static const struct mtk_parent a1sys_hp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
 };
 
-static const int a2sys_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2_D4
+static const struct mtk_parent a2sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
-static const int a3sys_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL3_D4,
-	CLK_TOP_APLL4_D4,
-	CLK_TOP_APLL5_D4
+static const struct mtk_parent a3sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL3_D4),
+	TOP_PARENT(CLK_TOP_APLL4_D4),
+	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
-static const int a4sys_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL3_D4,
-	CLK_TOP_APLL4_D4,
-	CLK_TOP_APLL5_D4
+static const struct mtk_parent a4sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL3_D4),
+	TOP_PARENT(CLK_TOP_APLL4_D4),
+	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
-static const int ecc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_UNIVPLL_D6
+static const struct mtk_parent ecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 };
 
-static const int spinor_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK13M,
-	CLK_TOP_MAINPLL_D7_D8,
-	CLK_TOP_UNIVPLL_D6_D8
+static const struct mtk_parent spinor_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK13M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
-static const int ulposc_parents[] = {
-	CLK_TOP_ULPOSC1,
-	CLK_TOP_ETHPLL_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_ETHPLL_D10
+static const struct mtk_parent ulposc_parents[] = {
+	TOP_PARENT(CLK_TOP_ULPOSC1),
+	TOP_PARENT(CLK_TOP_ETHPLL_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_ETHPLL_D10),
 };
 
-static const int srck_parents[] = {
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_CLK26M
+static const struct mtk_parent srck_parents[] = {
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_CLK26M),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI, axi_parents, 0x020, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SPM, spm_parents, 0x020, 8, 4, 15),
-	MUX_GATE(CLK_TOP_SCP, scp_parents, 0x020, 16, 4, 23),
-	MUX_GATE(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI, axi_parents, 0x020, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPM, spm_parents, 0x020, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_SCP, scp_parents, 0x020, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 4, 31),
 	/* CLK_CFG_1 */
-	MUX_GATE(CLK_TOP_VPP, vpp_parents, 0x02C, 0, 4, 7),
-	MUX_GATE(CLK_TOP_ETHDR, ethdr_parents, 0x02C, 8, 4, 15),
-	MUX_GATE(CLK_TOP_IPE, ipe_parents, 0x02C, 16, 4, 23),
-	MUX_GATE(CLK_TOP_CAM, cam_parents, 0x02C, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_VPP, vpp_parents, 0x02C, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_ETHDR, ethdr_parents, 0x02C, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_IPE, ipe_parents, 0x02C, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_CAM, cam_parents, 0x02C, 24, 4, 31),
 	/* CLK_CFG_2 */
-	MUX_GATE(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
-	MUX_GATE(CLK_TOP_CCU_AHB, ccu_ahb_parents, 0x038, 8, 4, 15),
-	MUX_GATE(CLK_TOP_IMG, img_parents, 0x038, 16, 4, 23),
-	MUX_GATE(CLK_TOP_CAMTM, camtm_parents, 0x038, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_CCU_AHB, ccu_ahb_parents, 0x038, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_IMG, img_parents, 0x038, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_CAMTM, camtm_parents, 0x038, 24, 4, 31),
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_DSP, dsp_parents, 0x044, 0, 4, 7),
-	MUX_GATE(CLK_TOP_DSP1, dsp1_parents, 0x044, 8, 4, 15),
-	MUX_GATE(CLK_TOP_DSP2, dsp2_parents, 0x044, 16, 4, 23),
-	MUX_GATE(CLK_TOP_DSP3, dsp3_parents, 0x044, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_DSP, dsp_parents, 0x044, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_DSP1, dsp1_parents, 0x044, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_DSP2, dsp2_parents, 0x044, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_DSP3, dsp3_parents, 0x044, 24, 4, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_DSP4, dsp4_parents, 0x050, 0, 4, 7),
-	MUX_GATE(CLK_TOP_DSP5, dsp5_parents, 0x050, 8, 4, 15),
-	MUX_GATE(CLK_TOP_DSP6, dsp6_parents, 0x050, 16, 4, 23),
-	MUX_GATE(CLK_TOP_DSP7, dsp7_parents, 0x050, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_DSP4, dsp4_parents, 0x050, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_DSP5, dsp5_parents, 0x050, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_DSP6, dsp6_parents, 0x050, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_DSP7, dsp7_parents, 0x050, 24, 4, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_MFG_CORE_TMP, mfg_core_tmp_parents, 0x05C, 0, 4, 7),
-	MUX_GATE(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 4, 15),
-	MUX_GATE(CLK_TOP_CAMTG2, camtg2_parents, 0x05C, 16, 4, 23),
-	MUX_GATE(CLK_TOP_CAMTG3, camtg3_parents, 0x05C, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_MFG_CORE_TMP, mfg_core_tmp_parents, 0x05C, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG2, camtg2_parents, 0x05C, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG3, camtg3_parents, 0x05C, 24, 4, 31),
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_UART, uart_parents, 0x068, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SPI, spi_parents, 0x068, 8, 4, 15),
-	MUX_GATE(CLK_TOP_MSDC50_0_HCLK, msdc5hclk_parents, 0x068, 16, 4, 23),
-	MUX_GATE(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x068, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_UART, uart_parents, 0x068, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI, spi_parents, 0x068, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_HCLK, msdc5hclk_parents, 0x068, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x068, 24, 4, 31),
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_MSDC30_1, msdc30_1_parents, 0x074, 0, 4, 7),
-	MUX_GATE(CLK_TOP_MSDC30_2, msdc30_2_parents, 0x074, 8, 4, 15),
-	MUX_GATE(CLK_TOP_INTDIR, intdir_parents, 0x074, 16, 4, 23),
-	MUX_GATE(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x074, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1, msdc30_1_parents, 0x074, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_2, msdc30_2_parents, 0x074, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR, intdir_parents, 0x074, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x074, 24, 4, 31),
 	/* CLK_CFG_8 */
-	MUX_GATE(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 0, 4, 7),
-	MUX_GATE(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x080, 8, 4, 15),
-	MUX_GATE(CLK_TOP_ATB, atb_parents, 0x080, 16, 4, 23),
-	MUX_GATE(CLK_TOP_SSPM, sspm_parents, 0x080, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x080, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_ATB, atb_parents, 0x080, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_SSPM, sspm_parents, 0x080, 24, 4, 31),
 	/* CLK_CFG_9 */
-	MUX_GATE(CLK_TOP_DP, dp_parents, 0x08C, 0, 4, 7),
-	MUX_GATE(CLK_TOP_EDP, edp_parents, 0x08C, 8, 4, 15),
-	MUX_GATE(CLK_TOP_DPI, dpi_parents, 0x08C, 16, 4, 23),
-	MUX_GATE(CLK_TOP_DISP_PWM0, disp_pwm0_parents, 0x08C, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_DP, dp_parents, 0x08C, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_EDP, edp_parents, 0x08C, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_DPI, dpi_parents, 0x08C, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_DISP_PWM0, disp_pwm0_parents, 0x08C, 24, 4, 31),
 	/* CLK_CFG_10 */
-	MUX_GATE(CLK_TOP_DISP_PWM1, disp_pwm1_parents, 0x098, 0, 4, 7),
-	MUX_GATE(CLK_TOP_USB_TOP, usb_parents, 0x098, 8, 4, 15),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI, ssusb_xhci_parents, 0x098, 16, 4, 23),
-	MUX_GATE(CLK_TOP_USB_TOP_2P, usb_2p_parents, 0x098, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_DISP_PWM1, disp_pwm1_parents, 0x098, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP, usb_parents, 0x098, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI, ssusb_xhci_parents, 0x098, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP_2P, usb_2p_parents, 0x098, 24, 4, 31),
 	/* CLK_CFG_11 */
-	MUX_GATE(CLK_TOP_SSUSB_XHCI_2P, ssusb_xhci_2p_parents, 0x0A4, 0, 4, 7),
-	MUX_GATE(CLK_TOP_USB_TOP_3P, usb_3p_parents, 0x0A4, 8, 4, 15),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI_3P, ssusb_xhci_3p_parents, 0x0A4, 16, 4, 23),
-	MUX_GATE(CLK_TOP_I2C, i2c_parents, 0x0A4, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_2P, ssusb_xhci_2p_parents, 0x0A4, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP_3P, usb_3p_parents, 0x0A4, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_3P, ssusb_xhci_3p_parents, 0x0A4, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_I2C, i2c_parents, 0x0A4, 24, 4, 31),
 	/* CLK_CFG_12 */
-	MUX_GATE(CLK_TOP_SENINF, seninf_parents, 0x0B0, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SENINF1, seninf1_parents, 0x0B0, 8, 4, 15),
-	MUX_GATE(CLK_TOP_GCPU, gcpu_parents, 0x0B0, 16, 4, 23),
-	MUX_GATE(CLK_TOP_VENC, venc_parents, 0x0B0, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_SENINF, seninf_parents, 0x0B0, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SENINF1, seninf1_parents, 0x0B0, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_GCPU, gcpu_parents, 0x0B0, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_VENC, venc_parents, 0x0B0, 24, 4, 31),
 	/* CLK_CFG_13 */
-	MUX_GATE(CLK_TOP_VDEC, vdec_parents, 0x0BC, 0, 4, 7),
-	MUX_GATE(CLK_TOP_PWM, pwm_parents, 0x0BC, 8, 4, 15),
-	MUX_GATE(CLK_TOP_MCUPM, mcupm_parents, 0x0BC, 16, 4, 23),
-	MUX_GATE(CLK_TOP_SPMI_P_MST, spmi_p_mst_parents, 0x0BC, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_VDEC, vdec_parents, 0x0BC, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_PWM, pwm_parents, 0x0BC, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_MCUPM, mcupm_parents, 0x0BC, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_SPMI_P_MST, spmi_p_mst_parents, 0x0BC, 24, 4, 31),
 	/* CLK_CFG_14 */
-	MUX_GATE(CLK_TOP_SPMI_M_MST, spmi_m_mst_parents, 0x0C8, 0, 4, 7),
-	MUX_GATE(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0C8, 8, 4, 15),
-	MUX_GATE(CLK_TOP_TL, tl_parents, 0x0C8, 16, 4, 23),
-	MUX_GATE(CLK_TOP_AES_MSDCFDE, aes_msdcfde_parents, 0x0C8, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_SPMI_M_MST, spmi_m_mst_parents, 0x0C8, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0C8, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_TL, tl_parents, 0x0C8, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_AES_MSDCFDE, aes_msdcfde_parents, 0x0C8, 24, 4, 31),
 	/* CLK_CFG_15 */
-	MUX_GATE(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0D4, 0, 4, 7),
-	MUX_GATE(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0D4, 8, 4, 15),
-	MUX_GATE(CLK_TOP_HDCP, hdcp_parents, 0x0D4, 16, 4, 23),
-	MUX_GATE(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0D4, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0D4, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0D4, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_HDCP, hdcp_parents, 0x0D4, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0D4, 24, 4, 31),
 	/* CLK_CFG_16 */
-	MUX_GATE(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0E0, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0E0, 8, 4, 15),
-	MUX_GATE(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0E0, 16, 4, 23),
-	MUX_GATE(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x0E0, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0E0, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0E0, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0E0, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x0E0, 24, 4, 31),
 	/* CLK_CFG_17 */
-	MUX_GATE(CLK_TOP_ADSP, adsp_parents, 0x0EC, 0, 4, 7),
-	MUX_GATE(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0EC, 8, 4, 15),
-	MUX_GATE(CLK_TOP_ASM_H, asm_h_parents, 0x0EC, 16, 4, 23),
-	MUX_GATE(CLK_TOP_ASM_L, asm_l_parents, 0x0EC, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_ADSP, adsp_parents, 0x0EC, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0EC, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_H, asm_h_parents, 0x0EC, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_L, asm_l_parents, 0x0EC, 24, 4, 31),
 	/* CLK_CFG_18 */
-	MUX_GATE(CLK_TOP_APLL1, apll1_parents, 0x0F8, 0, 4, 7),
-	MUX_GATE(CLK_TOP_APLL2, apll2_parents, 0x0F8, 8, 4, 15),
-	MUX_GATE(CLK_TOP_APLL3, apll3_parents, 0x0F8, 16, 4, 23),
-	MUX_GATE(CLK_TOP_APLL4, apll4_parents, 0x0F8, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_APLL1, apll1_parents, 0x0F8, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_APLL2, apll2_parents, 0x0F8, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_APLL3, apll3_parents, 0x0F8, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_APLL4, apll4_parents, 0x0F8, 24, 4, 31),
 	/* CLK_CFG_19 */
-	MUX_GATE(CLK_TOP_APLL5, apll5_parents, 0x0104, 0, 4, 7),
-	MUX_GATE(CLK_TOP_I2SO1, i2so1_parents, 0x0104, 8, 4, 15),
-	MUX_GATE(CLK_TOP_I2SO2, i2so2_parents, 0x0104, 16, 4, 23),
-	MUX_GATE(CLK_TOP_I2SI1, i2si1_parents, 0x0104, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_APLL5, apll5_parents, 0x0104, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_I2SO1, i2so1_parents, 0x0104, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_I2SO2, i2so2_parents, 0x0104, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_I2SI1, i2si1_parents, 0x0104, 24, 4, 31),
 	/* CLK_CFG_20 */
-	MUX_GATE(CLK_TOP_I2SI2, i2si2_parents, 0x0110, 0, 4, 7),
-	MUX_GATE(CLK_TOP_DPTX, dptx_parents, 0x0110, 8, 4, 15),
-	MUX_GATE(CLK_TOP_AUD_IEC, aud_iec_parents, 0x0110, 16, 4, 23),
-	MUX_GATE(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0110, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_I2SI2, i2si2_parents, 0x0110, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_DPTX, dptx_parents, 0x0110, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUD_IEC, aud_iec_parents, 0x0110, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0110, 24, 4, 31),
 	/* CLK_CFG_21 */
-	MUX_GATE(CLK_TOP_A2SYS, a2sys_parents, 0x011C, 0, 4, 7),
-	MUX_GATE(CLK_TOP_A3SYS, a3sys_parents, 0x011C, 8, 4, 15),
-	MUX_GATE(CLK_TOP_A4SYS, a4sys_parents, 0x011C, 16, 4, 23),
-	MUX_GATE(CLK_TOP_ECC, ecc_parents, 0x011C, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_A2SYS, a2sys_parents, 0x011C, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_A3SYS, a3sys_parents, 0x011C, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_A4SYS, a4sys_parents, 0x011C, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_ECC, ecc_parents, 0x011C, 24, 4, 31),
 	/* CLK_CFG_22 */
-	MUX_GATE(CLK_TOP_SPINOR, spinor_parents, 0x0128, 0, 4, 7),
-	MUX_GATE(CLK_TOP_ULPOSC, ulposc_parents, 0x0128, 8, 4, 15),
-	MUX_GATE(CLK_TOP_SRCK, srck_parents, 0x0128, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_SPINOR, spinor_parents, 0x0128, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_ULPOSC, ulposc_parents, 0x0128, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_SRCK, srck_parents, 0x0128, 16, 4, 23),
 };
 
 static const int mt8188_id_top_offs_map[] = {

-- 
2.43.0

