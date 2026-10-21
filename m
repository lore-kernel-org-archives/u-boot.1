Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED41606BF18
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1OK8NpEE;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=lqDjVHWL;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YZHsiSee
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B053812F6;
	Wed, 21 Oct 2026 16:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dk7_Pty7rXQs; Wed, 21 Oct 2026 16:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92521812FE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599418;
	b=sHHIpkvnwrFfDKYODo4glV/cXXdtWYaCpcOyWrbeDuEtngAbUwHO6Iom7EW/4++oKqVE
	 Avm6bMau4G2iwtr8qx9h7FcgFj6DxDttqU8vzyO0sfsthj3A9xPgp5di/4oYHFhB4jn8t
	 hRWfx/Ni6mfbqFtWTb3dyEuMDOuRA+3Mlg7FTjI5MIZdOt+cta6YmssfgJ+kka1hxonZ4
	 c85gPelnE1oxBhX/NgYdrxi/xn9+QtKScMlK2ZQ6fh/Ea9SPfnMZ99wV3qFpQWunt87B/
	 tdJENDRqqtV00ufolM6OUhOlNE4kkT31AQhmQfW6RuhbLDe7rCVu0gW4G7mQcLpZNQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JP+2k68Bc0hxuLcxVI+fqHv8Hwq82/aO9oJyEMVKm5s=;
	b=kdxqVDlZnAi/HqXHWFPSnQ8B0sVG20l4/kqFdZdEhFMmPG27LonLH1P8DqAbJWPILXfK
	 GlOINa7y0u6ggvXiayzG1DtfDT8ugcqJM0+2u0aRA5wkswC814sJB+aajYwbHZXAEZK0w
	 23ihcj/+BqaJ4bhK4JQMkqblPjQFvLHwuPx0KIbZOxToAAqGOIpoCxF5EbYv+BZEKy8Gb
	 27Rf8/cd8o3Q6es/QAibeV23rvHr/6tgh9HeXK8NIBGLzkQXiNZFN7dlMuoLVLfj1StRW
	 VFz5HKKm5BRCIn/B8fXSlEyPS20PY3HkyfiZMtSK/HycSplCt4awGd5LaKTqu2j6cvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=lqDjVHWL;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YZHsiSee;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599418;
	bh=JP+2k68Bc0hxuLcxVI+fqHv8Hwq82/aO9oJyEMVKm5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1OK8NpEEAbM0wHkvcwhMQLAVV1n6bbIntpWSEwI4L0EysxhyuILlqBE2mDQoK1q92
	 zgD+2IWfTX+YwZuXTjMopBk0mvSYsdIGnQJ3Dofo8gtWVXtSr6EsTkSEEPg9npn3id
	 TboWnUSNnFRSnApINV5qkW/0ISazINSp0cf1/kK+bbwmLiq6B/oqEgDkkAS/QQtGSW
	 1Sj9s8c8DNKtOwq1PByfF2/nC1FiQBvsXh7/BFNK0am3MPfIYz/0BX9z0huIoeyCn3
	 PiSTZR+A4k4sWvkUy+7FlQhI6JDbWnyzeF1euc/ilJMvITOQZOSmCqcOpS80CliHDT
	 ijXnfcEIFUFew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92521812FE;
	Wed, 21 Oct 2026 16:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 0BCD01184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id E6A00811A2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id wf7V2k5GVdbn for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAA928117B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598527;
 b=T+cfb6EGMKU2a1pOA3Jr2gI+4JI09y53p4WzSebTBT9A54mNlInlOpS/37z78QpnQHxn
 5utYMZpnsVUCaiu3lxseMMFXFULWExwAW0E4XAdxlGIuhIzbxau+QdxP812K4DIZgi1xu
 8zu+pCIjvIJJlAoAo57P1Uhi7XhcJzlEHl32pgmKEM8Fh1XChovYCBLP+gvs1P9LMhk1t
 ScmNy7TVUinmooEXqMhHBPCWDKdyLEU5wCFdym4aZwbo8iGMDNnfSkl/2zXRLGMY9scIe
 GjVEFVB60y3dS6r15fGxTH8y+LBId7KkfgXqT7VJ3lxvV4cloNEQ1uhZXGLPBSlOJ2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598527;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JP+2k68Bc0hxuLcxVI+fqHv8Hwq82/aO9oJyEMVKm5s=;
 b=Rm/omnRLjC7nO4DodXtwI+R0OSJjA6n4d4dC7gZZLdt1XUp0Xu6gsQaLuq89fu4b+WTN
 kyyz9B9WQ3QrdknuKo0WQJylyowkV7YpFKm6dGp+4plPegFkZyShIafKbL/1GlMNPZ+VW
 sxPe3r25vOxtanKq8tKZFqQZyF8jDXEpm0elYsooN9uK62351zvWOf9DSiQsOimSd3EPG
 mesqqAKoFEtQ7ALxZqYRzafyeHHYXtPG5tacDtkwIKHmhTP/6t1gC+dT4uN07KYR5njAA
 YJWEwGREYsuGCIP/fHGeOYly9e2BB1myLX/DiQAuzKb4iVNLTMq/SHeH9Nt8xXfUNWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=lqDjVHWL; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=YZHsiSee; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=lqDjVHWL; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=YZHsiSee
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id AAA928117B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598516; bh=JP+2k68Bc0hxuLcxVI+fqHv
 8Hwq82/aO9oJyEMVKm5s=; b=lqDjVHWL9xJo8JLAUidx03WSfWctweF+XUspXhiFIfGLDkD1y3
 e/jxX8ZghoNJGNwhncUv5tGJLMIgnKWel0vABTcgrY+Lj2CXEZy9bFm/3iGNh4Eq4K5S+VMtJ9d
 ZnV+naYt58oIk2e9VQUlna+8vhqKVrf2C5Egm5MoGel3jCByYeDeMRk9M1fEzfW85r+aYCU0n0K
 m1AFL7C9jl9CQ/rFsOD5KwPYBDHGNRzrF7uUyVU4Et1Xk+j8iysC5OapHucN7L6rXr3AszbFWh3
 oSYhFC9U36fWLPVoeBlD80/ttBE8R/7/HEsOsQqQMELeX0X1/iKS3p6Gu4+C+rbe62g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598516; bh=JP+2k68Bc0hxuLcxVI+fqHv
 8Hwq82/aO9oJyEMVKm5s=; b=YZHsiSeeRgNQ+hFBDbwZfukzZwtJi00Ln3SA8hcMLBwvwN3rsi
 YMXZ4kOVJNzKx0WtYFCisVksJq3euezHPcAw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 23/26] powerpc: mpc85xx: Remove BSC9131 support
