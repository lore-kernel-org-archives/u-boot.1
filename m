Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21762C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6340B880BE;
	Thu, 28 Mar 2024 02:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EDneCbl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80471880D6; Thu, 28 Mar 2024 02:46:49 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2C5880B9
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keZnTHvIFJpCkwXh8i7+QlLqHqxeM/qxopg45cZ5B1c++5MO8UB2FKckquYWs2RRWW8aoVR6BIUEWVHtsPFVMG3/XYwXdQTqd45GIhSpIAgD1HSOPho55l7YYmNA45Ry79/aw3Sj6YR3sDZHQ6VYP4NIU446yoDjsde1CtKEDQTtB7RspeOedaOEwxxoiUd8fnpEH5hwz6sIuFNeubxpTDeXL7Upzy288Hzc95l1I5DtPSCJOyrSrNvb66Fu5R8Jxe8Jf78Xf2X7cZzvvzzFayfJ9kcygwksfRhjUtIuUUgCH9cpHXPSa3XldOdsZ+OpN9b/SFxymsRj72zZn+YG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIssJtkZAUIjc4Sn37btWtObYvwWE6S5Hrqx4/FO7TI=;
 b=aFKsNQsId98itCBzasYUZBMlGX/dE7m1tKshCjTU9TbIKt7cWglqW3CUt+SjXXmqap3+oFU4yuSRlApmoWiVIgElmSYg14PqSeVjXK69XkUjpaHfkZqU4rkSgfCEa2kty8jXh+Q4nP/9WUxqzvw62sBUeiBKs90NU2sNx78kV49DsVWKEpc69a8Uq01VUfRaixabwvVwIdL57fyDstQUt1z2TbRWqP5Mnhs6Ti0TmAJvhcZo9zZnqz6uqCnLRkLs/+5t3lO3f0AhqoFz7aLnKjCr2burdr1zkEdtCIyvG10s9GC32F0f6+WBBxj3xA0TCZimC4x4Mz959lnLT/QzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIssJtkZAUIjc4Sn37btWtObYvwWE6S5Hrqx4/FO7TI=;
 b=EDneCbl8D9RsK9NBgJzc7y3al1DHBu1nKuB/fLeprtniGuJKvtiIh3fvrvB0eKhHac6JfMhQRT3V/S3phfxtCUzkMF2gdlDDHkyp1ndJPOk73jHubxxDV6wuTcXgQMyx2z9pumPOYcHsacw9Y37UIcpygBe/ndLLgfd3p8jPAbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:46:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:46:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:45:08 +0800
