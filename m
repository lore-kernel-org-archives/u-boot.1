Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EE5C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 06:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9EB684CF7;
	Thu,  2 Jul 2026 07:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wYMWmPau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B2084CD6; Thu,  2 Jul 2026 07:58:56 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8183E84CCF
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNg3K0WUvZCDQrX0KiVYSvU4FS8eE2WAdcQh1uzx7Z59RRsXF4ruuyJiNkXP1f0opF0S9xyqw+FaiNp0bTcCPDVI9yBDjD8F9xmynaTVdajXTd5i3YU19fZuN3QLMeY8ud2B2p/M2LbUugNMU+OETn0ora7gxV9XWfG5Apq1D+wrmgksQbQ12EFv4BV+3mVeJ8PjYQ4nLooR4k2a9vy8xxOUPT6uRqfqGMp34bwxzxpKpd/TCoMDLSpSuBmDjMRbQ/9EH8VFbrkYH3Of9ni2DmTlqwk3vJZuLZ5gLd5VyBWs3eZBsXJEkQ5n4372aR9C2hSGg0RNf9ZSWw2sgA2log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=FOk6LTL5rvIoH5gX3hMMTjmpq71/FrHYIaAVhG8ki4nat3KGg17imF49qmYnhFaHrteftNhapRrG4DIPT5/hmB7zMN6UjyWwJV47sL9AOJcSJlCMxFm9F6t1kqFlr7i9FVItNwJ2o2dDudQlE/9pgAx4F1aWDuiB+Rdy5aFMjyCRGYvy4xx6yEb0nPQHJmbxdL+M33LnXVsUB5GbReIKfXZsGIPLjZfdKbS+HnGauYB6IgBOX4kFWQ9Xtgi8wXtlQ0Ts3Q/GkPI48UrPSuHKk9VyYdQ8H0jEsKZ/ISy15ZoN/15nckS+wFaLhV+cihyLBa9A2WmB1LmYlTxGDjaIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=wYMWmPauuevkbZJ0WyzZh/I3bGS/qXIsA7FKt0xNLuUwmTNeAWVqbuqYDveRqtS1ZtdUJeD0+PwvLoyKTfSN+PH9fOvnic+1daQmspnqKbP2lvD/IxhQ3IjdCwMrj0sAxNEquN+tN0pRFZzc02Q090MG2YnxC0GnmdS2jcfuVildRf6aTfBgijM+iqQh7uzGkQT10/p+IKfn3ZXiJ3OkD+8xc7DA+wA+Ar/YZ9sQSq/5Y7fiDu/cU179A407ZRtmHKW3JSfRMBZ1jL+WPnAfps6zVzOlfo9+LxlbCFj7Y0qYjM24emjOQ58980oCH5jH/xT3PQ1ox9Sgr+aGcu24cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9543.eurprd08.prod.outlook.com (2603:10a6:102:2f1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 05:58:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 18/18] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Thu,  2 Jul 2026 08:57:44 +0300
Message-ID: <20260702055744.2164975-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: f312b5a5-7ccd-4126-cff1-08ded7fef724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|921020|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info: zp5jdXB07wjd1jtyMr2uz2L6D1tg1q4B7p7byh4sfDuA6rHHKHSnX5YqdN49cHSFW2S5L/7K5qZ4MSRU/Z/S7oZOZ9W0vWPCFR8hHzwms6S5SVqEyD3zpYuUVMEeORcZlBnRmP0IO2RILl//5kuAK+qab7Hoqrb/CKZyz+nBDxa4yPlOhNJUstF47vobYX9Jw+p2QFsLvvGljx2gPYMqYTI6VMEWmhgYywv8IBayylem0kBA6ah01N+/vAJW9tD7UNonzbEn6mkSuq29FKAMHx2aqHBgUBhBckW8FXJaeObucElcsvrbvI/jibDxdASuvFUuVTPpHS3+TYrtF2ursgn1Nebl/RgXPy05M2GozkIO0PlnCuS5T/70kKltDdWy+B9UXGiQ6X6WzPA5Z/SBc/LZONHhHexpFQFaSrn2LIjj0BS9mXJ/eHVKjrqvZSe3UtY6nTO4P5dqFXcuN+4ZpNCmUrIo7Hre35rOvewGCPJyqc6yew6NKNE5/CrMMgKSIUuug5Mq7cMAePwtPYYChq0UYX2K88FhXQ7l29Fe6xsLesNIOe+3kzeeA/pYKdD7O0OCKvDId39cTvtxzBCx2NRCm6IGytZZIaFc62Z4+KkpCCciQ+WM3xxwusJUhwjpiTz35P3DbM4WTc9zDQurbhrw5Hc8FQJ5+pu4CuNeLodHwANUyUedU/JAoa3yf//ZvuFdJDfWvrZAa/4WKJeh4LqW5jxjhW4rz7PaoApAOM1NrV57cqLQG378ppsb9XGk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(921020)(38350700014)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRNUplhZTCVdDrIPI5PfqlIQyjMmPl2rWFA9rMhsnJ0CQV0tRAhRcm7ScQpe?=
 =?us-ascii?Q?hVyXk9NT9aBt0dGMwXBNv5AtUfEw1SjvclhfjpDtSqdU6LtmXn8wzsT6PDUz?=
 =?us-ascii?Q?EdYiJ7Tic7ykUBiTS0voD97wju9+eWrYib6hYXoQ+oZ08V6+18ioYb1sQoTX?=
 =?us-ascii?Q?akVPcV04OdbXJ5CCTIRq1czdmsTVykMcKiwNt5b4NKVMvIqAb2KSliLpO98/?=
 =?us-ascii?Q?f/HWO8a/TFkA+qtlqfd+wzAuHRK3nGSFDPK1SPi0ALzToKE/UWIl/tepDyFa?=
 =?us-ascii?Q?1JWp0g/KYeM8zuDUg/R0JGcDKooRE/ru7NWlL4ku7qcEx1Guhew70mPJERjQ?=
 =?us-ascii?Q?R+I6ebP3L6l7NVl37LWKXsLRyULbyxrG2Jqz++3qY8BK3yatzbZoJsNeznVS?=
 =?us-ascii?Q?wtG+tYvrghC7AMgY08og2lxOlhGGjENQYHlilYIO2AYIX6J9W4hArjNYwVFz?=
 =?us-ascii?Q?lZti5Ojwo+AxyfHEW8YjrSK8Wmh4mGBs8SO41ktuL9voBwHjpJwfNQsk5U7N?=
 =?us-ascii?Q?bYQRBpgXty4fq1aZCSTWYHFtopRzHXNkcvyB8r/pFe2MAEO/WZq5KsAbjCDX?=
 =?us-ascii?Q?FSSePudyV+8NBaEWi2sHB5A7FQhinRau1MIUsN5Bh9EXzR2mfhdx1F0UxHII?=
 =?us-ascii?Q?5zRqVP+ANaXxNzHe/RLYPVtsLvAJH4K3ZEgl6PaG/0ftNg9Oil8PanQw5yS/?=
 =?us-ascii?Q?IkVtTj+kbr6amRw8XZRrvtNeJl3D9Hnzn8WGjOtbPy8pdSxHBTxeujUGdy+9?=
 =?us-ascii?Q?b9ok2dv3sojr2bGVwE4024S9XAr2yZe8jMxSzKVICTZjG1yyxbv78s8nOMEW?=
 =?us-ascii?Q?1oaguXy3HSs9drG5qiKQ+D9PyntKXZX4VsfGOE5q1do9dzQOSTFJstfUFrZi?=
 =?us-ascii?Q?XUecoPgEQloXJxQgYHKh+4KyY2HKGuqf+l6WAEJRz6L/Mv6D12Y5Uuibbobt?=
 =?us-ascii?Q?bBDW4U/ynsfv7nyeX+rU8NFvDF/NzQRA6hfPJc4Dq3mOMYPKWZ3rQ5tdLb8e?=
 =?us-ascii?Q?/j12NBKpmbiZ3+hE2lLReNv/PEjsrTXOIcDSTbkwJvaj9hVsXTOr0KK6bY2H?=
 =?us-ascii?Q?L1HQ80J7DVXz/Ou4Mep5NC0JAXBfiGL7GBYxUCPIMY1Y68nwF3QJZPgpxmW+?=
 =?us-ascii?Q?fnP6s4WUvxbQUTukBJIDRm8xBv2qXH04eVGCCk8nVyzyU1jO5pSbpxukRIhB?=
 =?us-ascii?Q?1hb7SUIR86XGlbDu5D3UwyKOQ3Ojz1IiEq5XdsHTwb8lBU4Yi88XZJZOa38N?=
 =?us-ascii?Q?yI8QIpBBq4Tk1mR8eXwLPqo2l1v0tSnakxI67m1pByJcQTYnzi35bwI5dEUj?=
 =?us-ascii?Q?lUzmxWwsin9olx9Dwd/dj/cSuUVXcF/BU55ddtFn1bGevz4s7YEZqfVQv6t2?=
 =?us-ascii?Q?1omIQmgH2mCjbo9GlzgFmo8u+xelDQ5DxovYyV6yWMSgnlPeXkL32gTtpAUG?=
 =?us-ascii?Q?pZGySPTQvOBEVfZg9H9IKrcLGkAEwZcxhT8qJb1Nni7dGUEgW7TavPvm15nR?=
 =?us-ascii?Q?1fsSn4VfR3Wvh86FO0B1gjayMiuL0Z6zisDhxSOpWfUy46QN6vZI7NxeH5kO?=
 =?us-ascii?Q?7yyE0jkhPgZVwcVC0xlOFJBEfoRE4Jwx1YzRGNd6TF2Hgk8HWHukOhbjQEQ3?=
 =?us-ascii?Q?O9ya+8KCyDwTJGDkK+7cIg1JGqsrdL2tOll/jL55I8OvXfsIk3VgkDVou9Ib?=
 =?us-ascii?Q?dLTfewXfv8LrrScI2+x3//JbafgtDcCXfHQReKdufCIcd9Q3mrX50q/WyMfB?=
 =?us-ascii?Q?dydfZOcx2m5SQNWaOY9nRxL0NQZRsWQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f312b5a5-7ccd-4126-cff1-08ded7fef724
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:40.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQAXj1TjsK2gdy5u8m0FDeLtFV8dbrlb8RRtV5k7sYDb8RqKJ9AX63IriAIj78nozkKtPz4IgUyf2VSLw3QcSlHI97SPKwriGci+N6sp7+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9543
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

