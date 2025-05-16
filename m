Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71C9C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 14:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1861A8006D;
	Fri, 16 May 2025 16:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Pa+OET8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 990DF80079; Fri, 16 May 2025 16:28:54 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA2980050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 16:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xANqgKuJBC7UWVB/0o5bj2LNuriTWxM1qu4PlIv2e9PqMC686eu9Uomyu+bgDTaZvIvOwSZTPOzDdkhV1K1DelDrDkbtKpGXrmIlWL7NMsMzZ1qOQmISeCfzR2bzoLeNaI9X4ikVhSvWRoJphHKMn4JqrgYj20YVnmTPfUfES8MDaUflZ5rrtt+sbPpsiXAA5dcg1cN3faPXCc86l5VB5Kd8ufewqlG+5MH5RY3dE4rwIUPnPzWJUPZ/DxsV6q73Rw1wya05m3OXK/btGopWz/wI3/87XmosUnar+1Jq2OqbAdJYLpXEc/hj2mmCKr33qL4oqlWd92tuAzJEh/qw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C9LqhCNDuAiL74kWDX2a5zmT3O6keaQSk65LoQCtQ0=;
 b=PukiwK68mDyJqyHp/jrbAeEBslFDLd9q5Iu/1ARRcfyAdwc7m+ZLLaHwRxVOG7feVFDIyKukLvWHoKP6t05q3G7RlKwmNlNYOzOMoa4AnJX32Vx2TIofFqigu2tD76wEqmTjlv+Q/bf2hqQ6p4TnYAGKq+4tPzB7e5EKbyjdRUSkv8oJxXwKBDKK/NCSwqRIMIdUnt+K3N50e2bAWdpLcK/xYAIXhND/Np9fxu2NTDQ5Y4ct5VYJxc/5sSyh2KXk3MfRary2SI6EjyDZUIxfDIktmHHYvILTsgsAB7v41avUSSc60wjP1twRUxpQr0tdbxfHmS5GNBdFL2TJ+9U9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C9LqhCNDuAiL74kWDX2a5zmT3O6keaQSk65LoQCtQ0=;
 b=Pa+OET8OYB7bOyjXFY3u14PNbKVsHWKQGkW6MNioCeNSA4WeRbbdpFkabf5jpiLq4T+Xo1wWXJGX/SJCDzLPfsrsud22VXy8dMXKKMdq0A6z3m3o/Vq6pn04gBcDmcTz0XpluOY2VaZu3CUhAqkWEItF7/TebRgaqeqB8391pBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 14:28:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 14:28:50 +0000
