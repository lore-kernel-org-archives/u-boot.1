Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ED8606BF24
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pl1BE2bP;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=ALKvHe5G;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Xo3nUyQG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2BA560A6C;
	Wed, 21 Oct 2026 16:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BIxxbeiFPj5C; Wed, 21 Oct 2026 16:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 744BD60ACD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599409;
	b=TXVNd3bQ19wh0ZRaNQEZ6fubY0Y4LC0kX4qCdBzDl8ayiYwIZiZ6Xw0PkwCu/NatLWNv
	 8ZPl69ZLUgY03/gxtGa5m6SWV+NgOweoOUiJb+raT7QO7JG54l0XSj3+9YY61bWV3EDUa
	 U4Ai26Olpsnz15izpEHWtW8T2AnrsiLrHYBrJVYp5/M3eR0iRu3PqR1Cn9+9iU2pxmlGg
	 nSfuG5ob1riozwyNMpLXz6XJwnkJdrg1uwquUF7sEx/o7GZLa/PC+CnJwiofCorop3lll
	 hkVfvBiccgE1lLIpbAj69OGHFfoDby3CXGG+qSP+Blnh0gEzhEr897t1pyBi1n+TrFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iSsllRR74YZCz4FKvmMwt6KgVMF17J+zCrtQSnAa78E=;
	b=oVSW+SiaNsUayWIFJgwC8VQWKPShGkOMgBSlT3KQIQYvp/dbDh3/t5w8iVcjXvutnG/N
	 z3VxILPBNC+a+KJaCPpzROcrIz+TBR5B1OpUtKIEuFh+v4foBgLE/Qden9aPKCtUq1eRQ
	 038v9c2KOMprcLhC75F6DKImogjsVlwDx8l3m4jdiJE94/Vkp0u+k6GDDmMTEdJHRF7Zs
	 Vu9wH120aGHR3OJAJx17OD/gbfru0PojTRK9yl6lWigzNFwgf4+gmhyF7NXUecRYiC96h
	 zhKGkPM0ObXEb7865sD9wtiw3pkBwA5lTfgQWtMwyrGqVsAxKlDoeA4xqnoRMW+CbCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599409;
	bh=iSsllRR74YZCz4FKvmMwt6KgVMF17J+zCrtQSnAa78E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pl1BE2bPdOVNa3RCUFe6gF/H48xPxOszSZNH9a3wwX2xgRFAk7g1KhSs+04gASS4n
	 hXDC8KdoJTi5HCMTgjDpr7e/xZEW9ADCszLWKO7uh+uRWfbFJ0vnYFWSG3nwAmIA1B
	 2tNRI9/gJZz1htnH3P8EF2JOl8GsFPHlBhPZjjb/hDYTxFwsDjnJKikMWdSppyn2R5
	 zARWOXsw+gvbnp5IcN0sxA5uxUTY/HvF/N1l+i2vYxAjcSGpZX2DrAFPfPSqMVoUIG
	 sT71rmBYckNPBi+YH+OO8bjd7qYwSl8XM1BCDdjp82gFWa+2ahtdKYnAQytclkbnjD
	 ha+pcq9qYV/Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 744BD60ACD;
	Wed, 21 Oct 2026 16:16:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 722D21E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 574C8811A1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id lPkxMUMYEW03 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E66C81103
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598520;
 b=sbMWkrSZCH+DL8ezRLYCv2FWlz/n3J4MZufV0wJw7L3FHFogk79KaEJhwvZ6NhXvWxBW
 Rtvq+rVmAfh8h2KuWZ7joPQtzzZVL4xUag8y5IDEY60x3M60q2WqiF+a7AI2kOWiS2sm+
 EUfUX51pkI3eHhIUqQFuqej5tES97ES+C/7CTo/GpvYZ5fYwm+9vbL4IPJVd0xGIsBPA7
 63EcyRLewRU6uNHhXS57eqLnjKn6YW/F2hr6JLMx4iOjFULuLRUoyEXn7lw6b0JVTdeSX
 LNe2CnrXGUZgTd/5i8Vws2DBQy1RI4PMHSK/XXPYR4YmcdL1bfIoudIpHRjLwCX/wSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598520;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iSsllRR74YZCz4FKvmMwt6KgVMF17J+zCrtQSnAa78E=;
 b=NtUW1gBoROSsJRUGIkeGswvDUnMX9hBCnHPKnPySHcLNViYDhF394Fvczy134TaMiTem
 y9T0/7yb98HUI+99+mlh+6gv/mdjzZuoAaXerH1WIq1BLh4EI78/dYWLSo6dz7yz98lNl
 vQ+xhLQGAT46DdZ2ZgmKMv9TOQ5AhLRALoFutLZVxlqAunvUUD8KtU12C+83syPqKl+QP
 0sA6kgn/eWCz9M/VPqRvhUPXRSntzlGn8XcCFO0LO9D3Ka0jQ+xOUwop7t2hHZ60UenHN
 uTjBMHTAHSZdewQ4fBAxqmUFAtDi+5ZNle+NtOhzb0BdkALd09baFYSSkrYCZ5kXrRA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=ALKvHe5G; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Xo3nUyQG; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=ALKvHe5G; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Xo3nUyQG
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 5E66C81103
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598509; bh=iSsllRR74YZCz4FKvmMwt6K
 gVMF17J+zCrtQSnAa78E=; b=ALKvHe5GdwBir7QEZTUq48OUpvenS8zQnj1MdmcFgjnqUPaS0Q
 OAVNfuu9lYsWQpDpzc8C5PhQEknDPc5o5Sr+EdLR/PuGicd255U6FEiJymYzaMHkjha3W1oo0/3
 8FoXKVzMqBSdsxoj6fDH5sdDFnIz5k11OTMJaTV4wyZ4fzYE0NyZ1UG4w7jB/buV9RszQYtFgmY
 GH9/NsklRdwhv2O93jawNL0p8AsZ/sc5U+UCY9pHEXVESMoMQGTdSrW8nIXXZSvmdQLPJGdq8S3
 yCroFbQTjFt+LjJ0nYZplo5hztLq5G2Dnq6iwkb99lFDCSZ4u9oclg1yVw9iATklbUg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598509; bh=iSsllRR74YZCz4FKvmMwt6K
 gVMF17J+zCrtQSnAa78E=; b=Xo3nUyQGA8y4WoHDVKekUso1CJ68In6e2mhUvd5cDtqd45/TFs
 cZFQ8ppwiNxs4Gsg5SKCaNTcVcoWd8GmeACA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v3 10/26] powerpc: mpc85xx: Remove P5040 support
