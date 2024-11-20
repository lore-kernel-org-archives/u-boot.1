Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA851D711C2
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10BE89350;
	Wed, 20 Nov 2024 17:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="kaCN5sNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2FA892DE; Wed, 20 Nov 2024 17:32:08 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1F7892DE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEswNEDo48+/H6n3Oj3poGaepOzstsSb3ehQoF2XNLE4+htU+OpnIQSBrJclgHOpQVYXImZFZwgg+Sj2sm0W3zv4W4ANifLQGjgIdS3L9TvMESS2nbJ2kwl5liRHnY0/nbeDCiiM3RGQBDtyBP/z1Ki0Ujp5wnINi0iYZkp49GxPIZ6vDAOSCm8dsYHvQ6ycF9uz/k8X31XeQHmrcuBMc6yukoTJ8SMm7g58wt6z1N7zx9id/oZnspdv0PB0w1uBxMC6Mse52+nq3k1e74p46tB+15hXQn7sF76FJ830aR6DlWqdbcSAh5WRjvvOu1Jt1H10KqlPwaIbjizra3hJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su593o1f/l8PXr6t8PVY5GiHOFCNY5LHDVtVFm3dciE=;
 b=VZ+cAYmvCXKm57LB82bp8cpRtucDomiXO/hjCq6xYHhZEkBuurFQRR/m9eOajfUrvGR2OveRqATd/iJAo4P5V6fMZQus2sjEN6phlOysd6UZUx2RlS7QEgE45ix6gjNBVnxCeQnckuEn6Nf74c3mwi9XB/j+5gYXeZBARmVuHkd7p1EdO3EhZYmxht67ymbE6HUfKC0m1TadkwB0CSDIIrJal0TJvu/Lmn5QtnBAsadzKxRfWBXOSmfwLhoa2a3jcmcm33A2IfPIPg9WcIhDXWKX6QF1Zs+6LjanMc4lEhF8/LJiaEEaGNBWUi1mVmhh/rn7psUc1dvFrHj+ias4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su593o1f/l8PXr6t8PVY5GiHOFCNY5LHDVtVFm3dciE=;
 b=kaCN5sNrlifpTcPsqrN7tHMm9/U+AZUjuH1QQbg1Hjmzryl160JWPMVCuS0QG6P9a8UWLaTMWfU9KH6jfWuTipvKnT9lS1U+nxGI8kwAg2aycc/TrllKdgd/oShXwSTcWXPq4gy1vVuyaPE1pi7ySCrA1W3JcKAroulzaKZTMU8=
