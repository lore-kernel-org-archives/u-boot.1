Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16803C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBAC440891;
	Mon, 17 Aug 2026 18:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s9YAxo_SgQO7; Mon, 17 Aug 2026 18:17:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5ABD540884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990658;
	bh=oRDXAE0MI20Zf0t2wNM49MT6dswoxNTo5thXVzk6l4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QaE8aH8qR0afu+yIq8rv1tiZaM31C/UsxzwUb1dtaxzheOBB1+aa/odlFtDwwZufk
	 og7Liveux8srca7fkc3ZlL+unq4Cs33CDIETPBF53NEMYdPlwLjHAb1r5toi9X9riu
	 5BUxzwj4DPb1UqYm/y5tMK+s6lb7p5X6+oza8MTLH6YhvyT3KDqt2GJFbRkilTpFlS
	 BCfFhflDYlONAE7iuytvHneKiODRfmLshrnuDzFXhfMm/ZUg6s3bnJpLm2qJo/rAvx
	 +LsFr56NNHC9ANfRLj+RcrUS+X4qUhhuRIdroYOybcYpYZAGx5NjwuE0FECFT7r5Cc
	 nZGhPl9bC4uUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ABD540884;
	Mon, 17 Aug 2026 18:17:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 694612EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F55580FB7
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayN4njQ4ETmG for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3F64580F0A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F64580F0A
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=bIcuw15b
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F64580F0A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:29 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-527e352a167so22871521cf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986988; x=1787591788;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oRDXAE0MI20Zf0t2wNM49MT6dswoxNTo5thXVzk6l4M=;
 b=bIcuw15bxvgKrtJvHFvhYAOv5WBJaHQlv+Gpy1/fqQaT+haLnIpdCAMZw9VO2ecDIX
 YEkloWf5gjsgZIDIb96rabK5n/DdXp/8LidxZXqRCzmmUuBFk039bbwQ3LyBQiJLv/1A
 bkHF4yVLIycoGV8vJlKHvrz8THiS0PBrjQaNBIfaxMkf3bSHgwFZRZiJB9r7GfL2p23l
 wxxjLwUkbVp0YrsdQQvkWAYBw15okho5GPEEsy9U3Y5zodY2iSABll+n9J8Aarm79Rfl
 6nlLebt8XhMfYggD0L+nOWTIkJsvvgqoNUeOXUFQHCvjwza1koXQd2wvuSU44tbhON1Y
 u6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986988; x=1787591788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oRDXAE0MI20Zf0t2wNM49MT6dswoxNTo5thXVzk6l4M=;
 b=KOf4BKy+KlyNQF0bM/IevEDyYVIu9cGLoWBt2B3Co3a+XK31eIRwIEqCsvVBEia6jc
 I1tRg+d2gpxohEqOD8fTKKeJPowPlSmutgRRKpvKqC1CcUCMADTzaB8ceZXX7P0D82kf
 2G0a9StQ2eRIaOOt+8Wlq6erhAyOKgFX7Hu7wozScPLzX7/iDYBcdo4s4TWavmrzTwUx
 jhuVqyiSoAqSYDYmwlP4rtbnKkc9NWCAAWuURhdVUrGi77hIMLep4fgpcd0ew//98MeH
 VPuBs86bPcuIww9H9cc7KFQrayox4QDstrQ7wMtfFrtSC9DOi1WKytT6/lKkqh3S8Ymd
 B/+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsjtbvPh6xIPmI6AeasVi/v6evEKyZ7vhUbGIYs3HAZ4RU1IoAbMBQ/EadV+kah2SinbxSqNc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy2XE38shg5xJjzGllYbtDs3GmsdFKmMYfheiUhUpoWjfF0uMSr
 qP0KLWW9IZttpRGrPtvsPCsMqu46Ksw0Dhdikn75umoiGpf9wreGlQw0/NUzbxukiSuhy7cQ6ob
 +GNi806eUX6Tzk4AUCONbCi3zIbZeFCJ1RJTHB+pzB6zmf2P2Vx/Q4qKIQLv+elNzux6ecjsAFN
 zcf1s=
X-Gm-Gg: AR+sD12CnTz+8AeJFSz1TlrNsNlTCygC10XgDJIwrIEYnVdG+xOExCOcOlCb8+6bDzR
 EB3BHuDHkOhFoFnW9tI3SDGoPxwopxNK3uEoXqYg4Jo/iGbgmBgaqCQjlNaPhcHO11bkItsOGHl
 7TKXGLY31JRsHwXgOTBIYSXFhBU0YIUkXf2PGPwwAXaW7HSocHmyV1aUvpM5X1+a6uUTbQ8m4Ij
 80JhnpJ1BXAW0gTB/LC2Rz6BdAU2zqgzosw1LGL/1H0DE7DPImFqK4Jmt9kLZMZfUNp/xxDOSHY
 NKF3hmS1+OHz47oHMvYvaRSq/4d2D0tDkpIHlqtwNz0Iw604H70jy+eMF9OE+8ns0UZzCb2K4GD
 /26Z8u4x1Gt1xExRnGjouVU4uVJ5zMhXBAI8582abLskh61pzmIAxf8UP8yzS7Hc+bLOG3XO+oA
 K+R7s37D4AFf/2INiWflDD6rtulRiMbZOxPMy0oCYRqJCJ9O1GV4eObK2z9KrpLx/LHUBSpFF2x
 E43CL1LKjc/a8TEy4lnaZUuxuU=
