Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAE9EB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E9C83F98;
	Tue,  3 Mar 2026 01:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K2VVXM46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F7783F8E; Tue,  3 Mar 2026 01:05:14 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B476B83F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so103336fac.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496308; x=1773101108;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YtOudwXUVueVSAu3S4JxA1emlNEoiwd6j/4JXlv8G3o=;
 b=K2VVXM46Hvsgbgx2YFdQb9uiZoVQnX3ZkcDwh29hH9a68MFnW4aB8x5osx5PWe046Z
 ztGC4Si+I2cQB4irmR+K1WT99vT1ymIvVhKXFsfTGw8VIpS5F8EPtrLsdwOnb9tDBCyo
 2jfPlxO70I4l/+CXprnlYsHsBdIFNu3cFXgk+w1I1cK0ZiQK24pIYfmNfBsZQphcwWvr
 XBJWw1H0Xocq1VBzTh9TR18Tnc1Cyfo81470nB+r18lrjVZG6XbqOpMKJy8P/dypfB7c
 qcaxWOx9j3R7TLcqR1HdL745jZU5uwCLW7QUJU0DlTNoDR/cg5ZPWD5YmCOApHYEz8nK
 s65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496308; x=1773101108;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YtOudwXUVueVSAu3S4JxA1emlNEoiwd6j/4JXlv8G3o=;
 b=KFC7Thx95sywAf+EQ87KTMqLK8eiKZlMYm96a7W4qsGoO83qAKm7vtrgY+6yMmpbze
 6qI6yHztCjCfC4EG/K+w2ACUiJZGSEgemxESJ8lrLcrsDnZqiDuaE5E65H+k+Jhrm4kJ
 Fq62Dy9AVcCDQRGRCwqBw1ONhMWJprsvwnq1RwT70CnosMtHRayLB8OE6yTWfmWc4R+s
 TiPOQVG+FiBzNTbs0NV/YhhU9NQPAdgqAWJ6IcjtIMq8SDGDACaQU+miKOtj1JxEOuNz
 N+brdPStrXzjk2dz1UvodM1o1SAKu2k6wZE7NrHZ5SdQ9Fj6PfiZO2TPFPj9yrBWW528
 omKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUMl1y0DxxEmDq0DiSYpQegekXIoJT9yYs8vgQWVU7IEwXvoNoYrEZYc4qGpNjG93Svd/w3gA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyve7rW1pIdPBY4FI7WHgeF4yWLOtcu1IUMhLzIK/dmozg9CcVh
 Sp4LSH9lPQTzQNBQ40KGIv1tW6Eu7BSXTlBxauQ2ToRXFZ18Q++w/N4ySYfKuJ+CAkc=
X-Gm-Gg: ATEYQzyHmCLSXnUPAqyC/aXSVRlMtqaEN+38zMXquO0bMQXQZQil7k78HAq8FjTEEBG
 D1Th+Xkv0xEg+HT6nLJ2kelpAyyymKZUOKn7YcNpZBiJ1FFmjnAXaWqlSAmikxFwJnQ3D1iZ5YP
 XEZpKRyG+LZdP8DkHiaFb5NF+Iu7qltlRkilr5obaq9tNqzh6ZeugnGAxIObxxe5BhKr++x48Fa
 ygw+N/4TMwi78IHcmZSJG1Rd5AEg6e0zx+4tjPCw3harMcwQG3WJBxUHM+t9PLeRN4+rFMw1g3p
 bsFgsskHuWQ9o0BwUiKO0BR4VhpGtgI5cXVBwDOnhD7KZUPK/c/5/A86Xqh0akxbSagnXFM5pps
 ABD/ErR9KkKG9dlJkmn7+L7wszztM7Feh9L3xDehLsplKCfM7rQzCFZbqbRIGTXCvKizoDStFd8
 14zf2t+Q5HUz7QJ6+MRe/Rx159q3pV
X-Received: by 2002:a05:6871:71c8:b0:414:e37a:9b80 with SMTP id
 586e51a60fabf-41627093a25mr9980223fac.45.1772496308091; 
 Mon, 02 Mar 2026 16:05:08 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:17 -0600
