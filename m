Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F715C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F054088AFB;
	Thu, 15 Aug 2024 22:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WXIBEF4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E86A88AF0; Thu, 15 Aug 2024 22:24:44 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3AC88A9F
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso5970075ab.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753471; x=1724358271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWYN0mDotxYJS2S1NKzfTVGNuN9DXy8T4vA3uR3tL08=;
 b=WXIBEF4iJYLkZY7F2EeYIHaIUZSUvFsrx55c2YUWN11pxRxLrT3R2R/26RrXQCTRr9
 Z5vohgYnxEh+gh9nUnpm6wGtk3VX/YMR589jFNzOMJx7+mIJLilGqhgBcFsyvmwrB0jS
 VC0DgjuRUTCT4bYWWcXszZGSfuavgoCuPxsBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753471; x=1724358271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWYN0mDotxYJS2S1NKzfTVGNuN9DXy8T4vA3uR3tL08=;
 b=ebF2vVwTGeqPSW3GP6HZKiEWBcSozKKXUjRBFbkHLR8eHocpiBgeuJSiAE8i7EeUnF
 sA1LD0MJYNF0f72IKVU6wvU2ivshTkAx0IE2QSbu8aUpdoE3siPF7UGH19M9QbTFCXOM
 9mTFyA9XeHYpipoPgps4RLYl9JDJlNO125lTSDTIGLKungN/ocgEPQG4ocyXQiWpGjUt
 BjyZKMjSyVCAcQCm3jc6Xt7DG+BYG2ONj6aiKXsB3uKNcL1jKPY6T/picCr8IMt1jv2Q
 ltkz+9qIhxdkmUoZi7iJgDyGBqk7mkdIZBZtmgtKjTRR6Vg0e9ERjEFxEWbtpltVDBGL
 tm6A==
X-Gm-Message-State: AOJu0YxNJVxiOEX7MnCMoEvblcP5HlJiI8lspDPGgTxgHaDu6aRToB2A
 HgzI/6buaQxy3DPtrLDguxDbxVbpxBjPMReEcqXJPou7Nfxbk2qBb2uBKWN5sgW9LBjs20OGS9T
 TIA==
X-Google-Smtp-Source: AGHT+IHQOKM64GBPiqvXTst7NMMhjKJfHgS/DxQpj8hXlqWBqgPa5EKi30l9uRpLb//Xspc3orK3bg==
X-Received: by 2002:a92:cdaf:0:b0:398:770d:1fa4 with SMTP id
 e9e14a558f8ab-39d26d75d85mr12022555ab.25.1723753471163; 
 Thu, 15 Aug 2024 13:24:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 04/14] efi: arm: x86: riscv: Drop crt0/relocal extra- rules
Date: Thu, 15 Aug 2024 14:24:14 -0600
Message-Id: <20240815202424.766778-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

