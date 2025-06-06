Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD03C5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B6382AAF;
	Fri,  6 Jun 2025 11:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gCyEjFm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDC382ADA; Fri,  6 Jun 2025 11:33:15 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E180982ADA
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so966551f8f.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749202392; x=1749807192; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xWgWJ3EmulB0xqoNRZUrGW3JTHhPF1wM/EEGqrw9zyU=;
 b=gCyEjFm6E/grMhcJ9CmEagJOQUldfS3/bHqCDGy0sTcaLxt+Qkclxe9yKGV1inNgeC
 pAajiIRYvG6VWQ+TIWcMMp1+HJXOYwrGkZwgfpRhDiMqWRkCaxlU47a6Xf1kvh5YeJtO
 IsbPpGwvH/SV+JqLaG5x11Hao6lKGpQllmOdNxP+tQTTA/8Lh73NLKXmPE1FdcusNhha
 BeQwP3muIbz3abZjxMMZbJtEEivgBljpR6t8kIj7EpbTmuQhfU/HMUwVU09FrjUmfLuq
 2be+pefoh2Nohv3f+7VjyiP0rwnlOWYZytiraWwuu7F/sewkafPW41qztdKoUflgbayW
 bfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202392; x=1749807192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWgWJ3EmulB0xqoNRZUrGW3JTHhPF1wM/EEGqrw9zyU=;
 b=BT9SoFrM3vUhbkq68db2O4Wok5/+0xFXona0X2+r+qjmUMqlsUxDZYmwuwQq1tSkBU
 ssULMprEALD0B1zmL6VeMP4nWWkYN7PKucqhUpCG1xuSyPsDqdNAr1SV5n1d2O5aL6ZV
 tTJ9YMHs7bjiEFfuGbUIa52vgSrXCjmqN/z6+4jamwWiu5b7Z6OzX0lCJbAvr/C4U/xi
 /NxQnUBejjcfzxpzj+xHxjGI+3iUAlHfch70ApL4XZcitIQyRNKqT6ma31vh6ApDJzdq
 QCORGlZMlzdCbiRahmL/jhGL35rE92TSKdpYtcQ4VL5vF0A2sfZa2o77Ogb14lY1HV3n
 YjQg==
X-Gm-Message-State: AOJu0YxWpKh77whClYwrGLItvS9wQwJfyckAfNs3I4G+/1UvOQkTnXym
 VRGSFJcXvySZoJfnh36yZK3Cji4ObVqSiQB68aakU9qMhGUlNcJTuxW7dEG4uz0M+JA=
X-Gm-Gg: ASbGnct6u07QkQPjzgDu67X6VMwde3Q+/I0jqM2M32gqhLa89d2mwRCnU3I/6GFXO6c
 6yQaoetuXRnCuqreF5Hew9QkfrXOOMF7zX5iCcfz1q+PGgOOGOUSkqhuFzpfeZ78JbKSVA7a28g
 mAZs+fz3ORQH/EbAHyRUTeZbbvMZFBr2LI4Ka4JR6NCTvIAMfEixwjaUxI3DHB1f06Khz2oDu06
 BsP54WIQASjHpD5MIOp/VLATKzS9bh/lT1dsSLSNsTh7SWpHApkyyH1D9NMpIw40iEk+4eODkmN
 AsZJth6gv/a03t6PzCLDYJ6MiZzq1yUq4ejlU0xTmFPsB/khPgj8ud5YBxMwBZQ646rdgBI4
X-Google-Smtp-Source: AGHT+IEVxkmDWpE99WgxFkOqdjB2tBVFivTawJqEPL4dRRlX4koZCeZXMMgNga8SL7phllNExMoEkA==
X-Received: by 2002:a05:6000:1786:b0:3a4:d452:fff with SMTP id
 ffacd0b85a97d-3a5318837d3mr2320036f8f.17.1749202392295; 
 Fri, 06 Jun 2025 02:33:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532452d7esm1302439f8f.85.2025.06.06.02.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 02:33:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Jun 2025 11:33:09 +0200
