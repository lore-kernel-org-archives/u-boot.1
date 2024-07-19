Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF82BC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D7C88BE8;
	Fri, 19 Jul 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pblnx4Oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2994B88BE0; Fri, 19 Jul 2024 14:43:58 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C609E88BC4
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eede876fcbso21114681fa.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393035; x=1721997835; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M7CcGxRGRWQfg7BDqiMqKl5BmEjZsiE6NCLF4VZf/tc=;
 b=Pblnx4Oj6uEKvGThkAGMs8jMvv1Y3HhgRA6dAEbcuuB7msFBkvDr0xyAJu5qfSxg66
 jPFmCvNlDTv/oMW9+YBWsL0w8SNeOfoPi+zuv4zwN7r5gkHk1qJFTM/mqVHlgvYW9xlA
 3V1RmM3q8euY68+RUN5IPO8Hgk615SSA/EvBAsMspg2iZw+9b3NwEs8B9Yhwrr87h8N6
 uNr5BpFvbQ4su2SmIGhlMdU85uTPY4BNDTGwANPO9ie9k/1ZQBif/Tfy4DfNfSdjQRUS
 C0Bmi1RGuT0/E7VwlaixaIq524OCIdmuXSESDTMPuGfQJ5kcy7r5mxBwsj4sjHEo+BHp
 FbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393035; x=1721997835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7CcGxRGRWQfg7BDqiMqKl5BmEjZsiE6NCLF4VZf/tc=;
 b=dKhRd2u8fFNLNdcVeIHmXn3eIxl+RvAwcNtStQjKPZ5I3DWzwtimVYGn0kFuxTdDmb
 RkLo2vgtyCi5z/elpAAZxlz4GP+rnUr4Dj+CSMjFAsTHU4Rn/dVs7AkVunL/AC5sbbPw
 rxvEhusoqNjgi+bSX3heYpV+pwsg2D89KEKPrgjQS/LPR4l2nz6YOp5uWjKWvzCovQBn
 oizxc02yq1qDeMI/9v+RLL3ePWRoRpuX5pblPl7cvccWKQ4BUbKnL5IqHHdLZxdPmTcW
 edvV6Dde/TZe1JfTLAKoaK76HEgZGtoMY4pc8vnGMl0urkZ9Flw0PN2y3e/L2MGrJI0H
 7iZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs6bQuqnNbngFpQPzJYMr1J5vJW2NHS3+pWGa0j1DhAvyFfIBBpgIvBhb4+/oBuee9HQBs6R2on/1Bmb138ovo39JKLQ==
X-Gm-Message-State: AOJu0Yx1IWaidUQV5b1oX3zm48W1w2RMVW83n4OnUOQTFlfDjlk8IEu6
 YL77PM/g+ZvZ+S2aQM5pBy2zxytvnVOgbkQjN2SQR7k9xtcZtIdecMhZwZP3CXI=
X-Google-Smtp-Source: AGHT+IHnpvG7KiIgoOSjS7ywh4DPKE7acg7tlCb4LO/3aRtI3EALmvKS/XAIBBiP0aBXL9woDu3GOg==
X-Received: by 2002:a05:6512:a8c:b0:52c:e121:c927 with SMTP id
 2adb3069b0e04-52ee544669dmr4833021e87.62.1721393035003; 
 Fri, 19 Jul 2024 05:43:55 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:47 +0200
Subject: [PATCH v5 07/11] include: export uuid.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-7-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15727;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=qH3r0Dg/LorphtqiiSLAE0FelhRGtjCh4FMI2EyXgW0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+BT3iiAspnw56f0dkbsQOIJj6TnWOBAmczx
 fCelZW4w6mJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgQAKCRAFgzErGV9k
 tk3jD/kBzqBodX6rWdGXt+Cb1K4hzys+3HZTujEv3rXbEk2OF/zIFBYB+/rp/nUQDFx5plaM2RA
 +Cec8zal9QHJzFkmZmV9cEHQLGUz8AWAMin8TMlz/z4GPb2cG19SuysdSJv6IkPCokZICNvlGDh
 mtsWYCgHaIEmZmfJ10wWQLWSTggBqHZKlrC5HPd2JBdhAmUUPaiyz1aB99mUlsvnsn4YK0y7Q86
 cPdBHTALgTCuDWKLAjdMmN0P9RsSFbHwSk7IiFzFsiiqNjIYB8bIcKa2ufBC/O2vRQpcjRRlAEx
 8ds3/RguND5j1b/V90ilxEqN8PitGULLB/t1Yz946X9327l7BfsTDhmsVHK13Uc3/JMQ+BCI/4G
 dBwhgdjkJ/1CwbVcuSwA6ieq7CpnvRlhwYar4ZkSINPbRICkdxjB6JW/17M8j6eD8sMEeboPXxl
 EWHIPtzLvbAXLf20E4D+qFgJpmj2Pe6w74MDLDccBm5kLhXTF+eziu+wc1RQLRxJfQOuiyilhzk
 Nxqhn3rOMSYWHQSqY31gnF19Gej1rH0jXJWJQu+8fWWWa8uVaP6faND6txl4g1AO+CxAWnNXxp9
 xVckUrastLxofI8NWPhb4zMILqU1RVEVrnTT/K99uhfdsnaMlZKevLHUIr9U915OzAjRlN4ErSN
 EUshjRZ858zDpbw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Move this header to include/u-boot/ so that it can be used by external
