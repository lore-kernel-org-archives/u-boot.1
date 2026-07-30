Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62994C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DA9680FF2;
	Thu, 30 Jul 2026 14:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ89qGBrKIv0; Thu, 30 Jul 2026 14:13:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6ECA980FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420809;
	bh=96iFrA273DVircfXXuop5lGg6K+gtA2+G0VekQGsAKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ujYSZYYLW1I8hIREb9WXSSBLHsKzq0T+gx3rJ+ozjblG7TXU5LXjCzMFMwiQgi4Gt
	 ilcTFMogpy5WEjoRlWZ0pSKtfQNeISLAP1Wbt1yjmHtjmSrxjpuxhST+YNi8a/4RKp
	 kDPXrj/3EWmVYbBiHXIuMNd2g/MIW6HdCqoVI0Kb5lcy3qOmVoBr1hRrLa7LvF1MFo
	 4vnMq/NPsnsJ9qzN3xPuF0Ejz2MkBlQJ6ecwRB/TVszkwdQdkWHkooS2HSMNAFi72B
	 tBBr1yHBsGyn3Lc87Dd1juLytq32yLokefeGGh+6G6QR2CSPN+U0xCUUhoER4Nqirn
	 BjXKUUfIU/l4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ECA980FEF;
	Thu, 30 Jul 2026 14:13:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7044269
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 620D780D47
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9HK9jF3MYlm for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3118B80CBD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3118B80CBD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3118B80CBD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:22 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c00a254ae338c0916e0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/15] clk: rockchip: pll: Always write the k param
Date: Thu, 30 Jul 2026 14:12:52 +0000
Message-ID: <20260730141308.1218014-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420801; bh=96iFrA273DVircfXXuop5lGg6K+gtA2+G0VekQGsAKY=;
 b=WpzOk2pxS9NUAD1qcRH263nScSbsADtarGkDJU78oSRYR5SglFTcpDqdD5iVPZnJopmkw9SOT
 3mkWrjv3lz95DtaUxAdFZIuuiUDBvrm/XiKqCqhHxhcPaBSMn5jedkBDqwYRBFt2BLA8M9uTcML
 rrb4HaW+YlveFZ1GyfqFzBw6Fv4BJmajybw8eeErurrmaU4MvGRQDByNrevtHMx0MqjKgLIqzVb
 etKasgYHo+e6La5Vu8Beb7N5WPjja6ZSqbCgxYrCsSAE+a+aU+Cp4wtiMWSlHjTHGTRknxa3+TA
 lvaHT12eK/4JA0tHF9AfyeMy32Cpi0G2kYsTFMuLTXgg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=WpzOk2px
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The k param help determine when a rk3588_pll fracpll should enable or
bypass use of fractal mode.

Change to always write the value of the k param to reg to allow fractal
re-configuration and closer match how Linux behaves.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_pll.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index a135fad3de0c..7dbe77d74b8a 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -484,11 +484,9 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		     RK3588_PLLCON1_S_MASK),
 		     (rate->p << RK3588_PLLCON1_P_SHIFT |
 		     rate->s << RK3588_PLLCON1_S_SHIFT));
-	if (rate->k) {
-		rk_clrsetreg(base + pll->con_offset + RK3588_PLLCON(2),
-			     RK3588_PLLCON2_K_MASK,
-			     rate->k << RK3588_PLLCON2_K_SHIFT);
-	}
+	rk_clrsetreg(base + pll->con_offset + RK3588_PLLCON(2),
+		     RK3588_PLLCON2_K_MASK,
+		     rate->k << RK3588_PLLCON2_K_SHIFT);
 	/* Power up */
 	rk_clrreg(base + pll->con_offset + RK3588_PLLCON(1),
 		  RK3588_PLLCON1_PWRDOWN);
-- 
2.54.0

