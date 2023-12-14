Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD30C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B0187BBD;
	Thu, 14 Dec 2023 19:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p6LmDEEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E2A87BAE; Thu, 14 Dec 2023 19:17:19 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C410C87B83
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e2bd289172so20808277b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577833; x=1703182633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wkf22a7rfdKCa3LACOeJPfTN7bS5rQ5uZ4exP+ol5zE=;
 b=p6LmDEErYUBeKqXyWR0eOkB7S7xB1EGYPSlb2rkYFKf05AlCUYX3PvdXxRLFqUYj3N
 0+kMEnT2/vKElA/nrd+L9P0O8rmQc3dMqowAy28HQVvHM9P0cLteMUhQz4Cs02WuLJcr
 n+2WUva+UPx0tZXIEE7bwKZ+ZiB1Ju3imGFRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577833; x=1703182633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wkf22a7rfdKCa3LACOeJPfTN7bS5rQ5uZ4exP+ol5zE=;
 b=d/rGFEA4c7v1DNrumWkfdHX68/c55F+TH9H/VPMp3RabCvncf6QVFlUcgDrWwWNQjw
 DZjGCz5or1saV4ETlKH1155WmTEL5EjkXQLvXrqzMU5ybfgMfAZ4zdnrvU+fQAHTmsj2
 rCp5VzCSX3IqkWnDzJJ6iZHI/NM8ix45hfoic5oUItlk28pAoLqrMlOl2E4EJQ/YLaXw
 CodH5CRBcZasPq9RzStXDf4jmV8GWKUP9jJDdnC0DiOLfnp/FBjMQBTAEYyVAKDygn4G
 YeXUJZYKrzJ3AsoPCovIsf1Thos6X2iM9fheVMKF4Au8C9p9PTkJNDx69UjJyOmsDTwB
 KzuQ==
X-Gm-Message-State: AOJu0YyI+1/UYQP7TKmIHhZfESDbvheh/k0WXLOwgjOM2HJR5WMmnvcP
 kTCoUelygu+0u9KKpRG17bsyv+JpkADlYrw1bOo=
X-Google-Smtp-Source: AGHT+IG9F5HzutKTNskJWGtGVWsihz11ACJwIpus143K+7RzTMPpulHhtmHVHcUDhHhWV/NOBFdnIg==
X-Received: by 2002:a0d:dbc1:0:b0:5e3:8b90:6e80 with SMTP id
 d184-20020a0ddbc1000000b005e38b906e80mr1331677ywe.96.1702577832859; 
 Thu, 14 Dec 2023 10:17:12 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 16/16] lib: Remove <common.h> inclusion from these files
Date: Thu, 14 Dec 2023 13:16:58 -0500
Message-Id: <20231214181658.3359902-16-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

