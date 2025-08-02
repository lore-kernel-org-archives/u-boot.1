Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B657DC87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 22:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CD183CB1;
	Sun,  3 Aug 2025 00:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="m0E5SN4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D7683C72; Sun,  3 Aug 2025 00:08:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B060D83C72
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 00:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7e69=2P=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754172480; bh=jtoscAFAQVsZA5ku52+wcxrwILj+g3wVDkjO/TkTaFM=;
 b=m0E5SN4QpOXomBFXkFi1Oty5zBmIlZLx4IkC/b+lYgyg9HT+x2O0mP2ZKOiYGCl+UAKbdd+rC
 lv24HslaCOmbbBb9OJ2Z4yXkxlhyz5JrOAwXYIr9+/pJJTOLZMlNUzYC3OEbNKDY4hzi7zwI6WJ
 h9xUBCCzLIom/M8cdWWvzNYNRD7HrKyGEGTfNofgZqljB1PLdYbH+XSfFqf2ulxoux1TSl16SaR
 1CYUODvE985RcE/fpNdv7u8IeniDlctb3pl7KC0SMaStdrzHtLZZ7f5ALyOc7doB5ay3qhLedko
 KjKEO1xrTjCI0tSAr2E1EiCihJ/UarFFaKuaiRVZWimg==
X-Forward-Email-ID: 688e8c3d056e3a070faf35ab
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
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
Subject: [PATCH v3 2/4] rockchip: Add support for RAM boot from maskrom mode
Date: Sat,  2 Aug 2025 22:07:23 +0000
Message-ID: <20250802220738.3018910-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802220738.3018910-1-jonas@kwiboo.se>
References: <20250802220738.3018910-1-jonas@kwiboo.se>
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

A config fragment rockchip-ramboot.config can be used to enable building
of these two binman images, e.g.:

  make generic-rk3588_defconfig rockchip-ramboot.config

These binman images can be used with the proprietary rkbin boot_merger
tool to create a special loader image that can be used with tools such
as rkdeveloptool or rockusb tools to RAM boot from maskrom, e.g.:

  Create loader image:
    $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini

  Boot from maskrom:
    $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
   or
    $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin

Another option that does not require use of proprietary tools is using
open source tools such as rkflashtool or rkusbboot that can load the
binman images directly without any need to first create a special loader
image to RAM boot from maskrom, e.g.:

  $ rkflashtool l < u-boot-rockchip-usb471.bin
  $ rkflashtool L < u-boot-rockchip-usb472.bin
 or
  $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
---
Changes in v3:
- Use read_brom_bootsource_id() to support RAM boot on RK3576
- Add a rockchip-ramboot.config fragment to enable the Kconfig option
- Update commit message to highlight that the binman images can be used
  directly without use of the proprietary rkbin boot_merger tool

Changes in v2:
- Use fit_template instead of common_part
- Collect t-b tag
---
 arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          |  8 ++++++
 arch/arm/mach-rockchip/spl-boot-order.c | 14 ++++++++---
 board/rockchip/rockchip-ramboot.config  |  1 +
 boot/Kconfig                            |  3 +++
 5 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 board/rockchip/rockchip-ramboot.config

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index cc2feed6464f..71d7623fe2ca 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -226,5 +226,38 @@
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
index c9ce30760292..e32e49ff59ac 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -706,6 +706,14 @@ config ROCKCHIP_SPI_IMAGE
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
index 6b1b84dc86d1..15f1cba8e8fd 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -8,6 +8,7 @@
 #include <log.h>
 #include <mmc.h>
 #include <spl.h>
+#include <asm/arch-rockchip/bootrom.h>
 #include <asm/global_data.h>
 #include <dm/uclass-internal.h>
 
@@ -98,15 +99,22 @@ __weak const char *board_spl_was_booted_from(void)
 
 void board_boot_order(u32 *spl_boot_list)
 {
+	int idx = 0;
+
+	/* Add RAM boot for maskrom mode boot over USB */
+	if (BROM_BOOTSOURCE_ID_ADDR && CONFIG_IS_ENABLED(RAM_DEVICE) &&
+	    read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
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
@@ -115,7 +123,7 @@ void board_boot_order(u32 *spl_boot_list)
 	if (chosen_node < 0) {
 		debug("%s: /chosen not found, using spl_boot_device()\n",
 		      __func__);
-		spl_boot_list[0] = spl_boot_device();
+		spl_boot_list[idx++] = spl_boot_device();
 		return;
 	}
 
diff --git a/board/rockchip/rockchip-ramboot.config b/board/rockchip/rockchip-ramboot.config
new file mode 100644
index 000000000000..312363e542b7
--- /dev/null
+++ b/board/rockchip/rockchip-ramboot.config
@@ -0,0 +1 @@
+CONFIG_ROCKCHIP_MASKROM_IMAGE=y
diff --git a/boot/Kconfig b/boot/Kconfig
index 2ff6f0037384..2afad56ddfa6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -257,6 +257,9 @@ config SPL_LOAD_FIT_ADDRESS
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
2.50.1

