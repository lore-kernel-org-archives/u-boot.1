Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F8606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c6JehPn9;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ewnYOoEE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D24C40AE6;
	Wed, 11 Nov 2026 22:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvrB068rzzdL; Wed, 11 Nov 2026 22:28:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E16240B13
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436135;
	b=bbtMj9mGB3gtcnvJtQYbMhrOu2ni9Nd4EBWIdPHz+NosesfxNfWZiGdUygCpUMmqhR93
	 IMDneJdz1/h+oJGZJZcX6hfkWyNqJnr2l2xGP64+Fj8q3nL94yxdq7d51qOdSFLsdGn4S
	 HgDPFcOB5h61Fj+iFPHW1y28EHhqhl/yhzPE4pX9DXgGWhHP+7R+xJ0JbAM4SOc1MXfHz
	 zLPP27ykfVP3jrWdYTgttza7VH684E7PaM/nQtl99ue3SvqIbMl65oYnAYOe9W4nj1Tdq
	 4uJ6/EcftfmQcsNU2J04uBUpxLVAuz/mzBI0qrClsfDIJbU/OthiaYq+Cdcrr5zr2Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436135;
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
	bh=qCnIiUO6nj8cc56C36d4B6QWK5oSkw7vE+tJqE4ka0E=;
	b=iUybKhBZJ4gYOIVx8Urg/FceubwSullMbhwZjg33E5RRQpx61mFDjfR4rl77zRGluAuh
	 U69dfoPNHUqw5F7Oi1EuD7p9cLihZZWzDd/sIm1yhVbT24VWqnQkW6UzsBk+udjGI1l/w
	 SggGMAp7vqTWe2O1K0VLiKV94gpBrYNChBJtpIVR2ld08cdV54V1ruenK7zp48vwi+7NF
	 mNrdvUfxVsLZLhyLURG+1NvuEoF2xTEPmgNF5d80nzlFm8lvdE8wtOI4PsrZLdF2ZxAus
	 doNWnen9w5GctEaae8T+pteMuZn0e7h8BD2PWnZjDeGmv3dz3Eh/j7Jl8ADvBooZRLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ewnYOoEE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436135;
	bh=qCnIiUO6nj8cc56C36d4B6QWK5oSkw7vE+tJqE4ka0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6JehPn9Lm5bfL67pv2JUkvmDBltxu9RrxNiqtEoN9W27eth0aMh5bwYlSVolHfLM
	 tdtTNAYxI4l07hPA5WbXr/gjjjQEYYn6nv8zUoWOju7L/cfJ7LHrdW7rMJuwNWo6Xa
	 Mi7+Mx38RJfhcN0CsyIxLL+nMcncHDBnCDy+izOsqsi1YPw7fqVfQiFSudj0HGcCOg
	 XWI5nzbQ9IrFSCq4pCeEYr3ArmPJ+cxdr88HS+VbYxOdkW0t0GL1zYveKJEccrOQjl
	 zGNH7EV9g9FVBf3iDI3asr+k0ahSwYQytc+Knw2gEmeHn7R7xbkbtNFkfiKwTEj8YA
	 efeiTNCRUD5mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E16240B13;
	Wed, 11 Nov 2026 22:28:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B76962FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9022240AE6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mKbQJs-qsJX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:28:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D3D8940ACD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ewnYOoEE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3D8940ACD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436132; bh=qCnIiUO6nj8cc56C36d4B6QWK5oSkw7vE+tJqE4ka0E=;
 b=ewnYOoEEM1UHRGlKGJ9wAPIkbVNXByQU55xLAPTih7Gx7OeMYr1j88TACZYdw4QR5w9hQ10Mh
 IY52WCOYEdVuNY6sk7RRKT2nIw2nf7OIfD4HFShlDBnlLy2EjLJPn9ep2nblcoXddpPdqUaRsAY
 X4mUkKQ8xJfdUfhSBR/kSpUGCw9FNZF6OwccZp5bYvqCpXxLVWCvad4Xt6218lTDiKs6D7EjSQ5
 jBTo6/W8382fF9iRU0VqbigESVK+W8fhEC7XOUE9SFhoyZAvnSMsV1IS8fvsQOsVJQ7mJTU/OqC
 StVT+Ukwjk5kLYmrKE95UUAw9Wk3yTX6WRf6K5jeDqAg==
X-Forward-Email-ID: 6af4ec226e1792a74d36a4d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 3/6] clk: rockchip: pll: Always write the dsmpd flag
Date: Wed, 11 Nov 2026 22:28:29 +0000
Message-ID: <20261111222834.157842-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111222834.157842-1-jonas@kwiboo.se>
References: <20261111222834.157842-1-jonas@kwiboo.se>
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

The dsmpd flag controls whether an rk3036-style PLL uses fractional
mode. When changing from a fractional rate to an integer rate, the
dsmpd field is left cleared, keeping fractional mode active.

Always write dsmpd to the register so integer rates disable fractional
mode. This also matches how Linux configures these PLLs.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Update commit message
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 5cb0e954ba4a..5de930e41dce 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -331,13 +331,12 @@ static int rk3036_pll_set_rate(struct rockchip_pll_clock *pll,
 		     rate->fbdiv);
 	rk_clrsetreg(base + pll->con_offset + 0x4,
 		     (RK3036_PLLCON1_POSTDIV2_MASK |
-		     RK3036_PLLCON1_REFDIV_MASK),
+		     RK3036_PLLCON1_REFDIV_MASK |
+		     RK3036_PLLCON1_DSMPD_MASK),
 		     (rate->postdiv2 << RK3036_PLLCON1_POSTDIV2_SHIFT |
-		     rate->refdiv << RK3036_PLLCON1_REFDIV_SHIFT));
+		     rate->refdiv << RK3036_PLLCON1_REFDIV_SHIFT |
+		     rate->dsmpd << RK3036_PLLCON1_DSMPD_SHIFT));
 	if (!rate->dsmpd) {
-		rk_clrsetreg(base + pll->con_offset + 0x4,
-			     RK3036_PLLCON1_DSMPD_MASK,
-			     rate->dsmpd << RK3036_PLLCON1_DSMPD_SHIFT);
 		writel((readl(base + pll->con_offset + 0x8) &
 			(~RK3036_PLLCON2_FRAC_MASK)) |
 			    (rate->frac << RK3036_PLLCON2_FRAC_SHIFT),
-- 
2.56.1

