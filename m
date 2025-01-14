Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77420E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 10:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D8C806D6;
	Tue, 14 Jan 2025 11:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kv5uVtCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 391AC806D6; Tue, 14 Jan 2025 11:30:18 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A18806B7
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 32BDA40B06
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736850614;
 bh=kiyF4DBJa2zy+qgj5GqI9LPPZvBjT9Ak6a+FhrTga/U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kv5uVtCyBIykVWGF7wHULDaaAszu+VvcEyJTrrroNjjzdUlyKqLMow0Y+YZioJiqT
 vJV1s347AkZICXvFDRlEKgqwvzeyVOdK26AjgoEQjmb/e6yORpNcqzatEt/qwlecgK
 17ifbNMlG7N6Rxl54J44HyUNfgCp+vdQpDC3o7F0FH/LDJTtTA7f7hLs51rkq2SDSF
 cv0/2HaAtG4lUm1Hu0MEAR2r+UkjxFDEANhw8ftLx28QWLLGddmV36/IDLroJ0JRCG
 3nvTJC72rKg08UMfFKoQbG3+ymo0P2DisyKsJfI5XabbZPJTlhcMlo//GL9boaTlib
 mLDfc43xmII0Q==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso29021825e9.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850610; x=1737455410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiyF4DBJa2zy+qgj5GqI9LPPZvBjT9Ak6a+FhrTga/U=;
 b=CdkwGdiJcN9ceNZFb3Ttz6x4zrV3x5o2/z/KGQANLCThMxnX7WeO/48gmKLi5pRJss
 0m4rI0lbg3Mv+zYIE5gswiyF4p7HsGzLMwkOUCm4C2lgLuZod0yBoJJegyTmpakT9xgl
 bbhgGH7EoEuYKOnwySgKfB6HmZjiaGiZ6zG1UfqW65Gn85Q8JJRLK7/8cBwbfXAlFcSH
 AUc/JoGpuNQHp/9q+Fyfrgug1XAWrHy0QIM4jnw23LNP6uoORp7SoKQjAj2M5gbJ/1kj
 o3dW6y27mH50PWHajELTNTZaNK+hNOnEbqUOv+KMMWDmxqjhxYgrY92A8thqInD8sqsp
 A2og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaNQKP8i0A9ww/HmuTbLJhnpiTfShWkM08bEt11zq77eWcdXYlPx7Fy6G9fGpIRDQB5Ck2tHc=@lists.denx.de
X-Gm-Message-State: AOJu0YxwK8hS+I9rZzJGqHHVso3yJxFC1JgsH8wflZPhI1+TgnrI0dHj
 Xq3HKyMA5Ig3IIBvcxpwp5kiDNPAOX31AJAPJwZA071SBPJ3YEGrUQD3MJovqtKEVyQfOPyM4U3
 8T/M/zrDqXZ6RL8HQzuYfdx5Tc98iB41D7IvKpVf/s+Y0RuE6IWgUDORq6nTs2OJ9qTU=
X-Gm-Gg: ASbGncs4GvoIp18eSs4dsPUWFN5LUvAIWosDhZ24k6T6HOS4FD6rrwFgRutaa3bbmdr
 FcJRpnAq6iyZ2sWjzglKJzKp/JpgObwfU7NLK+byxu+cn05ItcEfGkly81hiRm/wdlBtNc5IGo1
 B48QfFh80SMzGWg+pEEZu9fISJziKfAJ8iXfQbz3aSjwpVp5WVJ8Xz7GLgzP/HfmDZ9LQaNobCi
 LzBJ7y+FjGBJftN5ZFVvf21IIKQVpWbzaaCLh7dqwofZl4yK6+0Bz2Z5LHHCAt/ey/zfoWpQJWM
 2xOyO9/38+JSdgE=
X-Received: by 2002:a05:600c:510a:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-436e26adfc9mr213436085e9.13.1736850609884; 
 Tue, 14 Jan 2025 02:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQNalF19JzaUwEEvRTmpEK/8aFzJsrse/Xe6Sj4IQgzITmNUv+eFFKVJ+HGk2WHf8lMT+cmQ==
X-Received: by 2002:a05:600c:510a:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-436e26adfc9mr213435315e9.13.1736850608741; 
 Tue, 14 Jan 2025 02:30:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:642a:6b6a:606c:5383:21d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm169996455e9.11.2025.01.14.02.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:30:08 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] efi_loader: use include in ARM EFI linker script
Date: Tue, 14 Jan 2025 11:29:53 +0100
Message-ID: <20250114102953.64381-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
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

Use the same include as arm64 for the linker script.

Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
64-bit ARM header.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/lib/crt0_arm_efi.S  | 37 ++++++++++---------
 arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
 2 files changed, 20 insertions(+), 88 deletions(-)

diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index b5dfd4e3819..590fcf515da 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -14,11 +14,11 @@
 	/*
 	 * Magic "MZ" signature for PE/COFF
 	 */
-	.globl	image_base
-image_base:
+	.globl	ImageBase
+ImageBase:
 	.short	IMAGE_DOS_SIGNATURE		/* 'MZ' */
 	.skip	58				/* 'MZ' + pad + offset == 64 */
-	.long	pe_header - image_base		/* Offset to the PE header */
+	.long	pe_header - ImageBase		/* Offset to the PE header */
 pe_header:
 	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
 coff_header:
@@ -38,16 +38,16 @@ optional_header:
 	.short	IMAGE_NT_OPTIONAL_HDR32_MAGIC	/* PE32 format */
 	.byte	0x02				/* MajorLinkerVersion */
 	.byte	0x14				/* MinorLinkerVersion */
