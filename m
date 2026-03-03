Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1EBEB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4324983FA5;
	Tue,  3 Mar 2026 01:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SwqEuptX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D71983F4C; Tue,  3 Mar 2026 01:05:15 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E42C83F70
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-404254ffe8aso161814fac.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496310; x=1773101110;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l5hnfCDwYnOf8EyDzeHXqDBGFwtVQqW5gAWU2DxdEhI=;
 b=SwqEuptXEowAYS5abftniqdWL0npoNM+/7ZwjLYow0MbsG84EavdGq/ecLXyIKbC4z
 ze6mPvDHb5Ml49T07r82PStadI8Opp1Y5rKBza8l7544hoMQuK8czxvwXWHIGh7o7kxI
 rtBrrEjTRVX0P46js7tvHW70NmN7zT+3VoftGY7dqc71GTfqFTdG7UbvjWBwc0y0JVFN
 XXKREH7EsD+XcW9vrDIDKFh9H8g7V5IRGuRtK+6b8b6byCMoNqrQ500igGHrnQjRXAkH
 jLM6zceNBz2zst6odxU4W9m8YUZ/zm2CcLkHqv+cSxswpQLVgHqea57jPGvDfa9Cp9hW
 R/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496310; x=1773101110;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l5hnfCDwYnOf8EyDzeHXqDBGFwtVQqW5gAWU2DxdEhI=;
 b=fXAU8ILveEyyZASzIQ0+ittVUEREalbD/uzHaX8cxWOksY9gA5Uttqm+myhwSa/JSk
 K5JNvGtm21M2R18/VB12u6tKgu4RzDYegdkcK1Hc7V8EuRiyUSopCjCUuYIr1m5FXBqu
 qgRVdvRXXcHsnppBsklNHkd9DDDrOSVwp8HBiJYJPivrhZBSda1tjkPaNCgWqkK7rLSO
 W042jqesTJFFeJUK+ESEIrkX+ZK211JCIDrlGV6BYFr2cn3FlVTWAeSjQZ4qG1TDU2LB
 9ukBektZ2E6ZsJJjIUCeC//+gcvhtb0uQIyQbfsO7xR/7lo1Vy5JOpPvEz0DWhzlIi/3
 gzvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRd58V1gpjZ1YIbfPoxEVwDKoQox9KQ8V1s77TM1kZ2QNacYACOJUz9+dfhVgQY60663R3eA=@lists.denx.de
X-Gm-Message-State: AOJu0YyCpkA4JYslGC/DSy2O3hhVtKxAo05RR77deKFMba1kBaS1nAAu
 jJqbdaf4Z8L0GlSyQYeBtJy14GYt0SS93a5qyssl+XaRYFrgf5WqX81e5pg6nKuFyFA=
X-Gm-Gg: ATEYQzzSAfo6JqGWv6jj5g8w21RKdIn5Uo12CNBR6ZOv3MZEOC6ntxIbBP8KXIqKCFN
 XvImMuJxfakAkY/s0c64XOGXZqcj7s2qV/2eD6wPqVJLieqIS9OWBNb8BeP2VzDwmUv87jC8lCh
 PKESOdCEpmQeZ8noyrTD55OdQJTvg34tLtEnAqBhoM0pCAmMEDOvd6+UMlUHtb4KF7NKIN/NKC8
 luP44POhBosFxd39bo0LVtVZwjqgQ3z/mDxeQBwy/aIjELJDIyR35ogN/fqzHdYVMuDrdGExPFg
 kLA4sSEBvsPI/h8HfGMGbGDct34k5nn9BK3+Fa6ECxTgshVy5QC4tTek0WZvFbHd/S29gGaochi
 DGsL+c6MXsAW1gSqstG5nQBG769b9UvSEVjq4N5JCeS7idqrQRGifpulNj93Pt9nfDbrEBLZcue
 SqSDy3bZ84e8MX15/+IwGUSORtyN0Y
X-Received: by 2002:a05:6870:240b:b0:3ff:c029:d24c with SMTP id
 586e51a60fabf-41691ef5909mr147122fac.17.1772496309782; 
 Mon, 02 Mar 2026 16:05:09 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:19 -0600
