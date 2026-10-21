Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D16606B6EC
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ic6n3yPC;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=DheUd/h8;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=0n74YP7t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB38560AEE;
	Wed, 21 Oct 2026 16:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id haqWPT1qSHn9; Wed, 21 Oct 2026 16:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2534660846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599392;
	b=YzBCEadC0uCwQEcOFJaIP8QD8onBuCVf3Es+X29kx/vevsh1PdlBrFAtBBnXlBPL3A3T
	 D3oz9N9V51V2T5W9mT0qDPLTiUijB26kJpfA2W/8YghH26wU+dwH4jcU31lsmhR+EaTpd
	 TTjYNCl9beAubw+vJvs5ZEejFIqYeyTGrbNW9XmG9V0iiiA+fDl9gYhtWMErcOXFQF7Ll
	 TMOrvt7I5Jw7h9i1nA6tA9E2k6/t/CZ5C3Wc0nSHGjE98kEwrpisSGdSvmiHZ7vYbvK1J
	 7tyFuOdvDPggjAtUmZT2iQbpc06zovA3DGFvTcsGyUgUg5Va5m3QelANOM5ktzsUOVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hPfgVyUDEGG5FhlPizgmjhYpgCwJGGZ5NXPwaA/3h5E=;
	b=azOH/BN6J1zBZTYNS291CttAsoEqbj34mEYwOzSOd8frtLtG1pOyyBmx6H+ClGcHorSH
	 p9huiRWU4EITSbwVuv9hfAneH55rOcQfpTjWcujPfkdMcb25yAgPRqh4rQ9qaW4vbTp5w
	 TO1SI5xxw+z/pxgazlTMitGfieluCaAncbt4pkl+YwJ6lKRR1/tdReEXOTkEkJ6pLj2aH
	 ALjpg6Z+VnSpeBLqpfJ3ThZpbI3tLV0xbGKXdJFAYKrA57Pt2UrCfYXd+ej319TgOZO7+
	 BN6i7vRcMtibw4ax1/kBJvRa1VRHS9yrnFteZFGxROjEtNN+znKyw3upUJwNAGa/gBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599392;
	bh=hPfgVyUDEGG5FhlPizgmjhYpgCwJGGZ5NXPwaA/3h5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ic6n3yPC0ojpGeEjd4ba/ioSNJQrqKM8jfswmOJiNKo5npKVtpH6RdZS741o5rZbC
	 sXBgm6FgOENwVOAcKBuZBEugHwpAkKozvPb/yu2lFmUiV6qmTteXlKH9CTwxD14hLl
	 tsXseoEjSV1XkJppZ42smJhpC3nkHk/g7LIkyg4dXqGraZVvSl6Xw/UypTiMaoc4Iz
	 dYH8s3A3J5nrjlgvn5gZUr8hGyBdCgWDn5TxcniYtRFjWyc/87lJHl2EAyjx/HnYfS
	 POE+YOrj92eTPYMj76Qlct5e5/hBmsild8UYK3VBeQ+uB8Y+0r4W5ijqhmRIy5Gjoh
	 RS3vNHIjjIOHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2534660846;
	Wed, 21 Oct 2026 16:16:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id DD8C51E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id C4085811A1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id ZE7zqUJZ-Ji9 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AD8A81160
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598518;
 b=jYTE5bvDUPT1UPT/wpsjDot0zLq+TcFk3mEBvRnsdzjc153iv6aUlDFLUtPcq7NC17kT
 y72aCCAUfKr9CLIYBbo87hHUgwcCaYSPUgFcUyHGQSA/Qqz2yLjb7L1XXYuzbhAs43gDs
 tnHG36A3xYWJj1CJFFUY+8pnseQmqoHInPSfU/+y8i2eboqHgAE+IXnEzjrbleTtJvI6N
 HMXy5nahLBMD6NsJkxOyd8D0Km3NjHEH2wNuJlVVn7GH9W6mo91W8qxwxowd1jHlrb1YU
 uQCLLxFY3hQMpdbBTaa19nF94bohXjfpBmqh/cFjanN7cL/PCZzhi2dVg4JMIpNuxTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598518;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hPfgVyUDEGG5FhlPizgmjhYpgCwJGGZ5NXPwaA/3h5E=;
 b=Vmrh2o2nCQXc0hBLOs0MP3jyBaOAKIRRPF2aL50ulmLpi/vtZ6Jbm6KWixEBb7M0lRd4
 LxnWft8s3zQJZupDGfQxIZ+e3qHZLb3jreKjzDh6DVD8jnlFNlOvgpWqL2/ny8TkbPiyY
 GiflMmSYq4B6LtOnat1MbH00trR6Vk5nC2vTkHbtLjvd40FS+ym7JG3lsrP/ZfIzh7SI/
 nhj6TBxMuzh9OHlnGp4nbCJLcxJUWjsShqN8dnaBVt9CLOuxCUo2X5jJ6PGdyamMSZ0ba
 nRQY/CywC/q9ya82KmXD/KeWcvckQebzVq2p6JwJDC7q13ptlDGsTBkeQK0jOsx1I/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="DheUd/h8"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=0n74YP7t; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=DheUd/h8; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=0n74YP7t
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 9AD8A81160
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598514; bh=hPfgVyUDEGG5FhlPizgmjhY
 pgCwJGGZ5NXPwaA/3h5E=; b=DheUd/h80SX3QnJ6l5xcwxFhhb7e2M2cTB6CC5S0kGWtQbstMb
 6261SmHXUDwxxlWM5SHE52CMAe0kYpzLoeuEsTnmvmolguJ5yByQxX0e9/NfbW6NFY6P9MEbpAB
 fSkiLIeYOv1P2vMWkZWLIhMEl+K+ui9G8g4+deT1/PGboWtxU6Vh36tqoEF6d1zjP1TlxlQTuxZ
 ccV2Lmx/g6k9x4DCYj4CkgWVkT5MHfM7MmO14Y0tj20eMn6w53lqaGUq1hFcExMcSf7PsjthIG5
 UboCkkqnG/H1j8mvD/U1/jU5u74nPa4EJYggQVuN5qPEdb+eCsjW/DBzzqusbvkYivg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598514; bh=hPfgVyUDEGG5FhlPizgmjhY
 pgCwJGGZ5NXPwaA/3h5E=; b=0n74YP7tESMRGRsryrSLChcKgoVxxnFchDLfllCBbHXREOn9nJ
 5DcMsEWm8M+WdjFNOqI3hqJwNKdkkGjESTAQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v3 20/26] powerpc: mpc83xx: Remove MPC831x support
