Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C8606BF17
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h+4l5Aw5;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=DyCJ/C4q;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=HvBy8orw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C46F60A93;
	Wed, 21 Oct 2026 16:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AUPjB6VCI5Tj; Wed, 21 Oct 2026 16:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7089260AB3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599400;
	b=cwM2fUTsNDiLYnGVkzqmrZRBpTsL7DAnYsm80bmibVS6LguI59ZeAH1tBTjB2YMaQykK
	 KiLQNe80R5pfrFeLcVKSG0xN7DR1aoQAhvg2mKX+YUIcKgmmmT2uI/rfiwGeWbH5z7aR2
	 SAUhkN66+nJZlNJAEPHLJZeZ7OaEl49jGMlWyCichD6Lt+vF+Yx9wJ/4vy7nVvWrXV/E3
	 IHNtNJvtLl/MCa7VNUo9L6pMsUj9ToIcsJRWi5ngck26gLfu/i7a5tFDMFLKo5WqX9Msc
	 BVfmMX/Pl2LDydbKWxeQuelxK7zrVkxtOGPKYkGDpDSkA8mld4xW+wlE3df3QsvBqfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nr7uidUWzPw+0hGqlQiPW+JHOZQfUsJ0DcdJ0y26Dyg=;
	b=qzoanuPZPhqiAcBmR+hiCmKL6mLn6v6+cSrYzH44/z4lErBDOPzghP8Kl1EaxSbFJEab
	 w8CrYeTaDe691fynj2PVEHSbllHgib3G2ZwKDD+byP0ivdoqWRi2llxf5H8uA6dpiNtAX
	 w//cMx6Hx/Q2DVlzkxVTOHA787WVuxACXiR2HGRqARkf2A2C9LDLuDnILJ2M5FpSySzG+
	 FMfWTwJrMV8WfRgvMGz8G4kvpN9mEWQ7B6fNXCO+DfTUdsjxmlvYXj9Vofy2+Bc6rAbql
	 5hLOMdywvp/8FuOGCaDq3+c0gTWk0qbHxkDv32IC1rg+OkMTq4oMS9gr+eaiUvDDfzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599400;
	bh=nr7uidUWzPw+0hGqlQiPW+JHOZQfUsJ0DcdJ0y26Dyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h+4l5Aw5WtuQeBbxFxR4vfQiI99GXuEvSm0CTlcojCAVJlZEFNmCEayGQvZHhNneA
	 578mAFybjjqt5CmZwnKTiyHmxnzp6Y32bhKiVaKs1Ugrn8xqheBpmfEe7DknW5zPw1
	 u87B8o2EEG2C2sf9K1W2NPnpub7vB5WYsXdFOLHQDq2i4N3axj09cNEO/E0hz0NEGd
	 DqoW+qdcP3ish1hIKDHkOalE9NxhDQ5Nvtg6lmHTjefmtP07vLZqm/1ZmAlwI15E6E
	 3hpUfAXjb66Ywk+hMRVHxV6esuKHsp1n3fvYFRoGaRwold5iviqabaklp7rdLEuew5
	 kpeADVkTpOArw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7089260AB3;
	Wed, 21 Oct 2026 16:16:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id A218D1E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 94032403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id ZLnh7aC9bGHH for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4B0274016B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598518;
 b=psaqq9GyrvE9OxbhVGiNLQyoUE01fgxF26sv+jYbhBWx/qRu8VksTadhJKbwpb9eQ7mn
 A+xkWzEWuQVYYn9xl6ATQ3tYIYlkiATpFYd7a0YCV9XqVYooaiwP8/PDFoXLtE+srZ3v3
 aeRdFSQhLtg9bW2mMEmkaIxhA0obj/fdWoBrs5i8Cy0mcFedIc/1joX+Y7B2VmyKIq4FD
 CzsnpyaQ/O6w9nOvgNPsGz45ZKZ2kyx/9QLQa3DFr8qZSilEg1pfj1Igj52uvCUYYBntq
 4FuMldeB1dKOuMbNoSXPApqN7JdyYArMPOXn+nWyMmGTmoyQXR4QCxcZAnZvxDK8e2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598518;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nr7uidUWzPw+0hGqlQiPW+JHOZQfUsJ0DcdJ0y26Dyg=;
 b=gUJOXlMra8R5aCHETFkS188vJnnWNVdlMBjyx55+SvM48p8qnnSlEs79S47JAhKFNrRK
 0GAxDxYkpDqrHqpMifdUA2VVMgnX13C3dZFLFFrP64lf5e5AXwsmrKq3JZZXniofkv6TA
 B9HpaOCsK9x4V4IuxXXqt3SvxdgDaGnZkDJB3BVMpZ6NidlViTLFQ1HU8j438aJkhuy/l
 1tTop7ZftU4s7Hkx70FJDdHRKu2gRGU6qPincgHOuVsu3wN/5atKBt3lgCkjjSWvNLjO1
 eIKNrTBs6YGJhgumpfvSQuylQlTGkAOtUEksbSKVobiXeXWvvc2Pl2nsuur9ha6cu8Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="DyCJ/C4q"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=HvBy8orw; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=DyCJ/C4q; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=HvBy8orw
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 4B0274016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598504; bh=nr7uidUWzPw+0hGqlQiPW+J
 HOZQfUsJ0DcdJ0y26Dyg=; b=DyCJ/C4qfPf2nBuLAxc4StPDrtlPWC6OOK19cPqFaTTDclZRwo
 TKdzUFJhC6gQ3C6HIcCfawn9CJ6N28vzi3Y9+U5YMX5bLusPFOoxvK+YYkaPdatEQOF57C6hw0s
 oA8RnB8yTAOffV3iIj12PAZWJVwXJrQiF22EekQ3A9pkMxoTutNVWlrI8LeC3x2Gg4xyqM78gqg
 gW+mNLUtWigi34orRsMyn250gALAKERt4N1UXftUpRtbzQV5mSw1iF5FOxvFTITYWg790WmINag
 4tYbMqmeBbB5NUoVWuqvzZPkI/ka80vcSVl7a6Lxa+8X2lZlSmurJFq150CtMbXJCbw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598504; bh=nr7uidUWzPw+0hGqlQiPW+J
 HOZQfUsJ0DcdJ0y26Dyg=; b=HvBy8orwphMrwN++YP0FcOZZG5rAh2Hz9r3pDoCSEuFtAADrsz
 b+E+ZJ86MBjFeqEpTBLkxezVQ4Xv0DrizACA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v3 01/26] board: powerpc: Remove MPC8548CDS support
Date: Wed, 21 Oct 2026 16:00:57 +0000
Message-ID: <20261021160145.10430-2-brads@mainlining.org>
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

The MPC8548CDS board is unmaintained and lacks active community
testing. Remove the board and its SoC support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig          |  37 +--
 arch/powerpc/cpu/mpc85xx/Makefile         |   1 -
 arch/powerpc/cpu/mpc85xx/cpu_init.c       |  13 -
 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c |  57 ----
 arch/powerpc/dts/Makefile                 |   1 -
 arch/powerpc/dts/mpc8548-post.dtsi        |  36 ---
 arch/powerpc/dts/mpc8548.dtsi             |  27 --
 arch/powerpc/dts/mpc8548cds.dts           |  29 --
 arch/powerpc/dts/mpc8548cds_36b.dts       |  29 --
 arch/powerpc/include/asm/config_mpc85xx.h |   8 +-
 arch/powerpc/include/asm/immap_85xx.h     |   3 +-
 board/nxp/common/Makefile                 |   2 -
 board/nxp/common/cds_pci_ft.c             |  17 --
 board/nxp/common/cds_via.c                |  95 -------
 board/nxp/mpc8548cds/Kconfig              |  24 --
 board/nxp/mpc8548cds/MAINTAINERS          |   8 -
 board/nxp/mpc8548cds/Makefile             |  10 -
 board/nxp/mpc8548cds/ddr.c                |  51 ----
 board/nxp/mpc8548cds/law.c                |  18 --
 board/nxp/mpc8548cds/mpc8548cds.c         | 170 ------------
 board/nxp/mpc8548cds/tlb.c                |  87 ------
 configs/MPC8548CDS_36BIT_defconfig        | 108 --------
 configs/MPC8548CDS_defconfig              | 106 --------
 configs/MPC8548CDS_legacy_defconfig       | 106 --------
 doc/README.mpc85xxcds                     | 225 ----------------
 env/Kconfig                               |   1 -
 include/configs/MPC8548CDS.h              | 312 ----------------------
 27 files changed, 4 insertions(+), 1577 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
 delete mode 100644 arch/powerpc/dts/mpc8548-post.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548.dtsi
 delete mode 100644 arch/powerpc/dts/mpc8548cds.dts
 delete mode 100644 arch/powerpc/dts/mpc8548cds_36b.dts
 delete mode 100644 board/nxp/common/cds_pci_ft.c
 delete mode 100644 board/nxp/common/cds_via.c
 delete mode 100644 board/nxp/mpc8548cds/Kconfig
 delete mode 100644 board/nxp/mpc8548cds/MAINTAINERS
 delete mode 100644 board/nxp/mpc8548cds/Makefile
 delete mode 100644 board/nxp/mpc8548cds/ddr.c
 delete mode 100644 board/nxp/mpc8548cds/law.c
 delete mode 100644 board/nxp/mpc8548cds/mpc8548cds.c
 delete mode 100644 board/nxp/mpc8548cds/tlb.c
 delete mode 100644 configs/MPC8548CDS_36BIT_defconfig
 delete mode 100644 configs/MPC8548CDS_defconfig
 delete mode 100644 configs/MPC8548CDS_legacy_defconfig
 delete mode 100644 doc/README.mpc85xxcds
 delete mode 100644 include/configs/MPC8548CDS.h

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 32a140b0913..309becda5ac 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -115,12 +115,6 @@ config TARGET_P5040DS
 	imply SATA
 	imply PANIC_HANG
 
