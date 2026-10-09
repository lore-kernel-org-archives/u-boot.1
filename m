Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4BDCA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4C41815DB;
	Fri,  9 Oct 2026 19:54:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVxdlOaPVBSm; Fri,  9 Oct 2026 19:54:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5CC5815D7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575683;
	b=Q2kNiUXrdChXdww3F22ZokzR77IhA5X193XGd5NElFSek3hX2QlnKXxlvot+XtigSLkY
	 fGqrS3lysEZE08iiSqPGBZXJ7uFHY06Ar30ii1aifjra0b1RGei1Ilma2foDrvmipxGka
	 n+N+LMDd7xS/7Nw6OTtaTfnfXj4HyXSgHqvZQTCFN5t3/PWENsF+phHrSdPY1ZWcXyUu8
	 lSbZxytfUgQUQyj6C9SkHhB4ctYTBgP8uRKDrK5f+c5S5iZDFdupjizCwBvr8fV6QQ0DW
	 XEDyOvOO9MzSecwlsuDXg/V/y2L5jE+ctI/QcZboAtWklIyLDVWSO0WnLLSKXadSfqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sc7vO2TNieIUtuBA0yZtgK900LDPAo++gJJAL2ueEho=;
	b=l0rgwJ7HQjoBRfX6uoDztlXHUAIwx/gKio4ZaQRL0GnHE0uk0afTVH2YyQdsVLb4EonE
	 fOrj2bYePFh2k1JLw3ek0y7wvChyd33tPIlS0kQiOFB/glNyuc9N2My2lccKLtQLYdnTh
	 fwYMaqqszNGxWcDx6hnX+2ceartk7k/bqwq3v6xPPxirBCPEtDNfoQu6PJui9Q3/qemJW
	 Zyi4gzb33KAUCK7YbKqf5e3KYczSFThUejQNZlCiJb+THtbQY806shdWA3TVx8jOOTsI9
	 5I/b+9qe+IvG/ruiZhNv+sqxSMEznIyjuX54D1Y2nksi+0u64fckZb+LWXdg2hJNOIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575683;
	bh=Sc7vO2TNieIUtuBA0yZtgK900LDPAo++gJJAL2ueEho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lqsv7DhPdFWz83YFmW58qjPtCM2ieiVKoKcG4KOeYRmuEMwLiIsUX8zTx6W7y7u9F
	 4x7zX512OnGnbm6UBKRlMshTYLQJff9Q2CFACUN8QeUGlXX6s6LBLdvPimW0n3lNt6
	 bWKPizsBFrNCt708jepRpmQ8N9KTirnQ/84/cllaEX5K/ScP+Txhzqp+jJVCLU/hfc
	 oBvpLAcsvl7Nlx5NNbmVWuyM7bPGNfYIYdBDT5fD3MEUHoiNWjTXAzeQwxqjJOMGZf
	 3uyfhP+9xM7JJp4I1Tzz+xm7Rnj/azSKtoFs+YSHKjGGB99ZEBKB+ABI2TyMi3r/M8
	 fjJFuNIFjxVRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5CC5815D7;
	Fri,  9 Oct 2026 19:54:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id A290113B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 8670A40935
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id xUfGY2NI_vLn for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60696408CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574817;
 b=qtmGZndJzfSD19VifWbDg4W73MMkmVOffaTy6WNSx68rHPZyg1aQVG6+nerXCHuJIP4R
 QkrBASg6U0D+3pW/mucITjB0Acmf+/CYQ6IFUqjEMzTFbtawIzmKWLBTEeRsRcJWH1vFn
 S2LMbzLFTADXjRBmqGkf+ZM9sWT2Il/wLV6blPBFBhy3GD3BRVGrEfUjOy8F1it8Q4LfP
 37iDwz/Cq5M8CI+atAGrzi3NYpWuteJ2HxJ7Gas7fJEXIMMuPjfaDpJpIj8qVKCHMDwgC
 iIDpeCguXlRMhMblQ+kgVXsXhf3M6lBkZnAeYR3aq5O6BZ0I7bNVldHJWljsbEKuhkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574817;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Sc7vO2TNieIUtuBA0yZtgK900LDPAo++gJJAL2ueEho=;
 b=M16MNphUHfPRm6JbA8+4mfPvqniqyAbgB30egJaodo3FQBNdJMHOLQ1eEeYN04oY9r+y
 K6YWnPPL+taSvEAfuPJZyeoNlC7tH033p7auFXEsfBhqxE6fCxSQ20f2AYKg8noUNpyNb
 LArLj0fHaEl3QJ2BWkKS1qmv0BYDW2F18sMz/NGvR3FgifK46nk+cmBWbu8+e8IsNEdMt
 qVH7S8EYHaYQVeW1Ek7gXTYFOOsMtbJUDvob9keDwyo3K6MV68DHBTTyutjcGn4Y2rPYK
 dPZJSnMUZVSbMsyKnUUkVPp4VswmTEHFP0tGQKykcPNs5ZIVU5vUw7J+CWbD6RD9bUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=VgyO1Dt7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=z2JoIu3U; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=VgyO1Dt7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=z2JoIu3U
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 60696408CB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574634; bh=Sc7vO2TNieIUtuBA0yZtgK9
 00LDPAo++gJJAL2ueEho=; b=VgyO1Dt7ivyi3/wpGBl5713pLE1roYaCJVeGU2aO6oe//cdsbU
 /qMMjAHUu73rfQG4FFJbazpQdF/E91f3BGFjvbF4Wi5g/gVfmr7FEIUymwoWvslKQ0TbIW1G8qM
 9UxTB2SLDvJgLigzExec2BUp79OT41q6REccqLiAX7FhkjBoxL7mLMKs/dKoB9JdmTULavd0YHG
 DvAzzi0iry2NVytGvGmYPKWaxc8hjM0GwptkdsiwM1/q7Iornhzt+ximg2dIcXpjwfcMHbgUBj9
 Ufgqw+V9MM5M6SWOYChaXE0UVnsHXR/BhmORL6febbM+uFdMRnZl2JiBRwFDOwjcOfA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574634; bh=Sc7vO2TNieIUtuBA0yZtgK9
 00LDPAo++gJJAL2ueEho=; b=z2JoIu3U+jWHZw5BjXxw6RqibZnG17yBYonK71FWAEJOzmk6kd
 OSXDOXBIjagyXjv92Q4iBGmqaaZGWPeGheCg==;
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
Subject: [PATCH 22/26] powerpc: mpc85xx: Remove P1024 support
Date: Fri,  9 Oct 2026 19:37:00 +0000
Message-ID: <20261009193704.13061-23-brads@mainlining.org>
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

NXP marks P1024 End of Life, and no target in the tree selects
ARCH_P1024. Its old RDB timing branch and SoC defaults still hang
around in the shared P1020 code.

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

