Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF01BCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B04C3606E3;
	Sun, 11 Oct 2026 22:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4z3m7OzaWnWq; Sun, 11 Oct 2026 22:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02153606E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757797;
	b=A+tHJpLlj701vtDIuNoYgXvov4Ry3J/os0QTf+jxgPGjE5Co3pQoXseCUFq/k0cyQuPw
	 RjRjCvFE1PnfSL8CuhuQVFKh/DI59m2e8HHG/W3vQaqOxQzAH/ZDCbJy1b/n+TUYH5zij
	 yZx0orEszKppjmE0BI7LGfkblnEItT/5EhsaJ4yCWWQX8FGF/itI0slHOapEkT3axAz5n
	 6wXgP+gROAJMBZnF9wl0kT90wfRN3/fySNFXG7vaG22oex/b1a2NNS3CCTjx9VPsXuFEj
	 uI5DzKnJaZA4M3a0T/NU4as2Q4AqPpFQ7sPjlFCEqO026AK9ezByroggcOFJUTSxOeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757797;
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
	bh=Ne3ZldTO0/tP3ghc5YnKcFag/Ea2LAXSADViiZ1Frw0=;
	b=pliUAgKMc7aUnTeVdQbKtMHUNnS4vOy65pOwt9KrOgLvh4F1JcE5ErAPnVQaBp4sC5Qa
	 KDr3DndvC9VRfeH+/pUDQR9YzOm8v9o1ZPD4LG5YYdcnM4mnDTena90lnLq5jBrSELpTq
	 J/NCqbLJgkyoW8vUHAjsXduFs7j4rCI94dSKqCMjt0AwPJzzLhZemfA9WtduJFY/9Slu3
	 Sc5TVBo8jKunJ5H62KSKYO19BfXINbD8f1/Hi9aK58CjCVTHhLc9i+YB9Jkg11x0l3JKP
	 YVfpy0QClTT/EVk8Td5sm01UQR8Zmz5MzmUj4zoFr0Csrd/3THxn/XELfsk2rXwx1Lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757797;
	bh=Ne3ZldTO0/tP3ghc5YnKcFag/Ea2LAXSADViiZ1Frw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZOs6JLSIn7+7Iec3hkWy0oMvyAoxhzXpMZEYScr776lOOlctCT2y4JgXFW8Cr5Vwg
	 LsWSn+h6Gfoe4cYjsR2OKS3ra5EC9MrJ14MFtFesYOt3N/642uQjm/u0/QRFju9kjn
	 Kzv0l+mVxxoMWcwvei4nyprC1AEOzpQ16C6Mbb9mffL6jxNC0MXFboWxFDaLPoWKf/
	 8rW3OjuOO86VpVtqmFEf6rCKeAGpl8/aqNVESUxNLUS22ZrzJL1kcaACI8ctOKqey1
	 A20wKrYic4BaUV2Ijto0QBig/9dsSuAOcBeVqweWjC9zuQmiFFopZ0NxXNoREggs+0
	 rmkVF21nDUhng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02153606E5;
	Sun, 11 Oct 2026 22:29:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D872194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B50A80BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id plwze7Ex48Ff for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9EB6D80C66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757790;
 b=mj+6u7gjJhU6yfh/n88+sYolmMpxDFZ8Lrei1x7PRI5M10cGH+4OHwJkZ4+Mu4Jz8wKh
 //VcPPUyiQfZeyLnLNYYDXrBdqTbobqf156iHWcfoPi9LWqr2m4RzfTRTGbZT8AxjP/kR
 0uwjjSEOx+5NGQwpsxuXq2132xSIZi1rm28MoTYZJmlyOUzlWHPNObK5v9ActMLPyGiEM
 sAz5FMiXh6oqm3u6sUdvaZbqUg88ozKn7DgnD9qBPEyd2GD+2vdUVn45bULJZOABIdhJG
 4NTIZCQpKQRvBDqDGSUaGassXxnsNqOPEsRmQb/U73FrnyJvQUOnn/8LaNviYck0j2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757790;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Ne3ZldTO0/tP3ghc5YnKcFag/Ea2LAXSADViiZ1Frw0=;
 b=C0m3JseB4Hf0WBVeZUmhFVqE7zD3vZGascKM4IXzg4XKA8/yAedMRK47Eqivqz9VWzaI
 HL4mPeBaW1n12lSOapcd1ns+Y7flgyUetCxgb3aqpU3+QW2d3aySUDya6NReRZDrwGXFg
 O4DgGbW1Z33bAZf7KC3hi3HtY7YCns6kL9YvSk6PHyfLcMzli9wQUovbq+7Cnvu7kURHI
 uQoSiCkkkGMe5tqN4OeTZHXDIlI1sD7YhAUoszGj8lBGlzCQQeCkESzY5IrM8VOb/IGx9
 e6UnFCzOkxuaiuBSCsDx7Bsiz7WzDaPaoW18rddfE/POBgaaWkT6k+jkbftPAu58TJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=w5TeRrjA; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=w5TeRrjA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EB6D80C66
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757788; bh=Ne3ZldTO0/tP3ghc5YnKcFag/Ea2LAXSADViiZ1Frw0=;
 b=w5TeRrjAaWVmjLATKfBZxG7/7vwa9Izo60Uge+2ggkz772erL+WaB325id4VzIG1j+7u3j/Ri
 Wiigu16TRwfej2JnC9pNvVDZas29k0i/T4H3HfrXQvN6G9/IsTbq+A6EhfoPJOoOecbP/BIw5z+
 5vLUXbPpSx39UyPuhJ5f/zcUQsGB/2ktOWthujODWwYToq4suArD+ffIRRYeicnguSFunys+LdG
 Y4nCaZxiNwOZdabrKl1dxcj58SEIo1rLV7MFrivkG9W8A1IQnSJrp6z0WFTb5iyO/Av6+kYizhj
 dMh+gFONE35ZeNO8KwltA8Dx4LQTUCov2i5ctcztkQ5A==
X-Forward-Email-ID: 6acc0ddb4548822a24c172e3
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
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 03/37] clk: rockchip: pll: Always write the dsmpd flag
Date: Sun, 11 Oct 2026 22:28:38 +0000
Message-ID: <20261011222930.1085075-4-jonas@kwiboo.se>
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

The dsmpd flag controls whether an rk3036-style PLL uses fractional
mode. When changing from a fractional rate to an integer rate, the
dsmpd field is left cleared, keeping fractional mode active.

Always write dsmpd to the register so integer rates disable fractional
mode. This also matches how Linux configures these PLLs.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
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
2.55.0

