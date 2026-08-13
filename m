Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0F8C5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 14:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DFE0409B4;
	Thu, 13 Aug 2026 14:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qjjLX7d1lRX2; Thu, 13 Aug 2026 14:40:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62D2340703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786632031;
	bh=TS+k7iASXD6/BZIwGCRmhF9Z5msWrQF7PN2eObt5bEE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HgMBv7Q+lq40nK/6RCqQ10OFfJVPi/XXZEmLOG60VQqOMjsRB4EbxDOs99C+81mHi
	 8oHFXK8ZEMxYifvbAemb7Qdh/SQN+NtYAD7K1fjNiiidK/jLV+tdrrnTP6fynqJKHw
	 WJmYwUcmDC7zv2K49QJu4Ah6y003JFdgYbKvcWAu7vsH6gLZNafu368KLxmNEfcNsy
	 i7pp41uPJQSe015MuS00uqnBULUdC+5PRYlf92RnTt2uhfPtFmRfBiuzU8M51dtCX+
	 aFBqSHjAOI8edyka9kQFDTQHpN1/wairmyng9hl7pBqQJczb/OqBYlGwcfWzBTwxnB
	 SU7Ym5IDTNP6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62D2340703;
	Thu, 13 Aug 2026 14:40:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 472213A0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D4AF40133
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ZTb0Pe6Fnnw for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 14:40:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CBBC5400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBBC5400AC
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBBC5400AC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 14:40:28 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6acc74fef22so301529eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632027; x=1787236827;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TS+k7iASXD6/BZIwGCRmhF9Z5msWrQF7PN2eObt5bEE=;
 b=dmDCme4/gzsK9hJwAuBvdLwOohiqDI7kGuLnIlJqnzkKX/H5P4x547RYyPi0ogLWrd
 LfvMs96WOUYHtGEzWhGC3No5UDiUdfiqEM0Ums+BTLk+l+L8uxwK6eQQcQTpK9IJmIM2
 g6bZkb1hNwTOEAzqFzjWJuvSvK7DlIo+mKg++2MqcYx/Ei33pdETNJiXXVKN670bguWy
 ePx3ergDGHdhKIs8CU+hlQgUgjwfeOFzygDEl066d4OPktregs4BpO/PfayBhxI6Z7VW
 3IrzHWezu/36C82AYCJ12D2qHncCQTp27U88ezP/txT1bc7Yy3eQfIpdfPLbNqorbqXV
 CSuQ==
X-Gm-Message-State: AOJu0Yy1tXwVt5kxHZm2yoOTZCV652QvRXVZaqa2b9iWnSqO5bpP0d1y
 WpTRTtus17SDCX3r/SLBys6DKruVb+lV0eo5BM+fowkuCGvwtrCZV9aRLhdnhkxA0zY=
X-Gm-Gg: AR+sD12SMWNf/oudv4fsj0hzzS7xyiOAz3dfeCiXLANCxdFYf2hmiGkZ1KtxK0o2z1n
 jjHlc34NUF7ZWHjOXvnvdPL7b3M358EQlOY83hF+DsxyJHrus6tpy3IyDTJk8aZySgZertgNcZZ
 JCPR1e5C1Mt2WWUrc5oxnFw8kHdUOjqNRALRs+2W7Webf/wFNEbnBU3Fww+2H3UDN6GHBKAYiZy
 hj8xDFxMoa1EBiMSepbGm0YtRlteWoKPpPylY3BU3sjfDcptdvlT39ZRyP8GBaVJUkKBe3oz+mi
 q6rw7gJ/1DFhZ159Q4dCt0uOu1aa0IhcOOO0BursgiQecoXupZScKjndRhcjd9K0Xhv7xSKdSuy
 CpH4QM3oZt3GC1bxmZPuqEWb2W5PnsQzMvv46qRCrqqS4LtXx3oA8gQr0RveiyU87Wb44untEHU
 zhVsAHUiPoM4Xu0i5tKbBrK0t8zvQajF39U5rme21TjrV25TQl0oTP/8bjxRX5FQEY
