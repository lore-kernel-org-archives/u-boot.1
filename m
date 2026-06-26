Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D64C43211
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 17:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B7B8460E;
	Fri, 26 Jun 2026 19:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ETL03nGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCCF84704; Fri, 26 Jun 2026 19:00:49 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E726383FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 19:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnfbKFZDnJucy4+EKqAPV0DwTJX7qggWLmzmpHPLeLnxnZYSEwJYiGkMeeKLcyks2fQ7SpaHZ48AHZduhl8SRdpReyh8H9ALfAbFvvE5wNE3+GBvS6csvHcV7OhD0HZwdeqoPS2lgpcZGhZZuGtfUu2Lq5uUf3+1CidNIyE9fAOihL9uq8wWpekcpjhQznRFNbtP++9Wg4VWhmo34TlfXBsAR749K4FmDvIkD8EuzSilkmcKjArZT5Sk8FI+F0d2Zj9DQzQFym/zQwQh0p/VT+Qw0+ir9cOwxZFkEFR0T5qTQirTqQktvDf01Qr86erPix215+jncIeVnEGO99uKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR6WWIfh2sswnNiv51prFpACAKn4kcEFhyIluAn1gDA=;
 b=dWJd1F4Da6mqKWRiu07ViggCXcubN0Vbwb37CJ8xsz4O8mGRzGtlR2ppj5NOIHFNgdtmnjPd6nQWlX71/Y8ISDmSps/gr77zixowgzr264K7eI07KEVVoFxZ/xXOBBScoLDAjyjzZhUH/2DQW9ccVKk53BkFDanT/Y9XEDvzcuDt3I9/DUF8pFbWLgNqCIK6qzYd/PSPXR3mvwXsjvtq+Q2hwDj+4KjLMuQBt3IGk1UVA8c1SS1gJZRt2cY3R9sRJnBElZeinzspcyWdEbzXWfDx6aWbo2Y4IT33yfOqeEFMvIUzz+8iw68vGtVIf3JAiG09nHXReURtLy2Iq1j4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR6WWIfh2sswnNiv51prFpACAKn4kcEFhyIluAn1gDA=;
 b=ETL03nGZkpmnuiKu5zgW1XAt6BkHrlga6YjNI6IVx6N514igv03LYfdbbcUrd7xLrPQlAI5dWyGsXK65SKnbegH/BeO5ofYh6i5SgCtlPi+BRbvOoKCBcc2u0FsFz+CCdP+rQRoQ8Xze8Wgy/+wrKcrW/31GQxBfWIYK18XFRlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 17:00:41 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 17:00:41 +0000
