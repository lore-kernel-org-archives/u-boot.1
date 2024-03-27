Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6280C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD4B880A7;
	Wed, 27 Mar 2024 14:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zb2k5DPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F6C8800C; Wed, 27 Mar 2024 14:11:33 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6F1880E8
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRiqWDEy4XIbi5wqqPcl6djB5rxn0wU6foNxyZeoOw717evfMI0iTu88TkPCSEXs+99tnXwXy0wHSHhp0JWjDeAO8eZGrH6I8pfik2sX2iNoIRdlsGvX4A6W/bY+UOhBYl07CG1jXZEjgj6ZdrQot2f7MuQ+5yWpBlAtiWLjXaT0WzG4FIAAdb5d6ToHxfnpyf+2dz/zaj5WyJ2143mZ9veVkUXcpkCEAiMDHVfQQ6s9Lpknst8B3aa8B8pAgg3FCTHoUVPvB7rFQEryXFW125RyOo+Db6UN8tXP0ULqHnyLzXItV0KYXnqs054wYR45wSYsd0GqlMi2nUQWcftTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDBYFeelG2pxJFQyVkxYDijXU4QusAKDKkS2RdcIdls=;
 b=BT4q+WlFuQX5yw+M1IRq7vtf7JOqqRHDgtacz04uoPiAvTgk62wEAQSvyaQqhQhqbt0RG0f9tUGcaFBZjj1+UWGPJsg86CWHLLWfoRBEw4kWzeaiWgTaP0Gf2pBSVmTQTBAuVVhb9zZPTKBaXwVEXr/aEoFGx4DDKfTDqTYK0SkmlucH1wkpcwrzjdnBj6aSA+bzF9g4zcJ6Db7OCCg8rKnq/UYW6XfWY/H1FcnJPMrpyFiB6H5/vGmqDj6ZHfVuD+NT8o4iZAOKvuI7SnZlrRui/cKl3uUeTnImr1zby0JXKFa5AoRWMrs5IzpPSyQ0ptQxNI84rmi6rd73l1b1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDBYFeelG2pxJFQyVkxYDijXU4QusAKDKkS2RdcIdls=;
 b=Zb2k5DPsXjyy1aZPgWdf1lsALRWg8dSvRX1L6VmTWZuApJ02fJ9gejqA7zwfmTSZ2Cv6QtBAdq2jvOgPiW3/zjgOwakxOjlm1aeg1F/XLB1BxmvIbOnWn8iLWSVQ77PW/iEdA/j16v91WN7ZEulKmowqx72x8Hg7F5pnlcIoL/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7199.eurprd04.prod.outlook.com (2603:10a6:800:11d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 Mar 2024 22:10:50 +0800
Subject: [PATCH 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-imx93-of-v1-6-afab6b31422a@nxp.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3f7038-a3f6-4212-0b5c-08dc4e5f68a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxg3qJoshC1nNfWMThErp3zL8T9fcf2JD851Zyw5ADMLBGzMf+Oy+8RNvvxqqnSOnsUmtwS5OdkwzHqMRFyzrZb/YYcSB5f7twbYqmNUS0Z7+o1BZFh723A+BdcM1bhMoINlrQuYcpGyiovTJ+hJc3WkUNXIc4CJzgsMTcwgecuNyZLTfc4QYZME27U9BwjS6jlNQhgvmlsb5EVN8kQ5G551OPdeoIwLuyDg7192UbWMZmIDY6S46ZMWP3HN1yOFXevlxYH/U579x17B3kyDBvC0kl1zqqqnLdGoi7DPSQns2GO40Gh5N5F8pYfukHTo0YDBPmIrFbzzp9g1Lbya6AvOix6xC21yMgzXoqfuL9jaEdAbTYAEPlYa69TouSYldejPSGqPLEPkZsy/IU27SUaC3/14rZOwib+4BzVlqL5iUEUculn57t8PaocSmWL1olbYwaZX/HrFTEapmoMHJW5KC14fiXgT4a4fHhQJzJf5tCnhx0IsLpIkRnw/R/wQvzdtgFya4fJ4j+Eo9NBIaNXummtOM7qfawBVIoi1wDbwSOmH0r93PUR/7hcbhxMMHEog4cfL8HRO+l+iqjXcLBbwFI7AWQO/PzPx9u1VF6y59zglak6nG0WOkpboXhJtnRpaQdeu+RrW+uDa/a5dPQBAahE4IpLWydzto1QpryEnQ6AQ4CZx4W/OgH2rVp/vTnCSIpvIjI1m9leQ6VMUJVKJtKMmKhUnNBJJ0OxhMB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVowdXhrYktUSFhDV01yb3hJOStIZUdVUWpkYVdmYzhqclo4TEpDeEpDako1?=
 =?utf-8?B?TGcxS1l0RU56Z0lueWNDdGhrQ2phY1JCZlp5ZDJFaFlCZGs1clZyOUkxZEJG?=
 =?utf-8?B?QlNaZy9TYjhETGp0bHRyMU9UdC9nYnRyMnNvTTBqM0szTkljUC9KS3h6SFNa?=
 =?utf-8?B?QjRVcHVrVit2aFluUGl0YXpxeXIrR1lvR3hleDkydXo4ZkdOTDY2WnBJcGUv?=
 =?utf-8?B?dEREa1JYRUFVbmcrTnYxWU1kM3I5UXRMRVorWjhscTQxWjJNUFEzUzNDWWVl?=
 =?utf-8?B?YTdqUzZxVHlCOVhJK1UrWStWMEtFT2huejN2ZG9VakVROUZkd1p3THB6NmZq?=
 =?utf-8?B?MFJKRzRHNDdCV0xvQTcxOWdCcDZGMjhXS3RxdHNJeXJBaVo1Z2cwd05JbVhX?=
 =?utf-8?B?Q0RuUmd2UXYva1JYT1h3REdBTFRnR3FQNW55SlBQaU9CMXlkMmFTZUhDOUdj?=
 =?utf-8?B?VTFNTHlJWWJTWDRRcTRna2w2NlhSREVubGsybnR3M2tTaG55bXJNS2J1QWFU?=
 =?utf-8?B?MlVWaDRkbDF2ai80Q09QSlpYODlKT0xiSG9mWTV6YXFBYzB6bXgxMW92bnpC?=
 =?utf-8?B?MVNON2JpaUV0K2E5aHpxWmpJS2I4QTEyblNISy9WN3E3QnRsb0VvQTZvZDNs?=
 =?utf-8?B?djM0OThkcGo3dzZZcHU1ODJuN0NiUCsrR3k3ZDUxdzNyUHRzWURjeUlVRVVN?=
 =?utf-8?B?Zkl4MktSS085emp0Z21Eb3UzamJTZEhML0tWYTUwdlk3WXZtL1lCSXMvSlNP?=
 =?utf-8?B?UGJPd0FTWjFsVXN0eEN4SUErUXFJT2JCTllxSTI0SVBKeEJXWFVtVnhNRzBP?=
 =?utf-8?B?eE8zVGtVMmhCTDVVSS9LVTlNZDUwbzBobUVKNm02V08rekJ2UHJhc2VGRTJp?=
 =?utf-8?B?TlQwNi9IaUNPay9McWlSOWRuUndFVGpjSWJsQk5zOGI2a1R2bjM0NUFVVXB6?=
 =?utf-8?B?ditocVkzeEVsNm5sdjUrekd5NHUydlZtVGREVU1kUmdMZytWZlBQdTV5aDJh?=
 =?utf-8?B?NTRONi9FS3A3MnRucFZrT09VUHpEVU1Vd1FuQXVDc2c3ZHlBYVI3cTFoU1dV?=
 =?utf-8?B?ODJVclE4OFJ4VU5oZXdUNG92OE91K3JXbHRXYXJqYXFma05rRmF0NGFmMVNh?=
 =?utf-8?B?eTFiM1paNTdISlFNSWRqR3hlMkZDcmphaVVXTWdCTDhKK3hJMzhIZmFkeXNS?=
 =?utf-8?B?WERDcHBDR0NUWE9XT3kxTEtRZG1maEdTM240SlpJV3FCeng4bTF6MlplbENI?=
 =?utf-8?B?cGI2QzlXbTRReitVcXc5RUgrd2hxVkpla3paSXNMT3lCSDg4MjNKeUNDL0Zt?=
 =?utf-8?B?ZXphdlhiRlIycjhFcnpvUUwrSEhPaFF1eEdiVjdPME1POC82bnJuS29PQTlS?=
 =?utf-8?B?SzhwNFRHaFZXNjF5MjdFYVNLWUFzMHpYSWJDY3E2ZHg3UlMvSVByUGd2dXhM?=
 =?utf-8?B?SndzRi9PaUt0VFo3cVhwYnd6THY5bmhsbC9YT1ovcU51Q3lkVDYyOEZ3cDY1?=
 =?utf-8?B?T01YdXVLQ0ZNSHFycDkxTmE0eC9JQnNQL3hWM3c0YzJ5MTN1MHIvNGhiMlVp?=
 =?utf-8?B?WENwWFVQM25ZUWxQam9IUmt2ay9qbGc1Um5lRFgza3IwQ3hGSS83QldMVGw4?=
 =?utf-8?B?WWMrbUhSaHFXK2NYajl6amJxSUd2Q1FGbzJIclRpWmoxUmFTYjRVYXIrSUNT?=
 =?utf-8?B?ZjVBS092bDVlVE5UZUl1QkE0SnZ1VVZ3aWZ4OVBMcHMwTW1hRWpTTk1ldTQr?=
 =?utf-8?B?T0xvU3ozTkJZWDhKdFVHSE1ZSXJEKzRjRnRNd1FkR3ZPSDN4cnBETGlScTdC?=
 =?utf-8?B?NFR0V1czdXVKalBGSUttdTVkY1R2b3p1NkFpdjNqTWZBTkVkako3RGdEeFho?=
 =?utf-8?B?N1VnNGdwVzR2eFhwM2cyQ0NnZ1RoaFdma2lmWVJNYkRUY2tCeW9NcVJJTFVu?=
 =?utf-8?B?R0ZwR045S2Fqd250RkgwN1pUeGRaRSttRmpuVEJzNXdpaUk2OCtQT29RZHI0?=
 =?utf-8?B?bWpXczRlS2w2S0RyQjB6Qkdmb05rWE9NMlRraGRQdmtUcURMeUtoVXVBd242?=
 =?utf-8?B?aWtURWNuYU4xdWVjZ2IvY1N4cDBPNFdUZ1huSTNCWUZPQytIelpFRlJCMFhu?=
 =?utf-8?Q?iZBuFfG7UgOfy0veyDt1bwDX3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3f7038-a3f6-4212-0b5c-08dc4e5f68a4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:26.5367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSK4+PFYLmK7sVya44mXc93Wj9U3MAHlvEu/gt5C8r2y2XG4yZ9STn/EjEkaNMBoK6GlNNZ5NL2Q8CoRdOKRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7199
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

Convert to OF_UPSTREAM for i.MX93 11x11 EVK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 +++++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 -------------------------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 ++
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 7 files changed, 136 insertions(+), 325 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d85a33055c9..71c2facfb5e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1115,7 +1115,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-librem5-r4.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-11x11-evk.dtb \
 	imx93-var-som-symphony.dtb \
 	imx93-phyboard-segin.dtb
 
diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a99ba99bfb4..408e601bc90 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,6 +26,111 @@
 	bootph-pre-ram;
 };
 
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
@@ -44,6 +149,19 @@
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
diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index 40e17bbc5ae..289aba17584 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -86,3 +86,18 @@
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
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index b79485f1f75..e892da80fe8 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -31,6 +31,7 @@ choice
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
 	select IMX93
+	imply OF_UPSTREAM
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
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

-- 
2.35.3

