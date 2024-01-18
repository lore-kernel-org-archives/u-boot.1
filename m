Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E19C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 11:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5B787B8A;
	Thu, 18 Jan 2024 12:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB7F86FB2; Thu, 18 Jan 2024 12:41:38 +0100 (CET)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5AE87B8C
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 12:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TG16l02ZwzMpnYZ;
 Thu, 18 Jan 2024 11:41:35 +0000 (UTC)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TG16k31kPzyMq; Thu, 18 Jan 2024 12:41:34 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v4 4/6] rockchip: find U-boot proper boot device by inverting
 the logic that sets it
Date: Thu, 18 Jan 2024 12:41:17 +0100
Message-ID: <20240118-rk3588-spl-boot-dev-v4-4-23a97c82c77c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118-rk3588-spl-boot-dev-v4-0-23a97c82c77c@theobroma-systems.com>
References: <20240118-rk3588-spl-boot-dev-v4-0-23a97c82c77c@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

BOOT_DEVICE_* is set by spl_node_to_boot_device() depending on the block
device number associated with the MMC device the SPL used to load U-Boot
proper from. It is NOT related to the mmc alias in the Device Tree.

For SPI flashes, all SPI flashes will return BOOT_DEVICE_SPI so there's
currently no way to know from which one the SPL loaded U-Boot proper
from. Therefore, let's just find the first valid candidate in
/chosen/u-boot,spl-boot-order that is a SPI flash and return that path.
This is a best effort.

While the original implementation may have worked, using the exact same
mechanism but in inverted fashion makes it less likely to have
surprising corner-cases or side-effects.

A nice side-effect is that all existing and future Rockchip SoCs now
automatically have their /chosen/u-boot,spl-boot-device set.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/px30/px30.c      |  7 ---
 arch/arm/mach-rockchip/rk3399/rk3399.c  |  6 ---
 arch/arm/mach-rockchip/spl-boot-order.c | 91 ++++++++++++++++++++++++++-------
 3 files changed, 73 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 7676adcb044..fc7456e680c 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -443,10 +443,3 @@ void board_debug_uart_init(void)
 #endif /* CONFIG_DEBUG_UART_BASE && CONFIG_DEBUG_UART_BASE == ... */
 }
 #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
-
-#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
-const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
-	[BOOT_DEVICE_MMC2] = "/mmc@ff370000",
-	[BOOT_DEVICE_MMC1] = "/mmc@ff390000",
-};
-#endif
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 6929de5603c..801a4a6662e 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -175,12 +175,6 @@ void board_debug_uart_init(void)
 #endif
 
 #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
-const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
-	[BOOT_DEVICE_MMC2] = "/mmc@fe320000",
-	[BOOT_DEVICE_MMC1] = "/mmc@fe330000",
-	[BOOT_DEVICE_SPI] = "/spi@ff1d0000/flash@0",
-};
-
 static void rk3399_force_power_on_reset(void)
 {
 	ofnode node;
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 0cd3da20c95..fcc23151d3a 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -10,6 +10,7 @@
 #include <mmc.h>
 #include <spl.h>
 #include <asm/global_data.h>
+#include <dm/uclass-internal.h>
 
 #if CONFIG_IS_ENABLED(OF_LIBFDT)
 /**
@@ -163,30 +164,84 @@ void board_boot_order(u32 *spl_boot_list)
 		spl_boot_list[0] = spl_boot_device();
 }
 
-__weak const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {};
-
-const char *spl_decode_boot_device(u32 boot_device)
+int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 {
-	const char *spl_bootdevice_ofpath = NULL;
+	struct udevice *dev;
+	int dev_num, ret;
+
+	if (boot_device == BOOT_DEVICE_SPI) {
+		/* Revert spl_node_to_boot_device() logic to find appropriate SPI flash device */
+
+		/*
+		 * Devices with multiple SPI flash devices will take the first SPI flash found in
+		 * /chosen/u-boot,spl-boot-order.
+		 */
+		const void *blob = gd->fdt_blob;
+		int chosen_node = fdt_path_offset(blob, "/chosen");
+		int elem;
+		int node;
+		const char *conf;
+
+		if (chosen_node < 0) {
+			debug("%s: /chosen not found\n", __func__);
+			return -ENODEV;
+		}
+
+		for (elem = 0;
+		     (conf = fdt_stringlist_get(blob, chosen_node,
+						"u-boot,spl-boot-order", elem, NULL));
+		     elem++) {
+			const char *alias;
+
+			/* Handle the case of 'same device the SPL was loaded from' */
+			if (strncmp(conf, "same-as-spl", 11) == 0) {
+				conf = board_spl_was_booted_from();
+				if (!conf)
+					continue;
+			}
+
+			/* First check if the list element is an alias */
+			alias = fdt_get_alias(blob, conf);
+			if (alias)
+				conf = alias;
+
+			/* Try to resolve the config item (or alias) as a path */
+			node = fdt_path_offset(blob, conf);
+			if (node < 0) {
+				debug("%s: could not find %s in FDT\n", __func__, conf);
+				continue;
+			}
+
+			ret = uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &dev);
+			if (ret) {
+				debug("%s: could not find udevice for %s\n", __func__, conf);
+				continue;
+			}
 
-	if (boot_device < ARRAY_SIZE(spl_boot_devices))
-		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
+			return ofnode_get_path(dev_ofnode(dev), buf, buflen);
+		}
+
+		return -ENODEV;
+	}
 
-	if (spl_bootdevice_ofpath)
-		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
-		      __func__, boot_device, spl_bootdevice_ofpath);
-	else
-		debug("%s: failed to resolve spl_bootdevice_id %x\n",
-		      __func__, boot_device);
+	dev_num = (boot_device == BOOT_DEVICE_MMC1) ? 0 : 1;
+
+	ret = blk_find_device(UCLASS_MMC, dev_num, &dev);
+	if (ret) {
+		debug("%s: could not find blk device for MMC device %d: %d\n",
+		      __func__, dev_num, ret);
+		return ret;
+	}
 
-	return spl_bootdevice_ofpath;
+	dev = dev_get_parent(dev);
+	return ofnode_get_path(dev_ofnode(dev), buf, buflen);
 }
 
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	void *blob = spl_image_fdt_addr(spl_image);
-	const char *boot_ofpath;
-	int chosen;
+	char boot_ofpath[512];
+	int chosen, ret;
 
 	/*
 	 * Inject the ofpath of the device the full U-Boot (or Linux in
@@ -196,9 +251,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 	if (!blob)
 		return;
 
-	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
-	if (!boot_ofpath) {
-		pr_err("%s: could not map boot_device to ofpath\n", __func__);
+	ret = spl_decode_boot_device(spl_image->boot_device, boot_ofpath, sizeof(boot_ofpath));
+	if (ret) {
+		pr_err("%s: could not map boot_device to ofpath: %d\n", __func__, ret);
 		return;
 	}
 

-- 
2.43.0