Date: Wed, 21 Oct 2026 16:01:16 +0000
Message-ID: <20261021160145.10430-21-brads@mainlining.org>
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

No target in the tree selects ARCH_MPC831X, and the family lacks active
community maintenance. Remove the orphaned family support, register
handling, and device tree code.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                                  |  3 +-
 arch/powerpc/cpu/mpc83xx/Kconfig              | 13 ----
 arch/powerpc/cpu/mpc83xx/cpu.c                |  6 +-
 arch/powerpc/cpu/mpc83xx/cpu_init.c           | 14 +---
 arch/powerpc/cpu/mpc83xx/fdt.c                | 42 +----------
 arch/powerpc/cpu/mpc83xx/hid/hid.h            |  5 --
 arch/powerpc/cpu/mpc83xx/hrcw/Kconfig         | 38 +---------
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr |  2 +-
 arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr |  2 +-
 arch/powerpc/cpu/mpc83xx/spd_sdram.c          |  2 +-
 arch/powerpc/cpu/mpc83xx/speed.c              | 27 +++----
 arch/powerpc/include/asm/arch-mpc83xx/gpio.h  |  2 +-
 arch/powerpc/include/asm/arch-mpc83xx/soc.h   | 20 +-----
 arch/powerpc/include/asm/global_data.h        |  4 +-
 arch/powerpc/include/asm/immap_83xx.h         | 35 ---------
 arch/powerpc/include/asm/mpc8xxx_spi.h        |  1 -
 .../clock/fsl,mpc83xx-clk.txt                 |  2 -
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt  |  8 +--
 drivers/clk/mpc83xx_clk.c                     |  8 +--
 drivers/clk/mpc83xx_clk.h                     |  8 +--
 drivers/cpu/mpc83xx_cpu.c                     | 17 -----
 drivers/cpu/mpc83xx_cpu.h                     | 14 ----
 drivers/ram/mpc83xx_sdram.c                   |  2 -
 include/mpc83xx.h                             | 72 ++-----------------
 24 files changed, 42 insertions(+), 305 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e806fa2e3e7..8ea591cba4f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -467,8 +467,7 @@ config SYS_IMMR
 	hex "Address for the Internal Memory-Mapped Registers (IMMR) window"
 	depends on PPC || FSL_LSCH2 || FSL_LSCH3 || ARCH_LS1021A
 	default 0xFF000000 if MPC8xx
-	default 0xF0000000 if ARCH_MPC8313
-	default 0xE0000000 if MPC83xx && !ARCH_MPC8313
+	default 0xE0000000 if MPC83xx
 	default 0x01000000 if ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
 	default 0xFFE00000 if ARCH_P1010 || ARCH_P1020 || \
 			      ARCH_P1021 || ARCH_P1024 || \
diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/Kconfig
index daae933e52e..06d84c2d945 100644
--- a/arch/powerpc/cpu/mpc83xx/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/Kconfig
@@ -125,19 +125,6 @@ config ARCH_MPC8308
 	select MPC83XX_PCIE1_SUPPORT
 	select MPC83XX_SECOND_I2C
 
-config ARCH_MPC831X
-	bool
-	select MPC83XX_PCI_SUPPORT
-	select MPC83XX_TSEC1_SUPPORT
-	select MPC83XX_TSEC2_SUPPORT
-	select SYS_CACHE_SHIFT_5
-
-config ARCH_MPC8313
-	bool
-	select ARCH_MPC831X
-	select MPC83XX_SECOND_I2C
-	select FSL_ELBC
-
 config ARCH_MPC832X
 	bool
 	select MPC83XX_QUICC_ENGINE
diff --git a/arch/powerpc/cpu/mpc83xx/cpu.c b/arch/powerpc/cpu/mpc83xx/cpu.c
index f8e9f716936..e1f70f40fec 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu.c
@@ -24,7 +24,7 @@
 #include <tsec.h>
 #include <netdev.h>
 #include <fsl_esdhc.h>
-#if defined(CONFIG_BOOTCOUNT_LIMIT) && !defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_BOOTCOUNT_LIMIT)
 #include <linux/immap_qe.h>
 #include <asm/io.h>
 #endif
@@ -48,10 +48,6 @@ int checkcpu(void)
 	} cpu_type_list [] = {
 		CPU_TYPE_ENTRY(8308),
 		CPU_TYPE_ENTRY(8309),
-		CPU_TYPE_ENTRY(8311),
-		CPU_TYPE_ENTRY(8313),
-		CPU_TYPE_ENTRY(8314),
-		CPU_TYPE_ENTRY(8315),
 		CPU_TYPE_ENTRY(8321),
 		CPU_TYPE_ENTRY(8323),
 		CPU_TYPE_ENTRY(8343),
diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index 340f9a0da56..555dd502b36 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -84,12 +84,6 @@ void cpu_init_f (volatile immap_t * im)
 #ifdef CFG_SYS_SCCR_TSEC2CM /* TSEC2 clock mode */
 		SCCR_TSEC2CM |
 #endif
-#ifdef CONFIG_SYS_SCCR_TSEC1ON /* TSEC1 clock switch */
-		SCCR_TSEC1ON |
-#endif
-#ifdef CONFIG_SYS_SCCR_TSEC2ON /* TSEC2 clock switch */
-		SCCR_TSEC2ON |
-#endif
 #ifdef CONFIG_SYS_SCCR_USBMPHCM /* USB MPH clock mode */
 		SCCR_USBMPHCM |
 #endif
@@ -122,12 +116,6 @@ void cpu_init_f (volatile immap_t * im)
 #ifdef CFG_SYS_SCCR_TSEC2CM /* TSEC2 clock mode */
 		(CFG_SYS_SCCR_TSEC2CM << SCCR_TSEC2CM_SHIFT) |
 #endif
-#ifdef CONFIG_SYS_SCCR_TSEC1ON /* TSEC1 clock switch */
-		(CONFIG_SYS_SCCR_TSEC1ON << SCCR_TSEC1ON_SHIFT) |
-#endif
-#ifdef CONFIG_SYS_SCCR_TSEC2ON /* TSEC2 clock switch */
-		(CONFIG_SYS_SCCR_TSEC2ON << SCCR_TSEC2ON_SHIFT) |
-#endif
 #ifdef CONFIG_SYS_SCCR_USBMPHCM /* USB MPH clock mode */
 		(CONFIG_SYS_SCCR_USBMPHCM << SCCR_USBMPHCM_SHIFT) |
 #endif
@@ -177,7 +165,7 @@ void cpu_init_f (volatile immap_t * im)
 
 	/* System General Purpose Register */
 #ifdef CFG_SYS_SICRH
-#if defined(CONFIG_ARCH_MPC834X) || defined(CONFIG_ARCH_MPC8313)
+#if defined(CONFIG_ARCH_MPC834X)
 	/* regarding to MPC34x manual rev.1 bits 28..29 must be preserved */
 	__raw_writel((im->sysconf.sicrh & 0x0000000C) | CFG_SYS_SICRH,
 		     &im->sysconf.sicrh);
diff --git a/arch/powerpc/cpu/mpc83xx/fdt.c b/arch/powerpc/cpu/mpc83xx/fdt.c
index 1bd4f2b3449..08c3e783597 100644
--- a/arch/powerpc/cpu/mpc83xx/fdt.c
+++ b/arch/powerpc/cpu/mpc83xx/fdt.c
@@ -17,7 +17,7 @@ extern void ft_qe_setup(void *blob);
 DECLARE_GLOBAL_DATA_PTR;
 
 #if defined(CONFIG_BOOTCOUNT_LIMIT) && \
-	(defined(CONFIG_QE) && !defined(CONFIG_ARCH_MPC831X))
+	defined(CONFIG_QE)
 #include <linux/immap_qe.h>
 
 void fdt_fixup_muram (void *blob)
@@ -50,44 +50,6 @@ void ft_cpu_setup(void *blob, struct bd_info *bd)
 		 REVID_MAJOR(spridr) >= 2)
 		fdt_fixup_crypto_node(blob, 0x0204);
 
