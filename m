Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944ADC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4AA88CAB;
	Sat,  3 Aug 2024 18:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701716;
	bh=n8uuhggE3595QMAwj/+fNkc+0Ms+uDYG3/uQNQUWWyE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QsN5GCk+4LGhOM/I8cgsS1MbkKWmeMiyZv6qzFSx88UykdjgAtiwo/uPtb+3Bufbx
	 8A9QxsTjN/IcPfPZCLEBMMVAABAtbhSHnvXh7SstkQOY6ZYMsSwwOiNxh/GsqOZsBw
	 a+/bBb3xvE80EpRTF1zDXJP/5//bBlEY0Zvldhf68UDiyXZlsQG+jGMFuPtMSb6Qzi
	 qh3DOWaI5tPe/7mJDqXBm1BSofRP0DxHr/7ksBM9OVRMGcZlGnrcbUEaBKxPE1Snbd
	 Oi99urs6BMEKyLUZER1tctSNlPR6kly8n4mrmOKoMNTflWab4lP579CX7XD8CXVAjH
	 962QJnx3WRCnw==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4419588C57;
 Sat,  3 Aug 2024 18:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701714;
 bh=n8uuhggE3595QMAwj/+fNkc+0Ms+uDYG3/uQNQUWWyE=;
 h=From:To:Cc:Subject:Date:From;
 b=Vvb46a9MDs3MySGiWbe1yPDX1fR6GQn4YMLiURLxMMK1wzNpP/hIe0rvm2s+DY0Qz
 vIAFkW3DmOaC7c2/D3QDFptF9mmJrhlBD+E2ZdXSN5B/U6IJoRarwxnjuc5PJFCJAY
 cezSumKTtzjnVOgsKfV89sZ3pV63BC//l2O+moeimNk5v4hSqg9485+jKss2R9ebbh
 dnO5dXOUUfqPomFOY0MxRNLnsC0jbzl/Oi5++RaPMgJ/gRCQ8rXnzWmX5szIhqskbk
 Ffb2ckJJmPhJ1QOefL5NNT792lSzr4RDbzBQ3MH3ZLqfAA9ekzycC0MnHiUwvbLag4
 SmnMmUVnjln2w==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/11] board: shc: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:03 +0200
Message-Id: <20240803161513.486062-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Conversion to DM_I2C is mandatory, rework to remove
use of legacy I2C API.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
 board/bosch/shc/board.c              | 22 +++++++++++-----------
 configs/am335x_shc_defconfig         |  4 +++-
 configs/am335x_shc_ict_defconfig     |  4 +++-
 configs/am335x_shc_netboot_defconfig |  4 +++-
 configs/am335x_shc_sdboot_defconfig  |  4 +++-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index ab68874593..92c7b20f75 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -34,6 +34,7 @@
 #include <asm/emif.h>
 #include <asm/gpio.h>
 #include <i2c.h>
+#include <i2c_eeprom.h>
 #include <miiphy.h>
 #include <cpsw.h>
 #include <linux/delay.h>
@@ -51,21 +52,21 @@ static int shc_eeprom_valid;
 /*
  * Read header information from EEPROM into global structure.
  */
-#define EEPROM_ADDR	0x50
 static int read_eeprom(void)
 {
+	struct udevice *dev;
+	int ret;
+
 	/* Check if baseboard eeprom is available */
-	if (i2c_probe(EEPROM_ADDR)) {
-		puts("Could not probe the EEPROM; something fundamentally wrong on the I2C bus.\n");
-		return -ENODEV;
+	ret = uclass_first_device_err(UCLASS_I2C_EEPROM, &dev);
+	if (ret) {
+		puts("Could not find EEPROM.\n");
+		return ret;
 	}
 
-	/* read the eeprom using i2c */
-	if (i2c_read(EEPROM_ADDR, 0, 2, (uchar *)&header,
-		     sizeof(header))) {
-		puts("Could not read the EEPROM; something fundamentally wrong on the I2C bus.\n");
-		return -EIO;
-	}
+	ret = i2c_eeprom_read(dev, 0, (uint8_t *)&header, sizeof(header));
+	if (ret)
+		return ret;
 
 	if (header.magic != HDR_MAGIC) {
 		printf("Incorrect magic number (0x%x) in EEPROM\n",
@@ -445,7 +446,6 @@ int board_init(void)
 #if defined(CONFIG_HW_WATCHDOG)
 	hw_watchdog_init();
 #endif
-	i2c_init(CONFIG_SYS_I2C_SPEED, CONFIG_SYS_I2C_SLAVE);
 	if (read_eeprom() < 0)
 		puts("EEPROM Content Invalid.\n");
 
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 47c08e5054..dbce4611de 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -66,10 +66,12 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_SLAVE=0x1
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
 CONFIG_PHY_ADDR_ENABLE=y
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index c7618c5c79..24c6d44840 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -64,10 +64,12 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_SLAVE=0x1
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
 CONFIG_PHY_ADDR_ENABLE=y
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index 934265815b..0971d64afb 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -67,10 +67,12 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_SLAVE=0x1
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
 CONFIG_PHY_ADDR_ENABLE=y
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 439f9b8188..14d4fa4d6d 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -66,10 +66,12 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_SLAVE=0x1
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
 CONFIG_PHY_ADDR_ENABLE=y
-- 
2.25.1

