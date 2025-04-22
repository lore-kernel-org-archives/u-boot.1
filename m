Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D29C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F5080FF7;
	Tue, 22 Apr 2025 12:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QGp0dW+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F514810E8; Tue, 22 Apr 2025 12:49:47 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5BD80FEC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPCPxqUy76SlhMbdLzsxhpPZfB/sNHx9yqNmvB+/ohIFQbrIEu4uCPqvO5q/obbJ2MqLF+28E6IQO9Bv1yPU+pPSS8nxcoN0NVWJx8lpEWZ2MPmX3Qzp1ISjtCBhNDwkK6gx1xfHRKXHXoEWe3M02HNuCDXCJLv8r220/pDU+EhVeqAQkvNZBXRWf1U6DpO2R1Z51/cDJ1lTQ5WEol8uydh1wnmR2bVvzBXaSUYQb9feeLtFMjo+39Px0i9t1jfRr+HOOQ80sZy4WgbAhq8sC0FNcMwm7w7vjOMxElwp/VF2z5NCa98ZdcE58dJefoPXB38sMqZhnscbCgFnMCihXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPUlhRkou+/doCXTT3utRZia/0EIBfpCwBPAa9iyfYg=;
 b=UNc5CymSaLOZ+FGROHC3HTijzQ0oX+eaw/GsFKOSgYqFMaxRGfgg461tx/mtmNj3p1LfTLcmmuKJEOfzLE+EmWlaOPe1PEymIUYrJm9BN8OC8GF7I1G7GdS5Yx2HPqUny+9+4H2bQvY4tYRA3jSjWdL3/jGrIPOelf0cN7YIzbhk2KmBOIVJYdxApaw5z9tCu7hQChszTKhBv4pY75Atlhj+9/EqxctJgouyhH//cMzrVM+scNIz2sUhK6EOjX5WE/R4ye0nSaWC5VY5rr4YkF0/VYr6kctO+KIdYw/5UR8xhMryK2u/zGjGjAypxb5AlGApLHq/qqv+ASFPNDqZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPUlhRkou+/doCXTT3utRZia/0EIBfpCwBPAa9iyfYg=;
 b=QGp0dW+wMIw24KMtim41yZVzEGE8jkjme2q1ffa+xHUBBSybmf9j725ebLHtSRYb7yXXNvybsInWjBNEU/8UALDCRNdaixeiTQCZA5MOaHb7cT9nvXV30k2pBGXpapb2bumB+2xAIm43sR16Yh5ai3bXp6A2LDQ0nUKKLmI3hvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 10:49:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 10:49:42 +0000
