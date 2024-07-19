Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C7DC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904A688B8A;
	Fri, 19 Jul 2024 12:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RHtFnwb1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BbKcSR/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23C388BBF; Fri, 19 Jul 2024 12:50:35 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE8F88BE6
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKN69lNz9sdB;
 Fri, 19 Jul 2024 12:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDZ6HJvkwTEHu+Mwul+zZHB4gy6DvBoqY3vkgHdjUTc=;
 b=RHtFnwb19tNejh5k5H9h7U/b3R4J7nhPJF++ApOIgq43lviYcTab5dgKo3ctvOykBKbjGK
 lLG5yomNCT+9U69piWUzx3JjLRLbdjDUmVs7ZhYiEooJpksljwSJsKJrbNS3/HKRTQla/I
 5VTNaim3TDf1es/mwzulwgAa6C981yj7f2WSYS71Nm5o5NUCXKqbD0GiAGMPet48MaT5ki
 8TpymF6/D+dF65Ig1h0rBpJqy0bE7dEmSA0aZkJSWnvrpcaK2UhwS7+rI66naCZUAPzd5t
 xb8h4YTJ9ZreC3iBUxxInvZgnUQ7Ir54l2EdH3fHYLpx8RH/dcFIuncDqoiZCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDZ6HJvkwTEHu+Mwul+zZHB4gy6DvBoqY3vkgHdjUTc=;
 b=BbKcSR/krkOhwiwgeYdLSwDCDTBJzHhmdT5eCXaDa7mXaknm3tAFxMiFJmwQWvUxj33UT0
 N/55TBwFRdqq590aDqpL7MY9Qkv3RFtajam5rOa5uuvb5y5JWZQwl6XjRGxYFF1VxDhUbP
 dJbUIF97ylQkHX/ktFIdEB8Gyk69Dcnr4+UsbOjxKO5kJY2Vubs3lM8Tj9Z7VbjqvddcCv
 ZmM5UM/DUrGGZyXW/Fvh0QV3+1tNemU8HFRaar1s93ly9/1dDD9KAnTpgmyo4fV4joB/V1
 w1hClJTlXecUNM6XNupvK58QKsIYb4NY0LpVm9oe3hEqnLiFNu6NJE3dh+WWKQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/37] board: freescale: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:52 +0200
Message-ID: <20240719104948.323791-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hyrzjwnuspdewhc65fpoypjt98xfzadr
X-MBO-RS-ID: 517757a86f141375d11
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/freescale/common/cadmus.c                   | 5 -----
 board/freescale/common/cadmus.h                   | 4 ----
 board/freescale/common/eeprom.h                   | 3 ---
 board/freescale/common/fsl_validate.c             | 2 --
 board/freescale/imx8mn_evk/ddr4_timing.c          | 1 -
 board/freescale/imx8mn_evk/ddr4_timing_ld.c       | 2 --
 board/freescale/ls1012ardb/ls1012ardb.c           | 1 -
 board/freescale/ls1021aiot/ls1021aiot.c           | 1 -
 board/freescale/ls1043aqds/ls1043aqds.c           | 1 -
 board/freescale/ls1088a/ddr.c                     | 1 -
 board/freescale/ls2080aqds/ddr.c                  | 1 -
 board/freescale/ls2080aqds/ddr.h                  | 1 -
 board/freescale/ls2080ardb/ddr.c                  | 1 -
 board/freescale/ls2080ardb/ddr.h                  | 1 -
 board/freescale/m5249evb/m5249evb.c               | 2 --
 board/freescale/m5253demo/m5253demo.c             | 1 -
 board/freescale/m5275evb/m5275evb.c               | 1 -
 board/freescale/mpc8548cds/ddr.c                  | 1 -
 board/freescale/mx6sabreauto/mx6sabreauto.c       | 3 ---
 board/freescale/mx6sllevk/mx6sllevk.c             | 1 -
 board/freescale/mx6sxsabreauto/mx6sxsabreauto.c   | 1 -
 board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c | 2 --
 board/freescale/p1010rdb/p1010rdb.c               | 1 -
 board/freescale/t102xrdb/cpld.h                   | 1 -
 board/freescale/t104xrdb/eth.c                    | 1 -
 board/freescale/t208xqds/t208xqds_qixis.h         | 1 -
 board/freescale/t208xqds/tlb.c                    | 1 -
 board/freescale/t208xrdb/tlb.c                    | 1 -
 board/freescale/t4rdb/ddr.c                       | 1 -
 board/freescale/t4rdb/ddr.h                       | 1 -
 board/freescale/vf610twr/vf610twr.c               | 1 -
 31 files changed, 46 deletions(-)

