Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A31CFA775
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE338390D;
	Fri, 21 Nov 2025 11:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQIJFQtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174B983734; Fri, 21 Nov 2025 11:53:42 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEDEC833C6
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso18329595e9.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763722419; x=1764327219; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=StGalbJzzMsoX3fhTF8mrbLIseY6VYZyDF/d23xB0CM=;
 b=cQIJFQtTLyj6TQQrk/HY1IlQAfeofJx32GpCQdWrVq6UvycLBBhofAJvQIOYUGCx/0
 G89UTdUqMy4DxIp9PaEaPlLW0NoI/zqqaRX23PLrWEaNBxqu+5EgUndx3NJh8AhciKos
 HYDT3wZznoFVZov9LqWZ+qEyP+uvptzVDlA+PSVaspOyGNDPd1P0dwZdYcarZiiGysKB
 LTSC224o4O2+7f6bURz0KljLkkAVRVprVUaN0FKNt5uhpatuyIdLlUI4dtCawOuSGMsC
 nvwNm3BdATNxjua5ON4MqPq5CvSxi04MvC+WNpuYhEFONmrANH4fyQw+ishBoks8CWvZ
 oJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763722419; x=1764327219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=StGalbJzzMsoX3fhTF8mrbLIseY6VYZyDF/d23xB0CM=;
 b=uMjqqISnaixFVT9mzvkDEHmmMe7RIdA2n237G/yjBXRI559o6taF7rW052X6WWBj19
 uN8zOgAY/ongyZv1KcrDqF1Z0ywCWjHWRtBC1RSabai+z/Ql4uhGXZg+TIPk2GdLbzRQ
 15pPlkRlA+7fuis1//QA5BIrWRqcFDBhriztf90Jt587ZK+5eHMzsrdRyMFIZR1wU2/C
 s3LHXDysptKFWxs3V/4F47l4OQgZ94x++X/HNzac+Vp07H+u04VckGo5YNfAoxWB9qqR
 jUNY4O2hEw+C5TXi1dgGEpE51hCRrDoMmufG1UTJUZXfSfccpMF+iQbko/g5HfcLP6BZ
 Th5w==
X-Gm-Message-State: AOJu0YxP4sHi89Ak0ztjUSia23d2eJ3gh37I4CGHiKbObg/oQcda3Sjo
 HTCRkS7cNfw16EJdntkOmELeiOnM3az7tqgvsyHSPmQBZpCotRuaNMjuDwLY3z+NTCo=
X-Gm-Gg: ASbGncsipb5M8axn6oCpi9ZH73Bk3CuNdbY7ieJtQ9BC7ihCcJOmgFK/tlivwy4k+mJ
 BCZsk+InA0PE5zDYYXy0lEX9gLBFtiT3TmnGqCZimvPJA9IlhAUOyKLZABs5ScTwAPwNCoIut86
 M+C+/XQVYf7B+tG0oRKVAq+TW9pjpAoAnEc1pSebx//uotXg9/YlycX+kzWBThlFDwolpjQu7Zk
 GtP5yNTBH6WzJYThZNi73t6iU0jJ5ejP7TmGFr9Kg/qR79E9SSe4iFSCOur+nYgbXPLuLtA0fbh
 0TVt6b0xriaEe2OVdjmCsx4GppNhZeL85dvYgsxPBHU5UaCKUOyB7oLq7KgTj2PzW4hgwgaoS5j
 353ydxQfrG1MZUIY6aD/JRUvfw+q+BProyEkiLFhql0EFxPEBpIv4Ut6zgdSZGnnYBx3pxQXQ2R
 LETJ+FhZOxA5HKSD24ZXexO4BKxy/RwNk=
X-Google-Smtp-Source: AGHT+IGjSIquYjQAxvCDKg/U0Z9Szt0k+3+e2hCzaLAMfZusrXh0TXbBC4vY2Nu7FrYqXD6HLxDR0A==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id
 5b1f17b1804b1-477c01ee405mr18831245e9.26.1763722419253; 
 Fri, 21 Nov 2025 02:53:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de46cdsm80985285e9.8.2025.11.21.02.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 02:53:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 21 Nov 2025 11:53:33 +0100
