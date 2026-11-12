Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6200606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tYbctY/U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=ghn9QWXo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81B1040D82;
	Thu, 12 Nov 2026 11:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CqS207VhRLZT; Thu, 12 Nov 2026 11:58:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05491409C3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484694;
	b=YX0C4UwPVh1k9ggtCLQbN4IzAwVlHXttyo1brs+99ZJqyKQP1dTpN1GftcBfLvCWXCdi
	 BX6gsO/SrvpndEBCE7OLvlyQQW1EsuHS2iwOhAdoPNE93yo5pVolpt8znjspjolWr/3d0
	 zCWzv/iasQg7mXeLAZIkbublwnWPcxMx4705AwT5IsvBXUB2EhFON3rp5CF5oL7BAAbZQ
	 UsLcI8pDzR70tDhaZYSdwi8J6gIA3qjzC8dMxgXacWsYcDkris3zLhTBPdgmTtO/K4cor
	 5ALmkiI3fkFcrrWXRmYt4CoB9eK5aWM2NsTL3rG66ygyG+REqxtuFDxq4KKRNdGyVgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sW6wWoQgxtuXY/0TVwiJMB7GiME6Dt0ls9JDCEKNGHk=;
	b=DUARoG0cqRlK0R51g1NivrjN2vJWUXpuyykso45eRKheQ49eg1bIdRyLruca+zI7CKlW
	 YJGwvim2Ea6kpxUxtV63dJuAqI1kXu/98tAWdEH4Mun4syGDddfHHOcKqYHchl3TJ2+Ny
	 72oav2byTo94lMWTuxvtTTj/Ddyc/7YQlFUd5/y+mxPFRJu70SqatxyZBGzneBT9vH0m+
	 eL0QsNnRJcm/4gn4iqIzSCOgOp2jN3LNKemJmqsn0Qa6zjjM5YbcxLMgdrcl3ntK+CjJO
	 +Q+Po2eOYRZVqPs2tXxaCuVBTayH6lJIJujPHW2rhD2uB+DU/Kp/6AQR/oIZJ2H/b9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484694;
	bh=sW6wWoQgxtuXY/0TVwiJMB7GiME6Dt0ls9JDCEKNGHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYbctY/UC5NWik/z3qa3Nv34y8Ju4kVCsvX2u+kads8Zd/rJIkcHVyINvJqi1OKsO
	 eYGpFmObz4J91rjejWVJJmGhJN46TIdgHNczziTcOaUwss9RHoZ+et3CoxBku39YHV
	 qGcb+NfP15lmUKImPABa3MfWdjmTJbIMTyNt1noZPDvndS7gF9Lgkz+lYU+AwdYMH7
	 6bGc/El30tVSuvLiER5MC4ZJefoJr41ZaSxYzMACUSTynGj+KqS3ltWHb85r5d5KWa
	 vCzHs57Tt9IQAGBVVeJKUsWBIh286EUQlyqW/4kL8G5CY+K//9VPDUoP98BubVBnaJ
	 Wsq3robA6335w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05491409C3;
	Thu, 12 Nov 2026 11:58:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 861A270B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 737F060D53
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNFRY6IS_t_f for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9D556067E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=ghn9QWXo
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9D556067E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=ghn9QWXoT7d7RfqLDYt39D+Mu7m14Vn9TjFPpD6zxjwmAB8xD4FeQddf3MSUpc14UQOWS3RGNxWpCRsPO7Inmwh/hFtygXO4cCtp+k/ixl2BSTNS7VK/xEpwJFERmnMA7Vft9rR+htnYa1rr5QM5xT2I/IGZImQjEIp4ibuloWA=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=sW6wWoQgxtuXY/0TVwiJMB7GiME6Dt0ls9JDCEKNGHk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484678265685.5744297462508;
 Thu, 12 Nov 2026 03:57:58 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 17/20] efi: LoongArch: Implement everything
Date: Thu, 12 Nov 2026 11:54:35 +0000
Message-ID: <20261112115438.1837663-18-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement crt, relocator, linker scripts, and handling of PE relocation
IMAGE_REL_BASED_LOONGARCH64_MARK_LA. Wire things up in Makefiles and
Kconfig. The relocator originates from gnu-efi project.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v6