Subject: [PATCH 10/14] clk: mediatek: mt8512: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-10-32f45085f4d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25777;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=bTzFdK93WSOD2b/qgvQ2XiZi+rvECuzrDOoftbL1xIU=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiWMZjv3U8CmJyd06cNd6K1Nt+IjNRxs2u3XH
 NbhOdu6LpCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYljBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AX4IH/1Wg7m2jm3vNZemoc5UuVpn00fRl+psP3UhhIyq
 ODi+9gEuQIr72krXBPT12If+5utdenxhi0zGWCEpG332i+ucFFO+F/SPFbKTBzHV9/mQc5cZby3
 uvWDwWm7VnkSSwKpgPw1xyjpX3vyLmP6eRujTj3PJ2HCcOKkfvQWLQL5t/SyCahksGLtRTzbWk0
 jXezCttqJeTDwODIjCQngQxEBTt6Pu78Z0IN4bYugMH79mtTaEgOCqi4fUaoydvp6sFs8usLIlO
 AFUmy5klZR25j8U+BjuLsoeJKAneu5DXC9zgHtQgZVucHH/pKNhCG7TQaoN958z791X1/up4DST
 3Udo=
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
 drivers/clk/mediatek/clk-mt8512.c | 692 +++++++++++++++++++-------------------
 1 file changed, 346 insertions(+), 346 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 69576304f2f..31907fa49d0 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -135,465 +135,465 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_NFI2X_CK_D2, CLK_TOP_NFI2X_SEL, 1, 2),
 };
 
-static const int axi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_CLK32K
-};
-
-static const int mem_parents[] = {
-	CLK_TOP_DSPPLL,
-	CLK_TOP_IPPLL,
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int uart_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int spi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL4_D2
-};
-
-static const int spis_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL4_D2
-};
-
-static const int msdc50_0_hc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL2_D2
-};
-
-static const int msdc50_0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int msdc50_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4
-};
-
-static const int audio_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_APLL1_D4,
-	CLK_TOP_APLL2_D4
-};
-
-static const int aud_intbus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_APLL2_D8,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_APLL1_D8,
-	CLK_TOP_UNIVPLL3_D4
-};
-
-static const int hapll1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL1_D2,
-	CLK_TOP_APLL1_D3,
-	CLK_TOP_APLL1_D4,
-	CLK_TOP_APLL1_D8,
-	CLK_TOP_APLL1_D16,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int hapll2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL2_D2,
-	CLK_TOP_APLL2_D3,
-	CLK_TOP_APLL2_D4,
-	CLK_TOP_APLL2_D8,
-	CLK_TOP_APLL2_D16,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int asm_l_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D5
-};
-
-static const int aud_spdif_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_DSPPLL
-};
-
-static const int aud_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1
-};
-
-static const int aud_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2
-};
-
-static const int ssusb_sys_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2
-};
-
-static const int spm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D8
-};
-
-static const int i2c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_CLK32K
-};
-
-static const int pwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_CLK32K
-};
-
-static const int dsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_DSPPLL_D2,
-	CLK_TOP_DSPPLL_D4,
-	CLK_TOP_DSPPLL_D8,
-	CLK_TOP_APLL2_D4,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_CLK32K
-};
-
-static const int nfi2x_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5
-};
-
-static const int spinfi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2
-};
-
-static const int ecc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int gcpu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2
+static const struct mtk_parent axi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_IPPLL),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+};
+
+static const struct mtk_parent spis_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+};
+
+static const struct mtk_parent msdc50_0_hc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+};
+
+static const struct mtk_parent msdc50_0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent msdc50_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+};
+
+static const struct mtk_parent audio_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+};
+
+static const struct mtk_parent hapll1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D3),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
+	TOP_PARENT(CLK_TOP_APLL1_D16),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent hapll2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D3),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
+	TOP_PARENT(CLK_TOP_APLL2_D16),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent asm_l_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+};
+
+static const struct mtk_parent aud_spdif_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+};
+
+static const struct mtk_parent aud_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+};
+
+static const struct mtk_parent aud_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2),
+};
+
+static const struct mtk_parent ssusb_sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+};
+
+static const struct mtk_parent spm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+};
+
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent dsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_DSPPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL_D4),
+	TOP_PARENT(CLK_TOP_DSPPLL_D8),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_CLK32K),
+};
+
+static const struct mtk_parent nfi2x_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent spinfi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+};
+
+static const struct mtk_parent ecc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent gcpu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int gcpu_cpm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4
+static const struct mtk_parent gcpu_cpm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
 };
 
