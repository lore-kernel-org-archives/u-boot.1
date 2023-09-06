Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C727DEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4C9B86AB7;
	Wed,  6 Sep 2023 23:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LMjyYN6O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DJyotOXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDA3869EB; Wed,  6 Sep 2023 23:31:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F64586A78
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXf60SHz9sn0;
 Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0B6qXu0ELsH83Kxrat6/W/ciNyJZ6/99wSEQjrE+sM=;
 b=LMjyYN6O70QjJHt0+XHfGG+j1S07HI4C+cQYddLXvADjTxgvnKvjISu6UXFYPQds8sq2++
 GlfxdcdtP9P4nbH/3hAVSGNpXQgZpkAKqEdMde1IuYwNTxl7CRvnq/JpY08eYF8RWTUnjv
 y+fcx14V1/NTItwjJtkv53F4c8Q57Xp0t3VPexInyTOENfE3zyBTz/IRMIMzv9yr8itedN
 r4dfcHz2N0U9SbCBqUCrT6RQRL/JDyCeJQy0dgWau9xvrS9/wvl/r8Jpz73gGEGSJhGgRW
 epZ/GgHQuX7oh3TAcFUCAZ2bYtES5/JXUt/rsmDciEhJHu7UVDoaNAYSuijyeA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0B6qXu0ELsH83Kxrat6/W/ciNyJZ6/99wSEQjrE+sM=;
 b=DJyotOXa7R+hAFFIR3XVKxXCU1O5AciAazMSpqW8pemc8323haxxcVdqxiPLEaYbVCZ5z2
 vzOC/ptzNTcsoU9WL3200bC42SosLrctBBihUzcXnv3LmfZkpRmHi/pIP153v6LhlAsrmX
 VWPA0mow33H2R83Hf8r8atvx9TOBK4JDHg5h/mvBAWVsMsuc8Q10uL+8+reIhGa/103lBL
 w/nuvyCocds6U4AGH3+D5i9CXRSbIKapVAn3eQtf1dCuVGj2D8rrpm51J8//73D2OAqLOi
 ezhUvx1BEZLZGycErqcRjiUFeBorhxRoFZm6owqW/SLYmKsk/a/wA2quvwkApA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 29/35] net: phy: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:09 +0200
Message-Id: <20230906213015.203437-30-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8d111b89b8481bc3f46
X-MBO-RS-META: 515q6jm5f8nppnza9inejyg5wdwd5fz6
X-Rspamd-Queue-Id: 4RgwXf60SHz9sn0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/net/phy/phy.c | 31 -------------------------------
 include/phy.h         |  8 --------
 net/eth_common.c      |  4 ----
 3 files changed, 43 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index ae21acb059b..d50fd505e51 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -463,37 +463,6 @@ U_BOOT_PHY_DRIVER(genphy) = {
 	.shutdown	= genphy_shutdown,
 };
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-int phy_init(void)
-{
-	const int ll_n_ents = ll_entry_count(struct phy_driver, phy_driver);
-	struct phy_driver *drv, *ll_entry;
-
-	/* Perform manual relocation on linker list based PHY drivers */
-	ll_entry = ll_entry_start(struct phy_driver, phy_driver);
-	for (drv = ll_entry; drv != ll_entry + ll_n_ents; drv++) {
-		if (drv->probe)
-			drv->probe += gd->reloc_off;
-		if (drv->config)
-			drv->config += gd->reloc_off;
-		if (drv->startup)
-			drv->startup += gd->reloc_off;
-		if (drv->shutdown)
-			drv->shutdown += gd->reloc_off;
-		if (drv->readext)
-			drv->readext += gd->reloc_off;
-		if (drv->writeext)
-			drv->writeext += gd->reloc_off;
-		if (drv->read_mmd)
-			drv->read_mmd += gd->reloc_off;
-		if (drv->write_mmd)
-			drv->write_mmd += gd->reloc_off;
-	}
-
-	return 0;
-}
-#endif
-
 int phy_set_supported(struct phy_device *phydev, u32 max_speed)
 {
 	/* The default values for phydev->supported are provided by the PHY
diff --git a/include/phy.h b/include/phy.h
index f023a3c2685..27effdb5763 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -171,14 +171,6 @@ struct fixed_link {
 	int asym_pause;
 };
 
-/**
- * phy_init() - Initializes the PHY drivers
- * This function registers all available PHY drivers
- *
- * @return: 0 if OK, -ve on error
- */
-int phy_init(void);
-
 /**
  * phy_reset() - Resets the specified PHY
  * Issues a reset of the PHY and waits for it to complete
diff --git a/net/eth_common.c b/net/eth_common.c
index c94a7ba6ae7..14d4c07b695 100644
--- a/net/eth_common.c
+++ b/net/eth_common.c
@@ -36,10 +36,6 @@ void eth_common_init(void)
 #if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) || defined(CONFIG_PHYLIB)
 	miiphy_init();
 #endif
-
-#if defined(CONFIG_NEEDS_MANUAL_RELOC) && defined(CONFIG_PHYLIB)
-	phy_init();
-#endif
 #endif
 }
 
-- 
2.40.1

