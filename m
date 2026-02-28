Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC573FEE4F2
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 15:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC1883F2A;
	Sat, 28 Feb 2026 16:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V0RLnI9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF7383E63; Sat, 28 Feb 2026 12:43:56 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1DE801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukbKRSZQinDz9m5MzaxtoOgHJ9UAxivfkcdZoino9V/6BobODVqXVGL+8FdoHHpNXI1gThiBbJYSPvZl2UYlKeIjCMXoO3LAGdBDdZAmEfE5XTHb3Lc77Wzlfaapv2MnGz99vJezJZpf2jJDrsvfPE7vEzmk2eoZid4tJhA3u4MEwzxFFdJEtHdmZ7EXWqmyr9yvbCeujFHqhX7Z8JBo8If8RlN9+2O0c9gLHl9FJhzxxMD0GPf4QY0fOJe7d9Oj9zt5xyRuxRZ2msDwoZ0+T147mAdZ89273+cI7QtkMY2tkRYVx79uM5kdip6kvgvlV3PENPTF2SA5VwzpzvfNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coiDWIl2JIRrKFymjDlxzuzQSrEyfdjAlsyAz6PTcl4=;
 b=ajZ7NZhN4BptOn3R6bHpe12A59rTOyFddJ0TWAUXlxYC1Kuxyh5Cc0BP+tmiwaOf9K/2wlNFA17AH2ZoohqWHCODgTJR5fnsEDKF11VsMTL7nI2nsNma65NFszQdf2TZnpB88Xh88nrTHcHg1kDqfvepksKboLkgYYerZ7D+PlCfgUUmstyEBHH9ldQfi1nw/s/nms4J5JhDx9Ub+tS75Jde5vcy5csY2/vCsBN7OVWjM/CbU/3wkQxjtEw+QBnRyKUql2VQsgtTwVt4M8lDBI84i4wUFESy0NBS2oG3Sk/14EvB63wX9mrDTJDfyETXd9iNT/MDDJkF81hwFgcNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coiDWIl2JIRrKFymjDlxzuzQSrEyfdjAlsyAz6PTcl4=;
 b=V0RLnI9KOKUfBmFyW1A6ltuvuIYdOi04Qv94Bx3/XjQx97rJKpvSEjI6kavdS8+aTbktLKZko6DiGlauIWyTVhUl5a6SaovtLf0tHb7OVds7InP4/aa8LFQ35Jdg793Y4UjPwSS8cwWOf8xXkXvj0OYnPtDJjdd2dbS2+IY/AoEqRoxI9WvnL1/5QCxWQRYBqEYnIwsJVe5EvmsrfLBWap7/jwGfnFpiJ8dePchKVy45qF5nTUoB0XWVAwdTxGP/WZ2TdHfUen2yCwZcBB+MeBUHXMy92Jh568hHqFroOdcYyQuViRCUYq5EhNQmhSQ91VTQAdcPeP6tV5kgxVj34A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11713.eurprd04.prod.outlook.com (2603:10a6:102:51f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sat, 28 Feb
 2026 11:43:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 11:43:51 +0000
Date: Sat, 28 Feb 2026 19:45:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Niko Mauno <niko.mauno@vaisala.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 09/13] arm: imx9: Skip WDG3/WDG4 disable on i.MX952
Message-ID: <aaLVZ9oRKtuEfICX@shlinux89>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
 <20260228-imx952-v1-9-0a360e7e8cb7@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-imx952-v1-9-0a360e7e8cb7@nxp.com>
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11713:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f9e827-90ec-471a-fe99-08de76bea4d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: geMNZzeo1YKdrvEntid9BwGQs74q/TevBd8vmLgyw0GDVrfzwxJAUDkGsitEYpJHJ3Qhf+fZ3aaCzfoxda7OC3ra6FrZVv4xN+kopxzsjR8JhDSzA5ogK1QDvMLpMAE47Zx3u3UgeDvU87I3CDwG4P2Nn35T74lHN84YZ1dwxn2zC04sOK7ISMJxdaJBkdgLo2FYOjxabFafiy+akScrzbMGAqYg8Gc5ZDMy3dyIyz8l3Xg2PMqCcfnq0jH8sxEc0/Q+AQ6gA3D1V3BEgyecaV28hm8BC/natlOU7MYdT6DzBFAC3dSGmYSxHN8E7Fc+D/2kC3hiyvJ7ekO2U+hhs/3SMdg2QAAf3n40rK+7liPZcVjp+YhGuqi7wh6A85C4jfKUjofvvON+rWY3v43VqanO55H0HZHrALFc2Hv0BlbQOa5Cu0j8kSyUkSq+atxk1EPD4fhccmEV8BTpecbXQETO7uRDVb5x2WR8x5VsDU5wy/FLNwoYL0Bat9utuL/nMaemyB6iKzwcvEHoh1UGlq/5+eUrcQXPVfznXZXkT5c057bBdrYhRZaCQBBTqyUoms/jpbnxrfdaXm05uiW5eksldhMDeYIR22yUf/0AFbSH/AC3dIdrKmV602LVuv0sRIKW/Q2zpWc+mbgC7dnNbfSRbD/opksiAW0zWVcZvkbwuodzlcplskjc7f8FnrtfD40RhcahzbSOSXWsZ5HPp4RBFArdaQMh/PdeNMr3z2NuTFW2Wt2cK/OHvsHFyF1cqjCUsMbChbXJKz119qfjMn8Z5vpGBoFXgKOKzahhSUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwD6LQ08/heLIij0rDTVjtz+M/b4VQ2wO5HNnJilqxGG7cdf4XY47imAO6S+?=
 =?us-ascii?Q?dsuQQnBIXLIYyTydDXdqdDBOaKf5mDY6XmKv1YZSScBb+LqYCi81wH+j9JlF?=
 =?us-ascii?Q?RcjzokxYh4Q0rCsW2nDSL0nt25nevrndRCKlTMfqxsfU535R2+37WT2mLdIQ?=
 =?us-ascii?Q?v/7shudK+JC9IKo4pZDstT7a+9N9mVG1PbmghuVqX2ZpUKdzectH55jPqXQl?=
 =?us-ascii?Q?jsBoJmImBXhpjwN2xGCHPjqKYwB1REFg4T6vyZrWlOgcEUDxJNnRnIVDZITO?=
 =?us-ascii?Q?dE6q2R6OX9zNmNQU5TOgk55XwXfkT5MXU2RXEofq3amgbbySkfxYpKefuH84?=
 =?us-ascii?Q?bhS4Islmnmd3Rz2nYczWBts98O6ke+SQmIpWyw6oiNw7YfiC/dPUqEAMZ0Ch?=
 =?us-ascii?Q?3r4Bb6rRZTXGCKpTdH6llOhobs9IHBJHYbXCn4yrfEBjjfSBfS7nW2BaPyIb?=
 =?us-ascii?Q?yXSLV/SQQfbL5xUm+q65B39lzw5Np+3YT5eD6FOhKfAukooX7k+dLOZMHCgu?=
 =?us-ascii?Q?uAQdiAtKRDHv+igWXt3dFaqDY4g74s/zsuJB5MjO7lz82R9+JoQSdtyHmbkk?=
 =?us-ascii?Q?g7OVxbvLvWT2tGphqjF5F8jClQI+sSHemckrz5nJZUPTQBIITQP0F5iNCkV6?=
 =?us-ascii?Q?G4XB4o0OnAqcWCVTX+ZRUyX0RKC/OqNAz2WVcHQklAsKoTCTEdzi052Qq75c?=
 =?us-ascii?Q?oqut785SFiwtEkYOT33mFqR4nxkvGRSsN1RyyaIwdqT9nDV1OFD3OeuTEqfF?=
 =?us-ascii?Q?DC+yXg6vvP2cN8hBA30kIP45J4GulTHPcdHUblwdTespqNo/1eHU8g0tWecb?=
 =?us-ascii?Q?Vkj7PDf8ksAteozfGpXdMMJjxEsV4/RlB3nxWa627R/Qw2keREkn6Dy8lmN5?=
 =?us-ascii?Q?fbnSLommlDEhrSAouOVvk+ket1We0OznOHZh9phCOBjh9R1RpoCGSt4zAJIR?=
 =?us-ascii?Q?FGSteIhndKI6/DrPl9EMgY+Ce72j1scSEZ7IBUpMNc2pV3KH/VNNdpc9AERO?=
 =?us-ascii?Q?QQIUE3x/dWqflSIu7lylx8CFTs3ccwo/nKGinUO4EuRIqTGTAI3t5Sj3kVZi?=
 =?us-ascii?Q?VJqFJmfbbjXR5nW86ZL/n3u7k4suQBd6hHZwGJLWn9s54qPGRW/QUkNKcBo0?=
 =?us-ascii?Q?Dq6iOnfpTdyBYMM7211Ypjt+cLeVCF0Qfe8gAQeKSoVI+R0BQaaLdc+6pb2h?=
 =?us-ascii?Q?TcP5iW6syPhLtmVU/1IfP7YxfcxPWsMItPZXyZkAPPeaBHeSL4a5qvWUWrCA?=
 =?us-ascii?Q?f8vC2aoZermBQkZUaVfzFvOxzqYR+rPkKBdEDitBUGS/wGFpcf0GRdeZRGP1?=
 =?us-ascii?Q?6eGPint/AUeqeGDu/mh0qHf9+do874Mho9af/1C5GaIfiwQBpj2b8urIZAbK?=
 =?us-ascii?Q?MqW+6dI1jUnpYJZrjD3ZozHhesuNRThFnvz3F3wKa5iu/hbq6mL3AIQEVbiW?=
 =?us-ascii?Q?kc4FeX84l1d2vg4H6e1iCj/cbDyHHQVAkS/UXcAPelz2MtHvyd5Istq1rRg/?=
 =?us-ascii?Q?FBQwSsP3L151gcsKs5X3wmvw16JgtXXq8ERIkESIW+0mcqFila+MaNPPmiYX?=
 =?us-ascii?Q?zdhabEWYeSsGLxpSDLa8373STJlljMo9XEz6VVbQFEQXdT9M7y/4xSeigeZj?=
 =?us-ascii?Q?e6Z5SM30/l/tLl8MTd7mT3MkqlxM7RekzlL4A1iaKGwgu+Ivb5sUBLLJflSZ?=
 =?us-ascii?Q?CQtaQhgTg7VK25WpdMcGlx3y+NYyq2GVR/zS5xKgxcDgrZSLK1eILkvccj7/?=
 =?us-ascii?Q?rWz6lWFlcA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f9e827-90ec-471a-fe99-08de76bea4d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:43:51.7665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0p8/MU7BZjEv39D91q+UxnC9GbFnlMZfAIVIevSMflSaaV+Oi9filRyXrvosKwfR1gujqNwIkPrts3JDTWFbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11713
X-Mailman-Approved-At: Sat, 28 Feb 2026 16:59:36 +0100
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

On Sat, Feb 28, 2026 at 08:22:27AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>The i.MX952 uses PSCI for system reset (sysreset_psci) rather than
>watchdog-based reset, therefore watchdog configuration is unnecessary.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/mach-imx/imx9/scmi/soc.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>index 538190e23b7..67898012618 100644
>--- a/arch/arm/mach-imx/imx9/scmi/soc.c
>+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>@@ -786,8 +786,10 @@ static void gpio_reset(ulong gpio_base)
> int arch_cpu_init(void)
> {
> 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
>-		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
>-		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
>+		if (!IS_ENABLED(CONFIG_IMX952)) {
>+			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
>+			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
>+		}

This seems not match what you write in commit message. Or I may
get something wrong.

Regards
Peng

> 
> 		gpio_reset(GPIO2_BASE_ADDR);
> 		gpio_reset(GPIO3_BASE_ADDR);
>
>-- 
>2.43.0
>
