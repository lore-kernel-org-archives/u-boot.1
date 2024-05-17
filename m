Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216A5C25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014DA884B8;
	Fri, 17 May 2024 18:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ga6+46KC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8DQ4hSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0572B884BB; Fri, 17 May 2024 18:33:10 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D6708849A
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 8771311400BC;
 Fri, 17 May 2024 12:33:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 17 May 2024 12:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963586;
 x=1716049986; bh=w7CFEDUWIlfnXhQ5GwSoh+u96070taVKsd0buZD+RyM=; b=
 ga6+46KC7U4p5vV0I8Y2BCVFkGB4teW4nB04xBGvhPm0IFvk4PjvEQ2au3G/ubpJ
 Mb7+72NjRmexUASk3weVdzNjCyiMT6iTlbY4fE7U1OVIM31ywC0IeVRjI93FA7iv
 DXXzMyevEn9I1xLOYmbUplkRT6SQp+bnpn5JVSBzJV9PQvo7acPoQ9l0oeLNbKaL
 ZWPqzTxqisuGnvt1kqDeh5fZJf2SjASBsjmJjFnj4Q7QEH4rzf7HrJuyQ0di8BRz
 VsENlB9kVGo3V+bkGMdqo1jQTrVBxxRxwzM2KJLpEyvQzsf3ATb55QvzlSHp+OTX
 e2phtO+/oKgBRWdhOf6CUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963586; x=
 1716049986; bh=w7CFEDUWIlfnXhQ5GwSoh+u96070taVKsd0buZD+RyM=; b=h
 8DQ4hSu0bLUHt8x8zH2m0GSjWqzL34ZsgJb42YMadK3GjmnmUdx0tIQs90BPDK4C
 HnJU44t/ydCoj+DIDN8e6PsifjMwICa8b91YVPCUKt+FnPUGGW1RLFEd0bDioGBu
 lyFErSa42LivJzQgAab7et4vTiFpbiuiVwp3ji3awYl68Vl2HHo2kIyCp2moqtsj
 x8F9H/N8Vq84HWqeKaE3taUKd5uyvqu9s954ceSC4eCZEdAINQTkZnaT8+f5kPm1
 vIwlzazLQHfL4nF/e+/Mjy9/O0TYP5M2jveLQgZynypkuPhjcECumVLoOT96bkFs
 fLrfIdq0s4AD6ftu8Nqkg==
X-ME-Sender: <xms:woZHZlj0-YEXV-7XsCCXTtUYyj3f0kocuRfFcylnJVwR9SPqLTK5sw>
 <xme:woZHZqA1CsJmjiXfeyA_JvX4VQK5AKAvisxesq_7h-ZnR0E8rO5sk5WDZYUBSVEFs
 3ZPOaQoXGYluZT1rNg>
X-ME-Received: <xmr:woZHZlHtZvHlWWDXW9NE40UyfxEW6KqUdVKDwmzA461ARdfHaHjX7jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnheptefhheevtedvudfggeekledtgedtjeetfffhfeejfeetleeu
 leeffeelgefggeeinecuffhomhgrihhnpegtrhhttdgpmhhiphhspggvfhhirdhssgdpgh
 hnuhdrsghuihhlugdprhgvlhhotgdrvghhnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homh
X-ME-Proxy: <xmx:woZHZqQ9mYtbzenLHbwcT-sTOXxW8ngHWDl3Fy87qgKH7N8EfDb7IQ>
 <xmx:woZHZixbFGWgKJPTFOjShozA79Ikvsq-b7DADREU0QEWa15HsfPX4g>
 <xmx:woZHZg72CglOLtHJIkqMlGzedWdVQlrQajjEEnJGO1u_LLUXZrRPgw>
 <xmx:woZHZnzpQB5ufqWU7LkXOpYE3ZaIP0vN1AZJSWqrmPfFUsso1P3t6w>
 <xmx:woZHZpkfrVcU1hoMUcmrVHcsmZUETbJikPd0VUZoc9oYKnmYuPw1e0Kt>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:33:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:58 +0100
