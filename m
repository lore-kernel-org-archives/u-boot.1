Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A3606A552
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N/BLY+k2;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=o0sZPpoG;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=o3SPYB9c
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10B70608FE;
	Wed, 21 Oct 2026 16:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cO2m0BSBRoHY; Wed, 21 Oct 2026 16:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 270476090B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599381;
	b=ba9DQbQZZIpII0ynIojka+96DXjD6vsIQ1QqYCq1Lk56H7wxG2+H9796ULZvsvBSynZl
	 LVdn6S/ya2ZkjnSVeR5i3SMcKoK+CdoffTJqSADzjDzLOBm+kBlwt0wJSoN7GTv0fQZ0L
	 Xvby++gK6FUryCJPhHKWbK2VAl8tPShmUOEbX65SW7v1ScVTzIaOsv5hRc41ZM1NWvXGG
	 v/KQKrRf+vRXXCgA44ueBc2GcljOSz8N2JXq2czWdk16LxXZ07coQu6O10vEzQVRO+lDu
	 3XssM3DnPxkX5F997V7zQlbfx7PUeYjOsStSYBTxN+sjQbiVCtxtRNKIBOkbVyF/UqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VdDJV3N0HgyOMm8iD1nz2aklWozylhDV0eP+PM53CA4=;
	b=KvGTTBEDjwdMJcKQKIHIRN5wIW/6+TpOMx5qPlpcIYujCsEx+Md8Skhrdoj/WehR2ZU/
	 F7dnwRMemQErCtRmhIUFwEwlxyPyamJBNBN3y0ZYnieGEI4BYenzUMAGpscsWZUieMJY6
	 6a9AMpeMVF5P8fGh5jpAWibnluEA8RP8avira5OepEDdd2fMhq08lM7OrUNs0H7urZcUt
	 OZBYzDhz90LLOhCHUSeQV3+WMNKd+4p1boJztApeanwQCUYdmM7oV7h3xLwHI4KU/C2Y7
	 4CZNLoTYSrgpB7365+3jNSfjOnLR0SL1Dadea02LpL9X2dPSd6F/EYhu2Msa9UYbg2g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599381;
	bh=VdDJV3N0HgyOMm8iD1nz2aklWozylhDV0eP+PM53CA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/BLY+k2dAC6XcArFAYF6OGwUMXdbRBTSpsk2P6VsxDm8hOVYv1RtYg0Azm4xwuB9
	 9p1vgqYWCRl4zBmmpJ0jOdKRxvmOSdpkNC7M6lHrBYum8Ov9qrZEYSgoxLwAkw3Tpr
	 ViFbvlLwSBDsX7gXNtYShAL1mWoXj8v2vXSlFClDHFQGVRP1jO209Ft9WI21T3x+GZ
	 cuDLRZqWlgIy2gwekbdxMsdCEX3K+6V0gZu4yHMs3NHeOUON06BiJ+3MaoNsEEMyy3
	 1lfcFLmgdMdoCvbQycmJ2XC+PxuHB4nxvWUrpEQFe77Ac3fOqgnA5r7xtUDCFnnlDY
	 vUctn/lUpZV6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 270476090B;
	Wed, 21 Oct 2026 16:16:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 0FB2C3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 0D7FF4084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id ixFedwF1lzse for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EB1840879
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598516;
 b=IKdUt1jADVoewKwbitjFr92p62kltvQjgyf7RYjT0ljkRCXq/zcUPNrpIkPhztxrUQmY
 HsoZCN6k6BScw7NXaoUeoPgazK/9Dch0GEJwahi+/p1b7IfTxyxqXbDw0avCj4G+mCcu4
 9kIT3p2WFb5BQH6ztSbeRxiauSFVlwxuiKmeEAag/6LI1NPVkXeQ3vH19NhgTN0CWDjCR
 /AEGYZs0pqTOTUvxlIt62gf6Cs/KegqY9R4PkhyWUXQ5iXJhNfuVNt/2qdGHYTYQe/dgk
 17zpf1ka2I54vW9EQnJsY+LheEt9LS/5qr8QhI599Pb9pyanJ3zCZeNSBFDnes3pT4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598516;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VdDJV3N0HgyOMm8iD1nz2aklWozylhDV0eP+PM53CA4=;
 b=qoSFAT19M51F9hlFpzKtCnqv7jcuJvPDi7J/mg2AFol7qQAFsR+0NAcMHR9So+9WShWN
 Nz0VFSUwoCSig3fqOMf0P9kl61dTxDQX9u0pCADEcaHfaD4rj2iOhgY6GDwOdleptIUIN
 ItE+zjTWaVlpzmPtFZJKxxY9Gi8QtD0M3DCUn7660kP6CNz0AyFmzKK+xh/9p+RzjvqK2
 xpPHRJaUQgTHMEXCRBt3G613kjOVbeig2APc1uaBDIDrITzoal6IYc+kM/SNyVDM1l56h
 xLmx86l01VViE0RNv2V9hBoddad0hv7sNEmATr8UXClHktXKgDIvjnPqW6aDuaURf6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=o0sZPpoG; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=o3SPYB9c; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=o0sZPpoG; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=o3SPYB9c
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 9EB1840879
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598511; bh=VdDJV3N0HgyOMm8iD1nz2ak
 lWozylhDV0eP+PM53CA4=; b=o0sZPpoG2IqWumErakppNKEqf2W0rAleP3zWXIKSgSp5uLlyMG
 hVKJNKuT7j36tIbEOQyC3+68WVeYak8MMLlb08NVw1i7yl1Gam4ihLzxJa7gWcE/V0hPsqhKWHL
 +ZY+pUPxfCxE7aWflu/PBRiy3f0jCoyHPmFa6y1sKKg2PnZYtOY0q5OV432uYnVOwaTTOsBVYgC
 v47txFjYND1EbOQI0NHOUDuNWCkk680h+E9l9ib6Hs22JXaNtgOd3caEzMaagJDdrEO0jwoR6i7
 coQsp/68zHktEysXPK0jWDXkoxEiHW2MYGyiLCnphjiKoJD/xTaWmpGULncc/Sooavg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598511; bh=VdDJV3N0HgyOMm8iD1nz2ak
 lWozylhDV0eP+PM53CA4=; b=o3SPYB9cN6tzPOzEwVUCN+/natO6XnwpjyUIYa8cDmTo1NAQPW
 UzYpU/7KloumlvcxS0GABxu5x+8/K+GqyNCw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 14/26] powerpc: mpc85xx: Remove P1023 support