-#ifdef CONFIG_ARCH_MPC8313
-	/*
-	* mpc8313e erratum IPIC1 swapped TSEC interrupt ID numbers on rev. 1
-	* h/w (see AN3545).  The base device tree in use has rev. 1 ID numbers,
-	* so if on Rev. 2 (and higher) h/w, we fix them up here
-	*/
-	if (REVID_MAJOR(immr->sysconf.spridr) >= 2) {
-		int nodeoffset, path;
-		const char *prop;
-
-		nodeoffset = fdt_path_offset(blob, "/aliases");
-		if (nodeoffset >= 0) {
-			prop = fdt_getprop(blob, nodeoffset, "ethernet0", NULL);
-			if (prop) {
-				u32 tmp[] = { 32, 0x8, 33, 0x8, 34, 0x8 };
-
-				path = fdt_path_offset(blob, prop);
-				prop = fdt_getprop(blob, path, "interrupts",
-						   NULL);
-				if (prop)
-					fdt_setprop(blob, path, "interrupts",
-						    &tmp, sizeof(tmp));
-			}
-			prop = fdt_getprop(blob, nodeoffset, "ethernet1", NULL);
-			if (prop) {
-				u32 tmp[] = { 35, 0x8, 36, 0x8, 37, 0x8 };
-
-				path = fdt_path_offset(blob, prop);
-				prop = fdt_getprop(blob, path, "interrupts",
-						   NULL);
-				if (prop)
-					fdt_setprop(blob, path, "interrupts",
-						    &tmp, sizeof(tmp));
-			}
-		}
-	}
-#endif
-
 	do_fixup_by_prop_u32(blob, "device_type", "cpu", 4,
 		"timebase-frequency", (bd->bi_busfreq / 4), 1);
 	do_fixup_by_prop_u32(blob, "device_type", "cpu", 4,
@@ -116,7 +78,7 @@ void ft_cpu_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_memory(blob, (u64)gd->ram_base, (u64)gd->ram_size);
 
 #if defined(CONFIG_BOOTCOUNT_LIMIT) && \
-	(defined(CONFIG_QE) && !defined(CONFIG_ARCH_MPC831X))
+	defined(CONFIG_QE)
 	fdt_fixup_muram (blob);
 #endif
 }
diff --git a/arch/powerpc/cpu/mpc83xx/hid/hid.h b/arch/powerpc/cpu/mpc83xx/hid/hid.h
index 089d1d77f0b..0ae528af878 100644
--- a/arch/powerpc/cpu/mpc83xx/hid/hid.h
+++ b/arch/powerpc/cpu/mpc83xx/hid/hid.h
@@ -48,12 +48,7 @@
 	CONFIG_HID0_INIT_SLEEP_BIT \
 )
 
-#ifdef CONFIG_TARGET_IDS8313
-/* IDS8313 defines a reserved bit; keep to not break compatibility */
-#define CFG_HID2_SPECIAL 0x00020000
-#else
 #define CFG_HID2_SPECIAL 0x0
-#endif
 
 #define CFG_SYS_HID2 ( \
 	CONFIG_HID2_LET_BIT |\
diff --git a/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig b/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
index 49d5db098f7..eef39021354 100644
--- a/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
@@ -24,7 +24,7 @@ config DDR_MC_CLOCK_MODE_1_1
 
 endchoice
 
-if !ARCH_MPC8313 && !ARCH_MPC832X
+if !ARCH_MPC832X
 
 choice
 	prompt "System PLL VCO division"
@@ -36,11 +36,9 @@ config SYSTEM_PLL_VCO_DIV_2
 	bool "2"
 
 config SYSTEM_PLL_VCO_DIV_4
-	depends on !ARCH_MPC831X
 	bool "4"
 
 config SYSTEM_PLL_VCO_DIV_8
-	depends on !ARCH_MPC831X
 	bool "8"
 
 endchoice
@@ -418,21 +416,9 @@ choice
 config TSEC1_MODE_MII
 	bool "MII"
 
-config TSEC1_MODE_RMII
-	depends on ARCH_MPC831X
-	bool "RMII"
-
 config TSEC1_MODE_RGMII
 	bool "RGMII"
 
-config TSEC1_MODE_RTBI
-	depends on ARCH_MPC831X
-	bool "RTBI"
-
-config TSEC1_MODE_SGMII
-	depends on ARCH_MPC831X
-	bool "SGMII"
-
 endchoice
 
 endif
@@ -445,21 +431,9 @@ choice
 config TSEC2_MODE_MII
 	bool "MII"
 
