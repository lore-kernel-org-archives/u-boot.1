Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE93C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74BD88C39;
	Thu,  2 May 2024 03:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D3ip3q/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3212E88C36; Thu,  2 May 2024 03:32:19 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733A588BDF
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-61af74a010aso73660747b3.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613535; x=1715218335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJtKTnxcljC6wxcj7Za6rUrvctaXlMkppxCCcm0wdBg=;
 b=D3ip3q/NwiFZWQNCTpxIMKHu/oTPxY4VC9y6VlB7sXJFMgZDwla8sKxK08jKqmoXm2
 RuR/xHd5vzFSEUbb23LWXpR9msAl487fW7wIBdAdPYiT7dmXeER55EwppdRIA01ZlsHg
 5rlRjVP5J2eGOuvTxDjkQJL1BcCUb5wIcAH8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613535; x=1715218335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJtKTnxcljC6wxcj7Za6rUrvctaXlMkppxCCcm0wdBg=;
 b=MV2xz3rDDs1gZ6PlpO0gsMEt02YzScblLjMwQmAcRcxCnxoe6oLGb/oWXChMHgnQQx
 k15QnKOz+gPSf6DZpa2TmAcLRVyYxI3xN1BGX8z0TLoESsQ6m1JBgoJCVon7h8hUY1JH
 nnvBLwhawsS420lARL02w4VozetRKj9moCG6Pi0Nuv+t6gw6/7i2QAZ56o0MmZrfzLDv
 8l4KSz2KcCEs9qlPmquCkOLhA+YTbqhBNPFJ4YBmF2WtKM0KRt1gHo+6JJiS+gkhbzWj
 EX8VbaiqtJQWJ+OGLZ+bYijGi/vwQJ2yTH3nJsA2CDPNLDun+jU1GVgSHK4YLOseukaK
 zLVQ==
X-Gm-Message-State: AOJu0YyJQZcdAuAI5TU6IyUA+aAHja0uWRoeEDQxk2NDPSwwVqFdMNW5
 ZNIjfGqNNfx/sdG4R1yGarsyZR8dKUysfZvMIIIw/X32q0kllkFRZCb8SZNdpXmkxDyeMwHBlVk
 ngMYBwOpB
X-Google-Smtp-Source: AGHT+IGIqUKtChNndtbWJ7ZoUHJPMu80fgm8Nq1/3uQ+mGeIPCtGubTxmDeQrNnYbNsWjY4f8k2Waw==
X-Received: by 2002:a05:690c:d1c:b0:61b:3304:cdc7 with SMTP id
 cn28-20020a05690c0d1c00b0061b3304cdc7mr4562068ywb.29.1714613534836; 
 Wed, 01 May 2024 18:32:14 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 22/81] crypto: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:39 -0600
Message-Id: <20240502013138.2383421-22-trini@konsulko.com>
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
Cc: Tom Rini <trini@konsulko.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/crypto/ace_sha.c                    | 4 +++-
 drivers/crypto/ace_sha.h                    | 2 ++
 drivers/crypto/aspeed/aspeed_acry.c         | 1 -
 drivers/crypto/aspeed/aspeed_hace.c         | 1 -
 drivers/crypto/fsl/dcp_rng.c                | 1 -
 drivers/crypto/fsl/error.c                  | 2 +-
 drivers/crypto/fsl/fsl_blob.c               | 1 -
 drivers/crypto/fsl/fsl_hash.c               | 1 -
 drivers/crypto/fsl/fsl_mfgprot.c            | 1 -
 drivers/crypto/fsl/fsl_rsa.c                | 1 -
 drivers/crypto/fsl/jobdesc.c                | 2 +-
 drivers/crypto/fsl/jr.c                     | 2 +-
 drivers/crypto/fsl/rng.c                    | 1 -
 drivers/crypto/fsl/sec.c                    | 2 +-
 drivers/crypto/hash/hash-uclass.c           | 1 -
 drivers/crypto/hash/hash_sw.c               | 1 -
 drivers/crypto/nuvoton/npcm_aes.c           | 2 +-
 drivers/crypto/nuvoton/npcm_sha.c           | 1 -
 drivers/crypto/rsa_mod_exp/mod_exp_sw.c     | 1 -
 drivers/crypto/rsa_mod_exp/mod_exp_uclass.c | 1 -
 20 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/ace_sha.c b/drivers/crypto/ace_sha.c