-static const int mbist_diag_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int ip0_nna_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_DSPPLL_D2,
-	CLK_TOP_DSPPLL_D4,
-	CLK_TOP_IPPLL,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_IPPLL_D2,
-	CLK_TOP_MSDCPLL_D2
-};
-
-static const int ip2_wfst_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_IPPLL,
-	CLK_TOP_IPPLL_D2,
-	CLK_TOP_SYS_26M_D2,
-	CLK_TOP_MSDCPLL
-};
-
-static const int sflash_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_USB20_192M_D2,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int sram_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DSPPLL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYS_26M_D2
-};
-
-static const int mm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int dpi0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TCONPLL_D2,
-	CLK_TOP_TCONPLL_D4,
-	CLK_TOP_TCONPLL_D8,
-	CLK_TOP_TCONPLL_D16,
-	CLK_TOP_TCONPLL_D32,
-	CLK_TOP_TCONPLL_D64
-};
+static const struct mtk_parent mbist_diag_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent ip0_nna_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_DSPPLL_D2),
+	TOP_PARENT(CLK_TOP_DSPPLL_D4),
+	TOP_PARENT(CLK_TOP_IPPLL),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_IPPLL_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent ip2_wfst_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_IPPLL),
+	TOP_PARENT(CLK_TOP_IPPLL_D2),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+};
+
+static const struct mtk_parent sflash_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_USB20_192M_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent sram_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DSPPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYS_26M_D2),
+};
+
+static const struct mtk_parent mm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent dpi0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TCONPLL_D2),
+	TOP_PARENT(CLK_TOP_TCONPLL_D4),
+	TOP_PARENT(CLK_TOP_TCONPLL_D8),
+	TOP_PARENT(CLK_TOP_TCONPLL_D16),
+	TOP_PARENT(CLK_TOP_TCONPLL_D32),
+	TOP_PARENT(CLK_TOP_TCONPLL_D64),
+};
 
-static const int dbg_atclk_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5
+static const struct mtk_parent dbg_atclk_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
 };
 