X-Received: by 2002:a05:6820:4de9:b0:69e:4d9d:5a5 with SMTP id
 006d021491bc7-6b0c427b05amr5650728eaf.16.1786632027309; 
 Thu, 13 Aug 2026 07:40:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e64efc9adsm1698609fac.3.2026.08.13.07.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:40:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 13 Aug 2026 09:40:16 -0500
Subject: [PATCH v2] clk: mediatek: fix using clocks before relocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-mtk-clk-fix-reprobe-regression-v2-1-c7d1076a7ada@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBCFr0K6dkxbI4Ir7mFY0DLCyE/JFImEc
 HdbvICryZd8773ZhEcm9OKebIJxIU9uDKBPibBtNTYIVAcWWupUZuoCw9yB7Tt40gcYJ3YGw20
 YfYxCWllp5S3I0ohQMjEG8xh4lD/2b/NCO8fWaLTkZ8fr8cGiovf32KJAAdb6mudpZrXJClOtP
 RnGs3WDKPd9/wKd8Sfk4QAAAA==
X-Change-ID: 20260813-mtk-clk-fix-reprobe-regression-6ac0c072600b
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sam Shih <Sam.Shih@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=im2En+6YVCg4uxs+57/Z8hhg5d57IXMw14VLxdi7jtE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfddTS6l/yqtP14dihEi71ZOY/q7yEDuprR1/B
 tWDC3rnDMmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3XUxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ARcsH/1Z5Sr+KY1652c4v4WyxZUd2Ysct5PD10ZdlIyF
 TIGPN1HxNpkgOt/ajuUWSUgqQyMJ4kuMcNNMkZm/o3Grnc9jVJ2F0xd3zu8ZR5u6kyWcroI7Ksp
 DXHD3RaIGrrBQxyCWuGd+Ogfl+k2IbWnXgE/V1aIji+Jqdbk6vSbLkmBXKR23vOfcaBCTeyVfDH
 458RdnwFB7XLtZo+6STOZ5t3O+gDROF184xQpj5qhuVbJl7nDr7kLYMPTXeKc3Uwo+GqH0otyGX
 thX21aCq/b4JXC70wPLVEAt5aHY7XuwehHiHZ3n+Q1/N++C1ADrFE1imNy+HiEd58VRhtQ+LLKY
 T2ak=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786632027; x=1787236827;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TS+k7iASXD6/BZIwGCRmhF9Z5msWrQF7PN2eObt5bEE=;
 b=DYo7JvSoy4Isf2dK4C403c5MC4qRajJnJXbVwOGG74ZhMYyue/WuRQq6TSsUqAecTJ
 wmuMrXft1Ky5VGK9iyxsU1KtZJVepwD+IfWvSEU6rAU+ys5IBto2cSzJmLIyO7touiad
 3g7Dor7mIzLZ4QC+m2fdEpFiWZY259qdR0nltAwaw+gge4GGUTrBnEIWov6zNM5flbV0
 LC7RuGVXihxcEdqylfW6Sfq6zDzZMmKGC8IOJoyTmJ23B+aVI655BtlWGa5PnD2dDh38
 LCXT/y9gJTmQ3So4k1vNjeXiKKAGVcMdkZuPePoBDe8VjpS9ZOtnQIno/tM9a3xMwRJ2
 DEPg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DYo7JvSo
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Remove the static mtk_clk_providers array. Static variables cannot be
used before relocation in U-Boot, so it broke systems that used clocks
before relocation, e.g. for UART early console.

The mtk_clk_providers array was likely premature optimization anyway
since it only saves a few cycles of searching a small number of clock
devices on each parent lookup.

Reported-by: Sam Shih <Sam.Shih@mediatek.com>
Fixes: 8ef0ad4c7a6d ("clk: mediatek: use registered provider for parent lookup")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Change patch subject.
- Remove mtk_clk_providers array instead of clearing it.
- Link to v1: https://patch.msgid.link/20260813-mtk-clk-fix-reprobe-regression-v1-1-ed259968c2b8@baylibre.com
---
 drivers/clk/mediatek/clk-mtk.c | 70 +++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 13c248c93a6..70cc7624a14 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -35,8 +35,6 @@
 #define SCP_AXICK_DCM_DIS_EN		BIT(0)
 #define SCP_AXICK_26M_SEL_EN		BIT(4)
 
