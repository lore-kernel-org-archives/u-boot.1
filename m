Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95638CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F918495A;
	Tue, 26 May 2026 02:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="o7Fu5rKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF75284951; Tue, 26 May 2026 02:26:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF5984928
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWrCn8elj3+agV3G2a2s6SsKPlF7O/PiCMRZQoWnSznURvtJvgR2PbDPGQg0e7ocflMiW2+aRti4jtu0cXARE2GNKhNlLXzZxZL3KF4Zj1wjfcL5MDVVru61NLVtQokyLwiGJBfWUYISgx44YqORkSWvo7pUi3cc2iY/oQmEX35sfwaucq3nUfsC2DrvTWIAfXxs4k/YbxKzdU+e4xXsVmkYm00bLewhKSc8sFzwHQEY68yfOtTLWrQzNLMepaTjNUEgtEOO1SZuxP9gpicnup4YoyCqKHzw8NVBPonAo5UwYTVM0R6WRBYOKdl32MN5AIEDnO/paA3Xrh/B7tYAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=kUZ5UOJplG5asEN8hc3KSBNDqruFgUm8XM3OrPCvpBNXn17Kvg3c86fs6OL4ZvGeMYyjBqcP3rjcwM/8Tlkdr49hz6w5bnwepwlxcv379E50XKFSdQtruBF7kqVTNIrntM8n5qArexiDUC0+Zr2a1pHdNx0o7IzZquzkNVzTapZbdKRzr8PDyjKlqW7DkV0ouAK5RcF7RWOi7Y1sg64UmO7R8riy0j3dJUzQ2QNNw9ibnq7Wk39KoLHUTEvDKpDzXgnB0O62NMTSmNUt76lMRYhfdDsq/uYM8bUuLfAO7G+JicFMUtj+bf6Ori8YvfvKlXYb6NrttdwSHUFdtk+alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=o7Fu5rKyOYLNO5E075jixMgBVEaYG0RmMRIXIVdpQ8cLmzsq/t3AywEAfG875XsfmtmjE5+unBuXVII4+no96aUA91D44h8uL6f8YOLzE89uKdRry7s93Eutt3tJF2UqcDUReCgtaRKDfdA0a6JW6F7+f6DA6FpDTKeYoU146ifzeQMQ8TsoDTmPZVVAkirA9JhP67VFKb6hozmjkBsIhCWKxdtybCfd/pVRIIWu+Z1E8aMLA8G+1b4YNLr2WX/C+jKdg7Fu1YfoOVGB5vMsnZw99Un4J/7jyOj967h2EsQ0XPU+GAum3WVspF11pPajZgByDn9Yie49WX3+1ds0YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:26:02 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:26:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 05/12] pinctrl: sort and format the contents of the
 makefile