Date: Wed, 21 Oct 2026 16:01:06 +0000
Message-ID: <20261021160145.10430-11-brads@mainlining.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The P5040DS was the last user in the tree of ARCH_P5040. With that
board removed, nothing selects the option now.

Drop its unmaintained SoC specific FM, SERDES and errata support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig.nxp                              |   2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig              |  42 +------
 arch/powerpc/cpu/mpc85xx/Makefile             |   2 -
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c |  65 ----------
 arch/powerpc/cpu/mpc85xx/p5040_ids.c          | 111 ------------------
 arch/powerpc/cpu/mpc85xx/p5040_serdes.c       |  99 ----------------
 arch/powerpc/cpu/mpc8xxx/cpu.c                |   1 -
 arch/powerpc/include/asm/config_mpc85xx.h     |   9 --
 arch/powerpc/include/asm/immap_85xx.h         |  12 --
 arch/powerpc/include/asm/processor.h          |   1 -
 doc/README.pblimage                           |   6 +-
 drivers/ddr/fsl/Kconfig                       |   1 -
 drivers/net/Kconfig                           |   1 -
 drivers/net/fm/Makefile                       |   1 -
 drivers/net/fm/p5040.c                        | 106 -----------------
 drivers/usb/common/fsl-errata.c               |   4 -
 16 files changed, 6 insertions(+), 457 deletions(-)
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_ids.c
 delete mode 100644 arch/powerpc/cpu/mpc85xx/p5040_serdes.c
 delete mode 100644 drivers/net/fm/p5040.c

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 6b1ad1795fa..8b8210224b5 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -5,7 +5,7 @@ config FSL_TRUST_ARCH_v1
 
 config NXP_ESBC
 	bool "NXP ESBC (secure boot) functionality"
-	select FSL_TRUST_ARCH_v1 if ARCH_P5040 || ARCH_P2041
+	select FSL_TRUST_ARCH_v1 if ARCH_P2041
 	help
 	  Enable Freescale Secure Boot feature. Normally selected by defconfig.
 	  If unsure, do not change.
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 252666cab5f..32461cfae50 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -584,37 +584,6 @@ config ARCH_P2041
 	select FSL_ELBC
 	imply CMD_NAND
 
-config ARCH_P5040
-	bool
-	select BACKSIDE_L2_CACHE
-	select E500MC
-	select FSL_CORENET
-	select FSL_LAW
-	select SYS_CACHE_SHIFT_6
-	select SYS_FSL_DDR_VER_44
-	select SYS_FSL_ERRATUM_A004510
-	select SYS_FSL_ERRATUM_A004699
-	select SYS_FSL_ERRATUM_A005275
-	select SYS_FSL_ERRATUM_A005812
-	select SYS_FSL_ERRATUM_A006261
-	select SYS_FSL_ERRATUM_DDR_A003
-	select SYS_FSL_ERRATUM_DDR_A003474
-	select SYS_FSL_ERRATUM_ESDHC111
-	select SYS_FSL_ERRATUM_USB14
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_QORIQ_CHASSIS1
-	select SYS_FSL_PCIE_COMPAT_QORIQ_PCIE_v24
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_4
-	select SYS_FSL_USB1_PHY_ENABLE
-	select SYS_FSL_USB2_PHY_ENABLE
-	select SYS_PPC64
-	select FSL_ELBC
-	imply SATA
-	imply CMD_REGINFO
-	imply FSL_SATA
-
 config ARCH_QEMU_E500
 	bool
 	select SYS_CACHE_SHIFT_5
