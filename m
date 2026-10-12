Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B3CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6950606CE;
	Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkzdvbM-ZYVK; Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E5BD606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817564;
	b=HO30gU9CSgu8Mz8G4F8zx+P6jmE6k+o9N2LD8dblb5qvT/T+7Mzy8M9LrNXbHfxW0+7I
	 01yMW1upXu/haRbxjgLy2yHC5BwHRph2QXFLsNlzUATxnkbdG/512ZHRDMUvEr6rg4Exo
	 8jlhRferZk5VAWp46TzisRAmCTYB5UP7JvbGxbzc/DelKC7Dik3m8wdobc9M8bZHvPuly
	 KkLvRZBFqfMPtLMyPup4X4CpXhn0S6o6bhYnfTFs+kEVs3I057nKCxgtIIluD9/QY+n/A
	 FlT6vclmzOyGMryePIW/8ELujeErIWIuH23AJ3LW2ojSKk8t7TVEwhnYEVU73BOj8Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817564;
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
	bh=RDDxXlBPh1NxWBnLeed2G8vIzcb0rgOAGAIcOIHhEQY=;
	b=gxVSSgdjK+WUrmEdUb978ANs2+nzlBCOhxkD8jF+7Rv2RoNInTHNYNsnmn5v0iH6ipZ+
	 ATCQexIKI+eOpmSO34r5VyGM9+gJ2ji7BsJggXmNzaHLaM6Qb9QO95N2KsDBKI0zVSzo+
	 F4y3XhTtsEOFnLhhQHv3FjotNeZRPM3MAlHYLUZAibutpX/4bTGN8yObmJldKjWNa5xbo
	 NyKNyxSwU8GTjRvCgVpOj3x2gxtdu41PhW7jZQKHFqx34Uf4ZU5te/GWzf2++RDqmQ8pG
	 Bm/dW/XK5hR0qaKihfHmVNMBVmtyztQGzmgfrEizrL9o/2J3PTEpvm7CQraOetx4g5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=qN+E8PpR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817564;
	bh=RDDxXlBPh1NxWBnLeed2G8vIzcb0rgOAGAIcOIHhEQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wPXbTqmSvQqyRQvto8jRJKsC9RDOqg2OrRCeXcejwab+G6SH2IsAYhthqi+g1fjxG
	 TAmiPM6SWmcLwr6ekKFzVaIbESIBDEhc8Oy1w05xJyiuACVyvNl5nWtYQ5l9PX30ZH
	 Sg+iEnUa/WzmjsrCJI7HeXtLTpJWL4pYQLV4QoSKT9yFqqruc0ysBM1Nf2arlTKSEy
	 eNnjJ9kPdeSYu9nWlkLpfhINztkJTepGn/1cP42u0nMljLb7EIcdYbF5xS2Czts0oV
	 uqqEQ7oMe+WU5jhs9GGSMzjvaYGAm/tKUKgRlvMzfuqO65A/gQoSLxqykySY969qwh
	 q4J2nqkxH+0sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E5BD606CA;
	Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EA2D105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 013DA6066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qk0U_HNRy0oR for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1552D6064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817561;
 b=MVzScvuUHk5bjCKRYeajt//HiJurb2FF+V6EBeSD065isZbEeEguE4PIljcazUj09vZ4
 Val7qpqT7FcH9vx1vsy+WVOYa3KIvi8LojgRS537S+zZ0JZbh3oHcTwC7wnPE4ZCMjf3i
 uhsAcFMSNrORCHurJDDcbUnyEKBHqSY8bPgqWz5l2Z1AzRG6AypdIr1PQK/Em8VBwmWiX
 4Fs9U4SrF0JjU4g8baozcqkcfvuAglHP+rAn11Nrq4ZrZNHrkXDh/H0PKlJPndiC6RpP5
 Qm0khV+cJjFOVW/KFWJ+ym9yqYrxYrpeAT9rXNykAaxdz7R9S0TNxtNKqacqWWfeGYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817561;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=RDDxXlBPh1NxWBnLeed2G8vIzcb0rgOAGAIcOIHhEQY=;
 b=DoaaF4JSqEGjrtj9OfL+tMxleBSxwDDTX+AmgYdAr2kPXrtpXSLot8nnsHcttKiITQn6
 hMPYX/7P+qFZKJyw3Lj/I2J0VQtlSyWVooSJ41EFOsZOz40XugI9CKReD2hM9RwcD2etb
 2fmASNkPSqUmjfi2Cf/+SjmLSPDGIDHx5aW4dbUmmoSNUHwztgpe7Uz2c7+cBA1+JYq3X
 yaxIcu7H5ydgRrNooQo4APD23n/11MoqtDP/udUrp4npBC3xSx0eo2kI9vaSB2CoKEt8j
 6zql0H3mJ//3PmULMv4T2xZwrb8dCDQ0truDiepRSs2lYfaVsxr7Yv5nDt2VbyGKwXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=qN+E8PpR; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=qN+E8PpR
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1552D6064C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817559; bh=RDDxXlBPh1NxWBnLeed2G8vIzcb0rgOAGAIcOIHhEQY=;
 b=qN+E8PpRXQxrtgcknhowxu2dcCM3Z8y8MSBomAvoQVzArTKf/UokPbgiDGFnr6n21KwvwjgLL
 bt0nnx9zIEd0zz0426uNkA3XhPf5QEqAr3GJMcGhbQZcBFQv1GvoLoqEyxdLHusHiZyZDaalsOV
 P4YXlQX9Z/iYSoYtAVhHdGYrpQHhKCWQ+37Z1tbMqf/ZLBucEd2ODsCADd8gY+VbK9GQEhZEe3z
 oT1VR3btoUt3lmRmUMLQPTxabhOZlj9sfoOPRNQ6mCl+aEoRx4JBPhbzESmqTj9642OMgcreZqe
 I0JMy1RAHQNHhe2YsgfKTwQHT2cxpUtWSXorI8iyUO+Q==
X-Forward-Email-ID: 6accf7568ac7302d53a2c92c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org,
	Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 5/8] clk: rockchip: rk3576: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:35 +0000
Message-ID: <20261012150542.1182209-6-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RK3576 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h |  1 -
 drivers/clk/rockchip/clk_rk3576.c               | 11 +----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index 41e225245843..c9a4b1a47b6f 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -46,7 +46,6 @@ struct rk3576_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 1988f0472dec..3cbc90d37afe 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2443,9 +2443,7 @@ static void rk3576_clk_init(struct rk3576_clk_priv *priv)
 static int rk3576_clk_probe(struct udevice *dev)
 {
 	struct rk3576_clk_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	priv->sync_kernel = false;
+	__maybe_unused int ret;
 
 #ifdef CONFIG_SPL_BUILD
 	/* relase presetn_bigcore_biu/cru/grf */
@@ -2501,13 +2499,6 @@ static int rk3576_clk_probe(struct udevice *dev)
 
 	rk3576_clk_init(priv);
 
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

