Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF0CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2158D608DF;
	Fri,  9 Oct 2026 19:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJVzgpeQyZ4g; Fri,  9 Oct 2026 19:54:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D2BD60727
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575695;
	b=NVJGvSsFZNOVUrOPh79mhwJaOAvoiZe6C+jkZ6L0bE4YCCXKtaIW9Jo2iaq2fJ+QIy/G
	 tBkScptDkgNKghzbjnF8FTAVlshckH7HCMTXXeNYZfqBfC37Hz5hwaZsDu2YXA01Hd5c6
	 pygSQCaj+/NOCw4U+vJSnm53ZGeF4GbzGEM9xMkPNE9Xhn+X4EXSTSTlmhs3QsFdQxZQa
	 tRHIRRBPD72kmh2m4utBmFw+xNsV2A+RMhXCmbI77kiYo4T9Xj//xw3ElaqxM5ZMNNIzd
	 VuStyRtkycgZAOfOyTOrQZgJupLBBMB7iHSLeUSs6fbBZ12Tq9M0n0sZ06YzlpQ7tnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0VaHERtN6BJd4/87ZXQuFx5RXZIFhA1puGtJwQnI7S8=;
	b=ERruHF35IpDB+kuVQPeYACV0Z/stHn6m62gwSsM8a99nAOr4JWGZ1JcTPXw8Znkb/T3j
	 1jCV9q304zKTKe4q9D6NLPcnlcWa4FcU1IV1BwJSK8fzCo6+xGFemXuBGxxhbBHStp2IC
	 4Du4jJDe8FFmgQse3dmZpQj6BLXDcwyOLdNMytWPkCP6gwouVhRP3UvejnfGbZGF6um7v
	 4m+S66rxtDNKd4/TK/B9dWqFY7QU8yqJTS95DeYbY7b4lSs2KQYN50OASOy6aqkzaTuVs
	 P1Yj997qDQAhdu9haGwDDWDa1tCxIc+68X4mVnPO5SvdqR6PFBQB5QhoQBBisdVWQsQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575695;
	bh=0VaHERtN6BJd4/87ZXQuFx5RXZIFhA1puGtJwQnI7S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cRRKkozsMzYTM1M4RXuM7jOZLtmeRdE9BKt7oGdkwN4f7g/xvBrimAjo3nnBBHwv0
	 f+2rWWqYwHoEftBT9lFXVCkw8py36gCzPK00VU15YEJ+GN9MMfTwwuLkP2HHNHUMjN
	 yNENQ7TXaiYJOY8XBwoWmSGZ153mByMyBttPNaWyrAKr9LlPiMMKrUgkTyYYA8M1EG
	 VwLCeOinoFVKzDKCizrzQAQzilQS2qhMYNJpo0gm908wAGzKzepW159CyI0dKLUDLH
	 9HCbaA5EbWHPUeI9vY4hVeZshF8HRlaBzp55MwZEIrC+FrNMcasXK1F8wb5iKp9SHM
	 BYcNxnp5YpqwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D2BD60727;
	Fri,  9 Oct 2026 19:54:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 3AE113B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 2073540935
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id F9xSFIc9gv6N for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E6E6408CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574820;
 b=J5OBy4OcaqFzIvkbiasyQFuxksMS8mgELE/TYujaokp6yT+iH6YAx1OtnGtKeJBhpe4v
 pNFdGx5Vzbef73KX+WAPZWekj01D+F8JW2/+wLwy9kQitKUaWtVajFpsNjndPGiwfrava
 3V6QYsg8u7QLwp4iD3WNyJpg1jpp5eLIyDd+wCb6r9BahdJRtDPg31c0j24fKrbpZuV8K
 w8Tm6XLMvOomjdhKnQ0eUVy3txjkbjF0T5Y6p5sANTdqy/GSMuuNkxyf23gSjdlK2jJ0x
 twoNOgDsbPtpoBHwqiEdgHg9t5SxLIONkdahmxE6+MFMUpYmjKC2Zp1iutik3onM24g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574820;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0VaHERtN6BJd4/87ZXQuFx5RXZIFhA1puGtJwQnI7S8=;
 b=mH9r8mBdR17rCfUPKAgU98pJ7Tmo0EJT8orGzuA54RNgmMY0imSoHHXafDS1dGhNpZMZ
 pvy/HClTLzccAWSWAzBqg+AaNRTbyucdmr+h5mV3JIJessDy586QhBfM+lNLnkTSrOwX7
 HujSF/hZJtiU8HmP67alSwKtZYrbLvJknHVUeN2zYhby1pUtzqrjyKTv4aB1Ac1edmamL
 srbSmbXlG1C33vQ0yG4DPNpqE0ROHAdjJpTP7lpH86wtXlvZP5liLJL86Lavx4j9Kqq63
 c+aqwcqhfOF4+DCY0jjR22kIsLoSav2Vr05CEH3Gb2LmVn5uFuKutMArLaZlhO5LRTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=UvY2CxiI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=U8jn3fwd; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=UvY2CxiI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=U8jn3fwd
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 2E6E6408CB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574630; bh=0VaHERtN6BJd4/87ZXQuFx5
 RXZIFhA1puGtJwQnI7S8=; b=UvY2CxiIBBkfSHuMDA+PKrtJr0/7yW0BDGMplG2vi2bwTcGoOF
 CGNzeT8wXT+hghQJxjhu0+Zx5UDEDk4FTdYfugnVTaRtJvKL4A0/uUIKnz5TDHtToGYKFjLW7xF
 ZpoKIAXDpAXjkFV1XxHtau2NhvTRXAfsTG2xPnZ31+4rDtZuM+pM/hVx5m6tgS3S1zRBpWsD7/C
 MOagYPqraLFtL70eZtAFGf1SxiF5X09CDg7lMg+v3icM5EG1wbKHwYAWIIaxjFwyvkD17zh+nRn
 R/pLCS3vpUYFObt8hvMN+lBnUULINHkzPr9kxtd/zUSZXMmt04K2yFg1b5puVd6sx9g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574630; bh=0VaHERtN6BJd4/87ZXQuFx5
 RXZIFhA1puGtJwQnI7S8=; b=U8jn3fwd4VcxQoM2+TBZiYqmiFVy/g/OKo4X7VvTlDXwyCHkAz
 eHngWEThG3/dLYBGsKphrsNDpGAwdbOxL5BQ==;
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
Subject: [PATCH 13/26] powerpc: mpc85xx: Remove P1011 support
Date: Fri,  9 Oct 2026 19:36:51 +0000
Message-ID: <20261009193704.13061-14-brads@mainlining.org>
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

