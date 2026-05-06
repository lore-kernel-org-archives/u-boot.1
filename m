Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F34FCD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0400A84936;
	Wed,  6 May 2026 14:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jIJllXB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6D684936; Wed,  6 May 2026 14:36:27 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8E28484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C8F3940B7A;
 Wed,  6 May 2026 12:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48E7C2BCB8;
 Wed,  6 May 2026 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070983;
 bh=arWjY4GXdhpV0TPJScwVI4FF49MSMgqZsiQ0pCfGXRk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jIJllXB5BllJrW2WuIXkag1WS3FAHKJ09Gex2p639k3jSe9KyTu9ERA2hQTxgnLne
 M2Ztn933KFcRzknhRjJyGMix0hwotyHl+AuArl2Nc95k9LSedxKlHGfA+TC+uLQu0x
 bWZjfT5OCGfALTvRgqEJossZ4FxHbemn8TVOm4ad3v/JjwF1zZvdTQhRXMAdYMHBff
 f8QmM5sXrufavcO7ZITMdNCViUh+cwPGG7in6xmlfM2HfWHXCxuH4eps+cCIv7JWGr
 u5RbQSdONhk4sCA5B6ni5Febd6eXqIQEsMUopNrmBZA9zYA0NDqrfZqy8fBDDHe4wW
 9G9XYnuRT1OMA==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 06/11] boards/nxp: remove empty fdt_fixup_board_enet()
Date: Wed,  6 May 2026 14:34:15 +0200
Message-ID: <20260506123507.2081751-7-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove any empty function which is just called by the board code. There
is no need to define this function at all.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/nxp/ls1043aqds/Makefile     |  3 ---
 board/nxp/ls1043aqds/eth.c        | 11 ---------
 board/nxp/ls1043aqds/ls1043aqds.c |  4 ----
 board/nxp/ls1046aqds/Makefile     |  3 ---
 board/nxp/ls1046aqds/eth.c        | 11 ---------
 board/nxp/ls1046aqds/ls1046aqds.c |  4 ----
 board/nxp/t102xrdb/Makefile       |  1 -
 board/nxp/t102xrdb/eth_t102xrdb.c | 31 -------------------------
 board/nxp/t102xrdb/t102xrdb.c     |  1 -
 board/nxp/t102xrdb/t102xrdb.h     |  1 -
 board/nxp/t104xrdb/t104xrdb.h     |  1 -
 board/nxp/t208xqds/Makefile       |  2 +-
 board/nxp/t208xqds/eth_t208xqds.c | 38 -------------------------------
 board/nxp/t208xqds/t208xqds.c     |  1 -
 board/nxp/t208xqds/t208xqds.h     |  1 -
 board/nxp/t208xrdb/eth_t208xrdb.c |  5 ----
 board/nxp/t208xrdb/t208xrdb.c     |  1 -
 board/nxp/t208xrdb/t208xrdb.h     |  1 -
 board/nxp/t4rdb/Makefile          |  1 -
 board/nxp/t4rdb/eth.c             | 37 ------------------------------
 board/nxp/t4rdb/t4240rdb.c        |  1 -
 board/nxp/t4rdb/t4rdb.h           |  1 -
 22 files changed, 1 insertion(+), 159 deletions(-)
 delete mode 100644 board/nxp/ls1043aqds/eth.c
 delete mode 100644 board/nxp/ls1046aqds/eth.c
 delete mode 100644 board/nxp/t102xrdb/eth_t102xrdb.c
 delete mode 100644 board/nxp/t208xqds/eth_t208xqds.c
 delete mode 100644 board/nxp/t4rdb/eth.c

diff --git a/board/nxp/ls1043aqds/Makefile b/board/nxp/ls1043aqds/Makefile
index ff830788fd7..98ad49f6f0c 100644
--- a/board/nxp/ls1043aqds/Makefile
+++ b/board/nxp/ls1043aqds/Makefile
@@ -5,7 +5,4 @@
 #
 
 obj-y += ddr.o
-ifndef CONFIG_XPL_BUILD
-obj-y += eth.o
-endif
 obj-y += ls1043aqds.o
