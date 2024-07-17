Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE25C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 04:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6B58863C;
	Wed, 17 Jul 2024 06:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B604388A1B; Wed, 17 Jul 2024 06:47:54 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED49F8859C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 06:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 46H4lao7020657; Wed, 17 Jul 2024 13:47:37 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 andy.yan@rock-chips.com, gajjar04akash@gmail.com, jonas@kwiboo.se,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v3 1/3] configs: rockchip: reduce diff for rk3308, rk3328,
 rk3399, rk3568, and rk3588
Date: Wed, 17 Jul 2024 13:47:24 +0900
Message-ID: <20240717044726.59721-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

this is cosmetic change. no functional change is intended.

- remove redundant white spaces
- replace white spaces with tab
- align position of last letter/word
- sort lines in CFG_EXTRA_ENV_SETTINGS
- add comment after #endif

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v3:
- add missing separator in commit message
- collect R-b tag
Changes in v2:
- rewrite whole commit message
---
 include/configs/rk3308_common.h | 26 ++++++++++-----------
 include/configs/rk3328_common.h | 28 +++++++++++------------
 include/configs/rk3399_common.h | 40 ++++++++++++++++-----------------
 include/configs/rk3568_common.h | 14 ++++++------
 include/configs/rk3588_common.h | 12 +++++-----
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
index 861154fbeb..80113220e4 100644
--- a/include/configs/rk3308_common.h
+++ b/include/configs/rk3308_common.h
@@ -8,24 +8,24 @@
 
 #include "rockchip-common.h"
 
-#define CFG_IRAM_BASE		0xfff80000
+#define CFG_IRAM_BASE			0xfff80000
 
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xff000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x00500000\0" \
-	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x03e00000\0" \
-	"fdtoverlay_addr_r=0x03f00000\0" \
-	"kernel_addr_r=0x00680000\0" \
+#define ENV_MEM_LAYOUT_SETTINGS		\
+	"scriptaddr=0x00500000\0"	\
+	"pxefile_addr_r=0x00600000\0"	\
+	"fdt_addr_r=0x03e00000\0"	\
+	"fdtoverlay_addr_r=0x03f00000\0"	\
+	"kernel_addr_r=0x00680000\0"	\
 	"ramdisk_addr_r=0x04000000\0"
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	ENV_MEM_LAYOUT_SETTINGS \
-	"partitions=" PARTS_DEFAULT \
-	ROCKCHIP_DEVICE_SETTINGS \
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	"partitions=" PARTS_DEFAULT	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
-#endif
+#endif /* __CONFIG_RK3308_COMMON_H */
diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
index 2c40674b22..f9e6634c5f 100644
--- a/include/configs/rk3328_common.h
+++ b/include/configs/rk3328_common.h
@@ -8,25 +8,25 @@
 
 #include "rockchip-common.h"
 
-#define CFG_IRAM_BASE		0xff090000
+#define CFG_IRAM_BASE			0xff090000
 
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xff000000
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x00500000\0" \
-	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x01f00000\0" \
-	"kernel_addr_r=0x02080000\0" \
-	"ramdisk_addr_r=0x06000000\0" \
-	"kernel_comp_addr_r=0x08000000\0" \
+#define ENV_MEM_LAYOUT_SETTINGS		\
+	"scriptaddr=0x00500000\0"	\
+	"pxefile_addr_r=0x00600000\0"	\
+	"fdt_addr_r=0x01f00000\0"	\
+	"kernel_addr_r=0x02080000\0"	\
+	"ramdisk_addr_r=0x06000000\0"	\
+	"kernel_comp_addr_r=0x08000000\0"	\
 	"kernel_comp_size=0x2000000\0"
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	ENV_MEM_LAYOUT_SETTINGS \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"partitions=" PARTS_DEFAULT \
-	ROCKCHIP_DEVICE_SETTINGS \
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	"partitions=" PARTS_DEFAULT	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
-#endif
+#endif /* __CONFIG_RK3328_COMMON_H */
diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index 4e75771055..62007c8b27 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -8,36 +8,36 @@
 
 #include "rockchip-common.h"
 
-#define CFG_IRAM_BASE		0xff8c0000
+#define CFG_IRAM_BASE			0xff8c0000
 
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf8000000
 
 #ifndef CONFIG_SPL_BUILD
 
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"scriptaddr=0x00500000\0" \
-	"script_offset_f=0xffe000\0" \
-	"script_size_f=0x2000\0" \
-	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x01f00000\0" \
-	"fdtoverlay_addr_r=0x02000000\0" \
-	"kernel_addr_r=0x02080000\0" \
-	"ramdisk_addr_r=0x06000000\0" \
-	"kernel_comp_addr_r=0x08000000\0" \
-	"kernel_comp_size=0x2000000\0"
-
 #ifndef ROCKCHIP_DEVICE_SETTINGS
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	ENV_MEM_LAYOUT_SETTINGS \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"partitions=" PARTS_DEFAULT \
-	ROCKCHIP_DEVICE_SETTINGS \
+#define ENV_MEM_LAYOUT_SETTINGS		\
+	"scriptaddr=0x00500000\0"	\
+	"script_offset_f=0xffe000\0"	\
+	"script_size_f=0x2000\0"	\
+	"pxefile_addr_r=0x00600000\0"	\
+	"fdt_addr_r=0x01f00000\0"	\
+	"fdtoverlay_addr_r=0x02000000\0"	\
+	"kernel_addr_r=0x02080000\0"	\
+	"ramdisk_addr_r=0x06000000\0"	\
+	"kernel_comp_addr_r=0x08000000\0"	\
+	"kernel_comp_size=0x2000000\0"
+
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	"partitions=" PARTS_DEFAULT	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
-#endif
+#endif /* CONFIG_SPL_BUILD */
 
-#endif
+#endif /* __CONFIG_RK3399_COMMON_H */
diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
index 48f93083de..09b7b71c6a 100644
--- a/include/configs/rk3568_common.h
+++ b/include/configs/rk3568_common.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier:     GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
@@ -10,7 +10,7 @@
 
 #include "rockchip-common.h"
 
-#define CFG_IRAM_BASE		0xfdcc0000
+#define CFG_IRAM_BASE			0xfdcc0000
 
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf0000000
@@ -28,10 +28,10 @@
 	"kernel_comp_size=0x8000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS		\
-	ENV_MEM_LAYOUT_SETTINGS			\
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"partitions=" PARTS_DEFAULT		\
-	ROCKCHIP_DEVICE_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	"partitions=" PARTS_DEFAULT	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
-#endif
+#endif /* __CONFIG_RK3568_COMMON_H */
diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
index 70430612ef..e6654c275a 100644
--- a/include/configs/rk3588_common.h
+++ b/include/configs/rk3588_common.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier:     GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
@@ -26,11 +26,11 @@
 	"ramdisk_addr_r=0x12180000\0"	\
 	"kernel_comp_size=0x8000000\0"
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"partitions=" PARTS_DEFAULT		\
-	ENV_MEM_LAYOUT_SETTINGS			\
-	ROCKCHIP_DEVICE_SETTINGS \
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
+	"partitions=" PARTS_DEFAULT	\
+	ENV_MEM_LAYOUT_SETTINGS		\
+	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
 #endif /* __CONFIG_RK3588_COMMON_H */
-- 
2.43.0

