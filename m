Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA5BCCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826C283655;
	Wed, 15 Oct 2025 12:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2225B836A4; Wed, 15 Oct 2025 12:24:05 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C457C835B3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 776C3B220A10;
 Wed, 15 Oct 2025 12:24:00 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 08/10] riscv: dts: starfive: add Milk-V Mars CM
 system-on-module
Date: Wed, 15 Oct 2025 03:22:51 -0700
Message-ID: <20251015102253.48276-9-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251015102253.48276-1-e@freeshell.de>
References: <20251015102253.48276-1-e@freeshell.de>
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

Milk-V Mars CM is a System-on-Module based on the StarFive VisionFive 2
board and Radxa CM3 System-on-Module compatible with the Raspberry Pi
CM4IO Classic IO Board.

Mars CM SoM features:

- StarFive JH7110 System on Chip with RV64GC up to 1.5GHz
- AXP15060 Power Management Unit
- LPDDR4 2GB / 4GB / 8GB DRAM memory
- BL24C04F 4K bits (512 x 8) EEPROM
- GigaDevice 25LQ128EWIG QSPI NOR Flash 16M or SoC ROM UART loader for
  boot (selectable by GPIO)
- eMMC5.0 8GB / 16GB / 32GB flash storage onboard
- AP6256 via SDIO 2.0 onboard wireless connectivity WiFi 5 + Bluetooth
  5.2 (optional, present in models with WiFi feature)
- 1x Motorcomm YT8531C Gigabit Ethernet PHY
- IMG BXE-4-32 Integrated GPU with 3D Acceleration:
  - H.264 & H.265 4K@60fps Decoding
  - H.265 1080p@30fps Encoding
  - JPEG encoder / decoder

Additional features available via 2x 100-pin connectors for CM4IO Board:
- 1x HDMI 2.0
- 1x MIPI DSI (4-lanes)
- 1x 2CH Audio out (via GPIO)
- 1x MIPI CSI (2x2-lanes or 1x4-lanes)
- 1x USB 2.0
- 1x PCIe 1-lane Host, Gen 2 (5Gbps)
- Up to 28x GPIO, supporting 3.3V
- UART x6
- PWM x8
- I2C x7
- SPI
- I2S

Link to Milk-V Mars CM schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Add the devicetree file to make use of StarFive JH7110 common supported
features PMIC, EEPROM, UART, I2C, GPIO, eMMC, PCIe, QSPI Flash, PWM, and
Ethernet. Also configure the common SD Card interface mmc1 for onboard
SDIO BT+WiFi.

Signed-off-by: E Shattow <e@freeshell.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ upstream commit: 8d193bc0aa2e802be30de331317639482735d738 ]

(cherry picked from commit 8e935d097e975e6322b63fdc8ef9894c8582bef0)
---
 .../src/riscv/starfive/jh7110-milkv-marscm-emmc.dts  | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
new file mode 100644
index 00000000000..e568537af2c
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-milkv-marscm.dtsi"
+
+/ {
+	model = "Milk-V Mars CM";
+	compatible = "milkv,marscm-emmc", "starfive,jh7110";
+};
-- 
2.50.0

