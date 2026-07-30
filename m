Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1CBC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DF4781184;
	Thu, 30 Jul 2026 14:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iKJ3sP8vI_yF; Thu, 30 Jul 2026 14:13:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EE7A810A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420833;
	bh=g21vvIVeapFnlZT4Cy2n2FZwYkqoRZ4ljscy5LNcuUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LPT9xoSQ5FmRGMhR5IDpI5r481M4Yw1VoVd6zMEc0e0H/H0fViQYm5jwjWDWEEj5i
	 5eWDxcYYs8bTiqHEytcaJsVHxv6ACCAV2lSZ2Uici6N6DPh4QP7+DAipu7uZS2jkfp
	 Q7ScV3nMI8QjqUZid/K6POCQfI+nkmuz0OpXuYg7qnSAgcQ2vWufHhHaQqJUzXnK/+
	 Q5AeHo5hoKTFa8oD0F6I4jPfDc0UF5Gym6nFs/t/G8O9clialMg0MeCghVqt0fgMMm
	 s7rEPBHuIpiq7HgfgLCTcGM3Q+gXhhHVL337/l9LpqYNX1i9pL+7zwRPyb3503TtqO
	 jvaYJli7lc0iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EE7A810A2;
	Thu, 30 Jul 2026 14:13:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76248197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66EB48115D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i1fBZxzADsIv for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5E18981010
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E18981010
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E18981010
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:47 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c16a254ae338c0918fa
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
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 15/15] clk: rockchip: rk3588: Drop unused GRF syscon lookup
Date: Thu, 30 Jul 2026 14:13:04 +0000
Message-ID: <20260730141308.1218014-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420826; bh=g21vvIVeapFnlZT4Cy2n2FZwYkqoRZ4ljscy5LNcuUc=;
 b=AhcP0YIzcuGgatbtXLY9smpvPV2Ld2Gg0RE+q+NGqDCaEv/rlBgiNxdeg7lO51cGKz0lrRl5P
 ViFI5c26kjPum1mPk91xUGSdKm3E6GxEbTAJaqSe/yseWgfL6mDkR9ZL+nPBwcoVsV+w1ZBdMT1
 xajGJM7nu1TmE+rD6E/x/jvCGbOMG7CYrcW8HdhSWismocUzKhUqPmBcxIcFOknrOE832bUMCDe
 6gz9WEwOb3UjYuPvKn2PzfooN4orTyzNPZGtkTrJT+ENQ+MgEEe/ur3u6Axkvzyhncecy2Z9Sx0
 AJzMz1PGGGBw110EjJD5AY3hoD2TDrSpKFUS9U5iqIQQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=AhcP0YIz
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

The RK3588 clock driver lookup and stores a reference to the GRF regs.
However, the grf field is never dereferenced and struct rk3588_grf is
not defined in any header, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 1 -
 drivers/clk/rockchip/clk_rk3588.c               | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 39295adeb38a..85cc17840436 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -41,7 +41,6 @@ struct rk3588_clk_info {
 
 struct rk3588_clk_priv {
 	struct rk3588_cru *cru;
-	struct rk3588_grf *grf;
 	ulong ppll_hz;
 	ulong gpll_hz;
 	ulong cpll_hz;
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 1006102f4cf4..5236c3fa985e 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1977,10 +1977,6 @@ static int rk3588_clk_probe(struct udevice *dev)
 	}
 #endif
 
-	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	if (IS_ERR(priv->grf))
-		return PTR_ERR(priv->grf);
-
 	rk3588_clk_init(priv);
 
 	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-- 
2.54.0

