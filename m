Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F36C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 12:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24694875FD;
	Mon, 25 Dec 2023 13:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="WuH94EIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7C6877CE; Mon, 25 Dec 2023 04:21:56 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB09871DA
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 04:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=TracyMg_Li@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0jzOd9VIhrxdUdBPCorC5GiPdNjoZupYaBe2iad60a4eGOhktxYpLsdDRuAlrlnKFgRQyVbiFqqCKTmGO/5gw3DtH1Ok0idv7t10frYt4HD5UDDuufYx9z2+Q04HoGGvRfCVTaXiUE5B/mtJYER561URRMWZWZS7EAZBKgc4fg7Gs7Gx7ibnphRkLMwPa3XPSLq0kBtoDojxcrxnV0+zfiF4GUTzAzd/AEIP9aJGCGti2QksYX6xZ3ecQTR1HOQ6ssDAO212YpepdqAQidW/I5a4rYFUlepnR4MPYOkrF8mBAW6RH0TUZFtcTbAQfE8GeKWH/nkuQRciqE1bFTI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu14SfLXlSi6i6ACJezFXYLPh4oek+orcV44Bpr39SM=;
 b=l1mB4hClU/zedbWSVGnVGIqQxEqRnaAQNeDrP5JQ+BBnlHhMRT5PHrJe2FhoWNXoYhGgaR8MhD9K/cEuF96cHR+Cu7E43mcPlrDesCMllrPMW1/QjRLGcpxRBZT503SIKIIAlNUeNKHgyWTBzEeum7soQAo92wPSCaYMe5G5OOFnzrP213y9uH141FRNMlck4T8u30sRh7QO6PNuPG7MKxYLGJJdntC7D1HMPhgrAy6clqnp6dtrL1shcEqD14D+5e/eBdos+WRo9aHivH1HgDrhWNrob3g7kC8NjM/miF7eOsPptDoFBrOHGUXZsZlSAtuaYg/qlE9ETf/B2VLvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu14SfLXlSi6i6ACJezFXYLPh4oek+orcV44Bpr39SM=;
 b=WuH94EIGPKAtC0s5va1k2zIt+sPfjx9uv0fMvmc9p6bKtfWLScdkWr+GGfaROk2CBwp0grDho3Z83QasaIz2tKRaJO/aECo3/1Zrcf553ME6icdVffUJB8kF2FD+veLStWJyEjkGUkn49DUcRjptgdg90FnDCzScKXp8hrWrooeknsg2ZPvUW33e1H08DoZWy6MIpd9jOfBP8GDTFxJdcTZCZD1SLhiAFz5x6dIK/WHsFoKpRXQaJjOuM8ZTzR2Ryg1EzE9emekyD/nqzIwrOR7lvq5UU4Lqe/agtgiallO3DCDdX10boVOTsNzwqP/QPtte47cjomdiAmjYHlLNPw==
Received: from TYSPR01MB5885.apcprd01.prod.exchangelabs.com
 (2603:1096:400:468::10) by TY0PR0101MB4239.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 03:21:46 +0000
Received: from TYSPR01MB5885.apcprd01.prod.exchangelabs.com
 ([fe80::4cbb:8c28:500b:5a2d]) by TYSPR01MB5885.apcprd01.prod.exchangelabs.com
 ([fe80::4cbb:8c28:500b:5a2d%4]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 03:21:46 +0000
From: TracyMg_Li@outlook.com
To: trini@konsulko.com
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, festevam@gmail.com,
 patrick.delaunay@foss.st.com, tharvey@gateworks.com, pbrobinson@gmail.com,
 weichangzheng@phytium.com.cn, hs@denx.de, d-gerlach@ti.com,
 u-boot@lists.denx.de, robh+dt@kernel.org,
 TracyMg_Li <TracyMg_Li@outlook.com>
Subject: [PATCH V4] ARM add initial support for the Phytium Pe2201 Board.
Date: Mon, 25 Dec 2023 11:21:34 +0800
Message-ID: <TYSPR01MB58854E5328ACD3462C60E612F199A@TYSPR01MB5885.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [bW8jDBec0q4IDZ+bj4yz+dIiIDa9WoBd]
X-ClientProxiedBy: TYCPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:405:1::31) To TYSPR01MB5885.apcprd01.prod.exchangelabs.com
 (2603:1096:400:468::10)
