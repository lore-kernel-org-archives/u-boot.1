Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ACCC83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D56E805D7;
	Tue,  8 Jul 2025 12:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ytYbxPYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EAA80194; Tue,  8 Jul 2025 12:03:58 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C47183278
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2108865f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751969034; x=1752573834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgNRQQJOU59lDNikOzjvWydzE0cVCtIRbqU8905Ey50=;
 b=ytYbxPYZAs60fODD97wj5E64egM0Cn85+F0LNDotaFIwuujSxuY5VSA/tKIAKGSWVe
 vX7CKgbxq3mgTKEQd/lGeJ70c+oNxECI7QmWUq3+XmUNj4HXGUAg8eAda1ktkX7U7tDL
 2t0hQBZ07ACrsM2/Aa7O6MsVn/z5+xRNddl7M1X9f+3TkU0xxouVlOQ4UK8SpBNpOrfD
 S7hd6pSViTzmtA/d9aPjPKIc2ZNGNtctl0Agmdw9u6TupLybxiGKx8ed053Bbr2itCiD
 yTDa3F7wDFJdWeycMgJHKWc3svKt+bLGdMA+hThn+epDRjgCVJlQkK/2KosCCqTtlwp7
 7/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751969034; x=1752573834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgNRQQJOU59lDNikOzjvWydzE0cVCtIRbqU8905Ey50=;
 b=bo+rOpvsdl0wLQnJrGCznRE51vLvD2tH9RsTMNkwox6EdWccMSd/dSJflUMFvNVUJt
 4BlpdBFD0UFCo20BOickl4FkJlAvdyDkFaX2TMgtS9K7Rn47cbHl2qBLBFxNanmkmZWB
 0hDPRcoRA5RhgIQtvhhqpQjleKe/mI5zr4WZfeAD5t5ttpIxg5MKaj/S8Ok6Pb3ZnBXN
 UCUeewmmnUzwsMoWmNiUP3xoTdMIE3ZGOnKz0/TaSiY5XxDFpn3Ns4emqz8YQXrfBqe/
 qRseWJBANKQk7G/B0gSdKcJLBw3/gDdDcb6SJ0jndoeXEv8qrlqLrgsdqBNyKSsNiwZO
 D5sQ==
X-Gm-Message-State: AOJu0Yw9XpJfQFImaVN4pLmYc7F6Ksjvk8SrvMVKZ1O3dc8U10Ys6QH2
 OgwQz66kSIR46RnWqRMt1GyJ0bYehDAuPUbqzyA86H+K1D/sIN4727mVHYLR1Y/oi3/F61t8o1y
 9uRQ5OQwE1w==
X-Gm-Gg: ASbGnctgeEhFF52UHpAWC1t6He+XBCoOfcXmmcFW0ZEXxwm5hwi4W7NjXMcq3pRGAWT
 zQk9Zwbgtgq1xuwdzDV6T4RaLhuSzMJErkFJnq59x50B6xCbYJ/r0/EYqk29y0HNCWF53DqqPb0
 xLmw1rHnrLRxIbBSVbxNDLDzgFbqg9r2sotuzH7XE8RjFpvZ+3RHCyI6EseZzjVgOQ0hY62SMRH
 kwgHKZapdwUIOSv21S1OCTox8FQPnniC2Q9IDCZtzJaRiw/wrc5HU/XcNhwZHpncqNfZ3J6SL7u
 2kYDRVW3U7FI1EYyyyQ+Fr/FLub6X/3L83cfnTXnbovHs5rnOJ/cDNPlzLCIB1DsehykIw==
X-Google-Smtp-Source: AGHT+IFGgm/fdpyETfv3m8Io033sXN8ENsmHwVI7ZDAlKJ+4BEl/BOxGGAHptv1rDtGQQZoTyDEc0w==
X-Received: by 2002:a05:6000:2508:b0:3a4:febd:39f2 with SMTP id
 ffacd0b85a97d-3b497038e4cmr10609363f8f.37.1751969033400; 
 Tue, 08 Jul 2025 03:03:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fc4b:50ea:edb:b51a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm12302261f8f.83.2025.07.08.03.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:03:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Rick Chen <rick@andestech.com>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [RFC PATCH 4/4] linkage: use per-function section in ENTRY,
 WEAK and ENDPROC
Date: Tue,  8 Jul 2025 12:02:50 +0200
Message-ID: <20250708100322.2153533-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708100322.2153533-1-jerome.forissier@linaro.org>
References: <20250708100322.2153533-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In order to extend the unused symbol elimitation by the linker option
--gc-sections to assembly sources, update the ENTRY, WEAK and ENDPROC
macros so that they place the code in function-specific sections
(.text.<name>). In order to deal with special cases such as when
computing an offset between two functions, introduce ENTRY2/WEAK2/ENDPROC2
which do the same as the previous macros.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 arch/arm/cpu/armv7/lowlevel_init.S         |   4 -
 arch/arm/cpu/armv7/ls102xa/psci.S          |   2 +-
 arch/arm/cpu/armv7/nonsec_virt.S           |  16 +--
 arch/arm/cpu/armv7/psci.S                  | 118 ++++++++++-----------
 arch/arm/cpu/armv7/start.S                 |  20 ++--
 arch/arm/cpu/armv8/cache.S                 |  26 -----
 arch/arm/cpu/armv8/psci.S                  |  22 ++--
 arch/arm/cpu/armv8/tlb.S                   |   2 -
 arch/arm/cpu/armv8/transition.S            |   8 --
 arch/arm/lib/ashldi3.S                     |   8 +-
 arch/arm/lib/ashrdi3.S                     |   8 +-
 arch/arm/lib/bitops.S                      |   8 --
 arch/arm/lib/crt0.S                        |   4 +-
 arch/arm/lib/div64.S                       |   2 -
 arch/arm/lib/lib1funcs.S                   |  36 ++-----
 arch/arm/lib/lshrdi3.S                     |   8 +-
 arch/arm/lib/muldi3.S                      |   8 +-
 arch/arm/lib/relocate.S                    |   6 +-
 arch/arm/lib/semihosting.S                 |   2 -
 arch/arm/lib/setjmp.S                      |   6 --
 arch/arm/lib/setjmp_aarch64.S              |   6 --
 arch/arm/lib/uldivmod.S                    |   2 -
 arch/arm/mach-imx/mx5/lowlevel_init.S      |   4 +-
 arch/arm/mach-omap2/omap3/lowlevel_init.S  |  36 +++----
 arch/arm/mach-renesas/lowlevel_init_gen3.S |   6 +-
 arch/arm/mach-tegra/psci.S                 |  12 +--
 arch/riscv/lib/memcpy.S                    |   6 +-
 arch/riscv/lib/memmove.S                   |   7 +-
 arch/riscv/lib/memset.S                    |   6 +-
 arch/riscv/lib/semihosting.S               |   2 -
 arch/riscv/lib/setjmp.S                    |   6 --
 include/linux/linkage.h                    |  20 +++-
 32 files changed, 171 insertions(+), 256 deletions(-)

diff --git a/arch/arm/cpu/armv7/lowlevel_init.S b/arch/arm/cpu/armv7/lowlevel_init.S
index 72b7b7d082c..8cea2007660 100644
--- a/arch/arm/cpu/armv7/lowlevel_init.S
+++ b/arch/arm/cpu/armv7/lowlevel_init.S
@@ -15,13 +15,10 @@
 #include <linux/linkage.h>
 #include <system-constants.h>
 
-.pushsection .text.s_init, "ax"
 WEAK(s_init)
 	bx	lr
 ENDPROC(s_init)
-.popsection
 
