Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5038C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9686888C06;
	Thu,  8 Aug 2024 18:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qbi455X2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D63688BC6; Thu,  8 Aug 2024 18:22:04 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C28088BE0
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so1319422a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134122; x=1723738922; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w/dklX1Qa1Xruwgki38Zq8q0sSCGTSBGNpQqJQvhWpU=;
 b=qbi455X22SNtutiVN3cN1p6oBRG2TPeGrSQh62Zf4On9eeYwjkEx1GT+/2BZPY2cI3
 6KIplWK4YmpK4tGYHt6PyihDv8Qg+YaT1a9kc+PtxRGUrvV+Bc4pD2iirgj/bY11CPdY
 qKZwjoWuz5iCIi7a+paAzVzKS133DYB3mClcOZK4uahGOphNkkXtScDwfewQvVpQuALY
 rAuFAQbVKbyLnwJj9roUoiRgt4NQ1k76cheY0pKzp9Fgdmmdc0I+Ss7D7gCz1QCvLjrN
 g9ozhWSpsJFtvx0HYo5VDR2vRIzJylJRRzbZG1Lrf7u4jPM7atY1qKIiLkkb9IdyKKHL
 /EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134122; x=1723738922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/dklX1Qa1Xruwgki38Zq8q0sSCGTSBGNpQqJQvhWpU=;
 b=vUdJeOrp4kBw6dcJxtM6/4yYdx25M/FhCrCj6qyjsw0LJcGcCI7Beyy0uxtpwaTxS7
 jUhHw7vjj+3hLY2hQdBOvReFamLVOvkUvM9no2e2LbmQi9TCfiP4RvSvzlo0on+dJto+
 D7JMHA4+sXhrJtAqpoX7oYdMIsxFTFzPZpNIQU6jlRe8gVZRQxO4mVRBJUDBsstZwfrE
 3JKvnFlBrQATJhvkWCRgTIE10DFlyCYIwIGG0an3gfj8MTusZvU79+5eYrd6+x6gQB2d
 PHWgSaeBTzQ4CsGN9ieXtdScwGhse2wITDfpIWuuis9XahqXlKPvcPg1lpZqENYk5Rr2
 4nXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTw8S2NzhKDMgBvLEfHBtV91BEh2dzt67QC07FAphi+iYMV6SIgsluiYc+P3HU07ySRfuVmFg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz++wDZeRq+1lMKBukB9BwEP4zfmPkBIzfp1+5n/THoGR3GnhoM
 U8Bc+X5HXoMH9Y8+4SWTdDnCKvGRhegjQJv69AwCz3uSw8ueDIj6kNpsVSaD35w=
X-Google-Smtp-Source: AGHT+IH7SdCsQggdb0JrA4Butv4qTZQamImcN4c+QxGzMD1noADWokVVcv0TvkfMXqxCD45c9Xw+Lw==
X-Received: by 2002:a05:6402:510c:b0:5a3:8c9:3c1d with SMTP id
 4fb4d7f45d1cf-5bbb2231273mr1897830a12.14.1723134121732; 
 Thu, 08 Aug 2024 09:22:01 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:22:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:54 +0200
Subject: [PATCH v6 07/11] include: export uuid.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-7-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15788;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=G5fQCMrNXIS194tzHM7pmcoCrLiEsM5R5f+J56yyTS8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCf87fieKx4VhnHrLa35fXu2dEIMoeIdjtos
 JqrpaPmyamJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwnwAKCRAFgzErGV9k
 trJUD/9VyQZ/mW3nDYUEkmTEfKVXHpVPKnIjRY7hQWlH3V3VlkwwQ+Tkxj+js9YvFrNrGnyE9wk
 0Qvau75EJyY0fsIGfdjs/PmlTrN8EL0eFkGpDpJk1mveT1qG4RK/2JnaI7EJRgj9fqfw3DU+j64
 LO49shDtmJxMYLaJh++2WETOxsUThCrF3tSHvTnUfqy1eKYIPrX06lbODjlaX8HY68uduMKUlRy
 nk2Vv/dNNArrU8SXk+ccBrA2YS21P72JIGHPAiLjcpuz6oe8LZ91tYrcM+JkWSLb2taB1MvuWgq
 oTvYTwJocSzxT72j/1i4aRTLkgMZF0M0w6koFDPX8xSWw9ok2AMD+ZRNG4y4EG3aLcl65V/Yai7
 fKrLriftBUyTGXJU+asY8fxTRd81Jzort3AOERA63AaozZh5vMoPwOmr5xl9vcbVryypmmN40Fc
 UzMCGGC+KUE25Kol4B/PWWAijDbkZcd8Bg/v6AyiAnDgFsiPkL1hYySdSn6ADuG3xOQlyrieZzd
 Sfh1c2pIzVg+Mrlt3+UY3mcY+cZ81KdOd0NuBJsK7tLVT1UW9E00dqDsXAKrj74ktvS0t/EKFyn
 cyxcD9iORkj+PGPDQKmXxHAjiTwg8Dig1ssv2sBZ4EXs5KvqYpS4Nul7cuBxE6HYD9n6oxf26Sf
 kT2HynyCEBs4PuQ==
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
index 616842e62f4e..f16f2f1184f3 100644
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
index 25805393199e..54dc50ce2c1a 100644
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
index 84277cf67ece..ed920e0d9476 100644
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
2.46.0

