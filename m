Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7CBC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3288B849B1;
	Tue,  7 Jul 2026 17:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="HFPh11fT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E92084A0E; Tue,  7 Jul 2026 17:10:32 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4151C8497A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-448df16ab34so1609052fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437028; x=1784041828; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bRxgSL/bANz7lSyeIlPLX5cTUszSihlw//SvgeN3qFw=;
 b=HFPh11fTEm0bHurxkZI5crMTfuncExqz1Hy/khpp660JrTKocBH5qznX8HswC37NAA
 C229gg1CfXt6tVM4OPiA+GIyOnBGtifj3/6wPwuIFw1yZiwdWbI1P7KTF3NZceVE1ozO
 HFg3GtvN0Efk6QeAwhFC3N2eZmZNxVHUkX0M7b6c+g94UGTGC2pwwWHKbgBbpus3Vptk
 UFi/Xrf141iuHubtVIKcubHFNU0CKd2uT0/2AkCOaxj5qEbNTf8SDXCMkwH+jBf3Sara
 tffGrGviYXyalYQCOx65b5bDgUFvDwTh76obi/bMl6PrfN/8jnzxJ3fi2kVj4K8+R3s/
 StKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437028; x=1784041828;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bRxgSL/bANz7lSyeIlPLX5cTUszSihlw//SvgeN3qFw=;
 b=S8Q8c8U7IPcdlda5W4BpQF+cINQNj1O9ta2LrwX8SosCurFksdF+zwhxTd5b8bP1fj
 X7SXTIdedgG1fwGHCf/ce2z6cYMBrCQ/vYky2ySGiGTyt//z3YucYP/W+nLfQj6J9cLu
 1ZiiSUWJ/2UimRCURHzrI2+ASGgyb1XYxFUUxKPWC9GX+yU2why6nOwO46qbCMAftKkY
 JybYRqaoxF5BGDQcOjx+p7YPrUA01ZdqniXAHE0EH+w+22ZtxttK1lB1GK8P6auRcjoq
 B9bTDGBt5khRgX2SYQXLLFW2cVpNUoUXq5CLWUwZnI+59LpffpTRYGL1CyloxkP1jSb9
 4rMg==
X-Gm-Message-State: AOJu0Yxx9WLlMVxMMSPmLlu14TL/oiB2mgTkknKy9k4+LdO6wyBbfSlZ
 S29wDpVSqDkLJFqNSjwx8a+EHMn3iVQRKsqr9mtFK799+wG7YTDS0dO3HM3CXkDInw4=
X-Gm-Gg: AfdE7cmTorYWjswT/f/JIbN+RJIbzDhLdO6GLvEaFTl4P2rUZ77OPYczf2GvYjb6gGo
 FCdny+xF6oiqSzPx8Bi/zV1Fz8wbKlm+TsfGNAy+p7KBTm0Nvv3ERF+UNP9oBNnCokFDn7DKbUv
 +ZLGNe1UtbjJH71V3+gcrHrJsD8rYKKSzISW6csVXAMjpNvGXnvCzMA/mpTKuc3gL1JMI5cA54+
 7qzYcfgnQiLsigoEAuY6NcJEIog+cYF1C4CtbCF6y+jNrzb3USySx3g8sy7Se4QCohrvCcw9Jsm
 YkaMjnaW7yH2o5iKc4HkDCWbfeuPkUFNDE/ghy7rZyOPU3lKMRpFgXHYs2NJMvPTKNCQpZZ965P
 F94xFTilxceAsakzmkeHcZofXDbWxlMtmQT4WqJelx82NqLFXRyTENzYEAZ4KE0Z2Ibo5jZTtg+
 vpcVQToj0Z6FwFDO5jzA==
X-Received: by 2002:a05:6870:2dca:b0:448:558c:d8b4 with SMTP id
 586e51a60fabf-4510607eedfmr3749223fac.42.1783437027901; 
 Tue, 07 Jul 2026 08:10:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:23 -0500
Subject: [PATCH 03/24] clk: mediaTek: mt7622: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-3-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QrW+amW7ykQRoxj4FuZFWDgrLriYJ1jfszwF7axFC+Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZETv6c+dLpd03R1qnO4rMw6SrETK8U/iIJb
 oQEeCLu7x6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WRBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwuwH/iFToau4Z/xj5PcNHnb6l9zVYgqpVFs3XHTmx2y
 HeiP3DPDx1Str7MQuON6KelhUzxYgroEnUGxm/swa0T2dn8xTiq0DLGM25LNMfJoVKb9xpFPN/A
 oHnfdP38b1bTruUwnAoiUfKPyvYzuQrNnDITF1O+bgiKBpOkeMos/PcvGpkP3Mqq529VkTrrffN
 yKHb+xTwqBzqSSz/y4wtJDDiQE3+iCTS3czof1MuH3OLPVjM01NCPxPAJlRMQtyl8Df53l5oC4X
 KS8YsUBwDmYrsyX+Z0ljQgCIZcdEO+u5ycygVqx62RmkpSx2GXyDNFVXAwcycwh/yl2fvRn/gtJ
 v9tw=
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

Add clock tree type flags to the mt7622 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 60f4a872a66..fd51173a701 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -613,6 +613,21 @@ static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
 	.gates = apmixed_cgs,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_gates = ARRAY_SIZE(apmixed_cgs),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt7622_topckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.fclks = top_fixed_clks,
+	.fdivs = top_fixed_divs,
+	.muxes = top_muxes,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7622_infra_clk_tree = {
@@ -640,14 +655,6 @@ static const struct mtk_clk_tree mt7622_peri_clk_tree = {
 static const struct mtk_clk_tree mt7622_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.fclks = top_fixed_clks,
-	.fdivs = top_fixed_divs,
-	.muxes = top_muxes,
-	.num_fclks = ARRAY_SIZE(top_fixed_clks),
-	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
-	.num_muxes = ARRAY_SIZE(top_muxes),
 };
 
 static int mt7622_mcucfg_probe(struct udevice *dev)
@@ -687,7 +694,7 @@ static int mt7622_apmixedsys_probe(struct udevice *dev)
 
 static int mt7622_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7622_clk_tree);
+	return mtk_common_clk_init(dev, &mt7622_topckgen_clk_tree);
 }
 
 static int mt7622_infracfg_probe(struct udevice *dev)

-- 
2.43.0

