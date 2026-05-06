Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B013CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07FA84927;
	Wed,  6 May 2026 14:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fhtr5RS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BABF84933; Wed,  6 May 2026 14:36:25 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE9D8491D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 977C943568;
 Wed,  6 May 2026 12:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82169C2BCB8;
 Wed,  6 May 2026 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070979;
 bh=ZWZ83naK1YwHQZPHMyZbtQKtIdwwOj9v+Q0+vrFIiSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fhtr5RS9KtEr6hPoQLdONlHsZNxmaKukFUegvQJ425Jel3QFGJHxjbgOsra/ji006
 s8eNddYp4MODIWqnOsKMLAMiAea9Ve5a+V7yn+rAhJeSaQT6GrCqP78bAUGiA1klfx
 PK0D6RVXTncnEkcV7qRlcIN5JI7mUolcX2RUibuzOHSa93H9rOhaIcd4fvPFmGDJ6w
 79ongJKAoKs/ByWJEiSgqrtOM2UbQW/GN+n1qYyU7tZLscDeMCuRHUh0pi1ptQrSv7
 fyNd9fMwtpQG35yjlNN4kGZWmiEPoooBoeUPZ2NbefKHauJiD+fTXcvPtyvEe3sEsO
 LNAxy/aE0iY/A==
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
Subject: [PATCH v2 05/11] boards/nxp: remove board_eth_init()
Date: Wed,  6 May 2026 14:34:14 +0200
Message-ID: <20260506123507.2081751-6-mwalle@kernel.org>
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

board_eth_init() is dead code since commit e524f3a449f5 ("net: Remove
eth_legacy.c"). Remove it.

I'm not sure, all the shenanigans are covered by the new DM-version. The
MDIO mux and iomux controls probably are. The fman configuration
probably isn't. OTOH, nobody cared for years and the called
fm_info_set_phy_address() was also removed years ago.

This also removes fdt_fixup_board_enet() for the ls1043a and ls1046a
because it relies on the local variable "mdio_mux" being initialized by
the board_eth_init().

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/nxp/ls1012afrdm/eth.c               |  10 -
 board/nxp/ls1012ardb/eth.c                |  12 -
 board/nxp/ls1021atsn/ls1021atsn.c         |   5 -
 board/nxp/ls1021atwr/ls1021atwr.c         |   5 -
 board/nxp/ls1028a/ls1028a.c               |   5 -
 board/nxp/ls1043aqds/eth.c                | 391 ------------------
 board/nxp/ls1043ardb/Makefile             |   1 -
 board/nxp/ls1043ardb/eth.c                |  77 ----
 board/nxp/ls1046afrwy/eth.c               |  57 ---
 board/nxp/ls1046aqds/eth.c                | 339 ----------------
 board/nxp/ls1046ardb/eth.c                |  71 ----
 board/nxp/ls2080ardb/eth_ls2080rdb.c      |  19 -
 board/nxp/lx2160a/eth_lx2160aqds.c        |  18 -
 board/nxp/lx2160a/eth_lx2160ardb.c        |  17 -
 board/nxp/lx2160a/eth_lx2162aqds.c        |  18 -
 board/nxp/m5253demo/m5253demo.c           |   7 -
 board/nxp/mx6sxsabreauto/mx6sxsabreauto.c |  52 ---
 board/nxp/mx6sxsabresd/mx6sxsabresd.c     |  78 ----
 board/nxp/p2041rdb/Makefile               |   1 -
 board/nxp/p2041rdb/eth.c                  | 141 -------
 board/nxp/t102xrdb/eth_t102xrdb.c         | 103 -----
 board/nxp/t104xrdb/Makefile               |   1 -
 board/nxp/t104xrdb/eth.c                  |  91 -----
 board/nxp/t208xqds/eth_t208xqds.c         | 460 ----------------------
 board/nxp/t4rdb/eth.c                     | 115 ------
 25 files changed, 2094 deletions(-)
 delete mode 100644 board/nxp/ls1043ardb/eth.c
 delete mode 100644 board/nxp/p2041rdb/eth.c
 delete mode 100644 board/nxp/t104xrdb/eth.c

diff --git a/board/nxp/ls1012afrdm/eth.c b/board/nxp/ls1012afrdm/eth.c
index c431e5e611b..8761ec7845e 100644
--- a/board/nxp/ls1012afrdm/eth.c
+++ b/board/nxp/ls1012afrdm/eth.c
@@ -7,16 +7,6 @@
 #include <dm.h>
 #include <net.h>
 #include <asm/io.h>
-#include <netdev.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-#include <asm/types.h>
-#include <fsl_dtsec.h>
-#include <asm/arch/soc.h>
-#include <asm/arch-fsl-layerscape/config.h>
-#include <asm/arch-fsl-layerscape/immap_lsch2.h>
-#include <asm/arch/fsl_serdes.h>
 #include <linux/delay.h>
 #include <net/pfe_eth/pfe_eth.h>
 #include <dm/platform_data/pfe_dm_eth.h>
diff --git a/board/nxp/ls1012ardb/eth.c b/board/nxp/ls1012ardb/eth.c
index 71cb2988a56..6a6f4608fd1 100644
--- a/board/nxp/ls1012ardb/eth.c
+++ b/board/nxp/ls1012ardb/eth.c
@@ -6,18 +6,6 @@
 
 #include <config.h>
 #include <dm.h>
-#include <net.h>
-#include <asm/io.h>
-#include <netdev.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-#include <asm/types.h>
-#include <fsl_dtsec.h>
-#include <asm/arch/soc.h>
-#include <asm/arch-fsl-layerscape/config.h>
-#include <asm/arch-fsl-layerscape/immap_lsch2.h>
-#include <asm/arch/fsl_serdes.h>
 #include <linux/delay.h>
 #include <net/pfe_eth/pfe_eth.h>
 #include <dm/platform_data/pfe_dm_eth.h>
diff --git a/board/nxp/ls1021atsn/ls1021atsn.c b/board/nxp/ls1021atsn/ls1021atsn.c
index c92430c0896..277506fdbb8 100644
--- a/board/nxp/ls1021atsn/ls1021atsn.c
+++ b/board/nxp/ls1021atsn/ls1021atsn.c
@@ -123,11 +123,6 @@ int dram_init(void)
 	return 0;
 }
 
-int board_eth_init(struct bd_info *bis)
-{
-	return pci_eth_init(bis);
-}
-
 int board_early_init_f(void)
 {
 	struct ccsr_scfg *scfg = (struct ccsr_scfg *)CFG_SYS_FSL_SCFG_ADDR;
diff --git a/board/nxp/ls1021atwr/ls1021atwr.c b/board/nxp/ls1021atwr/ls1021atwr.c
index 0758e5eae25..135497f7c5d 100644
--- a/board/nxp/ls1021atwr/ls1021atwr.c
+++ b/board/nxp/ls1021atwr/ls1021atwr.c
@@ -239,11 +239,6 @@ int dram_init(void)
 	return 0;
 }
 
-int board_eth_init(struct bd_info *bis)
-{
-	return pci_eth_init(bis);
-}
-
 #if !defined(CONFIG_QSPI_BOOT) && !defined(CONFIG_SD_BOOT_QSPI)
 static void convert_serdes_mux(int type, int need_reset)
 {
diff --git a/board/nxp/ls1028a/ls1028a.c b/board/nxp/ls1028a/ls1028a.c
index db94d9c1fa8..007125358bd 100644
--- a/board/nxp/ls1028a/ls1028a.c
+++ b/board/nxp/ls1028a/ls1028a.c
@@ -103,11 +103,6 @@ int board_init(void)
 	return 0;
 }
 
