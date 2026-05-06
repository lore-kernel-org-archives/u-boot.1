Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09CCCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D8C8490D;
	Wed,  6 May 2026 14:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TSUUaP/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E0E84915; Wed,  6 May 2026 14:36:19 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AE484903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 31809442F2;
 Wed,  6 May 2026 12:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5BBC2BCB8;
 Wed,  6 May 2026 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070975;
 bh=zJT0aseiFuDu3NX8nWo7LxL2IwUxh5b9hfwjNfn1+FA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TSUUaP/TTNmcdwtiBWnu/JfOqzpmsFCAt509dtKPSVHYhHCE0Zrknk/ixPalE+HnI
 B89Mkc7ayKocVPVDGSskHdKHC9cQmaboiB87dm9nnOoR2hVZCUacgM0SGY4e2+SSDT
 J4lUGrkwF7mlDRbsdf47trnf8Fm0gc9L8JXdhlfM3tMKBiSAMr6psIySqKdqtnRL4m
 F/QKHtOH7f5bCfpkJV/1X55fJmbDn3IF/u8JoQmtT9qE7oZA3Wg4iUOF0j8eP8gIDd
 d+tgSVlS9qX5OysnUEM57PZRcBHOEAup/xTE9RVe1Atgcx8by0xWFvGJgGkChwwMGt
 Af6QK8oeWnvaQ==
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
Subject: [PATCH v2 04/11] boards: remove dead fman code
Date: Wed,  6 May 2026 14:34:13 +0200
Message-ID: <20260506123507.2081751-5-mwalle@kernel.org>
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

Commit cc2bf624eb71 ("net: fm: Remove non-DM_ETH code") removed the call
to board_ft_fman_fixup_port(). Thus remove the dead code in the board
files.

I'm not sure, all that DT shenanigans are covered by the new DM-version
of the fman code, but it seems no one complained for the past 4 years.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/nxp/ls1043aqds/eth.c        |  99 -------------
 board/nxp/ls1046aqds/eth.c        |  81 -----------
 board/nxp/p2041rdb/eth.c          |  71 +---------
 board/nxp/t102xrdb/eth_t102xrdb.c |  15 --
 board/nxp/t208xqds/eth_t208xqds.c | 225 ------------------------------
 5 files changed, 1 insertion(+), 490 deletions(-)

diff --git a/board/nxp/ls1043aqds/eth.c b/board/nxp/ls1043aqds/eth.c
index 5a8ca27b327..5680fd2d377 100644
--- a/board/nxp/ls1043aqds/eth.c
+++ b/board/nxp/ls1043aqds/eth.c
@@ -159,105 +159,6 @@ static int ls1043aqds_mdio_init(char *realbusname, u8 muxval)
 	return mdio_register(bus);
 }
 
