Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3262FC54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F1A83061;
	Thu, 22 May 2025 01:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ANyuh/Mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAA98305C; Thu, 22 May 2025 01:01:51 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F8D83010
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6062e41916dso4241988eaf.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868506; x=1748473306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pGc9Kw+6LRa3sCOKGfKVOOnAeHj4CrcTHoF2vAXP6Gs=;
 b=ANyuh/Mko1IKymJubRocslXdAReTbUd1dxQ1IRuPB4P34ee0SggQdD9+11Xoo3dnVd
 /n/M+dijpvy26zIoQQnJ4wTw43NhCnU6Bn0TR6UQU9cbuBCdfJcrg7V7hFOwq8g657Zo
 Fa9cndbHkxn1QvFHPEExJVCSZoJ7gtl2h9A4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868506; x=1748473306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGc9Kw+6LRa3sCOKGfKVOOnAeHj4CrcTHoF2vAXP6Gs=;
 b=RSxQpltNQ5gc1GwVzpobVz6TZnRrHi+Y3SfdWthXMY1orlamErQ+NtJVpQO1sMvJVO
 5B1+X25ECotW4YHclDFA7vT7cEA4od2bfIqdUWL4jGmnSq0wI7W7CvF7mYOfvZrOMt1B
 tSLkwYCAmW04jkIep55411W2wlkBsFOzNMsMCiahx0u01jV8aEmf7jgpo24ZjXHmZiv4
 iTFj7u2BlMib2EHKYf2MGdUFadjbE0mG41uezSvZZauCja8DT2XwjVFFJgMR2ToqaZpr
 5ai0wKkhVr7Ut5gx3pcmZWD8UmAGRgmCoTU/0nK61/lqWlvWsoEw+WWJ2s90JEmlSbuA
 NSWg==
X-Gm-Message-State: AOJu0YyNVnr3Wo6PE7UlEy6tiWYbxKpc6nyxKC6kayxs06nG2a4I7EJ8
 LGoZRn7i4yP9NpyrB9ZM3uOXBrYLXfRXVKomXCWuCMIofTHiRiML+Ggbwwv2XzmCisU1N5zJLac
 19wJXeGk=
X-Gm-Gg: ASbGncs+MaskTMMbCJAR2q8tj45/NErOZd9KZJKt1UCgUYAinMW8OFXT6zumGiiXTn7
 j6p3RPlNn+OABmC02CDYPchIxH3xx5uFSK3jA2NpaomdD4vAiZVQ17hjh8WzgBQ5qhVyArGBRMI
 krMsTxuUyURmZBATt+Li0ndBa20Dfz8ZMIJq/fE93HxHD8MJpZhyu+uDMAy2JurGMIIN85mWWAr
 aGh/K9PP8HPHo5EBzOeerY0LfFM/4nzJlEaEKJRgbijAdp3dhDEZOxXB8kNVW2f25uW1Oon/NI9
 f5qUpXBs2of7jrB9iOxIWoa2A3jIGt81+wXnCTwGToHLlyh0FIPB/XbhjlnI9OrVzNPDXWsvQSn
 jvGXfwKtpekoYynI=
X-Google-Smtp-Source: AGHT+IGm4YsBDlhWjBJPp4Bg1N3eBdJ3RlJdoUe89v/p4R+g0tpmm+Vslupe6TbsY+dZMtTSnOOyrQ==
X-Received: by 2002:a05:6820:a09:b0:60a:bee:497a with SMTP id
 006d021491bc7-60a0bee49fcmr8297834eaf.2.1747868506530; 
 Wed, 21 May 2025 16:01:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 16/17] include/mtd.h: Cleanup usage
Date: Wed, 21 May 2025 16:51:21 -0600
Message-ID: <20250521230119.2084088-17-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