After some header file cleanups to add missing include files, remove
common.h from all files in the lib directory. This primarily means just
dropping the line but in a few cases we need to add in other header
files now.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 lib/abuf.c                                        | 1 -
 lib/acpi/acpi.c                                   | 1 -
 lib/acpi/acpi_device.c                            | 1 -
 lib/acpi/acpi_dp.c                                | 1 -
 lib/acpi/acpi_table.c                             | 1 -
 lib/acpi/acpi_writer.c                            | 2 +-
 lib/acpi/acpigen.c                                | 1 -
 lib/acpi/base.c                                   | 3 ++-
 lib/acpi/csrt.c                                   | 2 +-
 lib/acpi/dsdt.c                                   | 2 +-
 lib/acpi/facs.c                                   | 2 +-
 lib/acpi/mcfg.c                                   | 4 +++-
 lib/acpi/ssdt.c                                   | 3 ++-
 lib/addr_map.c                                    | 1 -
 lib/aes.c                                         | 2 +-
 lib/aes/aes-decrypt.c                             | 1 -
 lib/asm-offsets.c                                 | 2 +-
 lib/at91/at91.c                                   | 1 -
 lib/bch.c                                         | 1 -
 lib/binman.c                                      | 1 -
 lib/bzip2/bzlib.c                                 | 3 +--
 lib/bzip2/bzlib_decompress.c                      | 1 -
 lib/charset.c                                     | 1 -
 lib/circbuf.c                                     | 1 -
 lib/crc16-ccitt.c                                 | 2 --
 lib/crc32.c                                       | 1 -
 lib/crc32c.c                                      | 1 -
 lib/crc8.c                                        | 2 --
 lib/crypt/crypt-port.h                            | 3 +++
 lib/crypt/crypt.c                                 | 1 -
 lib/crypto/x509_public_key.c                      | 1 -
 lib/date.c                                        | 1 -
 lib/dhry/cmd_dhry.c                               | 3 ++-
 lib/dhry/dhry_1.c                                 | 2 +-
 lib/dhry/dhry_2.c                                 | 2 +-
 lib/efi/efi.c                                     | 1 -
 lib/efi/efi_app.c                                 | 1 -
 lib/efi/efi_info.c                                | 1 -
 lib/efi/efi_stub.c                                | 1 -
 lib/efi_driver/efi_block_device.c                 | 1 -
 lib/efi_driver/efi_uclass.c                       | 1 -
 lib/efi_selftest/efi_selftest_esrt.c              | 1 -
 lib/efi_selftest/efi_selftest_miniapp_exception.c | 1 -
 lib/efi_selftest/efi_selftest_miniapp_exit.c      | 1 -
 lib/efi_selftest/efi_selftest_miniapp_return.c    | 1 -
 lib/elf.c                                         | 1 -
 lib/errno_str.c                                   | 2 +-
 lib/fdtdec.c                                      | 1 -
 lib/fdtdec_common.c                               | 1 -
 lib/fdtdec_test.c                                 | 1 -
 lib/getopt.c                                      | 2 +-
 lib/gunzip.c                                      | 1 -
 lib/gzip.c                                        | 1 -
 lib/hang.c                                        | 2 +-
 lib/hash-checksum.c                               | 1 -
 lib/hashtable.c                                   | 1 -
 lib/hexdump.c                                     | 2 +-
 lib/image-sparse.c                                | 1 -
 lib/initcall.c                                    | 1 -
 lib/linux_compat.c                                | 1 -
 lib/list_sort.c                                   | 1 -
 lib/lmb.c                                         | 1 -
 lib/lz4.c                                         | 1 -
 lib/lz4_wrapper.c                                 | 1 -
 lib/lzma/LzmaDec.c                                | 1 -
 lib/lzma/LzmaTools.c                              | 1 -
 lib/lzo/lzo1x_decompress.c                        | 3 ++-
 lib/md5.c                                         | 1 -
 lib/membuff.c                                     | 1 -
 lib/net_utils.c                                   | 2 +-
 lib/of_live.c                                     | 1 -
 lib/optee/optee.c                                 | 1 -
 lib/panic.c                                       | 1 -
 lib/physmem.c                                     | 2 +-
 lib/qsort.c                                       | 1 -
 lib/rand.c                                        | 1 -
 lib/rc4.c                                         | 3 ---
 lib/rsa/rsa-keyprop.c                             | 1 -
 lib/rsa/rsa-mod-exp.c                             | 1 -
 lib/rsa/rsa-verify.c                              | 1 -
 lib/rtc-lib.c                                     | 1 -
 lib/semihosting.c                                 | 3 ++-
 lib/slre.c                                        | 2 +-
 lib/smbios-parser.c                               | 1 -
 lib/smbios.c                                      | 1 -
 lib/strto.c                                       | 2 +-
 lib/tables_csum.c                                 | 3 +--
 lib/time.c                                        | 1 -
 lib/tiny-printf.c                                 | 1 -
 lib/tpm-common.c                                  | 1 -
 lib/tpm-v1.c                                      | 1 -
 lib/tpm-v2.c                                      | 1 -
 lib/tpm_api.c                                     | 1 -
 lib/trace.c                                       | 2 +-
 lib/uuid.c                                        | 2 --
 lib/vsprintf.c                                    | 1 -
 lib/zstd/zstd.c                                   | 2 +-
 97 files changed, 36 insertions(+), 103 deletions(-)

diff --git a/lib/abuf.c b/lib/abuf.c
index ce2cff53dc93..937c3df351e9 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -7,7 +7,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <string.h>
diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index f21e5094615c..939a638bb5b5 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -5,7 +5,6 @@
  * Copyright 2023 Google LLC
  */
 
-#include <common.h>
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
diff --git a/lib/acpi/acpi_device.c b/lib/acpi/acpi_device.c
index 1b838fdbd6f0..ed94194346d5 100644
--- a/lib/acpi/acpi_device.c
+++ b/lib/acpi/acpi_device.c
@@ -6,7 +6,6 @@
  * Mostly taken from coreboot file of the same name
  */
 
-#include <common.h>
 #include <dm.h>
 #include <irq.h>
 #include <log.h>
diff --git a/lib/acpi/acpi_dp.c b/lib/acpi/acpi_dp.c
index 7e3e3259d8d4..6733809986ae 100644
--- a/lib/acpi/acpi_dp.c
+++ b/lib/acpi/acpi_dp.c
@@ -6,7 +6,6 @@
  * Mostly taken from coreboot file acpi_device.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index a8d4b470001d..e74522e9972e 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <cpu.h>
 #include <log.h>
diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
index 946f90e8e7b1..a8dc207557b4 100644
--- a/lib/acpi/acpi_writer.c
+++ b/lib/acpi/acpi_writer.c
@@ -7,13 +7,13 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
 #include <dm/acpi.h>
