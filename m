Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B201CCA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DFB6814DD;
	Fri,  9 Oct 2026 19:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p6w-9fFAHswZ; Fri,  9 Oct 2026 19:54:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79075814DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575664;
	b=UT25DWQ7jCXZEl3Jr/YfmeFjqC54uiDwC3sVhc9TAtlr4vHh6js1yz6wBq156zhUcqpE
	 Bj+VsFDrItRuCxY+WH0V2yhAemfJHdnT1Z+cLEMSB7tuatV3DOXiWzxlsJC4i+0leXA+I
	 92XfqM8rYuZJiTArNMOkku2o6ujBefdOsDJmRgDeDkOyRmdzNptxJSQavmVgMUr9TSOPO
	 nPxA/xDPb3k9XF/i7cx98tiLYnC7J+TDNCfDYr8prvGE8MNcF/p8dkTvAXbx6jRBc1Cin
	 IJMd0CHtIDuwk/u+RBubnnIs0ej7w1yZhOiVi4pANYBL+ZUgI0XWm+O9yNAl6vzP6Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZM42ndKBLvTbo5m+7WE7ICJvwaydMAxN2dYs16+J1OY=;
	b=bBWB36SZjMzKD3xet26tyfFFjyuJEO0mJrDIVQPGUGX2OSkC+oDLXEsz+YPHUDXuQx1F
	 IL6h+kkt8yKayXJvnxSYMSMWNWMc7zFh2v8PB8ySvnC2yoT6j+gUlW9JjORMRFLO6CW06
	 7NN2pr3LlHdgNB1f+D+fCOLbtblK3/U2pEGPTVbwHHQmwLVzt8DpkD735k7qmXvvkujF4
	 yuEDm1dWuZZkyclvQ3K/vCsKAs98XqzH7FAyP6br0AgoPbD10YkOOo/H56a6SdxbRgq82
	 USOEwqpzlnVVw6wcS5ZPlk1UcfRpMiVpzKEo3RkFdpRte4Fr73AmB7fD4+/eeJkshEQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=QOQSj5hk;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=FG2qkjZb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575664;
	bh=ZM42ndKBLvTbo5m+7WE7ICJvwaydMAxN2dYs16+J1OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gf983V9etMSozeJ8vnQbyY1srDeQ/BSoi0MD8SD8oiJdC4bH1Hl9NxqWvs4TZnKMX
	 Q/dFCA7SxSfP4lvgdVV53iEMS2f2d7Aue39UDUtO9WcnYHFvicfLAvymXoGRYJCjuE
	 pcLNUz/vxW4BsqscE0JwKdvnf2fLdWBSrgV5ncl4S2qNBV/SteQSEMAIfWR8g5tJ3D
	 7elcoRCQvf7veJQDOSOYK2prGhcai/zSb6g1oLp7LTl5gh9J/su4gk/QCFJvXQZqUe
	 Ujei6myXVU+OPNgMjNpm/00BHAZTqR/tMzKDh+h8iaW1rOVyg5QChMtD74rEO90zVM
	 NKxa8ipQTGZxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79075814DC;
	Fri,  9 Oct 2026 19:54:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 28A57356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 1A874814A0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 5Oe8Pw77peNB for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28B7B81491
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574811;
 b=WsInWcenewUJVLwIYFFe/pn6myJZ4auddlsytbCV+uiBO6h29+5Ru8ZBrJK72hIMdBLy
 zb9MuXsJvL0CT54ZWz3i9IpmdDB48CXsnuR2qWUwdp1qGXiGVJiDOs/hN2JLQtAgggnGU
 e3Ok8Lv7iTIxyPMQAfXJFh1Ei+dtJ2F13Iwc8CAuIB+NGOIrzJIY7XleUex6q15itO7h5
 BC6mgDpjxj0HcgYQqVXfe1T3/07u8CE1TgSfC1hn0UcrucHv4HOl0um5w45tKAPgqNkiS
 /NDUiaDkCIe4R8f9zim0E1qVKr6pLWH9uUdWTQ8tSPUTnDU8c/3Fu2qo0v4pcvr7WQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574811;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ZM42ndKBLvTbo5m+7WE7ICJvwaydMAxN2dYs16+J1OY=;
 b=YVuNQ3sVWNfSFKVuYcra0zHg5nmhvakZNhtsJ1tSlMMqtCpFfPgRvXwRNUrV0Cjis888
 mTB0gG/lCTu+yYiopZ49pEC1o+osnt9HhzRf6f4McEWZhwsokyZPEz8Z3FfQQwQIoB+dl
 nMMsqgBE/T3/vU2fFSdHF9vPuAjluU2r46E1PTtMTtA2XFfUAAZqAfonEYzI+X2bdeK5g
 xERrpnVaAt+YEvO7eWgE28k8GEESfhvuiobXW2McrKeot7LA0glqDJqH5L5vVGaG2cgho
 qMO52bzeqhdSl6RGHwLfNQQyooMWxrH9EfTwbw81Zl9sgzfiIeKxu95QMxWZZtlsRLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=QOQSj5hk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=FG2qkjZb; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=QOQSj5hk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=FG2qkjZb
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 28B7B81491
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574628; bh=ZM42ndKBLvTbo5m+7WE7ICJ
 vwaydMAxN2dYs16+J1OY=; b=QOQSj5hks87V7xxhAOqL6jJAg0u1BvHksiH/pVxSNgBdFHz0tT
 +FSSB/DhSQT/OO4d3N5sTM/chYO88oEVttblt66LNt7rqTbd/hkw7VkORLPBCR3GweCzkXjnwp4
 I3VQpheMVCfVEDEY8wJAP24Tssx7OIIKSkRvnWeMJViA4Caz1mXJYFIYJ1ty1Q1oNrjzrD11ZwE
 enr31+iCmvGUrmIbsgqC9qwdTXiDNDSrPI+aDYkwvGcY+xUobv7aUv4bUFNpsMJT5dqmv9aAGAp
 T4/ATY03BTeSg8YQH+iVk5NarcJ3PpDt4Aktyb87hhBssgUb/2+Yn14hd7PybMbVmvA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574628; bh=ZM42ndKBLvTbo5m+7WE7ICJ
 vwaydMAxN2dYs16+J1OY=; b=FG2qkjZbXY0Ub8nAsPXQ5w1pkHfj/CaejEksQ/4eP/wzc1xLzx
 PI5c4X8SAtuOPv4ND3kiy56BqZlQyOtBw2CA==;
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
Subject: [PATCH 08/26] powerpc: mpc85xx: Remove P3041 support
Date: Fri,  9 Oct 2026 19:36:46 +0000
Message-ID: <20261009193704.13061-9-brads@mainlining.org>
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