@@ -850,7 +819,6 @@ config MAX_CPUS
 	default 12 if ARCH_T4240
 	default 4 if ARCH_B4860 || \
 		     ARCH_P2041 || \
-		     ARCH_P5040 || \
 		     ARCH_T1040 || \
 		     ARCH_T1042 || \
 		     ARCH_T2080
@@ -891,7 +859,6 @@ config SYS_CCSRBAR_DEFAULT
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
 				ARCH_P2041	|| \
-				ARCH_P5040	|| \
 				ARCH_T1024	|| \
 				ARCH_T1040	|| \
 				ARCH_T1042	|| \
@@ -937,9 +904,6 @@ config SYS_FSL_ERRATUM_A004508
 config SYS_FSL_ERRATUM_A004580
 	bool
 
-config SYS_FSL_ERRATUM_A004699
-	bool
-
 config SYS_FSL_ERRATUM_A004849
 	bool
 
@@ -1086,7 +1050,6 @@ config SYS_FSL_NUM_LAWS
 	default 32 if	ARCH_B4420	|| \
 			ARCH_B4860	|| \
 			ARCH_P2041	|| \
-			ARCH_P5040	|| \
 			ARCH_T2080	|| \
 			ARCH_T4240
 	default 16 if	ARCH_T1024	|| \
@@ -1248,8 +1211,7 @@ config SYS_FSL_LBC_CLK_DIV
 	depends on FSL_ELBC || ARCH_MPC8540 || \
 		ARCH_MPC8560
 
-	default 2 if	ARCH_P2041	|| \
-			ARCH_P5040
+	default 2 if	ARCH_P2041
 	default 1
 
 	help
@@ -1307,7 +1269,7 @@ config SYS_FSL_SRIO_LIODN
 config SYS_FSL_TBCLK_DIV
 	int
 	default 32 if ARCH_P2041
-	default 16 if ARCH_P5040 || ARCH_T4240 || ARCH_B4860 || \
+	default 16 if ARCH_T4240 || ARCH_B4860 || \
 			ARCH_B4420 || ARCH_T1040 || ARCH_T1042 || \
 			ARCH_T1024 || ARCH_T2080
 	default 8
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index a3622d60b16..b4bca7bbe6b 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_SYS_DPAA_QBMAN) += portals.o
 
 # various SoC specific assignments
 obj-$(CONFIG_ARCH_P2041) += p2041_ids.o
-obj-$(CONFIG_ARCH_P5040) += p5040_ids.o
 obj-$(CONFIG_ARCH_T4240) += t4240_ids.o
 obj-$(CONFIG_ARCH_B4420) += b4860_ids.o
 obj-$(CONFIG_ARCH_B4860) += b4860_ids.o
@@ -64,7 +63,6 @@ obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
 obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
-obj-$(CONFIG_ARCH_P5040) += p5040_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
 obj-$(CONFIG_ARCH_B4420) += b4860_serdes.o
 obj-$(CONFIG_ARCH_B4860) += b4860_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
index 0a66f376f86..3f73a46c282 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
@@ -152,9 +152,6 @@ void fsl_serdes_init(void)
 	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
 	int cfg;
 	serdes_corenet_t *srds_regs;
-#ifdef CONFIG_ARCH_P5040
-	serdes_corenet_t *srds2_regs;
-#endif
 	int lane, bank, idx;
 	int have_bank[SRDS_MAX_BANK] = {};
 	if (serdes_prtcl_map & (1 << NONE))
@@ -181,34 +178,6 @@ void fsl_serdes_init(void)
 		}
 	}
 
