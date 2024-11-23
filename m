Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1518BE66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B8B689420;
	Sat, 23 Nov 2024 22:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E2F891B4; Sat, 23 Nov 2024 20:57:40 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk
 [IPv6:2a00:1098:84:22e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708CF89275
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id 86FD340A09;
 Sat, 23 Nov 2024 19:57:35 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/10] Support separate DTB files with the UEFI app
Date: Sat, 23 Nov 2024 11:55:06 -0800
Message-ID: <20241123195616.305687-8-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

From: Matthew Garrett <mgarrett@aurora.tech>

The UEFI app is an actual executable with things like section headers,
so just gluing the DTB onto the end of it won't work. Add an additional
section to contain this and allocate some space, and then during build
copy the DTB into that section.

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 Makefile                        | 7 ++++++-
 arch/x86/config.mk              | 2 +-
 arch/x86/lib/elf_x86_64_efi.lds | 4 ++++
 include/asm-generic/sections.h  | 1 +
 lib/efi/Makefile                | 2 +-
 lib/efi/efi_dtb.S               | 6 ++++++
 lib/fdtdec.c                    | 3 +++
 7 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100644 lib/efi/efi_dtb.S

diff --git a/Makefile b/Makefile
index 2eaae427961..18abaa1ac52 100644
--- a/Makefile
+++ b/Makefile
@@ -1067,6 +1067,10 @@ quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) --gap-fill=0xff $(OBJCOPYFLAGS) \
 	$(OBJCOPYFLAGS_$(@F)) $< $@
 
+# Inject the DTB into u-boot
+quiet_cmd_embeddtb = OBJCOPY $@
+cmd_embeddtb = $(OBJCOPY) --update-section .embedded_dtb=dts/dt.dtb --set-section-flags .embedded_dtb=contents,alloc,load,data $<
+
 # Provide a version which does not do this, for use by EFI
 quiet_cmd_zobjcopy = OBJCOPY $@
 cmd_zobjcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
@@ -1673,7 +1677,8 @@ u-boot-x86-reset16.bin: u-boot FORCE
 endif # CONFIG_X86
 
 OBJCOPYFLAGS_u-boot-app.efi := $(OBJCOPYFLAGS_EFI)
-u-boot-app.efi: u-boot FORCE
+u-boot-app.efi: u-boot dts/dt.dtb FORCE
+	$(call if_changed,embeddtb)
 	$(call if_changed,zobjcopy)
 
 u-boot.bin.o: u-boot.bin FORCE
diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index 6d4839dfb38..ac1f1922b12 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -45,7 +45,7 @@ LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
 		       -s -zexecstack
 
 OBJCOPYFLAGS_EFI := -j .text -j .sdata -j .data -j .dynamic -j .dynsym \
-	-j .rel -j .rela -j .reloc --strip-all
+	-j .rel -j .rela -j .reloc -j .embedded_dtb --strip-all
 
 # Compiler flags to be added when building UEFI applications
 CFLAGS_EFI := -fpic -fshort-wchar
diff --git a/arch/x86/lib/elf_x86_64_efi.lds b/arch/x86/lib/elf_x86_64_efi.lds
index ada024c05c3..cb656ac46ea 100644
--- a/arch/x86/lib/elf_x86_64_efi.lds
+++ b/arch/x86/lib/elf_x86_64_efi.lds
@@ -79,5 +79,9 @@ SECTIONS
 		*(.note.GNU-stack)
 	}
 
+	.embedded_dtb : {
+		*(.embedded_dtb)
+	}
+
 	.comment 0 : { *(.comment) }
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index b6bca53db10..4113ea2a866 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -70,6 +70,7 @@ extern char __image_copy_start[], __image_copy_end[];
 extern char __bss_end[];
 extern char __rel_dyn_start[], __rel_dyn_end[];
 extern char _image_binary_end[];
+extern char _dtb[];
 
 /*
  * This is the U-Boot entry point - prior to relocation it should be same
diff --git a/lib/efi/Makefile b/lib/efi/Makefile
index 63845287336..9f51671c65d 100644
--- a/lib/efi/Makefile
+++ b/lib/efi/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2015 Google, Inc
 
-obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o efi_vars.o
+obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o efi_vars.o efi_dtb.o
 obj-$(CONFIG_EFI_STUB) += efi_info.o
 
 CFLAGS_REMOVE_efi_stub.o := -mregparm=3 \
diff --git a/lib/efi/efi_dtb.S b/lib/efi/efi_dtb.S
new file mode 100644
index 00000000000..75e0c4a5765
--- /dev/null
+++ b/lib/efi/efi_dtb.S
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifdef CONFIG_OF_SEPARATE
+.section .embedded_dtb, "a"
+.globl __dtb
+__dtb: .fill 1024*1024
+#endif
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b0655988029..63853f816f4 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1236,6 +1236,9 @@ static void *fdt_find_separate(void)
 		fdt_blob = (ulong *)_image_binary_end;
 	else
 		fdt_blob = (ulong *)__bss_end;
+#elif defined CONFIG_EFI_APP
+	/* FDT is in a separate section */
+	fdt_blob = (ulong *)__dtb;
 #else
 	/* FDT is at end of image */
 	fdt_blob = (ulong *)_end;
-- 
2.47.0