Date: Wed, 21 Oct 2026 16:01:10 +0000
Message-ID: <20261021160145.10430-15-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No board in the tree selects ARCH_P1023, and the family is unmaintained.
Remove the unused SoC, FMan, and SERDES support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig          | 19 +-----
 arch/powerpc/cpu/mpc85xx/Makefile         |  1 -
 arch/powerpc/cpu/mpc85xx/p1023_serdes.c   | 59 -------------------
 arch/powerpc/cpu/mpc8xxx/cpu.c            |  1 -
 arch/powerpc/include/asm/config_mpc85xx.h |  7 ---
 arch/powerpc/include/asm/immap_85xx.h     | 15 -----
 arch/powerpc/include/asm/processor.h      |  1 -
 drivers/net/Kconfig                       |  1 -
 drivers/net/fm/Makefile                   |  1 -
 drivers/net/fm/fm.h                       |  4 --
 drivers/net/fm/p1023.c                    | 72 -----------------------
 11 files changed, 1 insertion(+), 180 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p1023_serdes.c
 delete mode 100644 drivers/net/fm/p1023.c

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index ab66ffadebd..f4e34adbaea 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -443,20 +443,6 @@ config ARCH_P1021
 	imply CMD_REGINFO
 	imply SATA_SIL
 
