Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A3606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gFBP56KC;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=kUqFaCcD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5881260EF9;
	Fri, 13 Nov 2026 02:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuPepITZUVuK; Fri, 13 Nov 2026 02:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE1C660EFA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537275;
	b=HFKMpfQtC3SGRk1H6xbZLrknPBDcU/yAqvtoB8JoG0F0TpxMuV8MZJEFjrrM/NBRKzYr
	 KWm+KfEQVdaoIfsnZc+TD79YdNwn78AnhCs4a3W/JYQD4qERN+zmHtx/g8MBBHTD65ZQg
	 jOC0v1jy7khupfDhhLgkTJwFXxPpElmfZYzbA6DNvjSDvaRYirwRfaUVougt+oEKV1WIL
	 stEsz5VcpRGZXr6XkMBF5L2qh0K09UsLVTbSXT2tCMNJg7rMYqy/SF1OWDkvJYINuMypg
	 1GYUCN9Sc2FY1poWPxWIir/+BzLYdDmTUAvToRtvdvNTvSV4nhQSIDb3Pq0gyVjnXhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qv4Ak8ae9PIcH0lCGLBzrmScOiowdZoXeNzZZS+pwdQ=;
	b=pOmBk61cVwCyR5XPfG1bEgNc2rd/5iXJpPLT6ny8bLKFGv87dLSvDQ7I2ygSUx7x/PA2
	 0tvByUK7qSsYSX9FMuev+u6p+pXuZZe0SJrNagYYKljtmMtUbri57/iosF0bheWBM2Gwx
	 rGsuVjSzyWA338nLBiHP4Z0UyZrrnWwGs4wSCVMbInveta/9Gq9+rZSAjbhc3XtGadIXS
	 hY6PJATS1V6mq6TD3GCy38h7mAK+NYDged1jeQ42vLBiSUZ2+8xOlU77Qpa7bnhm1pQ/D
	 Jmj/6Sixr9T61DkEy0+PmwLaos2GDVpGsUInmicHBwPHQ/dOGPk+74pw3RQNm88c6Bw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537275;
	bh=Qv4Ak8ae9PIcH0lCGLBzrmScOiowdZoXeNzZZS+pwdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFBP56KCt4qhygHgLvWw8M+sLdoSOVp+1A2s0wuWGikG5eVM89kpkS32vLQLPm0Xk
	 TiDk6JAL0ZgPGweFQJJ1xPpRujYKEl6DxXx1oEJC8U1FZK+NJ8FgrteevP0la8oHfu
	 wZm6Vd/iYWVCPI1e6s7TVOYn8X5j7L8i9vRaaGwZMxwhQ9i/gTVaMEBnrDV0rg/6P0
	 MIZj3fMnmWats54JLsMW2zNdL4CDEosl/1mLf+oI4LXZYuXXPtpmqQhEUfk7sHjMoF
	 G9osCpSqEl4pxT8u/BtbFWsb2YPIxrXN9rzSDZ7VmSjHL9aINhActjGsc9+A52yL9V
	 p0uPS220Zbw9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE1C660EFA;
	Fri, 13 Nov 2026 02:34:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26FFB2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 181CE40D7C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXIgZVT8a-zj for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8541C40D44
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=kUqFaCcD
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8541C40D44
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:29 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 6EBC84C8C8;
 Fri, 13 Nov 2026 13:34:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qv4Ak8ae9PIcH0lCGLBzrmScOiowdZoXeNzZZS+pwdQ=;
 b=kUqFaCcDEuojHBOQtvfsag6zETT5XXhYZ0j7Kp/1a+xVqbQKBwoZOmlffQKqeNTr4vt9Xo
 gdLpiINeUkXEhBkgoThtfNm4sGvnRsoNmVNSd2NWBntTBd+h0BmsFWw9HInMqWOikNIhuI
 MQnjhRS78uqI/zkHMNm/D9HyLmglX0qtvBt13wo0LF1kY02cAeunwQjQxguCzclRlXn6zj
 LR05uciWmY4EbMEmBR/UbNnbD4HUolITg/pO8C991q7a1bydWG3Jicl8OcXTs7UQ75ottO
 oMVV42nXB80hVL5SJKjocjK2NPaL7psoLWVITxLaXMtW2sNxAcp9DHmA8K4VTw==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 20/26] sunxi: sun60i: initial support for A733 SoC
Date: Fri, 13 Nov 2026 13:32:30 +1100
Message-ID: <20261113023236.569054-21-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Yixun Lan <dlan@gentoo.org>

