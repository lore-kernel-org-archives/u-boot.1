Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CD6CE8375
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2B68903E;
	Mon, 30 Sep 2024 19:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FA388F94; Mon, 30 Sep 2024 18:56:49 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20714.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C661088D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX3BJrcFNbT9LjmI/VS4zrPeXAJ/JNLcsg7R2eh1eirU7QxW8ZN1LdmjrHkO671/4j9H5VmHM6yYDJv2kt+37C7XnxtBPgQgjalbnfXys8v2kGKtzFCLKypdHwbufeoLcK9Vg2UX797B80p0ckQuzbwxaqVgZrMJ2e2Q6qoZlBVJGf5LwyrFRoCGqXljabhb235QNe8yO9F6Uh/jXjn1cSaRa270V5VkSWxNnToWyNG9aQRjcD9wJr/25zT2Vp+hdyydi+YK3/RKDQ7YDTyveMS/4c9hiEUmjT8olhBGOj+ICbaEdQMmK43NjVtSCV8EFGbEeDw4nlc66Ou3i6Z5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=676eDd6lhJmyRxGmC/RG6w/xS7inPsU2ulf/riKCLjo=;
 b=IXRxw9mrDprmmrs5749erzPhwqBhZd2QVunVelh+tR0YmFVwKjRK7dpU5MNLGkvBjIe8hYGOshv1+cZ2wde9CXvjLKAOPXhO1eLQgN1rrIGnFa/vB7v4AMGTF2YHAkB1HOJrihXtxIEX8lmyaLHpbOVRYNl7PQYXRr2iXwIxnsibK9ioBO3YRGfkD+sKbNn1mRM9dYs8x1tmdnSNY9qM1c2Gia7a0skBwAOPVLHpMJ5b4y6LBGJrekmhbnsIEOKZQFUFU55XM2AQAwuFiRAC4nu/TEg3ZGPHHk1NN9Q46HGbOru5Ld/F82xmv7rsUTJZUUsX8sitYSTmsziXl/qT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:31 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:31 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 03/12] riscv: dts: jh7110: Drop redundant devicetree files
