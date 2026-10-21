Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874C606A32F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AxfgxfT0;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=JwnAnGU1;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=PAAm7Bup
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F522811D9;
	Wed, 21 Oct 2026 16:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6oa3MsUjf1K; Wed, 21 Oct 2026 16:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33796811DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599379;
	b=jzUZwGRzWbju32Dxb/95+rgc9sVosNv05+e9l+EBZ6ldmvun708glMYsxMZ6dvTmcLNf
	 ZYUuMIw01iS9x2rHx1Kyf4VygFAu6J8BIQCj+sDbIvlpQRzH9HA+axO+5tTxttOxg1iIf
	 +lnS05IavB4t+ItlOGTZ807rBAYvFIOZVd4ZqqAQeyRKi7pVzfVPgFLLahaDJD2g/xgaJ
	 ikjrQL4hEEHQEPF6GYsA5Oy+jKovvD/LXL/V/NTSE84LatQEO3ueCg1DGuaiKxBD+FOq1
	 cblhsuX+F/CSfpmRU6JpqRQhcc2mQ8bSaWnbSQbA2p7xToNqQkAO4jrx/iY4unHB1rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4GczjhMt0ipkH2ViqPbMVrSeQbD/tFGBGtlDaHofEso=;
	b=aorYA+hW9ltKXSQRb/M9eoKtpQJgWPvGgRk/TgDmKtutP3NwrFFQ7d2c8P4xPoYv7lrJ
	 Jxu7fdUexyx9C73M9dmmHXa2slhMumNFmqBoK3qtPXqW9pyDCghPkKUOrpTA+YMIOkaCF
	 GfN1buxAHKBFwVq0GGVAC1iSw0SPRNBKGyaULXf7tenSHxuuFZJYqMpXTnOkroxlbIpCb
	 ETVKXPUdXMJKetLk7Shn8URJ65or80xbPwpV12l4hzSSDZTksWeVcM0eMc1+NdR2Br4F9
	 dGboxtMErtNek8QFQsUODB7Z/Khn+FwiyVQKVSIa6GTwHK2RHEoSsM4r7JRfCDcjlvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599379;
	bh=4GczjhMt0ipkH2ViqPbMVrSeQbD/tFGBGtlDaHofEso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AxfgxfT0ZqeR0Rsgh0fodQHbL7KCFmpXKXACzEXD0W8xScsm7xpzKR9ajvT8mqhOb
	 qfa90NBs+beLu0o6wiTlpeZiwmcGu54/w0s+KJu1AE0K1Db827vkgRiuocowyRuhST
	 5UDZpnfmGaXzvDo2TRkN5FFcJvG77CudijkVFV/4VLj64JM8lfrvkLnrnGo5L04V1F
	 PJuFcfd/wmbnh4fMz+DZAo+lukb/+9Y4I//BTIb7xgNYdytiAzqiHQAkPw3g/HFmxG
	 4X/j/oz0Fq4zlvCnkQ4dqjPFBExouMAXlkdKQEjbDT9KCshoKjsWbVUX9q7kx7h+Im
	 C2Rs+W6bAgYpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33796811DC;
	Wed, 21 Oct 2026 16:16:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id E831F1E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id D9E734084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id ZKCsuBTsRq4d for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 984ED40877
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598516;
 b=nCtMRBR87Tv2vmFPFKIvGB2lcrUdnLEm3wRR4RrRti2vK66FJkqcu1RUDvMMXKJVg4jW
 KGM47UXoQ8WbUDr70l3+cQYqdlNwVoNZAZT95i/hwyK2lC99xuaDM5z+A2Dug7TW3zfTR
 IXzi29deccbAPYPHrAUDUaoUwaJdEa4a9mwtIwP7/N6WsewJjDmCA5wS+m18Tpp/sdwWB
 Xz9tk73diBbQG25+fyy3RzRYw6ltPdjHJsPJyj0gyuX160kWCqPTXhahwArPZppP2ItXv
 ouL24v40nexS8dqrh32mwgAS4B7VtXinNECEELBrbe08j+hldei9AeEMeYVOXodOnnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598516;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4GczjhMt0ipkH2ViqPbMVrSeQbD/tFGBGtlDaHofEso=;
 b=k0yvmf5iscw1k/23pp2fUjMZ6CfzBKKcN61blSPOgxrYatyYQBoiMxpZhadowdVs9inm
 P8RRCofPfW89Xxiucnua+BoOr0Pfh7nTBUH+aqqm0QI5Xf1X9A5JzBuvVGyYQTDIMjX+2
 nblg1atLHpxSHe8IpWRS6FfeNSXnHBkD5baW139MTnHo0AZevhwfaHWdzhBExA0YH38bs
 58x+ykK33n38SGmBlNi33i/FLKn0jr8v826Ye6adKF4URXokS4WzIlJak3sd1NL3MhcPz
 duc0blYtz42zsESFROB78Ccw7vgd2WSKAzU7f+XWj2ncdrmj/pOMqTRFPFRbP3FVtIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=JwnAnGU1; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=PAAm7Bup; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=JwnAnGU1; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=PAAm7Bup
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 984ED40877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598512; bh=4GczjhMt0ipkH2ViqPbMVrS
 eQbD/tFGBGtlDaHofEso=; b=JwnAnGU1DaLgpwXlj4syU/OlBGVs7xFqDtxBSTRut7oroaGm4i
 1VtAVcK0GnWmAKB+3CKijx7PKvJpBxCABkeQS5LA5hjNtlWlaH7lGLvCJtGUjfPgC3mONhT5RYf
 3tiyt+eXUGcG9VPlQa2PgovXiePtqBSPndy2bPOjgUjxOD8xD4MQVQlImJQdvjOcjtqMI2EnaSX
 5vYc59K8hM76nev7hzTkB5ttSGFHwzGPLhUDv2fcnS70qwPnqG0oWwD3nYY7qzro76lwx4wMZhL
 8wFS9z0uwDRrBozWCppIA27+Yl6HfgubWGQJLiDnLi9VbeoHN4qybOOSphioRChuM7Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598512; bh=4GczjhMt0ipkH2ViqPbMVrS
 eQbD/tFGBGtlDaHofEso=; b=PAAm7BupX762wpsz8LAlEON5ZrNkxcE2bXh2NRcIRfMM7csYRC
 KcCIkowyArKh1SpcEqDPa0R6CbOuLlIVz/BA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 15/26] powerpc: mpc85xx: Remove P1025 support
