Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085A5C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F1F9407A2;
	Wed,  5 Aug 2026 17:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEL85F3cb9t0; Wed,  5 Aug 2026 17:59:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E980407A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952780;
	bh=/htS1AH1svNTcJDsNjxbLmny5L0BjgUCjgxPM9KIOiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xjVNO2y1Nt97qZPyvw5LDEqpeScYHx3gX4KZfKuhKpTTFJjy65bFY8gGYcdrQjwzA
	 pNIfb8ottLeYKd2bBsTkzRDnSnDPKvdBnlVmv7pfqU2xyr1L6fQZGYVmgE/n0i5Q7C
	 aXjZKBF6CD8rWEY2zF8NNd466rCWKEXw7aHpWGps0CIaLlM7noye/bgDdS6y2+mIkF
	 Xluc3MU8AxKj9RiZHuWzC+Sv3m1ut1Si226RUtj7LGDSSaiL3wR9McdTtyv/UcdA7L
	 MMLCqrluVv9T6TNU6DhkDnrWP5qGlOqnkHwNtiha4XLEInE6uRZxHgYbT+dvycIQvp
	 6Ag1i2+HFCCSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E980407A1;
	Wed,  5 Aug 2026 17:59:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4772313
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A22B660786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDxpTAqhiWkM for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:59:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9FB456076B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FB456076B
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FB456076B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:59:37 +0000 (UTC)
X-Forward-Email-ID: 6a7376c15694ca629d62bb49
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
Subject: [PATCH 13/30] clk: rockchip: px30: Use rockchip_sysreset_bind() helper
Date: Wed,  5 Aug 2026 17:44:44 +0000
Message-ID: <20260805174509.2968252-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952776; bh=/htS1AH1svNTcJDsNjxbLmny5L0BjgUCjgxPM9KIOiw=;
 b=y0EvIWxeAGr7WOINYR3r5hcDD9+QTenrFcer2vmEru3uI6nHsTtBFF+UpyPBZse1zu4V724gm
 kK8oG1Hk06DG9/X6+S6KL8bDS8JGbIMn7ncpIMC3cQoPx7cUOLwCSkcX9vZVrMuMBIEfkbQkLgk
 AMs43qNuGcwFsOx7tQSRtSrZx8XfqZdsL1OuH6wg2T2cgYPZFT/sB08hliigWZN3XXDrnP1LX2h
 WTMFTqvDAyXYtDqATWToahZ5wVAIm/eCS34xGir1KwMUMnh88gLEKMixn51XBR64PdBzHkt3SLu
 7NNW0Ga4BR3dlGZCWTZVnOuiHowpBDcJwJgatMlsm/tw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=y0EvIWxe
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
rockchip_sysreset driver. Also add and use CRU base address constants
based on the clock-controller addresses used in the SoC device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_px30.h |  3 +++
 drivers/clk/rockchip/clk_px30.c               | 18 +++++-------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h b/arch/arm/include/asm/arch-rockchip/cru_px30.h
index 408fdd666357..4db83bd90918 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
@@ -113,6 +113,9 @@ struct cpu_rate_table {
 	unsigned int pclk_div;
 };
 
+#define PX30_CRU_BASE			0xff2b0000
+#define PX30_PMU_CRU_BASE		0xff2bc000
+
 enum {
 	/* PLLCON0*/
 	PLL_BP_SHIFT		= 15,
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index d143a6b85ee6..af87b150f402 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -1485,22 +1485,14 @@ static int px30_clk_of_to_plat(struct udevice *dev)
 static int px30_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, PX30_CRU_BASE,
+				     offsetof(struct px30_cru, glb_rst_st),
+				     offsetof(struct px30_cru, glb_srst_fst),
+				     offsetof(struct px30_cru, glb_srst_snd));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct px30_cru,
-						    glb_srst_fst);
-		priv->glb_srst_snd_value = offsetof(struct px30_cru,
-						    glb_srst_snd);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct px30_cru, softrst_con[0]);
-- 
2.54.0

