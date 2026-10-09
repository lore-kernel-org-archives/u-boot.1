Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A25CCA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7140608B4;
	Fri,  9 Oct 2026 22:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wiLRKs6B0TP; Fri,  9 Oct 2026 22:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D93C60727
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583919;
	b=D+TSbMbcmZt1WaN7vq5CaowkTW3Vy4fzc4F5STZaZ00ZlmjEPhBPtG+UArEsow3LVCIR
	 ETfQ6qXVVVjJHFoMGrwUIOU6zbFWSQLpIkyRa1wpYc7egNX3AnM/2flysQ30gyWEUhuyR
	 A1GECnpwjM+hqXodLcld+VMNQUr6Y17+jsst973zJlvAIXh7Duh1rLtLXFhy7lI4k4MNZ
	 fpDLB8WxkTNqPUbxk5/0XHXr/VavFvDCQziPMZrsKtvWzB+k5Utpt4RZgN/AWKbO3JbVI
	 zh6jf7nSb8AVHLRMjI6hwKbzl9LhvrMfMQYrIp1uzyCJnlIUTJnbEIcpnScXNgzHmJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R5aeXFoXMzcYyLksVPjkYg07x/6GA/oXVjMNlM8N99s=;
	b=BOoxW5BOyEUp7ygs578nIeVrxxuYStz/6jG03PC7Nv1XdHSoFK3pKkRz8QjiggLkvuHT
	 WbkQsL4yQU4JjDh5JFaVVwHgn97zsxB/mXYJhwRqw1s0akkL/Tstky61bbACwDcsvkStB
	 MnBOOMOVhDgMb866tDPoIL+XfNzsRZdX0oWTS8pj12t5s3kjELT7Kp/wsfRmJlxwwZOYk
	 WxB2XnP1Zv9hfMD+neE5bwHjDNV5j8pTyPPigmVJgQMK1ObO6ka1VXYU1DoRaIGXFWa0a
	 Vt7DCN2uzpL95eyojKjebTjJWT5rBPJdpBkrJTcdlUDB5EwCf5MpXXvAOh0LbE375Hg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583919;
	bh=R5aeXFoXMzcYyLksVPjkYg07x/6GA/oXVjMNlM8N99s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oH+nPbU8UOGFlSuqQSkbFTSbSHCB0hSxvFY2TgDkByB8lroqe3wK88jihLocLUVL0
	 RTTwSiToFHBntbovXskSmpjAGv/B8/Xi5vto2iauCoJhCEDlKWwLY+SG7EzC0eVfX3
	 P4zuOPTWChmwHyBUkFgKOA1FqZhnMWf4vD+d345YVS7qU2IG19F3waEBpDrfTLRZh3
	 Usyz0isuhTuRv3Y6OOiGiCVWkmXv27JtMdLih/IYd5gfqixWEnYYZ6ssRbk4VBkCeF
	 dMhDR2DOdpcOanND8W0rxxwShxhYlWvXgLm6sZZlVJcpzxanGtTODi0npklDnM2pok
	 moVZh+SDBPbxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D93C60727;
	Fri,  9 Oct 2026 22:11:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 81638317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 731EB812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id XFfYwSyYo8Oa for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 179DC8123E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583825;
 b=bxzK7fW/FqiznP+IRgNucNSe7qkhZQOA1cd1vsFMsxfR0WGawHwN8pRFUjW2nfgCa6a7
 g+FmNkw7+6KjveBZVYkqUBKQSotZA35iHJ8Y5ySX+ealICeeS6H+/D+Yv3mp8B0yV0R+i
 bOilyPQYfnGZqu2IvK0tV6xrzMjaZWSEaj5xd8G3hrDETMiaSRD5QQ8sAJiMQZL3Bp9bv
 2Z9eYrkvsOMBHlwCcdb8x61amBw+fKsTGFPf8yN/uFiWOSQ9RJ9XjjzYSfa4VLUDfjld7
 +Yl4ecNFHu850VFy0dNfiaWdOfZe6UsA3aVs+MQglINIcA818N5h4j4JSFdBxSVWTlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583825;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=R5aeXFoXMzcYyLksVPjkYg07x/6GA/oXVjMNlM8N99s=;
 b=StbLjn/hqBc+TceX6dGfS6TT8YV5MKXrHY2C8zrNYbv4FUx6OEFg6pFrNKvcucASpzM9
 ouie+/MuJr5Jv2ZPzEden7TswbawXCurBQuwlYKdNYZsBhXRL/Q3gmVzm814NoNmh24Sk
 UHPxRIST+KAalaktu1FEEsRvETmGc229CcUxNaYzH64GoqfjfxNSJMPJFHTEM63L5Xltw
 vtiQIMlf694W6DF5sWJb917dZi6SlPSJQGK+iCnlbBp9uum5PgTF4SvhGUqPULEXd8wyP
 f3Yy8QIq9r9HQsDViZ53RuDKSW70uWcgZH2QKIX8W34x1NbAFbEM7PfbBOqWyt2Go9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=a6ES35JR; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Os68BKvI; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=a6ES35JR; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Os68BKvI
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 179DC8123E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583822; bh=R5aeXFoXMzcYyLksVPjkYg0
 7x/6GA/oXVjMNlM8N99s=; b=a6ES35JRhO1E8VkADEkIXzfoRAhHHUImQpgIbbrElgwxrwEkIS
 CqhparLB9BqW67sKsGZGWjyZhPaMHO3ChFvb78UypqSLYMfGqRLfqniwbleoBP5Nttivq63t5Yp
 uIJUfx+amkA6YAHeUixaN+BA6pv54JDEZV3reSgWaRbzbGKGmmdiKdu0E6zAL1NADkPgEktIs34
 Hutinz8KcMLSHkCk/y0RiXpGAfUXh6SLoMovuZw1UtWud32I8oikH10RYjp2CuO1SVgCD4fsmE8
 v7hp1R0wObSjsOa+nMxVbeSGt7nmYdBBQw5ol/DYwHOtJ1rDiRvaPva+7h+TM7BPDaw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583822; bh=R5aeXFoXMzcYyLksVPjkYg0
 7x/6GA/oXVjMNlM8N99s=; b=Os68BKvIr2l6yL4oCEX5vbbOS9/TG6tVoLrgYN7WY9XmsNCXIb
 oenFwI8SBkDwGZUIktYMvOpRsaRRNZtqjQCw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 12/26] powerpc: mpc85xx: Remove C29x support
