Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24941CD1299
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 13:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D113D8828C;
	Thu,  4 Apr 2024 15:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJsIaz5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82AC883BA; Thu,  4 Apr 2024 15:20:13 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A897883A2
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d7169ec836so2427811fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712236810; x=1712841610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gX7lbsNsDSs/7jJICXPoTPGqtx7aNIRO4H1gnPqpcyA=;
 b=BJsIaz5hVb3D84Fo/RgiYV2uMPmuvkwlG7tgMYkXtOp5GLk8YZA8y/A34kuTRamOfh
 8PbHWHQfy00CrDxEcKyYhEFFJAmzRPIKQn9PbSdw6hiwTa1T1/yMVbJOAb8VGV+jKWq8
 66OxhxORJqOaBpkdlWv++G5VGryn/VcvFxblgCiTWYa+Py2chyC7KeVgaEeXmOiPIvW3
 eZg1eX1dts8t2JHYsF53p1eoH0Ok2xLED51t5g3jR7wQNYDCH1fTgVN7BbspkSRpz22L
 YzxS2/SAPUMT/HD1NNzGg+jnW4/9E1rWX4qcm2JxUwfLbNs9gim3KOkuKp6w9MvKgE5Y
 RgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236810; x=1712841610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gX7lbsNsDSs/7jJICXPoTPGqtx7aNIRO4H1gnPqpcyA=;
 b=Cc2eYdMp123XTbNMx2VJWENMM4//+sY5hyOg6/5eGY1BVS2zLzBVFZN0zQX8+5VI9B
 JyXv/kPqSGzMJOef7zhlNWidUdfy3ttzBqQD1A9Rcl9cv9xTk/m3lsdWg/CIT0JKiY6J
 qPqj3okPUZurS++McaM9gVvWJgVJnyBZXOCd707nXnWTM3cz9R0WLr5aBbrXueRQXcIw
 +h+iPqWyYU8pK7BtbLqRZovSWdvWfy48BkL9d8x2Tsxv6xrdyIQd5AyFsvggpBkbtmzT
 vujt4kahhpaZDUM3qc8+NVlOYu44HNxu6PsQRq5FeW+UM63fMuhNXZWx5D/17FY74mu+
 NoRg==
X-Gm-Message-State: AOJu0Yye8fX/gO1mv+VkT4vkhYlMQRb4y45l8v38CSV3khug/+rfpKK6
 Av2bP/r0zu3AhgQSvByRtDOUSwIBvT9LZjMCbhVgFplthzyUpAR/8Jq6hHLxDsNBQA==
X-Google-Smtp-Source: AGHT+IE+iPAbu64giF3Z5uFFkNRH4pRsIdOxrT6C+g3WOzIaAB5MRpWhQy0zFiJbgXyS6muT1nA7ow==
X-Received: by 2002:a2e:301a:0:b0:2d4:7f17:185d with SMTP id
 w26-20020a2e301a000000b002d47f17185dmr1822405ljw.0.1712236810111; 
 Thu, 04 Apr 2024 06:20:10 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 t16-20020a2e9c50000000b002d6a40a26a5sm2173615ljj.87.2024.04.04.06.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 06:20:09 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 5/5] tee: remove common.h inclusion
Date: Thu,  4 Apr 2024 15:19:51 +0200
Message-Id: <20240404131952.3252301-6-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
References: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
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

The usage of the common.h include file is deprecated [1], and has already
been removed from several files.
Get rid of all inclusions in the "drivers/tee" directory, and replace it
with required include files directly where needed.

[1] doc/develop/codingstyle.rst

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v5:
- Extended commit message for "cmd: optee_rpmb: close tee session"
- Added R-b tag

Changes in v4:
- Rebased on the latest master and excluded "tee: sandbox: fix spelling errors",
  as it was merged already by Heinrich Schuchardt

Changes in v3:
- Added calls for closing tee session after every read/write operation
- Added calls for closing tee session after every read/write operation

Changes in v2:
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
- Applied R-b and T-b tags
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'

 drivers/tee/broadcom/chimp_optee.c | 3 ++-
 drivers/tee/optee/core.c           | 1 -
 drivers/tee/optee/i2c.c            | 1 -
 drivers/tee/optee/rpmb.c           | 1 -
 drivers/tee/optee/supplicant.c     | 2 +-
 drivers/tee/sandbox.c              | 2 +-
 drivers/tee/tee-uclass.c           | 1 -
 7 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/chimp_optee.c
index 37f9b094f76..bd146ef2899 100644
--- a/drivers/tee/broadcom/chimp_optee.c
+++ b/drivers/tee/broadcom/chimp_optee.c
@@ -3,9 +3,10 @@
  * Copyright 2020 Broadcom.
  */
 
-#include <common.h>
 #include <tee.h>
 #include <broadcom/chimp.h>
+#include <linux/errno.h>
+#include <string.h>
 
 #ifdef CONFIG_CHIMP_OPTEE
 
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 47f845cffe3..5fc0505c788 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2020 Linaro Limited
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/tee/optee/i2c.c b/drivers/tee/optee/i2c.c
index ef4e10f9912..e3fb99897c5 100644
--- a/drivers/tee/optee/i2c.c
+++ b/drivers/tee/optee/i2c.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Foundries.io Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <tee.h>
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 5bc13757ea8..bacced6af6c 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <tee.h>
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index f9dd874b594..8a426f53ba8 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <tee.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #include "optee_msg.h"
diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index ec66401878c..8ad7c09efdd 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2018 Linaro Limited
  */
-#include <common.h>
+
 #include <dm.h>
 #include <sandboxtee.h>
 #include <tee.h>
diff --git a/drivers/tee/tee-uclass.c b/drivers/tee/tee-uclass.c
index 52412a4098e..0194d732193 100644
--- a/drivers/tee/tee-uclass.c
+++ b/drivers/tee/tee-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_TEE
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
-- 
2.34.1

