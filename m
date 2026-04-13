Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A15F34C4E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7F78407D;
	Mon, 13 Apr 2026 15:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ac8nkmly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86055841FF; Mon, 13 Apr 2026 15:15:51 +0200 (CEST)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F1383DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40429b1d8baso1505899fac.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776086146; x=1776690946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HZxcKFUzspgYDlg8sHte4lluXbOHHKhGrbF5q1lDox4=;
 b=Ac8nkmly3Xszmj1o75mRA7aWNm3AwhhDZbNImOQ0U68Jnvx3BzbjvpYv8Mt6MKvYhH
 aJ4p95gb/oXNaYfhCjji3kOtBHI7Kyp65vTHX7Dq6w87v1DN3ltb//Lynl8y91G2loDn
 rV+wzh6UETjgGebNZOgTqBp0aKyhNtcstypGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776086146; x=1776690946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZxcKFUzspgYDlg8sHte4lluXbOHHKhGrbF5q1lDox4=;
 b=RyoULK899rW8Ze2AgRVawg19JJ3i+bNCUeWnk2PTtP4rJS880VDV1eWWwYs3tqoWUJ
 RxPTWjYNjt5ZB4H/qw/xe/k0BhqQsvU5DtKtdIXHt1LsOfTFyhMbb3asb8qamQXq46FO
 JHFYZdFAL2DPIXII5ExQ8gd9UZIinaMA9bkMqVEiweh/Lwn44+4n7vX5GySQKgfdzDp6
 neIkxsj3zArbNQA+crSy0eP3XiDA5Th4axMrhtJSiCV6cnIN9IYWV8XGn9pw9DUezrEH
 jEBqvL0DM/CgWaoCWP6ADaXdcV+MqLessLOA7ZCSfbNBx1g3hPnnzCBXIvMdHM8/0QpV
 S/QA==
X-Gm-Message-State: AOJu0YwWJatBR6GnehB18qGaLEN1U4b6TeFYF4znBvT35fuhhWooF6S4
 8EFSGLonNj1aROmXfkMFKirUYo5DWyKiS6S7fPykiGvAWIrhdHs+bxWaAAUKRURkfdy3YH87THZ
 N4ZmMpCc6
X-Gm-Gg: AeBDiesdrHfQqw59+zdoVTLyfo8QXhqOv2MTQLi3M2RY/OOdNpSYXv6ZnDKjyHXAw4m
 EL6V6/Ote8edp3x34xhpobEtZpRRnKFt2g/I6roms7SM8dx43IaK5W3w5i9Ar08xNqQJ7L0n2u9
 +J6NQLp2dgwbb7URqQmqXkBuXhkfNLBzmBPCP/XZVCuPp7Byp2xa7Ae1NOqUVE8pXpw0WK/Fj56
 LoFpkkxSrwO5lBKzmMb8m/OkURKD0j622E8PalmPNv8J+obWZ0tckpPxewjmeZbrRsjLYtrC5gQ
 RouqGYCuYV7cShDfZ2kcBkFXF+vrSdEtygSfcO/4ybDCKnft3KpUQ/YjddnJCDsdbenRRgYig2O
 l4XPNhQz0HCyWWAj+Uc3Ve5NVuU2GmIyzrSLkGDPc1O6GmjHmS/tR/fKXfZzuHjLtIWsGgKy7kJ
 +3E3k4PBs+gAF9ihXa/A==
X-Received: by 2002:a05:6820:4c07:b0:68a:f94d:753d with SMTP id
 006d021491bc7-68be6432c7fmr6840701eaf.17.1776086146192; 
 Mon, 13 Apr 2026 06:15:46 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc7dfa196sm5958562eaf.2.2026.04.13.06.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:15:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH v4 1/2] kbuild: Move U-Boot .incbin rules to
 Makefile.lib-u-boot
Date: Mon, 13 Apr 2026 07:15:37 -0600
Message-ID: <20260413131541.2091541-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The font, splash-screen and EFI .incbin wrapper rules are U-Boot
additions that do not exist in the upstream Linux kbuild. Keeping them
in scripts/Makefile.lib makes re-syncing with Linux harder than it needs
to be, as every sync must manually preserve the U-Boot additions.

Move these rules into a new scripts/Makefile.lib-u-boot and include it
from Makefile.build and Makefile.xpl, right after the existing
Makefile.lib include.