The P3041DS was the last user in the tree of ARCH_P3041. NXP lists the processor and development system as no longer manufactured.

Nothing selects the SoC option now. Drop its remaining CPU, SERDES, FM and errata support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                          |   3 +-
 arch/powerpc/cpu/mpc85xx/Kconfig          |  45 +-------
 arch/powerpc/cpu/mpc85xx/Makefile         |   2 -
 arch/powerpc/cpu/mpc85xx/cmd_errata.c     |   6 +-
 arch/powerpc/cpu/mpc85xx/cpu_init.c       |   4 +-
 arch/powerpc/cpu/mpc85xx/p3041_ids.c      | 112 ------------------
 arch/powerpc/cpu/mpc85xx/p3041_serdes.c   | 133 ----------------------
 arch/powerpc/cpu/mpc85xx/release.S        |   2 +-
 arch/powerpc/cpu/mpc8xxx/cpu.c            |   1 -
 arch/powerpc/include/asm/config_mpc85xx.h |  10 --
 arch/powerpc/include/asm/immap_85xx.h     |   3 +-
 arch/powerpc/include/asm/processor.h      |   1 -
 doc/README.pblimage                       |   6 +-
 drivers/net/Kconfig                       |   1 -
 drivers/net/fm/Makefile                   |   3 +-
 drivers/usb/common/fsl-errata.c           |   5 -
 16 files changed, 15 insertions(+), 322 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p3041_serdes.c

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 152692e3230..ff645aea0d3 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -5,8 +5,7 @@ config FSL_TRUST_ARCH_v1
 
 config NXP_ESBC
 	bool "NXP ESBC (secure boot) functionality"
