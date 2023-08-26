Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90DBC83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 22:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08F9831BE;
	Sun, 27 Aug 2023 00:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UuBzz2ux";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YeNQ1r7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E3784003; Sun, 27 Aug 2023 00:26:13 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0556A82BBF
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 00:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RYBHQ4nBKz9t0S;
 Sun, 27 Aug 2023 00:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyQASTRb76EavkNdW4yWNyjdPZnxdE6HNa/HniRinCY=;
 b=UuBzz2uxB+cs92vp7p3v2CO25aPrg6lWxjcJwKIjQiPh72EG38OUX53amhwPGrrNO1j4v1
 btznwLQ/6x/Hd3AOSKTYCDeXI7x8hSAdxPZB7tDB/LU2GCBZQsJPfqU924n1yI2YZZ1Phx
 0cZSDcXHt/yKRWHgWUIXnm/k8NXqdXYBGzrpXMqtdTStVXN0zaKmlITHqsLTTyzSQy/QxR
 UWRv1yI12zZjVNBdGWitUT+EiDJxwhVL5RfuHQg+vwZZsLLriczBQ3ngCK32xCPqYfbWV3
 /kzenjSOTml6l1Ua//ZdIUhGa7Yoy2tJ0yLvUpXe3ivWr+zGl2nK11qXFWfk/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyQASTRb76EavkNdW4yWNyjdPZnxdE6HNa/HniRinCY=;
 b=YeNQ1r7bb7bTmdTMrzwOFRKwV7f4SawG/QkD6STIHkJuOAe++UCr6G2QHcB7bqjU6W8iCj
 Wd4mlPmcYjGFifZeN1UgQyFKv8muw84pwIZLDAfw4JQ/fVLae+cV6zp42zGyd+CQziNCCC
 Y5Q2aSSKLLoZtyPdP7tIwR/7ni/QuyigIX4A3dldpUMS9sVMxNVZI7jD+M1H/dsepi/knY
 gyU9IzzmGNycKQn9xs2LskYqgoNL8VX2MOTznERIkj0bnbs7nh1QyeaIdpV7IogWwi2wfW
 jc9JPgALrS2JW7WllcXQn13JmS91+ad/TZTxB6mHhS9xRB/tcJhK2qu09Dv53Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Durgehello <angelo.dureghello@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/2] arch: m68k: Implement relocation
Date: Sun, 27 Aug 2023 00:25:36 +0200
Message-Id: <20230826222536.26689-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230826222536.26689-1-marek.vasut+renesas@mailbox.org>
References: <20230826222536.26689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t58pfayynqz5caspzzf7qgdaysqnr63i
X-MBO-RS-ID: d7742bbead9f284b19e
X-Rspamd-Queue-Id: 4RYBHQ4nBKz9t0S
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

Implement relocation for M68K. Perform all the updates in start.S
relocate_code in assemby, since it is a simple matter of traversing
the dynsym table and adding relocation offset - MONITOR_BASE to all
the items in that table. The necessity to deal with MONITOR_BASE is
a specific of M68K, where the ELF entry point is at offset 0x400,
which is the MONITOR_BASE, while TEXT_BASE is at offset 0 .

This also removes the one last user of NEEDS_MANUAL_RELOC, so that
could be finally cleaned up .

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Angelo Durgehello <angelo.dureghello@timesys.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Zong Li <zong.li@sifive.com>
---
V2: Add RB from Simon
---
 arch/Kconfig                   |  1 -
 arch/m68k/Kconfig              |  4 +--
 arch/m68k/config.mk            |  6 ++--
 arch/m68k/cpu/mcf523x/start.S  | 57 ++++++++++++++++++++------------
 arch/m68k/cpu/mcf52x2/start.S  | 57 ++++++++++++++++++++------------
 arch/m68k/cpu/mcf530x/start.S  | 59 +++++++++++++++++++++-------------
 arch/m68k/cpu/mcf532x/start.S  | 57 ++++++++++++++++++++------------
 arch/m68k/cpu/mcf5445x/start.S | 57 ++++++++++++++++++++------------
 arch/m68k/cpu/u-boot.lds       | 14 ++++++++
 9 files changed, 204 insertions(+), 108 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c9a33592252..2e2cbdf37aa 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -68,7 +68,6 @@ config M68K
 	bool "M68000 architecture"
 	select HAVE_PRIVATE_LIBGCC
 	select USE_PRIVATE_LIBGCC
