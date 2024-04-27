Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6C6C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A12885AE;
	Sat, 27 Apr 2024 16:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GxL1i2Z9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3099F88429; Sat, 27 Apr 2024 16:11:31 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DA888411
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6eb658ca1ceso2241540a34.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227085; x=1714831885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5DboGBfuS01UXg3UCH81OlEuerv0vL3uyI2r2NiVlhU=;
 b=GxL1i2Z9Xt+lFHHeVl+rlHhqwy5P2UOqtLq3EbJhLP/H86AOKUU7FUmXthDGUttTnV
 8vSeIpCvOBMctdqC1SHUnfJ6NMJ3wvMrYN5F8wLq5+ExpeIfZaTMO5v1ngsgV8ZMbUm9
 b0M6+fQUV2varQKfwHrQysqAlJAkm5IlkN+LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227085; x=1714831885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DboGBfuS01UXg3UCH81OlEuerv0vL3uyI2r2NiVlhU=;
 b=n8Xepy/uYskXYxfxqtLIKH3xAzYRqn/9ZUjEFYFH0vbuvOOgGXDUNIvA/Z+SW6EG2L
 0v6yevyaO0F7tiydrPO2Hjpa9YDMNh/0bqWVz78AmXpIItMsfDP/1EjCl/8TZmG3w8Mr
 G86nzKojvqz1Yj8JS3O33Lxe5dfc+veznMAnj3QhivdskupSeOYUcgQ8iNZPQueZjDsS
 cQ7G5+23WA17Og1Ln9pgfd5DmssDYdRQ9mxoBtGjV47i/s0w0/qQzPwFKlN8QWjN0pUo
 fh7WSRJuZq3jiAGy3TRv4MmxJKxeD4hfuE1rVTNiSm2hgCQ3WRdhtrUrhM+BrnRyn7B8
 BvXQ==
X-Gm-Message-State: AOJu0YxfO+MvQqkMHF6RjTJPU4qbANwethWAcd10W8C/7IKGBteN7xsE
 fcv3jkvaQLInJ4ei1f9jGgTGxKf8yTk2zuxG1RliAMvJgb0VcaM2DCz7BRzfQdNOHvuI6NqIyft
 cE53rwg==
X-Google-Smtp-Source: AGHT+IEVcCOUb7x1abLdjskPHcsHhByIqoX2nvPFAXn1+pD8UrM7J9gBn0lrLn7PwLwASl4o+/IJmg==
X-Received: by 2002:a9d:7e85:0:b0:6ed:f048:dae1 with SMTP id
 m5-20020a9d7e85000000b006edf048dae1mr2386135otp.17.1714227083820; 
 Sat, 27 Apr 2024 07:11:23 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 11/18] cmd: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:59 -0600
Message-Id: <20240427141106.3406000-12-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove <common.h> from all "cmd/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/2048.c                      | 2 +-
 cmd/ab_select.c                 | 1 -
 cmd/abootimg.c                  | 1 -
 cmd/acpi.c                      | 2 +-
 cmd/adc.c                       | 1 -
 cmd/addrmap.c                   | 1 -
 cmd/adtimg.c                    | 2 +-
 cmd/aes.c                       | 2 +-
 cmd/arm/exception64.c           | 1 -
 cmd/armffa.c                    | 1 -
 cmd/armflash.c                  | 2 +-
 cmd/axi.c                       | 1 -
 cmd/bcb.c                       | 2 +-
 cmd/bdinfo.c                    | 1 -
 cmd/bind.c                      | 1 -
 cmd/binop.c                     | 2 +-
 cmd/blk_common.c                | 2 +-
 cmd/blkcache.c                  | 2 +-
 cmd/blkmap.c                    | 1 -
 cmd/blob.c                      | 2 +-
 cmd/bloblist.c                  | 1 -
 cmd/bmp.c                       | 1 -
 cmd/boot.c                      | 2 +-
 cmd/bootcount.c                 | 1 -
 cmd/bootdev.c                   | 1 -
 cmd/bootflow.c                  | 1 -
 cmd/booti.c                     | 1 -
 cmd/bootm.c                     | 1 -
 cmd/bootmenu.c                  | 1 -
 cmd/bootmeth.c                  | 1 -
 cmd/bootstage.c                 | 2 +-
 cmd/bootz.c                     | 1 -
 cmd/broadcom/chimp_boot.c       | 1 -
 cmd/broadcom/chimp_handshake.c  | 1 -
 cmd/broadcom/nitro_image_load.c | 2 +-
 cmd/btrfs.c                     | 1 -
 cmd/button.c                    | 1 -
 cmd/cache.c                     | 1 -
 cmd/cat.c                       | 1 -
 cmd/cbfs.c                      | 2 +-
 cmd/cedit.c                     | 1 -
 cmd/clk.c                       | 1 -
 cmd/clone.c                     | 2 +-
 cmd/cls.c                       | 1 -
 cmd/config.c                    | 1 -
 cmd/conitrace.c                 | 1 -
 cmd/console.c                   | 1 -
 cmd/cpu.c                       | 1 -
 cmd/cramfs.c                    | 1 -
 cmd/cros_ec.c                   | 1 -
 cmd/cyclic.c                    | 3 ++-
 cmd/date.c                      | 1 -
 cmd/demo.c                      | 1 -
 cmd/dfu.c                       | 1 -
 cmd/diag.c                      | 1 -
 cmd/disk.c                      | 1 -
 cmd/dm.c                        | 1 -
 cmd/echo.c                      | 1 -
 cmd/eeprom.c                    | 2 +-
 cmd/efi.c                       | 1 -
 cmd/efi_common.c                | 1 -
 cmd/eficonfig.c                 | 1 -
 cmd/eficonfig_sbkey.c           | 1 -
 cmd/efidebug.c                  | 1 -
 cmd/elf.c                       | 1 -
 cmd/ethsw.c                     | 2 +-
 cmd/event.c                     | 1 -
 cmd/exit.c                      | 2 +-
 cmd/ext2.c                      | 1 -
 cmd/ext4.c                      | 1 -
 cmd/extension_board.c           | 1 -
 cmd/fastboot.c                  | 1 -
 cmd/fat.c                       | 1 -
 cmd/fdt.c                       | 1 -
 cmd/flash.c                     | 2 +-
 cmd/font.c                      | 1 -
 cmd/fpga.c                      | 1 -
 cmd/fpgad.c                     | 2 +-
 cmd/fs.c                        | 1 -
 cmd/fs_uuid.c                   | 1 -
 cmd/fuse.c                      | 2 +-
 cmd/gettime.c                   | 2 +-
 cmd/gpio.c                      | 1 -
 cmd/gpt.c                       | 1 -
 cmd/hash.c                      | 1 -
 cmd/help.c                      | 1 -
 cmd/history.c                   | 1 -
 cmd/host.c                      | 1 -
 cmd/i2c.c                       | 1 -
 cmd/ide.c                       | 1 -
 cmd/ini.c                       | 2 +-
 cmd/io.c                        | 2 +-
 cmd/iotrace.c                   | 2 +-
 cmd/irq.c                       | 1 -
 cmd/itest.c                     | 2 +-
 cmd/jffs2.c                     | 1 -
 cmd/kaslrseed.c                 | 1 -
 cmd/led.c                       | 1 -
 cmd/legacy-mtd-utils.c          | 1 -
 cmd/legacy_led.c                | 3 +--
 cmd/license.c                   | 1 -
 cmd/load.c                      | 1 -
 cmd/log.c                       | 1 -
 cmd/lsblk.c                     | 1 -
 cmd/lzmadec.c                   | 2 +-
 cmd/mbr.c                       | 2 +-
 cmd/mdio.c                      | 1 -
 cmd/mem.c                       | 2 +-
 cmd/meson/sm.c                  | 2 +-
 cmd/mii.c                       | 1 -
 cmd/misc.c                      | 1 -
 cmd/mmc.c                       | 2 +-
 cmd/mp.c                        | 2 +-
 cmd/mtd.c                       | 1 -
 cmd/mtdparts.c                  | 1 -
 cmd/mux.c                       | 1 -
 cmd/mvebu/bubt.c                | 1 -
 cmd/mvebu/comphy_rx_training.c  | 1 -
 cmd/nand.c                      | 1 -
 cmd/net.c                       | 1 -
 cmd/nvedit.c                    | 2 +-
 cmd/nvedit_efi.c                | 1 -
 cmd/nvme.c                      | 1 -
 cmd/onenand.c                   | 1 -
 cmd/optee_rpmb.c                | 1 -
 cmd/osd.c                       | 1 -
 cmd/panic.c                     | 2 +-
 cmd/part.c                      | 1 -
 cmd/pcap.c                      | 2 +-
 cmd/pci.c                       | 1 -
 cmd/pci_mps.c                   | 1 -
 cmd/pinmux.c                    | 1 -
 cmd/pmc.c                       | 1 -
 cmd/pmic.c                      | 1 -
 cmd/printf.c                    | 2 +-
 cmd/pvblock.c                   | 1 -
 cmd/pxe.c                       | 2 +-
 cmd/qfw.c                       | 1 -
 cmd/read.c                      | 2 +-
 cmd/reginfo.c                   | 1 -
 cmd/regulator.c                 | 1 -
 cmd/remoteproc.c                | 1 -
 cmd/riscv/sbi.c                 | 1 -
 cmd/rkmtd.c                     | 1 -
 cmd/rng.c                       | 1 -
 cmd/rockusb.c                   | 1 -
 cmd/rtc.c                       | 1 -
 cmd/sata.c                      | 1 -
 cmd/sb.c                        | 1 -
 cmd/scp03.c                     | 1 -
 cmd/scsi.c                      | 1 -
 cmd/seama.c                     | 1 -
 cmd/setexpr.c                   | 3 ++-
 cmd/sf.c                        | 2 +-
 cmd/sha1sum.c                   | 1 -
 cmd/sleep.c                     | 3 ++-
 cmd/smccc.c                     | 2 +-
 cmd/sound.c                     | 1 -
 cmd/source.c                    | 1 -
 cmd/spi.c                       | 1 -
 cmd/spl.c                       | 1 -
 cmd/stackprot_test.c            | 1 -
 cmd/strings.c                   | 2 +-
 cmd/sysboot.c                   | 2 +-
 cmd/temperature.c               | 1 -
 cmd/terminal.c                  | 1 -
 cmd/test.c                      | 2 +-
 cmd/thordown.c                  | 1 -
 cmd/ti/ddr3.c                   | 1 -
 cmd/ti/pd.c                     | 1 -
 cmd/time.c                      | 1 -
 cmd/timer.c                     | 2 +-
 cmd/tlv_eeprom.c                | 1 -
 cmd/tpm-common.c                | 1 -
 cmd/tpm-v1.c                    | 2 +-
 cmd/tpm-v2.c                    | 1 -
 cmd/tpm_test.c                  | 2 +-
 cmd/trace.c                     | 2 +-
 cmd/tsi148.c                    | 2 +-
 cmd/ubi.c                       | 1 -
 cmd/ubifs.c                     | 2 +-
 cmd/ufs.c                       | 2 +-
 cmd/universe.c                  | 2 +-
 cmd/unlz4.c                     | 2 +-
 cmd/unzip.c                     | 2 +-
 cmd/usb.c                       | 1 -
 cmd/usb_gadget_sdp.c            | 1 -
 cmd/usb_mass_storage.c          | 1 -
 cmd/vbe.c                       | 1 -
 cmd/version.c                   | 1 -
 cmd/video.c                     | 1 -
 cmd/virtio.c                    | 1 -
 cmd/w1.c                        | 1 -
 cmd/wdt.c                       | 1 -
 cmd/wol.c                       | 2 +-
 cmd/x86/cbsysinfo.c             | 1 -
 cmd/x86/fsp.c                   | 1 -
 cmd/x86/hob.c                   | 1 -
 cmd/x86/mtrr.c                  | 2 +-
 cmd/ximg.c                      | 1 -
 cmd/xxd.c                       | 1 -
 cmd/yaffs2.c                    | 1 -
 cmd/zfs.c                       | 1 -
 cmd/zip.c                       | 2 +-
 include/android_ab.h            | 2 ++
 205 files changed, 65 insertions(+), 205 deletions(-)