Date: Wed, 21 Oct 2026 16:01:19 +0000
Message-ID: <20261021160145.10430-24-brads@mainlining.org>
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

No target selects ARCH_BSC9131, and the platform lacks active
community maintenance. Its mux, LAW and reset register paths have no
users.

Remove that family support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                      |   3 +-
 arch/powerpc/cpu/mpc85xx/Kconfig      |  22 +----
 arch/powerpc/cpu/mpc8xxx/cpu.c        |   1 -
 arch/powerpc/include/asm/fsl_law.h    |   4 -
 arch/powerpc/include/asm/immap_85xx.h | 116 --------------------------
 board/nxp/common/sdhc_boot.c          |   2 +-
 boot/Kconfig                          |   2 +-
 drivers/mmc/Kconfig                   |   2 +-
 8 files changed, 6 insertions(+), 146 deletions(-)

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 15e56ffb35a..e52ed3ddb21 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -286,8 +286,7 @@ config SYS_FSL_IFC_BANK_COUNT
 	depends on ARCH_LS1043A || ARCH_LS1046A || ARCH_LS2080A || \
 		ARCH_LS1088A || ARCH_LS1021A || ARCH_B4860 || ARCH_B4420 || \
 		ARCH_T4240 || ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || \
-		ARCH_T2080 || ARCH_P1010 || ARCH_BSC9131
-	default 3 if ARCH_BSC9131
+		ARCH_T2080 || ARCH_P1010
 	default 4 if ARCH_LS1043A || ARCH_LS1046A || ARCH_B4860 || \
 			ARCH_B4420 || ARCH_P1010
 	default 8 if ARCH_LS2080A || ARCH_LS1088A || ARCH_LS1021A || \
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 6cb37b8a378..6d5e81f47ac 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -281,22 +281,6 @@ config ARCH_B4860
 	imply CMD_NAND
 	imply CMD_REGINFO
 
