Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C6ACA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06805815D8;
	Fri,  9 Oct 2026 19:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTEa6oD2KCUQ; Fri,  9 Oct 2026 19:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 562A181521
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575697;
	b=FgQxL8SK/j3HMxFhN8p2FrP3uy9jVV4ezBsAm9PPdzW+kEa0W5ZLIylfSsoDyh4rsmJe
	 Ta2gW40eluQw7saXHHnwnTbh2RLxKN+RTOneEgtRBqHmIDfZ9AdC4ngui0xkIU33kxcKN
	 r7OFy9E/PptadTqh0DHC3CAgRPLUOEaulS0py8Cv9j/T1GLfxgaKUd2R0stAt60WYWs8Y
	 WudqZeOwGJ5MnlJ7uEeSY6B7q26YEndo4ezmHqsqBu4XipYrngI+TZfWS+hOUcWVSpCGm
	 JJ6APB40UIG2Arwyl0R988iNjnpmsl7Dcbxg2pvi6G6sQjNeqIT001lWZi8L41E+H8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bNXS85oye3I10LyxPpHQjAh6sEPNvBaqMMT4Y2xMOIE=;
	b=aF59z0O3n7fW9AnMp0G+KjVeCPU+ArrsWOuOyngJL1eYQHkx9CwmJwyW3VQMOUo1bJv9
	 +tVbHiXvG6vt1AXhDxZv8/OG4Gi2ufZ8S1Z4EG20a6kOg99nc8l1y4TH6ZyUVwyM6d5Oz
	 U01/QtumUdyXgiZWyEKc3oRYjZUA6Z+fgwCK3IB7tLwjQ0IgNX0mIucDCFNRRR2qbOzI3
	 B2wEet/VzHfcW5NbEMyccXlPmPilE4iNez4drtAPmJ+gnz26PgV2gunPcqgm+tFzPYL27
	 KnNFG0tfMsX5Bv3Mw6p7yRlwiJOEuEoJPC6HFARBIbJzjCnpqnInPb7gog2no5oChUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=qGS4+N4w;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6nnGZvN0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575697;
	bh=bNXS85oye3I10LyxPpHQjAh6sEPNvBaqMMT4Y2xMOIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0mhwjSD3bZqalBfYWm3x7adTvVroSCOjuo83zFFrPaL0ebpPMxvpZVVflgR5mz7kV
	 EpinOm+wAmS89lfZ5kUK2MK0OgFiRKU/7uWZoFovULcZAR1SZB2RVhguCOWgWjhpXM
	 kNSzSygcYGP2yZJPTHdOWwXyZf5Ql+UWPUPzys0Dd1gzkNhK6ZftP9IcAHVFb4KQNu
	 XvIpvGg+PT5yEfJpk0VD19GVdF39u9z/TDIoLBfNr3Ou+yXwjLFO1SX6Uj4mqAFD4p
	 5feASO+epnudsvvsB8EluI9ZsZmrmefWMSAurPc+0Dt9rP/zge5ZlK3q9T+BFIxwCb
	 4d93ZRQCVz4CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 562A181521;
	Fri,  9 Oct 2026 19:54:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id C7D80184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id A54C7814C5
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id qJwPmBrM7Hup for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D0F38149A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574819;
 b=Ctw0QhCD++YBy8Itu6GTwREld8q4jvQPQDxPSRb2LHuGvbZ/UgJ6LvWyTfq6PBPghWnB
 ybfyzMsRt+rE9f1GoZy0ReIMIBut+MAmIYiehZi8P5InA+Tx50b30nLafH32FY4T59gWE
 xmIfOTD2hVsMcGjW4swWmDDRMU0Lmj1EbOnAGeNrjuG3zcpKlK5xkddzyrl44TkgaGc7b
 lRJYGSqdvfaamMt/3y553iwo2QKzlTOCnEzw2uQLRwKEhIL0//pvEA6A9we2h2G6h4crb
 Fi7H76DdvKvebSSUXcORGjHL8QFxD9fPdBtcG6DcTo7DzIviPvbWixo4rz0vk8u6EOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574819;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bNXS85oye3I10LyxPpHQjAh6sEPNvBaqMMT4Y2xMOIE=;
 b=py1wKz6HDKUHy9yvIR9TOj0NGxmJzJpXogYTEI2lbmVLea7Rrm4BlqW/R4b6Hb4qKCmG
 KNZNFh896wTMnlVBBJ/nmPKiw+9Am24Fmr7K74/eN8s8AxTmtQP0OWXiRIqbL9YDToTJm
 4hTJYQuqHbUonWFrz1dv/lAVfZrQjXLU5J85CJQyqCjF8UAwhmclbSHHXw1vLTE87qsxI
 xOVSzpn23wko8TSZvoy1KI5NJndXZAI4XsnN8SQZBjqmUk2+h2/0iBxLP/Jy6H382iD21
 a7a0F8IgD44A0b4HmWhvc6SM6YxfqsFuvH9PEl4ls/NUoZGf6hssn4OeWev6lppITnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=qGS4+N4w; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=6nnGZvN0; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=qGS4+N4w; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=6nnGZvN0
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 2D0F38149A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574631; bh=bNXS85oye3I10LyxPpHQjAh
 6sEPNvBaqMMT4Y2xMOIE=; b=qGS4+N4weZQAGnQQI/Z8jhzys61AY4yMjH9nzI7u+jaxrpN4+5
 6FFGcpS1zHqdmy3IxlDHShmcsUFwNj3Iu9F3TBLlU5BIAvn8GTSytNj0ePMZMjlRp8IZOx+/eiB
 Kp3VvOJoY5gYAQm8KpfcTsU9D9Ack4BwBc4GlrGDNIhoOswF/GmE8QMp4/xmhzbp/NliqrZVr8A
 NF0cI+vZaBvdqceIxMbnrdGOYkEfS4ktyG0cUYBdoQOiBpJlZ8sXgCwyjjb9yIRRiQgnAff5/ef
 hqy1Hp9K1jBszpQC0edd/SRIM0zptyHxdqOfSEDOZTHvwQFd4Inddcr7KqmCia11hrQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574631; bh=bNXS85oye3I10LyxPpHQjAh
 6sEPNvBaqMMT4Y2xMOIE=; b=6nnGZvN0ebb3g84u8UnXnbAheC25raTTZu56o7PogSJqNWthYt
 U7TJ1GcWkg98pTKLH8XpSj0ycGNiDRX0IWCg==;
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
Subject: [PATCH 14/26] powerpc: mpc85xx: Remove P1023 support
Date: Fri,  9 Oct 2026 19:36:52 +0000
Message-ID: <20261009193704.13061-15-brads@mainlining.org>
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

