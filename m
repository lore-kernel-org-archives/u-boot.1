Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3023C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2042480834;
	Sun,  9 Feb 2025 03:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DbG3NTuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07AA80BB0; Sun,  9 Feb 2025 03:02:25 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581D480834
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so10484855ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066537; x=1739671337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6astdDW8m2lSaezuUzKbMAaBlnoRApCgy1E0PqPpSsc=;
 b=DbG3NTuhixijxbNtxhNGtwlp3GEoVGsfOdQdHey+KsIO5cdm9odNtQTVFtAoF6rs8v
 d5AoeyMUSAkPtwf+OiVSUgXNk/tj3ZHBMIOnx5RzqSjgSXM0FfnWVX/iEMY+Wnp24cK8
 fg0xrd14lRvwIXDH2j0TpNEmKr7bNrblvfBbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066537; x=1739671337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6astdDW8m2lSaezuUzKbMAaBlnoRApCgy1E0PqPpSsc=;
 b=gBSUjSbDt1HtDIfmAxl3Y/ICzGOv2/OM1YC1FgnXmd2IUTjyjUn7WDJZmWXKGyB90U
 Qgc1wnaTmi8nzH0mFl68QXDg5O1zUJ4tN7yF4/CaNcoFx7UtgTyXy39jqLNCosvW2MJo
 5xF/5CFXvjZMnVluW91t1+CJ5joOexOXvY5cYgH/4zarmuKcAv1+POgIP7I71o42qyS3
 WEwcO3HM6U64Pr47z7gdetbinI1KsX1OMP+4owa6KntpEKaVLRW6gVw1jAFkjOhUJaXr
 cjyHsdLCTIhsHXUAwCxOZkQVY1XTtTGpjToImmlg4XiYjuPjqcRrhGZPfykq8Do/AoxJ
 MSNQ==
X-Gm-Message-State: AOJu0Yy9qlwt07WRR12KCAFNOV7VX30XcQJci28ofIfHuTv2FPOB4XmE
 3UhphVmjyGWXzLlwCND7WSDqaB/KfVuIue4XqArGZZryTKS4/4QORSxyk5havd5kB9nigYsu6AU
 =
X-Gm-Gg: ASbGncuAqL/TncxguqsGsDtHa9bFvbta/WRowmdUBf7whOe/fZOthtoGuJJz1JVAdZ1
 5DVLBGynWj8F9dL3KZPO/FA7ISG2teLdU0mnR1/pIJCotNIOyDW28SIgCSxkrT6XhhhmjCUQ62c
 U4fBidY0zOVA2W2VXbFKuJE2/8LTdmBOK3jh46r+nwJ8jUwArp81rfnJUNZQOmrT9dJHGI11OZ0
 oLdQ7oeV27oHyBWfnt38WsTMQRb5GBOQ3bjNkjV1fb1+yWL/20LFZxmQ7u3m3HZHAZ2MTKyLB/p
 csogCOGQImlBZ86rTRAke6CCQ0+p/+jve7b8kFIcCBoDu2b6BrK/
X-Google-Smtp-Source: AGHT+IFFC9dgYGwrcWipq1u78ZcR/JaTQz5YXFp1nGvrZcvmGeogNh7bVXK1/KdhqhtTTiEoXyjqGQ==
X-Received: by 2002:a05:6e02:1c86:b0:3cf:c82f:586c with SMTP id
 e9e14a558f8ab-3d13dcde651mr76286605ab.4.1739066536653; 
 Sat, 08 Feb 2025 18:02:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/29] efi: Rename ImageBase to image_base
Date: Sat,  8 Feb 2025 19:01:11 -0700
Message-ID: <20250209020136.4108987-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

It is confusing to have a camel-case indentifier in the these files.
Rename them to fit with U-Boot's snake-case style.