Subject: [PATCH 08/14] clk: mediatek: mt8195: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-8-32f45085f4d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=53759;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=SfkixxsRDHad90pl2LuWJ0LSt8+KuOX4KBg8gk8IBXE=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiV+Sf/+LkX/7BHnaABgoJl6w93//GdtjKs0d
 dNsF6feJPeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlfhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyowIAIGg1BnwkYLojegGJsZDUqSbHJer88JTJbz9M1m
 cCOgnCXXKZfCjyfyiVFC4NfAUm15+Ps/qnXY5tnUsFihWclz4TmeYtDleMlPMe+J9qsF1dVjaQ0
 Zg3Ue77kAhqBvSwLUaQlTE5x8PiTqEOjmgLH8FzgwYoIDWXFh135qFr9LSNAM5WRGFeUh9fPhbB
 +NH2CKy0Vvu560T63UmdY2iwUiPDb1ZL5k8NLKzAatSjF5Qu95fQvVkkEHoUyTBFjBoQ/xjfXfY
 m9IIjCFVlmiJqk/qTioZES4oTTzsV6h8mRx18Eki6qDiuAIUgCBkmClwnxQ9YfV3FxwB2rlPdhP
 5Zqg=
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
 drivers/clk/mediatek/clk-mt8195.c | 1578 ++++++++++++++++++-------------------
 1 file changed, 789 insertions(+), 789 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index d9d63601cc4..1df5f875534 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -232,890 +232,890 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_HDMIRX_APLL, CLK_APMIXED_HDMIRX_APLL, 1, 1),
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
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_MAINPLL_D6_D2
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
-	CLK_TOP_UNIVPLL_D5_D2
-};
-
-static const int cam_parents[] = {
-	CLK_TOP_CLK26M,
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
-static const int img_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_IMGPLL,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D6,
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
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_MAINPLL_D3,
-	CLK_TOP_UNIVPLL_D3
-};
-
-static const int ipu_if_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4
-};
-
-static const int mfg_parents[] = {
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
-	CLK_TOP_UNIVPLL_D6_D16,
-	CLK_TOP_CLK26M_D2,
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
-	CLK_TOP_MSDCPLL_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D5_D4
-};
-
-static const int spis_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_MAINPLL_D7_D4
-};
-
-static const int msdc50_0_h_parents[] = {
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
-static const int msdc30_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MSDCPLL_D2
-};
-
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
-};
-
-static const int audio_h_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2
-};
-
-static const int pwrap_ulposc_parents[] = {
-	CLK_TOP_ULPOSC1_D10,
-	CLK_TOP_CLK26M,
-	CLK_TOP_ULPOSC1_D4,
-	CLK_TOP_ULPOSC1_D7,
-	CLK_TOP_ULPOSC1_D8,
-	CLK_TOP_ULPOSC1_D16,
-	CLK_TOP_MAINPLL_D4_D8,
-	CLK_TOP_UNIVPLL_D5_D8
-};
-
-static const int atb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D5_D2
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
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
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
+};
+
+static const struct mtk_parent cam_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
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
+static const struct mtk_parent img_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_IMGPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
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
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+};
+
+static const struct mtk_parent ipu_if_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+};
+
+static const struct mtk_parent mfg_parents[] = {
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
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D16),
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
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
+	TOP_PARENT(CLK_TOP_MSDCPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+};
+
+static const struct mtk_parent spis_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+};
+
+static const struct mtk_parent msdc50_0_h_parents[] = {
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
+static const struct mtk_parent msdc30_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
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
+};
+
+static const struct mtk_parent audio_h_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+};
+
+static const struct mtk_parent pwrap_ulposc_parents[] = {
+	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D8),
+};
+
+static const struct mtk_parent atb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+};
 
-static const int pwrmcu_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D9,
-	CLK_TOP_MAINPLL_D4_D2
+static const struct mtk_parent pwrmcu_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D9),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 };
 
