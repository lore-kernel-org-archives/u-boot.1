Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450EC606A543
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cufl8za0;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=AyjlBsO4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=h3EjXoRp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DFED60BDE;
	Wed, 21 Oct 2026 16:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0goZSM4zm3l; Wed, 21 Oct 2026 16:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DF7E60B1D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599414;
	b=QK0CmQQQYRqgFaBEiDNg+SdMtfVuHvzWmTmrFWRVsQqofDBpNn1vLcJ+5D1Omv4wVjQh
	 ODv8uOviJcHm40C9c4bIaFl1hrzfsbRhNr2JAF29I2E2Crh1NEvIb1RQnwMxEup29ysjA
	 oV3zLofKwjU2nNmrWi0fatA3Xo86Z/rZnRsXHg9U4R45M5huoXHDnGJtWZakdn9lLFNY9
	 at7S5dP5vNJiZXzWzT8Yp1LpZ59qExgH4I8348YeHEhNuM+aIOSokKen5B+64KOzWmpMy
	 64jkMHmWQuk+Yhi3sfm95444s1BCrGY57PBGwfAuMOVOi706yISi+G0uGayb//sFaEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FGnvf0UzoGwuQ8eWPYUM1RYiWrU7NZX93Pi6vOQnq8Q=;
	b=AAjnaBIApeOXgsUV3UxDyvTlWs6DyzyRPUHfYm6n49X8K4oTQYsW3Kv1WkxpE1bA9mT5
	 Kqvl+5FYjJVfE8vPtJLTD47m6PibwUluarY+KJT1t8NGRRrw8WVtyWM4P7tdGwAIQXmqq
	 mzZ8AEyMSUj4D3pyJojasYEOPhMfck4yRqlYbATSzto1HUOqo6hXsorHJ5GBDiEZvhuVw
	 U/luDKYeK+6+Dd/vJwE64ei36KvkRtQbbBZoVMmja0J1dfF2DYD4u8UfZk98PzsUV/xnZ
	 y2YxsagFGM2kza4ddHPOYBxd0vaGni68+A1yGUFfYU8asFYrRA9KqApa3CJlQvVfwPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599414;
	bh=FGnvf0UzoGwuQ8eWPYUM1RYiWrU7NZX93Pi6vOQnq8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cufl8za0/WrtfRmh/sbS88kUU/CPuu4wPU9t54bZI460Ki0S7D2XJoFKBNa9DJOxJ
	 /ERXf53u1jJr28F5IrklKcGsOkV31roZaWGZMnbyu80k9clUneJZA0IKLAQbheVKGT
	 ZjgZCJvEADphZlMscqwrHuNaLhBt2KndVz8N8eRQ7gjftoU+i93RWuXzmUHVp2tCP8
	 tF9jo7Cd2yFgv3y07Gb4gUueuvTkgZPfQG6Hd139WIPNBK8cXFRW8T6qs9wH4Edpmk
	 9olmNfN1SFqo4XxRLq1Fw4xW7FbIVUIzSjDYO8nSHfsLBwVhgnbM6y+OA1Gf+FPN4v
	 J0+R47z9fMcvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DF7E60B1D;
	Wed, 21 Oct 2026 16:16:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 198F9356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 0B9134039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id kdAJfB7i_O10 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8CF054016B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598525;
 b=U9EZC2kuMGE/juT1GxQn5ZkOKcTneMDt42OyDMiFYjigzI3RV4JZa78Xs5m06w2bZR7E
 0MDEWExSQhtZIhgt3vRrWIqZCH7anAV4ecA1LcwqBqUfF94IjAEkhkiTxOock3nKELKlT
 obtoWiOJLB1nu+KVufUH6ddAAPHzghh+jtKh1U/ZBmlZcFILqVymCvO+AqlSZlwAvLw2N
 z8+naQ2ONqPRcNa7VdRTZC6gNy6YMwZsgcHy6LkVfdUpwoV5azVd/DJSnC20oJ1Hr3lC1
 0mngRHmf0OCrTFB77o51LE5h3rX0rSCxfW+NvNjgVLGfWzXi4pSMYnftOiyocHc8ODg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598525;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FGnvf0UzoGwuQ8eWPYUM1RYiWrU7NZX93Pi6vOQnq8Q=;
 b=ZvhE9CvVLarqhgJsGvw8PKUkCrgDr9oKG93yKO1UMGdltSfyb3tXZEroGi49aPq2RebX
 VaOC1jZl02rG9DRtcaMNUqUjUt8dOv5E6jzfrxOpsp4zAteKkYM1UOCt1iH82PZGfZA+F
 BX9oZf5IY2Usa5ZKnplXi8Yk2+MKuGLZgkGEtGNtzCwfSZCLiChTC+wVFevdtkuoQhf9X
 EZ4Y0+0Jc+fYFZhij9kYbrFFsGvxs18GAgfS0Iy66L59pMVZd5FhId2tB12X37p3E5nNc
 vIbSaa7bTcnjfnMH4KGtQ+z/sIVW4+8UTvuBp1nYgbCUgHi4CHEoJnoa1YczCmrysYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=AyjlBsO4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=h3EjXoRp; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=AyjlBsO4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=h3EjXoRp
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 8CF054016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598512; bh=FGnvf0UzoGwuQ8eWPYUM1RY
 iWrU7NZX93Pi6vOQnq8Q=; b=AyjlBsO4oekYR0YULQLa3t6FJwyuuAdewNjluB6fGAZeeuZCRi
 db3k2ULurOs6hd7uIyl0ZoKYGmBMzGfMKOt6KwgrxU19wYBGzYMTUqILuI1oOJLgknpxRKQGycX
 ujBxa5QuEu0bXREE7kFWUYOGRJyQEf5K9exMUR2/D+uNiCTcfkSJk8YYVooERK2jIRYy3PIzqqC
 33P0sMn4cbs3eNP2FI0bBmP0hXpSyLqu9AyG1/ih5HDNpobx4f/hQKDYtJrLyZsFM57D7M0BcJW
 HzLVcP11BE6Q8Q4CgBr6Ki1YjS88u+ijjLrat785cEURBXAkT/H+1TnTH+oseehGKiQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598512; bh=FGnvf0UzoGwuQ8eWPYUM1RY
 iWrU7NZX93Pi6vOQnq8Q=; b=h3EjXoRprRUvFCxhd/tlFg3JcLmoF+d1x7gOKF9NxGAUUZvvw5
 48J6lGNfKLOxmZNQNEDN26Lpr/taJPGuJ4Aw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 16/26] powerpc: mpc85xx: Remove MPC8536 support