-#ifdef CONFIG_ARCH_P5040
-	/*
-	 * Lanes on bank 4 on P5040 are commented-out, but for some SERDES
-	 * protocols, these lanes are routed to SATA.  We use serdes_prtcl_map
-	 * to decide whether a protocol is supported on a given lane, so SATA
-	 * will be identified as not supported, and therefore not initialized.
-	 * So for protocols which use SATA on bank4, we add SATA support in
-	 * serdes_prtcl_map.
-	 */
-	switch (cfg) {
-	case 0x0:
-	case 0x1:
-	case 0x2:
-	case 0x3:
-	case 0x4:
-	case 0x5:
-	case 0x6:
-	case 0x7:
-		serdes_prtcl_map |= 1 << SATA1 | 1 << SATA2;
-		break;
-	default:
-		srds2_regs = (void *)CFG_SYS_FSL_CORENET_SERDES2_ADDR;
-
-		/* We don't need bank 4, so power it down */
-		setbits_be32(&srds2_regs->bank[0].rstctl, SRDS_RSTCTL_SDPD);
-	}
-#endif
-
 	soc_serdes_init();
 
 	/* Set the first bit to indicate serdes has been initialized */
@@ -224,40 +193,6 @@ void fsl_serdes_init(void)
 		}
 	}
 
