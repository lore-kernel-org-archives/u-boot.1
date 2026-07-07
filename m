Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E6AC44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF92849F0;
	Tue,  7 Jul 2026 17:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ltoUqZ3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBDF384A60; Tue,  7 Jul 2026 17:10:38 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9519C8494B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso2301996fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437035; x=1784041835; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RzD3a4TI+NT72evaGmE9kwFRWNhlDpYOHOWm1ek2luA=;
 b=ltoUqZ3xMdsXa3VVZqYWMBqTx4UZCz8ubmg/LNlIebOtC/MRf7QVDVggpFpotGS9El
 Od0seAXHdndhVLI+cG6eBuv0Kix6fUFr4r+u6qAmmqd1VHUxhIM+driNI8EV6RANPKyt
 D7QcoNuBfbUzxqYwdBFon5ppMqJWxqOvop5h8DU/pK7xF15S1ats6OhVgHyyqdUjROmM
 qgbGZvkkwhPFeGVxhLjcwwOkl0rcRH4uiumoUKTzDcx4WaNRGhq+CO+JR9QcdrBzDIuX
 OHQlo2eo69j3CidzPuB/CTQHwwdtcoSVgqVx0GRVY8EpAS/pa85WoFyjeSUufwfOQWJP
 50Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437035; x=1784041835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RzD3a4TI+NT72evaGmE9kwFRWNhlDpYOHOWm1ek2luA=;
 b=OzI57yCek1fZ9RuAgXwbfftJgmjdvHGkHjo7wUvQta23kkDYcfj/6jw26caafpvqiN
 CvwuYN2NA/JmfCC4UK2zqIMG3aPy2b/LtYkBw+m0KFYFTzZb5WCVbQvTfqmMsgNBI7qd
 NYl+BbrdrVeqKBTSPKZHDy+joGPMGu4LD/x4uMpcTZrbe44kAsazfqNiJLhO4xczb3bm
 VkzJk/REcBN8RquqdKQKXPxVNqDM/DXtrNfNn4EdVtBEIhPyA4CdLIU4mDUOWjK64Nxw
 yO9CclpvCn6cA4wNZ2lbZSikBGS4O9wJSPBAkuVyYvo7LVg7w4eN6QWP2ROB7nUH/zPj
 yEzw==
X-Gm-Message-State: AOJu0Yz4Z8oqVyDq8DMHf9K4D6mIcbd902cFNLlx9N1jTryjJ5Ni+V4w
 r2prgqRpvQO947McdGD1iSJl8p4c8sfPYF09VhH+5f9gra0B/aF3Bfy/v085GFG270E=
X-Gm-Gg: AfdE7cmUFxgK6kd6oBJGZkIGtSLBOahQdYP1oMRIYYpuY1vfXrLZp0T1WvUX5UGOs6J
 4kBXref2BisH+iD3JuASiOD5Dw2IrJbjsyevb2CQT/pnfRmtOjXGlLRVK4gVHEXvbRpP2aKYysu
 FyC8d2a3BuUcOvMpZ5dSgPRU3seAq3hfs309H15vECZbOf9yyjFe+ahciamXxbZ6R5BDtPjJLHv
 uUBneZDb/DnIwKHm31JFIEwH7moGQH56F/SOyRTPBmPiJ5FlSN3raA5j4nRHq5LFaCn1BG44QSN
 Ukrk9d+fetURcQK3WYNxa5MvFdW5xAzdPuKGHVzfeifLVAJB6G67CXCZvcjTxbJV+7KRkF1e1en
 4PaMXZodD1OBgJ+H3wmr4YFZyhq0pJdo3Qq3UrlZxtbJobVdnp9a62bpltFJFiVknkqlas/QvPK
 XslgW7YbBZ3mADhl4kVguA9KFQh+Cu
X-Received: by 2002:a05:6870:e124:b0:448:d78b:17d0 with SMTP id
 586e51a60fabf-45106164eb8mr3810642fac.13.1783437035304; 
 Tue, 07 Jul 2026 08:10:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:29 -0500
Subject: [PATCH 09/24] clk: mediaTek: mt7988: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-9-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Tdyh+fpkLcjV7J/m+kuzjQljWAxzO3mTmgy995F4o0w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZsVmgGEf2MuYU92EWIViK8Ba4WXsbj7JJIs
 5gwKqA4tVmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WbBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A09sH/3gKmH9gTLROaiaf478YNB1nF9+K+RxX1CAbOU0
 10D1Bf8bQoh6GHeVOjelLOxZf3s+HuTN+wAfJ2R18KvnRsrnYsaMNUZsdXWryShblNhlsTcFg8l
 yUrVCVtMgUvOf+AERyx6iRRBmvw2TBELUwbQMiGUcD06Y8ELTlEahtFP88GavxXSu+tRUjJPXt7
 VbbsDzs/JCwOmg5+ygdUhBQiLzNHeWckLv+6YK40AN+ydAOspq32WxMuwehR+KJV9DtNltJi865
 9e6onB7pnm1C3Em7s6iCO6Ba0XyuLnpb+OtY9oh0Kz3j6s6vr47bDoqssTzblXQR9fF8zp2FlJD
 FzvU=
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

Add clock tree type flags to the mt7988 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 4e19f285da0..c8e635e457d 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -808,6 +808,7 @@ static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
@@ -822,6 +823,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
@@ -833,6 +835,12 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
+	.type = MTK_CLK_TREE_INFRASYS,
+};
+
+static const struct mtk_clk_tree mt7988_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
@@ -924,8 +932,7 @@ static const struct mtk_gate ethdma_mtk_gate[] = {
 
 static int mt7988_ethdma_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
-					ethdma_mtk_gate,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree, ethdma_mtk_gate,
 					ARRAY_SIZE(ethdma_mtk_gate), 0);
 }
 
@@ -983,7 +990,7 @@ static const struct mtk_gate sgmiisys_0_mtk_gate[] = {
 
 static int mt7988_sgmiisys_0_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
 					sgmiisys_0_mtk_gate,
 					ARRAY_SIZE(sgmiisys_0_mtk_gate), 0);
 }
@@ -1028,7 +1035,7 @@ static const struct mtk_gate sgmiisys_1_mtk_gate[] = {
 
 static int mt7988_sgmiisys_1_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
 					sgmiisys_1_mtk_gate,
 					ARRAY_SIZE(sgmiisys_1_mtk_gate), 0);
 }
@@ -1075,7 +1082,7 @@ static const struct mtk_gate ethwarp_mtk_gate[] = {
 
 static int mt7988_ethwarp_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
 					ethwarp_mtk_gate,
 					ARRAY_SIZE(ethwarp_mtk_gate), 0);
 }

-- 
2.43.0

