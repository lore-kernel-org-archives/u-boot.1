Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2294CA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61D5C40964;
	Fri,  9 Oct 2026 22:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q3llNaRBgmqQ; Fri,  9 Oct 2026 22:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D1DDC409AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583965;
	b=WOsGXxlSHR/caTmHEPgQYkSBRMVBwX3aTkRhxg5XrfmKdoKhFU3h5nV2O+zVMxDeafA8
	 Stf6oYBp2rv9tQrw9WIMRnEOystWOiZTSgmagvqyhkEulc1tgWYbbWcKPOZeFFtSuYhfG
	 Y3zuJ/mlQzMlvIuZk5U00aSsb8FMyhP+969tYnuJN6N8qsidw/jm0c4NwzfNledwwGL+G
	 onKpEMSWUxSSgCLLbfIYV6+XExdDt5Ae8v6gdQ3fXcJ62MCQDjUefl6tZ1SJTkOVivN08
	 Wai86zO+P/xQekvMCN9pY6sS81T93Yl5K2hOGUO5hMe8MvO5EXr577UfDoqqA5bYy4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cFxSTnyU1144D0aMNIYVhLqyVGTnyp7WgfIHRm5P9hw=;
	b=tGE9qwlEIY0VvyZoUmwM1j5G8ghfkA3+DvAYIGmM9IQ11asP5Vj9bcSno5J91MYStLVe
	 9BssUT80oM6ym4ynlPr/mJhSnCXrdcrGVVavjmt90fh/2n83JmMXkjAPgFZSAZNebsMVg
	 pufRBEdJd+v00extJJeOAr63KHTK1qDbX4Rr3h4H68uRty2bsec+BuqjtvMSORf4M/kOM
	 3OIg86YFCg4ZZd+bikAeNirSXwBCpJAgEGLDug2eaJDvnCRVJoclx/NHPLI0f2OX1wtIH
	 HDMpwBlLftsQzmU/CUWcUQhiqvxW8HV0c5eo3qR0YaT0CuNlfbHLlvJXHoSTuDRTZWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=eYPaANwI;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b="3/NlRUmO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583965;
	bh=cFxSTnyU1144D0aMNIYVhLqyVGTnyp7WgfIHRm5P9hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ynsE3oOsPoYwfrVFe3GpAhfcQD5t94zjUAecQx3klUdzL34vuKlRL/NqWRk0fJfc0
	 ZOTm1UQGa30zFSW/36Kac3Ef1x0mddr50JdR95VK7UWj2Cha56DroDGG82PQd8VT9w
	 KtGCoDmXs3kSLKF2sH0M1M0qtoOdzmhDLJ7l9iIuEKN9bcZStUoM7a//mSub7r5XvS
	 Ml2ZxBLqw2qzazpFbKKPwZkRZ49F0nJnRMCz5tDFFbgCfFox6/XyU2GVNtf3SSsel6
	 Xz/Lu4OG4H7kJvnxoVLSmUZtsS/IaoKRDXWrzGyWFcTSybRZKjHENAPbzA+P02xkom
	 e/7kF0ZQztDNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1DDC409AC;
	Fri,  9 Oct 2026 22:12:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 6C61AB8C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 51FE6408F8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id fQRr17fTOwTF for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F45A408BC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583833;
 b=B3GCp/onH3p4vRyyg3t72KAhZeESrkci748xF6OrkGwIGHcjeGMLxWx/RDrpwl1vlo98
 j0lFOEZSYv+TSj5eTY5cMQJWrUlzNpf89hy0OvrRcv6rr4y85Kg8zyPHteMJ+v2Ula4/Y
 q8CvjeCxOyFTirbidz5U22394DepTiT/l3S6pqRYfG83O2rx4ta/+i9VlQEb+NDPfQJgY
 HGW7sEFpkmRi+zpuPnI2JJE32+FIKulHtW1OMYphAKKOoHoN2nP46mQvGE+r8Te2GNasM
 f9PE6jPESbse2aaXnpnKA9l4RYVv3XO3vxMdbTDLkumj6JjFkG+vNxtujyYKaHFbEfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583833;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cFxSTnyU1144D0aMNIYVhLqyVGTnyp7WgfIHRm5P9hw=;
 b=tcWNC64mC81zf+hObkwu4ocwD9lmGC4kf6tcKHhqB5ZxKH8uREIKv9N9aZ2jMnbmmCQa
 u1Wq/d2SwXLFce4vyYDtlNT3Qsyq2RBzGxMezB2fLf085Zp7p7uNCadHTtJPMmKCGtSTI
 hLEQkOyJWxnqiNI0YVRVlx1ZO3EcVbL45mshBTIguBMqVOw/mjb5MjI3i7fm7Wcs3JOnU
 866oOdxuHtZ0okRpJpXXBt63XN3JED3CAacXHDbBIklnIp9Us4G3T/L3Thzl3XhXbw7oE
 sP4nh9htXgXxF9GVbWQ9QQDy9oqfuE7aHRw2bzTXe1ViiNfqdbkMR1m4eOx4MXLsgfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=eYPaANwI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="3/NlRUmO"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=eYPaANwI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=3/NlRUmO
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 1F45A408BC
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583821; bh=cFxSTnyU1144D0aMNIYVhLq
 yVGTnyp7WgfIHRm5P9hw=; b=eYPaANwIdk1QaYTPqDkXH1GWiTSVgcer7boWBb/u3ll+HjKaV1
 whB65bxv5XB0dtaGUc3hKGtcVDqXzmhR71ins7ePMr8fPpitKmCzeWwCCL4sUCYBUhZYuOoIZGw
 mm+b00JwxYyva756wkkriliudok6slFIaQiHKrTdCGn8M7yEPbZ27vSR0warwc9skSFWRQjtYmR
 1bFmiy9X3zDEzwH+y6N52HJJ64Ddr9bCadnLK9PED7jHhTQ5gEA53mchn2yydCrXaSulmYkZ6ns
 xfR/fTLjOTdZSlHxqDIMHBkrA+2VrftyPZoONJtosA1iJSLsCZmpeGNK3wRWobS401w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583821; bh=cFxSTnyU1144D0aMNIYVhLq
 yVGTnyp7WgfIHRm5P9hw=; b=3/NlRUmOgg90HZjKtVUNn6oD+TNWLyTIoNs6ULxw4POnVXfDbp
 7UREqNfbphqMZX0q/ZjA5Iw4GT21frOljhDw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 09/26] powerpc: mpc85xx: Remove P4080 support
Date: Fri,  9 Oct 2026 22:09:59 +0000
Message-ID: <20261009221017.20385-10-brads@mainlining.org>
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

The P4080DS was the last user in the tree of ARCH_P4080. With that
board removed, nothing selects the option now.

Drop its unmaintained FM and SERDES support, errata workarounds,
and remaining platform hooks.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                              |   2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig              |  73 +--
 arch/powerpc/cpu/mpc85xx/Makefile             |   2 -
 arch/powerpc/cpu/mpc85xx/cmd_errata.c         |  39 +-
 arch/powerpc/cpu/mpc85xx/cpu_init.c           |  19 +-
 arch/powerpc/cpu/mpc85xx/fdt.c                |  22 -
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c | 600 ------------------
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h |   4 -
 arch/powerpc/cpu/mpc85xx/p4080_ids.c          | 112 ----
 arch/powerpc/cpu/mpc85xx/p4080_serdes.c       |  80 ---
 arch/powerpc/cpu/mpc85xx/release.S            |  23 +-
 arch/powerpc/cpu/mpc8xxx/cpu.c                |   1 -
 arch/powerpc/include/asm/config_mpc85xx.h     |  13 -
 arch/powerpc/include/asm/fsl_serdes.h         |   3 -
 arch/powerpc/include/asm/immap_85xx.h         |  16 -
 arch/powerpc/include/asm/processor.h          |   1 -
 doc/README.pblimage                           |   4 +-
 drivers/ddr/fsl/Kconfig                       |   1 -
 drivers/net/Kconfig                           |   1 -
 drivers/net/fm/Makefile                       |   1 -
 drivers/net/fm/p4080.c                        |  98 ---
 drivers/pci/pcie_fsl.c                        |  23 -
 drivers/usb/common/fsl-errata.c               |   4 -
 drivers/usb/host/Kconfig                      |   2 +-
 24 files changed, 13 insertions(+), 1131 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p4080_serdes.c
 delete mode 100644 drivers/net/fm/p4080.c

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index ff645aea0d3..6b1ad1795fa 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -5,7 +5,7 @@ config FSL_TRUST_ARCH_v1
 
 config NXP_ESBC
 	bool "NXP ESBC (secure boot) functionality"
-	select FSL_TRUST_ARCH_v1 if ARCH_P4080 || ARCH_P5040 || ARCH_P2041
+	select FSL_TRUST_ARCH_v1 if ARCH_P5040 || ARCH_P2041
 	help
 	  Enable Freescale Secure Boot feature. Normally selected by defconfig.
 	  If unsure, do not change.
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index ab80a1ab317..252666cab5f 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -584,49 +584,6 @@ config ARCH_P2041
 	select FSL_ELBC
 	imply CMD_NAND
 
