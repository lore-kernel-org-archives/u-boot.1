Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D71C021A6
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEAF80FD8;
	Sat, 15 Feb 2025 04:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IPq6ZJDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFD080ECC; Sat, 15 Feb 2025 04:24:31 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308D280B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d1988be53dso4768325ab.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589867; x=1740194667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgJjBOi7E3QrdeH1tjO0sQTcT23T/INrj2dNwhG6fbc=;
 b=IPq6ZJDO7TUyHgsvzMjq1u2mCmG9UBMWa/fhK1CItd4JADuo3blTwNIc48bIvHBVRT
 MKdphLEFUhq4ZSxvqwAGwJCEXSXO+FRf+s60pJh4XJRkBOerWe7e+SChwbxUDKhzjnXo
 AEVAo/X9gsifRmgNx0Vgv3143unT5UAbq6bWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589867; x=1740194667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgJjBOi7E3QrdeH1tjO0sQTcT23T/INrj2dNwhG6fbc=;
 b=DpMkrBz7PsI3XvYyQF5uPRs4yHUvEm93lZnDGxDPpv2J6T3ZkeFYgJSsDDeghbHyt1
 MiK0JJq0VCYD/B6rxNbK/EzAHkip8oH6CXQtO0m9JnmHogMj+xnffyYwfrzpCUZhQh3/
 +ZM0oDlkJTVqnfoXnZZh8vLu3v4gbg2pQqzS1cj95sf/SEsaBg0ACzu3km6P3PhVkQJZ
 ybHA+Bua3m1lD6FEoEiZzKcDQY9AveRJHzz1HLyYYgK6P98BsufJsY5H2q+7aVkSFVcz
 AKG1kcYBKlzQ5s+QLolloEvauBeG+rNrwcyaPJuOXyOjUa/ltFQfrEmrViZGj+yqQD8c
 7dWQ==
X-Gm-Message-State: AOJu0YxfXi4H9hYCvMmNoynNuXdiUj5YdjDQWmjF8EV1xUIxjR9L5mU1
 A3/FGtcGIFcPG8N4NfV1ATiEF6oAr1Ms5CzW9NVO1MURNS+Kvprel+UyMFViT9sogJdjVN37jY4
 =
X-Gm-Gg: ASbGnctI3REQRcS9XJNYB5xkBpuXpYFuQ3O7UKPEk9+q0EFfZLmquuvkW5IeJk7ZJBP
 Cnahhd6Kuf443yAix3oWA2VFc5UtVscvdjXSHlmcJRS/C0aCHFVNr50Z8GUsP347HmzV1HfwFLt
 1MgO+4JxlwjA3gBVpUHS1Xq94mp/BuHz1TrAJi7OabYYUmPAdNoW9rl7EKWP5R1sUqzuo9Onw43
 YrcFKvz5+NRBQudy2CONLY8aCjaSvLR9ZD9BFDxCPuOaYi9iHMmoPgGdGrynN2m11yOgv1y1jRz
 XUNDRxA2qv5+/ZVy+6KwiO/oS4Yjuo7udn63ugO7lwjNX4KxvAQu
X-Google-Smtp-Source: AGHT+IHvutUqeKKBTSojtquVmWudLhWfdnQ8Wbzm0NTkCRBSAiEKVqsIvFef9Ktjykvnb+VHV7SsnQ==
X-Received: by 2002:a05:6e02:b4b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d2809193c5mr16737305ab.19.1739589867150; 
 Fri, 14 Feb 2025 19:24:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 28/29] efi: arm: Simplify the crt0 file and update link
 script
Date: Fri, 14 Feb 2025 20:22:49 -0700
Message-ID: <20250215032254.4121030-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

We don't need to manually add the PE header, since binutils has support
for this now. Remove it to simplify the file.

Set the link-target to efi-app-aarch64 so that binutils knows what to
do. Add rules to pick up the arm64 files.

Make some updates to the link-script for arm64, so this all works:

- Pass  .hash .eh_frame and .reloc sections through to objcopy
- Put RELA pieces into a single section
- Put linker lists into .data
- Embed the dtb

Add a config.mk fragment into the baord directory.

Note that it does not seem to be possible to use this approach with
32-bit ARM, so this is left alone.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Put EFI_LDS back as it is required for building helloword.efi etc.
- Put the config.mk changes in the board directory

