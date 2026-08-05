Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0677DC561E6
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C500480DAC;
	Wed,  5 Aug 2026 17:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9JI95IIa1KJ; Wed,  5 Aug 2026 17:52:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D408280D7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952360;
	bh=Kb4WtJglZWhuo0KNGUI5rs6b//v/Rp4MM5Fx9UQ9W20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GlHC2gOWmdqjX1fihqRDhRQIvUdepeJFcwjaI7HkubIL2UB5zV+Z0+6Io79kCC1O3
	 qX371sBjnH5yAuEvyqeUUWSeiopdRNLxa6vknfi0yqO9WFpef0enhZ8vaHuwirQ8mL
	 4YzBuN20FpFMP/ahT3dEkOucelwpvz5ELsaCk+D5obsOJiOdy00n1CoEXMwIODCbJR
	 5PiwvM2M4vMvaWJbiNqwV+5Xh1vfrVm/WTfUMJZHQw5BXcH6El09MFxTpd7lxz1lKU
	 vaDR3HxtFVpFkbFoUQWvV+waXUSFX+phXLbWBi92j3bIFGYjsJRE2RwyytQl6hwVBx
	 /7TpnQetWp32Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D408280D7C;
	Wed,  5 Aug 2026 17:52:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55569144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B7EC607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3l4o_CLPDUD for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:52:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8B3FF60786
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B3FF60786
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B3FF60786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:35 +0000 (UTC)
X-Forward-Email-ID: 6a7376b65694ca629d62ba93
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
Subject: [PATCH 07/30] clk: rockchip: rk3399: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:38 +0000
Message-ID: <20260805174509.2968252-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952354; bh=Kb4WtJglZWhuo0KNGUI5rs6b//v/Rp4MM5Fx9UQ9W20=;
 b=tuHPItd1Lm4P+RIx9+ZLuSbRqcTpRT4Ea5dN2WobFY0EGhRJj/Jflq38Vdeg1QO7KD56CqBay
 45LjbW6w9206K8Y9oMBNmS12B7wsEnaVlTZugBGJM3R1dEme9vaKgn9Q0a0PYwqDLjEkjKGGIEp
 y+92HL9eTdsq12lWoOAjpYmvqrFK0rOey3yeDHvPt9j8RNUtZIWbuXpFw+cHqy+tTKUz6bTEM6W
 cdM+0zw+HypKVFc8bGDH1bn8NWn2MAp8L4POh0QM1+4qKAxZhSfzlU0+xs+LU2piooOPjkUoBUT
 WWvvRkwrXfvBaGqQw/YemD/xV83NvURABcDgV8bCl4Sw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tuHPItd1
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
 .../arm/include/asm/arch-rockchip/cru_rk3399.h |  3 +++
 drivers/clk/rockchip/clk_rk3399.c              | 18 +++++-------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3399.h b/arch/arm/include/asm/arch-rockchip/cru_rk3399.h
index d941a129f3e5..b86ae4c7e598 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3399.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3399.h
@@ -95,6 +95,9 @@ check_member(rockchip_cru, sdio1_con[1], 0x594);
 
 #define PWM_CLOCK_HZ    PMU_PCLK_HZ
 
+#define RK3399_PMU_CRU_BASE		0xff750000
+#define RK3399_CRU_BASE			0xff760000
+
 enum apll_l_frequencies {
 	APLL_L_1600_MHZ,
 	APLL_L_600_MHZ,
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 6e87db18be07..9811f94a13f8 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -1492,22 +1492,14 @@ static int rk3399_clk_of_to_plat(struct udevice *dev)
 static int rk3399_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3399_CRU_BASE,
+			offsetof(struct rockchip_cru, glb_rst_st),
+			offsetof(struct rockchip_cru, glb_srst_fst_value),
+			offsetof(struct rockchip_cru, glb_srst_snd_value));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rockchip_cru,
-						    glb_srst_fst_value);
-		priv->glb_srst_snd_value = offsetof(struct rockchip_cru,
-						    glb_srst_snd_value);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rockchip_cru, softrst_con[0]);
-- 
2.54.0

