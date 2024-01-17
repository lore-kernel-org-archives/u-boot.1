Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EBEC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EDD87BA9;
	Wed, 17 Jan 2024 18:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB9E87A4B; Wed, 17 Jan 2024 18:24:09 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6597987ABE
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFXmN045zzMpnXx;
 Wed, 17 Jan 2024 17:24:04 +0000 (UTC)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFXmM1q1hzl6F; Wed, 17 Jan 2024 18:24:03 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: heiko@sntech.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 jonas@kwiboo.se, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 3/6] rockchip: factor out spl_perform_fixups into common
 spl-boot-order
Date: Wed, 17 Jan 2024 18:22:57 +0100
Message-ID: <20240117-rk3588-spl-boot-dev-v3-3-72cb989e6da8@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
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

All SoCs are susceptible to wanting to know which storage medium was
used to load U-Boot SPL. So instead of reimplementing the same functions
in SoCs over and over again (here just rk3399 and px30 but rk3588 is
coming), let's just put all this in common into spl-boot-order.c
allowing to support a new SoC just by defining the spl_boot_devices
array in the appropriate SoC file.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/px30/px30.c      | 46 -------------------------------
 arch/arm/mach-rockchip/rk3399/rk3399.c  | 46 -------------------------------
 arch/arm/mach-rockchip/spl-boot-order.c | 49 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 8937677d79e..7676adcb044 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -449,50 +449,4 @@ const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
 	[BOOT_DEVICE_MMC2] = "/mmc@ff370000",
 	[BOOT_DEVICE_MMC1] = "/mmc@ff390000",
 };
-
-const char *spl_decode_boot_device(u32 boot_device)
-{
-	const char *spl_bootdevice_ofpath = NULL;
-
-	if (boot_device < ARRAY_SIZE(spl_boot_devices))
-		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
-
-	if (spl_bootdevice_ofpath)
-		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
-		      __func__, boot_device, spl_bootdevice_ofpath);
-	else
-		debug("%s: failed to resolve spl_bootdevice_id %x\n",
-		      __func__, boot_device);
-
-	return spl_bootdevice_ofpath;
-}
-
-void spl_perform_fixups(struct spl_image_info *spl_image)
-{
-	void *blob = spl_image->fdt_addr;
-	const char *boot_ofpath;
-	int chosen;
-
-	/*
-	 * Inject the ofpath of the device the full U-Boot (or Linux in
-	 * Falcon-mode) was booted from into the FDT, if a FDT has been
-	 * loaded at the same time.
-	 */
-	if (!blob)
-		return;
-
-	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
-	if (!boot_ofpath) {
-		pr_err("%s: could not map boot_device to ofpath\n", __func__);
-		return;
-	}
-
-	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
-	if (chosen < 0) {
-		pr_err("%s: could not find/create '/chosen'\n", __func__);
-		return;
-	}
-	fdt_setprop_string(blob, chosen,
-			   "u-boot,spl-boot-device", boot_ofpath);
-}
 #endif
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 60d95c81cd2..6929de5603c 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -181,52 +181,6 @@ const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
 	[BOOT_DEVICE_SPI] = "/spi@ff1d0000/flash@0",
 };
 
-const char *spl_decode_boot_device(u32 boot_device)
-{
-	const char *spl_bootdevice_ofpath = NULL;
-
-	if (boot_device < ARRAY_SIZE(spl_boot_devices))
-		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
-
-	if (spl_bootdevice_ofpath)
-		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
-		      __func__, boot_device, spl_bootdevice_ofpath);
-	else
-		debug("%s: failed to resolve spl_bootdevice_id %x\n",
-		      __func__, boot_device);
-
-	return spl_bootdevice_ofpath;
-}
-
-void spl_perform_fixups(struct spl_image_info *spl_image)
-{
-	void *blob = spl_image->fdt_addr;
-	const char *boot_ofpath;
-	int chosen;
-
-	/*
-	 * Inject the ofpath of the device the full U-Boot (or Linux in
-	 * Falcon-mode) was booted from into the FDT, if a FDT has been
-	 * loaded at the same time.
-	 */
-	if (!blob)
-		return;
-
-	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
-	if (!boot_ofpath) {
-		pr_err("%s: could not map boot_device to ofpath\n", __func__);
-		return;
-	}
-
-	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
-	if (chosen < 0) {
-		pr_err("%s: could not find/create '/chosen'\n", __func__);
-		return;
-	}
-	fdt_setprop_string(blob, chosen,
-			   "u-boot,spl-boot-device", boot_ofpath);
-}
-
 static void rk3399_force_power_on_reset(void)
 {
 	ofnode node;
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 93b8e7de4d0..55d0976fb0a 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <fdt_support.h>
 #include <log.h>
 #include <mmc.h>
 #include <spl.h>
@@ -161,4 +162,52 @@ void board_boot_order(u32 *spl_boot_list)
 	if (idx == 0)
 		spl_boot_list[0] = spl_boot_device();
 }
+
+__weak const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {};
+
+const char *spl_decode_boot_device(u32 boot_device)
+{
+	const char *spl_bootdevice_ofpath = NULL;
+
+	if (boot_device < ARRAY_SIZE(spl_boot_devices))
+		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
+
+	if (spl_bootdevice_ofpath)
+		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
+		      __func__, boot_device, spl_bootdevice_ofpath);
+	else
+		debug("%s: failed to resolve spl_bootdevice_id %x\n",
+		      __func__, boot_device);
+
+	return spl_bootdevice_ofpath;
+}
+
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	void *blob = spl_image->fdt_addr;
+	const char *boot_ofpath;
+	int chosen;
+
+	/*
+	 * Inject the ofpath of the device the full U-Boot (or Linux in
+	 * Falcon-mode) was booted from into the FDT, if a FDT has been
+	 * loaded at the same time.
+	 */
+	if (!blob)
+		return;
+
+	boot_ofpath = spl_decode_boot_device(spl_image->boot_device);
+	if (!boot_ofpath) {
+		pr_err("%s: could not map boot_device to ofpath\n", __func__);
+		return;
+	}
+
+	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
+	if (chosen < 0) {
+		pr_err("%s: could not find/create '/chosen'\n", __func__);
+		return;
+	}
+	fdt_setprop_string(blob, chosen,
+			   "u-boot,spl-boot-device", boot_ofpath);
+}
 #endif

-- 
2.43.0