-config ARCH_BSC9131
-	bool
-	select FSL_LAW
-	select SYS_FSL_DDR_VER_44
-	select SYS_FSL_ERRATUM_A004477
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_ESDHC111
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select FSL_IFC
-	imply CMD_EEPROM
-	imply CMD_NAND
-	imply CMD_REGINFO
-
 config ARCH_MPC8544
 	bool
 	select BTB
@@ -699,8 +683,7 @@ config MAX_CPUS
 
 config SYS_CCSRBAR_DEFAULT
 	hex "Default CCSRBAR address"
-	default	0xff700000 if	ARCH_BSC9131	|| \
-				ARCH_MPC8544	|| \
+	default	0xff700000 if	ARCH_MPC8544	|| \
 				ARCH_P1010	|| \
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
@@ -904,8 +887,7 @@ config SYS_FSL_NUM_LAWS
 	default 16 if	ARCH_T1024	|| \
 			ARCH_T1040	|| \
 			ARCH_T1042
-	default 12 if	ARCH_BSC9131	|| \
-			ARCH_P1010	|| \
+	default 12 if	ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P2020
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index e2ed910cb0d..42fbe445935 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -77,7 +77,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(T2080, T2080, 0),
 	CPU_TYPE_ENTRY(T2081, T2081, 0),
 	CPU_TYPE_ENTRY(BSC9130, 9130, 1),
-	CPU_TYPE_ENTRY(BSC9131, 9131, 1),
 	CPU_TYPE_ENTRY(BSC9232, 9232, 2),
 #elif defined(CONFIG_MPC86xx)
 	CPU_TYPE_ENTRY(8610, 8610, 1),
