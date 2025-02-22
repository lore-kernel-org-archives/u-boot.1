Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B401DC021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5028680FBD;
	Sat, 22 Feb 2025 21:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L9UEdIwI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TRPQT8SU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAEDD80FBD; Sat, 22 Feb 2025 21:36:17 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D31480F92
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z0f0b00v8z9snt;
 Sat, 22 Feb 2025 21:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GAe22qC2JMGaBBEu+Q4g+L8fhv7JshfW03mamRbaDg=;
 b=L9UEdIwI2txZPg+PhYn2Ih6wipVkkOh7B2RGoMKNOchUlVTKTDeIEUDswD7zHLTim4BjaP
 Z8FUKvDV6eM9jKyt5QPxOOY0w0llGwckqXYBri6z1s+WCWaWamgViVvtAqFgzZPoEpa6GM
 BwgGN6yIh/z9jZRCFmBimfg+CR8EXLY6xETMgGBxqUtixYERwZpvAacFIqdIItwz/DaJY5
 D+RiK+yMBzb+aPQ9MSU4pF+w+hqXSmwALlRBjaWZP8pkm+IQXN+oQWuLEvD5Xtmbjxc0Sr
 bFcidszEWsd5ny/ezJT0b1xi06mrks3s59q7XMgJE91MZgkBPhJoluD6poD/6A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GAe22qC2JMGaBBEu+Q4g+L8fhv7JshfW03mamRbaDg=;
 b=TRPQT8SUX3HCdd/3aBWiklpgOm8nxUtVGgrpT6z3N4nlmlMBSlFlR8rqi1bjp5sOoDnhFw
 5ih/pSW0CdmJGul7NnGbrAymTsnEEunCmca2CDVQnv01FX/mXj0mnQEfP1mdxMDSF2cNo3
 PwUpvSAnQJ8dVkRwtaCPPM1twvDxU/jOoxJWR1DBARprLs4SehTpKIx5OS8bNauAYtisX3
 BSp6ZnrKl+3yBTMklqZblc40fOb3Zg0UB7VbyNIsBChowf+QaW+Hr0qEwIOnVeXLjpHsfH
 LXm4XpxBxVpyeSEbGyBohFBClv6fucpKHtjFbWCDdwVGEAccC5fdqD5shHgELQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/23] net: miiphybb: Drop bb_miiphy_init() and .init
 callback
Date: Sat, 22 Feb 2025 21:33:19 +0100
Message-ID: <20250222203511.195437-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 73afb14955f2d4a2d1b
X-MBO-RS-META: cxmrop1biidyqeqy913qqspsapmf7pbg
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

The .init callback is not called by any function, drop it.
There are no more users of the init callback, drop the entire
mechanism.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Reorder this earlier in the series
V3: - Squash net: miiphybb: Drop bb_miiphy_init() and .init callback
      and net: miiphybb: Drop .init callback
    - Add RB from Paul
---
 common/board_r.c           |  3 ---
 drivers/net/phy/miiphybb.c | 11 -----------
 include/miiphy.h           | 10 ----------
 3 files changed, 24 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 179259b00de..db0c5cb8032 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -749,9 +749,6 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
 #endif
-#ifdef CONFIG_BITBANGMII
-	bb_miiphy_init,
-#endif
 #ifdef CONFIG_PCI_ENDPOINT
 	pci_ep_init,
 #endif
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 9f5f9b12c9f..75d9537b355 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -17,17 +17,6 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-int bb_miiphy_init(void)
-{
-	int i;
-
-	for (i = 0; i < bb_miiphy_buses_num; i++)
-		if (bb_miiphy_buses[i].init != NULL)
-			bb_miiphy_buses[i].init(&bb_miiphy_buses[i]);
-
-	return 0;
-}
-
 static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
 {
 	int i;
diff --git a/include/miiphy.h b/include/miiphy.h
index 1e6c7041fdc..0464f5dc219 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -65,7 +65,6 @@ void mdio_list_devices(void);
 
 struct bb_miiphy_bus {
 	char name[MDIO_NAME_LEN];
-	int (*init)(struct bb_miiphy_bus *bus);
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
 	int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
@@ -78,15 +77,6 @@ struct bb_miiphy_bus {
 extern struct bb_miiphy_bus bb_miiphy_buses[];
 extern int bb_miiphy_buses_num;
 
-/**
- * bb_miiphy_init() - Initialize bit-banged MII bus driver
- *
- * It is called during the generic post-relocation init sequence.
- *
- * Return: 0 if OK
- */
-int bb_miiphy_init(void);
-
 int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg);
 int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 		    u16 value);
-- 
2.47.2