-#ifdef CONFIG_SYS_FSL_ERRATUM_A004699
-	/*
-	 * To avoid the situation that resulted in the P4080 erratum
-	 * SERDES-8, a given SerDes bank will use the PLLs from the previous
-	 * bank if one of the PLL frequencies is a multiple of the other.  For
-	 * instance, if bank 3 is running at 2.5GHz and bank 2 is at 1.25GHz,
-	 * then bank 3 will use bank 2's PLL.  P5040 Erratum A-004699 says
-	 * that, in this situation, lane synchronization is not initiated.  So
-	 * when we detect a bank with a "borrowed" PLL, we have to manually
-	 * initiate lane synchronization.
-	 */
-	for (bank = FSL_SRDS_BANK_2; bank <= FSL_SRDS_BANK_3; bank++) {
-		/* Determine the first lane for this bank */
-		unsigned int lane;
-
-		for (lane = 0; lane < SRDS_MAX_LANES; lane++)
-			if (lanes[lane].bank == bank)
-				break;
-		idx = lanes[lane].idx;
-
-		/*
-		 * Check if the PLL for the bank is borrowed.  The UOTHL
-		 * bit of the first lane will tell us that.
-		 */
-		if (in_be32(&srds_regs->lane[idx].gcr0) & SRDS_GCR0_UOTHL) {
-			/* Manually start lane synchronization */
-			setbits_be32(&srds_regs->bank[bank].pllcr0,
-				     SRDS_PLLCR0_PVCOCNT_EN);
-		}
-	}
-#endif
-
-
-
 	for (idx = 0; idx < SRDS_MAX_BANK; idx++) {
 		bank = idx;
 
diff --git a/arch/powerpc/cpu/mpc85xx/p5040_ids.c b/arch/powerpc/cpu/mpc85xx/p5040_ids.c
deleted file mode 100644
index 0a34e066e94..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p5040_ids.c
+++ /dev/null
@@ -1,111 +0,0 @@
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
-	SET_QP_INFO(1, 2, 1, 0),
-	SET_QP_INFO(3, 4, 2, 1),
-	SET_QP_INFO(5, 6, 3, 2),
-	SET_QP_INFO(7, 8, 4, 3),
-	SET_QP_INFO(9, 10, 5, 0),
-	SET_QP_INFO(11, 12, 6, 1),
-	SET_QP_INFO(13, 14, 7, 2),
-	SET_QP_INFO(15, 16, 8, 3),
-	SET_QP_INFO(17, 18, 9, 0),	/* for now, set sdest to 0 */
-	SET_QP_INFO(19, 20, 10, 0),	/* for now, set sdest to 0 */
-};
-#endif
-
-struct liodn_id_table liodn_tbl[] = {
-#ifdef CONFIG_SYS_DPAA_QBMAN
-	SET_QMAN_LIODN(31),
-	SET_BMAN_LIODN(32),
-#endif
-
-	SET_SDHC_LIODN(1, 64),
-
-	SET_USB_LIODN(1, "fsl-usb2-mph", 93),
-	SET_USB_LIODN(2, "fsl-usb2-dr", 94),
-
-	SET_SATA_LIODN(1, 95),
-	SET_SATA_LIODN(2, 96),
-
-	SET_PCI_LIODN_BASE(CONFIG_SYS_FSL_PCIE_COMPAT, 1, 195),
-	SET_PCI_LIODN_BASE(CONFIG_SYS_FSL_PCIE_COMPAT, 2, 196),
-	SET_PCI_LIODN_BASE(CONFIG_SYS_FSL_PCIE_COMPAT, 3, 197),
-
-	SET_DMA_LIODN(1, "fsl,eloplus-dma", 193),
-	SET_DMA_LIODN(2, "fsl,eloplus-dma", 194),
-};
-int liodn_tbl_sz = ARRAY_SIZE(liodn_tbl);
-
-#ifdef CONFIG_SYS_DPAA_FMAN
-struct fman_liodn_id_table fman1_liodn_tbl[] = {
-	SET_FMAN_RX_1G_LIODN(1, 0, 11),
-	SET_FMAN_RX_1G_LIODN(1, 1, 12),
-	SET_FMAN_RX_1G_LIODN(1, 2, 13),
-	SET_FMAN_RX_1G_LIODN(1, 3, 14),
-	SET_FMAN_RX_1G_LIODN(1, 4, 15),
-	SET_FMAN_RX_10G_LIODN(1, 0, 16),
-};
-int fman1_liodn_tbl_sz = ARRAY_SIZE(fman1_liodn_tbl);
-
-#if (CFG_SYS_NUM_FMAN == 2)
-struct fman_liodn_id_table fman2_liodn_tbl[] = {
-	SET_FMAN_RX_1G_LIODN(2, 0, 17),
-	SET_FMAN_RX_1G_LIODN(2, 1, 18),
-	SET_FMAN_RX_1G_LIODN(2, 2, 19),
-	SET_FMAN_RX_1G_LIODN(2, 3, 20),
-	SET_FMAN_RX_1G_LIODN(2, 4, 21),
-	SET_FMAN_RX_10G_LIODN(2, 0, 22),
-};
-int fman2_liodn_tbl_sz = ARRAY_SIZE(fman2_liodn_tbl);
-#endif
-#endif
-
-struct liodn_id_table sec_liodn_tbl[] = {
-	SET_SEC_JR_LIODN_ENTRY(0, 129, 130),
-	SET_SEC_JR_LIODN_ENTRY(1, 131, 132),
-	SET_SEC_JR_LIODN_ENTRY(2, 133, 134),
-	SET_SEC_JR_LIODN_ENTRY(3, 135, 136),
-	SET_SEC_RTIC_LIODN_ENTRY(a, 89),
-	SET_SEC_RTIC_LIODN_ENTRY(b, 90),
-	SET_SEC_RTIC_LIODN_ENTRY(c, 91),
-	SET_SEC_RTIC_LIODN_ENTRY(d, 92),
-	SET_SEC_DECO_LIODN_ENTRY(0, 139, 140),
-	SET_SEC_DECO_LIODN_ENTRY(1, 141, 142),
-	SET_SEC_DECO_LIODN_ENTRY(2, 143, 144),
-	SET_SEC_DECO_LIODN_ENTRY(3, 145, 146),
-};
-int sec_liodn_tbl_sz = ARRAY_SIZE(sec_liodn_tbl);
-
-#ifdef CONFIG_SYS_FSL_RAID_ENGINE
-struct liodn_id_table raide_liodn_tbl[] = {
-	SET_RAID_ENGINE_JQ_LIODN_ENTRY(0, 0, 60),
-	SET_RAID_ENGINE_JQ_LIODN_ENTRY(0, 1, 61),
-	SET_RAID_ENGINE_JQ_LIODN_ENTRY(1, 0, 62),
-	SET_RAID_ENGINE_JQ_LIODN_ENTRY(1, 1, 63),
-};
-int raide_liodn_tbl_sz = ARRAY_SIZE(raide_liodn_tbl);
-#endif
-
-struct liodn_id_table liodn_bases[] = {
-	[FSL_HW_PORTAL_SEC]  = SET_LIODN_BASE_2(64, 101),
-#ifdef CONFIG_SYS_DPAA_FMAN
-	[FSL_HW_PORTAL_FMAN1] = SET_LIODN_BASE_1(32),
-#endif
-#if (CFG_SYS_NUM_FMAN == 2)
-	[FSL_HW_PORTAL_FMAN2] = SET_LIODN_BASE_1(160),
-#endif
-#ifdef CONFIG_SYS_FSL_RAID_ENGINE
-	[FSL_HW_PORTAL_RAID_ENGINE]  = SET_LIODN_BASE_1(49),
-#endif
-};
diff --git a/arch/powerpc/cpu/mpc85xx/p5040_serdes.c b/arch/powerpc/cpu/mpc85xx/p5040_serdes.c
deleted file mode 100644
index 409f2ac938d..00000000000
--- a/arch/powerpc/cpu/mpc85xx/p5040_serdes.c
+++ /dev/null
@@ -1,99 +0,0 @@
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
-/*
- * Note: For P5040, the fourth SerDes bank (with two lanes) is on SerDes2, but
- * U-Boot only supports one SerDes controller.  Therefore, we ignore bank 4 in
- * this table.  This works because most of the SerDes code is for errata
- * work-arounds, and there are no P5040 errata that effect bank 4.
- */
-
-static u8 serdes_cfg_tbl[][SRDS_MAX_LANES] = {
-	[0x00] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4,
-		XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2, /* SATA1, SATA2, */ },
-	[0x01] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		SGMII_FM1_DTSEC3, SGMII_FM2_DTSEC4, XAUI_FM1, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, /* SATA1, SATA2 */ },
-	[0x02] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, XAUI_FM2, /* SATA1, SATA2 */ },
-	[0x03] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, SGMII_FM2_DTSEC1,
-		SGMII_FM2_DTSEC2, SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4,
-		SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		/* SATA1, SATA2 */ },
-	[0x04] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE3, SGMII_FM2_DTSEC1,
-		SGMII_FM2_DTSEC2, SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4,
-		SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		/* SATA1, SATA2 */ },
-	[0x05] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE3, SGMII_FM1_DTSEC3,
-		SGMII_FM1_DTSEC4, SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, XAUI_FM2, /* SATA1, SATA2 */ },
-	[0x06] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1,
-		SGMII_FM2_DTSEC3, SGMII_FM2_DTSEC4, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4,
-		XAUI_FM2, XAUI_FM2, XAUI_FM2, XAUI_FM2, /* SATA1, SATA2 */ },
-	[0x07] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1, PCIE1,
-		SGMII_FM1_DTSEC3, SGMII_FM2_DTSEC4, XAUI_FM1, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, XAUI_FM2, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, /* SATA1, SATA2 */ },
-	[0x11] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, NONE, NONE, SATA1, SATA2,
-		/* NONE, NONE */ },
-	[0x15] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1,
-		NONE, NONE, SATA1, SATA2, /* NONE, NONE */ },
-	[0x2a] = {PCIE1, PCIE1, PCIE3, PCIE3, PCIE2, PCIE2, PCIE2, PCIE2,
-		AURORA, AURORA, SGMII_FM1_DTSEC1, SGMII_FM1_DTSEC2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, XAUI_FM2, XAUI_FM2,
-		XAUI_FM2, XAUI_FM2, /* NONE, NONE */ },
-	[0x34] = {PCIE1, PCIE1, PCIE1, PCIE1, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA,
-		AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE,
-		NONE, SATA1, SATA2, /* NONE, NONE */ },
-	[0x35] = {PCIE1, PCIE1, PCIE1, PCIE1, PCIE2, PCIE2,
-		SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA, AURORA, XAUI_FM1,
-		XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE, NONE, SATA1, SATA2,
-		/* NONE, NONE */ },
-	[0x36] = {PCIE1, PCIE1, PCIE3, PCIE3, SGMII_FM1_DTSEC1,
-		SGMII_FM1_DTSEC2, SGMII_FM1_DTSEC3, SGMII_FM1_DTSEC4, AURORA,
-		AURORA, XAUI_FM1, XAUI_FM1, XAUI_FM1, XAUI_FM1, NONE,
-		NONE, SATA1, SATA2, /* NONE, NONE */ },
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
-int is_serdes_prtcl_valid(u32 prtcl)
-{
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
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 8b575e85347..47daf51fc1b 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -60,7 +60,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P5010, P5010, 1),
 	CPU_TYPE_ENTRY(P5020, P5020, 2),
 	CPU_TYPE_ENTRY(P5021, P5021, 2),
