Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCF7CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC57280C75;
	Sun, 11 Oct 2026 22:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AzM6m5XtO_EK; Sun, 11 Oct 2026 22:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A22E80CA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757837;
	b=D5qscRW+PjHHZZ4L5gL92f/4sp4eyEkA8aLwDQQ0O8EZsV83Xbi/14h0SjKoSBCgWKoH
	 UDi40lrrMhSylA5jL5zY8vFY9RXlWAkihGOMN2M+YBI4YIrBcI519EePx6K486meyptbT
	 mcwFYD8xzJnVXKN0rkSoHzjjCV3Gw3f8RSjYdBCxLHYey0KVSwCUrkM3WMqUaB+FWebyt
	 zqqgUttwhrer6/Vx/T0zFWzHMozgRw20bf4X+gzQxttcKiuj3aMI2ZcMGfN9TspRxp3ZV
	 ggIwth2r0lNyz5aMk5L1Ev2uIR6CHgnv5dlZQ7qNG9dbjchLpFFuv8qX3UpMPdBPkOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757837;
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
	bh=aSoohK7tlR7456asKrniBLnPM+Fr+YLUvoC6RfFff84=;
	b=hlM8dezkOSxCA2TMoLB89pM1MUoLzVtLyH7h3b3NTPce1xbjqrp98NvdYeM+exCj3Hz5
	 i5rE9E2Y94beq3ke/yfMY8NMC5FBY6kyzlQG/5chXWze0p7A0902eeywlRtWPkT3uuadG
	 MWF6t2E58o3Tw244mgaO9o//M+oqDof6MONeWK85U0gKOCPzBoWSuIbt3UFuNiNWIpDDk
	 pUXEpitnvq4oHi7dtxRwCBruAyIcUHiqmhyLZ2jhWYlTpeeUg+HZ+JM0I3lNNIhmtV5Nf
	 7gthXweH50oZPQIcMstzBE7fKKY8EsLIGsMpjBfZTcn4Q4Jh1L2yTMPgLC1NVnjzq3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tHn5o0ne;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757837;
	bh=aSoohK7tlR7456asKrniBLnPM+Fr+YLUvoC6RfFff84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NCBpt7uPDKjBYmMfobmurWPpqXmrMq48TlzC6SrEAUl+FwyfJjZqvfyvIXguPvpA6
	 i8dXpcIUXZHzWv4dZXs2mP9P+me4Rycs4Zg/Qlvz5O4OVrtU9SlYhScckbLtlj/iUU
	 seSATbNlOC9WAilPxUwjSY5USzrEzrKQADSZ1Mfoi8pXDrxH0Kaqgno0Ch89/1s1j5
	 omFOmSpB3Cws187oWSWg9l6Wb1vkJRTLdNSnFJat40Ibok9UEHjnGr7l0bj2ySWMcC
	 2FzJwMu5D9oyZNU4lbiiyREwOuvJL3N5yHL9sYNQunDe6vs4O6EumgLa0VIS9CnsP0
	 enDwgw2QWeOQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A22E80CA9;
	Sun, 11 Oct 2026 22:30:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D133194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1ABD780C88
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKioll2nszRa for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D41180C92
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757835;
 b=pDTWaMONEVipYwlPxBQAFqtqaIjue2X/NnXJhw+CqCxkK3fm1VDds9RFEFhhQjFnNwJ+
 YM5jHGSodIJJsh5TzdUH/5Z2zyt41v6pyfVs4Tp0XuGZJ7ebvewI6UzrBiwvMdv/mev5R
 w3bAVwtWWJTAqnrgd0BAzQYlRWq3T7bP2FHZZ4qh5JP2zJgYhIsWhZ7yUHpQlNjyTfGLY
 hfubVB0TJXS9laEFvHj6tmF6mxRdokhMQl16AmeNabZl56IH8iGfzgATrxooNgSAL4HHD
 hvjkb9OrSWrVQo/2Gx7dvt6E+8MQctYwbqth7djxGKXI/KzczOVipzQjBEpuT4yr0tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757835;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=aSoohK7tlR7456asKrniBLnPM+Fr+YLUvoC6RfFff84=;
 b=OJBV6Xay5D3koDNmFMY5NrI2cQVstuz3OblLPy15g81vkEdjhVtebP1VIRGYk2PKQkTb
 4lvrnaKGo9KUfuRscGqx2+FiuszRSKGVjcjoWkgBi3swFSJ+2e6vKiJ0ZHevjhA8PPdTQ
 xnzuMdxeCCSo8De9jVj68NP7KWN1a6cqe5sJZvbN5BgdkuaFPTerQiI7x81+y9IwvWX0X
 ai8ZH5hN9HFiIei4ZaMCkVXToeHS62qCpjQTCqMhvJAgIOLxdVy8JVqZdqc5fBnwcLlK8
 ASq9tEThWfR1tVLgUrhGuqTtf1Jc+iVtsCAKfp8u5u254rNyTNiadV3H1udi5IAGV2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=tHn5o0ne; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tHn5o0ne
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D41180C92
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757834; bh=aSoohK7tlR7456asKrniBLnPM+Fr+YLUvoC6RfFff84=;
 b=tHn5o0neQz7vevTs5TrM4NfswTzDX1qn/xB13fKMNNVkyf9FrsAdOVlrdJUcqFlE3c03an1Un
 0X1Dz3aIwrgEGOXVl9vRcdQ39ipvPnLeU0u+yisVczSWI8vKL0xWMtVQ4gxrWLxitICNa+ukcKt
 bThIJe/xPQymvTu5uJuL0Q9xgqt16A6zyAyBidAEu+4v8njQaEMicOIXk3z5UWCGuy6MIYGdsy6
 onRIeNsBqvc5ME+biE8xDWNpmg+F+/H74HQTpygMpbKquE6S0F6L0/VPJBSp9+TZQRWsWpGTM/2
 Ww9PgWhAcW8bhVi1ZxGgaJv8CPmCXzs118be6X68Ap9Q==
X-Forward-Email-ID: 6acc0e0a4548822a24c1744b
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
Subject: [PATCH v2 16/37] clk: rockchip: rk3588: Rename PPLL register macro
Date: Sun, 11 Oct 2026 22:28:51 +0000
Message-ID: <20261011222930.1085075-17-jonas@kwiboo.se>
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

The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
Rename the register macro and update the PPLL entry to reflect this.

Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
 drivers/clk/rockchip/clk_rk3588.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index c83010e518ee..39295adeb38a 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -126,10 +126,10 @@ struct pll_rate_table {
 #define RK3588_SDMMC_CON0		0xC30
 #define RK3588_SDMMC_CON1		0xC34
 
+#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
 #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
 #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
 
-#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
 #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
 #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
 #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 872e36748caf..3b21c7f8465d 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -61,7 +61,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
 		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
-- 
2.55.0