This is a pure code-move with no functional change.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Split out of the relative-path patch as requested by Tom Rini

 scripts/Makefile.build      |  1 +
 scripts/Makefile.lib        | 94 ------------------------------------
 scripts/Makefile.lib-u-boot | 96 +++++++++++++++++++++++++++++++++++++
 scripts/Makefile.xpl        |  1 +
 4 files changed, 98 insertions(+), 94 deletions(-)
 create mode 100644 scripts/Makefile.lib-u-boot

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8da9851d430..e625f99986e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -65,6 +65,7 @@ ccflags-y  += $(PLATFORM_CPPFLAGS)
 cppflags-y += $(PLATFORM_CPPFLAGS)
 
 include $(srctree)/scripts/Makefile.lib
+include $(srctree)/scripts/Makefile.lib-u-boot
 
 # Do not include hostprogs rules unless needed.
 # $(sort ...) is used here to remove duplicated words and excessive spaces.
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7386353e0cc..b8969b7de54 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -508,100 +508,6 @@ $(multi-dtb-y): FORCE
 	$(call if_changed,fdtoverlay)
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
-# Fonts
-# ---------------------------------------------------------------------------
-
-# Generate an assembly file to wrap the font data
-quiet_cmd_S_ttf= TTF     $@
-# Modified for U-Boot
-cmd_S_ttf=						\
-(							\
-	echo '.section .rodata.ttf.init,"a"';		\
-	echo '.balign 16';				\
-	echo '.global __ttf_$(*F)_begin';		\
-	echo '__ttf_$(*F)_begin:';			\
-	echo '.incbin "$<" ';				\
-	echo '__ttf_$(*F)_end:';			\
-	echo '.global __ttf_$(*F)_end';			\
-	echo '.balign 16';				\
-) > $@
-
-$(obj)/%.S: $(src)/%.ttf
-	$(call cmd,S_ttf)
-
-# Splash logos
-# ---------------------------------------------------------------------------
-
-# Generate an assembly file to wrap the splash data
-quiet_cmd_S_splash= TTF     $@
-# Modified for U-Boot
-cmd_S_splash=						\
-(							\
-	echo '.section .rodata.splash.init,"a"';		\
-	echo '.balign 16';				\
-	echo '.global __splash_$(*F)_begin';		\
-	echo '__splash_$(*F)_begin:';			\
-	echo '.incbin "$<" ';				\
-	echo '__splash_$(*F)_end:';			\
-	echo '.global __splash_$(*F)_end';			\
-	echo '.balign 16';				\
-) > $@
-
-$(obj)/%.S: $(src)/%.bmp
-	$(call cmd,S_splash)
-
-# EFI applications
-# A Makefile target *.efi is built as EFI application.
-# A Makefile target *_efi.S wraps *.efi as built-in EFI application.
-# ---------------------------------------------------------------------------
-
-# Generate an assembly file to wrap the EFI app
-cmd_S_efi=					\
-(						\
-	echo '.section .rodata.$*.init,"a"';	\
-	echo '.balign 16';			\
-	echo '.global __efi_$*_begin';		\
-	echo '__efi_$*_begin:';			\
-	echo '.incbin "$<" ';			\
-	echo '__efi_$*_end:';			\
-	echo '.global __efi_$*_end';		\
-	echo '.balign 16';			\
-) > $@
-
-$(obj)/%_efi.S: $(obj)/%.efi
-	$(call cmd,S_efi)
-
-quiet_cmd_efi_objcopy = OBJCOPY $@
-cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
-		-j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
-		$(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
-
-$(obj)/%.efi: $(obj)/%_efi.so
-	$(call cmd,efi_objcopy)
-
-KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
-KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
-quiet_cmd_efi_ld = LD      $@
-cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
-		-shared -Bsymbolic -s $^ $(PLATFORM_LIBGCC) -o $@
-
-EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
-
-$(obj)/efi_crt0.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_CRT0:.o=.S) FORCE
-	$(call if_changed_dep,as_o_S)
-
-$(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_RELOC:.o=.c) $(recordmcount_source) FORCE
-	$(call cmd,force_checksrc)
-	$(call if_changed_rule,cc_o_c)
-
-$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
-	$(call cmd,efi_ld)
-
-targets += $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
-
-CFLAGS_REMOVE_efi_reloc.o := $(LTO_CFLAGS)
-CFLAGS_REMOVE_efi_freestanding.o := $(LTO_CFLAGS)
-
 # ACPI
 # ---------------------------------------------------------------------------
 #
