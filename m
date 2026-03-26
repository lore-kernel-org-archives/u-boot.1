Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E8010A1E82
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E1983E76;
	Thu, 26 Mar 2026 12:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cW4TyyEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F00483F14; Thu, 26 Mar 2026 12:55:17 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7E781E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-46726528f1cso536118b6e.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774526113; x=1775130913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OP5IoAJBR58biIqTCrkgk6Mvus+34Pd5UVdC5e5GZNw=;
 b=cW4TyyEfD1flKeTqSM63yXLL/s4ysUcVGHh8mu/UnNN4wsSXvPi5+y7foBbUrLXwLd
 qzhV8r1QtO/jCd1zLg7A8wz1lc3Ksk6SfYwA6iN6u76FN1cisjijIOJ3BZDpAoph4vrY
 CllsKajdQHL1LMx/mzDAbrofGTRdO+mkb3MJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526113; x=1775130913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OP5IoAJBR58biIqTCrkgk6Mvus+34Pd5UVdC5e5GZNw=;
 b=NvLC8xnoq1wuJIrYvq9RkfJENyvDNDFwafgIN035pYBytyTFXYTRrDt+SqlJv1QM36
 JcroODcMeIGymyfotKwcjQcx5Uou/e4wjNEVqAdXkANbI8pwUfOiW1eMpHdN4ck68JJ+
 pzqbdMaoqV/DnVoRwvSXccnOWbMCLclQSBR68dKJ3SBFjrQt+pSqX28Kl8S30BiiDUTv
 9LUtSnGzp1ZBdkIwNQZjgbPNIIQif8Y8cg4EJv7ISOsZj0oWWWmfSo0HVru8hGrKC337
 wWb6QruKxMdlBuuJ+ip2oNxdDEuZzlXJUk+fmCQI3u/F2S0WrR6S8Nbr21tczZ6sEjyR
 2Vrg==
X-Gm-Message-State: AOJu0YyZGJIIlns5bw5tTODPa7pqWQfUhCRUanfqwrO/HpXni3Xhx1Os
 CKVMAD7jE63VISppnDD+WUEigVH2PjceE/v5ORqRp9unzwUS4xuyrKsesAp0XZ9G2Fl3EPbD95n
 ESWejSbhW
X-Gm-Gg: ATEYQzzZCW8IW172bSQ9wZGsjoLsR6T3cKQpkSU0LXQtVrPJo5ZZaz3lTrOqboUQVx+
 h/QzoiFBEKechAoKbZ5Nwya/lOLeGyaahecHc8DrH7aTd/xRXrcwkhxohCN84XYkMnn15xH3RDm
 1oXUGbxi7ryq8rZ4IAq8OrgYmqG/xOyCt+Pa62WYrkM1bbwd+0R5H0aWaHxFV4YYpaFfWnqL64P
 w0cIy0jqLh1sOADE/xB4kgO+cxj22tDDguLxZgJgB72DV7KDe5XXqGL0rCUICCTEZkyBleOzK7T
 eL2qxmySjR8KzZfTBXu+n+83guymn4UMjocUcvfnpJEfreDZaqZa+p49hchp0trN+CoeTO+vmFI
 eE2FS6yOSljT/d6PezlGO88EpwuPBA69L8rDBVsjq6vPtjgwTp58S0C/Q8FBiVYXFkDfPFcPLLA
 iaNmDGB7aGH24sV3LfYVebktkm8A0F
X-Received: by 2002:a05:6808:50d9:b0:46a:7ab9:c339 with SMTP id
 5614622812f47-46a7ab9c72emr310601b6e.14.1774526113128; 
 Thu, 26 Mar 2026 04:55:13 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7b6312csm2145860fac.15.2026.03.26.04.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:55:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH v2 1/2] kbuild: Move U-Boot .incbin rules to
 Makefile.lib-u-boot
Date: Thu, 26 Mar 2026 05:54:56 -0600
Message-ID: <20260326115500.955388-1-sjg@chromium.org>
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
---

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

base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
branch: font-us2
