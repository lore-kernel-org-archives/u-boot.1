Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4101C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D1688937;
	Sat, 13 Jul 2024 15:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Zf7YudUN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dw0mRd3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269CC88933; Sat, 13 Jul 2024 15:21:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62EE88901
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyq4fX7z9scm;
 Sat, 13 Jul 2024 15:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGPbHnEtw1EVzEi4P3EKOOB+tE/DyPaaYeME34RLTHA=;
 b=Zf7YudUNdv4Y0eMjg5We3UwMP1hxWRSrKIUdUsmGskZanRXuffHnN0zuG8llX4rIzHd5yn
 krLqEUcnI8Qhxu6vJyO0k31xl9SEMrApB+B5GdJybfrM6DSDZGtojLR1QYE0Rpv02neNdD
 7Q5UPi6lsquHXZFoh8jH5FQXq6DJN8BfHcbwMhfUaE/7S63PrQkDVSwoFdbb97eVoMfwLr
 G6KfZyxLnZKPnr4EtzLphfUi2cZKdU/3KFbcuL+kSgQaLdas9Y+PG2GSdkKny9IBQraIZP
 dp9Yzc7B8ElpcaVrpgtqYmZy7d2n2DsmlIJL/wrKWsgaGcHAsFzGnDO+L2/Upg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGPbHnEtw1EVzEi4P3EKOOB+tE/DyPaaYeME34RLTHA=;
 b=Dw0mRd3ksRTLmcEH9wfHx4TglgXxMKA/FLn5+7YvbAKZGfpnp+4I1vwGUnsawOUNie0oq/
 v+ofAzjJLq2dSW/Wd+rdf0W4jAaQsw7QsWSCLGvtYAjWbHAEMADY06TFCnmhtiTRUPvM8i
 idsvOtCMbYbMekaEs7wO5jyE5WkOE59TsNJunTT5bwEaVtRUcff2D7HW6i7XaayWJgeMeH
 soyO96a621noQaEN14vwc3kTZ4n7qXngmR996IzHZzMy0tBIhEY9HNi54XVOMolC6scou1
 aGc9i2mj376P1mJ81uDcmjKQDg8c5FfLo2zU0YlA1Ju9opaIRMRb+hUQ0EiFbw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 45/45] xtensa: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:36 +0200
Message-ID: <20240713132021.57650-45-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dd278d0b166ec8fdc5d
X-MBO-RS-META: i1akf94c5hyak6riitzkqb6pei64s7hr
X-Rspamd-Queue-Id: 4WLpyq4fX7z9scm
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
 arch/xtensa/include/asm/arch-dc232b/core.h    | 13 -------------
 arch/xtensa/include/asm/arch-dc232b/tie-asm.h |  1 -
 arch/xtensa/include/asm/arch-dc233c/core.h    | 12 ------------
 arch/xtensa/include/asm/arch-dc233c/tie-asm.h |  1 -
 arch/xtensa/include/asm/arch-de212/core.h     | 13 -------------
 arch/xtensa/include/asm/arch-de212/tie-asm.h  |  2 --
 arch/xtensa/include/asm/asmmacro.h            | 11 -----------
 arch/xtensa/include/asm/cacheasm.h            | 16 ----------------
 arch/xtensa/include/asm/io.h                  |  1 -
 arch/xtensa/include/asm/processor.h           |  1 -
 arch/xtensa/include/asm/types.h               |  1 -
 arch/xtensa/lib/time.c                        |  2 --
 12 files changed, 74 deletions(-)

diff --git a/arch/xtensa/include/asm/arch-dc232b/core.h b/arch/xtensa/include/asm/arch-dc232b/core.h
index c1453f719e4..9ab7f464236 100644
--- a/arch/xtensa/include/asm/arch-dc232b/core.h
+++ b/arch/xtensa/include/asm/arch-dc232b/core.h
@@ -9,7 +9,6 @@
 #ifndef _XTENSA_CORE_CONFIGURATION_H
 #define _XTENSA_CORE_CONFIGURATION_H
 
-
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
  ****************************************************************************/
@@ -19,7 +18,6 @@
  *  configured, and a value of 0 otherwise.  These macros are always defined.
  */
 