-int board_eth_init(struct bd_info *bis)
-{
-	return pci_eth_init(bis);
-}
-
 #ifdef CONFIG_MISC_INIT_R
 int misc_init_r(void)
 {
diff --git a/board/nxp/ls1043aqds/eth.c b/board/nxp/ls1043aqds/eth.c
index 5680fd2d377..d62cf74732c 100644
--- a/board/nxp/ls1043aqds/eth.c
+++ b/board/nxp/ls1043aqds/eth.c
@@ -4,399 +4,8 @@
  * Copyright 2019 NXP
  */
 
-#include <config.h>
-#include <log.h>
-#include <net.h>
-#include <asm/io.h>
-#include <netdev.h>
 #include <fdt_support.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <fsl_dtsec.h>
-#include <linux/libfdt.h>
-#include <malloc.h>
-#include <asm/arch/fsl_serdes.h>
-
-#include "../common/qixis.h"
-#include "../common/fman.h"
-#include "ls1043aqds_qixis.h"
-
-#define EMI_NONE	0xFF
-#define EMI1_RGMII1	0
-#define EMI1_RGMII2	1
-#define EMI1_SLOT1	2
-#define EMI1_SLOT2	3
-#define EMI1_SLOT3	4
-#define EMI1_SLOT4	5
-#define EMI2		6
-
-static const char * const mdio_names[] = {
-	"LS1043AQDS_MDIO_RGMII1",
-	"LS1043AQDS_MDIO_RGMII2",
-	"LS1043AQDS_MDIO_SLOT1",
-	"LS1043AQDS_MDIO_SLOT2",
-	"LS1043AQDS_MDIO_SLOT3",
-	"LS1043AQDS_MDIO_SLOT4",
-	"NULL",
-};
-
-/* Map SerDes1 4 lanes to default slot, will be initialized dynamically */
-#ifdef CONFIG_FMAN_ENET
-static int mdio_mux[NUM_FM_PORTS];
-
-static u8 lane_to_slot[] = {1, 2, 3, 4};
-#endif
-
-static const char *ls1043aqds_mdio_name_for_muxval(u8 muxval)
-{
-	return mdio_names[muxval];
-}
-
-struct mii_dev *mii_dev_for_muxval(u8 muxval)
-{
-	struct mii_dev *bus;
-	const char *name;
-
-	if (muxval > EMI2)
-		return NULL;
-
-	name = ls1043aqds_mdio_name_for_muxval(muxval);
-
-	if (!name) {
-		printf("No bus for muxval %x\n", muxval);
-		return NULL;
-	}
-
-	bus = miiphy_get_dev_by_name(name);
-
-	if (!bus) {
-		printf("No bus by name %s\n", name);
-		return NULL;
-	}
-
-	return bus;
-}
-
-#ifdef CONFIG_FMAN_ENET
-struct ls1043aqds_mdio {
-	u8 muxval;
-	struct mii_dev *realbus;
-};
-
-static void ls1043aqds_mux_mdio(u8 muxval)
-{
-	u8 brdcfg4;
-
-	if (muxval < 7) {
-		brdcfg4 = QIXIS_READ(brdcfg[4]);
-		brdcfg4 &= ~BRDCFG4_EMISEL_MASK;
-		brdcfg4 |= (muxval << BRDCFG4_EMISEL_SHIFT);
-		QIXIS_WRITE(brdcfg[4], brdcfg4);
-	}
-}
-
-static int ls1043aqds_mdio_read(struct mii_dev *bus, int addr, int devad,
-			      int regnum)
-{
-	struct ls1043aqds_mdio *priv = bus->priv;
-
-	ls1043aqds_mux_mdio(priv->muxval);
-
-	return priv->realbus->read(priv->realbus, addr, devad, regnum);
-}
-
-static int ls1043aqds_mdio_write(struct mii_dev *bus, int addr, int devad,
-			       int regnum, u16 value)
-{
-	struct ls1043aqds_mdio *priv = bus->priv;
-
-	ls1043aqds_mux_mdio(priv->muxval);
-
-	return priv->realbus->write(priv->realbus, addr, devad,
-				    regnum, value);
-}
-
-static int ls1043aqds_mdio_reset(struct mii_dev *bus)
-{
-	struct ls1043aqds_mdio *priv = bus->priv;
-
-	return priv->realbus->reset(priv->realbus);
-}
-
-static int ls1043aqds_mdio_init(char *realbusname, u8 muxval)
-{
-	struct ls1043aqds_mdio *pmdio;
-	struct mii_dev *bus = mdio_alloc();
-
-	if (!bus) {
-		printf("Failed to allocate ls1043aqds MDIO bus\n");
-		return -1;
-	}
-
-	pmdio = malloc(sizeof(*pmdio));
-	if (!pmdio) {
-		printf("Failed to allocate ls1043aqds private data\n");
-		free(bus);
-		return -1;
-	}
-
-	bus->read = ls1043aqds_mdio_read;
-	bus->write = ls1043aqds_mdio_write;
-	bus->reset = ls1043aqds_mdio_reset;
-	strcpy(bus->name, ls1043aqds_mdio_name_for_muxval(muxval));
-
-	pmdio->realbus = miiphy_get_dev_by_name(realbusname);
-
-	if (!pmdio->realbus) {
-		printf("No bus with name %s\n", realbusname);
-		free(bus);
-		free(pmdio);
-		return -1;
-	}
-
-	pmdio->muxval = muxval;
-	bus->priv = pmdio;
-	return mdio_register(bus);
-}
 
 void fdt_fixup_board_enet(void *fdt)
 {
-	int i;
-	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-	u32 srds_s1;
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
-	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	for (i = FM1_DTSEC1; i < NUM_FM_PORTS; i++) {
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_QSGMII:
-			switch (mdio_mux[i]) {
-			case EMI1_SLOT1:
-				fdt_status_okay_by_alias(fdt, "emi1-slot1");
-				break;
-			case EMI1_SLOT2:
-				fdt_status_okay_by_alias(fdt, "emi1-slot2");
-				break;
-			case EMI1_SLOT3:
-				fdt_status_okay_by_alias(fdt, "emi1-slot3");
-				break;
-			case EMI1_SLOT4:
-				fdt_status_okay_by_alias(fdt, "emi1-slot4");
-				break;
-			default:
-				break;
-			}
-			break;
-		case PHY_INTERFACE_MODE_XGMII:
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-int board_eth_init(struct bd_info *bis)
-{
-	int i, idx, lane, slot, interface;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct memac_mdio_info tgec_mdio_info;
-	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-	u32 srds_s1;
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
-	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	/* Initialize the mdio_mux array so we can recognize empty elements */
-	for (i = 0; i < NUM_FM_PORTS; i++)
-		mdio_mux[i] = EMI_NONE;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the 10G MDIO bus */
-	fm_memac_mdio_init(bis, &tgec_mdio_info);
-
-	/* Register the muxing front-ends to the MDIO buses */
-	ls1043aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_RGMII1);
-	ls1043aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_RGMII2);
-	ls1043aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT1);
-	ls1043aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT2);
-	ls1043aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT3);
-	ls1043aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT4);
-	ls1043aqds_mdio_init(DEFAULT_FM_TGEC_MDIO_NAME, EMI2);
-
-	/* Set the two on-board RGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
-
-	switch (srds_s1) {
-	case 0x2555:
-		/* 2.5G SGMII on lane A, MAC 9 */
-		fm_info_set_phy_address(FM1_DTSEC9, 9);
-		break;
-	case 0x4555:
-	case 0x4558:
-		/* QSGMII on lane A, MAC 1/2/5/6 */
-		fm_info_set_phy_address(FM1_DTSEC1,
-					QSGMII_CARD_PORT1_PHY_ADDR_S1);
-		fm_info_set_phy_address(FM1_DTSEC2,
-					QSGMII_CARD_PORT2_PHY_ADDR_S1);
-		fm_info_set_phy_address(FM1_DTSEC5,
-					QSGMII_CARD_PORT3_PHY_ADDR_S1);
-		fm_info_set_phy_address(FM1_DTSEC6,
-					QSGMII_CARD_PORT4_PHY_ADDR_S1);
-		break;
-	case 0x1355:
-		/* SGMII on lane B, MAC 2*/
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT1_PHY_ADDR);
-		break;
-	case 0x2355:
-		/* 2.5G SGMII on lane A, MAC 9 */
-		fm_info_set_phy_address(FM1_DTSEC9, 9);
-		/* SGMII on lane B, MAC 2*/
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT1_PHY_ADDR);
-		break;
-	case 0x3335:
-		/* SGMII on lane C, MAC 5 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT1_PHY_ADDR);
-	case 0x3355:
-	case 0x3358:
-		/* SGMII on lane B, MAC 2 */
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT1_PHY_ADDR);
-	case 0x3555:
-	case 0x3558:
-		/* SGMII on lane A, MAC 9 */
-		fm_info_set_phy_address(FM1_DTSEC9, SGMII_CARD_PORT1_PHY_ADDR);
-		break;
-	case 0x1455:
-		/* QSGMII on lane B, MAC 1/2/5/6 */
-		fm_info_set_phy_address(FM1_DTSEC1,
-					QSGMII_CARD_PORT1_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC2,
-					QSGMII_CARD_PORT2_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC5,
-					QSGMII_CARD_PORT3_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC6,
-					QSGMII_CARD_PORT4_PHY_ADDR_S2);
-		break;
-	case 0x2455:
-		/* 2.5G SGMII on lane A, MAC 9 */
-		fm_info_set_phy_address(FM1_DTSEC9, 9);
-		/* QSGMII on lane B, MAC 1/2/5/6 */
-		fm_info_set_phy_address(FM1_DTSEC1,
-					QSGMII_CARD_PORT1_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC2,
-					QSGMII_CARD_PORT2_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC5,
-					QSGMII_CARD_PORT3_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC6,
-					QSGMII_CARD_PORT4_PHY_ADDR_S2);
-		break;
-	case 0x2255:
-		/* 2.5G SGMII on lane A, MAC 9 */
-		fm_info_set_phy_address(FM1_DTSEC9, 9);
-		/* 2.5G SGMII on lane B, MAC 2 */
-		fm_info_set_phy_address(FM1_DTSEC2, 2);
-		break;
-	case 0x3333:
-		/* SGMII on lane A/B/C/D, MAC 9/2/5/6 */
-		fm_info_set_phy_address(FM1_DTSEC9,
-					SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2,
-					SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC5,
-					SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6,
-					SGMII_CARD_PORT1_PHY_ADDR);
-		break;
-	default:
-		printf("Invalid SerDes protocol 0x%x for LS1043AQDS\n",
-		       srds_s1);
-		break;
-	}
-
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		idx = i - FM1_DTSEC1;
-		interface = fm_info_get_enet_if(i);
-		switch (interface) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_2500BASEX:
-		case PHY_INTERFACE_MODE_QSGMII:
-			if (interface == PHY_INTERFACE_MODE_SGMII) {
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						SGMII_FM1_DTSEC1 + idx);
-			} else if (interface == PHY_INTERFACE_MODE_2500BASEX) {
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						SGMII_2500_FM1_DTSEC1 + idx);
-			} else {
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						QSGMII_FM1_A);
-			}
-
-			if (lane < 0)
-				break;
-
-			slot = lane_to_slot[lane];
-			debug("FM1@DTSEC%u expects SGMII in slot %u\n",
-			      idx + 1, slot);
-			if (QIXIS_READ(present2) & (1 << (slot - 1)))
-				fm_disable_port(i);
-
-			switch (slot) {
-			case 1:
-				mdio_mux[i] = EMI1_SLOT1;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 2:
-				mdio_mux[i] = EMI1_SLOT2;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 3:
-				mdio_mux[i] = EMI1_SLOT3;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 4:
-				mdio_mux[i] = EMI1_SLOT4;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			default:
-				break;
-			}
-			break;
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			if (i == FM1_DTSEC3)
-				mdio_mux[i] = EMI1_RGMII1;
-			else if (i == FM1_DTSEC4)
-				mdio_mux[i] = EMI1_RGMII2;
-			fm_info_set_mdio(i, mii_dev_for_muxval(mdio_mux[i]));
-			break;
-		default:
-			break;
-		}
-	}
-
-	cpu_eth_init(bis);
-
-	return pci_eth_init(bis);
 }
-#endif /* CONFIG_FMAN_ENET */
diff --git a/board/nxp/ls1043ardb/Makefile b/board/nxp/ls1043ardb/Makefile
index 95745bf3a9c..13e0411c1ba 100644
--- a/board/nxp/ls1043ardb/Makefile
+++ b/board/nxp/ls1043ardb/Makefile
@@ -5,6 +5,5 @@
 obj-y += ddr.o
 obj-y += ls1043ardb.o
 ifndef CONFIG_XPL_BUILD
-obj-$(CONFIG_NET) += eth.o
 obj-y += cpld.o
 endif
