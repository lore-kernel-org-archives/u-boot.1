Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF32606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XlYVqk5y;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NeZoEq4k
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC7034058C;
	Tue, 27 Oct 2026 22:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZSvHS3-oU79; Tue, 27 Oct 2026 22:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F5AC4059B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141288;
	b=qJGKvJSsuS06ztK4FVHC8hVimmomCEjZX9gP+JYRGwQUSspAdJwtmeljI5i7pRwqcZiP
	 8e3k5mcCnglAOw818sCcWCECfD24kjHudF0wG3cpt0O6Q57Tqx4s76bBAP9vGrWgBMjak
	 Tot5nftE8grPzdJy6KXYfhwm94Fr1jqattQlbnc9CPAVaW/SUBdmXS53Xne43SMohgJBv
	 Od0vLaiRIrtZfG4JSf72i4pvRs5876kppXrG3+lVa1OohtUYrpu9XvZRIu75O3nRTlXUE
	 CA6keGjO2rOVw7yPJ+36iiMCoXYQ6lqtWTr7y1MYYzyyY6vR5+Lg+UuvqElXg3pOYgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141288;
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
	bh=6WQ7mT7G31+GK2MQ3wkBVXU2yL98eZ6uaVuigycK85U=;
	b=YozBwl2GxeNACYMZ+VKTyOe8RaTXUjljOndZw0wvFcd0Qsvq3cHymztOJ5mX4VS3rE7w
	 4nfub7zSJuj2QRcqddt4F4WR4iyvbRDAlQ3k1wMcQ6H1W496wOYzbAo1oClYou4jO511k
	 D3KHRuHW8iaeGr3vDLO8jrl5npWkLilTse07l8Vr3IrR+OI3YOsNutiQkF/b57mZhy7T/
	 1KnJq9Ir29uOy4522R0qsCw+CEMu1QIiEmLUwW3nWKw9vdduOyVT407Mrk9SSZfNqce0W
	 kqlC7JPI1Z0/mbaDoO2vkeGidX5x/+MqitZAS4RHqsoLdrbsJckzDR9UZG4b3nrhKEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NeZoEq4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141288;
	bh=6WQ7mT7G31+GK2MQ3wkBVXU2yL98eZ6uaVuigycK85U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XlYVqk5yF531iXNYOXw/s4ZVx+fE0HhPZL/OHApp3RfYJwe9gD7bfg/trCS3eQaT7
	 AIJyErAdISDbBMt8RLOAFp6kh2XH2XbFOh1ONPxxZXnUiMXAKEItCqPsBrkIKsw4kA
	 XsIbyxUqYtxlAjh9T6Sl4BB16Ki87ho0pMBhB+mCW37OaQqZ51jP9OyzHUrtuXva/M
	 pzLYrFbniD47ZYZtXkZmRQ0ks1GkAqxTDyr02tf7Qi9nUdJreCpGRIUT4KVlgpwRX/
	 9gBM9xxauF5NA6JyY4+Yn5rvKMNFZGQD3IFyipmfE2HgKO7AYP4pxUyJ4QA9zHQ0qD
	 O+qGjH/9xgrAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F5AC4059B;
	Tue, 27 Oct 2026 22:48:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66833235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 178054059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INOLncngt1-d for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:48:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BAFC740593
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141283;
 b=pz75pVncdHSEoglth0qylCZxJUAUOO6szIQeKpVL/QnckVK6sqLpQK4IQM9EHJSUAQqy
 sLNroLjtgwlbJYeXfQddUgcO84xClq1WRGOso3hQeT+pXo/PHlWHGL8+z0IikW1lPaE32
 pZuEhg5vajSG5ge0hIR2e0uvo9vj0WGBzcubJNkJiZ63IvW/ZYMXDPHsncrxGWNn0do7t
 zIOoQjAPKc0vvjvSz193n5jpq+9f9A3uAGIfTR+FLs5G+JWyjLwjUlwS6v0j0BPJN5YxS
 H0Iqo0H71Ova9Z1SqN6m/AvNVYB6/Yum2O/4XhN+rwTO0F0Nh2jrH3NSsylStUAr4nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141283;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=6WQ7mT7G31+GK2MQ3wkBVXU2yL98eZ6uaVuigycK85U=;
 b=Xu/atnMnCLu23ABKd/2rP9QDcY4QAd4xZNXGOiQFGTCUJ3FZLLITG9q58PqZD8hm28nk
 oSZZ2OuOgrIzP33PL3A62AyC8BwE9ZcJR+rXcq+eMksVjwqq9TyI3b0lWD+WrHZ8MP5aL
 zQzM4AGrTe8mekghW5e/ST1Tp9a/DwA608RsTCH8yD0fHxGJYlFoqA1ht6enai+AtO//8
 ewUP9c/GDcc+S2Fm78gybRSN0shCTnLqUzrPjta9727kVVRmN56+w5BSNaMx+YI2CmYWy
 co7PAsraPNihA0UudKJMVKevKYMIkrs1YuTTy+1rzwaSA+Yu3tqWoYPSfKvhvLh4lcA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=NeZoEq4k; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NeZoEq4k
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAFC740593
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1793141281; bh=6WQ7mT7G31+GK2MQ3wkBVXU2yL98eZ6uaVuigycK85U=;
 b=NeZoEq4kvMgOdIUF6kNj7WA9E3bY2bxUoKYkxX6sUaEGFXrY1HQRlV7LnGLDlqdY/sT85SG7y
 WQRBgZkMTletIBxGuHIcPJdcjV4zppQ9aW+kirSwEAg3DlFW6Rx24/yNvQajsyzkdNel8SW1Uws
 +ngPIoOrwtpWL3dHege81RhOek5f4P5bAduKsIxBRgaiMzWDBIs4tSpLUwTbmdWEzeifjrOxoEI
 yKwV9tDOKKN0zU8jH6ccwvX6BUuVwh1KhCnQvooJ9Znh4i2XXn/PJfpr/OK7wDgcKVYV1nqNiOh
 qL5V8wgfZwiKhCv4Td6XT/Lej4zjs0GpoyxBC6h489Dw==
