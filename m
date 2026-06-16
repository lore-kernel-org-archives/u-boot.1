Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08532CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 05:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F2E84954;
	Tue, 16 Jun 2026 07:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ADiiiu2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD42284942; Tue, 16 Jun 2026 07:31:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F658493A
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFc8FeIb87RvvligRbrxvibai12jytHfB/ZDYU4ciyAnMvTX0WK4VN4NlQR5FgN9MXdwlyt33awkMbuvP7tM7A7WhFfu6DMMUXZI0z9t/kreH+dqupfRDhapal2u1UN+FmEXitcnV7s4MjRhg/NHM68X067jnMoSlBWld+q2Fe5Pnyy/vlCX/PCad6foM1YRd4HoQ2wpJSp9TYqUS13vgXQtOmocsnJarJAHwIuYOk2n8lbSCK7yPHMqaRfYxvzkr/1uiGv/iYM7LCMbpbZkHWG3XAAwV2DbVSknzXRNIia1OJIegwXg3X08kaGmo4M/oC1efp7C1nUWxG0MbxzGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=XfnyK2e8km/dPODYM056O5ToqbBA8Ydv0dcMZOobzmo245kVTP1MYoLjvzi53oiTTXgWFpZDeyoBBoBULvw2+vsS+OAnq/HyzzM2vCNqNyuAjjcubkL1JnlvDMhQpU8Nlys71LOgX4bXViVINpP/1Q+hPiHVa8yVYljuWYAq1VvOykMoDyn2lcxfkj8K2jy8ZvqEaVyBKDtTeBJuAP13KoegkB2STadyvWHCx4PkEdQHXwAklfEq3oGQHpFCDWJIrdIR4AaeTHx0RdfMO09qbI1Bj0xrwJmbP7XtCWR0tvIcVOf7gAc3PLgdudiISAM4EqJRvK1FNZ+7bVuqK5yoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuN0P+W5dBObXIR75uFKXGCYqMbU4qsYQK2xPL+pjP8=;
 b=ADiiiu2hm541NhLOLpQLgI2XRxKZG9K2adWax//v6zUGNYfjiNcQIZlTDPnsFZWCyNH3JWHkRuZbwL7VKQAZSBcVlEyzf+U+7xHcEWfGybBNg1b9gcqVkklcdeozPp9YEiz1lbsSbe8Kzv7vsWp4n4XA9eFnkz0pEfh1fS6T0dBAlTGMQCcbpfJzIk5A2smORgkrZNhaW7CJjV6t6El+rgiGXUCMGTCoP4cHAYgzyh7ISNFcaVY1egSbIH6jMwOfNGWsHii/dnHfAsJZPG5IRKMWFlwBw2o7jXfp7GUc5EAtiKni+/OzF2SttlM4Wz0Y7qgh9px2ZpzwPTvUQ1ob6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU2PR08MB10160.eurprd08.prod.outlook.com (2603:10a6:10:496::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 05:31:37 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 05:31:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v12 12/12] arm: dts: en7523: add pinctrl/gpio support,
 drop legacy gpio support
