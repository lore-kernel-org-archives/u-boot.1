Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304A4C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BC980BA8;
	Sat,  8 Feb 2025 18:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I1uQJby3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C085E80B9F; Sat,  8 Feb 2025 18:12:39 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D6E80BAD
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844e06e5d11so87913939f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034754; x=1739639554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TCdZIJeT5rucXIgL6R4jaBRTTnKdHO3oW7/10C4Fl8=;
 b=I1uQJby3pJ0Y/XvuKUMA9Xk7h/+ybZaYsSEMcXGkF19HkU1dbnOmzP6NXBhGRfgmHC
 F0ba0QhCl6MP1I678H54PNtU1EiPWtM8jr2gBzvUO+r3AfD92Ugvz2VfIaUloXjvNw0E
 +Fzl98FDtuwSMTkeo0VLUXwjU2tZgZZz9Cn/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034754; x=1739639554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TCdZIJeT5rucXIgL6R4jaBRTTnKdHO3oW7/10C4Fl8=;
 b=fs5XFDL3+zOpV380BWEjmy1xnlvXdrURYCTLyrFSoMrzijMrhkZggskx/R50Nz1Gg3
 9JVjDC914DX3S2nctvp/wLT2kvNA3HbHl9YRq/NBYkpMHWzxOZT0yAiyKFIpB0sz+zJ2
 EzWMuFsAbt9zb440vC9jxW1Rlj3yIwzAthToy95X/VRUkiyFnFeTSmFCUjB3siHJLBOS
 AvFax9Hn2Xtt48o7F5StlUz7ENjLAza6/ipNhNUjYKvs3yYg7EeurIkg0iZak/7XRGmJ
 oJ+VZo5ETU9NnpnxaQNp8Wcp6vbTT5e7dDzEOc3mgNv+d9TgwWLBV7S5C30njICI1Bir
 lapw==
X-Gm-Message-State: AOJu0YwtokhgYUHLWE8MJrjjwppB8+Q8aIY2XABMcboisIhOkaYmjdPo
 b7lSDqTcNYVhH0g21FWoqAZHUJcwRgXE38JTAFQKq6VD0e7MCzGUD0Yi7Ge4mqMo3dRxBXfSAcw
 =
X-Gm-Gg: ASbGnctDQu3vHQTTnGhi3vR9Iaf3oXyx+8plVXId9GRsLR8wovA33W4nbGVlRsLpPg2
 kCQvTmK4ff5gHfGHpVS8QmpGr+piRJZ9sbEcKcWMfWHPO64MfTRhNH0HuzAmTqS4oDhyKcg3Rac
 kJ6fMpqLAC4xQT4tIV+e71gSxjF48QDn5QwRPbNimd7VCXr8wAJf8ZVb2QzIa24wkUTpDFo7kMT
 ChFaaE0QmNMoMSkBgRTGr3kOFDcqpHCgr6TBLP2ly8NcfBptZ1si5BgXGMNp2GKIJDpv5eQFkFB
 o7U9IdWiqk/3qRKiK0b0CjPYMlQMWs3yBidzp9Bt6yFIdfKzaSYX
X-Google-Smtp-Source: AGHT+IH6nnBlG+YWDvD10mxHT3h9kEdXJnEXV9oBBwpGLtNHeB56InbSYpfYmtcW3ucCf6ONANiPOg==
X-Received: by 2002:a05:6602:610b:b0:84c:ea14:9315 with SMTP id
 ca18e2360f4ac-854fd907d52mr757638839f.12.1739034753752; 
 Sat, 08 Feb 2025 09:12:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/29] efi: Rename ImageBase to image_base
Date: Sat,  8 Feb 2025 10:11:32 -0700
Message-ID: <20250208171154.1305761-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

