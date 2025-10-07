Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FA0CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4911D838C7;
	Tue,  7 Oct 2025 10:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="ApspwBu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0E483923; Tue,  7 Oct 2025 10:18:27 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDB48388D
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5BA18C9A4F; Tue,  7 Oct 2025 10:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825104; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=wJczPykMG4yZFFfmdOqBIa6QKd31E7J3wpYu3WhGdEQ=;
 b=ApspwBu/XgXqk6/ZzAo2F0f1u64jHQX3hs0aOiPZNUrgnG0zNJfQBtB5xXDXHE5F7VOB67
 D/jmup6VvHVN6UNFYCJq4w7cN3kv7qNbKXHEduZ9y/Ph5b38880FdFjHY76Ua5OiBPcxTw
 N/yiJ4EQNZgao4ux3PDWz/3fleMWOV56K1yobBPrPdMhDoTGcnIhEvFMY5vPUt1xUBZeJ+
 jh2dwWubEDImX8JxxEf61JeH0fABcD5+M5geSo2ZCI1iEOZQQgN91ndgbgVLK5J24+jB65
 cWzcp6VwZJRJaSvTv+d2T3hmEWRm2800F9WsSP+ZQm+ztsT4Zd8Adhs9ngmOew==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 10/13] imx: kontron-sl-mx8mm: Enable USB hub on BL i.MX8MM
 OSM-S board
Date: Tue,  7 Oct 2025 10:16:07 +0200
Message-ID: <20251007081640.61772-11-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Probe the USB hub on the BL i.MX8MM OSM-S board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/dts/imx8mm-kontron-bl-osm-s.dts | 1 +
 board/kontron/sl-mx8mm/sl-mx8mm.c        | 8 ++++++++
 configs/kontron-sl-mx8mm_defconfig       | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/imx8mm-kontron-bl-osm-s.dts b/arch/arm/dts/imx8mm-kontron-bl-osm-s.dts
index 8b16bd68576..fae00fd9632 100644
--- a/arch/arm/dts/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm/dts/imx8mm-kontron-bl-osm-s.dts
@@ -198,6 +198,7 @@
 	usb1@1 {
 		compatible = "usb424,9514";
 		reg = <1>;
+		vdd-supply = <&reg_vdd_3v3>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index cb0b3acdd62..cf71a4cf367 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -8,6 +8,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <dm/uclass.h>
 #include <efi.h>
 #include <efi_loader.h>
 #include <env_internal.h>
@@ -150,10 +151,17 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 int board_late_init(void)
 {
+	struct udevice *dev;
+	int ret;
+
 	if (!fdt_node_check_compatible(gd->fdt_blob, 0, "kontron,imx8mm-n802x-som") ||
 	    !fdt_node_check_compatible(gd->fdt_blob, 0, "kontron,imx8mm-osm-s")) {
 		env_set("som_type", "osm-s");
 		env_set("touch_rst_gpio", "111");
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "usb-hub@2c", &dev);
+		if (ret)
+			printf("Error bringing up USB hub (%d)\n", ret);
 	} else {
 		env_set("som_type", "sl");
 		env_set("touch_rst_gpio", "87");
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 11ce881bc19..a2cc4d03963 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -142,6 +142,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_USB_HUB_USB251XB=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-- 
2.51.0