Message-ID: <e2d354dd-4be6-45b0-b263-7112b9320692@cherry.de>
Date: Tue, 22 Apr 2025 12:49:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
References: <20250417000539.3709-1-andre.przywara@arm.com>
 <20250417000539.3709-3-andre.przywara@arm.com>
 <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
 <20250421222939.69832f73@minigeek.lan>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250421222939.69832f73@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9101d91c-4b14-4c30-5e92-08dd818b636e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmdDaVBaYXJYNVF4YzhIUk1raGFQRENHUEd0aUdTYTBaRkpLbW1HVVRQZ1F5?=
 =?utf-8?B?NkxQMXI1ckFQTVVwenBNSk5MUGcvVCtwSVFZOWR5SlJ1TkUzQjYvQ0ZYWG5X?=
 =?utf-8?B?QVpsQkd2WjFMR2lxc0NJZkx1bjIwM0QvcmdPZndMRHRsRjVvYUJNS1JNSzlL?=
 =?utf-8?B?bUVVM21mSlNVUkZqcXQrd1FEcEMrREpSUHpseWFDQWZPTUlMZXlqbW14K0p3?=
 =?utf-8?B?bDNPcU5sbFozUzRkMysrdWZuVC9kQlBjTEtoRzVtekVJNDVnaHI3UTEwLzJy?=
 =?utf-8?B?c0p4d0Ivekhma2xZOTY0ME00QnFGaXJNaFMwWGdNbU9yOS9xWTRuOG1nUUNi?=
 =?utf-8?B?d3NsWlB3b3pYYi9kdnByUHkrdk9BVStRZFdlTGE2VUpBQjk2VmxmUE1YSnBs?=
 =?utf-8?B?dU93clNlUlRHRXdwMkoyR3NqVnp6RTFlZmE5eWZ3QXJiU0pQZjVFMjV5M0JS?=
 =?utf-8?B?YUhLYkVGVVhLalhGY0wvRElDV3hTNmd1MDd5a25pa1lRcXRwSmFnbzRocldX?=
 =?utf-8?B?LzhGb2JwMVByV3poUUFjaTZkNUR3U0Y2WndzM0NNZWQrTm9zRXpDOHJhU2hq?=
 =?utf-8?B?RkhzdWRyeFFkaGhENEk0MDRodU41ZVlMMzB4Y0cwc3pEZi8zUjZWZGNyRm1r?=
 =?utf-8?B?TFZTcnZyUkNhSEdyOFNoOVZyQUw2UlArdTNCbkt5cDJSbFpNdEwxdlhGVXlN?=
 =?utf-8?B?cFJNK1M3bXZHRnd4NmcwMjVHMXNISG50dm5xUlFROGJzS0t4N1I1SkNHTXBR?=
 =?utf-8?B?ZEtVeDhFSjhoNllWWXNDbW9DVTdzV1pzR0NLMUU3amRWWkhwZnNHOER2MDdz?=
 =?utf-8?B?UE9pZlRNd0pLc1dYYUZEVWFTK2lzeVkzYU9XUlZOd0dJbFJpN0pnNS9GMll0?=
 =?utf-8?B?OHA3ZXlxUERBQnQ4MGFFa3luVVEwN2dsbGsyd0NGTy8rVHdtU3Z0aGRQZzBG?=
 =?utf-8?B?b2lFcnFjUlBTVlVtWHhGanhwalVKb3hLYi9RQkVmTzlwSTYxRGFsaWNTbU9q?=
 =?utf-8?B?ekVHK0dDSXY5OXg4SEtVcVVZTE41WXJRV2ZZYUE0bHhyTFlPWUxvNzlOb2Zi?=
 =?utf-8?B?TlJtUjNtNCt1SnJBdW9VdEUyK285WHBFQUdnN1pJNXVadXdDWEFTV2U5U3ho?=
 =?utf-8?B?TzhqUE9IbzRDMEwzY2Vza3gwandmOSszdnErOEtiU01qQ3crdEpybjlsVlRh?=
 =?utf-8?B?UC9FVGMzeTRzZE5FYkVHVTRFVzdnaHd0UFFEWjBZWVZpUmtDZHlZZVZOM2Rw?=
 =?utf-8?B?VjE1OU5sNDB3OE9vbk9qUHA3bUhYTFRXeWxjM1hjb2ZNR241ZUZERzFrY3Ju?=
 =?utf-8?B?UHZjT3RrbittYlpiZXZYancwWjdvWExlZTNwWHRWOWpYbkpiNmZTeFVBNmV4?=
 =?utf-8?B?b2hPQzJhdkZVemZsWGR0cFF5VEdqNzM1aDhoMm5hWW9sMnJNei85NDIxbjFD?=
 =?utf-8?B?Y2V4SERvZDJGaWFiam1RUzAxZ1lWT1p0ZXRBRkFSdHJ1QmNMcjRiVFAzK3pR?=
 =?utf-8?B?c3kwdU91dWlxS2dYN012K2JVOFJ5M1FDSmZrQUF2bmpZdGJxWkpUVGE2OVpm?=
 =?utf-8?B?NEs0UDlrUzZCN2ZQaHZDczJNcHdQQ2Y4RXNEdGJjbUNKeUZGcm1BRStyTVdw?=
 =?utf-8?B?U0tCNXM4d1o4STlZSmtGTmorbWFTZzRMVWJUMDBHckp3Q28rVHpiY045VXd3?=
 =?utf-8?B?SjVGZmF2US95aE54cHF0dkY0ZnVtQzN5MXJ2VmpRWHA2VlNuY1NnZllVVk9s?=
 =?utf-8?B?bFhNbGZvUmt6SVJSeXpYR0hyYWlkT0V2WGo4dkVJK1NhUkFrSzlvNm5pblB6?=
 =?utf-8?B?SEEyTzU1NUNwUWFFcmNWSHhma3ZJZG1DdEtaVzJEOEpKQTRhekV3SWE4UnhM?=
 =?utf-8?B?aFVlQkJuM1ordXREUGVEdVhaTlR2U2RHVzc4RUtlSnJaZ0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldXVzQreVZ2eWcrZ1hPeWdnbnVhYzFzVkhsN1pHY1U4OCs5S0p4NVVDR0ZL?=
 =?utf-8?B?clhMcHRFcFB2T0lUZmpWSVlpc0F0SHIyQzZUOWZBUnJaSnI4SDZxV1Fwelpx?=
 =?utf-8?B?NlVKVjVjOW5EZ2lxbnhxWlZHWjUrYkJjdGwxVnlKMEsySkhObko4UCtZdmhQ?=
 =?utf-8?B?UjJCaFBLK3diaXpvbUYrcDlRbXZtQWoxRHVIREJ5bmJPZ1c2Z2dBQVZkdzdM?=
 =?utf-8?B?bFoxaHhnODN2ZnJLL0IxSklYeThqbmhvVVBwN0NDWUlkcmR3VVl3bG5YdElr?=
 =?utf-8?B?WkJ5ckdSYU50SjVBMDExQXVveURuOGQ3K3JYa1dwVE1QRWd1TWhFSmxWUHB6?=
 =?utf-8?B?VVJuekZqTjZXQitoTWVibjNVWW0zVW5mM0ROM3JUakNvNFkxUTdRbnZtZ05h?=
 =?utf-8?B?T0ZuY2JmV1QzNEYxZVdKOEI2c2NVeHVKWm8xVDhxVFpHdVFhV0dEZnQxNEJ6?=
 =?utf-8?B?cmNyUjRhWGV5RjFZcFlhc0dNTk1RTzhSbVk1bmg1c1Bmemw3OFFQd3N4akNP?=
 =?utf-8?B?Mm1HbXFkVXFrL2lwWDh0VWlRU0lYckFtRDNiV3JIdTJaSjhWcmVYR2ZqWjZH?=
 =?utf-8?B?VG5hN3p1V0t6blg0a0F2dnNhUllwOHJPSzBzS2h4bmJGaHZpUE5PdzFneE9U?=
 =?utf-8?B?cEVhczlHQ2Mvc1lmKzVoalFENGovSThtUndNa3FyQ2x0Rzdud21rY1NkS3BB?=
 =?utf-8?B?TmN6eU9Wam5UVFp5WXlYRGhGL0FhdEpVeC9LdEl5VFNETTNZUTV6SHYrT1Ba?=
 =?utf-8?B?aHNidDJmeVowMVhWaytWUWdWU3FPZ0swU2NwcFdKaGlObGlmczAvUWRrYVZN?=
 =?utf-8?B?aHRzejVMWFp2RW5SV0oxVzNVYnkwTUhDQWpIYnRqbWp5MkE2d0wweUVLc1lF?=
 =?utf-8?B?akhwRFlzT1R5cmhyVjZCQzh0aUVrNVE5OVJCaHRrVnFCNGpsM2JGZzJ6djBv?=
 =?utf-8?B?SkdlYWdMd05QTUEvYXZqMlJlalpBQS9PUlU5aFhqQ3NwZTdWTEw4UXltc1hx?=
 =?utf-8?B?UXJmMUR0RlJkZ0VXcnV0TEoybDJUSnRXSEp3QlljQVVtSTFhS2IwVis4cXI0?=
 =?utf-8?B?Vk1DajIxdXZEZlYrQkhVQ0Y1ZWk3S3lBQnNrM1dveE1HRnIxUEl1Y0xyd04z?=
 =?utf-8?B?aEtDUks0RzB6dEpmbzAwbXVtYVAyVm5MYlR2OEtSblgvUVhwdVlqa3lvdEpL?=
 =?utf-8?B?YmlpRno1bjZpeWR1QWNxbDlXN3lxMm93V2dEQ0tKc2dXbU4rUGY4b2VqTG5w?=
 =?utf-8?B?L2YwZnVEajZMSEpNTzU3WVpKRVF6amM3cEkxSzJDU2RiM0U0eVVtN1FsTmgv?=
 =?utf-8?B?R0Y4SWp2WlkxY2Y3T283ZVViWFhGN1k1UzV2RkpEd2c1YkExZENVVEZwMy9l?=
 =?utf-8?B?cHRoU0dhMEtUTTA1OThmSnQxVjZObWkxbWxhendFSDNhTGcvWTMxVDBGVm8r?=
 =?utf-8?B?V25KSEdvNXM2YUZZSlQwd2NDS3YrMHpvSlhDZUljMXVtWkxMSTRpUllQcVpm?=
 =?utf-8?B?dnQrejY3NkpuYXJ1MFI1SHNGV0tzYXIyOVhVTU1Da3RzVk85SEM3elJtTlJG?=
 =?utf-8?B?MUNrRXJ2MVRER1U0Vks5Mjl4T09mblRmN0NTR1pTcjBQQnJDYVd3VXFZa2po?=
 =?utf-8?B?NFBYUzUwNlgxUGF2V01xRzhBR3lHTU8vbHZCMmNEK2t1ZHNRbEFrSUZuRHhP?=
 =?utf-8?B?MERuejJXWEpnR2g4MGNvcE93RVZTMEYrYWJ1TVVTMU1peVhIS01lcWF5bW9T?=
 =?utf-8?B?USsvMXZQYjg4NldrMmhkYWhob2ZseHFrM2F4d0VpemxsUTRDdGJnSE1rTDky?=
 =?utf-8?B?VDJOeWhyMGRVT1cwcWMrRFREQ2dleVBWQytDRFVqL3VhVXIrUVNhSEJaMHJ4?=
 =?utf-8?B?ZnpsTFlzSlZQRTRLUkdRMTgveU5BWnJMRGdSeFllOEFYTm8waStkZWQ3SHZx?=
 =?utf-8?B?b04rU2txKzA2S1gybHVFbDlSc21rOStjczdSWDRxVXRTcHFmQXJXbUNYV3JN?=
 =?utf-8?B?NC90c0pxcnhRVCtkZTZyUG84eFJIZm9vSE1IMnpvbkZDdUMrTElEemVWV3JL?=
 =?utf-8?B?RG13SDJHZ1g3cXlmcHdHdldQbFVXODN4SC91bHdPR1JnclV0VnZUNk9ZY0gz?=
 =?utf-8?B?YWNWODYwZmVZc1Z5d1VybXpUS2pTci91NDIyWHNhOFhTL1I1eGYyY1oyNDMx?=
 =?utf-8?B?Rjh3NGlUcVpVRTBIVnJkVFZLZjd4d3JTdEdhbmU5dkRvQUczblhSeStVVFRo?=
 =?utf-8?B?TkhaZkRmcWhteXJKMFU0QmFZbkpRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9101d91c-4b14-4c30-5e92-08dd818b636e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:49:42.6213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0XYvLGCSAB22y3eqTCjYBvFXEB53gXef1xWfCpjtnTYKr93Tm6Nr9aLCqmeN3AHLgGwGM+5jvumAs1xhKi9MAIQ+mAw1VE0S7983g6Q85U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

