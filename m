Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E342EC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 10:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FDD8804F;
	Tue, 26 Mar 2024 11:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YhzHz5Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274C883348; Tue, 26 Mar 2024 04:30:34 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A6487F69
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 04:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSx1DYqEGDHSfmu5xPslICJQNHa9LwJFeUX+a5e38DeccYKV3+vlbhxP4H9ddTgSteU5uUvoldpr+lT2uFGfvbyJ2tqTq8XfVTd8AV7gLXEl5JwGaBXvN5ashgDdUC4Tl0C14tyhWdtZx2DzkT9XlYuTqKjoP3MEbjjcwYxEnP9K3FQN743er8eUBYqOwaitXn1ftQbe+47ZWhB0FOfw4M+035iDGv26wWgCM/jDMQ0sg3T8tIfeW6EBAu+adHvWnnVMIo2gv4i50KM3ZG0adgJJXidHT3Ql+6RcffHBRt+cvLOVjSr38LFaJp6kk3IgSOvAWIslO0JfFRUqFuCNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gzdub+SX54sL1ogXwNsfQ28oiEjuKNEBr8P6z0UhSw=;
 b=ec3uKBgDTfpLpTp4vJ1XZDKvYkM4r2XN9mBuvhJukSJBEXXMHiND2QgxIj8SGObA+blZVBVkYaQvqLfF+PhBZTw8mJaJY6j2HPJNnX9ffFM3zEjneYoWAZgxq07ljX+AvvW2kf+oIxtVvToX88rK0Xa0km/7XvvBDcSxRYd8Ia/17bmx9Dj23fFOACljB+JMf1uplNP/oRmFTtNqThW0or9QFlHDonM4UEeaZxxfu7Y2N3NnXWy3jgtQghevDsgdXmMxn/Ay68yh3hEstVxSB6O+3LWEX2incZUXV+lydgkRGhj5MgEunKBEZbuHlOPzOnjyV3Lm6pLjPtw77Zsr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gzdub+SX54sL1ogXwNsfQ28oiEjuKNEBr8P6z0UhSw=;
 b=YhzHz5VwAlZg4zZB/oD+1fpR3GD/OFkCNneKET8AeJRug+Hny2xreDpP8WgfAuMZz5zF5q/a2/d1UOKK8T603Wka8qsePKU0h9S8GiAiFa0WT7X///2nHsqJvVF6l/87sGcKXAbKBLFkD9avT7JfksJ13fKhEWyGpqBcP9v1itM=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 03:30:30 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:30:30 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 2/3] imx: imx93_evk: add rtc pcf2131
