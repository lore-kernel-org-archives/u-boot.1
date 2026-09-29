Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426B8CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DACB810D8;
	Tue, 29 Sep 2026 20:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xn3YC14ZORNC; Tue, 29 Sep 2026 20:32:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 998F1810C6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713973;
	b=Ax5X7b0SjfK4/haSNcLrDgzssOlvBSSPt5RXwaE3bCpxFS5Egelnq7tW2ZKg5iwaCFzV
	 3qPqc0wGMQOhwfuWqU88SdYzb4bgXLQZjml/GAiCqRw+YC6mAHvFRZQKvseWBFJjZ8enI
	 F8ltyw01nHOwERfkbZb4PxJtI48U+Hv576enPyIuL4kXgxWrHv1kA3xXPkKLyi5NT8pud
	 xHFZfr+PjLOXuFSy+grb3pv+GyVSfE32QLqndrrPTbL0BwkhysPXDFTUuur+KNU1X8dtf
	 7/RCvSWsLjnKM/GOq5m/6YI23UHs/bySCF3MpbC+tWGCRBRxOLZNaguAjBaN66Fb4CQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
	b=fWo84XjoRr0l5JNeRzDNXe5mbR8KryV15zAWzmt94/19D20wPmOpBk4TF16TVjGdtHTj
	 6009asEiBXcMW38XviGYE2XsUyoHcb/lkQv9rMp6G6PKcXhTYii1xFxWCRCmqUS6Z4VDv
	 2UIVng5YZeP3rnHpFluZ/AhSAUaE0jEtjSqng6kO1YEAvPbxzUUuB1Ex/0THE42WwUoMN
	 Ek5b0WITSEUCtqgL3R7Zb2dtd8PCuA9BoLTMLQav812/Ug/zAaMmjxqszZ1IWHg3/IJAG
	 /1VtKKSHr8a72B0B1a5SGHn1Y+ADi61QPcObTzlFZNZhcz0ouQBEJLB6x0zVSdsnBHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713973;
	bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeW9ZRCJv3ElJYgU4b8NogvhWJUfLsdChMMT8rtzT/WiTlDd4ZG90uEgsjt8UgLVW
	 dT5Ni4uFoGo6/l7HXfYYe/M3O5aToVBBd5rjNJt3ZO41csY+yiozJYnheKyaS4RL5Q
	 34odNpp/yn047/u6p+TchbcGQ8FeuvAEjSAS0XupVl/IHqVgnjmEruiZKyp2qZeYr8
	 /7MQss/Itm1S7wKkVeCeyjnwFsU+O/O3xrkQMTZxVmVqCjWKqx+NY9xY+9TkE1lLR7
	 xnlrv2vwHxZyvan5jpkInFMaHSbX5olNOOySbcHC6gTIpppfRUgiofoKY6q0wOs1NK
	 UyYWHNpADlzqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 998F1810C6;
	Tue, 29 Sep 2026 20:32:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CE39282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E977400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Yo3yPMUA23E for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 57A81400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705247;
 b=QMjoR/GKmkm3C09uf3fNZSBQmREjZjzAaYzulpnn94q01zrb2vt3sPzAFEQWvFE8LP2V
 FQGlv/LgQ+YwUGErJ6yhFRcP8yDWSKCbwznbqO98Jh4/9sc7ss95Xz9gamkEe+zGjDPiB
 h2hKHGRJsXDDFaSY1TDjQHIebFM+bx7vNdNYxJiVWy4DsKo9Errgj8wljnkk/QPAQejMx
 GBNJYcCeXXBbkFqpU+HSf8jXMvKK6izqpgflE0Muz0jd6qk220nDXeqYk5tF5tQ8T+fbm
 JkgMhmLZVNPjAKfM7Zy+EF3snpo3OeSk/+ZkoCUE+DxwYNEofc1ffe2rwmeJgPwZMRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
 b=Z8+mUXeO5hxTtaBmePD5wRbunSOPYmgJO/hckHpXiCksIZyL6wTT0S040FAnxtWXwG6O
 QF5xUtrplasrE1hooFId1mZTFlhIfeWiIEe8tNdOW9Hlad5WuvPwze+CFNyPVPHaB+Tq5
 Q9Klnagcqoa5yxK/tF4Or8OjCcB/I040yxj7ZOuAHuOYdaQ1LZ9yt4+JAHQcsriZjBzEq
 AIx5VZCAympE50oNLCI0SqR2mE4z7Ji14F7XEWUr8jG++uR2i443F+lMuzcA94wO9fGN7
 oHevN3peV5xwjjai+8OGynbzyE/Bo3klwPeNH3G8YJ3Ptea+13gcMjZY0GWHr/F3INQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=zB4B9lnz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=zB4B9lnz
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com
 [IPv6:2607:f8b0:4864:34::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57A81400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:26 +0000 (UTC)
Received: by mail-qk2-x11.google.com with SMTP id
 af79cd13be357-93910c9ff1fso459926485a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705245; x=1791310045;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
 b=zB4B9lnzCamtjcsAMovZ5BZeln9aQ4p6ZKimWIFxvQ3RixHuw6hLZEEnPy3a89xBR4
 pXjbHOOXMuZZw9Wy1oQkdJHs4e5iTcx84tZxJjrubdRTERrDCNUmPy5rfkj4fZZhf3tN
 6bW4ehze7DPk4Bdnrzq4OZdYb6c4vBaVaR02Sr7oO1GT3tNHfeQPcS/R0HvTO3en50a2
 gtYkOEcGN4ttePFNaCD0J7ZQ4iOWOyZHf6ty5o/VV6fPHMSFvaZ2EtC8539WoGtjy6TW
 HHdwfMGfzGVJLkmu1ndBIvfSn4L6lDxYdvc3c0YstgSskhUFJ/yghnbQVm4S54z8Ji0k
 T7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705245; x=1791310045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
 b=o7ZqjTqJ66n32tCFxTQK9LzilBWL2LshAk7ZTRIP9lZ3DfOPv0hls2fm60zxJe5zE4
 gYK16oZHNCXvVyEUHG1ztwa2FHf7yrVN7iLMDtLZV/cMvL07ePMLsdFwCqhvxPtFUn0a
 0NHYAUhxCZNim+ELAPyORy+av03MLhhOZie7F+ZxNqkPhoLuO82FeSHzyxtOGejWUaCA
 cTUngJJSgQ+Qm93nLpmPNxiE1+Yd94mdPGkvZx2R59VociZOcFT8kq5EdDO9BPd/LL0g
 Srzd3I6zJQEXMiCTTyWtaLkDq5CIXLIaNm4oeveCFECGfdlqCxNRckmxS7BEIjf3djlM
 O/Pg==
X-Forwarded-Encrypted: i=1;
 AKwUvByyPr52VUA9TUD088FXyRxPFoAhGRrEF+XuRt4LeojYXbR10iIUmQSYe423eM3po+J21zI/BSE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lLwB4/MsDGfox/xdU57fbqQsOC/kErST+Yyi9ZK7h5VYUbVA2c
 Jd9E0wGHTwU/prtMdhXgRzNDscyutP9+hqKQtX/OgASMKjSkE/EmCZigW9cncPXkbkaDbYsWOly
 n0dUbRVdbo1oAw6/Bm7kZP9asjhNrCBt9nQZQYCqYmixwlB6yPomyFdDkr87MHL8=
X-Gm-Gg: AYBFou2mvvqEuR1SABgf9qsFtQw11YVQ4xZiaROpDWEPm4l/w+A6OTSoAqD8wORLgp1
 PhjJHFHbAHKnCccYTXndAkPhm4avydYkJR8rGKl3ctxcKFM+gRTUQNEDkkKm/GeyQldgJhw/45c
 swkzZYmgVD7GsqT/4jMjdAXyg/BdxNL1Ljk6fwRnIxT8wNezH6R/2ZEYX+WszrwaGkRAJEOmm6q
 CsjKYgAUmotEsBMQsSSz4G33e5Ip4U8bkQSNCl6xnXEG/4ViagPHi6PSZB40Bt38C9wryL/rW01
 htt++dWArRnL69njUfOAv4syLAkRlii5vM1x6JxLGzT7y7J3dfJmevmO3d0J8j+Xes6xUyvZ1ui
 zOgFqKxabKgKMMopH5fSOVCWYGj7DD6EQnTjIkQfVi683Vp6XBmF4F7RpGnqAhAY0qZsZGA0/5w
 IdpNczon8LXflbP7dPJ/FNhMUhbdxx4YsE4L/UGlnELMfz2/DfJjqVmGTBpqT0iC8p0H0sEY1B4
 4g=
X-Received: by 2002:a05:620a:808c:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-93c9fa9f5dcmr67532485a.48.1790705245388; 
 Tue, 29 Sep 2026 11:07:25 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/9] clk: meson: a1: Eliminate separate id parameter
Date: Tue, 29 Sep 2026 14:06:24 -0400
Message-ID: <20260929180721.3440839-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

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

