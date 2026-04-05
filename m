Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B09DE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 10:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6B480433;
	Sun,  5 Apr 2026 12:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AO/a0gEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3735E807C0; Sun,  5 Apr 2026 12:42:52 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A38800AE
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 12:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so3291880a34.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775385767; x=1775990567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V0pF/sW85/TPD/KT3wrN6ymxhpcgFc9Kx5J+K+5G3pc=;
 b=AO/a0gEZy9ilqVxBlLhr69uig2mVmeE73y36YNpNqHcbnK9xjCQyEmfVna3A7KI+nO
 B5zZhlM3Okj6oKrMNkZessr+W0Wl+t1SEZ9davPbZ+Dw+EgOqxgfnn1XqkX3vQbMS31/
 5MPCX1ucVTITzByyFMjNcPZas6ZwLqr5Q7UsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775385767; x=1775990567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0pF/sW85/TPD/KT3wrN6ymxhpcgFc9Kx5J+K+5G3pc=;
 b=YEUXx22Neg1EOAFHYTc64ByoMJi7aW1UVC3t9MlY+8djqWHETdQLdHaDN2h+y8kzCz
 868M6uBnNvoC8dfA/xWGblEcK91xMQo0KFKgqYDU8Wt/gr2+3wfLDOryS52SIWC9GXHy
 xJFvxcnjcQjnW/E8XkHxqrbmXdCnnyP3NZMUS18+cxYNp+T70uZ6rSRzEkVcgeCbNcZK
 ZRcKVdhRSC+hb963r0rLY8Fz7R2aee5hAEwXgyVHaIP9bZXJdhA+sf25pZHB4AIFVnhY
 vC2Y15zVR0PEiD0p9wJ06OSl4VLG0bgRYNt9XruOY6L79aKwdDbrO+XTqGeRIDFgVjdn
 JcFg==
X-Gm-Message-State: AOJu0Yw2ag0xVTOkbvss7iJLQhk0IkhuxpM+qNVYNG8fRUw47FGBc7WE
 EznDZjLE05ORo7gmGvxKfjWlTa4q1GBFUxlpT2aYbG2rKIJxcRHOJzuSS73mEMEk/VWg6xxtwxe
 +//p0BbP0
X-Gm-Gg: AeBDiesFkZ6hBaxwCLEqA55lXtZl0b6hPs//DmhzUeCvDHTidj4GfoLYVhRz64w3wjR
 HD1uX+Z62FWdUi6JNvAEP0agf7XbI9z8wxQWXfUdMOAsyt1FkrMNTUkPjQV88feRN+PWKLhkF52
 eQT38BrgGtMyiz4WmHSHvZafMr8p803rDjRYE8wZQ9IfpBOsgSfhcQ3eA07mL2G+CFarQlLGnz3
 4QLl+HQsXP6dtEqjOSNw3maRhif9IUXWRQwB1F+RFMJALjTluISYRDF/R+9LM2Wc/rNMPG9eSdt
 tzBH87idu/nGFgFEm63rbvDz4KIRmlHBamZwDMYHaXcMnbftkyUdAb1pFuAWOv/V44dI4sq8w9l
 S5qchw1LUORqOS6wCOW1srg54d1yT1Gz3U0kQFhjIOmbeaFS6t8FxMRlx0sIQ5W8eTObdOCI9KA
 /1fDhfJJRqhY4lZxdjSw==
X-Received: by 2002:a05:6820:81e:b0:682:b064:ecf3 with SMTP id
 006d021491bc7-682b064ef39mr3856669eaf.3.1775385767448; 
 Sun, 05 Apr 2026 03:42:47 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42330d4a3c1sm3914436fac.1.2026.04.05.03.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 03:42:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Greg Malysa <malysagreg@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH v3 1/2] kbuild: Move U-Boot .incbin rules to
 Makefile.lib-u-boot
Date: Sun,  5 Apr 2026 04:42:20 -0600
Message-ID: <20260405104224.530051-1-sjg@chromium.org>
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
-- 
2.43.0

base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
branch: font-us3
