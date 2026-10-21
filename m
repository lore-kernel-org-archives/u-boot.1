Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1307606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GAplnuo4;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=kGURYpHB;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Qw4m6N9+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A43781217;
	Wed, 21 Oct 2026 16:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doefGFgPR2uj; Wed, 21 Oct 2026 16:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 992DC8120E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599384;
	b=PxewXg6xhsaXVE013LwNnVuK4ep48jMxYhi7oVeUdoAI0t+eFWtlwVlu0i3NN0USmIN5
	 U7W9OH7PgFnnLGc0nNgof+/hqXsGK+oXGfL7ZYDiFwdFiBMR/0cdQ/Vjm0zJfMoDgHsH0
	 t947gTj/qhMCqx2Z+vc7Ky0XGnMG8tHh1siiA4NmmJ4urq1EdWQHHijpnBVdsvjJlT+y6
	 Q1OksNeMqqzyU7G3gZaS4Sg2hxFio4zgC8252H5ed9cj/2u+w0z1DJ8gycPD5QnN3NlAa
	 KIBg8CYNJqt1pp5FcMjFd8NYKfJar5Geue4sNroD3ApMQq3xIDDTGwuUKIN6j7CMsVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2TV9L3xcIi+rMojg7FAadcXsRKPKvAKqkfRLIDufbko=;
	b=cAjeChWlyFzvv3mZCl9Q0LcTTb4gTZCdZSSGdTtuU5WoPDHKtlGFeY6O+YsyoC/i2AVo
	 oAkXn0jEalvbeNV/yry0G2GTShnbuV7Im5l3bkfBeyVtzt/09cgdwTCsynG7vnIanbDPh
	 Hzwc/qjN8eREP34WxZyqlL04GcBvolxfBkRLI+lHIaN1q7A+MQo+U6OESLt38bfXCQXZL
	 SrndsbalipDcy0srupNinmJKMh3tZ/vxYWSmob8YG30cX/su2oz0KHA8+3KS7rraM2F6v
	 /Ro2nmEfOZrfqiANvTHS3zIVQ0iLFNI08gzOy+VwrDVCwJ33BmDq5tVlbAa8UMS5W2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599384;
	bh=2TV9L3xcIi+rMojg7FAadcXsRKPKvAKqkfRLIDufbko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GAplnuo4PQ5Yz5rCy/izBRq7jqNCftGBORutk4/eMg/e8AJ6rNt7SD0jUYUy9sOmq
	 6rVo8fXoHXMCanek4+WaQSX6RK+yqS2LsFH7tMzgqEp7xq5xmiDNyIwxZiA3bnt8fZ
	 8KSLzPX568qRn1LLqlqv9jLmzbH+dy+iq7KWz9gqxkS//6FnYhPiDd+UBblFrEc3LM
	 3k2DK/Tlu7OWKKg8Rkh+trcDJ11AluCpIhCuCUaFN1IzjNz0cE0Y9oOdyF848uYJhL
	 DNWx1P0HqunGZeja3dZo9Z6Nu7buhp8vzEbSWhW/yzjK0EdL8sxVmjVCmjZbdLNCy2
	 axF2QLf7x5MZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992DC8120E;
	Wed, 21 Oct 2026 16:16:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 9A463356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 80E864084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id sMRgj7b-wW_Y for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C36040879
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598517;
 b=esAZToHtJhtxtx03kQb1G1HvdhEb/Fts6Q8cp4zoS+d7Epx4iY3dleE2QX0dWNT8MZQr
 s/LM4WP2QB2vkNpvWAG3h+WzhdVbU/wRXt1ybsps75g8lglSxR4SofY4QmYoWKKKsrfTa
 qJd06UBlcAYcMh4Y6J9UqjNoxzoh5TiptAFcWvfijhs4mcopJvzaqXg9wBjKzFIaCROwb
 Nz/gO/TN9SclHj5KeIfVZFBws/2eIxR7TEusFs0T/Db9rDz39KFr9ip9A+ut+yDhQVFWy
 3hOlYd/FjUUv2UzOfF9Kr9WwLPrjTbU7SZTwL1FWx8oV9gRBciMdF9y21x0fUQqT3NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598517;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2TV9L3xcIi+rMojg7FAadcXsRKPKvAKqkfRLIDufbko=;
 b=RdO/OiwD75sdcqtwFi4bQSElIlRRMxtL9ruRy0e7oYmpNE+Ft14lGE1FjhzqssQJp3YX
 6+jEq0lCaH305xLZxSy2C3bHD/+4qelVmu5Ilmj9TxghI5aIsHRANRSxe4PjiYOJ2bHEY
 QlxMOjJMYhaxG6e4soj8175xTXg3b8XQH3QzWs+XuX5bZb4gqBQScXunQsG46ZrpVPkJb
 sk2yuFH9lsMwFbPAL/fOjp9nI/DKBvIaBkbh0KUDHE2dS3LCYU3bIaN8wxpVwEsM5pQfy
 nos0/uIxLzW75HEcVmlz1ZggTi4x70WcJB13I2ehhP6b7O9A2wvyH9kg33kvdCFJYbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=kGURYpHB; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Qw4m6N9+; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=kGURYpHB; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Qw4m6N9+
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 4C36040879
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598513; bh=2TV9L3xcIi+rMojg7FAadcX
 sRKPKvAKqkfRLIDufbko=; b=kGURYpHB4RpCBqKxjrUn6QCy8QDc0ZMmKJy7RUHxzlsJNKsdut
 Al0rcUbRXkNMmpOK14RwJGJzuKj/W8789FAGZvvBidbE9jqFu0ZIcSioAeYD65Dx3CSxU/WYR5U
 vrVFqtGoPxci72qNbUEdZ1sQl2O8ax/S7pY+Gex7mWvV4AX+vc3jhhZw4Bydhrv91tILqYdnFat
 Av1miwia0uJnzSE6RBgEN/bJKyxPAHwIJl5anQwJXrujFkftQJq26RvBYAkxlKs4TIDBkb4F/tE
 o1dXJYZWsgkeceHwdklMfDoFIORlvixdZVgiVl6aLVSFvp+lu+oMHJq2VqhHvQYHUQw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598513; bh=2TV9L3xcIi+rMojg7FAadcX
 sRKPKvAKqkfRLIDufbko=; b=Qw4m6N9+t0HLSnD5eE4ectCErNv0tpHnoeqE4gybZU1HpV6HHK
 2DL/ILPzhVt79G7CThsR5m96TieYgN+stLBg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 18/26] powerpc: mpc85xx: Remove MPC8560 support