-	select FSL_TRUST_ARCH_v1 if ARCH_P3041 || ARCH_P4080 || \
-		ARCH_P5040 || ARCH_P2041
+	select FSL_TRUST_ARCH_v1 if ARCH_P4080 || ARCH_P5040 || ARCH_P2041
 	help
 	  Enable Freescale Secure Boot feature. Normally selected by defconfig.
 	  If unsure, do not change.
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 7fee93862c7..ab80a1ab317 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -584,41 +584,6 @@ config ARCH_P2041
 	select FSL_ELBC
 	imply CMD_NAND
 
-config ARCH_P3041
-	bool
-	select BACKSIDE_L2_CACHE
-	select E500MC
-	select FSL_CORENET
-	select FSL_LAW
-	select SYS_CACHE_SHIFT_6
-	select SYS_FSL_DDR_VER_44
-	select SYS_FSL_ERRATUM_A004510
-	select SYS_FSL_ERRATUM_A004849
-	select SYS_FSL_ERRATUM_A005275
-	select SYS_FSL_ERRATUM_A005812
-	select SYS_FSL_ERRATUM_A006261
-	select SYS_FSL_ERRATUM_CPU_A003999
-	select SYS_FSL_ERRATUM_DDR_A003
-	select SYS_FSL_ERRATUM_DDR_A003474
-	select SYS_FSL_ERRATUM_ESDHC111
-	select SYS_FSL_ERRATUM_I2C_A004447
-	select SYS_FSL_ERRATUM_NMG_CPU_A011
-	select SYS_FSL_ERRATUM_SRIO_A004034
-	select SYS_FSL_ERRATUM_USB14
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_QORIQ_CHASSIS1
-	select SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v22
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select SYS_FSL_USB1_PHY_ENABLE
-	select SYS_FSL_USB2_PHY_ENABLE
-	select FSL_ELBC
-	imply CMD_NAND
-	imply SATA
-	imply CMD_REGINFO
-	imply FSL_SATA
-
 config ARCH_P4080
 	bool
 	select BACKSIDE_L2_CACHE
@@ -929,7 +894,6 @@ config MAX_CPUS
 	default 8 if ARCH_P4080
 	default 4 if ARCH_B4860 || \
 		     ARCH_P2041 || \
-		     ARCH_P3041 || \
 		     ARCH_P5040 || \
 		     ARCH_T1040 || \
 		     ARCH_T1042 || \
@@ -971,7 +935,6 @@ config SYS_CCSRBAR_DEFAULT
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
 				ARCH_P2041	|| \
-				ARCH_P3041	|| \
 				ARCH_P4080	|| \
 				ARCH_P5040	|| \
 				ARCH_T1024	|| \
@@ -1036,7 +999,7 @@ config SYS_FSL_ERRATUM_A004510_SVR_REV
 
 config SYS_FSL_ERRATUM_A004510_SVR_REV2
 	hex
-	depends on (SYS_FSL_ERRATUM_A004510 && (ARCH_P2041 || ARCH_P3041))
+	depends on (SYS_FSL_ERRATUM_A004510 && ARCH_P2041)
 	default 0x11
 
 config SYS_FSL_ERRATUM_A005125
@@ -1111,7 +1074,7 @@ config SYS_FSL_A004447_SVR_REV
 	depends on SYS_FSL_ERRATUM_I2C_A004447
 	default 0x10 if ARCH_P1010
 	default 0x11 if ARCH_P1023 || ARCH_P2041 || ARCH_BSC9132
-	default 0x20 if ARCH_P3041 || ARCH_P4080
+	default 0x20 if ARCH_P4080
 
 config SYS_FSL_ERRATUM_IFC_A002769
 	bool
@@ -1188,7 +1151,6 @@ config SYS_FSL_NUM_LAWS
 	default 32 if	ARCH_B4420	|| \
 			ARCH_B4860	|| \
 			ARCH_P2041	|| \
