Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB1ECA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED7188C4D;
	Fri, 30 Aug 2024 14:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lyyL1l4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D1E88C53; Fri, 30 Aug 2024 14:34:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3861F88C3F
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428e3129851so15765865e9.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021283; x=1725626083; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0CN5w97ylaw/CErONqtMmnfNAjTTm3YPDAwnAvBicuY=;
 b=lyyL1l4TvijRYrhq+xGFhDMXuIa6Hkd8cGpwpozqKrjnCmrfP3NeLiHvMGUsZ46ivJ
 lMWjV40yDSMAVYr7drknSawBpoVyd3dRoeRoE/HFwJBNiwFTzccPCLxPNPYkHXSaJJRz
 RFo6NQb5zrQZtHreF+DLvA/wzdoKb3Wq/9KoED3Iod4TJbfxwHKOgDYEFl3nzFf/DE98
 BgXaydoHheJwLlwNSa/wT028/wMWczT63UCDaTDih6lefiLG/eFn57W8GeXKWmVMbj0v
 kDIGI0Avp2/i64U9ccDVe//lMIZJnsetPLtHWltZ9+4apCJo/VpCgHFLvXKK0NubcELI
 qndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021283; x=1725626083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CN5w97ylaw/CErONqtMmnfNAjTTm3YPDAwnAvBicuY=;
 b=UjidwXQYaJbEaX40X20Wc/D/nlY6nL3kzgS10g760/Q0M9wjj0zki4R8tPuQlErwxi
 rzZhUYwttsbNeyVpwb5FYurekRJ1jgkNia7mfoQbkROL0lX255dDXf10EtJiik27+xiN
 kcwPXfRn9ts4SdN6K2DqffkUysvlP6RwwLaa3Cwlbxt+ve4tQgeEnMXXcnzPJdIfz3bL
 gwcmR63DWF/zTfWrn3EJXVD+xHAMbC8O6G7s+Pse423VmFG1GJdLxyAEXdpZjne4fCqx
 NlxNq5wI2SEBeKb+h/NzpQbnW5aAQZZ1Xd38uP2Dd3iZykTmoDDzjFgJOFgif7+sDqO9
 iEFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAEHh71eIN/w6FBmG2Hr+yL9Px4/XdNv9vJkFZLGG2YxDGuZMcx2uDj/eO+A5vRe+iQEhE/G0=@lists.denx.de
X-Gm-Message-State: AOJu0YywvCyzCvcsb/ILuG/o2bDMCBtuWd6sRTFNzyCHJOHukiXicIR0
 VejiASyjOPzwEKYL1YT30GPPGisMo372x50W4H211slmYQdjo0KlH9mwkyV7ulc=
X-Google-Smtp-Source: AGHT+IGdda9ua4VTwyDtETai9/e9aDobIE1H9TZ+dleoH69HCJ/e2shv9N8px6I0az32XiJkw+5rcw==
X-Received: by 2002:adf:b312:0:b0:371:82bc:7d93 with SMTP id
 ffacd0b85a97d-3749b526ec0mr4107056f8f.12.1725021282553; 
 Fri, 30 Aug 2024 05:34:42 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:37 +0100
Subject: [PATCH v8 07/11] include: export uuid.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-7-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
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
 bh=FcNtT1+wvv1lmD+dZOOogYZ0xKDMTXJuq72DJrRw0Ao=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGbRvFmhXyyFh1cFoOUQgCMqOEBdiIvs5zof1pwIpR9707i7p
 YkCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJm0bxZAAoJEAWDMSsZX2S2neMP/AnR
 2UpVu2px5E31RZsefRM9SnnewLOF+4yk23SkaPxUXp6IZprJ1hFHGTxw+9JCnyiyo8BAQ0jrEeR
 sPKj0sTwyf7bRTYAA7sRfDOQ6EIeiqfH4hppf/tX4ONktR+JaSje/AxWgsU8W2rwQfhJOyhaMDu
 5R9bf/kPW3z6wwtcbcJLfcconENHnqmSHJ78X0PXJKvgxSBIEFSFICvTQ3qOrABasbKTGL89VC2
 v+3KRJ5k2N5S49U92VgGRUnvbbqxOZkTZfdbBGWX09bD8jalaN0DTmvcDdg8KETdrows4tMd/SU
 cUrh1XGnge60bNWtjJS9u2rlHfIEWfCxJQV+jlbZA6ToyoQl7OouXmCHTqEKUnnEaW8L40ifhes
 GVd72pXQ+8vLekL3x6bdQ1P/nndmqgh89zepwM0nASfIvqOeoYYB9gSlzD4qooChE5qv3ATdWUm
 NXVCTpeMlfsV2s6saVfh5WZFH5cibhjz2wgcHC/CNpX/gI/HvGmOWj8uCKU3K50hkWiMdtnEUZ0
 WS1JtSTpKbjDsb69fXE4QQfZfhR3FJYBM5ObZzY5F6d+8cAS/7vXDxPy/Viy/n0ME0kjAxqqt3i
 WlFri0ytVQ9wDVegVaqlwe46cR0L2Lnkbm0iIKG9+3vGhZhlvAJOyWhmxGscBJDv/InpGROcxwT
 JjBiN
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
index b1a03bd165e0..580821a6ee9c 100644
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
index 906b85b0db44..21ac0c202e73 100644
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
index 54b986cee631..797b542ef1ff 100644
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
index 6fdae7997702..11b86ffb02e6 100644
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
index eaeda2b8a7af..038806004b55 100644
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
index 3e912fadaef8..23c16bd98669 100644
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
index 8fe65dbf78ba..3d62e18bcfee 100644
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