+#include <linux/errno.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/lib/acpi/acpigen.c b/lib/acpi/acpigen.c
index e395226e3de3..b95cabb91493 100644
--- a/lib/acpi/acpigen.c
+++ b/lib/acpi/acpigen.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <uuid.h>
diff --git a/lib/acpi/base.c b/lib/acpi/base.c
index 26bf0cb8d30d..07b53e0c5614 100644
--- a/lib/acpi/base.c
+++ b/lib/acpi/base.c
@@ -7,12 +7,13 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
 #include <mapmem.h>
 #include <tables_csum.h>
 #include <linux/sizes.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 
 void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
 		     struct acpi_xsdt *xsdt)
diff --git a/lib/acpi/csrt.c b/lib/acpi/csrt.c
index 2ba86f229529..00927e534063 100644
--- a/lib/acpi/csrt.c
+++ b/lib/acpi/csrt.c
@@ -7,11 +7,11 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <mapmem.h>
 #include <tables_csum.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 __weak int acpi_fill_csrt(struct acpi_ctx *ctx)
 {
diff --git a/lib/acpi/dsdt.c b/lib/acpi/dsdt.c
index db98cc20e1d0..206e1e2678ff 100644
--- a/lib/acpi/dsdt.c
+++ b/lib/acpi/dsdt.c
@@ -7,10 +7,10 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
 #include <tables_csum.h>
+#include <linux/string.h>
 
 /*
  * IASL compiles the dsdt entries and writes the hex values
diff --git a/lib/acpi/facs.c b/lib/acpi/facs.c
index e89f43ca5c91..86c28120c7e3 100644
--- a/lib/acpi/facs.c
+++ b/lib/acpi/facs.c
@@ -7,9 +7,9 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/string.h>
 
 int acpi_write_facs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
diff --git a/lib/acpi/mcfg.c b/lib/acpi/mcfg.c
index 7404ae586ab7..8b8a5bfafae2 100644
--- a/lib/acpi/mcfg.c
+++ b/lib/acpi/mcfg.c
@@ -7,11 +7,13 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <mapmem.h>
 #include <tables_csum.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
 			      u16 seg_nr, u8 start, u8 end)
diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
index b140b4b2ff65..b0a96f846e39 100644
--- a/lib/acpi/ssdt.c
+++ b/lib/acpi/ssdt.c
@@ -7,10 +7,11 @@
 
 #define LOG_CATEGORY LOGC_ACPI
 
-#include <common.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
 #include <tables_csum.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 
 int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
diff --git a/lib/addr_map.c b/lib/addr_map.c
index 86e932e4b561..f85fb0c7fb1b 100644
--- a/lib/addr_map.c
+++ b/lib/addr_map.c
@@ -3,7 +3,6 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <addr_map.h>
 #include <mapmem.h>
 
diff --git a/lib/aes.c b/lib/aes.c
index 4fca85ebee26..39ad4a990f07 100644
--- a/lib/aes.c
+++ b/lib/aes.c
@@ -22,9 +22,9 @@
 */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <display_options.h>
 #include <log.h>
+#include <linux/string.h>
 #else
 #include <string.h>
 #endif
diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 345029fa7847..741102a4723b 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -4,7 +4,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <malloc.h>
 #endif
 #include <image.h>
diff --git a/lib/asm-offsets.c b/lib/asm-offsets.c
index 216d9716d0d6..4e2dbda9a710 100644
--- a/lib/asm-offsets.c
+++ b/lib/asm-offsets.c
@@ -11,9 +11,9 @@
  * #defines from the assembly-language output.
  */
 
-#include <common.h>
 #include <asm-offsets.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 #include <linux/kbuild.h>
 
diff --git a/lib/at91/at91.c b/lib/at91/at91.c
index 048597690b1d..bd31e9e41dc1 100644
--- a/lib/at91/at91.c
+++ b/lib/at91/at91.c
@@ -4,7 +4,6 @@
  *		 Wenyou.Yang <wenyou.yang@microchip.com>
  */
 
-#include <common.h>
 #include <atmel_lcd.h>
 
 #include "atmel_logo_8bpp.h"
diff --git a/lib/bch.c b/lib/bch.c
index 72b4fdcc9c44..a309a8dfcba4 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -54,7 +54,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <ubi_uboot.h>
diff --git a/lib/binman.c b/lib/binman.c
index cfe1e5f80710..9047f5275f32 100644
--- a/lib/binman.c
+++ b/lib/binman.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <binman.h>
 #include <dm.h>
 #include <log.h>
diff --git a/lib/bzip2/bzlib.c b/lib/bzip2/bzlib.c
index bd589aa810c1..f7318b7886e0 100644
--- a/lib/bzip2/bzlib.c
+++ b/lib/bzip2/bzlib.c
@@ -1,7 +1,6 @@
-#include <config.h>
-#include <common.h>
 #include <malloc.h>
 #include <watchdog.h>
+#include <stdio.h>
 
 /*
  * This file is a modified version of bzlib.c from the bzip2-1.0.2
diff --git a/lib/bzip2/bzlib_decompress.c b/lib/bzip2/bzlib_decompress.c
index 3b417d57b276..e56ab6674b05 100644
--- a/lib/bzip2/bzlib_decompress.c
+++ b/lib/bzip2/bzlib_decompress.c
@@ -1,5 +1,4 @@
 #include <config.h>
-#include <common.h>
 #include <watchdog.h>
 
 /*-------------------------------------------------------------*/
diff --git a/lib/charset.c b/lib/charset.c
index 5e4c4f948a4a..89057ef7ce22 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -5,7 +5,6 @@
  *  Copyright (c) 2017 Rob Clark
  */
 
-#include <common.h>
 #include <charset.h>
 #include <capitalization.h>
 #include <cp437.h>
diff --git a/lib/circbuf.c b/lib/circbuf.c
index fa79c148dae4..2e161ae8d8ba 100644
--- a/lib/circbuf.c
+++ b/lib/circbuf.c
@@ -4,7 +4,6 @@
  * Gerry Hamel, geh@ti.com, Texas Instruments
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 
diff --git a/lib/crc16-ccitt.c b/lib/crc16-ccitt.c
index 6cadbc103d3e..6fa4e93ed17c 100644
--- a/lib/crc16-ccitt.c
+++ b/lib/crc16-ccitt.c
@@ -24,8 +24,6 @@
 
 #ifdef USE_HOSTCC
 #include <arpa/inet.h>
-#else
-#include <common.h>
 #endif
 #include <u-boot/crc.h>
 
diff --git a/lib/crc32.c b/lib/crc32.c
index f6fad8c15dfc..f36f1763064f 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -11,7 +11,6 @@
 #ifdef USE_HOSTCC
 #include <arpa/inet.h>
 #else
-#include <common.h>
 #include <efi_loader.h>
 #endif
 #include <compiler.h>
diff --git a/lib/crc32c.c b/lib/crc32c.c
index 016b34a523b8..7026ac4c330e 100644
--- a/lib/crc32c.c
+++ b/lib/crc32c.c
@@ -10,7 +10,6 @@
  * any later version.
  */
 
-#include <common.h>
 #include <compiler.h>
 
 uint32_t crc32c_cal(uint32_t crc, const char *data, int length,
diff --git a/lib/crc8.c b/lib/crc8.c
index 87b87b675b27..20d46d161472 100644
--- a/lib/crc8.c
+++ b/lib/crc8.c
@@ -5,8 +5,6 @@
 
 #ifdef USE_HOSTCC
 #include <arpa/inet.h>
-#else
-#include <common.h>
 #endif
 #include <u-boot/crc.h>
 
diff --git a/lib/crypt/crypt-port.h b/lib/crypt/crypt-port.h
index 6b9542d75bc2..50dde68b5cde 100644
--- a/lib/crypt/crypt-port.h
+++ b/lib/crypt/crypt-port.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2020 Steffen Jaeckel <jaeckel-floss@eyet-services.de> */
 
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <vsprintf.h>
 
diff --git a/lib/crypt/crypt.c b/lib/crypt/crypt.c
index 247c34b2a9c3..8f5fadb582ed 100644
--- a/lib/crypt/crypt.c
+++ b/lib/crypt/crypt.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright (C) 2020 Steffen Jaeckel <jaeckel-floss@eyet-services.de> */
 
-#include <common.h>
 #include <crypt.h>
 #include "crypt-port.h"
 
diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
index 30071233ee79..a10145a7cdcf 100644
--- a/lib/crypto/x509_public_key.c
+++ b/lib/crypto/x509_public_key.c
@@ -7,7 +7,6 @@
 
 #define pr_fmt(fmt) "X.509: "fmt
 #ifdef __UBOOT__
-#include <common.h>
 #include <image.h>
 #include <dm/devres.h>
 #include <linux/compat.h>
diff --git a/lib/date.c b/lib/date.c
index e3d22459cd05..0deac8a1bee1 100644
--- a/lib/date.c
+++ b/lib/date.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <rtc.h>
diff --git a/lib/dhry/cmd_dhry.c b/lib/dhry/cmd_dhry.c
index 77b52a23003c..e52beaeaadc7 100644
--- a/lib/dhry/cmd_dhry.c
+++ b/lib/dhry/cmd_dhry.c
@@ -3,9 +3,10 @@
  * (C) Copyright 2015 Google, Inc
  */
 
-#include <common.h>
 #include <command.h>
 #include <div64.h>
+#include <time.h>
+#include <vsprintf.h>
 #include "dhry.h"
 
 static int do_dhry(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/lib/dhry/dhry_1.c b/lib/dhry/dhry_1.c
index dcc224fb387d..252cd14a656e 100644
--- a/lib/dhry/dhry_1.c
+++ b/lib/dhry/dhry_1.c
@@ -42,8 +42,8 @@
  ***************************************************************************/
 char SCCSid[] = "@(#) @(#)dhry_1.c:3.4 -- 5/15/91 19:30:21";
 
-#include <common.h>
 #include <malloc.h>
+#include <stdio.h>
 
 #include "dhry.h"
 
diff --git a/lib/dhry/dhry_2.c b/lib/dhry/dhry_2.c
index 1ba879673e30..a74197d884de 100644
--- a/lib/dhry/dhry_2.c
+++ b/lib/dhry/dhry_2.c
@@ -39,7 +39,7 @@
  ****************************************************************************/
 /* SCCSid is defined in dhry_1.c */
 
-#include <common.h>
+#include <linux/string.h>
 #include "dhry.h"
 
 #ifndef REG
diff --git a/lib/efi/efi.c b/lib/efi/efi.c
index aa42f1842f33..bcb34d67465d 100644
--- a/lib/efi/efi.c
+++ b/lib/efi/efi.c
@@ -10,7 +10,6 @@
  * Common EFI functions
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <errno.h>
 #include <malloc.h>
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 2209410f35b5..a5ffa53b5a4e 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -8,7 +8,6 @@
  * This file implements U-Boot running as an EFI application.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index 4d78923c4d40..5b564c5651d5 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -5,7 +5,6 @@
  * Access to the EFI information table
  */
 
-#include <common.h>
 #include <efi.h>
 #include <errno.h>
 #include <mapmem.h>
diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
index c9eb32ec1046..40fc29d9adf7 100644
--- a/lib/efi/efi_stub.c
+++ b/lib/efi/efi_stub.c
@@ -9,7 +9,6 @@
  * EFI application. It can be built either in 32-bit or 64-bit mode.
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <efi.h>
 #include <efi_api.h>
diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index e3abd90275c8..34a0365739d7 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -28,7 +28,6 @@
  * iPXE uses the simple file protocol to load Grub or the Linux Kernel.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <efi_driver.h>
diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index 66a45e156d60..e1e28df20b2c 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -17,7 +17,6 @@
  * controllers.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <efi_driver.h>
 #include <log.h>
diff --git a/lib/efi_selftest/efi_selftest_esrt.c b/lib/efi_selftest/efi_selftest_esrt.c
index 922ff253c72c..b7688deb4964 100644
--- a/lib/efi_selftest/efi_selftest_esrt.c
+++ b/lib/efi_selftest/efi_selftest_esrt.c
@@ -4,7 +4,6 @@
  *
  *  Copyright (C) 2021 Arm Ltd.
  */
-#include <common.h>
 #include <efi_loader.h>
 #include <efi_selftest.h>
 
diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
index a9ad381001f9..f668cdac4ab2 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
@@ -7,7 +7,6 @@
  * This EFI application triggers an exception.
  */
 
-#include <common.h>
 #include <efi_api.h>
 #include <host_arch.h>
 
diff --git a/lib/efi_selftest/efi_selftest_miniapp_exit.c b/lib/efi_selftest/efi_selftest_miniapp_exit.c
index 1c42d6dd400f..8b2e60cc7114 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exit.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exit.c
@@ -8,7 +8,6 @@
  * It uses the Exit boot service to return.
  */
 
-#include <common.h>
 #include <efi_selftest.h>
 
 static efi_guid_t loaded_image_protocol_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
diff --git a/lib/efi_selftest/efi_selftest_miniapp_return.c b/lib/efi_selftest/efi_selftest_miniapp_return.c
index 45366aa9c638..8792d78ab30f 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_return.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_return.c
@@ -8,7 +8,6 @@
  * It returns directly without calling the Exit boot service.
  */
 
-#include <common.h>
 #include <efi_api.h>
 
 /*
diff --git a/lib/elf.c b/lib/elf.c
index 0476b2614c33..9a794f9cba89 100644
--- a/lib/elf.c
+++ b/lib/elf.c
@@ -3,7 +3,6 @@
    Copyright (c) 2001 William L. Pitts
 */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <elf.h>
diff --git a/lib/errno_str.c b/lib/errno_str.c
index 2e5f4a887d5b..752d4eb47aa6 100644
--- a/lib/errno_str.c
+++ b/lib/errno_str.c
@@ -4,8 +4,8 @@
  *
  * SDPX-License-Identifier:	GPL-2.0+
  */
-#include <common.h>
 #include <errno.h>
+#include <linux/kernel.h>
 
 #define ERRNO_MSG(errno, msg)	msg
 #define SAME_AS(x)		(const char *)&errno_message[x]
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 7a6916764835..4016bf3c1130 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -7,7 +7,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
diff --git a/lib/fdtdec_common.c b/lib/fdtdec_common.c
index ddaca0087e19..ca36ff15952b 100644
--- a/lib/fdtdec_common.c
+++ b/lib/fdtdec_common.c
@@ -8,7 +8,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <fdtdec.h>
diff --git a/lib/fdtdec_test.c b/lib/fdtdec_test.c
index 85351c75ca29..1e4d5fc83264 100644
--- a/lib/fdtdec_test.c
+++ b/lib/fdtdec_test.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <command.h>
 #include <fdtdec.h>
 #include <linux/libfdt.h>
diff --git a/lib/getopt.c b/lib/getopt.c
index 8b4515dc1967..e9175e2fff49 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -8,9 +8,9 @@
 
 #define LOG_CATEGORY LOGC_CORE
 
-#include <common.h>
 #include <getopt.h>
 #include <log.h>
+#include <linux/string.h>
 
 void getopt_init_state(struct getopt_state *gs)
 {
diff --git a/lib/gunzip.c b/lib/gunzip.c
index 932e3e8036d1..e71d8d00ccb5 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <console.h>
diff --git a/lib/gzip.c b/lib/gzip.c
index 2595b2d04b42..5d9c19598d5e 100644
--- a/lib/gzip.c
+++ b/lib/gzip.c
@@ -4,7 +4,6 @@
  * Lei Wen <leiwen@marvell.com>, Marvell Inc.
  */
 
-#include <common.h>
 #include <watchdog.h>
 #include <command.h>
 #include <gzip.h>
diff --git a/lib/hang.c b/lib/hang.c
index 2735774f9a40..3cfb06e9ca8d 100644
--- a/lib/hang.c
+++ b/lib/hang.c
@@ -7,9 +7,9 @@
  * u-boot.
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <hang.h>
+#include <stdio.h>
 #include <os.h>
 
 /**
diff --git a/lib/hash-checksum.c b/lib/hash-checksum.c
index 68c290d64d86..1970a741294d 100644
--- a/lib/hash-checksum.c
+++ b/lib/hash-checksum.c
@@ -4,7 +4,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <fdtdec.h>
 #include <asm/byteorder.h>
 #include <linux/errno.h>
diff --git a/lib/hashtable.c b/lib/hashtable.c
index f2d36bd34b4c..a0060f6a0d63 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -30,7 +30,6 @@
 #  endif
 # endif
 #else				/* U-Boot build */
-# include <common.h>
 # include <linux/string.h>
 # include <linux/ctype.h>
 #endif
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 149c93ead8b8..33e3e6e51824 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -8,9 +8,9 @@
  * more details.
  */
 
-#include <common.h>
 #include <hexdump.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 #include <linux/ctype.h>
 #include <linux/compat.h>
 #include <linux/log2.h>
diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 323aad981c64..f82890646920 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -35,7 +35,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <blk.h>
 #include <image-sparse.h>
 #include <div64.h>
diff --git a/lib/initcall.c b/lib/initcall.c
index 33b7d761dc7e..ce317af213ab 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <efi.h>
 #include <initcall.h>
 #include <log.h>
diff --git a/lib/linux_compat.c b/lib/linux_compat.c
index c83426f59dc2..985e88eb3976 100644
--- a/lib/linux_compat.c
+++ b/lib/linux_compat.c
@@ -1,5 +1,4 @@
 
-#include <common.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <asm/cache.h>
diff --git a/lib/list_sort.c b/lib/list_sort.c
index 1c9e06173270..a6e54d5bc46e 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -6,7 +6,6 @@
 #include <linux/slab.h>
 #else
 #include <linux/compat.h>
-#include <common.h>
 #include <malloc.h>
 #include <linux/printk.h>
 #endif
diff --git a/lib/lmb.c b/lib/lmb.c
index da924c6789ac..44f982053101 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2001 Peter Bergner.
  */
 
-#include <common.h>
 #include <efi_loader.h>
 #include <image.h>
 #include <mapmem.h>
diff --git a/lib/lz4.c b/lib/lz4.c
index 5337842126c8..d365dc727cfd 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -27,7 +27,6 @@
  *	- LZ4 homepage : http://www.lz4.org
  *	- LZ4 source repository : https://github.com/lz4/lz4
  */
-#include <common.h>
 #include <compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/lib/lz4_wrapper.c b/lib/lz4_wrapper.c
index 67dea2ff3904..4d48e7b0e8bf 100644
--- a/lib/lz4_wrapper.c
+++ b/lib/lz4_wrapper.c
@@ -3,7 +3,6 @@
  * Copyright 2015 Google Inc.
  */
 
-#include <common.h>
 #include <compiler.h>
 #include <image.h>
 #include <linux/kernel.h>
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index a90b35c6a993..1da3f0a14a7d 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -2,7 +2,6 @@
 2009-09-20 : Igor Pavlov : Public domain */
 
 #include <config.h>
-#include <common.h>
 #include <watchdog.h>
 #include "LzmaDec.h"
 
diff --git a/lib/lzma/LzmaTools.c b/lib/lzma/LzmaTools.c
index 55f64cd28908..400d606784ea 100644
--- a/lib/lzma/LzmaTools.c
+++ b/lib/lzma/LzmaTools.c
@@ -18,7 +18,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <watchdog.h>
 
diff --git a/lib/lzo/lzo1x_decompress.c b/lib/lzo/lzo1x_decompress.c
index 65fef0b0eb90..5d70fa413379 100644
--- a/lib/lzo/lzo1x_decompress.c
+++ b/lib/lzo/lzo1x_decompress.c
@@ -11,8 +11,9 @@
  *  Richard Purdie <rpurdie@openedhand.com>
  */
 
-#include <common.h>
+#include <linux/kernel.h>
 #include <linux/lzo.h>
+#include <linux/string.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 #include "lzodefs.h"
diff --git a/lib/md5.c b/lib/md5.c
index 1636ab936619..faf3f78ab1ed 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -28,7 +28,6 @@
 #include "compiler.h"
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <watchdog.h>
 #endif /* USE_HOSTCC */
 #include <u-boot/md5.h>
diff --git a/lib/membuff.c b/lib/membuff.c
index 36dc43a523fb..3c6c0ae125c4 100644
--- a/lib/membuff.c
+++ b/lib/membuff.c
@@ -6,7 +6,6 @@
  * Copyright (c) 1992 Simon Glass
  */
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 4283c13a31d9..c70fef0d991b 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -9,9 +9,9 @@
  * Copyright 2009 Dirk Behme, dirk.behme@googlemail.com
  */
 
-#include <common.h>
 #include <net.h>
 #include <net6.h>
+#include <vsprintf.h>
 
 struct in_addr string_to_ip(const char *s)
 {
diff --git a/lib/of_live.c b/lib/of_live.c
index 812c488f6067..90b9459ede31 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY	LOGC_DT
 
-#include <common.h>
 #include <abuf.h>
 #include <log.h>
 #include <linux/libfdt.h>
diff --git a/lib/optee/optee.c b/lib/optee/optee.c
index b03622404469..393f2715a9c1 100644
--- a/lib/optee/optee.c
+++ b/lib/optee/optee.c
@@ -4,7 +4,6 @@
  * Bryan O'Donoghue <bryan.odonoghue@linaro.org>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <image.h>
 #include <log.h>
diff --git a/lib/panic.c b/lib/panic.c
index 66ae17f3df99..0f578b5b5131 100644
--- a/lib/panic.c
+++ b/lib/panic.c
@@ -9,7 +9,6 @@
  * Wirzenius wrote this portably, Torvalds fucked it up :-)
  */
 
-#include <common.h>
 #include <hang.h>
 #if !defined(CONFIG_PANIC_HANG)
 #include <command.h>
diff --git a/lib/physmem.c b/lib/physmem.c
index fc90ce4d7cfd..562c74d37f31 100644
--- a/lib/physmem.c
+++ b/lib/physmem.c
@@ -8,11 +8,11 @@
  * Software Foundation.
  */
 
-#include <common.h>
 #include <log.h>
 #include <mapmem.h>
 #include <physmem.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 phys_addr_t __weak arch_phys_memset(phys_addr_t s, int c, phys_size_t n)
 {
diff --git a/lib/qsort.c b/lib/qsort.c
index 2f18588dfccd..a2562c4942ea 100644
--- a/lib/qsort.c
+++ b/lib/qsort.c
@@ -17,7 +17,6 @@
 
 #include <log.h>
 #include <linux/types.h>
-#include <common.h>
 #include <exports.h>
 #include <sort.h>
 
diff --git a/lib/rand.c b/lib/rand.c
index d256baf5cee7..d6f2977e8dcc 100644
--- a/lib/rand.c
+++ b/lib/rand.c
@@ -7,7 +7,6 @@
  * Michael Walle <michael@walle.cc>
  */
 
-#include <common.h>
 #include <rand.h>
 
 static unsigned int y = 1U;
diff --git a/lib/rc4.c b/lib/rc4.c
index 720112d1fd8e..3839924a2b2c 100644
--- a/lib/rc4.c
+++ b/lib/rc4.c
@@ -7,9 +7,6 @@
  * Rivest Cipher 4 (RC4) implementation
  */
 
-#ifndef USE_HOSTCC
-#include <common.h>
-#endif
 #include <rc4.h>
 
 void rc4_encode(unsigned char *buf, unsigned int len, const unsigned char key[16])
diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index 98855f67b890..80d0594a4303 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2016 Thomas Pornin <pornin@bolet.org>
  */
 
-#include <common.h>
 #include <image.h>
 #include <malloc.h>
 #include <crypto/internal/rsa.h>
diff --git a/lib/rsa/rsa-mod-exp.c b/lib/rsa/rsa-mod-exp.c
index d259b2aedf27..5b3ea02f82f8 100644
--- a/lib/rsa/rsa-mod-exp.c
+++ b/lib/rsa/rsa-mod-exp.c
@@ -4,7 +4,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/types.h>
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 2f3b34403913..e194e5433138 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -4,7 +4,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/rtc-lib.c b/lib/rtc-lib.c
index 1f7bdade298a..46dcfba27157 100644
--- a/lib/rtc-lib.c
+++ b/lib/rtc-lib.c
@@ -10,7 +10,6 @@
  * - January is month 1.
  */
 
-#include <common.h>
 #include <rtc.h>
 #include <linux/math64.h>
 
diff --git a/lib/semihosting.c b/lib/semihosting.c
index 831774e35664..9be5bffd3012 100644
--- a/lib/semihosting.c
+++ b/lib/semihosting.c
@@ -4,9 +4,10 @@
  * Copyright 2014 Broadcom Corporation
  */
 
-#include <common.h>
 #include <log.h>
 #include <semihosting.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 
 #define SYSOPEN		0x01
 #define SYSCLOSE	0x02
diff --git a/lib/slre.c b/lib/slre.c
index e1a50443e046..277a59a03a71 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -21,8 +21,8 @@
 #include <string.h>
 #else
 #include <log.h>
-#include <common.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #endif /* SLRE_TEST */
 
 #include <errno.h>
diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index 2b9392936b99..b578c3084081 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
-#include <common.h>
 #include <smbios.h>
 
 static inline int verify_checksum(const struct smbios_entry *e)
diff --git a/lib/smbios.c b/lib/smbios.c
index d7f4999e8b2a..807a021770cb 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -5,7 +5,6 @@
  * Adapted from coreboot src/arch/x86/smbios.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <linux/stringify.h>
diff --git a/lib/strto.c b/lib/strto.c
index 154921165cb2..5157332d6c1d 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -9,9 +9,9 @@
  * Wirzenius wrote this portably, Torvalds fucked it up :-)
  */
 
-#include <common.h>
 #include <errno.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <linux/ctype.h>
 
 /* from lib/kstrtox.c */
diff --git a/lib/tables_csum.c b/lib/tables_csum.c
index e2630d57d912..636aa5967681 100644
--- a/lib/tables_csum.c
+++ b/lib/tables_csum.c
@@ -3,8 +3,7 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
-#include <linux/ctype.h>
+#include <linux/types.h>
 
 u8 table_compute_checksum(void *v, int len)
 {
diff --git a/lib/time.c b/lib/time.c
index 00f4a1ac8fb3..872f73d521e1 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index f661fc65054a..9a70c6095b31 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2004,2008  Kustaa Nyholm
  */
 
-#include <common.h>
 #include <log.h>
 #include <serial.h>
 #include <stdarg.h>
diff --git a/lib/tpm-common.c b/lib/tpm-common.c
index 82ffdc5341bc..b592c22bfc13 100644
--- a/lib/tpm-common.c
+++ b/lib/tpm-common.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_TPM
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/unaligned.h>
diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
index 60a18ca50400..e66023da5e67 100644
--- a/lib/tpm-v1.c
+++ b/lib/tpm-v1.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_TPM
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/unaligned.h>
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index bd0fb078dc3c..68eaaa639f89 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -5,7 +5,6 @@
  * Author: Miquel Raynal <miquel.raynal@bootlin.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/of_access.h>
 #include <tpm_api.h>
diff --git a/lib/tpm_api.c b/lib/tpm_api.c
index 3ef5e811794f..39a5121e3028 100644
--- a/lib/tpm_api.c
+++ b/lib/tpm_api.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <tpm_api.h>
diff --git a/lib/trace.c b/lib/trace.c
index 4874bef861bf..cabbe47b58a3 100644
--- a/lib/trace.c
+++ b/lib/trace.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2012 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <mapmem.h>
 #include <time.h>
 #include <trace.h>
+#include <linux/errno.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/sections.h>
diff --git a/lib/uuid.c b/lib/uuid.c
index afb40bff507a..0be22bc05f78 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGOT LOGC_CORE
 
-#include <common.h>
 #include <command.h>
 #include <efi_api.h>
 #include <env.h>
@@ -18,7 +17,6 @@
 #include <uuid.h>
 #include <linux/ctype.h>
 #include <errno.h>
-#include <common.h>
 #include <asm/io.h>
 #include <part_efi.h>
 #include <malloc.h>
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e14c6ca9f966..27ea9c907a32 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -13,7 +13,6 @@
  * from hush: simple_itoa() was lifted from boa-0.93.15
  */
 
-#include <common.h>
 #include <charset.h>
 #include <efi_loader.h>
 #include <div64.h>
diff --git a/lib/zstd/zstd.c b/lib/zstd/zstd.c
index 3a2abc836734..14bde369068d 100644
--- a/lib/zstd/zstd.c
+++ b/lib/zstd/zstd.c
@@ -5,10 +5,10 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
-#include <common.h>
 #include <abuf.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/errno.h>
 #include <linux/zstd.h>
 
 int zstd_decompress(struct abuf *in, struct abuf *out)
-- 
2.34.1

