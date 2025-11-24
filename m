Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3EFCFD342
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 18:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33E883E9F;
	Mon, 24 Nov 2025 19:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C3p8TOHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C23E83EAB; Mon, 24 Nov 2025 19:09:46 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D3383E62
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 19:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT8bsSAiNu8FqTp0gSz/hs6wOqAzLWwCJ72NJuIq7Kz9oDhfYKNyvTkkrho5btiCE9FO3hIVj9OQ2ujgOk8U0YB62trx2TG4/wTTsV/6G+SDhOZrH5HjOQZnSNgEtFp10BYhlxrc+GhWQCScQXnEqsroZhgrR3AL5d+8QpqmiLeVLNcBXyIzVFgFkF9cRsfpncTJpBjz6k5AumJGSvpZEV8h/kKExnEfG7rRRaLMlrGiiVucvX114g4uHKJu/W26KzEZ942azVANSIPXxP7dx21Pww0e1P62gEVTCxpS2q0OcLpz3K91X4BGhGlEugru4EXNJOcgAoS7SSmyeYKiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/wGJEaJe3hIkDu13nXE9pMqcxD9Bp1EaYsBNecHST4=;
 b=WzFUP1k0wquN53rLe+/LSFI+73dvzVZ1tgfh5UHktUYX8ulKPymiAr1CZj9KLx9pnvMzQO2O+4FfWEIbR83W7N15pDkXQxoeCUeWUIjdcR+4kdtRHCkyuE58nvgQDaQ1Ze2PpNONdiCAacUSU8SRwXlMajXJ5OeThlCfU05+ArcD7+e0Qcv9f8BwG6IvzTQiT83xPR5HFV6Vxi3raCIOF/Vo74gmiUy9761KjBjEDIR6htp4vsgzc5203Gg00CL9uy2FEWr4dIObsAri7Zp/SvrN+4pRejtuF9n9CXkhobR7SaeJ3Yn7xi47vg2uoOvVcL++kTP2/qe181m1QYfknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/wGJEaJe3hIkDu13nXE9pMqcxD9Bp1EaYsBNecHST4=;
 b=C3p8TOHwlOqbvSxf5ZwniUBwhnSX0PB/3ybi+6/JwA/bNoQmZIeOs/sWKf8M0VKu7tbcCwexOlINTE9bYEAkkDms48DbGU39l2V0ny/f5gLdkVKr4PM2l75Zx+AW0PSrymnL2L+kLa5za5oVjKtfhepfXTTwpg9IIX1QyusKVvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:09:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:09:42 +0000
