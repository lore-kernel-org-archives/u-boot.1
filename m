Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6B7CA9ED2
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7905D80C8A;
	Sun, 11 Oct 2026 22:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RP9XwSZxMyiy; Sun, 11 Oct 2026 22:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FC2280C7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757794;
	b=cAUinWfLKBN7zANYPBRf8kn50NnyvuJ2/d4qGUPdzQ5Qzuv7uqpiBqLQ9k6a2mFCA9q5
	 ilTB+DzZurSAE5gHcCWK0NiDDsQnEzid2gOkJP+Ka5ksrE11yG1DLn2EOSc/0pg3vOw6q
	 955Xl0NPic/l7LQoB9ofOruGVUJPN+Gxd4gv2kmKiq7HtBkGbcLSVVQg8Yg4HsD7HzsE0
	 BX82GbY3IQaPvILBVW/lY4Yq7BUgtrxluRxC72/YfaT52oGInonPe7L4SUH+yOgUGOO+5
	 RF7Emr3g9FFOeREoq5dvZstNBUxqCfxwptcjorD6yjn2LfqSfRkiSaBPbAeUGBXacBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757794;
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
	bh=IBSQ99a0zshSKBcjIpB4ynejeWCVs+T/C5sldBjU12A=;
	b=fpp+4ExpvEtVrM6nffSVFGuKw8mu7Ek2tp7RiLscHhspazCeepwQ4QyWdMyvra9uRCLE
	 HWr/SzThhK2/+u+TWRI00HA+oXBaWtBUWOwSrSTUcC+E1JAJ5L3q5+EJcfPgbTxjU/9WR
	 d44738ladXUHlt8G5hoOwR812Xy6bSaPMl3T2BhjlZkDSiBmejy6s81B8Ge5yoxGGhvZE
	 MH32l6mvhKVNLiwQyME0NscKS1d/65d+1ydcFNDpfFl3wtvm2/qhonPFubopukBadLXVg
	 qGVrGtJyMs6xIL9krY1+9eDynjbas1I+sw6Ii30MdV5RXqcA5nDKoroXvbFVeNKqcaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=nP+zKkMJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757794;
	bh=IBSQ99a0zshSKBcjIpB4ynejeWCVs+T/C5sldBjU12A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYrsU/S8l2+CeYZUzX++xXsQ4F8WxDMo6w+XK4+ySlzTc9C9r/POw3yunuLna38ZA
	 ENI2Z6wYSN8VqUexZdjN3RmCxbC8RoztgUGVqEiRLPXfb/SMMktOU/69x0q8yvrChn
	 pE9reDnbbwcCw38pjJLi0AJMnR/kGsf5UxSHBB7uc0YEoVde2T+PtOtUpNRtnGB6SV
	 Ir7R5rOeNFrLr3pBVC3yWMhLEbrMbb5l4rWknUvS21sSiDrD5jknS7XbIjMnYNuaW7
	 fzZTPjniF4tGQnkBp8kkoSBRxElDM5UVx7lKl2whmvdRiunlPbNXNXa7GvD+853ARI
	 LCJkT3Q39QKAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FC2280C7A;
	Sun, 11 Oct 2026 22:29:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5EE7194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C7C980BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4DAWKj_oTlYL for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5FB480C66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757790;
 b=sMdw/UsBrJRtWvWCDRPHSJ1Mjw6QZpuOun49XGdONkio//UnSJWDA7qChNE6MWaMaH/+
 RTDjBoewdWdUDxlyJROMX3XeC90KK7TxFhSLKn3RPUVl49nyaCvOIMiJ/t0gjSmSYfC02
 XhuL6uWqvlJVdPwT0xMJdA1bq3E7TgQG293kWqw3i0A/YMVXcqmmqQO7F8EJ9nguXnbBJ
 eYE/N7Sl47hRaqf0d8XKjQyFN899QaDXZyFnVW8VXYKmdrjh4+SRV7j7TyIkOfUodkSIb
 NrdlpL51X3B9IglK5NXpVZNFz9UExoMBf4k4bss9s5eoYMSSUK2XOnfgoO4IRhVBqNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757790;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=IBSQ99a0zshSKBcjIpB4ynejeWCVs+T/C5sldBjU12A=;
 b=Sxnr2p8/BkWMpkSTJJ88CMZkZsq3YFCIGivVgedNMohCNTJcaTfxjSMUoSWy/eOexgcQ
 r0giGQSldRPblP6GgL/HiGR3SlbDKZ8qCZg/r0U1qccBtlYKXSXyWsBRCTXLsfP00WB7W
 HZn0W/DgP/KY7oPGuVqE9GG49ELjGyUxkY4CeGLUFjvVIYXuTEHcjSTrEoulM81k3fuNj
 1qc4w9oj5BQMDuZeptJVDtXYELH6UdmCQA5il3cF45EUSLnx4TxdIHbqAMJ/PUggtEwAn
 PYqiXOV5JyW1tUqPjw2ZrRTMbC19UC8lbE69291EDPJukbtfzJKZNejZ3YFOyPUNVng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=nP+zKkMJ; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=nP+zKkMJ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5FB480C66
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757788; bh=IBSQ99a0zshSKBcjIpB4ynejeWCVs+T/C5sldBjU12A=;
 b=nP+zKkMJpzhXBxVKuz4t5XE6j6vu1f47u404BP3/K3vX2K5JRvR2clEo7okBBoVzqXN5b0dhS
 +xcWumzgf3zSxpIQ0/EaLUshVKkJdRc2satytlk1j80A+UiJoMcGPOSzbKdStlaL0abDSf2zYOs
 huIrrfejhjMEKRU6JZVJVliTYbHflsGjdPgQBZXCdhFIhKO3QCoFL5xZpj+4y75vscjl1xksw7V
 vNfZ2yyNCgq+7DV0turyCiFJ3mHN/xJZSVtO3cNcd+81N4rvMmymNzb0JqVs6fMp1EA6pNSOSdf
 4th2KqSIoxjMsjMObdv01Gy86XvSIy+AQYn0eAzvbb5w==
X-Forward-Email-ID: 6acc0dd84548822a24c172c7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 02/37] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
Date: Sun, 11 Oct 2026 22:28:37 +0000
Message-ID: <20261011222930.1085075-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
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

Use 64-bit arithmetic for f_frac << 24 to prevent truncation before
division when automatically configuring fractional PLLs.

This closely matches the vendor kernel implementation.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/clk/rockchip/clk_pll.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 74b7ff5faa03..5cb0e954ba4a 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -114,7 +114,7 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
 	/* FIXME set postdiv1/2 always 1*/
 	u32 foutvco = fout_hz;
-	ulong fin_64, frac_64;
+	u64 fin_64, frac_64;
 	u32 f_frac, postdiv1, postdiv2;
 	ulong clk_gcd = 0;
 
@@ -156,10 +156,10 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 
 		f_frac = (foutvco % MHZ);
 		fin_64 = fin_hz;
-		fin_64 = fin_64 / rate_table->refdiv;
-		frac_64 = f_frac << 24;
-		frac_64 = frac_64 / fin_64;
-		rate_table->frac = frac_64;
+		do_div(fin_64, (u64)rate_table->refdiv);
+		frac_64 = (u64)f_frac << 24;
+		do_div(frac_64, fin_64);
+		rate_table->frac = (u32)frac_64;
 		if (rate_table->frac > 0)
 			rate_table->dsmpd = 0;
 		debug("frac = %x\n", rate_table->frac);
-- 
2.55.0

