Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F2C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91148083F;
	Wed, 22 Jan 2025 14:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tQJai+Mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A1380882; Wed, 22 Jan 2025 14:55:22 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD8F8083E
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 14:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhtvCrw7BT1RkNOqIUSKQzrA6QR3tqvnCqc5dWR2ERPDC4IQwpEbd1PtZjAFvJfZz35l9Q6cNOJ+cfBfU40tT09WBY1YKigCivr4ijGcKObBkfcluxpqI7QMMyb44wbREHM7KMKqghRes8lnZcZZ1d2ymF4DQtSEcKDa5Odw11z+guDHp+KBzbIwpCwBbn2w6d6vU4sdQ7W6wvhdXm2H3Y7c775t4ej2lQGEJ1PgYU4TYipS93cPAlCwhJmrHmQhor30HObYTYsgs68EFDoa7k/7OdJ2eOMQaR4Jl8IBQwFS3KRNoRyO0k7eg1r2vs35jBjjQBtKJAo6NMH2h8p6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOCSk+fNYO0jXMOWt4R0x1UTpsk4ru/wcuOEUQ2Z4bM=;
 b=h2MvZ573LG7FCCk+Y+ZXPavdNKo/D1eRos0pv/EqBY5jh1XothtEqCzEsulmopTwOP3helOOpvpE3th/fy5wMd8JtDO0NgTa8oh5qLofpKAWL7knXobGo0aFSw307qXCyUd7QFKtJptGgAvIe3/mfz6XG41/UZugA0fWHv4DAiighlqGvR1iHKauW2kJGY6p6uOfIDSJStpG7DejaQZX+mghtUfvKVwQlORZodidCIyShGqfSmUtfOFnvQ59m/teOg8ExkhkVaH+K2BS3zhWd17TJrbSQXWLrhnUoM4h+6+lBxJe0ybA2ILl/wt9PGOV1z/Zo5BrXFa4GrNDLKXjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOCSk+fNYO0jXMOWt4R0x1UTpsk4ru/wcuOEUQ2Z4bM=;
 b=tQJai+Mxq86PD72dE/CA7RB++X3/FqWV5rivTg+gh14J29LoeYoUW965B3d8KCJ+xOIGDZUPM0tpGZwE+tlT9cDCyvIACtdfQUFkU5IzIzz/GthmkOmd0CVZtzDxmpzG3szN4NDK3aWw7kFAdi24GllkqD1EZyRPJEtotKtFwwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 13:55:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:55:16 +0000
Message-ID: <cc078088-4ba5-45b4-8dbb-9f3672bbb726@amd.com>
Date: Wed, 22 Jan 2025 14:55:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net: phy: Let gmiitorgmii converter create
 additional PHY
