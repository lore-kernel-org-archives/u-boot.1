Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD36CC02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79CF480F68;
	Sat, 15 Feb 2025 04:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XNM+L0ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955C580B98; Sat, 15 Feb 2025 04:23:45 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F48580F3F
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d03ac846a7so8701165ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589821; x=1740194621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eB3pfGKuwO2gKh6lTMxj7rF0g2TMFwptn3IAZFUVfsA=;
 b=XNM+L0ueUXojQIH11xT02ofK3OQtIkgOyi3eGSQcYoiofOKkPdAgt1Q8H8YOcJZ9KW
 i21NfLLRSbK1EYzWYS//zaZdYUfZhTScjot7to9KnO0SAL/4r/NdyMc6lEMZzShN++da
 YAQq+bfajz6tTSySto82k6bDf4RHypAcfjQPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589821; x=1740194621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eB3pfGKuwO2gKh6lTMxj7rF0g2TMFwptn3IAZFUVfsA=;
 b=rDJFSBQz1jRE2l5MboR8RkyvvQtGaIzhl16lljau514PeCXxphvWey9jfI0bgHZs+D
 xIyaCQs5Rwf1ZZD171hCRQB+O3rDuB5WH3Q8qM8jjLKgtMf4SH+wOzARdchg1HInOlEx
 6Qsy61Lv6UaFzvQK2MRnY3xDK1mz80xJDpicLSPuFKAhd+V+aMzat3tLfFTs/kYxS42Q
 inWK8f6X/rWRRxA5pSHsark+B0b8X3Vy6n9ctiXXit8wM6XUZLxx2/FtE5xquVDCkG9B
 uy1VpQ/BBPGfuUmxeKpoALKMqlUtNodVE3qvOpt+4bH56EYaLFzjti5NgILxjr2bEjUa
 BpRw==
X-Gm-Message-State: AOJu0YyQpUjGD199efqKtmbzVkjzgX4KdSm9pGxR8hcR3N6oNol9ZisJ
 EIkICx4dcj5/ztszCSIAW4Hawf/yz55c1V0tE0X5XOU5gsN1jUudgFhJ1qBB/9FrgCWejSp5yj8
 =
X-Gm-Gg: ASbGncuNALPDL/xwEGqijpe44V8uf8b8YaBjgf4kUCscoANLjebq6EbOQJgorEl1Tas
 MeToHLYlJ1OSr0/yZMZhecy8InCgnjz0YsR3REaX+lXJ0KmhrGRYaRVoewyXtASGN7Gyq/ZIxnL
 6pssTymLXKaXCviVSMEHtfFOetz5D7W+wHlGx8yy7JEovof+vU1H5VwC/EurtBwcQK9FrWXSYQ6
 FglUG+t6YElgcUl0KCGAcV7P269hR4cu9m0vZlZz4iQJaREQ/CP09NZVr0MisYd1I9jjprfAtml
 3PsDxr3V16TJ/bc8ZvdlElS8KMtSOjRM/tppWfqfguSoXk431kUA
X-Google-Smtp-Source: AGHT+IEcMO8oZRe3rDElIOKhZ/HpkvaZTrMPs4MgS3thLEX4J3T2OBsR0RzYj6BYJfX2HiJobE3tzA==
X-Received: by 2002:a92:cd83:0:b0:3ce:6628:3c4 with SMTP id
 e9e14a558f8ab-3d28078e77cmr10551335ab.6.1739589820712; 
 Fri, 14 Feb 2025 19:23:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/29] efi: Rename ImageBase to image_base
Date: Fri, 14 Feb 2025 20:22:33 -0700
Message-ID: <20250215032254.4121030-13-sjg@chromium.org>
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
index 90eba30b68d..28cac120bf9 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -75,6 +75,8 @@ extern char __rel_dyn_start[], __rel_dyn_end[];
 extern char _image_binary_end[];
 extern char __dtb[];
 
+extern char image_base[];
+
 /*
  * This is the U-Boot entry point - prior to relocation it should be same
  * as __text_start
-- 
2.43.0