Message-ID: <7c778270-de93-4421-8085-1fc860d62564@cherry.de>
Date: Fri, 26 Jun 2026 19:00:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Cody Eksal <masterr3c0rd@epochal.quest>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF0000089B.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64f) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 577bf5ff-48d0-4118-6027-08ded3a4748f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: DpoPkHJ67Pkp1LD96ZsRBVG2XQ/Mfwe60oLNZwghb77c5eCjoD+ml2OpIhmfAjBdcmfLuQfEM4PdY9IpYFxK/OxoFDRTwHmB1MI0HHf5GlxJBF5hdD9jG+NrunwPxO1s+QzhyoZfy1nPdv20QjZS/Mmwo18wvgT2eNe9NeXzfA7KQ0KA4/KfbNEKsWVGIhGKo2kmmlB68oC44ZGVEysrg/OJSFUJB6rNY+fqO36EHk56wUFq2MsP90CdSCjFGV+Qp8dExUi0zARlLLNfjKbDB4Dc3U0xsZjt3pzMcUAbzar5ajdlqofdfnnbP3AJkGytzUpm6bCoAtxabj7YAva33aTlDDg40n/hjOa46So4DZQ9TJpmzlLzcgSBivrDKa4PCpujn9e2ms/FMkPhvOnpA4Y2fWWXvQPfeH3n0iwnC8QzsFLJOE0PTi7H1kX/KBBVC28oN8Jx2OC7C2Cmq+jQMyJ5/5dZHc9LoP42EtvEoo3VZzbjea6AIThtPlxoxMOzqhfHpyLc1blKFx0t99m8G5ApxsB+SX+PGxexLT/BsnTPyByhGzMszYyI3cSUPy2eN/BQsmAMTvVK6cxv+e3qbahf0J8bgajjGl8xQoDpRASbOPS8ipGSNCb5S6FiqFLAPFnpHY1jkur2QtvB1sm9dEu/rYBWm+d5C4vQH28297A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFHWm0zTlJ5bjBsWEY1UDFLT3RzaVNRaUNyekhaWEFTaEY0RVdEdU4rWHhy?=
 =?utf-8?B?Q0VOandsWmtCck9LYlBpV1BUUGxzenRCUEhDOWM4TGxwc055blRIeGFkOXlY?=
 =?utf-8?B?Y1JvSWRqVzV1Y2RSU0RtUm1GMWZZanRnQ2pJWWFTNWNZVm5EdndmblNhSThE?=
 =?utf-8?B?M1liWDU4WTRKYWRMVmxONE9DcFBTNUxvL1ZSRUpyYWladkdBQ0V6NndVQVZE?=
 =?utf-8?B?OWl3UjF5OVhKb3NHcWtVZXNNUzdMOVhxOSs1QmF2dG55RzRTWllFRDlRVHpN?=
 =?utf-8?B?bE50ZWlKVXYyT0ZaeUQwTGJpT3VQRHNqOVhYejRWbU83MW1pNFRhL1E0VmV6?=
 =?utf-8?B?TStZNzZScmJaeHpJNVlZWEowTkxXNFJhT2JXeWFRVlRPOWVBdjNyT3ZiK3RZ?=
 =?utf-8?B?SXlxT1M4RjdNM2phR1kwanovL0gyRDN3Q0FrL1FTRDlXY0lxT2FoL2pTWGFz?=
 =?utf-8?B?Z2tsMkRIOUZzMktpWDZpclBpWGltVVBrb21OYlhhZSsybVpwUVBUeHdDd1V5?=
 =?utf-8?B?WVE5TXhmb0RhcGVjdmVxWGVSb0p0Qkwrck9mNzB2V0g4MnY4TGdJS2hkRjJo?=
 =?utf-8?B?c2ZoUE01U0N0WFBRbHlTUWlrd1lnZnY5a1lleXFXL3NnTkcyTHBqeStHejlL?=
 =?utf-8?B?aTVHT09VVXYwTTZtdjJteEUrT1hGYzhBMG05azV0TzUyYUpaYTF4VkNvalJX?=
 =?utf-8?B?NXVHdVl1a1VLUlNpZEErZ21FVWMxZm1aWHg1RUdLWWk5cGpKNFJrSjFNR2tJ?=
 =?utf-8?B?NkdOTWJFUWVPTytSZ05JQTV6UXUrNmFDVGpzNnEyRXBRaGNMZkxHWXA1WGR3?=
 =?utf-8?B?aUlaY1hBclhMSkxXMEQwZE9lay9Ldyt6ZGVlRnlnak5zcUQzRFNndGt6dkZS?=
 =?utf-8?B?aFdTRk9DUHYvR2Z4ajlYbHd0UUdyeng1MjJ6U1pqanRQTmxWMHR4amVNWmJF?=
 =?utf-8?B?TTB4RTBMREVxMXVtQzJ5VDBscVZEU0QyTURwWFZOdXJtOGlwZ1J4NVJjaThV?=
 =?utf-8?B?dC90eTNVMTc2TXFLejFJZFJTTXptRk95dGxsbDFLV1J6WkZid0hHM3VWT0kw?=
 =?utf-8?B?ZkZhVmxJU1RuOXRlZVA0ak5iYjB6amhpMDQ2aW1BdDJ3djBXckc1U0lnUkxu?=
 =?utf-8?B?Wnp3bTZCYk1VL21LeDFydlEvZEY4NnJqSmxzYlhpOHAzU3JxaERLc0pucTZx?=
 =?utf-8?B?YzZtMGV1TmZpY1U2R0I1UHpMZnpnQW1walQySXpIMEV6bVpqZ0tzTndNSVVI?=
 =?utf-8?B?Z1haZE1lQnlKN2IzNHlkdmZIbUZPeE0xV3N5M0poNGVDWkVLTWxNc0dadWJy?=
 =?utf-8?B?UXVXYW5Yd29ySXhyQnVQOXlMNFNrQWRHZzBCdGxVVHpuWndwd295K2VpOEZL?=
 =?utf-8?B?RjAvWXp5YXphUzVOcysvTmFsRE16TXVDY21kM1F0djdMVEpLdllMcXJZVlhD?=
 =?utf-8?B?ME9QZ1k4Vkc2bTJ3Mmh0YitaR3BOYVU2VVZHVlR2WjNKMS9yYVFURlRRalgx?=
 =?utf-8?B?ZFpsT1JLZno1RCtPbXArSkhSVDErSVk0K1lBdmRqelM0S3o3STQ2Uy9jMDVx?=
 =?utf-8?B?c1RnYk4rc3BpYzNpSndxS2ZBSGVSOElITDF5dDlGRkxaN1V1QzJ5ZWVodGVS?=
 =?utf-8?B?SEFvMGtkOTFDUDZmMXVGZ0hma1dDcFJTcU42UTlnczQycGhlc2Nady8vRmI2?=
 =?utf-8?B?bXJCYy82aTFHc1hpd09oQXVKUHlZblJoOVplaDdheUQvdHoybUdUQ0FDZkRX?=
 =?utf-8?B?WnlmM2E5ejE3NmFZOEZYZVQ4RXM1Snl0eWFkQUdaNk5peUNFblZhMGpqV3RW?=
 =?utf-8?B?aUlZbUVLdmFWbmxFMncxMlN1ZWI3RnRhZDBSeWFEVHRtc29hcjQvU3lpSURy?=
 =?utf-8?B?QTlvbkFBNlp2ZXlYdTNaazB0R21BRjRsd0loOXRNUVpsVHF1NzgwUTZuOTRV?=
 =?utf-8?B?Zjh0ckVrQU13Rng4YWFjRFc0ai9BZnlHODhRcFE0c0U5RnRSdVc1VElkMWZ1?=
 =?utf-8?B?NVNWL3NmRENOVGlxbmNhSE9kMWRLdFpUQ2I1eXkwTUxGaEFBTVFrU2ROZSti?=
 =?utf-8?B?ZjBNeDFKL2w4em15MFBJamtQS0RiQXJXR1FIL2xnZ3ZSMmZqUlNCWlpVUWxC?=
 =?utf-8?B?VzJKZ0tlOVEwa01tajBtRVVFNldrQkJUaTZBTkdrMTBRMFU5c1RWanV2OTI4?=
 =?utf-8?B?YVNRZEJ6NG9UMDYyY04wekJuUUEwUjA1aXhoNkt5aEljTlZONHhxbHVuRzVu?=
 =?utf-8?B?eEJSdlZLY3JidVR5TnNjQXhLR3I5eDNJRjJKQnZYaVZYNHpyZkI3YXRrWE1D?=
 =?utf-8?B?bG5SNlFiRTFHR0doQlIyMjAvS29sU3JMU1VmeHV5YTdvY1JkVkNHUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 577bf5ff-48d0-4118-6027-08ded3a4748f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 17:00:41.8085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct9ukPl4WnKMnDV3/9Uj54G4fsSfPHaITFDB9CWN9enW4bItDU0khaV9kpbvBnRYPp4VPL0iVjoc83H7FTwFpaN0fE0eWfPERvC2GLOcZbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
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

