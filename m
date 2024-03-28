Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DA0C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9FB880DD;
	Thu, 28 Mar 2024 02:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cU7Kt2lK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F75F8808A; Thu, 28 Mar 2024 02:27:11 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500A288096
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB73/mMhKCyaFj44O3xSmUJ1sLvTIXXyiDrnZGFOape92qSh81ZUFFo4wAjMqa04ZdprEPQIrRPBt4a9N69cmE6GQirRM/RAD/2vWb4fnoxYVRz88jiUUoKBAj7jg19LufZMVSXLH86RjKe7+1TkdtF8zpb6a1n4ZYI/GtiUkrzWZD/lE/TxJtaI/n8gdR8QpI3GMXCGbvii32ZFqqHEVO60K8xwxU6YiV6/F7o2lVIfK+Wz5xNgD+L6oBwLRpu7lhDXBSGLpH/40qz23VYSosXfsOeKKeiXHlGqSJNxEBQDLGWIkWb8krrZkXfPVhGGoz67Pa+5LCrry1DVBF1EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akP9mFsq15yOf6aaODc8eBlM5sqjCctfOE6fSWAmEJk=;
 b=oWk89pZXLFyV0ZIPQ7rKza6/4EMdBCwolB/SIZYv8Ikdo0NWO/MDfMWb63ToRFn/dJaGnXv2Gf0RMWIniCPJBHCsQ/VPdwP9fSTwdLRyYgDMKxqvfQPp7SJTp5QoZmxTEtOfxmTIVviFeKUw5MmOozWDPoUZqs7i/iuSyWyYEhUkr/axZ/jv6K7Sk3V8TJ+H8+zuupNAqDkAVI2CFC0d5asJ+GBrXfoH2CcGVgq5jKtFd6N8IjPCHxdn8Wpzmahbwrb7O6bm6dYFz0ndcogkC2cn0+qfLyxzM9HNaaLlvZ8DeizkjjIsSGDnc6pXytO36bbtyRNg31RN4qtoh6HBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akP9mFsq15yOf6aaODc8eBlM5sqjCctfOE6fSWAmEJk=;
 b=cU7Kt2lKSeYJ43GXmmQmd6nVLfEYMjwKnkADPbGlj6T3jogJjD+dMZaYmBWZS1OjZyGnrKCtSrP1YJRammxr8Q6yBqoYSV+QQsD30MUtgD43m6f3wsZhxgzx+ZG1Ssnum0fUyG5zt6Mq6jK4WO6uSnav8j/ErIpXa61a3R98xgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 01:27:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:27:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:26:37 +0800