Date: Wed, 21 Oct 2026 16:01:12 +0000
Message-ID: <20261021160145.10430-17-brads@mainlining.org>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No board in the tree selects ARCH_MPC8536, and the SoC lacks active
community maintenance. Remove the unused SoC configuration, SERDES
setup, and CPU identification.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig          |  20 --
 arch/powerpc/cpu/mpc85xx/Makefile         |   1 -
 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c | 250 ----------------------
 arch/powerpc/cpu/mpc8xxx/cpu.c            |   1 -
 arch/powerpc/include/asm/immap_85xx.h     |  10 -
 arch/powerpc/include/asm/processor.h      |   5 -
 doc/README.mpc85xx-sd-spi-boot            |   1 -
 7 files changed, 288 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 6ca0ccd65e7..8391ea23cdb 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -321,23 +321,6 @@ config ARCH_BSC9132
 	imply CMD_PCI
 	imply CMD_REGINFO
 
-config ARCH_MPC8536
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR2
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-	imply CMD_NAND
-	imply SATA
-	imply CMD_REGINFO
-
 config ARCH_MPC8540
 	bool
 	select FSL_LAW
@@ -777,7 +760,6 @@ config SYS_CCSRBAR_DEFAULT
 	hex "Default CCSRBAR address"
 	default	0xff700000 if	ARCH_BSC9131	|| \
 				ARCH_BSC9132	|| \
