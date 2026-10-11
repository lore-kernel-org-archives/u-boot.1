Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A623CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F57A605F1;
	Sun, 11 Oct 2026 22:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pk2YStiVj9dy; Sun, 11 Oct 2026 22:31:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF92F60612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757874;
	b=okW+wg9Uq3c7DVOPjlPVtnn1mBXKllQqza7mUeJ6OR2iBwJC0gmsKmLv5oGH9uXErQRc
	 68gvT4QaIOdvkQ9UvMTymdXJSk9iBiKl2p7ObvFmUEaCze9i79cddzETS4JKYxc8PMRTt
	 NP2H+ktNHaP+qcnhIPZLZ9xpgsQsoBiHeES76ziPRaI8e3vdr2iW8TMbB8v9piniuiV7T
	 8N18ZIMAvpqVDu/jTeXzi7sw64BGJOa5y9gt4ZltodyWRgNDBUotD0q/nAcBN48m5VQ/E
	 6ArHE3xrYx6DIJGvCxCWJZ+RApPYi0Gmbom4qNAWaVZNVAdm5K07dmlc4xs8EaBvGWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757874;
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
	bh=AuhLwydBlubDdVnNOp0FIXu3+vXPxr1aK7psslm57bg=;
	b=Hi6G7vQKKb64X84TK5cE378tYK71rA/8xJVk5eIqhjIR8+MtJubxXBFfFiLWwSZM3N71
	 DxgF7GjJZZdJPcMQSSJkuTWWHevgE9TtkOEhLE4rBMOqIRqz6pjvuwsCQltUXaognQsbG
	 Caide9cUAaTLuH0k1doxakGI7OyrZxys8bvhH8fYGKpYB5wDHxZ5QQHGj+l4P/qZTW3AE
	 8nbK6zDIBmJcZd0+XQQV4pd4Gkpfwas6nUwn2SfjYe1JFatsLpvd9SUO8yOibjzMI8nJt
	 LI2BtPkz6PaNWqsyiFF4LF+kx4H+FoFR0N+27+SoDiojpTstZVSgllEl0XdwNCWZVwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757874;
	bh=AuhLwydBlubDdVnNOp0FIXu3+vXPxr1aK7psslm57bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yk42TEnQsL3LyQK2JmL0nwcMa1cFoJyb25WJWMWPrefPlzOPLuSgOI/0sFJAZvlJ1
	 7CFMEk9pPV8yHUmIa3ALYXreS15Xng0qY7XSidrdy6ykYxH2OyznYwFlDJbOJOAGYk
	 SmTIsOd7QIVGuE1VQK7C2pNkm9y2Eu/owhS7rKyb7SkW5sZh0b9LFawWByftz9mtlR
	 DaocZQ9pqTKThXlfg0nbZ80+Bd3TgVThVN1FwokucKiB8stvFtVl7Nx4OUpWT0MGhB
	 7riz90egQW02Ly5YXCmw85HPF7Ju7z3JXGI0q8rY21bKkWbPiZv4zkXAMc1nYHEmjK
	 zgroWgSgxe2lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF92F60612;
	Sun, 11 Oct 2026 22:31:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3167875
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23C2880D29
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1GsJwHmnSsX for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73E5180CB6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757870;
 b=UlGzy7vpeBH5rNbds2P3Xer9GKIKiNr9cBk6QKR1Z3wQRMBy/sRYGa/yJUBmasEVQXZh
 fbVlbjyKKpjmQOMF9YAfJYTmRGquUoPmzKLsebPc4AbDNtbNCjEGY4tUkTSFMleGO0soT
 bN24bmqTCKYjPQZNYAY2M7ewmeKYpzSkKNEZYyGGSRmLpzQPocSTcyT5AJbEmleFyU7rQ
 PbAzEVqXVgyWJvripYJnWRYx1/xMwPWNpbYfEPliexBAdwXbq4alFf4cCLAdnuytDLSDk
 aLBtM3xPYFgiwgO6luKX+pKx1pGHY0MBkgN+GuEr1QoN7oZx3iLQUSslqxs1sAwoEUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757870;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=AuhLwydBlubDdVnNOp0FIXu3+vXPxr1aK7psslm57bg=;
 b=rDf3GECLM/xdabMck03JqX5e3J+5nCdyzcT+w03VEC+LLZZpYVJekJUkXewVKCQHJGs9
 zFeRVlB1X4QajZlXvxzhIz+pwhfsOIatI+yr86J4jjsl7kLhMN3oEejy1X8GEOH+zz5Af
 N3TKGcnE9fzM2ifloweHngr/oY2Me0aGN3rE9pzgNRyAAi5Rsa6ro+4LNCkQ1LKHk07eq
 30a9n0ygEb5XHMI1XepfafE1Ci/n313AdPwtHvE3Y2hu2iEUC8yggqaYDtb1HIC275Rs+
 aPjc7Th1ySnalUIljWM/uG5itE3TiL/s7/OVlQGEfzQ2/KRP6u5+vXkp1zltuZdqSjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=crjXQxOK; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=crjXQxOK
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73E5180CB6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757869; bh=AuhLwydBlubDdVnNOp0FIXu3+vXPxr1aK7psslm57bg=;
 b=crjXQxOKTuZNIMJcxkw/aiVthJTvHXwxPb23S2OIwGBnDMq99KZ0Ds5+AP7qLz1jyV/B5Oum5
 2xG97cnU1aUzoAkvWN+2sh4rxnjmmuYKROLO8dWsaHtm2kPDoL+/0sxvd5whrQ4U7F7gUw7N4vk
 OynbfjIqr+mQ1TvKa9vl76rPAMWhOYlsAbeRdd8m2i0d1oMNx+RCFxrxZw3VIb/zREh4G3BXQb6
 v4DqyU6O2UvUVMgyYQNVx3+9QuDf/2m2hnJsXYMScvnABZ/V9m2UdWimnWx8aUGySE3oM3xfEzm
 kNKVkXD5UkRjP3ogRN0zI1JfvjlvUqVA5oEBqNo9FIXg==
X-Forward-Email-ID: 6acc0e2d4548822a24c17565
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
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 26/37] clk: rockchip: rk3576: Use correct PLL rate for UART
 divisor
Date: Sun, 11 Oct 2026 22:29:01 +0000
Message-ID: <20261011222930.1085075-27-jonas@kwiboo.se>
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

Calculate the UART divisor from the CPLL rate instead of the GPLL rate
when CPLL is selected as parent clock.

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
index 7908a3c95765..a7110b86c063 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -1843,7 +1843,7 @@ static ulong rk3576_uart_set_rate(struct rk3576_clk_priv *priv,
 		div = DIV_ROUND_UP(priv->gpll_hz, rate);
 	} else if (!(priv->cpll_hz % rate)) {
 		clk_src = CLK_UART_SEL_CPLL;
-		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
 	} else if (!(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0) % rate)) {
 		clk_src = CLK_UART_SEL_FRAC0;
 		div = DIV_ROUND_UP(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0), rate);
-- 
2.55.0