-config TARGET_MPC8548CDS
-	bool "Support MPC8548CDS"
-	select ARCH_MPC8548
-	select FSL_VIA
-	select SYS_CACHE_SHIFT_5
-
 config TARGET_P1010RDB_PA
 	bool "Support P1010RDB_PA"
 	select ARCH_P1010
@@ -427,25 +421,6 @@ config ARCH_MPC8544
 	select SYS_PPC_E500_USE_DEBUG_TLB
 	select FSL_ELBC
 
-config ARCH_MPC8548
-	bool
-	select BTB
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_NMG_DDR120
-	select SYS_FSL_ERRATUM_NMG_LBC103
-	select SYS_FSL_ERRATUM_NMG_ETSEC129
-	select SYS_FSL_ERRATUM_I2C_A004447
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR2
-	select SYS_FSL_HAS_DDR1
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_RMU
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	imply CMD_REGINFO
-
 config ARCH_MPC8560
 	bool
 	select FSL_LAW
@@ -1031,7 +1006,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_MPC8536	|| \
 				ARCH_MPC8540	|| \
 				ARCH_MPC8544	|| \
-				ARCH_MPC8548	|| \
 				ARCH_MPC8560	|| \
 				ARCH_P1010	|| \
 				ARCH_P1011	|| \
@@ -1182,7 +1156,6 @@ config SYS_FSL_ERRATUM_I2C_A004447
 config SYS_FSL_A004447_SVR_REV
 	hex
 	depends on SYS_FSL_ERRATUM_I2C_A004447
-	default 0x00 if ARCH_MPC8548
 	default 0x10 if ARCH_P1010
 	default 0x11 if ARCH_P1023 || ARCH_P2041 || ARCH_BSC9132
 	default 0x20 if ARCH_P3041 || ARCH_P4080
@@ -1282,8 +1255,7 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1024	|| \
 			ARCH_P1025	|| \
 			ARCH_P2020
-	default 10 if	ARCH_MPC8544	|| \
-			ARCH_MPC8548
+	default 10 if ARCH_MPC8544
 	default 8 if	ARCH_MPC8540	|| \
 			ARCH_MPC8560
 	help
@@ -1389,7 +1361,7 @@ config FSL_ELBC
 config SYS_PPC_E500_DEBUG_TLB
 	int "Temporary TLB entry for external debugger"
 	depends on SYS_PPC_E500_USE_DEBUG_TLB
-	default 0 if	ARCH_MPC8544 || ARCH_MPC8548
+	default 0 if ARCH_MPC8544
 	default 1 if	ARCH_MPC8536
 	default 2 if	ARCH_P1011	|| \
 			ARCH_P1020	|| \
@@ -1425,7 +1397,6 @@ config SYS_FSL_IFC_CLK_DIV
 config SYS_FSL_LBC_CLK_DIV
 	int "Divider of platform clock"
 	depends on FSL_ELBC || ARCH_MPC8540 || \
-		ARCH_MPC8548 || \
 		ARCH_MPC8560
 
 	default 2 if	ARCH_P2041	|| \
@@ -1537,12 +1508,8 @@ config TPL_SYS_MPC85XX_NO_RESETVEC
 	  the section .bootpg is placed in the previous 4k of the .text section,
 	  of the SPL portion of the binary.
 
-config FSL_VIA
-	bool
-
 source "board/CZ.NIC/turris_1x/Kconfig"
 source "board/emulation/qemu-ppce500/Kconfig"
-source "board/nxp/mpc8548cds/Kconfig"
 source "board/nxp/p1010rdb/Kconfig"
 source "board/nxp/p1_p2_rdb_pc/Kconfig"
 source "board/nxp/p2041rdb/Kconfig"
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index bf74228efde..6717e2c4578 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS2) += fsl_corenet2_serdes.o
 obj-$(CONFIG_ARCH_C29X)	+= c29x_serdes.o
 obj-$(CONFIG_ARCH_MPC8536) += mpc8536_serdes.o
 obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
-obj-$(CONFIG_ARCH_MPC8548) += mpc8548_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1011)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 414782c835f..4390f754809 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -384,19 +384,6 @@ ulong cpu_init_f(void)
 #if defined(CONFIG_NXP_ESBC) && !defined(CONFIG_SYS_RAMBOOT)
 	struct law_entry law;
 #endif
-#ifdef CONFIG_ARCH_MPC8548
-	ccsr_local_ecm_t *ecm = (void *)(CFG_SYS_MPC85xx_ECM_ADDR);
-	uint svr = get_svr();
-
-	/*
-	 * CPU2 errata workaround: A core hang possible while executing
-	 * a msync instruction and a snoopable transaction from an I/O
-	 * master tagged to make quick forward progress is present.
-	 * Fixed in silicon rev 2.1.
-	 */
-	if ((SVR_MAJ(svr) == 1) || ((SVR_MAJ(svr) == 2 && SVR_MIN(svr) == 0x0)))
-		out_be32(&ecm->eebpcr, in_be32(&ecm->eebpcr) | (1 << 16));
-#endif
 
 	disable_tlb(14);
 	disable_tlb(15);
