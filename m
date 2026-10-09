Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F2CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEAF4608E0;
	Fri,  9 Oct 2026 19:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLTYd8-YSYCl; Fri,  9 Oct 2026 19:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61CF4608D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575659;
	b=V9iB0++xkrRO5cCtZUeyAwmuNlsXOP/LQWi7DMg/0ZmE6HnjeSmNLEmYwxcuZaSwBC2h
	 ZrhpmC3s6Rf/KjIuaQfARMRSME6DFOcH4oklZsZy5Vf2KKTjCBbH8vPiwb8SKGrn59KMW
	 rxJeDS9wTgOp1TYWa3tnEgDx2tpTvKhUIOsYHZn3mq7lnAzxprVmhYj0jieZMU8ftPmKN
	 4hSZMd/L0PhLaqjmKqnRg1qCVKijTxypoTlEGKcs54l1utSMz3063xv6YqZ3wF7nJsG5c
	 Hak8Uu35cjjiS17fluW/OVBYYqAwfKWmJnLePIDdkyveEszfD40NuoZcseMmJVtu8cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RIiOCwSHCn4jH2r/w5t9l0Z6mRlQin3/mr3hVLos11s=;
	b=KK7Z7CZrz3f1IGqiOBEhlG+wc2ASDk0314jR68b2+DG/9P9BfluzVLkyuMATxuKbVB8E
	 Dk8lNfg8u91BFMgKEmfrqlYEtvWCrrWJiH3GyOecuKLW2ti3uMq36qVdJmhAZuf3WObr+
	 +fbiGlRObKF59wXUkTEXqTOqyWm+ZPWMG0/Yi+YaMjJTQCwroliQX52T3hr26dEURmwW/
	 sUEJoWZa6YOr+jxF5/yohMhgQn2sVaeA4bagKYPXoSs8Ky8FwkCZm57McePHYSEWH2YKm
	 VT7n6rIVsr1mZtSFE0ZdJS3XBf1fg2Sr09jgj9/U9jm3PVNqIjEJ0EgzLmQFHhUJ2+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=a5V0bQZ2;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=qKhFTq3c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575659;
	bh=RIiOCwSHCn4jH2r/w5t9l0Z6mRlQin3/mr3hVLos11s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v5PJ3o4hX+gN6r+oaSgFKG28U8cH1LIo5SSdrhGOqrCPeXQBWGaEuROOOkIyVtTWa
	 NHy9Tgde7MVtjp0KtOC/kFZXJIEAbMDt50MMS9VXN0812jmR22ypYROCrLM+UW6/n+
	 js0O+DXWT6b48+NbchLKN4yWQ3A2KGrgGf+RU+fttGSPFBp+SqTnx9t53Tb6RmQLGm
	 Z2aLAQIc+bS9g5J2K6rgPkxbzCL8cR2b9cXNrph7xUu6iFBmss5mfjogOG17sxcdrX
	 vjK0gHbmnQl1MJeB+LwnliyCwrTA9/3lDAH1JiKjT95Y2JQd8BcZdZLRvPBaK3raOc
	 1ZcFdYNM50L2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61CF4608D1;
	Fri,  9 Oct 2026 19:54:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 20046184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 1D80B60844
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 83OpJSEnn6_n for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 74F5E6069C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574809;
 b=OFGyd650dQ1VMMQ44ZxWwajvE9oGWkxxxJNNoNKHvtFE2bOef1eJWIhS8L6R+gOcsy3x
 I+XSsQDv7LOz5/waevEeFtXGZ8akW5pZ7tcJ+fPEc+58KYzz93wqjQJcBpbd/EgFoG4pT
 w6lpRfdKqoTqQqjbdHhy7IyjwRv7ATHkNxD8buo5nKikeB/8qnAsh1CrM4cMG5qS7NsP3
 mkYNbIg2kNp4rtibHx5Wt22aag7kV3DyP4E97TMxrhQzeSApjU/JI9YYvj6WN4WA+JzCN
 2ulV/TMpifvgSBLz0yVfH84+evv1++HD6i0o4htoL/97XInLmWu9OaeqdYqMdLqFdyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574809;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RIiOCwSHCn4jH2r/w5t9l0Z6mRlQin3/mr3hVLos11s=;
 b=Ssd7pCed9XcpSfsmechwAiWueYxN4FWXGtYOxB11KXYVweR8byrirDeGkJaDCox/QLac
 BzsiC3/kXKHnj+otHHVQPdu30/ACxBQ7v03Zo2l9jOxpDKbp2jRen2CIJ/EyaD0h0tqr+
 V3662aiQVaWa4HPtAPaJslKjXMT4Tb1SmO5aT6P0+2P/6kuQBePS+BzFu/IvQtkr8zDBJ
 6jNj5fH1Xp1exA9Dd50H214QQHpPNswKqV+h/KNwHLkt8PPPe28ZMXaIgvi47KYAKzbPw
 GIdE4BhyoCUwQrbikTvYmnIj4GuQFNKjsvm6gRb5yA/bk0c5E/MXnOboQsIdBQIwuag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=a5V0bQZ2; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qKhFTq3c; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=a5V0bQZ2; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qKhFTq3c
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 74F5E6069C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574632; bh=RIiOCwSHCn4jH2r/w5t9l0Z
 6mRlQin3/mr3hVLos11s=; b=a5V0bQZ2VsTnpBT2oeZLfFqnDGNlXBG+I32kDxWHe73Xo8IBZ9
 vaSB1yPCXie+P4pWn5ythnTUCgTwBzn1X6bGRMbi8lr3ZWjA1FEchUcKz1QD50CCUdnDeUpwu/E
 JrDQ1qNVTPGGf2w8gA0vXl504405lpwXylCh4vyreVKWD54Jj+gr/ChuiXaVO0JgbpMLU8voP7W
 L4WaJNXvebah/f344EVkWqNKQ0bNgnwjcWdsecm2yIhfASQtea85qM+GmF+9knc0ujeP4sgREIj
 sgMwItS80GibZpgvYQ8iJ7Wq/v7LXVacJq7s9cVsRkYIV/vSCCCzaU2HFvpMLszE+Jg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574632; bh=RIiOCwSHCn4jH2r/w5t9l0Z
 6mRlQin3/mr3hVLos11s=; b=qKhFTq3cihpLvKaVth61LSZan3GgaCnjuM3GfrXIG2JYgkvNtf
 NfqWlt/BuoWqNNzmPwC4n+hPLKfmtmJ8vdCw==;
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
Subject: [PATCH 16/26] powerpc: mpc85xx: Remove MPC8536 support
Date: Fri,  9 Oct 2026 19:36:54 +0000
Message-ID: <20261009193704.13061-17-brads@mainlining.org>
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

