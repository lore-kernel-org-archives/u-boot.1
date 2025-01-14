Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9961E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 10:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0361806C6;
	Tue, 14 Jan 2025 11:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CMe0S40a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3327580708; Tue, 14 Jan 2025 11:30:12 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F28806B7
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C17A3F689
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736850608;
 bh=X/GsFEBZi9OS94v4ZJZnDsKYiLceaB1EW+bjV7Cc4nI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CMe0S40aN9nuVfiSIMmohf1sMA3moNQDQFLXA4qCN+zjGRqPxY1d2Xk7O+ops32dH
 SoEegLfZgmHTnBmM0jFSukl1CWNLt9FQBJ1ZlX/m7fvz9LjYbctDFlv7nOIZjdAJxf
 Bgr1Cy58rzvLc/mKkufIRaxr7idTjnJPFS/NpBgSkg4hsN7XESH5ti/I8yvEbSfJLY
 HsG8oJXzk2+4ixXeVifUsGT7GDpMv0zGcLXhOF/S6R5pYy3YNR6rFj47pAqxShhqME
 arRcVekbe8YT14klVHC7J0JSfEYjx7WeTAgDhcoQ94BiK9lwq5KRVTOS1aGS2F2JQG
 aaxkGF45fLg5A==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso16810535e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850607; x=1737455407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/GsFEBZi9OS94v4ZJZnDsKYiLceaB1EW+bjV7Cc4nI=;
 b=Fn8NucY5MoUnKfrM2acy1KzCIkna9ih3zFDJVOc1Owg/Wk109fTML09Atgds47Wl3M
 W9AtB60joOgS0cShUXUtXWP4KcHJ7uQa45pqSWF+/vqnBnBZg/VYckFCQ+kXNHlUHMHG
 ssu426gwwJUYBaMUjJ5wuQeiOg+S/UNVP7L4iVjTh5qO2zRyKtv4VovaPlGq4qa5x/jM
 oj+dRv83/lK1uXK9bXpZ/3louco/TDFtHtgcZTdcW8RkKlE1nY4PGur1MmbgFAwcNeXa
 buUvBk+l4cOCSh/AReyZQujjkwhR+EKnKArk+FWu7eh89WkzQn/Lx8EGSp9BHcg6dKL1
 teHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFpbC3sGXVlhticlyCuRj74v0mVS65w4Lh5+rcC/xWk5LtcqMk08Otxvk7wUlPIKlSIyohoB4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5Xzu9+fEWR3gzKWgj6+8ioUOwxh6bjBYfSEOqTmepNWSEQFnP
 Rw/7EgJQ59yHy0+7K/NqXO6YuhNDLuOx/Knob3xyI9TFgcEPV14gcYVADlpFeAZIiCzyZm1KUve
 ZMYiFGtiPJtSO4Ya0Z3xsJDL0pYsvgzj5H6cBwKgxBdvI3jPIjZ7ahTTYco3TvzB5XrQ=
X-Gm-Gg: ASbGnctihnr11998vMs6+AT8lAUJ2OQU639zWEr/aHUbn0DVgU/OMYdqQNHvuB4hWpJ
 CSa9t/boDDwFBa48EC8PsaLzrqw0rZwJfhzNsi+jtk58sXrGQFkLxScG2wz6G/e0qYqbp1QtmWJ
 I8d8U3Toj/iKSDYuXaMtK6kZdmJbjulk++i74jdEz+I8D34ZzYe3K/zZWYBz1eaKDqE81wGQ5p/
 A2eTZKghBITA3QWA/bdmKkwe8z2DttGD1XQTzgNDOgsm8YZASNBqLSwAYaLrJbOU+ZtZSIf1EPC
 CYSQYU3+t5LeODY=
X-Received: by 2002:a05:600c:1c1a:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-436e2679a94mr238786415e9.7.1736850607499; 
 Tue, 14 Jan 2025 02:30:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0kEEw3yOQkgoij/40KtuqgNE7U73niTsXIJB60+KG3FPUiZ9Qb7nW/EWGKlpf1PDzFtVV1w==
X-Received: by 2002:a05:600c:1c1a:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-436e2679a94mr238786135e9.7.1736850607112; 
 Tue, 14 Jan 2025 02:30:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:642a:6b6a:606c:5383:21d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm169996455e9.11.2025.01.14.02.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:30:06 -0800 (PST)
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
Subject: [PATCH 3/4] efi_loader: use INCLUDE in EFI linker scripts
Date: Tue, 14 Jan 2025 11:29:52 +0100
Message-ID: <20250114102953.64381-4-heinrich.schuchardt@canonical.com>
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