diff --git a/board/freescale/common/cadmus.c b/board/freescale/common/cadmus.c
index 6f66ed6851d..e5ecd0e19c6 100644
--- a/board/freescale/common/cadmus.c
+++ b/board/freescale/common/cadmus.c
@@ -3,7 +3,6 @@
  * Copyright 2004, 2011 Freescale Semiconductor.
  */
 
-
 #include <config.h>
 #include <clock_legacy.h>
 #include <linux/types.h>
@@ -27,7 +26,6 @@ typedef struct cadmus_reg {
     u_char cm_reserved[248];	/* Total 256 bytes */
 } cadmus_reg_t;
 
-
 unsigned int
 get_board_version(void)
 {
@@ -36,7 +34,6 @@ get_board_version(void)
 	return cadmus->cm_ver;
 }
 
-
 unsigned long
 get_board_sys_clk(void)
 {
@@ -54,7 +51,6 @@ get_board_sys_clk(void)
 	}
 }
 
-
 unsigned int
 get_pci_slot(void)
 {
@@ -66,7 +62,6 @@ get_pci_slot(void)
 	return ((cadmus->cm_csr >> 6) & 0x3) + 1;
 }
 
-
 unsigned int
 get_pci_dual(void)
 {
diff --git a/board/freescale/common/cadmus.h b/board/freescale/common/cadmus.h
index fb74e8f6db5..93cea120845 100644
--- a/board/freescale/common/cadmus.h
+++ b/board/freescale/common/cadmus.h
@@ -6,7 +6,6 @@
 #ifndef __CADMUS_H_
 #define __CADMUS_H_
 
-
 /*
  * CADMUS Board System Register interface.
  */
@@ -21,17 +20,14 @@ extern unsigned int get_board_version(void);
  */
 extern unsigned long get_board_sys_clk(void);
 
-
 /*
  * Returns 1 - 4, as found in the USER CSR[6:7] bits.
  */
 extern unsigned int get_pci_slot(void);
 
-
 /*
  * Returns PCI DUAL as found in CM_PCI[3].
  */
 extern unsigned int get_pci_dual(void);
 
-
 #endif	/* __CADMUS_H_ */
diff --git a/board/freescale/common/eeprom.h b/board/freescale/common/eeprom.h
index 328fd3974b1..1d0685fde67 100644
--- a/board/freescale/common/eeprom.h
+++ b/board/freescale/common/eeprom.h
@@ -6,12 +6,10 @@
 #ifndef __EEPROM_H_
 #define __EEPROM_H_
 
-
 /*
  * EEPROM Board System Register interface.
  */
 
-
 /*
  * CPU Board Revision
  */
@@ -29,5 +27,4 @@
  */
 extern unsigned int get_cpu_board_revision(void);
 
-
 #endif	/* __CADMUS_H_ */
diff --git a/board/freescale/common/fsl_validate.c b/board/freescale/common/fsl_validate.c
index e03434dcdfe..657f4533bcd 100644
--- a/board/freescale/common/fsl_validate.c
+++ b/board/freescale/common/fsl_validate.c
@@ -327,7 +327,6 @@ static u32 read_validate_ie_tbl(struct fsl_secboot_img_priv *img)
 }
 #endif
 
-
 /* This function return length of public key.*/
 static inline u32 get_key_len(struct fsl_secboot_img_priv *img)
 {
@@ -858,7 +857,6 @@ static int secboot_init(struct fsl_secboot_img_priv **img_ptr)
 	return 0;
 }
 
