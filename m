Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39290C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 10:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F06846F8;
	Sun,  5 Jul 2026 12:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mbspZBOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2D0846FD; Sun,  5 Jul 2026 12:20:30 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C172846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyo/qGr8wV0fstbLBfOW1OYn7o9vh149Fi0ifpelQXdWdwAGyr9VEj2LDLtAfwWEVwILemCzphI4RRvmzDRf6blhksqAJG3mBoeAywQzN1mlFu6YfGrAXAi5J6rR4WqbN5lvzTePr/9FS9lxIiFLEv46arh2N+B/LMBTkFWW9FVnpRznuqWbsdav6S4xTqICNlhW545rgcIuWpUhnnk3k/UsOMOG5Aoutu2xanpyOJbH99htv4+6IbNneaR07WD34zfflNlqPJon9ILqZCFRO+DbDj+j3m4HW/gmJFmLBRdPCaddKFlVxxmX6RYoBL4t1fWQDjxgYtjLgE/javVQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6bIvo+Zy0yDWABIjYcJNWlk/W66JpMmZcP4jka8L8g=;
 b=p6L3OB9VeVD3IcWKuFRJk7yPMFyCFnOp8U9kbgZ7CiFY/zI17Z5xGpnzjkx4uQf1/gGqMe9MK+OspseIS5AY2M6JfV30amhOlv0986OtpeRhrVTxyayITrJMVmwhcWuOQYHeu+Dz7gHOQdhpPkUmXDFaX0iGHAP7SQmwjB3jUewWRCB29EFq+aNfxOewMCMr4wHIMmH9QRapCUKqtTNSUPaVeqHCiiex6zPuCVExEEfTkJMITogUSzPVpc07Oh4AvhpAgCxV5MabP9UEeWdNVocPrLtuIQ3Zc9ffVwvtKodFutVCnYTmCJhzM7bn+NSCBFba29zX6emYXWu7MXjuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6bIvo+Zy0yDWABIjYcJNWlk/W66JpMmZcP4jka8L8g=;
 b=mbspZBOQRryHdqWBuDY/Jnb7LmrT5ulEHW9NzXqkqShAR/tJWpET8ozaL/ZF+lqNfl2kR3Ek3lC0Ultq8pWZfxTIy1dUF1s0wrSR5vaUvlv5uhfJV0yR8UG4BjuvCTeOLSkYGrFf5foN+9bR1RPfbqI6rlMzQ6AHGJki8to4p1BN0+1HlT5YcN6zcUdqhIVm0LrIr640vnlR3D96LnGtsc0z8IQr5Rg6v+FxN6YfqSVRuf6V5YKqhyT/go2OueZSoTCST//7f0D1B/aE4ast3/w0Z2mYUWJkgfVUQSdGm9V/udqqb0ZzMopfg2HafSVTXa16TECZRXa/wRnncxAi0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7769.namprd03.prod.outlook.com (2603:10b6:610:241::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 10:20:21 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.012; Sun, 5 Jul 2026
 10:20:21 +0000