-	select NEEDS_MANUAL_RELOC
 	select SYS_BOOT_GET_CMDLINE
 	select SYS_BOOT_GET_KBD
 	select SYS_CACHE_SHIFT_4
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 1911563e540..587edd50d7e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,8 +4,8 @@ menu "M68000 architecture"
 config SYS_ARCH
 	default "m68k"
 
-config NEEDS_MANUAL_RELOC
-	def_bool y
+config STATIC_RELA
+	default y
 
 # processor family
 config MCF520x
diff --git a/arch/m68k/config.mk b/arch/m68k/config.mk
index 3ccbe492202..643b7d1d35d 100644
--- a/arch/m68k/config.mk
+++ b/arch/m68k/config.mk
@@ -3,8 +3,8 @@
 # (C) Copyright 2000-2002
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-PLATFORM_CPPFLAGS += -D__M68K__
-KBUILD_LDFLAGS  += -n
+PLATFORM_CPPFLAGS += -D__M68K__ -fPIC
+KBUILD_LDFLAGS    += -n -pie
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
 PLATFORM_RELFLAGS += -ffixed-d7 -msep-data
-LDFLAGS_FINAL                  += --gc-sections
+LDFLAGS_FINAL     += --gc-sections -pie
diff --git a/arch/m68k/cpu/mcf523x/start.S b/arch/m68k/cpu/mcf523x/start.S
index d2a21c3279b..c609e82163c 100644
--- a/arch/m68k/cpu/mcf523x/start.S
+++ b/arch/m68k/cpu/mcf523x/start.S
@@ -177,6 +177,39 @@ relocate_code:
 	cmp.l	%a1,%a2
 	bgt.s	1b
 
+#define R_68K_32	1
+#define R_68K_RELATIVE	22
+
+	move.l #(__rel_dyn_start), %a1
+	move.l #(__rel_dyn_end), %a2
+
+fixloop:
+	move.l	(%a1)+, %d1	/* Elf32_Rela r_offset */
+	move.l	(%a1)+, %d2	/* Elf32_Rela r_info */
+	move.l	(%a1)+, %d3	/* Elf32_Rela r_addend */
+
+	andi.l	#0xff, %d2
+	cmp.l	#R_68K_32, %d2
+	beq.s	fixup
+	cmp.l	#R_68K_RELATIVE, %d2
+	beq.s	fixup
+
+	bra	fixnext
+
+fixup:
+	/* relative fix: store addend plus offset at dest location */
+	move.l	%a0, %a3
+	add.l	%d1, %a3
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %a3
+	move.l	(%a3), %d4
+	add.l	%a0, %d4
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %d4
+	move.l	%d4, (%a3)
+
+fixnext:
+	cmp.l	%a1, %a2
+	bge.s	fixloop
+
 /*
  * We are done. Do not return, instead branch to second part of board
  * initialization, now running from RAM.
@@ -191,10 +224,8 @@ clear_bss:
 	/*
 	 * Now clear BSS segment
 	 */
-	move.l	%a0, %a1
-	add.l	#(_sbss - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a0, %d1
-	add.l	#(_ebss - CONFIG_SYS_MONITOR_BASE),%d1
+	move.l	#(_sbss), %a1
+	move.l	#(_ebss), %d1
 6:
 	clr.l	(%a1)+
 	cmp.l	%a1,%d1
@@ -203,24 +234,10 @@ clear_bss:
 	/*
 	 * fix got table in RAM
 	 */
-	move.l	%a0, %a1
-	add.l	#(__got_start - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a1,%a5		/* * fix got pointer register a5 */
-
-	move.l	%a0, %a2
-	add.l	#(__got_end - CONFIG_SYS_MONITOR_BASE),%a2
-
-7:
-	move.l	(%a1),%d1
-	sub.l	#_start,%d1
-	add.l	%a0,%d1
-	move.l	%d1,(%a1)+
-	cmp.l	%a2, %a1
-	bne	7b
+	move.l	#(__got_start), %a5	/* fix got pointer register a5 */
 
 	/* calculate relative jump to board_init_r in ram */
-	move.l	%a0, %a1
-	add.l	#(board_init_r - CONFIG_SYS_MONITOR_BASE), %a1
+	move.l	#(board_init_r), %a1
 
 	/* set parameters for board_init_r */
 	move.l	%a0,-(%sp)		/* dest_addr */