Date: Tue, 26 May 2026 03:25:27 +0300
Message-ID: <20260526002534.898340-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a24707-77ce-4597-2327-08debabd5de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: +1QYTFQIXuyZTfds4sRMdXuNc7RZlzU6aWaJn+O3c7MsNQWX4Tfu6CHr/NgxmECMjyRoOJMd8zPqGT2outfYjQqCIgNGE3Xe1832Wo6J2ircKDzWzr3YT0flBQQiAU0+eB9p3Vq8JP61VWzuhWV7oSZw1aqPGHMGW5Eve4va2jzB6OsggFjl2no8ya0aeeayFG5lS8NfcOejODl8f/kS9bNbHkSqb8NS2pQdx/EhM9qdcu/xjdKoUXnH39ttEZzHm+jyvdG/ImM1n4nTywMPBfGV2pS4bHzIF1pHPUIgFBAHkMWPe8rVlUbMGQETpfJ6RiNwSliXCNfrumEfCX3b6nZItFOaHN2YGf5EhcQDxZwqKQKz7ToZqhWjGCTwZspgvx+1TqxFzvOCxJJdaOMRlOf9tA90PYOKnYt6Sh8foB7SdBWsGjIbp4IOXOvQVh/Q24MzujqKUg1/QFBAlltdrFknayI+8WZT4VmpbMHVQxZvUnmi307/EAsVSMQlMQjE3p+KleqY60EsIIGs8nW5IgKtZVQN8XX4APVJymWqmrhW4fGTzqhep6EdDZwekGFLzDX60I7sDI8cQQAkUFKwvAl780eLQAa4QvLMyaEodAyENwZtg7paHNiiMga2nCrQAAhaQVav9Lds0i4LCTL2Io9r6ApK3icXqWrhxJHMzNai23wQyXAfc4VYV0Lo4hUH32MQxDNNafX0NpCP7DLW2sKEhPh1YxguHIqhnUWV3wW/Yxba6o5HXRe7nVINbm8cSJNND2UhHOmtrSqLsgqHSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ir6Rq4G2G22bOe7Sl7+IfR4Wj+Mz7VF+oHEAhFOICBoR7umXeINqtWeKzMyu?=
 =?us-ascii?Q?XpAVb7wake/IZtsAgqfc7/9GAh+YR50nKkQGjJRGS/5eXbOArUxuh1uP6pow?=
 =?us-ascii?Q?e5FcJR8BZEbiiXr3RXr2qerosyhz6OHMxriKOWZxkdIfxBd7kluGi3EuEAdg?=
 =?us-ascii?Q?u8LNs+kLqxgq3ujHheJAyG+J65/Sooj0Q9cAaUqNJVECYznFt+yI73mL2LwY?=
 =?us-ascii?Q?JkAD0yje9PMTsDEgs+JzfqIvFGC3BuRV0KBO2wUIup3VZqJxqgnCengSNA/X?=
 =?us-ascii?Q?Pu+4JKkqBzWrDaG9O8ytXMDCe61BY9LfnCQx8okcaAGHyZS3nX3YfB694Iyq?=
 =?us-ascii?Q?aBL3kGIXnbopQf8mtN9ejsftM7zW4cXRp+EoIKe0q/ifdO5y6ZLL0k7FoQ5p?=
 =?us-ascii?Q?J7IOhIveStrlh56S+Xq3OB+TWgu5P4daOMS4H6LFFWwrwTLDZXQC74Ihyphz?=
 =?us-ascii?Q?sfotAw7Qg8lLQ7evIdAD2Lawe8YBwfK5zTskyd+6R4E/I3kCUe9xX/hOhD60?=
 =?us-ascii?Q?Vkl1yCz+YAkkD6+M+wNr9E4NOyFX0Vws7nT909I8qFfpremaJCyyB9X3lM6t?=
 =?us-ascii?Q?cVbI0dpmTJvZ0MHZA/mwIgyqrIoNCrhp9kU9/wH4V5rujnh83lxXvqIfkKka?=
 =?us-ascii?Q?+KzezDtEw2Ofa9e2dLkGfcDCg5yA0fmDctZZQS31+Hj9ue+zEpGbW6gMFFDZ?=
 =?us-ascii?Q?Kcl9usYlbZh7mdUagS+CXNprWKDdDwQL34ABLZIBXo9x/EzylXM/B07HqHtl?=
 =?us-ascii?Q?ouxO739ibQIiZa3APdkuIgn++iudFt8rJLhoroQk01Oe9mDM2rmqy+pgmbJF?=
 =?us-ascii?Q?UQlYJY3Rhh+uxwvtQ8vRDNl6ABs/snLJk05To2kkGJ+rrpZK6pydacQ2P+FY?=
 =?us-ascii?Q?/RbOm0XNmXwn0ouVxU5eSfEUmU6QIyFUfAg18jAZMpvjTXRpDwCezxYfR2GF?=
 =?us-ascii?Q?tNdEW4pJjoYB7BH5n9N6xbxPjfVZb7Qqa79Om2Ky6NvFUGOda8J6KwjukJ28?=
 =?us-ascii?Q?PNYRRYcWPS2AhiE03xmd4PEc0WhYtRwwBzN5OHpakE1fT1+wN8OTZ22mwmDK?=
 =?us-ascii?Q?qgkba0iWmP2OlXGd/s6az1Y6BYaUDYGembS30L7Ejjn5kk9HrHFiH4THhoSN?=
 =?us-ascii?Q?qNGC2KetsWeuoujKl1w6WCt/gCY0jdgLfNav7olRzqDk1vVwbqvykC4g8m3S?=
 =?us-ascii?Q?XuL9afsQyetoyx2AJaVZQN9HwaKhiy2wa5+XMCNwlpDcqoech+14XQzgR4CX?=
 =?us-ascii?Q?taXL7bhlYj15k0L2/jZwfMzLzC4dbRxw7kfe3KszIwFhi8DTM5WBTpX3U2+K?=
 =?us-ascii?Q?7n/4gY43qE7WJOZPXb42aU6t6DL3erWZvrBkTY+kXyEGiaVsohINeFs8YeUf?=
 =?us-ascii?Q?wsxxPOxaaB5kEVoXwXzQ4DIGmkzdMeUVkgrIVWKHgvBy36cfkCipUkXb6njA?=
 =?us-ascii?Q?fkuQ9CYQunyoHkajvIlpdNGhImJ+IQz3ZoqUgZgAH4IK2lJJreXcjAL4/6H2?=
 =?us-ascii?Q?5TQJW4N6PDQe81I6rNIwpeBrhcDI7vIwY1pLw227RawHL8BVkqw1oNww+x6K?=
 =?us-ascii?Q?h61dfjLS1Nn1Syj57DA1Wn4gO6RqM6EQXHOU8CeC0baLnuDa0NOt6wm43wvq?=
 =?us-ascii?Q?nW1vT3OEc6q9h9QVDRrnycLe+z2tLDBuVJrRG/JPFGkJGh2imLqsSoMZLPGp?=
 =?us-ascii?Q?gjRSSretFEIsVqQ3AQFunAl7jXPHykP3uSnyUPCIX01U1m25WPbHWjuoGF/f?=
 =?us-ascii?Q?BM1WEnG3KB81Z0Mf8b7iUTyQjR/TjNE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a24707-77ce-4597-2327-08debabd5de6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:26:02.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDNswzadxP4zW8ZiLABIQ2AFln1iWYNOIt7efGijuDdSI48JmTAx9ldcztTFerS7dwoObliPuT2EFsNBLWlNbTzaJYhSRZnZPOmhinZ8Us0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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