Hi Andre and Yixun Lan,

On 4/21/25 11:29 PM, Andre Przywara wrote:
> On Fri, 18 Apr 2025 13:28:23 +0200
> Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
> Hi Quentin,
> 
> thanks for having a look!
> 
>> Hi Andre,
>>
>> On 4/17/25 2:05 AM, Andre Przywara wrote:
>>> Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
>>> labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
>>> power-on or reset. This allows to access the SoC's memory via USB OTG,
>>> and to upload and execute code. There is a tool to upload our U-Boot image
>>> and immediately boot it, when the SoC is in FEL mode.
>>>
>>> To mimic this convenient behaviour on boards without such a dedicated key,
>>> we can query a GPIO pin very early in the SPL boot, then trigger the
>>> BootROM FEL routine.  There has not been much of a SoC or board setup at
>>> this point, so we enter the BROM in a rather pristine state still. On
>>> 64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.
>>>
>>> Any GPIO can be used for that, the signal is expected to be active low,
>>> consequently we enable the pull-up resistors for that pin. A board (or a
>>> user) is expected to specify the GPIO name using the
>>> CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable. When this variable is not set,
>>> the compiler will optimise away the call.
>>>
>>> Call the code first thing in board_init_f(), which is the first sunxi
>>> specific C routine.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>    arch/arm/mach-sunxi/Kconfig | 10 ++++++++++
>>>    arch/arm/mach-sunxi/board.c | 31 +++++++++++++++++++++++++++++++
>>>    2 files changed, 41 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>>> index ab432390d3c..f1cfdb548bc 100644
>>> --- a/arch/arm/mach-sunxi/Kconfig
>>> +++ b/arch/arm/mach-sunxi/Kconfig
>>> @@ -825,6 +825,16 @@ config USB3_VBUS_PIN
>>>    	---help---
>>>    	See USB1_VBUS_PIN help text.
>>>    
>>> +config SUNXI_FAKE_FEL_PIN
>>> +	string "fake FEL GPIO pin"
>>> +	default ""
>>> +	---help---
>>> +	Define a GPIO that shall force entering FEL mode when a button
>>> +	connected to this pin is pressed at boot time. This must be an
>>> +	active low signal, the internal pull-up resistors are activated.
>>> +	This takes a string in the format understood by sunxi_name_to_gpio,
>>> +	e.g. PH1 for pin 1 of port H.
>>> +
>>
>> Why not use the DT for that? Then you wouldn't even need to assume the
>> polarity of the signal or whether pull-up/downs need to be activated, etc.
> 
> As Yixun Lan already pointed out, the DT is not available at this
> point, and doing several pull-ups to get this information from the DT
> into the SPL image are really over the top for this purpose.