diff --git a/board/nxp/ls1043aqds/eth.c b/board/nxp/ls1043aqds/eth.c
deleted file mode 100644
index d62cf74732c..00000000000
--- a/board/nxp/ls1043aqds/eth.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2015 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
- */
-
-#include <fdt_support.h>
-
-void fdt_fixup_board_enet(void *fdt)
-{
-}
diff --git a/board/nxp/ls1043aqds/ls1043aqds.c b/board/nxp/ls1043aqds/ls1043aqds.c
index f043599fbb8..0f115c16232 100644
--- a/board/nxp/ls1043aqds/ls1043aqds.c
+++ b/board/nxp/ls1043aqds/ls1043aqds.c
@@ -550,10 +550,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
 
-#ifdef CONFIG_FMAN_ENET
-	fdt_fixup_board_enet(blob);
-#endif
-
 	fdt_fixup_icid(blob);
 
 	reg = QIXIS_READ(brdcfg[0]);
diff --git a/board/nxp/ls1046aqds/Makefile b/board/nxp/ls1046aqds/Makefile
index 365247d92bc..8292726b0e4 100644
--- a/board/nxp/ls1046aqds/Makefile
+++ b/board/nxp/ls1046aqds/Makefile
@@ -5,7 +5,4 @@
 #
 
 obj-y += ddr.o
-ifndef CONFIG_XPL_BUILD
-obj-y += eth.o
-endif
 obj-y += ls1046aqds.o
diff --git a/board/nxp/ls1046aqds/eth.c b/board/nxp/ls1046aqds/eth.c
deleted file mode 100644
index 24e6c93aece..00000000000
--- a/board/nxp/ls1046aqds/eth.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2018-2020 NXP
- */
-
-#include <fdt_support.h>
-
-void fdt_fixup_board_enet(void *fdt)
-{
-}
diff --git a/board/nxp/ls1046aqds/ls1046aqds.c b/board/nxp/ls1046aqds/ls1046aqds.c
index 7df12550868..679b0b2235f 100644
--- a/board/nxp/ls1046aqds/ls1046aqds.c
+++ b/board/nxp/ls1046aqds/ls1046aqds.c
@@ -434,10 +434,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_memory_banks(blob, base, size, 2);
 	ft_cpu_setup(blob, bd);
 
-#ifdef CONFIG_FMAN_ENET
-	fdt_fixup_board_enet(blob);
-#endif
-
 	fdt_fixup_icid(blob);
 
 	reg = QIXIS_READ(brdcfg[0]);
diff --git a/board/nxp/t102xrdb/Makefile b/board/nxp/t102xrdb/Makefile
index b0f27c47191..2a360227418 100644
--- a/board/nxp/t102xrdb/Makefile
+++ b/board/nxp/t102xrdb/Makefile
@@ -9,7 +9,6 @@ obj-y	+= spl.o
 else
 obj-y   += t102xrdb.o
 obj-$(CONFIG_TARGET_T1024RDB)   += cpld.o
-obj-y   += eth_t102xrdb.o
 endif
 obj-y   += ddr.o
 obj-y   += law.o
diff --git a/board/nxp/t102xrdb/eth_t102xrdb.c b/board/nxp/t102xrdb/eth_t102xrdb.c
deleted file mode 100644
index a07d242c1eb..00000000000
--- a/board/nxp/t102xrdb/eth_t102xrdb.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014 Freescale Semiconductor, Inc.
- *
- * Shengzhou Liu <Shengzhou.Liu@freescale.com>
- */
-
-#include <config.h>
-#include <command.h>
-#include <fdt_support.h>
-#include <net.h>
-#include <netdev.h>
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_law.h>
-#include <asm/fsl_serdes.h>
-#include <asm/fsl_portals.h>
-#include <asm/fsl_liodn.h>
-#include <malloc.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <miiphy.h>
-#include <phy.h>
-#include <fsl_dtsec.h>
-#include <asm/fsl_serdes.h>
-#include "../common/fman.h"
-
-void fdt_fixup_board_enet(void *fdt)
-{
-}
diff --git a/board/nxp/t102xrdb/t102xrdb.c b/board/nxp/t102xrdb/t102xrdb.c
index 0a29e27b42c..02223497dd3 100644
--- a/board/nxp/t102xrdb/t102xrdb.c
+++ b/board/nxp/t102xrdb/t102xrdb.c
@@ -207,7 +207,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #ifndef CONFIG_DM_ETH
 	fdt_fixup_fman_ethernet(blob);
 #endif
-	fdt_fixup_board_enet(blob);
 #endif
 
 #ifdef CONFIG_TARGET_T1023RDB
