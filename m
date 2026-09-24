Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA4C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A0C3811EE;
	Thu, 24 Sep 2026 19:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihaQ8_OyGNLX; Thu, 24 Sep 2026 19:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 95302811E9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279033;
	b=T4Ik75QDqrmUx/xW+WJySI/tADqSDAr+1cgqtYgkqcyQtDR6J4OzI3C/JUGzVKQ721ao
	 4FZ/Tx/zJv2jzXHR+83fn3Ffm9ERl+sfVVmHKeAD3UXgHlptuUbT8yauqFQVGa2i8+Yx3
	 n2vWtbY9qrP57dn2JGo9v69365FIYZrSP9rb+Kr1JXrgmsMiTqQR3ABSFaOEloIQ2VqVg
	 tRmXaPpO2wbKxmU30ovkjmQz4QzXMXql8gBWHUrkVyY6nsw3GCaJfjK4tldx7SrXP/O1D
	 73/WD5eGb0CIPDlK70nwlDir1c03uKchadI+hczSRaDHKxmLa0sDcvLItrrVsORLpIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GD8cM/PQRHbGn2UUNm++50l0YIJXlKxYUNCzt4H7SOY=;
	b=LGdkKuV8URD2tsptX6ANXjURIG/B/yCmrD6xWo3ARYcCxglO0Y+j9calTrDsUOzdSBdz
	 TZeTP1hcle60JZTyoTM+6O10I+iqHSrH8Sx1iyXg6KLy+p5MjPHuQzzqyXSuRwkP700Io
	 ekGIm03mrmf7lriq4+UbcDAHjjtdrYGAsk1aKSDBRYuoI1f3rwNYFRwC3KJW1EWbAY4wK
	 TfAngK3AceJbd2JgCIPZbb8wZc5vJCXMxMCJhpLkMzAEwAiQgjEo8TcYeHY+7EXPcZoIr
	 UYzZyLr4N6ZHBPXhjsJSxBWDzbzna91IGvVSmSlWYrOptV/07sR+7fcyiD0YLyTULBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Db96nCEh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279033;
	bh=GD8cM/PQRHbGn2UUNm++50l0YIJXlKxYUNCzt4H7SOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7SSSJKTD8GXsmN8AdldgBsWMDgFHc9FfyXG4W07Cil5FASYFy9CvRWUrek9Hw1iP
	 DnjzAvcIRVRT4O+oWSdt9k1eW6EBd4evGnoHhZvmHGXQ3chaDRbvJ99f/4B8/NffVE
	 I0IlFfUyr8CQ3oWghOIDKQrKpSPipO+goYkKQYSfceZZH/0LL0DVLeaoabGuAlx4L6
	 h1vyhO0YLuBeAGIfSmjXpCvN05yQ28r5MTicln5nwnw8mEa0uoz8mspqWqrzlTr0QY
	 vUGFM2tsO0mVGbzlcDLXli4pzAX3ojF3dQVL+9QbrjshL9KMFeNpfvI4aFN/VWtNPp
	 4YG4llCgjrxNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95302811E9;
	Thu, 24 Sep 2026 19:43:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69136328
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C48D811E9
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RcmbHI45AXI3 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 49509811CE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279030;
 b=XmqzTfQm/ZFNj23w+GJQ+VbVxsM/aErPQKiMUck4po0J8DqX4YjR5Try3w+VyPBCmE1f
 u1eIVJay/ev+76BUcLNWTC7j+b09m586fHf6TFIYUc+NiEBVVQCqvVN5MAN+FMZZfC7KM
 TOlN0D911gJB1WlKvvB1eLmED4jN5SneoMmv4dhtN3TwqLYGwm+1GZgiT/t6CeHLSjIE7
 Q1uBZfJYiogUUMbP3R9H32HLVqLGYrGcpcSw2GE6ESKJKCvMq7Fv5dbw5yZnbM6IuzDMn
 +Ms+aomczL3l+flVZGUUgkUnvVtAgAeDQVmjBDeHAbkm9L7kgPjUmKe9wow1yCetA7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279030;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=GD8cM/PQRHbGn2UUNm++50l0YIJXlKxYUNCzt4H7SOY=;
 b=arwfgwtsmVMFp9+EJGoX8QCsXQ8fslecjm36wgTh729oVpoupvDbFTa/sSwzfvhBSwY2
 PqyvUPNJ7ZhWqFE8ElpO0O/P3VUWeA6jF7Xii/HRNdnMnqfc8SKoZX4nHlLf1ApoQHMRk
 PcbOsgHt66cVFav/b50aoBL1TvYIZdBpeXyVpIzV9N2kU70uygMn/ORLx9qmrfwlG75xz
 TdjixciQ/9DCviA9Ba5wJ+qGXFMwEk9fsLJagAuS8UxtP7Q6CZEolQjbgEpdQNbJT8PRv
 DAut8WEDcAPQiCmBTGoM5QHWmF+x/9Y2h4fTe77bhM0ohqjFhAskdQLtKCgN5nMkuvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Db96nCEh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Db96nCEh
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49509811CE
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:49 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-801a8bf8112so67273a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279029; x=1790883829;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GD8cM/PQRHbGn2UUNm++50l0YIJXlKxYUNCzt4H7SOY=;
 b=Db96nCEhzz55cD1TY9Prz2O5Y6pBStQK3k7vQ5TqyusaCdGx5IO1r35foTA4rTaE4B
 /V97FJ8sCJcUZPc3gBhAB0l28pxx+QpNN11NnNZ7kPGSH96iUOPIbgbOoDtzNQDon0Hj
 taHzWFVzwI+1vuWKa8d4LxRptDj4zthlNAqzRZ5Wmc7LAEUezJn0byD7BXmAhLdMRc3c
 9UHbX8ntbqCEpx6MC0QifEWbpB7t9C3u6NmUaTKdn/xPEgXhZ+PnY85SGYFUjRe4aLWv
 r93sC4bYnCHeZM+oMvQII7DZwuuVYTzjW7ZkhBQQzyePNB11w6WCjxxMu68F64VubGRb
 Eu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279029; x=1790883829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GD8cM/PQRHbGn2UUNm++50l0YIJXlKxYUNCzt4H7SOY=;
 b=OT6DStzPG/UAkXVkpRrPb1K7lmjRQ4qRi7KWscTUoIB7qhDTNyXPQq1A6wIoItkPiF
 kHCiDzCeI4JZyvmhg/Ky5EMYBOL7Tq7HS75CiJw5gkximt1GhnjztX1n+3wa/P2AnZJ+
 eueFOBef/e0xzhYSQ+GAYKHhwt0k6gQD93oZ+J1p8TzJqqn8NaEKbSv92sV008PqE2Du
 W32xwNe5bidJrrSPJMmQPeFs3G1wvB2S4kp9PMEAGCeoGhnSZVD8B0ZHhBDUAQjDdabY
 ZRO/QIZwXAobff+rpxqMnPscKZVBaDZ9YrZSWrbEkZBlWSvqKUtMn9MpeiG8CyLOaM1j
 kh4A==