diff --git a/cmd/2048.c b/cmd/2048.c
index fa60aa94aad8..42cd171b0e41 100644
--- a/cmd/2048.c
+++ b/cmd/2048.c
@@ -3,10 +3,10 @@
 
 /* Console version of the game "2048" for GNU/Linux */
 
-#include <common.h>
 #include <cli.h>
 #include <command.h>
 #include <rand.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
 
 #define SIZE 4
diff --git a/cmd/ab_select.c b/cmd/ab_select.c
index bfb67b8236b6..faeb83816e58 100644
--- a/cmd/ab_select.c
+++ b/cmd/ab_select.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 The Android Open Source Project
  */
 
-#include <common.h>
 #include <android_ab.h>
 #include <command.h>
 #include <env.h>
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 2653b555b10a..88c77d999290 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -5,7 +5,6 @@
  */
 
 #include <android_image.h>
-#include <common.h>
 #include <command.h>
 #include <image.h>
 #include <mapmem.h>
diff --git a/cmd/acpi.c b/cmd/acpi.c
index 928e5dc525e6..094d9d4e8586 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Google LLC
  * Written by Simon Glass <sjg@chromium.org>
  */
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <log.h>
@@ -11,6 +10,7 @@
 #include <acpi/acpi_table.h>
 #include <asm/acpi_table.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 #include <dm/acpi.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/cmd/adc.c b/cmd/adc.c
index 4cb18b66d4aa..f87f9785a114 100644
--- a/cmd/adc.c
+++ b/cmd/adc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 BayLibre, SAS
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <adc.h>
diff --git a/cmd/addrmap.c b/cmd/addrmap.c
index bd23549f3a5f..f7e4d9206de5 100644
--- a/cmd/addrmap.c
+++ b/cmd/addrmap.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <addr_map.h>
 
diff --git a/cmd/adtimg.c b/cmd/adtimg.c
index f4b5cbf35b97..53f33764fbe8 100644
--- a/cmd/adtimg.c
+++ b/cmd/adtimg.c
@@ -7,8 +7,8 @@
 
 #include <command.h>
 #include <env.h>
+#include <vsprintf.h>
 #include <image-android-dt.h>
-#include <common.h>
 
 #define OPT_INDEX	"--index"
 
diff --git a/cmd/aes.c b/cmd/aes.c
index 1264675aa01f..87ad1ab82b99 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -5,13 +5,13 @@
  * Command for en/de-crypting block of memory with AES-[128/192/256]-CBC cipher.
  */
 