-.pushsection .text.lowlevel_init, "ax"
 WEAK(lowlevel_init)
 	/*
 	 * Setup a temporary stack. Global data is not available yet.
@@ -68,4 +65,3 @@ WEAK(lowlevel_init)
 	bl	s_init
 	pop	{ip, pc}
 ENDPROC(lowlevel_init)
-.popsection
diff --git a/arch/arm/cpu/armv7/ls102xa/psci.S b/arch/arm/cpu/armv7/ls102xa/psci.S
index e7c4fbfb434..ab6b95e0ef4 100644
--- a/arch/arm/cpu/armv7/ls102xa/psci.S
+++ b/arch/arm/cpu/armv7/ls102xa/psci.S
@@ -108,7 +108,7 @@ LENTRY(psci_check_target_cpu_id)
 
 	mov	r0, #ARM_PSCI_RET_SUCCESS
 	bx	lr
-ENDPROC(psci_check_target_cpu_id)
+ENDPROC2(psci_check_target_cpu_id)
 
 	@ r1 = target CPU
 	@ r2 = target PC
diff --git a/arch/arm/cpu/armv7/nonsec_virt.S b/arch/arm/cpu/armv7/nonsec_virt.S
index bed40fa3d99..6c46f375e33 100644
--- a/arch/arm/cpu/armv7/nonsec_virt.S
+++ b/arch/arm/cpu/armv7/nonsec_virt.S
@@ -103,13 +103,13 @@ _secure_monitor:
 	msr	spsr_cxfs, ip			@ Set full SPSR
 	movs	pc, lr				@ ERET to non-secure
 
-ENTRY(_do_nonsec_entry)
+ENTRY2(_do_nonsec_entry)
 	mov	ip, r0
 	mov	r0, r1
 	mov	r1, r2
 	mov	r2, r3
 	smc	#0
-ENDPROC(_do_nonsec_entry)
+ENDPROC2(_do_nonsec_entry)
 
 .macro get_cbar_addr	addr
 #ifdef CONFIG_ARM_GIC_BASE_ADDRESS
@@ -140,7 +140,7 @@ ENDPROC(_do_nonsec_entry)
  * code has already been executed by a C function before.
  * Then they go back to wfi and wait to be woken up by the kernel again.
  */
-ENTRY(_smp_pen)
+ENTRY2(_smp_pen)
 	cpsid	i
 	cpsid	f
 
@@ -148,7 +148,7 @@ ENTRY(_smp_pen)
 
 	adr	r0, _smp_pen			@ do not use this address again
 	b	smp_waitloop			@ wait for IPIs, board specific
-ENDPROC(_smp_pen)
+ENDPROC2(_smp_pen)
 #endif
 
 /*
@@ -164,7 +164,7 @@ ENDPROC(_smp_pen)
  * PERIPHBASE is used to get the GIC address. This could be 40 bits long,
  * though, but we check this in C before calling this function.
  */
-ENTRY(_nonsec_init)
+ENTRY2(_nonsec_init)
 	get_gicd_addr	r3
 
 	mvn	r1, #0				@ all bits to 1
@@ -203,11 +203,11 @@ ENTRY(_nonsec_init)
 
 	mov	r0, r3				@ return GICC address
 	bx	lr
-ENDPROC(_nonsec_init)
+ENDPROC2(_nonsec_init)
 
 #ifdef CFG_SMP_PEN_ADDR
 /* void __weak smp_waitloop(unsigned previous_address); */
-WEAK(smp_waitloop)
+WEAK2(smp_waitloop)
 	wfi
 	ldr	r1, =CFG_SMP_PEN_ADDR	@ load start address
 	ldr	r1, [r1]
@@ -218,7 +218,7 @@ WEAK(smp_waitloop)
 	beq	smp_waitloop		@ again (due to a spurious wakeup)
 	mov	r0, r1
 	b	_do_nonsec_entry
-ENDPROC(smp_waitloop)
+ENDPROC2(smp_waitloop)
 #endif
 
 	.popsection
diff --git a/arch/arm/cpu/armv7/psci.S b/arch/arm/cpu/armv7/psci.S
index 41428728b7b..249d09f0b3c 100644
--- a/arch/arm/cpu/armv7/psci.S
+++ b/arch/arm/cpu/armv7/psci.S
@@ -36,52 +36,52 @@ _psci_vectors:
 	b	default_psci_vector	@ irq
 	b	psci_fiq_enter		@ fiq
 
-WEAK(psci_fiq_enter)
+WEAK2(psci_fiq_enter)
 	movs	pc, lr
-ENDPROC(psci_fiq_enter)
+ENDPROC2(psci_fiq_enter)
 
-WEAK(default_psci_vector)
+WEAK2(default_psci_vector)
 	movs	pc, lr
-ENDPROC(default_psci_vector)
+ENDPROC2(default_psci_vector)
 
-WEAK(psci_version)
-WEAK(psci_cpu_suspend)
-WEAK(psci_cpu_off)
-WEAK(psci_cpu_on)
-WEAK(psci_affinity_info)
-WEAK(psci_migrate)
-WEAK(psci_migrate_info_type)
-WEAK(psci_migrate_info_up_cpu)
-WEAK(psci_system_off)
-WEAK(psci_system_reset)
-WEAK(psci_features)
-WEAK(psci_cpu_freeze)
-WEAK(psci_cpu_default_suspend)
-WEAK(psci_node_hw_state)
-WEAK(psci_system_suspend)
-WEAK(psci_set_suspend_mode)
-WEAK(psi_stat_residency)
-WEAK(psci_stat_count)
+WEAK2(psci_version)
+WEAK2(psci_cpu_suspend)
+WEAK2(psci_cpu_off)
+WEAK2(psci_cpu_on)
+WEAK2(psci_affinity_info)
+WEAK2(psci_migrate)
+WEAK2(psci_migrate_info_type)
+WEAK2(psci_migrate_info_up_cpu)
+WEAK2(psci_system_off)
+WEAK2(psci_system_reset)
+WEAK2(psci_features)
+WEAK2(psci_cpu_freeze)
+WEAK2(psci_cpu_default_suspend)
+WEAK2(psci_node_hw_state)
+WEAK2(psci_system_suspend)
+WEAK2(psci_set_suspend_mode)
+WEAK2(psi_stat_residency)
+WEAK2(psci_stat_count)
 	mov	r0, #ARM_PSCI_RET_NI	@ Return -1 (Not Implemented)
 	mov	pc, lr
-ENDPROC(psci_stat_count)
-ENDPROC(psi_stat_residency)
-ENDPROC(psci_set_suspend_mode)
-ENDPROC(psci_system_suspend)
-ENDPROC(psci_node_hw_state)
-ENDPROC(psci_cpu_default_suspend)
-ENDPROC(psci_cpu_freeze)
-ENDPROC(psci_features)
-ENDPROC(psci_system_reset)
-ENDPROC(psci_system_off)
-ENDPROC(psci_migrate_info_up_cpu)
-ENDPROC(psci_migrate_info_type)
-ENDPROC(psci_migrate)
-ENDPROC(psci_affinity_info)
-ENDPROC(psci_cpu_on)
-ENDPROC(psci_cpu_off)
-ENDPROC(psci_cpu_suspend)
-ENDPROC(psci_version)
+ENDPROC2(psci_stat_count)
+ENDPROC2(psi_stat_residency)
+ENDPROC2(psci_set_suspend_mode)
+ENDPROC2(psci_system_suspend)
+ENDPROC2(psci_node_hw_state)
+ENDPROC2(psci_cpu_default_suspend)
+ENDPROC2(psci_cpu_freeze)
+ENDPROC2(psci_features)
+ENDPROC2(psci_system_reset)
+ENDPROC2(psci_system_off)
+ENDPROC2(psci_migrate_info_up_cpu)
+ENDPROC2(psci_migrate_info_type)
+ENDPROC2(psci_migrate)
+ENDPROC2(psci_affinity_info)
+ENDPROC2(psci_cpu_on)
+ENDPROC2(psci_cpu_off)
+ENDPROC2(psci_cpu_suspend)
+ENDPROC2(psci_version)
 
 _psci_table:
 	.word	ARM_PSCI_FN_CPU_SUSPEND
@@ -159,14 +159,14 @@ _smc_psci:
 	movs	pc, lr			@ Return to the kernel
 
 @ Requires dense and single-cluster CPU ID space
-WEAK(psci_get_cpu_id)
+WEAK2(psci_get_cpu_id)
 	mrc	p15, 0, r0, c0, c0, 5	/* read MPIDR */
 	and	r0, r0, #0xff		/* return CPU ID in cluster */
 	bx	lr
