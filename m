Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A44DFF6E97
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F1D9842A7;
	Wed, 18 Mar 2026 00:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPfe44rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2160F84242; Wed, 18 Mar 2026 00:26:34 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4778B841E2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40946982a78so2469343fac.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789990; x=1774394790;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IN0PhoZhTlCPCifg1Jgz84xLMH9ol0gYhVrp+woo/3U=;
 b=PPfe44rkCHOyfAxWo5R+WRXx7g72ji5FTrWpm6IknCR+l1BaJJklt1+HQtiKNYsQ4B
 Z3YtQbjrmKtuR7WMleqHzOSlvcxIAkrkmfsv5bf94dQzd7jNYRjXQZ75mQGNdQvrKgu8
 A6KpxgEoHJcrJyvFyFcghshNUey0az2DXm1loK8BPn8SZkfzA7m/ogGbn1bdsq6O68VQ
 0lBsGhMsjR3SRdIUqts1fayEyoNaVA0O086rjgCM24eb1Y4+fvTNZtSLz9EXs2aTPsxT
 E0A53nkpOXuj4rtU0O40Z6KJAealro+Bwd/tmiXja+6VmkSjQC1eyW0x/gM7DzdazNVB
 qjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789990; x=1774394790;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IN0PhoZhTlCPCifg1Jgz84xLMH9ol0gYhVrp+woo/3U=;
 b=WhPm9/UojRyYmXuqh66vFbR7W4NNeIIvyFDhfpiduNe7QrYKART0T4NnjAIhZJWbTC
 5K/Brgp1prTXwItu+2uilHNkU0ivD73VVHCxYPuOf07RQnIaA1NofrCJfK+MQPwhBabh
 n3kl00HC/osPwe5otqQA5V7HFSplTLtp+6eepqlnaI0UWEpHN7xyhIHE3b8Zn7x/0DU0
 aHBny+NLYwrATv1e3MKZqV2T841nNcA03+PO3zzZUCntXblYaw3awLBycf7a1uwqd1Y1
 dp93FisrGmOkkmX4j7MOE2zEPw3OeVP6NduOvdOJrwFTY1ZER3xTgsVUSgUnQKjsyFWi
 ppiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhWQwUfi9an+kd7IcB+rBZfW79PXa0U54yJQsMlwdxHc4IJtMG7tDddQD/vo0joZ6JQS+sK6M=@lists.denx.de
X-Gm-Message-State: AOJu0YyRKmG9kynbZr8dXSWS6Fhpe7XSyyaE0w10SfJMcTuGU6Y9O8DU
 Ded0xop82Mo+oAvwkTaTerCKETSx8wx6vCVU/O4yJPoAunq/+8Byhx7SoWw5mQ72/q0=
X-Gm-Gg: ATEYQzy78Xyw+rfj/xuxqmuQH/cltA4PhelT0ldMgXc+BhfWawKCU8qsOYD9TWsdNAp
 7fu+uVHChNQ/uF4iDCPV3Omg61KTPWfs03PxhTNy44hQy+Ghb7nA9RyYO0RlFZHEyTNIMJlq76t
 upZ/iGYOSjsai0H081B0xg//6XThdk0tGFafl0x99BkTsOJDx1g+m5F2FaknoTfe2MVV5jIj5pd
 SVC6jZi/sSrW9ZIGgef1QhbmIWTuZQ8pI6Rye/4Cc8spFcRHb8juTwnBKH69Y8F7pclJ1hi99kG
 JW0SyNhDkQlobttJK0m75eYW+Gqi1hWAVmow793YXCv0Xe+ru2ak4GiugV5wWD81C9tcKzkqbpN
 zUeywQX0IJdSCQDFU5UXLNo8EdkMyYTcbMpkVV4CUXukMBVvGGpm1MSzFDdijLWY3HIn1Mxxa1O
 Fmq0shv/JE1WE05yHSCmxBMuKCng==
X-Received: by 2002:a05:6870:16d2:b0:417:533b:7999 with SMTP id
 586e51a60fabf-41bd3cf6cc9mr955244fac.1.1773789989853; 
 Tue, 17 Mar 2026 16:26:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:16 -0500