NXP lists the P1023/P1017 family as no longer manufactured. No board in the tree selects ARCH_P1023, so remove the unused SoC, FMan, and SERDES
support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig          | 19 +-----
 arch/powerpc/cpu/mpc85xx/Makefile         |  1 -
 arch/powerpc/cpu/mpc85xx/p1023_serdes.c   | 59 -------------------
 arch/powerpc/cpu/mpc8xxx/cpu.c            |  1 -
 arch/powerpc/include/asm/config_mpc85xx.h |  7 ---
 arch/powerpc/include/asm/immap_85xx.h     | 15 -----
 arch/powerpc/include/asm/processor.h      |  1 -
 drivers/net/Kconfig                       |  1 -
 drivers/net/fm/Makefile                   |  1 -
 drivers/net/fm/fm.h                       |  4 --
 drivers/net/fm/p1023.c                    | 72 -----------------------
 11 files changed, 1 insertion(+), 180 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p1023_serdes.c
 delete mode 100644 drivers/net/fm/p1023.c

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index ab66ffadebd..f4e34adbaea 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -443,20 +443,6 @@ config ARCH_P1021
 	imply CMD_REGINFO
 	imply SATA_SIL
 
-config ARCH_P1023
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_I2C_A004447
-	select FSL_PCIE_RESET
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v22
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select FSL_ELBC
-
 config ARCH_P1024
 	bool
 	select FSL_LAW