Changes in v3:
- Drop setting of EFI_LDS and rely on the CONFIG_SYS_LDSCRIPT value

 arch/arm/config.mk               |  10 ++
 arch/arm/cpu/armv8/config.mk     |   6 +-
 arch/arm/lib/crt0_aarch64_efi.S  | 156 +++++--------------------------
 arch/arm/lib/elf_aarch64_efi.lds |  49 +++++++---
 board/efi/efi-arm_app/config.mk  |   4 +
 5 files changed, 74 insertions(+), 151 deletions(-)
 create mode 100644 board/efi/efi-arm_app/config.mk

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 20f4d41f2c3..a786709f3b5 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -149,6 +149,9 @@ OBJCOPYFLAGS += -j .text -j .secure_text -j .secure_data -j .rodata -j .hash \
 		-j .binman_sym_table -j .text_rest
 endif
 
+OBJCOPYFLAGS_EFI += $(OBJCOPYFLAGS) -j .dynamic -j .rela -j .reloc \
+	-j .embedded_dtb
+
 # if a dtb section exists we always have to include it
 # there are only two cases where it is generated
 # 1) OF_EMBEDED is turned on
@@ -178,6 +181,13 @@ endif
 endif
 endif
 
+ifdef CONFIG_ARM64
+EFI_LDS := elf_aarch64_efi.lds
+EFI_CRT0 := crt0_aarch64_efi.o
+EFI_RELOC := reloc_aarch64_efi.o
+EFI_TARGET := --target=efi-app-aarch64
+else
 EFI_LDS := elf_arm_efi.lds
 EFI_CRT0 := crt0_arm_efi.o
 EFI_RELOC := reloc_arm_efi.o
+endif
diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 0316af306c4..61ba3143969 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -13,7 +13,7 @@ EFI_RELOC := reloc_aarch64_efi.o
 
 LDSCRIPT_EFI := $(srctree)/arch/arm/lib/elf_aarch64_efi.lds
 EFISTUB := crt0_aarch64_efi.o reloc_aarch64_efi.o
-OBJCOPYFLAGS_EFI += --target=pei-aarch64-little
+OBJCOPYFLAGS_EFI += -O binary --target=efi-app-aarch64
 EFIPAYLOAD_BFDTARGET := pei-aarch64-little
 EFIPAYLOAD_BFDARCH := aarch64
 LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
@@ -21,7 +21,3 @@ LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
 
 CPPFLAGS_REMOVE_crt0-efi-aarch64.o += $(CFLAGS_NON_EFI)
 CPPFLAGS_crt0-efi-aarch64.o += $(CFLAGS_EFI)
-
-ifeq ($(CONFIG_EFI_APP),y)
-PLATFORM_CPPFLAGS += $(CFLAGS_EFI)
-endif
diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index c1030e5392a..88f8449bb03 100644
--- a/arch/arm/lib/crt0_aarch64_efi.S
+++ b/arch/arm/lib/crt0_aarch64_efi.S
@@ -10,140 +10,11 @@
 
 #include <asm-generic/pe.h>
 
