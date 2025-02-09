Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F038AC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4EC380BB0;
	Sun,  9 Feb 2025 03:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HDUUToBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B3D80A09; Sun,  9 Feb 2025 03:02:09 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE72580A23
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso10395355ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066523; x=1739671323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEV+88/hx5S6GXwbkmqcDv8GEutu0uwJH6P0jmSpWn8=;
 b=HDUUToBcadyz3LXu0WKE+J6SS4DpulzP5xXUVrlNFHrnNzkeU+lZYRYvFywvO2wSVe
 wSgEt87LLOqeV5wOTv2rdq6UlsybgHmJS/DwJkjLy9CqjPP9HkXF7Fa0ScLe8VrwMSIP
 AR/Jx5NC/cAh2dY8Ihbtpx/5NKd5CGHc9twfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066523; x=1739671323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEV+88/hx5S6GXwbkmqcDv8GEutu0uwJH6P0jmSpWn8=;
 b=a90tGvm4RnBVIxyXptMhcd4GDtRTIDry/O3t+RVkNcors5LZwhWoeWx+Q2eDj4wxHq
 R3KaSO9HCe9Er4YkTxvB6ovySawzmKDvwGIXsCMUmv/f+M65lFyCZIftUVT3oA1wTblv
 ORC/9HjDmGjdOcrYXuduHA9I54KRKYSaee/nDCTM/xA0259s5qaCOW2HgUAB1beii2ut
 kUo30ZdS9KA7WzwsqaGoH/eqbyr7x3RLFvI4EqlwiELsiKgtO8KdUkIiHEfUwG14ktwj
 FiFDXP/f8JeE1vZz1tTVPNFEPZRXEAkTaYcJzVW2MLZZk9/8oVNJ6sz5p/y6WNSikwun
 ACTw==
X-Gm-Message-State: AOJu0YxN5uttcLyyXnu7mOXjZIbJYBZOSugVG+BH0Z6NsrrmRjMS4eDl
 i+EH5XFxaTkOwrFOzV++s/ZQxNML/TmLx/RfV1QhUdyeHFhrVf4U5GshmIHX11tYkRqG4YQR7w4
 =
X-Gm-Gg: ASbGncvsJhKnONLYmaSkXSinL52+kA702tvzK12qx5TN1DwQstIeNEWlnbB22WJoHjy
 xhexbO66AF5b4miBYs+a5+2KxnfsC3UG6jje+JtrkSVx0mLMit9JJV1Jg933HMFsx+PWugDxqk1
 GOvnFNJrRzv+yyBz4Rb4Yo0fjTvuDDJbsZGyrWDuCcB2LBR2eobYMytsMjbUDTsHdi05fDTA4B4
 xhElOYmk+HIevTjjKUSnyNgAwXTRnjfzBLC/44nYIqNEvAlLgIM4Xu6CUAY2vNZLfITogEeB32p
 CHTb9h5P2egLIeNoGOg0WZrtTeLtFoR6Z12g5jF8t+UR3qTaPqy+
X-Google-Smtp-Source: AGHT+IFMYp9QLbjLerFt5W4EYGHbKCqUy+Imq4H0W0R6TNUjIlOB3ouVrqMoYNzFVgPHgBDPJtBsVA==
X-Received: by 2002:a05:6e02:3b84:b0:3d0:1ee6:731b with SMTP id
 e9e14a558f8ab-3d13df00890mr77770725ab.15.1739066522983; 
 Sat, 08 Feb 2025 18:02:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>
Subject: [PATCH v3 07/29] efi: x86: Move EFI SDRAM-handling into a common file
Date: Sat,  8 Feb 2025 19:01:06 -0700
Message-ID: <20250209020136.4108987-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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