The image_base symbol is already used in the x86 link-scripts.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rework the commit message to clarify the relationship to link-scripts

 arch/arm/lib/crt0_aarch64_efi.S | 26 +++++++++++++-------------
 arch/riscv/lib/crt0_riscv_efi.S | 28 ++++++++++++++--------------
 include/asm-generic/sections.h  |  2 ++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index f1d5de6a93d..c1030e5392a 100644
--- a/arch/arm/lib/crt0_aarch64_efi.S
+++ b/arch/arm/lib/crt0_aarch64_efi.S
@@ -15,12 +15,12 @@
 	/*
 	 * Magic "MZ" signature for PE/COFF
 	 */
-	.globl	ImageBase
-ImageBase:
+	.globl	image_base
+image_base:
 	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
 	.skip	54				/* 'MZ' + pad + offset == 64 */
 	.long   LINUX_ARM64_MAGIC		/* For GRUB's linux command */
-	.long	pe_header - ImageBase		/* Offset to the PE header */
+	.long	pe_header - image_base		/* Offset to the PE header */
 pe_header:
 	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
 coff_header:
@@ -43,11 +43,11 @@ optional_header:
 	.long	_etext - _start			/* SizeOfCode */
 	.long	0				/* SizeOfInitializedData */
 	.long	0				/* SizeOfUninitializedData */
-	.long	_start - ImageBase		/* AddressOfEntryPoint */
-	.long	_start - ImageBase		/* BaseOfCode */
+	.long	_start - image_base		/* AddressOfEntryPoint */
+	.long	_start - image_base		/* BaseOfCode */
 
 extra_header_fields:
-	.quad	0				/* ImageBase */
+	.quad	0				/* image_base */
 	.long	0x1000				/* SectionAlignment */
 	.long	0x200				/* FileAlignment */
 	.short	0				/* MajorOperatingSystemVersion */
@@ -58,12 +58,12 @@ extra_header_fields:
 	.short	0				/* MinorSubsystemVersion */
 	.long	0				/* Win32VersionValue */
 
-	.long	_edata - ImageBase		/* SizeOfImage */
+	.long	_edata - image_base		/* SizeOfImage */
 
 	/*
 	 * Everything before the kernel image is considered part of the header
 	 */
-	.long	_start - ImageBase		/* SizeOfHeaders */
+	.long	_start - image_base		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
 #if CONFIG_ARCH_EFI
@@ -114,9 +114,9 @@ section_table:
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
 	.long	_etext - _start		/* VirtualSize */
-	.long	_start - ImageBase	/* VirtualAddress */
+	.long	_start - image_base	/* VirtualAddress */
 	.long	_etext - _start		/* SizeOfRawData */
-	.long	_start - ImageBase	/* PointerToRawData */
+	.long	_start - image_base	/* PointerToRawData */
 	.long	0			/* PointerToRelocations */
 	.long	0			/* PointerToLineNumbers */
 	.short	0			/* NumberOfRelocations */
@@ -131,9 +131,9 @@ section_table:
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
 	.long	_data_size		/* VirtualSize */
-	.long	_data - ImageBase	/* VirtualAddress */
+	.long	_data - image_base	/* VirtualAddress */
 	.long	_data_size		/* SizeOfRawData */
-	.long	_data - ImageBase	/* PointerToRawData */
+	.long	_data - image_base	/* PointerToRawData */
 	.long	0			/* PointerToRelocations */
 	.long	0			/* PointerToLineNumbers */
 	.short	0			/* NumberOfRelocations */
