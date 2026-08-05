Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C805C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC60780D58;
	Wed,  5 Aug 2026 17:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmhYLRII7myj; Wed,  5 Aug 2026 17:51:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCA9A80D5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952281;
	bh=AZ/bC1Jw09g0csG0VhAXDxdmjXn/Fkrx8Sro7Bl91go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwjXoDb0iYuNX/XBCkpJ99/JMCs1jf7inQ7dYCJLR96+1RJdH0XYsJ4d73M90RAzG
	 hy/yEtHvn1LuIH2+YXZewVteKeezcGm37k2tcMdtIkQvS5FYkH7SJ1n9ts32eUcOx1
	 zwoGjfD51IEWsQb+iyKCTR2f5s+7vkta3tA/vjTi5+0FNRM2h3y1OpFhZ6hzT7Eg2y
	 rSZqDC8I/zS78QRfC7OJqq/hzzCR5EU3AaCzNTQJlZ/5m1j3aV00u3BEiNzJxJUdeU
	 BeLYzAxTJCyXCAHOeGzLUe3Vbv7dwOEMuDbIqKvwMsY32zoFjgquH7AntnvVuK3lNJ
	 x9o5BwgV2RbBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCA9A80D5A;
	Wed,  5 Aug 2026 17:51:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5028C218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42393607CC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPxbiy1nMEV0 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 48630607B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48630607B4
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48630607B4
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
X-Forward-Email-ID: 6a7376af5694ca629d62ba17
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
Subject: [PATCH 03/30] clk: rockchip: rk3576: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:34 +0000
Message-ID: <20260805174509.2968252-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952279; bh=AZ/bC1Jw09g0csG0VhAXDxdmjXn/Fkrx8Sro7Bl91go=;
 b=XjptakJnqI4rSb9GTrEJkWeJGNMbyu17u+76caHnq5cmNFTGSNcawVKkuIuP3HR66d27ctEJW
 7aG1yLL6Z7twMxa++Oa2Bagt5O8QXmx7pTvrZonsxP/kOGuVZzu9a4kOzZg+C8Th0iOgz8Me7MY
 jTokwF2aceF+KAqq6BS12IUIUsL0w6hb9ppDmdc0MOCwSLaHiYbrzN0wPb+LqHdVQFf3oFxjrvf
 s0+H1gREO+YTsn+waIHaEJwTnI/4WXSHYqMC+d86Udxav5PG9UcYZtXLg14V9E6LWz4XBcs6OME
 bGSnA3ztWbgJ/WYX7Gno9QZo3xAd7T7DkzoKz9lu9v5w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=XjptakJn
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
rockchip_sysreset driver. Also fix the glb_srst_snd register name.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm/include/asm/arch-rockchip/cru_rk3576.h |  2 +-
 drivers/clk/rockchip/clk_rk3576.c              | 18 +++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index 41e225245843..69033bae7b3f 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -73,7 +73,7 @@ struct rk3576_cru {
 	unsigned int glb_cnt_th;/* Address Offset: 0x0c00 */
 	unsigned int glb_rst_st;/* Address Offset: 0x0c04 */
 	unsigned int glb_srst_fst;/* Address Offset: 0x0c08 */
-	unsigned int glb_srsr_snd; /* Address Offset: 0x0c0c */
+	unsigned int glb_srst_snd; /* Address Offset: 0x0c0c */
 	unsigned int glb_rst_con;/* Address Offset: 0x0c10 */
 	unsigned int reserved5[43];/* Address Offset: 0x0c14 */
 	unsigned int smoth_divfree_con[3];/* Address Offset: 0x0cc0 */
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 1988f0472dec..83918908a4e0 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2523,26 +2523,18 @@ static int rk3576_clk_ofdata_to_platdata(struct udevice *dev)
 static int rk3576_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* Ensure clocks are initialized after bind in SPL build */
 	if (IS_ENABLED(CONFIG_SPL_BUILD))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3576_CRU_BASE,
+				     offsetof(struct rk3576_cru, glb_rst_st),
+				     offsetof(struct rk3576_cru, glb_srst_fst),
+				     offsetof(struct rk3576_cru, glb_srst_snd));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3576_cru,
-						    glb_srst_fst);
-		priv->glb_srst_snd_value = offsetof(struct rk3576_cru,
-						    glb_srsr_snd);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3576_cru, softrst_con[0]);
-- 
2.54.0

