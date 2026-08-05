Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B9AC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AEBA607D5;
	Wed,  5 Aug 2026 17:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ga-EtnQAg2mK; Wed,  5 Aug 2026 17:52:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE4DF607B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952358;
	bh=nEXYdVl32TPhpMiW3ppY13VsFlDVU7O8KR5ndWqY0mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vCsi50rfaFu6msrpj1CTliYtxz/nypIGi41rXoabvK6om1+m60a9VEeutiAjty1dm
	 Hos5mDlrUZ4bzcWHjlsZzeH29fVtI5COg/FAB8kgX24NVPw/uiuReu4ES5q7ovYu2L
	 LUx5elBAJIWBJ4x6JX6kHIFiUUgwiscT7vush6Kgak+c8eWFBkfegf7QwigGyuR2HE
	 oCBZlOAqg/SoWb7/Zi27SmjCIIURugq8zqLciaNxslMci/iwW4dT9QxDBW05YgOlhD
	 lXplJecWt2EKnf8EXMkRaG7ERgW1JeQenejffj0RXpWrBgYAlJpxernd3oGJmPVIA0
	 5aa2opBBrhhUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE4DF607B4;
	Wed,  5 Aug 2026 17:52:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98A94144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96797607D1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIVe8ajo0YOA for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:52:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D37C3607CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D37C3607CA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D37C3607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:35 +0000 (UTC)
X-Forward-Email-ID: 6a7376b35694ca629d62ba55
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/30] clk: rockchip: rk3528: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:36 +0000
Message-ID: <20260805174509.2968252-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952354; bh=nEXYdVl32TPhpMiW3ppY13VsFlDVU7O8KR5ndWqY0mQ=;
 b=pXHFxJ3z4bSSzaTn9K73ST28BWEUCtBD9oOglSdkCaceuUW44Rexue9NhTqVGli249JvkKYd6
 Cr3aulRF6TnZqOCWFDxRJb1K0sBS+DtdhtPoYhb9RxvaMHm8iDaSb7un7ULf/NwW0+ZtrPOaC1d
 ZmgOsO7DS0lgtwxdwLGp2Ow7SwSsj79rfLTOR92UMfueGlD7coRobA62oK8cxvyp3MZx2qNIJ9D
 BakxqsG5/pafi1cVQfrzEsJPHSW4qvcdPg7jyAFYXoRq+85Cn4wiCoXazZfphkRU8iJaVZKsvCG
 j2MHOvfSiU9QFbGm/KYomkkxaK49LLkjt43Szj+rmryg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=pXHFxJ3z
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
rockchip_sysreset driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3528.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 976ef0e0a919..b125e5f77021 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1711,8 +1711,6 @@ static int rk3528_clk_ofdata_to_platdata(struct udevice *dev)
 
 static int rk3528_clk_bind(struct udevice *dev)
 {
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 	int ret;
 
 	/* Ensure clocks are initialized after bind in SPL build */
@@ -1720,18 +1718,12 @@ static int rk3528_clk_bind(struct udevice *dev)
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, (unsigned long)RK3528_CRU_BASE,
+				     offsetof(struct rk3528_cru, glb_rst_st),
+				     offsetof(struct rk3528_cru, glb_srst_fst),
+				     offsetof(struct rk3528_cru, glb_srst_snd));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3528_cru,
-						    glb_srst_fst);
-		priv->glb_srst_snd_value = offsetof(struct rk3528_cru,
-						    glb_srst_snd);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3528_cru, softrst_con[0]);
-- 
2.54.0

