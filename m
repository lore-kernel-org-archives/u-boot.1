Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61143C54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC8388A92;
	Mon,  2 Sep 2024 03:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TixoRfWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A187C88A30; Mon,  2 Sep 2024 03:18:42 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F219889AE
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-82a20efed34so193838139f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239919; x=1725844719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWYN0mDotxYJS2S1NKzfTVGNuN9DXy8T4vA3uR3tL08=;
 b=TixoRfWtKPivfuQLj0OigBJPOZRJM0Eq/6EtIjf19eo+dPMsjMG6uRxrJsHMEV54v6
 NzxpVcEHwwRx0ta/gwZ/HDkKMaIq0OT1T1qaDZmxXDw2z3wpaWOj3IcuzCyFMjBc+av6
 PUPwAyV8c7L/GFJ/W07MyrVGZ7DnbomXQY5O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239919; x=1725844719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWYN0mDotxYJS2S1NKzfTVGNuN9DXy8T4vA3uR3tL08=;
 b=UW2oleZZwJlY4IGI9RnyA3V/c0oWlFDAxpelIRwC6402P3hNWkH/wg/2NYnvru2CXE
 4fki8oJqXrsjX7c+Lycg3xWAtPynsKD7oGUwbGKVea9ty9zkGSVndIn69fdHbY1/72+c
 PKSWJUnNpTkr79/VxsISWHqxQgg9A0Z5pQ+LqQ6EcLZf1zPXmQKqbuzd68EBGmjojDew
 Ic6PfPGB+8paUoOwhqIYy60uVe/AxobpBvSfCRQi0ToUpnkaaGfjEFK51JdEFooCGKSR
 5zVtt6vfp7CODPIdsgxLPQXxHXjYzEIkt0TIpPCxR/LkJSrpaIIGHVA3TWFB7DK7yfNM
 H9Gg==
X-Gm-Message-State: AOJu0YwMtmHrAwEXV0W8jQPg8EPlzMZHLqvN7hy6yG5IqxfpGdynzqld
 gWmzGtJXM4nvfV9VAsBrZBHWGoaph+M5QSHT/NNOzVLIhUvQiOKLNXXeEYyLO9T2bh383fA1bV8
 =
X-Google-Smtp-Source: AGHT+IH1AURKD1auUtlJExJXjg/NjQFeE2+BcFSryDNuKzgsOFa81XxlH4DDSBn8kFygM93EBXjEmg==
X-Received: by 2002:a05:6e02:156e:b0:39b:3462:70af with SMTP id
 e9e14a558f8ab-39f49a30af9mr58581925ab.8.1725239918717; 
 Sun, 01 Sep 2024 18:18:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 04/14] efi: arm: x86: riscv: Drop crt0/relocal extra- rules
Date: Sun,  1 Sep 2024 19:18:15 -0600
Message-Id: <20240902011825.746421-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

The link rule (for $(obj)/%_efi.so) in scripts/Makefile.lib handles
pulling in efi_crt0.o and efi_reloc.o so drop the 'extra' rules.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v3)

Changes in v3:
- Add new patch to drop crt0/relocal extra- rules

 arch/arm/lib/Makefile   |  7 -------
 arch/riscv/lib/Makefile |  3 ---
 arch/x86/lib/Makefile   | 16 ----------------
 3 files changed, 26 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 4e54c577cc3..87000d1609b 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -129,10 +129,3 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
-
-# TODO: As of v2019.01 the relocation code for the EFI application cannot
-# be built on ARMv7-M.
-ifndef CONFIG_CPU_V7M
-#extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
-endif
-extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 4f6272aab6e..bcfdb516b76 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -36,9 +36,6 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
 
-extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
-extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
-
 obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMSET) += memset.o
 obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMMOVE) += memmove.o
 obj-$(CONFIG_$(SPL_TPL_)USE_ARCH_MEMCPY) += memcpy.o
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8bc8d92172b..d6ea9c955f8 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -87,19 +87,3 @@ extra-$(CONFIG_EFI_STUB_32BIT) += crt0_ia32_efi.o reloc_ia32_efi.o
 extra-$(CONFIG_EFI_STUB_64BIT) += crt0_x86_64_efi.o reloc_x86_64_efi.o
 
 endif
-
-ifdef CONFIG_EFI_STUB
-
-ifeq ($(CONFIG_$(SPL_)X86_64),)
-extra-y += $(EFI_CRT0) $(EFI_RELOC)
-endif
-
-else
-
-ifndef CONFIG_SPL_BUILD
-ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST),)
-extra-y += $(EFI_CRT0) $(EFI_RELOC)
-endif
-endif
-
-endif
-- 
2.34.1

