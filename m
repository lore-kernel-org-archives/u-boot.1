Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08356606A552
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RocGEDiV;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=SsdG62oC;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=V9B56qTO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF74360B00;
	Wed, 21 Oct 2026 16:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoghDDAifpw5; Wed, 21 Oct 2026 16:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8246660A79
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599393;
	b=gytXmj0GMT8T8ur3Rtd+FERcDLBKuq0G7aYY8FFW0RlP2SJDGjaUhQOK8Ko/zhwuumc6
	 HpAyApQ9vu3Eobc91I6XGqCny7Avsq5Y7bij1OuD9ZxVao/e7OExRcCA4J8Nf3ff8NOIO
	 Y17eFicvqCLSVajbQnTWvojTibO7Jpe/mQBT18PXtjZPqjmFPrwTzBpaLQv72t8gs5Psn
	 mWhmYMKEideQeuEF0pbRoumuE63lEXymppNKH6vtMGFOHiPZ0DzRpdSPxr0BIubmvApHT
	 5TpeMMNg13+QwfQAWYmJLIPnbQF9M+awabdag2SNUtIsH6Old1cgizCRACyfmMAUfvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kvkpcqxZCIU/P/PF+VqYv+vp0Rk6/VpHDSIJC3YqI5M=;
	b=ULLs/gO5qmDEtpIxewuhldDhLhFAQMtPFa1rmKmG74uAwmBmWJANFfjFJVZ00wXELHTo
	 uSgtUC2Vzt+ctP5dBepCQqYc7A9MUXlFJIGqt0FQgfGRkxpZk4FffEf5AraoH3+4XAHRD
	 TVMThB1kcTWdqjksZ++SKUdu1k9omjq20/EVDjdxHAvBIODCIfMOrwn0i49G9IntfNBvl
	 eZCm2s+Lp56i/k5TMBAg3WgOISlEKmojyVCqtI9WPJlf9g3mKibEmV8CB3sCi+V39hL3i
	 Ft4rvG4lTs4ZAaRjKgCopq9veFqTp5Zw3TvejVZsZzi4E+nBerXpW55wSsowWmT7ENA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599393;
	bh=kvkpcqxZCIU/P/PF+VqYv+vp0Rk6/VpHDSIJC3YqI5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RocGEDiV+P6qnAMDz54o3SrXZUzrvb2gXVT2cAI7yYKwpTVchdjPDjcVI7/NVAz+D
	 DeV2pXOY3JXiTM9qOwvqffs997XuDJVSg70AzCCB6Qq5LGBi8+IiewoO6SqwOT9J/e
	 Eild+SykKH8e1JipXrK+2V0OWyrBi+wqyWL+CitHLDXjKK65p+vucAdRpivutOKqDw
	 4kcR27nSC8H+V8ipBe7PxKXRvaXQIkq5ItUlSOFZV79kpyKJwpyjMtVP65CJBL0mu5
	 IaZWAE4aZVWSyBIV2mirt+rIENTrL1egvuaQBCBVZ2n3qZ2CsV487TOVocgA/iz/ca
	 43DHX4vmuGURg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8246660A79;
	Wed, 21 Oct 2026 16:16:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id E8B151AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id CBADA4089D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id eaVbflf1n1sP for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD1424084B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598519;
 b=YWcaoLXrQR8s0gx5s/2obBVwktXYGvTJ+8lAYeiuzjbq2u+ZGHzIUB8rLfk00S+uzhw3
 zxu4Tfybq0N1xyD4+NqgVqU4O+dKRbX6k9LIlPZt7014LdTddNeXUZgZU7xXbemAhE4PH
 huxGh4PAVDBvyr67tCFyzuYPuLt1GlmEWMeZZxoErYPSBy53nf1/4vBKxl3ZdLKuvTwBC
 b0By6eA9l6/E2OiCN487RPo5v8odPJF9F6W0bCuEaJuv3s2tlBgecCvlRZLsUVaVLZbBr
 fyKCyEUR9pPQrYR4Cf/HpyfcbBeL3tnNrfY/g8220mwf08XU8d7FK9MVXcc1wkrCdzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598519;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=kvkpcqxZCIU/P/PF+VqYv+vp0Rk6/VpHDSIJC3YqI5M=;
 b=OSeUsgSkLh1+6nZuYyUGg6vh+ZQ39D7vQslKppTI7+VfSvD0ApjGrLXHyUTeeIM3iaRp
 PUX/w1h9BDboywvRTw8NZvhQ4K+CZI/Au8PCeh3dqQexX1Ui4/HVJhRPCSmRxWtfDJgHz
 9RaD1WqHbV9i+pN8qw2EKwCiui0OtBSi9lmNnwv/bsAbKOpsUYOaphsDHRx1B11VbSjYz
 zs/BPPi1WzoHw1yPw57E4ZegFIqTAsJ/4gQ74yYYa0ycD6AJxaOIy+4P3wnlIGBLAuO0U
 s/932uwYYPr1DjbW/78praPae0w2qpuL/SyAhbZvavCioQpX1hNUFkZM3GxQtOOjQeA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=SsdG62oC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=V9B56qTO; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=SsdG62oC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=V9B56qTO
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id CD1424084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598511; bh=kvkpcqxZCIU/P/PF+VqYv+v
 p0Rk6/VpHDSIJC3YqI5M=; b=SsdG62oClhyEFiGJHz7FglLnXYh5bH4uWyIPeQ/+nJG3KN+wQW
 zGjvcUCFAVPot43YXTxKM+Op9DVNOcYb1uHU54vUDLMdtlyjOW5H4nojUpLoSOa8L7YT3GBRFoU
 9pAG+8ve6MnH8UuAscj/MoOA4ry4bMWa+I3Wdz4RwB2FeqJWb/ZEgvW4Nvj1W3OlQ9LYS6nlmUp
 VLHxdMbarG1DsI86o7W4xOZNlJhNGk/sDSRiDb903r+kijhuWdd4FMT4+a8I8SJkecmgjb3xrHF
 lDAUfUHNNOKGWioDwaUymt83wLYfh7i06vjDvy4yu7SwL5XjlPsKUha3MAZAw37PFbg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598511; bh=kvkpcqxZCIU/P/PF+VqYv+v
 p0Rk6/VpHDSIJC3YqI5M=; b=V9B56qTOV4AWTuZg2++JYfcwDrrker9jSyntf5oZjZEIr0UVxO
 DY9L+1sOoZLRzEZ/SgmdO+yb79h9jI7KYaCw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 13/26] powerpc: mpc85xx: Remove P1011 support
