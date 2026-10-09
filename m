Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34124CA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F34E460672;
	Fri,  9 Oct 2026 22:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFRjFnDamA7u; Fri,  9 Oct 2026 22:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91A64608C3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583940;
	b=qBVgaJxVuuwVV8OP7Ut8B3CEYf94PIfsxfnkUn3f0b34wyHwJ99wxwrvg/cI1mb0p0yj
	 MXsiF96h1MqL+fCZvyYSs3f/cE5BSq74F/PTGMMf4wEbncfhb4WSyFvs3kVLcdtiQx62K
	 BR3rl6nVwFrysktJP2QNrv+WkeqU7AunjuJLapIELfQdUFQEixrpkSsLSXew3DwTqeg+L
	 iSyRLAWKJmKGqcb+VIQ0wvFPpdSS2jQDEB3ZJowjRKA5WVVA4brtfwSD4E/p+P0ZKxq9w
	 OEDoMyctBmIusjXd92vGbddp4JVjnxf274S/hHVUQjZ32SbpfDk52zkBg3vPjlivCOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ae9+/kevOO6JqsA5BaZFVyyPaKNHXdifPwvAlnOtgiU=;
	b=lN2r3PjeHZ8Npu1LGJExqLhTI9LKspKUIuqgLoCGJGLfksi/ACpDcwCVAcgghPbgL9dM
	 6VGgjOLDNfgJBdRlgyUOo7gGhp3cRK7KgudNAY6xgrNPWwaHsA5lvqlf8lfrAC33qX5Jw
	 UudYzNjJPGdNvKcRtPbsf3wqCQgB25mXGrL3m1gA9tD36GQrwXqTLqDFD/oVAgEDPcGoH
	 d2Yht/WR4ZQuF0D1tadF18cfm9bBi0i5CqFB1xD8T+F9HfCX3IT5HZiI8rD1JP+opKFsB
	 sD5zTCK4reFbyMGu9KwK68EtliqddpB/AWExqRGikZQ70yglJ5tEAT82sWOM4WWesFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="a/5Lsq1u";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=CDySosXm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583940;
	bh=Ae9+/kevOO6JqsA5BaZFVyyPaKNHXdifPwvAlnOtgiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vlZ2hSuNRDsWU9H31nXTruyTsKUZDXmd37RyxyMYrh17VVXo9/egGo1SKULaV3Z3V
	 Yt5cvH3TKav51WFWleqCnO0/xdtKjaIg/u+9eQdXrlT5oATYqVbc1lb+1aewcN9XVe
	 PuHVFjjW21mWAde0oUtXSkkuw11a45nJV0erCqDB7o+mayNryJjPFOfQd+sqbcdBm8
	 18tforDKqPXKiHF/iDUHt4O3DoxfXIYnyqpFCkA8hSsyDiLtyUt9LZSw9P1BphcFSQ
	 1IoosxTgExrsSxqaZ4/TJaC3xqF2knE8z+NauhZp38AOd8hqC31Zs7lJG2oBRHmHUo
	 8hegrtin9r25Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91A64608C3;
	Fri,  9 Oct 2026 22:12:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 13C13317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id EDD4D606F8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 79hEjhDfO7sN for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C5FE60672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583829;
 b=ZkgD+BcllLxRf5jyMyN7lOp5E8mzwmE2Is28PBaqcuDf/qNRfkID/8biaZRvErRcp5V5
 IIosASC94Xo9slksWxF3LF4Sq7xmrYNcWnRY6QkBbPL0R2a/R52yNz9/115FdHIAftmV+
 0IBMep1D0a9anRtP29KgCoOXh0OjekwqbEBBn8GFAxrm/EOtf7s4EZpq09AgBuU93Aq3Y
 xmOJER/29DtUhAsqDWEHgW7T1kc/4eVj46j1sVzbc3hb8wMD9Wosoa7UcYzTTte8xcBXt
 oPPtpiOnPv4z1t8WrR6WQ/aD0lyT1LSRARVTqSKXyiRbV0yMh4VIU3a9WypHodA2GEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583829;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Ae9+/kevOO6JqsA5BaZFVyyPaKNHXdifPwvAlnOtgiU=;
 b=cihoFC6a8HVvPs/7DA3xZPOemxmji0mMrkel982KSdB5WmItOohLrSUfLfDkTScDZ1ti
 LAJj0c5V7+V1Q5ZQP+WiZT0HXfpa9y5tdDbAclS830iBVl3quSiuYHqYKXu/cxTuJT3K1
 56wWxyHwwl0YUKMssrfd5EzJlOCZa4iPBdTpJYtpLMcqhmxUAfTqnQmZNVIfRgPChqyLT
 w/9SzWY0T2o0F7R7GHfLCYoPMytSRj1Jy35A5024KyEkh40SlI00qEIWxOXlRZA0qA8C8
 r8fd/QpfLNMw8Vmj3syJdWAVGntdRFoD592qRrqr2Hwpg5ObC6Y7B+eUYb47oNPaB1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="a/5Lsq1u"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=CDySosXm; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=a/5Lsq1u; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=CDySosXm
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 5C5FE60672
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583825; bh=Ae9+/kevOO6JqsA5BaZFVyy
 PaKNHXdifPwvAlnOtgiU=; b=a/5Lsq1uWVsVwskXN9UFS+MOK3joCuUVE8pqzfK08AR8H3cdli
 LxHy+TbvPWOyILaibf+qLfYt9r5rax48hLfty+m4IDdvJXcPf2vQE4emZzZ3f09oLXporad/MDD
 XV0jf+3fsU5lmMS6ro+nQmANmTJxp+nyMfscqmCvJ7nwiq6R3CRQLbggfabxxLwrPMy+0LxMGdP
 lCkGE4IDVHZIXD7p1EFizh+BS7X2dC5XYZ3+7vhWW7j868Oz0XL5Q8F8m4GOrjIzIun0AymHh3c
 St7o26dQVCZEk16xbzCJkqWZ6xGL2p/7xVz9wmEuoADyfGP+LFstBIWZgQdIB2kp0jw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583825; bh=Ae9+/kevOO6JqsA5BaZFVyy
 PaKNHXdifPwvAlnOtgiU=; b=CDySosXmVvCnk4OZlLDDh3vqDzHGR+dk9eJCmbsH7tgKWn9+RG
 3Ahc7U7yYBKcbdnPiBYJEl41CIeJBWLeTECw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 19/26] powerpc: mpc85xx: Remove BSC9132 support
