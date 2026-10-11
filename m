Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8932CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80FD6606D7;
	Sun, 11 Oct 2026 22:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRiKTnWRhoJE; Sun, 11 Oct 2026 22:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D35686062A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757819;
	b=EKi5tljyb5cujTngk5QUQd9+OsAu4abrF69krAHpA3qqYvKEad83kpETDAGZvGvFQGaH
	 v6B7FUGA+RzNgngrP/yQ0pXf1xy5MHVH7A9rF7cFLf16lv8GXbKEdExoQnH5tBD9j+fkM
	 POqY94uVeXOkwrr70hpqfzDENBiogzUwoqCHd4PFgDJlgng+9sVS0KM5bZxhMKGFv7Qex
	 2rxvpehhiHFJBrwoEq58m+DsJj3lOsDTi17LzwLimWfWAr+WyjfS5J8g2InMJCqX0Mfok
	 H8fVYbHaoJ4O6hfxRjQ991JGI3YX93swO9/idTkgl8dRwHuQ1VoQxoLxzkp89ccmLIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757819;
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
	bh=oh/hdn9eiEXn9PVs+i8JR71kNCEwpuWMzG6Y8BFtsmQ=;
	b=Nxom0pXye1Lx8lFTSqCS0Mgqh9crHfs6k11fC7vmP1qdT5ov+6SQFGqamDUkaAIcDbQW
	 1POKlSHSvTwqmuyi38dTkjF6n+f6yZs3zzIVgrWwiAfMJp6yeHTwUIL6IhyZUA+nVJW3i
	 GYOPeL3F9GoukyKnrafBG63IAAPUd/6BL0A9l4KYvEx6+kxdoGSrpCbyBgokPBxOJbbQU
	 RqklW93+winviagWwqT2CRwOvEYRjkSeOE9lCYPbG+lGJXK6//kIZ4knlwalNE71cVlT3
	 Hd5vjy+5977gs0yG+hXk34IefgP/OarmfvFqcTyayNjN1PIjUNzaBGt8/rytEhCF+3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757818;
	bh=oh/hdn9eiEXn9PVs+i8JR71kNCEwpuWMzG6Y8BFtsmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4gmzQ3GfDCoIclad9ipaXuIxEIDIrrOAEapLCzppkmuG2jm2wdBqf8cN1mDBLbYc
	 Tw1nWXVtvGPC4U0aa5x1eIP5qKl5CNTgFzbpG4AKNGyon2h06dZir1nCnqC7fpp+Ap
	 HY5P3cxQXUP877byrl6rcPAdCQHhs4MIeJxaARO1uU5wRlE3O81xx39Puf5m6vv3Te
	 5GeAjczRsqFG3+GH8RikJIISu5NgZGDp7Y9wQyEh24bX7VHgroRzOivo08v/cU6YkY
	 LHRsG9mhr17zNEKWgfQHLY/zJJilub+d5YygzdloSFZC5l7QVprh+3wu+m+LyyxNZ2
	 3nYWe0oDhqJCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D35686062A;
	Sun, 11 Oct 2026 22:30:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B85CE75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E3A280D10
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynDRCqlPEhNr for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF97F80CCC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757817;
 b=QF9736rJs1D0Ua/YBRckEjWgrfWK3ZGI0L4LLgFoflqoVBhD6z4H042gEZhaOk3mGqA7
 ft5KpzMwNqkFaXxJ2tgO1M3YOpYVoe2cCAvv0gJR/EXixnX8hME2XDI2MsVno2V+D+7z1
 z4R1Bg2yfcf64J/L9jVsEey10JrleNpW1lVlsqGfniN2oH4GCiFTCquL1ObhiIZlN87jR
 u8+FMoUk9ryeYvk57FvFxs5s6Zw3x+nDDGr9l9XMTxMF6/HbF0/8ttW1/ASOJ3mOvNPPg
 j9mVL3aGg9iUIKRyCa4yXat2kNIkvzybS1QYvv+qyKe3i3UJkL+5/xFkgbpnMMXT0hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757817;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=oh/hdn9eiEXn9PVs+i8JR71kNCEwpuWMzG6Y8BFtsmQ=;
 b=fCQxSh+KuiUyyZrzU9wexU8pdPLpjJInExy8N0EEM+1kRJKKHkAwQNMAPp0icozMdv9v
 Gl4hbSXSgLwN9azad7xxw7HZTUSmVvd8fwC8TW6woGpADJoWVSlK2/yACEJ2iLAMbEOd5
 hLuT8Nor+pfqZEr9BhwRNsw//NAFzBAcOVAeDxpfeq3WibsW+scpUyauAk8qxRW0wnYJS
 R4axqbEQ8JyoAniAj9rNI1wM1NBffi0JrEwIioGQAnN04p6YnfLgQ3685ZG0u9TFj6LUK
 pxK9zuwUVU1eKaFvind2t2Drv7AjIgiQjrbSRwuBro3d8MHpLuYfne6MjYAKSl/+ovg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=x+5hGjs0; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=x+5hGjs0
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF97F80CCC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757813; bh=oh/hdn9eiEXn9PVs+i8JR71kNCEwpuWMzG6Y8BFtsmQ=;
 b=x+5hGjs0zOJNBMkFt7lODfhnzk89J3eLpcoUVWm0Zny6f6rw3AfMlT7GU+4w3GZoJanL5aW+i
 6//qnT9DJXYjj7Aqm8RqnC6seHRq4Q4tFSpPn3luGNbzyuDJa1RZnAYqOSwzwFmc++cuSgMvaiL
 hZkArWp7+SPwRfl5gZ88zRLCNoqFP0W5ejgOa0VXBb7GSnc4PjjOgcvOZRmV+dgqQNvQ816O0I6
 pfoHCTrQglUTIzq63yH/YurG5s6Ivp4geWD/DvbN5fWhgiD/6OJG49KL7gEaN0uk+50gVAydrDN
 iVVi818dlBB+//wimlMe01xGC0M7/y996XOWJ66HSrjQ==
X-Forward-Email-ID: 6acc0df54548822a24c173a6
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
Subject: [PATCH v2 10/37] clk: rockchip: rk3568: Use correct PLL rate for
 CLK_MAC0_2TOP
Date: Sun, 11 Oct 2026 22:28:45 +0000
Message-ID: <20261011222930.1085075-11-jonas@kwiboo.se>
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

Use the PPLL rate instead of HPLL rate when the PPLL is parent of the
CLK_MAC0_2TOP clock.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3568: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 398f76488470..940b824103cc 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1882,7 +1882,7 @@ static ulong rk3568_gmac_src_get_clk(struct rk3568_clk_priv *priv,
 	case CLK_MAC0_2TOP_SEL_25M:
 		return 25 * MHz;
 	case CLK_MAC0_2TOP_SEL_PPLL:
-		return rk3568_pmu_pll_get_rate(priv, HPLL);
+		return rk3568_pmu_pll_get_rate(priv, PPLL);
 	default:
 		return -ENOENT;
 	}
-- 
2.55.0

