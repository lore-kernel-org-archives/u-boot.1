Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DEBEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A4686A26;
	Wed,  6 Sep 2023 23:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LSH8ZeG7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N2f4tGx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A1586A7A; Wed,  6 Sep 2023 23:31:06 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782E786A30
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgwXf1qsbz9sjN;
 Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yo+hyoxMIt3iHDlg5VRbVYbFmFFsn1YinZ/6IPuCOSw=;
 b=LSH8ZeG7m8LxhFF/JLq9VlC4WtEfSz4i/Z5xGSgVqTz5PBEKKsrc2n62Xb8yeG6gBpjxa8
 TwRUSNQMrYXfgmNKJQSmKq3J1u6vdzkWSi7YXtxJzIY1n6MqF2LbIRat0517aquwMh+29V
 x0gNaaSWyj8/I9fjHRYV7zkWfdmgvF+9H4E211bnvJTIzexP1GDTrv/cyv7IP1DU6dt51k
 MH4ymn4nDrY5/wEUjzjwGZlyvEktS7E5zAad4H0tBFGBTvnGrrMeeIur8SG5MmEbsfTzOV
 Xm0kv+FKiZsf6+uQNTSrAMUTGZ5G0r8CHJ9deRf+D01wW1YmrPxJGNyd9nHJjg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yo+hyoxMIt3iHDlg5VRbVYbFmFFsn1YinZ/6IPuCOSw=;
 b=N2f4tGx3T11spuAIQXI8gwBi6lsHlCX397arLCHI7BGYXK/De8Tyk25iOzhQfgN8GTiDa1
 sVSVdD/l0Ve8ZodnaBmAjIM6xBRl8G7GOwwIxObA/yEm60PbK7EHq7z1nt9DSIeN5AB0gF
 PxwKSUd3COuzu+T0+WLJDRrlJUK1n2Z3KzsSci6zDwyWHFt/52kO7tcLAaLHxXnYh6KPpp
 uZ0EMo5UX1B4Ewjf/g2VoI651uiENrKyBuXVbYgmUF6+AHWDsV3YqJeM1qsxvfUQGcpq6r
 2o4yBNSN7J8g3nK/enCKqOAV/dASsi8ilLPBeJOF7d8unufUqgpOeDJaw2F/zg==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 28/35] net: miiphybb: Remove unused NEEDS_MANUAL_RELOC code
 bits
Date: Wed,  6 Sep 2023 23:30:08 +0200
Message-Id: <20230906213015.203437-29-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ebjircy9iq34n1qnr1ij497a1e17essk
X-MBO-RS-ID: fd89c1e8ce3cafca41f
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
 drivers/net/phy/miiphybb.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 24d617553e7..cf71f7d4e7e 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -18,10 +18,6 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-#define BB_MII_RELOCATE(v,off) (v += (v?off:0))
-
-DECLARE_GLOBAL_DATA_PTR;
-
 #ifndef CONFIG_BITBANGMII_MULTI
 
 /*
@@ -110,21 +106,9 @@ int bb_miiphy_init(void)
 {
 	int i;
 
-	for (i = 0; i < bb_miiphy_buses_num; i++) {
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-		/* Relocate the hook pointers*/
-		BB_MII_RELOCATE(bb_miiphy_buses[i].init, gd->reloc_off);
-		BB_MII_RELOCATE(bb_miiphy_buses[i].mdio_active, gd->reloc_off);
-		BB_MII_RELOCATE(bb_miiphy_buses[i].mdio_tristate, gd->reloc_off);
-		BB_MII_RELOCATE(bb_miiphy_buses[i].set_mdio, gd->reloc_off);
-		BB_MII_RELOCATE(bb_miiphy_buses[i].get_mdio, gd->reloc_off);
-		BB_MII_RELOCATE(bb_miiphy_buses[i].set_mdc, gd->reloc_off);
-		BB_MII_RELOCATE(bb_miiphy_buses[i].delay, gd->reloc_off);
-#endif
-		if (bb_miiphy_buses[i].init != NULL) {
+	for (i = 0; i < bb_miiphy_buses_num; i++)
+		if (bb_miiphy_buses[i].init != NULL)
 			bb_miiphy_buses[i].init(&bb_miiphy_buses[i]);
-		}
-	}
 
 	return 0;
 }
-- 
2.40.1