Hi Alexander,

On 6/13/26 10:41 PM, Alexander Sverdlin wrote:
> [You don't often get email from alexander.sverdlin@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently some ARM-based platforms reserve TF-A memory in their own ways:
> - Mediatek gets BL31 region via SMC call in ft_system_setup()
> - K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()
> 

On Rockchip, we reserve the first 2MiB of DRAM. c.f. 
arch/arm/mach-rockchip/sdram.c. I haven't checked how it makes it to the 
Linux FDT but I'm assuming it does otherwise it'd be broken in 
interesting ways.
Don't ask us how we'll handle TF-A changing its location or amount of 
RAM. We also need to support Rockchip's TF-A blob which... doesn't 
support FDT (hence NO_PLATFORM_PARAM=y for most SoCs by default).

When xPL passes an FDT to TF-A (BL31; CONFIG=NO_PLATFORM_PARAM=n), TF-A 
passes it to OP-TEE OS (BL32) and OP-TEE OS writes its reserved area to 
the FDT before going back to U-Boot BL33.

U-Boot reads this (if CONFIG_OPTEE_LIB=y + CONFIG_OF_LIBFDT=y which are 
forced if you built with TEE variable present in your environment) and 
propagates the reserved areas to the kernel FDT, c.f. 
optee_copy_firmware_node(). So you probably want to hook yourself to 
wherever this is called.

Doing a quick grep in TF-A sources, it seems Alwinner is patching the 
FDT (and I'm now concerned not seeing Rockchip in there.... some more 
work to do I guess) which I assume is what prompted this series :)

Cheers,
Quentin