Received: from AS9PR06CA0353.eurprd06.prod.outlook.com (2603:10a6:20b:466::30)
 by DBAP195MB0858.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 16:32:03 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::d4) by AS9PR06CA0353.outlook.office365.com
 (2603:10a6:20b:466::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 16:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 16:32:03 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 17:32:02 +0100
Received: from llp-stoidner.fritz.box (172.25.39.157) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 17:32:02 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <y.moog@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej
 <andrej.picej@norik.com>
Subject: [PATCH v4 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Date: Wed, 20 Nov 2024 17:31:42 +0100
Message-ID: <20241120163143.127862-3-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120163143.127862-1-c.stoidner@phytec.de>
References: <20241120163143.127862-1-c.stoidner@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|DBAP195MB0858:EE_
X-MS-Office365-Filtering-Correlation-Id: 9344bf81-09dc-40d4-3ca8-08dd0980dd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LpADNJpXBzCKiLi7gLlV9L3L7ztonQyi8qGbuon8Jf/5IENmgnMYS6jZlCuz?=
 =?us-ascii?Q?cuAFQ955nVjII92aHiphLhfKmj85OlVDRj6MX9EwX0zj6RtP8CTQaJQMwpQ3?=
 =?us-ascii?Q?p9swalyRqhmyEKFi6EmONDAcCyRCdCBF3W5xq+vPSTqzHk/H6+iEcGbn85O5?=
 =?us-ascii?Q?zWOmdjEpn7uMAba+tecSpoafoxId0WED9hShikMpzGYzjw01ZV1X48PBzbKL?=
 =?us-ascii?Q?O6Iw3FPVo8oz9o/wrCiz0ql0DbLyLX1nu0KyQYl9NcfIG7EZF48oX8CFIEq5?=
 =?us-ascii?Q?QDZMPuZ1ucd9eU4EfXGBIK9b3Y4Vgfyjwlmhk8JVU4ciF3W1V9zoRcLesiHA?=
 =?us-ascii?Q?+tt0C4vPrNSXxUxQtr3QvB+QtJLtBhhp58LHxXVqm3ltzC3ly3vHUZzcZkHy?=
 =?us-ascii?Q?Rjl+Z5f677ssVhdb/Tpnx4zHtNl3pyHszBUzFlEJ2ygFuQGO+Uo7SlxZ1twt?=
 =?us-ascii?Q?m0yhZ7SigpCjvzXQ7M1wz+1qvPxz5OBhc8qB8tOI4qE9ePIFDdp5R7GX+yc/?=
 =?us-ascii?Q?zk/goYCyp9as0ZUaxRsEnFLk9xKwosKdM6kERFKte2fJuxIECppUb+h8FQSy?=
 =?us-ascii?Q?QJdpfM+g7sIHeMT2UfS13MkTju1NapHBAySGazc3zR1r22HDRxk8ZPvbpuZe?=
 =?us-ascii?Q?HqKpAr0vS2zPW8v18S7gTJFi9dINmtxLH+fXhEaZjRH8P8z8YvjfGehtmWC7?=
 =?us-ascii?Q?Ph5Pi/HhtlMnm7XYq3nvSmMo4OmAWZBh0XCWVF4HmZSIYhTorjzaWZpukk0f?=
 =?us-ascii?Q?WFjGinTQSeZZCSPrFiistYW3ghP9yC86z0P3tplf5NBDY4xR4RREt2j5XMFX?=
 =?us-ascii?Q?HvK5G6x/9ZfYXux11CswRteuSzwpFPm1XupTbaAL+8VWZ6zZL9ZuaB5A2bbk?=
 =?us-ascii?Q?reN4TUDYIzWt9SouL/ABQ83yfqoyrO6U2/NmgB2AYncTUEjZrd5N1vRL0lCu?=
 =?us-ascii?Q?JOYsVfykW+WpxkqqiMge5tyiHRSEcg2blzpNuge9DLAMKRjn89EYVWnC0CDZ?=
 =?us-ascii?Q?pSdlij7wyHd0XHvZQGXBpD3zdEoiHder4z7qB+VszK4UhZG+AW4J9EfEnP2L?=
 =?us-ascii?Q?MMorZV9x23q6+2WgDxpt07MeFd2SznRxB45DEBQiqWfS5Ore9ztzkc4bQSpg?=
 =?us-ascii?Q?RaP4Qte45WgruiVpgcgMqd5ps2QwsTE67fjTvROb6EFAyoNTpY9gMhj/HQr0?=
 =?us-ascii?Q?leERTZ7BSQmu636AaIhTD2EbwgF8TGBxe/y9zssoGii/IyD/9aMtmNF2laxV?=
 =?us-ascii?Q?SuvlhDuXlfN6YdzV4fvJMoz6h8Myom7r//4jp5fieuoq7S54wG0AA1wp2nPU?=
 =?us-ascii?Q?Ze/fNADiG+EqeJfz2WV8gjPWKO5vxuygA5S2pvjSV+vgH2ZQ0BaQe6qFeXOF?=
 =?us-ascii?Q?6AkmCbQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:32:03.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9344bf81-09dc-40d4-3ca8-08dd0980dd8d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0858
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

The phyCORE-i.MX 93 is available in various variants. Relevant variant
options for the spl/u-boot are:
- with or without HS400 support for the eMMC
- with 1GB ram chip, or 2GB ram chip

The phyCORE's eeprom contains all information about the existing variant
options. Add evaluation of the eeprom data to the spl/u-boot to
enable/disable HS400 and to select the appropriate ram configuration at
startup.

Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Yannic Moog <y.moog@phytec.de>
---
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: Primoz Fiser <primoz.fiser@norik.com>
Cc: Andrej Picej <andrej.picej@norik.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
---
Changes in v4:
- add missing pinctrls for eMMC 100mhz and 200mhz

Changes in v3:
- remove unwanted dts node eepromid
- correct typo in doc (PHYTEC_IMX93_VOLTAGE_3V3)
- improve enum code-style (phytec_imx93_option_index)

Changes in v2:
- encapsulate handling of feature flag VOLTAGE into own function
- move definition of enum phytec_imx93_ddr_eeprom_code into header file

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  58 +++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   2 +
 arch/arm/mach-imx/imx9/soc.c                  |   2 +-
 board/phytec/common/Kconfig                   |   8 ++
 board/phytec/common/Makefile                  |   1 +
 board/phytec/common/imx93_som_detection.c     | 111 ++++++++++++++++++
 board/phytec/common/imx93_som_detection.h     |  51 ++++++++
 board/phytec/phycore_imx93/Kconfig            |  28 +++++
 board/phytec/phycore_imx93/MAINTAINERS        |   5 +-
 board/phytec/phycore_imx93/phycore-imx93.c    |  51 ++++++++
 board/phytec/phycore_imx93/spl.c              |  48 ++++++++
 11 files changed, 363 insertions(+), 2 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 6897c91f4d..702d86f4e0 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -139,6 +139,13 @@
 &usdhc1 {
 	bootph-pre-ram;
 	bootph-some-ram;
+	/*
+	 * Remove pinctrl assignments once they are added to imx93-phycore-som.dtsi
+	 */
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 };
 
 &usdhc2 {
@@ -215,6 +222,48 @@
 			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x31e
 		>;
 	};
+
+	/*
+	 * Remove pinctrl_usdhc1_100mhz and pinctrl_usdhc1_200mhz once they
+	 * are added to imx93-phycore-som.dtsi
+	 */
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		bootph-pre-ram;
+		bootph-some-ram;
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000139e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013be
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000139e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000139e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000139e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000139e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000139e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		bootph-pre-ram;
+		bootph-some-ram;
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000139e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013be
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013be
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013be
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013be
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013be
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013be
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013be
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
+		>;
+	};
 };
 
 &lpi2c3 {
@@ -305,4 +354,13 @@
 			};
 		};
 	};
