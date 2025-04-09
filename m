Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DA8C36010
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 00:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8987832AF;
	Wed,  9 Apr 2025 02:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44CE83394; Wed,  9 Apr 2025 02:21:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 56D3683367
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 02:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E33F2308;
 Tue,  8 Apr 2025 17:21:36 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24C23F6A8;
 Tue,  8 Apr 2025 17:21:31 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Hans de Goede <hdegoede@redhat.com>,
 Olliver Schinagl <oliver@schinagl.nl>, Iain Paton <ipaton0@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>,
 Paul Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
 Adam Sampson <ats@offog.org>, Zoltan Herpai <wigyori@uid0.hu>,
 Siarhei Siamashka <siarhei.siamashka@gmail.com>,
 VishnuPatekar <vishnupatekar0510@gmail.com>,
 Rask Ingemann Lambertsen <rask@formelder.dk>,
 Aleksei Mamlin <mamlinav@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Michal Suchanek <hramrach@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Stefan Roese <sr@denx.de>, Phil Han <pengphei@sina.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Jonas Smedegaard <dr@jones.dk>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/8] sunxi: Enable PMIC drivevbus regulator support for USB
 supplies
Date: Wed,  9 Apr 2025 01:20:30 +0100
Message-ID: <20250409002036.12212-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250409002036.12212-1-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
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

From: Samuel Holland <samuel@sholland.org>

On many boards, the USB ports are powered by the PMIC's "drivevbus"
regulator. In preparation for switching the USB PHY driver to use the
regulator uclass instead of a virtual GPIO pin, ensure these boards
have AXP PMIC regulator support enabled.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/A33-OLinuXino_defconfig           | 1 +
 configs/Cubieboard4_defconfig             | 1 +
 configs/Cubietruck_plus_defconfig         | 1 +
 configs/MSI_Primo81_defconfig             | 1 +
 configs/Merrii_A80_Optimus_defconfig      | 1 +
 configs/Sinovoip_BPI_M3_defconfig         | 1 +
 configs/Yones_Toptech_BS1078_V2_defconfig | 1 +
 configs/colorfly_e708_q1_defconfig        | 1 +
 configs/ga10h_v1_1_defconfig              | 1 +
 configs/gt90h_v4_defconfig                | 1 +
 configs/iNet_D978_rev2_defconfig          | 1 +
 configs/inet86dz_defconfig                | 1 +
 configs/inet_q972_defconfig               | 1 +
 configs/polaroid_mid2407pxe03_defconfig   | 1 +
 configs/polaroid_mid2809pxe04_defconfig   | 1 +
 configs/q8_a23_tablet_800x480_defconfig   | 1 +
 configs/q8_a33_tablet_1024x600_defconfig  | 1 +
 configs/q8_a33_tablet_800x480_defconfig   | 1 +
 configs/tbs_a711_defconfig                | 1 +
 19 files changed, 19 insertions(+)

diff --git a/configs/A33-OLinuXino_defconfig b/configs/A33-OLinuXino_defconfig
index df4acaf33e2..705c869c19f 100644
--- a/configs/A33-OLinuXino_defconfig
+++ b/configs/A33-OLinuXino_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_BL_EN="PB2"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DCDC1_VOLT=3300
 CONFIG_USB_MUSB_HOST=y
diff --git a/configs/Cubieboard4_defconfig b/configs/Cubieboard4_defconfig
index d3678ad5c75..c8adabe0a0a 100644
--- a/configs/Cubieboard4_defconfig
+++ b/configs/Cubieboard4_defconfig
@@ -11,5 +11,6 @@ CONFIG_USB1_VBUS_PIN="PH14"
 CONFIG_USB3_VBUS_PIN="PH15"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP809_POWER=y
diff --git a/configs/Cubietruck_plus_defconfig b/configs/Cubietruck_plus_defconfig
index 29f4df2b81c..f349d9bc49f 100644
--- a/configs/Cubietruck_plus_defconfig
+++ b/configs/Cubietruck_plus_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO3_VOLT=2500
 CONFIG_AXP_DLDO4_VOLT=3300
diff --git a/configs/MSI_Primo81_defconfig b/configs/MSI_Primo81_defconfig
index d60eedb482a..709d27d342e 100644
--- a/configs/MSI_Primo81_defconfig
+++ b/configs/MSI_Primo81_defconfig
@@ -12,6 +12,7 @@ CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 CONFIG_VIDEO_LCD_PANEL_MIPI_4_LANE_513_MBPS_VIA_SSD2828=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/configs/Merrii_A80_Optimus_defconfig b/configs/Merrii_A80_Optimus_defconfig
index a26677e1c05..c7a3af7a8d1 100644
--- a/configs/Merrii_A80_Optimus_defconfig
+++ b/configs/Merrii_A80_Optimus_defconfig
@@ -11,5 +11,6 @@ CONFIG_USB1_VBUS_PIN="PH4"
 CONFIG_USB3_VBUS_PIN="PH5"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP809_POWER=y