X-Gm-Message-State: AFuF++mv9AyrZ45UXKde5oRSC+RJ4J+SySZ0quqvXXxMUiu8DsnjntJg
 3vy/sKBqgvay8cGMiyxqGRLar/7CTEJ9h9jRtWJ3vytcQNxMVlwf0EnDWh/Qdv1won0=
X-Gm-Gg: AYBFou3tsybD5VjQRoqU+lKALL+8anA/Y2jAx3Y7tpiM20JGHnR8m/PNFIJi9JT2Tvp
 GQPN3yOWGew8cirgY8DKO9x8esx6gmqRm7nzZv8Ib6FaXJP4REm7EXh16mEadRoYsZDFkoASYn6
 0/YW94r0qH6ETpR3MBn/wIFGV3JAV00a5RJcdGxoWW8FDkKBeTg9Sch53ms4Gksjddu0Ve4r/iI
 9ZQW4iArKQJGXyk5bVnLf+S8nXVSJEMv9xQEZPtNXTH8GbIf+JaPiWWOeQDEhrf4Omed9hxVSgp
 fiAAu5cOYR0gSIwB6NJf8wRiH1xhEQKm1OLXEvTS+SWKNiEQ0Uq6yCRQH+RisstZrWRamchtJlh
 atMKNvHqbLeUWunv2SfNMLhzrSSVLTOyKOMD1iOIiSxPDTpGuugWuZIms1lIdEZTwnt/L+dNult
 PbsJJH/8WpBd/kurTDKne1LwbDtY3O6fL4fAW5vMazHZ0zDKDyLtRD0W7j+YvEp5UyQLQkZaxEY
 Tc=
