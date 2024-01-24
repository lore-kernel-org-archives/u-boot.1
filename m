Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92487C47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 23:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E757A86D9E;
	Thu, 25 Jan 2024 00:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q/HnwlNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A364987B71; Thu, 25 Jan 2024 00:09:07 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A9486D9E
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 00:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4814B3F2D0; 
 Wed, 24 Jan 2024 23:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706137743;
 bh=4WEbVT+0FxeZkFQz2JflyfZjvq9Lb4QxMl4zkJxAiIs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Q/HnwlNR+NzQ2BIbkdlOnSCIQPCTsonxaEXzCYfAn9+8saAElMSyjPxUSFioJoNe8
 Nlf5IEb2XwS7GRzxDO5kxoWVPzx3pEkrjqTZfn9PHdaTquW5eNBRVQ4hl7YpJj7lB0
 68b3k2F0R88j7GCfI5FkB+jyRs8S8YIP/DO4Lswx69aOrqJeLDsg4T8ypQj3d5a5VK
 Zz1KyfbyQt+FAGtAm8NGUjJE0RNo/1NcYmgLqUo2oQknICtRAyQ/gZ8BEXtKXz9nM4
 TdUp/WisDlkmfeN++/gFq+1F9FD0D2I7Q+n/NHKw0hYIqVAzblwnA74x/CfXZIFhQ/
 CrGxkeAhzVSpA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: separate .data and .text sections of EFI binaries
Date: Thu, 25 Jan 2024 00:08:57 +0100
Message-ID: <20240124230857.64699-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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
executable. Separate the RX .text section from the RW .data section

Adjust the section alignment to 4096 bytes.

Fix conflicting SPDX license information in linker scripts introduced by
commit 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel
style").

Fixes: 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel style")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/lib/crt0_riscv_efi.S    | 39 ++++++++++++++++++++++--------
 arch/riscv/lib/elf_riscv32_efi.lds | 26 ++++++++++++--------
 arch/riscv/lib/elf_riscv64_efi.lds | 26 ++++++++++++--------
 3 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index 793eefdd883..46b08552371 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -53,7 +53,7 @@ pe_header:
 	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
 coff_header:
 	.short	PE_MACHINE			/* RISC-V 64/32-bit */
-	.short	2				/* nr_sections */
+	.short	3				/* nr_sections */
 	.long	0				/* TimeDateStamp */
 	.long	0				/* PointerToSymbolTable */
 	.long	0				/* NumberOfSymbols */
@@ -144,18 +144,37 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
-	.long	_edata - _start		/* VirtualSize */
+	.long	_etext - _start		/* VirtualSize */
 	.long	_start - ImageBase	/* VirtualAddress */
-	.long	_edata - _start		/* SizeOfRawData */
+	.long	_etext - _start		/* SizeOfRawData */
 	.long	_start - ImageBase	/* PointerToRawData */
+	.long	0			/* PointerToRelocations (0 for executables) */
+	.long	0			/* PointerToLineNumbers (0 for executables) */
+	.short	0			/* NumberOfRelocations  (0 for executables) */
+	.short	0			/* NumberOfLineNumbers  (0 for executables) */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_MEM_EXECUTE | \
+		 IMAGE_SCN_CNT_CODE)
+
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	_edata - _data		/* VirtualSize */
+	.long	_data - ImageBase	/* VirtualAddress */
+	.long	_edata - _data		/* SizeOfRawData */
+	.long	_data - ImageBase	/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_WRITE | \
+		 IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
-	.long	0		/* PointerToRelocations (0 for executables) */
-	.long	0		/* PointerToLineNumbers (0 for executables) */
-	.short	0		/* NumberOfRelocations  (0 for executables) */
-	.short	0		/* NumberOfLineNumbers  (0 for executables) */
-	.long	0xe0500020	/* Characteristics (section flags) */
-
-	.align	9
+	.align		12
 _start:
 	addi		sp, sp, -(SIZE_LONG * 3)
 	SAVE_LONG(a0, 0)