Message-ID: <eee5cbaf-3641-4e9f-b50e-b5931478e933@altera.com>
Date: Sun, 5 Jul 2026 15:50:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mmc: k1: add sdhci platform driver
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>,
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Johan Jonker
 <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
 <20260705-m4-v3-4-5a9bc7f25fc5@riscstar.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260705-m4-v3-4-5a9bc7f25fc5@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c48c86-1706-4167-7865-08deda7f03f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|55112099003|22082099003|18002099003|3023799007|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ZWN9rk9bhyoHyUoSeUYWMtMqriYkb5zNehg7U6xQNKj8yN8Ke/Qc/rQjhLXDmRhD6Ht61zucvXh+3DNN8YhL384Tj7NbRE+oVHSsoN6EqOxfRRQL590vq4gzdKNSFbeSOTyC4QaIcK24SicpWHHG/YrnMZwgoipodnARi1Bi2M/I2B2u+8lWiC9fOunJXxfBzRWEg/kLjq+HFItSp2zEgRbc5Ig4PxbrOAx99+htBz063g0EJt11uW0f5dwWGiJ1Bth8FJSZ3SfLIvZNwz+SbhjU02UWW3pnAIG/Zi1ivlNON2P3cr3G3viL0F9vYNxImr86dl4tQQSykYa9bCzEFPcM7XszbuYAgEG4tCs+vMfuwu52oNtkkFE9jvyMdTmHdouj1GQsoiXXZOY/7bTfCO1bOlJDOw1mBNWu4iYsDuVgKDdgA0pUwTHO1r3iMwaW7qQqMIeobgWKPGA+ZdFcEPtwiJ3A43Bp1d41RvgzVHvhiiOayL+QGxHfIRAI6N47U/h8w0Y4F13LCfkCtFuYR9LgMSdywizcJq5Ol+vPItA0uNMNTjwfvxBBwlKf27A+Ci+8SkKLR6+mTN/Thi5m+UzamVxlhqsTekMjFUgdMvMErdjGVvyztB8EiiGV2mprTUkWbGJV1QHZrcCp9GQq6H1aeO4jV+Mj6W1hqhNaw20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(55112099003)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZqaXBRTWlVTXJiTExsZGRBOFBUNUVHQXJtQmZodzdoTnQ2bnlRUXVlSGlo?=
 =?utf-8?B?dVJZTlUxV28vRHNtUmovdmg4RlYzS0RyZ1M4ZzRwUFVGdVpucnZ5L2IvWjdl?=
 =?utf-8?B?Ykl3djBrVXZ6NlVLdVVVeFJRNUNwYzBvYlhKZ291dkxTMnpFOVhHWnREWnAv?=
 =?utf-8?B?NTZPelI0YndUYkoxWkVUQkZVM1ViaHNKSEZtamt1WHBHVzNXWFZTZ29kNklu?=
 =?utf-8?B?N29hcW8zZmxWOS9HMU9pblhMSFQ3c1VRTXBCYW9wdFBqUjdDL05KVDRDbUhW?=
 =?utf-8?B?eDJLWUY5MDFGVjJDOVphNkwzOTllUXZ0ei9rbzQ4dithOXFSZTh4aWtieG1y?=
 =?utf-8?B?NWl2dU4xaElxMnVVWUNkT2p1RWhyV1N4UmF5V2ZJLzhxV1ppMWFLeFUzaVlK?=
 =?utf-8?B?MnpXbjBDN01EQ3RQVnV6UWhEODJiN0FWa3FxYkVhYjhqdEpZR3VFMG5BTHpT?=
 =?utf-8?B?dWtZczVFQkVjdmUzSmNUK0FCWEFuWkc5NEcvTmtDUVlxVjhVNTA4dTIydith?=
 =?utf-8?B?RWVYdUtlbXM1d0hFQkNscXRadnFmWXZmV00rMXNEc01GcVlCbTF2WmhOQnk4?=
 =?utf-8?B?Nk1PckJVVVNmeXdsL1FiUjhwTWROYVd4NkRDV1JBNlNhTzUvY0JPbWpBU1ZK?=
 =?utf-8?B?RFI1anI2Y0laN1QyUmJ0MW9LVllaYktHWTdkTHRCVTBxQ1p6OThRT0ZyVzJY?=
 =?utf-8?B?eDBwQ0JLbTBkWStDY29RMlhnYkk5WXIwMUlnTU9xMjI3b0ZwS3lHa0VsWExE?=
 =?utf-8?B?bmdMTG5GY1krRlNIdkxhYkI0WWN1cmhvcEdGQVB1L3JmYVAwOUxGL2JBSklF?=
 =?utf-8?B?d2ZCVU50TTZJejVRdDZad1ExTDU4cnptditmalk1NnRmLzR5OG9Hekg4cUdL?=
 =?utf-8?B?cnp6UXRvb1lzVVE1SCtUS3lNQXhUUlp2SXpHOHFGa3Bvb09XUlFCWkdkMHRH?=
 =?utf-8?B?dnhRam9HOE40U0RBRldIMFNXRkNaMlp5Y25rQjc2YVgzSzk1dTFHV29OLzhZ?=
 =?utf-8?B?Qm1uRTc4blRQWWF4UW5tQWdBRk5ZYnFQREVkUGRzWUxOczZPS05ZWmhON3R5?=
 =?utf-8?B?ZlhVbmV1Wm81RnZaZ0RpbzhjU0lLelRDOGxOY1VjTnNiVEd1WHA2UTFSSDdz?=
 =?utf-8?B?bXpKRHRWb0krSUNXSVFqcU92TUR2Z1ljZHE3NTk3aEUyVGNIV0xOTWlkMElw?=
 =?utf-8?B?MlpBeWJqZkk3NWdrNnJNY1NPZFB1Y1RZU3BMVG9zSjN3M09XdUxyWFdCMlU4?=
 =?utf-8?B?ZUZCSEtZcmhUaWdDemJLdWplVTVldWdYZTdkaGI0ZWl0ZE54T05iTCtBVm1k?=
 =?utf-8?B?ck5DRGFWdEs4VFpoejJyMnBFVFpUNHc5ajZzcy81UXZESGFGTEcvK1Y5VkFk?=
 =?utf-8?B?QXRZZ0V3N0Z3TWtiZnJVVU1PdWZmaWYvU1M1VkFNaU9ud1JjZWltTDFua2V6?=
 =?utf-8?B?dXJVMVIyNi8rZUtLd1NuZGhXanE2aDAzRXFEUEl6b2NEUzBBZVV3enpSTUM2?=
 =?utf-8?B?akptS2lYV09kTFlSRHNjNHVVUTNwd3RYSUwveHFQdEptb0Z5WEhndThtSjZp?=
 =?utf-8?B?d3VCT3N3SVRnT3I2c0tXK1lXNWZVazlNSUliL2xsRTIrTVhpS0FOYzd1OXIy?=
 =?utf-8?B?c2traGtHa0NOTm42TnVzN3QwT3ljSEhqZ1M4eStCOWNBckNHdzA0dGlvMmkx?=
 =?utf-8?B?Q1ZjYUc4ckFJaXhSUDBEU0tNeTNPOU1uK0J4UUJndmU2K1U1cis4UGFsMjRK?=
 =?utf-8?B?cFlJSE9rcGl0ODByVDNTTzRVeHlwdjRVb25HRG55aFdkeXNmUTltbDZISmZ2?=
 =?utf-8?B?MWJ3QnBYRkRuL1Q1aXJXeWNKdmtubmpFOGRtVnpDZlpoUDR4UTE0SXJRenVV?=
 =?utf-8?B?aVlkbnVVTjZZMlVNTGdnTFlsdmN4dU5KWGdmby84ZGFyRCsxSW1zbUxKK1pT?=
 =?utf-8?B?d3BqSkZ3Y1ViUFo5V29DQ1hxYkJZdkR4UDZJRnlqZmQ2THJhWjBxYTVUSEVj?=
 =?utf-8?B?dlJuQlRCUlQ3MGU3VWVsUDVBRXhZZ3ZibTdaaDFGT29MdEJuL2crajBpSjN5?=
 =?utf-8?B?MDFJYVZ3UVJ3T1FjQ3hwTzhsdnVWNGxwRXNwcEpIeTJQaVdlTE5XRmJJMlUy?=
 =?utf-8?B?cW9CVEdHT2R3N3ZNVkF0ZUF2YzlnSVZIWklEVE5HempiME1rL25QNEkxbjgw?=
 =?utf-8?B?MzJNOWhLcjJ4ZmMwM01jWDNJb1h4MU5CUWhlLzQ2YUtuT1NvNjdxcEE1aGxh?=
 =?utf-8?B?dUI0TThyZnRzVnlKR053bVhVb1ZOVGY1c2VYR1BNSXNuRlFabG1MRFJodlJB?=
 =?utf-8?B?dWdlVHJmR3U0bUxGRjNUaUErRTMzSytEVEFld1NUbXV1empUOWZpaWZZWDMv?=
 =?utf-8?Q?2BIIyEfc53PdJNF4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c48c86-1706-4167-7865-08deda7f03f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 10:20:21.1802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8uOgSIENkIgufgNeYL+1BbMG01rAUbZRITJ/1uiqtxJdWhGEwiSZr4vjc32SfTyY8ydutSGxpOsDAuQ8KsBP+mnLXR+JeY0n0fQ+kqM834=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7769
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


