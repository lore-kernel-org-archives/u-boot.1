Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF461C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66AFD607F0;
	Wed,  5 Aug 2026 17:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ldp2HZWGtan9; Wed,  5 Aug 2026 17:53:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 991B3607E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952385;
	bh=z9aud13U2lIhR+g959zxhM7Uv7+k551G/cV1ENQ8Puw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSlMbthieRxdWmalsBoIC4QdsDyqw8yF+suLqDnZzz8tE0VhFjIeuC3OFAUIFF1bk
	 nJuCW+dUQOCcHc8V7MG3vO0wyvUWAbQm/4a6OzYMf3uyNfWFNUkodzxt50GRiMkjnB
	 KQNr8AJeawy9kCO3VLcUvo3BzKIZ5MaXyT7wm6awOAC6ekXC6Lu0dqfzEpVaAE4ItD
	 5ZZJGoGW+ye36Z+kO+oX8EeLOD7arUvAJSRYBvmV/qEVK2Di+6OH7OR3QhvIYaULKW
	 HdzNpMNGP5CwpAMYhRDKk1bTRbx6NvDAWFGcfqP3foW35h4PCmpZpz2gpHMjHAO5rU
	 nykBGIR60VZwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 991B3607E9;
	Wed,  5 Aug 2026 17:53:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 88284144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A46E607D2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5eKpCVY6NFIi for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:53:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C51BB607EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C51BB607EB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C51BB607EB
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376b85694ca629d62bab1
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
Subject: [PATCH 08/30] clk: rockchip: rk3368: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:39 +0000
Message-ID: <20260805174509.2968252-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952379; bh=z9aud13U2lIhR+g959zxhM7Uv7+k551G/cV1ENQ8Puw=;
 b=ArkKL+ROd+vGNGKlcOJpFnYAY4db8NVSulZMXN8KeKEy7byS/GqJorZtn+49AS+KmSxxvyU4h
 YKLaX9lBK+t0kcLRtKLgRKa8IxvJnUaxIgQzyaEpkvfuT4yhv86j8I88DgJqm4vnPXA/MokSlIB
 75vM+PqdmWgcfP4njmURsyBNBsg5KWnMsiIV5o1HDHek/6GP+qlP5PFEklVwqsGIDGTuMBWQv7V
 Orj+OvwaPhJ+uxE0A1plTcBVG2MYxkwr5vv5NgdKI3GqN+1Yc2mBailWXvyxR7w+Jc0P8MTwuH+
 Gjyn5hrnD1o4h1JaDJNWiXj6ftErhnwCo/goBsUjeuyg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ArkKL+RO
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
 .../arm/include/asm/arch-rockchip/cru_rk3368.h |  2 ++
 drivers/clk/rockchip/clk_rk3368.c              | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
index ed2a61218552..bc6beb60ca11 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
@@ -54,6 +54,8 @@ struct rk3368_clk_priv {
 	struct rk3368_cru *cru;
 };
 
+#define RK3368_CRU_BASE			0xff760000
+
 enum {
 	/* PLL CON0 */
 	PLL_NR_SHIFT			= 8,
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb1df..695e72ff3177 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -607,22 +607,14 @@ static int rk3368_clk_of_to_plat(struct udevice *dev)
 static int rk3368_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3368_CRU_BASE,
+				offsetof(struct rk3368_cru, glb_rst_st),
+				offsetof(struct rk3368_cru, glb_srst_fst_val),
+				offsetof(struct rk3368_cru, glb_srst_snd_val));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3368_cru,
-						    glb_srst_fst_val);
-		priv->glb_srst_snd_value = offsetof(struct rk3368_cru,
-						    glb_srst_snd_val);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3368_cru, softrst_con[0]);
-- 
2.54.0

