Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4899ACA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 144BB40611;
	Mon, 12 Oct 2026 15:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQOTIq17881N; Mon, 12 Oct 2026 15:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45E9E40602
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817562;
	b=MUq0gEBOMXABoEpIYTQC71+QtfZGRG+n3+3E1+8Dt6gVd9eZl8sRT6ZziRjJDqv7xt/b
	 QYv6tGr7/w1askjNNxMH0ktI7mbU2hKCOFK84NiILu/lLT1X2b/QIFwOFGhw6TXonrfKm
	 q+MYLktrE0HQ5gP48nr5XeqrZtMAssW+lKxpxDDekFA7o8Ra9jV+doMlOy1ZgABGTcm4s
	 F96JITWAMNZUoUfUmSJYH4KBUsDVMKisoIvCavLUPiPQHSz9sjC96HK4F6Skn+IUBSd8e
	 rCw9gRs1udb9IwNmpbMQn2Us9piNu97PWZ5D5edJY6EvK3bjV2WbIBukyRE7+WO5h0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817562;
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
	bh=u12ZxbwAE/huhiBqVBkDsM7tM3exjXei9YAS8/jaXaQ=;
	b=fig3sontzFAUuMzwmVWcyj8aPBVOet2Xf3S4NUTk+KaV/hUqs+eVxEYJYcGXmpBrsyQo
	 KY9y9HQtxMMNC+5pQp3vEu45Y+MA2BfqKTuNz25x8ftJmukNqzDLHDGvGzXzVWU2iZDoa
	 P/aNmCDhGCWN2+Z6lu+emq7pq1DTJEOdxW6gsma95dW5LspGq9yZ8Tvbn7TWiqQ96efik
	 9iUUzgE27Yr+XQZV1kyw+xaae+zPFJQvJKgFFr5U5Q+XB/PlcorZLixsUVtjcc46te51i
	 WMJcTiYSsOSnHv9vgiqzzNI920E+p7R9jpFKGpMuR8BkbVPvCG4GPe4AP4s6PTVJhmw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817562;
	bh=u12ZxbwAE/huhiBqVBkDsM7tM3exjXei9YAS8/jaXaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tusLM6WcVT2fiEzUHMd8+ZQEG4Rqz5w9W3IlC6wrLj9OCIgbhO1LQkNgrY0mCbuqD
	 XcrXedmavOdHGI1hZeMjaahwYfnOA3jlYTb1aNCiuwPb2doAD5y8pf+DkYalevUbot
	 vHhDZ7x2hKZe9FLrAX51bKjY3Pjbmus6l3aLJJ+linc4l/B9qcHNBIpaAJHwqsO8r6
	 w6IUP59ugNl/Y0KHaqOurUHCAoBvuY+8LDirLAve6x1ITARLN5WjBrJA3UJ9fAuSAZ
	 w5jnSoBXFgCoZtXpt3yGGPjWG9netPE8ps90CmDSLLHPVvyyFBya16MKnDe0plP6qz
	 nMgNVFdCI4X8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45E9E40602;
	Mon, 12 Oct 2026 15:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4378156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 873B66067D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-z0GeMDJH_w for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C38A860665
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817559;
 b=L/b+k9GNvoFqQ5JNdl+0nIc5QQX5w4ls0Z5VxFv4TUwIhfWV5Z3TVHbumaSvB4ua0WUf
 Y29ydN7M8dBuEJNuTdtyhDaim1Ou8PYZyG7vxQADyB6bHVr8KFgkZBd/cjJ89sv5+zgs8
 dIxwCXELvxrRlEnavCqmsvmdsNHuz6pmPyC8s24v1+F7JDRhTiz+z4GVrlVx0XTY3eTza
 Jd9OiyZBhG7ZyYUrMmRBxa0VjGjvvz+/H7j9xE3Hml4iFSb0peahq2u7v5d3CmWAYZSSB
 /kRcyG9sFxdFmWwP3zJknswNWKoXJUBeANlF3FPdD4vZNfI0a1jJBQtuV8JR8DjsIcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817559;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=u12ZxbwAE/huhiBqVBkDsM7tM3exjXei9YAS8/jaXaQ=;
 b=gRDD7/qlKNx21Qj6wy5h89/lX1DlqD2AtqLM/474qu+ME4TmTXKfHa6p5oc51Ch8YBpl
 IFXnBL82zJA0BtmBJNoddYMt31fmMQ+VLKvNcPxkV6VfIKPtkunY+6sUHVbxol4Xz6rkV
 CAovWiuQsRowQc8ttKOCnzVygKUrpKfFqKhjc5gIcdblXzP6jm0S/pmYDAUlxd6GkknnN
 p1LdDHKSx4VJVQIdioS/2P4EgxapSNr/gen6+ygKSKGDpjv46ZafuO7qa4XC2g8mZpJyn
 lYO9RzOimFTXp0sjmMaUF4T4Y3B1qGMpLS3RIVMvmctR1r/X0+3uA8zmIPbWbaHOEmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=T8OBUWJN; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=T8OBUWJN
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C38A860665
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817556; bh=u12ZxbwAE/huhiBqVBkDsM7tM3exjXei9YAS8/jaXaQ=;
 b=T8OBUWJNjj9oXSfWXOM7b7JkXclHPbMTIYB4o7rB6ahya9wVkP9gYthN5wM+yNbNF09cNPEM7
 CkcClPNblGW2WMVI2CPCbW4F8Ksd1RwbydfzeDGKogV17IqP6/BJk97NzGt8Wzu2Y8PCNPNfqv9
 Aw5aEPEBsvbxGz7UpYbKnizQyAPSSVCp58H3cYFEqIncxljMeYrsJDtqmvxZwtxcRQOQ1LlzAne
 Uztth2x2IaoENsc2RDobtmZOusLabxXYay02PpGf1vgGhNoAZ5lyIUCAnCaWoqXdfj1yVnpb4wL
 8wZNy8jkrVdsfmn/33eC8miuHVLdEh3Fy8JL7qI9pw2A==
X-Forward-Email-ID: 6accf7548ac7302d53a2c913
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/8] clk: rockchip: rk3568: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:34 +0000
Message-ID: <20261012150542.1182209-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012150542.1182209-1-jonas@kwiboo.se>
References: <20261012150542.1182209-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
node of the clock it sets up"), first included in v2020.01-rc2, added
a clock-uclass post_probe() hook that applies clock controllers own
assigned clocks.

Remove the redundant clk_set_defaults() call from the RK3568 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 1 -
 drivers/clk/rockchip/clk_rk3568.c               | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
index d72f241d0150..8af2c5be1ba4 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
@@ -53,7 +53,6 @@ struct rk3568_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 5a05f1b4de00..2b055a5cea81 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2866,7 +2866,6 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 {
 	int ret;
 
-	priv->sync_kernel = false;
 	if (!priv->armclk_enter_hz) {
 		priv->armclk_enter_hz =
 			rockchip_pll_get_rate(&rk3568_pll_clks[APLL],
@@ -2905,17 +2904,9 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 static int rk3568_clk_probe(struct udevice *dev)
 {
 	struct rk3568_clk_priv *priv = dev_get_priv(dev);
-	int ret;
 
 	rk3568_clk_init(priv);
 
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
2.55.0

