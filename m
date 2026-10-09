Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F21DCA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 539A9608F1;
	Fri,  9 Oct 2026 19:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpN2CGQqOqxd; Fri,  9 Oct 2026 19:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 938F3608DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575673;
	b=rK8Y+Rq+3VDlQVT9RepSK54AGjL5v8c9XUOo1yb/HxdwWRoKo5uL16lntxJXKx5moVec
	 MuhZ4O/b6yFPwKvGklx4CZZF+BMglfDWfOOeh2DsHwFegKs37ybug4AVq54yYz8nC81Lw
	 Nski9KlXaOS02N9u43Kb97LZqqke69fypq/mXwjmtzVhWIFcdY4Zx5X/6S8ikT3PGAng0
	 HsNYWk3nh33/he/4K2ssDZqNpTRFctughKtDuicnJIQqYcfXxmkv5t2CPYQgaUJVbF4jA
	 D13ajR2Cg/rB/yhuWCyfC6+MunOwmBp2H47JkOj8qhF/y+q3a+R98hiXqcD3d1Af7fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uOp0F3Wig+3UytrCuVi2wUAalNRaNXkfMcTxOuBIZRA=;
	b=SiupCls6a4fhaYJ7EuRMYCmHuZS3S3PxfgZmWdS8tgBbhD3nfBRMyYhQvWoXnjHmnWd2
	 v88EK8JsijpJqfz0SctWeXnVr5IiSjqW6Omu74zLU67a9kEcJLAHXnT2CHAxZzMCdyIlJ
	 Njlwa0GAzRuf41IFQnBc+Y59RvR5iHbOQI0uwKfkXkVKz24Xi6CiW+aBbT458OYB/hYC2
	 nyJ/thunMWb9cABgVShR3b6SoypiZbMl3c99k+Cl8Xra4/Qbr6j0kk140UF9q75SKPi0u
	 0dPV0oVRDrlcQhKC5/ek7dgUHt56WdSO+JzCihDQOehfLMF3PR/LfLF2sx/Mzpy2vFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575673;
	bh=uOp0F3Wig+3UytrCuVi2wUAalNRaNXkfMcTxOuBIZRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x5MCkDdeBDnu7uVdNtYECbaw9AkDzTIsYNqJVdv867jhcR0X3aaLxz8zB0Agh5qiz
	 LNFg3txTYGYvGnCI5STXv3gv9PdtqeFWGQ4Md4K8bJ19MCU27zDui/rLVHthT0zmYy
	 96hCcu2SUjn75NnSWGiXtKtJ1Ci7wLfxTvNueXBGNxcXr7YRdsl6wO1G3RZ4vt+liS
	 O3yqeFn3u0VFHj6T/DLwaI6enVtgfG6QDkFlraZM09JtrDejdA9bLNdqFfbuWH6RiB
	 cmTKITFpZrLS6cR0wQyVzbAnfcf5XOp1qeIXrhQRNAOcdVMzlTl2TBUgdFbr2vBAPp
	 VGqZo+J3nvXCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 938F3608DF;
	Fri,  9 Oct 2026 19:54:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 396FB13B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 2B0E381491
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id TuR7nTyEAAha for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B016A8148E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574813;
 b=mrVLHHldo5tb4dIfyHXCnjSKieS1yQ2dQsEKO+SomBBjKhnzX46ZmoJBoDHPIMjGP/fG
 HpGseWSbbyqxBk88OM3heHAaLe+c5NoC+9ICqv7ubBztvgM2WFb4jzXXhh0hVlSCA8JvH
 KdBHT4ljbfC0p6nHLyBtdMcpKxujO9yG3zytmYedDXlStUhSfveaGCuXUXsgtybfDw2vR
 htWc1M1ZAsCfZwJohM0ZrEk0cv9UudUZOady+f8q5G7HiELwEBs+1eVgpb3kE6Olh2T8r
 3UxVrUo5okf7k2l/hUoQPfpAJHeAfUeChF7bG4jZ+cBeAW9llpXKQAfGdgc3jqsrs+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574813;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=uOp0F3Wig+3UytrCuVi2wUAalNRaNXkfMcTxOuBIZRA=;
 b=OnxLfbt148/1uGzcYywvbCWJl78levcFTE7tDrzhdBIy5zyADB30w2kFHkZXuQMdT3hK
 vR7CUiwl5YqSgEeq4+izgoC+eeRL7QgKkdOROX0psvAp0hcXElQhas/KCEhqCrYnrDF+9
 EJEt/eZ1mksaksziG+U4GrtTs9I8UVbIpRbTA7kvnsEwlUhQ7PCwnAtUopXiWxaxVaFiN
 kQ9KK/d1fdcd6Dc5pV9ayass3dxyJD5QS7b7gw6o/GuyOFQahbTlT/kZ1O26jzFJHw8Jr
 klf3Kf2cw5o1TLGijt+YDjzydIhmTXG3ZShESp/Nt50c3ulFj/dDmUQiwlRCG0JIVCw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=hHzXQWa3; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ScPUA7QU; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=hHzXQWa3; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ScPUA7QU
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id B016A8148E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574635; bh=uOp0F3Wig+3UytrCuVi2wUA
 alNRaNXkfMcTxOuBIZRA=; b=hHzXQWa3ccV38ktiHBFab9AW2tXlA1yktDrW9nRUJ+F3OetLwJ
 sZfzQM+hYBH+9Q7B2oD17Hb1LSX/4slhDsXkBOwZ8ObNNp/kmAB7Yf6kwZtFfpXIechxPgW3WZ5
 sRB+pkjK76GEoHkchD0vQck2tnWrnjCXgI3x+TFYdmaZHueVZgIOxMklCUDtVSeP5Z/6Jn7OeXb
 n0HnvshDd7HNGXZ/cqE6cbqlefDV7ri/bTisUM2P8MX4CNAkifce2ZPdx2cwEMfO6wnuDWiU+vR
 mTfw4s0Zf2kdxQMB5SXBgyOkGvqkfSGYzHNK2gv9+I9wORnemnEjXPz0Dzqa8enjN9Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574635; bh=uOp0F3Wig+3UytrCuVi2wUA
 alNRaNXkfMcTxOuBIZRA=; b=ScPUA7QUVF+ToaHNPh3mtIvlXdrgZ4CPOfkiB7jDOxExAEvK9S
 QjMA/tkxG+4UiVCF/VKIxmcG0aWFFHErnYDQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Mario Six <mario.six@gdsys.cc>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 23/26] powerpc: mpc85xx: Remove BSC9131 support
Date: Fri,  9 Oct 2026 19:37:01 +0000
Message-ID: <20261009193704.13061-24-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009193704.13061-1-brads@mainlining.org>
References: <20261009193704.13061-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 19:54:04 +0000
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

NXP marks each BSC9131 part number End of Life. No target selects
ARCH_BSC9131, so its mux, LAW and reset register paths have no users.

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
index 3840cb42b76..8ebef9d5991 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -77,7 +77,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(T2080, T2080, 0),
 	CPU_TYPE_ENTRY(T2081, T2081, 0),
 	CPU_TYPE_ENTRY(BSC9130, 9130, 1),
-	CPU_TYPE_ENTRY(BSC9131, 9131, 1),
 	CPU_TYPE_ENTRY(BSC9232, 9232, 2),
 	CPU_TYPE_ENTRY(C291, C291, 1),
 	CPU_TYPE_ENTRY(C292, C292, 1),
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