Add basic support for Allwinner A733 SoC, including SPL settings:
- Introduce MACH_SUN60I_A733 Kconfig option and sun60i.h wrapper
- Program CPU_DA_DDR_CTRL_REG, AA64 mode, and RVBAR in boot0.h /
  rmr_switch.S for the AArch32-to-AArch64 RMR warm reset
- Configure 16 GiB max DRAM size, SPL text/stack/size layout, and TF-A
  BL31 load address at 0x58000 above active SPL
- Support A733 watchdog soft-reset key, R_TWI SPL PMIC pins, MMC2 pinmux,
  UART0_PORT_B0 option, and FEL SH_SRAM SPL header lookup

Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-9-f19dcd098f60@gentoo.org
Signed-off-by: Yixun Lan <dlan@gentoo.org>
[Alastair: Wire DRAM_SUN60I_A733 and SPL_DISPOSABLE_INIT_RODATA, add RMR
 AXI2HIF/AA64 sequence, watchdog reset key, R_I2C/MMC2/FEL SPL helpers]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/include/asm/arch-sunxi/boot0.h       | 20 +++++++++++++-
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |  1 +
 arch/arm/include/asm/arch-sunxi/spl.h         |  3 +++
 arch/arm/include/asm/arch-sunxi/watchdog.h    |  1 +
 arch/arm/mach-sunxi/Kconfig                   | 26 +++++++++++++++++++
 arch/arm/mach-sunxi/board.c                   |  6 +++++
 arch/arm/mach-sunxi/cpu_info.c                |  2 ++
 arch/arm/mach-sunxi/rmr_switch.S              | 22 +++++++++++++---
 board/sunxi/board.c                           | 21 ++++++++++++---
 common/spl/Kconfig                            |  4 +++
 include/configs/sun60i.h                      | 11 ++++++++
 11 files changed, 110 insertions(+), 7 deletions(-)
 create mode 100644 include/configs/sun60i.h

diff --git a/arch/arm/include/asm/arch-sunxi/boot0.h b/arch/arm/include/asm/arch-sunxi/boot0.h
index d79aea97a40..7010030a42f 100644
--- a/arch/arm/include/asm/arch-sunxi/boot0.h
+++ b/arch/arm/include/asm/arch-sunxi/boot0.h
@@ -32,7 +32,7 @@
 	.word	0xe580e00c	// str     lr, [r0, #12]
 	.word	0xee1cef10	// mrc     15, 0, lr, cr12, cr0, {0}
 	.word	0xe580e010	// str     lr, [r0, #16]
-#ifdef CONFIG_MACH_SUN55I_A523
+#if defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
 	.word	0xee1cefbc	// mrc     15, 0, lr, cr12, cr12, {5}
 	.word	0xe31e0001	// tst     lr, #1
 	.word	0x0a000003	// beq     cc <start32+0x48>
@@ -41,6 +41,18 @@
 	.word	0xee1ceffc	// mrc     15, 0, lr, cr12, cr12, {7}
 	.word	0xe580e01c	// str     lr, [r0, #28]
 #endif
+#if defined(CONFIG_MACH_SUN60I_A733)
+	.word	0xe59f1040	// ldr     r1, [pc, #64] ; CPU_DA_DDR_CTRL_REG
+	.word	0xe3a02001	// mov     r2, #1
+	.word	0xe5812000	// str     r2, [r1]
+	.word	0xe59f1038	// ldr     r1, [pc, #56] ; CLU0_CPU0_CTRL_REG
+	.word	0xe3a02001	// mov     r2, #1
+	.word	0xe5812000	// str     r2, [r1]
+	.word	0xe59f0030	// ldr     r0, [pc, #48] ; CONFIG_*TEXT_BASE
+	.word	0xe5810004	// str     r0, [r1, #4]  ; CLU0_RVBARADDR0_L
+	.word	0xe3a02000	// mov     r2, #0
+	.word	0xe5812008	// str     r2, [r1, #8]  ; CLU0_RVBARADDR0_H
+#else
 	.word	0xe59f1034	// ldr     r1, [pc, #52] ; RVBAR_ADDRESS
 	.word	0xe59f0034	// ldr     r0, [pc, #52] ; SUNXI_SRAMC_BASE
 	.word	0xe5900024	// ldr     r0, [r0, #36] ; SRAM_VER_REG
@@ -48,6 +60,7 @@
 	.word	0x159f102c	// ldrne   r1, [pc, #44] ; RVBAR_ALTERNATIVE
 	.word	0xe59f002c	// ldr     r0, [pc, #44] ; CONFIG_*TEXT_BASE
 	.word	0xe5810000	// str     r0, [r1]
