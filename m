Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF8ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 08:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69A28656E;
	Sun, 15 Oct 2023 10:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="arVCFCex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076278071F; Sun, 15 Oct 2023 10:05:10 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CBA8071F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 10:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7740cedd4baso254931785a.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697357106; x=1697961906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVakoLi3eB/8GKxnsM8ZrVHl78GXQG5pyaTAhjbbx8I=;
 b=arVCFCex0H2TjumFkHmAgS1Ub0n0z+2pwF93F6nBMj/B1fwfxfHKlxmLHNL1SLe1SE
 ioIMDzmcsmDCiho8wI1jS5574cXgriTzyNNvvrtUJ5uDtlySa7yzeyNfbNyKIv263bg5
 Z2R7kx3EUteGbG8S3At7dY+9sY4t80VFxJO3B4SuQl8ln28li1ooaWiFaImMteHVI1CM
 mh9w0laR/muUyGQ6HxaQojG4yEdxXuBiDeUYrwPpNs+G1bivivPcZJLeeWprzRsuy3q4
 a1nFsAlgd1Top8IMMWdlEMQjivEn7Omzwqe1DXzpmMcyShXJMjkdLwEsAi3pHVkHOPch
 H7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697357106; x=1697961906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVakoLi3eB/8GKxnsM8ZrVHl78GXQG5pyaTAhjbbx8I=;
 b=W9LS/J5LTuUJ62MBZLJ8qh7Cx8X+9Goq3QwV/7+6mz68DjnauPgMuTMQvmsuOGV3zv
 nPMfMAshI2Gnq54n+QtB1wCGmgeRyO9raLEutGHbtH/DKs6VQp7LssoqNDJunbgMETZ4
 g/zZzoNH2BoZf9tXF8LGnFFVKw0yZgXO29zeJgkOtg3/K1dupf0euVCOyyi83zfGQ31C
 Mnjlv3yvgccElD6KGABFbjVMs3kjjVYN3feYTgXzmDErgpv4mppetq2VQ3ZXRWFCM8Np
 c+D321Im5M7G+ikNFCm4jlT0QSkzsSwK9SURjEr0rmOeMEKOimTVIoj1MJMikEccvJik
 6yQQ==
X-Gm-Message-State: AOJu0YwyLjyvUWcGy4SgFzfs4WEZE0yjV7K14oPx1cQVyIN4mPSlfah5
 F86qWSmPSG1wGnDX3sDBKlhp8pQOLj4+JQ==
X-Google-Smtp-Source: AGHT+IHpQHcs6Xh0q8FzSWCGhUn+kriQQIR4Rc8WUEheeDaSJQJAKndfh5nFSbgJEIIdHoLklQrwoA==
X-Received: by 2002:a05:620a:1239:b0:775:cb36:5ae1 with SMTP id
 v25-20020a05620a123900b00775cb365ae1mr29224242qkj.52.1697316497560; 
 Sat, 14 Oct 2023 13:48:17 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g18-20020ae9e112000000b007743360b3fasm1723167qkm.34.2023.10.14.13.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:17 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, uboot-imx@nxp.com,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 08/29] arm: imx: Check header before calling
 spl_load_imx_container
Date: Sat, 14 Oct 2023 16:47:44 -0400
Message-Id: <20231014204805.439009-9-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Make sure we have an IMX header before calling spl_load_imx_container,
since if we don't it will fail with -ENOENT. This allows us to fall back to
legacy/raw images if they are also enabled.

This is a functional change, one which likely should have been in place
from the start, but a functional change nonetheless. Previously, all
non-IMX8 images (except FITs without FIT_FULL) would be optimized out if
the only image load method enabled supported IMX8 images. With this change,
support for other image types now has an effect.

There are seven boards with SPL_LOAD_IMX_CONTAINER enabled: three with
SPL_BOOTROM_SUPPORT:

    imx93_11x11_evk_ld imx93_11x11_evk imx8ulp_evk

and four with SPL_MMC:

    deneb imx8qxp_mek giedi imx8qm_mek

