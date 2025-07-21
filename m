Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032FBC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 13:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBB883152;
	Mon, 21 Jul 2025 15:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="sayrAxDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1419E83197; Mon, 21 Jul 2025 15:08:51 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992DF83118
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 15:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfj/gESTuxvCnUrFh0UWy41rnhSNhlOgpBOsRFdAW9twMtf7JMmjCjAVtJTS/sdoLb8BpieDbADLZ3GlcYD35oxDIFuVdRjA33GNh83uCzU86gEVyOrHlUsjCgibOLQ3Hsq50wCCKmR8N4Z7vA+i7r4BiDUhOY5wBOYJPFxtzr0ezfNlJBC+jfErPklMPs+/pwxKPKnV5TEXE5f7XgS7W7JAGR3KdOWXviCQjnr6eugm5UNNV7smKL/SiE/9H9057uGFklexgdCANddSo9T1yp5urn43jDKVS3WmKJP2cBZcqoxvbNsabP+7lWezQ35fcUbYPQaUKkBN6/QibLC30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3Lejy28pluaH9Q7ka6rRMzMLX82Pkny8KNVVbypWzY=;
 b=QV/MjaanGFT/2YHIklydgUJfY9bvduXDtDRPDAxfFGKS5wPnlM8mJH6J+/pBQb6n5VMQ+SK155PNp8o0V+yTQ1jXX2vMk3+n5l5Nj70DKhcJBgF9FfRSjFUEYp9j1XBttbNeYBQ3q14k/mup9EJyXO+bt/yn8D61zKV/g7vqdqCgkS0aKYZyDCFTf+kRJsFyWJSr4m3qm5CoBr2g4gMMFlsWZ9HeR9XI0v6j3SHXh/21gXRwM+hAN+2eW+D25jc341xQjBg1sXETxnEKKcD6c44js8YvxTjOItI2r0H5EJ0QRSL5/2yYI2WWbUTS0q2BSS/InxRFC2LSghn//ZmmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3Lejy28pluaH9Q7ka6rRMzMLX82Pkny8KNVVbypWzY=;
 b=sayrAxDgct3NQAoEmbIj8KZ+GcfBe/fPLiEbaNa3S2HTG6kQQTj4fweleIEVnEEW/7jfQ691ZCeg0qvpf1eor1GheRwGpssQxSgLdWx10Yujgel8X9mhVkuiwBqH6SHoZESthG+ZxUeSg5KtjlcKkbiNV9Mpu1wCLhbijaUlnJlWMqq5dfzlDrU5yy2K8S+D5y5rrf93NShyds2VLB9wdaMF/XotZXW1AqGjGc4+F2HZchhpTY0ir/M+Zdzh8Yz08U5FKNe6DzWcE91GGXcHLc681hKP1gHBagiNeGFpJhTOTClrfTlSn4/SUqgfwPyZBG7xSUuvE3kW2iUKQmwpeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB9143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:08:45 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 13:08:45 +0000
