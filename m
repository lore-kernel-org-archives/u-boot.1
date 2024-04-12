Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777DBC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE44881D7;
	Fri, 12 Apr 2024 15:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="esnoADRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329AC8803E; Fri, 12 Apr 2024 15:25:09 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7EC881D6
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eePxTjG+jK4RxbZlVdZ5+F2y4+02NAQLE723yPCWUrDgUBoTcO3jbUxvvSrClB/j78W2h/QHmBjW9i5J3e0sCJ4uSNhIjOzOt+ndvIGyCuhWT4KcoAvDH91hSvEseO6Fw0u8Mk+ipr2xs81qJZHFkqx/RkaDgTjL0KL0vf84sopSQ/OaDGwhhud9oNsJS7FxS8QLXSCzUmN2RnF0H22kgZJvuL47CLrgB+6ZpFV9BycyWbJ7wkmJ2KAJVDNAnYX9kdjviY2Dbhi5kxy/lFAQooMM1cE1gKLOCLdlxDCsyGLNGE4LxAivOqQofayC+ERMvNlF7M1mnoARxSrNse/xWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3PkRzOpZBfgeUVtkDVaCF2wn86oP3ERRxDe/hFbySQ=;
 b=bKL6DBNOhztuyPgqMZ1uNqJM/Uq8xz2k1X/hJ6E3/tQoDZSzBEIpufH9ZnJbBWr3WcPGH+MloM6+LEfbKjK7J5MYx69UNVYd4xEU9o0GtLl3lJHa6xpMRKuiMYysAcXI9PSbDh8xqeK00QX8HFiTW5dtzgzEsb6Q4yItvy1mOogGtun3uM1CF2zeAjC5RpS6jGhtlrhWkG8YLLVPAip3JLDqKsBcdN2LFq7u7Ob4nRGUGE1pHp9l7D3ZikaE3XCKT91VQLwpGlm284rK6JXbOQpUa8ZKxqdLpLXx+ZEsh+eAcgzeVxPfby9FxXaidQyrsXM1qMpcRVBPVnITQQXJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3PkRzOpZBfgeUVtkDVaCF2wn86oP3ERRxDe/hFbySQ=;
 b=esnoADRctT1ruRcSO5zdNHP386VqZjRa54OJg8Z2XAqX3A0JS8amaUQoulAo+GTfg55CeHPOnJoCS0pHSflVxJ6kn52Ulq+skeNjipsUrw8Xh2TLoskm16yvFDbnRcuoK+PVD/BrFHMxFK0t5g8PKd+v5j394bkWAJx0eoOa6+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:25:00 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:25:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 22:24:55 +0800
Subject: [PATCH v6 5/5] imx93: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx93-of-v2-v6-5-c2ad48e46eca@nxp.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
In-Reply-To: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 84008c94-c2ad-47a5-452e-08dc5af3f42a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1z5Za/Vul8G7L1auQJYaM91U9au0SRn+LehdvqDpwaw+nN71L/Gylq5rdRaO63YuYbYzC9rTLeq+7MumHRdtyCLwLZINOt1zM8lyGsMpdtqQ0Yja6bTdI7MjE5VCrP0SCehXSR1EoKAc5bc9OoHy7Xi+f+mLB9MSHUFucQi0sBOAiyelkce8uS0c907Sr1Jg3qrUoXggjYuM5lKsvxSfgvOAAburIZoSJFhyl1/YRRvRrmhu1SvxVc7RtLa3MKMnYzns6Bw6IpU2d1c6/cYnXzj5aF+pZNist/7syyPJG9qapWyheXsK7oaFQPikJhsyUQJxrQO3tnvw9Z47jyTgpSz6of2yL8VjH7Z+2XhX07IEkyuFi0KDJJ798YQmbk/HUQoKMEUa01+VylZR9JNaRje93VTGUjnKu+Qp8pDRhSfmAyzzDAL+SCLi01bt8DWsPbojPEW9rmNHkUnadDQlmjLACuqdL+pxIseFspUoMN9DxRVYn7GdOL82oxqym2WAIABASdsBVpELRpF+YlvCFdJ3jZM/S+eL653LM5JwGrxtx5SLVxvAqt4KLjmk21fgfGCMxUFgGyJMrziMk02EoclEFRYl+hNhHxVvoIAtQ2rdY2Xy4u218t3pjZwFn47VKgc1vl2PhPR0dXco6AHqfgFp2c9PGPORpni9Q/nGco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9pMFpKKzFXVThvRi8ra1RaaHpRM09LOVZQanRaNnRobnB1c0lub2xGbE5B?=
 =?utf-8?B?RnhsaDVtbXdxQU1uQjZwY09NOWpnNm5Fek5FMzBpRlBzZE85Q1B2UGlJRUhj?=
 =?utf-8?B?L0pTODYrbW5lQlFKTlBvS1p2TnhGaVVhWjVjMVYxZE1wdVlRL1ZiS2RVaFRP?=
 =?utf-8?B?VVFLK29uM2RqKzNOOW1RSjFlMlY4K3FSTWJ2ZnFEMFBWK052djl5SGs2UWgz?=
 =?utf-8?B?NlR0MmRqekVGK3grWmxiUHBPSnJGUmhuaVB1Z1RjSmpBWlV4QzJlUStGMXBv?=
 =?utf-8?B?ZlZNd3J2SGZYZVBBaEU2N0hUbWhSV2tpb0ZpU25wRXJCN0MxUklSNktXa1hJ?=
 =?utf-8?B?ZnROejVDK2Jsa2wvTWZUcDBLemNqZDJsNldKWkZSa0JMR1BGRk9tNGs2Wm5u?=
 =?utf-8?B?T2twV0FLdjdnMUJiRExNLzVEK0JYVklsUVRXLzFKZW1Ld2FSN1M3Rk1xNUpw?=
 =?utf-8?B?Mm4xemIrY1dRZEtMZGZoeGZIOFhGWUFYWHF3ZmdvRnRhT0RENWY4T0xRNnk0?=
 =?utf-8?B?SzQyUmN0NnBvd0U4N1FBSVdYVjhjcFB3c3k5MWIzdTFjbWlIbFh2U3lJM3E5?=
 =?utf-8?B?bEprT2ZCOG1uaXAzdmNtSmp3a1dJVzJiOTlLdzdJUzJuUk13OVFvY2l5YVM0?=
 =?utf-8?B?aVpIY25FL2trMVMyWi8vM1h3dXJpNHp0WjczU3hHWVZsckc3bWlXRDNaUTlk?=
 =?utf-8?B?M2ZXM2wvYVNUL3MxYnNTTjcvUUtoSjQzRmpDMm1ZQ1pJYTlTSFI1RlBtT0tY?=
 =?utf-8?B?MUN1dHJjYVZRS1hFUkxqSHlDQVI1K2JxY1lLN0FocERpRHBsYllxTTBQcG1Q?=
 =?utf-8?B?MzIrYXhkd29NeCtQaEtWeHBoUklYR3hlRytRalo0NDZlU0lYQlEyR1JQbFpW?=
 =?utf-8?B?R01NZDNSeDhjUUdUb3FFbHZwdjZ3WkY1clhMSUVmUFJiNXdGbWpSdmg4RlBu?=
 =?utf-8?B?WUt0S2QyQzZPL3lNUlMzdXZNek55RUxNRStKaCtqSkFWbVVuVjhyMTZyUXVl?=
 =?utf-8?B?dEZzZXlYZnJja3QvYkNmWXdZK1VIU2gvTGU5dUFnTVM3WjBXQ2ZTTWp6bHk4?=
 =?utf-8?B?ckI5MmxTWVNlTTE4MHFqbXE5RWFaeW5DbmNQMXFrRjlLeDI0dk85alFhZmVS?=
 =?utf-8?B?cXpUTGJ6U1FDTWFQZTJJS0FRdWxOcENNNEJPa0lUNitvanRzV1NzL1NRUkRO?=
 =?utf-8?B?R1lQd0FZaU1WeVZUeC9VNnlLZUgxblorK3htdTBnZHA4eFdKMjk0VFRabU5I?=
 =?utf-8?B?ZU81Ti85WWgrMWpUOFQzdXhpeG1pYko4eXBLRmJ5eHdPOGk2cWJtaWdnMDNs?=
 =?utf-8?B?M2JmY3FWNjlkZFN4elhYMGhGUkczZHNVV3FkUzlZRklHaGxtblJUL3IxOGpD?=
 =?utf-8?B?WStIN1B1WjNIUjdWeUFzV2l0bTJWR2hMRFFJYVpnaGpvbGpnTG4yK3B0RG03?=
 =?utf-8?B?OE0zSkhXc0J0NTJFUUFsZmtEald0ZDQwWUtycTRKQzdyeWRmYUpUTzZPaFVO?=
 =?utf-8?B?cDc2SDN2NWF5eGZML1M4Rk12eW1wdlRqRHlFK3g1ZUJxbHhZdFRwRUlXdlhs?=
 =?utf-8?B?TytOUUFBWW90V2hNaUZJZCtpQm5xQkwxRUNTZ2hPWkJERStUMDIzTElvSHRo?=
 =?utf-8?B?Y2hHd3U3cHFydHJQSEpLaEtTbWMxdkIvZ3lhRXBYMmtwOGw0QVFaKzl5eHlF?=
 =?utf-8?B?L0tWVTJydVdNN25ja2wwZC9OdG9CZ3lML0dHeWhHaVFwQ211TkR3b3B3T1lO?=
 =?utf-8?B?T3ZjdkxXc2hVSlFXdFdKaEIrL0o2djU2QTBOSEFJNXdaM0dYOTd5dk5KcUVi?=
 =?utf-8?B?NnpuZys2Z2RoL1FiMU1uRnUxcjhsN0VpZjVCdFVEakRaM0VYbjJodjNrUXlT?=
 =?utf-8?B?VDl5RTZnUXF0L2JZbDlsMjdUbkVyRVIyMVJPbXd2MTZtTHowLzdoeGNmb21X?=
 =?utf-8?B?L3JTbkJ2dlZHVlZLVmpVUC9VZ05kZWx0Z3gxZ0U4dEExa0RsS3JPVER3SlFx?=
 =?utf-8?B?Nmx5d29TeTYyelp4c3VidEw4d0hPcWRxYUhmOWJUVGhaMGFpaFpNNi9QcmF3?=
 =?utf-8?B?R0xvVE9BT29kZWxqa1I3eWZ6dmY2aDQyTlJUV2pTOUwvY2x5YWxjQlM4TWpH?=
 =?utf-8?Q?OklDNsTtgAw/8Zjm4OG52YEks?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84008c94-c2ad-47a5-452e-08dc5af3f42a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:25:00.3863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egUNnl8hzhj1IFTnvTWhT4SP1aiEmEX9i18ELEVPh6gOOB7i/YbWchgas3m7pp3VR3VIv2VdV2A8dkofv/oSLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966
X-Mailman-Approved-At: Fri, 12 Apr 2024 15:29:37 +0200
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

Convert all i.MX93 boards to OF_UPSTREAM.

Add lpi2c2 nodes for imx93-11x11-evk-u-boot.dtsi.
Add usbotg1 nodes in imx93-u-boot.dtsi and board u-boot.dtsi.
The nodes could be removed after upstream linux supports them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                           |   5 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi        | 119 ++++
 arch/arm/dts/imx93-11x11-evk.dts                | 322 ---------
 arch/arm/dts/imx93-phyboard-segin.dts           | 117 ---
 arch/arm/dts/imx93-phycore-som.dtsi             | 126 ----
 arch/arm/dts/imx93-pinfunc.h                    | 623 ----------------
 arch/arm/dts/imx93-u-boot.dtsi                  |  80 +++
 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi |  22 +
 arch/arm/dts/imx93-var-som-symphony.dts         | 323 ---------
 arch/arm/dts/imx93-var-som.dtsi                 | 111 ---
 arch/arm/dts/imx93.dtsi                         | 906 ------------------------
 arch/arm/mach-imx/imx9/Kconfig                  |   1 +
 configs/imx93-phyboard-segin_defconfig          |   2 +-
 configs/imx93_11x11_evk_defconfig               |   2 +-
 configs/imx93_11x11_evk_ld_defconfig            |   2 +-
 configs/imx93_var_som_defconfig                 |   2 +-
 include/dt-bindings/clock/imx93-clock.h         | 208 ------
 include/dt-bindings/power/fsl,imx93-power.h     |  15 -
 18 files changed, 226 insertions(+), 2760 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2634bb4c9ac..0b6a92e36e9 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1046,11 +1046,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-kontron-pitx-imx8m.dtb \
 	imx8mq-librem5-r4.dtb
 
-dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-11x11-evk.dtb \
-	imx93-var-som-symphony.dtb \
-	imx93-phyboard-segin.dtb
-
 dtb-$(CONFIG_ARCH_IMXRT) += imxrt1050-evk.dtb \
 	imxrt1020-evk.dtb \
 	imxrt1170-evk.dtb \
diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a99ba99bfb4..4a834ded44c 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,6 +26,112 @@
 	bootph-pre-ram;
 };
 