Message-ID: <3c142aee-f6c2-4313-b743-57d7e7b96d0f@cherry.de>
Date: Fri, 16 May 2025 16:28:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 256c5c64-36f7-4694-9afe-08dd9485f83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmxQZ0Rsd0RMSFUxUkNhL1VpTk1MNlJMbllzRjRBYTlkaElzbTh0Snd6eTVT?=
 =?utf-8?B?bmE1Rk5MK0xLNFFhaHRBeDhFT0IwWlREZ0hGbUZsYy90dncrUEhncjAzM0RC?=
 =?utf-8?B?bDFYckZCK1hoTTdNRFF5ckYyWXQ2bjBVbFNPTFBlKzc1ZTJrSzNYUE9QK0pX?=
 =?utf-8?B?cnRTMjRocnZkS2N4N1NlUkErWU9OMmJQby8rT2d6NFpIcVZqWGphWVc2Z2Nj?=
 =?utf-8?B?eWNQUkVnZVRPRW1TMkFPdmQ3ZmRwLy82N2xwOFhMZ0srZVlQcEVJL2tRVW91?=
 =?utf-8?B?V2RvRXRKWjd0VWUycjFnUlpEYjFEcUNuMiswK1loVXBoemFXeUVWMTZqYnhS?=
 =?utf-8?B?WGxkajlmRDVFb0ttLzNmek5qa2VjVkNja0g4bThDVks2VG51NVJtMlRxektk?=
 =?utf-8?B?YVNjWUNzSmR1SU9jT3ljU3RVQkZ6bjNCV0ZmVDRPbkkzWHVJbXBuUVloUjFo?=
 =?utf-8?B?K1Z4dkRIQ1BXajB1bkVLRFhDbEVIWnlNRi9hVjRKMjZmNElmbU53eWYycFov?=
 =?utf-8?B?QXpybWh0RUZhK0dZZlJLT0hOOGxuUFZuMDE5VU9hYnFtZWhndk4rRmFjUERN?=
 =?utf-8?B?RTY3RGU5TFpWV3A5Vlpmc2tsaXpEaWpGYnZkdWh3Wk5VdEU1RXJwMEZtdS8y?=
 =?utf-8?B?WjlOQldZL1lFcHcxMVdaT0RvSjRGOWcvOVhBWUR2VVFrTVVhd0VqbkZOT0lW?=
 =?utf-8?B?bkJjeFlhaEJNaW9DVE10eldvK2JVSHN0YkNwQWtjMTdKaFRqSVoxTW1YQ2dy?=
 =?utf-8?B?RGw0RzE1NVJHUGp0OHRmYUVzakxtU041Y3NGSUZKV3pvd0xrdGRXYS84dU9Y?=
 =?utf-8?B?NDdDSmRFWDB1dkFlRzRrVklVa3NId21IN0FWRjR1cDljcHhmZ1hIRmgyaXFV?=
 =?utf-8?B?YVhvd3BWdHllSUpGQ2ZWcnFLd3lzNTJrL2RZRVB0WEdURGdvWUVVdzdUZVly?=
 =?utf-8?B?b0dkdzM5OEFKTkFLU3dpeXNkTVlDaTJrYThJWXpjMEJZaGlDZkdQMU0xdEtT?=
 =?utf-8?B?cU1OQ2lLRjgrRkdManFmSFZqM2ttbHJSM1dvUjJxVnNvY1NiakFuRzNqaGdW?=
 =?utf-8?B?NlIxa1JOdXFmcU9sMEs2SXVBNXptKzRsOEpoanpVcmJEejdKUW1vZkVJeUJw?=
 =?utf-8?B?MFJlNFl5bVJpYWQrenFKZnppemZMMVBUVTk2RG9TVW0wZWtQODVVbmV3WVlt?=
 =?utf-8?B?WFU3UWdTTng3QlFRQ2tVV1JJTnJaOFlKSis0dXVnVWhaWjhDM1pDYmJjbFp5?=
 =?utf-8?B?NVEwVzE3SUNIRnNEbURNYUxtZDZXVGlsUUpOZlRwemt5OTdMK1dySnlGeFY4?=
 =?utf-8?B?NEtyb0E1VFJlQlQ1UDd3NEtXL3J3OFh0SldtRzRFQ21ldTQvV1JTckU3MmdC?=
 =?utf-8?B?MXh3VUdzbE8vdDBNK1crRmRnZStHU3IvamlsamVwVk9EOVk3ajRWTGwrWHVz?=
 =?utf-8?B?eGlyMXNpK1Azcjd0dHZ5L0tueVRWRzA5eHFIeWRiZW94bi9helFmaW1mZUJJ?=
 =?utf-8?B?dmQvbHc5eVZMNGJ0RWV4UlRXenN2emc5UHRYdGcvY2pnVzhaTTFuajlYREcx?=
 =?utf-8?B?VE9vaGN0dHQ0VmtrSEJ0RnpOdmJ5Ymk3OTBtakhzV05HUnFOOGJIeUM4ZGlu?=
 =?utf-8?B?WkpnL2NMOTNnaTljTHNoQUlZZWRhSllUUktveFF2dFRjMmtrcDEvYW1VWlNo?=
 =?utf-8?B?M3cwUnA3cTBGS3dVd3FKWVY1UnpPcGo3Y1F3REFGN0NtRjdlU3V4SlF6Q21W?=
 =?utf-8?B?cmtDdXI0ZE9tMGE4bDgwc09oTzZUSUZnS09Fc0tiZzNmTitTSjRLbWY1d3FJ?=
 =?utf-8?B?NVhwc2hiNFFHQ0VlM2hKbC9uWDdPL09ScTFzTnZSd2RCd3Z6V3VOUjVTeFpR?=
 =?utf-8?B?eDFvY3Y1M0ZmWW5tVExIR283S0NVUVlQcWpkUzArV2s0TFBxZElSaDB0enFj?=
 =?utf-8?Q?eZduV9f70j8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1VQam00MXZRTmQ0bERsaElMZVpKTVpGVGplM1BhREJqYzR0cFVNYWk0VXJB?=
 =?utf-8?B?MlQyYUIzeHN5SERYVGRObGF1aVN3czh2dzlNVzNnOWY3dk1nRURpekxENWNv?=
 =?utf-8?B?SFJZK09QUWxUblV2amRXN0dpRUcwd295aU9jeE9qZENlNmxTMXd5dUU4UDhW?=
 =?utf-8?B?VGR2ZUJ2VzdsQmZ3TGU5SHNJN0o2ejBuTlNqaFdNWCtMd3NpWCtwOWE3Z3pw?=
 =?utf-8?B?SFRKNEV2OW1IdVVmc1doekdHL0ZMTDJmeWRwMFBGOG9rVUJWaW9qejBlaXJ6?=
 =?utf-8?B?T3ZFWXJHbSt0YjBXRXNEYUxOZWlSTGUyMU1ycXVXYVFwaFdxMW9nc1ErbHgv?=
 =?utf-8?B?L0pkVXJOZERHY2Y0U2srdUlCK0VJQk42ZTc4T3BWZHZVQkhuNTM4akUySU9P?=
 =?utf-8?B?TkZYWmdvc2tITXRtOFc4cFhjMDgyYVFBSmo3TUZQOTZPeElRZmtoeVovNXFH?=
 =?utf-8?B?YUFINUVWb0k1V0dWTGtOYzJsOVM0WHdiU283SllmVjg2a0NPSnhwQWduZHJT?=
 =?utf-8?B?K1MrR2NMbE5Jd0xXc1pvNTlyT29Lck1ocDFrK2RpL3NsVnNUQjU3ckErb3JC?=
 =?utf-8?B?d0VFVnZ5bDVyMjU0MzhkN25tem5nWFpnNmgwSVBHWlFYaXBKbk9MZUx0aXl5?=
 =?utf-8?B?c2JwUFJwTHNOQkVFVURiNGZ6VHZZSGxCUXNzRDl3RERiR2xWYXpTeHgvZEtY?=
 =?utf-8?B?NWkxWWxsRUViZUJtQzI4Zk8rTmxhcXAzK2xkZnJ1bC85MW82Z1JIVHB4MlBa?=
 =?utf-8?B?UnNWYTFHaUVZMVR5dHkrdEk3TXVvNDNPbStqd2VxV0RHSjdHSjc3bVArN3VP?=
 =?utf-8?B?b0NBYU1sa3J0YWJtaUR0VC92dGsxWmxadWNNUk02NXJNNmp4bHdqaGF6SzF1?=
 =?utf-8?B?YnExcWwxZDhJODA2ZVRISk1zZVpWOEErSW4vMisreTNVc1V2Y3FMTGlPSTRz?=
 =?utf-8?B?NUNUSk5SZitvc1B1VnRvM2ZVZHdHYUQ2SmthdWpFTFJ1MmRvZ3NmOHVCK2pG?=
 =?utf-8?B?ZnlEdlNWNzNZbW9TL1c5MHRIK1c5c0xCdTcyS1N0TjMyTzVzLytRUFFuM3NL?=
 =?utf-8?B?M0VvUnZXc3JiZTVoQVVvZmFxOU5SVWJkd054VWI4Umpudy9YUCsvT0Z0R1FY?=
 =?utf-8?B?c2Jockd6Q3o2LzFTcXl1NmhLVlBpdDl6cE5HZExPK2w0Qit2THQzVnhremh2?=
 =?utf-8?B?VXpvaXdSdU5rdXRONnIwREtXYXFCUm1jdmV4b3lkSjJuZ3FHQ21qLzJJdi9X?=
 =?utf-8?B?ZGRHU2dXbkV0YzVESmxPVWhXTi9OWmJqREw5VVBkaEN1TEllRzMzZDF3QmdM?=
 =?utf-8?B?ck5rMHp4LzVrS1ZGUUhsTGhuQitVZlI2bzFROFJ1ZGNDVUVwYzFyWXp5S3Jy?=
 =?utf-8?B?VDV6L1lWb2VwdXlmZ2dNUDdhRnd4VGg2c2dZYzNXLzVxcFZrbU8ySEVCTmFI?=
 =?utf-8?B?NzY4cDA1WUdxVnJiUUYvZUgwRHM4VzEzbFd5ZnVHWC9KSnlNQWsyUllhSzVh?=
 =?utf-8?B?cnpDd20za3R4N3NtaEFFMlJxUllndzJnWjFVd0NUeFBrOUM2M2x3QmJpbVVj?=
 =?utf-8?B?dFU4RjE4bzR5YjhSaUNhV0duTlRPdVo5SzdkOUJnS3dVVXAzaHB4eDlvL21z?=
 =?utf-8?B?RGZLdCt6RWhRMFFpbGpMdk4zbWVxd1lQdHhMb0JTUWErd0tPMkYxcXErU3Vh?=
 =?utf-8?B?ZC92NjVmd1NYVGhvQlR1SFZ4dmkraHNUTU1ibUhpY1N1R0RlVkdXRStYUVNq?=
 =?utf-8?B?RVAreXd0K1FxekNpQWtlYlY2bHEzVUtXR21FQ0g5eXFZQWk1WGhndDhhU1VP?=
 =?utf-8?B?V1JsNHdtejdSeU1PRzIwNkl0c1hieEZmVGY2OVdVOEhpbTl4ZmY5TWF2YTRD?=
 =?utf-8?B?Qm81aGowdi9RUDRMTEpXL2RZdTE5TElJN3Zod1JQb1d6dGhFbktlQ3p1UFE2?=
 =?utf-8?B?T2lOaHVvOXkrRzV0WXZxdDRsWXBPYzh0OGZST3d6dXBQczZVWWZ4SEt6WitI?=
 =?utf-8?B?eWQzdS9IdTdDV2hVSXQrVy9SaUJreVBLNHlsNHZnVWd4ZWtGclB0aG1MT0dz?=
 =?utf-8?B?UXBjVk5WdjRiMFJPT2RSamorRDZ2eGxZQmRqU0dVeTZTY1UvM3dOcnJoQjZ1?=
 =?utf-8?B?WHMxRlovcUhpdXNuZ0tGckloRkgvRFlVdTk1MlpHSXZSNE9RazhHa3Q5K0dL?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 256c5c64-36f7-4694-9afe-08dd9485f83e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 14:28:50.9347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbKHlS75DZ2VB86haq9ZOxDLPoNlZtM4GRdJdlfUOi58InLC4nVJ/xKMPZPcjoAPQE2HhkaJfWWITN36OV0/MbvhnnLRwwJJqcZ6g10AThE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238
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

