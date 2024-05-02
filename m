Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6E9C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2B788CDC;
	Thu,  2 May 2024 03:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OzpCKEYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E913588CB7; Thu,  2 May 2024 03:34:04 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDB788CDB
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7906776e17aso531850185a.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613640; x=1715218440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7/Sfg7GY/dRMIRcLPbuONf0honWMidnJU+fYTRQc0I=;
 b=OzpCKEYAZBK/eof32gx4uNHncxup8FhE38UQYWiqv110SYCbX7GW0c8qEpDmh2MEmV
 WZDMzSSYRBcvIooCiqaeic5NnQ8CJ3d96dVGcDThwxV6CnpRyGAhAfXRQMqgRls77QoI
 hr3lf2/ShQXtr0/VKV01LmypwGh0HuwnSnreE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613640; x=1715218440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7/Sfg7GY/dRMIRcLPbuONf0honWMidnJU+fYTRQc0I=;
 b=q5ZAPWR4EmoJhTFtRsWqCZ6vWZkQfCjweNnT5fmMwT2KBEuM7BEEjdXUqQ6z4X4vbp
 33eNlK6X3/rXLywUUC7oYG91ci0RwWxKb0ch+Ax6yMsZeC3ip+AfBUbNHcKnz4ggL75o
 t8q4kAVU439z8CBkpqd9LN2z90t9hMx3EduAHY4aMxu6hCUBcW7I//AzLNCzgK3+XjA1
 e5heE186bmVwTeKOI0lZh0IyzfsGiyA/mUbDTP5kGrOl8BoiUKVfkrQzv5c7sTfVuVEz
 0Uc1eojv2nFarchijXZNI4kqUB/mFe4ShfHs57p6x1sUv3ceX5DsZ5cFIvDPx7RaobEo
 nvDg==
X-Gm-Message-State: AOJu0YydnwedoXld1nlumGy+/qSTm41en0Og3K+M918qzKrQFJO2/Sna
 IZZMA7xMow2jr7MxlTI3qxkLx6NHhKwEVkzJLJykv9nS4f1ZpAZXXRncOFgypfx8myWDpdRdaqp
 QNHej3z8a
X-Google-Smtp-Source: AGHT+IFAeeFBrPdYpGyl9xXd2hG/jxrYPpsWUxw4VBIdMzekIdqWUR/3TFT+hCBl78iK2Lzml6P6Jg==
X-Received: by 2002:ac8:5fc6:0:b0:43a:d386:f8eb with SMTP id
 k6-20020ac85fc6000000b0043ad386f8ebmr4241366qta.22.1714613640267; 
 Wed, 01 May 2024 18:34:00 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 71/81] tpm: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:28 -0600
Message-Id: <20240502013138.2383421-71-trini@konsulko.com>
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
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/tpm/cr50_i2c.c             | 2 +-
 drivers/tpm/sandbox_common.c       | 1 -
 drivers/tpm/tpm-uclass.c           | 2 +-
 drivers/tpm/tpm2_ftpm_tee.c        | 1 -
 drivers/tpm/tpm2_tis_core.c        | 2 +-
 drivers/tpm/tpm2_tis_i2c.c         | 1 -
 drivers/tpm/tpm2_tis_mmio.c        | 1 -
 drivers/tpm/tpm2_tis_sandbox.c     | 1 -
 drivers/tpm/tpm2_tis_spi.c         | 2 +-
 drivers/tpm/tpm_atmel_twi.c        | 2 +-
 drivers/tpm/tpm_tis_infineon.c     | 2 +-
 drivers/tpm/tpm_tis_lpc.c          | 1 -
 drivers/tpm/tpm_tis_sandbox.c      | 1 -
 drivers/tpm/tpm_tis_st33zp24_i2c.c | 1 -
 drivers/tpm/tpm_tis_st33zp24_spi.c | 1 -
 15 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
index acf4c7859a9f..08ec179346e2 100644
--- a/drivers/tpm/cr50_i2c.c
+++ b/drivers/tpm/cr50_i2c.c
@@ -7,12 +7,12 @@
 
 #define LOG_CATEGORY UCLASS_TPM
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <irq.h>
 #include <log.h>
 #include <spl.h>
+#include <time.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
 #include <acpi/acpigen.h>
diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
index 7e0b2502e35d..596e01563899 100644
--- a/drivers/tpm/sandbox_common.c
+++ b/drivers/tpm/sandbox_common.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY	UCLASS_TPM
 
-#include <common.h>
 #include <tpm-v1.h>
 #include <tpm-v2.h>
 #include <asm/unaligned.h>
diff --git a/drivers/tpm/tpm-uclass.c b/drivers/tpm/tpm-uclass.c
index b2286f7e7edc..0fade2dcc0ad 100644
--- a/drivers/tpm/tpm-uclass.c
+++ b/drivers/tpm/tpm-uclass.c
@@ -6,9 +6,9 @@
 
 #define LOG_CATEGORY UCLASS_TPM
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <time.h>
 #include <tpm_api.h>
 #include <tpm-v1.h>
 #include <tpm-v2.h>
