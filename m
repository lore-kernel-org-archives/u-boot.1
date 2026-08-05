Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE0DC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06B89607EF;
	Wed,  5 Aug 2026 17:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrJuNrDY03XU; Wed,  5 Aug 2026 17:52:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36057607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952368;
	bh=LYsDtsIB04+PlmMBUrooTwqRs7ynpjesmtTgg1oSQeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RshHcsZ/eZEIb7FJonakM5b1uL6z7sFAJNZ1xympph60X+aWQ0rDj/s4CqFLiKXiF
	 Pux1i3Kl8DW0lEX+ye2NXEwdTUYpn6xrMaRmgE/tIBNO/0cKnIyJTsuvb2OWtzrgOL
	 4ZcbOoUJVoYvPYF2VPEeUuEgbqNDU2ECu4Bw+xEROYFp1v+oRWh9Q/e7u8GQyRuE/N
	 2BvKkxEkvvlQwODF4YTJqVREDIsjLJkBSx6imXHfb2C9gPOIMa3IbJnjITWgZ2m8L7
	 ic5baRO7kA3sb36xjY9b0oDeIYm+9RPUB7T+UxlL6+CCNNiHKW2vU9GQD3BuwN8qn6
	 /aE0of6HxDeWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36057607CA;
	Wed,  5 Aug 2026 17:52:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 095C3218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF712607DC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1S9JOqIUdYjl for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:52:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9EEE607D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9EEE607D7
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9EEE607D7
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:45 +0000 (UTC)
X-Forward-Email-ID: 6a7376c65694ca629d62bba5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
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
Subject: [PATCH 16/30] clk: rockchip: rk3188: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:47 +0000
Message-ID: <20260805174509.2968252-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952365; bh=LYsDtsIB04+PlmMBUrooTwqRs7ynpjesmtTgg1oSQeY=;
 b=MS6l/o7u6vroXK/B2Doz8finRXqg/r00tmKan4RLKmWQPgd8jePYkISmobjh6VVkZUTbkm9/E
 ADpnswaKPS8ge2bBpLqiuOUxqEiC3s+Y0ecgVG+2MxdrzWblc02Z25U/8UOdlwVGPgpLg/1R3YJ
 tkIs+ZsKK/fS2rucRYXMuVAnaNZaOj39vrG6x8DoOezCqVdyDLIToCaWMozU/j5uunTyNAPV4T1
 k1FzpxxC9lRFOcC9xgHW3NzjwqCSRdXevCxstTQDJMzMOh4LMGXlhO6SPDCIw+RbAHwNJdRq0zp
 BrzSkdP4LqvM+K6e7gamc3w+eXJu8BAqFehAc5HHSmiA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=MS6l/o7u
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

Convert to use the rockchip_sysreset_bind() helper to bind the
rockchip_sysreset driver. Also add and use a CRU base address constant
based on the clock-controller address used in the SoC device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3188.h |  2 ++
 drivers/clk/rockchip/clk_rk3188.c               | 17 ++++-------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3188.h b/arch/arm/include/asm/arch-rockchip/cru_rk3188.h
index eec4815bbc06..7f019167a784 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3188.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3188.h
@@ -51,6 +51,8 @@ struct rk3188_cru {
 };
 check_member(rk3188_cru, cru_glb_cnt_th, 0x0140);
 
+#define RK3188_CRU_BASE			0x20000000
+
 /* CRU_CLKSEL0_CON */
 enum {
 	/* a9_core_div: core = core_src / (a9_core_div + 1) */
diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index d8b03e1d7ab3..0e7d1ccb410c 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -577,22 +577,13 @@ static int rk3188_clk_probe(struct udevice *dev)
 static int rk3188_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3188_CRU_BASE, 0,
+			offsetof(struct rk3188_cru, cru_glb_srst_fst_value),
+			offsetof(struct rk3188_cru, cru_glb_srst_snd_value));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3188_cru,
-						    cru_glb_srst_fst_value);
-		priv->glb_srst_snd_value = offsetof(struct rk3188_cru,
-						    cru_glb_srst_snd_value);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3188_cru, cru_softrst_con[0]);
-- 
2.54.0

