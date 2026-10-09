Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA2ACA9EC3
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEE3740985;
	Fri,  9 Oct 2026 22:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUvpny6VhVgj; Fri,  9 Oct 2026 22:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 471CB4097B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583932;
	b=R6hZ925A6B8tpyH83IE5is9QUKQhXIUIqVPj1tYpU5UAowbhupWMMdhUG+kID9I0mxx4
	 8zIwoJr/pOyF8omheXQlfhnnZZ7Jz+KUnNXuPSA1m7oPJxEY0woFpDY/x24afteqUi4XJ
	 EgYUHDjaiDcTr3+DL+Hqz6Xod+zQvB+OFxIc1Kuq/OQ94nLwbdVZl2uOblIYZRrcdsHho
	 5F515PHMtBQ35fOI3a80n1ZeIGD9WfsMRrGsBDE3HjcIDlIE3PLFN1RhBWv+ayVjn0JqK
	 9obZMrFAyetRtoW9ktLCsBdYjokvEAfkZMx7rO0mgcXi27jQei90hrZ4dAfmbEGS9yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hbhR0T+GoFX38eXiFLBSOPbwmOaBtipkotBjqWAC0cA=;
	b=RyBdd0RLOz8HQ1Ubl/FJxaVQRzhG1axVMW27YlZDRqcrFUDEH9lvSfGYX5p/hR+1Vopx
	 2nKWURSZXhHzwhw4sphrbiUpZITGuuo+eBNQPfDF+SQmZwwzIMmcyB1fRYJ5U575cvhpV
	 jnJa6UzidapTg/Syo9MRUlloNSIFuwcvmtVzX6qCqBK7y2PX2qADe7/ABQyFr2a5sJrsJ
	 R4g7mvFiLCv60zaOUEyRuuCQFgcAcIAx/ZdKD8Vo9QBXTQjl2UtJlIYZ7VR31QniBqoDu
	 6rTRt8MTPhpIcIQJfTyHvZDl0y3v6SoMYDtZ/zdAr/dr3YS/6mK/Js92e5n5JMMf29A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="WQvv/KDa";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=DIbC66Ek;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583932;
	bh=hbhR0T+GoFX38eXiFLBSOPbwmOaBtipkotBjqWAC0cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zsq8vUf1AAdxUyI+JrkeU5r3Wzz0gkNndGZSFDxcya9wLqgNh5wk4XzPKiPmt1XZH
	 DK47parvKamBpe1e9N+Ra5viW9jBZR/L0rI987Vhf8AyYZUZt2vMFXxpV4Owaz/MHk
	 xwtTx89VdJ5u8GfiNQ76TkDuLuAOD0/cz3Q2hNLkX9ypdn5GnHln0F9mt+tYQLer4x
	 AhHDFbh0UUAfVIAMa6bgnoTxUxbMjCLxDl90yEuKus0eIAWKdypEzOBDIOqYaZUvOf
	 9NjQXJccYB93/MTPNGIB508RE3GT2nsCQADH0uDFe+ImznREUOYVZlqw4Lrhea0HuI
	 qPrV3e45U9z6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 471CB4097B;
	Fri,  9 Oct 2026 22:12:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 0BD80CC0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 32B7A408A2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id eM6V4WzqE9er for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD093408F8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583827;
 b=WWxgw/Dlm95SYoJLOJZDIdvssdSsOsUdcwCSVsHjOzEmANDJnJiiAKmFdOLfI9daXltn
 9MsC6rbbWF3K2csKhXHY2KFsCGNn1WoqVHiNkgKgH/AOx8YiBJffdNWo+5rfUrKrMwM6j
 BSNiwBvWtNXGoHG3Je/i3ji5jkmIQ9GSo4/5X6Ds2pjFAn7FlXw3/tMe507sWDjMPCIeT
 q2YlsSAcWsfh9742Lw3dxsFOA/4itpQxA5Ff5rkXjNYZuj7Kpk8PJEdb5it8a2tRgihnP
 /QI0W7lBgEa3rRYuoyvNP9I+rlAgqVNvAiYtXXGobXgAFy6zsoSjKF6hcvK3L3KdKcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583827;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hbhR0T+GoFX38eXiFLBSOPbwmOaBtipkotBjqWAC0cA=;
 b=dbunfgTzxJslGIhG8lPNJcHbX21Jq71T00WZjgZOIbDhX/gqopAu3tENJtZiOl41T04M
 5oCBaXR7Y7FOvtNTGsu4mL5Ye+2wvdxPbbJuvEtJwnSNUsy6YI225HeRNpWWgmDoMDUPv
 bAosKomBmRGwGvs9gErZCxu2gJ+DHS780weFJu79+eGukT2zbLjUcEZVk5HDsKxIxRMl9
 c1oky5arDTiwe1A1Pre0lTkmLhFuTKAXWYXRoJq+yS3AKnemvxurK54KNIcIgSEwZaXom
 z9EyCl0hkLgbDRKsyLJKCFWYFXPiBFSIq2DMQCfzZ/uXPq59XVs9huIzz18eYmjX7zg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b="WQvv/KDa"; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=DIbC66Ek; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=WQvv/KDa; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=DIbC66Ek
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id CD093408F8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583824; bh=hbhR0T+GoFX38eXiFLBSOPb
 wmOaBtipkotBjqWAC0cA=; b=WQvv/KDaajc5wZtGDzad/vMlu0uMYWhuiz2OeQAE2jO8c8J/hs
 x7/RMjs3xtTR7iGl7i4SDD14B8wESuBa4gXMu+ag9LsbVEypxMrQdo1FS+IZOaIxVTPHTcj+MtW
 uMI13eiu/GaG0Hv4Xqe93UzmUtE3CCPkYCLQUskFxOh5soanRqWt/vNA1MA3w9KWVY7luAD0ex2
 Pjy6ksg7SglFDF7EoEvEo1VL8jY14117p1LpzBgGUecchE+zauG6UwIFWaXwlpoz4ahuSA4s9Y/
 snUjhrGrjpxJYcXIWk8g76tKFvF9dui1eTDkFKlFRQ7Nsx7pyX+QEMXa9YsDk3TNM2A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583824; bh=hbhR0T+GoFX38eXiFLBSOPb
 wmOaBtipkotBjqWAC0cA=; b=DIbC66EkMt9dabGaoyNi8T6VSEgdO1o9tyK6nzO+51z0egnMWb
 ozSJTkRWv1RTAtG1GYENPd8bjbMyGzuorlAA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 17/26] powerpc: mpc85xx: Remove MPC8540 support
Date: Fri,  9 Oct 2026 22:10:07 +0000
Message-ID: <20261009221017.20385-18-brads@mainlining.org>
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
index 5ef82e84324..8d652e36d17 100644
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

