Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54817CA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F05318156E;
	Fri,  9 Oct 2026 22:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Z9tbcTr1H8w; Fri,  9 Oct 2026 22:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2EBA814C2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583957;
	b=WeEmc4kQAj8jJDj7f5DPL+7ZW5dI9DoqWxkfsKkmfaMbUSwuSq0Mzyv8BhiIQXUFcsOQ
	 Qg/afsYFaa9uHDKKXrdm2XnvJZMRWpY7NHaz3RuCder0V1fjKzJ4TFHV6lU5I7wovaKbo
	 PgqZ/uJMNQHNvznn9eocvKvnBnhIK5nT/OSv11NHlQpAFxxkss0fjK2/NP7HgfWOAOjG5
	 TMwVvhCBnoILE45GPwsyLPhqjOjCw7Dbq4zLHLkNv2HR9MTUymMt6esvvt0bQcU+Q4fRF
	 jTsJ+3EhlOqbygY2qbEuQQCLuie8a0lG/oqYirv3Gt9TvYuM8ASuMmxmpNmF9QGFxvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wGwlVgMpVjTAN9J1z48z0m8+uQRO2lYeWDRC9kf1Lu4=;
	b=UoB6CisvkYyZSlx94Eds7PQEDQpaaLiDfvxXS7FEWzWicfZ9fjr7nWzSRbe0/U/97CxF
	 PFCkfK3XMpIRjKtYuCk8RO/kKO14u3Mmw364H/2C5oDaC/9s5SeYZLBcvCe4wGgrxJ+nl
	 L+MbWShLI8DSTvknBbukjpVVt5Nvi9fnn/4MHZamS+bpzHfhJM4TnGnf84en5H/RUtGuN
	 7lj+W9ahS+/9aKBNPSByEDDPEKRGumZwJdRymyeBNjwzi3nDY+oXM2XyMpmr5ndL6XCWR
	 6HO3Ydyaj9s6IXo/9Rh6DOapWGCHlsgnacsDffZqVFUF2fBHHR3GbMWqB9tBmnNMjtQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583957;
	bh=wGwlVgMpVjTAN9J1z48z0m8+uQRO2lYeWDRC9kf1Lu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IHxsDchPqo8E4kQ3MQz/xntSM2R3gyWEgtZFWCc9ZXCTR5A/QkhD5ATqtAtoUw6kQ
	 EBG/FpVbDTBKYnDDh7SL9sbET1klWdLssWH8fOMhM75JJiVOFP5Zb3xudGeZJ8SyhP
	 hLMpeGvaJ2qEffJx5D4nQurl3G345QTttQm3Te/36qAlTw6g2b4kayNtVF8b29/ul8
	 GYYkIOVo+fDwkjUpqu1LSkQT4lIMJxTxj+i5F935T0cmISAr6tKiN89upuHC7aHNfP
	 j/xd8hPa14u514S+UUZh/qs/VhXaHRigUJ6PTLMZzmJ1x1UrxoCKaD1Q1DQu+7YtEg
	 gr6JXt+oOjZdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2EBA814C2;
	Fri,  9 Oct 2026 22:12:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id A615275
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 97D37408F9
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id DpbarBto4BBf for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63A92408F7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583833;
 b=BzwX5gTA3htw+r/rFPfOC2Po5hJjMYeAHwANt7seX4yGa9kX3hVjj0hy+dO1zzArmNPD
 A5M9JYXBBtZ4qsy4t1sLUQRNAhn6u/u/7prcTG+TTYmu47a0NgDbaGoz+SvqL45BodM/i
 moL+09hbdalD/6NVk2LQD5jOKdPuozEVqH2J2dTxQAmwfOYf9M99lw2dheH8tewJgfGLs
 9bfxpfHCBfZ2ecCw2h3hFAH5v0Jd9NTnQ9mgfP+w9NQAXfalUSuQT3gAsV4pJwe25T54G
 lmK8IU8MXXOiSwPEeFVhKZJDxDwSWnjwc7BmUN4PKOfogeALk4QkoZKh23ML3i4tOsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583833;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wGwlVgMpVjTAN9J1z48z0m8+uQRO2lYeWDRC9kf1Lu4=;
 b=CYMtis7eO9id27t7xyQkUL+MBET2eVjKZ0MvobIqMsapanBWEoEyA8wggbepBWhbe/jn
 4jCUdo5xii0vkkeITG0Qn+GqGk+h0kImNFlRsx+Tc2ZadZVo7J7ubgF3IC1e9UIWopj0Y
 oEyVt+LqJEAT2T3/gHK9+ScznBxuFNE/Q/SUB60UYQ2KcO3fi6lBcdtZ2umct8ZsjpIxn
 yKBCdg7qS1Xwti3BDYBZsxyF3g9JFTvuO2EiZU8H/u/+p7g1k4QTvVJoekDGOaXxbjNYO
 DaXB3z8vAqokXghCE0VkZCpjnRnpxbS9iZ3U9XExA6yyEc8Cz98wUiE73nttGO1d1UA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=AVJIiCxb; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qiUEQT3k; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=AVJIiCxb; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qiUEQT3k
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 63A92408F7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583827; bh=wGwlVgMpVjTAN9J1z48z0m8
 +uQRO2lYeWDRC9kf1Lu4=; b=AVJIiCxbpGLdXN2Zp638OANYqW6KDGNEBS/YAjtCtNHxwwt7qs
 nwO7uaAMZjBnAAE28mwabNfUoWIbMdECqRjDnGjPPzOv1yXwrnztb3IOnCc2HCQG6emFGkKWy4h
 dQ85fmq8/ka+pTTWkxudIlwosIFeoG+k4pN9mj8QkFDlkUCM0abhKghGPvXlsjiQlzWJuQrhq98
 S5MjSqowy6PgXWysKEKtF3RlfbXpAwruytCcY0C4sJu3Te49AMy1+Jxav0cz+wHeoh5KywdiGa6
 NlHUnvjxGivBWYzKjg+3QOlNp5uGbbmDbtXn8XObzWg2EQViU5b7nZB/njrzAJ7AmuQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583827; bh=wGwlVgMpVjTAN9J1z48z0m8
 +uQRO2lYeWDRC9kf1Lu4=; b=qiUEQT3kRSTgEsYAmDX2dtJCUyqsm/CHkGqYz2GTOxalMKS3+9
 iwYzDFdH9eSt276OOMXQFRboIZOqZYaWoZCg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 22/26] powerpc: mpc85xx: Remove P1024 support
Date: Fri,  9 Oct 2026 22:10:12 +0000
Message-ID: <20261009221017.20385-23-brads@mainlining.org>
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
index 046ab063700..3840cb42b76 100644
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