OK, we do have something "similar" for Rockchip boards, via the 
sysreset-gpio DT property in /config, see 
arch/arm/mach-rockchip/rk3399/rk3399.c and 
arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi.

I guess something similar could be implemented IFF there's an actual DT 
in SPL (or even TPL). We for sure have DT in SPL for most if not all 
Rockchip devices, and probably in TPL as well. Hence why I sometimes 
forget other Arm boards may not have DT in those stages :)

> This is more a sweet hacker device: I often have devices with eMMC and
> SPI flash, but without a FEL button. So the idea was to just pick a
> GPIO and use menuconfig to set it. Then I could just connect this pin
> to GND during boot, to get into FEL and test-boot firmware. "Connect to
> GND" could really be a jumper or even the tip of a screwdriver ;-)
> So I don't think this qualifies to being defined in the DT, really.
> 

If I understood correctly, this GPIO is essentially not fixed, you just 
pick a random one that you like and have access to and it may differ 
depending on the user I guess?

Then yeah, I understand.

Can you please specify this in the commit log and also why we are not 
going the DT route (if I read correctly, in addition to it not being 
suitable for DT due to the ability to the function being available on 
any unused GPIO, there's also no DT available in the stage when this 
needs to be done?).

>> You can have the property in the -u-boot.dtsi then if you want?
>>
>> While the FEL button on the X96 is "fake", it does what it says, just in
>> software, maybe that is close enough to "hardware definition" which
>> would make it suitable for the DT (well, we also store binman nodes in
> 
> Yes, I have a patch to add this particular button as a GPIO button into
> the DT, so people can use it for whatever they want in Linux (trigger
> reboot, update, you name it). But this is rather orthogonal to this
> problem, as mentioned above.
> 

Mmmmm but this will be in the Linux kernel DT and I assume you want the 
same GPIO to be used in U-Boot and in Linux, so it would probably be 
best to make sure they stay in sync? How are you planning to do that?

Cheers,
Quentin
