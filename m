Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813CDC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB40C8811D;
	Thu, 28 Mar 2024 00:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QIfe18cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 561E68812C; Thu, 28 Mar 2024 00:47:34 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41CD8811C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3Mg2KScvCxEKQ8U4LuWJV1LMDa6sMjn1XXqgccrx5mRKi+oHdsh1nY7CAcEY6RN5N5fXBqOt68mL121GwhF8yOFUk2LS0qxy5uVfKpWRxQ4xENhEpd1mtw8LWBIuAONDhgm3aiE5GDOOQoy0nEzb0M0pCBBtjPcSuqyhNrEEKec60JLk2huBwphklq2yJRbhxwo0syUY8EDEYApXt3YFplHyFsJltGt73R6C9fm2HxHgsw4R5G0jnXFMR51VHR6mrcYdTVs0XbOAkkeGNorM2a26LLht0RcrWeHDa2O4l/qOXesQ8/M6ZJ/ilRZEL9LU1xToMW329yAmFEV2Q09/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDBYFeelG2pxJFQyVkxYDijXU4QusAKDKkS2RdcIdls=;
 b=Sx28Tq7zNTYE5TFcRpA+6gfmUzf8x8s2rrQqkIvMSIadMgYGCQs9LNCyGlefEsyg+31pC7O4WadP5vpWEer4NhASbzQHjUA0VhbN8YSzy06/ZGGrv3FejwKyTtOXk5eyMmKcQ8R9/L4YdUyNgS4g7yM5k1lyVm4WPbbDdRWkQFhSCJjdnQnRAqhjJfId1Lm3L0QiS1uYk8okxmqPrLFbXaBgtXo9HihiOySByhAX+t/6qQ63EhcrErlLPC3Zf8fb9qTOz3fAU760vHi9dSvJCs3I4TFueeEKDhu2CMlCI+zls3ThVTitWkmw/nsksfN9FierhjBD78nyuVkaT8gf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDBYFeelG2pxJFQyVkxYDijXU4QusAKDKkS2RdcIdls=;
 b=QIfe18cEIzhDMeP2wBAHX5FghW50sc9Ydzn3G4GYFHK4euLRFpGyG5kQwwO9gHpXQf+xjrnhyXDfVqEtvc4VM77tMgrIt65VyGdSfZc5+i645eUSMvjT5raTgjrwVrS9xHQ8IaYmzcoRHUm8JMbbNFp8EcpR1lNM3vfoHguM1ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:46:52 +0800
