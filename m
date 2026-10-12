Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E834CA9EDD
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24CE4606E0;
	Mon, 12 Oct 2026 15:06:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPO-Ek5OsnC7; Mon, 12 Oct 2026 15:06:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E1CA6067C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817569;
	b=T1G9Oe4Cwo+IOFbT9IHFbu3nPaqsrOb7WBgxecoy1JHdexIs4kuEl9iwPx0KZDK875bN
	 sndgX8I4hpUJA4tgBRMzGYTQkFlzoirgNnTkeGfb/E91SoWMmUt8Z8DPP9LNJNxk6EsIj
	 VezXy9IFkgnhdykFQ4+kuOzinFifC6ffnNYWE1453IDV2C9tuCTjyAT2+DLp8NJxVn84Z
	 H9vDkW3RrK5GWpv7dlWXNzA0UrC2qzEY51x6L1jEfg/XMDGvVA7btP2YZ6sA0Lj8fPSUA
	 c4sqVoFVLWr34Vlo1CnAIzOejDVNsI/i/Xvs8yPB0fQpJQ+cdxcoHaO9SF5ttFDTMig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817569;
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
	bh=GAx0mYMhAQ/NTYEPn5OL8ZEnA+vab4eatfD7CApVC74=;
	b=gssF25suY3NlDw27ugEa5h/bgqGX2sc2hGHt7IsSlkpuxVz1DVrvWLlCJSK/0MvOTvH4
	 fwlhK8IWPwOuypIHbLmi02QeiwveAto1mdZLWsUuFN4mmcT9nZc7T5HZ8La42qGZYFxCY
	 Zo6CelO3nPGyYmr2yLYdomVObPaxeEGLZW1SyRwipDzqxLX3kF/cfuCCKNsyQmQEy1mJu
	 jJfCapU7gLWK/FItYlI4Aue1/ITDEoDGYzNxMHbzUcrMELMcvXJI86/0Yg7IFAA0Xk2wb
	 vp1STSll/gTRlXp5DkS61aOVlhPW0jDUZ3iv9rO6Zsp8w0iv1ZqbmcwfOwPWI2o/fjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=BPLs0Rny;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817569;
	bh=GAx0mYMhAQ/NTYEPn5OL8ZEnA+vab4eatfD7CApVC74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWMLnsPfwrJoNKeGEQyVlYY9jezy5T0ENuuI2Y6LIBr8gGBEnavnjw36pXTXJ9iqP
	 6EurPsEzBqW9cZLPbYfRvlHDXjLYrZ6XL9Afp7iMb0fdAdg80tnBDcZmiD3KlzJ3rR
	 BRUwAFRb0mws/Y+Sk+h5LRxuuvIIukidrQtJMHYk9faWlc7lD46QsLbO80AgEvkmsl
	 6qUNLzB8nEvWmRTrMtQRTOhqbE3sGMKJLSCFbsz0Y2ZgZsgdKgBZSHpFUQ9WN2+AcZ
	 aGTc6zYkqOD9OQG6meAevMqawp5B3XgBqrXhX34bhRAYULgZbSmfwZXcCqBqMuwabG
	 3rfDnnWmMZV5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E1CA6067C;
	Mon, 12 Oct 2026 15:06:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2136105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2100606CA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yTfjAtlhmflS for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE065606E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817565;
 b=dUufH4qFLHtH4SUtJHia408zroSJAwrMwZc94LfjqcYGKqt3Mcy03QQ54IoNF1L4dJkz
 5+PBNz8YcWqsf+EH4k1rBXJGVArU1Tg6J1QmVPp604ySrpnBxcLlUONbjvx7zY5cA0u3W
 FfylweWW+edzlmszhsEZFzTBRsApQr8CAirVP4MDkxIQ1SzwYYcQ4jZjuCYdcni8oAlgz
 MCq7gyhpeDegxvuL+HI7Qw0upukpkNXXTPp1ZSBPPvpufy8dLLBT6my6TRDwoZyc+Xr1B
 +X8Ecb99suB3baI7BEx8nHlMZX2Yz6vdi5paP1z99tEHhiLNZNaitUmBsUYXRqfRQSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817565;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=GAx0mYMhAQ/NTYEPn5OL8ZEnA+vab4eatfD7CApVC74=;
 b=mwkCk9vrrY58Y/e+K8qkRLbIgmyJQle9RPv3l+PmGGA8LCpTC80BBVP2+t73jlYrq7lZ
 Tr63PwE4GR1e8GG2bdX+ZjfZ2rigHLhN5qrPKqNDIqOEvt8T87fDYNhTkPQrFu4qj5s7j
 majim1V5Qh5azoc/Q6XoJhwWUA6FY7sDZEFT/D1mo/zY3pbmnXsnlCGLZCR7p7tAN/C69
 PZIzN5PKMjY0AIQxdgqnUn7IrTR8EshQQqUQktvlpqVyoY+W8QrWkhRbO321fWej6YUL5
 MzIeTG++4I6fXA/8sViDbO2AeB5gXsL7/nuNeoB1JqQSNB7RGnw9cv2q45GPpL6Unyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=BPLs0Rny; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=BPLs0Rny
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE065606E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817564; bh=GAx0mYMhAQ/NTYEPn5OL8ZEnA+vab4eatfD7CApVC74=;
 b=BPLs0Rny4pXQG3ESA9Q/quy+FDMvjs3g2aKsY0HUHSsrO7vdUGgb5LmbIeEyymDwQwLmhZyoU
 fq4b2PrmeppMrDiMGd590ZSI16kIsWMoFqMXSaP1baxhaewAlIOWQ2E33VbblTtTZRRLqcpAAQl
 ITPj+qWGE2woOY/nQtIH6FpYz8n6LQKX6+vs5lz5a2g3MBSrAftIO7VWqIqIe3Wm3iay77T5emG
 WihqnS4sy/SUcludrC9dcbayMAeFgx7N7PoxAiGpv9x4mTaZF7IbXKRf3XCZYr7v4LCVzyRb5JG
 FaLK6JI/D516f0BVVC7AiKBDHhMnxtLg8uX67q+NQxIA==
