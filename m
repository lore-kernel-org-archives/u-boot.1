Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1007C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E460180F0A;
	Sat, 15 Feb 2025 04:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iRv2dSrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 652D880F4A; Sat, 15 Feb 2025 04:23:33 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF2D80F0A
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-851c4f1fb18so94262239f.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589806; x=1740194606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEV+88/hx5S6GXwbkmqcDv8GEutu0uwJH6P0jmSpWn8=;
 b=iRv2dSrjx4hpk9E0WmBfTn663RaHGmEe8s9s2TeCvjm/OQ1IidB1Rpz7v32dPJfrEm
 zUauCMNJRg52ACc9lI0Bk8nNl6T96nxlVtLAcfi1Vy93wJ4TwV+7+Ho0SZI9eI+IiGUn
 J0/lIfESm3MlPTXwmlGAs+PW2GpPRo9deiovM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589806; x=1740194606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEV+88/hx5S6GXwbkmqcDv8GEutu0uwJH6P0jmSpWn8=;
 b=f5jCOFdoBbxPhObn9s5koV37GO/wcd0qG1aQv9HietZBkw/lZP+z/f/91RjKVwx1mh
 8XFLJMvHVXN+f3CzOUMJRPM71p0Xm7yy1xe99B1sfiwXvVTdiuJTy26sXvGT+iDg6nHJ
 DUdQOUG9WMWgwRXR87jqt163VN8QCvtBqU6+83OVLyUZlU/8T4+WVu1FOADJy8E7dsrb
 OJ/3kJ3KiTbg2XrWJ/yMg05+LRkg/fTRcwTBn5Kjl702VkwC7G3HQeTpE2i9PnK1+Pfd
 qoO2r00rRjkbNehi8ORr0zktdDRPaCrpE1eIShNWU/Q3dXZzR8PsATHaOvfklc3AEw9o
 jwsA==
X-Gm-Message-State: AOJu0YwuOcxJfHyDzovKLCN25is2hKvURayqqZxr+gcXhGHn5uEn5PDT
 jpfVY4KAeQ5Uaw1G61uSvUCNUWfagZputpv1vmWG8v8iZSYIWvMI7A6PeOqDqjZnnK12T7eUnpE
 =
X-Gm-Gg: ASbGncuxQMLiUFHOlL+/0WoCPy9Cad7C2DPSWwxbacAMKDpdkFOdkG39pGQvpamrzBt
 +NhcxOz7PSe5qLcPUquaeuAz4FOILoRHEs32dy1/J+rFjNzuOuNGuiQ77IlWmtChwmKObTu0p4v
 NnfgUXepxTRJiBccfnb1nluWH5ZYGUYpzgkAJR05oiVOImHYKSsFQL/9HjO2/vEq78w9cXEq7r1
 PZkO/hkcMrT+73kqMSwezZShp02LYzL75mRisFXDdwYmtX/sXkYBJT6yY6oncYWv5oaoK6FSNY8
 hDGr9vgLS9GT7RG/SeYcoBGsaOBILBu/4iARhLJq7+aEznPGfGIt
X-Google-Smtp-Source: AGHT+IHeID8iKWuR9KlNoDtsT9lNxPNaWAViAgrK72JN1I5BM6ZEbX8Nk3s7FHME5UCupMb4yDOWKg==
X-Received: by 2002:a05:6602:2dd4:b0:855:690e:ed8f with SMTP id
 ca18e2360f4ac-8557a13ad91mr183786839f.12.1739589806129; 
 Fri, 14 Feb 2025 19:23:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>
Subject: [PATCH v4 07/29] efi: x86: Move EFI SDRAM-handling into a common file
Date: Fri, 14 Feb 2025 20:22:28 -0700
Message-ID: <20250215032254.4121030-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