-ENDPROC(psci_get_cpu_id)
+ENDPROC2(psci_get_cpu_id)
 
 /* Imported from Linux kernel */
-ENTRY(psci_v7_flush_dcache_all)
+ENTRY2(psci_v7_flush_dcache_all)
 	stmfd	sp!, {r4-r5, r7, r9-r11, lr}
 	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
@@ -213,26 +213,26 @@ finished:
 	isb
 	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}
 	bx	lr
-ENDPROC(psci_v7_flush_dcache_all)
+ENDPROC2(psci_v7_flush_dcache_all)
 
-WEAK(psci_disable_smp)
+WEAK2(psci_disable_smp)
 	mrc	p15, 0, r0, c1, c0, 1		@ ACTLR
 	bic	r0, r0, #(1 << 6)		@ Clear SMP bit
 	mcr	p15, 0, r0, c1, c0, 1		@ ACTLR
 	isb
 	dsb
 	bx	lr
-ENDPROC(psci_disable_smp)
+ENDPROC2(psci_disable_smp)
 
-WEAK(psci_enable_smp)
+WEAK2(psci_enable_smp)
 	mrc	p15, 0, r0, c1, c0, 1		@ ACTLR
 	orr	r0, r0, #(1 << 6)		@ Set SMP bit
 	mcr	p15, 0, r0, c1, c0, 1		@ ACTLR
 	isb
 	bx	lr
-ENDPROC(psci_enable_smp)
+ENDPROC2(psci_enable_smp)
 
-ENTRY(psci_cpu_off_common)
+ENTRY2(psci_cpu_off_common)
 	push	{lr}
 
 	bl	psci_v7_flush_dcache_all
@@ -253,7 +253,7 @@ ENTRY(psci_cpu_off_common)
 
 	pop	{lr}
 	bx	lr
-ENDPROC(psci_cpu_off_common)
+ENDPROC2(psci_cpu_off_common)
 
 @ The stacks are allocated in reverse order, i.e.
 @ the stack for CPU0 has the highest memory address.
@@ -278,12 +278,12 @@ LENTRY(psci_get_cpu_stack_top)
 	sub	r0, r3, r0, LSL #ARM_PSCI_STACK_SHIFT
 	sub	r0, r0, #4		@ Save space for target PC
 	bx	lr
-ENDPROC(psci_get_cpu_stack_top)
+ENDPROC2(psci_get_cpu_stack_top)
 
 @ {r0, r1, r2, ip} from _do_nonsec_entry(kernel_entry, 0, machid, r2) in
 @ arch/arm/lib/bootm.c:boot_jump_linux() must remain unchanged across
 @ this function.
-ENTRY(psci_stack_setup)
+ENTRY2(psci_stack_setup)
 	mov	r6, lr
 	mov	r7, r0
 	bl	psci_get_cpu_id		@ CPU ID => r0
@@ -291,17 +291,17 @@ ENTRY(psci_stack_setup)
 	mov	sp, r0
 	mov	r0, r7
 	bx	r6
-ENDPROC(psci_stack_setup)
+ENDPROC2(psci_stack_setup)
 
-WEAK(psci_arch_init)
+WEAK2(psci_arch_init)
 	mov	pc, lr
-ENDPROC(psci_arch_init)
+ENDPROC2(psci_arch_init)
 
-WEAK(psci_arch_cpu_entry)
+WEAK2(psci_arch_cpu_entry)
 	mov	pc, lr
-ENDPROC(psci_arch_cpu_entry)
+ENDPROC2(psci_arch_cpu_entry)
 
-ENTRY(psci_cpu_entry)
+ENTRY2(psci_cpu_entry)
 	bl	psci_enable_smp
 
 	bl	_nonsec_init
@@ -317,6 +317,6 @@ ENTRY(psci_cpu_entry)
 	bl	psci_get_target_pc		@ target PC => r0
 	pop	{r1}				@ context id => r1
 	b	_do_nonsec_entry
-ENDPROC(psci_cpu_entry)
+ENDPROC2(psci_cpu_entry)
 
 	.popsection
diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 833486817f8..82669ae034d 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -128,7 +128,7 @@ switch_to_hypervisor_ret:
 
 /*------------------------------------------------------------------------------*/
 
-ENTRY(c_runtime_cpu_setup)
+ENTRY2(c_runtime_cpu_setup)
 /*
  * If I-cache is enabled invalidate it
  */
@@ -140,7 +140,7 @@ ENTRY(c_runtime_cpu_setup)
 
 	bx	lr
 
-ENDPROC(c_runtime_cpu_setup)
+ENDPROC2(c_runtime_cpu_setup)
 
 /*************************************************************************
  *
@@ -151,7 +151,7 @@ ENDPROC(c_runtime_cpu_setup)
  * Don't save anything to stack even if compiled with -O0
  *
  *************************************************************************/
-WEAK(save_boot_params)
+WEAK2(save_boot_params)
 #if (IS_ENABLED(CONFIG_BLOBLIST))
 	/* Calculate the PC-relative address of saved_args */
 	adr	r12, saved_args_offset
