Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5502EC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FA780C59;
	Wed, 30 Jul 2025 14:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF038129F; Wed, 30 Jul 2025 14:03:33 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2564D8091A
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsW8264kzzGxw;
 Wed, 30 Jul 2025 14:03:30 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bsW815JRpzbbl; Wed, 30 Jul 2025 14:03:29 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 30 Jul 2025 14:03:18 +0200
Subject: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAUKimgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2MD3ZQS3eSM/OLUPN2k/PyS4vzSouRU3TTjZIuUlJRUIwMDQyWg1oK
 i1LTMCrCx0UpBbs5KsbW1ALDFqcFrAAAA
X-Change-ID: 20250730-dt-chosen-bootsource-f3c8ddde2001
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

From: Quentin Schulz <quentin.schulz@cherry.de>

U-Boot typically can be loaded from different storage media, such as
eMMC, SD card, SPI flash, but also from non-persistent media such as USB
(via proprietary protocols loading directly into SRAM, or fastboot, DFU,
 etc..), JTAG, ...

This information is usually reported by the BootROM via some proprietary
mechanism (some specific address in registers/DRAM for example). For
Rockchip, that information is stored in a register
(BROM_BOOTSOURCE_ID_ADDR).

While we already have the information about which medium was used to
load U-Boot proper from SPL (via /chosen/u-boot,spl-boot-device), this
new property represents the medium used to load U-Boot first phase
(depending on configuration, can be VPL/TPL/SPL) which absolutely may
differ from the one used to load U-Boot proper!

It would be useful to know which medium was used to load the first phase
of U-Boot, for example to check fallback mechanisms (proper loaded from
a different medium than first phase) are actually working.

For now, this only applies to Rockchip's U-Boot proper DT but could be
applied to the kernel's as well and possibly for other architectures or
vendors.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
I have a board (RK3399 Puma) running U-Boot which currently has 9 boot
scenarios (eMMC/SD/SPI-NOR for the first phase, eMMC/SD/SPI-NOR for the
next phases; not counting USB loading yet, which would make it a few
more). I cannot force the BootROM of this board to select a specific
device aside from erasing the other media.

The only way to identify which device was used for the first phase is to
parse U-Boot first phase console output or add some custom logic for my
board. To validate that a new version of the bootloader works, including
the fallback mechanisms, I need to make sure the BootROM loads the first
phase from the expected device otherwise I may have false positives.
This would be useful for automated testing.

Patches pending in the devicetree-spec[1] and dt-schema[2], hence the
RFC here.

[1] https://lore.kernel.org/devicetree-spec/20250505-bootsource-v2-1-5a315d9bff26@cherry.de/
[2] https://github.com/devicetree-org/dt-schema/pull/169
---
 arch/arm/mach-rockchip/spl-boot-order.c | 34 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 3dce9b30898d49a86ec1963846ffdddea521e201..1bfd120adc46d4c847fc81112033bcf193be96d3 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -242,30 +242,38 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
+	const char *bootrom_ofpath = board_spl_was_booted_from();
 	void *blob = spl_image_fdt_addr(spl_image);
 	char boot_ofpath[512];
 	int chosen, ret;
 
-	/*
-	 * Inject the ofpath of the device the full U-Boot (or Linux in
-	 * Falcon-mode) was booted from into the FDT, if a FDT has been
-	 * loaded at the same time.
-	 */
 	if (!blob)
 		return;
 
-	ret = spl_decode_boot_device(spl_image->boot_device, boot_ofpath, sizeof(boot_ofpath));
-	if (ret) {
-		pr_err("%s: could not map boot_device to ofpath: %d\n", __func__, ret);
-		return;
-	}
-
 	chosen = fdt_find_or_add_subnode(blob, 0, "chosen");
 	if (chosen < 0) {
 		pr_err("%s: could not find/create '/chosen'\n", __func__);
 		return;
 	}
-	fdt_setprop_string(blob, chosen,
-			   "u-boot,spl-boot-device", boot_ofpath);
+
+	/*
+	 * Inject the ofpath of the device the full U-Boot (or Linux in
+	 * Falcon-mode) was booted from into the FDT.
+	 */
+	ret = spl_decode_boot_device(spl_image->boot_device, boot_ofpath, sizeof(boot_ofpath));
+	if (ret)
+		pr_err("%s: could not map boot_device to ofpath: %d\n", __func__, ret);
+	else
+		fdt_setprop_string(blob, chosen,
+				   "u-boot,spl-boot-device", boot_ofpath);
+
+	/*
+	 * Inject the ofpath of the device the BootROM loaded the very first
+	 * stage from into the FDT.
+	 */
+	if (!bootrom_ofpath)
+		pr_err("%s: could not map BootROM boot device to ofpath\n", __func__);
+	else
+		fdt_setprop_string(blob, chosen, "bootsource", bootrom_ofpath);
 }
 #endif

---
base-commit: a8f20bb6650df56d2600cda2c66f9349df9e49c8
change-id: 20250730-dt-chosen-bootsource-f3c8ddde2001

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

