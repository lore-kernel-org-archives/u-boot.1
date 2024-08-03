Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D5BC49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7C388CED;
	Sat,  3 Aug 2024 18:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701720;
	bh=D5efXucQyf09qCXw45VUq0QJkOZaX2ctRAM3gZ8gKV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGLjKOgQIJPtlrzMv7ZyO+oUs6WSpGFojVC4NngF+MyzntIzJ/cNRO3n6wbYjdcQE
	 wMnyeFk9b6h8NQT9wN1STxHxCOQDdDqAcVVGKubVFMt6qyHBTUk7Fujb60TC7HmpJO
	 GbeosvJksuL9GCyCxWp5FBC5UX7RnQkHSUYzepr5Ejutibnog1/VNEqPVU0bsipnV1
	 n3JH96yHkz3wsKyBUfXh3KX+MiEX0SXdR2HZpTolt0ApNY64wJDtH4k/FxqAXk/rmz
	 qg0aQvOWJlLZ0TG1ztTndRii1SCKbKyJlvrrnF4mbLwzA7YDImbRRYC2LDppez25p5
	 ghqwF8bGkHwcw==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 76EA988C8F;
 Sat,  3 Aug 2024 18:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701716;
 bh=D5efXucQyf09qCXw45VUq0QJkOZaX2ctRAM3gZ8gKV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jLZOy8g1EpXKVKJuVsMvQwM/fagk3tjnbOA/7RVXRhXxB8wejGyRNkJirunsWcmC5
 IVIdE6MENGu+JZrR1taCEGFRClzrmj9tW3j3zZ3NE+pKxi5rrkAUaKXi3uQq+WVina
 Yhaabm6H3EaXweD+NFyEQ/rMP9dWsF6SilfnNDQfAcr5n8+EVcpRFJseSMIoXE16Tm
 IvR4DkVJrAuKloFV8gsgpGlGNsua+U5ar+teGZ7Oz0z8kSZmrnHOfjpvteuW3WmcQ7
 2j+X37DWYZ7tbiPe7GP9097ALsx5AU3rM3bIebjgZT8z/WvXmOXKuBzOGtFYWRxtly
 vFs/ROUrKaxCA==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Nikita Kiryanov <nikita@compulab.co.il>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] board: cm_fx6: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:12 +0200
Message-Id: <20240803161513.486062-10-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
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

Conversion to DM_I2C is mandatory, enable DM_I2C to fix board
removal warning. Convert EEPROM access to use DM_I2C API.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
 board/compulab/cm_fx6/cm_fx6.c |  3 ++-
 board/compulab/common/Makefile |  2 +-
 board/compulab/common/eeprom.c | 14 +++++---------
 board/compulab/common/eeprom.h |  2 +-
 configs/cm_fx6_defconfig       |  2 +-
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index c6d33c32cc..40047cf678 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -14,6 +14,7 @@
 #include <env.h>
 #include <fsl_esdhc_imx.h>
 #include <init.h>
+#include <i2c.h>
 #include <miiphy.h>
 #include <mtd_node.h>
 #include <net.h>
@@ -256,7 +257,7 @@ static int cm_fx6_setup_one_i2c(int busnum, struct i2c_pads_info *pads)
 {
 	int ret;
 
-	ret = setup_i2c(busnum, CONFIG_SYS_I2C_SPEED, 0x7f, pads);
+	ret = setup_i2c(busnum, I2C_SPEED_STANDARD_RATE, 0x7f, pads);
 	if (ret)
 		printf("Warning: I2C%d setup failed: %d\n", busnum, ret);
 
diff --git a/board/compulab/common/Makefile b/board/compulab/common/Makefile
index 7c8226e6e1..863b50a98e 100644
--- a/board/compulab/common/Makefile
+++ b/board/compulab/common/Makefile
@@ -5,5 +5,5 @@
 # Author: Igor Grinberg <grinberg@compulab.co.il>
 
 obj-y				+= common.o
-obj-$(CONFIG_$(SPL_)SYS_I2C_LEGACY)	+= eeprom.o
+obj-$(CONFIG_$(SPL_)DM_I2C)	+= eeprom.o
 obj-$(CONFIG_SMC911X)		+= omap3_smc911x.o
diff --git a/board/compulab/common/eeprom.c b/board/compulab/common/eeprom.c
index efdaf342d5..1b12d09604 100644
--- a/board/compulab/common/eeprom.c
+++ b/board/compulab/common/eeprom.c
@@ -34,19 +34,15 @@ static int cl_eeprom_layout; /* Implicitly LAYOUT_INVALID */
 
 static int cl_eeprom_read(uint offset, uchar *buf, int len)
 {
+	struct udevice *eeprom;
 	int res;
-	unsigned int current_i2c_bus = i2c_get_bus_num();
 
-	res = i2c_set_bus_num(cl_eeprom_bus);
-	if (res < 0)
+	res = i2c_get_chip_for_busnum(cl_eeprom_bus, CONFIG_SYS_I2C_EEPROM_ADDR,
+				      CONFIG_SYS_I2C_EEPROM_ADDR_LEN, &eeprom);
+	if (res)
 		return res;
 
-	res = i2c_read(CONFIG_SYS_I2C_EEPROM_ADDR, offset,
-			CONFIG_SYS_I2C_EEPROM_ADDR_LEN, buf, len);
-
-	i2c_set_bus_num(current_i2c_bus);
-
-	return res;
+	return dm_i2c_read(eeprom, offset, (uint8_t *)buf, len);
 }
 
 static int cl_eeprom_setup(uint eeprom_bus)
diff --git a/board/compulab/common/eeprom.h b/board/compulab/common/eeprom.h
index 9bd7604a99..ca8738db76 100644
--- a/board/compulab/common/eeprom.h
+++ b/board/compulab/common/eeprom.h
@@ -10,7 +10,7 @@
 #define _EEPROM_
 #include <errno.h>
 
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
+#if CONFIG_IS_ENABLED(DM_I2C)
 int cl_eeprom_read_mac_addr(uchar *buf, uint eeprom_bus);
 u32 cl_eeprom_get_board_rev(uint eeprom_bus);
 int cl_eeprom_get_product_name(uchar *buf, uint eeprom_bus);
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index 386616cc42..81a39f7073 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -80,7 +80,7 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
 # CONFIG_DWC_AHSATA_AHCI is not set
 CONFIG_LBA48=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SYS_MXC_I2C3_SPEED=400000
-- 
2.25.1