-config TSEC2_MODE_RMII
-	depends on ARCH_MPC831X
-	bool "RMII"
-
 config TSEC2_MODE_RGMII
 	bool "RGMII"
 
-config TSEC2_MODE_RTBI
-	depends on ARCH_MPC831X
-	bool "RTBI"
-
-config TSEC2_MODE_SGMII
-	depends on ARCH_MPC831X
-	bool "SGMII"
-
 endchoice
 
 endif
@@ -490,7 +464,7 @@ endchoice
 
 endif
 
-if ARCH_MPC831X || ARCH_MPC832X || ARCH_MPC8360
+if ARCH_MPC832X || ARCH_MPC8360
 
 choice
 	prompt "LALE timing"
@@ -534,7 +508,7 @@ config DDR_MC_CLOCK_MODE
 
 config SYSTEM_PLL_VCO_DIV
 	int
-	default 2 if ARCH_MPC8313 || ARCH_MPC832X
+	default 2 if ARCH_MPC832X
 	default 0 if SYSTEM_PLL_VCO_DIV_2 && !ARCH_MPC8360
 	default 1 if SYSTEM_PLL_VCO_DIV_4 && !ARCH_MPC8360
 	default 2 if SYSTEM_PLL_VCO_DIV_8 && !ARCH_MPC8360
@@ -615,19 +589,13 @@ config TSEC1_MODE
 	hex
 	default 0x0 if !MPC83XX_TSEC1_SUPPORT
 	default 0x0 if TSEC1_MODE_MII
-	default 0x1 if TSEC1_MODE_RMII
 	default 0x3 if TSEC1_MODE_RGMII
-	default 0x5 if TSEC1_MODE_RTBI
-	default 0x6 if TSEC1_MODE_SGMII
 
 config TSEC2_MODE
 	hex
 	default 0x0 if !MPC83XX_TSEC2_SUPPORT
 	default 0x0 if TSEC2_MODE_MII
-	default 0x1 if TSEC2_MODE_RMII
 	default 0x3 if TSEC2_MODE_RGMII
-	default 0x5 if TSEC2_MODE_RTBI
-	default 0x6 if TSEC2_MODE_SGMII
 
 config SECONDARY_DDR_IO
 	int
diff --git a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr
index 86c5f42dd37..a85e698a867 100644
--- a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr
+++ b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.lcrr
@@ -1,6 +1,6 @@
 menu "LCRR - Clock Ratio Register register"
 
-if !ARCH_MPC831X && !ARCH_MPC832X
+if !ARCH_MPC832X
 
 choice
 	prompt "DLL bypass"
diff --git a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr
index 91686b3b8b4..7bf7bda09e0 100644
--- a/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr
+++ b/arch/powerpc/cpu/mpc83xx/initreg/Kconfig.spcr
@@ -14,7 +14,7 @@ config SPCR_OPT_SPEC_READ
 
 endchoice
 
-if ARCH_MPC8308 || ARCH_MPC831X
+if ARCH_MPC8308
 
 choice
 	prompt "TSEC emergency priority"
diff --git a/arch/powerpc/cpu/mpc83xx/spd_sdram.c b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
index e847c03f378..949efc8e828 100644
--- a/arch/powerpc/cpu/mpc83xx/spd_sdram.c
+++ b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
@@ -37,7 +37,7 @@ void board_add_ram_info(int use_default)
 	printf(" (DDR%d", ((ddr->sdram_cfg & SDRAM_CFG_SDRAM_TYPE_MASK)
 			   >> SDRAM_CFG_SDRAM_TYPE_SHIFT) - 1);
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 	if ((ddr->sdram_cfg & SDRAM_CFG_DBW_MASK) == SDRAM_CFG_DBW_16)
 		puts(", 16-bit");
 	else if ((ddr->sdram_cfg & SDRAM_CFG_DBW_MASK) == SDRAM_CFG_DBW_32)
diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
index a2343c67f28..e2ed3caf022 100644
--- a/arch/powerpc/cpu/mpc83xx/speed.c
+++ b/arch/powerpc/cpu/mpc83xx/speed.c
@@ -87,7 +87,7 @@ int get_clocks(void)
 	u32 lcrr;
 
 	u32 csb_clk;
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
+#if defined(CONFIG_ARCH_MPC8308) || \
 	defined(CONFIG_ARCH_MPC834X)
 	u32 tsec1_clk;
 	u32 tsec2_clk;
@@ -117,7 +117,7 @@ int get_clocks(void)
 	u32 qe_clk;
 	u32 brg_clk;
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 	u32 pciexp1_clk;
 	u32 pciexp2_clk;
 #endif