Message-ID: <cf5d5a08-9ed5-4500-9e1d-b36224d3ed75@kontron.de>
Date: Mon, 21 Jul 2025 15:08:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx6dl-sielaff: Convert to OF_UPSTREAM
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Frieder Schrempf <frieder@fris.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20250721125148.167020-1-frieder@fris.de>
 <20a08d1b-2b68-451b-b7e3-6e6f2bed7601@cherry.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20a08d1b-2b68-451b-b7e3-6e6f2bed7601@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 83665feb-9e95-450b-767d-08ddc857b833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a09ZVkFUZTB3TWt0ZFBzUHZtRVpwb2ozVzQ0UDlUeWIvcjBuUEdDaDJZOXhl?=
 =?utf-8?B?ZWY1Zm0wNXZVLzd4dXYwMXVYVXZ6OTF2bGFtOTRHOGF2aDRPN0p6WG9Kc2FE?=
 =?utf-8?B?MGprVVZEdWdnNytYL0ZXaW4rdFJqUUc5WDVLem85bURBZ1RnclJoUTMyRjhz?=
 =?utf-8?B?V3ByWE1yYjh3ZFdpZUlUWGZ5WEdtNDkwWHhrS1p1eG5scHFNWDhTM0M5RXhN?=
 =?utf-8?B?RGdMQmNtUW1jeHFHYmJqZGVuWExrSUNESUI0SEdYcmd0SWNQMmxmOHA3UVpM?=
 =?utf-8?B?dTcxNytRRkJrWTJRL3NwWHdzSHIyZi9KV3JQUzFKbHBzNE9nMWgzSU8zcmdZ?=
 =?utf-8?B?U0FieExick9QT05oNis5Q05rcHhRMzBRdTUwL0p5MUpFRUZ5UUhYVEV1Q0xD?=
 =?utf-8?B?a2plRUtYZGY0VVhNZHlyMmJaKzhUK1RyZExsZFlINHVocmJZVHZZcUFBR1M2?=
 =?utf-8?B?UXEzZnNWaDF3bDkxSkZrSTU3NUxqZFhMWVhHdUpQOHprRERVbVVqeWMrd2Ni?=
 =?utf-8?B?eFRBVjNXdE1ZRnFJYkxwTHd6QlE3V1ZreCtWY1FMQVFCMDcyMmk2dGpXWVZF?=
 =?utf-8?B?emo5bHZaT0tmaDJOZnM2N1ovbUN6Y0Eyd2Q3bE5VeGo2VEJBdmVaOVh4Y1VG?=
 =?utf-8?B?blZ0SDhmRzBmVmN0endTTSsrVHVaclBuaExOS3NFb1BZRVNmVWpiSC9MS0Zu?=
 =?utf-8?B?Zm5QM3RnUGhuUjlWamlxTlgxTVF6Y0JPNzc5dE1xVjNaL1NMMDlaK1Z2dXQz?=
 =?utf-8?B?WkZzSXNwKzMyaUdFUkczaW9LdEF3alhNd0dzbmhHWktuOU04dDUwMUZscnFY?=
 =?utf-8?B?QWVqL3NxeG04K3dYQzIvTFZnb3BCdnYrNjZRWU1UbENTUUVTQ1VqTnRyTnIr?=
 =?utf-8?B?MEdNL1kralVWNk5ETGFucmZoOXdKR1pZWVQybFdlSHBzUll0cWV0b3IrcUJa?=
 =?utf-8?B?ZTNKTmpRV0lKTzVDT1RSNUlZZ1dMT0ZaMSt3V0FmYjY0S3FVR0tvZFUxN3Qv?=
 =?utf-8?B?WkhrSDNiaytFZGpoWWVZS3VzM1cxNzN5YTdRUEtvZCswZEhQbjNBMkp5RGJw?=
 =?utf-8?B?TkdYTlJqK2g4QXBhd0lmN0ZScWhxam1oRmR4YnltTVFxSmhhM010V1FKalp0?=
 =?utf-8?B?VG02Mi84NmlDeUlGL3ptUjhBVitIR0UzVGJleEVUTWZadVlPZ2JzQ2NZUUtB?=
 =?utf-8?B?eTNrRjJIL2hLcU1YdGo5SVhveVIrN1FoUWV4UUJPN09DRzhsSmRDR0U2UFZF?=
 =?utf-8?B?UmZJc1dYbDhwUXJya0FzejdYNkpJejlrSlk4dllaR3lnNGsrM0hXSFJCVFNF?=
 =?utf-8?B?akN2c2U3SnhkWDlVT3BGSVdKZHdTVEpCVExoS1dseUx6UEMzbjlJdzhXekNV?=
 =?utf-8?B?QUp0V05KUGZKVDNPejJXUkFPS1dGT3Ezb080Q0ZsQTl0b3MrNWdrallUVmNw?=
 =?utf-8?B?Z1VRL3M0eHp3Umt3N0hWWjRmL09rdUxwVHl4ajRkV0lZN3prZFA0S0N3OW55?=
 =?utf-8?B?MFFVZ2FqUkJrMmhKaFZEeWxvK3JUMnEvbjBDcTJPR1AzRXBsN1VuQ2haZCtp?=
 =?utf-8?B?NWVDYkVkMGVxc0ZSclVqL0Y3eEFkUkdSMmoyU25lazJXRkJKYVJDdTdKME1G?=
 =?utf-8?B?R1NXQmJ1d1pvWDhMck5CY055QktKVEVGZlFqVlRmOWdlWXVvMi9KWGk0S3B3?=
 =?utf-8?B?c2FSVlB5ZUx4MG5ZNHNLQmF6OW9qbUxlMGo5UHV5cmJINVBPZHB4aVplejR3?=
 =?utf-8?B?WDhYVmtid0JPeGlpM08xVHJRMXllZ1ZzTUJLVVJJMUhRall6RE5CL0o5YXpG?=
 =?utf-8?B?THlkeFVyMDc3OHJlbmVicFpwUHRGYll3Y1pwMDFVU2VOZkwvdDZuZHprU0ZI?=
 =?utf-8?B?eVQ3N29jcDBta1hiQnJKQ212ZXJsRU4wZHVpeGZGa3dHS2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFNdFJsYzk4NVBUc0lOWkZhVEUzM0N5dVJVQmFYWm04bXk3bHJRK3VoU2F2?=
 =?utf-8?B?ZDNTTW9hc2VPZjZHekdsM3g1OXpQQkIvZWFTUHZZK1Y2VVlnRHJOSTlCSEYz?=
 =?utf-8?B?MTI0RnZGeGo4TWlqS3YxYVlmYVdKM3FRZ0ZrSlBHZ1VQSHhBV1lGOHdRZ3VH?=
 =?utf-8?B?VmI5V3U1allYMlpvZDJkcFJLcGY0ZFNaNlNXVUtQL2hHRkVDQzNCL3BYZXcz?=
 =?utf-8?B?V0h2ZklFU2RuaFVTenlza01mek53Q3IzOU9OUkZjTWx0SE0rVnF2WllCSzRX?=
 =?utf-8?B?bTljTzQxd1gwZCtTWDNqWHlmTGM0Ynk3N3VSY3lDNFBDc3A0MnlXSTNvNVRD?=
 =?utf-8?B?RzZDNXJDQ3kyemJYaTdPN2svRUZSTlljekc2eDIxRUtQTFJheTR3bWozd3Zk?=
 =?utf-8?B?akZZQ1pnb2ZMaWI5bHVQckRYdUoydlBEcktuMkFIVHU0bWZKT1hpTUljTXRG?=
 =?utf-8?B?dEtoZW9xZHN3ajhQTDRna3F6NHVxTmdRYTY1QlAvbWwvRnlCQnhDT3NwY2Zh?=
 =?utf-8?B?YUlHcWIyNUdUUTNyMVdLZWtraTd2T2wxeWZSNU5ybjE4amY2dzBmZGFJS2Nn?=
 =?utf-8?B?dVFmWTVnMkp0QlBFTTVsa0ZicGxQZDJWMXREK3NVOGI4TjdyU3Rld3lHQ2VM?=
 =?utf-8?B?dDEzakZ3SGtVTUFYUmVyMzhYc04zRHRPWVZKaVA3WEhjd2RWblNYbUJEc1c0?=
 =?utf-8?B?QmRlVFZVR05Ub1N1UXpMVGNVUjhWZW1pMGJpVGtVenREbGdiK3dGdzBadXFV?=
 =?utf-8?B?NFFLRkxNUmQ5SWlPbmVIbWFjUkRpZjFxTiszeTJuL1pYVnIvRHR4a1hOU3d3?=
 =?utf-8?B?NllsSGtzdjdOU3J6TVF5b3pqZHpneHlsUDRzY3lBQ3JyL3d0aExQcHYyNzNt?=
 =?utf-8?B?TktYMFVDZy9ZdGpjNk5lZkFVTEgycDZxL3Q1NmhsRFVadHF0RGUxRHN1SElt?=
 =?utf-8?B?OGtOU0JrOERHRE1OQWhkV1dONmh5eFRSN0JMczQ5L3gvNWFRNzF5Nkd5UVRl?=
 =?utf-8?B?VWt6RUVPaFZramV3OUZKaCtJcU9lQmttNnVMdzNkRXVjdlZDVWh2K25SQUxC?=
 =?utf-8?B?NFZxV3dRWWUwNW5UWUdVaWMwMUxtM3lhL09pdHlOdEI3aXE3aEhCQ3VJbXBw?=
 =?utf-8?B?d1l5eENqNEJsd3RXUndmcEhhV1NtdGRVaEZCVlViVVlmZlZGYUNHUy9yanda?=
 =?utf-8?B?eXFmd3MyTjlOVlhqN1NKbVpLZGwwRUJhamtIWWxHUmk3SFh2UGIrRWVya3Rp?=
 =?utf-8?B?aWdnazZqZjNOa0lBMWtHWHA1cWpCeG9LL1RrZkV3eWtPRDRmSzdHeVA0YXNa?=
 =?utf-8?B?QWRDNHJ0cWJ0NncxN1NCellDR3NlcmJNR3FENTFIQmdSZGVtVFpzUDUycFlV?=
 =?utf-8?B?NndJWlNtTVl1RmVjTXZnZFlsenZmY2QrTWlEZ1JQSmplcmgrVXI5WGVqYmdZ?=
 =?utf-8?B?ZitJTHk0UEd2eGVKS2Q2ZHF4MXBRaWZpNEFMOVhtRkhnTWtDSEg3eHYxRkZ2?=
 =?utf-8?B?bjdJdEVQZE1wd1NpRWcxaFZScnN1UUUyTDErNWd0YXlTSEJvSm5sNW0yTjJl?=
 =?utf-8?B?SXgwSlJQdm1vOUVvYmVWY3gveG5BWU5iOWxXRGhRN1kzUWJzWWVmT1lnREdL?=
 =?utf-8?B?OGJNZTV3MGEvc0NySUR3dVZScTBFeHNBa0JrVTRpVm8yY284dUxWdlVURkJM?=
 =?utf-8?B?ODhiYjQ3bkNabGYzbTBaMnREL3NPY2J4eHcvZVRZYUd6ek9DdGVqMjFqRkxW?=
 =?utf-8?B?STVXTnRmZlZWM1grK1RKTjZXNWh5cUc0ZHB5cW1RanFzZkNEYm9sV0JpMGVY?=
 =?utf-8?B?RXd3N0RoTGFRMlhCY1hiaGlGSi9KSTYwam1LaElWOUdoQnFaTmhtTHFjc0pR?=
 =?utf-8?B?L250dEN3SGE4T0ZLcmcwYVA5WmN3VXNVcTgzRkZOUkhBcVp2V3FVRVB3MVRS?=
 =?utf-8?B?VC9iNzdCL3NkV09nL3VHcm1BM0xIeGtyd0o4am1aQllaS1hnOW1IVFBHWkxk?=
 =?utf-8?B?UzlBdlRONnhPT0tsbWJzWVoxUURnUTRiZDhZaVlnbFhLUVA0RXlNU0xBMnNy?=
 =?utf-8?B?WHJCL1VtSW9QR0FOKzBYS0xMdGN5SHczTmM1OUR2dk9Cc3V0a0p6L3JqbDFx?=
 =?utf-8?B?TWlZYnUyelk1a2xIZm05TnVVbnhYZy9vVmdzZTluQ1Z3Sm12N3lMTEFKQTA0?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83665feb-9e95-450b-767d-08ddc857b833
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:08:44.8687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNpvLXqqE2q91MPbu6+QTNZ393ckv0teHPxoFeTW7rr+W2HCGioXFcsRDRiVrkSN3cID+4iJurXUFk8xHYSy5kzqQSFGEovzTYcNzUfFaZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9143
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

