Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C73D75E5D
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924FC89507;
	Sun, 24 Nov 2024 21:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aTXP3vHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6B0896E6; Sun, 24 Nov 2024 21:27:38 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2869589507
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa52bb7beceso212517666b.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480055; x=1733084855; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CQ5Y5hBnuh3OHccVB+2889/FscgqQ4h3wZqGOAgHYKg=;
 b=aTXP3vHggvRXuIBCA7JRjH500fz6PTzGGJ6jUpkXs4rffB2c09Z7uHKrl8GrGqh2K6
 T8VlKEshhlsdmXA0jO50wTBY7/n8GiTT9lcZg1utn1RlA7BhbNdoND0qlWxj4wpoovac
 7GW2PtxTAy0C37HJ7dulY9x0hZffJccLKljX4B2NdQtcRwiHWrgEsJho0H1OXCGm9bl3
 tx6UQOfLcLrEeuPlCtoXL8MmyCi4Pf0TrBE8YNXhONJ7l9wtxCWFcPF7t4xlzeLeUZ9G
 WODOjbaqnRCazh8KLGm/qCAxJCGwqulxnQdDUm6seAOJm/ky5Aui/37QrieX4kIjKLaO
 eRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480055; x=1733084855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQ5Y5hBnuh3OHccVB+2889/FscgqQ4h3wZqGOAgHYKg=;
 b=wEoxvxBWP8X9Wn7vqcNb6c7FZO16i1kz4tSOhJ4Zag6jQlpc7jgtF7uMKZdLvFL46G
 3D1Mztve5/4CQFWDoBVTrxZFfhbS6z28qPPlXB+e/Fn0sDfjpNjtp8TlvEvj8I/D8QfJ
 HpxdjQ2lWvO9POU8u/T17xVQEuVoem2ODC7TsYUHyO5nGJa949e+mAM928XzF9v6E7gt
 M8jWQ1Phig45tS6NeecgDR6LEzhxKZLuSf6BtkS3MNOjESc8us5OUKzp4y6Y47UvRUKV
 r0SQULYbSXYlway03DnS1wS/xYLZ/TGAdT45EoBl7NJT5BtkWOIZ+tTEA+rC3DqHpvks
 Wqqw==
X-Gm-Message-State: AOJu0YyQ1Aq7yCgYfyC9wZ+BDKIXfykQciatpmk8oxc8rlZzjI4yLgYI
 rEgFsap+VJ/iFWbEeCVetJI26VbGqUYn7q3mgD0rR89tYkv7GFHExIEobf/2gziOPK84TiXFyYn
 GzdI=
X-Gm-Gg: ASbGncubH7R5AA21zBhsO/SXcGu2SSkTUhnti8NA80S66e6F589dwJ5QN+8k9tQ94xl
 aoqFa2GuwC1aWUbyGozO0aTWVxJtU2BTl5FXwpOm7bCwgqPkV7pm+wXkpS3SuXz7f8xQKDve6pH
 weDZRM/e2wXwC3VhageMrrERGCGk6HLmiyPuW/cF/GNIQJaSwzDS31fh8EOCrX0UJ3zvxbsAwJf
 kLKsdodwI7DfRkaedxwIGT/Rbzk1QqPCF0k1RR9yi4MaqhampUn9g+h+iQpCyQlzGD2
X-Google-Smtp-Source: AGHT+IF4yo+ndy4EitZj7j8PCWu9eaYF6L2UbEBvXt9FhhAmVRwCCsjbnDMtN6rhQgfo3qjmbAYkiA==
X-Received: by 2002:a17:906:32cb:b0:aa5:52db:eebd with SMTP id
 a640c23a62f3a-aa552dbeeffmr97687266b.26.1732480055600; 
 Sun, 24 Nov 2024 12:27:35 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:35 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:26:58 +0100
Subject: [PATCH RFC 02/14] efi: stub: support running U-Boot as an EFI
 payload on ARM64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-2-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15393;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=k3WUy1eVrp84M7BzsIREhASHHRi6D3EBoNV3dwvT5QQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHsMoj8cPev1snAwb569LsP1wZ/W67MduF/Pn1/29J
 Z0lvNqwo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEwk2ZHhr9Cxw7sZzuv0zvR7
 8uqvX1L/pPt713G8nMLj3KKWuJal3p7hn3LEzUNn5l4K5Tm2aor7W5/MOWVbHlzYeWDK4p9vt16
 PsnwFAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Implement support for launching U-Boot via an EFI stub app on ARM64.

