Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE0ECA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 189EF80CFE;
	Sun, 11 Oct 2026 22:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWyox-Y0r-vb; Sun, 11 Oct 2026 22:31:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40D3E80D35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757882;
	b=VPk9GckD6o2C/j1EhxKv0YxHEnLy8PblKqbBZj9QKQdzORYPIj6/7e+DZMMflqFpyEbu
	 Nvddv//9fnCfpeXacoStsU8Mxst6OMejiJN0lOcyllm2Q1TYMJXiDix669fy8P1lPU9ya
	 AaK8QVrlqt0PP6GDe0XnSKBbusPqXyiqRD0ZAUH94A5r46l2a2RKe6cY1OjEyJ5kiK4e9
	 grfa9ag3G2KTNwjXO7zA6ifOWAW1wMGftpOYPFwTIJ/9MB/sBvd8u6H9izCzMs3vxVHbd
	 LTURVX8gnaYWVKlyeEt2Ra2PsmvoHvQ9g3ghq9VEWlG/+XsXvW+Fvyw7LYTzOOgMeDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757882;
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
	bh=SNNR2oZxHExXZ1oCRUJsq9MLLj0UL2RP58CQmYrycKo=;
	b=sKP8z/lB9JdIKP5umnJBFP+FBUG+35qDe5Oz0pwxmreOWbyhwHJ9XVcaUKA2rEMaeXeZ
	 eKD8yZSyECKt8MX32iBCq6VeFInuksGBG6FUh7W2zf+PYor9Tx6lYqcfwf5Yj9V09UQrR
	 gVrP/GgXWoNmhbA92ILrMmF5aKkmJP8/rnHFi63ZS11ZMv6iMc3bLL39LiUoQUSV5FQcf
	 QDcvauMA/QhTew4c2E5yW8eDzEaBGWYCrw36+wvBESoP8XQ5SuObGn/BBMPKPi5v7fYxM
	 KFuw18kl/XQwf1nXsewTIVPrrTEpDJrA8ZhbtkObGebs8/vibPj5loQa6pqvgMZfRgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=bsWJJCss;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757882;
	bh=SNNR2oZxHExXZ1oCRUJsq9MLLj0UL2RP58CQmYrycKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qQlCzTwYzhyEzYNn4GsGxkVN4Aowg7h1gy98uhqG2EiF2PIYOx0mhDZw3BfRjviAU
	 uEfe1OoI73lZ8kn1+I+KJcB4kzBUOuaXaYakGzWeukZzttt+PtydV824kd9WHP/s2G
	 b+xz22uWRc3ihhcbCAUlrX6pspmZkI0/xBDXFIYljHn0eJpdEs8iufvtjfk9xX/oag
	 4WCEE3nKHL50VMJ2yHnWzWCJLJf2fxXyFdsjixTo+WpjVdpZyAVXPTV60s0kls+ofd
	 AwC7OvylDLP6vI2c7VoSgj2WfSXorBGrKX1XrZ2iuxW/GTVLMBJmSne4+OQEmYVHOt
	 k2nUJMGkBxctA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40D3E80D35;
	Sun, 11 Oct 2026 22:31:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08FCB1DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEE4E80CB6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ce4QVE3aBzo3 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC30580CA2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757880;
 b=SXTxXHridw4i1JJMLiM757HfWfuLfyYvMZvvXrI1WIpXTo3L7NcdKHUK0KkoxOPB0Cs8
 FzVhdA+KdEtEoaFHnE3yRjsXgoNp9NAY7/lDvf6co12eyZF1t5TrOVoiA1C4FlziYa+zJ
 E+J8FO0QfUg3UErGIBHqUu65wcWNwahtl1bHk7XW4IP2cnxdHhMZaH9tTXoprLH9HT2YL
 fiXQLCyGsBRKvFY8JEIve9xgx+/HRjkpbWA0dhczirgMvLmnvtdi7cwii1bAGBwWdZjS0
 NSI/QyUMQUYbQpdUlOoIYykoFwU46bY+UFZNwQSThdpV4duT520Sov+j/Q36vjnAzuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757880;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=SNNR2oZxHExXZ1oCRUJsq9MLLj0UL2RP58CQmYrycKo=;
 b=WkSQlj37AfSEftOhvCg0adVTa3GcyD2zLgCqVuI7iW1PZyiy27wg4JmkC+YwVjj3uv5Q
 pHbh6cmI4ISX36BXEelfa2wn2ucu7pUVpmi3fr78n/Fv8QhtgrjS/pUzr7akWO93HCvVE
 g0EpUroK47RKIwHnFC+AGCjzBcGBv//hXSu9eXAKxHVLLFelxCY5FcWAB5Zruhzf6pBXM
 gojqs98srCa/f09o8EctFDJb/bkNTGHGTqPkZYlcVHPs0urR14bHRVeH2rvINIIPdiBOr
 xLEkS/J183Te6yryUfo34tYHbgTjiLZRyQ1yZnI8W64n4T1RlU/dgJjrb5inpdxdLDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=bsWJJCss; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=bsWJJCss
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC30580CA2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757879; bh=SNNR2oZxHExXZ1oCRUJsq9MLLj0UL2RP58CQmYrycKo=;
 b=bsWJJCssmvUmU1VB+RtCfz0v7SHcFJqQ2leyIituQaAHl8La013betDNE5pwWTD0NhUg0I55C
 TMOEJF3qullJ9VQSlXV/R+YCHxhXt0dD/OGyEItAcoDRlPoi94KMNtg6o0H5nto52q9SSrD1osi
 Cm8st2QBNKrOm7wRfYJdMOmyi1V10U5wHgyo/4JdoPw/KdAGQI25rCpNxhR5+ZuvW4sfEgxQfsE
 /WBJ8zzFoE/Chg2D6Q03NJ8XOOhwu/TDkEwnBTTCgCPFBw5OciMa7HIuHMEYdzJrelQqDHC5Lax
 xtC8FO0yukHCEocBWSiFapNrCzCWqfjMKYkoMpIeCigw==
