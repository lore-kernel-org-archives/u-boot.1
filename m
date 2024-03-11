Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBE6C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CEB87FFF;
	Mon, 11 Mar 2024 13:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113FF87E44; Mon, 11 Mar 2024 13:03:25 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E2E87FCD
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttb542ygdzMq4Rj;
 Mon, 11 Mar 2024 13:03:04 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ttb533f49z3Z; Mon, 11 Mar 2024 13:03:03 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Mar 2024 13:02:02 +0100
Subject: [PATCH v4 19/20] rockchip: ringneck_px30: migrate README to
 doc/board in rST format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240311-jaguar-v4-19-d2ca1af68ed3@theobroma-systems.com>
References: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
In-Reply-To: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This migrates the plaintext README in
board/theobroma-systems/ringneck_px30 to doc/board/theobroma-systems and
while doing so, update the instructions and rewrite it in rST.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/theobroma-systems/ringneck_px30/MAINTAINERS |  1 +
 board/theobroma-systems/ringneck_px30/README      | 70 +----------------
 doc/board/theobroma-systems/index.rst             |  1 +
 doc/board/theobroma-systems/ringneck_px30.rst     | 95 +++++++++++++++++++++++
 4 files changed, 98 insertions(+), 69 deletions(-)

diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
index 06e1beaab14..601830fe45b 100644
--- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
+++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
@@ -4,6 +4,7 @@ M:	Klaus Goger <klaus.goger@theobroma-systems.com>
 S:	Maintained
 F:	board/theobroma-systems/ringneck_px30
 F:	board/theobroma-systems/common
+F:	doc/board/theobroma-systems/
 F:	include/configs/ringneck_px30.h
 F:	arch/arm/dts/px30-ringneck*
 F:	configs/ringneck-px30_defconfig
diff --git a/board/theobroma-systems/ringneck_px30/README b/board/theobroma-systems/ringneck_px30/README
index e756b3a8ffc..915baf4a9a0 100644
--- a/board/theobroma-systems/ringneck_px30/README
+++ b/board/theobroma-systems/ringneck_px30/README
@@ -1,69 +1 @@
-Introduction
-============
-
-The PX30-uQ7 (Ringneck) SoM is a µQseven-compatible (40mmx70mm, MXM-230
-connector) system-on-module from Theobroma Systems[1], featuring the
-Rockchip PX30.
-
-It provides the following feature set:
-  * up to 4GB DDR4
-  * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
-  * SD card (on a baseboard) via edge connector
-  * Fast Ethernet with on-module TI DP83825I PHY
-  * MIPI-DSI/LVDS
-  * MIPI-CSI
-  * USB
-    - 1x USB 2.0 dual-role
-    - 3x USB 2.0 host
-  * on-module companion controller (STM32 Cortex-M0 or ATtiny), implementing:
-    - low-power RTC functionality (ISL1208 emulation)
-    - fan controller (AMC6821 emulation)
-    - USB<->CAN bridge controller (STM32 only)
-  * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
-  * on-module NXP SE05x Secure Element
-
-Here is the step-by-step to boot to U-Boot on px30.
-
-Get the Source and build ATF binary
-===================================
-
-  > git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
-
-Compile the ATF
-===============
-
-  > cd trusted-firmware-a
-  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=px30 bl31
-  > cp build/px30/release/bl31/bl31.elf ../u-boot/bl31.elf
-
-Compile the U-Boot
-==================
-
-  > cd ../u-boot
-  > make CROSS_COMPILE=aarch64-linux-gnu- ringneck-px30_defconfig all
-
-Flash the image
-===============
-
-Copy u-boot-rockchip.bin to offset 32k for SD/eMMC.
-
-SD-Card
--------
-
-  > dd if=u-boot-rockchip.bin of=/dev/sdb seek=64
-
-eMMC
-----
-
-rkdeveloptool allows to flash the on-board eMMC via the USB OTG interface with
-help of the Rockchip loader binary.
-
-  > git clone https://github.com/rockchip-linux/rkdeveloptool
-  > cd rkdeveloptool
-  > autoreconf -i && ./configure && make
-  > git clone https://github.com/rockchip-linux/rkbin.git
-  > cd rkbin
-  > ./tools/boot_merger RKBOOT/PX30MINIALL.ini
-  > cd ..
-  > ./rkdeveloptool db rkbin/px30_loader_v1.16.131.bin
-  > ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
+See doc/board/theobroma-systems/ringneck_px30.rst.
diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
index 0720128ad52..b4da2616c37 100644
--- a/doc/board/theobroma-systems/index.rst
+++ b/doc/board/theobroma-systems/index.rst
@@ -8,3 +8,4 @@ Theobroma Systems
 
    jaguar_rk3588
    puma_rk3399
