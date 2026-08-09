Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CF6C5AD5A
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 230A680D74;
	Sun,  9 Aug 2026 01:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaJjpfGo25tL; Sun,  9 Aug 2026 01:34:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69E6A80BB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239287;
	bh=dinP+jk1IOCHLpnIZOP2t0np2abBTHJQDIOgsSmU/dg=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KGeVhnLSaPQXZ+YtPs9RzSZxrwW3IoV1O3YsnKnRaIiu+YyGEruGop04gYS+suNO+
	 9xgSm6XTTNa9/UgMiAtTeTS0SvTMuCutmYXnmoqvUR9h7NUOlmZZT6fMkoR4ECEIKB
	 x82uy2d0YYXIqzHpxiOE0g8glQD/W7yNlCUD1JOBk7rssBZ81bnN3bou708/yoMj4Z
	 Sgr36rncjweThdP/HMHbncFAVURbTXG0UzIko2G2i6EuOjtq5Gfx0sfLm0FjHn2J0y
	 kU10MTzCY2HbTHaUWHF9wbAWwZTQSmiZwqCbdOx+FT9teRvK9EizGlCB4ELlmGBhI7
	 kMdatMamKRx+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69E6A80BB5;
	Sun,  9 Aug 2026 01:34:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1108A2B6
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02E0380BB5
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyEZ4dibiPao for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:34:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CAEE080B53
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAEE080B53
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAEE080B53
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:42 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHgRP19RTzMlCw;
 Sun, 09 Aug 2026 03:34:41 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH 3/3] pci: pcie-rcar-gen4: Switch to devm_*() GPIO and reset
Date: Sun,  9 Aug 2026 03:32:40 +0200
Message-ID: <20260809013431.444164-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
References: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b42fa90e66d956865d0
X-MBO-RS-META: 57owffawr31t6oboip5turafuink1hza
X-Rspamd-Queue-Id: 4hHgRP19RTzMlCw
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dinP+jk1IOCHLpnIZOP2t0np2abBTHJQDIOgsSmU/dg=;
 b=h90+RIBa6EhnZ2Rxy9f9PLMKTTI7FoTbcWBLMWzvLFInGd3g8OvUwMBuVDzuCNLr3f00xQ
 v8909AVJ4HpnlEY3F1jLzSXhjA8cRIA4TL90lKyiPxR+tVUQBJHvZERId8gb7yGtWTKqyd
 cQ1A/LiqT4DYhTVOjw9zKOhXnauYs2NC1WgYz/7TN9k2gps4PsEjGAC8tP7gNLp+mdrD8P
 4gxTS6UZCoJtpS0AZRl+GHHGPYbyELfwYF9UpOM99TGt/Y1gP9YJOI24Xb4InSaLOHHuFI
 TKufH+vJiOFIRaTbnU/HFdWHAcDykXcxsInyqpgboEtIatXWngFGfOsIgKyzvA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dinP+jk1IOCHLpnIZOP2t0np2abBTHJQDIOgsSmU/dg=;
 b=HZkvkQPFSrOCj/ifrGemXmx9RMSy9SeRvELw/26LRdAsXJubhgD9tQCnwUC7vimdyGD/Dn
 wepe+YCXHKaWsCqXcZdIMLmYKSGYa8Ht+Ezl7OnFaXHfplkzKMwaAoPpT8qJkEPQvlunBS
 yLyZ4clpNBYn8UsOFqaLthmpPgeAScC6kXVuDtOMTQUSwya8BFo//fsKXvMuez0I3IdfJy
 gifFSt+elI8krlc3KTXLYvrxKhrEsDXelX/N6JCLU5so9JPXbDPlYGK3IzmPDLo8v36Osy
 hzl9OlC3C1/3i9/kNgSs0nJFrxLeEj9lnK60FcQZ3oGtuF0PHnxUIP+9XghtmA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=h90+RIBa; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=HZkvkQPF
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=HZkvkQPF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use device managed GPIO and reset get to automatically free
those resources up. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 044bceee6c7..b1d43b2e7aa 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -99,10 +99,10 @@
 struct rcar_gen4_pcie {
 	/* Must be first member of the struct */
 	struct			pcie_dw dw;
-	struct reset_ctl	pwr_rst;
+	struct reset_ctl	*pwr_rst;
 	struct clk		*core_clk;
 	struct clk		*ref_clk;
-	struct gpio_desc	pe_rst;
+	struct gpio_desc	*pe_rst;
 	void			*app_base;
 	void			*dbi2_base;
 	void			*phy_base;
@@ -313,7 +313,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	if (ret)
 		return ret;
 
-	ret = reset_assert(&rcar->pwr_rst);
+	ret = reset_assert(rcar->pwr_rst);
 	if (ret)
 		goto err_unprepare;
 
@@ -323,11 +323,11 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		     DEVICE_TYPE_RC |
 		     ((rcar->num_lanes < 4) ? BIFUR_MOD_SET_ON : 0));
 