Date: Wed, 21 Oct 2026 16:01:11 +0000
Message-ID: <20261021160145.10430-16-brads@mainlining.org>
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

No board in the tree selects ARCH_P1025, and the variant is unmaintained.
Remove its configuration and variant specific code while retaining the
shared P1021 support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                              |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig          | 22 ----------------------
 arch/powerpc/cpu/mpc85xx/Makefile         |  1 -
 arch/powerpc/cpu/mpc85xx/speed.c          |  2 +-
 arch/powerpc/cpu/mpc8xxx/cpu.c            |  1 -
 arch/powerpc/include/asm/config_mpc85xx.h |  6 ------
 arch/powerpc/include/asm/immap_85xx.h     |  2 +-
 arch/powerpc/include/asm/processor.h      |  1 -
 doc/README.mpc85xx-sd-spi-boot            |  2 --
 drivers/qe/Kconfig                        |  3 +--
 10 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 07214f2af7c..e806fa2e3e7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -471,7 +471,7 @@ config SYS_IMMR
 	default 0xE0000000 if MPC83xx && !ARCH_MPC8313
 	default 0x01000000 if ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
 	default 0xFFE00000 if ARCH_P1010 || ARCH_P1020 || \
-			      ARCH_P1021 || ARCH_P1024 || ARCH_P1025 || \
+			      ARCH_P1021 || ARCH_P1024 || \
 			      ARCH_P2020
 	default SYS_CCSRBAR_DEFAULT
 	help
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index f4e34adbaea..6ca0ccd65e7 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -466,24 +466,6 @@ config ARCH_P1024
 	imply CMD_REGINFO
 	imply SATA_SIL
 
-config ARCH_P1025
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
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-	imply SATA
-	imply CMD_REGINFO
-
 config ARCH_P2020
 	bool
 	select BTB
@@ -781,7 +763,6 @@ config MAX_CPUS
 		     ARCH_P1020 || \
 		     ARCH_P1021 || \
 		     ARCH_P1024 || \
-		     ARCH_P1025 || \
 		     ARCH_P2020 || \
 		     ARCH_T1024
 	default 1
@@ -804,7 +785,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
 				ARCH_P1024	|| \
-				ARCH_P1025	|| \
 				ARCH_P2020
 	default 0xfe000000 if	ARCH_B4420	|| \
 				ARCH_B4860	|| \
