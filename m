Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168DCC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C31976067F;
	Wed, 26 Aug 2026 13:42:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEOYv-Ss-KmA; Wed, 26 Aug 2026 13:42:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751748;
	bh=yN7X3vgkTJkBVGjdW98Y9xd7lrakrz2s2TmF/uMsynY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jU++uRjL2p3VnMtxrrekh70Hcmm8X/WtE7QE4XL7H+BRxaVO12SWNH+Ub3vyYwdl2
	 t/SylLSovsruXyZliOROohDoA47GbUHrvoixiu0tWGLOEf2hQBQtkQ/Q6QjE1tX/Kt
	 lERpjj/WKE+I3Ri27TS3IYEtkrivujy/3SRVxdeGxbnMjIPq42ReIsJs8TkvUVCAsj
	 u6P9vcaN2yWCeYnvM+ntHwziyR5HD9sXTLlYoCgK35zrPh5xWHutwO2KVpuoEJDYnq
	 8epmIWbFEf7ZWJYVvNgjQcELA2N/AFZnEKLWDSgfGngXFE+ZLIJCvhnm5P2/60E7tP
	 DTaolvc63saWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7335C605AC;
	Wed, 26 Aug 2026 13:42:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EE5F396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C9F540108
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZKXoBuPnKvQ for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:34:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=DH0H/5Oi
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id 45C464005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751290; bh=yN7X3vgkTJkBVGjdW98Y9xd7lrakrz2s2TmF/uMsynY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=DH0H/5Oiht8I6QNgO1FWocliT1muHWsDZRTJ7S4ikeb8EzCwz/yZO4H0QBCedRUG132ia4n7lX2bG7TZjYDAKMjRMOwqeIueiCoDjCPRkN1Otbp3HqVFW3Xv4VQeBFFDzPH3qPyCAfAohh3/KkTIqvCO0fAG5UTtmzbM1YlhDKQOSFRg9nZfpw/6YI5nnCZylK6tm5R15L5bVu/0m2n9HhGh6IGtU88DrcIvCIepb46N+hhg3pSMboPFeHtWj5crc91AgEAE9TLyRmnrx1+DyFk42EecZ4P78SD4xNq7tkYweUEvP2P55rPkrkxgzqM9LgyRqLeTESNGbe5C4RNUKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751290; bh=Bz4dx2Tn5HGtA7SmtHbAIImgtIHmveoCrEKFoI1nXCN=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=L/Z8PoNREhoGxxAb5Uas0C7fj+6omvvOwP+empo1bwRra5cPWzIy0f7lp3yQDTkuGLimm8TlbMlZa7Kwj6YlmEKGvdNFftbcvf64P2Dra2B7wJjbeo8hWYKhCpZQVVngEwLZtonYfcA9zoRvAOOyr8x9VhNDbjQV1Czulj2x2dXcyVgeVFQNPvwQH4hrjcWT4GkmoXlxRQosWFx3UDPYiICg6tInnanHYxrhcoy5+qJ6FbnhzlipM76uRSJrWwNQALSJOck4hz43fseesiJgJAI+/tVNgiJdMvlNBA8Xy0HYKCAXGPWy7P+JwAlroHeIw6W8gZH58Gx48o9WqREi/w==
X-YMail-OSG: 1uZsg3wVM1npacIM6VIfUN2X1nuggjYWtSFQkh_I0VQ_Rt2audN8lMLaGKj.8R8
 Vsrnu60leuWl6O9lppVQJHG2CjbUvHuxNgeKlCP4oudn0dfR2Iq94NVnhtgLy29pbnUc6pqDZmvo
 gA_Bj2.0g7KvfTobdh2UTCEq9O22BvUfwHuiBC77YHS2fwkf.NjnVqdgLbpp1e_aYcQf7_Hg9R1t
 AufuzrYB.6WtrKKjpiXxpDIhHmBQsz9j0I8Y6eXV6stP5NCDPly630CTrZOIqBGJVOktvK5jzL9b
 zfSE4AxbQ6g488FUBbcCpo.q34hnA..HiVlirNtzQIOuKjUL98EOkvzp7u8S3QS_YEVJjEhFWZWD
 7_bJT6vuyNur83UqbR9rinMGzGJ.Y6s5DHs4vMli1TV4xcKbcfmmyZhFvN3s5S7oEAD3LhXIGVMU
 8ed94W5XLKHpQv0yt7t9Wv_N_ucNsnHovk637FQpePbC.obUbC7sq1Tdj7PvkwFEzFOTxnS3ZOYr
 h_73eg8Wjm4Gk2Y8t.Z31W7pQTTXh5M05msH6Yo0pBsM_6ijAEGisUrUY.1uXgFLQwYKyn3qyxI7
 BH5HA6bvVsGCCfzEWlvOtkbfR5cJwGgYq0Bx62PnDefdZbKtmnEFwdAaff1PFEoapK3DI.oLjGox
 4Y3ie_ah.M2t5zcVe1FvuiJMwt0F8ceCnO.u2k4_fdCKV7GKL9y0zbKCJEAvRAUBh_X.FJyLdyJI
 XhZi4MfV3FLdnwULgJgGaM9X8as5_vbB76f4vkAMQE3if9mFqtWipIdZYHeDG4I8ehRbN0QZ7.fe
 _ruqPk9tdOC_kUvAen._h519sq3FX3rltyFlyyaYbzBnY9LMlvcU7sdEbWONrWejQgeL4ygud9MN
 lFgDuXwEDD2hKOKGgU8YnbNxm3uy7utG0BROrOgxGujer1oO68kZtbbj40L4WHg80vRciZdvDBw8
 cxnTViBAv7IvF5SxWEomJHpLTx56eaOn8aOG.9c.6dlvwGPI8MeAgfJFHoUg8ncve8.WAmCkY3sk
 dEzCW5sPwfMKgxLodJzXflI1HaiO.k2rsVw7mk1G5omPCDoXPOO3IpVeAHUhDfehTbrr7s7PtjPU
 gC4SCwAcfU3mHlIWLlHXq2wl3Oy9OlyryTJEjiI3Wy7c2dBpFCAosfakwD8VRCdPlTAjnZZBH7Pl
 DOQXgvO2Kap7hrI1RY3cLdsPZ9lstmWvO.0F6Ek_IaalRgOb7fuJ3dkbxol4CqQaxhz3HPg2GP5L
 CE84IihiQP00kAmIbH6KKDpEMrOyNgmPbn9qngHL3TEZgUqniw6GjrOQnTnX1SocxqhH0Ls6b4Nm
 RUQF5E1.zZ5Pu4sbVTccaoLUulFxqDYr8D3PhzR.bJx8aJY033KryybyiWhjJt9TU5IUG5zYpcqb
 YsJFsodXDjstGB0a4XvAk8.VlvoLaAK1AdMeJO85J4UpK9Lr3OPc5a6wf3TtykpAwL73BeUGtWmj
 n1tLa7ZiigV90g2qKZ57W5LM7C.VPQ3Q7u60d4kt5Y5SgAFLLb33oj2p.4R.umaaa6J4ENF3p.zr
 McttQoha7hQtYpmnCAhkH1QzByQInhh2.efACPS0p_i0YNFKfiUPPEy1l4Kd.kV4U_i_t4Cv7XVe
 syGJMfUBAnmIkC21q2uAeRvRdQVNKgRUz.PNcqoPDA31HGz.7IyWns8iboM1zXigP0qtz5Sqd2gT
 Lvr.lNeA_vxEHgX4n4XC4rMokKauX7MLdwtEHpxybTG78hae7sRaqaj10lZPFNNvXu323M1Grmk0
 i87U6eNbo1ELVXcRjxfeY8F1kYZDX.3Vecq8CPMi8SyHn38Vib40Wrt3K2yGm35m8FdDuHfVZEyT
 EgBDI6Mq3.6hvjVY7Mody3GmSUewT9BvYw1utm7fbwathryEoL7FDQeF07QTv9cISFlHrGUbhTg_
 PRYwHL8XIGsiWr.O2KCBu2FwoCqqnxtpnSqB1YISBv.rf7XfU6uqxJADYFjL9WlHo.uqKa1V_KDM
 GnDJRvF2qxv5FORJfBIjHn.Siny_UTz90vvIUdL46pXhGgDkHaaj1XeeID5_zv9JMLkCTt4WkQdF
 rzg--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: fb757955-0457-4b94-9b80-e80643fa6c00
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 26 Aug 2026 13:34:50 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:34:48 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 1/9] mips: en75xx: add EcoNet/Airoha EN75xx SoC support
Date: Wed, 26 Aug 2026 19:04:35 +0530
Message-ID: <9fa9bf7e599c459eefa50fe3cee8af3b8edc904b.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
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

