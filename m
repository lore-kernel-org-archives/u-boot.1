Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD2AC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 12:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97C780FDA;
	Wed,  2 Apr 2025 14:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1DE81FFC; Wed,  2 Apr 2025 07:40:19 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2070820B0
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 07:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.43.60.20])
 by inet11.abb.com (8.15.2/8.14.7) with ESMTPS id 5325d4xl3445465
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Apr 2025 07:39:05 +0200
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025040207390559-82131 ;
 Wed, 2 Apr 2025 07:39:05 +0200 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2025040207390572-28502 ;
 Wed, 2 Apr 2025 07:39:05 +0200 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Adam Ford" <aford173@gmail.com>,
 "Andre Przywara" <andre.przywara@arm.com>,
 "Fabio Estevam" <festevam@denx.de>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Kever Yang" <kever.yang@rock-chips.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Oliver Gaskell" <Oliver.Gaskell@analog.com>,
 "Prasad Kummari" <prasad.kummari@amd.com>,
 "Sumit Garg" <sumit.garg@kernel.org>, "Tom Rini" <trini@konsulko.com>,
 "Tony Dinh" <mibodhi@gmail.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
Subject: [PATCH v3 4/4] board/BuR/zynq: initial commit
Date: Wed, 2 Apr 2025 07:38:35 +0200
Message-ID: <20250402053901.8149-5-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402053901.8149-1-bernhard.messerklinger@br-automation.com>
References: <20250402053901.8149-1-bernhard.messerklinger@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 04/02/2025 07:39:05 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 04/02/2025 07:39:05 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3
 HF8|December 13, 2024) at 04/02/2025 07:39:05 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3 HF8|December
 13, 2024) at 04/02/2025 07:39:08 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 02 Apr 2025 14:39:53 +0200
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

This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170
boards. This boards are based on the Xilinx Zynq SoC.

Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation=
.com>
---

Changes in v3:
- Split spi=5Fflash and qspi controller node in device tree for the usage
of bootph-all
- Merge binman descriptions into one zynq-binman-brcp1
- Add links instead of manually including u-boot.dtsi files
- Remove empty MAC addresses nodes from the device tree
- Seperate B&R Zynq device trees in the devicetree Makefile

Changes in v2:
- Remove all unnecessary device-tree entries
- Reviewed led names (no pattern restriction found)
- Fix maintainers file
- Cleanup of code
- Move preboot variable to env file

 arch/arm/dts/Makefile                         |   7 +
 arch/arm/dts/zynq-binman-brcp1.dtsi           | 102 +++++++
 arch/arm/dts/zynq-brcp1.dtsi                  | 131 +++++++++
 arch/arm/dts/zynq-brcp150-u-boot.dtsi         |  34 +++
 arch/arm/dts/zynq-brcp150.dts                 | 173 +++++++++++
 arch/arm/dts/zynq-brcp170-u-boot.dtsi         |  26 ++
 arch/arm/dts/zynq-brcp170.dts                 | 139 +++++++++
 arch/arm/dts/zynq-brcp1=5F1r-u-boot.dtsi        |  30 ++
 arch/arm/dts/zynq-brcp1=5F1r.dts                |  28 ++
 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi |   1 +
 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts         |  30 ++
 arch/arm/dts/zynq-brcp1=5F2r-u-boot.dtsi        |   1 +
 arch/arm/dts/zynq-brcp1=5F2r.dts                |  21 ++
 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        |  30 ++
 arch/arm/dts/zynq-brsmarc2.dts                | 157 ++++++++++
 arch/arm/mach-zynq/Kconfig                    |   1 +
 board/BuR/zynq/Kconfig                        |  14 +
 board/BuR/zynq/MAINTAINERS                    |  11 +
 board/BuR/zynq/Makefile                       |  15 +
 board/BuR/zynq/brcp150/board.c                |   4 +
 board/BuR/zynq/brcp150/ps7=5Finit=5Fgpl.c         | 278 ++++++++++++++++++
 board/BuR/zynq/brcp170/board.c                |   4 +
 board/BuR/zynq/brcp170/ps7=5Finit=5Fgpl.c         | 274 +++++++++++++++++
 board/BuR/zynq/brcp1=5F1r/board.c               |   4 +
 board/BuR/zynq/brcp1=5F1r/ps7=5Finit=5Fgpl.c        | 274 +++++++++++++++++
 board/BuR/zynq/brcp1=5F1r=5Fswitch/board.c        |   4 +
 board/BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c | 270 ++++++++++++++=
+++
 board/BuR/zynq/brcp1=5F2r/board.c               |   4 +
 board/BuR/zynq/brcp1=5F2r/ps7=5Finit=5Fgpl.c        | 277 +++++++++++++++++
 board/BuR/zynq/brsmarc2/board.c               |  30 ++
 board/BuR/zynq/brsmarc2/ps7=5Finit=5Fgpl.c        | 276 +++++++++++++++++
 board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
 board/BuR/zynq/env/brcp1.env                  | 109 +++++++
 board/BuR/zynq/env/brcp150.env                | 119 ++++++++
 configs/brcp150=5Fdefconfig                     | 121 ++++++++
 configs/brcp170=5Fdefconfig                     | 120 ++++++++
 configs/brcp1=5F1r=5Fdefconfig                    | 120 ++++++++
 configs/brcp1=5F1r=5Fswitch=5Fdefconfig             | 121 ++++++++
 configs/brcp1=5F2r=5Fdefconfig                    | 120 ++++++++
 configs/brsmarc2=5Fdefconfig                    | 120 ++++++++
 include/configs/brzynq.h                      |  21 ++
 41 files changed, 3852 insertions(+)
 create mode 100644 arch/arm/dts/zynq-binman-brcp1.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp150.dts
 create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp170.dts
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r.dts
 create mode 120000 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts
 create mode 120000 arch/arm/dts/zynq-brcp1=5F2r-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1=5F2r.dts
 create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
 create mode 100644 board/BuR/zynq/Kconfig
 create mode 100644 board/BuR/zynq/MAINTAINERS
 create mode 100644 board/BuR/zynq/Makefile
 create mode 100644 board/BuR/zynq/brcp150/board.c
 create mode 100644 board/BuR/zynq/brcp150/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp170/board.c
 create mode 100644 board/BuR/zynq/brcp170/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r/board.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r=5Fswitch/board.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp1=5F2r/board.c
 create mode 100644 board/BuR/zynq/brcp1=5F2r/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brsmarc2/board.c
 create mode 100644 board/BuR/zynq/brsmarc2/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/common/board.c
 create mode 100644 board/BuR/zynq/env/brcp1.env
 create mode 100644 board/BuR/zynq/env/brcp150.env
 create mode 100644 configs/brcp150=5Fdefconfig
 create mode 100644 configs/brcp170=5Fdefconfig
 create mode 100644 configs/brcp1=5F1r=5Fdefconfig
 create mode 100644 configs/brcp1=5F1r=5Fswitch=5Fdefconfig
 create mode 100644 configs/brcp1=5F2r=5Fdefconfig
 create mode 100644 configs/brsmarc2=5Fdefconfig
 create mode 100644 include/configs/brzynq.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 267b0179a5f..40e696c9e37 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -297,6 +297,13 @@ dtb-$(CONFIG=5FARCH=5FZYNQMP) +=3D \
 	zynqmp-zc1751-xm017-dc3.dtb		\
 	zynqmp-zc1751-xm018-dc4.dtb		\
 	zynqmp-zc1751-xm019-dc5.dtb
+dtb-$(CONFIG=5FARCH=5FZYNQ) +=3D \
+	zynq-brcp1=5F2r.dtb			\
+	zynq-brcp1=5F1r.dtb			\
+	zynq-brcp1=5F1r=5Fswitch.dtb		\
+	zynq-brsmarc2.dtb			\
+	zynq-brcp150.dtb			\
+	zynq-brcp170.dtb
=20
 zynqmp-p-a2197-00-revA-x-prc-01-revA-dtbs :=3D zynqmp-p-a2197-00-revA.dtb =
zynqmp-p-a2197-00-revA-x-prc-01-revA.dtbo
 zynqmp-p-a2197-00-revA-x-prc-02-revA-dtbs :=3D zynqmp-p-a2197-00-revA.dtb =