Subject: [PATCH 4/4] imx: imx8mp_evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v1-4-2be5e6657a88@nxp.com>
References: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
In-Reply-To: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5d7122-9c8f-4b5e-2948-08dc4ec62ee7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/Crh2rwEE5QxJVGkrbl1mU3RdDKOzJh3Yw1VaSnVb4OsBUzdRQykSQHeP6ETP9ZAdrU6/MEw0iDtZwzfpwtVnwb0QGN1foKNULmoKS0pJ0NvUWTXpg6khNI2lkDYZOUr7EVTXWJO7p3s/FWbx2u8oQMulaEAWp+phT3AJgqV2JnPNGLn4C0h4SZJ98eIDRKP5T3cCmZljyAUFjsKCDtjDjQlKJd76YiYwKmoWpR9xgPhrBmrDtzRfBZ7E8IKVDRQcwVjlgvBKA689lZU/+7L5cbvkQWx4VPJklUFm0ibidvDkhf2S8e9Qy/siDdb64tkCVbMra6daZkC+KhR67gpBiu+FNNBpG0ogpf4gHFr0ToXAPw3FeMxg7IgV4Lxb+0GYaDaMlBKh/78zDEnrjY2sxziQCz4wySd/BqN7AM0rtKQMm7LQZmQe8BdBpySP9oB9sDDKkrvxMtsmCrRFqAkDCJWUjQWVMutvK7x9YX440anrvmWc/x+7gA3lG0ghsnmxETy09QaJUTFzz46svi0C06C32brCqiDj97gNSL2mmiaMIk1nKNiit2eOOqdy4GlGZv0a1mbB8gpZ2qAJ1gFodBBnyXrokGG2OBjnQ6cFrVyf9kbWKXwAv6kicqe+FD34WKyNl5D/0iKIxr1M+nqnQ1hF9T/bSmpEsY+3CfB/JIG12bqQHaODVDJ/zIdgU7E66/pKTnn09ZZxoNZ5EYt2Fns5im1KyWaL1Qnw4KlOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUd4T1hwYzk3aUdadUhsMFVEZTJrNVUzcnR4WWIrbmlTT0VNWkZpZGdtRndn?=
 =?utf-8?B?Z2JPK1I4dDlJTkIvTlc0VE5TVjV1Q1E3U0pPdWlTTVhJenZDVWUzMW44NU80?=
 =?utf-8?B?Vk43S05RUDY3UUNsT25rd0N3NHFYTVdvempmcDcvcDRSNHhQK3RWQSswaEdR?=
 =?utf-8?B?OHphdThnalRRRTVvd3o5UW92NXBlN2oyVVpxUmVVOXNoRnQ1cWdkTnFDay9u?=
 =?utf-8?B?UW9TWGJUcUhSM1oxT2EyYlY3cWE5KzRQMU5RZkIyZ2RqMDZacFZLcnRKR0g0?=
 =?utf-8?B?N3RzbHdqb1E5dStjN25xQXJRbTJ6K3FDWG1WdkJtcTFLVFc2MDJWT2dKVTNX?=
 =?utf-8?B?VldaZXZyTmZQdTdCbm42ekRySlpWdWFvKy8xakxienpQb2E3SUtFNlBDSk1y?=
 =?utf-8?B?NnJXNU9Pajl4NEFPTE9lQXlEUmc2dVRsNDNFNnVaVGlDbEdCR3lLczNaL05K?=
 =?utf-8?B?Z0JibDFNUU1GNnJET3pUM216RWpZSHIyeXMybjVqdStZYlRld3NGd0c3bWt6?=
 =?utf-8?B?NHlYdUovVVNzb1M2NndvWVFiT2JGR2dlVVh3cXZTYzlRWlIxcUZmWm94OEVv?=
 =?utf-8?B?c1BrRjYybWdRbk93ZUJRN2gvSTAvdFh6dC9TK256VjdFOUZwNVpvRWtPZy9U?=
 =?utf-8?B?MzdpZHNoWEN3VUttaWd2anlsaTVkNlBDVURZWEZ1SW5yZTMweDNXdVhQaWY2?=
 =?utf-8?B?RlN2MTM5TUE2cUhPY0pDdVpYRUZ1d0tGRCtkN3JITXFmdjltaWRWOCtEWVBJ?=
 =?utf-8?B?S1hvWHFkQ0paMDVMZUpiaWpHdVVoSGxiaGRHTW9YSFFZWVBNRFU3MklLTjk2?=
 =?utf-8?B?UCtkZHZlOVdwNUh1NExhZ05TWVVnU05wZ0hlNGVwY1pUSTVxcko4b2xrandW?=
 =?utf-8?B?RVhYczVNZWVHMk03SjlvNkVlaDdLNVVabEtGVlZDRnBXaVJJb042bUdSeGo1?=
 =?utf-8?B?cmE0a2Y3ZUpHV1ltMlExeS9BcTFzeFhhN1JJZU51N3JZZDZSTHFhSlJycCt1?=
 =?utf-8?B?MExISFJSUXVzUlNXT3YxWlhnUnc4RWo0MVc4d0hobjBwd0h5cTRYdHRLTXJI?=
 =?utf-8?B?Rk14dkhBb0MrcWgxRCt1eWZaMmdEM1lsN2VrNzNQNnVwQU1tL2pTblJVQm5w?=
 =?utf-8?B?ZnV0RnVpSVpLbDBpWnkzUi8yb1YrZ0VSSkxFd1hGMlZodng5dGp0NXB3TXJE?=
 =?utf-8?B?eWVXSk1nbmRTRHg2TXZSTHhDbHJESFUrTmJucWxBZ3hTRmtLKzJhYWJjNVBQ?=
 =?utf-8?B?T3BKR0xxSFo2Z2FVRGRyNG80SlA2b0k2bHphK0UxcWorek83Z3BFcDE2S2NO?=
 =?utf-8?B?UUtGMTNheTBSaUQ2R2FhbWlhcE5MckQ5UlprdkpaTm91djFTZ2s2Y2FrUFpx?=
 =?utf-8?B?K3ljNk9kSTV2OUJoZzBBTVdCV3A0ZkxkSTVoUU9hYmM3d2lNd2wvU01YRHJ0?=
 =?utf-8?B?ZytxOWYxY0pNSlB4b2ROZHRNd1U4NWQ2Y1kvYU1oaHo3SEZmcU1PYzdzemtm?=
 =?utf-8?B?bWhBYTNkQWRqeVRXNW8vbzFxZWJiUFc3dGNOVUZoSVZYeVZHajhpR1VWRzdy?=
 =?utf-8?B?dkxmMnJSZEVONUZZMjN2K05aOVlqSWRYaWZuM0t0UTNsMnY3TWNKWmZaQ3Ix?=
 =?utf-8?B?R05zVDkrY0IyNkhkVXFzVHBNbGxsbzJGOGpRbGJjdXl5UWxqOHhiUG1UdXJE?=
 =?utf-8?B?YUVYU2hzWDBONWF6NTRlVHhCMTN1cGVBakpaMFo3bHNURENRRERWN1Z3RXBx?=
 =?utf-8?B?UmZBS1pqY2lCeDFXaWpMZmhXWDZGbmhpcFFvdGJtMDUwMHViUFlUTVI0dVE3?=
 =?utf-8?B?b2svTC9haE1YV2gyNmtENG5jNndacW9ZK1BJeEZ5cjA0azhTU1RhTnFTc1JK?=
 =?utf-8?B?UFdBUjdMSXN5bHRmMWNFcGcvSjRlYXBaNzlvM2R5SXZ6eDdHeVhVdlVzTkpm?=
 =?utf-8?B?UENFTlNQWmthcUVqUlZFTW50UHNCVmFMa3BoeU5RbWFJOU4vZGoyTC8wU3lj?=
 =?utf-8?B?b1Z1L0dUN1lGdTM0RmdsTFBJdG1MaDVINXcyek5McmpkQVgvSHRYMGc2UDUz?=
 =?utf-8?B?RXA5S0J1U2FGVFJiMVRKSDFIcVpjNlN6bUZYbWVTL1A4N0dHeVNnRTFnbk52?=
 =?utf-8?Q?qSX5XIS55kpnOxCYaB2H5dt5u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5d7122-9c8f-4b5e-2948-08dc4ec62ee7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:27:07.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S7+284aMAb7GKj/HyuVaopX9ndoUqcHAJ6okOcu0aHB9AT8+XaXZQwPUI1sMXGPkf3IHRNXYCsPc8/t0yaTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763
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

