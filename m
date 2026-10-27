Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46768606A320
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HOpOvv+g;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zE6U71jZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25B1980D0B;
	Tue, 27 Oct 2026 22:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id itRuWdacvQ13; Tue, 27 Oct 2026 22:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61C2380D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141294;
	b=REzpxHiuUqek0jCiErxdwfEtC6e6J6pNx/rzHogCDCZnLLM9dGwLwjRkMs4Dt5vmwxTV
	 YKcfWQjXNuUvg3AKy6DTc2ybY5wCVuuLFCHMkQlSJM6U/tKTAyKo67W+NpDVJbzQu6AN4
	 XM7eCDpAYSPwDokYWzPDt1FVlkJszI7HdNO6VmXiAsdzrIIu8s2m/gyp+ryUxdoOR5Nkz
	 VlTgEjnLchdonEv5yr8Bnr9Xw9nAiF/UpruvzXuqAlVtLsFfEeBi/dh4HJaoxoiCPht1F
	 G2iLKd87Gr8X2fdnIXXSAXrqmPTdEyzZm63LrvQUtNjBhAdVvJKH21JeLdxX3XPiCCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1dOBaygUmX/2NTdMVK07Zpt69hxsqGtY5/luxtyZHp4=;
	b=OxqzCx8673/tXVCG8CUq1Or8cpMFrv39t/XF6wk2kYewpLlpjB9+HT7AuHnckH5mcrpg
	 zTVau4bGhSnmEIHPfX4tP2AC84ovddmFaTHkOKG84MGoczelZ6KTATA/XWB9lndEG1OKy
	 N5iAbfBiVNkOHNZsYw/sbrupyADFj1Th/5IHPEbprZHrFJhzyrsd0jtamfk35qjnNxdi4
	 K8MD2Z5PdWz3PSwQG5jgmJRiPtLVHDEsVjueRchONFrDurI1LoS9lUQlWyO70bZkMa1Yx
	 Dbsay6Oy5xqbcNkzTmGtixLyfBn4HBvqwzXPI6p4UdY+rMIO1SRY3eakaKnUpPe+6vg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141294;
	bh=1dOBaygUmX/2NTdMVK07Zpt69hxsqGtY5/luxtyZHp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOpOvv+gVkYbupmUyrvS+Gp5MZkPnGf2SCgcaLSP3Jplehma4fmhaVLJpf0ZLwTvT
	 nQVCPA5OgvFmV568jQ3Sk33C2zGtkHtOfZUR7a4mDROfR7Vcj15StXdufIhw6DE7SB
	 c2H5TIV5pXh5QCpBUuY843qFrrvdRN70Wj4UPTiH0BnO1M8HqPBflA7HH1YaenOdAB
	 9fEeHKSjeMm/RSFSHIIh21MIXN+gJPKJdSeum0fZvO4xvfWQ1H2HYT8EvrZQ94RtmA
	 dcKhnEiuIAmjHL8TBcU0yNUU5oUl6yZHRS+1WQFXclLlBCBrtJF76hp+lfnd2EaLju
	 9fdYIcNQBz5sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C2380D39;
	Tue, 27 Oct 2026 22:48:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67493235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CD3840603
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3V2t2zQ5tDgD for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE9414059B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141289;
 b=cye2GPkuU9fPX2SAFS1AGi7IXSWWlOWjX8RIAvAvgqwTlVXEpq1uSHv3jpF0KmpHOxjc
 sEAt78ufUFaanZuLUtGi5zzY1fVD/yL2Ysa44e/y4aWGHzluwXZxAB+aSkmZ1whhflyuQ
 bYVjOPcQQem9LqJKw/HsFs+Brr4UwDPMKthYsvNsr4ALjZQNpNSfLe0Tc4h+l8lInond5
 oQ16F5u+qWvZOEGlka+H38xryBNTHNdLNrZgAnNOTvt7HzXv6lbnEXbxaXRh/4RqFgUx7
 YLpdF521YIP87TZFAmXYYt+D/Lug/cEnmncXl9oYLXxEtKf9kNvoT6q92ioT1oUUiJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141289;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=1dOBaygUmX/2NTdMVK07Zpt69hxsqGtY5/luxtyZHp4=;
 b=i0X1jtYfbiNiyyn22G1+3hxfOxD91QvYg8v/vzFm5aFsITXn6flm4JesieI6xrNwrwdo
 WRyEw55pgPo5BOszlbgcXbOTRp1mKKwuWJy7x7spldXcEErT8ntgycq/uKXiAqdeGfeNd
 DTTNaeNntRP89ojFW0wEQbnfe9o1IjCcwEifYSXZ/auVCPlsF0SbHtU3mu3CkkJRMD5+V
 Kr1pS6qiKEaDyd/5qL8uKQEvpy+CNn9jb2HFaIROmt/ShVXoYJ+JFiBVHhihN6A7EV5+d
 oAJ+9FU9j5mmXnsQ4dHweo1nXRm5HEiPN7yT5kvMBLkj7zusja6MXMu8hjhJzmDm7gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zE6U71jZ; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zE6U71jZ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE9414059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1793141287; bh=1dOBaygUmX/2NTdMVK07Zpt69hxsqGtY5/luxtyZHp4=;
 b=zE6U71jZkqVdIFG1+hcbEH+gjW8KK66glSaF5nwSsIprJD6CAhHGrYI3i8OEf94DkNYJwO0z1
 lgjKY13oIP9y5TT4RdKf59NoJDTtJSwb4R/JV15ThQPs9sckiBwnVf6skBBg8ILEnUt/YZ7ItzN
 wKHj5lYWBVa0dpUTawHb+XOV9xTsETKggMvgKPDoxhDQzFilOdZzsIU93QPrmo17rHW0G5zLMAo
 brZ4OJULBsUatL+Q0emWrDOaYvfvKyPI5hRRuwoV80sPvaBTjqCTd95Q9M8C9LMpF34DEIVPSyc
 WHGiYs42mtEHLDZPtrUK7BgzeUoV9D39iL9G9j0CSirw==