-config ARCH_P4080
-	bool
-	select BACKSIDE_L2_CACHE
-	select E500MC
-	select FSL_CORENET
-	select FSL_LAW
-	select SYS_CACHE_SHIFT_6
-	select SYS_FSL_DDR_VER_44
-	select SYS_FSL_ERRATUM_A004510
-	select SYS_FSL_ERRATUM_A004580
-	select SYS_FSL_ERRATUM_A004849
-	select SYS_FSL_ERRATUM_A005812
-	select SYS_FSL_ERRATUM_A007075
-	select SYS_FSL_ERRATUM_CPC_A002
-	select SYS_FSL_ERRATUM_CPC_A003
-	select SYS_FSL_ERRATUM_CPU_A003999
-	select SYS_FSL_ERRATUM_DDR_A003
-	select SYS_FSL_ERRATUM_DDR_A003474
-	select SYS_FSL_ERRATUM_ELBC_A001
-	select SYS_FSL_ERRATUM_ESDHC111
-	select SYS_FSL_ERRATUM_ESDHC13
-	select SYS_FSL_ERRATUM_ESDHC135
-	select SYS_FSL_ERRATUM_I2C_A004447
-	select SYS_FSL_ERRATUM_NMG_CPU_A011
-	select SYS_FSL_ERRATUM_SRIO_A004034
-	select SYS_FSL_PCIE_COMPAT_P4080_PCIE
-	select SYS_P4080_ERRATUM_CPU22
-	select SYS_P4080_ERRATUM_PCIE_A003
-	select SYS_P4080_ERRATUM_SERDES8
-	select SYS_P4080_ERRATUM_SERDES9
-	select SYS_P4080_ERRATUM_SERDES_A001
-	select SYS_P4080_ERRATUM_SERDES_A005
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_QORIQ_CHASSIS1
-	select SYS_FSL_RMU
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select FSL_ELBC
-	imply SATA
-	imply CMD_REGINFO
-	imply SATA_SIL
-
 config ARCH_P5040
 	bool
 	select BACKSIDE_L2_CACHE
@@ -891,7 +848,6 @@ config HETROGENOUS_CLUSTERS
 config MAX_CPUS
 	int "Maximum number of CPUs permitted for MPC85xx"
 	default 12 if ARCH_T4240
-	default 8 if ARCH_P4080
 	default 4 if ARCH_B4860 || \
 		     ARCH_P2041 || \
 		     ARCH_P5040 || \
@@ -935,7 +891,6 @@ config SYS_CCSRBAR_DEFAULT
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
 				ARCH_P2041	|| \
-				ARCH_P4080	|| \
 				ARCH_P5040	|| \
 				ARCH_T1024	|| \
 				ARCH_T1040	|| \
@@ -994,7 +949,6 @@ config SYS_FSL_ERRATUM_A004510
 config SYS_FSL_ERRATUM_A004510_SVR_REV
 	hex
 	depends on SYS_FSL_ERRATUM_A004510
-	default 0x20 if ARCH_P4080
 	default 0x10
 
 config SYS_FSL_ERRATUM_A004510_SVR_REV2
@@ -1074,7 +1028,6 @@ config SYS_FSL_A004447_SVR_REV
 	depends on SYS_FSL_ERRATUM_I2C_A004447
 	default 0x10 if ARCH_P1010
 	default 0x11 if ARCH_P1023 || ARCH_P2041 || ARCH_BSC9132
-	default 0x20 if ARCH_P4080
 
 config SYS_FSL_ERRATUM_IFC_A002769
 	bool
@@ -1106,24 +1059,6 @@ config SYS_FSL_ERRATUM_SRIO_A004034
 config SYS_FSL_ERRATUM_USB14
 	bool
 
-config SYS_P4080_ERRATUM_CPU22
-	bool
-
-config SYS_P4080_ERRATUM_PCIE_A003
-	bool
-
-config SYS_P4080_ERRATUM_SERDES8
-	bool
-
-config SYS_P4080_ERRATUM_SERDES9
-	bool
-
-config SYS_P4080_ERRATUM_SERDES_A001
-	bool
-
-config SYS_P4080_ERRATUM_SERDES_A005
-	bool
-
 config FSL_PCIE_DISABLE_ASPM
 	bool
 
@@ -1151,7 +1086,6 @@ config SYS_FSL_NUM_LAWS
 	default 32 if	ARCH_B4420	|| \
 			ARCH_B4860	|| \
 			ARCH_P2041	|| \
-			ARCH_P4080	|| \
 			ARCH_P5040	|| \
 			ARCH_T2080	|| \
 			ARCH_T4240
@@ -1315,7 +1249,6 @@ config SYS_FSL_LBC_CLK_DIV
 		ARCH_MPC8560
 
 	default 2 if	ARCH_P2041	|| \
-			ARCH_P4080	|| \
 			ARCH_P5040
 	default 1
 
@@ -1346,9 +1279,6 @@ config SYS_FSL_CPC
 config SYS_CACHE_STASHING
 	bool "Enable cache stashing"
 
-config SYS_FSL_PCIE_COMPAT_P4080_PCIE
-	bool
-
 config SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v22
 	bool
 
@@ -1361,7 +1291,6 @@ config SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v30
 config SYS_FSL_PCIE_COMPAT
 	string
 	depends on FSL_CORENET
-	default "fsl,p4080-pcie" if SYS_FSL_PCIE_COMPAT_P4080_PCIE
 	default "fsl,qoriq-pcie-v2.2" if SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v22
 	default "fsl,qoriq-pcie-v2.4" if SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v24
 	default "fsl,qoriq-pcie-v3.0" if SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v30
@@ -1378,7 +1307,7 @@ config SYS_FSL_SRIO_LIODN
 config SYS_FSL_TBCLK_DIV
 	int
 	default 32 if ARCH_P2041
-	default 16 if ARCH_P4080 || ARCH_P5040 || ARCH_T4240 || ARCH_B4860 || \
+	default 16 if ARCH_P5040 || ARCH_T4240 || ARCH_B4860 || \
 			ARCH_B4420 || ARCH_T1040 || ARCH_T1042 || \
 			ARCH_T1024 || ARCH_T2080
 	default 8
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 664e566b06e..a3622d60b16 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_SYS_DPAA_QBMAN) += portals.o
 
 # various SoC specific assignments
 obj-$(CONFIG_ARCH_P2041) += p2041_ids.o
-obj-$(CONFIG_ARCH_P4080) += p4080_ids.o
 obj-$(CONFIG_ARCH_P5040) += p5040_ids.o
 obj-$(CONFIG_ARCH_T4240) += t4240_ids.o
 obj-$(CONFIG_ARCH_B4420) += b4860_ids.o
@@ -65,7 +64,6 @@ obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
 obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
-obj-$(CONFIG_ARCH_P4080) += p4080_serdes.o
 obj-$(CONFIG_ARCH_P5040) += p5040_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
 obj-$(CONFIG_ARCH_B4420) += b4860_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/cmd_errata.c b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
index 52de04323c9..73601a884c7 100644
--- a/arch/powerpc/cpu/mpc85xx/cmd_errata.c
+++ b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
@@ -20,7 +20,7 @@
  * Array offsets[] contains a list of offsets within DCSR.  According to the
  * erratum document, the value at each offset should be 2.
  */
