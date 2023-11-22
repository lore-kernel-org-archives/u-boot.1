Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C6C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9E587097;
	Wed, 22 Nov 2023 14:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bNRz2Xty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75909875EF; Wed, 22 Nov 2023 14:12:09 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EA0875F1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9beb865a40so6324715276.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658722; x=1701263522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMCett7Kq6K4rtf381amf8Y5X5SPwVppeytC3u9nbxw=;
 b=bNRz2XtyRo7Fph2M/MAU0KrcE6pc7laEmYBkNSgx431uCgwFTDoSW1QtMwbFzKBkMk
 ggS9uO5vSgh1j33Mz8xG5GcztKIM6/4iMCBFZnIwqdOwgVbG1HuxQIaMExg/5RsXiO4o
 PQ2W/5wBORgmvBLmoXvHwe95DKmSwaz14fvas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658722; x=1701263522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMCett7Kq6K4rtf381amf8Y5X5SPwVppeytC3u9nbxw=;
 b=bCOmKiDNRFtB798UCWDtcupfVVzGE0AzK+s/sXh1QyR8xgQSp/3Ch/n/U0aDsqZP/L
 6ZvqXdFGCd25cpvRmltSqg3KrQKjcAMXcdt7uzaod+gJOBr0MqjS2YmmWmUKwD75KO7W
 GCMM3aniaMbCuTMjFykDUF9Lnm0Y09vAs+UMlob4V6oNlDcA3EvQ992z7qr5/rfeU2Jw
 SMIkOj0xxB6dxASYvt0mAiNfSoU802YE5VCkdN0e0YHOeq5uO0lFpQwPmabVdfmwNRak
 M8nAt+AJ5Uv/Z7wL+m1O0vburLIHVIPhhW+kqXHi2pe8a+VAus/JXldRAJlcdYskJWPw
 25vQ==
X-Gm-Message-State: AOJu0YxfNNALq/OsxiU9KTSehyyg3fxsobFSqyyCjfcO+D+eTQ3dGoMu
 r3dFSd1yujzSKCjVPhHt1Weud7mxepY2ACRxytEdaQ==
X-Google-Smtp-Source: AGHT+IEtK8gSo1qlSTbXVR64jxGwDD2DtdtzNdCSc9xesBbdPOP6pryjj6lTDsYELJNhI9idIGjbtA==
X-Received: by 2002:a25:c094:0:b0:d9c:7d48:3020 with SMTP id
 c142-20020a25c094000000b00d9c7d483020mr1917094ybf.20.1700658722483; 
 Wed, 22 Nov 2023 05:12:02 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:12:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 08/11] efi_loader: Remove <common.h>
Date: Wed, 22 Nov 2023 08:11:51 -0500
Message-Id: <20231122131154.2444690-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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

We largely do not need <common.h> in these files, so drop it. The only
exception here is that efi_freestanding.c needs <linux/types.h> and had
been getting that via <common.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_loader.h                       | 1 -
 lib/efi_loader/dtbdump.c                   | 1 -
 lib/efi_loader/efi_acpi.c                  | 1 -
 lib/efi_loader/efi_bootmgr.c               | 1 -
 lib/efi_loader/efi_boottime.c              | 1 -
 lib/efi_loader/efi_capsule.c               | 1 -
 lib/efi_loader/efi_conformance.c           | 1 -
 lib/efi_loader/efi_console.c               | 1 -
 lib/efi_loader/efi_device_path.c           | 1 -
 lib/efi_loader/efi_device_path_to_text.c   | 1 -
 lib/efi_loader/efi_device_path_utilities.c | 1 -
 lib/efi_loader/efi_disk.c                  | 1 -
 lib/efi_loader/efi_dt_fixup.c              | 1 -
 lib/efi_loader/efi_esrt.c                  | 1 -
 lib/efi_loader/efi_file.c                  | 1 -
 lib/efi_loader/efi_firmware.c              | 1 -
 lib/efi_loader/efi_freestanding.c          | 2 +-
 lib/efi_loader/efi_gop.c                   | 1 -
 lib/efi_loader/efi_helper.c                | 1 -
 lib/efi_loader/efi_hii.c                   | 1 -
 lib/efi_loader/efi_hii_config.c            | 1 -
 lib/efi_loader/efi_image_loader.c          | 1 -
 lib/efi_loader/efi_load_initrd.c           | 1 -
 lib/efi_loader/efi_load_options.c          | 1 -
 lib/efi_loader/efi_memory.c                | 1 -
 lib/efi_loader/efi_net.c                   | 1 -
 lib/efi_loader/efi_riscv.c                 | 1 -
 lib/efi_loader/efi_rng.c                   | 1 -
 lib/efi_loader/efi_root_node.c             | 1 -
 lib/efi_loader/efi_runtime.c               | 1 -
 lib/efi_loader/efi_setup.c                 | 1 -
 lib/efi_loader/efi_signature.c             | 1 -
 lib/efi_loader/efi_smbios.c                | 1 -
 lib/efi_loader/efi_string.c                | 1 -
 lib/efi_loader/efi_tcg2.c                  | 1 -
 lib/efi_loader/efi_unicode_collation.c     | 1 -
 lib/efi_loader/efi_var_common.c            | 1 -
 lib/efi_loader/efi_var_file.c              | 1 -
 lib/efi_loader/efi_var_mem.c               | 1 -
 lib/efi_loader/efi_variable.c              | 1 -
 lib/efi_loader/efi_variable_tee.c          | 1 -
 lib/efi_loader/efi_watchdog.c              | 1 -
 lib/efi_loader/initrddump.c                | 1 -
 43 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f40..247be060e1c0 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -8,7 +8,6 @@
 #ifndef _EFI_LOADER_H
 #define _EFI_LOADER_H 1
 
