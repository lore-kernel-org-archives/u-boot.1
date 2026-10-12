Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C280FCA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E30380D96;
	Mon, 12 Oct 2026 15:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYMcrrsEooFw; Mon, 12 Oct 2026 15:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5A9A80DDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817566;
	b=Qb1bYsaP2mXC9cNqMW5gYtOWk4s7Ca7UaBf/tXGIAOUq92n9kqHEShxgQf5wkSyQyETe
	 YlDkak7xRRGHRRBrQmSbWkGY+zE7mntM23/ea6vdOrhWPdscp6WhCArkG+O7VNpLjyi4h
	 82OVKY4SUS6SO0+CS2SakZvsNqVnFN0xRHA0gK9CwitIjmbF1Bsbt4XG785SKBpL3Xx58
	 hdBCbSORoNZgsd1PFHGH6JTsP9YPNkOESidb6P6qO9E9YzPH4bI/PjTVyPq8ZO/KBEeAd
	 071FsG8njc//XpKMM/WGoo/9L5rPVFdKUTLuB+0wHFUxmQs9CPykg+QwKpDBxP0RI6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817566;
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
	bh=y8dHMYeq6AqoBktI/silNBg/LFVl4xC48EQWtZcCD6c=;
	b=HdrzYcENIRW2zgMbJI/VCVjmPOS+XUX6dWG4ssRY+mHAnV+Nbzzy3eWVrg+fuB/iXoNk
	 y3egyYctEs3guucQtO43wRI1ShQgTU9phCPFPp/te4xM4IJAppAUn8Fp5jQNbOpO+hqbO
	 W/OfI+KKsDk0jHhClfOx5yg1PSOqRHoezkGEFMq3z/kymKldixTwRYgVgTgSZcpH/FNa3
	 muS1CO+FH5qWUJTK4TBQ93GRyDpZf0bPaRbgvmVL4O3CFv5H9cDIXMtgpbG/8OC/7QDIJ
	 hSf+liCiTg2fKxg9Ee4/GgInRzPDqmlkR2yiDOr7eHRYbaskQx5tUvFL0PXKRcv3YBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817566;
	bh=y8dHMYeq6AqoBktI/silNBg/LFVl4xC48EQWtZcCD6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2G5EgM23JNuh6uKvTZeQviqOCuT9tm2emXyI9yofJhlS0mKfQT5WevYnnPIBDTsB
	 dP3lzS1G6l5YaqH0l+xbnQb+9C7NZP49soC3GvQAZwyybP9Ds+1XD51KUuKAzQbG0m
	 Z+vDqWv9aodj186eqH3sS5yhVHHigluPR+Ws/m4XOaWbnyOHwzsj7mGa61xMEw2ifx
	 YNiYQmlro7+BrJdUMizP6kqppGHng2+8CXRM/1iUg8eweEg7S3pZwfra2bhQq0qK9L
	 OBMlKpIm5XXsoSeLIIelkzDjzkfA5kh0u+knSO59BnAawFH0Hq7GBMbGo6uRWBUgNr
	 wgfKiEVcAVuBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5A9A80DDF;
	Mon, 12 Oct 2026 15:06:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 367E7105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32DC3606CE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qcx2gEPcl7l for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87D8B606C0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817563;
 b=PVbbYpJ7TZifF2yOAn/bWP9CpgSQ1yfz7u0K6CPf2y42hrLltxD+uJJjvrlG1u8hISOH
 w/Q6sxbvXRx4+wi8BaY3as1ci1pFrHLGzFUOFZYpCPZQgqHRxzdJmA+nKw03c5GesJbov
 XPzbQ1bA1/6b3OU3qxWxUHPLQJI8qtGb1dPlil6nBiKZ7sAjQ27idBIohVoL6wbEet68E
 tXKWEBE45057SQfLwIfnx/e8W1FGLQJieXMiHxjhAeLGa5Z/7qk1OCtHaSOoqSaT3KpLR
 h6nDnSLYcGoxPETGEmrW9xH7Elco2lzdhOcJs7QinLvrumzVKQnlugIcIaUyk2IAqvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817563;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=y8dHMYeq6AqoBktI/silNBg/LFVl4xC48EQWtZcCD6c=;
 b=hbbcU7E0PVdtbwi5XkJv8iTQzP21JkkSRE4yvIliEi2TglnOgNOXpkd9YKWmU7rj1gd2
 blVV8uCE8qg8/4gBvf3519WD+eM0S0qL+8Q6P0LpfX/1SdvlL4gW/c/gXkwNIBb8tbu+j
 oY5C8Bu348YzgTRpQKAM2v0xroD39Hqygrt/iyTg8OrkajfNik0pdlZdVyo3eUqL+Nj2y
 FPXLfOxo7sIG5+xilr58R163ydqZVHT0UBUZvl9/9o2QqiqhfCFg40YgxEIb9uatX8rUY
 o782MulFVWSb06AoWR4uTBsKrJChW4e0zr7VHrJ1ROeotVlJKwRHAUamJSJiu/SVZIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=H12nMTfH; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=H12nMTfH
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87D8B606C0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817561; bh=y8dHMYeq6AqoBktI/silNBg/LFVl4xC48EQWtZcCD6c=;
 b=H12nMTfHi5PbDogryfBykZKFJE1HROYOJlGfXUiOp9K2sgGPZI4r6RoANFYWrttUxn9T+ZOiX
 MPQbLk/zYvY5XtMQvCAWTvV8Q4KfXqGHJ6oUsZhk9MNqC0x8+WHHPn9TvneBoRZQzabXp35VvEc
 mShLzLirO2drcvqzqVEwPKZKN5pwk/hmXuiXAlh8ibP2IeQw9OHr1hONAhGc3SFyWU+mrNl984A
 lH2z3WWDjvXlcpWLK/mrovo5cQm1su43SULvGUpp6gcKf/OcRLvErd5YVgyqDGA5DGz/m/mqqA0
 8xT6ZYWmrePrNZRvbBtErMiUUkVNsXAcs3YX9qSdQFww==
X-Forward-Email-ID: 6accf74f8ac7302d53a2c8e1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 2/8] clk: rockchip: rk3506: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:32 +0000
Message-ID: <20261012150542.1182209-3-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RK3506 clock
driver probe() ops.

Fixes: fbf72dce915a ("clk: rockchip: Add support for RK3506")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3506.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
index 457082eea87b..b0c9f311461a 100644
--- a/drivers/clk/rockchip/clk_rk3506.c
+++ b/drivers/clk/rockchip/clk_rk3506.c
@@ -1109,15 +1109,9 @@ static void rk3506_clk_init_xpl(void)
 static int rk3506_clk_probe(struct udevice *dev)
 {
 	struct rk3506_clk_priv *priv = dev_get_priv(dev);
-	int ret;
 
 	rk3506_clk_init(priv);
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, 1);
-	if (ret)
-		log_debug("clk_set_defaults failed: ret=%d\n", ret);
-
 	return 0;
 }
 
-- 
2.55.0