-config ARCH_P1023
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_I2C_A004447
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v22
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select FSL_ELBC
-
 config ARCH_P1024
 	bool
 	select FSL_LAW
@@ -794,7 +780,6 @@ config MAX_CPUS
 		     ARCH_BSC9132 || \
 		     ARCH_P1020 || \
 		     ARCH_P1021 || \
-		     ARCH_P1023 || \
 		     ARCH_P1024 || \
 		     ARCH_P1025 || \
 		     ARCH_P2020 || \
@@ -821,7 +806,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_P1024	|| \
 				ARCH_P1025	|| \
 				ARCH_P2020
-	default 0xff600000 if	ARCH_P1023
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
 				ARCH_P2041	|| \
@@ -957,7 +941,7 @@ config SYS_FSL_A004447_SVR_REV
 	hex
 	depends on SYS_FSL_ERRATUM_I2C_A004447
 	default 0x10 if ARCH_P1010
-	default 0x11 if ARCH_P1023 || ARCH_P2041 || ARCH_BSC9132
+	default 0x11 if ARCH_P2041 || ARCH_BSC9132
 
 config SYS_FSL_ERRATUM_IFC_A002769
 	bool
@@ -1027,7 +1011,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
-			ARCH_P1023	|| \
 			ARCH_P1024	|| \
 			ARCH_P1025	|| \
 			ARCH_P2020
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index f78131dd61a..c40558880ea 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
-obj-$(CONFIG_ARCH_P1023)	+= p1023_serdes.o
 obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/p1023_serdes.c b/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
