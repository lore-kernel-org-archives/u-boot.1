Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3DCFF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C908432F;
	Wed, 18 Mar 2026 00:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O4fEdfCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A2B842DF; Wed, 18 Mar 2026 00:26:39 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955A68429E
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso4446997fac.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789994; x=1774394794;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AoMFsYuogtt/798honM+yn/mP46yuHZOb4pViXI9/vg=;
 b=O4fEdfCn/1EltIdo3NRrKsxrH3HOfQ1kAHl6lKuv/eNT8NpKrDEY4D8JhTmk1oKXcL
 IoguAR99o9r+jXaSyGtij+Y69T/qQG8uAXj6yXJueBGMYTVScm5dLoeK3hEUTWy/zPky
 9c07uB3Uns90tV/q89K7w5Ic9mbf63M5ZDVjOeNCRRcTUen+XYcwXYR2oiR9b8uAFVtp
 Onz0CrxQpG5US4ZE4SHPZq113lUbfEo1gf26hEDe194F91pDGwIwLgnvbwCVBqkXOQU2
 vzkvVllYGYasW6H+j1LMm/SUcyndeSAyPXWBtjsOKCkW/iuxCl7U5o36hOzifUBp7OTt
 4fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789994; x=1774394794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AoMFsYuogtt/798honM+yn/mP46yuHZOb4pViXI9/vg=;
 b=CjXy8IZU0x1XTB0mwW7l16vAJ2jWZ8pP9a7ZRGyit0gFBhWs7cEYu3ujbubf+jPQyK
 w0i1CwGSYrTpGxpTHpoKwQ1B16N/c5UDScoE2KWuA3vMOTC95EPazAgHlhtnwy+4z591
 VVg/s50X8oafenyabe283hwVgqRVx1/pgsYPGcCI6qMnanGFgfU17qSgwPFWgTQSNoVw
 shg5eJaWmeKpEiTgJuuhqt/AcRqLrkAvRvV54PsyCSw5IMw+GbXPYYNWdQ4/bNWgkYT8
 i2BwdlVahTOtG57ZFljd/dnZJ1q+NyWrl1Q6xj1sPy2Zv6/yQ+Sh0qkRODMJLK65Ry5F
 oeOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlrA5WoXoOms4DoIf5kCC0XbvbPl1dtalGD8mHkfC8Ten37C8+HcxV5Uudsbd8ohaYfL/jxh4=@lists.denx.de
X-Gm-Message-State: AOJu0YyYKKmpmz4HYF/xP/ClXJIlrbjEAqRmNb2VAvvZd1iE47SPzqpE
 JZ+At+jf81FKGjEuW7cac6ryBZbHAEzPpiTu9R1uabWamvK2sCtHvYbbYynxxfDPtWY=
X-Gm-Gg: ATEYQzwkWvmc522NysvfRqLAr8KOsczG8jcZ6IRGBD5byeXW0Tmt4WkEjfZ73ujoFgF
 rNP/eiCF7nXf7Tfm1CGtt3U6LdPgnmKlXoQ3cnS4y1MXyWLybGCp29LezujwVon5C0/0kcSs8RX
 yhZnYNR9Azw+KfEwU613va981j+6Pf0Rqqb4zeAPrclf6U2M2ZwfUUZCSOgJNIMregSEw2wZg4k
 bUMxulVcocNOOz3NBzaE8PL5HeAsVtackWobZTnKLV2x5FfDXHf4aVopOGWze5rsIUgg+PxAG+z
 ZpgW5O78GE+WvW1P0k7mir023jGysatoosL65+7+UD8ezie7pB0D5pO6FxrTfk0QMqdDbyt5SUI
 QuFqP1c8P4NII6/6P/CMJBJODVK4ONzsu164mwx7JWa2PODTNBYdcC0/CHpCyZVhvznACmtM2DU
 F3FQF8poFJ82nvZLShQ7tlnV/Rt54jRIMj4HMW
X-Received: by 2002:a05:6871:5d0f:b0:3d4:6fba:31ff with SMTP id
 586e51a60fabf-41bd3e99d7cmr959952fac.1.1773789994052; 
 Tue, 17 Mar 2026 16:26:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:21 -0500
Subject: [PATCH v3 08/16] clk: mediatek: mt8188: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-8-a4760f5b0a80@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=55347;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=jXPw7a6i8CnKOI8q7LH/m8owW/ZBlSNOJOoeFaTtLn8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueLkZ92Y+PKj1wyupHURmKUWwux6UXp7ydl+4
 YkmfMZS5pyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabni5BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArqQH/RjmY3H3QA1tgZR7b/STjbLMMbYHTy+lhxNcQfw
 QB3cvIawETQs4xipG8fv6U/sSpT3jGwpfcRI5J895LohIqglKRt9w7Lec5aAZmf3AE+fbh+XWC6
 l9yUvXoQE1CcfhxWttenAJL41vZR5MonTnmk85WYzUgwj9y7ykyqwrNoTVtVfb6C3cl38QfJEJj
 V23Zg5iToSaHxF+Bv8LH1ONs6VPbzhXBB9ANo4R7zGRwmIGjs/nFSZ19ieRGTYwFF1LQbJRPSAk
 lep4ltAU30lIgONHtVYmEuVCX3spiHD3JftI2G5/3JWxWMwaWGM1P/3KfMi2NgkkoqMrr+iAcIp
 NU9U=
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

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 1704 ++++++++++++++++++-------------------
 1 file changed, 852 insertions(+), 852 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 3d20d2d93fc..1db5350763e 100644
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

