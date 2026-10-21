Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24162606BF0C
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wf1cEbG4;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=iCESdJwC;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=muPD41Ux
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE30760A8B;
	Wed, 21 Oct 2026 16:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzttrvZ-KU4q; Wed, 21 Oct 2026 16:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4743260A5B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599386;
	b=kSYM1FOVD2pfV1iTh4HsqzidVsDqMzDTRZXtIVwAhcKmR2n05CVwds13hTthCziByAuL
	 +oTUd8A7vpIUjiu76uHohYmr67CgBACnwJuXolIm0juHJ0ovrpmErqKzZiTFQk3dIGOLj
	 5+jrCNgXm3ZTgBVGqSrfCzLPtYmH4Z6EfIH/9qVD/OUvJt85jIZplF4ejaJZ4KlzgX8BO
	 IcRlforV72sCMqhjNx2StHGTg0++oVF7Vl/ocbeeC7pvkCZSP9OReNkTEX2WPYCdI0x9U
	 GziLfWnJMikrjAcgJeUZ39KXjtF5Jb3yGz4NtWry8vR6FPSBGixVYlcBMTiEKq2JY2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iO7z6qqanCYqio7HMYymevxjpBfLUZoHafeTBWq5F3g=;
	b=qY2Q/ZW1M5i7AsV54D81dOH9k0FHkPBz3CmoSMwMTBLprAO6X8WnevWLeReEG7slLiq1
	 sCGKoJbzBeva2N4CTindixIE3hwVbpCpPAwcAVkIh3meOO44YOCuDVQITsLN9kSGs8Tar
	 YFQ112ybVk/4I6VybZzg7E8mbEHzQYX/IbjoMucGyKCMtSisT0wefd3ZNJLzotBtEvjXe
	 2z8oGe/FXwip70hSKW8MtMBqjYaae2C2OGiO9htOUj0jyCcKhBAfBj6mQ68fx9DPzTDeD
	 Pgi805M4+dzoxwiLjycXGGsgueqiv1//345unIxNW9g3gvVpbQBLBxmjN093k3gcRsQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=iCESdJwC;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=muPD41Ux;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599386;
	bh=iO7z6qqanCYqio7HMYymevxjpBfLUZoHafeTBWq5F3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wf1cEbG4+qMVtFHStuTgpQRZKNmW3KK1oPxijV98hnxYrmxuw6PVOVbfL1kRMPYt/
	 dh1ooXq8wRfdgAYHD9rNBHpFogFsbYpXPOQWKFIBfaeOtRzuOpwK+RSroH0I21yLVX
	 Bi3tKIM6BbaUmuvc7G84uXQHFtc19rUWIVfgd7/vJByPyOc+IOnjTlp+AR7wejstVO
	 x1lOy/uXBDpEcjIf2I6DdUAWSNCltPlJtD+kY4+DGxb6xQC3VuTpkw82dK6dTb9HGW
	 BiR/98Thk/3NYcwr9l8ndX5Vz6K8aJJB+h2Tq5oWNBjYM405K7x+1MCpl58jINYqk3
	 OMkJtRMgVjYZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4743260A5B;
	Wed, 21 Oct 2026 16:16:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id E3B761AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id D583C60877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id A23GQ5yl2_mz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B287D60844
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598518;
 b=AFSXm7hfUG9cGinroR7LOHg05gTqiBe0YsN+BOkuQcKpvkcNhaKipUVIMAytKuZrbtxU
 VZ/99JsoZTVS7ZJUniU1OQCDxFkNoapJcMc2yHD6EwCtujde+2tO2aMfZRdGfCQ1LGV+z
 ZTrfG5BhUiV7mQ3dhs9YmR8buXBvxTFx/PEmpydqMjVBs9I5y2T5Rd9ZPQUEXMXFHZhy2
 t25ZKfpap+4d4WRxgOpNJux5OWJBe9fM4P1Zwjn8PejlM8VTF2kmtmrepShOL2VHMiyLE
 XarLHaaeGxsGtf07UCtNL85Rj7v6PQItQfymBqn6dIJWTlbXexPqLi0kE5Hgood6JGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598518;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iO7z6qqanCYqio7HMYymevxjpBfLUZoHafeTBWq5F3g=;
 b=Rf2cEy2O7THiDup8w3hODjmcxmo29SVwOXBoLLCAb1oYtHxK8/nGSFmDT5/ejWQ4kjeE
 z1c/prS4FJdNldgvkY6G5fNNbggOXTKtvHxNUxzMkP/PYHuMSkDiRnOJg/kTuvieZGL1j
 ahMhO3M3fcrpnYuUD1wChk92pmomK8hM0HNeN3avvB7rtDJodhZDdy0YWgT3Szv2QnWqa
 e+TgwgSTcSqG4wPrJjYE0nCFjFaci/4voG2Z+H6HMKhN6fEVjvK8krdOorq6xpR0lKlcL
 YZW9fOl2cnXeI53LYcu4GVGk6hZp7uqyXq0rI+1lY1F0xpt2utzt9dALtWPcT47JXig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=iCESdJwC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=muPD41Ux; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=iCESdJwC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=muPD41Ux
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id B287D60844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598515; bh=iO7z6qqanCYqio7HMYymevx
 jpBfLUZoHafeTBWq5F3g=; b=iCESdJwC7jUNsDeoLNJcHYtFQwF77yepJyHzirxXtTvBWytXHY
 V03s9W+EJZQehtxJKpyADQKvmEOtwySuRYOL9ex3bA6j0ReLjsuQk49YUbhovfrphTLWciP40Mk
 z6RTWqbjfEi7EzOHospdnQqjD2cMhE+SeTkPsSG8KSkvcxA0P2WprIDLyfRtsbdbQvsaluPMR8N
 qEuT4YaGHMa/+S7JcLluXTmcLRklSZGCutQeCOan8dlHqVtwVpG5Z78JiCXDewzssNb9GxnxXbR
 eVETL4lDdnR/ZLdhkVweWp1FgG/pIY82DtAMaz8dZAD6U1HNGBqVcxVphW9iVROXy3A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598515; bh=iO7z6qqanCYqio7HMYymevx
 jpBfLUZoHafeTBWq5F3g=; b=muPD41UxfiTzTS2M76oS7Q94Nusu+WyF09KA8TjY8VgqCuFxVL
 y0I2z6rzdyJHy3/CDWliMtuX4EP4S0bwrOBQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 22/26] powerpc: mpc85xx: Remove P1024 support
