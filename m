Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA989C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E38C87F4F;
	Thu, 28 Mar 2024 02:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VBGPprDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E1C880B9; Thu, 28 Mar 2024 02:27:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446A18808A
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ/LIFz6+O5KvHXiLudIOV9uTGyG5LCLLk2IOQ94r5do0HXcfc77M7/5eTx3ubwGyFJihzP/o2wEQNirAqn1qb+ADvAoINd3rg6Q2E+m9WGuObuId+VKR33VtLtDhI+zlwauAugOh3r+AzCfdJuH9cex5Y8QZ6jo9FPrCBO9ZXuDdKImoXIpEpZS6FjY5VM/kZr2/Z+FXb+MWdjvFvesM3U3W3VZ7Fw9Do8d10cI0c1ID3lf9uUz8xO+X0+rQR4LX9UfMuWVhlOsnb3nDOdrZRbaUYSE8PTo79gMlxddeNnZ/MIPzzDsNvkV6QL2tYlm/e/jSS5Bo7Oe+CfskPxtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sekdDlqXUTLhOSalpO5XKqKKECgkigKGkJpI1BLmMkw=;
 b=mWf7X1KNXt7ctgm83B5fpLcvN7JUyzLtEddL7F7GTdxDCdY10UdBrpMJLTjsUC0wRN5oPjvwswdiaxc2CDcQSnGEa0Gt8va5OxJVcr1lgawUI4BwrjYoHa2SHf7TAkuHZ0MdyYtZymc68r7oxZjUohP56dWApcgr72V3u1ti+iqjfHxL8EmejrUQxgCd2K84NFXWUMhOdlpNkRPNYp8Ng4tS6nJ7T/kW1mNCm4g7CVpQ1/aJAqFMYiajQPrxStkdX4At/JHhtQca0k6h9TwVT6ftZgLvt4ACfe0lwtvD0tBNqcSm3qH1eAYg1rI8Z+m2BDdAAMIr8fhycvc8iTrA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sekdDlqXUTLhOSalpO5XKqKKECgkigKGkJpI1BLmMkw=;
 b=VBGPprDN6RYAF2ft9I7nAvqbvdgebzEJD3s4s77bVVxz/8HS2Q3BlHHwL/4ucdNPlKnQcu2w5cowXIPTXE6Te5ycr2JyuVWDs7elQrqNO7TpwGJ5l08GMr2vzWlpsDycikKHfgltQblt3tsbhGZfttn2Cz8/TUN+L4dcs0iI/Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 01:27:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:27:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:26:34 +0800