diff --git a/board/nxp/ls1043ardb/eth.c b/board/nxp/ls1043ardb/eth.c
deleted file mode 100644
index cacc49c0584..00000000000
--- a/board/nxp/ls1043ardb/eth.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2015 Freescale Semiconductor, Inc.
- */
-#include <config.h>
-#include <net.h>
-#include <asm/io.h>
-#include <netdev.h>
-#include <fm_eth.h>
-#include <fsl_dtsec.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-
-#include "../common/fman.h"
-
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_FMAN_ENET
-	int i;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct memac_mdio_info tgec_mdio_info;
-	struct mii_dev *dev;
-	u32 srds_s1;
-	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
-	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the 10G MDIO bus */
-	fm_memac_mdio_init(bis, &tgec_mdio_info);
-
-	/* Set the two on-board RGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
-
-	/* QSGMII on lane B, MAC 1/2/5/6 */
-	fm_info_set_phy_address(FM1_DTSEC1, QSGMII_PORT1_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC2, QSGMII_PORT2_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC5, QSGMII_PORT3_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC6, QSGMII_PORT4_PHY_ADDR);
-
-	switch (srds_s1) {
-	case 0x1455:
-		break;
-	default:
-		printf("Invalid SerDes protocol 0x%x for LS1043ARDB\n",
-		       srds_s1);
-		break;
-	}
-
-	dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++)
-		fm_info_set_mdio(i, dev);
-
-	/* 10GBase-R on lane A, MAC 9 */
-	fm_info_set_phy_address(FM1_10GEC1, FM1_10GEC1_PHY_ADDR);
-	dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-	fm_info_set_mdio(FM1_10GEC1, dev);
-
-	cpu_eth_init(bis);
-#endif
-
-	return pci_eth_init(bis);
-}
diff --git a/board/nxp/ls1046afrwy/eth.c b/board/nxp/ls1046afrwy/eth.c
index 8efc7f68424..d76841c6ab4 100644
--- a/board/nxp/ls1046afrwy/eth.c
+++ b/board/nxp/ls1046afrwy/eth.c
@@ -4,64 +4,7 @@
  */
 #include <config.h>
 #include <fdt_support.h>
-#include <net.h>
 #include <asm/io.h>
-#include <netdev.h>
-#include <fm_eth.h>
-#include <fsl_dtsec.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-
-#include "../common/fman.h"
-
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_FMAN_ENET
-	struct memac_mdio_info dtsec_mdio_info;
-	struct mii_dev *dev;
-	u32 srds_s1;
-	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
-	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	/* QSGMII on lane B, MAC 6/5/10/1 */
-	fm_info_set_phy_address(FM1_DTSEC6, QSGMII_PORT1_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC5, QSGMII_PORT2_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC10, QSGMII_PORT3_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC1, QSGMII_PORT4_PHY_ADDR);
-
-	switch (srds_s1) {
-	case 0x3040:
-		break;
-	default:
-		printf("Invalid SerDes protocol 0x%x for LS1046AFRWY\n",
-		       srds_s1);
-		break;
-	}
-
-	dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-	fm_info_set_mdio(FM1_DTSEC6, dev);
-	fm_info_set_mdio(FM1_DTSEC5, dev);
-	fm_info_set_mdio(FM1_DTSEC10, dev);
-	fm_info_set_mdio(FM1_DTSEC1, dev);
-
-	fm_disable_port(FM1_DTSEC9);
-
-	cpu_eth_init(bis);
-#endif
-
-	return pci_eth_init(bis);
-}
 
 #ifdef CONFIG_FMAN_ENET
 int fdt_update_ethernet_dt(void *blob)
diff --git a/board/nxp/ls1046aqds/eth.c b/board/nxp/ls1046aqds/eth.c
index 8446f438d3c..24e6c93aece 100644
--- a/board/nxp/ls1046aqds/eth.c
+++ b/board/nxp/ls1046aqds/eth.c
@@ -4,347 +4,8 @@
  * Copyright 2018-2020 NXP
  */
 
-#include <config.h>
-#include <log.h>
-#include <net.h>
-#include <asm/io.h>
-#include <netdev.h>
 #include <fdt_support.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <fsl_dtsec.h>
-#include <malloc.h>
-#include <asm/arch/fsl_serdes.h>
-
-#include "../common/qixis.h"
-#include "../common/fman.h"
-#include "ls1046aqds_qixis.h"
-
-#define EMI_NONE	0xFF
-#define EMI1_RGMII1	0
-#define EMI1_RGMII2	1
-#define EMI1_SLOT1	2
-#define EMI1_SLOT2	3
-#define EMI1_SLOT4	4
-
-static const char * const mdio_names[] = {
-	"LS1046AQDS_MDIO_RGMII1",
-	"LS1046AQDS_MDIO_RGMII2",
-	"LS1046AQDS_MDIO_SLOT1",
-	"LS1046AQDS_MDIO_SLOT2",
-	"LS1046AQDS_MDIO_SLOT4",
-	"NULL",
-};
-
-/* Map SerDes 1 & 2 lanes to default slot. */
-#ifdef CONFIG_FMAN_ENET
-static int mdio_mux[NUM_FM_PORTS];
-
-static u8 lane_to_slot[] = {1, 1, 1, 1, 0, 4, 0 , 0};
-#endif
-
-static const char *ls1046aqds_mdio_name_for_muxval(u8 muxval)
-{
-	return mdio_names[muxval];
-}
-
-struct mii_dev *mii_dev_for_muxval(u8 muxval)
-{
-	struct mii_dev *bus;
-	const char *name;
-
-	if (muxval > EMI1_SLOT4)
-		return NULL;
-
-	name = ls1046aqds_mdio_name_for_muxval(muxval);
-
-	if (!name) {
-		printf("No bus for muxval %x\n", muxval);
-		return NULL;
-	}
-
-	bus = miiphy_get_dev_by_name(name);
-
-	if (!bus) {
-		printf("No bus by name %s\n", name);
-		return NULL;
-	}
-
-	return bus;
-}
-
-#ifdef CONFIG_FMAN_ENET
-struct ls1046aqds_mdio {
-	u8 muxval;
-	struct mii_dev *realbus;
-};
-
-static void ls1046aqds_mux_mdio(u8 muxval)
-{
-	u8 brdcfg4;
-
-	if (muxval < 7) {
-		brdcfg4 = QIXIS_READ(brdcfg[4]);
-		brdcfg4 &= ~BRDCFG4_EMISEL_MASK;
-		brdcfg4 |= (muxval << BRDCFG4_EMISEL_SHIFT);
-		QIXIS_WRITE(brdcfg[4], brdcfg4);
-	}
-}
-
-static int ls1046aqds_mdio_read(struct mii_dev *bus, int addr, int devad,
-			      int regnum)
-{
-	struct ls1046aqds_mdio *priv = bus->priv;
-
-	ls1046aqds_mux_mdio(priv->muxval);
-
-	return priv->realbus->read(priv->realbus, addr, devad, regnum);
-}
-
-static int ls1046aqds_mdio_write(struct mii_dev *bus, int addr, int devad,
-			       int regnum, u16 value)
-{
-	struct ls1046aqds_mdio *priv = bus->priv;
-
-	ls1046aqds_mux_mdio(priv->muxval);
-
-	return priv->realbus->write(priv->realbus, addr, devad,
-				    regnum, value);
-}
-
-static int ls1046aqds_mdio_reset(struct mii_dev *bus)
-{
-	struct ls1046aqds_mdio *priv = bus->priv;
-
-	return priv->realbus->reset(priv->realbus);
-}
-
-static int ls1046aqds_mdio_init(char *realbusname, u8 muxval)
-{
-	struct ls1046aqds_mdio *pmdio;
-	struct mii_dev *bus = mdio_alloc();
-
-	if (!bus) {
-		printf("Failed to allocate ls1046aqds MDIO bus\n");
-		return -1;
-	}
-
-	pmdio = malloc(sizeof(*pmdio));
-	if (!pmdio) {
-		printf("Failed to allocate ls1046aqds private data\n");
-		free(bus);
-		return -1;
-	}
-
-	bus->read = ls1046aqds_mdio_read;
-	bus->write = ls1046aqds_mdio_write;
-	bus->reset = ls1046aqds_mdio_reset;
-	sprintf(bus->name, ls1046aqds_mdio_name_for_muxval(muxval));
-
-	pmdio->realbus = miiphy_get_dev_by_name(realbusname);
-
-	if (!pmdio->realbus) {
-		printf("No bus with name %s\n", realbusname);
-		free(bus);
-		free(pmdio);
-		return -1;
-	}
-
-	pmdio->muxval = muxval;
-	bus->priv = pmdio;
-	return mdio_register(bus);
-}
 
 void fdt_fixup_board_enet(void *fdt)
 {
-	int i;
-
-	for (i = FM1_DTSEC1; i < NUM_FM_PORTS; i++) {
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_QSGMII:
-			switch (mdio_mux[i]) {
-			case EMI1_SLOT1:
-				fdt_status_okay_by_alias(fdt, "emi1-slot1");
-				break;
-			case EMI1_SLOT2:
-				fdt_status_okay_by_alias(fdt, "emi1-slot2");
-				break;
-			case EMI1_SLOT4:
-				fdt_status_okay_by_alias(fdt, "emi1-slot4");
-				break;
-			default:
-				break;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-int board_eth_init(struct bd_info *bis)
-{
-	int i, idx, lane, slot, interface;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-	u32 srds_s1, srds_s2;
-	u8 brdcfg12;
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
-	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	srds_s2 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS2_PRTCL_MASK;
-	srds_s2 >>= FSL_CHASSIS2_RCWSR4_SRDS2_PRTCL_SHIFT;
-
-	/* Initialize the mdio_mux array so we can recognize empty elements */
-	for (i = 0; i < NUM_FM_PORTS; i++)
-		mdio_mux[i] = EMI_NONE;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	/* Register the muxing front-ends to the MDIO buses */
-	ls1046aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_RGMII1);
-	ls1046aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_RGMII2);
-	ls1046aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT1);
-	ls1046aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT2);
-	ls1046aqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT4);
-
-	/* Set the two on-board RGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
-
-	switch (srds_s1) {
-	case 0x3333:
-		/* SGMII on slot 1, MAC 9 */
-		fm_info_set_phy_address(FM1_DTSEC9, SGMII_CARD_PORT1_PHY_ADDR);
-	case 0x1333:
-	case 0x2333:
-		/* SGMII on slot 1, MAC 10 */
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT2_PHY_ADDR);
-	case 0x1133:
-	case 0x2233:
-		/* SGMII on slot 1, MAC 5/6 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-	case 0x1040:
-	case 0x2040:
-		/* QSGMII on lane B, MAC 6/5/10/1 */
-		fm_info_set_phy_address(FM1_DTSEC6,
-					QSGMII_CARD_PORT1_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC5,
-					QSGMII_CARD_PORT2_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC10,
-					QSGMII_CARD_PORT3_PHY_ADDR_S2);
-		fm_info_set_phy_address(FM1_DTSEC1,
-					QSGMII_CARD_PORT4_PHY_ADDR_S2);
-		break;
-	case 0x3363:
-		/* SGMII on slot 1, MAC 9/10 */
-		fm_info_set_phy_address(FM1_DTSEC9, SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT2_PHY_ADDR);
-	case 0x1163:
-	case 0x2263:
-	case 0x2223:
-		/* SGMII on slot 1, MAC 6 */
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-	default:
-		printf("Invalid SerDes protocol 0x%x for LS1046AQDS\n",
-		       srds_s1);
-		break;
-	}
-
-	if (srds_s2 == 0x5a59 || srds_s2 == 0x5a06)
-		/* SGMII on slot 4, MAC 2 */
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT1_PHY_ADDR);
-
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		idx = i - FM1_DTSEC1;
-		interface = fm_info_get_enet_if(i);
-		switch (interface) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_QSGMII:
-			if (interface == PHY_INTERFACE_MODE_SGMII) {
-				if (i == FM1_DTSEC5) {
-					/* route lane 2 to slot1 so to have
-					 * one sgmii riser card supports
-					 * MAC5 and MAC6.
-					 */
-					brdcfg12 = QIXIS_READ(brdcfg[12]);
-					QIXIS_WRITE(brdcfg[12],
-						    brdcfg12 | 0x80);
-				}
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						SGMII_FM1_DTSEC1 + idx);
-			} else {
-				/* clear the bit 7 to route lane B on slot2. */
-				brdcfg12 = QIXIS_READ(brdcfg[12]);
-				QIXIS_WRITE(brdcfg[12], brdcfg12 & 0x7f);
-
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						QSGMII_FM1_A);
-				lane_to_slot[lane] = 2;
-			}
-
-			if (i == FM1_DTSEC2)
-				lane = 5;
-
-			if (lane < 0)
-				break;
-
-			slot = lane_to_slot[lane];
-			debug("FM1@DTSEC%u expects SGMII in slot %u\n",
-			      idx + 1, slot);
-			if (QIXIS_READ(present2) & (1 << (slot - 1)))
-				fm_disable_port(i);
-
-			switch (slot) {
-			case 1:
-				mdio_mux[i] = EMI1_SLOT1;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 2:
-				mdio_mux[i] = EMI1_SLOT2;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 4:
-				mdio_mux[i] = EMI1_SLOT4;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			default:
-				break;
-			}
-			break;
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			if (i == FM1_DTSEC3)
-				mdio_mux[i] = EMI1_RGMII1;
-			else if (i == FM1_DTSEC4)
-				mdio_mux[i] = EMI1_RGMII2;
-			fm_info_set_mdio(i, mii_dev_for_muxval(mdio_mux[i]));
-			break;
-		default:
-			break;
-		}
-	}
-
-	cpu_eth_init(bis);
-
-	return pci_eth_init(bis);
 }
