Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F19C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF6688A75;
	Sun, 11 Aug 2024 16:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TAxOoQ9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D036388A95; Sun, 11 Aug 2024 16:52:55 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84A788B2A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so201735139f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387972; x=1723992772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMiCbuMttxcqPPlARM4XLKVYwCWIZE5EuK9sImcrxM8=;
 b=TAxOoQ9tt6OYuKxGPfnwiz4/ghxDRLaXdt/asZEyBT6XMOnxuelI7Gb7muEZVAoW56
 of3eJLhpzT9+FclpAynEuQQI46du/+AD4RjQoW1W1x4Aq+Phase40hTvxF0hhLysaHl8
 WRchawgyCY9hZ6pipxpQ104X63WgBoUwKAyto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387972; x=1723992772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMiCbuMttxcqPPlARM4XLKVYwCWIZE5EuK9sImcrxM8=;
 b=G1ArchPApzZbSCe0zOnib5nzkQ08fVt2cCp5LJBanL+p7rUEAqJEd/F4xx2YQBDrrJ
 37Lp5wY36NGnHWn3RUBNdDX4ZaU8nJX700EtOmAqfvKiSWboGdTnDKEwKCkoFf/atOhg
 MXPbwo80e3v4lV/K6rpuc/ohMtypSpuk8yi+B+tNJVQm6wfF8eDVYFB3kHmm8QfS2W0Y
 4cahD+OsIps09uJjU/gDvKXctTvQByY2p/JNgZk912aYPYGR3Ce3P5ojBI4+duJnQsLX
 50/a3fdOIYTOPthFSIzMSqjAH01HqGraEcpDtUMgFgRjzsOQ7BPXCMweIM0BZGHGkIeJ
 0oKw==
X-Gm-Message-State: AOJu0Yz8Wdbvn593P/k0HwD+SL6lAbPRPEGMiRoWdKBA4dLnm9YAcw/v
 I1CxEfAAWOsDMsiS1YAWAYlXyKAiItvEUowjo73ybTT870KejJpTJIMUGs4/S5HOQXKVzrghX/U
 =
X-Google-Smtp-Source: AGHT+IH/Pkw1QWP5FTjyNOaWQYbszvk1oV2RLi6mVex1BLQRyzBEEhu3UnolHK+5ioWJrAezOWk00Q==
X-Received: by 2002:a05:6e02:1a86:b0:39b:2d7d:7289 with SMTP id
 e9e14a558f8ab-39b8122a0d6mr86894925ab.23.1723387972309; 
 Sun, 11 Aug 2024 07:52:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 28/40] efi: arm: x86: riscv: Drop crt0/relocal extra- rules
Date: Sun, 11 Aug 2024 08:51:57 -0600
Message-Id: <20240811145209.4191404-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