Add the core support for the EcoNet/Airoha EN75xx MIPS SoC family: the
big-endian MIPS34Kc EN7512/EN7521 and the little-endian MIPS1004Kc
EN7528. This adds the ARCH_EN75XX Kconfig entry, the mach-en75xx CPU and
cache init, and the SoC register definitions.

dram_init() takes the DRAM size published by the DDR stage in
REG_SAVE_INFO and falls back to probing with get_ram_size() when that
field reads back an implausibly small value (some bootbases leave it
unset), sizing through the uncached KSEG1 alias and capping the scan at
256 MiB to stay clear of the SoC register island.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 arch/mips/Kconfig                           |  29 ++++++
 arch/mips/Makefile                          |   2 +
 arch/mips/cpu/start.S                       |   2 +
 arch/mips/mach-en75xx/Kconfig               | 100 +++++++++++++++++++
 arch/mips/mach-en75xx/Makefile              |  15 +++
 arch/mips/mach-en75xx/cache.c               |  85 ++++++++++++++++
 arch/mips/mach-en75xx/cpu.c                 |  95 ++++++++++++++++++
 arch/mips/mach-en75xx/include/mach/en75xx.h | 103 ++++++++++++++++++++
 8 files changed, 431 insertions(+)
 create mode 100644 arch/mips/mach-en75xx/Kconfig
 create mode 100644 arch/mips/mach-en75xx/Makefile
 create mode 100644 arch/mips/mach-en75xx/cache.c
 create mode 100644 arch/mips/mach-en75xx/cpu.c
 create mode 100644 arch/mips/mach-en75xx/include/mach/en75xx.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 36612756..7f105d43 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -88,6 +88,26 @@ config ARCH_MTMIPS
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_SPL
 
