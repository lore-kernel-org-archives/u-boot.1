Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E04ECAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 16:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD47833BF;
	Thu, 11 Sep 2025 18:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="W94Ro0QO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACAA833EB; Thu, 11 Sep 2025 15:35:50 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C4E833C0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 61FDA1A0DB9;
 Thu, 11 Sep 2025 13:35:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3909460630;
 Thu, 11 Sep 2025 13:35:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D9BB102F29DB; 
 Thu, 11 Sep 2025 15:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757597746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=zvj/0gh5zFe5rqZoFI72Tdtur2zqnViYorPR3ZF9KKQ=;
 b=W94Ro0QOQke0F6Mza8FoQ17PtMdadf1CXBl1k+WC5qZlsNrJhnxr2sY0xDIRN41s3L2+qn
 edX/VPPVAzTiRPpZxPzEBPp0X4k4tLhg7BYLdmwHPVbdbD0ZmA0J4b6U+1e4AP796diu9D
 NCuus6FNkJbpO6T2cxE4BrjfqO7KrISl1g/GEaXYbcbSkDBjtYcNUKVNVnDyXhFaym7MUH
 M/S0swjp+6gdZzA+UdM3doAMzCoj08COzGxIGe6VIMaswu1XtGjnj4vbv45tlFIieg4Qcn
 J/WBnSnRW94WrpHAxJ7yHdzS69ApvhaVWl6pkAhoAVz+IAPYXiKILYHuUkLRtw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 11 Sep 2025 15:34:28 +0200
Subject: [PATCH] imx93_frdm: Add support for flashing board with UUU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOPPwmgC/x3MwQqEIBAA0F+JOSeouxX1KxEy2VhzMENtCaJ/X
 +n4Lu+GRJEpwVDdEOnHicNeoOoK7Ib7SoKXYtBSN7JXSnjMG9MpXFy8YX/1H+Mw5TmELDqcpbR
 Nq/FroQxHJMfXu4/T8/wBvQKOoW0AAAA=
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757597734; l=3654;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=PuabTONHOI3Wi68roDlpuNjBuN3i7VlZrimHSyEB9a4=;
 b=glgz8TmKPdfjoxU2fhiTiuY3u2CYMWBtsy1EWIlReG0Y7/rkvhQw8og1WicbmdEl04wuf+Kld
 G0AwrmmXJVeAKBoqlW9susPyvOywhE8qywLFWNPsSCnHncnkczIFkMJ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 11 Sep 2025 18:10:40 +0200
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
 board/freescale/imx93_frdm/imx93_frdm.c   |  6 ++++++
 board/freescale/imx93_frdm/imx93_frdm.env |  8 ++++++++
 configs/imx93_frdm_defconfig              | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/freescale/imx93_frdm/imx93_frdm.c
index c74fd85712f4..ab9ee040d8bf 100644
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
+		printf("Detect USB boot. Will enter fastboot mode!\n");
+		env_set_ulong("dofastboot", 1);
+	}
+
 	return 0;
 }
diff --git a/board/freescale/imx93_frdm/imx93_frdm.env b/board/freescale/imx93_frdm/imx93_frdm.env
index 528a953c8df1..ea5000f1c685 100644
--- a/board/freescale/imx93_frdm/imx93_frdm.env
+++ b/board/freescale/imx93_frdm/imx93_frdm.env
@@ -19,8 +19,16 @@ kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
+fastboot_partition_alias_all=0:0
+fastboot_partition_alias_bootloader=0.1
+emmc_dev=0
+sd_dev=0
+dofastboot=0
 
 bsp_bootcmd=
+	if test ${dofastboot} = 1; then
+		fastboot 0;
+	fi;
 	echo Running BSP bootcmd ...;
 	mmc dev ${mmcdev};
 	run mmcargs;
diff --git a/configs/imx93_frdm_defconfig b/configs/imx93_frdm_defconfig
index 4f837ca92828..3f96e1ddd4ff 100644
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
@@ -116,6 +123,12 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_SHA384=y

---
base-commit: 7a4f3c5652157cbb3d26a7728bfe537ea483efc9
change-id: 20250911-mathieu-frdm_imx93_fastboot-7ab00c562a4c

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

