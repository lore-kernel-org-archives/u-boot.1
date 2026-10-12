Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C54CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CC22605ED;
	Mon, 12 Oct 2026 15:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vmn14NHYbtrT; Mon, 12 Oct 2026 15:05:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 893CC6064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817558;
	b=bmkjY0txFCODiiDS/UCxR2uHOVhGG2yLiDtPQxOuBX26ioc6RFSHjYOLg5V3da/KgbVA
	 bahvvn4CMgawQZA15m2p2GV24d3ydnt2Q9KtmORID00ganIWVG4Uv72z+YjsjSB9t9ZWT
	 oTUO0GrUtSAnp9MhyCaItQ+sJAZGqKuLkhvpaMW4r+8slVviVJGoBbY9rgMCEhnrpLZr0
	 Sw5lfzmK7t4CYb0OOXskPtjBLB/UPjiSk7YnsmTx2uKc4mTWsQ8GZ3KRYdVUpfhMl9LEI
	 bN04fxJGBiEnzP4G/pdVzmIB8wsXHe4ZjjXWEoR1AgUHpHDEkmlLWJsO9bs7RHyJjwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817558;
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
	bh=uUnxVAC3kvqhd50ys6UMcipgXhoFpf1wrcSzvx+Zr/o=;
	b=Gg8Jr7pazZr+d0pntdDXCetkaMBLanLSr2UK0gLZBKLuMxD5dboXCkXZQD9LNiHrhMA7
	 TCHZqStpozezA3jfdroNq7hVKW0O7h6Poha/mYx4Q58X8yUzm1gCgupq+jOKMGfMdn/g0
	 IFJhEAjVtS1ELOWSvYwTSsInEg81yu1QxHj5NoInPoAgcoZv7ddKafb389DzEdBkEW3vq
	 vnAEsOtIv1X5M7MK4FEbz1rKRkJ6Odw1Z7l+ofWMmj45+W6aJ82PTtVKuXOH+tQZRvOr2
	 LIY6jmGOosllF/DcsMkw7oVZf/A5saYA2DN6QGD2O0sMQY/braaZ3K3oH2wDfDrUPZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kdVxFCaz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817558;
	bh=uUnxVAC3kvqhd50ys6UMcipgXhoFpf1wrcSzvx+Zr/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B5KOl9Y9qMKfQt1rgbZZiidL1xf7t6Sh2iHFLBFKjuk6Bxx0/0yFawdkWtt9g08hO
	 nIPt5ElnGi+fscE7ecbM0cEgYa8MIVytFaJMOaqcGUTR0VNnDrHoVGfrOF0OdZLcUa
	 DVgz6ITAtjpejgJhaivvDMcYvYLDdDeegbw14c4Biruq292jJqIe2c0RrqWZaNgIvJ
	 q8aL6TwNLXb47oI1WklYUY51i2HsUb3SgPO+cEcgTHA+XygCigP9CiXs/VVFl0cwLt
	 K+m5JVVR7ZXBYUqH05SHmSLX06JxumkAKTiMYqEDa/PyAVK3gma+vAJWa6lzMOHR+r
	 ZxRNAbULKsqTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 893CC6064C;
	Mon, 12 Oct 2026 15:05:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C6932105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABB2A60665
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYLuSWgaaEEq for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CCEF8605ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817556;
 b=rQARG+cMJNT9ZkgbNYdxB2up2IpiW5co0WRMpdouzYTe8hwO2bExurRJoxwt+0Qo3yf0
 Ed01KXwp+0qOXqrM8WVH+ULJz6Y90q52oJgRuQbxu1yR/Y/BORvbjhj9Wuo/KhivIw10i
 Ez8uYHDo/E+AT8KAuzmVilDSxkhppsm+VuuIbXj+6qxn2qkA7PSiEW3zvls7LfO9JhQol
 jmntWn/MUCBgCVJilUY2jY4Ll6HZyOJOleWwoEpg3KeArU845Trpc6H64h2AOUeLOPNgL
 4nnGGsUmJeCmfszxRB0KigfoyrnLf+SP3w3LgA09TIvqI5DmSQ81JRxjiBEj2Xo28DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817556;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=uUnxVAC3kvqhd50ys6UMcipgXhoFpf1wrcSzvx+Zr/o=;
 b=l7+Fa3HcCDTRsFd7zaVoH68ewQeOqhA1F9abCXigK1WV2JapqHxBN9DH70/W0epAPYxq
 QDtFG68lcE/38vwAYIEAJINm8YSdmaOwhQoYfOHs/vj79XIUlgP97U8pBsllDbztm4BQX
 7Zmo8HbpTXemsff4/YCTy/S5f2beQ+eiBI/pjf/Emb40YF7duuNOhmTbdmTW+p0dXGMwT
 PembIjqmsJeAEjy+9iG0cpbkaLEM+9VN9mheqABzLarOnv66OCnKibDLPCsKNSzAJBk0v
 XFHxPw1N4B0eyqOk233E1Fg2L39Dmw5QO8BenDQSsRag+R3/1pSzLGPuxiHk2XbyicA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=kdVxFCaz; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kdVxFCaz
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCEF8605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817554; bh=uUnxVAC3kvqhd50ys6UMcipgXhoFpf1wrcSzvx+Zr/o=;
 b=kdVxFCazwrxXYdC5IKEHFCc+MlKQWhtQ5cO4X6t1su+dMwOkpnw3xK/ZBozazvVkRaPkvRKIO
 wkwQlSMVyagRj4511Xdijtvz+Q44nyjJOkfsFxLrCeD7a0T7rzAiYEbCTT4OCGjag2eiGDePkFn
 /2XokT+YBUIS5A7znfy2Qjouo4Z0wHbTmI+mNHa4I4ENIEZurUdvl5Aeqyl6COjBF4ee5upzVhc
 vo7kubdYKhrTkcm972OT5HjEtZtdzNJ1enfxm4oTGcI8Gu2BrDUPWtIi5vYkI2oIxzN8nyP9hwH
 xZRXZAB5o4eGV491GHdU/jfmEAjF8sCwVvBeBKxkaRKw==
X-Forward-Email-ID: 6accf7528ac7302d53a2c8fa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH 3/8] clk: rockchip: rk3528: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:33 +0000
Message-ID: <20261012150542.1182209-4-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RK3528 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3528.h |  1 -
 drivers/clk/rockchip/clk_rk3528.c               | 16 +---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3528.h b/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
index b4020958a046..64af04b0a97e 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
@@ -35,7 +35,6 @@ struct rk3528_clk_priv {
 	unsigned long armclk_hz;
 	unsigned long armclk_enter_hz;
 	unsigned long armclk_init_hz;
-	bool sync_kernel;
 };
 
 struct rk3528_pll {
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 976ef0e0a919..ee4284d65d03 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1602,8 +1602,6 @@ static int rk3528_clk_init(struct rk3528_clk_priv *priv)
 {
 	int ret;
 
-	priv->sync_kernel = false;
-
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * BOOTROM:
@@ -1684,20 +1682,8 @@ static int rk3528_clk_init(struct rk3528_clk_priv *priv)
 static int rk3528_clk_probe(struct udevice *dev)
 {
 	struct rk3528_clk_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = rk3528_clk_init(priv);
-	if (ret)
-		return ret;
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, 1);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-	else
-		priv->sync_kernel = true;
-
-	return 0;
+	return rk3528_clk_init(priv);
 }
 
 static int rk3528_clk_ofdata_to_platdata(struct udevice *dev)
-- 
2.55.0

