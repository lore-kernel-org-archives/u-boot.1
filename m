Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA52CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C9B840606;
	Mon, 12 Oct 2026 15:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UIUWTVgTZgz; Mon, 12 Oct 2026 15:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7FAE4058A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817567;
	b=p58OO/8CNrKp1J5nXCmz6ZJNXIPuAzXlq55CG7wqqknYWWdFQNq3Bz1+TJuBbJDSwb0J
	 aPsJ4CpbfDBAuTvDnHY9yWqsr34ewFt/8InCNWHwZse6IVTl06lku9xJBbVrJyD32EeKU
	 Ld9DeaQwt7efjQf3OyqHzkLs60Vz2P5i6PxVTiv57sxIv+Hv+k0sqaN1pH1VwJgSgH2uq
	 77bLrJrmE/RxSmN1ODp3mKjnYISq+BdaVsaacI3jsN8c7RFv/ekx39iarZTgRD79qOwXk
	 tN/WBAcx6xM4EYkB/tREv8UQ3wTjkm9x8ncumo7d1T6Wxk3pn8YBylU107GFtGkNybw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817567;
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
	bh=BjGqJQhUSJo9TNoXGR3sMUx/ENQhn3ux+0GIaBvrZ48=;
	b=ho3ZNU+JaiaDsJKb/s42Fu38iwb2AmwGemwpe4QeNr6GEC6MyIolcJaHdKeE6DFp808v
	 Jggxj1DqEf+imnQtwwMAaClqH5IMMO2/XYiRbcMh1Tu46ko8MARKqV50vjpjMZMftpqCO
	 mkCPyn8jmS35eyrZsOWnt6Wv8mkhJzhbwOcZTRCDCk19Tr9O0JqwxbBPnCKG8T2QoobIi
	 FH93Nzr4Qm2y65EM8yzSeooWZV1YqVkxqp5BiLOQdZEn6qFe55y96KgR06sYeyPUFXSsM
	 oM3IYtU4I4AhqX+dBDZvFxUlRBrycOu4MNkvh7zG+Yg1ugf03QDRRckDJlM4auZQUWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817567;
	bh=BjGqJQhUSJo9TNoXGR3sMUx/ENQhn3ux+0GIaBvrZ48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyjgWkd0lwt54AIDlOdVCFJJpPFEib6EKbe2fqZZn/ujXqRXPaQwCbQXTXl/1lag1
	 Ndg00ru3II5qwMxdnB3fW3VxIYiseVXIV84qjJEYtie2Shlbk4j5R0lWFEgaDr0fPe
	 AGmxJxEjoYsCe9XnkjERMwMfWeQybxYxRb9yvQ9GSGg9yB370eIYeQxNC4V8w2H4Wm
	 p3VzQ2mTvrYtXJk8FSseXH5TDDQDKvwxE8grFWakXleCsFZ58Unfm88gJbeqKsp+E/
	 ovs7bDG31tzqGm34Y3HaUlzg6ToQeBj+CCGlWFiHdNv0HVjf234ybdUcsi0dJDRjVW
	 V0ISws3PcSegg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7FAE4058A;
	Mon, 12 Oct 2026 15:06:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 608A2105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45FF1606C0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8w-aK_jKfQGT for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 832666066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817563;
 b=Xqv+Vj2e76UxfxHAsWsJf7uVO0eCupEDMPiJICDp6iJDw7OYTIcsEeR1SHZ82g+c7Lrt
 sOHyAcm42Wukw5MieMqJUUTZ3Ehfsn7j+MgrrHyAEncGMF4yBnPe9a2UAv6/t7yMlOGXe
 Chxm22fUro4o/qfhOIg+1ut+O8kk/uAESqzDX0Yjrp3CQQPwghgrpez/XWzipw96U98rY
 +jflykQrXoUHGng7Jo/TCxkv09u30+ApIbFWDmuU+O7sdqm+3MXe00lleehMpxddb3B0V
 ws08yS2fBaGZD8a11oQ5VEWVAuslZKzpzz4RtQo9VWhJbzGMogmG+hVCT8/C5klR6dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817563;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=BjGqJQhUSJo9TNoXGR3sMUx/ENQhn3ux+0GIaBvrZ48=;
 b=Pj/J2kvLw4iqv9jEf5DtyBa8bQp8gxAIfUECBG92N1bAY0qqumRCLCepm05upAqxU+A9
 Uz5HPi4OrWRfPuhLNIgp4DuCW5dtHS0Ty4NP7dND9bvne2KqCY/vmSDMLxMiQ9UOB1RZQ
 4D3iHdGZ0MpvhV1f2g9oJH9cAtdyKbtsf7CoSFvCz7VxPQZgcFcCWURSQHU9xwRjYPNZ7
 qH8TAf9u1BX0RaaVdEOHWnA0Llcyj844o5iD1BR3a2XM+1f0AzbbySd0i2uMhcqnZVMAj
 AOMN3ndnntZsOB1jgD5uW0x/8oq7o1M5ywYih3+fdHZJ4OeMpadXfRKzaAjhNQgYxxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="kr+az17/"; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kr+az17/
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 832666066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817561; bh=BjGqJQhUSJo9TNoXGR3sMUx/ENQhn3ux+0GIaBvrZ48=;
 b=kr+az17/ZNSpVkgvaE1w35OdXBRAxZ91DNTAKhBCn7iSkDLGXf+vzNK8BXOE3gmds30o818xY
 VC6Uu1vporz1UfdHY0ZIhdDU9F9mijJ1RHIkFIj32+6/P0UHkV2W1+zfKrKRS9zDmv2FLGxfVNN
 x3IS2SPEWZRGH3IkskK/iiHiFIoGP4kZ6v0ifjTTbKR5lk+ghEDPKqGSnQtQn0ZttsoOHKRcPne
 0zPTCeg1u5BvQY0qtOpRCzTi2CNZ/Mk1QUHCtJ6rZGIXeuWh9XMqWs2MdieXTPl2n5QHxSFcD5f
 9BX+imRBgUxo9j2/iZQLh1qlXlduE7m4h6aD44f1cW0w==
X-Forward-Email-ID: 6accf7588ac7302d53a2c945
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
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 6/8] clk: rockchip: rk3588: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:36 +0000
Message-ID: <20261012150542.1182209-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012150542.1182209-1-jonas@kwiboo.se>
References: <20261012150542.1182209-1-jonas@kwiboo.se>
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

Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
node of the clock it sets up"), first included in v2020.01-rc2, added
a clock-uclass post_probe() hook that applies clock controllers own
assigned clocks.

Remove the redundant clk_set_defaults() call from the RK3588 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  1 -
 drivers/clk/rockchip/clk_rk3588.c               | 11 +----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 85cc17840436..1058fbc19dc2 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -50,7 +50,6 @@ struct rk3588_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index fe3fc695c15f..51c863a7bfe3 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1958,9 +1958,7 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 static int rk3588_clk_probe(struct udevice *dev)
 {
 	struct rk3588_clk_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	priv->sync_kernel = false;
+	__maybe_unused int ret;
 
 #ifdef CONFIG_XPL_BUILD
 	rockchip_pll_set_rate(&rk3588_pll_clks[B0PLL], priv->cru,
@@ -1979,13 +1977,6 @@ static int rk3588_clk_probe(struct udevice *dev)
 
 	rk3588_clk_init(priv);
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, 1);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-	else
-		priv->sync_kernel = true;
-
 	return 0;
 }
 
-- 
2.55.0