X-Received: by 2002:a05:6830:498e:b0:805:620e:4d40 with SMTP id
 46e09a7af769-81782586263mr3800733a34.2.1790279028675; 
 Thu, 24 Sep 2026 12:43:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:41 -0500
Subject: [PATCH 03/15] clk: mediatek: merge the enable and disable
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-3-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8015; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nrKpgVXfvHbzYmrFds/PHMUYFJdNc6E/saKt15rULOM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0QqUD8GgN1WSteETlpYIicf9M1djtgM9yBS
 bJeIWKjhHmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9EBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqGEIAJXY2c3nUeGV1uBEYpoe18FHyULPLHfA5px/Omn
 oPK5MFi1tUSSzp6RpcaYyRQnlL+dCXmcaWg+wOVqgm+cGcTr5i+2NaS/D1UN8luJFxxr4CBgGDv
 A5bA1QSgbw4mBzoYlqabh4ns2ok7c4+pvpObscO7Q5+wTltnaypnO9/SoyIUVjwhvbos+16oY35
 k9Xb0ERan8s5miWrpe0BGwflqEwXkmB4GiP353AjdGNmLBMEChGecrayDhyNOp/F/xWNIB4ml/2
 MbKgcB6P/6OFTXZl7qW39JFGZ1v0bjn6We2hW3j/Q9dI8BlWjSH7QC4iDPAlghyNiXqWwBVh1zM
 LKPM=
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

Replace the per-ops enable and disable callbacks with one
mtk_clk_enable() and mtk_clk_disable() that handle a PLL, a mux or a
gate according to the clock ID, and do nothing for the other types.

The PLL sequences move into mtk_pll_enable() and mtk_pll_disable(),
and the mux helpers lose their own type check since the callers now
make it. The checks follow the order of the tables in struct
mtk_clk_tree. The order does not matter, as the ID ranges of a tree do
not overlap, including the apmixedsys trees that define gates next to
their PLLs. Fixed clocks and fixed factors cannot be switched, which is
what the removed mtk_dummy_enable() and the mux fallback already
reported.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 129 +++++++++++++----------------------------
 1 file changed, 40 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d93c19c74db..ac173dc48cd 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -195,11 +195,6 @@ static int mtk_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 	return 0;
 }
 
-static int mtk_dummy_enable(struct clk *clk)
-{
-	return 0;
-}
-
 static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
 {
 	u32 bit = BIT(gate->shift);
@@ -609,21 +604,11 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
 }
 
-static int mtk_apmixedsys_enable(struct clk *clk)
+static int mtk_pll_enable(struct mtk_clk_priv *priv,
+			  const struct mtk_pll_data *pll)
 {
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll;
-	const struct mtk_gate *gate;
 	u32 r;
 
-	/* GATE handling */
-	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
-		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-		return mtk_gate_enable(priv->base, gate);
-	}
-
-	pll = &priv->tree->plls[clk->id];
-
 	r = readl(priv->base + pll->pwr_reg) | CON0_PWR_ON;
 	writel(r, priv->base + pll->pwr_reg);
 	udelay(1);
@@ -647,21 +632,11 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 	return 0;
 }
 
-static int mtk_apmixedsys_disable(struct clk *clk)
+static int mtk_pll_disable(struct mtk_clk_priv *priv,
+			   const struct mtk_pll_data *pll)
 {
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll;
-	const struct mtk_gate *gate;
 	u32 r;
 
-	/* GATE handling */
-	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
-		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-		return mtk_gate_disable(priv->base, gate);
-	}
-
-	pll = &priv->tree->plls[clk->id];
-
 	if (pll->flags & CLK_PLL_HAVE_RST_BAR) {
 		r = readl(priv->base + pll->reg + REG_CON0);
 		r &= ~pll->rst_bar_mask;
@@ -763,9 +738,6 @@ static int mtk_clk_mux_enable(struct clk *clk)
 	const struct mtk_composite *mux;
 	u32 val;
 
-	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
-		return 0;
-
 	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
 	if (mux->gate_shift < 0)
 		return 0;
@@ -790,29 +762,12 @@ static int mtk_clk_mux_enable(struct clk *clk)
 	return 0;
 }
 
