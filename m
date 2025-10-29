Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F6CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 15:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF978004F;
	Wed, 29 Oct 2025 16:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KGXnv1V0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28ABE8004F; Wed, 29 Oct 2025 16:39:32 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5BA8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 16:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBAnnmy6581X57RD+epRftehnY0t/U3uyuWXKyOdHgP/K4lwF9ZfSgaVT2gLJ1uR68aHTOZaxfFtSfrPrBXOTpvcNKx8K03CoLUjuBeJZODroBvhdk5HFkJiTpPss3WO80/ppj7GmTGrexE1J7Wrc/XMQvxgm2Ao1KjSuf1FebAvcipAYb/9Oo/xS/wH2O/lf7ASQXDa7GGdUD3FAAuS+5lYxuOf4dPwkIq46tqyO36PaHCJGrrX9lf0dWBhJyvfnc4blz+u7RNzuVSwoCDwL/UukGgzX2cfjTgm+qgYEgnTjjnnjs2gAakNJtnaGMFE1gE/6Q+tPIE0lxqmWkApqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbPAcRq3kdqMm3yKJ3rMBj90Bp0QsZqXfzPcaGBOHwI=;
 b=cMZU4aXawAxddEvCro66G9ujVqYJLmYZytNVCFXFGxsahCNKFFHZvbJVN1A+g3EgU9J4C5prF1Y01FJvhXsweZxwKvYdMrUdcZ0KRIyvv6FPMsLX3ttWNIYQ7HeGMAshnjjzIyOQ5p+gFvWabo/IbHbAs6yHtGpB/H3W2eREjfIB9wzINDTOBcc+tEtvNHhhW+2n76LD+BClonJ1hg88UrmH2RpupIygQwj7+vkMUkbjzift1QMoaCTUYYE9wEA7CiP3MhbjnKUUXIlTIxLa4L/TWWWFU2gvUA6uh/VWYI7nRybz6mfJFFulvm0Pal8Wh2teFfGCj2JBnc0+yCGjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbPAcRq3kdqMm3yKJ3rMBj90Bp0QsZqXfzPcaGBOHwI=;
 b=KGXnv1V0icWdqHWhG4GVnaOvicZNzC9jedmyN4fBBnOyhlIQ3kc8AyKyOIQiCt/8bT92dOZAjJpn0zJVZFVDQgK8LMw2yJ+J/4Al2XM+RCTqjTvHr3rUCvyqzubZwTYms8/kTgbiyfUcqCobyeB38zOJX5QXwZ1IcNntk1QHfxG48/FMKVoRj9UGLmix7LM8tmZaEH1dzZ6kBk+Uz5bnMPhzYY4lL6x3IPsyRc0Z/MKw/JpzHs1XkgMdhR175zQN7L+K0o9c5lqLVkZztvAD0LwV9hwMXWWTcsKoeDEylcLblz4ThMpdm08g+7xf0si5qiqyjDJvfmsd+qNxjchxTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS4P195MB1576.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:39:27 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:39:27 +0000
