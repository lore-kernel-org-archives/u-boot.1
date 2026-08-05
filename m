Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCBC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D6BE607DE;
	Wed,  5 Aug 2026 17:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZNpe5XsmImL; Wed,  5 Aug 2026 17:51:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45BAB607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952303;
	bh=G0efoq3Ww/48fQqGz1N5KrmVjb6xFqUhZzoQ1ZJGp00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OxwjGDwsbrqR+godzQ+bwzN53PyMokJFMDV062PnC/ox7gslC40kvVacfSwymE3Nl
	 qznQnNKP8J5A1KA9vXXl1w+MNQMxFXdH7L46tykroxTwy7NqQsYbbDVYI126Yxh6yr
	 21tPXI1MRMDryLshc1zRyh7lvd2TqaYsI5kXTjTQMxowSb3gnTbJ+gOOT+owalpfLc
	 AHrM3iF4Edz9bkncgzf4x8iX6qb3IYg7LcWab1jmGAWiUSCu/MB6dF/UGhCcxrJpsU
	 HPPyBAfQZVN02iZMz5/40TBMDpk98XfrnBRx69EoYor5nTRi0X5rZQW3DoxlNUZRSE
	 g+hj/I2yqds9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45BAB607CA;
	Wed,  5 Aug 2026 17:51:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9643B397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CEF560786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lm8SyvTkM0hD for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 62F75607CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62F75607CA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62F75607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:40 +0000 (UTC)
X-Forward-Email-ID: 6a7376c35694ca629d62bb67
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
Subject: [PATCH 14/30] clk: rockchip: rv1126: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:45 +0000
Message-ID: <20260805174509.2968252-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952299; bh=G0efoq3Ww/48fQqGz1N5KrmVjb6xFqUhZzoQ1ZJGp00=;
 b=GR2A53gdNtcy9X6IfZXRfnptDG0rRr99NZWHHYrxjU+C1OatmAPaE7qCHrVGBk4Jn0alXFG6w
 7DpnZexZQZyogtpAUZqnipHWeQBlxrtm3ixE0LPwrDEBuFVMhRApqbGgzYfUmUI7AtPbT126uO4
 FJPOFHOpWYc4IL38qfmvfCMy0YhWIkOaAC1CqcgrMZRrv/IReXLHtFw89SwO9O9l/4O+NcnYgDl
 RF/LzrAPIdCgMdUdQHT3CPQjHaUkIxZ4O+gTlmlERAD4r0pnaX6p0cyvhJ3dGJA1qRRlUg21Fhs
 sSAm/GjfukZP+0CzvrEfDuNaUdoxPStA00IQfjGK13oQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=GR2A53gd
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
 .../arm/include/asm/arch-rockchip/cru_rv1126.h |  2 ++
 drivers/clk/rockchip/clk_rv1126.c              | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
index ae273de31442..8f7bd1c544f9 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
@@ -150,8 +150,10 @@ struct cpu_rate_table {
 	unsigned int pclk_div;
 };
 
+#define RV1126_PMU_CRU_BASE		0xff480000
 #define RV1126_PMU_MODE			0x0
 #define RV1126_PMU_PLL_CON(x)		((x) * 0x4 + 0x10)
+#define RV1126_CRU_BASE			0xff490000
 #define RV1126_PLL_CON(x)		((x) * 0x4)
 #define RV1126_MODE_CON			0x90
 
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index 39920d34b75a..7c71d0b64ce4 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -1842,22 +1842,14 @@ static int rv1126_clk_of_to_plat(struct udevice *dev)
 static int rv1126_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RV1126_CRU_BASE,
+				     offsetof(struct rv1126_cru, glb_rst_st),
+				     offsetof(struct rv1126_cru, glb_srst_fst),
+				     offsetof(struct rv1126_cru, glb_srst_snd));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rv1126_cru,
-						    glb_srst_fst);
-		priv->glb_srst_snd_value = offsetof(struct rv1126_cru,
-						    glb_srst_snd);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rv1126_cru, softrst_con[0]);
-- 
2.54.0