@@ -149,7 +149,7 @@ _start:
 	mov		x29, sp
 
 	stp		x0, x1, [sp, #16]
-	adr		x0, ImageBase
+	adr		x0, image_base
 	adrp		x1, _DYNAMIC
 	add		x1, x1, #:lo12:_DYNAMIC
 	bl		_relocate
diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index 424f18480fa..909d9e793d3 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -41,14 +41,14 @@
 	/*
 	 * Magic "MZ" signature for PE/COFF
 	 */
-	.globl	ImageBase
-ImageBase:
+	.globl	image_base
+image_base:
 	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
 	.skip	46				/* 'MZ' + pad + offset == 64 */
 	.long	0x43534952			/* Linux magic "RISCV */
 	.long	0x00000056
 	.long	0x05435352			/* Linux magic2 "RSC\x05*/
-	.long	pe_header - ImageBase		/* Offset to the PE header */
+	.long	pe_header - image_base		/* Offset to the PE header */
 pe_header:
 	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
 coff_header:
@@ -66,17 +66,17 @@ optional_header:
 	.long	_edata - _start			/* SizeOfCode */
 	.long	0				/* SizeOfInitializedData */
 	.long	0				/* SizeOfUninitializedData */
-	.long	_start - ImageBase		/* AddressOfEntryPoint */
-	.long	_start - ImageBase		/* BaseOfCode */
+	.long	_start - image_base		/* AddressOfEntryPoint */
+	.long	_start - image_base		/* BaseOfCode */
 #if __riscv_xlen == 32
 	.long	0				/* BaseOfData */
 #endif
 
 extra_header_fields:
 #if __riscv_xlen == 32
-	.long	0				/* ImageBase */
+	.long	0				/* image_base */
 #else
-	.quad	0				/* ImageBase */
+	.quad	0				/* image_base */
 #endif
 	.long	0x200				/* SectionAlignment */
 	.long	0x200				/* FileAlignment */
@@ -88,12 +88,12 @@ extra_header_fields:
 	.short	0				/* MinorSubsystemVersion */
 	.long	0				/* Win32VersionValue */
 
-	.long	_edata - ImageBase		/* SizeOfImage */
+	.long	_edata - image_base		/* SizeOfImage */
 
 	/*
 	 * Everything before the kernel image is considered part of the header
 	 */
-	.long	_start - ImageBase		/* SizeOfHeaders */
+	.long	_start - image_base		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
 #if CONFIG_ARCH_EFI
@@ -149,9 +149,9 @@ section_table:
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
 	.long	_etext - _start		/* VirtualSize */
-	.long	_start - ImageBase	/* VirtualAddress */
+	.long	_start - image_base	/* VirtualAddress */
 	.long	_etext - _start		/* SizeOfRawData */
-	.long	_start - ImageBase	/* PointerToRawData */
+	.long	_start - image_base	/* PointerToRawData */
 	.long	0			/* PointerToRelocations (0 for executables) */
 	.long	0			/* PointerToLineNumbers (0 for executables) */
 	.short	0			/* NumberOfRelocations  (0 for executables) */
@@ -166,9 +166,9 @@ section_table:
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
 	.long	_edata - _data		/* VirtualSize */
-	.long	_data - ImageBase	/* VirtualAddress */
+	.long	_data - image_base	/* VirtualAddress */
 	.long	_edata - _data		/* SizeOfRawData */
-	.long	_data - ImageBase	/* PointerToRawData */
+	.long	_data - image_base	/* PointerToRawData */
 	.long	0			/* PointerToRelocations */
 	.long	0			/* PointerToLineNumbers */
 	.short	0			/* NumberOfRelocations */
@@ -185,7 +185,7 @@ _start:
 	SAVE_LONG(a1, 1)
 	SAVE_LONG(ra, 2)
 
-	lla		a0, ImageBase
+	lla		a0, image_base
 	lla		a1, _DYNAMIC
 	call		_relocate
 	bne		a0, zero, 0f
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 5b040d0acd0..606fce65adc 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -72,6 +72,8 @@ extern char __rel_dyn_start[], __rel_dyn_end[];
 extern char _image_binary_end[];
 extern char __dtb[];
 
+extern char image_base[];
+
 /*
  * This is the U-Boot entry point - prior to relocation it should be same
  * as __text_start
-- 
2.43.0

