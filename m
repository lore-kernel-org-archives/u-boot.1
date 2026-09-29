Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AEBCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A192C607F0;
	Tue, 29 Sep 2026 12:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zy4P7-KHiBnK; Tue, 29 Sep 2026 12:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 75E53607FB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685414;
	b=lGLabcPR8tlKF0u3knWuH3ViX0t8R4kK0twc0YrdK44EpVliZajevZDPcwEaU3ZGLA0d
	 sSzPG3utpIWg/MxTaNn/OQ6OQeMfHgvVAyuoG2ABEJAm5zJJODIFv690n04MwaP5ZVwlt
	 YijiW2r1ZiaUbW8lVaf8UIy1oZZQHi4ha9aRku82YVrOBatxqsz08o1ysJ8UBS2i5MKc3
	 pVGq+7nZKQ+cxw2TCSKUAoooK+Z8iqS0Y9+7LmLXBcphvUwJv6nlL97tXLWYgUwN9lXSc
	 c/og6JnMRD8XMt+RjBUdRzHHl3LNIYPZKbJzPLLujqrrkl658yaOGLk+1ZX72WltGAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EXVL86MC8ylRDKNhKDDnGoWvopNJTjt2O2tpE9RdXX4=;
	b=f7QgiRe8dkjlnV7irbEigXSBnmh+eikUBxVrjVdWJ6cWfH2DkrIqBBTZBrNUQiJCGUsv
	 dtOt25smeZP68h7QxlJADKrABKVZ1oifFmvvMwkYmf5pjzZhLJcDhbogxSwY2fnhFosRI
	 GJFbR/ghAy9qRzHgCEXaq9vpCRTn1vDorXAdpnP0x5MVpidOmCkF/KIZ9i++0EzSxUYU8
	 fGk/n+a6lVbr4lo7zK3d39gr8x51SXyjp0XzCkJJwTsRunZmu+kOyIGxOSwNGzY37DsBl
	 c8GhHrpdOMb6U23OsU68RAXCPFKCukhjPdWKW/fIwu6c+zcKfQBFv/BdJkYMUn1+YAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685414;
	bh=EXVL86MC8ylRDKNhKDDnGoWvopNJTjt2O2tpE9RdXX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEQU74BFcS7sC0GXbXhkAdRqnyfTxkrbXvA8X3g161cP3tY1qkjL7EmvyFqHRUhbf
	 Z08/wsfsmgJbIcv7kIFmTHg+qmgWQgOua+ZiqC2NNyw5fndlqsR3oxsOFoqkXpucJy
	 neMYvZIipj3iB8QKNgMDHIAE/bESf+662FtKUlL+bI4lQVFA5kW42kmOaEp5iZmKPv
	 RwILVnFYIawpvePj8l6m+Ftr8uth88mMxstFZjwNer0dyPTJoX8S1asV9jOQYIRg85
	 a2RECjkkcU+ts+ZGXQhrEHpLYqeIHXASTi8ZuUvOEWIjd4EHdMwpfPvmUZgl9SIRz1
	 Se3QOVpLPWHRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75E53607FB;
	Tue, 29 Sep 2026 12:36:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1479A335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D362880E87
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfYrgVOLpajq for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7FB1F80E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685398;
 b=elBz0cN6Tp38CjQZx+1iy6RjAOM8sFFZKKbgdod+H3CSxfhNaCcYTraTX033isk8JcuI
 Rlhme3Mms1j+JIyMBBksU0vSCZfev0vz84MRJLjzcvofYh5pcFyASc8HGPzlaULn4YyZ8
 lorjInwR6ui0GVH+Xa/qnpS/g0kEpvrK2UDkQSGSgzB6xG06we8w3h5zqiaKYW6TgX3SR
 1mrBN0V7GXhIe8H8jLM31AD6GDgVUDHCL3AE7jcuL76B4RiJcZ6HYtB6Wb2KxnEBJ69nt
 42BfWx574etVAFNb9cbS5js1uxRozI6P4XzK8czVQ8Dp5yzXq92g9ry14LGYxU3Trdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=EXVL86MC8ylRDKNhKDDnGoWvopNJTjt2O2tpE9RdXX4=;
 b=OQkl7WLDVpV3Zdl4q5IwCYAuUXOxrc5m+uVouVuANMaNaId1PaSYkIUjsaGSrt3R0Q9w
 IpEAjk4Vpu5VyEq8GM1CZEv8iZlHZfCjCal7qUU/lCcwxEMgCD77pjKJ7N8wyPmSFg7oN
 awhasBOfUfhwfn4Zhk9OIH8BWF2Ptux+vWeBirCgM+4Klt5lRyzlvdNld67WYEQ8rxUvr
 zmzOrZp6PWmNhHH/PVPcdLFG9JJhCxtHTImnISToTbLhtovicFjyopprRwz87lQ5GONxf
 wx5Y2xAP21DFA1oTSV0yXC8NYTIfcNP2uYBntJSzoQfF57T0zfRKWvOe/w3f/jwFsEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=agB1BRM8; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=agB1BRM8
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FB1F80E3B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so24354825e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685396; x=1791290196;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EXVL86MC8ylRDKNhKDDnGoWvopNJTjt2O2tpE9RdXX4=;
 b=agB1BRM8bRAX8KWaSgmkereh/m+S0GP7TC3HbVinI7oIk6BZYHT9p5mJDhFUDeHHnX
 KFml7T7pWeVfaFkLWoXdXiYOO0wukJmKO5f66ePzzEZN7vNjEvSVTF73glX6UVkINW3h
 CoJQCeKyEPgdfxhgDpKkBJTytqPBT/A3Ms1uXQGMBpQG0RQBO5aPeY52JG2X7u8WnyDn
 5sr3lPbFPx+aHYr5ZHM+GHHLEBP3ZuH7MeVYqOxdT2fhP+Mb5aNhV/gnfo9KE6qHUIsp
 EKuHdoEIW/KHy9/Sciw8yTuQ0pzfmg/Sr508SDXVg1DVu8fXDoDj4zs0x3MM4+jGERAN
 XgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685396; x=1791290196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXVL86MC8ylRDKNhKDDnGoWvopNJTjt2O2tpE9RdXX4=;
 b=y6ed15LBbV51ooyZnBS6T2AlkxNK9O9j7KWKDAqQnxhcx/chAWxrUdnQmbir9TR7XY
 xKQlW2qST0mvYimjxxvrH3SrjlPv8tdDZOjG+S8ceNfBXpaU7+IKoA0QPP/+rO2ajh4S
 nK0vz5SE+91km3pljg4K0eu9AF2coEli4jYLrsZUhmJrqsm3DEjggkErdL08a7yE70i8
 byKZobfv9nb4qAOQQdA+28diT5tbz5S1pTzQ8g3orCF1KkRyCJ6+2gWmvlO5Vg2Thcjn
 WVjI+PpluhCg8Nbmw+N+NVI2DIIP9ZLy8ESyHRXyZDM3mw4XmtoyhF2c27PK7U2/UvIi
 XRFw==