From: Peng Fan <peng.fan@nxp.com>

Convert to OF_UPSTREAM for i.MX8MP EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile           |   1 -
 arch/arm/dts/imx8mp-evk.dts     | 684 ----------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig |   1 +
 configs/imx8mp_evk_defconfig    |   2 +-
 4 files changed, 2 insertions(+), 686 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d85a33055c9..55e9ab0725e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1105,7 +1105,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk2.dtb \
 	imx8mp-dhcom-pdk3.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
-	imx8mp-evk.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
 	imx8mp-phyboard-pollux-rdk.dtb \
diff --git a/arch/arm/dts/imx8mp-evk.dts b/arch/arm/dts/imx8mp-evk.dts
deleted file mode 100644
index 9f1469db554..00000000000
--- a/arch/arm/dts/imx8mp-evk.dts
+++ /dev/null
@@ -1,684 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mp.dtsi"
-
-/ {
-	model = "NXP i.MX8MPlus EVK board";
-	compatible = "fsl,imx8mp-evk", "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		status {
-			label = "yellow:status";
-			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0xc0000000>,
-		      <0x1 0x00000000 0 0xc0000000>;
-	};
-
-	pcie0_refclk: pcie0-refclk {
-		compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <100000000>;
-	};
-
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can1-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcie0_reg>;
-		regulator-name = "MPCIE_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&reg_arm>;
-};
-
-&A53_1 {
-	cpu-supply = <&reg_arm>;
-};
-
-&A53_2 {
-	cpu-supply = <&reg_arm>;
-};
-
-&A53_3 {
-	cpu-supply = <&reg_arm>;
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	snps,force_thresh_dma_mode;
-	snps,mtl-tx-config = <&mtl_tx_setup>;
-	snps,mtl-rx-config = <&mtl_rx_setup>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-			realtek,clkout-disable;
-		};
-	};
-
-	mtl_tx_setup: tx-queues-config {
-		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
-
-		queue0 {
-			snps,dcb-algorithm;
-			snps,priority = <0x1>;
-		};
-
-		queue1 {
-			snps,dcb-algorithm;
-			snps,priority = <0x2>;
-		};
-
-		queue2 {
-			snps,dcb-algorithm;
-			snps,priority = <0x4>;
-		};
-
-		queue3 {
-			snps,dcb-algorithm;
-			snps,priority = <0x8>;
-		};
-
-		queue4 {
-			snps,dcb-algorithm;
-			snps,priority = <0xf0>;
-		};
-	};
-
-	mtl_rx_setup: rx-queues-config {
-		snps,rx-queues-to-use = <5>;
-		snps,rx-sched-sp;
-
-		queue0 {
-			snps,dcb-algorithm;
-			snps,priority = <0x1>;
-			snps,map-to-dma-channel = <0>;
-		};
-
-		queue1 {
-			snps,dcb-algorithm;
-			snps,priority = <0x2>;
-			snps,map-to-dma-channel = <1>;
-		};
-
-		queue2 {
-			snps,dcb-algorithm;
-			snps,priority = <0x4>;
-			snps,map-to-dma-channel = <2>;
-		};
-
-		queue3 {
-			snps,dcb-algorithm;
-			snps,priority = <0x8>;
-			snps,map-to-dma-channel = <3>;
-		};
-
-		queue4 {
-			snps,dcb-algorithm;
-			snps,priority = <0xf0>;
-			snps,map-to-dma-channel = <4>;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-			realtek,clkout-disable;
-		};
-	};
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
-	status = "okay";
-};
-
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
-	status = "disabled";/* can2 pin conflict with pdm */
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9450c";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			reg_arm: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1025000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-			};
-
-			BUCK4 {
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			BUCK5 {
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1045000>;
-				regulator-max-microvolt = <1155000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO3 {
-				regulator-name = "LDO3";
-				regulator-min-microvolt = <1710000>;
-				regulator-max-microvolt = <1890000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	pca6416: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pca6416_int>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
-		gpio-line-names = "EXT_PWREN1",
-			"EXT_PWREN2",
-			"CAN1/I2C5_SEL",
-			"PDM/CAN2_SEL",
-			"FAN_EN",
-			"PWR_MEAS_IO1",
-			"PWR_MEAS_IO2",
-			"EXP_P0_7",
-			"EXP_P1_0",
-			"EXP_P1_1",
-			"EXP_P1_2",
-			"EXP_P1_3",
-			"EXP_P1_4",
-			"EXP_P1_5",
-			"EXP_P1_6",
-			"EXP_P1_7";
-	};
-};
-
-/* I2C on expansion connector J22. */
-&i2c5 {
-	clock-frequency = <100000>; /* Lower clock speed for external bus. */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c5>;
-	status = "disabled"; /* can1 pins conflict with i2c5 */
-
-	/* GPIO 2 of PCA6416 is used to switch between CAN1 and I2C5 functions:
-	 *     LOW:  CAN1 (default, pull-down)
-	 *     HIGH: I2C5
-	 * You need to set it to high to enable I2C5 (for example, add gpio-hog
-	 * in pca6416 node).
-	 */
-};
-
-&pcie_phy {
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	clocks = <&pcie0_refclk>;
-	clock-names = "ref";
-	status = "okay";
-};
-
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
-		 <&clk IMX8MP_CLK_PCIE_ROOT>,
-		 <&clk IMX8MP_CLK_HSIO_AXI>;
-	clock-names = "pcie", "pcie_aux", "pcie_bus";
-	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
-	assigned-clock-rates = <10000000>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
-	vpcie-supply = <&reg_pcie0>;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 {
-	/* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb1_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x16
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x16
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x16
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x16
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x16
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
-			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x10
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x16
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x16
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x16
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x16
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x16
-			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x10
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX          0x154
-			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX          0x154
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
-			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
-		>;
-	};
-
-	pinctrl_flexcan1_reg: flexcan1reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
-		>;
-	};
-
-	pinctrl_i2c5: i2c5grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA         0x400001c2
-			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
-			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
-		>;
-	};
-
-	pinctrl_pcie0_reg: pcie0reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
-		>;
-	};
-
-	pinctrl_pca6416_int: pca6416_int_grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usb1_vbus: usb1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index cb8afce241d..fbde476a7f1 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -222,6 +222,7 @@ config TARGET_IMX8MP_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MP_VENICE
 	bool "Support Gateworks Venice iMX8M Plus module"
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 2846faa8352..7e5dfce2ab6 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-evk"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.35.3

