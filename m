Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFFEC98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BA0C60BAF;
	Thu, 24 Sep 2026 19:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1RyEM6-Ec7d; Thu, 24 Sep 2026 19:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 042EE60BC6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279031;
	b=al+ImSE6cGJxMJuYHE4iis+uvx9CsABkd4sJHJCtpy5x1gYMmUktP5kjv0raeQXtOwFv
	 RDysbgQ1nMicr7bW5Gi0OOo4e1zPlcaYJoec6Aswu+5J8kMcEY9eT1IuM88TiNZwQ+94a
	 mPLf1RLpPbgBR3vGBjtzO4ub6QpUIoG8kJJWIFrNYCAsAoppop/hWMBB7wCXAP7BLbrVJ
	 jVmAKBVWGt23c2OXykG34VxXLjinHRCH00itq7G5i5khL6aHws5w+AbC5LapA+7mL2Dbi
	 /xZ0Jx2zbspY1MBTJMr6NsZJgojTOBpwL84Er4etUPEAlab6h0jEtjV26FKcjlpPvvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yVEDHDqsMwX9EswXFDsJ5a3G8SjJ7/17O26mrBzePiU=;
	b=bYdBnYcQW9j3TfukUbS1T6OgUaKSAnaIGJ4BDOBevZkUhdcRQoq8bHOWo+SmykYoFgnT
	 uQFar/4JdvxkKhytrY6gxl6QV/T6nWpV8YAiLni6/CNttj3TFlBwQnGA6VEKU497kLhx1
	 u5Fs08mIv7HzrRcSWnuu/MMCx4LdIItIulAUIoXNimktuajnq5e7BWtg9NGTjbMeZeH3Y
	 EXVE2Kp3rJ4h47kUXLpNBypSnj2q3jzcQZNoq73X29un6vcQ3MDXWKwg6HmNGPXwQzK7h
	 mIyoxpOL92WxKy1CVTrSjTWRdVL7k3n5ajM6zJs35fqWfbULoYJdKHbb78pg0CFGSvw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279031;
	bh=yVEDHDqsMwX9EswXFDsJ5a3G8SjJ7/17O26mrBzePiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0QJSr9axLITega0oHoZ6oSfpqX1BE6YNKMUHLFfc1Dig/TvWL60Xg8uSG2T4c8d5I
	 PVs4ERUCCXXTbwsJl3x4OFdpU08/lrtVD0/4ufdZ6fNobH1ESGx9uUk1XKh12t+5xE
	 Y02nYQ7ktVM7DI3O4+KZAjE9f026edfrzrXo/+sK/01e/TRUTirCrUcE2fbnRdu8vK
	 /eUaRr4+MDs7j1ydwgYIxEeQHVtqkspch+9yuKrjrglPG6lI9UvhkkYdgzYj/7yTCr
	 iweBFqoEYs70mfhediYEdgprxsJ3MO91ljHaAYYDoYeiHNuIzUvJ2GOLQbC4ZG/hQk
	 ng4kTgmzt05PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 042EE60BC6;
	Thu, 24 Sep 2026 19:43:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 459B1355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B4CE40E3B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WfInPrWQhMX7 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 337B240BD3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279026;
 b=HtLHYPsK7k3n/HNskHYG8Gi6ndBG88y+cthdBwIbCOetm7IQgqP+JrtxlyWPa2QB34LK
 AUZ+k20tDha112mbflsXM/CumhFpr/HICi+gq4cMygLapho3jYkHOAOEnyV+9PWk5TaNx
 4lGXMFZTzLK5lJeNzBdF7+H1rArInsInndZUySYMhNG+orCPQFQRDtizSsXvvJVb0aeBL
 IE08hvlEIvC/UeCIMLeoFtPtxrIw7egZyOjVKZSGrbFHlvZlT/wPfu3lNI4c8y7FJhGyr
 4Pbpfxnbi03ARRjbUVyV317qCbAgSByZSIg9jUOqj4areCRjBjkHb8SyJy0ddLpe2xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279026;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=yVEDHDqsMwX9EswXFDsJ5a3G8SjJ7/17O26mrBzePiU=;
 b=RRXrNtXkMmbJ0ieZRmcuPWuLLB/C9zawg+kovfAKdNVKew4EIV0Khm3RTtiqxN+VgH4Y
 hF9i4N9Wnd5FdIJJtdwafI9J89UD0aaTixWty9awfd4chJlyn0Yk33kjmkzkO8XzkbGNG
 S5rypVraeTtqqefYgxt0QPvLpvUy9Ld24puJ3LFH3vvMwjIQllY1c1nEymQFXJ1uSMZbS
 /SBv3BZ0ub4D1H4zPzs/53QO8594LJnMsoFD9u4l8L7P/Oxz3P5qIYW8+nzvX9zFDq0Dd
 MberztpfMGVpLmsQ7JNuoZik1UvEJM3hUAfiHceZIWEXlLFCJQ7xVGSfuonZewXF3/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gyFL2hB1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gyFL2hB1
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 337B240BD3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:45 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-80a18990c76so102869a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279024; x=1790883824;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVEDHDqsMwX9EswXFDsJ5a3G8SjJ7/17O26mrBzePiU=;
 b=gyFL2hB1LgOUr1HKDgY+mvwYpsgKNJy9g2U2fyDpR4PNh/ERDvIzsVZ4UBSom8CpnU
 Va7M5UxVaraZ8+OyPwLZY5NAx5MR9Ln44UrzP/3/RJAlSsYLfOe8Vx3HQ2I13ZxCPh+l
 r0hxCNlMNR8hQ40C/a+NLZaNvxKbGya39FvdlF05JquYtpxJhUMo+uJSlU9YrYwUYPFy
 AdrV+2d/QPqYgEdlAI+O/kiIDqcV2+nsQmoPxETcY8Rd0nO55vdMslYO+ArIuu/OaTHc
 IKvhltxHlMtP0kxm69XOPnHiPZ7fs25Noam/kkaSnDAYnBje32IJ7dQLekvwH4+PAnIp
 f5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279024; x=1790883824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yVEDHDqsMwX9EswXFDsJ5a3G8SjJ7/17O26mrBzePiU=;
 b=ci6QpmYu3UYIg1frV566Oz6FWzwCvSUyPr+z/TDuIGehUl1HlXr0r5+dXO2ZxD1uaZ
 3S3FaQP+mTToW+CT1551TphrUfe5kxqV9CJdgjT5NnMijjpgrXnmBfrdva/QvXkABU7Y
 q4D2w5F1NL2s7ei7GHBhcndUBCgSpto0h8gZLC4hoQK6eQ0aRGKSfDoqqEtIxKvpSisM
 rpfsm26sOQHKiYgseT6Htjy5DBYiGG8e6NOGfQzVQFMrKSKL3h1cRNVHsokwwojZ3ItT
 SKOjO4KDmXyP8H7gC9Hl0/NZcXiU5I674qqPEVlky1t/syYX+SapC75Zv2WxDm8d7FTP
 +Wrw==
