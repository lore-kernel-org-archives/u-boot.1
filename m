Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BA2D3B7F6
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5764389A06;
	Mon, 25 Nov 2024 11:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gfl4n1JU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A697589A08; Mon, 25 Nov 2024 11:03:04 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36CB889A00
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrj77tJ4pCLDiDHFvjhviQqlWGs7JgNyLCU16ud4Faf1zSMyywHVBT0mqBwZl+xS70tnNdstkhsJgk5XHVDs7KKo0SP70G3TCdUKpdRpr2rTCM01TyIvDVjMBP9zHW9acJGw4L0Dfiv5AYcsROJxTP3d/dZgatjqAXP+1F0Nb5emdJCYIrAGIPBhr2UAOVgb5gKkUgTkUQ4q4fJweaNjwbO0kDAjozjGM93ZtTNTcnhLTSuScLOjoW72TsL9PHdvDVozodUxkthBfttCoaquPi+WnR7J/mHQwJgbGoa8SUoOt/lhu2xzfaWJ/84Lz11IefL3MgfjVCPXGyervaQ8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfAdZbK6EgnKeMhlelXLudeIX720NidWxKoYOhQl7q0=;
 b=ZlMOvo0Se0iNRum0ftzSVMMPKFtZyOdWKoONrSzaVbYqSbutTAhvsiv9PwwPkEgoXChBpeWG4iO+EhCJBFiWVr1doEDwhOliqoBm0w53l92BrnXCnNhibruxn/bP0wH5eTqW3Z2ypY6rflFKJZGo6ziNXBstzYFYfhQVOtO8XJ2NnewJs5H+zlqGUQHSWHaqBBCb9EH7c72hxrJsBml0xazcnSf38XeamQsH8skuxyJeJDfOxakvlfxVD5wdCsqEvDRXKltzoCtFG5T4mtFJo6q8Orx7JV5TX5caKk2xcH/GMxNV+BDEO6hTnAqFR2v9zI7s0wlnSH/WO6ueWoZIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfAdZbK6EgnKeMhlelXLudeIX720NidWxKoYOhQl7q0=;
 b=Gfl4n1JU4ycDYEC/lAy0nQMmf1ptjuoY2WD3T3t3bOdM5dMYDY/j61Flr5B1w+m8dpqDEhrc34EJjuBYHy12HBGUo2pCB9jrFKWhJtmK2Eyj3I1CARKr1cPSTEbg1bzBleMrAmtur2Q6qfNbIDt+Drnlvy2TDBfsc1d7jZstCCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 10:02:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 10:02:57 +0000
