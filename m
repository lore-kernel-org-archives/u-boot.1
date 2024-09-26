Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC9FCDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45EB88ED1;
	Fri, 27 Sep 2024 00:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D2ReB4WE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881B088EC9; Fri, 27 Sep 2024 00:00:49 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8F788E9F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e22531db3baso1514588276.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388046; x=1727992846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpghxRb9gXK6ZpZvSrEIS0pABSRGGJJzjUN0aGDhTNA=;
 b=D2ReB4WEsAjEqNDfuocoqxgp9IrTb+wh6s6rsIs6G1dHqggSFciHlBSXoGUzh4acoP
 3qsPn5FLqZMXCmtdLBzauEYX6UMMapC2s0l5bvUZhkz1Pjo14+X07JN8rgid2hSCbAi4
 0SsGdGnSxrU09VOHorVYMOCE9Fn/LK7L9BVss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388046; x=1727992846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpghxRb9gXK6ZpZvSrEIS0pABSRGGJJzjUN0aGDhTNA=;
 b=HR6KwDZou8bs5mQtQDwBumB77E5Jvwau0iMjmSvqOluTWm5/NNeM/6408oBCVJzFOL
 P8dWx/KKJYTwciY1Iyas3sx6/YUo31biFLdPiSDfjQy8B3wn1xywRqb27eUHXcHcxSia
 toaDvxAN4DBXgimaMcIoWHrl8g6gz/f1d4L4e3s/r9NyVFPESMfyKPurIP2rp2z3ZQQp
 pymjZWYhJyWSdc0LuagNoD9TMylnhd+c3npAFGXU7wHXVHcch47HxDXqaEnmT6IRGJo9
 R1IPJMhs+vAVzBZS2Ju4A8UhvwsNzXMssz9Os1XAaZubh3MjraLthETkN+4sRm7dsuaF
 tT5Q==
X-Gm-Message-State: AOJu0YwkARhxf4725FikYStfHXePeEA7OJXznGlmyN1Dln6uQMF0EaLA
 nl8IcCghXXvdgSAGZeDhblDZVN+ZVkJTZJVKkDsrz/N4EEFBjKUWKnPqq2RMKAupDNM/F2HA26p
 rIJS1tlw=
X-Google-Smtp-Source: AGHT+IFtJ1wIIgdX0pAVG2J0y3FuYc99BLAiLTBysVPZLJEBo4lOQqywhklsdlaBvKql047MDhEZZw==
X-Received: by 2002:a05:6902:102f:b0:e20:26cf:2eda with SMTP id
 3f1490d57ef6-e2604b80adbmr848483276.32.1727388045609; 
 Thu, 26 Sep 2024 15:00:45 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:00:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v6 02/12] efi: arm: x86: riscv: Drop crt0/relocal extra- rules
Date: Thu, 26 Sep 2024 23:59:32 +0200
Message-ID: <20240926215950.1265143-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926215950.1265143-1-sjg@chromium.org>
References: <20240926215950.1265143-1-sjg@chromium.org>
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
2.43.0

