Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0A606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y/Ffq6e3;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sYY2Sc5f
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2073480CF2;
	Tue, 27 Oct 2026 22:48:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9YSilu87fmL; Tue, 27 Oct 2026 22:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 490D280CF1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141286;
	b=L6JsWu1mP5CWR1YTCNyid8+QrrOREMt/8orwkrx537O9jmzCmJ6NowWo64k4NHQu3qoU
	 7AZW0DP80Ek97c7tTFybJbEGSoHrwz0C9IutHt9WJa1VG68fPfWZf3wa1Vfw3RcgmBYQ6
	 FGvA/nsdX68/SDg9VLNlZ0wjBxGGrqMxgxSpRpf24utk+LNAwxB5uFVkDvx7LXCEvwVx6
	 9hq+UVYjHluVSDSoYVivFzceCvdgyAMuUssVB/fDQIeJSk0JA3NK54IrL+cfKt7VhXjNm
	 jMZ+Sq6w6r7Y3mhRhXla2OeaG3sRQBvqUUS9DGgakJQYN9lSdiM1Enz8BxA/25JDZTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141286;
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
	bh=4JiKOhujszwSHAXIembRIZ8AhXOlkxdZh+Vw+ZfQ1WE=;
	b=HJWX2ORH6PZ43FrYr775t4Bx35wnfKt6H9mQfEjNVe/cn2SB+l+t9O6Q5T5j+PrmOs0Y
	 wDZ3XQZeX2UB8Oz89qpVz2/ms/mH/cIrQy8LCbhgqesTqgjh9bqEGoymI85w+wqfIVa7S
	 z10l/v6eikQxWnmpqR9YFom7saWb+ZtEjFMM4HEw/4zNEIn7XnBGjQOG+qkWNIoca/7M5
	 k0OR3VnTOF2GsgqEHkhNLlMAdi5tm1r0eykqqlGEhfIJfyGhdMBlmRBVF0T1IMqN7Xzob
	 uhFcEquQ0LaKSLlEsjrH9d0ezTVV3BYHFONeE0MDnDdFmlK7U9K9w3ML05GjutRpxPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141286;
	bh=4JiKOhujszwSHAXIembRIZ8AhXOlkxdZh+Vw+ZfQ1WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y/Ffq6e38i5UYkCOUK50EyczlPwsdln1anyAXuFFvWfNTxYiEtU7E0iK0P3dWDQw1
	 q/Hr6onxRAa3QuwSp80ebxOE3f2C124pr8eBeAOGQEtMqU0cR684nuJWzAc1vJaYl6
	 IHL/8FVMnro423lGd5eA18FzLN9cx27ghYajtMzk3mdfiEsyQOmhzReYntQE1ioEp4
	 4rMLRbaqNoXiFCyO85ODcSGnXyc3GiBdMZovq45FZVm2Q+VYIPrYh673aUcJq5SNed
	 5GWzaf7rTvycTQbu8tOc0b9u7SC9x1MtcQfrkripOCufMqKCuCS8O7Uhlobrp/ZIEE
	 nAm7HFwpDiTyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 490D280CF1;
	Tue, 27 Oct 2026 22:48:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28468729
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A14B4058B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sr0vwPZpyzGe for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60FC840589
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141280;
 b=tNF+lQg6Iq13+iaRRnfSXKUK9cUw524pZRKL7xsbMA+ly8wbYrwDQ7hfCv3vSDtKlL54
 APhxANKFG8JtIXaxzBF1IVyvWNxe/IRqsdbKfCH2rNQy1S+euVEILfMtjfxJpPsiFiamm
 vMAVAlmTo2x6tfT3gJpKQreAzHa3v/jQYhSy397IE8n7Xvn60+4zC/zI12uYuOpcVHaEQ
 eecj5pVqBJAcYHHdXGngjnUhnsfGZMRA2vk0l8BzrTZIqMKgZcLZYLUGjcrfNgn1tKuD5
 vsbgRh3DW6TB4ULZYhpv+oY0gEaAmYOU/Agirw2cAv+zQqUaBur8Y2u2htAWaaebnsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141280;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=4JiKOhujszwSHAXIembRIZ8AhXOlkxdZh+Vw+ZfQ1WE=;
 b=JsTi4Mj6CV7/j1CD4TfL+VjZBCv6EMo7wUb2z87Lg5QlGVbM+Jk425E4sx0O/sa636zF
 F2kB8y3jDvXzRJhaUvhL0Y0AHCBuG46V18MVD128t8JTSM4ahPhnDdC6qIOC0PVGM0CqT
 5WMu2zak2SsV7rxXUSnnrGagYEUIUPZi0Oesbb+CyQYMLzZmWb5QaUwoEDkXmOr4OQWWw
 3a1Z4wkiVBwlI6i32s2jnFUO29lwSBuKGS79ALvZalY07TKcjmX4kr2C0YXcy2tsR0jxd
 JbRfI7FqXyQc+I/c16vbuvPSpromMqsybhSlq1F2b9FsF8tzVW5H/t35SAoblckFscA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=sYY2Sc5f; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sYY2Sc5f
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60FC840589
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1793141279; bh=4JiKOhujszwSHAXIembRIZ8AhXOlkxdZh+Vw+ZfQ1WE=;
 b=sYY2Sc5ffuVC/26rfcZMZ0dRTsQ/PtFqac9s7vHi2DqvQh7sQWAYKHE5cSaM3vVxNR5xK3dzZ
 J3wzLp34XPkeJXessERkGeLWpDgzVmADRkTbNamONI/sWOYBOIZiAeG6hpr6LJjrL+G62a4C+JA
 JXJ1y/daHV0YLf2v7tK35tsElWXxulkKIh/woUSHmh3SzRfNHKV6JN5ds1VXnPDL2Ilil/5FHKX
 1QQirNbur67wg8k5FGpbhgoYW7480e73B0/g1xUbc1NFBAHsJnHbKgQu7+pGv+Sq5xxX40kus25
 qR/TNSIkU+KflmbA8uieTRIhNxxMZMaZvQfPksu4isjg==
