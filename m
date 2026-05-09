Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3846CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD5C84D47;
	Sat,  9 May 2026 13:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GOCgaWKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA84D84D24; Sat,  9 May 2026 13:12:37 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1444184D47
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN6pNEsvMuVHrOmTVb2/sgzdzIPBwE0Uauz/o1RrFekquZAVO0ctDRzOmsJmwJ/FZGcAsnHmO0S+eioSHm/F95oXMB3lh9HW55pefxL8MiQwkJ+ZI6PIFYK8PeEPI0PG/RyPs+eMuMCb1gfIvfHUUkzTzpiQ2ZdgPrKpXlFDBokqlHUNcxjj0+0lqGPLOvBWKKTCSjuG9zwo1ZXlQi1E659FYCNhzZ2Z6wDi2yVS8hRgxVI2+jZF4qNoSEoynC9vBIhjb1tXl0IzUT8oKL8UVgFtn27+rzhGScfGrDv28n4CVE2Av2gKNwJCVSswkHAnHLMy7+UZPZXEaU7AbpWvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ/p2VJ5wGw144PYwP700WD0CX8ySgrRbmsOHjcFJJw=;
 b=Z85sQ49K/jhHtythi7cJd0aSfP3V8UnU0Ich7CAnD20Ecglk+YGGVcaZ3E7MjL92HtG9U3EdgoTry43rTn3qM4GNu1SFJfOuxotaz4mu7fuFH+Qf40Aii0rGkPXVE93ftTP+e+FO5sX/eDc249k8GhsN2yeFookWD/rOJTwANoJkowhEmdyEIIGt7ywGIoIiRyamxC1sHWy5VwZCTG6WmWx+3+F2Ax0IqzzvKkEX5+3/bmTDYBAN4C9cNNyq5/jdmiqz+z3IN0LWpRax90Nn9EVQRaoRMkW6AjzEt/hHwGaAQPUZELjT7sJN1qqDqXpwX/b+2NCdgCReXO2PjPqk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ/p2VJ5wGw144PYwP700WD0CX8ySgrRbmsOHjcFJJw=;
 b=GOCgaWKor7YSnG1CRG4ZwHCENgdhAA01jsBvUxeifElBC5VhuCe7L8MfND1VRBQq3kXo91MDiCH1fQStFQg/fLT3hMjL96i4XWY/EcBJOeiei5+HTrs2TW756MRSGdCzF6NeaJ1WV8awJF73o2v2bQbcPiDaNrewuoOSaJFqPYR870qkgS0aPmAjFTkRUISotd0vmZzqC5XHdHeDxEwAW4ZxVMOWAEb/EgmXE06nsAsghpa/H3XAIjB2APfxRA2aN6lLr61rN//PvnMy0k49coxK9697oVKAeqLT4U9SrDwsHHTakemVJAaQVGVtRk+1jBCAE1tDbuwhnL8mC5FnCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:33 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 10/11] configs: airoha: en7523: enable pinctrl/gpio support