This is more or less a straight port of the x86 implementation, but due
to the highly x86/qemu specific nature of that implementation I decided
to just split it out to its own file.

Unlike the x86 implementation, there is no debug UART here since ARM
platforms don't have a standard UART interface. However it is usually
possible to port over the debug uart implementation for you platform for
bringup purposes.

Currently this implementation doesn't provide a DTB to U-Boot and
expects U-Boot to use a built-in one, however this ought to be a fairly
trivial addition in the future.

The other significant difference to the x86 version is that rather than
copying U-Boot to CONFIG_TEXT_OFFSET, we require that U-Boot is built
position independent and copy it to EFI allocated memory.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 Makefile                               |  15 ++-
 arch/arm/cpu/armv8/config.mk           |  11 ++
 arch/arm/include/asm/global_data.h     |   3 +
 arch/arm/lib/Makefile                  |   2 +
 include/efi.h                          |   2 +-
 lib/efi/Kconfig                        |   9 +-
 lib/efi/Makefile                       |  28 ++--
 lib/efi/efi_info.c                     |   4 +-
 lib/efi/efi_stub_arm64.c               | 236 +++++++++++++++++++++++++++++++++
 lib/efi/{efi_stub.c => efi_stub_x86.c} |   0
 10 files changed, 294 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index da742ceae76e..8d0340622d7c 100644
--- a/Makefile
+++ b/Makefile
@@ -1681,21 +1681,32 @@ u-boot.bin.o: u-boot.bin FORCE
 
 u-boot-payload.lds: $(LDSCRIPT_EFI) FORCE
 	$(call if_changed_dep,cpp_lds)
 
+# Determine the file suffix for the efi stub implementation
+EFI_STUB_ARCH := $(if $(CONFIG_ARM64),arm64,$(if $(CONFIG_X86_64),x86,$(ARCH)))
+
 # Rule to link the EFI payload which contains a stub and a U-Boot binary
 quiet_cmd_u-boot_payload ?= LD      $@
       cmd_u-boot_payload ?= $(LD) $(LDFLAGS_EFI_PAYLOAD) -o $@ \
-      -T u-boot-payload.lds arch/x86/cpu/call32.o \
-      lib/efi/efi.o lib/efi/efi_stub.o u-boot.bin.o \
+      -T u-boot-payload.lds $(if $(CONFIG_X86),arch/x86/cpu/call32.o,) \
+      lib/efi/efi.o lib/efi/efi_stub_$(EFI_STUB_ARCH).o u-boot.bin.o \
       $(addprefix arch/$(ARCH)/lib/,$(EFISTUB))
 
+quiet_cmd_u-boot_payload_arm64.efi ?= OBJCOPY $@
+      cmd_u-boot_payload_arm64.efi ?= $(OBJCOPY) -O binary u-boot-payload $@
+
 u-boot-payload: u-boot.bin.o u-boot-payload.lds FORCE
 	$(call if_changed,u-boot_payload)
 
 OBJCOPYFLAGS_u-boot-payload.efi := $(OBJCOPYFLAGS_EFI)
+ifeq ($(CONFIG_X86),y)
 u-boot-payload.efi: u-boot-payload FORCE
 	$(call if_changed,zobjcopy)
+else
+u-boot-payload.efi: u-boot-payload FORCE
+	$(call if_changed,u-boot_payload_$(EFI_STUB_ARCH).efi)
+endif
 
 u-boot-img.bin: spl/u-boot-spl.bin u-boot.img FORCE
 	$(call if_changed,cat)
 
diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 4d74b2a533e0..1ee316801064 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -9,4 +9,15 @@ PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
 
 EFI_LDS := elf_aarch64_efi.lds
 EFI_CRT0 := crt0_aarch64_efi.o
 EFI_RELOC := reloc_aarch64_efi.o