Message-ID: <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
Date: Mon, 24 Nov 2025 19:09:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: e78898f5-6310-4a82-7e7c-08de2b84a3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG0wWmNWQ0M3TkE1enVpcXpsRkZEbkx6ZjVWYlJ2ejN5dkRtOGhiaGhHTk9B?=
 =?utf-8?B?SXdtZ0ZmTG5aakZ6OWE5bEt4U1kyRm9uZC9GNGQxRUhYWFNscExScm9zaTJ3?=
 =?utf-8?B?L2tRQWVmNGpiNWtka2l1ZkN5akEvUXVBNVhEL3hNT1JzVHZublhJUUg4TUh6?=
 =?utf-8?B?QU5vTWZoNW56OFgyM2JsKy95N2c1ZW5CRmg0ZmN4czhNSTFnNmJ5Sm9qR3c1?=
 =?utf-8?B?SnM5TlpoYXNXejQ1a3RWUnphaGo4LytGNm1FT3FteXVWQVFDVS9LQThEbFVN?=
 =?utf-8?B?VU9ZWUpMTDhOSGg3dGxPM1NVTTdINGxPTjhOWi9BVUdhbDJmR0k5L1ErQmZG?=
 =?utf-8?B?cWFhZjc0MDJaTHhKTEdVUG45TjEvMW85c3k4YmVWNXRmZVZpbGQxWEdWMWtw?=
 =?utf-8?B?RTViRWp6amNNR2tTTUdMcUlndk9CWmM3eXBpa3dHd0hPaTBraUxvT2k2YXRW?=
 =?utf-8?B?cTlmTXJTWXY0dTI2KzJndy8zaGdPclhRVlJNUjREUkdVb3Irdk84b1N1ZzJN?=
 =?utf-8?B?NGQ2WDBYMnc3aC9nZFBSRnVORmlQMkdvcGZXWDhNYTNnY2wvM1dITDRNeEFy?=
 =?utf-8?B?NUZHc0RuRG1KbmJhazYvdGNueGM2ZndiWnorVDFvMkp2ZVh6ZzI3TjY2empF?=
 =?utf-8?B?eGxwSmhtSk1tNGZ6dkRHSHdXUys1K3daRGRwT1ROaFBDMW9qdW5EeVRVU1RM?=
 =?utf-8?B?a3hwZkRDVWhCRHJ2dVorSXBrL2VuQTBzVTBNcEkzSkxvUjNpc0VzbGgzNms4?=
 =?utf-8?B?dFJyeFM0YnlWVUVyWUpkUjF4K1RBd0Y2eWJUdnZIajVQSTJVVjNMUFV0dk1x?=
 =?utf-8?B?dXI1S2U0U0dyMHdzOERtVm9xM3RNNEQ3a04zUm0yQWlxd2tndjFzS3oyYnk2?=
 =?utf-8?B?dllRNmJaSk5qcFY3UFFEeVo1aTRxK3ZaalR3RzFTNlp5T1lMblZ3S2gzOGxk?=
 =?utf-8?B?WEJuS1A4T3loM0VOQy93cDJzUTIxYThSUmFLdGl5Z3dxalNEeHl0SkpWK1Y2?=
 =?utf-8?B?NTE4WE1FeitGbUdseXJLR25LR2JmaVpXOFpGUzNZcDBsbmM3WGNybzNJdlps?=
 =?utf-8?B?YWVqb2RkdWxSUU16aDZ1cVA2MnQ0djVjRktacFZwZXdxWVp4SmRNZXBzMW12?=
 =?utf-8?B?VzdBQXh4dE41b0FSVUdaUkNlemZ1RS9QSE5GUDhCaXlUOGtLZUN1cGtMaDhq?=
 =?utf-8?B?clM4K29WSVNZUlFIa0RuT2piaSt5WCs4dnNvWHR5Vng3SW93Y0t5OG5HbU9t?=
 =?utf-8?B?V3M2UnhaZ3pjME1jQ0VJeHdlU0FKMEFISG1wZnlKUWxLMi84ZjNkRHpJNmxp?=
 =?utf-8?B?VzRkd0FTeUEwdklkTktLKzJLSEdmd281SkExRTdnTHNubUpBOEcvYXpzNGhG?=
 =?utf-8?B?S1VXSnM2UEVsWjdjS1hBZ1BNSm1FZkFGSzRNMTJPcUdXV1lZSVN2aTFGTWFq?=
 =?utf-8?B?dmsxa3pqM2dLY2FZb0R4SFFkVjNZZzFucnVTYVRjbVRZb0ZxUUVOYmJGc25a?=
 =?utf-8?B?TVRsZ25xOEJGVUMxWHZwdFpWVDVqcW1aQnN5VFhFYUZmUXl3R0J3ZVBMaXFO?=
 =?utf-8?B?Znc1N1dFNDY1K1hZOWd5U0ZSQVBPeS9nSDNBcnl0WkxqYjFvaElNYXZQZUpp?=
 =?utf-8?B?NGVldnpJOXhkd2QxZWE4YXBCdmtUUWx4QmxHT0krRUVwWEdma3R5aEFzRHVm?=
 =?utf-8?B?VG5QRGJDS2FLU21MT3NXRE1tbndPL3FTUVZ1UlczOTlTT3o3YkNrazB4QllL?=
 =?utf-8?B?Y1dGZU1kYXoxcHZBemFPS0RMQkYwaG9xdWdQUnNYT1hNd2N1Q2VnOWRjeWxW?=
 =?utf-8?B?Zmg1OHk1SE9RaW93Q2RPYkI0dkFaK2wyWVAwZTgvUk9aNkxtRkZ3MnBTbGNx?=
 =?utf-8?B?WVgyL2RQbnhsejd2OThVampGVlRpZkJlQjZWNUpvZHcwM3NINDhqOWo5bjE4?=
 =?utf-8?Q?y/2wOVMUAI2f3V8HNoUpJcuba8Mj+Hp4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01NWW9DZGtKR1dTQ2ttUFpXa1Z2ditqU0RONDllYWFOY1FwWWprSHRHUndW?=
 =?utf-8?B?cjdWeTdaNXpzOTk5RHNOLzBYb0haNCtEcXhUQnZCMGp6Y0xCOE52Z21JM25o?=
 =?utf-8?B?TUFhWDJpczBUdm00aTFpanhvRmQ4by9xaXpYbWN6azBITEFHdmIrNzA2N09m?=
 =?utf-8?B?L285d1NncldrYjV1WU96UEU3bktjUVp6Z00rWUJ3MUhwdC9nNXlDOUk4Tm5i?=
 =?utf-8?B?enNDeWl0Nk4vRFBCVHNJbjArV2FvRHhQbFhxdGF5ZTFlR0x4c0J5akxEYjls?=
 =?utf-8?B?TWpheGFwcFpmV016d1hsMDVRTUVkMkQrVGlUdm9EajY1ZEp0c2JXQ0xFbk5v?=
 =?utf-8?B?SGg4ZUJqdTNUcE5LNTg2TkMzQkZHaXJQeUo5cjcrUEQzZG5FcTk2dXczK0VT?=
 =?utf-8?B?d29ZR1JjOFVYWE9vS3RyMFEybmFaSmtjeWs4MVY3T0JrYnhWNmdud2RHdWw4?=
 =?utf-8?B?QUxzMnJSU0FLbTFQUEhDQi8rNHlRMUM3VGVmYnlkQ3c0T1VZa0psNFNFbEk1?=
 =?utf-8?B?UmpQUU15ZW1BTVBlMzJCRkJacWFJZ1oyS2RIb2NRQ2IxeDJVTUFNRmx1dE83?=
 =?utf-8?B?cFY4ekNWeTZPcno0SFR5TElpUndXYm1QTGZlaXZCZzRYRG92M0xmd1B0WnND?=
 =?utf-8?B?bkhJRWowU24yU0IrR1BWbzRSSk1rVWVzMFdiZVdJcmplUksvajMyQkNVSG1T?=
 =?utf-8?B?c2hVY296bHZORy9XVS9kR0pSWGdPOXpmWXhRNUhOU0NmNU5uQk5hb3NiazVW?=
 =?utf-8?B?YThyL3cxbEpqbnNxeEV2cVE3UE1kd05LOFNWdlY1U2svd3NIbFpmWTZ3RFV3?=
 =?utf-8?B?clg0blFiS2JVVjlZQlluOC9hZVlteno4cnVLUUpTZnA0R2R6b2hsVDZpZUFI?=
 =?utf-8?B?LzNSRmZJM25WVDd5Wmt1ZVh2YlJGM0VHbHpjelJSNUJlMHFGVWwrU2IrYU00?=
 =?utf-8?B?YkQyclJtMFVCOS9ZNllKbWhTZkw0MHphYWM2a2ZBUWh6NkRqU2VkVmc2VTJr?=
 =?utf-8?B?S0k5ZWhLMlVmMUVkSi95QU4wcGlKeW9Nbld3NU1FakhjczdHUS9vTlN0eUha?=
 =?utf-8?B?eFVXRHZFQm1HNXpaaWs3UnBwNW9qOHVEZVI0eWd5YjdGc3MyOXhsWldZbU1G?=
 =?utf-8?B?NDdZQUhlSVRmMEZaUkxJWWFvdWd3WFc4Sm1Pblh3UTB4eGsySTRlWFZkeHZ4?=
 =?utf-8?B?SmRCRVNQSzBPcG9UTjYzUDg0c3Uxa1p6RTROQ3pJZm8yZG1ySmR2TkpnLzYv?=
 =?utf-8?B?MHBUQ1ZzUjV6N08zT2ZoVDJGTGFHSjc2L3BkTmpzaXpTbmNwNlcrTWFlUGRq?=
 =?utf-8?B?cURWYzRNVG9oVk9ySy8rWGtlekY2cktZRTlkMWNiRENuenVDeE9vZWhtWFR6?=
 =?utf-8?B?dEtHTGZ4N3poYStKaDd4WEhlYnNTNXN1QkU4K3phQVJ1SUNUZ01yWUxWUEdB?=
 =?utf-8?B?eWxOQ2ZqVEdHM2FwdFVRYmlYWHBtTFFRSk1JaEhzcnZueXdQL040azU3aVBs?=
 =?utf-8?B?Ukl3aUp2bjR1MC9ybkd5YmRCc0hBYTF4L0ZhVi9rNUZrOGM0bUlLTzM4WU01?=
 =?utf-8?B?OG5MNTNPcXJZRlg5OU1wclp4b2lvdmJUdlhjbEQvOTFuKy81Y1BHeHZFNWxD?=
 =?utf-8?B?QW5vdHNNVk1DNk1mZWhHQ0dSamxBQkxHcmVRK0hPRzVJZGM2YkFMK2MwZTE2?=
 =?utf-8?B?ckVnSTZKajRNV0piZW1wWll3UUtCd0pzbkxYTU5BVTFBSVUvdjcvT1ljZjhV?=
 =?utf-8?B?TkFadm16RlRpb0dQUEt5WWNZMVFiRWlRZHFaeHNmSlh1dWMxREdaYUVQZ3d6?=
 =?utf-8?B?eFY5QkVFaGx6N2xlZXdKYkg3anpQclhtNkY1M01HTlNqQlQ2VFZYKy9QcGJB?=
 =?utf-8?B?QmltU3VqanBiMmhnUk5iQjlNSHRNeHBaQ0t1SWp6TUZNd3JnekNvclBRNHRj?=
 =?utf-8?B?UTEvYmo1NUVjK0ZRVWExMUN5UXd6M2ZXV1EvbWRaVWc2ZWRvQzI3RE5VS3hu?=
 =?utf-8?B?UTgvYXZwM1JkczI5OEpWVVBtSjVGWXczUlpPSXdxdGl3dHNQR0FwdGFKRmxL?=
 =?utf-8?B?aVNocXdabUsvVHFPQzdUdW1NNVR5ZFgzcG80YUJ3bUIwS3Z3UkpsaG5SVDlR?=
 =?utf-8?B?RytJdmVZckp6SWNJNXpaQ21LVzFVMWQ4M0k3ZndFL2NBRlMxd0RSTlRsVDlQ?=
 =?utf-8?Q?6BNvwnSEo5EEao9umYlTs7Q=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e78898f5-6310-4a82-7e7c-08de2b84a3f5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:09:42.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiLzkO1UcYHWi1TPw3yHyk66ELX8A33la9RSej3Wn7lnS420S8jH8HEoGsTx3O4KO2tlBeoDe99TU1DSse0jPA1xEfoeKQ4MQpd4UwRSITE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792
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

