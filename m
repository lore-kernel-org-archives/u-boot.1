Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40111CD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0BB848A6;
	Tue,  9 Jun 2026 03:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKKrfp5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E7B848D7; Tue,  9 Jun 2026 03:26:26 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B44A848A2
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68f0fc103easo522124a12.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968383; x=1781573183; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mBODNBcFmQRYdZ+okefsxbHjkNsyBqUntHtuz6X7Gew=;
 b=fKKrfp5wDgeCW0qNX4KCC8zLRl1cFKWSqH1aZCT0emBwsBX7U49dyqb9RDngWoOzOw
 BQ8DCi0Nsxjgoi3PVGRKu6Zxr9ddRDbgqRqoo7Y9s6m9JydAu3QskLaHE+/x2/NL0v2u
 1Q+0Z7y5NdckRLJdcm9I/leGiOkdVv254yOr/47MPqTzVtdN2B2fclikGAovol25rC6p
 1/rsdUIzM0EMwQt2xlFIOa/YCd7YqcCRK5zl5qHX0egYTCuI8vNImUBXRxKi90lKbNh7
 9btt1+Ryy386/MsoxABYKj+MFexaymK5z9tR6D/L03ap4MA0WnYA3W03CInjHa+laVlS
 uAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968383; x=1781573183;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mBODNBcFmQRYdZ+okefsxbHjkNsyBqUntHtuz6X7Gew=;
 b=LbCBzQ9wMDDipNQRYFCSNGNPrvpG6bfo/xVbDDYmDC1MmaERvVNCCumhZE18hOQ9PJ
 TvKR78lvx2DowzavNrsELPx1i/piUTWdXguINQxZsW0Gj8hNKC0H0Ehyc66Yyg6PpJGU
 +LjXwvI/iZeEJswUUkCDRrPKpcK3mupcjwf3Wwja0IwnovdDdcPPZ0fCaLjKgefhsAVJ
 pStAk37SO/CdZt058NqkkwJjvo1wwvUnw3/95fMr5Y5ovMvRCQ2bPYrv80Wj05WAg3PV
 SMIJHcQmwO5LMp1nmsVODjy0xh6Dae15rNR9lKllx6+9EoOjXAJ9vF/+a24PJ8em6RS5
 4VqQ==
X-Gm-Message-State: AOJu0YxuRDNLI/UvQM0tV7eWZiibpn1suxzDq3+7dV2BP5N0Wdb/1JcS
 sWAW196us4BZXjd4XgviQ49EdtH9Qwzf/81kOaYB1mCOPCgJjqB+ZvUh
X-Gm-Gg: Acq92OFVnjKMgwI6Mdygr6aoRjF0TQQ79TtoppJF82btBUos+t1lOf4BRPgSlehuUx5
 42wtPTQy+Pq/Zup5ExDA/voefV1zD3ug6bxY0kF3x+Wpcy7eXm/CjJKuIn5v/MiZCZVrvYfTorS
 +utDQ9cXr2Xm2vw87o45Md2lKsXetAVq3lzddoakcdgHVWJYg9g1yAd2SHvXQ2tiCyTe0mrVPBE
 AHWVuXWO5vNEOEa9GR8qxQKF9pBPBFLnrZ577BROZOwOAQpxjUnthAeSjeYYXN8ThVUpSk/JqwZ
 rdok561bdew6IHCiusbDx7cu4mW0DRx26c6S/eir0Ldw3LpjASXiUwjkm/YA2XsUUJbjLEGC2zE
 Y0AYp3fBzPTxD6H4CruO7o1BlZD5k51C9frRzWRwUkY3qWcKTruuU8ySyLPo2vqf/6QabtswJFk
 Iy1HzDU+qDoAnV4AtrhABwbRGRKk7cw5r6y0El0KTMVE3TOCztRzdEWwRUJBMf2Z3MUNdqPlYB