Date: Fri,  9 Oct 2026 22:10:02 +0000
Message-ID: <20261009221017.20385-13-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 22:11:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

No board in the tree selects ARCH_C29X, and the family lacks active
community maintenance. Remove the unused platform support and its
C29x specific crypto, clocking and SERDES setup.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                          |  4 +-
 arch/powerpc/cpu/mpc85xx/Kconfig          | 22 +------
 arch/powerpc/cpu/mpc85xx/Makefile         |  1 -
 arch/powerpc/cpu/mpc85xx/c29x_serdes.c    | 70 -----------------------
 arch/powerpc/cpu/mpc85xx/cpu_init.c       | 11 ----
 arch/powerpc/include/asm/config_mpc85xx.h |  3 -
 arch/powerpc/include/asm/immap_85xx.h     | 22 -------
 arch/powerpc/include/asm/processor.h      |  3 -
 drivers/crypto/fsl/jr.c                   | 14 +----
 drivers/mmc/Kconfig                       |  3 +-
 include/fsl_sec.h                         |  3 -
 11 files changed, 7 insertions(+), 149 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/c29x_serdes.c

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 8b8210224b5..4ce12613131 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -286,14 +286,14 @@ config SYS_FSL_IFC_BANK_COUNT
 	depends on ARCH_LS1043A || ARCH_LS1046A || ARCH_LS2080A || \
 		ARCH_LS1088A || ARCH_LS1021A || ARCH_B4860 || ARCH_B4420 || \
 		ARCH_T4240 || ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || \
-		ARCH_T2080 || ARCH_C29X || ARCH_P1010 || ARCH_BSC9131 || \
+		ARCH_T2080 || ARCH_P1010 || ARCH_BSC9131 || \
 		ARCH_BSC9132
 	default 3 if ARCH_BSC9131 || ARCH_BSC9132
 	default 4 if ARCH_LS1043A || ARCH_LS1046A || ARCH_B4860 || \
 			ARCH_B4420 || ARCH_P1010
 	default 8 if ARCH_LS2080A || ARCH_LS1088A || ARCH_LS1021A || \
 			ARCH_T4240 || ARCH_T1040 || ARCH_T1042 || \