-
 /*----------------------------------------------------------------------
 				ISA
   ----------------------------------------------------------------------*/
@@ -69,7 +67,6 @@
 #define XCHAL_HAVE_VECTRALX		0	/* Vectra LX pkg */
 #define XCHAL_HAVE_HIFI2		0	/* HiFi2 Audio Engine pkg */
 
-
 /*----------------------------------------------------------------------
 				MISC
   ----------------------------------------------------------------------*/
@@ -111,7 +108,6 @@
 #define XCHAL_HW_MAX_VERSION_MINOR	1	/* minor v of latest tgt hw */
 #define XCHAL_HW_MAX_VERSION		221001	/* latest targeted hw */
 
-
 /*----------------------------------------------------------------------
 				CACHE
   ----------------------------------------------------------------------*/
@@ -126,12 +122,10 @@
 
 #define XCHAL_DCACHE_IS_WRITEBACK	1	/* writeback feature */
 
-
 /****************************************************************************
     Parameters Useful for PRIVILEGED (Supervisory or Non-Virtualized) Code
  ****************************************************************************/
 
-
 #ifndef XTENSA_HAL_NON_PRIVILEGED_ONLY
 
 /*----------------------------------------------------------------------
@@ -159,7 +153,6 @@
 /*  Number of encoded cache attr bits (see <xtensa/hal.h> for decoded bits):  */
 #define XCHAL_CA_BITS			4
 
-
 /*----------------------------------------------------------------------
 			INTERNAL I/D RAM/ROMs and XLMI
   ----------------------------------------------------------------------*/
@@ -171,7 +164,6 @@
 #define XCHAL_NUM_URAM			0	/* number of core unified RAMs*/
 #define XCHAL_NUM_XLMI			0	/* number of core XLMI ports */
 
-
 /*----------------------------------------------------------------------
 			INTERRUPTS and TIMERS
   ----------------------------------------------------------------------*/
@@ -282,7 +274,6 @@
 #define XCHAL_INTLEVEL7_NUM		14
 /*  (There are many interrupts each at level(s) 1, 3.)  */
 
-
 /*
  *  External interrupt vectors/levels.
  *  These macros describe how Xtensa processor interrupt numbers
@@ -311,7 +302,6 @@
 #define XCHAL_EXTINT15_NUM		20	/* (intlevel 1) */
 #define XCHAL_EXTINT16_NUM		21	/* (intlevel 3) */
 
-
 /*----------------------------------------------------------------------
 			EXCEPTIONS and VECTORS
   ----------------------------------------------------------------------*/
@@ -379,7 +369,6 @@
 #define XCHAL_INTLEVEL7_VECTOR_VADDR	XCHAL_NMI_VECTOR_VADDR
 #define XCHAL_INTLEVEL7_VECTOR_PADDR	XCHAL_NMI_VECTOR_PADDR
 
-
 /*----------------------------------------------------------------------
 				DEBUG
   ----------------------------------------------------------------------*/
@@ -389,7 +378,6 @@
 #define XCHAL_NUM_DBREAK		2	/* number of DBREAKn regs */
 #define XCHAL_HAVE_OCD_DIR_ARRAY	1	/* faster OCD option */
 
-
 /*----------------------------------------------------------------------
 				MMU
   ----------------------------------------------------------------------*/
@@ -415,5 +403,4 @@
 
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
-
 #endif /* _XTENSA_CORE_CONFIGURATION_H */
diff --git a/arch/xtensa/include/asm/arch-dc232b/tie-asm.h b/arch/xtensa/include/asm/arch-dc232b/tie-asm.h
index 35a26dca7cc..9c6b1eeacd0 100644
--- a/arch/xtensa/include/asm/arch-dc232b/tie-asm.h
+++ b/arch/xtensa/include/asm/arch-dc232b/tie-asm.h
@@ -25,7 +25,6 @@
 /*  Misc  */
 #define XTHAL_SAS_ALL	0xFFFF	/* include all default NCP contents */
 