NXP lists the P1011 parts as end of life, and no board in the tree
selects ARCH_P1011. Remove the unused SoC configuration, CPU
identification, and stale boot documentation entry.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/Kconfig                         |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig     | 20 +-------------------
 arch/powerpc/cpu/mpc85xx/Makefile    |  1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c       |  1 -
 arch/powerpc/include/asm/processor.h |  1 -
 doc/README.mpc85xx-sd-spi-boot       |  1 -
 6 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d63afeb138..07214f2af7c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -470,7 +470,7 @@ config SYS_IMMR
 	default 0xF0000000 if ARCH_MPC8313
 	default 0xE0000000 if MPC83xx && !ARCH_MPC8313
 	default 0x01000000 if ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
-	default 0xFFE00000 if ARCH_P1010 || ARCH_P1011 || ARCH_P1020 || \
+	default 0xFFE00000 if ARCH_P1010 || ARCH_P1020 || \
 			      ARCH_P1021 || ARCH_P1024 || ARCH_P1025 || \
 			      ARCH_P2020
 	default SYS_CCSRBAR_DEFAULT
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index b1b134ca990..ab66ffadebd 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -399,21 +399,6 @@ config ARCH_P1010
 	imply FSL_SATA
 	imply TIMESTAMP
 
-config ARCH_P1011
-	bool
-	select FSL_LAW
-	select SYS_FSL_ERRATUM_A004508
-	select SYS_FSL_ERRATUM_A005125
-	select SYS_FSL_ERRATUM_ELBC_A001
-	select SYS_FSL_ERRATUM_ESDHC111
-	select FSL_PCIE_DISABLE_ASPM
-	select SYS_FSL_HAS_DDR3
-	select SYS_FSL_HAS_SEC
-	select SYS_FSL_SEC_BE
-	select SYS_FSL_SEC_COMPAT_2
-	select SYS_PPC_E500_USE_DEBUG_TLB
-	select FSL_ELBC
-
 config ARCH_P1020
 	bool
 	select BTB
