Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4561AC9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CFE660BC4;
	Thu, 24 Sep 2026 19:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xwBe-8DWRW0; Thu, 24 Sep 2026 19:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4280960BE6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279035;
	b=GrzT2OhGIGOHN+KS+Hi1fhdRZblZH+GYyU59OicEHXQtcA7sMNXYsSV6GzduGkUOZo6p
	 o3Yp7FGEH1gNRgfwmlJEz+843EyoJVgJPHjsvaHEystFX4miYrXOb4f0LxkKk/VB6Zj0t
	 xvwc8owo8/y07Gjl8kpQRcEfoQOYFh9x1n9+t+ay5Sx80pgdlCTdb0FncvVoO9/r4OB2J
	 H16uzRTyXHGtILPF1ft3j5DXGI7W67s8teHnjb53dou2GVcG0eriqudn39RXjZQIGubUy
	 3AKD+uO+Vcev+IDEywuchRyRLVhikn5yZSb2rMthL5mDN9iBRizbFU/TCjAQmlgJciQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dVuPlJQF9RuHgAewBtICYTgV9KxMWQMu1Low3o/R3LQ=;
	b=iC9kY8hOtk2SsKRwTQVZRGr7jL4TEivVxAqOXf1ErfYhgFkhj0P3IkOnJW5Fq2fC1NrA
	 A+s3jXTeTfSCIcO3Tx12JYF4eFnJXb1DpC5pdLpVi9qEpJB2cbv5cShJBO9YEMQRGPqDJ
	 bTKtEfJdC77a3Ge6rCe7tf1yPcGC15O69ePKNTunS4ProeiImkSyZtBVBYcnKx5JF46BW
	 6bpMBCX55Zr01x6eKzh5RDyXqthtOhjMzCKMrLE2/k1LbUeRwAYiV4MzJP2LKXBe5PY4a
	 zdy0TRqZcOnURndMw+EPTqOjG+xVn7qTfi6gQ/wAD6XX+4PZnE5fhdu1qnPOnU5SMUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=C42YUjKi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279035;
	bh=dVuPlJQF9RuHgAewBtICYTgV9KxMWQMu1Low3o/R3LQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iiWWWzKYeMZU7l8gdGePfO+AjGGPffrtamlX2ak4EK0kODpfNsGCyObRPiSar+d7u
	 tX15gF4FkVFSPLxhmiMDg2fElH6SZOQIFWSXZmKPINT2kzHVMK4/F8QvcfVQQzEg8O
	 RyV2iVCKWMTjKV4A8kSXdFn1xhg9pqrAAtXCUNsWS0mOPCB4RlOuY5/yLaUPnI6rsA
	 bv7oFnUNKET3QV7mTT/aqPIjpHaE3ANtjfPFjRTS4VDmaa2Hc78EFlgzBs6tNCUIr/
	 IjczSTJhpMBKHcgDQbAmxTYL3w++sTHOGI8dsSeSKhqr4xqB6sP3s2Xh3aQYnCDEa6
	 cOQlhlV5IYWIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4280960BE6;
	Thu, 24 Sep 2026 19:43:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C026C2F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0BCC60BC0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HfjO1kKu55nr for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9CA4560BB0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279031;
 b=sUhrmsioszP35/RLNPKINsu7hKaxx/7MWPU/xowYWAvdo1KXLGDgQ6VbJSob9/8rLYnI
 LYcT53xGe/Ea2xB/CvtrKuKbKE9WqZBqPByB6S7kSwcUwV92XQLNR8hqcFtMseN53BJun
 tfiSwmANWvKzVjqftYFkCWweQ7dA45KO0XI3qjd3wNUKK2iE0ENbpnwQrNfXMYghJ+NT8
 EM4xJQzZ9sroMvg/w+hewK3Qnreh9Ak2Jdt6uQBmJtDqD3KESD5FXD2QokpGM1HajcDRj
 BioSuZYLIycgSoZYbI2FXwb140O0X8sioW+AHk47k/Sz6XV3rI2LtHWgET4NjVLZFdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279031;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=dVuPlJQF9RuHgAewBtICYTgV9KxMWQMu1Low3o/R3LQ=;
 b=Wzyo8HxOdOjxY4+nlslXySOkc7+TLaQkB3nYe1+fJku9c85otd6tqohTb5Wx5KiDJTv2
 GhTfoHxar3lnVIud0qDGsiAoWN5sA1jXpf/c8Hb99Ul0A8A2HHKAR3uMBQCDrbOTxd3z0
 v1kxljdEQKKec0T3vDNbQgZzrYqXhii7ORmyAh43II9NDQxpB7vvW/7sbCiFE8Q8DvprJ
 TNp3QcrI4wc/2C8LEo7GKJ2gYZNkc+HZBiEDtkWMuOkISAYBSlcZyYusosvEpyiJBden0
 WI2xw+KQWZp3epcC6kSEa9XSDqgpQ+iW71cA5btjS0XT/HZLTLUYETQll15Jlttd7uQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=C42YUjKi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C42YUjKi
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CA4560BB0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:51 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-805440319deso88014a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279030; x=1790883830;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dVuPlJQF9RuHgAewBtICYTgV9KxMWQMu1Low3o/R3LQ=;
 b=C42YUjKi+3M2SPG0lYi9rVPpYpIg73vPKU80M/DuYDB//BlUD5Xr7YWaiXivYaRKtd
 hk+smlTGTF+VdjgQ/FES7/2N7jUyeNjrMaZwOsRJin+qXAERJWUc7RY6lisEQ2S/RVIU
 PZolMq2SDupUEkqxTT9NBuknJFh87rcIl5q9DGr2ODQIEBDjs1JTLFZ8ex72cUaOSU2y
 2Lbhm9mpFFQwbtB7UsFg9iIuKjzWoZRpGhqB8co138O6UDl3N/iJv79upjxZ4QhIq9zW
 FpEJCNe4doiEppXVBeE7oq5yAC8treC7GtXp0UDZLcAREOgfBsMRQWO6JZ9PscHkm+rE
 OZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279030; x=1790883830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dVuPlJQF9RuHgAewBtICYTgV9KxMWQMu1Low3o/R3LQ=;
 b=gtv6dnLEghdMejh1e1H6i6mVOEezPNUokreWmc5ALOY89aoSYRScnd/zhjoodTKu8L
 3Jck8YAaEM5a+Fz8jygOV8xUJuGlOOw0oiQQVIrq0dDt6ga8a5nov7B5t4acBywWCDe0
 QTuDktRjglFethdqDQjwmlsf/wZpmwCd09EyfyNVO8Dh+B/3h79hUMkfKhxzDHE5V76K
 AeQdEe9Y9fSPBpnomXTwUhjY/AnWmAPHlaBMYMKHEWfYLASkE+gHWPlp1G0E8pQuX7wh
 p6/B7xas+WK8eGmqLbAthsWEY0YRWn1t3CcZ4sPXXGeJZ5aipMauNGP7HczK1y8M/xNF
 YWzA==
