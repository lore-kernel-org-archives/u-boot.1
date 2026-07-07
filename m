Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDFFC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E1E84A3A;
	Tue,  7 Jul 2026 17:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PYoLeyA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F348F84A30; Tue,  7 Jul 2026 17:10:34 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3F084942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69e9b037d82so3501085eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437031; x=1784041831; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B36e1VXMH66NyU3ASpgIUALLdUjjDdaWdEh1bAlxV08=;
 b=PYoLeyA2uKg364GKK4PbXkX+x8DzAWr3/7r+3RsygyGJUdVmlY6lbSbhK19d6tH9tn
 w5p/8iXaCVXuudVFc+VG4MMnFh0gOpsgPd0poAF8qUgQUTVsuf3IuPXLV8iFAWOOgEw0
 4TYR7oAz69p/H5xqAZb25loBfbYMtyI5PRv0k9BDWItm+eLAxbV1LjQV5Mm/FIaofZYj
 rrnS/o1rHClwUDzhp0FasBEBYv8NfSSqW4B+LC435eHLkUW2acub0sGx3IoI67M6fwbU
 GMSoo54i6LEzjinGxA0JCj+O10strA/HfWIK7da0c4qbGfu+UeKR+cjAZa2Xmzkyg3ep
 5wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437031; x=1784041831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B36e1VXMH66NyU3ASpgIUALLdUjjDdaWdEh1bAlxV08=;
 b=C+9+vyqEMbGhMhqlj63hpK2VittgqXYJySChUDP5QUiqPOYZq4BGODOuZ0HGK/TAKH
 EExh2ZlrX9E4iTT4nIqToUdPC1ne9FXCJQ7iyyiPzY7vvgTxsD4qzQ7dqWDt4eHFblM2
 MlMYA0yGaxL/Z43k9ZXgYD+XbSOr5kgAuFatZfhcwfj+7793Ml2xX3aE87eyZclWQAlk
 iRCyPJuzp38HRx4TtmVeiUdp22Iv+hF+LTIxcdwYTb2ggTpZGfwVXRCN0FynVFpkvcKe
 VSHiyy9NX2E3k5S/p4dSmJ7p/NVfp7a98GgHTwX5hUwP8Vv41Ty1pYYKI/KRHNMbxP/m
 7m0A==
X-Gm-Message-State: AOJu0YyknKeickFm5CIObW3EZfKiN8lGQ9nWJWvJJiMEz1M3ze1+TUUw
 rSz5KSd6CTq8kLurC67VcsAqzP/Nq6pwws9fhAO6f5bSRh11rFRYcnDcsjtkJadC/nU=
X-Gm-Gg: AfdE7cn6LB2Nb6idglkUmGhjotT9vGJx5ay4R+/6h54RDeWREE0ti8XssyGoa1a9Vda
 /iDcjlY0hFpBQL+rY6bqBstj1Ii+En8LSTemucXQ0phwzlCUy83F0bA2rpXv9bvvBkptKqikayx
 +fheRmwhFR+iM39+bHqQ2vOVMwqH3UuvB47mQV+jl3xH22xFALaaUx19uHh2+ObbCc/WTJfd6X3
 30pMmCS/WETTfq+H1cpfEZY/FpG5Y7suOBL+VjehssBAJ4LN5FKrkUdyOvoHkjzRZ/1kI9RNFZO
 Po+Y0hPUi4o9d8GpIBQnuCl806N+eXGXCTNcO+39kDFuWDiBSG86kCa79DZPZ/BZV0SKilVrTVt
 9Gu02AQyX0dV2fdD9ataFOO1P9tPKFttkmyisj94h5pp/BEIM2JtuZiL9hTOpgdaDmnSP76nZko
 NZXMTqltXiYGT8DKUhrg==
X-Received: by 2002:a05:6820:4b8b:b0:6a1:160a:25de with SMTP id
 006d021491bc7-6a35526d9e8mr3525905eaf.16.1783437031300; 
 Tue, 07 Jul 2026 08:10:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:26 -0500
Subject: [PATCH 06/24] clk: mediaTek: mt7981: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-6-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UIFcw/zBSA2faznuR7Yr6zlyvhP7d6v/AAXyUQwAciM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZY2qLhswfTIWNp21c4Z42MMunecdj8zT+IE
 0QYCfyKakyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WWBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A46UH/i0wctdLHdrCLEukVM3tKFXT8VjW6Ap3iHpmd6X
 7aBGdw2fmDw5qhMAhudRcrfXQah4KKaEmHRAgzdMZ51pGbQHBf3y2lVEztcDv1D4nbX12UDjK+C
 RkZ63GR/FwcELUeOzyJHLcs5Fg97knj31I0r+3VqY26ItTSgRxHN+4NRHQNHNLG4lQokrYnhQwX
 CiY4UD8/At3lGt+5dDIhPMM2t6DfWQWOzbhEBu3IITjLfAS0mbdSSkkeem/nG5hd1JzZGDGfsgp
 Arywfv6DgUHxO/IgG6PmXX3IC7+3CMYYdG+rSbBLJj9EE10Nb8XQBDu+S9s5n/LnV/wEM00PsQT
 ThD4=
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

Add clock tree type flags to the mt7981 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 8c2944b7fb3..5d6af62664e 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -622,6 +622,7 @@ static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
@@ -636,6 +637,7 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
@@ -651,6 +653,12 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.num_muxes = ARRAY_SIZE(infra_muxes),
 	.num_gates = ARRAY_SIZE(infracfg_gates),
 	.flags = CLK_PARENT_INFRASYS,
+	.type = MTK_CLK_TREE_INFRASYS,
+};
+
+static const struct mtk_clk_tree mt7981_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
@@ -742,7 +750,7 @@ static const struct mtk_gate sgmii0_cgs[] = {
 
 static int mt7981_sgmii0sys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
 					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs), 0);
 }
 
@@ -769,7 +777,7 @@ static const struct mtk_gate sgmii1_cgs[] = {
 
 static int mt7981_sgmii1sys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
 					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs), 0);
 }
 
@@ -810,7 +818,7 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7981_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt7981_clk_tree,
 					eth_cgs, ARRAY_SIZE(eth_cgs), 0);
 }
 

-- 
2.43.0

