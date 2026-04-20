Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E28BF588F7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B990842E7;
	Mon, 20 Apr 2026 18:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="juVIxNto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A6284258; Mon, 20 Apr 2026 18:36:00 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51113842FC
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNHck6PHcIeMSqbH/UO8KsBCXUw28j3kapxpZkxbxhgSnsoLrlxRYESU5ALB8hhPNKklGotVrjIlwEvkdt5m8CGkZvjWt5do0ZxeVz9B/4kEIO93H6mvFRMgGmZS+R2WMFI+cyxnrqtC2yKEfukGayjHndWe+cC70a7OJUnXwMu2v2axBy1A1ojoK4xix+fylP9g00Osob6MEkd/cXfbvKgPgAIs09n1TnhGHTIFgHLxce2zZciKlni26HfUb2vQxp16iLil5XoRurH22TWXWCVbQWaKh7+kopsqXbKI3IGk0IRZeTxbk7rnN1fCGHJMTqAnOrQS2ouPpBSIisOnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9ed+GiPgihfGCUqmmfIcdk+3BodpwZiBi+yV2jyzuk=;
 b=KYy0D877NeYkrAZRWYylmaO6jTXmZwwXH1AuFPXnqfKUe84cPzJDk7u3Zm1WuacEz13o7A0VTbq3vXrqmqNxff9hb86lgYySisAFdLCIKO56/NA5Kgd2sPrl4HeTM0Ee/rRxsWNm+2zwdoSP3DcAYRm+WZXr4eWXE1WzKcZaWynxYEaAadQwBwLwqlaGofqBfOUnHAv6QxsDSs1giIKqEDpfVvASzZl6xumg94Wd9GzFu1IoFnfsmbFJEeP5hXnDaqqZB/VO0kOMRSd3im1zoXf1rLarBTVOYKHTpK5dies0NETdTowsrDMi/I/5FSsHFjusnx3khDk138dOSYYcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9ed+GiPgihfGCUqmmfIcdk+3BodpwZiBi+yV2jyzuk=;
 b=juVIxNto46btgDcGVEVniQoILiQcAI5R32jf10u4s33PYB5m1SVMuQrPCfCmwTGoXIitZI0cQVFlhgaGSuaLd/eDPAggSX9Ok06BV55PLxJ1nv77idF0G78bi6/i8Q3gIl8wUi6DitnkM0YgLyzTPLYb4hks35n0GWYXvRPhE/fQXDG9MiZwnMYGb4Ekf4Ozzaj2iLEBGjjRKy03tKmtvR5LEVVrGEaH+3ppXnUAUT15cqYETv2fpEQiJ7yF0YUn2lfXTGOiuBZ7f6V7D8HU+JQOtBOgEvGNZwxn1sEI3EB4UWZ/Xyoxhe59+7vrHfe4ufHu+geiRTxEcv+1D8ScYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB2613.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 16:35:56 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 16:35:56 +0000