Hi Lukasz,

On 4/25/25 12:56 PM, Lukasz Czechowski wrote:
> Currently the check in usb_onboard_hub_bind is relying on specific
> compatible string for the Michrochip USB5744. Replace this with
> more generic approach that will allow to add new types of devices
> to the of_match table. Because the driver only needs to bind one
> "half" of the hub, the peer-hub node is used to find out if it
> was already done. In case peer-hub was bound, -ENODEV is returned.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   common/usb_onboard_hub.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 7fe62b043e6a..9f8c1a304cdf 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -9,6 +9,7 @@
>   
>   #include <asm/gpio.h>
>   #include <dm.h>
> +#include <dm/device.h>
>   #include <dm/device_compat.h>
>   #include <i2c.h>
>   #include <linux/delay.h>
> @@ -179,8 +180,8 @@ err:
>   static int usb_onboard_hub_bind(struct udevice *dev)
>   {
>   	struct ofnode_phandle_args phandle;
> -	const void *fdt = gd->fdt_blob;
> -	int ret, off;
> +	struct udevice *peerdev;
> +	int ret;
>   
>   	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>   	if (ret == -ENOENT) {
> @@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	off = ofnode_to_offset(phandle.node);
> -	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
> -	if (!ret)
> +	ret = device_find_global_by_ofnode(phandle.node, &peerdev);

Wondering if uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node, 
&peerdev) wouldn't be faster/more appropriate here?

Looks good in any case so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Just for general information (I assume specifically to Tom since he's 
the maintainer there), I would really appreciate this to be merged 
before we sync the kernel DT with 6.16 (if Heiko manages to squeeze one 
last merge request to Arnd before the cut-off date; or 6.17 failing 
that) otherwise RK3399 Puma will have USB completely broken (I assume we 
could have -u-boot.dtsi hacking the device tree to remove/add nodes to 
keep it as it is today, but better to not do it :) ).

Timeline wise, I assume 2025.10 at the earliest, but maybe 2026.01? It 
depends when 6.16/6.17 will be released and/or if we take -rc1 :)

Cheers,
Quentin