-	.section	.text.head
-
-	/*
-	 * Magic "MZ" signature for PE/COFF
-	 */
-	.globl	image_base
-image_base:
-	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
-	.skip	54				/* 'MZ' + pad + offset == 64 */
-	.long   LINUX_ARM64_MAGIC		/* For GRUB's linux command */
-	.long	pe_header - image_base		/* Offset to the PE header */
-pe_header:
-	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
-coff_header:
-	.short	IMAGE_FILE_MACHINE_ARM64	/* AArch64 */
-	.short	3				/* nr_sections */
-	.long	0				/* TimeDateStamp */
-	.long	0				/* PointerToSymbolTable */
-	.long	0				/* NumberOfSymbols */
-	.short	section_table - optional_header	/* SizeOfOptionalHeader */
-	/* Characteristics */
-	.short	(IMAGE_FILE_EXECUTABLE_IMAGE | \
-		 IMAGE_FILE_LINE_NUMS_STRIPPED | \
-		 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
-		 IMAGE_FILE_LARGE_ADDRESS_AWARE | \
-		 IMAGE_FILE_DEBUG_STRIPPED)
-optional_header:
-	.short	IMAGE_NT_OPTIONAL_HDR64_MAGIC	/* PE32+ format */
-	.byte	0x02				/* MajorLinkerVersion */
-	.byte	0x14				/* MinorLinkerVersion */
-	.long	_etext - _start			/* SizeOfCode */
-	.long	0				/* SizeOfInitializedData */
-	.long	0				/* SizeOfUninitializedData */
-	.long	_start - image_base		/* AddressOfEntryPoint */
-	.long	_start - image_base		/* BaseOfCode */
-
-extra_header_fields:
-	.quad	0				/* image_base */
-	.long	0x1000				/* SectionAlignment */
-	.long	0x200				/* FileAlignment */
-	.short	0				/* MajorOperatingSystemVersion */
-	.short	0				/* MinorOperatingSystemVersion */
-	.short	0				/* MajorImageVersion */
-	.short	0				/* MinorImageVersion */
-	.short	0				/* MajorSubsystemVersion */
-	.short	0				/* MinorSubsystemVersion */
-	.long	0				/* Win32VersionValue */
-
-	.long	_edata - image_base		/* SizeOfImage */
-
-	/*
-	 * Everything before the kernel image is considered part of the header
-	 */
-	.long	_start - image_base		/* SizeOfHeaders */
-	.long	0				/* CheckSum */
-	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
-#if CONFIG_ARCH_EFI
-	.short	0				/* DllCharacteristics */
-#else
-	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
-#endif
-	.quad	0				/* SizeOfStackReserve */
-	.quad	0				/* SizeOfStackCommit */
-	.quad	0				/* SizeOfHeapReserve */
-	.quad	0				/* SizeOfHeapCommit */
-	.long	0				/* LoaderFlags */
-	.long	0x6				/* NumberOfRvaAndSizes */
-
-	.quad	0				/* ExportTable */
-	.quad	0				/* ImportTable */
-	.quad	0				/* ResourceTable */
-	.quad	0				/* ExceptionTable */
-	.quad	0				/* CertificationTable */
-	.quad	0				/* BaseRelocationTable */
-
-	/* Section table */
-section_table:
-
-	/*
-	 * The EFI application loader requires a relocation section
-	 * because EFI applications must be relocatable.  This is a
-	 * dummy section as far as we are concerned.
-	 */
-	.ascii	".reloc"
-	.byte	0
-	.byte	0			/* end of 0 padding of section name */
-	.long	0
-	.long	0
-	.long	0			/* SizeOfRawData */
-	.long	0			/* PointerToRawData */
-	.long	0			/* PointerToRelocations */
-	.long	0			/* PointerToLineNumbers */
-	.short	0			/* NumberOfRelocations */
-	.short	0			/* NumberOfLineNumbers */
-	/* Characteristics (section flags) */
-	.long	(IMAGE_SCN_MEM_READ | \
-		 IMAGE_SCN_MEM_DISCARDABLE | \
-		 IMAGE_SCN_CNT_INITIALIZED_DATA)
-
-	.ascii	".text"
-	.byte	0
-	.byte	0
-	.byte	0			/* end of 0 padding of section name */
-	.long	_etext - _start		/* VirtualSize */
-	.long	_start - image_base	/* VirtualAddress */
-	.long	_etext - _start		/* SizeOfRawData */
-	.long	_start - image_base	/* PointerToRawData */
-	.long	0			/* PointerToRelocations */
-	.long	0			/* PointerToLineNumbers */
-	.short	0			/* NumberOfRelocations */
-	.short	0			/* NumberOfLineNumbers */
-	/* Characteristics (section flags) */
-	.long	(IMAGE_SCN_MEM_READ | \
-		 IMAGE_SCN_MEM_EXECUTE | \
-		 IMAGE_SCN_CNT_CODE)
-
-	.ascii	".data"
-	.byte	0
-	.byte	0
-	.byte	0			/* end of 0 padding of section name */
-	.long	_data_size		/* VirtualSize */
-	.long	_data - image_base	/* VirtualAddress */
-	.long	_data_size		/* SizeOfRawData */
-	.long	_data - image_base	/* PointerToRawData */
-	.long	0			/* PointerToRelocations */
-	.long	0			/* PointerToLineNumbers */
-	.short	0			/* NumberOfRelocations */
-	.short	0			/* NumberOfLineNumbers */
-	/* Characteristics (section flags) */
-	.long	(IMAGE_SCN_MEM_WRITE | \
-		 IMAGE_SCN_MEM_READ | \
-		 IMAGE_SCN_CNT_INITIALIZED_DATA)
-
+	.text
 	.align		12
