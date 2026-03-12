Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFA3105A591
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4317C8422D;
	Thu, 12 Mar 2026 13:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EAtNkI1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA66B84137; Thu, 12 Mar 2026 10:00:04 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F878410C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+FrI9lLkHh0NGV8zlpb8QBFgGSdG9U0yL/CXGYcnmroNjRejRrtuJUA9C5DreOKWleX5NWx7/PWv+9JohWxpYY22KzgkwDbQ+FRbAJNoCJe5dfBO6J1iX23xgFE1UT8NdAbMD9WKSLqu5LRkd0L1bF6SgOZLkeyWxtM3mOGTdMtHofIXMAhKjROuF1o3LqXjE+ScB5xthACDkWHMtzm+yCkd7kEnddcTruyvhVuBtIv6dC8d0DlcHZLTtwXy6tC6SdhCGhPO1Y2VTcXuMw6p8XnBTjpEQmoduGJJ67BxwTcrygY4ZHKB+J5jysLJnLWDdyxrvLg9sUHOCK4z63cRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBg+Zo+CLrgzSyrWqnf1wl/zudbALV5e98k/BKebvi4=;
 b=gLgT7d6cYPjIoEpI7LaVcVl2iVyzWnHCuPaEhB6kdn96ZJ0imyLFlBXi/EjLor6lifcnaVpEcmkvv43L1IRlY/xOwZ688BgG+yaz17tO91s2qV4gSGrs0pkMmG5wwhdv12OYmuvr+piRxstTI5BLorGpkWGrktOwRaWzvFMc16GFNyB/Zil4ZZATsvtLI4K+iXs3GzumSkOFwJjdQj/Zl/JapbS9cHWcOEPxwcxbSICmaMrrWRj33gNdw4AOkNvuiZktDmp10cfJVJIjYsxlYj5G04VT7Zdrwvh/tFRwHPkuD+jIpb1HQw6I9gZPJ5eCeLb7SAPaAApqhiYTwECxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBg+Zo+CLrgzSyrWqnf1wl/zudbALV5e98k/BKebvi4=;
 b=EAtNkI1R2xBc4k2aOGyDZzl1IJH1TqJ4KicMQey8HwWMSdyS/+npLiAyHkUfM4aODFGY38Moh8aCtqsAJ+fqewNXTzy9mamzecgPZsEYo6kFOpJcvD4kVunNdlcUxTnT3REK8VOQgVner/YRu+XTz4arPzmQtkwb1XtnOuHg6OKJOkFGmfcvIJxvrz+B6KsMguWUz4IfA5n8bB2JUo1Yc0ubo9g/zwRaZDp3PQo2dXyIMz6cq92uw+BbzeC7GrMK8ysFC8NfYYSHk6e5hAFRVPANPOFh/xmPtgQZNvZ9kOTBpRoZzKWev0UJtPtX308fXbUlWTsdMsYJarbDa9TvPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 08:59:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 08:59:54 +0000
Date: Thu, 12 Mar 2026 17:01:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 03/10] imx: soc: Get watchdog base addresses from
 device tree
Message-ID: <abKBA7LTRIWqUIL7@shlinux89>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
 <20260310-wdog-v1-3-2ee21e890634@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-wdog-v1-3-2ee21e890634@nxp.com>
