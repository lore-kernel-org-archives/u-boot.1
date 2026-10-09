Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C11ACA9EC1
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 618FE814D5;
	Fri,  9 Oct 2026 19:54:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsIkicX2I1nU; Fri,  9 Oct 2026 19:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 912DF81587
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575676;
	b=NFdJzVtSjN7yUG7rrxMz7heG4Vs3e1Il53i4fcH6EVgn9caqJU5I0eSBpiHK8xgNPVYz
	 dQh277trACbC7YBmXOU4dAwJ9/B53sDUZnywFqM65PlUk+U0vc7ybYDQZi2f0bJ9RVKaU
	 c8Yp3h/YQNf+s3PdFTI1yLFjwW4khqPmLOBJalinPPbHknXGxU1krAc5+PwjTkx9gJ6rm
	 QD4k7TY3DLHLKgyLv2ETFTMdycUNWQuBgGWflEhcP/UaZA4fa3dlPaQv0FYBg9D1gSYma
	 Gau6LrpJfQ58XId0n7METOivNZ5ZtJhV+2gdCd5bQ+ZcyZFfKfPFvwhBjSykVZG0ZYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QX++3A+n2WoSW9KquOkBjwe6jAdw1qyWGr6T2N6MSuo=;
	b=aV1i9lUfKLqI2wMbW8D372xLXU830WWuLkD8AUD7Umx8sBSn4AKS412FbsYdu8Odwal7
	 U5mSGmzC7cUBBUnDV06RtHvEGQn16FOk0fsKRHqHCz1MVZbqfv7Ovjg5wKGhDj338ailr
	 /r7+QFoq5W4mPwG9uszU1rkRiORDjOFP/z9AYKS5jeUO6LQP3nxZf8FGAUTMrURPLqL15
	 09JpIM514QBYyUY221OAW2NOW/BV20JWQUbcCjTL7e8XHpKq2Qo3pvVpqCCOfdOmW+vbc
	 PDBqkf4qK325V4E5/27SKc427NviUiLTTeptYTkSXkYnuRLweCQEKkmExIdxcfWY8Og==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575676;
	bh=QX++3A+n2WoSW9KquOkBjwe6jAdw1qyWGr6T2N6MSuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oIEo6GnECDVe6vb+5HaDAKv5fkWxcg+F6/snoDZJgNHphEnbIu+8HzosuRTnc2vrX
	 nYs4otEQXXbyKnLiwJtiH7xtkENk1aLEiMa2LcejyrLa6LAcqooVDEInm0WAkrvx6N
	 Aj2rkTAieWxNQ+QmGUvbTpmTAZg/+Ssy4ReC0AXQyc3idOy7wZk2G46gyaJHfDLFTn
	 OU0jAHoisu0SjaDCH6c/fhm7legOYutXbZpVyNXvKEEL+ciZEcs4RP/EDgOXQYEnaj
	 pw2mt1A0JMbfqtlbIBFm3elaeiokvHrWsYr52cdg2c8Q7IDDCjrSTvy/oGZkQLHNsj
	 HI8lbG/OypCmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 912DF81587;
	Fri,  9 Oct 2026 19:54:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 7E08E13B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 7B593606F8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id HatXjhLDiJeG for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6050A6069C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574817;
 b=aFCgiBUlIedQQMSfL2zNcB5ROwY8e7XJJO7E/HaG0g9Tuyd+TadirP7UA7asQGy/OoYS
 m1jCmU5VUCSIyZ4xau3BwswoSFVYmoLNG96p979uNt0PLwzPrVRP1ruKTn+x3IvD4svT5
 4lWVyaehmuMkQRhPWJXEaVTgio/MGpYZxTT5s6OXcjlqNCFM3DxBHdAMNOAFLpC+gC43n
 1HEU1TcPK4Amn9i+XoWbhCsW9JRkMm5NP5Yma+LcsWxkd8yXBaqWOxa+P693RmNLbVpE7
 h+86wh0TFJpvb/Hyo2Aeh+UC2sBSx+vV65tzqVPp855lUM/ymIXNEojCbqf3aQjpvsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574817;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=QX++3A+n2WoSW9KquOkBjwe6jAdw1qyWGr6T2N6MSuo=;
 b=tS9VV74MxMpvRoPmjoWV364yxPZiDwsWgaXg6oC6NImtDfrF2HJNEZJW76paosvr/Mpt
 8lb6YxRsypF4nhrj0lawwK9OPtXLCzVCzC4VcAln/lNCJdA1TmJpoydrGk37KYbf3ZLrz
 bXWvqRO6IG7f4ndOUomYRB9U4sB0uT6xkAIxlA9XMc1S7LNb02UMkEzEtooYQZRQFH+3H
 YvYbNCtbxnSDcE/8Y3E1z8FWjb40llQ3deuOTsmHbSQjCfyRpCf7fkBoORnq7dA2N0p5T
 PUIt0TtpR9+HbfN9IvTy3YgAwePGGC2+TWmEJPAk+BeATjUaFzaKXPt/wpVzuNFNcyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=spzyI+77; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=1+qY2O3y; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=spzyI+77; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=1+qY2O3y
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 6050A6069C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574633; bh=QX++3A+n2WoSW9KquOkBjwe
 6jAdw1qyWGr6T2N6MSuo=; b=spzyI+77WQkrbG1qpuUBUQyJn4oRVcqyRzLMACmvLxQC8wnPlC
 mI8AVDRgckZAdgarr1O8EghsGATYQ2ORReBsxclnARf4HidGmqQKxlbptBttCKggUFL+OkQTaHB
 88x83dxkSW9GYRR7PRMSCtUy1HRQVSkjdK3vqGUiHJuhxQCyxVoEcggB4027gvIrB8PL0OGZkyP
 7/Ai4tUbhYG65Nr8BrVq5tGPRxjaH7fSxvuy8QL2EbgILjCjXi4QohvydJ+4DgFOMnibLVIspCj
 JVBIuoATCpdtt6NBe/ShAaQU4jGL9WGYyhSQlT+zSKR6AN4aukLdQHe+RuQkxZut3lg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574633; bh=QX++3A+n2WoSW9KquOkBjwe
 6jAdw1qyWGr6T2N6MSuo=; b=1+qY2O3ykIliCylGEdkZYj0CjlnDSTl7l2gJWi/NxtoaiL/eEP
 zlsKEYqHyVDtWKM2qEhIfCgoGBYhOB8cLRDA==;
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
Subject: [PATCH 18/26] powerpc: mpc85xx: Remove MPC8560 support
Date: Fri,  9 Oct 2026 19:36:56 +0000
Message-ID: <20261009193704.13061-19-brads@mainlining.org>
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

NXP lists MPC8560 as no longer manufactured, and no board in the tree selects
ARCH_MPC8560. Remove the unused architecture configuration, reset and
clock handling, and CPU identification.

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
index 8d652e36d17..3594c1e3de2 100644
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