X-Forward-Email-ID: 6acc0e304548822a24c1757f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 27/37] clk: rockchip: rk3576: Rename PPLL register macro
Date: Sun, 11 Oct 2026 22:29:02 +0000
Message-ID: <20261011222930.1085075-28-jonas@kwiboo.se>
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
Rename the register macro and update the PPLL entry and users to reflect
this.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 2 +-
 drivers/clk/rockchip/clk_rk3576.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index fb77fbd7307a..380151e0f8d5 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -127,11 +127,11 @@ struct pll_rate_table {
 #define RK3576_SDMMC_CON0		0xC30
 #define RK3576_SDMMC_CON1		0xC34
 
+#define RK3576_PHP_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
 #define RK3576_PHP_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x300)
 #define RK3576_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x800)
 #define RK3576_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0xa00)
 
-#define RK3576_PMU_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
 #define RK3576_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x300)
 #define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
 #define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index a7110b86c063..ce97997c73ea 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -56,7 +56,7 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
 		     RK3576_MODE_CON0, 8, 15, 0, rk3576_24m_pll_rates),
 	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PLL_CON(128),
 		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3576_24m_pll_rates),
 };
@@ -2458,7 +2458,7 @@ static int rk3576_clk_probe(struct udevice *dev)
 	       RK3576_SCRU_BASE + RK3576_MODE_CON0);
 	/* fix ppll\aupll\cpll */
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-	       RK3576_CRU_BASE + RK3576_PMU_PLL_CON(129));
+	       RK3576_CRU_BASE + RK3576_PHP_PLL_CON(129));
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
 	       RK3576_CRU_BASE + RK3576_PLL_CON(97));
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-- 
2.55.0

