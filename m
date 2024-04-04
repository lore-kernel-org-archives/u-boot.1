Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51749CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFBF88404;
	Thu,  4 Apr 2024 10:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iK3+/uhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCC9883FC; Thu,  4 Apr 2024 10:14:16 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75744883DD
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516ce8b2486so52861e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712218453; x=1712823253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNmT5vFa+RtUpJlbQrpNeWzXC7oMpaPjY7wZ9ximqhI=;
 b=iK3+/uhMKqeBoEVlEzR3Y4M+sltsAwhtVTH+gtBJfJyX58CFaDoyWI/D8RlxkV2Js2
 p6MsNBEgCnmdrqGR49f5pseUjZM4zAyicP4uLSL0Nj1Nr+ph0LPyCWC742axPRsGSDPr
 z9f/KllT6vU4Rs9hHC3NPbnkcndl3ZmnD+8+zRhD5+IBK0e5NbJdCm2zKYqhNhRNSanI
 sjEhdOsYZsghpz8X4Zv1O1MS/Yjdf2KQhY60xz2qhU8YbU5esvrZwfJeR/I8hzlVQSdl
 WMXabqLXs9Rs2okjtaG/yvcUUH35vxVLEWvjepdcF/YiikYWUTVNr+QjzjDmbZ7pFfiZ
 cjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218453; x=1712823253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNmT5vFa+RtUpJlbQrpNeWzXC7oMpaPjY7wZ9ximqhI=;
 b=Nvqv+tuI/xqdkH1CcaEMIbJdi2yuf49yTA3I/bD0n0TWd2+JuADJZ5og4852EbHadO
 8mHManUZNtcYOEPvtvHnuM4zhUhEXm6OfE3imkoQNPzVhwPmTpX+TpuTFBXKSxnrssa+
 Rd6IivNPppsgeZJpL8Pn4RoKSdMAcA0tzmdbw0bA4UgU/WLVPakAZBObvF3ddhbQrs3R
 Fp8KgSyvvvGMy3IqxWfLFvL+3+Y0Q5f3PQ1+4za2BcH0uoY7w/HVylvY/fwIityvVh7h
 DGkGm3Dmzil3i5XW+Lmn8yU+aAHcQWnzlBh+53Te7yf0aKLlgqGyd9ZSBuicmljI2U74
 t56g==
X-Gm-Message-State: AOJu0YyLQdYlKKK63vdepG206xgiwCrRxC6iLbnODWf/K0fKdiigUSSY
 KdwhvhC60eanOKqVAtlOHiQB9i6zXTHsfL5RHccwSaOhOukWspZvnbgPLZJi9CgVsw==
X-Google-Smtp-Source: AGHT+IFnQjFzP8OM7zrUT4CBZCoJ2Rd1XcAAwDodv+/ZUtiQtOuYEpEQi7NnNXMAPBpUnZbw69HMOg==
X-Received: by 2002:ac2:4c19:0:b0:513:c428:9daa with SMTP id
 t25-20020ac24c19000000b00513c4289daamr1066587lfq.0.1712218453061; 
 Thu, 04 Apr 2024 01:14:13 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 z7-20020ac25de7000000b00515bb998006sm2211777lfq.67.2024.04.04.01.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:14:12 -0700 (PDT)
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
Subject: [PATCH v4 5/5] tee: remove common.h inclusion
Date: Thu,  4 Apr 2024 10:13:52 +0200
Message-Id: <20240404081352.3224643-6-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
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

(no changes since v3)

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