Message-ID: <9dba627c-4e6c-473d-8417-b176011fbc7d@phytec.de>
Date: Wed, 29 Oct 2025 17:39:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: mach-k3: Rework spl/get_boot_device()
To: Anshul Dalal <anshuld@ti.com>, trini@konsulko.com, afd@ti.com,
 n-francis@ti.com, s-k6@ti.com, bb@ti.com, ggiordano@phytec.com,
 b-padhi@ti.com
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20251002130455.1795794-1-w.egorov@phytec.de>
 <20251002130455.1795794-2-w.egorov@phytec.de>
 <DDC0SM36IAM0.FRMOZ81MG22S@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <DDC0SM36IAM0.FRMOZ81MG22S@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0040.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::29) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS4P195MB1576:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ed9126-dd83-4cd4-faf1-08de17015807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHJQUUJXUjRVM2lIeUZRcTRSWnY4dm9MQmk3Z3VTRFhNdFdSaTlwMVBjUWNJ?=
 =?utf-8?B?RkpFNWV6WXlpQldoaXVzRnpxUDZiRjFwU1NiSHc0a3RzNndqalFFQ0RRQUVG?=
 =?utf-8?B?WHJEMmNMOXhkVWdGNkNRYjBoYUwwUVN1M0d4cHA5QUtDRHVsdjhqOVBlMC9o?=
 =?utf-8?B?QWNaWDJTYzB6ZE4zTEFMdi9DcldpMEYxQTQweDlSdVRkTkFPakNKRXpFeXFQ?=
 =?utf-8?B?bEtyeEJIc1Nsazh3N3FHUWNpaDdBVmg1dWxGanFWQ251WVFHN3A1V0RHemVy?=
 =?utf-8?B?RXJPWjRoaWRGYlZDblg4c0RrQWo5UGtaKzFUNldPMXNYTXBVOWZVRkFxdGRa?=
 =?utf-8?B?SDJqV09QSlVvUHRTbjhuU0puRU40QmtSazZndU5vakcray9ZcWU5SWJTMEZP?=
 =?utf-8?B?ckpZRDNVRUQ3eXphL3Z3TnZSNm01ODZpQkhMR1ZBWXNBcWpMU0xVWlpBQ1Nt?=
 =?utf-8?B?emdlY08wbnNXSFcwZ3N0YXBaait0dlVLazg1L0RrMVFOTTh5TG9UTlJWd1cr?=
 =?utf-8?B?cFNuS0VFN0ExWU80WmRZYTg5ZzRuV2FqeWVVU3dYZmszSGxQaWtVTUk2cEZw?=
 =?utf-8?B?Rk0zOHY5T0hVNTdlcStGWHBoUFlGYmlNNEl3N2Vrc2hEKzcxVmE0VkdpcnRz?=
 =?utf-8?B?Mko3anV1eFlSdUhnbTlmNVVZRktwUHkzVTh1bXR3MHN0SDE5VHVUK1VXUmZN?=
 =?utf-8?B?TW9vTlZUM3ZCUGJpS3BnQkhqdHB5cFBVS3lnQ2JnY1R3NDNWUFM4ejVzcEJs?=
 =?utf-8?B?ZGNGNFJUWnY1VlZpYkRGaXRuTmxXYUQrRnhYa0RGckdCT1hIN3FCSEppd3BR?=
 =?utf-8?B?Q0ZPemtQdVh5d0FnOVI5OVdlYks5VlZNdEFxVTdhdTNUcTA1RmNHaFdYRlRY?=
 =?utf-8?B?SWpQbFIrc3kwYVZQTVhTZWdIY1VqbkhQa0FjdVM1dTU4SEhpNlNUMnF3QktR?=
 =?utf-8?B?dkcxR0twaE85SC9HeExlMlRZbk9WaU56Vkg3OUswUHRxcGxybGt1b2VzdFBP?=
 =?utf-8?B?UEtEWFV1em5qMzE4dm5LY1Rna2t5L1Q3eWJBRXd4MmtCTzVDdVhPbTBLdlhw?=
 =?utf-8?B?cVVRV25zTERGWUNGWXovSUNnQXZvQXFWTjEyU3VjdXkyTVdEWCtPRGF0VU1k?=
 =?utf-8?B?Rjd5M29TOUxpZTliYWFxQVArQVRZcXVjc2tSRTRhMkQyZGg0YnU5VmNPS21O?=
 =?utf-8?B?YmxVV09PRjduUHp2VnNsWXNod1RTVmVFZytIc3hRZjJEY3l5OWNvN0RURkx3?=
 =?utf-8?B?dmRIVXRnaEQ1dlc5MlF1aURsdDRFYXRFNHAreFNKT3BuKzQwdHp6NHVZQXNH?=
 =?utf-8?B?bUovU0g2ZnFTazBNbUJua1poYmo4WVhBbmNKM2RqSkJsckdMZTVCVktwSlY3?=
 =?utf-8?B?dW9sb0xybkpzWlRPU0dlSkg4aDRPNDViTHM4Q1hyTFR4b2c2S2h3cGJ5QkZ5?=
 =?utf-8?B?RW0yekJsc2Zjc1J4MFQrdTFZMVRFekF3NEdtV1kxcVRnRzFnaHRZcU84ek1Q?=
 =?utf-8?B?aEF5bTQ1bUtwNUwvSVlaUzdGTlp6d1V0UFdWNWpld2JGVVZFWTN5Q0Q1Ymx5?=
 =?utf-8?B?OVJ0d01DWHZDak9sOU9nN0FJTEdIeFhjbHZkVkQvckdNVXYzNTNUMjNodHVI?=
 =?utf-8?B?eEJ3c3BHeDJXZE9LN2doSHlnVGJVVVVQSjNZL0dOeW9pS2JXdHh3T0p5VSs1?=
 =?utf-8?B?elB4NDZXUFV4SEl1cWlaNmZFRS9ER3ZzR2QyaHg0UnNDR0tBdmJtY3FFQTRK?=
 =?utf-8?B?ejZDY1JYMW9xTXROL3FJdXZTQVpaSDBCeU1lOE5FZFhlN1F1cmtUQy9MRW1y?=
 =?utf-8?B?WkJWUWJENjFRQVFXSWFSb0lpSHJTMHNwZU5wbC9FWCtSVnppLzk3RUMwNHRz?=
 =?utf-8?B?ZlRRK0phbTkwTnVpbFg0M3RwWFlhcXBjSTl3WEplNjFMZXRMcVU0QmVRdDg1?=
 =?utf-8?Q?7JnX6iOANL6JRxS7WWKF/clS7wzXzmRa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVOcUhhbUhzSXN5RGFiTGlhZnJMU014TE5UTUk5dTFrbjVlc2J3V2I2V3RG?=
 =?utf-8?B?UmtRaUxwTXN2aS9mODBGZFdmZytUMU1DK2pJeGhGWDFxd1llWDg1VkQrRzM2?=
 =?utf-8?B?TUVCQUR5OUt3ZWhlQVdEM29WOFFhd0FOOVA1YndsbkVzRXNWU1Z6NjYyT0RS?=
 =?utf-8?B?UjNJWmx3Nk1QbXlDMS9mdjRIUTNYd3l1ZEptTkJSYXg5Q3N4MVJONDQ0aFZr?=
 =?utf-8?B?eVdvR3dBbVBSL1RHZjZwSTJKakIvS0d4N3hUWmplbFV6elpFMXFLZk1UL1Mw?=
 =?utf-8?B?Y0xtQVE2ck05YW1HU1g4dVExNVFMV3NUaEFFR243TlkyeHhXN25zc1V0RG9R?=
 =?utf-8?B?UjNNOUhzQk1BY3ZtdHpBVitZYUV5NzN2UUhLUC9sS0JVdjFhNkhRcUdxTFpR?=
 =?utf-8?B?aU9MWjBYYUxad3hndkt3MTZjZW4rTkF5c05HSGNQczFxeW5oY0c5N1pISVpm?=
 =?utf-8?B?aHplZjFyQWY5cjFxYkMyZkx0c1ROZU10UVJGT096YTdJYnJvOWgreG83NFow?=
 =?utf-8?B?MWNGOFhOUmtFbTBkdzV0NHZsSG1FT2E5SXM4S0lJb0xXWnBFOWJTeEMxQmtF?=
 =?utf-8?B?TW5HbnVZSXBvOENKdGd0Yzl4QWtSSCtDcnE3VmkyMVoyR2QwQXRnNFQ2Tnpx?=
 =?utf-8?B?M28xVGJoOEpkK3N4S3Z0bGxKMVdGeXNPQ3pMQUJGdG1nMk0vM1Iya3htdFdj?=
 =?utf-8?B?ZHZ1bm92OUZrdTFISURIQ21ZakRzZEpEd0swSldEeUg0ZXpVYTVyM29HY2Iy?=
 =?utf-8?B?Qk83ektpNnl1ekxyV3ZTYTYwMDJMMVNYSEV3aWZkUHRWNGEvb1M5b1l0bEhu?=
 =?utf-8?B?RGNBQnNYcHdCQXB5MFZ5QjgwK3p6ZmoxZkc2aUFic05rWnQ3b2tqem9NVmlx?=
 =?utf-8?B?bUNGUmJpY3RVZldYRytMZGhYcDQ2SUl0cVdKTTVzZXNiWUFrQWlOUGU2TTY1?=
 =?utf-8?B?MnVRRE1JdTZCWjI5c0lucjhhWE03Y0RPek03YXErZTNKQ0hsQUp4MmUzZk0x?=
 =?utf-8?B?c0l1OU5iZTN2WUE5RTIyMDQzcCt4Q09ja1pYOTNnOE5jSmQ3c0pZYWNJWU1a?=
 =?utf-8?B?R2pkdjRTM3BvV21mbDV4OFJGOGNQSHEyVXBqYisyQ1RtVXgybzVYNmZMcjJz?=
 =?utf-8?B?ZndYRXJ4cVNuV1UvalM1NlJSa2Z4UWRvVnhiS3R4N1hpRWRPR0JVWnJVL2pr?=
 =?utf-8?B?SVlwRGVGQ1QrMXFBRjcyV0RJdEJ1R2hIZWpyV3BXcmQ4eUJOTGZoKzg4VHlt?=
 =?utf-8?B?dkk3bkZyeWhCMFJoR1JIaWFlTzQvaE1yc1R6aUliN25kRlNUUWd1VVRGQ2Rt?=
 =?utf-8?B?Q0djbHNzNVpDdzRKMWZrMmxvd01GRFlNcm83Z2RObnBCdzJ4WWkwMElMbDlw?=
 =?utf-8?B?NHI1UWZvdHJLOWRFSVF2bFBObVJ3MzRNUGl5dkRVZ3B1NGtLbldINUhDalJw?=
 =?utf-8?B?VzFzTHBMMngvdmthWFl6TG9BVm0xTzVCOWNmOU9RTjRvY1JnTFpmY0ZrUDJz?=
 =?utf-8?B?MlZUTlBvRk55TzZQYk5iYjBSRWV5bDZYbzJuellVc3ZTaUx2ZVRWL28xRm1r?=
 =?utf-8?B?dndwdGE3MllpK292WWhpd09RazdZR3pBcWJtM2xEMlUzQW1WVXJtRWY0VVZa?=
 =?utf-8?B?QThFc2hjdXpISnhmdFFhejB2Tm5ON203VFh3MGtSbmY4K2tEU0tkd00xM09H?=
 =?utf-8?B?UnpCMk9ka0M5R3RhQ0VOVHpxOUFGaXF5SHk1cUprcW1hampFMFJhTnFkTTFq?=
 =?utf-8?B?UUhmK3k5QXFQYzh4WGk2NUtiZHowczJIUHhFaFVveFlod3RkT2MzbWx5Qkw0?=
 =?utf-8?B?cEVlVUFUcjZpVTRPOVRGR2o4QlpUZEFXR3Q2dmRlbE03T2l3bThTdG1Qbk9j?=
 =?utf-8?B?UE51aEdiTDYrZmh0UkhMM1kvY0RjWFJWd2dDd2FwbUtYZ2gwN084K2FuMkNY?=
 =?utf-8?B?MDdUVGlMQitCR1hZZmNpSzZCVjZiSUE1dUh0VXJQOEF0WXFVU2ZUc2FqNlNT?=
 =?utf-8?B?RFV3N0R6NXlQTXlVR3RHeUVqSWpPcXpQRWg4MzJRWSsxcFhiWjRTNUFncldh?=
 =?utf-8?B?OVp1d3FpZXZpNTZMbzBxODhzTzZwZVROODVNTTV6a1A4dGQ2SXI2eVhpWnpZ?=
 =?utf-8?Q?X2FbM0Lqxn1M6w5yz2Kg9lPmO?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ed9126-dd83-4cd4-faf1-08de17015807
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:39:27.4375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Gc+a2MtOd8qEKfQ/5ylyCC7gwnNU1oDl64khyv4oMcHNXA9oc2yxe+tGF+qpO3/uAe7qRDl126Z7ZwAt6ePmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1576
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