Changed from v5:
- Remove unnecessary settings of extra-$(CONFIG_*) in
  arch/loongarch/lib/Makefile for EFI applications
- Whitespace/empty line clean up
- Localize the temporary variable used only by loongarch in
  efi_loader_relocate()
- Fix grammar nits in the commit message

No changes since v4

Changed from v3
- Read addend from Rela entry when processing relative relocations in
  reloc_loongarch_efi.c
  - This has been submitted to gnu-efi upstream[1]

Changed from v2
- Mention IMAGE_REL_BASED_LOONGARCH64_MARK_LA handling in the commit
  message, explain the instruction sequence in comments
- Mention the origin of reloc_loongarch_efi.c
- Fix typo in copyright of crt0_loongarch_efi.S
- Clean up whitespaces in crt0_loongarch_efi.S
- Fix SPDX identifier for reloc_loongarch_efi.c
- Drop the meaningless branch for DT_PLTGOT in reloc_loongarch_efi.c

Changed from v1
- Replace obsolete macro __loongarch64 with __loongarch__ and
  __loongarch_grlen
- Support relocation of IMAGE_REL_BASED_LOONGARCH64_MARK_LA

[1]: https://github.com/ncroxon/gnu-efi/pull/109
---
 arch/loongarch/config.mk                 |   4 +
 arch/loongarch/lib/Makefile              |   8 +
 arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++
 arch/loongarch/lib/elf_loongarch_efi.lds |  76 ++++++++++
 arch/loongarch/lib/reloc_loongarch_efi.c | 101 +++++++++++++
 lib/efi_loader/Kconfig                   |   2 +-
 lib/efi_loader/efi_helper.c              |   3 +
 lib/efi_loader/efi_image_loader.c        |  33 ++++
 8 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/crt0_loongarch_efi.S
 create mode 100644 arch/loongarch/lib/elf_loongarch_efi.lds
 create mode 100644 arch/loongarch/lib/reloc_loongarch_efi.c

diff --git a/arch/loongarch/config.mk b/arch/loongarch/config.mk
index 7c247400e361..bae4566e9b62 100644
--- a/arch/loongarch/config.mk
+++ b/arch/loongarch/config.mk
@@ -21,3 +21,7 @@ endif
 PLATFORM_CPPFLAGS	+= -fpic
 PLATFORM_RELFLAGS	+= -fno-common -ffunction-sections -fdata-sections
 LDFLAGS_u-boot		+= --gc-sections -static -pie
+
+EFI_LDS				:= elf_loongarch_efi.lds
+EFI_CRT0			:= crt0_loongarch_efi.o
+EFI_RELOC			:= reloc_loongarch_efi.o
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 9eb9662066a5..d67cfa9ed18c 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -12,3 +12,11 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
 obj-y	+= reset.o
 endif
 obj-y	+= setjmp.o
