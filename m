Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ABCC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7994F84A20;
	Tue,  7 Jul 2026 17:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="lRoHS9pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8422E8497A; Tue,  7 Jul 2026 17:10:32 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A20849D2
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a0ddedcd00so1597238eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437029; x=1784041829; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pysh3E2DevkK9LFvq3ShIMBe6Va75C9EePPZLemAa+w=;
 b=lRoHS9prUihZJnovDz5IkJCiqmJfGeeenCkoYID19Zq8/mfKxfArOGAoR1tqd/JiAe
 7BYGaUwcX1bBvfILN/DVJ6BUI8fOlSKHoScoFGnlKQ3uwPQRV2C6sqdSKt6yPkECPqBW
 xcYH2U4Zdfryb9dfBE9SCWH/w/nvcGmpT4NdkOkeqDn2I5Spvphi36mX9leeAQWLXCtM
 M3znViwla+DfWnK0YcTnk7VCSFQSEf4rGigMU3YATfkoCEwEPB3UB1ogLjznotyjoXp3
 h7oqnmG/HHE1hXID9n09IlwNLR+RXkdlJVSjo6Ht90kIRNRQv8XMMmuEkA9KTjo3uY0j
 tqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437029; x=1784041829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pysh3E2DevkK9LFvq3ShIMBe6Va75C9EePPZLemAa+w=;
 b=C01ugvCwJHt1IUX+0a+kDxCFnyoSjaI1/sUQHnilgMVX4zsYHmHZmHLTCndyjTyg3J
 j28z9iV/G5P7jPiMFaHPWKNOjNVH01O0FxU+kFlvv7sLZgNWkR92bgfBbZIPOizgXo5Y
 34TLDDX66CALhoQetA2ogpRap8e7qo7pCoWGqqx+uGEnSk6+hoUXnC5X/eYMsylM8BVp
 ZGSBQsdvGKm0bMLSIJ7cYas7gnbCj4+38Ko3+4CinLTK6kgQxN5/PAgjXpr3aYSze4MX
 ifuHUVrLwbTp2scVMxdJbk0eOl+K+toOltX5NIzbOjfYJ+zx9mWN79DxoIPN1RqWOBTL
 iVdw==
X-Gm-Message-State: AOJu0Yzl55FRx+lRkcpDWV1uiEUmQoIvV/wz2oORfpGKFfyE0Hb8ol4f
 ILdtB8Ffx62B+9ExBUny73NunA24qD6URC4oyMIA2Gau1fLMF67PSzb3hl+HqKkT4Ps=
X-Gm-Gg: AfdE7clo1ST5QbMd6hgvNreWsuLVXC+dyL2r4qNYVFYeHgyZSnXYSl4XGYy0tkt6aTX
 AXjOxUh5bbuAAXbvy+As+tnHvkwl/JVOUxNRJBNLYxuDgHmy4UguHCq1FdoDN2M4/AjcaXjCNTi
 sle9zVwE/Lod2Rq3blpjPdxzUp8F2qiOTDZpIUeFfv0HTwXB2pAYgEFVDBmO/7m3xJxvo1+Tggu
 TI0Ou0imeotn3Gdo/HCf13y8sUn0Q7iEsfH6O91qjp3mlPaOfUTz5c3O8HfUZcPVNxpvlqVihsl
 GZAW4J3zWAysBmkL4j6HBWX6C+94GtWXdEYKUziK/u/DopyEO69VjB1wj1zOCVq7dHYFfo46317
 QL7IHtwMIkKaG1Ax48MJrnmngLq0VUWH3bYR2iC9z1GRQA4fXr3kKUeOOKrH7MpjmT6sVlpfMd5
 gC7hAEhskRlx8bdNF7IA==
X-Received: by 2002:a05:6820:3103:b0:6a0:f200:253b with SMTP id
 006d021491bc7-6a3554f9d96mr3498450eaf.14.1783437029122; 
 Tue, 07 Jul 2026 08:10:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:24 -0500
Subject: [PATCH 04/24] clk: mediaTek: mt7623: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-4-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Fb/7jJj4LHYejNTKv7l/zR3KzWTTvOfQi4TwALDIx+s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZLdRanuXlWcb+9AdTtdadHvA4q+1bxHcQFO
 XMCsxmDO2OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WSxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfLsH/0usnhESD7/yHXMpz9D3i0O3st18t0BtoBwvS9d
 PoIRr4M8L3aYFtJPvVNyCxqLneG8zxN+3V7hBp9wX/0b/z/J4ErfGOFmOkxpgkI4aoOBcs/gegy
 qCL+P8vWVMEyOu4IvMoKjfBiVLXcNAlInWDDQ4MynQyJrf/EjO/XrIsAws9Jmmx0FZpGPppzkbi
 6cB4EQdclQ3nLnpSn9yinZCedhDvAmzFJ3791AlveCP8qeJS9y6GrYME14UFGDNL2QYVAewdyKo
 fqvKDCIo/GErZg8k7GnOuXWiHUwzOXF8YzOvSi+OPHJAeAvry/gWQi2HAJ/hg4X0cWfw7PUb0nn
 eBYY=
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

Add clock tree type flags to the mt7623 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 0a302b405e2..16894a68e3f 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1009,6 +1009,7 @@ static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 	.id_offs_map_size = ARRAY_SIZE(pll_id_offs_map),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
@@ -1024,6 +1025,7 @@ static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static int mt7623_mcucfg_probe(struct udevice *dev)

-- 
2.43.0