Date: Mon, 30 Sep 2024 23:59:10 +0800
Message-ID: <20240930155919.111738-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc481cb-f1e4-419b-6637-08dce168ded0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: JUEXIOAmE22WmW0OrstyhPkGg528zy15dPq6SxXdhhPyc152syFMA1GML2GlkZgzddRAURa2KpL0wZBE7H5RDeHf+u1j7cY3v3GTGEmB8V2G0AcD+8Qs6MrJidCW1XWtqtffcDfqDfeefG9GR7Yv5wq1MOk5NS60/7Lpb7GRIYK+rfdS4r0ZLiGPx6gReuk1TqTYMCJuiL7Zp8zi1+gU1qLk6xLt+uYKlhYky/Cc2pYPLkjYhfVP9DY876yvEqgokQ+gTaB/07aNMGo9fhYmWkFqh6dNVcAGywmqKta3Y7K7Y1qxRY+yxO6kLNXoWXpSA047p1wq+N/vJjTdgUeUPjMgG2r9uaNziKh7QAeCk19CNcJKbfu523rvblQDrOhal+HkLwAJCdFE9zNMEew7ZCwDFErJG0evNxLmcg2zmAYOc1A00w4zaT5jbNwPKiBafVLzXgb75BHY6B/TnxqP69OFsscSMsIVQkCrwObKnqe2RGGjhznIp4l6FaK3JPQmM+L1lao/XiWCi4jru1BSM67sweW9PQDABnO9uCdCshmhi4Q+NQGso8HpJ67NPoeiSlp2IRAnOxhNVrvP43yDb48wghlwC+pm6EUJJJUFVOq9p07oVseFvccZ43cldnVV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjEWcf/+ePVFvwCEIGeKRVVPf69fQ3M+VNFBeO9VO0IFtOUyIwItDGZ89pUH?=
 =?us-ascii?Q?WIEuIY6f4JGCL+ij7MSw8JfbV/Ru0XKQhDHKCbOaL9LS3GPg4lrvPoCnliy4?=
 =?us-ascii?Q?rMcgNKR0op+jQx4zMKBGBZFhfFHpJ8b0RkMG9vYbwV431YNxGzgDkBNTUNOf?=
 =?us-ascii?Q?pDUfCNk24yJw3p2P5fj6gui5yniEobYymyE+H4J7CKHxsEG+mbo0jOYrZoKo?=
 =?us-ascii?Q?RitQpYSvzs6iP7I5Ch7neeFsgWSAu+CyLZ+mYeY01JMCAOwUaEcckmiNFBZ+?=
 =?us-ascii?Q?ilFdLxYZ7tPjQugrygGK672L2Rn+pEU3CMWBpu/c0Bzx2stUPdIBb2r3v84A?=
 =?us-ascii?Q?D6HojKqEx4KbjZEhc/yLhBv4uSdvn+llL273R64EDbjIlFNpfATsk3G5wD3L?=
 =?us-ascii?Q?AO5cbMC3fPOiNr34BTR0uYFiJlOeNSK5Vh/k16pRWv0+rqDWJ+Sl0kh2Ng+P?=
 =?us-ascii?Q?QyBeysp+SmzqQhJ9dN28Ro2VitPTtT2OIaxVnPuY3XUBy9z/tiK1zqlfebtW?=
 =?us-ascii?Q?nu3zETzrzOHriP8K4N24NVNraw0zShZHrHnwu1+WSwoNnvb0dG8QyiDWn9/L?=
 =?us-ascii?Q?c7fnUceuo6ABlC3iuOO1ivCd7qe+iuPRhV0OnDQJBVAYcT96KwhiWIDa/WVy?=
 =?us-ascii?Q?tTfbZ4Jbw0B6L4H/1jQUFYZ0S4DpYCf5xBVwRbQjsMSEUqoWgDTEl3TyLCbn?=
 =?us-ascii?Q?JMvey5bq2Z4muNYBG3NTyVqUnjM+nRQg7u/w4f+lDH1tVYPACfsF4AECYBko?=
 =?us-ascii?Q?dg0eh6MfdbaZszuSz13B4mSxQS9C2eiXpGmDy/R12l8Cg2o0hXcG6/E7nHjL?=
 =?us-ascii?Q?OIPElxbtMUfXHmKtVUizescqkEYvOPz1wEpj9l6/1x74LavIdap8Nl+0YkwT?=
 =?us-ascii?Q?INggTFVshM+Ka8PMV7Fedz+g7o+19nWEzho1sogg+rxu28It0HFm+kOCK4Zm?=
 =?us-ascii?Q?ELv2YS/WT297d+cTsuGwIX5a240Frn9mgqPY3YTQCdv1CTan7j6WzM5dN7k8?=
 =?us-ascii?Q?rsQibJdRhBTLeqOtm1NokFk/iWVqoVIuRqa9b27mw4nPXz+BhpC4HUnqshlw?=
 =?us-ascii?Q?3nAhH6JTnz8DuXG+nIW9AQt2REf+eMLr89JWMjJmW9WtDcTad7TgIuWSpKEn?=
 =?us-ascii?Q?Yv+v6DKgINDOUgSJiigf5hmExEqsvZGakqJVuCoXSqPz2w3dX2FHc5tJFBP9?=
 =?us-ascii?Q?iYJ1MYOTVYKifmqBqJXShpW+4mMiLZZwVWHkQSS2dzwAeRgHPdidS7fTxDwQ?=
 =?us-ascii?Q?GNDBjZFVI/hskC9DQ4AA7l14UkhPFta5j0vXoRMLx1bHHWjipTFtcI9Jf6Zk?=
 =?us-ascii?Q?bJpikI1Y43kkTmEIN8J+E14TBeqLpGiXMuiLUQje83PgBWxAFMMWSJtvLYdG?=
 =?us-ascii?Q?ha3Z7FdINmVwcI0btTrNsGzTObo6ledVau1YqpaWCEoNqXzMsrU6J/m0uy6b?=
 =?us-ascii?Q?U4RMlCj22GrMmG4L78MToOJFDKHfp1XXY3gh+s/mZedQkYt1FduPiIIEMOGH?=
 =?us-ascii?Q?x037iFeEwjb3+GhdDZ0zR+LiPyhW71x1hprbzoLD2fPAAneY/b0PJ0TkBZ6r?=
 =?us-ascii?Q?y0CVlsGS/vmac1bHjJ6yDD6johNPJXncOe735FIEbIfzezj+aiLu73paycV7?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc481cb-f1e4-419b-6637-08dce168ded0
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:31.2713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/EK1xL4ylaAwtYFeNqs3G9u0n6zH3kYYLoVjkt1/FOfaoFQ1tzHiU6OqYe0bpuf5Y1xzE+ok3cXLtQpGJUaAI8Di7v9JviAb7TqgIcU+9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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
index 17cda483e1..434df3bc1e 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -8,7 +8,6 @@ dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNLEASHED) += hifive-unleashed-a00.dtb
 dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-unmatched-a00.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-visionfive-2.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 
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