X-Received: by 2002:a17:906:45a4:b0:beb:9c9:335 with SMTP id
 a640c23a62f3a-bf93a617831mr4873266b.5.1780968383443; 
 Mon, 08 Jun 2026 18:26:23 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05176fd07sm965007866b.1.2026.06.08.18.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:26:21 -0700 (PDT)
Message-ID: <33cb3c5e-785f-46da-8378-bb562d71b312@gmail.com>
Date: Tue, 9 Jun 2026 03:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 7/8] Kconfig: arch: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs other then "arm":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/Kconfig                     | 16 ++++++------
 arch/m68k/Kconfig                | 34 ++++++++++++------------
 arch/mips/Kconfig                |  8 +++---
 arch/mips/mach-octeon/Kconfig    |  8 +++---
 arch/powerpc/cpu/mpc85xx/Kconfig | 44 ++++++++++++++++----------------
 arch/x86/Kconfig                 | 20 +++++++--------
 6 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e28e4c4bce73..8d63afeb138e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,14 +11,14 @@ config HAVE_ARCH_IOREMAP
 config HAVE_SETJMP
 	bool
 	help
-	 The architecture supports setjmp() and longjmp().
+	  The architecture supports setjmp() and longjmp().

 config HAVE_INITJMP
 	bool
 	depends on HAVE_SETJMP
 	help
-	 The architecture supports initjmp(), a non-standard companion to
-	 setjmp() and longjmp().
+	  The architecture supports initjmp(), a non-standard companion to
+	  setjmp() and longjmp().

 config SUPPORT_BIG_ENDIAN
 	bool
@@ -457,11 +457,11 @@ config SYS_CONFIG_NAME
 config SYS_DISABLE_DCACHE_OPS
 	bool
 	help
-	 This option disables dcache flush and dcache invalidation
-	 operations. For example, on coherent systems where cache
-	 operatios are not required, enable this option to avoid them.
-	 Note that, its up to the individual architectures to implement
-	 this functionality.
+	  This option disables dcache flush and dcache invalidation
+	  operations. For example, on coherent systems where cache
+	  operatios are not required, enable this option to avoid them.
+	  Note that, its up to the individual architectures to implement
+	  this functionality.

 config SYS_IMMR
 	hex "Address for the Internal Memory-Mapped Registers (IMMR) window"
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 00e89bd0a625..c1b9dac014c2 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,56 +11,56 @@ config STATIC_RELA
 config MCF520x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF52x2
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF523x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF530x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF5301x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF532x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF537x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	bool

 config MCF5441x
 	select OF_CONTROL
 	select DM
-        select DM_SERIAL
+	select DM_SERIAL
 	select ARCH_COLDFIRE
 	select CREATE_ARCH_SYMLINK
 	bool
@@ -191,17 +191,17 @@ config TARGET_AMCORE
 	select M5307

 config TARGET_STMARK2
-        bool "Support stmark2"
-        select CF_DSPI
-        select M54418
+	bool "Support stmark2"
+	select CF_DSPI
+	select M54418

 config TARGET_QEMU_M68K
-    bool "Support QEMU m68k virt"
-    select M68040
-    imply CMD_DM
-    help
-      This target supports the QEMU m68k virtual machine (-M virt).
-      It simulates a Motorola 68040 CPU with Goldfish peripherals.
+	bool "Support QEMU m68k virt"
+	select M68040
+	imply CMD_DM
+	help
+	  This target supports the QEMU m68k virtual machine (-M virt).
+	  It simulates a Motorola 68040 CPU with Goldfish peripherals.

 endchoice

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 36612756294b..75913d4f1aeb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -267,8 +267,8 @@ config CPU_MIPS64_OCTEON
 	select 64BIT
 	select SPL_64BIT if SPL
 	help
-	 Choose this option for Marvell Octeon CPUs.  These CPUs are between
-	 MIPS64 R5 and R6 with other extensions.
+	  Choose this option for Marvell Octeon CPUs.  These CPUs are between
+	  MIPS64 R5 and R6 with other extensions.

 endchoice