Subject: [PATCH v2 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-6-909f5d37da87@nxp.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb4b3ac-6b02-4b0f-a90b-08dc4eb843e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I72P9HgmW523uZuRovBsMK8ReXmeP/BY+fJWmFeyyvJNbOHq+44DLEHMfnKC3xI7zmQaX+x0tMAJ2jdsz2FdBSL9tgRjqXS/er03qrajLmCIeRhUiImhdSTlqtZnkVXh/x61EjzoGs6PzvdYE9yHNKKe3Ace9ILvJwpW7cnh3EyAjrkmeS8vXUhkCc4A/nJP3QKZdnjIiIb0qQZKrvg11IEPPfH9YgA4v6kXWl8mX35JJrpyrSARRhwJkB3SyEydvVtbKoy4Gsoy/705gZjIaYkFNm/HVD1csnwtnYQQhwH7sFCAc8CW3+QhCKOjhB9Uff5pAZhmVSia9MWtYi/agcNDYbxn337CGHI6zt4iEonFhW8wz3yAyS5bLZId1L+cYrvjXBqvAGSvVGoCgyTq90JhZIcrtZlthihLTpHLUwb3t9cG74r5zhK8JIQPKldv5olA1HmQd0LNFY33XOyvdWxaNf+NtbnCvRscry2AU7Y/11OOijpD6E855D1AgcY2Xw4vRLeKh2T3nE00Ft09ezkVn223ARsiRf+CPJFbwUhD1nkiEJU8JOHmGvStVa2e0kgApIjUKDa0gN7s2B3WSFG80WWh4cOZtlqxJxE5SONxCKLvi0xjMEHURoktXyCPiZVClpzTB9E5irlDztXpbEoG5YSrR7RGmC8Ka8EOnb+etsjrcqVf77KOZTIfvwhBCW0q07IH+yDAMY1Jp+VceHUMCqiPo40Kn2Q8w2KpKDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXFzMlJsVnQ4ZmVzMUU1bjU3dldvYzg5aC9maWRnOUtnejAwVFJia2VrMzE2?=
 =?utf-8?B?M1gxUlpmRnIreDJPUkNhUy9PYjlvSWJtTlZFN1I4QlFKeXJTb0xxWUEzMU9K?=
 =?utf-8?B?aVpYaFFQbEhBeW84K3I5ZHg0UTBPWElkajkzdFNqOWZSNSt6ZXV0SEJvano1?=
 =?utf-8?B?WXFOUW1wZ1ZaMUlQU2R0RGE2UUYwSmRxVlZOWkdrbUo5RzJ1UFZaTStnZUFk?=
 =?utf-8?B?SjVjUVBPdGNTYmJrdFVGUzVTTnhhT0hDaFgrK3VPdVh0NFFiTjlqcnhCK3pS?=
 =?utf-8?B?K2crVUtNNzRUZS94YVRLVDVvc2Jld1BYc1pWMi94SzVIVW1RT1RtNXVGQUdx?=
 =?utf-8?B?Y3JwWGt4NDhOa3h0ekxJTlgrUU5lQjFXLzFnWnBza0hVdmV1UHJDZHVxdFJM?=
 =?utf-8?B?WUtkSWc5TG9uTldDWUsrQVJjSlNFWG5SSVloM28wYm5EZzMrUHRsdFJZUXZJ?=
 =?utf-8?B?cWovTnNyTkt0RE9Vb3ZSUkRJc093U2pFcElsOXpQMW12V2VVc2hNQ2VJRTJG?=
 =?utf-8?B?QWQ2UzdIeHpic0VjNTdsM3hvTTZ2aVBlWHMrTjAwdWNyai9zZk1xV1JkN3dv?=
 =?utf-8?B?N2xGblV4MlVmK0tIVXVwV2hGR0dReklEc2dKZjlRYmNaODVxSVVORjhoV2da?=
 =?utf-8?B?S2ZOQ3FVZ2JQTmV5eEgrbG53WEIwOHQrczN1VWlvdDZoSjN0S1NWdHA1c0JI?=
 =?utf-8?B?bmZqTi9Ubm9ML2FqRzhBWHV1a21aU2Y1VktncGhWL2RNWE9odklDSU9oM3Qw?=
 =?utf-8?B?Vll0M2ttQkg2VXZxcjBwUnF3VE55Y2JBUE5iZUU1YVQ0czFPNGV3V1pQS1Bv?=
 =?utf-8?B?ZDRpYTR3RlR6ZFZRclRUUkdmZ0VjalAzQzUzWUVJb0QvakdHaDgrZUhMSGtB?=
 =?utf-8?B?bkw4aDBBOXhBeHVUQlNMUGNFTnlKV0JyWjJDcjNYTjhVdTdWNEZJMTJ1cVVp?=
 =?utf-8?B?Vjd6eFJMc0MySDhjTkNsZjcxN3FiNXBJb2RkVk5rMkN0ZkRqK1hHeGs4L1dB?=
 =?utf-8?B?VmhMU1RSRUdSMERBK0pzNEtYdlc2NzdIS01ySU9sN2VSOFlUeWpFY25CNDJj?=
 =?utf-8?B?M2hQYWdTb2xGSzVkUEUvaWUyMjk1WDFJbFZJaHdFTzhhQldCdkczemdCM1py?=
 =?utf-8?B?RkRwb2g5bjVDSkdhMmRLd0YxQjhJM254MlU1dFNTZnJiTlB4alR5cmNkNUZW?=
 =?utf-8?B?RlRXME1mb3ptSWJqd3hzaUlGbEwxamd2TXV1OGpXa3BwdDI3SWJTeDJWaG9o?=
 =?utf-8?B?MUxhSmtSVUs0YmlRTXJNUkxhK0dnRWk1UExDU1NqNTRsRVBIN0JXQURPcXNZ?=
 =?utf-8?B?Rm1uYnN3OHg1dEpmQWhiazBpYjgwZ1hnRys1R05uTG5Rc0NmU3d4M1NWWi9a?=
 =?utf-8?B?Z0NOVGpKbTJFZC94bzNXVUxONWlVZ3NSczUvV29YMWp4dTRSV09wbFNqS1c4?=
 =?utf-8?B?K0FyeDRYQkg3WVVHSTRiZFdiWmFKS2EzM0dlUXhSOTRiRFFUdGltbTdoM3dQ?=
 =?utf-8?B?Y1ZsR3dNOWRUbGI2L0NNay9RMUZJVWFEamIxZ00yQUxEQWx4Z2JtNTV2U0Nq?=
 =?utf-8?B?RkJvZXVGQ3dzOXJzQTZYYSt2WUtsYWdUdHlGcEUyb3VreGlhR01zVFUvNEVZ?=
 =?utf-8?B?cklXd0pDSVNqL1RROEh5MU1xNUJOa2pKaDdMR1VNcTRXcjNsSlJRNzJvYzBD?=
 =?utf-8?B?OEt3VXZTRDBSa2ZFdW9Ybzl3WUcwSGc0dThwN2o4M214eXdZU2t0cWJMZ0VQ?=
 =?utf-8?B?enBORVFjRURLZEZ6NmRGOGMxMmF6NUE0dXRQb0lBVjhtY09OdlVCZTVTVnFk?=
 =?utf-8?B?MVNMeTJkVXV4Vm1GQStYSHh6ckVHVDFnREdsdFFhNGdhcmMwTUk4TTZlUHVy?=
 =?utf-8?B?aDlZNlRPWkxXK1huY213NjdaOWhlWXp2eElTUEQ4ZzM3UXBaQ040R29SL1B3?=
 =?utf-8?B?RUtjVldkSmhqcVFLdWcya1pUV1ladmErMTdSSlZjZ21xSWVHYWx6ajNXYUZL?=
 =?utf-8?B?NDJiR0c2azk5OGtBdUtXYndHdGhCT2ZBcmp4cFNUaFUwWXJ5VUpHcmxpdFdF?=
 =?utf-8?B?UXNiZlRoUDIrR0JQL05RSk13THI0VDVDaUpuK1pVT2lCeHJoOUdQZjhUUGF4?=
 =?utf-8?Q?/0I71ABI0LR21Wxvbxr+7xvdb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4b3ac-6b02-4b0f-a90b-08dc4eb843e0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:30.2102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmXqJgFCB7KWfR9xRQBO4PdgEpBanAX9zqR12uy7/LQ7rdryoFdjynVYs2mYKn+qYuwvxedKHGZ6ll18x2MARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

