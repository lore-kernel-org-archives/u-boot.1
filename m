Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D818AC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9382240B96;
	Thu, 30 Jul 2026 14:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SK17eK4EVqws; Thu, 30 Jul 2026 14:13:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C29B540B68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420824;
	bh=vyIXpQ4eyslncWuLU6H33MutfFRYrm5+g6seG3XIgWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oy9lV2fWGqHQu9AJIaCnsYvNNEWr2SacJcgqezvDzYt1SR5AZYJ83oFvUHnVNk2vU
	 9zos/wqp5OFU/MupPAw8w+PqwtXPN2/sMF3FG3s5uHhcP+PB14VnW/4IQnWyfe3THe
	 xdMD8OozH/Nofniiz4XcXjaYv7be5AjgPfynK41byRkBrWLRJ7Szfy6OSzAlZA+pS+
	 RhaDswez4UXluLnkjCgwxoWqA1OJ7pUwXj/5oSjLxT95crdsRCj+LDZCCsiVToI4iY
	 WyUlKbKnEqxG6ZnQ3PMKIQGwotT3SSIXiWGLXN6WaKica/LwEX+jkfI1/HoBkstcOl
	 47HT56xbeClXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C29B540B68;
	Thu, 30 Jul 2026 14:13:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A61352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0953381110
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzF4AvnxI6vs for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A06E280FEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A06E280FEF
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A06E280FEF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c0ba254ae338c0917d0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH 09/15] clk: rockchip: rk3588: Fix ACLK_BUS_ROOT rate set
 during probe
Date: Thu, 30 Jul 2026 14:12:58 +0000
Message-ID: <20260730141308.1218014-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420817; bh=vyIXpQ4eyslncWuLU6H33MutfFRYrm5+g6seG3XIgWY=;
 b=liDbVqWEEjQeIjBxxFwyWNbsuVsgXm6nbYL1gVw5Xm/bGRdZMKulXW1qt8fu0XJ1rDfd6+khk
 7Vj6BULEgqdhCT5dguqRFaPM7cNyR0hTZlDEiYduGzqJdZ83B3QA5P689N3eeArrM6pxtmT/zu6
 NAbyFOCoI3rcEWKqDm11Ei9Hkn4amcJviHgP/sDRz1niQuh2RLHjCs6QvsveulIKop3RA4tehHl
 ZmLv5FSKyhDtarV2azgca/nbbXD/ueKvpaGUSyhiGbNzhd89/ZWcP1BwWtcDovEsPLN2QDtzufi
 WOU3OoTU2bf0nOkw7bjOdNRw/YhGMrCSAqq8fb7ii6Hg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=liDbVqWE
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

The ACLK_BUS_ROOT is typically using CPLL as parent clock and running at
500 MHz out of reset when CPLL is running at 1.5 GHz.

The parent and rate of ACLK_BUS_ROOT is changed to use GPLL and to run
at 237 MHz during clock driver probe. However, the clock rate is
hardcoded to be reported as 375 MHz.

Change to explicitly use CPLL as parent and set the rate to 375 MHz, to
match the reported rate and closer match how the Linux configures the
clock.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3588.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index d03ca9c4ac8d..c48743d8296f 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1921,11 +1921,11 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 {
 	int ret, div;
 
-	div = DIV_ROUND_UP(GPLL_HZ, 300 * MHz);
+	div = DIV_ROUND_UP(CPLL_HZ, 375 * MHz);
 	rk_clrsetreg(&priv->cru->clksel_con[38],
-		     ACLK_BUS_ROOT_SEL_MASK |
-		     ACLK_BUS_ROOT_DIV_MASK,
-		     div << ACLK_BUS_ROOT_DIV_SHIFT);
+		     ACLK_BUS_ROOT_SEL_MASK | ACLK_BUS_ROOT_DIV_MASK,
+		     (ACLK_BUS_ROOT_SEL_CPLL << ACLK_BUS_ROOT_SEL_SHIFT) |
+		     (div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
 
 	if (priv->cpll_hz != CPLL_HZ) {
 		ret = rockchip_pll_set_rate(&rk3588_pll_clks[CPLL], priv->cru,
-- 
2.54.0

