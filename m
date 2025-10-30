Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EA4CCF9FE
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183B483981;
	Thu, 30 Oct 2025 17:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="p+SswSAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A20383990; Thu, 30 Oct 2025 17:45:32 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0F083984
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 83CBE1A1757;
 Thu, 30 Oct 2025 16:45:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5AFF560331;
 Thu, 30 Oct 2025 16:45:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3368411808CAB; Thu, 30 Oct 2025 17:45:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842728; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qHCSvuBWRc0ztXL3FsfoqdoZzTX0YO3zx8o4pkrPxug=;
 b=p+SswSAuYE1ZMf27E1RrovFOrzL7j1WS+6PGU/pVJo7zSaqZYjoO8dteOed+k+/QTYPok5
 qrg2reDc1wv9VJGsX87ZNNMfR4W+u5YwA04kG2BLQSbO09Gkxaw7wuvS182nk7UhxmD8ZO
 yXWkvaCCEVzrIpAgrcWtQMV6CzF9PW99ihzmxD4LEZGkRtny+sz1cYC5FEd8SHr7Q2wB+7
 V5iZudSbnWvE62P74yrEi4KvV1Gc8Kqp6UE/wK9BKZRYoBEyxBnrvIYo/PXxKf46AGF+wV
 SpeHbX3T3AgCYdwYFaP7iZsSzZF42jEK44Wr0x0rv6i+i2Gz83eWXiCTpnziyw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:03 +0100
Subject: [PATCH v5 10/20] board: ti: Convert cape detection to use UCLASS
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-10-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
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
X-Mailer: b4 0.14.3
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

