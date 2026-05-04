Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED170FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F363846CB;
	Mon,  4 May 2026 15:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="U4YAt8W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313F084692; Mon,  4 May 2026 15:03:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4894B846C3
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMamTImL4Xc3VuqVE7dxBKz1bj4ePkKJ5ZmDrKTxJj+ZZi8oJespw4R3P5GtFvbUhFk7gre6344SkwEO9/UD1A3WTpxb3mt6nSrvvlbKvCMqSNJNPGoeCv3+nwBWx9H2BLget/XtsKQR6695qNEL2wK22oB2aDFtl33ZiDDrWEa7wCNf0/OknQmVhbUZW9hYf09+ZG9tH+n4+TUVW8X3up5FyVhMsdtD1Z9lgYc9/5xsqPdk3NuSI4IgSCr15g1uAvVTGMBzBJsLge/Q0LvfYizr/LmInqEdrVPyE3ctg/Zv+r3QjmMcMEMuyEzOKk8j+Tj94ru3PiFTbK6c+FCtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHlAMtD13yfobu/KvAXsNlz1ZLoTsv7t4pXRszc+J4I=;
 b=csR8SQwqc4nDckscu90qsbh33VQmMtn6nNM8oBaS7KgfCVarO0j2tjgyDXAy8nUArDr9G/jV/2k71apETcqHUtGg1vvTW8Z0PCbS94P89FQRZhthIPHF0ZaTXCF5My0Z4XDW5zhcTThVSkjGCTlATC9WCmrwYZvQFRHjUh50ftimv1WTjnAp9erwA+MbdDG1NeHu2iRCy7GEAipUsF7mnLMWOdnkRY6ukrDh0GWx18ta6l1/SJzPAz+qp6kCSpwN7kJWxRTvgKuzSU2lbHyC87+4o0t7yh1tSGtcvkr/s+oNstEwsEK4crmqw+30o/cxFQqBl9CrtVg2c2ooSjbhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHlAMtD13yfobu/KvAXsNlz1ZLoTsv7t4pXRszc+J4I=;
 b=U4YAt8W0nfQSjzAavZnGkI5UHWWLPHsmgVVg0gOdPyNuke8Ze554+3RdMBUMD963IX3sNOKEwkBfh0LiMWJZSBA+A/wB+Y6xRpLJuWm59GUCmFsEhejTDqiREsWmXFKb++XaB82pfnX8V4OdkT/M5xKF3OZQbgaaPtX6PafxCdGTExvkgp/oHBMPxLe/OuYtAD7o2OzbaZe6HC1Uot+69eAqWhIb1jvkeaE8qR7zIYLfWJFZNbx/SW/XfPdM2QQV/KipM7dyBsEy2S9USyBS8QyDjXS3goOrcF5OfNKR4q4qz5GctWpFvhLhaNTR/6yuMGjCLw2beZDOyLJqDBOQ8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:03:34 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:03:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 9/9] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Mon,  4 May 2026 16:03:06 +0300