@@ -168,7 +168,7 @@ WEAK(save_boot_params)
 	str	r3, [r12, #12]
 #endif
 	b	save_boot_params_ret		@ back to my caller
-ENDPROC(save_boot_params)
+ENDPROC2(save_boot_params)
 
 #if (IS_ENABLED(CONFIG_BLOBLIST))
 saved_args_offset:
@@ -187,9 +187,9 @@ END(saved_args)
 #endif
 
 #ifdef CONFIG_ARMV7_LPAE
-WEAK(switch_to_hypervisor)
+WEAK2(switch_to_hypervisor)
 	b	switch_to_hypervisor_ret
-ENDPROC(switch_to_hypervisor)
+ENDPROC2(switch_to_hypervisor)
 #endif
 
 /*************************************************************************
@@ -200,7 +200,7 @@ ENDPROC(switch_to_hypervisor)
  * CONFIG_SYS_ICACHE_OFF is defined.
  *
  *************************************************************************/
-ENTRY(cpu_init_cp15)
+ENTRY2(cpu_init_cp15)
 
 #if CONFIG_IS_ENABLED(ARMV7_SET_CORTEX_SMPEN)
 	/*
@@ -393,7 +393,7 @@ skip_errata_801819:
 #endif
 
 	mov	pc, r5			@ back to my caller
-ENDPROC(cpu_init_cp15)
+ENDPROC2(cpu_init_cp15)
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) && \
 	!CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY)
@@ -405,7 +405,7 @@ ENDPROC(cpu_init_cp15)
  * setup memory timing
  *
  *************************************************************************/
-ENTRY(cpu_init_crit)
+ENTRY2(cpu_init_crit)
 	/*
 	 * Jump to board specific initialization...
 	 * The Mask ROM will have already initialized
@@ -413,7 +413,7 @@ ENTRY(cpu_init_crit)
 	 * wake up conditions.
 	 */
 	b	lowlevel_init		@ go setup pll,mux,memory
-ENDPROC(cpu_init_crit)
+ENDPROC2(cpu_init_crit)
 #endif
 
 #if CONFIG_POSITION_INDEPENDENT
diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
index c9e46859b4f..2d2fca5ca0f 100644
--- a/arch/arm/cpu/armv8/cache.S
+++ b/arch/arm/cpu/armv8/cache.S
@@ -23,7 +23,6 @@
  * x16: FEAT_CCIDX
  * x2~x9: clobbered
  */
-.pushsection .text.__asm_dcache_level, "ax"
 ENTRY(__asm_dcache_level)
 	lsl	x12, x0, #1
 	msr	csselr_el1, x12		/* select cache level */
@@ -64,7 +63,6 @@ loop_way:
 
 	ret
 ENDPROC(__asm_dcache_level)
-.popsection
 
 /*
  * void __asm_flush_dcache_all(int invalidate_only)
@@ -73,7 +71,6 @@ ENDPROC(__asm_dcache_level)
  *
  * flush or invalidate all data cache by SET/WAY.
  */
-.pushsection .text.__asm_dcache_all, "ax"
 ENTRY(__asm_dcache_all)
 	mov	x1, x0
 	dsb	sy
@@ -110,35 +107,26 @@ skip:
 finished:
 	ret
 ENDPROC(__asm_dcache_all)
-.popsection
 
-.pushsection .text.__asm_flush_dcache_all, "ax"
 ENTRY(__asm_flush_dcache_all)
 	mov	x0, #0
 	b	__asm_dcache_all
 ENDPROC(__asm_flush_dcache_all)
-.popsection
 
-.pushsection .text.__asm_invalidate_dcache_all, "ax"
 ENTRY(__asm_invalidate_dcache_all)
 	mov	x0, #0x1
 	b	__asm_dcache_all
 ENDPROC(__asm_invalidate_dcache_all)
-.popsection
 
-.pushsection .text.__asm_flush_l3_dcache, "ax"
 WEAK(__asm_flush_l3_dcache)
 	mov	x0, #0			/* return status as success */
 	ret
 ENDPROC(__asm_flush_l3_dcache)
-.popsection
 
-.pushsection .text.__asm_invalidate_l3_icache, "ax"
 WEAK(__asm_invalidate_l3_icache)
 	mov	x0, #0			/* return status as success */
 	ret
 ENDPROC(__asm_invalidate_l3_icache)
-.popsection
 
 #else	/* CONFIG_CMO_BY_VA */
 
@@ -147,18 +135,14 @@ ENDPROC(__asm_invalidate_l3_icache)
  * accidentally selecting CONFIG_CMO_BY_VA
  */
 
-.pushsection .text.__asm_invalidate_l3_icache, "ax"
 ENTRY(__asm_invalidate_l3_icache)
 	mov	x0, xzr
 	ret
 ENDPROC(__asm_invalidate_l3_icache)
-.popsection
-.pushsection .text.__asm_flush_l3_dcache, "ax"
 ENTRY(__asm_flush_l3_dcache)
 	mov	x0, xzr
 	ret
 ENDPROC(__asm_flush_l3_dcache)
-.popsection
 #endif	/* CONFIG_CMO_BY_VA */
 
 /*
@@ -169,7 +153,6 @@ ENDPROC(__asm_flush_l3_dcache)
  * x0: start address
  * x1: end address
  */
-.pushsection .text.__asm_flush_dcache_range, "ax"
 ENTRY(__asm_flush_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
@@ -186,7 +169,6 @@ ENTRY(__asm_flush_dcache_range)
 	dsb	sy
 	ret
 ENDPROC(__asm_flush_dcache_range)
-.popsection
 /*
  * void __asm_invalidate_dcache_range(start, end)
  *
@@ -195,7 +177,6 @@ ENDPROC(__asm_flush_dcache_range)
  * x0: start address
  * x1: end address
  */
-.pushsection .text.__asm_invalidate_dcache_range, "ax"
 ENTRY(__asm_invalidate_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
@@ -212,34 +193,28 @@ ENTRY(__asm_invalidate_dcache_range)
 	dsb	sy
 	ret
 ENDPROC(__asm_invalidate_dcache_range)
-.popsection
 
 /*
  * void __asm_invalidate_icache_all(void)
  *
  * invalidate all tlb entries.
  */
-.pushsection .text.__asm_invalidate_icache_all, "ax"
 ENTRY(__asm_invalidate_icache_all)
 	ic	ialluis
 	isb	sy
 	ret
 ENDPROC(__asm_invalidate_icache_all)
-.popsection
 
-.pushsection .text.__asm_invalidate_l3_dcache, "ax"
 WEAK(__asm_invalidate_l3_dcache)
 	mov	x0, #0			/* return status as success */
 	ret
 ENDPROC(__asm_invalidate_l3_dcache)
-.popsection
 
 /*
  * void __asm_switch_ttbr(ulong new_ttbr)
  *
  * Safely switches to a new page table.
  */
-.pushsection .text.__asm_switch_ttbr, "ax"
 ENTRY(__asm_switch_ttbr)
 	/* x2 = SCTLR (alive throghout the function) */
 	switch_el x4, 3f, 2f, 1f
@@ -287,4 +262,3 @@ ENTRY(__asm_switch_ttbr)
 
 	ret	x3
 ENDPROC(__asm_switch_ttbr)
-.popsection
diff --git a/arch/arm/cpu/armv8/psci.S b/arch/arm/cpu/armv8/psci.S
index ab8b3df3416..4a9f9af4f4e 100644
--- a/arch/arm/cpu/armv8/psci.S
+++ b/arch/arm/cpu/armv8/psci.S
@@ -12,10 +12,10 @@
 
 /* Default PSCI function, return -1, Not Implemented */
 #define PSCI_DEFAULT(__fn) \
-	WEAK(__fn); \
+	WEAK2(__fn); \
 	mov	w0, #ARM_PSCI_RET_NI; \
 	ret; \
-	ENDPROC(__fn); \
+	ENDPROC2(__fn); \
 
 /* PSCI function and ID table definition*/
 #define PSCI_TABLE(__id, __fn) \
@@ -208,7 +208,7 @@ handle_smc64:
  * used for the return value, while in this PSCI environment, X0 usually holds
  * the SMC function identifier, so X0 should be saved by caller function.
  */
-WEAK(psci_get_cpu_id)
+WEAK2(psci_get_cpu_id)
 #ifdef CONFIG_ARMV8_PSCI_CPUS_PER_CLUSTER
 	mrs	x9, MPIDR_EL1
 	ubfx	x9, x9, #8, #8
@@ -221,7 +221,7 @@ WEAK(psci_get_cpu_id)
 	ubfx	x10, x10, #0, #8
 	add	x0, x10, x9
 	ret
-ENDPROC(psci_get_cpu_id)
+ENDPROC2(psci_get_cpu_id)
 
 /* CPU ID input in x0, stack top output in x0*/
 LENTRY(psci_get_cpu_stack_top)
@@ -229,7 +229,7 @@ LENTRY(psci_get_cpu_stack_top)
 	lsl	x0, x0, #ARM_PSCI_STACK_SHIFT
 	sub	x0, x9, x0
 	ret
-ENDPROC(psci_get_cpu_stack_top)
+ENDPROC2(psci_get_cpu_stack_top)
 
 unhandled_exception:
 	b	unhandled_exception	/* simply dead loop */
@@ -261,9 +261,9 @@ handle_sync:
  * Override this function if custom error handling is
  * needed for asynchronous aborts
  */
-WEAK(plat_error_handler)
+WEAK2(plat_error_handler)
 	ret
-ENDPROC(plat_error_handler)
+ENDPROC2(plat_error_handler)
 
 handle_error:
 	bl	psci_get_cpu_id
@@ -316,14 +316,14 @@ el3_exception_vectors:
 	.align	7
 	b	unhandled_exception	/* SError, Lower EL using AArch32 */
 
-ENTRY(psci_setup_vectors)
+ENTRY2(psci_setup_vectors)
 	adr	x0, el3_exception_vectors
 	msr	vbar_el3, x0
 	ret
-ENDPROC(psci_setup_vectors)
+ENDPROC2(psci_setup_vectors)
 
-WEAK(psci_arch_init)
+WEAK2(psci_arch_init)
 	ret
-ENDPROC(psci_arch_init)
+ENDPROC2(psci_arch_init)
 
 .popsection
diff --git a/arch/arm/cpu/armv8/tlb.S b/arch/arm/cpu/armv8/tlb.S
index 46a0d7d8f63..66527755e31 100644
--- a/arch/arm/cpu/armv8/tlb.S
+++ b/arch/arm/cpu/armv8/tlb.S
@@ -14,7 +14,6 @@
  *
  * invalidate all tlb entries.
 */
-.pushsection .text.__asm_invalidate_tlb_all, "ax"
 ENTRY(__asm_invalidate_tlb_all)
 	switch_el x9, 3f, 2f, 1f
 3:	tlbi	alle3
@@ -31,4 +30,3 @@ ENTRY(__asm_invalidate_tlb_all)
 0:
 	ret
 ENDPROC(__asm_invalidate_tlb_all)
-.popsection
diff --git a/arch/arm/cpu/armv8/transition.S b/arch/arm/cpu/armv8/transition.S
index 85f13ccd0d2..70f50e19801 100644
--- a/arch/arm/cpu/armv8/transition.S
+++ b/arch/arm/cpu/armv8/transition.S
@@ -9,13 +9,10 @@
 #include <linux/linkage.h>
 #include <asm/macro.h>
 
-.pushsection .text.armv8_switch_to_el2_prep, "ax"
 WEAK(armv8_switch_to_el2_prep)
 	ret
 ENDPROC(armv8_switch_to_el2_prep)
-.popsection
 
-.pushsection .text.armv8_switch_to_el2, "ax"
 ENTRY(armv8_switch_to_el2)
 	bl	armv8_switch_to_el2_prep
 	nop
@@ -38,9 +35,7 @@ ENTRY(armv8_switch_to_el2)
 	br x4
 1:	armv8_switch_to_el2_m x4, x5, x6
 ENDPROC(armv8_switch_to_el2)
-.popsection
 
-.pushsection .text.armv8_switch_to_el1, "ax"
 ENTRY(armv8_switch_to_el1)
 	switch_el x6, 0f, 1f, 0f
 0:
@@ -50,10 +45,7 @@ ENTRY(armv8_switch_to_el1)
 	br x4
 1:	armv8_switch_to_el1_m x4, x5, x6, x7
 ENDPROC(armv8_switch_to_el1)
-.popsection
 
-.pushsection .text.armv8_el2_to_aarch32, "ax"
 WEAK(armv8_el2_to_aarch32)
 	ret
 ENDPROC(armv8_el2_to_aarch32)
-.popsection
diff --git a/arch/arm/lib/ashldi3.S b/arch/arm/lib/ashldi3.S
index 6330de4833e..9c4fd0cc877 100644
--- a/arch/arm/lib/ashldi3.S
+++ b/arch/arm/lib/ashldi3.S
@@ -15,8 +15,8 @@
 #endif
 
 .pushsection .text.__ashldi3, "ax"
-ENTRY(__ashldi3)
-ENTRY(__aeabi_llsl)
+ENTRY2(__ashldi3)
+ENTRY2(__aeabi_llsl)
 
 	subs	r3, r2, #32
 	rsb	ip, r2, #32
@@ -28,6 +28,6 @@ ENTRY(__aeabi_llsl)
 	mov	al, al, lsl r2
 	ret	lr
 
-ENDPROC(__ashldi3)
-ENDPROC(__aeabi_llsl)
+ENDPROC2(__ashldi3)
+ENDPROC2(__aeabi_llsl)
 .popsection
diff --git a/arch/arm/lib/ashrdi3.S b/arch/arm/lib/ashrdi3.S
index 64203123446..9eafd2f29e7 100644
--- a/arch/arm/lib/ashrdi3.S
+++ b/arch/arm/lib/ashrdi3.S
@@ -15,8 +15,8 @@
 #endif
 
 .pushsection .text.__ashrdi3, "ax"
-ENTRY(__ashrdi3)
-ENTRY(__aeabi_lasr)
+ENTRY2(__ashrdi3)
+ENTRY2(__aeabi_lasr)
 
 	subs	r3, r2, #32
 	rsb	ip, r2, #32
@@ -28,6 +28,6 @@ ENTRY(__aeabi_lasr)
 	mov	ah, ah, asr r2
 	ret	lr
 
-ENDPROC(__ashrdi3)
-ENDPROC(__aeabi_lasr)
+ENDPROC2(__ashrdi3)
+ENDPROC2(__aeabi_lasr)
 .popsection
diff --git a/arch/arm/lib/bitops.S b/arch/arm/lib/bitops.S
index 29d15246346..6ff7add3730 100644
--- a/arch/arm/lib/bitops.S
+++ b/arch/arm/lib/bitops.S
@@ -7,15 +7,12 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-.pushsection .text.__fls
 ENTRY(__fls)
 	clz	r0, r0
 	rsb	r0, r0, #31
 	ret	lr
 ENDPROC(__fls)
-.popsection
 
-.pushsection .text.__ffs
 ENTRY(__ffs)
 	rsb	r3, r0, #0
 	and	r0, r0, r3
@@ -23,18 +20,14 @@ ENTRY(__ffs)
 	rsb	r0, r0, #31
 	ret	lr
 ENDPROC(__ffs)
-.popsection
 
-.pushsection .text.fls
 ENTRY(fls)
 	cmp	r0, #0
 	clzne	r0, r0
 	rsbne	r0, r0, #32
 	ret	lr
 ENDPROC(fls)
-.popsection
 
-.pushsection .text.ffs
 ENTRY(ffs)
 	rsb	r3, r0, #0
 	and	r0, r0, r3
@@ -42,4 +35,3 @@ ENTRY(ffs)
 	rsb	r0, r0, #32
 	ret	lr
 ENDPROC(ffs)
-.popsection
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a50dde60e8b..591cd394b8b 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -89,7 +89,7 @@ clbss_l:cmp	r0, r1			/* while not at end of BSS */
  * entry point of crt0 sequence
  */
 
-ENTRY(_main)
+ENTRY2(_main)
 
 /* Call arch_very_early_init before initializing C runtime environment. */
 #if CONFIG_IS_ENABLED(ARCH_VERY_EARLY_INIT)
@@ -200,7 +200,7 @@ here:
 	/* we should not return here. */
 #endif
 
-ENDPROC(_main)
+ENDPROC2(_main)
 
 _start_ofs:
 	.word	_start - _main
diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
index a83e3372149..efc62c11bcd 100644
--- a/arch/arm/lib/div64.S
+++ b/arch/arm/lib/div64.S
@@ -44,7 +44,6 @@
  * Clobbered regs: xl, ip
  */
 
-.pushsection .text.__do_div64, "ax"
 ENTRY(__do_div64)
 UNWIND(.fnstart)
 
@@ -210,4 +209,3 @@ Ldiv0_64:
 
 UNWIND(.fnend)
 ENDPROC(__do_div64)
-.popsection
diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index a1f44d94541..0f11bf26c97 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -191,8 +191,8 @@
 
 
 .pushsection .text.__udivsi3, "ax"
-ENTRY(__udivsi3)
-ENTRY(__aeabi_uidiv)
+ENTRY2(__udivsi3)
+ENTRY2(__aeabi_uidiv)
 UNWIND(.fnstart)
 
 	subs	r2, r1, #1
@@ -218,11 +218,10 @@ UNWIND(.fnstart)
 	ret	lr
 
 UNWIND(.fnend)
-ENDPROC(__udivsi3)
-ENDPROC(__aeabi_uidiv)
+ENDPROC2(__udivsi3)
+ENDPROC2(__aeabi_uidiv)
 .popsection
 
-.pushsection .text.__umodsi3, "ax"
 ENTRY(__umodsi3)
 UNWIND(.fnstart)
 
@@ -240,11 +239,10 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__umodsi3)
-.popsection
 
 .pushsection .text.__divsi3, "ax"
-ENTRY(__divsi3)
-ENTRY(__aeabi_idiv)
+ENTRY2(__divsi3)
+ENTRY2(__aeabi_idiv)
 UNWIND(.fnstart)
 
 	cmp	r1, #0
@@ -283,11 +281,10 @@ UNWIND(.fnstart)
 	ret	lr
 
 UNWIND(.fnend)
-ENDPROC(__divsi3)
-ENDPROC(__aeabi_idiv)
+ENDPROC2(__divsi3)
+ENDPROC2(__aeabi_idiv)
 .popsection
 
-.pushsection .text.__modsi3, "ax"
 ENTRY(__modsi3)
 UNWIND(.fnstart)
 
@@ -311,9 +308,7 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__modsi3)
-.popsection
 
-.pushsection .text.__aeabi_uidivmod, "ax"
 ENTRY(__aeabi_uidivmod)
 UNWIND(.fnstart)
 UNWIND(.save {r0, r1, ip, lr}	)
@@ -327,9 +322,7 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_uidivmod)
-.popsection
 