-void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
-			      enum fm_port port, int offset)
-{
-	struct fixed_link f_link;
-
-	if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_SGMII) {
-		if (port == FM1_DTSEC9) {
-			fdt_set_phy_handle(fdt, compat, addr,
-					   "sgmii-riser-s1-p1");
-		} else if (port == FM1_DTSEC2) {
-			fdt_set_phy_handle(fdt, compat, addr,
-					   "sgmii-riser-s2-p1");
-		} else if (port == FM1_DTSEC5) {
-			fdt_set_phy_handle(fdt, compat, addr,
-					   "sgmii-riser-s3-p1");
-		} else if (port == FM1_DTSEC6) {
-			fdt_set_phy_handle(fdt, compat, addr,
-					   "sgmii-riser-s4-p1");
-		}
-	} else if (fm_info_get_enet_if(port) ==
-		   PHY_INTERFACE_MODE_2500BASEX) {
-		/* 2.5G SGMII interface */
-		f_link.phy_id = cpu_to_fdt32(port);
-		f_link.duplex = cpu_to_fdt32(1);
-		f_link.link_speed = cpu_to_fdt32(1000);
-		f_link.pause = 0;
-		f_link.asym_pause = 0;
-		/* no PHY for 2.5G SGMII */
-		fdt_delprop(fdt, offset, "phy-handle");
-		fdt_setprop(fdt, offset, "fixed-link", &f_link, sizeof(f_link));
-		fdt_setprop_string(fdt, offset, "phy-connection-type",
-				   "2500base-x");
-	} else if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_QSGMII) {
-		switch (mdio_mux[port]) {
-		case EMI1_SLOT1:
-			switch (port) {
-			case FM1_DTSEC1:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s1-p1");
-				break;
-			case FM1_DTSEC2:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s1-p2");
-				break;
-			case FM1_DTSEC5:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s1-p3");
-				break;
-			case FM1_DTSEC6:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s1-p4");
-				break;
-			default:
-				break;
-			}
-			break;
-		case EMI1_SLOT2:
-			switch (port) {
-			case FM1_DTSEC1:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s2-p1");
-				break;
-			case FM1_DTSEC2:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s2-p2");
-				break;
-			case FM1_DTSEC5:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s2-p3");
-				break;
-			case FM1_DTSEC6:
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "qsgmii-s2-p4");
-				break;
-			default:
-				break;
-			}
-			break;
-		default:
-			break;
-		}
-		fdt_delprop(fdt, offset, "phy-connection-type");
-		fdt_setprop_string(fdt, offset, "phy-connection-type",
-				   "qsgmii");
-	} else if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_XGMII &&
-		   port == FM1_10GEC1) {
-		/* 10GBase-R interface */
-		f_link.phy_id = cpu_to_fdt32(port);
-		f_link.duplex = cpu_to_fdt32(1);
-		f_link.link_speed = cpu_to_fdt32(10000);
-		f_link.pause = 0;
-		f_link.asym_pause = 0;
-		/* no PHY for 10GBase-R */
-		fdt_delprop(fdt, offset, "phy-handle");
-		fdt_setprop(fdt, offset, "fixed-link", &f_link, sizeof(f_link));
-		fdt_setprop_string(fdt, offset, "phy-connection-type", "xgmii");
-	}
-}
-
 void fdt_fixup_board_enet(void *fdt)
 {
 	int i;
diff --git a/board/nxp/ls1046aqds/eth.c b/board/nxp/ls1046aqds/eth.c
index cd3500c2e96..8446f438d3c 100644
--- a/board/nxp/ls1046aqds/eth.c
+++ b/board/nxp/ls1046aqds/eth.c
@@ -155,87 +155,6 @@ static int ls1046aqds_mdio_init(char *realbusname, u8 muxval)
 	return mdio_register(bus);
 }
 
