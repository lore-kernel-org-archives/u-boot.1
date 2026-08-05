Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89140C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53C0A40235;
	Wed,  5 Aug 2026 18:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDeKXjE9DQCl; Wed,  5 Aug 2026 18:06:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D6E8407B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785953162;
	bh=ammIWPR9rTOkJlaA9snI7vfbqxk2npD0cywr2vye+l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QMpIKyw+30LD4ow2iiWb1UiWf+zoEDitWP/YyxnOxLLom8y6otKzS1Cy+1W1JhFhq
	 p1/OJDrJwQuDurMDpzib/u2eMstFsBTBCpgBrElu6g62LzoeKPn9aPqWiUwoFrkYZa
	 UG5OcAH5DL6aY15Qyexd+RTF6hxKTCzCwk3WHRLpiwlcgT+Y8zA/aMSQbsjyMPjf50
	 +MfsMniI72217CazFSvUYVd0d/oX8+SVHeJkw5RrtnOF2PHHWCMWxh/d+6ofSsMba2
	 775s5Ckkj8Z0+akqIHYYNJEVjRxSUHNp6OLBFF1N4Juw3lSf05HL8KOe6otUYOtFbd
	 b59IdY/uoXXRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D6E8407B9;
	Wed,  5 Aug 2026 18:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E96C42B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D082A605D9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cG2hseUgM16c for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:06:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8DDE8605C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DDE8605C9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DDE8605C9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:06:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376c55694ca629d62bb87
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
Subject: [PATCH 15/30] clk: rockchip: rv1108: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:46 +0000
Message-ID: <20260805174509.2968252-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785953159; bh=ammIWPR9rTOkJlaA9snI7vfbqxk2npD0cywr2vye+l0=;
 b=uv4rF9duILKISB6gPlfHSRryPMorzV+7Z3fkGc1TcqKUbjb8bgwhairAsI6aaRnFrdA/vrzwK
 NYxDOi8mAmoKPdi12f5lyU2g+r3wNuT9Blit+M3Dctpb68na3oQI07eqnCQdwY+4w9/kMB90yk2
 4xGig7W1kX5z8kylYEW6FeTp2H1p+c96jzuUEvE9hhnex8Sn3gOEyK7lglujIN+fbauGJYS016k
 WmXj1W4c94ocNiZgksu6HMnDYqPaN7wkMYTeTewItiVMLlKlfuA8oZL77Yv8nsKh9lhUkCNlxzG
 cA51y30CYRBEQTAeuh72esn/YqtZ8UWHAQgPNIv+hTBQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=uv4rF9du
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
 .../arm/include/asm/arch-rockchip/cru_rv1108.h |  2 ++
 drivers/clk/rockchip/clk_rv1108.c              | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1108.h b/arch/arm/include/asm/arch-rockchip/cru_rv1108.h
index 0ba5ff6a04f2..50d99485dcb0 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rv1108.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1108.h
@@ -60,6 +60,8 @@ struct pll_div {
 	u32 frac;
 };
 
+#define RV1108_CRU_BASE			0x20200000
+
 enum {
 	/* PLL CON0 */
 	FBDIV_MASK		= 0xfff,
diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_rv1108.c
index e1b9ccf1236a..3dcfb3385a4d 100644
--- a/drivers/clk/rockchip/clk_rv1108.c
+++ b/drivers/clk/rockchip/clk_rv1108.c
@@ -680,22 +680,14 @@ static int rv1108_clk_probe(struct udevice *dev)
 static int rv1108_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RV1108_CRU_BASE,
+				offsetof(struct rv1108_cru, glb_rst_st),
+				offsetof(struct rv1108_cru, glb_srst_fst_val),
+				offsetof(struct rv1108_cru, glb_srst_snd_val));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rv1108_cru,
-						    glb_srst_fst_val);
-		priv->glb_srst_snd_value = offsetof(struct rv1108_cru,
-						    glb_srst_snd_val);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rv1108_cru, softrst_con[0]);
-- 
2.54.0

