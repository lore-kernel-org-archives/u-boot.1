Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B00BCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CCB83837;
	Fri, 24 Oct 2025 16:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0E0835FE; Fri, 24 Oct 2025 10:59:50 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5163583642
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSNUtMdQCsMkMLJhWn0PfcJ3UHkApUdy+tvEar4GVjBmlrmNe+PH1+ktBwuANrTM7t7OB0EckARnX2+V/GUs6Xb13OYNKA0Z6VOCSoq1U77pEe/bHqiF7J/AXid68s8pnSFgljSBFdh6/uDKufFfnLPhhmKhA/leijsAt3b6khccfVYPYmOf8ga+iC9tvStAjzhOBc+5z8G3Gs6++COk+jsRYQWFcUKkinyJ4IRiLBD49pvY5FdFLjD0YtxrOiHGScHC2YU8M2/kClCDbrVrA1yJqSEl0xjOItFjZ1GOW1lwSdHF8eAx01MBe50cJnF5COmijQ6JJkv8JLBYeebM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdwiRNEjljzT5Q4/0k0mNXlNHJSrxSbTD4oY7JnFJFk=;
 b=Yy8k6e8r0oouJN1k7rc8vYckNf3rlOAug5fJPLgw5kyZnYxJFfkGLupEASidyludjkb4C7+37mEG5HxZ7Ce0XG4Su782xKNhsnfb8QZpP7BXdtzDM2WSuuE8fG0LOfK3gjoKPYxazSEOCZ0H4SkkV1I37kBJzT45zFTZLWGZRv2mNxf9WbN6cpzs82tdMVaN+8tYCmlYIxaWRoxAz/Tt7Q/iVpNS5TOE/zV2BGelHazmOqzmaSKUa0cDxtRZBglcDowiZHxh93RaS5KpCkFrfNrCTz4Xe9T0n1sHMlaegDqRAL7gBzrMCN0RaRYmDc73jaU6Zdln05rKrIg3MNhmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:41 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:41 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Date: Fri, 24 Oct 2025 16:59:25 +0800
