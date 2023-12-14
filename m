Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57616C46CA2
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 04:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C61879D6;
	Thu, 14 Dec 2023 05:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="MtplKF+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836B2879AD; Thu, 14 Dec 2023 04:07:49 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::801])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFBB879B3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 04:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=TracyMg_Li@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv5SH/ilGD+LwYUenHtaAAXVxkyqLB/owUsJCe5APWhGElj7ZQrt13/M30rqkP7GNy9I2uITRz6lF3ghBPEpB28R8ZRNK6fqFken5tIzV4NmtoDRx1AtCDUiV0VA5vRhY5IytbNHOnyIURfNFf2ydE2oiPS+ke8ayHhyqvdr0hzHKDvKt6tfZiLtRKe0NksF8Lxys9APJtT0N+xxv9RB7bLFAKWiwaKFiT8tVR5XiU09XRBnDExOaqpx+fvwI2pVDz9TdaajYIzHg2ZyWS78NcxYC7ndycx+866YHSGr5uHYTNsd7HFPlYKXcWM7xGJqZI+IC1P6Ajmfp4czm8k+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH7/PKCZTfEHR1b2w6xZOqq2GrOX7WKJ04AMz+8xi0U=;
 b=edE0WX4vq3SIp5TGMfxzkLEoWxtQXHntUPAcz15F1qvek16DnBpbiHygzMtNLqd/Nvwvd/6L2QqtW6NjEVSx7GITjey8ZzAqBsAmrJnSYRGzV17fCcptOtzUCYpDlRHrYnLCOWuofQuFtJLswxUuRzJWeSHDDZnqvzRvpC38kPVgrFLBqwNjuYdjQSZVJw2PVdP6nVwMh/Qh/mQ/z/8AvtRFHanGAr500vQB2Iecy4UMQZ2nPjnUPT+SZq593eAraawe8YSxYqG1BJWemshj/RrGLLa1wzJ5KrP0vQiOpfN/g1CQglJhne1uzQe//dgjGn+CqJB9eAsuhV68m7z0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH7/PKCZTfEHR1b2w6xZOqq2GrOX7WKJ04AMz+8xi0U=;
 b=MtplKF+XKS0LCZgPKO+WdNS3AyEz2mMBDBRy3xEatuOHoa4eshS6v2rzr7KcVa/8VO0/DvoeIg5k8Z0OGyzZ45SW7zeTVOwvLfy0clOy7VEYeuuVPl+VUv2rREBk6Jf7INiz0cX+Plyly9IPPcKrKO4DYEUybOLHAUIVWpho8YfOM0OH/dx4V5U1CrAg/2D1YYiLG7/J+9dX7pHSfLr4g6WU9d6NQn68WytH2uO70MhXbhnuGqK1Dha93Hw5ZGGVW7b7x9/c+jdR12DYQO6Xhu4XW39fm1sqaFz5K/WcP2CD6jYcupXdZI0u8fKXoamY1V1BlQFE5voaaG27Mhd58g==
