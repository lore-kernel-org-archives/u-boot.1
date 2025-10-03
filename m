Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE59CCA472
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD0883885;
	Fri,  3 Oct 2025 18:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="tapl/W2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5431C83759; Fri,  3 Oct 2025 18:34:31 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662B983885
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1D4DC4E40E9F;
 Fri,  3 Oct 2025 16:34:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D9F2D60683;
 Fri,  3 Oct 2025 16:34:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9C171102F1CFB; 
 Fri,  3 Oct 2025 18:34:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509267; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3s1AJZkqLWydY2UGU45YXvybTPQDrBaZq8tzvcOHx/o=;
 b=tapl/W2Dq2E2o/qF0i7a/RfZbDORKRsVRhIhqLx+7A6IDVk1AFfny71YaoVqrX+FGT4or/
 RMgBwviT/d6dHDpHTWtgm0ruC5KdJG9M0/hqfCXZPCGTTLK3KB5coZyAmfCXJy8N1MYOAV
 P1YPcfJ0Bd3WyChMrHB3ei7LQpIccloGQLsgK1CjVE+LUC01VD27TJhCnEAh/sXzN9GoB/
 wRRWJBS4jTvJRGSnPTaeLeNbwFVn14rlMns0XqlvvaWxK5VGqvAF3qVKNju5O4BT6Ad2AT
 NjN5lLyKJER+MNUNDeSloyzZ5eQGNZKHR+5BMfrufZhZLQPAYfzgh6Q8z3l6zw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:46 +0200
Subject: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
 arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
 board/ti/common/cape_detect.c      | 24 +++++++++++-------------
 3 files changed, 13 insertions(+), 15 deletions(-)

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

