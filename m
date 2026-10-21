Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51452606B6F1
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=THl9Md5D;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=DGEZyAHJ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=55iQt+PA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1668360B30;
	Wed, 21 Oct 2026 16:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qzXk4tyFk006; Wed, 21 Oct 2026 16:16:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25C3660A7C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599397;
	b=LY78Lw8HRqNrTQluk+NxnvQ8GeQIJWrvtpoW3t7vXXXE7gktFmcDC1Q8pFC7x4WStHD5
	 hKv4KHDSMsXEZc5xiUxuQU6eDdcmIaE3mBiyECjAvSKk8huMA/4gR+WpciWA7wE5J+LL+
	 VT9zLvr5CwxzDO6Z1QvF9fJntfVXFCkT0fzBiVi+5AN2CW5o3DjpGn6IvTHNt0lOUNJZA
	 HqxsCSxJ9XBZvBUeEeMIlxjcuMm7RncrnKNGjfiOvykDHZKeaO71dRxjcuhRj2p0dxE4x
	 cv/5Uo7iwB7PUgpqU1eNRJlZk/hHzFMMBCMMsxblTOThHKGEx+4FJliwJVSods5raAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MO4BjqrfjSv/RlWRuY1NmDag3+XKh1dI1OwA/0Ca2Mc=;
	b=fV8g9Eo2raEVCmkMLC0/0P/1RqEOII31riBF5ABe0FTQf+Q6RCO/FIw3v3kEclgnvrWb
	 aLqfaey64QlMkkGHI/leiCeNV+8TOjHQJ0EGQ+mgvmT/qKk5L8/qwxae/o/EiIbX3NC+d
	 qP7/5vjahAHisf51BnB7MCvGyEqfst3JmyzH/M9Vkv8CrFpe0cyD6bR7brEV8p87HPnMw
	 rOLYt7g+vsQBmWdcedCOtACmjpGxkavQycZQ66X9eBriumcUKxo6VPnwMur0OuGIAjldT
	 l38MdzLeJiGhCmRV2hNxqH1QkMfbLinnJMRVbUHc7C1bKoNzWLs7m49AgyKE30CIMRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=DGEZyAHJ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=55iQt+PA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599397;
	bh=MO4BjqrfjSv/RlWRuY1NmDag3+XKh1dI1OwA/0Ca2Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=THl9Md5DWquPgBmcXjEBPp3KOgm7WLJTql31/reHufTb8s+x4TN5jdqkGn9nUlPPU
	 1n8jxnJ+MOMpw7PTSLyV42Er5Wx95pSjzH9nH+omS4WjI65GTG8eH1VV5DXjdmNnEP
	 1vNNQ3z/bF/ARoE3/nnpoAOxgljL2RsDwVp64Af/nYb2obzprbt7CzkhbgkPslX/ea
	 LFOpsJVFAQuO4lTAB4JhCf56zaJ5A7oKlM2uhL7v8p8lurS7iJrYv8YdDd+aUhZU7s
	 YMM3tQcKRlSgRwg7/PnFuh4atvp7PnnEHB6dRqkcbrHysocmbPDqVCL64KqlM+1oAq
	 UAIj+89Vr1huw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25C3660A7C;
	Wed, 21 Oct 2026 16:16:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 4BDFD1E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 31B7360848
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id CWNiBu3_Cyv6 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E76660874
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598519;
 b=lLlprUDQ/bhpgLwzQIoqGxAZKl1RYlsfK5ziSTfMl9K4xC2RbokNJcD5T3UEfijxJN3G
 CFRrsut/pvkvY9y/cizFkGmavs+UfhWtlqCEfVpil1/TZT7653VhElRxzNY1YxjezZDHo
 s65gPsSz7UMhg7APlRVX9FW6Hs3Tr8Rq5Jsf/hNRWrIE75pzfX8jx7lJBdUwJG8dByjP0
 1HtrkBS624uAm3cS0gMS52jT2qMK59S1NAX8bjNev0Dh3/Io6sKc53v/X2kn/qDJrnPGb
 McD2NbJjL+XRNMcurAHVzmZdoE1nrIW4VirUF74uC21QhUGteR68rVPm8dH8wOFcIyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598519;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=MO4BjqrfjSv/RlWRuY1NmDag3+XKh1dI1OwA/0Ca2Mc=;
 b=el5h1aIsQ0tFXn1zJYYjRPihgt9HAhYzKG5ae8voinXQrWZ7RrwKJZQkjoXFv0IqIXBT
 /2ltzTOSP/bSRSpEAxEKqW4JJDYlTLinmzY6UkTxOi9FdOH4zFW6xtbMve92SfHctiFCE
 XHOhRZEOuO1IZtOl3ABhLquCSzyXCHXF9fYWPT0UacE5E7c2fZy6JS5vWE7q6R75mH5W1
 +mwdcd1U0e9aimXgKqjexOeiSV4pVwxXi7NSbT3cJ3h7X6UO+zwIY+d92eQhMcBSgr7Qp
 gm7BN9RGItsvHWYFzqcSl3gw0NpFm+9CXiTpBKnpgqsGgeL20AcxKJp/OALViWztIJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=DGEZyAHJ; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=55iQt+PA; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=DGEZyAHJ; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=55iQt+PA
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 9E76660874
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598514; bh=MO4BjqrfjSv/RlWRuY1NmDa
 g3+XKh1dI1OwA/0Ca2Mc=; b=DGEZyAHJzEW++8CG6IYlzFaWYGNW8czgMK+m2wEAiW7V03iqMZ
 IECHbzjes7QZnv3wgaTD/NC4Rl5WVMQDQ9DQbyFOShjfNsp24aJfkt8ipyrCwSenLwN4Q56cvBJ
 Ff1A9Rk91BVpVKiBa4PYRB2geYVOUKZUPsZTBgOvoRBuUN9dt6Ma5D3pBoiewatmINoE7U4AcOl
 iuOuTnaaIOcfJvvbPLcyeoA/7sjLRz3O7x2ooQEefwRwxmDX9jwRDKEC5i3oi9fkXq2ArBhvLKu
 0sqwMpaHb/1kdqbI5qC752y/gVa6h+zZb42AmqLo/q8BR+REkDDe4oHZ4AMWzXp/gng==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598514; bh=MO4BjqrfjSv/RlWRuY1NmDa
 g3+XKh1dI1OwA/0Ca2Mc=; b=55iQt+PAXOjus3lX89F8lXeMzgHwMoCVx2CkNIrTxocHokxxWi
 2PVz67K3SsjujoZS3zbakDWOJeOCFs7w5vAw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 19/26] powerpc: mpc85xx: Remove BSC9132 support
Date: Wed, 21 Oct 2026 16:01:15 +0000
Message-ID: <20261021160145.10430-20-brads@mainlining.org>
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
index 0a5232ef9eb..c382fdc1d1c 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -79,7 +79,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(T2081, T2081, 0),
 	CPU_TYPE_ENTRY(BSC9130, 9130, 1),
 	CPU_TYPE_ENTRY(BSC9131, 9131, 1),
-	CPU_TYPE_ENTRY(BSC9132, 9132, 2),
 	CPU_TYPE_ENTRY(BSC9232, 9232, 2),
 #elif defined(CONFIG_MPC86xx)
 	CPU_TYPE_ENTRY(8610, 8610, 1),
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