-	.long	_edata - _start			/* SizeOfCode */
+	.long	_etext - _start			/* SizeOfCode */
 	.long	0				/* SizeOfInitializedData */
 	.long	0				/* SizeOfUninitializedData */
-	.long	_start - image_base		/* AddressOfEntryPoint */
-	.long	_start - image_base		/* BaseOfCode */
+	.long	_start - ImageBase		/* AddressOfEntryPoint */
+	.long	_start - ImageBase		/* BaseOfCode */
 	.long	0				/* BaseOfData */
 
 extra_header_fields:
-	.long	0				/* image_base */
-	.long	0x200				/* SectionAlignment */
+	.long	0				/* ImageBase */
+	.long	0x1000				/* SectionAlignment */
 	.long	0x200				/* FileAlignment */
 	.short	0				/* MajorOperatingSystemVersion */
 	.short	0				/* MinorOperatingSystemVersion */
@@ -57,14 +57,14 @@ extra_header_fields:
 	.short	0				/* MinorSubsystemVersion */
 	.long	0				/* Win32VersionValue */
 
-	.long	_edata - image_base		/* SizeOfImage */
+	.long	_edata - ImageBase		/* SizeOfImage */
 
 	/*
 	 * Everything before the kernel image is considered part of the header
 	 */
-	.long	_start - image_base		/* SizeOfHeaders */
+	.long	_start - ImageBase		/* SizeOfHeaders */
 	.long	0				/* CheckSum */
-	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION	/* Subsystem */
+	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
 #if CONFIG_VENDOR_EFI
 	.short	0				/* DllCharacteristics */
 #else
@@ -84,6 +84,7 @@ extra_header_fields:
 	.quad	0				/* CertificationTable */
 	.quad	0				/* BaseRelocationTable */
 
+	/* Section table */
 section_table:
 
 	/*
@@ -111,10 +112,10 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
-	.long	_text_size		/* VirtualSize */
-	.long	_start - image_base	/* VirtualAddress */
-	.long	_text_size		/* SizeOfRawData */
-	.long	_start - image_base	/* PointerToRawData */
+	.long	_etext - _start		/* VirtualSize */
+	.long	_start - ImageBase	/* VirtualAddress */
+	.long	_etext - _start		/* SizeOfRawData */
+	.long	_start - ImageBase	/* PointerToRawData */
 	.long	0			/* PointerToRelocations */
 	.long	0			/* PointerToLineNumbers */
 	.short	0			/* NumberOfRelocations */
@@ -129,9 +130,9 @@ section_table:
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
 	.long	_data_size		/* VirtualSize */
-	.long	_data - image_base	/* VirtualAddress */
+	.long	_data - ImageBase	/* VirtualAddress */
 	.long	_data_size		/* SizeOfRawData */
-	.long	_data - image_base	/* PointerToRawData */
+	.long	_data - ImageBase	/* PointerToRawData */
 	.long	0			/* PointerToRelocations */
 	.long	0			/* PointerToLineNumbers */
 	.short	0			/* NumberOfRelocations */
@@ -148,7 +149,7 @@ _start:
 	adr		r1, .L_DYNAMIC
 	ldr		r0, [r1]
 	add		r1, r0, r1
-	adrl		r0, image_base
+	adrl		r0, ImageBase
 	bl		_relocate
 	teq		r0, #0
 	bne		0f
diff --git a/arch/arm/lib/elf_arm_efi.lds b/arch/arm/lib/elf_arm_efi.lds
index 41440594aa6..eb16fae74cf 100644
--- a/arch/arm/lib/elf_arm_efi.lds
+++ b/arch/arm/lib/elf_arm_efi.lds
@@ -8,73 +8,4 @@
 OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
 
-PHDRS
-{
-	data PT_LOAD FLAGS(3); /* PF_W | PF_X */
-}
-
-ENTRY(_start)
-SECTIONS
-{
-	.text 0x0 : {
-		_text = .;
-		*(.text.head)
-		*(.text)
-		*(.text.*)
-		*(.gnu.linkonce.t.*)
-		*(.srodata)
-		*(.rodata*)
-		. = ALIGN(16);
-		*(.dynamic);
-		. = ALIGN(512);
-	}
-	_etext = .;
-	_text_size = . - _text;
-	. = ALIGN(4096);
-	.data : {
-		_data = .;
-		*(.sdata)
-		*(.data)
-		*(.data1)
-		*(.data.*)
-		*(.got.plt)
-		*(.got)
-
-		/*
-		 * The EFI loader doesn't seem to like a .bss section, so we
-		 * stick it all into .data:
-		 */
-		. = ALIGN(16);
-		_bss = .;
-		*(.sbss)
-		*(.scommon)
-		*(.dynbss)
-		*(.bss)
-		*(.bss.*)
-		*(COMMON)
-		. = ALIGN(512);
-		_bss_end = .;
-		_edata = .;
-	} :data
-	_data_size = . - _data;
-
-	/DISCARD/ : {
-		/*
-		 * We don't support relocations. These would have to be
-		 * translated from ELF to PE format and added to the .reloc
-		 * section.
-		 */
-		*(.rel.dyn)
-		*(.rel.plt)
-		*(.rel.got)
-		*(.rel.data)
-		*(.rel.data*)
-		*(.rel.reloc)
-		*(.eh_frame)
-		*(.note.GNU-stack)
-		*(.dynsym)
-		*(.dynstr)
-		*(.note.gnu.build-id)
-		*(.comment)
-	}
-}
+INCLUDE lib/efi_loader/elf_efi.ldsi
-- 
2.47.1

