Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B178C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9E9876D0;
	Fri,  3 Nov 2023 01:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fcfQMtw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088AA86FC1; Fri,  3 Nov 2023 01:38:33 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3994876C5
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cBDQ003513;
 Thu, 2 Nov 2023 19:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971891;
 bh=WSp/+GRWEQOKHmyR9VnSfcSCZ+/BmmtyoLTHjEe+638=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fcfQMtw0V4PyC23uj0s7a9wwdREwNO0RDjU0XefUMkQSuSC/ZK6cDPn7yn9cKUhU4
 AKJD1UD5rnCDHamqzctcJ8+cy8Xdt6V+bGCgFIGNWyVm/ORDeJKNs7cD7/fUUi0A/o
 3mZ1YHfQWo6BANStNVseS09OBYYxZmULGAIIcc4o=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30cB8P124974
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cBlX007551;
 Thu, 2 Nov 2023 19:38:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 14/15] board: ti: Add j721e_beagleboneai64_* config fragments
 and env file
Date: Thu, 2 Nov 2023 19:38:04 -0500
Message-ID: <20231103003805.2420005-15-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
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

Add defconfig fragments for J721E based BeagleBone AI-64 and
corresponding customized environment.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/j721e/beagleboneai64.env        | 19 ++++++++
 board/ti/j721e/beagleboneai64_a72.config | 55 ++++++++++++++++++++++++
 board/ti/j721e/beagleboneai64_r5.config  | 19 ++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 board/ti/j721e/beagleboneai64.env
 create mode 100644 board/ti/j721e/beagleboneai64_a72.config
 create mode 100644 board/ti/j721e/beagleboneai64_r5.config

diff --git a/board/ti/j721e/beagleboneai64.env b/board/ti/j721e/beagleboneai64.env
new file mode 100644
index 000000000000..4f0a94a8113e
--- /dev/null
+++ b/board/ti/j721e/beagleboneai64.env
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
diff --git a/board/ti/j721e/beagleboneai64_a72.config b/board/ti/j721e/beagleboneai64_a72.config
new file mode 100644
index 000000000000..926f725508e5
--- /dev/null
+++ b/board/ti/j721e/beagleboneai64_a72.config
@@ -0,0 +1,55 @@
+# Defconfig fragment to apply on top of j721e_evm_a72_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-beagleboneai64"
+CONFIG_SPL_OF_LIST="k3-j721e-beagleboneai64"
+CONFIG_OF_LIST="k3-j721e-beagleboneai64"
+CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
+CONFIG_EXT4_WRITE=y
+CONFIG_LZO=y
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
+CONFIG_AUTOBOOT_DELAY_STR="d"
+CONFIG_AUTOBOOT_STOP_STR=" "
+
+# No Flash
+CONFIG_HBMC_AM654=n
+CONFIG_UFS=n
+
+# Sierra disabled for now till stability
+CONFIG_PHY_CADENCE_SIERRA=n
+CONFIG_PHY_J721E_WIZ=n
+# Torrent only for DP. no DP splash screen
+CONFIG_PHY_CADENCE_TORRENT=n
+
+# Use the Beaglebone-AI64 env file
+CONFIG_ENV_SOURCE_FILE="beagleboneai64"
+# No dependency on EEPROM detection
+CONFIG_TI_I2C_BOARD_DETECT=n
+# No board fixup to do
+CONFIG_OF_BOARD_SETUP=n
+
+# Do not use emmc boot - use FS only
+CONFIG_SUPPORT_EMMC_BOOT=n
+CONFIG_MMC_IO_VOLTAGE=y
+# CONFIG_SPL_MMC_IO_VOLTAGE is not set
+CONFIG_MMC_UHS_SUPPORT=y
+# CONFIG_SPL_MMC_UHS_SUPPORT is not set
+CONFIG_MMC_HS200_SUPPORT=y
+# CONFIG_SPL_MMC_HS200_SUPPORT is not set
+
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
diff --git a/board/ti/j721e/beagleboneai64_r5.config b/board/ti/j721e/beagleboneai64_r5.config
new file mode 100644
index 000000000000..cf124fb70cf1
--- /dev/null
+++ b/board/ti/j721e/beagleboneai64_r5.config
@@ -0,0 +1,19 @@
+# Defconfig fragment to apply on top of:
+# j721e_evm_r5_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-r5-beagleboneai64"
+CONFIG_SPL_OF_LIST="k3-j721e-r5-beagleboneai64"
+
+# No ESM, PMIC or AVS adjustment till PMIC is enabled
+CONFIG_ESM_K3=n
+CONFIG_K3_AVS0=n
+CONFIG_ESM_PMIC=n
+
+# Do not use emmc boot - we will use FS only
+CONFIG_SUPPORT_EMMC_BOOT=n
+
+CONFIG_HBMC_AM654=n
+# No dependency on EEPROM detection
+CONFIG_TI_I2C_BOARD_DETECT=n
+# No board fixup to do
+CONFIG_OF_BOARD_SETUP=n
-- 
2.40.0

