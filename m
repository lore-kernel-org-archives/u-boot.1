Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3763AC8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AD182E27;
	Mon, 30 Jun 2025 17:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DPZ8pNat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731C182F03; Mon, 30 Jun 2025 17:20:10 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566EF80B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so17840955e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751296803; x=1751901603; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qXsJAcjL+wJJXVsuQnMemZXIQywIfTxngzhmXeZF+ys=;
 b=DPZ8pNat//5JPUCe+AzkMBsRRiORQXxCKlCY9KexpFy89TgKH535hCJUr7JxjAO9Z/
 qc6l0m9XmS3Kfb2W+rPS9mOxFaB/9mcDpkrtD4BW+GFDf7sRwAlpGdEuU1ZpaPmv2oZ9
 IGeTSQj2Hd85imjQWiRhuUKz7ZRU6fVuixpK3EJEWiTtdXw5cdwf3AlI4m7oExGgRqyS
 rlLuI9EHStQ6p+Rg2Gcv4bspf11ayf2wRbxWOLYf6We3kAmPtIDC/qdQxuzsFRqLJaFB
 eUCqxDI0LFhxoNJi8aXjPrRYAMfAs6xmtsNSrm5qGSveByMXoxrx6qHl+4h05cJTFEmX
 Xzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296803; x=1751901603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qXsJAcjL+wJJXVsuQnMemZXIQywIfTxngzhmXeZF+ys=;
 b=qoKT0z2eL8936DCBA/OEm8CaJBSgQLKusG92NW9cAyccZjdv3l5OwcfKr0M4POE8jR
 7lzgnAX+mBi9vMCHiPSH4bCpewRoSltCawQN960Tt83H9lCZXL8yVotz1iGxrIF28Q3g
 keNnkTaU8OKpW6RRBsgFIF9RNu39GjRisSkBjD7gAOUSU3dWKtgCcoQMAvd5MEWrTkJ1
 5KGcHiu+60NdMS1pv4qTr2XFnKR+i+GEtJ17NrkuObcShUusr4i8TDm+DnIRvotqYjoq
 WcPf06orPi2VdIEw8kZe3bqKU4ef2gEbUsnKxtu9cgkvDg35u78cbA30pw3RH+fvCW69
 9UHQ==
X-Gm-Message-State: AOJu0YxjzrwpHEcPumkv1sWSYTWL3YGlpvtLV2l0R9nRaYPj4wCHe01n
 M9yvs49pHgGYcjW2i4PBSiphiG35WfL2P5YSzU9ZDMIRyp+t9hZKDwv6dYv9yXZ/oFA=
X-Gm-Gg: ASbGncuMLNUPd+ofQfKj0HFSvk8BBgOuNPTO2Mc6h3pogTzThzj4rmzNhnBRw/4mNB4
 K6jfmGjjfVDGqxkhIpERRjzngpCAISkTI7Jh4xB1p/NwbJZ//UcWLzGaqHWN3tDoMABgjHVSWv3
 2xBnTiqy3ltmS+VmJrwW8jSk3OLEZ3p8+W+PwyJWJJE8M5qXwKK6zfwmApdW0UjVgonV4nMrcCF
 hxGyGUuI5tsCmmoJ8QXmWnTTXSmKqWUm7hdBGOobPju3vr6ZWWhgpC8Pqfz1h5IJL0lT4Vg4cVW
 7qYAzVSCN04HvkdFq+u0ALpORyayhAOusWVtC23ZPX1e+BRyhrvTYyI76dipzJmTxbooNNyELIp
 ycjNvU44=
X-Google-Smtp-Source: AGHT+IHJU6RP9YygiyauUmy1mn4wcx73o9xQFCiiMi86ksM5GsDFEIwrBLhtxEyp0cWdnpg/NbqQ+A==
X-Received: by 2002:a05:600c:6383:b0:442:f482:c42d with SMTP id
 5b1f17b1804b1-4538ee39977mr138435995e9.9.1751296802491; 
 Mon, 30 Jun 2025 08:20:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad03asm170432295e9.23.2025.06.30.08.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:20:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Jun 2025 17:19:59 +0200
Subject: [PATCH RFT v6 3/3] fastboot: integrate block flashing back-end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-topic-fastboot-blk-v6-3-7cdfd3a24786@linaro.org>
References: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
In-Reply-To: <20250630-topic-fastboot-blk-v6-0-7cdfd3a24786@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RLinaxkpe3PwUb+fbTmIup4LnynRByPlLI0vD59SZs4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoYqsfs1noB11I50xBIaD2AcJ5KuRpskHXitG/AdRj
 Vp+WLryJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaGKrHwAKCRB33NvayMhJ0TBgD/
 0Wf4c2o5fMn+Chx7OTLnxXTeUYSF8zpl3Ake7qr95gzVlLBwwljoc76FSBKYAGKR6z59xxKye3P/TE
 ffCho+o63b95C94BIwdKZGqSTXE4EeLQeP8TsMnreCN0lJk8SsRcwCow7vUfmwAANPE9EuRAqsdtJr
 kbtyBOj4YKFZZEc/3suk5SsOK99+Cex3BdtweOsvFICx0YZNOtzG/M4veCs3Zd1WfDPn7HihAPfn1n
 MOwNl2fLCAtKZHYHjvvEG6Wb+z2sHSieWPL7C7QblTK71i5C11BDQUhWWmdEKQrlPOExuaA7oBkqRw
 aHYXR8SRKUieszF0wYNtyn9kTspA+CXLtkzJ30pS6fcx7zwwJdw9XwKvEQyEv7w3pCQZlua4laK1tI
 PIPNwZHPyr9619dxsZdB4mgOBpSbc/YWquoGlfK1H0U6+zv1Ua2SxX2KPjzTkBy2q1elWh4sfRyaEj
 RsQ8dAFnumhbrgCXs7its4psZYKVpD9gktHRCT9C5V22pANgVlzC1/jcPU5w4QZeZeBQQwAT/cYWYF
 mf9b8wVvRiz5lrshfKP3DbluXbX5u3aL/wAPUiltEt/W4FyOVYCJPWL8mTjiDHuksfh76CnGp0kwE9
 LLV1Iqsl/xY3/zgMJj9n97gE8I+8rqrirSS9W4PeCuWNbD+wxhZmGF0p9HMA==
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
so it doesn't break the CHIP & Ninendo boards, and for ROCKCHIP
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
index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..b2b20a2c5e430cccc49fd6c04d6fb8825b67ec04 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -90,8 +90,9 @@ config FASTBOOT_USB_DEV
 
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
-	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	default y if ARCH_SUNXI && ( MMC || MTD_RAW_NAND )
+	default y if ARCH_ROCKCHIP && MMC
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -119,6 +120,10 @@ config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_BLOCK
+	bool "FASTBOOT on block device"
+	depends on BLK
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -193,6 +198,29 @@ config FASTBOOT_MMC_USER_NAME
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

