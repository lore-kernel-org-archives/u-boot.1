Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27021C36010
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 00:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0FD82898;
	Wed,  9 Apr 2025 02:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C964C828E1; Wed,  9 Apr 2025 02:21:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 618BF827A6
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 02:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33EE91688;
 Tue,  8 Apr 2025 17:21:28 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23243F6A8;
 Tue,  8 Apr 2025 17:21:23 -0700 (PDT)
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
Subject: [PATCH v2 0/8] sunxi: Control USB pins and supplies via DT regulators
Date: Wed,  9 Apr 2025 01:20:28 +0100
Message-ID: <20250409002036.12212-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

This series removes some old custom non-DM code from the Allwinner USB
PHY driver. So far we were relying on Kconfig specified GPIO names for
the VBUS power supplies, USB ID detect pin and the VBUS detect pin.

The first 5 patches resurrect Samuel's series from 1.5 years ago, fixing
one issue that prevented this series from being merged earlier (by using
regulator_set_enable_if_allowed()). This involves adding a new regulator
driver, for the AXP DRIVEVBUS functionality, then switching the USB PHY
over to using DM compliant regulator calls. Eventually the old, no
longer needed symbols are removed both from the Kconfig and the defconfig
files.
This also fixes a lot of A20 boards (probably even more SoCs from this
era), where USB was broken since v2025.01-rc1, due to conflicts between
"regulator-boot-on" DT regulators and the same controlling GPIO being
claimed by the current custom code.

The last three patches convert the currently Kconfig defined USB ID
detect pins (to switch between host and device support on USB-OTG ports)
and the VBUS detect pins (to detect external VBUS power supplied by the
connected host) to DT based GPIO pins. This changes the driver in the
first two patches, then removes the old symbols in the third one.

Please have a look and most importantly test USB host and device
functionality on any boards you have access to.

Cheers,
Andre

Andre Przywara (3):
  phy: sun4i-usb: Determine VBUS detection pin from devicetree
  phy: sun4i-usb: Determine USB OTG detection pin from devicetree
  sunxi: Kconfig: Remove obsolete USBx_* pin symbols