@@ -831,7 +816,6 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_MPC8544	|| \
 				ARCH_MPC8560	|| \
 				ARCH_P1010	|| \
-				ARCH_P1011	|| \
 				ARCH_P1020	|| \
 				ARCH_P1021	|| \
 				ARCH_P1024	|| \
@@ -1041,7 +1025,6 @@ config SYS_FSL_NUM_LAWS
 			ARCH_BSC9132	|| \
 			ARCH_MPC8536	|| \
 			ARCH_P1010	|| \
-			ARCH_P1011	|| \
 			ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1023	|| \
@@ -1156,8 +1139,7 @@ config SYS_PPC_E500_DEBUG_TLB
 	depends on SYS_PPC_E500_USE_DEBUG_TLB
 	default 0 if ARCH_MPC8544
 	default 1 if	ARCH_MPC8536
-	default 2 if	ARCH_P1011	|| \
-			ARCH_P1020	|| \
+	default 2 if	ARCH_P1020	|| \
 			ARCH_P1021	|| \
 			ARCH_P1024	|| \
 			ARCH_P1025	|| \
diff --git a/arch/powerpc/cpu/mpc85xx/Makefile b/arch/powerpc/cpu/mpc85xx/Makefile
index 93b0c28ca03..f78131dd61a 100644
--- a/arch/powerpc/cpu/mpc85xx/Makefile
+++ b/arch/powerpc/cpu/mpc85xx/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_SYS_FSL_QORIQ_CHASSIS2) += fsl_corenet2_serdes.o
 obj-$(CONFIG_ARCH_MPC8536) += mpc8536_serdes.o
 obj-$(CONFIG_ARCH_MPC8544) += mpc8544_serdes.o
 obj-$(CONFIG_ARCH_P1010)	+= p1010_serdes.o
-obj-$(CONFIG_ARCH_P1011)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1020)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1021)	+= p1021_serdes.o
 obj-$(CONFIG_ARCH_P1023)	+= p1023_serdes.o
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 47daf51fc1b..641d2a199f8 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -41,7 +41,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(8569, 8569, 1),
 	CPU_TYPE_ENTRY(8572, 8572, 2),
 	CPU_TYPE_ENTRY(P1010, P1010, 1),
-	CPU_TYPE_ENTRY(P1011, P1011, 1),
 	CPU_TYPE_ENTRY(P1012, P1012, 1),
 	CPU_TYPE_ENTRY(P1013, P1013, 1),
 	CPU_TYPE_ENTRY(P1014, P1014, 1),
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1d6f960be94..36d8660cddc 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -1033,7 +1033,6 @@
 #define SVR_8569	0x808000
 #define SVR_8572	0x80E000
 #define SVR_P1010	0x80F100
-#define SVR_P1011	0x80E500
 #define SVR_P1012	0x80E501
 #define SVR_P1013	0x80E700
 #define SVR_P1014	0x80F101
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 8e98fc9f659..086c8f9e49b 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -60,7 +60,6 @@ P2020DS		config_sram_p2020ds.dat
 P1020RDB	config_ddr2_1g_p1020rdb_533M.dat
 P1020RDB	config_ddr2_1g_p1020rdb_667M.dat
 P1020RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
-P1011RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1010RDB	config_ddr3_1gb_p1010rdb_800M.dat
 P1021RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1022DS		config_ddr3_2gb_p1022ds.dat
-- 
2.47.3