deleted file mode 100644
index 6d306d99c32..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
- * Author: Roy Zang <tie-fei.zang@freescale.com>
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
-static const u8 serdes1_cfg_tbl[][SRDS1_MAX_LANES] = {
-	[0x00] = {PCIE1, PCIE2, NONE, NONE},
-	[0x01] = {PCIE1, PCIE2, PCIE3, NONE},
-	[0x02] = {PCIE1, PCIE2, PCIE3, SGMII_FM1_DTSEC2},
-	[0x03] = {PCIE1, PCIE2, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2},
-};
-
-int is_serdes_configured(enum srds_prtcl device)
-{
-	int ret;
-
-	if (!(serdes1_prtcl_map & (1 << NONE)))
-		fsl_serdes_init();
-
-	ret = (1 << device) & serdes1_prtcl_map;
-	return ret;
-}
-
-void fsl_serdes_init(void)
-{
-	ccsr_gur_t *gur = (void *)CFG_SYS_MPC85xx_GUTS_ADDR;
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
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes1_cfg_tbl[srds_cfg][lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index efbbbced132..668bd139066 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -48,7 +48,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P1020, P1020, 2),
 	CPU_TYPE_ENTRY(P1021, P1021, 2),
 	CPU_TYPE_ENTRY(P1022, P1022, 2),
-	CPU_TYPE_ENTRY(P1023, P1023, 2),
 	CPU_TYPE_ENTRY(P1024, P1024, 2),
 	CPU_TYPE_ENTRY(P1025, P1025, 2),
 	CPU_TYPE_ENTRY(P2010, P2010, 1),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index f115dcce76a..67804ada5ed 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -15,13 +15,6 @@
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
 
-#elif defined(CONFIG_ARCH_P1023)
-#define CFG_SYS_NUM_FMAN		1
-#define CFG_SYS_NUM_FM1_DTSEC	2
-#define CFG_SYS_QMAN_NUM_PORTALS	3
-#define CFG_SYS_BMAN_NUM_PORTALS	3
-#define CFG_SYS_FM_MURAM_SIZE	0x10000
-
 /* P1025 is lower end variant of P1021 */
 #elif defined(CONFIG_ARCH_P1025)
 #define QE_MURAM_SIZE			0x6000UL
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 489fcd43351..39ddfcfe308 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1790,22 +1790,12 @@ typedef struct ccsr_gur {
 #define PORBMSR_ROMLOC_NOR	0xf
 	u32	porimpscr;	/* POR I/O impedance status & control */
 	u32	pordevsr;	/* POR I/O device status regsiter */
-#if defined(CONFIG_ARCH_P1023)
-#define MPC85xx_PORDEVSR_SGMII1_DIS	0x10000000
-#define MPC85xx_PORDEVSR_SGMII2_DIS	0x08000000
-#define MPC85xx_PORDEVSR_TSEC1_PRTC	0x02000000
-#else
 #define MPC85xx_PORDEVSR_SGMII1_DIS	0x20000000
 #define MPC85xx_PORDEVSR_SGMII2_DIS	0x10000000
-#endif
 #define MPC85xx_PORDEVSR_SGMII3_DIS	0x08000000
 #define MPC85xx_PORDEVSR_SGMII4_DIS	0x04000000
 #define MPC85xx_PORDEVSR_SRDS2_IO_SEL	0x38000000
 #define MPC85xx_PORDEVSR_PCI1		0x00800000
-#if defined(CONFIG_ARCH_P1023)
-#define MPC85xx_PORDEVSR_IO_SEL		0x00600000
-#define MPC85xx_PORDEVSR_IO_SEL_SHIFT	21
-#else
 #if defined(CONFIG_ARCH_P1010)
 #define MPC85xx_PORDEVSR_IO_SEL		0x00600000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	21
@@ -1816,7 +1806,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PORDEVSR_IO_SEL		0x00780000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	19
 #endif /* if defined(CONFIG_ARCH_P1010) */
-#endif
 #define MPC85xx_PORDEVSR_PCI2_ARB	0x00040000
 #define MPC85xx_PORDEVSR_PCI1_ARB	0x00020000
 #define MPC85xx_PORDEVSR_PCI1_PCI32	0x00010000
@@ -1891,9 +1880,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR_CAN2_TDM			0x00000002
 #define MPC85xx_PMUXCR_CAN2_RES			0x00000003
 #endif
-#if defined(CONFIG_ARCH_P1023)
-#define MPC85xx_PMUXCR_TSEC1_1		0x10000000
-#else
 #define MPC85xx_PMUXCR_SD_DATA		0x80000000
 #define MPC85xx_PMUXCR_SDHC_CD		0x40000000
 #define MPC85xx_PMUXCR_SDHC_WP		0x20000000
@@ -1912,7 +1898,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR_QE10		0x00000020
 #define MPC85xx_PMUXCR_QE11		0x00000010
 #define MPC85xx_PMUXCR_QE12		0x00000008
-#endif
 #if defined(CONFIG_ARCH_BSC9131)
 #define MPC85xx_PMUXCR_TSEC2_DMA_GPIO_IRQ	0x40000000
 #define MPC85xx_PMUXCR_TSEC2_USB		0xC0000000
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 36d8660cddc..2612f182a4c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1040,7 +1040,6 @@
 #define SVR_P1020	0x80E400
 #define SVR_P1021	0x80E401
 #define SVR_P1022	0x80E600
-#define SVR_P1023	0x80F600
 #define SVR_P1024	0x80E402
 #define SVR_P1025	0x80E403
 #define SVR_P2010	0x80E300
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b4224c24040..ac201ba45c2 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -962,7 +962,6 @@ config SYS_DPAA_QBMAN
 	depends on ARM || PPC
 	default y if ARCH_B4860 || \
 		     ARCH_B4420 || \
-		     ARCH_P1023 || \
 		     ARCH_P2041 || \
 		     ARCH_T1024 || \
 		     ARCH_T1040 || \
diff --git a/drivers/net/fm/Makefile b/drivers/net/fm/Makefile
index 6ec673feec4..847c1cbe340 100644
--- a/drivers/net/fm/Makefile
+++ b/drivers/net/fm/Makefile
@@ -13,7 +13,6 @@ obj-y += tgec_phy.o
 obj-$(CONFIG_SYS_FMAN_V3) += memac.o
 
 # SoC specific SERDES support
-obj-$(CONFIG_ARCH_P1023)	+= p1023.o
 # The P204x and P5020 are the same
 obj-$(CONFIG_ARCH_P2041) += p5020.o
 obj-$(CONFIG_ARCH_T1040) += t1040.o
diff --git a/drivers/net/fm/fm.h b/drivers/net/fm/fm.h
index 5c45ad56d0a..cafdaf89014 100644
--- a/drivers/net/fm/fm.h
+++ b/drivers/net/fm/fm.h
@@ -96,11 +96,7 @@ struct fm_port_global_pram {
 #define PRAM_MODE_GLOBAL	0x20000000
 #define PRAM_MODE_GRACEFUL_STOP	0x00800000
 
-#if defined(CONFIG_ARCH_P1023)
-#define FM_FREE_POOL_SIZE	0x2000 /* 8K bytes */
-#else
 #define FM_FREE_POOL_SIZE	0x20000 /* 128K bytes */
-#endif
 #define FM_FREE_POOL_ALIGN	256
 
 void *fm_muram_alloc(int fm_idx, size_t size, ulong align);
diff --git a/drivers/net/fm/p1023.c b/drivers/net/fm/p1023.c
deleted file mode 100644
index 362bc9f30a1..00000000000
--- a/drivers/net/fm/p1023.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2011 Freescale Semiconductor, Inc.
- */
-#include <config.h>
-#include <phy.h>
-#include <fm_eth.h>
-#include <asm/io.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_serdes.h>
-
-static u32 port_to_devdisr[] = {
-	[FM1_DTSEC1] = MPC85xx_DEVDISR_TSEC1,
-	[FM1_DTSEC2] = MPC85xx_DEVDISR_TSEC2,
-};
-
-static int is_device_disabled(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 devdisr = in_be32(&gur->devdisr);
-
-	return port_to_devdisr[port] & devdisr;
-}
-
-void fman_disable_port(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-
-	/* don't allow disabling of DTSEC1 as its needed for MDIO */
-	if (port == FM1_DTSEC1)
-		return;
-
-	setbits_be32(&gur->devdisr, port_to_devdisr[port]);
-}
-
-void fman_enable_port(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-
-	clrbits_be32(&gur->devdisr, port_to_devdisr[port]);
-}
-
-phy_interface_t fman_port_enet_if(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 pordevsr = in_be32(&gur->pordevsr);
-
-	if (is_device_disabled(port))
-		return PHY_INTERFACE_MODE_NA;
-
-	/* DTSEC1 can be SGMII, RGMII or RMII */
-	if (port == FM1_DTSEC1) {
-		if (is_serdes_configured(SGMII_FM1_DTSEC1))
-			return PHY_INTERFACE_MODE_SGMII;
-		if (pordevsr & MPC85xx_PORDEVSR_SGMII1_DIS) {
-			if (pordevsr & MPC85xx_PORDEVSR_TSEC1_PRTC)
-				return PHY_INTERFACE_MODE_RGMII;
-			else
-				return PHY_INTERFACE_MODE_RMII;
-		}
-	}
-
-	/* DTSEC2 only supports SGMII or RGMII */
-	if (port == FM1_DTSEC2) {
-		if (is_serdes_configured(SGMII_FM1_DTSEC2))
-			return PHY_INTERFACE_MODE_SGMII;
-		if (pordevsr & MPC85xx_PORDEVSR_SGMII2_DIS)
-			return PHY_INTERFACE_MODE_RGMII;
-	}
-
-	return PHY_INTERFACE_MODE_NA;
-}
-- 
2.47.3