diff --git a/configs/Sinovoip_BPI_M3_defconfig b/configs/Sinovoip_BPI_M3_defconfig
index ad41dbd26a1..fcdd7ded82d 100644
--- a/configs/Sinovoip_BPI_M3_defconfig
+++ b/configs/Sinovoip_BPI_M3_defconfig
@@ -17,6 +17,7 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_INITIAL_USB_SCAN_DELAY=500
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DCDC5_VOLT=1200
 CONFIG_AXP_DLDO3_VOLT=3300
diff --git a/configs/Yones_Toptech_BS1078_V2_defconfig b/configs/Yones_Toptech_BS1078_V2_defconfig
index de69ebe9956..67fef2a6202 100644
--- a/configs/Yones_Toptech_BS1078_V2_defconfig
+++ b/configs/Yones_Toptech_BS1078_V2_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_USB_MUSB_HOST=y
diff --git a/configs/colorfly_e708_q1_defconfig b/configs/colorfly_e708_q1_defconfig
index 07bda049665..201b7425573 100644
--- a/configs/colorfly_e708_q1_defconfig
+++ b/configs/colorfly_e708_q1_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_AXP_DLDO2_VOLT=1800
diff --git a/configs/ga10h_v1_1_defconfig b/configs/ga10h_v1_1_defconfig
index 935071d61ac..5d083742f1f 100644
--- a/configs/ga10h_v1_1_defconfig
+++ b/configs/ga10h_v1_1_defconfig
@@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/gt90h_v4_defconfig b/configs/gt90h_v4_defconfig
index 205eab29293..6502ac8cf43 100644
--- a/configs/gt90h_v4_defconfig
+++ b/configs/gt90h_v4_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/iNet_D978_rev2_defconfig b/configs/iNet_D978_rev2_defconfig
index ed6a6038424..70be98030a0 100644
--- a/configs/iNet_D978_rev2_defconfig
+++ b/configs/iNet_D978_rev2_defconfig
@@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/configs/inet86dz_defconfig b/configs/inet86dz_defconfig
index d215a8375e2..3405bc423a3 100644
--- a/configs/inet86dz_defconfig
+++ b/configs/inet86dz_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/inet_q972_defconfig b/configs/inet_q972_defconfig
index 24ff6c0062e..a70a83ebcd0 100644
--- a/configs/inet_q972_defconfig
+++ b/configs/inet_q972_defconfig
@@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/polaroid_mid2407pxe03_defconfig b/configs/polaroid_mid2407pxe03_defconfig
index 6ec7c83be5b..2155fe6646f 100644
--- a/configs/polaroid_mid2407pxe03_defconfig
+++ b/configs/polaroid_mid2407pxe03_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/polaroid_mid2809pxe04_defconfig b/configs/polaroid_mid2809pxe04_defconfig
index 1aefc50588e..1faf78f1b54 100644
--- a/configs/polaroid_mid2809pxe04_defconfig
+++ b/configs/polaroid_mid2809pxe04_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/q8_a23_tablet_800x480_defconfig b/configs/q8_a23_tablet_800x480_defconfig
index 0f8c30ec853..08ba34e08ee 100644
--- a/configs/q8_a23_tablet_800x480_defconfig
+++ b/configs/q8_a23_tablet_800x480_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/q8_a33_tablet_1024x600_defconfig b/configs/q8_a33_tablet_1024x600_defconfig
index b3b5cc704f4..6efbd84f7c3 100644
--- a/configs/q8_a33_tablet_1024x600_defconfig
+++ b/configs/q8_a33_tablet_1024x600_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/q8_a33_tablet_800x480_defconfig b/configs/q8_a33_tablet_800x480_defconfig
index 37ee08fa629..bf5dcd0d018 100644
--- a/configs/q8_a33_tablet_800x480_defconfig
+++ b/configs/q8_a33_tablet_800x480_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/tbs_a711_defconfig b/configs/tbs_a711_defconfig
index 9a70b6bee52..c17815382ec 100644
--- a/configs/tbs_a711_defconfig
+++ b/configs/tbs_a711_defconfig
@@ -13,6 +13,7 @@ CONFIG_USB0_ID_DET="PH11"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DCDC5_VOLT=1200
 CONFIG_USB_EHCI_HCD=y
-- 
2.46.3