-
 /* Macro to save all non-coprocessor (extra) custom TIE and optional state
  * (not including zero-overhead loop registers).
  * Save area ptr (clobbered):  ptr  (1 byte aligned)
diff --git a/arch/xtensa/include/asm/arch-dc233c/core.h b/arch/xtensa/include/asm/arch-dc233c/core.h
index cd3c8c115f5..3cd11981d01 100644
--- a/arch/xtensa/include/asm/arch-dc233c/core.h
+++ b/arch/xtensa/include/asm/arch-dc233c/core.h
@@ -9,7 +9,6 @@
 #ifndef _XTENSA_CORE_CONFIGURATION_H
 #define _XTENSA_CORE_CONFIGURATION_H
 
-
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
  ****************************************************************************/
@@ -19,7 +18,6 @@
  *  configured, and a value of 0 otherwise.  These macros are always defined.
  */
 
-
 /*----------------------------------------------------------------------
 				ISA
   ----------------------------------------------------------------------*/
@@ -86,7 +84,6 @@
 #define XCHAL_HAVE_TURBO16		0	/* ConnX Turbo16 pkg */
 #define XCHAL_HAVE_BBP16		0	/* ConnX BBP16 pkg */
 
-
 /*----------------------------------------------------------------------
 				MISC
   ----------------------------------------------------------------------*/
@@ -130,7 +127,6 @@
 #define XCHAL_HW_MAX_VERSION_MINOR	1	/* minor v of latest tgt hw */
 #define XCHAL_HW_MAX_VERSION		240001	/* latest targeted hw */
 
-
 /*----------------------------------------------------------------------
 				CACHE
   ----------------------------------------------------------------------*/
@@ -148,7 +144,6 @@
 
 #define XCHAL_HAVE_PREFETCH		0	/* PREFCTL register */
 
-
 /****************************************************************************
     Parameters Useful for PRIVILEGED (Supervisory or Non-Virtualized) Code
  ****************************************************************************/
@@ -184,7 +179,6 @@
 /*  Number of encoded cache attr bits (see <xtensa/hal.h> for decoded bits):  */
 #define XCHAL_CA_BITS			4
 
-
 /*----------------------------------------------------------------------
 			INTERNAL I/D RAM/ROMs and XLMI
   ----------------------------------------------------------------------*/
@@ -198,7 +192,6 @@
 
 #define XCHAL_HAVE_IMEM_LOADSTORE	1	/* can load/store to IROM/IRAM*/
 
-
 /*----------------------------------------------------------------------
 			INTERRUPTS and TIMERS
   ----------------------------------------------------------------------*/
@@ -309,7 +302,6 @@
 #define XCHAL_INTLEVEL7_NUM		14
 /*  (There are many interrupts each at level(s) 1, 3.)  */
 
-
 /*
  *  External interrupt vectors/levels.
  *  These macros describe how Xtensa processor interrupt numbers
@@ -338,7 +330,6 @@
 #define XCHAL_EXTINT15_NUM		20	/* (intlevel 1) */
 #define XCHAL_EXTINT16_NUM		21	/* (intlevel 3) */
 
-
 /*----------------------------------------------------------------------
 			EXCEPTIONS and VECTORS
   ----------------------------------------------------------------------*/
@@ -408,7 +399,6 @@
 #define XCHAL_INTLEVEL7_VECTOR_VADDR	XCHAL_NMI_VECTOR_VADDR
 #define XCHAL_INTLEVEL7_VECTOR_PADDR	XCHAL_NMI_VECTOR_PADDR
 
-
 /*----------------------------------------------------------------------
 				DEBUG
   ----------------------------------------------------------------------*/
@@ -418,7 +408,6 @@
 #define XCHAL_NUM_DBREAK		2	/* number of DBREAKn regs */
 #define XCHAL_HAVE_OCD_DIR_ARRAY	1	/* faster OCD option */
 
-
 /*----------------------------------------------------------------------
 				MMU
   ----------------------------------------------------------------------*/
@@ -445,5 +434,4 @@
 
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
-
 #endif /* _XTENSA_CORE_CONFIGURATION_H */
diff --git a/arch/xtensa/include/asm/arch-dc233c/tie-asm.h b/arch/xtensa/include/asm/arch-dc233c/tie-asm.h
index 7b3d1f3c572..ee1b1986415 100644
--- a/arch/xtensa/include/asm/arch-dc233c/tie-asm.h
+++ b/arch/xtensa/include/asm/arch-dc233c/tie-asm.h
@@ -159,7 +159,6 @@
 	.endif
     .endm	// xchal_ncp_load
 