-	ret = reset_deassert(&rcar->pwr_rst);
+	ret = reset_deassert(rcar->pwr_rst);
 	if (ret)
 		goto err_unprepare;
 
-	reset_status(&rcar->pwr_rst);
+	reset_status(rcar->pwr_rst);
 	mdelay(1);
 
 	rcar_gen4_pcie_additional_common_init(rcar);
@@ -346,7 +346,7 @@ static int rcar_gen4_pcie_host_init(struct udevice *dev)
 	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
 	int ret;
 
-	dm_gpio_set_value(&rcar->pe_rst, 1);
+	dm_gpio_set_value(rcar->pe_rst, 1);
 
 	ret = rcar_gen4_pcie_common_init(rcar);
 	if (ret)
@@ -366,7 +366,7 @@ static int rcar_gen4_pcie_host_init(struct udevice *dev)
 
 	mdelay(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	dm_gpio_set_value(&rcar->pe_rst, 0);
+	dm_gpio_set_value(rcar->pe_rst, 0);
 
 	return 0;
 }
@@ -428,9 +428,9 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 	rcar->dw.first_busno = dev_seq(dev);
 	rcar->dw.dev = dev;
 
-	ret = reset_get_by_name(dev, "pwr", &rcar->pwr_rst);
-	if (ret)
-		return ret;
+	rcar->pwr_rst = devm_reset_control_get(dev, "pwr");
+	if (IS_ERR(rcar->pwr_rst))
+		return PTR_ERR(rcar->pwr_rst);
 
 	rcar->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(rcar->core_clk))
@@ -444,10 +444,10 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 	if (ret && ret != -ENOSYS)
 		return ret;
 
-	ret = gpio_request_by_name(dev, "reset-gpios", 0, &rcar->pe_rst,
-				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-	if (ret)
-		return ret;
+	rcar->pe_rst = devm_gpiod_get(dev, "reset",
+				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (IS_ERR(rcar->pe_rst))
+		return PTR_ERR(rcar->pe_rst);
 
 	ret = rcar_gen4_pcie_host_init(dev);
 	if (ret)
@@ -469,8 +469,8 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
 	if (!rcar_gen4_pcie_link_up(rcar)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		rcar_gen4_pcie_ltssm_control(rcar, false);
-		dm_gpio_set_value(&rcar->pe_rst, 1);
-		reset_assert(&rcar->pwr_rst);
+		dm_gpio_set_value(rcar->pe_rst, 1);
+		reset_assert(rcar->pwr_rst);
 		clk_disable_unprepare(rcar->ref_clk);
 		return -ENODEV;
 	}
@@ -501,8 +501,8 @@ static int rcar_gen4_pcie_remove(struct udevice *dev)
 	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
 
 	rcar_gen4_pcie_ltssm_control(rcar, false);
-	dm_gpio_set_value(&rcar->pe_rst, 1);
-	reset_assert(&rcar->pwr_rst);
+	dm_gpio_set_value(rcar->pe_rst, 1);
+	reset_assert(rcar->pwr_rst);
 	clk_disable_unprepare(rcar->ref_clk);
 
 	return 0;
-- 
2.53.0