Subject: [PATCH 7/7] MIPS: Implement EFI supporting stuff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-7-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14895;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=mANS4VleiiND1XBzHzPNvA/oOFn4q3LYs3NEsMzfR/c=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th21XZuvtBVW7KznYHmw/VSwSWp1yuOVq1QWCFt5x
 q7ec+NjRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEyk7AvDP83rk2PUeqtnvNoh
 sv1xVeOZc5+YNK8/cVSKmHU9dY7DsxSG/8HVsltb16VdF5b4yFUcmn5k4rOYCqOEGVczP3Ibdn9
 t4AIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Implemented crt, ELF and EFI linking, ELF relocation handling
and other necessary bits for MIPS EFI.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/config.mk            |   9 ++
 arch/mips/lib/Makefile         |  13 +++
 arch/mips/lib/crt0_mips_efi.S  | 239 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/lib/elf_mips_efi.lds | 113 +++++++++++++++++++
 arch/mips/lib/reloc_mips_efi.c |  99 +++++++++++++++++
 lib/efi_loader/Kconfig         |   2 +-
 6 files changed, 474 insertions(+), 1 deletion(-)

diff --git a/arch/mips/config.mk b/arch/mips/config.mk
index 745f03190e98..e970858c1e59 100644
--- a/arch/mips/config.mk
+++ b/arch/mips/config.mk
@@ -36,6 +36,10 @@ endif
 PLATFORM_CPPFLAGS += -D__MIPS__
 PLATFORM_ELFFLAGS += -B mips $(OBJCOPYFLAGS)
 
+EFI_LDS				:= elf_mips_efi.lds
+EFI_CRT0			:= crt0_mips_efi.o
+EFI_RELOC			:= reloc_mips_efi.o
+
 #
 # From Linux arch/mips/Makefile
 #
@@ -66,3 +70,8 @@ LDFLAGS_FINAL			+= --gc-sections
 OBJCOPYFLAGS			+= -j .text -j .rodata -j .data -j __u_boot_list
 
 LDFLAGS_STANDALONE		+= --gc-sections