-static void check_erratum_a4849(uint32_t svr)
+static void check_erratum_a4849(void)
 {
 	void __iomem *dcsr = (void *)CFG_SYS_DCSRBAR + 0xb0000;
 	unsigned int i;
@@ -29,11 +29,6 @@ static void check_erratum_a4849(uint32_t svr)
 	static const uint8_t offsets[] = {
 		0x50, 0x54, 0x58, 0x90, 0x94, 0x98
 	};
-#endif
-#ifdef CONFIG_ARCH_P4080
-	static const uint8_t offsets[] = {
-		0x60, 0x64, 0x68, 0x6c, 0xa0, 0xa4, 0xa8, 0xac
-	};
 #endif
 	uint32_t x108; /* The value that should be at offset 0x108 */
 
@@ -48,17 +43,6 @@ static void check_erratum_a4849(uint32_t svr)
 	x108 = 0x12;
 #endif
 
-#ifdef CONFIG_ARCH_P4080
-	/*
-	 * For P4080, the erratum document says that the value at offset 0x108
-	 * should be 0x12 on rev2, or 0x1c on rev3.
-	 */
-	if (SVR_MAJ(svr) == 2)
-		x108 = 0x12;
-	if (SVR_MAJ(svr) == 3)
-		x108 = 0x1c;
-#endif
-
 	if (in_be32(dcsr + 0x108) != x108) {
 		printf("Work-around for Erratum A004849 is not enabled\n");
 		return;
@@ -146,23 +130,9 @@ static int do_errata(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 #endif
 
-#if defined(CONFIG_SYS_P4080_ERRATUM_SERDES8)
-	puts("Work-around for Erratum SERDES8 enabled\n");
-#endif
-#if defined(CONFIG_SYS_P4080_ERRATUM_SERDES9)
-	puts("Work-around for Erratum SERDES9 enabled\n");
-#endif
-#if defined(CONFIG_SYS_P4080_ERRATUM_SERDES_A005)
-	puts("Work-around for Erratum SERDES-A005 enabled\n");
-#endif
-#if defined(CONFIG_SYS_P4080_ERRATUM_CPU22)
-	if (SVR_MAJ(svr) < 3)
-		puts("Work-around for Erratum CPU22 enabled\n");
-#endif
 #ifdef CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011
 	/*
-	 * NMG_CPU_A011 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * also applies to P2041 rev 1.0, 1.1
+	 * NMG_CPU_A011 applies to P2041 rev 1.0, 1.1, fixed in 2.0.
 	 * The SVR has been checked by cpu_init_r().
 	 */
 	if (enable_cpu_a011_workaround)
@@ -258,15 +228,12 @@ static int do_errata(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 #ifdef CONFIG_SYS_FSL_ERRATUM_A004849
 	/* This work-around is implemented in PBI, so just check for it */
-	check_erratum_a4849(svr);
+	check_erratum_a4849();
 #endif
 #ifdef CONFIG_SYS_FSL_ERRATUM_A004580
 	/* This work-around is implemented in PBI, so just check for it */
 	check_erratum_a4580(svr);
 #endif
-#ifdef CONFIG_SYS_P4080_ERRATUM_PCIE_A003
-	puts("Work-around for Erratum PCIe-A003 enabled\n");
-#endif
 #ifdef CONFIG_SYS_FSL_ERRATUM_USB14
 	puts("Work-around for Erratum USB14 enabled\n");
 #endif
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 6d150cb8ba2..e7e9b3dbd1c 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -653,22 +653,14 @@ int cpu_init_r(void)
 #ifdef CONFIG_SYS_FSL_ERRATUM_SEC_A003571
 	ccsr_sec_t __iomem *sec = (void *)CFG_SYS_FSL_SEC_ADDR;
 #endif
-#if defined(CONFIG_SYS_P4080_ERRATUM_CPU22) || \
-	defined(CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011)
+#ifdef CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011
 	/*
-	 * CPU22 and NMG_CPU_A011 share the same workaround.
-	 * CPU22 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * NMG_CPU_A011 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * also applies to P2041 rev 1.0, 1.1, fixed in 2.0.
-	 * NMG_CPU_A011 is activated by default and can
-	 * be disabled by hwconfig with syntax:
+	 * NMG_CPU_A011 applies to P2041 rev 1.0 and 1.1, fixed in 2.0.
+	 * It is enabled by default and can be disabled with:
 	 *
 	 * fsl_cpu_a011:disable
 	 */
 	extern int enable_cpu_a011_workaround;
-#ifdef CONFIG_SYS_P4080_ERRATUM_CPU22
-	enable_cpu_a011_workaround = (SVR_MAJ(svr) < 3);
-#else
 	char buffer[HWCONFIG_BUFFER_SIZE];
 	char *buf = NULL;
 	int n, res;
@@ -685,11 +677,8 @@ int cpu_init_r(void)
 			printf("fsl_cpu_a011 was not found. hwconfig variable "
 				"may be too long\n");
 		}
-		enable_cpu_a011_workaround =
-			(SVR_SOC_VER(svr) == SVR_P4080 && SVR_MAJ(svr) < 3) ||
-			(SVR_SOC_VER(svr) != SVR_P4080 && SVR_MAJ(svr) < 2);
+		enable_cpu_a011_workaround = SVR_MAJ(svr) < 2;
 	}
-#endif
 	if (enable_cpu_a011_workaround) {
 		flush_dcache();
 		mtspr(L1CSR2, (mfspr(L1CSR2) | L1CSR2_DCWS));
diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index 143b7c624d2..7de6a033ce2 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -504,27 +504,6 @@ static void ft_fixup_qe_snum(void *blob)
 }
 #endif
 
-#if defined(CONFIG_ARCH_P4080)
-static void fdt_fixup_usb(void *fdt)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 rcwsr11 = in_be32(&gur->rcwsr[11]);
-	int off;
-
-	off = fdt_node_offset_by_compatible(fdt, -1, "fsl,mpc85xx-usb2-mph");
-	if ((rcwsr11 & FSL_CORENET_RCWSR11_EC1) !=
-				FSL_CORENET_RCWSR11_EC1_FM1_USB1)
-		fdt_status_disabled(fdt, off);
-
-	off = fdt_node_offset_by_compatible(fdt, -1, "fsl,mpc85xx-usb2-dr");
-	if ((rcwsr11 & FSL_CORENET_RCWSR11_EC2) !=
-				FSL_CORENET_RCWSR11_EC2_USB2)
-		fdt_status_disabled(fdt, off);
-}
-#else
-#define fdt_fixup_usb(x)
-#endif
-
 #if defined(CONFIG_ARCH_T2080) || defined(CONFIG_ARCH_T4240)
 void fdt_fixup_dma3(void *blob)
 {
@@ -719,7 +698,6 @@ void ft_cpu_setup(void *blob, struct bd_info *bd)
 	do_fixup_by_compat_u32(blob, "fsl,p1010-flexcan",
 			"clock-frequency", gd->bus_clk/2, 1);
 
-	fdt_fixup_usb(blob);
 
 	fdt_fixup_l2_switch(blob);
 
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
index f2f854ebc12..0a66f376f86 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
@@ -4,62 +4,17 @@
  */
 
 #include <config.h>
-#include <env.h>
 #include <log.h>
 #include <time.h>
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-#include <hwconfig.h>
-#endif
 #include <asm/fsl_serdes.h>
 #include <asm/immap_85xx.h>
 #include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/fsl_law.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include "fsl_corenet_serdes.h"
 
-/*
- * The work-arounds for erratum SERDES8 and SERDES-A001 are linked together.
- * The code is already very complicated as it is, and separating the two
- * completely would just make things worse.  We try to keep them as separate
- * as possible, but for now we require SERDES8 if SERDES_A001 is defined.
- */
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A001
-#ifndef CONFIG_SYS_P4080_ERRATUM_SERDES8
-#error "CONFIG_SYS_P4080_ERRATUM_SERDES_A001 requires CONFIG_SYS_P4080_ERRATUM_SERDES8"
-#endif
-#endif
-
 static u32 serdes_prtcl_map;
 
-#ifdef DEBUG
-static const char *serdes_prtcl_str[] = {
-	[NONE] = "NA",
-	[PCIE1] = "PCIE1",
-	[PCIE2] = "PCIE2",
-	[PCIE3] = "PCIE3",
-	[PCIE4] = "PCIE4",
-	[SATA1] = "SATA1",
-	[SATA2] = "SATA2",
-	[SRIO1] = "SRIO1",
-	[SRIO2] = "SRIO2",
-	[SGMII_FM1_DTSEC1] = "SGMII_FM1_DTSEC1",
-	[SGMII_FM1_DTSEC2] = "SGMII_FM1_DTSEC2",
-	[SGMII_FM1_DTSEC3] = "SGMII_FM1_DTSEC3",
-	[SGMII_FM1_DTSEC4] = "SGMII_FM1_DTSEC4",
-	[SGMII_FM1_DTSEC5] = "SGMII_FM1_DTSEC5",
-	[SGMII_FM2_DTSEC1] = "SGMII_FM2_DTSEC1",
-	[SGMII_FM2_DTSEC2] = "SGMII_FM2_DTSEC2",
-	[SGMII_FM2_DTSEC3] = "SGMII_FM2_DTSEC3",
-	[SGMII_FM2_DTSEC4] = "SGMII_FM2_DTSEC4",
-	[SGMII_FM2_DTSEC5] = "SGMII_FM2_DTSEC5",
-	[XAUI_FM1] = "XAUI_FM1",
-	[XAUI_FM2] = "XAUI_FM2",
-	[AURORA] = "DEBUG",
-};
-#endif
-
 static const struct {
 	int idx;
 	unsigned int lpd; /* RCW lane powerdown bit */
@@ -79,17 +34,10 @@ static const struct {
 	{ 17, 163, FSL_SRDS_BANK_2 },
 	{ 18, 164, FSL_SRDS_BANK_2 },
 	{ 19, 165, FSL_SRDS_BANK_2 },
-#ifdef CONFIG_ARCH_P4080
-	{ 20, 170, FSL_SRDS_BANK_3 },
-	{ 21, 171, FSL_SRDS_BANK_3 },
-	{ 22, 172, FSL_SRDS_BANK_3 },
-	{ 23, 173, FSL_SRDS_BANK_3 },
-#else
 	{ 20, 166, FSL_SRDS_BANK_3 },
 	{ 21, 167, FSL_SRDS_BANK_3 },
 	{ 22, 168, FSL_SRDS_BANK_3 },
 	{ 23, 169, FSL_SRDS_BANK_3 },
-#endif
 #if SRDS_MAX_BANK > 3
 	{ 24, 175, FSL_SRDS_BANK_4 },
 	{ 25, 176, FSL_SRDS_BANK_4 },
@@ -118,16 +66,6 @@ int serdes_lane_enabled(int lane)
 	if (in_be32(&regs->bank[bank].rstctl) & SRDS_RSTCTL_SDPD)
 		return 0;
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-	/*
-	 * For banks two and three, use the srds_lpd_b[] array instead of the
-	 * RCW, because this array contains the real values of SRDS_LPD_B2 and
-	 * SRDS_LPD_B3.
-	 */
-	if (bank > 0)
-		return !(srds_lpd_b[bank] & (8 >> (lane - (6 + 4 * bank))));
-#endif
-
 	return !(in_be32(&gur->rcwsr[word]) & (0x80000000 >> bit));
 }
 
@@ -180,285 +118,6 @@ int serdes_get_first_lane(enum srds_prtcl device)
 	return __serdes_get_first_lane(prtcl, device);
 }
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES9
-/*
- * Returns the SERDES bank (1, 2, or 3) that a given device is on for a given
- * SERDES protocol.
- *
- * Returns a negative error code if the given device is not supported for the
- * given SERDES protocol.
- */
-static int serdes_get_bank_by_device(uint32_t prtcl, enum srds_prtcl device)
-{
-	int lane;
-
-	lane = __serdes_get_first_lane(prtcl, device);
-	if (unlikely(lane < 0))
-		return lane;
-
-	return serdes_get_bank_by_lane(lane);
-}
-
-static uint32_t __serdes_get_lane_count(uint32_t prtcl, enum srds_prtcl device,
-					int first)
-{
-	int lane;
-
-	for (lane = first; lane < SRDS_MAX_LANES; lane++) {
-		if (serdes_get_prtcl(prtcl, lane) != device)
-			break;
-	}
-
-	return lane - first;
-}
-
-static void __serdes_reset_rx(serdes_corenet_t *regs,
-			      uint32_t prtcl,
-			      enum srds_prtcl device)
-{
-	int lane, idx, first, last;
-
-	lane = __serdes_get_first_lane(prtcl, device);
-	if (unlikely(lane < 0))
-		return;
-	first = serdes_get_lane_idx(lane);
-	last = first + __serdes_get_lane_count(prtcl, device, lane);
-
-	/*
-	 * Set BnGCRy0[RRST] = 0 for each lane in the each bank that is
-	 * selected as XAUI to place the lane into reset.
-	*/
-	for (idx = first; idx < last; idx++)
-		clrbits_be32(&regs->lane[idx].gcr0, SRDS_GCR0_RRST);
-
-	/* Wait at least 250 ns */
-	udelay(1);
-
-	/*
-	 * Set BnGCRy0[RRST] = 1 for each lane in the each bank that is
-	 * selected as XAUI to bring the lane out of reset.
-	 */
-	for (idx = first; idx < last; idx++)
-		setbits_be32(&regs->lane[idx].gcr0, SRDS_GCR0_RRST);
-}
-
-void serdes_reset_rx(enum srds_prtcl device)
-{
-	u32 prtcl;
-	const ccsr_gur_t *gur;
-	serdes_corenet_t *regs;
-
-	if (unlikely(device == NONE))
-		return;
-
-	gur = (typeof(gur))CFG_SYS_MPC85xx_GUTS_ADDR;
-
-	/* Is serdes enabled at all? */
-	if (unlikely((in_be32(&gur->rcwsr[5]) & 0x2000) == 0))
-		return;
-
-	regs = (typeof(regs))CFG_SYS_FSL_CORENET_SERDES_ADDR;
-	prtcl = (in_be32(&gur->rcwsr[4]) & FSL_CORENET_RCWSR4_SRDS_PRTCL) >> 26;
-
-	__serdes_reset_rx(regs, prtcl, device);
-}
-#endif
-
-#ifndef CFG_SYS_DCSRBAR_PHYS
-#define CFG_SYS_DCSRBAR_PHYS	0x80000000 /* Must be 1GB-aligned for rev1.0 */
-#define CFG_SYS_DCSRBAR	0x80000000
-#define __DCSR_NOT_DEFINED_BY_CONFIG
-#endif
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-/*
- * Enable a SERDES bank that was disabled via the RCW
- *
- * We only call this function for SERDES8 and SERDES-A001 in cases we really
- * want to enable the bank, whether we actually want to use the lanes or not,
- * so make sure at least one lane is enabled.  We're only enabling this one
- * lane to satisfy errata requirements that the bank be enabled.
- *
- * We use a local variable instead of srds_lpd_b[] because we want drivers to
- * think that the lanes actually are disabled.
- */
-static void enable_bank(ccsr_gur_t *gur, int bank)
-{
-	u32 rcw5;
-	u32 temp_lpd_b = srds_lpd_b[bank];
-
-	/*
-	 * If we're asked to disable all lanes, just pretend we're doing
-	 * that.
-	 */
-	if (temp_lpd_b == 0xF)
-		temp_lpd_b = 0xE;
-
-	/*
-	 * Enable the lanes SRDS_LPD_Bn.  The RCW bits are read-only in
-	 * CCSR, and read/write in DSCR.
-	 */
-	rcw5 = in_be32(gur->rcwsr + 5);
-	if (bank == FSL_SRDS_BANK_2) {
-		rcw5 &= ~FSL_CORENET_RCWSRn_SRDS_LPD_B2;
-		rcw5 |= temp_lpd_b << 26;
-	} else if (bank == FSL_SRDS_BANK_3) {
-		rcw5 &= ~FSL_CORENET_RCWSRn_SRDS_LPD_B3;
-		rcw5 |= temp_lpd_b << 18;
-	} else {
-		printf("SERDES: enable_bank: bad bank %d\n", bank + 1);
-		return;
-	}
-
-	/* See similar code in cpu/mpc85xx/cpu_init.c for an explanation
-	 * of the DCSR mapping.
-	 */
-	{
-#ifdef __DCSR_NOT_DEFINED_BY_CONFIG
-		struct law_entry law = find_law(CFG_SYS_DCSRBAR_PHYS);
-		int law_index;
-		if (law.index == -1)
-			law_index = set_next_law(CFG_SYS_DCSRBAR_PHYS,
-						 LAW_SIZE_1M, LAW_TRGT_IF_DCSR);
-		else
-			set_law(law.index, CFG_SYS_DCSRBAR_PHYS, LAW_SIZE_1M,
-				LAW_TRGT_IF_DCSR);
-#endif
-		u32 *p = (void *)CFG_SYS_DCSRBAR + 0x20114;
-		out_be32(p, rcw5);
-#ifdef __DCSR_NOT_DEFINED_BY_CONFIG
-		if (law.index == -1)
-			disable_law(law_index);
-		else
-			set_law(law.index, law.addr, law.size, law.trgt_id);
-#endif
-	}
-}
-
-/*
- * To avoid problems with clock jitter, rev 2 p4080 uses the pll from
- * bank 3 to clock banks 2 and 3, as well as a limited selection of
- * protocol configurations.  This requires that banks 2 and 3's lanes be
- * disabled in the RCW, and enabled with some fixup here to re-enable
- * them, and to configure bank 2's clock parameters in bank 3's pll in
- * cases where they differ.
- */
-static void p4080_erratum_serdes8(serdes_corenet_t *regs, ccsr_gur_t *gur,
-				  u32 devdisr, u32 devdisr2, int cfg)
-{
-	int srds_ratio_b2;
-	int rfck_sel;
-
-	/*
-	 * The disabled lanes of bank 2 will cause the associated
-	 * logic blocks to be disabled in DEVDISR.  We reverse that here.
-	 *
-	 * Note that normally it is not permitted to clear DEVDISR bits
-	 * once the device has been disabled, but the hardware people
-	 * say that this special case is OK.
-	 */
-	clrbits_be32(&gur->devdisr, devdisr);
-	clrbits_be32(&gur->devdisr2, devdisr2);
-
-	/*
-	 * Some protocols require special handling.  There are a few
-	 * additional protocol configurations that can be used, which are
-	 * not listed here.  See app note 4065 for supported protocol
-	 * configurations.
-	 */
-	switch (cfg) {
-	case 0x19:
-		/*
-		 * Bank 2 has PCIe which wants BWSEL -- tell bank 3's PLL.
-		 * SGMII on bank 3 should still be usable.
-		 */
-		setbits_be32(&regs->bank[FSL_SRDS_BANK_3].pllcr1,
-			     SRDS_PLLCR1_PLL_BWSEL);
-		break;
-
-	case 0x0f:
-	case 0x10:
-		/*
-		 * Banks 2 (XAUI) and 3 (SGMII) have different clocking
-		 * requirements in these configurations.  Bank 3 cannot
-		 * be used and should have its lanes (but not the bank
-		 * itself) disabled in the RCW.  We set up bank 3's pll
-		 * for bank 2's needs here.
-		 */
-		srds_ratio_b2 = (in_be32(&gur->rcwsr[4]) >> 13) & 7;
-
-		/* Determine refclock from XAUI ratio */
-		switch (srds_ratio_b2) {
-		case 1: /* 20:1 */
-			rfck_sel = SRDS_PLLCR0_RFCK_SEL_156_25;
-			break;
-		case 2: /* 25:1 */
-			rfck_sel = SRDS_PLLCR0_RFCK_SEL_125;
-			break;
-		default:
-			printf("SERDES: bad SRDS_RATIO_B2 %d\n",
-			       srds_ratio_b2);
-			return;
-		}
-
-		clrsetbits_be32(&regs->bank[FSL_SRDS_BANK_3].pllcr0,
-				SRDS_PLLCR0_RFCK_SEL_MASK, rfck_sel);
-
-		clrsetbits_be32(&regs->bank[FSL_SRDS_BANK_3].pllcr0,
-				SRDS_PLLCR0_FRATE_SEL_MASK,
-				SRDS_PLLCR0_FRATE_SEL_6_25);
-		break;
-	}
-
-	enable_bank(gur, FSL_SRDS_BANK_3);
-}
-#endif
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A005
-/*
- * If PCIe is not selected as a protocol for any lanes driven by a given PLL,
- * that PLL should have SRDSBnPLLCR1[PLLBW_SEL] = 0.
- */
-static void p4080_erratum_serdes_a005(serdes_corenet_t *regs, unsigned int cfg)
-{
-	enum srds_prtcl device;
-
-	switch (cfg) {
-	case 0x13:
-	case 0x16:
-		/*
-		 * If SRDS_PRTCL = 0x13 or 0x16, set SRDSB1PLLCR1[PLLBW_SEL]
-		 * to 0.
-		 */
-		clrbits_be32(&regs->bank[FSL_SRDS_BANK_1].pllcr1,
-			     SRDS_PLLCR1_PLL_BWSEL);
-		break;
-	case 0x19:
-		/*
-		 * If SRDS_PRTCL = 0x19, set SRDSB1PLLCR1[PLLBW_SEL] to 0 and
-		 * SRDSB3PLLCR1[PLLBW_SEL] to 1.
-		 */
-		clrbits_be32(&regs->bank[FSL_SRDS_BANK_1].pllcr1,
-			     SRDS_PLLCR1_PLL_BWSEL);
-		setbits_be32(&regs->bank[FSL_SRDS_BANK_3].pllcr1,
-			     SRDS_PLLCR1_PLL_BWSEL);
-		break;
-	}
-
-	/*
-	 * Set SRDSBnPLLCR1[PLLBW_SEL] to 0 for each bank that selects XAUI
-	 * before XAUI is initialized.
-	 */
-	for (device = XAUI_FM1; device <= XAUI_FM2; device++) {
-		if (is_serdes_configured(device)) {
-			int bank = serdes_get_bank_by_device(cfg, device);
-
-			clrbits_be32(&regs->bank[bank].pllcr1,
-				     SRDS_PLLCR1_PLL_BWSEL);
-		}
-	}
-}
-#endif
 
 /*
  * Wait for the RSTDONE bit to get set, or a one-second timeout.
@@ -498,27 +157,6 @@ void fsl_serdes_init(void)
 #endif
 	int lane, bank, idx;
 	int have_bank[SRDS_MAX_BANK] = {};
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-	u32 serdes8_devdisr = 0;
-	u32 serdes8_devdisr2 = 0;
-	char srds_lpd_opt[16];
-	const char *srds_lpd_arg;
-	size_t arglen;
-#endif
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A001
-	int need_serdes_a001;	/* true == need work-around for SERDES A001 */
-#endif
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-	char buffer[HWCONFIG_BUFFER_SIZE];
-	char *buf = NULL;
-
-	/*
-	 * Extract hwconfig from environment since we have not properly setup
-	 * the environment but need it for ddr config params
-	 */
-	if (env_get_f("hwconfig", buffer, sizeof(buffer)) > 0)
-		buf = buffer;
-#endif
 	if (serdes_prtcl_map & (1 << NONE))
 		return;
 
@@ -534,42 +172,6 @@ void fsl_serdes_init(void)
 		printf("SERDES[PRTCL] = 0x%x is not valid\n", cfg);
 		return;
 	}
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-	/*
-	 * Display a warning if banks two and three are not disabled in the RCW,
-	 * since our work-around for SERDES8 depends on these banks being
-	 * disabled at power-on.
-	 */
-#define B2_B3 (FSL_CORENET_RCWSRn_SRDS_LPD_B2 | FSL_CORENET_RCWSRn_SRDS_LPD_B3)
-	if ((in_be32(&gur->rcwsr[5]) & B2_B3) != B2_B3) {
-		printf("Warning: SERDES8 requires banks two and "
-		       "three to be disabled in the RCW\n");
-	}
-
-	/*
-	 * Store the values of the fsl_srds_lpd_b2 and fsl_srds_lpd_b3
-	 * hwconfig options into the srds_lpd_b[] array.  See README.p4080ds
-	 * for a description of these options.
-	 */
-	for (bank = 1; bank < ARRAY_SIZE(srds_lpd_b); bank++) {
-		sprintf(srds_lpd_opt, "fsl_srds_lpd_b%u", bank + 1);
-		srds_lpd_arg =
-			hwconfig_subarg_f("serdes", srds_lpd_opt, &arglen, buf);
-		if (srds_lpd_arg)
-			srds_lpd_b[bank] =
-				simple_strtoul(srds_lpd_arg, NULL, 0) & 0xf;
-	}
-
-	if ((cfg == 0xf) || (cfg == 0x10)) {
-		/*
-		 * For SERDES protocols 0xF and 0x10, force bank 3 to be
-		 * disabled, because it is not supported.
-		 */
-		srds_lpd_b[FSL_SRDS_BANK_3] = 0xF;
-	}
-#endif
-
 	/* Look for banks with all lanes disabled, and power down the bank. */
 	for (lane = 0; lane < SRDS_MAX_LANES; lane++) {
 		enum srds_prtcl lane_prtcl = serdes_get_prtcl(cfg, lane);
@@ -612,44 +214,13 @@ void fsl_serdes_init(void)
 	/* Set the first bit to indicate serdes has been initialized */
 	serdes_prtcl_map |= (1 << NONE);
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-	/*
-	 * Bank two uses the clock from bank three, so if bank two is enabled,
-	 * then bank three must also be enabled.
-	 */
-	if (have_bank[FSL_SRDS_BANK_2])
-		have_bank[FSL_SRDS_BANK_3] = 1;
-#endif
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A001
-	/*
-	 * The work-aroud for erratum SERDES-A001 is needed only if bank two
-	 * is disabled and bank three is enabled.  The converse is also true,
-	 * but SERDES8 ensures that bank 3 is always enabled if bank 2 is
-	 * enabled, so there's no point in complicating the code to handle
-	 * that situation.
-	 */
-	need_serdes_a001 =
-		!have_bank[FSL_SRDS_BANK_2] && have_bank[FSL_SRDS_BANK_3];
-#endif
 
 	/* Power down the banks we're not interested in */
 	for (bank = 0; bank < SRDS_MAX_BANK; bank++) {
 		if (!have_bank[bank]) {
 			printf("SERDES: bank %d disabled\n", bank + 1);
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A001
-			/*
-			 * Erratum SERDES-A001 says bank two needs to be powered
-			 * down after bank three is powered up, so don't power
-			 * down bank two here.
-			 */
-			if (!need_serdes_a001 || (bank != FSL_SRDS_BANK_2))
-				setbits_be32(&srds_regs->bank[bank].rstctl,
-					     SRDS_RSTCTL_SDPD);
-#else
 			setbits_be32(&srds_regs->bank[bank].rstctl,
 				     SRDS_RSTCTL_SDPD);
-#endif
 		}
 	}
 
@@ -685,188 +256,17 @@ void fsl_serdes_init(void)
 	}
 #endif
 
-#if defined(CONFIG_SYS_P4080_ERRATUM_SERDES8) || defined (CONFIG_SYS_P4080_ERRATUM_SERDES9)
-	for (lane = 0; lane < SRDS_MAX_LANES; lane++) {
-		enum srds_prtcl lane_prtcl;
 
-		idx = serdes_get_lane_idx(lane);
-		lane_prtcl = serdes_get_prtcl(cfg, lane);
-
-#ifdef DEBUG
-		switch (lane) {
-		case 0:
-			puts("Bank1: ");
-			break;
-		case 10:
-			puts("\nBank2: ");
-			break;
-		case 14:
-			puts("\nBank3: ");
-			break;
-		default:
-			break;
-		}
-
-		printf("%s ", serdes_prtcl_str[lane_prtcl]);
-#endif
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES9
-		/*
-		 * Set BnTTLCRy0[FLT_SEL] = 011011 and set BnTTLCRy0[31] = 1
-		 * for each of the SerDes lanes selected as SGMII, XAUI, SRIO,
-		 * or AURORA before the device is initialized.
-		 *
-		 * Note that this part of the SERDES-9 work-around is
-		 * redundant if the work-around for A-4580 has already been
-		 * applied via PBI.
-		 */
-		switch (lane_prtcl) {
-		case SGMII_FM1_DTSEC1:
-		case SGMII_FM1_DTSEC2:
-		case SGMII_FM1_DTSEC3:
-		case SGMII_FM1_DTSEC4:
-		case SGMII_FM2_DTSEC1:
-		case SGMII_FM2_DTSEC2:
-		case SGMII_FM2_DTSEC3:
-		case SGMII_FM2_DTSEC4:
-		case SGMII_FM2_DTSEC5:
-		case XAUI_FM1:
-		case XAUI_FM2:
-		case SRIO1:
-		case SRIO2:
-		case AURORA:
-			out_be32(&srds_regs->lane[idx].ttlcr0,
-				 SRDS_TTLCR0_FLT_SEL_KFR_26 |
-				 SRDS_TTLCR0_FLT_SEL_KPH_28 |
-				 SRDS_TTLCR0_FLT_SEL_750PPM |
-				 SRDS_TTLCR0_FREQOVD_EN);
-			break;
-		default:
-			break;
-		}
-#endif
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-		switch (lane_prtcl) {
-		case PCIE1:
-		case PCIE2:
-		case PCIE3:
-			serdes8_devdisr |= FSL_CORENET_DEVDISR_PCIE1 >>
-					   (lane_prtcl - PCIE1);
-			break;
-		case SRIO1:
-		case SRIO2:
-			serdes8_devdisr |= FSL_CORENET_DEVDISR_SRIO1 >>
-					   (lane_prtcl - SRIO1);
-			break;
-		case SGMII_FM1_DTSEC1:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM1 |
-					    FSL_CORENET_DEVDISR2_DTSEC1_1;
-			break;
-		case SGMII_FM1_DTSEC2:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM1 |
-					    FSL_CORENET_DEVDISR2_DTSEC1_2;
-			break;
-		case SGMII_FM1_DTSEC3:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM1 |
-					    FSL_CORENET_DEVDISR2_DTSEC1_3;
-			break;
-		case SGMII_FM1_DTSEC4:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM1 |
-					    FSL_CORENET_DEVDISR2_DTSEC1_4;
-			break;
-		case SGMII_FM2_DTSEC1:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM2 |
-					    FSL_CORENET_DEVDISR2_DTSEC2_1;
-			break;
-		case SGMII_FM2_DTSEC2:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM2 |
-					    FSL_CORENET_DEVDISR2_DTSEC2_2;
-			break;
-		case SGMII_FM2_DTSEC3:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM2 |
-					    FSL_CORENET_DEVDISR2_DTSEC2_3;
-			break;
-		case SGMII_FM2_DTSEC4:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM2 |
-					    FSL_CORENET_DEVDISR2_DTSEC2_4;
-			break;
-		case SGMII_FM2_DTSEC5:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM2 |
-					    FSL_CORENET_DEVDISR2_DTSEC2_5;
-			break;
-		case XAUI_FM1:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM1	|
-					    FSL_CORENET_DEVDISR2_10GEC1;
-			break;
-		case XAUI_FM2:
-			serdes8_devdisr2 |= FSL_CORENET_DEVDISR2_FM2	|
-					    FSL_CORENET_DEVDISR2_10GEC2;
-			break;
-		case AURORA:
-			break;
-		default:
-			break;
-		}
-
-#endif
-	}
-#endif
-
-#ifdef DEBUG
-	puts("\n");
-#endif
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A005
-	p4080_erratum_serdes_a005(srds_regs, cfg);
-#endif
 
 	for (idx = 0; idx < SRDS_MAX_BANK; idx++) {
 		bank = idx;
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-		/*
-		 * Change bank init order to 0, 2, 1, so that the third bank's
-		 * PLL is established before we start the second bank.  The
-		 * second bank uses the third bank's PLL.
-		 */
-
-		if (idx == 1)
-			bank = FSL_SRDS_BANK_3;
-		else if (idx == 2)
-			bank = FSL_SRDS_BANK_2;
-#endif
-
 		/* Skip disabled banks */
 		if (!have_bank[bank])
 			continue;
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-		if (idx == 1) {
-			/*
-			 * Re-enable devices on banks two and three that were
-			 * disabled by the RCW, and then enable bank three. The
-			 * devices need to be enabled before either bank is
-			 * powered up.
-			 */
-			p4080_erratum_serdes8(srds_regs, gur, serdes8_devdisr,
-					      serdes8_devdisr2, cfg);
-		} else if (idx == 2) {
-			/* Enable bank two now that bank three is enabled. */
-			enable_bank(gur, FSL_SRDS_BANK_2);
-		}
-#endif
-
 		wait_for_rstdone(bank);
 	}
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES_A001
-	if (need_serdes_a001) {
-		/* Bank 3 has been enabled, so now we can disable bank 2 */
-		setbits_be32(&srds_regs->bank[FSL_SRDS_BANK_2].rstctl,
-			     SRDS_RSTCTL_SDPD);
-	}
-#endif
 }
 
 const char *serdes_clock_to_string(u32 clock)
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h
index e95dc485814..553c72a43d6 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.h
@@ -20,8 +20,4 @@ int serdes_get_bank_by_lane(int lane);
 int serdes_lane_enabled(int lane);
 enum srds_prtcl serdes_get_prtcl(int cfg, int lane);
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-extern uint16_t srds_lpd_b[SRDS_MAX_BANK];
-#endif
-
 #endif /* __FSL_CORENET_SERDES_H */