All of these boards also have SPL_RAW_IMAGE_SUPPORT and
SPL_LEGACY_IMAGE_FORMAT enabled as well. However, none have FIT support
enabled. Of the six load methods affected by this patch, only SPL_MMC and
SPL_BOOTROM_SUPPORT are enabled with SPL_LOAD_IMX_CONTAINER.
spl_romapi_load_image_seekable does not support legacy or raw images, so
there is no growth. However, mmc_load_image_raw_sector does support loading
legacy/raw images. Since these images could not have been booted before, I
have disabled support for legacy/raw images on these four boards. This
reduces bloat from around 800 bytes to around 200.

There are no in-tree boards with SPL_LOAD_IMX_CONTAINER and AHAB_BOOT both
enabled, so we do not need to worry about potentially falling back to
legacy images in a secure boot scenario.

Future work could include merging imx_container.h with imx8image.h, since
they appear to define mostly the same structures.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Clarify commit message

 MAINTAINERS                                                  | 1 +
 arch/arm/include/asm/mach-imx/ahab.h                         | 2 +-
 arch/arm/mach-imx/cmd_dek.c                                  | 4 ++--
 arch/arm/mach-imx/ele_ahab.c                                 | 2 +-
 arch/arm/mach-imx/image-container.c                          | 2 +-
 arch/arm/mach-imx/imx8/ahab.c                                | 2 +-
 arch/arm/mach-imx/parse-container.c                          | 2 +-
 arch/arm/mach-imx/spl_imx_romapi.c                           | 5 +++--
 common/spl/spl_mmc.c                                         | 4 +++-
 common/spl/spl_nand.c                                        | 4 +++-
 common/spl/spl_nor.c                                         | 4 +++-
 common/spl/spl_spi.c                                         | 4 +++-
 configs/deneb_defconfig                                      | 2 ++
 configs/giedi_defconfig                                      | 2 ++
 configs/imx8qm_mek_defconfig                                 | 2 ++
 configs/imx8qxp_mek_defconfig                                | 2 ++
 drivers/usb/gadget/f_sdp.c                                   | 4 +++-
 .../include/asm/mach-imx/image.h => include/imx_container.h  | 0
 18 files changed, 34 insertions(+), 14 deletions(-)
 rename arch/arm/include/asm/mach-imx/image.h => include/imx_container.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d5d05320c0..35209e73af5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -300,6 +300,7 @@ F:	arch/arm/include/asm/mach-imx/
 F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	drivers/serial/serial_mxc.c
+F:	include/imx_container.h
 
 ARM HISILICON
 M:	Peter Griffin <peter.griffin@linaro.org>
diff --git a/arch/arm/include/asm/mach-imx/ahab.h b/arch/arm/include/asm/mach-imx/ahab.h
index 4222e3db278..4884f056251 100644
--- a/arch/arm/include/asm/mach-imx/ahab.h
+++ b/arch/arm/include/asm/mach-imx/ahab.h
@@ -6,7 +6,7 @@
 #ifndef __IMX_AHAB_H__
 #define __IMX_AHAB_H__
 
-#include <asm/mach-imx/image.h>
+#include <imx_container.h>
 
 int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length);
 int ahab_auth_release(void);
diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
index 6fa5b41fcd3..2f389dbe8df 100644
--- a/arch/arm/mach-imx/cmd_dek.c
+++ b/arch/arm/mach-imx/cmd_dek.c
@@ -18,12 +18,12 @@
 #include <mapmem.h>
 #include <tee.h>
 #ifdef CONFIG_IMX_SECO_DEK_ENCAP
+#include <imx_container.h>
 #include <firmware/imx/sci/sci.h>
-#include <asm/mach-imx/image.h>
 #endif
 #ifdef CONFIG_IMX_ELE_DEK_ENCAP
+#include <imx_container.h>
 #include <asm/mach-imx/ele_api.h>
-#include <asm/mach-imx/image.h>
 #endif
 
 #include <cpu_func.h>
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 6a1ad198f89..295c055ad0a 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -6,12 +6,12 @@
 #include <common.h>
 #include <command.h>
 #include <errno.h>
+#include <imx_container.h>
 #include <asm/io.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/sys_proto.h>
 #include <asm/arch-imx/cpu.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/image.h>
 #include <console.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index eff9e0c4597..ebc8021d7cc 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <errno.h>
+#include <imx_container.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/io.h>
@@ -12,7 +13,6 @@
 #include <spi_flash.h>
 #include <spl.h>
 #include <nand.h>