Date: Wed, 21 Oct 2026 16:01:09 +0000
Message-ID: <20261021160145.10430-14-brads@mainlining.org>
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

No board in the tree selects ARCH_P1011, and the SoC lacks active
community maintenance. Remove the unused SoC configuration, CPU
identification, and stale boot documentation entry.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                         |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig     | 20 +-------------------
 arch/powerpc/cpu/mpc85xx/Makefile    |  1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c       |  1 -
 arch/powerpc/include/asm/processor.h |  1 -
 doc/README.mpc85xx-sd-spi-boot       |  1 -
 6 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d63afeb138..07214f2af7c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -470,7 +470,7 @@ config SYS_IMMR
 	default 0xF0000000 if ARCH_MPC8313
 	default 0xE0000000 if MPC83xx && !ARCH_MPC8313
 	default 0x01000000 if ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
-	default 0xFFE00000 if ARCH_P1010 || ARCH_P1011 || ARCH_P1020 || \
+	default 0xFFE00000 if ARCH_P1010 || ARCH_P1020 || \
 			      ARCH_P1021 || ARCH_P1024 || ARCH_P1025 || \
 			      ARCH_P2020
 	default SYS_CCSRBAR_DEFAULT
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index b1b134ca990..ab66ffadebd 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -399,21 +399,6 @@ config ARCH_P1010
 	imply FSL_SATA
 	imply TIMESTAMP
 
-config ARCH_P1011
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_ELBC_A001
-	select SYS_FSL_ERRATUM_ESDHC111
-	select FSL_PCIE_DISABLE_ASPM
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-
 config ARCH_P1020
 	bool
 	select BTB
@@ -831,7 +816,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_MPC8544	|| \
 				ARCH_MPC8560	|| \
 				ARCH_P1010	|| \
-				ARCH_P1011	|| \
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
 				ARCH_P1024	|| \
@@ -1041,7 +1025,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_BSC9132	|| \
 			ARCH_MPC8536	|| \
 			ARCH_P1010	|| \
-			ARCH_P1011	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1023	|| \
@@ -1156,8 +1139,7 @@ config SYS_PPC_E500_DEBUG_TLB
 	depends on SYS_PPC_E500_USE_DEBUG_TLB
 	default 0 if ARCH_MPC8544
 	default 1 if	ARCH_MPC8536
-	default 2 if	ARCH_P1011	|| \
-			ARCH_P1020	|| \
+	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
 			ARCH_P1025	|| \
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 93b0c28ca03..f78131dd61a 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS2) += fsl_corenet2_serdes.o
 obj-$(CONFIG_ARCH_MPC8536) += mpc8536_serdes.o
 obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
-obj-$(CONFIG_ARCH_P1011)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1023)	+= p1023_serdes.o
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 2ee7348391a..efbbbced132 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -41,7 +41,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(8569, 8569, 1),
 	CPU_TYPE_ENTRY(8572, 8572, 2),
 	CPU_TYPE_ENTRY(P1010, P1010, 1),
-	CPU_TYPE_ENTRY(P1011, P1011, 1),
 	CPU_TYPE_ENTRY(P1012, P1012, 1),
 	CPU_TYPE_ENTRY(P1013, P1013, 1),
 	CPU_TYPE_ENTRY(P1014, P1014, 1),
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1d6f960be94..36d8660cddc 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1033,7 +1033,6 @@
 #define SVR_8569	0x808000
 #define SVR_8572	0x80E000
 #define SVR_P1010	0x80F100
-#define SVR_P1011	0x80E500
 #define SVR_P1012	0x80E501
 #define SVR_P1013	0x80E700
 #define SVR_P1014	0x80F101
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 8e98fc9f659..086c8f9e49b 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -60,7 +60,6 @@ P2020DS		config_sram_p2020ds.dat
 P1020RDB	config_ddr2_1g_p1020rdb_533M.dat
 P1020RDB	config_ddr2_1g_p1020rdb_667M.dat
 P1020RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
-P1011RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1010RDB	config_ddr3_1gb_p1010rdb_800M.dat
 P1021RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1022DS		config_ddr3_2gb_p1022ds.dat
-- 
2.47.3

