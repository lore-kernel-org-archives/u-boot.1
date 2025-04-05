Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D2CC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 15:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B7982AAE;
	Sat,  5 Apr 2025 17:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RrLZujoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844E182ABB; Sat,  5 Apr 2025 17:38:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0623F82A76
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743867529; bh=vel0yzgb5V9KZHAJQorzbzu0fA/LBH4jgPt4We/+r90=;
 b=RrLZujoYVP4AM2yindnfdXMvLjcWvSRM4fvzQyiYVR+5ljcF42iTCE1p7V2HwLTbuYt5DKjTf
 G+sjMK2+cavMAshwbea4FLoFNb4TgIkdhnYR5x6Xf/KO/eLLvyB1b2bceKzN+fNaUQ7bQYoJ5T6
 DwkB2NuJx5Ad2lSLoNOVu2Le4w5VhhRQ7a/Y5EkTuz/ntZPXJQnhMRQ4Dt9cwAzBberpF+WwXcn
 7SMoU/1TBS+le13Q9M3FiAbJHJndWB+gFejcEY8fsBe2Gj1PLn0Jc0NANPDlwB7JvCcm6JFSLPk
 jMSAOqpEE9ga1ZILi6w6R68aBu4ZE6eJG0Ziv/eg/C6Q==
X-Forward-Email-ID: 67f14e853dc50e09d12388e7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/4] rockchip: Add support for RAM boot from maskrom mode
Date: Sat,  5 Apr 2025 15:38:22 +0000
Message-ID: <20250405153832.1427549-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405153832.1427549-1-jonas@kwiboo.se>
References: <20250405153832.1427549-1-jonas@kwiboo.se>
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

The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
cannot be found in nand/spi/mmc storage.

In maskrom mode the USB OTG port can accept one of two custom commands.

Initially a 0x471 command to load TPL into SRAM. After TPL has been
executed and it has returned back-to-BROM, a 0x472 command to load SPL
into start of DRAM.

Add two binman images that can be used to RAM boot from maskrom mode:
- u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
- u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
  payload with i.e. U-Boot proper, TF-A and FDT.

These images can be used with rkbin tools/boot_merger to create a loader
image to be used with rkdeveloptool or rockusb tools, e.g.:

  Create loader image:
    $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini

  Boot from maskrom:
    $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
   or
    $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin

Or directly with tools such as rkflashtool or rkusbboot:

  $ rkflashtool l < u-boot-rockchip-usb471.bin
  $ rkflashtool L < u-boot-rockchip-usb472.bin
 or
  $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
---
v2: Use fit_template instead of common_part
v2: Collect t-b tag
---
 arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          |  8 ++++++
 arch/arm/mach-rockchip/spl-boot-order.c | 15 ++++++++---
 boot/Kconfig                            |  3 +++
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 0dfd45bb9bed..dafae297d0cf 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -231,5 +231,38 @@
 		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
+
+#ifdef CONFIG_ROCKCHIP_MASKROM_IMAGE
+	simple-bin-usb471 {
+		filename = "u-boot-rockchip-usb471.bin";
+
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+		rockchip-tpl {
+		};
+#elif defined(CONFIG_TPL)
+		u-boot-tpl {
+			no-write-symbols;
+		};
+#endif
+	};
+
+	simple-bin-usb472 {
+		filename = "u-boot-rockchip-usb472.bin";
+		pad-byte = <0x00>;
+
+		u-boot-spl {
+			no-write-symbols;
+		};
+
+#ifdef HAS_FIT
+		fit {
+			insert-template = <&fit_template>;
+#else
+		u-boot-img {
+#endif
+			offset = <(CONFIG_SPL_LOAD_FIT_ADDRESS - CFG_SYS_SDRAM_BASE)>;
+		};
+	};
+#endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
 };
 #endif /* CONFIG_SPL */
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index c9d8f9105083..e817bf46e565 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -607,6 +607,14 @@ config ROCKCHIP_SPI_IMAGE
 	  option to produce a SPI-flash image containing U-Boot. The image
 	  is built by binman. U-Boot sits near the start of the image.
 
+config ROCKCHIP_MASKROM_IMAGE
+	bool "Build a maskrom mode image for Rockchip"
+	depends on TPL || ROCKCHIP_EXTERNAL_TPL
+	select SPL_RAM_DEVICE
+	help
+	  Rockchip SoCs support maskrom mode boot over USB. Enable this
+	  option to produce maskrom mode boot images containing U-Boot.
+
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE
 
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 3dce9b30898d..20cbee8c9ff4 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -8,7 +8,9 @@
 #include <log.h>
 #include <mmc.h>
 #include <spl.h>
+#include <asm/arch-rockchip/bootrom.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <dm/uclass-internal.h>
 
 #if CONFIG_IS_ENABLED(OF_LIBFDT)
@@ -98,15 +100,22 @@ __weak const char *board_spl_was_booted_from(void)
 
 void board_boot_order(u32 *spl_boot_list)
 {
+	int idx = 0;
+
+	/* Add RAM boot for maskrom mode boot over USB */
+	if (BROM_BOOTSOURCE_ID_ADDR && CONFIG_IS_ENABLED(RAM_DEVICE) &&
+	    readl(BROM_BOOTSOURCE_ID_ADDR) == BROM_BOOTSOURCE_USB) {
+		spl_boot_list[idx++] = BOOT_DEVICE_RAM;
+	}
+
 	/* In case of no fdt (or only plat), use spl_boot_device() */
 	if (!CONFIG_IS_ENABLED(OF_CONTROL) || CONFIG_IS_ENABLED(OF_PLATDATA)) {
-		spl_boot_list[0] = spl_boot_device();
+		spl_boot_list[idx++] = spl_boot_device();
 		return;
 	}
 
 	const void *blob = gd->fdt_blob;
 	int chosen_node = fdt_path_offset(blob, "/chosen");
-	int idx = 0;
 	int elem;
 	int boot_device;
 	int node;
@@ -115,7 +124,7 @@ void board_boot_order(u32 *spl_boot_list)
 	if (chosen_node < 0) {
 		debug("%s: /chosen not found, using spl_boot_device()\n",
 		      __func__);
-		spl_boot_list[0] = spl_boot_device();
+		spl_boot_list[idx++] = spl_boot_device();
 		return;
 	}
 
diff --git a/boot/Kconfig b/boot/Kconfig
index f101200ba7a5..abfc9eaf325f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -246,6 +246,9 @@ config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
 	depends on SPL_LOAD_FIT
 	default 0x44000000 if ARCH_IMX8M
+	default 0x60080000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x60000000
+	default 0x40200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x40000000
+	default 0x00200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x00000000
 	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
-- 
2.49.0