X-Forward-Email-ID: 6ae12a1e61225291cb468a96
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 5/7] clk: rockchip: rk3588: Remove unnecessary
 clk_set_defaults() call
Date: Tue, 27 Oct 2026 22:47:36 +0000
Message-ID: <20261027224742.2527550-6-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RK3588 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Remove the unchecked ret variable
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  1 -
 drivers/clk/rockchip/clk_rk3588.c               | 14 ++------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 85cc17840436..1058fbc19dc2 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -50,7 +50,6 @@ struct rk3588_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index fe3fc695c15f..f6144d1f96b8 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1958,9 +1958,6 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 static int rk3588_clk_probe(struct udevice *dev)
 {
 	struct rk3588_clk_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	priv->sync_kernel = false;
 
 #ifdef CONFIG_XPL_BUILD
 	rockchip_pll_set_rate(&rk3588_pll_clks[B0PLL], priv->cru,
@@ -1968,8 +1965,8 @@ static int rk3588_clk_probe(struct udevice *dev)
 	rockchip_pll_set_rate(&rk3588_pll_clks[B1PLL], priv->cru,
 			      B1PLL, LPLL_HZ);
 	if (!priv->armclk_enter_hz) {
-		ret = rockchip_pll_set_rate(&rk3588_pll_clks[LPLL], priv->cru,
-					    LPLL, LPLL_HZ);
+		rockchip_pll_set_rate(&rk3588_pll_clks[LPLL], priv->cru,
+				      LPLL, LPLL_HZ);
 		priv->armclk_enter_hz =
 			rockchip_pll_get_rate(&rk3588_pll_clks[LPLL],
 					      priv->cru, LPLL);
@@ -1979,13 +1976,6 @@ static int rk3588_clk_probe(struct udevice *dev)
 
 	rk3588_clk_init(priv);
 
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