-static const int occ_104m_parents[] = {
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent occ_104m_parents[] = {
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int occ_68m_parents[] = {
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D8
-};
+static const struct mtk_parent occ_68m_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
 
-static const int occ_182m_parents[] = {
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent occ_182m_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, axi_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, axi_parents,
 			      0x040, 0x044, 0x048, 0, 3, 7,
 			      0x4, 0, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, mem_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, mem_parents,
 			      0x040, 0x044, 0x048, 8, 2, 15,
 			      0x4, 1, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_UART_SEL, uart_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_UART_SEL, uart_parents,
 			      0x040, 0x044, 0x048, 16, 1, 23,
 			      0x4, 2, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPI_SEL, spi_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPI_SEL, spi_parents,
 			      0x040, 0x044, 0x048, 24, 3, 31,
 			      0x4, 3, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_1 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPIS_SEL, spis_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPIS_SEL, spis_parents,
 			      0x050, 0x054, 0x058, 0, 3, 7,
 			      0x4, 4, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents,
 			      0x050, 0x054, 0x058, 8, 2, 15,
 			      0x4, 5, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents,
 			      0x050, 0x054, 0x058, 16, 2, 23,
 			      0x4, 6, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
 			      0x050, 0x054, 0x058, 24, 3, 31,
 			      0x4, 7, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_2 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents,
 			      0x060, 0x064, 0x068, 0, 3, 7,
 			      0x4, 8, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, msdc50_0_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, msdc50_0_parents,
 			      0x060, 0x064, 0x068, 8, 3, 15,
 			      0x4, 9, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUDIO_SEL, audio_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUDIO_SEL, audio_parents,
 			      0x060, 0x064, 0x068, 16, 2, 23,
 			      0x4, 10, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
 			      0x060, 0x064, 0x068, 24, 3, 31,
 			      0x4, 11, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_3 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL1_SEL, hapll1_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL1_SEL, hapll1_parents,
 			      0x070, 0x074, 0x078, 0, 3, 7,
 			      0x4, 12, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL2_SEL, hapll2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL2_SEL, hapll2_parents,
 			      0x070, 0x074, 0x078, 8, 3, 15,
 			      0x4, 13, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_A2SYS_SEL, hapll1_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_A2SYS_SEL, hapll1_parents,
 			      0x070, 0x074, 0x078, 16, 3, 23,
 			      0x4, 14, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_A1SYS_SEL, hapll2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_A1SYS_SEL, hapll2_parents,
 			      0x070, 0x074, 0x078, 24, 3, 31,
 			      0x4, 15, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_4 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_L_SEL, asm_l_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_L_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 0, 2, 7,
 			      0x4, 16, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_M_SEL, asm_l_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_M_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 8, 2, 15,
 			      0x4, 17, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_H_SEL, asm_l_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_H_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 16, 2, 23,
 			      0x4, 18, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents,
 			      0x080, 0x084, 0x088, 24, 2, 31,
 			      0x4, 19, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_5 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_1_SEL, aud_1_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_1_SEL, aud_1_parents,
 			      0x090, 0x094, 0x098, 0, 1, 7,
 			      0x4, 20, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_2_SEL, aud_2_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_2_SEL, aud_2_parents,
 			      0x090, 0x094, 0x098, 8, 1, 15,
 			      0x4, 21, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents,
 			      0x090, 0x094, 0x098, 16, 2, 23,
 			      0x4, 22, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents,
 			      0x090, 0x094, 0x098, 24, 2, 31,
 			      0x4, 23, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_6 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, spm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, spm_parents,
 			      0x0a0, 0x0a4, 0x0a8, 0, 1, 7,
 			      0x4, 24, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_I2C_SEL, i2c_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_I2C_SEL, i2c_parents,
 			      0x0a0, 0x0a4, 0x0a8, 8, 3, 15,
 			      0x4, 25, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_PWM_SEL, pwm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_PWM_SEL, pwm_parents,
 			      0x0a0, 0x0a4, 0x0a8, 16, 3, 23,
 			      0x4, 26, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DSP_SEL, dsp_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DSP_SEL, dsp_parents,
 			      0x0a0, 0x0a4, 0x0a8, 24, 3, 31,
 			      0x4, 27, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_7 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_NFI2X_SEL, nfi2x_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_NFI2X_SEL, nfi2x_parents,
 			      0x0b0, 0x0b4, 0x0b8, 0, 3, 7,
 			      0x4, 28, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPINFI_SEL, spinfi_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPINFI_SEL, spinfi_parents,
 			      0x0b0, 0x0b4, 0x0b8, 8, 3, 15,
 			      0x4, 29, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ECC_SEL, ecc_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ECC_SEL, ecc_parents,
 			      0x0b0, 0x0b4, 0x0b8, 16, 2, 23,
 			      0x4, 30, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_SEL, gcpu_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_SEL, gcpu_parents,
 			      0x0b0, 0x0b4, 0x0b8, 24, 3, 31,
 			      0x4, 31, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_8 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents,
 			      0x0c0, 0x0c4, 0x0c8, 0, 2, 7,
 			      0x8, 0, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MBIST_DIAG_SEL, mbist_diag_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MBIST_DIAG_SEL, mbist_diag_parents,
 			      0x0c0, 0x0c4, 0x0c8, 8, 1, 15,
 			      0x8, 1, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP0_NNA_SEL, ip0_nna_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP0_NNA_SEL, ip0_nna_parents,
 			      0x0c0, 0x0c4, 0x0c8, 16, 3, 23,
 			      0x8, 2, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP1_NNA_SEL, ip0_nna_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP1_NNA_SEL, ip0_nna_parents,
 			      0x0c0, 0x0c4, 0x0c8, 24, 3, 31,
 			      0x8, 3, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_9 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP2_WFST_SEL, ip2_wfst_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP2_WFST_SEL, ip2_wfst_parents,
 			      0x0d0, 0x0d4, 0x0d8, 0, 3, 7,
 			      0x8, 4, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SFLASH_SEL, sflash_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SFLASH_SEL, sflash_parents,
 			      0x0d0, 0x0d4, 0x0d8, 8, 3, 15,
 			      0x8, 5, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SRAM_SEL, sram_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SRAM_SEL, sram_parents,
 			      0x0d0, 0x0d4, 0x0d8, 16, 3, 23,
 			      0x8, 6, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MM_SEL, mm_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MM_SEL, mm_parents,
 			      0x0d0, 0x0d4, 0x0d8, 24, 3, 31,
 			      0x8, 7, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_10 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DPI0_SEL, dpi0_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DPI0_SEL, dpi0_parents,
 			      0x0e0, 0x0e4, 0x0e8, 0, 3, 7,
 			      0x8, 8, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents,
 			      0x0e0, 0x0e4, 0x0e8, 8, 2, 15,
 			      0x8, 9, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_104M_SEL, occ_104m_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_104M_SEL, occ_104m_parents,
 			      0x0e0, 0x0e4, 0x0e8, 16, 1, 23,
 			      0x8, 10, CLK_MUX_SETCLR_UPD),
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_68M_SEL, occ_68m_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_68M_SEL, occ_68m_parents,
 			      0x0e0, 0x0e4, 0x0e8, 24, 1, 31,
 			      0x8, 11, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_11 */
-	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_182M_SEL, occ_182m_parents,
+	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_182M_SEL, occ_182m_parents,
 			      0x0ec, 0x0f0, 0x0f4, 0, 2, 7,
 			      0x8, 12, CLK_MUX_SETCLR_UPD),
 };

-- 
2.43.0