diff --git a/arch/powerpc/cpu/mpc85xx/p4080_ids.c b/arch/powerpc/cpu/mpc85xx/p4080_ids.c
deleted file mode 100644
index 15ab4ac9385..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p4080_ids.c
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
-	SET_QP_INFO( 1,  2,  1, 0),
-	SET_QP_INFO( 3,  4,  2, 1),
-	SET_QP_INFO( 5,  6,  3, 2),
-	SET_QP_INFO( 7,  8,  4, 3),
-	SET_QP_INFO( 9, 10,  5, 4),
-	SET_QP_INFO(11, 12,  6, 5),
-	SET_QP_INFO(13, 14,  7, 6),
-	SET_QP_INFO(15, 16,  8, 7),
-	SET_QP_INFO(17, 18,  9, 0), /* for now sdest to 0 */
-	SET_QP_INFO(19, 20, 10, 0), /* for now sdest to 0 */
-};
-#endif
-
-struct srio_liodn_id_table srio_liodn_tbl[] = {
-	SET_SRIO_LIODN_1(1, 198),
-	SET_SRIO_LIODN_1(2, 199),
-};
-int srio_liodn_tbl_sz = ARRAY_SIZE(srio_liodn_tbl);
-
-struct liodn_id_table liodn_tbl[] = {
-	SET_USB_LIODN(1, "fsl-usb2-mph", 127),
-	SET_USB_LIODN(2, "fsl-usb2-dr", 157),
-
-	SET_SDHC_LIODN(1, 156),
-
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 1, 193),
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 2, 194),
-	SET_PCI_LIODN(CONFIG_SYS_FSL_PCIE_COMPAT, 3, 195),
-
-	SET_DMA_LIODN(1, "fsl,eloplus-dma", 196),
-	SET_DMA_LIODN(2, "fsl,eloplus-dma", 197),
-
-	SET_GUTS_LIODN("fsl,srio-rmu", 200, rmuliodnr, 0xd3000),
-
-#ifdef CONFIG_SYS_DPAA_QBMAN
-	SET_QMAN_LIODN(31),
-	SET_BMAN_LIODN(32),
-#endif
-	SET_PME_LIODN(128),
-};
-int liodn_tbl_sz = ARRAY_SIZE(liodn_tbl);
-
-#ifdef CONFIG_SYS_DPAA_FMAN
-struct fman_liodn_id_table fman1_liodn_tbl[] = {
-	SET_FMAN_RX_1G_LIODN(1, 0, 11),
-	SET_FMAN_RX_1G_LIODN(1, 1, 12),
-	SET_FMAN_RX_1G_LIODN(1, 2, 13),
-	SET_FMAN_RX_1G_LIODN(1, 3, 14),
-	SET_FMAN_RX_10G_LIODN(1, 0, 15),
-};
-int fman1_liodn_tbl_sz = ARRAY_SIZE(fman1_liodn_tbl);
-
-#if (CFG_SYS_NUM_FMAN == 2)
-struct fman_liodn_id_table fman2_liodn_tbl[] = {
-	SET_FMAN_RX_1G_LIODN(2, 0, 16),
-	SET_FMAN_RX_1G_LIODN(2, 1, 17),
-	SET_FMAN_RX_1G_LIODN(2, 2, 18),
-	SET_FMAN_RX_1G_LIODN(2, 3, 19),
-	SET_FMAN_RX_10G_LIODN(2, 0, 20),
-};
-int fman2_liodn_tbl_sz = ARRAY_SIZE(fman2_liodn_tbl);
-#endif
-#endif
-
-struct liodn_id_table sec_liodn_tbl[] = {
-	/*
-	 * We assume currently that all JR are in the same partition
-	 * and as such they need to represent the same LIODN due to
-	 * a 4080 rev.2 h/w requirement that DECOs sharing from themselves
-	 * or from another DECO have the two Non-SEQ LIODN values equal
-	 */
-	SET_SEC_JR_LIODN_ENTRY(0, 146, 154), /* (0, 146, 154), */
-	SET_SEC_JR_LIODN_ENTRY(1, 146, 154), /* (1, 147, 155), */
-	SET_SEC_JR_LIODN_ENTRY(2, 146, 154), /* (2, 178, 186), */
-	SET_SEC_JR_LIODN_ENTRY(3, 146, 154), /* (3, 179, 187), */
-	SET_SEC_RTIC_LIODN_ENTRY(a, 144),
-	SET_SEC_RTIC_LIODN_ENTRY(b, 145),
-	SET_SEC_RTIC_LIODN_ENTRY(c, 176),
-	SET_SEC_RTIC_LIODN_ENTRY(d, 177),
-	SET_SEC_DECO_LIODN_ENTRY(0, 129, 161),
-	SET_SEC_DECO_LIODN_ENTRY(1, 130, 162),
-	SET_SEC_DECO_LIODN_ENTRY(2, 131, 163),
-	SET_SEC_DECO_LIODN_ENTRY(3, 132, 164),
-	SET_SEC_DECO_LIODN_ENTRY(4, 133, 165),
-};
-int sec_liodn_tbl_sz = ARRAY_SIZE(sec_liodn_tbl);
-
-struct liodn_id_table liodn_bases[] = {
-	[FSL_HW_PORTAL_SEC]  = SET_LIODN_BASE_2(96, 106),
-#ifdef CONFIG_SYS_DPAA_FMAN
-	[FSL_HW_PORTAL_FMAN1] = SET_LIODN_BASE_1(32),
-#if (CFG_SYS_NUM_FMAN == 2)
-	[FSL_HW_PORTAL_FMAN2] = SET_LIODN_BASE_1(64),
-#endif
-#endif
-#ifdef CONFIG_SYS_DPAA_PME
-	[FSL_HW_PORTAL_PME]   = SET_LIODN_BASE_2(116, 133),
-#endif
-};
diff --git a/arch/powerpc/cpu/mpc85xx/p4080_serdes.c b/arch/powerpc/cpu/mpc85xx/p4080_serdes.c
deleted file mode 100644
index 438fd446be3..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p4080_serdes.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2009-2010 Freescale Semiconductor, Inc.
- */
-
-#include <asm/io.h>
-#include <asm/fsl_serdes.h>
-#include <asm/processor.h>
-#include <asm/io.h>
-#include "fsl_corenet_serdes.h"
-
-static u8 serdes_cfg_tbl[][SRDS_MAX_LANES] = {
-	[0x2] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0x5] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0x8] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0xd] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, SGMII_FM2_DTSEC3,
-		SGMII_FM2_DTSEC4, AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0xe] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, SGMII_FM2_DTSEC3,
-		SGMII_FM2_DTSEC4, AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0xf] = {PCIE1, PCIE1, PCIE1, PCIE1, SGMII_FM2_DTSEC1, SGMII_FM2_DTSEC2,
-		SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4, AURORA, AURORA, XAUI_FM2,
-		XAUI_FM2, XAUI_FM2, XAUI_FM2, NONE, NONE, NONE, NONE},
-	[0x10] = {PCIE1, PCIE1, PCIE3, PCIE3, SGMII_FM2_DTSEC1,
-		SGMII_FM2_DTSEC2, SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		NONE, NONE, NONE, NONE},
-	[0x13] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0x16] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, SGMII_FM2_DTSEC1, SGMII_FM2_DTSEC2,
-		SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4},
-	[0x19] = {SRIO2, SRIO2, SRIO2, SRIO2, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, PCIE3, PCIE3, PCIE3, PCIE3, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4},
-	[0x1d] = {PCIE1, PCIE1, PCIE3, PCIE3, NONE, SRIO2, NONE, SRIO1,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0x22] = {PCIE1, PCIE1, PCIE1, PCIE1, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-	[0x25] = {PCIE1, PCIE1, PCIE3, PCIE3, SRIO1, SRIO1, SRIO1, SRIO1,
-		AURORA, AURORA, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1},
-};
-
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES8
-uint16_t srds_lpd_b[SRDS_MAX_BANK];
-#endif
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
index 078d8cf3f34..26110f11592 100644
--- a/arch/powerpc/cpu/mpc85xx/release.S
+++ b/arch/powerpc/cpu/mpc85xx/release.S
@@ -203,32 +203,11 @@ __secondary_start_page:
 #endif
 #endif	/* CONFIG_SYS_FSL_ERRATUM_A007907 */
 