X-Forward-Email-ID: 6ae12a1c61225291cb468a7d
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
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/7] clk: rockchip: rk3576: Remove unnecessary
 clk_set_defaults() call
Date: Tue, 27 Oct 2026 22:47:35 +0000
Message-ID: <20261027224742.2527550-5-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
node of the clock it sets up"), first included in v2020.01-rc2, added
a clock-uclass post_probe() hook that applies clock controllers own
assigned clocks.

Remove the redundant clk_set_defaults() call from the RK3576 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Remove the unchecked ret variable
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h |  1 -
 drivers/clk/rockchip/clk_rk3576.c               | 14 ++------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index 41e225245843..c9a4b1a47b6f 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -46,7 +46,6 @@ struct rk3576_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 1988f0472dec..1a2ac14b63a5 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2443,9 +2443,6 @@ static void rk3576_clk_init(struct rk3576_clk_priv *priv)
 static int rk3576_clk_probe(struct udevice *dev)
 {
 	struct rk3576_clk_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	priv->sync_kernel = false;
 
 #ifdef CONFIG_SPL_BUILD
 	/* relase presetn_bigcore_biu/cru/grf */
@@ -2471,8 +2468,8 @@ static int rk3576_clk_probe(struct udevice *dev)
 	rockchip_pll_set_rate(&rk3576_pll_clks[BPLL], priv->cru,
 			      BPLL, LPLL_HZ);
 	if (!priv->armclk_enter_hz) {
-		ret = rockchip_pll_set_rate(&rk3576_pll_clks[LPLL], priv->cru,
-					    LPLL, LPLL_HZ);
+		rockchip_pll_set_rate(&rk3576_pll_clks[LPLL], priv->cru,
+				      LPLL, LPLL_HZ);
 		priv->armclk_enter_hz =
 			rockchip_pll_get_rate(&rk3576_pll_clks[LPLL],
 					      priv->cru, LPLL);
@@ -2501,13 +2498,6 @@ static int rk3576_clk_probe(struct udevice *dev)
 
 	rk3576_clk_init(priv);
 
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