+/* The node should be removed after upstream supports it */
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	adp5585gpio: gpio@34 {
+		compatible = "adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &aips1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -44,6 +150,19 @@
 &iomuxc {
 	bootph-pre-ram;
 	bootph-some-ram;
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx93-11x11-evk.dts b/arch/arm/dts/imx93-11x11-evk.dts
deleted file mode 100644
index 4322cc3e11b..00000000000
--- a/arch/arm/dts/imx93-11x11-evk.dts
+++ /dev/null
@@ -1,322 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-/dts-v1/;
-
-#include "imx93.dtsi"
-
-/ {
-	model = "NXP i.MX93 11X11 EVK board";
-	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_vref_1v8>;
-	status = "okay";
-};
-
-&mu1 {
-	status = "okay";
-};
-
-&mu2 {
-	status = "okay";
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy2>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	adp5585gpio: gpio@34 {
-		compatible = "adp5585";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&lpuart1 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-	no-sdio;
-	no-mmc;
-};
-
-&iomuxc {
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
-
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
-			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
-			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
-			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx93-phyboard-segin.dts b/arch/arm/dts/imx93-phyboard-segin.dts
deleted file mode 100644
index 85fb188b057..00000000000
--- a/arch/arm/dts/imx93-phyboard-segin.dts
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2023 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
- * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
- *
- * Product homepage:
- * phyBOARD-Segin carrier board is reused for the i.MX93 design.
- * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
- */
-/dts-v1/;
-
-#include "imx93-phycore-som.dtsi"
-
-/{
-	model = "PHYTEC phyBOARD-Segin-i.MX93";
-	compatible = "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-som",
-		     "fsl,imx93";
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "VCC_SD";
-	};
-};
-
-/* Console */
-&lpuart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-/* eMMC */
-&usdhc1 {
-	no-1-8-v;
-};
-
-/* SD-Card */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
-	bus-width = <4>;
-	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
-	no-mmc;
-	no-sdio;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_cd: usdhc2cdgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_default: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x179e
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK            0x179e
-			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK            0x178e
-			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx93-phycore-som.dtsi b/arch/arm/dts/imx93-phycore-som.dtsi
deleted file mode 100644
index 88c2657b50e..00000000000
--- a/arch/arm/dts/imx93-phycore-som.dtsi
+++ /dev/null
@@ -1,126 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2023 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
- * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
- *
- * Product homepage:
- * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
- */
-
-#include <dt-bindings/leds/common.h>
-
-#include "imx93.dtsi"
-
-/{
-	model = "PHYTEC phyCORE-i.MX93";
-	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
-
-	reserved-memory {
-		ranges;
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		linux,cma {
-			compatible = "shared-dma-pool";
-			reusable;
-			alloc-ranges = <0 0x80000000 0 0x40000000>;
-			size = <0 0x10000000>;
-			linux,cma-default;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds>;
-
-		led-0 {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_HEARTBEAT;
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-};
-
-/* Ethernet */
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
-	fsl,magic-packet;
-	assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
-			  <&clk IMX93_CLK_ENET_REF>,
-			  <&clk IMX93_CLK_ENET_REF_PHY>;
-	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-	assigned-clock-rates = <100000000>, <50000000>, <50000000>;
-	status = "okay";
-
-	mdio: mdio {
-		clock-frequency = <5000000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-		};
-	};
-};
-
-/* eMMC */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-/* Watchdog */
-&wdog3 {
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_MDC__ENET1_MDC			0x50e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x502
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RX_ER			0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x50e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x50e
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x50e
-			MX93_PAD_ENET2_TD2__ENET1_TX_CLK		0x4000050e
-		>;
-	};
-
-	pinctrl_leds: ledsgrp {
-		fsl,pins = <
-			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x31e
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x179e
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x1386
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx93-pinfunc.h b/arch/arm/dts/imx93-pinfunc.h
deleted file mode 100644
index 4298a145f8a..00000000000
--- a/arch/arm/dts/imx93-pinfunc.h
+++ /dev/null
@@ -1,623 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Copyright 2022 NXP
- */
-
-#ifndef __DTS_IMX93_PINFUNC_H
-#define __DTS_IMX93_PINFUNC_H
-
-/*
- * The pin function ID is a tuple of
- * <mux_reg conf_reg input_reg mux_mode input_val>
- */
-#define MX93_PAD_DAP_TDI__JTAG_MUX_TDI                            0x0000 0x01B0 0x03D8 0x0 0x0
-#define MX93_PAD_DAP_TDI__MQS2_LEFT                               0x0000 0x01B0 0x0000 0x1 0x0
-#define MX93_PAD_DAP_TDI__CAN2_TX                                 0x0000 0x01B0 0x0000 0x3 0x0
-#define MX93_PAD_DAP_TDI__FLEXIO2_FLEXIO30                        0x0000 0x01B0 0x0000 0x4 0x0
-#define MX93_PAD_DAP_TDI__GPIO3_IO28                              0x0000 0x01B0 0x0000 0x5 0x0
-#define MX93_PAD_DAP_TDI__LPUART5_RX                              0x0000 0x01B0 0x0430 0x6 0x0
-#define MX93_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                      0x0004 0x01B4 0x03DC 0x0 0x0
-#define MX93_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO31                  0x0004 0x01B4 0x0000 0x4 0x0
-#define MX93_PAD_DAP_TMS_SWDIO__GPIO3_IO29                        0x0004 0x01B4 0x0000 0x5 0x0
-#define MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                     0x0004 0x01B4 0x0000 0x6 0x0
-#define MX93_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                     0x0008 0x01B8 0x03D4 0x0 0x0
-#define MX93_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO30                 0x0008 0x01B8 0x0000 0x4 0x0
-#define MX93_PAD_DAP_TCLK_SWCLK__GPIO3_IO30                       0x0008 0x01B8 0x0000 0x5 0x0
-#define MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                    0x0008 0x01B8 0x042C 0x6 0x0
-#define MX93_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                   0x000C 0x01BC 0x0000 0x0 0x0
-#define MX93_PAD_DAP_TDO_TRACESWO__MQS2_RIGHT                     0x000C 0x01BC 0x0000 0x1 0x0
-#define MX93_PAD_DAP_TDO_TRACESWO__CAN2_RX                        0x000C 0x01BC 0x0364 0x3 0x0
-#define MX93_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO31               0x000C 0x01BC 0x0000 0x4 0x0
-#define MX93_PAD_DAP_TDO_TRACESWO__GPIO3_IO31                     0x000C 0x01BC 0x0000 0x5 0x0
-#define MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX                     0x000C 0x01BC 0x0434 0x6 0x0
-#define MX93_PAD_GPIO_IO00__GPIO2_IO00                            0x0010 0x01C0 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO00__LPI2C3_SDA                            0x0010 0x01C0 0x03E4 0x11 0x0
-#define MX93_PAD_GPIO_IO00__MEDIAMIX_CAM_CLK                      0x0010 0x01C0 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK                     0x0010 0x01C0 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO00__LPSPI6_PCS0                           0x0010 0x01C0 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO00__LPUART5_TX                            0x0010 0x01C0 0x0434 0x5 0x1
-#define MX93_PAD_GPIO_IO00__LPI2C5_SDA                            0x0010 0x01C0 0x03EC 0x16 0x0
-#define MX93_PAD_GPIO_IO00__FLEXIO1_FLEXIO00                      0x0010 0x01C0 0x036C 0x7 0x0
-#define MX93_PAD_GPIO_IO01__GPIO2_IO01                            0x0014 0x01C4 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO01__LPI2C3_SCL                            0x0014 0x01C4 0x03E0 0x11 0x0
-#define MX93_PAD_GPIO_IO01__MEDIAMIX_CAM_DATA00                   0x0014 0x01C4 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO01__MEDIAMIX_DISP_DE                      0x0014 0x01C4 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO01__LPSPI6_SIN                            0x0014 0x01C4 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO01__LPUART5_RX                            0x0014 0x01C4 0x0430 0x5 0x1
-#define MX93_PAD_GPIO_IO01__LPI2C5_SCL                            0x0014 0x01C4 0x03E8 0x16 0x0
-#define MX93_PAD_GPIO_IO01__FLEXIO1_FLEXIO01                      0x0014 0x01C4 0x0370 0x7 0x0
-#define MX93_PAD_GPIO_IO02__GPIO2_IO02                            0x0018 0x01C8 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO02__LPI2C4_SDA                            0x0018 0x01C8 0x0000 0x11 0x0
-#define MX93_PAD_GPIO_IO02__MEDIAMIX_CAM_VSYNC                    0x0018 0x01C8 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC                   0x0018 0x01C8 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO02__LPSPI6_SOUT                           0x0018 0x01C8 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO02__LPUART5_CTS_B                         0x0018 0x01C8 0x042C 0x5 0x1
-#define MX93_PAD_GPIO_IO02__LPI2C6_SDA                            0x0018 0x01C8 0x03F4 0x16 0x0
-#define MX93_PAD_GPIO_IO02__FLEXIO1_FLEXIO02                      0x0018 0x01C8 0x0374 0x7 0x0
-#define MX93_PAD_GPIO_IO03__GPIO2_IO03                            0x001C 0x01CC 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO03__LPI2C4_SCL                            0x001C 0x01CC 0x0000 0x11 0x0
-#define MX93_PAD_GPIO_IO03__MEDIAMIX_CAM_HSYNC                    0x001C 0x01CC 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC                   0x001C 0x01CC 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO03__LPSPI6_SCK                            0x001C 0x01CC 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO03__LPUART5_RTS_B                         0x001C 0x01CC 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO03__LPI2C6_SCL                            0x001C 0x01CC 0x03F0 0x16 0x0
-#define MX93_PAD_GPIO_IO03__FLEXIO1_FLEXIO03                      0x001C 0x01CC 0x0378 0x7 0x0
-#define MX93_PAD_GPIO_IO04__GPIO2_IO04                            0x0020 0x01D0 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO04__TPM3_CH0                              0x0020 0x01D0 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO04__PDM_CLK                               0x0020 0x01D0 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA00                  0x0020 0x01D0 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO04__LPSPI7_PCS0                           0x0020 0x01D0 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO04__LPUART6_TX                            0x0020 0x01D0 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO04__LPI2C6_SDA                            0x0020 0x01D0 0x03F4 0x16 0x1
-#define MX93_PAD_GPIO_IO04__FLEXIO1_FLEXIO04                      0x0020 0x01D0 0x037C 0x7 0x0
-#define MX93_PAD_GPIO_IO05__GPIO2_IO05                            0x0024 0x01D4 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO05__TPM4_CH0                              0x0024 0x01D4 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO05__PDM_BIT_STREAM00                      0x0024 0x01D4 0x0438 0x2 0x0
-#define MX93_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA01                  0x0024 0x01D4 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO05__LPSPI7_SIN                            0x0024 0x01D4 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO05__LPUART6_RX                            0x0024 0x01D4 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO05__LPI2C6_SCL                            0x0024 0x01D4 0x03F0 0x16 0x1
-#define MX93_PAD_GPIO_IO05__FLEXIO1_FLEXIO05                      0x0024 0x01D4 0x0380 0x7 0x0
-#define MX93_PAD_GPIO_IO06__GPIO2_IO06                            0x0028 0x01D8 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO06__TPM5_CH0                              0x0028 0x01D8 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO06__PDM_BIT_STREAM01                      0x0028 0x01D8 0x043C 0x2 0x0
-#define MX93_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA02                  0x0028 0x01D8 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO06__LPSPI7_SOUT                           0x0028 0x01D8 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO06__LPUART6_CTS_B                         0x0028 0x01D8 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO06__LPI2C7_SDA                            0x0028 0x01D8 0x03FC 0x16 0x0
-#define MX93_PAD_GPIO_IO06__FLEXIO1_FLEXIO06                      0x0028 0x01D8 0x0384 0x7 0x0
-#define MX93_PAD_GPIO_IO07__GPIO2_IO07                            0x002C 0x01DC 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO07__LPSPI3_PCS1                           0x002C 0x01DC 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO07__MEDIAMIX_CAM_DATA01                   0x002C 0x01DC 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA03                  0x002C 0x01DC 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO07__LPSPI7_SCK                            0x002C 0x01DC 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO07__LPUART6_RTS_B                         0x002C 0x01DC 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO07__LPI2C7_SCL                            0x002C 0x01DC 0x03F8 0x16 0x0
-#define MX93_PAD_GPIO_IO07__FLEXIO1_FLEXIO07                      0x002C 0x01DC 0x0388 0x7 0x0
-#define MX93_PAD_GPIO_IO08__GPIO2_IO08                            0x0030 0x01E0 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO08__LPSPI3_PCS0                           0x0030 0x01E0 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO08__MEDIAMIX_CAM_DATA02                   0x0030 0x01E0 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA04                  0x0030 0x01E0 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO08__TPM6_CH0                              0x0030 0x01E0 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO08__LPUART7_TX                            0x0030 0x01E0 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO08__LPI2C7_SDA                            0x0030 0x01E0 0x03FC 0x16 0x1
-#define MX93_PAD_GPIO_IO08__FLEXIO1_FLEXIO08                      0x0030 0x01E0 0x038C 0x7 0x0
-#define MX93_PAD_GPIO_IO09__GPIO2_IO09                            0x0034 0x01E4 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO09__LPSPI3_SIN                            0x0034 0x01E4 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO09__MEDIAMIX_CAM_DATA03                   0x0034 0x01E4 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA05                  0x0034 0x01E4 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO09__TPM3_EXTCLK                           0x0034 0x01E4 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO09__LPUART7_RX                            0x0034 0x01E4 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO09__LPI2C7_SCL                            0x0034 0x01E4 0x03F8 0x16 0x1
-#define MX93_PAD_GPIO_IO09__FLEXIO1_FLEXIO09                      0x0034 0x01E4 0x0390 0x7 0x0
-#define MX93_PAD_GPIO_IO10__GPIO2_IO10                            0x0038 0x01E8 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO10__LPSPI3_SOUT                           0x0038 0x01E8 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO10__MEDIAMIX_CAM_DATA04                   0x0038 0x01E8 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA06                  0x0038 0x01E8 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO10__TPM4_EXTCLK                           0x0038 0x01E8 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO10__LPUART7_CTS_B                         0x0038 0x01E8 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO10__LPI2C8_SDA                            0x0038 0x01E8 0x0404 0x16 0x0
-#define MX93_PAD_GPIO_IO10__FLEXIO1_FLEXIO10                      0x0038 0x01E8 0x0394 0x7 0x0
-#define MX93_PAD_GPIO_IO11__GPIO2_IO11                            0x003C 0x01EC 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO11__LPSPI3_SCK                            0x003C 0x01EC 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO11__MEDIAMIX_CAM_DATA05                   0x003C 0x01EC 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA07                  0x003C 0x01EC 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO11__TPM5_EXTCLK                           0x003C 0x01EC 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO11__LPUART7_RTS_B                         0x003C 0x01EC 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO11__LPI2C8_SCL                            0x003C 0x01EC 0x0400 0x16 0x0
-#define MX93_PAD_GPIO_IO11__FLEXIO1_FLEXIO11                      0x003C 0x01EC 0x0398 0x7 0x0
-#define MX93_PAD_GPIO_IO12__GPIO2_IO12                            0x0040 0x01F0 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO12__TPM3_CH2                              0x0040 0x01F0 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO12__PDM_BIT_STREAM02                      0x0040 0x01F0 0x0440 0x2 0x0
-#define MX93_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA08                  0x0040 0x01F0 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO12__LPSPI8_PCS0                           0x0040 0x01F0 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO12__LPUART8_TX                            0x0040 0x01F0 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO12__LPI2C8_SDA                            0x0040 0x01F0 0x0404 0x16 0x1
-#define MX93_PAD_GPIO_IO12__SAI3_RX_SYNC                          0x0040 0x01F0 0x0450 0x7 0x0
-#define MX93_PAD_GPIO_IO13__GPIO2_IO13                            0x0044 0x01F4 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO13__TPM4_CH2                              0x0044 0x01F4 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO13__PDM_BIT_STREAM03                      0x0044 0x01F4 0x0444 0x2 0x0
-#define MX93_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA09                  0x0044 0x01F4 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO13__LPSPI8_SIN                            0x0044 0x01F4 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO13__LPUART8_RX                            0x0044 0x01F4 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO13__LPI2C8_SCL                            0x0044 0x01F4 0x0400 0x16 0x1
-#define MX93_PAD_GPIO_IO13__FLEXIO1_FLEXIO13                      0x0044 0x01F4 0x039C 0x7 0x0
-#define MX93_PAD_GPIO_IO14__GPIO2_IO14                            0x0048 0x01F8 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO14__LPUART3_TX                            0x0048 0x01F8 0x041C 0x1 0x0
-#define MX93_PAD_GPIO_IO14__MEDIAMIX_CAM_DATA06                   0x0048 0x01F8 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10                  0x0048 0x01F8 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO14__LPSPI8_SOUT                           0x0048 0x01F8 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO14__LPUART8_CTS_B                         0x0048 0x01F8 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO14__LPUART4_TX                            0x0048 0x01F8 0x0428 0x6 0x0
-#define MX93_PAD_GPIO_IO14__FLEXIO1_FLEXIO14                      0x0048 0x01F8 0x03A0 0x7 0x0
-#define MX93_PAD_GPIO_IO15__GPIO2_IO15                            0x004C 0x01FC 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO15__LPUART3_RX                            0x004C 0x01FC 0x0418 0x1 0x0
-#define MX93_PAD_GPIO_IO15__MEDIAMIX_CAM_DATA07                   0x004C 0x01FC 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11                  0x004C 0x01FC 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO15__LPSPI8_SCK                            0x004C 0x01FC 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO15__LPUART8_RTS_B                         0x004C 0x01FC 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO15__LPUART4_RX                            0x004C 0x01FC 0x0424 0x6 0x0
-#define MX93_PAD_GPIO_IO15__FLEXIO1_FLEXIO15                      0x004C 0x01FC 0x03A4 0x7 0x0
-#define MX93_PAD_GPIO_IO16__GPIO2_IO16                            0x0050 0x0200 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO16__SAI3_TX_BCLK                          0x0050 0x0200 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO16__PDM_BIT_STREAM02                      0x0050 0x0200 0x0440 0x2 0x1
-#define MX93_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12                  0x0050 0x0200 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO16__LPUART3_CTS_B                         0x0050 0x0200 0x0414 0x4 0x0
-#define MX93_PAD_GPIO_IO16__LPSPI4_PCS2                           0x0050 0x0200 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO16__LPUART4_CTS_B                         0x0050 0x0200 0x0420 0x6 0x0
-#define MX93_PAD_GPIO_IO16__FLEXIO1_FLEXIO16                      0x0050 0x0200 0x03A8 0x7 0x0
-#define MX93_PAD_GPIO_IO17__GPIO2_IO17                            0x0054 0x0204 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO17__SAI3_MCLK                             0x0054 0x0204 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO17__MEDIAMIX_CAM_DATA08                   0x0054 0x0204 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13                  0x0054 0x0204 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO17__LPUART3_RTS_B                         0x0054 0x0204 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO17__LPSPI4_PCS1                           0x0054 0x0204 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO17__LPUART4_RTS_B                         0x0054 0x0204 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO17__FLEXIO1_FLEXIO17                      0x0054 0x0204 0x03AC 0x7 0x0
-#define MX93_PAD_GPIO_IO18__GPIO2_IO18                            0x0058 0x0208 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO18__SAI3_RX_BCLK                          0x0058 0x0208 0x044C 0x1 0x0
-#define MX93_PAD_GPIO_IO18__MEDIAMIX_CAM_DATA09                   0x0058 0x0208 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14                  0x0058 0x0208 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO18__LPSPI5_PCS0                           0x0058 0x0208 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO18__LPSPI4_PCS0                           0x0058 0x0208 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO18__TPM5_CH2                              0x0058 0x0208 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO18__FLEXIO1_FLEXIO18                      0x0058 0x0208 0x03B0 0x7 0x0
-#define MX93_PAD_GPIO_IO19__GPIO2_IO19                            0x005C 0x020C 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO19__SAI3_RX_SYNC                          0x005C 0x020C 0x0450 0x1 0x1
-#define MX93_PAD_GPIO_IO19__PDM_BIT_STREAM03                      0x005C 0x020C 0x0444 0x2 0x1
-#define MX93_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15                  0x005C 0x020C 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO19__LPSPI5_SIN                            0x005C 0x020C 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO19__LPSPI4_SIN                            0x005C 0x020C 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO19__TPM6_CH2                              0x005C 0x020C 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO19__SAI3_TX_DATA00                        0x005C 0x020C 0x0000 0x7 0x0
-#define MX93_PAD_GPIO_IO20__GPIO2_IO20                            0x0060 0x0210 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO20__SAI3_RX_DATA00                        0x0060 0x0210 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO20__PDM_BIT_STREAM00                      0x0060 0x0210 0x0438 0x2 0x1
-#define MX93_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16                  0x0060 0x0210 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO20__LPSPI5_SOUT                           0x0060 0x0210 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO20__LPSPI4_SOUT                           0x0060 0x0210 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO20__TPM3_CH1                              0x0060 0x0210 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO20__FLEXIO1_FLEXIO20                      0x0060 0x0210 0x03B4 0x7 0x0
-#define MX93_PAD_GPIO_IO21__GPIO2_IO21                            0x0064 0x0214 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO21__SAI3_TX_DATA00                        0x0064 0x0214 0x0000 0x1 0x0
-#define MX93_PAD_GPIO_IO21__PDM_CLK                               0x0064 0x0214 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17                  0x0064 0x0214 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO21__LPSPI5_SCK                            0x0064 0x0214 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO21__LPSPI4_SCK                            0x0064 0x0214 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO21__TPM4_CH1                              0x0064 0x0214 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO21__SAI3_RX_BCLK                          0x0064 0x0214 0x044C 0x7 0x1
-#define MX93_PAD_GPIO_IO22__GPIO2_IO22                            0x0068 0x0218 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO22__USDHC3_CLK                            0x0068 0x0218 0x0458 0x1 0x0
-#define MX93_PAD_GPIO_IO22__SPDIF_IN                              0x0068 0x0218 0x0454 0x2 0x0
-#define MX93_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18                  0x0068 0x0218 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO22__TPM5_CH1                              0x0068 0x0218 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO22__TPM6_EXTCLK                           0x0068 0x0218 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO22__LPI2C5_SDA                            0x0068 0x0218 0x03EC 0x16 0x1
-#define MX93_PAD_GPIO_IO22__FLEXIO1_FLEXIO22                      0x0068 0x0218 0x03B8 0x7 0x0
-#define MX93_PAD_GPIO_IO23__GPIO2_IO23                            0x006C 0x021C 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO23__USDHC3_CMD                            0x006C 0x021C 0x045C 0x1 0x0
-#define MX93_PAD_GPIO_IO23__SPDIF_OUT                             0x006C 0x021C 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19                  0x006C 0x021C 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO23__TPM6_CH1                              0x006C 0x021C 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO23__LPI2C5_SCL                            0x006C 0x021C 0x03E8 0x16 0x1
-#define MX93_PAD_GPIO_IO23__FLEXIO1_FLEXIO23                      0x006C 0x021C 0x03BC 0x7 0x0
-#define MX93_PAD_GPIO_IO24__GPIO2_IO24                            0x0070 0x0220 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO24__USDHC3_DATA0                          0x0070 0x0220 0x0460 0x1 0x0
-#define MX93_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20                  0x0070 0x0220 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO24__TPM3_CH3                              0x0070 0x0220 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO24__JTAG_MUX_TDO                          0x0070 0x0220 0x0000 0x5 0x0
-#define MX93_PAD_GPIO_IO24__LPSPI6_PCS1                           0x0070 0x0220 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO24__FLEXIO1_FLEXIO24                      0x0070 0x0220 0x03C0 0x7 0x0
-#define MX93_PAD_GPIO_IO25__GPIO2_IO25                            0x0074 0x0224 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO25__USDHC3_DATA1                          0x0074 0x0224 0x0464 0x1 0x0
-#define MX93_PAD_GPIO_IO25__CAN2_TX                               0x0074 0x0224 0x0000 0x2 0x0
-#define MX93_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21                  0x0074 0x0224 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO25__TPM4_CH3                              0x0074 0x0224 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO25__JTAG_MUX_TCK                          0x0074 0x0224 0x03D4 0x5 0x1
-#define MX93_PAD_GPIO_IO25__LPSPI7_PCS1                           0x0074 0x0224 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO25__FLEXIO1_FLEXIO25                      0x0074 0x0224 0x03C4 0x7 0x0
-#define MX93_PAD_GPIO_IO26__GPIO2_IO26                            0x0078 0x0228 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO26__USDHC3_DATA2                          0x0078 0x0228 0x0468 0x1 0x0
-#define MX93_PAD_GPIO_IO26__PDM_BIT_STREAM01                      0x0078 0x0228 0x043C 0x2 0x1
-#define MX93_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22                  0x0078 0x0228 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO26__TPM5_CH3                              0x0078 0x0228 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO26__JTAG_MUX_TDI                          0x0078 0x0228 0x03D8 0x5 0x1
-#define MX93_PAD_GPIO_IO26__LPSPI8_PCS1                           0x0078 0x0228 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO26__SAI3_TX_SYNC                          0x0078 0x0228 0x0000 0x7 0x0
-#define MX93_PAD_GPIO_IO27__GPIO2_IO27                            0x007C 0x022C 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO27__USDHC3_DATA3                          0x007C 0x022C 0x046C 0x1 0x0
-#define MX93_PAD_GPIO_IO27__CAN2_RX                               0x007C 0x022C 0x0364 0x2 0x1
-#define MX93_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23                  0x007C 0x022C 0x0000 0x3 0x0
-#define MX93_PAD_GPIO_IO27__TPM6_CH3                              0x007C 0x022C 0x0000 0x4 0x0
-#define MX93_PAD_GPIO_IO27__JTAG_MUX_TMS                          0x007C 0x022C 0x03DC 0x5 0x1
-#define MX93_PAD_GPIO_IO27__LPSPI5_PCS1                           0x007C 0x022C 0x0000 0x6 0x0
-#define MX93_PAD_GPIO_IO27__FLEXIO1_FLEXIO27                      0x007C 0x022C 0x03C8 0x7 0x0
-#define MX93_PAD_GPIO_IO28__GPIO2_IO28                            0x0080 0x0230 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO28__LPI2C3_SDA                            0x0080 0x0230 0x03E4 0x11 0x1
-#define MX93_PAD_GPIO_IO28__FLEXIO1_FLEXIO28                      0x0080 0x0230 0x0000 0x7 0x0
-#define MX93_PAD_GPIO_IO29__GPIO2_IO29                            0x0084 0x0234 0x0000 0x0 0x0
-#define MX93_PAD_GPIO_IO29__LPI2C3_SCL                            0x0084 0x0234 0x03E0 0x11 0x1
-#define MX93_PAD_GPIO_IO29__FLEXIO1_FLEXIO29                      0x0084 0x0234 0x0000 0x7 0x0
-#define MX93_PAD_CCM_CLKO1__CCMSRCGPCMIX_CLKO1                    0x0088 0x0238 0x0000 0x0 0x0
-#define MX93_PAD_CCM_CLKO1__FLEXIO1_FLEXIO26                      0x0088 0x0238 0x0000 0x4 0x0
-#define MX93_PAD_CCM_CLKO1__GPIO3_IO26                            0x0088 0x0238 0x0000 0x5 0x0
-#define MX93_PAD_CCM_CLKO2__GPIO3_IO27                            0x008C 0x023C 0x0000 0x5 0x0
-#define MX93_PAD_CCM_CLKO2__CCMSRCGPCMIX_CLKO2                    0x008C 0x023C 0x0000 0x0 0x0
-#define MX93_PAD_CCM_CLKO2__FLEXIO1_FLEXIO27                      0x008C 0x023C 0x03C8 0x4 0x1
-#define MX93_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3                    0x0090 0x0240 0x0000 0x0 0x0
-#define MX93_PAD_CCM_CLKO3__FLEXIO2_FLEXIO28                      0x0090 0x0240 0x0000 0x4 0x0
-#define MX93_PAD_CCM_CLKO3__GPIO4_IO28                            0x0090 0x0240 0x0000 0x5 0x0
-#define MX93_PAD_CCM_CLKO4__CCMSRCGPCMIX_CLKO4                    0x0094 0x0244 0x0000 0x0 0x0
-#define MX93_PAD_CCM_CLKO4__FLEXIO2_FLEXIO29                      0x0094 0x0244 0x0000 0x4 0x0
-#define MX93_PAD_CCM_CLKO4__GPIO4_IO29                            0x0094 0x0244 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_MDC__ENET_QOS_MDC                          0x0098 0x0248 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_MDC__LPUART3_DCB_B                         0x0098 0x0248 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_MDC__I3C2_SCL                              0x0098 0x0248 0x03CC 0x2 0x0
-#define MX93_PAD_ENET1_MDC__HSIOMIX_OTG_ID1                       0x0098 0x0248 0x0000 0x3 0x0
-#define MX93_PAD_ENET1_MDC__FLEXIO2_FLEXIO00                      0x0098 0x0248 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_MDC__GPIO4_IO00                            0x0098 0x0248 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO                        0x009C 0x024C 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_MDIO__LPUART3_RIN_B                        0x009C 0x024C 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_MDIO__I3C2_SDA                             0x009C 0x024C 0x03D0 0x2 0x0
-#define MX93_PAD_ENET1_MDIO__HSIOMIX_OTG_PWR1                     0x009C 0x024C 0x0000 0x3 0x0
-#define MX93_PAD_ENET1_MDIO__FLEXIO2_FLEXIO01                     0x009C 0x024C 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_MDIO__GPIO4_IO01                           0x009C 0x024C 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                    0x00A0 0x0250 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_TD3__CAN2_TX                               0x00A0 0x0250 0x0000 0x2 0x0
-#define MX93_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                       0x00A0 0x0250 0x0000 0x3 0x0
-#define MX93_PAD_ENET1_TD3__FLEXIO2_FLEXIO02                      0x00A0 0x0250 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_TD3__GPIO4_IO02                            0x00A0 0x0250 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                    0x00A4 0x0254 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_TD2__CCM_ENET_QOS_CLOCK_GENERATE_REF_CLK   0x00A4 0x0254 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_TD2__CAN2_RX                               0x00A4 0x0254 0x0364 0x2 0x2
-#define MX93_PAD_ENET1_TD2__HSIOMIX_OTG_OC2                       0x00A4 0x0254 0x0000 0x3 0x0
-#define MX93_PAD_ENET1_TD2__FLEXIO2_FLEXIO03                      0x00A4 0x0254 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_TD2__GPIO4_IO03                            0x00A4 0x0254 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1                    0x00A8 0x0258 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_TD1__LPUART3_RTS_B                         0x00A8 0x0258 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_TD1__I3C2_PUR                              0x00A8 0x0258 0x0000 0x2 0x0
-#define MX93_PAD_ENET1_TD1__HSIOMIX_OTG_OC1                       0x00A8 0x0258 0x0000 0x3 0x0
-#define MX93_PAD_ENET1_TD1__FLEXIO2_FLEXIO04                      0x00A8 0x0258 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_TD1__GPIO4_IO04                            0x00A8 0x0258 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_TD1__I3C2_PUR_B                            0x00A8 0x0258 0x0000 0x6 0x0
-#define MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                    0x00AC 0x025C 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_TD0__LPUART3_TX                            0x00AC 0x025C 0x041C 0x1 0x1
-#define MX93_PAD_ENET1_TD0__FLEXIO2_FLEXIO05                      0x00AC 0x025C 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_TD0__GPIO4_IO05                            0x00AC 0x025C 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL              0x00B0 0x0260 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_TX_CTL__LPUART3_DTR_B                      0x00B0 0x0260 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO06                   0x00B0 0x0260 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_TX_CTL__GPIO4_IO06                         0x00B0 0x0260 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK    0x00B4 0x0264 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_TXC__ENET_QOS_TX_ER                        0x00B4 0x0264 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_TXC__FLEXIO2_FLEXIO07                      0x00B4 0x0264 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_TXC__GPIO4_IO07                            0x00B4 0x0264 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL              0x00B8 0x0268 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_RX_CTL__LPUART3_DSR_B                      0x00B8 0x0268 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_RX_CTL__HSIOMIX_OTG_PWR2                   0x00B8 0x0268 0x0000 0x3 0x0
-#define MX93_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO08                   0x00B8 0x0268 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_RX_CTL__GPIO4_IO08                         0x00B8 0x0268 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK    0x00BC 0x026C 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_RXC__ENET_QOS_RX_ER                        0x00BC 0x026C 0x0000 0x1 0x0
-#define MX93_PAD_ENET1_RXC__FLEXIO2_FLEXIO09                      0x00BC 0x026C 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_RXC__GPIO4_IO09                            0x00BC 0x026C 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                    0x00C0 0x0270 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_RD0__LPUART3_RX                            0x00C0 0x0270 0x0418 0x1 0x1
-#define MX93_PAD_ENET1_RD0__FLEXIO2_FLEXIO10                      0x00C0 0x0270 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_RD0__GPIO4_IO10                            0x00C0 0x0270 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                    0x00C4 0x0274 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_RD1__LPUART3_CTS_B                         0x00C4 0x0274 0x0414 0x1 0x1
-#define MX93_PAD_ENET1_RD1__LPTMR2_ALT1                           0x00C4 0x0274 0x0408 0x3 0x0
-#define MX93_PAD_ENET1_RD1__FLEXIO2_FLEXIO11                      0x00C4 0x0274 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_RD1__GPIO4_IO11                            0x00C4 0x0274 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                    0x00C8 0x0278 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_RD2__LPTMR2_ALT2                           0x00C8 0x0278 0x040C 0x3 0x0
-#define MX93_PAD_ENET1_RD2__FLEXIO2_FLEXIO12                      0x00C8 0x0278 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_RD2__GPIO4_IO12                            0x00C8 0x0278 0x0000 0x5 0x0
-#define MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                    0x00CC 0x027C 0x0000 0x0 0x0
-#define MX93_PAD_ENET1_RD3__FLEXSPI1_TESTER_TRIGGER               0x00CC 0x027C 0x0000 0x2 0x0
-#define MX93_PAD_ENET1_RD3__LPTMR2_ALT3                           0x00CC 0x027C 0x0410 0x3 0x0
-#define MX93_PAD_ENET1_RD3__FLEXIO2_FLEXIO13                      0x00CC 0x027C 0x0000 0x4 0x0
-#define MX93_PAD_ENET1_RD3__GPIO4_IO13                            0x00CC 0x027C 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_MDC__ENET1_MDC                             0x00D0 0x0280 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_MDC__LPUART4_DCB_B                         0x00D0 0x0280 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_MDC__SAI2_RX_SYNC                          0x00D0 0x0280 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_MDC__FLEXIO2_FLEXIO14                      0x00D0 0x0280 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_MDC__GPIO4_IO14                            0x00D0 0x0280 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_MDIO__ENET1_MDIO                           0x00D4 0x0284 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_MDIO__LPUART4_RIN_B                        0x00D4 0x0284 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_MDIO__SAI2_RX_BCLK                         0x00D4 0x0284 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_MDIO__FLEXIO2_FLEXIO15                     0x00D4 0x0284 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_MDIO__GPIO4_IO15                           0x00D4 0x0284 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_TD3__SAI2_RX_DATA00                        0x00D8 0x0288 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_TD3__FLEXIO2_FLEXIO16                      0x00D8 0x0288 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_TD3__GPIO4_IO16                            0x00D8 0x0288 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3                       0x00D8 0x0288 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2                       0x00DC 0x028C 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_TD2__ENET1_TX_CLK                          0x00DC 0x028C 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_TD2__SAI2_RX_DATA01                        0x00DC 0x028C 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_TD2__FLEXIO2_FLEXIO17                      0x00DC 0x028C 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_TD2__GPIO4_IO17                            0x00DC 0x028C 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1                       0x00E0 0x0290 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_TD1__LPUART4_RTS_B                         0x00E0 0x0290 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_TD1__SAI2_RX_DATA02                        0x00E0 0x0290 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_TD1__FLEXIO2_FLEXIO18                      0x00E0 0x0290 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_TD1__GPIO4_IO18                            0x00E0 0x0290 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0                       0x00E4 0x0294 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_TD0__LPUART4_TX                            0x00E4 0x0294 0x0428 0x1 0x1
-#define MX93_PAD_ENET2_TD0__SAI2_RX_DATA03                        0x00E4 0x0294 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_TD0__FLEXIO2_FLEXIO19                      0x00E4 0x0294 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_TD0__GPIO4_IO19                            0x00E4 0x0294 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL                 0x00E8 0x0298 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_TX_CTL__LPUART4_DTR_B                      0x00E8 0x0298 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_TX_CTL__SAI2_TX_SYNC                       0x00E8 0x0298 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO20                   0x00E8 0x0298 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_TX_CTL__GPIO4_IO20                         0x00E8 0x0298 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC                       0x00EC 0x029C 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_TXC__ENET1_TX_ER                           0x00EC 0x029C 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_TXC__SAI2_TX_BCLK                          0x00EC 0x029C 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_TXC__FLEXIO2_FLEXIO21                      0x00EC 0x029C 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_TXC__GPIO4_IO21                            0x00EC 0x029C 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL                 0x00F0 0x02A0 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_RX_CTL__LPUART4_DSR_B                      0x00F0 0x02A0 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_RX_CTL__SAI2_TX_DATA00                     0x00F0 0x02A0 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO22                   0x00F0 0x02A0 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_RX_CTL__GPIO4_IO22                         0x00F0 0x02A0 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC                       0x00F4 0x02A4 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_RXC__ENET1_RX_ER                           0x00F4 0x02A4 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_RXC__SAI2_TX_DATA01                        0x00F4 0x02A4 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_RXC__FLEXIO2_FLEXIO23                      0x00F4 0x02A4 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_RXC__GPIO4_IO23                            0x00F4 0x02A4 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0                       0x00F8 0x02A8 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_RD0__LPUART4_RX                            0x00F8 0x02A8 0x0424 0x1 0x1
-#define MX93_PAD_ENET2_RD0__SAI2_TX_DATA02                        0x00F8 0x02A8 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_RD0__FLEXIO2_FLEXIO24                      0x00F8 0x02A8 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_RD0__GPIO4_IO24                            0x00F8 0x02A8 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1                       0x00FC 0x02AC 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_RD1__SPDIF_IN                              0x00FC 0x02AC 0x0454 0x1 0x1
-#define MX93_PAD_ENET2_RD1__SAI2_TX_DATA03                        0x00FC 0x02AC 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_RD1__FLEXIO2_FLEXIO25                      0x00FC 0x02AC 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_RD1__GPIO4_IO25                            0x00FC 0x02AC 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2                       0x0100 0x02B0 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_RD2__LPUART4_CTS_B                         0x0100 0x02B0 0x0420 0x1 0x1
-#define MX93_PAD_ENET2_RD2__SAI2_MCLK                             0x0100 0x02B0 0x0000 0x2 0x0
-#define MX93_PAD_ENET2_RD2__MQS2_RIGHT                            0x0100 0x02B0 0x0000 0x3 0x0
-#define MX93_PAD_ENET2_RD2__FLEXIO2_FLEXIO26                      0x0100 0x02B0 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_RD2__GPIO4_IO26                            0x0100 0x02B0 0x0000 0x5 0x0
-#define MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3                       0x0104 0x02B4 0x0000 0x0 0x0
-#define MX93_PAD_ENET2_RD3__SPDIF_OUT                             0x0104 0x02B4 0x0000 0x1 0x0
-#define MX93_PAD_ENET2_RD3__SPDIF_IN                              0x0104 0x02B4 0x0454 0x2 0x2
-#define MX93_PAD_ENET2_RD3__MQS2_LEFT                             0x0104 0x02B4 0x0000 0x3 0x0
-#define MX93_PAD_ENET2_RD3__FLEXIO2_FLEXIO27                      0x0104 0x02B4 0x0000 0x4 0x0
-#define MX93_PAD_ENET2_RD3__GPIO4_IO27                            0x0104 0x02B4 0x0000 0x5 0x0
-#define MX93_PAD_SD1_CLK__FLEXIO1_FLEXIO08                        0x0108 0x02B8 0x038C 0x4 0x1
-#define MX93_PAD_SD1_CLK__GPIO3_IO08                              0x0108 0x02B8 0x0000 0x5 0x0
-#define MX93_PAD_SD1_CLK__USDHC1_CLK                              0x0108 0x02B8 0x0000 0x0 0x0
-#define MX93_PAD_SD1_CMD__USDHC1_CMD                              0x010C 0x02BC 0x0000 0x0 0x0
-#define MX93_PAD_SD1_CMD__FLEXIO1_FLEXIO09                        0x010C 0x02BC 0x0390 0x4 0x1
-#define MX93_PAD_SD1_CMD__GPIO3_IO09                              0x010C 0x02BC 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA0__USDHC1_DATA0                          0x0110 0x02C0 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA0__FLEXIO1_FLEXIO10                      0x0110 0x02C0 0x0394 0x4 0x1
-#define MX93_PAD_SD1_DATA0__GPIO3_IO10                            0x0110 0x02C0 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA1__USDHC1_DATA1                          0x0114 0x02C4 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA1__FLEXIO1_FLEXIO11                      0x0114 0x02C4 0x0398 0x4 0x1
-#define MX93_PAD_SD1_DATA1__GPIO3_IO11                            0x0114 0x02C4 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA1__CCMSRCGPCMIX_INT_BOOT                 0x0114 0x02C4 0x0000 0x6 0x0
-#define MX93_PAD_SD1_DATA2__USDHC1_DATA2                          0x0118 0x02C8 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA2__FLEXIO1_FLEXIO12                      0x0118 0x02C8 0x0000 0x4 0x0
-#define MX93_PAD_SD1_DATA2__GPIO3_IO12                            0x0118 0x02C8 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA2__CCMSRCGPCMIX_PMIC_READY               0x0118 0x02C8 0x0000 0x6 0x0
-#define MX93_PAD_SD1_DATA3__USDHC1_DATA3                          0x011C 0x02CC 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                      0x011C 0x02CC 0x0000 0x1 0x0
-#define MX93_PAD_SD1_DATA3__FLEXIO1_FLEXIO13                      0x011C 0x02CC 0x039C 0x4 0x1
-#define MX93_PAD_SD1_DATA3__GPIO3_IO13                            0x011C 0x02CC 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA4__USDHC1_DATA4                          0x0120 0x02D0 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA4__FLEXSPI1_A_DATA04                     0x0120 0x02D0 0x0000 0x1 0x0
-#define MX93_PAD_SD1_DATA4__FLEXIO1_FLEXIO14                      0x0120 0x02D0 0x03A0 0x4 0x1
-#define MX93_PAD_SD1_DATA4__GPIO3_IO14                            0x0120 0x02D0 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA5__USDHC1_DATA5                          0x0124 0x02D4 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA5__FLEXSPI1_A_DATA05                     0x0124 0x02D4 0x0000 0x1 0x0
-#define MX93_PAD_SD1_DATA5__USDHC1_RESET_B                        0x0124 0x02D4 0x0000 0x2 0x0
-#define MX93_PAD_SD1_DATA5__FLEXIO1_FLEXIO15                      0x0124 0x02D4 0x03A4 0x4 0x1
-#define MX93_PAD_SD1_DATA5__GPIO3_IO15                            0x0124 0x02D4 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA6__USDHC1_DATA6                          0x0128 0x02D8 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA6__FLEXSPI1_A_DATA06                     0x0128 0x02D8 0x0000 0x1 0x0
-#define MX93_PAD_SD1_DATA6__USDHC1_CD_B                           0x0128 0x02D8 0x0000 0x2 0x0
-#define MX93_PAD_SD1_DATA6__FLEXIO1_FLEXIO16                      0x0128 0x02D8 0x03A8 0x4 0x1
-#define MX93_PAD_SD1_DATA6__GPIO3_IO16                            0x0128 0x02D8 0x0000 0x5 0x0
-#define MX93_PAD_SD1_DATA7__USDHC1_DATA7                          0x012C 0x02DC 0x0000 0x0 0x0
-#define MX93_PAD_SD1_DATA7__FLEXSPI1_A_DATA07                     0x012C 0x02DC 0x0000 0x1 0x0
-#define MX93_PAD_SD1_DATA7__USDHC1_WP                             0x012C 0x02DC 0x0000 0x2 0x0
-#define MX93_PAD_SD1_DATA7__FLEXIO1_FLEXIO17                      0x012C 0x02DC 0x03AC 0x4 0x1
-#define MX93_PAD_SD1_DATA7__GPIO3_IO17                            0x012C 0x02DC 0x0000 0x5 0x0
-#define MX93_PAD_SD1_STROBE__USDHC1_STROBE                        0x0130 0x02E0 0x0000 0x0 0x0
-#define MX93_PAD_SD1_STROBE__FLEXSPI1_A_DQS                       0x0130 0x02E0 0x0000 0x1 0x0
-#define MX93_PAD_SD1_STROBE__FLEXIO1_FLEXIO18                     0x0130 0x02E0 0x03B0 0x4 0x1
-#define MX93_PAD_SD1_STROBE__GPIO3_IO18                           0x0130 0x02E0 0x0000 0x5 0x0
-#define MX93_PAD_SD2_VSELECT__USDHC2_VSELECT                      0x0134 0x02E4 0x0000 0x0 0x0
-#define MX93_PAD_SD2_VSELECT__USDHC2_WP                           0x0134 0x02E4 0x0000 0x1 0x0
-#define MX93_PAD_SD2_VSELECT__LPTMR2_ALT3                         0x0134 0x02E4 0x0410 0x2 0x1
-#define MX93_PAD_SD2_VSELECT__FLEXIO1_FLEXIO19                    0x0134 0x02E4 0x0000 0x4 0x0
-#define MX93_PAD_SD2_VSELECT__GPIO3_IO19                          0x0134 0x02E4 0x0000 0x5 0x0
-#define MX93_PAD_SD2_VSELECT__CCMSRCGPCMIX_EXT_CLK1               0x0134 0x02E4 0x0368 0x6 0x0
-#define MX93_PAD_SD3_CLK__USDHC3_CLK                              0x0138 0x02E8 0x0458 0x0 0x1
-#define MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK                         0x0138 0x02E8 0x0000 0x1 0x0
-#define MX93_PAD_SD3_CLK__FLEXIO1_FLEXIO20                        0x0138 0x02E8 0x03B4 0x4 0x1
-#define MX93_PAD_SD3_CLK__GPIO3_IO20                              0x0138 0x02E8 0x0000 0x5 0x0
-#define MX93_PAD_SD3_CMD__USDHC3_CMD                              0x013C 0x02EC 0x045C 0x0 0x1
-#define MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                        0x013C 0x02EC 0x0000 0x1 0x0
-#define MX93_PAD_SD3_CMD__FLEXIO1_FLEXIO21                        0x013C 0x02EC 0x0000 0x4 0x0
-#define MX93_PAD_SD3_CMD__GPIO3_IO21                              0x013C 0x02EC 0x0000 0x5 0x0
-#define MX93_PAD_SD3_DATA0__USDHC3_DATA0                          0x0140 0x02F0 0x0460 0x0 0x1
-#define MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00                     0x0140 0x02F0 0x0000 0x1 0x0
-#define MX93_PAD_SD3_DATA0__FLEXIO1_FLEXIO22                      0x0140 0x02F0 0x03B8 0x4 0x1
-#define MX93_PAD_SD3_DATA0__GPIO3_IO22                            0x0140 0x02F0 0x0000 0x5 0x0
-#define MX93_PAD_SD3_DATA1__USDHC3_DATA1                          0x0144 0x02F4 0x0464 0x0 0x1
-#define MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01                     0x0144 0x02F4 0x0000 0x1 0x0
-#define MX93_PAD_SD3_DATA1__FLEXIO1_FLEXIO23                      0x0144 0x02F4 0x03BC 0x4 0x1
-#define MX93_PAD_SD3_DATA1__GPIO3_IO23                            0x0144 0x02F4 0x0000 0x5 0x0
-#define MX93_PAD_SD3_DATA2__USDHC3_DATA2                          0x0148 0x02F8 0x0468 0x0 0x1
-#define MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02                     0x0148 0x02F8 0x0000 0x1 0x0
-#define MX93_PAD_SD3_DATA2__FLEXIO1_FLEXIO24                      0x0148 0x02F8 0x03C0 0x4 0x1
-#define MX93_PAD_SD3_DATA2__GPIO3_IO24                            0x0148 0x02F8 0x0000 0x5 0x0
-#define MX93_PAD_SD3_DATA3__USDHC3_DATA3                          0x014C 0x02FC 0x046C 0x0 0x1
-#define MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03                     0x014C 0x02FC 0x0000 0x1 0x0
-#define MX93_PAD_SD3_DATA3__FLEXIO1_FLEXIO25                      0x014C 0x02FC 0x03C4 0x4 0x1
-#define MX93_PAD_SD3_DATA3__GPIO3_IO25                            0x014C 0x02FC 0x0000 0x5 0x0
-#define MX93_PAD_SD2_CD_B__USDHC2_CD_B                            0x0150 0x0300 0x0000 0x0 0x0
-#define MX93_PAD_SD2_CD_B__ENET_QOS_1588_EVENT0_IN                0x0150 0x0300 0x0000 0x1 0x0
-#define MX93_PAD_SD2_CD_B__I3C2_SCL                               0x0150 0x0300 0x03CC 0x2 0x1
-#define MX93_PAD_SD2_CD_B__FLEXIO1_FLEXIO00                       0x0150 0x0300 0x036C 0x4 0x1
-#define MX93_PAD_SD2_CD_B__GPIO3_IO00                             0x0150 0x0300 0x0000 0x5 0x0
-#define MX93_PAD_SD2_CLK__USDHC2_CLK                              0x0154 0x0304 0x0000 0x0 0x0
-#define MX93_PAD_SD2_CLK__ENET_QOS_1588_EVENT0_OUT                0x0154 0x0304 0x0000 0x1 0x0
-#define MX93_PAD_SD2_CLK__I3C2_SDA                                0x0154 0x0304 0x03D0 0x2 0x1
-#define MX93_PAD_SD2_CLK__FLEXIO1_FLEXIO01                        0x0154 0x0304 0x0370 0x4 0x1
-#define MX93_PAD_SD2_CLK__GPIO3_IO01                              0x0154 0x0304 0x0000 0x5 0x0
-#define MX93_PAD_SD2_CLK__CCMSRCGPCMIX_OBSERVE0                   0x0154 0x0304 0x0000 0x6 0x0
-#define MX93_PAD_SD2_CMD__USDHC2_CMD                              0x0158 0x0308 0x0000 0x0 0x0
-#define MX93_PAD_SD2_CMD__ENET1_1588_EVENT0_IN                    0x0158 0x0308 0x0000 0x1 0x0
-#define MX93_PAD_SD2_CMD__I3C2_PUR                                0x0158 0x0308 0x0000 0x2 0x0
-#define MX93_PAD_SD2_CMD__I3C2_PUR_B                              0x0158 0x0308 0x0000 0x3 0x0
-#define MX93_PAD_SD2_CMD__FLEXIO1_FLEXIO02                        0x0158 0x0308 0x0374 0x4 0x1
-#define MX93_PAD_SD2_CMD__GPIO3_IO02                              0x0158 0x0308 0x0000 0x5 0x0
-#define MX93_PAD_SD2_CMD__CCMSRCGPCMIX_OBSERVE1                   0x0158 0x0308 0x0000 0x6 0x0
-#define MX93_PAD_SD2_DATA0__USDHC2_DATA0                          0x015C 0x030C 0x0000 0x0 0x0
-#define MX93_PAD_SD2_DATA0__ENET1_1588_EVENT0_OUT                 0x015C 0x030C 0x0000 0x1 0x0
-#define MX93_PAD_SD2_DATA0__CAN2_TX                               0x015C 0x030C 0x0000 0x2 0x0
-#define MX93_PAD_SD2_DATA0__FLEXIO1_FLEXIO03                      0x015C 0x030C 0x0378 0x4 0x1
-#define MX93_PAD_SD2_DATA0__GPIO3_IO03                            0x015C 0x030C 0x0000 0x5 0x0
-#define MX93_PAD_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                 0x015C 0x030C 0x0000 0x6 0x0
-#define MX93_PAD_SD2_DATA1__USDHC2_DATA1                          0x0160 0x0310 0x0000 0x0 0x0
-#define MX93_PAD_SD2_DATA1__ENET1_1588_EVENT1_IN                  0x0160 0x0310 0x0000 0x1 0x0
-#define MX93_PAD_SD2_DATA1__CAN2_RX                               0x0160 0x0310 0x0364 0x2 0x3
-#define MX93_PAD_SD2_DATA1__FLEXIO1_FLEXIO04                      0x0160 0x0310 0x037C 0x4 0x1
-#define MX93_PAD_SD2_DATA1__GPIO3_IO04                            0x0160 0x0310 0x0000 0x5 0x0
-#define MX93_PAD_SD2_DATA1__CCMSRCGPCMIX_WAIT                     0x0160 0x0310 0x0000 0x6 0x0
-#define MX93_PAD_SD2_DATA2__USDHC2_DATA2                          0x0164 0x0314 0x0000 0x0 0x0
-#define MX93_PAD_SD2_DATA2__ENET1_1588_EVENT1_OUT                 0x0164 0x0314 0x0000 0x1 0x0
-#define MX93_PAD_SD2_DATA2__MQS2_RIGHT                            0x0164 0x0314 0x0000 0x2 0x0
-#define MX93_PAD_SD2_DATA2__FLEXIO1_FLEXIO05                      0x0164 0x0314 0x0380 0x4 0x1
-#define MX93_PAD_SD2_DATA2__GPIO3_IO05                            0x0164 0x0314 0x0000 0x5 0x0
-#define MX93_PAD_SD2_DATA2__CCMSRCGPCMIX_STOP                     0x0164 0x0314 0x0000 0x6 0x0
-#define MX93_PAD_SD2_DATA3__USDHC2_DATA3                          0x0168 0x0318 0x0000 0x0 0x0
-#define MX93_PAD_SD2_DATA3__LPTMR2_ALT1                           0x0168 0x0318 0x0408 0x1 0x1
-#define MX93_PAD_SD2_DATA3__MQS2_LEFT                             0x0168 0x0318 0x0000 0x2 0x0
-#define MX93_PAD_SD2_DATA3__FLEXIO1_FLEXIO06                      0x0168 0x0318 0x0384 0x4 0x1
-#define MX93_PAD_SD2_DATA3__GPIO3_IO06                            0x0168 0x0318 0x0000 0x5 0x0
-#define MX93_PAD_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET              0x0168 0x0318 0x0000 0x6 0x0
-#define MX93_PAD_SD2_RESET_B__USDHC2_RESET_B                      0x016C 0x031C 0x0000 0x0 0x0
-#define MX93_PAD_SD2_RESET_B__LPTMR2_ALT2                         0x016C 0x031C 0x040C 0x1 0x1
-#define MX93_PAD_SD2_RESET_B__FLEXIO1_FLEXIO07                    0x016C 0x031C 0x0388 0x4 0x1
-#define MX93_PAD_SD2_RESET_B__GPIO3_IO07                          0x016C 0x031C 0x0000 0x5 0x0
-#define MX93_PAD_SD2_RESET_B__CCMSRCGPCMIX_SYSTEM_RESET           0x016C 0x031C 0x0000 0x6 0x0
-#define MX93_PAD_I2C1_SCL__LPI2C1_SCL                             0x0170 0x0320 0x0000 0x10 0x0
-#define MX93_PAD_I2C1_SCL__I3C1_SCL                               0x0170 0x0320 0x0000 0x1 0x0
-#define MX93_PAD_I2C1_SCL__LPUART1_DCB_B                          0x0170 0x0320 0x0000 0x2 0x0
-#define MX93_PAD_I2C1_SCL__TPM2_CH0                               0x0170 0x0320 0x0000 0x3 0x0
-#define MX93_PAD_I2C1_SCL__GPIO1_IO00                             0x0170 0x0320 0x0000 0x5 0x0
-#define MX93_PAD_I2C1_SDA__LPI2C1_SDA                             0x0174 0x0324 0x0000 0x10 0x0
-#define MX93_PAD_I2C1_SDA__I3C1_SDA                               0x0174 0x0324 0x0000 0x1 0x0
-#define MX93_PAD_I2C1_SDA__LPUART1_RIN_B                          0x0174 0x0324 0x0000 0x2 0x0
-#define MX93_PAD_I2C1_SDA__TPM2_CH1                               0x0174 0x0324 0x0000 0x3 0x0
-#define MX93_PAD_I2C1_SDA__GPIO1_IO01                             0x0174 0x0324 0x0000 0x5 0x0
-#define MX93_PAD_I2C2_SCL__LPI2C2_SCL                             0x0178 0x0328 0x0000 0x10 0x0
-#define MX93_PAD_I2C2_SCL__I3C1_PUR                               0x0178 0x0328 0x0000 0x1 0x0
-#define MX93_PAD_I2C2_SCL__LPUART2_DCB_B                          0x0178 0x0328 0x0000 0x2 0x0
-#define MX93_PAD_I2C2_SCL__TPM2_CH2                               0x0178 0x0328 0x0000 0x3 0x0
-#define MX93_PAD_I2C2_SCL__SAI1_RX_SYNC                           0x0178 0x0328 0x0000 0x4 0x0
-#define MX93_PAD_I2C2_SCL__GPIO1_IO02                             0x0178 0x0328 0x0000 0x5 0x0
-#define MX93_PAD_I2C2_SCL__I3C1_PUR_B                             0x0178 0x0328 0x0000 0x6 0x0
-#define MX93_PAD_I2C2_SDA__LPI2C2_SDA                             0x017C 0x032C 0x0000 0x10 0x0
-#define MX93_PAD_I2C2_SDA__LPUART2_RIN_B                          0x017C 0x032C 0x0000 0x2 0x0
-#define MX93_PAD_I2C2_SDA__TPM2_CH3                               0x017C 0x032C 0x0000 0x3 0x0
-#define MX93_PAD_I2C2_SDA__SAI1_RX_BCLK                           0x017C 0x032C 0x0000 0x4 0x0
-#define MX93_PAD_I2C2_SDA__GPIO1_IO03                             0x017C 0x032C 0x0000 0x5 0x0
-#define MX93_PAD_UART1_RXD__LPUART1_RX                            0x0180 0x0330 0x0000 0x0 0x0
-#define MX93_PAD_UART1_RXD__S400_UART_RX                          0x0180 0x0330 0x0000 0x1 0x0
-#define MX93_PAD_UART1_RXD__LPSPI2_SIN                            0x0180 0x0330 0x0000 0x2 0x0
-#define MX93_PAD_UART1_RXD__TPM1_CH0                              0x0180 0x0330 0x0000 0x3 0x0
-#define MX93_PAD_UART1_RXD__GPIO1_IO04                            0x0180 0x0330 0x0000 0x5 0x0
-#define MX93_PAD_UART1_TXD__LPUART1_TX                            0x0184 0x0334 0x0000 0x0 0x0
-#define MX93_PAD_UART1_TXD__S400_UART_TX                          0x0184 0x0334 0x0000 0x1 0x0
-#define MX93_PAD_UART1_TXD__LPSPI2_PCS0                           0x0184 0x0334 0x0000 0x2 0x0
-#define MX93_PAD_UART1_TXD__TPM1_CH1                              0x0184 0x0334 0x0000 0x3 0x0
-#define MX93_PAD_UART1_TXD__GPIO1_IO05                            0x0184 0x0334 0x0000 0x5 0x0
-#define MX93_PAD_UART2_RXD__LPUART2_RX                            0x0188 0x0338 0x0000 0x0 0x0
-#define MX93_PAD_UART2_RXD__LPUART1_CTS_B                         0x0188 0x0338 0x0000 0x1 0x0
-#define MX93_PAD_UART2_RXD__LPSPI2_SOUT                           0x0188 0x0338 0x0000 0x2 0x0
-#define MX93_PAD_UART2_RXD__TPM1_CH2                              0x0188 0x0338 0x0000 0x3 0x0
-#define MX93_PAD_UART2_RXD__SAI1_MCLK                             0x0188 0x0338 0x0448 0x4 0x0
-#define MX93_PAD_UART2_RXD__GPIO1_IO06                            0x0188 0x0338 0x0000 0x5 0x0
-#define MX93_PAD_UART2_TXD__LPUART2_TX                            0x018C 0x033C 0x0000 0x0 0x0
-#define MX93_PAD_UART2_TXD__LPUART1_RTS_B                         0x018C 0x033C 0x0000 0x1 0x0
-#define MX93_PAD_UART2_TXD__LPSPI2_SCK                            0x018C 0x033C 0x0000 0x2 0x0
-#define MX93_PAD_UART2_TXD__TPM1_CH3                              0x018C 0x033C 0x0000 0x3 0x0
-#define MX93_PAD_UART2_TXD__GPIO1_IO07                            0x018C 0x033C 0x0000 0x5 0x0
-#define MX93_PAD_PDM_CLK__PDM_CLK                                 0x0190 0x0340 0x0000 0x0 0x0
-#define MX93_PAD_PDM_CLK__MQS1_LEFT                               0x0190 0x0340 0x0000 0x1 0x0
-#define MX93_PAD_PDM_CLK__LPTMR1_ALT1                             0x0190 0x0340 0x0000 0x4 0x0
-#define MX93_PAD_PDM_CLK__GPIO1_IO08                              0x0190 0x0340 0x0000 0x5 0x0
-#define MX93_PAD_PDM_CLK__CAN1_TX                                 0x0190 0x0340 0x0000 0x6 0x0
-#define MX93_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM00                0x0194 0x0344 0x0438 0x0 0x2
-#define MX93_PAD_PDM_BIT_STREAM0__MQS1_RIGHT                      0x0194 0x0344 0x0000 0x1 0x0
-#define MX93_PAD_PDM_BIT_STREAM0__LPSPI1_PCS1                     0x0194 0x0344 0x0000 0x2 0x0
-#define MX93_PAD_PDM_BIT_STREAM0__TPM1_EXTCLK                     0x0194 0x0344 0x0000 0x3 0x0
-#define MX93_PAD_PDM_BIT_STREAM0__LPTMR1_ALT2                     0x0194 0x0344 0x0000 0x4 0x0
-#define MX93_PAD_PDM_BIT_STREAM0__GPIO1_IO09                      0x0194 0x0344 0x0000 0x5 0x0
-#define MX93_PAD_PDM_BIT_STREAM0__CAN1_RX                         0x0194 0x0344 0x0360 0x6 0x0
-#define MX93_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM01                0x0198 0x0348 0x043C 0x0 0x2
-#define MX93_PAD_PDM_BIT_STREAM1__NMI_GLUE_NMI                    0x0198 0x0348 0x0000 0x1 0x0
-#define MX93_PAD_PDM_BIT_STREAM1__LPSPI2_PCS1                     0x0198 0x0348 0x0000 0x2 0x0
-#define MX93_PAD_PDM_BIT_STREAM1__TPM2_EXTCLK                     0x0198 0x0348 0x0000 0x3 0x0
-#define MX93_PAD_PDM_BIT_STREAM1__LPTMR1_ALT3                     0x0198 0x0348 0x0000 0x4 0x0
-#define MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10                      0x0198 0x0348 0x0000 0x5 0x0
-#define MX93_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_EXT_CLK1           0x0198 0x0348 0x0368 0x6 0x1
-#define MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC                          0x019C 0x034C 0x0000 0x0 0x0
-#define MX93_PAD_SAI1_TXFS__SAI1_TX_DATA01                        0x019C 0x034C 0x0000 0x1 0x0
-#define MX93_PAD_SAI1_TXFS__LPSPI1_PCS0                           0x019C 0x034C 0x0000 0x2 0x0
-#define MX93_PAD_SAI1_TXFS__LPUART2_DTR_B                         0x019C 0x034C 0x0000 0x3 0x0
-#define MX93_PAD_SAI1_TXFS__MQS1_LEFT                             0x019C 0x034C 0x0000 0x4 0x0
-#define MX93_PAD_SAI1_TXFS__GPIO1_IO11                            0x019C 0x034C 0x0000 0x5 0x0
-#define MX93_PAD_SAI1_TXC__SAI1_TX_BCLK                           0x01A0 0x0350 0x0000 0x0 0x0
-#define MX93_PAD_SAI1_TXC__LPUART2_CTS_B                          0x01A0 0x0350 0x0000 0x1 0x0
-#define MX93_PAD_SAI1_TXC__LPSPI1_SIN                             0x01A0 0x0350 0x0000 0x2 0x0
-#define MX93_PAD_SAI1_TXC__LPUART1_DSR_B                          0x01A0 0x0350 0x0000 0x3 0x0
-#define MX93_PAD_SAI1_TXC__CAN1_RX                                0x01A0 0x0350 0x0360 0x4 0x1
-#define MX93_PAD_SAI1_TXC__GPIO1_IO12                             0x01A0 0x0350 0x0000 0x5 0x0
-#define MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00                        0x01A4 0x0354 0x0000 0x0 0x0
-#define MX93_PAD_SAI1_TXD0__LPUART2_RTS_B                         0x01A4 0x0354 0x0000 0x1 0x0
-#define MX93_PAD_SAI1_TXD0__LPSPI1_SCK                            0x01A4 0x0354 0x0000 0x2 0x0
-#define MX93_PAD_SAI1_TXD0__LPUART1_DTR_B                         0x01A4 0x0354 0x0000 0x3 0x0
-#define MX93_PAD_SAI1_TXD0__CAN1_TX                               0x01A4 0x0354 0x0000 0x4 0x0
-#define MX93_PAD_SAI1_TXD0__GPIO1_IO13                            0x01A4 0x0354 0x0000 0x5 0x0
-#define MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00                        0x01A8 0x0358 0x0000 0x0 0x0
-#define MX93_PAD_SAI1_RXD0__SAI1_MCLK                             0x01A8 0x0358 0x0448 0x1 0x1
-#define MX93_PAD_SAI1_RXD0__LPSPI1_SOUT                           0x01A8 0x0358 0x0000 0x2 0x0
-#define MX93_PAD_SAI1_RXD0__LPUART2_DSR_B                         0x01A8 0x0358 0x0000 0x3 0x0
-#define MX93_PAD_SAI1_RXD0__MQS1_RIGHT                            0x01A8 0x0358 0x0000 0x4 0x0
-#define MX93_PAD_SAI1_RXD0__GPIO1_IO14                            0x01A8 0x0358 0x0000 0x5 0x0
-#define MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY                         0x01AC 0x035C 0x0000 0x0 0x0
-#define MX93_PAD_WDOG_ANY__GPIO1_IO15                             0x01AC 0x035C 0x0000 0x5 0x0
-
-#endif /* __DTS_IMX93_PINFUNC_H */
diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index 40e17bbc5ae..2bd42a7f66a 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -86,3 +86,83 @@
 		};
 	};
 };
+
+&tmu {
+	compatible = "fsl,imx93-tmu";
+	reg = <0x44482000 0x1000>;
+	clocks = <&clk IMX93_CLK_TMC_GATE>;
+	little-endian;
+	fsl,tmu-calibration = <0x0000000e 0x800000da
+			       0x00000029 0x800000e9
+			       0x00000056 0x80000102
+			       0x000000a2 0x8000012a
+			       0x00000116 0x80000166
+			       0x00000195 0x800001a7
+			       0x000001b2 0x800001b6>;
+	#thermal-sensor-cells = <1>;
+};
+
+/*
+ * The following nodes should be deleted after upstream support
+ */
+&{/} {
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+};
+
+&{/soc@0} {
+	usbotg1: usb@4c100000 {
+		compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x4c100000 0x200>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+			 <&clk IMX93_CLK_HSIO_32K_GATE>;
+		clock-names = "usb_ctrl_root_clk", "usb_wakeup";
+		assigned-clocks = <&clk IMX93_CLK_HSIO>;
+		assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+		assigned-clock-rates = <133000000>;
+		phys = <&usbphynop1>;
+		fsl,usbmisc = <&usbmisc1 0>;
+		status = "disabled";
+	};
+
+	usbmisc1: usbmisc@4c100200 {
+		compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+			     "fsl,imx6q-usbmisc";
+		reg = <0x4c100200 0x200>;
+		#index-cells = <1>;
+	};
+
+	usbotg2: usb@4c200000 {
+		compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x4c200000 0x200>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+			 <&clk IMX93_CLK_HSIO_32K_GATE>;
+		clock-names = "usb_ctrl_root_clk", "usb_wakeup";
+		assigned-clocks = <&clk IMX93_CLK_HSIO>;
+		assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+		assigned-clock-rates = <133000000>;
+		phys = <&usbphynop2>;
+		fsl,usbmisc = <&usbmisc2 0>;
+		status = "disabled";
+	};
+
+	usbmisc2: usbmisc@4c200200 {
+		compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+			     "fsl,imx6q-usbmisc";
+		reg = <0x4c200200 0x200>;
+		#index-cells = <1>;
+	};
+};
diff --git a/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi b/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
index 1193fc0ca19..e8a5afd2131 100644
--- a/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
+++ b/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
@@ -148,6 +148,28 @@
 	bootph-pre-ram;
 };
 
+/*
+ * The two nodes below won't be needed once support is added
+ * to the Linux kernel.
+ */
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 /*
  * The two nodes below won't be needed once nxp,pca9451a
  * support is added to the Linux kernel.
diff --git a/arch/arm/dts/imx93-var-som-symphony.dts b/arch/arm/dts/imx93-var-som-symphony.dts
deleted file mode 100644
index 1bc61942716..00000000000
--- a/arch/arm/dts/imx93-var-som-symphony.dts
+++ /dev/null
@@ -1,323 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2021 NXP
- * Copyright 2023 Variscite Ltd.
- */
-
-/dts-v1/;
-
-#include "imx93-var-som.dtsi"
-
-/{
-	model = "Variscite VAR-SOM-MX93 on Symphony evaluation board";
-	compatible = "variscite,var-som-mx93-symphony",
-		     "variscite,var-som-mx93", "fsl,imx93";
-
-	aliases {
-		ethernet0 = &eqos;
-		ethernet1 = &fec;
-	};
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	/*
-	 * Needed only for Symphony <= v1.5
-	 */
-	reg_fec_phy: regulator-fec-phy {
-		compatible = "regulator-fixed";
-		regulator-name = "fec-phy";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-enable-ramp-delay = <20000>;
-		gpio = <&pca9534 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 18 GPIO_ACTIVE_HIGH>;
-		off-on-delay-us = <20000>;
-		enable-active-high;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		ethosu_mem: ethosu-region@88000000 {
-			compatible = "shared-dma-pool";
-			reusable;
-			reg = <0x0 0x88000000 0x0 0x8000000>;
-		};
-
-		vdev0vring0: vdev0vring0@87ee0000 {
-			reg = <0 0x87ee0000 0 0x8000>;
-			no-map;
-		};
-
-		vdev0vring1: vdev0vring1@87ee8000 {
-			reg = <0 0x87ee8000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring0: vdev1vring0@87ef0000 {
-			reg = <0 0x87ef0000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring1: vdev1vring1@87ef8000 {
-			reg = <0 0x87ef8000 0 0x8000>;
-			no-map;
-		};
-
-		rsc_table: rsc-table@2021f000 {
-			reg = <0 0x2021f000 0 0x1000>;
-			no-map;
-		};
-
-		vdevbuffer: vdevbuffer@87f00000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0x87f00000 0 0x100000>;
-			no-map;
-		};
-
-		ele_reserved: ele-reserved@87de0000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0x87de0000 0 0x100000>;
-			no-map;
-		};
-	};
-};
-
-/* Use external instead of internal RTC*/
-&bbnsm_rtc {
-	status = "disabled";
-};
-
-&eqos {
-	mdio {
-		ethphy1: ethernet-phy@5 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <5>;
-			qca,disable-smarteee;
-			eee-broken-1000t;
-			reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <20000>;
-			vddio-supply = <&vddio1>;
-
-			vddio1: vddio-regulator {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy1>;
-	phy-supply = <&reg_fec_phy>;
-	status = "okay";
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
-			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
-			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
-			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX93_PAD_PDM_CLK__CAN1_TX                       0x139e
-			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX               0x139e
-		>;
-	};
-
-	pinctrl_lpi2c1: lpi2c1grp {
-		fsl,pins = <
-			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
-			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c1_gpio: lpi2c1gpiogrp {
-		fsl,pins = <
-			MX93_PAD_I2C1_SCL__GPIO1_IO00			0x31e
-			MX93_PAD_I2C1_SDA__GPIO1_IO01			0x31e
-		>;
-	};
-
-	pinctrl_lpi2c5: lpi2c5grp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
-			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO23__GPIO2_IO23			0x31e
-			MX93_PAD_GPIO_IO22__GPIO2_IO22			0x31e
-		>;
-	};
-
-	pinctrl_pca9534: pca9534grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO18__GPIO2_IO18		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-};
-
-&lpi2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c1>;
-	pinctrl-1 = <&pinctrl_lpi2c1_gpio>;
-	pinctrl-2 = <&pinctrl_lpi2c1_gpio>;
-	scl-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-
-	/* DS1337 RTC module */
-	rtc@68 {
-		compatible = "dallas,ds1337";
-		reg = <0x68>;
-	};
-};
-
-&lpi2c5 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c5>;
-	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
-	pinctrl-2 = <&pinctrl_lpi2c5_gpio>;
-	scl-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-
-	pca9534: gpio@20 {
-		compatible = "nxp,pca9534";
-		reg = <0x20>;
-		gpio-controller;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pca9534>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
-		#gpio-cells = <2>;
-		wakeup-source;
-	};
-};
-
-/* Console */
-&lpuart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	clocks = <&clk IMX93_CLK_LPUART1_GATE>, <&clk IMX93_CLK_LPUART1_GATE>;
-	clock-names = "ipg", "per";
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	disable-over-current;
-	status = "okay";
-};
-
-/* SD */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-	no-sdio;
-	no-mmc;
-};
-
-/* Watchdog */
-&wdog3 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx93-var-som.dtsi b/arch/arm/dts/imx93-var-som.dtsi
deleted file mode 100644
index 6c77b886666..00000000000
--- a/arch/arm/dts/imx93-var-som.dtsi
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- * Copyright 2023 Variscite Ltd.
- */
-
-/dts-v1/;
-
-#include "imx93.dtsi"
-
-/{
-	model = "Variscite VAR-SOM-MX93 module";
-	compatible = "variscite,var-som-mx93", "fsl,imx93";
-
-	mmc_pwrseq: mmc-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		post-power-on-delay-ms = <100>;
-		power-off-delay-us = <10000>;
-		reset-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>,	/* WIFI_RESET */
-			      <&gpio3 7 GPIO_ACTIVE_LOW>;	/* WIFI_PWR_EN */
-	};
-
-	reg_eqos_phy: regulator-eqos-phy {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_eqos_phy>;
-		regulator-name = "eth_phy_pwr";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100000>;
-		regulator-always-on;
-	};
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy0>;
-	phy-supply = <&reg_eqos_phy>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <1000000>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_reg_eqos_phy: regeqosgrp {
-		fsl,pins = <
-			MX93_PAD_UART2_TXD__GPIO1_IO07			0x51e
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-};
-
-/* eMMC */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx93.dtsi b/arch/arm/dts/imx93.dtsi
deleted file mode 100644
index d6964714ea0..00000000000
--- a/arch/arm/dts/imx93.dtsi
+++ /dev/null
@@ -1,906 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-#include <dt-bindings/clock/imx93-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/fsl,imx93-power.h>
-#include <dt-bindings/thermal/thermal.h>
-
-#include "imx93-pinfunc.h"
-
-/ {
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		i2c0 = &lpi2c1;
-		i2c1 = &lpi2c2;
-		i2c2 = &lpi2c3;
-		i2c3 = &lpi2c4;
-		i2c4 = &lpi2c5;
-		i2c5 = &lpi2c6;
-		i2c6 = &lpi2c7;
-		i2c7 = &lpi2c8;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		mmc2 = &usdhc3;
-		serial0 = &lpuart1;
-		serial1 = &lpuart2;
-		serial2 = &lpuart3;
-		serial3 = &lpuart4;
-		serial4 = &lpuart5;
-		serial5 = &lpuart6;
-		serial6 = &lpuart7;
-		serial7 = &lpuart8;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		A55_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x0>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-		};
-
-	};
-
-	osc_32k: clock-osc-32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "osc_32k";
-	};
-
-	osc_24m: clock-osc-24m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "osc_24m";
-	};
-
-	clk_ext1: clock-ext1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext1";
-	};
-
-	pmu {
-		compatible = "arm,cortex-a55-pmu";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <24000000>;
-		arm,no-tick-in-suspend;
-		interrupt-parent = <&gic>;
-	};
-
-	gic: interrupt-controller@48000000 {
-		compatible = "arm,gic-v3";
-		reg = <0 0x48000000 0 0x10000>,
-		      <0 0x48040000 0 0xc0000>;
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-	};
-
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	usbphynop1: usbphynop1 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	usbphynop2: usbphynop2 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x80000000>,
-			 <0x28000000 0x0 0x28000000 0x10000000>;
-
-		aips1: bus@44000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x44000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			anomix_ns_gpr: syscon@44210000 {
-				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
-				reg = <0x44210000 0x1000>;
-			};
-
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			system_counter: timer@44290000 {
-				compatible = "nxp,sysctr-timer";
-				reg = <0x44290000 0x30000>;
-				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&osc_24m>;
-				clock-names = "per";
-				nxp,no-divider;
-			};
-
-			tpm1: pwm@44310000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44310000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM1_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm2: pwm@44320000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44320000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM2_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			lpi2c1: i2c@44340000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44340000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c2: i2c@44350000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44350000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi1: spi@44360000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44360000 0x10000>;
-				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi2: spi@44370000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44370000 0x10000>;
-				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44380000 0x1000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART1_GATE>, <&clk IMX93_CLK_LPUART1_GATE>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44390000 0x1000>;
-				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			flexcan1: can@443a0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x443a0000 0x10000>;
-				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_AON>,
-					 <&clk IMX93_CLK_CAN1_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				status = "disabled";
-			};
-
-			iomuxc: pinctrl@443c0000 {
-				compatible = "fsl,imx93-iomuxc";
-				reg = <0x443c0000 0x10000>;
-				status = "okay";
-			};
-
-			bbnsm: bbnsm@44440000 {
-				compatible = "nxp,imx93-bbnsm", "syscon", "simple-mfd";
-				reg = <0x44440000 0x10000>;
-
-				bbnsm_rtc: rtc {
-					compatible = "nxp,imx93-bbnsm-rtc";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				};
-
-				bbnsm_pwrkey: pwrkey {
-					compatible = "nxp,imx93-bbnsm-pwrkey";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-					linux,code = <KEY_POWER>;
-				};
-			};
-
-			clk: clock-controller@44450000 {
-				compatible = "fsl,imx93-ccm";
-				reg = <0x44450000 0x10000>;
-				#clock-cells = <1>;
-				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
-				clock-names = "osc_32k", "osc_24m", "clk_ext1";
-				status = "okay";
-			};
-
-			src: system-controller@44460000 {
-				compatible = "fsl,imx93-src", "syscon";
-				reg = <0x44460000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges;
-
-				mediamix: power-domain@44462400 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44462400 0x400>, <0x44465800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
-						 <&clk IMX93_CLK_MEDIA_APB>;
-				};
-
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-			};
-
-			anatop: anatop@44480000 {
-				compatible = "fsl,imx93-anatop", "syscon";
-				reg = <0x44480000 0x10000>;
-			};
-
-			tmu: tmu@44482000 {
-				compatible = "fsl,imx93-tmu";
-				reg = <0x44482000 0x1000>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-calibration = <0x0000000e 0x800000da
-						       0x00000029 0x800000e9
-						       0x00000056 0x80000102
-						       0x000000a2 0x8000012a
-						       0x00000116 0x80000166
-						       0x00000195 0x800001a7
-						       0x000001b2 0x800001b6>;
-				#thermal-sensor-cells = <1>;
-			};
-
-			adc1: adc@44530000 {
-				compatible = "nxp,imx93-adc";
-				reg = <0x44530000 0x10000>;
-				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ADC1_GATE>;
-				clock-names = "ipg";
-				#io-channel-cells = <1>;
-				status = "disabled";
-			};
-		};
-
-		aips2: bus@42000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			wakeupmix_gpr: syscon@42420000 {
-				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
-				reg = <0x42420000 0x1000>;
-			};
-
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			wdog3: wdog@42490000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x42490000 0x10000>;
-				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
-				timeout-sec = <40>;
-			};
-
-			tpm3: pwm@424e0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424e0000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM3_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm4: pwm@424f0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424f0000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM4_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm5: pwm@42500000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42500000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM5_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm6: pwm@42510000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42510000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM6_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			lpi2c3: i2c@42530000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42530000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c4: i2c@42540000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42540000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi3: spi@42550000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42550000 0x10000>;
-				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi4: spi@42560000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42560000 0x10000>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42570000 0x1000>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42580000 0x1000>;
-				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42590000 0x1000>;
-				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x425a0000 0x1000>;
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			flexcan2: can@425b0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x425b0000 0x10000>;
-				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_CAN2_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN2>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				status = "disabled";
-			};
-
-			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
-				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
-				reg-names = "fspi_base", "fspi_mmap";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_FLEXSPI1_GATE>,
-					 <&clk IMX93_CLK_FLEXSPI1_GATE>;
-				clock-names = "fspi_en", "fspi";
-				assigned-clocks = <&clk IMX93_CLK_FLEXSPI1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				status = "disabled";
-			};
-
-			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42690000 0x1000>;
-				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x426a0000 0x1000>;
-				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpi2c5: i2c@426b0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426b0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c6: i2c@426c0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426c0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c7: i2c@426d0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426d0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c8: i2c@426e0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426e0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi5: spi@426f0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x426f0000 0x10000>;
-				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi6: spi@42700000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42700000 0x10000>;
-				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi7: spi@42710000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42710000 0x10000>;
-				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi8: spi@42720000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42720000 0x10000>;
-				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-		};
-
-		aips3: bus@42800000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			usdhc1: mmc@42850000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42850000 0x10000>;
-				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC1_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <8>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
-				status = "disabled";
-			};
-
-			usdhc2: mmc@42860000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42860000 0x10000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC2_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <4>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
-				status = "disabled";
-			};
-
-			eqos: ethernet@428a0000 {
-				compatible = "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
-				reg = <0x428a0000 0x10000>;
-				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "macirq", "eth_wake_irq";
-				clocks = <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER2>,
-					 <&clk IMX93_CLK_ENET>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>;
-				clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER2>,
-						  <&clk IMX93_CLK_ENET>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>;
-				intf_mode = <&wakeupmix_gpr 0x28>;
-				snps,clk-csr = <0>;
-				status = "disabled";
-			};
-
-			fec: ethernet@42890000 {
-				compatible = "fsl,imx93-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
-				reg = <0x42890000 0x10000>;
-				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER1>,
-					 <&clk IMX93_CLK_ENET_REF>,
-					 <&clk IMX93_CLK_ENET_REF_PHY>;
-				clock-names = "ipg", "ahb", "ptp",
-					      "enet_clk_ref", "enet_out";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
-						  <&clk IMX93_CLK_ENET_REF>,
-						  <&clk IMX93_CLK_ENET_REF_PHY>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>, <50000000>;
-				fsl,num-tx-queues = <3>;
-				fsl,num-rx-queues = <3>;
-				status = "disabled";
-			};
-
-			usdhc3: mmc@428b0000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x428b0000 0x10000>;
-				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC3_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <4>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
-				status = "disabled";
-			};
-		};
-
-		gpio2: gpio@43810080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43810080 0x1000>, <0x43810040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
-				 <&clk IMX93_CLK_GPIO2_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 4 30>;
-		};
-
-		gpio3: gpio@43820080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
-				 <&clk IMX93_CLK_GPIO3_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
-				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
-		};
-
-		gpio4: gpio@43830080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
-				 <&clk IMX93_CLK_GPIO4_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
-		};
-
-		gpio1: gpio@47400080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
-				 <&clk IMX93_CLK_GPIO1_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 92 16>;
-		};
-
-		s4muap: mailbox@47520000 {
-			compatible = "fsl,imx93-mu-s4";
-			reg = <0x47520000 0x10000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tx", "rx";
-			#mbox-cells = <2>;
-		};
-
-		media_blk_ctrl: system-controller@4ac10000 {
-			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
-			reg = <0x4ac10000 0x10000>;
-			power-domains = <&mediamix>;
-			clocks = <&clk IMX93_CLK_MEDIA_APB>,
-				 <&clk IMX93_CLK_MEDIA_AXI>,
-				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
-				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
-				 <&clk IMX93_CLK_CAM_PIX>,
-				 <&clk IMX93_CLK_PXP_GATE>,
-				 <&clk IMX93_CLK_LCDIF_GATE>,
-				 <&clk IMX93_CLK_ISI_GATE>,
-				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
-				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
-			clock-names = "apb", "axi", "nic", "disp", "cam",
-				      "pxp", "lcdif", "isi", "csi", "dsi";
-			#power-domain-cells = <1>;
-			status = "disabled";
-		};
-
-		usbotg1: usb@4c100000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c100000 0x200>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root_clk", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop1>;
-			fsl,usbmisc = <&usbmisc1 0>;
-			status = "disabled";
-		};
-
-		usbmisc1: usbmisc@4c100200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c100200 0x200>;
-			#index-cells = <1>;
-		};
-
-		usbotg2: usb@4c200000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c200000 0x200>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root_clk", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop2>;
-			fsl,usbmisc = <&usbmisc2 0>;
-			status = "disabled";
-		};
-
-		usbmisc2: usbmisc@4c200200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c200200 0x200>;
-			#index-cells = <1>;
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index b79485f1f75..ea42c4980ed 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -15,6 +15,7 @@ config IMX9
 	select BINMAN
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
+	imply OF_UPSTREAM
 
 config IMX93
 	bool
diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
index 54215c51c08..2db19d6f1cd 100644
--- a/configs/imx93-phyboard-segin_defconfig
+++ b/configs/imx93-phyboard-segin_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-phyboard-segin"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_PHYCORE_IMX93=y
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 63613477c7f..a671de7ca40 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx93_11x11_evk_ld_defconfig b/configs/imx93_11x11_evk_ld_defconfig
index 4e3bbdd0cf5..4e1f162e35a 100644
--- a/configs/imx93_11x11_evk_ld_defconfig
+++ b/configs/imx93_11x11_evk_ld_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_IMX9_LOW_DRIVE_MODE=y
 CONFIG_TARGET_IMX93_11X11_EVK=y
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 996cad4854a..15896a68efe 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-var-som-symphony"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-var-som-symphony"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_IMX93_VAR_SOM=y
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
deleted file mode 100644
index 35a1f62053a..00000000000
--- a/include/dt-bindings/clock/imx93-clock.h
+++ /dev/null
@@ -1,208 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
-/*
- * Copyright 2022 NXP
- */
-
-#ifndef __DT_BINDINGS_CLOCK_IMX93_CLK_H
-#define __DT_BINDINGS_CLOCK_IMX93_CLK_H
-
-#define IMX93_CLK_DUMMY			0
-#define IMX93_CLK_24M			1
-#define IMX93_CLK_EXT1			2
-#define IMX93_CLK_SYS_PLL_PFD0		3
-#define IMX93_CLK_SYS_PLL_PFD0_DIV2	4
-#define IMX93_CLK_SYS_PLL_PFD1		5
-#define IMX93_CLK_SYS_PLL_PFD1_DIV2	6
-#define IMX93_CLK_SYS_PLL_PFD2		7
-#define IMX93_CLK_SYS_PLL_PFD2_DIV2	8
-#define IMX93_CLK_AUDIO_PLL		9
-#define IMX93_CLK_VIDEO_PLL		10
-#define IMX93_CLK_A55_PERIPH		11
-#define IMX93_CLK_A55_MTR_BUS		12
-#define IMX93_CLK_A55			13
-#define IMX93_CLK_M33			14
-#define IMX93_CLK_BUS_WAKEUP		15
-#define IMX93_CLK_BUS_AON		16
-#define IMX93_CLK_WAKEUP_AXI		17
-#define IMX93_CLK_SWO_TRACE		18
-#define IMX93_CLK_M33_SYSTICK		19
-#define IMX93_CLK_FLEXIO1		20
-#define IMX93_CLK_FLEXIO2		21
-#define IMX93_CLK_LPTMR1		24
-#define IMX93_CLK_LPTMR2		25
-#define IMX93_CLK_TPM2			27
-#define IMX93_CLK_TPM4			29
-#define IMX93_CLK_TPM5			30
-#define IMX93_CLK_TPM6			31
-#define IMX93_CLK_FLEXSPI1		32
-#define IMX93_CLK_CAN1			33
-#define IMX93_CLK_CAN2			34
-#define IMX93_CLK_LPUART1		35
-#define IMX93_CLK_LPUART2		36
-#define IMX93_CLK_LPUART3		37
-#define IMX93_CLK_LPUART4		38
-#define IMX93_CLK_LPUART5		39
-#define IMX93_CLK_LPUART6		40
-#define IMX93_CLK_LPUART7		41
-#define IMX93_CLK_LPUART8		42
-#define IMX93_CLK_LPI2C1		43
-#define IMX93_CLK_LPI2C2		44
-#define IMX93_CLK_LPI2C3		45
-#define IMX93_CLK_LPI2C4		46
-#define IMX93_CLK_LPI2C5		47
-#define IMX93_CLK_LPI2C6		48
-#define IMX93_CLK_LPI2C7		49
-#define IMX93_CLK_LPI2C8		50
-#define IMX93_CLK_LPSPI1		51
-#define IMX93_CLK_LPSPI2		52
-#define IMX93_CLK_LPSPI3		53
-#define IMX93_CLK_LPSPI4		54
-#define IMX93_CLK_LPSPI5		55
-#define IMX93_CLK_LPSPI6		56
-#define IMX93_CLK_LPSPI7		57
-#define IMX93_CLK_LPSPI8		58
-#define IMX93_CLK_I3C1			59
-#define IMX93_CLK_I3C2			60
-#define IMX93_CLK_USDHC1		61
-#define IMX93_CLK_USDHC2		62
-#define IMX93_CLK_USDHC3		63
-#define IMX93_CLK_SAI1			64
-#define IMX93_CLK_SAI2			65
-#define IMX93_CLK_SAI3			66
-#define IMX93_CLK_CCM_CKO1		67
-#define IMX93_CLK_CCM_CKO2		68
-#define IMX93_CLK_CCM_CKO3		69
-#define IMX93_CLK_CCM_CKO4		70
-#define IMX93_CLK_HSIO			71
-#define IMX93_CLK_HSIO_USB_TEST_60M	72
-#define IMX93_CLK_HSIO_ACSCAN_80M	73
-#define IMX93_CLK_HSIO_ACSCAN_480M	74
-#define IMX93_CLK_ML_APB		75
-#define IMX93_CLK_ML			76
-#define IMX93_CLK_MEDIA_AXI		77
-#define IMX93_CLK_MEDIA_APB		78
-#define IMX93_CLK_MEDIA_LDB		79
-#define IMX93_CLK_MEDIA_DISP_PIX	80
-#define IMX93_CLK_CAM_PIX		81
-#define IMX93_CLK_MIPI_TEST_BYTE	82
-#define IMX93_CLK_MIPI_PHY_CFG		83
-#define IMX93_CLK_ADC			84
-#define IMX93_CLK_PDM			85
-#define IMX93_CLK_TSTMR1		86
-#define IMX93_CLK_TSTMR2		87
-#define IMX93_CLK_MQS1			88
-#define IMX93_CLK_MQS2			89
-#define IMX93_CLK_AUDIO_XCVR		90
-#define IMX93_CLK_SPDIF			91
-#define IMX93_CLK_ENET			92
-#define IMX93_CLK_ENET_TIMER1		93
-#define IMX93_CLK_ENET_TIMER2		94
-#define IMX93_CLK_ENET_REF		95
-#define IMX93_CLK_ENET_REF_PHY		96
-#define IMX93_CLK_I3C1_SLOW		97
-#define IMX93_CLK_I3C2_SLOW		98
-#define IMX93_CLK_USB_PHY_BURUNIN	99
-#define IMX93_CLK_PAL_CAME_SCAN		100
-#define IMX93_CLK_A55_GATE		101
-#define IMX93_CLK_CM33_GATE		102
-#define IMX93_CLK_ADC1_GATE		103
-#define IMX93_CLK_WDOG1_GATE		104
-#define IMX93_CLK_WDOG2_GATE		105
-#define IMX93_CLK_WDOG3_GATE		106
-#define IMX93_CLK_WDOG4_GATE		107
-#define IMX93_CLK_WDOG5_GATE		108
-#define IMX93_CLK_SEMA1_GATE		109
-#define IMX93_CLK_SEMA2_GATE		110
-#define IMX93_CLK_MU_A_GATE		111
-#define IMX93_CLK_MU_B_GATE		112
-#define IMX93_CLK_EDMA1_GATE		113
-#define IMX93_CLK_EDMA2_GATE		114
-#define IMX93_CLK_FLEXSPI1_GATE		115
-#define IMX93_CLK_GPIO1_GATE		116
-#define IMX93_CLK_GPIO2_GATE		117
-#define IMX93_CLK_GPIO3_GATE		118
-#define IMX93_CLK_GPIO4_GATE		119
-#define IMX93_CLK_FLEXIO1_GATE		120
-#define IMX93_CLK_FLEXIO2_GATE		121
-#define IMX93_CLK_LPIT1_GATE		122
-#define IMX93_CLK_LPIT2_GATE		123
-#define IMX93_CLK_LPTMR1_GATE		124
-#define IMX93_CLK_LPTMR2_GATE		125
-#define IMX93_CLK_TPM1_GATE		126
-#define IMX93_CLK_TPM2_GATE		127
-#define IMX93_CLK_TPM3_GATE		128
-#define IMX93_CLK_TPM4_GATE		129
-#define IMX93_CLK_TPM5_GATE		130
-#define IMX93_CLK_TPM6_GATE		131
-#define IMX93_CLK_CAN1_GATE		132
-#define IMX93_CLK_CAN2_GATE		133
-#define IMX93_CLK_LPUART1_GATE		134
-#define IMX93_CLK_LPUART2_GATE		135
-#define IMX93_CLK_LPUART3_GATE		136
-#define IMX93_CLK_LPUART4_GATE		137
-#define IMX93_CLK_LPUART5_GATE		138
-#define IMX93_CLK_LPUART6_GATE		139
-#define IMX93_CLK_LPUART7_GATE		140
-#define IMX93_CLK_LPUART8_GATE		141
-#define IMX93_CLK_LPI2C1_GATE		142
-#define IMX93_CLK_LPI2C2_GATE		143
-#define IMX93_CLK_LPI2C3_GATE		144
-#define IMX93_CLK_LPI2C4_GATE		145
-#define IMX93_CLK_LPI2C5_GATE		146
-#define IMX93_CLK_LPI2C6_GATE		147
-#define IMX93_CLK_LPI2C7_GATE		148
-#define IMX93_CLK_LPI2C8_GATE		149
-#define IMX93_CLK_LPSPI1_GATE		150
-#define IMX93_CLK_LPSPI2_GATE		151
-#define IMX93_CLK_LPSPI3_GATE		152
-#define IMX93_CLK_LPSPI4_GATE		153
-#define IMX93_CLK_LPSPI5_GATE		154
-#define IMX93_CLK_LPSPI6_GATE		155
-#define IMX93_CLK_LPSPI7_GATE		156
-#define IMX93_CLK_LPSPI8_GATE		157
-#define IMX93_CLK_I3C1_GATE		158
-#define IMX93_CLK_I3C2_GATE		159
-#define IMX93_CLK_USDHC1_GATE		160
-#define IMX93_CLK_USDHC2_GATE		161
-#define IMX93_CLK_USDHC3_GATE		162
-#define IMX93_CLK_SAI1_GATE		163
-#define IMX93_CLK_SAI2_GATE		164
-#define IMX93_CLK_SAI3_GATE		165
-#define IMX93_CLK_MIPI_CSI_GATE		166
-#define IMX93_CLK_MIPI_DSI_GATE		167
-#define IMX93_CLK_LVDS_GATE		168
-#define IMX93_CLK_LCDIF_GATE		169
-#define IMX93_CLK_PXP_GATE		170
-#define IMX93_CLK_ISI_GATE		171
-#define IMX93_CLK_NIC_MEDIA_GATE	172
-#define IMX93_CLK_USB_CONTROLLER_GATE	173
-#define IMX93_CLK_USB_TEST_60M_GATE	174
-#define IMX93_CLK_HSIO_TROUT_24M_GATE	175
-#define IMX93_CLK_PDM_GATE		176
-#define IMX93_CLK_MQS1_GATE		177
-#define IMX93_CLK_MQS2_GATE		178
-#define IMX93_CLK_AUD_XCVR_GATE		179
-#define IMX93_CLK_SPDIF_GATE		180
-#define IMX93_CLK_HSIO_32K_GATE		181
-#define IMX93_CLK_ENET1_GATE		182
-#define IMX93_CLK_ENET_QOS_GATE		183
-#define IMX93_CLK_SYS_CNT_GATE		184
-#define IMX93_CLK_TSTMR1_GATE		185
-#define IMX93_CLK_TSTMR2_GATE		186
-#define IMX93_CLK_TMC_GATE		187
-#define IMX93_CLK_PMRO_GATE		188
-#define IMX93_CLK_32K			189
-#define IMX93_CLK_SAI1_IPG		190
-#define IMX93_CLK_SAI2_IPG		191
-#define IMX93_CLK_SAI3_IPG		192
-#define IMX93_CLK_MU1_A_GATE		193
-#define IMX93_CLK_MU1_B_GATE		194
-#define IMX93_CLK_MU2_A_GATE		195
-#define IMX93_CLK_MU2_B_GATE		196
-#define IMX93_CLK_NIC_AXI		197
-#define IMX93_CLK_ARM_PLL		198
-#define IMX93_CLK_A55_SEL		199
-#define IMX93_CLK_A55_CORE		200
-#define IMX93_CLK_END			201
-
-#endif
diff --git a/include/dt-bindings/power/fsl,imx93-power.h b/include/dt-bindings/power/fsl,imx93-power.h
deleted file mode 100644
index 17f9f015bf7..00000000000
--- a/include/dt-bindings/power/fsl,imx93-power.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
-/*
- *  Copyright 2022 NXP
- */
-
-#ifndef __DT_BINDINGS_IMX93_POWER_H__
-#define __DT_BINDINGS_IMX93_POWER_H__
-
-#define IMX93_MEDIABLK_PD_MIPI_DSI		0
-#define IMX93_MEDIABLK_PD_MIPI_CSI		1
-#define IMX93_MEDIABLK_PD_PXP			2
-#define IMX93_MEDIABLK_PD_LCDIF			3
-#define IMX93_MEDIABLK_PD_ISI			4
-
-#endif

-- 
2.35.3

