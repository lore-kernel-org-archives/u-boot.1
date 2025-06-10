Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042DAC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 11:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856C482AC4;
	Tue, 10 Jun 2025 13:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ePR5qZmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BD382AE9; Tue, 10 Jun 2025 13:18:24 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BFF8070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 13:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc0yL3Q9H0r/zSCvIrnSW9FazaLmjirIQshuwK2a1MRb2rkLEQqZnoSgs4MFZpFv77R1LOpnFS3l0zhNrMyzgsbM1axhvcMP2VIbC/+NAJPm2sCE00z3Ht8cmHZ9f9gVa4JyuntSxKiTjvo9MIhppa1sry/medMx7XhPnP7IE0GoB0sCCrnfXXYuedF/13SoJbHbLe/QN/DZIvaOZLaViBJU3AQKiaZuBvNJYOCdAyj11lQMzzbG/sEq+KuzZqkT/vg/5O10Q1bp/l0cgbSX9Eo5YBQjlReZxGdHM2FcDF8H1NO4gLSoqf2o7JbsQG3tFkqTpF8TNZW/DZFcDWmqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n+cuDxD8CJHNsgwnSo3N93bSY9sHZJ38DMVYyqh+UE=;
 b=YJXOwv2vQ5+WYEtYgcdOF/QsrHxcepjGQFLlVCQrKo9wRacF1mDCxVV/IS5Mxes3zdqEVG3rcyRDrbiXXjY8V6LlFPxxeIMT3MEO3N1d4+7DBEubBz/F0ROcLHCmUUzfSaxsWXdhPbb3MLd+zRdasPm0SUQANwm4yCMMuljVPt1Un63wu6/+HkEk+bY9vE20Xor8Vr52fEYkE/lkBPBxsMZJQEXKqoK1Jb5mu3kp109wio7iP9dSfPrHqcLY5lvWtLb/8BJTHeALhpRbusGnpJ4Z2nE1O7CgCKj8mupxH06+urjLFkITR9cjt7nfuFwlTcrxYsmSIJqoZ9WeKevGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n+cuDxD8CJHNsgwnSo3N93bSY9sHZJ38DMVYyqh+UE=;
 b=ePR5qZmvkE/g5Q6/KPdk63YiTaHnIG0xu3qSzcrmVVpDAPIfupZCK4YrL0Eek4ThrqOPAscpuiFEk+xievI+mN4jbE0sh9A1WiBs6zH6reVHFA7MwkZWZVwm7Ny9T9X8S/sfx3sZsKx465s8GPRrHD9BLeEPhkNWptar4vVGHpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 11:18:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 11:18:18 +0000
