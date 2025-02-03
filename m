Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05492C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3548807D9;
	Mon,  3 Feb 2025 18:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QxjwUSRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246A2805E2; Mon,  3 Feb 2025 18:43:38 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D0B800D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb9ba53f90so1387035b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604614; x=1739209414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Tc5qLq84GyaUI8M387bFLUNmXelCjSb02RgBh22ink=;
 b=QxjwUSRDF3qe8BoxF00AOVKpB036Ldtdb54eDdZcIcrCQMi1z324XkLKFXgFejxbhb
 7lNzK53RwuY0iSZ6vdKfhHTKs5ofgOaLiUl33bW7u1hTRTSgZ18YJjDDQ2fDcQmzGvFv
 jJ+vEMGo8mtDjxXrBVYckhBoIaNRnOEnwXWYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604614; x=1739209414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Tc5qLq84GyaUI8M387bFLUNmXelCjSb02RgBh22ink=;
 b=UtE0XyZLknpqDiWv85gPdX+TLQ6dSuR5RBDF95E/zvXR9Jp9E0ElCLpBzsQLxsu+1I
 /IOjYEPgxRdV4lx0sTczUGgs5vzli7Vk/FdcBUUAKgEm9/GVXoJybZSsFbU4/ySoeHkY
 9Eh6JF/5UFeHanTtOwHODFoFZVTKaF112fbXOBqyUbHHKtAuYauB03BF8/lYaEHC8Hoq
 iQhn2U9KLWuo9uQv8Dc4tC44LboOloeC830MtC6DRGVA+oRHseJeD/rl6uUp6FgboAfp
 ztVhmY5dCdc5vQvkI4hbFekDrJHv1JDd9B8iA10dEVAZHF6Ca3UWQdusdWg6UwPIluzH
 KJTw==
X-Gm-Message-State: AOJu0Yy9Bm7KADnxnNHnef4rDrwrDzN8Q8pm7EzPBTR0IR2zuWz7dwsn
 ZbrbQRuDMVlWpXNRNCQPaKAPJZSb7EkEegLv/ISRYC/A9gZyCXTagfiL40ADJIlhtW47SK2pFAY
 =
X-Gm-Gg: ASbGncvzIy1W+LWdc8PsIcXMB8I1/0LLDMRM3ecK3DVwcG4iCh0xpmCahEW0CsS8egU
 hLgRJzoENpK9LPAx9NVcISMSwG9j5ABbEVwu636N9Yyjq8TnXO30y1hnED1p20EADmSkMNMooVH
 5rFIr0wa97DBOmyLkgJ2xMhw3rfIAEoTGO4jWllFsf8a5xobMTTqhtX5CvzGLdijhTre2J56W4P
 g7eim/14JnWuReuapC82c8JX2jO6qH8rErHz3G7XI0iMoGwGGGLx+iCl2QRt9QAQ9fyvwqJ8JbG
 EABU87r2+HW71j9QBeQPYxXz1tWCzCd0EANhSzxjeq171xynp0Fo
X-Google-Smtp-Source: AGHT+IEcc4ZSU/Mlg+LKsrT7xG0DeEWpb0i01xCgIAHmpKA3cAI1RGVMUAuQ66LsPDfps3u3ESkC9w==
X-Received: by 2002:a05:6808:164c:b0:3e7:bcab:8f11 with SMTP id
 5614622812f47-3f323a7227dmr13939425b6e.18.1738604613809; 
 Mon, 03 Feb 2025 09:43:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/32] efi: x86: Move EFI SDRAM-handling into a common file
Date: Mon,  3 Feb 2025 10:42:03 -0700
Message-ID: <20250203174245.1331464-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

This code is not actually x86-specific, so move it into the lib/efi dir
where other archs can use it.

Drop inclusion of the unnecessary x86-specific header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/efi/Makefile         | 1 -
 lib/efi/Makefile                  | 1 +
 {arch/x86/cpu => lib}/efi/sdram.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename {arch/x86/cpu => lib}/efi/sdram.c (94%)

diff --git a/arch/x86/cpu/efi/Makefile b/arch/x86/cpu/efi/Makefile
index 9716a4ebe08..9be1d5e5401 100644
--- a/arch/x86/cpu/efi/Makefile
+++ b/arch/x86/cpu/efi/Makefile
@@ -4,7 +4,6 @@
 
 ifdef CONFIG_EFI_APP
 obj-y += app.o
-obj-y += sdram.o
 endif
 
 ifdef CONFIG_EFI_STUB
diff --git a/lib/efi/Makefile b/lib/efi/Makefile
index 315625c0e8c..5081d71a19f 100644
--- a/lib/efi/Makefile
+++ b/lib/efi/Makefile
@@ -3,6 +3,7 @@
 # (C) Copyright 2015 Google, Inc
 
 obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o efi_vars.o efi_dtb.o
+obj-$(CONFIG_EFI_APP) += sdram.o
 obj-$(CONFIG_EFI_STUB) += efi_info.o
 
 ifeq ($(CONFIG_ARM64),y)
diff --git a/arch/x86/cpu/efi/sdram.c b/lib/efi/sdram.c
similarity index 94%
rename from arch/x86/cpu/efi/sdram.c
rename to lib/efi/sdram.c
index 6fe40071140..bd59dfade0f 100644
--- a/arch/x86/cpu/efi/sdram.c
+++ b/lib/efi/sdram.c
@@ -6,7 +6,6 @@
 #include <efi.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.43.0

