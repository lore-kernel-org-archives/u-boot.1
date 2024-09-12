Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43508EED617
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4858905A;
	Thu, 12 Sep 2024 17:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bq1yu6Ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF90889013; Thu, 12 Sep 2024 17:51:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EF088FEC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B91705C58A2;
 Thu, 12 Sep 2024 15:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 026D0C4CEC3;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=zpCapxLlW1BrO2xuQcko3HzyQ5f8voNpSdv8qNxTBko=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Bq1yu6Honsdv7clMBta7qoryWXkE9H+K0LVAOYJqSetvahXJ8g5vJ4fS+WOo/oCEA
 ORXLM+gssdGFJmXJy3U6zx01TJ/H2ZJhbxO+mRv4PecwqANmH5yWlBoHgtvMa4unJc
 E4CZJOlrJdhzig43wTMVxePSJIAE3/9RCKvS372/sTSzrT6UMz1nHGghZ/o1bBvcV5
 x4dtss6GEeM2BRlJbHUOztg87QK0r7VktYPa2N7wuwnGPGF85i+lyTKPx9vpugENOi
 bqIyxGBPbHsZfL4dPZCFec74yF5WvSv+2oyjSmCdNviKkpCBuDMOoWzdGBCtevFgIQ
 ABBPcddVITEPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E49F5EED617;
 Thu, 12 Sep 2024 15:51:13 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:42 +0100
Subject: [PATCH v2 01/20] arm: dts: Support SC573-EZKIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-1-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=4317;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=r4aHTZBVZsVIuHKj//cUZ8TbZSM5wgSHOGA8oAUbiMs=;
 b=vvApAYSjBxmM5VPOES236JkuWOC6tsf0i75zgYlOWdwOVaDyfQcvHxkg4UJ29Kpiw/NWTvp5T
 sQG9885y4rZB0cSSIemXvIscLe1wn6jBewBMnca0C0TT5WB24tSqNSf
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
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                  |  2 ++
 arch/arm/dts/Makefile        |  2 ++
 arch/arm/dts/sc573-ezkit.dts | 13 +++++++++++
 arch/arm/dts/sc57x.dtsi      | 21 +++++++++++++++++
 arch/arm/dts/sc5xx.dtsi      | 54 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2050ae24df..b172e1ea95 100644
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
index 2d931c23fc..d2194908d9 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1258,6 +1258,8 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
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