Message-ID: <907734c2-f401-4c89-888d-5eb2670cb690@cherry.de>
Date: Tue, 10 Jun 2025 13:18:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Searching and Finding boot.scr and uboot.env on a Raspberry Pi 4
To: Marc Haber <mh+u-boot@zugschlus.de>, u-boot@lists.denx.de
References: <aEcOkQdwEF9zNJu2@torres.zugschlus.de>
 <dc51ba46-010e-4fc5-a0bd-88c758940e96@cherry.de>
 <aEgN40XL0D8gIg0F@torres.zugschlus.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aEgN40XL0D8gIg0F@torres.zugschlus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afa6ed8-cb81-4002-a6bb-08dda810807a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0t1TmpEYVpLQXcvWTZCbXIxNlBkdWR0Rk5WQVU5eVYvZnRHQUFpWEpKdFJH?=
 =?utf-8?B?RGNQeFFzeDVSVUc4K0JJeXhKOVNFOXBQNXR4SzgyY1dCVVY0OHBNTm8weXpT?=
 =?utf-8?B?b3psZnA0RjF1cjlLSVV1NDhqbTNnMmFuTTJMYXMvQlozZUpIOVlVaDJSV21C?=
 =?utf-8?B?NDJGU0Q3MnhzZllTOVRZZmpaUW5mYXU3eGxFQ3dhZVdFT2V5RmJGVkc2TGtz?=
 =?utf-8?B?Rk1xdW83YzNtNW11YTgrdzg5bFdaQTVFcUNXMysrNTBRUUdCVW1sUG1LSHU5?=
 =?utf-8?B?dktRVjF6WWlwblFxQUZKYXhJRnRFa2pTWStVbk50T1lvSXZnUXVyUzVrMGpu?=
 =?utf-8?B?YmdsM0pkeHNyVG9nUllpK0c3bFFpTy9BTnpTbGlpc2l4cUt4dTRnYUFhN3lP?=
 =?utf-8?B?dGo0S1prdDBwYWxhUnZDa2I4aUp4MnNvd2p1UDlOWE1NSDYvWC9ZVC9pc3R2?=
 =?utf-8?B?WU5FUDFUTWUzQmR0THpJa3hWRVBxbVVjYk0waHk5QUxJay9FK0c1dFNucWNl?=
 =?utf-8?B?d1VQK0xya2NNTDRYNHFodVpLdGp5K0wvV3l4UE9vQjBodXQ2TjZ4SjhKTVQ0?=
 =?utf-8?B?bTN0M0kvMmpJZSsxQmRFbldzUXlEdGhvWkNMUWlZeGR2TGgzek5VN25LSkJu?=
 =?utf-8?B?WnI0Tm9QVEpxQVJPcFZWQldLNEVjVkFGSTVZYklCK1Rqd3MwZUcrd0I4WHJN?=
 =?utf-8?B?REZadEYxek1zaFQ4YnN0NW80L1N1Q21LWi91ZjNNMmhuMFZTWWV4UjlLNi9L?=
 =?utf-8?B?VFgyRk1UenNpMFVZeHFGaysxa2p0Sm9mMFNURE5CZ2c2UlBScGlmMFZOeVdz?=
 =?utf-8?B?UmdvbTEzYVUybkNtTXpsNU9IblpOaW5abFdjdWpCc1BZUHVLQkg2Q3hoVGI3?=
 =?utf-8?B?MU4vYzRmbXRVN3hEYU9seExXekVjaGJPU3FVUXNlbGNadFdwbFVzMm1pcU1S?=
 =?utf-8?B?U29WYVQrVWtMOVRVek9nbW9jSUNJVGlnWVpIaHh6RjczbFJZdG93VlI0UkJr?=
 =?utf-8?B?NzNwUkhtNE1uK2M1V2dXQ21mdDdhY1RqU25FWG0zTlJJWWIwRXlYcThBQndQ?=
 =?utf-8?B?UUdRY1dEZWYzZVJQNkxRTmo5ajZPdUFpT3dFM1A2YmlKUEp6b1VXRFFLOGgr?=
 =?utf-8?B?QXZJdlJZMUxsRHJSM3EzWjB1cHRQNFpzTGpSd0NuUEtndEhPNUo2ak9WSkE2?=
 =?utf-8?B?YVY1a3d2T3ZyamhkZ0ZyQklRVFJZeldnc243ZlFyYm53WWNkU01UWmlRSjVo?=
 =?utf-8?B?cDdxSUlUK0owMW5oRjNibXBEVmpFdllCeXpZWE9wclF4dU5rVnovaUVGeW5R?=
 =?utf-8?B?WUdsN09oMSswSG5HcjI3M1BjRFpIV3FZVHA4TGxHWDRZWWsyVFk2c0ROVmJG?=
 =?utf-8?B?UlhhUG4zc09xZU9GTk5mYTFXVXNnZFo1ZCsyZGpKN3lManJzcjFhRDBPUDZN?=
 =?utf-8?B?cTFONE1mZWNydzkwZGxzWGlYS0VLQ0kxU3ZNM3YzRlgvYzZpdzJpb0h2NVR4?=
 =?utf-8?B?WGw2cUlNWW1jUG1zL3NlNnVxUXMwLzJsajVwU0RhRnJMOVdGY0ZuWUx3Z0U4?=
 =?utf-8?B?ZDlONi9MamJobTlkKzZxNldpaXUyWFVTUGJsR1ZZNWg5a3dGWFBqak5Qbmw2?=
 =?utf-8?B?TGFlY2doVm00VnJBUnUxd0Q4anhJUHgwNUdlY3ZjTGR2anprZEhkQ3RSOWQx?=
 =?utf-8?B?S3Vvc1dGNEZLYndacFA0MXpFcHZlb3ZHV29sSk1uZFlQTWgrdWJYdnhBakwv?=
 =?utf-8?B?SzltaHVTNGtraHczUW1uQkdLamg3UnZ2UUgyQ1R5OTBWWXhMS21JR0hUNXFn?=
 =?utf-8?B?VmYwUkxxWUhSSWFRS29nbFI2aHk0SWw4cktKSG96ZXFrblJNeEVZZ3JaSGsx?=
 =?utf-8?B?aTBwcm43d2ZocHUzQmF3MWFycGMxeUVNTVpJQ2Q3VmhDYjNvZUxRUnByTWZD?=
 =?utf-8?Q?tu5LwbunR0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitsZmdhOGgvOGV0bm8xQ0FlaFJjUGZWL0pLWEd1SHhJWVExZWFuR2JzcWx6?=
 =?utf-8?B?TlJ2clJGUFpXNlBOditEMlFKVHpCSzlvbUtjZGhVYm9HZUNBamk3NW4yeE9j?=
 =?utf-8?B?SUw2WFEraVd4b1NNNWNYcWxmY1h4UWtRaTN3THh0OWNndkVYTFZ0SitDd1FY?=
 =?utf-8?B?N2Fyb0UwSklna1VwQ1QrOGhSTzFVNEVmb1hCRHdYbmRiWGs0SEhUNWpudE5Z?=
 =?utf-8?B?dnQwVlBJY1dXUFJsd2FsQmtDVGxNYnBDRFlZTmZmWndpVWpYaUE0a3FHWDht?=
 =?utf-8?B?amF5UUgxdlNUZFlLcm1OOUx3cVFZK0xndU1ueGlWZ1JkWDFYZVp2NXM5QjhS?=
 =?utf-8?B?cE1Jd0RzWjNyMThmRytqdFoyaW55WHBnUEZ4anhDTlQ1SUlWM2dVWEUvbklT?=
 =?utf-8?B?TVpOaEJPMUE2YVU3eE5ZYlhmb2Rid0l2UEo3MmE2QnRLajFaeHZRUVVOb1Jo?=
 =?utf-8?B?K1hIUThXS0l0UllyT2lITm54U2hnOHFBaTJPZTFuTEQ2Sk5uRE12YmNUSS9Z?=
 =?utf-8?B?N0U2SFhsMmROSytZYVJKWDdqSnJOY21TTktNdllNL2E5dC9pMHFUM01palB2?=
 =?utf-8?B?OXBOVktFUUhzY2JaRkJTcTBkbFpTUGcydlp6T0EwSEpQNk0yV2p0WUlIaWZZ?=
 =?utf-8?B?VkF4Y3RTTVFrcS9nMDJKdkhHYWQvcERaN01SYVZ1R0c5TU5XdGUwM0FOS0kw?=
 =?utf-8?B?SjYybU0zUUZndk82TnhnOXJKU2pzOGJrdFNiV1hDcytqV2xHL1Zac3l6Y28v?=
 =?utf-8?B?ekFDcnBBZlN6d1kwakpibVUyRHc4WW5POWdqMlhKSiswRTZSalBHWUtlS1Bj?=
 =?utf-8?B?c21LdVhQdXBYUjVZeFlCRUJVcHhLb3NRSFhHYWl3WC9mbDlhaVV3NVlPS3RW?=
 =?utf-8?B?OVkyNEliQmhrZmVDMVZDVjR5S1pYMFN3NzI1UGQ2aFFBMzkrOHVhKytRQ09X?=
 =?utf-8?B?VFRjTjBYSFZ6dE01MmZxWmRORXkxR2dqYVp4UFZEYlU0ODZ6NmJ4b0l1aVV1?=
 =?utf-8?B?SkNkQzdYZUcvUWhudys3WU1PRGxEM2htZXVQWERsUWNsZXBPaytKSjdOOXli?=
 =?utf-8?B?a2EvTnRmS25OenhYTTNNZ2o1bGg4UW15dlc3Q3BZcmZDcGs5bFlxR21UdHRG?=
 =?utf-8?B?VVlYN0pjMHE2dzdBY1pkdFlmMlRJcmNpaGV5eFJYOVZrWnd4Z0VCVU1RaS81?=
 =?utf-8?B?UEpQVkVnanlOc1pkYW82YkJkMmZ5d041RWU1TEoyL3pBeFVvc2dNRitRMkQw?=
 =?utf-8?B?Sk52WXh3TTBwMFhKQWFDWXFlK0pONmptVks4T0FTTEVrQzlPTlkxTjkvK3R4?=
 =?utf-8?B?SUZZbTR4cHZrVmdzbTdZcUZDZjc2MytOZEp1U1ZUVXBaZkw2NmdXK2x1djRn?=
 =?utf-8?B?Ujk5TGowMG9BU09xdjRBY2tqTk1KcU9qdHNJMk4yS1EyVVNyejNIakJOaDA2?=
 =?utf-8?B?a01QUkp3R1R6WHFnT1ZuampncHBtdlNzWFRpMmV1UCtOakJDdi9NNGdkd3J3?=
 =?utf-8?B?YTZSbFk0RGlmQnRnYVJFN2xMUmlSRzd5dDhiQWRMb2JLMkptSUltRGttMWlC?=
 =?utf-8?B?bjVLOTRUa0kyVmhCQ3F3ZzM2YlhaOGFxYzZRSUM4YWdHdjRmM2xrYXBpcVZS?=
 =?utf-8?B?ZUwwTy94djhFenZZVGpnbUpqWkVURmpnYmVWYnB3d1hPQ09iRkNkT2VPNEM1?=
 =?utf-8?B?Y3NNVDBPNmF1STd0elRrakdIM0JWU1Z4MCtqY1ZTdkpKYWNoR2prNjgzR0Er?=
 =?utf-8?B?eGdmUEw5VU8zR200UlNGNlZseU1XL05WR3AzYzNva0trNkptb1lYMy9Felhw?=
 =?utf-8?B?YXdpb1QzMS9qeXRwamxkMUQ0a3phQ3ZNZnNaNHhXZmZWckszakZSZktOaUl1?=
 =?utf-8?B?bVROZFNTNkRmVUx0NHBpTlhYWHRrb25oZTdDTVFtRmxMc2RZb29QREpKRDR3?=
 =?utf-8?B?ZUVXdGxESm1YbFltb0ZXeENkQUpxSFF5UE1wdDZQVU5JaU5QcGxmZlJNRGJ0?=
 =?utf-8?B?YzVOTzJsR243RnBZU3JFMkdwWHNDVXBzaXArMlh4SVZRMUJrOEVRT2lUdGgz?=
 =?utf-8?B?NTZhWUJaS3VWcTRySzlRNkQ1MDh2cWNXUlhDNE1GVWEzSlRjNzZVcXJYVWNX?=
 =?utf-8?B?eENBNFRMeElwd3duU2k3SWxHZ2VmVEJFaDJaSTQ4cmNNV3Boc2E3NERKMFMx?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afa6ed8-cb81-4002-a6bb-08dda810807a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:18:18.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1CChWEQFagxvxX0q7OmnyC9z4CduRHw9pBeiLWlKHsHRCO43RgaklctVw8XsFGpYmHJ/pUm2Isgsx5rWrDpfJ8VWWcg0iRjXqxsC+BEJ20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
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

