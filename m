Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CACC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F55481107;
	Thu, 30 Jul 2026 14:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xV9WpQhQfJoD; Thu, 30 Jul 2026 14:13:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B7CE81109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420818;
	bh=iwHmtUIp8xfvpUgWGNK6I+/PgXDCU1fRSL/2HXhlwaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txqmjyOW1blyHsIkEcTy+1n5ONjC6eRMdcIh7hWpM9e3+IJ9V9LNBRtzw334iYwGw
	 1cw+nF79qavluCCKvis/dmFoRYiS3E1clvdWQlf1tQKT9awF/iQau1HtvzwztbKmjO
	 4u1PG+cfyudmV6EAorpM1hY3DdXhfzLl3hQVC7uTVXYZfXMzQWUFUdyAYJsvC23Tmp
	 Ftldt15kPL7KyEAsAZR7KBiE3VdUD2jFSgL0EbJxMhRwMsyGjZtZj8SSeNfj7lMLuQ
	 uRm1CoA5aOAT5U36NwcPvXDzaasQvHBR+k+SNxhGzfx0NDKaqvkUiUH3WtWdGAbwXw
	 KrvPxd4Zb75EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B7CE81109;
	Thu, 30 Jul 2026 14:13:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F57A352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 672E3810C7
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9u8IB09o-vj8 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 49E9B810B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49E9B810B8
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49E9B810B8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c09a254ae338c091787
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
Subject: [PATCH 08/15] clk: rockchip: rk3588: Fix possible divide by zero
Date: Thu, 30 Jul 2026 14:12:57 +0000
Message-ID: <20260730141308.1218014-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420811; bh=iwHmtUIp8xfvpUgWGNK6I+/PgXDCU1fRSL/2HXhlwaU=;
 b=UUMzUecnIrqCNjIkDqFapYkR5G6xzO3KzxK1H/kqDmzchEFZ3IAZV1EbCC5DBcSet2/92UpE5
 8fMKZaRyKHU4FfLB+18sI/9uI2b6ssPaW3h8xshSlypWM3iqa8+HGfB2pUZ6TlkQW3Vkaue0eq0
 ks5wnGjsYhp+N6p8dNfZlvFBuNiP3xjaorCfpaEp2+uht6ngCVqIlvAf6AJQgHTocbIPsRCP5Yc
 Akkkir5R8/oQ5/xGg9SZJayu/xTCqTfcFJ1VURTK/11IvDgnWbY8SdkEEu/cAg+3UyQsJaK6TG5
 9f6euYOqB62kE1zmboLLAi7MxoSHF0DgNnn2nT5zmONg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=UUMzUecn
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

The best rate handling of rk3588_dclk_vop_set_clk() may unintentionally
trigger a divide by zero when V0PLL is tested as parent. Instead, fully
skip rate calculation when testing using V0PLL as parent to avoid a
divide by zero error.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3588.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 157a02e011a5..d03ca9c4ac8d 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1165,8 +1165,8 @@ static ulong rk3588_dclk_vop_set_clk(struct rk3588_clk_priv *priv,
 				pll_rate = priv->aupll_hz;
 				break;
 			case DCLK_VOP_SRC_SEL_V0PLL:
-				pll_rate = 0;
-				break;
+				/* Skip V0PLL as parent for best_rate mode */
+				continue;
 			default:
 				printf("do not support this vop pll sel\n");
 				return -EINVAL;
-- 
2.54.0