-void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
-			      enum fm_port port, int offset)
-{
-	struct fixed_link f_link;
-	const char *phyconn;
-
-	if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_SGMII) {
-		switch (port) {
-		case FM1_DTSEC9:
-			fdt_set_phy_handle(fdt, compat, addr, "sgmii-s1-p1");
-			break;
-		case FM1_DTSEC10:
-			fdt_set_phy_handle(fdt, compat, addr, "sgmii-s1-p2");
-			break;
-		case FM1_DTSEC5:
-			fdt_set_phy_handle(fdt, compat, addr, "sgmii-s1-p3");
-			break;
-		case FM1_DTSEC6:
-			fdt_set_phy_handle(fdt, compat, addr, "sgmii-s1-p4");
-			break;
-		case FM1_DTSEC2:
-			fdt_set_phy_handle(fdt, compat, addr, "sgmii-s4-p1");
-			break;
-		default:
-			break;
-		}
-	} else if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_2500BASEX) {
-		/* 2.5G SGMII interface */
-		f_link.phy_id = cpu_to_fdt32(port);
-		f_link.duplex = cpu_to_fdt32(1);
-		f_link.link_speed = cpu_to_fdt32(1000);
-		f_link.pause = 0;
-		f_link.asym_pause = 0;
-		/* no PHY for 2.5G SGMII on QDS */
-		fdt_delprop(fdt, offset, "phy-handle");
-		fdt_setprop(fdt, offset, "fixed-link", &f_link, sizeof(f_link));
-		fdt_setprop_string(fdt, offset, "phy-connection-type",
-				   "2500base-x");
-	} else if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_QSGMII) {
-		switch (port) {
-		case FM1_DTSEC1:
-			fdt_set_phy_handle(fdt, compat, addr, "qsgmii-s2-p4");
-			break;
-		case FM1_DTSEC5:
-			fdt_set_phy_handle(fdt, compat, addr, "qsgmii-s2-p2");
-			break;
-		case FM1_DTSEC6:
-			fdt_set_phy_handle(fdt, compat, addr, "qsgmii-s2-p1");
-			break;
-		case FM1_DTSEC10:
-			fdt_set_phy_handle(fdt, compat, addr, "qsgmii-s2-p3");
-			break;
-		default:
-			break;
-		}
-		fdt_delprop(fdt, offset, "phy-connection-type");
-		fdt_setprop_string(fdt, offset, "phy-connection-type",
-				   "qsgmii");
-	} else if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_XGMII &&
-		   (port == FM1_10GEC1 || port == FM1_10GEC2)) {
-		phyconn = fdt_getprop(fdt, offset, "phy-connection-type", NULL);
-		if (is_backplane_mode(phyconn)) {
-			/* Backplane KR mode: skip fixups */
-			printf("Interface %d in backplane KR mode\n", port);
-		} else {
-			/* 10GBase-R interface */
-			f_link.phy_id = cpu_to_fdt32(port);
-			f_link.duplex = cpu_to_fdt32(1);
-			f_link.link_speed = cpu_to_fdt32(10000);
-			f_link.pause = 0;
-			f_link.asym_pause = 0;
-			/* no PHY for 10GBase-R */
-			fdt_delprop(fdt, offset, "phy-handle");
-			fdt_setprop(fdt, offset, "fixed-link", &f_link,
-				    sizeof(f_link));
-			fdt_setprop_string(fdt, offset, "phy-connection-type",
-					   "xgmii");
-		}
-	}
-}
-
 void fdt_fixup_board_enet(void *fdt)
 {
 	int i;
diff --git a/board/nxp/p2041rdb/eth.c b/board/nxp/p2041rdb/eth.c
index 65850866777..d51b579b8b0 100644
--- a/board/nxp/p2041rdb/eth.c
+++ b/board/nxp/p2041rdb/eth.c
@@ -56,76 +56,6 @@ static void initialize_lane_to_slot(void)
 	lane_to_slot[13] = (mux & SERDES_MUX_LANE_D_MASK) ? 0 : 2;
 }
 