Subject: [PATCH v3 03/16] clk: mediatek: mt7629: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-3-a4760f5b0a80@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15549;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=qU0iXkUq8Ny1GdAhP61OtVuQ6gWlsm/KoqqyfWAvPr4=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueKq7TJv36W8kjRTI9EmRQC7gbze3pfY+zT/0
 QpafjxWnfeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabniqhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZMMH/07fEO8zg3XhAnEz4Xp2IMYmHyE5RKMbiyGuxwV
 qeVekP5kToTUezP3eacMEc7txcYq6D8SZP3tU/tk0Ceedj03vvgF+3ygcIqV1HvdBJi7NISrCa6
 kX4ABFlg7zNDWys7xe2wJPkM3We9DI0bDMvxY9yH76imU03hUxhNMjOkXVcHZjAc5vNbh0HeDQh
 sAOtJ4deJAlvRObQL1K8647Eof2KKqnwZGedE1Kfip8EdhgazAB9E3GWTj0vyELCPdk+JtLx9Ve
 6bHjDAiv8OPxcy12XIWzIkN5WWMWQbdtsuUwz5a7QbnK0IRr8kV+792PXULF/WH197JsF3zuORW
 S+i4=
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

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 440 +++++++++++++++++++-------------------
 1 file changed, 220 insertions(+), 220 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 1d697539ce2..c675104d573 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -152,271 +152,271 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_PCIE0_MAC_EN, CLK_TOP_UNIVPLL1_D4, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_DMPLL
-};
-
-static const int mem_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_DMPLL
-};
-
-static const int ddrphycfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8
-};
-
-static const int eth_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SGMIIPLL_D2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_DMPLL
-};
-
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int sgmii_ref_1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SGMIIPLL_D2
-};
-
-static const int nfi_infra_parents[] = {
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL_D7
-};
-
-static const int flash_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D80_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int spi0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
-};
-
-static const int spi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
-};
-
-static const int msdc30_0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M
-};
-
-static const int msdc30_1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL2_D2
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent ddrphycfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+};
+
+static const struct mtk_parent eth_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SGMIIPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent sgmii_ref_1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SGMIIPLL_D2),
+};
+
+static const struct mtk_parent nfi_infra_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+};
+
+static const struct mtk_parent flash_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent spi0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent spi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent msdc30_0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
+};
+
+static const struct mtk_parent msdc30_1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int ap2wbmcu_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIV48M,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_UNIVPLL2_D2
+static const struct mtk_parent ap2wbmcu_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIV48M),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 };
 
-static const int audio_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL1_D16
+static const struct mtk_parent audio_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_DMPLL_D4
-};
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D4),
+};
 
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_DMPLL_D8
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_DMPLL_D8),
 };
 
-static const int scp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent scp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
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
 
-static const int hif_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	-1,
-	CLK_TOP_UNIVPLL_D7
+static const struct mtk_parent hif_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
-static const int sata_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent sata_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
-static const int aud1_parents[] = {
-	CLK_XTAL
+static const struct mtk_parent aud1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int irrx_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D16
+static const struct mtk_parent irrx_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
 };
 
-static const int crypto_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D2
+static const struct mtk_parent crypto_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
 };
 
-static const int gpt10m_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_CLKXTAL_D4
+static const struct mtk_parent gpt10m_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_CLKXTAL_D4),
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
-	MUX_GATE(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
-	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
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
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_AP2WBMCU_SEL, ap2wbmcu_parents, 0x70, 16, 3, 23),
-	MUX_GATE(CLK_TOP_AP2WBHIF_SEL, ap2wbmcu_parents, 0x70, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_AP2WBMCU_SEL, ap2wbmcu_parents, 0x70, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_AP2WBHIF_SEL, ap2wbmcu_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x80, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x80, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x80, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
-	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_IRRX_SEL, irrx_parents, 0xA0, 16, 1, 23),
-	MUX_GATE(CLK_TOP_IRTX_SEL, irrx_parents, 0xA0, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, irrx_parents, 0xA0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, irrx_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_SATA_MCU_SEL, scp_parents, 0xB0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_PCIE0_MCU_SEL, scp_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PCIE1_MCU_SEL, scp_parents, 0xB0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_SSUSB_MCU_SEL, scp_parents, 0xB0, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_SATA_MCU_SEL, scp_parents, 0xB0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_PCIE0_MCU_SEL, scp_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PCIE1_MCU_SEL, scp_parents, 0xB0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_MCU_SEL, scp_parents, 0xB0, 24, 2, 31),
 
 	/* CLK_CFG_8 */
-	MUX_GATE(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
 };
 
 /* infracfg */

-- 
2.43.0

