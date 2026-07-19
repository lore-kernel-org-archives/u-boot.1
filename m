Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE050C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 11:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04F3842FC;
	Sun, 19 Jul 2026 13:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="czLZB2ib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D32846A4; Sun, 19 Jul 2026 13:44:13 +0200 (CEST)
Received: from mail-wm2-x0a.google.com (mail-wm2-x0a.google.com
 [IPv6:2a00:1450:4864:31::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC9B80517
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 13:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm2-x0a.google.com with SMTP id
 5b1f17b1804b1-495501e57beso3922785e9.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784461450; x=1785066250; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wr7c5oGp5iF+4nSQ0dxGcGd44/TmfAR9bhUmO+uSufI=;
 b=czLZB2ibjNACEEcv1B9S/+sejzAfLpWcxbOstBW5WA3v2cOrF406CDulQKdaKuLeLj
 Bi6RYKHtNtALscUWg7u9B843jMAAOhr2rcVEc6SkPun6sT/Xx3n3l3jxh2EqAuAfgOoX
 z9F5jZVktJSmTq92Dqs24C1n+v6j4OM9gbYFqUAzg9LhtZMjovHYVos78cPoPv7G0oWT
 F11WYpGnFihtz2IkDDs0Hfvhr8xqLtmDLJNbDQR1yCHpnVRSJO1DKDhLKr6N7qmOBEFt
 Ei8T+1n2Ubgadp6vX0mQDjQATT4vDCdnWHmrFBRuRsRV4IHmqEdKXgA78uZh54qgiuk5
 b/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784461450; x=1785066250;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wr7c5oGp5iF+4nSQ0dxGcGd44/TmfAR9bhUmO+uSufI=;
 b=swQftLIXmw94FHcE2eRyiC+0a+w7jn/7ohIVG7Y1EdRnF6OKu6NA3u58b1Pl4/yQly
 X+AWBGvvp9jobXHrh1UewJh2mhVzsOmcsrQF9N02NuFTcePwTGk4fyvCYvPKuGk1JUVG
 2hXD5RjfJzCgMXZ3ytbmxbPLmBARpCN73dsxj4Rog864irlEUx4Y8aX5mNW8aOGDCFqQ
 k1sQzmzRHo7t9toEISx3hEEMxxeLRAzOM67+t+W1cDfZa5fDvT2RmISw0y0LzQkP8I0b
 jndgrT8mJzpSWBJIbLkpeqChgn7CQPXijrwDPrvudXufOC3c4oAkm79FsaXy1C7thjrp
 eecw==
X-Gm-Message-State: AOJu0YwpEV97LqsWpHNsglY/LInkFJne0fp3azbdc8MIUzbVHP+ef9Hp
 +y/s1QpkLfZ+YTDJF7ubXe4y9D/CHC0oTRaCHK0wtQuag9xlXAQRPaJTC/lD37nJvGoiKrZRmZS
 Z9zpoe0FM209ThbA=
X-Gm-Gg: AfdE7clmNkA+xBb/xUtB8ljrpcGixxgSfkAlj5kmyY0lYlQGzfGNu+kzCJAcn9oT8LZ
 9rP2nXI2uuulWB9/SFFN0Rp9QLIc2uvSX29lT/8ydYd4mcWKOx3lis2UfsRz6tV0WoEex8TBGdi
 KkrAVM++kApLxR4Tn16P9OYJK0MNbnSmORrSSrPARGIj9U5CVQ1z3n5IbGXzsM4Fp7xv3znVPBm
 59Nzqhb9UBrgxYb85xY6LMOMElIi9UrZZ1RhlutW/zCWyxxUecCtmTiOEepZFMvOUDH971r34qW
 NaN12qiGmzQbq94w0ltlTo8VXQ3HESJutdl850v1L/VPsBxfJwgXcGjn4xKaiK09K9GLTZ+3j8V
 9FfTVj5u8xeoHlj5EjRJprLiL/1jf85ZEmrTuF6vWJprv1FNqQH8U/SRl40R5T7zym+v63JcVSq
 m20Iqp+euuDQy4rAoK3nj6pPfkAAOLY4X1d1f6EnIn2I1AYqraHWmWzzJGRrrwzKRoKzLERUkOv
 w==
X-Received: by 2002:a05:6000:491c:b0:47f:73fb:daa1 with SMTP id
 ffacd0b85a97d-47f73fbdae1mr1953203f8f.19.1784461448916; 
 Sun, 19 Jul 2026 04:44:08 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa
 (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7f55sm18401082f8f.18.2026.07.19.04.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 04:44:08 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 19 Jul 2026 13:43:46 +0200
Subject: [PATCH RFC] fastboot: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UATShW3ggdwW1xM4kQj2oRMK
 oXSu3fUxV+8z+MtIFwiCxybBQp/osQ0KphdA/5B450x3pTBtrZv9+aA3pMqjFOWWpjeKPmFgaS
 6lCqaLpB1vdN1oI1cOMT51x/gcj7B9X/K5J7s67cM67oBIuLiq4YAAAA=
X-Change-ID: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

Some recovery and initial-provisioning flows run before usable firmware is
available in persistent storage. In these flows the SoC ROM loads a small
first stage, but that stage must still provide a standard protocol with
which the host can provision the device.

U-Boot already provides fastboot for this purpose, but its implementation
is currently restricted to U-Boot proper and coupled to command-line
support. This forces platforms that need provisioning from SPL to maintain
a separate downloader or an out-of-tree fastboot implementation.

Allow boards to run USB fastboot as a service directly from SPL. Include
MMC partition flashing and Android sparse-image handling so that the SPL
service can provision the same storage images accepted by fastboot in
U-Boot proper.

Keep the SPL interface deliberately narrower. The fastboot boot command
is not supported because SPL is being used for provisioning rather than
OS boot orchestration. Filesystem probing is also omitted, so partition
types are reported as raw. Reboot support remains optional since reset
and persistent reboot-reason handling are platform-specific.

SPL size remains an important constraint. Make the support entirely
opt-in and phase-specific: when CONFIG_SPL_FASTBOOT is disabled, no
fastboot code or supporting library is added to SPL and its binary size
is unchanged.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/fastboot.c                  | 60 +++++----------------------
 doc/android/fastboot.rst        | 27 ++++++++++++-
 drivers/Makefile                |  2 +-
 drivers/fastboot/Kconfig        | 89 ++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/Makefile       | 13 ++++--
 drivers/fastboot/fb_block.c     |  9 ++---
 drivers/fastboot/fb_command.c   | 58 +++++++++++++++++++--------
 drivers/fastboot/fb_common.c    | 25 +++++++++++-
 drivers/fastboot/fb_getvar.c    | 19 +++++----
 drivers/fastboot/fb_mmc.c       | 36 ++++++++---------
 drivers/fastboot/fb_usb.c       | 68 +++++++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile     |  1 +
 drivers/usb/gadget/f_fastboot.c |  6 ++-
 include/fastboot.h              | 10 +++++
 lib/Kconfig                     | 11 +++++
 lib/Makefile                    |  3 +-
 lib/image-sparse.c              |  2 +-
 17 files changed, 328 insertions(+), 111 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f3929f88dfa..b12f9ea0ac4 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -7,12 +7,9 @@
  * Rob Herring <robh@kernel.org>
  */
 #include <command.h>
-#include <console.h>
-#include <g_dnl.h>
 #include <fastboot.h>
 #include <net.h>
-#include <usb.h>
-#include <watchdog.h>
+#include <vsprintf.h>
 #include <linux/printk.h>
 #include <linux/stringify.h>
 
@@ -63,7 +60,6 @@ static int do_fastboot_usb(int argc, char *const argv[],
 {
 	int controller_index;
 	char *usb_controller;
-	struct udevice *udc;
 	char *endp;
 	int ret;
 
@@ -82,48 +78,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
-	ret = udc_device_get_by_index(controller_index, &udc);
-	if (ret) {
-		pr_err("USB init failed: %d\n", ret);
-		return CMD_RET_FAILURE;
-	}
-
-	g_dnl_clear_detach();
-	ret = g_dnl_register("usb_dnl_fastboot");
-	if (ret)
-		return ret;
-
-	if (!g_dnl_board_usb_cable_connected()) {
-		puts("\rUSB cable not detected.\n" \
-		     "Command exit.\n");
-		ret = CMD_RET_FAILURE;
-		goto exit;
-	}
-
-	while (1) {
-		if (g_dnl_detach())
-			break;
-		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
-			if (tstc()) {
-				getchar();
-				puts("\rOperation aborted.\n");
-				break;
-			}
-		} else if (ctrlc()) {
-			break;
-		}
-		schedule();
-		dm_usb_gadget_handle_interrupts(udc);
-	}
-
-	ret = CMD_RET_SUCCESS;
-
-exit:
-	udc_device_put(udc);
-	g_dnl_unregister();
-	g_dnl_clear_detach();
+	ret = fastboot_usb_start(controller_index, (void *)buf_addr, buf_size);
 
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -167,13 +124,14 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	fastboot_init((void *)buf_addr, buf_size);
-
 #if CONFIG_IS_ENABLED(NET_LEGACY)
-	if (!strcmp(argv[1], "udp"))
-		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
-	if (!strcmp(argv[1], "tcp"))
+	if (!strcmp(argv[1], "udp") || !strcmp(argv[1], "tcp")) {
+		fastboot_init((void *)buf_addr, buf_size);
+		if (!strcmp(argv[1], "udp"))
+			return do_fastboot_udp(argc, argv, buf_addr, buf_size);
+
 		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
+	}
 #endif
 	if (!strcmp(argv[1], "usb")) {
 		argv++;
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 96c544ae11b..3f9cfb2fa78 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -10,7 +10,7 @@ The protocol that is used over USB and UDP is described in [1]_.
 
 The current implementation supports the following standard commands:
 
-- ``boot``
+- ``boot`` (not available in SPL)
 - ``continue``
 - ``download``
 - ``erase`` (if enabled)
@@ -72,6 +72,31 @@ platform. The location of the buffer and size are set with
 may be overridden on the fastboot command line using ``-l`` and
 ``-s``.
 
+Fastboot in SPL
+^^^^^^^^^^^^^^^
+
+Fastboot can be used from SPL without enabling the command line. Enable
+``CONFIG_SPL_FASTBOOT`` together with the platform's SPL USB gadget support,
+then start the session from board code::
+
+   ret = fastboot_usb_start(controller_index, NULL, 0);
+
+A ``NULL`` buffer and zero size select ``CONFIG_FASTBOOT_BUF_ADDR`` and
+``CONFIG_FASTBOOT_BUF_SIZE``. Passing explicit values overrides these
+defaults. The ``continue`` command ends the session and returns control to the
+caller. Unlike the command-line invocation, an SPL session cannot be aborted
+from the local console.
+
+MMC flash and erase support is enabled with
+``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
+storage layout must also be enabled, for example ``CONFIG_SPL_EFI_PARTITION``
+for GPT.
+
+The ``boot`` command is not available in SPL. Reboot commands require
+``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform ``reset_cpu()`` implementation.
+The ``reboot-bootloader``, ``reboot-fastboot`` and ``reboot-recovery`` commands
+also require a platform ``fastboot_set_reboot_flag()`` implementation.
+
 Fastboot environment variables
 ------------------------------
 
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..43d03479146 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)DMA) += dma/
 obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
 obj-$(CONFIG_$(PHASE_)DFU) += dfu/
 obj-$(CONFIG_$(PHASE_)EXTCON) += extcon/
+obj-$(CONFIG_$(PHASE_)FASTBOOT) += fastboot/
 obj-$(CONFIG_$(PHASE_)GPIO) += gpio/
 obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
@@ -93,7 +94,6 @@ obj-y += block/
 obj-y += cache/
 obj-$(CONFIG_CPU) += cpu/
 obj-y += crypto/
-obj-$(CONFIG_FASTBOOT) += fastboot/
 obj-$(CONFIG_FWU_MDATA) += fwu-mdata/
 obj-y += misc/
 obj-$(CONFIG_MMC) += mmc/
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 90212fcf9ef..017fb7956a1 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,6 @@
 menu "Fastboot support"
-	depends on CMDLINE
+
+if CMDLINE
 
 config FASTBOOT
 	bool
@@ -47,7 +48,27 @@ config TCP_FUNCTION_FASTBOOT
 	help
 	  This enables the fastboot protocol over TCP.
 
-if FASTBOOT
+endif # CMDLINE
+
+config SPL_FASTBOOT
+	bool "Support fastboot in SPL"
+	depends on USB_GADGET && SPL_USB_GADGET
+	depends on SPL_ENV_SUPPORT
+	depends on !SPL_USE_TINY_PRINTF
+	select SPL_LIBCOMMON_SUPPORT
+	select SPL_LIBGENERIC_SUPPORT
+	select SPL_PRINTF
+	help
+	  Enable the USB fastboot protocol in SPL. The board is responsible
+	  for starting the fastboot session.
+
+config SPL_FASTBOOT_REBOOT
+	bool "Enable fastboot reboot commands in SPL"
+	depends on SPL_FASTBOOT
+	help
+	  Enable the fastboot reboot commands in SPL.
+
+if FASTBOOT || SPL_FASTBOOT
 
 config FASTBOOT_BUF_ADDR
 	hex "Define FASTBOOT buffer address"
@@ -79,6 +100,10 @@ config FASTBOOT_BUF_SIZE
 	  downloads. This buffer should be as large as possible for a
 	  platform. Define this to the size available RAM for fastboot.
 
+endif # FASTBOOT || SPL_FASTBOOT
+
+if FASTBOOT
+
 config FASTBOOT_USB_DEV
 	int "USB controller number"
 	depends on USB_FUNCTION_FASTBOOT
@@ -294,4 +319,64 @@ config FASTBOOT_OEM_BOARD
 
 endif # FASTBOOT
 
+config SPL_FASTBOOT_FLASH
+	bool
+	default y if SPL_FASTBOOT_FLASH_MMC
+	select SPL_IMAGE_SPARSE
+
+config SPL_FASTBOOT_FLASH_MMC
+	bool "Enable fastboot MMC flashing in SPL"
+	depends on SPL_FASTBOOT && SPL_MMC && SPL_DM_MMC && SPL_PARTITIONS
+	select SPL_MMC_WRITE
+	help
+	  Build the fastboot MMC flashing backend into SPL. This allows the
+	  fastboot flash and erase commands to operate on MMC partitions. A
+	  suitable SPL partition-table parser must also be enabled.
+
+config SPL_FASTBOOT_FLASH_MMC_DEV
+	int "Define fastboot MMC flash device in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	default 0
+	help
+	  Define the MMC device that the SPL fastboot flash backend uses.
+
+config SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	bool "Enable eMMC boot-partition flash/erase in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SUPPORT_EMMC_BOOT
+	help
+	  Enable the special fastboot targets used to flash or erase the eMMC
+	  boot hardware partitions from SPL.
+
+config SPL_FASTBOOT_MMC_BOOT1_NAME
+	string "Target name for updating eMMC boot partition 1 in SPL"
+	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	default "mmc0boot0"
+
+config SPL_FASTBOOT_MMC_BOOT2_NAME
+	string "Target name for updating eMMC boot partition 2 in SPL"
+	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	default "mmc0boot1"
+
+config SPL_FASTBOOT_MMC_USER_SUPPORT
+	bool "Enable eMMC user-area flash/erase in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	help
+	  Enable a special fastboot target for flashing or erasing the complete
+	  eMMC user area from SPL.
+
+config SPL_FASTBOOT_MMC_USER_NAME
+	string "Target name for updating the eMMC user area in SPL"
+	depends on SPL_FASTBOOT_MMC_USER_SUPPORT
+	default "mmc0"
+
+config SPL_FASTBOOT_GPT_NAME
+	string "Target name for updating GPT from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SPL_EFI_PARTITION
+	default "gpt"
+
+config SPL_FASTBOOT_MBR_NAME
+	string "Target name for updating MBR from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SPL_DOS_PARTITION
+	default "mbr"
+
 endmenu
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index a341af076d1..43e391d8ec4 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,8 +3,13 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
-obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
+ifndef CONFIG_XPL_BUILD
+obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
+else
+obj-$(CONFIG_SPL_FASTBOOT) += fb_usb.o
+endif
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
-obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
-obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
-obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_NAND) += fb_nand.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_SPI) += fb_spi_flash.o
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 51d1abb18c7..9658b14e668 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -130,11 +130,10 @@ int fastboot_block_get_part_info(const char *part_name,
 				 char *response)
 {
 	int ret;
-	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   NULL);
-	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	const char *interface = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+		(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)), (NULL));
+	const int device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+		(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)), (-1));
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..4a3cc4cbb27 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -37,9 +37,9 @@ static void getvar(char *, char *);
 static void download(char *, char *);
 static void flash(char *, char *);
 static void erase(char *, char *);