X-Microsoft-Original-Message-ID: <20231225032134.12229-1-TracyMg_Li@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR01MB5885:EE_|TY0PR0101MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: e40250c4-5f69-49cd-598a-08dc04f89fdb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dl52MwiDASZZkJi1f8Qz/kyRXRrN87pcQ7Wh1Qm6C6tMb222x51hnGAivlNDeTJeMy1ZhsmnjE8WBN9bdEi3pU5ph4gjtGl+6zyL9SnCGJ7+rcRg35XmUwrheAvU+Az55hseKc9aukHzxsOgABaH0MthacWn7C/wUN6FWwK/RQalRVRUT0iAuz09bIVR6xlYa/17ybr7zJsQh+xgYbi+P/hHOJ2Ql2S7YeFwHpcjyF6YGyep09FNwMLzUUtnO92vT8hsPa4FU/qti01ZeWiXMy5A1wTLJ3pmDbujxjXj7GUIjZ2K0qBde1+FJp7qjYY6ten5FypC47gfmcIgwqgDmJF33mVApgFYQLtgSPIMHf87p+YLOMGJcmiq0yG7d7h8LZ3VHXOZjndQsaelOXASqKyBhW4nxP6xj+nNIEpKDpoS1AzLcjDpbErjSh+qDsrheAcOA5uT1QsoKztd2AiCBsF0yzAttNRDpF112zUCXD/tQ/DkS2s91Y1m/zAkOftCjutr7Cl9ee5oKx1/6TmP6Lvj99kXMyCJw/91wFrT5rRkGGVgGmlNc7EFUNZTKrOYdxRDTTu7AlJwbHdLxSXMHV+bENP4TSKD3x29GWBFQbK/3w/eakG6Da+FTiDRvdUU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mE+0QpzOQ24ArIIu5miklTcfYG3RNjvtC0CRQL/ATRpX11mXRsf7oQIjuRIK?=
 =?us-ascii?Q?7kQI/LeGcYKJKxRdgbKG44hxnZmru4jmTY9kV1j6zzjZQXK1ZarWzPz7yp80?=
 =?us-ascii?Q?YOLAPM/hgvGxhEe4R2ZR7mG6DbDK2p2g98w1do9Ux5po7bCmSjqpBGluMWqs?=
 =?us-ascii?Q?jzp46OYb9/yeWri7kS6iY9oBiynqRYXqmDWuMt2DTnMY19cU+xHIB9m96XSA?=
 =?us-ascii?Q?XaP2B3VLbSUk0XhbSjmIsO3c9jTCF23oV1Y0joSKDk/6Euqc1Cz7waU+Rbui?=
 =?us-ascii?Q?INVEr1FbO3s44tXmeDHuwJOXcr/mV22djiPQSwFboVrCd90EYev5Y/aLKP6s?=
 =?us-ascii?Q?TAeQjfXQfzo1JToCh3mm3eu2PUXttxI/b7wHHmYAwdS9dOTPmmLCj4s02182?=
 =?us-ascii?Q?A4552EJ/L+CGaPzInl4UO0nSWdxu2zVSWISroOt90AzHGPQwpCPBQkRW+d9Y?=
 =?us-ascii?Q?wxmA9VdOLRl9MIUe6xlZQyV+H8uQKz1jtM01yOsPZWQcsmDe2lxfZxFLlPAZ?=
 =?us-ascii?Q?xMXntGAWP1gSHas3/4PL0ZGP3+Y5dqCPzwED6r+WLq5UXbcuElZOg83PC4D3?=
 =?us-ascii?Q?3cw8w1sUQJSjRj79FBIhzpSgEmZMMQN8NOhDxybDVsz+VAUgLEOuWJUZ+o9C?=
 =?us-ascii?Q?NYi0L7XT2KOA15Ll8aBRKkf3wbHgboG1puViC3n60AU8J/yS66NksmRHlE2u?=
 =?us-ascii?Q?rfVlOCjrZC0moilbr84kQ/p0YPeiWB394rxKq4v4pqfSgaZvwcuI6Oi2/22A?=
 =?us-ascii?Q?Y/Q3G8Y/xlWO9mLLDWMxd7PXJlcIik8p3c18bXe8toT6exY3evf7t1NDYo+x?=
 =?us-ascii?Q?SSvQibdoXKHqR62GAt27zWFGfb4dXzgiuOymtk+Cumv2TGtLSPRUIMt/vzka?=
 =?us-ascii?Q?bXIkaZkGCVbZYn0QQ600Hg5o04k3b3/OxELDxMK1dKZq4pKQMB7Raz2RG7OV?=
 =?us-ascii?Q?BXlOFgjbV5MJPbhdhcxYWCJEVdG71xk8nAodY3wmIxeJZ3S5i1smiMMhGM6w?=
 =?us-ascii?Q?f3z/TiSChplbKSRvgQ3HIktHxf7+BJhXWYxpsGvBmMsRibPDYWDEXxZkbL62?=
 =?us-ascii?Q?v3r9tjSPAFTAHmWeBf06ciUmiHyzodj1TK4A25rpmnyrPnTG7O54un2ie1Oz?=
 =?us-ascii?Q?n3VtvFDBPgV9kXVjRDSf1+KhVV88u1s3a1vH/qmyHxj/R4kEs3SFNvByekSS?=
 =?us-ascii?Q?DJXsaeADwyR0AX6ENeA/yx5YPBay561MXHxFLPU3ek8aTIU9NUhYCMAUrE4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40250c4-5f69-49cd-598a-08dc04f89fdb