+
+	eeprom@50 {
+		bootph-pre-ram;
+		bootph-some-ram;
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+		vcc-supply = <&buck4>;
+	};
 };
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 5c1054138f..2465e31d73 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -45,6 +45,8 @@ config TARGET_PHYCORE_IMX93
 	bool "phycore_imx93"
 	select IMX93
 	select IMX9_LPDDR4X
+	select OF_BOARD_FIXUP
+	select OF_BOARD_SETUP
 
 endchoice
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 21e0e7dd1e..6837ac82b0 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -634,7 +634,7 @@ static int low_drive_freq_update(void *blob)
 	return 0;
 }
 
-#ifdef CONFIG_OF_BOARD_FIXUP
+#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_TARGET_PHYCORE_IMX93)
 #ifndef CONFIG_XPL_BUILD
 int board_fix_fdt(void *fdt)
 {
diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index f394ace786..bc5511707a 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -19,6 +19,14 @@ config PHYTEC_IMX8M_SOM_DETECTION
 	  Support of I2C EEPROM based SoM detection. Supported
 	  for PHYTEC i.MX8MM/i.MX8MP boards
 
+config PHYTEC_IMX93_SOM_DETECTION
+	bool "Support SoM detection for i.MX93 PHYTEC platforms"
+	depends on ARCH_IMX9 && PHYTEC_SOM_DETECTION
+	default y
+	help
+	  Support of I2C EEPROM based SoM detection. Supported
+	  for PHYTEC i.MX93 based boards
+
 config PHYTEC_AM62_SOM_DETECTION
 	bool "Support SoM detection for AM62x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM62X_A53 || TARGET_PHYCORE_AM62X_R5) && \
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index cd78f7686f..8126f7356e 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -10,3 +10,4 @@ endif
 obj-y += phytec_som_detection.o phytec_som_detection_blocks.o
 obj-$(CONFIG_ARCH_K3) += am6_som_detection.o k3/
 obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
+obj-$(CONFIG_ARCH_IMX9) += imx93_som_detection.o
diff --git a/board/phytec/common/imx93_som_detection.c b/board/phytec/common/imx93_som_detection.c
new file mode 100644
index 0000000000..eb9574d43b
--- /dev/null
+++ b/board/phytec/common/imx93_som_detection.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#include <asm/arch/sys_proto.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <i2c.h>
+#include <u-boot/crc.h>
+
+#include "imx93_som_detection.h"
+
+extern struct phytec_eeprom_data eeprom_data;
+
+#if IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION)
+
+/* Check if the SoM is actually one of the following products:
+ * - i.MX93
+ *
+ * Returns 0 in case it's a known SoM. Otherwise, returns 1.
+ */
+u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
+{
+	u8 som;
+
+	if (!data)
+		data = &eeprom_data;
+
+	/* Early API revisions are not supported */
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return 1;
+
+	som = data->payload.data.data_api2.som_no;
+	debug("%s: som id: %u\n", __func__, som);
+
+	if (som == PHYTEC_IMX93_SOM && is_imx93())
+		return 0;
+
+	pr_err("%s: SoM ID does not match. Wrong EEPROM data?\n", __func__);
+	return 1;
+}
+
+/*
+ * Filter PHYTEC i.MX93 SoM options by option index
+ *
+ * Returns:
+ *  - option value
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid
+ *
+ */
+u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+				       enum phytec_imx93_option_index idx)
+{
+	char *opt;
+	u8 opt_id;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	opt = phytec_get_opt(data);
+	if (opt)
+		opt_id = PHYTEC_GET_OPTION(opt[idx]);
+	else
+		opt_id = PHYTEC_EEPROM_INVAL;
+
+	debug("%s: opt[%d] id: %u\n", __func__, idx, opt_id);
+	return opt_id;
+}
+
+/*
+ * Filter PHYTEC i.MX93 SoM voltage
+ *
+ * Returns:
+ *  - PHYTEC_IMX93_VOLTAGE_1V8 or PHYTEC_IMX93_VOLTAGE_3V3
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid
+ *
+ */
+enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage(struct phytec_eeprom_data *data)
+{
+	u8 option = phytec_imx93_get_opt(data, PHYTEC_IMX93_OPT_FEAT);
+
+	if (option == PHYTEC_EEPROM_INVAL)
+		return PHYTEC_IMX93_VOLTAGE_INVALID;
+	return (option & 0x01) ? PHYTEC_IMX93_VOLTAGE_1V8 : PHYTEC_IMX93_VOLTAGE_3V3;
+}
+
+#else
+
+inline u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
+{
+	return 1;
+}
+
+inline u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+					      enum phytec_imx93_option_index idx)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage
+	(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION) */
diff --git a/board/phytec/common/imx93_som_detection.h b/board/phytec/common/imx93_som_detection.h
new file mode 100644
index 0000000000..a0803b47cb
--- /dev/null
+++ b/board/phytec/common/imx93_som_detection.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#ifndef _PHYTEC_IMX93_SOM_DETECTION_H
+#define _PHYTEC_IMX93_SOM_DETECTION_H
+
+#include "phytec_som_detection.h"
+
+#define PHYTEC_IMX93_SOM	77
+
+enum phytec_imx93_option_index {
+	PHYTEC_IMX93_OPT_DDR = 0,
+	PHYTEC_IMX93_OPT_EMMC = 1,
+	PHYTEC_IMX93_OPT_CPU = 2,
+	PHYTEC_IMX93_OPT_FREQ = 3,
+	PHYTEC_IMX93_OPT_NPU = 4,
+	PHYTEC_IMX93_OPT_DISP = 5,
+	PHYTEC_IMX93_OPT_ETH = 6,
+	PHYTEC_IMX93_OPT_FEAT = 7,
+	PHYTEC_IMX93_OPT_TEMP = 8,
+	PHYTEC_IMX93_OPT_BOOT = 9,
+	PHYTEC_IMX93_OPT_LED = 10,
+	PHYTEC_IMX93_OPT_EEPROM = 11,
+};
+
+enum phytec_imx93_voltage {
+	PHYTEC_IMX93_VOLTAGE_INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX93_VOLTAGE_3V3 = 0,
+	PHYTEC_IMX93_VOLTAGE_1V8 = 1,
+};
+
+enum phytec_imx93_ddr_eeprom_code {
+	PHYTEC_IMX93_DDR_INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX93_LPDDR4X_512MB = 0,
+	PHYTEC_IMX93_LPDDR4X_1GB = 1,
+	PHYTEC_IMX93_LPDDR4X_2GB = 2,
+	PHYTEC_IMX93_LPDDR4_512MB = 3,
+	PHYTEC_IMX93_LPDDR4_1GB = 4,
+	PHYTEC_IMX93_LPDDR4_2GB = 5,
+};
+
+u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+				       enum phytec_imx93_option_index idx);
+enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage
+	(struct phytec_eeprom_data *data);
+
+#endif /* _PHYTEC_IMX93_SOM_DETECTION_H */
diff --git a/board/phytec/phycore_imx93/Kconfig b/board/phytec/phycore_imx93/Kconfig
index a70104cb79..09f26e89e3 100644
--- a/board/phytec/phycore_imx93/Kconfig
+++ b/board/phytec/phycore_imx93/Kconfig
@@ -10,4 +10,32 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "phycore_imx93"
 
