Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8CFD1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E2088FDE;
	Tue,  5 Nov 2024 04:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981D588ECC; Tue,  5 Nov 2024 04:45:03 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2863C88F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqekIjsfXp7rR8Yqx/CegMnZm0asK51kYQ7SNKAU3dHsESTyXdSdDzY5ZH5/ATNKuFNhjoqHbtEY6oCOF3KQdGIyAt3V1pmBqs17NXS2kNEFEsrIam1YIqqJ4WkSZS2ipujiHYNCjZCO6Hwr76dGE379RgwKTRKAWLf4WDSi1G2+BacVj0XDoppqvXSK6rzUh8+Wcg6g1J1qT2VdL0vneuN8YO1RFP0OYYHxDFN63F/tFanHvEsXr9oeQXSTR0d2gtZPQ8oUL+vFply9Z4uvHKNe07Kop/+0FZzQayVh7MayPTJv6WUWNRRcNa0iFzWeXWCsAoscECHbIGMMGds/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57WhjpFh7m0ZEsY55OYF3l3XbFSSIrVpxQ8et7O21cA=;
 b=M9vm5yqzjoeUpclSRD2k9zREyVMoXNo46WNtr2Ty/Ubkd1mLTbrsvlJ0VjtbxhHNngkMLjSz+nAeGP0QnyShPQBFScMEh9+E5ty09bk7lkJOzDD0EBSmfxW72AXbVwp7InE1Prrp784k0ncX+Gr4ZDEC46w6g/yM+gp6kl+pRH34mDKGVTVh0XLuq9baPbUWbfqnB5MhDmQGYcNuTj9lwcOnJz6Ru2aBwf6sz+40KlWpnacF06c2uDnT6DV0vjpiBfyFHr3WT0DISRy23sfzl61c7i3eLckVZdx/guqbQkYXgINV2jXbFej5q4d5CqtQ6hGE1KpX+9CHloU0/DKRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:05 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:05 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 02/13] riscv: dts: jh7110: Drop redundant devicetree files
