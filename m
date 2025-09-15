Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB9ECAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 12:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108808346A;
	Mon, 15 Sep 2025 14:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QhandCL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF0A83496; Mon, 15 Sep 2025 14:57:34 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C608344E
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 14:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 86D931A0859
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 12:57:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4FE776063F;
 Mon, 15 Sep 2025 12:57:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A5563102F2ABB; 
 Mon, 15 Sep 2025 14:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757941049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=CI0xo1MuSOSBBrQiuwWg+tIf56254ONpXVlGoGn+8nI=;
 b=QhandCL+U852a2q1jFXWDaI6+6OteE3y9miDHQvlBcOlQS93we6SfLVNViL/FZwZp23pJb
 +cN4N05kcs/VJFM1RrBWZvKgmk4uJ9ue6ykdh+CVjNBh7IFMCU59vwfwNzoS2r0DWAnEAg
 87W0R0y1TZweXCZllfp/NqktkifqKupoZLggLGF96O4p3cjRxcoCP8zd9QYQGc3rBIzo2/
 Rd9/ZlDgxwkkNPw4obOvjXuDyXdhlBa8ErEX+LREBNj+036dfIdV61wgV568wjAIw8HK6o
 5laBO8AS/xV0y+gO4SLQm28+gQGyJh3Hmp7vOP9ng1QSjNO/6yKEha1LbVmT0Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 15 Sep 2025 14:57:02 +0200
Subject: [PATCH v2] imx93_frdm: Add support for flashing board with UUU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-mathieu-frdm_imx93_fastboot-v2-1-a4f2a72758e9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAB0NyGgC/42NSw7CIBQAr9K8tRhA+3PlPUzT0AfYl0gxgE1N0
 7tLewKXM4uZFaIJZCLcihWCmSmSnzLIUwE4qulpGOnMILkseSsEcyqNZD7MBu16ckt76a2KafA
 +sVoNnGNZSXVFyIV3MJaWo/7oMo8Ukw/fYzaL3f7XnQUTDCvZ6maosUG87/pF0xm9g27bth9OW
 4qOyAAAAA==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757941043; l=5447;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=9R68YYA2pJVGkk4A4FbpgYMxY6EatVnSNqVfa/Zw3c0=;
 b=CTJSGxqmSbNPE4tBRwt3+ZRFn5YXfX21TiVJyKlGOoqiu0fBjB1Rre9lxehbgnFaE3fjFtvGN
 fx1JLbpiTSJAFUiIBFUmXl0XyUKX0nXYhogmG68KzLpaAEOQAl4BjH9
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
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

Allow to flash a board using NXP UUU utility:
- Enable fastboot support on USB.
- Add fastboot partition aliases with names used by UUU. Also add extra
  environment variables used by UUU.
- Set 'dofastboot' environment variable based on boot device
  configuration, allowing to automatically enter fastboot when booting
  from USB.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Add section describing use of uuu in board documentation.
- Fix SD card device id (sd_dev).
- Update USB gadget vendor id and manufacturer name.
- Link to v1: https://lore.kernel.org/r/20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com
---
 board/freescale/imx93_frdm/imx93_frdm.c   |  6 ++++++
 board/freescale/imx93_frdm/imx93_frdm.env |  8 ++++++++
 configs/imx93_frdm_defconfig              | 14 ++++++++++++++
 doc/board/nxp/imx93_frdm.rst              | 22 ++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/freescale/imx93_frdm/imx93_frdm.c
index c74fd85712f4..c436ac6aa479 100644
--- a/board/freescale/imx93_frdm/imx93_frdm.c
+++ b/board/freescale/imx93_frdm/imx93_frdm.c
@@ -10,6 +10,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch-imx9/imx93_pins.h>
 #include <asm/arch/clock.h>
+#include <asm/mach-imx/boot_mode.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 
@@ -55,5 +56,10 @@ int board_late_init(void)
 		env_set("board_rev", "iMX93");
 	}
 
+	if (get_boot_device() == USB_BOOT) {
+		printf("USB boot detected. Will enter fasboot mode\n");
+		env_set_ulong("dofastboot", 1);
+	}
+
 	return 0;
 }
diff --git a/board/freescale/imx93_frdm/imx93_frdm.env b/board/freescale/imx93_frdm/imx93_frdm.env
index 528a953c8df1..111f38ed72a6 100644
--- a/board/freescale/imx93_frdm/imx93_frdm.env
+++ b/board/freescale/imx93_frdm/imx93_frdm.env
@@ -19,8 +19,16 @@ kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
+fastboot_partition_alias_all=0:0
+fastboot_partition_alias_bootloader=0.1
+emmc_dev=0
+sd_dev=1
+dofastboot=0
 
 bsp_bootcmd=
+	if test ${dofastboot} = 1; then
+		fastboot 0;
+	fi;
 	echo Running BSP bootcmd ...;
 	mmc dev ${mmcdev};
 	run mmcargs;
diff --git a/configs/imx93_frdm_defconfig b/configs/imx93_frdm_defconfig
index 4f837ca92828..eddd36c618d6 100644
--- a/configs/imx93_frdm_defconfig
+++ b/configs/imx93_frdm_defconfig
@@ -30,6 +30,7 @@ CONFIG_EFI_VAR_BUF_SIZE=139264
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-frdm.dtb"
 CONFIG_SYS_CBSIZE=2048
@@ -58,6 +59,7 @@ CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_MEMTEST=y
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
@@ -91,6 +93,11 @@ CONFIG_ADC_IMX93=y
 CONFIG_SPL_CLK_IMX93=y
 CONFIG_CLK_IMX93=y
 CONFIG_DFU_MMC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82800000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
@@ -116,6 +123,13 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_SHA384=y
diff --git a/doc/board/nxp/imx93_frdm.rst b/doc/board/nxp/imx93_frdm.rst
index a1f526fd4cca..3c3e5f49b040 100644
--- a/doc/board/nxp/imx93_frdm.rst
+++ b/doc/board/nxp/imx93_frdm.rst
@@ -13,6 +13,7 @@ Quick Start
 - Get ahab-container.img
 - Build U-Boot
 - Boot from the SD card
+- Boot using USB serial download (uuu)
 
 Get and Build the ARM Trusted firmware
 --------------------------------------
@@ -73,3 +74,24 @@ Boot from the SD card
   at /dev/ttyACM0.
 - Power on the board by connecting a USB Type-C cable into the P1
   Power USB Port.
+
+Boot using USB serial download (uuu)
+------------------------------------
+
+- Configure SW1 boot switches to serial download boot mode:
+  0001 SW1[3:0] - ("Serial downloader (USB)" Boot Mode)
+- Plug USB Type-C cable into the P2 device port.
+- Connect a USB Type-C cable into the P16 Debug USB Port and connect
+  using a terminal emulator at 115200 bps, 8n1. The console will show up
+  at /dev/ttyACM0.
+- Power on the board by connecting a USB Type-C cable into the P1
+  Power USB Port.
+- Use NXP Universal Update Utility `NXP Universal Update Utility`_ to boot or
+  flash the device. E.g. following command can be used to flash an image onto
+  the eMMC storage:
+
+.. code-block:: bash
+
+   $ uuu -V -b emmc_all <image file>
+
+.. _`NXP Universal Update Utility`: https://github.com/nxp-imx/mfgtools

---
base-commit: 7a4f3c5652157cbb3d26a7728bfe537ea483efc9
change-id: 20250911-mathieu-frdm_imx93_fastboot-7ab00c562a4c

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

