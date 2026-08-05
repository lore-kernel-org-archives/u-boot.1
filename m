Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12183C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBCDB80DDB;
	Wed,  5 Aug 2026 17:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikhl-AiHiGET; Wed,  5 Aug 2026 17:54:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5294580D7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952463;
	bh=M4p/1NRc0T1EaAE9UojDnPGM78gltX3yIr6O7f2q/Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AYmhoBlkj4EaasPziVgdr4UvRt4e8eeuKPCo/hwRxaOilGKusaSfkTOBvfNshOtvc
	 ojOabt5GSE9a4ftAU6Q4mP2bMeRph6/e+0TGBVIN7B6/lLQoVp/2T7yFZVLGKN8xHo
	 wYWzTYtkA3g2sinLPgc6/+VbRt0DGItkJnsAGqBHya5hUtxH6Pg6DWUi2F5a8RjfHn
	 FmAj1ofHJxgvGeFnc+73srIkVxhRL54iRSGvo3XA3Rs0Zy1bIAAQwKQueM0X+IOyxA
	 s+7uBar9mXq9GEizZ4IqX7OuquQb1Wzh33xA66lVNKSCXIeCMGAfBPSof7gFWj0YZs
	 gdsrtl0+QEvNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5294580D7C;
	Wed,  5 Aug 2026 17:54:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FD3D2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA8BB607E7
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YjG0Ubxh_llt for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:54:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 03AE2607CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03AE2607CA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03AE2607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:20 +0000 (UTC)
X-Forward-Email-ID: 6a7376ca5694ca629d62bbe1
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
Subject: [PATCH 18/30] clk: rockchip: rk3066: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:49 +0000
Message-ID: <20260805174509.2968252-19-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952460; bh=M4p/1NRc0T1EaAE9UojDnPGM78gltX3yIr6O7f2q/Rc=;
 b=HXjX8QZdBiBRLNC/q95LfaUW/LXKZLvX5CgHthWvDPIf8GHu+6SXIZDvkyNgk7jFTkwVfIaVD
 E3k186Sh0QUQ1jh9MwbvPqg1uw/DfICyxdUpltfeT5cFOBzSR5c+NPnqVTAtjEeOK7vOmtcSeS4
 dQgAlHDmUEzbNg9LIRk5jTXVVdDcsVV9mYJhbiv8Dpnu9bcVXki6Pq/sbmBWOqGkW0BJMFQ0vI0
 nCM+IGqVRNZfPHCkYMhS1p6ABkZ/3Z9Jw0QXXXwFhJ47YXtEib8w9gbkpnBuhvOvryZtqeqTFBj
 cs2uTKODoKdw/Uia64JRx1ojoyGNDjoTK47qqeKJRUjQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=HXjX8QZd
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
 arch/arm/include/asm/arch-rockchip/cru_rk3066.h |  2 ++
 drivers/clk/rockchip/clk_rk3066.c               | 17 ++++-------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3066.h b/arch/arm/include/asm/arch-rockchip/cru_rk3066.h
index 76a715a8e6a8..2d94a4ee1419 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3066.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3066.h
@@ -60,6 +60,8 @@ struct rk3066_cru {
 
 check_member(rk3066_cru, cru_glb_cnt_th, 0x0140);
 
+#define RK3066_CRU_BASE			0x20000000
+
 /* CRU_CLKSEL0_CON */
 enum {
 	REG(CPU_ACLK_PLL, 8, 8),
diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
index f7dea7859f74..84535e41d8db 100644
--- a/drivers/clk/rockchip/clk_rk3066.c
+++ b/drivers/clk/rockchip/clk_rk3066.c
@@ -669,23 +669,14 @@ static int rk3066_clk_probe(struct udevice *dev)
 
 static int rk3066_clk_bind(struct udevice *dev)
 {
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 	int reg_offset, ret;
 
 	/* The reset driver does not have a device node, so bind it here. */
-	ret = device_bind(dev, DM_DRIVER_GET(sysreset_rockchip), "sysreset",
-			  NULL, ofnode_null(), &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3066_CRU_BASE, 0,
+			offsetof(struct rk3066_cru, cru_glb_srst_fst_value),
+			offsetof(struct rk3066_cru, cru_glb_srst_snd_value));
+	if (ret)
 		dev_dbg(dev, "Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3066_cru,
-						    cru_glb_srst_fst_value);
-		priv->glb_srst_snd_value = offsetof(struct rk3066_cru,
-						    cru_glb_srst_snd_value);
-		dev_set_priv(sys_child, priv);
-	}
 
 	if (CONFIG_IS_ENABLED(RESET_ROCKCHIP)) {
 		reg_offset = offsetof(struct rk3066_cru, cru_softrst_con[0]);
-- 
2.54.0