+#endif
 	.word	0xf57ff04f	// dsb     sy
 	.word	0xf57ff06f	// isb     sy
 	.word	0xee1c0f50	// mrc     15, 0, r0, cr12, cr0, {2} ; RMR
@@ -57,9 +70,14 @@
 	.word	0xe320f003	// wfi
 	.word	0xeafffffd	// b       @wfi
 
+#if defined(CONFIG_MACH_SUN60I_A733)
+	.word	SUNXI_CPU_DA_DDR_CTRL_REG
+	.word	SUNXI_CLU0_CPU0_CTRL_REG
+#else
 	.word	CONFIG_SUNXI_RVBAR_ADDRESS	// writable RVBAR mapping addr
 	.word	SUNXI_SRAMC_BASE
 	.word	CONFIG_SUNXI_RVBAR_ALTERNATIVE	// address for die variant
+#endif
 #ifdef CONFIG_XPL_BUILD
 	.word	CONFIG_SPL_TEXT_BASE
 #else
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index 260fed24741..b59a120d780 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -63,6 +63,7 @@
 #define SUNXI_RTC_BASE			0x07090000
 
 #if defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_FEL_EL3_VBAR		0x00080000
 #define SUNXI_CPUCFG_BASE		0x08000000
 #define SUNXI_CPU_DA_DDR_CTRL_REG	(SUNXI_CPUCFG_BASE + 0x0200)
 #define SUNXI_CLU0_CPU0_CTRL_REG	(SUNXI_CPUCFG_BASE + 0x1000)
diff --git a/arch/arm/include/asm/arch-sunxi/spl.h b/arch/arm/include/asm/arch-sunxi/spl.h
index 14944a20eac..4473c605461 100644
--- a/arch/arm/include/asm/arch-sunxi/spl.h
+++ b/arch/arm/include/asm/arch-sunxi/spl.h
@@ -11,6 +11,9 @@
 
 #define SPL_ADDR		CONFIG_SUNXI_SRAM_ADDRESS
 
+/* FEL swap buffer backup address in SH_SRAM (A733) */
+#define SUNXI_FEL_SPL_ADDR	0x000e0000
+
 /* The low 8-bits of the 'boot_media' field in the SPL header */
 #define SUNXI_BOOTED_FROM_MMC0	0
 #define SUNXI_BOOTED_FROM_NAND	1
