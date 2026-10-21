Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995A606A543
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RTCEMMJb;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=JSra0ZE2;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=C1PEBgFQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DA9B60B2B;
	Wed, 21 Oct 2026 16:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dIpPDieFYo2; Wed, 21 Oct 2026 16:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C7FA60B2D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599417;
	b=sPnSSKRAeVzFoH7XJal76pomwhNyMkkd0PFkmcyO6+kpEtsqUo5jfZqvJXxe0kPFVO8e
	 YQ6CH/69XwePsFnjkGH9RKmLhr0vLAax/ydIHBEMYJlvx6eOP3zSr+FlggOWPXSF3NrpH
	 qbOK7dFCNhUiEMeIsvYPA+eaalOXHo1ufLVWRmfuWTZCbUS6qZ5vxxGzd8159FsPUWg3K
	 Pckluc30KaJTEAhdx31J2RozEET3DXjFsIfWBKMdAHOoX6LBjfftFsoQFZQzOgrZph7+j
	 eVWlSDudNlG5wPlXNkbGIW4rHCVIoxet6LWTtGhrX7hPTn5Nhu+T6BI3XyRKF1h/q4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0sAIpF4rpbMjTl9MnGyFp3xh6boHeBf/nm6dCAYvblI=;
	b=XgnBaXCVk3dCICA0ty9sUapWJeejrPfHfGJT4efZb9aReOCBm9z3J7hkCuhIELeFjkSe
	 sOcJYSfAmIHiZwtZHEIfuuP2MDp2GcmBodjFbpfwNewoTrBP6NJt7dCrqoM+4PMG61Ggn
	 uRkFqgRzokuLKtbzZx/nS89WBNenyxX5E0ef9gseMYH/lvcA8gs9d9gM5fRNvrEdugvgb
	 ILjFiK9DTy+y+XC06wH04feaO12Fl/i2GnrCTa8BNS5Su3p0Mm0ua4JgFnymFiqK9dJ6j
	 Gn8CPfHbDiDtpNhCP40IDw0PXxRVQfrmAXiCR2MfegnuQE/1VU+VXQNvNMqV/aakxLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599417;
	bh=0sAIpF4rpbMjTl9MnGyFp3xh6boHeBf/nm6dCAYvblI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RTCEMMJbrFhi74Cz6TqyaSJ7uk4N0UtGOetCw1C3BPuuO8vh9K5tUTazvSD3zIgCI
	 qMai9NbQR/ZO9cZkx7vJXFj5xijtG+3PSb330X0JezNnSZLnsgR5ATerYOlGY/6PjB
	 e9cliUULOvlJSGf18e+5k09sVBDR7nWp4ULVphsO1BdmvjlH6l9WS2YoZKDdzQuo0T
	 j98lsLtsy9YNWqx3jFxvN1RsUgCDnqXnUHwk23F7XxY24oEJqtWfYq5moBtM28z6t9
	 vyT8v9SFnVTKMTV4Y70OpqIwDEu/pGiaZ7twm8PJq7z4bg9h8mexYaqoBuB5xPyYl8
	 p1Di3D/Mc4AQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C7FA60B2D;
	Wed, 21 Oct 2026 16:16:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id EF0C21AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id ECCE8408CC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id gHo02gRAqE-h for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8EA1408A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598526;
 b=okm1+hYSGe6CCckeSt7BH/zopibvq2NGJx1zkhOM2JHFI4Q9IkJ/o3gKkS4X0PdINkw6
 54Er2z07T3b89BjbBPULCxR7gY8xaJ1Oi3zWAe78uBRvtOXKlJz4qFxoGbNiNeMiNi/zR
 4n+NKz8ZoPJOM4Pc60BnsNiDYYkRqmzMux1Az0xvbnzCW/dvFJPvszUtTmD3dYvIjZCfH
 Qtpgk5pjg/kxoFEKCO2Wy3TPkxYswbec1f4dsyFMvP8fnBf0LuBsaE3aSK6PneFq0IxSP
 jxvpTFBcs308kY2xabnNFN6p+eq8e38jh9rFJxa98/RtBtsTAOoRm5P2nOHcdGlOgew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598526;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0sAIpF4rpbMjTl9MnGyFp3xh6boHeBf/nm6dCAYvblI=;
 b=Dqh7SNz6sEals+sP1hF649iqDXUR0R98JdOHDRzYa981vEYuFyXgJ22Af4EnMEUwUch5
 ODnz5T8JhcPLPVx1iVEJBzzbCpzjRHXJ4kMFiOmLQzt6fLJRqlreu15R2Pd/74rG6kjbo
 gwW8X4RRO9HeT5BseI0yA6pgKWYnQDyrAIh/e9X3dPo/98VLYf7RIXRjEvODWLEacfp6r
 FCnfzuR9SyUa3dUxkW+NSV3Xum/+biSlkJGzwCRnD6nDQE+RB7DnfPJmCzoUKVO6Yah0A
 eQCNXrg8M/gJGmJYIUmB3t/NctGLrxOyAKEUGevnWvYrKxhdcSXGQq9XXzxbNvJwZRg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=JSra0ZE2; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=C1PEBgFQ; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=JSra0ZE2; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=C1PEBgFQ
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id B8EA1408A1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598513; bh=0sAIpF4rpbMjTl9MnGyFp3x
 h6boHeBf/nm6dCAYvblI=; b=JSra0ZE2c729KMCEuTTtZo37Y2vywULyQwxa99Yh0IohzKbMCy
 CHjNPeu2Jy/ct3kiUzZFLaVTUhAksl9qa8BzCqsoxwQvmk0ggoOinSpqG6akKLvwEswDpYyCuvU
 9QNCTO3tOcY2D9KIq8zIKWA9uKiJOLaJps2Hvhh/ONUXkUNUMJCKZemxiZ/mployLUyeRwaUpTn
 vPibJ1BqVzYMfAmvDrxu8oINEffVdCSbKQSC/Pkh2DgSd/u1PooyKxagpr+av7YgzAaQBQxuvzM
 L2udjf4LtKVqOK5WPBCFDCfIRx/3TKydl86PzN/C8uXKE2wx5TSIkqkj6S9v8xunmlA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598513; bh=0sAIpF4rpbMjTl9MnGyFp3x
 h6boHeBf/nm6dCAYvblI=; b=C1PEBgFQQXbGm4EcjXacwzzeKoMv4j1WmDLFUSF2QIrOAg2dl4
 jJQBxiNB4jqQSLzI54rEl/yMUoZr1CGaaNBA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 17/26] powerpc: mpc85xx: Remove MPC8540 support
