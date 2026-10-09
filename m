Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9518CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86262814FE;
	Fri,  9 Oct 2026 19:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A61Am1tPPYGt; Fri,  9 Oct 2026 19:54:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F0EF81495
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575661;
	b=ZnQ8LN3SUTOvxlChxe9CrSB946Z2NQzl8rQmVu1Xgap+dw0//EA8eupNDCsPN+/OO+tE
	 vS/f4tLcgi/kxEekXinSdVlIEJSIytmCZiTCIUjmh6ncYOPwGsA4bYzBfDsnS8BbggMol
	 Y1pIZYOj4Vvm4fqt4MSyfm+j1SM/Ew7gezUDD4FRsFHu2MCTfF9Ag++lW2c6FUUrzkGnn
	 JOJ2UmFv4YA3IQpFKKkFmZhmZWN+poGKO2G93hWQvsZ+1AMbmIFHasqif15eUbXXS1ymL
	 riU2fZ0uMMnnEjyvunvON/ixnuAbvr+ePAlzT/6GNWOGxT72GQQOpdU5DuvF9eG0xHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yxn6llNOh8raB5/x4SUtCLY+t60S1GV76ZspCYPu9ZQ=;
	b=TqW2QfGM2VdHIOOweORzNngzM/ranuNLezBjTz/L4w6G9WN0HU9SLOBzV5blv6l74xSv
	 ixyLLs/Vdmy/HD0c4Pp2zkkhIAWug6wdPrk41qPVzvmJSILDTqmiULM/27uXutD+vFLV6
	 ZkA61t+RQIqvj4Wap/noq91lGiYpHHwL/9+QFNzwFZTB07d4HEVuqNZczMVhYpImAemPp
	 IfEtgWZvcPbdZEHJvnCY7f5vKlfJF9yLqTjASjP2OsDQ62b8HKaYd5Mz/2uRz3hYrqdlF
	 O0iyz2gJPzc55eAJ2G7aU86pK/iFBeMoOmUiJ6lOGANpAJKL4bEALX6g0wQeihlZomQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=ZTHqEmzr;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=3SJacRUY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575661;
	bh=yxn6llNOh8raB5/x4SUtCLY+t60S1GV76ZspCYPu9ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3DPWn7LDYrV5sqb9oxpEFR8DgZrvDuf8Mutza4ZLYm7dZuWtRU/AoRvbGfNywSM7
	 ugy12rcy2TGB6i69VQqUmwoOwJCr050T5XvBsfBhGZX9H8ptl03IOzWaPL5jOtVhmp
	 i1Lw4bWaPDwDYquFKj78mAw+3PQMQo9D9CtX6ih7m/OY6lmVb7BKNXwP010yy2GumW
	 f01kjVa185aiBQMBKf2Q5b4DCgezsXtd7+vJWBW0y1tYZ5ASw2XhGLcb9UMdozNnht
	 YNQGR4XzmKk/FAB4cFvQcSDtSlg07n3W2KSA1PxvHmm2p6PvXKbr5jUqeLiGA3dad/
	 hBbh6iBNuFEvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F0EF81495;
	Fri,  9 Oct 2026 19:54:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 68216380
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 4E4C78149A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id uRECBJTGQ0hw for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2FF2F8148F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574810;
 b=adC9mHgZ9r2BfawrJ8keEFkZmhjqoi79oVbfCztyy2/TDhPbZpCvzw7W3lmhGcCR28RK
 zAulZ0wTJSppqamjF3qt+/K03NEdDWU7OE9ixsFwMAdejrmKdHCPl0PFion33Q0DMIJRJ
 JpA5dOaBFRzF2T2GK/hGvSLV+KXw5mlJLR6+uyNFW784uMNvMjeL5j4zpuuOgAm311iBx
 JpfgNeylObXWadmG2mP74EZW81ZFA8BGuJXdOzlH3O3WPzPbVnVqZey837+deMp1yDDkP
 SdJLdgz6hAKqrR1iCw0yTOiN1LPp0kzusT+xdD0snUhvgRPfaeWhrUYy3AcyTaPbuqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574810;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=yxn6llNOh8raB5/x4SUtCLY+t60S1GV76ZspCYPu9ZQ=;
 b=OV7AUVU9YhsUsGP7AIzag1/q4CRGFdMAbV78QBjp0idGxgNlSBWK0SaF3xtWjm3AicWj
 fHW3f0jS/Jag8hVU3bUVUUBsrhqtlbmmu2hse8FQMO7IeCWu2wIyREyKkcJwcG/VMuMLg
 ZWnJZm9m70WC34GP2KMRr4bAHNkjUzD4ZafVm6gpJKw5Ta9Ky1DImy1lI0stPJULxVosL
 XsLKRspIywAGmaTkH8g+uvxYiSkPipoYmhPyMqAeFZeqogQRF8i5bSvGWUsg0WVwD46dT
 jEHbdSN1PQhai7sNhubRId5VG3EmL/6NTF+By8SShdWeSE4j/oisPNIM7avkvukAL6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=ZTHqEmzr; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=3SJacRUY; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=ZTHqEmzr; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=3SJacRUY
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 2FF2F8148F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574632; bh=yxn6llNOh8raB5/x4SUtCLY
 +t60S1GV76ZspCYPu9ZQ=; b=ZTHqEmzr5ZNaLpZZbdmrBCjn5JqEUpZsVynAI3cv8IzezszAUS
 /4ORhQDEB0mWbG5xRq7ebLR5Om37cSShRmMY+kkRgdrUHaytI9E7eJXs2DVdTOUAhOpnnHzqdG4
 6XJpGRHToDOUt3iqLJOZ1RFRRcGDuSzRxKW6u5YzzDitavtWTuF17QZR4mTKSCfjYOMPiL21iug
 X+dZHCmxfv4mS84X48cw7rxxP53izMqdkLMqikj0Tf3lnHbHjwa9j66SRPPzQRPs6Cnol/jkHgP
 eCWd1zNGpCysF6CeyNrUELk3mIDWfIQgai82a57lQ888UwKV8AKGUnWqyQYL3La1WmA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574632; bh=yxn6llNOh8raB5/x4SUtCLY
 +t60S1GV76ZspCYPu9ZQ=; b=3SJacRUYu6yAJVGIxMFo3VNoCgMAyfAGgmbyE0PyhHm85qHq2E
 itSaTMCysG/ogFm/Ull1uPB9iDpZ6jMbWVCw==;
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
Subject: [PATCH 17/26] powerpc: mpc85xx: Remove MPC8540 support
Date: Fri,  9 Oct 2026 19:36:55 +0000
Message-ID: <20261009193704.13061-18-brads@mainlining.org>
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

NXP lists MPC8540 as no longer manufactured, and no board in the tree selects
ARCH_MPC8540. Remove its architecture configuration, DUART definitions,
and CPU specific cache handling.

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

