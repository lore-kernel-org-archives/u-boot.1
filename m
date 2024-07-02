Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21E9C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533A088729;
	Tue,  2 Jul 2024 15:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O8MAHj8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0C0886FD; Tue,  2 Jul 2024 15:30:55 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852FD88730
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a729d9d7086so824467166b.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927053; x=1720531853; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UMZNQLIxkLDQlOwgeDd47anWZHxKsgk2gbcJMAISzOQ=;
 b=O8MAHj8Xcuy8wM50eBA/hId9oJHATs6rJvUHBwMtc6Q3dVhcjSQAFBon1kgWqEAHx7
 EoAHviuk6qtgr2CHbG3bHgQ3r/6KDTbYQZcb9lyMAabFEQo0P34V4gYzZYC+i/Y8gHtS
 eT74q3qSNDwpAgGQM4TrOaNfupe4q38/68Y88QU0JGjZT3EFk4n4lJArymWtaiKRGdgd
 5sl1oQHYqV58/MtheEsGoJftQVRFcCnPHepsA2Vr2Pdmlmd9xQM5GtUA8gAKBBK1mE2T
 CoNdaD3GBSdtJcwfG9kIL91hjyYKHR+SIk6JH9Mb0wuNSQ9sofm2v/al0cEgnk3ReOKP
 pVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927053; x=1720531853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMZNQLIxkLDQlOwgeDd47anWZHxKsgk2gbcJMAISzOQ=;
 b=l1QbzxmjTRVUJZ032jraB9Fnu5dxXQiLqMev0pjFmF5lbEzFjDLA+7iJRxM9OydSAq
 Nbh995/akHknoEPQDEKZtyYGmp6qwPsp0g+9qcqSa2WW0Q2/xKDMRXqttCqJIGsbjrhT
 KMs8v87zDyjIX9+pJxgC2s8Y/S3/qrCwNoV2X4yHi9U5cKQrBWumB6B2pCWelZ63N9JB
 3h1w6JPgJ3Xk23ZpV4VkDst+a1KowdLgzKk04Zdy2NIZzqkDb9zRvCE6H0kDZwLhB0ka
 RvvtSUodBVC/Fm/EmpMtdwyt5walWJU20pOSfLitgL6RGo0h2LOWwiSP4JOmIIoEVyIv
 PTFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoKhHjhPQ7yokNw37Jn004f8w1LaksE3lxoVO7C7CNYYsmQbcahd5XCe0Nzsmx7U1ZCRuSb/nOPeMd2R8CvSEGrz+kiA==
X-Gm-Message-State: AOJu0YzKxK+R9veYwvWc3CJY4Wj0SVaQFOm6d7JRX2Ob2f3MSL3Jqa+N
 hXskR/n9zhoakfMEURmriS0Q2pwczIIja57PHgJDA5QVP9WmXWfm9pYmj+moqyY=
X-Google-Smtp-Source: AGHT+IG0cW3ITNdENGBTkLGj8b/0RUJ4neLpdDzZJNNo+sguQzTPyjMPb8XBHuONi8dVHkDOXA4AMQ==
X-Received: by 2002:a17:907:70a:b0:a72:634d:d843 with SMTP id
 a640c23a62f3a-a7513954ddfmr789597066b.34.1719927052813; 
 Tue, 02 Jul 2024 06:30:52 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:47 +0200
Subject: [PATCH v4 07/10] include: export uuid.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-7-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
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
 bh=JxHRkZy037e6RpWqgqKaco9xK0TZR5Qw5ZARyJiq3rs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAECT5Adf2cl1voriN68hITKpQ2zcNsUQmqLZ
 EDivgG8INCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 tqg0EACd5EOTRTjwuUfWSgkk2tf3X539fjypXgTaznkyl9o+dwtZEQp1MaKh5H2GeQmSAlxSCkT
 6CwqRLj4iEi52BagrErJfD8XR5UEBOK7VOXrvJxThf75kDDiBIhXtpkjh//WJS88PmAnrofQ23n
 d20w1S0emGvT3zHSz2LFtwjGH5MPYmz6dZyhKm1E5lxDf6VII8eN9jl25TfaPM72TyZC4Xa1G1Z
 I7HT8mInxiZR0LTqIhDlQUbV4Z25uPAE64jnlKHbR9wjeXUn04UAMeqmsVgJW/WC5K55bPZItsp
 ZbJFfwgbxXED6yc2EL9gc9pHnUIjwx4HfbfMHH7IoomL6GAqKfUtjdS0pWoXvlc2+LhEYFTa+sE
 DzhMIVh+G61dnhksycO/RsImyrNsuO7ODMbKB4Eb2AozAVSiGnppjEsbWRjDU8v+k1+Hh9xHhb+
 IMBvVqmriqfuzaQWph6XkRxHvrWEBEnvAf3MxZq0S+USAzs0aKZxe6034+0DC/8Zt/7JoADKijU
 4u3MvUA2l0x+mSe9uk4+6OhG6Dn+1L08mDbM6TLivx8upWoRkcl6rISrwN8xtYkRqqI1kdu6Gz6
 pd6APUdnoOBPjjhfKbuYojBP7vLEOA1dwbKGo94AUB89zbDapQlw0JRJRQWYrw73hXCGIbzTkai
 zLFL5cfFET6gmPQ==
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
index 30a81376ac41..e11141b94260 100644
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
index 36b112d59784..be040d7f94a6 100644
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
index e5bfaf461c2b..8dac7c57cd30 100644
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
index ac02e79ae7d8..d482eac81b25 100644
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
index 1cc02acb3b26..4d906acd56af 100644
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