Date: Wed, 21 Oct 2026 16:01:13 +0000
Message-ID: <20261021160145.10430-18-brads@mainlining.org>
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

No board in the tree selects ARCH_MPC8540, and the SoC is unmaintained.
Remove its architecture configuration, DUART definitions, and CPU
specific cache handling.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 README                                |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig      | 12 ++-------
 arch/powerpc/cpu/mpc85xx/cpu.c        |  2 +-
 arch/powerpc/cpu/mpc85xx/cpu_init.c   |  4 +--
 arch/powerpc/cpu/mpc85xx/fdt.c        |  4 +--
 arch/powerpc/cpu/mpc85xx/speed.c      |  2 +-
 arch/powerpc/cpu/mpc8xxx/cpu.c        |  1 -
 arch/powerpc/include/asm/fsl_lbc.h    |  3 +--
 arch/powerpc/include/asm/immap_85xx.h | 35 ---------------------------
 arch/powerpc/include/asm/processor.h  |  1 -
 10 files changed, 10 insertions(+), 56 deletions(-)

diff --git a/README b/README
index 7060bc5ac0c..830aa9b722f 100644
--- a/README
+++ b/README
@@ -137,7 +137,7 @@ The following options need to be configured:
 
 - CPU Type:	Define exactly one, e.g. CONFIG_MPC85XX.
 