-static const int dp_parents[] = {
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
-static const int disp_pwm_parents[] = {
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
-	CLK_TOP_UNIVPLL_D4_D2,
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
-static const int dxcc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D4_D8
-};
-
-static const int dpmaif_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D4_D2
-};
-
-static const int aes_fde_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D6
-};
-
-static const int ufs_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D4_D8,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MSDCPLL_D2
-};
-
-static const int ufs_tick1us_parents[] = {
-	CLK_TOP_CLK26M_D52,
-	CLK_TOP_CLK26M
-};
-
-static const int ufs_mp_sap_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL_D16
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
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_MAINPLL_D5,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D5,
-	CLK_TOP_VDECPLL,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MMPLL_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MMPLL_D9,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MAINPLL_D4
-};
-
-static const int pwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D8
-};
-
-static const int mcupm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D7_D4,
-};
-
-static const int spmi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK26M_D2,
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
-static const int dsi_occ_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MAINPLL_D6_D2,
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
-};
-
-static const int hdcp_24m_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_192M_D4,
-	CLK_TOP_UNIVPLL_192M_D8,
-	CLK_TOP_UNIVPLL_D6_D8
-};
-
-static const int hd20_dacr_ref_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D4_D8
-};
-
-static const int hd20_hdcp_c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL_D4,
-	CLK_TOP_UNIVPLL_D4_D8,
-	CLK_TOP_UNIVPLL_D6_D8
+static const struct mtk_parent dp_parents[] = {
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
+static const struct mtk_parent disp_pwm_parents[] = {
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
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
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
+static const struct mtk_parent dxcc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+};
+
+static const struct mtk_parent dpmaif_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent aes_fde_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+};
+
+static const struct mtk_parent ufs_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent ufs_tick1us_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M_D52),
+	TOP_PARENT(CLK_TOP_CLK26M),
+};
+
+static const struct mtk_parent ufs_mp_sap_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D16),
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
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D5),
+	TOP_PARENT(CLK_TOP_VDECPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D9),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
+};
+
+static const struct mtk_parent mcupm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+};
+
+static const struct mtk_parent spmi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
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
+static const struct mtk_parent dsi_occ_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
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
+};
+
+static const struct mtk_parent hdcp_24m_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+};
+
+static const struct mtk_parent hd20_dacr_ref_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
+};
+
+static const struct mtk_parent hd20_hdcp_c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
-static const int hdmi_xtal_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK26M_D2
+static const struct mtk_parent hdmi_xtal_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
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
+static const struct mtk_parent snps_eth_62p4m_ptp_parents[] = {
+	TOP_PARENT(CLK_TOP_APLL2_D3),
+	TOP_PARENT(CLK_TOP_APLL1_D3),
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D8),
 };
 
-static const int snps_eth_50m_rmii_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_ETHPLL_D10
+static const struct mtk_parent snps_eth_50m_rmii_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D10),
 };
 
-static const int dgi_out_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_DGIPLL,
-	CLK_TOP_DGIPLL_D2,
-	CLK_TOP_IN_DGI,
-	CLK_TOP_IN_DGI_D2,
-	CLK_TOP_MMPLL_D4_D4
+static const struct mtk_parent dgi_out_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_DGIPLL),
+	TOP_PARENT(CLK_TOP_DGIPLL_D2),
+	TOP_PARENT(CLK_TOP_IN_DGI),
+	TOP_PARENT(CLK_TOP_IN_DGI_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D4),
 };
 
-static const int nna_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_NNAPLL,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_MAINPLL_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MMPLL_D4_D2,
-	CLK_TOP_UNIVPLL_D4_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MMPLL_D6_D2
+static const struct mtk_parent nna_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_NNAPLL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
 };
 
-static const int adsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK26M_D2,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D4_D4,
-	CLK_TOP_UNIVPLL_D4,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_ULPOSC1,
-	CLK_TOP_ADSPPLL,
-	CLK_TOP_ADSPPLL_D2,
-	CLK_TOP_ADSPPLL_D4,
-	CLK_TOP_ADSPPLL_D8
+static const struct mtk_parent adsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_ULPOSC1),
+	TOP_PARENT(CLK_TOP_ADSPPLL),
+	TOP_PARENT(CLK_TOP_ADSPPLL_D2),
+	TOP_PARENT(CLK_TOP_ADSPPLL_D4),
+	TOP_PARENT(CLK_TOP_ADSPPLL_D8),
 };
 