diff --git a/arch/riscv/lib/elf_riscv32_efi.lds b/arch/riscv/lib/elf_riscv32_efi.lds
index c3e0d20d577..7b9bd7b7f15 100644
--- a/arch/riscv/lib/elf_riscv32_efi.lds
+++ b/arch/riscv/lib/elf_riscv32_efi.lds
@@ -1,14 +1,18 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: BSD-2-Clause */
 /*
  * U-Boot riscv32 EFI linker script
  *
- * SPDX-License-Identifier:	BSD-2-Clause
- *
  * Modified from arch/arm/lib/elf_aarch64_efi.lds
  */
 
 OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
 OUTPUT_ARCH(riscv)
+
+PHDRS
+{
+	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
+}
+
 ENTRY(_start)
 SECTIONS
 {
@@ -20,11 +24,17 @@ SECTIONS
 		*(.gnu.linkonce.t.*)
 		*(.srodata)
 		*(.rodata*)
+		. = ALIGN(16);
+		*(.dynamic);
 		. = ALIGN(512);
 	}
+	.rela.dyn : { *(.rela.dyn) }
+	.rela.plt : { *(.rela.plt) }
+	.rela.got : { *(.rela.got) }
+	.rela.data : { *(.rela.data) *(.rela.data*) }
 	_etext = .;
 	_text_size = . - _text;
-	.dynamic  : { *(.dynamic) }
+	. = ALIGN(4096);
 	.data : {
 		_data = .;
 		*(.sdata)
@@ -49,12 +59,8 @@ SECTIONS
 		. = ALIGN(512);
 		_bss_end = .;
 		_edata = .;
-	}
-	.rela.dyn : { *(.rela.dyn) }
-	.rela.plt : { *(.rela.plt) }
-	.rela.got : { *(.rela.got) }
-	.rela.data : { *(.rela.data) *(.rela.data*) }
-	_data_size = . - _etext;
+	} :data
+	_data_size = _edata - _data;
 
 	. = ALIGN(4096);
 	.dynsym   : { *(.dynsym) }
diff --git a/arch/riscv/lib/elf_riscv64_efi.lds b/arch/riscv/lib/elf_riscv64_efi.lds
index ecb91395486..d0b4f3d1d64 100644
--- a/arch/riscv/lib/elf_riscv64_efi.lds
+++ b/arch/riscv/lib/elf_riscv64_efi.lds
@@ -1,14 +1,18 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: BSD-2-Clause */
 /*
  * U-Boot riscv64 EFI linker script
  *
- * SPDX-License-Identifier:	BSD-2-Clause
- *
  * Modified from arch/arm/lib/elf_aarch64_efi.lds
  */
 
 OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
 OUTPUT_ARCH(riscv)
+
+PHDRS
+{
+	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
+}
+
 ENTRY(_start)
 SECTIONS
 {
@@ -20,11 +24,17 @@ SECTIONS
 		*(.gnu.linkonce.t.*)
 		*(.srodata)
 		*(.rodata*)
+		. = ALIGN(16);
+		*(.dynamic);
 		. = ALIGN(512);
 	}
+	.rela.dyn : { *(.rela.dyn) }
+	.rela.plt : { *(.rela.plt) }
+	.rela.got : { *(.rela.got) }
+	.rela.data : { *(.rela.data) *(.rela.data*) }
 	_etext = .;
 	_text_size = . - _text;
-	.dynamic  : { *(.dynamic) }
+	. = ALIGN(4096);
 	.data : {
 		_data = .;
 		*(.sdata)
@@ -49,12 +59,8 @@ SECTIONS
 		. = ALIGN(512);
 		_bss_end = .;
 		_edata = .;
-	}
-	.rela.dyn : { *(.rela.dyn) }
-	.rela.plt : { *(.rela.plt) }
-	.rela.got : { *(.rela.got) }
-	.rela.data : { *(.rela.data) *(.rela.data*) }
-	_data_size = . - _etext;
+	} :data
+	_data_size = _edata - _data;
 
 	. = ALIGN(4096);
 	.dynsym   : { *(.dynsym) }
-- 
2.43.0