NXP lists MPC8536 as no longer manufactured, and no board in the tree selects
ARCH_MPC8536. Remove the unused SoC configuration, SERDES setup, and
CPU identification.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig          |  20 --
 arch/powerpc/cpu/mpc85xx/Makefile         |   1 -
 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c | 250 ----------------------
 arch/powerpc/cpu/mpc8xxx/cpu.c            |   1 -
 arch/powerpc/include/asm/immap_85xx.h     |  10 -
 arch/powerpc/include/asm/processor.h      |   5 -
 doc/README.mpc85xx-sd-spi-boot            |   1 -
 7 files changed, 288 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 6ca0ccd65e7..8391ea23cdb 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -321,23 +321,6 @@ config ARCH_BSC9132
 	imply CMD_PCI
 	imply CMD_REGINFO
 
-config ARCH_MPC8536
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR2
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-	imply CMD_NAND
-	imply SATA
-	imply CMD_REGINFO
-
 config ARCH_MPC8540
 	bool
 	select FSL_LAW
@@ -777,7 +760,6 @@ config SYS_CCSRBAR_DEFAULT
 	hex "Default CCSRBAR address"
 	default	0xff700000 if	ARCH_BSC9131	|| \
 				ARCH_BSC9132	|| \
-				ARCH_MPC8536	|| \
 				ARCH_MPC8540	|| \
 				ARCH_MPC8544	|| \
 				ARCH_MPC8560	|| \
@@ -987,7 +969,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_T1042
 	default 12 if	ARCH_BSC9131	|| \
 			ARCH_BSC9132	|| \
-			ARCH_MPC8536	|| \
 			ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
@@ -1100,7 +1081,6 @@ config SYS_PPC_E500_DEBUG_TLB
 	int "Temporary TLB entry for external debugger"
 	depends on SYS_PPC_E500_USE_DEBUG_TLB
 	default 0 if ARCH_MPC8544