X-Received: by 2002:a05:622a:2b49:b0:51c:b98a:2448 with SMTP id
 d75a77b69052e-52dbd5fed58mr29129911cf.9.1786986987473; 
 Mon, 17 Aug 2026 10:16:27 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:27 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/9] clk: meson: a1: Eliminate separate id parameter
Date: Mon, 17 Aug 2026 13:15:13 -0400
Message-ID: <20260817171623.1943847-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

Instead of passing a struct clk (containing the device and an unrelated
id) and a separate id parameter to most functions, just pass a single
struct clk with the correct id. This is in preparation for converting
some instances of meson_clk_* functions to clk_* functions to allow for
greater extensibility.

In general, this transformation requires constructing a synthetic
struct clk wherever we used to call a function with an id different from
clk->id. We don't bother to call clk_request since we don't implement it
ourselves.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/a1.c | 150 ++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 76 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 669247a9a09..d0376663069 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -302,17 +302,16 @@ static const struct meson_clk_info *meson_pll_clocks[] = {
 	),
 };
 
-static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id,
+static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
 						       enum meson_clk_type type)
 {
-	struct meson_clk_data *data;
+	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
 	const struct meson_clk_info *info;
 
-	data = (struct meson_clk_data *)dev_get_driver_data(clk->dev);
-	if (id >= data->num_clocks)
+	if (clk->id >= data->num_clocks)
 		return ERR_PTR(-EINVAL);
 
-	info = data->clocks[id];
+	info = data->clocks[clk->id];
 	if (!info)
 		return ERR_PTR(-ENOENT);
 
@@ -322,7 +321,7 @@ static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id
 	return info;
 }
 
-static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
+static ulong meson_clk_get_rate(struct clk *clk);
 
 static int meson_set_gate(struct clk *clk, bool on)
 {
@@ -331,7 +330,7 @@ static int meson_set_gate(struct clk *clk, bool on)
 
 	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
 
-	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -350,32 +349,35 @@ static int meson_clk_disable(struct clk *clk)
 	return meson_set_gate(clk, false);
 }
 
-static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
+static ulong meson_div_get_rate(struct clk *clk)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	u16 n;
 	ulong rate;
 	const struct meson_clk_info *info;
+	struct clk parent;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	info = meson_clk_get_info(clk, MESON_CLK_DIV);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	/* Actual divider value is (field value + 1), hence the increment */
 	n = GET_PARM_VALUE(priv, info->parm) + 1;
 
-	rate = meson_clk_get_rate_by_id(clk, info->parents[0]);
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	rate = meson_clk_get_rate(&parent);
 
 	return rate / n;
 }
 
-static int meson_clk_get_parent(struct clk *clk, unsigned long id)
+static int meson_clk_get_parent(struct clk *clk)
 {
 	uint reg = 0;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -391,16 +393,16 @@ static int meson_clk_get_parent(struct clk *clk, unsigned long id)
 	return info->parents[reg];
 }
 
-static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
+static ulong meson_pll_get_rate(struct clk *clk)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 	const struct parm *pm, *pn;
 	ulong parent_rate_mhz;
-	unsigned int parent;
+	struct clk parent;
 	u16 n, m;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -413,40 +415,39 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 	if (n == 0)
 		return -EINVAL;
 
-	parent = info->parents[0];
-	parent_rate_mhz = meson_clk_get_rate_by_id(clk, parent) / 1000000;
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
 
 	return parent_rate_mhz * m / n * 1000000;
 }
 
-static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
+static ulong meson_clk_get_rate(struct clk *clk)
 {
-	ulong rate, parent;
+	struct clk parent;
 	const struct meson_clk_info *info;
 
-	if (IS_ERR_VALUE(id))
-		return id;
+	if (IS_ERR_VALUE(clk->id))
+		return clk->id;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	switch (info->type) {
 	case MESON_CLK_PLL:
-		rate = meson_pll_get_rate(clk, id);
-		break;
+		return meson_pll_get_rate(clk);
 	case MESON_CLK_GATE:
 	case MESON_CLK_MUX:
-		parent = meson_clk_get_parent(clk, id);
-		rate = meson_clk_get_rate_by_id(clk, parent);
-		break;
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent);
 	case MESON_CLK_DIV:
-		rate = meson_div_get_rate(clk, id);
-		break;
+		return meson_div_get_rate(clk);
 	case MESON_CLK_FIXED_DIV:
-		parent = meson_clk_get_parent(clk, id);
-		rate = meson_clk_get_rate_by_id(clk, parent) / info->div;
-		break;
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent) / info->div;
 	case MESON_CLK_EXTERNAL: {
 		int ret;
 		struct clk external_clk;
@@ -455,20 +456,11 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 		if (ret)
 			return ret;
 
-		rate = clk_get_rate(&external_clk);
-		break;
+		return clk_get_rate(&external_clk);
 	}
 	default:
-		rate = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	return rate;
-}
-
-static ulong meson_clk_get_rate(struct clk *clk)
-{
-	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
 /* This implements rate propagation for dividers placed after multiplexer:
@@ -476,19 +468,22 @@ static ulong meson_clk_get_rate(struct clk *clk)
  *     ..... | |---DIV--
  *  ---------|/
  */
-static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
+static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
 {
 	unsigned int i, best_div_val;
 	unsigned long best_delta, best_parent;
 	const struct meson_clk_info *div;
 	const struct meson_clk_info *mux;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct clk mux_clk;
 
-	div = meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	div = meson_clk_get_info(clk, MESON_CLK_DIV);
 	if (IS_ERR(div))
 		return PTR_ERR(div);
 
-	mux = meson_clk_get_info(clk, div->parents[0], MESON_CLK_MUX);
+	mux_clk.dev = clk->dev;
+	mux_clk.id = div->parents[0];
+	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
 	if (IS_ERR(mux))
 		return PTR_ERR(mux);
 
@@ -497,8 +492,12 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
 	for (i = 0; i < (1 << mux->parm->width); i++) {
 		unsigned long parent_rate, delta;
 		unsigned int div_val;
+		struct clk parent = {
+			.dev = clk->dev,
+			.id =  mux->parents[i],
+		};
 
-		parent_rate = meson_clk_get_rate_by_id(clk, mux->parents[i]);
+		parent_rate = meson_clk_get_rate(&parent);
 		if (IS_ERR_VALUE(parent_rate))
 			continue;
 
@@ -524,21 +523,26 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
 	return 0;
 }
 
-static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate);
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
 
-static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
+static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 {
 	int i;
 	ulong ret = -EINVAL;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_MUX);
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	for (i = 0; i < (1 << info->parm->width); i++) {
-		ret = meson_clk_set_rate_by_id(clk, info->parents[i], rate);
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = info->parents[i],
+		};
+
+		ret = meson_clk_set_rate(&parent, rate);
 		if (!ret) {
 			SET_PARM_VALUE(priv, info->parm, i);
 			break;
@@ -551,43 +555,41 @@ static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
 /* Rate propagation is implemented for a subcection of a clock tree, that is
  * required at boot stage.
  */
-static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate)
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
 {
-	switch (id) {
+	switch (clk->id) {
 	case CLKID_SPIFC_DIV:
 	case CLKID_USB_BUS_DIV:
-		return meson_composite_set_rate(clk, id, rate);
+		return meson_composite_set_rate(clk, rate);
 	case CLKID_SPIFC:
 	case CLKID_USB_BUS: {
-		unsigned long parent = meson_clk_get_parent(clk, id);
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = meson_clk_get_parent(clk),
+		};
 
-		return meson_clk_set_rate_by_id(clk, parent, rate);
+		return meson_clk_set_rate(&parent, rate);
 	}
 	case CLKID_SPIFC_SEL2:
-		return meson_mux_set_rate(clk, id, rate);
+		return meson_mux_set_rate(clk, rate);
 	}
 
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
-{
-	return meson_clk_set_rate_by_id(clk, clk->id, rate);
-}
-
-static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
+static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	unsigned int i, parent_index;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, clk->id, MESON_CLK_MUX);
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	parent_index = -EINVAL;
 	for (i = 0; i < (1 << info->parm->width); i++) {
-		if (parent_id == info->parents[i]) {
+		if (parent->id == info->parents[i]) {
 			parent_index = i;
 			break;
 		}
@@ -601,11 +603,6 @@ static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
 	return 0;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
-{
-	return meson_mux_set_parent_by_id(clk, parent_clk->id);
-}
-
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv = dev_get_priv(dev);
@@ -636,11 +633,11 @@ static const struct udevice_id meson_clk_ids[] = {
 };
 
 #if IS_ENABLED(CONFIG_CMD_CLK)
-static const char *meson_clk_get_name(struct clk *clk, int id)
+static const char *meson_clk_get_name(struct clk *clk)
 {
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 
 	return IS_ERR(info) ? "unknown" : info->name;
 }
@@ -651,11 +648,11 @@ static int meson_clk_dump_single(struct clk *clk)
 	struct meson_clk *priv;
 	unsigned long rate;
 	char *state, frequency[80];
-	int parent;
+	struct clk parent;
 
 	priv = dev_get_priv(clk->dev);
 
-	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info) || !info->name)
 		return -EINVAL;
 
@@ -670,11 +667,12 @@ static int meson_clk_dump_single(struct clk *clk)
 	else
 		state = "N/A";
 
-	parent = meson_clk_get_parent(clk, clk->id);
+	parent.dev = clk->dev;
+	parent.id = meson_clk_get_parent(clk);
 	printf("%15s%20s%20s%15s\n",
 	       info->name,
 	       frequency,
-	       meson_clk_get_name(clk, parent),
+	       meson_clk_get_name(&parent),
 	       state);
 
 	return 0;
-- 
2.53.0

