Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C7CC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3461887EE3;
	Sat,  2 Mar 2024 23:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S2HHBuD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81FF87EDD; Sat,  2 Mar 2024 23:01:26 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC08087EEB
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33e12bcf6adso973764f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416883; x=1710021683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29ZfrGGPw9deOi4jp/M1SFPGboRFKNilOsGHVs2N7NM=;
 b=S2HHBuD6HPKW17Yt9usmSgk9vWRQtR1HALXOXEHIJUuE09ayXQJwj4+Ida0ctVtWV7
 yqxm6nfGcHHgQz0uz6rJ3xTRCZJIZG5yg7pUQ5dfBZG60bsHk2pC+a4j/tBpRHG1EORZ
 DP7a31+x4MMnUG6ZKvP12LbR1tcBj9MYBtd0Em+qmwk6yeNQ4SPDwGP1t6rmuCFx4R2G
 weFZlyeYytxaqfbL8WlIu2dG2sVixYKNZOFd5dqNpkEkwvhw0Ui6VhoBIKDlo8lQg0n0
 mB0W5+AFqiQSqgtUcbAanznitByN3BnNgc+/Cxde0L16fO+u3U+HWQpZGQy2mWvjPU5q
 8TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416883; x=1710021683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29ZfrGGPw9deOi4jp/M1SFPGboRFKNilOsGHVs2N7NM=;
 b=WBRTYSU7dK8QvmGRJlTe+WRulZE54CSN7NEzHAz/OoEdAkvVgjkWWsQIZIvQGldA4c
 Ur3ngzXl9lmZbm4nWGBN94FisPxr6uMWyjmCvQPXNmFK4JZzVPn9h2hDit4RLj8HHMrj
 rUB1rwFE0vGPsiIAIPSCO+OdrnJ5MY9xuA+LZmrzfxG3MExFuRtgKBVvSEPCZuIS+zZL
 sI6YGyvpPd0Dhrpzcbv2/zOO4Yrny+gaCfI9y7VCC13U5aNSxvDu8LpcXJF7G9dXQDsr
 itzjBqjmr7eSD8FAOGc+rIRNU32qmBRzeoZlg7f53CECeoeu7TH5JdQSC77nk424Jr3E
 HKZQ==
X-Gm-Message-State: AOJu0YzzxHxRVkAxi9GCHbMqI/BeguxMoCXvTvq3CSGMgDirhcRHNreG
 tW8nxOLKKWucrD55NWvp4xyFAaMkFDAxvS7Y3NUqfVY/M5+LDiq7QGYb+YnO
X-Google-Smtp-Source: AGHT+IGzKIvvGpLr0KIrpeUgkE7SVkizbJXp0Pbe0k8kCuhteF2+vehFOU/8J33C8UO8j7nuF73/wQ==
X-Received: by 2002:a5d:42c1:0:b0:33e:527:e1a7 with SMTP id
 t1-20020a5d42c1000000b0033e0527e1a7mr3740990wrr.2.1709416883182; 
 Sat, 02 Mar 2024 14:01:23 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 bp22-20020a5d5a96000000b0033d8b1ace25sm8588062wrb.2.2024.03.02.14.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 14:01:22 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/5] tee: remove common.h inclusion
Date: Sat,  2 Mar 2024 23:01:08 +0100
Message-Id: <20240302220108.720637-6-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302220108.720637-1-igor.opaniuk@gmail.com>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
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

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
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