+
+# For building EFI apps
+CFLAGS_NON_EFI := -fstack-protector-strong
+CFLAGS_$(EFI_CRT0) := $(CFLAGS_EFI)
+CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
+
+CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
+CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib/crt0_loongarch_efi.S
new file mode 100644
index 000000000000..ba3d9b4ad71d
--- /dev/null
+++ b/arch/loongarch/lib/crt0_loongarch_efi.S
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * crt0-efi-loongarch.S - PE/COFF header for LoongArch EFI applications
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm-generic/pe.h>
+#include <asm/asm.h>
+
+#if __loongarch_grlen == 64
+#define PE_MACHINE	IMAGE_FILE_MACHINE_LOONGARCH64
+#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR64_MAGIC
+#define IMG_CHARACTERISTICS \
+	(IMAGE_FILE_EXECUTABLE_IMAGE | \
+	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
+	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
+	 IMAGE_FILE_LARGE_ADDRESS_AWARE | \
+	 IMAGE_FILE_DEBUG_STRIPPED)
+#else
+#define PE_MACHINE	IMAGE_FILE_MACHINE_LOONGARCH32
+#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR32_MAGIC
+#define IMG_CHARACTERISTICS \
+	(IMAGE_FILE_EXECUTABLE_IMAGE | \
+	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
+	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
+	 IMAGE_FILE_DEBUG_STRIPPED)
+#endif
+
+	.section	.text.head
+
+	/*
+	 * Magic "MZ" signature for PE/COFF
+	 */
+	.globl	ImageBase
+ImageBase:
+	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
+	.skip	58
+	.long	pe_header - ImageBase		/* Offset to the PE header */
+pe_header:
+	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
+coff_header:
+	.short	PE_MACHINE			/* LoongArch 64/32-bit */
+	.short	3				/* nr_sections */
+	.long	0				/* TimeDateStamp */
+	.long	0				/* PointerToSymbolTable */
+	.long	0				/* NumberOfSymbols */
+	.short	section_table - optional_header	/* SizeOfOptionalHeader */
+	.short	IMG_CHARACTERISTICS		/* Characteristics */
+optional_header:
+	.short	PE_MAGIC			/* PE32(+) format */
+	.byte	0x02				/* MajorLinkerVersion */
+	.byte	0x14				/* MinorLinkerVersion */
+	.long	_edata - _start			/* SizeOfCode */
+	.long	0				/* SizeOfInitializedData */
+	.long	0				/* SizeOfUninitializedData */
+	.long	_start - ImageBase		/* AddressOfEntryPoint */
+	.long	_start - ImageBase		/* BaseOfCode */
+#if __loongarch_grlen != 64
+	.long	0				/* BaseOfData */
+#endif
+
+extra_header_fields:
+	LONG	0
+	.long	0x200				/* SectionAlignment */
+	.long	0x200				/* FileAlignment */
+	.short	0				/* MajorOperatingSystemVersion */
+	.short	0				/* MinorOperatingSystemVersion */
+	.short	1				/* MajorImageVersion */
+	.short	0				/* MinorImageVersion */
+	.short	0				/* MajorSubsystemVersion */
+	.short	0				/* MinorSubsystemVersion */
+	.long	0				/* Win32VersionValue */
+
+	.long	_edata - ImageBase		/* SizeOfImage */
+
+	/*
+	 * Everything before the kernel image is considered part of the header
+	 */
+	.long	_start - ImageBase		/* SizeOfHeaders */
+	.long	0				/* CheckSum */
+	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
+#if CONFIG_VENDOR_EFI
+	.short	0				/* DllCharacteristics */
+#else
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
+#endif
+	LONG	0				/* SizeOfStackReserve */
+	LONG	0				/* SizeOfStackCommit */
+	LONG	0				/* SizeOfHeapReserve */
+	LONG	0				/* SizeOfHeapCommit */
+
+	.long	0				/* LoaderFlags */
+	.long	0x6				/* NumberOfRvaAndSizes */
+
+	.quad	0				/* ExportTable */
+	.quad	0				/* ImportTable */
+	.quad	0				/* ResourceTable */
+	.quad	0				/* ExceptionTable */
+	.quad	0				/* CertificationTable */
+	.quad	0				/* BaseRelocationTable */
+
+	/* Section table */
+section_table:
+
+	/*
+	 * The EFI application loader requires a relocation section
+	 * because EFI applications must be relocatable.  This is a
+	 * dummy section as far as we are concerned.
+	 */
+	.ascii	".reloc"
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	0
+	.long	0
+	.long	0			/* SizeOfRawData */
+	.long	0			/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	.long	0x42100040		/* Characteristics (section flags) */
+
+
+	.ascii	".text"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	_etext - _start		/* VirtualSize */
+	.long	_start - ImageBase	/* VirtualAddress */
+	.long	_etext - _start		/* SizeOfRawData */
+	.long	_start - ImageBase	/* PointerToRawData */
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
+
+	.align		12
+	.globl	_start
+	.type	_start, @function
+_start:
+	PTR_ADDI	sp, sp, -(3 * LONGSIZE)
+	LONG_S		ra, sp, 0
+	LONG_S		a0, sp, (1 * LONGSIZE)
+	LONG_S		a1, sp, (2 * LONGSIZE)
+
+	move		a2, a0		/* a2: ImageHandle */
+	move		a3, a1		/* a3: SystemTable */
+	la.local	a0, ImageBase	/* a0: ImageBase */
+	la.local	a1, _DYNAMIC	/* a1: DynamicSection */
+	bl		_relocate
+	bnez		a0, 0f
+
+	LONG_L		a0, sp, (1 * LONGSIZE)
+	LONG_L		a1, sp, (2 * LONGSIZE)
+	bl		efi_main
+
+0:	LONG_L		ra, sp, 0
+	PTR_ADDI	sp, sp, (3 * LONGSIZE)
+	jr		ra
+	.end	_start
diff --git a/arch/loongarch/lib/elf_loongarch_efi.lds b/arch/loongarch/lib/elf_loongarch_efi.lds
new file mode 100644
index 000000000000..050e5a52a0b3
--- /dev/null
+++ b/arch/loongarch/lib/elf_loongarch_efi.lds
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * U-Boot LoongArch
+ *
+ * Modified from arch/riscv/lib/elf_riscv64_efi.lds
+ */
+
+OUTPUT_ARCH(loongarch)
+
+PHDRS
+{
+	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
+}
+
+ENTRY(_start)
+SECTIONS
+{
+	.text 0x0 : {
+		_text = .;
+		*(.text.head)
+		*(.text)
+		*(.text.*)
+		*(.gnu.linkonce.t.*)
+		*(.srodata)
+		*(.rodata*)
+		. = ALIGN(16);
+		*(.dynamic);
+		. = ALIGN(512);
+	}
+	.rela.dyn : { *(.rela.dyn) }
+	.rela.plt : { *(.rela.plt) }
+	.rela.got : { *(.rela.got) }
+	.rela.data : { *(.rela.data) *(.rela.data*) }
+	_etext = .;
+	_text_size = . - _text;
+	. = ALIGN(4096);
+	.data : {
+		_data = .;
+		*(.sdata)
+		*(.data)
+		*(.data1)
+		*(.data.*)
+		*(.got.plt)
+		*(.got)
+
+		/*
+		 * The EFI loader doesn't seem to like a .bss section, so we
+		 * stick it all into .data:
+		 */
+		. = ALIGN(16);
+		_bss = .;
+		*(.sbss)
+		*(.scommon)
+		*(.dynbss)
+		*(.bss)
+		*(.bss.*)
+		*(COMMON)
+		. = ALIGN(512);
+		_bss_end = .;
+		_edata = .;
+	} :data
+	_data_size = _edata - _data;
+
+	. = ALIGN(4096);
+	.dynsym   : { *(.dynsym) }
+	. = ALIGN(4096);
+	.dynstr   : { *(.dynstr) }
+	. = ALIGN(4096);
+	.note.gnu.build-id : { *(.note.gnu.build-id) }
+	/DISCARD/ : {
+		*(.rel.reloc)
+		*(.eh_frame)
+		*(.note.GNU-stack)
+	}
+	.comment 0 : { *(.comment) }
+}
diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/lib/reloc_loongarch_efi.c
new file mode 100644
index 000000000000..72acfe525c3f
--- /dev/null
+++ b/arch/loongarch/lib/reloc_loongarch_efi.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* reloc_loongarch.c - position independent ELF shared object relocator
+   Copyright (C) 2018 Alexander Graf <agraf@suse.de>
+   Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+   Copyright (C) 1999 Hewlett-Packard Co.
+	Contributed by David Mosberger <davidm@hpl.hp.com>.
+
+    All rights reserved.
+
+    Redistribution and use in source and binary forms, with or without
+    modification, are permitted provided that the following conditions
+    are met:
+
+    * Redistributions of source code must retain the above copyright
+      notice, this list of conditions and the following disclaimer.
+    * Redistributions in binary form must reproduce the above
+      copyright notice, this list of conditions and the following
+      disclaimer in the documentation and/or other materials
+      provided with the distribution.
+    * Neither the name of Hewlett-Packard Co. nor the names of its
+      contributors may be used to endorse or promote products derived
+      from this software without specific prior written permission.
+
+    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+    MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
+    BE LIABLE FOR ANYDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
+    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
+    THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+    SUCH DAMAGE.
+*/
+
+#include <efi.h>
+
+#include <elf.h>
+
+#if __loongarch_grlen == 64
+#define Elf_Dyn		Elf64_Dyn
+#define Elf_Rela	Elf64_Rela
+#define ELF_R_TYPE	ELF64_R_TYPE
+#else
+#define Elf_Dyn		Elf32_Dyn
+#define Elf_Rela	Elf32_Rela
+#define ELF_R_TYPE	ELF32_R_TYPE
+#endif
+
+efi_status_t EFIAPI _relocate(long ldbase, Elf_Dyn *dyn)
+{
+	long relsz = 0, relent = 0;
+	Elf_Rela *rel = 0;
+	unsigned long *addr;
+	int i;
+
+	for (i = 0; dyn[i].d_tag != DT_NULL; ++i) {
+		switch (dyn[i].d_tag) {
+		case DT_RELA:
+			rel = (Elf_Rela *)
+				((unsigned long)dyn[i].d_un.d_ptr
+					+ ldbase);
+			break;
+		case DT_RELASZ:
+			relsz = dyn[i].d_un.d_val;
+			break;
+		case DT_RELAENT:
+			relent = dyn[i].d_un.d_val;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!rel && relent == 0)
+		return EFI_SUCCESS;
+
+	if (!rel || relent == 0)
+		return EFI_LOAD_ERROR;
+
+	while (relsz > 0) {
+		/* apply the relocs */
+		switch (ELF_R_TYPE(rel->r_info)) {
+		case R_LARCH_NONE:
+			break;
+		case R_LARCH_RELATIVE:
+			addr = (unsigned long *)
+				(ldbase + rel->r_offset);
+			*addr = ldbase + rel->r_addend;
+			break;
+		default:
+			break;
+		}
+		rel = (Elf_Rela *)((char *)rel + relent);
+		relsz -= relent;
+	}
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c4b0c2137b87..6a417e75bf46 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -7,7 +7,7 @@ config EFI_LOADER
 			SYS_CPU = arm1176 || \
 			SYS_CPU = armv7   || \
 			SYS_CPU = armv8)  || \
-		X86 || RISCV || SANDBOX)
+		X86 || RISCV || LOONGARCH || SANDBOX)
 	# We have not fully removed the requirement for some block device
 	depends on BLK
 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bc48e265b901..641b001a9a16 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -44,6 +44,9 @@
 #elif HOST_ARCH == HOST_ARCH_RISCV64
 #define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
 #define HOST_PXE_ARCH 0x1b
