Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA59C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F9A86AE8;
	Fri, 25 Aug 2023 20:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UPMbydYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86B086B16; Fri, 25 Aug 2023 20:03:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A7186ADA
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI372f125512;
 Fri, 25 Aug 2023 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986587;
 bh=OlG6IrMpteXLFz025M28nqV8WLHAghKpygTP0dO3+Zw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UPMbydYkzsZDyE1yVuyucjODGtHhyqAZ7FJTuHzYfb+l5yofKypoX1MKeVZpqK7Fb
 DTN9qDVsuaphwpR965FCdZVXG6w5w/7aGPGaYYjyZIb4ru6aPQ+9ind8q1GVCT/d2K
 dRK0McyXQkZJuCQgktjjFTjfjTiwj8mAhITDTBHI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI37Xp085974
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:07 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI37W5114820;
 Fri, 25 Aug 2023 13:03:07 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 19/20] board: ti: am62x: Add am62x_beagleplay_* defconfigs
 and env file
Date: Fri, 25 Aug 2023 13:03:04 -0500
Message-ID: <20230825180305.69515-20-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add defconfig fragments for am625 based beagleplay and corresponding
customized environment file for beagleplay.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No major changes other than explicitly calling out script in the
crafted bootmeths

V5: https://lore.kernel.org/r/20230824031101.3460411-17-nm@ti.com
V4: https://lore.kernel.org/r/20230822184135.2328409-8-nm@ti.com
V3: https://lore.kernel.org/all/20230815164440.2713726-4-nm@ti.com/
V2: https://lore.kernel.org/u-boot/20230727234446.3651836-4-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-6-nm@ti.com/

 board/ti/am62x/beagleplay.env        | 19 ++++++++++
 board/ti/am62x/beagleplay_a53.config | 55 ++++++++++++++++++++++++++++
 board/ti/am62x/beagleplay_r5.config  | 15 ++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 board/ti/am62x/beagleplay.env
 create mode 100644 board/ti/am62x/beagleplay_a53.config
 create mode 100644 board/ti/am62x/beagleplay_r5.config

diff --git a/board/ti/am62x/beagleplay.env b/board/ti/am62x/beagleplay.env
new file mode 100644
index 000000000000..4f0a94a8113e
--- /dev/null
+++ b/board/ti/am62x/beagleplay.env
@@ -0,0 +1,19 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/default_findfdt.env>
+#include <env/ti/mmc.env>
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+set_led_state_fail_load= led led-0 off; led led-1 on;
+	led led-2 off; led led-3 on; led led-4 off
+set_led_state_start_load=led led-0 on; led led-1 off;
+	led led-2 on; led led-3 off; led led-4 on
+boot=mmc
+mmcdev=1
+bootpart=1:1
+bootdir=/boot
+boot_targets=mmc1 mmc0 usb pxe
+bootmeths=script extlinux efi pxe
+rd_spec=-
diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beagleplay_a53.config
new file mode 100644
index 000000000000..f0380416cc5e
--- /dev/null
+++ b/board/ti/am62x/beagleplay_a53.config
@@ -0,0 +1,55 @@
+# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
+CONFIG_OF_LIST="k3-am625-beagleplay"
+CONFIG_SPL_OF_LIST="k3-am625-beagleplay"
+CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
+CONFIG_EXT4_WRITE=y
+CONFIG_LZO=y
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
+CONFIG_AUTOBOOT_DELAY_STR="d"
+CONFIG_AUTOBOOT_STOP_STR=" "
+# Use the Beagleplay env file
+CONFIG_ENV_SOURCE_FILE="beagleplay"
+# Do not use emmc boot - we will use FS only
+CONFIG_SUPPORT_EMMC_BOOT=n
+CONFIG_MMC_IO_VOLTAGE=y
+# CONFIG_SPL_MMC_IO_VOLTAGE is not set
+CONFIG_MMC_UHS_SUPPORT=y
+# CONFIG_SPL_MMC_UHS_SUPPORT is not set
+CONFIG_MMC_HS200_SUPPORT=y
+# CONFIG_SPL_MMC_HS200_SUPPORT is not set
+# Enable GPIO control
+CONFIG_DM_GPIO=y
+CONFIG_SPL_GPIO=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPIO_READ=y
+# Enable LEDs
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SPL_LED=y
+CONFIG_SPL_LED_GPIO=y
+# Enable I2C bus
+CONFIG_SPL_I2C=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_CMD_I2C=y
+# Regulator
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65219=y
+CONFIG_CMD_PMIC=y
+# Uses Realtek phy rather than TI phy
+CONFIG_PHY_TI_DP83867=n
+CONFIG_PHY_REALTEK=y
+# No SPI flash on Beagleplay
+CONFIG_SPI=n
+CONFIG_SPI_FLASH=n
+CONFIG_SPL_DM_SPI_FLASH=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
diff --git a/board/ti/am62x/beagleplay_r5.config b/board/ti/am62x/beagleplay_r5.config
new file mode 100644
index 000000000000..4ee0375a2a1d
--- /dev/null
+++ b/board/ti/am62x/beagleplay_r5.config
@@ -0,0 +1,15 @@
+# Defconfig fragment to apply on top of:
+# am62x_evm_r5_defconfig
+#
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-beagleplay"
+CONFIG_OF_LIST="k3-am625-r5-beagleplay"
+CONFIG_SPL_OF_LIST="k3-am625-r5-beagleplay"
+# Do spl board init
+CONFIG_SPL_BOARD_INIT=y
+# Do not use emmc boot - we will use FS only
+CONFIG_SUPPORT_EMMC_BOOT=n
+# No SPI flash on Beagleplay
+CONFIG_SPI=n
+CONFIG_SPI_FLASH=n
+CONFIG_SPL_DM_SPI_FLASH=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
-- 
2.40.0

