Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62121CD6E53
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 10:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870D284671;
	Sat, 30 May 2026 12:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="h3MkiWnY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EA6846A3; Sat, 30 May 2026 12:48:18 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B282F80087
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 12:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B40E8111CDA; Sat, 30 May 2026 12:48:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780138095; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=ztJS/6qQvKZOxKd0M8j7jkVbRfQDoSPoE1vaOkZbcLk=;
 b=h3MkiWnYvgqt76GQ/hEI+Q0t4s6ytV+xzza1SNl85iEb0Vu+nl/DKqCCckSAQXsVxcC5/B
 +GhkFfu+l84GOWYWzl36jyR8lBzgr/upwYi5D3sJff7Hb3B0BUJ4AVxzU+yygBA0ThbLNa
 YhFR+lEvLKnoeAbDkdYmkwB3Y//PCvYmHjMSBUklQpLE9vE5kjai1tdU0omiGVuZbQ33Z2
 lVKjtoOdPUKN9dnc1YTrU1TpdfNh5nsGx9588awSge+FxiGHVBNhh4W1DmZ2p6qgNwHdLP
 0NbsTiG1fwrDFfLPddUW+zKMm7m5TI7pZXxFPXJ+DT0vRE/38BaBlGkt7My58w==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Simona Toaca <simona.toaca@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] arm: imx9: Fix broken formatting
Date: Sat, 30 May 2026 12:47:53 +0200
Message-ID: <20260530104812.32822-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Fix ad-hoc tabs and spaces use, convert to tabs. Drop bogus duplicate
asterisk from non-kerneldoc code comments. No functional change.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simona Toaca <simona.toaca@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Viorel Suman <viorel.suman@nxp.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-imx9/ddr.h | 30 ++++++++++++++--------------
 arch/arm/mach-imx/cmd_qb.c           |  2 +-
 arch/arm/mach-imx/imx9/qb.c          | 24 +++++++++++-----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index bba12369f06..b0f90b53f64 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -13,21 +13,21 @@
 #define DDR_PHY_BASE			0x4E100000
 #define DDRMIX_BLK_CTRL_BASE		0x4E010000
 
-#define REG_DDR_SDRAM_MD_CNTL	(DDR_CTL_BASE + 0x120)
-#define REG_DDR_CS0_BNDS        (DDR_CTL_BASE + 0x0)
-#define REG_DDR_CS1_BNDS        (DDR_CTL_BASE + 0x8)
+#define REG_DDR_SDRAM_MD_CNTL		(DDR_CTL_BASE + 0x120)
+#define REG_DDR_CS0_BNDS		(DDR_CTL_BASE + 0x0)
+#define REG_DDR_CS1_BNDS		(DDR_CTL_BASE + 0x8)
 #define REG_DDRDSR_2			(DDR_CTL_BASE + 0xB24)
-#define REG_DDR_TIMING_CFG_0	(DDR_CTL_BASE + 0x104)
+#define REG_DDR_TIMING_CFG_0		(DDR_CTL_BASE + 0x104)
 #define REG_DDR_SDRAM_CFG		(DDR_CTL_BASE + 0x110)
-#define REG_DDR_TIMING_CFG_4	(DDR_CTL_BASE + 0x160)
+#define REG_DDR_TIMING_CFG_4		(DDR_CTL_BASE + 0x160)
 #define REG_DDR_DEBUG_19		(DDR_CTL_BASE + 0xF48)
-#define REG_DDR_SDRAM_CFG_3	(DDR_CTL_BASE + 0x260)
-#define REG_DDR_SDRAM_CFG_4	(DDR_CTL_BASE + 0x264)
-#define REG_DDR_SDRAM_MD_CNTL_2	(DDR_CTL_BASE + 0x270)
-#define REG_DDR_SDRAM_MPR4	(DDR_CTL_BASE + 0x28C)
-#define REG_DDR_SDRAM_MPR5	(DDR_CTL_BASE + 0x290)
+#define REG_DDR_SDRAM_CFG_3		(DDR_CTL_BASE + 0x260)
+#define REG_DDR_SDRAM_CFG_4		(DDR_CTL_BASE + 0x264)
+#define REG_DDR_SDRAM_MD_CNTL_2		(DDR_CTL_BASE + 0x270)
+#define REG_DDR_SDRAM_MPR4		(DDR_CTL_BASE + 0x28C)
+#define REG_DDR_SDRAM_MPR5		(DDR_CTL_BASE + 0x290)
 
