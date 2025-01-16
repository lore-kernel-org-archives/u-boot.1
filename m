Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D1C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B75E5806FE;
	Thu, 16 Jan 2025 12:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="irSSa4Zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1C280770; Thu, 16 Jan 2025 12:39:36 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A66280214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C3A23FE21
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737027563;
 bh=YAdlqRBoNexkb213O/4J/L0oWMrGnmHqJfEM5zS38kg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=irSSa4ZmuBnP9J/KQT16YAHKtq8pCYvD9CmbYaPjopzhZ4y2/2KSIsLAhzw7Or4PK
 HinA1C3vmF/UUM3nyRXPug3X6x5OpaejeRphUXDAD1bQHnWn6vTVz4VFsJhkA47m3g
 7pImUH+hbZzoX/eDGdESHUuWGWcHQC1Kncqs9SGl4FikWVbo0rdGBiY4Uj3zPRN5v9
 0JfeINUd1QB00DWp224UuOcMs2N4YgJ7iW9z0y0rHIWvi02co/FGUJ9/BRjwlJC6k4
 pMjFwB4FD9BjmrV6gJ26fFQ9GM9uCttBPhgBuMyFNoor/pYdCRbL3/0ej0/PYfJBZe
 DYzJT+sGEALrw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so5118085e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 03:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027560; x=1737632360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAdlqRBoNexkb213O/4J/L0oWMrGnmHqJfEM5zS38kg=;
 b=H6TwYLn13RcgBaRw555LO34jFBl77UwYhz14TSCKiaE8uJOV+6lgOOYITBLwWYr380
 fOzBLfU8245C173WKq4SJLNO8RDdyssFwJQpqoPban9lhUMLhj1zuifXc/vE1xGKPxw7
 0KmXzXTe8j3+mepZnHo1G0NLjBSq3Cu4VC9d9FZwUd3SzNl3u+Pvb7PhchKvSPU8uIzm
 Sscp61xpLeFw/r0cTSrWJ6PAlOBP4iJ8E22IzQ/qN37rNZLtMFJ06CNX6pqxY7q50p70
 YaFxM0gCot84g/XSVVcs1PV9uK5C7AhOo+aJVRxFhnYyta0Z2XbRNMe/p230RNFED6LB
 Fm2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGE2FLHsWK7CwZ2NPz/+lFUkVfAVaKyeDCgf05A2sQfqAzYq0NSVTSbrWwuZcc48inbA0shx8=@lists.denx.de
X-Gm-Message-State: AOJu0YyvFoQBSfZUPQL4/2J5EMIQhPmyvE/FZFexWcR5Zky5ybOt8Amw
 5HAZBdt4sYgzzgAcYZNEsMJNPcFOXOQ0SMPEs/Ohgd/d4vbjhvfkTUvCvRswHE9fyNsGRXalx4M
 X9fEzCtSrKdbf2QztY+CKSRko1e9jNkmSArfkMeU+ICYPn3mUk/d9vJQReyPdKTRzags=
X-Gm-Gg: ASbGncvmVbK8SMhFff0eKOkeupZRkKmhodq52/Ch/9PuhIH4g7AkGmc2K2ntEkQjwfZ
 vaFZKauK7P/6/tGx4jGi7TnKB+8lWdWK5RhbfjEj8CJyQkHoBShTxy0HWr5WFNFjRP0GJOoghNa
 tTWhHPQwR21fOg4cThLWhQpdatC63hrRTp0upeOpXzkRG+SyLwICeFGzIcInhQud8c90z0xhkew
 ix02leDwPQaJaXhyUHAIVpLWmVAaY1tdERkP1fzrq97mgTtT7BYNM1AZvvP+wpx7hSa7YB8vMgf
 9XT97+uV+ZSljA==
X-Received: by 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-436e26d0cf9mr264665765e9.19.1737027560071; 
 Thu, 16 Jan 2025 03:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVRRFbCXuSVVYJDdpC35owqgHtxuvIIvjoNhY25UCLBqRsq3c1meUSTbMWYSA5E4rhCj8JmA==
X-Received: by 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-436e26d0cf9mr264665485e9.19.1737027559626; 
 Thu, 16 Jan 2025 03:39:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm20606320f8f.39.2025.01.16.03.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:39:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/5] efi_loader: use INCLUDE in EFI linker scripts
Date: Thu, 16 Jan 2025 12:39:07 +0100
Message-ID: <20250116113909.113950-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v2:
	no change
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