-
 /* haddr - Address of the header of image to be validated.
  * arg_hash_str - Option hash string. If provided, this
  * overrides the key hash in the SFP fuses.
diff --git a/board/freescale/imx8mn_evk/ddr4_timing.c b/board/freescale/imx8mn_evk/ddr4_timing.c
index 77611ea0260..ce39c9e2bcf 100644
--- a/board/freescale/imx8mn_evk/ddr4_timing.c
+++ b/board/freescale/imx8mn_evk/ddr4_timing.c
@@ -787,7 +787,6 @@ struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{ 0xd0000, 0x1 },
 };
 
-
 /* P0 2D message block paremeter for training firmware */
 struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
 	{ 0xd0000, 0x0 },
diff --git a/board/freescale/imx8mn_evk/ddr4_timing_ld.c b/board/freescale/imx8mn_evk/ddr4_timing_ld.c
index a3577efd0b2..d719b5916f5 100644
--- a/board/freescale/imx8mn_evk/ddr4_timing_ld.c
+++ b/board/freescale/imx8mn_evk/ddr4_timing_ld.c
@@ -765,7 +765,6 @@ struct dram_cfg_param ddr_fsp0_cfg[] = {
 	{ 0xd0000, 0x1 },
 };
 
-
 /* P1 message block paremeter for training firmware */
 struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{ 0xd0000, 0x0 },
@@ -791,7 +790,6 @@ struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{ 0xd0000, 0x1 },
 };
 
-
 /* P0 2D message block paremeter for training firmware */
 struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
 	{ 0xd0000, 0x0 },
diff --git a/board/freescale/ls1012ardb/ls1012ardb.c b/board/freescale/ls1012ardb/ls1012ardb.c
index 7f8001b4981..5f0564f1b23 100644
--- a/board/freescale/ls1012ardb/ls1012ardb.c
+++ b/board/freescale/ls1012ardb/ls1012ardb.c
@@ -147,7 +147,6 @@ int dram_init(void)
 }
 #endif
 