Message-ID: <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
Date: Mon, 25 Nov 2024 11:02:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9aabec-2ddf-4f5c-0e71-08dd0d385631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0RZcVpsL0lIajl0ZVhxeEtGOWg4aXhSRE5lZURYRGJ4cElPcVZENmRvWnBy?=
 =?utf-8?B?SUdHMGZUU1JUdjBQOXZvQ3oxTmF0b2ozRytTTENFcmoyUW9MSUtaU25yMjNL?=
 =?utf-8?B?VUNGcTgrMU1EVUlHTjJHZDZHWVJ0WjNmR2VmZzBXSnhtUmRTcUdoUjNvcjha?=
 =?utf-8?B?cTdSb2ZwbFpJL1kzNDhwbE1kQml0b2pvaGU0bDJQbHUzK1huYzFTUVVPdTI1?=
 =?utf-8?B?dWtLbTZsVzVTd1oxVit1ZjVqUnk1eWs1Q0lIdGdYSWh2dWxiSTgrUGFpREpH?=
 =?utf-8?B?dUlvWkNCVlJ5Q1lkZUdzdmRQdlBuamxaS3Q3czZTSWt4ZW9ZeFdhTmZWclpW?=
 =?utf-8?B?aGpYb3ljQkpMdFRHdTJRZ2pyOGc2RmE2ZWYwUjcxeGRkYy82N1JkdmxsV2Qy?=
 =?utf-8?B?enBWZE5uL2NBdm9LMGUyVXFTNnA1Tk1kSmg1WnpNMXFRUjMveDQvTnlhV0lP?=
 =?utf-8?B?VUF0bjd6TGFnTGs3SDBCL2o5ZzVmS3h6WFNHZWRzZzZEUklaVkNuejZ3ZjZX?=
 =?utf-8?B?UndGa1Y4UXR0RlYzcTNpNE0yUFZMaEtSYlB1MVYyYWtXNEoyNTdwclFBZWJ0?=
 =?utf-8?B?VWJVakU4Z2VhYkZTbVJ4aVY3a0JxWlk4ajJ3QW5vS2F5R3BaUVhOQk9FSmZv?=
 =?utf-8?B?bHlUUEtoWGdwSUo0L2JjbzJnamVBK0FPWjQ1elFWR0liNVFUbjBBWExyQmJw?=
 =?utf-8?B?ekJBeE5MYnBYV2xSNEZMVzVKbDRHRStDd2dCTU9ua095bDBINU0yZkpRTk5u?=
 =?utf-8?B?YmlBbEYzUkNYVXhlU2VKRFZkWW53RGZWbVBnMTNhWkdIQ0lwSEgxbzNvT3JZ?=
 =?utf-8?B?TytUK0NJTjBjV3plRXI3WFNWQXNMbFFJYk0vZmM1VVVGcEtZTUVPbTJ6WWp4?=
 =?utf-8?B?UVlBaXAra2tHNlA2KytjaHBnRlFzL3R4TEFZY3hOcmo4WE9DaE1yQW40N2Zh?=
 =?utf-8?B?YjFtOHFzeG9HVHVzZ3JZajU4YWFXdEUrM0hYTFhqa1o1VTFCaFV0NUJZbHpq?=
 =?utf-8?B?YjRwYWl0QlVxUWdmM1JZU1dBS043SXZXeE1IZUtUWUltZ0t4Qk5GUmhIUjcw?=
 =?utf-8?B?VTdEQnRHRWdEekFoM0FoTFdwWVlxZncycWxkZHVYWkR1MWhab2pDMElwelFW?=
 =?utf-8?B?UFJlL1VyUGlSc2lQcC9UY1pKaGhGOWQ4OUswaU5tY1pMMDdKNWNTazhQbkZq?=
 =?utf-8?B?OHFNTy9xVUR6NEh5bnNBNHd4bk9pU2F6aDhBWS82aTZZMzJWODI3UGhWNU93?=
 =?utf-8?B?ZGVtQUpUM3pRbm9VNnFNMTExbCs4a2s0UmRTMUpLYnhjVWlIVHpNVmY3eGlN?=
 =?utf-8?B?dVd1Mmdpc2hxVGFNWHZPYUt4L1A1Si95K0ErQ04rdWhwVWUxbHV3NE5scHhX?=
 =?utf-8?B?djdRbkxJdG92VXBpWG5iSHJrUkgvY0lsV1JwcDl5RjA5bUZsN2haV3pNTGhZ?=
 =?utf-8?B?SjljVHdqdWQwQnpNWVdWWFA0U2IwSm9uRjcrL0dDdmsyeWltYjlKOXo4d2NV?=
 =?utf-8?B?dndYMkFRZjlYWnE5R3RFMUpWNXArcEVwWmR4Uld5SmF1ZDlQNms2WmVGeTBa?=
 =?utf-8?B?OFYvNENQT3o0UDJ4SWdJM1FMaFF4VDZScHdrYVFpUy9hWVdyZjJ6THRVanZj?=
 =?utf-8?B?cTU4d3pwM3NUdFFaYjgzUHVnM3B1Mlg2b3k5d09ySjJORlh2VjNKQVJiVW5N?=
 =?utf-8?B?Q2ZXcXUrQS9iMyt4dDN3eWRLbnhSZVNHenNVelFWTWtaTnduT3FlM25NdWZx?=
 =?utf-8?B?RDQ5Y0lPRWtYSFozQTdUVVVCRTd4WnVOZ3EwdDI4OEVZTkt1eitBL2dOd1Zz?=
 =?utf-8?B?L1Z3WUozeUJLbitRaWk2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldjSUFkZjdPN3UxUWgzaXNESHBPRzRIcmI1c2VDWENhYk9CY1BPZnJPeUtT?=
 =?utf-8?B?bHhaQjBWMkdLVFlZMUZpbkVPVitockFvL1hFZzFNb3RIQ2JhYTB2L0RBRm5n?=
 =?utf-8?B?RHhIQXdLTU9vUlhCb0R6K2wzbFVLbjIvNTRRUldNdE5WZERIUC9XVGJjNm10?=
 =?utf-8?B?MCtKZjBNU3RaRVlqWmhxK2IxaXMyMWRCVjdaQVYvQTRLeWx0aXUzeE9IZXkz?=
 =?utf-8?B?dzg0Zlh0aElIeG83R0NsRWNZbGxuUktkbkVCSmlBVVdBdWcybmhmYjhnWk5Q?=
 =?utf-8?B?T09HNmo4U2lDUmxLV0EvK3BSZWU2d1prM3JCR3JPTHZxYkFqMkxmQWg3NEVS?=
 =?utf-8?B?dk81bDVnQjc5SWM3eDZuQ0I5YkV3ODg2ZVRFdERURGpmdGpnWFJLMVA3ZThQ?=
 =?utf-8?B?T3AvRjVoQlIybWFWbmxqUHBoRWI4d2IzTEcyQnh5Y0pFN2wyVldtMWZ6bEJ3?=
 =?utf-8?B?RVJ4RHBZTFJEbGpXZitySDVya0xUTzVPQTJsUEgwRTMyMkpmNkxhdE9xQUM2?=
 =?utf-8?B?clVjMHEvZVZoYWhhMUFxdGpmeTBxVTNLVHRxZStRQStNVG1kUkIvMWI3MDM2?=
 =?utf-8?B?MWZReENkSncxRWRka0JGYVhFYTJaN09HNFBQeGRJVXRxYWpFT2QyVEhVYUtT?=
 =?utf-8?B?Q0NJSHIyeEZ3dS9WekltZmF2TDQ4SkF6cXgydHdJcVV3aFQyQk1meHRTczYv?=
 =?utf-8?B?UnRpNDBaUFExK0wraGtXNTNuQ1RlNEtvTUVSckxEWEVtcE56K0ZZZ3kyTWlG?=
 =?utf-8?B?Uno3Wk9Ob1c0Wnp1OUFKWkZ3OVp5Yk90cm5YdjNyQStHaEhLU1pyQmdzckpT?=
 =?utf-8?B?ZkpZbmRBZ2QvN24yWVc0amJIMG9lMzF1dC90WmNsUWt3NldqUUlFQ1hveHE5?=
 =?utf-8?B?bytoK3dZZFVuQTltbTBLUDBQQmRqOTM4d0lNM0o0T0xqd3BhcW9XdXk2anU0?=
 =?utf-8?B?b09rWUlGMkdmcXlWRExDdDdlNHVVRGJZcUhzTEZFWjVDTUhhbGRlS2ZoWW5z?=
 =?utf-8?B?dllVd2NqWnlXSTFYWHI5VSt3UmE4VjhJZ3ZhSHYrOGp1SlJjTGpWOXpjbVBz?=
 =?utf-8?B?UzJoUC93WUljZzdJbDFjUEhQYUUxdlFxMVpyUkVzL0dWR01oU1JMV1lTNWJT?=
 =?utf-8?B?Skx1TnpUTUczQ1lLR3NpV25XZ3p3Wk5ma1Z2cTNTckc4RnBGZkNLSFB1UUhn?=
 =?utf-8?B?Z09aNG5tM1ltaVVPRWhaTzB6akpFUUsxQkRjOEx5L1p4WjNFckY2YmgrREVK?=
 =?utf-8?B?QVZxUG02ZmlCRFdiNlJrSHFsOFlQMjA2QXg0VjI1L3paTFUvUWpPbzZvWjNS?=
 =?utf-8?B?UXBuRE1LallEUFk5OURzd09RclR2Q0Y5bGcyTnY0WStqN0pBQnFzaHQ3dWZU?=
 =?utf-8?B?RHpkM2ZPYUQvSE5HOGhyb1hEVDdDajFkdjV4WWNvaDdwQmdVVGtYTmNiSFhw?=
 =?utf-8?B?a2UvdkpXOUpxNlFDYUcyY0NFRndHejBqY0FYNi9UWFpILytRRitNNUxXeStI?=
 =?utf-8?B?eWNWOW9rWUllYVFseWdrakpMd2l3N21TN01nZ1FHSzV3SHdVZExOSi9JVUYr?=
 =?utf-8?B?OTJBay8wcXFHQ3ByMnkraEJyamx6RkFRaXlVZ2hLUGdNTWZaTW9TV0ZLTnFa?=
 =?utf-8?B?c0I0UFZaYWRmY3RBeFlSWmlSOFBDS2xXNG5iL3o0dng2THJscXVMelNzNmhP?=
 =?utf-8?B?Zm1Nd21VWFRJMHNhaUpNUFhhMHd3UExKUUVueWpuUDQ2VG9jTHRaaFRlMkxs?=
 =?utf-8?B?bkhxdFYwWk5nTU9mMG41d0dWM241Szd2OEVzVDJuSE9FdC94d1c0d0Y0ZktI?=
 =?utf-8?B?b05pS2ZOa2wrSjBNSElFaERDOU4yQzQvNCsweVUyVTZzSmdHOTBHUUZUTGI2?=
 =?utf-8?B?dThHUmUrYVFHaURXMHFieVhNdWJIOVZ6bTdLWWVLS3pwVEJ2c2oyb1JhdHFO?=
 =?utf-8?B?VUtVQ2M5aDdiUFlIQ3doSnBEa2V1L3J6VnZSY3QrQWErbzZhb2V0RzNQSTI5?=
 =?utf-8?B?dlpkOVhxUml3c1ByZllvdW1IdTdUYTdNSXJsc09ZK1U2YUYzL2RlMFJsZ2Ra?=
 =?utf-8?B?TUtmcU5TQ29NUkxqTXZOT3Fld01icUtUYi9nMkdOQzFWWktueVJMdVh0Q3Ux?=
 =?utf-8?Q?le6MIiPHuQnlKZpyTzorh41Lo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9aabec-2ddf-4f5c-0e71-08dd0d385631
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 10:02:57.2767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLXT+nZtjcUIfWfKiDGyMb7cEkX1bGIWn23P/J2X/dX487vrqL67M2qFD/xfteVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
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