X-MS-Exchange-CrossTenant-AuthSource: TYSPR01MB5885.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 03:21:46.4912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4239
X-Mailman-Approved-At: Mon, 25 Dec 2023 13:30:11 +0100
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

From: TracyMg_Li <TracyMg_Li@outlook.com>

Add pe2201 platform code and the device tree of pe2201 platform board.
The initial support comprises the UART and PCIe.

Signed-off-by: TracyMg_Li <TracyMg_Li@outlook.com>
Changes since v1:
        fix space corrupt.
Changes since v2:
        switch to bootstd and text environment.
Changes since v3:
        add environment variables.
---
 arch/arm/Kconfig                 |   7 ++
 arch/arm/dts/Makefile            |   1 +
 arch/arm/dts/phytium-pe2201.dts  |  43 +++++++
 board/phytium/pe2201/Kconfig     |  12 ++
 board/phytium/pe2201/MAINTAINERS |   8 ++
 board/phytium/pe2201/Makefile    |  12 ++
 board/phytium/pe2201/cpu.h       |  64 +++++++++++
 board/phytium/pe2201/ddr.c       | 190 +++++++++++++++++++++++++++++++
 board/phytium/pe2201/pcie.c      |  60 ++++++++++
 board/phytium/pe2201/pe2201.c    |  92 +++++++++++++++
 board/phytium/pe2201/pe2201.env  |  25 ++++
 board/phytium/pe2201/pll.c       |  75 ++++++++++++
 board/phytium/pe2201/sec.c       |  37 ++++++
 configs/pe2201_defconfig         |  42 +++++++
 include/configs/pe2201.h         |  16 +++
 15 files changed, 684 insertions(+)
 create mode 100644 arch/arm/dts/phytium-pe2201.dts
 create mode 100644 board/phytium/pe2201/Kconfig
 create mode 100644 board/phytium/pe2201/MAINTAINERS
 create mode 100644 board/phytium/pe2201/Makefile
 create mode 100644 board/phytium/pe2201/cpu.h
 create mode 100644 board/phytium/pe2201/ddr.c
 create mode 100644 board/phytium/pe2201/pcie.c
 create mode 100644 board/phytium/pe2201/pe2201.c
 create mode 100644 board/phytium/pe2201/pe2201.env
 create mode 100644 board/phytium/pe2201/pll.c
 create mode 100644 board/phytium/pe2201/sec.c
 create mode 100644 configs/pe2201_defconfig
 create mode 100644 include/configs/pe2201.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c98..358c515a93 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2060,6 +2060,12 @@ config TARGET_POMELO
 	   Support for pomelo platform.
 	   It has 8GB Sdram, uart and pcie.
 
+config TARGET_PE2201
+	bool "Support Phytium PE2201 Platform"
+	select ARM64
+	help
+	  Support for pe2201 platform.It has 2GB Sdram, uart and pcie.
+
 config TARGET_PRESIDIO_ASIC
 	bool "Support Cortina Presidio ASIC Platform"
 	select ARM64
@@ -2336,6 +2342,7 @@ source "board/variscite/dart_6ul/Kconfig"
 source "board/vscom/baltos/Kconfig"
 source "board/phytium/durian/Kconfig"
 source "board/phytium/pomelo/Kconfig"
+source "board/phytium/pe2201/Kconfig"
 source "board/xen/xenguest_arm64/Kconfig"
 
 source "arch/arm/Kconfig.debug"
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 5fc888680b..ce2fc626b0 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1469,6 +1469,7 @@ dtb-$(CONFIG_TARGET_TOTAL_COMPUTE) += total_compute.dtb
 
 dtb-$(CONFIG_TARGET_DURIAN) += phytium-durian.dtb
 dtb-$(CONFIG_TARGET_POMELO) += phytium-pomelo.dtb
+dtb-$(CONFIG_TARGET_PE2201) += phytium-pe2201.dtb
 
 dtb-$(CONFIG_TARGET_PRESIDIO_ASIC) += ca-presidio-engboard.dtb
 
