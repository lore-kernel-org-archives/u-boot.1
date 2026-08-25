Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CC9C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14D68407A8;
	Tue, 25 Aug 2026 22:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pgTreYcyJA03; Tue, 25 Aug 2026 22:50:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698222;
	bh=DZ/QaD5gCRAIIZF8wMhIxJbWzerY3jfebMjKoea9q44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8ITkmapp6qAmVGp1fsc6NUp//ryS1aUwFfiylHm3FIG7VmWONdCvk8GorPqNeN4T
	 +vou5ulSvuNsur9gcau0XhJ86mKlmFhKvN3J61pKRih2od14r1slWuweUCb1QN7GD5
	 vaAo8oFoCf9wshUWA8mxU0ZboAcKQ9EyyaAsT72o6PPetF6dhZxeubrG73jPJLE3+p
	 f3RDnG/5TIQYb5uC77g6I1g8ywJ50pPO1bO68wDca5WfyzM6eeX+Ddzbfd9MKyBhoc
	 /17xVkddAYWQ+3LxvbRhGV+w+NnrLHjqSiWe50xiyuunL/fLDEpuMaeaSpyecZVETE
	 4wj1oSyqpv4Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B95F94068B;
	Tue, 25 Aug 2026 22:50:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C88E3C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0345940629
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ga7GwOAPZ8Uo for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=lAEAjSCc
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp4.osuosl.org (Postfix) with ESMTPS id F22D240606
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697837; bh=DZ/QaD5gCRAIIZF8wMhIxJbWzerY3jfebMjKoea9q44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=lAEAjSCc9js78DdAKnqLECfmyzPtP7CJah2aTfHHkLKKjEcFr9Wv4bnE49YTePY9LosEV2Gz6L4UfdZTy5LtwCrYheuGabCUKR8SfVI6DC/55LQZ1OAImc6yAnjE1fIuxEgZkvHMLoK6P4Y5GguvaG9J997xXG9MmXmPymLcd8RXsPixhChnm/iuSlzRxoeM9YJ0XVzQxAMDr5yyNm4N/3aiWMTplMSWpG75GO0olvKlY2D7qUBWLfgnzouOIorBpTFp8lq0rY+PlDDMKzmvyQkgKsBjRUW4uTlaw9xJH8bQCT9iFvi9Zv41UdNnX/9URuXOAfVe8pw+4dus72DNPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697837; bh=hsOVi8KWh8lmQzs0C+VgOOVfBPeZpytxI+2kXifHhfC=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=HmAreZd7GXFCxlzUuSV0pVT/s55kPzzM1wrOBZ6BN7ccOgCnRNfkH2aIVwy+Hd17dz8bbvZkjUZe9o0LDuEPeMl3C+seLk5mTCMl63yGOTqkM0Ve5mAfER3fcv7i9yN9b1L0RsmJ0t8g7FmHpNCGgsn6Hn4F7rmcXFCg43CDUBuyuy1qoBASOPCKZrUu/JWn1srNwhnDmSGe3qkgITwmwP2rJl4QCdOG/UCD4uzyyTQIIPwzfuL98MgAvoUypThfPsOPOuC2tbEIgtdJozfLaDvD1rnAzHK5jmvrNrMLJBXbJgHdREpdUNLC/f93k0GMt54dwirBb6/tMDGnFJRoww==
X-YMail-OSG: ratlNRoVM1mELhYMSsr70QvMgexmz8uL_U2FojCGvFgCNlURk6Bek2ddlpJesG2
 NbCFG9KEQbQeCRaa1Eu3Xqeq.u_Lfkn48O4op4mDOJOX7VwBFwr9u7iaWfwV6yf9awLFaTonVp3.
 BRcYUdNHGDCRFw.wEOkGjIQ5kZ5YQvE7PEpp9j2VLwCjjuALMuquLgby0MPS2dMVRjQa4QKu9Fhx
 lUWOqM9UKMRFXP7JVvXUc.JHouL0iTdcoH4YDiai6HWTTESgnwvQ6Ynk3hriDR9BWPof1x0UX80.
 t6hgqXD3yLpqJGITGXUf5hCc6w92SbHPuGJPPMkpx4gxFtZCPoNaXQ6MDbBv9vjcypqG2DxNqzNX
 f1bNkeeuD.3yol9vpINRApHpcjez1Bur_QYxm9Tu_FB0Crtg3IJ9hMBwVJbb3qFkVruKEjUws6Pm
 brD8aDk6eXo0VqXr7RD02khNMeMBadwvtISCm5CPQbhkgCsw8JH_we0SB6ApmQjh21i7A6fGh1jN
 cxk1K0fLkj5qOQ2f8n5RpE5OsgpCksxo1p9ibfvRn5wlRrFD3Ixvg7i8Co7EQbnslcAYplJ93t_O
 Sa_Gc.VxDoK5SFKFnICOQ0SXKrhAAdHRBz.weuZiNDPK6DTe5WFD1jFI2UIGupoEcLjDFakLkkC.
 pwTqSdNDyOfbTTW72E4UCc2VWAiU9OTjw1k4Jm1LsxDQphaeAEwXGytjTvtpxLPOudKKwwt9xiZK
 j4o6NFjx2AUBzkiVBWzxwgX7S1fOhJVVnSgnmm.Nmso9tBwzso5ityHDuQSEEkVTUsNnkXD3REZG
 ONnnzPDURRojhWTD2ipVJkOQyz7k9L_dv3orHRZZtdAgYVOUECIKal0VQ3t3A2LP6HYJIppA9ImH
 dqunqiuDT9Y_QcGuxYAprRIF72olIhq6Q1OjTkSNZhB_GsUnuGqfrNY1RPze8IfTnixAw29D1Wji
 lqYtc7zspenqmaqyNyhGYvm8ePc2j0uDON65pSU_4pW1e1TFCJEJ7RtiRj33sjpus711s6JtL3Tz
 uDwbuGNrWmSYvYMdzU0E1HpgiiiOPESLaKYud1HljiDbkobdB.PHvGDbK_My1VJt1.iivyrt2HNg
 Ik3dAkjqfzDfzPIEeCPGfmhrQ.SXLBGgNFAEoNFgppe5XHSPwXp9mZpU8cwWpwOKrFAXN5eaAIyj
 7XF7bh98GgoX5mZUWGhwJOtDkk9OU84ltyASkqzQRh88gZmfSXooJnzbn0hUswhFfPLLF8rlqoX9
 F5u6T0nuk6jpH3nEYEUdM7bIXMpvkuIYYXYc8NbVPk3xqewXZCtDFzuUuoOddKvQXAWB5oxZ95N3
 xKDv_oVulJ1YeIR9ftYhdNYVNHpmVldiIepDLcbBJSLHR.vKEy3mpR.aDdNUD6ILeFerunAIWDkS
 5dt.xD1AJmaKiwv6XVj1r5OXyj43ZDNH60q_DUUcnFA3C2TnBvHtGMRUBJqgSHAjD.M4nFiEyDPO
 zq_DYT8lvgyuv92EjqAWQx8rVvkimfSh6.hxkCTZzZvvy_ODaBNsmJ_TRP1NLU_09KL4srMKYZ86
 rTP2REhs0eqFZG2DiF7w_OfSpwzcmyaHHMdcNu7vWpfM0lFq6.c0qym.ZEfCelVhsT30pXP9kBu8
 AsQtW3pS_HbM13JHRrKE7qOSjszbTKMVDYOzVlWXr6wchShwBXGZjE.Dn5ZHnLG5vNRu68ezbGMN
 j_DrwYOCQ8m5UHHBXe7zrqtUPBkR3YpZa.KxuTJOuBQ0br0KmTx089ifW5RewyG.KvXMfJSjKjT8
 d3iGfW1X8Xf4inwKNS1qLhs8liRcyTQe61dqagassPQmzar6kRzFyoyl1of0s.VHahnzHNUZ47WB
 J1deWKsyM.xPAxwC4dphN3h0IjAFwGTzamaVUtSq_hGlpHpdNkWzSkLk2k6.DZMl.DtR1_grE5j6
 acNMAJdx2igndVoteL7PHpaVb0yoXTQHqa_q3zl5fkbQv3Hvn.nKixgyOBGr45wsWKiHNX5UwS0k
 .C2dFM4Ke2bmqpBnE66I8lVNzRYPtycGnD3.19oOL2LqjYthe4_IQ.HV7cs6RvakMmWj3l_QRogb
 wx.8l
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 7978fcb1-2170-42c3-b384-3641790f2b1a
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:43:57 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:43:53 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 01/12] mips: en75xx: add EcoNet/Airoha EN75xx SoC support
Date: Wed, 26 Aug 2026 04:11:56 +0530
Message-ID: <20260825224330.713151-2-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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
 arch/mips/Kconfig                           |  21 ++++
 arch/mips/Makefile                          |   2 +
 arch/mips/cpu/start.S                       |   2 +
 arch/mips/mach-en75xx/Kconfig               | 118 +++++++++++++++++++
 arch/mips/mach-en75xx/Makefile              |  17 +++
 arch/mips/mach-en75xx/cache.c               | 121 ++++++++++++++++++++
 arch/mips/mach-en75xx/cpu.c                 |  95 +++++++++++++++
 arch/mips/mach-en75xx/include/mach/en75xx.h | 104 +++++++++++++++++
 8 files changed, 480 insertions(+)
 create mode 100644 arch/mips/mach-en75xx/Kconfig
 create mode 100644 arch/mips/mach-en75xx/Makefile
 create mode 100644 arch/mips/mach-en75xx/cache.c
 create mode 100644 arch/mips/mach-en75xx/cpu.c
 create mode 100644 arch/mips/mach-en75xx/include/mach/en75xx.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 36612756..c0c98f37 100644
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
index 00000000..5c512559
--- /dev/null
+++ b/arch/mips/mach-en75xx/Kconfig
@@ -0,0 +1,118 @@
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
+config MIPS_SKIP_CP0_COUNT_CLEAR
+	bool
+	help
+	  Do not mtc0 zero,CP0_COUNT at reset. On EN7528 Count is GIC/CM
+	  backed and that write stalls the CPU. Other MIPS targets keep
+	  the generic clear in arch/mips/cpu/start.S.
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
+	default 0x81E00000 if BOARD_EN7528_R3HOOK
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
+	default "u-boot.bin" if BOARD_EN7528_R3HOOK
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
+	  up the SoC and runs the lifted FE-SRAM DDR3 stage (en7528_ddr.bin,
+	  carved from the stock bootbase) before loading SPL into DDR. The exact
+	  DDR-stage entry/handoff is validated over UART during bring-up; see
+	  doc/board/econet/en7528-porting.md.
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
+config BOARD_EN7528_R3HOOK
+	bool "EN7528 JCOW414 R3-hook (FIT + bootm, U-Boot at flash 0x40000)"
+	select SOC_EN7528
+	help
+	  NAND-resident U-Boot for the JCOW414 R3-hook: vendor bootbase + our
+	  R3 (flash 0x20000) SFC-reads this image from flash 0x40000 into
+	  DRAM 0x81E00000. Linked above the OpenWrt FIT kernel load address
+	  (0x80020000) so bootm decompress cannot overwrite U-Boot. Env lives
+	  in MTD at 0xC0000/0xE0000; bootcmd loads the FIT at 0x100000.
+
+endchoice
+
+endmenu
diff --git a/arch/mips/mach-en75xx/Makefile b/arch/mips/mach-en75xx/Makefile
new file mode 100644
index 00000000..f40e49ec
--- /dev/null
+++ b/arch/mips/mach-en75xx/Makefile
@@ -0,0 +1,17 @@
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
+# PIO SFC reader for `en75 sfctest` vs the DM SPI-NAND path.
+obj-$(CONFIG_CMD_EN75BOOT) += early_sfc.o
+endif
+endif
diff --git a/arch/mips/mach-en75xx/cache.c b/arch/mips/mach-en75xx/cache.c
new file mode 100644
index 00000000..3eea715e
--- /dev/null
+++ b/arch/mips/mach-en75xx/cache.c
@@ -0,0 +1,121 @@
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
+	 * DM init fails. Kernel images use en75xx_inval_kernel() after
+	 * a KSEG1 decompress.
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
+void en75xx_inval_kernel(ulong start_addr, ulong size)
+{
+	if (!size)
+		return;
+
+	cache_loop(start_addr, start_addr + size, EN75XX_L1_LINE,
+		   HIT_INVALIDATE_D);
+	cache_loop(start_addr, start_addr + size, EN75XX_L2_LINE,
+		   HIT_INVALIDATE_SD);
+	cache_loop(start_addr, start_addr + size, EN75XX_L1_LINE,
+		   HIT_INVALIDATE_I);
+	sync();
+	instruction_hazard_barrier();
+}
+
+void *image_get_decomp_buf(void *load_buf)
+{
+	void *dst = load_buf;
+
+	if (((uintptr_t)dst & 0xe0000000UL) == CKSEG0) {
+		dst = (void *)CKSEG1ADDR((unsigned long)dst);
+		printf("   Uncached decompress via %p\n", dst);
+	}
+	return dst;
+}
+
+void image_decomp_flush(ulong load, ulong image_len)
+{
+	if (!image_len)
+		return;
+
+	printf("   EN75xx L2/I invalidate %lu bytes\n", image_len);
+	en75xx_inval_kernel(load, image_len);
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
index 00000000..a5732345
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
+	 * (live-verified 0x20038400 => 512 MiB on the JCOW407).
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
index 00000000..ba114116
--- /dev/null
+++ b/arch/mips/mach-en75xx/include/mach/en75xx.h
@@ -0,0 +1,104 @@
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
+ * The lifted DDR stage (en7528_ddr.bin, carved from the JCOW407 stock
+ * bootbase) is the full FE-SRAM first stage: it self-inits SoC registers,
+ * calibrates DDR3 and hands control back via *(EN75XX_SCREG_WR0). It is
+ * loaded at the FE-SRAM base 0x9fa30000 (NOT +0x2800 like EN7512) and is
+ * 0x5a70 bytes (JCOW407 V1.6 carve).
+ *
+ * NOTE (hardware bring-up): the blob's own entry word is `j 0xbfc00060`,
+ * i.e. it is a plain subroutine: entry 0x9fa30000 = NOP pad -> stub @+0x290
+ * -> main(), and one jalr *(SCREG_WR0) hands control back to us.
+ * The exact entry/handoff must be validated over UART — see
+ * doc/board/econet/en7528-porting.md. The constants below build a coherent
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
+void en75xx_inval_kernel(unsigned long addr, unsigned long size);
+void en75xx_prepare_linux(void);
+#endif
+
+#endif /* __MACH_EN75XX_H__ */
-- 
2.53.0

