Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA42606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y3aV9ULF;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=hFkoC1uk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45E4880C88;
	Tue, 27 Oct 2026 22:48:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqI4EE6UGaGM; Tue, 27 Oct 2026 22:48:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 900E380C95
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141283;
	b=PzQYORbsX0E8lIhc6TWexxFtkTfyv1VVYqXRqW9oGkyHBZbm7OOX9MyU0h9bUrCKAdC6
	 919Ingxf1HmnkWyx/yvPY35MHTFQVGLqwNc4metULxkJc/jC0eD7UHtFS4OoLlcRnXi7+
	 3bL/vbCJ7fqu/gCUxYSevNeukTj/eJCaMsFfYsf2rZxF0Y1ZP0hg05MBJjPrhTGKXIxaH
	 yV9H4dBHr3iDPAWQ+s4krjyhTsb6sL81pV9b++ax1UOUCmlKYrSnxSg5RK36q/5SDgUas
	 ZCaJ8u3K9geSj9+ij63hS85lYaWr6j7CLfSjyxYgATdaan+2OEosR0CM1jTM4WM1E2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141283;
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
	bh=Fq9wAvwnngE2b3ZWW1Z8W6kYSJBKUVkyD+39zedtUnc=;
	b=kELxpw1woHs2A7/x11/of2v0p97aI6oy1ZN69Cxc4JPjv/LJsEv2G3Pld91hB1zv/sgv
	 gwl7aFgU+/KXKaKgEGPRPT785ZQPvltTdbKgY6ejVVx8NXp1KRFULAt8MVAh6QBGWYrBK
	 TiNrh1PpckFt8sHsVKeuxPIuB1GU9Nsq148Qmoj4fx0psyRrnqUQM3slcPUAnMdHdnH9L
	 8bR+3kQQOyiLIuj7Z5nVVw6Q9rRqYAsTMRAFsdMOkdmMQcFI18NKfZyisMM0/yDWxCNH5
	 URhp4PVsqiy4sNwP29IYJU8FiUzCCVyC0cnjwtXYPaOivqk8zLyp4cOp6suxlHsIx0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141283;
	bh=Fq9wAvwnngE2b3ZWW1Z8W6kYSJBKUVkyD+39zedtUnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3aV9ULF69ZKDkH+W7HwDfIViSkSTr7TZjLcoSTeOD1jsOpFSaDSpj3jow0WRufq3
	 UlfgO6e/zrocZqRfhXCY4w4rExQFCUiqZ0/PEBL/Ss9WfYTS1fZkCsC3jY4aNHshig
	 Uety9mCUq3wtMk4kIFAS2jXV/4IQUg8Wp1VMZgrfqDmf41IyoXsq8Y8U1w2MHDZnGe
	 vo7HjhKJjQook+wKIJie72b8B6l1MX596YUL52+D2VeCF4dyee/n5nvZR+p9pPy1fB
	 cX8hXiixg+ZMi8gLvf94LCN/G3RKy923yqu610aZDU8lHxM4ZIZzvur6cFowsoFeky
	 LLlNgAzaNzlmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 900E380C95;
	Tue, 27 Oct 2026 22:48:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19861729
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0016E4058B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CNQL-HA1DjT for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43B0540589
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141277;
 b=TnrGXNiHkwz22Fe0UlZEkCte9Xm0T1+Hu1U1dzEmnFAwutORVT8HxcCCw5DSXw/Uwouu
 e+ZMoxJw/EZcKf+XqeK/KY1gv/Jmrvdzy3HpefwOeZhypfG1q8ObpZ5VOu+AwqqrAusbB
 KHKTef6QO/9qu7scVz8Imt2cofZVi/fuceZmEehoB1B7H+fXPwWz7ltLGIrpzsNwgyzbb
 nOqhib6nf2qj0CxmvxncDuY1OVTjHnB7zVtGxFiManyL9ptYoJUOe1J/G96/eOUqJNzhY
 wNyTOfKAEt943DI+TjGhngWvhAjoUtw4Z+36UHdcQJ7j7DyCLu4qdu9cw4JeOJvFLhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141277;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Fq9wAvwnngE2b3ZWW1Z8W6kYSJBKUVkyD+39zedtUnc=;
 b=Y/SqM21apHLhCVDsiCBt2NABlLVpY14OyePHKkKwNs3QQjuFO8BsENF2iA1hbvGlfUlA
 ezuEG8UPivJ/WB1YYmYelSeeIU224lEblPLyb1u22c5JmAu06XHKtHTdTyW6QWqXg6t+F
 Azpa3Hurla/+dC4iOUSxYgYfP/Qa78JECJ06K9/VVk3CSvCNFrN5oM5nc6Qzo8gSdoQxC
 ZIxLYLZwL+ZmAiZLc5PPxCkieik79YGk2TqR/wTqyWIMjuKj95kL/0Lvbi3qlKNkJ21xI
 zXpC174RfJTvv7S2L1upwEUgl5DzUKDtx1oBZbahFWkiM4iu9irOwNSJocVXKiRd2hQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=hFkoC1uk; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=hFkoC1uk
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43B0540589
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1793141276; bh=Fq9wAvwnngE2b3ZWW1Z8W6kYSJBKUVkyD+39zedtUnc=;
 b=hFkoC1ukiCmTDYQfT2NYfkMj2gWozfTJBgiDYP2OBf15XZovzRULWe8Yjv3FtkuArWmpVdCFE
 MnjQq16W+PRkqT+ibRqj9xlHaHdnvDEBnkG3JDNFO7LDr2bO/rdtr7M6oS7P8GEYXWRm2SvQddc
 Bb8R2ETxzwqo7yKoi9n1iWh7mCEzneEsf/GOXZsij3eAs3imt88/LpkVo5nA2FCZHYLWDHYxTFT
 O/a5kxbI1ORpk5OWl3d9kG1QT9ScxJ6NosLUPA7XP4n595l81D+DYUgUqAZPOVi3h4zhK3RBA3E
 iM8Z/LK1k6WiwnCFtQJvPyW4ftbQjWocjh8fcXxojOKg==
X-Forward-Email-ID: 6ae12a1a61225291cb468a64
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/7] clk: rockchip: rk3568: Remove unnecessary
 clk_set_defaults() call
Date: Tue, 27 Oct 2026 22:47:34 +0000
Message-ID: <20261027224742.2527550-4-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RK3568 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
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
index c3973215c37e..fd7e69ee338a 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2873,7 +2873,6 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 {
 	int ret;
 
-	priv->sync_kernel = false;
 	if (!priv->armclk_enter_hz) {
 		priv->armclk_enter_hz =
 			rockchip_pll_get_rate(&rk3568_pll_clks[APLL],
@@ -2912,17 +2911,9 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
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
2.56.0

