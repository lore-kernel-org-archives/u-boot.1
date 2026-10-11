Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726BDCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D296606BD;
	Sun, 11 Oct 2026 22:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_nPvZjAVVCa; Sun, 11 Oct 2026 22:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F3E9606D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757864;
	b=a6Asmavg4XQpjNfbxHVeAhFbLbM27cXv9Wcsc90U1OFe1I/7aLW15vch+Af3r9OXvJ3L
	 iWIhpnkSPtDnYKOnpBLT1k76GisxnIQGphTwjs4NMLpgqZimADPFrsEkfvjtOi4WT3abv
	 /e8a4Bp0C9Nf1lFF2vfKUa69VaIlYRExMWzhNdWB6AU08fmDlVTu7n5Fu8XDvHmu+zWVE
	 air7djtzaXByQMMqJRmdX+93wCzKJ7GxrqJDUdPvkeRibUy6DWhBrJ6XSTmk2WD9F6F9N
	 WTvPvHliU7FoHQtdftNL68QiliLXh3RO+m5aSz3Yc1iwrvc5v8SDtGEg2TiCpU06QZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757864;
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
	bh=f7mt+hZgnF8A+7TRJsC+6eCaFdNMInWd74+QJIoAoT4=;
	b=dgrH083+9GSAkfWk1ZTUN894jBF7iMIP9vpcxA/vsR1w/kYeJTMnsomRv8kknleWPHfy
	 Oj28nxAWV23jRblpvfSC6hCLCGZ2EfA65cx8a0El6uqWNpkkQ9ZOWbbQTiMbXHn9pxEUl
	 Z5285qV6eS3WTMf+pW/icoamEoVBtIEtX4pU/Ut5lqSTAGj3Q3NIzyDBipkpBYrMY53jV
	 C1rWf4BU9ykJ2nNQUIjaAboh9IUM50IWMeJpAloOren5gl5aAAEMqxUDQAVRlGLdDBgWK
	 yE4r7zpsDdKx2VRdjPjrR2As7vnLP+IuiT+ynShMggiSVbG9AWE6CsIfZsRszX/fpLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757864;
	bh=f7mt+hZgnF8A+7TRJsC+6eCaFdNMInWd74+QJIoAoT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H5WKe2C2RmoX0PJTT0eMYbEabpcLka/VM4ajKf+ZhrViJ43LKOKvgYDolij8yLRdg
	 Hxwic5QFY4V55TJlD3dNczWU3K622arwu1ZBi6jTX3tPdSlA9LYrM4xTJJ2ZpjaijH
	 7MRT8iyAmhhkwvGBF8sHXCCeHvTX3N9GzuTljAsCRpcLlVb2AZtClZK6W2CQpTzmM/
	 7r9+YitGfZsPomKVYRnKQ3Eh61o5TGoQ4QsLjX4RQMut27GjVh6yzolth9CSiCBkxP
	 S70eH6CEH1P5oiBAXheF9EwZFPGdm0R8arysFNarYe8srwyBlPY2j5SOskCjLlTDeg
	 jZoL6LyxWpRfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F3E9606D7;
	Sun, 11 Oct 2026 22:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9844C75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CF4E80BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ax1FbpVUNey9 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D49580D00
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757860;
 b=mJS/CnwlQJbEfFNwStxdS1pZ1AS0up0Ud0ea1niBf89Dqw9oFOZdSQTBwXsi5PhncHCg
 jRAYPn6XUdHJYbtYZ3uYSCqNWXI+NCNL78Hx6lwbQDeVEmdDh0qEXkhgKium8ycCVtOx0
 SyYLINpEO9tV48/wRyGjq4XjCbx+0My9L3lnbFXKgPrkvnzOc1ywj3Y+PxtuUff4mNFMb
 jcbv+a1t0GcVo9Ja4spy8Um6FyJT1SpL/Xxk67FmO27P6FSolOkO0fec5QUZeX4AZn6jq
 ye1brxY6/4JhOgfYuRXFeiKEx62vsFUrVv46jhp/DBqiwcatfk3nSAgEd58SYh284gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757860;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=f7mt+hZgnF8A+7TRJsC+6eCaFdNMInWd74+QJIoAoT4=;
 b=ftvs3sg8YE0nxMA7n+s6YhXXVPxIbAJ1H+FiLLepk+Cpk1QOALfrjdHqpee9Buc7D2CN
 96E32t84PPTexvComXTR2LNBq6VFRs84hwzF+MP5iPhr1uvxcuQ9MVwUYEcTtgEaH4Bsw
 f4D05R6zryEfUGEOeGX1yqi5rH11zfapf4Ankw+lsi+NcHXvUgduPpk3pqTjJud/355H2
 EYVA0Fcm4dz7TjklvVkMHQBMCHCO/gUApay/Q6QKwCdaCVwuXFpS5o/7U0B2u1Xo+8pb5
 LpsA5cWoKHKSL5QQfVdMrr86J08qZzdPU0kuQ2g9pWWhifxDZAcdDyAQbFGnyZQTeCQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=mvqZkZOq; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=mvqZkZOq
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D49580D00
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757859; bh=f7mt+hZgnF8A+7TRJsC+6eCaFdNMInWd74+QJIoAoT4=;
 b=mvqZkZOqi1qnElx+6zzwcnJHwvX/vy1vlOmbUdurRwWfat+97j138S2beS7tp6zloKF9d68zw
 0MgvbjgAW1VJvkMoTxwmu20rLT7xaCsOexEbMO97oXJWwZLf05C9ku9EGsFbB8BLTx7Ihdnz2uS
 edCgy26cfQYFsXJhM0rb0Iij8VTwqQAwIAmmtn0GJijO30ooEuPsiTuGN6sbLVIZNbmKpdqlZQu
 YbfeHn6i/dwGNy7YREqhfE2bzjrN0AUyUhCKZoocMypFLMY8nnptL137xyBRZF4FarL1H171DQo
 D0JGUvugT9MVlv+e3TpDOJn9PiGmEt5j/BA7NP2LXndQ==
X-Forward-Email-ID: 6acc0e224548822a24c1750c
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
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 23/37] clk: rockchip: rk3576: Use correct clock register
 for CLK_SARADC
Date: Sun, 11 Oct 2026 22:28:58 +0000
Message-ID: <20261011222930.1085075-24-jonas@kwiboo.se>
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

Parent and divider fields for CLK_SARADC are located in CLKSEL_CON58 not
in CLKSEL_CON59. Change to use correct CLKSEL_CON for the CLK_SARADC
clock.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3576.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 04b0f6b13ed3..17f9b01ff0c8 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -691,7 +691,7 @@ static ulong rk3576_adc_set_clk(struct rk3576_clk_priv *priv,
 		} else {
 			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
 			assert(src_clk_div - 1 <= 255);
-			rk_clrsetreg(&cru->clksel_con[59],
+			rk_clrsetreg(&cru->clksel_con[58],
 				     CLK_SARADC_SEL_MASK |
 				     CLK_SARADC_DIV_MASK,
 				     (CLK_SARADC_SEL_GPLL <<
-- 
2.55.0