Date: Wed, 21 Oct 2026 16:01:14 +0000
Message-ID: <20261021160145.10430-19-brads@mainlining.org>
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

No board in the tree selects ARCH_MPC8560, and the SoC is unmaintained.
Remove the unused architecture configuration, reset and clock handling,
and CPU identification.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig      |  9 +--------
 arch/powerpc/cpu/mpc85xx/cpu.c        | 17 -----------------
 arch/powerpc/cpu/mpc85xx/cpu_init.c   |  6 ++----
 arch/powerpc/cpu/mpc85xx/fdt.c        |  6 ++----
 arch/powerpc/cpu/mpc85xx/speed.c      |  4 +---
 arch/powerpc/cpu/mpc8xxx/cpu.c        |  1 -
 arch/powerpc/include/asm/fsl_lbc.h    |  2 +-
 arch/powerpc/include/asm/immap_85xx.h |  4 ----
 arch/powerpc/include/asm/processor.h  |  1 -
 9 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 2d405501c57..bcdeef59fe7 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -335,11 +335,6 @@ config ARCH_MPC8544
 	select SYS_PPC_E500_USE_DEBUG_TLB
 	select FSL_ELBC
 
-config ARCH_MPC8560
-	bool
-	select FSL_LAW
-	select SYS_FSL_HAS_DDR1
-
 config ARCH_P1010
 	bool
 	select A003399_NOR_WORKAROUND if SYS_FSL_ERRATUM_IFC_A003399 && !SPL
@@ -756,7 +751,6 @@ config SYS_CCSRBAR_DEFAULT
 	default	0xff700000 if	ARCH_BSC9131	|| \
 				ARCH_BSC9132	|| \
 				ARCH_MPC8544	|| \
-				ARCH_MPC8560	|| \
 				ARCH_P1010	|| \
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
@@ -969,7 +963,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_P1024	|| \
 			ARCH_P2020
 	default 10 if ARCH_MPC8544
-	default 8 if	ARCH_MPC8560
 	help
 	  Number of local access windows. This is fixed per SoC.
 	  If not sure, do not change.
@@ -1104,7 +1097,7 @@ config SYS_FSL_IFC_CLK_DIV
 
 config SYS_FSL_LBC_CLK_DIV
 	int "Divider of platform clock"
-	depends on FSL_ELBC || ARCH_MPC8560
+	depends on FSL_ELBC
 
 	default 2 if	ARCH_P2041
 	default 1
diff --git a/arch/powerpc/cpu/mpc85xx/cpu.c b/arch/powerpc/cpu/mpc85xx/cpu.c
index c33250faac6..b4e9f6aac66 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu.c
@@ -301,22 +301,6 @@ int checkcpu (void)
 
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-/* Everything after the first generation of PQ3 parts has RSTCR */
-#if defined(CONFIG_ARCH_MPC8560)
-	unsigned long val, msr;
-
-	/*
-	 * Initiate hard reset in debug control register DBCR0
-	 * Make sure MSR[DE] = 1.  This only resets the core.
-	 */
-	msr = mfmsr ();
-	msr |= MSR_DE;
-	mtmsr (msr);
-
-	val = mfspr(DBCR0);
-	val |= 0x70000000;
-	mtspr(DBCR0,val);
-#else
 	volatile ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
 
 	/* Call board-specific preparation for reset */
