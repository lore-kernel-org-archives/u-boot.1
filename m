Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A3CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94888863E;
	Sat, 27 Apr 2024 16:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O5VQuE4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24FB88413; Sat, 27 Apr 2024 16:11:31 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7540488532
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78f049ddd7dso232853585a.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227088; x=1714831888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RIJRAbE2beMpm9v2ZTi+k+h82q3s7umfaMpyvc29RmQ=;
 b=O5VQuE4vDcj8Igv+H4/cedJLLJ43XwZ6AH+7pMWs8zLsc+jNVOFsbHdanikhtD6KfK
 4Gu7PWU4E07FBwsXDF0iNoWfZFJXaTf/MVlTJviug5XhdD2FxatJtZoc6afIcsZdVv3c
 87nJPWGrwvsffZUXJxUdT5uYjx7wjPKILZLMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227088; x=1714831888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIJRAbE2beMpm9v2ZTi+k+h82q3s7umfaMpyvc29RmQ=;
 b=p0aQydTpaJfV+BM3PX0kSKha7BWrU61MnVdoCYyTiFfMSE0Kv8lLHO0e6pQgKxxNFV
 YlarzrkCUmilewsskV2fysW5eTQaQry3PPSqf4TvRchMTogo+hLWdrhmtb9mG5FOoz//
 swIcA9rPhtwxdSkzIK5nqckk+/T/2mGVq9WtdMU06eLtTko6ASUbcl4kyxZyBEINjWLH
 cf974ZvurMv7ZSDrbASl/FwKmDtXokDwKX/jwnB4Za6yA3wuKzCu+hVvbkW2rC81AjG0
 HoPfKb13r9wcr2nG0g0K6u0ETaX7SQJc8z8c15SDc0JEouLUu3nzoPjZGDwq69wrn4El
 +12g==
X-Gm-Message-State: AOJu0Yz64n4V3Wu85ukeVnxIG7fZtNwVecJun87kq748ASfPnGepVsd3
 EcIVMmEnvCarI/2Xpaf5Bm93poRa1j2LfH9pXcZBd0UshU7GdxuNU5+TD8gxAhc4eNb0/hYwQUj
 LPM67EQ==
X-Google-Smtp-Source: AGHT+IHCHwLM3NopPQhYWq19fA11eXKFiFcbZuyfZV1n6IxbDmyseq57vJRkkfzIytgfGI1Pu+nkvA==
X-Received: by 2002:a05:620a:13fc:b0:78d:61ff:d608 with SMTP id
 h28-20020a05620a13fc00b0078d61ffd608mr6450516qkl.22.1714227087807; 
 Sat, 27 Apr 2024 07:11:27 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 15/18] env: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:03 -0600
Message-Id: <20240427141106.3406000-16-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all "env/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 env/attr.c             | 4 ++--
 env/callback.c         | 1 -
 env/common.c           | 1 -
 env/eeprom.c           | 1 -
 env/env.c              | 2 +-
 env/ext4.c             | 1 -
 env/fat.c              | 1 -
 env/flags.c            | 4 ++--
 env/flash.c            | 1 -
 env/mmc.c              | 1 -
 env/nand.c             | 1 -
 env/nowhere.c          | 1 -
 env/nvram.c            | 1 -
 env/onenand.c          | 1 -
 env/remote.c           | 2 +-
 env/sf.c               | 1 -
 env/ubi.c              | 1 -
 include/env_callback.h | 1 +
 include/env_default.h  | 1 +
 include/env_flags.h    | 2 ++
 20 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/env/attr.c b/env/attr.c
index a958c7148283..fed5b212e2f9 100644
--- a/env/attr.c
+++ b/env/attr.c
@@ -4,13 +4,13 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
+#include <stdio.h>
 #ifdef USE_HOSTCC /* Eliminate "ANSI does not permit..." warnings */
 #include <stdint.h>
-#include <stdio.h>
 #include <linux/linux_string.h>
 #else
-#include <common.h>
 #include <slre.h>
+#include <vsprintf.h>
 #endif
 
 #include <env_attr.h>
diff --git a/env/callback.c b/env/callback.c
index 98ddba035ea7..b7cbccd1175f 100644
--- a/env/callback.c
+++ b/env/callback.c
@@ -4,7 +4,6 @@
  * Joe Hershberger, National Instruments, joe.hershberger@ni.com
  */
 
-#include <common.h>
 #include <env.h>
 #include <env_internal.h>
 #include <asm/global_data.h>
diff --git a/env/common.c b/env/common.c
index 48a565107c11..d8c276dddfd9 100644
--- a/env/common.c
+++ b/env/common.c
@@ -7,7 +7,6 @@
  * Andreas Heppel <aheppel@sysgo.de>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <env.h>
diff --git a/env/eeprom.c b/env/eeprom.c
index 7ce7e9972b29..b290b1013e1c 100644
--- a/env/eeprom.c
+++ b/env/eeprom.c
@@ -7,7 +7,6 @@
  * Andreas Heppel <aheppel@sysgo.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <eeprom.h>
 #include <env.h>
