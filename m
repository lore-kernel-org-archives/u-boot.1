Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D77DC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54523407E9;
	Wed,  5 Aug 2026 17:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PT5aETYKqndV; Wed,  5 Aug 2026 17:51:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34C8D407C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952299;
	bh=Ic5MsYPfJTHOen+jqRSzRtJvvUyx3l+WFic5nc0Qzmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qkjhWGPP8T7SYPapQhBp73hV5rHGp3em+S6kih1OTQ7Dgj0N3IM5WAXPFmQC18KLF
	 gET4HfMllSrkR8u0oHaKhBvCzh726XtoGE0uFcgnxcdOc3Yvb1en4+pb0D3Ccc7b35
	 4O8IPLa/Mtk2MQTFPn8jg/xDplrHpaONarDXTqy5UyY4GOcAcpnfecC1QV5UH5/oFH
	 I06D1DnmOuJKaYzjNcvx1iZD/bQMZc/kiD8sOaKyB1RO8BJn22jwNFaQgzjhVLNzLG
	 GPtXoEmfPKTWnnj4VJ5NnNolIFA6b+jwSLhIcYfvsKn4ZiyMaN64BnHZ2snu+zfsBX
	 7wNG2fh8n2jCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34C8D407C1;
	Wed,  5 Aug 2026 17:51:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52A2B397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39847607CF
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_nW1CCHsI7k for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 42E8960786
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42E8960786
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42E8960786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:35 +0000 (UTC)
X-Forward-Email-ID: 6a7376bf5694ca629d62bb2b
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
Subject: [PATCH 12/30] clk: rockchip: rk322x: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:43 +0000
Message-ID: <20260805174509.2968252-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952294; bh=Ic5MsYPfJTHOen+jqRSzRtJvvUyx3l+WFic5nc0Qzmo=;
 b=RA1U56Q2wz8ony33DO7zurFdwPF6SpUb83ujLqT/dSQKUbf52OIKd0edmtQaP1JyQcMGFwSTw
 art1mD8Z1mZda11LBbhtlegU2Mbcnxj7VL1KdgHoHo+Sv+nK04nGHMw1kkdMuZxaMqTmpmypi1d
 2eZQRSABIzhsdLwq4FaUXSmCafRSgyKuR7n739x9AaahEZzHVIpASfIhcww+Ka0i6S0QqrCYMmu
 cgKNaAzeAIYTPo1DjAdmtcs/uTQTcqGx79Xam/nuA6A/dyoUxQ+eATO520BtEjHgFXZksjpj0vv
 VgB9ckFLiyVGH9ZCXhwHr3nQCRXPT73TjKolCKy/m6VA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RA1U56Q2
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
 .../arm/include/asm/arch-rockchip/cru_rk322x.h |  2 ++
 drivers/clk/rockchip/clk_rk322x.c              | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk322x.h b/arch/arm/include/asm/arch-rockchip/cru_rk322x.h
index ee12fa831f28..707cc2f4b9fc 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk322x.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk322x.h
@@ -64,6 +64,8 @@ struct pll_div {
 	u32 frac;
 };
 
+#define RK322X_CRU_BASE			0x110e0000
+
 enum {
 	/* PLLCON0*/
 	PLL_BP_SHIFT		= 15,
diff --git a/drivers/clk/rockchip/clk_rk322x.c b/drivers/clk/rockchip/clk_rk322x.c
index 9b71fd863bad..680e4faf31ed 100644
--- a/drivers/clk/rockchip/clk_rk322x.c
+++ b/drivers/clk/rockchip/clk_rk322x.c
@@ -495,22 +495,14 @@ static int rk322x_clk_probe(struct udevice *dev)
 static int rk322x_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK322X_CRU_BASE,
+			offsetof(struct rk322x_cru, cru_glb_rst_st),
+			offsetof(struct rk322x_cru, cru_glb_srst_fst_value),
+			offsetof(struct rk322x_cru, cru_glb_srst_snd_value));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk322x_cru,
-						    cru_glb_srst_fst_value);
-		priv->glb_srst_snd_value = offsetof(struct rk322x_cru,
-						    cru_glb_srst_snd_value);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk322x_cru, cru_softrst_con[0]);
-- 
2.54.0