diff --git a/scripts/Makefile.lib-u-boot b/scripts/Makefile.lib-u-boot
new file mode 100644
index 00000000000..c55f8d8e0c3
--- /dev/null
+++ b/scripts/Makefile.lib-u-boot
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# U-Boot-specific rules for embedding binary data via .incbin
+# These are split out of Makefile.lib to simplify kbuild re-syncs.
+
+# Fonts
+# ---------------------------------------------------------------------------
+
+# Generate an assembly file to wrap the font data
+quiet_cmd_S_ttf= TTF     $@
+cmd_S_ttf=						\
+(							\
+	echo '.section .rodata.ttf.init,"a"';		\
+	echo '.balign 16';				\
+	echo '.global __ttf_$(*F)_begin';		\
+	echo '__ttf_$(*F)_begin:';			\
+	echo '.incbin "$<" ';				\
+	echo '__ttf_$(*F)_end:';			\
+	echo '.global __ttf_$(*F)_end';			\
+	echo '.balign 16';				\
+) > $@
+
+$(obj)/%.S: $(src)/%.ttf
+	$(call cmd,S_ttf)
+
+# Splash logos
+# ---------------------------------------------------------------------------
+
+# Generate an assembly file to wrap the splash data
+quiet_cmd_S_splash= TTF     $@
+cmd_S_splash=						\
+(							\
+	echo '.section .rodata.splash.init,"a"';	\
+	echo '.balign 16';				\
+	echo '.global __splash_$(*F)_begin';		\
+	echo '__splash_$(*F)_begin:';			\
+	echo '.incbin "$<" ';				\
+	echo '__splash_$(*F)_end:';			\
+	echo '.global __splash_$(*F)_end';		\
+	echo '.balign 16';				\
+) > $@
+
+$(obj)/%.S: $(src)/%.bmp
+	$(call cmd,S_splash)
+
+# EFI applications
+# A Makefile target *.efi is built as EFI application.
+# A Makefile target *_efi.S wraps *.efi as built-in EFI application.
+# ---------------------------------------------------------------------------
+
+# Generate an assembly file to wrap the EFI app
+cmd_S_efi=					\
+(						\
+	echo '.section .rodata.$*.init,"a"';	\
+	echo '.balign 16';			\
+	echo '.global __efi_$*_begin';		\
+	echo '__efi_$*_begin:';			\
+	echo '.incbin "$<" ';			\
+	echo '__efi_$*_end:';			\
+	echo '.global __efi_$*_end';		\
+	echo '.balign 16';			\
+) > $@
+
+$(obj)/%_efi.S: $(obj)/%.efi
+	$(call cmd,S_efi)
+
+quiet_cmd_efi_objcopy = OBJCOPY $@
+cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
+		-j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
+		$(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
+
+$(obj)/%.efi: $(obj)/%_efi.so
+	$(call cmd,efi_objcopy)
+
+KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
+KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
+quiet_cmd_efi_ld = LD      $@
+cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
+		-shared -Bsymbolic -s $^ $(PLATFORM_LIBGCC) -o $@
+
+EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
+
+$(obj)/efi_crt0.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_CRT0:.o=.S) FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_RELOC:.o=.c) $(recordmcount_source) FORCE
+	$(call cmd,force_checksrc)
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
+	$(call cmd,efi_ld)
+
+targets += $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
+
+CFLAGS_REMOVE_efi_reloc.o := $(LTO_CFLAGS)
+CFLAGS_REMOVE_efi_freestanding.o := $(LTO_CFLAGS)
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index c5ddf64c73f..862a8e6f231 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -88,6 +88,7 @@ include $(srctree)/config.mk
 include $(srctree)/arch/$(ARCH)/Makefile
 
 include $(srctree)/scripts/Makefile.lib
+include $(srctree)/scripts/Makefile.lib-u-boot
 
 # Enable garbage collection of un-used sections for SPL
 KBUILD_CFLAGS += -ffunction-sections -fdata-sections
---
base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
branch: font-us4

-- 
2.43.0