-.pushsection .text.__aeabi_uidivmod, "ax"
 ENTRY(__aeabi_idivmod)
 UNWIND(.fnstart)
 UNWIND(.save {r0, r1, ip, lr}	)
@@ -343,7 +336,6 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_idivmod)
-.popsection
 
 .pushsection .text.Ldiv0, "ax"
 Ldiv0:
@@ -357,12 +349,11 @@ UNWIND(.save {lr})
 	ldr	pc, [sp], #8
 
 UNWIND(.fnend)
-ENDPROC(Ldiv0)
+ENDPROC2(Ldiv0)
 .popsection
 
 /* Thumb-1 specialities */
 #if CONFIG_IS_ENABLED(SYS_THUMB_BUILD) && !defined(CONFIG_HAS_THUMB2)
-.pushsection .text.__gnu_thumb1_case_sqi, "ax"
 ENTRY(__gnu_thumb1_case_sqi)
 	push	{r1}
 	mov	r1, lr
@@ -374,9 +365,7 @@ ENTRY(__gnu_thumb1_case_sqi)
 	pop	{r1}
 	ret	lr
 ENDPROC(__gnu_thumb1_case_sqi)
-.popsection
 
-.pushsection .text.__gnu_thumb1_case_uqi, "ax"
 ENTRY(__gnu_thumb1_case_uqi)
 	push	{r1}
 	mov	r1, lr