-#include <asm/mach-imx/image.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index 44ea63584aa..994becccefd 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <command.h>
 #include <errno.h>
+#include <imx_container.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -13,7 +14,6 @@
 #include <asm/mach-imx/sys_proto.h>
 #include <asm/arch-imx/cpu.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/image.h>
 #include <console.h>
 #include <cpu_func.h>
 #include "u-boot/sha256.h"
diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index d57f25df6dc..c29cb15f55e 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -7,9 +7,9 @@
 #include <common.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <imx_container.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/mach-imx/image.h>
 #ifdef CONFIG_AHAB_BOOT
 #include <asm/mach-imx/ahab.h>
 #endif
diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index b51061b987b..8816566b364 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -6,11 +6,11 @@
 #include <common.h>
 #include <errno.h>
 #include <image.h>
+#include <imx_container.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <spl.h>
-#include <asm/mach-imx/image.h>
 #include <asm/arch/sys_proto.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -111,7 +111,8 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 		load.read = spl_romapi_read_seekable;
 		load.priv = &pagesize;
 		return spl_load_simple_fit(spl_image, &load, offset / pagesize, header);
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
 		memset(&load, 0, sizeof(load));
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 02ad32a23e0..67c7ae34a58 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <mmc.h>
 #include <image.h>
+#include <imx_container.h>
 
 static int mmc_load_legacy(struct spl_image_info *spl_image,
 			   struct spl_boot_device *bootdev,
@@ -108,7 +109,8 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		load.bl_len = mmc->read_bl_len;
 		load.read = h_spl_load_read;
 		ret = spl_load_simple_fit(spl_image, &load, sector, header);
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
 		load.dev = mmc;
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 6cc34004f49..07916bedbb9 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <fdt_support.h>
 #include <image.h>
+#include <imx_container.h>
 #include <log.h>
 #include <spl.h>
 #include <asm/io.h>
@@ -99,7 +100,8 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
 		return spl_load_simple_fit(spl_image, &load, offset / bl_len, header);
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
 		load.dev = NULL;
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index c141a9ae629..dd447982071 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <image.h>
+#include <imx_container.h>
 #include <log.h>
 #include <spl.h>
 
@@ -102,7 +103,8 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 					   (void *)header);
 	}
 #endif
-	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+	    valid_container_hdr((void *)header)) {
 		load.bl_len = 1;
 		load.read = spl_nor_load_read;
 		return spl_load_imx_container(spl_image, &load,
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index d69069a75bf..1427c9478c0 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -10,6 +10,7 @@
 
 #include <common.h>
 #include <image.h>
+#include <imx_container.h>
 #include <log.h>
 #include <spi.h>
 #include <spi_flash.h>
@@ -153,7 +154,8 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			err = spl_load_simple_fit(spl_image, &load,
 						  payload_offs,
 						  header);
-		} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+		} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+			   valid_container_hdr((void *)header)) {
 			struct spl_load_info load;
 
 			load.dev = flash;
diff --git a/configs/deneb_defconfig b/configs/deneb_defconfig
index 82869e4e0f9..ee2478aa0bb 100644
--- a/configs/deneb_defconfig
+++ b/configs/deneb_defconfig
@@ -44,6 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x128000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
diff --git a/configs/giedi_defconfig b/configs/giedi_defconfig
index b56b736c436..5e403c90c8c 100644
--- a/configs/giedi_defconfig
+++ b/configs/giedi_defconfig
@@ -44,6 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x128000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index b9083b0453f..4c5206306ee 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -38,6 +38,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x128000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index f516b0b5557..f312d3945fb 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -38,6 +38,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x128000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 2b3a9c5fd4c..ee9384fb37e 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -34,6 +34,7 @@
 #include <spl.h>
 #include <image.h>
 #include <imximage.h>
+#include <imx_container.h>
 #include <watchdog.h>
 
 #define HID_REPORT_ID_MASK	0x000000ff
@@ -852,7 +853,8 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 				return SDP_EXIT;
 			}
 #endif
-			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
+			    valid_container_hdr((void *)header)) {
 				struct spl_load_info load;
 
 				load.dev = header;
diff --git a/arch/arm/include/asm/mach-imx/image.h b/include/imx_container.h
similarity index 100%
rename from arch/arm/include/asm/mach-imx/image.h
rename to include/imx_container.h
-- 
2.37.1