+config ARCH_EN75XX
+	bool "Support EcoNet/Airoha EN75xx MIPS platforms"
+	select HAS_FIXED_TIMER_FREQUENCY
+	select DM
+	select DM_SERIAL
+	select EN75XX_SERIAL
+	select OF_CONTROL
+	select ROM_EXCEPTION_VECTORS
+	select SUPPORT_BIG_ENDIAN
+	select SUPPORT_LITTLE_ENDIAN
+	select SUPPORTS_CPU_MIPS32_R2
+	select SUPPORT_SPL
+	select SPL_SKIP_LOWLEVEL_INIT if SPL
+	select SUPPORT_TPL
+	select SYS_CACHE_SHIFT_5
+	select MIPS_TUNE_34KC
+	help
+	  Support the EcoNet/Airoha EN75xx MIPS SoCs: the big-endian MIPS34Kc
+	  EN7512/EN7521 and the little-endian MIPS1004Kc EN7528.
+
 config ARCH_JZ47XX
 	bool "Support Ingenic JZ47xx"
 	select SUPPORT_SPL
@@ -201,6 +221,7 @@ source "arch/mips/mach-mscc/Kconfig"
 source "arch/mips/mach-bmips/Kconfig"
 source "arch/mips/mach-jz47xx/Kconfig"
 source "arch/mips/mach-pic32/Kconfig"
+source "arch/mips/mach-en75xx/Kconfig"
 source "arch/mips/mach-mtmips/Kconfig"
 source "arch/mips/mach-octeon/Kconfig"
 
@@ -322,6 +343,14 @@ config MIPS_MACH_EARLY_INIT
 	  and at this stage the PC might not match the linking address
 	  (CONFIG_TEXT_BASE) - no absolute jump done until this call.
 