-static const int asm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D2,
-	CLK_TOP_MAINPLL_D5_D2
+static const struct mtk_parent asm_parents[] = {
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
 
-static const int i2s_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1,
-	CLK_TOP_APLL2,
-	CLK_TOP_APLL3,
-	CLK_TOP_APLL4,
-	CLK_TOP_APLL5,
-	CLK_TOP_HDMIRX_APLL
+static const struct mtk_parent i2s_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1),
+	TOP_PARENT(CLK_TOP_APLL2),
+	TOP_PARENT(CLK_TOP_APLL3),
+	TOP_PARENT(CLK_TOP_APLL4),
+	TOP_PARENT(CLK_TOP_APLL5),
+	TOP_PARENT(CLK_TOP_HDMIRX_APLL),
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
-	CLK_TOP_APLL5_D4,
-	CLK_TOP_HDMIRX_APLL_D3,
-	CLK_TOP_HDMIRX_APLL_D4,
-	CLK_TOP_HDMIRX_APLL_D6
-};
-
-static const int spinfi_b_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D6_D8,
-	CLK_TOP_UNIVPLL_D5_D8,
-	CLK_TOP_MAINPLL_D4_D8,
-	CLK_TOP_MAINPLL_D7_D4,
-	CLK_TOP_MAINPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D5_D4
-};
-
-static const int nfi1x_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_MAINPLL_D7_D4,
-	CLK_TOP_MAINPLL_D6_D4,
-	CLK_TOP_UNIVPLL_D6_D4,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D6_D2
+static const struct mtk_parent a3sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL3_D4),
+	TOP_PARENT(CLK_TOP_APLL4_D4),
+	TOP_PARENT(CLK_TOP_APLL5_D4),
+	TOP_PARENT(CLK_TOP_HDMIRX_APLL_D3),
+	TOP_PARENT(CLK_TOP_HDMIRX_APLL_D4),
+	TOP_PARENT(CLK_TOP_HDMIRX_APLL_D6),
+};
+
+static const struct mtk_parent spinfi_b_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+};
+
+static const struct mtk_parent nfi1x_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
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
 
-static const int audio_local_bus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK26M_D2,
-	CLK_TOP_MAINPLL_D4_D4,
-	CLK_TOP_MAINPLL_D7_D2,
-	CLK_TOP_MAINPLL_D4_D2,
-	CLK_TOP_MAINPLL_D5_D2,
-	CLK_TOP_MAINPLL_D6_D2,
-	CLK_TOP_MAINPLL_D7,
-	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_ULPOSC1,
-	CLK_TOP_ULPOSC1_D4,
-	CLK_TOP_ULPOSC1_D2
+static const struct mtk_parent audio_local_bus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_ULPOSC1),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
+	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
 };
 