-static void reboot_bootloader(char *, char *);
-static void reboot_fastbootd(char *, char *);
-static void reboot_recovery(char *, char *);
+static void __maybe_unused reboot_bootloader(char *, char *);
+static void __maybe_unused reboot_fastbootd(char *, char *);
+static void __maybe_unused reboot_recovery(char *, char *);
 static void oem_format(char *, char *);
 static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
@@ -70,7 +70,9 @@ static const struct {
 	},
 	[FASTBOOT_COMMAND_BOOT] =  {
 		.command = "boot",
+#ifndef CONFIG_XPL_BUILD
 		.dispatch = okay
+#endif
 	},
 	[FASTBOOT_COMMAND_CONTINUE] =  {
 		.command = "continue",
@@ -78,19 +80,38 @@ static const struct {
 	},
 	[FASTBOOT_COMMAND_REBOOT] =  {
 		.command = "reboot",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
+#else
 		.dispatch = okay
+#endif
 	},
 	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
 		.command = "reboot-bootloader",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_bootloader), (NULL))
+#else
 		.dispatch = reboot_bootloader
+#endif
 	},
 	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
 		.command = "reboot-fastboot",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_fastbootd), (NULL))
+#else
 		.dispatch = reboot_fastbootd
+#endif
 	},
 	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
 		.command = "reboot-recovery",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_recovery), (NULL))