diff --git a/drivers/tpm/tpm2_ftpm_tee.c b/drivers/tpm/tpm2_ftpm_tee.c
index c61ff2c2af63..f2ced50c4eb7 100644
--- a/drivers/tpm/tpm2_ftpm_tee.c
+++ b/drivers/tpm/tpm2_ftpm_tee.c
@@ -13,7 +13,6 @@
  * https://github.com/microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <tpm-v2.h>
diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
index 81b9210056db..680a6409433e 100644
--- a/drivers/tpm/tpm2_tis_core.c
+++ b/drivers/tpm/tpm2_tis_core.c
@@ -5,8 +5,8 @@
  * Based on the Linux TIS core interface and U-Boot original SPI TPM driver
  */
 
-#include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <tpm-v2.h>
 #include <linux/delay.h>
 #include <linux/unaligned/be_byteshift.h>
diff --git a/drivers/tpm/tpm2_tis_i2c.c b/drivers/tpm/tpm2_tis_i2c.c
index 99d1cf218daf..93efccc77575 100644
--- a/drivers/tpm/tpm2_tis_i2c.c
+++ b/drivers/tpm/tpm2_tis_i2c.c
@@ -3,7 +3,6 @@
  * Copyright 2022 IBM Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <i2c.h>
diff --git a/drivers/tpm/tpm2_tis_mmio.c b/drivers/tpm/tpm2_tis_mmio.c
index a646ce41ff4e..dee5503c055f 100644
--- a/drivers/tpm/tpm2_tis_mmio.c
+++ b/drivers/tpm/tpm2_tis_mmio.c
@@ -5,7 +5,6 @@
  * Specifications at www.trustedcomputinggroup.org
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <tpm-v2.h>
diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
index d15a28d9fc82..50e308e71161 100644
--- a/drivers/tpm/tpm2_tis_sandbox.c
+++ b/drivers/tpm/tpm2_tis_sandbox.c
@@ -4,7 +4,6 @@
  * Author: Miquel Raynal <miquel.raynal@bootlin.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <tpm-v2.h>
 #include <asm/state.h>
diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index de9cf8f21e07..28079b5039a3 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -13,11 +13,11 @@
  * It is based on the U-Boot driver tpm_tis_infineon_i2c.c.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <spi.h>
+#include <time.h>
 #include <tpm-v2.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/tpm/tpm_atmel_twi.c b/drivers/tpm/tpm_atmel_twi.c
index fd2a45d34b03..05dd66525c77 100644
--- a/drivers/tpm/tpm_atmel_twi.c
+++ b/drivers/tpm/tpm_atmel_twi.c
@@ -5,11 +5,11 @@
  * Written by Dirk Eibach <dirk.eibach@gdsys.cc>
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <dm.h>
 #include <tpm-v1.h>
 #include <i2c.h>
+#include <time.h>
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 
diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index 16f4af0e331e..e2f6238cbc71 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -19,11 +19,11 @@
  * Version: 2.1.1
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <i2c.h>
 #include <log.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/tpm/tpm_tis_lpc.c b/drivers/tpm/tpm_tis_lpc.c
index 13a133d58ebd..dec7acb0c7b1 100644
--- a/drivers/tpm/tpm_tis_lpc.c
+++ b/drivers/tpm/tpm_tis_lpc.c
@@ -12,7 +12,6 @@
  * slb9635), so this driver provides access to locality 0 only.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
index 7350e1c4d525..2bc7dc87ed30 100644
--- a/drivers/tpm/tpm_tis_sandbox.c
+++ b/drivers/tpm/tpm_tis_sandbox.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <dm.h>
 #include <tpm-v1.h>
diff --git a/drivers/tpm/tpm_tis_st33zp24_i2c.c b/drivers/tpm/tpm_tis_st33zp24_i2c.c
index e0eeabb93371..1a265b28b22f 100644
--- a/drivers/tpm/tpm_tis_st33zp24_i2c.c
+++ b/drivers/tpm/tpm_tis_st33zp24_i2c.c
@@ -12,7 +12,6 @@
  * STMicroelectronics Protocol Stack Specification version 1.2.0.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <i2c.h>
diff --git a/drivers/tpm/tpm_tis_st33zp24_spi.c b/drivers/tpm/tpm_tis_st33zp24_spi.c
index f0de8a65b093..2cf690328d87 100644
--- a/drivers/tpm/tpm_tis_st33zp24_spi.c
+++ b/drivers/tpm/tpm_tis_st33zp24_spi.c
@@ -12,7 +12,6 @@
  * STMicroelectronics Protocol Stack Specification version 1.2.0.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
-- 
2.34.1

