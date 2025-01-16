Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D60C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 19:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E638033D;
	Thu, 16 Jan 2025 20:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Cz2ar193";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B288069D; Thu, 16 Jan 2025 20:27:10 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1FFB8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 20:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5731F3F686
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737055627;
 bh=G9YLCo2P77yAOLOXKtcrUYOVEvGSQ9zZBzSwWm92ZTc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Cz2ar193a4EyUE00IScHTNpQk2++57qGPQdJyHb1XHsApzulGonu/K3AjfpnL5aF6
 u3bCOJTrFH00J+OLv/52yelfWzxVSWu18FoLP5Lq2S5E+0UE+1Ldy3RWDSgT+E7wBI
 3Rzcl8SrwyEB1tB3+3Zanv5pcEZg4Gf1L0E58CzTAPEzOugzXx3TMpsqeJrfCto89f
 BKnfDwYKbkwNF1vK9n341cFa+DB5vzEHGEGre67aQ2C8A+O3qaKw6P/UGQMlZY87hI
 Sfw2R6ZP+YLFXj91FelYRM5FC8as93DAyh2vovqv8U8ekkmqmU0teI0TI0MMMDog8R
 3TdETxQBccWgQ==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aafc90962ffso147963666b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737055627; x=1737660427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9YLCo2P77yAOLOXKtcrUYOVEvGSQ9zZBzSwWm92ZTc=;
 b=IPq6yu2lFANSaeyrtyc6Usfo/sUug36pZaIpcWDS5D7tYgP/8TjoTx9DSbciGmyuGQ
 iIXABHs/mzKTwYX9Ih0UOeC3fyzz04NWQmcRks40Jc22ybJLHT6TzQEXG7oCggtnX0tM
 1U2XPg3Se0nzEjd6MaOZ5fC9qouRsxhBF8dtnXK+wpkK8NbKrvbX57305j+Qklt9tNW5
 tHcpAzCuUmEvNboWCNusg12pQwRq6vtVHMA7LlAvpYWw3OzRWlyzIVUz1nPCPWHaWrwy
 /XDiP55s+V4sFhoDp3DKIpgiX5dCvgDAXq8yNUZAp7kFa8+EJ4fTluvn4cXxN2WHMdE1
 IGng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7CDui8zusHu+ZdAqARaHgkw5OX/6ujEEqeDL0aVmNtppfmci3U1LefW6VUwumgOu3G5m9jZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YzhQ60yXxhtU9ty3456D3R/Knl4D0VjsrAOh4a/vc0g00AdNUGB
 NBFYsXG7mUSIalU4JIv6a0xDcUy4ommqobDu1dSTY3Ced6UJOpjCiYylWvSX0FoY9WonWy0r7x6
 DzqDCx6PIWaMJoDqJLNz4phGuS+uysNZWM20Xs1r099kWSVnfj0wfTHQbMq1Jio9BvOs=
X-Gm-Gg: ASbGncslAqCeXo1TR/TS0NBpZhRd8JhXDIXVFzyrRdl0x8StEPhfbLPXwvN5Mg4GPwR
 /rh7kBfFwl6S2zH79uN/vYQuaTVLWae8t2z5knJYPC4b1LMLb3IccfS0wPAM/kUi1t0GRMFhW5+
 nFtemuzo3syjqwg1er1QK02YlYufJaZg2jGCArRwqv3Jijb5ik0S+3O/KdWbM6JldEwijuo/dCl
 2dW8Vi1XCf9fuDEWmQgx5UjI5plUgirzbklM8slq2Mgz8yiyeXfv9SoXUvxmbnpcd4dV9F9oQ4r
 qrmwByuFd7VBug==
X-Received: by 2002:a17:906:f58e:b0:aa6:8e9e:1b5 with SMTP id
 a640c23a62f3a-ab38b1b4598mr3841666b.3.1737055626537; 
 Thu, 16 Jan 2025 11:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQXjwot9hrc8Q+x+VWcglwFGJqRqXqHXHrs6SnbAEBok6ZOW95QoEE11M6aVmMffQ7S+2RhQ==
X-Received: by 2002:a17:906:f58e:b0:aa6:8e9e:1b5 with SMTP id
 a640c23a62f3a-ab38b1b4598mr3839866b.3.1737055626077; 
 Thu, 16 Jan 2025 11:27:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f87065sm37717666b.133.2025.01.16.11.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 11:27:05 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: use LOGC_EFI consistently
