Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E14C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A43882F8C;
	Mon, 30 Jun 2025 20:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jIIizsnE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PXZFyX2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D0682E27; Mon, 30 Jun 2025 20:51:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1FA82EA2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bWFd243RLz9t8d;
 Mon, 30 Jun 2025 20:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlwYPoweauW0urQOV0VRa9jHkSkYRfTXhtWBOBml7XM=;
 b=jIIizsnE+x+3YTwxlkXvHZEdWr0bY1FD+JsjtIwVSfATJV7DdOy8br8IirECh9oqMBexK7
 z54wYJl8qx5f7t9xgSb16ArwIH87IoVEI+ZZWyALkXDvPU1Yqwbsk++wMk/RmMmnynmbE2
 HMaFieCfRMhj/mBYq36gK+VlY6winXcDW0DenEN/gDkuyOyrmbqLgF/HXwh8fUQ7RhHK9w
 u3p3X826hQLcChVkKKYi6PWR7HYIvzMQprekjOxqr2VzKsfeKBFriTojlSRL1Rz2p9ABEH
 Et5r/QtteIH5UTu9smpCyL16ZmWYiEuX1AplpmFGhjcQDHrf4OsIT3qM3zPrzg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlwYPoweauW0urQOV0VRa9jHkSkYRfTXhtWBOBml7XM=;
 b=PXZFyX2pnD3wEqj+cKcODwPDsJ2bft4JlmQpXodt92lw0RtCKr7aMfuCmkS99JWNC/31ah
 ngPY1UqQyLLVkVu8W6LdWC//OJ/94QNtne5/TD5aaKJaaf6vQtD0+uDYwpP154j6vMiBim
 fXh5ftAgfpRDzdINUGE6GpJmr+BYshgHPafFCJtcQT9YwcK4TCMGfFnYW+TSXbu/Jfp8xL
 hU3X4kJQ0BarwZbkQGxr17XtJgGGP6skFSlkyEZTXjssbGDjX+eSPR/ohbgB5bfPU8OXxH
 DMBapfpbEGIXy5aTXAssntQQnW6iuZXUFPRPKxmWt7Corf0WJjref/5SEMimbg==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] net: sh_eth: arm: renesas: README: Drop
 CFG_SH_ETHER_PHY_ADDR
Date: Mon, 30 Jun 2025 20:51:15 +0200
Message-ID: <20250630185124.1099147-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9c57cfa5e29274c5bf5
X-MBO-RS-META: a8bxorfrmp4he8i3rt3yfxqj3q4f1di1
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

Drop CFG_SH_ETHER_PHY_ADDR from README and configuration files, this
value is never used, PHY address is extracted from control DT instead.
No functional change intended.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 README                    | 3 ---
 drivers/net/sh_eth.c      | 4 ----
 include/configs/alt.h     | 1 -
 include/configs/condor.h  | 1 -
 include/configs/gose.h    | 1 -
 include/configs/grpeach.h | 1 -
 include/configs/koelsch.h | 1 -
 include/configs/lager.h   | 1 -
 include/configs/porter.h  | 1 -
 include/configs/silk.h    | 1 -
 include/configs/stout.h   | 1 -
 include/configs/v3hsk.h   | 1 -
 12 files changed, 17 deletions(-)

diff --git a/README b/README
index 7acf39540c2..dbf66bd83ac 100644
--- a/README
+++ b/README
@@ -379,9 +379,6 @@ The following options need to be configured:
 		CONFIG_SH_ETHER
 		Support for Renesas on-chip Ethernet controller
 
-			CFG_SH_ETHER_PHY_ADDR
-			Define the ETH PHY's address
-
 - TPM Support:
 		CONFIG_TPM
 		Support TPM devices.
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 4d9cdf17b46..1160c1d6cfa 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -29,10 +29,6 @@
 
 #include "sh_eth.h"
 
-#ifndef CFG_SH_ETHER_PHY_ADDR
-# error "Please define CFG_SH_ETHER_PHY_ADDR"
-#endif
-
 static void flush_cache_wback(void *addr, unsigned long len)
 {
 	flush_dcache_range((unsigned long)addr,
diff --git a/include/configs/alt.h b/include/configs/alt.h
index 987fd25bb4c..7db01cedb8b 100644
--- a/include/configs/alt.h
+++ b/include/configs/alt.h
@@ -21,7 +21,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/condor.h b/include/configs/condor.h
index b2d66c785fc..3be0f99ec4b 100644
--- a/include/configs/condor.h
+++ b/include/configs/condor.h
@@ -14,7 +14,6 @@
 /* Environment compatibility */
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/gose.h b/include/configs/gose.h
index acef925855a..a5537ee30b2 100644
--- a/include/configs/gose.h
+++ b/include/configs/gose.h
@@ -20,7 +20,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512u * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/grpeach.h b/include/configs/grpeach.h
index 9a7eef57c87..9c47fbf1c90 100644
--- a/include/configs/grpeach.h
+++ b/include/configs/grpeach.h
@@ -17,7 +17,6 @@
 #define CFG_SYS_SDRAM_SIZE		(10 * 1024 * 1024)
 
 /* Network interface */
-#define CFG_SH_ETHER_PHY_ADDR	0
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_MII
 
 #endif	/* __GRPEACH_H */
diff --git a/include/configs/koelsch.h b/include/configs/koelsch.h
index 13d2127ac13..cc6266d4d6c 100644
--- a/include/configs/koelsch.h
+++ b/include/configs/koelsch.h
@@ -20,7 +20,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/lager.h b/include/configs/lager.h
index d76f003e391..f59f44f1862 100644
--- a/include/configs/lager.h
+++ b/include/configs/lager.h
@@ -21,7 +21,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/porter.h b/include/configs/porter.h
index eaf5d31c1d3..265a0d775a3 100644
--- a/include/configs/porter.h
+++ b/include/configs/porter.h
@@ -22,7 +22,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(1024u * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/silk.h b/include/configs/silk.h
index 4ef70281dda..459b9b86797 100644
--- a/include/configs/silk.h
+++ b/include/configs/silk.h
@@ -22,7 +22,6 @@
 #define RCAR_GEN2_UBOOT_SDRAM_SIZE	(512 * 1024 * 1024)
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/stout.h b/include/configs/stout.h
index cb544de243e..d1accb90d9f 100644
--- a/include/configs/stout.h
+++ b/include/configs/stout.h
@@ -26,7 +26,6 @@
 #define CFG_SCIF_A
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x1
 #define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
 
 /* Board Clock */
diff --git a/include/configs/v3hsk.h b/include/configs/v3hsk.h
index a8d1641b36e..c5685b4c6c1 100644
--- a/include/configs/v3hsk.h
+++ b/include/configs/v3hsk.h
@@ -15,7 +15,6 @@
 /* Environment compatibility */
 
 /* SH Ether */
-#define CFG_SH_ETHER_PHY_ADDR	0x0
 #define CFG_SH_ETHER_PHY_MODE	PHY_INTERFACE_MODE_RGMII_ID
 
 /* Board Clock */
-- 
2.47.2