-	CPU_TYPE_ENTRY(P5040, P5040, 4),
 	CPU_TYPE_ENTRY(T4240, T4240, 0),
 	CPU_TYPE_ENTRY(T4120, T4120, 0),
 	CPU_TYPE_ENTRY(T4160, T4160, 0),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index 3701f29daa0..e5890376df8 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -44,15 +44,6 @@
 #define CFG_SYS_FSL_SRIO_IB_WIN_NUM	5
 #define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xf0000000
 
-#elif defined(CONFIG_ARCH_P5040)
-#define CFG_SYS_NUM_FMAN		2
-#define CFG_SYS_NUM_FM1_DTSEC	5
-#define CFG_SYS_NUM_FM1_10GEC	1
-#define CFG_SYS_NUM_FM2_DTSEC	5
-#define CFG_SYS_NUM_FM2_10GEC	1
-#define CFG_SYS_FM_MURAM_SIZE	0x28000
-#define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xf0000000
-
 #elif defined(CONFIG_ARCH_T4240)
 #ifdef CONFIG_ARCH_T4240
 #define CFG_SYS_FSL_CLUSTER_CLOCKS   { 1, 1, 4 }
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index de1ae25440c..a9336d73f20 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -1521,15 +1521,6 @@ typedef struct ccsr_gur {
 #define FSL_CORENET_RCWSR11_EC2_FM1_DTSEC5_MII		0x00100000
 #define FSL_CORENET_RCWSR11_EC2_FM1_DTSEC5_NONE		0x00180000
 #endif
-#if defined(CONFIG_ARCH_P5040)
-#define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC5_RGMII        0x00000000
-#define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC5_MII          0x00800000
-#define FSL_CORENET_RCWSR11_EC1_FM1_DTSEC5_NONE         0x00c00000
-#define FSL_CORENET_RCWSR11_EC2                 0x00180000 /* bits 363..364 */
-#define FSL_CORENET_RCWSR11_EC2_FM2_DTSEC5_RGMII        0x00000000
-#define FSL_CORENET_RCWSR11_EC2_FM2_DTSEC5_MII          0x00100000
-#define FSL_CORENET_RCWSR11_EC2_FM2_DTSEC5_NONE         0x00180000
-#endif
 #if defined(CONFIG_ARCH_T4240)
 #define FSL_CORENET_RCWSR13_EC1			0x60000000 /* bits 417..418 */
 #define FSL_CORENET_RCWSR13_EC1_FM2_DTSEC5_RGMII	0x00000000
@@ -2433,7 +2424,6 @@ struct ccsr_pman {
 #define CFG_SYS_SFP_OFFSET                   0xE8000
 #endif
 #define CFG_SYS_FSL_CORENET_SERDES_OFFSET	0xEA000
-#define CFG_SYS_FSL_CORENET_SERDES2_OFFSET	0xEB000
 #define CFG_SYS_FSL_CORENET_SERDES3_OFFSET	0xEC000
 #define CFG_SYS_FSL_CORENET_SERDES4_OFFSET	0xED000
 #define CFG_SYS_FSL_CPC_OFFSET		0x10000
@@ -2608,8 +2598,6 @@ struct ccsr_pman {
 	(CONFIG_SYS_IMMR + CFG_SYS_MPC85xx_SERDES2_OFFSET)
 #define CFG_SYS_FSL_CORENET_SERDES_ADDR \
 	(CONFIG_SYS_IMMR + CFG_SYS_FSL_CORENET_SERDES_OFFSET)
-#define CFG_SYS_FSL_CORENET_SERDES2_ADDR \
-	(CONFIG_SYS_IMMR + CFG_SYS_FSL_CORENET_SERDES2_OFFSET)
 #define CFG_SYS_FSL_CORENET_SERDES3_ADDR \
 	(CONFIG_SYS_IMMR + CFG_SYS_FSL_CORENET_SERDES3_OFFSET)
 #define CFG_SYS_FSL_CORENET_SERDES4_ADDR \
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1ddbf15c410..306dfd01346 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1052,7 +1052,6 @@
 #define SVR_P5010	0x822100
 #define SVR_P5020	0x822000
 #define SVR_P5021	0x820500
-#define SVR_P5040	0x820400
 #define SVR_T4240	0x824000
 #define SVR_T4120	0x824001
 #define SVR_T4160	0x824100
diff --git a/doc/README.pblimage b/doc/README.pblimage
index f4bdadfb2dd..66dc9cb0922 100644
--- a/doc/README.pblimage
+++ b/doc/README.pblimage
@@ -14,15 +14,15 @@ Building PBL Boot Image and boot steps
 1. Building PBL Boot Image.
    The default Image is u-boot.pbl.
 
-   For eSPI boot(available on P2041/P5020/P5040/T4240):
+   For eSPI boot(available on P2041/P5020/T4240):
 	To build the eSPI boot image:
 	make <board_name>_SPIFLASH
 
-   For SD boot(available on P2041/P5020/P5040/T4240):
+   For SD boot(available on P2041/P5020/T4240):
 	To build the SD boot image:
 	make <board_name>_SDCARD
 
-   For Nand boot(available on P2041/P5020/P5040):
+   For Nand boot(available on P2041/P5020):
 	To build the NAND boot image:
 	make <board_name>_NAND
 
diff --git a/drivers/ddr/fsl/Kconfig b/drivers/ddr/fsl/Kconfig
index c518704d93e..91b439428ab 100644
--- a/drivers/ddr/fsl/Kconfig
+++ b/drivers/ddr/fsl/Kconfig
@@ -52,7 +52,6 @@ config SYS_NUM_DDR_CTLRS
 			ARCH_T4240
 	default 2 if	ARCH_B4860	|| \
 			ARCH_BSC9132	|| \
-			ARCH_P5040	|| \
 			ARCH_LX2160A	|| \
 			ARCH_LX2162A
 	default 1
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index df243e8fe9b..b4224c24040 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -969,7 +969,6 @@ config SYS_DPAA_QBMAN
 		     ARCH_T1042 || \
 		     ARCH_T2080 || \
 		     ARCH_T4240 || \
-		     ARCH_P5040 || \
 		     ARCH_LS1043A || \
 		     ARCH_LS1046A
 	help
diff --git a/drivers/net/fm/Makefile b/drivers/net/fm/Makefile
index e6727eeec98..6ec673feec4 100644
--- a/drivers/net/fm/Makefile
+++ b/drivers/net/fm/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_SYS_FMAN_V3) += memac.o
 obj-$(CONFIG_ARCH_P1023)	+= p1023.o
 # The P204x and P5020 are the same
 obj-$(CONFIG_ARCH_P2041) += p5020.o
-obj-$(CONFIG_ARCH_P5040) += p5040.o
 obj-$(CONFIG_ARCH_T1040) += t1040.o
 obj-$(CONFIG_ARCH_T1042)	+= t1040.o
 obj-$(CONFIG_ARCH_T1024) += t1024.o
diff --git a/drivers/net/fm/p5040.c b/drivers/net/fm/p5040.c
deleted file mode 100644
index f6ae947ef99..00000000000
--- a/drivers/net/fm/p5040.c
+++ /dev/null
@@ -1,106 +0,0 @@
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
-u32 port_to_devdisr[] = {
-	[FM1_DTSEC1] = FSL_CORENET_DEVDISR2_DTSEC1_1,
-	[FM1_DTSEC2] = FSL_CORENET_DEVDISR2_DTSEC1_2,
-	[FM1_DTSEC3] = FSL_CORENET_DEVDISR2_DTSEC1_3,
-	[FM1_DTSEC4] = FSL_CORENET_DEVDISR2_DTSEC1_4,
-	[FM1_DTSEC5] = FSL_CORENET_DEVDISR2_DTSEC1_5,
-	[FM1_10GEC1] = FSL_CORENET_DEVDISR2_10GEC1,
-	[FM2_DTSEC1] = FSL_CORENET_DEVDISR2_DTSEC2_1,
-	[FM2_DTSEC2] = FSL_CORENET_DEVDISR2_DTSEC2_2,
-	[FM2_DTSEC3] = FSL_CORENET_DEVDISR2_DTSEC2_3,
-	[FM2_DTSEC4] = FSL_CORENET_DEVDISR2_DTSEC2_4,
-	[FM2_DTSEC5] = FSL_CORENET_DEVDISR2_DTSEC2_5,
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
-	if ((port == FM1_DTSEC5) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC1) ==
-		FSL_CORENET_RCWSR11_EC1_FM1_DTSEC5_RGMII))
-		return PHY_INTERFACE_MODE_RGMII;
-
-	if ((port == FM1_DTSEC5) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC1) ==
-		FSL_CORENET_RCWSR11_EC1_FM1_DTSEC5_MII))
-		return PHY_INTERFACE_MODE_MII;
-
-	if ((port == FM2_DTSEC5) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC2) ==
-		FSL_CORENET_RCWSR11_EC2_FM2_DTSEC5_RGMII))
-		return PHY_INTERFACE_MODE_RGMII;
-
-	if ((port == FM2_DTSEC5) && ((rcwsr11 & FSL_CORENET_RCWSR11_EC2) ==
-		FSL_CORENET_RCWSR11_EC2_FM2_DTSEC5_MII))
-		return PHY_INTERFACE_MODE_MII;
-
-	switch (port) {
-	case FM1_DTSEC1:
-	case FM1_DTSEC2:
-	case FM1_DTSEC3:
-	case FM1_DTSEC4:
-	case FM1_DTSEC5:
-		if (is_serdes_configured(SGMII_FM1_DTSEC1 + port - FM1_DTSEC1))
-			return PHY_INTERFACE_MODE_SGMII;
-		break;
-	case FM2_DTSEC1:
-	case FM2_DTSEC2:
-	case FM2_DTSEC3:
-	case FM2_DTSEC4:
-	case FM2_DTSEC5:
-		if (is_serdes_configured(SGMII_FM2_DTSEC1 + port - FM2_DTSEC1))
-			return PHY_INTERFACE_MODE_SGMII;
-		break;
-	default:
-		return PHY_INTERFACE_MODE_NA;
-	}
-
-	return PHY_INTERFACE_MODE_NA;
-}
diff --git a/drivers/usb/common/fsl-errata.c b/drivers/usb/common/fsl-errata.c
index b6fc8182092..1b84614c8f5 100644
--- a/drivers/usb/common/fsl-errata.c
+++ b/drivers/usb/common/fsl-errata.c
@@ -61,7 +61,6 @@ bool has_erratum_a005275(void)
 	case SVR_P5020:
 	case SVR_P5021:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0);
-	case SVR_P5040:
 	case SVR_P1010:
 		return IS_SVR_REV(svr, 1, 0);
 #endif
@@ -90,9 +89,6 @@ bool has_erratum_a006261(void)
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0);
 	case SVR_T4240:
 		return IS_SVR_REV(svr, 1, 0) || IS_SVR_REV(svr, 2, 0);
-	case SVR_P5040:
-		return IS_SVR_REV(svr, 1, 0) ||
-			IS_SVR_REV(svr, 2, 0) || IS_SVR_REV(svr, 2, 1);
 #endif
 	}
 
-- 
2.47.3