@@ -146,7 +146,7 @@ int get_clocks(void)
 
 	sccr = im->clk.sccr;
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
+#if defined(CONFIG_ARCH_MPC8308) || \
 	defined(CONFIG_ARCH_MPC834X)
 	switch ((sccr & SCCR_TSEC1CM) >> SCCR_TSEC1CM_SHIFT) {
 	case 0:
@@ -167,7 +167,7 @@ int get_clocks(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_MPC830X) || defined(CONFIG_ARCH_MPC831X) || \
+#if defined(CONFIG_ARCH_MPC830X) || \
 	defined(CONFIG_ARCH_MPC834X)
 	switch ((sccr & SCCR_USBDRCM) >> SCCR_USBDRCM_SHIFT) {
 	case 0:
@@ -206,13 +206,6 @@ int get_clocks(void)
 		/* unknown SCCR_TSEC2CM value */
 		return -4;
 	}
-#elif defined(CONFIG_ARCH_MPC8313)
-	tsec2_clk = tsec1_clk;
-
-	if (!(sccr & SCCR_TSEC1ON))
-		tsec1_clk = 0;
-	if (!(sccr & SCCR_TSEC2ON))
-		tsec2_clk = 0;
 #endif
 
 #if defined(CONFIG_ARCH_MPC834X)
@@ -286,7 +279,7 @@ int get_clocks(void)
 	i2c1_clk = csb_clk;
 #elif defined(CONFIG_ARCH_MPC832X)
 	i2c1_clk = enc_clk;
-#elif defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#elif defined(CONFIG_ARCH_MPC8308)
 	i2c1_clk = enc_clk;
 #elif defined(CONFIG_FSL_ESDHC)
 	i2c1_clk = sdhc_clk;
@@ -295,7 +288,7 @@ int get_clocks(void)
 	i2c2_clk = csb_clk; /* i2c-2 clk is equal to csb clk */
 #endif
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 	switch ((sccr & SCCR_PCIEXP1CM) >> SCCR_PCIEXP1CM_SHIFT) {
 	case 0:
 		pciexp1_clk = 0;
@@ -392,7 +385,7 @@ int get_clocks(void)
 #endif
 
 	gd->arch.csb_clk = csb_clk;
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
+#if defined(CONFIG_ARCH_MPC8308) || \
 	defined(CONFIG_ARCH_MPC834X)
 	gd->arch.tsec1_clk = tsec1_clk;
 	gd->arch.tsec2_clk = tsec2_clk;
@@ -420,7 +413,7 @@ int get_clocks(void)
 	gd->arch.qe_clk = qe_clk;
 	gd->arch.brg_clk = brg_clk;
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 	gd->arch.pciexp1_clk = pciexp1_clk;
 	gd->arch.pciexp2_clk = pciexp2_clk;
 #endif
@@ -491,7 +484,7 @@ static int do_clocks(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("  SDHC:                %-4s MHz\n",
 	       strmhz(buf, gd->arch.sdhc_clk));
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
+#if defined(CONFIG_ARCH_MPC8308) || \
 	defined(CONFIG_ARCH_MPC834X)
 	printf("  TSEC1:               %-4s MHz\n",
 	       strmhz(buf, gd->arch.tsec1_clk));
@@ -504,7 +497,7 @@ static int do_clocks(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("  USB MPH:             %-4s MHz\n",
 	       strmhz(buf, gd->arch.usbmph_clk));
 #endif
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 	printf("  PCIEXP1:             %-4s MHz\n",
 	       strmhz(buf, gd->arch.pciexp1_clk));
 	printf("  PCIEXP2:             %-4s MHz\n",
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/gpio.h b/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
index dd368af7b91..6449fded125 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/gpio.h
@@ -6,7 +6,7 @@
 /*
  * The MCP83xx's 1-2 GPIO controllers each with 32 bits.
  */
-#if defined(CONFIG_ARCH_MPC8313) || defined(CONFIG_ARCH_MPC8308)
+#if defined(CONFIG_ARCH_MPC8308)
 #define MPC83XX_GPIO_CTRLRS 1
 #elif defined(CONFIG_ARCH_MPC834X)
 #define MPC83XX_GPIO_CTRLRS 2
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/soc.h b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
index d61d3a944f1..0eeaa23b190 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/soc.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
@@ -10,8 +10,6 @@
 enum soc_type {
 	SOC_MPC8308,
 	SOC_MPC8309,
-	SOC_MPC8313,
-	SOC_MPC8315,
 	SOC_MPC832X,
 	SOC_MPC8349,
 	SOC_MPC8360,
@@ -26,25 +24,12 @@ static inline bool mpc83xx_has_sdhc(int type)
 static inline bool mpc83xx_has_tsec(int type)
 {
 	return (type == SOC_MPC8308) ||
-	       (type == SOC_MPC8313) ||
-	       (type == SOC_MPC8315) ||
 	       (type == SOC_MPC8349);
 }
 
 static inline bool mpc83xx_has_pcie1(int type)
 {
-	return (type == SOC_MPC8308) ||
-	       (type == SOC_MPC8315);
-}
-
-static inline bool mpc83xx_has_pcie2(int type)
-{
-	return type == SOC_MPC8315;
-}
-
-static inline bool mpc83xx_has_sata(int type)
-{
-	return type == SOC_MPC8315;
+	return type == SOC_MPC8308;
 }
 
 static inline bool mpc83xx_has_pci(int type)
@@ -54,8 +39,7 @@ static inline bool mpc83xx_has_pci(int type)
 
 static inline bool mpc83xx_has_second_i2c(int type)
 {
-	return (type != SOC_MPC8315) &&
-	       (type != SOC_MPC832X);
+	return type != SOC_MPC832X;
 }
 
 static inline bool mpc83xx_has_quicc_engine(int type)
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 608e49667af..168eb55b497 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -26,7 +26,7 @@ struct arch_global_data {
 #else
 	/* There are other clocks in the MPC83XX */
 	u32 csb_clk;
-# if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X) || \
+# if defined(CONFIG_ARCH_MPC8308) || \
 	defined(CONFIG_ARCH_MPC834X)
 	u32 tsec1_clk;
 	u32 tsec2_clk;
@@ -39,7 +39,7 @@ struct arch_global_data {
 	u32 enc_clk;
 	u32 lbiu_clk;
 	u32 lclk_clk;
-# if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+# if defined(CONFIG_ARCH_MPC8308)
 	u32 pciexp1_clk;
 	u32 pciexp2_clk;
 # endif
diff --git a/arch/powerpc/include/asm/immap_83xx.h b/arch/powerpc/include/asm/immap_83xx.h
index 2eff504a80d..c7e7616529d 100644
--- a/arch/powerpc/include/asm/immap_83xx.h
+++ b/arch/powerpc/include/asm/immap_83xx.h
@@ -688,41 +688,6 @@ typedef struct immap {
 	u8			res7[0xC0000];
 } immap_t;
 
-#elif defined(CONFIG_ARCH_MPC8313)
-typedef struct immap {
-	sysconf83xx_t		sysconf;	/* System configuration */
-	wdt83xx_t		wdt;		/* Watch Dog Timer (WDT) Registers */
-	rtclk83xx_t		rtc;		/* Real Time Clock Module Registers */
-	rtclk83xx_t		pit;		/* Periodic Interval Timer */
-	gtm83xx_t		gtm[2];		/* Global Timers Module */
-	ipic83xx_t		ipic;		/* Integrated Programmable Interrupt Controller */
-	arbiter83xx_t		arbiter;	/* System Arbiter Registers */
-	reset83xx_t		reset;		/* Reset Module */
-	clk83xx_t		clk;		/* System Clock Module */
-	pmc83xx_t		pmc;		/* Power Management Control Module */
-	gpio83xx_t		gpio[1];	/* General purpose I/O module */
-	u8			res0[0x1300];
-	ddr83xx_t		ddr;		/* DDR Memory Controller Memory */
-	fsl_i2c_t		i2c[2];		/* I2C Controllers */
-	u8			res1[0x1300];
-	duart83xx_t		duart[2];	/* DUART */
-	u8			res2[0x900];
-	fsl_lbc_t		im_lbc;		/* Local Bus Controller Regs */
-	u8			res3[0x1000];
-	spi8xxx_t		spi;		/* Serial Peripheral Interface */
-	dma83xx_t		dma;		/* DMA */
-	pciconf83xx_t		pci_conf[1];	/* PCI Software Configuration Registers */
-	u8			res4[0x80];
-	ios83xx_t		ios;		/* Sequencer */
-	pcictrl83xx_t		pci_ctrl[1];	/* PCI Controller Control and Status Registers */
-	u8			res5[0x1aa00];
-	usb83xx_t		usb[1];
-	tsec83xx_t		tsec[2];
-	u8			res6[0xA000];
-	security83xx_t		security;
-	u8			res7[0xC0000];
-} immap_t;
-
 #elif defined(CONFIG_ARCH_MPC8308)
 typedef struct immap {
 	sysconf83xx_t		sysconf;	/* System configuration */
diff --git a/arch/powerpc/include/asm/mpc8xxx_spi.h b/arch/powerpc/include/asm/mpc8xxx_spi.h
index c136b3fb4af..5d8d7db2933 100644
--- a/arch/powerpc/include/asm/mpc8xxx_spi.h
+++ b/arch/powerpc/include/asm/mpc8xxx_spi.h
@@ -11,7 +11,6 @@
 #include <asm/types.h>
 
 #if defined(CONFIG_ARCH_MPC8308) || \
-	defined(CONFIG_ARCH_MPC8313) || \
 	defined(CONFIG_ARCH_MPC832X) || \
 	defined(CONFIG_ARCH_MPC834X)
 
diff --git a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
index 065575d87f0..baaacb62846 100644
--- a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
+++ b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
@@ -6,8 +6,6 @@ system.
 Required properties:
 - compatible: must be one of "fsl,mpc8308-clk",
                              "fsl,mpc8309-clk",
-                             "fsl,mpc8313-clk",
-                             "fsl,mpc8315-clk",
                              "fsl,mpc832x-clk",
                              "fsl,mpc8349-clk",
                              "fsl,mpc8360-clk"
diff --git a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
index efdcdfbdba0..5bdbd309fbf 100644
--- a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
+++ b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
@@ -6,8 +6,6 @@ Required properties:
 - compatible: must be one of "fsl,mpc83xx",
                              "fsl,mpc8308",
                              "fsl,mpc8309",
-                             "fsl,mpc8313",
-                             "fsl,mpc8315",
                              "fsl,mpc832x",
                              "fsl,mpc8349",
                              "fsl,mpc8360"
@@ -18,15 +16,15 @@ Required properties:
 Example:
 
 socclocks: clocks {
-	compatible = "fsl,mpc8315-clk";
+	compatible = "fsl,mpc832x-clk";
 	#clock-cells = <1>;
 };
 
 cpus {
 	compatible = "cpu_bus";
 
-	PowerPC,8315@0 {
-		compatible = "fsl,mpc8315";
+	PowerPC,8321@0 {
+		compatible = "fsl,mpc832x";
 		clocks = <&socclocks MPC83XX_CLK_CORE
 		          &socclocks MPC83XX_CLK_CSB>;
 	};
diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
index 20f77a983da..bca09f17d5f 100644
--- a/drivers/clk/mpc83xx_clk.c
+++ b/drivers/clk/mpc83xx_clk.c
@@ -51,7 +51,7 @@ static inline bool is_clk_valid(struct udevice *clk, int id)
 	case MPC83XX_CLK_I2C1:
 		return true;
 	case MPC83XX_CLK_TDM:
-		return type == SOC_MPC8315;
+		return false;
 	case MPC83XX_CLK_SDHC:
 		return mpc83xx_has_sdhc(type);
 	case MPC83XX_CLK_TSEC1:
@@ -64,9 +64,9 @@ static inline bool is_clk_valid(struct udevice *clk, int id)
 	case MPC83XX_CLK_PCIEXP1:
 		return mpc83xx_has_pcie1(type);
 	case MPC83XX_CLK_PCIEXP2:
-		return mpc83xx_has_pcie2(type);
+		return false;
 	case MPC83XX_CLK_SATA:
-		return mpc83xx_has_sata(type);
+		return false;
 	case MPC83XX_CLK_DMAC:
 		return (type == SOC_MPC8308) || (type == SOC_MPC8309);
 	case MPC83XX_CLK_PCI:
@@ -321,8 +321,6 @@ const struct clk_ops mpc83xx_clk_ops = {
 static const struct udevice_id mpc83xx_clk_match[] = {
 	{ .compatible = "fsl,mpc8308-clk", .data = SOC_MPC8308 },
 	{ .compatible = "fsl,mpc8309-clk", .data = SOC_MPC8309 },
-	{ .compatible = "fsl,mpc8313-clk", .data = SOC_MPC8313 },
-	{ .compatible = "fsl,mpc8315-clk", .data = SOC_MPC8315 },
 	{ .compatible = "fsl,mpc832x-clk", .data = SOC_MPC832X },
 	{ .compatible = "fsl,mpc8349-clk", .data = SOC_MPC8349 },
 	{ .compatible = "fsl,mpc8360-clk", .data = SOC_MPC8360 },
diff --git a/drivers/clk/mpc83xx_clk.h b/drivers/clk/mpc83xx_clk.h
index b9486a4c202..ce3683f3932 100644
--- a/drivers/clk/mpc83xx_clk.h
+++ b/drivers/clk/mpc83xx_clk.h
@@ -204,10 +204,8 @@ static int retrieve_mode(int clk, int soc_type, struct clk_mode *mode)
 		set_mode(mode, 0, 1, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_TSEC2:
-		if (soc_type == SOC_MPC8313) /* I2C and TSEC2 are the same register */
-			set_mode(mode, 2, 3, TYPE_SCCR_STANDARD);
-		else /* FIXME(mario.six@gdsys.cc): This has separate enable/disable bit! */
-			set_mode(mode, 0, 1, TYPE_SCCR_STANDARD);
+		/* FIXME(mario.six@gdsys.cc): This has separate enable/disable bit! */
+		set_mode(mode, 0, 1, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_SDHC:
 		set_mode(mode, 4, 5, TYPE_SCCR_STANDARD);
@@ -228,7 +226,7 @@ static int retrieve_mode(int clk, int soc_type, struct clk_mode *mode)
 		set_mode(mode, 12, 13, TYPE_SCCR_STANDARD);
 		break;
 	case MPC83XX_CLK_USBDR:
-		if (soc_type == SOC_MPC8313 || soc_type == SOC_MPC8349)
+		if (soc_type == SOC_MPC8349)
 			set_mode(mode, 10, 11, TYPE_SCCR_STANDARD);
 		else
 			set_mode(mode, 8, 9, TYPE_SCCR_STANDARD);
diff --git a/drivers/cpu/mpc83xx_cpu.c b/drivers/cpu/mpc83xx_cpu.c
index 780b08f0885..01ac307c821 100644
--- a/drivers/cpu/mpc83xx_cpu.c
+++ b/drivers/cpu/mpc83xx_cpu.c
@@ -70,9 +70,6 @@ static inline void determine_family(const struct udevice *dev)
 	case 0x811:
 		priv->family = FAMILY_830X;
 		break;
-	case 0x80B:
-		priv->family = FAMILY_831X;
-		break;
 	case 0x806:
 		priv->family = FAMILY_832X;
 		break;
@@ -108,18 +105,6 @@ static inline void determine_type(const struct udevice *dev)
 	case 0x8110:
 		priv->type = TYPE_8309;
 		break;
-	case 0x80B2:
-		priv->type = TYPE_8311;
-		break;
-	case 0x80B0:
-		priv->type = TYPE_8313;
-		break;
-	case 0x80B6:
-		priv->type = TYPE_8314;
-		break;
-	case 0x80B4:
-		priv->type = TYPE_8315;
-		break;
 	case 0x8066:
 		priv->type = TYPE_8321;
 		break;
@@ -321,8 +306,6 @@ static const struct udevice_id mpc83xx_cpu_ids[] = {
 	{ .compatible = "fsl,mpc83xx", },
 	{ .compatible = "fsl,mpc8308", },
 	{ .compatible = "fsl,mpc8309", },
-	{ .compatible = "fsl,mpc8313", },
-	{ .compatible = "fsl,mpc8315", },
 	{ .compatible = "fsl,mpc832x", },
 	{ .compatible = "fsl,mpc8349", },
 	{ .compatible = "fsl,mpc8360", },
diff --git a/drivers/cpu/mpc83xx_cpu.h b/drivers/cpu/mpc83xx_cpu.h
index 20579cecf5e..d9773d893f1 100644
--- a/drivers/cpu/mpc83xx_cpu.h
+++ b/drivers/cpu/mpc83xx_cpu.h
@@ -35,7 +35,6 @@ static const char * const e300_names[] = {
 /**
  * enum mpc83xx_cpu_family - Identifiers for MPC83xx CPU families
  * @FAMILY_830X:    Identifier for the MPC830x CPU family
- * @FAMILY_831X:    Identifier for the MPC831x CPU family
  * @FAMILY_832X:    Identifier for the MPC832x CPU family
  * @FAMILY_834X:    Identifier for the MPC834x CPU family
  * @FAMILY_836X:    Identifier for the MPC836x CPU family
@@ -43,7 +42,6 @@ static const char * const e300_names[] = {
  */
 enum mpc83xx_cpu_family {
 	FAMILY_830X,
-	FAMILY_831X,
 	FAMILY_832X,
 	FAMILY_834X,
 	FAMILY_836X,
@@ -54,10 +52,6 @@ enum mpc83xx_cpu_family {
  * enum mpc83xx_cpu_type - Identifiers for MPC83xx CPU types
  * @TYPE_8308:      Identifier for the MPC8308 CPU type
  * @TYPE_8309:      Identifier for the MPC8309 CPU type
- * @TYPE_8311:      Identifier for the MPC8311 CPU type
- * @TYPE_8313:      Identifier for the MPC8313 CPU type
- * @TYPE_8314:      Identifier for the MPC8314 CPU type
- * @TYPE_8315:      Identifier for the MPC8315 CPU type
  * @TYPE_8321:      Identifier for the MPC8321 CPU type
  * @TYPE_8323:      Identifier for the MPC8323 CPU type
  * @TYPE_8343:      Identifier for the MPC8343 CPU type
@@ -76,10 +70,6 @@ enum mpc83xx_cpu_family {
 enum mpc83xx_cpu_type {
 	TYPE_8308,
 	TYPE_8309,
-	TYPE_8311,
-	TYPE_8313,
-	TYPE_8314,
-	TYPE_8315,
 	TYPE_8321,
 	TYPE_8323,
 	TYPE_8343,
@@ -96,10 +86,6 @@ enum mpc83xx_cpu_type {
 static const char * const cpu_type_names[] = {
 	[TYPE_8308] = "8308",
 	[TYPE_8309] = "8309",
-	[TYPE_8311] = "8311",
-	[TYPE_8313] = "8313",
-	[TYPE_8314] = "8314",
-	[TYPE_8315] = "8315",
 	[TYPE_8321] = "8321",
 	[TYPE_8323] = "8323",
 	[TYPE_8343] = "8343",
diff --git a/drivers/ram/mpc83xx_sdram.c b/drivers/ram/mpc83xx_sdram.c
index d45c4e6264e..888fec949df 100644
--- a/drivers/ram/mpc83xx_sdram.c
+++ b/drivers/ram/mpc83xx_sdram.c
@@ -177,7 +177,6 @@ static int mpc83xx_sdram_static_init(ofnode node, u32 cs, u32 mapaddr, u32 size)
 	case ODT_RD_ONLY_CURRENT:
 	case ODT_RD_ONLY_OTHER_CS:
 		if (!IS_ENABLED(CONFIG_ARCH_MPC830X) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC831X) &&
 		    !IS_ENABLED(CONFIG_ARCH_MPC8360)) {
 			debug("%s: odt_rd_cfg value %d invalid.\n",
 			      ofnode_get_name(node), odt_rd_cfg);
@@ -206,7 +205,6 @@ static int mpc83xx_sdram_static_init(ofnode node, u32 cs, u32 mapaddr, u32 size)
 	case ODT_WR_ONLY_CURRENT:
 	case ODT_WR_ONLY_OTHER_CS:
 		if (!IS_ENABLED(CONFIG_ARCH_MPC830X) &&
-		    !IS_ENABLED(CONFIG_ARCH_MPC831X) &&
 		    !IS_ENABLED(CONFIG_ARCH_MPC8360)) {
 			debug("%s: odt_wr_cfg value %d invalid.\n",
 			      ofnode_get_name(node), odt_wr_cfg);
diff --git a/include/mpc83xx.h b/include/mpc83xx.h
index b8d2c3edd56..8a1a9e7a9b9 100644
--- a/include/mpc83xx.h
+++ b/include/mpc83xx.h
@@ -57,11 +57,6 @@
 
 #define SPR_8308			0x8100
 #define SPR_8309			0x8110
-#define SPR_831X_FAMILY			0x80B
-#define SPR_8311			0x80B2
-#define SPR_8313			0x80B0
-#define SPR_8314			0x80B6
-#define SPR_8315			0x80B4
 #define SPR_832X_FAMILY			0x806
 #define SPR_8321			0x8066
 #define SPR_8323			0x8062
@@ -113,8 +108,8 @@
 #define SPCR_TSEC2EP			0x00000003
 #define SPCR_TSEC2EP_SHIFT		(31-31)
 
-#elif defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
-/* SPCR bits - MPC8308 and MPC831x specific */
+#elif defined(CONFIG_ARCH_MPC8308)
+/* SPCR bits - MPC8308 specific */
 /* TSEC data priority */
 #define SPCR_TSECDP			0x00003000
 #define SPCR_TSECDP_SHIFT		(31-19)
@@ -199,38 +194,6 @@
 #define SICRL_URT_CTPR			0x06000000
 #define SICRL_IRQ_CTPR			0x00C00000
 
-#elif defined(CONFIG_ARCH_MPC8313)
-/* SICRL bits - MPC8313 specific */
-#define SICRL_LBC			0x30000000
-#define SICRL_UART			0x0C000000
-#define SICRL_SPI_A			0x03000000
-#define SICRL_SPI_B			0x00C00000
-#define SICRL_SPI_C			0x00300000
-#define SICRL_SPI_D			0x000C0000
-#define SICRL_USBDR_11			0x00000C00
-#define SICRL_USBDR_10			0x00000800
-#define SICRL_USBDR_01			0x00000400
-#define SICRL_USBDR_00			0x00000000
-#define SICRL_ETSEC1_A			0x0000000C
-#define SICRL_ETSEC2_A			0x00000003
-
-/* SICRH bits - MPC8313 specific */
-#define SICRH_INTR_A			0x02000000
-#define SICRH_INTR_B			0x00C00000
-#define SICRH_IIC			0x00300000
-#define SICRH_ETSEC2_B			0x000C0000
-#define SICRH_ETSEC2_C			0x00030000
-#define SICRH_ETSEC2_D			0x0000C000
-#define SICRH_ETSEC2_E			0x00003000
-#define SICRH_ETSEC2_F			0x00000C00
-#define SICRH_ETSEC2_G			0x00000300
-#define SICRH_ETSEC1_B			0x00000080
-#define SICRH_ETSEC1_C			0x00000060
-#define SICRH_GTX1_DLY			0x00000008
-#define SICRH_GTX2_DLY			0x00000004
-#define SICRH_TSOBI1			0x00000002
-#define SICRH_TSOBI2			0x00000001
-
 #elif defined(CONFIG_ARCH_MPC8308)
 /* SICRL bits - MPC8308 specific */
 #define SICRL_SPI_PF0			(0 << 28)
@@ -514,7 +477,7 @@
 #define HRCWH_ROM_LOC_LOCAL_16BIT	0x00600000
 #define HRCWH_ROM_LOC_LOCAL_32BIT	0x00700000
 
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 #define HRCWH_ROM_LOC_NAND_SP_8BIT	0x00100000
 #define HRCWH_ROM_LOC_NAND_SP_16BIT	0x00200000
 #define HRCWH_ROM_LOC_NAND_LP_8BIT	0x00500000
@@ -566,7 +529,7 @@
 /*
  * RSR - Reset Status Register
  */
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 #define RSR_RSTSRC			0xF0000000	/* Reset source */
 #define RSR_RSTSRC_SHIFT		28
 #else
@@ -712,29 +675,8 @@
 #define SCCR_USBCM_2			0x00A00000
 #define SCCR_USBCM_3			0x00F00000
 
-#elif defined(CONFIG_ARCH_MPC8313)
-/* TSEC1 bits are for TSEC2 as well */
-#define SCCR_TSEC1CM			0xc0000000
-#define SCCR_TSEC1CM_SHIFT		30
-#define SCCR_TSEC1CM_0			0x00000000
-#define SCCR_TSEC1CM_1			0x40000000
-#define SCCR_TSEC1CM_2			0x80000000
-#define SCCR_TSEC1CM_3			0xC0000000
-
-#define SCCR_TSEC1ON			0x20000000
-#define SCCR_TSEC1ON_SHIFT		29
-#define SCCR_TSEC2ON			0x10000000
-#define SCCR_TSEC2ON_SHIFT		28
-
-#define SCCR_USBDRCM			0x00300000
-#define SCCR_USBDRCM_SHIFT		20
-#define SCCR_USBDRCM_0			0x00000000
-#define SCCR_USBDRCM_1			0x00100000
-#define SCCR_USBDRCM_2			0x00200000
-#define SCCR_USBDRCM_3			0x00300000
-
 #elif defined(CONFIG_ARCH_MPC8308)
-/* SCCR bits - MPC8315/MPC8308 specific */
+/* SCCR bits - MPC8308 specific */
 #define SCCR_TSEC1CM			0xc0000000
 #define SCCR_TSEC1CM_SHIFT		30
 #define SCCR_TSEC1CM_0			0x00000000
@@ -810,7 +752,7 @@
  */
 #define CSCONFIG_EN			0x80000000
 #define CSCONFIG_AP			0x00800000
-#if defined(CONFIG_ARCH_MPC830X) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC830X)
 #define CSCONFIG_ODT_RD_NEVER		0x00000000
 #define CSCONFIG_ODT_RD_ONLY_CURRENT	0x00100000
 #define CSCONFIG_ODT_RD_ONLY_OTHER_CS	0x00200000
@@ -932,7 +874,7 @@
 #define SDRAM_CFG_SDRAM_TYPE_MASK	0x07000000
 #define SDRAM_CFG_SDRAM_TYPE_SHIFT	24
 #define SDRAM_CFG_DYN_PWR		0x00200000
-#if defined(CONFIG_ARCH_MPC8308) || defined(CONFIG_ARCH_MPC831X)
+#if defined(CONFIG_ARCH_MPC8308)
 #define SDRAM_CFG_DBW_MASK		0x00180000
 #define SDRAM_CFG_DBW_16		0x00100000
 #define SDRAM_CFG_DBW_32		0x00080000
-- 
2.47.3

