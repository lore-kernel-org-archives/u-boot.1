Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BBAC54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0EC88AFB;
	Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z0lgTuf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 561ED88A7B; Wed, 28 Aug 2024 12:12:26 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E707D8870B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C9EF2A402E7;
 Wed, 28 Aug 2024 10:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 513D6C4E672;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=eM8RjWG47fSFRTrSf/BTgOm4pIig8a7IEAX+0/slPTo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Z0lgTuf2H3Zl+2K7KkzNxt/G1wwm2YSjyRtLuKj96vkPnXQcVS999E4r0nAHs5CBR
 LIlcrOtUEmsG5VZzYVqlrha/Pryw53YG7HI2hCaNu/tKAYxs3H+NiumpGDey4KBXp1
 iOAFbh2sP4FP8GyIFLfrGhV/AC7iVdHvyvooVL+dl1eFvDyjpyRZkNSy0NpEBQkVt5
 QIkBaT+ATZ1o8yvyFZPt2Z25QnGc5ShyL2yEckGIEldw20B4DwXx6oayUPUOdDASnO
 G19kY4GEpEu0DZI1oPRFwiVOgKM54ruE6UCjfgGyHZjmdcpp6/CrfgH5D0yuahlmTM
 HB8fmnrDRcD5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 41575C5479A;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:09 +0100
Subject: [PATCH 01/20] arm: dts: Support SC573-EZKIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-1-44d9adfdf327@analog.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=4193;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=OVSg+BZV1AHkTE15V5hBb895rNTFv7VgbOq175IFpOE=;
 b=xMRO3AATlzZo3ZKGsCAmkZTgHUinRMPrcQ23TL9LEsIzTOkqlVpNcU5wsEOw89wvz7d6aLybe
 zsxugsbYK9fDBeEyDs36/xdvxZp5ZH0s6eYG7dlYRE4CFa3ssytiQgk
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Adds minimal device tree for Analog Devices' SC573-EZKIT board and
common files for the SC57x/SC5xx family.

This also adds all sc5* devicetrees to ARM SC5XX in MAINTAINERS, and
adds the ADSP Linux mailing list as the list for ARM SC5XX.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                  |  2 ++
 arch/arm/dts/Makefile        |  2 ++
 arch/arm/dts/sc573-ezkit.dts | 13 +++++++++++
 arch/arm/dts/sc57x.dtsi      | 21 +++++++++++++++++
 arch/arm/dts/sc5xx.dtsi      | 54 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e47e8a21..0640d56991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -601,8 +601,10 @@ M:	Ian Roberts <ian.roberts@timesys.com>
 M:	Vasileios Bimpikas <vasileios.bimpikas@analog.com>
 M:	Utsav Agarwal <utsav.agarwal@analog.com>
 M:	Arturs Artamonovs <arturs.artamonovs@analog.com>
+L:	adsp-linux@analog.com
 S:	Supported
 T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
+F:	arch/arm/dts/sc5*
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a4d95c8306..8fa56cc9f4 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1275,6 +1275,8 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
 					imx8mm-cl-iot-gate-ied-tpm0.dtbo \
 					imx8mm-cl-iot-gate-ied-tpm1.dtbo
 
+dtb-$(CONFIG_TARGET_SC573_EZKIT) += sc573-ezkit.dtb
+
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
 endif
diff --git a/arch/arm/dts/sc573-ezkit.dts b/arch/arm/dts/sc573-ezkit.dts
new file mode 100644
index 0000000000..0dc2962618
--- /dev/null
+++ b/arch/arm/dts/sc573-ezkit.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc57x.dtsi"
+
+/ {
+	model = "ADI SC573-EZKIT";
+	compatible = "adi,sc573-ezkit", "adi,sc57x";
+};
diff --git a/arch/arm/dts/sc57x.dtsi b/arch/arm/dts/sc57x.dtsi
new file mode 100644
index 0000000000..ddfcae8d19
--- /dev/null
+++ b/arch/arm/dts/sc57x.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#include "sc5xx.dtsi"
+
+/ {
+	gic: interrupt-controller@310b2000 {
+		compatible = "arm,cortex-a5-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x310B2000 0x1000>,
+		      <0x310B4000 0x100>;
+	};
+};
+
+&timer0 {
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
new file mode 100644
index 0000000000..3f440dac29
--- /dev/null
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/adi-sc5xx-clock.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	clocks {
+		sys_clkin0: sys_clkin0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+			bootph-all;
+		};
+
+		sys_clkin1: sys_clkin1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+			bootph-all;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		ranges;
+		bootph-all;
+
+		timer0: timer@31018000 {
+			compatible = "adi,sc5xx-gptimer";
+			reg = <0x31018004 0x100>,
+			      <0x31018060 0x100>;
+			status = "okay";
+			bootph-all;
+		};
+
+		clk: clocks@3108d000 {
+			reg = <0x3108d000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&sys_clkin0>, <&sys_clkin1>;
+			clock-names = "sys_clkin0", "sys_clkin1";
+			status = "okay";
+			bootph-all;
+		};
+	};
+};

-- 
2.34.1