Subject: [PATCH RFT v7 3/3] fastboot: integrate block flashing back-end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-topic-fastboot-blk-v7-3-9589d902fc91@linaro.org>
References: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
In-Reply-To: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7535;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ss7uIIWFuuKATHzOvbCz7BWQ2Y7uWamv0PRcgb0RQ0c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpIESv0wUCGvQl9xnqkD/qnXAomC2qMguzJFybNm4T
 Ny+k8GuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaSBErwAKCRB33NvayMhJ0QwZD/
 95E7591lMdJ73/uYUvaiW8NDF/McwLUvbr/OpP1pqgOBDnSNAe3A/M0lPCJTrC4yOlmrudAYY5Js/B
 K8OeTCAhob9DkRmuXbZDOmiM0Oir9DlMugazFYIOfAnfWSYOxNSfo6ZuKySXfDA9wO2uxCazaTP6r7
 0d6Rwd+XzaDc7zxP6xLi3BXLXJi40gI2tba/9ocB/BnJkRHlXZMhMnncUO0oFZlnTcFXpMoO98zEDV
 lb82NBkEvZj+o3VN20z7Lov4mIIqHDRxUClA459iKf6qirnuznWwaIrtLRC+zelfmLPiTswUpoaq3l
 hxqulqgPyh+QinqIGPQM+OFUn92ziSePTXqZHFCuCMJccyukk56QBXs6z7ZbEixLUjEIFfxU5cpY47
 PaqD7O3ceJSYazJ1XHsXrEU2KWKi/CbM9Yr3j8YwLUXce6O6wOt8Lb9nvDoFXl6Zw+NAG4uJQ5N4Do
 YhPXQV2PNGNF6urYppbWk2PCA+Q2QDdecE/nWNZ4heP/bGbo8GYXn1PXTM9duJxm3j+CNQojWnLjR9
 y3+Q123ESV7mManbQ154nEsiW/o6wE0gdvDR2jYu3U7ogTBRXnDAEv6m+EetWLi6ovPlO/j+MbDeh9
 Jtr5HIN5SAlHOeLhTXq8rUelXpNcStudDxbvA79rIgKPh/fANheRLeIihG7A==
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

Make FASTBOOT_FLASH also depend on BLK, but make sure
it doesn't affect SUNXI and ROCKCHIP platforms since they
default to y already.

Make it only default on SUNXI when MMC or NAND is enabled,
so it doesn't break the CHIP & Nintendo boards, and for ROCKCHIP
when MMC is enabled.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/Kconfig      | 32 ++++++++++++++++++++++++++++++--
 drivers/fastboot/Makefile     |  1 +
 drivers/fastboot/fb_command.c |  8 ++++++++
 drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
 drivers/fastboot/fb_getvar.c  |  8 +++++++-
 5 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 843171902ae..576c3ef8a45 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -90,8 +90,9 @@ config FASTBOOT_USB_DEV
 
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
-	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH
+	default y if ARCH_SUNXI && ( MMC || MTD_RAW_NAND )
+	default y if ARCH_ROCKCHIP && MMC
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH || BLK
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -123,6 +124,10 @@ config FASTBOOT_FLASH_SPI
 	bool "FASTBOOT on SPI flash"
 	depends on DM_SPI_FLASH
 
+config FASTBOOT_FLASH_BLOCK
+	bool "FASTBOOT on block device"
+	depends on BLK
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -197,6 +202,29 @@ config FASTBOOT_MMC_USER_NAME
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
index e4c97d45997..a341af076d1 100644
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
index 791088bc094..18d86988f4c 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
+#include <fb_block.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
@@ -338,6 +339,10 @@ void fastboot_data_complete(char *response)
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
@@ -362,6 +367,9 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_erase(cmd_parameter, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 68f92c4b887..dac5528f809 100644
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
index 6775ea397ab..e8aa0e09aa6 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -7,6 +7,7 @@
 #include <fastboot.h>
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
+#include <fb_block.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
 #include <fs.h>
@@ -115,7 +116,12 @@ static int getvar_get_part_info(const char *part_name, char *response,
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