-#if defined(CONFIG_SYS_P4080_ERRATUM_CPU22) || \
-	defined(CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011)
-	/*
-	 * CPU22 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * NMG_CPU_A011 applies to P4080 rev 1.0, 2.0, fixed in 3.0
-	 * also applies to P2041 rev 1.0, 1.1
-	 */
-	mfspr   r3,SPRN_SVR
-	rlwinm	r6,r3,24,~0x800		/* clear E bit */
-
-	lis	r5,SVR_P4080@h
-	ori	r5,r5,SVR_P4080@l
-	cmpw	r6,r5
-	bne	1f
-
-	rlwinm  r3,r3,0,0xf0
-	li      r5,0x30
-	cmpw    r3,r5
-	bge     2f
-1:
-#ifdef	CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011
+#ifdef CONFIG_SYS_FSL_ERRATUM_NMG_CPU_A011
 	lis	r3,toreset(enable_cpu_a011_workaround)@ha
 	lwz	r3,toreset(enable_cpu_a011_workaround)@l(r3)
 	cmpwi	r3,0
 	beq	2f
-#endif
 	mfspr	r3,L1CSR2
 	oris	r3,r3,(L1CSR2_DCWS)@h
 	mtspr	L1CSR2,r3
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index b8bec9ed2e8..8b575e85347 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -57,7 +57,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P2040, P2040, 4),
 	CPU_TYPE_ENTRY(P2041, P2041, 4),
 	CPU_TYPE_ENTRY(P4040, P4040, 4),