Samuel Holland (5):
  power: regulator: Add a driver for the AXP PMIC drivevbus
  sunxi: Enable PMIC drivevbus regulator support for USB supplies
  phy: sun4i-usb: Control supplies via the regulator uclass
  sunxi: Remove obsolete USBx_VBUS_PIN Kconfig symbols
  gpio: axp: Remove virtual VBUS enable GPIO

 arch/arm/mach-sunxi/Kconfig                  | 43 ---------
 configs/A10s-OLinuXino-M_defconfig           |  1 -
 configs/A13-OLinuXinoM_defconfig             |  1 -
 configs/A13-OLinuXino_defconfig              |  2 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  2 -
 configs/A20-OLinuXino-Lime2_defconfig        |  2 -
 configs/A20-Olimex-SOM-EVB_defconfig         |  2 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  2 -
 configs/A20-Olimex-SOM204-EVB_defconfig      |  2 -
 configs/A33-OLinuXino_defconfig              |  3 +-
 configs/Ainol_AW1_defconfig                  |  1 -
 configs/Ampe_A76_defconfig                   |  3 -
 configs/Auxtek-T003_defconfig                |  1 -
 configs/Auxtek-T004_defconfig                |  1 -
 configs/Bananapi_M2_Ultra_defconfig          |  2 -
 configs/Bananapi_m2m_defconfig               |  1 -
 configs/Bananapro_defconfig                  |  2 -
 configs/CHIP_defconfig                       |  1 -
 configs/CHIP_pro_defconfig                   |  1 -
 configs/CSQ_CS908_defconfig                  |  2 -
 configs/Chuwi_V7_CW0825_defconfig            |  3 -
 configs/Colombus_defconfig                   |  1 -
 configs/Cubieboard4_defconfig                |  5 +-
 configs/Cubietruck_defconfig                 |  3 -
 configs/Cubietruck_plus_defconfig            |  5 +-
 configs/Empire_electronix_d709_defconfig     |  3 -
 configs/Empire_electronix_m712_defconfig     |  3 -
 configs/Hummingbird_A31_defconfig            |  2 -
 configs/Hyundai_A7HD_defconfig               |  4 -
 configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
 configs/Linksprite_pcDuino_defconfig         |  2 -
 configs/MSI_Primo81_defconfig                |  2 +-
 configs/Mele_A1000G_quad_defconfig           |  2 -
 configs/Mele_I7_defconfig                    |  2 -
 configs/Mele_M9_defconfig                    |  2 -
 configs/Merrii_A80_Optimus_defconfig         |  5 +-
 configs/Mini-X_defconfig                     |  1 -
 configs/Orangepi_defconfig                   |  2 -
 configs/Orangepi_mini_defconfig              |  2 -
 configs/Sinlinx_SinA31s_defconfig            |  2 -
 configs/Sinlinx_SinA33_defconfig             |  1 -
 configs/Sinovoip_BPI_M2_defconfig            |  2 -
 configs/Sinovoip_BPI_M3_defconfig            |  4 +-
 configs/Sunchip_CX-A99_defconfig             |  3 -
 configs/UTOO_P66_defconfig                   |  3 -
 configs/Wexler_TAB7200_defconfig             |  2 -
 configs/Wobo_i5_defconfig                    |  1 -
 configs/Yones_Toptech_BD1078_defconfig       |  1 -
 configs/Yones_Toptech_BS1078_V2_defconfig    |  3 +-
 configs/ba10_tv_box_defconfig                |  2 -
 configs/bananapi_m2_berry_defconfig          |  1 -
 configs/colorfly_e708_q1_defconfig           |  3 +-
 configs/difrnce_dit4350_defconfig            |  3 -
 configs/dserve_dsrv9703c_defconfig           |  3 -
 configs/ga10h_v1_1_defconfig                 |  3 +-
 configs/gt90h_v4_defconfig                   |  3 +-
 configs/h8_homlet_v2_defconfig               |  2 -
 configs/iNet_3F_defconfig                    |  2 -
 configs/iNet_3W_defconfig                    |  2 -
 configs/iNet_86VS_defconfig                  |  2 -
 configs/iNet_D978_rev2_defconfig             |  3 +-
 configs/icnova-a20-swac_defconfig            |  3 -
 configs/inet1_defconfig                      |  3 -
 configs/inet86dz_defconfig                   |  3 +-
 configs/inet97fv2_defconfig                  |  3 -
 configs/inet98v_rev2_defconfig               |  3 -
 configs/inet9f_rev03_defconfig               |  3 -
 configs/inet_q972_defconfig                  |  3 +-
 configs/jesurun_q5_defconfig                 |  1 -
 configs/mixtile_loftq_defconfig              |  2 -
 configs/mk802_a10s_defconfig                 |  1 -
 configs/mk802_defconfig                      |  1 -
 configs/orangepi_2_defconfig                 |  1 -
 configs/orangepi_plus_defconfig              |  2 -
 configs/orangepi_zero2_defconfig             |  1 -
 configs/orangepi_zero3_defconfig             |  1 -
 configs/parrot_r16_defconfig                 |  2 -
 configs/pine_h64_defconfig                   |  1 -
 configs/polaroid_mid2407pxe03_defconfig      |  3 +-
 configs/polaroid_mid2809pxe04_defconfig      |  3 +-
 configs/pov_protab2_ips9_defconfig           |  3 -
 configs/q8_a13_tablet_defconfig              |  3 -
 configs/q8_a23_tablet_800x480_defconfig      |  3 +-
 configs/q8_a33_tablet_1024x600_defconfig     |  3 +-
 configs/q8_a33_tablet_800x480_defconfig      |  3 +-
 configs/r7-tv-dongle_defconfig               |  1 -
 configs/sun8i_a23_evb_defconfig              |  3 -
 configs/tbs_a711_defconfig                   |  3 +-
 configs/teres_i_defconfig                    |  1 -
 drivers/gpio/axp_gpio.c                      | 75 +++++----------
 drivers/gpio/sunxi_gpio.c                    | 12 +--
 drivers/phy/allwinner/phy-sun4i-usb.c        | 96 +++++++-------------
 drivers/power/pmic/axp.c                     |  1 +
 drivers/power/regulator/Kconfig              |  7 ++
 drivers/power/regulator/Makefile             |  1 +
 drivers/power/regulator/axp_drivevbus.c      | 57 ++++++++++++
 include/axp221.h                             |  4 -
 include/axp809.h                             |  4 -
 include/axp818.h                             |  4 -
 include/sunxi_gpio.h                         |  8 --
 100 files changed, 139 insertions(+), 369 deletions(-)
 create mode 100644 drivers/power/regulator/axp_drivevbus.c

-- 
2.46.3