-			ARCH_T1024 || ARCH_T2080 || ARCH_C29X
+			ARCH_T1024 || ARCH_T2080
 
 config FSL_QIXIS
 	bool "Enable QIXIS support"
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 32461cfae50..b1b134ca990 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -321,23 +321,6 @@ config ARCH_BSC9132
 	imply CMD_PCI
 	imply CMD_REGINFO
 
-config ARCH_C29X
-	bool
-	select FSL_LAW
-	select SYS_FSL_DDR_VER_46
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_ESDHC111
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_6
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_IFC
-	imply CMD_NAND
-	imply CMD_PCI
-	imply CMD_REGINFO
-
 config ARCH_MPC8536
 	bool
 	select FSL_LAW
@@ -843,7 +826,6 @@ config SYS_CCSRBAR_DEFAULT
 	hex "Default CCSRBAR address"
 	default	0xff700000 if	ARCH_BSC9131	|| \
 				ARCH_BSC9132	|| \
-				ARCH_C29X	|| \
 				ARCH_MPC8536	|| \
 				ARCH_MPC8540	|| \
 				ARCH_MPC8544	|| \
@@ -1057,7 +1039,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_T1042
 	default 12 if	ARCH_BSC9131	|| \
 			ARCH_BSC9132	|| \
-			ARCH_C29X	|| \
 			ARCH_MPC8536	|| \
 			ARCH_P1010	|| \
 			ARCH_P1011	|| \
@@ -1182,8 +1163,7 @@ config SYS_PPC_E500_DEBUG_TLB
 			ARCH_P1025	|| \
 			ARCH_P2020
 	default 3 if	ARCH_P1010	|| \
-			ARCH_BSC9132	|| \
-			ARCH_C29X
+			ARCH_BSC9132
 	help
 	  Select a temporary TLB entry to be used during boot to work
 	  around limitations in e500v1 and e500v2 external debugger
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index b4bca7bbe6b..93b0c28ca03 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -51,7 +51,6 @@ obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS1) += fsl_corenet_serdes.o
 obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS2) += fsl_corenet2_serdes.o
 
 # SoC specific SERDES support
-obj-$(CONFIG_ARCH_C29X)	+= c29x_serdes.o
 obj-$(CONFIG_ARCH_MPC8536) += mpc8536_serdes.o
 obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/c29x_serdes.c b/arch/powerpc/cpu/mpc85xx/c29x_serdes.c
