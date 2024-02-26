Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB10C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBED587FB9;
	Mon, 26 Feb 2024 22:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RMDafSgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8668387F74; Mon, 26 Feb 2024 22:24:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6D887F8B
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-150.46.114.pool.telefonica.de
 [46.114.105.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 40B2840ED7; 
 Mon, 26 Feb 2024 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708982647;
 bh=eR50pk103WVrQNw4N39vLgsZci00vipahr0oiB+CAQM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RMDafSgE/MBERzLaDwK8bHjfGXNCSGYM055d6oYSCvvbLy8eyEfykrQyZXyT87q/J
 FSb9JSFLlxiEIU9IrQ3wkRbcyuhwcrb0MfulQJxx4JtkMhN8in46gmcD42oFolAznC
 8dnWMKbOebbMniZRwK5xd3D1Ser/Rb+9+WanLzW0Oetf1r1CeH2WuMvT6mJX+ENwax
 oHd0SwY/TvpcB0h7pCxJ6eDPN1L0Ybbw26L1Xwi5Zg0Fyf0cmDgmbI29cwCJUjJx/a
 Zrogr8VAIQTapvHKMGfwwGUzDDDyuQCrLTp8zrbzO+9/tbMzLtIapo3AhMWKD6Fi1f
 D5fIpnAAiHqPA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] arm: separate .data and .text sections of EFI binaries
Date: Mon, 26 Feb 2024 22:24:08 +0100
Message-ID: <20240226212408.7535-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
References: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
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

EFI binaries should not contain sections that are both writable and
executable. Separate the RX .text section from the RW .data section.

We currently don't created relocation sections (.rel.*) for our EFI
binaries. Anyway these would have to be converted to PE/COFF relocations.
Enumerate them under DISCARD and add a comment.

Correct the characteristics of the sections.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Consider that 32-bit arm uses .rel and not .rela relocations
	and discard them as they are cannot be used in EFI binaries.
	Correct the characteristics of the .reloc section.
---
 arch/arm/lib/crt0_arm_efi.S  | 40 ++++++++++++++++++++++++++++--------
 arch/arm/lib/elf_arm_efi.lds | 28 ++++++++++++++++++-------
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index 7a4e5dff75..7219c0f2fe 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -23,7 +23,7 @@ pe_header:
 	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
 coff_header:
 	.short	IMAGE_FILE_MACHINE_THUMB	/* Mixed ARM/Thumb */
-	.short	2				/* nr_sections */
+	.short	3				/* nr_sections */
 	.long	0				/* TimeDateStamp */
 	.long	0				/* PointerToSymbolTable */
 	.long	0				/* NumberOfSymbols */
@@ -98,22 +98,44 @@ section_table:
 	.long	0			/* PointerToLineNumbers */
 	.short	0			/* NumberOfRelocations */
 	.short	0			/* NumberOfLineNumbers */
-	.long	0x42100040		/* Characteristics (section flags) */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_MEM_DISCARDABLE | \
+		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
 	.ascii	".text"
 	.byte	0
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
-	.long	_edata - _start		/* VirtualSize */
+	.long	_text_size		/* VirtualSize */
 	.long	_start - image_base	/* VirtualAddress */
-	.long	_edata - _start		/* SizeOfRawData */
+	.long	_text_size		/* SizeOfRawData */
 	.long	_start - image_base	/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_MEM_EXECUTE | \
+		 IMAGE_SCN_CNT_CODE)
 
-	.long	0		/* PointerToRelocations (0 for executables) */
-	.long	0		/* PointerToLineNumbers (0 for executables) */
-	.short	0		/* NumberOfRelocations  (0 for executables) */
-	.short	0		/* NumberOfLineNumbers  (0 for executables) */
-	.long	0xe0500020	/* Characteristics (section flags) */
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	_data_size		/* VirtualSize */
+	.long	_data - image_base	/* VirtualAddress */
+	.long	_data_size		/* SizeOfRawData */
+	.long	_data - image_base	/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_WRITE | \
+		 IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
 	.align		12
 _start:
diff --git a/arch/arm/lib/elf_arm_efi.lds b/arch/arm/lib/elf_arm_efi.lds
index 767ebda635..41440594aa 100644
--- a/arch/arm/lib/elf_arm_efi.lds
+++ b/arch/arm/lib/elf_arm_efi.lds
@@ -7,6 +7,12 @@
 
 OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
+
+PHDRS
+{
+	data PT_LOAD FLAGS(3); /* PF_W | PF_X */
+}
+
 ENTRY(_start)
 SECTIONS
 {
@@ -18,11 +24,13 @@ SECTIONS
 		*(.gnu.linkonce.t.*)
 		*(.srodata)
 		*(.rodata*)
+		. = ALIGN(16);
+		*(.dynamic);
 		. = ALIGN(512);
 	}
 	_etext = .;
 	_text_size = . - _text;
-	.dynamic  : { *(.dynamic) }
+	. = ALIGN(4096);
 	.data : {
 		_data = .;
 		*(.sdata)
@@ -47,14 +55,20 @@ SECTIONS
 		. = ALIGN(512);
 		_bss_end = .;
 		_edata = .;
-	}
-	.rel.dyn : { *(.rel.dyn) }
-	.rel.plt : { *(.rel.plt) }
-	.rel.got : { *(.rel.got) }
-	.rel.data : { *(.rel.data) *(.rel.data*) }
-	_data_size = . - _etext;
+	} :data
+	_data_size = . - _data;
 
 	/DISCARD/ : {
+		/*
+		 * We don't support relocations. These would have to be
+		 * translated from ELF to PE format and added to the .reloc
+		 * section.
+		 */
+		*(.rel.dyn)
+		*(.rel.plt)
+		*(.rel.got)
+		*(.rel.data)
+		*(.rel.data*)
 		*(.rel.reloc)
 		*(.eh_frame)
 		*(.note.GNU-stack)
-- 
2.43.0