Date: Wed, 21 Oct 2026 16:01:18 +0000
Message-ID: <20261021160145.10430-23-brads@mainlining.org>
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

No target in the tree selects ARCH_P1024, and the variant is
unmaintained. Its timing branch and SoC defaults still hang around in
the shared P1020 code.

Drop those paths.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                         |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig     | 27 --------------------
 arch/powerpc/cpu/mpc85xx/Makefile    |  1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c       |  1 -
 arch/powerpc/include/asm/processor.h |  1 -
 board/nxp/p1_p2_rdb_pc/README        |  1 -
 board/nxp/p1_p2_rdb_pc/ddr.c         | 37 ----------------------------
 doc/README.mpc85xx-sd-spi-boot       |  1 -
 8 files changed, 1 insertion(+), 70 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8ea591cba4f..cb808df07f4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -470,7 +470,7 @@ config SYS_IMMR
 	default 0xE0000000 if MPC83xx
 	default 0x01000000 if ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
 	default 0xFFE00000 if ARCH_P1010 || ARCH_P1020 || \
-			      ARCH_P1021 || ARCH_P1024 || \
+			      ARCH_P1021 || \
 			      ARCH_P2020
 	default SYS_CCSRBAR_DEFAULT
 	help
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index fe1592d75aa..6cb37b8a378 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -392,29 +392,6 @@ config ARCH_P1021
 	imply CMD_REGINFO
 	imply SATA_SIL
 
-config ARCH_P1024
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_ELBC_A001
-	select SYS_FSL_ERRATUM_ESDHC111
-	select FSL_PCIE_DISABLE_ASPM
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_RMU
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-	imply CMD_EEPROM
-	imply CMD_NAND
-	imply SATA
-	imply CMD_PCI
-	imply CMD_REGINFO
-	imply SATA_SIL
-
 config ARCH_P2020
 	bool
 	select BTB
@@ -710,7 +687,6 @@ config MAX_CPUS
 	default 2 if ARCH_B4420 || \
 		     ARCH_P1020 || \
 		     ARCH_P1021 || \
-		     ARCH_P1024 || \
 		     ARCH_P2020 || \
 		     ARCH_T1024
 	default 1
