Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B7ACCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC9384563;
	Thu,  9 Oct 2025 16:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wBb5ebco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB2484528; Thu,  9 Oct 2025 16:51:10 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028B183F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 25B9DC035AD;
 Thu,  9 Oct 2025 14:50:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B3E0B6062C;
 Thu,  9 Oct 2025 14:51:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E324D102F21EC; 
 Thu,  9 Oct 2025 16:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4HesGXCf/ZZQ1a0Hd5mDkIgmuR9s9u+rki2xSP9JbgA=;
 b=wBb5ebcoDB4F4wg/cyf81d75jP9Cum+rfuYrBbGjaThG1R2ch8+MqaN3DN7P7GyQiYaHgz
 O1L5hQnodWqacngvG3GV4c5CLunSydM6yTqp/TfzRxuJzkpqEq/kaSvfjwq3EUqdUPvA5v
 VAx9BL9OnzhZ+cVVPEmWegJSmQTac8WktfDLg2jvLzHKrlXBqb++38MXSaILLH4CwVkNl9
 rKh2JRc/DvGhz95ii2hiG0RZ+gSKoWAZJ1indUQWXX/CWjOal83lPgISX/LRHvEW1gdc4z
 e++ONBRTjRMOOah4GShvnbN4wUMfzTUxjwuo9RCVS22gQdkyNbO1GRTNJei9Tg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:42 +0200
Subject: [PATCH v2 06/18] board: ti: Convert cape detection to use UCLASS
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-6-e09b39e54de5@bootlin.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
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
 arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
 arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
 board/ti/common/Makefile           |  2 +-
 board/ti/common/cape_detect.c      | 24 +++++++++++-------------
 4 files changed, 14 insertions(+), 16 deletions(-)

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
index 7786bdda5d1..23c93964dc3 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -22,7 +22,7 @@ static void sanitize_field(char *text, size_t size)
 	}
 }
 
-int extension_board_scan(struct list_head *extension_list)
+static int ti_extension_board_scan(struct alist *extension_list)
 {
 	unsigned char addr;
 	int num_capes = 0;
@@ -31,7 +31,7 @@ int extension_board_scan(struct list_head *extension_list)
 		struct am335x_cape_eeprom_id eeprom_header;
 		char process_cape_part_number[17] = {'0'};
 		char process_cape_version[5] = {'0'};
-		struct extension *cape;
+		struct extension cape = {0}, *_cape;
 		struct udevice *dev;
 		u8 cursor = 0;
 		int ret, i;
@@ -78,22 +78,20 @@ int extension_board_scan(struct list_head *extension_list)
 
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
+		_cape = alist_add(extension_list, cape);
+		if (!_cape)
+			return -ENOMEM;
 		num_capes++;
 	}
 	return num_capes;
 }
+
+U_BOOT_EXTENSION(cape, ti_extension_board_scan);

-- 
2.43.0