Date: Thu, 16 Jan 2025 20:26:59 +0100
Message-ID: <20250116192659.374576-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

The log category should be LOGC_EFI all over the EFI sub-system.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_driver/efi_block_device.c          | 2 ++
 lib/efi_driver/efi_uclass.c                | 2 ++
 lib/efi_loader/efi_acpi.c                  | 2 ++
 lib/efi_loader/efi_boottime.c              | 2 ++
 lib/efi_loader/efi_conformance.c           | 2 ++
 lib/efi_loader/efi_device_path_to_text.c   | 2 ++
 lib/efi_loader/efi_device_path_utilities.c | 2 ++
 lib/efi_loader/efi_dt_fixup.c              | 2 ++
 lib/efi_loader/efi_esrt.c                  | 2 ++
 lib/efi_loader/efi_fdt.c                   | 2 ++
 lib/efi_loader/efi_file.c                  | 2 ++
 lib/efi_loader/efi_firmware.c              | 2 ++
 lib/efi_loader/efi_gop.c                   | 2 ++
 lib/efi_loader/efi_helper.c                | 1 +
 lib/efi_loader/efi_hii.c                   | 2 ++
 lib/efi_loader/efi_hii_config.c            | 2 ++
 lib/efi_loader/efi_http.c                  | 2 ++
 lib/efi_loader/efi_ipconfig.c              | 2 ++
 lib/efi_loader/efi_load_initrd.c           | 1 +
 lib/efi_loader/efi_net.c                   | 2 ++
 lib/efi_loader/efi_riscv.c                 | 1 +
 lib/efi_loader/efi_root_node.c             | 2 ++
 lib/efi_loader/efi_runtime.c               | 2 ++
 lib/efi_loader/efi_signature.c             | 2 ++
 lib/efi_loader/efi_string.c                | 2 ++
 lib/efi_loader/efi_tcg2.c                  | 1 +
 lib/efi_loader/efi_unicode_collation.c     | 2 ++
 lib/efi_loader/efi_var_common.c            | 2 ++
 lib/efi_loader/efi_var_mem.c               | 2 ++
 lib/efi_loader/efi_variable_tee.c          | 2 ++
 lib/efi_loader/efi_watchdog.c              | 2 ++
 31 files changed, 58 insertions(+)

diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index 19a5ee24794..d3c668dc183 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -28,6 +28,8 @@
  * iPXE uses the simple file protocol to load Grub or the Linux Kernel.
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <blk.h>
 #include <dm.h>
 #include <efi_driver.h>
diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index e1e28df20b2..495be53cb77 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -17,6 +17,8 @@
  * controllers.
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <dm.h>
 #include <efi_driver.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bd7f8ca24..c1cc6e7b311 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -5,6 +5,8 @@
  *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ccbaad2b549..9f51db90f33 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2016 Alexander Graf
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <bootm.h>
 #include <div64.h>
 #include <dm/device.h>
diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
index 167067e26cd..2bae93a94bd 100644
--- a/lib/efi_loader/efi_conformance.c
+++ b/lib/efi_loader/efi_conformance.c
@@ -5,6 +5,8 @@
  *  Copyright (C) 2022 Arm Ltd.
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <log.h>
 #include <efi_api.h>
diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 481a9712d9d..f6889cb7399 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -5,6 +5,8 @@
  *  Copyright (c) 2017 Heinrich Schuchardt
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <blk.h>
 #include <efi_loader.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index ac250bbfcc9..552c5bb1f05 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -5,6 +5,8 @@
  *  Copyright (c) 2017 Leif Lindholm
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 
 const efi_guid_t efi_guid_device_path_utilities_protocol =
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 0dac94b0c6c..26928cfc454 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2020 Heinrich Schuchardt
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_dt_fixup.h>
 #include <efi_loader.h>
 #include <efi_rng.h>
diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
index 443bd999ce1..e235c8fe91c 100644
--- a/lib/efi_loader/efi_esrt.c
+++ b/lib/efi_loader/efi_esrt.c
@@ -5,6 +5,8 @@
  *  Copyright (C) 2021 Arm Ltd.
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <log.h>
 #include <efi_api.h>
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index f882622fdad..1ba6641d821 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -6,6 +6,8 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <env.h>
 #include <errno.h>
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 95b3c890ee9..201fa5f8f3c 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2017 Rob Clark
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <charset.h>
 #include <efi_loader.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 112775daf4c..5a754c9cd03 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -6,6 +6,8 @@
  *			Author: AKASHI Takahiro
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <charset.h>
 #include <dfu.h>
 #include <efi_loader.h>
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 41e12fa7246..4593975be5a 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -5,6 +5,8 @@
  *  Copyright (c) 2016 Alexander Graf
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <dm.h>
 #include <efi_loader.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bf96f61d3d0..04b2efc4a3b 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -4,6 +4,7 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