-static const int spinor_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_CLK26M_D2,
-	CLK_TOP_MAINPLL_D7_D8,
-	CLK_TOP_UNIVPLL_D6_D8
+static const struct mtk_parent spinor_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_CLK26M_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
-static const int dvio_dgi_ref_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_IN_DGI,
-	CLK_TOP_IN_DGI_D2,
-	CLK_TOP_IN_DGI_D4,
-	CLK_TOP_IN_DGI_D6,
-	CLK_TOP_IN_DGI_D8,
-	CLK_TOP_MMPLL_D4_D4
+static const struct mtk_parent dvio_dgi_ref_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_IN_DGI),
+	TOP_PARENT(CLK_TOP_IN_DGI_D2),
+	TOP_PARENT(CLK_TOP_IN_DGI_D4),
+	TOP_PARENT(CLK_TOP_IN_DGI_D6),
+	TOP_PARENT(CLK_TOP_IN_DGI_D8),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D4),
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
-
-static const int ulposc_core_parents[] = {
-	CLK_TOP_ULPOSC2,
-	CLK_TOP_UNIVPLL_D7,
-	CLK_TOP_MAINPLL_D6,
-	CLK_TOP_ETHPLL_D10
+
+static const struct mtk_parent ulposc_core_parents[] = {
+	TOP_PARENT(CLK_TOP_ULPOSC2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
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
-	MUX_GATE(CLK_TOP_AXI, axi_parents, 0x020, 0, 3, 7),
-	MUX_GATE(CLK_TOP_SPM, spm_parents, 0x020, 8, 2, 15),
-	MUX_GATE(CLK_TOP_SCP, scp_parents, 0x020, 16, 3, 23),
-	MUX_GATE(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI, axi_parents, 0x020, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPM, spm_parents, 0x020, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_SCP, scp_parents, 0x020, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 3, 31),
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
-	MUX_GATE(CLK_TOP_IMG, img_parents, 0x038, 8, 4, 15),
-	MUX_GATE(CLK_TOP_CAMTM, camtm_parents, 0x038, 16, 2, 23),
-	MUX_GATE(CLK_TOP_DSP, dsp_parents, 0x038, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_IMG, img_parents, 0x038, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_CAMTM, camtm_parents, 0x038, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_DSP, dsp_parents, 0x038, 24, 3, 31),
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_DSP1, dsp1_parents, 0x044, 0, 3, 7),
-	MUX_GATE(CLK_TOP_DSP2, dsp1_parents, 0x044, 8, 3, 15),
-	MUX_GATE(CLK_TOP_DSP3, dsp1_parents, 0x044, 16, 3, 23),
-	MUX_GATE(CLK_TOP_DSP4, dsp2_parents, 0x044, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_DSP1, dsp1_parents, 0x044, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_DSP2, dsp1_parents, 0x044, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_DSP3, dsp1_parents, 0x044, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_DSP4, dsp2_parents, 0x044, 24, 3, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_DSP5, dsp2_parents, 0x050, 0, 3, 7),
-	MUX_GATE(CLK_TOP_DSP6, dsp2_parents, 0x050, 8, 3, 15),
-	MUX_GATE(CLK_TOP_DSP7, dsp_parents, 0x050, 16, 3, 23),
-	MUX_GATE(CLK_TOP_IPU_IF, ipu_if_parents, 0x050, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_DSP5, dsp2_parents, 0x050, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_DSP6, dsp2_parents, 0x050, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_DSP7, dsp_parents, 0x050, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_IPU_IF, ipu_if_parents, 0x050, 24, 3, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_MFG_CORE_TMP, mfg_parents, 0x05C, 0, 2, 7),
-	MUX_GATE(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 3, 15),
-	MUX_GATE(CLK_TOP_CAMTG2, camtg_parents, 0x05C, 16, 3, 23),
-	MUX_GATE(CLK_TOP_CAMTG3, camtg_parents, 0x05C, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MFG_CORE_TMP, mfg_parents, 0x05C, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG2, camtg_parents, 0x05C, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG3, camtg_parents, 0x05C, 24, 3, 31),
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_CAMTG4, camtg_parents, 0x068, 0, 3, 7),
-	MUX_GATE(CLK_TOP_CAMTG5, camtg_parents, 0x068, 8, 3, 15),
-	MUX_GATE(CLK_TOP_UART, uart_parents, 0x068, 16, 1, 23),
-	MUX_GATE(CLK_TOP_SPI, spi_parents, 0x068, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG4, camtg_parents, 0x068, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG5, camtg_parents, 0x068, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_UART, uart_parents, 0x068, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_SPI, spi_parents, 0x068, 24, 3, 31),
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_SPIS, spis_parents, 0x074, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC50_0_HCLK, msdc50_0_h_parents, 0x074, 8, 2, 15),
-	MUX_GATE(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x074, 16, 3, 23),
-	MUX_GATE(CLK_TOP_MSDC30_1, msdc30_parents, 0x074, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_SPIS, spis_parents, 0x074, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_HCLK, msdc50_0_h_parents, 0x074, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x074, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1, msdc30_parents, 0x074, 24, 3, 31),
 	/* CLK_CFG_8 */
-	MUX_GATE(CLK_TOP_MSDC30_2, msdc30_parents, 0x080, 0, 3, 7),
-	MUX_GATE(CLK_TOP_INTDIR, intdir_parents, 0x080, 8, 2, 15),
-	MUX_GATE(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x080, 16, 2, 23),
-	MUX_GATE(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_2, msdc30_parents, 0x080, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR, intdir_parents, 0x080, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x080, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 24, 2, 31),
 	/* CLK_CFG_9 */
-	MUX_GATE(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x08C, 0, 3, 7),
-	MUX_GATE(CLK_TOP_ATB, atb_parents, 0x08C, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PWRMCU, pwrmcu_parents, 0x08C, 16, 3, 23),
-	MUX_GATE(CLK_TOP_DP, dp_parents, 0x08C, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x08C, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_ATB, atb_parents, 0x08C, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PWRMCU, pwrmcu_parents, 0x08C, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_DP, dp_parents, 0x08C, 24, 4, 31),
 	/* CLK_CFG_10 */