-			ARCH_P3041	|| \
 			ARCH_P4080	|| \
 			ARCH_P5040	|| \
 			ARCH_T2080	|| \
@@ -1353,7 +1315,6 @@ config SYS_FSL_LBC_CLK_DIV
 		ARCH_MPC8560
 
 	default 2 if	ARCH_P2041	|| \
-			ARCH_P3041	|| \
 			ARCH_P4080	|| \
 			ARCH_P5040
 	default 1
@@ -1416,7 +1377,7 @@ config SYS_FSL_SRIO_LIODN
 
 config SYS_FSL_TBCLK_DIV
 	int
-	default 32 if ARCH_P2041 || ARCH_P3041
+	default 32 if ARCH_P2041
 	default 16 if ARCH_P4080 || ARCH_P5040 || ARCH_T4240 || ARCH_B4860 || \
 			ARCH_B4420 || ARCH_T1040 || ARCH_T1042 || \
 			ARCH_T1024 || ARCH_T2080
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 6717e2c4578..664e566b06e 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_SYS_DPAA_QBMAN) += portals.o
 
 # various SoC specific assignments
 obj-$(CONFIG_ARCH_P2041) += p2041_ids.o
-obj-$(CONFIG_ARCH_P3041) += p3041_ids.o
 obj-$(CONFIG_ARCH_P4080) += p4080_ids.o
 obj-$(CONFIG_ARCH_P5040) += p5040_ids.o
 obj-$(CONFIG_ARCH_T4240) += t4240_ids.o
@@ -66,7 +65,6 @@ obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
 obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
-obj-$(CONFIG_ARCH_P3041) += p3041_serdes.o
 obj-$(CONFIG_ARCH_P4080) += p4080_serdes.o
 obj-$(CONFIG_ARCH_P5040) += p5040_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/cmd_errata.c b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
index f91a4d441d3..52de04323c9 100644
--- a/arch/powerpc/cpu/mpc85xx/cmd_errata.c
+++ b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
@@ -25,7 +25,7 @@ static void check_erratum_a4849(uint32_t svr)
 	void __iomem *dcsr = (void *)CFG_SYS_DCSRBAR + 0xb0000;
 	unsigned int i;
 
-#if defined(CONFIG_ARCH_P2041) || defined(CONFIG_ARCH_P3041)
+#ifdef CONFIG_ARCH_P2041
 	static const uint8_t offsets[] = {
 		0x50, 0x54, 0x58, 0x90, 0x94, 0x98
 	};
@@ -44,7 +44,7 @@ static void check_erratum_a4849(uint32_t svr)
 		}
 	}
 
-#if defined(CONFIG_ARCH_P2041) || defined(CONFIG_ARCH_P3041)
+#ifdef CONFIG_ARCH_P2041
 	x108 = 0x12;
 #endif
 