-static struct udevice *mtk_clk_providers[MTK_CLK_TREE_NUM_TYPES];
-
 static bool mtk_clk_tree_type_is_provider(enum mtk_clk_tree_type type)
 {
 	return type != MTK_CLK_TREE_NONE && type < MTK_CLK_TREE_NUM_TYPES;
@@ -58,44 +56,40 @@ static enum mtk_clk_tree_type mtk_clk_tree_type_from_parent_flags(u16 flags)
 
 static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
 {
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret;
+
 	if (!mtk_clk_tree_type_is_provider(type))
 		return NULL;
 
-	if (!mtk_clk_providers[type]) {
-		struct udevice *dev;
-		struct uclass *uc;
-		int ret;
-
-		/* Lazily probe and register the requested provider. */
-		ret = uclass_get(UCLASS_CLK, &uc);
-		if (ret)
-			return ERR_PTR(ret);
+	ret = uclass_get(UCLASS_CLK, &uc);
+	if (ret)
+		return ERR_PTR(ret);
 
-		uclass_foreach_dev(dev, uc) {
-			const struct mtk_clk_tree *tree;
-			const void *ops;
+	uclass_foreach_dev(dev, uc) {
+		const struct mtk_clk_tree *tree;
+		const void *ops;
 
-			ops = dev_get_driver_ops(dev);
-			if (ops != &mtk_clk_apmixedsys_ops &&
-			    ops != &mtk_clk_fixed_pll_ops &&
-			    ops != &mtk_clk_topckgen_ops &&
-			    ops != &mtk_clk_infrasys_ops)
-				continue;
+		ops = dev_get_driver_ops(dev);
+		if (ops != &mtk_clk_apmixedsys_ops &&
+		    ops != &mtk_clk_fixed_pll_ops &&
+		    ops != &mtk_clk_topckgen_ops &&
+		    ops != &mtk_clk_infrasys_ops)
+			continue;
 
-			tree = (const void *)dev_get_driver_data(dev);
-			if (tree->type != type)
-				continue;
+		tree = (const void *)dev_get_driver_data(dev);
+		if (tree->type != type)
+			continue;
 
-			/* Probe will add it to mtk_clk_providers[type]. */
-			ret = device_probe(dev);
-			if (ret)
-				return ERR_PTR(ret);
+		ret = device_probe(dev);
+		if (ret)
+			return ERR_PTR(ret);
 
-			break;
-		}
+		return dev;
 	}
 
-	return mtk_clk_providers[type] ?: ERR_PTR(-ENOENT);
+	return ERR_PTR(-ENOENT);
 }
 
 static struct udevice *mtk_clk_parent_get_provider(u16 flags)
@@ -103,20 +97,6 @@ static struct udevice *mtk_clk_parent_get_provider(u16 flags)
 	return mtk_clk_tree_get_provider(mtk_clk_tree_type_from_parent_flags(flags));
 }
 
-static int mtk_clk_tree_register_provider(struct udevice *dev,
-					  const struct mtk_clk_tree *tree)
-{
-	if (!mtk_clk_tree_type_is_provider(tree->type))
-		return 0;
-
-	if (mtk_clk_providers[tree->type])
-		return -EEXIST;
-
-	mtk_clk_providers[tree->type] = dev;
-
-	return 0;
-}
-
 /* shared functions */
 
 static const int mtk_common_clk_of_xlate(struct clk *clk,
@@ -1128,5 +1108,5 @@ int mtk_clk_probe(struct udevice *dev)
 
 	priv->tree = tree;
 
-	return mtk_clk_tree_register_provider(dev, tree);
+	return 0;
 }

---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
change-id: 20260813-mtk-clk-fix-reprobe-regression-6ac0c072600b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

