Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5471DCA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AED6836D2;
	Fri, 29 Aug 2025 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A5783487; Fri, 29 Aug 2025 08:10:17 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CB18350A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZYneMXj4fseevPQeqV10iEIvFPOwMayHwLGLJEQfmlo8KXGRrSMAFsDQS5DXvTRilV1rtFSkiKEkjKF2IzHlE1dIIAvzNK1XbebxrDqQ2H7VRZPDbBW4SZR4Yn6LkwJmmfawq5ioNRgu4RU/vWua97llRsCHhrwOMbT9iZitI/kDJkQ/ZOl98++17IilVS+Ej2TN5rUf7wDdbgnpseV2NUS5Qk1XPz3EjQo/T2O1aICfZVYRgDiNwH7G7AVY12ZAmjn6phEpAvtmYY7/CONvBh7acKurM6fmMLZnbOA/QaQF7R1iYsJd6J9nLmcU+ERRWbfif/SURQQMnsb+KQq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiO5JT+ay/9hjs1jziOfOVsec75chD+3kWtcBY77b/Q=;
 b=VQIzUK7oAgnKWoiD8nJLgO2KOVHN+Qokrfd0NRE768LCd1jf/K9pdNnoi9bct7QOTSYe5DXSZiiII+gb5fKZqEm7xA32I8E5pB61Y9k5MiwFP4nu06qbAsShCyG5FDKlb8UBVco+BZmlt7l174NH5nuZWU2Beae2WAzV85YtureYmn1pXbUD7TkhuxGolatuJ2ZPFPUXyMqmn6EWqevojwi3jjJfLxq/ytOJFEQO7/uK3SkjN8aUgC6R5Ss5T/7xpGLpffilrABbKqhTPyGSxNWdAhhb1Hb1kmisIkzZIa8hpA6GsKHau+NS0O/muauPb9OFd/AgBHv6luRXsei8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board device
 tree
