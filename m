Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADFFC43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 02:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE0A841F2;
	Mon, 29 Jun 2026 04:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uLNhJXDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3391D846A4; Mon, 29 Jun 2026 04:00:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3168084105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 04:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAst4KDqYAucDaCQCOHhJY7XPttF1DenPG7tU1g3/o4EKsHS49a6PGXnj6wFTZRNjzq5QwBHlqD7r1OnePzRGzHmKxrXuzoMPyo5D2AiiQIAoik3NK3WSfrdAX3dlPyLNtMR4ipKp27NgoyPLq2/D27OUaUWxasakSTbKtM6ZBbV9myxUgTyGDxxPqH8w2Sv/op22goegzTrg7A/99uCDL6ZrVObsz4R3B3MM0DMOGNlwspj/MxwJ6pNq31HM8NkFL2ZN9RjHzqyrcvGn3g4kOdMxq1/wKJwd5nYxRGyWUT4EX7JqFn+SvrN2jUQ4ZyHQTYqLb8Gt87E8G9ESRuAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T9YANlrjwmyRBLcV/9xedTbGXhySDfUOyLPiraCPUg=;
 b=Ie396YEUZjMWHw2uPt/XlyMC0rspZ2JRDtKkqmAQkxGL87Mf5gnbx6R2Jq7M7OD4xYYhoyamQkmx6jTP8UMleXOPBSfLrnE8O7tem2yVPzhGOHw2C/pIQaYhDaQvi1d25j7ewDWwUDvIvp45CZOS3DdOLdl0X29+4cvfWo9Nx2MPObR2ylGR77dRnuyIQAJ7xtPo6YXf3DYc9rf8FfgJEWjFtOzNJedWc/xcthUGs+NaLxTkkWy5mlNDVnXURVfN8ND9aDoaGRkV5eodSl0jMOrM587cBQch+QuCkZAjaAZeUGCoVI4sIXuseqgOBIXzoyFzzXoBUdFPidc8DYrzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T9YANlrjwmyRBLcV/9xedTbGXhySDfUOyLPiraCPUg=;
 b=uLNhJXDe5hofYJIYtMSBMnNlSHhj163w1BHYFKZWFDw0UU4S/J1CLDOCYtrQBRROHJpljbpXLmG8mtIdXa1LMIV/CZzHvIVUS6EZfsGiHhtPfcIpj02knyhype2/cXJE/C2cvddbeaxv8Eh7oDaSAx9e9KCnL11kjN9Qc470fSCyVIH1DAJXhx+cGczE2JnVQj2hw1SBlP7nO73RQ1XwndpZR0u4JegoB62sD4AllmPMX1TLX5bYJE85W1gqy8injldkJVrvfetbww+imko4zRkKNXP7/9jTAvy9uC211KTQ9JAWseF4MSokH5Q7dQiS1vWGpx7qsQpcdA3OjeW4hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7263.eurprd04.prod.outlook.com (2603:10a6:800:1af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 02:00:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Mon, 29 Jun 2026
 02:00:09 +0000
Date: Mon, 29 Jun 2026 10:02:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, trini@konsulko.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Tze Yee Ng <tze.yee.ng@altera.com>
Subject: Re: [PATCH] Revert "mmc: sdhci-cadence: trigger tuning for SD HS
 mode on SD6HC (v6) PHY"
Message-ID: <akHSUfUHLz4L7fvG@shlinux89>
References: <20260628185752.1504-1-tanmay.kathpalia@altera.com>
 <6f745e04-2978-4474-940e-4cafd6f61851@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f745e04-2978-4474-940e-4cafd6f61851@nabladev.com>
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 78aded60-fd8e-45d3-3970-08ded582260e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|23010399003|6133799003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 153dULM/4ebAcQfVlxcZMdkIZtpDCUb9H86++s9wEzlh9lg8dUoBCsqHSVGmXWqtUVNM+FPf8BOjLx93SIN/6oOlzspFwU53zAdsIIusL0ECMBniyoUHxmXoH6GPcQ6LQIqpDKFkiGV9M0ZLNQ77qB7qhrYQa62PGU/dFZhvQmzaJh42yDhMgPU0SvHY6ghkCNUitej1rMvn8I4jjPqdY5+vNcdWP0GHXkB9YeDT4UWCnP6k+ytSRU75UtcE6oayck803Apx0x+AQSgkQ/QJg1BzaFUKdjFXXTdqzKyuIUdBGsGHsfhRRJzEfgHrm2UygyeyoyatGDkVDG3egtjPCm1qdN7uRVWhN16Oo7eoS/Shh3pm4KUPVb1UzGhaKBJo9LgnVJ/HPqoDUlOhaHRibkbezgJlgyvTqlIVBXWq3CNCzQh8+e3YdA6bH3iAOYujuWAGPq7aEI79g8Inq5ePyvP91sgR412PI+soD+XlDra+bCCHxKqYyHxwuwPMofIYW/+bEx+0/Cp6E5letFT5vI7oVIekxEyY7rWEhX47rtvkWrRHOUOpegcX6Nszl4CUc1+ONWtKfB5MeydjqbpWBC1slVsq9hihGoWww+b+ij4Y5jQIhzIbKaMcyuCu8hTlm6QD93RhPKWL+yRU477Zi/PGqMTK3fdzELM3xSE+M/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahlopkaUbehAhyHSwwLHoYsapK/tPk1LM4VAAYfZZlSHcb4yxC8AnqxpxppB?=
 =?us-ascii?Q?vw6yxGv9O+V0vnKlXgKAguO1BmdcwOXwdmFb2xz97Y58aAiaeXtaWcsctZdE?=
 =?us-ascii?Q?9ks3M8j7tfqjN4N1tNsKIcPRrNLAN1ryWZYvgrtuXkC8GMOBwMfelwoE34WC?=
 =?us-ascii?Q?5MQ293oZDqOs6u3TxZ7GxN90T/4WIXi33WTmNK+FeTN1E+2/tMNmjk4scd3j?=
 =?us-ascii?Q?YCv9/XZn2SxjMMyI55QrQnJONFcDIZ0O3CL2uUqlHLVvF85zrKfRRR/rTz62?=
 =?us-ascii?Q?fjw3iMLCEtESEsVnBviD0QdMsHzJah0ctRkbJL9fIMZ/1Hwd/Bk+UprFU5z5?=
 =?us-ascii?Q?qR0y9f8RotqSmSMvgO+GJ+UrQHk8EUk0Q9XAVt8Xe0KdFbC/lw+6GvLMrLOn?=
 =?us-ascii?Q?ak65ynKoFYTYtfNjjWCHXUwfWF4694tLH1QZwRApYWKDB6CIS+tOvLZTr76F?=
 =?us-ascii?Q?jluPrj8+tAKT8z2eloxBi5Y2S5+z+D6rhApCpF0lx3YZ8+uhDk1OIcTsFJsR?=
 =?us-ascii?Q?C3xsLy95KBm4rhn9Qu+KElxpAZ3I+u25jOiaFq51nii1HN8GgZpl2JrXJtN9?=
 =?us-ascii?Q?XRbc8b+w7tlc+bM78m03XfoW02SD+nxz9097imUu3r7yWe+8OmROeO2bw0of?=
 =?us-ascii?Q?9YrDQ7ViNtJh5Z1QMYLwt671bzoHATB/oo0S7qOkbLRxI/Gto91b3GGoXIju?=
 =?us-ascii?Q?gqV/aFmp60EKnm+besAWMd4Y6gSHDpfSTiF4Aj0ZICoNoNvMW7qFYKVbBSO9?=
 =?us-ascii?Q?brteYKYaFB1wwDbXDBGpg/BUXwg2rRLjRISYUjwc1Fg6w5uxF/Cj9N/FV74a?=
 =?us-ascii?Q?Kx+t1LwkTMhpeVU5XgImDIw3a0SDgxA8xbV0oIY+rFPcnjZ+ncqPBuyNvCNM?=
 =?us-ascii?Q?iuxYtEosdAZ683bNy2kZ4K8YTLmDc12JH9dTr/+6IeTARo1HOHh2FZ9IWq9j?=
 =?us-ascii?Q?qtQXTKsJHwcCaP78Ue2S9jUdjBtLS1XvXAw9mKGfO/vSNOItjCnhMulHptJN?=
 =?us-ascii?Q?o8uLfxDuDQli16WzJzp36jqtU130gBz5DGwFPhe3Ebnzc8kF1YKLufEnV7ZB?=
 =?us-ascii?Q?JOXGq/Ti3ROT25Rm4WHwMecti+IrP2G/EQk0h/LFgglrA0nmubK0zLCMmZaG?=
 =?us-ascii?Q?rAN14P1VZVQPfcRFsqfPlqyzHgvOhjDT3SCyUw9AyM8yAxjlhI+6F33OOOXn?=
 =?us-ascii?Q?XzMUeT80BjQQvAM1cFc/0paa1Saq2gfSE+KxgDAWaOaVplYaGESEPiqCpaow?=
 =?us-ascii?Q?gd6F+e7uw8IdnSG1RD9shghjT63eO/sa2tj7v03628WiiC0v4+qX3poYC0QE?=
 =?us-ascii?Q?ZIzAiIq5uwbC4dTw6HSGHIPhE0mNii5/zDgVkEACyhFdYgbeXiivMEovmjqh?=
 =?us-ascii?Q?TAO9SSaw13yOKNHzwfWP+RpDO1I/uWQM7wCTeOTi8l51u19AnKl/HywBpQ8Y?=
 =?us-ascii?Q?e5sbhu+MWUIEyZVcuu3MOYUxX1t7eZsEyt1aAGhjKS7sOkVNLV7reKec5m64?=
 =?us-ascii?Q?zExfX8eAuHulESKPXdhmmhNYorFhlQ5Di9kns1JCbsNox4AtHoYYypTqNctS?=
 =?us-ascii?Q?FLddYt0YqrfveDcBStK/fQyMbpaWanyMdfohc5TyD8NE4s1Hm0+9Q25pwzBK?=
 =?us-ascii?Q?RwGpQJM11QY0uSCRUGzqR0Z74PAywW56A4Vdaytq34XOJrLjKVdGCiPxXplK?=
 =?us-ascii?Q?ZnsApMMraXXlfOKLYmMGppUExwVHDDC27A0QFF5UBc2KazNXn7K6pxnEzYdT?=
 =?us-ascii?Q?3n0E/2ncYXzz2ZSz2DVN20wzCcZgP2E2TTE2Bznq8b6Z6qwHmjiU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aded60-fd8e-45d3-3970-08ded582260e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 02:00:09.5871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVU+/00AMjNv5nDDOqcm1dH2ReYDuX1eMBGpR48mk7lk5DO6+Hb17yLFn4sgqzGc+rMJoC8mhhIK2Aorakff/9OqJE/fxVqrgzaCdbvQNgDg9G3MdEtrplFP0GSOlAu5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7263
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

On Sun, Jun 28, 2026 at 10:21:07PM +0200, Marek Vasut wrote:
>On 6/28/26 8:57 PM, Tanmay Kathpalia wrote:
>> This reverts commit b42c67188c14 ("mmc: sdhci-cadence: trigger tuning
>> for SD HS mode on SD6HC (v6) PHY").
>> 
>> The reverted patch added runtime DLL delay calibration for SD High
>> Speed mode on the Cadence SD6HC (v6) PHY, gated by the device tree
>> property "cdns,sd-hs-tuning". Reviewer feedback identified issues with
>> the implementation, but the patch was merged without those concerns
>> being adequately addressed or justified.
>> 
>> Reverting to realign the driver with the IP documentation and the SD
>> Physical Layer Specification, as the underlying issue requires a
>> different solution approach.
>It would be good if the commit message went into details of those issues and
>explained the reasoning behind the revert. I.e. include details please.

+1