diff --git a/arch/powerpc/include/asm/fsl_law.h b/arch/powerpc/include/asm/fsl_law.h
index bdef61bc80f..ce40fe31742 100644
--- a/arch/powerpc/include/asm/fsl_law.h
+++ b/arch/powerpc/include/asm/fsl_law.h
@@ -79,12 +79,8 @@ enum law_trgt_if {
 	LAW_TRGT_IF_PCI = 0x00,
 	LAW_TRGT_IF_PCI_2 = 0x01,
 	LAW_TRGT_IF_PCIE_1 = 0x02,
-#if defined(CONFIG_ARCH_BSC9131)
-	LAW_TRGT_IF_OCN_DSP = 0x03,
-#else
 #if !defined(CONFIG_ARCH_P2020)
 	LAW_TRGT_IF_PCIE_3 = 0x03,
-#endif
 #endif
 	LAW_TRGT_IF_LBC = 0x04,
 	LAW_TRGT_IF_CCSR = 0x08,
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index e1167dbb3d7..45f96fefc62 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1726,11 +1726,7 @@ typedef struct ccsr_rcpm {
 #else
 typedef struct ccsr_gur {
 	u32	porpllsr;	/* POR PLL ratio status */
-#if defined(CONFIG_ARCH_BSC9131)
-#define MPC85xx_PORPLLSR_DDR_RATIO	0x00003f00
-#else
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003e00
-#endif
 #define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	9
 #define MPC85xx_PORPLLSR_QE_RATIO	0x3e000000
 #define MPC85xx_PORPLLSR_QE_RATIO_SHIFT		25
@@ -1846,50 +1842,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR_QE10		0x00000020
 #define MPC85xx_PMUXCR_QE11		0x00000010
 #define MPC85xx_PMUXCR_QE12		0x00000008
-#if defined(CONFIG_ARCH_BSC9131)
-#define MPC85xx_PMUXCR_TSEC2_DMA_GPIO_IRQ	0x40000000
-#define MPC85xx_PMUXCR_TSEC2_USB		0xC0000000
-#define MPC85xx_PMUXCR_TSEC2_1588_PPS		0x10000000
-#define MPC85xx_PMUXCR_TSEC2_1588_RSVD		0x30000000
-#define MPC85xx_PMUXCR_IFC_AD_GPIO		0x04000000
-#define MPC85xx_PMUXCR_IFC_AD_GPIO_MASK		0x0C000000
-#define MPC85xx_PMUXCR_IFC_AD15_GPIO		0x01000000
-#define MPC85xx_PMUXCR_IFC_AD15_TIMER2		0x02000000
-#define MPC85xx_PMUXCR_IFC_AD16_GPO8		0x00400000
-#define MPC85xx_PMUXCR_IFC_AD16_MSRCID0		0x00800000
-#define MPC85xx_PMUXCR_IFC_AD17_GPO		0x00100000
-#define MPC85xx_PMUXCR_IFC_AD17_GPO_MASK	0x00300000
-#define MPC85xx_PMUXCR_IFC_AD17_MSRCID_DSP	0x00200000
-#define MPC85xx_PMUXCR_IFC_CS2_GPO65		0x00040000
-#define MPC85xx_PMUXCR_IFC_CS2_DSP_TDI		0x00080000
-#define MPC85xx_PMUXCR_SDHC_USIM		0x00010000
-#define MPC85xx_PMUXCR_SDHC_TDM_RFS_RCK		0x00020000
-#define MPC85xx_PMUXCR_SDHC_GPIO77		0x00030000
-#define MPC85xx_PMUXCR_SDHC_RESV		0x00004000
-#define MPC85xx_PMUXCR_SDHC_TDM_TXD_RXD		0x00008000
-#define MPC85xx_PMUXCR_SDHC_GPIO_TIMER4		0x0000C000
-#define MPC85xx_PMUXCR_USB_CLK_UART_SIN		0x00001000
-#define MPC85xx_PMUXCR_USB_CLK_GPIO69		0x00002000
-#define MPC85xx_PMUXCR_USB_CLK_TIMER3		0x00003000
-#define MPC85xx_PMUXCR_USB_UART_GPIO0		0x00000400
-#define MPC85xx_PMUXCR_USB_RSVD			0x00000C00
-#define MPC85xx_PMUXCR_USB_GPIO62_TRIG_IN	0x00000800
-#define MPC85xx_PMUXCR_USB_D1_2_IIC2_SDA_SCL	0x00000100
-#define MPC85xx_PMUXCR_USB_D1_2_GPIO71_72	0x00000200
-#define MPC85xx_PMUXCR_USB_D1_2_RSVD		0x00000300
-#define MPC85xx_PMUXCR_USB_DIR_GPIO2		0x00000040
-#define MPC85xx_PMUXCR_USB_DIR_TIMER1		0x00000080
-#define MPC85xx_PMUXCR_USB_DIR_MCP_B		0x000000C0
-#define MPC85xx_PMUXCR_SPI1_UART3		0x00000010
-#define MPC85xx_PMUXCR_SPI1_SIM			0x00000020
-#define MPC85xx_PMUXCR_SPI1_CKSTP_IN_GPO74	0x00000030
-#define MPC85xx_PMUXCR_SPI1_CS2_CKSTP_OUT_B	0x00000004
-#define MPC85xx_PMUXCR_SPI1_CS2_dbg_adi1_rxen	0x00000008
-#define MPC85xx_PMUXCR_SPI1_CS2_GPO75		0x0000000C
-#define MPC85xx_PMUXCR_SPI1_CS3_ANT_TCXO_PWM	0x00000001
-#define MPC85xx_PMUXCR_SPI1_CS3_dbg_adi2_rxen	0x00000002
-#define MPC85xx_PMUXCR_SPI1_CS3_GPO76		0x00000003
-#endif
 	u32	pmuxcr2;	/* Alt. function signal multiplex control 2 */
 #if defined(CONFIG_ARCH_P1010)
 #define MPC85xx_PMUXCR2_UART_GPIO		0x40000000
@@ -1916,68 +1868,7 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR2_DEBUG_MUX_SEL_USBPHY	0x00002000
 #define MPC85xx_PMUXCR2_PLL_LKDT_EXPOSE		0x00001000
 #endif
-#if defined(CONFIG_ARCH_BSC9131)
-#define MPC85xx_PMUXCR2_UART_CTS_B0_SIM_PD		0x40000000
-#define MPC85xx_PMUXCR2_UART_CTS_B0_DSP_TMS		0x80000000
-#define MPC85xx_PMUXCR2_UART_CTS_B0_GPIO42		0xC0000000
-#define MPC85xx_PMUXCR2_UART_RTS_B0_PWM2		0x10000000
-#define MPC85xx_PMUXCR2_UART_RTS_B0_DSP_TCK		0x20000000
-#define MPC85xx_PMUXCR2_UART_RTS_B0_GPIO43		0x30000000
-#define MPC85xx_PMUXCR2_UART_CTS_B1_SIM_PD		0x04000000
-#define MPC85xx_PMUXCR2_UART_CTS_B1_SRESET_B		0x08000000
-#define MPC85xx_PMUXCR2_UART_CTS_B1_GPIO44		0x0C000000
-#define MPC85xx_PMUXCR2_UART_RTS_B1_PPS_LED		0x01000000
-#define MPC85xx_PMUXCR2_UART_RTS_B1_RSVD		0x02000000
-#define MPC85xx_PMUXCR2_UART_RTS_B1_GPIO45		0x03000000
-#define MPC85xx_PMUXCR2_TRIG_OUT_ASLEEP			0x00400000
-#define MPC85xx_PMUXCR2_TRIG_OUT_DSP_TRST_B		0x00800000
-#define MPC85xx_PMUXCR2_ANT1_TIMER5			0x00100000
-#define MPC85xx_PMUXCR2_ANT1_TSEC_1588			0x00200000
-#define MPC85xx_PMUXCR2_ANT1_GPIO95_19			0x00300000
-#define MPC85xx_PMUXCR2_ANT1_TX_RX_FRAME_MAX3_LOCK	0x00040000
-#define MPC85xx_PMUXCR2_ANT1_TX_RX_FRAME_RSVD		0x00080000
-#define MPC85xx_PMUXCR2_ANT1_TX_RX_FRAME_GPIO80_20	0x000C0000
-#define MPC85xx_PMUXCR2_ANT1_DIO0_3_SPI3_CS0		0x00010000
-#define MPC85xx_PMUXCR2_ANT1_DIO0_3_ANT2_DO_3		0x00020000
-#define MPC85xx_PMUXCR2_ANT1_DIO0_3_GPIO81_84		0x00030000
-#define MPC85xx_PMUXCR2_ANT1_DIO4_7_SPI4		0x00004000
-#define MPC85xx_PMUXCR2_ANT1_DIO4_7_ANT2_DO4_7		0x00008000
-#define MPC85xx_PMUXCR2_ANT1_DIO4_7_GPIO85_88		0x0000C000
-#define MPC85xx_PMUXCR2_ANT1_DIO8_9_MAX2_1_LOCK		0x00001000
-#define MPC85xx_PMUXCR2_ANT1_DIO8_9_ANT2_DO8_9		0x00002000
-#define MPC85xx_PMUXCR2_ANT1_DIO8_9_GPIO21_22		0x00003000
-#define MPC85xx_PMUXCR2_ANT1_DIO10_11_TIMER6_7		0x00000400
-#define MPC85xx_PMUXCR2_ANT1_DIO10_11_ANT2_DO10_11	0x00000800
-#define MPC85xx_PMUXCR2_ANT1_DIO10_11_GPIO23_24		0x00000C00
-#define MPC85xx_PMUXCR2_ANT2_RSVD			0x00000100
-#define MPC85xx_PMUXCR2_ANT2_GPO90_91_DMA		0x00000300
-#define MPC85xx_PMUXCR2_ANT2_ENABLE_DIO0_10_USB		0x00000040
-#define MPC85xx_PMUXCR2_ANT2_ENABLE_DIO0_10_GPIO	0x000000C0
-#define MPC85xx_PMUXCR2_ANT2_DIO11_RSVD			0x00000010
-#define MPC85xx_PMUXCR2_ANT2_DIO11_TIMER8		0x00000020
-#define MPC85xx_PMUXCR2_ANT2_DIO11_GPIO61		0x00000030
-#define MPC85xx_PMUXCR2_ANT3_AGC_GPO53			0x00000004
-#define MPC85xx_PMUXCR2_ANT3_DO_TDM			0x00000001
-#define MPC85xx_PMUXCR2_ANT3_DO_GPIO46_49		0x00000002
-	u32	pmuxcr3;
-#define MPC85xx_PMUXCR3_ANT3_DO4_5_TDM			0x40000000
-#define MPC85xx_PMUXCR3_ANT3_DO4_5_GPIO_50_51		0x80000000
-#define MPC85xx_PMUXCR3_ANT3_DO6_7_TRIG_IN_SRESET_B	0x10000000
-#define MPC85xx_PMUXCR3_ANT3_DO6_7_GPIO_52_53		0x20000000
-#define MPC85xx_PMUXCR3_ANT3_DO8_MCP_B			0x04000000
-#define MPC85xx_PMUXCR3_ANT3_DO8_GPIO54			0x08000000
-#define MPC85xx_PMUXCR3_ANT3_DO9_10_CKSTP_IN_OUT	0x01000000
-#define MPC85xx_PMUXCR3_ANT3_DO9_10_GPIO55_56		0x02000000
-#define MPC85xx_PMUXCR3_ANT3_DO11_IRQ_OUT		0x00400000
-#define MPC85xx_PMUXCR3_ANT3_DO11_GPIO57		0x00800000
-#define MPC85xx_PMUXCR3_SPI2_CS2_GPO93			0x00100000
-#define MPC85xx_PMUXCR3_SPI2_CS3_GPO94			0x00040000
-#define MPC85xx_PMUXCR3_ANT2_AGC_RSVD			0x00010000
-#define MPC85xx_PMUXCR3_ANT2_GPO89			0x00030000
-	u32 pmuxcr4;
-#else
 	u8	res6[8];
-#endif
 	u32	devdisr;	/* Device disable control */
 #define MPC85xx_DEVDISR_PCI1		0x80000000
 #define MPC85xx_DEVDISR_PCI2		0x40000000
@@ -2027,14 +1918,7 @@ typedef struct ccsr_gur {
 	u32	ddrdllcr;	/* DDR DLL control */
 	u8	res14[12];
 	u32	lbcdllcr;	/* LBC DLL control */
-#if defined(CONFIG_ARCH_BSC9131)
-	u8	res15[12];
-	u32	halt_req_mask;
-#define HALTED_TO_HALT_REQ_MASK_0	0x80000000
-	u8	res18[232];
-#else
 	u8	res15[248];
-#endif
 	u32	lbiuiplldcr0;	/* LBIU PLL Debug Reg 0 */
 	u32	lbiuiplldcr1;	/* LBIU PLL Debug Reg 1 */
 	u32	ddrioovcr;	/* DDR IO Override Control */
diff --git a/board/nxp/common/sdhc_boot.c b/board/nxp/common/sdhc_boot.c
index 16b6f0fc343..d49064f23f0 100644
--- a/board/nxp/common/sdhc_boot.c
+++ b/board/nxp/common/sdhc_boot.c
@@ -45,7 +45,7 @@ int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 
 #ifdef CONFIG_ESDHC_HC_BLK_ADDR
 	/*
-	 * On P1010 and BSC9131:
+	 * On P1010:
 	 * In High Capacity SD Cards (> 2 GBytes), the 32-bit source address and
 	 * code length of these soc specify the memory address in block address
 	 * format. Block length is fixed to 512 bytes as per the SD High
diff --git a/boot/Kconfig b/boot/Kconfig
index 0fc550c3e01..63828e5e005 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1199,7 +1199,7 @@ config FSL_FIXED_MMC_LOCATION
 
 config ESDHC_HC_BLK_ADDR
 	def_bool y
-	depends on FSL_FIXED_MMC_LOCATION && (ARCH_BSC9131 || ARCH_P1010)
+	depends on FSL_FIXED_MMC_LOCATION && ARCH_P1010
 	help
 	  In High Capacity SD Cards (> 2 GBytes), the 32-bit source address and
 	  code length of these soc specify the memory address in block address
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 671cae7aaf2..7a690721b91 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -911,7 +911,7 @@ config FSL_SDHC_V2_3
 config FSL_ESDHC
 	bool "Freescale/NXP eSDHC controller support"
 	depends on ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3 || PPC
-	select FSL_SDHC_V2_3 if ARCH_P1010 || ARCH_BSC9131
+	select FSL_SDHC_V2_3 if ARCH_P1010
 	help
 	  This selects support for the eSDHC (Enhanced Secure Digital Host
 	  Controller) found on numerous Freescale/NXP SoCs.
-- 
2.47.3