@@ -162,7 +162,7 @@ static int do_errata(struct cmd_tbl *cmdtp, int flag, int argc,
 #ifdef CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011
 	/*
 	 * NMG_CPU_A011 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * also applies to P3041 rev 1.0, 1.1, P2041 rev 1.0, 1.1
+	 * also applies to P2041 rev 1.0, 1.1
 	 * The SVR has been checked by cpu_init_r().
 	 */
 	if (enable_cpu_a011_workaround)
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 4390f754809..6d150cb8ba2 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -659,8 +659,8 @@ int cpu_init_r(void)
 	 * CPU22 and NMG_CPU_A011 share the same workaround.
 	 * CPU22 applies to P4080 rev 1.0, 2.0, fixed in 3.0
 	 * NMG_CPU_A011 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * also applies to P3041 rev 1.0, 1.1, P2041 rev 1.0, 1.1, both
-	 * fixed in 2.0. NMG_CPU_A011 is activated by default and can
+	 * also applies to P2041 rev 1.0, 1.1, fixed in 2.0.
+	 * NMG_CPU_A011 is activated by default and can
 	 * be disabled by hwconfig with syntax:
 	 *
 	 * fsl_cpu_a011:disable
diff --git a/arch/powerpc/cpu/mpc85xx/p3041_ids.c b/arch/powerpc/cpu/mpc85xx/p3041_ids.c
deleted file mode 100644
index 0675a59414b..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p3041_ids.c
+++ /dev/null
@@ -1,112 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <linux/kernel.h>
-#include <asm/fsl_portals.h>
-#include <asm/fsl_liodn.h>
-
-#ifdef CONFIG_SYS_DPAA_QBMAN
-struct qportal_info qp_info[CFG_SYS_QMAN_NUM_PORTALS] = {
-	/* dqrr liodn, frame data liodn, liodn off, sdest */
-	SET_QP_INFO(1,  2,  1, 0),
-	SET_QP_INFO(3,  4,  2, 1),
-	SET_QP_INFO(5,  6,  3, 2),
-	SET_QP_INFO(7,  8,  4, 3),
-	SET_QP_INFO(9, 10,  5, 0),
-	SET_QP_INFO(1, 12,  6, 1),
-	SET_QP_INFO(13, 14,  7, 2),
-	SET_QP_INFO(15, 16,  8, 3),
-	SET_QP_INFO(17, 18,  9, 0), /* for now sdest to 0 */
-	SET_QP_INFO(19, 20, 10, 0), /* for now sdest to 0 */
-};
-#endif
-
-struct srio_liodn_id_table srio_liodn_tbl[] = {
-	SET_SRIO_LIODN_2(1, 199, 200),
-	SET_SRIO_LIODN_2(2, 201, 202),
-};
-int srio_liodn_tbl_sz = ARRAY_SIZE(srio_liodn_tbl);
-
-struct liodn_id_table liodn_tbl[] = {
-#ifdef CONFIG_SYS_DPAA_QBMAN
-	SET_QMAN_LIODN(31),
-	SET_BMAN_LIODN(32),
-#endif
-
-	SET_SDHC_LIODN(1, 64),
-
-	SET_PME_LIODN(117),
-
-	SET_USB_LIODN(1, "fsl-usb2-mph", 125),
-	SET_USB_LIODN(2, "fsl-usb2-dr", 126),
-
-	SET_SATA_LIODN(1, 127),
-	SET_SATA_LIODN(2, 128),
-
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 1, 193),
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 2, 194),
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 3, 195),
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 4, 196),
-
-	SET_DMA_LIODN(1, "fsl,eloplus-dma", 197),
-	SET_DMA_LIODN(2, "fsl,eloplus-dma", 198),
-
-	SET_GUTS_LIODN("fsl,rapidio-delta", 199, rio1liodnr, 0),
-	SET_GUTS_LIODN(NULL, 200, rio2liodnr, 0),
-	SET_GUTS_LIODN(NULL, 201, rio1maintliodnr, 0),
-	SET_GUTS_LIODN(NULL, 202, rio2maintliodnr, 0),
-};
-int liodn_tbl_sz = ARRAY_SIZE(liodn_tbl);
-
-#ifdef CONFIG_SYS_DPAA_FMAN
-struct fman_liodn_id_table fman1_liodn_tbl[] = {
-	SET_FMAN_RX_1G_LIODN(1, 0, 10),
-	SET_FMAN_RX_1G_LIODN(1, 1, 11),
-	SET_FMAN_RX_1G_LIODN(1, 2, 12),
-	SET_FMAN_RX_1G_LIODN(1, 3, 13),
-	SET_FMAN_RX_1G_LIODN(1, 4, 14),
-	SET_FMAN_RX_10G_LIODN(1, 0, 15),
-};
-int fman1_liodn_tbl_sz = ARRAY_SIZE(fman1_liodn_tbl);
-#endif
-
-struct liodn_id_table sec_liodn_tbl[] = {
-	SET_SEC_JR_LIODN_ENTRY(0, 129, 130),
-	SET_SEC_JR_LIODN_ENTRY(1, 131, 132),
-	SET_SEC_JR_LIODN_ENTRY(2, 133, 134),
-	SET_SEC_JR_LIODN_ENTRY(3, 135, 136),
-	SET_SEC_RTIC_LIODN_ENTRY(a, 154),
-	SET_SEC_RTIC_LIODN_ENTRY(b, 155),
-	SET_SEC_RTIC_LIODN_ENTRY(c, 156),
-	SET_SEC_RTIC_LIODN_ENTRY(d, 157),
-	SET_SEC_DECO_LIODN_ENTRY(0, 97, 98),
-	SET_SEC_DECO_LIODN_ENTRY(1, 99, 100),
-};
-int sec_liodn_tbl_sz = ARRAY_SIZE(sec_liodn_tbl);
-
-#ifdef CONFIG_SYS_DPAA_RMAN
-struct liodn_id_table rman_liodn_tbl[] = {
-	/* Set RMan block 0-3 liodn offset */
-	SET_RMAN_LIODN(0, 6),
-	SET_RMAN_LIODN(1, 7),
-	SET_RMAN_LIODN(2, 8),
-	SET_RMAN_LIODN(3, 9),
-};
-int rman_liodn_tbl_sz = ARRAY_SIZE(rman_liodn_tbl);
-#endif
-
-struct liodn_id_table liodn_bases[] = {
-	[FSL_HW_PORTAL_SEC]  = SET_LIODN_BASE_2(64, 100),
-#ifdef CONFIG_SYS_DPAA_FMAN
-	[FSL_HW_PORTAL_FMAN1] = SET_LIODN_BASE_1(32),
-#endif
-#ifdef CONFIG_SYS_DPAA_PME
-	[FSL_HW_PORTAL_PME]   = SET_LIODN_BASE_2(136, 172),
-#endif
-#ifdef CONFIG_SYS_DPAA_RMAN
-	[FSL_HW_PORTAL_RMAN] = SET_LIODN_BASE_1(80),
-#endif
-};
diff --git a/arch/powerpc/cpu/mpc85xx/p3041_serdes.c b/arch/powerpc/cpu/mpc85xx/p3041_serdes.c
deleted file mode 100644
index b1586f110e8..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p3041_serdes.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2009-2011 Freescale Semiconductor, Inc.
- */
-
-#include <asm/fsl_serdes.h>
-#include <asm/processor.h>
-#include <asm/io.h>
-#include "fsl_corenet_serdes.h"
-
-static u8 serdes_cfg_tbl[][SRDS_MAX_LANES] = {
-	[0x2] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		PCIE4, AURORA, PCIE3, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2, },
-	[0x4] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		PCIE2, AURORA, PCIE3, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, },
-	[0xb] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO2, SRIO2, SRIO1, SRIO1,
-		PCIE2, AURORA, PCIE3, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2, },
-	[0x10] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x11] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2, },
-	[0x13] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, XAUI_FM1, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, },
-	[0x14] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, PCIE3, PCIE3, PCIE3, PCIE3,
-		SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, },
-	[0x15] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x16] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, SRIO1, SRIO1, SRIO1,
-		SRIO1, },
-	[0x17] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2, },
-	[0x18] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, SGMII_FM1_DTSEC5, NONE,
-		NONE, NONE, },
-	[0x1b] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x1d] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, PCIE3, PCIE3, PCIE3, PCIE3, NONE, NONE,
-		SATA1, SATA2, },
-	[0x20] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, XAUI_FM1, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, },
-	[0x21] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, PCIE3, PCIE3, PCIE3, PCIE3,
-		SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, },
-	[0x22] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x23] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO2, SRIO2, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2, },
-	[0x24] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO2, SRIO2, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, SGMII_FM1_DTSEC5, NONE,
-		NONE, NONE, },
-	[0x28] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2, },
-	[0x29] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, SGMII_FM1_DTSEC5, NONE,
-		NONE, NONE, },
-	[0x2a] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, XAUI_FM1, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, },
-	[0x2b] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x2f] = {PCIE1, PCIE1, PCIE3, PCIE3, SRIO2, SRIO2, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x31] = {PCIE1, PCIE1, PCIE3, PCIE3, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, SGMII_FM1_DTSEC5, NONE,
-		NONE, NONE, },
-	[0x33] = {PCIE1, PCIE1, PCIE3, PCIE3, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, },
-	[0x34] = {PCIE1, PCIE1, PCIE1, PCIE1, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA,
-		AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE,
-		NONE, SATA1, SATA2, },
-	[0x35] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA, AURORA, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE, NONE, SATA1, SATA2, },
-	[0x36] = {PCIE1, PCIE1, PCIE3, PCIE3, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA,
-		AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE,
-		NONE, SATA1, SATA2, },
-	[0x37] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA, AURORA, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE, NONE, SATA1, SATA2, },
-};
-
-enum srds_prtcl serdes_get_prtcl(int cfg, int lane)
-{
-	if (!serdes_lane_enabled(lane))
-		return NONE;
-
-	return serdes_cfg_tbl[cfg][lane];
-}
-
-int is_serdes_prtcl_valid(u32 prtcl) {
-	int i;
-
-	if (prtcl >= ARRAY_SIZE(serdes_cfg_tbl))
-		return 0;
-
-	for (i = 0; i < SRDS_MAX_LANES; i++) {
-		if (serdes_cfg_tbl[prtcl][i] != NONE)
-			return 1;
-	}
-
-	return 0;
-}
diff --git a/arch/powerpc/cpu/mpc85xx/release.S b/arch/powerpc/cpu/mpc85xx/release.S
index 391751ce1e7..078d8cf3f34 100644
--- a/arch/powerpc/cpu/mpc85xx/release.S
+++ b/arch/powerpc/cpu/mpc85xx/release.S
@@ -208,7 +208,7 @@ __secondary_start_page:
 	/*
 	 * CPU22 applies to P4080 rev 1.0, 2.0, fixed in 3.0
 	 * NMG_CPU_A011 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * also appleis to P3041 rev 1.0, 1.1, P2041 rev 1.0, 1.1
+	 * also applies to P2041 rev 1.0, 1.1
 	 */
 	mfspr   r3,SPRN_SVR
 	rlwinm	r6,r3,24,~0x800		/* clear E bit */
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index d64eb7328fe..b8bec9ed2e8 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -56,7 +56,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P2020, P2020, 2),
 	CPU_TYPE_ENTRY(P2040, P2040, 4),
 	CPU_TYPE_ENTRY(P2041, P2041, 4),