-- Board Type:	Define exactly one, e.g. CONFIG_MPC8540ADS.
+- Board Type:	Define exactly one.
 
 - 85xx CPU Options:
 		CONFIG_SYS_PPC64
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 8391ea23cdb..2d405501c57 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -321,11 +321,6 @@ config ARCH_BSC9132
 	imply CMD_PCI
 	imply CMD_REGINFO
 
-config ARCH_MPC8540
-	bool
-	select FSL_LAW
-	select SYS_FSL_HAS_DDR1
-
 config ARCH_MPC8544
 	bool
 	select BTB
@@ -760,7 +755,6 @@ config SYS_CCSRBAR_DEFAULT
 	hex "Default CCSRBAR address"
 	default	0xff700000 if	ARCH_BSC9131	|| \
 				ARCH_BSC9132	|| \
-				ARCH_MPC8540	|| \
 				ARCH_MPC8544	|| \
 				ARCH_MPC8560	|| \
 				ARCH_P1010	|| \
@@ -975,8 +969,7 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1024	|| \
 			ARCH_P2020
 	default 10 if ARCH_MPC8544
-	default 8 if	ARCH_MPC8540	|| \
-			ARCH_MPC8560
+	default 8 if	ARCH_MPC8560
 	help
 	  Number of local access windows. This is fixed per SoC.
 	  If not sure, do not change.
@@ -1111,8 +1104,7 @@ config SYS_FSL_IFC_CLK_DIV
 
 config SYS_FSL_LBC_CLK_DIV
 	int "Divider of platform clock"
-	depends on FSL_ELBC || ARCH_MPC8540 || \
-		ARCH_MPC8560
+	depends on FSL_ELBC || ARCH_MPC8560
 
 	default 2 if	ARCH_P2041
 	default 1
diff --git a/arch/powerpc/cpu/mpc85xx/cpu.c b/arch/powerpc/cpu/mpc85xx/cpu.c
index ab4ef154729..c33250faac6 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu.c
@@ -302,7 +302,7 @@ int checkcpu (void)
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 /* Everything after the first generation of PQ3 parts has RSTCR */
-#if defined(CONFIG_ARCH_MPC8540) || defined(CONFIG_ARCH_MPC8560)
+#if defined(CONFIG_ARCH_MPC8560)
 	unsigned long val, msr;
 
 	/*
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 710b3b31354..c6923a797f9 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -546,7 +546,7 @@ int l2cache_init(void)
 		return -1;
 		break;
 	case 0x1:
-		if (ver == SVR_8540 || ver == SVR_8560   ||
+		if (ver == SVR_8560 ||
 		    ver == SVR_8541 || ver == SVR_8555) {
 			puts("128 KiB ");
 			/* set L2E=1, L2I=1, & L2BLKSZ=1 (128 KiBibyte) */
@@ -557,7 +557,7 @@ int l2cache_init(void)
 		}
 		break;
 	case 0x2:
-		if (ver == SVR_8540 || ver == SVR_8560   ||
+		if (ver == SVR_8560 ||
 		    ver == SVR_8541 || ver == SVR_8555) {
 			puts("256 KiB ");
 			/* set L2E=1, L2I=1, & L2BLKSZ=2 (256 KiBibyte) */
diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index 7de6a033ce2..e115c19cf8d 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -229,14 +229,14 @@ static inline u32 l2cache_size(void)
 	case 0x0:
 		break;
 	case 0x1:
-		if (ver == SVR_8540 || ver == SVR_8560   ||
+		if (ver == SVR_8560 ||
 		    ver == SVR_8541 || ver == SVR_8555)
 			return 128;
 		else
 			return 256;
 		break;
 	case 0x2:
-		if (ver == SVR_8540 || ver == SVR_8560   ||
+		if (ver == SVR_8560 ||
 		    ver == SVR_8541 || ver == SVR_8555)
 			return 256;
 		else
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index 01fe85ffd57..8e9808953dc 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -593,7 +593,7 @@ int get_clocks(void)
 	 * for that SOC. This information is taken from application note
 	 * AN2919.
 	 */
-#if defined(CONFIG_ARCH_MPC8540) || defined(CONFIG_ARCH_MPC8560)
+#if defined(CONFIG_ARCH_MPC8560)
 	gd->arch.i2c1_clk = sys_info.freq_systembus;
 #elif defined(CONFIG_ARCH_MPC8544)
 	/*
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 1e5d733ffce..ff6087904ba 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -26,7 +26,6 @@ static struct cpu_type cpu_type_list[] = {
 #if defined(CONFIG_MPC85xx)
 	CPU_TYPE_ENTRY(8533, 8533, 1),
 	CPU_TYPE_ENTRY(8535, 8535, 1),
-	CPU_TYPE_ENTRY(8540, 8540, 1),
 	CPU_TYPE_ENTRY(8541, 8541, 1),
 	CPU_TYPE_ENTRY(8543, 8543, 1),
 	CPU_TYPE_ENTRY(8544, 8544, 1),
diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index f07535cb5ea..d98673c40b3 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -321,8 +321,7 @@ void lbc_sdram_init(void);
  */
 #define LCRR_CLKDIV			0x0000001F
 #define LCRR_CLKDIV_SHIFT		0
-#if defined(CONFIG_MPC83xx) || defined(CONFIG_ARCH_MPC8540) || \
-	defined(CONFIG_ARCH_MPC8560)
+#if defined(CONFIG_MPC83xx) || defined(CONFIG_ARCH_MPC8560)
 #define LCRR_CLKDIV_2			0x00000002
 #define LCRR_CLKDIV_4			0x00000004
 #define LCRR_CLKDIV_8			0x00000008
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 695c89f2237..4479ef813c8 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -123,44 +123,9 @@ typedef struct ccsr_i2c {
 	u8	res[4096 - 1 * sizeof(struct fsl_i2c_base)];
 } ccsr_i2c_t;
 
-#if defined(CONFIG_ARCH_MPC8540)
-/* DUART Registers */
-typedef struct ccsr_duart {
-	u8	res1[1280];
-/* URBR1, UTHR1, UDLB1 with the same addr */
-	u8	urbr1_uthr1_udlb1;
-/* UIER1, UDMB1 with the same addr01 */
-	u8	uier1_udmb1;
-/* UIIR1, UFCR1, UAFR1 with the same addr */
-	u8	uiir1_ufcr1_uafr1;
-	u8	ulcr1;		/* UART1 Line Control */
-	u8	umcr1;		/* UART1 Modem Control */
-	u8	ulsr1;		/* UART1 Line Status */
-	u8	umsr1;		/* UART1 Modem Status */
-	u8	uscr1;		/* UART1 Scratch */
-	u8	res2[8];
-	u8	udsr1;		/* UART1 DMA Status */
-	u8	res3[239];
-/* URBR2, UTHR2, UDLB2 with the same addr */
-	u8	urbr2_uthr2_udlb2;
-/* UIER2, UDMB2 with the same addr */
-	u8	uier2_udmb2;
-/* UIIR2, UFCR2, UAFR2 with the same addr */
-	u8	uiir2_ufcr2_uafr2;
-	u8	ulcr2;		/* UART2 Line Control */
-	u8	umcr2;		/* UART2 Modem Control */
-	u8	ulsr2;		/* UART2 Line Status */
-	u8	umsr2;		/* UART2 Modem Status */
-	u8	uscr2;		/* UART2 Scratch */
-	u8	res4[8];
-	u8	udsr2;		/* UART2 DMA Status */
-	u8	res5[2543];
-} ccsr_duart_t;
-#else /* MPC8560 uses UART on its CPM */
 typedef struct ccsr_duart {
 	u8 res[4096];
 } ccsr_duart_t;
-#endif
 
 /* eSPI Registers */
 typedef struct ccsr_espi {
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e11498c6e78..77414c05aba 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1014,7 +1014,6 @@
 
 #define SVR_8533	0x803400
 #define SVR_8535	0x803701
-#define SVR_8540	0x803000
 #define SVR_8541	0x807200
 #define SVR_8543	0x803200
 #define SVR_8544	0x803401
-- 
2.47.3