+
+	.globl _start
+	.type _start,%function
 _start:
 	stp		x29, x30, [sp, #-32]!
 	mov		x29, sp
@@ -160,3 +31,22 @@ _start:
 
 0:	ldp		x29, x30, [sp], #32
 	ret
+
+	/*
+	 * hand-craft a dummy .reloc section so EFI knows it's a relocatable
+	 * executable:
+	*/
+	.data
+dummy:	.4byte	0
+
+#define IMAGE_REL_ABSOLUTE	0
+	.section .reloc, "a"
+label1:
+	.4byte	dummy-label1			// Page RVA
+	.4byte	12				// Block Size (2*4+2*2), must be aligned by 32 Bits
+	.2byte	(IMAGE_REL_ABSOLUTE<<12) +  0	// reloc for dummy
+	.2byte	(IMAGE_REL_ABSOLUTE<<12) +  0	// reloc for dummy
+
+#if defined(__ELF__) && defined(__linux__)
+	.section .note.GNU-stack,"",%progbits
+#endif
diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd98091698..2241bea4dc1 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -7,18 +7,19 @@
 
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
 OUTPUT_ARCH(aarch64)
-
-PHDRS
-{
-	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
-}
-
 ENTRY(_start)
 SECTIONS
 {
-	.text 0x0 : {
+	. = 0;
+	image_base = .;
+	/* .hash and/or .gnu.hash MUST come first! */
+	.hash : { *(.hash) }
+	.gnu.hash : { *(.gnu.hash) }
+	. = ALIGN(4096);
+	.eh_frame : { *(.eh_frame) }
+	. = ALIGN(4096);
+	.text : {
 		_text = .;
-		*(.text.head)
 		*(.text)
 		*(.text.*)
 		*(.gnu.linkonce.t.*)
@@ -28,12 +29,12 @@ SECTIONS
 		*(.dynamic);
 		. = ALIGN(512);
 	}
-	.rela.dyn : { *(.rela.dyn) }
-	.rela.plt : { *(.rela.plt) }
-	.rela.got : { *(.rela.got) }
-	.rela.data : { *(.rela.data) *(.rela.data*) }
 	_etext = .;
 	_text_size = . - _text;
+	. = ALIGN(65536);
+	.reloc : {
+		KEEP (*(.reloc))
+	}
 	. = ALIGN(4096);
 	.data : {
 		_data = .;
@@ -43,6 +44,10 @@ SECTIONS
 		*(.data.*)
 		*(.got.plt)
 		*(.got)
+		/* U-Boot lists and device tree */
+		. = ALIGN(8);
+		*(SORT(__u_boot_list*));
+		. = ALIGN(8);
 
 		/*
 		 * The EFI loader doesn't seem to like a .bss section, so we
@@ -59,9 +64,24 @@ SECTIONS
 		. = ALIGN(512);
 		_bss_end = .;
 		_edata = .;
-	} :data
+		_end = .;
+	}
 	_data_size = _edata - _data;
 
+	. = ALIGN(4096);
+	.rela : {
+		*(.rela.text*)
+		*(.rela.data*)
+		*(.rela.got)
+		*(.rela.dyn)
+		*(.rela.stab)
+		*(.rela.init_array*)
+		*(.rela.fini_array*)
+		*(.rela.ctors*)
+		*(.rela.dtors*)
+		*(.rela__u_boot_list*)
+	}
+
 	. = ALIGN(4096);
 	.dynsym   : { *(.dynsym) }
 	. = ALIGN(4096);
@@ -73,5 +93,8 @@ SECTIONS
 		*(.eh_frame)
 		*(.note.GNU-stack)
 	}
+	.embedded_dtb : {
+		*(.embedded_dtb)
+	}
 	.comment 0 : { *(.comment) }
 }
diff --git a/board/efi/efi-arm_app/config.mk b/board/efi/efi-arm_app/config.mk
new file mode 100644
index 00000000000..a576a1da539
--- /dev/null
+++ b/board/efi/efi-arm_app/config.mk
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+BUILD_CFLAGS += -shared
+PLATFORM_CPPFLAGS += $(CFLAGS_EFI)
-- 
2.43.0

