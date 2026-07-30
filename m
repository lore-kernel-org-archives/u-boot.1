Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE07C55167
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36DF38113E;
	Thu, 30 Jul 2026 14:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQDxczCz2BAn; Thu, 30 Jul 2026 14:13:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 718978108D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420823;
	bh=XBg0hpAPmbdGkJRcLe8GfxJeCMe1taZlWYhMcyn6+7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8PlbIqP0G+HMHG4lxWQsNqKks+H1rfGaf0ryqy495qhHpBW5yC2YdbxHJGejqI/D
	 nWOF5SKtpLdPJD6TnIfbYqrNDV/pgoIVxJxUvBvrDmwkHeu2VqpxOvFxmXlgPnETzi
	 AfbbbAlAFPh5nIQu4N392jmRitd40rs/vmVH+M7nzdSyd/zLvscTm1811hj0MzygKu
	 r6Rmld48XaGyVGmSlD5SbphHMXHtUzhko70u1KUYdCMryIqqCNNBEH/EokCO37pAgZ
	 hDJD4jFk21R/WXwJTFm8acyyKNklkdfkRY4zof3isj8vFQGe4Meqe/UKEtgrvucCf4
	 Gas6K+WNVKMIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 718978108D;
	Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCC2945B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB8BD8110E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-srgRRRqiwl for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 91FF5810F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91FF5810F9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91FF5810F9
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c0da254ae338c0917fa
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
Subject: [PATCH 10/15] clk: rockchip: rk3588: Use SPLL_HZ constant
Date: Thu, 30 Jul 2026 14:12:59 +0000
Message-ID: <20260730141308.1218014-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420817; bh=XBg0hpAPmbdGkJRcLe8GfxJeCMe1taZlWYhMcyn6+7M=;
 b=ELTAaQ1csetktoy6eLc9Z0nB+REVxzA6eg0TucCWCl4fi0DCNiZG7QK1IauHY/Ii8jnVPjH0H
 RVFggVbC96Wb3NKBJ5NmdF/6dFG09flpddvfJikt1/Q9R/BCyprY0cQ62spIx/BvzrPFRe8nVL9
 vHHLWOVx0mnBorhpZ3SrTl67DJXUhiy+6R7TqHQRfuikQuQmxz1B/GaEHHG/qA3pmK7oZnvF9U7
 N5m9gEI/StDQfH14+awJLB7T09fM13xy0+7ggJpYksH78izNBcg2nQIhzZtDEaAvPlIbAmMdZuc
 BeRS7geCzvmEMy2oRAH1yGIhfoYqDrj8j79SLhnEWQgA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ELTAaQ1c
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

The SPLL rate is set to 702 MHz in SPL. Replace '702 * MHz' with use of
the SPLL_HZ constant to enhance readability.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3588.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index c48743d8296f..1006102f4cf4 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -777,7 +777,7 @@ static ulong rk3588_mmc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & DCLK_DECOM_SEL_MASK) >>
 		      DCLK_DECOM_SEL_SHIFT;
 		if (sel == DCLK_DECOM_SEL_SPLL)
-			prate = 702 * MHz;
+			prate = SPLL_HZ;
 		else
 			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
@@ -817,9 +817,9 @@ static ulong rk3588_mmc_set_clk(struct rk3588_clk_priv *priv,
 		}
 		break;
 	case DCLK_DECOM:
-		if (!(702 * MHz % rate)) {
+		if (!(SPLL_HZ % rate)) {
 			src_clk = DCLK_DECOM_SEL_SPLL;
-			div = DIV_ROUND_UP(702 * MHz, rate);
+			div = DIV_ROUND_UP(SPLL_HZ, rate);
 		} else {
 			src_clk = DCLK_DECOM_SEL_GPLL;
 			div = DIV_ROUND_UP(priv->gpll_hz, rate);
@@ -942,7 +942,7 @@ static ulong rk3588_aclk_vop_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		else if (sel == ACLK_VOP_ROOT_SEL_NPLL)
 			parent = priv->npll_hz;
 		else
-			parent = 702 * MHz;
+			parent = SPLL_HZ;
 		return DIV_TO_RATE(parent, div);
 	case ACLK_VOP_LOW_ROOT:
 		con = readl(&cru->clksel_con[110]);
-- 
2.54.0