+config PHYCORE_IMX93_RAM_TYPE_FIX
+	bool "Set phyCORE-i.MX93 RAM type and size fix instead of detecting"
+	default false
+	help
+	  RAM type and size is being automatically detected with the help
+	  of the PHYTEC EEPROM introspection data.
+	  Set RAM type to a fix value instead.
+
+choice
+	prompt "phyCORE-i.MX93 RAM type"
+	depends on PHYCORE_IMX93_RAM_TYPE_FIX
+	default PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB
+
+config PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB
+	bool "LPDDR4X 1GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4X and RAM size fixed to 1GB
+	  for phyCORE-i.MX93.
+
+config PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB
+	bool "LPDDR4X 2GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4X and RAM size fixed to 2GB
+	  for phyCORE-i.MX93.
+
+endchoice
+
+source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
index 9e91a29dc3..cea817ffdc 100644
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ b/board/phytec/phycore_imx93/MAINTAINERS
@@ -1,10 +1,13 @@
 phyCORE-i.MX93
-M:	Mathieu Othacehe <m.othacehe@gmail.com>
+M:      Mathieu Othacehe <m.othacehe@gmail.com>
+R:      Christoph Stoidner <c.stoidner@phytec.de>
 W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
 S:      Maintained
 F:      arch/arm/dts/imx93-phyboard-segin.dts
 F:      arch/arm/dts/imx93-phycore-som.dtsi
 F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
 F:      board/phytec/phycore_imx93/