tools.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-rockchip/board.c             | 2 +-
 board/cobra5272/flash.c                    | 2 +-
 board/gardena/smart-gateway-mt7688/board.c | 2 +-
 board/socrates/socrates.c                  | 2 +-
 board/xilinx/common/board.c                | 2 +-
 cmd/efi.c                                  | 2 +-
 cmd/efi_common.c                           | 2 +-
 cmd/flash.c                                | 2 +-
 cmd/gpt.c                                  | 2 +-
 cmd/nvedit_efi.c                           | 2 +-
 cmd/x86/hob.c                              | 2 +-
 common/flash.c                             | 2 +-
 disk/part_efi.c                            | 2 +-
 drivers/firmware/arm-ffa/arm-ffa-uclass.c  | 2 +-
 env/sf.c                                   | 2 +-
 fs/btrfs/btrfs.c                           | 2 +-
 fs/btrfs/compat.h                          | 2 +-
 fs/btrfs/disk-io.c                         | 2 +-
 fs/ext4/ext4fs.c                           | 2 +-
 include/fwu.h                              | 2 +-
 include/part.h                             | 2 +-
 include/rkmtd.h                            | 2 +-
 include/{ => u-boot}/uuid.h                | 0
 lib/acpi/acpi_dp.c                         | 2 +-
 lib/acpi/acpigen.c                         | 2 +-
 lib/efi/efi_app.c                          | 2 +-
 lib/efi_loader/efi_capsule.c               | 2 +-
 lib/efi_loader/efi_device_path.c           | 2 +-
 lib/efi_loader/efi_variable.c              | 2 +-
 lib/fwu_updates/fwu_mtd.c                  | 2 +-
 lib/uuid.c                                 | 2 +-
 lib/vsprintf.c                             | 2 +-
 net/bootp.c                                | 2 +-
 test/dm/acpi_dp.c                          | 2 +-
 test/dm/acpigen.c                          | 2 +-
 test/lib/uuid.c                            | 2 +-
 36 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 8a57b8217ff2..0fdf9365b41e 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -24,9 +24,9 @@
 #include <misc.h>
 #include <part.h>
 #include <ram.h>
 #include <syscon.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <u-boot/crc.h>
 #include <u-boot/sha256.h>
 #include <asm/cache.h>
 #include <asm/io.h>
diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 157b71da85e8..0c1b1c7decd8 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -10,9 +10,9 @@
 #include <flash.h>
 #include <irq_func.h>
 #include <stdio.h>
 #include <time.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 
diff --git a/board/gardena/smart-gateway-mt7688/board.c b/board/gardena/smart-gateway-mt7688/board.c
index c6b14bed41fb..eb7fcd630a10 100644
--- a/board/gardena/smart-gateway-mt7688/board.c
+++ b/board/gardena/smart-gateway-mt7688/board.c
@@ -15,9 +15,9 @@
 #include <spi_flash.h>
 #include <linux/delay.h>
 #include <linux/stringify.h>
 #include <u-boot/crc.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linux/ctype.h>
 #include <linux/io.h>
 
 #define MT76XX_AGPIO_CFG	0x1000003c
diff --git a/board/socrates/socrates.c b/board/socrates/socrates.c
index 6e6e276cc741..5e5a45ee00db 100644
--- a/board/socrates/socrates.c
+++ b/board/socrates/socrates.c
@@ -14,9 +14,9 @@
 #include <clock_legacy.h>
 #include <env.h>
 #include <init.h>
 #include <pci.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
 #include <asm/immap_85xx.h>
 #include <ioports.h>
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 0b43407b9e94..8cec455ae984 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -30,9 +30,9 @@
 #include <slre.h>
 #include <soc.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 #include "fru.h"
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
diff --git a/cmd/efi.c b/cmd/efi.c
index 6bed2d743ba6..687ccb520428 100644
--- a/cmd/efi.c
+++ b/cmd/efi.c
@@ -10,9 +10,9 @@
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
 #include <sort.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/cmd/efi_common.c b/cmd/efi_common.c