Subject: [PATCH 1/4] imx: imx8mq_evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v1-1-2be5e6657a88@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 09c33613-a61d-410f-254c-08dc4ec62b03
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwVU4rtz3O/M6GV2YWnnuMrRhIn1Vdz4BTgfSSW/Wt518EOXmHW47TIRg9dgzf8nsG5FtMUoSWVNroUamIJojhiR1eMrKQbWXXBP/NbT0b12hYuAqoHKQ32xVpY0szDQ6e9/6YbsWO0WZe4HeDafqPxecmla+WUHO5QW3Q1cCY8e7gC+CAMu8pD/HeEqv3naD5xl8QWKGKDcNLXeOprYs/IrPx3D3lX3rAPkc24Xe1E438/+98fqEyZvzKV82t2K2w7RHEBGJrYl7+KfkiwUGXIp32heKnRIa6W1r/yMKvVYKdhILLzL4yrwv7yThT/O1YJkQFbT0NZdL22hEvhERJfh2Xv7rC1qn5uhMLJ9i75o3F6/XLHt6EHDtG7v0vJVFKKDfyJHxz72FV1vn1GwMoAfAizp7IFJKrXZ7JmPhOmZGsPFhkxrUiI0bLXWByyDBs6EKdDLdXe8tp5aHzUJ1v64wAC5/lGHmkjcz7iuRmcuYXQbC8rbBUjGsi6q/XtkWecdxTXrELz/Sr5w978TMq6o2P5IOj5NsJFPHaVijHW1pxNaZhdi8nmmY5p0A+27u7sTiQ2DI4sXOuAgCjSMbpRCCDWQ9Rq8PSPBzx7TKc2LG/oAiVM+LfsI0CVKgmdlJJt2XRzinHsFZQldqbrY2DVIYiSSMy2sPza/ruF1WVkJeQMPC/ZD/joIUF2+E/vs0bQ4SAlrzLah8RynMilA6aoKTF2lWskFToD00nv7Duc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVU5OFdmcVE0VzVxTU5oUEY2Zzk5N3ZKWUV4Q2NGZkNETGE5MEpscW1CQUkr?=
 =?utf-8?B?SHZXcGNYcXVPU291NjB4Wks3azIxVElPVmo1U1Vwcnp4QzVUMjdJNnJHTXFq?=
 =?utf-8?B?QmVhaG1KSVhSZ2lVRmVYQnM5eFE1Umd3NjI5aWo4R0FGN2ttYjJMZTlDSTdH?=
 =?utf-8?B?QWpWc01wRDhKZTFJbG1ZVG9HT2VnS2RnY3N6Q3FRVkNJdnB1ZmgreExhTzJV?=
 =?utf-8?B?ZFNzMkdwQzltN0NsOFdpNkxwV3ZlNWVNS29oNkMxbEVISFJYcUVDbjMyV0k4?=
 =?utf-8?B?WmJlbzBTakhsb0Z0YVFoY2hnYnBITEZTSmRNZ2w0ZGJZRmgzVUFlRDhDSEJJ?=
 =?utf-8?B?aS83cmFHbFFUck9LZmREaXFWL1pjc2QvSEVoWEpvVE16ZDhSdGozTnJSZDZ1?=
 =?utf-8?B?c3NhdmZKZXlQOUFwR3NrWWhUK0R6WXlzN3Q1YjVtVmNZaFQ0c0Evd1FMaXJF?=
 =?utf-8?B?ZmxialFwOGJoRjBobVVPWUlnV2RlTHV5TCsvSDRLQml5anF0ZUxjQURyNmF6?=
 =?utf-8?B?cktvL3MrSjE1dU0zTGlncVR4YXFuRDJNZFJNVGpWL2Zhd1doQ3M0SXpLQnpq?=
 =?utf-8?B?MGxWVG1zQzhNTCtuN0dDdEZpMGQ2WE5WcmFRMFk5SHBXWmRDam43ZDJROHRR?=
 =?utf-8?B?NVdQYTViN1RtSE1GdE0xencyUUcvaVBKaTNTbFNGcjYwZ1M3ZHZuMFZoanY3?=
 =?utf-8?B?NkpBWWc2dTExNjUwQk10NnRZb1RpUWNpS2JhZFNsZDlwUHZvcXMweGwwT0Vl?=
 =?utf-8?B?ZlhlK0gvNG05aWh2VHl5cG5xbHNSeVpFQ1d5NUhRSGFoL3ZIM2VDVE5vUkJz?=
 =?utf-8?B?TDJNZGQ5d2dSTDRpWFcyNE9jSVp4Q1puS1hrdlBuOGMvNHNueHhCL0VqSWpy?=
 =?utf-8?B?T1U4YjZabUJ0QUhZTHNCYUZjZXFGSDVDSDFXL0pwdVBWUXhhcytBeCtPYVFo?=
 =?utf-8?B?aUwzb3dsVFhWYU1ZNmxGcTB2MElYQlZqRWNvUXF6NVlFMERvdHpFVkQ2OWlB?=
 =?utf-8?B?UTlnMEkwcGlwMGhXeTRLVXI0TFVmR25UdzR6TWZmRnk5c1FWQ1FIeE1tbWd5?=
 =?utf-8?B?WXJNc2RjSnAxTFZqNElkN2VpUlVOc09xZEhEUjJ5UzFuNHN3NFhBdFZCd3Jv?=
 =?utf-8?B?Q1NIOE9PWi80WE1FUUNndUxFWWxNYjhpODJmMGxKL1I2UW85c0xoK3laSEJO?=
 =?utf-8?B?VGd3S0w1S21GUTF0b2s0ZkZwUFBTSldtemtPRGI2NFFmWDlqVTUyYTBaRTl1?=
 =?utf-8?B?MHZ1ZXZiemJHbGp5MkFEd0tjVDA3NDAyNnY0Rlk1eDVqNlRCWHBVSlFmQnBz?=
 =?utf-8?B?c3U3YVlyQ2s1cFF2UkZjVXNNaWtUNUdXdnNReFRLVG8xZXc5aHFvL01yOEdC?=
 =?utf-8?B?em5jNmk4R3Iwemx3L1BOZmpxVWZMcXRraTN1MWVvbWZjWWpKaHZYdWpralFD?=
 =?utf-8?B?eTFZOXJNVzdrSzlyWm5ieGNreXNwc0xSWi9uczFaMlI4azdqTm5XTW9rTVZN?=
 =?utf-8?B?eTZ4bWRKUUVienUxdlBZVUFYSjhjczhWQy9UTm0wWS8rRXpzMjlOSzdub3pi?=
 =?utf-8?B?dU9KODYwR1hsQjlSUld5cjcxN2piVjgrbXVWR25JdFZkUThGQ2VVWlV3Z01N?=
 =?utf-8?B?OGVFWVE3Y3RWQ1VQcWZudDFQQ3hUbTFVZi9OcUU0WnNHWEZmdE1uNHlzNGNo?=
 =?utf-8?B?aERTTU5TNmtRcEN1UUs2Zy8wd2RWa0ZlcHQyaHA3WnV5M0d1eXRKVWRBMUZp?=
 =?utf-8?B?M1NrNHA0dHdxbTRFU2g4RzRlMGs3VHdnRmNqVDNqaHZHNUNmU3BSTy9jWHFs?=
 =?utf-8?B?dlpVSk1JTXJjSUtMMCtreW9ROGpML0ZPcC84M1VwZXZidlAyb3JuYUtHRmNX?=
 =?utf-8?B?Y25PSjhvOFR1R0U4ZUtLQkgyS3RDcHdoUHBKMDZmU045WWhWMjBOL3dLTzBv?=
 =?utf-8?B?eWVySHRNZXZ6aVRzT3dIbXhqQ1ltWUxtVTdkTXVDYWRsalFJNHdTcjYvSWM2?=
 =?utf-8?B?OXNhb1JVNzU0cGVWaStWVHFTVmlydG0xdzhHSTFsYmxEUlFxdk1JWU1IanpW?=
 =?utf-8?B?Zlg5N1AwaFgxSTFGVmpkU2tuVWRMTWI5VzFvRTJmZENmYVV0bGhrUXhtSU9a?=
 =?utf-8?Q?dRkuUPBJOB+QPvYw3/nZHC+5j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c33613-a61d-410f-254c-08dc4ec62b03
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:27:01.2853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S+ZESL9P8mFJWOmQ8f+Tb4+iux1b69AybI2iMDVWy+6O9WV5oQs7w2rFaK4iecIu4H06lWJl5xRDQQ1hRi0Wg==
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

