Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3CC43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CEF984AA4;
	Tue,  7 Jul 2026 17:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Ti7CNf06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A23A84A67; Tue,  7 Jul 2026 17:10:57 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B12784A8F
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso3756966a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437054; x=1784041854; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SIV+3mHstq3+8J+7LV0VH6fNfYlxrCv/xRuoLBUF8Hc=;
 b=Ti7CNf06zsS0ikEYz11ysLsnHuHD9FlrrZhn5vIFEJOZMUkTza1QvNEPcbg2lzZ9Ca
 FomaekgjcfmFPilR/pRL3z5sfxQoM71ZJlGBTHzAqn0PFp/jwoC2McVzEzkQqcnlhSev
 q9OmtVyGjZZVLDo2ymn07MLT9IcTfpkMy40rPxmTtRlOBhAym4q7MtoE6INzjVbgetP/
 hs8o6Kukjo/wWP2eG2PVskiLR2L3WpRBz7jmd5RGXnFuC9s5z0FJYukJ5dWIdxG7OVBG
 y7v1XvaMpoSSSpXYjRRVDgthQbvdZDMBABDYsAm9mwjpU79OzRkzHsiXP7ER1s62MBh8
 EdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437054; x=1784041854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SIV+3mHstq3+8J+7LV0VH6fNfYlxrCv/xRuoLBUF8Hc=;
 b=hSDqbDmsd6xN4F8kjW3WeKgvTCQ/RzZadxGdfLCd8VMuzU5WbE1KkgLSupimCx1XV6
 SIeL4Mo6jtql2xeeMjlCgW6WOC2jqxjbUrUhcW+lcs5waOBKInWeLOnjPCHCKhSGfKhf
 7pEpsDAsjb1MtCbIPCqZnB7inSN/g50P5AM+T8PIdXhh1vehAsKR7/ZNht0P/997RQk4
 bfvSjEXLYeRcxoVCQiCoK+8M7j/UU6KqhRHViXOHUt2oJSi68kaWd2oFvJ938nz3v/3F
 00FyvHV6lmDfurM5pEiLhNYRrCZkIiDNm95sgMU4SHEGM5CvdqRMEegWqFlQqIl1O92t
 mcsw==
X-Gm-Message-State: AOJu0YxvvRJlulXiCmTxJSkMitZ0OZXUJ6YWNTQKvTDnkj32KiH1i4wc
 yzvjCd5tjoXCY6lupS06neuaW3kV0KLuXZTJP7F25y6kFf6/6RtTv8Zswt30+052C4Q=
X-Gm-Gg: AfdE7ck11Gh3Cat+qYqghCmjJvh4Z/W4JGWnE+4DZ7VIHIw30gvCWH+BqF+lskBcHmf
 pFVEy94AoBNViLjaMHRyjymrlSMJfKqteJR/hBRJBlhwItmFa+HeHSreO98xgbP7kyOXbdRIwEW
 VBgd0pn/+VsT3zY0J7NsvhZYJh37bNMxqE8H8/oqoYC8KiLxKWNFDY66mmSb6JuiM9FK25K5niV
 yQyWyX6kPm53nZZa0qDHk7TXYQvk7a+tJjwXzbjk/lTn6ZuLz5RzsjTTj5FAtovq8CIRrLwjgfd
 6DLV552j1iZrTmitYZGecrywV1ZY6nSsjT8RQozxpjYkPxQBpwHkbeKI6e1w7QnL67e+nxL1bxZ
 pa6xjpOfDeRiQxcN81l3do0mmJf6MEQ3DM/kI7BmqDOdv4ghRSCP0CAoya2sB5QW4+RfTjuCTv+
 QeeEQ1VUMD7s4BP8mMLQ==
X-Received: by 2002:a05:6820:2114:b0:6a1:788e:86a1 with SMTP id
 006d021491bc7-6a355367590mr4069050eaf.18.1783437053784; 
 Tue, 07 Jul 2026 08:10:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:44 -0500
Subject: [PATCH 24/24] clk: mediatek: mt7629: remove mt7629_peri_clk_tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-24-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QioXU5PksNsBW2lRklmB4LxfP6wdpbpA3Bupk+Mq6ks=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRbXNQ/1iIBCn9WPz2UnE1uLsAJycOwo5X0+g
 qM+6Yj4xgGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0W1xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5E4IAILnyaFUspx8DC+kZcWqp2bZDFTJz5T7NT9Kc0H
 EKYnfG7YEPmttqShNXe2NI3QoMlctJi8TEla+Q12+WKdLjIQ/ew6LRIYIFSPBZWbGR/LN8VjlNW
 f0vaFs3pENl8TphQ5QA5VkYcD36cpZLdYzamNobQ7hlOsoXmkmGA4RwBEIkLw8cpcnwrPxnqsTn
 a909ls6WhydYICD82G/784SgDuLxPqIvLy8lujS8MFx5xFTKogB5Z5Q0fQ12/4C/cV642npIZpn
 Tej3Yp/4YDrcLySGgfwnP8c6wxHWEwHjbIR3QT+h2QkqSXCt9CecuG/AzKM5oIWjPniaXVYoxlq
 kzfA=
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

Remove the mt7629_peri_clk_tree struct. Most of the fields are unused
and we can just use mt7629_clk_tree instead as it has the required
fields.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 621abe4d1a3..793cabf8490 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -603,22 +603,6 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
-static const struct mtk_clk_tree mt7629_peri_clk_tree = {
-	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
-	.fclks = top_fixed_clks,
-	.fdivs = top_fixed_divs,
-	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
-	.num_fclks = ARRAY_SIZE(top_fixed_clks),
-	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
-	.num_muxes = ARRAY_SIZE(top_muxes),
-};
-
 static int mt7629_mcucfg_probe(struct udevice *dev)
 {
 	void __iomem *base;
@@ -665,7 +649,7 @@ static int mt7629_infracfg_probe(struct udevice *dev)
 
 static int mt7629_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_peri_clk_tree, peri_cgs,
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, peri_cgs,
 					ARRAY_SIZE(peri_cgs), CLK_PERI_PWM1_PD);
 }
 

-- 
2.43.0