diff --git a/arch/m68k/cpu/mcf52x2/start.S b/arch/m68k/cpu/mcf52x2/start.S
index 51d2e23df10..3a2760236ce 100644
--- a/arch/m68k/cpu/mcf52x2/start.S
+++ b/arch/m68k/cpu/mcf52x2/start.S
@@ -255,6 +255,39 @@ relocate_code:
 	cmp.l	%a1,%a2
 	bgt.s	1b
 
+#define R_68K_32	1
+#define R_68K_RELATIVE	22
+
+	move.l #(__rel_dyn_start), %a1
+	move.l #(__rel_dyn_end), %a2
+
+fixloop:
+	move.l	(%a1)+, %d1	/* Elf32_Rela r_offset */
+	move.l	(%a1)+, %d2	/* Elf32_Rela r_info */
+	move.l	(%a1)+, %d3	/* Elf32_Rela r_addend */
+
+	andi.l	#0xff, %d2
+	cmp.l	#R_68K_32, %d2
+	beq.s	fixup
+	cmp.l	#R_68K_RELATIVE, %d2
+	beq.s	fixup
+
+	bra	fixnext
+
+fixup:
+	/* relative fix: store addend plus offset at dest location */
+	move.l	%a0, %a3
+	add.l	%d1, %a3
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %a3
+	move.l	(%a3), %d4
+	add.l	%a0, %d4
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %d4
+	move.l	%d4, (%a3)
+
+fixnext:
+	cmp.l	%a1, %a2
+	bge.s	fixloop
+
 /*
  * We are done. Do not return, instead branch to second part of board
  * initialization, now running from RAM.
@@ -269,10 +302,8 @@ clear_bss:
 	/*
 	 * Now clear BSS segment
 	 */
-	move.l	%a0, %a1
-	add.l	#(_sbss - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a0, %d1
-	add.l	#(_ebss - CONFIG_SYS_MONITOR_BASE),%d1
+	move.l	#(_sbss), %a1
+	move.l	#(_ebss), %d1
 6:
 	clr.l	(%a1)+
 	cmp.l	%a1,%d1
@@ -281,24 +312,10 @@ clear_bss:
 	/*
 	 * fix got table in RAM
 	 */
-	move.l	%a0, %a1
-	add.l	#(__got_start - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a1,%a5			/* fix got pointer register a5 */
-
-	move.l	%a0, %a2
-	add.l	#(__got_end - CONFIG_SYS_MONITOR_BASE),%a2
-
-7:
-	move.l	(%a1),%d1
-	sub.l	#_start,%d1
-	add.l	%a0,%d1
-	move.l	%d1,(%a1)+
-	cmp.l	%a2, %a1
-	bne	7b
+	move.l	#(__got_start), %a5	/* fix got pointer register a5 */
 
 	/* calculate relative jump to board_init_r in ram */
-	move.l	%a0, %a1
-	add.l	#(board_init_r - CONFIG_SYS_MONITOR_BASE), %a1
+	move.l	#(board_init_r), %a1
 
 	/* set parameters for board_init_r */
 	move.l	%a0,-(%sp)		/* dest_addr */
diff --git a/arch/m68k/cpu/mcf530x/start.S b/arch/m68k/cpu/mcf530x/start.S
index cef8d79aad1..552e0204b77 100644
--- a/arch/m68k/cpu/mcf530x/start.S
+++ b/arch/m68k/cpu/mcf530x/start.S
@@ -180,6 +180,39 @@ relocate_code:
 	cmp.l	%a1,%a2
 	bgt.s	1b
 
+#define R_68K_32	1
+#define R_68K_RELATIVE	22
+
+	move.l #(__rel_dyn_start), %a1
+	move.l #(__rel_dyn_end), %a2
+
+fixloop:
+	move.l	(%a1)+, %d1	/* Elf32_Rela r_offset */
+	move.l	(%a1)+, %d2	/* Elf32_Rela r_info */
+	move.l	(%a1)+, %d3	/* Elf32_Rela r_addend */
+
+	andi.l	#0xff, %d2
+	cmp.l	#R_68K_32, %d2
+	beq.s	fixup
+	cmp.l	#R_68K_RELATIVE, %d2
+	beq.s	fixup
+
+	bra	fixnext
+
+fixup:
+	/* relative fix: store addend plus offset at dest location */
+	move.l	%a0, %a3
+	add.l	%d1, %a3
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %a3
+	move.l	(%a3), %d4
+	add.l	%a0, %d4
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %d4
+	move.l	%d4, (%a3)
+
+fixnext:
+	cmp.l	%a1, %a2
+	bge.s	fixloop
+
 /*
  * We are done. Do not return, instead branch to second part of board
  * initialization, now running from RAM.
@@ -194,10 +227,8 @@ clear_bss:
 	/*
 	 * Now clear BSS segment
 	 */
