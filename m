Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ED3CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7D2C60714;
	Sun, 11 Oct 2026 22:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkJCPtNDA_if; Sun, 11 Oct 2026 22:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A63A606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757894;
	b=lH5aqzevVnEZJzJBroHFjCDs5M6iTI/3n0kftzy4bx2QLjt1pMiJkl4Y6xhJ/HEqnV6v
	 DM1ksxtDmmQfyNmzz1ns1bUYsBXXWqpQaRAbay+ptjvaOlbL1/KglK4Z2//7TXKeUg8pG
	 2i+r0+nvrz1qDc57cZij4Rg27Wy+J0+ibA6nHmjMGydvVMObFV4N1pgqFfzHNqf+ve/m3
	 hqLJ0Z2Y3zYjSwYSsMyexFD34NS50N9ITyB/csUXBQhHKTldm3BTuHitTKIDhhY5Lsapw
	 iatBjJ/S9qyoICpvW8cqqTfQxqv0s52YdFamwJBPX7gdB4yN6AUIXtB+7DdmjAV7xUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757894;
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
	bh=MpLJHsRNe0uu5zB8/V8JC+49/PWfmXjsuZ0I3xO7HKY=;
	b=kxY8Yqcs5Kf5aBv2rkt3/FvSdwqV2xP/UwwOhXUAiP6w13IMhWsnI7HvpksPjE1Q68To
	 9t+LGDXjkq6zx+t5BmKyg+fJmo+vn0Y3fRj9EC47tpOFbxcv4sJqiTDvGGq+5aovI0x51
	 GFJS3JFmmPyZZzme4v4JYpg+UuD+3mbvyj1hvmf2Kz8cp7Go2wpzYYdHtktF9T5oTR128
	 BpDABQIjKO6UCnlhY/p/QqNKE9hsDWoMXNGUaQTJ8rSeWa8yid/hs6ZmgsP/4OGgA1TlW
	 eAdZXroy4LVtGF1hbew3l10ihUaH4wP1QpU3gQAP69i3ssjNGvq4DItF9ZbtisrT1fA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757894;
	bh=MpLJHsRNe0uu5zB8/V8JC+49/PWfmXjsuZ0I3xO7HKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDqyOuUnL/RmGtSplvzJfk6YOVzvj6J00/mVejIqYQ0eVPbcPTsXpD0e8SuS3aPKO
	 U9CX/8dtiYhe0t9RW6PN6huOwrvoR8rUFiId2ItttDqVsrO2TWZZ/lJEwIVlgZENig
	 QMLdevF7Aj2Rfy4JKD+1paG3lj9gDraMWC077Sn9wrjVxYqKOwhY16By30zCYZEqtM
	 q6jTuVEukZ8N34NimFAa1ARAESMfL8ln2/c/DQrY8AsGzfk0P2ozlPBwlK/WpbxxUs
	 9sfiXpWKWcoNJURfHo/QNQNVcDKknd9rDtHF/S+QDm3Bokv+e4+lgkN4dRd7T+lhJb
	 GWefQsVSbhtEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A63A606CE;
	Sun, 11 Oct 2026 22:31:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 372B8194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D86480D5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMSLMsCeOnWr for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E7E480D9D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757891;
 b=OsSYa9Mm6S96KroRWUS4aJKatJTEY3Iwh9Sv1tFQ29r+8t0KxmX1m0TRFzHdvy5VL1yU
 u6kDQOL7KJBwJAgGP2IljfVtfKw0rROI2POex+99NhXPXN8hinMcsIx1Iim8d/REcZgWX
 HX4lxcgj8KEcAUm49OI1HIHPrdNRLXJfqsPtTb22qyPNbbdDx+FdscjG+auEb238r4r4E
 ytnKcSvsDL/SKVdMCUUjzdjQP0vTz05SI6i8NieaT9LdwtWgyX9TAteI7k245YHusXz7L
 Qc45RRi/Edlw/ti+7nbUNahRzTvxRzquesebTkPqphjUK9GHEecOaLQN3Q45sCbVUVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757891;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=MpLJHsRNe0uu5zB8/V8JC+49/PWfmXjsuZ0I3xO7HKY=;
 b=gegvOt4ef8/Pf3hsrDSuC/21Torq/kbtZR0Akj6ghNtGSnfJ214jdRFp+/QWTsx8KBil
 ASWLdjuOCM7UtTez/VSfBa8l0hd74F6Y/YGJDJre97yMfbqOENKJfeIM2oYslo0tOE5Xc
 whoSNCA5HRVvHNC+b4tEvw00PEbvzmAGe7YD5q3miZ3RzerY/6HGG6JVjKC6oaAQjpRh+
 I4QSxqFO8IjLth7XNlkXKVba3PJMepFNnY3E04+yUOy+YjG3txT+YN73WTXwJ8/j1YWT2
 c7LqKZL1nNg23O4XcoVPipK1ppvszFqUlGv+IHD/r/DpXPH3OtJ3oMhZIJjdTBE0+ow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=eMtT+ptH; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eMtT+ptH
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E7E480D9D
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757890; bh=MpLJHsRNe0uu5zB8/V8JC+49/PWfmXjsuZ0I3xO7HKY=;
 b=eMtT+ptHbnkwlv3MHGKhcFTVBcKvciV1RXhShP1kIS1b3xN2zCW8nVto/jooRC8bVW0vFNz3S
 /sqPB4OU9nZI/FO6RLSL1GEKuIH+0bHY9Q2AXLz94hA8+enP+zyAJNVAvrMLqzVDW0jB429vee1
 koJSXKICZMySdhUd+GS35WCByiLrq44S8MKEnKowTEImx6BZZVXsNIAhV4P0pGQR8yVG21pfbqg
 DW9K/QndxKVBZdFjPIv+BjrckTv6+sr2KdvtlnAE4F/Vt2qQtxVC/VDq3HvHQKooIR7OpSJ19Ev
 z0uDnKxgtnEZWgGQ23BwyNO6c4gb/r2cpczXB0fLFLhA==
X-Forward-Email-ID: 6acc0e414548822a24c17608
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Finley Xiao <finley.xiao@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 32/37] clk: rockchip: rk3528: Fix VOP clock configuration
Date: Sun, 11 Oct 2026 22:29:07 +0000
Message-ID: <20261011222930.1085075-33-jonas@kwiboo.se>
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

Setting rate of the VOP clocks never changes the clock parent and the
old divisor value is OR with new divisor value due to incorrect args
being passed to rk_clrsetreg() call.

Use selector and divisor masks and values correctly in rk_clrsetreg()
call to ensure VOP clocks are configured as expected.

Video is not supported for this SoC, so nothing is likely going to try
to change rate of VOP clocks until video support have been implemented.

Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3528: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3528.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 812710872729..82a1b6e85b5b 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1097,7 +1097,7 @@ static ulong rk3528_dclk_vop_set_clk(struct rk3528_clk_priv *priv,
 	}
 
 	div = ((DIV_ROUND_UP(prate, rate) - 1) << div_shift) & div_mask;
-	rk_clrsetreg(&cru->clksel_con[id], sel, div);
+	rk_clrsetreg(&cru->clksel_con[id], sel_mask | div_mask, sel | div);
 
 	return rk3528_dclk_vop_get_clk(priv, clk_id);
 }
-- 
2.55.0

