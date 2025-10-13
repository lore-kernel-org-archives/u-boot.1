Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F95BCCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8F38383E;
	Mon, 13 Oct 2025 15:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hB7tjyF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7F6839AD; Mon, 13 Oct 2025 15:33:02 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370B1834E5
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DBDFF4E40F94;
 Mon, 13 Oct 2025 13:32:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B2124606C6;
 Mon, 13 Oct 2025 13:32:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 71E28102F2270; 
 Mon, 13 Oct 2025 15:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qHCSvuBWRc0ztXL3FsfoqdoZzTX0YO3zx8o4pkrPxug=;
 b=hB7tjyF2uuAApY7jMXvjpEvZru+DxSW6S7PBFpw5ULdHccmZMAmuRrjs9J2wzIxZgw/Wjg
 Ls7sF8U3Ywa1Cy0tEZ2+NW2BT4w7bqWjW4ynYQi65LcZwMGC59oiNKXkrNrLdOZQGtPHWM
 oMZa8QOH/g1xjI3i+Hd16EbM3irx7m8lVmwmyhfA7pIlzVXD1Ih+GSgMNjBmNYxvUVFor8
 KKqi0ZdpGte0T/L9imBCwnSm4ZcRT8Ux6PaslFLnORmiJKjpVA5iF2pGxxWxZhZzyye8T3
 7NaayrHVSdvK6/anBrJywF/2g3CFiKkFBtWYOQ9Lni7OzyF2Ql1quZWIUArufg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:35 +0200
Subject: [PATCH v3 10/20] board: ti: Convert cape detection to use UCLASS
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-10-04067b7422a5@bootlin.com>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
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

Migrate TI board cape detection from legacy extension support to the
new UCLASS-based extension board framework.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v3:
- Use U_BOOT_DRVINFO.
---
 arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
 arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
 board/ti/common/Kconfig            |  2 +-
 board/ti/common/Makefile           |  2 +-
 board/ti/common/cape_detect.c      | 28 +++++++++++++++-------------
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
index dff4f1cf202..77f7938305b 100644
--- a/arch/arm/mach-omap2/am33xx/Kconfig
+++ b/arch/arm/mach-omap2/am33xx/Kconfig
@@ -15,7 +15,7 @@ config TARGET_AM335X_EVM
 	select DM_GPIO
 	select DM_SERIAL
 	select TI_I2C_BOARD_DETECT
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_DM_EXTENSION_SCAN
 	imply CMD_DM
 	imply SPL_DM
 	imply SPL_DM_SEQ_ALIAS
diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap2/omap5/Kconfig
index 5394529658b..819490a8cf8 100644
--- a/arch/arm/mach-omap2/omap5/Kconfig
+++ b/arch/arm/mach-omap2/omap5/Kconfig
@@ -38,7 +38,7 @@ config TARGET_AM57XX_EVM
 	select CMD_DDR3
 	select DRA7XX
 	select TI_I2C_BOARD_DETECT
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_DM_EXTENSION_SCAN
 	imply DM_THERMAL
 	imply SCSI
 	imply SPL_THERMAL
diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 9512c5c23f1..feb05b4bf95 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -20,7 +20,7 @@ config CAPE_EEPROM_BUS_NUM
 	int "Cape EEPROM's I2C bus address"
 	range 0 8
 	default 2
-	depends on SUPPORT_EXTENSION_SCAN
+	depends on SUPPORT_DM_EXTENSION_SCAN
 
 config TI_COMMON_CMD_OPTIONS
 	bool "Enable cmd options on TI platforms"
diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index f58935b4103..b42273d3a5a 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -2,6 +2,6 @@
 # Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
-obj-${CONFIG_$(PHASE_)SUPPORT_EXTENSION_SCAN} += cape_detect.o
+obj-${CONFIG_$(PHASE_)SUPPORT_DM_EXTENSION_SCAN} += cape_detect.o
 obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
 obj-${CONFIG_ARCH_K3} += k3-ddr.o
diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
index 7786bdda5d1..0bd4a38c187 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -22,7 +22,8 @@ static void sanitize_field(char *text, size_t size)
 	}
 }
 
-int extension_board_scan(struct list_head *extension_list)
+static int ti_extension_board_scan(struct udevice *dev,
+				   struct alist *extension_list)
 {
 	unsigned char addr;
 	int num_capes = 0;
@@ -31,7 +32,7 @@ int extension_board_scan(struct list_head *extension_list)
 		struct am335x_cape_eeprom_id eeprom_header;
 		char process_cape_part_number[17] = {'0'};
 		char process_cape_version[5] = {'0'};
-		struct extension *cape;
+		struct extension cape = {0};
 		struct udevice *dev;
 		u8 cursor = 0;
 		int ret, i;
@@ -78,22 +79,23 @@ int extension_board_scan(struct list_head *extension_list)
 
 		printf("BeagleBone Cape: %s (0x%x)\n", eeprom_header.board_name, addr);
 
-		cape = calloc(1, sizeof(struct extension));
-		if (!cape) {
-			printf("Error in memory allocation\n");
-			return num_capes;
-		}
-
-		snprintf(cape->overlay, sizeof(cape->overlay), "%s-%s.dtbo",
+		snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s.dtbo",
 			 process_cape_part_number, process_cape_version);
-		strlcpy(cape->name, eeprom_header.board_name,
+		strlcpy(cape.name, eeprom_header.board_name,
 			sizeof(eeprom_header.board_name));
-		strlcpy(cape->version, process_cape_version,
+		strlcpy(cape.version, process_cape_version,
 			sizeof(process_cape_version));
-		strlcpy(cape->owner, eeprom_header.manufacturer,
+		strlcpy(cape.owner, eeprom_header.manufacturer,
 			sizeof(eeprom_header.manufacturer) + 1);
-		list_add_tail(&cape->list, extension_list);
+		if (!alist_add(extension_list, cape))
+			return -ENOMEM;
 		num_capes++;
 	}
 	return num_capes;
 }
+
+U_BOOT_EXTENSION(cape, ti_extension_board_scan);
+
+U_BOOT_DRVINFO(cape) = {
+	.name	= "cape",
+};

-- 
2.43.0