-
 #define XCHAL_NCP_NUM_ATMPS	1
 
 #define XCHAL_SA_NUM_ATMPS	1
diff --git a/arch/xtensa/include/asm/arch-de212/core.h b/arch/xtensa/include/asm/arch-de212/core.h
index 60c6efba7d2..c2609f46a02 100644
--- a/arch/xtensa/include/asm/arch-de212/core.h
+++ b/arch/xtensa/include/asm/arch-de212/core.h
@@ -9,7 +9,6 @@
 #ifndef _XTENSA_CORE_CONFIGURATION_H
 #define _XTENSA_CORE_CONFIGURATION_H
 
-
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
  ****************************************************************************/
@@ -19,7 +18,6 @@
  *  configured, and a value of 0 otherwise.  These macros are always defined.
  */
 
-
 /*----------------------------------------------------------------------
 				ISA
   ----------------------------------------------------------------------*/
@@ -91,7 +89,6 @@
 #define XCHAL_HAVE_HIFI2EP		0	/* HiFi2EP */
 #define XCHAL_HAVE_HIFI_MINI		0
 
-
 #define XCHAL_HAVE_VECTORFPU2005	0	/* vector or user floating-point pkg */
 #define XCHAL_HAVE_USER_DPFPU         0       /* user DP floating-point pkg */
 #define XCHAL_HAVE_USER_SPFPU         0       /* user DP floating-point pkg */
@@ -130,7 +127,6 @@
 #define XCHAL_HAVE_GRIVPEP              0	/*  GRIVPEP is General Release of IVPEP */
 #define XCHAL_HAVE_GRIVPEP_HISTOGRAM    0	/* Histogram option on GRIVPEP */
 
-
 /*----------------------------------------------------------------------
 				MISC
   ----------------------------------------------------------------------*/
@@ -178,7 +174,6 @@
 #define XCHAL_HW_MAX_VERSION_MINOR	2	/* minor v of latest tgt hw */
 #define XCHAL_HW_MAX_VERSION		260002	/* latest targeted hw */
 
-
 /*----------------------------------------------------------------------
 				CACHE
   ----------------------------------------------------------------------*/
@@ -205,7 +200,6 @@
 #define XCHAL_HAVE_ICACHE_DYN_WAYS	0	/* Icache dynamic way support */
 #define XCHAL_HAVE_DCACHE_DYN_WAYS	0	/* Dcache dynamic way support */
 
-
 /****************************************************************************
     Parameters Useful for PRIVILEGED (Supervisory or Non-Virtualized) Code
  ****************************************************************************/
@@ -250,7 +244,6 @@
 					   XCHAL_HAVE_DCACHE_DYN_WAYS)	&&	\
 					   (XCHAL_HW_MIN_VERSION >= XTENSA_HWVERSION_RE_2012_0))
 
-
 /*----------------------------------------------------------------------
 			INTERNAL I/D RAM/ROMs and XLMI
   ----------------------------------------------------------------------*/
@@ -283,7 +276,6 @@
 
 #define XCHAL_HAVE_IMEM_LOADSTORE	1	/* can load/store to IROM/IRAM*/
 
-
 /*----------------------------------------------------------------------
 			INTERRUPTS and TIMERS
   ----------------------------------------------------------------------*/
@@ -395,7 +387,6 @@
 #define XCHAL_INTLEVEL7_NUM		14
 /*  (There are many interrupts each at level(s) 1, 3.)  */
 
-
 /*
  *  External interrupt mapping.
  *  These macros describe how Xtensa processor interrupt numbers
@@ -442,7 +433,6 @@
 #define XCHAL_INT20_EXTNUM		15	/* (intlevel 1) */
 #define XCHAL_INT21_EXTNUM		16	/* (intlevel 3) */
 
-
 /*----------------------------------------------------------------------
 			EXCEPTIONS and VECTORS
   ----------------------------------------------------------------------*/
@@ -512,7 +502,6 @@
 #define XCHAL_INTLEVEL7_VECTOR_VADDR	XCHAL_NMI_VECTOR_VADDR
 #define XCHAL_INTLEVEL7_VECTOR_PADDR	XCHAL_NMI_VECTOR_PADDR
 