-#include <common.h>
 #include <blk.h>
 #include <event.h>
 #include <log.h>
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 3ce2a07f9eb0..5f39cf22da79 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -6,7 +6,6 @@
  * to a file.
  */
 
-#include <common.h>
 #include <efi_api.h>
 #include <efi_dt_fixup.h>
 #include <part.h>
diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index f755af76f866..67bbd2a01c0b 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -5,7 +5,6 @@
  *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c83..47691d8a3d4d 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <charset.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5af1..f82b1a809f8f 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2016 Alexander Graf
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <div64.h>
 #include <dm/device.h>
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index af8a2ee940ce..de0d49ebebda 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <env.h>
diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
index 0ca26f57a7f2..167067e26cd1 100644
--- a/lib/efi_loader/efi_conformance.c
+++ b/lib/efi_loader/efi_conformance.c
@@ -5,7 +5,6 @@
  *  Copyright (C) 2022 Arm Ltd.
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <log.h>
 #include <efi_api.h>
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index a2d137d7a9e1..03dece51aeaa 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -8,7 +8,6 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <ansi.h>
-#include <common.h>
 #include <charset.h>
 #include <malloc.h>
 #include <time.h>
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a347..8dbd8105ae26 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <dm/root.h>
diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 8c76d8be605d..0c7b30a26e7e 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2017 Heinrich Schuchardt
  */
 
-#include <common.h>
 #include <blk.h>
 #include <efi_loader.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index a07d9bab3a3c..844d8acd67c0 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2017 Leif Lindholm
  */
 
-#include <common.h>
 #include <efi_loader.h>
 
 const efi_guid_t efi_guid_device_path_utilities_protocol =
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f0d76113b001..321f9b82b73c 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 838023c78ff7..2176388f4207 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020 Heinrich Schuchardt
  */
 
-#include <common.h>
 #include <efi_dt_fixup.h>
 #include <efi_loader.h>
 #include <efi_rng.h>
diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
index 7f46d651e6f2..dafd447b6d76 100644
--- a/lib/efi_loader/efi_esrt.c
+++ b/lib/efi_loader/efi_esrt.c
@@ -5,7 +5,6 @@
  *  Copyright (C) 2021 Arm Ltd.
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <log.h>
 #include <efi_api.h>
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 3c56cebf9653..222001d6a3b5 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2017 Rob Clark
  */
 
-#include <common.h>
 #include <charset.h>
 #include <efi_loader.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9abb29f1dff1..1fde1885e3ca 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -6,7 +6,6 @@
  *			Author: AKASHI Takahiro
  */
 
-#include <common.h>
 #include <charset.h>
 #include <dfu.h>
 #include <efi_loader.h>
diff --git a/lib/efi_loader/efi_freestanding.c b/lib/efi_loader/efi_freestanding.c
index 4b65fc64dd04..b2786095c323 100644
--- a/lib/efi_loader/efi_freestanding.c
+++ b/lib/efi_loader/efi_freestanding.c
@@ -8,7 +8,7 @@
  * memset(), and memcmp().
  */
 
-#include <common.h>
+#include <linux/types.h>
 
 /**
  * memcmp() - compare memory areas
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index a09db31eb465..41e12fa72460 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2016 Alexander Graf
  */
 
-#include <common.h>
 #include <dm.h>
 #include <efi_loader.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index cdfd16ea7742..17f27ca1a0b2 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -4,7 +4,6 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