-	CPU_TYPE_ENTRY(P4080, P4080, 8),
 	CPU_TYPE_ENTRY(P5010, P5010, 1),
 	CPU_TYPE_ENTRY(P5020, P5020, 2),
 	CPU_TYPE_ENTRY(P5021, P5021, 2),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index 07be48d518d..3701f29daa0 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -44,19 +44,6 @@
 #define CFG_SYS_FSL_SRIO_IB_WIN_NUM	5
 #define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xf0000000
 
-#elif defined(CONFIG_ARCH_P4080) /* also supports P4040 */
-#define CFG_SYS_NUM_FMAN		2
-#define CFG_SYS_NUM_FM1_DTSEC	4
-#define CFG_SYS_NUM_FM2_DTSEC	4
-#define CFG_SYS_NUM_FM1_10GEC	1
-#define CFG_SYS_NUM_FM2_10GEC	1
-#define CFG_SYS_FM_MURAM_SIZE	0x28000
-#define CFG_SYS_FSL_SRIO_MAX_PORTS	2
-#define CFG_SYS_FSL_SRIO_OB_WIN_NUM	9
-#define CFG_SYS_FSL_SRIO_IB_WIN_NUM	5
-#define CFG_SYS_FSL_SRIO_MSG_UNIT_NUM	2
-#define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xff000000
-
 #elif defined(CONFIG_ARCH_P5040)
 #define CFG_SYS_NUM_FMAN		2
 #define CFG_SYS_NUM_FM1_DTSEC	5