@@ -794,7 +780,6 @@ config MAX_CPUS
 		     ARCH_BSC9132 || \
 		     ARCH_P1020 || \
 		     ARCH_P1021 || \
-		     ARCH_P1023 || \
 		     ARCH_P1024 || \
 		     ARCH_P1025 || \
 		     ARCH_P2020 || \
@@ -821,7 +806,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_P1024	|| \
 				ARCH_P1025	|| \
 				ARCH_P2020
-	default 0xff600000 if	ARCH_P1023
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
 				ARCH_P2041	|| \
@@ -957,7 +941,7 @@ config SYS_FSL_A004447_SVR_REV
 	hex
 	depends on SYS_FSL_ERRATUM_I2C_A004447
 	default 0x10 if ARCH_P1010
-	default 0x11 if ARCH_P1023 || ARCH_P2041 || ARCH_BSC9132
+	default 0x11 if ARCH_P2041 || ARCH_BSC9132
 
 config SYS_FSL_ERRATUM_IFC_A002769
 	bool
@@ -1027,7 +1011,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1010	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
-			ARCH_P1023	|| \
 			ARCH_P1024	|| \
 			ARCH_P1025	|| \
 			ARCH_P2020
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index f78131dd61a..c40558880ea 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
-obj-$(CONFIG_ARCH_P1023)	+= p1023_serdes.o
 obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/p1023_serdes.c b/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
deleted file mode 100644
index 6d306d99c32..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
- * Author: Roy Zang <tie-fei.zang@freescale.com>
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
-static const u8 serdes1_cfg_tbl[][SRDS1_MAX_LANES] = {
-	[0x00] = {PCIE1, PCIE2, NONE, NONE},
-	[0x01] = {PCIE1, PCIE2, PCIE3, NONE},
-	[0x02] = {PCIE1, PCIE2, PCIE3, SGMII_FM1_DTSEC2},
-	[0x03] = {PCIE1, PCIE2, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2},
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
-	return ret;
-}
-
-void fsl_serdes_init(void)
-{
-	ccsr_gur_t *gur = (void *)CFG_SYS_MPC85xx_GUTS_ADDR;
-	u32 pordevsr = in_be32(&gur->pordevsr);
-	u32 srds_cfg = (pordevsr & MPC85xx_PORDEVSR_IO_SEL) >>
-				MPC85xx_PORDEVSR_IO_SEL_SHIFT;
-	int lane;
-
-	if (serdes1_prtcl_map & (1 << NONE))
-		return;
-
-	debug("PORDEVSR[IO_SEL_SRDS] = %x\n", srds_cfg);
-
-	if (srds_cfg >= ARRAY_SIZE(serdes1_cfg_tbl)) {
-		printf("Invalid PORDEVSR[IO_SEL_SRDS] = %d\n", srds_cfg);
-		return;
-	}
-	for (lane = 0; lane < SRDS1_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl = serdes1_cfg_tbl[srds_cfg][lane];
-		serdes1_prtcl_map |= (1 << lane_prtcl);
-	}
-
-	/* Set the first bit to indicate serdes has been initialized */
-	serdes1_prtcl_map |= (1 << NONE);
-}
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 641d2a199f8..52817a4fc2a 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -48,7 +48,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P1020, P1020, 2),
 	CPU_TYPE_ENTRY(P1021, P1021, 2),
 	CPU_TYPE_ENTRY(P1022, P1022, 2),
-	CPU_TYPE_ENTRY(P1023, P1023, 2),
 	CPU_TYPE_ENTRY(P1024, P1024, 2),
 	CPU_TYPE_ENTRY(P1025, P1025, 2),
 	CPU_TYPE_ENTRY(P2010, P2010, 1),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index f115dcce76a..67804ada5ed 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -15,13 +15,6 @@
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
 