Date: Tue,  5 Nov 2024 11:43:17 +0800
Message-ID: <20241105034328.56439-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 96860911-2a45-4b51-f8ac-08dcfd4c3c58
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: wsJAMhQliYnVHt+BmYAMSI55SHvvMGubZNEcog05sty07wt5gL0AVGKInyv8L6Cx72YRUrdyDTFonA1zZgObiSJc5F8IR9bo3RjgeouYIGax2n5J2T42Rw8qKH99XhQei9Oe51/LJ7FBdKI/ixBm45oOwoyRsudV2gWRHfUkb5Y07WITHqh2Fqp8ChnakLfJRH4ZEE1Yp4sLYg5CR+/HzhV1jxNWEd1nLlaf4Vry5LjwppllKeUEXsH1v+OQmYwc0O8M879uZ6rVEGms59tZio0E37wEjSChQb44fIscUiU14CcMnLylzdlJF+p8uv9ct9TloqAOO8STgVRhTPF/EbBzY65tTBkuO83VusCN0NxuHeIBCJgV2L7xn4dC7I5vRaEC9evs9GDOG5/ENmjPhfHMsXyQ4W9NWyvTCqEEVoZlpP2/+xlyYUQm9ruj6C4/KbA2mUke2rh5pliIcfG5y2EsTvzPdSKS0b7d0aQzSZPtXAsqPSF2g8CQ4TYr2jCSq6FpJodMi9QqpLPy9dsCWFWwlC8oAZwdKow0Tr/V2m0UdbhGeOs0yd0njAhsQ28jYqjt5W6pHRhnFlBTqmW94HRy9z88FbN4twiZrHD79Roee4zEsRdHT6DutqQirOl9SVL019/ftm9R/EtH/h4RkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjM79QNOGDActjat7YGy0f6H38t6dPK5viJ+qhvZvIamHIsGns1VGrDYztqL?=
 =?us-ascii?Q?hZtEL0QZDruWfkcBfNE0n4qLLOgUlX9lT/aGPiTqRxP87z8JU+Mn2SJpiMbM?=
 =?us-ascii?Q?AZjrkd3bbZ7UsYTADZ/3v42KqWw3WNCvhXwKfmsOdWYOCvDev5tuiDNmBZS3?=
 =?us-ascii?Q?f8tC0HNeXfWr+ZNnWB+THw9gCMDWOKNTOkm7aTT8gMIDZfOTyyecz6GcOwQJ?=
 =?us-ascii?Q?ev0QgPzkqlzbqso2DEYY6BqAde4ZI3JMWavN0wGKuql0Zd2SPyRHoiNZcQnZ?=
 =?us-ascii?Q?eU0IXRRMZxA9ISgs/IODrskkG1KkvxZiyN4EOHlzdqq52eJ2KqGHoRWGsWJ7?=
 =?us-ascii?Q?ppLSYyciE8k7E7Hy7wh9Y6ihPF+eq1MwXf7LWi1/pXfY6PN831NDC/+Tu8Oy?=
 =?us-ascii?Q?MquFF7R7vQ7xGnNZCY00lxKiXQUbaZbSnzXsr/3AbPawFjqWglWbe5eozHgq?=
 =?us-ascii?Q?JEWn2UzNPPPfhDYCmHAWyPMfvnCrDP6pLvE2HgKdvQAVxW7e2jxbSME2waHt?=
 =?us-ascii?Q?uwZ8pKIq/tQ3xwqkspHxhhMPmkIM88nZJDkFIjTyG55ZdfwxneiZSCNHm7Pk?=
 =?us-ascii?Q?J4lpzqNohbw8olIgaH8t2Z2MhtAoCcmE6/tzw4/5Mg2VqJOl7bO57prgdc8F?=
 =?us-ascii?Q?fUtam+dCX+C+M7sugO2zhhnzzNGaS/9+6C9uN4vlWFZQzndzp5ZlDVlIFYaW?=
 =?us-ascii?Q?1Cxnxb83e1TCsLusH5P3Nj3Y+6dRr0qXq9qS35C3JSmGGy86qDBXbNtX7WEF?=
 =?us-ascii?Q?mHopsJkWZDCthnOS0qswhPPQByBLFByoDJGR4BfyUrbqYIm/9BxVEez/Jmkm?=
 =?us-ascii?Q?vx1dc3PuN97SWfbcEnQ3YrG2UFzuoxeSwNDT2ltxdQa9Zgg7jGYkJZBHY/F5?=
 =?us-ascii?Q?7YhCfmSDwCIb4IUNJIExJnDCOn5o/UcvhDvTyqiQcslEwBRMPgbO8KWz6EH/?=
 =?us-ascii?Q?7RTSBM8cmBc0IppEp3f0Ph4uPm0lNMZp1O+W2qZDyE0T1VE2MsvyG5XPGFBk?=
 =?us-ascii?Q?9AlyWAQDiLKKqs2cCHo899IaIp5K76/fQWYd0OdKN7sPM8F7QQOROYuVTaXJ?=
 =?us-ascii?Q?NiLmVqLaB6r0UPGcHQy79yxPlS3JsAGQ8vNzZ/db54U0xKyYF93pn6HICpZI?=
 =?us-ascii?Q?vxNXcliovTwQLz9ujRtTxntAJf/I2Wlu37tAS+FmjGLm6xQrwYHEEvhW3j/r?=
 =?us-ascii?Q?QGKIiFI0EPvxcLjJojDAguejXdHW2ZzW0Ey+lxionKNXuDzLIO4l6MVFvkyA?=
 =?us-ascii?Q?554qXzin0Bakd8EhzkUGHe4KmVeg4eK8jc31lMGjH6geMWLbOaDMnwRHiu6Q?=
 =?us-ascii?Q?nWLDRky9neOhX+GXxHs7CkCikNTRI2xmQqS5svBq9FDq9hIbY3CqWEEMfnXS?=
 =?us-ascii?Q?ql/8nFtyxYjjgsMneJJVzHhK5GxUZxgAvzGXUCwMz42OmaiWI0CgdfmSFg56?=
 =?us-ascii?Q?4NmfhRix72sDB26znV6jl7RLb+GGB7aJLabnNYpSZtuuWXTGaNL9D04PDLww?=
 =?us-ascii?Q?NpjA5qaRTTYgFVQACgXlExRobQgDQREOo3YHy/rweDc1k35EAmzClnyuIcn3?=
 =?us-ascii?Q?BytLJ1RkIDl9sr01PSGSaon4vlwhcufYjh3kbW+pWB6VfbmUN0aM118OifFn?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96860911-2a45-4b51-f8ac-08dcfd4c3c58
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:05.2925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INuM3zhSHG7UzZsX3YKfV0XbpX0Q8/gyNTlPtg+F0b17XOr15jQXrkTdbrI8z1L6Q+3TrwPQBz7WZgTbXyr/MlWIKAVHw1Vx9KYfnvnn08s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