deleted file mode 100644
index bbe4a0dd62b..00000000000
--- a/arch/powerpc/cpu/mpc85xx/c29x_serdes.c
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <log.h>
-#include <asm/io.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_serdes.h>
-
-#define SRDS1_MAX_LANES		4
-
-static u32 serdes1_prtcl_map;
-
-struct serdes_config {
-	u32 protocol;
-	u8 lanes[SRDS1_MAX_LANES];
-};
-
-static const struct serdes_config serdes1_cfg_tbl[] = {
-	/* SerDes 1 */
-	{1, {PCIE1, PCIE1, PCIE1, PCIE1} },
-	{2, {PCIE1, PCIE1, PCIE1, PCIE1} },
-	{3, {PCIE1, PCIE1, NONE, NONE} },
-	{4, {PCIE1, PCIE1, NONE, NONE} },
-	{5, {PCIE1, NONE, NONE, NONE} },
-	{6, {PCIE1, NONE, NONE, NONE} },
-	{}
-};
-
-int is_serdes_configured(enum srds_prtcl device)
-{
-	if (!(serdes1_prtcl_map & (1 << NONE)))
-		fsl_serdes_init();
-
-	return (1 << device) & serdes1_prtcl_map;
-}
-
-void fsl_serdes_init(void)
-{
-	ccsr_gur_t *gur = (void *)CFG_SYS_MPC85xx_GUTS_ADDR;
-	u32 pordevsr = in_be32(&gur->pordevsr);
-	u32 srds_cfg = (pordevsr & MPC85xx_PORDEVSR_IO_SEL) >>
-				MPC85xx_PORDEVSR_IO_SEL_SHIFT;
-	const struct serdes_config *ptr;
-	int lane;
-
-	if (serdes1_prtcl_map & (1 << NONE))
-		return;
-
-	debug("PORDEVSR[IO_SEL_SRDS] = %x\n", srds_cfg);
-
-	if (srds_cfg > ARRAY_SIZE(serdes1_cfg_tbl)) {
-		printf("Invalid PORDEVSR[IO_SEL_SRDS] = %d\n", srds_cfg);
-		return;
-	}
-
-	ptr = &serdes1_cfg_tbl[srds_cfg];
-	if (!ptr->protocol)
-		return;
-
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = ptr->lanes[lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index e7e9b3dbd1c..710b3b31354 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -881,17 +881,6 @@ int cpu_init_r(void)
 	pamu_init();
 #endif
 
-#ifdef CONFIG_FSL_CAAM
-#if defined(CONFIG_ARCH_C29X)
-	if ((SVR_SOC_VER(svr) == SVR_C292) ||
-	    (SVR_SOC_VER(svr) == SVR_C293))
-		sec_init_idx(1);
-
-	if (SVR_SOC_VER(svr) == SVR_C293)
-		sec_init_idx(2);
-#endif
-#endif
-
 #if defined(CONFIG_FSL_SATA_V2) && defined(CONFIG_SYS_FSL_ERRATUM_SATA_A001)
 	/*
 	 * For P1022/1013 Rev1.0 silicon, after power on SATA host
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index e5890376df8..f115dcce76a 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -126,9 +126,6 @@
 #define CFG_SYS_FM1_CLK		0
 #define CFG_SYS_FM_MURAM_SIZE	0x28000
 
-#elif defined(CONFIG_ARCH_C29X)
-#define CFG_SYS_FSL_SEC_IDX_OFFSET	0x20000
-
 #endif
 
 #endif /* _ASM_MPC85xx_CONFIG_H_ */
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index a9336d73f20..489fcd43351 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1768,11 +1768,6 @@ typedef struct ccsr_gur {
 #ifdef CONFIG_ARCH_MPC8536
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x3e000000
 #define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	25
-#elif defined(CONFIG_ARCH_C29X)
-#define MPC85xx_PORPLLSR_DDR_RATIO	0x00003f00
-#define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	(9 - ((gur->pordevsr2 \
-					& MPC85xx_PORDEVSR2_DDR_SPD_0) \
-					>> MPC85xx_PORDEVSR2_DDR_SPD_0_SHIFT))
 #else
 #if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003f00