X-Forwarded-Encrypted: i=1;
 AKwUvByzcF1BruYhruhvOyZWDdcuz3PDbHQnsN+G3TXKOPh1iGj4FjrMW3u+UD7PuZZZJ7frfqKsoos=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/PUwUxWV/W1LUafeLY8uIOguM9QMuOsJmkVJcgBaQnvwABGwM
 ucHgicPhkBviVozcgRoVfaEZpfyMLLwUl1MDVSH9xIjk7eOOCHnCsOmykjJH+Zt1piI=
X-Gm-Gg: AYBFou0WSSPmQPvnysEThfe4VDiw8+VFidUGQQu6CLTo7jhG1GR7FxhKM+qhIQmYoZr
 z5iNbdVl77JE+9iJ/NcS9M4hwGqU9Xs7upzntJ2mf7m5HU5fdCRdLicg4COFzvgHK0RgqbbhBPa
 K9gzDs/MCP8MOrypxbmYjZ7H4RyaYITZ9wuwAsHg6cl6AtdJ36moxzU3lsivZeTn1qYjWqjv+bg
 SCrAmHP5WLGiowi0+I3GoUbNNmqjtQ4QWw9dgGzmXjeLeGNUHFHbaiNXu6po8aP8/lLKCGUzMvH
 ydV0xEDLqfP9m26kP9m/vsJUz1w2NJWppD3U4RrpEPoTCHgcChqUip4kgqSo9aa0qzatKsRaXCA
 KdDtotXc6ZYEyVVM40N8OUEBgfIjglmFT8ljjlDBKQmxcUTfXFYmHAoUUYkgGK0yAwsgded87iX
 A7TFpPMiIWuN7Hu+LYHzA6/C114mNdKL/hFziDrCCl0Xq0l0CkdfU3/KOMeBFpq01fcNVeDpyZY
 4HZmaI+P0TvCS7ISdIajJ6K5rXlKTe8B9mzYOX1TV7VQy5kR3iI/99kmzlTcE1XRwn7SIHVPcYd
 hkeyDkYvAjnKpKc0GjZA0f7lLHNNQ6zWix6xWu8ARCQ1czaqA5pbnh8=
X-Received: by 2002:a05:600c:3b01:b0:4a0:25c:8af2 with SMTP id
 5b1f17b1804b1-4a0025c8d29mr106060605e9.17.1790685396248; 
 Tue, 29 Sep 2026 05:36:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:48 +0200
Subject: [PATCH v2 10/11] clk: mediatek: mt8516: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-10-b296bf3a4a93@baylibre.com>
References: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
In-Reply-To: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The topckgen and topckgen-cg U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8516-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

While at it, fix the indentation of the .priv_auto assignments.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index f4d4dc3cc56..0c395b161f7 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -777,15 +777,11 @@ static const struct udevice_id mt8516_apmixed_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8516_topckgen_compat[] = {
+static const struct udevice_id mt8516_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-topckgen",
 		.data = (ulong)&mt8516_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8516_topckgen_cg_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-topckgen-cg",
 		.data = (ulong)&mt8516_clk_tree,
@@ -798,25 +794,15 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
 	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8516_clk_topckgen) = {
-	.name = "mt8516-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8516_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8516_clk_topckgen_cg) = {
-	.name = "mt8516-topckgen-cg",
+U_BOOT_DRIVER(mt8516_clk) = {
+	.name = "mt8516-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8516_topckgen_cg_compat,
+	.of_match = mt8516_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