X-Gm-Message-State: AFuF++msDg7K8SmHtKHn82a5EMC1+OtIwrNcuiFkGGuTnn4QS+CMfnTK
 McCviiZS/wOr+NRH3OERltFlyjnA3TbE/fpHey5ORtgN/hl7Ax0cbAPpGDfnr5lh1vw=
X-Gm-Gg: AYBFou0WbgEK7v47qNinDoAxoELtLDaprSjuT4CyJdV4R1mxdg+yB0Fx4i88BP1lIae
 PewH02HcJJKW/U/j5xnHeCnGkhB/xJUHY+IIqnhHsHkxwySkX0xMc4KdE3WiB9G97+3vSMDoRzR
 J20Wu0/7f4d73tP9d521FFDhEeZGzJP6E+9f/dhQu2colP/LHGmIt3uDgxXWf9d9lckz8Xu/bF4
 ma4AKyVMV01D3acNnmM6fUZlKqdZNR+mYDOT67Ve3/RUWmC5dnA/lS4EU3gW23RZrcPFTyDR4J5
 eN24R2/LE0pRuw7uxVAN0SsPn0i1qdvdj1eJYjmrfr85+OrIsVBx7mbzlrBqwGH5Qt8xI1EJ/NQ
 JBWeYpT2+P2l/EeOJp04FOHKdwiBX4CBGMLFF0mVRZeN/rewtvM+dt/yBNE0ZxAHa4vpE4QUM0I
 QA7rOm1LOPEYuoRgpQHQQ6sgfoMXR02uYbuSYhHgfpYgDALyWhreNx5i6wXfDnLjOiILYKfGN+M
 w0=
