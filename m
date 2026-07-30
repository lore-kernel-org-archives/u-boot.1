Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39011C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECD5D81149;
	Thu, 30 Jul 2026 14:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2FiKFIBP9LD; Thu, 30 Jul 2026 14:13:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 134C38115C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420828;
	bh=n9vY0Ouvn2BVbJUlLJgXbu9oVu0Klx8raISGlxcPJj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJHLr6Nh0rVWzGr1MXb6SIFYOJt8cKG9LCPRI1tYBhZCYlwyDL2eeKHQkVR6K5d0t
	 vEWsUCNkthGLjMrlqhaVAPN+QNj/y6sAlu+ncII03eq5PRQInP/+BGYEXqjmgfMBlS
	 rIzqD+4mx+QfkT0rk5Vnw6N2FRNi2eh7btRqCL3ohy3KhNpr1jIpRdZ5OFyHsggZgN
	 B/TWkxbHxA2n8RToqL+s48C5fM1g5NxWeMBd6K9fibe19rUanfM1P4IbTqGeTbZgYk
	 LNfZ/V7uaMjV3XKRHOxtlMt+kC4gh0a3vC/YOx7Zpa8bsg9Y7yjozKUhcg3U6tvG5D
	 0TPm0SkiLeUnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 134C38115C;
	Thu, 30 Jul 2026 14:13:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5610127C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47E6581006
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1rVLL3ZTaeM for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 373E88100F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 373E88100F
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 373E88100F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c14a254ae338c0918d0
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
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 14/15] clk: rockchip: rk3568: Drop unused GRF syscon lookup
Date: Thu, 30 Jul 2026 14:13:03 +0000
Message-ID: <20260730141308.1218014-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420821; bh=n9vY0Ouvn2BVbJUlLJgXbu9oVu0Klx8raISGlxcPJj8=;
 b=VlV5ms6mbmfrsO0uAmcS5OUr7qGnyT3Z/D2LgEs2K2OcvRt2apD90D0IDKC/yRCXSdkIqWswy
 iufCGxDnPa42DrxC1PRzFYLqUNbbRteWavz7lN3rckdbB5WR4eaEr+CJSpiYNSunkn7Hx+0GuX+
 06QVvs33V2xZG8hf3TVrS4iPeYyqlVxl5gahTFy1xfeKQKzNePKDk6Hc87jTb9pbt0Y5YkTd2i2
 kL9uNS1Ic8fhXBmdngsehKr+7Fx5dbWBzTYWovlM7yZYXkPKos//d9GyHAAn5JoIsxgfuH42L4q
 e7rJ64yGTGUG2HvJjWP/gHMnK//llypbdSHEuXzqc+qA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=VlV5ms6m
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

The RK3568 clock driver lookup and stores a reference to the GRF regs.
However, the grf field is never dereferenced, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 1 -
 drivers/clk/rockchip/clk_rk3568.c               | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
index 9c7ddd751f72..d72f241d0150 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
@@ -44,7 +44,6 @@ struct rk3568_pmuclk_priv {
 
 struct rk3568_clk_priv {
 	struct rk3568_cru *cru;
-	struct rk3568_grf *grf;
 	ulong ppll_hz;
 	ulong hpll_hz;
 	ulong gpll_hz;
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 940b824103cc..9f3e9322161e 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2907,10 +2907,6 @@ static int rk3568_clk_probe(struct udevice *dev)
 	struct rk3568_clk_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	if (IS_ERR(priv->grf))
-		return PTR_ERR(priv->grf);
-
 	rk3568_clk_init(priv);
 
 	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-- 
2.54.0