@@ -728,7 +704,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_P1010	|| \
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
-				ARCH_P1024	|| \
 				ARCH_P2020
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
@@ -933,7 +908,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
-			ARCH_P1024	|| \
 			ARCH_P2020
 	default 10 if ARCH_MPC8544
 	help
@@ -1042,7 +1016,6 @@ config SYS_PPC_E500_DEBUG_TLB
 	default 0 if ARCH_MPC8544
 	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
-			ARCH_P1024	|| \
 			ARCH_P2020
 	default 3 if	ARCH_P1010
 	help
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 9b7c02eae5f..5861f4bbe63 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -55,7 +55,6 @@ obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
-obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
 obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index c382fdc1d1c..e2ed910cb0d 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -45,7 +45,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P1020, P1020, 2),
 	CPU_TYPE_ENTRY(P1021, P1021, 2),
 	CPU_TYPE_ENTRY(P1022, P1022, 2),
-	CPU_TYPE_ENTRY(P1024, P1024, 2),
 	CPU_TYPE_ENTRY(P2010, P2010, 1),
 	CPU_TYPE_ENTRY(P2020, P2020, 2),
 	CPU_TYPE_ENTRY(P2040, P2040, 4),
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 01228bee20f..6c274c9ceef 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1033,7 +1033,6 @@
 #define SVR_P1020	0x80E400
 #define SVR_P1021	0x80E401
 #define SVR_P1022	0x80E600
-#define SVR_P1024	0x80E402
 #define SVR_P2010	0x80E300
 #define SVR_P2020	0x80E200
 #define SVR_P2040	0x821000
diff --git a/board/nxp/p1_p2_rdb_pc/README b/board/nxp/p1_p2_rdb_pc/README
index 5bf27816ab2..73226bd1a53 100644
--- a/board/nxp/p1_p2_rdb_pc/README
+++ b/board/nxp/p1_p2_rdb_pc/README
@@ -5,7 +5,6 @@ P1_P2_RDB_PC represents a set of boards including
     P1020RDB-PC
     P1020RDB-PD
     P1021RDB-PC
-    P1024RDB
 
 They have similar design of P1020RDB but have DDR3 instead of DDR2.
 
diff --git a/board/nxp/p1_p2_rdb_pc/ddr.c b/board/nxp/p1_p2_rdb_pc/ddr.c
index 74c9c78c4e1..17138d92b0b 100644
--- a/board/nxp/p1_p2_rdb_pc/ddr.c
+++ b/board/nxp/p1_p2_rdb_pc/ddr.c
@@ -114,43 +114,6 @@ dimm_params_t ddr_raw_timing = {
 	.refresh_rate_ps = 7800000,
 	.tfaw_ps = 37500,
 };
-#elif	defined(CONFIG_TARGET_P1024RDB)
-/*
- * Samsung K4B2G0846C-HCH9
- * The following timing are for "downshift"
- * i.e. to use CL9 part as CL7
- * otherwise, tAA, tRCD, tRP will be 13500ps
- * and tRC will be 49500ps
- */
-dimm_params_t ddr_raw_timing = {
-	.n_ranks = 1,
-	.rank_density = 1073741824u,
-	.capacity = 1073741824u,
-	.primary_sdram_width = 32,
-	.ec_sdram_width = 0,
-	.registered_dimm = 0,
-	.mirrored_dimm = 0,
-	.n_row_addr = 15,
-	.n_col_addr = 10,
-	.n_banks_per_sdram_device = 8,
-	.edc_config = 0,
-	.burst_lengths_bitmask = 0x0c,
-
-	.tckmin_x_ps = 1500,
-	.caslat_x = 0x3e << 4,	/* 5,6,7,8,9 */
-	.taa_ps = 13125,
-	.twr_ps = 15000,
-	.trcd_ps = 13125,
-	.trrd_ps = 6000,
-	.trp_ps = 13125,
-	.tras_ps = 36000,
-	.trc_ps = 49125,
-	.trfc_ps = 160000,
-	.twtr_ps = 7500,
-	.trtp_ps = 7500,
-	.refresh_rate_ps = 7800000,
-	.tfaw_ps = 30000,
-};
 #else
 #error Missing raw timing data for this board
 #endif
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index c382e9bf7aa..ace40b2c7cf 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -63,6 +63,5 @@ P1020RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1010RDB	config_ddr3_1gb_p1010rdb_800M.dat
 P1021RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1022DS		config_ddr3_2gb_p1022ds.dat
-P1024RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
 P1020UTM	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1020MBG	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
-- 
2.47.3