Message-ID: <20251024085932.83596-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ab8cad-41e6-4521-78d5-08de12dbab13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: W1bxuhEfP+4sGhaFPMewe2iRhAeteBO95BmrkYUYCfeLpRUEQFm1eWkOzhQOwHoUs5+S8SJdNqbSFr7saemaELK47wKNmaDDZyC28A7T88l02TwlKkTi58ntFZc98BTwtcTMU6pRYxA8wZ7/HpDGB1LyYwW1RCx3GgnzRxacqvtxcra92ZNvIh6Fq+IzYBOjPh4ykNPPy69rP71Rcxcu0xvBzzPscLw4r9n4NdSNZR+rvqvJIk2TbktM3DfhakNgAtAYIIyp8ta3E6Ohe81a5gDIv6mQpm8m1RatZ6z6NOlQkddoJET0rOFfmfNwCSXOgVe8xpgMjlslf9KMUN/YxrtWPn2zthFvkb2nytYhh/YiW4bs7H/vQnWyup3lfPkL0+T86QtqURP64sVl7aYrCZWUg2Rl5s5yojjhxY++VIQxCBuhdu2SKOAk5iVg92SdNaJazkQJwlwLUFvnm8poAMqM1xFr2C0MwOMJJXjfbWz/cHC2IDgmzB4V8uCFec2mTKJrFDWeALaYrwh2cG8mO/gmX+fH3PcX8DVDtIRx1a0VVmjVoggIlTsyDyCLoIEdkT8LdtRUDnkqY6t+RIz11Zdchmx860KZV7m6igCfjDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBrMghZC8d6vBlt/pOMLA9pMEabAcyJIg8UTa34bFNXKiFlGEPen/gMxPGIR?=
 =?us-ascii?Q?Ea2FumYiX/Loqj94U3nZYGQt0Gx5WoNiYwIW1y8zLYjaHHhaaPgsPCJWrLxX?=
 =?us-ascii?Q?r1W6G8mwRTOfBuePD0iKwb1ASZmPK3RxX8lZVzhiZzrHKG5a+RgJJ/JdfmLt?=
 =?us-ascii?Q?OAh3WgchkpGMQsOAwsOAVUnKk00S2K3x8SZ9vXTalun/Vtagdyzm5Q2FTLcT?=
 =?us-ascii?Q?kOTeFVm5BTWOn7NrlruGvf6fRpSHhuad0dWQVEIQplMInfFslmrBHC0FD8A/?=
 =?us-ascii?Q?mFTkiTHE4vrmNmON1XDl8IvM/CaQsptuvp2bLwaRQVFOVNu1yBelLeIiyA8q?=
 =?us-ascii?Q?1HuNOTMz9YqQOW2Be0+lk2zfm0VJdNkkXaMlgBy0Fga6UlGPxd57OCJ5yl2O?=
 =?us-ascii?Q?ajv8BFgz9YeQilOzH6wb+cT5CXtFiqfTiGh0SolL4PX6d4DxRZop8TmnCUJj?=
 =?us-ascii?Q?bS8HI9RjH5D6dGYOl0CpSjP4ErFkMO4A7iLNhBKNnkEww2FFKUCp0i+1b339?=
 =?us-ascii?Q?vsZPfUko3mZc+b3+6hD28J+qxqcYiY2MWONgvrcePh050w/hPMG5h0S00eev?=
 =?us-ascii?Q?2BNjGsDF8P5rOSn+qY5BkTNJdEe5iyzHC+9ay1+4SFKq4m//T+h95kWpvGhK?=
 =?us-ascii?Q?vpwTcSdFaRJ0ANYMmhnETKS7zpZ4V6/zIgbNwl06N43T8LM/wPa1Q/3v9gMt?=
 =?us-ascii?Q?6GLB7s0fBCvP4tR7eNKrQGsSjepcpSSKB927HF8Ob9UO9oembipY66YwCA3m?=
 =?us-ascii?Q?k5ZlZyo2BDKrJ4zn2lYzR526+mYk1yaAJwB2T544rBaK2i0kYDb8iRRcHyuo?=
 =?us-ascii?Q?oBHvVvO/Dcgy/tFveoBbrp/vo+ZCzh22WyBdwsmSvGERYMRLol4lg3saKFTK?=
 =?us-ascii?Q?z9FltetSsUsVf2zjt4TiFIUDsS3I61nuVpekS+GznwTuqUnWuQAuwTXLX6dX?=
 =?us-ascii?Q?A3svoq+GDwTvnEV8gLGR0FRkidiDm6mS4tTXVs2LKF2IUGJw2fY4JYrF0R9F?=
 =?us-ascii?Q?0+Yzu+ox9/cQKNEIiIzXdXU4O3ovn4f8saQ5IMLLHSH1g8yuVQpKcAwrZVa8?=
 =?us-ascii?Q?rTEXJIWt6J9AJ8Ftmw+AvVAkVgsIeT5rswqoTIYRQf6hE4Icp4PFRekIkWWr?=
 =?us-ascii?Q?cmuiBCYbWIo1Ii1PiNdhMtffekWSaD0eU3f5AVMYJ9TT1zjIQ7cXEQw0l/r7?=
 =?us-ascii?Q?JSGKPQlKXlCY4j5i6cmDqaudSbqiAQ9LUmxhEWjgJJe6Zn9cDuRAgcJGhM5R?=
 =?us-ascii?Q?3gcN3Qlu5vJHU8Uxvu0eBr5NEhDm8N2KhW6utAzFU4I67bO9Hewl0fZoonFX?=
 =?us-ascii?Q?OFv+BS/m9+Ld1wozHaXHXiLdaMvY6Z/NNLP1nqWctHmqlg/walL6MPMwLiZU?=
 =?us-ascii?Q?swjpw0YOIkv9I3wRS2AlHIuEKhcU0RDv48HV1oXS/rfDzXU0juuKU4e95ywW?=
 =?us-ascii?Q?pSYqXJduRG4Na2bWLc5y2AdZe3yHF4tR/V9nwvHDKQ3rn6MRJ5IrQylU2Ay0?=
 =?us-ascii?Q?3diG5oK4qHEY7SN5zR07d6nqooNmbVLIIwGj8u9StAw2lnUBmviQVWEzqLR0?=
 =?us-ascii?Q?LpHmucrBZsXXXrVvlbYRC718pmKJoz76wmq10NOdyMXi1j+/xUnfgJQGxN3i?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ab8cad-41e6-4521-78d5-08de12dbab13
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:41.1539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NP3NLaj95m0WxzS5zi5B8zlgVCrO3JxV783snxy5HEbNAj5cfmosJvTkP5X2+lll47QhN2Xd8GZ9+/47/5PGv9miXNnIQqZL74QvZ+elgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

/****************************************************************/
This patch picked from [1] is just for test and can be ignored.
dts/upstream should be synced regularly with devicetree-rebasing.

[1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
/****************************************************************/

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
 .../jh7110s-starfive-visionfive-2-lite.dts    | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
new file mode 100644
index 00000000000..30842b0cd1f
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
@@ -0,0 +1,159 @@
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
+
+		switch-pins {
+			pinmux = <GPIOMUX(62, GPOUT_LOW,
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

