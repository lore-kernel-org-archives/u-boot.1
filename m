Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95236606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=otP66hX3;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=hnd6Nx7J;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=oRrZKusZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7070B608EA;
	Wed, 21 Oct 2026 16:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6d9s4v9FaM1k; Wed, 21 Oct 2026 16:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CF96608F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599377;
	b=Op7ylHnXeP8pKU/EgKEDASAghisEM5GnFaL+YoBLoq1lnDKH+4yTr9C68bTh7N1JO0LT
	 tkv7dDla3p7EFDGd8Kw1N56jPp6yASKzt4OeWrMB37dKWaCYATZk616L1nLGy7nxY74uK
	 M16L4GeuS224/CwgX+XRhvl/3FWhkuLbdU3FVYxFFjDNER7y1Nuo8fQoKNlG08iAiMaNc
	 1NOyxXECM0P79DtxsMioSabV/L9l5Hx/2VsKEESruZBM0RO5KuiHM0chM803o6773YZjt
	 1FDcvK39xLea0QZ1fXhOonZVmxgiDcrYs4AqlpNYud/24A0SNkG75bNMuNXW3SdysVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lLc2MIDxtXpWpGq5S+oi9hn05J0D7eezn3pbR52dEM4=;
	b=lRolk8mTel1TOCgKcM9BSoFoFFoZxIWykIfdCeH/CjkMB6g+QKB1Nj2FI+ddDAeU89Nb
	 TEx0UAlVFpmJHqw9VIZTvTw0DFGkazrQB6PSBDhIVxt91Ek0EyEP8n4R3qYisF2Hj58Vi
	 ZCorig9nEJuAW410EEKYsPIzeqJJ4G7gDl/+wK8fq4G/2k6lKB6CKHXr4+sD/8WIqhyI8
	 9bcWWHD9aoPZz9vSF/+km/zsa2HU4+5/+7xDwhTGNlP23wjn0DhNkXQIaXRIWiCXYwsPj
	 501K7HcFFSOTVwJEKDP4BRSSmmqNNRttwnwPubJprva6OkRDfAsNh2OQhCjiqvcRi8Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599377;
	bh=lLc2MIDxtXpWpGq5S+oi9hn05J0D7eezn3pbR52dEM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=otP66hX3TV18QLKwcW3+HbW5OFhubRzUNLZ7xPIrE1UNzI8CGL3ZV4qVXqH0aiT7v
	 fAvMeT04dsEs/0m69yMlv47aVvJzGXm+fHh6/EFWFaqtweO8o1XPez9XvY8Mb6MocW
	 eCyQShuWZfTX9H2DKlfWMpxsCmgVmzXPtDzliQ0dw8c5BDGBhVQJZlYjcxv0Mo7vpv
	 4/MlTKFhFqEYrX5e1JtVVl6r/Q5dwYrWZstR89oE471FEy/Lq+wGtVETppgQO0K4/y
	 bNaIhLJAkhBO32r1SiuAGYGdTcmrNhCduhjnJQM3vyGnnY18gjcuguPtpc5PA15aXi
	 woLXUInmAFi4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CF96608F7;
	Wed, 21 Oct 2026 16:16:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 841521E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 695DB403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 783XA3gf9HVz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 184104016B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598514;
 b=KkTZdhqXwTja5Is2+QX12APrFQfTRX0Z3nY5P1boNM0OlAnfUb9/c9GkNgnyfzTHHXh8
 Jv0VI2DV8Aa3OVvw1jHNY5ME2yvwgjyUbfu++V8vGt8dRxbMdZsV1bwyX2jmxRje+3NIX
 2Mp0Yey39edGb38c9jP0ssKuRFH/ZwjpCKnSKYl0+OmMPvEjlIOuIppKm2Xg4yS4DeUFn
 IHtKLN10fkX4nXoyzZwyZFq/c7mbpVSuRkd4e4pT90V2/ListUQ7o19C8J/6X7Wg0eIbI
 AyFdhIKBLFQDAn4bAAP16AQsVNsu/T5xGaWxPIy0ctuDdUHgJoU/ZbDoa6U9oznCHsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598514;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lLc2MIDxtXpWpGq5S+oi9hn05J0D7eezn3pbR52dEM4=;
 b=paq+iXgb1++YmkQ7iCtEfe7ZBNwD0Q5vW9tposKcCa5jCoZeFR2pGSK/rR7eChDvbunR
 tFjOfeIRM3vRcB4h0cFLqmno92veFjTSE6phMyXb9CtBiufR1Knyk77vPPdh7yzDynBJn
 a2qhUfH6/AYwUlEvsf5IxdTVuVCbVQti2Xqh975rJX601sL0AXcnhzhXYB3M4N7sJtpL2
 yQO6vCBkIQS8LLlLSaIRUiRJmw1fDclaoPxNMv4brawV+ZBDfIJSQLcqdPUPo7iOL4Idq
 eyzWGMds0dlBICpHMJS/3VZkmXAQLEnSwVWVQPdBdWB14uzKYHKZMLUkjX5BTR3I+Sw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=hnd6Nx7J; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=oRrZKusZ; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=hnd6Nx7J; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=oRrZKusZ
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 184104016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598510; bh=lLc2MIDxtXpWpGq5S+oi9hn
 05J0D7eezn3pbR52dEM4=; b=hnd6Nx7JNLC/169hIPQ7Uduye+F9XZwS/FuiOExl7TswbVaaRt
 C1sd0FBxuj+kKRAWh53Nr2Isn8RfgzcO0wp5dhYqD2BXQnop1WBsynmqO96MdOChgHh4wlX3ZOr
 HRalYprkc1NV8ldPbOxHcuEWLRWZVpw2tAtUWzLeD/Dbls9993U9qCCe4jOjc84GmRLbWGMiVi/
 XGVscuKEab5LcMNisCQ47SPWahvIf640udlcAEoSU1oNecohu7PrnLjDQzb6nXWwLK0/D8ccpwA
 2tCm7j8x8T/1H0zdTEsgH1ifaCaI56zInWugNtSPqasi9/t3bK1Y13k9EqUUnT5zVTA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598510; bh=lLc2MIDxtXpWpGq5S+oi9hn
 05J0D7eezn3pbR52dEM4=; b=oRrZKusZSpWY9ui6osdJVjA9zEIyNn+C7BfMFDf46JGv4+xx61
 pOuY+Nyv3d2YPeJAc/z5PUvIr0HIJk1advCQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 12/26] powerpc: mpc85xx: Remove C29x support
