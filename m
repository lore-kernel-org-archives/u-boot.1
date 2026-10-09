Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698E8CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DC9A816FF;
	Fri,  9 Oct 2026 19:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brNyFZeSo3P4; Fri,  9 Oct 2026 19:55:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D65FE814DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575699;
	b=skQ9CYgMaFkA+rgeQBUIai/7N6ja2O7hI4loisdo1e60IaTqA6/2a0sMEg1Kq6pL7CVM
	 8J3NH60r4zPWRP7aaX5uMY+X6JxHjdnuhS1yK298z/QIGvcomAVRdiOHAQFs7UdTIGtzU
	 z355w8Mz5kOsFWvbOCIjiqDtSy7860KeSCJba65uHv8zFDyTRmNzBXVX4CbUAGEhm35Xo
	 lazVkH+TfoqmMCgmiIMb/z4nHIdWzrMc0yp2iAxYzdZIEsJEnqPsIXNKLMnHrpEhpMSQw
	 6nRpGK73Vaox7eO7nyI1uBpdgCVTZIyarF1E4B1kJKbHuqXl1IrOl+/OgL0b2XDh8+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yY0y9PYGYR23OmtQUjXJBFkcJXIfB66Jd8WGlLzypkE=;
	b=po/4pPDJps/L8X06j/4sQ3MXrxK0qEcH4j9QiZAPNBS/ZW9rH3rVBRgZZkGL+uWkLHGJ
	 bifUsJsB07Q9dbiw0+M2czv+wShfHUbI3KP/ILr822pQeUMFJEgluESr+3Q+pcPadAz6V
	 NKH1WUjiHZsu0EwcrLn5lXnz+R1GiyCS96jR6fvY1XZIOQbjzm5CqTUYThM3rV+Ywu1gi
	 2fMF2RgogPkhET0FR6aLXycfYwB2D4b+U79ePl+joFEuo9zw0Urf3FYIMiNtY3iQJOyo5
	 G0W/wxfKx4Ai5/t7hNihpHDAOqCysJfjehiAqdF21TMY4E4NY3MXrIZdwS4ZJ8sKspg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=fmuQ0NgB;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=b6GXahr1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575699;
	bh=yY0y9PYGYR23OmtQUjXJBFkcJXIfB66Jd8WGlLzypkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KQ2rJuvwxeNqxcroMPKJm7J1/pUcE9FykCEKop9AzIaXtotoYPT/uiQ2xQf8ILwSz
	 mt6ZYo0tbuEH7ZrgHEkorjfS86aH/E/kNiI24CZQFPXFT4ZWF8zkLcAdODc0o05TkJ
	 DijlhSMoifWWFyroNuUW/MeK5HzhxC81bl2Sdm63DtjPRUyjFI4sRqp/9HVihrfYLw
	 lLl+evrex1cWJ6jgl8Sqde6mszJ+BIBz2tb0lMy17cTEUu37oq1K7oB/gA70lBXJWO
	 LxqV4tz7Y6OiVenZCuFPfGPkcxa5jY9ahZSHLAfZmtpHC7rQ/fGCw8Q6jeY0fM8Qma
	 /OS2W+XdpqcRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D65FE814DD;
	Fri,  9 Oct 2026 19:54:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 4FD4E13B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 3987F81490
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 9NxYbBVmETA5 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 077EB81491
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574820;
 b=ImHYnMTTvXFmrM2/7tezP/IF0Mrnxeqk4g0ePSruN/8aMUgvKV/pZ1jhUrkLauDpiEgx
 xHPrcmdk5HKp8P4ptddKBRx6bLzWNG5INctnsIX/xn8G30s8xDphlO2uyZ4nQ2jtipogG
 l2NIvkcw7mXXLXVEMtNwRu2EbHBB2dAidsPT12KasiHPHa+RTEUhgOqU99eCmY/SayW9w
 ZFK4AYh/LDwerDm/YQIXQ2Tokom7EC5+SNLHGLUMIOHjGM9r6Jeb9CpjoHDdJVwXgMy+W
 sap2PjysQcyrEoUi7kBamL7tCGXuSyoySBtoVmktYq/32khpKRGl+iuHWfsUjNIlH4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574820;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yY0y9PYGYR23OmtQUjXJBFkcJXIfB66Jd8WGlLzypkE=;
 b=kYV0VaLKDACJ6iOwUcAIZsTFjIyJevBWxb7XXuYxp3SrhUT7OUQ/3Mm1EMj+wYhYC9zj
 leDf13aShnntiHBVi078xaR4ZK9pOKfdSzWnzXScq5Dqzve0KyO0xcQPatXB0OpgVhMUB
 OEgUdAzlOjR0BzhqEqFvBUUWlTZ+c06mygSPz+iZ7ihBEUbOVwme4gmQXNnmVHwkQ33T2
 hxFWxQSyKDyGd82SlPrb73e/bmOL3dU3jz/61mL+318mKgvhAVgkH8s+RSGErqJjGW7kv
 jFdcZKr1z038eJIB2PHfjIRXprHiaplHpwpWoyvZSUCImGxprzbLkXS4LGveiaklwPQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=fmuQ0NgB; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=b6GXahr1; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=fmuQ0NgB; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=b6GXahr1
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 077EB81491
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574630; bh=yY0y9PYGYR23OmtQUjXJBFk
 cJXIfB66Jd8WGlLzypkE=; b=fmuQ0NgBQCWbNs0TRBxJMhyBG+RAxPKZqzwzR489LZnXF7O8Kg
 vivzxcGrLuyNBEEXGtMdTiValDTHxfMbHwcvwhbgM8TcvGf3zVJHClZOuOvXshNmteqKTiM7WEV
 8o9tNZhMRx1wzoXXMoQPPSBrwRyDnzWkedlPZk81J58f6bI0hkLvhDQiDqlUmHhuH75N3AEs+a2
 O4StKxn7w6RDzFtSSJZJ5cQAV1HJnQwwmYLimNMT7GQ2gorsAp6Sxzuukl/Gh3kjmKxsHfSx6yo
 7uSNHF55/wDEJelOsNwRi0/AG39nCUCwikGnJ4KkbJTwsPfKYu60fBcbm5vFyI1+9Cw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574630; bh=yY0y9PYGYR23OmtQUjXJBFk
 cJXIfB66Jd8WGlLzypkE=; b=b6GXahr1mgzH8sHCvvjDnK0SnPOj3IQZ1xnAtS7dz/y8W6yGBj
 o6xeV8E9bMoP/g4/Fv3AYrchQJPzAlVp9sBA==;
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
Subject: [PATCH 12/26] powerpc: mpc85xx: Remove C29x support
Date: Fri,  9 Oct 2026 19:36:50 +0000
Message-ID: <20261009193704.13061-13-brads@mainlining.org>
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

NXP lists the C29x family as end of life, and no board in the tree selects
ARCH_C29X. Remove the unused platform support and its C29x specific
crypto, clocking and SERDES setup.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                          |  4 +-
 arch/powerpc/cpu/mpc85xx/Kconfig          | 22 +------
 arch/powerpc/cpu/mpc85xx/Makefile         |  1 -
 arch/powerpc/cpu/mpc85xx/c29x_serdes.c    | 70 -----------------------
 arch/powerpc/cpu/mpc85xx/cpu_init.c       | 11 ----
 arch/powerpc/include/asm/config_mpc85xx.h |  3 -
 arch/powerpc/include/asm/immap_85xx.h     | 22 -------
 arch/powerpc/include/asm/processor.h      |  3 -
 drivers/crypto/fsl/jr.c                   | 14 +----
 drivers/mmc/Kconfig                       |  3 +-
 include/fsl_sec.h                         |  3 -
 11 files changed, 7 insertions(+), 149 deletions(-)
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

