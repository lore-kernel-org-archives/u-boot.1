Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF5FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 00:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74DCB84683;
	Mon,  4 May 2026 02:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CRdSdziS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B788467A; Mon,  4 May 2026 02:35:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFE284374
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 02:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1H5D+tJLmbUYP8j/ozDSiZeZJfRuFek2sqmdupnIohP9DDkoSId0fzjU96pSZR8ol7Jmc/0ubSyP/+UrJTSDBE8LVfeAKP8cnd84otNdbSUW03N+uTQAwB4t+q4FRLa1slMAw0Upy4guW0O1h64WsuJNq2hadyzSPPJJ5DYQX6zRFFLIPwWaDnytRWqjikdVOEp8xrNF9eM/kEcyUNEDyAd4j5JzuKNSFZSDQsU87Af7nYk13lQCXpHsTGkLbKKdSTKtaGUj6QkbMixq7pUPlVcM1TMmKqzOTQFIo36eEyDPUb/gVoFxdPJZOfAVe67D4BrQ2CvdbAHwDd8mmSbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHlAMtD13yfobu/KvAXsNlz1ZLoTsv7t4pXRszc+J4I=;
 b=q0qX16+572tvG4Y8k6rX7AKC/LeiO9Sz7xXKvryZYYjYNpc9CKOCKskwwa0VDxPbzIGXaPzhxq9zfUmZOwbXw1vjyaxieHxU1cKKRusW1kkY/hc8K7JnozABER26HijlXqPQRqNcfyII+DQD+s4WcfTJYf/UYEvajIwCxydXMa04Pguv+dzVScXZcqE7FQvBjV5vExNJDVn/VaFe1jZef3N1YwX5ZXbUYT+HYDLdXdtNAQqGlSpBjbd3hQFzH7nQEQDbCgZdYhzVnlcja6tBmnaFbn3Nx2QmJOMSwoMrAmIHqfGFhFnv8QZt2JAhpAcpNP03wRlDaVuXb4te56g3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHlAMtD13yfobu/KvAXsNlz1ZLoTsv7t4pXRszc+J4I=;
 b=CRdSdziS+xHyh4Lfx1vKhYnHvfZKONe9N3GUI3luxiEpx/eJI6c5He/AGxTr5ZRnlRDKjT9EN6XYAufj25CS33++U4vNQY7wYvFsPWVi9yCLZtn8t8u/DTFW7QRQbd5/lNvxjej1x48s0elL3bcZBO/Rgg6Tp0j1wSz8YqRZrrwwNtK2QnUrwdutBUqRqUTKuhS1RTBOVbzgZ3gRxcoWVNcITf8IoEsGU1J+Qeyeltygvfkn8KaXip9EsvLY8RSgFiKxBRYoreCcXRBG4AlqTYAUrWSbCSOQj9QvGEjZSWhRqkMErWscxdOMQhxKc3k8wKElF31vTDC0sKkUPgU3lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 00:35:00 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9846.025; Mon, 4 May 2026
 00:35:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 9/9] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Mon,  4 May 2026 03:34:21 +0300