JH7110 boards switch to using upstream DT, so drop
redundant DT files from arch/riscv/dts/.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/Makefile                       |   1 -
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 4 files changed, 1153 deletions(-)
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index bf32ead01b..2339ae6381 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -7,7 +7,6 @@ dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-unmatched-a00.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-visionfive-2.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dts b/arch/riscv/dts/jh7110-starfive-visionfive-2.dts
deleted file mode 100644
index 288ea39493..0000000000
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dts
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2023 StarFive Technology Co., Ltd.
- */
-
-/dts-v1/;
-#include "jh7110-starfive-visionfive-2.dtsi"
-
-/ {
-	compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
-};
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
deleted file mode 100644
index e11babc1cd..0000000000
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ /dev/null
@@ -1,380 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- */
-
-/dts-v1/;
-
-#include "jh7110.dtsi"
-#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
-#include <dt-bindings/gpio/gpio.h>
-/ {
-	aliases {
-		serial0 = &uart0;
-		spi0 = &qspi;
-		mmc0 = &mmc0;
-		mmc1 = &mmc1;
-		i2c0 = &i2c0;
-		i2c2 = &i2c2;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	cpus {
-		timebase-frequency = <4000000>;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x2 0x0>;
-	};
-
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&osc {
-	clock-frequency = <24000000>;
-};
-
-&rtc_osc {
-	clock-frequency = <32768>;
-};
-
-&gmac0_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&gmac0_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac1_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&gmac1_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&i2stx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2stx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&i2srx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2srx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&tdm_ext {
-	clock-frequency = <49152000>;
-};
-
-&mclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&uart0 {
-	reg-offset = <0>;
-	current-speed = <115200>;
-	clock-frequency = <24000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&i2c5 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c5_pins>;
-	status = "okay";
-
-	pmic@36 {
-		compatible = "x-powers,axp15060";
-		reg = <0x36>;
-	};
-
-	eeprom@50 {
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&i2c6 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
-	status = "okay";
-};
-
-&sysgpio {
-	status = "okay";
-	uart0_pins: uart0-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
-					     GPOEN_ENABLE,
-					     GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(6, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_UART0_RX)>;
-			bias-disable; /* external pull-up */
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-
-	i2c0_pins: i2c0-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(57, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_CLK,
-					      GPI_SYS_I2C0_CLK)>,
-				 <GPIOMUX(58, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_DATA,
-					      GPI_SYS_I2C0_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c2_pins: i2c2-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(3, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_CLK,
-					     GPI_SYS_I2C2_CLK)>,
-				 <GPIOMUX(2, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_DATA,
-					     GPI_SYS_I2C2_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c5_pins: i2c5-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(19, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_CLK,
-					      GPI_SYS_I2C5_CLK)>,
-				 <GPIOMUX(20, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_DATA,
-					      GPI_SYS_I2C5_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c6_pins: i2c6-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(16, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_CLK,
-					      GPI_SYS_I2C6_CLK)>,
-				 <GPIOMUX(17, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_DATA,
-					      GPI_SYS_I2C6_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	mmc0_pins: mmc0-pins {
-		 mmc0-pins-rest {
-			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
-					      GPOEN_ENABLE, GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	mmc1_pins: mmc1-pins {
-		mmc1-pins0 {
-			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
-					      GPOEN_ENABLE, GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc1-pins1 {
-			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
-					     GPOEN_SYS_SDIO1_CMD, GPI_SYS_SDIO1_CMD)>,
-				<GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
-					     GPOEN_SYS_SDIO1_DATA0, GPI_SYS_SDIO1_DATA0)>,
-				<GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
-					     GPOEN_SYS_SDIO1_DATA1, GPI_SYS_SDIO1_DATA1)>,
-				<GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
-					     GPOEN_SYS_SDIO1_DATA2, GPI_SYS_SDIO1_DATA2)>,
-				<GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
-					     GPOEN_SYS_SDIO1_DATA3, GPI_SYS_SDIO1_DATA3)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&mmc0 {
-	compatible = "snps,dw-mshc";
-	max-frequency = <100000000>;
-	bus-width = <8>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	cap-mmc-hw-reset;
-	post-power-on-delay-ms = <200>;
-	status = "okay";
-
-};
-
-&mmc1 {
-	compatible = "snps,dw-mshc";
-	max-frequency = <100000000>;
-	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	no-sdio;
-	no-mmc;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
-	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
-	status = "okay";
-};
-
-&qspi {
-	spi-max-frequency = <250000000>;
-	status = "okay";
-
-	nor-flash@0 {
-		compatible = "jedec,spi-nor";
-		reg=<0>;
-		spi-max-frequency = <100000000>;
-		cdns,tshsl-ns = <1>;
-		cdns,tsd2d-ns = <1>;
-		cdns,tchsh-ns = <1>;
-		cdns,tslch-ns = <1>;
-	};
-};
-
-&pcie0 {
-	reset-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&pcie1 {
-	reset-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&syscrg {
-	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
-			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
-			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
-			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
-	assigned-clock-parents = <&pllclk JH7110_SYSCLK_PLL0_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>,
-				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
-	assigned-clock-rates = <0>, <0>, <0>, <0>;
-};
-
-&aoncrg {
-	assigned-clocks = <&aoncrg JH7110_AONCLK_APB_FUNC>;
-	assigned-clock-parents = <&osc>;
-	assigned-clock-rates = <0>;
-};
-
-&gmac0 {
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
-	};
-};
-
-&gmac1 {
-	phy-handle = <&phy1>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy1: ethernet-phy@1 {
-			reg = <0>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
deleted file mode 100644
index 2cdc683d49..0000000000
--- a/arch/riscv/dts/jh7110.dtsi
+++ /dev/null
@@ -1,761 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- */
-
-/dts-v1/;
-#include <dt-bindings/clock/starfive,jh7110-crg.h>
-#include <dt-bindings/reset/starfive,jh7110-crg.h>
-
-/ {
-	compatible = "starfive,jh7110";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		S7_0: cpu@0 {
-			compatible = "sifive,s7", "riscv";
-			reg = <0>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <16384>;
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imac_zba_zbb";
-			status = "disabled";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_1: cpu@1 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <1>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu1_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_2: cpu@2 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <2>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu2_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_3: cpu@3 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <3>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu3_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		U74_4: cpu@4 {
-			compatible = "sifive,u74-mc", "riscv";
-			reg = <4>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <64>;
-			d-cache-size = <32768>;
-			d-tlb-sets = <1>;
-			d-tlb-size = <40>;
-			device_type = "cpu";
-			i-cache-block-size = <64>;
-			i-cache-sets = <64>;
-			i-cache-size = <32768>;
-			i-tlb-sets = <1>;
-			i-tlb-size = <40>;
-			mmu-type = "riscv,sv39";
-			next-level-cache = <&ccache>;
-			riscv,isa = "rv64imafdc_zba_zbb";
-			tlb-split;
-
-			cpu4_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&S7_0>;
-				};
-
-				core1 {
-					cpu = <&U74_1>;
-				};
-
-				core2 {
-					cpu = <&U74_2>;
-				};
-
-				core3 {
-					cpu = <&U74_3>;
-				};
-
-				core4 {
-					cpu = <&U74_4>;
-				};
-			};
-		};
-	};
-
-	timer {
-		compatible = "riscv,timer";
-		interrupts-extended = <&cpu0_intc 5>,
-				      <&cpu1_intc 5>,
-				      <&cpu2_intc 5>,
-				      <&cpu3_intc 5>,
-				      <&cpu4_intc 5>;
-	};
-
-	osc: oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc";
-		#clock-cells = <0>;
-	};
-
-	rtc_osc: rtc-oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "rtc_osc";
-		#clock-cells = <0>;
-	};
-
-	gmac0_rmii_refin: gmac0-rmii-refin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac0_rmii_refin";
-		#clock-cells = <0>;
-	};
-
-	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac0_rgmii_rxin";
-		#clock-cells = <0>;
-	};
-
-	gmac1_rmii_refin: gmac1-rmii-refin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac1_rmii_refin";
-		#clock-cells = <0>;
-	};
-
-	gmac1_rgmii_rxin: gmac1-rgmii-rxin-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "gmac1_rgmii_rxin";
-		#clock-cells = <0>;
-	};
-
-	i2stx_bclk_ext: i2stx-bclk-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2stx_bclk_ext";
-		#clock-cells = <0>;
-	};
-
-	i2stx_lrck_ext: i2stx-lrck-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2stx_lrck_ext";
-		#clock-cells = <0>;
-	};
-
-	i2srx_bclk_ext: i2srx-bclk-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2srx_bclk_ext";
-		#clock-cells = <0>;
-	};
-
-	i2srx_lrck_ext: i2srx-lrck-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "i2srx_lrck_ext";
-		#clock-cells = <0>;
-	};
-
-	tdm_ext: tdm-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "tdm_ext";
-		#clock-cells = <0>;
-	};
-
-	mclk_ext: mclk-ext-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "mclk_ext";
-		#clock-cells = <0>;
-	};
-
-	stmmac_axi_setup: stmmac-axi-config {
-		snps,lpi_en;
-		snps,wr_osr_lmt = <4>;
-		snps,rd_osr_lmt = <4>;
-		snps,blen = <256 128 64 32 0 0 0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		clint: timer@2000000 {
-			compatible = "starfive,jh7110-clint", "sifive,clint0";
-			reg = <0x0 0x2000000 0x0 0x10000>;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
-					      <&cpu1_intc 3>, <&cpu1_intc 7>,
-					      <&cpu2_intc 3>, <&cpu2_intc 7>,
-					      <&cpu3_intc 3>, <&cpu3_intc 7>,
-					      <&cpu4_intc 3>, <&cpu4_intc 7>;
-		};
-
-		plic: interrupt-controller@c000000 {
-			compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
-			reg = <0x0 0xc000000 0x0 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11>,
-					      <&cpu1_intc 11>, <&cpu1_intc 9>,
-					      <&cpu2_intc 11>, <&cpu2_intc 9>,
-					      <&cpu3_intc 11>, <&cpu3_intc 9>,
-					      <&cpu4_intc 11>, <&cpu4_intc 9>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			riscv,ndev = <136>;
-		};
-
-		ccache: cache-controller@2010000 {
-			compatible = "starfive,jh7110-ccache", "sifive,ccache0", "cache";
-			reg = <0x0 0x2010000 0x0 0x4000>;
-			interrupts = <1>, <3>, <4>, <2>;
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-sets = <2048>;
-			cache-size = <2097152>;
-			cache-unified;
-		};
-
-		uart0: serial@10000000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x10000000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART0_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART0_APB>,
-				 <&syscrg JH7110_SYSRST_UART0_CORE>;
-			interrupts = <32>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart1: serial@10010000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x10010000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART1_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART1_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART1_APB>,
-				 <&syscrg JH7110_SYSRST_UART1_CORE>;
-			interrupts = <33>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart2: serial@10020000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x10020000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART2_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART2_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART2_APB>,
-				 <&syscrg JH7110_SYSRST_UART2_CORE>;
-			interrupts = <34>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		i2c0: i2c@10030000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x10030000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C0_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C0_APB>;
-			interrupts = <35>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@10040000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x10040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C1_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C1_APB>;
-			interrupts = <36>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@10050000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x10050000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C2_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C2_APB>;
-			interrupts = <37>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		stgcrg: clock-controller@10230000 {
-			compatible = "starfive,jh7110-stgcrg";
-			reg = <0x0 0x10230000 0x0 0x10000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		stg_syscon: stg_syscon@10240000 {
-			compatible = "starfive,jh7110-stg-syscon","syscon";
-			reg = <0x0 0x10240000 0x0 0x1000>;
-		};
-
-		uart3: serial@12000000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x12000000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART3_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART3_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART3_APB>,
-				 <&syscrg JH7110_SYSRST_UART3_CORE>;
-			interrupts = <45>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart4: serial@12010000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x12010000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART4_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART4_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART4_APB>,
-				 <&syscrg JH7110_SYSRST_UART4_CORE>;
-			interrupts = <46>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		uart5: serial@12020000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x0 0x12020000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_UART5_CORE>,
-				 <&syscrg JH7110_SYSCLK_UART5_APB>;
-			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART5_APB>,
-				 <&syscrg JH7110_SYSRST_UART5_CORE>;
-			interrupts = <47>;
-			reg-io-width = <4>;
-			reg-shift = <2>;
-			status = "disabled";
-		};
-
-		i2c3: i2c@12030000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12030000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C3_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C3_APB>;
-			interrupts = <48>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c4: i2c@12040000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C4_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C4_APB>;
-			interrupts = <49>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c5: i2c@12050000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12050000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C5_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C5_APB>;
-			interrupts = <50>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c6: i2c@12060000 {
-			compatible = "snps,designware-i2c";
-			reg = <0x0 0x12060000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_I2C6_APB>;
-			clock-names = "ref";
-			resets = <&syscrg JH7110_SYSRST_I2C6_APB>;
-			interrupts = <51>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		power-controller@17030000 {
-			compatible = "starfive,jh7110-pmu";
-			reg = <0x0 0x17030000 0x0 0x10000>;
-			interrupts = <111>;
-		};
-
-		qspi: spi@13010000 {
-			compatible = "cdns,qspi-nor";
-			reg = <0x0 0x13010000 0x0 0x10000
-				0x0 0x21000000 0x0 0x400000>;
-			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>;
-			clock-names = "clk_ref";
-			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
-				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
-				 <&syscrg JH7110_SYSRST_QSPI_REF>;
-			reset-names = "rst_apb", "rst_ahb", "rst_ref";
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		syscrg: clock-controller@13020000 {
-			compatible = "starfive,jh7110-syscrg";
-			reg = <0x0 0x13020000 0x0 0x10000>;
-			clocks = <&osc>, <&gmac1_rmii_refin>,
-				 <&gmac1_rgmii_rxin>,
-				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
-				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
-				 <&tdm_ext>, <&mclk_ext>,
-				 <&pllclk JH7110_SYSCLK_PLL0_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL1_OUT>,
-				 <&pllclk JH7110_SYSCLK_PLL2_OUT>;
-			clock-names = "osc", "gmac1_rmii_refin",
-				      "gmac1_rgmii_rxin",
-				      "i2stx_bclk_ext", "i2stx_lrck_ext",
-				      "i2srx_bclk_ext", "i2srx_lrck_ext",
-				      "tdm_ext", "mclk_ext",
-				      "pll0_out", "pll1_out", "pll2_out";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		sys_syscon: sys_syscon@13030000 {
-			compatible = "starfive,jh7110-sys-syscon","syscon", "simple-mfd";
-			reg = <0x0 0x13030000 0x0 0x1000>;
-
-			pllclk: clock-controller {
-				compatible = "starfive,jh7110-pll";
-				clocks = <&osc>;
-				#clock-cells = <1>;
-			};
-		};
-
-		sysgpio: pinctrl@13040000 {
-			compatible = "starfive,jh7110-sys-pinctrl";
-			reg = <0x0 0x13040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_IOMUX_APB>;
-			resets = <&syscrg JH7110_SYSRST_IOMUX_APB>;
-			interrupts = <86>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-
-		watchdog@13070000 {
-			compatible = "starfive,jh7110-wdt";
-			reg = <0x0 0x13070000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_WDT_APB>,
-				 <&syscrg JH7110_SYSCLK_WDT_CORE>;
-			clock-names = "apb", "core";
-			resets = <&syscrg JH7110_SYSRST_WDT_APB>,
-				 <&syscrg JH7110_SYSRST_WDT_CORE>;
-		};
-
-		mmc0: mmc@16010000 {
-			compatible = "starfive,jh7110-mmc";
-			reg = <0x0 0x16010000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
-				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
-			clock-names = "biu", "ciu";
-			resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
-			reset-names = "reset";
-			interrupts = <74>;
-			fifo-depth = <32>;
-			fifo-watermark-aligned;
-			data-addr = <0>;
-			starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
-			status = "disabled";
-		};
-
-		mmc1: mmc@16020000 {
-			compatible = "starfive,jh7110-mmc";
-			reg = <0x0 0x16020000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
-				 <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
-			clock-names = "biu", "ciu";
-			resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
-			reset-names = "reset";
-			interrupts = <75>;
-			fifo-depth = <32>;
-			fifo-watermark-aligned;
-			data-addr = <0>;
-			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
-			status = "disabled";
-		};
-
-		gmac0: ethernet@16030000 {
-			compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
-			reg = <0x0 0x16030000 0x0 0x10000>;
-			clocks = <&aoncrg JH7110_AONCLK_GMAC0_AXI>,
-				 <&aoncrg JH7110_AONCLK_GMAC0_AHB>,
-				 <&syscrg JH7110_SYSCLK_GMAC0_PTP>,
-				 <&aoncrg JH7110_AONCLK_GMAC0_TX_INV>,
-				 <&syscrg JH7110_SYSCLK_GMAC0_GTXC>;
-			clock-names = "stmmaceth", "pclk", "ptp_ref",
-				      "tx", "gtx";
-			resets = <&aoncrg JH7110_AONRST_GMAC0_AXI>,
-				 <&aoncrg JH7110_AONRST_GMAC0_AHB>;
-			reset-names = "stmmaceth", "ahb";
-			interrupts = <7>, <6>, <5>;
-			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
-			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <8>;
-			rx-fifo-depth = <2048>;
-			tx-fifo-depth = <2048>;
-			snps,fixed-burst;
-			snps,no-pbl-x8;
-			snps,force_thresh_dma_mode;
-			snps,axi-config = <&stmmac_axi_setup>;
-			snps,tso;
-			snps,en-tx-lpi-clockgating;
-			snps,txpbl = <16>;
-			snps,rxpbl = <16>;
-			starfive,syscon = <&aon_syscon 0xc 0x12>;
-			status = "disabled";
-		};
-
-		gmac1: ethernet@16040000 {
-			compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
-			reg = <0x0 0x16040000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_GMAC1_AXI>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_AHB>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_PTP>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_TX_INV>,
-				 <&syscrg JH7110_SYSCLK_GMAC1_GTXC>;
-			clock-names = "stmmaceth", "pclk", "ptp_ref",
-				      "tx", "gtx";
-			resets = <&syscrg JH7110_SYSRST_GMAC1_AXI>,
-				 <&syscrg JH7110_SYSRST_GMAC1_AHB>;
-			reset-names = "stmmaceth", "ahb";
-			interrupts = <78>, <77>, <76>;
-			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
-			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <8>;
-			rx-fifo-depth = <2048>;
-			tx-fifo-depth = <2048>;
-			snps,fixed-burst;
-			snps,no-pbl-x8;
-			snps,force_thresh_dma_mode;
-			snps,axi-config = <&stmmac_axi_setup>;
-			snps,tso;
-			snps,en-tx-lpi-clockgating;
-			snps,txpbl = <16>;
-			snps,rxpbl = <16>;
-			starfive,syscon = <&sys_syscon 0x90 0x2>;
-			status = "disabled";
-		};
-
-		rng: rng@1600c000 {
-			compatible = "starfive,jh7110-trng";
-			reg = <0x0 0x1600C000 0x0 0x4000>;
-			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
-				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
-			clock-names = "hclk", "ahb";
-			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
-			interrupts = <30>;
-		};
-
-		aoncrg: clock-controller@17000000 {
-			compatible = "starfive,jh7110-aoncrg";
-			reg = <0x0 0x17000000 0x0 0x10000>;
-			clocks = <&osc>, <&rtc_osc>,
-				 <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
-				 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
-				 <&syscrg JH7110_SYSCLK_APB_BUS>,
-				 <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>;
-			clock-names = "osc", "rtc_osc", "gmac0_rmii_refin",
-				      "gmac0_rgmii_rxin", "stg_axiahb",
-				      "apb_bus", "gmac0_gtxclk";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		aon_syscon: aon_syscon@17010000 {
-			compatible = "starfive,jh7110-aon-syscon","syscon";
-			reg = <0x0 0x17010000 0x0 0x1000>;
-		};
-
-		aongpio: pinctrl@17020000 {
-			compatible = "starfive,jh7110-aon-pinctrl";
-			reg = <0x0 0x17020000 0x0 0x10000>;
-			resets = <&aoncrg JH7110_AONRST_IOMUX>;
-			interrupts = <85>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
-
-		pcie0: pcie@2b000000 {
-			compatible = "starfive,jh7110-pcie";
-			reg = <0x0 0x2b000000 0x0 0x1000000
-			       0x9 0x40000000 0x0 0x10000000>;
-			reg-names = "reg", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
-				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
-			interrupts = <56>;
-			interrupt-parent = <&plic>;
-			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-			interrupt-map = <0x0 0x0 0x0 0x1 &plic 0x1>,
-					<0x0 0x0 0x0 0x2 &plic 0x2>,
-					<0x0 0x0 0x0 0x3 &plic 0x3>,
-					<0x0 0x0 0x0 0x4 &plic 0x4>;
-			msi-parent = <&plic>;
-			device_type = "pci";
-			starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
-			bus-range = <0x0 0xff>;
-			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
-			clock-names = "noc", "tl", "axi", "apb";
-			resets = <&stgcrg JH7110_STGRST_PCIE0_MST0>,
-				 <&stgcrg JH7110_STGRST_PCIE0_SLV0>,
-				 <&stgcrg JH7110_STGRST_PCIE0_SLV>,
-				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
-				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
-				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
-			reset-names = "mst0", "slv0", "slv", "brg",
-				      "core", "apb";
-			status = "disabled";
-		};
-
-		pcie1: pcie@2c000000 {
-			compatible = "starfive,jh7110-pcie";
-			reg = <0x0 0x2c000000 0x0 0x1000000
-			       0x9 0xc0000000 0x0 0x10000000>;
-			reg-names = "reg", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000>,
-				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
-			interrupts = <57>;
-			interrupt-parent = <&plic>;
-			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-			interrupt-map = <0x0 0x0 0x0 0x1 &plic 0x1>,
-					<0x0 0x0 0x0 0x2 &plic 0x2>,
-					<0x0 0x0 0x0 0x3 &plic 0x3>,
-					<0x0 0x0 0x0 0x4 &plic 0x4>;
-			msi-parent = <&plic>;
-			device_type = "pci";
-			starfive,stg-syscon = <&stg_syscon 0x270 0x274 0x2e0 0x368>;
-			bus-range = <0x0 0xff>;
-			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_AXI>,
-				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
-			clock-names = "noc", "tl", "axi", "apb";
-			resets = <&stgcrg JH7110_STGRST_PCIE1_MST0>,
-				 <&stgcrg JH7110_STGRST_PCIE1_SLV0>,
-				 <&stgcrg JH7110_STGRST_PCIE1_SLV>,
-				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
-				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
-				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
-			reset-names = "mst0", "slv0", "slv", "brg",
-				      "core", "apb";
-			status = "disabled";
-		};
-	};
-};
-- 
2.43.2