@@ -1012,7 +992,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
-			ARCH_P1025	|| \
 			ARCH_P2020
 	default 10 if ARCH_MPC8544
 	default 8 if	ARCH_MPC8540	|| \
@@ -1125,7 +1104,6 @@ config SYS_PPC_E500_DEBUG_TLB
 	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
-			ARCH_P1025	|| \
 			ARCH_P2020
 	default 3 if	ARCH_P1010	|| \
 			ARCH_BSC9132
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index c40558880ea..3746d5c6fdb 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1024)	+= p1021_serdes.o
-obj-$(CONFIG_ARCH_P1025)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P2020)	+= p2020_serdes.o
 obj-$(CONFIG_ARCH_P2041) += p2041_serdes.o
 obj-$(CONFIG_ARCH_T4240) += t4240_serdes.o
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index d17a19026dd..01fe85ffd57 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -544,7 +544,7 @@ void get_sys_info(sys_info_t *sys_info)
 #endif
 
 #ifdef CONFIG_QE
-#if defined(CONFIG_ARCH_P1021) || defined(CONFIG_ARCH_P1025)
+#if defined(CONFIG_ARCH_P1021)
 	sys_info->freq_qe =  sys_info->freq_systembus;
 #else
 	qe_ratio = ((gur->porpllsr) & MPC85xx_PORPLLSR_QE_RATIO)
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 668bd139066..ec036cdac01 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -49,7 +49,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(P1021, P1021, 2),
 	CPU_TYPE_ENTRY(P1022, P1022, 2),
 	CPU_TYPE_ENTRY(P1024, P1024, 2),
-	CPU_TYPE_ENTRY(P1025, P1025, 2),
 	CPU_TYPE_ENTRY(P2010, P2010, 1),
 	CPU_TYPE_ENTRY(P2020, P2020, 2),
 	CPU_TYPE_ENTRY(P2040, P2040, 4),
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index 67804ada5ed..3cc952797a7 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -15,12 +15,6 @@
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
 
-/* P1025 is lower end variant of P1021 */
-#elif defined(CONFIG_ARCH_P1025)
-#define QE_MURAM_SIZE			0x6000UL
-#define MAX_QE_RISC			1
-#define QE_NUM_OF_SNUM			28
-
 #elif defined(CONFIG_ARCH_P2020)
 #define CFG_SYS_FSL_SRIO_MAX_PORTS	2
 #define CFG_SYS_FSL_SRIO_OB_WIN_NUM	9
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 39ddfcfe308..9f5e9a7cfcd 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -2077,7 +2077,7 @@ typedef struct ccsr_gur {
 	u32	svr;		/* System version */
 	u8	res10[8];
 	u32	rstcr;		/* Reset control */
-#if defined(CONFIG_ARCH_P1021) || defined(CONFIG_ARCH_P1025)
+#if defined(CONFIG_ARCH_P1021)
 	u8      res11a[12];
 	u32     iovselsr;
 	u8      res11b[60];
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 2612f182a4c..748cf1a3f54 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1041,7 +1041,6 @@
 #define SVR_P1021	0x80E401
 #define SVR_P1022	0x80E600
 #define SVR_P1024	0x80E402
-#define SVR_P1025	0x80E403
 #define SVR_P2010	0x80E300
 #define SVR_P2020	0x80E200
 #define SVR_P2040	0x821000
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 086c8f9e49b..7a5748f5df3 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -64,8 +64,6 @@ P1010RDB	config_ddr3_1gb_p1010rdb_800M.dat
 P1021RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1022DS		config_ddr3_2gb_p1022ds.dat
 P1024RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
-P1025RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
-P1016RDB	config_ddr3_1gb_p1_p2_rdb_pc_667M.dat
 P1020UTM	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1020MBG	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 MPC8536DS	config_ddr2_512m_mpc8536ds_667M.dat
diff --git a/drivers/qe/Kconfig b/drivers/qe/Kconfig
index 22ed80bfc66..1d10422dd37 100644
--- a/drivers/qe/Kconfig
+++ b/drivers/qe/Kconfig
@@ -4,8 +4,7 @@
 config QE
 	bool "Enable support for QUICC Engine"
 	depends on PPC
-	default y if ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || ARCH_P1021 \
-		|| ARCH_P1025
+	default y if ARCH_T1040 || ARCH_T1042 || ARCH_T1024 || ARCH_P1021
 	help
 	  Chose this option to add support for the QUICC Engine.
 
-- 
2.47.3