diff --git a/arch/arm/dts/phytium-pe2201.dts b/arch/arm/dts/phytium-pe2201.dts
new file mode 100644
index 0000000000..959584fbbb
--- /dev/null
+++ b/arch/arm/dts/phytium-pe2201.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  dts file for Phytium pe2201 board
+ *  Copyright (C) 2023, Phytium Technology Co., Ltd.
+ *	lixinde			<lixinde@phytium.com.cn>
+ *	weichangzheng	<weichangzheng@phytium.com.cn>
+ */
+/dts-v1/;
+
+/ {
+	model = "Phytium pe2201 Board";
+	compatible = "phytium,pe2201";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	uart0: serial@2800c000 {
+	compatible = "arm,pl011", "arm,primecell";
+		reg = <0x0 0x2800c000 0x0 0x1000>;
+		clock = <100000000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		pcie@40000000 {
+			compatible = "pci-host-ecam-generic";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0x0 0x40000000 0x0 0x10000000>;
+			ranges = <0x01000000 0x00 0x00000000 0x0 0x50000000 0x0 0x00F00000>,
+			<0x02000000 0x00 0x58000000 0x0 0x58000000 0x0 0x28000000>,
+			<0x43000000 0x10 0x00000000 0x10 0x00000000 0x10 0x00000000>;
+		};
+	};
+};
diff --git a/board/phytium/pe2201/Kconfig b/board/phytium/pe2201/Kconfig
new file mode 100644
index 0000000000..f2f222b5d3
--- /dev/null
+++ b/board/phytium/pe2201/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_PE2201
+
+config SYS_BOARD
+	default "pe2201"
+
+config SYS_VENDOR
+	default "phytium"
+
+config SYS_CONFIG_NAME
+	default "pe2201"
+
+endif
diff --git a/board/phytium/pe2201/MAINTAINERS b/board/phytium/pe2201/MAINTAINERS
new file mode 100644
index 0000000000..f583d631d2
--- /dev/null
+++ b/board/phytium/pe2201/MAINTAINERS
@@ -0,0 +1,8 @@
+PE2201 BOARD
+M:	lixinde <lixinde@phytium.com.cn>
+M:	weichangzheng <weichangzheng@phytium.com.cn>
+S:	Maintained
+F:	board/phytium/pe2201/*
+F:	include/configs/pe2201.h
+F:	configs/pe2201_defconfig
+F:	arch/arm/dts/phytium-pe2201.dts
diff --git a/board/phytium/pe2201/Makefile b/board/phytium/pe2201/Makefile
new file mode 100644
index 0000000000..5350f0f818
--- /dev/null
+++ b/board/phytium/pe2201/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023, Phytium Technology Co., Ltd.
+# lixinde		<lixinde@phytium.com.cn>
+# weichangzheng	<weichangzheng@phytium.com.cn>
+#
+
+obj-y	+= pe2201.o
+obj-y	+= pll.o
+obj-y	+= pcie.o
+obj-y	+= ddr.o
+obj-y	+= sec.o
diff --git a/board/phytium/pe2201/cpu.h b/board/phytium/pe2201/cpu.h
new file mode 100644
index 0000000000..01adbb0a17
--- /dev/null
+++ b/board/phytium/pe2201/cpu.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#ifndef _FT_PE2201_H
+#define _FT_PE2201_H
+
+/* SMCCC ID */
+#define CPU_SVC_VERSION             0xC2000F00
+#define CPU_GET_RST_SOURCE          0xC2000F01
+#define CPU_INIT_PLL                0xC2000F02
+#define CPU_INIT_PCIE               0xC2000F03
+#define CPU_INIT_MEM                0xC2000F04
+#define CPU_INIT_SEC_SVC            0xC2000F05
+
+/* CPU RESET */
+#define CPU_RESET_POWER_ON          0x1
+#define CPU_RESET_PLL               0x4
+#define CPU_RESET_WATCH_DOG         0x8
+
+/* PLL */
+#define PARAMETER_PLL_MAGIC         0x54460020
+
+/* PCIE */
+#define PARAMETER_PCIE_MAGIC        0x54460021
+#define CFG_INDEPENDENT_TREE        0x0
+#define PCI_PEU0                    0x1
+#define PCI_PEU1                    0x1
+#define PEU1_OFFSET                 16
+#define PEU_C_OFFSET_MODE           16
+#define PEU_C_OFFSET_SPEED          0
+#define X1X1X1X1                    0x2
+#define X1X1                        0x0
+#define EP_MODE                     0x0
+#define RC_MODE                     0x1
+#define GEN3                        3
+
+/* DDR */
+#define PARAMETER_MCU_MAGIC         0x54460024
+#define PARAM_MCU_VERSION           0x3
+#define PARAM_MCU_SIZE              0x100
+#define PARAM_CH_ENABLE             0x1
+
+#define RDIMM_TYPE                  0x1
+#define UDIMM_TYPE                  0x2
+#define LPDDR4_TYPE                 0x10
+#define DIMM_X8                     0x1
+#define DIMM_X16                    0x2
+#define NO_MIRROR                   0x0
+#define NO_ECC_TYPE                 0
+#define DDR4_TYPE                   0xC
+
+/* SEC */
+#define PARAMETER_COMMON_MAGIC      0x54460013
+
+void ddr_init(void);
+void sec_init(void);
+void check_reset(void);
+void pcie_init(void);
+
+#endif /* _FT_PE2201_H */
diff --git a/board/phytium/pe2201/ddr.c b/board/phytium/pe2201/ddr.c
new file mode 100644
index 0000000000..549d211ccd
--- /dev/null
+++ b/board/phytium/pe2201/ddr.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#include <stdio.h>
+#include <linux/arm-smccc.h>
+#include <init.h>
+#include "cpu.h"
+
+struct ddr_spd {
+	/***************** read from spd ******************/
+	u8 dimm_type;        /* 1: RDIMM;	2: UDIMM;	3: SODIMM;	4: LRDIMM */
+	u8 data_width;       /* 0: x4;		1: x8;		2: x16;		3: x32 */
+	u8 mirror_type;      /* 0: standard;	1: mirror */
+	u8 ecc_type;         /* 0: no-ecc;	1: ecc */
+	u8 dram_type;        /* 0xB: DDR3;	0xC: DDR4 */
+	u8 rank_num;
+	u8 row_num;
+	u8 col_num;
+
+	u8 bg_num;           /* DDR4/DDR5 */
+	u8 bank_num;
+	u16 module_manufacturer_id;
+	u16 taamin;
+	u16 trcdmin;
+
+	u16 trpmin;
+	u16 trasmin;
+	u16 trcmin;
+	u16 tfawmin;         /* only DDR3/DDR4 */
+
+	u16 trrd_smin;       /* only DDR4 */
+	u16 trrd_lmin;       /* only DDR4 */
+	u16 tccd_lmin;       /* only DDR4 */
+	u16 twrmin;
+
+	u16 twtr_smin;       /* only DDR4 */
+	u16 twtr_lmin;       /* only DDR4 */
+	u32 trfc1min;
+
+	u32 trfc2min;
+	u32 trfc4_rfcsbmin;  /* DDR4: tRFC4min;	DDR5: tRFCsbmin */
+	u8 resv[8];
+
+	/***************** RCD control words ******************/
+	u8 f0rc03;           /* bit[3:2]:CS	bit[1:0]:CA */
+	u8 f0rc04;           /* bit[3:2]:ODT  bit[1:0]:CKE */
+	u8 f0rc05;           /* bit[3:2]:CLK-A side  bit[1:0]:CLK-B side */
+	u8 rcd_num;          /* Registers used on RDIMM */
+
+	u8 lrdimm_resv[4];
+	u8 lrdimm_resv1[8];
+	u8 lrdimm_resv2[8];
+} __attribute((aligned(4)));
+
+struct mcu_config {
+	u32 magic;
+	u32 version;
+	u32 size;
+	u8 rev1[4];
+
+	u8 ch_enable;
+	u8 resv1[7];
+
+	u64 misc_enable;
+
+	u8 train_debug;
+	u8 train_recover;
+	u8 train_param_type;
+	u8 train_param_1;    /* DDR4: cpu_odt */
+	u8 train_param_2;    /* DDR4: cpu_drv */
+	u8 train_param_3;    /* DDR4: mr_drv */
+	u8 train_param_4;    /* DDR4: rtt_nom */
+	u8 train_param_5;    /* DDR4: rtt_park */
+
+	u8 train_param_6;    /* DDR4: rtt_wr */
+	u8 resv2[7];
+
+	/***************** for LPDDR4 dq swap ******************/
+	u32 data_byte_swap;
+	u32 slice0_dq_swizzle;
+
+	u32 slice1_dq_swizzle;
+	u32 slice2_dq_swizzle;
+
+	u32 slice3_dq_swizzle;
+	u32 slice4_dq_swizzle;
+
+	u32 slice5_dq_swizzle;
+	u32 slice6_dq_swizzle;
+
+	u32 slice7_dq_swizzle;
+	u8 resv3[4];
+	u8 resv4[8];
+
+	struct ddr_spd ddr_spd_info;
+} __attribute((aligned(4)));
+
+static void get_mcu_up_info_default(struct mcu_config *pm)
+{
+	pm->magic		= PARAMETER_MCU_MAGIC;
+	pm->version		= PARAM_MCU_VERSION;
+	pm->size		= PARAM_MCU_SIZE;
+	pm->ch_enable	= PARAM_CH_ENABLE;
+}
+
+static u8 init_dimm_param(struct mcu_config *pm)
+{
+	debug("manual config dimm info...\n");
+	pm->misc_enable = 0x2001;
+	pm->train_debug = 0x0;
+	pm->train_recover = 0x0;
+	pm->train_param_type = 0x0;
+	pm->train_param_1 = 0x0;
+	pm->train_param_2 = 0x0;
+	pm->train_param_3 = 0x0;
+	pm->train_param_4 = 0x0;
+	pm->train_param_5 = 0x0;
+	pm->train_param_6 = 0x0;
+
+	pm->data_byte_swap = 0x76543210;
+	pm->slice0_dq_swizzle = 0x3145726;
+
+	pm->slice1_dq_swizzle = 0x54176230;
+	pm->slice2_dq_swizzle = 0x57604132;
+
+	pm->slice3_dq_swizzle = 0x20631547;
+	pm->slice4_dq_swizzle = 0x16057423;
+
+	pm->slice5_dq_swizzle = 0x16057423;
+	pm->slice6_dq_swizzle = 0x16057423;
+
+	pm->slice7_dq_swizzle = 0x16057423;
+
+	pm->ddr_spd_info.dimm_type = RDIMM_TYPE;
+	pm->ddr_spd_info.data_width = DIMM_X16;
+	pm->ddr_spd_info.mirror_type = NO_MIRROR;
+	pm->ddr_spd_info.ecc_type = NO_ECC_TYPE;
+	pm->ddr_spd_info.dram_type = LPDDR4_TYPE;
+	pm->ddr_spd_info.rank_num = 0x1;
+	pm->ddr_spd_info.row_num = 0x10;
+	pm->ddr_spd_info.col_num = 0xa;
+	pm->ddr_spd_info.bg_num = 0x0;
+	pm->ddr_spd_info.bank_num = 0x8;
+	pm->ddr_spd_info.taamin = 0x0;
+	pm->ddr_spd_info.trcdmin = 0x0;
+
+	pm->ddr_spd_info.trpmin = 0x0;
+	pm->ddr_spd_info.trasmin = 0x0;
+	pm->ddr_spd_info.trcmin = 0x0;
+	pm->ddr_spd_info.tfawmin = 0x0;
+
+	pm->ddr_spd_info.trrd_smin = 0x0;
+	pm->ddr_spd_info.trrd_lmin = 0x0;
+	pm->ddr_spd_info.tccd_lmin = 0x0;
+	pm->ddr_spd_info.twrmin = 0x0;
+
+	pm->ddr_spd_info.twtr_smin = 0x0;
+	pm->ddr_spd_info.twtr_lmin = 0x0;
+
+	return 0;
+}
+
+void get_default_mcu_info(u8 *data)
+{
+	get_mcu_up_info_default((struct mcu_config *)data);
+}
+
+void fix_mcu_info(u8 *data)
+{
+	struct mcu_config *mcu_info = (struct mcu_config *)data;
+
+	init_dimm_param(mcu_info);
+}
+
+void ddr_init(void)
+{
+	u8 buffer[0x100];
+	struct arm_smccc_res res;
+
+	get_default_mcu_info(buffer);
+	fix_mcu_info(buffer);
+
+	arm_smccc_smc(CPU_INIT_MEM, 0, (u64)buffer, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0)
+		panic("DRAM init failed :0x%lx\n", res.a0);
+}
diff --git a/board/phytium/pe2201/pcie.c b/board/phytium/pe2201/pcie.c
new file mode 100644
index 0000000000..34c38d2aee
--- /dev/null
+++ b/board/phytium/pe2201/pcie.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <linux/arm-smccc.h>
+#include <init.h>
+#include "cpu.h"
+
+struct pcu_ctr {
+	u32 base_config[4];
+	u32 equalization[4];
+	u8 rev[72];
+} __attribute((aligned(4)));
+
+struct pcu_config {
+	u32 magic;
+	u32 version;
+	u32 size;
+	u8 rev1[4];
+	u32 independent_tree;
+	u32 base_cfg;
+	u8 rev2[16];
+	struct pcu_ctr ctr_cfg[2];
+} __attribute((aligned(4)));
+
+struct pcu_config const peu_base_info = {
+	.magic = PARAMETER_PCIE_MAGIC,
+	.version = 0x4,
+	.size = 0x100,
+	.independent_tree = CFG_INDEPENDENT_TREE,
+	.base_cfg = ((PCI_PEU1 | (X1X1X1X1 << 1)) << PEU1_OFFSET | (PCI_PEU0 | (X1X1 << 1))),
+	.ctr_cfg[0].base_config[0] = (EP_MODE << PEU_C_OFFSET_MODE) | (GEN3 << PEU_C_OFFSET_SPEED),
+	.ctr_cfg[0].base_config[1] = (EP_MODE << PEU_C_OFFSET_MODE) | (GEN3 << PEU_C_OFFSET_SPEED),
+	.ctr_cfg[0].base_config[2] = (EP_MODE << PEU_C_OFFSET_MODE) | (GEN3 << PEU_C_OFFSET_SPEED),
+	.ctr_cfg[1].base_config[0] = (EP_MODE << PEU_C_OFFSET_MODE) | (GEN3 << PEU_C_OFFSET_SPEED),
+	.ctr_cfg[1].base_config[1] = (EP_MODE << PEU_C_OFFSET_MODE) | (GEN3 << PEU_C_OFFSET_SPEED),
+	.ctr_cfg[1].base_config[2] = (EP_MODE << PEU_C_OFFSET_MODE) | (GEN3 << PEU_C_OFFSET_SPEED),
+	.ctr_cfg[0].equalization[0] = 0x7,
+	.ctr_cfg[0].equalization[1] = 0x7,
+	.ctr_cfg[0].equalization[2] = 0x7,
+	.ctr_cfg[1].equalization[0] = 0x7,
+	.ctr_cfg[1].equalization[1] = 0x7,
+	.ctr_cfg[1].equalization[2] = 0x7,
+};
+
+void pcie_init(void)
+{
+	u8 buffer[0x100];
+	struct arm_smccc_res res;
+
+	memcpy(buffer, &peu_base_info, sizeof(peu_base_info));
+	arm_smccc_smc(CPU_INIT_PCIE, 0, (u64)buffer, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0)
+		panic("PCIE init failed :0x%lx\n", res.a0);
+}
diff --git a/board/phytium/pe2201/pe2201.c b/board/phytium/pe2201/pe2201.c
new file mode 100644
index 0000000000..0e837b0f50
--- /dev/null
+++ b/board/phytium/pe2201/pe2201.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#include <stdio.h>
+#include <command.h>
+#include <init.h>
+#include <asm/armv8/mmu.h>
+#include <asm/io.h>
+#include <linux/arm-smccc.h>
+#include <scsi.h>
+#include <asm/u-boot.h>
+#include "cpu.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int mach_cpu_init(void)
+{
+	check_reset();
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	pcie_init();
+	return 0;
+}
+
+int dram_init(void)
+{
+	debug("Phytium ddr init\n");
+	ddr_init();
+
+	gd->mem_clk = 0;
+	gd->ram_size = PHYS_SDRAM_1_SIZE;
+
+	sec_init();
+	debug("PBF relocate done\n");
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	struct arm_smccc_res res;
+
+	debug("run in reset cpu\n");
+	arm_smccc_smc(0x84000009, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0)
+		panic("reset cpu error, %lx\n", res.a0);
+}
+
+static struct mm_region pe2201_mem_map[] = {
+	{
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) | PTE_BLOCK_NON_SHARE | PTE_BLOCK_PXN
+	},
+	{
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = 0x7b000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_NS | PTE_BLOCK_INNER_SHARE
+	},
+	{
+		0,
+	}
+};
+
+struct mm_region *mem_map = pe2201_mem_map;
+
+int last_stage_init(void)
+{
+	return 0;
+}
diff --git a/board/phytium/pe2201/pe2201.env b/board/phytium/pe2201/pe2201.env
new file mode 100644
index 0000000000..d57b82d23b
--- /dev/null
+++ b/board/phytium/pe2201/pe2201.env
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ */
+
+/* Initial environment variables */
+
+image=Image
+scriptaddr=0x90100000
+script_offset_f=0xc00000
+script_size_f=0x2000
+kernel_addr_r=0x90200000
+fdt_addr_r=0x90000000
+boot_fit=no
+fdtfile=phytium-pe2201.dtb
+ft_fdt_name=boot/dtb/pe2201.dtb
+fdtoverlay_addr_r=0x95100000
+kernel_comp_addr_r=0x96000000
+kernel_comp_size=0x2000000
+pxefile_addr_r=0x9A000000
+ramdisk_addr_r=0x95000000
+load_kernel=ext4load scsi 0:2 $kernel_addr_r boot/uImage-2004
+load_initrd=ext4load scsi 0:2 $ramdisk_addr_r initrd.img-4.19.0.pe2201
+load_fdt=ext4load scsi 0:2 $fdt_addr_r $ft_fdt_name
+distro_bootcmd=run load_kernel; run load_initrd; run load_fdt; run boot_os
diff --git a/board/phytium/pe2201/pll.c b/board/phytium/pe2201/pll.c
new file mode 100644
index 0000000000..f46435c74b
--- /dev/null
+++ b/board/phytium/pe2201/pll.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <asm/io.h>
+#include <linux/arm-smccc.h>
+#include <init.h>
+#include "cpu.h"
+
+struct pll_config {
+	u32 magic;
+	u32 version;
+	u32 size;
+	u8 rev1[4];
+	u32 clust0_pll;
+	u32 clust1_pll;
+	u32 clust2_pll;
+	u32 noc_pll;
+	u32 dmu_pll;
+} __attribute((aligned(4)));
+
+struct pll_config const pll_base_info = {
+	.magic = PARAMETER_PLL_MAGIC,
+	.version = 0x2,
+	.size = 0x100,
+	.clust0_pll = 2000,
+	.clust1_pll = 2000,
+	.clust2_pll = 2000,
+	.noc_pll = 1800,
+	.dmu_pll = 600,
+};
+
+u32 get_reset_source(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(CPU_GET_RST_SOURCE, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+void pll_init(void)
+{
+	u8 buffer[0x100];
+	struct arm_smccc_res res;
+
+	memcpy(buffer, &pll_base_info, sizeof(pll_base_info));
+	arm_smccc_smc(CPU_INIT_PLL, 0, (u64)buffer, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0)
+		panic("PLL init failed :0x%lx\n", res.a0);
+}
+
+void check_reset(void)
+{
+	u32 rst;
+
+	rst = get_reset_source();
+
+	switch (rst) {
+	case CPU_RESET_POWER_ON:
+		pll_init();
+		break;
+	case CPU_RESET_PLL:
+		break;
+	case CPU_RESET_WATCH_DOG:
+		break;
+	default:
+		panic("other reset source\n");
+	}
+}
diff --git a/board/phytium/pe2201/sec.c b/board/phytium/pe2201/sec.c
new file mode 100644
index 0000000000..6a980d6ea6
--- /dev/null
+++ b/board/phytium/pe2201/sec.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <linux/arm-smccc.h>
+#include <init.h>
+#include "cpu.h"
+
+struct common_config {
+	u32 magic;
+	u32 version;
+	u32 size;
+	u8 rev1[4];
+	u64 core_bit_map;
+} __attribute((aligned(4)));
+
+struct common_config const common_base_info = {
+	.magic = PARAMETER_COMMON_MAGIC,
+	.version = 0x1,
+	.core_bit_map = 0x3333,
+};
+
+void sec_init(void)
+{
+	u8 buffer[0x100];
+	struct arm_smccc_res res;
+
+	memcpy(buffer, &common_base_info, sizeof(common_base_info));
+	arm_smccc_smc(CPU_INIT_SEC_SVC, 0, (u64)buffer, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0)
+		panic("SEC init failed :0x%lx\n", res.a0);
+}
diff --git a/configs/pe2201_defconfig b/configs/pe2201_defconfig
new file mode 100644
index 0000000000..e6b9cef4cd
--- /dev/null
+++ b/configs/pe2201_defconfig
@@ -0,0 +1,42 @@
+CONFIG_ARM=y
+CONFIG_ARM_SMCCC=y
+CONFIG_TARGET_PE2201=y
+CONFIG_TEXT_BASE=0x38180000
+CONFIG_SYS_MALLOC_LEN=0x101000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x30c1a000
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="phytium-pe2201"
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_PSCI_RESET is not set
+CONFIG_AHCI=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="earlycon=pl011,0x2800c000 root=/dev/sda2 rw"
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_LAST_STAGE_INIT=y
+CONFIG_SYS_PROMPT="pe2201#"
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_PCI=y
+CONFIG_CMD_DM=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+CONFIG_DM=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_BLK=y
+# CONFIG_MMC is not set
+CONFIG_PCI=y
+CONFIG_DM_PCI=y
+CONFIG_PCI_PHYTIUM=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
+CONFIG_DM_SERIAL=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_CMD_BOOTMETH=y
diff --git a/include/configs/pe2201.h b/include/configs/pe2201.h
new file mode 100644
index 0000000000..80f8f17bcd
--- /dev/null
+++ b/include/configs/pe2201.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023, Phytium Technology Co., Ltd.
+ * lixinde          <lixinde@phytium.com.cn>
+ * weichangzheng    <weichangzheng@phytium.com.cn>
+ */
+
+#ifndef __PE2201_CONFIG_H
+#define __PE2201_CONFIG_H
+
+/* SDRAM Bank #1 start address */
+#define PHYS_SDRAM_1            0x80000000
+#define PHYS_SDRAM_1_SIZE       0x74000000
+#define CFG_SYS_SDRAM_BASE      PHYS_SDRAM_1
+
+#endif
-- 
2.17.1

