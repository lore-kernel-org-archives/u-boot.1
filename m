Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7ADEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BCAE84142;
	Tue, 10 Mar 2026 16:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H7sAu9+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CE684109; Tue, 10 Mar 2026 16:34:30 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1411840D7
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-466ec4c6846so892456b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156866; x=1773761666;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hqOf46rfoFLTwZ0apeSCrT+CPIrEU8Zv8jzPU6ueL3U=;
 b=H7sAu9+3wUbIYLFFyEWZNPZPTh3IVP7+th78EZjnpr+R7/aSTqCbfhLNYLI3c2UfdX
 UMkdDeNCs8dun3BEbukFshm5yXqDigGTgQxfqQAqiLZLBwr3X6KJ1TZ1A5NLPsH63H49
 ZekYQ58om3vRAWl7V52pMYpn164MWpVOg66vKAbp/ZUvLwYL93+dqbg7pRNxUtRiFNcB
 iaI4zrdjK+F+IVid1LjZByj9NtuAw3QWMkNpBLxZuiC5hbYZFH91p5npfTQwNr81b0R+
 VCmE1wsaZ6xqd10GyRAiWeLJRnkfEwFu8LxlYXquND505g+4IPp7FC923wEuxH1tGFMo
 62Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156866; x=1773761666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hqOf46rfoFLTwZ0apeSCrT+CPIrEU8Zv8jzPU6ueL3U=;
 b=kzYVM5Ove2UEhLeBIkQ+YjPZt4f2nKyhGqZ901qOU1fY0LN+HZ1E4OrxHnioFKylif
 SUHIM2/B1N4TByBC0d2Gwh5qW6hLW5UNIN2NbkqCBhRNvFwYv5klCgZodawqaXzLlpCu
 PBSkauLCB+4k6v+eOZ9VLrI0kslMZfW/pB04glU7JItLFNfCeDEG+Etp2h81EsSCwrwO
 6qzNPlOMaXVeeoGZgxGozmTd7Nemr2TqrF1zgdD3np5497jEMRDqu8NbtSB0rmViayZ3
 Ot9arZF9qusHzoDByUjD+2QdgMnBc/LZDW4oAbKLlL1B2CX9GaiT2TIIhJqpHMRLVSTv
 RNSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIWc6Q44n/f7Ra58w8Y/uKdPQQ6I5OpHx/dW6/EFVKvConx5TjjbKk5LXrYFBP//nPN7RsLNw=@lists.denx.de
X-Gm-Message-State: AOJu0YzGxo9kndcw9Airm1uKZuMgB5vwOXpjryiObRcF+8hFbdivg39Z
 GwWOK+3J08zWZqWTfh4DChnjoJP2lSBbZCNkWaX6b/fobXo1WAw4bvpRIiYeDDCsVoY=
X-Gm-Gg: ATEYQzx2QtY0uKEDXlXEqFUimOVHlv1NRt5QNCPMnb6YbNa0HPxGYnP6hZypFbDuhSu
 yEy+9FeLw+COonZnU1DBDdJhgQ3fbSiA0qwkZecRkWn+rqQf3Z1F/cdrF2A3WKUh8KY84uiaWfM
 Bz9VH/TrNZf3kz6NSQw0/L/OKCMJuw37u7SevBeZT5ld/8MUekm/Wnsru0pXR4vtNk7770h2S9p
 XwgcjSQMiWigtk4cNk+p1LOSMbqZCYx+SQTEzLdRdI+xfFkEHQrX7HztpXu5imRULjOTlSlVkU8
 Of34jVoV1CmIo/fWLavYCmSutwujz/wMRQIR2VqO3v5JxIl0+nltEnyF4JvRhrdQYhJQjtxI6/i
 hvwpwEyAdKT61x/WAhhJlRcDqeNCwnpHoRGIPrpVO9PS82Ir1ceYlHYHE0hoWa71XSIgt7J23VS
 TOgCedp25bQs88cJlPEzvSNCdXQrXP
X-Received: by 2002:a05:6808:6b89:b0:44d:bdeb:f577 with SMTP id
 5614622812f47-466dcb27da0mr8051767b6e.31.1773156866510; 
 Tue, 10 Mar 2026 08:34:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:24 -0500
Subject: [PATCH 11/16] clk: mediatek: mt8195: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-11-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=MRfYl5nEYTBb1hVnre/MSgtK0bQzv8+wr+jT68cDRoY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDnMvNaotaABeu/orIND4jkVlEc45gpbP0Uvo
 CxC31ae/XqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5zBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6eIH/j9hhi7pqISYYcmP12iFsuf9LGp7WbpjVbOWKRs
 Ct+TlXO2KmOE2cMnDfIy2oBGIEFYrgLLWsVUC4zsSodFgX1X1wjhBdy5+DNWRDllXzXMeA9oTfm
 T/Jd8O3RyhehWr6FWmBkMZVoDPf8vayXudUDXFx/Rl+uxssCfLs36xkBtt+fwCspM8574e9/IkA
 jMQgNjEqFPocyYjkSYppjdDG8XFpcCzBSXp1ZlWsGDJ4DlHKQ4/O3dJ/fzaakF1CwIaJYva0pzD
 3IjCjlZNY05zXTm2jM3fA5eiG8RFsbs46p2lA0bRNE4iDhvA5uhnt2pbn5CiLcBCOWNIhHP6l5W
 Y40I=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK26M.

This avoids declaring the same parent clock two different ways and will
eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 28b2e2f12ac..37cceb5f32b 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -96,7 +96,6 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -105,7 +104,7 @@ static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree = {
 };
 
 #define FIXED_CLK0(_id, _rate)	\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_IN_DGI, 165000000),
@@ -1409,7 +1408,6 @@ static const int mt8195_id_top_offs_map[] = {
 };
 
 static const struct mtk_clk_tree mt8195_topckgen_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = mt8195_id_top_offs_map,
@@ -1597,7 +1595,6 @@ static const struct mtk_gate infra_ao_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8195_infracfg_ao_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };

-- 
2.43.0