diff --git a/arch/arm/include/asm/arch-sunxi/watchdog.h b/arch/arm/include/asm/arch-sunxi/watchdog.h
index 14a6e89ccfa..950811523f3 100644
--- a/arch/arm/include/asm/arch-sunxi/watchdog.h
+++ b/arch/arm/include/asm/arch-sunxi/watchdog.h
@@ -31,6 +31,7 @@ struct sunxi_wdog {
 #else
 
 #define WDT_CFG_RESET		(0x1)
+#define WDT_CFG_KEY		(0x16aa << 16)
 #define WDT_MODE_EN		(0x1)
 
 struct sunxi_wdog {
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index f3f70b277b1..df686d63186 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -243,6 +243,7 @@ config SUNXI_SRAM_ADDRESS
 	hex
 	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
 	default 0x44000 if MACH_SUN55I_A523
+	default 0x47000 if MACH_SUN60I_A733
 	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
 	help
@@ -285,6 +286,7 @@ config SUNXI_BL31_BASE
 	default 0x40000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 0x00104000 if SUN50I_GEN_H6
 	default 0x00054000 if MACH_SUN55I_A523
+	default 0x00058000 if MACH_SUN60I_A733
 	default 0x0
 	help
 	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
@@ -367,6 +369,7 @@ config MACH_SUNXI_H3_H5
 config SUNXI_DRAM_MAX_SIZE
 	hex
 	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
+	default 0x400000000 if MACH_SUN60I_A733
 	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
 	default 0x80000000
 
@@ -581,6 +584,21 @@ config MACH_SUN55I_A523
 	select SPL_LOAD_FIT if SPL
 	imply OF_UPSTREAM
 
+config MACH_SUN60I_A733
+	bool "sun60i (Allwinner A733)"
+	select ARM64
+	select DRAM_SUN60I_A733
+	select FIT
+	select SPL_DISPOSABLE_INIT_RODATA if SPL
+	select SPL_LOAD_FIT if SPL
+	select SUNXI_A733_PINCTRL
+	select SUNXI_GEN_NCAT2
+	select SUPPORT_SPL
+	imply SPL_SYS_I2C_LEGACY
+	help
+	  Support for Allwinner A733 and T736 SoCs with octa-core ARMv8 cores,
+	  NCAT2 interconnect, and LPDDR5 DRAM controller.
+
 endchoice
 
 # The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
@@ -902,6 +920,7 @@ config SYS_CONFIG_NAME
 	default "sun50i" if MACH_SUN50I_H616
 	default "sun50i" if MACH_SUN50I_A133
 	default "sun55i" if MACH_SUN55I_A523
+	default "sun60i" if MACH_SUN60I_A733
 
 config SYS_BOARD
 	default "sunxi"
@@ -931,6 +950,13 @@ config UART0_PORT_F
 	  at the same time, the system can be only booted in the FEL mode.
 	  Only enable this if you really know what you are doing.
 
+config UART0_PORT_B0
+	bool "UART0 on PB0/PB1 pins"
+	depends on MACH_SUN60I_A733
+	help
+	  Select this option on Allwinner A733 boards that route the UART0
+	  serial console to PB0/PB1 instead of the default PB9/PB10 pins.
+
 config OLD_SUNXI_KERNEL_COMPAT
 	bool "Enable workarounds for booting old kernels"
 	help
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 38936afae24..c6dd3f317c3 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -523,6 +523,12 @@ void reset_cpu(void)
 	writel(WDT_CTRL_KEY | WDT_CTRL_RESTART, wdog + WDT_SRST_REG);
 	while (1)
 		;
+#elif defined(CONFIG_MACH_SUN60I_A733)
+	static const void *wdog = (void *)(ulong)SUNXI_WDT_BASE;
+
+	writel(WDT_CFG_KEY | WDT_CTRL_RESTART, wdog + WDT_SRST_REG);
+	while (1)
+		;
 #elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
 #if defined(CONFIG_MACH_SUN50I_H6)
 	/* WDOG is broken for some H6 rev. use the R_WDOG instead */
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index c3a51d9956e..f0b33bb9097 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -108,6 +108,8 @@ int print_cpuinfo(void)
 	puts("CPU:   Allwinner A133 (SUN50I)\n");
 #elif defined CONFIG_MACH_SUN55I_A523
 	puts("CPU:   Allwinner A523 (SUN55I)\n");
+#elif defined CONFIG_MACH_SUN60I_A733
+	puts("CPU:   Allwinner A733 (SUN60I)\n");
 #else
 #warning Please update cpu_info.c with correct CPU information
 	puts("CPU:   SUNXI Family\n");
diff --git a/arch/arm/mach-sunxi/rmr_switch.S b/arch/arm/mach-sunxi/rmr_switch.S
index a6d75c32ed9..2d3ca275037 100644
--- a/arch/arm/mach-sunxi/rmr_switch.S
+++ b/arch/arm/mach-sunxi/rmr_switch.S
@@ -55,7 +55,7 @@ start32:
 	str	lr, [r0, #12]
 	mrc	p15, 0, lr, cr12, cr0, 0	// VBAR
 	str	lr, [r0, #16]
-//#ifdef CONFIG_MACH_SUN55I_A523
+#if defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
 	mrc	p15, 0, lr, cr12, cr12, 5	// ICC_SRE
 	tst	lr, #1
 	beq	1f
@@ -64,8 +64,23 @@ start32:
 	mrc	p15, 0, lr, c12, c12, 7		// ICC_IGRPEN1
 	str	lr, [r0, #28]
 1:
-//#endif
-
+#endif
+#if defined(CONFIG_MACH_SUN60I_A733)
+	ldr	r1, =SUNXI_CPU_DA_DDR_CTRL_REG
+	mov	r2, #1
+	str	r2, [r1]			// CPU_DA_DDR_CTRL_REG = 1 (AXI2HIF)
+	ldr	r1, =SUNXI_CLU0_CPU0_CTRL_REG
+	mov	r2, #1
+	str	r2, [r1]			// CLU0_CPU0_CTRL_REG = 1 (AA64 mode)
+#ifdef CONFIG_XPL_BUILD
+	ldr	r0, =CONFIG_SPL_TEXT_BASE
+#else
+	ldr	r0, =CONFIG_TEXT_BASE
+#endif
+	str	r0, [r1, #4]			// CLU0_RVBARADDR0_L
+	mov	r2, #0
+	str	r2, [r1, #8]			// CLU0_RVBARADDR0_H = 0
+#else
 	ldr	r1, =CONFIG_SUNXI_RVBAR_ADDRESS
 	ldr	r0, =SUNXI_SRAMC_BASE
 	ldr	r0, [r0, #36]			// SRAM_VER_REG
@@ -77,6 +92,7 @@ start32:
 	ldr	r0, =CONFIG_TEXT_BASE
 #endif
 	str	r0, [r1]			// store start address in RVBAR
+#endif
 	dsb	sy
 	isb	sy
 	mrc	15, 0, r0, cr12, cr0, 2	@ read RMR register
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 299faa890b9..5a5229c7068 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -117,10 +117,14 @@ void i2c_init_board(void)
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
-#elif CONFIG_MACH_SUN55I_A523
+#elif defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_GPL_R_TWI);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_GPL_R_TWI);
+#ifdef CONFIG_MACH_SUN60I_A733
+	sunxi_gpio_set_pull(SUNXI_GPL(0), SUNXI_GPIO_PULL_UP);
+	sunxi_gpio_set_pull(SUNXI_GPL(1), SUNXI_GPIO_PULL_UP);
+#endif
 #else
 	clock_twi_onoff(5, 1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
@@ -243,7 +247,18 @@ int board_init(void)
 static struct boot_file_head * get_spl_header(uint8_t req_version)
 {
 	struct boot_file_head *spl = (void *)(ulong)SPL_ADDR;
-	uint8_t spl_header_version = spl->spl_signature[3];
+	u8 spl_header_version;
+
+	/*
+	 * In FEL mode on A733, sunxi-fel uses an SRAM swap buffer to preserve
+	 * the BROM stack. When returning from SPL to FEL, BROM state is
+	 * restored to SPL_ADDR (0x47000), leaving the SPL header in SH_SRAM.
+	 */
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733) &&
+	    memcmp(spl->spl_signature, SPL_SIGNATURE, 3) != 0)
+		spl = (void *)(ulong)SUNXI_FEL_SPL_ADDR;
+
+	spl_header_version = spl->spl_signature[3];
 
 	/* Is there really the SPL header (still) there? */
 	if (memcmp(spl->spl_signature, SPL_SIGNATURE, 3) != 0)
@@ -448,7 +463,7 @@ static void mmc_pinmux_setup(int sdc)
 			sunxi_gpio_set_drv(pin, 2);
 		}
 #elif defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A133) || \
-      defined(CONFIG_MACH_SUN55I_A523)
+	defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
 		/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
 		for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(16); pin++) {
 			if (pin > SUNXI_GPC(1) && pin < SUNXI_GPC(5))
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 170578ef895..f45115d0be9 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -73,6 +73,7 @@ config SPL_MAX_SIZE
 	default 0xec00 if OMAP34XX
 	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0xbfa0 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
+	default 0x28fa0 if MACH_SUN60I_A733
 	default 0x7000 if RCAR_GEN3
 	default 0x5fa0 if SUNXI_SRAM_ADDRESS = 0x0
 	default 0x7fa0 if ARCH_SUNXI
@@ -98,6 +99,7 @@ config SPL_DISPOSABLE_INIT_RODATA
 config SPL_ACTIVE_MAX_SIZE
 	hex
 	depends on SPL_DISPOSABLE_INIT_RODATA
+	default 0x10fa0 if MACH_SUN60I_A733
 	default 0x0
 	help
 	  When non-zero, maximum size in bytes of the active SPL image
@@ -302,6 +304,7 @@ config SPL_TEXT_BASE
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
 	default 0x44060 if MACH_SUN55I_A523
+	default 0x47060 if MACH_SUN60I_A733
 	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x00060 if ARCH_SUNXI
 	default 0xfffc0000 if ARCH_ZYNQMP
@@ -457,6 +460,7 @@ config SPL_STACK
 	default 0x52a00 if MACH_SUN50I_H616
 	default 0x40000 if MACH_SUN8I_R528 || MACH_SUN50I_A133
 	default 0x44000 if MACH_SUN55I_A523
+	default 0x98000 if MACH_SUN60I_A733
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI
diff --git a/include/configs/sun60i.h b/include/configs/sun60i.h
new file mode 100644
index 00000000000..8e9488be979
--- /dev/null
+++ b/include/configs/sun60i.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Placeholder wrapper to allow addressing Allwinner devices with Cortex-A76/A55
+ * cores separately. Please do not add anything in here.
+ */
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/sunxi-common.h>
+
+#endif /* __CONFIG_H */
-- 
2.53.0