-#include <common.h>
 #include <command.h>
 #include <uboot_aes.h>
 #include <malloc.h>
 #include <asm/byteorder.h>
 #include <linux/compiler.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 
 u32 aes_get_key_len(char *command)
 {
diff --git a/cmd/arm/exception64.c b/cmd/arm/exception64.c
index 589a23115b04..73d6c20ccace 100644
--- a/cmd/arm/exception64.c
+++ b/cmd/arm/exception64.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <linux/bitops.h>
 
diff --git a/cmd/armffa.c b/cmd/armffa.c
index 9585150b9627..181e31bc49ad 100644
--- a/cmd/armffa.c
+++ b/cmd/armffa.c
@@ -5,7 +5,6 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
-#include <common.h>
 #include <arm_ffa.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/armflash.c b/cmd/armflash.c
index fdaea5ad811d..e292cf85c45d 100644
--- a/cmd/armflash.c
+++ b/cmd/armflash.c
@@ -5,10 +5,10 @@
  *
  * Support for ARM Flash Partitions
  */
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <flash.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 
 #define MAX_REGIONS 4
diff --git a/cmd/axi.c b/cmd/axi.c
index 5620891db28b..3dbea0499dee 100644
--- a/cmd/axi.c
+++ b/cmd/axi.c
@@ -9,7 +9,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <axi.h>
 #include <command.h>
 #include <console.h>
diff --git a/cmd/bcb.c b/cmd/bcb.c
index f3b92564d10b..fe6d6cb2c381 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -8,12 +8,12 @@
 #include <android_bootloader_message.h>
 #include <bcb.h>
 #include <command.h>
-#include <common.h>
 #include <display_options.h>
 #include <log.h>
 #include <part.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <vsprintf.h>
 #include <linux/err.h>
 
 enum bcb_cmd {
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 79106caeec2e..437ac4e86309 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -6,7 +6,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/cmd/bind.c b/cmd/bind.c
index be0d4d2a7115..3a59eefd5c58 100644
--- a/cmd/bind.c
+++ b/cmd/bind.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 JJ Hiblot <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/cmd/binop.c b/cmd/binop.c
index 592e9146901b..10d91b5dbf2e 100644
--- a/cmd/binop.c
+++ b/cmd/binop.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <hexdump.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 #include <linux/ctype.h>
 
 enum {
diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 02ac92837b6c..4c05a4e0610e 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -8,10 +8,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 
 int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 		   int *cur_devnump)
diff --git a/cmd/blkcache.c b/cmd/blkcache.c
index 1456654df6f5..dbd03df14dcf 100644
--- a/cmd/blkcache.c
+++ b/cmd/blkcache.c
@@ -6,9 +6,9 @@
  */
 #include <command.h>
 #include <config.h>
-#include <common.h>
 #include <malloc.h>
 #include <part.h>
+#include <vsprintf.h>
 
 static int blkc_show(struct cmd_tbl *cmdtp, int flag,
 		     int argc, char *const argv[])
diff --git a/cmd/blkmap.c b/cmd/blkmap.c
index ef74ebc0036c..164f80f1387d 100644
--- a/cmd/blkmap.c
+++ b/cmd/blkmap.c
@@ -6,7 +6,6 @@
 
 #include <blk.h>
 #include <blkmap.h>
-#include <common.h>
 #include <command.h>
 #include <malloc.h>
 #include <dm/device.h>
diff --git a/cmd/blob.c b/cmd/blob.c
index 7c77c410d528..a3c1dc49224d 100644
--- a/cmd/blob.c
+++ b/cmd/blob.c
@@ -4,9 +4,9 @@
  * Command for encapsulating/decapsulating blob of memory.
  */
 
-#include <common.h>
 #include <command.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <asm/byteorder.h>
 #include <linux/compiler.h>
 #if defined(CONFIG_ARCH_MX6) || defined(CONFIG_ARCH_MX7) || \
diff --git a/cmd/bloblist.c b/cmd/bloblist.c
index 26548ecf847e..333ae558142c 100644
--- a/cmd/bloblist.c
+++ b/cmd/bloblist.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bloblist.h>
 #include <command.h>
 #include <asm/global_data.h>
diff --git a/cmd/bmp.c b/cmd/bmp.c
index 8f43a40dafdd..3b6184486245 100644
--- a/cmd/bmp.c
+++ b/cmd/bmp.c
@@ -8,7 +8,6 @@
  * BMP handling routines
  */
 
-#include <common.h>
 #include <command.h>
 #include <image.h>
 #include <mapmem.h>
diff --git a/cmd/boot.c b/cmd/boot.c
index 14839c1cedcc..23496cafdf5c 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -7,9 +7,9 @@
 /*
  * Misc boot support
  */
-#include <common.h>
 #include <command.h>
 #include <net.h>
+#include <vsprintf.h>
 
 #ifdef CONFIG_CMD_GO
 
diff --git a/cmd/bootcount.c b/cmd/bootcount.c
index 30ce5dba30d9..5e3b66e676b8 100644
--- a/cmd/bootcount.c
+++ b/cmd/bootcount.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <command.h>
 #include <bootcount.h>
 
diff --git a/cmd/bootdev.c b/cmd/bootdev.c
index 471189cda480..fa7285ba25e1 100644
--- a/cmd/bootdev.c
+++ b/cmd/bootdev.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootstd.h>
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index be5d7d8e743a..1588f277a4a0 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootm.h>
diff --git a/cmd/booti.c b/cmd/booti.c
index b9637b3ec3d8..62b19e834366 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <command.h>
 #include <image.h>
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 9737a2d28c03..545b0c3d8235 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -7,7 +7,6 @@
 /*
  * Boot support
  */
-#include <common.h>
 #include <bootm.h>
 #include <command.h>
 #include <env.h>
diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index 78184fccab25..977a04b7d769 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -5,7 +5,6 @@
 
 #include <charset.h>
 #include <cli.h>
-#include <common.h>
 #include <command.h>
 #include <ansi.h>
 #include <efi_config.h>
diff --git a/cmd/bootmeth.c b/cmd/bootmeth.c
index f5b01343c48c..ebf8b7e2530f 100644
--- a/cmd/bootmeth.c
+++ b/cmd/bootmeth.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootmeth.h>
 #include <bootstd.h>
diff --git a/cmd/bootstage.c b/cmd/bootstage.c
index 77a4bc66ff43..5246924f39a4 100644
--- a/cmd/bootstage.c
+++ b/cmd/bootstage.c
@@ -3,9 +3,9 @@
  * Copyright (c) 2012, Google Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
+#include <vsprintf.h>
 
 static int do_bootstage_report(struct cmd_tbl *cmdtp, int flag, int argc,
 			       char *const argv[])
diff --git a/cmd/bootz.c b/cmd/bootz.c
index b6bb4aae72d4..55837a7599b9 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <command.h>
 #include <image.h>
diff --git a/cmd/broadcom/chimp_boot.c b/cmd/broadcom/chimp_boot.c
index 16f2b612c4db..ae0a81179d0a 100644
--- a/cmd/broadcom/chimp_boot.c
+++ b/cmd/broadcom/chimp_boot.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Broadcom
  */
 
-#include <common.h>
 #include <command.h>
 #include <broadcom/chimp.h>
 
diff --git a/cmd/broadcom/chimp_handshake.c b/cmd/broadcom/chimp_handshake.c
index a90a73a6d749..e27426719636 100644
--- a/cmd/broadcom/chimp_handshake.c
+++ b/cmd/broadcom/chimp_handshake.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Broadcom
  */
 
-#include <common.h>
 #include <command.h>
 #include <broadcom/chimp.h>
 
diff --git a/cmd/broadcom/nitro_image_load.c b/cmd/broadcom/nitro_image_load.c
index 93b5cb4cebe6..289b184e9afd 100644
--- a/cmd/broadcom/nitro_image_load.c
+++ b/cmd/broadcom/nitro_image_load.c
@@ -3,8 +3,8 @@
  * Copyright 2020 Broadcom
  */
 
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 
 #define FW_IMAGE_SIG	0xff123456
 #define CFG_IMAGE_SIG	0xcf54321a
diff --git a/cmd/btrfs.c b/cmd/btrfs.c
index 2843835d08b8..69d1b1f830d5 100644
--- a/cmd/btrfs.c
+++ b/cmd/btrfs.c
@@ -3,7 +3,6 @@
  * 2017 by Marek Behún <kabel@kernel.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <btrfs.h>
 #include <fs.h>
diff --git a/cmd/button.c b/cmd/button.c
index 1b45d0a2a035..3e6db3f5b8eb 100644
--- a/cmd/button.c
+++ b/cmd/button.c
@@ -5,7 +5,6 @@
  * Based on led.c
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <button.h>
diff --git a/cmd/cache.c b/cmd/cache.c
index b68d45b98bf2..0254ff17f9b2 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -7,7 +7,6 @@
 /*
  * Cache support: switch on or off, get status
  */
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <linux/compiler.h>
diff --git a/cmd/cat.c b/cmd/cat.c
index 18aa6ca7aa67..6828b7b364e5 100644
--- a/cmd/cat.c
+++ b/cmd/cat.c
@@ -4,7 +4,6 @@
  * Roger Knecht <rknecht@pm.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <fs.h>
 #include <malloc.h>
diff --git a/cmd/cbfs.c b/cmd/cbfs.c
index 3cfc9eb27270..c1035461df15 100644
--- a/cmd/cbfs.c
+++ b/cmd/cbfs.c
@@ -6,10 +6,10 @@
 /*
  * CBFS commands
  */
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <cbfs.h>
+#include <vsprintf.h>
 
 static int do_cbfs_init(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 6352e6369d1e..fec67a8e3349 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <abuf.h>
 #include <cedit.h>
 #include <command.h>
diff --git a/cmd/clk.c b/cmd/clk.c
index 7bbcbfeda332..6fda6efb1cea 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2013 Xilinx, Inc.
  */
-#include <common.h>
 #include <command.h>
 #include <clk.h>
 #if defined(CONFIG_DM) && defined(CONFIG_CLK)
diff --git a/cmd/clone.c b/cmd/clone.c
index a90620775712..1f3cff1836d1 100644
--- a/cmd/clone.c
+++ b/cmd/clone.c
@@ -4,11 +4,11 @@
  *
  */
 
-#include <common.h>
 #include <command.h>
 #include <malloc.h>
 #include <part.h>
 #include <blk.h>
+#include <time.h>
 #include <vsprintf.h>
 
 #define BUFSIZE (1 * 1024 * 1024)
diff --git a/cmd/cls.c b/cmd/cls.c
index 80d0558d4679..4bee8a18305c 100644
--- a/cmd/cls.c
+++ b/cmd/cls.c
@@ -5,7 +5,6 @@
  *
  * cls - clear screen command
  */
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <dm.h>
diff --git a/cmd/config.c b/cmd/config.c
index cf30841a3594..f0d2033c61f4 100644
--- a/cmd/config.c
+++ b/cmd/config.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <gzip.h>
 #include <malloc.h>
diff --git a/cmd/conitrace.c b/cmd/conitrace.c
index 9a1bc3518485..6cc113328ebc 100644
--- a/cmd/conitrace.c
+++ b/cmd/conitrace.c
@@ -5,7 +5,6 @@
  *
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
-#include <common.h>
 #include <command.h>
 #include <linux/delay.h>
 
diff --git a/cmd/console.c b/cmd/console.c
index 58c2cf1c8943..12fc92061a19 100644
--- a/cmd/console.c
+++ b/cmd/console.c
@@ -7,7 +7,6 @@
 /*
  * Boot support
  */
-#include <common.h>
 #include <command.h>
 #include <iomux.h>
 #include <stdio_dev.h>
diff --git a/cmd/cpu.c b/cmd/cpu.c
index 245a82fa3eb4..9e323069b9e8 100644
--- a/cmd/cpu.c
+++ b/cmd/cpu.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu.h>
 #include <display_options.h>
diff --git a/cmd/cramfs.c b/cmd/cramfs.c
index 57e2afa2472b..b57e28159261 100644
--- a/cmd/cramfs.c
+++ b/cmd/cramfs.c
@@ -10,7 +10,6 @@
 /*
  * CRAMFS support
  */
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
diff --git a/cmd/cros_ec.c b/cmd/cros_ec.c
index 90921cecf602..7b60e415b6c9 100644
--- a/cmd/cros_ec.c
+++ b/cmd/cros_ec.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2016 National Instruments Corp
  */
 
-#include <common.h>
 #include <command.h>
 #include <cros_ec.h>
 #include <dm.h>
diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index ad7fc3b975e1..40e966de9aa5 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -8,11 +8,12 @@
  * Copyright (C) 2022 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cyclic.h>
 #include <div64.h>
 #include <malloc.h>
+#include <time.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
 
 struct cyclic_demo_info {
diff --git a/cmd/date.c b/cmd/date.c
index 4f98b470ca2e..755adec1e71e 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -7,7 +7,6 @@
 /*
  * RTC, Date & Time support: get and set date & time
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <rtc.h>
diff --git a/cmd/demo.c b/cmd/demo.c
index ebd5a241c362..5c422ac165bd 100644
--- a/cmd/demo.c
+++ b/cmd/demo.c
@@ -6,7 +6,6 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <dm-demo.h>
diff --git a/cmd/dfu.c b/cmd/dfu.c
index d7bfb535dc68..46f0190588e0 100644
--- a/cmd/dfu.c
+++ b/cmd/dfu.c
@@ -10,7 +10,6 @@
  *	    Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <watchdog.h>
 #include <dfu.h>
diff --git a/cmd/diag.c b/cmd/diag.c
index f51536dbfaaf..c6da5aae3fcd 100644
--- a/cmd/diag.c
+++ b/cmd/diag.c
@@ -7,7 +7,6 @@
 /*
  * Diagnostics support
  */
-#include <common.h>
 #include <command.h>
 #include <post.h>
 
diff --git a/cmd/disk.c b/cmd/disk.c
index 92eaa02f4a13..2efc3ca4b1a2 100644
--- a/cmd/disk.c
+++ b/cmd/disk.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2000-2011
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <cpu_func.h>
diff --git a/cmd/dm.c b/cmd/dm.c
index fb605c2da1a8..ec9cfd85376e 100644
--- a/cmd/dm.c
+++ b/cmd/dm.c
@@ -6,7 +6,6 @@
  * Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm/root.h>
 #include <dm/util.h>
diff --git a/cmd/echo.c b/cmd/echo.c
index fda844ee9d35..973213a03a66 100644
--- a/cmd/echo.c
+++ b/cmd/echo.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 322765ad02a0..26f3750a80ad 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -19,12 +19,12 @@
  *
  */
 
-#include <common.h>
 #include <config.h>
 #include <command.h>
 #include <eeprom.h>
 #include <i2c.h>
 #include <eeprom_layout.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
 
 #ifndef	I2C_RXTX_LEN
diff --git a/cmd/efi.c b/cmd/efi.c
index 6cd5361aca59..6bed2d743ba6 100644
--- a/cmd/efi.c
+++ b/cmd/efi.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <efi.h>
 #include <efi_api.h>
diff --git a/cmd/efi_common.c b/cmd/efi_common.c
index 1aa2351fcdfd..c46764e6eea7 100644
--- a/cmd/efi_common.c
+++ b/cmd/efi_common.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <efi.h>
 #include <efi_api.h>
 #include <uuid.h>
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 0ba92c60e039..4164cb4f9b80 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -7,7 +7,6 @@
 
 #include <ansi.h>
 #include <cli.h>
-#include <common.h>
 #include <charset.h>
 #include <efi_loader.h>
 #include <efi_load_initrd.h>
diff --git a/cmd/eficonfig_sbkey.c b/cmd/eficonfig_sbkey.c
index caca27495e02..b3325a540f9a 100644
--- a/cmd/eficonfig_sbkey.c
+++ b/cmd/eficonfig_sbkey.c
@@ -6,7 +6,6 @@
  */
 
 #include <ansi.h>
-#include <common.h>
 #include <charset.h>
 #include <hexdump.h>
 #include <log.h>
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a587860e2a53..505f5bfa67d0 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -6,7 +6,6 @@
  */
 
 #include <charset.h>
-#include <common.h>
 #include <command.h>
 #include <dm/device.h>
 #include <efi_dt_fixup.h>
diff --git a/cmd/elf.c b/cmd/elf.c
index df4354d37428..a02361f9f512 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -4,7 +4,6 @@
  * All rights reserved.
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <elf.h>
diff --git a/cmd/ethsw.c b/cmd/ethsw.c
index f8b8a798bf6a..4bf49ac598fc 100644
--- a/cmd/ethsw.c
+++ b/cmd/ethsw.c
@@ -5,13 +5,13 @@
  * Ethernet Switch commands
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <errno.h>
 #include <env_flags.h>
 #include <ethsw.h>
 #include <net.h>
+#include <vsprintf.h>
 
 static const char *ethsw_name;
 
diff --git a/cmd/event.c b/cmd/event.c
index f6cdb55fc913..00c828757ca9 100644
--- a/cmd/event.c
+++ b/cmd/event.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <event.h>
 
diff --git a/cmd/exit.c b/cmd/exit.c
index 7bf241ec732d..d125ec1e31f2 100644
--- a/cmd/exit.c
+++ b/cmd/exit.c
@@ -4,8 +4,8 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 
 static int do_exit(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
diff --git a/cmd/ext2.c b/cmd/ext2.c
index a0ce0cf5796b..45c8b353b586 100644
--- a/cmd/ext2.c
+++ b/cmd/ext2.c
@@ -19,7 +19,6 @@
 /*
  * Ext2fs support
  */
-#include <common.h>
 #include <command.h>
 #include <fs.h>
 
diff --git a/cmd/ext4.c b/cmd/ext4.c
index 4791b69fd96d..40d1fe30d5ea 100644
--- a/cmd/ext4.c
+++ b/cmd/ext4.c
@@ -25,7 +25,6 @@
  *	        file in uboot. Added ext4fs ls load and write support.
  */
 
-#include <common.h>
 #include <part.h>
 #include <config.h>
 #include <command.h>
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 2b672d888c68..f43bf680858f 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -4,7 +4,6 @@
  * Köry Maincent, Bootlin, <kory.maincent@bootlin.com>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index c3c19231c988..d4cfc0c7a282 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -6,7 +6,6 @@
  * (C) Copyright 2014 Linaro, Ltd.
  * Rob Herring <robh@kernel.org>
  */
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <g_dnl.h>
diff --git a/cmd/fat.c b/cmd/fat.c
index 69ce1fa5300b..ad0e5ed7d600 100644
--- a/cmd/fat.c
+++ b/cmd/fat.c
@@ -7,7 +7,6 @@
 /*
  * Boot support
  */
-#include <common.h>
 #include <command.h>
 #include <mapmem.h>
 #include <fat.h>
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 331564c13be9..d16b141ce32d 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -7,7 +7,6 @@
  *   Matthew McClintock <msm@freescale.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
diff --git a/cmd/flash.c b/cmd/flash.c
index f4f85ecc7a8e..de0e04f09cfb 100644
--- a/cmd/flash.c
+++ b/cmd/flash.c
@@ -7,9 +7,9 @@
 /*
  * FLASH support
  */
-#include <common.h>
 #include <command.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <uuid.h>
 
 #if defined(CONFIG_CMD_MTDPARTS)
diff --git a/cmd/font.c b/cmd/font.c
index cb39c88063fb..ebde094b0a5b 100644
--- a/cmd/font.c
+++ b/cmd/font.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <video.h>
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 8c64e957db0f..93f14098ccb6 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -7,7 +7,6 @@
 /*
  *  FPGA support
  */
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <fpga.h>
diff --git a/cmd/fpgad.c b/cmd/fpgad.c
index dfc6220b5e01..b4bfaa121657 100644
--- a/cmd/fpgad.c
+++ b/cmd/fpgad.c
@@ -8,10 +8,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <display_options.h>
+#include <vsprintf.h>
 
 #include <gdsys_fpga.h>
 
diff --git a/cmd/fs.c b/cmd/fs.c
index 46cb43dcdb5b..3d7e06d6f1e5 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -5,7 +5,6 @@
  * Inspired by cmd_ext_common.c, cmd_fat.c.
  */
 
-#include <common.h>
 #include <command.h>
 #include <fs.h>
 
diff --git a/cmd/fs_uuid.c b/cmd/fs_uuid.c
index 5dc94aa64081..5f7770d09ac6 100644
--- a/cmd/fs_uuid.c
+++ b/cmd/fs_uuid.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2014, Bachmann electronic GmbH
  */
 
-#include <common.h>
 #include <command.h>
 #include <fs.h>
 
diff --git a/cmd/fuse.c b/cmd/fuse.c
index f884c894fb00..598ef496a430 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -8,11 +8,11 @@
  * Martha Marx <mmarx@silicontkx.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 #include <linux/errno.h>
 
 static int strtou32(const char *str, unsigned int base, u32 *result)
diff --git a/cmd/gettime.c b/cmd/gettime.c
index 2e74e02b4998..fc307efce8c2 100644
--- a/cmd/gettime.c
+++ b/cmd/gettime.c
@@ -11,8 +11,8 @@
 /*
  * Get Timer overflows after 2^32 / CONFIG_SYS_HZ (32Khz) = 131072 sec
  */
-#include <common.h>
 #include <command.h>
+#include <time.h>
 
 static int do_gettime(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
diff --git a/cmd/gpio.c b/cmd/gpio.c
index dab6f7097aec..7a43dc6ab184 100644
--- a/cmd/gpio.c
+++ b/cmd/gpio.c
@@ -6,7 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/cmd/gpt.c b/cmd/gpt.c
index d7e96529a693..ddf9e0cf8d4b 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -10,7 +10,6 @@
  * author: Piotr Wilczek <p.wilczek@samsung.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <env.h>
 #include <log.h>
diff --git a/cmd/hash.c b/cmd/hash.c
index 5534a735fa7e..60d482b7f872 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -9,7 +9,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <hash.h>
 #include <linux/ctype.h>
diff --git a/cmd/help.c b/cmd/help.c
index 9f8393eefd81..56579e28d31d 100644
--- a/cmd/help.c
+++ b/cmd/help.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_help(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/history.c b/cmd/history.c
index b6bf4670b1ce..8972986ca9d1 100644
--- a/cmd/history.c
+++ b/cmd/history.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cli.h>
 
diff --git a/cmd/host.c b/cmd/host.c
index c33c2a9787eb..e03576b4d2de 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2012, Google Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <fs.h>
diff --git a/cmd/i2c.c b/cmd/i2c.c
index 80831561c671..7dac0a9fb6cb 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -64,7 +64,6 @@
  * Adapted from cmd_mem.c which is copyright Wolfgang Denk (wd@denx.de).
  */
 
-#include <common.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
diff --git a/cmd/ide.c b/cmd/ide.c
index ddc87d3a0bb9..036489fda979 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -8,7 +8,6 @@
  * IDE support
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <config.h>
diff --git a/cmd/ini.c b/cmd/ini.c
index 35de2373e602..963990176916 100644
--- a/cmd/ini.c
+++ b/cmd/ini.c
@@ -11,9 +11,9 @@
  * http://code.google.com/p/inih/
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
+#include <vsprintf.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
 
diff --git a/cmd/io.c b/cmd/io.c
index 2de1111998fe..617373d3cb71 100644
--- a/cmd/io.c
+++ b/cmd/io.c
@@ -7,9 +7,9 @@
  * IO space access commands.
  */
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 
 /* Display values from last command */
diff --git a/cmd/iotrace.c b/cmd/iotrace.c
index f28359e2875d..0a041ed8652a 100644
--- a/cmd/iotrace.c
+++ b/cmd/iotrace.c
@@ -3,9 +3,9 @@
  * Copyright (c) 2014 Google, Inc
  */
 
-#include <common.h>
 #include <command.h>
 #include <iotrace.h>
+#include <vsprintf.h>
 
 static void do_print_stats(void)
 {
diff --git a/cmd/irq.c b/cmd/irq.c
index 1d3e28cb3ce0..655aba576a8b 100644
--- a/cmd/irq.c
+++ b/cmd/irq.c
@@ -3,7 +3,6 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <config.h>
 #include <command.h>
 #include <irq_func.h>
diff --git a/cmd/itest.c b/cmd/itest.c
index 74414cbdc4c6..b79512a505d6 100644
--- a/cmd/itest.c
+++ b/cmd/itest.c
@@ -11,11 +11,11 @@
  * A few parts were lifted from bash 'test' command
  */
 
-#include <common.h>
 #include <config.h>
 #include <command.h>
 #include <env.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 
 #include <asm/io.h>
 
diff --git a/cmd/jffs2.c b/cmd/jffs2.c
index e00fcc202266..89d336f59585 100644
--- a/cmd/jffs2.c
+++ b/cmd/jffs2.c
@@ -70,7 +70,6 @@
 /*
  * JFFS2/CRAMFS support
  */
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #if defined(CONFIG_CMD_FLASH)
diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index 9acb8e163863..e0d3c7fe7489 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2021, Chris Morgan <macromorgan@hotmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <hexdump.h>
diff --git a/cmd/led.c b/cmd/led.c
index 48a02baf509d..4256b3429c2f 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <led.h>
diff --git a/cmd/legacy-mtd-utils.c b/cmd/legacy-mtd-utils.c
index 5903a90fe53b..1a5271000bf3 100644
--- a/cmd/legacy-mtd-utils.c
+++ b/cmd/legacy-mtd-utils.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <jffs2/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 5256255f052d..50de7e89d8f4 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -9,10 +9,9 @@
  * Ulf Samuelsson <ulf.samuelsson@atmel.com>
  */
 
-#include <common.h>
-#include <config.h>
 #include <command.h>
 #include <status_led.h>
+#include <vsprintf.h>
 
 struct led_tbl_s {
 	char		*string;	/* String for use in the command */
diff --git a/cmd/license.c b/cmd/license.c
index 15411b5a92d5..161663ff29c6 100644
--- a/cmd/license.c
+++ b/cmd/license.c
@@ -4,7 +4,6 @@
  * Author: Harald Welte <laforge@openmoko.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <gzip.h>
 #include <malloc.h>
diff --git a/cmd/load.c b/cmd/load.c
index 540361b43f02..ace1c52f90ad 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -7,7 +7,6 @@
 /*
  * Serial up- and download support
  */
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <cpu_func.h>
diff --git a/cmd/log.c b/cmd/log.c
index c9a23e4ae0d3..519ec76f3b51 100644
--- a/cmd/log.c
+++ b/cmd/log.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <getopt.h>
diff --git a/cmd/lsblk.c b/cmd/lsblk.c
index d214dafc3bee..7c00bfdc7a09 100644
--- a/cmd/lsblk.c
+++ b/cmd/lsblk.c
@@ -4,7 +4,6 @@
  * Niel Fourie, DENX Software Engineering, lusus@denx.de.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/lzmadec.c b/cmd/lzmadec.c
index 81924da46180..c40b96941b47 100644
--- a/cmd/lzmadec.c
+++ b/cmd/lzmadec.c
@@ -9,10 +9,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <mapmem.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 
 #include <lzma/LzmaTools.h>
diff --git a/cmd/mbr.c b/cmd/mbr.c
index ec99b662834e..7e1f92a13bb5 100644
--- a/cmd/mbr.c
+++ b/cmd/mbr.c
@@ -8,11 +8,11 @@
  * based on the gpt command.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <malloc.h>
 #include <part.h>
+#include <vsprintf.h>
 
 /**
  * extract_val() - Extract a value from the key=value pair list
diff --git a/cmd/mdio.c b/cmd/mdio.c
index 3c74326161ef..c0a87087d315 100644
--- a/cmd/mdio.c
+++ b/cmd/mdio.c
@@ -8,7 +8,6 @@
  * MDIO Commands
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <miiphy.h>
diff --git a/cmd/mem.c b/cmd/mem.c
index 768057e4d3f6..4989d27f2ab4 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -10,7 +10,6 @@
  * Copied from FADS ROM, Dan Malek (dmalek@jlc.net)
  */
 
-#include <common.h>
 #include <console.h>
 #include <bootretry.h>
 #include <cli.h>
@@ -24,6 +23,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <rand.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
index de9a242e17f5..b69f8123ee2d 100644
--- a/cmd/meson/sm.c
+++ b/cmd/meson/sm.c
@@ -9,11 +9,11 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <env.h>
 #include <asm/arch/sm.h>
 #include <stdlib.h>
 #include <display_options.h>
+#include <vsprintf.h>
 
 static int do_sm_serial(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
diff --git a/cmd/mii.c b/cmd/mii.c
index fab420ee29e2..ce3724896926 100644
--- a/cmd/mii.c
+++ b/cmd/mii.c
@@ -8,7 +8,6 @@
  * MII Utilities
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <miiphy.h>
diff --git a/cmd/misc.c b/cmd/misc.c
index ec32b41ed1e9..792d9723c759 100644
--- a/cmd/misc.c
+++ b/cmd/misc.c
@@ -8,7 +8,6 @@
  * A command interface to access misc devices with MISC uclass driver APIs.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/cmd/mmc.c b/cmd/mmc.c
index 2d5430a53079..7244a90f4dce 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -4,7 +4,6 @@
  * Kyle Harris, kharris@nexus-tech.net
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <console.h>
@@ -14,6 +13,7 @@
 #include <part.h>
 #include <sparse_format.h>
 #include <image-sparse.h>
+#include <vsprintf.h>
 
 static int curr_device = -1;
 
diff --git a/cmd/mp.c b/cmd/mp.c
index 1b4373f25873..b9b5e0162466 100644
--- a/cmd/mp.c
+++ b/cmd/mp.c
@@ -3,9 +3,9 @@
  * Copyright 2008-2009 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
+#include <vsprintf.h>
 
 static int cpu_status_all(void)
 {
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 9189f45cabd5..795aaa2b37da 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -9,7 +9,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <console.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index b31db73ebfc9..f57d84dbb3ad 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -70,7 +70,6 @@
  *
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <log.h>
diff --git a/cmd/mux.c b/cmd/mux.c
index 388fb0878a84..2f6c08b8b079 100644
--- a/cmd/mux.c
+++ b/cmd/mux.c
@@ -6,7 +6,6 @@
  * Author: Pratyush Yadav <p.yadav@ti.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index 744b1c20aa83..e3f21dd0d815 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
diff --git a/cmd/mvebu/comphy_rx_training.c b/cmd/mvebu/comphy_rx_training.c
index 4ee8f54ea9c7..5653877cd4a2 100644
--- a/cmd/mvebu/comphy_rx_training.c
+++ b/cmd/mvebu/comphy_rx_training.c
@@ -5,7 +5,6 @@
  * SPDX-License-Identifier:	GPL-2.0
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <dm.h>
diff --git a/cmd/nand.c b/cmd/nand.c
index fe834c4ac5c0..5a328e0acddf 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -23,7 +23,6 @@
  * only
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <image.h>
 #include <asm/cache.h>
diff --git a/cmd/net.c b/cmd/net.c
index d407d8320a3d..b206ff58e681 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -9,7 +9,6 @@
 /*
  * Boot support
  */
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index e77338f81394..98a687bcabbd 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -23,7 +23,7 @@
  * environment. After that, we use a hash table.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cli.h>
 #include <command.h>
 #include <console.h>
diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
index 7a30b5cc8f87..64ae2ad2ce24 100644
--- a/cmd/nvedit_efi.c
+++ b/cmd/nvedit_efi.c
@@ -6,7 +6,6 @@
  */
 
 #include <charset.h>
-#include <common.h>
 #include <command.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
diff --git a/cmd/nvme.c b/cmd/nvme.c
index 09d5f438fb1a..f2c9acba5c32 100644
--- a/cmd/nvme.c
+++ b/cmd/nvme.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017 Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/onenand.c b/cmd/onenand.c
index fad781583a31..6e808ce3fce4 100644
--- a/cmd/onenand.c
+++ b/cmd/onenand.c
@@ -9,7 +9,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <common.h>
 #include <command.h>
 #include <malloc.h>
 #include <linux/printk.h>
diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index b3cafd924108..b155278ee2ad 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -4,7 +4,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <image.h>
diff --git a/cmd/osd.c b/cmd/osd.c
index 210bc5d4c231..5671338d9e7b 100644
--- a/cmd/osd.c
+++ b/cmd/osd.c
@@ -9,7 +9,6 @@
  * Dirk Eibach,  Guntermann & Drunck GmbH, eibach@gdsys.de
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <hexdump.h>
diff --git a/cmd/panic.c b/cmd/panic.c
index f13b3f094fab..7c0affa5eb50 100644
--- a/cmd/panic.c
+++ b/cmd/panic.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
+#include <vsprintf.h>
 #include <command.h>
 
 static int do_panic(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/part.c b/cmd/part.c
index c75f85acd52d..d140a1eddb92 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -15,7 +15,6 @@
  * Pavel Bartusek <pba@sysgo.com>
  */
 
-#include <common.h>
 #include <config.h>
 #include <command.h>
 #include <env.h>
diff --git a/cmd/pcap.c b/cmd/pcap.c
index a0149203fad5..8d610966c13d 100644
--- a/cmd/pcap.c
+++ b/cmd/pcap.c
@@ -4,8 +4,8 @@
  * Ramon Fried <rfried.dev@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 #include <net.h>
 #include <net/pcap.h>
 
diff --git a/cmd/pci.c b/cmd/pci.c
index d89e71c16a04..3c0aed50cae3 100644
--- a/cmd/pci.c
+++ b/cmd/pci.c
@@ -12,7 +12,6 @@
  * PCI routines
  */
 
-#include <common.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
diff --git a/cmd/pci_mps.c b/cmd/pci_mps.c
index 98161da93a05..19e71db8cbd2 100644
--- a/cmd/pci_mps.c
+++ b/cmd/pci_mps.c
@@ -6,7 +6,6 @@
  * PCI Express Maximum Packet Size (MPS) configuration
  */
 
-#include <common.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
diff --git a/cmd/pinmux.c b/cmd/pinmux.c
index 105f01eaafff..01f3e4af6cec 100644
--- a/cmd/pinmux.c
+++ b/cmd/pinmux.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/cmd/pmc.c b/cmd/pmc.c
index 9a3ba2bffc50..1a3416fb2a96 100644
--- a/cmd/pmc.c
+++ b/cmd/pmc.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Google LLC
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <power/acpi_pmc.h>
diff --git a/cmd/pmic.c b/cmd/pmic.c
index c9e9730adf90..3ad1b8aa3756 100644
--- a/cmd/pmic.c
+++ b/cmd/pmic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014-2015 Samsung Electronics
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/cmd/printf.c b/cmd/printf.c
index 0c6887e0d6e9..a1727ac15a2d 100644
--- a/cmd/printf.c
+++ b/cmd/printf.c
@@ -84,12 +84,12 @@
  * We try to be compatible.
  */
 
-#include <common.h>
 #include <ctype.h>
 #include <errno.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <vsprintf.h>
 
 #define WANT_HEX_ESCAPES 0
 #define PRINT_CONVERSION_ERROR 1
diff --git a/cmd/pvblock.c b/cmd/pvblock.c
index 1b604c37373c..3a83ac9cd92c 100644
--- a/cmd/pvblock.c
+++ b/cmd/pvblock.c
@@ -6,7 +6,6 @@
  */
 
 #include <blk.h>
-#include <common.h>
 #include <command.h>
 
 /* Current I/O Device */
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 21134eb7a304..ae02c28c0750 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -4,12 +4,12 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <command.h>
 #include <fs.h>
 #include <net.h>
 #include <net6.h>
 #include <malloc.h>
+#include <vsprintf.h>
 
 #include "pxe_utils.h"
 
diff --git a/cmd/qfw.c b/cmd/qfw.c
index 1b8c775ebf5a..1b108118658e 100644
--- a/cmd/qfw.c
+++ b/cmd/qfw.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Miao Yan <yanmiaobest@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <errno.h>
diff --git a/cmd/read.c b/cmd/read.c
index 1218e7acfd0a..af54bd176547 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -8,10 +8,10 @@
  * Software Foundation.
  */
 
-#include <common.h>
 #include <command.h>
 #include <mapmem.h>
 #include <part.h>
+#include <vsprintf.h>
 
 static int
 do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/cmd/reginfo.c b/cmd/reginfo.c
index c8a04b1754eb..53b8bc41bfe5 100644
--- a/cmd/reginfo.c
+++ b/cmd/reginfo.c
@@ -4,7 +4,6 @@
  * Subodh Nijsure, SkyStream Networks, snijsure@skystream.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/ppc.h>
 
diff --git a/cmd/regulator.c b/cmd/regulator.c
index 635a9add5856..da298090bb76 100644
--- a/cmd/regulator.c
+++ b/cmd/regulator.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014-2015 Samsung Electronics
  * Przemyslaw Marczak <p.marczak@samsung.com>
  */
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/cmd/remoteproc.c b/cmd/remoteproc.c
index ea8724a187da..3c5b6a05b1af 100644
--- a/cmd/remoteproc.c
+++ b/cmd/remoteproc.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015
  * Texas Instruments Incorporated - https://www.ti.com/
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index bd9d9c4765da..df9f212cd0dd 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/sbi.h>
 
diff --git a/cmd/rkmtd.c b/cmd/rkmtd.c
index 5b80427cb949..a870c1191108 100644
--- a/cmd/rkmtd.c
+++ b/cmd/rkmtd.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/rng.c b/cmd/rng.c
index e5ab86811226..2fb7202303ac 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -4,7 +4,6 @@
  *
  * Copyright (c) 2019, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <hexdump.h>
diff --git a/cmd/rockusb.c b/cmd/rockusb.c
index 07088564a109..48497aa87641 100644
--- a/cmd/rockusb.c
+++ b/cmd/rockusb.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Eddie Cai <eddie.cai.linux@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <g_dnl.h>
diff --git a/cmd/rtc.c b/cmd/rtc.c
index a344cfa76b1d..a931fd9d54f0 100644
--- a/cmd/rtc.c
+++ b/cmd/rtc.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <dm.h>
diff --git a/cmd/sata.c b/cmd/sata.c
index 9c9fe111d12f..8b923f9378b2 100644
--- a/cmd/sata.c
+++ b/cmd/sata.c
@@ -9,7 +9,6 @@
  *		Dave Liu <daveliu@freescale.com>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <blk.h>
 #include <dm.h>
diff --git a/cmd/sb.c b/cmd/sb.c
index 0d55818e3c67..1aa5921f03e6 100644
--- a/cmd/sb.c
+++ b/cmd/sb.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <spl.h>
diff --git a/cmd/scp03.c b/cmd/scp03.c
index 2b8d5aecf349..9c749d19af81 100644
--- a/cmd/scp03.c
+++ b/cmd/scp03.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <scp03.h>
diff --git a/cmd/scsi.c b/cmd/scsi.c
index c501d7f456d7..c286bdc07260 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -7,7 +7,6 @@
 /*
  * SCSI support.
  */
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <scsi.h>
diff --git a/cmd/seama.c b/cmd/seama.c
index 3aafb43c48a0..3c8e81992340 100644
--- a/cmd/seama.c
+++ b/cmd/seama.c
@@ -4,7 +4,6 @@
  * Support for the "SEAttle iMAge" SEAMA NAND image format
  */
 
-#include <common.h>
 #include <command.h>
 #include <nand.h>
 
diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index ab76824a32bb..e111b8ba98ad 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -8,7 +8,6 @@
  * This file provides a shell like 'expr' function to return.
  */
 
-#include <common.h>
 #include <config.h>
 #include <command.h>
 #include <ctype.h>
@@ -16,6 +15,8 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <vsprintf.h>
+#include <linux/errno.h>
 #include <linux/sizes.h>
 #include "printf.h"
 
diff --git a/cmd/sf.c b/cmd/sf.c
index e3866899f6c4..f43a2e08b318 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2008 Atmel Corporation
  */
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <div64.h>
@@ -14,6 +13,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <spi.h>
+#include <time.h>
 #include <spi_flash.h>
 #include <asm/cache.h>
 #include <jffs2/jffs2.h>
diff --git a/cmd/sha1sum.c b/cmd/sha1sum.c
index bcc665a5a6c6..52aa26c78d2f 100644
--- a/cmd/sha1sum.c
+++ b/cmd/sha1sum.c
@@ -7,7 +7,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <hash.h>
 #include <u-boot/sha1.h>
diff --git a/cmd/sleep.c b/cmd/sleep.c
index c741b4aa029b..7616fed75566 100644
--- a/cmd/sleep.c
+++ b/cmd/sleep.c
@@ -4,9 +4,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
+#include <time.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
 
 static int do_sleep(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/smccc.c b/cmd/smccc.c
index fb80431ad1d9..3a4d885e37e1 100644
--- a/cmd/smccc.c
+++ b/cmd/smccc.c
@@ -4,8 +4,8 @@
  * Michalis Pappas <mpappas@fastmail.fm>
  */
 #include <asm/psci.h>
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 #include <linux/arm-smccc.h>
 #include <linux/compiler.h>
 #include <linux/psci.h>
diff --git a/cmd/sound.c b/cmd/sound.c
index 0b7f9599716b..08bf74112f16 100644
--- a/cmd/sound.c
+++ b/cmd/sound.c
@@ -4,7 +4,6 @@
  * Rajeshwari Shinde <rajeshwari.s@samsung.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/cmd/source.c b/cmd/source.c
index 0ba9736b1ab3..c9b5f8e400a6 100644
--- a/cmd/source.c
+++ b/cmd/source.c
@@ -14,7 +14,6 @@
 
 /* #define DEBUG */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
diff --git a/cmd/spi.c b/cmd/spi.c
index f30018f33be8..ea30c854c218 100644
--- a/cmd/spi.c
+++ b/cmd/spi.c
@@ -8,7 +8,6 @@
  * SPI Read/Write Utilities
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/cmd/spl.c b/cmd/spl.c
index 8a2ded72be9f..d1f47c7316b4 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -4,7 +4,6 @@
  * Corscience GmbH & Co. KG - Simon Schwarz <schwarz@corscience.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cmd_spl.h>
 #include <env.h>
diff --git a/cmd/stackprot_test.c b/cmd/stackprot_test.c
index f3470288facc..e7ff4a061589 100644
--- a/cmd/stackprot_test.c
+++ b/cmd/stackprot_test.c
@@ -3,7 +3,6 @@
  *  Copyright 2021 Broadcom
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_test_stackprot_fail(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/strings.c b/cmd/strings.c
index bf348afce814..5bcb0f2b567c 100644
--- a/cmd/strings.c
+++ b/cmd/strings.c
@@ -7,8 +7,8 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 
 static char *start_addr, *last_addr;
 
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index d14c570d96ab..0ea08fd7b535 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <fs.h>
 #include <pxe_utils.h>
+#include <vsprintf.h>
 
 /**
  * struct sysboot_info - useful information for sysboot helpers
diff --git a/cmd/temperature.c b/cmd/temperature.c
index 420965de1436..41e422fc937d 100644
--- a/cmd/temperature.c
+++ b/cmd/temperature.c
@@ -5,7 +5,6 @@
  * Written by Robert Marko <robert.marko@sartura.hr>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <thermal.h>
diff --git a/cmd/terminal.c b/cmd/terminal.c
index 9e32a4191e1e..369a755e0f5f 100644
--- a/cmd/terminal.c
+++ b/cmd/terminal.c
@@ -7,7 +7,6 @@
 /*
  * Boot support
  */
-#include <common.h>
 #include <command.h>
 #include <stdio_dev.h>
 #include <serial.h>
diff --git a/cmd/test.c b/cmd/test.c
index fa7c48fb9f10..b4c3eabf9f60 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -4,10 +4,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <fs.h>
 #include <log.h>
+#include <vsprintf.h>
 
 #define OP_INVALID	0
 #define OP_NOT		1
diff --git a/cmd/thordown.c b/cmd/thordown.c
index 48e22b31d025..70061bf8d4cc 100644
--- a/cmd/thordown.c
+++ b/cmd/thordown.c
@@ -6,7 +6,6 @@
  * All rights reserved.
  */
 
-#include <common.h>
 #include <command.h>
 #include <thor.h>
 #include <dfu.h>
diff --git a/cmd/ti/ddr3.c b/cmd/ti/ddr3.c
index bbd406fc66ec..70ce53d01e87 100644
--- a/cmd/ti/ddr3.c
+++ b/cmd/ti/ddr3.c
@@ -12,7 +12,6 @@
 #include <asm/arch/hardware.h>
 #include <asm/cache.h>
 #include <asm/emif.h>
-#include <common.h>
 #include <command.h>
 #include <asm/global_data.h>
 
diff --git a/cmd/ti/pd.c b/cmd/ti/pd.c
index a0492a5fdee3..305023af1e7d 100644
--- a/cmd/ti/pd.c
+++ b/cmd/ti/pd.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2020 Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <k3-dev.h>
diff --git a/cmd/time.c b/cmd/time.c
index db8c1892df4a..eee6084e9685 100644
--- a/cmd/time.c
+++ b/cmd/time.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <command.h>
 
 static void report_time(ulong cycles)
diff --git a/cmd/timer.c b/cmd/timer.c
index 551be5dd54ee..04fcd84ac6a6 100644
--- a/cmd/timer.c
+++ b/cmd/timer.c
@@ -4,8 +4,8 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
+#include <time.h>
 
 static int do_timer(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 57cfd355df1b..0aec75217709 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2014,2016 david_yang <david_yang@accton.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/cmd/tpm-common.c b/cmd/tpm-common.c
index a7dc23d85d5d..1cd57f901b6d 100644
--- a/cmd/tpm-common.c
+++ b/cmd/tpm-common.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
index 1b1efcd204d2..6e019d1c7291 100644
--- a/cmd/tpm-v1.c
+++ b/cmd/tpm-v1.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2013 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <asm/unaligned.h>
 #include <tpm-common.h>
 #include <tpm-v1.h>
diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 7e479b9dfe36..99c540b26de9 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -4,7 +4,6 @@
  * Author: Miquel Raynal <miquel.raynal@bootlin.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
index c7fa6e775f55..9c8b1c74384a 100644
--- a/cmd/tpm_test.c
+++ b/cmd/tpm_test.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <tpm-v1.h>
 #include <linux/printk.h>
 #include "tpm-user-utils.h"
diff --git a/cmd/trace.c b/cmd/trace.c
index 2e3ee1d3ba23..937e6a682add 100644
--- a/cmd/trace.c
+++ b/cmd/trace.c
@@ -3,11 +3,11 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <mapmem.h>
 #include <trace.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 
 static int get_args(int argc, char *const argv[], char **buff,
diff --git a/cmd/tsi148.c b/cmd/tsi148.c
index 0d849d9979e4..113b4e673304 100644
--- a/cmd/tsi148.c
+++ b/cmd/tsi148.c
@@ -7,10 +7,10 @@
  * (C) Copyright 2003 Stefan Roese, stefan.roese@esd-electronics.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 #include <pci.h>
 
diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd109..8c1b5df05724 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <exports.h>
diff --git a/cmd/ubifs.c b/cmd/ubifs.c
index 2a035bc7ae6f..8fd39032eccf 100644
--- a/cmd/ubifs.c
+++ b/cmd/ubifs.c
@@ -11,11 +11,11 @@
 
 #undef DEBUG
 
-#include <common.h>
 #include <config.h>
 #include <command.h>
 #include <log.h>
 #include <ubifs_uboot.h>
+#include <vsprintf.h>
 
 static int ubifs_initialized;
 static int ubifs_mounted;
diff --git a/cmd/ufs.c b/cmd/ufs.c
index 536bd85b75d8..6e21fbb1685c 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -5,9 +5,9 @@
  * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  *
  */
-#include <common.h>
 #include <command.h>
 #include <ufs.h>
+#include <vsprintf.h>
 
 static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/universe.c b/cmd/universe.c
index fb3a32d4d5a7..d1a712829d01 100644
--- a/cmd/universe.c
+++ b/cmd/universe.c
@@ -3,9 +3,9 @@
  * (C) Copyright 2003 Stefan Roese, stefan.roese@esd-electronics.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <malloc.h>
+#include <vsprintf.h>
 #include <asm/io.h>
 #include <pci.h>
 
diff --git a/cmd/unlz4.c b/cmd/unlz4.c
index 5f20838e899c..fc5200117adc 100644
--- a/cmd/unlz4.c
+++ b/cmd/unlz4.c
@@ -4,9 +4,9 @@
  * FUJITSU COMPUTERTECHNOLOGIES LIMITED. All rights reserved.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
+#include <vsprintf.h>
 #include <u-boot/lz4.h>
 
 static int do_unlz4(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/unzip.c b/cmd/unzip.c
index bc6cee060432..e7a3f9808b2c 100644
--- a/cmd/unzip.c
+++ b/cmd/unzip.c
@@ -4,12 +4,12 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <gzip.h>
 #include <mapmem.h>
 #include <part.h>
+#include <vsprintf.h>
 
 static int do_unzip(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/usb.c b/cmd/usb.c
index 23253f22231c..3a3764a5b862 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -10,7 +10,6 @@
  * project.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <bootstage.h>
 #include <command.h>
diff --git a/cmd/usb_gadget_sdp.c b/cmd/usb_gadget_sdp.c
index cbdda733533c..39259a3b0925 100644
--- a/cmd/usb_gadget_sdp.c
+++ b/cmd/usb_gadget_sdp.c
@@ -6,7 +6,6 @@
  * Author: Stefan Agner <stefan.agner@toradex.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <g_dnl.h>
 #include <sdp.h>
diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index 751701fe73af..47e8b70cd103 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <console.h>
diff --git a/cmd/vbe.c b/cmd/vbe.c
index 0e84b0e97aa4..423d9e5f8f09 100644
--- a/cmd/vbe.c
+++ b/cmd/vbe.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bloblist.h>
 #include <bootmeth.h>
 #include <bootstd.h>
diff --git a/cmd/version.c b/cmd/version.c
index d99a44f19fb3..53db1a0b6bd1 100644
--- a/cmd/version.c
+++ b/cmd/version.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <version_string.h>
diff --git a/cmd/video.c b/cmd/video.c
index 942f81c16336..91bd6de14dc1 100644
--- a/cmd/video.c
+++ b/cmd/video.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <video.h>
diff --git a/cmd/virtio.c b/cmd/virtio.c
index 019e317e7558..a42a563ab727 100644
--- a/cmd/virtio.c
+++ b/cmd/virtio.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <dm.h>
diff --git a/cmd/w1.c b/cmd/w1.c
index 3209e65f377f..e462e786a96e 100644
--- a/cmd/w1.c
+++ b/cmd/w1.c
@@ -4,7 +4,6 @@
  * Microchip Technology, Inc.
  * Eugen Hristev <eugen.hristev@microchip.com>
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <w1.h>
diff --git a/cmd/wdt.c b/cmd/wdt.c
index b9fdf7ad155f..c7a06cca181f 100644
--- a/cmd/wdt.c
+++ b/cmd/wdt.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2019 Michael Walle <michael@walle.cc>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <wdt.h>
diff --git a/cmd/wol.c b/cmd/wol.c
index f0d634322721..45d4ae3f719e 100644
--- a/cmd/wol.c
+++ b/cmd/wol.c
@@ -7,9 +7,9 @@
 /*
  * Wake-on-LAN support
  */
-#include <common.h>
 #include <command.h>
 #include <net.h>
+#include <vsprintf.h>
 
 #if defined(CONFIG_CMD_WOL)
 void wol_set_timeout(ulong);
diff --git a/cmd/x86/cbsysinfo.c b/cmd/x86/cbsysinfo.c
index 84822a3e3211..7ca2e13ae2f8 100644
--- a/cmd/x86/cbsysinfo.c
+++ b/cmd/x86/cbsysinfo.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <asm/cb_sysinfo.h>
 #include <command.h>
 #include <console.h>
diff --git a/cmd/x86/fsp.c b/cmd/x86/fsp.c
index 82e4415b16eb..2620ab8ee025 100644
--- a/cmd/x86/fsp.c
+++ b/cmd/x86/fsp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014-2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/fsp/fsp_support.h>
 #include <asm/global_data.h>
diff --git a/cmd/x86/hob.c b/cmd/x86/hob.c
index 04d092dbe7ef..2dd30808bd10 100644
--- a/cmd/x86/hob.c
+++ b/cmd/x86/hob.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014-2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <efi.h>
 #include <uuid.h>
diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index 6ad7a123a447..b2afb598c73e 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -3,9 +3,9 @@
  * (C) Copyright 2014 Google, Inc
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <asm/msr.h>
 #include <asm/mp.h>
 #include <asm/mtrr.h>
diff --git a/cmd/ximg.c b/cmd/ximg.c
index 0e7eead8d192..1467484df8d0 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -11,7 +11,6 @@
 /*
  * Multi Image extract
  */
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/cmd/xxd.c b/cmd/xxd.c
index 446ac1915ef5..8ae05f910cb0 100644
--- a/cmd/xxd.c
+++ b/cmd/xxd.c
@@ -4,7 +4,6 @@
  * Roger Knecht <rknecht@pm.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <fs.h>
diff --git a/cmd/yaffs2.c b/cmd/yaffs2.c
index 27fbd1be8f75..d0724d9bea8f 100644
--- a/cmd/yaffs2.c
+++ b/cmd/yaffs2.c
@@ -13,7 +13,6 @@
  *  ...
  */
 
-#include <common.h>
 
 #include <config.h>
 #include <command.h>
diff --git a/cmd/zfs.c b/cmd/zfs.c
index 6ef1b56ab10b..2f831532c2e8 100644
--- a/cmd/zfs.c
+++ b/cmd/zfs.c
@@ -8,7 +8,6 @@
  * made from existing GRUB Sources by Sun, GNU and others.
  */
 
-#include <common.h>
 #include <part.h>
 #include <config.h>
 #include <command.h>
diff --git a/cmd/zip.c b/cmd/zip.c
index 08afd62b973d..2d2554288229 100644
--- a/cmd/zip.c
+++ b/cmd/zip.c
@@ -4,10 +4,10 @@
  * Lei Wen <leiwen@marvell.com>, Marvell Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <gzip.h>
+#include <vsprintf.h>
 
 static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/include/android_ab.h b/include/android_ab.h
index 1fee7582b90a..dbf20343da62 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -6,6 +6,8 @@
 #ifndef __ANDROID_AB_H
 #define __ANDROID_AB_H
 
+#include <stdbool.h>
+
 struct blk_desc;
 struct disk_partition;
 
-- 
2.34.1