-	MUX_GATE(CLK_TOP_EDP, dp_parents, 0x098, 0, 4, 7),
-	MUX_GATE(CLK_TOP_DPI, dp_parents, 0x098, 8, 4, 15),
-	MUX_GATE(CLK_TOP_DISP_PWM0, disp_pwm_parents, 0x098, 16, 3, 23),
-	MUX_GATE(CLK_TOP_DISP_PWM1, disp_pwm_parents, 0x098, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_EDP, dp_parents, 0x098, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_DPI, dp_parents, 0x098, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_DISP_PWM0, disp_pwm_parents, 0x098, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_DISP_PWM1, disp_pwm_parents, 0x098, 24, 3, 31),
 	/* CLK_CFG_11 */
-	MUX_GATE(CLK_TOP_USB_TOP, usb_parents, 0x0A4, 0, 2, 7),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI, usb_parents, 0x0A4, 8, 2, 15),
-	MUX_GATE(CLK_TOP_USB_TOP_1P, usb_parents, 0x0A4, 16, 2, 23),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI_1P, usb_parents, 0x0A4, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP, usb_parents, 0x0A4, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI, usb_parents, 0x0A4, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP_1P, usb_parents, 0x0A4, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_1P, usb_parents, 0x0A4, 24, 2, 31),
 	/* CLK_CFG_12 */
-	MUX_GATE(CLK_TOP_USB_TOP_2P, usb_parents, 0x0B0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI_2P, usb_parents, 0x0B0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_USB_TOP_3P, usb_parents, 0x0B0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_SSUSB_XHCI_3P, usb_parents, 0x0B0, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP_2P, usb_parents, 0x0B0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_2P, usb_parents, 0x0B0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_USB_TOP_3P, usb_parents, 0x0B0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_3P, usb_parents, 0x0B0, 24, 2, 31),
 	/* CLK_CFG_13 */
-	MUX_GATE(CLK_TOP_I2C, i2c_parents, 0x0BC, 0, 2, 7),
-	MUX_GATE(CLK_TOP_SENINF, seninf_parents, 0x0BC, 8, 3, 15),
-	MUX_GATE(CLK_TOP_SENINF1, seninf_parents, 0x0BC, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SENINF2, seninf_parents, 0x0BC, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_I2C, i2c_parents, 0x0BC, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_SENINF, seninf_parents, 0x0BC, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_SENINF1, seninf_parents, 0x0BC, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SENINF2, seninf_parents, 0x0BC, 24, 3, 31),
 	/* CLK_CFG_14 */
-	MUX_GATE(CLK_TOP_SENINF3, seninf_parents, 0x0C8, 0, 3, 7),
-	MUX_GATE(CLK_TOP_GCPU, gcpu_parents, 0x0C8, 8, 3, 15),
-	MUX_GATE(CLK_TOP_DXCC, dxcc_parents, 0x0C8, 16, 2, 23),
-	MUX_GATE(CLK_TOP_DPMAIF_MAIN, dpmaif_parents, 0x0C8, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_SENINF3, seninf_parents, 0x0C8, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_GCPU, gcpu_parents, 0x0C8, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_DXCC, dxcc_parents, 0x0C8, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_DPMAIF_MAIN, dpmaif_parents, 0x0C8, 24, 3, 31),
 	/* CLK_CFG_15 */
-	MUX_GATE(CLK_TOP_AES_UFSFDE, aes_fde_parents, 0x0D4, 0, 3, 7),
-	MUX_GATE(CLK_TOP_UFS, ufs_parents, 0x0D4, 8, 3, 15),
-	MUX_GATE(CLK_TOP_UFS_TICK1US, ufs_tick1us_parents, 0x0D4, 16, 1, 23),
-	MUX_GATE(CLK_TOP_UFS_MP_SAP_CFG, ufs_mp_sap_parents, 0x0D4, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_AES_UFSFDE, aes_fde_parents, 0x0D4, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_UFS, ufs_parents, 0x0D4, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_UFS_TICK1US, ufs_tick1us_parents, 0x0D4, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_UFS_MP_SAP_CFG, ufs_mp_sap_parents, 0x0D4, 24, 1, 31),
 	/* CLK_CFG_16 */
-	MUX_GATE(CLK_TOP_VENC, venc_parents, 0x0E0, 0, 4, 7),
-	MUX_GATE(CLK_TOP_VDEC, vdec_parents, 0x0E0, 8, 4, 15),
-	MUX_GATE(CLK_TOP_PWM, pwm_parents, 0x0E0, 16, 1, 23),
-	MUX_GATE(CLK_TOP_MCUPM, mcupm_parents, 0x0E0, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_VENC, venc_parents, 0x0E0, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_VDEC, vdec_parents, 0x0E0, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_PWM, pwm_parents, 0x0E0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_MCUPM, mcupm_parents, 0x0E0, 24, 2, 31),
 	/* CLK_CFG_17 */