sorting rules:
 * rules for generic pinctrl files placed first,
 * obj-y rules,
 * obj-$(CONFIG_ARCH_something) rules
 * obj-$(CONFIG_PINCTRL_something) rules

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/Makefile | 60 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 29fb9b484d0..df52c6db8c2 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,39 +3,41 @@
 obj-y					+= pinctrl-uclass.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
+obj-y					+= broadcom/
+obj-y					+= nxp/
+
+obj-$(CONFIG_ARCH_ASPEED)		+= aspeed/
+obj-$(CONFIG_ARCH_ATH79)		+= ath79/
+obj-$(CONFIG_ARCH_MTMIPS)		+= mtmips/
+obj-$(CONFIG_ARCH_MVEBU)		+= mvebu/
+obj-$(CONFIG_ARCH_NEXELL)		+= nexell/
+obj-$(CONFIG_ARCH_NPCM)			+= nuvoton/
+obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
+
 obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
-obj-y					+= nxp/
+obj-$(CONFIG_PINCTRL_EXYNOS)		+= exynos/
+obj-$(CONFIG_PINCTRL_INTEL)		+= intel/
+obj-$(CONFIG_PINCTRL_K210)		+= pinctrl-k210.o
+obj-$(CONFIG_PINCTRL_MESON)		+= meson/
+obj-$(CONFIG_PINCTRL_MSCC)		+= mscc/
+obj-$(CONFIG_PINCTRL_MTK)		+= mediatek/
+obj-$(CONFIG_PINCTRL_PIC32)		+= pinctrl_pic32.o
+obj-$(CONFIG_PINCTRL_QCOM)		+= qcom/
+obj-$(CONFIG_PINCTRL_QE)		+= pinctrl-qe-io.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_ROCKCHIP)	+= rockchip/
-obj-$(CONFIG_ARCH_ASPEED) += aspeed/
-obj-$(CONFIG_ARCH_ATH79) += ath79/
-obj-$(CONFIG_PINCTRL_INTEL) += intel/
-obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
-obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
-obj-$(CONFIG_PINCTRL_QCOM) += qcom/
-obj-$(CONFIG_ARCH_RENESAS) += renesas/
-obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
-obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
-obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
-obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
-obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
-obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
-obj-$(CONFIG_PINCTRL_MESON)	+= meson/
-obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
-obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
-obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
-obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
-obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
-obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
-obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
-obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
-obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
-obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
+obj-$(CONFIG_PINCTRL_SANDBOX)		+= pinctrl-sandbox.o
+obj-$(CONFIG_PINCTRL_SCMI)		+= pinctrl-scmi.o
+obj-$(CONFIG_PINCTRL_SINGLE)		+= pinctrl-single.o
+obj-$(CONFIG_PINCTRL_STARFIVE)		+= starfive/
+obj-$(CONFIG_PINCTRL_STI)		+= pinctrl-sti.o
+obj-$(CONFIG_PINCTRL_STM32)		+= pinctrl_stm32.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
-obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
-obj-y				+= broadcom/
+obj-$(CONFIG_PINCTRL_SUNXI)		+= sunxi/
+obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X)	+= pinctrl-sx150x.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
+obj-$(CONFIG_PINCTRL_TH1520)		+= pinctrl-th1520.o
+obj-$(CONFIG_PINCTRL_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_$(PHASE_)PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
-obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
-- 
2.53.0

