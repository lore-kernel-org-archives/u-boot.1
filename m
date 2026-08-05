Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55182C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 192AC4080D;
	Wed,  5 Aug 2026 17:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EK6ReYOE4YXt; Wed,  5 Aug 2026 17:53:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4753407C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952382;
	bh=fmlqMH66VwUl8MIroDYtZvly7SqCUGFUuDCau4ZLNtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qw32CVowBfuzQ6ux1OOnRcLrQQDlVc2VQWgbrx0MWRMbGBjgXwkbzuX1d/YkFssI3
	 vJ3SYmE41BRcFFZ7M4qsygDsVa67dr61ttpvt/TwPtWkvDQSyoqoAg5/7HAELy+Ig/
	 GVe2FajcVZnV21fojBgSErNFYMuSQXbx9FF+cAHqTYPKuTSsrL1EAZlCToHGt05dSe
	 XofDSwU5luFa0Gkk7g3AU3Zo6ghJREmPyjBY8SBQseTharwCDzingT0mF5YxDh2xMi
	 tZ5mSumvnQpsR09HCjiIqR+VN/07QPQUM7GUXS0hMqaa/apFVNEgp/PenqY7sIN57k
	 5iJKewxVohFYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4753407C0;
	Wed,  5 Aug 2026 17:53:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF98397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4ABC607F0
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FB6PwQapaizn for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:53:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B5C1D607D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5C1D607D2
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5C1D607D2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376c85694ca629d62bbc3
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
Subject: [PATCH 17/30] clk: rockchip: rk3128: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:48 +0000
Message-ID: <20260805174509.2968252-18-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952379; bh=fmlqMH66VwUl8MIroDYtZvly7SqCUGFUuDCau4ZLNtI=;
 b=qdHz7WG6Z/L7aMfVd44am29BYtzncSUdg/BmUqr4r76iBSxAxbHdRrSYi7MVpk8XjzYpvhlmO
 ZnK03SS95dtaoP8ZfDu8LJUKengTVeORZ/SGu0YIctSulx36m4nAmlIFLIcqyGABeNhKmtOcO0v
 fnYYQ+7xl0yfcdEhRAyOlmAjP7aQi0TAUZAkRysBhpWJQ9sFAwll6pBBTrv+zf5kKRGo1BXy4yf
 0lBSMZt6GcaMUoWyjeWL+jcGWVhOmZwV4BK7xJWqBNJ6wtNZKrmoKUHSy84l0vlxJ0vOFrOMfUk
 TJy6DDXunZ2d7mhTYRcRYlC+QSMUmTuTNY7WWiX2zrWA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=qdHz7WG6
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
 .../arm/include/asm/arch-rockchip/cru_rk3128.h |  2 ++
 drivers/clk/rockchip/clk_rk3128.c              | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3128.h b/arch/arm/include/asm/arch-rockchip/cru_rk3128.h
index cca812d29e40..02347d09117f 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3128.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3128.h
@@ -70,6 +70,8 @@ struct pll_div {
 	u32 frac;
 };
 
+#define RK3128_CRU_BASE			0x20000000
+
 enum {
 	/* PLLCON0*/
 	PLL_POSTDIV1_SHIFT	= 12,
diff --git a/drivers/clk/rockchip/clk_rk3128.c b/drivers/clk/rockchip/clk_rk3128.c
index a07285593b55..7ec7e331f11f 100644
--- a/drivers/clk/rockchip/clk_rk3128.c
+++ b/drivers/clk/rockchip/clk_rk3128.c
@@ -566,22 +566,14 @@ static int rk3128_clk_probe(struct udevice *dev)
 static int rk3128_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3128_CRU_BASE,
+			offsetof(struct rk3128_cru, cru_glb_rst_st),
+			offsetof(struct rk3128_cru, cru_glb_srst_fst_value),
+			offsetof(struct rk3128_cru, cru_glb_srst_snd_value));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3128_cru,
-						    cru_glb_srst_fst_value);
-		priv->glb_srst_snd_value = offsetof(struct rk3128_cru,
-						    cru_glb_srst_snd_value);
-		dev_set_priv(sys_child, priv);
-	}
 
 	return 0;
 }
-- 
2.54.0

