Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3968BC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDA5830E5;
	Thu, 17 Apr 2025 20:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AJFhoeLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11F283158; Thu, 17 Apr 2025 20:17:15 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C1383145
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d5ebc2b725so3885975ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913831; x=1745518631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNn+l1VdVXhRajZ9LTqcpVvmjUrYqaHWZA2MmXxbO6w=;
 b=AJFhoeLtzUdceo6PVYo2a66WG7M2NeOkqqV0x3Pr0rKoA8hPUbY3MxB6mMu23ulskT
 GJWss8e4gygmTBAwDHzjVNN7tc8qwNQocx7EwSbHA79euXdQrzACssr0DUgb3gyrMemz
 GY6radq6Yav+AESvPxavr+DzGiGled3DKFuC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913831; x=1745518631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNn+l1VdVXhRajZ9LTqcpVvmjUrYqaHWZA2MmXxbO6w=;
 b=l59gq7ulFuOeKjsrXsWuxP28r+CPBH/gN9lXBbiNa7QC84569JidnZgcZGIXRuG26T
 ZZMnI57N7pY//RT9hNjRXx7AkYfu92T64RdY3fbyd4dgHjLVULwAmk0c9Ns6GJNtyQmP
 LP+eJBIYT9066f9ExkeCdlNLiEncGBp8CCEcyLTBhf4fxwzkfEALiBoPqD1pdji6kHC0
 R68L5ut0BCd4ni49QRhwtiKhS98zm9vCFk+EhSSvGlkiLUH35vT0i02iaLrq38kXfmds
 XioaMFnWg2zRoW+qsy8jFNae6F2zSNHaNJmMaaXJpu43k5ac4lpAk6zGksLIudgaEF/2
 JzXw==
X-Gm-Message-State: AOJu0Yz3LMswDLy64l8GYk0hWW5K9mWigtMv0A5uU2QxaBRBwudlHNuN
 gc7SUGfRTgOnCb4RPUwDKrbSPZwcC9/9izMrGEyBR16BAtVrctM7QwCDVX7O5S6GpWwZqNSlQ0Q
 =
X-Gm-Gg: ASbGncvFtEMmP+Z2M8dKM0ElBPb3g/OgHfOGo/HaGDAxdD8YyDlrUtJYjQ4xe3rWb8V
 0JL6mgy1zb8hNKOAOA1tT9QWX8VJf+9SRP3fGuK8j0wBWMgsg8xQckq9z9VC7NhnosjNwQ90nLx
 fGNQj/CJv5Mgrue417GE+EXkJK54pDITEJH197Xr11F1gltEFkXSITgDtDGHw6f7k17Ro/XpCvf
 R14cF5kOJYSCywWzTrDKJ1eQGR8fOLLxFFXK9FoKtDr0KRkgp0HiD4JAN8rN7AnKTji85ZVtEoX
 Xc4qGnrpy+Ifl3cXBznkeugDGxzQBO4dLKnnKBJBeZhiezjUX7q67EHaAzMRFwJe7ZHebJmOdHV
 XGQ==
X-Google-Smtp-Source: AGHT+IEAtlu7Djdg5h2DE+dzHlCo5ip7PBPEd9NhQDe95YhCody1cmO9A/4cbKQuSgv1QfyGv6HRUw==
X-Received: by 2002:a05:6e02:2683:b0:3d8:1ea5:26d1 with SMTP id
 e9e14a558f8ab-3d89417e663mr792235ab.18.1744913831269; 
 Thu, 17 Apr 2025 11:17:11 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>
Subject: [PATCH v3 16/22] xferlist: Drop old xferlist code
Date: Thu, 17 Apr 2025 12:15:58 -0600
Message-ID: <20250417181613.1355024-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

This is not needed now, as the startup protocol is handled in
arch-specific code early in boot.

Drop BLOBLIST_PASSAGE_MANDATORY as well, as OF_BLOBLIST is enough to
cover this. With standard passage the devicetree is accessed before the
bloblist is inited.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/Makefile                   |  1 -
 arch/arm/lib/xferlist.c                 | 23 ---------------
 arch/arm/lib/xferlist.h                 | 19 -------------
 common/Kconfig                          | 11 -------
 common/bloblist.c                       | 38 -------------------------
 configs/vexpress_fvp_bloblist_defconfig |  2 +-
 doc/board/armltd/vexpress64.rst         |  2 +-
 include/bloblist.h                      | 26 ++---------------
 8 files changed, 4 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/lib/xferlist.c
 delete mode 100644 arch/arm/lib/xferlist.h

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index ade42d0ca43..31497394580 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -86,7 +86,6 @@ obj-y	+= psci-dt.o
 
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
-obj-$(CONFIG_BLOBLIST)  += xferlist.o
 obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
 
 # For EABI conformant tool chains, provide eabi_compat()
diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
deleted file mode 100644
index 6425936d354..00000000000
--- a/arch/arm/lib/xferlist.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2023 Linaro Limited
- * Author: Raymond Mao <raymond.mao@linaro.org>
- */
-#include <linux/types.h>
-#include <errno.h>
-#include <bloblist.h>
-#include "xferlist.h"
-
-int xferlist_from_boot_arg(ulong *addr)
-{
-	int ret;
-
-	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
-				      saved_args[1], saved_args[3]);
-	if (ret)
-		return ret;
-
-	*addr = bloblist_get_base();
-
-	return 0;
-}
diff --git a/arch/arm/lib/xferlist.h b/arch/arm/lib/xferlist.h
deleted file mode 100644
index 60d79c1a8eb..00000000000
--- a/arch/arm/lib/xferlist.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
-/*
- * Copyright (C) 2023 Linaro Limited
- * Author: Raymond Mao <raymond.mao@linaro.org>
- */
-
-#ifndef _XFERLIST_H_
-#define _XFERLIST_H_
-
-/*
- * Boot parameters saved from start.S
- * saved_args[0]: FDT base address
- * saved_args[1]: Bloblist signature
- * saved_args[2]: must be 0
- * saved_args[3]: Bloblist base address
- */
-extern unsigned long saved_args[];
-
-#endif /* _XFERLIST_H_ */
diff --git a/common/Kconfig b/common/Kconfig
index 1f908790139..773ea3c9e7f 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1079,16 +1079,6 @@ config BLOBLIST_ALLOC
 	  specify a fixed address on systems where this is unknown or can
 	  change at runtime.
 
-config BLOBLIST_PASSAGE_MANDATORY
-	bool "Use bloblist in-place mandatorily"
-	help
-	  By default U-Boot will use a bloblist in the incoming standard passage.
-	  This option controls whether U-Boot tries to load a static bloblist or
-	  allocate one if a valid incoming bloblist does not exist.
-	  Select this option to mark incoming standard passage as mandatory and
-	  U-Boot will report an error when a valid incoming bloblist does not
-	  exist.
-
 config BLOBLIST_PASSAGE
 	bool "Obtain bloblist from standard passage information"
 	help
@@ -1111,7 +1101,6 @@ config BLOBLIST_ADDR
 
 config BLOBLIST_SIZE
 	hex "Size of bloblist"
-	default 0x0 if BLOBLIST_PASSAGE_MANDATORY
 	default 0x400
 	help
 	  Sets the size of the bloblist in bytes. This must include all
diff --git a/common/bloblist.c b/common/bloblist.c
index c7322b96bcb..d0e92acfee5 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -503,14 +503,6 @@ int bloblist_reloc(void *to, uint to_size)
 	return 0;
 }
 
-/*
- * Weak default function for getting bloblist from boot args.
- */
-int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
-{
-	return -ENOENT;
-}
-
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
@@ -587,33 +579,3 @@ int bloblist_maybe_init(void)
 
 	return 0;
 }
-
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
-{
-	u64 version = BLOBLIST_REGCONV_VER;
-	ulong sigval;
-	int ret;
-
-	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
-			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
-		sigval = ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
-	} else {
-		sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
-	}
-
-	if (rzero || rsig != sigval)
-		return -EIO;
-
-	ret = bloblist_check(xlist, 0);
-	if (ret)
-		return ret;
-
-	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
-		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
-		return -EIO;
-	}
-
-	return 0;
-}
diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
index 4d52b96202b..9d59e016b5f 100644
--- a/configs/vexpress_fvp_bloblist_defconfig
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -1,5 +1,5 @@
 #include <configs/vexpress_fvp_defconfig>
 
 CONFIG_BLOBLIST=y
-CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
+CONFIG_OF_PASSAGE=y
 CONFIG_BLOBLIST_SIZE_RELOC=0x10000
diff --git a/doc/board/armltd/vexpress64.rst b/doc/board/armltd/vexpress64.rst
index 109337d7fe3..ebf1ec77c7a 100644
--- a/doc/board/armltd/vexpress64.rst
+++ b/doc/board/armltd/vexpress64.rst
@@ -103,7 +103,7 @@ bloblist, or utilizing a standard passage-provided bloblist with automatic size
 detection.
 
 By default, ``vexpress_fvp_bloblist_defconfig`` uses the standard passage method mandatorily
-(CONFIG_BLOBLIST_PASSAGE_MANDATORY) because TF-A provides a Transfer List in non-secure
+(CONFIG_OF_PASSAGE) because TF-A provides a Transfer List in non-secure
 memory that U-Boot can utilise. This Bloblist, which is referred to as a Transfer List in
 TF-A, contains all necessary data for the handoff process, including DT and ACPI
 tables.
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..6ea864bf896 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -467,8 +467,8 @@ int bloblist_reloc(void *to, uint to_size);
  * If CONFIG_BLOBLIST_ALLOC is selected, it allocates memory for a bloblist of
  * size CONFIG_BLOBLIST_SIZE.
  *
- * If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected, bloblist in the incoming
- * standard passage is mandatorily required.
+ * If CONFIG_OF_BLOBLIST is selected, a bloblist is required in the incoming
+ * standard passage.
  *
  * Sets GD_FLG_BLOBLIST_READY in global_data flags on success
  *
@@ -492,26 +492,4 @@ static inline int bloblist_maybe_init(void)
 }
 #endif /* BLOBLIST */
 
-/**
- * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
- *			       the register conventions according to the
- *			       Firmware Handoff spec.
- *
- * @rfdt:  Register that holds the FDT base address.
- * @rzero: Register that must be zero.
- * @rsig:  Register that holds signature and register conventions version.
- * @xlist: Register that holds the transfer list.
- * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
- *	   conventions.
- */
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
-
-/**
- * xferlist_from_boot_arg() - Get bloblist from the boot args.
- *
- * @addr: Address of the bloblist
- * Return: 0 if OK, else on error
- */
-int xferlist_from_boot_arg(ulong *addr);
-
 #endif /* __BLOBLIST_H */
-- 
2.43.0