diff --git a/env/env.c b/env/env.c
index bae3f6482aea..bcc189e14db7 100644
--- a/env/env.c
+++ b/env/env.c
@@ -4,13 +4,13 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <env.h>
 #include <env_internal.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/env/ext4.c b/env/ext4.c
index da26705b8daf..eb16568bd463 100644
--- a/env/ext4.c
+++ b/env/ext4.c
@@ -18,7 +18,6 @@
  * Manjunatha C Achar <a.manjunatha@samsung.com>
  */
 
-#include <common.h>
 #include <part.h>
 
 #include <command.h>
diff --git a/env/fat.c b/env/fat.c
index 3172130d75d3..2a40f123936c 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -6,7 +6,6 @@
  *  Maximilian Schwerin <mvs@tigris.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/env/flags.c b/env/flags.c
index e2866361dfe4..233fd460d842 100644
--- a/env/flags.c
+++ b/env/flags.c
@@ -8,9 +8,9 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 
+#include <stdio.h>
 #ifdef USE_HOSTCC /* Eliminate "ANSI does not permit..." warnings */
 #include <stdint.h>
-#include <stdio.h>
 #include "fw_env_private.h"
 #include "fw_env.h"
 #include <env_attr.h>
@@ -18,7 +18,7 @@
 #define env_get fw_getenv
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #else
-#include <common.h>
+#include <linux/kernel.h>
 #include <env_internal.h>
 #endif
 
diff --git a/env/flash.c b/env/flash.c
index 1e75f8c004ee..1bd6e7003d6e 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -9,7 +9,6 @@
 
 /* #define DEBUG */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/env/mmc.c b/env/mmc.c
index 7afb733e890f..776df0786be5 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -5,7 +5,6 @@
 
 /* #define DEBUG */
 
-#include <common.h>
 #include <asm/global_data.h>
 
 #include <command.h>
diff --git a/env/nand.c b/env/nand.c
index df300b131793..fef5697ec39d 100644
--- a/env/nand.c
+++ b/env/nand.c
@@ -13,7 +13,6 @@
  * Andreas Heppel <aheppel@sysgo.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/env/nowhere.c b/env/nowhere.c
index 9ebc357dbd78..326f27db2e9c 100644
--- a/env/nowhere.c
+++ b/env/nowhere.c
@@ -7,7 +7,6 @@
  * Andreas Heppel <aheppel@sysgo.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/env/nvram.c b/env/nvram.c
index 229c34f5367c..d49cd0f337a0 100644
--- a/env/nvram.c
+++ b/env/nvram.c
@@ -7,7 +7,6 @@
  * Andreas Heppel <aheppel@sysgo.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/env/onenand.c b/env/onenand.c
index 1faa2cb62a34..8c349ef5ce6c 100644
--- a/env/onenand.c
+++ b/env/onenand.c
@@ -7,7 +7,6 @@
  * Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env_internal.h>
 #include <asm/global_data.h>
diff --git a/env/remote.c b/env/remote.c
index 166bebf52b5b..0cc383c23602 100644
--- a/env/remote.c
+++ b/env/remote.c
@@ -5,10 +5,10 @@
 
 /* #define DEBUG */
 
-#include <common.h>
 #include <command.h>
 #include <env_internal.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 #include <linux/stddef.h>
 #include <u-boot/crc.h>
 
diff --git a/env/sf.c b/env/sf.c
index 8f5c03b00d33..c747e175e31b 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -8,7 +8,6 @@
  *
  * (C) Copyright 2008 Atmel Corporation
  */
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/env/ubi.c b/env/ubi.c
index 445d34fedb89..0c3e93c2bf2d 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -4,7 +4,6 @@
  *        Joe Hershberger <joe.hershberger@ni.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 
 #include <command.h>
diff --git a/include/env_callback.h b/include/env_callback.h
index 23bc650c162d..8e500aaaf806 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -7,6 +7,7 @@
 #ifndef __ENV_CALLBACK_H__
 #define __ENV_CALLBACK_H__
 
+#include <config.h>
 #include <env_flags.h>
 #include <linker_lists.h>
 #include <search.h>
diff --git a/include/env_default.h b/include/env_default.h
index 8ee500d1709c..076ffdd44e9b 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -7,6 +7,7 @@
  * Andreas Heppel <aheppel@sysgo.de>
  */
 
+#include <config.h>
 #include <env_callback.h>
 #include <linux/stringify.h>
 
diff --git a/include/env_flags.h b/include/env_flags.h
index d785f87cdcbe..2476043b0e38 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -7,6 +7,8 @@
 #ifndef __ENV_FLAGS_H__
 #define __ENV_FLAGS_H__
 
+#include <config.h>
+
 enum env_flags_vartype {
 	env_flags_vartype_string,
 	env_flags_vartype_decimal,
-- 
2.34.1

