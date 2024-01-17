Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D5C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D869D879F8;
	Wed, 17 Jan 2024 18:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BECB387BA0; Wed, 17 Jan 2024 18:24:07 +0100 (CET)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:3:17::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C9B879ED
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFXmM1cw2zMqNGx;
 Wed, 17 Jan 2024 17:24:03 +0000 (UTC)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFXmL3wV6zl8c; Wed, 17 Jan 2024 18:24:02 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: heiko@sntech.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 jonas@kwiboo.se, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 2/6] rockchip: px30: simplify logic for getting SPL boot
 medium DT node
Date: Wed, 17 Jan 2024 18:22:56 +0100
Message-ID: <20240117-rk3588-spl-boot-dev-v3-2-72cb989e6da8@theobroma-systems.com>
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

In preparation of moving spl_perform_fixups to spl-boot-order.c, let's
simplify the logic around mapping the BOOT_DEVICE_x enum index to a DT
node by using an instantiated array of chars instead of creating a new
data structure on the fly.

This will make it easier to only define the spl_boot_devices array in
the appropriate SoC file in an upcoming commit.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/px30/px30.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 3bca25c609f..8937677d79e 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -445,22 +445,26 @@ void board_debug_uart_init(void)
 #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
 
 #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+const char * const spl_boot_devices[BOOT_DEVICE_NONE + 1] = {
+	[BOOT_DEVICE_MMC2] = "/mmc@ff370000",
+	[BOOT_DEVICE_MMC1] = "/mmc@ff390000",
+};
+
 const char *spl_decode_boot_device(u32 boot_device)
 {
-	int i;
-	static const struct {
-		u32 boot_device;
-		const char *ofpath;
-	} spl_boot_devices_tbl[] = {
-		{ BOOT_DEVICE_MMC2, "/mmc@ff370000" },
-		{ BOOT_DEVICE_MMC1, "/mmc@ff390000" },
-	};
+	const char *spl_bootdevice_ofpath = NULL;
+
+	if (boot_device < ARRAY_SIZE(spl_boot_devices))
+		spl_bootdevice_ofpath = spl_boot_devices[boot_device];
 
-	for (i = 0; i < ARRAY_SIZE(spl_boot_devices_tbl); ++i)
-		if (spl_boot_devices_tbl[i].boot_device == boot_device)
-			return spl_boot_devices_tbl[i].ofpath;
+	if (spl_bootdevice_ofpath)
+		debug("%s: spl_bootdevice_id %x maps to '%s'\n",
+		      __func__, boot_device, spl_bootdevice_ofpath);
+	else
+		debug("%s: failed to resolve spl_bootdevice_id %x\n",
+		      __func__, boot_device);
 
-	return NULL;
+	return spl_bootdevice_ofpath;
 }
 
 void spl_perform_fixups(struct spl_image_info *spl_image)

-- 
2.43.0

