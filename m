Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952A8E6BF30
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F5C84535;
	Fri, 30 Jan 2026 19:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Hmep63qQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE3A84543; Fri, 30 Jan 2026 19:19:28 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C71984523
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQB71chzeN+KfG03NIvekR0MY9gRF3aTfW7iwuTi8dZISz5H+UhdWsgCkR/063fGIWBk7FQBYQ67o7pQ//x5Hx72D9lD3+hAY1mZHtEtV2ddk4NuhMtj8M0DqM1he3ALxppr/81+XvhO3GbduKKDl8+4v8VL/RZFXViplNNeLhURjFlECWdlbPxmqyQpeLVpxfM4KXMcmfuG5NNeMg9KIuo5uE4t/R+DzMbjwOdzD/64PUnN8ORyW5EnTdVw3fjs63zXLM5Nt6ySpP3gr18i8fDU2N9zKu9lqqyvqoEbxkIiFoMFRFrI68wq9UYwvPhJ3w0bvwDyQ51A5psCfXfkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdGxA51lg042W1A4C7nx5X8f06GjZ02Xlmrocaapw60=;
 b=ZcnjaLV6x+hJsLX8yEnEce2vKUanyhNsOCjO1xVKAoGhOv68aS+Nmg10M0Uf99QS3BPuWFy+6gZTp0YcoSi3AdBE7B26l8xaulczdGWS/wLfhUA6gdj5Bc/eGSWRC9F3rBvFkfVyyWJs9P1RKFGmNiVMarCxDc/ju6PQ2Fyc73TmbZuQkvHRoAYdvX2RZXOcCd3Mi7M2ErGvO2GQ45lVevCMqnR02Bh8EXapMQFhZeuR2Dd9Bo1l5CqavUoE2/tNIEc6+5W7S1Ctyvrxq0kUKkrIOpxzPJwJJR1BsLRgC76Yvtupn4/ZVBnLjnDs7Kiry3fR8AQeDVEJ2UgHbVDPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdGxA51lg042W1A4C7nx5X8f06GjZ02Xlmrocaapw60=;
 b=Hmep63qQ7VcfwLkWqxzEQzGAKAnJbE+swEb9qa6SDrxcF1/UXxwKwx/iNS5RUjfasW+KgyMFZq3Te0VwuJgIVoouTXbKcmYn9aspCmCgFYVdnmnwRwEb21fjEVC53rzBgWBWOVi7rkSk0RVlVEVoxYHjN26ctobKxFTrXSQgv3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB9827.eurprd04.prod.outlook.com (2603:10a6:20b:652::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 18:19:24 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 18:19:24 +0000
Message-ID: <8bd0b00f-9631-4c36-bb73-280e4943dccc@cherry.de>
Date: Fri, 30 Jan 2026 19:19:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568: Include all addressable DRAM in memory
 map
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20260129193153.2232395-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260129193153.2232395-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb7dc88-5e47-4181-8523-08de602c18a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXlKTkc4RTZyQWNYYlcrZG1kNXRUT2lZQ1FMb3NDbjEvZ2hGOGN5WEFaT1gr?=
 =?utf-8?B?a3ovTC9iMkJPdGtuTW1MbkIzMFcvQkFyYTVBVUtLODB2ckRiN2hDb3JtS1Z1?=
 =?utf-8?B?VXN1dU1tc29xWDFMZ1RMY2YzcUhZQ3FIK21YZWVjK094bHdrN2VHZ1QvL2Zs?=
 =?utf-8?B?L2pvR1BKdzdHOWVQWFNJa0JGZk9iMmtCMkttZitEUDFTSmhrcC91S3pNM3gv?=
 =?utf-8?B?NlYybklLNkFJMHYwTk0xYnRYaitubU1obVdVN0Y0OE9RNkJKMFBFdC8wRXgx?=
 =?utf-8?B?ekM4Y1FJMWVqbTJxTEl3dWdWclh0Nlc0MUNYbW1LVFhMMWp4NzNHMFF1MWQy?=
 =?utf-8?B?eUVqYzBFV3pGaXEreHBaVlBmeDRFemxTSGs3TEwvUnpHVHB4TzZPbGFvaHNw?=
 =?utf-8?B?bmRTWXE4eVRTREtGVUdtOTJXU2ttdnljY3dMYVNZZGJFaTRDeWQyOWoxdDB4?=
 =?utf-8?B?VkJUbTNMREg5YTlITjFzNTlUN01UY1VPKzBzaGdYdnRWVmZFRGVxNmJRTzZP?=
 =?utf-8?B?RzZ2VE5kUnpYR2hqK2k5L2dtR3c3dmFHTUcrWHNEWXdOU0FyNjdZNmR4TGtk?=
 =?utf-8?B?VVFnSFFZbG9tZDNSZ1lyQnM1T3UwU2k4RVk1K2luUHFpR3I0Uno1eHM4N0h2?=
 =?utf-8?B?YW9DOW9qbEc5ZzNKUWZ6VWwyZzVlMHlSVTEyUU1xNXpsbTZJSzRqMWZjejVF?=
 =?utf-8?B?MkdoNElHb2doYjBJbDZ2UjVvQ2t6QTUwL0RzWDIyZ0FyVktJY0Yrdmh4Nkh4?=
 =?utf-8?B?V2hwZkpRUStSVUtOalNBV0o2T25xWTR2bWUwT29Pd3lFNFJvUDFGUXl5L2N0?=
 =?utf-8?B?RGRyYmlIcW5mUmQ4LzNXRGh3L3lFWkt4TDQ3UUJ6MERUSlFPVWJCbmZ1S0VB?=
 =?utf-8?B?ZU1LZ2hLV1RFSURReEE4eHQweXhNKzNqayt1NEZTWHBuNE5wWWNubFBBOG5N?=
 =?utf-8?B?dmhQdTY3SEloQXczcWZmbEFWakZaYks0Q1phVlNoSC9rUFBiRDkzY3ZENVFP?=
 =?utf-8?B?V0lYMzFyamhFUHF4djRPeHY1OVRKVVZQMkZoemUzelRKQWZmcWtRc2NIN0xF?=
 =?utf-8?B?SWYwMFdCZWh1TkNHM2Vwa25UTWxzNjFpb1hzVGZvVGVudjJ0ZjFJSVozcEpX?=
 =?utf-8?B?aE1ibC9hTHg3ZjNBYi81TnRYQ2wwdUZ3MG52NnJNaWI4eFBURDF3VS9DTzJO?=
 =?utf-8?B?VGwzdmJxd2hhRG4rcHZIUUNlS09weXdpdExReGlTbmJINWhhR1IxYzlqdURa?=
 =?utf-8?B?Q1dYUDBaamFwWWZuYy90Ty9sSzFVSnlSTDlHSGlzSDZRNWI4UjlXRy90emha?=
 =?utf-8?B?dXRIZlRwaVZiTVZuTjRVc1pTWkp1a3ZwUWgydzZ4d3VnUlBRc0hlUlpYSEdk?=
 =?utf-8?B?OVNNRC9lbURub3NLdGlZYnhWYmFjTzZqSUEwVkkxZWlVbCtsUkROUUVUTGVh?=
 =?utf-8?B?czBIVW9Hc2F3U3F5bGxmNWlCNit3bk92TGw3K1BueVhvd1RXb2RGQU03clAx?=
 =?utf-8?B?Z1V6ZEVvd1ZFSEtjZGFDYWtkc045UzRROHk1Y0I5UzlZaGNnUUdRczBNWnF1?=
 =?utf-8?B?NWYzTHhOYzdvMG92WjFMSWJSTjNOM2RuUzlXbTlnMmtFNEh4bDdXNEEzSEs1?=
 =?utf-8?B?SVBCSTRPWEs5bFJUUHNqaDhrR0tvN3ZaNUxRTWYwVkRvSkRFNUdzNTE2RGpG?=
 =?utf-8?B?VEZYdG1xMEh5VkVGNndNbjE1SDQwYTFIU2FzWDZWbjhhSzFjUWwrV2ZyY2FP?=
 =?utf-8?B?Q1A2OWxLN3ZhUTNQWFZkQ0ZkMVh0bERYbGprVmszSlB4ZGRLNTdMdTdMR3gr?=
 =?utf-8?B?cTQ3VTZGY29qN0JFWjFDWk9nMks4TitPUThYVC92Q2pFZG1ZMHhERmZzWHo0?=
 =?utf-8?B?RFVYZCtIeHFhamptUkg0ZmRkSGxGWFFVSUdCd2VOcUIyaFJIbEh5TTN3RVl5?=
 =?utf-8?B?STkvODZFMUkwL1d4VWRtK2VQQjhVc1FCbDNjZDNBWnpqODhnSXJ6Vml6TTkw?=
 =?utf-8?B?NkRMQy93enBnR2xLODdUUktZUTAwV1A5NXY0RWZzWjJjZ3BVWjVBdnNvdCtR?=
 =?utf-8?B?aUVxWTdPbHFENnZOQjlxVm1jTGU0WVRoVGNSem43eXpwOGNtUks1NnRZNEdG?=
 =?utf-8?Q?NVlk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxVejhXZ3VFL3NVNmN6VzdTZk8zQmZlYUxsSmpPemw5eUtwU054bHFyblAz?=
 =?utf-8?B?cm8xNDJML0FGbTFIZ1dBc0NUM1daa0NkWUhtdUhkSTl3ODlCbFNLbUVPZHdy?=
 =?utf-8?B?bjhSbTE0aThHYXM1Y001elhuc3ZhN2N2RWhJa0lzbS9sS3ZubDhCZWpJL1Bz?=
 =?utf-8?B?WHEvbkUxdDY0MGVQY0huVUhiMmdDRnNHVkRPK0EwbWtIM1h1L3lyU3BrYTR5?=
 =?utf-8?B?UjBLdUh0TVFzYWZqT3VialpZQXJnY2pXWDBPUGthQy8wZTZWZlR1QkZoeUY4?=
 =?utf-8?B?OGdXVEVLZHVTTGVndzZ0RU1keVI0SS9IeG44VWFVWk5NdVA4SnRoSUgzNkMr?=
 =?utf-8?B?UWdMNW1tUDc2eHdIWExPZE1HSVpLNW1UeUpNaVF4a2NuQkd0QmdhTnBQRVZW?=
 =?utf-8?B?VUE3VEFMY043SnFMZW1MM1RwZU41azBTeGRTaFkvZ1JZVExXbmRKUSs3K3hY?=
 =?utf-8?B?OE1qSWRTQjhFQWtKVFlQektrd0VKOTN6KzArdDk3R25Eb2RxVUtjd0VHQWhi?=
 =?utf-8?B?ekw2dXVXYkdIdlBaZWJUVVV5OGVud1RreFI0bU5xRmlJNUdPdmtSQ0xzS2Mr?=
 =?utf-8?B?blFBZUtCNm9NRUlHM2c4RWw5OTA4RjVPOTBaVGlJRnUzTWg3enZOQmdRblVr?=
 =?utf-8?B?TTBnSGdqRXBEc2V1MkJ2dlBjRXpacldJWUlENlFTT2lQOE9UNk9aaFJSSnBQ?=
 =?utf-8?B?TGRRTTNqd2gyMWNHd3BUT25qbUIyOGNyRHBWN0t2aVBoMFlJYWhSUkgxb0Nh?=
 =?utf-8?B?c3o4aENDRWJ0MmIwQ05ESjB0YTNLWVlqeURTdFJQQ3FONEFKbG5DMlJIeHht?=
 =?utf-8?B?NVFxb2lTekEyL1JId2E5SG9CT01mZG92bEd3MzFVUVZSSXMwZENKeFQ3SGJr?=
 =?utf-8?B?TkNodzdHMVNOaG1VbVNhclcyQ3NCYW9xc2U5TFROcFJTOVVyODlFQ2JKMTJV?=
 =?utf-8?B?VU02STF4WTlTU2x4ZnltY1NhSURZcnV1TGh3Q3E0QnZyalVoc0psd2JBYkhi?=
 =?utf-8?B?am5CRFloSlNlaW9oa0Y1Wnpxck56aGtMdTNFdHFxMkJuT2FRQ2hPMzhkTXpE?=
 =?utf-8?B?a0lwdTcyeFhsbllCcERsYlZoaFBYRkpnSGNhTG03akJndjk2UHVLWkJ4bVp3?=
 =?utf-8?B?VGx5bGlVYXR1QnYzWi9YRWpCc2tDT3RjMVpTZUNSYThIWVRPM2RJUVkxYUsv?=
 =?utf-8?B?bjdTY092ckZTL1Qvbk5sTG5xeG9jeEJYUm9ydmFJdUNWV1MxZUlydnEwMVFn?=
 =?utf-8?B?T3U0cWtOSXVHRzJUNzg0M0p1U0QycWwwQWFyUzllakZWNGdmaFpzaEZ3TzJT?=
 =?utf-8?B?Rm1SY2VnTkhPZndTSzRvazh2Z1JLeDkxMk1LSk0rN2VLc0ZBM0lnTDlKckYv?=
 =?utf-8?B?Rm9rT1c3bzFpYi80cytWbDV0LzQrY25yRW8rWFJuOVNFamtjWVRydStidTdF?=
 =?utf-8?B?Z0MyK1lUY21MOXpyblZWaTR1Y1VWOXpLRVBYNjVNaVcvdmZLSldGZEpKaEl1?=
 =?utf-8?B?WFl1RnhaV2lpVkwrdlhaWlluVlVTRkx3WlRJZ1lzM2RWMXVxaVVVd1htNHhI?=
 =?utf-8?B?a2FqR280QTcxNFVRVlQ1SWV1NmJiYkl2WG4vL3h1akE2NFpzRGNtMkNsUWQ5?=
 =?utf-8?B?WFVrM3IzT2tXYllUMDdBNmZaeStiNlpJTEJCcG1vS2xyckR2MFBhVG1vQUx6?=
 =?utf-8?B?TmpZdkV2cURoNXoxUUpjRDRRZDV3N2dPVGNnUHdheUx0TlZBRFU2ZVVzbjBT?=
 =?utf-8?B?RU5ObHdNVUlZUU5ld2VnbFNMZytuNGZwakN2ZWRsMzRNazljcno3cUtrdGlz?=
 =?utf-8?B?YmN6UVZOeU90RUpqMllsTWxQTDdCWCs3Zi9xR2RtUEM2aEwvRUN0cTJjeklv?=
 =?utf-8?B?OW1XV3MzVUtUbUZlbTZhd3Rja1pnZ3Z1WmZsZUlQT2U2c2czRnhPbkI3aU5C?=
 =?utf-8?B?bmtoWGVxNGZLYWhoWGMyaHZWLzJMaUZ2dkZCYXQ3a1k0OGpZWDA1b2dRMTAv?=
 =?utf-8?B?MnRnYjBYU1R0cFk2NUNhZ2RweHd6WURUcEl0dzRlUUloMUo2dDM4dXUrcFk3?=
 =?utf-8?B?TDR2SW43dHJxc2RadXVkejRwQTkzRDltSTZmcmtBRno0WnlhdmkxTXlCUVVL?=
 =?utf-8?B?VGdmdzh5S3g1cmg3RjkrNDQyYlZRVnQwTzF2NUNYTHNha0NWeDdJTlNydEJC?=
 =?utf-8?B?SExtRFl1anVOQUpmczFjZElHMWs5bmtHcnh5YnkxdkVhSis3MkVyVzkzYmN6?=
 =?utf-8?B?UUZHdlN1R3htU3lycGIyOGJOSVgySXA5SlVMUWNNYVQxRFp5RW9lU0k4V1Fk?=
 =?utf-8?B?MURNNFU0LzFQL2d5VVVZdGNiS2o2Qm5FQVY1bVZUV1lPejI0Sm05QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb7dc88-5e47-4181-8523-08de602c18a8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 18:19:24.2543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo2npk7zhZkuqGrh1jMsdZaVpzOjJquRZEDf5wzHaBVB1OWV8XafHfgembEi3+5lkAQaTJ3a1PEFbS9w9JmgQCaHf3zkuYQjG4KQ0adtges=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9827
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

Hi Jonas,

On 1/29/26 8:31 PM, Jonas Karlman wrote:
> Rockchip RK356x supports up to 8 GiB DRAM, however U-Boot only includes
> the initial 4 GiB in its memory map, something that matches gd->ram_top

Does it? The first range is 0-0xf0000000 which is 3.75GiB and not 4GiB.

> and current expected memory available for use in U-Boot.
> 
> Add the remaining 4-8 GiB range to the memory map to more correctly
> describe available and addressable DRAM of RK356x. While at it also add
> the missing UL suffix to the PCIe address range for consistency.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3568/rk3568.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index c2b96902d2dd..2b1eafee37c9 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -72,9 +72,15 @@ static struct mm_region rk3568_mem_map[] = {
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>   	}, {
> -		.virt = 0x300000000,
> -		.phys = 0x300000000,
> -		.size = 0x0c0c00000,
> +		.virt = 0x100000000UL,
> +		.phys = 0x100000000UL,

How do you know it starts there? I'm assuming from the ATAGS? If so, 
please state that in the commit log.

The previous mem region ends there but if you read the TRM, it should 
likely end at 0xFE8C0000 + 128KiB which is 0xfe8e0000. This only gives 
us an additional 23.125MiB which wouldn't be enough to explain the 
missing 0.25GiB we need to round this all to a nice 4/8GiB.

Cheers,
Quentin