-#endif /* CONFIG_FMAN_ENET */
diff --git a/board/nxp/ls1046ardb/eth.c b/board/nxp/ls1046ardb/eth.c
index fee8e0e21d4..ce9b7b81e3d 100644
--- a/board/nxp/ls1046ardb/eth.c
+++ b/board/nxp/ls1046ardb/eth.c
@@ -4,78 +4,7 @@
  */
 #include <config.h>
 #include <fdt_support.h>
-#include <net.h>
 #include <asm/io.h>
-#include <netdev.h>
-#include <fm_eth.h>
-#include <fsl_dtsec.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-
-#include "../common/fman.h"
-
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_FMAN_ENET
-	int i;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct memac_mdio_info tgec_mdio_info;
-	struct mii_dev *dev;
-	u32 srds_s1;
-	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-			FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_MASK;
-	srds_s1 >>= FSL_CHASSIS2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the 10G MDIO bus */
-	fm_memac_mdio_init(bis, &tgec_mdio_info);
-
-	/* Set the two on-board RGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
-
-	/* Set the two on-board SGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC5, SGMII_PHY1_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC6, SGMII_PHY2_ADDR);
-
-	/* Set the on-board AQ PHY address */
-	fm_info_set_phy_address(FM1_10GEC1, FM1_10GEC1_PHY_ADDR);
-
-	switch (srds_s1) {
-	case 0x1133:
-		break;
-	default:
-		printf("Invalid SerDes protocol 0x%x for LS1046ARDB\n",
-		       srds_s1);
-		break;
-	}
-
-	dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++)
-		fm_info_set_mdio(i, dev);
-
-	/* 10GBase-R on lane A, MAC 9 */
-	dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-	fm_info_set_mdio(FM1_10GEC1, dev);
-
-	cpu_eth_init(bis);
-#endif
-
-	return pci_eth_init(bis);
-}
 
 #ifdef CONFIG_FMAN_ENET
 int fdt_update_ethernet_dt(void *blob)
diff --git a/board/nxp/ls2080ardb/eth_ls2080rdb.c b/board/nxp/ls2080ardb/eth_ls2080rdb.c
index 7d5beb32417..6a8859fd0c5 100644
--- a/board/nxp/ls2080ardb/eth_ls2080rdb.c
+++ b/board/nxp/ls2080ardb/eth_ls2080rdb.c
@@ -9,25 +9,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int board_eth_init(struct bd_info *bis)
-{
-
-#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_XPL_BUILD)
-	/*
-	 * Export functions to be used by AQ firmware
-	 * upload application
-	 */
-	gd->jt->strcpy = strcpy;
-	gd->jt->mdelay = mdelay;
-	gd->jt->mdio_get_current_dev = mdio_get_current_dev;
-	gd->jt->phy_find_by_mask = phy_find_by_mask;
-	gd->jt->mdio_phydev_for_ethname = mdio_phydev_for_ethname;
-	gd->jt->miiphy_set_current_dev = miiphy_set_current_dev;
-#endif
-
-	return 0;
-}
-
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
diff --git a/board/nxp/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
index 9939bb6f89e..4c16f565b69 100644
--- a/board/nxp/lx2160a/eth_lx2160aqds.c
+++ b/board/nxp/lx2160a/eth_lx2160aqds.c
@@ -11,24 +11,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_PHY_AQUANTIA
-	/*
-	 * Export functions to be used by AQ firmware
-	 * upload application
-	 */
-	gd->jt->strcpy = strcpy;
-	gd->jt->mdelay = mdelay;
-	gd->jt->mdio_get_current_dev = mdio_get_current_dev;
-	gd->jt->phy_find_by_mask = phy_find_by_mask;
-	gd->jt->mdio_phydev_for_ethname = mdio_phydev_for_ethname;
-	gd->jt->miiphy_set_current_dev = miiphy_set_current_dev;
-#endif
-
-	return 0;
-}
-
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
diff --git a/board/nxp/lx2160a/eth_lx2160ardb.c b/board/nxp/lx2160a/eth_lx2160ardb.c
index 90e7c9100e1..31bbac6310e 100644
--- a/board/nxp/lx2160a/eth_lx2160ardb.c
+++ b/board/nxp/lx2160a/eth_lx2160ardb.c
@@ -11,23 +11,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_PHY_AQUANTIA
-	/*
-	 * Export functions to be used by AQ firmware
-	 * upload application
-	 */
-	gd->jt->strcpy = strcpy;
-	gd->jt->mdelay = mdelay;
-	gd->jt->mdio_get_current_dev = mdio_get_current_dev;
-	gd->jt->phy_find_by_mask = phy_find_by_mask;
-	gd->jt->mdio_phydev_for_ethname = mdio_phydev_for_ethname;
-	gd->jt->miiphy_set_current_dev = miiphy_set_current_dev;
-#endif
-	return pci_eth_init(bis);
-}
-
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
diff --git a/board/nxp/lx2160a/eth_lx2162aqds.c b/board/nxp/lx2160a/eth_lx2162aqds.c
index 805aa705be9..81b81d47978 100644
--- a/board/nxp/lx2160a/eth_lx2162aqds.c
+++ b/board/nxp/lx2160a/eth_lx2162aqds.c
@@ -11,24 +11,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_PHY_AQUANTIA
-	/*
-	 * Export functions to be used by AQ firmware
-	 * upload application
-	 */
-	gd->jt->strcpy = strcpy;
-	gd->jt->mdelay = mdelay;
-	gd->jt->mdio_get_current_dev = mdio_get_current_dev;
-	gd->jt->phy_find_by_mask = phy_find_by_mask;
-	gd->jt->mdio_phydev_for_ethname = mdio_phydev_for_ethname;
-	gd->jt->miiphy_set_current_dev = miiphy_set_current_dev;
-#endif
-
-	return 0;
-}
-
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
diff --git a/board/nxp/m5253demo/m5253demo.c b/board/nxp/m5253demo/m5253demo.c
index 50c5320b55c..7d4b60b283e 100644
--- a/board/nxp/m5253demo/m5253demo.c
+++ b/board/nxp/m5253demo/m5253demo.c
@@ -133,10 +133,3 @@ void ide_set_reset(int idereset)
 	}
 }
 #endif				/* CONFIG_IDE */
-
-#ifdef CONFIG_DRIVER_DM9000
-int board_eth_init(struct bd_info *bis)
-{
-	return dm9000_initialize(bis);
-}
-#endif
diff --git a/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c b/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
index ac91da3f4f6..036deb464b5 100644
--- a/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
+++ b/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
@@ -33,16 +33,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define ENET_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_PUE |     \
-	PAD_CTL_SPEED_HIGH   |                                   \
-	PAD_CTL_DSE_48ohm   | PAD_CTL_SRE_FAST)
-
-#define ENET_CLK_PAD_CTRL  (PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_120ohm   | PAD_CTL_SRE_FAST)
-
-#define ENET_RX_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |          \
-	PAD_CTL_SPEED_HIGH   | PAD_CTL_SRE_FAST)
-
 #define GPMI_PAD_CTRL0 (PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_UP)
 #define GPMI_PAD_CTRL1 (PAD_CTL_DSE_40ohm | PAD_CTL_SPEED_MED | \
 			PAD_CTL_SRE_FAST)