Convert i.MX8MQ EVK to OF_UPSTREAM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mq-evk.dts     | 712 ----------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig |   1 +
 configs/imx8mq_evk_defconfig    |   2 +-
 3 files changed, 2 insertions(+), 713 deletions(-)

diff --git a/arch/arm/dts/imx8mq-evk.dts b/arch/arm/dts/imx8mq-evk.dts
deleted file mode 100644
index 82387b9cb80..00000000000
--- a/arch/arm/dts/imx8mq-evk.dts
+++ /dev/null
@@ -1,712 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2017 NXP
- * Copyright (C) 2017-2018 Pengutronix, Lucas Stach <kernel@pengutronix.de>
- */
-
-/dts-v1/;
-
-#include "imx8mq.dtsi"
-
-/ {
-	model = "NXP i.MX8MQ EVK";
-	compatible = "fsl,imx8mq-evk", "fsl,imx8mq";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x00000000 0x40000000 0 0xc0000000>;
-	};
-
-	pcie0_refclk: pcie0-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	reg_pcie1: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcie1_reg>;
-		regulator-name = "MPCIE_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-vsd-3v3 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2>;
-		compatible = "regulator-fixed";
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	buck2_reg: regulator-buck2 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_buck2>;
-		compatible = "regulator-gpio";
-		regulator-name = "vdd_arm";
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <1000000>;
-		gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-		states = <1000000 0x0
-			  900000 0x1>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ir>;
-		linux,autosuspend-period = <125>;
-	};
-
-	audio_codec_bt_sco: audio-codec-bt-sco {
-		compatible = "linux,bt-sco";
-		#sound-dai-cells = <1>;
-	};
-
-	wm8524: audio-codec {
-		#sound-dai-cells = <0>;
-		compatible = "wlf,wm8524";
-		wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
-	};
-
-	sound-bt-sco {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "bt-sco-audio";
-		simple-audio-card,format = "dsp_a";
-		simple-audio-card,bitclock-inversion;
-		simple-audio-card,frame-master = <&btcpu>;
-		simple-audio-card,bitclock-master = <&btcpu>;
-
-		btcpu: simple-audio-card,cpu {
-			sound-dai = <&sai3>;
-			dai-tdm-slot-num = <2>;
-			dai-tdm-slot-width = <16>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&audio_codec_bt_sco 1>;
-		};
-	};
-
-	sound-wm8524 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "wm8524-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&cpudai>;
-		simple-audio-card,bitclock-master = <&cpudai>;
-		simple-audio-card,widgets =
-			"Line", "Left Line Out Jack",
-			"Line", "Right Line Out Jack";
-		simple-audio-card,routing =
-			"Left Line Out Jack", "LINEVOUTL",
-			"Right Line Out Jack", "LINEVOUTR";
-
-		cpudai: simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-		};
-
-		link_codec: simple-audio-card,codec {
-			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
-		};
-	};
-
-	sound-spdif {
-		compatible = "fsl,imx-audio-spdif";
-		model = "imx-spdif";
-		spdif-controller = <&spdif1>;
-		spdif-out;
-		spdif-in;
-	};
-
-	sound-hdmi-arc {
-		compatible = "fsl,imx-audio-spdif";
-		model = "imx-hdmi-arc";
-		spdif-controller = <&spdif2>;
-		spdif-in;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-	status = "okay";
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		/*
-		 * On imx8mq B0 PLL can't be bypassed so low bus is 166M
-		 */
-		opp-166M {
-			opp-hz = /bits/ 64 <166935483>;
-		};
-
-		opp-800M {
-			opp-hz = /bits/ 64 <800000000>;
-		};
-	};
-};
-
-&dphy {
-	status = "okay";
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			qca,disable-smarteee;
-			vddio-supply = <&vddh>;
-
-			vddh: vddh-regulator {
-			};
-		};
-	};
-};
-
-&gpio5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wifi_reset>;
-
-	wl-reg-on-hog {
-		gpio-hog;
-		gpios = <29 GPIO_ACTIVE_HIGH>;
-		output-high;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@8 {
-		compatible = "fsl,pfuze100";
-		reg = <0x8>;
-
-		regulators {
-			sw1a_reg: sw1ab {
-				regulator-min-microvolt = <825000>;
-				regulator-max-microvolt = <1100000>;
-			};
-
-			sw1c_reg: sw1c {
-				regulator-min-microvolt = <825000>;
-				regulator-max-microvolt = <1100000>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3ab {
-				regulator-min-microvolt = <825000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			sw4_reg: sw4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-always-on;
-			};
-
-			vgen1_reg: vgen1 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen2_reg: vgen2 {
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <975000>;
-				regulator-always-on;
-			};
-
-			vgen3_reg: vgen3 {
-				regulator-min-microvolt = <1675000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: vgen4 {
-				regulator-min-microvolt = <1625000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vgen5 {
-				regulator-min-microvolt = <3075000>;
-				regulator-max-microvolt = <3625000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vgen6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-};
-
-&lcdif {
-	status = "okay";
-};
-
-&mipi_dsi {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	panel@0 {
-		pinctrl-0 = <&pinctrl_mipi_dsi>;
-		pinctrl-names = "default";
-		compatible = "raydium,rm67191";
-		reg = <0>;
-		reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
-		dsi-lanes = <4>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&mipi_dsi_out>;
-			};
-		};
-	};
-
-	ports {
-		port@1 {
-			reg = <1>;
-			mipi_dsi_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-	};
-};
-
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
-		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
-		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
-		 <&pcie0_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
-	vph-supply = <&vgen5_reg>;
-	status = "okay";
-};
-
-&pcie1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie1>;
-	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
-		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-		 <&pcie0_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
-	vpcie-supply = <&reg_pcie1>;
-	vph-supply = <&vgen5_reg>;
-	status = "okay";
-};
-
-&pgc_gpu {
-	power-supply = <&sw1a_reg>;
-};
-
-&pgc_vpu {
-	power-supply = <&sw1c_reg>;
-};
-
-&qspi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi>;
-	status = "okay";
-
-	n25q256a: flash@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&sai2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <0>, <24576000>;
-	status = "okay";
-};
-
-&sai3 {
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MQ_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&spdif1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spdif1>;
-	assigned-clocks = <&clk IMX8MQ_CLK_SPDIF1>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&spdif2 {
-	assigned-clocks = <&clk IMX8MQ_CLK_SPDIF2>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc1 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vqmmc-supply = <&sw4_reg>;
-	bus-width = <8>;
-	non-removable;
-	no-sd;
-	no-sdio;
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
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
-	pinctrl_buck2: vddarmgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
-			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_ir: irgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x4f
-		>;
-	};
-
-	pinctrl_mipi_dsi: mipidsigrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ECSPI1_SCLK_GPIO5_IO6		0x16
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
-			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
-		>;
-	};
-
-	pinctrl_pcie1: pcie1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C4_SDA_PCIE2_CLKREQ_B		0x76
-			MX8MQ_IOMUXC_ECSPI2_MISO_GPIO5_IO12		0x16
-		>;
-	};
-
-	pinctrl_pcie1_reg: pcie1reggrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ECSPI2_SCLK_GPIO5_IO10		0x16
-		>;
-	};
-
-	pinctrl_qspi: qspigrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x82
-			MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82
-			MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x82
-			MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82
-			MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82
-			MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82
-		>;
-	};
-
-	pinctrl_reg_usdhc2: regusdhc2gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
-		>;
-	};
-
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
-			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
-			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0xd6
-			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
-			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-			MX8MQ_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
-			MX8MQ_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
-			MX8MQ_IOMUXC_SAI3_RXD_SAI3_RX_DATA0     0xd6
-		>;
-	};
-
-	pinctrl_spdif1: spdif1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
-			MX8MQ_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
-			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
-			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_wdog: wdog1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
-		>;
-	};
-
-	pinctrl_wifi_reset: wifiresetgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 5db643c1958..6f68ee2c27d 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -53,6 +53,7 @@ config TARGET_IMX8MQ_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MQ_PHANBELL
 	bool "imx8mq_phanbell"
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 941b845006a..3a2d88aec45 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mq-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-evk"
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_TARGET_IMX8MQ_EVK=y
 CONFIG_DM_RESET=y

-- 
2.35.3