-#include <common.h>
 #include <env.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 3b54ecb11ac1..74e402df1b8a 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -6,7 +6,6 @@
  *  Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <malloc.h>
 #include <asm/unaligned.h>
diff --git a/lib/efi_loader/efi_hii_config.c b/lib/efi_loader/efi_hii_config.c
index 31b0c97eb286..ae0f3ecd3b18 100644
--- a/lib/efi_loader/efi_hii_config.c
+++ b/lib/efi_loader/efi_hii_config.c
@@ -10,7 +10,6 @@
  * the Makefile.
  */
 
-#include <common.h>
 #include <efi_loader.h>
 
 const efi_guid_t efi_guid_hii_config_routing_protocol
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 97547571ce33..604243603289 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <cpu_func.h>
 #include <efi_loader.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index 193433782c24..2b467b554810 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -4,7 +4,6 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_load_initrd.h>
 #include <efi_variable.h>
diff --git a/lib/efi_loader/efi_load_options.c b/lib/efi_loader/efi_load_options.c
index 5f62184da1cd..01984235e248 100644
--- a/lib/efi_loader/efi_load_options.c
+++ b/lib/efi_loader/efi_load_options.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <charset.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f752703b438e..edfad2d95a1d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <efi_loader.h>
 #include <init.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 96a5bcca2758..7cd536705f43 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -15,7 +15,6 @@
  * Reset():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <malloc.h>
 #include <net.h>
diff --git a/lib/efi_loader/efi_riscv.c b/lib/efi_loader/efi_riscv.c
index 064172755b95..4d398c5be348 100644
--- a/lib/efi_loader/efi_riscv.c
+++ b/lib/efi_loader/efi_riscv.c
@@ -7,7 +7,6 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index bb11d8d0e0cb..9bad7ed69317 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <dm.h>
 #include <efi_loader.h>
 #include <efi_rng.h>
diff --git a/lib/efi_loader/efi_root_node.c b/lib/efi_loader/efi_root_node.c
index 108c14b95bd6..4d7fb74b5d6f 100644
--- a/lib/efi_loader/efi_root_node.c
+++ b/lib/efi_loader/efi_root_node.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2018 Heinrich Schuchardt
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <efi_dt_fixup.h>
 #include <efi_loader.h>
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index bf54d6ad871d..18da6892e796 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2016 Alexander Graf
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index e6de685e8795..36f66c51921b 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 742d8919402c..f338e7327599 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2019 Linaro Limited, Author: AKASHI Takahiro
  */
 
-#include <common.h>
 #include <charset.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 48446f654d9b..2a79c0b1ba60 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <efi_loader.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_string.c b/lib/efi_loader/efi_string.c
index e21e09c94617..413e329b600c 100644
--- a/lib/efi_loader/efi_string.c
+++ b/lib/efi_loader/efi_string.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020 AKASHI Takahiro, Linaro Limited
  */
 
-#include <common.h>
 #include <charset.h>
 #include <efi_loader.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 463ea4c15416..8db35d0b3c85 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -8,7 +8,6 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
-#include <common.h>
 #include <dm.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
index c4c75720634a..2b6912c50921 100644
--- a/lib/efi_loader/efi_unicode_collation.c
+++ b/lib/efi_loader/efi_unicode_collation.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018 Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <charset.h>
 #include <cp1250.h>
 #include <cp437.h>
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index ad50bffd2b26..d528747f3fb4 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2020 Linaro Limited, Author: AKASHI Takahiro
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <stdlib.h>
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index d7dba050710a..532b6b40eefe 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <charset.h>
 #include <fs.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 5fa7dcb8d3ed..6c21cec5d457 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020, Heinrich Schuchardt
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <u-boot/crc.h>
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6ef..40f7a0fb10d5 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <env.h>
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 09d03c0eee78..dde135fd9f81 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -10,7 +10,6 @@
  *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
 #include <arm_ffa.h>
 #endif
diff --git a/lib/efi_loader/efi_watchdog.c b/lib/efi_loader/efi_watchdog.c
index d741076dcdd9..f5fb9117717c 100644
--- a/lib/efi_loader/efi_watchdog.c
+++ b/lib/efi_loader/efi_watchdog.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2017 Heinrich Schuchardt
  */
 
-#include <common.h>
 #include <efi_loader.h>
 
 /* Conversion factor from seconds to multiples of 100ns */
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 5b470f481946..0004b6b042b4 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -9,7 +9,6 @@
  * clearing of the screen.
  */
 
-#include <common.h>
 #include <efi_api.h>
 #include <efi_load_initrd.h>
 
-- 
2.34.1