Hi Marc,

On 6/10/25 12:50 PM, Marc Haber wrote:
> [You don't often get email from mh+u-boot@zugschlus.de. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin,
> 
> thanks for answering. I really appreciate that.
> 
> On Tue, Jun 10, 2025 at 12:36:23PM +0200, Quentin Schulz wrote:
>> On Theobroma boards (Rockchip-based), we force the environment to be
>> coming from the same storage medium as U-Boot proper, c.f.
>> board/theobroma-systems/common/common.c:arch_env_get_location()
>>
>> This is the location of the U-Boot environment in raw, not in a
>> filesystem, so this won't apply to your use-case.
> 
> Sadly ;-)
> 

But the logic to detect which boot medium was used is there, hence why I 
mentioned it :)

>> But quickly looking at env/fat.c which makes use of the
>> CONFIG_ENV_FAT* variables from above, it seems like you should be able
>> to override env_fat_get_intf and env_fat_get_dev_part from a board
>> file and implement what you want there, provided U-Boot (and/or the
>> RPi firmware) provides you with the information from where it was
>> booted.
> 
> Can I get u-boot to somehow log where it is looking for files? That way
> I wouldn't have to guess where to put a board file.
> 

By "board file" i meant a C file in board/ (for RPi, typically 
board/raspberrypi/rpi/ I woudl assume).

>> If you don't want to change the U-Boot binary and somehow you can have
>> a minimal environment to run a few commands, you could probably erase
>> the whole environment and re-import it manually with `env import`?
> 
> As far as I have understood, if u-boot finds neither its environment
> file or a boot.scr (that one comes from the environment as well, right?)
> it just sits there doing nothing. It's that first step that I don't
> understand.
> 

Which first step are you talking about?

Cheers,
Quentin