Except for the architecture specific lines ARM and RISC-V can use the same
linker script. Move the common lines to an include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/lib/elf_aarch64_efi.lds   | 68 +--------------------------
 arch/riscv/lib/elf_riscv32_efi.lds | 68 +--------------------------
 arch/riscv/lib/elf_riscv64_efi.lds | 68 +--------------------------
 lib/efi_loader/elf_efi.ldsi        | 74 ++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 201 deletions(-)
 create mode 100644 lib/efi_loader/elf_efi.ldsi

diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index e382254a6cf..453d3511c28 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -8,70 +8,4 @@
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
 OUTPUT_ARCH(aarch64)
 
-PHDRS
-{
-	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
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
-	.rela.dyn : { *(.rela.dyn) }
-	.rela.plt : { *(.rela.plt) }
-	.rela.got : { *(.rela.got) }
-	.rela.data : { *(.rela.data) *(.rela.data*) }
-	. = ALIGN(4096);
-	_etext = .;
-	_text_size = . - _text;
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
-	_data_size = _edata - _data;
-
-	. = ALIGN(4096);
-	.dynsym   : { *(.dynsym) }
-	. = ALIGN(4096);
-	.dynstr   : { *(.dynstr) }
-	. = ALIGN(4096);
-	.note.gnu.build-id : { *(.note.gnu.build-id) }
-	/DISCARD/ : {
-		*(.rel.reloc)
-		*(.eh_frame)
-		*(.note.GNU-stack)
-	}
-	.comment 0 : { *(.comment) }
-}
+INCLUDE lib/efi_loader/elf_efi.ldsi
diff --git a/arch/riscv/lib/elf_riscv32_efi.lds b/arch/riscv/lib/elf_riscv32_efi.lds
index 7b9bd7b7f15..e23521c4931 100644
--- a/arch/riscv/lib/elf_riscv32_efi.lds
+++ b/arch/riscv/lib/elf_riscv32_efi.lds
@@ -8,70 +8,4 @@
 OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
 OUTPUT_ARCH(riscv)
 
-PHDRS
-{
-	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
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
-	.rela.dyn : { *(.rela.dyn) }
-	.rela.plt : { *(.rela.plt) }
-	.rela.got : { *(.rela.got) }
-	.rela.data : { *(.rela.data) *(.rela.data*) }
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
-	_data_size = _edata - _data;
-
-	. = ALIGN(4096);
-	.dynsym   : { *(.dynsym) }
-	. = ALIGN(4096);
-	.dynstr   : { *(.dynstr) }
-	. = ALIGN(4096);
-	.note.gnu.build-id : { *(.note.gnu.build-id) }
-	/DISCARD/ : {
-		*(.rel.reloc)
-		*(.eh_frame)
-		*(.note.GNU-stack)
-	}
-	.comment 0 : { *(.comment) }
-}
+INCLUDE lib/efi_loader/elf_efi.ldsi
diff --git a/arch/riscv/lib/elf_riscv64_efi.lds b/arch/riscv/lib/elf_riscv64_efi.lds
index d0b4f3d1d64..8e4844c2eea 100644
--- a/arch/riscv/lib/elf_riscv64_efi.lds
+++ b/arch/riscv/lib/elf_riscv64_efi.lds
@@ -8,70 +8,4 @@
 OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
 OUTPUT_ARCH(riscv)
 
-PHDRS
-{
-	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
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
-	.rela.dyn : { *(.rela.dyn) }
-	.rela.plt : { *(.rela.plt) }
-	.rela.got : { *(.rela.got) }
-	.rela.data : { *(.rela.data) *(.rela.data*) }
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
-	_data_size = _edata - _data;
-
-	. = ALIGN(4096);
-	.dynsym   : { *(.dynsym) }
-	. = ALIGN(4096);
-	.dynstr   : { *(.dynstr) }
-	. = ALIGN(4096);
-	.note.gnu.build-id : { *(.note.gnu.build-id) }
-	/DISCARD/ : {
-		*(.rel.reloc)
-		*(.eh_frame)
-		*(.note.GNU-stack)
-	}
-	.comment 0 : { *(.comment) }
-}
+INCLUDE lib/efi_loader/elf_efi.ldsi
diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
new file mode 100644
index 00000000000..190a88fb69e
--- /dev/null
+++ b/lib/efi_loader/elf_efi.ldsi
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * U-Boot EFI linker script include
+ *
+ * Modified from elf_aarch64_efi.lds in gnu-efi
+ */
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
+	. = ALIGN(4096);
+	_etext = .;
+	_text_size = . - _text;
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
-- 
2.47.1