Date: Fri, 29 Aug 2025 14:09:23 +0800
Message-ID: <20250829060931.79940-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: 856d7e79-6b80-4e44-b2fc-08dde6c2b495
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: SXI/Zb7kp1D6BAwZCsIq5xQvX/BL5c8jyqm/WWkBPVwruaEGmmoATSlOmjsJuXzuh5GannZAO0dcVAq3+bJawfmLDcBYQZHT1qXCBF88OcAOaoPyLQIsVwmnSuemjZ1YQeLb8eYOY9FlPz2iwbGxl/BNf0f6en4KgR0HvaHZHh/0KNQLYwQa+rIuXPfSgaSqLsuibZihXKkIDx3iWG0TE9okx4rNfR76HuBBwBqhHOUnZqrRjHxWQJ28F5OqNsb2yGATmExntB9sEYi5B4v6gkH7YOqRWVT4SM6Ec5Adql2wgDAo0EPjhCAsr75khzNymrYkHvR0fKUIBLz4WSQdNLCV1o85ZPT6uBRs3iN/mA3aRPWTecrYZMENUd8YE1Z8Bkk7ZTt40DJ2M7hSrJcAyN1X+TPNZ7kccp0SiLeYi9EnQlwHSJ0HO8j3MXqE7qF+tc5RUtaBY0jwHKzTNBEcF+W4utKf0Dr/3vmqdEbpEfE4fJJGVHVtRxehmUvkvxIMC5Ec/PAX5rWhHv+Hk9kGyCcjLOB65wHT4K2nJ9i5oylwjMwfUBgOu/VmbOWIXxTEmtEhGeBnpfKxuG9E6FmU4UCxZP0P3BI7zgAGYzbe/PI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFG5x+aJsYUeVqiku53bMCbKKYcYBj94sVScNv1mRvt4twZht9yq5ub+Icf2?=
 =?us-ascii?Q?baNw/FXXa6W+ywo6FXKrRgXHe1yOJcJIrf0vODWLukv3Czby3N++YH3BjA9s?=
 =?us-ascii?Q?mUSEcsYI8I6ImpYqP9YMdBPNzjy+moykO3Rq+mS6HlPwdq0+NfMPpJYyDptA?=
 =?us-ascii?Q?/IdKOBT3RSCKGvANEHetFCk+gO8vyOMl/SzG6QgjF9pheOKHpLtOFVTx4nTl?=
 =?us-ascii?Q?+/cKskL2DfADGVjNnaAFuOyKzQ5o23pr99AcjNNHIpzXajFojH16OLDwrdlD?=
 =?us-ascii?Q?GLUPM0bePS4bvHfxkNwFftSpwnBW/obymg+yuUGyikrhmpmj/JvkkgBrQsyC?=
 =?us-ascii?Q?n3O/V89eD8XK++MF4ugxSCeLR9JWl8cYAcgVMi3awCMDz2oGuQZ/Lec1hU4m?=
 =?us-ascii?Q?EAKZrFdM3AZgyy3AhHn0qvUz7CsYQg7RDjxz+ZgTjSrOgJijenDJgH33r0t0?=
 =?us-ascii?Q?xc4ye89ENsciyBtj1gJTSO2qYr+wvktGfwePQrb33IzTC/cKYHHc+ZU9EgJY?=
 =?us-ascii?Q?UJz95Dwye+tabtfEt9rtsQVPaTaRPoDZu0JqZgYzW3XGvwMacYZYrLdrqIpo?=
 =?us-ascii?Q?Ru1QaIXI4xbsMDNwwePBUhGZWVhlRzxayjtG+dR61cKGviL14G3PtjLp32p/?=
 =?us-ascii?Q?eC20Y4KZNjXhmB7nAaU2UY6uqRAer4i+vWDnAr1lEt4BBD7OrRN7cblXClWx?=
 =?us-ascii?Q?U0fVlZFhbaspV5QLiCbB0ODGtMEJlFsp4N8jQ0sBh+sxdH7/OcNlQzGxcSEz?=
 =?us-ascii?Q?LK7ZuZ+8s8cqQqr4jCCihD/wZhsl5jE+kHoBxq5A3FhS2L9bII4++1KAf4m4?=
 =?us-ascii?Q?AeU2PwQAwloR9xX61E/ffOGMWh9od2sUCCSbeEjyltEDXayNUdmqPUwYso8N?=
 =?us-ascii?Q?Fnj4/QUG6NZKgTUdcl+mj9nj3+i37p/rUZEXzvXM/IciTFEVlz1kioVw7B2z?=
 =?us-ascii?Q?TRnyBAteQ+tWpEuzt1v0tVOCyn9gk0jVBoYzh54tJMtAwl7jxiLiKlxzbA2g?=
 =?us-ascii?Q?BWLQx15ey8CDQbenGl+LTbeutPitLuGfhLRnqsGsncxzYqJmJLaJSd+VFIxf?=
 =?us-ascii?Q?Gs3zCL3uNYzT/J/4vK7tZJFLZdv30T04daN/Vo26jzGH5UUp/c+Jx4eBChLg?=
 =?us-ascii?Q?uSgDo9RSas+iFYw0bazdwhv5a05xcO6Nb+iLmAgZlM3cuSlAfUdbVnK2xuGt?=
 =?us-ascii?Q?w2HuojUqp0lngboZfPJ9vt8Gw5+FQv1YB9RymoqVgzBU2TZcb9U3RLEEmrhm?=
 =?us-ascii?Q?qKmWmuATLmg3lTjv4h/iiZ2KHZz74ZScy6NUbfzi5G5R79PpMuFErm2p0Nxv?=
 =?us-ascii?Q?mMlJJ6gaeR72EJGdkior7zY7s5jFx2X+IqGS0OI6cPv83CIlqLOXRZ6akDqn?=
 =?us-ascii?Q?4LsLKrbrzlQWcfrm8/pG3seHfKIdFeSSKEIP4FBK0VXwFmW5GkGG6BLRA4Yq?=
 =?us-ascii?Q?zxacNOG0X/y4CvvIwyNgIhiExYUg1z3VRUl7ZKUY0NXzsVTLy9I9vDojpHOK?=
 =?us-ascii?Q?nP7gdkBkyJXkmdZC6PtlmnmphfZDeX35c/0dlHALQuENp2hxWyXQoozlyZfr?=
 =?us-ascii?Q?oABj1ymg/rwnlvVgkIEpmYCq11wu6Ccwut3EpVXhyd+6W3bnvZyT2swuGl3O?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856d7e79-6b80-4e44-b2fc-08dde6c2b495
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:08.5122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIhcZE/eFdCxBYvPkM3O1GEtnT4SHx5pdVOrg198kSLtse/d4V72EKi5jGxF5TQthOIqB2LlMrwdMD8jPPJsC8jPwsjk2QD4ayMrtFLC1G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.

Board features:
- JH7110S SoC
- 2/4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
new file mode 100644
index 00000000000..a0cb9912eb8
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "StarFive VisionFive 2 Lite";
+	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
+};
+
+&cpu_opp {
+	opp-312500000 {
+		opp-hz = /bits/ 64 <312500000>;
+		opp-microvolt = <800000>;
+	};
+	opp-417000000 {
+		opp-hz = /bits/ 64 <417000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-625000000 {
+		opp-hz = /bits/ 64 <625000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1250000000 {
+		opp-hz = /bits/ 64 <1250000000>;
+		opp-microvolt = <1000000>;
+	};
+};
+
+&gmac0 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
+	disable-wp;
+	cap-sd-highspeed;
+};
+
+&mmc1 {
+	max-frequency = <50000000>;
+	keep-power-in-suspend;
+	non-removable;
+};
+
+&pcie1 {
+	enable-gpios = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&phy0 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&syscrg {
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1250000000>;
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(22, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(23, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(24, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_CTS)>;
+			input-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_UART1_RTS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		power-pins {
+			pinmux = <GPIOMUX(26, GPOUT_HIGH,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-disable;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
+
+&usb_cdns3 {
+	phys = <&usbphy0>, <&pciephy0>;
+	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
+};
-- 
2.43.2