+
+CFLAGS_EFI := -fPIE -mabicalls
+AFLAGS_EFI := -fPIE -mabicalls
+CFLAGS_NON_EFI := -mno-abicalls -fno-pic -fno-PIE
+AFLAGS_NON_EFI := -mno-abicalls -fno-pic -fno-PIE
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index e36dfd0547b5..eef663febe47 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -17,3 +17,16 @@ obj-$(CONFIG_CMD_GO) += boot.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
 
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o udivdi3.o
+
+# For building EFI apps
+CFLAGS_$(EFI_CRT0) := $(CFLAGS_EFI)
+CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
+AFLAGS_$(EFI_CRT0) := $(CFLAGS_EFI)
+AFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
+
+CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
+CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
+
+extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
+extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
+extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
diff --git a/arch/mips/lib/crt0_mips_efi.S b/arch/mips/lib/crt0_mips_efi.S
new file mode 100644
index 000000000000..84acee620d14
--- /dev/null
+++ b/arch/mips/lib/crt0_mips_efi.S
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * crt0-efi-mips64el.S - PE/COFF header for MIPS64 EFI applications
+ *
+ * Copright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ * Copright (C) 2017 Heiher <r@hev.cc>
+ * Copright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm/asm.h>
+#include <asm-generic/pe.h>
+
+#if __mips == 64
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define PE_MACHINE	IMAGE_FILE_MACHINE_R4000
+#else
+#define PE_MACHINE	IMAGE_FILE_MACHINE_R4000_BE
+#endif
+#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR64_MAGIC
+#define IMG_CHARACTERISTICS \
+	(IMAGE_FILE_EXECUTABLE_IMAGE | \
+	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
+	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
+	 IMAGE_FILE_LARGE_ADDRESS_AWARE | \
+	 IMAGE_FILE_DEBUG_STRIPPED)
+#else
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define PE_MACHINE	IMAGE_FILE_MACHINE_R3000
+#else
+#define PE_MACHINE	IMAGE_FILE_MACHINE_R3000_BE
+#endif
+#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR32_MAGIC
+#define IMG_CHARACTERISTICS \
+	(IMAGE_FILE_EXECUTABLE_IMAGE | \
+	 IMAGE_FILE_LINE_NUMS_STRIPPED | \
+	 IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
+	 IMAGE_FILE_DEBUG_STRIPPED)
+#endif
+
+
+	.section	.text.head
+
+	/*
+	 * Magic "MZ" signature for PE/COFF
+	 */
+	.globl	ImageBase
+ImageBase:
+	.2byte	IMAGE_DOS_SIGNATURE		/* 'MZ' */
+	.skip	58				/* 'MZ' + pad + offset == 64 */
+	.4byte	pe_header - ImageBase		/* Offset to the PE header */
+pe_header:
+	.4byte	IMAGE_NT_SIGNATURE		/* 'PE' */
+coff_header:
+	.2byte	PE_MACHINE			/* Machine Magic */
+	.2byte	3				/* nr_sections */
+	.4byte	0 				/* TimeDateStamp */
+	.4byte	0				/* PointerToSymbolTable */
+	.4byte	0				/* NumberOfSymbols */
+	.2byte	section_table - optional_header	/* SizeOfOptionalHeader */
+	.2byte	IMG_CHARACTERISTICS		/* Characteristics */
+
+optional_header:
+	.2byte	PE_MAGIC			/* PE32(+) format */
+	.byte	0x02				/* MajorLinkerVersion */
+	.byte	0x14				/* MinorLinkerVersion */
+	.4byte	_edata - _start			/* SizeOfCode */
+	.4byte	0				/* SizeOfInitializedData */
+	.4byte	0				/* SizeOfUninitializedData */
+	.4byte	_start - ImageBase		/* AddressOfEntryPoint */
+	.4byte	_start - ImageBase		/* BaseOfCode */
+#if __mips != 64
+	.4byte	0				/* BaseOfData */
+#endif
+
+extra_header_fields:
+#if __mips == 64
+	.8byte	0				/* ImageBase */
+#else
+	.4byte	0				/* ImageBase */
+#endif
+	.4byte	0x20				/* SectionAlignment */
+	.4byte	0x8				/* FileAlignment */
+	.2byte	0				/* MajorOperatingSystemVersion */
+	.2byte	0				/* MinorOperatingSystemVersion */
+	.2byte	1				/* MajorImageVersion */
+	.2byte	0				/* MinorImageVersion */
+	.2byte	0				/* MajorSubsystemVersion */
+	.2byte	0				/* MinorSubsystemVersion */
+	.4byte	0				/* Win32VersionValue */
+
+	.4byte	_edata - ImageBase		/* SizeOfImage */
+
+	/*
+	 * Everything before the kernel image is considered part of the header
+	 */
+	.4byte	_start - ImageBase		/* SizeOfHeaders */
+	.4byte	0				/* CheckSum */
+	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
+#if CONFIG_VENDOR_EFI
+	.short	0				/* DllCharacteristics */
+#else
+	.short	IMAGE_DLLCHARACTERISTICS_NX_COMPAT
+#endif
+#if __mips == 64
+	.8byte	0				/* SizeOfStackReserve */
+	.8byte	0				/* SizeOfStackCommit */
+	.8byte	0				/* SizeOfHeapReserve */
+	.8byte	0				/* SizeOfHeapCommit */
+#else
+	.4byte	0				/* SizeOfStackReserve */
+	.4byte	0				/* SizeOfStackCommit */
+	.4byte	0				/* SizeOfHeapReserve */
+	.4byte	0				/* SizeOfHeapCommit */
+#endif
+	.4byte	0				/* LoaderFlags */
+	.4byte	0x6				/* LoaderFlags */
+
+	.4byte	0				/* ExportTable */
+	.4byte	0				/* ImportTable */
+	.4byte	0				/* ResourceTable */
+	.4byte	0				/* ExceptionTable */
+	.4byte	0				/* CertificationTable */
+	.4byte	0				/* BaseRelocationTable */
+
+	// Section table
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
+	.4byte	0
+	.4byte	0
+	.4byte	0			/* SizeOfRawData */
+	.4byte	0			/* PointerToRawData */
+	.4byte	0			/* PointerToRelocations */
+	.4byte	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	.4byte	0x42100040		/* Characteristics (section flags) */
+
+	.ascii	".text"
+	.byte	0
+	.byte	0
+	.byte	0        		/* end of 0 padding of section name */
+	.4byte	_etext - _start		/* VirtualSize */
+	.4byte	_start - ImageBase	/* VirtualAddress */
+	.4byte	_etext - _start		/* SizeOfRawData */
+	.4byte	_start - ImageBase	/* PointerToRawData */
+
+	.4byte	0			/* PointerToRelocations (0 for executables) */
+	.4byte	0			/* PointerToLineNumbers (0 for executables) */
+	.2byte	0			/* NumberOfRelocations  (0 for executables) */
+	.2byte	0			/* NumberOfLineNumbers  (0 for executables) */
+	/* Characteristics (section flags) */
+	.4byte	(IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_MEM_EXECUTE | \
+		 IMAGE_SCN_CNT_CODE)
+
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.4byte	_data_size		/* VirtualSize */
+	.4byte	_etext - ImageBase	/* VirtualAddress */
+	.4byte	_data_size		/* SizeOfRawData */
+	.4byte	_etext - ImageBase	/* PointerToRawData */
+	.4byte	0			/* PointerToRelocations */
+	.4byte	0			/* PointerToLineNumbers */
+	.2byte	0			/* NumberOfRelocations */
+	.2byte	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.4byte	(IMAGE_SCN_MEM_WRITE | \
+		 IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_CNT_INITIALIZED_DATA)
+
+	.align		4
+
+	.globl	_start
+	.ent	_start
+	.type	_start, @function
+_start:
+	LONG_ADDIU	$sp, -(LONGSIZE * 4)
+	LONG_S		$ra, ($sp)
+
+	// Get pc & gp
+	.set		push
+	.set		noreorder
+	.align		LONGLOG
+	bal		1f
+	LONG_S		$gp, (1 * LONGSIZE)($sp)	/* Delay slot */
+_pc:
+	PTR		_gp
+	PTR		_DYNAMIC
+	PTR		_relocate
+1:
+	.set		pop
+	// pc in ra
+	PTR_L		$gp, ($ra)
+	PTR_LI		$t0, _pc
+	PTR_SUBU	$gp, $t0
+	PTR_ADDU	$gp, $ra
+
+	LONG_S		$a0, (2 * LONGSIZE)($sp)
+	LONG_S		$a1, (3 * LONGSIZE)($sp)
+
+	/* a0: ImageBase */
+	PTR_LI		$t1, ImageBase - _pc
+	PTR_ADDU	$a0, $ra, $t1
+	/* a1: DynamicSection */
+	PTR_L		$t1, (1 * PTRSIZE)($ra)
+	PTR_SUBU	$t1, $t0
+	PTR_ADDU	$a1, $ra, $t1
+	/* call _relocate */
+	PTR_L		$t1, (2 * PTRSIZE)($ra)
+	PTR_SUBU	$t1, $t0
+	PTR_ADDU	$t9, $ra, $t1
+	jalr		$t9
+	/* Return early */
+	bnez		$v0, 1b
+
+	/* a0: ImageHandle */
+	LONG_L		$a0, (2 * LONGSIZE)($sp)
+	/* a1: SystemTable */
+	LONG_L		$a1, (3 * LONGSIZE)($sp)
+	/* Load the entry point */
+	PTR_LA		$t9, efi_main
+	jalr		$t9
+
+1:
+	LONG_L		$gp, (1 * LONGSIZE)($sp)
+	LONG_L		$ra, ($sp)
+	LONG_ADDIU	$sp, (LONGSIZE * 4)
+	jr		$ra
+.end		_start
diff --git a/arch/mips/lib/elf_mips_efi.lds b/arch/mips/lib/elf_mips_efi.lds
new file mode 100644
index 000000000000..31039c3d4843
--- /dev/null
+++ b/arch/mips/lib/elf_mips_efi.lds
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * U-Boot MIPS EFI linker script
+ *
+ * Modified from elf_mips64el_efi.lds in gnu-efi
+ */
+
+OUTPUT_ARCH(mips)
+ENTRY(_start)
+
+SECTIONS
+{
+  .text 0x0 : {
+    _text = .;
+    *(.text.head)
+    *(.text)
+    *(.text.*)
+    *(.gnu.linkonce.t.*)
+    *(.plt)
+    . = ALIGN(16);
+  }
+  _etext = .;
+  _text_size = _etext - _text;
+  . = DATA_SEGMENT_ALIGN (CONSTANT (MAXPAGESIZE), CONSTANT (COMMONPAGESIZE));
+  .dynamic  : { *(.dynamic) }
+  . = ALIGN(4096);
+  .data :
+  {
+   _data = .;
+   *(.sdata)
+   *(.data)
+   *(.data1)
+   *(.data.*)
+   *(.got.plt)
+   HIDDEN (_gp = ALIGN (16) + 0x7ff0);
+   *(.got)
+
+   /*
+    * Note that these aren't the using the GNU "CONSTRUCTOR" output section
+    * command, so they don't start with a size.  Because of p2align and the
+    * end/END definitions, and the fact that they're mergeable, they can also
+    * have NULLs which aren't guaranteed to be at the end.
+    */
+   . = ALIGN(16);
+   __init_array_start = .;
+   *(SORT(.init_array.*))
+   *(.init_array)
+   __init_array_end = .;
+  . = ALIGN(16);
+   __CTOR_LIST__ = .;
+   *(SORT(.ctors.*))
+   *(.ctors)
+   __CTOR_END__ = .;
+  . = ALIGN(16);
+   __DTOR_LIST__ = .;
+   *(SORT(.dtors.*))
+   *(.dtors)
+   __DTOR_END__ = .;
+   . = ALIGN(16);
+   __fini_array_start = .;
+   *(SORT(.fini_array.*))
+   *(.fini_array)
+   __fini_array_end = .;
+
+   /* the EFI loader doesn't seem to like a .bss section, so we stick
+      it all into .data: */
+   . = ALIGN(16);
+   _bss = .;
+   *(.sbss)
+   *(.scommon)
+   *(.dynbss)
+   *(.bss*)
+   *(COMMON)
+   . = ALIGN(16);
+   _bss_end = .;
+  }
+
+  . = ALIGN(4096);
+  .rel :
+  {
+    *(.rel.text*)
+    *(.rel.data*)
+    *(.rel.got)
+    *(.rel.dyn)
+    *(.rel.stab)
+    *(.rel.init_array*)
+    *(.rel.fini_array*)
+    *(.rel.ctors*)
+    *(.rel.dtors*)
+  }
+  . = ALIGN(4096);
+  .rel.plt : { *(.rel.plt) }
+  . = ALIGN(4096);
+  .rodata : { *(.rodata*) }
+  _edata = .;
+  _data_size = _edata - _etext;
+
+  . = ALIGN(4096);
+  .dynsym   : { *(.dynsym) }
+  . = ALIGN(4096);
+  .dynstr   : { *(.dynstr) }
+  . = ALIGN(4096);
+  .note.gnu.build-id : { *(.note.gnu.build-id) }
+  . = DATA_SEGMENT_END (.);
+  /DISCARD/ :
+  {
+    *(.rel.reloc)
+    *(.eh_frame)
+    *(.MIPS.abiflags)
+    *(.note.GNU-stack)
+  }
+  .comment 0 : { *(.comment) }
+}
diff --git a/arch/mips/lib/reloc_mips_efi.c b/arch/mips/lib/reloc_mips_efi.c
new file mode 100644
index 000000000000..ee4f95d9e783
--- /dev/null
+++ b/arch/mips/lib/reloc_mips_efi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * reloc_mips64el.c - position independent MIPS64 ELF shared object relocator
+ *
+ * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (C) 1999 Hewlett-Packard Co.
+ *   Contributed by David Mosberger <davidm@hpl.hp.com>.
+ * Copyright (C) 2017 Lemote Co.
+ *   Contributed by Heiher <r@hev.cc>
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <efi.h>
+#include <elf.h>
+
+#include <asm/byteorder.h>
+
+#if __mips == 64
+#define Elf_Dyn		Elf64_Dyn
+#define Elf_Rel		Elf64_Rel
+#define ELF_R_TYPE	ELF64_R_TYPE
+#define R_MIPS_RELATIVE	((R_MIPS_64 << 8) | R_MIPS_REL32)
+#define swabl(x)	swab64(x)
+#else
+#define Elf_Dyn		Elf32_Dyn
+#define Elf_Rel		Elf32_Rel
+#define ELF_R_TYPE	ELF32_R_TYPE
+#define R_MIPS_RELATIVE	R_MIPS_REL32
+#define swabl(x)	swab32(x)
+#endif
+
+efi_status_t EFIAPI _relocate(long ldbase, Elf_Dyn *dyn)
+{
+	long relsz = 0, relent = 0, gotsz = 0;
+	Elf_Rel *rel = 0;
+	unsigned long *addr = 0;
+	int i;
+
+	for (i = 0; dyn[i].d_tag != DT_NULL; ++i) {
+		switch (dyn[i].d_tag) {
+		case DT_REL:
+			rel = (Elf_Rel *)
+				((unsigned long)dyn[i].d_un.d_ptr
+					+ ldbase);
+			break;
+
+		case DT_RELSZ:
+			relsz = dyn[i].d_un.d_val;
+			break;
+
+		case DT_RELENT:
+			relent = dyn[i].d_un.d_val;
+			break;
+
+		case DT_PLTGOT:
+			addr = (unsigned long *)
+				((unsigned long)dyn[i].d_un.d_ptr
+					+ ldbase);
+			break;
+
+		case DT_MIPS_LOCAL_GOTNO:
+			gotsz = dyn[i].d_un.d_val;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	if ((!rel && relent == 0) && (!addr && gotsz == 0))
+		return EFI_SUCCESS;
+
+	if ((!rel && relent != 0) || (!addr && gotsz != 0))
+		return EFI_LOAD_ERROR;
+
+	while (gotsz > 0) {
+		*addr += ldbase;
+		addr += 1;
+		gotsz--;
+	}
+
+	while (relsz > 0) {
+		/* apply the relocs */
+		switch (ELF_R_TYPE(swabl(rel->r_info))) {
+		case R_MIPS_NONE:
+			break;
+		case R_MIPS_RELATIVE:
+			addr = (unsigned long *)(ldbase + rel->r_offset);
+			*addr += ldbase;
+			break;
+		default:
+			break;
+		}
+		rel = (Elf_Rel *)((char *) rel + relent);
+		relsz -= relent;
+	}
+
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index bc5ae9086ea2..a9b006fa6d24 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -5,7 +5,7 @@ config EFI_LOADER
 			SYS_CPU = arm1176 || \
 			SYS_CPU = armv7   || \
 			SYS_CPU = armv8)  || \
-		X86 || RISCV || SANDBOX)
+		X86 || RISCV || MIPS || SANDBOX)
 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB

-- 
2.34.1

