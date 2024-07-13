Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347E4C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 861FD88919;
	Sat, 13 Jul 2024 15:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ocNHlb2/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PmjAY261";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69431888A5; Sat, 13 Jul 2024 15:21:50 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32260888FD
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyh05Pwz9sZF;
 Sat, 13 Jul 2024 15:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39OVwhO0TQ86hipOIpL++eXWAwI4JGSgPr50CSxqEm8=;
 b=ocNHlb2/QlYAKwBB5T/Cqmvggkx+l+HO1HD1+6r7PTdRy3xma0gNKC0glZwC0wbwQbvgaW
 Hd8W/ufJeM46lMXxkr2zDMzO38GC6ckgcX6M222Z2NryoNTLk2BGtjPJ1KCLyeRUXK+nyG
 tITJScL7iRqFqZoTNrQQ9qW+5mV2kZoGuqyS/sMZcodWDpfpKOlkwHeCMlgKlwmbnS3mlX
 wuWlVqW3dbaS8CoQm/41pQH11gTCKst6WxiFNPzKMLOtK2TU8FQm5mKfGB7W1ljPgZFFgC
 +7OQIR2se08f2YjWjbiq97H8GytI5MBNncx0Nwlv/LHkhoJtlwdh8XsacUFNwQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39OVwhO0TQ86hipOIpL++eXWAwI4JGSgPr50CSxqEm8=;
 b=PmjAY261BUoeiDoIdtRb/IkSXJtYiCm3Asur0nPqR/GCd9hJFjP8YH5ACWWP0j8ErTx5eF
 3KbFsOOzkoOEyMUqTok60MKF669mTwKMz/36ddMaH57Hwk/TWY9BiNsYeO1Wyex7Sm5pV9
 hOZ2/8dktS6vN8Q7BOxSj/Vx0eGgQU1sP1eyJY76yfiRXCYY84KDpIRMFl2erR+zmEAlFL
 f5Ge5ESFhwaNJDyCaCACJ34kqmdBXh06lcktKIUcmPNBOl323abN+TzC0aAekfmui8BYU3
 z2LHUz1Y0VyRgN7XvY363RYhSSP1YQGKdZ4aSrnncv82RHm3am/AOQibMfc2Tw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 38/45] ppc: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:29 +0200
Message-ID: <20240713132021.57650-38-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ec66a37459d351ae54f
X-MBO-RS-META: kon6j957x7yw3xuwqn59s7mho3koy5dc
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/powerpc/cpu/mpc83xx/interrupts.c         | 5 -----
 arch/powerpc/cpu/mpc83xx/traps.c              | 2 --
 arch/powerpc/cpu/mpc85xx/cpu.c                | 3 ---
 arch/powerpc/cpu/mpc85xx/cpu_init.c           | 1 -
 arch/powerpc/cpu/mpc85xx/fdt.c                | 1 -
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c | 1 -
 arch/powerpc/cpu/mpc85xx/mp.c                 | 1 -
 arch/powerpc/cpu/mpc85xx/p1010_serdes.c       | 1 -
 arch/powerpc/cpu/mpc85xx/speed.c              | 1 -
 arch/powerpc/cpu/mpc85xx/t1024_serdes.c       | 1 -
 arch/powerpc/cpu/mpc85xx/t1040_serdes.c       | 1 -
 arch/powerpc/cpu/mpc85xx/tlb.c                | 1 -
 arch/powerpc/cpu/mpc85xx/traps.c              | 1 -
 arch/powerpc/cpu/mpc8xx/immap.c               | 1 -
 arch/powerpc/cpu/mpc8xx/traps.c               | 2 --
 arch/powerpc/cpu/mpc8xxx/cpu.c                | 1 -
 arch/powerpc/cpu/mpc8xxx/fsl_lbc.c            | 1 -
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c           | 3 ---
 arch/powerpc/cpu/mpc8xxx/law.c                | 1 -
 arch/powerpc/include/asm/bitops.h             | 1 -
 arch/powerpc/include/asm/config_mpc85xx.h     | 2 --
 arch/powerpc/include/asm/fsl_pci.h            | 1 -
 arch/powerpc/include/asm/io.h                 | 1 -
 arch/powerpc/include/asm/mmu.h                | 3 ---
 arch/powerpc/include/asm/mpc8349_pci.h        | 3 ---
 arch/powerpc/include/asm/sigcontext.h         | 1 -
 arch/powerpc/lib/bootm.c                      | 1 -
 arch/powerpc/lib/interrupts.c                 | 1 -
 28 files changed, 43 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/interrupts.c b/arch/powerpc/cpu/mpc83xx/interrupts.c
