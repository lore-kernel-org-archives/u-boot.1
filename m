Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DC606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xvrwrQDs;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=qkBDNOxA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1BD58110F;
	Wed, 11 Nov 2026 23:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkyClVkHgmDg; Wed, 11 Nov 2026 23:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4F0C81144
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438787;
	b=iNyA9xKRL+3Cpu7svOaMPe1pVz0xojPQoRhhTHmp1aNFPbPENdd9FNhgKY49Ux0o2keY
	 UHjqsuXrRaZVlG2TSuRZzoUIfS+9cUEKBpaxTJZy3JJ7uxsycg5xs2pHJpnFx5YaD/8M7
	 fZ30wvRuv3jfMOB8e8DtzjmnONefdF0wg7zmMZgG/jHFXyBNs5aHHUD2RmpQxhPV5YAAW
	 5ey4KwZdjgfY/6lE1e3ww/qzrLtnJpL2xuqdWv5dExGNnooc6VhVLFl5VMmDM56IGiKh6
	 c9XmooSIWjPYv3FacU8DtlsmqaTHEJaeBs2ofQmuEGXjKDTD2SEHxzlxOhzl5pHGpbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438787;
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
	bh=pIXnn1aOwjBY7IXEP3EvYH6+zhsU0Ysz1WK8MSwEaZk=;
	b=WpIZ82xN6us6D2U9MoFelQBysSqEs/4xwCJNjkjrdIrdvYPjfhCTSXmkZisxEP66VOSQ
	 FUobcKGUJWfitbt+LuCc0CYCCBPZAW0q9JmQnqRcFV8z7720G9HkXmLHoToc8aGnSTO/i
	 WMeMoz4RWXjQ+VRKe/JjBpZpUHEM2mCU389yc223NhKyUpjiNX9FYXiidQyHyMpFRztP3
	 pj5f/1GiyRb6b79lfgIMS9wlZqBElICeGJ+r5TpUUo+CWTkxV7T5n0Pl6p2nLhlidvjnQ
	 emMiuDjgPTIyrhRHmC/gRwI8ceQHfJEqD7Ntaf56cqRzv0MCdyLlCDugISDealq0CjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438787;
	bh=pIXnn1aOwjBY7IXEP3EvYH6+zhsU0Ysz1WK8MSwEaZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xvrwrQDsISKMyGLyt1btlmklKz5SVqudaSz9brdATnVbi2jpXGYKHbbrkBp1cG/4J
	 db1W6Eq+yojZAoQbeB0/+TADwcyEIxENR0BA/oaacyiwMbQpOGDo9Wrac6Awu5SGiY
	 Q5rfrOD21TqBemWKdVPBsEHiei0aHV88qqCNOzUoHaVAdJhnBOr/sdx2lLenKijhVr
	 lR7qj8KLebt9I2VUX5aArZgpKb2UzODSlxG+GKC1dN4JhK9h0qynNDBqz1AxEuxT2H
	 IztDR2EyCc3UiqmRJhMyIBTnRxdYLc+32rMClZ6XDjyLvCPPgXGze8hvYSqdyBsHsg
	 Z2wMPW3nwHBjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4F0C81144;
	Wed, 11 Nov 2026 23:13:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A23FEC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8976405AC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLkXqKkMOTa2 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21B324081E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=qkBDNOxA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21B324081E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438784; bh=pIXnn1aOwjBY7IXEP3EvYH6+zhsU0Ysz1WK8MSwEaZk=;
 b=qkBDNOxA3U8usbvyYZO32V0rcxScuzwkPbvlvyy/zsVPtdBuUDBkRShzoMKZErhSdJ7Bjds+e
 vzb1JPRDan5Tzw5ZfMOaqKp8wjWU1LYcTT71m5TlZS8FiBWb1ujXePjy4Nsvfd52veO2P8x5/eV
 laL3JedeHXrHmBLQC/4fLqxE71vZopDhRg5iUX6tqPyLe1x8MeRDm8F1V125bpzCnY8G5rZpLyo
 VNYk837hoWN49UUaBMai7WvErPQ01WkgeZYxPMwG9biUZu0qUMcP45Vygdsf4Db6FlaKIHwnN9V
 Prhoy52aFycsHOv2ITBbU31rEXI7/1YyVcC8r1ICyGaQ==
X-Forward-Email-ID: 6af4f67ff53292d6859f3386
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 2/8] clk: rockchip: rk3588: Use correct PLL rate for
 SCLK_UARTx divider
Date: Wed, 11 Nov 2026 23:12:43 +0000
Message-ID: <20261111231251.160051-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
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

Calculate the divider from the CPLL rate instead of the GPLL rate when
CPLL is selected as the SCLK_UARTx parent.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 58d407a12e20..73bc92027649 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1343,7 +1343,7 @@ static ulong rk3588_uart_set_rate(struct rk3588_clk_priv *priv,
 	} else if (priv->cpll_hz % rate == 0) {
 		clk_src = CLK_UART_SRC_SEL_CPLL;
 		uart_src = CLK_UART_SEL_SRC;
-		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
 	} else if (rate == OSC_HZ) {
 		clk_src = CLK_UART_SRC_SEL_GPLL;
 		uart_src = CLK_UART_SEL_XIN24M;
-- 
2.56.1