-#define REG_DDR_ERR_EN		(DDR_CTL_BASE + 0x1000)
+#define REG_DDR_ERR_EN			(DDR_CTL_BASE + 0x1000)
 
 #define SRC_BASE_ADDR			(0x44460000)
 #define SRC_DPHY_BASE_ADDR		(SRC_BASE_ADDR + 0x1400)
@@ -107,13 +107,13 @@ extern struct dram_timing_info dram_timing;
 #define DDRPHY_QB_PSTATES	0
 #define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)
 
-/**
+/*
  * This structure needs to be aligned with the one in OEI.
  */
 struct ddrphy_qb_state {
-	u32 crc;		  /* Used for ensuring integrity in DRAM */
-#define MAC_LENGTH		8 /* 256 bits, 32-bit aligned */
-	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
+	u32 crc;			/* Used for ensuring integrity in DRAM */
+#define MAC_LENGTH		8	/* 256 bits, 32-bit aligned */
+	u32 mac[MAC_LENGTH];		/* For 95A0/1 use mac[0] to keep CRC32 value */
 	u8 trained_vrefca_a0;
 	u8 trained_vrefca_a1;
 	u8 trained_vrefca_b0;
diff --git a/arch/arm/mach-imx/cmd_qb.c b/arch/arm/mach-imx/cmd_qb.c
index 633d83d3abd..a6b654d342f 100644
--- a/arch/arm/mach-imx/cmd_qb.c
+++ b/arch/arm/mach-imx/cmd_qb.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * Copyright 2024-2026 NXP
  */
 #include <command.h>
diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
index 1a0a12de3d4..ac4d10b5885 100644
--- a/arch/arm/mach-imx/imx9/qb.c
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * Copyright 2024-2026 NXP
  */
 #include <dm/device-internal.h>
@@ -17,15 +17,15 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/sys_proto.h>
 
-#define QB_STATE_LOAD_SIZE    SZ_64K
+#define QB_STATE_LOAD_SIZE		SZ_64K
 
-#define BLK_DEV		0
-#define SPI_DEV		1
+#define BLK_DEV				0
+#define SPI_DEV				1
 
-#define IMG_FLAGS_IMG_TYPE_MASK   0xF
-#define IMG_FLAGS_IMG_TYPE(x)     FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, (x))
+#define IMG_FLAGS_IMG_TYPE_MASK		0xF
+#define IMG_FLAGS_IMG_TYPE(x)		FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, (x))
 
-#define IMG_TYPE_DDR_TDATA_DUMMY  0xD   /* dummy DDR training data image */
+#define IMG_TYPE_DDR_TDATA_DUMMY	0xD /* dummy DDR training data image */
 
 static const struct {
 	const char *ifname;
@@ -33,7 +33,7 @@ static const struct {
 } imx_boot_devs[] = {
 	[BOOT_DEVICE_MMC1] = { "mmc", "0" },
 	[BOOT_DEVICE_MMC2] = { "mmc", "1" },
-	[BOOT_DEVICE_SPI]  = { "spi", "" },
+	[BOOT_DEVICE_SPI] = { "spi", "" },
 };
 
 static int imx_qb_get_board_boot_device(void)
@@ -77,7 +77,7 @@ bool imx_qb_check(void)
 	struct ddrphy_qb_state *qb_state;
 	u32 size, crc;
 
-	/**
+	/*
 	 * Ensure CRC is not empty, the reason is that
 	 * the data is invalidated after first save run
 	 * or after it is overwritten.
@@ -105,7 +105,7 @@ static int imx_qb_get_blk_boot_part(const char * const ifname,
 	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		return blk_get_device_part_str(ifname, dev, bdesc, &info, 1);
 
-	/**
+	/*
 	 * SPL does not have access to part_get_info,
 	 * so get the partition manually. Currently only
 	 * supporting MMC devices.
@@ -364,7 +364,7 @@ int imx_qb(const char *ifname, const char *dev, bool save)
 
 	ret = 0;
 
-	/* Try to use boot device  */
+	/* Try to use boot device */
 	if (!strcmp(ifname, "auto"))
 		ret = imx_qb_get_boot_dev_str(&ifname, &dev);
 
@@ -385,7 +385,7 @@ int imx_qb(const char *ifname, const char *dev, bool save)
 	if (!save)
 		return 0;
 
-	/**
+	/*
 	 * invalidate qb_state mem so that at next boot
 	 * the check function will fail and save won't happen
 	 */
-- 
2.53.0

