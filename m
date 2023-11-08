Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EC0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FF587230;
	Wed,  8 Nov 2023 18:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208D686CBD; Wed,  8 Nov 2023 18:26:04 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21478871A2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB4C4C0005;
 Wed,  8 Nov 2023 17:26:00 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 jonas@kwiboo.se, Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 heiko@sntech.de
Subject: [PATCH next v2 1/6] rockchip: rk3399: simplify logic for getting SPL
 boot medium DT node
Date: Wed,  8 Nov 2023 18:25:37 +0100
Message-ID: <20231108-rk3588-spl-boot-dev-v2-1-e67e26202c85@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108-rk3588-spl-boot-dev-v2-0-e67e26202c85@theobroma-systems.com>
References: <20231108-rk3588-spl-boot-dev-v2-0-e67e26202c85@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

In preparation of moving spl_perform_fixups to spl-boot-order.c, let's
simplify the logic around mapping the BOOT_DEVICE_x enum index to a DT
node by using an instantiated array of chars instead of creating a new
data structure on the fly.

This will make it easier to only define the spl_boot_devices array in
the appropriate SoC file in an upcoming commit.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 14565d2ed9f..60d95c81cd2 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -175,23 +175,27 @@ void board_debug_uart_init(void)
 #endif
 
 #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
+	[BOOT_DEVICE_MMC2] = "/mmc@fe320000",
+	[BOOT_DEVICE_MMC1] = "/mmc@fe330000",
+	[BOOT_DEVICE_SPI] = "/spi@ff1d0000/flash@0",
+};
+
 const char *spl_decode_boot_device(u32 boot_device)
 {
-	int i;
-	static const struct {
-		u32 boot_device;
-		const char *ofpath;
-	} spl_boot_devices_tbl[] = {
-		{ BOOT_DEVICE_MMC2, "/mmc@fe320000" },
-		{ BOOT_DEVICE_MMC1, "/mmc@fe330000" },
-		{ BOOT_DEVICE_SPI, "/spi@ff1d0000/flash@0" },
-	};
-
-	for (i = 0; i < ARRAY_SIZE(spl_boot_devices_tbl); ++i)
-		if (spl_boot_devices_tbl[i].boot_device == boot_device)
-			return spl_boot_devices_tbl[i].ofpath;
-
-	return NULL;
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
 }
 
 void spl_perform_fixups(struct spl_image_info *spl_image)

-- 
2.41.0