index d86c981811e..af517213f17 100644
--- a/arch/powerpc/cpu/mpc83xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc83xx/interrupts.c
@@ -32,7 +32,6 @@ void interrupt_init_cpu (unsigned *decrementer_count)
 	immr->sysconf.spcr |= 0x00400000;
 }
 
-
 /*
  * Handle external interrupts
  */
@@ -41,7 +40,6 @@ void external_interrupt(struct pt_regs *regs)
 {
 }
 
-
 /*
  * Install and free an interrupt handler.
  */
@@ -51,19 +49,16 @@ irq_install_handler(int irq, interrupt_handler_t * handler, void *arg)
 {
 }
 
-
 void irq_free_handler(int irq)
 {
 }
 
-
 void timer_interrupt_cpu (struct pt_regs *regs)
 {
 	/* nothing to do here */
 	return;
 }
 
-
 #if defined(CONFIG_CMD_IRQ)
 
 /* ripped this out of ppc4xx/interrupts.c */
diff --git a/arch/powerpc/cpu/mpc83xx/traps.c b/arch/powerpc/cpu/mpc83xx/traps.c
index 79ea1a9bb3c..d50499ceb7c 100644
--- a/arch/powerpc/cpu/mpc83xx/traps.c
+++ b/arch/powerpc/cpu/mpc83xx/traps.c
@@ -74,7 +74,6 @@ void show_regs(struct pt_regs *regs)
 	}
 }
 
-
 static void _exception(int signr, struct pt_regs *regs)
 {
 	show_regs(regs);
@@ -191,7 +190,6 @@ void SoftEmuException(struct pt_regs *regs)
 	panic("Software Emulation Exception");
 }
 
-
 void UnknownException(struct pt_regs *regs)
 {
 #if defined(CONFIG_CMD_KGDB)
diff --git a/arch/powerpc/cpu/mpc85xx/cpu.c b/arch/powerpc/cpu/mpc85xx/cpu.c
index ebce2fe3935..ab4ef154729 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu.c
@@ -297,7 +297,6 @@ int checkcpu (void)
 	return 0;
 }
 
-
 /* ------------------------------------------------------------------------- */
 
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -337,7 +336,6 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 1;
 }
 
-
 /*
  * Get timebase clock frequency
  */
@@ -348,7 +346,6 @@ __weak unsigned long get_tbclk(void)
 	return (gd->bus_clk + (tbclk_div >> 1)) / tbclk_div;
 }
 
-
 /*
  * Initializes on-chip MMC controllers.
  * to override, implement board_mmc_init()
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index b770d294e61..a7b805bc674 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -128,7 +128,6 @@ void fsl_erratum_a006261_workaround(struct ccsr_usb_phy __iomem *usb_phy)
 }
 #endif
 
-
 #if defined(CONFIG_QE) && !defined(CONFIG_U_QE)
 extern qe_iop_conf_t qe_iop_conf_tab[];
 extern void qe_config_iopin(u8 port, u8 pin, int dir,
diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index c56e98d4b49..b2c0c517e7a 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -428,7 +428,6 @@ static inline void ft_fixup_cache(void *blob)
 	ft_fixup_l2cache(blob);
 }
 
-
 void fdt_add_enet_stashing(void *fdt)
 {
 	do_fixup_by_compat(fdt, "gianfar", "bd-stash", NULL, 0, 1);
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
index 78316ea5ffe..f2f854ebc12 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
@@ -482,7 +482,6 @@ static void wait_for_rstdone(unsigned int bank)
 		printf("SERDES: timeout resetting bank %u\n", bank + 1);
 }
 
-
 static void __soc_serdes_init(void)
 {
 	/* Allow for SoC-specific initialization in <SOC>_serdes.c  */
diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index b638f24ed14..03f801ebbb7 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -191,7 +191,6 @@ u32 determine_mp_bootpg(unsigned int *pagesize)
 	struct law_entry e;
 #endif
 
-
 	/* use last 4K of mapped memory */
 	bootpg = ((gd->ram_size > CFG_MAX_MEM_MAPPED) ?
 		CFG_MAX_MEM_MAPPED : gd->ram_size) +
diff --git a/arch/powerpc/cpu/mpc85xx/p1010_serdes.c b/arch/powerpc/cpu/mpc85xx/p1010_serdes.c
index d38041ef5c2..c1190667cef 100644
--- a/arch/powerpc/cpu/mpc85xx/p1010_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p1010_serdes.c
@@ -29,7 +29,6 @@ static const u8 serdes2_cfg_tbl[][SRDS2_MAX_LANES] = {
 	[0x03] = {PCIE1, PCIE2},
 };
 
-
 int is_serdes_configured(enum srds_prtcl device)
 {
 	int ret;
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index a7e1b3c98a9..d17a19026dd 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -625,7 +625,6 @@ int get_clocks(void)
 	else return (1);
 }
 
-
 /********************************************
  * get_bus_freq
  * return system bus freq in Hz
diff --git a/arch/powerpc/cpu/mpc85xx/t1024_serdes.c b/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
index 0d958fe131b..ff76bed1af2 100644
--- a/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
@@ -7,7 +7,6 @@
 #include <asm/processor.h>
 #include <asm/io.h>
 
-
 static u8 serdes_cfg_tbl[][SRDS_MAX_LANES] = {
 	[0x40] = {PCIE1, PCIE1, PCIE1, PCIE1},
 	[0xD5] = {QSGMII_FM1_A, PCIE3, PCIE2, PCIE1},
diff --git a/arch/powerpc/cpu/mpc85xx/t1040_serdes.c b/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
index 2033ebbaa5e..fb59a3e4136 100644
--- a/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
@@ -9,7 +9,6 @@
 #include <asm/io.h>
 #include <asm/ppc.h>
 
-
 static u8 serdes_cfg_tbl[][SRDS_MAX_LANES] = {
 	[0x00] = {PCIE1, PCIE1, PCIE1, PCIE1,
 		PCIE2, PCIE2, PCIE2, PCIE2},
diff --git a/arch/powerpc/cpu/mpc85xx/tlb.c b/arch/powerpc/cpu/mpc85xx/tlb.c
index e0b36f869a9..32b68a169a4 100644
--- a/arch/powerpc/cpu/mpc85xx/tlb.c
+++ b/arch/powerpc/cpu/mpc85xx/tlb.c
@@ -354,5 +354,4 @@ void clear_ddr_tlbs(unsigned int memsize_in_meg)
 	clear_ddr_tlbs_phys(CFG_SYS_DDR_SDRAM_BASE, memsize_in_meg);
 }
 
-
 #endif /* not SPL */
diff --git a/arch/powerpc/cpu/mpc85xx/traps.c b/arch/powerpc/cpu/mpc85xx/traps.c
index db70f07500c..a1c111ec171 100644
--- a/arch/powerpc/cpu/mpc85xx/traps.c
+++ b/arch/powerpc/cpu/mpc85xx/traps.c
@@ -111,7 +111,6 @@ void show_regs(struct pt_regs *regs)
 	}
 }
 
