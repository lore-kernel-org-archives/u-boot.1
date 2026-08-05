Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64F9C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D41B407D9;
	Wed,  5 Aug 2026 17:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpr6tPhvI5RP; Wed,  5 Aug 2026 17:54:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C55440798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952443;
	bh=KOPExkPi7g6qkK0bkGyllBVIfxiSq4A7TPF3YwyKGuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3Z1xD2s7am1R21HTlrLwLWQJWP0J5YS4DepkXamOkzuyRmJEChOXpeo192AQyyQm
	 ibRfjreCtWoZxiSDsEpnQAuw031SkKJvtT2DDkPA+RTa9QXPQJpRrEre93nFEIfUwR
	 eiH/v5VxZls817kpgarouehKLIbe+rTbt/Y7D1fz/w/4GlEnyIyN7s1dxT8ss6DNRp
	 IHMfSzlawUd0HxAUPKSS3/HugpuJBkEFqK4Hk5vw747MR07H56ZaeKOiuPGzDgpTG4
	 o5T0v6f47DaYcUvaJiJpdAkKuSfyqbqHeNUIGM6JXFbUXST9N533QInxHLkRSWOV4D
	 Q+xfI/4W6ejSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C55440798;
	Wed,  5 Aug 2026 17:54:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E9A8144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5AC160786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxHGmFmXGtKa for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:54:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DFFC96066A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFFC96066A
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFFC96066A
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376bb5694ca629d62baed
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
Subject: [PATCH 10/30] clk: rockchip: rk3308: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:41 +0000
Message-ID: <20260805174509.2968252-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952440; bh=KOPExkPi7g6qkK0bkGyllBVIfxiSq4A7TPF3YwyKGuk=;
 b=cM6MeortHAZnLBNX5gAtBFTj07GtbcE41xDkKcyGEoh4ZEDyu3smZcHMApaXX4AK140FALjv8
 x2PTiPe4IUbLEPhnbQMfcfDUONYTYwz2SVdpYMGcC55aAuxULos2/YKSp7ojCZN6GkRDSkKmqE2
 QYYk+aa7Rfi7N6QmtT07nRsXU9maF4yUtDeEZHtJoDVZ8FcGNqBY3ucJbEZDaAk/+NSVvOgOZpT
 sD4y1OE/bsAqEGTrQvRHCMD75exM1GddJtLf0IaXVJd2xMw2ri6NTWWa9UM8qD6wKN+KtXkdIjo
 fbQ93DinVsWupZjiPY5vmGey4/VedOAXMyhCluLyxkjQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=cM6Meort
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
 .../arm/include/asm/arch-rockchip/cru_rk3308.h |  1 +
 drivers/clk/rockchip/clk_rk3308.c              | 18 +++++-------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3308.h b/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
index 091ae82d7cc1..e38d2a7cfdc8 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
@@ -24,6 +24,7 @@
 #define AUDIO_HCLK_HZ	100000000
 #define AUDIO_PCLK_HZ	100000000
 
+#define RK3308_CRU_BASE		0xff500000
 #define RK3308_PLL_CON(x)	((x) * 0x4)
 #define RK3308_MODE_CON		0xa0
 
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 97043b8693c0..93fbb557c130 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -1186,22 +1186,14 @@ static int rk3308_clk_of_to_plat(struct udevice *dev)
 static int rk3308_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3308_CRU_BASE,
+				     offsetof(struct rk3308_cru, glb_rst_st),
+				     offsetof(struct rk3308_cru, glb_srst_fst),
+				     offsetof(struct rk3308_cru, glb_srst_snd));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3308_cru,
-						    glb_srst_fst);
-		priv->glb_srst_snd_value = offsetof(struct rk3308_cru,
-						    glb_srst_snd);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3308_cru, softrst_con[0]);
-- 
2.54.0