index 261d3efe84e5..0e43e82fc5fa 100644
--- a/drivers/crypto/ace_sha.c
+++ b/drivers/crypto/ace_sha.c
@@ -3,10 +3,12 @@
  * Advanced Crypto Engine - SHA Firmware
  * Copyright (c) 2012  Samsung Electronics
  */
-#include <common.h>
+
+#include <config.h>
 #include "ace_sha.h"
 #include <log.h>
 #include <rand.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SHA_HW_ACCEL
 #include <u-boot/sha256.h>
diff --git a/drivers/crypto/ace_sha.h b/drivers/crypto/ace_sha.h
index ad9e81a586c7..efc791a4def4 100644
--- a/drivers/crypto/ace_sha.h
+++ b/drivers/crypto/ace_sha.h
@@ -8,6 +8,8 @@
 #ifndef __ACE_SHA_H
 #define __ACE_SHA_H
 
+#include  <linux/types.h>
+
 struct exynos_ace_sfr {
 	unsigned int	fc_intstat;	/* base + 0 */
 	unsigned int	fc_intenset;
diff --git a/drivers/crypto/aspeed/aspeed_acry.c b/drivers/crypto/aspeed/aspeed_acry.c
index 47a007f633a6..e3f81ebd5c74 100644
--- a/drivers/crypto/aspeed/aspeed_acry.c
+++ b/drivers/crypto/aspeed/aspeed_acry.c
@@ -3,7 +3,6 @@
  * Copyright 2021 ASPEED Technology Inc.
  */
 #include <config.h>
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/types.h>
diff --git a/drivers/crypto/aspeed/aspeed_hace.c b/drivers/crypto/aspeed/aspeed_hace.c
index 6b6c8fa65889..17cc30a7b54d 100644
--- a/drivers/crypto/aspeed/aspeed_hace.c
+++ b/drivers/crypto/aspeed/aspeed_hace.c
@@ -3,7 +3,6 @@
  * Copyright 2021 ASPEED Technology Inc.
  */
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <clk.h>
 #include <log.h>
diff --git a/drivers/crypto/fsl/dcp_rng.c b/drivers/crypto/fsl/dcp_rng.c
index 31706960157c..6b19c171fcda 100644
--- a/drivers/crypto/fsl/dcp_rng.c
+++ b/drivers/crypto/fsl/dcp_rng.c
@@ -7,7 +7,6 @@
  * Based on RNGC driver in drivers/char/hw_random/imx-rngc.c in Linux
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <rng.h>
diff --git a/drivers/crypto/fsl/error.c b/drivers/crypto/fsl/error.c
index c76574919c74..7b232d94c2a3 100644
--- a/drivers/crypto/fsl/error.c
+++ b/drivers/crypto/fsl/error.c
@@ -7,9 +7,9 @@
  * Derived from error.c file in linux drivers/crypto/caam
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include "desc.h"
 #include "jr.h"
 
diff --git a/drivers/crypto/fsl/fsl_blob.c b/drivers/crypto/fsl/fsl_blob.c
index 9b6e4bca062c..0ecd6befd259 100644
--- a/drivers/crypto/fsl/fsl_blob.c
+++ b/drivers/crypto/fsl/fsl_blob.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/crypto/fsl/fsl_hash.c b/drivers/crypto/fsl/fsl_hash.c
index f22f24b60775..79b32e2627c4 100644
--- a/drivers/crypto/fsl/fsl_hash.c
+++ b/drivers/crypto/fsl/fsl_hash.c
@@ -4,7 +4,6 @@
  * Copyright 2021 NXP
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/crypto/fsl/fsl_mfgprot.c b/drivers/crypto/fsl/fsl_mfgprot.c
index 29af79f577dc..7c22f8e012b8 100644
--- a/drivers/crypto/fsl/fsl_mfgprot.c
+++ b/drivers/crypto/fsl/fsl_mfgprot.c
@@ -4,7 +4,6 @@
  * Copyright 2017 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <fsl_sec.h>
 #include <memalign.h>
diff --git a/drivers/crypto/fsl/fsl_rsa.c b/drivers/crypto/fsl/fsl_rsa.c
index 335b7fe25acb..125a72ae6d32 100644
--- a/drivers/crypto/fsl/fsl_rsa.c
+++ b/drivers/crypto/fsl/fsl_rsa.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/crypto/fsl/jobdesc.c b/drivers/crypto/fsl/jobdesc.c
index d32c1fe5c31a..551917369318 100644
--- a/drivers/crypto/fsl/jobdesc.c
+++ b/drivers/crypto/fsl/jobdesc.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <fsl_sec.h>
 #include "desc_constr.h"
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 203f16252159..4436e23b72ac 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -6,7 +6,7 @@
  * Based on CAAM driver in drivers/crypto/caam in Linux
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <linux/kernel.h>
 #include <log.h>
diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
index 063649480521..786a710f5fb6 100644
--- a/drivers/crypto/fsl/rng.c
+++ b/drivers/crypto/fsl/rng.c
@@ -7,7 +7,6 @@
  */
 
 #include <asm/cache.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <rng.h>
diff --git a/drivers/crypto/fsl/sec.c b/drivers/crypto/fsl/sec.c
index 9de30a6112fa..e9c39ddcfd9e 100644
--- a/drivers/crypto/fsl/sec.c
+++ b/drivers/crypto/fsl/sec.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 #if CONFIG_SYS_FSL_SEC_COMPAT == 2 || CONFIG_SYS_FSL_SEC_COMPAT >= 4
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index 446eb9e56a4f..5d9f1e0d59bd 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_HASH
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <u-boot/hash.h>
diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
index d8065d68ea48..ffd4ab149ffb 100644
--- a/drivers/crypto/hash/hash_sw.c
+++ b/drivers/crypto/hash/hash_sw.c
@@ -4,7 +4,6 @@
  * Author: ChiaWei Wang <chiawei_wang@aspeedtech.com>
  */
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/crypto/nuvoton/npcm_aes.c b/drivers/crypto/nuvoton/npcm_aes.c
index 6493ea108ec7..8d3a30ea918d 100644
--- a/drivers/crypto/nuvoton/npcm_aes.c
+++ b/drivers/crypto/nuvoton/npcm_aes.c
@@ -3,13 +3,13 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <uboot_aes.h>
 #include <asm/io.h>
 #include <asm/arch/aes.h>
 #include <asm/arch/otp.h>
 #include <malloc.h>
+#include <time.h>
 
 #define ONE_SECOND 0xC00000
 
diff --git a/drivers/crypto/nuvoton/npcm_sha.c b/drivers/crypto/nuvoton/npcm_sha.c
index 7ebdfa16f4fc..f06be86ca59e 100644
--- a/drivers/crypto/nuvoton/npcm_sha.c
+++ b/drivers/crypto/nuvoton/npcm_sha.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hash.h>
 #include <malloc.h>
diff --git a/drivers/crypto/rsa_mod_exp/mod_exp_sw.c b/drivers/crypto/rsa_mod_exp/mod_exp_sw.c
index 7bed444c3fbf..4f59adc09c9c 100644
--- a/drivers/crypto/rsa_mod_exp/mod_exp_sw.c
+++ b/drivers/crypto/rsa_mod_exp/mod_exp_sw.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <u-boot/rsa-mod-exp.h>
diff --git a/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c b/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c
index 057cc74b10bb..107500dd6e07 100644
--- a/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c
+++ b/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_MOD_EXP
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <u-boot/rsa-mod-exp.h>
-- 
2.34.1