X-Gm-Message-State: AFuF++k+CdbBhODkY+FmujJGvQD0/+P1fe4EL1R+oTL7KZGsCiJDAwuy
 p0KoVxq8l9zMa+2rOS4o7R83U+c3EBC57rnX7o5w8PQmnvpRDLhemx4dfgCNkt6uEyE=
X-Gm-Gg: AYBFou2R6btD82fHjEBHsjVIXmr+gjqpHrDCaf86EQ2fQHh5UrTJzg2YQnHWj4J4zB4
 Sx48so9+5prHop4PO4fNgNPAv8R59jYDgrPXBXmiLiibCIPqvFnYJzJLVU1zcouIyHaX3zvr2fK
 hokuLLZQGIFDp2+CEBQBchCieroP1j4kC3uJktIr2S54XhFq7POj7e97Bo7pboZjzGOEJM171Gu
 lTU1J4rcxorIMZ7t0oxyrTgNNdijLlmrUrhKNYyepCnXNEipCNlQ2ce0x057flEhy1UBZkbAoyg
 45vvb2xh1Ar0uGLXOLTcApLsRWf83plIz/v2RdMX6ghbXBkOuxc0u1IDFKpADzTXskSz9ovV3h5
 BYgt90VM0QJ+o3dn/dZeYIACfew24FySN4nC2H9I4gRWsWHv6VeCUQ5kgZadfBVXXuujypl8psU
 a/q0GU8UXBR3yjAjXTZXioNvGeXDIpgjXOjhzj9DPFhh2KuFD/YMzjqtXSCqbMYPCPEMO7i1k1w
 CI=
X-Received: by 2002:a05:6830:d16:b0:7f6:96ad:36a8 with SMTP id
 46e09a7af769-81782984b2dmr3803012a34.8.1790279029993; 
 Thu, 24 Sep 2026 12:43:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:42 -0500
Subject: [PATCH 04/15] clk: mediatek: merge the get_rate callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-4-1c3b5d8744ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5784; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=uCzXbr0WDeghSh0xMp+7e4U4Yem5HtQKbpJUV2+Z22w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0W47jtydvAn44pPaCv7JTNrRhgmBv9jw4wD
 JDoAp9XzTKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9FhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEtwH/igVaSejFmfgjaG2hlrYPPo7B1hekL5Hvdocm8E
 CAfBqTKTksR12HYYI3ACdILj6p6xf+FJzfPOO/ibYUiQcPsUTZlmtUacz7VxszFW3hgUanCDYAK
 5Jgp4Z60/XYQ+9Jr7f6i1o05sb9dUxJcpNhhkk2TRgdAZahfsTB2OzFSxDV/83u2aSrcSNeX72i
 8DHz2ZXGJ5KyAlOxWvzwW3F6cphPfov1y8krpNUHFGfr/L6C2vz+UoNyMRbqoTl3L0EEDdjWTN2
 TZng4Garh/0CVaocQf56VPRyXQK3ZrefYTAkk1r9SFXoEwXkbMPZjmjuaOUVEYZWU5lRi5VuVj0
 FLUA=
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