Hi Quentin,

Am 21.07.25 um 15:01 schrieb Quentin Schulz:
> Hi Frieder,
> 
> On 7/21/25 2:51 PM, Frieder Schrempf wrote:
>> [You don't often get email from frieder@fris.de. Learn why this is
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Switch to OF_UPSTREAM to make use of the upstream devicetree.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>   arch/arm/dts/Makefile            |   1 -
>>   arch/arm/dts/imx6dl-sielaff.dts  | 533 -------------------------------
>>   arch/arm/mach-imx/mx6/Kconfig    |   1 +
>>   configs/imx6dl_sielaff_defconfig |   2 +-
>>   4 files changed, 2 insertions(+), 535 deletions(-)
>>   delete mode 100644 arch/arm/dts/imx6dl-sielaff.dts
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index db83abb5967..d3cb7cf3f43 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -760,7 +760,6 @@ dtb-y += \
>>          imx6dl-riotboard.dtb \
>>          imx6dl-sabreauto.dtb \
>>          imx6dl-sabresd.dtb \
>> -       imx6dl-sielaff.dtb \
>>          imx6dl-wandboard-revd1.dtb
>>
>>   endif
>> diff --git a/arch/arm/dts/imx6dl-sielaff.dts b/arch/arm/dts/imx6dl-
>> sielaff.dts
>> deleted file mode 100644
>> index 7de8d5f2651..00000000000
>> --- a/arch/arm/dts/imx6dl-sielaff.dts
>> +++ /dev/null
>> @@ -1,533 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> -/*
>> - * Copyright (C) 2022 Kontron Electronics GmbH
>> - */
>> -
>> -/dts-v1/;
>> -
>> -#include "imx6dl.dtsi"
>> -#include <dt-bindings/clock/imx6qdl-clock.h>
>> -#include <dt-bindings/gpio/gpio.h>
>> -#include <dt-bindings/input/input.h>
>> -
>> -/ {
>> -       model = "Sielaff i.MX6 Solo";
>> -       compatible = "sielaff,imx6dl-board", "fsl,imx6dl";
>> -
>> -       chosen {
>> -               stdout-path = &uart2;
>> -       };
>> -
>> -       backlight: pwm-backlight {
>> -               compatible = "pwm-backlight";
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_backlight>;
>> -               pwms = <&pwm3 0 50000 0>;
>> -               brightness-levels = <0 0 64 88 112 136 184 232 255>;
>> -               default-brightness-level = <4>;
>> -               enable-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
>> -               power-supply = <&reg_backlight>;
>> -       };
>> -
>> -       cec {
>> -               compatible = "cec-gpio";
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_hdmi_cec>;
>> -               cec-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
>> -               hdmi-phandle = <&hdmi>;
>> -       };
>> -
>> -       enet_ref: clock-enet-ref {
>> -               compatible = "fixed-clock";
>> -               #clock-cells = <0>;
>> -               clock-frequency = <50000000>;
>> -               clock-output-names = "enet-ref";
>> -       };
>> -
>> -       gpio-keys {
>> -               compatible = "gpio-keys";
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_gpio_keys>;
>> -
>> -               key-0 {
>> -                       gpios = <&gpio2 16 0>;
>> -                       debounce-interval = <10>;
>> -                       linux,code = <1>;
>> -               };
>> -
>> -               key-1 {
>> -                       gpios = <&gpio3 27 0>;
>> -                       debounce-interval = <10>;
>> -                       linux,code = <2>;
>> -               };
>> -
>> -               key-2 {
>> -                       gpios = <&gpio5 4 0>;
>> -                       debounce-interval = <10>;
>> -                       linux,code = <3>;
>> -               };
>> -       };
>> -
>> -       leds {
>> -               compatible = "gpio-leds";
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_gpio_leds>;
>> -
>> -               led-debug {
>> -                       label = "debug-led";
>> -                       gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>;
>> -                       default-state = "off";
>> -                       linux,default-trigger = "heartbeat";
>> -               };
>> -       };
>> -
>> -       memory@80000000 {
>> -               reg = <0x80000000 0x20000000>;
>> -               device_type = "memory";
>> -       };
>> -
>> -       osc_eth_phy: clock-osc-eth-phy {
>> -               compatible = "fixed-clock";
>> -               #clock-cells = <0>;
>> -               clock-frequency = <25000000>;
>> -               clock-output-names = "osc-eth-phy";
>> -       };
>> -
>> -       panel {
>> -               compatible = "lg,lb070wv8";
>> -               backlight = <&backlight>;
>> -               power-supply = <&reg_3v3>;
>> -
>> -               port {
>> -                       panel_in_lvds: endpoint {
>> -                               remote-endpoint = <&lvds_out>;
>> -                       };
>> -               };
>> -       };
>> -
>> -       reg_3v3: regulator-3v3 {
>> -               compatible = "regulator-fixed";
>> -               regulator-name = "3v3";
>> -               regulator-min-microvolt = <3300000>;
>> -               regulator-max-microvolt = <3300000>;
>> -       };
>> -
>> -       reg_backlight: regulator-backlight {
>> -               compatible = "regulator-fixed";
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_reg_backlight>;
>> -               enable-active-high;
>> -               gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
>> -               regulator-name = "backlight";
>> -               regulator-min-microvolt = <12000000>;
>> -               regulator-max-microvolt = <12000000>;
>> -       };
>> -
>> -       reg_usb_otg_vbus: regulator-usb-otg-vbus {
>> -               compatible = "regulator-fixed";
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_reg_usbotg_vbus>;
>> -               enable-active-high;
>> -               gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
>> -               regulator-name = "usb_otg_vbus";
>> -               regulator-min-microvolt = <5000000>;
>> -               regulator-max-microvolt = <5000000>;
>> -       };
>> -};
>> -
>> -&ecspi2 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_ecspi2>;
>> -       cs-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
>> -       status = "okay";
>> -
>> -       flash@0 {
>> -               compatible = "jedec,spi-nor";
>> -               reg = <0>;
>> -               spi-max-frequency = <20000000>;
>> -       };
>> -};
>> -
>> -&fec {
>> -       /*
>> -        * Set PTP clock to external instead of internal reference, as
>> the
>> -        * REF_CLK from the PHY is fed back into the i.MX6 and the GPR
>> -        * register needs to be set accordingly (see mach-imx6q.c).
>> -        */
>> -       clocks = <&clks IMX6QDL_CLK_ENET>,
>> -                <&clks IMX6QDL_CLK_ENET>,
>> -                <&enet_ref>,
>> -                <&clks IMX6QDL_CLK_ENET_REF>;
>> -       clock-names = "ipg", "ahb", "ptp", "enet_out";
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_enet>;
>> -       phy-connection-type = "rmii";
>> -       phy-handle = <&ethphy>;
>> -       status = "okay";
>> -
>> -       mdio {
>> -               #address-cells = <1>;
>> -               #size-cells = <0>;
>> -
>> -               ethphy: ethernet-phy@1 {
>> -                       reg = <1>;
>> -                       clocks = <&osc_eth_phy>;
>> -                       clock-names = "rmii-ref";
>> -                       micrel,led-mode = <1>;
>> -                       reset-assert-us = <500>;
>> -                       reset-deassert-us = <100>;
>> -                       reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
>> -               };
>> -       };
>> -};
>> -
>> -&gpio1 {
>> -       gpio-line-names =
>> -               "", "", "", "", "", "", "", "",
>> -               "", "", "", "", "", "", "key-out", "key-in",
>> -               "", "", "", "", "", "", "", "",
>> -               "", "", "", "", "", "", "", "";
>> -};
>> -
>> -&gpio2 {
>> -       gpio-line-names =
>> -               "", "", "", "", "", "", "", "",
>> -               "lan9500a-rst", "", "", "", "", "", "", "",
>> -               "", "", "", "", "", "", "", "",
>> -               "", "", "", "", "", "", "", "";
>> -};
>> -
>> -&gpmi {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_gpmi_nand>;
>> -       status = "okay";
>> -};
>> -
>> -&hdmi {
>> -       ddc-i2c-bus = <&i2c4>;
>> -       status = "okay";
>> -};
>> -
>> -&i2c2 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_i2c2>;
>> -       clock-frequency = <100000>;
>> -       status = "okay";
>> -
>> -       rtc@51 {
>> -               compatible = "nxp,pcf8563";
>> -               reg = <0x51>;
>> -       };
>> -};
>> -
>> -&i2c3 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_i2c3>;
>> -       clock-frequency = <100000>;
>> -       status = "okay";
>> -
>> -       touchscreen@55 {
>> -               compatible = "sitronix,st1633";
>> -               reg = <0x55>;
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_touch>;
>> -               interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
>> -               interrupt-parent = <&gpio5>;
>> -               gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
>> -               status = "disabled";
>> -       };
>> -
>> -       touchscreen@5d {
>> -               compatible = "goodix,gt928";
>> -               reg = <0x5d>;
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_touch>;
>> -               interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
>> -               interrupt-parent = <&gpio5>;
>> -               irq-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
>> -               reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>> -               status = "disabled";
>> -       };
>> -};
>> -
>> -&i2c4 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_i2c4>;
>> -       clock-frequency = <100000>;
>> -       status = "okay";
>> -};
>> -
>> -&ldb {
>> -       status = "okay";
>> -
>> -       lvds: lvds-channel@0 {
>> -               fsl,data-mapping = "spwg";
>> -               fsl,data-width = <24>;
>> -               status = "okay";
>> -
>> -               port@4 {
>> -                       reg = <4>;
>> -
>> -                       lvds_out: endpoint {
>> -                               remote-endpoint = <&panel_in_lvds>;
>> -                       };
>> -               };
>> -       };
>> -};
>> -
>> -&pwm3 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_pwm3>;
>> -       status = "okay";
>> -};
>> -
>> -&uart1 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_uart1>;
>> -       status = "okay";
>> -};
>> -
>> -&uart2 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_uart2>;
>> -       status = "okay";
>> -};
>> -
>> -&uart3 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_uart3>;
>> -       status = "okay";
>> -};
>> -
>> -&usbh1 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_usbh1>;
>> -       disable-over-current;
>> -       status = "okay";
>> -
>> -       #address-cells = <1>;
>> -       #size-cells = <0>;
>> -
>> -       usb1@1 {
>> -               compatible = "usb4b4,6570";
>> -               reg = <1>;
>> -               clocks = <&clks IMX6QDL_CLK_CKO>;
>> -
>> -               assigned-clocks = <&clks IMX6QDL_CLK_CKO>,
>> -                                 <&clks IMX6QDL_CLK_CKO2_SEL>;
>> -               assigned-clock-parents = <&clks IMX6QDL_CLK_CKO2>,
>> -                                        <&clks IMX6QDL_CLK_OSC>;
>> -               assigned-clock-rates = <12000000 0>;
>> -       };
>> -};
>> -
>> -&usbotg {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_usbotg>;
>> -       dr_mode = "host";
>> -       over-current-active-low;
>> -       vbus-supply = <&reg_usb_otg_vbus>;
>> -       status = "okay";
>> -};
>> -
>> -&usdhc3 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_usdhc3>;
>> -       cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
>> -       vmmc-supply = <&reg_3v3>;
>> -       voltage-ranges = <3300 3300>;
>> -       no-1-8-v;
>> -       status = "okay";
>> -};
>> -
>> -&wdog1 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_wdog>;
>> -       fsl,ext-reset-output;
>> -       status = "okay";
>> -};
>> -
>> -&iomuxc {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&pinctrl_hog>;
>> -
>> -       pinctrl_hog: hoggrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_RGMII_RD0__GPIO6_IO25       
>> 0x1b0b0 /* PMIC_IRQ */
>> -                       MX6QDL_PAD_SD2_DAT3__GPIO1_IO12         0x1b0b0
>> -                       MX6QDL_PAD_SD2_DAT1__GPIO1_IO14         0x1b0b0
>> -                       MX6QDL_PAD_SD2_DAT0__GPIO1_IO15         0x1b0b0
>> -                       MX6QDL_PAD_SD4_DAT0__GPIO2_IO08         0x1b0b0
>> -                       MX6QDL_PAD_EIM_D29__GPIO3_IO29          0x1b0b0
>> -               >;
>> -       };
>> -
>> -       pinctrl_backlight: backlightgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_NANDF_CS3__GPIO6_IO16        0x100b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_ecspi2: ecspi2grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_CSI0_DAT10__ECSPI2_MISO      0x100b1
>> -                       MX6QDL_PAD_CSI0_DAT9__ECSPI2_MOSI       0x100b1
>> -                       MX6QDL_PAD_CSI0_DAT8__ECSPI2_SCLK       0x100b1
>> -                       MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29       0x100b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_enet: enetgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_ENET_MDIO__ENET_MDIO         0x1b0b0
>> -                       MX6QDL_PAD_ENET_MDC__ENET_MDC           0x1b0b0
>> -                       MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0     0x1b0b0
>> -                       MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1     0x1b0b0
>> -                       MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN      0x1b0b0
>> -                       MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER       0x1b0b0
>> -                       MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0     0x1b0b0
>> -                       MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1     0x1b0b0
>> -                       MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN       0x1b0b0
>> -                       MX6QDL_PAD_GPIO_16__ENET_REF_CLK       
>> 0x4001b0a8
>> -                       MX6QDL_PAD_EIM_A25__GPIO5_IO02          0x100b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_gpio_keys: gpiokeysgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_EIM_A22__GPIO2_IO16          0x1b080
>> -                       MX6QDL_PAD_EIM_D27__GPIO3_IO27          0x1b080
>> -                       MX6QDL_PAD_EIM_A24__GPIO5_IO04          0x1b080
>> -               >;
>> -       };
>> -
>> -       pinctrl_gpio_leds: gpioledsgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21       0x1b0b0
>> -               >;
>> -       };
>> -
>> -       pinctrl_gpmi_nand: gpminandgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_NANDF_CLE__NAND_CLE          0xb0b1
>> -                       MX6QDL_PAD_NANDF_ALE__NAND_ALE          0xb0b1
>> -                       MX6QDL_PAD_NANDF_WP_B__NAND_WP_B        0xb0b1
>> -                       MX6QDL_PAD_NANDF_RB0__NAND_READY_B      0xb000
>> -                       MX6QDL_PAD_NANDF_CS0__NAND_CE0_B        0xb0b1
>> -                       MX6QDL_PAD_SD4_CMD__NAND_RE_B           0xb0b1
>> -                       MX6QDL_PAD_SD4_CLK__NAND_WE_B           0xb0b1
>> -                       MX6QDL_PAD_NANDF_D0__NAND_DATA00        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D1__NAND_DATA01        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D2__NAND_DATA02        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D3__NAND_DATA03        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D4__NAND_DATA04        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D5__NAND_DATA05        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D6__NAND_DATA06        0xb0b1
>> -                       MX6QDL_PAD_NANDF_D7__NAND_DATA07        0xb0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_hdmi_cec: hdmicecgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_EIM_A21__GPIO2_IO17          0x1b8b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_i2c2: i2c2grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_KEY_COL3__I2C2_SCL          
>> 0x4001b8b1
>> -                       MX6QDL_PAD_KEY_ROW3__I2C2_SDA          
>> 0x4001b8b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_i2c3: i2c3grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_GPIO_5__I2C3_SCL            
>> 0x4001f8b1
>> -                       MX6QDL_PAD_GPIO_6__I2C3_SDA            
>> 0x4001f8b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_i2c4: i2c4grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_GPIO_7__I2C4_SCL            
>> 0x4001b8b1
>> -                       MX6QDL_PAD_GPIO_8__I2C4_SDA            
>> 0x4001b8b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_pwm3: pwm3grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_SD4_DAT1__PWM3_OUT           0x1b0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_reg_backlight: regbacklightgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_ENET_REF_CLK__GPIO1_IO23     0x1b0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_reg_usbotg_vbus: regusbotgvbusgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_KEY_ROW4__GPIO4_IO15         0x1b0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_touch: touchgrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b0
>> -                       MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18      0x1b0b0
>> -               >;
>> -       };
>> -
>> -       pinctrl_uart1: uart1grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA      0x1b0b1
>> -                       MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA      0x1b0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_uart2: uart2grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA      0x1b0b1
>> -                       MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA      0x1b0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_uart3: uart3grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_EIM_D24__UART3_TX_DATA       0x1b0b0
>> -                       MX6QDL_PAD_EIM_D25__UART3_RX_DATA       0x1b0b0
>> -               >;
>> -       };
>> -
>> -       pinctrl_usbh1: usbh1grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_GPIO_3__USB_H1_OC            0x1b0b1
>> -                       MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1         0x1b0b0
>> -               >;
>> -       };
>> -
>> -       pinctrl_usbotg: usbotggrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_KEY_COL4__USB_OTG_OC         0x1b0b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_usdhc3: usdhc3grp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_SD3_CMD__SD3_CMD             0x17059
>> -                       MX6QDL_PAD_SD3_CLK__SD3_CLK             0x10059
>> -                       MX6QDL_PAD_SD3_DAT0__SD3_DATA0          0x17059
>> -                       MX6QDL_PAD_SD3_DAT1__SD3_DATA1          0x17059
>> -                       MX6QDL_PAD_SD3_DAT2__SD3_DATA2          0x17059
>> -                       MX6QDL_PAD_SD3_DAT3__SD3_DATA3          0x17059
>> -                       MX6QDL_PAD_GPIO_4__GPIO1_IO04           0x100b1
>> -               >;
>> -       };
>> -
>> -       pinctrl_wdog: wdoggrp {
>> -               fsl,pins = <
>> -                       MX6QDL_PAD_GPIO_9__WDOG1_B              0x1b0b0
>> -               >;
>> -       };
>> -};
>> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/
>> Kconfig
>> index 465e258f8e4..0798eac68f5 100644
>> --- a/arch/arm/mach-imx/mx6/Kconfig
>> +++ b/arch/arm/mach-imx/mx6/Kconfig
>> @@ -366,6 +366,7 @@ config TARGET_MX6S_SIELAFF
>>          select DM_THERMAL
>>          select SUPPORT_SPL
>>          imply CMD_DM
>> +       imply OF_UPSTREAM
> 
> Why "imply" only here? It won't build without OF_UPSTREAM anymore no?
> Shouldn't it be "select" instead?

Good question. I wasn't sure about this, either. But "imply OF_UPSTREAM"
is used basically everywhere in the tree whereas "select OF_UPSTREAM" is
only used twice. That's why I assumed there must be some good reason to
use imply. Maybe that assumption was wrong, but I still wonder why
everyone uses this. If someone can explain, that would be appreciated.

Thanks
Frieder