Date: Wed, 21 Oct 2026 16:01:08 +0000
Message-ID: <20261021160145.10430-13-brads@mainlining.org>
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
 arch/powerpc/cpu/mpc8xxx/cpu.c            |  3 -
 arch/powerpc/include/asm/config_mpc85xx.h |  3 -
 arch/powerpc/include/asm/immap_85xx.h     | 22 -------
 arch/powerpc/include/asm/processor.h      |  3 -
 drivers/crypto/fsl/jr.c                   | 14 +----
 drivers/mmc/Kconfig                       |  3 +-
 include/fsl_sec.h                         |  3 -
 12 files changed, 7 insertions(+), 152 deletions(-)
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
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 47daf51fc1b..2ee7348391a 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -87,9 +87,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(BSC9131, 9131, 1),
 	CPU_TYPE_ENTRY(BSC9132, 9132, 2),
 	CPU_TYPE_ENTRY(BSC9232, 9232, 2),
-	CPU_TYPE_ENTRY(C291, C291, 1),
-	CPU_TYPE_ENTRY(C292, C292, 1),
-	CPU_TYPE_ENTRY(C293, C293, 1),
 #elif defined(CONFIG_MPC86xx)
 	CPU_TYPE_ENTRY(8610, 8610, 1),
 	CPU_TYPE_ENTRY(8641, 8641, 2),
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

