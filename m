Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA189C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66AF8219D;
	Tue,  6 May 2025 18:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DZG3LNri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D973582998; Tue,  6 May 2025 18:10:22 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C13822D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so6122261f8f.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746547816; x=1747152616; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vghMrZJGET8uzFQGRt6atFm9U3VvwEwrffjvJwdC4bY=;
 b=DZG3LNriiYCeabEGprcLMpTCNAbmrvaDRKJN9FYbM517KwyAouVqQxpS7kyjcQtZz+
 34OXd1ZPtmgQQe0gPHuxWrf6VoDGly8UOB2KKitjz/g0BNBR9T4MawzMHpAh3O2QGygu
 7hp0QBDDL3FynksYDh95geOPwHmiKX/XQ6Q5XSpfOnrCx+nGHque2JKEL8Kk/Y/7PL2t
 38llXLvrAfYcnormoQUGAf5XvEhUaOBQNzCU0QUQmruGoBQDM54yo1GeWbWwSZMx1Ob+
 s1M39jmFWA5WzEzIqpLNpdgkSlG5UuPK5QuOFZ3amC6kkD31te9u7DzgkaTf9qIKGukG
 o0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746547816; x=1747152616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vghMrZJGET8uzFQGRt6atFm9U3VvwEwrffjvJwdC4bY=;
 b=cYE4e8DNdlBr/rMVKPGI7sSC67a5VtlfPTq97ku2Q8EmMW7xoIUGvUcSZY571d5L/v
 EdwbyuKaWMprBhSoiUE8G5fGX1cftuDr8WiWyRpI1XuyEupxXRKmrRP+rCZoU3J/YvCg
 99S7yZrYI2XIrXTNwMlt76WXNIOx4BhhMs/bYdzWFwtYBDW0dkydUeQCUb+N6WFD1WGi
 nJEJPxTapLlC+F62oPfOamBcj33ZOsg0YOCudU6FWssueXlP9cunkpvz+BPhaaClt1z6
 L2T25/CM7y8C5u3ot96YaUPfhnl1n1Eb2Dmhh8LH2k5TP1iwqPvRzKkVV8ANOSi3GrSQ
 SdEQ==
X-Gm-Message-State: AOJu0YyoNk6D9muuj6muozNXyYb24Tpcenb/FEqQ+tdBGHCTnN1Jv0Ak
 YbTMCkpkMmHR4bNysL31I5VxlsYqtoi20tjAeyVJP+4LivDiiZcQZGFlRHuj6V8=
X-Gm-Gg: ASbGncsB5ifbTrhru4VE0lpnI4uozyNEIxQqs4kj4TPNCP4gzMo5EKeD3yWPE+mtoZe
 b6jQNDDXy+pwniqpJ4KA9ZDuX35uLLyqnpZ8wzMZp4IPg8FBVTcFK4OgtZXkFLpWbo81Cw1IX62
 CF2e3JOABUhaDV7KcV9bVjir897LsQP366Fy0RzoZkjM4OTFzNt7CcpvTvqAvUPj9HKpyLBujDQ
 EYKPgYuMNUxVtPCodm3jHnld5M/BtMSzdrDem6zXuX+fWm9BIFkuRkjsVJdQ0/a6UjUz7YwLkY3
 l/bL2tyAiI2yyPwJ7Ow2llbnCBLrlpc0IUY+wyPZBDHTFg4D3K4XO5Zezx+2pQ==
X-Google-Smtp-Source: AGHT+IHdL+vy3ksJJFT+GEQxTCjDWl3KrEqzkFv2noqma4W9HIedWc2eS6wThkOEhdojqIUU5aL5eg==
X-Received: by 2002:a05:6000:310d:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-3a0b4a060f0mr30196f8f.4.1746547816170; 
 Tue, 06 May 2025 09:10:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b0dffaa1sm2103960f8f.31.2025.05.06.09.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:10:15 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 06 May 2025 18:10:09 +0200
Subject: [PATCH RFT v3 3/3] fastboot: integrate block flashing back-end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-topic-fastboot-blk-v3-3-d94be5829f46@linaro.org>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
In-Reply-To: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6809;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zGJrKdXkNJR8l9GpIB0ZjvxL62DS9PORGV3xh9A2bCM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoGjRjPo/a+OunyUxAJLTJWMrJZzCGZQlIqSk7TOXJ
 Nj8FsuuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaBo0YwAKCRB33NvayMhJ0d+YEA
 DBzIph8NAJo0/fA1VcIdGnUKditG7mOXNxPYtzDECJDD3T8IuIiVCODX/66w0uvI1bqMJprjdaAOdY
 qwAKI9dfEKb/DZRZf9DwqmKER1rRkt61p0/Hg4tKIisWZvCKgROTtPDZdp3dAF2z0ocJsP3mTP1KgG
 T5HYzxZRI+Mqf6VjD+RORjgn3m6wd0//ZpvYm4KgVNRBv1smTJu4MTahwh3PYA+k7YD8aGi/y3b7Vt
 WKcb51UsZpZOc+j1dPfI4TqVDvRFvSlzNpAb5hrizKqlmxbbh9sjioVSX0cJixo2XJ+CxFCN3CEVgn
 kp9EYA6QSxvGj7qbzrq/c5VekcbmJTKD+uEf4jDyG56xuENLn9RR5Y1PXNhKtXgAmXErgPxIXRoCkv
 IDVwSKTj//1znqpdn3+hULPNSlnRMg54kPuLVyuA3CN1RqtkgEGLK/1+X6ouBnukyMZCQtMPDfJSl3
 KUvvqnsZPjsi9PPnGRBnnZ3eXHUbcLuV/0YYWX56Ks0EqRxpOTvp4E/2Ir7oFiQXcXJoSIj68szm9o
 A8sKFkhxle6AYhk2i+41uh5kquzgv+zUfD3/WfK3i1B4o/Bjog7y5g3Y0QptrEesgG4jC+hhJfN16z
 NRVHq+RuOhYqYeb21ZUvkJUKWd5ulCTAmU+N0/gW4KTUwxnv3kIF1PMKfL+w==
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
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/Kconfig      | 24 ++++++++++++++++++++++++
 drivers/fastboot/Makefile     |  1 +
 drivers/fastboot/fb_command.c |  8 ++++++++
 drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
 drivers/fastboot/fb_getvar.c  |  8 +++++++-
 5 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 33825ee408fbd9aff26cd390a140421c7c98ecc3..68967abb751ed512f157bc32bfafc863943a2265 100644
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
@@ -193,6 +197,26 @@ config FASTBOOT_MMC_USER_NAME
 	  defined here.
 	  The default target name for erasing EMMC_USER is "mmc0".
 
+config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
+	string "Define FASTBOOT block interface name"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  The fastboot "flash" and "erase" commands support operations
+	  on any Block device, this should specify the block device name
+	  like virtio, scsi, etc...
+	  The mmc block device type can be used but most of the features
+	  available in the FASTBOOT_MMC will be missing.
+	  Consider using FASTBOOT_MMC on a MMC block device until all
+	  features are migrated.
+
+config FASTBOOT_FLASH_BLOCK_DEVICE_ID
+	int "Define FASTBOOT block device identifier"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  The fastboot "flash" and "erase" commands support operations
+	  on any Block device, this should specify the block device
+	  identifier on the system, as a number.
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