On 11/25/24 10:21, Heinrich Schuchardt wrote:
> On 11/25/24 09:32, Michal Simek wrote:
>>
>>
>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>> The CI uses the following command to launch xilinx_versal_virt_defconfig:
>>>
>>>      qemu-system-aarch64 -M xlnx-versal-virt \
>>>      -display none -m 4G -serial mon:stdio \
>>>      -device loader,file=u-boot,cpu-num=0
>>>
>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>>> relative to the register start address 0xfe20c100.
>>>
>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>> v2:
>>>     new patch
>>> ---
>>>   configs/xilinx_versal_virt_defconfig | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/ 
>>> xilinx_versal_virt_defconfig
>>> index c8f166c1221..06a240173ba 100644
>>> --- a/configs/xilinx_versal_virt_defconfig
>>> +++ b/configs/xilinx_versal_virt_defconfig
>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>   CONFIG_DM_USB_GADGET=y
>>>   CONFIG_USB_XHCI_HCD=y
>>>   CONFIG_USB_XHCI_DWC3=y
>>> -CONFIG_USB_DWC3=y
>>> -CONFIG_USB_DWC3_GENERIC=y
>>>   CONFIG_USB_ULPI_VIEWPORT=y
>>>   CONFIG_USB_ULPI=y
>>>   CONFIG_USB_GADGET=y
>>
>> NACK. That's not the way to go. If one test is failing in CI disable that test 
>> not really support which is for HW too.
>>
>> Thanks,
>> Michal
> 
> Hello Michal,
> 
> It is not that a single test fails. USB is completely unusable on the board. 
> 'usb start' leads to an immediate crash.

I am not applying any patches on SOM with HEAD and usb is partially working.
I can agree that it is not super stable with upstream only patches but that's 
different story.

> 
> The problem already existed in v2021.01.

Any log?

> Do you know of any QEMU/U-Boot combination where USB ever worked on the board?

Why was this visible in CI in past and why this pops up now?
What has changed? I don't think there was any change in QEMu regarding USB but I 
can double check.

Thanks,
Michal