@@ -55,48 +45,6 @@ int dram_init(void)
 	return 0;
 }
 
-static iomux_v3_cfg_t const fec2_pads[] = {
-	MX6_PAD_ENET1_MDC__ENET2_MDC | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_ENET1_MDIO__ENET2_MDIO | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII2_RX_CTL__ENET2_RX_EN | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII2_RD0__ENET2_RX_DATA_0 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII2_RD1__ENET2_RX_DATA_1 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII2_RD2__ENET2_RX_DATA_2 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII2_RD3__ENET2_RX_DATA_3 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII2_RXC__ENET2_RX_CLK | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII2_TX_CTL__ENET2_TX_EN | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII2_TD0__ENET2_TX_DATA_0 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII2_TD1__ENET2_TX_DATA_1 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII2_TD2__ENET2_TX_DATA_2 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII2_TD3__ENET2_TX_DATA_3 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII2_TXC__ENET2_RGMII_TXC | MUX_PAD_CTRL(ENET_PAD_CTRL),
-};
-
-static int setup_fec(void)
-{
-	struct iomuxc *iomuxc_regs = (struct iomuxc *)IOMUXC_BASE_ADDR;
-
-	/* Use 125MHz anatop loopback REF_CLK1 for ENET2 */
-	clrsetbits_le32(&iomuxc_regs->gpr[1], IOMUX_GPR1_FEC2_MASK, 0);
-
-	return enable_fec_anatop_clock(1, ENET_125MHZ);
-}
-
-int board_eth_init(struct bd_info *bis)
-{
-	int ret;
-
-	imx_iomux_v3_setup_multiple_pads(fec2_pads, ARRAY_SIZE(fec2_pads));
-	setup_fec();
-
-	ret = fecmxc_initialize_multi(bis, 1,
-		CFG_FEC_MXC_PHYADDR, IMX_FEC_BASE);
-	if (ret)
-		printf("FEC%d MXC: %s:failed\n", 1, __func__);
-
-	return ret;
-}
-
 int board_phy_config(struct phy_device *phydev)
 {
 	/*
diff --git a/board/nxp/mx6sxsabresd/mx6sxsabresd.c b/board/nxp/mx6sxsabresd/mx6sxsabresd.c
index e3353feec68..cab0892affc 100644
--- a/board/nxp/mx6sxsabresd/mx6sxsabresd.c
+++ b/board/nxp/mx6sxsabresd/mx6sxsabresd.c
@@ -40,16 +40,6 @@ DECLARE_GLOBAL_DATA_PTR;
 	PAD_CTL_PUS_22K_UP  | PAD_CTL_SPEED_LOW |		\
 	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
 
-#define ENET_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_PUE |     \
-	PAD_CTL_SPEED_HIGH   |                                   \
-	PAD_CTL_DSE_48ohm   | PAD_CTL_SRE_FAST)
-
-#define ENET_CLK_PAD_CTRL  (PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_120ohm   | PAD_CTL_SRE_FAST)
-
-#define ENET_RX_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |          \
-	PAD_CTL_SPEED_HIGH   | PAD_CTL_SRE_FAST)
-
 #define LCD_PAD_CTRL    (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | \
 	PAD_CTL_PKE | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm)
 
@@ -71,84 +61,16 @@ static iomux_v3_cfg_t const uart1_pads[] = {
 static iomux_v3_cfg_t const wdog_b_pad = {
 	MX6_PAD_GPIO1_IO13__GPIO1_IO_13 | MUX_PAD_CTRL(WDOG_PAD_CTRL),
 };
-static iomux_v3_cfg_t const fec1_pads[] = {
-	MX6_PAD_ENET1_MDC__ENET1_MDC | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_ENET1_MDIO__ENET1_MDIO | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII1_RX_CTL__ENET1_RX_EN | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII1_RD0__ENET1_RX_DATA_0 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII1_RD1__ENET1_RX_DATA_1 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII1_RD2__ENET1_RX_DATA_2 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII1_RD3__ENET1_RX_DATA_3 | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII1_RXC__ENET1_RX_CLK | MUX_PAD_CTRL(ENET_RX_PAD_CTRL),
-	MX6_PAD_RGMII1_TX_CTL__ENET1_TX_EN | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII1_TD0__ENET1_TX_DATA_0 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII1_TD1__ENET1_TX_DATA_1 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII1_TD2__ENET1_TX_DATA_2 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII1_TD3__ENET1_TX_DATA_3 | MUX_PAD_CTRL(ENET_PAD_CTRL),
-	MX6_PAD_RGMII1_TXC__ENET1_RGMII_TXC | MUX_PAD_CTRL(ENET_PAD_CTRL),
-};
 
 static iomux_v3_cfg_t const peri_3v3_pads[] = {
 	MX6_PAD_QSPI1A_DATA0__GPIO4_IO_16 | MUX_PAD_CTRL(NO_PAD_CTRL),
 };
 
-static iomux_v3_cfg_t const phy_control_pads[] = {
-	/* 25MHz Ethernet PHY Clock */
-	MX6_PAD_ENET2_RX_CLK__ENET2_REF_CLK_25M | MUX_PAD_CTRL(ENET_CLK_PAD_CTRL),
-
-	/* ENET PHY Power */
-	MX6_PAD_ENET2_COL__GPIO2_IO_6 | MUX_PAD_CTRL(NO_PAD_CTRL),
-
-	/* AR8031 PHY Reset */
-	MX6_PAD_ENET2_CRS__GPIO2_IO_7 | MUX_PAD_CTRL(NO_PAD_CTRL),
-};
-
 static void setup_iomux_uart(void)
 {
 	imx_iomux_v3_setup_multiple_pads(uart1_pads, ARRAY_SIZE(uart1_pads));
 }
 
-static int setup_fec(void)
-{
-	struct iomuxc *iomuxc_regs = (struct iomuxc *)IOMUXC_BASE_ADDR;
-	struct anatop_regs *anatop = (struct anatop_regs *)ANATOP_BASE_ADDR;
-	int reg, ret;
-
-	/* Use 125MHz anatop loopback REF_CLK1 for ENET1 */
-	clrsetbits_le32(&iomuxc_regs->gpr[1], IOMUX_GPR1_FEC1_MASK, 0);
-
-	ret = enable_fec_anatop_clock(0, ENET_125MHZ);
-	if (ret)
-		return ret;
-
-	imx_iomux_v3_setup_multiple_pads(phy_control_pads,
-					 ARRAY_SIZE(phy_control_pads));
-
-	/* Enable the ENET power, active low */
-	gpio_request(IMX_GPIO_NR(2, 6), "enet_rst");
-	gpio_direction_output(IMX_GPIO_NR(2, 6) , 0);
-
-	/* Reset AR8031 PHY */
-	gpio_request(IMX_GPIO_NR(2, 7), "phy_rst");
-	gpio_direction_output(IMX_GPIO_NR(2, 7) , 0);
-	mdelay(10);
-	gpio_set_value(IMX_GPIO_NR(2, 7), 1);
-
-	reg = readl(&anatop->pll_enet);
-	reg |= BM_ANADIG_PLL_ENET_REF_25M_ENABLE;
-	writel(reg, &anatop->pll_enet);
-
-	return 0;
-}
-
-int board_eth_init(struct bd_info *bis)
-{
-	imx_iomux_v3_setup_multiple_pads(fec1_pads, ARRAY_SIZE(fec1_pads));
-	setup_fec();
-
-	return cpu_eth_init(bis);
-}
-
 int power_init_board(void)
 {
 	struct udevice *dev;
diff --git a/board/nxp/p2041rdb/Makefile b/board/nxp/p2041rdb/Makefile
index ebd0982b5db..5512458832d 100644
--- a/board/nxp/p2041rdb/Makefile
+++ b/board/nxp/p2041rdb/Makefile
@@ -7,4 +7,3 @@
 obj-y	+= p2041rdb.o
 obj-y	+= cpld.o
 obj-y	+= ddr.o
-obj-y	+= eth.o
diff --git a/board/nxp/p2041rdb/eth.c b/board/nxp/p2041rdb/eth.c
deleted file mode 100644
index d51b579b8b0..00000000000
--- a/board/nxp/p2041rdb/eth.c
+++ /dev/null
@@ -1,141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2011 Freescale Semiconductor, Inc.
- * Author: Mingkai Hu <Mingkai.hu@freescale.com>
- */
-
-/*
- * The RGMII PHYs are provided by the two on-board PHY. The SGMII PHYs
- * are provided by the three on-board PHY or by the standard Freescale
- * four-port SGMII riser card. We need to change the phy-handle in the
- * kernel dts file to point to the correct PHY according to serdes mux
- * and serdes protocol selection.
- */
-
-#include <config.h>
-#include <net.h>
-#include <netdev.h>
-#include <asm/fsl_serdes.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-#include <fsl_dtsec.h>
-
-#include "cpld.h"
-#include "../common/fman.h"
-
-#ifdef CONFIG_FMAN_ENET
-/*
- * Mapping of all 18 SERDES lanes to board slots. A value of '0' here means
- * that the mapping must be determined dynamically, or that the lane maps to
- * something other than a board slot
- */
-static u8 lane_to_slot[] = {
-	0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0
-};
-
-static int riser_phy_addr[] = {
-	CFG_SYS_FM1_DTSEC1_RISER_PHY_ADDR,
-	CFG_SYS_FM1_DTSEC2_RISER_PHY_ADDR,
-	CFG_SYS_FM1_DTSEC3_RISER_PHY_ADDR,
-	CFG_SYS_FM1_DTSEC4_RISER_PHY_ADDR,
-};
-
-/*
- * Initialize the lane_to_slot[] array.
- *
- * On the P2040RDB board the mapping is controlled by CPLD register.
- */
-static void initialize_lane_to_slot(void)
-{
-	u8 mux = CPLD_READ(serdes_mux);
-
-	lane_to_slot[6] = (mux & SERDES_MUX_LANE_6_MASK) ? 0 : 1;
-	lane_to_slot[10] = (mux & SERDES_MUX_LANE_A_MASK) ? 0 : 2;
-	lane_to_slot[12] = (mux & SERDES_MUX_LANE_C_MASK) ? 0 : 2;
-	lane_to_slot[13] = (mux & SERDES_MUX_LANE_D_MASK) ? 0 : 2;
-}
-
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_FMAN_ENET
-	struct fsl_pq_mdio_info dtsec_mdio_info;
-	struct tgec_mdio_info tgec_mdio_info;
-	unsigned int i, slot;
-	int lane;
-
-	printf("Initializing Fman\n");
-
-	initialize_lane_to_slot();
-
-	dtsec_mdio_info.regs =
-		(struct tsec_mii_mng *)CFG_SYS_FM1_DTSEC1_MDIO_ADDR;
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the real 1G MDIO bus */
-	fsl_pq_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct tgec_mdio_controller *)CFG_SYS_FM1_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the real 10G MDIO bus */
-	fm_tgec_mdio_init(bis, &tgec_mdio_info);
-
-	/*
-	 * Program the three on-board SGMII PHY addresses. If the SGMII Riser
-	 * card used, we'll override the PHY address later. For any DTSEC that
-	 * is RGMII, we'll also override its PHY address later. We assume that
-	 * DTSEC4 and DTSEC5 are used for RGMII.
-	 */
-	fm_info_set_phy_address(FM1_DTSEC1, CFG_SYS_FM1_DTSEC1_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC2, CFG_SYS_FM1_DTSEC2_PHY_ADDR);
-	fm_info_set_phy_address(FM1_DTSEC3, CFG_SYS_FM1_DTSEC3_PHY_ADDR);
-
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		int idx = i - FM1_DTSEC1;
-
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_SGMII:
-			lane = serdes_get_first_lane(SGMII_FM1_DTSEC1 + idx);
-			if (lane < 0)
-				break;
-			slot = lane_to_slot[lane];
-			if (slot)
-				fm_info_set_phy_address(i, riser_phy_addr[i]);
-			break;
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			/* Only DTSEC4 and DTSEC5 can be routed to RGMII */
-			fm_info_set_phy_address(i, i == FM1_DTSEC5 ?
-					CFG_SYS_FM1_DTSEC5_PHY_ADDR :
-					CFG_SYS_FM1_DTSEC4_PHY_ADDR);
-			break;
-		default:
-			printf("Fman1: DTSEC%u set to unknown interface %i\n",
-			       idx + 1, fm_info_get_enet_if(i));
-			break;
-		}
-
-		fm_info_set_mdio(i,
-			miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME));
-	}
-
-	lane = serdes_get_first_lane(XAUI_FM1);
-	if (lane >= 0) {
-		slot = lane_to_slot[lane];
-		if (slot)
-			fm_info_set_phy_address(FM1_10GEC1,
-					CFG_SYS_FM1_10GEC1_PHY_ADDR);
-	}
-
-	fm_info_set_mdio(FM1_10GEC1,
-			miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME));
-	cpu_eth_init(bis);
-#endif
-
-	return pci_eth_init(bis);
-}
-#endif /* #ifdef CONFIG_FMAN_ENET */
diff --git a/board/nxp/t102xrdb/eth_t102xrdb.c b/board/nxp/t102xrdb/eth_t102xrdb.c
index 91f87983dc5..a07d242c1eb 100644
--- a/board/nxp/t102xrdb/eth_t102xrdb.c
+++ b/board/nxp/t102xrdb/eth_t102xrdb.c
@@ -26,109 +26,6 @@
 #include <asm/fsl_serdes.h>
 #include "../common/fman.h"
 
