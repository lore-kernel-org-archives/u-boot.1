Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36491C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 18:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64319888DE;
	Thu,  4 Jul 2024 20:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/SaRCij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C2B888C2; Thu,  4 Jul 2024 17:49:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1376D888EB
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 17:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4256aee6d4fso4720965e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720108179; x=1720712979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vDN2EE74D67OuxvnkewPY8hW7zFLVI0XwEl93AFZsEE=;
 b=e/SaRCijiIm64+3Z7g6roFS269637tliQVq35M0vsqcM41SRCDZp5j31o6aJdxcb8p
 WWMpclxncN2qe3bj3TCp1xZ89JuokyiLe/oan3qmoDoPFRzhex1caCh1HYcW+GzMWa2D
 Rr8mxzumy5t+3V/9/pyCcZq/7yqpXEX0W0qPYe6h0D2HBoQ1PZ8/WnD3J0UtNQBSBMo/
 D/FnStHfkJpTgRwq/mIXjJ4ci5SQ87YRqPbYmrD8EqIqKo88mWbpwHbjC6ztc8QAQCL/
 /E2s4cCSpgHFhHwzrpzIjGujZlJ/eXrS3Aq0wTpK944Bx/UtdhdJiTIeGoQZreNUUf6A
 bWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720108179; x=1720712979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vDN2EE74D67OuxvnkewPY8hW7zFLVI0XwEl93AFZsEE=;
 b=CxayBbdYuJMLgiVSr7Vbg91yESb3S7DsaeTwmi5IFqxC6iSValv4rWRDQEXhfsn5cW
 RcKFpjKVVNI2ICWu+A24icHQWo7oGD4Cp02P97NcwZ/ouwQqqp1GyAGiMBUCQg2vN9yb
 OpFE5TkYuVWtSm/FeUs9qGc0gNlAZuq/AV2c89pDYUw+r+lEMuRQzjpGtzpNbV4eyISI
 52YHAkU3w43aePd+cJr2VfQY7ZDw9l3LMSE/5rhn2oJvAoFEWT2aVazamKt75wCwoCgF
 Q0/ysjnNuWhZ5rqLGLgkfOnIik9yz5HHYHQroMEuifp003VFxl7vULX8YKvrEf2ovkhn
 RdIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUugGnmjqSWSQj2oBKXEzkmH+bXerjC9wKPV/GFvFVMZUGQ1bHKJ+mvApurumZeb3onZtIKpVXcqoAiGY9m8+EwHRXiHA==
X-Gm-Message-State: AOJu0YwjRgTNRI9y2clsRsJovO1jzq7ATW/ZgP3FndI4x58ZZxYDoZQG
 dKSmj2KG9RBClrXvaHt6xcfCi/cep6TTvoitLkLYR9M0dZEH2yMp
X-Google-Smtp-Source: AGHT+IFMI895zAZjyJb3QQEit0wMv81Vuizgncr08qnfVCREOeVgrV3HokMne0oRx3G9ow2YaE98dA==
X-Received: by 2002:adf:ed12:0:b0:367:9639:66d3 with SMTP id
 ffacd0b85a97d-3679dd1584fmr1438895f8f.5.1720108179117; 
 Thu, 04 Jul 2024 08:49:39 -0700 (PDT)
Received: from vitor-nb.Home ([2001:8a0:e622:f700:1bcb:c524:3ed6:f20d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679b1e5f31sm2259284f8f.33.2024.07.04.08.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 08:49:36 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] verdin-am62: add DFU, USB and UUU fastboot support
Date: Thu,  4 Jul 2024 16:49:32 +0100
Message-Id: <20240704154932.434266-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jul 2024 20:35:52 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Enable USB host as well as USB gadget and DFU support for a53 and r5
configs. Also, enable UUU fastboot support to download files with
the UUU tool from a53.

Additionally, configure usb0 to peripheral mode and add extra
environment for DFU use.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 11 ++++++++
 configs/verdin-am62_a53_defconfig             | 27 +++++++++++++++++++
 configs/verdin-am62_r5_defconfig              | 20 +++++++++++++-
 include/configs/verdin-am62.h                 |  9 +++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 9ecb30527404..b3d237c86979 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -173,6 +173,17 @@
 	status = "disabled";
 };
 
+&usb0 {
+	dr_mode = "peripheral";
+	/* Since role switching is not supported in U-Boot */
+	/delete-property/ extcon;
+	bootph-pre-ram;
+};
+
+&usbss0 {
+	bootph-pre-ram;
+};
+
 /* Verdin UART_2 */
 &wkup_uart0 {
 	bootph-all;
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 03730b498fd0..464d0bbb159d 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -73,12 +73,15 @@ CONFIG_MD5SUM_VERIFY=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_BCB=y
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
@@ -115,8 +118,15 @@ CONFIG_BOOTCOUNT_ENV=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
+CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
@@ -178,5 +188,22 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_HEXDUMP=y
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index 8266a7f6e8f1..e39ee2ac6fea 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
@@ -68,19 +69,22 @@ CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
 CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
-CONFIG_SPL_MISC=y
+CONFIG_MISC=y
 CONFIG_ESM_K3=y
 CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
@@ -105,5 +109,19 @@ CONFIG_SOC_TI=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
diff --git a/include/configs/verdin-am62.h b/include/configs/verdin-am62.h
index ac44809fdfa5..e8bc22d4c352 100644
--- a/include/configs/verdin-am62.h
+++ b/include/configs/verdin-am62.h
@@ -35,9 +35,18 @@
 	""
 #endif /* CONFIG_TARGET_VERDIN_AM62_A53 */
 
+#define EXTRA_ENV_DFUARGS \
+	"dfu_alt_info_ram=" \
+	"tispl.bin ram 0x80080000 0x200000;" \
+	"u-boot.img ram 0x81000000 0x400000;" \
+	"loadaddr ram " __stringify(CONFIG_SYS_LOAD_ADDR) " 0x80000;" \
+	"scriptaddr ram " __stringify(SCRIPTADDR) " 0x80000;" \
+	"ramdisk_addr_r ram " __stringify(RAMDISK_ADDR_R) " 0x8000000\0"
+
 /* Incorporate settings into the U-Boot environment */
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
+	EXTRA_ENV_DFUARGS \
 	MEM_LAYOUT_ENV_SETTINGS \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttyS2\0" \
-- 
2.34.1