+
 #include <bootm.h>
 #include <env.h>
 #include <image.h>
diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 74e402df1b8..44235970a7c 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -6,6 +6,8 @@
  *  Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <malloc.h>
 #include <asm/unaligned.h>
diff --git a/lib/efi_loader/efi_hii_config.c b/lib/efi_loader/efi_hii_config.c
index 54a72d573be..521481a86d8 100644
--- a/lib/efi_loader/efi_hii_config.c
+++ b/lib/efi_loader/efi_hii_config.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2018 AKASHI Takahiro, Linaro Limited
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 
 const efi_guid_t efi_guid_hii_config_routing_protocol
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 694e1993418..88816256b03 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -7,6 +7,8 @@
  * IP4_CONFIG2_PROTOCOL
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <charset.h>
 #include <efi_loader.h>
 #include <image.h>
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
index 0b247a4c028..f1c092daafd 100644
--- a/lib/efi_loader/efi_ipconfig.c
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -4,6 +4,8 @@
  *
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <image.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index 23508431c83..fb8cc7bcbe3 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -4,6 +4,7 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <efi_load_initrd.h>
 #include <efi_variable.h>
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 67593ef50c0..ce9272fa240 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -15,6 +15,8 @@
  * Reset():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <dm.h>
 #include <linux/sizes.h>
diff --git a/lib/efi_loader/efi_riscv.c b/lib/efi_loader/efi_riscv.c
index 4d398c5be34..6f2ccf4f7e6 100644
--- a/lib/efi_loader/efi_riscv.c
+++ b/lib/efi_loader/efi_riscv.c
@@ -7,6 +7,7 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
diff --git a/lib/efi_loader/efi_root_node.c b/lib/efi_loader/efi_root_node.c
index 426f77cb2ad..e5246f65df2 100644
--- a/lib/efi_loader/efi_root_node.c
+++ b/lib/efi_loader/efi_root_node.c
@@ -5,6 +5,8 @@
  *  Copyright (c) 2018 Heinrich Schuchardt
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <malloc.h>
 #include <efi_dt_fixup.h>
 #include <efi_loader.h>
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 05369c47b01..35eb6a77766 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -5,6 +5,8 @@
  *  Copyright (c) 2016 Alexander Graf
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 184eac8cddb..93a4f257016 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2019 Linaro Limited, Author: AKASHI Takahiro
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <charset.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
diff --git a/lib/efi_loader/efi_string.c b/lib/efi_loader/efi_string.c
index 413e329b600..50d1daf33a9 100644
--- a/lib/efi_loader/efi_string.c
+++ b/lib/efi_loader/efi_string.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2020 AKASHI Takahiro, Linaro Limited
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <charset.h>
 #include <efi_loader.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index a15c73162ee..c697b53441a 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -8,6 +8,7 @@
  */
 
 #define LOG_CATEGORY LOGC_EFI
+
 #include <dm.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
index d48700a352b..df2a988ee39 100644
--- a/lib/efi_loader/efi_unicode_collation.c
+++ b/lib/efi_loader/efi_unicode_collation.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2018 Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <charset.h>
 #include <cp1250.h>
 #include <cp437.h>
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index ea8d2a4cf98..4b34a58b4cf 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2020 Linaro Limited, Author: AKASHI Takahiro
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <stdlib.h>
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 139e16aad7c..b265d95dd6b 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2020, Heinrich Schuchardt
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <u-boot/crc.h>
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 8b6b0a39086..0d090d051dd 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -10,6 +10,8 @@
  *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
 #include <arm_ffa.h>
 #endif
diff --git a/lib/efi_loader/efi_watchdog.c b/lib/efi_loader/efi_watchdog.c
index f5fb9117717..c21d8086074 100644
--- a/lib/efi_loader/efi_watchdog.c
+++ b/lib/efi_loader/efi_watchdog.c
@@ -5,6 +5,8 @@
  *  Copyright (c) 2017 Heinrich Schuchardt
  */
 
+#define LOG_CATEGORY LOGC_EFI
+
 #include <efi_loader.h>
 
 /* Conversion factor from seconds to multiples of 100ns */
-- 
2.47.1