@@ -331,7 +315,6 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	/* Attempt last-stage board-specific reset */
 	board_reset_last();
-#endif
 
 	return 1;
 }
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index c6923a797f9..7970c296e5a 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -546,8 +546,7 @@ int l2cache_init(void)
 		return -1;
 		break;
 	case 0x1:
-		if (ver == SVR_8560 ||
-		    ver == SVR_8541 || ver == SVR_8555) {
+		if (ver == SVR_8541 || ver == SVR_8555) {
 			puts("128 KiB ");
 			/* set L2E=1, L2I=1, & L2BLKSZ=1 (128 KiBibyte) */
 			cache_ctl = 0xc4000000;
@@ -557,8 +556,7 @@ int l2cache_init(void)
 		}
 		break;
 	case 0x2:
-		if (ver == SVR_8560 ||
-		    ver == SVR_8541 || ver == SVR_8555) {
+		if (ver == SVR_8541 || ver == SVR_8555) {
 			puts("256 KiB ");
 			/* set L2E=1, L2I=1, & L2BLKSZ=2 (256 KiBibyte) */
 			cache_ctl = 0xc8000000;
diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index e115c19cf8d..e7d1d9473d2 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -229,15 +229,13 @@ static inline u32 l2cache_size(void)
 	case 0x0:
 		break;
 	case 0x1:
-		if (ver == SVR_8560 ||
-		    ver == SVR_8541 || ver == SVR_8555)
+		if (ver == SVR_8541 || ver == SVR_8555)
 			return 128;
 		else
 			return 256;
 		break;
 	case 0x2:
-		if (ver == SVR_8560 ||
-		    ver == SVR_8541 || ver == SVR_8555)
+		if (ver == SVR_8541 || ver == SVR_8555)
 			return 256;
 		else
 			return 512;
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index 8e9808953dc..ed4ae33e6a8 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -593,9 +593,7 @@ int get_clocks(void)
 	 * for that SOC. This information is taken from application note
 	 * AN2919.
 	 */
-#if defined(CONFIG_ARCH_MPC8560)
-	gd->arch.i2c1_clk = sys_info.freq_systembus;
-#elif defined(CONFIG_ARCH_MPC8544)
+#if defined(CONFIG_ARCH_MPC8544)
 	/*
 	 * On the 8544, the I2C clock is the same as the SEC clock.  This can be
 	 * either CCB/2 or CCB/3, depending on the value of cfg_sec_freq. See
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index ff6087904ba..0a5232ef9eb 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -33,7 +33,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(8547, 8547, 1),
 	CPU_TYPE_ENTRY(8548, 8548, 1),
 	CPU_TYPE_ENTRY(8555, 8555, 1),
-	CPU_TYPE_ENTRY(8560, 8560, 1),
 	CPU_TYPE_ENTRY(8567, 8567, 1),
 	CPU_TYPE_ENTRY(8568, 8568, 1),
 	CPU_TYPE_ENTRY(8569, 8569, 1),
diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index d98673c40b3..9efb6ae6cd0 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -321,7 +321,7 @@ void lbc_sdram_init(void);
  */
 #define LCRR_CLKDIV			0x0000001F
 #define LCRR_CLKDIV_SHIFT		0
-#if defined(CONFIG_MPC83xx) || defined(CONFIG_ARCH_MPC8560)
+#if defined(CONFIG_MPC83xx)
 #define LCRR_CLKDIV_2			0x00000002
 #define LCRR_CLKDIV_4			0x00000004
 #define LCRR_CLKDIV_8			0x00000008
diff --git a/arch/powerpc/include/asm/immap_85xx.h b/arch/powerpc/include/asm/immap_85xx.h
index 4479ef813c8..b646d24bc6b 100644
--- a/arch/powerpc/include/asm/immap_85xx.h
+++ b/arch/powerpc/include/asm/immap_85xx.h
@@ -123,10 +123,6 @@ typedef struct ccsr_i2c {
 	u8	res[4096 - 1 * sizeof(struct fsl_i2c_base)];
 } ccsr_i2c_t;
 
-typedef struct ccsr_duart {
-	u8 res[4096];
-} ccsr_duart_t;
-
 /* eSPI Registers */
 typedef struct ccsr_espi {
 	u32	mode;		/* eSPI mode */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 77414c05aba..b78a726445d 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1021,7 +1021,6 @@
 #define SVR_8547	0x803101
 #define SVR_8548	0x803100
 #define SVR_8555	0x807100
-#define SVR_8560	0x807000
 #define SVR_8567	0x807501
 #define SVR_8568	0x807500
 #define SVR_8569	0x808000
-- 
2.47.3

