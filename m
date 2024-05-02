Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8375CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F8688C41;
	Thu,  2 May 2024 03:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MhWgDgoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D9588C38; Thu,  2 May 2024 03:32:23 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBEE88C3A
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43ae2a44963so16724801cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613539; x=1715218339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jq5KBGXax1Uofe1h8y50WVSWEgzZZZlcXw8i2FVEbvg=;
 b=MhWgDgoTnRrkhHXXLpVMVt8Op8i8RUnDYujaEnPpQTUhjKz1LUf/ToTZrM6u4PtKf9
 00qjYcgYE0FCCljl2M7jI3+KeSyGULeaU+5Ecmh27VLAAxHIXHDm3xQRGs0aIgkiA5If
 YpaN6+lfOWa/f7Vl3YSZ4ALrJ4WBDrp8aWSP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613539; x=1715218339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jq5KBGXax1Uofe1h8y50WVSWEgzZZZlcXw8i2FVEbvg=;
 b=mEGTPsHxXnkAWcZOgW4Z3y7JmoIlu4EKC0wNkluVypuT4ZH0qBXfPFOWB4WfuMoD6I
 snMxrZj6g3GAALBtXdemTsLwbaddePGeEgUy0tFCtWTt5d8WmTF0ilu1wSRMK6X/Tahl
 EMaGRwZfnqGi7BnfwCyt9NCLFEUNY6fYMJlruubqvVDvxx6FnWi5bpYL1cB9rv/7xkan
 +Ot2eYjiVTcMnLGZQIqviq7XAL30pqFxY4WEuTG/lN8cYiDKdbSPLx3+V2+0pdSSEiMW
 UgxM2/v9CUda4hk3dOyb19dhh/vKgC/8/l/Lnx4g0CIRKYZHFi1Dq7OxS5ehRuiA0cVw
 B/Sg==
X-Gm-Message-State: AOJu0YyCcV84RYJT8jHlGQwt5+YN4gRgYZ41PZ1SIIiPDCGTCNc8BSZp
 l8oM0eqrclkOQJfevSOvdW6GlvXdBKfrtxZVSk9Li4a7pM6rL8L2AnUWlUEogZUJDFFgxnc2U04
 +2Bux3mFF
X-Google-Smtp-Source: AGHT+IHi2sdlo9VDZQmH1czF2mYtm7WEwBS5OYXZ2+xk2WnsP/hre9/DGzu6GM1HPsSdj4NaC7UDxw==
X-Received: by 2002:a05:622a:3d1:b0:43a:e59e:5c9a with SMTP id
 k17-20020a05622a03d100b0043ae59e5c9amr671918qtx.43.1714613538680; 
 Wed, 01 May 2024 18:32:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 25/81] dfu: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:42 -0600
Message-Id: <20240502013138.2383421-25-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/dfu/dfu.c      | 1 -
 drivers/dfu/dfu_alt.c  | 1 -
 drivers/dfu/dfu_mmc.c  | 1 -
 drivers/dfu/dfu_mtd.c  | 1 -
 drivers/dfu/dfu_nand.c | 1 -
 drivers/dfu/dfu_ram.c  | 1 -
 drivers/dfu/dfu_sf.c   | 1 -
 drivers/dfu/dfu_virt.c | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 2adf26e2fe24..540d48fab77d 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -6,7 +6,6 @@
  * author: Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/dfu/dfu_alt.c b/drivers/dfu/dfu_alt.c
index ece3d2236f3d..e9132936a90b 100644
--- a/drivers/dfu/dfu_alt.c
+++ b/drivers/dfu/dfu_alt.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski <l.majewski@majess.pl>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <errno.h>
diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index 12c54e90ef71..cfa6334e4397 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -6,7 +6,6 @@
  * author: Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <errno.h>
diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
index 485586989c8a..c36ac09189f3 100644
--- a/drivers/dfu/dfu_mtd.c
+++ b/drivers/dfu/dfu_mtd.c
@@ -7,7 +7,6 @@
  * Based on dfu_nand.c
  */
 
-#include <common.h>
 #include <dfu.h>
 #include <mtd.h>
 #include <linux/err.h>
diff --git a/drivers/dfu/dfu_nand.c b/drivers/dfu/dfu_nand.c
index 08e8cf5cdb37..940cfefc986c 100644
--- a/drivers/dfu/dfu_nand.c
+++ b/drivers/dfu/dfu_nand.c
@@ -9,7 +9,6 @@
  * author: Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <errno.h>
diff --git a/drivers/dfu/dfu_ram.c b/drivers/dfu/dfu_ram.c
index c4f4bd2e482f..043acbf022fc 100644
--- a/drivers/dfu/dfu_ram.c
+++ b/drivers/dfu/dfu_ram.c
@@ -8,7 +8,6 @@
  * author: Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <errno.h>
diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
index 2dae15937064..7c1c0f9e2dc7 100644
--- a/drivers/dfu/dfu_sf.c
+++ b/drivers/dfu/dfu_sf.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2014, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <errno.h>
 #include <div64.h>
diff --git a/drivers/dfu/dfu_virt.c b/drivers/dfu/dfu_virt.c
index 29f7a08f6728..2c31445af12a 100644
--- a/drivers/dfu/dfu_virt.c
+++ b/drivers/dfu/dfu_virt.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
  */
-#include <common.h>
 #include <dfu.h>
 #include <errno.h>
 #include <log.h>
-- 
2.34.1