Subject: [PATCH v2 1/4] imx: imx8mq_evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v2-1-7656998cc8b0@nxp.com>
References: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
In-Reply-To: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: d9df7ae9-3b73-4f60-ed4b-08dc4ec8ecd7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uc7uDOsNQAHP22JFFWmLzbpXSYG+ART/5KUcq00R7Rcr6RRLsTjMe00aCR+mA1k4YM6nX3tcdZ/pqb2VEGGiWRJoX9qiTa9wBhvCslLKzZGsT+db3FZ9kNcyMIEmjv25rMfE5I+q3BblDfjVbvxWCry/Vj2bfPJEsCfPC3ipNmxUW5QrQiK/8fjMvXM3XGxr+SND0WX9QasZhI2LNYUpoWOvQvfGO8fjIkeXhyaBNpx7GY87e66tmi9BXec7Z7ypmRYFYe7lUJdXBiR+3guAf07ec7S1c7oGIkzdxUw2+qDiu15myQlcHpoFLbS8QjCkvm9mTTAPT/LiZcAe/Z2Ib1NK9ZAzjeq81pJkgXHMm2/Jhk4eHgJC1yd0MeBe/fUAkCUP/GxNrJc90HwsEHrf9nR/uWo5/P1+lYh3Y8a0ClO9RFm1a0zBnwnWsRarEn3ZYXmanZwvu1mCB0nrfHyOSG99XyjPNfdXYbLCSqq+BM7D89G2b/Q1ft+cVPRsbcibENqeLsUCZN4BYIFc3JUhOBjI3w0mTluEjHaQEjH8ZvYEtROFTNh7e9+55YMKSqb+3FvJCt2ydjFdsL9San8SUHQk63P6YjmmCo6J5DvKTyHfzW73oF7iQPLCQ/4d2HuDmqbQZr2ch1a6Zmht0z4d4YdoKz633Qt9qZ/a5dWILetYykomGBZCZ4yXdSJGUjaGcRHGwpIYMnIXT/vzjJu+EWN5DHIgLHk6EYcG28a7URI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGJyUlY3aStFZjdTTmYxcFpORC9zZFRJODREdS9TMlBHNGZPbFFkUW9HdHNq?=
 =?utf-8?B?SlVWSmpxRTlvQSt4SWNkVXNxWEthd1d2RkNJb2dtejJoSXUrY2dKVFlnNlRP?=
 =?utf-8?B?cEl3NlhGTldjZ0hKUlhmK3B0dDdXVHVaR3ZmczNvRWlkd1hpL1JvZTl0TDhH?=
 =?utf-8?B?S1l4STdtZU1hK2I1QWFvTXRMZXdkLy83SW1jckdmMjBMcWJ0dVE3dlJwaHEr?=
 =?utf-8?B?UGxsbjdPd1F1anpWalluMldCdzdoSnZkVW43MHdGRjhPbE94NFZYSmVVbWxw?=
 =?utf-8?B?Mno1b29KUjVjTVRCV1ArRGtNNnZFS0d1TEFXTWlyeFlTYU4wTVhvYmhMSENY?=
 =?utf-8?B?K1lhdkxJakd2TW1MWnlNQjJzNk1xdFFYNEMxeUtnY0ZudDdjT0IwT1Zwb2Zl?=
 =?utf-8?B?SldOL2draEQxM1lLd3VkUmNsanhldHFFT2hqWU9YODE5ajFzSSszbm5RYm9I?=
 =?utf-8?B?M1hMREF0STZ6M01BZm9rclo2UlFVOGFwNTRNZlUyb29BVERTUjJLakJLU3Qr?=
 =?utf-8?B?NVZLT1FXOFUxa1ZvODl4Ni90dlFoWnJrU1RqNjQxTmlTQXc5d21XemNUdHBO?=
 =?utf-8?B?blMyNmhJU1k1ZlFZbTF4NDZzZlFwZXNpVW4rekVXYVVjRlBqakUyb0tIVVNC?=
 =?utf-8?B?SGJvN3hkSDc1VGNRbjREWkc4VGFNWSswNU5tRVZnTkttNzlvN3Z2c29CWDd1?=
 =?utf-8?B?eTRYMkxEQUFXdjA5azlRUDBpeGFYZVpKdVdrcHo3b29jODExL2EzSDk4RHUv?=
 =?utf-8?B?aVlhZ1hHYlJQTTlTZzJtem8wWjgxZkEyQVFaQ1poL1pwVklQS296bGNmZlVF?=
 =?utf-8?B?TjVManhCN01qbmZ0QTFVNnJmL1lGTWlHbkRwdWJoVU5rdzRJdUVDY2IzcERX?=
 =?utf-8?B?K2gzSzJ6VnlPYTAzNVJRSzRRdVcxaDBRd0ljQTJYbndtM09ZbXJJWkdOSENC?=
 =?utf-8?B?WjJFcGFKOE1TSTRrWFdrcTlNVkpkdm01Nnl2R1RBZWV1T2RkbkdOTkNLYzRz?=
 =?utf-8?B?NEt1RTk0L01YUTFtRmVDK2JPQkhDNXVnbWNnNjljYW1iZjg3WGlwU252RnI2?=
 =?utf-8?B?NWd5WmI5R1JsYXd3akkvRmZITWVrcVhoZTJHK3VSNlMzSVJMOUJxU1p4cm1U?=
 =?utf-8?B?VDVwME5NQlpMcEpqd0tiN1hIMFVVSEk3bzRhSFBsdWZFZVd0QXdJR0kwaEoz?=
 =?utf-8?B?blFvaEFCa0o0aG1WRThQSHJSdnBIQzZ2OG1kWWpHREtRYjIrNStPeGloRk1s?=
 =?utf-8?B?MVZKakRqQ3lBZlZNeU91MlBha1l1bjFhZDFiWFExUVIxb2pWeVpQbWNKYUM3?=
 =?utf-8?B?SUtONnJ4QU5uYWR2SWgybEdKekRSd3ZWZ2JQZHM3WVZBRG9ZT21vT3R5SG5l?=
 =?utf-8?B?WVM4WEZ4TlZ2N0QrVTNKWmRyam81bStyS3lLNExsNVJsL2M5OTRacXZzRlpH?=
 =?utf-8?B?MjB3ZFA0VXhvWDdEb3JmeFh6Z0FZMTIrK0dWd0szUXFldkltbXVEbUtMZWl3?=
 =?utf-8?B?bTA1aXNJL3lITWV1a1M0THIvRmxlOEtaSTk4Q01aejNRSWZoaGQzRFFiQUlr?=
 =?utf-8?B?Wkt1TFJ1MGpUdFlVM3FHdkl4eG4vS1FKcWZ5RVhhR3pIUUV6WWYranhDRS8r?=
 =?utf-8?B?SGdsTHM5T0wrMmNCQ2ZpeWFEOHVycHFDb3FBUUl6M3Y3VkxyOGJwZzF2bXdX?=
 =?utf-8?B?WlFNNjhNK3B3bmd4UFM3MUNNNFVkRHVRUEV1bHFMeVprZXlLc0xkQVlxRHd5?=
 =?utf-8?B?eXRFQWJHZVZCU3dYbThWS1lGSDczUzNlQUIvSjM0MHdQTGJDRDJtOFlqYUxZ?=
 =?utf-8?B?NWF4Y3dpOFoydWVpTnU2em1wL1BFS2E1UHNqV3pmVlBGTzgvL0wwRndwdEdy?=
 =?utf-8?B?NXBkUDFDOGQ5NW9Rc2VzYTVmMXFNRHptYW13NHNVREtIMXdibmR1ZHZ3NDN4?=
 =?utf-8?B?citDM3dmcWNJQ2l3Y2h3WC8xMjlaaDhkaTYyNDRFY21BQU5GTmgxcEJaZlA0?=
 =?utf-8?B?WXA2VWUrMXhOWVNFMXlYeFRTL0JQQlFvZGFydFg2VXJTdjdtVUxoUU9FOTNa?=
 =?utf-8?B?eUhBZGhINzJhVXJWcExJSWFCS3BnaHlidm13OWVNeTVMRVViTTlkN2JqU09z?=
 =?utf-8?Q?HByvPbx6Jtopn6FiBVfi6S1Ml?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9df7ae9-3b73-4f60-ed4b-08dc4ec8ecd7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:46:45.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju2NjQcG+Y5iRll664ik22snPzHntafBJbJ++9IUHv5Rl7iegAI5WIe8Hdj7KMspE8Kmrg43F1Nv+htR7DX8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
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
 arch/arm/dts/Makefile           |   1 -
 arch/arm/dts/imx8mq-evk.dts     | 712 ----------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig |   1 +
 configs/imx8mq_evk_defconfig    |   2 +-
 4 files changed, 2 insertions(+), 714 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d85a33055c9..b76ee4d609b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1090,7 +1090,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-cm.dtb \
 	imx8mn-evk.dtb \
 	imx8mn-var-som-symphony.dtb \
-	imx8mq-evk.dtb \
 	imx8mm-beacon-kit.dtb \
 	imx8mn-beacon-kit.dtb \
 	imx8mq-mnt-reform2.dtb \
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