-	CPU_TYPE_ENTRY(P3041, P3041, 4),
 	CPU_TYPE_ENTRY(P4040, P4040, 4),
 	CPU_TYPE_ENTRY(P4080, P4080, 8),
 	CPU_TYPE_ENTRY(P5010, P5010, 1),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index d7d18c3eeca..07be48d518d 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -44,16 +44,6 @@
 #define CFG_SYS_FSL_SRIO_IB_WIN_NUM	5
 #define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xf0000000
 
-#elif defined(CONFIG_ARCH_P3041)
-#define CFG_SYS_NUM_FMAN		1
-#define CFG_SYS_NUM_FM1_DTSEC	5
-#define CFG_SYS_NUM_FM1_10GEC	1
-#define CFG_SYS_FM_MURAM_SIZE	0x28000
-#define CFG_SYS_FSL_SRIO_MAX_PORTS	2
-#define CFG_SYS_FSL_SRIO_OB_WIN_NUM	9
-#define CFG_SYS_FSL_SRIO_IB_WIN_NUM	5
-#define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xf0000000
-
 #elif defined(CONFIG_ARCH_P4080) /* also supports P4040 */
 #define CFG_SYS_NUM_FMAN		2
 #define CFG_SYS_NUM_FM1_DTSEC	4
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 9e082a87a3b..e1d1ca80092 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1522,8 +1522,7 @@ typedef struct ccsr_gur {
 #define FSL_CORENET_RCWSR11_EC2_FM1_DTSEC2		0x00080000
 #define FSL_CORENET_RCWSR11_EC2_USB2			0x00100000
 #endif
-#if defined(CONFIG_ARCH_P2041) || \
-	defined(CONFIG_ARCH_P3041)
+#if defined(CONFIG_ARCH_P2041)
 #define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC4_RGMII	0x00000000
 #define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC4_MII		0x00800000
 #define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC4_NONE		0x00c00000
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 2357734a5be..31d52f3b734 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1048,7 +1048,6 @@
 #define SVR_P2020	0x80E200
 #define SVR_P2040	0x821000
 #define SVR_P2041	0x821001
-#define SVR_P3041	0x821103
 #define SVR_P4040	0x820100
 #define SVR_P4080	0x820000
 #define SVR_P5010	0x822100
diff --git a/doc/README.pblimage b/doc/README.pblimage
index e99b010d262..7145622b575 100644
--- a/doc/README.pblimage
+++ b/doc/README.pblimage
@@ -14,15 +14,15 @@ Building PBL Boot Image and boot steps
 1. Building PBL Boot Image.
    The default Image is u-boot.pbl.
 
-   For eSPI boot(available on P2041/P3041/P4080/P5020/P5040/T4240):
+   For eSPI boot(available on P2041/P4080/P5020/P5040/T4240):
 	To build the eSPI boot image:
 	make <board_name>_SPIFLASH
 
-   For SD boot(available on P2041/P3041/P4080/P5020/P5040/T4240):
+   For SD boot(available on P2041/P4080/P5020/P5040/T4240):
 	To build the SD boot image:
 	make <board_name>_SDCARD
 
-   For Nand boot(available on P2041/P3041/P5020/P5040):
+   For Nand boot(available on P2041/P5020/P5040):
 	To build the NAND boot image:
 	make <board_name>_NAND
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c057504cf66..fb0dc39cf35 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -970,7 +970,6 @@ config SYS_DPAA_QBMAN
 		     ARCH_T2080 || \
 		     ARCH_T4240 || \
 		     ARCH_P4080 || \
-		     ARCH_P3041 || \
 		     ARCH_P5040 || \
 		     ARCH_LS1043A || \
 		     ARCH_LS1046A
diff --git a/drivers/net/fm/Makefile b/drivers/net/fm/Makefile
index b34209d2b3e..af8fca353a9 100644
--- a/drivers/net/fm/Makefile
+++ b/drivers/net/fm/Makefile
@@ -14,9 +14,8 @@ obj-$(CONFIG_SYS_FMAN_V3) += memac.o
 
 # SoC specific SERDES support
 obj-$(CONFIG_ARCH_P1023)	+= p1023.o
-# The P204x, P304x, and P5020 are the same
+# The P204x and P5020 are the same
 obj-$(CONFIG_ARCH_P2041) += p5020.o
-obj-$(CONFIG_ARCH_P3041) += p5020.o
 obj-$(CONFIG_ARCH_P4080) += p4080.o
 obj-$(CONFIG_ARCH_P5040) += p5040.o
 obj-$(CONFIG_ARCH_T1040) += t1040.o
diff --git a/drivers/usb/common/fsl-errata.c b/drivers/usb/common/fsl-errata.c
index 66ff93b2982..e2f0563e33c 100644
--- a/drivers/usb/common/fsl-errata.c
+++ b/drivers/usb/common/fsl-errata.c
@@ -54,7 +54,6 @@ bool has_erratum_a005275(void)
 
 	switch (soc) {
 #ifdef CONFIG_PPC
-	case SVR_P3041:
 	case SVR_P2041:
 	case SVR_P2040:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 1, 1);
@@ -85,10 +84,6 @@ bool has_erratum_a006261(void)
 		return IS_SVR_REV(svr, 1, 0) ||
 			IS_SVR_REV(svr, 1, 1) ||
 			IS_SVR_REV(svr, 2, 0) || IS_SVR_REV(svr, 2, 1);
-	case SVR_P3041:
-		return IS_SVR_REV(svr, 1, 0) ||
-			IS_SVR_REV(svr, 1, 1) ||
-			IS_SVR_REV(svr, 2, 0) || IS_SVR_REV(svr, 2, 1);
 	case SVR_P5010:
 	case SVR_P5020:
 	case SVR_P5021:
-- 
2.47.3

