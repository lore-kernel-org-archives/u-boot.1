Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DCBC44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9B684A51;
	Tue,  7 Jul 2026 17:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="kGHyXps0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9766184942; Tue,  7 Jul 2026 17:10:37 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FE884942
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a192afad7dso2280054eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437034; x=1784041834; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mrQ2X8fLZ/v4PIIDqxyF8iFo3got1iU6LUyLiit6nLQ=;
 b=kGHyXps0JD1mmeRFog9Ca5jNjtRZ5vRG7zbUS3VAmbW5zbtbikceksXyUplvyF5ofK
 Oxg2YHvbvSuAXi8UnL5QNOR0ySmWMuyDM8pAhTQxZiaJe5RUsCtgOcz8GEoY8YhVUcA4
 Tf9382x1M3kl2RTBBoOXNjP6+lVHqTGen1EhjVfTrL7Ka04ZCza3YuYu2VkRgrnxVNMU
 CanoyGKSduaBydQqvaDwIm7M0uUrnhyiY64MCqHaN1f2eo9iK6KnS/FdJ7QB/sTYmH48
 DRzadATzdUSQ0pqfc6NKFYvApfd77Mh69iyumZHYGDRALgTtdkR3l1nLBwLycWknmzH+
 KX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437034; x=1784041834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mrQ2X8fLZ/v4PIIDqxyF8iFo3got1iU6LUyLiit6nLQ=;
 b=c/JaLTO/z17E3wqvLu60Q+BIazXhVK/xcvDG5BcTDziqE+aUVYpH1NfGQGt1CQknwE
 w7Pe82y/D60k/6pcVn1qK1+ra7f/TUDoX516nQplIy1KV19OqSb8w4/L+nK9DjvpB2cF
 pSCDrWZPrwDQaSX8rlAsL9uT8/0/BR0kXt4LpUBuOaODps1SkXFkLcsQG/U/fQRZfV04
 MPdrk9LejuxiIX6/kJmkWgN8Lg2bD9Mud9OVstIFXGRIBku7bkZ7xyl8Mg10XTrxRe19
 NHhI5kPWaI6eXLuG9JsLDQUySFpp5PQAnK+/sUNz7zidoPVQTY8HM2Viw6BaOeFoAjDl
 2jgg==
X-Gm-Message-State: AOJu0YwM5tm4bR0pamHffqn2v8GL1ckhkzdpVGSRMRa20i02qLk7OFme
 7VrdG7Fhm7MHaXmimUgZk8871NZSOFHEkMpIehiU4NudvWLmCEklD+xoJJczaG6JsQA=
X-Gm-Gg: AfdE7clFvVPthkaI90wUL/NIUl4jNJbtgTTr1vhEpd0umqql6Hv9hO9YYGEyFFZsCZb
 lUDTuD/cGm+cM9MO23250JXdPwg7avKY6ZclqKjUmuGcfEarXUhDaEwXAr3eQ1WYuwfiPRj+Lnk
 5Da5LCSk1vzHPyiHGmY/o0C630ZoHu+h1lmklu5FFrwpwRuC4SzYM41ak6sJuiullOJZ7opmMW2
 qJyvCnqEHCoCkKm7vyebO6GcI8rVrP8FveCqyZs6NZNYm46RacppIYmaqALc0co5GcB33Pa17gz
 5rQktRXwVCAZPcqn+8U7JmJHL9DfZpJJqGLtAGY3+qa9IepotuSvSTgTPBQstORPy32p7sXD10W
 VC6P+Sde1drKeIIiNWfYGnkwfH7SVSEl8sFQ+RestZWt4xc51SHMo9WBbEu/PIBbt/PjmSPkTMS
 z0SmYQb4mCvdw2jxMd3A==
X-Received: by 2002:a05:6820:1806:b0:6a1:5934:459b with SMTP id
 006d021491bc7-6a35538e0f8mr3413714eaf.9.1783437034212; 
 Tue, 07 Jul 2026 08:10:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:28 -0500
Subject: [PATCH 08/24] clk: mediaTek: mt7987: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-8-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Lh41+0sFdqd+i80seS675R5eb9u+ytC7r5JUpZqvYUc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZlcoz1so1z0tMVsASS+YSaQxeF3Czk9tKUP
 OJoZsnOoPOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WZRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgKAIAIRiptW/XUF2kKIVbFurfAn+ntx1Ek22yzp1olg
 1DyUxX1w7GsCsClqPCLUUj/m2gKj26R4B+enVDmgB0UB0oUQJMxMHLwXBCAVBam4KTVsfi+KUCO
 C06f527r79WdIDg8Saz8OAo4ha/Dd4U5V0V3o7U+1MWooDG6GUptcx64E8niFL34xBIY+SC9IbH
 68XN6+bXKSrm7NJdKwVO1tVdsAGqr6QIxWTg1YgH8GxJjzFHQQBpZGRa5XcQGf22m1gdqJAd5cP
 5TsolrKYMQhkqVdS3VSdIkl9EOZKPr72yLa9f9r3unnRYa1NPVISRZQ780Obe1TdEGkU3pjGspS
 Xe4g=
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

Add clock tree type flags to the mt7987 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 5f102636079..b455f52bafc 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -60,6 +60,7 @@ static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct udevice_id mt7987_fixed_pll_compat[] = {
@@ -457,6 +458,12 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt7987_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7987_topckgen_compat[] = {
@@ -783,6 +790,7 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
+	.type = MTK_CLK_TREE_INFRASYS,
 };
 
 static const struct udevice_id mt7987_infracfg_compat[] = {
@@ -829,7 +837,7 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7987_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7987_topckgen_clk_tree, eth_cgs,
+	return mtk_common_clk_gate_init(dev, &mt7987_clk_tree, eth_cgs,
 					ARRAY_SIZE(eth_cgs), 0);
 }
 

-- 
2.43.0

