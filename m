Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930F5C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A718092B;
	Sat,  8 Feb 2025 18:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iDOnEpAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D539808AF; Sat,  8 Feb 2025 18:12:25 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CDE48083C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-84cdacbc373so96193139f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034741; x=1739639541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEV+88/hx5S6GXwbkmqcDv8GEutu0uwJH6P0jmSpWn8=;
 b=iDOnEpAOcsqnIBftkqUcC1FDo7CFUJ6MawglaMeMUDL0gANZl8HFphctKKQzSIivKZ
 Jm6IFt2zcbOmtq9Azt3dA45OBBAGwDrakqAswOv7QwJMk8nCG+NGK4u6bpYwb5Y9Ji+S
 UjXHLo33QzJ29CRsWAkKw/Xa55xXUFi4f8YP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034741; x=1739639541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEV+88/hx5S6GXwbkmqcDv8GEutu0uwJH6P0jmSpWn8=;
 b=s4hKJuElUnas3cfbYWYiTsNK7R6x2Jmh2qlN+hnNGVMiMkfmvoVHHyCCn1LSlfa0n7
 fnVReuBo3zcZ/HIhK3KSVb/95UsR4eOV14gRvJOyn9Fu5aNqWk7LS7RnQ17BL96o2Hel
 Q+aWLqEj5dw7G/VJwEeA6isrwglXizpwFejQUMRYUSJrSXbBjLpTJlHoqMxST2HT4zmy
 GKZOIKEuPKnEwmHQOiFReTe9DF94wVG45csv3oQR0+C8tN8DDfrVnDSCqQ8309/JB7K9
 BBu+xWpW/aPjkr6OJ/UJPuVw6UoWa79y+7z0+DgF0C2K9yh5ggwJXcdW5kbSM3GPlDuK
 mg0g==
X-Gm-Message-State: AOJu0Yw0eJxC66v0B/xT+RJLJnRCuliuJnvXRszSTrX+tzHPnlxyrQcm
 a8gjB6Tk7erXo5IQsjxAsaGfN6MwYTTGa31DEUsAGFKIzbdDO8I3HDZ+wVjMQF3IZy+kye8AO74
 =
X-Gm-Gg: ASbGncvAyH+wwT+ALB7h8k5hI8Dp15CR7NoZwdxQIvfSJ0eXls+izX8zjIKupWZuDPy
 M6eYG+3FAjUOj83BSnF060dgjyHUH/4qfLlxzh5WK+I0nCX5SsmqiKJGVVhgJor9rG6DO/4iHDe
 gKCl6QVPr9zcB6yIU8rvl7bekQSCYCyFN8n4zsonTY6lmETtiJtBASNNMFiaPTzEv2h3GZ8HBPJ
 ched7mhqvdqw925zAgXi+cW59AzyMHAFn9eIZJq6VYNPFk+vRpmPfNtzotCdz1DLL8kG2TIug9x
 QktKr0gmNiWpxq7tZ8WQ2xfB/c1vaEXYwvyb791oEURStHPsQKr2
X-Google-Smtp-Source: AGHT+IEXzBEwtRpQ80xXCakuumil4KcQM/KeLUp/vyQnoZjEPKBrCsirh/rpBpAyAr3S1YksHr7Y6Q==
X-Received: by 2002:a05:6602:3886:b0:842:ff2d:c3bb with SMTP id
 ca18e2360f4ac-854fd8982ffmr779184539f.6.1739034740944; 
 Sat, 08 Feb 2025 09:12:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>
Subject: [PATCH v2 07/29] efi: x86: Move EFI SDRAM-handling into a common file
Date: Sat,  8 Feb 2025 10:11:27 -0700
Message-ID: <20250208171154.1305761-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