Date: Sat,  9 May 2026 14:11:56 +0300
Message-ID: <20260509111157.4039434-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: f7360b4d-fee4-4831-8200-08deadbbde2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WcVR02j9ussdolcFQM9whJGdD/oKi2G0NnXFtqRXStkX1J2WhSHTFu6ABeINzQyd1r291qhyakDovblMM3XAMj5GZUH7Il+AWBEnoVwfzOcrImY1v8i8ozFpDbcfB0qlCwcwNbeY8qUzdbPnQbazT8219O47T8ZQZqeNaSe2VfqH0rqKzrvgbk2tOV0ZcEOjwyGxxqIyxbZSsKWERXmnOw63HKPdCFpZTp2P0NdAkgbnZmpyl0HIqqBQUM5jdgJrxRL0vlkFlcyd1+Swkr/j4VwqSuxsJ5DNahFpSN4MDY6kTmm9OOdNP430IIywEMRUqc94uPRRKhzUeGrYvDazERIYDPf9HWZuS1E7jch0vWRy4AIqxgpIzssjCWZhCAntag7ND74AkiOG+vdRmkQKC3P50LtUjSUPuRqHFPZZ2tFPbvaupF725Rj4qKyuryAztqpBGVAZDwNrw6xlNhJQZeTHrVc1tbnIaCHx/1hEXkpMC826osGaWmFZQnU9JHuIwf1SqgnbdZJFSjxUAHYCmyQlex7izv+Y2DHt+ImIqkVFht9UTN1Z+odo5ybu7BR3Dwew3190hPLZ5hRUcwB3GORK3oehDn6b/1FJRafJ/tzNPjqOXpTdTl+qn5//1461t73pgxW3R8zGnPXZafH2kifo+tKzrkDSFKsb/M3/2xc1fY+dC72sZIDKtEnOCXuFTL/4ZylU/jY6IVr2M4Q79lmELSUfmpYjmXZi3Niu9oQUH14ZmR/ZWQseor1lo0LBgA6I6AL3LfkcE9D+cMumRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/23N5U3YuXw7pgne8pkR/UE+MlxjwB9zgswzcIkbl7KEY5OqxHL7IKEnqEb?=
 =?us-ascii?Q?ExE5YlC6HGN4jV1H0dNC627wVVdbkZA/jrjB1G/CIBPSiVST8vVjrlbQ0xQj?=
 =?us-ascii?Q?oU6lOq6dvwGk6snEJ/Iaf8ZuuezbipcsY3rsZgnBQX3CsqdEsiEzzh4sGNvg?=
 =?us-ascii?Q?7UlC4fXByh1J0/t8AoPahnajl5/LEnnoJGrx/9deLeh9aTS9lHKIZ8xIA/Zn?=
 =?us-ascii?Q?kag1CU9jn+5mbjp7MiRTZx8pzXqQLSa/Uww+/1356C56FqrSSHoYxXwXvlv2?=
 =?us-ascii?Q?LY04UUI0xCvWl8zIXuLftdmX+S48WaEYdJufvkm1Qx7symy76bhEtXAFQJuE?=
 =?us-ascii?Q?2IHal+8qnm7vJ9/jlFYxUU9VEVd56+8cm0f5o+kupG3fqHKlJ3iewbXEX2kj?=
 =?us-ascii?Q?G6sQM0ZGOx18nE7aszc6/rq3stwhqK5OxDiQUryAKECQq+taqjuA1fRRc/k3?=
 =?us-ascii?Q?DM2VBkeb0U9bTOInkPIgKqQLXyIpmCoqnT+HyfpdJZKPz+RNkOceUfz3ML5x?=
 =?us-ascii?Q?EW0IrlCteF31Lh1+/+ovPpocCPjHALowdxVX83hA3KH0k2nrIsAG2DNI2iEb?=
 =?us-ascii?Q?LZ0MhUG8+etk6hzrZaLc69re1IUF2XOD/XZ/YuvGlJCd1hG0aXO1eCqVYJ6f?=
 =?us-ascii?Q?TY8GtpNfzoR/y5CL9F5zRz8oUFhr7VnqzPoXVVdMW+IRZu837Ee5Z+ysxcND?=
 =?us-ascii?Q?iQ4Eo0bzeva8GRK8o/AQhaYHIt8xJKdrLkfi6p07s3Sqeqw6YFA3wgy9gawv?=
 =?us-ascii?Q?FiBMB7brNExYpV0ExrAS1aL4hWtsNiG4uYY5tYfxECPfXaZXDCqomKzqajDs?=
 =?us-ascii?Q?k2vFkgovgxmp2HaNRS+9jooWKwvo/C78+XXZ5gbiPgARk054xh0mXIPq/hRD?=
 =?us-ascii?Q?DU+oK8djEfufHW4D7zIyCJRQXNjC+Q006n4IgGDjlvgF33tCzwPkull8CqIq?=
 =?us-ascii?Q?Tajg+NFn7HD+wcCrYq4aAhxUEJhmhlz2TWRs5Zuf/GynWzaDAiLa3d/byRiB?=
 =?us-ascii?Q?+ErT06V/eeBDiu2LqU5cgPnFpU7spEp7jIpCjHh4tIflEmkCeUKH+UlabGE+?=
 =?us-ascii?Q?g3VikPHnoFGQnEmrUqbni3tv23lnNZxNiFTRaPZolGilGxzyHCWi6o+l5lAp?=
 =?us-ascii?Q?q4dj3dqtbEZ7oXNVx306fF/ixTg7rjP4sXAl0bqjWXL4OHC1RG/vYdIdJYuj?=
 =?us-ascii?Q?FTw5gLVKnaURiwXbQXsn74SIZCoF61++IHaaBUhn2dyHwOQ8kwvGgIaSuojP?=
 =?us-ascii?Q?vVqMQTR1EZQAMxqIBAgUCnZ/QvURy1xYs+s3cXGX9ODXd2tCjjLk9OYTEk6i?=
 =?us-ascii?Q?L0o4k67SjWaJwMgZDaoVPHESUaH+o6lbl0W8OrufdlNVmjYKS78okOpm++en?=
 =?us-ascii?Q?YCG6yecDFjrfTdgn/auOIMgebuPnIg531Ea+5JFOb+SajiNWHs9JIOKURfjT?=
 =?us-ascii?Q?GWJubW5y0Y79ZGknZPzMUIT/r/5VHTFHWUERgXHMoqzKqXVwIrGG7XZwcxE/?=
 =?us-ascii?Q?v5zzoa9NeF3qEttQ9XHcAN4yCbCYPJTeDhuHwwH9W953WTjQNHCDhQ0WpYSX?=
 =?us-ascii?Q?/W6CaiKyi+hIFZ2YToEGeISoSPNpvrEz1jyiL4nbAfNzc+rzxm20bPoh7Jzk?=
 =?us-ascii?Q?uwhvtYhG34nZc+KGyptxMQqNgYWIa7YMmm7rdeiscrRn60KuCsGr4gvcfT3R?=
 =?us-ascii?Q?7uUMen/S9dwwot0tB9s/GU/U5iGcXS9Iq6N8hEdHTCy4+x4Bp1ML3iDNRV9H?=
 =?us-ascii?Q?vkM9cw67iC71YWapiakECrVJGTe+93Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f7360b4d-fee4-4831-8200-08deadbbde2d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:33.2479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIgs2xNyGZH5MDo4AEeYmUuHHUnVH/AjKmu8RnX44bLFZFP40aktZTCBvz609Z7p/ITkpsDe4wFQjYSTMZiqUSKSN9OvP/outUqia8Ioh1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 381d5d05616..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -42,7 +42,6 @@ CONFIG_ENV_MTD_DEV="spi-nand0"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_REGMAP=y
 CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
@@ -55,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