zynqmp-p-a2197-00-revA-x-prc-02-revA.dtbo
diff --git a/arch/arm/dts/zynq-binman-brcp1.dtsi b/arch/arm/dts/zynq-binman=
-brcp1.dtsi
new file mode 100644
index 00000000000..3cc8ee8b810
--- /dev/null
+++ b/arch/arm/dts/zynq-binman-brcp1.dtsi
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 B&R Industrial Automation GmbH
+ */
+
+ #include <config.h>
+
+/ {
+	binman {
+		bootph-all;
+		filename =3D "flash.bin";
+		pad-byte =3D <0xff>;
+		align-size =3D <16>;
+		align =3D <16>;
+
+		blob@0 {
+			filename =3D "spl/boot.bin";
+			offset =3D <0x0>;
+		};
+
+		fit {
+			description =3D "U-Boot BR Zynq boards";
+			offset =3D <CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS>;
+
+			images {
+				uboot {
+					description =3D "U-Boot BR Zynq";
+					type =3D "firmware";
+					os =3D "u-boot";
+					arch =3D "arm";
+					compression =3D "none";
+					load =3D <CONFIG=5FTEXT=5FBASE>;
+					u-boot-nodtb {
+					};
+				};
+
+				fdt-0 {
+					description =3D "DTB BR Zynq";
+					type =3D "flat=5Fdt";
+					arch =3D "arm";
+					compression =3D "none";
+					u-boot-dtb {
+					};
+				};
+			};
+
+			configurations {
+				default =3D "conf-0";
+
+				conf-0 {
+					description =3D "BR Zynq";
+					firmware =3D "uboot";
+					fdt =3D "fdt-0";
+				};
+			};
+		};
+
+		blob-ext@0 {
+			filename =3D "blobs/cfg.img";
+			offset =3D <0xC0000>;
+			size =3D <0x10000>;
+			optional;
+		};
+
+		blob-ext@5 {
+			filename =3D "blobs/cfg=5Fopt.img";
+			offset =3D <0xD0000>;
+			size =3D <0x10000>;
+			optional;
+		};
+
+		blob-ext@1 {
+			bootph-all;
+			filename =3D "blobs/bitstream.bit";
+			offset =3D <0x100000>;
+			size =3D <0x200000>;
+			optional;
+		};
+
+		blob-ext@4 {
+			bootph-all;
+			filename =3D "blobs/bitstream=5Fupdate.bit";
+			offset =3D <0x400000>;
+			size =3D <0x200000>;
+			optional;
+		};
+
+		blob-ext@2 {
+			filename =3D "blobs/bootar.itb";
+			offset =3D <0x900000>;
+			size =3D <0x600000>;
+			optional;
+		};
+
+		blob-ext@3 {
+			filename =3D "blobs/dtb.bin";
+			offset =3D <0xF00000>;
+			size =3D <0x100000>;
+			optional;
+		};
+	};
+};
diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi
new file mode 100644
index 00000000000..ebaf42d9419
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1.dtsi
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/include/ "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "BRCP1 CPU";
+	compatible =3D "br,cp1",
+		     "xlnx,zynq-7000";
+
+	aliases {
+		i2c0 =3D &i2c0;
+		serial0 =3D &uart0;
+		spi0 =3D &qspi;
+		mmc0 =3D &sdhci0;
+	};
+
+	memory {
+		device=5Ftype =3D "memory";
+		reg =3D <0x0 0x40000000>;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	usb=5Fphy0: phy0 {
+		compatible =3D "usb-nop-xceiv";
+		#phy-cells =3D <0>;
+	};
+
+	brd=5Frst: board=5Freset {
+		compatible =3D "br,board-reset";
+		pin =3D <&gpio0 9 GPIO=5FACTIVE=5FHIGH>;
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		se=5Fgreen {
+			label =3D "S=5FE=5FGREEN";
+			gpios =3D <&ledgpio 0 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		se=5Fred {
+			label =3D "S=5FE=5FRED";
+			gpios =3D <&ledgpio 1 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		rdy=5Ff=5Fyellow {
+			label =3D "RDY=5FF=5FYELLOW";
+			gpios =3D <&ledgpio 2 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		re=5Fgreen {
+			label =3D "R=5FE=5FGREEN";
+			gpios =3D <&ledgpio 3 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		re=5Fred {
+			label =3D "R=5FE=5FRED";
+			gpios =3D <&ledgpio 4 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		plk=5Fse=5Fgreen {
+			label =3D "PLK=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 5 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		eth=5Fse=5Fgreen {
+			label =3D "ETH=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 6 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+	};
+};
+
+&i2c0 {
+	status =3D "okay";
+	clock-frequency =3D <100000>;
+
+	ledgpio: max7320@5d {	/* board LED */
+		status =3D "okay";
+		compatible =3D "maxim,max7320";
+		reg =3D <0x5d>;
+		#gpio-cells =3D <2>;
+		gpio-controller;
+		ngpios =3D <8>;
+	};
+
+	pmic0: da9062@58 {
+		compatible =3D "dlg,da9062";
+		reg =3D <0x58>;
+	};
+};
+
+&sdhci0 {
+	status =3D "okay";
+	max-frequency =3D <25000000>;
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&qspi {
+	status =3D "okay";
+	spi-max-frequency =3D <100000000>;
+
+	spi=5Fflash: spiflash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "jedec,spi-nor", "spi-flash", "s25fl256s1";
+		spi-max-frequency =3D <100000000>;
+		spi-cpol;
+		spi-cpha;
+		reg =3D <0>;
+	};
+};
+
+&usb0 {
+	status =3D "okay";
+	dr=5Fmode =3D "host";
+	usb-phy =3D <&usb=5Fphy0>;
+};
+
+&gpio0 {
+	status =3D "okay";
+};
diff --git a/arch/arm/dts/zynq-brcp150-u-boot.dtsi b/arch/arm/dts/zynq-brcp=
150-u-boot.dtsi
new file mode 100644
index 00000000000..1bfd5f27a7e
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+#include "zynq-binman-brcp1.dtsi"
+
+&i2c0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+};
+
+&spi=5Fflash {
+	bootph-all;
+};
+
+&gpio0 {
+	bootph-all;
+};
+
+&brd=5Frst {
+	bootph-all;
+};
+
+&rs232=5Fen {
+	bootph-all;
+};
diff --git a/arch/arm/dts/zynq-brcp150.dts b/arch/arm/dts/zynq-brcp150.dts
new file mode 100644
index 00000000000..1b22d3793db
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp150.dts
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "BRCP150 CPU";
+	compatible =3D "br,cp150",
+		     "xlnx,zynq-7000";
+
+	aliases {
+		i2c0 =3D &i2c0;
+		serial0 =3D &uart0;
+		spi0 =3D &qspi;
+	};
+
+	memory {
+		device=5Ftype =3D "memory";
+		reg =3D <0x0 0x20000000>;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	usb=5Fphy0: phy0 {
+		compatible =3D "usb-nop-xceiv";
+		#phy-cells =3D <0>;
+	};
+
+	brd=5Frst: board=5Freset {
+		compatible =3D "br,board-reset";
+		pin =3D <&gpio0 27 GPIO=5FACTIVE=5FHIGH>;
+	};
+
+	/* Put this pin active high to enable RS232 debug serial */
+	rs232=5Fen: rs232=5Fenable {
+		compatible =3D "br,rs232-en";
+		pin =3D <&gpio0 52 GPIO=5FACTIVE=5FHIGH>;
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		re=5Fgreen {
+			label =3D "R=5FE=5FGREEN";
+			gpios =3D <&ledgpio 0 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		re=5Fred {
+			label =3D "R=5FE=5FRED";
+			gpios =3D <&ledgpio 1 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		rdy=5Ff=5Fred {
+			label =3D "RDY=5FF=5FRED";
+			gpios =3D <&ledgpio 2 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		rdy=5Ff=5Fyellow {
+			label =3D "RDY=5FF=5FYELLOW";
+			gpios =3D <&ledgpio 3 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		se=5Fgreen {
+			label =3D "S=5FE=5FGREEN";
+			gpios =3D <&ledgpio 4 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		se=5Fred {
+			label =3D "S=5FE=5FRED";
+			gpios =3D <&ledgpio 5 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		plk=5Fse=5Fgreen {
+			label =3D "PLK=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 6 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		eth=5Fse=5Fgreen {
+			label =3D "ETH=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 7 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		user1=5Fgreen {
+			label =3D "USER1=5FGREEN";
+			gpios =3D <&ledgpio 12 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		user1=5Fred {
+			label =3D "USER1=5FRED";
+			gpios =3D <&ledgpio 13 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		user2=5Fgreen {
+			label =3D "USER2=5FGREEN";
+			gpios =3D <&ledgpio 14 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		user2=5Fred {
+			label =3D "USER2=5FRED";
+			gpios =3D <&ledgpio 15 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+	};
+};
+
+&gem0 {
+	status =3D "okay";
+	phy-mode =3D "mii";
+	phy-handle =3D <&ethernet=5Fphy>;
+
+	ethernet=5Fphy: emio-phy@2 {
+		reg =3D <2>;
+		max-speed =3D <100>;
+	};
+};
+
+&i2c0 {
+	status =3D "okay";
+	clock-frequency =3D <100000>;
+
+	ledgpio: max7320@5d {	/* board LED */
+		status =3D "okay";
+		compatible =3D "maxim,max7320";
+		reg =3D <0x5d>;
+		#gpio-cells =3D <2>;
+		gpio-controller;
+		ngpios =3D <16>;
+	};
+};
+
+&sdhci0 {
+	status =3D "okay";
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&qspi {
+	status =3D "okay";
+	spi-max-frequency =3D <100000000>;
+
+	spi=5Fflash: spiflash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "jedec,spi-nor", "spi-flash", "s25fl256s1";
+		spi-max-frequency =3D <100000000>;
+		spi-cpol;
+		spi-cpha;
+		reg =3D <0>;
+	};
+};
+
+&usb0 {
+	status =3D "okay";
+	dr=5Fmode =3D "host";
+	usb-phy =3D <&usb=5Fphy0>;
+};
+
+&gpio0 {
+	status =3D "okay";
+};
+
+/* Since the gem0 clock is configured EMIO this dummy entry is needed */
+&clkc {
+	clocks =3D <&clkc 16>;
+	clock-names =3D "gem0=5Femio=5Fclk";
+};
diff --git a/arch/arm/dts/zynq-brcp170-u-boot.dtsi b/arch/arm/dts/zynq-brcp=
170-u-boot.dtsi
new file mode 100644
index 00000000000..ceea610ec17
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp170-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+#include "zynq-binman-brcp1.dtsi"
+
+&i2c0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+};
+
+&spi=5Fflash {
+	bootph-all;
+};
+
+&gpio0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/zynq-brcp170.dts b/arch/arm/dts/zynq-brcp170.dts
new file mode 100644
index 00000000000..eee19ce4c5f
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp170.dts
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "BRCP170 CPU";
+	compatible =3D "br,cp170",
+		     "xlnx,zynq-7000";
+
+	aliases {
+		i2c0 =3D &i2c0;
+		serial0 =3D &uart0;
+		spi0 =3D &qspi;
+	};
+
+	memory {
+		device=5Ftype =3D "memory";
+		reg =3D <0x0 0x20000000>;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	usb=5Fphy0: phy0 {
+		compatible =3D "usb-nop-xceiv";
+		#phy-cells =3D <0>;
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		re=5Fgreen {
+			label =3D "R=5FE=5FGREEN";
+			gpios =3D <&ledgpio 0 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		re=5Fred {
+			label =3D "R=5FE=5FRED";
+			gpios =3D <&ledgpio 1 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		rdy=5Ff=5Fred {
+			label =3D "RDY=5FF=5FRED";
+			gpios =3D <&ledgpio 2 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		rdy=5Ff=5Fyellow {
+			label =3D "RDY=5FF=5FYELLOW";
+			gpios =3D <&ledgpio 3 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		se=5Fgreen {
+			label =3D "S=5FE=5FGREEN";
+			gpios =3D <&ledgpio 4 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		se=5Fred {
+			label =3D "S=5FE=5FRED";
+			gpios =3D <&ledgpio 5 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		plk=5Fse=5Fgreen {
+			label =3D "PLK=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 6 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+		eth=5Fse=5Fgreen {
+			label =3D "ETH=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 7 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+	};
+};
+
+&gem0 {
+	status =3D "okay";
+	phy-mode =3D "rgmii-id";
+	phy-handle =3D <&ethernet=5Fphy>;
+
+	ethernet=5Fphy: ethernet-phy@0 {
+		reg =3D <0>;
+		max-speed =3D <100>;
+		ti,rx-internal-delay =3D <7>;
+		ti,tx-internal-delay =3D <7>;
+		ti,fifo-depth =3D <0>;
+	};
+};
+
+&i2c0 {
+	status =3D "okay";
+	clock-frequency =3D <100000>;
+
+	ledgpio: max7320@58 {	/* board LED */
+		status =3D "okay";
+		compatible =3D "maxim,max7320";
+		reg =3D <0x58>;
+		#gpio-cells =3D <2>;
+		gpio-controller;
+		ngpios =3D <8>;
+	};
+};
+
+&sdhci0 {
+	status =3D "okay";
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&qspi {
+	status =3D "okay";
+	spi-max-frequency =3D <100000000>;
+
+	spi=5Fflash: spiflash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "jedec,spi-nor", "spi-flash", "s25fl256s1";
+		spi-max-frequency =3D <100000000>;
+		spi-cpol;
+		spi-cpha;
+		reg =3D <0>;
+	};
+};
+
+&usb0 {
+	status =3D "okay";
+	dr=5Fmode =3D "host";
+	usb-phy =3D <&usb=5Fphy0>;
+};
+
+&gpio0 {
+	status =3D "okay";
+};
diff --git a/arch/arm/dts/zynq-brcp1=5F1r-u-boot.dtsi b/arch/arm/dts/zynq-b=
rcp1=5F1r-u-boot.dtsi
new file mode 100644
index 00000000000..58c4558ddff
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1=5F1r-u-boot.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+#include "zynq-binman-brcp1.dtsi"
+
+&i2c0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+};
+
+&spi=5Fflash {
+	bootph-all;
+};
+
+&gpio0 {
+	bootph-all;
+};
+
+&brd=5Frst {
+	bootph-all;
+};
diff --git a/arch/arm/dts/zynq-brcp1=5F1r.dts b/arch/arm/dts/zynq-brcp1=5F1=
r.dts
new file mode 100644
index 00000000000..fd7ae5539c3
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1=5F1r.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/dts-v1/;
+#include "zynq-brcp1.dtsi"
+
+/ {
+	memory {
+		device=5Ftype =3D "memory";
+		reg =3D <0x0 0x8000000>;
+	};
+};
+
+&gem0 {
+	status =3D "okay";
+	phy-mode =3D "rgmii-id";
+	phy-handle =3D <&ethernet=5Fphy>;
+
+	ethernet=5Fphy: ethernet-phy@0 {
+		reg =3D <0>;
+		ti,rx-internal-delay =3D <7>;
+		ti,tx-internal-delay =3D <7>;
+		ti,fifo-depth =3D <0>;
+		max-speed =3D <1000>;
+	};
+};
diff --git a/arch/arm/dts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi b/arch/arm/d=
ts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi
new file mode 120000
index 00000000000..5a31a05ea66
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi
@@ -0,0 +1 @@
+zynq-brcp1=5F1r-u-boot.dtsi
\ No newline at end of file
diff --git a/arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts b/arch/arm/dts/zynq-=
brcp1=5F1r=5Fswitch.dts
new file mode 100644
index 00000000000..a68d530bfe2
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/dts-v1/;
+#include "zynq-brcp1.dtsi"
+
+/ {
+	memory {
+		device=5Ftype =3D "memory";
+		reg =3D <0x0 0x8000000>;
+	};
+};
+
+&gem0 {
+	status =3D "okay";
+	phy-mode =3D "gmii";
+
+	fixed-link {
+		speed =3D <100>;
+		full-duplex;
+	};
+};
+
+/* Since the gem0 clock is configured EMIO this dummy entry is needed */
+&clkc {
+	clocks =3D <&clkc 16>;
+	clock-names =3D "gem0=5Femio=5Fclk";
+};
diff --git a/arch/arm/dts/zynq-brcp1=5F2r-u-boot.dtsi b/arch/arm/dts/zynq-b=
rcp1=5F2r-u-boot.dtsi
new file mode 120000
index 00000000000..5a31a05ea66
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1=5F2r-u-boot.dtsi
@@ -0,0 +1 @@
+zynq-brcp1=5F1r-u-boot.dtsi
\ No newline at end of file
diff --git a/arch/arm/dts/zynq-brcp1=5F2r.dts b/arch/arm/dts/zynq-brcp1=5F2=
r.dts
new file mode 100644
index 00000000000..353d8a1235c
--- /dev/null
+++ b/arch/arm/dts/zynq-brcp1=5F2r.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/dts-v1/;
+#include "zynq-brcp1.dtsi"
+
+&gem0 {
+	status =3D "okay";
+	phy-mode =3D "rgmii-id";
+	phy-handle =3D <&ethernet=5Fphy>;
+
+	ethernet=5Fphy: ethernet-phy@0 {
+		reg =3D <0>;
+		ti,rx-internal-delay =3D <7>;
+		ti,tx-internal-delay =3D <7>;
+		ti,fifo-depth =3D <0>;
+		max-speed =3D <1000>;
+	};
+};
diff --git a/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi b/arch/arm/dts/zynq-brs=
marc2-u-boot.dtsi
new file mode 100644
index 00000000000..58c4558ddff
--- /dev/null
+++ b/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+#include "zynq-binman-brcp1.dtsi"
+
+&i2c0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+};
+
+&spi=5Fflash {
+	bootph-all;
+};
+
+&gpio0 {
+	bootph-all;
+};
+
+&brd=5Frst {
+	bootph-all;
+};
diff --git a/arch/arm/dts/zynq-brsmarc2.dts b/arch/arm/dts/zynq-brsmarc2.dts
new file mode 100644
index 00000000000..32f873d1b4c
--- /dev/null
+++ b/arch/arm/dts/zynq-brsmarc2.dts
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 B&R Industrial Automation GmbH
+ */
+
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model =3D "BRSMARC2 CPU";
+	compatible =3D "br,smarc2",
+		     "xlnx,zynq-7000";
+
+	aliases {
+		i2c0 =3D &i2c0;
+		serial0 =3D &uart0;
+		spi0 =3D &qspi;
+		mmc0 =3D &sdhci0;
+		can0 =3D &can0;
+		can1 =3D &can1;
+	};
+
+	memory {
+		device=5Ftype =3D "memory";
+		reg =3D <0x0 0x10000000>;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	usb=5Fphy0: phy0 {
+		compatible =3D "usb-nop-xceiv";
+		#phy-cells =3D <0>;
+	};
+
+	brd=5Frst: board=5Freset {
+		compatible =3D "br,board-reset";
+		pin =3D <&gpio0 9 GPIO=5FACTIVE=5FHIGH>;
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		plk=5Fse=5Fgreen {
+			label =3D "PLK=5FS=5FE=5FGREEN";
+			gpios =3D <&ledgpio 0 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		plk=5Fse=5Fred {
+			label =3D "PLK=5FS=5FE=5FRED";
+			gpios =3D <&ledgpio 1 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		rdy=5Ff=5Fyellow {
+			label =3D "RDY=5FF=5FYELLOW";
+			gpios =3D <&ledgpio 2 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		re=5Fgreen {
+			label =3D "R=5FE=5FGREEN";
+			gpios =3D <&ledgpio 3 GPIO=5FACTIVE=5FLOW>;
+			default-state =3D "off";
+		};
+		re=5Fred {
+			label =3D "R=5FE=5FRED";
+			gpios =3D <&ledgpio 4 GPIO=5FACTIVE=5FHIGH>;
+			default-state =3D "off";
+		};
+	};
+};
+
+&gem0 {
+	status =3D "okay";
+	phy-mode =3D "rgmii-id";
+	phy-handle =3D <&ethernet=5Fphy0>;
+
+	ethernet=5Fphy0: ethernet-phy@1 {
+		ti,ledcr =3D <0x0480>;
+		ti,rgmii-rxclk-shift;
+		reg =3D <1>;
+	};
+};
+
+&gem1 {
+	status =3D "okay";
+	phy-mode =3D "rgmii-id";
+	phy-handle =3D <&ethernet=5Fphy1>;
+	mac-address =3D [ 00 00 00 00 00 00 ];
+
+	ethernet=5Fphy1: ethernet-phy@3{
+		ti,ledcr =3D <0x0480>;
+		reg =3D <3>;
+	};
+};
+
+&i2c0 {
+	status =3D "okay";
+	clock-frequency =3D <100000>;
+
+	resetc: rststm@60 {	/* reset controller */
+		compatible =3D "bur,rststm";
+		reg =3D <0x60>;
+		hit-gpios =3D <&gpio0 84 GPIO=5FACTIVE=5FHIGH>;
+		cooling-min-state =3D <0>;
+		cooling-max-state =3D <1>;	/* reset gets fired */
+		#cooling-cells =3D <2>;		/* min followed by max */
+	};
+
+	ledgpio: max7320@5d {	/* board LED */
+		status =3D "okay";
+		compatible =3D "maxim,max7320";
+		reg =3D <0x5d>;
+		#gpio-cells =3D <2>;
+		gpio-controller;
+		ngpios =3D <8>;
+	};
+};
+
+&i2c1 {
+	status =3D "okay";
+	clock-frequency =3D <100000>;
+};
+
+&sdhci0 {
+	status =3D "okay";
+	max-frequency =3D <25000000>;
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&qspi {
+	status =3D "okay";
+	spi-max-frequency =3D <100000000>;
+
+	spi=5Fflash: spiflash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "jedec,spi-nor", "spi-flash", "s25fl256s1";
+		spi-max-frequency =3D <100000000>;
+		spi-cpol;
+		spi-cpha;
+		reg =3D <0>;
+	};
+};
+
+&gpio0 {
+	status =3D "okay";
+};
+
+&usb0 {
+	status =3D "okay";
+	dr=5Fmode =3D "host";
+	usb-phy =3D <&usb=5Fphy0>;
+};
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 376d1bc7131..c3f505fa15c 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -58,5 +58,6 @@ config ZYNQ=5FSDHCI=5FMAX=5FFREQ
=20
 source "board/xilinx/Kconfig"
 source "board/xilinx/zynq/Kconfig"
+source "board/BuR/zynq/Kconfig"
=20
 endif
diff --git a/board/BuR/zynq/Kconfig b/board/BuR/zynq/Kconfig
new file mode 100644
index 00000000000..b450a21bd98
--- /dev/null
+++ b/board/BuR/zynq/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# B&R Industrial Automation GmbH - http://www.br-automation.com
+if ARCH=5FZYNQ
+
+config TARGET=5FZYNQ=5FBR
+	bool "Support BR Zynq builds"
+	depends on SYS=5FVENDOR =3D "BuR"
+	select BINMAN
+	select SPL=5FBINMAN=5FFDT
+
+endif
+
+source "board/BuR/common/Kconfig"
diff --git a/board/BuR/zynq/MAINTAINERS b/board/BuR/zynq/MAINTAINERS
new file mode 100644
index 00000000000..d655cae58d4
--- /dev/null
+++ b/board/BuR/zynq/MAINTAINERS
@@ -0,0 +1,11 @@
+ZYNQ BOARD
+M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
+S:	Maintained
+F:	board/BuR/zynq/
+F:	board/BuR/common/
+F:	include/configs/brzynq.h
+F:	arch/arm/dts/zynq-br*
+F:	configs/brcp1=5F*
+F:	configs/brcp150=5Fdefconfig
+F:	configs/brcp170=5Fdefconfig
+F:	configs/brsmarc2=5Fdefconfig
diff --git a/board/BuR/zynq/Makefile b/board/BuR/zynq/Makefile
new file mode 100644
index 00000000000..fed40b0a069
--- /dev/null
+++ b/board/BuR/zynq/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# B&R Industrial Automation GmbH - http://www.br-automation.com
+
+hw-platform-y :=3D$(shell echo $(CONFIG=5FDEFAULT=5FDEVICE=5FTREE) | sed -=
e 's/zynq-//')
+
+obj-y :=3D ../common/common.o
+obj-y +=3D ../common/br=5Fresetc.o
+obj-y +=3D common/board.o
+obj-y +=3D $(hw-platform-y)/board.o
+
+obj-$(CONFIG=5FSPL=5FBUILD) +=3D $(hw-platform-y)/ps7=5Finit=5Fgpl.o
+
+# Suppress "warning: function declaration isn't a prototype"
+CFLAGS=5FREMOVE=5Fps7=5Finit=5Fgpl.o :=3D -Wstrict-prototypes
diff --git a/board/BuR/zynq/brcp150/board.c b/board/BuR/zynq/brcp150/board.c
new file mode 100644
index 00000000000..456d4900680
--- /dev/null
+++ b/board/BuR/zynq/brcp150/board.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ */
diff --git a/board/BuR/zynq/brcp150/ps7=5Finit=5Fgpl.c b/board/BuR/zynq/brc=
p150/ps7=5Finit=5Fgpl.c
new file mode 100644
index 00000000000..822bce358aa
--- /dev/null
+++ b/board/BuR/zynq/brcp150/ps7=5Finit=5Fgpl.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/ps7=5Finit=5Fgpl.h>
+
+unsigned long ps7=5Fpll=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000110, 0x003FFFF0U, 0x001772C0U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x0007F000U, 0x0001A000U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
+	EMIT=5FMASKWRITE(0XF8000114, 0x003FFFF0U, 0x001DB2C0U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x0007F000U, 0x00015000U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000002U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
+	EMIT=5FMASKWRITE(0XF8000118, 0x003FFFF0U, 0x0012C220U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x0007F000U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000004U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fclock=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000128, 0x03F03F01U, 0x00203401U),
+	EMIT=5FMASKWRITE(0XF8000138, 0x00000011U, 0x00000011U),
+	EMIT=5FMASKWRITE(0XF8000140, 0x03F03F71U, 0x00500141U),
+	EMIT=5FMASKWRITE(0XF800014C, 0x00003F31U, 0x00000801U),
+	EMIT=5FMASKWRITE(0XF8000150, 0x00003F33U, 0x00001001U),
+	EMIT=5FMASKWRITE(0XF8000154, 0x00003F33U, 0x00001003U),
+	EMIT=5FMASKWRITE(0XF8000158, 0x00003F33U, 0x00000802U),
+	EMIT=5FMASKWRITE(0XF800015C, 0x03F03F33U, 0x00A01403U),
+	EMIT=5FMASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000168, 0x00003F31U, 0x00000801U),
+	EMIT=5FMASKWRITE(0XF8000170, 0x03F03F30U, 0x00400800U),
+	EMIT=5FMASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01FF844DU),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fddr=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006004, 0x0007FFFFU, 0x0000103FU),
+	EMIT=5FMASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
+	EMIT=5FMASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
+	EMIT=5FMASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
+	EMIT=5FMASKWRITE(0XF8006014, 0x001FFFFFU, 0x00042E1AU),
+	EMIT=5FMASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D154D4U),
+	EMIT=5FMASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
+	EMIT=5FMASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
+	EMIT=5FMASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
+	EMIT=5FMASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
+	EMIT=5FMASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
+	EMIT=5FMASKWRITE(0XF8006034, 0x13FF3FFFU, 0x00011674U),
+	EMIT=5FMASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
+	EMIT=5FMASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
+	EMIT=5FMASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0F666666U),
+	EMIT=5FMASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
+	EMIT=5FMASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
+	EMIT=5FMASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
+	EMIT=5FMASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
+	EMIT=5FMASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
+	EMIT=5FMASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
+	EMIT=5FMASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
+	EMIT=5FMASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
+	EMIT=5FMASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
+	EMIT=5FMASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0670C845U),
+	EMIT=5FMASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
+	EMIT=5FMASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
+	EMIT=5FMASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
+	EMIT=5FMASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
+	EMIT=5FMASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
+	EMIT=5FMASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
+	EMIT=5FMASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C000U),
+	EMIT=5FMASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
+	EMIT=5FMASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
+	EMIT=5FMASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
+	EMIT=5FMASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
+	EMIT=5FMASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
+	EMIT=5FMASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
+	EMIT=5FMASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C5U),
+	EMIT=5FMASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
+	EMIT=5FMASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
+	EMIT=5FMASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
+	EMIT=5FMASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
+	EMIT=5FMASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
+	EMIT=5FMASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
+	EMIT=5FMASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
+	EMIT=5FMASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
+	EMIT=5FMASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
+	EMIT=5FMASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A6U),
+	EMIT=5FMASKPOLL(0XF8000B74, 0x00002000U),
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
+	EMIT=5FMASKPOLL(0XF8006054, 0x00000007U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fmio=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
+	EMIT=5FMASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
+	EMIT=5FMASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF8000740, 0x00003FFFU, 0x000003E0U),
+	EMIT=5FMASKWRITE(0XF8000744, 0x00003FFFU, 0x000003E1U),
+	EMIT=5FMASKWRITE(0XF8000748, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF800074C, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000750, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000754, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000758, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF800075C, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000760, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000764, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000768, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF800076C, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000321U),
+	EMIT=5FMASKWRITE(0XF80007BC, 0x00003FFFU, 0x00001220U),
+	EMIT=5FMASKWRITE(0XF80007C0, 0x00003FFFU, 0x00001220U),
+	EMIT=5FMASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000321U),
+	EMIT=5FMASKWRITE(0XF80007C8, 0x00003FFFU, 0x000013E1U),
+	EMIT=5FMASKWRITE(0XF80007CC, 0x00003FFFU, 0x000003E0U),
+	EMIT=5FMASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FMASKWRITE(0XE0001034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0001018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0001000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0001004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
+	EMIT=5FMASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fpost=5Fconfig=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
+	EMIT=5FMASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+int ps7=5Fpost=5Fconfig(void)
+{
+	return ps7=5Fconfig(ps7=5Fpost=5Fconfig=5F3=5F0);
+}
+
+int ps7=5Finit(void)
+{
+	int ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fmio=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fpll=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fclock=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fddr=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	return PS7=5FINIT=5FSUCCESS;
+}
diff --git a/board/BuR/zynq/brcp170/board.c b/board/BuR/zynq/brcp170/board.c
new file mode 100644
index 00000000000..456d4900680
--- /dev/null
+++ b/board/BuR/zynq/brcp170/board.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ */
diff --git a/board/BuR/zynq/brcp170/ps7=5Finit=5Fgpl.c b/board/BuR/zynq/brc=
p170/ps7=5Finit=5Fgpl.c
new file mode 100644
index 00000000000..223d13cc389
--- /dev/null
+++ b/board/BuR/zynq/brcp170/ps7=5Finit=5Fgpl.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/ps7=5Finit=5Fgpl.h>
+
+unsigned long ps7=5Fpll=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000110, 0x003FFFF0U, 0x001772C0U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x0007F000U, 0x0001A000U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
+	EMIT=5FMASKWRITE(0XF8000114, 0x003FFFF0U, 0x001DB2C0U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x0007F000U, 0x00015000U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000002U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
+	EMIT=5FMASKWRITE(0XF8000118, 0x003FFFF0U, 0x001F42C0U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x0007F000U, 0x00014000U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000004U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fclock=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000128, 0x03F03F01U, 0x00203401U),
+	EMIT=5FMASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000140, 0x03F03F71U, 0x00100801U),
+	EMIT=5FMASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000158, 0x00003F33U, 0x00000502U),
+	EMIT=5FMASKWRITE(0XF800015C, 0x03F03F33U, 0x00501903U),
+	EMIT=5FMASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000170, 0x03F03F30U, 0x00400500U),
+	EMIT=5FMASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DF844DU),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fddr=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006004, 0x0007FFFFU, 0x0000103FU),
+	EMIT=5FMASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
+	EMIT=5FMASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
+	EMIT=5FMASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
+	EMIT=5FMASKWRITE(0XF8006014, 0x001FFFFFU, 0x00042E1AU),
+	EMIT=5FMASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D154D4U),
+	EMIT=5FMASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
+	EMIT=5FMASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
+	EMIT=5FMASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
+	EMIT=5FMASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
+	EMIT=5FMASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
+	EMIT=5FMASKWRITE(0XF8006034, 0x13FF3FFFU, 0x00011674U),
+	EMIT=5FMASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
+	EMIT=5FMASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
+	EMIT=5FMASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0F666666U),
+	EMIT=5FMASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
+	EMIT=5FMASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
+	EMIT=5FMASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
+	EMIT=5FMASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
+	EMIT=5FMASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
+	EMIT=5FMASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
+	EMIT=5FMASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
+	EMIT=5FMASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
+	EMIT=5FMASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
+	EMIT=5FMASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0670C845U),
+	EMIT=5FMASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
+	EMIT=5FMASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
+	EMIT=5FMASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
+	EMIT=5FMASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
+	EMIT=5FMASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
+	EMIT=5FMASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
+	EMIT=5FMASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C000U),
+	EMIT=5FMASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
+	EMIT=5FMASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
+	EMIT=5FMASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
+	EMIT=5FMASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
+	EMIT=5FMASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
+	EMIT=5FMASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
+	EMIT=5FMASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C5U),
+	EMIT=5FMASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
+	EMIT=5FMASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
+	EMIT=5FMASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
+	EMIT=5FMASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
+	EMIT=5FMASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
+	EMIT=5FMASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
+	EMIT=5FMASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
+	EMIT=5FMASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
+	EMIT=5FMASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
+	EMIT=5FMASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A6U),
+	EMIT=5FMASKPOLL(0XF8000B74, 0x00002000U),
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
+	EMIT=5FMASKPOLL(0XF8006054, 0x00000007U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fmio=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
+	EMIT=5FMASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
+	EMIT=5FMASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000321U),
+	EMIT=5FMASKWRITE(0XF80007BC, 0x00003FFFU, 0x00001220U),
+	EMIT=5FMASKWRITE(0XF80007C0, 0x00003FFFU, 0x00001220U),
+	EMIT=5FMASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000321U),
+	EMIT=5FMASKWRITE(0XF80007C8, 0x00003FFFU, 0x000013E1U),
+	EMIT=5FMASKWRITE(0XF80007CC, 0x00003FFFU, 0x000003E0U),
+	EMIT=5FMASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FMASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
+	EMIT=5FMASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fpost=5Fconfig=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
+	EMIT=5FMASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+int ps7=5Fpost=5Fconfig(void)
+{
+	return ps7=5Fconfig(ps7=5Fpost=5Fconfig=5F3=5F0);
+}
+
+int ps7=5Finit(void)
+{
+	int ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fmio=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fpll=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fclock=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fddr=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	return PS7=5FINIT=5FSUCCESS;
+}
diff --git a/board/BuR/zynq/brcp1=5F1r/board.c b/board/BuR/zynq/brcp1=5F1r/=
board.c
new file mode 100644
index 00000000000..456d4900680
--- /dev/null
+++ b/board/BuR/zynq/brcp1=5F1r/board.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ */
diff --git a/board/BuR/zynq/brcp1=5F1r/ps7=5Finit=5Fgpl.c b/board/BuR/zynq/=
brcp1=5F1r/ps7=5Finit=5Fgpl.c
new file mode 100644
index 00000000000..be39db9caaa
--- /dev/null
+++ b/board/BuR/zynq/brcp1=5F1r/ps7=5Finit=5Fgpl.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/ps7=5Finit=5Fgpl.h>
+
+unsigned long ps7=5Fpll=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA240U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x0007F000U, 0x0003C000U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000300U),
+	EMIT=5FMASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000002U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
+	EMIT=5FMASKWRITE(0XF8000118, 0x003FFFF0U, 0x000FA240U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x0007F000U, 0x0003C000U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000004U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fclock=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
+	EMIT=5FMASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000140, 0x03F03F71U, 0x00101001U),
+	EMIT=5FMASKWRITE(0XF800014C, 0x00003F31U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000150, 0x00003F33U, 0x00001401U),
+	EMIT=5FMASKWRITE(0XF8000154, 0x00003F33U, 0x00001401U),
+	EMIT=5FMASKWRITE(0XF8000158, 0x00003F33U, 0x00000A02U),
+	EMIT=5FMASKWRITE(0XF800015C, 0x03F03F33U, 0x00A01901U),
+	EMIT=5FMASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000168, 0x00003F31U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000170, 0x03F03F30U, 0x00500800U),
+	EMIT=5FMASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DD844DU),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fddr=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000084U),
+	EMIT=5FMASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
+	EMIT=5FMASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
+	EMIT=5FMASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
+	EMIT=5FMASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
+	EMIT=5FMASKWRITE(0XF8006014, 0x001FFFFFU, 0x00040EDAU),
+	EMIT=5FMASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
+	EMIT=5FMASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
+	EMIT=5FMASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
+	EMIT=5FMASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
+	EMIT=5FMASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
+	EMIT=5FMASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
+	EMIT=5FMASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
+	EMIT=5FMASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000666U),
+	EMIT=5FMASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFFF0000U),
+	EMIT=5FMASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0FFF5555U),
+	EMIT=5FMASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
+	EMIT=5FMASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
+	EMIT=5FMASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
+	EMIT=5FMASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
+	EMIT=5FMASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
+	EMIT=5FMASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
+	EMIT=5FMASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
+	EMIT=5FMASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
+	EMIT=5FMASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
+	EMIT=5FMASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
+	EMIT=5FMASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
+	EMIT=5FMASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
+	EMIT=5FMASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
+	EMIT=5FMASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
+	EMIT=5FMASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
+	EMIT=5FMASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000000U),
+	EMIT=5FMASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000000U),
+	EMIT=5FMASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
+	EMIT=5FMASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
+	EMIT=5FMASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
+	EMIT=5FMASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
+	EMIT=5FMASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
+	EMIT=5FMASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
+	EMIT=5FMASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
+	EMIT=5FMASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
+	EMIT=5FMASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
+	EMIT=5FMASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
+	EMIT=5FMASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
+	EMIT=5FMASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
+	EMIT=5FMASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
+	EMIT=5FMASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
+	EMIT=5FMASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
+	EMIT=5FMASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
+	EMIT=5FMASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
+	EMIT=5FMASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
+	EMIT=5FMASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
+	EMIT=5FMASKPOLL(0XF8000B74, 0x00002000U),
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000085U),
+	EMIT=5FMASKPOLL(0XF8006054, 0x00000007U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fmio=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000800U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000800U),
+	EMIT=5FMASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
+	EMIT=5FMASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000220U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
+	EMIT=5FMASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000360U),
+	EMIT=5FMASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007C8, 0x00003FFFU, 0x000012E1U),
+	EMIT=5FMASKWRITE(0XF80007CC, 0x00003FFFU, 0x000002E0U),
+	EMIT=5FMASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000180U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000180U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FMASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
+	EMIT=5FMASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fpost=5Fconfig=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
+	EMIT=5FMASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+int ps7=5Fpost=5Fconfig(void)
+{
+	return ps7=5Fconfig(ps7=5Fpost=5Fconfig=5F3=5F0);
+}
+
+int ps7=5Finit(void)
+{
+	int ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fmio=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fpll=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fclock=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fddr=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	return PS7=5FINIT=5FSUCCESS;
+}
diff --git a/board/BuR/zynq/brcp1=5F1r=5Fswitch/board.c b/board/BuR/zynq/br=
cp1=5F1r=5Fswitch/board.c
new file mode 100644
index 00000000000..456d4900680
--- /dev/null
+++ b/board/BuR/zynq/brcp1=5F1r=5Fswitch/board.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ */
diff --git a/board/BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c b/board/=
BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c
new file mode 100644
index 00000000000..e4fc708a45c
--- /dev/null
+++ b/board/BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/ps7=5Finit=5Fgpl.h>
+
+unsigned long ps7=5Fpll=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA220U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x0007F000U, 0x00028000U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
+	EMIT=5FMASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000002U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
+	EMIT=5FMASKWRITE(0XF8000118, 0x003FFFF0U, 0x001452C0U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x0007F000U, 0x0001E000U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000004U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fclock=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
+	EMIT=5FMASKWRITE(0XF8000138, 0x00000011U, 0x00000011U),
+	EMIT=5FMASKWRITE(0XF800013C, 0x00000011U, 0x00000011U),
+	EMIT=5FMASKWRITE(0XF8000140, 0x03F03F71U, 0x00500141U),
+	EMIT=5FMASKWRITE(0XF8000144, 0x03F03F71U, 0x00500141U),
+	EMIT=5FMASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000158, 0x00003F33U, 0x00000502U),
+	EMIT=5FMASKWRITE(0XF800015C, 0x03F03F33U, 0x00501901U),
+	EMIT=5FMASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000170, 0x03F03F30U, 0x00400500U),
+	EMIT=5FMASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DD84CDU),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fddr=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000084U),
+	EMIT=5FMASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
+	EMIT=5FMASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
+	EMIT=5FMASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
+	EMIT=5FMASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
+	EMIT=5FMASKWRITE(0XF8006014, 0x001FFFFFU, 0x00040EDAU),
+	EMIT=5FMASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
+	EMIT=5FMASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
+	EMIT=5FMASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
+	EMIT=5FMASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
+	EMIT=5FMASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
+	EMIT=5FMASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
+	EMIT=5FMASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
+	EMIT=5FMASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000666U),
+	EMIT=5FMASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFFF0000U),
+	EMIT=5FMASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0FFF5555U),
+	EMIT=5FMASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
+	EMIT=5FMASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
+	EMIT=5FMASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
+	EMIT=5FMASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
+	EMIT=5FMASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
+	EMIT=5FMASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
+	EMIT=5FMASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
+	EMIT=5FMASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
+	EMIT=5FMASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
+	EMIT=5FMASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
+	EMIT=5FMASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
+	EMIT=5FMASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
+	EMIT=5FMASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
+	EMIT=5FMASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
+	EMIT=5FMASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
+	EMIT=5FMASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000000U),
+	EMIT=5FMASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000000U),
+	EMIT=5FMASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
+	EMIT=5FMASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
+	EMIT=5FMASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
+	EMIT=5FMASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
+	EMIT=5FMASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
+	EMIT=5FMASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
+	EMIT=5FMASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
+	EMIT=5FMASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
+	EMIT=5FMASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
+	EMIT=5FMASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
+	EMIT=5FMASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
+	EMIT=5FMASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
+	EMIT=5FMASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
+	EMIT=5FMASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
+	EMIT=5FMASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
+	EMIT=5FMASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
+	EMIT=5FMASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
+	EMIT=5FMASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
+	EMIT=5FMASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
+	EMIT=5FMASKPOLL(0XF8000B74, 0x00002000U),
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000085U),
+	EMIT=5FMASKPOLL(0XF8006054, 0x00000007U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fmio=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000800U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000800U),
+	EMIT=5FMASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
+	EMIT=5FMASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000220U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
+	EMIT=5FMASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF8000740, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000744, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000748, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF800074C, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000750, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000754, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000758, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF800075C, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000760, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000764, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000768, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF800076C, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000360U),
+	EMIT=5FMASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007C8, 0x00003FFFU, 0x000012E1U),
+	EMIT=5FMASKWRITE(0XF80007CC, 0x00003FFFU, 0x000002E0U),
+	EMIT=5FMASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000300U),
+	EMIT=5FMASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000180U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000180U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FMASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
+	EMIT=5FMASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fpost=5Fconfig=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
+	EMIT=5FMASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+int ps7=5Fpost=5Fconfig(void)
+{
+	return ps7=5Fconfig(ps7=5Fpost=5Fconfig=5F3=5F0);
+}
+
+int ps7=5Finit(void)
+{
+	int ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fmio=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fpll=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fclock=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fddr=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	return PS7=5FINIT=5FSUCCESS;
+}
diff --git a/board/BuR/zynq/brcp1=5F2r/board.c b/board/BuR/zynq/brcp1=5F2r/=
board.c
new file mode 100644
index 00000000000..456d4900680
--- /dev/null
+++ b/board/BuR/zynq/brcp1=5F2r/board.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ */
diff --git a/board/BuR/zynq/brcp1=5F2r/ps7=5Finit=5Fgpl.c b/board/BuR/zynq/=
brcp1=5F2r/ps7=5Finit=5Fgpl.c
new file mode 100644
index 00000000000..4ebed8bf90f
--- /dev/null
+++ b/board/BuR/zynq/brcp1=5F2r/ps7=5Finit=5Fgpl.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/ps7=5Finit=5Fgpl.h>
+
+unsigned long ps7=5Fpll=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA3C0U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x0007F000U, 0x0002E000U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
+	EMIT=5FMASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000002U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
+	EMIT=5FMASKWRITE(0XF8000118, 0x003FFFF0U, 0x001452C0U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x0007F000U, 0x0001E000U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000004U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fclock=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
+	EMIT=5FMASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000140, 0x03F03F71U, 0x00100801U),
+	EMIT=5FMASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000158, 0x00003F33U, 0x00000502U),
+	EMIT=5FMASKWRITE(0XF800015C, 0x03F03F33U, 0x00501901U),
+	EMIT=5FMASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000170, 0x03F03F30U, 0x00101400U),
+	EMIT=5FMASKWRITE(0XF8000180, 0x03F03F30U, 0x00101400U),
+	EMIT=5FMASKWRITE(0XF8000190, 0x03F03F30U, 0x00101400U),
+	EMIT=5FMASKWRITE(0XF80001A0, 0x03F03F30U, 0x00101400U),
+	EMIT=5FMASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DD844DU),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fddr=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
+	EMIT=5FMASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
+	EMIT=5FMASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
+	EMIT=5FMASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
+	EMIT=5FMASKWRITE(0XF8006014, 0x001FFFFFU, 0x0004281AU),
+	EMIT=5FMASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
+	EMIT=5FMASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
+	EMIT=5FMASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
+	EMIT=5FMASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
+	EMIT=5FMASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
+	EMIT=5FMASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
+	EMIT=5FMASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
+	EMIT=5FMASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
+	EMIT=5FMASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
+	EMIT=5FMASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0F666666U),
+	EMIT=5FMASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
+	EMIT=5FMASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
+	EMIT=5FMASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
+	EMIT=5FMASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
+	EMIT=5FMASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
+	EMIT=5FMASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
+	EMIT=5FMASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
+	EMIT=5FMASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
+	EMIT=5FMASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
+	EMIT=5FMASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
+	EMIT=5FMASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
+	EMIT=5FMASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
+	EMIT=5FMASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
+	EMIT=5FMASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
+	EMIT=5FMASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
+	EMIT=5FMASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
+	EMIT=5FMASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
+	EMIT=5FMASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
+	EMIT=5FMASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
+	EMIT=5FMASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
+	EMIT=5FMASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
+	EMIT=5FMASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
+	EMIT=5FMASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
+	EMIT=5FMASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
+	EMIT=5FMASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
+	EMIT=5FMASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
+	EMIT=5FMASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
+	EMIT=5FMASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
+	EMIT=5FMASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
+	EMIT=5FMASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
+	EMIT=5FMASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
+	EMIT=5FMASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
+	EMIT=5FMASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
+	EMIT=5FMASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
+	EMIT=5FMASKPOLL(0XF8000B74, 0x00002000U),
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
+	EMIT=5FMASKPOLL(0XF8006054, 0x00000007U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fmio=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
+	EMIT=5FMASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
+	EMIT=5FMASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
+	EMIT=5FMASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000360U),
+	EMIT=5FMASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000361U),
+	EMIT=5FMASKWRITE(0XF80007C8, 0x00003FFFU, 0x000012E1U),
+	EMIT=5FMASKWRITE(0XF80007CC, 0x00003FFFU, 0x000002E0U),
+	EMIT=5FMASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FMASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
+	EMIT=5FMASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fpost=5Fconfig=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
+	EMIT=5FMASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+int ps7=5Fpost=5Fconfig(void)
+{
+	return ps7=5Fconfig(ps7=5Fpost=5Fconfig=5F3=5F0);
+}
+
+int ps7=5Finit(void)
+{
+	int ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fmio=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fpll=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fclock=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fddr=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	return PS7=5FINIT=5FSUCCESS;
+}
diff --git a/board/BuR/zynq/brsmarc2/board.c b/board/BuR/zynq/brsmarc2/boar=
d.c
new file mode 100644
index 00000000000..7d9e13a5eec
--- /dev/null
+++ b/board/BuR/zynq/brsmarc2/board.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ */
+#include <linux/types.h>
+#include <i2c.h>
+#include <init.h>
+#include "../../common/br=5Fresetc.h"
+#include "../../common/bur=5Fcommon.h"
+
+int board=5Fboot=5Fkey(void)
+{
+	unsigned char u8buf =3D 0;
+	int rc;
+
+	rc =3D br=5Fresetc=5Fregget(RSTCTRL=5FENHSTATUS, &u8buf);
+	if (rc =3D=3D 0)
+		return (u8buf & 0x1);
+
+	return 0;
+}
+
+#if defined(CONFIG=5FSPL=5FBUILD)
+int br=5Fboard=5Flate=5Finit(void)
+{
+	brdefaultip=5Fsetup(0, 0x57);
+
+	return 0;
+}
+#endif
diff --git a/board/BuR/zynq/brsmarc2/ps7=5Finit=5Fgpl.c b/board/BuR/zynq/br=
smarc2/ps7=5Finit=5Fgpl.c
new file mode 100644
index 00000000000..51ff8bfb70f
--- /dev/null
+++ b/board/BuR/zynq/brsmarc2/ps7=5Finit=5Fgpl.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/ps7=5Finit=5Fgpl.h>
+
+unsigned long ps7=5Fpll=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA220U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x0007F000U, 0x00028000U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
+	EMIT=5FMASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000002U),
+	EMIT=5FMASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
+	EMIT=5FMASKWRITE(0XF8000118, 0x003FFFF0U, 0x001452C0U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x0007F000U, 0x0001E000U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKPOLL(0XF800010C, 0x00000004U),
+	EMIT=5FMASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fclock=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
+	EMIT=5FMASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800013C, 0x00000011U, 0x00000011U),
+	EMIT=5FMASKWRITE(0XF8000140, 0x03F03F71U, 0x00500801U),
+	EMIT=5FMASKWRITE(0XF8000144, 0x03F03F71U, 0x00500141U),
+	EMIT=5FMASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
+	EMIT=5FMASKWRITE(0XF8000158, 0x00003F33U, 0x00000503U),
+	EMIT=5FMASKWRITE(0XF800015C, 0x03F03F33U, 0x00501903U),
+	EMIT=5FMASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
+	EMIT=5FMASKWRITE(0XF8000170, 0x03F03F30U, 0x00400500U),
+	EMIT=5FMASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DFC4CDU),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fddr=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
+	EMIT=5FMASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
+	EMIT=5FMASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
+	EMIT=5FMASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
+	EMIT=5FMASKWRITE(0XF8006014, 0x001FFFFFU, 0x00040EDAU),
+	EMIT=5FMASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
+	EMIT=5FMASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
+	EMIT=5FMASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
+	EMIT=5FMASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
+	EMIT=5FMASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
+	EMIT=5FMASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
+	EMIT=5FMASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
+	EMIT=5FMASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
+	EMIT=5FMASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
+	EMIT=5FMASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0FFF6666U),
+	EMIT=5FMASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
+	EMIT=5FMASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
+	EMIT=5FMASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
+	EMIT=5FMASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
+	EMIT=5FMASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
+	EMIT=5FMASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
+	EMIT=5FMASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
+	EMIT=5FMASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
+	EMIT=5FMASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
+	EMIT=5FMASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
+	EMIT=5FMASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
+	EMIT=5FMASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
+	EMIT=5FMASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
+	EMIT=5FMASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
+	EMIT=5FMASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
+	EMIT=5FMASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
+	EMIT=5FMASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
+	EMIT=5FMASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
+	EMIT=5FMASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
+	EMIT=5FMASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
+	EMIT=5FMASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
+	EMIT=5FMASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
+	EMIT=5FMASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
+	EMIT=5FMASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
+	EMIT=5FMASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
+	EMIT=5FMASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
+	EMIT=5FMASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
+	EMIT=5FMASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
+	EMIT=5FMASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
+	EMIT=5FMASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
+	EMIT=5FMASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
+	EMIT=5FMASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
+	EMIT=5FMASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
+	EMIT=5FMASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
+	EMIT=5FMASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
+	EMIT=5FMASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
+	EMIT=5FMASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
+	EMIT=5FMASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FMASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
+	EMIT=5FMASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
+	EMIT=5FMASKPOLL(0XF8000B74, 0x00002000U),
+	EMIT=5FMASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
+	EMIT=5FMASKPOLL(0XF8006054, 0x00000007U),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fmio=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
+	EMIT=5FMASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
+	EMIT=5FMASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
+	EMIT=5FMASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
+	EMIT=5FMASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
+	EMIT=5FMASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
+	EMIT=5FMASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
+	EMIT=5FMASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
+	EMIT=5FMASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
+	EMIT=5FMASKWRITE(0XF8000738, 0x00003FFFU, 0x000016E1U),
+	EMIT=5FMASKWRITE(0XF800073C, 0x00003FFFU, 0x000006E0U),
+	EMIT=5FMASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
+	EMIT=5FMASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
+	EMIT=5FMASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
+	EMIT=5FMASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
+	EMIT=5FMASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
+	EMIT=5FMASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000321U),
+	EMIT=5FMASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000320U),
+	EMIT=5FMASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000320U),
+	EMIT=5FMASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000321U),
+	EMIT=5FMASKWRITE(0XF80007C8, 0x00003FFFU, 0x00000340U),
+	EMIT=5FMASKWRITE(0XF80007CC, 0x00003FFFU, 0x00000340U),
+	EMIT=5FMASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000280U),
+	EMIT=5FMASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000280U),
+	EMIT=5FMASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
+	EMIT=5FMASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FMASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
+	EMIT=5FMASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
+	EMIT=5FMASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
+	EMIT=5FMASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
+	EMIT=5FMASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
+	EMIT=5FMASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FMASKDELAY(0XF8F00200, 1),
+	EMIT=5FEXIT(),
+};
+
+unsigned long ps7=5Fpost=5Fconfig=5F3=5F0[] =3D {
+	EMIT=5FWRITE(0XF8000008, 0x0000DF0DU),
+	EMIT=5FMASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
+	EMIT=5FMASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
+	EMIT=5FWRITE(0XF8000004, 0x0000767BU),
+	EMIT=5FEXIT(),
+};
+
+int ps7=5Fpost=5Fconfig(void)
+{
+	return ps7=5Fconfig(ps7=5Fpost=5Fconfig=5F3=5F0);
+}
+
+int ps7=5Finit(void)
+{
+	int ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fmio=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fpll=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fclock=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fddr=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	ret =3D ps7=5Fconfig(ps7=5Fperipherals=5Finit=5Fdata=5F3=5F0);
+	if (ret !=3D PS7=5FINIT=5FSUCCESS)
+		return ret;
+
+	return PS7=5FINIT=5FSUCCESS;
+}
diff --git a/board/BuR/zynq/common/board.c b/board/BuR/zynq/common/board.c
new file mode 100644
index 00000000000..35e8ed81181
--- /dev/null
+++ b/board/BuR/zynq/common/board.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board functions for B&R brcp150, brcp170, brcp1, brsmarc2 Board
+ *
+ * B&R Industrial Automation GmbH - http://www.br-automation.com
+ *
+ */
+
+#include <fdtdec.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/arch/sys=5Fproto.h>
+#include <asm/gpio.h>
+#include <init.h>
+#include <i2c.h>
+#include <dm/uclass.h>
+#include <command.h>
+#include <binman.h>
+#include "../../common/br=5Fresetc.h"
+#include "../../common/bur=5Fcommon.h"
+
+#include <fdt=5Fsupport.h>
+#include <spi=5Fflash.h>
+#include <fpga.h>
+#include <zynqpl.h>
+
+#define RSTCTRL=5FCTRLSPEC=5FnPCIRST		0x1
+
+=5F=5Fweak int br=5Fboard=5Flate=5Finit(void)
+{
+	return 0;
+}
+
+#if defined(CONFIG=5FSPL=5FBUILD) && CONFIG=5FIS=5FENABLED(FPGA)
+const char *fpga=5Fpaths[2] =3D { "/binman/blob-ext@4",
+			      "/binman/blob-ext@1"};
+
+static int start=5Ffpga(unsigned int bank)
+{
+	struct spi=5Fflash *flash=5Fdev;
+	ofnode fpga=5Fnode;
+	void *buf;
+
+	u32 flash=5Foffset, flash=5Fsize;
+	int rc;
+
+	fpga=5Fnode =3D ofnode=5Fpath(fpga=5Fpaths[bank]);
+
+	if (!ofnode=5Fvalid(fpga=5Fnode)) {
+		printf("WARN:  binman node not found %s\n", fpga=5Fpaths[bank]);
+		return -ENOENT;
+	}
+
+	flash=5Foffset =3D ofnode=5Fread=5Fu32=5Fdefault(fpga=5Fnode, "offset", ~=
0UL);
+	flash=5Fsize =3D ofnode=5Fread=5Fu32=5Fdefault(fpga=5Fnode, "size", ~0UL);
+
+	if (flash=5Foffset =3D=3D ~0UL || flash=5Fsize =3D=3D ~0UL) {
+		printf("WARN:  invalid fpga 'offset, size' in fdt (0x%x, 0x%x)",
+		       flash=5Foffset, flash=5Fsize);
+		return -EINVAL;
+	}
+
+	printf("loading bitstream from bank #%d (0x%08x / 0x%08x)\n", bank,
+	       flash=5Foffset, flash=5Fsize);
+
+	flash=5Fdev =3D spi=5Fflash=5Fprobe(CONFIG=5FENV=5FSPI=5FBUS, CONFIG=5FEN=
V=5FSPI=5FCS,
+				    CONFIG=5FSF=5FDEFAULT=5FSPEED, CONFIG=5FSF=5FDEFAULT=5FMODE);
+
+	if (rc)  {
+		printf("WARN:  cannot probe SPI-flash for bitstream!\n");
+		return -ENODEV;
+	}
+
+	buf =3D kmalloc(flash=5Fsize, 0);
+	if (!buf) {
+		spi=5Fflash=5Ffree(flash=5Fdev);
+		return -ENOMEM;
+	}
+
+	debug("using buf @ %p, flashbase: 0x%08x, len: 0x%08x\n",
+	      buf, flash=5Foffset, flash=5Fsize);
+
+	rc =3D spi=5Fflash=5Fread(flash=5Fdev, flash=5Foffset, flash=5Fsize, buf);
+
+	spi=5Fflash=5Ffree(flash=5Fdev);
+
+	if (rc) {
+		printf("WARN:  cannot read bitstream from spi-flash!\n");
+		kfree(buf);
+
+		return -EIO;
+	}
+
+	rc =3D fpga=5Floadbitstream(0, buf, flash=5Fsize, BIT=5FFULL);
+	if (rc) {
+		printf("WARN:  FPGA configuration from bank #%d failed!\n", bank);
+		kfree(buf);
+
+		return -EIO;
+	}
+
+	kfree(buf);
+
+	return 0;
+}
+#endif
+
+#if defined(CONFIG=5FSPL=5FBUILD)
+const char *boot=5Fgpios[] =3D { "br,rs232-en",
+			     "br,board-reset",
+			     NULL};
+
+/* spl stage */
+int board=5Finit(void)
+{
+	struct gpio=5Fdesc gpio;
+	int node;
+	int rc;
+
+	/* peripheral RESET on PSOC reset-controller */
+	rc =3D br=5Fresetc=5Fregset(RSTCTRL=5FSPECGPIO=5FO, RSTCTRL=5FCTRLSPEC=5F=
nPCIRST);
+	if (rc !=3D 0)
+		printf("ERROR: cannot write to resetc (nPCIRST)!\n");
+
+	for (int i =3D 0; boot=5Fgpios[i]; i++) {
+		node =3D fdt=5Fnode=5Foffset=5Fby=5Fcompatible(gd->fdt=5Fblob, 0, boot=
=5Fgpios[i]);
+
+		if (node < 0) {
+			printf("INFO:  %s not found!\n", boot=5Fgpios[i]);
+		} else {
+			rc =3D gpio=5Frequest=5Fby=5Fname=5Fnodev(offset=5Fto=5Fofnode(node), "=
pin",
+							0, &gpio, GPIOD=5FIS=5FOUT);
+
+			if (!rc)
+				dm=5Fgpio=5Fset=5Fvalue(&gpio, 1);
+			else
+				printf("ERROR: failed to setup %s!\n", boot=5Fgpios[i]);
+		}
+	}
+
+#if CONFIG=5FIS=5FENABLED(FPGA)
+	unsigned int bmode;
+	unsigned int bank;
+
+	rc =3D br=5Fresetc=5Fbmode=5Fget(&bmode);
+	if (rc) {
+		printf("WARN:  can't get Boot Mode!\n");
+		return -ENODEV;
+	}
+
+	/* use golden FPGA image in case of special boot flow (PME, BootAR, USB, =
Net ...) */
+	bank =3D ((bmode =3D=3D 0) || (bmode =3D=3D 12)) ? 1 : 0;
+
+	/* bring up FPGA */
+	if (start=5Ffpga(bank) !=3D 0) {
+		printf("WARN:  cannot start fpga from bank %d, trying bank %d!\n", bank,=
 bank ^ 1);
+		bank ^=3D 1;
+		start=5Ffpga(bank);
+	}
+#endif
+	return 0;
+}
+#else
+int board=5Finit(void)
+{
+	return 0;
+}
+
+/*
+ * PMIC buckboost regulator workaround:
+ * The DA9062 PMIC can switch its buckboost regulator output
+ * between PFM and PWM mode for eco-purpose.
+ * In very rare situations this transition leads into a non-
+ * functional buckboost regulator with zero output.
+ * With this workaround we prevent this with turning this
+ * feature off by forcing PWM-mode if auto-mode is selected.
+ */
+static void pmic=5Ffixup(int addr)
+{
+	u8 regs[] =3D { 0x9E, 0x9D, 0xA0, 0x9F };
+	struct udevice *i2cdev =3D NULL;
+	unsigned int i;
+	u8 val;
+	int rc;
+
+	i2c=5Fget=5Fchip=5Ffor=5Fbusnum(0, addr, 1, &i2cdev);
+	if (!i2cdev)
+		return;
+
+	printf("PMIC:  fixup buckboost at i2c device 0x%x\n", addr);
+
+	for (i =3D 0; i < sizeof(regs); i++) {
+		rc =3D dm=5Fi2c=5Fread(i2cdev, regs[i], &val, 1);
+		if (rc =3D=3D 0 && val =3D=3D 0xC0) {
+			val =3D 0x80;
+			dm=5Fi2c=5Fwrite(i2cdev, regs[i], &val, 1);
+		}
+	}
+}
+
+int board=5Flate=5Finit(void)
+{
+	ofnode node;
+	u32 addr;
+
+	br=5Fresetc=5Fbmode();
+	br=5Fboard=5Flate=5Finit();
+
+	node =3D ofnode=5Fby=5Fcompatible(ofnode=5Fnull(), "dlg,da9062");
+
+	if (!ofnode=5Fvalid(node))
+		return 0;
+
+	if (!ofnode=5Fread=5Fu32(node, "reg", &addr))
+		pmic=5Ffixup(addr);
+	else
+		printf("WARN:  cannot read PMIC address!");
+
+	return 0;
+}
+#endif
+
+int dram=5Finit(void)
+{
+	if (fdtdec=5Fsetup=5Fmem=5Fsize=5Fbase() !=3D 0)
+		return -EINVAL;
+
+	zynq=5Fddrc=5Finit();
+
+	return 0;
+}
diff --git a/board/BuR/zynq/env/brcp1.env b/board/BuR/zynq/env/brcp1.env
new file mode 100644
index 00000000000..269e5193046
--- /dev/null
+++ b/board/BuR/zynq/env/brcp1.env
@@ -0,0 +1,109 @@
+autoload=3D0
+b=5Fbreak=3D0
+fpgastatus=3Ddisabled
+/* Memory variable */
+scradr=3D0xC0000
+fdtbackaddr=3D0x4000000
+loadaddr=3DCONFIG=5FSYS=5FLOAD=5FADDR
+
+/* PREBOOT */
+preboot=3Drun setupaddr=5Fspi; run brdefaultip; run cfgscr; setenv bootsta=
rt 1
+
+/* SPI layout variables */
+cfg=5Faddr=3D
+	fdt get value cfgaddr=5Fspi /binman/blob-ext@0 offset &&
+	fdt get value cfgsize=5Fspi /binman/blob-ext@0 size
+
+fpga=5Faddr=3D
+	fdt get value fpgaaddr=5Fspi /binman/blob-ext@1 offset &&
+	fdt get value fpgasize=5Fspi /binman/blob-ext@1 size
+
+os=5Faddr=3D
+	fdt get value osaddr=5Fspi /binman/blob-ext@2 offset &&
+	fdt get value ossize=5Fspi /binman/blob-ext@2 size
+
+dtb=5Faddr=3D
+	fdt get value dtbaddr=5Fspi /binman/blob-ext@3 offset &&
+	fdt get value dtbsize=5Fspi /binman/blob-ext@3 size
+
+setupaddr=5Fspi=3D
+	fdt addr ${fdtcontroladdr};
+	run dtb=5Faddr; run os=5Faddr;
+	run fpga=5Faddr; run cfg=5Faddr
+
+/* IP setup */
+brdefaultip=3D
+	if test -r ${ipaddr}; then;
+	else
+		setenv ipaddr 192.168.60.1; setenv serverip 192.168.60.254;
+		setenv gatewayip 192.168.60.254; setenv netmask 255.255.255.0;
+	fi
+
+/* Boot orders */
+b=5Ftgts=5Fstd=3Dmmc0 mmc1 spi usb0 usb1 net
+b=5Ftgts=5Frcy=3Dspi usb0 usb1 net
+b=5Ftgts=5Fpme=3Dnet usb0 usb1 mmc spi
+
+/* Boot targets */
+b=5Fmmc0=3D
+	run fpga; mmc dev 0; load mmc 0 ${loadaddr} arimg.itb &&
+	run vxargs && bootm ${loadaddr}
+
+b=5Fmmc1=3D
+	run fpga; mmc dev 0; load mmc 0 ${loadaddr} arimg &&
+	run vxargs &&
+	sf read ${fdtbackaddr} ${dtbaddr=5Fspi} ${dtbsize=5Fspi} &&
+	fdt addr ${fdtbackaddr} &&
+	bootm ${loadaddr} - ${fdtbackaddr}
+
+b=5Fspi=3D
+	run fpga; sf read ${loadaddr} ${osaddr=5Fspi} ${ossize=5Fspi} &&
+	run vxargs && bootm ${loadaddr}
+
+b=5Fnet=3Drun fpga; tftp ${scradr} netscript.img && source ${scradr}
+b=5Fusb0=3Dusb start && load usb 0 ${scradr} usbscript.img && source ${scr=
adr}
+b=5Fusb1=3Dusb start && load usb 0 ${scradr} bootscr.img && source ${scrad=
r}
+
+/* FPGA setup */
+fpga=3D
+	setenv fpgastatus disabled;
+	sf read ${loadaddr} ${fpgaaddr=5Fspi} ${fpgasize=5Fspi} &&
+	fpga loadb 0 ${loadaddr} ${fpgasize=5Fspi} &&
+	setenv fpgastatus okay
+
+/* Configuration preboot*/
+cfgscr=3D
+	sf probe &&
+	sf read ${scradr} ${cfgaddr=5Fspi} ${cfgsize=5Fspi} &&
+	source ${scradr}
+
+/* OS Boot */
+fdt=5Ffixup=3D
+	run cfgscr; run vxfdt
+
+vxargs=3D
+	setenv bootargs gem(0,0)host:vxWorks h=3D${serverip}
+	e=3D${ipaddr}:${netmask} g=3D${gatewayip} u=3DvxWorksFTP pw=3DvxWorks f=
=3D0x1
+
+vxfdt=3D
+	fdt set /fpga/pci status ${fpgastatus};
+	fdt set /fpga status ${fpgastatus}
+
+/* Boot code */
+b=5Fdefault=3D
+	run b=5Fdeftgts;
+	for target in ${b=5Ftgts}; do
+		run b=5F${target};
+		if test ${b=5Fbreak} =3D 1; then;
+			exit;
+		fi;
+	done
+
+b=5Fdeftgts=3D
+	if test ${b=5Fmode} =3D 12; then
+		setenv b=5Ftgts ${b=5Ftgts=5Fpme};
+	elif test ${b=5Fmode} =3D 0; then
+		setenv b=5Ftgts ${b=5Ftgts=5Frcy};
+	else
+		setenv b=5Ftgts ${b=5Ftgts=5Fstd};
+	fi
diff --git a/board/BuR/zynq/env/brcp150.env b/board/BuR/zynq/env/brcp150.env
new file mode 100644
index 00000000000..9c27f0fa325
--- /dev/null
+++ b/board/BuR/zynq/env/brcp150.env
@@ -0,0 +1,119 @@
+autoload=3D0
+b=5Fbreak=3D0
+fpgastatus=3Ddisabled
+/* Memory variable */
+scradr=3D0xC0000
+fdtbackaddr=3D0x4000000
+loadaddr=3DCONFIG=5FSYS=5FLOAD=5FADDR
+
+/* PREBOOT */
+preboot=3Drun setupaddr=5Fspi; run brdefaultip; run cfgscr; setenv bootsta=
rt 1
+
+/* SPI layout variables */
+cfg=5Faddr=3D
+	fdt get value cfgaddr=5Fspi /binman/blob-ext@0 offset &&
+	fdt get value cfgsize=5Fspi /binman/blob-ext@0 size
+
+fpga=5Faddr=3D
+	fdt get value fpgaaddr=5Fspi /binman/blob-ext@1 offset &&
+	fdt get value fpgasize=5Fspi /binman/blob-ext@1 size
+
+os=5Faddr=3D
+	fdt get value osaddr=5Fspi /binman/blob-ext@2 offset &&
+	fdt get value ossize=5Fspi /binman/blob-ext@2 size
+
+dtb=5Faddr=3D
+	fdt get value dtbaddr=5Fspi /binman/blob-ext@3 offset &&
+	fdt get value dtbsize=5Fspi /binman/blob-ext@3 size
+
+opt=5Faddr=3D
+	fdt get value optaddr=5Fspi /binman/blob-ext@5 offset &&
+	fdt get value optsize=5Fspi /binman/blob-ext@5 size
+
+setupaddr=5Fspi=3D
+	fdt addr ${fdtcontroladdr};
+	run dtb=5Faddr; run os=5Faddr;
+	run fpga=5Faddr; run cfg=5Faddr;
+	run opt=5Faddr
+
+/* IP setup */
+brdefaultip=3D
+	if test -r ${ipaddr}; then;
+	else
+		setenv ipaddr 192.168.60.1; setenv serverip 192.168.60.254;
+		setenv gatewayip 192.168.60.254; setenv netmask 255.255.255.0;
+	fi
+
+/* Boot orders */
+b=5Ftgts=5Fstd=3Dmmc0 mmc1 fpga spi usb0 usb1 net
+b=5Ftgts=5Frcy=3Dspi usb0 usb1 net
+b=5Ftgts=5Fpme=3Dnet usb0 usb1 mmc spi
+
+/* Boot targets */
+b=5Fmmc0=3D
+	mmc dev 0; load mmc 0 ${loadaddr} arimg.itb &&
+	run vxargs && bootm ${loadaddr}
+
+b=5Fmmc1=3D
+	mmc dev 0; load mmc 0 ${loadaddr} arimg &&
+	run vxargs &&
+	sf read ${fdtbackaddr} ${dtbaddr=5Fspi} ${dtbsize=5Fspi} &&
+	fdt addr ${fdtbackaddr} &&
+	bootm ${loadaddr} - ${fdtbackaddr}
+
+b=5Fspi=3D
+	sf read ${loadaddr} ${osaddr=5Fspi} ${ossize=5Fspi} &&
+	run vxargs && bootm ${loadaddr}
+
+b=5Fnet=3Dtftp ${scradr} netscript.img && source ${scradr}
+b=5Fusb0=3Dusb start && load usb 0 ${scradr} usbscript.img && source ${scr=
adr}
+b=5Fusb1=3Dusb start && load usb 0 ${scradr} bootscr.img && source ${scrad=
r}
+
+/* FPGA setup */
+b=5Ffpga=3D
+	setenv fpgastatus disabled;
+	sf read ${loadaddr} ${fpgaaddr=5Fspi} ${fpgasize=5Fspi} &&
+	fpga loadb 0 ${loadaddr} ${fpgasize=5Fspi} &&
+	setenv fpgastatus okay
+
+/* Configuration preboot*/
+cfgscr=3D
+	sf probe &&
+	sf read ${scradr} ${cfgaddr=5Fspi} ${cfgsize=5Fspi} &&
+	source ${scradr}
+
+cfgoptsct=3D
+	sf probe &&
+	sf read ${scradr} ${optaddr=5Fspi} ${optsize=5Fspi} &&
+	source ${scradr}
+
+/* OS Boot */
+fdt=5Ffixup=3D
+	run cfgscr; run cfgoptsct; run vxfdt
+
+vxargs=3D
+	setenv bootargs gem(0,0)host:vxWorks h=3D${serverip}
+	e=3D${ipaddr}:${netmask} g=3D${gatewayip} u=3DvxWorksFTP pw=3DvxWorks f=
=3D0x1
+
+vxfdt=3D
+	fdt set /fpga/pci status ${fpgastatus};
+	fdt set /fpga status ${fpgastatus}
+
+/* Boot code */
+b=5Fdefault=3D
+	run b=5Fdeftgts;
+	for target in ${b=5Ftgts}; do
+		run b=5F${target};
+		if test ${b=5Fbreak} =3D 1; then;
+			exit;
+		fi;
+	done
+
+b=5Fdeftgts=3D
+	if test ${b=5Fmode} =3D 12; then
+		setenv b=5Ftgts ${b=5Ftgts=5Fpme};
+	elif test ${b=5Fmode} =3D 0; then
+		setenv b=5Ftgts ${b=5Ftgts=5Frcy};
+	else
+		setenv b=5Ftgts ${b=5Ftgts=5Fstd};
+	fi
diff --git a/configs/brcp150=5Fdefconfig b/configs/brcp150=5Fdefconfig
new file mode 100644
index 00000000000..d619f71f37b
--- /dev/null
+++ b/configs/brcp150=5Fdefconfig
@@ -0,0 +1,121 @@
+CONFIG=5FARM=3Dy
+CONFIG=5FSYS=5FVENDOR=3D"BuR"
+CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
+CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
+CONFIG=5FARCH=5FZYNQ=3Dy
+CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
+CONFIG=5FINITRD=5FTAG=3Dy
+CONFIG=5FTEXT=5FBASE=3D0x4000000
+CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
+CONFIG=5FSPL=5FGPIO=3Dy
+CONFIG=5FNR=5FDRAM=5FBANKS=3D1
+CONFIG=5FENV=5FSOURCE=5FFILE=3D"env/brcp150"
+CONFIG=5FSF=5FDEFAULT=5FSPEED=3D100000000
+CONFIG=5FSF=5FDEFAULT=5FMODE=3D0x3
+CONFIG=5FENV=5FSIZE=3D0x10000
+CONFIG=5FENV=5FOFFSET=3D0x20000
+CONFIG=5FENV=5FSECT=5FSIZE=3D0x10000
+CONFIG=5FDM=5FGPIO=3Dy
+CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"zynq-brcp150"
+CONFIG=5FMULTI=5FDTB=5FFIT=5FUNCOMPRESS=5FSZ=3D0x10000
+# CONFIG=5FSPL=5FMMC is not set
+CONFIG=5FSPL=5FSTACK=5FR=5FADDR=3D0x800000
+CONFIG=5FSPL=5FSTACK=3D0xFFFFFE00
+CONFIG=5FSPL=5FHAS=5FBSS=5FLINKER=5FSECTION=3Dy
+CONFIG=5FSPL=5FBSS=5FSTART=5FADDR=3D0x20000
+CONFIG=5FSPL=5FBSS=5FMAX=5FSIZE=3D0x80000
+CONFIG=5FSPL=5FSTACK=5FR=3Dy
+CONFIG=5FSPL=5FSTACK=5FR=5FMALLOC=5FSIMPLE=5FLEN=3D0x600000
+CONFIG=5FSYS=5FBOOTM=5FLEN=3D0x2000000
+CONFIG=5FSYS=5FLOAD=5FADDR=3D0x2000000
+CONFIG=5FSPL=5FSIZE=5FLIMIT=3D0x20000
+CONFIG=5FSPL=3Dy
+CONFIG=5FENV=5FOFFSET=5FREDUND=3D0x30000
+# CONFIG=5FSPL=5FFS=5FFAT is not set
+# CONFIG=5FSPL=5FLIBDISK=5FSUPPORT is not set
+CONFIG=5FZYNQ=5FSDHCI=5FMAX=5FFREQ=3D100000000
+CONFIG=5FTARGET=5FZYNQ=5FBR=3Dy
+# CONFIG=5FEFI=5FLOADER is not set
+CONFIG=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=5FADDRESS=3D0x4000000
+CONFIG=5FSPL=5FLOAD=5FFIT=5FFULL=3Dy
+CONFIG=5FBOOTDELAY=3D0
+CONFIG=5FOF=5FENV=5FSETUP=3Dy
+CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
+CONFIG=5FBOOTCOMMAND=3D"run b=5Fdefault"
+CONFIG=5FUSE=5FPREBOOT=3Dy
+CONFIG=5FSYS=5FCBSIZE=3D512
+CONFIG=5FSYS=5FCONSOLE=5FINFO=5FQUIET=3Dy
+# CONFIG=5FDISPLAY=5FCPUINFO is not set
+CONFIG=5FCLOCKS=3Dy
+CONFIG=5FSPL=5FMAX=5FSIZE=3D0x20000
+CONFIG=5FSPL=5FPAD=5FTO=3D0x0
+CONFIG=5FSPL=5FSYS=5FMALLOC=5FSIMPLE=3Dy
+# CONFIG=5FSPL=5FSHARES=5FINIT=5FSP=5FADDR is not set
+# CONFIG=5FSPL=5FSYS=5FMMCSD=5FRAW=5FMODE is not set
+CONFIG=5FSPL=5FCPU=3Dy
+CONFIG=5FSPL=5FFPGA=3Dy
+CONFIG=5FSPL=5FI2C=3Dy
+CONFIG=5FSPL=5FSPI=5FLOAD=3Dy
+CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS=3D0x40000
+CONFIG=5FHUSH=5FPARSER=3Dy
+CONFIG=5FHUSH=5FMODERN=5FPARSER=3Dy
+CONFIG=5FSYS=5FPROMPT=3D"-> "
+CONFIG=5FCMD=5FGPIO=3Dy
+CONFIG=5FCMD=5FI2C=3Dy
+# CONFIG=5FCMD=5FLOADB is not set
+# CONFIG=5FCMD=5FLOADS is not set
+CONFIG=5FCMD=5FMMC=3Dy
+CONFIG=5FCMD=5FUSB=3Dy
+CONFIG=5FBOOTP=5FMAY=5FFAIL=3Dy
+CONFIG=5FCMD=5FEXT4=3Dy
+CONFIG=5FCMD=5FEXT4=5FWRITE=3Dy
+CONFIG=5FCMD=5FFAT=3Dy
+CONFIG=5FCMD=5FFS=5FGENERIC=3Dy
+CONFIG=5FENV=5FOVERWRITE=3Dy
+CONFIG=5FENV=5FIS=5FIN=5FSPI=5FFLASH=3Dy
+CONFIG=5FSYS=5FREDUNDAND=5FENVIRONMENT=3Dy
+CONFIG=5FNET=5FRETRY=5FCOUNT=3D10
+CONFIG=5FNET=5FRANDOM=5FETHADDR=3Dy
+CONFIG=5FFPGA=5FXILINX=3Dy
+CONFIG=5FFPGA=5FZYNQPL=3Dy
+CONFIG=5FMAX7320=5FGPIO=3Dy
+CONFIG=5FDM=5FI2C=3Dy
+CONFIG=5FSYS=5FI2C=5FCADENCE=3Dy
+CONFIG=5FLED=3Dy
+CONFIG=5FLED=5FGPIO=3Dy
+CONFIG=5FMMC=5FSDHCI=3Dy
+CONFIG=5FMMC=5FSDHCI=5FZYNQ=3Dy
+CONFIG=5FZYNQ=5FHISPD=5FBROKEN=3Dy
+CONFIG=5FDM=5FMTD=3Dy
+CONFIG=5FSPI=5FFLASH=5FATMEL=3Dy
+CONFIG=5FSPI=5FFLASH=5FEON=3Dy
+CONFIG=5FSPI=5FFLASH=5FGIGADEVICE=3Dy
+CONFIG=5FSPI=5FFLASH=5FISSI=3Dy
+CONFIG=5FSPI=5FFLASH=5FMACRONIX=3Dy
+CONFIG=5FSPI=5FFLASH=5FSILICONKAISER=3Dy
+CONFIG=5FSPI=5FFLASH=5FSPANSION=3Dy
+CONFIG=5FSPI=5FFLASH=5FS28HX=5FT=3Dy
+CONFIG=5FSPI=5FFLASH=5FSTMICRO=3Dy
+CONFIG=5FSPI=5FFLASH=5FMT35XU=3Dy
+CONFIG=5FSPI=5FFLASH=5FSST=3Dy
+CONFIG=5FSPI=5FFLASH=5FWINBOND=3Dy
+CONFIG=5FSPI=5FFLASH=5FXMC=3Dy
+CONFIG=5FSPI=5FFLASH=5FXTX=3Dy
+CONFIG=5FSPI=5FFLASH=5FZBIT=3Dy
+CONFIG=5FSPI=5FFLASH=5FDATAFLASH=3Dy
+CONFIG=5FPHY=5FTI=5FGENERIC=3Dy
+CONFIG=5FMII=3Dy
+CONFIG=5FZYNQ=5FGEM=3Dy
+CONFIG=5FZYNQ=5FSERIAL=3Dy
+CONFIG=5FZYNQ=5FQSPI=3Dy
+CONFIG=5FUSB=3Dy
+CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
+CONFIG=5FUSB=5FULPI=5FVIEWPORT=3Dy
+CONFIG=5FUSB=5FULPI=3Dy
+CONFIG=5FUSB=5FSTORAGE=3Dy
+CONFIG=5FSYS=5FTIMER=5FCOUNTS=5FDOWN=3Dy
+# CONFIG=5FSHA256 is not set
+CONFIG=5FSPL=5FCRC32=3Dy
+# CONFIG=5FSPL=5FSHA1 is not set
diff --git a/configs/brcp170=5Fdefconfig b/configs/brcp170=5Fdefconfig
new file mode 100644
index 00000000000..06cd64ad4bc
--- /dev/null
+++ b/configs/brcp170=5Fdefconfig
@@ -0,0 +1,120 @@
+CONFIG=5FARM=3Dy
+CONFIG=5FSYS=5FVENDOR=3D"BuR"
+CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
+CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
+CONFIG=5FARCH=5FZYNQ=3Dy
+CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
+CONFIG=5FINITRD=5FTAG=3Dy
+CONFIG=5FTEXT=5FBASE=3D0x4000000
+CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
+CONFIG=5FSPL=5FGPIO=3Dy
+CONFIG=5FNR=5FDRAM=5FBANKS=3D1
+CONFIG=5FENV=5FSOURCE=5FFILE=3D"env/brcp1"
+CONFIG=5FSF=5FDEFAULT=5FSPEED=3D100000000
+CONFIG=5FSF=5FDEFAULT=5FMODE=3D0x3
+CONFIG=5FENV=5FSIZE=3D0x10000
+CONFIG=5FENV=5FOFFSET=3D0x20000
+CONFIG=5FENV=5FSECT=5FSIZE=3D0x10000
+CONFIG=5FDM=5FGPIO=3Dy
+CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"zynq-brcp170"
+CONFIG=5FMULTI=5FDTB=5FFIT=5FUNCOMPRESS=5FSZ=3D0x10000
+# CONFIG=5FSPL=5FMMC is not set
+CONFIG=5FSPL=5FSTACK=5FR=5FADDR=3D0x800000
+CONFIG=5FSPL=5FSTACK=3D0xFFFFFE00
+CONFIG=5FSPL=5FHAS=5FBSS=5FLINKER=5FSECTION=3Dy
+CONFIG=5FSPL=5FBSS=5FSTART=5FADDR=3D0x20000
+CONFIG=5FSPL=5FBSS=5FMAX=5FSIZE=3D0x80000
+CONFIG=5FSPL=5FSTACK=5FR=3Dy
+CONFIG=5FSPL=5FSTACK=5FR=5FMALLOC=5FSIMPLE=5FLEN=3D0x600000
+CONFIG=5FSYS=5FBOOTM=5FLEN=3D0x2000000
+CONFIG=5FSYS=5FLOAD=5FADDR=3D0x2000000
+CONFIG=5FSPL=5FSIZE=5FLIMIT=3D0x20000
+CONFIG=5FSPL=3Dy
+CONFIG=5FENV=5FOFFSET=5FREDUND=3D0x30000
+# CONFIG=5FSPL=5FFS=5FFAT is not set
+# CONFIG=5FSPL=5FLIBDISK=5FSUPPORT is not set
+CONFIG=5FZYNQ=5FSDHCI=5FMAX=5FFREQ=3D100000000
+CONFIG=5FTARGET=5FZYNQ=5FBR=3Dy
+# CONFIG=5FEFI=5FLOADER is not set
+CONFIG=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=5FADDRESS=3D0x4000000
+CONFIG=5FSPL=5FLOAD=5FFIT=5FFULL=3Dy
+CONFIG=5FBOOTDELAY=3D0
+CONFIG=5FOF=5FENV=5FSETUP=3Dy
+CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
+CONFIG=5FBOOTCOMMAND=3D"run b=5Fdefault"
+CONFIG=5FUSE=5FPREBOOT=3Dy
+CONFIG=5FSYS=5FCBSIZE=3D512
+CONFIG=5FSYS=5FCONSOLE=5FINFO=5FQUIET=3Dy
+# CONFIG=5FDISPLAY=5FCPUINFO is not set
+CONFIG=5FCLOCKS=3Dy
+CONFIG=5FSPL=5FMAX=5FSIZE=3D0x20000
+CONFIG=5FSPL=5FPAD=5FTO=3D0x0
+CONFIG=5FSPL=5FSYS=5FMALLOC=5FSIMPLE=3Dy
+# CONFIG=5FSPL=5FSHARES=5FINIT=5FSP=5FADDR is not set
+# CONFIG=5FSPL=5FSYS=5FMMCSD=5FRAW=5FMODE is not set
+CONFIG=5FSPL=5FCPU=3Dy
+CONFIG=5FSPL=5FI2C=3Dy
+CONFIG=5FSPL=5FSPI=5FLOAD=3Dy
+CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS=3D0x40000
+CONFIG=5FHUSH=5FPARSER=3Dy
+CONFIG=5FHUSH=5FMODERN=5FPARSER=3Dy
+CONFIG=5FSYS=5FPROMPT=3D"-> "
+CONFIG=5FCMD=5FGPIO=3Dy
+CONFIG=5FCMD=5FI2C=3Dy
+# CONFIG=5FCMD=5FLOADB is not set
+# CONFIG=5FCMD=5FLOADS is not set
+CONFIG=5FCMD=5FMMC=3Dy
+CONFIG=5FCMD=5FUSB=3Dy
+CONFIG=5FBOOTP=5FMAY=5FFAIL=3Dy
+CONFIG=5FCMD=5FEXT4=3Dy
+CONFIG=5FCMD=5FEXT4=5FWRITE=3Dy
+CONFIG=5FCMD=5FFAT=3Dy
+CONFIG=5FCMD=5FFS=5FGENERIC=3Dy
+CONFIG=5FENV=5FOVERWRITE=3Dy
+CONFIG=5FENV=5FIS=5FIN=5FSPI=5FFLASH=3Dy
+CONFIG=5FSYS=5FREDUNDAND=5FENVIRONMENT=3Dy
+CONFIG=5FNET=5FRETRY=5FCOUNT=3D10
+CONFIG=5FNET=5FRANDOM=5FETHADDR=3Dy
+CONFIG=5FFPGA=5FXILINX=3Dy
+CONFIG=5FFPGA=5FZYNQPL=3Dy
+CONFIG=5FMAX7320=5FGPIO=3Dy
+CONFIG=5FDM=5FI2C=3Dy
+CONFIG=5FSYS=5FI2C=5FCADENCE=3Dy
+CONFIG=5FLED=3Dy
+CONFIG=5FLED=5FGPIO=3Dy
+CONFIG=5FMMC=5FSDHCI=3Dy
+CONFIG=5FMMC=5FSDHCI=5FZYNQ=3Dy
+CONFIG=5FZYNQ=5FHISPD=5FBROKEN=3Dy
+CONFIG=5FDM=5FMTD=3Dy
+CONFIG=5FSPI=5FFLASH=5FATMEL=3Dy
+CONFIG=5FSPI=5FFLASH=5FEON=3Dy
+CONFIG=5FSPI=5FFLASH=5FGIGADEVICE=3Dy
+CONFIG=5FSPI=5FFLASH=5FISSI=3Dy
+CONFIG=5FSPI=5FFLASH=5FMACRONIX=3Dy
+CONFIG=5FSPI=5FFLASH=5FSILICONKAISER=3Dy
+CONFIG=5FSPI=5FFLASH=5FSPANSION=3Dy
+CONFIG=5FSPI=5FFLASH=5FS28HX=5FT=3Dy
+CONFIG=5FSPI=5FFLASH=5FSTMICRO=3Dy
+CONFIG=5FSPI=5FFLASH=5FMT35XU=3Dy
+CONFIG=5FSPI=5FFLASH=5FSST=3Dy
+CONFIG=5FSPI=5FFLASH=5FWINBOND=3Dy
+CONFIG=5FSPI=5FFLASH=5FXMC=3Dy
+CONFIG=5FSPI=5FFLASH=5FXTX=3Dy
+CONFIG=5FSPI=5FFLASH=5FZBIT=3Dy
+CONFIG=5FSPI=5FFLASH=5FDATAFLASH=3Dy
+CONFIG=5FPHY=5FTI=5FGENERIC=3Dy
+CONFIG=5FMII=3Dy
+CONFIG=5FZYNQ=5FGEM=3Dy
+CONFIG=5FZYNQ=5FSERIAL=3Dy
+CONFIG=5FZYNQ=5FQSPI=3Dy
+CONFIG=5FUSB=3Dy
+CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
+CONFIG=5FUSB=5FULPI=5FVIEWPORT=3Dy
+CONFIG=5FUSB=5FULPI=3Dy
+CONFIG=5FUSB=5FSTORAGE=3Dy
+CONFIG=5FSYS=5FTIMER=5FCOUNTS=5FDOWN=3Dy
+# CONFIG=5FSHA256 is not set
+CONFIG=5FSPL=5FCRC32=3Dy
+# CONFIG=5FSPL=5FSHA1 is not set
diff --git a/configs/brcp1=5F1r=5Fdefconfig b/configs/brcp1=5F1r=5Fdefconfig
new file mode 100644
index 00000000000..ed2eb86545c
--- /dev/null
+++ b/configs/brcp1=5F1r=5Fdefconfig
@@ -0,0 +1,120 @@
+CONFIG=5FARM=3Dy
+CONFIG=5FSYS=5FVENDOR=3D"BuR"
+CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
+CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
+CONFIG=5FARCH=5FZYNQ=3Dy
+CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
+CONFIG=5FINITRD=5FTAG=3Dy
+CONFIG=5FTEXT=5FBASE=3D0x4000000
+CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
+CONFIG=5FSPL=5FGPIO=3Dy
+CONFIG=5FNR=5FDRAM=5FBANKS=3D1
+CONFIG=5FENV=5FSOURCE=5FFILE=3D"env/brcp1"
+CONFIG=5FSF=5FDEFAULT=5FSPEED=3D100000000
+CONFIG=5FSF=5FDEFAULT=5FMODE=3D0x3
+CONFIG=5FENV=5FSIZE=3D0x10000
+CONFIG=5FENV=5FOFFSET=3D0x20000
+CONFIG=5FENV=5FSECT=5FSIZE=3D0x10000
+CONFIG=5FDM=5FGPIO=3Dy
+CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"zynq-brcp1=5F1r"
+CONFIG=5FMULTI=5FDTB=5FFIT=5FUNCOMPRESS=5FSZ=3D0x10000
+# CONFIG=5FSPL=5FMMC is not set
+CONFIG=5FSPL=5FSTACK=5FR=5FADDR=3D0x800000
+CONFIG=5FSPL=5FSTACK=3D0xFFFFFE00
+CONFIG=5FSPL=5FHAS=5FBSS=5FLINKER=5FSECTION=3Dy
+CONFIG=5FSPL=5FBSS=5FSTART=5FADDR=3D0x20000
+CONFIG=5FSPL=5FBSS=5FMAX=5FSIZE=3D0x80000
+CONFIG=5FSPL=5FSTACK=5FR=3Dy
+CONFIG=5FSPL=5FSTACK=5FR=5FMALLOC=5FSIMPLE=5FLEN=3D0x600000
+CONFIG=5FSYS=5FBOOTM=5FLEN=3D0x2000000
+CONFIG=5FSYS=5FLOAD=5FADDR=3D0x2000000
+CONFIG=5FSPL=5FSIZE=5FLIMIT=3D0x20000
+CONFIG=5FSPL=3Dy
+CONFIG=5FENV=5FOFFSET=5FREDUND=3D0x30000
+# CONFIG=5FSPL=5FFS=5FFAT is not set
+# CONFIG=5FSPL=5FLIBDISK=5FSUPPORT is not set
+CONFIG=5FZYNQ=5FSDHCI=5FMAX=5FFREQ=3D100000000
+CONFIG=5FTARGET=5FZYNQ=5FBR=3Dy
+# CONFIG=5FEFI=5FLOADER is not set
+CONFIG=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=5FADDRESS=3D0x4000000
+CONFIG=5FSPL=5FLOAD=5FFIT=5FFULL=3Dy
+CONFIG=5FBOOTDELAY=3D0
+CONFIG=5FOF=5FENV=5FSETUP=3Dy
+CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
+CONFIG=5FBOOTCOMMAND=3D"run b=5Fdefault"
+CONFIG=5FUSE=5FPREBOOT=3Dy
+CONFIG=5FSYS=5FCBSIZE=3D512
+CONFIG=5FSYS=5FCONSOLE=5FINFO=5FQUIET=3Dy
+# CONFIG=5FDISPLAY=5FCPUINFO is not set
+CONFIG=5FCLOCKS=3Dy
+CONFIG=5FSPL=5FMAX=5FSIZE=3D0x20000
+CONFIG=5FSPL=5FPAD=5FTO=3D0x0
+CONFIG=5FSPL=5FSYS=5FMALLOC=5FSIMPLE=3Dy
+# CONFIG=5FSPL=5FSHARES=5FINIT=5FSP=5FADDR is not set
+# CONFIG=5FSPL=5FSYS=5FMMCSD=5FRAW=5FMODE is not set
+CONFIG=5FSPL=5FCPU=3Dy
+CONFIG=5FSPL=5FI2C=3Dy
+CONFIG=5FSPL=5FSPI=5FLOAD=3Dy
+CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS=3D0x40000
+CONFIG=5FHUSH=5FPARSER=3Dy
+CONFIG=5FHUSH=5FMODERN=5FPARSER=3Dy
+CONFIG=5FSYS=5FPROMPT=3D"-> "
+CONFIG=5FCMD=5FGPIO=3Dy
+CONFIG=5FCMD=5FI2C=3Dy
+# CONFIG=5FCMD=5FLOADB is not set
+# CONFIG=5FCMD=5FLOADS is not set
+CONFIG=5FCMD=5FMMC=3Dy
+CONFIG=5FCMD=5FUSB=3Dy
+CONFIG=5FBOOTP=5FMAY=5FFAIL=3Dy
+CONFIG=5FCMD=5FEXT4=3Dy
+CONFIG=5FCMD=5FEXT4=5FWRITE=3Dy
+CONFIG=5FCMD=5FFAT=3Dy
+CONFIG=5FCMD=5FFS=5FGENERIC=3Dy
+CONFIG=5FENV=5FOVERWRITE=3Dy
+CONFIG=5FENV=5FIS=5FIN=5FSPI=5FFLASH=3Dy
+CONFIG=5FSYS=5FREDUNDAND=5FENVIRONMENT=3Dy
+CONFIG=5FNET=5FRETRY=5FCOUNT=3D10
+CONFIG=5FNET=5FRANDOM=5FETHADDR=3Dy
+CONFIG=5FFPGA=5FXILINX=3Dy
+CONFIG=5FFPGA=5FZYNQPL=3Dy
+CONFIG=5FMAX7320=5FGPIO=3Dy
+CONFIG=5FDM=5FI2C=3Dy
+CONFIG=5FSYS=5FI2C=5FCADENCE=3Dy
+CONFIG=5FLED=3Dy
+CONFIG=5FLED=5FGPIO=3Dy
+CONFIG=5FMMC=5FSDHCI=3Dy
+CONFIG=5FMMC=5FSDHCI=5FZYNQ=3Dy
+CONFIG=5FZYNQ=5FHISPD=5FBROKEN=3Dy
+CONFIG=5FDM=5FMTD=3Dy
+CONFIG=5FSPI=5FFLASH=5FATMEL=3Dy
+CONFIG=5FSPI=5FFLASH=5FEON=3Dy
+CONFIG=5FSPI=5FFLASH=5FGIGADEVICE=3Dy
+CONFIG=5FSPI=5FFLASH=5FISSI=3Dy
+CONFIG=5FSPI=5FFLASH=5FMACRONIX=3Dy
+CONFIG=5FSPI=5FFLASH=5FSILICONKAISER=3Dy
+CONFIG=5FSPI=5FFLASH=5FSPANSION=3Dy
+CONFIG=5FSPI=5FFLASH=5FS28HX=5FT=3Dy
+CONFIG=5FSPI=5FFLASH=5FSTMICRO=3Dy
+CONFIG=5FSPI=5FFLASH=5FMT35XU=3Dy
+CONFIG=5FSPI=5FFLASH=5FSST=3Dy
+CONFIG=5FSPI=5FFLASH=5FWINBOND=3Dy
+CONFIG=5FSPI=5FFLASH=5FXMC=3Dy
+CONFIG=5FSPI=5FFLASH=5FXTX=3Dy
+CONFIG=5FSPI=5FFLASH=5FZBIT=3Dy
+CONFIG=5FSPI=5FFLASH=5FDATAFLASH=3Dy
+CONFIG=5FPHY=5FNATSEMI=3Dy
+CONFIG=5FMII=3Dy
+CONFIG=5FZYNQ=5FGEM=3Dy
+CONFIG=5FZYNQ=5FSERIAL=3Dy
+CONFIG=5FZYNQ=5FQSPI=3Dy
+CONFIG=5FUSB=3Dy
+CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
+CONFIG=5FUSB=5FULPI=5FVIEWPORT=3Dy
+CONFIG=5FUSB=5FULPI=3Dy
+CONFIG=5FUSB=5FSTORAGE=3Dy
+CONFIG=5FSYS=5FTIMER=5FCOUNTS=5FDOWN=3Dy
+# CONFIG=5FSHA256 is not set
+CONFIG=5FSPL=5FCRC32=3Dy
+# CONFIG=5FSPL=5FSHA1 is not set
diff --git a/configs/brcp1=5F1r=5Fswitch=5Fdefconfig b/configs/brcp1=5F1r=
=5Fswitch=5Fdefconfig
new file mode 100644
index 00000000000..38427da7b51
--- /dev/null
+++ b/configs/brcp1=5F1r=5Fswitch=5Fdefconfig
@@ -0,0 +1,121 @@
+CONFIG=5FARM=3Dy
+CONFIG=5FSYS=5FVENDOR=3D"BuR"
+CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
+CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
+CONFIG=5FARCH=5FZYNQ=3Dy
+CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
+CONFIG=5FINITRD=5FTAG=3Dy
+CONFIG=5FTEXT=5FBASE=3D0x4000000
+CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
+CONFIG=5FSPL=5FGPIO=3Dy
+CONFIG=5FNR=5FDRAM=5FBANKS=3D1
+CONFIG=5FENV=5FSOURCE=5FFILE=3D"env/brcp1"
+CONFIG=5FSF=5FDEFAULT=5FSPEED=3D100000000
+CONFIG=5FSF=5FDEFAULT=5FMODE=3D0x3
+CONFIG=5FENV=5FSIZE=3D0x10000
+CONFIG=5FENV=5FOFFSET=3D0x20000
+CONFIG=5FENV=5FSECT=5FSIZE=3D0x10000
+CONFIG=5FDM=5FGPIO=3Dy
+CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"zynq-brcp1=5F1r=5Fswitch"
+CONFIG=5FMULTI=5FDTB=5FFIT=5FUNCOMPRESS=5FSZ=3D0x10000
+# CONFIG=5FSPL=5FMMC is not set
+CONFIG=5FSPL=5FSTACK=5FR=5FADDR=3D0x800000
+CONFIG=5FSPL=5FSTACK=3D0xFFFFFE00
+CONFIG=5FSPL=5FHAS=5FBSS=5FLINKER=5FSECTION=3Dy
+CONFIG=5FSPL=5FBSS=5FSTART=5FADDR=3D0x20000
+CONFIG=5FSPL=5FBSS=5FMAX=5FSIZE=3D0x80000
+CONFIG=5FSPL=5FSTACK=5FR=3Dy
+CONFIG=5FSPL=5FSTACK=5FR=5FMALLOC=5FSIMPLE=5FLEN=3D0x600000
+CONFIG=5FSYS=5FBOOTM=5FLEN=3D0x2000000
+CONFIG=5FSYS=5FLOAD=5FADDR=3D0x2000000
+CONFIG=5FSPL=5FSIZE=5FLIMIT=3D0x20000
+CONFIG=5FSPL=3Dy
+CONFIG=5FENV=5FOFFSET=5FREDUND=3D0x30000
+# CONFIG=5FSPL=5FFS=5FFAT is not set
+# CONFIG=5FSPL=5FLIBDISK=5FSUPPORT is not set
+CONFIG=5FZYNQ=5FSDHCI=5FMAX=5FFREQ=3D100000000
+CONFIG=5FTARGET=5FZYNQ=5FBR=3Dy
+# CONFIG=5FEFI=5FLOADER is not set
+CONFIG=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=5FADDRESS=3D0x4000000
+CONFIG=5FSPL=5FLOAD=5FFIT=5FFULL=3Dy
+CONFIG=5FBOOTDELAY=3D0
+CONFIG=5FOF=5FENV=5FSETUP=3Dy
+CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
+CONFIG=5FBOOTCOMMAND=3D"run b=5Fdefault"
+CONFIG=5FUSE=5FPREBOOT=3Dy
+CONFIG=5FSYS=5FCBSIZE=3D512
+CONFIG=5FSYS=5FCONSOLE=5FINFO=5FQUIET=3Dy
+# CONFIG=5FDISPLAY=5FCPUINFO is not set
+CONFIG=5FCLOCKS=3Dy
+CONFIG=5FSPL=5FMAX=5FSIZE=3D0x20000
+CONFIG=5FSPL=5FPAD=5FTO=3D0x0
+CONFIG=5FSPL=5FSYS=5FMALLOC=5FSIMPLE=3Dy
+# CONFIG=5FSPL=5FSHARES=5FINIT=5FSP=5FADDR is not set
+# CONFIG=5FSPL=5FSYS=5FMMCSD=5FRAW=5FMODE is not set
+CONFIG=5FSPL=5FCPU=3Dy
+CONFIG=5FSPL=5FI2C=3Dy
+CONFIG=5FSPL=5FSPI=5FLOAD=3Dy
+CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS=3D0x40000
+CONFIG=5FHUSH=5FPARSER=3Dy
+CONFIG=5FHUSH=5FMODERN=5FPARSER=3Dy
+CONFIG=5FSYS=5FPROMPT=3D"-> "
+CONFIG=5FCMD=5FGPIO=3Dy
+CONFIG=5FCMD=5FI2C=3Dy
+# CONFIG=5FCMD=5FLOADB is not set
+# CONFIG=5FCMD=5FLOADS is not set
+CONFIG=5FCMD=5FMMC=3Dy
+CONFIG=5FCMD=5FUSB=3Dy
+CONFIG=5FBOOTP=5FMAY=5FFAIL=3Dy
+CONFIG=5FCMD=5FEXT4=3Dy
+CONFIG=5FCMD=5FEXT4=5FWRITE=3Dy
+CONFIG=5FCMD=5FFAT=3Dy
+CONFIG=5FCMD=5FFS=5FGENERIC=3Dy
+CONFIG=5FENV=5FOVERWRITE=3Dy
+CONFIG=5FENV=5FIS=5FIN=5FSPI=5FFLASH=3Dy
+CONFIG=5FSYS=5FREDUNDAND=5FENVIRONMENT=3Dy
+CONFIG=5FNET=5FRETRY=5FCOUNT=3D10
+CONFIG=5FNET=5FRANDOM=5FETHADDR=3Dy
+CONFIG=5FFPGA=5FXILINX=3Dy
+CONFIG=5FFPGA=5FZYNQPL=3Dy
+CONFIG=5FMAX7320=5FGPIO=3Dy
+CONFIG=5FDM=5FI2C=3Dy
+CONFIG=5FSYS=5FI2C=5FCADENCE=3Dy
+CONFIG=5FLED=3Dy
+CONFIG=5FLED=5FGPIO=3Dy
+CONFIG=5FMMC=5FSDHCI=3Dy
+CONFIG=5FMMC=5FSDHCI=5FZYNQ=3Dy
+CONFIG=5FZYNQ=5FHISPD=5FBROKEN=3Dy
+CONFIG=5FDM=5FMTD=3Dy
+CONFIG=5FSPI=5FFLASH=5FATMEL=3Dy
+CONFIG=5FSPI=5FFLASH=5FEON=3Dy
+CONFIG=5FSPI=5FFLASH=5FGIGADEVICE=3Dy
+CONFIG=5FSPI=5FFLASH=5FISSI=3Dy
+CONFIG=5FSPI=5FFLASH=5FMACRONIX=3Dy
+CONFIG=5FSPI=5FFLASH=5FSILICONKAISER=3Dy
+CONFIG=5FSPI=5FFLASH=5FSPANSION=3Dy
+CONFIG=5FSPI=5FFLASH=5FS28HX=5FT=3Dy
+CONFIG=5FSPI=5FFLASH=5FSTMICRO=3Dy
+CONFIG=5FSPI=5FFLASH=5FMT35XU=3Dy
+CONFIG=5FSPI=5FFLASH=5FSST=3Dy
+CONFIG=5FSPI=5FFLASH=5FWINBOND=3Dy
+CONFIG=5FSPI=5FFLASH=5FXMC=3Dy
+CONFIG=5FSPI=5FFLASH=5FXTX=3Dy
+CONFIG=5FSPI=5FFLASH=5FZBIT=3Dy
+CONFIG=5FSPI=5FFLASH=5FDATAFLASH=3Dy
+CONFIG=5FPHY=5FNATSEMI=3Dy
+CONFIG=5FPHY=5FFIXED=3Dy
+CONFIG=5FMII=3Dy
+CONFIG=5FZYNQ=5FGEM=3Dy
+CONFIG=5FZYNQ=5FSERIAL=3Dy
+CONFIG=5FZYNQ=5FQSPI=3Dy
+CONFIG=5FUSB=3Dy
+CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
+CONFIG=5FUSB=5FULPI=5FVIEWPORT=3Dy
+CONFIG=5FUSB=5FULPI=3Dy
+CONFIG=5FUSB=5FSTORAGE=3Dy
+CONFIG=5FSYS=5FTIMER=5FCOUNTS=5FDOWN=3Dy
+# CONFIG=5FSHA256 is not set
+CONFIG=5FSPL=5FCRC32=3Dy
+# CONFIG=5FSPL=5FSHA1 is not set
diff --git a/configs/brcp1=5F2r=5Fdefconfig b/configs/brcp1=5F2r=5Fdefconfig
new file mode 100644
index 00000000000..2bc8eab14a8
--- /dev/null
+++ b/configs/brcp1=5F2r=5Fdefconfig
@@ -0,0 +1,120 @@
+CONFIG=5FARM=3Dy
+CONFIG=5FSYS=5FVENDOR=3D"BuR"
+CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
+CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
+CONFIG=5FARCH=5FZYNQ=3Dy
+CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
+CONFIG=5FINITRD=5FTAG=3Dy
+CONFIG=5FTEXT=5FBASE=3D0x4000000
+CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
+CONFIG=5FSPL=5FGPIO=3Dy
+CONFIG=5FNR=5FDRAM=5FBANKS=3D1
+CONFIG=5FENV=5FSOURCE=5FFILE=3D"env/brcp1"
+CONFIG=5FSF=5FDEFAULT=5FSPEED=3D100000000
+CONFIG=5FSF=5FDEFAULT=5FMODE=3D0x3
+CONFIG=5FENV=5FSIZE=3D0x10000
+CONFIG=5FENV=5FOFFSET=3D0x20000
+CONFIG=5FENV=5FSECT=5FSIZE=3D0x10000
+CONFIG=5FDM=5FGPIO=3Dy
+CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"zynq-brcp1=5F2r"
+CONFIG=5FMULTI=5FDTB=5FFIT=5FUNCOMPRESS=5FSZ=3D0x10000
+# CONFIG=5FSPL=5FMMC is not set
+CONFIG=5FSPL=5FSTACK=5FR=5FADDR=3D0x800000
+CONFIG=5FSPL=5FSTACK=3D0xFFFFFE00
+CONFIG=5FSPL=5FHAS=5FBSS=5FLINKER=5FSECTION=3Dy
+CONFIG=5FSPL=5FBSS=5FSTART=5FADDR=3D0x20000
+CONFIG=5FSPL=5FBSS=5FMAX=5FSIZE=3D0x80000
+CONFIG=5FSPL=5FSTACK=5FR=3Dy
+CONFIG=5FSPL=5FSTACK=5FR=5FMALLOC=5FSIMPLE=5FLEN=3D0x600000
+CONFIG=5FSYS=5FBOOTM=5FLEN=3D0x2000000
+CONFIG=5FSYS=5FLOAD=5FADDR=3D0x2000000
+CONFIG=5FSPL=5FSIZE=5FLIMIT=3D0x20000
+CONFIG=5FSPL=3Dy
+CONFIG=5FENV=5FOFFSET=5FREDUND=3D0x30000
+# CONFIG=5FSPL=5FFS=5FFAT is not set
+# CONFIG=5FSPL=5FLIBDISK=5FSUPPORT is not set
+CONFIG=5FZYNQ=5FSDHCI=5FMAX=5FFREQ=3D100000000
+CONFIG=5FTARGET=5FZYNQ=5FBR=3Dy
+# CONFIG=5FEFI=5FLOADER is not set
+CONFIG=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=5FADDRESS=3D0x4000000
+CONFIG=5FSPL=5FLOAD=5FFIT=5FFULL=3Dy
+CONFIG=5FBOOTDELAY=3D0
+CONFIG=5FOF=5FENV=5FSETUP=3Dy
+CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
+CONFIG=5FBOOTCOMMAND=3D"run b=5Fdefault"
+CONFIG=5FUSE=5FPREBOOT=3Dy
+CONFIG=5FSYS=5FCBSIZE=3D512
+CONFIG=5FSYS=5FCONSOLE=5FINFO=5FQUIET=3Dy
+# CONFIG=5FDISPLAY=5FCPUINFO is not set
+CONFIG=5FCLOCKS=3Dy
+CONFIG=5FSPL=5FMAX=5FSIZE=3D0x20000
+CONFIG=5FSPL=5FPAD=5FTO=3D0x0
+CONFIG=5FSPL=5FSYS=5FMALLOC=5FSIMPLE=3Dy
+# CONFIG=5FSPL=5FSHARES=5FINIT=5FSP=5FADDR is not set
+# CONFIG=5FSPL=5FSYS=5FMMCSD=5FRAW=5FMODE is not set
+CONFIG=5FSPL=5FCPU=3Dy
+CONFIG=5FSPL=5FI2C=3Dy
+CONFIG=5FSPL=5FSPI=5FLOAD=3Dy
+CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS=3D0x40000
+CONFIG=5FHUSH=5FPARSER=3Dy
+CONFIG=5FHUSH=5FMODERN=5FPARSER=3Dy
+CONFIG=5FSYS=5FPROMPT=3D"-> "
+CONFIG=5FCMD=5FGPIO=3Dy
+CONFIG=5FCMD=5FI2C=3Dy
+# CONFIG=5FCMD=5FLOADB is not set
+# CONFIG=5FCMD=5FLOADS is not set
+CONFIG=5FCMD=5FMMC=3Dy
+CONFIG=5FCMD=5FUSB=3Dy
+CONFIG=5FBOOTP=5FMAY=5FFAIL=3Dy
+CONFIG=5FCMD=5FEXT4=3Dy
+CONFIG=5FCMD=5FEXT4=5FWRITE=3Dy
+CONFIG=5FCMD=5FFAT=3Dy
+CONFIG=5FCMD=5FFS=5FGENERIC=3Dy
+CONFIG=5FENV=5FOVERWRITE=3Dy
+CONFIG=5FENV=5FIS=5FIN=5FSPI=5FFLASH=3Dy
+CONFIG=5FSYS=5FREDUNDAND=5FENVIRONMENT=3Dy
+CONFIG=5FNET=5FRETRY=5FCOUNT=3D10
+CONFIG=5FNET=5FRANDOM=5FETHADDR=3Dy
+CONFIG=5FFPGA=5FXILINX=3Dy
+CONFIG=5FFPGA=5FZYNQPL=3Dy
+CONFIG=5FMAX7320=5FGPIO=3Dy
+CONFIG=5FDM=5FI2C=3Dy
+CONFIG=5FSYS=5FI2C=5FCADENCE=3Dy
+CONFIG=5FLED=3Dy
+CONFIG=5FLED=5FGPIO=3Dy
+CONFIG=5FMMC=5FSDHCI=3Dy
+CONFIG=5FMMC=5FSDHCI=5FZYNQ=3Dy
+CONFIG=5FZYNQ=5FHISPD=5FBROKEN=3Dy
+CONFIG=5FDM=5FMTD=3Dy
+CONFIG=5FSPI=5FFLASH=5FATMEL=3Dy
+CONFIG=5FSPI=5FFLASH=5FEON=3Dy
+CONFIG=5FSPI=5FFLASH=5FGIGADEVICE=3Dy
+CONFIG=5FSPI=5FFLASH=5FISSI=3Dy
+CONFIG=5FSPI=5FFLASH=5FMACRONIX=3Dy
+CONFIG=5FSPI=5FFLASH=5FSILICONKAISER=3Dy
+CONFIG=5FSPI=5FFLASH=5FSPANSION=3Dy
+CONFIG=5FSPI=5FFLASH=5FS28HX=5FT=3Dy
+CONFIG=5FSPI=5FFLASH=5FSTMICRO=3Dy
+CONFIG=5FSPI=5FFLASH=5FMT35XU=3Dy
+CONFIG=5FSPI=5FFLASH=5FSST=3Dy
+CONFIG=5FSPI=5FFLASH=5FWINBOND=3Dy
+CONFIG=5FSPI=5FFLASH=5FXMC=3Dy
+CONFIG=5FSPI=5FFLASH=5FXTX=3Dy
+CONFIG=5FSPI=5FFLASH=5FZBIT=3Dy
+CONFIG=5FSPI=5FFLASH=5FDATAFLASH=3Dy
+CONFIG=5FPHY=5FNATSEMI=3Dy
+CONFIG=5FMII=3Dy
+CONFIG=5FZYNQ=5FGEM=3Dy
+CONFIG=5FZYNQ=5FSERIAL=3Dy
+CONFIG=5FZYNQ=5FQSPI=3Dy
+CONFIG=5FUSB=3Dy
+CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
+CONFIG=5FUSB=5FULPI=5FVIEWPORT=3Dy
+CONFIG=5FUSB=5FULPI=3Dy
+CONFIG=5FUSB=5FSTORAGE=3Dy
+CONFIG=5FSYS=5FTIMER=5FCOUNTS=5FDOWN=3Dy
+# CONFIG=5FSHA256 is not set
+CONFIG=5FSPL=5FCRC32=3Dy
+# CONFIG=5FSPL=5FSHA1 is not set
diff --git a/configs/brsmarc2=5Fdefconfig b/configs/brsmarc2=5Fdefconfig
new file mode 100644
index 00000000000..0b57042424b
--- /dev/null
+++ b/configs/brsmarc2=5Fdefconfig
@@ -0,0 +1,120 @@
+CONFIG=5FARM=3Dy
+CONFIG=5FSYS=5FVENDOR=3D"BuR"
+CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
+CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
+CONFIG=5FARCH=5FZYNQ=3Dy
+CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
+CONFIG=5FINITRD=5FTAG=3Dy
+CONFIG=5FTEXT=5FBASE=3D0x4000000
+CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
+CONFIG=5FSPL=5FGPIO=3Dy
+CONFIG=5FNR=5FDRAM=5FBANKS=3D1
+CONFIG=5FENV=5FSOURCE=5FFILE=3D"env/brcp1"
+CONFIG=5FSF=5FDEFAULT=5FSPEED=3D100000000
+CONFIG=5FSF=5FDEFAULT=5FMODE=3D0x3
+CONFIG=5FENV=5FSIZE=3D0x10000
+CONFIG=5FENV=5FOFFSET=3D0x20000
+CONFIG=5FENV=5FSECT=5FSIZE=3D0x10000
+CONFIG=5FDM=5FGPIO=3Dy
+CONFIG=5FDEFAULT=5FDEVICE=5FTREE=3D"zynq-brsmarc2"
+CONFIG=5FMULTI=5FDTB=5FFIT=5FUNCOMPRESS=5FSZ=3D0x10000
+# CONFIG=5FSPL=5FMMC is not set
+CONFIG=5FSPL=5FSTACK=5FR=5FADDR=3D0x800000
+CONFIG=5FSPL=5FSTACK=3D0xFFFFFE00
+CONFIG=5FSPL=5FHAS=5FBSS=5FLINKER=5FSECTION=3Dy
+CONFIG=5FSPL=5FBSS=5FSTART=5FADDR=3D0x20000
+CONFIG=5FSPL=5FBSS=5FMAX=5FSIZE=3D0x80000
+CONFIG=5FSPL=5FSTACK=5FR=3Dy
+CONFIG=5FSPL=5FSTACK=5FR=5FMALLOC=5FSIMPLE=5FLEN=3D0x600000
+CONFIG=5FSYS=5FBOOTM=5FLEN=3D0x2000000
+CONFIG=5FSYS=5FLOAD=5FADDR=3D0x2000000
+CONFIG=5FSPL=5FSIZE=5FLIMIT=3D0x20000
+CONFIG=5FSPL=3Dy
+CONFIG=5FENV=5FOFFSET=5FREDUND=3D0x30000
+# CONFIG=5FSPL=5FFS=5FFAT is not set
+# CONFIG=5FSPL=5FLIBDISK=5FSUPPORT is not set
+CONFIG=5FZYNQ=5FSDHCI=5FMAX=5FFREQ=3D100000000
+CONFIG=5FTARGET=5FZYNQ=5FBR=3Dy
+# CONFIG=5FEFI=5FLOADER is not set
+CONFIG=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=3Dy
+CONFIG=5FSPL=5FLOAD=5FFIT=5FADDRESS=3D0x4000000
+CONFIG=5FSPL=5FLOAD=5FFIT=5FFULL=3Dy
+CONFIG=5FBOOTDELAY=3D0
+CONFIG=5FOF=5FENV=5FSETUP=3Dy
+CONFIG=5FUSE=5FBOOTCOMMAND=3Dy
+CONFIG=5FBOOTCOMMAND=3D"run b=5Fdefault"
+CONFIG=5FUSE=5FPREBOOT=3Dy
+CONFIG=5FSYS=5FCBSIZE=3D512
+CONFIG=5FSYS=5FCONSOLE=5FINFO=5FQUIET=3Dy
+# CONFIG=5FDISPLAY=5FCPUINFO is not set
+CONFIG=5FCLOCKS=3Dy
+CONFIG=5FSPL=5FMAX=5FSIZE=3D0x20000
+CONFIG=5FSPL=5FPAD=5FTO=3D0x0
+CONFIG=5FSPL=5FSYS=5FMALLOC=5FSIMPLE=3Dy
+# CONFIG=5FSPL=5FSHARES=5FINIT=5FSP=5FADDR is not set
+# CONFIG=5FSPL=5FSYS=5FMMCSD=5FRAW=5FMODE is not set
+CONFIG=5FSPL=5FCPU=3Dy
+CONFIG=5FSPL=5FI2C=3Dy
+CONFIG=5FSPL=5FSPI=5FLOAD=3Dy
+CONFIG=5FSYS=5FSPI=5FU=5FBOOT=5FOFFS=3D0x40000
+CONFIG=5FHUSH=5FPARSER=3Dy
+CONFIG=5FHUSH=5FMODERN=5FPARSER=3Dy
+CONFIG=5FSYS=5FPROMPT=3D"-> "
+CONFIG=5FCMD=5FGPIO=3Dy
+CONFIG=5FCMD=5FI2C=3Dy
+# CONFIG=5FCMD=5FLOADB is not set
+# CONFIG=5FCMD=5FLOADS is not set
+CONFIG=5FCMD=5FMMC=3Dy
+CONFIG=5FCMD=5FUSB=3Dy
+CONFIG=5FBOOTP=5FMAY=5FFAIL=3Dy
+CONFIG=5FCMD=5FEXT4=3Dy
+CONFIG=5FCMD=5FEXT4=5FWRITE=3Dy
+CONFIG=5FCMD=5FFAT=3Dy
+CONFIG=5FCMD=5FFS=5FGENERIC=3Dy
+CONFIG=5FENV=5FOVERWRITE=3Dy
+CONFIG=5FENV=5FIS=5FIN=5FSPI=5FFLASH=3Dy
+CONFIG=5FSYS=5FREDUNDAND=5FENVIRONMENT=3Dy
+CONFIG=5FNET=5FRETRY=5FCOUNT=3D10
+CONFIG=5FNET=5FRANDOM=5FETHADDR=3Dy
+CONFIG=5FFPGA=5FXILINX=3Dy
+CONFIG=5FFPGA=5FZYNQPL=3Dy
+CONFIG=5FMAX7320=5FGPIO=3Dy
+CONFIG=5FDM=5FI2C=3Dy
+CONFIG=5FSYS=5FI2C=5FCADENCE=3Dy
+CONFIG=5FLED=3Dy
+CONFIG=5FLED=5FGPIO=3Dy
+CONFIG=5FMMC=5FSDHCI=3Dy
+CONFIG=5FMMC=5FSDHCI=5FZYNQ=3Dy
+CONFIG=5FZYNQ=5FHISPD=5FBROKEN=3Dy
+CONFIG=5FDM=5FMTD=3Dy
+CONFIG=5FSPI=5FFLASH=5FATMEL=3Dy
+CONFIG=5FSPI=5FFLASH=5FEON=3Dy
+CONFIG=5FSPI=5FFLASH=5FGIGADEVICE=3Dy
+CONFIG=5FSPI=5FFLASH=5FISSI=3Dy
+CONFIG=5FSPI=5FFLASH=5FMACRONIX=3Dy
+CONFIG=5FSPI=5FFLASH=5FSILICONKAISER=3Dy
+CONFIG=5FSPI=5FFLASH=5FSPANSION=3Dy
+CONFIG=5FSPI=5FFLASH=5FS28HX=5FT=3Dy
+CONFIG=5FSPI=5FFLASH=5FSTMICRO=3Dy
+CONFIG=5FSPI=5FFLASH=5FMT35XU=3Dy
+CONFIG=5FSPI=5FFLASH=5FSST=3Dy
+CONFIG=5FSPI=5FFLASH=5FWINBOND=3Dy
+CONFIG=5FSPI=5FFLASH=5FXMC=3Dy
+CONFIG=5FSPI=5FFLASH=5FXTX=3Dy
+CONFIG=5FSPI=5FFLASH=5FZBIT=3Dy
+CONFIG=5FSPI=5FFLASH=5FDATAFLASH=3Dy
+CONFIG=5FPHY=5FNATSEMI=3Dy
+CONFIG=5FMII=3Dy
+CONFIG=5FZYNQ=5FGEM=3Dy
+CONFIG=5FZYNQ=5FSERIAL=3Dy
+CONFIG=5FZYNQ=5FQSPI=3Dy
+CONFIG=5FUSB=3Dy
+CONFIG=5FUSB=5FEHCI=5FHCD=3Dy
+CONFIG=5FUSB=5FULPI=5FVIEWPORT=3Dy
+CONFIG=5FUSB=5FULPI=3Dy
+CONFIG=5FUSB=5FSTORAGE=3Dy
+CONFIG=5FSYS=5FTIMER=5FCOUNTS=5FDOWN=3Dy
+# CONFIG=5FSHA256 is not set
+CONFIG=5FSPL=5FCRC32=3Dy
+# CONFIG=5FSPL=5FSHA1 is not set
diff --git a/include/configs/brzynq.h b/include/configs/brzynq.h
new file mode 100644
index 00000000000..e2ebb2f1004
--- /dev/null
+++ b/include/configs/brzynq.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Config file for BR Zynq board
+ *
+ * Copyright (C) 2024
+ * B&R Industrial Automation GmbH - http://www.br-automation.com/
+ */
+
+#ifndef =5F=5FCONFIG=5FBRZYNQ=5FH=5F=5F
+#define =5F=5FCONFIG=5FBRZYNQ=5FH=5F=5F
+
+/* Increase PHY=5FANEG=5FTIMEOUT since the FPGA needs some setup time */
+#if IS=5FENABLED(CONFIG=5FSPL=5FFPGA)
+#define PHY=5FANEG=5FTIMEOUT  8000
+#endif
+
+/* Use top mapped SRAM */
+#define CFG=5FSYS=5FINIT=5FRAM=5FADDR	0xFFFF0000
+#define CFG=5FSYS=5FINIT=5FRAM=5FSIZE	0x2000
+
+#endif /* =5F=5FCONFIG=5FBRZYNQ=5FH=5F=5F */
--=20
2.49.0