To: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Michal Simek <monstr@monstr.eu>, "Katakam, Harini" <harini.katakam@amd.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
 <20250116054324.836712-2-tapio.reijonen@vaisala.com>
 <CAHTX3d+Gb+KHHLaDpuHsei+4aQVYk=+urG1u-MaxcaZGdeHmMg@mail.gmail.com>
 <63c7d675-1db1-4613-88b0-0c2229a57867@vaisala.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <63c7d675-1db1-4613-88b0-0c2229a57867@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0243.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: dd03d104-576c-4193-6234-08dd3aec6687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjlqbkptR2RjT09Va1RjdnVOQjZvWW1qd0lHbGcrdlpRYzdiK25nWnZ2c1Jk?=
 =?utf-8?B?bkk1OUFhTldPZnVFNFNUa090a2c1NXAxSFE3R2xxYmVkQ2pEQ2syWVI0RGtC?=
 =?utf-8?B?TW45SUQrOGRJY0NGZnNyMVhQd3pnSmduOUpERmlYc0ZLZnAxY0JISEJ3Ni9s?=
 =?utf-8?B?ZGNXSzlvblI0eFpueGpURlk3a1VEakc1NEE1b09uQUFIQS9FNkhTNjVhejd5?=
 =?utf-8?B?cmo0LzN6S1dNSmlSWkNsYU5UZVpDRExHc0hGN1J5ZkdYa2NiUTY1TzdsUG9a?=
 =?utf-8?B?WmkvTytSY1hLcllxZkVBSzJtVWZjKzcrM3dJUjVaeHFMSkpiRFZIWGVWTWtv?=
 =?utf-8?B?T2tRc3dmODNoaFpGRTg3OFVjcEo4UWFwN3hWV0RYOVJkdTMzajNEd0FjOEdL?=
 =?utf-8?B?MnNHM0ZLSXJTUDd2bWc1RmRtZGoyK1RXWkxzK0RTREpJRE5uZzlVdElJQ2RJ?=
 =?utf-8?B?ejh5OENhV2ZzSDRBMTl0Z2pMZmtPQlg5S0ROemZ0b3MvaTQ3UVArWmZDTnp1?=
 =?utf-8?B?NVVGQXR1aEdnemlUbThlS0NKQ2wvSmxlc0p6YUVTNVE5N2RrcXY1c2tEUzA1?=
 =?utf-8?B?T095WnRNK0lpU0F0N1hDRlFTbzB5cVkrRldoelBaVktOdk0vNmp4dmNYMVpO?=
 =?utf-8?B?aU1IVGE3b0ZPWFhmYWVESTZTaUtXS3dhMUI4ejhlTzRKU0VjSU1rd3R0cjFs?=
 =?utf-8?B?aVc4SC9xUFNyVStXVkt4aFhkSVhhL3NhWWt2MDVOcVVBRDRmMjQzcEl0L3JN?=
 =?utf-8?B?bE1INUY0Wm9FTklGUVZjVTdDOXk2YnN3VlFvNmxwM0xvSlZoL3pVMjRsalUz?=
 =?utf-8?B?Z2djQS9jVVQrOCt1cTUrNVFFKy9lbjVxSTdZNDlsakJzbmxXdVdpNUN2djVT?=
 =?utf-8?B?OU9scDl5Q2M2NVl2SmJXdHNuRlpXbjZSYmRJYnE0RTcvVjRMRUdPRWx5Q2dE?=
 =?utf-8?B?K2VyYUMwKysxZmNUZVo1V2hZTzdLSWE5Nkk4VjBMWXQxTmxRMnFoYzA5cUYv?=
 =?utf-8?B?bGx3YWRqM3pGeVZBVVZDRDhTWEhjb2g4K1VQMTFqRzUxTE9LY3BxWWdqNndS?=
 =?utf-8?B?dlVhRzZoR1R5THJyZksrOG5MRVJVcWs4eEV3b0t6RkN1VHd6d0tkNDFlMGla?=
 =?utf-8?B?enBhTXhDbXpDQ2s3MU5xWWs4eTNFUU5QaGhJU1dCc1F3WUhVVVR1dE5yWEZB?=
 =?utf-8?B?WEdQTHFLMG9sNWIrVkFGbCtKMWQ3SENUdStNY3Q4TENMWXk5N1VhTWthOXBz?=
 =?utf-8?B?eG1tRGFYczBWVEJNNHBrTjFhQ1Fua0p4QkFwVjhrUFc1cVBPc1owV0xlQmw5?=
 =?utf-8?B?UVl1Y05GazJPUnpMREF2SkhPWU5hZWF2NzV3WmY1WFYxYU0zdWdKaTRObTFw?=
 =?utf-8?B?RHJSVDJNQTlreThZeDJOTTExNlk2YVdXMVBGaWhiTDNMMlZDUmVIek1XRVJG?=
 =?utf-8?B?SEpEZ1Bwa0lZbGJlbHB0VGQ1azNQUTdwcTZpRnI0dVFsTUdjSTgvTXFoUGti?=
 =?utf-8?B?QzZpMk9td3BZL1R5N3lCL20zdmlEQ1pTbW5qWVJWZmUwVnhWUVZjbUJkN2NM?=
 =?utf-8?B?RG03VnByMjY1MVlHdVlOaU1palF4L2dPUlpxcVVKWW9PSG5COWNOWGhtcEF0?=
 =?utf-8?B?VWY1NTRKeDFRdXVzRE5CTjM0MmJRUk9tSFZ6YVpYcUFUMW9TNkM1enFHUmZY?=
 =?utf-8?B?bFNoR3AxbjlEdTFNaTM1NTFZRXpxYW9qRTdWbWFEQWVidDlzNzYrZUhRK1Fu?=
 =?utf-8?B?WUEvYUxnS3dtdVYxemxJYk14TDd4dlg2b2UxWnYyV3pKeU92Y1ZVNUoxNlZo?=
 =?utf-8?B?N1A4dVN3VDFFczdwT2plRElyYzMxZWQ4RE0weDY0QjlDZitMSUZyVGxBbkpP?=
 =?utf-8?Q?tOIleb+kf+nCU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZ4MTZmNW9GMTV1ZEVQaGRDeWdXTUpMWFZUazE2NVVZcXkwdWh1aytDV3lG?=
 =?utf-8?B?MlpYWEIrWEFTdUJuY1hxU3FjN21Uc2VDc05hbXBYN3VoWHJtMDl1KzhuRk5v?=
 =?utf-8?B?MTVjN0RNR2JCa1FlR2VXUWFkUmlIWHJ1QU1tZmNqTjlvZW4wa0pEZUJJejB5?=
 =?utf-8?B?anptRnFaMjMxSDI1TDhDTFZNRFZCN0o2MXk3QjUwWGJyTW82Z3hUejVhRjB2?=
 =?utf-8?B?Q3lTTmFVTndSeWoyU3RsU1RYZlY5UDFIRXp2blM4T25oNlFWQXZXQ1pGTHNL?=
 =?utf-8?B?ckpxRnZTbkpPb0lwaWpSUFZOU2gveHFJdStqVk10c1diZ1VodW9KSmlWR1c1?=
 =?utf-8?B?VVYrcEpZbzdmanEwRVdZdzQxdUtmcEJjNTNyNlplL25VNTI2V0l4R0FCaWhZ?=
 =?utf-8?B?eFhKZTlVQVl3amdTME15TWlVYUU2Y21uVXp1VWFTUHVESnA1MnZHbHQ2d2pO?=
 =?utf-8?B?aWpEOC90eW0vNWFWK0NzYXhxTUNUcGNqTjlHTHlieTl3cnJrdUNIOHQvMkhZ?=
 =?utf-8?B?Z01kWC90QllrNzAzYVFLY21pU2RxbVUyaWdiMjV2RDFDRWhDbEFwNDB2cERD?=
 =?utf-8?B?d3Y1ZzVyOWRJZUpWTmJneWd3c3FoMGo1dWJYRmlQMDEwNVM3aGhsVjg5dnhL?=
 =?utf-8?B?dElIemlNQXFid0gxZVBPa0NkRzRMM3lyZVZ2MXNJSzY1ZkdRY1RnekgwNDNq?=
 =?utf-8?B?R0JRR0RrM2xGTXZnbTBmd2F5NXVZMElocGJKNm5jYU91M2VRaldrTVN3UHBn?=
 =?utf-8?B?Q2JBRmx5NTA2MUxyT0p4VUY1VVZYcllPcTVlenRITXF6aTIycS9uamhHVEUx?=
 =?utf-8?B?V0lqRGVkWHZxMWVzTnJyKzc0c2Zsc0gxaURNMk5MUlg3OHBMUzJNbGY4VkNN?=
 =?utf-8?B?MFRIQVZJTi82Y3JmblA2blFucnFmYzRySmJnTDBDMXROc3B4Rjl2V2NSRGhw?=
 =?utf-8?B?UHpwRzRJbkIrVnpKc3YwQ204QTRSRHlQc2RHK2NoL0N1QUIyMkoyN3RGZGsx?=
 =?utf-8?B?R3VkemhMTEJlWWFaenVMYmp5TndyQi9HQzgzUFFmZEtxZDZiRm91Tzd0UEZV?=
 =?utf-8?B?R3lINFAvNnNqZEx5Wk14UkhFVUdKNnZ0eGJFREY4cjdrT1grR1dqYU9WeHZP?=
 =?utf-8?B?ekVrd1N6cksxSnAveFFHODBzWjlWNkt6MDFHQ09zQk1RZldHZDhSVFZ4UVRm?=
 =?utf-8?B?V0ZzbEF1K2JxYjZ0cG9kRlJlSU9QbjdJNkVjUkw3NHZVRS96elF0eGJNRml4?=
 =?utf-8?B?Mk9NZVF3Yk82eU1Sd2pydU1VVEZVZW1DRzduclA4S2lNVis5S2p0c0ZBcXlQ?=
 =?utf-8?B?MHUxMStjUmgybmhkUEhva3J5Y3ltcDlneEZzNGxJcHJNcm9yN1JmZ2N6cC9y?=
 =?utf-8?B?SWlIS3gvMk9VRnE4bTZZS0F0cDBCOG96QVM2UDk4elc0ZnVudmxwTjhLY1o1?=
 =?utf-8?B?cjZUTVVkQXhnY2FDY1llMU1WVzdFT1FhMzAxblBkcEJWQ2VDMlpjQ3dQMzRi?=
 =?utf-8?B?VnUvQkpzL0F4OW1kam9yRklhaFFNUkJSdi9YQjNnNHVWS0VlaHFJbnM0angr?=
 =?utf-8?B?K2Z1dThRME5YSXdnT1VmU3lVVkY5ZmZmd3pPaGxsUmc3M2ZxVzJsemRGZHdU?=
 =?utf-8?B?QVljeERzUU1sUU1MREdiRjNwUVowOU1JcWNlem02Q1ZUVGJueE4vc0ZpU1hM?=
 =?utf-8?B?Yk5DZ3NwSm5NM1lDRFV6UVlLZmJEK29PT1A1TVVBeS9hNWFmeU1PWkxSa01F?=
 =?utf-8?B?KzF5bjUwVDYyTXhNS2hrZkl1V0RBN1FlYUx2QjYyMEpiZytZc291d0xZdzdj?=
 =?utf-8?B?eXhSU1cwZU9hQ1NMUWRneXNHSGZxL040MTFSbnIyRGNFdFdJVFVuYTZNbitt?=
 =?utf-8?B?cDNqRU5kV09xc1FJVS9aUTViVm9weGtZRU9zV0JDNFNDc244RFZuVktpdDZO?=
 =?utf-8?B?OTY4end1US85bjNNZHNxVkxhVS9BUStPSE9xZVlqMHNWU2xZUStxdTdIUHpi?=
 =?utf-8?B?YVhydXliNGVkSkc5ZkpGTUFlVW1Kb0FqNWMwY1dkNCthc3k2OFJqU0ZqT2cv?=
 =?utf-8?B?Smc3VmF1WUpzUFZwa3h6KzZsdGZhWnVaWnBnU3hVVm5OQ3BNb1grR3ZPakV2?=
 =?utf-8?Q?2ts3Vpwu9BqRt89nl/03kAb1s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd03d104-576c-4193-6234-08dd3aec6687
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:55:16.5792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYFVYndNAZsc2IDRLb8TI/oCu0T5DRwla2Hg+DjXLw7X/SvTwDgDbujjxfzZRY2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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