Replace the per-ops get_rate callbacks with one mtk_clk_get_rate() that
handles each clock type according to the clock ID, and return -ENOENT
for an ID that matches none of them.

The PLL rate calculation moves into mtk_pll_get_rate(), and the fixed
factor helper, which the infrasys ops carried a byte-identical copy of,
becomes mtk_factor_get_rate().

The infrasys callback read any ID that was not a fixed clock, fixed
factor or gate as a mux, without checking the mux range, and its fixed
clock branch could not be reached since its of_xlate rejected those
IDs. Neither is a problem for IDs that of_xlate accepts, so this is no
functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 64 ++++++++----------------------------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index ac173dc48cd..6fb329ef7c6 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -571,22 +571,15 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static ulong mtk_apmixedsys_get_rate(struct clk *clk)
+static ulong mtk_pll_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_parent *parent;
 	const struct mtk_pll_data *pll;
-	const struct mtk_gate *gate;
 	unsigned long xtal_rate;
 	u32 postdiv;
 	u32 pcw;
 
-	/* GATE handling */
-	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
-		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-		return mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
-	}
-
 	parent = &priv->tree->pll_parent;
 	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	if (IS_ERR_VALUE(xtal_rate))
@@ -696,7 +689,7 @@ static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
 	return rate;
 }
 
-static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
+static ulong mtk_factor_get_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
@@ -709,16 +702,19 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_topckgen_get_rate(struct clk *clk)
+static ulong mtk_clk_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
+	if (mtk_clk_id_is_pll(tree, clk->id))
+		return mtk_pll_get_rate(clk);
+
 	if (mtk_clk_id_is_fclk(tree, clk->id))
 		return tree->fclks[clk->id - tree->fclks_offs].rate;
 
 	if (mtk_clk_id_is_fdiv(tree, clk->id))
-		return mtk_topckgen_get_factor_rate(clk, clk->id - tree->fdivs_offs);
+		return mtk_factor_get_rate(clk, clk->id - tree->fdivs_offs);
 
 	if (mtk_clk_id_is_mux(tree, clk->id))
 		return mtk_clk_mux_get_rate(clk, clk->id - tree->muxes_offs);
@@ -894,44 +890,6 @@ static void mtk_topckgen_dump(struct udevice *dev)
 
 /* infrasys functions */
 
-static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
-	ulong rate;
-
-	rate = mtk_find_parent_rate(priv, clk, fdiv->parent, fdiv->flags);
-	if (IS_ERR_VALUE(rate))
-		return rate;
-
-	return mtk_factor_recalc_rate(fdiv, rate);
-}
-
-static ulong mtk_infrasys_get_rate(struct clk *clk)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	ulong rate;
-
-	if (mtk_clk_id_is_fclk(priv->tree, clk->id)) {
-		rate = priv->tree->fclks[clk->id - priv->tree->fclks_offs].rate;
-	} else if (mtk_clk_id_is_fdiv(priv->tree, clk->id)) {
-		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
-						    priv->tree->fdivs_offs);
-	/* No gates defined or ID is a MUX */
-	} else if (!mtk_clk_id_is_gate(priv->tree, clk->id)) {
-		rate = mtk_clk_mux_get_rate(clk, clk->id - priv->tree->muxes_offs);
-	/* Only valid with muxes + gates implementation */
-	} else {
-		const struct mtk_gate *gate;
-
-		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-
-		rate = mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
-	}
-
-	return rate;
-}
-
 #if CONFIG_IS_ENABLED(CMD_CLK)
 static void mtk_infrasys_dump(struct udevice *dev)
 {
@@ -973,7 +931,7 @@ const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
 	.set_rate = mtk_apmixedsys_set_rate,
-	.get_rate = mtk_apmixedsys_get_rate,
+	.get_rate = mtk_clk_get_rate,
 #if CONFIG_IS_ENABLED(CMD_CLK)
 	.dump = mtk_apmixedsys_dump,
 #endif
@@ -983,7 +941,7 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
-	.get_rate = mtk_topckgen_get_rate,
+	.get_rate = mtk_clk_get_rate,
 #if CONFIG_IS_ENABLED(CMD_CLK)
 	.dump = mtk_topckgen_dump,
 #endif
@@ -993,7 +951,7 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
-	.get_rate = mtk_topckgen_get_rate,
+	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)
 	.dump = mtk_topckgen_dump,
@@ -1004,7 +962,7 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
-	.get_rate = mtk_infrasys_get_rate,
+	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)
 	.dump = mtk_infrasys_dump,

-- 
2.43.0