Date: Fri,  9 Oct 2026 22:10:09 +0000
Message-ID: <20261009221017.20385-20-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 22:11:54 +0000
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

No board in the tree selects ARCH_BSC9132, and the platform lacks
active community maintenance. Remove its SoC and SERDES configuration,
register code and errata paths.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                          |   5 +-
 arch/powerpc/cpu/mpc85xx/Kconfig          |  32 +------
 arch/powerpc/cpu/mpc85xx/Makefile         |   1 -
 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c | 101 ----------------------
 arch/powerpc/cpu/mpc8xxx/cpu.c            |   1 -
 arch/powerpc/include/asm/fsl_law.h        |   6 +-
 arch/powerpc/include/asm/immap_85xx.h     |  19 +---
 arch/powerpc/include/asm/processor.h      |   1 -
 board/nxp/common/sdhc_boot.c              |   2 +-
 boot/Kconfig                              |   2 +-
 drivers/ddr/fsl/Kconfig                   |   1 -
 drivers/mmc/Kconfig                       |   2 +-
 drivers/usb/common/fsl-errata.c           |   2 -
 13 files changed, 9 insertions(+), 166 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 4ce12613131..15e56ffb35a 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -286,9 +286,8 @@ config SYS_FSL_IFC_BANK_COUNT
 	depends on ARCH_LS1043A || ARCH_LS1046A || ARCH_LS2080A || \
 		ARCH_LS1088A || ARCH_LS1021A || ARCH_B4860 || ARCH_B4420 || \
 		ARCH_T4240 || ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || \
-		ARCH_T2080 || ARCH_P1010 || ARCH_BSC9131 || \
-		ARCH_BSC9132
-	default 3 if ARCH_BSC9131 || ARCH_BSC9132
+		ARCH_T2080 || ARCH_P1010 || ARCH_BSC9131
+	default 3 if ARCH_BSC9131
 	default 4 if ARCH_LS1043A || ARCH_LS1046A || ARCH_B4860 || \
 			ARCH_B4420 || ARCH_P1010
 	default 8 if ARCH_LS2080A || ARCH_LS1088A || ARCH_LS1021A || \
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index bcdeef59fe7..fe1592d75aa 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -297,30 +297,6 @@ config ARCH_BSC9131
 	imply CMD_NAND
 	imply CMD_REGINFO
 
-config ARCH_BSC9132
-	bool
-	select FSL_LAW
-	select SYS_FSL_DDR_VER_46
-	select SYS_FSL_ERRATUM_A004477
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_A005434
-	select SYS_FSL_ERRATUM_ESDHC111
-	select SYS_FSL_ERRATUM_I2C_A004447
-	select SYS_FSL_ERRATUM_IFC_A002769
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v22
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_IFC
-	imply CMD_EEPROM
-	imply CMD_MTDPARTS
-	imply CMD_NAND
-	imply CMD_PCI
-	imply CMD_REGINFO
-
 config ARCH_MPC8544
 	bool
 	select BTB
@@ -732,7 +708,6 @@ config MAX_CPUS
 		     ARCH_T1042 || \
 		     ARCH_T2080
 	default 2 if ARCH_B4420 || \
-		     ARCH_BSC9132 || \
 		     ARCH_P1020 || \
 		     ARCH_P1021 || \
 		     ARCH_P1024 || \
@@ -749,7 +724,6 @@ config MAX_CPUS
 config SYS_CCSRBAR_DEFAULT
 	hex "Default CCSRBAR address"
 	default	0xff700000 if	ARCH_BSC9131	|| \
-				ARCH_BSC9132	|| \
 				ARCH_MPC8544	|| \
 				ARCH_P1010	|| \
 				ARCH_P1020	|| \
@@ -891,7 +865,7 @@ config SYS_FSL_A004447_SVR_REV
 	hex
 	depends on SYS_FSL_ERRATUM_I2C_A004447
 	default 0x10 if ARCH_P1010
-	default 0x11 if ARCH_P2041 || ARCH_BSC9132
+	default 0x11 if ARCH_P2041
 
 config SYS_FSL_ERRATUM_IFC_A002769
 	bool
@@ -956,7 +930,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_T1040	|| \
 			ARCH_T1042
 	default 12 if	ARCH_BSC9131	|| \
-			ARCH_BSC9132	|| \
 			ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
@@ -1071,8 +1044,7 @@ config SYS_PPC_E500_DEBUG_TLB
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
 			ARCH_P2020
-	default 3 if	ARCH_P1010	|| \
-			ARCH_BSC9132
+	default 3 if	ARCH_P1010
 	help
 	  Select a temporary TLB entry to be used during boot to work
 	  around limitations in e500v1 and e500v2 external debugger
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 43a5b5b67a4..9b7c02eae5f 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
 obj-$(CONFIG_ARCH_B4420) += b4860_serdes.o
 obj-$(CONFIG_ARCH_B4860) += b4860_serdes.o
-obj-$(CONFIG_ARCH_BSC9132) += bsc9132_serdes.o
 obj-$(CONFIG_ARCH_T1040) += t1040_serdes.o
 obj-$(CONFIG_ARCH_T1042)	+= t1040_serdes.o
 obj-$(CONFIG_ARCH_T1024) += t1024_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c b/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