Date: Tue, 16 Jun 2026 08:31:06 +0300
Message-ID: <20260616053106.2623475-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260616053106.2623475-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU2PR08MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 04df6a53-2994-432a-304c-08decb688974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|7416014|52116014|22082099003|18002099003|38350700014|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7DEeRG5CY4lXkVaPc+jHah8OHRekK+wVAVVqnRxMJHVgDkN2JG9/WeSO+J3mAu9V6jbLnvjAT05QeK3h0XrwziaommWIHkI3JttU80StNy77kwDF49AS5hwCWEPvlsRQVa3hRzdsfeL+SCgMTb5iJxpVQfYXrXGXpe3K8GJf61fe1eULhu6SmvMbZ958pHzLhgI8/tjnmy0JrTU8Yk8JDEWhmPyR2jWmxb88flvom+wKxkqkS7+rx6GqUtjTgLN0CoeKvWjM7uaWjvlY/ltqTKtcTndnW4MjAWN7DrRuj/CcI9V/tj9WiGpYOBpSh+U/kSxTA8hbtrtEJsgNKQ3PbK0fD6ybCo+HOjMVVaA7lurKidxUDzHHqDs1N9Cpq4Np2wGbMVqLdTD/nB1N2quhW+4HLsKNg7rmDe++gqXl9UYxh+anW7u00u7Ioi+As371tphIlIsbOAYV4OxMHiRp7yNB0YZsGRwyqnhqZ5Z7QC2lsQzpO7flNsZkHreX/ZlFfx/KO9IE7fRBuFAgd82sdbW5bdCYlCCi+IM1/1pNfpg6qAuyW7Wh3mLop/FVqO5MMEDtp5vhcrbub284cZ7qPlZuO/q40+AO86RaokEg4eZZu3ivibaDH0uU2JJnZUXCEC4intu3PL2NSEwb2uTNBU+GpTVYTo87whGtqL0jW+D8zydiU4joYrJjr6cgtmaazt67B3qozxGG+tmdk/bM4Co4GlFfhmVTrTuJ0dN5HwAMvWPcmc11E6K+GNUE8dgBkmMNAi4UYKLxeQHSujRHKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sf0SYUmu4kNxSoAvTnm7UjhjkuMQFDmj7UaCuuqvdDYpScZY7q5Euva/FfO1?=
 =?us-ascii?Q?/QbVahqL8X58Zv9XUZvzF82ud1T23H3TKD60jFPeYdFPoMaH4eIcYQ2rkTdp?=
 =?us-ascii?Q?AnG/OmohxHX4152/7GSlx4mMmta0l7DeSM5YiG91F9LWaN/wHl4P2DNrjWHd?=
 =?us-ascii?Q?S8uT2z3vZiX35bnY+WxXgANoMRw4wBBIdR3mmEWYsYlXlM/dF5OP7PTK28Sm?=
 =?us-ascii?Q?AA/+/lfoOtP4FU+TfmbpIZP8SX0Jr/Ac54JnuokasrQV+jvp7WkMBqmlZ1pm?=
 =?us-ascii?Q?RwSHNUDiQn2KW1a+wZCN2SDUANa67CdciWi31F8lnl2/+Zoqpfc4cxb0j1G+?=
 =?us-ascii?Q?qVoXACIIw2zvb3dvcrGXoiXRzs941fOsukRtfI//AgfDpyqhj8y7LZaTKWeB?=
 =?us-ascii?Q?smhBBRdPF3ktdPgfntaI3ZfpqXVSemKdEOwc53sw7L7q1mDg8ltcX6feW3GM?=
 =?us-ascii?Q?4yMGjf36Cbj+x0qiW++0ejNeiFoxu/MEt8gbWBoJ7aZqJ0II8L7c+4c8dJj0?=
 =?us-ascii?Q?R3VdUcxLCqD56a/CNvTvQdCxsi/VwPCqroJy1kP3B0R0lJzmm5s4KNaT69F7?=
 =?us-ascii?Q?59lgRGIGxd4UqkyVIsi1ck8CHjeo4EwJZehsYByaeBOtYQac7+v6V3+q3S8V?=
 =?us-ascii?Q?5SssK327jnqSN8bhpC9TqWBS6nvB8SlqPgfd+IklGUBJqOT8YTSy2ff+eTLs?=
 =?us-ascii?Q?Soiv9/pqGo8nUGTZePCAsgid4YS7Chj9Zuixf/vqHh4/Ue9UB858ubE8qdht?=
 =?us-ascii?Q?pwVkjDtwB85gPSvcGZS0Vq4LV5gU/LezN34w86AP3J88Ubpt7VHGySwL5X7V?=
 =?us-ascii?Q?tEnx/dMr9sl6muXWxFlU5VwTTv/B5vGBm37NKqOC/5TieX0oO0epICXCJheT?=
 =?us-ascii?Q?R5QqdXsuXASob01xV/YJdsVQ7kgXxgaC4eQ6yZQD9hMiGrM5iQBhavRD5KmZ?=
 =?us-ascii?Q?PkMuzQe8jcHAf+iKZrh66CFR76wkQL0Ruz4OZBGZ7iaAhiZFg2PlBa3XneDf?=
 =?us-ascii?Q?xprjl4uAz6n/juq9zfxAJsce5OpDWqz04x8lRSPDWG4b7WRDTqQtV0AkR4XP?=
 =?us-ascii?Q?0c19xj4gZdB7eSTS9Jw8ZCwZ2Y5fnYOomcmXKxBzW+6ZexvEumAviAOkS3xL?=
 =?us-ascii?Q?ZnHSwwdJYzOa5IV+Pu362X8QCgfuKHE853UkGs6AZRI68DsPeKUxBokaDa6D?=
 =?us-ascii?Q?CrMEC1/d6/gHUgrhkx99ILvuCi9vmzfsM7CfBOOoiocYdXct2vec29GWfvs2?=
 =?us-ascii?Q?qfrJ6rAl9bw5on6e41bK7nobti3PPPXAVlAH5PLOlnvYf4xYSsN2Zr+4D+/5?=
 =?us-ascii?Q?aJ7mSi2nU/0Mj6G5yEsQ5yL+sJILCysLELBgz8r3nT/MqjPo2FrijChX9Znu?=
 =?us-ascii?Q?suT8KFEhoggCo0JhW6Hkkl0Fl5iUpp8pp31MdcedBFFfPfuqga4wnwhDt6IS?=
 =?us-ascii?Q?Yw9fUTshVEeDF4EvpVatA+EgUhusKZjlOVlvL9FjsUoIZt+OOhSDX/SlXQ0T?=
 =?us-ascii?Q?WKYbWs3etIOnX6bRSgHo58L1/z7XFXAbu5CdaKuBJWChAuddzv8HBbWpzjWt?=
 =?us-ascii?Q?o6lfxdItNOU9bq+KmyBY7Xjlvo4vZTSH2DEPdFvHK70G7ET5UY+K+gzWBCQF?=
 =?us-ascii?Q?FKlIOpvih3Ei0aNpNTL3Si40DcvwQxwC0504rntgZgeScSED1N8DTomTW3dl?=
 =?us-ascii?Q?vPgPRt6PKcX8Qi19yomxZUC+dTtEfkzKR2FoQa1OZaTssmLRMyzqmXEhmIeV?=
 =?us-ascii?Q?g9f7/jAt3Pzyej0EEhIHknoro9jq9FA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 04df6a53-2994-432a-304c-08decb688974
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:31:37.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsZZlkdRPn/wAO3eiv9hMCuQYUFIIWtNSgeTIRaJUTEH/qHtbtJy+NA4xrJwAuX3y2tkLjuoGyr3GmafXL910HO9FS69RyDPQxlFnT6R37w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10160
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