+#else
 		.dispatch = reboot_recovery
+#endif
 	},
 	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
 		.command = "set_active",
@@ -339,19 +360,19 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
 					   image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
 		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
 					  image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 }
@@ -367,16 +388,16 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
 		fastboot_nand_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_erase(cmd_parameter, response);
 }
 
@@ -482,8 +503,9 @@ static void reboot_recovery(char *cmd_parameter, char *response)
 static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!env_get("partitions")) {
 		fastboot_fail("partitions not set", response);
@@ -505,8 +527,9 @@ static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
@@ -531,8 +554,9 @@ static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 9c52e004588..bd8ba8824de 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -12,6 +12,7 @@
 
 #include <bcb.h>
 #include <command.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <fastboot.h>
 #include <net.h>
@@ -89,6 +90,14 @@ void fastboot_okay(const char *reason, char *response)
  * which sets whatever flag your board specific Android bootloader flow
  * requires in order to re-enter the bootloader.
  */
+#ifdef CONFIG_XPL_BUILD
+int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
+{
+	(void)reason;
+
+	return -EOPNOTSUPP;
+}
+#else
 int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 {
 	int ret;
@@ -127,6 +136,7 @@ out:
 	bcb_reset();
 	return ret;
 }
+#endif
 
 /**
  * fastboot_get_progress_callback() - Return progress callback
@@ -138,6 +148,7 @@ void (*fastboot_get_progress_callback(void))(const char *)
 	return fastboot_progress_callback;
 }
 
+#ifndef CONFIG_XPL_BUILD
 /**
  * fastboot_boot() - Execute fastboot boot command
  *
@@ -175,6 +186,7 @@ void fastboot_boot(void)
 		do_reset(NULL, 0, 0, NULL);
 	}
 }
+#endif /* !CONFIG_XPL_BUILD */
 
 /**
  * fastboot_handle_boot() - Shared implementation of system reaction to
@@ -189,12 +201,14 @@ void fastboot_handle_boot(int command, bool success)
 		return;
 
 	switch (command) {
+#ifndef CONFIG_XPL_BUILD
 	case FASTBOOT_COMMAND_BOOT:
 		fastboot_boot();
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 		net_set_state(NETLOOP_SUCCESS);
 #endif
 		break;
+#endif
 
 	case FASTBOOT_COMMAND_CONTINUE:
 #if CONFIG_IS_ENABLED(NET_LEGACY)
@@ -206,7 +220,14 @@ void fastboot_handle_boot(int command, bool success)
 	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
 	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
 	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
+#ifdef CONFIG_XPL_BUILD
+#if CONFIG_IS_ENABLED(FASTBOOT_REBOOT)
+		/* SPL may omit CMDLINE, so use the platform reset hook directly. */
+		reset_cpu();
+#endif
+#else
 		do_reset(NULL, 0, 0, NULL);
+#endif
 		break;
 	}
 }