diff --git a/board/nxp/t102xrdb/t102xrdb.h b/board/nxp/t102xrdb/t102xrdb.h
index 33df0f24df8..71e2cfea22e 100644
--- a/board/nxp/t102xrdb/t102xrdb.h
+++ b/board/nxp/t102xrdb/t102xrdb.h
@@ -6,7 +6,6 @@
 #ifndef __T1024_RDB_H__
 #define __T1024_RDB_H__
 
-void fdt_fixup_board_enet(void *blob);
 void pci_of_setup(void *blob, struct bd_info *bd);
 #ifdef CONFIG_TARGET_T1023RDB
 static u32 t1023rdb_ctrl(u32 ctrl_type);
diff --git a/board/nxp/t104xrdb/t104xrdb.h b/board/nxp/t104xrdb/t104xrdb.h
index 678724c7e2b..5825e69cdb4 100644
--- a/board/nxp/t104xrdb/t104xrdb.h
+++ b/board/nxp/t104xrdb/t104xrdb.h
@@ -6,7 +6,6 @@
 #ifndef __T104x_RDB_H__
 #define __T104x_RDB_H__
 
-void fdt_fixup_board_enet(void *blob);
 void pci_of_setup(void *blob, struct bd_info *bd);
 
 #endif
diff --git a/board/nxp/t208xqds/Makefile b/board/nxp/t208xqds/Makefile
index eb99d921b4a..4bfd2b50d8f 100644
--- a/board/nxp/t208xqds/Makefile
+++ b/board/nxp/t208xqds/Makefile
@@ -7,7 +7,7 @@
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 else
-obj-$(CONFIG_TARGET_T2080QDS) += t208xqds.o eth_t208xqds.o
+obj-$(CONFIG_TARGET_T2080QDS) += t208xqds.o
 endif
 
 obj-y   += ddr.o
diff --git a/board/nxp/t208xqds/eth_t208xqds.c b/board/nxp/t208xqds/eth_t208xqds.c
deleted file mode 100644
index e6aeb9bb66f..00000000000
--- a/board/nxp/t208xqds/eth_t208xqds.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- * Copyright 2020 NXP
- *
- * Shengzhou Liu <Shengzhou.Liu@freescale.com>
- */
-
-#include <config.h>
-#include <command.h>
-#include <fdt_support.h>
-#include <log.h>
-#include <net.h>
-#include <netdev.h>
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_law.h>
-#include <asm/fsl_serdes.h>
-#include <asm/fsl_portals.h>
-#include <asm/fsl_liodn.h>
-#include <malloc.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <miiphy.h>
-#include <phy.h>
-#include <fsl_dtsec.h>
-#include <asm/fsl_serdes.h>
-#include <hwconfig.h>
-#include "../common/qixis.h"
-#include "../common/fman.h"
-#include "t208xqds_qixis.h"
-#include <linux/libfdt.h>
-
-void fdt_fixup_board_enet(void *fdt)
-{
-	return;
-}
diff --git a/board/nxp/t208xqds/t208xqds.c b/board/nxp/t208xqds/t208xqds.c
index 5e71da0e163..329cf59793f 100644
--- a/board/nxp/t208xqds/t208xqds.c
+++ b/board/nxp/t208xqds/t208xqds.c
@@ -419,7 +419,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #ifndef CONFIG_DM_ETH
 	fdt_fixup_fman_ethernet(blob);
 #endif
-	fdt_fixup_board_enet(blob);
 #endif
 
 	return 0;
diff --git a/board/nxp/t208xqds/t208xqds.h b/board/nxp/t208xqds/t208xqds.h
index 50ebb6f6f98..4086f8c010a 100644
--- a/board/nxp/t208xqds/t208xqds.h
+++ b/board/nxp/t208xqds/t208xqds.h
@@ -6,7 +6,6 @@
 #ifndef __CORENET_DS_H__
 #define __CORENET_DS_H__
 
-void fdt_fixup_board_enet(void *blob);
 void pci_of_setup(void *blob, struct bd_info *bd);
 
 #endif
diff --git a/board/nxp/t208xrdb/eth_t208xrdb.c b/board/nxp/t208xrdb/eth_t208xrdb.c
index 5223eccb280..c9e415bc446 100644
--- a/board/nxp/t208xrdb/eth_t208xrdb.c
+++ b/board/nxp/t208xrdb/eth_t208xrdb.c
@@ -93,8 +93,3 @@ void fdt_fixup_board_phy(void *fdt)
 		printf("Unable to rename node ethernet-phy@1: %s\n",
 		       fdt_strerror(ret));
 }