-	MUX_GATE(CLK_TOP_SPMI_P_MST, spmi_parents, 0x0EC, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SPMI_M_MST, spmi_parents, 0x0EC, 8, 4, 15),
-	MUX_GATE(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0EC, 16, 2, 23),
-	MUX_GATE(CLK_TOP_TL, tl_parents, 0x0EC, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_SPMI_P_MST, spmi_parents, 0x0EC, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPMI_M_MST, spmi_parents, 0x0EC, 8, 4, 15),
+	MUX_GATE_MIXED(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0EC, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_TL, tl_parents, 0x0EC, 24, 2, 31),
 	/* CLK_CFG_18 */
-	MUX_GATE(CLK_TOP_TL_P1, tl_parents, 0x0F8, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AES_MSDCFDE, aes_fde_parents, 0x0F8, 8, 3, 15),
-	MUX_GATE(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0F8, 16, 2, 23),
-	MUX_GATE(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0F8, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_TL_P1, tl_parents, 0x0F8, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AES_MSDCFDE, aes_fde_parents, 0x0F8, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0F8, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0F8, 24, 4, 31),
 	/* CLK_CFG_19 */
-	MUX_GATE(CLK_TOP_HDCP, hdcp_parents, 0x0104, 0, 2, 7),
-	MUX_GATE(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0104, 8, 2, 15),
-	MUX_GATE(CLK_TOP_HD20_DACR_REF_CLK, hd20_dacr_ref_parents, 0x0104, 16, 2, 23),
-	MUX_GATE(CLK_TOP_HD20_HDCP_CCLK, hd20_hdcp_c_parents, 0x0104, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_HDCP, hdcp_parents, 0x0104, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0104, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_HD20_DACR_REF_CLK, hd20_dacr_ref_parents, 0x0104, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_HD20_HDCP_CCLK, hd20_hdcp_c_parents, 0x0104, 24, 2, 31),
 	/* CLK_CFG_20 */
-	MUX_GATE(CLK_TOP_HDMI_XTAL, hdmi_xtal_parents, 0x0110, 0, 1, 7),
-	MUX_GATE(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0110, 8, 2, 15),
-	MUX_GATE(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0110, 16, 1,
+	MUX_GATE_MIXED(CLK_TOP_HDMI_XTAL, hdmi_xtal_parents, 0x0110, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0110, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0110, 16, 1,
 		 23),
-	MUX_GATE(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0110, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0110, 24, 2, 31),
 	/* CLK_CFG_21 */
-	MUX_GATE(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x011C, 0, 1, 7),
-	MUX_GATE(CLK_TOP_DGI_OUT, dgi_out_parents, 0x011C, 8, 3, 15),
-	MUX_GATE(CLK_TOP_NNA0, nna_parents, 0x011C, 16, 4, 23),
-	MUX_GATE(CLK_TOP_NNA1, nna_parents, 0x011C, 24, 4, 31),
+	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x011C, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_DGI_OUT, dgi_out_parents, 0x011C, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_NNA0, nna_parents, 0x011C, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_NNA1, nna_parents, 0x011C, 24, 4, 31),
 	/* CLK_CFG_22 */
-	MUX_GATE(CLK_TOP_ADSP, adsp_parents, 0x0128, 0, 4, 7),
-	MUX_GATE(CLK_TOP_ASM_H, asm_parents, 0x0128, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ASM_M, asm_parents, 0x0128, 16, 2, 23),
-	MUX_GATE(CLK_TOP_ASM_L, asm_parents, 0x0128, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_ADSP, adsp_parents, 0x0128, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_ASM_H, asm_parents, 0x0128, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_M, asm_parents, 0x0128, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_L, asm_parents, 0x0128, 24, 2, 31),
 	/* CLK_CFG_23 */