+
+LDSCRIPT_EFI := $(srctree)/arch/arm/lib/elf_aarch64_efi.lds
+EFISTUB := crt0_aarch64_efi.o reloc_aarch64_efi.o
+OBJCOPYFLAGS_EFI += --target=pei-aarch64-little
+EFIPAYLOAD_BFDTARGET := pei-aarch64-little
+EFIPAYLOAD_BFDARCH := aarch64
+LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
+		       -s -zexecstack
+
+CPPFLAGS_REMOVE_crt0-efi-aarch64.o += $(CFLAGS_NON_EFI)
+CPPFLAGS_crt0-efi-aarch64.o += $(CFLAGS_EFI)
diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 45401d5e3c8a..6e4471662a38 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -107,8 +107,11 @@ struct arch_global_data {
 #endif
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+#ifdef CONFIG_EFI_STUB
+	ulong table;
+#endif
 };
 
 #include <asm-generic/global_data.h>
 
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed21..14e3990925a7 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -130,4 +130,6 @@ CFLAGS_$(EFI_CRT0) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
+
+extra-$(CONFIG_EFI_STUB) += $(EFI_CRT0) $(EFI_RELOC)
diff --git a/include/efi.h b/include/efi.h
index c559fda3004c..a6eff13a6bbb 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -496,9 +496,9 @@ struct efi_media_plat {
 /* Base address of the EFI image */
 extern char image_base[];
 
 /* Start and end of U-Boot image (for payload) */
-extern char _binary_u_boot_bin_start[], _binary_u_boot_bin_end[];
+extern char _binary_u_boot_bin_start[], _binary_u_boot_bin_end[], _binary_u_boot_bin_size[];
 
 /*
  * Variable Attributes
  */
diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
index 81ed3e66b34d..18f69bdcfbec 100644
--- a/lib/efi/Kconfig
+++ b/lib/efi/Kconfig
@@ -1,10 +1,10 @@
 menu "U-Boot as UEFI application"
-	depends on X86
+	depends on X86 || ARM
 
 config EFI
 	bool "Support running U-Boot from EFI"
-	depends on X86
+	depends on X86 || ARM
 	imply X86_TSC_READ_BASE
 	help
 	  U-Boot can be started from EFI on certain platforms. This allows
 	  EFI to perform most of the system init and then jump to U-Boot for
@@ -12,12 +12,13 @@ config EFI
 	  application, with U-Boot using EFI's drivers instead of its own.
 
 choice
 	prompt "Select EFI mode to use"
-	depends on X86 && EFI
+	depends on EFI
 
 config EFI_APP
 	bool "Support running as an EFI application"
+	depends on !ARM
 	select CHARSET
 	help
 	  Build U-Boot as an application which can be started from EFI. This
 	  is useful for examining a platform in the early stages of porting
@@ -25,8 +26,9 @@ config EFI_APP
 	  command prompt and memory and I/O functions. Use 'reset' to return
 	  to EFI.
 
 config EFI_STUB
+	select POSITION_INDEPENDENT if ARM
 	bool "Support running as an EFI payload"
 
 endchoice
 
@@ -58,8 +60,9 @@ choice
 	  32-bit EFI, select 32-bit here, else select 64-bit. Failure to do
 	  this may produce no error message - it just won't start!
 
 config EFI_STUB_32BIT
+	depends on !ARM
 	bool "Produce a stub for running with 32-bit EFI"
 
 config EFI_STUB_64BIT
 	bool "Produce a stub for running with 64-bit EFI"
diff --git a/lib/efi/Makefile b/lib/efi/Makefile
index 232fa684360e..bf65bacf47e7 100644
--- a/lib/efi/Makefile
+++ b/lib/efi/Makefile
@@ -4,14 +4,24 @@
 
 obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o
 obj-$(CONFIG_EFI_STUB) += efi_info.o
 
-CFLAGS_REMOVE_efi_stub.o := -mregparm=3 \
-	$(if $(CONFIG_EFI_STUB_64BIT),-march=i386 -m32)
-CFLAGS_efi_stub.o := -fpic -fshort-wchar \
-	$(if $(CONFIG_EFI_STUB_64BIT),-m64)
-CFLAGS_REMOVE_efi.o := -mregparm=3 \
-	$(if $(CONFIG_EFI_STUB_64BIT),-march=i386 -m32)
-CFLAGS_efi.o := -fpic -fshort-wchar \
-	$(if $(CONFIG_EFI_STUB_64BIT),-m64)
+ifeq ($(CONFIG_ARM64),y)
+efi_stub.o := efi_stub_arm64.o
+else
+efi_stub.o := efi_stub_x86.o
 
-extra-$(CONFIG_EFI_STUB) += efi_stub.o efi.o
+ifeq ($(CONFIG_EFI_STUB_64BIT),y) # && !CONFIG_ARM64
+CFLAGS_REMOVE_$(efi_stub.o) := -march=i386 -m32
+CFLAGS_$(efi_stub.o) := -m64
+CFLAGS_REMOVE_efi.o := -march=i386 -m32
+CFLAGS_efi.o := -fpic -m64
+endif
+endif
+
+CFLAGS_REMOVE_$(efi_stub.o) += -mregparm=3
+CFLAGS_$(efi_stub.o) += -fpic -fshort-wchar
+CFLAGS_REMOVE_efi.o += -mregparm=3
+CFLAGS_efi.o += -fpic -fshort-wchar
+
+$(info removing flags $(CFLAGS_REMOVE_$(efi_stub.o)))
+extra-$(CONFIG_EFI_STUB) += $(efi_stub.o) efi.o
diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index 5b564c5651d5..5fa4baeec635 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -9,8 +9,10 @@
 #include <errno.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int efi_info_get(enum efi_entry_t type, void **datap, int *sizep)
 {
 	struct efi_entry_hdr *entry;
 	struct efi_info_hdr *info;
@@ -41,6 +43,6 @@ int efi_info_get(enum efi_entry_t type, void **datap, int *sizep)
 	ret = -ENOENT;
 err:
 	unmap_sysmem(info);
 
-	return ret;
+	return -ENOSYS;
 }
diff --git a/lib/efi/efi_stub_arm64.c b/lib/efi/efi_stub_arm64.c
new file mode 100644
index 000000000000..54bee6c55d7e
--- /dev/null
+++ b/lib/efi/efi_stub_arm64.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2015 Google, Inc
+ * Copyright (c) 2024 Linaro, Ltd.
+ *
+ * EFI information obtained here:
+ * http://wiki.phoenix.com/wiki/index.php/EFI_BOOT_SERVICES
+ *
+ * Call ExitBootServices() and launch U-Boot from an EFI environment.
+ */
+
+#include <debug_uart.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <malloc.h>
+#include <asm/io.h>
+#include <linux/err.h>
+#include <linux/types.h>
+
+static bool ebs_called;
+
+void _debug_uart_putc(int ch)
+{
+	struct efi_priv *priv = efi_get_priv();
+
+	if (ch == '\n')
+		_debug_uart_putc('\r');
+	/*
+	 * After calling EBS we can't log anywhere.
+	 * NOTE: for development it is possible to re-implement
+	 * your boards debug uart here like in efi_stub.c for x86.
+	 */
+	if (!ebs_called)
+		efi_putc(priv, ch);
+}
+
+void _debug_uart_init(void) {}
+
+DEBUG_UART_FUNCS;
+
+void putc(const char ch)
+{
+	_debug_uart_putc(ch);
+}
+
+void puts(const char *str)
+{
+	while (*str)
+		putc(*str++);
+}
+
+
+void *memcpy(void *dest, const void *src, size_t size)
+{
+	unsigned char *dptr = dest;
+	const unsigned char *ptr = src;
+	const unsigned char *end = src + size;
+
+	while (ptr < end)
+		*dptr++ = *ptr++;
+
+	return dest;
+}
+
+void *memset(void *inptr, int ch, size_t size)
+{
+	char *ptr = inptr;
+	char *end = ptr + size;
+
+	while (ptr < end)
+		*ptr++ = ch;
+
+	return ptr;
+}
+
+/**
+ * setup_info_table() - sets up a table containing information from EFI
+ *
+ * We must call exit_boot_services() before jumping out of the stub into U-Boot
+ * proper, so that U-Boot has full control of peripherals, memory, etc.
+ *
+ * Once we do this, we cannot call any boot-services functions so we must find
+ * out everything we need to before doing that.
+ *
+ * Set up a struct efi_info_hdr table which can hold various records (e.g.
+ * struct efi_entry_memmap) with information obtained from EFI.
+ *
+ * @priv: Pointer to our private information which contains the list
+ * @size: Size of the table to allocate
+ * Return: 0 if OK, non-zero on error
+ */
+static int setup_info_table(struct efi_priv *priv, int size)
+{
+	struct efi_info_hdr *info;
+	efi_status_t ret;
+
+	/* Get some memory for our info table */
+	priv->info_size = size;
+	info = efi_malloc(priv, priv->info_size, &ret);
+	if (ret) {
+		printhex2(ret);
+		puts(" No memory for info table: ");
+		return ret;
+	}
+
+	memset(info, '\0', sizeof(*info));
+	info->version = EFI_TABLE_VERSION;
+	info->hdr_size = sizeof(*info);
+	priv->info = info;
+	priv->next_hdr = (char *)info + info->hdr_size;
+
+	return 0;
+}
+
+/**
+ * add_entry_addr() - Add a new entry to the efi_info list
+ *
+ * This adds an entry, consisting of a tag and two lots of data. This avoids the
+ * caller having to coalesce the data first
+ *
+ * @priv: Pointer to our private information which contains the list
+ * @type: Type of the entry to add
+ * @ptr1: Pointer to first data block to add
+ * @size1: Size of first data block in bytes (can be 0)
+ * @ptr2: Pointer to second data block to add
+ * @size2: Size of second data block in bytes (can be 0)
+ */
+static void add_entry_addr(struct efi_priv *priv, enum efi_entry_t type,
+			   void *ptr1, int size1, void *ptr2, int size2)
+{
+	struct efi_entry_hdr *hdr = priv->next_hdr;
+
+	hdr->type = type;
+	hdr->size = size1 + size2;
+	hdr->addr = 0;
+	hdr->link = ALIGN(sizeof(*hdr) + hdr->size, 16);
+	priv->next_hdr += hdr->link;
+	memcpy(hdr + 1, ptr1, size1);
+	memcpy((void *)(hdr + 1) + size1, ptr2, size2);
+	priv->info->total_size = (ulong)priv->next_hdr - (ulong)priv->info;
+}
+
+/**
+ * efi_main() - Start an EFI image
+ *
+ * This function is called by our EFI start-up code. It handles running
+ * U-Boot. If it returns, EFI will continue.
+ */
+efi_status_t EFIAPI efi_main(efi_handle_t image,
+			     struct efi_system_table *sys_table)
+{
+	struct efi_priv local_priv, *priv = &local_priv;
+	struct efi_boot_services *boot = sys_table->boottime;
+	struct efi_entry_memmap map;
+	struct efi_gop *gop;
+	struct efi_entry_gopmode mode;
+	struct efi_entry_systable table;
+	efi_guid_t efi_gop_guid = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
+	efi_status_t ret;
+
+	ebs_called = false;
+
+	ret = efi_init(priv, "Payload", image, sys_table);
+	if (ret) {
+		printhex2(ret);
+		puts(" efi_init() failed\n");
+		return ret;
+	}
+	efi_set_priv(priv);
+
+	phys_addr_t reloc_addr = ULONG_MAX;
+	ret = boot->allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_LOADER_CODE,
+				   (phys_addr_t)_binary_u_boot_bin_size / EFI_PAGE_SIZE,
+				   &reloc_addr);
+	if (ret != EFI_SUCCESS) {
+		puts("Failed to allocate memory for U-Boot: ");
+		printhex2(ret);
+		putc('\n');
+		return ret;
+	}
+
+	ret = efi_store_memory_map(priv);
+	if (ret)
+		return ret;
+
+	ret = setup_info_table(priv, priv->memmap_size + 128);
+	if (ret)
+		return ret;
+
+	ret = boot->locate_protocol(&efi_gop_guid, NULL, (void **)&gop);
+	if (ret) {
+		puts(" GOP unavailable\n");
+	} else {
+		mode.fb_base = gop->mode->fb_base;
+		mode.fb_size = gop->mode->fb_size;
+		mode.info_size = gop->mode->info_size;
+		add_entry_addr(priv, EFIET_GOP_MODE, &mode, sizeof(mode),
+			       gop->mode->info,
+			       sizeof(struct efi_gop_mode_info));
+	}
+
+	table.sys_table = (ulong)sys_table;
+	add_entry_addr(priv, EFIET_SYS_TABLE, &table, sizeof(table), NULL, 0);
+
+	ret = efi_call_exit_boot_services();
+	if (ret)
+		return ret;
+
+	/* The EFI console won't work now :( */
+	ebs_called = true;
+
+	map.version = priv->memmap_version;
+	map.desc_size = priv->memmap_desc_size;
+	add_entry_addr(priv, EFIET_MEMORY_MAP, &map, sizeof(map),
+		       priv->memmap_desc, priv->memmap_size);
+	add_entry_addr(priv, EFIET_END, NULL, 0, 0, 0);
+
+	memcpy((void *)reloc_addr, _binary_u_boot_bin_start,
+	       (ulong)_binary_u_boot_bin_end -
+	       (ulong)_binary_u_boot_bin_start);
+
+/* This will only work if you patched your own debug uart into this file. */
+#ifdef DEBUG
+	puts("EFI table at ");
+	printhex8((ulong)priv->info);
+	puts(" size ");
+	printhex8(priv->info->total_size);
+	putc('\n');
+#endif
+	typedef void (*func_t)(u64 x0, u64 x1, u64 x2, u64 x3);
+
+	puts("Jumping to U-Boot\n");
+	((func_t)reloc_addr)((phys_addr_t)priv->info, 0, 0, 0);
+
+	return EFI_LOAD_ERROR;
+}
diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub_x86.c
similarity index 100%
rename from lib/efi/efi_stub.c
rename to lib/efi/efi_stub_x86.c

-- 
2.47.0

