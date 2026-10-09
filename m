Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4EDCA9EC3
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C1F6408F7;
	Fri,  9 Oct 2026 22:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oX__ADOc-ca9; Fri,  9 Oct 2026 22:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18EA040961
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583921;
	b=id+LNPZeMUbkRQsVzzqZQWlT7ttHDbcXmYdObOjRDkIKrETEgIEXxcYDwWdjsKlcMO0P
	 zh8V9G3ag55TlH37Q1uMr3jSXruDJygdP6ulC7PHZ2S6831BnC/uachWHL++Svr/qM9Yq
	 ZSbnedCjcNopRkbjOr/hmC7H3AtGwkJcS5GdpM2Y1dI5uSRgHb8TA3WGnTMlQC9QCBUwK
	 iuUKB5jj6HyJ6PmgmQsXa52c8mG+z/aU1wnUaq4dzlcXxwKahZKAqHLASwxcliH31NJhp
	 a+gthVvG6EIYru1c9VCmq6E4RQhFqeIW6ABipxEqYBBctYf6sAXMXr/2mfZL4bT7JrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0mM4W0GEwjvnCJBFdMjv9m5ZWiHd7K2p+VIcgyGu6os=;
	b=JcjZe5elAjKdgz9eLhPfY5oGrPzyjrN0uy1G1vcQYUHxyKBbex+q0OsHFErcTD6SC0Kl
	 Re/gHslgJ+MsuN9ChLMP6pBI3wF7n6n55CgJ0zjpBjsGf9/OIqNejNfjMONqz0s2sbsAm
	 N2WWPwjMOABfyBgYOs6ptr0Rara/QSWRZ31YkOuasllAyZeZY7qjssypD3bu8UbdRT3LK
	 kK3wQO4+iHGiEjZ1nEQ40I6RtuQEyvRyrAbzATBKx8MhM5Z4qbiwK45ZJ+9jodTe0ZOwh
	 SmPPa31EwXwsQ4wXmtwSc91VjBLn4P+VnODaXg5qPtwwSW+ImUVW5xLtFodpLCE+NGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583921;
	bh=0mM4W0GEwjvnCJBFdMjv9m5ZWiHd7K2p+VIcgyGu6os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F1HMmXgLyiKHNVnDP43F/ouQgXtQ1WG+CGlO71whsjzdDiQtVxuXA4qHGkE0iDxFP
	 3ojIGt9dVwXUG0quxZRZwhW943kdVhczPF+eUnjv6hYHeLVpoDrD/x+1C9AInIwcbH
	 ZeL5gVpzrOdoxkNuyN67aUrOC8BPB1lcHgoPgDIs863N1lFq3pwltn/ZZry8JLpa/x
	 VbSSbeyKfCU2ZkdukbilkDntK5EjCLNzJTqUydD1FoesVD/WZ9726appVAQzspqJs5
	 4rx5x911vBKLr2LsHwOj5ypHciMPAV7Ykmyn8G5zgoOUtU9B7vtqVNAP9T+S7LZpo7
	 tqqLAMqz//G8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18EA040961;
	Fri,  9 Oct 2026 22:12:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 096A1B87
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id DC68840194
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 6cSnpOhvZUE9 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D628040053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583826;
 b=Nl0YEnm2dLw9Najvg1lYdCx3EIG/c9y6rEXaETLWmC6DDlpb46Eq13+YF97Rkiv4T3JI
 Z7phSVXbfrbbrsQ6T5ai4VFp8qtEAU8xb39LcyUzYaW99NW6mXWOXQIw48vZQtBRUIs1F
 7X/8sc8bp6xQvyzh3IfezuqJfJ3IarfFErSBzl1Uww6x9DBFUYpvsgjDTO5gEAlDOA4W9
 tqoJ0reydX38jSdMcrT9AkIlVKbn23txWNbEVx7ek1CQNHv8Lq+pwRi9aFQbuiI7bWXYm
 myvh6QzxRCBBcrdMuMStlU/AbNiBHYDtuemP/bnZVJo+Xz2vY4UyXRsMuFiwIeeNd/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583826;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0mM4W0GEwjvnCJBFdMjv9m5ZWiHd7K2p+VIcgyGu6os=;
 b=kGGhMdLMIXCM8YyE/gqYd1XpMVdu7q5qiHRHYujjyM9HbPuzpLAhEA22vw2zXCfWvjiK
 4FI47GnT15GWNwXXk3yEeQrw6y7VEmfRv8/z/vROLwbGQHYNwPzalQ5agRcL0zB4+IUTJ
 OnRurOgcNnaitk7NFTNOx0DW8kSmVrd4HYa3q89P7NoXdsTaBAbWOiTZivVkr799QMwe9
 hZSzb9LXKlGM8pxT2FimoZOM9IhbuORhLFWGCuqSh9cfhmCYRkIBK9mzzhpLiHCagdFSa
 Sj5r6YVr+gw/AS1+RIneNTakEzefV4sn39qpsYwhVBph1ojcGEtfpMC5bSdVg21Si/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=JmScBK9R; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=smZQx6fC; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=JmScBK9R; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=smZQx6fC
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id D628040053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583824; bh=0mM4W0GEwjvnCJBFdMjv9m5
 ZWiHd7K2p+VIcgyGu6os=; b=JmScBK9R1SV9VA9pkAg3Ld6Sc89GjuRknmwnBnvTWZxt8T3tjS
 561yEuupgZGKvmHVjbY9BuuG1CvMrjXlKb9G8yZS0aXyYeAyjWH0ug8furO97GHR2ThXT6HSAwn
 0LlpMw503hIU34s3HrME89FcsjtPqenv1H0axcQNTQwXWKs3tuX/40Iz2NEognDF+PyuTEtR0dh
 cJg811XXix2WwX6JQJYdG1z3T9TjqfWIp9IgxCQ6352fZOLsCrtaEfICFF0nyPfIps9Mbp2rdlN
 iMGpB8dB0FqFw5bSDvP3KMFLXw9I5J9Qz52MNdV3U6/8m1ME+fxOFvj8IOcVsbgAgVA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583824; bh=0mM4W0GEwjvnCJBFdMjv9m5
 ZWiHd7K2p+VIcgyGu6os=; b=smZQx6fCZ/QaDHLCzlEX3W8WSV+seFR9qa8Nv+3gDSmOJHs2JX
 rRVRkP5UWWAMlA+a1V9+aRLhjSYdhfYsjeCg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 15/26] powerpc: mpc85xx: Remove P1025 support
Date: Fri,  9 Oct 2026 22:10:05 +0000
Message-ID: <20261009221017.20385-16-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 22:11:53 +0000
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
index 52817a4fc2a..8c02893f63b 100644
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