+config MIPS_SKIP_CP0_COUNT_CLEAR
+	bool
+	help
+	  Do not clear the CP0 Count register (mtc0 zero, CP0_COUNT) at reset
+	  in arch/mips/cpu/start.S. On some SoCs the Count register is GIC/CM
+	  backed and that write stalls the CPU; such targets select this.
+	  Other MIPS targets keep the generic clear.
+
 config MIPS_CACHE_SETUP
 	bool "Allow generic start code to initialize and setup caches"
 	default n if SKIP_LOWLEVEL_INIT
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 453c7885..7c3976aa 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -9,6 +9,7 @@ endif
 
 ifeq ($(CONFIG_TPL_BUILD),y)
 head-$(CONFIG_SOC_MT7621) := arch/mips/mach-mtmips/mt7621/tpl/start.o
+head-$(CONFIG_ARCH_EN75XX) := arch/mips/mach-en75xx/tpl/start.o
 endif
 
 libs-y += arch/mips/cpu/
@@ -16,6 +17,7 @@ libs-y += arch/mips/lib/
 
 machine-$(CONFIG_ARCH_ATH79) += ath79
 machine-$(CONFIG_ARCH_BMIPS) += bmips
+machine-$(CONFIG_ARCH_EN75XX) += en75xx
 machine-$(CONFIG_ARCH_JZ47XX) += jz47xx
 machine-$(CONFIG_MACH_PIC32) += pic32
 machine-$(CONFIG_ARCH_MTMIPS) += mtmips
diff --git a/arch/mips/cpu/start.S b/arch/mips/cpu/start.S
index a95c95bc..48eb69b1 100644
--- a/arch/mips/cpu/start.S
+++ b/arch/mips/cpu/start.S
@@ -124,7 +124,9 @@ ENTRY(_start)
 #endif
 
 reset:
+#ifndef CONFIG_MIPS_SKIP_CP0_COUNT_CLEAR
 	mtc0	zero, CP0_COUNT	# clear cp0 count for most accurate boot timing
+#endif
 #if __mips_isa_rev >= 6
 	mfc0	t0, CP0_CONFIG, 5
 	and	t0, t0, MIPS_CONF5_VP