-
 int board_early_init_f(void)
 {
 	fsl_lsch2_early_init_f();
diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/freescale/ls1021aiot/ls1021aiot.c
index 7abc4126933..2fdac87bc29 100644
--- a/board/freescale/ls1021aiot/ls1021aiot.c
+++ b/board/freescale/ls1021aiot/ls1021aiot.c
@@ -33,7 +33,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define DDR_SIZE		0x40000000
 
-
 int checkboard(void)
 {
 	puts("Board: LS1021AIOT\n");
diff --git a/board/freescale/ls1043aqds/ls1043aqds.c b/board/freescale/ls1043aqds/ls1043aqds.c
index fdf011efc5b..2ecf5a74a03 100644
--- a/board/freescale/ls1043aqds/ls1043aqds.c
+++ b/board/freescale/ls1043aqds/ls1043aqds.c
@@ -508,7 +508,6 @@ int config_serdes_mux(void)
 	return 0;
 }
 
-
 #ifdef CONFIG_MISC_INIT_R
 int misc_init_r(void)
 {
diff --git a/board/freescale/ls1088a/ddr.c b/board/freescale/ls1088a/ddr.c
index d2e239c4d61..54b432ad794 100644
--- a/board/freescale/ls1088a/ddr.c
+++ b/board/freescale/ls1088a/ddr.c
@@ -94,7 +94,6 @@ found:
 	popts->wrlvl_override = 1;
 	popts->wrlvl_sample = 0xf;
 
-
 	/* Enable ZQ calibration */
 	popts->zq_en = 1;
 
diff --git a/board/freescale/ls2080aqds/ddr.c b/board/freescale/ls2080aqds/ddr.c
index 2986ffb7a82..d19c061e122 100644
--- a/board/freescale/ls2080aqds/ddr.c
+++ b/board/freescale/ls2080aqds/ddr.c
@@ -46,7 +46,6 @@ void fsl_ddr_board_options(memctl_options_t *popts,
 	else
 		pbsp = udimms[ctrl_num];
 
-
 	/* Get clk_adjust, wrlvl_start, wrlvl_ctl, according to the board ddr
 	 * freqency and n_banks specified in board_specific_parameters table.
 	 */
diff --git a/board/freescale/ls2080aqds/ddr.h b/board/freescale/ls2080aqds/ddr.h
index b5d790a4a05..465155e56bf 100644
--- a/board/freescale/ls2080aqds/ddr.h
+++ b/board/freescale/ls2080aqds/ddr.h
@@ -87,5 +87,4 @@ static const struct board_specific_parameters *rdimms[] = {
 	rdimm2,
 };
 
-
 #endif
diff --git a/board/freescale/ls2080ardb/ddr.c b/board/freescale/ls2080ardb/ddr.c
index ec34b42e619..a1a97f9f8c2 100644
--- a/board/freescale/ls2080ardb/ddr.c
+++ b/board/freescale/ls2080ardb/ddr.c
@@ -46,7 +46,6 @@ void fsl_ddr_board_options(memctl_options_t *popts,
 	else
 		pbsp = udimms[ctrl_num];
 
-
 	/* Get clk_adjust, wrlvl_start, wrlvl_ctl, according to the board ddr
 	 * freqency and n_banks specified in board_specific_parameters table.
 	 */
diff --git a/board/freescale/ls2080ardb/ddr.h b/board/freescale/ls2080ardb/ddr.h
index c5f2a95211b..43301dc72a3 100644
--- a/board/freescale/ls2080ardb/ddr.h
+++ b/board/freescale/ls2080ardb/ddr.h
@@ -72,5 +72,4 @@ static const struct board_specific_parameters *rdimms[] = {
 	udimm2,	/* DP-DDR doesn't support RDIMM */
 };
 
-
 #endif
diff --git a/board/freescale/m5249evb/m5249evb.c b/board/freescale/m5249evb/m5249evb.c
index 717dc087e02..68524e5e682 100644
--- a/board/freescale/m5249evb/m5249evb.c
+++ b/board/freescale/m5249evb/m5249evb.c
@@ -32,7 +32,6 @@ int checkboard (void) {
 	return 0;
 };
 
-
 int dram_init(void)
 {
 	unsigned long	junk = 0xa5a59696;
@@ -91,7 +90,6 @@ int dram_init(void)
 	return 0;
 };
 
-
 int testdram(void)
 {
 	/* TODO: XXX XXX XXX */
diff --git a/board/freescale/m5253demo/m5253demo.c b/board/freescale/m5253demo/m5253demo.c
index d0b01f81745..446a79e6723 100644
--- a/board/freescale/m5253demo/m5253demo.c
+++ b/board/freescale/m5253demo/m5253demo.c
@@ -133,7 +133,6 @@ void ide_set_reset(int idereset)
 }
 #endif				/* CONFIG_IDE */
 
-
 #ifdef CONFIG_DRIVER_DM9000
 int board_eth_init(struct bd_info *bis)
 {
diff --git a/board/freescale/m5275evb/m5275evb.c b/board/freescale/m5275evb/m5275evb.c
index e1d94fc9a3e..8b986d42425 100644
--- a/board/freescale/m5275evb/m5275evb.c
+++ b/board/freescale/m5275evb/m5275evb.c
@@ -74,7 +74,6 @@ int dram_init(void)
 	*((volatile unsigned long *)CFG_SYS_SDRAM_BASE) = 0xa5a59696;
 	*((volatile unsigned long *)CFG_SYS_SDRAM_BASE) = 0xa5a59696;
 
-
 	out_be32(&sdp->sdmr, 0x018d0000);
 	*((volatile unsigned long *)CFG_SYS_SDRAM_BASE) = 0xa5a59696;
 
diff --git a/board/freescale/mpc8548cds/ddr.c b/board/freescale/mpc8548cds/ddr.c
index 14202cd5a78..4b8ddcc3ae4 100644
--- a/board/freescale/mpc8548cds/ddr.c
+++ b/board/freescale/mpc8548cds/ddr.c
@@ -3,7 +3,6 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-
 #include <fsl_ddr_sdram.h>
 #include <fsl_ddr_dimm_params.h>
 
diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c b/board/freescale/mx6sabreauto/mx6sabreauto.c
index e782543c0fa..bab62fd4421 100644
--- a/board/freescale/mx6sabreauto/mx6sabreauto.c
+++ b/board/freescale/mx6sabreauto/mx6sabreauto.c
@@ -138,7 +138,6 @@ static void eim_clk_setup(void)
 	struct mxc_ccm_reg *imx_ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
 	int cscmr1, ccgr6;
 
-
 	/* Turn off EIM clock */
 	ccgr6 = readl(&imx_ccm->CCGR6);
 	ccgr6 &= ~(0x3 << 10);
@@ -170,7 +169,6 @@ static void setup_iomux_eimnor(void)
 }
 #endif
 
-
 static iomux_v3_cfg_t const usdhc3_pads[] = {
 	IOMUX_PADS(PAD_SD3_CLK__SD3_CLK		| MUX_PAD_CTRL(USDHC_PAD_CTRL)),
 	IOMUX_PADS(PAD_SD3_CMD__SD3_CMD		| MUX_PAD_CTRL(USDHC_PAD_CTRL)),
@@ -480,7 +478,6 @@ int power_init_board(void)
 	if (ret != 0)
 		return ret;
 
-
 	if (is_mx6dqp()) {
 		/* set SW2 staby volatage 0.975V*/
 		value = pmic_reg_read(dev, PFUZE100_SW2STBY);
diff --git a/board/freescale/mx6sllevk/mx6sllevk.c b/board/freescale/mx6sllevk/mx6sllevk.c
index 7114444fc3e..9e39e39ac90 100644
--- a/board/freescale/mx6sllevk/mx6sllevk.c
+++ b/board/freescale/mx6sllevk/mx6sllevk.c
@@ -54,7 +54,6 @@ int power_init_board(void)
 	rev_id = pmic_reg_read(dev, PFUZE100_REVID);
 	printf("PMIC: PFUZE100! DEV_ID=0x%x REV_ID=0x%x\n", dev_id, rev_id);
 
-
 	/* Init mode to APS_PFM */
 	pmic_reg_write(dev, PFUZE100_SW1ABMODE, APS_PFM);
 
diff --git a/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c b/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
index 6176f738238..d80cfd4ab27 100644
--- a/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
+++ b/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
@@ -135,7 +135,6 @@ int power_init_board(void)
 	rev_id = pmic_reg_read(dev, PFUZE100_REVID);
 	printf("PMIC: PFUZE100! DEV_ID=0x%x REV_ID=0x%x\n", dev_id, rev_id);
 
-
 	/* Init mode to APS_PFM */
 	pmic_reg_write(dev, PFUZE100_SW1ABMODE, APS_PFM);
 
diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
index 6b0665a1067..e5a0197e2fd 100644
--- a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
+++ b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
@@ -108,7 +108,6 @@ static iomux_v3_cfg_t const uart1_pads[] = {
 	MX6_PAD_UART1_RX_DATA__UART1_DCE_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
-
 static void setup_iomux_uart(void)
 {
 	imx_iomux_v3_setup_multiple_pads(uart1_pads, ARRAY_SIZE(uart1_pads));
@@ -352,7 +351,6 @@ void board_preboot_os(void)
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
 
-
 static struct mx6ul_iomux_grp_regs mx6_grp_ioregs = {
 	.grp_addds = 0x00000030,
 	.grp_ddrmode_ctl = 0x00020000,
diff --git a/board/freescale/p1010rdb/p1010rdb.c b/board/freescale/p1010rdb/p1010rdb.c
index ab0031440ae..e386840d9ef 100644
--- a/board/freescale/p1010rdb/p1010rdb.c
+++ b/board/freescale/p1010rdb/p1010rdb.c
@@ -622,7 +622,6 @@ void board_reset(void)
 }
 #endif
 
-
 int misc_init_r(void)
 {
 	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
diff --git a/board/freescale/t102xrdb/cpld.h b/board/freescale/t102xrdb/cpld.h
index bd40cc319a8..b504c3fcc47 100644
--- a/board/freescale/t102xrdb/cpld.h
+++ b/board/freescale/t102xrdb/cpld.h
@@ -23,7 +23,6 @@ struct cpld_data {
 	u8 boot_config2;	/* 0x1A - Boot config override register*/
 };
 
-
 /* Pointer to the CPLD register set */
 
 u8 cpld_read(unsigned int reg);
diff --git a/board/freescale/t104xrdb/eth.c b/board/freescale/t104xrdb/eth.c
index d5c084e319d..c35ec368a45 100644
--- a/board/freescale/t104xrdb/eth.c
+++ b/board/freescale/t104xrdb/eth.c
@@ -84,7 +84,6 @@ int board_eth_init(struct bd_info *bis)
 							DEFAULT_FM_MDIO_NAME));
 	}
 
-
 	cpu_eth_init(bis);
 #endif
 
diff --git a/board/freescale/t208xqds/t208xqds_qixis.h b/board/freescale/t208xqds/t208xqds_qixis.h
index 0f9a45a6fd4..66651422031 100644
--- a/board/freescale/t208xqds/t208xqds_qixis.h
+++ b/board/freescale/t208xqds/t208xqds_qixis.h
@@ -11,7 +11,6 @@
 #define QIXIS_SRDS1CLK_122		0x5a
 #define QIXIS_SRDS1CLK_125		0x5e
 
-
 /* BRDCFG4[4:7]] select EC1 and EC2 as a pair */
 #define BRDCFG4_EMISEL_MASK             0xE0
 #define BRDCFG4_EMISEL_SHIFT            5
diff --git a/board/freescale/t208xqds/tlb.c b/board/freescale/t208xqds/tlb.c
index f99d51c8cd7..a4cc532acda 100644
--- a/board/freescale/t208xqds/tlb.c
+++ b/board/freescale/t208xqds/tlb.c
@@ -81,7 +81,6 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 		      0, 5, BOOKE_PAGESZ_256M, 1),
 
-
 	/* *I*G* - PCIe 4, 0xc0000000 */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE4_MEM_VIRT, CFG_SYS_PCIE4_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
diff --git a/board/freescale/t208xrdb/tlb.c b/board/freescale/t208xrdb/tlb.c
index df5831541f3..a9a03908dfb 100644
--- a/board/freescale/t208xrdb/tlb.c
+++ b/board/freescale/t208xrdb/tlb.c
@@ -81,7 +81,6 @@ struct fsl_e_tlb_entry tlb_table[] = {
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
 		      0, 5, BOOKE_PAGESZ_256M, 1),
 
-
 	/* *I*G* - PCIe 4, 0xc0000000 */
 	SET_TLB_ENTRY(1, CFG_SYS_PCIE4_MEM_VIRT, CFG_SYS_PCIE4_MEM_PHYS,
 		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
diff --git a/board/freescale/t4rdb/ddr.c b/board/freescale/t4rdb/ddr.c
index 5b60b50c672..bbe31d4a54e 100644
--- a/board/freescale/t4rdb/ddr.c
+++ b/board/freescale/t4rdb/ddr.c
@@ -39,7 +39,6 @@ void fsl_ddr_board_options(memctl_options_t *popts,
 	else
 		pbsp = udimms[0];
 
-
 	/* Get clk_adjust, cpo, write_data_delay,2T, according to the board ddr
 	 * freqency and n_banks specified in board_specific_parameters table.
 	 */
diff --git a/board/freescale/t4rdb/ddr.h b/board/freescale/t4rdb/ddr.h
index 74a27796114..241b13475da 100644
--- a/board/freescale/t4rdb/ddr.h
+++ b/board/freescale/t4rdb/ddr.h
@@ -73,5 +73,4 @@ static const struct board_specific_parameters *rdimms[] = {
 	rdimm0,
 };
 
-
 #endif
diff --git a/board/freescale/vf610twr/vf610twr.c b/board/freescale/vf610twr/vf610twr.c
index 80a798af9cb..bfb49ad8604 100644
--- a/board/freescale/vf610twr/vf610twr.c
+++ b/board/freescale/vf610twr/vf610twr.c
@@ -214,7 +214,6 @@ static void setup_iomux_nfc(void)
 }
 #endif
 
-
 static void setup_iomux_qspi(void)
 {
 	static const iomux_v3_cfg_t qspi0_pads[] = {
-- 
2.43.0