Message-ID: <20260504003421.2545713-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A03.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2aa) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4ae445-a127-4e80-cdac-08dea974f95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NeTuE85nl7WxUx+BmO/w+KIZPpotPo4BM4Gv1n9zC7fwA11r8V5cFgC83hcM6mYsZKjnJrPT19wd/SQVrvpboSwlUA6toeXxcADUImcu+WU6RcgTyfWsrlb1iQZeTaSVDlfwZuScRvbzXgW2cSv1U5YLTTUMiurAybmP8FnE0Up1KG2FW8OKEH58OmXvigmLyimbuTzKxSGZSeMHcdFHn1vswovwfxG9AVVHcGZvM84+4yeaRDobfbmST4tlq5Yr6c2uhrAwqE4rynpZvrfJVhy3470l0jOX6/r48O2UDTEvyxgeRl8794qpDdMzA3g9kfTX2ESr/8GdMPAsdH6ceSBJg7Zmhpc/fPDbmYd2XV94qKq0zmStjkHAxCeub+eAeAoaAlsLYmTVZlxAGnEEhMByupZFYIGbdRK8pfy0+rrS6BfgB2/vEEtHXVSpRs21Ueufme+58f8deiT6PKDhj0qV97cI1wtCEOY7EkJCLid1aIJr0kf0iQ+kG6zPDH7K9RMwgl/U99EUyIUWY5lhQRFXczTjplTcXtueuqX/QDw+YnQldlO8s1CYvo1IrkaSu4GUbLJF26OHe2qxMHBeQ3oSInwlH9/Khvdg6F6RuJTvqMA3p7/22loY0kBVl2hNufZT8e3jLtzdcHRyL8TCfySZwsRMytQKWr59kgLbDIhlSepaNKTbr0iGaT4b4IOo5jPRR+tt57ZQFAj1EBMZ/iDgTeMWHqGyZ9m2NlnBidFZF8sS8Pq69/+jFtM/PuEyckbdIuJZjtjg5le9Kynpmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhfUGIDF3RpaYMFeQxc6UCkUDtoF0DrIS71bPqUZdq0n+EYZvtwEJHMZBCh1?=
 =?us-ascii?Q?uai3edL2bgBea8xOvuOaRoO2YEXz6Cwf9rV+jO1wzG2OZSr1VRAP4ZgSMBop?=
 =?us-ascii?Q?hdx366gcTqOTaf5LkZGP/VtH+15hb9pqSFwlMe/ndrgvYVYzA+AvaKu01JLy?=
 =?us-ascii?Q?COHJO/bL2KEAvF6ko3sTCfFq/wHUT8piWfZUUbqjVcwArOo4z5+j1txJ+ylP?=
 =?us-ascii?Q?yJpUorUGWJaetGO1aez5PKFlUjf2hVjwXnrcfjOg0uDoBGfuZdmn2bR5CESk?=
 =?us-ascii?Q?RAndgqbK2GiUEj4hP5EswXV47GOPZ3HKwBcWy065uNez9uRLkx7Tvuq3ciNu?=
 =?us-ascii?Q?k+JGSc6mbpioROWXMSi+IgFsbFhQtP7NueEogc/GanDat9nU5xE9LT4+pkRg?=
 =?us-ascii?Q?eGifLzcinwmxrKQzRhFWOaMib7wt+Gd0SddYz+pdyTR9ltP6lf5krtqQgFn4?=
 =?us-ascii?Q?1AonI/d3FLwHFRCYMSWNbt8NIVU35x915VDNkSRvh4O5u1Ny2wvhmWdEsb+q?=
 =?us-ascii?Q?T0OqG+ZPpK7zkzrm20mQTLr4WZzBD8rDsa2cghuPZr1zuPRa3qGADuCq1qiq?=
 =?us-ascii?Q?N5bOn47p7FQFI+qqstZK8YNO32syUpEzdHodp2GAtKd0kZzkxy/xaQP5uOM/?=
 =?us-ascii?Q?Fq7yC86JD83Q1dZhpKX5C9lFabPHmyqVOQQWzf0W3X7uk3ZRgAhNY3NmsJca?=
 =?us-ascii?Q?t2nP8VKeJgFGZdWIfeNJNDSRYhHK/Usn8sPI3RERb8/dSohzYeTFtKKk57mN?=
 =?us-ascii?Q?cL1IKjhVVsqLWo4vR7aidd+MQE+Mf3ONyrvSzmPacbQEWWF7pknV+gF/5l13?=
 =?us-ascii?Q?XpiEdKya6ufgWh49h7HGtuES7KvzFhkM+h7Jb/Nthkczd1hGlNaEOV9Prrkj?=
 =?us-ascii?Q?ChLJXc1DBfsJEvbXhdKUVL62jSsscbDxYQ3a8PaB1eNjh7Cg9yNGL+JkRycC?=
 =?us-ascii?Q?nDiGDfo3ynTZk6UJjhpSxZdJLkUo0bZgF/OU29+yKK/pTKeQlqPte0Zt5Yab?=
 =?us-ascii?Q?e/AckXHhJn7HdUakDyhNapHwaViMRwmfOB38Yok35WDqr9I1Vv8XJRSBY6wG?=
 =?us-ascii?Q?oCyiH7Xa1p6ioaS230e58zC6kVOsD4Dc8AzmqEpGC6AHQPSqclagM0cQg6oC?=
 =?us-ascii?Q?LoN4FZ3DfbDz3NlaPMEozyT2pAroT9KQ6rcKUdg0r//LjTcts/QADZwDvc2z?=
 =?us-ascii?Q?gGWkyOhIFpXsVa/dp/6Z1+wZPt7VcDo/66aA/K6OnYQrgit2GxtEYZ1DDYXv?=
 =?us-ascii?Q?xxa7I4iE4scN4e3H3NhXXRzNXvkFhdhflFpHgMHuUxtn5ZLMLZKU2pob4EGS?=
 =?us-ascii?Q?VLRb2qdn+j4lWyc95wrAwDeCM/qXwH7kP6ehkRIWbEcjIYkd67yhyv3EESqy?=
 =?us-ascii?Q?DQ7eY8UirUduAHtfOmjS5jaY24F2sTnTpiNHFTayeTq2W3kO2tperYEcX7K1?=
 =?us-ascii?Q?mW56XoXrsJ8yN2atfAS1L/DqgkJJ5/CCR8M7qsFDXdUFyNyAUj0b2TWUxGJT?=
 =?us-ascii?Q?PLBPbXLunkcZg2p3070gb2fmUF/ykCwcLaMelI+ByWfBEu40lC5ets9XvRB7?=
 =?us-ascii?Q?jYMnvYoFnMFAUwvEd1Bt5czBczLInbzXzu336T5TDpZMAEHmHauZkY8KJnOh?=
 =?us-ascii?Q?ZRKuJulniO9f9p/wBIInYwsbxQgZUn8xGF88t6j9eMcqjHZ8BPT73uFmxemc?=
 =?us-ascii?Q?UY01TfCyP3VksdHdDRiuIa2BCzRZD8etDgzbbJVm08/fRrgvshfTEJIZr+Ur?=
 =?us-ascii?Q?A1ZyHekV3rUVWC2/P3g5x4FDr8yHnGI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ae445-a127-4e80-cdac-08dea974f95a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 00:34:59.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKXyDKOxGrEaEH8o7kURJ1sjKTbF3jeM8F0EZjKpT5baN46QS4hKgmGgoQ15B1L5ZUAGYc8NTWDOOWCSkmn/8YxLbT0oOCGGAn8sup1oeEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
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

