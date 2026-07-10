Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18567C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06CA84AFF;
	Fri, 10 Jul 2026 20:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="JPdRJ93r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238B084AFF; Fri, 10 Jul 2026 20:59:21 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0336B849BA
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a168dc590cso935757eaf.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709958; x=1784314758; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ND74WladeiJPt9pI8kKAw2Qr3bIexW8yMa9Gloqd8FQ=;
 b=JPdRJ93rWB5oH4ENdpT7q8pqF9S7quUh2zLJM0R2UO9ft6Cmbp9XYIGgFR7eI4ej0m
 3r4nGqXbeX8PNQ478y7lvKs4ouGIeO8MmlRwdCuUR28TbaJ9yy/A6SsnGdm/Oog/TfCC
 0RuEco8+4/zqI8H5tKB9PM7oZOp3FORzKWn6YPP+AUiRzYUXU3ai65/Kk2BcaZaUbaC7
 qFEcuNTPfdON+kIulxUnE8d0602uRN9kLuLvcwowu0HXWg0GKr7/HZhvldrygFA+xzOR
 WmPPfS1qiQRH1XQ1SoN3U2/F0KQ5Bnn0KtP8ryJBUr6wxerbLZagOqhxqwN0cshRAX3p
 DYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709958; x=1784314758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ND74WladeiJPt9pI8kKAw2Qr3bIexW8yMa9Gloqd8FQ=;
 b=szTzS5jz70Yy4LieG0kA6kF8neWbRna3XvGN8O/NGqNYIoB8OKzWYqCi39yRLkmwdh
 IJlFXNoZWW55zIJLPkOH0iqgJa151LBstol6AtxsF0Uvho3BiOCXvj3nSXLGFQG4pg47
 /bjN16P3NVqFLJHrHk/mOUPEffAfF7SsO+DdMETq2AvLY1Sk+o5Z50hDCKzdodLx9Oje
 4UWUJQXv4qYGtR9HfwpR3lHX83dhKEANAVRYHFTO65G2814zsB8s/RXtOhRFo0CwQnka
 Pd5LoEY5HH6iwLTFSmxGYduAAB/4186/pAFdM9Ud9dWuKOusNhT9Vc+5sHD3kOq5vz7g
 ysSQ==
X-Gm-Message-State: AOJu0Yz45ZgNZVmT67tOL7/1uIrqZ8cWK6Cu46mFhFpp5/WkbQ0HHLzN
 aZrxbvDYa9lRV1tHCA+fs5oZC77tXpzD66VceIqiKAiufh+Pu/M0Ko1o6CTGUR9X7Hq5GaGxD+m
 X6sv+
X-Gm-Gg: AfdE7clFEpge7cdZzk65ZBwGAwWdGqNYROSgxaiOR53zpBcNHVNHF45eOigwmk9PDpe
 7ckpUgd0/sV8df0NJiNV5AUXE1lfZWTML+r2UdQFu0sRV8OoPxthzDugpsSagpo4HA2oWdEMtCr
 GDeX5WJe/8MmZqWSV5d8klKOjxCGnRZJ89/zptFhLRk+kxmWDQk9jfIT1xU8vQJJ9iPre/0s3QB
 wZGiZgW6mESwvOhr+w6FqZjwtCChJeX4A6HAZTSMjr2AFW/+O7ba6ViXCbXt0XV3yaCbfPzJu+k
 md5MlNeghR+YxTHlnrHi9ZMa/oGi1+k64+BKBEeIDVNIoCLBxmDhhewn0xCgRQXleTwPjGMTsDo
 tHCe+DOmyuTiBX0qRJLKYJMM4w5EJypOI00QuEZmScqtRbwM0H5DCIoM7Idw9cK+/MmVJs2lRiw
 oZJOUdM6M852lhCb3m
X-Received: by 2002:a4a:e845:0:b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6a39a56f825mr367626eaf.6.1783709957738; 
 Fri, 10 Jul 2026 11:59:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:20 -0500
Subject: [PATCH v2 04/24] clk: mediaTek: mt7623: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-4-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EFNtuOnggw4vSwFAErERaQ0mg7mEuhesHvVDMktK/vY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUBzid8U7TRyVnHS2TugV9gJaM/BQHrYm88l2
 fCVayLRqeeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAcxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVCEH/08ulhKZSh6CAYAp08HOc+WK/gVnmvbK0j0NuCd
 4OHr+FmLGPMUUzv/ztI0DOSeE1f7OxKAgEEJsYb0jbT6a8znsimHbM4hjUskO1vm0llCZi1qzAp
 KQblpg497O0gHPDwym5SYsThgHQwRasVyJPvzwkJ3QUZB7DvynMyh3SGo1Y+gaWhQ3Blhz2inio
 MFIP/psVEmamFsXUSKI1lkfkWPCszzdgEW6+CnpeW42WjbQO1QgPxmzjYs6Ycr4gQF/SIcy0zgR
 T3u7rlGRkMbW6kwlMX2sNFHwe/M+F1QweJiAX1XKLeJktWDiI3vKbz1uU2+SYXBHlvOAavChg2o
 2GHA=
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
 drivers/clk/mediatek/clk-mt7623.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 0a302b405e2..348b8c1e85f 100644
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
@@ -1163,6 +1165,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7623-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7623_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1173,6 +1176,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7623-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7623_topckgen_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