index c46764e6eea7..d2f2b59e9e3b 100644
--- a/cmd/efi_common.c
+++ b/cmd/efi_common.c
@@ -7,9 +7,9 @@
  */
 
 #include <efi.h>
 #include <efi_api.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 void efi_show_tables(struct efi_system_table *systab)
 {
 	int i;
diff --git a/cmd/flash.c b/cmd/flash.c
index de0e04f09cfb..fd660ec477c9 100644
--- a/cmd/flash.c
+++ b/cmd/flash.c
@@ -9,9 +9,9 @@
  */
 #include <command.h>
 #include <log.h>
 #include <vsprintf.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 #if defined(CONFIG_CMD_MTDPARTS)
 #include <jffs2/jffs2.h>
 
diff --git a/cmd/gpt.c b/cmd/gpt.c
index 86b7701886a3..27aea2df197c 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -18,9 +18,9 @@
 #include <part.h>
 #include <part_efi.h>
 #include <part.h>
 #include <exports.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linux/ctype.h>
 #include <div64.h>
 #include <memalign.h>
 #include <linux/compat.h>
diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
index 64ae2ad2ce24..32b7d0490747 100644
--- a/cmd/nvedit_efi.c
+++ b/cmd/nvedit_efi.c
@@ -14,9 +14,9 @@
 #include <hexdump.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <rtc.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linux/kernel.h>
 
 /*
  * From efi_variable.c,
diff --git a/cmd/x86/hob.c b/cmd/x86/hob.c
index 2dd30808bd10..d3713cef3312 100644
--- a/cmd/x86/hob.c
+++ b/cmd/x86/hob.c
@@ -4,9 +4,9 @@
  */
 
 #include <command.h>
 #include <efi.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/global_data.h>
 #include <asm/hob.h>
 #include <asm/fsp/fsp_hob.h>
 
diff --git a/common/flash.c b/common/flash.c
index 24ddc8bee724..226646c6868f 100644
--- a/common/flash.c
+++ b/common/flash.c
@@ -7,9 +7,9 @@
 /* #define DEBUG */
 
 #include <flash.h>
 #include <log.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linux/string.h>
 
 #include <mtd/cfi_flash.h>
 
diff --git a/disk/part_efi.c b/disk/part_efi.c
index bde4adcfa087..f302a2433cb6 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -14,9 +14,9 @@
 
 #include <blk.h>
 #include <log.h>
 #include <part.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/unaligned.h>
 #include <command.h>
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index e0767fc75517..96c64964bb73 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -10,9 +10,9 @@
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
 #include <string.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/root.h>
diff --git a/env/sf.c b/env/sf.c
index c747e175e31b..bf08764a09f8 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -15,9 +15,9 @@
 #include <spi.h>
 #include <spi_flash.h>
 #include <search.h>
 #include <errno.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <u-boot/crc.h>
diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 1149a3b20077..350cff0cbca0 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -6,9 +6,9 @@
  */
 
 #include <config.h>
 #include <malloc.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linux/time.h>
 #include "btrfs.h"
 #include "crypto/hash.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 02173dea5f48..4596b9d1dd39 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -4,9 +4,9 @@
 #define __BTRFS_COMPAT_H__
 
 #include <linux/errno.h>
 #include <fs_internal.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 /* Provide a compatibility layer to make code syncing easier */
 
 /* A simple wraper to for error() used in btrfs-progs */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 34d9d5351216..14efe7218df5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <fs_internal.h>
 #include <log.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <memalign.h>
 #include "kernel-shared/btrfs_tree.h"
 #include "common/rbtree-utils.h"
 #include "disk-io.h"
diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index da59cb008fce..15587e92e3e7 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -26,9 +26,9 @@
 #include "ext4_common.h"
 #include <div64.h>
 #include <malloc.h>
 #include <part.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 int ext4fs_symlinknest;
 struct ext_filesystem ext_fs;
 
diff --git a/include/fwu.h b/include/fwu.h
index 77ec65e61807..c317613eaaab 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -9,9 +9,9 @@
 #include <blk.h>
 #include <efi.h>
 #include <fwu_mdata.h>
 #include <mtd.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 #include <linux/types.h>
 
 struct fwu_mdata;
diff --git a/include/part.h b/include/part.h
index afae51f1b933..678eb4d7ee99 100644
--- a/include/part.h
+++ b/include/part.h
@@ -7,9 +7,9 @@
 #define _PART_H
 
 #include <blk.h>
 #include <ide.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linker_lists.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 
diff --git a/include/rkmtd.h b/include/rkmtd.h
index 145fede6c840..b7479036b397 100644
--- a/include/rkmtd.h
+++ b/include/rkmtd.h
@@ -10,9 +10,9 @@
 #ifndef __RKMTD__
 #define __RKMTD__
 
 #include <part_efi.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 #define LBA			64 + 512 + 33
 
 #define RK_TAG			0xFCDC8C3B
diff --git a/include/uuid.h b/include/u-boot/uuid.h
similarity index 100%
rename from include/uuid.h
rename to include/u-boot/uuid.h
diff --git a/lib/acpi/acpi_dp.c b/lib/acpi/acpi_dp.c
index 6733809986ae..5714acce0882 100644
--- a/lib/acpi/acpi_dp.c
+++ b/lib/acpi/acpi_dp.c
@@ -8,9 +8,9 @@
 
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <acpi/acpigen.h>
 #include <acpi/acpi_dp.h>
 #include <dm/acpi.h>
 
diff --git a/lib/acpi/acpigen.c b/lib/acpi/acpigen.c
index b95cabb91493..ecff5a50d504 100644
--- a/lib/acpi/acpigen.c
+++ b/lib/acpi/acpigen.c
@@ -9,9 +9,9 @@
 #define LOG_CATEGORY LOGC_ACPI
 
 #include <dm.h>
 #include <log.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
 #include <dm/acpi.h>
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 88332c3c910a..9b94a93ee4f1 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -16,9 +16,9 @@
 #include <errno.h>
 #include <init.h>
 #include <malloc.h>
 #include <sysreset.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm/global_data.h>
 #include <linux/err.h>
 #include <linux/types.h>
 #include <asm/global_data.h>
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index f3a2388506cc..a4ea28730387 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -19,9 +19,9 @@
 #include <mapmem.h>
 #include <sort.h>
 #include <sysreset.h>
 #include <asm/global_data.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 
 #include <crypto/pkcs7.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 0f684590f22a..9de3b95d073b 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -16,9 +16,9 @@
 #include <mmc.h>
 #include <nvme.h>
 #include <efi_loader.h>
 #include <part.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <asm-generic/unaligned.h>
 #include <linux/compat.h> /* U16_MAX */
 
 /* template END node: */
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index e888c52efe3e..f3533f4def3a 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -15,9 +15,9 @@
 #include <log.h>
 #include <malloc.h>
 #include <rtc.h>
 #include <search.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/compat.h>
 #include <u-boot/crc.h>
 #include <asm/sections.h>
diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index ccaba3f3115a..11b42a3d796c 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -9,9 +9,9 @@
 #include <fwu_mdata.h>
 #include <log.h>
 #include <malloc.h>
 #include <mtd.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <stdio.h>
 
 #include <dm/ofnode.h>
 
diff --git a/lib/uuid.c b/lib/uuid.c
index 272e07dc1613..17d1c4b4a186 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -28,9 +28,9 @@
 #endif
 #include <linux/types.h>
 #include <errno.h>
 #include <linux/kconfig.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <u-boot/sha1.h>
 
 #ifdef USE_HOSTCC
 /* polyfill hextoul to avoid pulling in strto.c */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index cfd1f1914edf..e5802866632e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -17,9 +17,9 @@
 #include <efi_loader.h>
 #include <div64.h>
 #include <hexdump.h>
 #include <stdarg.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <stdio.h>
 #include <vsprintf.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
diff --git a/net/bootp.c b/net/bootp.c
index 9dfb50749b49..512ab2ed7c81 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -14,9 +14,9 @@
 #include <efi_loader.h>
 #include <log.h>
 #include <net.h>
 #include <rand.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <linux/delay.h>
 #include <net/tftp.h>
 #include "bootp.h"
 #ifdef CONFIG_LED_STATUS
diff --git a/test/dm/acpi_dp.c b/test/dm/acpi_dp.c
index 87bd8ae6749b..fe3ffcb2f8bc 100644
--- a/test/dm/acpi_dp.c
+++ b/test/dm/acpi_dp.c
@@ -6,9 +6,9 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
 #include <dm.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <acpi/acpigen.h>
 #include <acpi/acpi_dp.h>
 #include <asm/unaligned.h>
 #include <dm/acpi.h>
diff --git a/test/dm/acpigen.c b/test/dm/acpigen.c
index 7113219792e6..7637ad0e312b 100644
--- a/test/dm/acpigen.c
+++ b/test/dm/acpigen.c
@@ -8,9 +8,9 @@
 
 #include <dm.h>
 #include <irq.h>
 #include <malloc.h>
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
 #include <asm/gpio.h>
diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 0914f2c47e77..9629d378c329 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -7,9 +7,9 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <uuid.h>
+#include <u-boot/uuid.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 

-- 
2.45.2