-
 /*----------------------------------------------------------------------
 				DEBUG MODULE
   ----------------------------------------------------------------------*/
@@ -539,7 +528,6 @@
 /*  Perf counters  */
 #define XCHAL_NUM_PERF_COUNTERS		0	/* performance counters */
 
-
 /*----------------------------------------------------------------------
 				MMU
   ----------------------------------------------------------------------*/
@@ -564,5 +552,4 @@
 
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
-
 #endif /* _XTENSA_CORE_CONFIGURATION_H */
diff --git a/arch/xtensa/include/asm/arch-de212/tie-asm.h b/arch/xtensa/include/asm/arch-de212/tie-asm.h
index 3192ac82ad2..5156aae71e3 100644
--- a/arch/xtensa/include/asm/arch-de212/tie-asm.h
+++ b/arch/xtensa/include/asm/arch-de212/tie-asm.h
@@ -31,7 +31,6 @@
 					| ((ccuse) & XTHAL_SAS_ANYCC)  \
 					| ((abi)   & XTHAL_SAS_ANYABI) )
 
-
     /*
       *  Macro to store all non-coprocessor (extra) custom TIE and optional state
       *  (not including zero-overhead loop registers).
@@ -140,7 +139,6 @@
 	.endif
     .endm	// xchal_ncp_load
 
-
 #define XCHAL_NCP_NUM_ATMPS	1
 
 #define XCHAL_SA_NUM_ATMPS	1
diff --git a/arch/xtensa/include/asm/asmmacro.h b/arch/xtensa/include/asm/asmmacro.h
index 78613fc5797..8267f05f52a 100644
--- a/arch/xtensa/include/asm/asmmacro.h
+++ b/arch/xtensa/include/asm/asmmacro.h
@@ -59,7 +59,6 @@
 	loop	\at, 99f
 .endm
 
-
 .macro	__loops	ar, as, at, incr_log2, mask_log2, cond, ncond
 	.ifgt \incr_log2 - 1
 		addi	\at, \as, (1 << \incr_log2) - 1
@@ -72,7 +71,6 @@
 	loop\cond	\at, 99f
 .endm
 
-
 .macro	__loopt	ar, as, at, incr_log2
 	sub	\at, \as, \ar
 	.ifgt	\incr_log2 - 1
@@ -82,17 +80,14 @@
 	loop	\at, 99f
 .endm
 
-
 .macro	__loop	as
 	loop	\as, 99f
 .endm
 
-
 .macro	__endl	ar, as
 99:
 .endm
 
-
 #else
 
 .macro	__loopi ar, at, size, incr
@@ -101,7 +96,6 @@
 98:
 .endm
 
-
 .macro	__loops	ar, as, at, incr_log2, mask_log2, cond, ncond
 	.ifnc \mask_log2,
 		extui	\at, \as, \incr_log2, \mask_log2
@@ -127,25 +121,20 @@
 98:
 .endm
 
-
 .macro	__loop	as
 98:
 .endm
 
-
 .macro	__endl	ar, as
 	bltu	\ar, \as, 98b
 99:
 .endm
 
-
 #endif
 
-
 .macro	__endla	ar, as, incr
 	addi	\ar, \ar, \incr
 	__endl	\ar \as
 .endm
 
-
 #endif /* _XTENSA_ASMMACRO_H */
diff --git a/arch/xtensa/include/asm/cacheasm.h b/arch/xtensa/include/asm/cacheasm.h
index 69448cfff78..c53e653dfda 100644
--- a/arch/xtensa/include/asm/cacheasm.h
+++ b/arch/xtensa/include/asm/cacheasm.h
@@ -51,7 +51,6 @@
 
 	.endm
 
-
 	.macro	__loop_cache_range ar as at insn line_width
 
 	extui	\at, \ar, 0, \line_width
@@ -63,7 +62,6 @@
 
 	.endm
 
-
 	.macro	__loop_cache_page ar at insn line_width
 
 	__loopi	\ar, \at, PAGE_SIZE, 4 << (\line_width)
@@ -77,7 +75,6 @@
 
 	.endm
 