X-Received: by 2002:a05:6830:8294:b0:7f4:effa:a5ad with SMTP id
 46e09a7af769-81781487f59mr4041988a34.10.1790279024555; 
 Thu, 24 Sep 2026 12:43:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:40 -0500
Subject: [PATCH 02/15] clk: mediatek: merge the of_xlate callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-2-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5276; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OHz29QeE33WQm9qbB6ZEOT16DuTfwYE0060yA9JTw5E=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0JQsMRwpx2OridZPChfdL7EDPJRWLqx08mj
 pRXalbpmuaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9CRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhcEIAKFj/4L/oIOpM7BlU9Ngd9eraEfWV3rk2iYOU0s
 AXrBpXItz0c7wdSvW2rixrPzP9hHPo9RD0wqCsYi8l+dzVpW47dz5PJ4jUH635Yp3TeSd8Qatgl
 V8KS+S0o2ZMJVIbDyPNOOSnY5Ls3MxXgLB1WEkDqLihjxlE5GoSiSyGSPz6J8X4oMtsbOifTURj
 Ybb0PGddDuuYJMZZAEU3ydRoWNwYRuKw7PzIFKh5nrC9E67Mems5c3XfViQIfZzRqveM4zdlhOI
 d1IG/UGczNFURfscj2CW6MMHnk5Oenh6W3W4LQlVeLu32CSYE1W9BBaBG0kaJj3sjoGZV7VI1FH
 oIPs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Replace the apmixedsys, topckgen and infrasys of_xlate callbacks with a
single mtk_clk_of_xlate() that accepts an ID if it belongs to any of
the tables of the clock tree.

The three callbacks only differed in which clock types they accepted,
but each mtk_clk_id_is_*() check already requires the matching table to
be defined, so the tree contents do that filtering by themselves. No
tree using the apmixedsys ops defines fixed clocks, fixed factors or
muxes, none using the topckgen ops defines PLLs, and none using the
infrasys ops defines PLLs or fixed clocks, so this is no functional
change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 82 ++++++++++++------------------------------
 1 file changed, 22 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 78ce206197d..d93c19c74db 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -177,6 +177,24 @@ static bool mtk_clk_id_is_gate(const struct mtk_clk_tree *tree, int mapped_id)
 	       mapped_id < tree->gates_offs + tree->num_gates;
 }
 