@@ -351,7 +351,7 @@ config MIPS_RELOCATION_TABLE_SIZE
 	range 0x100 0x10000
 	default "0xc000" if TARGET_MALTA
 	default "0x8000"
-	---help---
+	help
 	  A table of relocation data will be appended to the U-Boot binary
 	  and parsed in relocate_code() to fix up all offsets in the relocated
 	  U-Boot.
@@ -526,7 +526,7 @@ config MIPS_SRAM_INIT
 config DMA_ADDR_T_64BIT
 	bool
 	help
-	 Select this to enable 64-bit DMA addressing
+	  Select this to enable 64-bit DMA addressing

 config SYS_DCACHE_SIZE
 	int
diff --git a/arch/mips/mach-octeon/Kconfig b/arch/mips/mach-octeon/Kconfig
index 6105cdcf96ea..cd1e377c79de 100644
--- a/arch/mips/mach-octeon/Kconfig
+++ b/arch/mips/mach-octeon/Kconfig
@@ -25,8 +25,8 @@ choice
 config SOC_OCTEON3
 	bool "Octeon III family"
 	help
-	 This selects the Octeon III SoC family CN70xx, CN73XX, CN78xx
-	 and CNF75XX.
+	  This selects the Octeon III SoC family CN70xx, CN73XX, CN78xx
+	  and CNF75XX.

 endchoice

@@ -38,14 +38,14 @@ config TARGET_OCTEON_EBB7304
 	bool "Marvell Octeon EBB7304"
 	select OCTEON_CN73XX
 	help
-	 Choose this for the Octeon EBB7304 board
+	  Choose this for the Octeon EBB7304 board

 config TARGET_OCTEON_NIC23
 	bool "Marvell Octeon NIC23"
 	select ARCH_MISC_INIT
 	select OCTEON_CN73XX
 	help
-	 Choose this for the Octeon NIC23 board
+	  Choose this for the Octeon NIC23 board

 endchoice

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index f0580e3877ad..32a140b09133 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -966,14 +966,14 @@ config E500
 	bool
 	default y
 	help
-		Enable PowerPC E500 cores, including e500v1, e500v2, e500mc
+	  Enable PowerPC E500 cores, including e500v1, e500v2, e500mc

 config E500MC
 	bool
 	select BTB
 	imply CMD_PCI
 	help
-		Enable PowerPC E500MC core
+	  Enable PowerPC E500MC core

 config E5500
 	bool
@@ -982,7 +982,7 @@ config E6500
 	bool
 	select BTB
 	help
-		Enable PowerPC E6500 core
+	  Enable PowerPC E6500 core

 config NOBQFMAN
 	bool
@@ -990,7 +990,7 @@ config NOBQFMAN
 config FSL_LAW
 	bool
 	help
-		Use Freescale common code for Local Access Window
+	  Use Freescale common code for Local Access Window

 config HETROGENOUS_CLUSTERS
 	bool
@@ -1054,10 +1054,10 @@ config SYS_CCSRBAR_DEFAULT
 				ARCH_T4240
 	default 0xe0000000 if ARCH_QEMU_E500
 	help
-		Default value of CCSRBAR comes from power-on-reset. It
-		is fixed on each SoC. Some SoCs can have different value
-		if changed by pre-boot regime. The value here must match
-		the current value in SoC. If not sure, do not change.
+	  Default value of CCSRBAR comes from power-on-reset. It
+	  is fixed on each SoC. Some SoCs can have different value
+	  if changed by pre-boot regime. The value here must match
+	  the current value in SoC. If not sure, do not change.

 config SYS_DPAA_PME
 	bool
@@ -1287,8 +1287,8 @@ config SYS_FSL_NUM_LAWS
 	default 8 if	ARCH_MPC8540	|| \
 			ARCH_MPC8560
 	help