+F:      board/phytec/common/imx93_som_detection.c
+F:      board/phytec/common/imx93_som_detection.h
 F:      configs/imx93-phyboard-segin_defconfig
 F:      include/configs/phycore_imx93.h
diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index 085c8e195a..a55795e060 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 PHYTEC Messtechnik GmbH
  * Author: Christoph Stoidner <c.stoidner@phytec.de>
  * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  */
 
 #include <asm/arch-imx9/ccm_regs.h>
@@ -12,11 +13,21 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
+#include <fdt_support.h>
+
+#include "../common/imx93_som_detection.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define EEPROM_ADDR            0x50
+
 int board_init(void)
 {
+	int ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
+
+	if (ret)
+		printf("%s: EEPROM data init failed\n", __func__);
+
 	return 0;
 }
 
@@ -40,3 +51,43 @@ int board_late_init(void)
 
 	return 0;
 }
+
+static void emmc_fixup(void *blob, struct phytec_eeprom_data *data)
+{
+	enum phytec_imx93_voltage voltage = phytec_imx93_get_voltage(data);
+	int offset;
+
+	if (voltage == PHYTEC_IMX93_VOLTAGE_INVALID)
+		goto err;
+
+	if (voltage == PHYTEC_IMX93_VOLTAGE_1V8) {
+		offset = fdt_node_offset_by_compat_reg(blob, "fsl,imx93-usdhc",
+						       0x42850000);
+		if (offset)
+			fdt_delprop(blob, offset, "no-1-8-v");
+		else
+			goto err;
+	}
+
+	return;
+err:
+	printf("Could not detect eMMC VDD-IO. Fall back to default.\n");
+}
+
+int board_fix_fdt(void *blob)
+{
+	struct phytec_eeprom_data data;
+
+	phytec_eeprom_data_setup(&data, 2, EEPROM_ADDR);
+
+	emmc_fixup(blob, &data);
+
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	emmc_fixup(blob, NULL);
+
+	return 0;
+}
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 17a8736c73..a4d2aaac32 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 PHYTEC Messtechnik GmbH
  * Author: Christoph Stoidner <c.stoidner@phytec.de>
  * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  */
 
 #include <asm/arch/clock.h>
