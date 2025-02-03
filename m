Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD423C02197
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 204D280762;
	Mon,  3 Feb 2025 18:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hrZEqFhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE109807B9; Mon,  3 Feb 2025 18:43:51 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D1A800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb9de518e2so2395339b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604626; x=1739209426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLHp6SigTqe4hGhqHf6RclXUEymgTXjN4jw6sBmX6ZU=;
 b=hrZEqFhc5g3JwzkxdY/dygBJ/z3HkCik6HAt2hpgKCM7xU2PdTnVZhMtUkBi/UOHby
 bt8SZfZBXA+ur0VAfORxOit5cqCL+tp+HH0o1JZ7xfE1qyCFDG/tFB9nv2OwGYh3mC7r
 jYOP3x3AI57Qvlg469JIIlsc+zOdjYkleIRlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604626; x=1739209426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLHp6SigTqe4hGhqHf6RclXUEymgTXjN4jw6sBmX6ZU=;
 b=cugAu66Lvh0hER9whhfBNkGqkJ86wr1a7xVjih1mIQS6AYAzvioPMP41Wjtyqrmh7L
 qpPJR1n1bqhyNAWwBEcCXPLm0aNNNmKjl28L4CmL2tYNe2m4BoSv/sxVrIQfZMq4bm/F
 Mk4+cW/GxY8++8GgkE6/GU6Np3nW0lB+xeXh/y7E6L/hVWV11/n5MkybMnhQuBHlg1Cz
 F/zrMw5BHHlH4GFprlBp0V6u/HighU++qG3u1uCqpAgH/cF7Ev2Hpr9tyS1qeFLSThY6
 FKDLcqSDcP0SoXJTaXGSTL0fl55pWaxaZWQHa9txCydZvL0iiqsxUZSpC/eaZzpMBhwe
 wRQQ==
X-Gm-Message-State: AOJu0Yzch85RHmiJvDIoEK6tIJu46jKbhulHWeYj8afRdBG1zrsVlOJ3
 mcXSXeeT9nN6ZlxWM4PoFBR7K/CwvY0ZTZrXgHkG5pVaKFO5yURiXrN2sfldPaZok5XwQVr4ubE
 =
X-Gm-Gg: ASbGnctAiQFZI5ZdTdCZkGFAG6IyIKX3aXFMnK/Z93gIY8Q5boUal1eURlI1ID0uyvu
 IU4fzDCgc6v0PvcMsNyQBSWowGt1b6/E+mmenRAE7iZLtthYoJkbhgOE0vGQqcsq0HMTO2CfSRo
 qURpJui2tONTIrBRpH9UjtahpzYM4eLawAx6JuEoNl9bj6w/lNxdrzBmQfSJ3uqFMkt8f/sAn+b
 gprH+sK7G2iAqjxo4Vzp9MRMpWsTd5f1mTCoJu+YNq/4rRuWcSMe9o/ZES1qUA0/OLeZ3jF9yxH
 c2AJlwDsWhsOuM1wBnVTXPXZet71Hg5U1QOBY5IIaOReUJ4TgRpf
X-Google-Smtp-Source: AGHT+IGWAKXrlKPKr8RaeTNx+vSHka0t33QDp6zzRJGbOArvWYSuRG2QsK5sFXdwZNRskNID3HrCeQ==
X-Received: by 2002:a05:6808:10cd:b0:3f1:cfb4:9b9 with SMTP id
 5614622812f47-3f323b13af7mr15741004b6e.24.1738604626470; 
 Mon, 03 Feb 2025 09:43:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/32] efi: Rename ImageBase to image_base
Date: Mon,  3 Feb 2025 10:42:07 -0700
Message-ID: <20250203174245.1331464-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

It is confusing to have a camel-case indentifier in the link scripts.
Rename it to fit with U-Boot's snake-case style.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/crt0_aarch64_efi.S | 26 +++++++++++++-------------
 arch/riscv/lib/crt0_riscv_efi.S | 28 ++++++++++++++--------------
 include/asm-generic/sections.h  |  2 ++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
index fe6eca576ec..a1888cbb1e4 100644
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
 #if CONFIG_VENDOR_EFI
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
index c7a4559eac8..5fb17f10fd8 100644
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
 #if CONFIG_VENDOR_EFI
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