+   ringneck_px30
diff --git a/doc/board/theobroma-systems/ringneck_px30.rst b/doc/board/theobroma-systems/ringneck_px30.rst
new file mode 100644
index 00000000000..c16b9ed17ed
--- /dev/null
+++ b/doc/board/theobroma-systems/ringneck_px30.rst
@@ -0,0 +1,95 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+PX30-uQ7 Ringneck
+=================
+
+The PX30-uQ7 (Ringneck) SoM is a µQseven-compatible (40mmx70mm, MXM-230
+connector) system-on-module from Theobroma Systems, featuring the Rockchip PX30.
+
+It provides the following feature set:
+
+  * up to 4GB DDR4
+  * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
+  * SD card (on a baseboard) via edge connector
+  * Fast Ethernet with on-module TI DP83825I PHY
+  * MIPI-DSI/LVDS
+  * MIPI-CSI
+  * USB
+
+    - 1x USB 2.0 dual-role
+    - 3x USB 2.0 host
+
+  * on-module companion controller (STM32 Cortex-M0 or ATtiny), implementing:
+
+    - low-power RTC functionality (ISL1208 emulation)
+    - fan controller (AMC6821 emulation)
+    - USB<->CAN bridge controller (STM32 only)
+
+  * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
+  * on-module NXP SE05x Secure Element
+
+Here is the step-by-step to boot to U-Boot on PX30-uQ7 Ringneck from Theobroma
+Systems.
+
+Get the Source and build ATF binary
+-----------------------------------
+
+.. prompt:: bash
+
+   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+   cd trusted-firmware-a
+   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=px30 bl31
+   export BL31=$PWD/build/px30/release/bl31/bl31.elf
+
+Compile the U-Boot
+------------------
+
+.. prompt:: bash
+
+   cd ../u-boot
+   make CROSS_COMPILE=aarch64-linux-gnu- ringneck-px30_defconfig all
+
+This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
+(eMMC or SD card).
+
+Flash the image
+---------------
+
+Copy ``u-boot-rockchip.bin`` to offset 32k for SD/eMMC.
+
+SD-Card
+~~~~~~~
+
+.. prompt:: bash
+
+   dd if=u-boot-rockchip.bin of=/dev/sdX seek=64
+
+.. note::
+
+   Replace ``/dev/sdX`` to match your SD card kernel device.
+
+eMMC
+~~~~
+
+``rkdeveloptool`` allows to flash the on-board eMMC via the USB OTG interface
+with help of the Rockchip loader binary.
+
+To enter the USB flashing mode on Haikou baseboard, remove any SD card, insert a
+micro-USB cable in the ``Q7 USB P1`` connector (P8), move ``SW5`` switch into
+``BIOS Disable`` mode, power cycle or reset the board and move ``SW5`` switch
+back to ``Normal Boot`` mode. A new USB device should have appeared on your PC
+(check with ``lsusb -d 2207:330d``).
+
+To flash U-Boot on the eMMC with ``rkdeveloptool``:
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkdeveloptool
+   cd rkdeveloptool
+   autoreconf -i && CPPFLAGS=-Wno-format-truncation ./configure && make
+   git clone https://github.com/rockchip-linux/rkbin.git
+   cd rkbin
+   ./tools/boot_merger RKBOOT/PX30MINIALL.ini
+   cd ..
+   ./rkdeveloptool db rkbin/px30_loader_v2.08.135.bin
+   ./rkdeveloptool wl 64 ../u-boot-rockchip.bin

-- 
2.44.0