There are only a few things found in <mtd.h> today. Go through and audit
the C files which include <mtd.h> and remove it when not required. Then,
add it to the files which had either missed it or had an indirect
inclusion of it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 1 +
 board/bosch/guardian/board.c                    | 1 -
 board/dhelectronics/dh_stm32mp1/board.c         | 1 -
 board/isee/igep00x0/igep00x0.c                  | 1 +
 board/xilinx/zynqmp/zynqmp.c                    | 1 +
 cmd/legacy-mtd-utils.c                          | 1 -
 cmd/mtdparts.c                                  | 1 +
 drivers/fwu-mdata/raw_mtd.c                     | 1 +
 drivers/mtd/altera_qspi.c                       | 2 +-
 drivers/mtd/renesas_rpc_hf.c                    | 1 -
 include/fwu.h                                   | 1 -
 lib/fwu_updates/fwu_v1.c                        | 1 +
 lib/fwu_updates/fwu_v2.c                        | 1 +
 13 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
index 5b027fad0482..9acbc0689a92 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <misc.h>
 #include <mmc.h>
+#include <mtd.h>
 #include <part.h>
 #include <tee.h>
 #include <asm/arch/stm32mp1_smc.h>
diff --git a/board/bosch/guardian/board.c b/board/bosch/guardian/board.c
index 33ba7a7751ce..ebbae27c0f9a 100644
--- a/board/bosch/guardian/board.c
+++ b/board/bosch/guardian/board.c
@@ -32,7 +32,6 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <jffs2/load_kernel.h>
-#include <mtd.h>
 #include <nand.h>
 #include <video.h>
 #include <video_console.h>
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index d30171f1fbe5..f7347bbb826f 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -27,7 +27,6 @@
 #include <led.h>
 #include <memalign.h>
 #include <misc.h>
-#include <mtd.h>
 #include <mtd_node.h>
 #include <netdev.h>
 #include <phy.h>
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index a35a7cd3b1f7..c21b083b62a2 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -7,6 +7,7 @@
 #include <env.h>
 #include <init.h>
 #include <malloc.h>
+#include <mtd.h>
 #include <net.h>
 #include <status_led.h>
 #include <dm.h>
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 735ef3cd1bea..789b945d4623 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -14,6 +14,7 @@
 #include <efi_loader.h>
 #include <init.h>
 #include <log.h>
+#include <mtd.h>
 #include <net.h>
 #include <sata.h>
 #include <ahci.h>
diff --git a/cmd/legacy-mtd-utils.c b/cmd/legacy-mtd-utils.c
index 1a5271000bf3..34a6da019473 100644
--- a/cmd/legacy-mtd-utils.c
+++ b/cmd/legacy-mtd-utils.c
@@ -4,7 +4,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/string.h>
-#include <mtd.h>
 
 static int get_part(const char *partname, int *idx, loff_t *off, loff_t *size,
 	     loff_t *maxsize, int devtype)
diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index a021b2d198d1..571b79f091d7 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -74,6 +74,7 @@
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
+#include <mtd.h>
 #include <asm/global_data.h>
 #include <jffs2/load_kernel.h>
 #include <linux/list.h>
diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index 78a709f766c8..41c153038ab2 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -8,6 +8,7 @@
 #include <fwu.h>
 #include <fwu_mdata.h>
 #include <memalign.h>
+#include <mtd.h>
 
 #include <linux/errno.h>
 #include <linux/types.h>
diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
index e5c8df750b7f..46174aab3492 100644
--- a/drivers/mtd/altera_qspi.c
+++ b/drivers/mtd/altera_qspi.c
@@ -9,10 +9,10 @@
 #include <fdt_support.h>
 #include <flash.h>
 #include <log.h>
-#include <mtd.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/mtd/mtd.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 50a6191d9c2c..9390c9e9ab34 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <fdt_support.h>
 #include <flash.h>
-#include <mtd.h>
 #include <wait_bit.h>
 #include <linux/bitops.h>
 #include <mtd/cfi_flash.h>
diff --git a/include/fwu.h b/include/fwu.h
index 6441de370c91..77e60167fc7d 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -9,7 +9,6 @@
 #include <blk.h>
 #include <efi.h>
 #include <fwu_mdata.h>
-#include <mtd.h>
 #include <u-boot/uuid.h>
 
 #include <linux/types.h>
diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
index c311a8857a60..974abf216f6f 100644
--- a/lib/fwu_updates/fwu_v1.c
+++ b/lib/fwu_updates/fwu_v1.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2024, Linaro Limited
  */
 
+#include <errno.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
 
diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index ce46904ff2ec..159315b45b98 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2024, Linaro Limited
  */
 
+#include <errno.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
 #include <log.h>
-- 
2.43.0