diff --git a/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c b/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
deleted file mode 100644
index 924afa096d1..00000000000
--- a/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2010 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <log.h>
-#include <asm/io.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_serdes.h>
-
-#define SRDS1_MAX_LANES		8
-
-static u32 serdes1_prtcl_map;
-
-static u8 serdes1_cfg_tbl[][SRDS1_MAX_LANES] = {
-	[0x3] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO1, SRIO1, SRIO1, SRIO1},
-	[0x4] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO1, SRIO1, SRIO1, SRIO1},
-	[0x5] = {NONE, NONE, NONE, NONE, SRIO1, SRIO1, SRIO1, SRIO1},
-	[0x6] = {NONE, NONE, NONE, NONE, SRIO1, SRIO1, SRIO1, SRIO1},
-	[0x7] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1},
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
-	u32 srds1_cfg = (pordevsr & MPC85xx_PORDEVSR_IO_SEL) >>
-				MPC85xx_PORDEVSR_IO_SEL_SHIFT;
-	int lane;
-
-	if (serdes1_prtcl_map & (1 << NONE))
-		return;
-
-	debug("PORDEVSR[IO_SEL] = %x\n", srds1_cfg);
-
-	if (srds1_cfg >= ARRAY_SIZE(serdes1_cfg_tbl)) {
-		printf("Invalid PORDEVSR[IO_SEL] = %d\n", srds1_cfg);
-		return;
-	}
-
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes1_cfg_tbl[srds1_cfg][lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index a9075c16fef..2540684307e 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -8,7 +8,6 @@ dtb-$(CONFIG_TARGET_KMSUPX5) += kmsupc5.dtb kmsupm5.dtb
 dtb-$(CONFIG_TARGET_KMTEGR1) += kmtegr1.dtb
 dtb-$(CONFIG_TARGET_KMTEPR2) += kmtepr2.dtb
 dtb-$(CONFIG_TARGET_MPC837XERDB) += mpc8379erdb.dtb
-dtb-$(CONFIG_TARGET_MPC8548CDS) += mpc8548cds.dtb mpc8548cds_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PA) += p1010rdb-pa.dtb p1010rdb-pa_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
diff --git a/arch/powerpc/dts/mpc8548-post.dtsi b/arch/powerpc/dts/mpc8548-post.dtsi
deleted file mode 100644
index 97c3ce6e74d..00000000000
--- a/arch/powerpc/dts/mpc8548-post.dtsi
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * MPC8548 Silicon/SoC Device Tree Source (post include)
- *
- * Copyright 2012 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
- */
-
-&soc {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	device_type = "soc";
-	compatible = "fsl,mpc8548-immr", "simple-bus";
-	bus-frequency = <0x0>;
-
-	mpic: pic@40000 {
-		interrupt-controller;
-		#address-cells = <0>;
-		#interrupt-cells = <4>;
-		reg = <0x40000 0x40000>;
-		compatible = "fsl,mpic";
-		device_type = "open-pic";
-		big-endian;
-		single-cpu-affinity;
-		last-interrupt-source = <255>;
-	};
-};
-
-&pcie {
-	compatible = "fsl,mpc8548-pcie", "fsl,pcie-fsl-qoriq";
-	law_trgt_if = <2>;
-	#address-cells = <3>;
-	#size-cells = <2>;
-	device_type = "pci";
-	bus-range = <0x0 0xff>;
-};
diff --git a/arch/powerpc/dts/mpc8548.dtsi b/arch/powerpc/dts/mpc8548.dtsi
deleted file mode 100644
index b24567dc653..00000000000
--- a/arch/powerpc/dts/mpc8548.dtsi
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * MPC8548CDS Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
- */
-
-/dts-v1/;
-
-/include/ "e500v2_power_isa.dtsi"
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8548@0 {
-			device_type = "cpu";
-			reg = <0>;
-		};
-	};
-};
diff --git a/arch/powerpc/dts/mpc8548cds.dts b/arch/powerpc/dts/mpc8548cds.dts
deleted file mode 100644
index 3b927bd2657..00000000000
--- a/arch/powerpc/dts/mpc8548cds.dts
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * MPC8548CDS Device Tree Source
- *
- * Copyright 2006 - 2012 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
- */
-
-/include/ "mpc8548.dtsi"
-
-/ {
-	model = "fsl,MPC8548CDS";
-	compatible = "fsl,MPC8548CDS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	soc: soc8548@e0000000 {
-		ranges = <0x0 0x0 0xe0000000 0x100000>;
-	};
-
-	pcie: pcie@e000a000 {
-		reg = <0x0 0xe000a000 0x0 0x1000>;	/* registers */
-		ranges = <0x01000000 0x0 0x00000000 0x0 0xe3000000 0x0 0x00100000   /* downstream I/O */
-			  0x02000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-};
-
-/include/ "mpc8548-post.dtsi"
diff --git a/arch/powerpc/dts/mpc8548cds_36b.dts b/arch/powerpc/dts/mpc8548cds_36b.dts
deleted file mode 100644
index 98d7c2410bc..00000000000
--- a/arch/powerpc/dts/mpc8548cds_36b.dts
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * MPC8548CDS (36-bit address map) Device Tree Source
- *
- * Copyright 2012 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
- */
-
-/include/ "mpc8548.dtsi"
-
-/ {
-	model = "fsl,MPC8548CDS";
-	compatible = "fsl,MPC8548CDS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	soc: soc8548@fe0000000 {
-		ranges = <0x0 0xf 0xe0000000 0x100000>;
-	};
-
-	pcie: pcie@fe000a000 {
-		reg = <0xf 0xe000a000 0x0 0x1000>;	/* registers */
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xe3000000 0x0 0x00100000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-};
-
-/include/ "mpc8548-post.dtsi"
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index abdaffbe00b..d7d18c3eeca 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -10,13 +10,7 @@
 
 #include <fsl_ddrc_version.h>
 
-#if defined(CONFIG_ARCH_MPC8548)
-#define CFG_SYS_FSL_SRIO_MAX_PORTS	1
-#define CFG_SYS_FSL_SRIO_OB_WIN_NUM	9
-#define CFG_SYS_FSL_SRIO_IB_WIN_NUM	5
-#define CFG_SYS_FSL_SRIO_MSG_UNIT_NUM	2
-
-#elif defined(CONFIG_ARCH_P1021)
+#if defined(CONFIG_ARCH_P1021)
 #define QE_MURAM_SIZE			0x6000UL
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 3565a287154..9e082a87a3b 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -123,8 +123,7 @@ typedef struct ccsr_i2c {
 	u8	res[4096 - 1 * sizeof(struct fsl_i2c_base)];
 } ccsr_i2c_t;
 
-#if defined(CONFIG_ARCH_MPC8540) || \
-	defined(CONFIG_ARCH_MPC8548)
+#if defined(CONFIG_ARCH_MPC8540)
 /* DUART Registers */
 typedef struct ccsr_duart {
 	u8	res1[1280];
diff --git a/board/nxp/common/Makefile b/board/nxp/common/Makefile
index dafd3717948..46e43a4e45a 100644
--- a/board/nxp/common/Makefile
+++ b/board/nxp/common/Makefile
@@ -27,7 +27,6 @@ I2C_COMMON=y
 endif
 
 obj-$(CONFIG_FSL_CADMUS)	+= cadmus.o
-obj-$(CONFIG_FSL_VIA)		+= cds_via.o
 obj-$(CONFIG_FMAN_ENET)	+= fman.o
 ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_FSL_NGPIXIS)	+= ngpixis.o
@@ -49,7 +48,6 @@ else
 obj-$(CONFIG_DEEP_SLEEP)		+= mpc85xx_sleep.o
 endif
 
-obj-$(CONFIG_TARGET_MPC8548CDS)	+= cds_pci_ft.o
 
 obj-$(CONFIG_TARGET_P3041DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P4080DS)		+= ics307_clk.o