Received: from SEYPR01MB5884.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1da::6) by TYSPR01MB6437.apcprd01.prod.exchangelabs.com
 (2603:1096:405:81::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 03:07:39 +0000
Received: from SEYPR01MB5884.apcprd01.prod.exchangelabs.com
 ([fe80::8b4f:f233:9377:7402]) by SEYPR01MB5884.apcprd01.prod.exchangelabs.com
 ([fe80::8b4f:f233:9377:7402%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 03:07:39 +0000
From: TracyMg_Li@outlook.com
To: trini@konsulko.com
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, festevam@gmail.com,
 patrick.delaunay@foss.st.com, tharvey@gateworks.com, pbrobinson@gmail.com,
 hs@denx.de, d-gerlach@ti.com, u-boot@lists.denx.de, robh+dt@kernel.org,
 TracyMg_Li <TracyMg_Li@outlook.com>
Subject: [patch v1] =?UTF-8?q?arm=20add=20initial=20support=20for=20the=20?=
 =?UTF-8?q?Phytium=20Pe2201=20Board=20board=EF=BC=9Aphytium=EF=BC=9Aadd=20?=
 =?UTF-8?q?pe2201=20folder=EF=BC=8CIt=20initializes=20pcie,
 =20ddr=20and=20?=
 =?UTF-8?q?other=20aspects=20of=20phytium=20pe2201=20board=20dts=EF=BC=9Aa?=
 =?UTF-8?q?dd=20phytium=5Fpe2201.dts=EF=BC=8Cit=20is=20device=20tree=20of?=
 =?UTF-8?q?=20phytium=20pe2201=20board,
 =20include=20pcie=20and=20uart=20no?= =?UTF-8?q?de?=
Date: Thu, 14 Dec 2023 11:06:58 +0800
Message-ID: <SEYPR01MB5884E73747590F8307ACEBE7F18CA@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [Pe78P7n+1AAms9ct5T5OMUv9gqkMpD9F]
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To SEYPR01MB5884.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1da::6)
X-Microsoft-Original-Message-ID: <20231214030658.7744-1-TracyMg_Li@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5884:EE_|TYSPR01MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e44fb6-8b21-4f1c-e06e-08dbfc51d36c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xi06vfNeJj6fJeS5g91zhw3npIf9OXa5XTWiKwnrH04hRilt5NxiTnLpWbPEWpUGOM1qZUjBtG89V285BBgPSrvPvSphT1PKOwwh/RpjQ/jVF26ZTYY6jQ3seFu/ebY8t7PLhPA2Rq+pk+vSwwudiV679N3gw8d+9+co8fjoxVKuT75bvhxxmLQtBe7V5I2Nha1I4hGewTrj3BITR0G9szKyt82XhhRUsc/S/hZqK/Rgp/G0P8ZoH4ejLS98WxNhd3dEKrXwmNuMlJ+bIjmcxEhjoSgVeA/LgXfw2BEgynCCgDC+z8viPP+BU2cj7AXSWovHWP6sHLrW8LkVrQvaeBldcA1yDUokGxbtuQq/TU+OunwCReeGdozS2DJwjWeaQg7e5w05P5gRZV5Z16jnSvgNr7uN1ntpl7+uLAdu2RUzFS+VJvVtxsO+gaImVnX8KitMqwIpTVcXNSi+Z2JGYjZsmO5QGfKX+qap+e9cfF71Lyd/WoVmk1lnIZwdoNlfyoCDOpuvGmWHJoV3ZTXbKbepFBRzXWK/7AdHEMhjV85vlAeucbwQm8zEIWHkUouL/VbyDL+7EEMTqjgVvhaEZ4+7eXQzpVriwlE7fyGn+XadN3d72P+xFbZKso2LmGhO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVZMmlOaHEvREFDZWRwRitSSGtJQWZib0V3NmhMQmFXQkRYMHZuakdMTkJL?=
 =?utf-8?B?YmNGNVZPbzl1cjM2VW90dnJHSWlBeWswM3FIREk5V3QrVFpNaEwrSCszMEts?=
 =?utf-8?B?ZDNOU3ZlcHIvTmg4Z3JPODY5cC8yK0MwQk9CNGJoRERDRmtjaWVrdXZaSm5z?=
 =?utf-8?B?NGV1Nkh5dFZiMW5VZFRUMGlKeG42ZEd2cEVTemNOK2JmVk5BejRFRVFzTERi?=
 =?utf-8?B?REhLaE5YQnJRUUVEcWNwNE1jaUNkbHhyRjZ6ZUdEeXVMejRXTjY2L0JFOTkx?=
 =?utf-8?B?YzhSZnZNNGNpdG9PcytKTFVnbWJYL3Y5aytzTHgyRXhuU1ZzS2xsZmdWb25O?=
 =?utf-8?B?d0U2U0ZOS1MzRlhkL1hDdmlVZWFNci9BR2NBRFgyVTl4elFVSjhXYVhmQ2Qx?=
 =?utf-8?B?aXl2bnVZYkRxMjcwdERlVFk0QzNseGMxZDR2UnBYZGYzc1JvdU9NT0VwRlBk?=
 =?utf-8?B?L3ZYWm5CckQ2Y09HaVBQSjRjT0Z3cVk0YlpKWGdLYWpFTVo3NlAyTWxDbW4x?=
 =?utf-8?B?QjVzc2tlaW5ad1JLZHZjVnJjdXNHWWF4Mk9XM2oxRVp5OFVyWmY1Ui9kNDNJ?=
 =?utf-8?B?L25KOXpwMkJGbDF4WGVUNFlxRFIybWJiR1VRekFoNGU0SVBnWVlVNUk1VDli?=
 =?utf-8?B?MjV4ay8zOWQ2cTdraXpSUCtoT1FEZ1RzYm5LYURZejR6Wk5wTUx4S291UWc3?=
 =?utf-8?B?MWhiMGg0cG9DMjdHZFc0SndacUpGYUcwNWpPT0J6bkNjbGh0SFZrbGRPMTFj?=
 =?utf-8?B?Q0tTTVpaQ2RUdEV0dHluQ3JnT1VpYWtYMTJBeWUwcUVPYWtMajNUSE5ZMkxN?=
 =?utf-8?B?MzMxejk4aU9vYVdSVHBtNEUzT2NaUjlCT21qS1AydTdUS0R5RnB0OUdneGsy?=
 =?utf-8?B?K0p6ZGxldTY0Zzgrd1d2MFRYYm9VM3kzUVJOSENoVHJLNzAxeURzYVJNeTl6?=
 =?utf-8?B?Si91ZXV1blZISTRvYWYxZG43V1UzMzZ0QXJBRjU5aXZoRGhtRHIrYTNxa3kv?=
 =?utf-8?B?S2l5aExHMEJSTVZ0NG02NnB4bGxqUUJwdXFoTC9hOElKWUJ5dW1qWDFJeE9K?=
 =?utf-8?B?OU1yOHJVNlFySitpNDZRa0tPbE81SVIzcVBXUEhOYTRtTUNveHREQVUySXdH?=
 =?utf-8?B?TVJxcTUxVVp6Tk5VNWpIeU5HOWJqY1pSZitqcThVcktHY01KZFRJNGNUY0hC?=
 =?utf-8?B?YzBhNmdDREcrS3dvRWx3Wko2Y0J1dmFiemJYc2tBTW9TajYyY2k0REVqOGdq?=
 =?utf-8?B?a1V6bWxYTFcyTGhjYzFRQnZOOGVPWCtEdVpwb0wvcmpaVEtsVk9raWlIa0tM?=
 =?utf-8?B?aXRlVXIySUpuVm1KR0thb1RlZGkvY0J4NGFxaExsSm1JRUx6WFVUZFc2WUtB?=
 =?utf-8?B?THUwU0dxb3EzNXBGcm5TTVIvd25FSXZDVlZUQVJydE9OMm5oVG40aUFVMFJ5?=
 =?utf-8?B?eEF5NW55QVpjMTlrRkNqUlRsajBkMjdUMW5lTUlUWllWZkdPbVl4dmZNNnpT?=
 =?utf-8?B?UzdoaXFTdTRKWEdDK1N1dVFmUEJZTllrMUpUbHd1bjhkTUh5dkdIdnVqMXhB?=
 =?utf-8?B?SlN0SjA3Vnh4VU9Jc29nRW5qbmdwcE1PaXRFZVN6UkZrZGZjL1B5VzRSR3Z6?=
 =?utf-8?Q?SW7yRWV+OmZD4+qOHvnoBM75lV1NPGlayg+HYCd9pdCg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e44fb6-8b21-4f1c-e06e-08dbfc51d36c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5884.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:07:38.3667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB6437
X-Mailman-Approved-At: Thu, 14 Dec 2023 05:25:17 +0100
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

Signed-off-by: TracyMg_Li <TracyMg_Li@outlook.com>
---
 arch/arm/Kconfig                 |   8 ++
 arch/arm/dts/Makefile            |   1 +
 arch/arm/dts/phytium-pe2201.dts  |  43 +++++++
 board/phytium/pe2201/Kconfig     |  12 ++
 board/phytium/pe2201/MAINTAINERS |   8 ++
 board/phytium/pe2201/Makefile    |  12 ++
 board/phytium/pe2201/cpu.h       |  64 +++++++++++
 board/phytium/pe2201/ddr.c       | 190 +++++++++++++++++++++++++++++++
 board/phytium/pe2201/pcie.c      |  60 ++++++++++
 board/phytium/pe2201/pe2201.c    |  92 +++++++++++++++
 board/phytium/pe2201/pll.c       |  75 ++++++++++++
 board/phytium/pe2201/sec.c       |  37 ++++++
 configs/pe2201_defconfig         |  40 +++++++
 include/configs/pe2201.h         |  32 ++++++
 14 files changed, 674 insertions(+)
 create mode 100644 arch/arm/dts/phytium-pe2201.dts
 create mode 100644 board/phytium/pe2201/Kconfig
 create mode 100644 board/phytium/pe2201/MAINTAINERS
 create mode 100644 board/phytium/pe2201/Makefile
 create mode 100644 board/phytium/pe2201/cpu.h
 create mode 100644 board/phytium/pe2201/ddr.c
 create mode 100644 board/phytium/pe2201/pcie.c
 create mode 100644 board/phytium/pe2201/pe2201.c
 create mode 100644 board/phytium/pe2201/pll.c
 create mode 100644 board/phytium/pe2201/sec.c
 create mode 100644 configs/pe2201_defconfig
 create mode 100644 include/configs/pe2201.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c98..8a8f8805a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2060,6 +2060,13 @@ config TARGET_POMELO
 	   Support for pomelo platform.
 	   It has 8GB Sdram, uart and pcie.
 
+config TARGET_PE2201
+    bool "Support Phytium PE2201 Platform"
+    select ARM64
+    help
+      Support for pe2201 platform.
+      It has 2GB Sdram, uart and pcie.
+
 config TARGET_PRESIDIO_ASIC
 	bool "Support Cortina Presidio ASIC Platform"
 	select ARM64
@@ -2336,6 +2343,7 @@ source "board/variscite/dart_6ul/Kconfig"
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
index 0000000000..e661e80f06
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
+			};
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
index 0000000000..5a2f8f6f5e
--- /dev/null
+++ b/configs/pe2201_defconfig
@@ -0,0 +1,40 @@
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
diff --git a/include/configs/pe2201.h b/include/configs/pe2201.h
new file mode 100644
index 0000000000..ff24dc5ac6
--- /dev/null
+++ b/include/configs/pe2201.h
@@ -0,0 +1,32 @@
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
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM_1
+
+/* BOOT */
+#define BOOT_TARGET_DEVICES(func)	\
+	func(SCSI, scsi, 0)	\
+
+#include <config_distro_bootcmd.h>
+
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS	\
+	"image=Image\0"	\
+	BOOTENV	\
+	"scriptaddr=0x90100000\0"	\
+	"kernel_addr_r=0x90200000\0"	\
+	"fdt_addr_r=0x95000000\0"	\
+	"boot_fit=no\0"	\
+	"fdtfile=phytium-pe2201.dtb\0"	\
+
+#endif
-- 
2.17.1