-#elif defined(CONFIG_ARCH_P1023)
-#define CFG_SYS_NUM_FMAN		1
-#define CFG_SYS_NUM_FM1_DTSEC	2
-#define CFG_SYS_QMAN_NUM_PORTALS	3
-#define CFG_SYS_BMAN_NUM_PORTALS	3
-#define CFG_SYS_FM_MURAM_SIZE	0x10000
-
 /* P1025 is lower end variant of P1021 */
 #elif defined(CONFIG_ARCH_P1025)
 #define QE_MURAM_SIZE			0x6000UL
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 489fcd43351..39ddfcfe308 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1790,22 +1790,12 @@ typedef struct ccsr_gur {
 #define PORBMSR_ROMLOC_NOR	0xf
 	u32	porimpscr;	/* POR I/O impedance status & control */
 	u32	pordevsr;	/* POR I/O device status regsiter */
-#if defined(CONFIG_ARCH_P1023)
-#define MPC85xx_PORDEVSR_SGMII1_DIS	0x10000000
-#define MPC85xx_PORDEVSR_SGMII2_DIS	0x08000000
-#define MPC85xx_PORDEVSR_TSEC1_PRTC	0x02000000
-#else
 #define MPC85xx_PORDEVSR_SGMII1_DIS	0x20000000
 #define MPC85xx_PORDEVSR_SGMII2_DIS	0x10000000
-#endif
 #define MPC85xx_PORDEVSR_SGMII3_DIS	0x08000000
 #define MPC85xx_PORDEVSR_SGMII4_DIS	0x04000000
 #define MPC85xx_PORDEVSR_SRDS2_IO_SEL	0x38000000
 #define MPC85xx_PORDEVSR_PCI1		0x00800000
-#if defined(CONFIG_ARCH_P1023)
-#define MPC85xx_PORDEVSR_IO_SEL		0x00600000
-#define MPC85xx_PORDEVSR_IO_SEL_SHIFT	21
-#else
 #if defined(CONFIG_ARCH_P1010)
 #define MPC85xx_PORDEVSR_IO_SEL		0x00600000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	21
@@ -1816,7 +1806,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PORDEVSR_IO_SEL		0x00780000
 #define MPC85xx_PORDEVSR_IO_SEL_SHIFT	19
 #endif /* if defined(CONFIG_ARCH_P1010) */
-#endif
 #define MPC85xx_PORDEVSR_PCI2_ARB	0x00040000
 #define MPC85xx_PORDEVSR_PCI1_ARB	0x00020000
 #define MPC85xx_PORDEVSR_PCI1_PCI32	0x00010000
@@ -1891,9 +1880,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR_CAN2_TDM			0x00000002
 #define MPC85xx_PMUXCR_CAN2_RES			0x00000003
 #endif
-#if defined(CONFIG_ARCH_P1023)
-#define MPC85xx_PMUXCR_TSEC1_1		0x10000000
-#else
 #define MPC85xx_PMUXCR_SD_DATA		0x80000000
 #define MPC85xx_PMUXCR_SDHC_CD		0x40000000
 #define MPC85xx_PMUXCR_SDHC_WP		0x20000000
@@ -1912,7 +1898,6 @@ typedef struct ccsr_gur {
 #define MPC85xx_PMUXCR_QE10		0x00000020
 #define MPC85xx_PMUXCR_QE11		0x00000010
 #define MPC85xx_PMUXCR_QE12		0x00000008
-#endif
 #if defined(CONFIG_ARCH_BSC9131)
 #define MPC85xx_PMUXCR_TSEC2_DMA_GPIO_IRQ	0x40000000
 #define MPC85xx_PMUXCR_TSEC2_USB		0xC0000000
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 36d8660cddc..2612f182a4c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1040,7 +1040,6 @@
 #define SVR_P1020	0x80E400
 #define SVR_P1021	0x80E401
 #define SVR_P1022	0x80E600
-#define SVR_P1023	0x80F600
 #define SVR_P1024	0x80E402
 #define SVR_P1025	0x80E403
 #define SVR_P2010	0x80E300
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b4224c24040..ac201ba45c2 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -962,7 +962,6 @@ config SYS_DPAA_QBMAN
 	depends on ARM || PPC
 	default y if ARCH_B4860 || \
 		     ARCH_B4420 || \
-		     ARCH_P1023 || \
 		     ARCH_P2041 || \
 		     ARCH_T1024 || \
 		     ARCH_T1040 || \
diff --git a/drivers/net/fm/Makefile b/drivers/net/fm/Makefile
index 6ec673feec4..847c1cbe340 100644
--- a/drivers/net/fm/Makefile
+++ b/drivers/net/fm/Makefile
@@ -13,7 +13,6 @@ obj-y += tgec_phy.o
 obj-$(CONFIG_SYS_FMAN_V3) += memac.o
 
 # SoC specific SERDES support
-obj-$(CONFIG_ARCH_P1023)	+= p1023.o
 # The P204x and P5020 are the same
 obj-$(CONFIG_ARCH_P2041) += p5020.o
 obj-$(CONFIG_ARCH_T1040) += t1040.o
diff --git a/drivers/net/fm/fm.h b/drivers/net/fm/fm.h
index 5c45ad56d0a..cafdaf89014 100644
--- a/drivers/net/fm/fm.h
+++ b/drivers/net/fm/fm.h
@@ -96,11 +96,7 @@ struct fm_port_global_pram {
 #define PRAM_MODE_GLOBAL	0x20000000
 #define PRAM_MODE_GRACEFUL_STOP	0x00800000
 
-#if defined(CONFIG_ARCH_P1023)
-#define FM_FREE_POOL_SIZE	0x2000 /* 8K bytes */
-#else
 #define FM_FREE_POOL_SIZE	0x20000 /* 128K bytes */
-#endif
 #define FM_FREE_POOL_ALIGN	256
 
 void *fm_muram_alloc(int fm_idx, size_t size, ulong align);
diff --git a/drivers/net/fm/p1023.c b/drivers/net/fm/p1023.c
deleted file mode 100644
index 362bc9f30a1..00000000000
--- a/drivers/net/fm/p1023.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2011 Freescale Semiconductor, Inc.
- */
-#include <config.h>
-#include <phy.h>
-#include <fm_eth.h>
-#include <asm/io.h>
-#include <asm/immap_85xx.h>
-#include <asm/fsl_serdes.h>
-
-static u32 port_to_devdisr[] = {
-	[FM1_DTSEC1] = MPC85xx_DEVDISR_TSEC1,
-	[FM1_DTSEC2] = MPC85xx_DEVDISR_TSEC2,
-};
-
-static int is_device_disabled(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 devdisr = in_be32(&gur->devdisr);
-
-	return port_to_devdisr[port] & devdisr;
-}
-
-void fman_disable_port(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-
-	/* don't allow disabling of DTSEC1 as its needed for MDIO */
-	if (port == FM1_DTSEC1)
-		return;
-
-	setbits_be32(&gur->devdisr, port_to_devdisr[port]);
-}
-
-void fman_enable_port(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-
-	clrbits_be32(&gur->devdisr, port_to_devdisr[port]);
-}
-
-phy_interface_t fman_port_enet_if(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 pordevsr = in_be32(&gur->pordevsr);
-
-	if (is_device_disabled(port))
-		return PHY_INTERFACE_MODE_NA;
-
-	/* DTSEC1 can be SGMII, RGMII or RMII */
-	if (port == FM1_DTSEC1) {
-		if (is_serdes_configured(SGMII_FM1_DTSEC1))
-			return PHY_INTERFACE_MODE_SGMII;
-		if (pordevsr & MPC85xx_PORDEVSR_SGMII1_DIS) {
-			if (pordevsr & MPC85xx_PORDEVSR_TSEC1_PRTC)
-				return PHY_INTERFACE_MODE_RGMII;
-			else
-				return PHY_INTERFACE_MODE_RMII;
-		}
-	}
-
-	/* DTSEC2 only supports SGMII or RGMII */
-	if (port == FM1_DTSEC2) {
-		if (is_serdes_configured(SGMII_FM1_DTSEC2))
-			return PHY_INTERFACE_MODE_SGMII;
-		if (pordevsr & MPC85xx_PORDEVSR_SGMII2_DIS)
-			return PHY_INTERFACE_MODE_RGMII;
-	}
-
-	return PHY_INTERFACE_MODE_NA;
-}
-- 
2.47.3

