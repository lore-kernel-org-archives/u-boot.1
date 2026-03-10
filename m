Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9729EB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E1784113;
	Tue, 10 Mar 2026 16:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cHmAPege";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B766840DE; Tue, 10 Mar 2026 16:34:25 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A2084106
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4638e238094so6712333b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156861; x=1773761661;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DpWeGBy3LfEtP6c+YZdjt3meTK/Fds3+giqvhFR0wDQ=;
 b=cHmAPege3m+DHQN1CUC3/B860zeFAj8x2yIHGBmAQJjGBu6pQpAod9iAIYM3AbjTpU
 nBnAY16ALrm72ldsI0FCYuyo8uX0nGMthcqSQ1cQAwHBtvlBONJtwFHVXjpp2IIxfqWb
 AIVoF8jG64rLd1j+qF8SYnUvifeTKARagt8m8T0YPhsL6mjUBjEeYaaMOnl7IYy+fSjx
 Yts0OTbol/WFTaZ0tZj+2Znt4EvMTa2M5v7cHKCPZoLNaEjPHMyxc5paCRs1NHe4+VM8
 wUsqb5tU1AP+rrKXRKujTosSfr5H0G+QYHhrM5PuOSUPXceLqZPVeJXdhTkUrLGQzAbE
 L68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156861; x=1773761661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DpWeGBy3LfEtP6c+YZdjt3meTK/Fds3+giqvhFR0wDQ=;
 b=Llf2CaeT8iiqACzmiJXbDSSsZPybRa0JelWkTPtTn/ROXarIm6t403YRBh9YOb+629
 ChhLCJc0ACXKdkeHGDm3rMbn8OpfR9lSjXUo1Uv7CeYhSOqOJR7u/mG/rngYZOe9Hy/0
 0IyhoxklWNvAr1T4tk2d6TKzygUBnIEyga4I4FOEo2QnUCQ0QKGA1MulKaJCpp1J3OAS
 UfXGJTXJKkj+wuSrbEz3IVtz8cOB6Uqo417lW32YfxqPIReLBKBmr5mvKYOO0fUKuyz8
 NkRVln2a7o8aShUNPPOEBRByOVNtVlbEK9GnMGegqB5nL+oDKwUi3BExn9jy8gc6wOQt
 LpLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMzrcefvUQWaOL7z+kN5aLbjc/hAwujG6IoUe8J/I/i2E4X/PFGbcLMSijnr7qO8p5GcwaxXs=@lists.denx.de
X-Gm-Message-State: AOJu0YwkZMsEycH3oT/RBBfZpnSUMDmOzGW0ouBaAl1NGPU860m+HudT
 Bp15ImC8PWk1TkM+FoO+m+gFrKTLd9S8IjH/lkjuKIsGqAAV6pDBda8dumRDihtasGo=
X-Gm-Gg: ATEYQzzM+hPHpcOFvgPPRRYU1lF4hFdfvZRjVVX0vukLihh+x0YVsI85AmBJn9Xz9ZI
 pyyNAbqGWAeYR6+TGgdXW/MeO8KVfsr0lyLy/6hquYACoW2jLFXcbCnfk+jQrDrZId6qqQ/pG/9
 8ISiU2nb2zmz9Bva9Wm8iubNtvF/320IF8eL3gqG1i1NllhOMwsKRPEjJ8nCN7TUspUm+oFqhx0
 A0+dZeuDjxnnKHVDccFcvu9C4QlPTrrW4zzaGL7rI+wco2fT+HFis5ZfNcJvBnhHmdAXJAoenzQ
 tBPDNNFk3U54KwNgHS6oVUzbQfyztIJE+eLPvfDShUwqJQKiidP/Bmf8D08LxsOJ7CkS1Uee5re
 OSxCvC0Gv3CZOmXPFx8o5HlzBi7Tnc2VSVnaAl3cHAEITfEJTVMv98dnQsADeB6YPy0U3PDdUFP
 QMRsib54LvGPDq0H2anKFjQUMVLDVJ
X-Received: by 2002:a05:6808:1310:b0:467:15dc:b35b with SMTP id
 5614622812f47-46715dd2562mr2870825b6e.3.1773156861327; 
 Tue, 10 Mar 2026 08:34:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:19 -0500
Subject: [PATCH 06/16] clk: mediatek: mt7986: convert CLK_XTAL to
 CLK_PAD_CLK40M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-6-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YcFbSI9nwTt/QRTnUcqppJNztF65LX5TlSZULS5Clu4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmsZi66L9Dj198pQf4HKJ1EixCdCoxwfvD5o
 yCOEIRame2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5rBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZbQH+we1ZrLvsMrDIZTvwaiYHnNbn4FU/ld92WCnmIl
 /SHzmA6dKPYAzNRUTa3jNbbCvgbQ5N+b049AqtHMUvXkLWhCFhugyPgtOGYKyBDqF9/d4ZK7dgd
 5qVRm9eczB9eieEFGf/zBSvpfcfULRO8YFXb+EtmB2gDmA9Qe1Sdo+Uu3XcyCyRAdVcZtzIEtUq
 OqOYZn03Ixb0QaIU1VLkFmnO9z+XAm2Z3beD7Mrm4d33TyjsJzrhSgiWskmIZqsoqPFLtN3hDcC
 IAn6fjkoKoUiOSjA8SJ6PmOdGZRemMRK7pMazEMUO7Pegreq5XmaPeLIKvQoV8zz4nnh+ORTVcv
 4XEQ=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK40M.

This will eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index ed65aa81a21..9c6514120a6 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -18,8 +18,16 @@
 #define MT7986_CLK_PDN 0x250
 #define MT7986_CLK_PDN_EN_WRITE BIT(31)
 
+enum {
+	CLK_PAD_CLK40M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK40M] = 40 * MHZ,
+};
+
 #define FIXED_CLK0(_id, _rate)					\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK40M, CLK_PARENT_EXT, _rate)
 
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -516,14 +524,17 @@ static const struct mtk_gate infracfg_gates[] = {
 };
 
 static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
-	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_PARENT_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_XTAL_D2,
 	.muxes_offs = CLK_TOP_NFI1X_SEL,
 	.fclks = top_fixed_clks,
@@ -536,6 +547,8 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_INFRA_SYSAXI_D2,
 	.muxes_offs = CLK_INFRA_UART0_SEL,
 	.gates_offs = CLK_INFRA_GPT_STA,

-- 
2.43.0

