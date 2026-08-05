Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A019FC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 682C1607DF;
	Wed,  5 Aug 2026 17:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jC_FeUpy1MSR; Wed,  5 Aug 2026 17:51:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7558607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952288;
	bh=0x7/vEomZ9S1/m1QzovhWfysj7nTT0U5WwmyC3RffuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNzYooX+2A4SVaL6dea53+YHiyvl5LsNoYirpba65WWbDYQTZo6w24ouK6hQZ82PT
	 qROa33WI5j27uo1VlMV2GTAlI4H0XST1HL10SEa6QJ6b8DySFCLtb0o5/a05iuN1HZ
	 RtW3WLCpHZaaslD2CTtv/sq6xnbGlpP0y3Pp7yL+mRdvYOjubbucome+0acpTF3lIz
	 Fq4vb5XaqcTz6rdCE4kkbsvoqcIWLNz7IN/tovPOxBduSSfob8MlxHNnMQrG9bbUBn
	 itYstvTMuEvQS+q//TcxIm8IJX86O3GV12Uv46Oh7wA9ic9Obo8M6yyRaHh6pyOpjZ
	 X3PWHHkUaWr2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7558607CA;
	Wed,  5 Aug 2026 17:51:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26CF8144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C4C6607DA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjfmScHdEqni for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:26 +0000 (UTC)
X-Greylist: delayed 328 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 05 Aug 2026 17:51:25 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BEA89607CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEA89607CE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:6ea0:d71e::15;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (unknown [IPv6:2a02:6ea0:d71e::15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEA89607CE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:25 +0000 (UTC)
X-Forward-Email-ID: 6a7376ba5694ca629d62bacf
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
Subject: [PATCH 09/30] clk: rockchip: rk3328: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:40 +0000
Message-ID: <20260805174509.2968252-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952284; bh=0x7/vEomZ9S1/m1QzovhWfysj7nTT0U5WwmyC3RffuY=;
 b=koOUevESUSGBbEijzATQoxgilj69i/pil2xZhjqi9ngM9nEZ6vIghPaV/Zjt2PtPu/o80TIEE
 yNZkDktew394Qac/6RgG/V7knW/RZNas9Iwhvc6SjKmSEGrDIXvtdsVVsZ8G5Sr4ounAUj9mwsW
 sF+JWuaoH7mVYQsnIcZdd4Z9oACBE2DqbO73nES1gh3mDCrko7jmlhmpJxysNBxrwe3h59lU7bU
 Db+Lk3QihDnlbIBb5vD+Jy7DtfcA1ZwCbqV3mqGROuYsF2r8WCeAwX9OiRi8p2hyngZhWHdLVnS
 5uChBW98TslpUhI+RntCvBGkH17xzpFGcxUOlcmyYE1g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=koOUevES
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
 .../arm/include/asm/arch-rockchip/cru_rk3328.h |  2 ++
 drivers/clk/rockchip/clk_rk3328.c              | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3328.h b/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
index 4ad1d33e056e..5dd344b88264 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
@@ -59,6 +59,8 @@ check_member(rk3328_cru, sdmmc_ext_con[1], 0x39c);
 
 #define PWM_CLOCK_HZ    (74 * MHz)
 
+#define RK3328_CRU_BASE			0xff440000
+
 enum apll_frequencies {
 	APLL_816_MHZ,
 	APLL_600_MHZ,
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 7701a9734ee0..d82cc6887cf8 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -914,22 +914,14 @@ static int rk3328_clk_of_to_plat(struct udevice *dev)
 static int rk3328_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3328_CRU_BASE,
+			offsetof(struct rk3328_cru, glb_rst_st),
+			offsetof(struct rk3328_cru, glb_srst_fst_value),
+			offsetof(struct rk3328_cru, glb_srst_snd_value));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3328_cru,
-						    glb_srst_fst_value);
-		priv->glb_srst_snd_value = offsetof(struct rk3328_cru,
-						    glb_srst_snd_value);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3328_cru, softrst_con[0]);
-- 
2.54.0