@@ -234,8 +255,8 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
  */
 void fastboot_init(void *buf_addr, u32 buf_size)
 {
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
-	if (!strcmp(CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc"))
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)
+	if (!strcmp(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME), "mmc"))
 		printf("Warning: the fastboot block backend features are limited, consider using the MMC backend\n");
 #endif
 
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..608a62299af 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -70,19 +70,19 @@ static const struct {
 		.variable = "current-slot",
 		.dispatch = getvar_current_slot,
 		.list = true
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	}, {
 		.variable = "has-slot",
 		.dispatch = getvar_has_slot,
 		.list = false
 #endif
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)
 	}, {
 		.variable = "partition-type",
 		.dispatch = getvar_partition_type,
 		.list = false
 #endif
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	}, {
 		.variable = "partition-size",
 		.dispatch = getvar_partition_size,
@@ -116,21 +116,21 @@ static int getvar_get_part_info(const char *part_name, char *response,
 	struct disk_partition disk_part;
 	struct part_info *part_info;
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)) {
 		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
 						 response);
 		if (r >= 0 && size)
 			*size = disk_part.size * disk_part.blksz;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)) {
 		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
 					       response);
 		if (r >= 0 && size)
 			*size = disk_part.size * disk_part.blksz;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND)) {
 		r = fastboot_nand_get_part_info(part_name, &part_info, response);
 		if (r >= 0 && size)
 			*size = part_info->size;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI)) {
 		r = fastboot_spi_flash_get_part_info(part_name, &disk_part,
 						     response);
 		if (r >= 0 && size)
@@ -240,12 +240,17 @@ static void __maybe_unused getvar_partition_type(char *part_name, char *response
 	r = fastboot_mmc_get_part_info(part_name, &dev_desc, &part_info,
 				       response);
 	if (r >= 0) {
+#ifdef CONFIG_XPL_BUILD
+		/* SPL does not pull in filesystem probing just for this getvar. */
+		fastboot_okay("raw", response);
+#else
 		r = fs_set_blk_dev_with_part(dev_desc, r);
 		if (r < 0)
 			/* If we don't know then just default to raw */
 			fastboot_okay("raw", response);
 		else
 			fastboot_okay(fs_get_type_name(), response);
+#endif
 	}
 }
 
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 9bc782ccd02..ae33e35365b 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -75,7 +75,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
 	int ret;
 
 	/* First try partition names on the default device */
-	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	*dev_desc = blk_get_dev("mmc", CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 	if (*dev_desc) {
 		ret = part_get_info_by_name(*dev_desc, name, info);
 		if (ret >= 0)
@@ -111,7 +111,7 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
 	return do_get_part_info(dev_desc, name, info);
 }
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
 static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 			    int hwpart, u32 buff_sz, char *response)
 {
@@ -130,7 +130,7 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 }
 #endif
 
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
+#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
 /**
  * Read Android boot image header from boot partition.
  *
@@ -346,7 +346,7 @@ int fastboot_mmc_get_part_info(const char *part_name,
 static struct blk_desc *fastboot_mmc_get_dev(char *response)
 {
 	struct blk_desc *ret = blk_get_dev("mmc",
-					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
+					   CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 
 	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
 		pr_err("invalid mmc device\n");
@@ -370,15 +370,15 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	struct blk_desc *dev_desc;
 	struct disk_partition info = {0};
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, download_buffer, 1,
 					download_bytes, response);
 		return;
 	}
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, download_buffer, 2,
@@ -388,7 +388,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #endif
 
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
-	if (strcmp(cmd, CONFIG_FASTBOOT_GPT_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_GPT_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -415,7 +415,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
-	if (strcmp(cmd, CONFIG_FASTBOOT_MBR_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MBR_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -440,7 +440,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	}
 #endif
 
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
+#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
 	if (strncasecmp(cmd, "zimage", 6) == 0) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
@@ -450,8 +450,8 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	}
 #endif
 
-#if IS_ENABLED(CONFIG_FASTBOOT_MMC_USER_SUPPORT)
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -485,17 +485,17 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 {
 	struct blk_desc *dev_desc;
 	struct disk_partition info;
-	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	struct mmc *mmc = find_mmc_device(CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
 		/* erase EMMC boot1 */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, NULL, 1, 0, response);
 		return;
 	}
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
 		/* erase EMMC boot2 */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