diff --git a/arch/mips/mach-en75xx/Kconfig b/arch/mips/mach-en75xx/Kconfig
new file mode 100644
index 00000000..d5371544
--- /dev/null
+++ b/arch/mips/mach-en75xx/Kconfig
@@ -0,0 +1,100 @@
+menu "EcoNet/Airoha EN75xx platforms"
+	depends on ARCH_EN75XX
+
+config SYS_VENDOR
+	default "econet"
+
+# Common SoC-identity flag selected by every EN7528 board (reference/RAM/...).
+config SOC_EN7528
+	bool
+	select MIPS_SKIP_CP0_COUNT_CLEAR
+
+config SYS_SOC
+	default "en7528" if SOC_EN7528
+	default "en7512"
+
+config SYS_BOARD
+	default "en7528" if SOC_EN7528
+	default "en7512"
+
+config SYS_CONFIG_NAME
+	default "en7528" if SOC_EN7528
+	default "en7512"
+
+config SYS_MALLOC_F_LEN
+	default 0x2000
+
+config SYS_DCACHE_SIZE
+	default 32768
+
+config SYS_DCACHE_LINE_SIZE
+	default 32
+
+config SYS_ICACHE_SIZE
+	default 32768
+
+config SYS_ICACHE_LINE_SIZE
+	default 32
+
+config TEXT_BASE
+	default 0x80020000 if BOARD_EN7528_RAM
+	default 0x81000000
+
+config SPL_TEXT_BASE
+	default 0x80010000
+
+config SPL_SIZE_LIMIT
+	default 0x30000
+
+config TPL_TEXT_BASE
+	default 0xbfc00000
+
+config TPL_MAX_SIZE
+	default 0x8000
+
+
+config BUILD_TARGET
+	default "u-boot.img" if BOARD_EN7512_REFERENCE
+	default "u-boot.bin" if BOARD_EN7528_REFERENCE
+	default "u-boot.bin" if BOARD_EN7528_RAM
+
+choice
+	prompt "EN75xx reference board"
+	default BOARD_EN7512_REFERENCE
+
+config BOARD_EN7512_REFERENCE
+	bool "EN7512/EN7521 reference board"
+	select BINMAN
+	select SPL_LOADER_SUPPORT if SPL
+	help
+	  Build a boot image compatible with the EN7512/EN7521 TCBoot flow.
+	  TPL initializes the serial flash controller, executes the legacy DDR
+	  calibration stage from FE SRAM and loads SPL into DDR.
+
+config BOARD_EN7528_REFERENCE
+	bool "EN7528 reference board (DASAN H660GM-A)"
+	select SOC_EN7528
+	select BINMAN
+	select SPL_LOADER_SUPPORT if SPL
+	help
+	  Build a boot image for the little-endian MIPS1004Kc EN7528. TPL brings
+	  up the SoC and runs the FE-SRAM DDR3 calibration stage (en7528_ddr.bin,
+	  extracted from the vendor bootloader) before loading SPL into DDR. The exact
+	  DDR-stage entry/handoff is validated over UART during bring-up; see
+	  doc/board/econet/en7528.rst.
+
+config BOARD_EN7528_RAM
+	bool "EN7528 RAM-boot (loaded by the stock bootbase at 0x80020000)"
+	select SOC_EN7528
+	help
+	  Build a standalone U-Boot proper (no TPL/SPL, no DDR blob) linked at
+	  0x80020000 to be RAM-loaded by the stock bootbase, which has already
+	  initialized DRAM. XMODEM it in from the bldr> prompt ("xmdm 80020000
+	  <len>") and run it with "jump 80020000". This is the non-destructive
+	  bring-up path that exercises the whole upper stack (console, DTS, DM,
+	  U-Boot proper) on real EN7528 silicon without needing the DDR stage.
+
+
+endchoice
+
+endmenu
diff --git a/arch/mips/mach-en75xx/Makefile b/arch/mips/mach-en75xx/Makefile
new file mode 100644
index 00000000..8b9a418f
--- /dev/null
+++ b/arch/mips/mach-en75xx/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+ifeq ($(CONFIG_TPL_BUILD),y)
+obj-y += early_sfc.o
+obj-y += tpl/
+else
+obj-y += cpu.o
+ifeq ($(CONFIG_SPL_BUILD),y)
+obj-y += early_sfc.o
+obj-y += spl/
+else
+# U-Boot proper
+obj-y += cache.o
+endif
+endif
diff --git a/arch/mips/mach-en75xx/cache.c b/arch/mips/mach-en75xx/cache.c
new file mode 100644
index 00000000..80f5e718
--- /dev/null
+++ b/arch/mips/mach-en75xx/cache.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * EN75xx (EN7528) cache and Linux-handoff helpers.
+ *
+ * The CM L2 on this part hangs on Hit_Writeback_Inv_SD (cache op 0x17).
+ * Override the generic MIPS flush routines so they never issue that op,
+ * decompress kernels through KSEG1, and join the CM coherent domain
+ * before jumping to Linux.
+ */
+
+#include <cpu_func.h>
+#include <image.h>
+#include <stdio.h>
+#include <asm/addrspace.h>
+#include <asm/cache.h>
+#include <asm/cacheops.h>
+#include <asm/io.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <mach/en75xx.h>
+
+#define EN75XX_L1_LINE	32
+#define EN75XX_L2_LINE	32
+#define EN75XX_GCR_CL_COHERENCE	0x2008
+
+#define cache_loop(start, end, lsize, op) do {				\
+	const void *_addr = (const void *)((start) & ~((lsize) - 1));	\
+	const void *_aend = (const void *)(((end) - 1) & ~((lsize) - 1)); \
+	if (!(lsize) || (start) == (end))				\
+		break;							\
+	for (; _addr <= _aend; _addr += (lsize))			\
+		mips_cache((op), _addr);				\
+} while (0)
+
+void flush_cache(ulong start_addr, ulong size)
+{
+	if (!size)
+		return;
+
+	/*
+	 * Write back L1 D so U-Boot's own cached stores reach DRAM.
+	 * Do not Hit_Writeback_Inv_SD (hangs). Do not invent an L2 line
+	 * size here: Hit_Invalidate_SD on U-Boot's working set during
+	 * DM init fails.
+	 */
+	cache_loop(start_addr, start_addr + size, EN75XX_L1_LINE,
+		   HIT_WRITEBACK_INV_D);
+	cache_loop(start_addr, start_addr + size, EN75XX_L1_LINE,
+		   HIT_INVALIDATE_I);
+	sync();
+	instruction_hazard_barrier();
+}
+
+void flush_dcache_range(ulong start_addr, ulong stop)
+{
+	if (start_addr == stop)
+		return;
+
+	cache_loop(start_addr, stop, EN75XX_L1_LINE, HIT_WRITEBACK_INV_D);
+	sync();
+}
+
+void en75xx_prepare_linux(void)
+{
+	unsigned long cmgcr, cm;
+
+	/* Airoha WDT — same block as EN75XX_TIMER_BASE. */
+	writel(0, (void __iomem *)EN75XX_WDT_CTRL);
+
+	/*
+	 * mips_cm_map() never writes GCR_CL_COHERENCE, so the boot core is
+	 * out of the coherent domain and a CM/CPS kernel's vector fetches
+	 * go stale. Same join as arch/mips/mach-mtmips/mt7621.
+	 */
+	cmgcr = read_c0_cmgcrbase();
+	cm = ((unsigned long)cmgcr << 4) + CKSEG1;
+	writel(0xff, (void __iomem *)(cm + EN75XX_GCR_CL_COHERENCE));
+	instruction_hazard_barrier();
+	printf("## EN75xx: WDT off, CM COHERENCE=0xff GCR@%08lx\n", cm);
+}
+
+void arch_preboot_os(void)
+{
+	en75xx_prepare_linux();
+}
diff --git a/arch/mips/mach-en75xx/cpu.c b/arch/mips/mach-en75xx/cpu.c
new file mode 100644
index 00000000..ae1d627b
--- /dev/null
+++ b/arch/mips/mach-en75xx/cpu.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/sizes.h>
+#include <mach/en75xx.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	/*
+	 * The DDR stage (blob, or the stock bootbase on the chainload path)
+	 * publishes the DRAM size in REG_SAVE_INFO. EN7528: MB in bits [31:20]
+	 * (for example, 0x20038400 => 512 MiB).
+	 */
+	u32 val = __raw_readl((void __iomem *)EN75XX_REG_SAVE_INFO);
+	u32 size_mb = (val >> EN75XX_SAVE_DRAM_SHIFT) & EN75XX_SAVE_DRAM_MASK;
+
+	/*
+	 * Some bootbases do not publish a valid DRAM size in REG_SAVE_INFO
+	 * (the field reads back implausibly small). Fall back to sizing the
+	 * DRAM at runtime in that case, probing through the uncached KSEG1
+	 * alias to avoid cache-aliasing false positives and capping the scan
+	 * at 256 MiB to stay clear of the SoC register island at 0x1fa00000.
+	 */
+	if (size_mb < 64)
+		gd->ram_size = get_ram_size((long *)0xa0000000, SZ_256M);
+	else
+		gd->ram_size = (phys_size_t)size_mb << 20;
+
+	return 0;
+}
+
+int print_cpuinfo(void)
+{
+	u32 val = __raw_readl((void __iomem *)EN75XX_REG_SAVE_INFO);
+	u32 clk = (val >> EN75XX_SAVE_CLK_SHIFT) & EN75XX_SAVE_CLK_MASK;
+
+#if defined(CONFIG_SOC_EN7528)
+	printf("CPU:   EcoNet/Airoha EN7528 MIPS1004Kc\n");
+#else
+	printf("CPU:   EcoNet/Airoha EN7512/EN7521 MIPS34K\n");
+#endif
+	if (clk)
+		printf("Clock: %u MHz\n", clk);
+	else
+		printf("Clock: unknown\n");
+
+	return 0;
+}
+
+ulong notrace get_tbclk(void)
+{
+	u32 val = __raw_readl((void __iomem *)EN75XX_REG_SAVE_INFO);
+	u32 clk = (val >> EN75XX_SAVE_CLK_SHIFT) & EN75XX_SAVE_CLK_MASK;
+
+	/*
+	 * CP0 Count rate per SoC: EN7528 = clk_field * 2 MHz (hardware-measured
+	 * via sleep timing), EN7512 = clk_field / 2. See EN75XX_COUNT_HZ_PER_CLK.
+	 */
+	if (clk)
+		return (ulong)clk * EN75XX_COUNT_HZ_PER_CLK;
+
+	return CONFIG_SYS_MIPS_TIMER_FREQ;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * DRAM is aliased into KSEG0 at 0x80000000, but KSEG0 ends at
+	 * 0x9fffffff and the SoC MMIO / FE-SRAM island sits at phys 0x1fa00000
+	 * (= KSEG0 0x9fa00000). On a 512 MiB part, ram_base + size = 0xa0000000
+	 * would relocate U-Boot past KSEG0 / into the island and hang. Relocating
+	 * into high DRAM (0x9exxxxxx) also hangs on this SoC (cache-flush over the
+	 * large range / unstable high DRAM). U-Boot gains nothing from a high top,
+	 * so clamp to the proven-good 0x90000000 (256 MiB); Linux still gets the
+	 * full DRAM via the /memory DT node.
+	 */
+	phys_addr_t top = 0x80000000UL + gd->ram_size;
+
+	if (top > 0x90000000UL)
+		top = 0x90000000UL;
+
+	return top;
+}
+
+void _machine_restart(void)
+{
+	__raw_writel(0x80000000, (void __iomem *)EN75XX_RESET_CONTROL);
+
+	for (;;)
+		;
+}
diff --git a/arch/mips/mach-en75xx/include/mach/en75xx.h b/arch/mips/mach-en75xx/include/mach/en75xx.h
new file mode 100644
index 00000000..a42e304b
--- /dev/null
+++ b/arch/mips/mach-en75xx/include/mach/en75xx.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Generic register map for the EcoNet/Airoha EN75xx MIPS SoCs.
+ *
+ * The EN7512/EN7521 (MIPS 34Kc, big-endian) and the EN7528 (MIPS 1004Kc,
+ * little-endian) share the same TCBoot-derived boot model and almost the
+ * same peripheral register map. Values that differ between the two are
+ * selected here on CONFIG_SOC_EN7528.
+ */
+#ifndef __MACH_EN75XX_H__
+#define __MACH_EN75XX_H__
+
+/* --- Peripheral bases (identical across the family) --- */
+#define EN75XX_FLASH_BASE		0xbfc00000
+#define EN75XX_SFC_BASE			0xbfa10000
+#define EN75XX_CHIP_SCU_BASE		0xbfa20000
+#define EN75XX_FE_SRAM_BASE		0xbfa30000
+#define EN75XX_FE_SRAM_CACHED		0x9fa30000
+#define EN75XX_SYSCTL_BASE		0xbfb00000
+#define EN75XX_SMC_BASE			0xbfb10000
+#define EN75XX_DRAMC_BASE		0xbfb20000
+#define EN75XX_INTC_BASE		0xbfb40000
+#define EN75XX_UART0_BASE		0xbfbf0000
+#define EN75XX_TIMER_BASE		0xbfbf0100
+#define EN75XX_WDT_CTRL			0xbfbf0100	/* airoha WDT; writel(0) stops it */
+#define EN75XX_GPIO_BASE		0xbfbf0200
+
+/* --- SYSCTL scratch/handoff registers (identical) --- */
+#define EN75XX_RESET_CONTROL		(EN75XX_SYSCTL_BASE + 0x040)
+#define EN75XX_FE_SRAM_SEL		(EN75XX_SYSCTL_BASE + 0x958)
+#define EN75XX_SCREG_WR0		(EN75XX_SYSCTL_BASE + 0x280)
+#define EN75XX_REG_SAVE_INFO		(EN75XX_SYSCTL_BASE + 0x284)
+
+/* --- Flash image layout: DDR blob offset is common; SPL/U-Boot offsets
+ *     differ because the EN7528 DDR blob is much larger (see below). --- */
+#define EN75XX_DDR_BLOB_OFFSET		0x00008000
+
+/* --- DRAM-size / clock info in REG_SAVE_INFO (0xbfb00284).
+ *     Field positions differ per SoC - see the EN7528/EN7512 blocks below.
+ *     Read as: (val >> _SHIFT) & _MASK. --- */
+
+#if defined(CONFIG_SOC_EN7528)
+/*
+ * EN7528 (MIPS 1004Kc, little-endian).
+ *
+ * The DDR stage (en7528_ddr.bin, extracted from the vendor
+ * bootloader) is the full FE-SRAM first stage: it self-inits SoC registers,
+ * calibrates DDR3 and hands control back via *(EN75XX_SCREG_WR0). It is
+ * loaded at the FE-SRAM base 0x9fa30000 (NOT +0x2800 like EN7512) and is
+ * 0x5a70 bytes.
+ *
+ * NOTE (hardware bring-up): the blob's own entry word is `j 0xbfc00060`,
+ * i.e. it is a plain subroutine: entry 0x9fa30000 = NOP pad -> stub @+0x290
+ * -> main(), and one jalr *(SCREG_WR0) hands control back to us.
+ * The exact entry/handoff must be validated over UART — see
+ * doc/board/econet/en7528.rst. The constants below build a coherent
+ * image and are the starting point for that bring-up.
+ */
+#define EN75XX_DDR_BLOB_ADDR		(EN75XX_FE_SRAM_CACHED + 0x0000)
+#define EN75XX_DDR_BLOB_SIZE		0x00005a70
+/* The 0xf0a0-byte blob at flash 0x8000 ends at 0x170a0, so SPL starts at
+ * 0x20000 (EN7512 could use 0x10000 with its 0x4f70 blob). */
+#define EN75XX_SPL_IMAGE_OFFSET		0x00020000
+#define EN75XX_UBOOT_IMAGE_OFFSET	0x00050000
+/* Keep TPL scratch clear of the (large) EN7528 blob image. */
+#define EN75XX_SPL_HEADER_ADDR		(EN75XX_FE_SRAM_BASE + 0x0f000)
+#define EN75XX_TPL_STACK_ADDR		(EN75XX_FE_SRAM_BASE + 0x0fff0)
+#define EN75XX_TPL_SAVED_RA		(EN75XX_FE_SRAM_BASE + 0x0ff00)
+#define EN75XX_SAVE_DRAM_SHIFT		20
+#define EN75XX_SAVE_DRAM_MASK		0xfff		/* MB, bits [31:20] */
+#define EN75XX_SAVE_CLK_SHIFT		10
+#define EN75XX_SAVE_CLK_MASK		0x3ff		/* MHz, bits [19:10] */
+#define EN75XX_COUNT_HZ_PER_CLK	2000000	/* CP0 Count = clk_field * 2 MHz (measured) */
+#else
+/*
+ * EN7512/EN7521 (MIPS 34Kc, big-endian). The vendor spram DDR-only stage
+ * is linked for and entered at 0x9fa32800 and is 0x4f70 bytes.
+ */
+#define EN75XX_DDR_BLOB_ADDR		(EN75XX_FE_SRAM_CACHED + 0x2800)
+#define EN75XX_DDR_BLOB_SIZE		0x00004f70
+#define EN75XX_SPL_IMAGE_OFFSET		0x00010000
+#define EN75XX_UBOOT_IMAGE_OFFSET	0x00050000
+#define EN75XX_SPL_HEADER_ADDR		(EN75XX_FE_SRAM_BASE + 0x40)
+#define EN75XX_TPL_STACK_ADDR		(EN75XX_FE_SRAM_BASE + 0xbff0)
+#define EN75XX_TPL_SAVED_RA		(EN75XX_FE_SRAM_BASE + 0x00)
+#define EN75XX_SAVE_DRAM_SHIFT		0
+#define EN75XX_SAVE_DRAM_MASK		0xfff		/* MB, bits [11:0] */
+#define EN75XX_SAVE_CLK_SHIFT		12
+#define EN75XX_SAVE_CLK_MASK		0xfff		/* MHz, bits [23:12] */
+#define EN75XX_COUNT_HZ_PER_CLK	500000
+#endif
+
+#ifndef __ASSEMBLY__
+#include <stddef.h>
+#include <linux/types.h>
+
+int en75xx_sfc_read(u32 offset, void *dst, size_t len);
+int en75xx_sfc_init(void);
+void en75xx_run_ddr_blob(void);
+void en75xx_prepare_linux(void);
+#endif
+
+#endif /* __MACH_EN75XX_H__ */
-- 
2.53.0