+static int mtk_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	int ret;
+
+	ret = mtk_common_clk_of_xlate(clk, args, tree);
+	if (ret)
+		return ret;
+
+	if (!mtk_clk_id_is_pll(tree, clk->id) && !mtk_clk_id_is_fclk(tree, clk->id) &&
+	    !mtk_clk_id_is_fdiv(tree, clk->id) && !mtk_clk_id_is_mux(tree, clk->id) &&
+	    !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
+
+	return 0;
+}
+
 static int mtk_dummy_enable(struct clk *clk)
 {
 	return 0;
@@ -427,24 +445,6 @@ static void mtk_clk_print_mux_parents(struct mtk_clk_priv *priv,
 
 /* apmixedsys functions */
 
-static const int mtk_apmixedsys_of_xlate(struct clk *clk,
-					 struct ofnode_phandle_args *args)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	int ret;
-
-	ret = mtk_common_clk_of_xlate(clk, args, tree);
-	if (ret)
-		return ret;
-
-	/* apmixedsys only uses plls and gates. */
-	if (!mtk_clk_id_is_pll(tree, clk->id) && !mtk_clk_id_is_gate(tree, clk->id))
-		return -ENOENT;
-
-	return 0;
-}
-
 static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
 					   u32 fin, u32 pcw, int postdiv)
 {
@@ -711,25 +711,6 @@ static void mtk_apmixedsys_dump(struct udevice *dev)
 
 /* topckgen functions */
 
-static const int mtk_topckgen_of_xlate(struct clk *clk,
-				       struct ofnode_phandle_args *args)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	int ret;
-
-	ret = mtk_common_clk_of_xlate(clk, args, tree);
-	if (ret)
-		return ret;
-
-	/* topckgen only uses fclks, fdivs, muxes and gates. */
-	if (!mtk_clk_id_is_fclk(tree, clk->id) && !mtk_clk_id_is_fdiv(tree, clk->id) &&
-	    !mtk_clk_id_is_mux(tree, clk->id) && !mtk_clk_id_is_gate(tree, clk->id))
-		return -ENOENT;
-
-	return 0;
-}
-
 static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
 				    ulong parent_rate)
 {
@@ -936,25 +917,6 @@ static void mtk_topckgen_dump(struct udevice *dev)
 
 /* infrasys functions */
 
-static const int mtk_infrasys_of_xlate(struct clk *clk,
-				       struct ofnode_phandle_args *args)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	int ret;
-
-	ret = mtk_common_clk_of_xlate(clk, args, tree);
-	if (ret)
-		return ret;
-
-	/* ifrasys only uses fdivs, muxes and gates. */
-	if (!mtk_clk_id_is_fdiv(tree, clk->id) && !mtk_clk_id_is_mux(tree, clk->id) &&
-	    !mtk_clk_id_is_gate(tree, clk->id))
-		return -ENOENT;
-
-	return 0;
-}
-
 static int mtk_clk_infrasys_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -1056,7 +1018,7 @@ static void mtk_infrasys_dump(struct udevice *dev)
 #endif
 
 const struct clk_ops mtk_clk_apmixedsys_ops = {
-	.of_xlate = mtk_apmixedsys_of_xlate,
+	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_apmixedsys_enable,
 	.disable = mtk_apmixedsys_disable,
 	.set_rate = mtk_apmixedsys_set_rate,
@@ -1067,7 +1029,7 @@ const struct clk_ops mtk_clk_apmixedsys_ops = {
 };
 
 const struct clk_ops mtk_clk_fixed_pll_ops = {
-	.of_xlate = mtk_topckgen_of_xlate,
+	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_dummy_enable,
 	.disable = mtk_dummy_enable,
 	.get_rate = mtk_topckgen_get_rate,
@@ -1077,7 +1039,7 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 };
 
 const struct clk_ops mtk_clk_topckgen_ops = {
-	.of_xlate = mtk_topckgen_of_xlate,
+	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_topckgen_enable,
 	.disable = mtk_topckgen_disable,
 	.get_rate = mtk_topckgen_get_rate,
@@ -1088,7 +1050,7 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 };
 
 const struct clk_ops mtk_clk_infrasys_ops = {
-	.of_xlate = mtk_infrasys_of_xlate,
+	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_clk_infrasys_enable,
 	.disable = mtk_clk_infrasys_disable,
 	.get_rate = mtk_infrasys_get_rate,

-- 
2.43.0