@@ -388,9 +377,7 @@ ENTRY(__gnu_thumb1_case_uqi)
 	pop	{r1}
 	ret	lr
 ENDPROC(__gnu_thumb1_case_uqi)
-.popsection
 
-.pushsection .text.__gnu_thumb1_case_shi, "ax"
 ENTRY(__gnu_thumb1_case_shi)
 	push	{r0, r1}
 	mov	r1, lr
@@ -403,9 +390,7 @@ ENTRY(__gnu_thumb1_case_shi)
 	pop	{r0, r1}
 	ret	lr
 ENDPROC(__gnu_thumb1_case_shi)
-.popsection
 
-.pushsection .text.__gnu_thumb1_case_uhi, "ax"
 ENTRY(__gnu_thumb1_case_uhi)
 	push	{r0, r1}
 	mov	r1, lr
@@ -418,10 +403,8 @@ ENTRY(__gnu_thumb1_case_uhi)
 	pop	{r0, r1}
 	ret	lr
 ENDPROC(__gnu_thumb1_case_uhi)
-.popsection
 
 /* Taken and adapted from: https://github.com/gcc-mirror/gcc/blob/4f181f9c7ee3efc509d185fdfda33be9018f1611/libgcc/config/arm/lib1funcs.S#L2156 */
-.pushsection .text.__gnu_thumb1_case_si, "ax"
 ENTRY(__gnu_thumb1_case_si)
 	push	{r0, r1}
 	mov	r1, lr
@@ -435,5 +418,4 @@ ENTRY(__gnu_thumb1_case_si)
 	pop	{r0, r1}
 	mov	pc, lr		/* We know we were called from thumb code.  */
 ENDPROC(__gnu_thumb1_case_si)
-.popsection
 #endif
diff --git a/arch/arm/lib/lshrdi3.S b/arch/arm/lib/lshrdi3.S
index cfa5607c5b0..8f193c596e8 100644
--- a/arch/arm/lib/lshrdi3.S
+++ b/arch/arm/lib/lshrdi3.S
@@ -15,8 +15,8 @@
 #endif
 
 .pushsection .text.__lshldi3, "ax"
-ENTRY(__lshrdi3)
-ENTRY(__aeabi_llsr)
+ENTRY2(__lshrdi3)
+ENTRY2(__aeabi_llsr)
 
 	subs	r3, r2, #32
 	rsb	ip, r2, #32
@@ -28,6 +28,6 @@ ENTRY(__aeabi_llsr)
 	mov	ah, ah, lsr r2
 	ret	lr
 
-ENDPROC(__lshrdi3)
-ENDPROC(__aeabi_llsr)
+ENDPROC2(__lshrdi3)
+ENDPROC2(__aeabi_llsr)
 .popsection
diff --git a/arch/arm/lib/muldi3.S b/arch/arm/lib/muldi3.S
index e6c91811923..8b01ccd7df4 100644
--- a/arch/arm/lib/muldi3.S
+++ b/arch/arm/lib/muldi3.S
@@ -23,8 +23,8 @@
 #endif
 
 .pushsection .text.__muldi3, "ax"
-ENTRY(__muldi3)
-ENTRY(__aeabi_lmul)
+ENTRY2(__muldi3)
+ENTRY2(__aeabi_lmul)
 
 	mul	xh, yl, xh
 	mla	xh, xl, yh, xh
@@ -42,6 +42,6 @@ ENTRY(__aeabi_lmul)
 	adc	xh, xh, ip, lsr #16
 	ret	lr
 
-ENDPROC(__muldi3)
-ENDPROC(__aeabi_lmul)
+ENDPROC2(__muldi3)
+ENDPROC2(__aeabi_lmul)
 .popsection
diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index bffadfecba1..02aacef222b 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -22,8 +22,6 @@
  * the standard cases must provide their own, strong, version.
  */
 
-	.section	.text.relocate_vectors,"ax",%progbits
-
 WEAK(relocate_vectors)
 
 #ifdef CONFIG_CPU_V7M
@@ -76,7 +74,7 @@ ENDPROC(relocate_vectors)
  * respect to relocate_code, and at run time, add relocate_code back to them.
  */
 
-ENTRY(relocate_code)
+ENTRY2(relocate_code)
 relocate_base:
 	adr	r3, relocate_base
 	ldr	r1, _image_copy_start_ofs
@@ -126,7 +124,7 @@ relocate_done:
 
 	ret	lr
 
-ENDPROC(relocate_code)
+ENDPROC2(relocate_code)
 
 _image_copy_start_ofs:
 	.word	__image_copy_start - relocate_code
diff --git a/arch/arm/lib/semihosting.S b/arch/arm/lib/semihosting.S
index 6e1691a832c..39146d5aeb2 100644
--- a/arch/arm/lib/semihosting.S
+++ b/arch/arm/lib/semihosting.S
@@ -7,7 +7,6 @@
 #include <asm/macro.h>
 #include <linux/linkage.h>
 
-.pushsection .text.smh_trap, "ax"
 /* long smh_trap(unsigned int sysnum, void *addr); */
 ENTRY(smh_trap)
 
@@ -34,4 +33,3 @@ ENTRY(smh_trap)
 #endif
 
 ENDPROC(smh_trap)
-.popsection
diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
index 81bef578719..b294775b736 100644
--- a/arch/arm/lib/setjmp.S
+++ b/arch/arm/lib/setjmp.S
@@ -7,7 +7,6 @@
 #include <asm/assembler.h>
 #include <linux/linkage.h>
 
-.pushsection .text.setjmp, "ax"
 ENTRY(setjmp)
 	/*
 	 * A subroutine must preserve the contents of the registers
@@ -19,9 +18,7 @@ ENTRY(setjmp)
 	mov  a1, #0
 	ret  lr
 ENDPROC(setjmp)
-.popsection
 
-.pushsection .text.longjmp, "ax"
 ENTRY(longjmp)
 	ldm  a1, {v1-v8, ip, lr}
 	mov  sp, ip
@@ -33,9 +30,7 @@ ENTRY(longjmp)
 1:
 	ret  lr
 ENDPROC(longjmp)
-.popsection
 
-.pushsection .text.initjmp, "ax"
 ENTRY(initjmp)
 	stm  a1, {v1-v8}
 	/* a2: entry point address, a3: stack base, a4: stack size */
@@ -45,4 +40,3 @@ ENTRY(initjmp)
 	mov  a1, #0
 	ret  lr
 ENDPROC(initjmp)
-.popsection
diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 01193ccc426..7060d4362c3 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -7,7 +7,6 @@
 #include <asm/macro.h>
 #include <linux/linkage.h>
 