@@ -504,8 +504,8 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 	}
 #endif
 
-#ifdef CONFIG_FASTBOOT_MMC_USER_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
 		/* erase EMMC userdata */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
new file mode 100644
index 00000000000..b6637c49fd8
--- /dev/null
+++ b/drivers/fastboot/fb_usb.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2008 - 2009 Windriver, <www.windriver.com>
+ * Author: Tom Rix <Tom.Rix@windriver.com>
+ *
+ * (C) Copyright 2014 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ */
+
+#include <console.h>
+#include <fastboot.h>
+#include <g_dnl.h>
+#include <usb.h>
+#include <u-boot/schedule.h>
+#include <linux/errno.h>
+#include <linux/printk.h>
+
+int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size)
+{
+	struct udevice *udc;
+	int ret;
+
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	fastboot_init(buf_addr, buf_size);
+	g_dnl_clear_detach();
+
+	ret = g_dnl_register("usb_dnl_fastboot");
+	if (ret)
+		goto err_put;
+
+	if (!g_dnl_board_usb_cable_connected()) {
+		puts("\rUSB cable not detected.\n");
+		ret = -ENODEV;
+		goto err_unregister;
+	}
+
+	while (!g_dnl_detach()) {
+#ifndef CONFIG_XPL_BUILD
+		/* SPL callers own the session lifetime and may have no console. */
+		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
+			if (tstc()) {
+				getchar();
+				puts("\rOperation aborted.\n");
+				break;
+			}
+		} else if (ctrlc()) {
+			break;
+		}
+#endif
+		schedule();
+		dm_usb_gadget_handle_interrupts(udc);
+	}
+
+	ret = 0;
+
+err_unregister:
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+err_put:
+	udc_device_put(udc);
+
+	return ret;
+}
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index f2aebf4e480..87ec0cf6c40 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_$(PHASE_)USB_ETH_RNDIS) += rndis.o
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
 obj-$(CONFIG_SPL_DFU) += f_dfu.o
