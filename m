Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77EAD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 20:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6390B83B64;
	Mon,  8 Dec 2025 21:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FABfc4BB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE8583B71; Mon,  8 Dec 2025 21:47:46 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EAB83990
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 21:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CA77B403C9; 
 Mon,  8 Dec 2025 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765226864;
 bh=aVi7i7J/29R+GGn/QKld0/FVpfWnq2ciiNYUYEE67wg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FABfc4BBFGOgWo77CnssrMYvLTZrxlMCyNEYv9UdflytLzpLMw9EYSgZymzPMEmES
 lGk42QJj3Mca6+Evpvdq9HA1Um8CDllwyojpX3WiVJdiZauNMI/aWke6reA2XrEyaN
 A9SBeeKj817moxWxlcCu+8OYpCg26G1c35Ij6QjSP7JXfB98eSWr+9XJa9pNPS9Obz
 wKADB7/JkAy7mcuaFcs3BtJLV658kjECU4xUWHI0r4gxCje755IUJO+hPmCAs15CKo
 GStiOIcMfUEoKKzYc5m+9x4on+xKGVSVM/4O8JKw6RTI/Mj02lzJowwr0K1yy7S/oT
 cYWR/ukK/DLqiMeMyG/eywgbM0LxP1jaaI9A/RpJ42sZd2d1X/Yxy0KcLmrtCs+KGM
 mf65TiYRtfXoITJGBnGgfFSzCoVneMXsPWM+4w0EXVUJe1yspdLst5jN9D9jMf4VM7
 uA9QeForTfVDim+7Q2064v/ZxVYTUl81u2A8r9qf/XbTWHIrzQM6YMYWzclRMGlrCj
 Z/OMg5n8kghxmoOvSKO5umLKH1J1rvF6oAl3knyL9BotD9AvjSn68XKpF972atF6Tb
 X55vh5Tf0xGjXaurRoObFK0Mjfw3Vx/jEgGDVrUnyKgUQmaruga9kVWmLCzk76Ntyk
 fS+d1X3E5s6NSref/MNnV6aE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] Makefile: use --output-target instead of --target
Date: Mon,  8 Dec 2025 21:47:38 +0100
Message-ID: <20251208204738.62792-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The objcopy man-page teaches:

    --target=bfdname
      Use bfdname as the object format for
      both the input and the output file

This implies for --target=efi-app-x86_64 that the input file would have
to be an EFI app.

Objcopy in binutils 2.45 checks this more strictly than previous versions
and refuses to accept an ELF file as input with --target=efi-app-x86_64.

Replace --target by --output-target for building sandbox and x86 EFI
binaries.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/config.mk | 4 ++--
 arch/x86/config.mk     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 9a61e803a57..275661a1f3a 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -50,10 +50,10 @@ cmd_u-boot-spl = (cd $(obj) && \
 
 ifeq ($(HOST_ARCH),$(HOST_ARCH_X86_64))
 EFI_LDS := ${SRCDIR}/../../../arch/x86/lib/elf_x86_64_efi.lds
-EFI_TARGET := --target=efi-app-x86_64
+EFI_TARGET := --output-target=efi-app-x86_64
 else ifeq ($(HOST_ARCH),$(HOST_ARCH_X86))
 EFI_LDS := ${SRCDIR}/../../../arch/x86/lib/elf_ia32_efi.lds
-EFI_TARGET := --target=efi-app-ia32
+EFI_TARGET := --output-target=efi-app-ia32
 else ifeq ($(HOST_ARCH),$(HOST_ARCH_AARCH64))
 EFI_LDS := ${SRCDIR}/../../../arch/arm/lib/elf_aarch64_efi.lds
 OBJCOPYFLAGS += -j .text -j .secure_text -j .secure_data -j .rodata -j .data \
diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index 6d4839dfb38..c2bb5549b7c 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -69,7 +69,7 @@ endif
 
 LDSCRIPT_EFI := $(srctree)/arch/x86/lib/elf_$(EFIARCH)_efi.lds
 EFISTUB := crt0_$(EFIARCH)_efi.o reloc_$(EFIARCH)_efi.o
-OBJCOPYFLAGS_EFI += --target=efi-app-$(EFIARCH)
+OBJCOPYFLAGS_EFI += --output-target=efi-app-$(EFIARCH)
 
 CPPFLAGS_REMOVE_crt0-efi-$(EFIARCH).o += $(CFLAGS_NON_EFI)
 CPPFLAGS_crt0-efi-$(EFIARCH).o += $(CFLAGS_EFI)
@@ -127,7 +127,7 @@ endif
 endif
 
 ifdef CONFIG_X86_64
-EFI_TARGET := --target=efi-app-x86_64
+EFI_TARGET := --output-target=efi-app-x86_64
 else
-EFI_TARGET := --target=efi-app-ia32
+EFI_TARGET := --output-target=efi-app-ia32
 endif
-- 
2.51.0