Subject: [PATCH RFT v5 3/3] fastboot: integrate block flashing back-end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-topic-fastboot-blk-v5-3-203538ec5b32@linaro.org>
References: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
In-Reply-To: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7403;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=y6qvaiEMUchMXQgKuNyGVteFx7uQoBYQun68FGcztHk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoQrXVMitMq0QXQzo2iO286ByGDCE9XyXGkpN8+l4n
 eVUOmxKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaEK11QAKCRB33NvayMhJ0dHaD/
 0es+CySRg9CSxyWmNRka487AfFFORsUsy6kSYZLPiH8cewyCZjIERl3VfC7cjb1wiM+5HTNgvJ/S0V
 x2K5pT8sqxyd/C1rzw0IgrLUm0En75RcSxslHAlns+qYiL9xVWN9F+VWU7i9Ys0YVyZMqamGD1NAZL
 4qrkKLD8R7pfSN+qoSQbBUA4E5XKF/ILoKeO7NhP83kwRAVH2kiTnDR8xip6IGc4P47xPqqS6jdNja
 h93MKP4xGXNEkdDkKXxW+SreWFtLz6ZmLbQ/+9AaUobgndeIKrN5117n+X136yEIM5nRx6ySuCLeMv
 h4D7Rx9Upvz1qqkakqrEC7Q/YR7/AUDfhF4Xz/jtBgQmBDcAyKA+h6C+ep6XhpQjw/fN5ghXcCMT2/
 tzcGQgeeNoeknxWLxcfGEQBuNBkR1pse1tQeFz0NO08elj7KWSWL7IwAqVjBv0WvRROQmp1cD9N/jg
 6yV3Fi62GA00oQhsiHdv9RfpflFTPG1XQ5VkPUcDS9ppKXjp16maRBGuhwGk6ZVfSKepCY2nRc2vzN
 +7q9DcRFNGuve2DpIyj3L2W4R5FvmFbUGWTIr0agIMGWX4Mk1tS1tZEd6ilEwusVKV83qF77fOZsvY
 lhXLQvQTWXUlxbcPaHn2VddhPVSpa5Jfder1lbTgChrJB3uUhVSIyYmSZDFA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Dmitrii Merkurev <dimorinny@google.com>

1. Get partition info/size
2. Erase partition
3. Flash partition
4. BCB

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/Kconfig      | 29 ++++++++++++++++++++++++++++-
 drivers/fastboot/Makefile     |  1 +
 drivers/fastboot/fb_command.c |  8 ++++++++
 drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
 drivers/fastboot/fb_getvar.c  |  8 +++++++-
 5 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..75911468ba4980d9b96e2af9e708f08b9ef16ac8 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -119,6 +119,10 @@ config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_BLOCK
+	bool "FASTBOOT on block device"
+	depends on BLK
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -193,6 +197,29 @@ config FASTBOOT_MMC_USER_NAME
 	  defined here.
 	  The default target name for erasing EMMC_USER is "mmc0".
 
+config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
+	string "Define FASTBOOT block interface name"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  The fastboot "flash" and "erase" commands support operations
+	  on any Block device, this should specify the block device name
+	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
+	  The mmc block device type can be used but most of the features
+	  available in the FASTBOOT_MMC will be missing.
+	  Consider using FASTBOOT_MMC on a MMC block device until all
+	  features are migrated.
+
+config FASTBOOT_FLASH_BLOCK_DEVICE_ID
+	int "Define FASTBOOT block device identifier"
+	depends on FASTBOOT_FLASH_BLOCK
+	default 0
+	help
+	  The fastboot "flash" and "erase" commands support operations
+	  on any Block device, this should specify the block device
+	  identifier on the system, as a number.
+	  Device identifiers are numbered starting from 0 and the most
+	  common case is to use the first controller on the system.
+
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
 	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index c2214c968ab357371f5d3d27ecc9c1a3e9404e89..91e98763e8eab84ccd9b8e5354ff1419f61ef372 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,6 +3,7 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
+obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 2cdbac50ac4a0ce501753e95c1918ffa5d11158d..e6aee13e01618ee6567bf00527d3df327ae06f1c 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
+#include <fb_block.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <part.h>
@@ -337,6 +338,10 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
+					   image_size, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
@@ -357,6 +362,9 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_erase(cmd_parameter, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 68f92c4b887c8442cc212b8613fb70c7251cdcdf..dac5528f80908bf5b1224284c9ecd492394e4f0e 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -97,16 +97,24 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
 		[FASTBOOT_REBOOT_REASON_RECOVERY] = "boot-recovery"
 	};
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
 
-	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+					CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	if (device == -1) {
+		device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
+					    CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	}
+	const char *bcb_iface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						   "mmc");
+
+	if (device == -1)
 		return -EINVAL;
 
 	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
 		return -EINVAL;
 
-	ret = bcb_find_partition_and_load("mmc", mmc_dev, "misc");
+	ret = bcb_find_partition_and_load(bcb_iface, device, "misc");
 	if (ret)
 		goto out;
 
@@ -226,8 +234,14 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
  */
 void fastboot_init(void *buf_addr, u32 buf_size)
 {
+#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
+	if (!strcmp(CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc"))
+		printf("Warning: the fastboot block backend features are limited, consider using the MMC backend\n");
+#endif
+
 	fastboot_buf_addr = buf_addr ? buf_addr :
 				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
 	fastboot_buf_size = buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
 	fastboot_set_progress_callback(NULL);
+
 }
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9c2ce65a4e5bce0da6b18aa1b2818f7db556c528..f083b21c797dc7e55315f2cba017a4372483fa92 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -7,6 +7,7 @@
 #include <fastboot.h>
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
+#include <fb_block.h>
 #include <fb_nand.h>
 #include <fs.h>
 #include <part.h>
@@ -114,7 +115,12 @@ static int getvar_get_part_info(const char *part_name, char *response,
 	struct disk_partition disk_part;
 	struct part_info *part_info;
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
+		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
+						 response);
+		if (r >= 0 && size)
+			*size = disk_part.size * disk_part.blksz;
+	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
 		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
 					       response);
 		if (r >= 0 && size)

-- 
2.34.1