diff --git a/board/nxp/common/cds_pci_ft.c b/board/nxp/common/cds_pci_ft.c
deleted file mode 100644
index 56b01e3f51f..00000000000
--- a/board/nxp/common/cds_pci_ft.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2004 Freescale Semiconductor.
- */
-
-#include <linux/libfdt.h>
-#include <fdt_support.h>
-#include "cadmus.h"
-
-#if defined(CONFIG_OF_BOARD_SETUP)
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	ft_cpu_setup(blob, bd);
-
-	return 0;
-}
-#endif
diff --git a/board/nxp/common/cds_via.c b/board/nxp/common/cds_via.c
deleted file mode 100644
index 6fc3a21780f..00000000000
--- a/board/nxp/common/cds_via.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2006 Freescale Semiconductor.
- */
-
-#include <pci.h>
-
-/* Config the VIA chip */
-void mpc85xx_config_via(struct pci_controller *hose,
-			pci_dev_t dev, struct pci_config_table *tab)
-{
-	pci_dev_t bridge;
-	unsigned int cmdstat;
-
-	/* Enable USB and IDE functions */
-	pci_hose_write_config_byte(hose, dev, 0x48, 0x08);
-
-	pci_hose_read_config_dword(hose, dev, PCI_COMMAND, &cmdstat);
-	cmdstat |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY| PCI_COMMAND_MASTER;
-	pci_hose_write_config_dword(hose, dev, PCI_COMMAND, cmdstat);
-	pci_hose_write_config_byte(hose, dev, PCI_CACHE_LINE_SIZE, 0x08);
-	pci_hose_write_config_byte(hose, dev, PCI_LATENCY_TIMER, 0x80);
-
-	/*
-	 * Force the backplane P2P bridge to have a window
-	 * open from 0x00000000-0x00001fff in PCI I/O space.
-	 * This allows legacy I/O (i8259, etc) on the VIA
-	 * southbridge to be accessed.
-	 */
-#ifdef CONFIG_TARGET_MPC8548CDS_LEGACY
-	bridge = PCI_BDF(0, 17, 0);
-#else
-	bridge = PCI_BDF(0, 28, 0);
-#endif
-	pci_hose_write_config_byte(hose, bridge, PCI_IO_BASE, 0);
-	pci_hose_write_config_word(hose, bridge, PCI_IO_BASE_UPPER16, 0);
-	pci_hose_write_config_byte(hose, bridge, PCI_IO_LIMIT, 0x10);
-	pci_hose_write_config_word(hose, bridge, PCI_IO_LIMIT_UPPER16, 0);
-}
-
-/* Function 1, IDE */
-void mpc85xx_config_via_usbide(struct pci_controller *hose,
-			       pci_dev_t dev, struct pci_config_table *tab)
-{
-	pciauto_config_device(hose, dev);
-	/*
-	 * Since the P2P window was forced to cover the fixed
-	 * legacy I/O addresses, it is necessary to manually
-	 * place the base addresses for the IDE and USB functions
-	 * within this window.
-	 */
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_0, 0x1ff8);
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_1, 0x1ff4);
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_2, 0x1fe8);
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_3, 0x1fe4);
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_4, 0x1fd0);
-}
-
-/* Function 2, USB ports 0-1 */
-void mpc85xx_config_via_usb(struct pci_controller *hose,
-			    pci_dev_t dev, struct pci_config_table *tab)
-{
-	pciauto_config_device(hose, dev);
-
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_4, 0x1fa0);
-}
-
-/* Function 3, USB ports 2-3 */
-void mpc85xx_config_via_usb2(struct pci_controller *hose,
-			     pci_dev_t dev, struct pci_config_table *tab)
-{
-	pciauto_config_device(hose, dev);
-
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_4, 0x1f80);
-}
-
-/* Function 5, Power Management */
-void mpc85xx_config_via_power(struct pci_controller *hose,
-			      pci_dev_t dev, struct pci_config_table *tab)
-{
-	pciauto_config_device(hose, dev);
-
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_0, 0x1e00);
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_1, 0x1dfc);
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_2, 0x1df8);
-}
-
-/* Function 6, AC97 Interface */
-void mpc85xx_config_via_ac97(struct pci_controller *hose,
-			     pci_dev_t dev, struct pci_config_table *tab)
-{
-	pciauto_config_device(hose, dev);
-
-	pci_hose_write_config_dword(hose, dev, PCI_BASE_ADDRESS_0, 0x1c00);
-}
diff --git a/board/nxp/mpc8548cds/Kconfig b/board/nxp/mpc8548cds/Kconfig
deleted file mode 100644
index e43c2030e00..00000000000
--- a/board/nxp/mpc8548cds/Kconfig
+++ /dev/null
@@ -1,24 +0,0 @@
-if TARGET_MPC8548CDS
-
-config PCI1
-	def_bool y
-
-config FSL_CADMUS
-	def_bool y
-
-config INTERRUPTS
-	def_bool y
-
-config SYS_BOARD
-	default "mpc8548cds"
-
-config SYS_VENDOR
-	default "nxp"
-
-config SYS_CONFIG_NAME
-	default "MPC8548CDS"
-
-config TARGET_MPC8548CDS_LEGACY
-	bool "Legacy platform support"
-
-endif
diff --git a/board/nxp/mpc8548cds/MAINTAINERS b/board/nxp/mpc8548cds/MAINTAINERS
deleted file mode 100644
index 51e62a34365..00000000000
--- a/board/nxp/mpc8548cds/MAINTAINERS
+++ /dev/null
@@ -1,8 +0,0 @@
-MPC8548CDS BOARD
-M:	Priyanka Jain <priyanka.jain@nxp.com>
-S:	Maintained
-F:	board/nxp/mpc8548cds/
-F:	include/configs/MPC8548CDS.h
-F:	configs/MPC8548CDS_defconfig
-F:	configs/MPC8548CDS_36BIT_defconfig
-F:	configs/MPC8548CDS_legacy_defconfig
diff --git a/board/nxp/mpc8548cds/Makefile b/board/nxp/mpc8548cds/Makefile
deleted file mode 100644
index 5ed40e92eb9..00000000000
--- a/board/nxp/mpc8548cds/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright 2004 Freescale Semiconductor.
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-
-obj-y	+= mpc8548cds.o
-obj-y	+= ddr.o
-obj-y	+= law.o
-obj-y	+= tlb.o
diff --git a/board/nxp/mpc8548cds/ddr.c b/board/nxp/mpc8548cds/ddr.c
deleted file mode 100644
index 4b8ddcc3ae4..00000000000
--- a/board/nxp/mpc8548cds/ddr.c
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2008 Freescale Semiconductor, Inc.
- */
-
-#include <fsl_ddr_sdram.h>
-#include <fsl_ddr_dimm_params.h>
-
-void fsl_ddr_board_options(memctl_options_t *popts,
-				dimm_params_t *pdimm,
-				unsigned int ctrl_num)
-{
-	/*
-	 * Factors to consider for clock adjust:
-	 *	- number of chips on bus
-	 *	- position of slot
-	 *	- DDR1 vs. DDR2?
-	 *	- ???
-	 *
-	 * This needs to be determined on a board-by-board basis.
-	 *	0110	3/4 cycle late
-	 *	0111	7/8 cycle late
-	 */
-	popts->clk_adjust = 7;
-
-	/*
-	 * Factors to consider for CPO:
-	 *	- frequency
-	 *	- ddr1 vs. ddr2
-	 */
-	popts->cpo_override = 10;
-
-	/*
-	 * Factors to consider for write data delay:
-	 *	- number of DIMMs
-	 *
-	 * 1 = 1/4 clock delay
-	 * 2 = 1/2 clock delay
-	 * 3 = 3/4 clock delay
-	 * 4 = 1   clock delay
-	 * 5 = 5/4 clock delay
-	 * 6 = 3/2 clock delay
-	 */
-	popts->write_data_delay = 3;
-
-	/*
-	 * Factors to consider for half-strength driver enable:
-	 *	- number of DIMMs installed
-	 */
-	popts->half_strength_driver_enable = 0;
-}
diff --git a/board/nxp/mpc8548cds/law.c b/board/nxp/mpc8548cds/law.c
deleted file mode 100644
index 2334870fda0..00000000000
--- a/board/nxp/mpc8548cds/law.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2008,2010-2011 Freescale Semiconductor, Inc.
- *
- * (C) Copyright 2000
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-#include <config.h>
-#include <asm/fsl_law.h>
-#include <asm/mmu.h>
-
-struct law_entry law_table[] = {
-	/* LBC window - maps 256M */
-	SET_LAW(CFG_SYS_LBC_SDRAM_BASE_PHYS, LAW_SIZE_256M, LAW_TRGT_IF_LBC),
-};
-
-int num_law_entries = ARRAY_SIZE(law_table);
diff --git a/board/nxp/mpc8548cds/mpc8548cds.c b/board/nxp/mpc8548cds/mpc8548cds.c
deleted file mode 100644
index 7810010fd04..00000000000
--- a/board/nxp/mpc8548cds/mpc8548cds.c
+++ /dev/null
@@ -1,170 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2004, 2007, 2009-2011 Freescale Semiconductor, Inc.
- *
- * (C) Copyright 2002 Scott McNutt <smcnutt@artesyncp.com>
- */
-
-#include <config.h>
-#include <display_options.h>
-#include <init.h>
-#include <net.h>
-#include <pci.h>
-#include <vsprintf.h>
-#include <asm/processor.h>
-#include <asm/mmu.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_pci.h>
-#include <fsl_ddr_sdram.h>
-#include <asm/fsl_serdes.h>
-#include <miiphy.h>
-#include <linux/delay.h>
-#include <linux/libfdt.h>
-#include <fdt_support.h>
-#include <tsec.h>
-#include <fsl_mdio.h>
-#include <netdev.h>
-
-#include "../common/cadmus.h"
-#include "../common/eeprom.h"
-#include "../common/via.h"
-
-void local_bus_init(void);
-
-int checkboard (void)
-{
-	volatile ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	volatile ccsr_local_ecm_t *ecm = (void *)(CFG_SYS_MPC85xx_ECM_ADDR);
-
-	/* PCI slot in USER bits CSR[6:7] by convention. */
-	uint pci_slot = get_pci_slot ();
-
-	uint cpu_board_rev = get_cpu_board_revision ();
-
-	puts("Board: MPC8548CDS");
-	printf(" Carrier Rev: 0x%02x, PCI Slot %d\n",
-			get_board_version(), pci_slot);
-	printf("       Daughtercard Rev: %d.%d (0x%04x)\n",
-		MPC85XX_CPU_BOARD_MAJOR (cpu_board_rev),
-		MPC85XX_CPU_BOARD_MINOR (cpu_board_rev), cpu_board_rev);
-	/*
-	 * Initialize local bus.
-	 */
-	local_bus_init ();
-
-	/*
-	 * Hack TSEC 3 and 4 IO voltages.
-	 */
-	gur->tsec34ioovcr = 0xe7e0;	/*  1110 0111 1110 0xxx */
-
-	ecm->eedr = 0xffffffff;		/* clear ecm errors */
-	ecm->eeer = 0xffffffff;		/* enable ecm errors */
-	return 0;
-}
-
-/*
- * Initialize Local Bus
- */
-void
-local_bus_init(void)
-{
-	volatile ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	volatile fsl_lbc_t *lbc = LBC_BASE_ADDR;
-
-	uint clkdiv;
-	sys_info_t sysinfo;
-
-	get_sys_info(&sysinfo);
-	clkdiv = (lbc->lcrr & LCRR_CLKDIV) * 2;
-
-	gur->lbiuiplldcr1 = 0x00078080;
-	if (clkdiv == 16) {
-		gur->lbiuiplldcr0 = 0x7c0f1bf0;
-	} else if (clkdiv == 8) {
-		gur->lbiuiplldcr0 = 0x6c0f1bf0;
-	} else if (clkdiv == 4) {
-		gur->lbiuiplldcr0 = 0x5c0f1bf0;
-	}
-
-	lbc->lcrr |= 0x00030000;
-
-	asm("sync;isync;msync");
-
-	lbc->ltesr = 0xffffffff;	/* Clear LBC error interrupts */
-	lbc->lteir = 0xffffffff;	/* Enable LBC error interrupts */
-}
-
-/*
- * Initialize SDRAM memory on the Local Bus.
- */
-void lbc_sdram_init(void)
-{
-#if defined(CONFIG_SYS_OR2_PRELIM) && defined(CONFIG_SYS_BR2_PRELIM)
-
-	uint idx;
-	volatile fsl_lbc_t *lbc = LBC_BASE_ADDR;
-	uint *sdram_addr = (uint *)CFG_SYS_LBC_SDRAM_BASE;
-	uint lsdmr_common;
-
-	puts("LBC SDRAM: ");
-	print_size(CFG_SYS_LBC_SDRAM_SIZE * 1024 * 1024,
-		   "\n");
-
-	/*
-	 * Setup SDRAM Base and Option Registers
-	 */
-	set_lbc_or(2, CONFIG_SYS_OR2_PRELIM);
-	set_lbc_br(2, CONFIG_SYS_BR2_PRELIM);
-	lbc->lbcr = CFG_SYS_LBC_LBCR;
-	asm("msync");
-
-	lbc->lsrt = CFG_SYS_LBC_LSRT;
-	lbc->mrtpr = CFG_SYS_LBC_MRTPR;
-	asm("msync");
-
-	/*
-	 * MPC8548 uses "new" 15-16 style addressing.
-	 */
-	lsdmr_common = CFG_SYS_LBC_LSDMR_COMMON;
-	lsdmr_common |= LSDMR_BSMA1516;
-
-	/*
-	 * Issue PRECHARGE ALL command.
-	 */
-	lbc->lsdmr = lsdmr_common | LSDMR_OP_PCHALL;
-	asm("sync;msync");
-	*sdram_addr = 0xff;
-	ppcDcbf((unsigned long) sdram_addr);
-	udelay(100);
-
-	/*
-	 * Issue 8 AUTO REFRESH commands.
-	 */
-	for (idx = 0; idx < 8; idx++) {
-		lbc->lsdmr = lsdmr_common | LSDMR_OP_ARFRSH;
-		asm("sync;msync");
-		*sdram_addr = 0xff;
-		ppcDcbf((unsigned long) sdram_addr);
-		udelay(100);
-	}
-
-	/*
-	 * Issue 8 MODE-set command.
-	 */
-	lbc->lsdmr = lsdmr_common | LSDMR_OP_MRW;
-	asm("sync;msync");
-	*sdram_addr = 0xff;
-	ppcDcbf((unsigned long) sdram_addr);
-	udelay(100);
-
-	/*
-	 * Issue NORMAL OP command.
-	 */
-	lbc->lsdmr = lsdmr_common | LSDMR_OP_NORMAL;
-	asm("sync;msync");
-	*sdram_addr = 0xff;
-	ppcDcbf((unsigned long) sdram_addr);
-	udelay(200);    /* Overkill. Must wait > 200 bus cycles */
-
-#endif	/* enable SDRAM init */
-}
diff --git a/board/nxp/mpc8548cds/tlb.c b/board/nxp/mpc8548cds/tlb.c
deleted file mode 100644
index 0b2afa8054d..00000000000
--- a/board/nxp/mpc8548cds/tlb.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2008, 2011 Freescale Semiconductor, Inc.
- *
- * (C) Copyright 2000
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- */
-
-#include <config.h>
-#include <asm/mmu.h>
-#include <asm/ppc.h>
-
-struct fsl_e_tlb_entry tlb_table[] = {
-	/* TLB 0 - for temp stack in cache */
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR, CFG_SYS_INIT_RAM_ADDR,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 4 * 1024 , CFG_SYS_INIT_RAM_ADDR + 4 * 1024,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 8 * 1024 , CFG_SYS_INIT_RAM_ADDR + 8 * 1024,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 12 * 1024 , CFG_SYS_INIT_RAM_ADDR + 12 * 1024,
-		      MAS3_SX|MAS3_SW|MAS3_SR, 0,
-		      0, 0, BOOKE_PAGESZ_4K, 0),
-
-	/* TLB 1 */
-	/*
-	 * Entry 0:
-	 * FLASH(cover boot page)	16M	Non-cacheable, guarded
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE, CFG_SYS_FLASH_BASE_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 0, BOOKE_PAGESZ_16M, 1),
-
-	/*
-	 * Entry 1:
-	 * CCSRBAR	1M	Non-cacheable, guarded
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_CCSRBAR, CFG_SYS_CCSRBAR_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 1, BOOKE_PAGESZ_1M, 1),
-
-	/*
-	 * Entry 2:
-	 * LBC SDRAM	64M	Cacheable, non-guarded
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_LBC_SDRAM_BASE,
-		      CFG_SYS_LBC_SDRAM_BASE_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_M,
-		      0, 2, BOOKE_PAGESZ_64M, 1),
-
-	/*
-	 * Entry 3:
-	 * CADMUS registers	1M	Non-cacheable, guarded
-	 */
-	SET_TLB_ENTRY(1, CADMUS_BASE_ADDR, CADMUS_BASE_ADDR_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 3, BOOKE_PAGESZ_1M, 1),
-
-	/*
-	 * Entry 4:
-	 * PCI and PCIe MEM	1G	Non-cacheable, guarded
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_PCI1_MEM_VIRT, CFG_SYS_PCI1_MEM_PHYS,
-		      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 4, BOOKE_PAGESZ_1G, 1),
-
-	/*
-	 * Entry 5:
-	 * PCI1 IO	1M	Non-cacheable, guarded
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_PCI1_IO_VIRT, CFG_SYS_PCI1_IO_PHYS,
-		      MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 5, BOOKE_PAGESZ_1M, 1),
-
-	/*
-	 * Entry 6:
-	 * PCIe IO	1M	Non-cacheable, guarded
-	 */
-	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_IO_VIRT, CFG_SYS_PCIE1_IO_PHYS,
-		      MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
-		      0, 6, BOOKE_PAGESZ_1M, 1),
-};
-
-int num_tlb_entries = ARRAY_SIZE(tlb_table);
diff --git a/configs/MPC8548CDS_36BIT_defconfig b/configs/MPC8548CDS_36BIT_defconfig
deleted file mode 100644
index 45dfb9237cf..00000000000
--- a/configs/MPC8548CDS_36BIT_defconfig
+++ /dev/null
@@ -1,108 +0,0 @@
-CONFIG_PPC=y
-CONFIG_SYS_IMMR=0xE0000000
-CONFIG_TEXT_BASE=0xFFF80000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="mpc8548cds_36b"
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_ENV_ADDR=0xFFF60000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_SYS_SRIO=y
-CONFIG_SRIO1=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_MPC8548CDS=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_UBOOTPATH="8548cds/u-boot.bin"
-CONFIG_PCIE1=y
-CONFIG_PHYS_64BIT=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-# CONFIG_MISC_INIT_R is not set
-CONFIG_ID_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_CCID=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_PCI=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="8548cds/uImage.uboot"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC0"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_GATEWAYIP=y
-CONFIG_GATEWAYIP="192.168.1.1"
-CONFIG_USE_IPADDR=y
-CONFIG_IPADDR="192.168.1.253"
-CONFIG_USE_NETMASK=y
-CONFIG_NETMASK="255.255.255.0"
-CONFIG_USE_ROOTPATH=y
-CONFIG_ROOTPATH="/nfsroot"
-CONFIG_USE_SERVERIP=y
-CONFIG_SERVERIP="192.168.1.1"
-CONFIG_SPD_EEPROM=y
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFF807001
-CONFIG_SYS_OR0_PRELIM=0xFF806E65
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xFF007001
-CONFIG_SYS_OR1_PRELIM=0xFF806E65
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xF0007861
-CONFIG_SYS_OR2_PRELIM=0xFC006901
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xF8006801
-CONFIG_SYS_OR3_PRELIM=0xFFF00FF7
-CONFIG_DM_I2C=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x57
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_DM_PCI_COMPAT=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_ADDR_MAP=y
diff --git a/configs/MPC8548CDS_defconfig b/configs/MPC8548CDS_defconfig
deleted file mode 100644
index 13e352b5d1c..00000000000
--- a/configs/MPC8548CDS_defconfig
+++ /dev/null
@@ -1,106 +0,0 @@
-CONFIG_PPC=y
-CONFIG_SYS_IMMR=0xE0000000
-CONFIG_TEXT_BASE=0xFFF80000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="mpc8548cds"
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_ENV_ADDR=0xFFF60000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_SYS_SRIO=y
-CONFIG_SRIO1=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_MPC8548CDS=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_UBOOTPATH="8548cds/u-boot.bin"
-CONFIG_PCIE1=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-# CONFIG_MISC_INIT_R is not set
-CONFIG_ID_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_CCID=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_PCI=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="8548cds/uImage.uboot"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC0"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_GATEWAYIP=y
-CONFIG_GATEWAYIP="192.168.1.1"
-CONFIG_USE_IPADDR=y
-CONFIG_IPADDR="192.168.1.253"
-CONFIG_USE_NETMASK=y
-CONFIG_NETMASK="255.255.255.0"
-CONFIG_USE_ROOTPATH=y
-CONFIG_ROOTPATH="/nfsroot"
-CONFIG_USE_SERVERIP=y
-CONFIG_SERVERIP="192.168.1.1"
-CONFIG_SPD_EEPROM=y
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFF801001
-CONFIG_SYS_OR0_PRELIM=0xFF806E65
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xFF001001
-CONFIG_SYS_OR1_PRELIM=0xFF806E65
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xF0001861
-CONFIG_SYS_OR2_PRELIM=0xFC006901
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xF8000801
-CONFIG_SYS_OR3_PRELIM=0xFFF00FF7
-CONFIG_DM_I2C=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x57
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_DM_PCI_COMPAT=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
diff --git a/configs/MPC8548CDS_legacy_defconfig b/configs/MPC8548CDS_legacy_defconfig
deleted file mode 100644
index 1a5c1becbb6..00000000000
--- a/configs/MPC8548CDS_legacy_defconfig
+++ /dev/null
@@ -1,106 +0,0 @@
-CONFIG_PPC=y
-CONFIG_SYS_IMMR=0xE0000000
-CONFIG_TEXT_BASE=0xFFF80000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="mpc8548cds"
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_ENV_ADDR=0xFFF60000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_SYS_SRIO=y
-CONFIG_SRIO1=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_MPC8548CDS=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_TARGET_MPC8548CDS_LEGACY=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_UBOOTPATH="8548cds/u-boot.bin"
-CONFIG_PCIE1=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-# CONFIG_MISC_INIT_R is not set
-CONFIG_ID_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_CCID=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_PCI=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="8548cds/uImage.uboot"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC0"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_GATEWAYIP=y
-CONFIG_GATEWAYIP="192.168.1.1"
-CONFIG_USE_IPADDR=y
-CONFIG_IPADDR="192.168.1.253"
-CONFIG_USE_NETMASK=y
-CONFIG_NETMASK="255.255.255.0"
-CONFIG_USE_ROOTPATH=y
-CONFIG_ROOTPATH="/nfsroot"
-CONFIG_USE_SERVERIP=y
-CONFIG_SERVERIP="192.168.1.1"
-CONFIG_SPD_EEPROM=y
-CONFIG_CHIP_SELECTS_PER_CTRL=2
-CONFIG_DDR_ECC=y
-CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFF801001
-CONFIG_SYS_OR0_PRELIM=0xFF806E65
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xFF001001
-CONFIG_SYS_OR1_PRELIM=0xFF806E65
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xF0001861
-CONFIG_SYS_OR2_PRELIM=0xFC006901
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xF8000801
-CONFIG_SYS_OR3_PRELIM=0xFFF00FF7
-CONFIG_DM_I2C=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x57
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_SYS_MAX_FLASH_BANKS=2
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_DM_PCI_COMPAT=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
diff --git a/doc/README.mpc85xxcds b/doc/README.mpc85xxcds
deleted file mode 100644
index 79d71cb37f6..00000000000
--- a/doc/README.mpc85xxcds
+++ /dev/null
@@ -1,225 +0,0 @@
-Motorola MPC85xxCDS boards
---------------------------
-
-The CDS family of boards consists of a PCI backplane called the
-"Arcadia", a PCI-form-factor carrier card that plugs into a PCI slot,
-and a CPU daughter card that bolts onto the daughter card.
-
-Much of the content of the README.mpc85xxads for the 85xx ADS boards
-applies to the 85xx CDS boards as well.	 In particular the toolchain,
-the switch nomenclature, and the basis for the memory map.  There are
-some differences, though.
-
-
-Building U-Boot
----------------
-
-The Binutils in current ELDK toolchain will not support MPC85xx
-chip.  You need to use binutils-2.14.tar.bz2 (or newer) from
-    http://ftp.gnu.org/gnu/binutils.
-
-The 85xx CDS code base is known to compile using:
-    gcc (GCC) 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a)
-
-
-Memory Map
-----------
-
-The memory map for U-Boot and linux has been extended w.r.t. the ADS
-platform to allow for utilization of all 85xx CDS devices.  The memory
-map is setup for linux to operate properly.  The linux source when
-configured for MPC85xx CDS has been updated to reflect the new memory
-map.
-
-The mapping is:
-
-   0x0000_0000	   0x7fff_ffff	   DDR			   2G
-   0x8000_0000	   0x9fff_ffff	   PCI1 MEM		   512M
-   0xa000_0000	   0xbfff_ffff	   PCI2 MEM		   512M
-   0xe000_0000	   0xe00f_ffff	   CCSR			   1M
-   0xe200_0000	   0xe2ff_ffff	   PCI1 IO		   16M
-   0xe300_0000	   0xe3ff_ffff	   PCI2 IO		   16M
-   0xf000_0000	   0xf7ff_ffff	   SDRAM		   128M
-   0xf800_0000	   0xf80f_ffff	   NVRAM/CADMUS (*)	   1M
-   0xff00_0000	   0xff7f_ffff	   FLASH (2nd bank)	   8M
-   0xff80_0000	   0xffff_ffff	   FLASH (boot bank)	   8M
-
-   (*) The system control registers (CADMUS) start at offset 0xfdb0_4000
-   within the NVRAM/CADMUS region of memory.
-
-
-Using Flash
------------
-
-The CDS board  has two flash banks, each 8MB in size (2^23 = 0x00800000).
-There is a switch which allows the boot-bank to be selected.  The switch
-settings for updating flash are given below.
-
-The U-Boot commands for copying the boot-bank into the secondary bank are
-as follows:
-
-     erase ff780000 ff7fffff
-     cp.b fff80000 ff780000 80000
-
-
-U-Boot/kermit commands for downloading an image, then copying
-it into the secondary bank:
-
-     loadb
-     [Drop to kermit:
-	^\c
-	send <u-boot-bin-image>
-	c
-     ]
-
-     erase ff780000 ff7fffff
-     cp.b $loadaddr ff780000 80000
-
-
-U-Boot commands for downloading an image via tftp and flashing
-it into the second bank:
-
-     tftp 10000 <u-boot.bin.image>
-     erase ff780000 ff7fffff
-     cp.b 10000 ff780000 80000
-
-
-After copying the image into the second bank of flash, be sure to toggle
-SW2[2] on the carrier card before resetting the board in order to set the
-secondary bank as the boot-bank.
-
-
-Carrier Board Switches
-----------------------
-
-As a reminder, you should read the README.mpc85xxads too.
-
-Most switches on the carrier board should not be changed.  The only
-user-settable switches on the carrier board are used to configure
-the flash banks and determining the PCI slot.
-
-The first two bits of SW2 control how flash is used on the board:
-
-      12345678
-      --------
-  SW2=00XXXXXX	   FLASH:  Boot bank 1, bank 2 available.
-      01XXXXXX	   FLASH:  Boot bank 2, bank 1 available (swapped).
-      10XXXXXX	   FLASH:  Boot promjet, bank 1 available
-      11XXXXXX	   FLASH:  Boot promjet, bank 2 available
-
-The boot bank is always mapped to FF80_0000 and listed first by
-the "flinfo" command.  The secondary bank is always FF00_0000.
-
-When using PCI, linux needs to know to which slot the CDS carrier is
-connected..  By convention, the user-specific bits of SW2 are used to
-convey this information:
-
-      12345678
-      --------
-  SW2=xxxxxx00	   PCI SLOT INFORM: The CDS carrier is in slot0 of the Arcadia
-      xxxxxx01	   PCI SLOT INFORM: The CDS carrier is in slot1 of the Arcadia
-      xxxxxx10	   PCI SLOT INFORM: The CDS carrier is in slot2 of the Arcadia
-      xxxxxx11	   PCI SLOT INFORM: The CDS carrier is in slot3 of the Arcadia
-
-These are cleverly, er, clearly silkscreened as Slot 1 through 4,
-respectively, on the Arcadia near the support posts.
-
-
-The default setting of all switches on the carrier board is:
-
-      12345678
-      --------
-  SW1=01101100
-  SW2=0x1111yy	   x=Flash bank, yy=PCI slot
-  SW3=11101111
-  SW4=10001000
-
-
-8555/41 CPU Card Switches
--------------------------
-
-Most switches on the CPU Card should not be changed.  However, the
-frequency can be changed by setting SW3:
-
-      12345678
-      --------
-  SW3=XX00XXXX == CORE:CCB 2:1
-      XX01XXXX == CORE:CCB 5:2
-      XX10XXXX == CORE:CCB 3:1
-      XX11XXXX == CORE:CCB 7:2
-      XXXX1000 == CCB:SYSCLK 8:1
-      XXXX1010 == CCB:SYSCLK 10:1
-
-A safe default setting for all switches on the CPU board is:
-
-      12345678
-      --------
-  SW1=10001111
-  SW2=01000111
-  SW3=00001000
-  SW4=11111110
-
-
-8548 CPU Card Switches
-----------------------
-And, just to be confusing, in this set of switches:
-
-    ON  = 1
-    OFF = 0
-
-Default
-  SW1=11111101
-  SW2=10011111
-  SW3=11001000    (8X) (2:1)
-  SW4=11110011
-
-  SW3=X000XXXX  == CORE:CCB    4:1
-      X001XXXX  == CORE:CCB    9:2
-      X010XXXX  == CORE:CCB    1:1
-      X011XXXX  == CORE:CCB    3:2
-      X100XXXX  == CORE:CCB    2:1
-      X101XXXX  == CORE:CCB    5:2
-      X110XXXX  == CORE:CCB    3:1
-      X111XXXX  == CORE:CCB    7:2
-      XXXX0000  == CCB:SYSCLK 16:1
-      XXXX0001  == RESERVED
-      XXXX0010  == CCB:SYSCLK  2:1
-      XXXX0011  == CCB:SYSCLK  3:1
-      XXXX0100  == CCB:SYSCLK  4:1
-      XXXX0101  == CCB:SYSCLK  5:1
-      XXXX0110  == CCB:SYSCLK  6:1
-      XXXX0111  == RESERVED
-      XXXX1000  == CCB:SYSCLK  8:1
-      XXXX1001  == CCB:SYSCLK  9:1
-      XXXX1010  == CCB:SYSCLK 10:1
-      XXXX1011  == RESERVED
-      XXXX1100  == CCB:SYSCLK 12:1
-      XXXX1101  == CCB:SYSCLK 20:1
-      XXXX1110  == RESERVED
-      XXXX1111  == RESERVED
-
-
-eDINK Info
-----------
-
-One bank of flash may contain an eDINK image.
-
-Memory Map:
-
-   CCSRBAR @ 0xe0000000
-   Flash Bank 1 @ 0xfe000000
-   Flash Bank 2 @ 0xff000000
-   Ram @ 0
-
-Commands for downloading a U-Boot image to memory from edink:
-
-   env -c
-   time -s 4/8/2004 4:30p
-   dl -k -b -o 100000
-   [Drop to kermit:
-	^\c
-	transmit /binary <u-boot-bin-image>
-	c
-   ]
-
-   fu -l 100000 fe780000 80000
diff --git a/env/Kconfig b/env/Kconfig
index c6df09a3349..fa4cf30af39 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -156,7 +156,6 @@ config ENV_IS_IN_FLASH
 	default y if M548x || M547x || M5282
 	default y if MCF532x || MCF52x2
 	default y if MPC86xx || MPC83xx