X-Forward-Email-ID: 6accf75b8ac7302d53a2c961
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
 Jagan Teki <jagan@edgeble.ai>, Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 7/8] clk: rockchip: rv1126: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:37 +0000
Message-ID: <20261012150542.1182209-8-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RV1126 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: a25338aa896a ("clk: rockchip: Add rv1126 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h | 1 -
 drivers/clk/rockchip/clk_rv1126.c               | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
index ae273de31442..20e580a8eb3d 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
@@ -72,7 +72,6 @@ struct rv1126_clk_priv {
 	ulong armclk_hz;
 	ulong armclk_enter_hz;
 	ulong armclk_init_hz;
-	bool sync_kernel;
 	bool set_armclk_rate;
 };
 
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index 39920d34b75a..018232dcb027 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -1772,7 +1772,6 @@ static void rv1126_clk_init(struct rv1126_clk_priv *priv)
 {
 	int ret;
 
-	priv->sync_kernel = false;
 	if (!priv->armclk_enter_hz) {
 		priv->armclk_enter_hz =
 			rockchip_pll_get_rate(&rv1126_pll_clks[APLL],
@@ -1812,7 +1811,6 @@ static void rv1126_clk_init(struct rv1126_clk_priv *priv)
 static int rv1126_clk_probe(struct udevice *dev)
 {
 	struct rv1126_clk_priv *priv = dev_get_priv(dev);
-	int ret;
 
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR(priv->grf))
@@ -1820,13 +1818,6 @@ static int rv1126_clk_probe(struct udevice *dev)
 
 	rv1126_clk_init(priv);
 
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

