Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA3606C6C9
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nqIHo6m0;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=CbOtgwir
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11E4F40EA0;
	Fri, 20 Nov 2026 18:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlLZIn5lZ6Xj; Fri, 20 Nov 2026 18:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBB5B40E80
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198425;
	b=Jhl9HI4V3GKJajt8MSegvedzlLXSzNdg93sPM9GAKCFMl+ksuCX8m6VIj5sEc43sXgEN
	 pHWsWui+MnQqy2rT3H6KNiun043mNaybo+g/yGpzZty/IA/Rrr5sRaMeRVPpj697oDPEp
	 1AoO20xla0oExtRTI5NO1wz2k1m6bcLKnyEyZ1bR2LkmG2WOq2RmmLpArkCj4Lia30dNP
	 5xy10G9Q0P6mN89EpS+3Wyvf6Mp/8w10bWlW8MsJBl52Us9WWGsi+B8Ml7T58NbSuafoD
	 ydZHNIkSb6rK48rIF4an88N0uLWbxs6SbHhUYcaGShE06cNnWBgOlBSqAzXkBidIcCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PSEhJ6JYjQ0EYkeQi/Kl6xE0OJ+5JWGfTkRAGppowNU=;
	b=JWo91NY9MM2h0ak4TZtQRqCEd2Eu2PnHejAHMMGO7npIHEwzPU/WNjCvWtj6yB+HqXUm
	 m7V8q9bOachbdvIViC4mSD3FGL5J45UAwUWSRsCmmW6l0gsmH/+MoaH8gCVQKb6Pg19Mw
	 2ZUI05c5xlXoW2HhlY07yfW/5DSZwqjuLrRDW0Yq0RlfMjZhVFoyGWml1T3wDah9dgtjc
	 Mm+a2LHpvnoaZbUXUBUrluofXAVt8UW3s0W7ooN7KiWJqyf0QfclYuyq41ZH/y0li/0V6
	 uVxLajfQNgX028A0zuUxtrNXcDlvjdXiEZyD0VfhGkKq5gIAt98IzQuc02IVfm2mpEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198425;
	bh=PSEhJ6JYjQ0EYkeQi/Kl6xE0OJ+5JWGfTkRAGppowNU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nqIHo6m0dyAlmiiJu3M0Yvca9f1+XgAgwtNI5gfZZWZ4b/Ci1ld6Q3DC4B1CQ/dNM
	 sfBYx7VAVTR4xI2F+rKlzEPg4+2NYQF70OydjPwcyXWYgiO+6L4Q6qcDN9Ox6L0hGF
	 F4CTkAH1AUCe7Q6Z0Vi+XC0IpyeSIBgjsjLG3mD50o2GMC7Fdrt9J4Dhpae8Frz5Xv
	 PScjgqQvikdEUZCABRWVD2Wmo1J0gHpacIUwiqfoAOeoRY6QqoDNgd2Giki+XrKZB8
	 X2vQsY3RC4wBlJEJAvCOHXWORJmJ7Cl7DYFfvfX0yFNDOd1phOdrUvorM0CsJzos3X
	 QeQgfcT7vPtpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBB5B40E80;
	Fri, 20 Nov 2026 18:13:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FF45465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5632A4022E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2owMlGGMlAG for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A1186400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=CbOtgwir
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1186400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198417; x=1826734417;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=mb/L7P8v3j4IgOFCy8HjiSN3D/tmfNKzIAfQwytJJHQ=;
 b=CbOtgwirW5xXqjKX0/LUlKTVSQ3xELq2LosNZ9VdBltNpRAClD4lO001
 ZPyhK3wKb49bsE5ZF2c+vwatm+sRAS3o1l6xK1XAWF79leQdUD5ND0ypL
 +kPosWlWzCQtRKTObX9tbGvjksLPmbOTvKARFJNX5U1h8LPmqxsgtEhBn
 LBHpO73mnwp/qUJYUwJ6yy5iE7AK81HhgdG35/0IY3Nukhk3r0jJzhFuA
 bZGiWeQb0b2GhOcppHVCFdEtbGgUnHN7aKB+HHL14GhqlKbsjLWXQMNXE
 bqBkGgRisvu7uL5InqiN4xbw6YvnzNoseBXGhma5AGjMYNCXOxs4XwPvi A==;
X-CSE-ConnectionGUID: Y/pZmrFOSgqRycSrwCRynw==
X-CSE-MsgGUID: 1BA9CJJfS2iUn1QZH06jsg==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="65862338"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 11:13:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 11:13:36 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:35 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 20 Nov 2026 13:13:05 -0500
Subject: [PATCH 6/6] net: macb: use dm_eth_phy_connect() if CONFIG_DM_MDIO
 is enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-6-d344297d5b44@microchip.com>
References: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
In-Reply-To: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
To: <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Nathan Whitehorn <nwhitehorn@pa.msu.edu>, Conor Dooley
 <conor@kernel.org>, Romain Caritey <romain.caritey@microchip.com>, "Mame
 Maria Mbaye" <MameMaria.Mbaye@microchip.com>, Charles Perry
 <charles.perry@microchip.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows the macb driver to use phy connected to an external MDIO bus
controller.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/macb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index 39ab56c9d8fd..80d1e6f04d63 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -663,11 +663,6 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 	arch_get_mdio_control(name);
 	/* If port is not fixed -> setup PHY */
 	if (!macb_port_is_fixed_link(macb)) {
-		/* Auto-detect phy_addr */
-		ret = macb_phy_find(macb, name);
-		if (ret)
-			return ret;
-
 		if (macb->phy_addr == PHY_MAX_ADDR+2) {
 			/* Internal PCS fake PHY */
 			int id;
@@ -676,8 +671,17 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 			macb->phydev->node = dev_ofnode(dev);
 		} else {
 			/* Real PHY */
-			macb->phydev = phy_connect(macb->bus, macb->phy_addr, dev,
-					     macb->phy_interface);
+			if (IS_ENABLED(CONFIG_DM_MDIO))
+				macb->phydev = dm_eth_phy_connect(dev);
+			if (!macb->phydev) {
+				/* Auto-detect phy_addr */
+				ret = macb_phy_find(macb, name);
+				if (ret)
+					return ret;
+
+				macb->phydev = phy_connect(macb->bus, macb->phy_addr,
+							   dev, macb->phy_interface);
+			}
 		}
 
 		if (!macb->phydev) {

-- 
2.53.0