+#elif HOST_ARCH == HOST_ARCH_LOONGARCH64
+#define HOST_BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
+#define HOST_PXE_ARCH 0x27
 #else
 #error Unsupported Host architecture
 #endif
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index bed5f1817266..612e0cfec2ce 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -19,6 +19,7 @@
 #include <crypto/mscode.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
+#include <linux/bitfield.h>
 
 const efi_guid_t efi_global_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 const efi_guid_t efi_guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
@@ -231,6 +232,38 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 					return EFI_LOAD_ERROR;
 				}
 				break;
+#elif defined(__loongarch__) && __loongarch_grlen == 64
+			case IMAGE_REL_BASED_LOONGARCH64_MARK_LA: {
+				uint64_t tmp;
+
+				if (virt_size - offset < 16) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
+
+				/*
+				 * Apply an offset to a 64-bit immediate loaded
+				 * by four instructions, lu12i.w, ori, lu32i.d,
+				 * and lu52i.d.
+				 */
+				tmp = FIELD_GET(GENMASK(24, 5), x32[0]) << 12;
+				tmp |= FIELD_GET(GENMASK(21, 10), x32[1]);
+				tmp |= FIELD_GET(GENMASK(24, 5), x32[2]) << 32;
+				tmp |= FIELD_GET(GENMASK(21, 10), x32[3]) << 52;
+				tmp += (uint64_t)delta;
+
+				x32[0] &= ~GENMASK(24, 5);
+				x32[0] |= FIELD_PREP(GENMASK(24, 5), tmp >> 12);
+				x32[1] &= ~GENMASK(21, 10);
+				x32[1] |= FIELD_PREP(GENMASK(21, 10), tmp);
+				x32[2] &= ~GENMASK(24, 5);
+				x32[2] |= FIELD_PREP(GENMASK(24, 5), tmp >> 32);
+				x32[3] &= ~GENMASK(21, 10);
+				x32[3] |= FIELD_PREP(GENMASK(21, 10),
+						     tmp >> 52);
+
+				break;
+			}
 #endif
 			default:
 				log_err("Unknown Relocation off %lx type %x\n",
-- 
2.56.0