-/*
- * Given the following ...
- *
- * 1) A pointer to an Fman Ethernet node (as identified by the 'compat'
- * compatible string and 'addr' physical address)
- *
- * 2) An Fman port
- *
- * ... update the phy-handle property of the Ethernet node to point to the
- * right PHY.  This assumes that we already know the PHY for each port.
- *
- * The offset of the Fman Ethernet node is also passed in for convenience, but
- * it is not used, and we recalculate the offset anyway.
- *
- * Note that what we call "Fman ports" (enum fm_port) is really an Fman MAC.
- * Inside the Fman, "ports" are things that connect to MACs.  We only call them
- * ports in U-Boot because on previous Ethernet devices (e.g. Gianfar), MACs
- * and ports are the same thing.
- *
- */
-void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
-			      enum fm_port port, int offset)
-{
-	phy_interface_t intf = fm_info_get_enet_if(port);
-	char phy[16];
-	int lane;
-	u8 slot;
-
-	switch (intf) {
-	/* The RGMII PHY is identified by the MAC connected to it */
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		sprintf(phy, "phy_rgmii_%u", port == FM1_DTSEC5 ? 0 : 1);
-		fdt_set_phy_handle(fdt, compat, addr, phy);
-		break;
-	/* The SGMII PHY is identified by the MAC connected to it */
-	case PHY_INTERFACE_MODE_SGMII:
-		lane = serdes_get_first_lane(SGMII_FM1_DTSEC1 + port);
-		if (lane < 0)
-			return;
-		slot = lane_to_slot[lane];
-		if (slot) {
-			sprintf(phy, "phy_sgmii_%x",
-					CFG_SYS_FM1_DTSEC1_RISER_PHY_ADDR
-					+ (port - FM1_DTSEC1));
-			fdt_set_phy_handle(fdt, compat, addr, phy);
-		} else {
-			sprintf(phy, "phy_sgmii_%x",
-					CFG_SYS_FM1_DTSEC1_PHY_ADDR
-					+ (port - FM1_DTSEC1));
-			fdt_set_phy_handle(fdt, compat, addr, phy);
-		}
-		break;
-	case PHY_INTERFACE_MODE_XGMII:
-		/* XAUI */
-		lane = serdes_get_first_lane(XAUI_FM1);
-		if (lane >= 0) {
-			/* The XAUI PHY is identified by the slot */
-			sprintf(phy, "phy_xgmii_%u", lane_to_slot[lane]);
-			fdt_set_phy_handle(fdt, compat, addr, phy);
-		}
-		break;
-	default:
-		break;
-	}
-}
-#endif /* #ifdef CONFIG_FMAN_ENET */
-
 int board_eth_init(struct bd_info *bis)
 {
 #ifdef CONFIG_FMAN_ENET
@@ -208,3 +138,4 @@ int board_eth_init(struct bd_info *bis)
 
 	return pci_eth_init(bis);
 }
+#endif /* #ifdef CONFIG_FMAN_ENET */
diff --git a/board/nxp/t102xrdb/eth_t102xrdb.c b/board/nxp/t102xrdb/eth_t102xrdb.c
index 7185a0abd52..91f87983dc5 100644
--- a/board/nxp/t102xrdb/eth_t102xrdb.c
+++ b/board/nxp/t102xrdb/eth_t102xrdb.c
@@ -129,21 +129,6 @@ int board_eth_init(struct bd_info *bis)
 	return pci_eth_init(bis);
 }
 
-void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
-			      enum fm_port port, int offset)
-{
-#if defined(CONFIG_TARGET_T1024RDB)
-	if (((fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_2500BASEX) ||
-	     (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_SGMII)) &&
-			(port == FM1_DTSEC3)) {
-		fdt_set_phy_handle(fdt, compat, addr, "sg_2500_aqr105_phy4");
-		fdt_setprop_string(fdt, offset, "phy-connection-type",
-				   "2500base-x");
-		fdt_status_disabled_by_alias(fdt, "xg_aqr105_phy3");
-	}
-#endif
-}
-
 void fdt_fixup_board_enet(void *fdt)
 {
 }
diff --git a/board/nxp/t208xqds/eth_t208xqds.c b/board/nxp/t208xqds/eth_t208xqds.c
index b55078c8fe1..12951df591e 100644
--- a/board/nxp/t208xqds/eth_t208xqds.c
+++ b/board/nxp/t208xqds/eth_t208xqds.c
@@ -177,231 +177,6 @@ static int t208xqds_mdio_init(char *realbusname, u8 muxval)
 	return mdio_register(bus);
 }
 