Message-ID: <df5d318f-7d30-4806-8ecc-3d6183fb2667@phytec.de>
Date: Mon, 20 Apr 2026 19:35:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] configs: phycore_am62x_r5_ethboot: Drop duplicate
 CONFIG entries
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: ggiordano@phytec.com, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
 <20260420145353.3923395-3-aristo.chen@canonical.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260420145353.3923395-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0022.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::14) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB2613:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3a18a9-89cf-484e-3452-08de9efae58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GMrHMSo2afPwG5couF7F4C4rcHtu11D9HLNGVa7tqcEc+enpCxGGXbYg+dpRYwa71oFXpX+h9TRcm+71aaCsHZtc7+Abya/dGJtsiqpeHUT2KXz39b3mCM/1T+piEpvnxZr/qYb+DLeoWUuBREkisBP2m8YZo2vP7OhPDVrZzAbQNU2B0xVffyeuun9BthzDEpmDVfP82Id8hZPPL5vmjKoBMq0dgRfHx+Q/B2XifqCyDB/4qvZWoMulmnsTPR/PzMqmoaJR6GraT+xqZhm85p2kci3QOHg60OeyDbvS0vXkdIg34sBJAfke5SixdHCYJgJvLs5CMtXqGk/b+pee+mvusMwlwufayftXPbhCHFnuu9mXtlY4oHq0Q1NgtGL2LBh7jlqaMdH1wqpnG0aN+wlfWeSSQKPv3XYUWELI7tRDqnu238C3zrp7MwZ64Ic7fu8K/o/IIDQiDTSKccTWgIDoMV43NbYfNtbcxK8ftRubPAIvU+a8vpgfgbrma+qImkAQdMErr7nSvh+DnkKwCmH/wNn1UpfQhcc4oo4Q5CouJlm6ueyacIcHPDh3d0TRjtJZE44hoKyNC39RrnSPBqwmfb8UYXHIkYh+oH5RewC5aOJVXsoes9lfBrKIs3x2mViCEHvr/O1clTfgnu7l0/+eTpCI8qaluRU5ufAtnkVTBE0jcLms/rJOi6nJLLdyN56pMWbpY+ryxQMq+03QGMOuT9FSQqQOQv5nQ3jiSdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VabXdqWDRQRjkvQVZWYW44NmFXL3JLN1IxSy9vdkJpM2hZYXZ0Q1B6dFpu?=
 =?utf-8?B?R2JNVTVIa0J2eG5FT1VKRlhOcGplY2h1WlVGMUJCaDRmYmU1UWczS1hZdGhV?=
 =?utf-8?B?bCtGcnAzQmNla2hLZ0RxTzdWZXhyNDdTWnR0UGtGeTB5TW9hRzA5bG5xWHJ6?=
 =?utf-8?B?NThXOGFheVJNOXpWeDFKRWYyOUl3N0o3eW1lSVUyRFowK21QUUU1ZzNjZ3l5?=
 =?utf-8?B?b2xNbFVkeE8wbThQei9UU2dwaHU1Z3V3NlhXS1FLRng4czZEV0pWV2l3RWxW?=
 =?utf-8?B?MjUyWkUwYkh1VG9rR2dMcEpiT040MG9VY1ZFT2E2enp0WTQ1Zzk0V0NLUWJB?=
 =?utf-8?B?ZzhqUXBtWUdOQXpQOTVyZEpiVDhQRCt2ZUJLRTFwT0lrUHg5amdlRkZnQnNi?=
 =?utf-8?B?WWlBNFpFN3NCMmpXRmY0VCtVUmcva3V4cXZ2dzlUMDFmcVdnNUQxNlZLNXdk?=
 =?utf-8?B?SVdheTVEUDMvSzBOOG1uMDQ0cXpMaXROR0YvUksxbzMwZDJaMTNtZ3JheGxZ?=
 =?utf-8?B?Rm15dzhvbFZRVmpYdG9sYzZMOXRTZmhlTEJaQitKR3pkcFpTeWxkNzVZM3dV?=
 =?utf-8?B?SFRGdzlkMStxRC84TGRxdERSWk16UDA3d1drWVRNYXVONVYrRk5PdXJDZnV3?=
 =?utf-8?B?ZSt5SXVNMktrbzFwbFUwSm01L0dOUGUxaElSeUE0dy9lME1YWHJ5UWdyS3RR?=
 =?utf-8?B?NDRlMVpXY053RTI3ZXcrbyt5LzNhOWhNOEZPeGtlVVpWa2gyaFZIaXlkOTM4?=
 =?utf-8?B?U2JScHFIQ2FCYjdqL0Y4Uml3Qzk0di9oYjBSRUxYeWZsZStzYTQ2RjBvQjkv?=
 =?utf-8?B?YXNsS2lJbTZXMHBPcjhyOVpMbXp2SGRKZHJ1aFhNM0dnZGIxTW5NVVpKc1NQ?=
 =?utf-8?B?RVl1ZzFGRTRyVW9HcHZ0RWtEZWdhNGJ5eHB4QzNiT052Wllrb2tZYVkzWEpQ?=
 =?utf-8?B?RzFVL2k3OHkvclZlZkh1eWVNSTVXVjB6NmlDMzkyVkFEQUhlRkxYdkJVRnFD?=
 =?utf-8?B?UzlaVGZadzBXSVNhRlpoZTAvUFhIczFsKzlDbEc5bFFaTXg5eFhkSGsydTFP?=
 =?utf-8?B?QVlpWkxQMHF1NEQwZWhCVXYrSkNhOXo5T2h0ajdjLzY4ZW4vaiswVHJicCtY?=
 =?utf-8?B?SXBhVWhNRXplT0dKM2I4UzFmUzVwd25lVkU0TGk0YTVidzNmWXhvSWQ5YzZO?=
 =?utf-8?B?QXJjZW9UeVU1cjIzRVBKdEZ3cCtGOVVBSmFHMk1FSFdXS0Vqc2xBc3ZYdmhi?=
 =?utf-8?B?VnBGZ3UzaEI2aFBtdlJqTFdjWFBvNklKNTZJTFFFeDRSYWROYVlTOUdLNWt3?=
 =?utf-8?B?eFJNd0RkMmtLSGFPakdORGNMaDZ1b25JLytBOUdZdjI1Y2dGengxckRNdHdy?=
 =?utf-8?B?L0I0c0dmQmMrWTBmRWlkMHkyQ0tUNXdrM3VnS3FIV1c0OGl6RFMwdTdXc25k?=
 =?utf-8?B?alc5QlFGOXJaaDl1dXhKMXcxZ0R5VHFmZDgyemRhSC93MFQwTlBXM0JKcmpQ?=
 =?utf-8?B?KytCZHl1VTR1cWNnUXpoNVp1aENxM3N3bGJMdWMrZGVIYlVneC93TFp6bUZE?=
 =?utf-8?B?Rmc5ZkY3K3FFRHN3TmtqT3VoWVdxUXpkUXJWM05MMFdDa1BzeS9Ta1BMWGdT?=
 =?utf-8?B?UkZaV0ZoVVBQQXlUYUZSM2ExbHRzb050NnBVYnlxQ1NZU2ErYmlCVGYxZXo2?=
 =?utf-8?B?aVBNWUoxb2NqL1A2WE1qRXBOMDhEWGZJV3Ntb2RzbnRTUlRwU1ozbElTa09N?=
 =?utf-8?B?Tmo3TUM5Q2NXampndnpvMUczWWRXTkc0T2o1VTkraEwwTm5SV3FhOFZyZi8r?=
 =?utf-8?B?M0ExT1Uwelg5S2ZvNjVvTHNQRkVreU9JUG9zR1psMU9XeEkyNHYzNTRSTTF3?=
 =?utf-8?B?YXAxbWtKc0VwU05qQThrZ0dKYk5zRkpBeWQxOVFIYmV1Vm9INWNDVW1kQmFZ?=
 =?utf-8?B?aUZBY2JuUXl4T0NtcmN5MXVxdWE5MWhTYi9IMngyTWl2TFVSQzBTOTlLMFFv?=
 =?utf-8?B?cGhZdjZCR2JyK2lPUE91aW5OLzliTkJWRG1oRXlRMlo0Z3lsWnVsU0FxNkNY?=
 =?utf-8?B?Y0hsUmF2bzhZM00xMjZNL3BDR3dsKzdDZzZCZXJmdkNETGxKTTZuRWxGQXVT?=
 =?utf-8?B?b082YUg2UnNqOWRSVUhsQ3RaNWZDMFRRNXJkSVgxMXdTc0R6T1pHUHE1amFI?=
 =?utf-8?B?V3RZM1dZUTdhUzFkUW1DY3gwVkhWbmZrYm1yTXU0ZmE1YkMzYVRNcVdSZ3JL?=
 =?utf-8?B?VDJ2TTBNdk05QW1hUGZOOVcyYzdERG82bHdiTkdEUHpkUm1tMUpoODd2eG9F?=
 =?utf-8?B?dVlqTzJLNTVQeEE1WnE5SVkya2V1dTk4MTlOTENBamY0V05BNmhFZz09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3a18a9-89cf-484e-3452-08de9efae58c
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:35:56.4518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGdy8L7VpWz/W9xbnX/BPDmu4HEaebajKDLClnH0lkQszFSmvLWkVCVaM5HFEziYXaZ4UOguZ5Bt+HrUNGCV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2613
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



On 4/20/26 5:53 PM, Aristo Chen wrote:
> CONFIG_SPL_MMC=n and CONFIG_SPL_DM_SPI=n are each listed twice in the
> defconfig. Remove the redundant occurrences so each option appears only
> once.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>  configs/phycore_am62x_r5_ethboot_defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
> index a4434388ff8..b8a686afd39 100644
> --- a/configs/phycore_am62x_r5_ethboot_defconfig
> +++ b/configs/phycore_am62x_r5_ethboot_defconfig
> @@ -23,7 +23,6 @@ CONFIG_PHY_TI_DP83867=y
>  CONFIG_TI_AM65_CPSW_NUSS=y
>  CONFIG_SPL_MMC=n
>  CONFIG_SPL_DM_SPI=n
> -CONFIG_SPL_MMC=n
>  CONFIG_SPL_SPI_FLASH_SUPPORT=n
>  CONFIG_SPL_SPI=n
>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
> @@ -38,4 +37,3 @@ CONFIG_SPI_FLASH_MT35XU=n
>  CONFIG_SPI=n
>  CONFIG_DM_SPI=n
>  CONFIG_CADENCE_QSPI=n
> -CONFIG_SPL_DM_SPI=n