X-ClientProxiedBy: MA5P287CA0264.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 477273c5-e2da-449a-d6b9-08de8015ba65
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|7416014|19092799006|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KGCWQVzInXGYk0BwrVJcOj1MsHgvjjBUTXWllAKqua+RF5W0yrlfnhpaqzf22AT9inJtvgHUtKAYP5Uf3LawSIvhPxZnPCAFDHuvHFqO1c3NqFOE4f3RbGspxwV3oOta/7JLnxm5KB8iJ2pJ7+eXrNlpamdqeU8uFMxVGqqwa5nJ6hpSebS/AWInGw9pZ/sw79jgb+/vrpdg64UNAiUhcxt7FU3WqVTMvtxcbE7iUS9TRkYWCWvvb1CSd+ctDeiX/r0lxnMzu9YDqotR/KeElfGLqTj/Cvl/0IKIDEyOfdWkj9iWKTHifGFczUPQ7Z4LCTFdW/oJa7yQYvOyoTAOJ5oW2vwt60udLNhiD8jrXhZ9n2RM7BkF9Hfh6GRokl91YHd3sBrl026G+r6yG5SlqyVoXe3AuTxTkRWj6WWg3Rf+pLoJ5SvThovpXz+XWocYHDONN4Ticw2+HeL7Rw3gTdGmGaGCqWNvsqCCTvqZW1f+9v68l4JhWFRMm+i5mzmQab9XzWDyFQTO6Rw3t92JOM6kYwcdHB/4ZeONr394vuYCxnBBLbD8T/mjEaHmrHgH7fvEfLTWtcKzdI2RSN/aKpTHihruGQ5V81aF0xqBmB5KNZNfLzCRJqDYW6cvtzalu3sOwFdslsFkd5cQXCuJKOvnbhv3ZITm5EkwOf4cW+olWa1oe1btkkjvFzZzWVI9A+zYrIWjA4dhu3uh1LnvUOygWKw3EF8/B7LX72RD+s25v0CtfFr8DoGN9SqgH+OF5rQMjlxcUZX729ijxAarJJaMjORwslUDgXFZ3bKpg/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(19092799006)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJ+AKSbtqspJ3zgzncQl8tpoxBPWZRJU0v710G1TTmcpQWnOZaHsfUKdOEnV?=
 =?us-ascii?Q?xBKXILf7S77zhogkG6bPRvTK0FfVdBLoqFLWaUEYvDezz1dIO67S8zIKnjPi?=
 =?us-ascii?Q?DAwUSl/hCb11YuZTnLOtJXhiAho1iWVIUf1EnR+0qIMya12qQJX9iiSYvO+I?=
 =?us-ascii?Q?8UyFCy52Qjf8GCWFUdOP6gjqODPco1qvSthzdL8uoqamZsDiNORn/jpyvQ5i?=
 =?us-ascii?Q?x9unHIH9KLDYJJOpit9QKccCcxEhqHtPCMpZIy6YaTacu73j90aLLzOTIWAf?=
 =?us-ascii?Q?Ks78GmPnv/xwTkDrD6UjV2u6Sk1sYZyhug2E3UlzakPlbfYx3rOvtjw2kAEo?=
 =?us-ascii?Q?gfFzQ04r08oRRmxO/bgDMv/yt2cmmvoUoon1PRAB7VxNQ6keuiNIOjuy7MNv?=
 =?us-ascii?Q?me+GMyyRZfKe8Q0ITAD5TgF5XULKk8CLWH8bHRc6KuYJ8odPoAQKUPxub76G?=
 =?us-ascii?Q?6jJXnfbbx3SGAE8NQwsOlLK7GQ7eYvPhuM3BPxs1jTAmCut1i4Es0FMe/2bk?=
 =?us-ascii?Q?n9FJdp4+0uMPqEENsHkqLbAPE72lFaoBI/HH4Q42iwYwTe8a3hBHjW/HlR7o?=
 =?us-ascii?Q?yzyCRSQmQ3vlNrK+dPNX0c/9rZbrJRCIwYgAab+52GjqUDI0hX2h+RocZPbI?=
 =?us-ascii?Q?mykgtxMbj+zIbHBt2OM0S4zc4eB6fy0VAJfgdrcvcEEQND/IsKrf7kSvHZCy?=
 =?us-ascii?Q?muWqHIuZvkVvjAFYC48FGW4n75xpEL9Pd88mXbJF6nLj4HXAAjiBFi+m1Y3N?=
 =?us-ascii?Q?SDtBr0f5qfzDRRBldXLUzGY/FZQg63NwUjP36BfQ9dr3HaRs9+cgFGbQnNuj?=
 =?us-ascii?Q?5i/85NzmMoeui4lvTELFqM2sloPXWmUe3KaWLa97eGy30Oiu67lalyx+YUxh?=
 =?us-ascii?Q?uXNbiz9qUen1tErRaf7HA4sDXUPC12TZkE+ilFJFwNE+2JX+hYmj4A1CmKKK?=
 =?us-ascii?Q?h8Qo8aBV9ujVN2LCZrdxu7NP2blk0sM4qH7I0cV8CBJ04mNYwxy2k/z3IesY?=
 =?us-ascii?Q?WRE1cbNHF129vVt+yU+VYpfvkb/w0eFZAWxQ5M/z5rLyHCZKd5R7qRjyy+kk?=
 =?us-ascii?Q?HtWOPkyZOzZ4q0+SUMPXspYVKJHH/GZGm0pwIBu9mlQ8/Lt8bPtuio6VX/6O?=
 =?us-ascii?Q?neSlhMfcyh5kXl1vhj1wg3odbgvm/TjLEi+QpLxWENUct6uvaLwp+WbvwajO?=
 =?us-ascii?Q?ieK22VVo6anheBKW6SVoAzuHPViZIzY+jfv/j+DZztZFuxvk1/gCVGkpGJGA?=
 =?us-ascii?Q?iD55ULIWMk9oSOGvmDIt6mwzuVgTsIFEIpjVkoG0YS0XBUeyCv0BP+GLZGDp?=
 =?us-ascii?Q?b4SLcQ/a/ESZ3vT5hdgS8rgMCQlANaBuJd/Ug4lzUlE4X3Ap0Uj+rCkRNyp7?=
 =?us-ascii?Q?4zMNOGiIPVhjBYQy0KXDRxyj1mDZd6rfuGkxdGgZvUxdcCqLpAMaNlvsS651?=
 =?us-ascii?Q?85ys5TefdX26/WLZtpP8THYqREs+50hPh+AtmyMy5oMQeyRgVkRjabtudwQr?=
 =?us-ascii?Q?S8Cvjxgps21gehU1RqVuLNpnMf0FSTYU6+jMnTaavr57ehOVEpelPGMzZ5Vf?=
 =?us-ascii?Q?HhBe6gC1/U57alSgccZpg0ymJ7ZbJDN07w+vZoB8N4WJRHM2YIEayfoUg0EK?=
 =?us-ascii?Q?AnGRDZtz/ZGrwmxOcGZAlO8HazbiexDqUUdAuDilMhMqlP0LJTVNyP7gI7dO?=
 =?us-ascii?Q?krCCt8YdjN+nebAmjkq/+vJCwt/Yoxaa/G9Xhw3m4z3Aurmzam9xHjOV7zi0?=
 =?us-ascii?Q?AHmPmnfTmA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477273c5-e2da-449a-d6b9-08de8015ba65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:59:54.6226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucYtFHWtGz7aYEbEvrjdHEFtO11GQv4peodjJlFo6/3UC1zqqoWEb/n81mFlNK3Gl/OdwrzV3mJJzZLAZeI3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:43 +0100
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