-
 static void _exception(int signr, struct pt_regs *regs)
 {
 	show_regs(regs);
diff --git a/arch/powerpc/cpu/mpc8xx/immap.c b/arch/powerpc/cpu/mpc8xx/immap.c
index 8c85fc180b9..09aaebc5c47 100644
--- a/arch/powerpc/cpu/mpc8xx/immap.c
+++ b/arch/powerpc/cpu/mpc8xx/immap.c
@@ -206,7 +206,6 @@ static int do_iopset(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (pin > 31)
 		rcode = 1;
 
-
 	switch (argv[3][0]) {
 	case 'd':
 		if (argv[3][1] == 'a')
diff --git a/arch/powerpc/cpu/mpc8xx/traps.c b/arch/powerpc/cpu/mpc8xx/traps.c
index 5220c560e5f..22f2f5878e3 100644
--- a/arch/powerpc/cpu/mpc8xx/traps.c
+++ b/arch/powerpc/cpu/mpc8xx/traps.c
@@ -75,7 +75,6 @@ void show_regs(struct pt_regs *regs)
 	}
 }
 
-
 static void _exception(int signr, struct pt_regs *regs)
 {
 	show_regs(regs);
@@ -142,7 +141,6 @@ void SoftEmuException(struct pt_regs *regs)
 	panic("Software Emulation Exception");
 }
 
-
 void UnknownException(struct pt_regs *regs)
 {
 	printf("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 82f28749eb1..d64eb7328fe 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -300,7 +300,6 @@ __weak int cpu_numcores(void)
 	return cpu->num_cores;
 }
 
-
 /*
  * Check if the given core ID is valid
  *
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c b/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
index 843dd191ccf..9b7a07958ec 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
@@ -20,7 +20,6 @@ static void __lbc_sdram_init(void)
 void lbc_sdram_init(void) __attribute__((weak, alias("__lbc_sdram_init")));
 #endif
 
-
 void print_lbc_regs(void)
 {
 	int i;
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
index 29399bcd8b6..3a82e60a247 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
@@ -26,7 +26,6 @@ static inline int __ilog2_roundup_64(uint64_t val)
 		return  __ilog2_u64(val) + 1;
 }
 
-
 static inline int count_lsb_zeroes(unsigned long val)
 {
 	return ffs(val) - 1;
@@ -332,7 +331,6 @@ void pamu_disable(void)
 	u32 i  = 0;
 	u32 base_addr = CFG_SYS_PAMU_ADDR;
 
-
 	for (i = 0; i < CFG_NUM_PAMU; i++) {
 		clrbits_be32((void *)base_addr + PAMU_PCR_OFFSET, PAMU_PCR_PE);
 		sync();
@@ -340,7 +338,6 @@ void pamu_disable(void)
 	}
 }
 
-
 static uint64_t find_max(uint64_t arr[], int num)
 {
 	int i = 0;
diff --git a/arch/powerpc/cpu/mpc8xxx/law.c b/arch/powerpc/cpu/mpc8xxx/law.c
index f16bc199663..2e744b9322c 100644
--- a/arch/powerpc/cpu/mpc8xxx/law.c
+++ b/arch/powerpc/cpu/mpc8xxx/law.c
@@ -31,7 +31,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define LAWBAR_SHIFT 12
 #endif
 
-
 static inline phys_addr_t get_law_base_addr(int idx)
 {
 #ifdef CONFIG_FSL_CORENET
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 96491b6e4ec..b22eebaa0ae 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -270,7 +270,6 @@ found_middle:
 	return result + ffz(tmp);
 }
 
-
 #define _EXT2_HAVE_ASM_BITOPS_
 
 #ifdef __KERNEL__
diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index d990ecff96f..819250f0090 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -82,7 +82,6 @@
 #define CFG_SYS_FM_MURAM_SIZE	0x28000
 #define CFG_SYS_FSL_CORENET_SNOOPVEC_COREONLY 0xf0000000
 
-
 #elif defined(CONFIG_ARCH_T4240)
 #ifdef CONFIG_ARCH_T4240
 #define CFG_SYS_FSL_CLUSTER_CLOCKS   { 1, 1, 4 }
@@ -168,7 +167,6 @@
 #define CFG_SYS_FM_MURAM_SIZE	0x28000
 #define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 
-
 #elif defined(CONFIG_ARCH_C29X)
 #define CFG_SYS_FSL_SEC_IDX_OFFSET	0x20000
 
diff --git a/arch/powerpc/include/asm/fsl_pci.h b/arch/powerpc/include/asm/fsl_pci.h
index 809ab1d4187..6c6e436b6ee 100644
--- a/arch/powerpc/include/asm/fsl_pci.h
+++ b/arch/powerpc/include/asm/fsl_pci.h
@@ -269,5 +269,4 @@ int fsl_pcie_init_board(int busno);
 #error FT_FSL_PCI_SETUP not defined
 #endif
 
-
 #endif
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 2412bb9d7c1..9a59ed8c5a0 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -92,7 +92,6 @@ extern void _outsl_ns(volatile u32 *port, const void *buf, int nl);
 #define insl_ns(port, buf, nl)  _insl_ns((u32 *)((port)+_IO_BASE), (buf), (nl))
 #define outsl_ns(port, buf, nl) _outsl_ns((u32 *)((port)+_IO_BASE), (buf), (nl))
 
-
 #define IO_SPACE_LIMIT ~0
 
 #define memset_io(a,b,c)       memset((void __force *)(a),(b),(c))
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index b0aafdcdae1..bc7716b7079 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -126,7 +126,6 @@ typedef struct _pte {
 #define PT_MASK  0x02FF
 #define PG_SHIFT (12)			/* Page Entry */
 
-
 /* MMU context */
 
 typedef struct _MMU_context {
@@ -304,7 +303,6 @@ extern void print_bats(void);
 #define M_CASID		793	/* Address space ID (context) to match */
 #define MC_ASIDMASK	0x0000000f	/* Bits used for ASID value */
 
-
 /* These are the Ks and Kp from the PowerPC books.  For proper operation,
  * Ks = 0, Kp = 1.
  */
@@ -349,7 +347,6 @@ extern void print_bats(void);
 #define MD_SVALID	0x00000001	/* Segment entry is valid */
 					/* Reset value is undefined */
 
-
 /* Real page number.  Defined by the pte.  Writing this register
  * causes a TLB entry to be created for the data TLB, using
  * additional information from the MD_EPN, and MD_TWC registers.
diff --git a/arch/powerpc/include/asm/mpc8349_pci.h b/arch/powerpc/include/asm/mpc8349_pci.h
index 7a1adba950d..3d920c25ade 100644
--- a/arch/powerpc/include/asm/mpc8349_pci.h
+++ b/arch/powerpc/include/asm/mpc8349_pci.h
@@ -1,7 +1,6 @@
 #ifndef _PPC_KERNEL_MPC8349_PCI_H
 #define _PPC_KERNEL_MPC8349_PCI_H
 
-
 #define M8265_PCIBR0	0x101ac
 #define M8265_PCIBR1	0x101b0
 #define M8265_PCIMSK0	0x101c4
@@ -30,10 +29,8 @@
 #define PCIMSK_512MB        0xE0000000
 #define PCIMSK_1GB          0xC0000000  /* Size of window, largest */
 
-
 #define M826X_SCCR_PCI_MODE_EN 0x100
 
-
 /*
  * Outbound ATU registers (3 sets). These registers control how 60x bus
  * (local) addresses are translated to PCI addresses when the MPC826x is
diff --git a/arch/powerpc/include/asm/sigcontext.h b/arch/powerpc/include/asm/sigcontext.h
index 715c868ab67..5dee3ba415b 100644
--- a/arch/powerpc/include/asm/sigcontext.h
+++ b/arch/powerpc/include/asm/sigcontext.h
@@ -3,7 +3,6 @@
 
 #include <asm/ptrace.h>
 
-
 struct sigcontext_struct {
 	unsigned long	_unused[4];
 	int		signal;
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index f55b5ff8320..61e08728dd4 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -6,7 +6,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-
 #include <config.h>
 #include <bootm.h>
 #include <bootstage.h>
diff --git a/arch/powerpc/lib/interrupts.c b/arch/powerpc/lib/interrupts.c
index 92b8a0bceac..46208ae4c71 100644
--- a/arch/powerpc/lib/interrupts.c
+++ b/arch/powerpc/lib/interrupts.c
@@ -32,7 +32,6 @@ static __inline__ unsigned long get_dec (void)
 	return val;
 }
 
-
 static __inline__ void set_dec (unsigned long val)
 {
 	if (val)
-- 
2.43.0