-	move.l	%a0, %a1
-	add.l	#(_sbss - CONFIG_SYS_MONITOR_BASE), %a1
-	move.l	%a0, %d1
-	add.l	#(_ebss - CONFIG_SYS_MONITOR_BASE), %d1
+	move.l	#(_sbss), %a1
+	move.l	#(_ebss), %d1
 6:
 	clr.l	(%a1)+
 	cmp.l	%a1,%d1
@@ -206,26 +237,10 @@ clear_bss:
 	/*
 	 * fix got table in RAM
 	 */
-	move.l	%a0, %a1
-	add.l	#(__got_start - CONFIG_SYS_MONITOR_BASE), %a1
-
-	/* fix got pointer register a5 */
-	move.l	%a1,%a5
-
-	move.l	%a0, %a2
-	add.l	#(__got_end - CONFIG_SYS_MONITOR_BASE), %a2
-
-7:
-	move.l	(%a1),%d1
-	sub.l	#_start, %d1
-	add.l	%a0,%d1
-	move.l	%d1,(%a1)+
-	cmp.l	%a2, %a1
-	bne	7b
+	move.l	#(__got_start), %a5	/* fix got pointer register a5 */
 
 	/* calculate relative jump to board_init_r in ram */
-	move.l	%a0, %a1
-	add.l	#(board_init_r - CONFIG_SYS_MONITOR_BASE), %a1
+	move.l	#(board_init_r), %a1
 
 	/* set parameters for board_init_r */
 	move.l	%a0,-(%sp)	/* dest_addr */
diff --git a/arch/m68k/cpu/mcf532x/start.S b/arch/m68k/cpu/mcf532x/start.S
index 72a2f99b7dd..c3eae73a9c0 100644
--- a/arch/m68k/cpu/mcf532x/start.S
+++ b/arch/m68k/cpu/mcf532x/start.S
@@ -192,6 +192,39 @@ relocate_code:
 	cmp.l	%a1,%a2
 	bgt.s	1b
 
+#define R_68K_32	1
+#define R_68K_RELATIVE	22
+
+	move.l #(__rel_dyn_start), %a1
+	move.l #(__rel_dyn_end), %a2
+
+fixloop:
+	move.l	(%a1)+, %d1	/* Elf32_Rela r_offset */
+	move.l	(%a1)+, %d2	/* Elf32_Rela r_info */
+	move.l	(%a1)+, %d3	/* Elf32_Rela r_addend */
+
+	andi.l	#0xff, %d2
+	cmp.l	#R_68K_32, %d2
+	beq.s	fixup
+	cmp.l	#R_68K_RELATIVE, %d2
+	beq.s	fixup
+
+	bra	fixnext
+
+fixup:
+	/* relative fix: store addend plus offset at dest location */
+	move.l	%a0, %a3
+	add.l	%d1, %a3
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %a3
+	move.l	(%a3), %d4
+	add.l	%a0, %d4
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %d4
+	move.l	%d4, (%a3)
+
+fixnext:
+	cmp.l	%a1, %a2
+	bge.s	fixloop
+
 /*
  * We are done. Do not return, instead branch to second part of board
  * initialization, now running from RAM.
@@ -206,10 +239,8 @@ clear_bss:
 	/*
 	 * Now clear BSS segment
 	 */
-	move.l	%a0, %a1
-	add.l	#(_sbss - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a0, %d1
-	add.l	#(_ebss - CONFIG_SYS_MONITOR_BASE),%d1
+	move.l	#(_sbss), %a1
+	move.l	#(_ebss), %d1
 6:
 	clr.l	(%a1)+
 	cmp.l	%a1,%d1
@@ -218,24 +249,10 @@ clear_bss:
 	/*
 	 * fix got table in RAM
 	 */
-	move.l	%a0, %a1
-	add.l	#(__got_start - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a1,%a5			/* fix got pointer register a5 */
-
-	move.l	%a0, %a2
-	add.l	#(__got_end - CONFIG_SYS_MONITOR_BASE),%a2
-
-7:
-	move.l	(%a1),%d1
-	sub.l	#_start,%d1
-	add.l	%a0,%d1
-	move.l	%d1,(%a1)+
-	cmp.l	%a2, %a1
-	bne	7b
+	move.l	#(__got_start), %a5	/* fix got pointer register a5 */
 
 	/* calculate relative jump to board_init_r in ram */