-
-void fdt_fixup_board_enet(void *fdt)
-{
-	return;
-}
diff --git a/board/nxp/t208xrdb/t208xrdb.c b/board/nxp/t208xrdb/t208xrdb.c
index d93edf007ad..d47ec91e7d0 100644
--- a/board/nxp/t208xrdb/t208xrdb.c
+++ b/board/nxp/t208xrdb/t208xrdb.c
@@ -160,7 +160,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 #ifdef CONFIG_SYS_DPAA_FMAN
 	fdt_fixup_board_fman_ethernet(blob);
-	fdt_fixup_board_enet(blob);
 	fdt_fixup_board_phy(blob);
 #endif
 
diff --git a/board/nxp/t208xrdb/t208xrdb.h b/board/nxp/t208xrdb/t208xrdb.h
index 26998898e82..e800270a0e2 100644
--- a/board/nxp/t208xrdb/t208xrdb.h
+++ b/board/nxp/t208xrdb/t208xrdb.h
@@ -10,7 +10,6 @@
 #define CORTINA_FW_ADDR_IFCNOR				0xefe00000
 #define CORTINA_FW_ADDR_IFCNOR_ALTBANK		0xebe00000
 
-void fdt_fixup_board_enet(void *blob);
 void pci_of_setup(void *blob, struct bd_info *bd);
 void fdt_fixup_board_fman_ethernet(void *blob);
 void fdt_fixup_board_phy(void *blob);
diff --git a/board/nxp/t4rdb/Makefile b/board/nxp/t4rdb/Makefile
index 8d94faaba1c..6d9b8df2fc1 100644
--- a/board/nxp/t4rdb/Makefile
+++ b/board/nxp/t4rdb/Makefile
@@ -9,7 +9,6 @@ obj-y	+= spl.o
 else
 obj-$(CONFIG_TARGET_T4240RDB)	+= t4240rdb.o
 obj-y			+= cpld.o
-obj-y			+= eth.o
 endif
 
 obj-y	+= ddr.o
diff --git a/board/nxp/t4rdb/eth.c b/board/nxp/t4rdb/eth.c
deleted file mode 100644
index dc2390f1003..00000000000
--- a/board/nxp/t4rdb/eth.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014 Freescale Semiconductor, Inc.
- *
- * Chunhe Lan <Chunhe.Lan@freescale.com>
- */
-
-#include <config.h>
-#include <command.h>
-#include <fdt_support.h>
-#include <net.h>
-#include <netdev.h>
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/cache.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_law.h>
-#include <fsl_ddr_sdram.h>
-#include <asm/fsl_serdes.h>
-#include <asm/fsl_portals.h>
-#include <asm/fsl_liodn.h>
-#include <malloc.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <miiphy.h>
-#include <phy.h>
-#include <fsl_dtsec.h>
-#include <asm/fsl_serdes.h>
-#include <hwconfig.h>
-
-#include "../common/fman.h"
-#include "t4rdb.h"
-
-void fdt_fixup_board_enet(void *fdt)
-{
-	return;
-}
diff --git a/board/nxp/t4rdb/t4240rdb.c b/board/nxp/t4rdb/t4240rdb.c
index 5cacfd27380..11e2c0f78b7 100644
--- a/board/nxp/t4rdb/t4240rdb.c
+++ b/board/nxp/t4rdb/t4240rdb.c
@@ -128,7 +128,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #ifndef CONFIG_DM_ETH
 	fdt_fixup_fman_ethernet(blob);
 #endif
-	fdt_fixup_board_enet(blob);
 #endif
 
 	return 0;
diff --git a/board/nxp/t4rdb/t4rdb.h b/board/nxp/t4rdb/t4rdb.h
index bb3ce216d7d..9ec190c03cb 100644
--- a/board/nxp/t4rdb/t4rdb.h
+++ b/board/nxp/t4rdb/t4rdb.h
@@ -14,7 +14,6 @@
 #define CORTINA_FW_ADDR_IFCNOR				0xefe00000
 #define CORTINA_FW_ADDR_IFCNOR_ALTBANK		0xebf00000
 
-void fdt_fixup_board_enet(void *blob);
 void pci_of_setup(void *blob, struct bd_info *bd);
 
 #endif
-- 
2.47.3