-static int mtk_topckgen_enable(struct clk *clk)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-
-	if (mtk_clk_id_is_gate(tree, clk->id)) {
-		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
-
-		return mtk_gate_enable(priv->base, gate);
-	}
-
-	return mtk_clk_mux_enable(clk);
-}
-
 static int mtk_clk_mux_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux;
 	u32 val;
 
-	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
-		return 0;
-
 	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
 	if (mux->gate_shift < 0)
 		return 0;
@@ -830,18 +785,40 @@ static int mtk_clk_mux_disable(struct clk *clk)
 	return 0;
 }
 
-static int mtk_topckgen_disable(struct clk *clk)
+static int mtk_clk_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (mtk_clk_id_is_gate(tree, clk->id)) {
-		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+	if (mtk_clk_id_is_pll(tree, clk->id))
+		return mtk_pll_enable(priv, &tree->plls[clk->id]);
 
-		return mtk_gate_disable(priv->base, gate);
-	}
+	if (mtk_clk_id_is_mux(tree, clk->id))
+		return mtk_clk_mux_enable(clk);
+
+	if (mtk_clk_id_is_gate(tree, clk->id))
+		return mtk_gate_enable(priv->base,
+				       &tree->gates[clk->id - tree->gates_offs]);
+
+	return 0;
+}
+
+static int mtk_clk_disable(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (mtk_clk_id_is_pll(tree, clk->id))
+		return mtk_pll_disable(priv, &tree->plls[clk->id]);
+
+	if (mtk_clk_id_is_mux(tree, clk->id))
+		return mtk_clk_mux_disable(clk);
+
+	if (mtk_clk_id_is_gate(tree, clk->id))
+		return mtk_gate_disable(priv->base,
+					&tree->gates[clk->id - tree->gates_offs]);
 
-	return mtk_clk_mux_disable(clk);
+	return 0;
 }
 
 static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
@@ -917,32 +894,6 @@ static void mtk_topckgen_dump(struct udevice *dev)
 
 /* infrasys functions */
 
-static int mtk_clk_infrasys_enable(struct clk *clk)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate;
-
-	/* MUX handling */
-	if (!mtk_clk_id_is_gate(priv->tree, clk->id))
-		return mtk_clk_mux_enable(clk);
-
-	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-	return mtk_gate_enable(priv->base, gate);
-}
-
-static int mtk_clk_infrasys_disable(struct clk *clk)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate;
-
-	/* MUX handling */
-	if (!mtk_clk_id_is_gate(priv->tree, clk->id))
-		return mtk_clk_mux_disable(clk);
-
-	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-	return mtk_gate_disable(priv->base, gate);
-}
-
 static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -1019,8 +970,8 @@ static void mtk_infrasys_dump(struct udevice *dev)
 
 const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_apmixedsys_enable,
-	.disable = mtk_apmixedsys_disable,
+	.enable = mtk_clk_enable,
+	.disable = mtk_clk_disable,
 	.set_rate = mtk_apmixedsys_set_rate,
 	.get_rate = mtk_apmixedsys_get_rate,
 #if CONFIG_IS_ENABLED(CMD_CLK)
@@ -1030,8 +981,8 @@ const struct clk_ops mtk_clk_apmixedsys_ops = {
 
 const struct clk_ops mtk_clk_fixed_pll_ops = {
 	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_dummy_enable,
-	.disable = mtk_dummy_enable,
+	.enable = mtk_clk_enable,
+	.disable = mtk_clk_disable,
 	.get_rate = mtk_topckgen_get_rate,
 #if CONFIG_IS_ENABLED(CMD_CLK)
 	.dump = mtk_topckgen_dump,
@@ -1040,8 +991,8 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 
 const struct clk_ops mtk_clk_topckgen_ops = {
 	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_topckgen_enable,
-	.disable = mtk_topckgen_disable,
+	.enable = mtk_clk_enable,
+	.disable = mtk_clk_disable,
 	.get_rate = mtk_topckgen_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)
@@ -1051,8 +1002,8 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 
 const struct clk_ops mtk_clk_infrasys_ops = {
 	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_clk_infrasys_enable,
-	.disable = mtk_clk_infrasys_disable,
+	.enable = mtk_clk_enable,
+	.disable = mtk_clk_disable,
 	.get_rate = mtk_infrasys_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)

-- 
2.43.0