-
 	.macro	___unlock_dcache_all ar at
 
 #if XCHAL_DCACHE_LINE_LOCKABLE && XCHAL_DCACHE_SIZE
@@ -86,7 +83,6 @@
 
 	.endm
 
-
 	.macro	___unlock_icache_all ar at
 
 #if XCHAL_ICACHE_LINE_LOCKABLE && XCHAL_ICACHE_SIZE
@@ -95,7 +91,6 @@
 
 	.endm
 
-
 	.macro	___flush_invalidate_dcache_all ar at
 
 #if XCHAL_DCACHE_SIZE
@@ -104,7 +99,6 @@
 
 	.endm
 
-
 	.macro	___flush_dcache_all ar at
 
 #if XCHAL_DCACHE_SIZE
@@ -113,7 +107,6 @@
 
 	.endm
 
-
 	.macro	___invalidate_dcache_all ar at
 
 #if XCHAL_DCACHE_SIZE
@@ -123,7 +116,6 @@
 
 	.endm
 
-
 	.macro	___invalidate_icache_all ar at
 
 #if XCHAL_ICACHE_SIZE
@@ -133,7 +125,6 @@
 
 	.endm
 
-
 	.macro	___flush_invalidate_dcache_range ar as at
 
 #if XCHAL_DCACHE_SIZE
@@ -142,7 +133,6 @@
 
 	.endm
 
-
 	.macro	___flush_dcache_range ar as at
 
 #if XCHAL_DCACHE_SIZE
@@ -151,7 +141,6 @@
 
 	.endm
 
-
 	.macro	___invalidate_dcache_range ar as at
 
 #if XCHAL_DCACHE_SIZE
@@ -160,7 +149,6 @@
 
 	.endm
 
-
 	.macro	___invalidate_icache_range ar as at
 
 #if XCHAL_ICACHE_SIZE
@@ -169,7 +157,6 @@
 
 	.endm
 
-
 	.macro	___flush_invalidate_dcache_page ar as
 
 #if XCHAL_DCACHE_SIZE
@@ -178,7 +165,6 @@
 
 	.endm
 
-
 	.macro ___flush_dcache_page ar as
 
 #if XCHAL_DCACHE_SIZE
@@ -187,7 +173,6 @@
 
 	.endm
 
-
 	.macro	___invalidate_dcache_page ar as
 
 #if XCHAL_DCACHE_SIZE
@@ -196,7 +181,6 @@
 
 	.endm
 
-
 	.macro	___invalidate_icache_page ar as
 
 #if XCHAL_ICACHE_SIZE
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index ab2438b829a..6ca1dea68f7 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -111,7 +111,6 @@ void outsl(unsigned long port, const void *src, unsigned long count);
 # error processor byte order undefined!
 #endif
 
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem access
  */
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 22203c96497..066188fbde5 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -6,5 +6,4 @@
 #ifndef _XTENSA_PROCESSOR_H
 #define _XTENSA_PROCESSOR_H
 
-
 #endif /* _XTENSA_PROCESSOR_H */
diff --git a/arch/xtensa/include/asm/types.h b/arch/xtensa/include/asm/types.h
index 2c5b5433cc4..56594912229 100644
--- a/arch/xtensa/include/asm/types.h
+++ b/arch/xtensa/include/asm/types.h
@@ -24,7 +24,6 @@ typedef u32 dma_addr_t;
 typedef unsigned long phys_addr_t;
 typedef unsigned long phys_size_t;
 
-
 #endif /* __KERNEL__ */
 
 #endif /* _XTENSA_TYPES_H */
diff --git a/arch/xtensa/lib/time.c b/arch/xtensa/lib/time.c
index c6739584bbf..319635c6b09 100644
--- a/arch/xtensa/lib/time.c
+++ b/arch/xtensa/lib/time.c
@@ -62,7 +62,6 @@ void __udelay(unsigned long usec)
 	delay_cycles(mhz * lo);
 }
 
-
 /*
  * Return the elapsed time (ticks) since 'base'.
  */
@@ -89,7 +88,6 @@ ulong get_timer(ulong base)
 #endif
 }
 
-
 /*
  * This function is derived from ARM/PowerPC code (read timebase as long long).
  * On Xtensa it just returns the timer value.
-- 
2.43.0