On 1/22/25 08:31, Tapio Reijonen wrote:
> Hi Michal,
> 
> On 2025-01-21 15:14, Michal Simek wrote:
>> [You don't often get email from monstr@monstr.eu. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi,
>>
>> čt 16. 1. 2025 v 14:07 odesílatel Tapio Reijonen
>> <tapio.reijonen@vaisala.com> napsal:
>>>
>>> Change the order to connect gmiitorgmii before PHY creation.
>>> The gmiitorgmii create additional in DTS configured PHY during
>>> it's configuration. This ensures, that converter sits between the
>>> MAC and the external phy
>>> MAC <==> GMII2RGMII <==> RGMII_PHY.
>>>
>>> Fixes: commit a744a284e354 ("net: phy: Add support for ethernet-phy-id with gpio reset")
>>
>>  From format. Look at link in 2/2.
> 
> Fixing format in next version.
> 
>>
>>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>>> ---
>>>
>>>   drivers/net/phy/phy.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>>> index 716a1d46111..740533adeca 100644
>>> --- a/drivers/net/phy/phy.c
>>> +++ b/drivers/net/phy/phy.c
>>> @@ -939,14 +939,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>>>                  phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
>>>   #endif
>>>
>>> -#ifdef CONFIG_PHY_ETHERNET_ID
>>> +#ifdef CONFIG_PHY_XILINX_GMII2RGMII
>>>          if (!phydev)
>>> -               phydev = phy_connect_phy_id(bus, dev, addr);
>>> +               phydev = phy_connect_gmii2rgmii(bus, dev);
>>>   #endif
>>>
>>> -#ifdef CONFIG_PHY_XILINX_GMII2RGMII
>>> +#ifdef CONFIG_PHY_ETHERNET_ID
>>>          if (!phydev)
>>> -               phydev = phy_connect_gmii2rgmii(bus, dev);
>>> +               phydev = phy_connect_phy_id(bus, dev, addr);
>>>   #endif
>>>
>>>          if (!phydev)
>>> --
>>> 2.39.5
>>>
>>
>> I can't see any issue with this swap but I would like to check your DT
>> description first.
>> Can you please share your DT fragment which describes this?
> 
> Here is our board's DT fragment:
> &gem1 {
> 	status = "okay";
> 	phy-handle = <&phy1>;
> 	phy-mode = "rgmii-id";
> 
> 	mdio {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		phy1: ethernet-phy@1 {
> 			reg = <1>;
> 			#phy-cells = <1>;
> 			compatible = "ethernet-phy-id2000.a231";
> 			reset-assert-us = <10>;
> 			reset-deassert-us = <400>;
> 			reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
> 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
> 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> 		};
> 
> 		gmii_to_rgmii_0: gmiitorgmii@8 {
> 			reg = <8>;
> 			compatible = "xlnx,gmii-to-rgmii-1.0";
> 			phy-handle = <&phy1>;
> 		};
> 	};
> };

That's what I was expecting that you have and it is not your fault.
I have been in touch with our team in connection to proper description of this 
situation and description above is unfortunately what Linux expects but it is 
not correct.

Description should be
gem - phy_handle points to bridge and bridge point to phy

what you have above that gem and bridge are pointing to the same phy.

As far as I know there was no way in Linux kernel to describe it like this 
that's why dt binding for linux kernel is different. (And by purpose Linux dt 
binding is not describing this connection from IP).

It means I am fine with the patch above which let kernel binding to work but 
please describe this reason in commit message.

Thanks,
Michal