Hi Anshul,


On 10/7/25 1:32 PM, Anshul Dalal wrote:
> Hi Wadim, I have noted a few comments below but overall the patch set
> looks good to me.
> 
> On Thu Oct 2, 2025 at 6:34 PM IST, Wadim Egorov wrote:
>> Introduce a shared boot-device helper that translates DEVSTAT boot
>> modes via SoC-specific lookup tables. This replaces the per SoC
>> get_boot_device()/get_*_bootmedia() implementations and centralizes
>> the logic in boot-device.c while keeping the mapping data SoC-owned.
>>
>> Start with am62x as a reference implementation.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   arch/arm/mach-k3/Makefile                     |   2 +-
>>   arch/arm/mach-k3/am62x/boot.c                 | 141 ++++++------------
>>   arch/arm/mach-k3/boot-device.c                |  90 +++++++++++
>>   arch/arm/mach-k3/boot-device.h                |  34 +++++
>>   arch/arm/mach-k3/include/mach/am62_hardware.h |   1 +
>>   5 files changed, 169 insertions(+), 99 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/boot-device.c
>>   create mode 100644 arch/arm/mach-k3/boot-device.h
>>
>> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
>> index b2fd5810b67..7dc77328e5c 100644
>> --- a/arch/arm/mach-k3/Makefile
>> +++ b/arch/arm/mach-k3/Makefile
>> @@ -6,7 +6,7 @@
>>   obj-$(CONFIG_ARM64) += arm64/
>>   obj-$(CONFIG_CPU_V7R) += r5/
>>   obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
>> -obj-y += common.o security.o k3-ddr.o
>> +obj-y += common.o security.o k3-ddr.o boot-device.o
>>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
>> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
>> index a3a6cda6bdb..06bd04da99f 100644
>> --- a/arch/arm/mach-k3/am62x/boot.c
>> +++ b/arch/arm/mach-k3/am62x/boot.c
>> @@ -3,104 +3,7 @@
>>   #include <asm/arch/hardware.h>
>>   #include <asm/arch/am62_spl.h>
>>   
>> -static u32 __get_backup_bootmedia(u32 devstat)
>> -{
>> -	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
>> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
>> -	u32 bkup_bootmode_cfg =
>> -			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
>> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
>> -
>> -	switch (bkup_bootmode) {
>> -	case BACKUP_BOOT_DEVICE_UART:
>> -		return BOOT_DEVICE_UART;
>> -
>> -	case BACKUP_BOOT_DEVICE_USB:
>> -		return BOOT_DEVICE_USB;
>> -
>> -	case BACKUP_BOOT_DEVICE_ETHERNET:
>> -		return BOOT_DEVICE_ETHERNET;
>> -
>> -	case BACKUP_BOOT_DEVICE_MMC:
>> -		if (bkup_bootmode_cfg)
>> -			return BOOT_DEVICE_MMC2;
>> -		return BOOT_DEVICE_MMC1;
>> -
>> -	case BACKUP_BOOT_DEVICE_SPI:
>> -		return BOOT_DEVICE_SPI;
>> -
>> -	case BACKUP_BOOT_DEVICE_I2C:
>> -		return BOOT_DEVICE_I2C;
>> -
>> -	case BACKUP_BOOT_DEVICE_DFU:
>> -		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
>> -			return BOOT_DEVICE_USB;
>> -		return BOOT_DEVICE_DFU;
>> -	};
>> -
>> -	return BOOT_DEVICE_RAM;
>> -}
>> -
>> -static u32 __get_primary_bootmedia(u32 devstat)
>> -{
>> -	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
>> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
>> -	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>> -
>> -	switch (bootmode) {
>> -	case BOOT_DEVICE_OSPI:
>> -		fallthrough;
>> -	case BOOT_DEVICE_QSPI:
>> -		fallthrough;
>> -	case BOOT_DEVICE_XSPI:
>> -		fallthrough;
>> -	case BOOT_DEVICE_SPI:
>> -		return BOOT_DEVICE_SPI;
>> -
>> -	case BOOT_DEVICE_ETHERNET_RGMII:
>> -		fallthrough;
>> -	case BOOT_DEVICE_ETHERNET_RMII:
>> -		return BOOT_DEVICE_ETHERNET;
>> -
>> -	case BOOT_DEVICE_EMMC:
>> -		return BOOT_DEVICE_MMC1;
>> -
>> -	case BOOT_DEVICE_MMC:
>> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
>> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
>> -			return BOOT_DEVICE_MMC2;
>> -		return BOOT_DEVICE_MMC1;
>> -
>> -	case BOOT_DEVICE_DFU:
>> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
>> -		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
>> -			return BOOT_DEVICE_USB;
>> -		return BOOT_DEVICE_DFU;
>> -
>> -	case BOOT_DEVICE_NOBOOT:
>> -		return BOOT_DEVICE_RAM;
>> -	}
>> -
>> -	return bootmode;
>> -}
>> -
>> -u32 get_boot_device(void)
>> -{
>> -	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
>> -	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
>> -	u32 bootmedia;
>> -
>> -	if (bootmode == K3_PRIMARY_BOOTMODE)
>> -		bootmedia = __get_primary_bootmedia(devstat);
>> -	else
>> -		bootmedia = __get_backup_bootmedia(devstat);
>> -
>> -	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
>> -	      __func__, devstat, bootmedia, bootmode);
>> -
>> -	return bootmedia;
>> -}
>> +#include "../boot-device.h"
>>   
>>   const char *get_reset_reason(void)
>>   {
>> @@ -141,3 +44,45 @@ const char *get_reset_reason(void)
>>   
>>   	return "UNKNOWN";
>>   }
>> +
>> +static const struct k3_boot_map am62_boot_device_primary_table[] = {
>> +	{ BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +	{ BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +	{ BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +	{ BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +	{ BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
>> +	{ BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
>> +	{ BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
>> +	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
>> +	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
>> +	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
>> +	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
>> +	{ BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
>> +};
>> +
>> +static const struct k3_boot_map am62_boot_device_backup_table[] = {
>> +	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
>> +	{ BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
>> +	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
>> +	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 1, BOOT_DEVICE_MMC2 },
>> +	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 0, BOOT_DEVICE_MMC1 },
>> +	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
>> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 0, BOOT_DEVICE_DFU },
>> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 1, BOOT_DEVICE_USB },
>> +};
>> +
>> +static const struct k3_boot_device_info am62_boot_device_info = {
>> +	.boot_device_primary_table = am62_boot_device_primary_table,
>> +	.boot_device_primary_count = ARRAY_SIZE(am62_boot_device_primary_table),
>> +	.boot_device_backup_table = am62_boot_device_backup_table,
>> +	.boot_device_backup_count = ARRAY_SIZE(am62_boot_device_backup_table),
>> +	.main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
>> +	.wkup_devstat_reg = NULL,
>> +	.bootmode_addr = (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
>> +};
>> +
>> +const struct k3_boot_device_info *k3_get_boot_device_info(void)
>> +{
>> +	return &am62_boot_device_info;
>> +}
>> diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot-device.c
>> new file mode 100644
>> index 00000000000..9431dae71fa
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/boot-device.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
>> + *  Author: Wadim Egorov <w.egorov@phytec.de>
>> + */
>> +
>> +#include "boot-device.h"
>> +
>> +#include <asm/io.h>
>> +#include <asm/arch/hardware.h>
>> +#include <asm/arch/am62_spl.h>
>> +
> 
> We shouldn't be including an am62x specific header in a mach-k3 file
> meant for multiple SoCs. Please refactor the macros used below so it's
> no longer required.

Good point, I will update it.

> 
> One idea could be to let the SoC's boot.c handle parsing the devstat and
> bootmode (primary or not). With get_boot_device in boot-device.c only
> receiving the final bootmode and bootmode_cfg as part of the
> k3_boot_device_info struct.

This means we will end up with code duplication again, every SoC/boot.c 
will have identical parsing code. Let's not do this.

> 
> This would also allow Jacinto platforms to easily make use of this
> refactor since the handling of wkup and main devstat would be handled as
> part of the SoC's boot.c.

I don't think it is a big deal to extend for jacinto here.

> 
>> +__weak const struct k3_boot_device_info *k3_get_boot_device_info(void)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static u32 __get_backup_bootmedia(const struct k3_boot_device_info *info, u32 devstat)
>> +{
>> +	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
>> +			     MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
>> +	u32 bkup_bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
>> +				 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < info->boot_device_backup_count; i++) {
>> +		const struct k3_boot_map *m = &info->boot_device_backup_table[i];
>> +
>> +		if (bkup_bootmode != m->mode)
>> +			continue;
>> +
>> +		if (m->cfg_mask == 0)
>> +			return m->result;
>> +
>> +		if (((bkup_bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m->cfg_value)
>> +			return m->result;
>> +	}
>> +
>> +	return BOOT_DEVICE_RAM;
>> +}
>> +
>> +static u32 __get_primary_bootmedia(const struct k3_boot_device_info *info, u32 devstat)
>> +{
>> +	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
>> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
>> +	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < info->boot_device_primary_count; i++) {
>> +		const struct k3_boot_map *m = &info->boot_device_primary_table[i];
>> +
>> +		if (bootmode != m->mode)
>> +			continue;
>> +
>> +		if (m->cfg_mask == 0)
>> +			return m->result;
>> +
>> +		if (((bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m->cfg_value)
>> +			return m->result;
>> +	}
>> +
>> +	return bootmode;
>> +}
>> +
>> +u32 __weak get_boot_device(void)
>> +{
> 
> Having a k3 specific get_boot_device called by U-Boot's generic
> spl_boot_device from SoC's init file is convoluted.
> 
> We should probably just replace get_boot_device with spl_boot_device in
> a later patch after this series.

I have introduced get_boot_device() because our board code needs this 
information in various stages. See board/phytec/common/k3/board.c


> 
>> +	const struct k3_boot_device_info *info = k3_get_boot_device_info();
>> +	u32 bootmode;
>> +	u32 main_devstat;
>> +	u32 bootmedia;
>> +
>> +	if (!info) {
>> +		pr_err("%s: no boot-device info for this SoC\n", __func__);
>> +		return BOOT_DEVICE_NOBOOT;
>> +	}
>> +
>> +	bootmode = readl(info->bootmode_addr);
>> +	main_devstat = readl(info->main_devstat_reg);
>> +
>> +	if (bootmode == K3_PRIMARY_BOOTMODE)
>> +		bootmedia = __get_primary_bootmedia(info, main_devstat);
>> +	else
>> +		bootmedia = __get_backup_bootmedia(info, main_devstat);
>> +
>> +	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
>> +	      __func__, main_devstat, bootmedia, bootmode);
>> +
>> +	return bootmedia;
>> +}
>> diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot-device.h
>> new file mode 100644
>> index 00000000000..965a4570710
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/boot-device.h
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
>> + *  Author: Wadim Egorov <w.egorov@phytec.de>
>> + */
>> +
>> +#ifndef _K3_BOOT_DEVICE_H
>> +#define _K3_BOOT_DEVICE_H
>> +
>> +#include <linux/types.h>
>> +#include <asm/io.h>
>> +
>> +/* Descriptor for mode + optional cfg test -> normalized device */
>> +struct k3_boot_map {
>> +	u32 mode;	/* Raw PRIMARY_BOOTMODE value */
>> +	u32 cfg_mask;	/* Bits in devstat-cfg to test (0 if none) */
>> +	u32 cfg_shift;	/* Shift right before comparing */
>> +	u32 cfg_value;	/* Desired value after mask+shift */
>> +	u32 result;	/* Normalized device to return */
>> +};
>> +
> 
> Nit: This could be better documented following the standard '@' in a
> comment above the struct.

Can do

> 
>> +struct k3_boot_device_info {
>> +	const struct k3_boot_map *boot_device_primary_table;
>> +	unsigned int boot_device_primary_count;
>> +	const struct k3_boot_map *boot_device_backup_table;
>> +	unsigned int boot_device_backup_count;
>> +	void __iomem *main_devstat_reg;
>> +	void __iomem *wkup_devstat_reg;
>> +	void __iomem *bootmode_addr;
>> +};
>> +
>> +const struct k3_boot_device_info *k3_get_boot_device_info(void);
>> +
>> +#endif /* _K3_BOOT_DEVICE_H */
>> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
>> index 2f5655bf24a..084f16bf2d2 100644
>> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
>> @@ -10,6 +10,7 @@
>>   #define __ASM_ARCH_AM62_HARDWARE_H
>>   
>>   #include <config.h>
>> +#include <asm/io.h>
> 
> Why do we need this header here?

There was a compile error in a previous version. A separate patch would 
be better, sorry. But I will drop it since there is no Issue anymore.

Regards,
Wadim

> 
>>   #ifndef __ASSEMBLY__
>>   #include <linux/bitops.h>
>>   #endif
> 
> Acked-by: Anshul Dalal <anshuld@ti.com>
> 
> Regards,
> Anshul