deleted file mode 100644
index 9ebb3d838fa..00000000000
--- a/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- * Author: Prabhakar Kushwaha <prabhakar@freescale.com>
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
-static u8 serdes1_cfg_tbl[][SRDS1_MAX_LANES] = {
-	 [0] = {NONE, NONE, NONE, NONE},
-	 [1] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	 [2] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	 [3] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	 [4] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	 [5] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	 [6] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	 [7] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	 [8] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	 [9] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[10] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[11] = {PCIE1, PCIE2, SGMII_TSEC1, SGMII_TSEC2},
-	[12] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[13] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[14] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[15] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[16] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[17] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[18] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[19] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[20] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[21] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[22] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	[23] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	[24] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	[25] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	[26] = {PCIE1, PCIE2, CPRI2, CPRI1},
-	[27] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[28] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[29] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[30] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[31] = {PCIE1, PCIE2, SGMII_TSEC1, CPRI1},
-	[32] = {PCIE1, PCIE2, SGMII_TSEC1, SGMII_TSEC2},
-	[33] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[34] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[35] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[36] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[37] = {PCIE1, SGMII_TSEC2, CPRI2, CPRI1},
-	[38] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[39] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[40] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[41] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[42] = {PCIE1, SGMII_TSEC2, SGMII_TSEC1, CPRI1},
-	[43] = {SGMII_TSEC1, SGMII_TSEC2, CPRI2, CPRI1},
-	[44] = {SGMII_TSEC1, SGMII_TSEC2, CPRI2, CPRI1},
-	[45] = {SGMII_TSEC1, SGMII_TSEC2, CPRI2, CPRI1},
-	[46] = {SGMII_TSEC1, SGMII_TSEC2, CPRI2, CPRI1},
-	[47] = {SGMII_TSEC1, SGMII_TSEC2, CPRI2, CPRI1},
-};
-
-int is_serdes_configured(enum srds_prtcl prtcl)
-{
-	if (!(serdes1_prtcl_map & (1 << NONE)))
-		fsl_serdes_init();
-
-	return (1 << prtcl) & serdes1_prtcl_map;
-}
-
-void fsl_serdes_init(void)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 pordevsr = in_be32(&gur->pordevsr);
-	u32 srds_cfg = (pordevsr & MPC85xx_PORDEVSR_IO_SEL) >>
-				MPC85xx_PORDEVSR_IO_SEL_SHIFT;
-	int lane;
-
-	if (serdes1_prtcl_map & (1 << NONE))
-		return;
-
-	debug("PORDEVSR[IO_SEL_SRDS] = %x\n", srds_cfg);
-
-	if (srds_cfg >= ARRAY_SIZE(serdes1_cfg_tbl)) {
-		printf("Invalid PORDEVSR[IO_SEL_SRDS] = %d\n", srds_cfg);
-		return;
-	}
-
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes1_cfg_tbl[srds_cfg][lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 3594c1e3de2..046ab063700 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -79,7 +79,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(T2081, T2081, 0),
 	CPU_TYPE_ENTRY(BSC9130, 9130, 1),
 	CPU_TYPE_ENTRY(BSC9131, 9131, 1),
-	CPU_TYPE_ENTRY(BSC9132, 9132, 2),
 	CPU_TYPE_ENTRY(BSC9232, 9232, 2),
 	CPU_TYPE_ENTRY(C291, C291, 1),
 	CPU_TYPE_ENTRY(C292, C292, 1),
diff --git a/arch/powerpc/include/asm/fsl_law.h b/arch/powerpc/include/asm/fsl_law.h
index d1cd7283971..bdef61bc80f 100644
--- a/arch/powerpc/include/asm/fsl_law.h
+++ b/arch/powerpc/include/asm/fsl_law.h
@@ -79,7 +79,7 @@ enum law_trgt_if {
 	LAW_TRGT_IF_PCI = 0x00,
 	LAW_TRGT_IF_PCI_2 = 0x01,
 	LAW_TRGT_IF_PCIE_1 = 0x02,
-#if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
+#if defined(CONFIG_ARCH_BSC9131)
 	LAW_TRGT_IF_OCN_DSP = 0x03,
 #else
 #if !defined(CONFIG_ARCH_P2020)
@@ -92,11 +92,7 @@ enum law_trgt_if {
 	LAW_TRGT_IF_PLATFORM_SRAM = 0x0a,
 	LAW_TRGT_IF_DDR_INTRLV = 0x0b,
 	LAW_TRGT_IF_RIO = 0x0c,
-#if defined(CONFIG_ARCH_BSC9132)
-	LAW_TRGT_IF_CLASS_DSP = 0x0d,
-#else
 	LAW_TRGT_IF_RIO_2 = 0x0d,
-#endif
 	LAW_TRGT_IF_DPAA_SWP_SRAM = 0x0e,
 	LAW_TRGT_IF_DDR = 0x0f,
 	LAW_TRGT_IF_DDR_2 = 0x16,	/* 2nd controller */
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index b646d24bc6b..e1167dbb3d7 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1726,7 +1726,7 @@ typedef struct ccsr_rcpm {
 #else
 typedef struct ccsr_gur {
 	u32	porpllsr;	/* POR PLL ratio status */
-#if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
+#if defined(CONFIG_ARCH_BSC9131)
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003f00
 #else
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003e00
@@ -1755,9 +1755,6 @@ typedef struct ccsr_gur {
 #if defined(CONFIG_ARCH_P1010)
 #define MPC85xx_PORDEVSR_IO_SEL		0x00600000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	21
-#elif defined(CONFIG_ARCH_BSC9132)
-#define MPC85xx_PORDEVSR_IO_SEL		0x00FE0000
-#define MPC85xx_PORDEVSR_IO_SEL_SHIFT	17
 #else
 #define MPC85xx_PORDEVSR_IO_SEL		0x00780000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	19
@@ -1892,10 +1889,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR_SPI1_CS3_ANT_TCXO_PWM	0x00000001
 #define MPC85xx_PMUXCR_SPI1_CS3_dbg_adi2_rxen	0x00000002
 #define MPC85xx_PMUXCR_SPI1_CS3_GPO76		0x00000003
-#endif
-#ifdef CONFIG_ARCH_BSC9132
-#define MPC85xx_PMUXCR0_SIM_SEL_MASK	0x0003b000
-#define MPC85xx_PMUXCR0_SIM_SEL		0x00014000
 #endif
 	u32	pmuxcr2;	/* Alt. function signal multiplex control 2 */
 #if defined(CONFIG_ARCH_P1010)
@@ -1923,7 +1916,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR2_DEBUG_MUX_SEL_USBPHY	0x00002000
 #define MPC85xx_PMUXCR2_PLL_LKDT_EXPOSE		0x00001000
 #endif
-#if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
 #if defined(CONFIG_ARCH_BSC9131)
 #define MPC85xx_PMUXCR2_UART_CTS_B0_SIM_PD		0x40000000
 #define MPC85xx_PMUXCR2_UART_CTS_B0_DSP_TMS		0x80000000
@@ -1967,9 +1959,7 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR2_ANT3_AGC_GPO53			0x00000004
 #define MPC85xx_PMUXCR2_ANT3_DO_TDM			0x00000001
 #define MPC85xx_PMUXCR2_ANT3_DO_GPIO46_49		0x00000002
-#endif
 	u32	pmuxcr3;
-#if defined(CONFIG_ARCH_BSC9131)
 #define MPC85xx_PMUXCR3_ANT3_DO4_5_TDM			0x40000000
 #define MPC85xx_PMUXCR3_ANT3_DO4_5_GPIO_50_51		0x80000000
 #define MPC85xx_PMUXCR3_ANT3_DO6_7_TRIG_IN_SRESET_B	0x10000000
@@ -1984,13 +1974,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR3_SPI2_CS3_GPO94			0x00040000
 #define MPC85xx_PMUXCR3_ANT2_AGC_RSVD			0x00010000
 #define MPC85xx_PMUXCR3_ANT2_GPO89			0x00030000
-#endif
-#ifdef CONFIG_ARCH_BSC9132
-#define MPC85xx_PMUXCR3_USB_SEL_MASK	0x0000ff00
-#define MPC85xx_PMUXCR3_UART2_SEL	0x00005000
-#define MPC85xx_PMUXCR3_UART3_SEL_MASK	0xc0000000
-#define MPC85xx_PMUXCR3_UART3_SEL	0x40000000
-#endif
 	u32 pmuxcr4;
 #else
 	u8	res6[8];
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b78a726445d..01228bee20f 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1072,7 +1072,6 @@
 
 #define SVR_9130	0x860001
 #define SVR_9131	0x860000
-#define SVR_9132	0x861000
 #define SVR_9232	0x861400
 
 #define SVR_Unknown	0xFFFFFF
diff --git a/board/nxp/common/sdhc_boot.c b/board/nxp/common/sdhc_boot.c
index 0c2532a8595..16b6f0fc343 100644
--- a/board/nxp/common/sdhc_boot.c
+++ b/board/nxp/common/sdhc_boot.c
@@ -45,7 +45,7 @@ int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 
 #ifdef CONFIG_ESDHC_HC_BLK_ADDR
 	/*
-	 * On soc BSC9131, BSC9132:
+	 * On P1010 and BSC9131:
 	 * In High Capacity SD Cards (> 2 GBytes), the 32-bit source address and
 	 * code length of these soc specify the memory address in block address
 	 * format. Block length is fixed to 512 bytes as per the SD High
diff --git a/boot/Kconfig b/boot/Kconfig
index 11b5036caad..0fc550c3e01 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1199,7 +1199,7 @@ config FSL_FIXED_MMC_LOCATION
 
 config ESDHC_HC_BLK_ADDR
 	def_bool y
-	depends on FSL_FIXED_MMC_LOCATION && (ARCH_BSC9131 || ARCH_BSC9132 || ARCH_P1010)
+	depends on FSL_FIXED_MMC_LOCATION && (ARCH_BSC9131 || ARCH_P1010)
 	help
 	  In High Capacity SD Cards (> 2 GBytes), the 32-bit source address and
 	  code length of these soc specify the memory address in block address
diff --git a/drivers/ddr/fsl/Kconfig b/drivers/ddr/fsl/Kconfig
index 91b439428ab..7a3aa7e2087 100644
--- a/drivers/ddr/fsl/Kconfig
+++ b/drivers/ddr/fsl/Kconfig
@@ -51,7 +51,6 @@ config SYS_NUM_DDR_CTLRS
 	default 3 if	ARCH_LS2080A	|| \
 			ARCH_T4240
 	default 2 if	ARCH_B4860	|| \
-			ARCH_BSC9132	|| \
 			ARCH_LX2160A	|| \
 			ARCH_LX2162A
 	default 1
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4eb5d80e336..671cae7aaf2 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -911,7 +911,7 @@ config FSL_SDHC_V2_3
 config FSL_ESDHC
 	bool "Freescale/NXP eSDHC controller support"
 	depends on ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3 || PPC
-	select FSL_SDHC_V2_3 if ARCH_P1010 || ARCH_BSC9131 || ARCH_BSC9132
+	select FSL_SDHC_V2_3 if ARCH_P1010 || ARCH_BSC9131
 	help
 	  This selects support for the eSDHC (Enhanced Secure Digital Host
 	  Controller) found on numerous Freescale/NXP SoCs.
diff --git a/drivers/usb/common/fsl-errata.c b/drivers/usb/common/fsl-errata.c
index 1b84614c8f5..09dc905abe7 100644
--- a/drivers/usb/common/fsl-errata.c
+++ b/drivers/usb/common/fsl-errata.c
@@ -155,7 +155,6 @@ bool has_erratum_a005697(void)
 	switch (soc) {
 #ifdef CONFIG_PPC
 	case SVR_9131:
-	case SVR_9132:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 1, 1);
 #endif
 #ifdef ONFIG_ARM64
@@ -177,7 +176,6 @@ bool has_erratum_a004477(void)
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0);
 	case SVR_P1022:
 	case SVR_9131:
-	case SVR_9132:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 1, 1);
 	case SVR_P2020:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0) ||
-- 
2.47.3