Message-ID: <20260504130306.2764862-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1b5a09-aaff-40ed-d27f-08dea9dd8c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|7416014|22082099003|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: aaYy+d2nrjUSa8NNSnyhHPFBRbZOaH7IX9iwWYTsxPZRn8I9bwIAecZh7+Vm3R7NUJdiQ5RtzJiSU6tERHlskD2RUsmLMy13rkPrxQkxiqHc1EsKc7ve5d/nt78U/kuaP4VP+2u8wr/A0kNx+2JQZweeLeJKEsf47wjKLFKsWdcXkknc57a24AztQLKyydL8z3nFPYqyoRRwM/ZUCUj14lbNvFA5VLEcgqLlDbgS5BHfLPOqNXnpJftHGNjRCgXkxkOQLXHE4qIGa/Jq1cJnokmzunpmlOoC2khJCGz3vLltjc0HXCeCki/SvpUT/DwREEMTaq1Blp3jCiEEDIWxR8nUUe1+TAxu7/8fD9VKf9aNoJxEJphysNulmC434CbxhJoairWPzogdUr0b4F2vj+MUr2cV1K+YOaifE4fJxOXeBirTgpEdtK1+voBdv/MYRCsYr9aEXE0+Nd8cG6s+fAfZb6R4zZ1AfR7GWZ9Dv99WAYYvNdrHU9ls3pXkASwSqpVawWnAA8V3MIj3+EOHTeEFdik6v1GQhVrK0VRe0LDWGmVpV30nUvYn3IXW2Snox2x6nWFoELZ+7lozbqD3p04cZXzYJe3jFGgg0Cu7spPLCgWwUU/1bdZtkmp7dzAT3aAxebIuFMT5mmTkdXYKDQQoaCgWFigo8dh6nM8wvw61/OSTf4UY9s0ius8i5WANPn/o28Xpwkas0qMnm2JYnIkqE2NU+dlf2hY8zWNLDbaSZ9/eH27Y09YpFqbtHY4wGoFX92EfBmOKZKMyMl6OHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(22082099003)(56012099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lk74/a4C2yfb3m4o+hBzWSYn6HjYOWmuA5ssc1OcpBxqadks8xpddBbNaSJR?=
 =?us-ascii?Q?BbSp0arT6CFOYvwmK79xQ0vIAHoSZE6OLfY9Jmm+M6RfRj4yIMwwWGdpmdXY?=
 =?us-ascii?Q?JwBWCCNMNaE7FYZviJs3Fi6QNxPokZybmTqs0bb/Ff8Pe/+UeSRBiQgubqbW?=
 =?us-ascii?Q?mXRbbe7hZDsHULogamhJcJhoABIB+rbF8mSxZK41x6eVBy1FAJ8GcwV1iMfz?=
 =?us-ascii?Q?DOlBJMntQ0vwfF0Gx577anDvBgOBvgBG5bMsaSwbTOBdWzyD1hOGRaGB8cE2?=
 =?us-ascii?Q?uuebDJfSnUCrsmfJMJQrCpHBQiWN6EdE8Ww5e3w8USEIOk0X37pRjeXobNE3?=
 =?us-ascii?Q?aaUCrBl4rrFB+nTZEPDYlqlxCg8UhknPBo+jNHRK9MHesNF//b+mYGHVZy2Q?=
 =?us-ascii?Q?3xWpxLRjqsfXj6eduFPgi2HKKWvJhNEMBHedAYO1iKLlrqE2u++unGLBnLMj?=
 =?us-ascii?Q?vLdCXWg7DENYPWfGvNLckqRUdHdieYwse7YCF1WSYFrbolqKpndj2jG1HGhq?=
 =?us-ascii?Q?Rha3p8jFU3TKcXY/sEKERqDU0QmOMPBYmaDwZwt0kDjFnLvlCpag3PZBubze?=
 =?us-ascii?Q?a1wrEQr+VlSCRvEwqmkrkqQfYXahWkmO6cn9eHV1tL4JJzMluTzV1YA6PxST?=
 =?us-ascii?Q?Tbk28Kez13edFMTaIGiwCTFTh+XQIgig85yJeg2f0ejmjdBi8HOTBcW/NOtE?=
 =?us-ascii?Q?BnEaiz4nQoFfIrPcsdmE8V0QnWORMvm4SH6R/r+6EGfXK14l5h5xVxdwREKT?=
 =?us-ascii?Q?AOqJmReCYxYMXj13tNC8LZoRa25GAbt3NvuLerV5LAjmuTS/QuueGa7pEDJV?=
 =?us-ascii?Q?/vBvsGhLMm/r1YpuvlfuOR87C3N6py9nZMFNMo/gXFi2/GDWF3kWuRhYfimE?=
 =?us-ascii?Q?mSQsDy2EIc/ywzF7zbCUi4W2PbaMcgz1EJLpYMcFwJDjyLh+PyQTGy0oIiDa?=
 =?us-ascii?Q?3CY5yhLn8ru4QbJWAMkjMTKR7IVlothTP2Y8XIE2UK5AHpJDg76Iovmk+cms?=
 =?us-ascii?Q?FCnW2gm/XF27DYgT47O6U+9QsPYhcz88006BwFKGQFQ3YXg76jvYIDAO1fAc?=
 =?us-ascii?Q?0SsWQPhILWpIiGqeGX5lS+lN2zI8V4D2QcxTF1C7DoSw6mV/v5+ipVI2LQmE?=
 =?us-ascii?Q?vq5EZk0FOE7u1Glh2YOSjaAPar6TQvGBMno9a2S+J77TxJw/zKor/qk0Cm7a?=
 =?us-ascii?Q?N8q886lH3V6IgG+pJBxzaFWup6cNd4Oez5+EZdaeT59OBjmYyPQlBAYRICFx?=
 =?us-ascii?Q?BgnvMp9hW5m9Mz99P3trD2UpVWOtfVr6NzLPqEKqAoXgORFO4qlEEzUlPY+8?=
 =?us-ascii?Q?qFWTW1nI9mKVU+S8bpvlXGBSqIsNXsabStQcSzSNWctiTxlnBh67G79PCdMf?=
 =?us-ascii?Q?SgT0rr3DwWBpTKfXhsfzR+mv19BIQ2xrKCux6jpSjPbRpTBhUfnu5undlnc5?=
 =?us-ascii?Q?yYJ/MVp++SepeADskGXThyuchgt8Vlh4j8aLPCrmu5s6JmC9dWzJHl9kuoL3?=
 =?us-ascii?Q?ZTC3zRv3LXRBTVGVX2G7Ze5BQ9KYVVVtWbUH/GAVpRXG5e6Vl3EMgvfeF1kR?=
 =?us-ascii?Q?apnI9IkkYnXV64coVZPvh4duwTOpGwjDdKxrHo3cvwcKlRsWNvWpGm97X22X?=
 =?us-ascii?Q?MBwysofGPW2EZiEjJlrEqKsUCxgh3sj27ZRmMCjvPBEsFrXDogkceYov4Zi2?=
 =?us-ascii?Q?Dyi6oRhK7xpFo2KnjAmQQ3ob5/STiNv8Z5Wy4vuETKXfXES2nNOyhVqaENPa?=
 =?us-ascii?Q?89PoWYzkdSfwWQ/y7FcDiVil/EIFGD0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1b5a09-aaff-40ed-d27f-08dea9dd8c85
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:03:34.5243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP4uu1gA0/b43ZXIqP6sZX10wPZKn6PjthfALvQeTPNd4DMbQZv90IH/HKimOGOU51rJLAf5Rpe1c52XGQisfnUXwzdjcIEs8YOLWuowM6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
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
---
 arch/arm/dts/en7523-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 62d1a724678..c8287dd22f0 100644
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
@@ -22,6 +25,24 @@
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
+		};
+	};
+
 	eth: ethernet@1fb50000 {
 		compatible = "airoha,en7523-eth";
 		reg = <0x1fb50000 0x2600>,
-- 
2.53.0

