Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBB1CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B878498C;
	Wed, 17 Jun 2026 07:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rUPz3FGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B6E84974; Wed, 17 Jun 2026 07:30:28 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159F78498C
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPTT1nCnz3KVQifOpdXAGLuFuRYRhOCRYQtkG2X+OSbQQjceBQFZ5kmxzRNLQ+Q6kyllO687qUlkfB5/2J9PwgJv792Blu/8u2FCTRMW22fpqKz+jPJJaYx8XWPS6R1SHbAHUsEB25ot1LFI9PjeWMmqr28NvMUGJeHVYne3jlTyr4weTvam5PFwtG5m/n37lXOE0kie2T1BByw0xgrvIKuJA15SOgBX/S6b0Bu8VE0yGM7xJtt+46aALf5LhSiUdxeH282+vsQsvWGx5f0biqDkMJNaw2PgujtiSVyAL6PHMRxRY/OaDy20Tlznrf+ppPT/iEyO8BZJDgBhNH4N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=ndO43iT/OOqcT/2n7v6tsh7YS7uLJvxbLJr3H/lYSkp4TsuhPzGeI22RZrxLtpoMocxvU4MtN5098SLfF4xJSbd/Ls1BXWibqpGn2ai/WFYLSkpYItYk0eYH4AzKcxUoAED3rsdWKdpYAxC4WSEYqkP7fvO8SOiD7SXWnpU8phVSk4e0UeSfTRib3u6R96UDADwUbG0+9LySK5sdz3zB2HcC/0YctLxGlHGhr2vxW2TBqRNODmLUkBwLPBTjYo044FzLpin2+NR8SdB0XSBERvEoKTLIcLwJbM2JuuOvmaTYDK2U7PPO20dlwb8qHL8V/WiF6cTH0XSfhtSzh/vT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=rUPz3FGyGGMCsTaxvDWYdwiN8RGv7OQiQrnfAh3ust1X/rvVzqQBgmdjtp9Mn5X2rPhRQSPIT6kXWzOplbTX3RFd9tmNocpnyg4V2EC3qqZ7H8HE3l64rihe/CtnyGxFYyzf9CRoede5TVlp80sYZ9Imdnutin48O9s7ujLAecbnbjuNK9iWRUxTwC2AMAyJzdDMM41YEDe/hzgzGrZmhDQfq/m/Au3cp0xm58AXUx1UhrYrPCiLOskK+jvHa+zt4yDW32VnfWxyLnTXLpRk0dnPnnTu8mmbZr3Pc0TgdCoiCO2W/wlbMLlePbLbgYp7pRNxO9sNZBDUYKbD3kymnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB10692.eurprd08.prod.outlook.com (2603:10a6:150:160::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:30:23 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:30:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Wed, 17 Jun 2026 08:29:48 +0300
Message-ID: <20260617052948.2815870-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB10692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8758977a-04ab-4ca8-eaa2-08decc3187ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|52116014|1800799024|11063799006|56012099006|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: oxQoX5xNo657w3zF7nMu8lwLRSQdd9aZcWr5Krv8U1REUcU3nbMcVj+GjuNk2OXeU8e2q6TmQI4SkK9oXthxTrSlPqtK4vGUCxx1a9DEjcvR0ycPjQzLkr9uZ8lOBOSR4G4fYjVrX6rOQf0tdnoiVvOuZYELOkeF/dZWYV663bmTljzTpHe8ri5ivrZoVqYawPkRxtRK4VT4vL8HCTdK7JLMWT8QJVCHT4ShHehwKg7INrNSGKhkos+rFnunYJBtECJyiM1kmt8UU6jbZZwHiRqGnsJaijD6eebZcfvN6P8nfn4BLCKmPTwD3F8RjVoPePWWPf5wrDCV/i+8VFeT3CnEVAStRRQC9knjtO4sqwWSpKmUQktbX5fYMrfPlHHiTrI5yRMQK+ZCCl+SGayLXRlMVXAkeIWfOmCB834YWEyssSDi3e7BOeJDGtxIw/LmGul6KWzd2+tMUjq7KJpaQmo5K5SIpZsnefgJys10/HksP4iA2+eyKRL/Kd/1J4KGIL4exWL//Gacj2FOHSCYbO92dvAvpoaqLoI7VtmXJd+VuYEMbDMzoISTyH7Rg2Gx/aGhbshxkzR3BkIcv1bFWF4wMOgH7Zn5G02lRdDO7ziFNqRwj5sHBhWH2M4NIpfqb8snuMl3nUpi+Hb+/TPxXc8sI4Km8u0NKYbyIkN+wiy7q+fDmZ/bULTs7zrBRl9oWRLkdOJXCyVlln5OFdtZX09rN+7EnCiUZlEhl07eNBwWMdewHpwEBkUzzBZxCnqM7DcfQBeuuv1O7KGo+Nws0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(52116014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lczRXq9/hmwSn1cIr3jpjVJEkUXlUgZ/Yffv+Qrz1q6YYIfL10m3iS1OfMzI?=
 =?us-ascii?Q?7H28VGpbbrnpQdHFrxWKezW/hWPjZjSPUV4C2IL9kIlKU0TeMhf7LSkwP0GB?=
 =?us-ascii?Q?yrk6qhwv2hiAEX5SWLjFkiuDaRdY8SRI8x7j7RVOZL0V4Pra/ozxEaWJfX7M?=
 =?us-ascii?Q?432J633JoF7SoivRP5eHI+zQteXtRK0cwmEth3IiUpw7tpdhVRSyaqMSG2F1?=
 =?us-ascii?Q?H6gpfUTnV4XGIHYaY3gqJa0UAsvF96cWFf9HGz1xSyGLYNUPzW0cgASobIwM?=
 =?us-ascii?Q?48Z1MBloql4aDiHUDU/xM4YdPj2tQ1WBtAUX0YUP2Af3pH+fdaDwpOlUfbij?=
 =?us-ascii?Q?Jfr36II8t0fJO12BXiOj90TQU9bLOAlWzLaS0hx1ZiSX6UuIxXhh2/tEoLx+?=
 =?us-ascii?Q?pzhbJpZsL5YTvGkJgwVuFoWEF3mWnrbdOpOYALidl4901QTuzrcqKi4817jc?=
 =?us-ascii?Q?KTlb8Zu3qTO0QC8iUCg7FLTYWSbV12QbOzHecotEBbFb8O0HyeH6+EkvNWzS?=
 =?us-ascii?Q?7CiJ8o10qgqjSJR7CNmYQCnCW6Ndk2w61oum78EkhW/vQPwB0yZatNvN6ybu?=
 =?us-ascii?Q?7jqIxmVzrurXe8qzgGCdEcW39Q0HWty2FLpd+TD0kCmFgf53X7pOUaDeEDb0?=
 =?us-ascii?Q?Kec3vK94E/AO+StTC2IG0bQeDv6kGmd3MyIDBMO/eDiX9YjCm7JDqmXmparY?=
 =?us-ascii?Q?tymQJHecY73qRcwpiczUG9jE0rXLxGGvbVmtOvmRbZ3LDcnd5CUPxtT7FXBH?=
 =?us-ascii?Q?LrzoLK0Wz8nqZw349thL+qI2CdhOfMKhVeRliwTqW5NtvV2tP280xtYa3ysf?=
 =?us-ascii?Q?ycP9Fnmbup1l2Un6Qq3W9UPXw8pk5RQT5d01GGl2DP2EzpuplPLbLfe3C5i3?=
 =?us-ascii?Q?jODDNI/rrG8ZZ8XG8EmfinV0C71tP+gmyQXzw853Bo5X32dBnG2O/3rFO6UX?=
 =?us-ascii?Q?G3lLAVZGv+uIo2jPSGf8NOx22tCiJmiu0hWbwviBvuR+FS1JQ/HSks9OpUxa?=
 =?us-ascii?Q?F2xBUQlQA4i/gnr4ljwfqbppW0E5ecB4j+oNVn7JAnloFC19FxNknQtfMmRZ?=
 =?us-ascii?Q?I673o09H3ClC7YyPT7DcPkZVTQFzMkDbycw74tCmEuOD6cv0vtvhBTqh2Av/?=
 =?us-ascii?Q?nPfv3ICAeV4a4tA4nxIQYbQYeSiTian/vPcAvlHM88biqS9yXx2hfILNUtY2?=
 =?us-ascii?Q?W4W14PaVT/3W4c2bRE2fBLViuPl5xQjnhOPhAvZ/BecprLmd8d9v0J9X8MCV?=
 =?us-ascii?Q?tzitYO0bz50JhNjl2bZ0pxafP1fFmt6ol1HxVY55bTA0xe6ITyeYGVW5vzse?=
 =?us-ascii?Q?u1Mei717KQ7Wb/a5bukn0f7teRg9512DbuvsG84+7s1ZUXB/CH+nCsmPXDWF?=
 =?us-ascii?Q?n/6M9umgR/Z5Z3NSoMtdFTPrVmoZyg3ZCmeaR9TaU33nuwl9N/c/DRWRPReM?=
 =?us-ascii?Q?XMjB6p8wQS8Nw41yH85i0f+azdqqoUngF9NNwkABXGNygSy3rKKPv1vIYA5+?=
 =?us-ascii?Q?CojZ7X9r9YYU+oftia0l3YSVdFbaeAGLrC5pJpia9/5qIUMwQ0JzqNdo7Mwj?=
 =?us-ascii?Q?PGtHI03RrtfReierqV5yL6xc3Jk1/Ec87yn6hm4oXMZODBpdwgrUlK9mU89l?=
 =?us-ascii?Q?bw+E2twvKZt2d5HMYLhXIg2ixbV/sTUrTFytErtjqvcFkaWUaWbIUSvm9MVQ?=
 =?us-ascii?Q?laUhZnDEVabwNz2XiyH8OImSz1lkvHDJ6OpEeXQm24FQRl4GvXi83jnK9VNH?=
 =?us-ascii?Q?4p+4tsgfWtT+R5QcuiuVDQAN3NvlTmk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8758977a-04ab-4ca8-eaa2-08decc3187ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:30:23.6729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06iEpy1wQajTY+fwVhtDH6IRKy/ya2t0PzzoIYEi+0QMgq8zOL7H/ue1uzWNpvEoxHUvjZwKjS9BnYiay3yWyUdY9+8Q/As+CXzscbHfX/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10692
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

This patch adds pinctrl/gpio dts nodes for airoha pinctrl driver.
It also removes legacy gpio nodes.

It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * The same driver is planned for upstream linux/openwrt

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/en7523-u-boot.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 62d1a724678..7866a3552e6 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -2,6 +2,9 @@
 
 #include <dt-bindings/reset/airoha,en7523-reset.h>
 
+/delete-node/ &gpio0;
+/delete-node/ &gpio1;
+
 / {
 	reserved-memory {
 		#address-cells = <1>;
@@ -22,6 +25,26 @@
 		#reset-cells = <1>;
 	};
 
+	system-controller@1fbf0200 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x1fbf0200 0xc0>;
+
+		en7523_pinctrl: pinctrl {
+			compatible = "airoha,en7523-pinctrl";
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			gpio-ranges = <&en7523_pinctrl 0 12 30>;
+		};
+	};
+
 	eth: ethernet@1fb50000 {
 		compatible = "airoha,en7523-eth";
 		reg = <0x1fb50000 0x2600>,
-- 
2.53.0