-void board_ft_fman_fixup_port(void *fdt, char *compat, phys_addr_t addr,
-				enum fm_port port, int offset)
-{
-	int phy;
-	char alias[20];
-	char lane_mode[2][20] = {"1000BASE-KX", "10GBASE-KR"};
-	char buf[32] = "serdes-1,";
-	struct fixed_link f_link;
-	int media_type = 0;
-	const char *phyconn;
-	int off;
-
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-#ifdef CONFIG_TARGET_T2080QDS
-	serdes_corenet_t *srds_regs =
-		(void *)CFG_SYS_FSL_CORENET_SERDES_ADDR;
-	u32 srds1_pccr1 = in_be32(&srds_regs->srdspccr1);
-#endif
-	u32 srds_s1 = in_be32(&gur->rcwsr[4]) &
-				FSL_CORENET2_RCWSR4_SRDS1_PRTCL;
-
-	srds_s1 >>= FSL_CORENET2_RCWSR4_SRDS1_PRTCL_SHIFT;
-
-	if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_SGMII) {
-		phy = fm_info_get_phy_address(port);
-		switch (port) {
-#if defined(CONFIG_TARGET_T2080QDS)
-		case FM1_DTSEC1:
-			if (hwconfig_sub("fsl_1gkx", "fm1_1g1")) {
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "phy_1gkx1");
-				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio1");
-				strcat(buf, "lane-c,");
-				strcat(buf, (char *)lane_mode[0]);
-				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
-					 PCCR1_SGMIIH_KX_MASK);
-				break;
-			}
-		case FM1_DTSEC2:
-			if (hwconfig_sub("fsl_1gkx", "fm1_1g2")) {
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "phy_1gkx2");
-				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio2");
-				strcat(buf, "lane-d,");
-				strcat(buf, (char *)lane_mode[0]);
-				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
-					 PCCR1_SGMIIG_KX_MASK);
-				break;
-			}
-		case FM1_DTSEC9:
-			if (hwconfig_sub("fsl_1gkx", "fm1_1g9")) {
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "phy_1gkx9");
-				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio9");
-				strcat(buf, "lane-a,");
-				strcat(buf, (char *)lane_mode[0]);
-				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
-					 PCCR1_SGMIIE_KX_MASK);
-				break;
-			}
-		case FM1_DTSEC10:
-			if (hwconfig_sub("fsl_1gkx", "fm1_1g10")) {
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "phy_1gkx10");
-				fdt_status_okay_by_alias(fdt,
-							 "1gkx_pcs_mdio10");
-				strcat(buf, "lane-b,");
-				strcat(buf, (char *)lane_mode[0]);
-				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
-					 PCCR1_SGMIIF_KX_MASK);
-				break;
-			}
-			if (mdio_mux[port] == EMI1_SLOT2) {
-				sprintf(alias, "phy_sgmii_s2_%x", phy);
-				fdt_set_phy_handle(fdt, compat, addr, alias);
-				fdt_status_okay_by_alias(fdt, "emi1_slot2");
-			} else if (mdio_mux[port] == EMI1_SLOT3) {
-				sprintf(alias, "phy_sgmii_s3_%x", phy);
-				fdt_set_phy_handle(fdt, compat, addr, alias);
-				fdt_status_okay_by_alias(fdt, "emi1_slot3");
-			}
-			break;
-		case FM1_DTSEC5:
-			if (hwconfig_sub("fsl_1gkx", "fm1_1g5")) {
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "phy_1gkx5");
-				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio5");
-				strcat(buf, "lane-g,");
-				strcat(buf, (char *)lane_mode[0]);
-				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
-					 PCCR1_SGMIIC_KX_MASK);
-				break;
-			}
-		case FM1_DTSEC6:
-			if (hwconfig_sub("fsl_1gkx", "fm1_1g6")) {
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						   "phy_1gkx6");
-				fdt_status_okay_by_alias(fdt, "1gkx_pcs_mdio6");
-				strcat(buf, "lane-h,");
-				strcat(buf, (char *)lane_mode[0]);
-				out_be32(&srds_regs->srdspccr1, srds1_pccr1 |
-					 PCCR1_SGMIID_KX_MASK);
-				break;
-			}
-			if (mdio_mux[port] == EMI1_SLOT1) {
-				sprintf(alias, "phy_sgmii_s1_%x", phy);
-				fdt_set_phy_handle(fdt, compat, addr, alias);
-				fdt_status_okay_by_alias(fdt, "emi1_slot1");
-			} else if (mdio_mux[port] == EMI1_SLOT2) {
-				sprintf(alias, "phy_sgmii_s2_%x", phy);
-				fdt_set_phy_handle(fdt, compat, addr, alias);
-				fdt_status_okay_by_alias(fdt, "emi1_slot2");
-			}
-			break;
-#endif
-		default:
-			break;
-		}
-		if (media_type) {
-			/* set property for 1000BASE-KX in dtb */
-			off = fdt_node_offset_by_compat_reg(fdt,
-					"fsl,fman-memac-mdio", addr + 0x1000);
-			fdt_setprop_string(fdt, off, "lane-instance", buf);
-		}
-
-	} else if (fm_info_get_enet_if(port) == PHY_INTERFACE_MODE_XGMII) {
-		switch (srds_s1) {
-		case 0x66: /* 10GBase-R interface */
-		case 0x6b:
-		case 0x6c:
-		case 0x6d:
-		case 0x71:
-			/*
-			 * Check hwconfig to see what is the media type, there
-			 * are two types, fiber or copper, fix the dtb
-			 * accordingly.
-			 */
-			switch (port) {
-			case FM1_10GEC1:
-			if (hwconfig_sub("fsl_10gkr_copper", "fm1_10g1")) {
-				/* it's MAC9 */
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						"phy_xfi9");
-				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio9");
-				strcat(buf, "lane-a,");
-				strcat(buf, (char *)lane_mode[1]);
-			}
-				break;
-			case FM1_10GEC2:
-			if (hwconfig_sub("fsl_10gkr_copper", "fm1_10g2")) {
-				/* it's MAC10 */
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						"phy_xfi10");
-				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio10");
-				strcat(buf, "lane-b,");
-				strcat(buf, (char *)lane_mode[1]);
-			}
-				break;
-			case FM1_10GEC3:
-			if (hwconfig_sub("fsl_10gkr_copper", "fm1_10g3")) {
-				/* it's MAC1 */
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						"phy_xfi1");
-				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio1");
-				strcat(buf, "lane-c,");
-				strcat(buf, (char *)lane_mode[1]);
-			}
-				break;
-			case FM1_10GEC4:
-			if (hwconfig_sub("fsl_10gkr_copper", "fm1_10g4")) {
-				/* it's MAC2 */
-				media_type = 1;
-				fdt_set_phy_handle(fdt, compat, addr,
-						"phy_xfi2");
-				fdt_status_okay_by_alias(fdt, "xfi_pcs_mdio2");
-				strcat(buf, "lane-d,");
-				strcat(buf, (char *)lane_mode[1]);
-			}
-				break;
-			default:
-				return;
-			}
-
-			if (!media_type) {
-				phyconn = fdt_getprop(fdt, offset,
-						      "phy-connection-type",
-						      NULL);
-				if (is_backplane_mode(phyconn)) {
-					/* Backplane KR mode: skip fixups */
-					printf("Interface %d in backplane KR mode\n",
-					       port);
-				} else {
-					/* fixed-link for 10GBase-R fiber cable */
-					f_link.phy_id = port;
-					f_link.duplex = 1;
-					f_link.link_speed = 10000;
-					f_link.pause = 0;
-					f_link.asym_pause = 0;
-					fdt_delprop(fdt, offset, "phy-handle");
-					fdt_setprop(fdt, offset, "fixed-link",
-						    &f_link, sizeof(f_link));
-				}
-			} else {
-				/* set property for copper cable */
-				off = fdt_node_offset_by_compat_reg(fdt,
-					"fsl,fman-memac-mdio", addr + 0x1000);
-				fdt_setprop_string(fdt, off,
-					"lane-instance", buf);
-			}
-			break;
-		default:
-			break;
-		}
-	}
-}
-
 void fdt_fixup_board_enet(void *fdt)
 {
 	return;
-- 
2.47.3