@@ -20,6 +21,8 @@
 #include <power/pca9450.h>
 #include <spl.h>
 
+#include "../common/imx93_som_detection.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 /*
@@ -27,6 +30,13 @@ DECLARE_GLOBAL_DATA_PTR;
  * when pca9451a support is added.
  */
 #define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
+#define EEPROM_ADDR            0x50
+
+/*
+ * Prototypes of automatically generated ram config file
+ */
+void set_dram_timings_2gb_lpddr4x(void);
+void set_dram_timings_1gb_lpddr4x_900mhz(void);
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
@@ -46,6 +56,44 @@ void spl_board_init(void)
 
 void spl_dram_init(void)
 {
+	int ret;
+	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
+
+	/* NOTE: In SPL lpi2c3 is mapped to bus 0 */
+	ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
+	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
+		goto out;
+
+	ret = phytec_imx93_detect(NULL);
+	if (!ret)
+		phytec_print_som_info(NULL);
+
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB))
+			ddr_opt = PHYTEC_IMX93_LPDDR4X_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB))
+			ddr_opt = PHYTEC_IMX93_LPDDR4X_2GB;
+	} else {
+		ddr_opt = phytec_imx93_get_opt(NULL, PHYTEC_IMX93_OPT_DDR);
+	}
+
+	switch (ddr_opt) {
+	case PHYTEC_IMX93_LPDDR4X_1GB:
+		if (is_voltage_mode(VOLT_LOW_DRIVE))
+			set_dram_timings_1gb_lpddr4x_900mhz();
+		break;
+	case PHYTEC_IMX93_LPDDR4X_2GB:
+		set_dram_timings_2gb_lpddr4x();
+		break;
+	default:
+		goto out;
+	}
+	ddr_init(&dram_timing);
+	return;
+out:
+	puts("Could not detect correct RAM type and size. Fall back to default.\n");
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		set_dram_timings_1gb_lpddr4x_900mhz();
 	ddr_init(&dram_timing);
 }
 
-- 
2.34.1