-	move.l	%a0, %a1
-	add.l	#(board_init_r - CONFIG_SYS_MONITOR_BASE), %a1
+	move.l	#(board_init_r), %a1
 
 	/* set parameters for board_init_r */
 	move.l	%a0,-(%sp)		/* dest_addr */
diff --git a/arch/m68k/cpu/mcf5445x/start.S b/arch/m68k/cpu/mcf5445x/start.S
index a083c3d45d2..5c3bfff7918 100644
--- a/arch/m68k/cpu/mcf5445x/start.S
+++ b/arch/m68k/cpu/mcf5445x/start.S
@@ -533,6 +533,39 @@ relocate_code:
 	cmp.l	%a1,%a2
 	bgt.s	1b
 
+#define R_68K_32	1
+#define R_68K_RELATIVE	22
+
+	move.l #(__rel_dyn_start), %a1
+	move.l #(__rel_dyn_end), %a2
+
+fixloop:
+	move.l	(%a1)+, %d1	/* Elf32_Rela r_offset */
+	move.l	(%a1)+, %d2	/* Elf32_Rela r_info */
+	move.l	(%a1)+, %d3	/* Elf32_Rela r_addend */
+
+	andi.l	#0xff, %d2
+	cmp.l	#R_68K_32, %d2
+	beq.s	fixup
+	cmp.l	#R_68K_RELATIVE, %d2
+	beq.s	fixup
+
+	bra	fixnext
+
+fixup:
+	/* relative fix: store addend plus offset at dest location */
+	move.l	%a0, %a3
+	add.l	%d1, %a3
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %a3
+	move.l	(%a3), %d4
+	add.l	%a0, %d4
+	sub.l   #CONFIG_SYS_MONITOR_BASE, %d4
+	move.l	%d4, (%a3)
+
+fixnext:
+	cmp.l	%a1, %a2
+	bge.s	fixloop
+
 /*
  * We are done. Do not return, instead branch to second part of board
  * initialization, now running from RAM.
@@ -547,10 +580,8 @@ clear_bss:
 	/*
 	 * Now clear BSS segment
 	 */
-	move.l	%a0, %a1
-	add.l	#(_sbss - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a0, %d1
-	add.l	#(_ebss - CONFIG_SYS_MONITOR_BASE),%d1
+	move.l	#(_sbss), %a1
+	move.l	#(_ebss), %d1
 6:
 	clr.l	(%a1)+
 	cmp.l	%a1,%d1
@@ -559,24 +590,10 @@ clear_bss:
 	/*
 	 * fix got table in RAM
 	 */
-	move.l	%a0, %a1
-	add.l	#(__got_start - CONFIG_SYS_MONITOR_BASE),%a1
-	move.l	%a1,%a5			/* fix got pointer register a5 */
-
-	move.l	%a0, %a2
-	add.l	#(__got_end - CONFIG_SYS_MONITOR_BASE),%a2
-
-7:
-	move.l	(%a1),%d1
-	sub.l	#_start,%d1
-	add.l	%a0,%d1
-	move.l	%d1,(%a1)+
-	cmp.l	%a2, %a1
-	bne	7b
+	move.l	#(__got_start), %a5	/* fix got pointer register a5 */
 
 	/* calculate relative jump to board_init_r in ram */
-	move.l	%a0, %a1
-	add.l	#(board_init_r - CONFIG_SYS_MONITOR_BASE), %a1
+	move.l	#(board_init_r), %a1
 
 	/* set parameters for board_init_r */
 	move.l	%a0,-(%sp)		/* dest_addr */
diff --git a/arch/m68k/cpu/u-boot.lds b/arch/m68k/cpu/u-boot.lds
index 133f79150ba..03d427cd36c 100644
--- a/arch/m68k/cpu/u-boot.lds
+++ b/arch/m68k/cpu/u-boot.lds
@@ -76,6 +76,20 @@ SECTIONS
 	. = ALIGN(4);
 	__init_end = .;
 
+	. = ALIGN(4);
+	__rel_dyn_start = .;
+	.rela.dyn : {
+		*(.rela.dyn)
+	}
+	__rel_dyn_end = .;
+
+	. = ALIGN(4);
+	__dyn_sym_start = .;
+	.dynsym : {
+		*(.dynsym)
+	}
+	__dyn_sym_end = .;
+
 	_end = .;
 
 	__bss_start = .;
-- 
2.40.1