diff --git a/arch/powerpc/include/asm/fsl_serdes.h b/arch/powerpc/include/asm/fsl_serdes.h
index fdf76115233..6d238115c10 100644
--- a/arch/powerpc/include/asm/fsl_serdes.h
+++ b/arch/powerpc/include/asm/fsl_serdes.h
@@ -118,9 +118,6 @@ enum srds_prtcl serdes_get_prtcl(int serdes, int cfg, int lane);
 #else
 int serdes_get_first_lane(enum srds_prtcl device);
 #endif
-#ifdef CONFIG_SYS_P4080_ERRATUM_SERDES9
-void serdes_reset_rx(enum srds_prtcl device);
-#endif
 #endif
 
 #endif /* __FSL_SERDES_H */
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index e1d1ca80092..de1ae25440c 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1506,22 +1506,12 @@ typedef struct ccsr_gur {
 #define FSL_CORENET_RCWSR5_SRDS_EN		0x00002000
 #define FSL_CORENET_RCWSR5_SRDS2_EN		0x00001000
 #define FSL_CORENET_RCWSR6_BOOT_LOC	0x0f800000
-#define FSL_CORENET_RCWSRn_SRDS_LPD_B2		0x3c000000 /* bits 162..165 */
-#define FSL_CORENET_RCWSRn_SRDS_LPD_B3		0x003c0000 /* bits 170..173 */
 #endif /* CONFIG_SYS_FSL_QORIQ_CHASSIS2 */
 
 #define FSL_CORENET_RCWSR7_MCK_TO_PLAT_RAT	0x00400000
 #define FSL_CORENET_RCWSR8_HOST_AGT_B1		0x00e00000
 #define FSL_CORENET_RCWSR8_HOST_AGT_B2		0x00100000
 #define FSL_CORENET_RCWSR11_EC1			0x00c00000 /* bits 360..361 */
-#ifdef CONFIG_ARCH_P4080
-#define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC1		0x00000000
-#define FSL_CORENET_RCWSR11_EC1_FM1_USB1		0x00800000
-#define FSL_CORENET_RCWSR11_EC2			0x001c0000 /* bits 363..365 */
-#define FSL_CORENET_RCWSR11_EC2_FM2_DTSEC1		0x00000000
-#define FSL_CORENET_RCWSR11_EC2_FM1_DTSEC2		0x00080000
-#define FSL_CORENET_RCWSR11_EC2_USB2			0x00100000
-#endif
 #if defined(CONFIG_ARCH_P2041)
 #define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC4_RGMII	0x00000000
 #define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC4_MII		0x00800000
@@ -2313,12 +2303,6 @@ typedef struct serdes_corenet {
 #define SRDS_TECR0_TEQ_TYPE_2LVL	0x10000000
 		u32	res3;
 		u32	ttlcr0;	/* Transition Tracking Loop Ctrl 0 */
-#define SRDS_TTLCR0_FLT_SEL_MASK	0x3f000000
-#define SRDS_TTLCR0_FLT_SEL_KFR_26	0x10000000
-#define SRDS_TTLCR0_FLT_SEL_KPH_28	0x08000000
-#define SRDS_TTLCR0_FLT_SEL_750PPM	0x03000000
-#define SRDS_TTLCR0_PM_DIS		0x00004000
-#define SRDS_TTLCR0_FREQOVD_EN		0x00000001
 		u32	res4[7];
 	} lane[24];
 	u32 res6[384];
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 31d52f3b734..1ddbf15c410 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1049,7 +1049,6 @@
 #define SVR_P2040	0x821000
 #define SVR_P2041	0x821001
 #define SVR_P4040	0x820100
-#define SVR_P4080	0x820000
 #define SVR_P5010	0x822100
 #define SVR_P5020	0x822000
 #define SVR_P5021	0x820500
diff --git a/doc/README.pblimage b/doc/README.pblimage
index 7145622b575..f4bdadfb2dd 100644
--- a/doc/README.pblimage
+++ b/doc/README.pblimage
@@ -14,11 +14,11 @@ Building PBL Boot Image and boot steps
 1. Building PBL Boot Image.
    The default Image is u-boot.pbl.
 
-   For eSPI boot(available on P2041/P4080/P5020/P5040/T4240):
+   For eSPI boot(available on P2041/P5020/P5040/T4240):
 	To build the eSPI boot image:
 	make <board_name>_SPIFLASH
 
-   For SD boot(available on P2041/P4080/P5020/P5040/T4240):
+   For SD boot(available on P2041/P5020/P5040/T4240):
 	To build the SD boot image:
 	make <board_name>_SDCARD
 
diff --git a/drivers/ddr/fsl/Kconfig b/drivers/ddr/fsl/Kconfig
index d5c0af7d3b1..c518704d93e 100644
--- a/drivers/ddr/fsl/Kconfig
+++ b/drivers/ddr/fsl/Kconfig
@@ -52,7 +52,6 @@ config SYS_NUM_DDR_CTLRS
 			ARCH_T4240
 	default 2 if	ARCH_B4860	|| \
 			ARCH_BSC9132	|| \
-			ARCH_P4080	|| \
 			ARCH_P5040	|| \
 			ARCH_LX2160A	|| \
 			ARCH_LX2162A
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index fb0dc39cf35..df243e8fe9b 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -969,7 +969,6 @@ config SYS_DPAA_QBMAN
 		     ARCH_T1042 || \
 		     ARCH_T2080 || \
 		     ARCH_T4240 || \
-		     ARCH_P4080 || \
 		     ARCH_P5040 || \
 		     ARCH_LS1043A || \
 		     ARCH_LS1046A
diff --git a/drivers/net/fm/Makefile b/drivers/net/fm/Makefile
index af8fca353a9..e6727eeec98 100644
--- a/drivers/net/fm/Makefile
+++ b/drivers/net/fm/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_SYS_FMAN_V3) += memac.o
 obj-$(CONFIG_ARCH_P1023)	+= p1023.o
 # The P204x and P5020 are the same
 obj-$(CONFIG_ARCH_P2041) += p5020.o
