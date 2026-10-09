Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53FCCA9EC3
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D8094098F;
	Fri,  9 Oct 2026 22:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utA6Yp-krrDq; Fri,  9 Oct 2026 22:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E299640985
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583960;
	b=XhjFoCmcnFNPlk6KUOzhWtaqmPaPMH2KVwBr9KnG5eywAkTOJeX56JMYdO7Tfz5Z4EMd
	 3hrVHmy3pWnH8PUZvf+u+tWrKz2rXzZn/Oo4/0JBRk4FMqQnMefBjvH8/YCJGJ9XzwpLe
	 WZ5Su4t0Uyr8A01L0lPNk/9lkYH4XdecTy7btzy+V0iEktpKvg44JNFlGhMUEaVbEvy2L
	 kOvruaujkdo9JJoE76tfOdDmET7g7KeW+Qmddwdiz4c3Jv5noTyHLSQWRgpwkgc7FSMZH
	 7K7x2bSmb7oTjR7jZHrDtQLJMyh/rk12SzaUUMVvX+X8WsZbsC2HzFBZlvhxx5aUZYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MtZxZOH+am6IMku9leeRFy/51zDIIoQptuE/4vMPGbg=;
	b=ZWXKAPlZUQVP1ICDBaw8K71tDhqksbEctFhSZZbxFr7RaZq3Wy5cWUgNXgerCoa6GsWT
	 /SlwljwpEsLzvfQ6kE2y5eQ0L2ZSlX077MTjRvkypeTkASe0/G5AObc4BuCqxki3W5G4y
	 CSfb/m+wWuOZWRjRCBSfog160+YjmBZ3xHwcUIKikaMgfcvbj4pyWq3GT/nRtCvgd0KHi
	 CV1xsRoRL3G2xiad00z8eLOZ8tdw04bX4QN8/DvwGt2Kzv5mX9MrUT4qzvDuT3T+Hp1qO
	 8hdhUn8Um+yVxzvssNP9BIWe5ZioIMLVGwmKXwufK1Mpd53yVQdecKxy4kELcGneD2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583960;
	bh=MtZxZOH+am6IMku9leeRFy/51zDIIoQptuE/4vMPGbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZlAhJWf4QN4dJKlWTQOyOVU5ONlLaJ+aO6qAzjUe+8mrKokPxrkBbG8aQi7ZhJjJ
	 cPGLtPDkcHmi+vwLpCVD2e9ya4E4T6vUB38cb7BFGmJCZGLt58z0mG5CdEOX6/Nesv
	 W/yXcpZJfIJJELkoINRIFj8/5CQ23Iuc/7hb7A5Z6bUA+jAmKzSiOdskIVdbhGKBF8
	 8YMOWthZbspiMSAduZo/MtShqpfGvy90mEh1mS0vYti4sgPkkKKWQccEY2m/6eAs/Z
	 rlMlFeSpvioOHdhsY99w38Z0tRtTnvCCD/PGZS/MSa5LrdEUVa0Hu3DPNO482CxG8I
	 dR3dXSKu8+rWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E299640985;
	Fri,  9 Oct 2026 22:12:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id E1EF6380
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id D3376607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id fnS2c3F7dGn2 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C94F360672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583833;
 b=UPdPJt4MqlkPbv44gpZEvazdi4TEns7A7cqPZ50+gW1PXO0IHgOvROwPE4VwIpjXyUpY
 tIFQEmf9WXv6e3RERAFX4BEuPVnPQ4DzG4lYMLCbk2EH5ooddnMxevuwuQSvIBPwUX605
 aJpf/UejEabFhU9ZB6WSGDZ1ojLKZ6FH5JOgXAPbD7s0W986GYZJesAeUYYUbxMWmMVoE
 wSwDT8hjgJ8MScXoq96LRO0EED6Q0vbN1TO3JIzBO+w4bOZBRsH+R3LefZEidNX8Su0NT
 M7eVbRPVqG0ER6xBBHSOd5lJCGTwXClT06qsXRMR8sHE/FjPfaB5eB3w8Llj77seloA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583833;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=MtZxZOH+am6IMku9leeRFy/51zDIIoQptuE/4vMPGbg=;
 b=epIJ7+M2ncEn6FvLV0J6saWEMSknWJng0HcgR3mcPc1W0+kRmj/uIqxYHjD9qR2Y8Y2m
 aSFYxkTDfICGNn+gzBaxFe0pNQxASZIuxPcMCeiy7hxPL56UbG9mZdi4S9scJXxSWWRut
 PcTPS3aOMaGh6qkUvF3KLGK4FAn+pPp93stVRH8eBmCfn/RCRO0Ls4+FLlNIyH/Yumg+K
 SU9drF2NMaEmvyaBILKHub14fjA3H8rkrCaGp8TT1+IWNoOtGRwYQ2cSfzufVCXlIgm0g
 KMwyCtJGqkS5gxro56pJssupFGZT/yWu9AIDGvnFMIM/kFNU8RZzHbf7rOiyUpK3Y1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=HeYGztFf; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=E2R0ffo8; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=HeYGztFf; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=E2R0ffo8
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id C94F360672
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583823; bh=MtZxZOH+am6IMku9leeRFy/
 51zDIIoQptuE/4vMPGbg=; b=HeYGztFfrURZg5xr4oQIhkn0Io8YvlDYLQTgy/HYkWxbZ8hrkB
 ZrVmDkKFrTvMeP+OrWS2gj0fNc/cQDSqx1LegehmtIEZzHV5D2v1JA+oTU/O1K4vffNis3G7Szz
 Axm6mD3/gIvAUK1iiSk8vcCLyhUS3c/ilmUU8Kr4jNR3+DcoDFw8vfCx3uukxKqSLOZUtkuFgWd
 zwDFttvJsNB1tt9bPkeeqjl465ndg3M/HrDfXWR+NBd9BMxvMyBxiF967qvYSYWRLXJZm07PwoF
 Ep+KlCZ+acjL3KXLSYmhwn3W0SKeo6jJTzqbgx8F8hi8aBFBFU059vi7Yrf/gA8cA1A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583823; bh=MtZxZOH+am6IMku9leeRFy/
 51zDIIoQptuE/4vMPGbg=; b=E2R0ffo8P4+qkfK6qFzmo+UJdKAINJHO1NXiDNO12DT6HHTkGE
 UUBuavLKv0cYsctyPMTWoBwoNgYlUiQeHeAQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 13/26] powerpc: mpc85xx: Remove P1011 support
Date: Fri,  9 Oct 2026 22:10:03 +0000
Message-ID: <20261009221017.20385-14-brads@mainlining.org>
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

No board in the tree selects ARCH_P1011, and the SoC lacks active
community maintenance. Remove the unused SoC configuration, CPU
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

