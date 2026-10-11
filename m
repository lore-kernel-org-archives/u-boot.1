Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E2CA9ED2
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A7D580D29;
	Sun, 11 Oct 2026 22:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KnfK4Q2SBtbq; Sun, 11 Oct 2026 22:30:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1C91B80D18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757822;
	b=qJmm6Wp4++bNcmx6hK18Qk1kjwcV1wanq0pOOoTwxbq+wkKO4Ixalg8DyI9NDFun88+0
	 JkzHnp8aiksNHtjnO2B3y7fu3O/sfy2W6aTXsGbDR1/AzT42aQy9UL+9Rd8ccu3A4I5zM
	 CNOWxjPQ6BCivW+D3y85J7cSi/mIVKnYUExbYZMsDbbakqabuDJxcsCHMwu8n7orwMDma
	 1uWMpB/KuItF4xzIkiSXyC+Gwc5UbP63+P9jJwI5hS5zBMWsPgMHRmqY6NsDPvZBmj/gx
	 mEapIeLJUpDAQNtF3RjYBpPW//kzXwMWBd38+1OuxwktNv3sJ0gXrbky+OnGvtx7NdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757822;
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
	bh=vdOidMIPjrzXvaCQo+9BhwLOMPmJIUgXHPMRnZmDwoc=;
	b=AnbYan63lTbd6Se9u9lgnt6YfPIb314oNjFbJ5ipaPzsyeikPMjlrSD+GEA3RsUNy1NJ
	 YxSU4OK6+A8zRsTvNHMVztpc10aB3Iok9TXZe7VbBNiIK47c+3yANBfOaBUYQXEtQzL+n
	 2lmiyME4YqIDdvR5Hu8yU+MvWilF8hgMVq5xlrZcC5tx6DS0hqSg0F8hSPdCyyetnwYEO
	 oMmetABLdcqel5Px50L2cPVHfLHNZE2NhluI3Le1KX6xQu4kcbGz+CbUzBpL/NJaWqMpZ
	 h/5JA4sMksFivLM/mxHTeaivJlIeRQzPNuOteAECczRCvCcmrr3oEkEzguiBwwN6BwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=bZ+MWWUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757822;
	bh=vdOidMIPjrzXvaCQo+9BhwLOMPmJIUgXHPMRnZmDwoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KnB3frdnDBPCMDkg2ooXA2oRkXo0QwMw94kecUFLJOYdP8TlpctYe+5ykaBzNOhYM
	 hU26XeOBO1Mw8OqqatFmYt+DeVy5qbSMOG/8nrH4pnr4O4MCEMCizqnzc+dT5eZRKQ
	 87Pn5PyRKGfD49s6JCDISHcpGHIcwxhTKPfSWa1NgQgHN9TMZpmbTV5CaN2dsjbPYm
	 AcLPwpdEWJU99BYrKLdHi/fQ6LBiqznfY4mP9su3jLF5YPU0HSxzVDPJh66Y8RU4I6
	 Uke2Id3+a9bXLDhDL1t3nf09uzwoWe4IjGVeTIaCQAnLccPbzrT3e0cfIWtr4HwQGj
	 QbbyFBq+9b7rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C91B80D18;
	Sun, 11 Oct 2026 22:30:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D74551DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C91A580C76
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eY-pLr_bo7xA for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3368680BDB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757820;
 b=Im82W5ZAIpvIEFTpE1leSvtaYLKZGc7iSHJKV/om4mo/qn7Gi91hNuGe2hHr2o82emxy
 QKuyufUWMhYesRrfcn124DKYFV+dITc1+aUc2j0hGsx3lqzjxOGqLH6lBelOMuH7zSjoy
 sO2p1vxEnZ4MsgiByZfSnw2eAm704L8NRPcG1Mw7CfeafdX4bZC7I5fglRTLx3/xyA/Wi
 Vd1mBHhnQq6SKNSB9AMj+MGKwe7j/do7IFmjr19bvO1nQNTBeO6UkqzTmaNG5zxdg5eQI
 e8CegmCgUIbvbPJ25+PBPW5JkTrvS8YPDF6LTvISh3zAw9WgHdfqX4qgRmiV33M9s5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757820;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=vdOidMIPjrzXvaCQo+9BhwLOMPmJIUgXHPMRnZmDwoc=;
 b=Wjnonq15yjVnxnNps+Kbtzx40EeOlfmpW6oT/dqpM9+F9L7rYtrITtylxg/s0XC1sXZQ
 XqhkqAMvJJTwVgsiDzbi+8v3Ny3RJUOEK6ZJ6grKWNWCo+Qfe2Oty2bnnZWuCkBwBvdFc
 rTvGHrqLZCcee02QSzpBllIfRT5VQXKkex2sbiBreN3YGEkPTYSipti6+2Uflm0vaqpAl
 A61hsrfQli1YBMY6SgOYRbg34kAq+Hv4b3jLqAZt98MxfT3khdV699ruN5+rn8qCI05H4
 U9t5q7aiwzFzcDV6lOiWOfF5+U6aqT07amZVT/RI1EMr05jAXBAz9VKKxIYqNCHPI6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=bZ+MWWUk; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=bZ+MWWUk
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3368680BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757819; bh=vdOidMIPjrzXvaCQo+9BhwLOMPmJIUgXHPMRnZmDwoc=;
 b=bZ+MWWUkNWf3OHYA5YtXCJKo70EVq7zK7NvGMlI1bIfS4Sr4qUiBKkO03BanTzAtFAGlTqzOs
 CV9Wdo1lkumj5vAYI7QfIkk6535DNrwIIoIx8IfTrzYVMojQYfZPr7EAXOu6FaUKKSD6KUbcdr8
 N3B1FBB1UAjY++/Ehr6EWKxD2+Hkf8BrUuzsacyniq1U6vnaq2cEi5bcXzSmjt12B0XHf3/IHcM
 z+Xto2HbGVTZOcrnahOUpE1y4Mmn9CDZbeO+secRbO2DOUzs2SX6DmW5iKJYBLyoeEOMdmTMDVJ
 SNB5FRG7ZBrsZcqp9byjVqFrXxEri2QWU/8VwcP6W6kg==
X-Forward-Email-ID: 6acc0df84548822a24c173c1
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
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 11/37] clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
Date: Sun, 11 Oct 2026 22:28:46 +0000
Message-ID: <20261011222930.1085075-12-jonas@kwiboo.se>
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

Use the GPLL rate instead of using a hardcoded 100 MHz parent rate when
GPLL is parent of the CLK_TSADC clock.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index b9fd4bec311b..a4fd3a57ad7f 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -655,7 +655,7 @@ static ulong rk3588_adc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		if (sel == CLK_TSADC_SEL_24M)
 			prate = OSC_HZ;
 		else
-			prate = 100 * MHz;
+			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
 	default:
 		return -ENOENT;
-- 
2.55.0