X-Forward-Email-ID: 6ae12a2161225291cb468aaf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Jagan Teki <jagan@edgeble.ai>, Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 6/7] clk: rockchip: rv1126: Remove unnecessary
 clk_set_defaults() call
Date: Tue, 27 Oct 2026 22:47:37 +0000
Message-ID: <20261027224742.2527550-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027224742.2527550-1-jonas@kwiboo.se>
References: <20261027224742.2527550-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
node of the clock it sets up"), first included in v2020.01-rc2, added
a clock-uclass post_probe() hook that applies clock controllers own
assigned clocks.

Remove the redundant clk_set_defaults() call from the RV1126 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: a25338aa896a ("clk: rockchip: Add rv1126 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h | 1 -
 drivers/clk/rockchip/clk_rv1126.c               | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
index ae273de31442..20e580a8eb3d 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
@@ -72,7 +72,6 @@ struct rv1126_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index 39920d34b75a..018232dcb027 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -1772,7 +1772,6 @@ static void rv1126_clk_init(struct rv1126_clk_priv *priv)
 {
 	int ret;
 
-	priv->sync_kernel = false;
 	if (!priv->armclk_enter_hz) {
 		priv->armclk_enter_hz =
 			rockchip_pll_get_rate(&rv1126_pll_clks[APLL],
@@ -1812,7 +1811,6 @@ static void rv1126_clk_init(struct rv1126_clk_priv *priv)
 static int rv1126_clk_probe(struct udevice *dev)
 {
 	struct rv1126_clk_priv *priv = dev_get_priv(dev);
-	int ret;
 
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR(priv->grf))
@@ -1820,13 +1818,6 @@ static int rv1126_clk_probe(struct udevice *dev)
 
 	rv1126_clk_init(priv);
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, 1);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-	else
-		priv->sync_kernel = true;
-
 	return 0;
 }
 
-- 
2.56.0