On Tue, Mar 10, 2026 at 03:53:37PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace hardcoded watchdog base addresses with dynamic address lookup
>from device tree.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/mach-imx/imx8ulp/soc.c   | 15 ++++++++++++++-
> arch/arm/mach-imx/imx9/scmi/soc.c | 16 ++++++++++++++--
> arch/arm/mach-imx/imx9/soc.c      | 17 ++++++++++++++---
> arch/arm/mach-imx/mx7ulp/soc.c    | 16 ++++++++++++++--
> 4 files changed, 56 insertions(+), 8 deletions(-)
>
>diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
>index 1ee483065e8..081ba9d60b6 100644
>--- a/arch/arm/mach-imx/imx8ulp/soc.c
>+++ b/arch/arm/mach-imx/imx8ulp/soc.c
>@@ -341,9 +341,22 @@ static void disable_wdog(void __iomem *wdog_base)
> 		;
> }
> 
>+static char *wdog_list[] = {"wdog3"};
>+
> void init_wdog(void)
> {
>-	disable_wdog((void __iomem *)WDG3_RBASE);
>+	fdt_addr_t addr;
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
>+		addr = imx_wdog_alias_to_addr(wdog_list[i], false);
>+		if (addr == FDT_ADDR_T_NONE) {
>+			debug("watchdog alias %s not found\n", wdog_list[i]);
>+			continue;
>+		}
>+
>+		disable_wdog((void __iomem *)addr);
>+	}
> }
> 
> static struct mm_region imx8ulp_arm64_mem_map[] = {
>diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>index c1458ccca3c..692c6743418 100644
>--- a/arch/arm/mach-imx/imx9/scmi/soc.c
>+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>@@ -734,11 +734,23 @@ static void gpio_reset(ulong gpio_base)
> 	writel(0, gpio_base + 0x1c);
> }
> 
>+static char *wdog_list[] = {"wdog3", "wdog4"};
>+
> int arch_cpu_init(void)
> {
> 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
>-		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
>-		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
>+		fdt_addr_t addr;
>+		int i;
>+
>+		for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
>+			addr = imx_wdog_alias_to_addr(wdog_list[i], false);
>+			if (addr == FDT_ADDR_T_NONE) {
>+				debug("watchdog alias %s not found\n", wdog_list[i]);
>+				continue;
>+			}
>+
>+			disable_wdog((void __iomem *)addr);
>+		}
> 
> 		gpio_reset(GPIO2_BASE_ADDR);
> 		gpio_reset(GPIO3_BASE_ADDR);
>diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
>index 583c3a5a464..031226ec97f 100644
>--- a/arch/arm/mach-imx/imx9/soc.c
>+++ b/arch/arm/mach-imx/imx9/soc.c
>@@ -279,11 +279,22 @@ static void disable_wdog(void __iomem *wdog_base)
> 		;
> }
> 
>+static char *wdog_list[] = {"wdog3", "wdog4", "wdog5"};
>+
> void init_wdog(void)
> {
>-	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
>-	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
>-	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
>+	fdt_addr_t addr;
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
>+		addr = imx_wdog_alias_to_addr(wdog_list[i], false);
>+		if (addr == FDT_ADDR_T_NONE) {
>+			debug("watchdog alias %s not found\n", wdog_list[i]);
>+			continue;
>+		}
>+
>+		disable_wdog((void __iomem *)addr);
>+	}
> }
> 
> static struct mm_region imx93_mem_map[] = {
>diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
>index 5306e76223f..27ba8a37162 100644
>--- a/arch/arm/mach-imx/mx7ulp/soc.c
>+++ b/arch/arm/mach-imx/mx7ulp/soc.c
>@@ -146,6 +146,8 @@ static void disable_wdog(u32 wdog_base)
> 	while (!(readl(wdog_base + 0x00) & 0x400));
> }
> 
>+static char *wdog_list[] = {"wdog1", "wdog2"};
>+
> void init_wdog(void)
> {
> 	/*
>@@ -161,8 +163,18 @@ void init_wdog(void)
> 	 * In this function, we will disable both WDOG1 and WDOG2,
> 	 * and set update bit for both. So that kernel can reconfigure them.
> 	 */
>-	disable_wdog(WDG1_RBASE);
>-	disable_wdog(WDG2_RBASE);
>+	fdt_addr_t addr;
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(wdog_list); i++) {
>+		addr = imx_wdog_alias_to_addr(wdog_list[i], false);
>+		if (addr == FDT_ADDR_T_NONE) {
>+			debug("watchdog alias %s not found\n", wdog_list[i]);
>+			continue;
>+		}
>+
>+		disable_wdog((u32)addr);
>+	}

It should be better to use
fdt_for_each_comaptible_node or ofnode_for_each_compatible_node


Regards
Peng

> }
> 
> static bool ldo_mode_is_enabled(void)
>
>-- 
>2.43.0
>