+obj-$(CONFIG_SPL_FASTBOOT) += f_fastboot.o
 obj-$(CONFIG_SPL_USB_SDP_SUPPORT) += f_sdp.o
 endif
 
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d..49cacde9db5 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -422,7 +422,7 @@ static int fastboot_tx_write_str(const char *buffer)
 static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
 {
 	g_dnl_unregister();
-	do_reset(NULL, 0, 0, NULL);
+	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
 }
 
 static unsigned int rx_bytes_expected(struct usb_ep *ep)
@@ -490,11 +490,13 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 	g_dnl_trigger_detach();
 }
 
+#ifndef CONFIG_XPL_BUILD
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	fastboot_boot();
 	do_exit_on_complete(ep, req);
 }
+#endif
 
 static int multiresponse_cmd = -1;
 static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req)
@@ -560,7 +562,9 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 	if (!strncmp("OKAY", response, 4)) {
 		switch (cmd) {
 		case FASTBOOT_COMMAND_BOOT:
+#ifndef CONFIG_XPL_BUILD
 			fastboot_func->in_req->complete = do_bootm_on_complete;
+#endif
 			break;
 
 		case FASTBOOT_COMMAND_CONTINUE:
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..b7b661b9591 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
  */
 void fastboot_init(void *buf_addr, u32 buf_size);
 
+/**
+ * fastboot_usb_start() - run a USB fastboot session
+ *
+ * @controller_index: USB gadget controller index
+ * @buf_addr: Pointer to download buffer, or NULL for default
+ * @buf_size: Size of download buffer, or zero for default
+ * Return: 0 on success, or a negative error code
+ */
+int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size);
+
 /**
  * fastboot_boot() - Execute fastboot boot command
  *
diff --git a/lib/Kconfig b/lib/Kconfig
index 24e55ade4d3..07ee3c88fd3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -205,6 +205,9 @@ config VPL_STRTO
 config IMAGE_SPARSE
 	bool
 
+config SPL_IMAGE_SPARSE
+	bool
+
 config IMAGE_SPARSE_FILLBUF_SIZE
 	hex "Android sparse image CHUNK_TYPE_FILL buffer size"
 	default 0x80000
@@ -213,6 +216,14 @@ config IMAGE_SPARSE_FILLBUF_SIZE
 	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
 	  chunks.
 
+config SPL_IMAGE_SPARSE_FILLBUF_SIZE
+	hex "Android sparse image fill buffer size in SPL"
+	default 0x80000
+	depends on SPL_IMAGE_SPARSE
+	help
+	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
+	  chunks in SPL.
+
 config USE_PRIVATE_LIBGCC
 	bool "Use private libgcc"
 	depends on HAVE_PRIVATE_LIBGCC
diff --git a/lib/Makefile b/lib/Makefile
index 222378a8531..014fda82860 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
 endif
 
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
-obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
 obj-y += ldiv.o
 obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
@@ -56,6 +55,8 @@ obj-y += list_sort.o
 obj-$(CONFIG_PMBUS) += pmbus.o
 endif
 
+obj-$(CONFIG_$(PHASE_)IMAGE_SPARSE) += image-sparse.o
+
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
 ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 09225692e9b..48e5d8ee869 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -125,7 +125,7 @@ int write_sparse_image(struct sparse_storage *info,
 	int i;
 	int j;
 
-	fill_buf_num_blks = CONFIG_IMAGE_SPARSE_FILLBUF_SIZE / info->blksz;
+	fill_buf_num_blks = CONFIG_VAL(IMAGE_SPARSE_FILLBUF_SIZE) / info->blksz;
 
 	/* Read and skip over sparse image header */
 	sparse_header = (sparse_header_t *)data;

---
base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
change-id: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