-	MUX_GATE(CLK_TOP_APLL1, apll1_parents, 0x0134, 0, 1, 7),
-	MUX_GATE(CLK_TOP_APLL2, apll2_parents, 0x0134, 8, 1, 15),
-	MUX_GATE(CLK_TOP_APLL3, apll3_parents, 0x0134, 16, 1, 23),
-	MUX_GATE(CLK_TOP_APLL4, apll4_parents, 0x0134, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_APLL1, apll1_parents, 0x0134, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_APLL2, apll2_parents, 0x0134, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_APLL3, apll3_parents, 0x0134, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_APLL4, apll4_parents, 0x0134, 24, 1, 31),
 	/*
 	 * CLK_CFG_24
 	 * i2so4_mck is not used in MT8195.
 	 */
-	MUX_GATE(CLK_TOP_APLL5, apll5_parents, 0x0140, 0, 1, 7),
-	MUX_GATE(CLK_TOP_I2SO1_MCK, i2s_parents, 0x0140, 8, 3, 15),
-	MUX_GATE(CLK_TOP_I2SO2_MCK, i2s_parents, 0x0140, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_APLL5, apll5_parents, 0x0140, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_I2SO1_MCK, i2s_parents, 0x0140, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_I2SO2_MCK, i2s_parents, 0x0140, 16, 3, 23),
 	/*
 	 * CLK_CFG_25
 	 * i2so5_mck and i2si4_mck are not used in MT8195.
 	 */
-	MUX_GATE(CLK_TOP_I2SI1_MCK, i2s_parents, 0x014C, 8, 3, 15),
-	MUX_GATE(CLK_TOP_I2SI2_MCK, i2s_parents, 0x014C, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_I2SI1_MCK, i2s_parents, 0x014C, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_I2SI2_MCK, i2s_parents, 0x014C, 16, 3, 23),
 	/*
 	 * CLK_CFG_26
 	 * i2si5_mck is not used in MT8195.
 	 */
-	MUX_GATE(CLK_TOP_DPTX_MCK, i2s_parents, 0x0158, 8, 3, 15),
-	MUX_GATE(CLK_TOP_AUD_IEC_CLK, i2s_parents, 0x0158, 16, 3, 23),
-	MUX_GATE(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0158, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_DPTX_MCK, i2s_parents, 0x0158, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUD_IEC_CLK, i2s_parents, 0x0158, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0158, 24, 1, 31),
 	/* CLK_CFG_27 */
-	MUX_GATE(CLK_TOP_A2SYS_HF, a2sys_parents, 0x0164, 0, 1, 7),
-	MUX_GATE(CLK_TOP_A3SYS_HF, a3sys_parents, 0x0164, 8, 3, 15),
-	MUX_GATE(CLK_TOP_A4SYS_HF, a3sys_parents, 0x0164, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SPINFI_BCLK, spinfi_b_parents, 0x0164, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_A2SYS_HF, a2sys_parents, 0x0164, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_A3SYS_HF, a3sys_parents, 0x0164, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_A4SYS_HF, a3sys_parents, 0x0164, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SPINFI_BCLK, spinfi_b_parents, 0x0164, 24, 3, 31),
 	/* CLK_CFG_28 */
-	MUX_GATE(CLK_TOP_NFI1X, nfi1x_parents, 0x0170, 0, 3, 7),
-	MUX_GATE(CLK_TOP_ECC, ecc_parents, 0x0170, 8, 3, 15),
-	MUX_GATE(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0170, 16, 4, 23),
-	MUX_GATE(CLK_TOP_SPINOR, spinor_parents, 0x0170, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_NFI1X, nfi1x_parents, 0x0170, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_ECC, ecc_parents, 0x0170, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0170, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_SPINOR, spinor_parents, 0x0170, 24, 2, 31),
 	/* CLK_CFG_29 */
-	MUX_GATE(CLK_TOP_DVIO_DGI_REF, dvio_dgi_ref_parents, 0x017C, 0, 3, 7),
-	MUX_GATE(CLK_TOP_ULPOSC, ulposc_parents, 0x017C, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ULPOSC_CORE, ulposc_core_parents, 0x017C, 16, 2, 23),
-	MUX_GATE(CLK_TOP_SRCK, srck_parents, 0x017C, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_DVIO_DGI_REF, dvio_dgi_ref_parents, 0x017C, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_ULPOSC, ulposc_parents, 0x017C, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ULPOSC_CORE, ulposc_core_parents, 0x017C, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_SRCK, srck_parents, 0x017C, 24, 1, 31),
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {

-- 
2.43.0