-int board_eth_init(struct bd_info *bis)
-{
-#if defined(CONFIG_FMAN_ENET)
-	int i, interface;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct memac_mdio_info tgec_mdio_info;
-	struct mii_dev *dev;
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 srds_s1;
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-					FSL_CORENET2_RCWSR4_SRDS1_PRTCL;
-	srds_s1 >>= FSL_CORENET2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the 10G MDIO bus */
-	fm_memac_mdio_init(bis, &tgec_mdio_info);
-
-	/* Set the on-board RGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY1_ADDR);
-
-	switch (srds_s1) {
-#ifdef CONFIG_TARGET_T1024RDB
-	case 0x95:
-		/* set the on-board RGMII2  PHY */
-		fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY2_ADDR);
-
-		/* set 10GBase-R with Aquantia AQR105 PHY */
-		fm_info_set_phy_address(FM1_10GEC1, FM1_10GEC1_PHY_ADDR);
-		break;
-#endif
-	case 0x6a:
-	case 0x6b:
-	case 0x77:
-	case 0x135:
-		/* set the on-board 2.5G SGMII AQR105 PHY */
-		fm_info_set_phy_address(FM1_DTSEC3, SGMII_AQR_PHY_ADDR);
-#ifdef CONFIG_TARGET_T1023RDB
-		/* set the on-board 1G SGMII RTL8211F PHY */
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_RTK_PHY_ADDR);
-#endif
-		break;
-	default:
-		printf("SerDes protocol 0x%x is not supported on T102xRDB\n",
-		       srds_s1);
-		break;
-	}
-
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		interface = fm_info_get_enet_if(i);
-		switch (interface) {
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		case PHY_INTERFACE_MODE_SGMII:
-#if defined(CONFIG_TARGET_T1023RDB)
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-#elif defined(CONFIG_TARGET_T1024RDB)
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-#endif
-			fm_info_set_mdio(i, dev);
-			break;
-		case PHY_INTERFACE_MODE_2500BASEX:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		default:
-			break;
-		}
-	}
-
-	for (i = FM1_10GEC1; i < FM1_10GEC1 + CFG_SYS_NUM_FM1_10GEC; i++) {
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_XGMII:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		default:
-			break;
-		}
-	}
-
-	cpu_eth_init(bis);
-#endif /* CONFIG_FMAN_ENET */
-
-	return pci_eth_init(bis);
-}
-
 void fdt_fixup_board_enet(void *fdt)
 {
 }
diff --git a/board/nxp/t104xrdb/Makefile b/board/nxp/t104xrdb/Makefile
index 9bca1a1fbcc..cee574aabb9 100644
--- a/board/nxp/t104xrdb/Makefile
+++ b/board/nxp/t104xrdb/Makefile
@@ -7,7 +7,6 @@ obj-y += spl.o
 else
 obj-y	+= t104xrdb.o
 obj-y	+= cpld.o
-obj-y	+= eth.o
 endif
 obj-y	+= ddr.o
 obj-y	+= law.o
diff --git a/board/nxp/t104xrdb/eth.c b/board/nxp/t104xrdb/eth.c
deleted file mode 100644
index c35ec368a45..00000000000
--- a/board/nxp/t104xrdb/eth.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2014 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <net.h>
-#include <netdev.h>
-#include <asm/fsl_serdes.h>
-#include <asm/immap_85xx.h>
-#include <fm_eth.h>
-#include <fsl_mdio.h>
-#include <malloc.h>
-#include <fsl_dtsec.h>
-#include <vsc9953.h>
-
-#include "../common/fman.h"
-
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_FMAN_ENET
-	struct memac_mdio_info memac_mdio_info;
-	unsigned int i;
-	int phy_addr = 0;
-
-	printf("Initializing Fman\n");
-
-	memac_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-	memac_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the real 1G MDIO bus */
-	fm_memac_mdio_init(bis, &memac_mdio_info);
-
-	/*
-	 * Program on board RGMII, SGMII PHY addresses.
-	 */
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		int idx = i - FM1_DTSEC1;
-
-		switch (fm_info_get_enet_if(i)) {
-#ifdef CONFIG_TARGET_T1042D4RDB
-		case PHY_INTERFACE_MODE_SGMII:
-			/* T1042D4RDB supports SGMII on DTSEC1, DTSEC2
-			 *  & DTSEC3
-			 */
-			if (FM1_DTSEC1 == i)
-				phy_addr = CFG_SYS_SGMII1_PHY_ADDR;
-			if (FM1_DTSEC2 == i)
-				phy_addr = CFG_SYS_SGMII2_PHY_ADDR;
-			if (FM1_DTSEC3 == i)
-				phy_addr = CFG_SYS_SGMII3_PHY_ADDR;
-			fm_info_set_phy_address(i, phy_addr);
-			break;
-#endif
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			if (FM1_DTSEC4 == i)
-				phy_addr = CFG_SYS_RGMII1_PHY_ADDR;
-			if (FM1_DTSEC5 == i)
-				phy_addr = CFG_SYS_RGMII2_PHY_ADDR;
-			fm_info_set_phy_address(i, phy_addr);
-			break;
-		case PHY_INTERFACE_MODE_QSGMII:
-			fm_info_set_phy_address(i, 0);
-			break;
-		case PHY_INTERFACE_MODE_NA:
-			fm_info_set_phy_address(i, 0);
-			break;
-		default:
-			printf("Fman1: DTSEC%u set to unknown interface %i\n",
-			       idx + 1, fm_info_get_enet_if(i));
-			fm_info_set_phy_address(i, 0);
-			break;
-		}
-		if (fm_info_get_enet_if(i) == PHY_INTERFACE_MODE_QSGMII ||
-		    fm_info_get_enet_if(i) == PHY_INTERFACE_MODE_NA)
-			fm_info_set_mdio(i, NULL);
-		else
-			fm_info_set_mdio(i,
-					 miiphy_get_dev_by_name(
-							DEFAULT_FM_MDIO_NAME));
-	}
-
-	cpu_eth_init(bis);
-#endif
-
-	return pci_eth_init(bis);
-}
diff --git a/board/nxp/t208xqds/eth_t208xqds.c b/board/nxp/t208xqds/eth_t208xqds.c
index 12951df591e..e6aeb9bb66f 100644
--- a/board/nxp/t208xqds/eth_t208xqds.c
+++ b/board/nxp/t208xqds/eth_t208xqds.c
@@ -32,467 +32,7 @@
 #include "t208xqds_qixis.h"
 #include <linux/libfdt.h>
 