-	default 1 if	ARCH_MPC8536
 	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 3746d5c6fdb..43a5b5b67a4 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -51,7 +51,6 @@ obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS1) += fsl_corenet_serdes.o
 obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS2) += fsl_corenet2_serdes.o
 
 # SoC specific SERDES support
-obj-$(CONFIG_ARCH_MPC8536) += mpc8536_serdes.o
 obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c b/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
deleted file mode 100644
index bafff2083b3..00000000000
--- a/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
+++ /dev/null
@@ -1,250 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2008,2010 Freescale Semiconductor, Inc.
- *	Dave Liu <daveliu@freescale.com>
- */
-
-#include <config.h>
-#include <log.h>
-#include <asm/io.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_serdes.h>
-
-/* PORDEVSR register */
-#define GUTS_PORDEVSR_OFFS		0xc
-#define GUTS_PORDEVSR_SERDES2_IO_SEL	0x38000000
-#define GUTS_PORDEVSR_SERDES2_IO_SEL_SHIFT	27
-
-/* SerDes CR0 register */
-#define	FSL_SRDSCR0_OFFS	0x0
-#define FSL_SRDSCR0_TXEQA_MASK	0x00007000
-#define FSL_SRDSCR0_TXEQA_SGMII	0x00004000
-#define FSL_SRDSCR0_TXEQA_SATA	0x00001000
-#define FSL_SRDSCR0_TXEQE_MASK	0x00000700
-#define FSL_SRDSCR0_TXEQE_SGMII	0x00000400
-#define FSL_SRDSCR0_TXEQE_SATA	0x00000100
-
-/* SerDes CR1 register */
-#define FSL_SRDSCR1_OFFS	0x4
-#define FSL_SRDSCR1_LANEA_MASK	0x80200000
-#define FSL_SRDSCR1_LANEA_OFF	0x80200000
-#define FSL_SRDSCR1_LANEE_MASK	0x08020000
-#define FSL_SRDSCR1_LANEE_OFF	0x08020000
-
-/* SerDes CR2 register */
-#define FSL_SRDSCR2_OFFS	0x8
-#define FSL_SRDSCR2_EICA_MASK	0x00001f00
-#define FSL_SRDSCR2_EICA_SGMII	0x00000400
-#define FSL_SRDSCR2_EICA_SATA	0x00001400
-#define FSL_SRDSCR2_EICE_MASK	0x0000001f
-#define FSL_SRDSCR2_EICE_SGMII	0x00000004
-#define FSL_SRDSCR2_EICE_SATA	0x00000014
-
-/* SerDes CR3 register */
-#define FSL_SRDSCR3_OFFS	0xc
-#define FSL_SRDSCR3_LANEA_MASK	0x3f000700
-#define FSL_SRDSCR3_LANEA_SGMII	0x00000000
-#define FSL_SRDSCR3_LANEA_SATA	0x15000500
-#define FSL_SRDSCR3_LANEE_MASK	0x003f0007
-#define FSL_SRDSCR3_LANEE_SGMII	0x00000000
-#define FSL_SRDSCR3_LANEE_SATA	0x00150005
-
-#define SRDS1_MAX_LANES		8
-#define SRDS2_MAX_LANES		2
-
-static u32 serdes1_prtcl_map, serdes2_prtcl_map;
-
-static u8 serdes1_cfg_tbl[][SRDS1_MAX_LANES] = {
-	[0x2] = {PCIE1, PCIE1, PCIE1, PCIE1, NONE, NONE, NONE, NONE},
-	[0x3] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1},
-	[0x5] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2},
-	[0x7] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE3, PCIE3},
-};
-
-static u8 serdes2_cfg_tbl[][SRDS2_MAX_LANES] = {
-	[0x1] = {SATA1, SATA2},
-	[0x3] = {SATA1, NONE},
-	[0x4] = {SGMII_TSEC1, SGMII_TSEC3},
-	[0x6] = {SGMII_TSEC1, NONE},
-};
-
-int is_serdes_configured(enum srds_prtcl device)
-{
-	int ret;
-
-	if (!(serdes1_prtcl_map & (1 << NONE)))
-		fsl_serdes_init();
-
-	ret = (1 << device) & serdes1_prtcl_map;
-
-	if (ret)
-		return ret;
-
-	if (!(serdes2_prtcl_map & (1 << NONE)))
-		fsl_serdes_init();
-
-	return (1 << device) & serdes2_prtcl_map;
-}
-
-void fsl_serdes_init(void)
-{
-	void *guts = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	void *sd = (void *)CFG_SYS_MPC85xx_SERDES2_ADDR;
-	u32 pordevsr = in_be32(guts + GUTS_PORDEVSR_OFFS);
-	u32 srds1_io_sel, srds2_io_sel;
-	u32 tmp;
-	int lane;
-
-	if (serdes1_prtcl_map & (1 << NONE) &&
-	    serdes2_prtcl_map & (1 << NONE))
-		return;
-
-	srds1_io_sel = (pordevsr & MPC85xx_PORDEVSR_IO_SEL) >>
-				MPC85xx_PORDEVSR_IO_SEL_SHIFT;
-
-	/* parse the SRDS2_IO_SEL of PORDEVSR */
-	srds2_io_sel = (pordevsr & GUTS_PORDEVSR_SERDES2_IO_SEL)
-		       >> GUTS_PORDEVSR_SERDES2_IO_SEL_SHIFT;
-
-	debug("PORDEVSR[SRDS1_IO_SEL] = %x\n", srds1_io_sel);
-	debug("PORDEVSR[SRDS2_IO_SEL] = %x\n", srds2_io_sel);
-
-	switch (srds2_io_sel) {
-	case 1:	/* Lane A - SATA1, Lane E - SATA2 */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SATA;
-		tmp &= ~FSL_SRDSCR0_TXEQE_MASK;
-		tmp |= FSL_SRDSCR0_TXEQE_SATA;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEA_MASK;
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SATA;
-		tmp &= ~FSL_SRDSCR2_EICE_MASK;
-		tmp |= FSL_SRDSCR2_EICE_SATA;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SATA;
-		tmp &= ~FSL_SRDSCR3_LANEE_MASK;
-		tmp |= FSL_SRDSCR3_LANEE_SATA;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 3: /* Lane A - SATA1, Lane E - disabled */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SATA;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		tmp |= FSL_SRDSCR1_LANEE_OFF;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SATA;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SATA;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 4: /* Lane A - eTSEC1 SGMII, Lane E - eTSEC3 SGMII */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SGMII;
-		tmp &= ~FSL_SRDSCR0_TXEQE_MASK;
-		tmp |= FSL_SRDSCR0_TXEQE_SGMII;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEA_MASK;
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SGMII;
-		tmp &= ~FSL_SRDSCR2_EICE_MASK;
-		tmp |= FSL_SRDSCR2_EICE_SGMII;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SGMII;
-		tmp &= ~FSL_SRDSCR3_LANEE_MASK;
-		tmp |= FSL_SRDSCR3_LANEE_SGMII;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 6: /* Lane A - eTSEC1 SGMII, Lane E - disabled */
-		/* CR 0 */
-		tmp = in_be32(sd + FSL_SRDSCR0_OFFS);
-		tmp &= ~FSL_SRDSCR0_TXEQA_MASK;
-		tmp |= FSL_SRDSCR0_TXEQA_SGMII;
-		out_be32(sd + FSL_SRDSCR0_OFFS, tmp);
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		tmp |= FSL_SRDSCR1_LANEE_OFF;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		/* CR 2 */
-		tmp = in_be32(sd + FSL_SRDSCR2_OFFS);
-		tmp &= ~FSL_SRDSCR2_EICA_MASK;
-		tmp |= FSL_SRDSCR2_EICA_SGMII;
-		out_be32(sd + FSL_SRDSCR2_OFFS, tmp);
-		/* CR 3 */
-		tmp = in_be32(sd + FSL_SRDSCR3_OFFS);
-		tmp &= ~FSL_SRDSCR3_LANEA_MASK;
-		tmp |= FSL_SRDSCR3_LANEA_SGMII;
-		out_be32(sd + FSL_SRDSCR3_OFFS, tmp);
-		break;
-	case 7: /* Lane A - disabled, Lane E - disabled */
-		/* CR 1 */
-		tmp = in_be32(sd + FSL_SRDSCR1_OFFS);
-		tmp &= ~FSL_SRDSCR1_LANEA_MASK;
-		tmp |= FSL_SRDSCR1_LANEA_OFF;
-		tmp &= ~FSL_SRDSCR1_LANEE_MASK;
-		tmp |= FSL_SRDSCR1_LANEE_OFF;
-		out_be32(sd + FSL_SRDSCR1_OFFS, tmp);
-		break;
-	default:
-		break;
-	}
-
-	if (srds1_io_sel >= ARRAY_SIZE(serdes1_cfg_tbl)) {
-		printf("Invalid PORDEVSR[SRDS1_IO_SEL] = %d\n", srds1_io_sel);
-		return;
-	}
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes1_cfg_tbl[srds1_io_sel][lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-
-	if (srds2_io_sel >= ARRAY_SIZE(serdes2_cfg_tbl)) {
-		printf("Invalid PORDEVSR[SRDS2_IO_SEL] = %d\n", srds2_io_sel);
-		return;
-	}
-
-	for (lane = 0; lane < SRDS2_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes2_cfg_tbl[srds2_io_sel][lane];
-		serdes2_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes2_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 8c02893f63b..5ef82e84324 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -26,7 +26,6 @@ static struct cpu_type cpu_type_list[] = {
 #if defined(CONFIG_MPC85xx)
 	CPU_TYPE_ENTRY(8533, 8533, 1),
 	CPU_TYPE_ENTRY(8535, 8535, 1),
-	CPU_TYPE_ENTRY(8536, 8536, 1),
 	CPU_TYPE_ENTRY(8540, 8540, 1),
 	CPU_TYPE_ENTRY(8541, 8541, 1),
 	CPU_TYPE_ENTRY(8543, 8543, 1),
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 9f5e9a7cfcd..695c89f2237 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1765,17 +1765,12 @@ typedef struct ccsr_rcpm {
 #else
 typedef struct ccsr_gur {
 	u32	porpllsr;	/* POR PLL ratio status */
-#ifdef CONFIG_ARCH_MPC8536
-#define MPC85xx_PORPLLSR_DDR_RATIO	0x3e000000
-#define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	25
-#else
 #if defined(CONFIG_ARCH_BSC9131) || defined(CONFIG_ARCH_BSC9132)
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003f00
 #else
 #define MPC85xx_PORPLLSR_DDR_RATIO	0x00003e00
 #endif
 #define MPC85xx_PORPLLSR_DDR_RATIO_SHIFT	9
-#endif
 #define MPC85xx_PORPLLSR_QE_RATIO	0x3e000000
 #define MPC85xx_PORPLLSR_QE_RATIO_SHIFT		25
 #define MPC85xx_PORPLLSR_PLAT_RATIO	0x0000003e
@@ -1822,12 +1817,7 @@ typedef struct ccsr_gur {
 	u8	res1[8];
 	u32	gpporcr;	/* General-purpose POR configuration */
 	u8	res2[12];
-#if defined(CONFIG_ARCH_MPC8536)
-	u32	gencfgr;	/* General Configuration Register */
-#define MPC85xx_GENCFGR_SDHC_WP_INV	0x20000000
-#else
 	u32	gpiocr;		/* GPIO control */
-#endif
 	u8	res3[12];
 	u32	gpoutdr;	/* General-purpose output data */
 	u8	res4[12];
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 748cf1a3f54..e11498c6e78 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -990,11 +990,7 @@
 #define SVR_FAM(svr)	(((svr) >> 20) & 0xFFF)	/* Family field */
 #define SVR_MEM(svr)	(((svr) >> 16) & 0xF)	/* Member field */
 
-#ifdef CONFIG_ARCH_MPC8536
-#define SVR_MAJ(svr)	(((svr) >>  4) & 0x7)	/* Major revision field*/
-#else
 #define SVR_MAJ(svr)	(((svr) >>  4) & 0xF)	/* Major revision field*/
-#endif
 #define SVR_MIN(svr)	(((svr) >>  0) & 0xF)	/* Minor revision field*/
 
 /* Some parts define SVR[0:23] as the SOC version */
@@ -1018,7 +1014,6 @@
 
 #define SVR_8533	0x803400
 #define SVR_8535	0x803701
-#define SVR_8536	0x803700
 #define SVR_8540	0x803000
 #define SVR_8541	0x807200
 #define SVR_8543	0x803200
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 7a5748f5df3..c382e9bf7aa 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -66,4 +66,3 @@ P1022DS		config_ddr3_2gb_p1022ds.dat
 P1024RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
 P1020UTM	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1020MBG	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
-MPC8536DS	config_ddr2_512m_mpc8536ds_667M.dat
-- 
2.47.3

