Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23512C56201
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E032080D93;
	Wed,  5 Aug 2026 17:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ow5asJQRsB2; Wed,  5 Aug 2026 17:51:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D3A780D8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952286;
	bh=WcoIQkEpZIHXr48zGpfZpyMl/yYQZqycaFz0YuAPGmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XXdZKs4GIF5X/fhMOAptY/3MifYcjlzycEufdiigNZFgYZChTJEPZzoC+9nQM9S7e
	 sD/XXuguvflP5JJo6uBWNuBg0PDdcmX3g8BmOYzfA463H4Wn9GEwoYmVxPqfHOG67f
	 I1cG+ohEfqaEr/4QlbDJGF249RfAr+sRn4hdIgn/XY8UhUDnnFl6XiBlwygtJ0GQL8
	 2lnYOlT64BDrwCct/LTkh2bBRlgODLbRhNpWxgGYbm+Pn+mtBSVAhzCZ0Bb13SeSGO
	 NZNz+FEPaAWA4nTk0y8UMD3iW9s+KX63Ap9QOwKV9HB9381ZaBvqFUm6k02UFGd33j
	 b4Mr1AAhXsszQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D3A780D8D;
	Wed,  5 Aug 2026 17:51:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 070DD730
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 050F56078F
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8NxjGsR9F4g for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3521360661
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3521360661
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3521360661
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
X-Forward-Email-ID: 6a7376b15694ca629d62ba35
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
Subject: [PATCH 04/30] clk: rockchip: rk3568: Use rockchip_sysreset_bind()
 helper
Date: Wed,  5 Aug 2026 17:44:35 +0000
Message-ID: <20260805174509.2968252-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952279; bh=WcoIQkEpZIHXr48zGpfZpyMl/yYQZqycaFz0YuAPGmg=;
 b=ETO1+c+w+du0X1UFlL8890R5WMUrmbc0BIgi6y2buAZcfPuaIGL9/g3+gxUCDHbsDIGSkE7yG
 K6R4Q8v3cSlMs8h9PASi2wuwblETnuGWDkly4im6cbh6M77oMgvb56qnVwbJ1cxh72Qczibm/cm
 8O1qX2HGDrEclZKrpFnkkzQjtGcaq0uC5Rtpj9nTn1cDqc/Gm6noK5L6erbrfknDJjJ5VFlmsEt
 2CNmobs1d7dcR7YrJLuw/bv/jTHB+uGvjVy3nofuPo3VCz/nGYBqSU1B4O+EyxiXIDKoGCm2o7g
 y63SEKc8w45hCt2/zBLok+mdhZMuj60TDxEQ2EfsZS/A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ETO1+c+w
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
rockchip_sysreset driver. Also fix the glb_srst_snd register name.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm/include/asm/arch-rockchip/cru_rk3568.h |  2 +-
 drivers/clk/rockchip/clk_rk3568.c              | 18 +++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
index e2dc3cda5577..528bbaf4b044 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
@@ -86,7 +86,7 @@ struct rk3568_cru {
 	unsigned int misc_con[3];/* Address Offset: 0x00C4 */
 	unsigned int glb_cnt_th;/* Address Offset: 0x00D0 */
 	unsigned int glb_srst_fst;/* Address Offset: 0x00D4 */
-	unsigned int glb_srsr_snd; /* Address Offset: 0x00D8 */
+	unsigned int glb_srst_snd; /* Address Offset: 0x00D8 */
 	unsigned int glb_rst_con;/* Address Offset: 0x00DC */
 	unsigned int glb_rst_st;/* Address Offset: 0x00E0 */
 	unsigned int reserved0[7];/* Address Offset: 0x00E4 */
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index eaf51728520a..2a88ed560e40 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2907,26 +2907,18 @@ static int rk3568_clk_ofdata_to_platdata(struct udevice *dev)
 static int rk3568_clk_bind(struct udevice *dev)
 {
 	int ret;
-	struct udevice *sys_child;
-	struct sysreset_reg *priv;
 
 	/* Ensure clocks are initialized after bind in SPL build */
 	if (IS_ENABLED(CONFIG_SPL_BUILD))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
 	/* The reset driver does not have a device node, so bind it here */
-	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
-				 &sys_child);
-	if (ret) {
+	ret = rockchip_sysreset_bind(dev, RK3568_CRU_BASE,
+				     offsetof(struct rk3568_cru, glb_rst_st),
+				     offsetof(struct rk3568_cru, glb_srst_fst),
+				     offsetof(struct rk3568_cru, glb_srst_snd));
+	if (ret)
 		debug("Warning: No sysreset driver: ret=%d\n", ret);
-	} else {
-		priv = malloc(sizeof(struct sysreset_reg));
-		priv->glb_srst_fst_value = offsetof(struct rk3568_cru,
-						    glb_srst_fst);
-		priv->glb_srst_snd_value = offsetof(struct rk3568_cru,
-						    glb_srsr_snd);
-		dev_set_priv(sys_child, priv);
-	}
 
 #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
 	ret = offsetof(struct rk3568_cru, softrst_con[0]);
-- 
2.54.0