-#define EMI_NONE	0xFFFFFFFF
-#define EMI1_RGMII1	0
-#define EMI1_RGMII2     1
-#define EMI1_SLOT1	2
-#if defined(CONFIG_TARGET_T2080QDS)
-#define EMI1_SLOT2	6
-#define EMI1_SLOT3	3
-#define EMI1_SLOT4	4
-#define EMI1_SLOT5	5
-#define EMI2            7
-#endif
-
-#define PCCR1_SGMIIA_KX_MASK		0x00008000
-#define PCCR1_SGMIIB_KX_MASK		0x00004000
-#define PCCR1_SGMIIC_KX_MASK		0x00002000
-#define PCCR1_SGMIID_KX_MASK		0x00001000
-#define PCCR1_SGMIIE_KX_MASK		0x00000800
-#define PCCR1_SGMIIF_KX_MASK		0x00000400
-#define PCCR1_SGMIIG_KX_MASK		0x00000200
-#define PCCR1_SGMIIH_KX_MASK		0x00000100
-
-static int mdio_mux[NUM_FM_PORTS];
-
-static const char * const mdio_names[] = {
-#if defined(CONFIG_TARGET_T2080QDS)
-	"T2080QDS_MDIO_RGMII1",
-	"T2080QDS_MDIO_RGMII2",
-	"T2080QDS_MDIO_SLOT1",
-	"T2080QDS_MDIO_SLOT3",
-	"T2080QDS_MDIO_SLOT4",
-	"T2080QDS_MDIO_SLOT5",
-	"T2080QDS_MDIO_SLOT2",
-	"T2080QDS_MDIO_10GC",
-#endif
-};
-
-/* Map SerDes1 8 lanes to default slot, will be initialized dynamically */
-#if defined(CONFIG_TARGET_T2080QDS)
-static u8 lane_to_slot[] = {3, 3, 3, 3, 1, 1, 1, 1};
-#endif
-
-static const char *t208xqds_mdio_name_for_muxval(u8 muxval)
-{
-	return mdio_names[muxval];
-}
-
-struct mii_dev *mii_dev_for_muxval(u8 muxval)
-{
-	struct mii_dev *bus;
-	const char *name = t208xqds_mdio_name_for_muxval(muxval);
-
-	if (!name) {
-		printf("No bus for muxval %x\n", muxval);
-		return NULL;
-	}
-
-	bus = miiphy_get_dev_by_name(name);
-
-	if (!bus) {
-		printf("No bus by name %s\n", name);
-		return NULL;
-	}
-
-	return bus;
-}
-
-struct t208xqds_mdio {
-	u8 muxval;
-	struct mii_dev *realbus;
-};
-
-static void t208xqds_mux_mdio(u8 muxval)
-{
-	u8 brdcfg4;
-	if (muxval < 8) {
-		brdcfg4 = QIXIS_READ(brdcfg[4]);
-		brdcfg4 &= ~BRDCFG4_EMISEL_MASK;
-		brdcfg4 |= (muxval << BRDCFG4_EMISEL_SHIFT);
-		QIXIS_WRITE(brdcfg[4], brdcfg4);
-	}
-}
-
-static int t208xqds_mdio_read(struct mii_dev *bus, int addr, int devad,
-				int regnum)
-{
-	struct t208xqds_mdio *priv = bus->priv;
-
-	t208xqds_mux_mdio(priv->muxval);
-
-	return priv->realbus->read(priv->realbus, addr, devad, regnum);
-}
-
-static int t208xqds_mdio_write(struct mii_dev *bus, int addr, int devad,
-				int regnum, u16 value)
-{
-	struct t208xqds_mdio *priv = bus->priv;
-
-	t208xqds_mux_mdio(priv->muxval);
-
-	return priv->realbus->write(priv->realbus, addr, devad, regnum, value);
-}
-
-static int t208xqds_mdio_reset(struct mii_dev *bus)
-{
-	struct t208xqds_mdio *priv = bus->priv;
-
-	return priv->realbus->reset(priv->realbus);
-}
-
-static int t208xqds_mdio_init(char *realbusname, u8 muxval)
-{
-	struct t208xqds_mdio *pmdio;
-	struct mii_dev *bus = mdio_alloc();
-
-	if (!bus) {
-		printf("Failed to allocate t208xqds MDIO bus\n");
-		return -1;
-	}
-
-	pmdio = malloc(sizeof(*pmdio));
-	if (!pmdio) {
-		printf("Failed to allocate t208xqds private data\n");
-		free(bus);
-		return -1;
-	}
-
-	bus->read = t208xqds_mdio_read;
-	bus->write = t208xqds_mdio_write;
-	bus->reset = t208xqds_mdio_reset;
-	strcpy(bus->name, t208xqds_mdio_name_for_muxval(muxval));
-
-	pmdio->realbus = miiphy_get_dev_by_name(realbusname);
-
-	if (!pmdio->realbus) {
-		printf("No bus with name %s\n", realbusname);
-		free(bus);
-		free(pmdio);
-		return -1;
-	}
-
-	pmdio->muxval = muxval;
-	bus->priv = pmdio;
-	return mdio_register(bus);
-}
-
 void fdt_fixup_board_enet(void *fdt)
 {
 	return;
 }
-
-/*
- * This function reads RCW to check if Serdes1{A:H} is configured
- * to slot 1/2/3/4/5/6/7 and update the lane_to_slot[] array accordingly
- */
-static void initialize_lane_to_slot(void)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 srds_s1 = in_be32(&gur->rcwsr[4]) &
-				FSL_CORENET2_RCWSR4_SRDS1_PRTCL;
-
-	srds_s1 >>= FSL_CORENET2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	switch (srds_s1) {
-#if defined(CONFIG_TARGET_T2080QDS)
-	case 0x51:
-	case 0x5f:
-	case 0x65:
-	case 0x6b:
-	case 0x71:
-		lane_to_slot[5] = 2;
-		lane_to_slot[6] = 2;
-		lane_to_slot[7] = 2;
-		break;
-	case 0xa6:
-	case 0x8e:
-	case 0x8f:
-	case 0x82:
-	case 0x83:
-	case 0xd3:
-	case 0xd9:
-	case 0xcb:
-		lane_to_slot[6] = 2;
-		lane_to_slot[7] = 2;
-		break;
-	case 0xda:
-		lane_to_slot[4] = 3;
-		lane_to_slot[5] = 3;
-		lane_to_slot[6] = 3;
-		lane_to_slot[7] = 3;
-		break;
-#endif
-	default:
-		break;
-	}
-}
-
-int board_eth_init(struct bd_info *bis)
-{
-#if defined(CONFIG_FMAN_ENET)
-	int i, idx, lane, slot, interface;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct memac_mdio_info tgec_mdio_info;
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 rcwsr13 = in_be32(&gur->rcwsr[13]);
-	u32 srds_s1;
-
-	srds_s1 = in_be32(&gur->rcwsr[4]) &
-					FSL_CORENET2_RCWSR4_SRDS1_PRTCL;
-	srds_s1 >>= FSL_CORENET2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	initialize_lane_to_slot();
-
-	/* Initialize the mdio_mux array so we can recognize empty elements */
-	for (i = 0; i < NUM_FM_PORTS; i++)
-		mdio_mux[i] = EMI_NONE;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM1_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the 10G MDIO bus */
-	fm_memac_mdio_init(bis, &tgec_mdio_info);
-
-	/* Register the muxing front-ends to the MDIO buses */
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_RGMII1);
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_RGMII2);
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT1);
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT2);
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT3);
-#if defined(CONFIG_TARGET_T2080QDS)
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT4);
-#endif
-	t208xqds_mdio_init(DEFAULT_FM_MDIO_NAME, EMI1_SLOT5);
-	t208xqds_mdio_init(DEFAULT_FM_TGEC_MDIO_NAME, EMI2);
-
-	/* Set the two on-board RGMII PHY address */
-	fm_info_set_phy_address(FM1_DTSEC3, RGMII_PHY1_ADDR);
-	if ((rcwsr13 & FSL_CORENET_RCWSR13_EC2) ==
-			FSL_CORENET_RCWSR13_EC2_DTSEC4_RGMII)
-		fm_info_set_phy_address(FM1_DTSEC4, RGMII_PHY2_ADDR);
-	else
-		fm_info_set_phy_address(FM1_DTSEC10, RGMII_PHY2_ADDR);
-
-	switch (srds_s1) {
-	case 0x1b:
-	case 0x1c:
-	case 0x95:
-	case 0xa2:
-	case 0x94:
-		/* T2080QDS: SGMII in Slot3;  T2081QDS: SGMII in Slot2 */
-		fm_info_set_phy_address(FM1_DTSEC9, SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT2_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT4_PHY_ADDR);
-		/* T2080QDS: SGMII in Slot2;  T2081QDS: SGMII in Slot1 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-	case 0x50:
-	case 0x51:
-	case 0x5e:
-	case 0x5f:
-	case 0x64:
-	case 0x65:
-		/* T2080QDS: XAUI/HiGig in Slot3;  T2081QDS: in Slot2 */
-		fm_info_set_phy_address(FM1_10GEC1, FM1_10GEC1_PHY_ADDR);
-		/* T2080QDS: SGMII in Slot2;  T2081QDS: in Slot3 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-	case 0x66:
-	case 0x67:
-		/*
-		 * 10GBase-R does not need a PHY to work, but to avoid U-Boot
-		 * use default PHY address which is zero to a MAC when it found
-		 * a MAC has no PHY address, we give a PHY address to 10GBase-R
-		 * MAC, and should not use a real XAUI PHY address, since
-		 * MDIO can access it successfully, and then MDIO thinks
-		 * the XAUI card is used for the 10GBase-R MAC, which will cause
-		 * error.
-		 */
-		fm_info_set_phy_address(FM1_10GEC1, 4);
-		fm_info_set_phy_address(FM1_10GEC2, 5);
-		fm_info_set_phy_address(FM1_10GEC3, 6);
-		fm_info_set_phy_address(FM1_10GEC4, 7);
-		break;
-	case 0x6a:
-	case 0x6b:
-		fm_info_set_phy_address(FM1_10GEC1, 4);
-		fm_info_set_phy_address(FM1_10GEC2, 5);
-		fm_info_set_phy_address(FM1_10GEC3, 6);
-		fm_info_set_phy_address(FM1_10GEC4, 7);
-		/* T2080QDS: SGMII in Slot2;  T2081QDS: in Slot3 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT2_PHY_ADDR);
-		break;
-	case 0x6c:
-	case 0x6d:
-		fm_info_set_phy_address(FM1_10GEC1, 4);
-		fm_info_set_phy_address(FM1_10GEC2, 5);
-		/* T2080QDS: SGMII in Slot3;  T2081QDS: in Slot2 */
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-	case 0x70:
-	case 0x71:
-		/* SGMII in Slot3 */
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT4_PHY_ADDR);
-		/* SGMII in Slot2 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT2_PHY_ADDR);
-		break;
-	case 0xa6:
-	case 0x8e:
-	case 0x8f:
-	case 0x82:
-	case 0x83:
-		/* SGMII in Slot3 */
-		fm_info_set_phy_address(FM1_DTSEC9, SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT2_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT4_PHY_ADDR);
-		/* SGMII in Slot2 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT2_PHY_ADDR);
-		break;
-	case 0xa4:
-	case 0x96:
-	case 0x8a:
-		/* SGMII in Slot3 */
-		fm_info_set_phy_address(FM1_DTSEC9, SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT2_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-#if defined(CONFIG_TARGET_T2080QDS)
-	case 0xd9:
-	case 0xd3:
-	case 0xcb:
-		/* SGMII in Slot3 */
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT2_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT4_PHY_ADDR);
-		/* SGMII in Slot2 */
-		fm_info_set_phy_address(FM1_DTSEC5, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT2_PHY_ADDR);
-		break;
-#endif
-	case 0xf2:
-		/* T2080QDS: SGMII in Slot3; T2081QDS: SGMII in Slot7 */
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_CARD_PORT1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_CARD_PORT2_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC10, SGMII_CARD_PORT3_PHY_ADDR);
-		fm_info_set_phy_address(FM1_DTSEC6, SGMII_CARD_PORT4_PHY_ADDR);
-		break;
-	default:
-		break;
-	}
-
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		idx = i - FM1_DTSEC1;
-		interface = fm_info_get_enet_if(i);
-		switch (interface) {
-		case PHY_INTERFACE_MODE_SGMII:
-			lane = serdes_get_first_lane(FSL_SRDS_1,
-					SGMII_FM1_DTSEC1 + idx);
-			if (lane < 0)
-				break;
-			slot = lane_to_slot[lane];
-			debug("FM1@DTSEC%u expects SGMII in slot %u\n",
-			      idx + 1, slot);
-			if (QIXIS_READ(present2) & (1 << (slot - 1)))
-				fm_disable_port(i);
-
-			switch (slot) {
-			case 1:
-				mdio_mux[i] = EMI1_SLOT1;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 2:
-				mdio_mux[i] = EMI1_SLOT2;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			case 3:
-				mdio_mux[i] = EMI1_SLOT3;
-				fm_info_set_mdio(i, mii_dev_for_muxval(
-						 mdio_mux[i]));
-				break;
-			}
-			break;
-		case PHY_INTERFACE_MODE_RGMII:
-		case PHY_INTERFACE_MODE_RGMII_TXID:
-		case PHY_INTERFACE_MODE_RGMII_RXID:
-		case PHY_INTERFACE_MODE_RGMII_ID:
-			if (i == FM1_DTSEC3)
-				mdio_mux[i] = EMI1_RGMII1;
-			else if (i == FM1_DTSEC4 || FM1_DTSEC10)
-				mdio_mux[i] = EMI1_RGMII2;
-			fm_info_set_mdio(i, mii_dev_for_muxval(mdio_mux[i]));
-			break;
-		default:
-			break;
-		}
-	}
-
-	for (i = FM1_10GEC1; i < FM1_10GEC1 + CFG_SYS_NUM_FM1_10GEC; i++) {
-		idx = i - FM1_10GEC1;
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_XGMII:
-			if (srds_s1 == 0x51) {
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						XAUI_FM1_MAC9 + idx);
-			} else if ((srds_s1 == 0x5f) || (srds_s1 == 0x65)) {
-				lane = serdes_get_first_lane(FSL_SRDS_1,
-						HIGIG_FM1_MAC9 + idx);
-			} else {
-				if (i == FM1_10GEC1 || i == FM1_10GEC2)
-					lane = serdes_get_first_lane(FSL_SRDS_1,
-						XFI_FM1_MAC9 + idx);
-				else
-					lane = serdes_get_first_lane(FSL_SRDS_1,
-						XFI_FM1_MAC1 + idx);
-			}
-
-			if (lane < 0)
-				break;
-			mdio_mux[i] = EMI2;
-			fm_info_set_mdio(i, mii_dev_for_muxval(mdio_mux[i]));
-
-			if ((srds_s1 == 0x66) || (srds_s1 == 0x6b) ||
-			    (srds_s1 == 0x6a) || (srds_s1 == 0x70) ||
-			    (srds_s1 == 0x6c) || (srds_s1 == 0x6d) ||
-			    (srds_s1 == 0x71)) {
-				/* As 10GBase-R is in cage intead of a slot, so
-				 * ensure doesn't disable the corresponding port
-				 */
-				break;
-			}
-
-			slot = lane_to_slot[lane];
-			if (QIXIS_READ(present2) & (1 << (slot - 1)))
-				fm_disable_port(i);
-			break;
-		default:
-			break;
-		}
-	}
-
-	cpu_eth_init(bis);
-#endif /* CONFIG_FMAN_ENET */
-
-	return pci_eth_init(bis);
-}
diff --git a/board/nxp/t4rdb/eth.c b/board/nxp/t4rdb/eth.c
index e7646365d7d..dc2390f1003 100644
--- a/board/nxp/t4rdb/eth.c
+++ b/board/nxp/t4rdb/eth.c
@@ -35,118 +35,3 @@ void fdt_fixup_board_enet(void *fdt)
 {
 	return;
 }