@@ -1817,9 +1812,6 @@ typedef struct ccsr_gur {
 #elif defined(CONFIG_ARCH_BSC9132)
 #define MPC85xx_PORDEVSR_IO_SEL		0x00FE0000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	17
-#elif defined(CONFIG_ARCH_C29X)
-#define MPC85xx_PORDEVSR_IO_SEL		0x00e00000
-#define MPC85xx_PORDEVSR_IO_SEL_SHIFT	21
 #else
 #define MPC85xx_PORDEVSR_IO_SEL		0x00780000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	19
@@ -1835,10 +1827,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PORDEVSR_RIO_DEV_ID	0x00000007
 	u32	pordbgmsr;	/* POR debug mode status */
 	u32	pordevsr2;	/* POR I/O device status 2 */
-#if defined(CONFIG_ARCH_C29X)
-#define MPC85xx_PORDEVSR2_DDR_SPD_0	0x00000008
-#define MPC85xx_PORDEVSR2_DDR_SPD_0_SHIFT	3
-#endif
 #define MPC85xx_PORDEVSR2_SBC_MASK	0x10000000
 /* The 8544 RM says this is bit 26, but it's really bit 24 */
 #define MPC85xx_PORDEVSR2_SEC_CFG	0x00000080
@@ -1972,11 +1960,6 @@ typedef struct ccsr_gur {
 #ifdef CONFIG_ARCH_BSC9132
 #define MPC85xx_PMUXCR0_SIM_SEL_MASK	0x0003b000
 #define MPC85xx_PMUXCR0_SIM_SEL		0x00014000
-#endif
-#if defined(CONFIG_ARCH_C29X)
-#define MPC85xx_PMUXCR_SPI_MASK			0x00000300
-#define MPC85xx_PMUXCR_SPI			0x00000000
-#define MPC85xx_PMUXCR_SPI_GPIO			0x00000100
 #endif
 	u32	pmuxcr2;	/* Alt. function signal multiplex control 2 */
 #if defined(CONFIG_ARCH_P1010)
@@ -2515,13 +2498,8 @@ struct ccsr_pman {
 #define CFG_SYS_MPC85xx_USB2_PHY_OFFSET	0xE5100
 #define CFG_SYS_MDIO1_OFFSET			0x24000
 #define CFG_SYS_MPC85xx_ESDHC_OFFSET		0x2e000
-#if defined(CONFIG_ARCH_C29X)
-#define CFG_SYS_FSL_SEC_OFFSET		0x80000
-#define CFG_SYS_FSL_JR0_OFFSET               0x81000
-#else
 #define CFG_SYS_FSL_SEC_OFFSET		0x30000
 #define CFG_SYS_FSL_JR0_OFFSET               0x31000
-#endif
 #define CFG_SYS_MPC85xx_SERDES2_OFFSET	0xE3100
 #define CFG_SYS_MPC85xx_SERDES1_OFFSET	0xE3000
 #define CFG_SYS_SEC_MON_OFFSET		0xE6000
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 306dfd01346..1d6f960be94 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1056,9 +1056,6 @@
 #define SVR_T4120	0x824001
 #define SVR_T4160	0x824100
 #define SVR_T4080	0x824102
-#define SVR_C291	0x850000
-#define SVR_C292	0x850020
-#define SVR_C293	0x850030
 #define SVR_B4860	0x868000
 #define SVR_G4860	0x868001
 #define SVR_B4460	0x868003
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 3a5032bcaf6..ed69ba92750 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -30,22 +30,14 @@
 #define CIRC_CNT(head, tail, size)	(((head) - (tail)) & (size - 1))
 #define CIRC_SPACE(head, tail, size)	CIRC_CNT((tail), (head) + 1, (size))
 
-uint32_t sec_offset[CONFIG_SYS_FSL_MAX_NUM_OF_SEC] = {
-	0,
-#if defined(CONFIG_ARCH_C29X)
-	CFG_SYS_FSL_SEC_IDX_OFFSET,
-	2 * CFG_SYS_FSL_SEC_IDX_OFFSET
-#endif
-};
-
 #if CONFIG_IS_ENABLED(DM)
 struct udevice *caam_dev;
 #else
 #define SEC_ADDR(idx)	\
-	(ulong)((CFG_SYS_FSL_SEC_ADDR + sec_offset[idx]))
+	(ulong)CFG_SYS_FSL_SEC_ADDR
 
 #define SEC_JR0_ADDR(idx)	\
-	(ulong)(SEC_ADDR(idx) +	\
+	(ulong)(CFG_SYS_FSL_SEC_ADDR +	\
 	 (CFG_SYS_FSL_JR0_OFFSET - CFG_SYS_FSL_SEC_OFFSET))
 struct caam_regs caam_st;
 #endif
@@ -688,7 +680,7 @@ static void jr_setown_non_trusted(ccsr_sec_t *sec)
 }
 #endif
 
-int sec_init_idx(uint8_t sec_idx)
+static int sec_init_idx(uint8_t sec_idx)
 {
 	int ret = 0;
 	struct caam_regs *caam;
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index b3731dfe4a1..4eb5d80e336 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -911,8 +911,7 @@ config FSL_SDHC_V2_3
 config FSL_ESDHC
 	bool "Freescale/NXP eSDHC controller support"
 	depends on ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3 || PPC
-	select FSL_SDHC_V2_3 if ARCH_P1010 || ARCH_BSC9131 || ARCH_BSC9132 \
-		|| ARCH_C29X
+	select FSL_SDHC_V2_3 if ARCH_P1010 || ARCH_BSC9131 || ARCH_BSC9132
 	help
 	  This selects support for the eSDHC (Enhanced Secure Digital Host
 	  Controller) found on numerous Freescale/NXP SoCs.
diff --git a/include/fsl_sec.h b/include/fsl_sec.h
index 8c5e59c5b1c..4b769759593 100644
--- a/include/fsl_sec.h
+++ b/include/fsl_sec.h
@@ -374,9 +374,6 @@ int gen_mppubk(u8 *dst);
 
 int sign_mppubk(const u8 *m, int data_size, u8 *dgst, u8 *c, u8 *d);
 
-#if defined(CONFIG_ARCH_C29X)
-int sec_init_idx(uint8_t);
-#endif
 int sec_init(void);
 
 u8 caam_get_era(void);
-- 
2.47.3