-		Number of local access windows. This is fixed per SoC.
-		If not sure, do not change.
+	  Number of local access windows. This is fixed per SoC.
+	  If not sure, do not change.

 config SYS_FSL_CORES_PER_CLUSTER
 	int
@@ -1308,8 +1308,8 @@ config SYS_NUM_TLBCAMS
 	default 64 if E500MC
 	default 16
 	help
-		Number of TLB CAM entries for Book-E chips. 64 for E500MC,
-		16 for other E500 SoCs.
+	  Number of TLB CAM entries for Book-E chips. 64 for E500MC,
+	  16 for other E500 SoCs.

 config L2_CACHE
 	bool "Enable L2 cache support"
@@ -1401,12 +1401,12 @@ config SYS_PPC_E500_DEBUG_TLB
 			ARCH_BSC9132	|| \
 			ARCH_C29X
 	help
-		Select a temporary TLB entry to be used during boot to work
-                around limitations in e500v1 and e500v2 external debugger
-                support. This reduces the portions of the boot code where
-                breakpoints and single stepping do not work. The value of this
-                symbol should be set to the TLB1 entry to be used for this
-                purpose. If unsure, do not change.
+	  Select a temporary TLB entry to be used during boot to work
+	  around limitations in e500v1 and e500v2 external debugger
+	  support. This reduces the portions of the boot code where
+	  breakpoints and single stepping do not work. The value of this
+	  symbol should be set to the TLB1 entry to be used for this
+	  purpose. If unsure, do not change.

 config SYS_FSL_IFC_CLK_DIV
 	int "Divider of platform clock"
@@ -1419,8 +1419,8 @@ config SYS_FSL_IFC_CLK_DIV
 			ARCH_T4240
 	default 1
 	help
-		Defines divider of platform clock(clock input to
-		IFC controller).
+	  Defines divider of platform clock(clock input to
+	  IFC controller).

 config SYS_FSL_LBC_CLK_DIV
 	int "Divider of platform clock"
@@ -1435,8 +1435,8 @@ config SYS_FSL_LBC_CLK_DIV
 	default 1

 	help
-		Defines divider of platform clock(clock input to
-		eLBC controller).
+	  Defines divider of platform clock(clock input to
+	  eLBC controller).

 config ENABLE_36BIT_PHYS
 	bool "Enable 36bit physical address space support"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8f21b78dbe45..ec4d484a6691 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -44,9 +44,9 @@ config X86_RUN_64BIT_NO_SPL
 	bool "64-bit"
 	select X86_64
 	help
-          Build U-Boot as a 64-bit binary without SPL. As U-Boot enters
-          in 64-bit mode, the assumption is that the silicon is fully
-          initialized (MP, page tables, etc.).
+	  Build U-Boot as a 64-bit binary without SPL. As U-Boot enters
+	  in 64-bit mode, the assumption is that the silicon is fully
+	  initialized (MP, page tables, etc.).

 endchoice

@@ -585,11 +585,11 @@ config DCACHE_RAM_MRC_VAR_SIZE
 	  not boot.

 config HAVE_REFCODE
-        bool "Add a Reference Code binary"
-        help
-          Select this option to add a Reference Code binary to the resulting
-          U-Boot image. This is an Intel binary blob that handles system
-          initialisation, in this case the PCH and System Agent.
+	bool "Add a Reference Code binary"
+	help
+	  Select this option to add a Reference Code binary to the resulting
+	  U-Boot image. This is an Intel binary blob that handles system
+	  initialisation, in this case the PCH and System Agent.

           Note: Without this binary (on platforms that need it such as
           broadwell) U-Boot will be missing some critical setup steps.
@@ -617,8 +617,8 @@ config SMP_AP_WORK
 	bool
 	depends on SMP
 	help
-	 Allow APs to do other work after initialisation instead of going
-	 to sleep.
+	  Allow APs to do other work after initialisation instead of going
+	  to sleep.

 config MAX_CPUS
 	int "Maximum number of CPUs permitted"
--
2.39.5