-
-int board_eth_init(struct bd_info *bis)
-{
-#if defined(CONFIG_FMAN_ENET)
-	int i, interface;
-	struct memac_mdio_info dtsec_mdio_info;
-	struct memac_mdio_info tgec_mdio_info;
-	struct mii_dev *dev;
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 srds_prtcl_s1, srds_prtcl_s2;
-
-	srds_prtcl_s1 = in_be32(&gur->rcwsr[4]) &
-				FSL_CORENET2_RCWSR4_SRDS1_PRTCL;
-	srds_prtcl_s1 >>= FSL_CORENET2_RCWSR4_SRDS1_PRTCL_SHIFT;
-	srds_prtcl_s2 = in_be32(&gur->rcwsr[4]) &
-				FSL_CORENET2_RCWSR4_SRDS2_PRTCL;
-	srds_prtcl_s2 >>= FSL_CORENET2_RCWSR4_SRDS2_PRTCL_SHIFT;
-
-	dtsec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM2_DTSEC_MDIO_ADDR;
-
-	dtsec_mdio_info.name = DEFAULT_FM_MDIO_NAME;
-
-	/* Register the 1G MDIO bus */
-	fm_memac_mdio_init(bis, &dtsec_mdio_info);
-
-	tgec_mdio_info.regs =
-		(struct memac_mdio_controller *)CFG_SYS_FM2_TGEC_MDIO_ADDR;
-	tgec_mdio_info.name = DEFAULT_FM_TGEC_MDIO_NAME;
-
-	/* Register the 10G MDIO bus */
-	fm_memac_mdio_init(bis, &tgec_mdio_info);
-
-	if ((srds_prtcl_s1 == 28) || (srds_prtcl_s1 == 27)) {
-		/* SGMII */
-		fm_info_set_phy_address(FM1_DTSEC1, SGMII_PHY_ADDR1);
-		fm_info_set_phy_address(FM1_DTSEC2, SGMII_PHY_ADDR2);
-		fm_info_set_phy_address(FM1_DTSEC3, SGMII_PHY_ADDR3);
-		fm_info_set_phy_address(FM1_DTSEC4, SGMII_PHY_ADDR4);
-	} else {
-		puts("Invalid SerDes1 protocol for T4240RDB\n");
-	}
-
-	fm_disable_port(FM1_DTSEC5);
-	fm_disable_port(FM1_DTSEC6);
-
-	for (i = FM1_DTSEC1; i < FM1_DTSEC1 + CFG_SYS_NUM_FM1_DTSEC; i++) {
-		interface = fm_info_get_enet_if(i);
-		switch (interface) {
-		case PHY_INTERFACE_MODE_SGMII:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		default:
-			break;
-		}
-	}
-
-	for (i = FM1_10GEC1; i < FM1_10GEC1 + CFG_SYS_NUM_FM1_10GEC; i++) {
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_XGMII:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		default:
-			break;
-		}
-	}
-
-#if (CFG_SYS_NUM_FMAN == 2)
-	if ((srds_prtcl_s2 == 56) || (srds_prtcl_s2 == 55)) {
-		/* SGMII && 10GBase-R */
-		fm_info_set_phy_address(FM2_DTSEC1, SGMII_PHY_ADDR5);
-		fm_info_set_phy_address(FM2_DTSEC2, SGMII_PHY_ADDR6);
-		fm_info_set_phy_address(FM2_DTSEC3, SGMII_PHY_ADDR7);
-		fm_info_set_phy_address(FM2_DTSEC4, SGMII_PHY_ADDR8);
-		fm_info_set_phy_address(FM1_10GEC1, FM1_10GEC1_PHY_ADDR);
-		fm_info_set_phy_address(FM1_10GEC2, FM1_10GEC2_PHY_ADDR);
-		fm_info_set_phy_address(FM2_10GEC1, FM2_10GEC2_PHY_ADDR);
-		fm_info_set_phy_address(FM2_10GEC2, FM2_10GEC1_PHY_ADDR);
-	} else {
-		puts("Invalid SerDes2 protocol for T4240RDB\n");
-	}
-
-	fm_disable_port(FM2_DTSEC5);
-	fm_disable_port(FM2_DTSEC6);
-	for (i = FM2_DTSEC1; i < FM2_DTSEC1 + CFG_SYS_NUM_FM2_DTSEC; i++) {
-		interface = fm_info_get_enet_if(i);
-		switch (interface) {
-		case PHY_INTERFACE_MODE_SGMII:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		default:
-			break;
-		}
-	}
-
-	for (i = FM2_10GEC1; i < FM2_10GEC1 + CFG_SYS_NUM_FM2_10GEC; i++) {
-		switch (fm_info_get_enet_if(i)) {
-		case PHY_INTERFACE_MODE_XGMII:
-			dev = miiphy_get_dev_by_name(DEFAULT_FM_TGEC_MDIO_NAME);
-			fm_info_set_mdio(i, dev);
-			break;
-		default:
-			break;
-		}
-	}
-#endif /* CFG_SYS_NUM_FMAN */
-
-	cpu_eth_init(bis);
-#endif /* CONFIG_FMAN_ENET */
-
-	return pci_eth_init(bis);
-}
-- 
2.47.3