Date: Tue, 26 Mar 2024 11:38:00 +0800
Message-Id: <20240326033801.228419-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240326033801.228419-1-joy.zou@nxp.com>
References: <20240326033801.228419-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB7863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmA8lKrG/Su7gQCqTScOr+mpAtVSgI9LdN/LZhnIcq15XPw91CvbjjWPqPF9MdgGfTIChme9SpNZsnY4Ocs6/QUPxzf1B/xkO1aL2m96Au7LbODUbxxH9lEFbVf6SF2rqSX9LlZHkyohZG/B9eFikTOtBcbCAIOE7HVlg8IOQHup/GZ3hf8V2oVy12ZStW1IQEoozZvPCvXPId6mJ7rKReZVWON89cGQNfgQPfgeDmooLQvzsZqwvhGtbKLQMTGxx9jFLugMyPCKBDU2D0jmSOgwBY73jvUaSJ+SO0Rjk37U81kzn5vb+rnvKvij+LTDkEGGjQIUl1RWAdozxaXAsF133w+zHW5q/y4gtiFu4PEKl+IS9pu1efRFl6RBw70Lj4KuH2G5fTeBKAs6mwTNaBBCbG+csdgUx10CGwMVuOItu+vv6Wh6gVXXCqdRHAOWuwgRLM3o0mpaivqTLZI09gcv+G8sb4yyyTqhMGzgBXy9AVOqik5d4/iA7GywsPZSLZ+ybIGVwPxhKMIf2Xjj+75340W/QYiJQEoir9nDwMGhfswiPKKD184h799iUfgbXy7Cg+emzc6yyqjHBavSXVnhzwjdlh3On09SKHk5iQKfRprg84Mfo6Ducxf1CUSH+LoPRJgE8LxehKZqIKk4XGrsozjigpCB43pEmegB0hT8NY1vqNSW2XY74MK9KGFDrWHWyhal9LwmY2fqs5WA5MzFyDY1BCNvqadS8G7jSOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/Uxia3bdFuMAE4T97MIQATZopIuBpVs8/vGy+ECqBWZato6/8YZZUc3WlcY?=
 =?us-ascii?Q?MgSruYWyh6Xt8qIRVgkZE9OFQaaBbtvCx2lMYI5pKPqVn8zwZLYrnxFAACUR?=
 =?us-ascii?Q?JTOH0h9+aNmVhVDv7kTwbbZnzs/AIuaHe47QRHf7974qDDY+/NBfRgqRKEyX?=
 =?us-ascii?Q?y1LABWdduwqJ7nnV9aCUenqcBRSvcgl+uk61HzbbJAD2d3DdXjF3Gca+8UP+?=
 =?us-ascii?Q?QMjkPJK3q/4wovzbqmCZz8J2ZPv2IrEbESN3Bxhtgn4x3co9iNDiLy1IdTzr?=
 =?us-ascii?Q?zK8YSRv8FMH6uWykLHWLrV+G9gWpwQrgIAUFMaisfVIG+QxSJxzXb2PzGAkq?=
 =?us-ascii?Q?xmbFNSIDragr1Bc0IL7Odbud4ZkA785HVVC5RWB1vMjLGKwc64n5KscpQjLM?=
 =?us-ascii?Q?tYxSajhRR60jH1xctrLiHuuLF+N0Jf8QOqCS7L92KwQr6jHtSakLLZ1/kg7i?=
 =?us-ascii?Q?NJa3LVxItYxM0jEidnJT3n2t2xNpMUHaIyOvhOwhn1eLvrnh3FWMClXjRINr?=
 =?us-ascii?Q?GHAylFgwAGmhCJKEgRDhCFCK7cwYsOSadieSXxR5NJKWfzj2k+/Mr9ajGZ/G?=
 =?us-ascii?Q?URkgjxlq/CfwUOSc499GAojzLQoNdujg+RAgz2y61takKx+7RHz8P6g8aU4F?=
 =?us-ascii?Q?vZD1e1ZzvYrStcUTOzmZqOkYxfcliN1H/j6rgTLQ8vp3Hdwr0RkGBU5ru/zm?=
 =?us-ascii?Q?QHX3wNW9uvqRy8rpOVB3u4BKbIDvLXPK7YqnPy16jUiXzF6CEiCVwdrU4vXI?=
 =?us-ascii?Q?+T1R39qAdAUaY1lmz3ugcw7JYJ1YPiCKwdC9PKO7L7bifDZLf8qFHmsfrkha?=
 =?us-ascii?Q?o9w9L1clXbO7l+47Dv2dKq7tDKuxnV2MNHOHkEwObn5VhWVyABipKebW66Sm?=
 =?us-ascii?Q?qvuCIUwMkA1OUYqXVswLSGF24/fl89GR5RvDtKw+hNvotm5JR1APtCQcuV53?=
 =?us-ascii?Q?jrzJ/TMH7BxB1//N/b1HnLn0K80ETDUIKKQy4uH2nE8SAM2j9lNQ/2dvPKez?=
 =?us-ascii?Q?VDdlTh0JBNpf55ekK366as+eZgfVcdMc16p9Ff5yeKuEiRXAK1pLax9mTHzi?=
 =?us-ascii?Q?repYuD0aDo/ZCvSbqaJ8ugE8zEayOmnJUG78+rFOo0WNkX/RzsiWxa2NCA38?=
 =?us-ascii?Q?R59fB/6uA7etTIiydRMLWbdy4UxrtyGr0fpLhPqeJZSod2BUdnwns1mDLyAt?=
 =?us-ascii?Q?frcvU/gXH3Mr4D6LKOwq2ttph2SIqeqzm0MA3Tev3RboZ0k+7Pwa5cyQTKEz?=
 =?us-ascii?Q?LWd464jhQTjGRhfBE874mOoiy53zcF0AKASPraGW61iu1Skn7NS2P7VqyF0S?=
 =?us-ascii?Q?uwxQfW0g1CarvMBaxrnbGAU2ys38V0hL9umyqvV2qMw+YyhZe22Et3zcl4/r?=
 =?us-ascii?Q?6N+iMPxqCL24+bh94TdKRGVQAmDEXoPlXcUytRif1KULLXfv1jYjHmp5oWrl?=
 =?us-ascii?Q?CL9ruL31wUQwd339CCN+Ji1GYUtd7z2LnDCF+50Xqy+AYpHrd5nPnunc2crX?=
 =?us-ascii?Q?OaUAGJ5u+F7ovEBSTMTUUyO0TEGuHv73xGy50fJgPiJxGT/wcMnS8tqpvC3M?=
 =?us-ascii?Q?N22oADHYlIwXjwmNB+CkxRfpM6zyQ4VkQmc4GMVJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71be5d5-3b6c-4659-f419-08dc4d451673
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:30:30.5968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfbmXO7+vkCY4XGm8ndwMlGerKqlhJit67lFRqmKDmBeC7YYlKs9fdi5tTj0ttti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863
X-Mailman-Approved-At: Tue, 26 Mar 2024 11:21:12 +0100
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

support rtc pcf2131 for imx93.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1. remove arch/arm/dts/imx93.dtsi modification because this change have existed.

Changes in v2:
1. use the flag bootph-pre-ram instead of uboot,dm-spl.
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi |  8 ++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 25 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a99ba99bfb..2dbe33f073 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -112,6 +112,10 @@
 	bootph-some-ram;
 };
 
+&lpi2c3 {
+	bootph-pre-ram;
+};
+
 &{/soc@0/bus@44000000/i2c@44350000/pmic@25} {
 	bootph-pre-ram;
 	bootph-some-ram;
@@ -127,6 +131,10 @@
 	bootph-some-ram;
 };
 
+&pinctrl_lpi2c3 {
+	bootph-pre-ram;
+};
+
 &fec {
 	phy-reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <15>;
diff --git a/arch/arm/dts/imx93-11x11-evk.dts b/arch/arm/dts/imx93-11x11-evk.dts
index 4322cc3e11..8b57de3b4c 100644
--- a/arch/arm/dts/imx93-11x11-evk.dts
+++ b/arch/arm/dts/imx93-11x11-evk.dts
@@ -192,6 +192,24 @@
 	};
 };
 
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+	};
+};
+
 &lpuart1 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -254,6 +272,13 @@
 		>;
 	};
 
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA                  0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL                  0x40000b9e
+			>;
+	};
+
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
-- 
2.37.1