On 7/5/2026 11:37 AM, Eric Chung wrote:
> Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> implements the necessary platform-specific operations for the SDHCI
> controller, enabling MMC/SD card functionality on K1-based platforms.
>
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
> ---
> v3:
> - Enable CMD23 in capability.
> v2:
> - Enable ADMA mode support.
> - Use CMD23 for multi-block read/write.
> - Move ASR/AIB register into pinctrl driver.
> - Correct pinctrl state from "fast" to "uhs".
> - Migrate tuning support from the spacemit linux driver.
> ---
>   drivers/mmc/Kconfig          |   7 +
>   drivers/mmc/Makefile         |   1 +
>   drivers/mmc/spacemit_sdhci.c | 680 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 688 insertions(+)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 131be3106a1..f05b376ab72 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -722,6 +722,13 @@ config MMC_SDHCI_SNPS
>   
>   	  If unsure, say N.
>   
> +config MMC_SDHCI_SPACEMIT
> +	bool "Spacemit SDHCI controller"
> +	depends on MMC_SDHCI
> +	help
> +	  Support for Secure Digital Host Controller Interface (SDHCI) on
> +	  Spacemit K1 SoC.
> +
>   config MMC_SDHCI_STI
>   	bool "SDHCI support for STMicroelectronics SoC"
>   	depends on MMC_SDHCI && OF_CONTROL && ARCH_STI
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index a23336d7d8d..aa05cec23be 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
>   obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
>   obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
>   obj-$(CONFIG_MMC_SDHCI_SNPS)		+= snps_sdhci.o
> +obj-$(CONFIG_MMC_SDHCI_SPACEMIT)	+= spacemit_sdhci.o
>   obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
>   obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
>   obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= tegra_mmc.o
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> new file mode 100644
> index 00000000000..8622a3e21f1
> --- /dev/null
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -0,0 +1,680 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Spacemit K1 Mobile Storage Host Controller
> + *
> + * Copyright (C) 2023-2026 Spacemit Inc.
> + * Copyright (C) 2026 RISCstar Ltd.
> + */
> +
> +#define LOG_CATEGORY UCLASS_MMC
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <fdtdec.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <sdhci.h>
> +#include <reset-uclass.h>
> +#include <mapmem.h>
> +#include <dm/pinctrl.h>
> +#include <linux/libfdt.h>
> +#include <linux/delay.h>
> +#include <power/regulator.h>
> +
> +#define FIELD_PREP(mask, val)		(((val) << __ffs(mask)) & (mask))