-obj-$(CONFIG_ARCH_P4080) += p4080.o
 obj-$(CONFIG_ARCH_P5040) += p5040.o
 obj-$(CONFIG_ARCH_T1040) += t1040.o
 obj-$(CONFIG_ARCH_T1042)	+= t1040.o
diff --git a/drivers/net/fm/p4080.c b/drivers/net/fm/p4080.c
deleted file mode 100644
index 6e63e338e5d..00000000000
--- a/drivers/net/fm/p4080.c
+++ /dev/null
@@ -1,98 +0,0 @@
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
-	[FM1_DTSEC1] = FSL_CORENET_DEVDISR2_DTSEC1_1,
-	[FM1_DTSEC2] = FSL_CORENET_DEVDISR2_DTSEC1_2,
-	[FM1_DTSEC3] = FSL_CORENET_DEVDISR2_DTSEC1_3,
-	[FM1_DTSEC4] = FSL_CORENET_DEVDISR2_DTSEC1_4,
-	[FM1_10GEC1] = FSL_CORENET_DEVDISR2_10GEC1,
-	[FM2_DTSEC1] = FSL_CORENET_DEVDISR2_DTSEC2_1,
-	[FM2_DTSEC2] = FSL_CORENET_DEVDISR2_DTSEC2_2,
-	[FM2_DTSEC3] = FSL_CORENET_DEVDISR2_DTSEC2_3,
-	[FM2_DTSEC4] = FSL_CORENET_DEVDISR2_DTSEC2_4,
-	[FM2_10GEC1] = FSL_CORENET_DEVDISR2_10GEC2,
-};
-
-static int is_device_disabled(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 devdisr2 = in_be32(&gur->devdisr2);
-
-	return port_to_devdisr[port] & devdisr2;
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
-	setbits_be32(&gur->devdisr2, port_to_devdisr[port]);
-}
-
-void fman_enable_port(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-
-	clrbits_be32(&gur->devdisr2, port_to_devdisr[port]);
-}
-
-phy_interface_t fman_port_enet_if(enum fm_port port)
-{
-	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
-	u32 rcwsr11 = in_be32(&gur->rcwsr[11]);
-
-	if (is_device_disabled(port))
-		return PHY_INTERFACE_MODE_NA;
-
-	if ((port == FM1_10GEC1) && (is_serdes_configured(XAUI_FM1)))
-		return PHY_INTERFACE_MODE_XGMII;
-
-	if ((port == FM2_10GEC1) && (is_serdes_configured(XAUI_FM2)))
-		return PHY_INTERFACE_MODE_XGMII;
-
-	/* handle RGMII first */
-	if ((port == FM1_DTSEC1) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC1) ==
-		FSL_CORENET_RCWSR11_EC1_FM1_DTSEC1))
-		return PHY_INTERFACE_MODE_RGMII;
-
-	if ((port == FM1_DTSEC2) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC2) ==
-		FSL_CORENET_RCWSR11_EC2_FM1_DTSEC2))
-		return PHY_INTERFACE_MODE_RGMII;
-
-	if ((port == FM2_DTSEC1) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC2) ==
-		FSL_CORENET_RCWSR11_EC2_FM2_DTSEC1))
-		return PHY_INTERFACE_MODE_RGMII;
-
-	switch (port) {
-	case FM1_DTSEC1:
-	case FM1_DTSEC2:
-	case FM1_DTSEC3:
-	case FM1_DTSEC4:
-		if (is_serdes_configured(SGMII_FM1_DTSEC1 + port - FM1_DTSEC1))
-			return PHY_INTERFACE_MODE_SGMII;
-		break;
-	case FM2_DTSEC1:
-	case FM2_DTSEC2:
-	case FM2_DTSEC3:
-	case FM2_DTSEC4:
-		if (is_serdes_configured(SGMII_FM2_DTSEC1 + port - FM2_DTSEC1))
-			return PHY_INTERFACE_MODE_SGMII;
-		break;
-	default:
-		return PHY_INTERFACE_MODE_NA;
-	}
-
-	return PHY_INTERFACE_MODE_NA;
-}
diff --git a/drivers/pci/pcie_fsl.c b/drivers/pci/pcie_fsl.c
index 18af23c9504..8d634b42373 100644
--- a/drivers/pci/pcie_fsl.c
+++ b/drivers/pci/pcie_fsl.c
@@ -12,7 +12,6 @@
 #include <mapmem.h>
 #include <pci.h>
 #include <asm/fsl_pci.h>
-#include <asm/fsl_serdes.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -474,28 +473,6 @@ static int fsl_pcie_init_port(struct fsl_pcie *pcie)
 	}
 #endif
 
-#ifdef CONFIG_SYS_P4080_ERRATUM_PCIE_A003
-	if (!fsl_pcie_link_up(pcie)) {
-		serdes_corenet_t *srds_regs;
-
-		srds_regs = (void *)CFG_SYS_FSL_CORENET_SERDES_ADDR;
-		val_32 = in_be32(&srds_regs->srdspccr0);
-
-		if ((val_32 >> 28) == 3) {
-			int i;
-
-			out_be32(&srds_regs->srdspccr0, 2 << 28);
-			setbits_be32(&regs->pdb_stat, 0x08000000);
-			in_be32(&regs->pdb_stat);
-			udelay(100);
-			clrbits_be32(&regs->pdb_stat, 0x08000000);
-			asm("sync;isync");
-			for (i = 0; i < 100 && !fsl_pcie_link_up(pcie); i++)
-				udelay(1000);
-		}
-	}
-#endif
-
 	/*
 	 * The Read-Only Write Enable bit defaults to 1 instead of 0.
 	 * Set to 0 to protect the read-only registers.
diff --git a/drivers/usb/common/fsl-errata.c b/drivers/usb/common/fsl-errata.c
index e2f0563e33c..b6fc8182092 100644
--- a/drivers/usb/common/fsl-errata.c
+++ b/drivers/usb/common/fsl-errata.c
@@ -111,8 +111,6 @@ bool has_erratum_a007075(void)
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0);
 	case SVR_P1010:
 		return IS_SVR_REV(svr, 1, 0);
-	case SVR_P4080:
-		return IS_SVR_REV(svr, 2, 0) || IS_SVR_REV(svr, 3, 0);
 #endif
 	}
 	return false;
@@ -191,8 +189,6 @@ bool has_erratum_a004477(void)
 	case SVR_B4860:
 	case SVR_B4420:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0);
-	case SVR_P4080:
-		return IS_SVR_REV(svr, 2, 0) || IS_SVR_REV(svr, 3, 0);
 #endif
 	}
 
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6bbed9cb513..ce560a95681 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -309,7 +309,7 @@ config USB_EHCI_FSL
 	depends on PPC
 	select EHCI_HCD_INIT_AFTER_RESET
 	select SYS_FSL_USB_INTERNAL_UTMI_PHY if MPC85xx && \
-		!(ARCH_B4860 || ARCH_B4420 || ARCH_P4080 || ARCH_P1020 || ARCH_P2020)
+		!(ARCH_B4860 || ARCH_B4420 || ARCH_P1020 || ARCH_P2020)
 	help
 	  Enables support for the on-chip EHCI controller on FSL chips.
 
-- 
2.47.3