-	default y if ARCH_MPC8548
 	default y if SH && !CPU_SH4
 	help
 	  Define this if you have a flash device which you want to use for the
diff --git a/include/configs/MPC8548CDS.h b/include/configs/MPC8548CDS.h
deleted file mode 100644
index 71e81e09ddb..00000000000
--- a/include/configs/MPC8548CDS.h
+++ /dev/null
@@ -1,312 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2004, 2007, 2010-2011 Freescale Semiconductor.
- * Copyright 2020 NXP
- */
-
-/*
- * mpc8548cds board configuration file
- *
- * Please refer to doc/README.mpc85xxcds for more info.
- *
- */
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#ifndef __ASSEMBLY__
-#include <linux/stringify.h>
-#endif
-
-/*
- * Only possible on E500 Version 2 or newer cores.
- */
-
-#define CFG_SYS_CCSRBAR		0xe0000000
-#define CFG_SYS_CCSRBAR_PHYS_LOW	CFG_SYS_CCSRBAR
-
-/* DDR Setup */
-
-#define CFG_SYS_DDR_SDRAM_BASE	0x00000000	/* DDR is system memory*/
-#define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
-
-/* I2C addresses of SPD EEPROMs */
-#define SPD_EEPROM_ADDRESS	0x51	/* CTLR 0 DIMM 0 */
-
-/* Make sure required options are set */
-#ifndef CONFIG_SPD_EEPROM
-#error ("CONFIG_SPD_EEPROM is required")
-#endif
-
-/*
- * Physical Address Map
- *
- * 32bit:
- * 0x0000_0000	0x7fff_ffff	DDR			2G	cacheable
- * 0x8000_0000	0x9fff_ffff	PCI1 MEM		512M	cacheable
- * 0xa000_0000	0xbfff_ffff	PCIe MEM		512M	cacheable
- * 0xc000_0000	0xdfff_ffff	RapidIO			512M	cacheable
- * 0xe000_0000	0xe00f_ffff	CCSR			1M	non-cacheable
- * 0xe200_0000	0xe20f_ffff	PCI1 IO			1M	non-cacheable
- * 0xe300_0000	0xe30f_ffff	PCIe IO			1M	non-cacheable
- * 0xf000_0000	0xf3ff_ffff	SDRAM			64M	cacheable
- * 0xf800_0000	0xf80f_ffff	NVRAM/CADMUS		1M	non-cacheable
- * 0xff00_0000	0xff7f_ffff	FLASH (2nd bank)	8M	non-cacheable
- * 0xff80_0000	0xffff_ffff	FLASH (boot bank)	8M	non-cacheable
- *
- * 36bit:
- * 0x00000_0000	0x07fff_ffff	DDR			2G	cacheable
- * 0xc0000_0000	0xc1fff_ffff	PCI1 MEM		512M	cacheable
- * 0xc2000_0000	0xc3fff_ffff	PCIe MEM		512M	cacheable
- * 0xc4000_0000	0xc5fff_ffff	RapidIO			512M	cacheable
- * 0xfe000_0000	0xfe00f_ffff	CCSR			1M	non-cacheable
- * 0xfe200_0000	0xfe20f_ffff	PCI1 IO			1M	non-cacheable
- * 0xfe300_0000	0xfe30f_ffff	PCIe IO			1M	non-cacheable
- * 0xff000_0000	0xff3ff_ffff	SDRAM			64M	cacheable
- * 0xff800_0000	0xff80f_ffff	NVRAM/CADMUS		1M	non-cacheable
- * 0xfff00_0000	0xfff7f_ffff	FLASH (2nd bank)	8M	non-cacheable
- * 0xfff80_0000	0xfffff_ffff	FLASH (boot bank)	8M	non-cacheable
- *
- */
-
-/*
- * Local Bus Definitions
- */
-
-/*
- * FLASH on the Local Bus
- * Two banks, 8M each, using the CFI driver.
- * Boot from BR0/OR0 bank at 0xff00_0000
- * Alternate BR1/OR1 bank at 0xff80_0000
- *
- * BR0, BR1:
- *    Base address 0 = 0xff00_0000 = BR0[0:16] = 1111 1111 0000 0000 0
- *    Base address 1 = 0xff80_0000 = BR1[0:16] = 1111 1111 1000 0000 0
- *    Port Size = 16 bits = BRx[19:20] = 10
- *    Use GPCM = BRx[24:26] = 000
- *    Valid = BRx[31] = 1
- *
- * 0	4    8	  12   16   20	 24   28
- * 1111 1111 1000 0000 0001 0000 0000 0001 = ff801001	 BR0
- * 1111 1111 0000 0000 0001 0000 0000 0001 = ff001001	 BR1
- *
- * OR0, OR1:
- *    Addr Mask = 8M = ORx[0:16] = 1111 1111 1000 0000 0
- *    Reserved ORx[17:18] = 11, confusion here?
- *    CSNT = ORx[20] = 1
- *    ACS = half cycle delay = ORx[21:22] = 11
- *    SCY = 6 = ORx[24:27] = 0110
- *    TRLX = use relaxed timing = ORx[29] = 1
- *    EAD = use external address latch delay = OR[31] = 1
- *
- * 0	4    8	  12   16   20	 24   28
- * 1111 1111 1000 0000 0110 1110 0110 0101 = ff806e65	 ORx
- */
-
-#define CFG_SYS_FLASH_BASE		0xff000000	/* start of FLASH 16M */
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_FLASH_BASE_PHYS	0xfff000000ull
-#else
-#define CFG_SYS_FLASH_BASE_PHYS	CFG_SYS_FLASH_BASE
-#endif
-
-#define CFG_SYS_FLASH_BANKS_LIST \
-	{CFG_SYS_FLASH_BASE_PHYS + 0x800000, CFG_SYS_FLASH_BASE_PHYS}
-
-/*
- * SDRAM on the Local Bus
- */
-#define CFG_SYS_LBC_SDRAM_BASE	0xf0000000	/* Localbus SDRAM */
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_LBC_SDRAM_BASE_PHYS	0xff0000000ull
-#else
-#define CFG_SYS_LBC_SDRAM_BASE_PHYS	CFG_SYS_LBC_SDRAM_BASE
-#endif
-#define CFG_SYS_LBC_SDRAM_SIZE	64		/* LBC SDRAM is 64MB */
-
-/*
- * Base Register 2 and Option Register 2 configure SDRAM.
- * The SDRAM base address, CFG_SYS_LBC_SDRAM_BASE, is 0xf0000000.
- *
- * For BR2, need:
- *    Base address of 0xf0000000 = BR[0:16] = 1111 0000 0000 0000 0
- *    port-size = 32-bits = BR2[19:20] = 11
- *    no parity checking = BR2[21:22] = 00
- *    SDRAM for MSEL = BR2[24:26] = 011
- *    Valid = BR[31] = 1
- *
- * 0	4    8	  12   16   20	 24   28
- * 1111 0000 0000 0000 0001 1000 0110 0001 = f0001861
- *
- * FIXME: CFG_SYS_LBC_SDRAM_BASE should be masked and OR'ed into
- * FIXME: the top 17 bits of BR2.
- */
-
-/*
- * The SDRAM size in MB, CFG_SYS_LBC_SDRAM_SIZE, is 64.
- *
- * For OR2, need:
- *    64MB mask for AM, OR2[0:7] = 1111 1100
- *		   XAM, OR2[17:18] = 11
- *    9 columns OR2[19-21] = 010
- *    13 rows	OR2[23-25] = 100
- *    EAD set for extra time OR[31] = 1
- *
- * 0	4    8	  12   16   20	 24   28
- * 1111 1100 0000 0000 0110 1001 0000 0001 = fc006901
- */
-
-#define CFG_SYS_LBC_LCRR		0x00030004	/* LB clock ratio reg */
-#define CFG_SYS_LBC_LBCR		0x00000000	/* LB config reg */
-#define CFG_SYS_LBC_LSRT		0x20000000	/* LB sdram refresh timer */
-#define CFG_SYS_LBC_MRTPR		0x00000000	/* LB refresh timer prescal*/
-
-/*
- * Common settings for all Local Bus SDRAM commands.
- * At run time, either BSMA1516 (for CPU 1.1)
- *		    or BSMA1617 (for CPU 1.0) (old)
- * is OR'ed in too.
- */
-#define CFG_SYS_LBC_LSDMR_COMMON	( LSDMR_RFCR16		\
-				| LSDMR_PRETOACT7	\
-				| LSDMR_ACTTORW7	\
-				| LSDMR_BL8		\
-				| LSDMR_WRC4		\
-				| LSDMR_CL3		\
-				| LSDMR_RFEN		\
-				)
-
-/*
- * The CADMUS registers are connected to CS3 on CDS.
- * The new memory map places CADMUS at 0xf8000000.
- *
- * For BR3, need:
- *    Base address of 0xf8000000 = BR[0:16] = 1111 1000 0000 0000 0
- *    port-size = 8-bits  = BR[19:20] = 01
- *    no parity checking  = BR[21:22] = 00
- *    GPMC for MSEL	  = BR[24:26] = 000
- *    Valid		  = BR[31]    = 1
- *
- * 0	4    8	  12   16   20	 24   28
- * 1111 1000 0000 0000 0000 1000 0000 0001 = f8000801
- *
- * For OR3, need:
- *    1 MB mask for AM,	  OR[0:16]  = 1111 1111 1111 0000 0
- *    disable buffer ctrl OR[19]    = 0
- *    CSNT		  OR[20]    = 1
- *    ACS		  OR[21:22] = 11
- *    XACS		  OR[23]    = 1
- *    SCY 15 wait states  OR[24:27] = 1111	max is suboptimal but safe
- *    SETA		  OR[28]    = 0
- *    TRLX		  OR[29]    = 1
- *    EHTR		  OR[30]    = 1
- *    EAD extra time	  OR[31]    = 1
- *
- * 0	4    8	  12   16   20	 24   28
- * 1111 1111 1111 0000 0000 1111 1111 0111 = fff00ff7
- */
-
-#define CADMUS_BASE_ADDR 0xf8000000
-#ifdef CONFIG_PHYS_64BIT
-#define CADMUS_BASE_ADDR_PHYS	0xff8000000ull
-#else
-#define CADMUS_BASE_ADDR_PHYS	CADMUS_BASE_ADDR
-#endif
-
-#define CFG_SYS_INIT_RAM_ADDR	0xe4010000	/* Initial RAM address */
-#define CFG_SYS_INIT_RAM_SIZE	0x4000		/* Size of used area in RAM */
-
-#define CFG_SYS_INIT_SP_OFFSET	(CFG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
-
-#define CFG_SYS_BAUDRATE_TABLE \
-	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400,115200}
-
-#define CFG_SYS_NS16550_COM1	(CFG_SYS_CCSRBAR+0x4500)
-#define CFG_SYS_NS16550_COM2	(CFG_SYS_CCSRBAR+0x4600)
-
-/*
- * I2C
- */
-#if !CONFIG_IS_ENABLED(DM_I2C)
-#define CFG_SYS_I2C_NOPROBES		{ {0, 0x69} }
-#endif
-
-/*
- * General PCI
- * Memory space is mapped 1-1, but I/O space must start from 0.
- */
-#define CFG_SYS_PCI1_MEM_VIRT	0x80000000
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_PCI1_MEM_PHYS	0xc00000000ull
-#else
-#define CFG_SYS_PCI1_MEM_PHYS	0x80000000
-#endif
-#define CFG_SYS_PCI1_IO_VIRT	0xe2000000
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_PCI1_IO_PHYS 0xfe2000000ull
-#else
-#define CFG_SYS_PCI1_IO_PHYS	0xe2000000
-#endif
-
-#ifdef CONFIG_PCIE1
-#define CFG_SYS_PCIE1_MEM_VIRT	0xa0000000
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_PCIE1_MEM_PHYS	0xc20000000ull
-#else
-#define CFG_SYS_PCIE1_MEM_PHYS	0xa0000000
-#endif
-#define CFG_SYS_PCIE1_IO_VIRT	0xe3000000
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_PCIE1_IO_PHYS        0xfe3000000ull
-#else
-#define CFG_SYS_PCIE1_IO_PHYS	0xe3000000
-#endif
-#endif
-
-/*
- * RapidIO MMU
- */
-#define CFG_SYS_SRIO1_MEM_VIRT	0xc0000000
-#ifdef CONFIG_PHYS_64BIT
-#define CFG_SYS_SRIO1_MEM_PHYS	0xc40000000ull
-#else
-#define CFG_SYS_SRIO1_MEM_PHYS	0xc0000000
-#endif
-#define CFG_SYS_SRIO1_MEM_SIZE	0x20000000	/* 512M */
-
-/*
- * Miscellaneous configurable options
- */
-
-/*
- * For booting Linux, the board info and command line data
- * have to be in the first 64 MB of memory, since this is
- * the maximum mapped by the Linux kernel during initialization.
- */
-#define CFG_SYS_BOOTMAPSZ	(64 << 20)	/* Initial Memory map for Linux*/
-
-/*
- * Environment Configuration
- */
-
-#define	CFG_EXTRA_ENV_SETTINGS		\
-	"hwconfig=fsl_ddr:ecc=off\0"		\
-	"netdev=eth0\0"				\
-	"uboot=" CONFIG_UBOOTPATH "\0"	\
-	"tftpflash=tftpboot $loadaddr $uboot; "	\
-		"protect off " __stringify(CONFIG_TEXT_BASE)	\
-			" +$filesize; "	\
-		"erase " __stringify(CONFIG_TEXT_BASE)		\
-			" +$filesize; "	\
-		"cp.b $loadaddr " __stringify(CONFIG_TEXT_BASE)	\
-			" $filesize; "	\
-		"protect on " __stringify(CONFIG_TEXT_BASE)		\
-			" +$filesize; "	\
-		"cmp.b $loadaddr " __stringify(CONFIG_TEXT_BASE)	\
-			" $filesize\0"	\
-	"consoledev=ttyS1\0"			\
-	"ramdiskaddr=2000000\0"			\
-	"ramdiskfile=ramdisk.uboot\0"		\
-	"fdtaddr=1e00000\0"			\
-	"fdtfile=mpc8548cds.dtb\0"
-
-#endif	/* __CONFIG_H */
-- 
2.47.3

