Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1320FCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425D184006;
	Fri,  6 Mar 2026 23:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M86ZyrIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE65F83FA3; Fri,  6 Mar 2026 23:07:13 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFBE83F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d596ab0917so6022341a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834830; x=1773439630;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ju1kh1ViyBQkY65NM8OoLTA74RCB42e7xA4bcC1HkA8=;
 b=M86ZyrIqd/ZODESF+lxgi7Qes0a88QeFaRJNfonyCHknz8NombdG1hnprO2M78BnJ9
 8s5QtEzSNDlkrTZWfSGv/rIu+AANnUokQP8FeAR2Hyd9vOjusvwN7V+Oop41gHSbvoR7
 id0G73Q2nU8yJGXytmAGMBLnbJf1bbV8w8dSEQ49JUVsS4i4C/MsNrjKXKWtPTzYLnf8
 YdfYID7VXlpIjbjqG8DHGDo3joDygNmGMBkFFTMsq8dxjyMqcrq7XSVCw2G2xilMNp6H
 O0q0Vf6UKhK0AzRyGqxg5eUowki9EhvRHgbLT64mWOiUDmY/jyAu/C4Y03B9Xj6bkpHg
 RfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834830; x=1773439630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ju1kh1ViyBQkY65NM8OoLTA74RCB42e7xA4bcC1HkA8=;
 b=Q5H9OOnJrEkBtiZN9Fra3vLgPJvrDeWca4LrczO3qyTASlefruhV6Tdb8Hvi+CxuRB
 q+AHBCkBvIMvunT1fWQivkp5MO3MRgvd23dAbU1fktAE9DxW/iiTg/2p4ehSp57mJ+wU
 a+CK/96o2nloS35V4uJwpAJhADNzT4JYDrcEUhwZhdAohFoAOIe07T965+VT34sMeA4n
 46C0tDodny54D7VkCxz/sQBJ4f9FqSbBcb/nk2FooSqn8qzw9R7REzQydm1dTfH1yDFa
 VcIQR0Mi2cqPjW/Ece8G2pD5EsITsoORYfYCAuoKC5oXe1siEC0ZL95AL6oUeqx6wAPr
 CNVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkAPdAw1DjLUFHgujBIz84L7tnW6Hprw6YTVqfKNvt8OyQ9SjDoeJvL/VNCW8oZFjiFFt0gx4=@lists.denx.de
X-Gm-Message-State: AOJu0YyrSLh8YeU5iwejDnOTD/gsTtY9ouHTapBf17D553Ix4j2l9qn5
 bvTgXLS6wB8A5JpqOCtkMXzFdfhtR8fRsh+eAxQVaf9IM/FoY3Uycspkzv9WM6Ix6ic=
X-Gm-Gg: ATEYQzwmq4dBpIAjD0ztjdeHZxXJ+UYf0H0SZ3PcHnjN/rGQm8Vfrzm6br/JzakehjY
 lQo7GrUAN5FXU4YlfBih774REV/oMkEFwfbKMOsXt/FY+/8ffOvmbvXdxw/v31taoNEkf8t3tfT
 +CYAqATqrSuak/Vll44QpELSEp9iiELJvioF2vQGbHil6foqQ2HfJr3P8xs5ikQxcIXTqqey4wz
 ivkzAIlz/ZfPANEnDpvNqBuWEMor+gcsN931xcLe3gf1fNLsPXMmw7LmY72nHPuZO17nf7i3Dzq
 s0E1ifw1dRvG52MRJB8CaSqvJDpBybs1PAzjOQJuwlT1Zzb8c2HHJbnesYWF0aYGw1CHa3RBF6k
 web7vRMs++QzFneSu7fOjdMbyZcF+VzpVORIU5oqhKHdgVLF5+GZ3c7eYAz2DcJkvGVhZtjXGpl
 zlsS0Rr3TPdIt7B2krAV4kyw0ikZOM
X-Received: by 2002:a9d:624d:0:b0:7d1:48dd:b439 with SMTP id
 46e09a7af769-7d71d15742dmr3317067a34.1.1772834829894; 
 Fri, 06 Mar 2026 14:07:09 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:54 -0600
Subject: [PATCH v2 7/9] clk: mediatek: mt7629: change to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-7-b253b49f17b2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15504;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=RLAExgiZpoxrI4YsksgB/zx7S4Ft+QdHFVoD45FK2Lk=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/yeQ2hGMDJ8Hk5O+flP/XrWWoOrslS5tCtq
 LEQhNWHwuyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhBMIAJIMPAHREwH7xu/JRGM9MT0ZYdg3AQbSJEksgNZ
 QF4K0i/Ff6IDQsHp/cZREbPYpX8CwsZGls1fcJRVUUu+uQPl8S0+4PytUCZd7PbB/FFgcQKCGMW
 b271UInGS9pQlcoBfi5XQNCywE4XVJkcFPruYr8qqDXgndoLe+TUv9LQ8F1++9hRbjbKfV5XYm/
 fvg4YpYuAzzaFGJiYXR7EpFXbp5N9S0VGrnfyZG+Af7aKdz3Rv7QtgAWRUBoQrWJNv5+UFfQvx8
 PtlWEQnuDE78Xu3IoX6X0RKcNmtyHicBY2fallnJyaA1/2K3UT/WN0AujJvStapZdCg9QLv+5F6
 axLY=
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
 drivers/clk/mediatek/clk-mt7629.c | 440 +++++++++++++++++++-------------------
 1 file changed, 220 insertions(+), 220 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 85011f5327b..b82212ec664 100644
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