-.pushsection .text.setjmp, "ax"
 ENTRY(setjmp)
 	/* Preserve all callee-saved registers and the SP */
 	stp  x19, x20, [x0,#0]
@@ -21,9 +20,7 @@ ENTRY(setjmp)
 	mov  x0, #0
 	ret
 ENDPROC(setjmp)
-.popsection
 
-.pushsection .text.longjmp, "ax"
 ENTRY(longjmp)
 	ldp  x19, x20, [x0,#0]
 	ldp  x21, x22, [x0,#16]
@@ -38,9 +35,7 @@ ENTRY(longjmp)
 	csinc x0, x0, xzr, ne
 	ret
 ENDPROC(longjmp)
-.popsection
 
-.pushsection .text.initjmp, "ax"
 ENTRY(initjmp)
 	/* x1: entry point address, x2: stack base, x3: stack size */
 	add x2, x2, x3
@@ -48,4 +43,3 @@ ENTRY(initjmp)
 	mov  x0, #0
 	ret
 ENDPROC(initjmp)
-.popsection
diff --git a/arch/arm/lib/uldivmod.S b/arch/arm/lib/uldivmod.S
index 5e9e136cc45..880e4e514d9 100644
--- a/arch/arm/lib/uldivmod.S
+++ b/arch/arm/lib/uldivmod.S
@@ -32,7 +32,6 @@ THUMB(
 TMP	.req	r8
 )
 
-.pushsection .text.__aeabi_uldivmod, "ax"
 ENTRY(__aeabi_uldivmod)
 
 	stmfd	sp!, {r4, r5, r6, r7, THUMB(TMP,) lr}
@@ -242,4 +241,3 @@ L_div_by_0:
 	mov	R_1, #0
 	ldmfd	sp!, {r4, r5, r6, r7, THUMB(TMP,) pc}
 ENDPROC(__aeabi_uldivmod)
-.popsection
diff --git a/arch/arm/mach-imx/mx5/lowlevel_init.S b/arch/arm/mach-imx/mx5/lowlevel_init.S
index 6ec38dcfa4e..e31721eaa9f 100644
--- a/arch/arm/mach-imx/mx5/lowlevel_init.S
+++ b/arch/arm/mach-imx/mx5/lowlevel_init.S
@@ -374,7 +374,7 @@ setup_pll_func:
 #endif	/* CONFIG_MX53 */
 .endm
 
-ENTRY(lowlevel_init)
+ENTRY2(lowlevel_init)
 	mov r10, lr
 	mov r4, #0	/* Fix R4 to 0 */
 
@@ -399,7 +399,7 @@ ENTRY(lowlevel_init)
 	init_clock
 
 	mov pc, r10
-ENDPROC(lowlevel_init)
+ENDPROC2(lowlevel_init)
 
 /* Board level setting value */
 #if defined(CONFIG_MX51_PLL_ERRATA)
diff --git a/arch/arm/mach-omap2/omap3/lowlevel_init.S b/arch/arm/mach-omap2/omap3/lowlevel_init.S
index 5541a4714ac..c88784f38fa 100644
--- a/arch/arm/mach-omap2/omap3/lowlevel_init.S
+++ b/arch/arm/mach-omap2/omap3/lowlevel_init.S
@@ -23,7 +23,7 @@
  *	R0 - Service ID
  *	R1 - paramer list
  */
-ENTRY(do_omap3_emu_romcode_call)
+ENTRY2(do_omap3_emu_romcode_call)
 	PUSH {r4-r12, lr} @ Save all registers from ROM code!
 	MOV r12, r0	@ Copy the Secure Service ID in R12
 	MOV r3, r1	@ Copy the pointer to va_list in R3
@@ -35,14 +35,14 @@ ENTRY(do_omap3_emu_romcode_call)
 	mcr     p15, 0, r0, c7, c10, 5	@ DMB
 	SMC     #1	@ Call PPA service
 	POP {r4-r12, pc}
-ENDPROC(do_omap3_emu_romcode_call)
+ENDPROC2(do_omap3_emu_romcode_call)
 
 #if !defined(CONFIG_SYS_NAND_BOOT) && !defined(CONFIG_SYS_NAND_BOOT)
 /**************************************************************************
  * cpy_clk_code: relocates clock code into SRAM where its safer to execute
  * R1 = SRAM destination address.
  *************************************************************************/
-ENTRY(cpy_clk_code)
+ENTRY2(cpy_clk_code)
 	/* Copy DPLL code into SRAM */
 	adr	r0, go_to_speed		/* copy from start of go_to_speed... */
 	adr	r2, go_to_speed_end	/* ... up to start of go_to_speed_end */
@@ -52,7 +52,7 @@ next2:
 	cmp	r0, r2			/* until source end address [r2] */
 	blo	next2
 	mov	pc, lr			/* back to caller */
-ENDPROC(cpy_clk_code)
+ENDPROC2(cpy_clk_code)
 
 /* ***************************************************************************
  *  go_to_speed: -Moves to bypass, -Commits clock dividers, -puts dpll at speed
@@ -67,7 +67,7 @@ ENDPROC(cpy_clk_code)
  *        L3 when its not in self refresh seems bad for it.  Normally, this
  *	  code runs from flash before SDR is init so that should be ok.
  ****************************************************************************/
-ENTRY(go_to_speed)
+ENTRY2(go_to_speed)
 	stmfd sp!, {r4 - r6}
 
 	/* move into fast relock bypass */
@@ -128,7 +128,7 @@ wait2:
 	nop
 	ldmfd	sp!, {r4 - r6}
 	mov	pc, lr		/* back to caller, locked */
-ENDPROC(go_to_speed)
+ENDPROC2(go_to_speed)
 
 _go_to_speed: .word go_to_speed
 
@@ -172,7 +172,7 @@ go_to_speed_end:
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) && \
 	!CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY)
-ENTRY(lowlevel_init)
+ENTRY2(lowlevel_init)
 	ldr	sp, SRAM_STACK
 	str	ip, [sp]	/* stash ip register */
 	mov	ip, lr		/* save link reg across call */
@@ -189,7 +189,7 @@ ENTRY(lowlevel_init)
 	/* tail-call s_init to setup pll, mux, memory */
 	b	s_init
 
-ENDPROC(lowlevel_init)
+ENDPROC2(lowlevel_init)
 #endif
 
 	/* the literal pools origin */
@@ -454,27 +454,27 @@ per2_36x_dpll_param:
 .word PER2_36XX_M_38P4, PER2_36XX_N_38P4, 0, PER2_36XX_M2_38P4
 
 
-ENTRY(get_36x_mpu_dpll_param)
+ENTRY2(get_36x_mpu_dpll_param)
 	adr	r0, mpu_36x_dpll_param
 	mov	pc, lr
-ENDPROC(get_36x_mpu_dpll_param)
+ENDPROC2(get_36x_mpu_dpll_param)
 
-ENTRY(get_36x_iva_dpll_param)
+ENTRY2(get_36x_iva_dpll_param)
 	adr	r0, iva_36x_dpll_param
 	mov	pc, lr
-ENDPROC(get_36x_iva_dpll_param)
+ENDPROC2(get_36x_iva_dpll_param)
 
-ENTRY(get_36x_core_dpll_param)
+ENTRY2(get_36x_core_dpll_param)
 	adr	r0, core_36x_dpll_param
 	mov	pc, lr
-ENDPROC(get_36x_core_dpll_param)
+ENDPROC2(get_36x_core_dpll_param)
 
-ENTRY(get_36x_per_dpll_param)
+ENTRY2(get_36x_per_dpll_param)
 	adr	r0, per_36x_dpll_param
 	mov	pc, lr
-ENDPROC(get_36x_per_dpll_param)
+ENDPROC2(get_36x_per_dpll_param)
 
-ENTRY(get_36x_per2_dpll_param)
+ENTRY2(get_36x_per2_dpll_param)
 	adr	r0, per2_36x_dpll_param
 	mov	pc, lr
-ENDPROC(get_36x_per2_dpll_param)
+ENDPROC2(get_36x_per2_dpll_param)
diff --git a/arch/arm/mach-renesas/lowlevel_init_gen3.S b/arch/arm/mach-renesas/lowlevel_init_gen3.S
index 0d7780031ac..af2f4290172 100644
--- a/arch/arm/mach-renesas/lowlevel_init_gen3.S
+++ b/arch/arm/mach-renesas/lowlevel_init_gen3.S
@@ -31,13 +31,11 @@ ENTRY(save_boot_params)
 	b	save_boot_params_ret
 ENDPROC(save_boot_params)
 
-.pushsection .text.s_init, "ax"
 WEAK(s_init)
 	ret
 ENDPROC(s_init)
-.popsection
 
-ENTRY(lowlevel_init)
+ENTRY2(lowlevel_init)
 	mov	x29, lr			/* Save LR */
 
 #ifndef CONFIG_ARMV8_MULTIENTRY
@@ -100,4 +98,4 @@ lowlevel_in_el1:
 2:
 	mov	lr, x29			/* Restore LR */
 	ret
-ENDPROC(lowlevel_init)
+ENDPROC2(lowlevel_init)
diff --git a/arch/arm/mach-tegra/psci.S b/arch/arm/mach-tegra/psci.S
index f9eb37fc79b..d13a5ef7675 100644
--- a/arch/arm/mach-tegra/psci.S
+++ b/arch/arm/mach-tegra/psci.S
@@ -35,7 +35,7 @@
 	addne	\ofs, \tmp, #FLOW_CTRL_CPU1_CSR - 8
 .endm
 
-ENTRY(psci_arch_init)
+ENTRY2(psci_arch_init)
 	mov	r6, lr
 
 	mrc	p15, 0, r5, c1, c1, 0	@ Read SCR
@@ -61,12 +61,12 @@ ENTRY(psci_arch_init)
 	mcrne	p15, 0, r7, c14, c0, 0	@ write CNTFRQ to CPU1..3
 
 	bx	r6
-ENDPROC(psci_arch_init)
+ENDPROC2(psci_arch_init)
 
 _sys_clock_freq:
 	.word	0
 
-ENTRY(psci_cpu_off)
+ENTRY2(psci_cpu_off)
 	bl	psci_cpu_off_common
 
 	bl	psci_get_cpu_id		@ CPU ID => r0
@@ -81,9 +81,9 @@ ENTRY(psci_cpu_off)
 
 _loop:	wfi
 	b	_loop
-ENDPROC(psci_cpu_off)
+ENDPROC2(psci_cpu_off)
 
-ENTRY(psci_cpu_on)
+ENTRY2(psci_cpu_on)
 	push	{r4, r5, r6, lr}
 
 	mov	r4, r1
@@ -105,6 +105,6 @@ ENTRY(psci_cpu_on)
 
 	mov	r0, #ARM_PSCI_RET_SUCCESS	@ Return PSCI_RET_SUCCESS
 	pop	{r4, r5, r6, pc}
-ENDPROC(psci_cpu_on)
+ENDPROC2(psci_cpu_on)
 
 	.popsection
diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
index 9884077c933..71d5fa07ba2 100644
--- a/arch/riscv/lib/memcpy.S
+++ b/arch/riscv/lib/memcpy.S
@@ -7,8 +7,8 @@
 #include <asm/asm.h>
 
 /* void *memcpy(void *, const void *, size_t) */
-ENTRY(__memcpy)
-WEAK(memcpy)
+ENTRY2(__memcpy)
+WEAK2(memcpy)
 	beq	a0, a1, .copy_end
 	/* Save for return value */
 	mv	t6, a0
@@ -158,4 +158,4 @@ WEAK(memcpy)
 	add	a1, a1, a3
 
 	j	.Lbyte_copy_tail
-END(__memcpy)
+ENDPROC2(__memcpy)
diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index fbe6701dbe4..19bb9fd5261 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -3,8 +3,8 @@
 #include <linux/linkage.h>
 #include <asm/asm.h>
 
-ENTRY(__memmove)
-WEAK(memmove)
+ENTRY2(__memmove)
+WEAK2(memmove)
 	/*
 	 * Here we determine if forward copy is possible. Forward copy is
 	 * preferred to backward copy as it is more cache friendly.
@@ -124,5 +124,4 @@ WEAK(memmove)
 	add	a1, a1, a3
 
 	j	.Lbyte_copy_tail
-
-END(__memmove)
+ENDPROC2(__memmove)
diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index 34c5360c670..200393e0f57 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -8,8 +8,8 @@
 #include <asm/asm.h>
 
 /* void *memset(void *, int, size_t) */
-ENTRY(__memset)
-WEAK(memset)
+ENTRY2(__memset)
+WEAK2(memset)
 	move t0, a0  /* Preserve return value */
 
 	/* Defer to byte-oriented fill for small sizes */
@@ -110,4 +110,4 @@ WEAK(memset)
 	bltu t0, a3, 5b
 6:
 	ret
-END(__memset)
+ENDPROC2(__memset)
diff --git a/arch/riscv/lib/semihosting.S b/arch/riscv/lib/semihosting.S
index 49bb419a962..2421371ab88 100644
--- a/arch/riscv/lib/semihosting.S
+++ b/arch/riscv/lib/semihosting.S
@@ -6,7 +6,6 @@
 #include <asm/asm.h>
 #include <linux/linkage.h>
 
-.pushsection .text.smh_trap, "ax"
 ENTRY(smh_trap)
 	.align	4		/* keep slli, ebreak, srai in same page */
 	.option	push
@@ -19,4 +18,3 @@ ENTRY(smh_trap)
 
 	ret
 ENDPROC(smh_trap)
-.popsection
diff --git a/arch/riscv/lib/setjmp.S b/arch/riscv/lib/setjmp.S
index 9e1f3d5749b..50624c61c5f 100644
--- a/arch/riscv/lib/setjmp.S
+++ b/arch/riscv/lib/setjmp.S
@@ -14,7 +14,6 @@
 #define LOAD_IDX(reg, idx)	lw reg, (idx*4)(a0)
 #endif
 
-.pushsection .text.setjmp, "ax"
 ENTRY(setjmp)
 	/* Preserve all callee-saved registers and the SP */
 	STORE_IDX(s0, 0)
@@ -34,9 +33,7 @@ ENTRY(setjmp)
 	li  a0, 0
 	ret
 ENDPROC(setjmp)
-.popsection
 
-.pushsection .text.longjmp, "ax"
 ENTRY(longjmp)
 	LOAD_IDX(s0, 0)
 	LOAD_IDX(s1, 1)
@@ -58,9 +55,7 @@ ENTRY(longjmp)
 	add a0, a0, a1
 	ret
 ENDPROC(longjmp)
-.popsection
 
-.pushsection .text.initjmp, "ax"
 ENTRY(initjmp)
 	/* a1: entry point address, a2: stack base, a3: stack size */
 	add a2, a2, a3
@@ -69,4 +64,3 @@ ENTRY(initjmp)
 	li  a0, 0
 	ret
 ENDPROC(initjmp)
-.popsection
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 0b24111d6ae..65e88122226 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -50,25 +50,37 @@
 	ALIGN ASM_NL \
 	SYMBOL_NAME_LABEL(name)
 
-#define ENTRY(name) \
+#define ENTRY2(name) \
 	.globl SYMBOL_NAME(name) ASM_NL \
 	LENTRY(name)
 
-#define WEAK(name) \
+#define WEAK2(name) \
 	.weak SYMBOL_NAME(name) ASM_NL \
 	LENTRY(name)
 
+#define ENTRY(name) \
+	.pushsection .text.##name,"ax",%progbits ASM_NL \
+	ENTRY2(name)
+
+#define WEAK(name) \
+	.pushsection .text.##name,"ax",%progbits ASM_NL \
+	WEAK2(name)
+
 #ifndef END
 #define END(name) \
 	.size name, .-name
 #endif
 
-#ifndef ENDPROC
-#define ENDPROC(name) \
+#define ENDPROC2(name) \
 	.type name STT_FUNC ASM_NL \
 	END(name)
 #endif
 
+#ifndef ENDPROC
+#define ENDPROC(name) \
+	ENDPROC2(name) ASM_NL \
+	.popsection
+
 #endif
 
 #endif
-- 
2.43.0