Hi Brian,

On 11/24/25 3:17 PM, Sune Brian wrote:
>> Device Tree is representation of the hardware. Is the watchdog present
>> in hardware? Yes? Then status = "okay".
>>
>> Ideally, the board shouldn't fail if watchdog is enabled in DT but not
>> the driver (and vice-versa).
>>
>> Do you know what the actual issue is? Why does it fail when watchdog is
>> enabled in DT but not the driver?
> 
> Best guess watchdog timeout.
> I have no clue but this is the case.

I know some SoCs/ICs report the reset cause and you would be able to 
tell whether the reset was triggered by a watchdog or not, do you have 
such a register available maybe?

> Otherwise it cannot explain why it is always at the point of message
> check and fails.
> 

Add a substantial sleep/delay right before the last message you see and 
check if it fails after the same amount of time or not.

> If DT is enabled but not the driver then the driver is empty from first place.

My hunch is that SPL_WDT is enabled (or whatever other mechanism can be 
used to start the watchdog on this architecture/vendor) and somehow the 
watchdog is started in SPL but not in proper, in which case the watchdog 
isn't pinged. It could also be a remnant from the previous boot if this 
is a warm reboot (e.g. the IC isn't entirely/correctly reset before 
booting U-Boot).

Looking into socfpga_cyclone5_defconfig it seems that SPL_WATCHDOG is 
enabled but no driver is. Can you tell us which (failing) defconfig 
you're using (and if it supports multiple boards, which one) so we can 
check assumptions without going back and forth with you?

> AKA the watchdog never initializes proper cycling? (my assumption)

The designware watchdog cannot be stopped once started, you have to 
continuously ping it, c.f. comment at the top of the Linux kernel driver.

> If the driver enables but DT does not then it simply disables during
> probe or ops?
> (also my assumption)

If DT node is disabled, the driver won't be probed for that device, 
nothing will be done.

> 
> So simply said w/o the socfpga watchdog driver it is problematic I guess.
> So always complying with the driver and leaving DTS to do the job is the
> most stable case.
> 

That's a bandage fix. It would be better to have some idea of what's 
going on. If this is possible, bisecting between a known working and 
broken commits would hopefully return the culprit and we can start 
making educated guesses from there. I also see no defconfig in upstream 
with TARGET_SOCFPGA_GEN5

Cheers,
Quentin