<linux/bitfield.h> is already used elsewhere include it instead.

> +
> +/* SDH register definitions */
> +#define SPACEMIT_SDHC_OP_EXT_REG	0x108
> +#define  SDHC_OVRRD_CLK_OEN		BIT(11)
> +#define  SDHC_FORCE_CLK_ON		BIT(12)
> +
> +#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
> +#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
> +
> +#define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
> +#define  SDHC_MISC_INT_EN		BIT(1)
> +#define  SDHC_MISC_INT			BIT(2)
> +#define  SDHC_ENHANCE_STROBE_EN		BIT(8)
> +#define  SDHC_MMC_HS400			BIT(9)
> +#define  SDHC_MMC_HS200			BIT(10)
> +#define  SDHC_MMC_CARD_MODE		BIT(12)
> +
> +#define SPACEMIT_SDHC_TX_CFG_REG	0x11C
> +#define  SDHC_TX_INT_CLK_SEL		BIT(30)
> +#define  SDHC_TX_MUX_SEL		BIT(31)
> +
> +#define SPACEMIT_SDHC_PHY_CTRL_REG	0x160
> +#define  SDHC_PHY_FUNC_EN		BIT(0)
> +#define  SDHC_PHY_PLL_LOCK		BIT(1)
> +#define  SDHC_HOST_LEGACY_MODE		BIT(31)
> +
> +#define SPACEMIT_SDHC_PHY_FUNC_REG	0x164
> +#define  SDHC_PHY_TEST_EN		BIT(7)
> +#define  SDHC_HS200_USE_RFIFO		BIT(15)
> +
> +#define SPACEMIT_SDHC_PHY_DLLCFG	0x168
> +#define  SDHC_DLL_PREDLY_NUM		GENMASK(3, 2)
> +#define  SDHC_DLL_FULLDLY_RANGE		GENMASK(5, 4)
> +#define  SDHC_DLL_VREG_CTRL		GENMASK(7, 6)
> +#define  SDHC_DLL_ENABLE		BIT(31)
> +
> +#define SPACEMIT_SDHC_PHY_DLLCFG1	0x16C
> +#define  SDHC_DLL_REG1_CTRL		GENMASK(7, 0)
> +#define  SDHC_DLL_REG2_CTRL		GENMASK(15, 8)
> +#define  SDHC_DLL_REG3_CTRL		GENMASK(23, 16)
> +#define  SDHC_DLL_REG4_CTRL		GENMASK(31, 24)
> +
> +#define SPACEMIT_SDHC_PHY_DLLSTS	0x170
> +#define  SDHC_DLL_LOCK_STATE		BIT(0)
> +
> +#define SPACEMIT_SDHC_PHY_PADCFG_REG	0x178
> +#define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
> +#define  SDHC_RX_BIAS_CTRL		BIT(5)
> +
> +#define SPACEMIT_SDHC_RX_CFG_REG        0x118
> +#define  SDHC_RX_SDCLK_SEL0_MASK        GENMASK(1, 0)
> +#define  SDHC_RX_SDCLK_SEL1_MASK        GENMASK(3, 2)
> +#define  SDHC_RX_SDCLK_SEL1             FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)
> +
> +#define SPACEMIT_SDHC_DLINE_CTRL_REG    0x130
> +#define  SDHC_DLINE_PU                  BIT(0)
> +#define  SDHC_RX_DLINE_CODE_MASK        GENMASK(23, 16)
> +#define  SDHC_TX_DLINE_CODE_MASK        GENMASK(31, 24)
> +
> +#define SPACEMIT_SDHC_DLINE_CFG_REG     0x134
> +#define  SDHC_RX_DLINE_REG_MASK         GENMASK(7, 0)
> +#define  SDHC_RX_DLINE_GAIN             BIT(8)
> +#define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
> +
> +#define SPACEMIT_RX_DLINE_REG		9
> +#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
> +#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
> +
> +#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
> +#define SPACEMIT_TX_TUNING_DELAYCODE	127
> +
> +struct spacemit_sdhci_plat {
> +	struct mmc_config cfg;
> +	struct mmc mmc;
> +	struct reset_ctl_bulk resets;
> +	struct clk_bulk clks;
> +};
> +
> +struct spacemit_sdhci_priv {
> +	struct sdhci_host host;
> +};
> +
> +/* All helper functions will update clr/set while preserve rest bits */
> +static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val,
> +					  int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val,
> +					  int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr,
> +					     u32 set, int reg)
> +{
> +	u32 val = sdhci_readl(host, reg);
> +
> +	val = (val & ~clr) | set;
> +	sdhci_writel(host, val, reg);
> +}
> +
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
> +static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_CODE_MASK,
> +				  FIELD_PREP(SDHC_RX_DLINE_CODE_MASK, delay),
> +				  SPACEMIT_SDHC_DLINE_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_CODE_MASK,
> +				  FIELD_PREP(SDHC_TX_DLINE_CODE_MASK, delay),
> +				  SPACEMIT_SDHC_DLINE_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host,
> +					    u8 dline_reg)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_REG_MASK,
> +				  FIELD_PREP(SDHC_TX_DLINE_REG_MASK, dline_reg),
> +				  SPACEMIT_SDHC_DLINE_CFG_REG);
> +}
> +
> +static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
> +{
> +	spacemit_sdhci_setbits(host, SDHC_TX_MUX_SEL, SPACEMIT_SDHC_TX_CFG_REG);
> +	spacemit_sdhci_setbits(host, SDHC_DLINE_PU,
> +			       SPACEMIT_SDHC_DLINE_CTRL_REG);
> +	udelay(5);
> +}
> +
> +static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_REG_MASK,
> +				  FIELD_PREP(SDHC_RX_DLINE_REG_MASK, SPACEMIT_RX_DLINE_REG),
> +				  SPACEMIT_SDHC_DLINE_CFG_REG);
> +
> +	spacemit_sdhci_setbits(host, SDHC_DLINE_PU,
> +			       SPACEMIT_SDHC_DLINE_CTRL_REG);
> +	udelay(5);
> +
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_SDCLK_SEL1_MASK,
> +				  SDHC_RX_SDCLK_SEL1,
> +				  SPACEMIT_SDHC_RX_CFG_REG);
> +
> +	if (host->mmc->selected_mode == MMC_HS_200)
> +		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO,
> +				       SPACEMIT_SDHC_PHY_FUNC_REG);
> +}
> +#endif /* MMC_SUPPORTS_TUNING */
> +
> +/*
> + * Reference: PMU_SDH0_CLK_RES_CTRL (0x054), SDH0_CLK_SEL=0x0,
> + * SDH0_CLK_DIV=0x1. The default clock source is 204.8 MHz
> + * (pll1_d6_409p6Mhz / 2).
> + *
> + * During start-up, use a 200 kHz frequency.
> + */
> +#define SDHC_MIN_CLOCK (200 * 1000)
> +
> +static void spacemit_sdhci_phy_init(struct udevice *dev,
> +				    struct sdhci_host *host)
> +{
> +	u32 reg = 0;
> +
> +	if (dev_read_bool(dev, "no-sd") && dev_read_bool(dev, "no-sdio")) {
> +		/* MMC card mode */
> +		reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
> +		reg |= SDHC_MMC_CARD_MODE;
> +		sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
> +
> +		/* Use PHY functional mode */
> +		reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_CTRL_REG);
> +		reg |= (SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK);
> +		sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_CTRL_REG);
> +
> +		reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_PADCFG_REG);
> +		reg |= SDHC_RX_BIAS_CTRL;
> +		sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_PADCFG_REG);
> +	} else {
> +		reg = sdhci_readl(host, SPACEMIT_SDHC_TX_CFG_REG);
> +		reg |= SDHC_TX_INT_CLK_SEL;
> +		sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
> +	}
> +
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
> +	reg &= ~SDHC_ENHANCE_STROBE_EN;
> +	sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
> +}
> +
> +static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int voltage)
> +{
> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> +	int ret;
> +
> +	if (!mmc->vqmmc_supply)
> +		return 0;
> +
> +	ret = regulator_set_value(mmc->vqmmc_supply, voltage);
> +	if (ret) {
> +		log_err("failed to set vqmmc voltage to %d.%dV\n",
> +			voltage / 1000000, (voltage / 100000) % 10);
> +		return ret;
> +	}
> +	ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
> +	if (ret) {
> +		log_err("failed to enable vqmmc supply\n");
> +		return ret;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
> +{
> +	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
> +		struct mmc *mmc = host->mmc;
> +		u32 ctrl;
> +
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		switch (mmc->signal_voltage) {
> +		case MMC_SIGNAL_VOLTAGE_330:
> +		case MMC_SIGNAL_VOLTAGE_180: {
> +			bool to_180 = mmc->signal_voltage ==
> +				      MMC_SIGNAL_VOLTAGE_180;
> +			bool ok;
> +			int voltage_mv = to_180 ? 1800000 : 3300000;
> +
> +			if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_mv))
> +				return;
> +			if (!IS_SD(mmc))
> +				return;
> +			if (to_180)
> +				ctrl |= SDHCI_CTRL_VDD_180;
> +			else
> +				ctrl &= ~SDHCI_CTRL_VDD_180;
> +			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +			mdelay(5);
> +
> +			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
> +			if (ok)
> +				return;
> +
> +			log_err("%d.%dV regulator output not stable\n",
> +				voltage_mv / 1000000,
> +				(voltage_mv / 100000) % 10);
> +			break;
> +		}
> +		default:
> +			/* No signal voltage switch required */
> +			return;
> +		}
> +	}
> +}
> +
> +static void spacemit_sdhci_set_clk_gate(struct sdhci_host *host, int auto_gate)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_OP_EXT_REG);
> +	if (auto_gate)
> +		reg &= ~(SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON);
> +	else
> +		reg |= (SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON);
> +	sdhci_writel(host, reg, SPACEMIT_SDHC_OP_EXT_REG);
> +}
> +
> +static bool spacemit_sdhci_is_voltage_switch_cmd(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +	u32 cmd;
> +
> +	if (!IS_SD(mmc))
> +		return false;
> +
> +	cmd = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +	return cmd == SD_CMD_SWITCH_UHS18V &&
> +	       mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180;
> +}
> +
> +static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
> +				    int timeout_us)
> +{
> +	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +	struct sdhci_host *host = mmc->priv;
> +	unsigned long timeout = timer_get_us() + timeout_us;
> +	u32 tmp;
> +
> +	/*
> +	 * readx_poll_timeout is unsuitable because sdhci_readl accepts
> +	 * two arguments
> +	 */
> +	do {
> +		tmp = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		if (!!(tmp & SDHCI_DATA_0_LVL_MASK) == !!state) {
> +			if (spacemit_sdhci_is_voltage_switch_cmd(host))
> +				spacemit_sdhci_set_clk_gate(host, 1);
> +			return 0;
> +		}
> +	} while (!timeout_us || !time_after(timer_get_us(), timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
> +{
> +	struct mmc *mmc = host->mmc;
> +	u32 reg;
> +
> +	spacemit_sdhci_set_voltage(host);
> +
> +	if (spacemit_sdhci_is_voltage_switch_cmd(host))
> +		spacemit_sdhci_set_clk_gate(host, 0);
> +
> +	/*
> +	 * Set TX_INT_CLK_SEL to guarantee hold time at default speed,
> +	 * HS, SDR12/SDR25/SDR50 modes. See SDHC_TX_CFG_REG (0x11c).
> +	 */
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_TX_CFG_REG);
> +	if (mmc->selected_mode == MMC_LEGACY ||
> +	    mmc->selected_mode == MMC_HS ||
> +	    mmc->selected_mode == SD_HS ||
> +	    mmc->selected_mode == UHS_SDR12 ||
> +	    mmc->selected_mode == UHS_SDR25 ||
> +	    mmc->selected_mode == UHS_SDR50) {
> +		reg |= SDHC_TX_INT_CLK_SEL;
> +	} else {
> +		reg &= ~SDHC_TX_INT_CLK_SEL;
> +	}
> +	sdhci_writel(host, reg, SPACEMIT_SDHC_TX_CFG_REG);
> +
> +	/* Set pinctrl state */
> +	if (IS_ENABLED(CONFIG_PINCTRL)) {
> +		if (mmc->clock >= 200000000)
> +			pinctrl_select_state(mmc->dev, "uhs");
> +		else
> +			pinctrl_select_state(mmc->dev, "default");
> +	}
> +
> +	if (mmc->selected_mode == MMC_HS_200 ||
> +	    mmc->selected_mode == MMC_HS_400 ||
> +	    mmc->selected_mode == MMC_HS_400_ES) {
> +		reg = sdhci_readw(host, SPACEMIT_SDHC_MMC_CTRL_REG);
> +		if (mmc->selected_mode == MMC_HS_200)
> +			reg |= SDHC_MMC_HS200;
> +		else
> +			reg |= SDHC_MMC_HS400;
> +		sdhci_writew(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
> +	} else {
> +		reg = sdhci_readw(host, SPACEMIT_SDHC_MMC_CTRL_REG);
> +		reg &= ~(SDHC_MMC_HS200 | SDHC_MMC_HS400 | SDHC_ENHANCE_STROBE_EN);
> +		sdhci_writew(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
> +	}
> +
> +	sdhci_set_uhs_timing(host);
> +}
> +
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
> +static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
> +{
> +	struct sdhci_host *host = mmc->priv;
> +	int current_len = 0, current_start = 0;
> +	int max_pass_len = 0, max_pass_start = 0;
> +	u8 final_delay;
> +	int ret = 0;
> +	int i;
> +
> +	/*
> +	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
> +	 * if clock frequency is greater than 100MHz in these modes.
> +	 */
> +	if (host->clock < 100 * 1000 * 1000 ||
> +	    !(mmc->selected_mode == MMC_HS_200 ||
> +	      mmc->selected_mode == UHS_SDR50 ||
> +	      mmc->selected_mode == UHS_SDR104))
> +		return 0;
> +
> +	if (IS_SD(host->mmc)) {
> +		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
> +		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
> +		spacemit_sdhci_tx_tuning_prepare(host);
> +
> +		log_debug("TX tuning: dline_reg=%d, delaycode=%d\n",
> +			  SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
> +	}
> +
> +	spacemit_sdhci_prepare_tuning(host);
> +
> +	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX; i++) {
> +		spacemit_sdhci_set_rx_delay(host, i);
> +		ret = mmc_send_tuning(host->mmc, opcode);
> +
> +		log_debug("RX delay %d: %s\n",
> +			  i, ret == 0 ? "pass" : "fail");
> +
> +		if (ret == 0) {
> +			/* Test passed - extend current window */
> +			if (current_len == 0)
> +				current_start = i;
> +			current_len++;
> +		} else {
> +			/* Test failed - check if current window is best so far */
> +			if (current_len > max_pass_len) {
> +				max_pass_len = current_len;
> +				max_pass_start = current_start;
> +			}
> +			current_len = 0;
> +		}
> +	}
> +
> +	if (current_len > max_pass_len) {
> +		max_pass_len = current_len;
> +		max_pass_start = current_start;
> +	}
> +
> +	if (max_pass_len < 3) {
> +		log_err("Tuning failed: no stable window found\n");
> +		return -EIO;
> +	}
> +
> +	final_delay = max_pass_start + max_pass_len / 2;
> +	spacemit_sdhci_set_rx_delay(host, final_delay);
> +	ret = mmc_send_tuning(host->mmc, opcode);
> +	if (ret) {
> +		u8 retry_delays[] = {
> +			max_pass_start + max_pass_len / 4,
> +			max_pass_start + (3 * max_pass_len) / 4,
> +			max_pass_start,
> +			max_pass_start + max_pass_len - 1
> +		};
> +		int retry_count = ARRAY_SIZE(retry_delays);
> +
> +		log_warning("Primary delay %d failed, trying alternatives\n",
> +			    final_delay);
> +
> +		for (i = 0; i < retry_count; i++) {
> +			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
> +			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
> +				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
> +				ret = mmc_send_tuning(host->mmc, opcode);
> +				if (!ret) {
> +					final_delay = retry_delays[i];
> +					log_info("Retry successful with delay %d\n",
> +						 final_delay);
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (ret) {
> +			log_err("All retry attempts failed\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	log_debug("Tuning successful: window %d-%d, using delay %d\n",
> +		  max_pass_start, max_pass_start + max_pass_len - 1, final_delay);
> +
> +	return 0;
> +}
> +#endif /* MMC_SUPPORTS_TUNING */
> +
> +#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
> +static int spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> +{
> +	u32 reg;
> +	int i;
> +
> +	/* Configure DLL predly, fulldly, and vreg */
> +	spacemit_sdhci_clrsetbits(host, SDHC_DLL_PREDLY_NUM |
> +				  SDHC_DLL_FULLDLY_RANGE |
> +				  SDHC_DLL_VREG_CTRL,
> +				  FIELD_PREP(SDHC_DLL_PREDLY_NUM, 1) |
> +				  FIELD_PREP(SDHC_DLL_FULLDLY_RANGE, 1) |
> +				  FIELD_PREP(SDHC_DLL_VREG_CTRL, 1),
> +				  SPACEMIT_SDHC_PHY_DLLCFG);
> +
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG1);
> +	reg |= FIELD_PREP(SDHC_DLL_REG1_CTRL, 0x92);
> +	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG1);
> +
> +	/* Enable DLL */
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG);
> +	reg |= SDHC_DLL_ENABLE;
> +	sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG);
> +
> +	/* Wait for DLL lock */
> +	i = 0;
> +	while (i++ < 100) {
> +		if (sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLSTS) & SDHC_DLL_LOCK_STATE)
> +			break;
> +		udelay(10);
> +	}
> +	if (i == 100) {
> +		log_err("%s: phy dll lock timeout\n", host->name);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spacemit_sdhci_hs400_enhanced_strobe(struct sdhci_host *host)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SPACEMIT_SDHC_MMC_CTRL_REG);
> +	reg |= SDHC_ENHANCE_STROBE_EN;
> +	sdhci_writel(host, reg, SPACEMIT_SDHC_MMC_CTRL_REG);
> +
> +	return spacemit_sdhci_phy_dll_init(host);
> +}
> +#endif
> +
> +const struct sdhci_ops spacemit_sdhci_ops = {
> +	.set_control_reg		= spacemit_sdhci_set_control_reg,
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
> +	.platform_execute_tuning	= spacemit_sdhci_execute_tuning,
> +#endif
> +#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
> +	.set_enhanced_strobe		= spacemit_sdhci_hs400_enhanced_strobe,
> +#endif
> +};
> +
> +static struct dm_mmc_ops spacemit_mmc_ops;
> +
> +static int spacemit_sdhci_probe(struct udevice *dev)
> +{
> +	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
> +	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
> +	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
> +	struct sdhci_host *host = &priv->host;
> +	struct clk clk;
> +	int ret = 0;
> +
> +	host->mmc = &plat->mmc;
> +	host->mmc->priv = host;
> +	host->mmc->dev = dev;
> +	upriv->mmc = host->mmc;
> +
> +	spacemit_mmc_ops = sdhci_ops;
> +	spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
> +
> +	ret = clk_get_bulk(dev, &plat->clks);
> +	if (ret) {
> +		log_err("Can't get clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_enable_bulk(&plat->clks);
> +	if (ret) {
> +		log_err("Failed to enable clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = reset_get_bulk(dev, &plat->resets);
> +	if (ret) {
> +		log_err("Can't get reset: %d\n", ret);
> +		return ret;
> +	}

The previously clk_enable_bulk()'d clocks are never released better to
add to cleanup paths.

> +
> +	ret = reset_deassert_bulk(&plat->resets);
> +	if (ret) {
> +		log_err("Failed to reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_get_by_index(dev, 1, &clk);
> +	if (ret) {
> +		log_err("Can't get io clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_set_rate(&clk, plat->cfg.f_max);
> +	if (ret) {
> +		log_err("Failed to set io clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set quirks */
> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
> +		host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD;
> +	else
> +		host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
> +				SDHCI_QUIRK_32BIT_DMA_ADDR;
> +	host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz |
> +			  MMC_CAP_CMD23;
> +	host->max_clk = plat->cfg.f_max;
> +
> +	plat->cfg.f_min = SDHC_MIN_CLOCK;
> +	host->ops = &spacemit_sdhci_ops;
> +
> +	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max,
> +			      SDHC_MIN_CLOCK);
> +	if (ret)
> +		return ret;
> +
> +	ret = sdhci_probe(dev);
> +	if (ret)
> +		return ret;
> +
> +	spacemit_sdhci_phy_init(dev, host);
> +	return ret;
> +}
> +
> +static int spacemit_sdhci_of_to_plat(struct udevice *dev)
> +{
> +	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
> +	struct spacemit_sdhci_priv *priv = dev_get_priv(dev);
> +	struct sdhci_host *host = &priv->host;
> +	int ret = 0;
> +
> +	host->name = dev->name;
> +	host->ioaddr = (void *)dev_read_addr(dev);
> +
> +	ret = mmc_of_parse(dev, &plat->cfg);
> +
> +	return ret;
> +}
> +
> +static int spacemit_sdhci_bind(struct udevice *dev)
> +{
> +	struct spacemit_sdhci_plat *drv_data;
> +	struct spacemit_sdhci_plat *plat = dev_get_plat(dev);
> +
> +	drv_data = (struct spacemit_sdhci_plat *)dev_get_driver_data(dev);
> +	if (drv_data)
> +		memcpy(plat, drv_data, sizeof(struct spacemit_sdhci_plat));
> +	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
> +}
> +
> +static const struct udevice_id spacemit_sdhci_ids[] = {
> +	{
> +		.compatible = "spacemit,k1-sdhci",
> +		.data = 0,
> +	}, {
> +	}
> +};
> +
> +U_BOOT_DRIVER(spacemit_sdhci_drv) = {
> +	.name		= "spacemit_sdhci",
> +	.id		= UCLASS_MMC,
> +	.of_match	= spacemit_sdhci_ids,
> +	.of_to_plat	= spacemit_sdhci_of_to_plat,
> +	.ops		= &spacemit_mmc_ops,
> +	.bind		= spacemit_sdhci_bind,
> +	.probe		= spacemit_sdhci_probe,
> +	.priv_auto	= sizeof(struct spacemit_sdhci_priv),
> +	.plat_auto	= sizeof(struct spacemit_sdhci_plat),
> +};
>
