Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541A4C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E9382C03;
	Sat, 10 May 2025 15:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AxG7nyPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A5682BF6; Sat, 10 May 2025 15:44:13 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FF682952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso488526866b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884650; x=1747489450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ES4QmobaG14rz2zRxqruy/iELVFYmfSLAOGeXraSXDM=;
 b=AxG7nyPeT+0MW4TDBAhapU+tso1rwdwcGrkDNf9CWkq16ZhFO8xTc+eBz+xsiHGd4G
 PIFyI78g5GwOVrCYcC8nDuFrLDFY1bopsnAaUH11satkA9P0pi7xILtjSHDmTN2nDk12
 rtAR8xHHsQwMSfzHV/O82esaoP7uyZ8s9ltsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884650; x=1747489450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ES4QmobaG14rz2zRxqruy/iELVFYmfSLAOGeXraSXDM=;
 b=IQuMjd1FdCrnGkL17YyjnPP3QRQsFXhnUC3kRZ9aCS1CHSRXTTH6miiCAVj/YNJq6B
 xaTG7J6txcbg8ZR4atnyyzxiJK1qGXayvatEqjYpuqM4ekuzKg+dg9NCjD5Fgz1D9N2o
 9ud9UnTG100z5+lFG3byzTSwnbshUNZ4Hs8gBbfikqSkSSMRbI5sE5HBzIK2tz3ctfJJ
 u/Xj2t91e1iQ3gkmqTvBvjrlpRt6mpcXaYqO9m59eJ2tklqjEQcjQaI/280PJV29r70g
 k+R5wUQiTC+0dBTdeI1t2RENp8RghYuYjhAsYvxLs+zvSb03jkyPwRZA/hWL/Lp4N+DI
 Y1sw==
X-Gm-Message-State: AOJu0YzzPiNqzyfWbuuVlmts6F1a29XlM0UsP8bMKxYGDPoqGvlJbw1W
 S9ZGQU5RCLh29GWwOvqH8zRhk1OXFEfqZ0z13VfpXIIu/SGTTyNkDqP6KH8/hQW+mdPZfIlFwnc
 jp7Z6RHd0rQ==
X-Gm-Gg: ASbGncuZvf00fXfUGDrfyfgTpjAE2UGfl0u7aHede39ajDWiuGEzGo2DWoCzCFf0vM9
 sU6SX6kLiq+hgslOPgF+7jImjldJgA/IBsaV5SNTlhbfwS39VX9lVkAnBXpYTwuvDsmRETz1Rxp
 b4xctGFUwUHzktJJGp0xwq+gCL7xx5hMh43Q4ciXTGglqWMxNdQzmyuzZRPfyrwc2UlDN35Elxq
 stlZtkHN/rS1dMmWpM2JUxNiofGByAtZNy+kysx42R/0lnTTHww/8MBUUzlNr3LOPSLyzp7gn5G
 9A99wfl9Wi6sW8lfr3pU44HKFWMPe77WoMIc0dlOMc8hUEgp+hnewF9u+AR5e6jcwdZsxS6AE6w
 BxnA=
X-Google-Smtp-Source: AGHT+IELn6suMO/Mq6ThvGMUntSmq7L5U0XSo6Ko+7DSBPqH1rb963PlFYps9HzIJarlVor/Fz7TWw==
X-Received: by 2002:a17:907:8687:b0:ad2:3efc:dd80 with SMTP id
 a640c23a62f3a-ad23efce3a7mr148643166b.7.1746884650331; 
 Sat, 10 May 2025 06:44:10 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v4 16/22] xferlist: Drop old xferlist code
Date: Sat, 10 May 2025 15:42:14 +0200
Message-ID: <20250510134253.1581164-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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
index fd5f91bc039..6cc329e503d 100644
--- a/configs/vexpress_fvp_bloblist_defconfig
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -1,7 +1,7 @@
 #include <configs/vexpress_fvp_defconfig>
 
 CONFIG_BLOBLIST=y
-CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
+CONFIG_OF_PASSAGE=y
 CONFIG_BLOBLIST_SIZE_RELOC=0x10000
 CONFIG_BLOBLIST_PASSAGE=y
 CONFIG_PASSAGE_IN=y
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