-				ARCH_MPC8536	|| \
 				ARCH_MPC8540	|| \
 				ARCH_MPC8544	|| \
 				ARCH_MPC8560	|| \
@@ -987,7 +969,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_T1042
 	default 12 if	ARCH_BSC9131	|| \
 			ARCH_BSC9132	|| \
-			ARCH_MPC8536	|| \
 			ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
@@ -1100,7 +1081,6 @@ config SYS_PPC_E500_DEBUG_TLB
 	int "Temporary TLB entry for external debugger"
 	depends on SYS_PPC_E500_USE_DEBUG_TLB
 	default 0 if ARCH_MPC8544
-	default 1 if	ARCH_MPC8536
 	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 3746d5c6fdb..43a5b5b67a4 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -51,7 +51,6 @@ obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS1) += fsl_corenet_serdes.o
 obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS2) += fsl_corenet2_serdes.o
 
 # SoC specific SERDES support
-obj-$(CONFIG_ARCH_MPC8536) += mpc8536_serdes.o
 obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c b/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
deleted file mode 100644
index bafff2083b3..00000000000
--- a/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
+++ /dev/null
@@ -1,250 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2008,2010 Freescale Semiconductor, Inc.
- *	Dave Liu <daveliu@freescale.com>
- */
-
-#include <config.h>
-#include <log.h>
-#include <asm/io.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_serdes.h>
-
-/* PORDEVSR register */
-#define GUTS_PORDEVSR_OFFS		0xc
-#define GUTS_PORDEVSR_SERDES2_IO_SEL	0x38000000
-#define GUTS_PORDEVSR_SERDES2_IO_SEL_SHIFT	27
-
-/* SerDes CR0 register */
-#define	FSL_SRDSCR0_OFFS	0x0
-#define FSL_SRDSCR0_TXEQA_MASK	0x00007000
-#define FSL_SRDSCR0_TXEQA_SGMII	0x00004000
-#define FSL_SRDSCR0_TXEQA_SATA	0x00001000
-#define FSL_SRDSCR0_TXEQE_MASK	0x00000700
-#define FSL_SRDSCR0_TXEQE_SGMII	0x00000400
-#define FSL_SRDSCR0_TXEQE_SATA	0x00000100
-
-/* SerDes CR1 register */
-#define FSL_SRDSCR1_OFFS	0x4
-#define FSL_SRDSCR1_LANEA_MASK	0x80200000
-#define FSL_SRDSCR1_LANEA_OFF	0x80200000
-#define FSL_SRDSCR1_LANEE_MASK	0x08020000
-#define FSL_SRDSCR1_LANEE_OFF	0x08020000
-
-/* SerDes CR2 register */
-#define FSL_SRDSCR2_OFFS	0x8
-#define FSL_SRDSCR2_EICA_MASK	0x00001f00
-#define FSL_SRDSCR2_EICA_SGMII	0x00000400
-#define FSL_SRDSCR2_EICA_SATA	0x00001400
-#define FSL_SRDSCR2_EICE_MASK	0x0000001f
-#define FSL_SRDSCR2_EICE_SGMII	0x00000004
-#define FSL_SRDSCR2_EICE_SATA	0x00000014
-
-/* SerDes CR3 register */
-#define FSL_SRDSCR3_OFFS	0xc
-#define FSL_SRDSCR3_LANEA_MASK	0x3f000700
-#define FSL_SRDSCR3_LANEA_SGMII	0x00000000
-#define FSL_SRDSCR3_LANEA_SATA	0x15000500
-#define FSL_SRDSCR3_LANEE_MASK	0x003f0007
-#define FSL_SRDSCR3_LANEE_SGMII	0x00000000
-#define FSL_SRDSCR3_LANEE_SATA	0x00150005
-
-#define SRDS1_MAX_LANES		8
-#define SRDS2_MAX_LANES		2
-
-static u32 serdes1_prtcl_map, serdes2_prtcl_map;
-
-static u8 serdes1_cfg_tbl[][SRDS1_MAX_LANES] = {
-	[0x2] = {PCIE1, PCIE1, PCIE1, PCIE1, NONE, NONE, NONE, NONE},
-	[0x3] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1},
-	[0x5] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2},
-	[0x7] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE3, PCIE3},
-};
-
-static u8 serdes2_cfg_tbl[][SRDS2_MAX_LANES] = {
-	[0x1] = {SATA1, SATA2},
-	[0x3] = {SATA1, NONE},
-	[0x4] = {SGMII_TSEC1, SGMII_TSEC3},
-	[0x6] = {SGMII_TSEC1, NONE},
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
-
-	if (ret)
-		return ret;
-
-	if (!(serdes2_prtcl_map & (1 << NONE)))
-		fsl_serdes_init();
-
-	return (1 << device) & serdes2_prtcl_map;
-}
-
-void fsl_serdes_init(void)
-{
-	void *guts = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	void *sd = (void *)CFG_SYS_MPC85xx_SERDES2_ADDR;
-	u32 pordevsr = in_be32(guts + GUTS_PORDEVSR_OFFS);
-	u32 srds1_io_sel, srds2_io_sel;
-	u32 tmp;
-	int lane;
-
-	if (serdes1_prtcl_map & (1 << NONE) &&
-	    serdes2_prtcl_map & (1 << NONE))
-		return;
-
-	srds1_io_sel = (pordevsr & MPC85xx_PORDEVSR_IO_SEL) >>
-				MPC85xx_PORDEVSR_IO_SEL_SHIFT;
-
-	/* parse the SRDS2_IO_SEL of PORDEVSR */
-	srds2_io_sel = (pordevsr & GUTS_PORDEVSR_SERDES2_IO_SEL)
-		       >> GUTS_PORDEVSR_SERDES2_IO_SEL_SHIFT;
-
-	debug("PORDEVSR[SRDS1_IO_SEL] = %x\n", srds1_io_sel);
-	debug("PORDEVSR[SRDS2_IO_SEL] = %x\n", srds2_io_sel);
-
-	switch (srds2_io_sel) {
-	case 1:	/* Lane A - SATA1, Lane E - SATA2 */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SATA;
-		tmp &= ~FSL_SRDSCR0_TXEQE_MASK;
-		tmp |= FSL_SRDSCR0_TXEQE_SATA;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEA_MASK;
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SATA;
-		tmp &= ~FSL_SRDSCR2_EICE_MASK;
-		tmp |= FSL_SRDSCR2_EICE_SATA;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SATA;
-		tmp &= ~FSL_SRDSCR3_LANEE_MASK;
-		tmp |= FSL_SRDSCR3_LANEE_SATA;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 3: /* Lane A - SATA1, Lane E - disabled */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SATA;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		tmp |= FSL_SRDSCR1_LANEE_OFF;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SATA;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SATA;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 4: /* Lane A - eTSEC1 SGMII, Lane E - eTSEC3 SGMII */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SGMII;
-		tmp &= ~FSL_SRDSCR0_TXEQE_MASK;
-		tmp |= FSL_SRDSCR0_TXEQE_SGMII;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEA_MASK;
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SGMII;
-		tmp &= ~FSL_SRDSCR2_EICE_MASK;
-		tmp |= FSL_SRDSCR2_EICE_SGMII;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SGMII;
-		tmp &= ~FSL_SRDSCR3_LANEE_MASK;
-		tmp |= FSL_SRDSCR3_LANEE_SGMII;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 6: /* Lane A - eTSEC1 SGMII, Lane E - disabled */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SGMII;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		tmp |= FSL_SRDSCR1_LANEE_OFF;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SGMII;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SGMII;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 7: /* Lane A - disabled, Lane E - disabled */
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEA_MASK;
-		tmp |= FSL_SRDSCR1_LANEA_OFF;
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		tmp |= FSL_SRDSCR1_LANEE_OFF;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		break;
-	default:
-		break;
-	}
-
-	if (srds1_io_sel >= ARRAY_SIZE(serdes1_cfg_tbl)) {
-		printf("Invalid PORDEVSR[SRDS1_IO_SEL] = %d\n", srds1_io_sel);
-		return;
-	}
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes1_cfg_tbl[srds1_io_sel][lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-
-	if (srds2_io_sel >= ARRAY_SIZE(serdes2_cfg_tbl)) {
-		printf("Invalid PORDEVSR[SRDS2_IO_SEL] = %d\n", srds2_io_sel);
-		return;
-	}
-
-	for (lane = 0; lane < SRDS2_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes2_cfg_tbl[srds2_io_sel][lane];
-		serdes2_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes2_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index ec036cdac01..1e5d733ffce 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -26,7 +26,6 @@ static struct cpu_type cpu_type_list[] = {
 #if defined(CONFIG_MPC85xx)
 	CPU_TYPE_ENTRY(8533, 8533, 1),
 	CPU_TYPE_ENTRY(8535, 8535, 1),
-	CPU_TYPE_ENTRY(8536, 8536, 1),
 	CPU_TYPE_ENTRY(8540, 8540, 1),
 	CPU_TYPE_ENTRY(8541, 8541, 1),
 	CPU_TYPE_ENTRY(8543, 8543, 1),
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 9f5e9a7cfcd..695c89f2237 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1765,17 +1765,12 @@ typedef struct ccsr_rcpm {
 #else
 typedef struct ccsr_gur {
 	u32	porpllsr;	/* POR PLL ratio status */
-#ifdef CONFIG_ARCH_MPC8536
-#define MPC85xx_PORPLLSR_DDR_RATIO	0x3e000000
-#define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	25
-#else
 #if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003f00
 #else
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003e00
 #endif
 #define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	9
-#endif
 #define MPC85xx_PORPLLSR_QE_RATIO	0x3e000000
 #define MPC85xx_PORPLLSR_QE_RATIO_SHIFT		25
 #define MPC85xx_PORPLLSR_PLAT_RATIO	0x0000003e
@@ -1822,12 +1817,7 @@ typedef struct ccsr_gur {
 	u8	res1[8];
 	u32	gpporcr;	/* General-purpose POR configuration */
 	u8	res2[12];
-#if defined(CONFIG_ARCH_MPC8536)
-	u32	gencfgr;	/* General Configuration Register */
-#define MPC85xx_GENCFGR_SDHC_WP_INV	0x20000000
-#else
 	u32	gpiocr;		/* GPIO control */
-#endif
 	u8	res3[12];
 	u32	gpoutdr;	/* General-purpose output data */
 	u8	res4[12];
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 748cf1a3f54..e11498c6e78 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -990,11 +990,7 @@
 #define SVR_FAM(svr)	(((svr) >> 20) & 0xFFF)	/* Family field */
 #define SVR_MEM(svr)	(((svr) >> 16) & 0xF)	/* Member field */
 
-#ifdef CONFIG_ARCH_MPC8536
-#define SVR_MAJ(svr)	(((svr) >>  4) & 0x7)	/* Major revision field*/
-#else
 #define SVR_MAJ(svr)	(((svr) >>  4) & 0xF)	/* Major revision field*/
-#endif
 #define SVR_MIN(svr)	(((svr) >>  0) & 0xF)	/* Minor revision field*/
 
 /* Some parts define SVR[0:23] as the SOC version */
@@ -1018,7 +1014,6 @@
 
 #define SVR_8533	0x803400
 #define SVR_8535	0x803701
-#define SVR_8536	0x803700
 #define SVR_8540	0x803000
 #define SVR_8541	0x807200
 #define SVR_8543	0x803200
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 7a5748f5df3..c382e9bf7aa 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -66,4 +66,3 @@ P1022DS		config_ddr3_2gb_p1022ds.dat
 P1024RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
 P1020UTM	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1020MBG	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
-MPC8536DS	config_ddr2_512m_mpc8536ds_667M.dat
-- 
2.47.3

