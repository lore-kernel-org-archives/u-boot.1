Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA4C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 12:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AC2830B4;
	Thu, 22 May 2025 14:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QrjTH4SM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F0C830AF; Thu, 22 May 2025 14:37:13 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E98182F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 14:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso49853375e9.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747917430; x=1748522230; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FuuqfMQ8lg9iQu/AzUV9PTzWCbszBbS9wH7Up4Yct6c=;
 b=QrjTH4SMXxy5L5+GdIH9uhA39V8U2uYDLClLEwMsqmcwGiRbQQGbWeJI/TtCtfWgR9
 EiUx6lxUWSZ6RAgwaX9exnPlEiFSwetDSnS0G5o8IJOfbx7WIZy5hQsR1he924C671KV
 CTyRS7A+KOZ84n6RVv0OJM1XPViFPFuJxbmT1S2MDDCpG5Cx0hGgCugFZkmiQnb04gzv
 12RlBdrmmf8Vu2riUMfui5j5/oTemlEzMoRQJDztoVHjrynIkHCtSatYkZtOl2F+ffKg
 WVeVfJSFCRE08l+D6zen05pYQA8FmPv2W4G2LrXGGOfyV9Pi13A8YDuZ6kcvEGtxI0N6
 9VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747917430; x=1748522230;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FuuqfMQ8lg9iQu/AzUV9PTzWCbszBbS9wH7Up4Yct6c=;
 b=iKt+U+3jUnC2fNU9ETYfw55/jfvqJ9FqTZmX669Wcgp9o7O8LTokwHnx+FKyinUp4k
 FcYJpaZ1/HmjGN8qRCcBeIm+9DytcLPLvnwqNwW3bs4Bz4MdQ84/HRBrmjLtwwYMLaH+
 d5IB7aTSRvRJMOFZuGqsB6FnADpKbk5ZcIgYZ5bgQA5LdSagFHCOHuCGSkYnipuMXMyu
 oDCbqUOdPGL1oUIUZmgKr8uRh1Z2SnLtTvajr/JGqA91fNcAGO2LxDAF0q39iNO9pr8s
 9g0xLu9sc1ayCj+JBzmhF6jfB1fDl6Dwctb5ZqHsrUcg2QZ2aQMGlsUO5ji8xwuc45US
 Z0VQ==
X-Gm-Message-State: AOJu0YxHPRWH5dlk65d3KXXHUD5LqWkKERMS+8aA22SyqLYba0iRKVNl
 S5pjXFMyVoeCFkIhcf5bRcDHVN6Pc7nvfnzCcIDSjxG6niep2eHICEtcS/3wrLK3L78=
X-Gm-Gg: ASbGncuHF2JdkQYCw8JAwgUvuB2M1IR9C3apYDT5wnOfmjP7TNIJksLO/vN+IuGN7jF
 C93yTVWm3kVRdGjBglKjO4rjP3f5KK6Ib36igyV7pN8W+tfENDsNiTLOxaCjj0q3IFcnf8ysJOD
 6sFdJyR8JT6aGrY5Bhu2cnYREWWgm2kOEhHCw5/isKK4CjS8gbPsZeNG1GEcDvIv1gIgAC/SUez
 KjzxTA7qNJTXPOgRNIJScQmBcPKLENzoxUzrzQY46KWwcxZJNO0FCk9P4R0x93D4oNxHzABg0ba
 EhHJVhwwYbXHKMosS1U6BYrIeYAWhvtfMstAM4fZWsU2oEGa8ipvP/DnMLEbFoyH4672PM0Zjfc
 DPyOJODQ=
X-Google-Smtp-Source: AGHT+IGTEO5hghp+/x8jXt6A5CKFB7n4Y0fztp0vSwZaZW/UNelKmzJq+KyqrMXC/Y2J/6vt6LzbIw==
X-Received: by 2002:a05:600c:3b86:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-442fefee241mr197404205e9.13.1747917429692; 
 Thu, 22 May 2025 05:37:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38145eesm102271045e9.26.2025.05.22.05.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 05:37:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 22 May 2025 14:37:07 +0200
Subject: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
In-Reply-To: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=I2XfY0aQLJO/FWUs4f6+IXGVMeuS/xUx6DP9kROkGoY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoLxpyBPqzTu6xa3oPkVbT1zCyBloRVf1HaMHWZTmG
 BIJWxnmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaC8acgAKCRB33NvayMhJ0Q8dEA
 CdE2tu6aOPbSKFEwRKc6TkiFhtYxcLi9E0JqZll/JodV3Wt7ZvmuOde665JmYDf0OigbuDNj2PkJjQ
 CzsAT1h60svzfwIpuKMB/OMaxWyzx7BCb/g+C04hYZL4tuvErlFBHMPnfhzUhMt+cqIj6aBJyZDMqM
 yQ79Ynu0isgd2YSmoDoH4jrIDhHLBfhHOBqNky+jyq2binnfi5vlTXLIkDZLrqHZAjW36GHcKKAJIt
 IIwNIkeTQJs3nBJGOXKKpixii9bLZZw8DU8bgGsHWFy9UjvWTYImVf8UpxIxB3pYwUlr2rl7pc3ebY
 ghcHQrLPiEY7tY6BsvPoo7BJKjqLh2NqxvWmlHnEbnqLg1MamUYB5tnv+wiZD2lPJkXeBWarcD8q+k
 NqoyjIQ3BL5pNdtQV5bwhYtw10yw8JGVXnyjALNVSFQNpLiMKU+NZjd5aKMtwxAmbj3Zhez7+ULQxc
 XHfJ8LinpwvhF8cvT0qtw0ldwksgEKczNEp3/ISWqHn5G18lhCvaitqhwyS/UAxxWPO46prU0yH812
 C5nW2Wz3EUIYYNuebyBz5BOBwfb6WwrvrrtYnZkWh11qb8C3sshGDUVaocGb+kc4e45GGlhyYN7t76
 NJkssHhB9BdBL3io+yUSh+sTmytpYFJlBI1PqJnrKuDobEjkROyX9Hh6yF0g==
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
 drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
 drivers/fastboot/Makefile     |  1 +
 drivers/fastboot/fb_command.c |  8 ++++++++
 drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
 drivers/fastboot/fb_getvar.c  |  8 +++++++-
 5 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 33825ee408fbd9aff26cd390a140421c7c98ecc3..2ea5b7f73c1338ad435e87cb1ecfbcc7728f2244 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -119,6 +119,10 @@ config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_BLOCK
+	bool "FASTBOOT on block device"
+	depends on BLK
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
 	  defined here.
 	  The default target name for erasing EMMC_USER is "mmc0".
 
+config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
+	string "Define FASTBOOT block interface name"
+	depends on FASTBOOT_FLASH_BLOCK
+	default ""
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
+          The device identifier should be 0 for first device on the
+	  interface type specified in FLASH_BLOCK_INTERFACE_NAME config,
+	  1 the second, etc...
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

