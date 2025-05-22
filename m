Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99475C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D2783145;
	Thu, 22 May 2025 16:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="QWDBmgNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04E48307F; Thu, 22 May 2025 16:11:14 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968EF83095
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=230144c57=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1747923072; x=1779459072;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=llzqysO0b3TpTpiFYoVy3Q5ds6RGbVFw92NasLsi+6Q=;
 b=QWDBmgNhBHD86Izhkd+NTfEMucHeLQikfi/PeXNJVK6lUyPK8+dmfYNS
 ZrDyW4nZew6ggoIhGhX8hX0+pAwBeyjdQnvAnZeOg+sbhkAlqNx/+cGWb
 9JbACd086b2PfCZGcCPHvyw6A3DH09jRCPzISUr58O8L040owFFtRy9Wy
 dgeJ2Yb/qcd5DFMXQI3n9FuOpmFdVuW16FEZ0oFVc3L5FxipBouZs5avi
 L8CSZQNFIJ/vHxqPq110tyS6DR69Ll2s4PnskdvqXERrwR/TOym/g8+5h
 hBQLnqpX4uctX7if/8PpWeNG6aRtKo4EMpPFdCL+33Uv58stMygv5M6i/ A==;
X-CSE-ConnectionGUID: 7PmJpG1zQoeG3faFo7IHbQ==
X-CSE-MsgGUID: FN8BjikcS7Sd2cL4HS639w==
X-IronPort-AV: E=Sophos;i="6.15,306,1739862000"; d="scan'208";a="209459857"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2025 07:11:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 07:10:58 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 07:10:56 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <conor.dooley@microchip.com>, <jamie.gibbons@microchip.com>,
 <praveen.kumar@microchip.com>, <eoin.dickson@microchip.com>,
 <cyril.jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v1 4/4] riscv: dts: microchip: enable gpio banks in Beagle-V
 Fire
Date: Thu, 22 May 2025 19:40:02 +0530
Message-ID: <20250522141002.1212408-5-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
References: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 22 May 2025 16:50:59 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

Add GPIO banks 0, 1 and 2 to the beaglev_fire device tree

Signed-off-by: Eoin Dickson <eoin.dickson@microchip.com>
---
 arch/riscv/dts/mpfs-beaglev-fire.dts | 44 +++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/mpfs-beaglev-fire.dts b/arch/riscv/dts/mpfs-beaglev-fire.dts
index 232fbcc4f3..548171a605 100644
--- a/arch/riscv/dts/mpfs-beaglev-fire.dts
+++ b/arch/riscv/dts/mpfs-beaglev-fire.dts
@@ -4,7 +4,7 @@
  */
 
 /dts-v1/;
-
+#include <dt-bindings/gpio/gpio.h>
 #include "microchip-mpfs.dtsi"
 
 /* Clock frequency (in Hz) of the rtcclk */
@@ -156,6 +156,48 @@
 	sd-uhs-sdr104;
 };
 
+&qspi {
+	status = "okay";
+	cs-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+	num-cs = <1>;
+
+	mmc@0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		gpios = <&gpio2 31 1>;
+		voltage-ranges = <3300 3300>;
+		spi-max-frequency = <5000000>;
+		disable-wp;
+	};
+};
+
+&gpio0 {
+	ngpios=<14>;
+	gpio-line-names = "", "", "", "", "", "", "",
+			  "", "", "", "", "", "SD_CARD_CS", "USER_BUTTON";
+	status = "okay";
+};
+
+&gpio1 {
+	ngpios=<24>;
+	gpio-line-names = "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "ADC_IRQn", "", "", "USB_OCn";
+	status = "okay";
+};
+
+&gpio2 {
+	gpio-line-names = "P8_PIN3_USER_LED_0", "P8_PIN4_USER_LED_1", "P8_PIN5_USER_LED_2",
+			  "P8_PIN6_USER_LED_3", "P8_PIN7_USER_LED_4", "P8_PIN8_USER_LED_5",
+			  "P8_PIN9_USER_LED_6", "P8_PIN10_USER_LED_7", "P8_PIN11_USER_LED_8",
+			  "P8_PIN12_USER_LED_9", "P8_PIN13_USER_LED_10", "P8_PIN14_USER_LED_11",
+			  "P8_PIN15", "P8_PIN16", "P8_PIN17", "P8_PIN18", "P8_PIN19", "P8_PIN20",
+			  "P8_PIN21", "P8_PIN22", "P8_PIN23", "P8_PIN24", "P8_PIN25", "P8_PIN26",
+			  "P8_PIN27", "P8_PIN28", "P8_PIN29", "P8_PIN30", "M2_W_DISABLE1",
+			  "M2_W_DISABLE2", "VIO_ENABLE", "SD_DET";
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
-- 
2.34.1

