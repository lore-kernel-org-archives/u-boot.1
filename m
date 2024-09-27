Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28F6CEBF8C
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 09:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38014890AC;
	Fri, 27 Sep 2024 11:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DLltSfMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B342D8909F; Fri, 27 Sep 2024 11:28:52 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEEE7890AF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 11:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YivH3BXhj5Qc+TXEntZfrlTbrevAHPC05l7AUuQSIZYvYWITABdS8rc1nCCQejJedtYavXozn6TvK8pOsmhE6H7kW0yKCrphMoJsnlrWkzBFvbCdEaTclGJdhMNUcSHcKgd1De8B5dg/iEMehnuh+VDaoDf9u41vI9wHQyMf6D1NY+L7eQUnBGyCdUK/p/j5U+78A8p+NXNKTemSq8KpRDQypgM/VpVZ2Mek/tT+ZV7ihBRV357nMMKumPzYQvj6FF3lGmjYcRI3AFKp3JQtskBYIHRy63q8CdgavEXAzdBMVuUqkncLMIO+f7M6Zk2/V8ZVwP+p1w9Vw6msSJbO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2kvkwdE4JGHegEbwEHvVJ4IpsAOeDxS2GQB9pdLjSc=;
 b=uP7BB7i64aT8VYPc+rdoVwTdhIQ1BsBL0ZLPJu5rV9/2xQ87gAcPLIBHMKWrWXx3nFRAgZLQWi4dEw4LcOQX34QVTDEfRyzDNC/jq7M7LiM3AnLUwGwRhzHRwohMGML4bLqUY12KyaJFK91cJ9jw93mtagY4KYCWBAPN0RttDDmnAle+An7UDjLEWiEBBok7z2GpTXaHzilBztljzXfyk1WKiVoZUsNKPFx1T1GZX0vhIFonZsPr5zaiY+bivNRvIoZPeeyL8nC76mpWxGxiePprXlxQf3/pD5GGDCLgYadqsKsPsewDLGYdo3Av/6GOrKUmRmYkMcjKjEhquSZZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2kvkwdE4JGHegEbwEHvVJ4IpsAOeDxS2GQB9pdLjSc=;
 b=DLltSfMHKp56IByW8seSTyx5WRg4biNuDZujJaQ7OgQ3damahQ5yw4kKfHC/naiZUpkseZJ97guvMpzjNSmH0QhQ5t3I48sMEE0D4CoRqcHmd1+ybvZmtIoi32kA38W68yeny4y9k2yBlpduV3Ej3oYAbE4r4lhJdqSyvRRCiJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU0PR04MB9660.eurprd04.prod.outlook.com (2603:10a6:10:31b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 09:28:49 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Fri, 27 Sep 2024
 09:28:49 +0000
Message-ID: <c49c7161-f89f-4626-a2cc-1fe701aa97a8@cherry.de>
Date: Fri, 27 Sep 2024 11:28:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] rockchip: rk3399-rockpro64: Hook sysreset gpio to
 enable full reset
To: Paul Kocialkowski <paulk@sys-base.io>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-2-paulk@sys-base.io>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240926183111.1324284-2-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU0PR04MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d7b14d-fdd3-4da1-b5f7-08dcded6cb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1NDM2IzTkc3STczNkNMMlpCMTFsVUVnN1h4bHlocGZPbCtodjBLRkd1WThF?=
 =?utf-8?B?OGJscithc3I5N2RVYzE2a1JTcytSckhITWNPMkNxYWFqL09pRWtXNFV2RUNE?=
 =?utf-8?B?ZmNqWHU4TDM5dmJYL2g4TmcxUmdOdERPeVc2bkNJRE9nYzJBenF0WVIyTUVT?=
 =?utf-8?B?dkhjM2FOUnA2d0R3cnlrSjBFSmtZbWN5VUV2M0JxSGdDVysrK3VCMndjVFdi?=
 =?utf-8?B?ZFBkS0dlWHhHNDYzeUh2eWkxZjBFcjEvL0xoL1ZYMUpVNVFUS2sySjQ3Z1RC?=
 =?utf-8?B?cDRtdTRQTE8ySXJLUFd6K1J0UXluTmcrM0dUenRKU1RRNG40U1NnZSsvM3Ba?=
 =?utf-8?B?NklCQWo4VFphWmZMSlJMaXhNMDhWV1ZuanBSdmZkbTJzQUlsZ1VtV1VUL1U2?=
 =?utf-8?B?cm92cXlFMkx1VFc0UmdBVVo3SFV1OElOdXRpU0x3eTF3RmpKenBQbGlYbS8w?=
 =?utf-8?B?UjZTK2JkOVEyWDVPQTN6djFJK1JsNE9PZVFuK2UyWm12UXA2WWFjQkpwejVv?=
 =?utf-8?B?OHRKWDFScjh2MzlpaXlHNUFSanNPUG5hdjRnNGw1a1dSbUN5akhIbFFSMnd2?=
 =?utf-8?B?Wmp1UXJUR2ZjWHhacHdUVFVNYU1VUGRILzNOZnU3S05LcW9mdno1Q3ZUTzY3?=
 =?utf-8?B?c0s3Q1NZVlc5aUxHbEU0eWFiQ0h1Wll2ckl0bEoyMk85MnhxTGEwdW1HV0Jt?=
 =?utf-8?B?STE1UXl5WGRScGtvNE5FbHNHd0cra1lKUFdHcGlPL1hEWmE1dVFwUDdpREJr?=
 =?utf-8?B?MmNXc3RIR2UrSDcxOVZnWlljd2o1Ti9ZdGJvd25hazRZdlpodmxwSlVkQlUx?=
 =?utf-8?B?RkpUZnE0TEtpK3Fjak5YOUNJUElKRitJV3RLWDhMOFhmK0p2YU9MZmpiaTZr?=
 =?utf-8?B?RUExdTJ5YUZlSmR3dGd2TVk5SFpWaGdlRk5HRWFQcjh6bUVjSk9BTjNiQTNL?=
 =?utf-8?B?ZHk0K09WZ1daLzBlRHFGNm0wV3luMzhzdEdNdjV4YkVtQjV3N05ERkVNVm9V?=
 =?utf-8?B?WEROM2UxK28vMnJEQTQ0c0l5elE1L2JrZ0hRUi9ZSkFQZE1rN0R3bFpvLzd6?=
 =?utf-8?B?UlZFY1ZCTzNZR29lNHFHL2tDMS9ibW5BdlRYUldGb2tOMkEvV2JFZngrek9G?=
 =?utf-8?B?WTZ3RjFmTFM5OHdJeEJubU8rcnZKUU9LK3F2SFJsQVhQcWlCQVRuQWN6UnhB?=
 =?utf-8?B?TnVUNDAvNkNvL3NXcmZuQmhjTE1jTXd3MjF0RjVMQUtzYy9CK2JzWDRNbkFa?=
 =?utf-8?B?dHh3dE80R2VmZnZRdjloM285cHFDWWlINGpaMFlHQW1TeS91TUFNM3FlR0R1?=
 =?utf-8?B?NEJQV0x2NVBDcGxQQ25BenFraG53MEZaOE5PQ1Mzcng4N281R0RYZHBvZ2hz?=
 =?utf-8?B?N0p1Q3VZajIwMlNjelR5Um1XdWRxVlJXcHV3elo3bjNxeTVXWS95WVBHTGVG?=
 =?utf-8?B?U2hBK1BYbzlsV2h5ZHlsNThQOWFTNmJlUjRWN05ydVNVZUR4dmJDWFNsYnIy?=
 =?utf-8?B?SVJaeDcxeXQvR0tCa25iaGlLV0xQTTdjdjZmSGcxWkFaNDNHL3FhRDJUMEpT?=
 =?utf-8?B?Q0ZUeDdxN0VHWTR5SkxkWXluQzBjY21wSFJvVjlMdnBQaVhFdUVzNzBVRnA2?=
 =?utf-8?B?Vm5HOU9PRndkOW5rU0ExMFN2cFhEa0lJYlJPZ05JT3NqUHR5bklXYklWOXV2?=
 =?utf-8?B?a1RnL0VQaE5KTHNRNGVQKzFIMS9nT2VhSW1oMk9wUElVSU1LQ3h4ZnFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRPQXcyeTBEMWpwdEtrSHQxSUl4UG00OGNRbGsrMjVmaU80aVQ1SzlUenpn?=
 =?utf-8?B?N09pNVNocDJIbXJkejdIWXlHamxKbmtJeEpNa05kc3pQZjBZbWRsQTBSRDRU?=
 =?utf-8?B?TzBXVVArT2V3eWFWUXcwZE9TaFBYOEVqZXhKcW90WXMwWEYyVFNlN0MwUzIz?=
 =?utf-8?B?cnBwSGNyNHRYbXRleGhzNWFjby9ncVNzRnkxYWJlNkJKbW9PMGU2M1UrMnlN?=
 =?utf-8?B?Y3NqVVJMVEo0SHZtOWxRZnRaMFRqT1U1TXdGOFMrNEs5VWtmclFwR1hNb2gz?=
 =?utf-8?B?ZCtzUk1wS2FSYVROUzNKYzc2WGQ2bTdjTktOWllVaUcvM0xKTVBQRStiMzFq?=
 =?utf-8?B?ZUl5TE9TLzQvRHBsWGEzNTlvYVNvTmZSeUYzUkx6Ky9vZGF3OTM0WVBFaXhy?=
 =?utf-8?B?QndQa1NJQURNOTRVZVRWWk9PVDNtMVN6dkhrcXYwKzJnQUl4c3RuK0xvS1p2?=
 =?utf-8?B?WHNJak04NXpnRkZyT0IvZmVNeHpWQ0txc3FkVXVDME9OMzZsYTlIY0haRHZl?=
 =?utf-8?B?SUI0WDJJRk9ETDJZWERuV2MvZVdDSDRvTGFwK3IrRVl2Y0ZRUTdRZGdkSUkx?=
 =?utf-8?B?UFFYL0hURk5mR0liZy80WDJmNU4zUXl1VWNzcSs1L3Uwb1FrM1VEdElIaFBu?=
 =?utf-8?B?eHhweVZHaHlGWkxXbmkyU1ZjNndEUGZhWmJEU29RZlhVckJrcjVTcVk3VW8x?=
 =?utf-8?B?Uk10Y0hHVTIrckl4Y09TMmp5REpKK0wreWVpMmRnQTZGMFM5WS9CbkdiRlpx?=
 =?utf-8?B?U09vU3FCT29OU2xMZ2hLNUxrdS8yNHI5QW0zekt0d3RVZTlNLzlmdnpUcmZr?=
 =?utf-8?B?ekhwUW5RZVNDQ3FRMEU0M1NCQVd4TXZDRU1XMndPcWh3bnkzcFpoY3RlNHE4?=
 =?utf-8?B?M2thaG4zRW9EYUJFSHFOQ1lQUlJPdGtaZkk2OElkempsYm1rd0xHYzczSmxy?=
 =?utf-8?B?eWRNK1VHNktxWTZWL2R5RjJDWDNLRERzcWlZb1k0WHV1cmovS08vT2M0Unpq?=
 =?utf-8?B?a2FDbS84Mk1YL0JoR1Exam1CbU9POXRERVlOVlNoYW9oblRHbjRlcUUydlE1?=
 =?utf-8?B?L3ZMU21yblNpeC9raVNhVHBCazdQMUNScmwybWJwTCtWOEFBOEtXWWtGdGx2?=
 =?utf-8?B?dWpGM1lXQTUvRWNpb2gyVEFqWW1HY3YxSHN5dkVtY3V4Mm83N3MvV2Y2N1Vy?=
 =?utf-8?B?dHpPYnAxYVpYQVEzU2xoSG1qVEdnbUFCRzM3bEkvQkZlR1dkMlFaaW1GUDhp?=
 =?utf-8?B?MU1JeUg5NlNCYXlMaTlwb2NDWFM5dEZWbXNXUkdUL2N6cXh0c3JjOVMvUlZj?=
 =?utf-8?B?ZlNHaU9vTXQwcmlmUkxKdXovOXJBZFg0Z25qOWxRWkkyNWlEbUtKbHpTck1o?=
 =?utf-8?B?ajhJVnFVNlNQYUxhbUtheW4wVFgxUlJjYzROYVEvK0dYS0sySWZsZUxSUjlO?=
 =?utf-8?B?WnpqS0EyY05ZODAvUytoOWlSYXFCdHJnOU1hK0ZCeFVENnVXRlM3V3VTL3Bo?=
 =?utf-8?B?STljMFJPTDFrMDNrMFV1OFNZVmpkdEF1TlJRNXcvVVJFOXBFWXp4YU1TN2ND?=
 =?utf-8?B?UkpYUHJHenRjdThkaVJpa0V4YzRISlhENk9EbXhnSjgreHVDQnJXWHFPM1gy?=
 =?utf-8?B?YWZORUlQNGNYQjVzNy8zQzF4KzJ4OVEvcTFVVmpsTUxCd0Nma3dTaTk0MW9Q?=
 =?utf-8?B?Z25lQ3JjZko5cFE1dlZmeGZDZG1EVVYwQUJLeTViVjYrMmhvTWJ1Q2EzM2E3?=
 =?utf-8?B?am41SFBxRmpJQkZPaTdVSkZTZnY3MDRiOW1yajRPbVZtaVZYUk4raHdwRnJJ?=
 =?utf-8?B?dGZ6N1ZKTzl6b1BqNFdqczk5ZzRPejhoWXowZTlzQUhlTFVRT3plQnBmUkpZ?=
 =?utf-8?B?eW9PY1dSaUJLODloMUFqSFdrRkd5dGJ3TFc2aVkyRjlQQ1RiVk1rSmQ2Njdl?=
 =?utf-8?B?VkpXOXIxT2ZIRmRLL3dBcHZHQThqdmpPVzljYzUzRWNqVEZ0VE0yYkw3bUFi?=
 =?utf-8?B?dW5XL2ZvWGl0THNUbUw5bFRWaDhyc05vTGU0U3pvdXVmTnkrVU5LWmJDRUh4?=
 =?utf-8?B?NXpmZEJKdS9ZZjhQV3I3c1puTm55U0xZcDJnVGVvR1ZBaEZOVnJSQTNkeHZC?=
 =?utf-8?B?SStRbDVSTWl2UzBNTW1VWDJld2dvZGVHN0VReVdPeklFdEMvNUFHaS9veDk2?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d7b14d-fdd3-4da1-b5f7-08dcded6cb04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 09:28:49.1043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdc96vI0r6rg8zcn+oNbh43BC4yNMpSmQogDdjM52ew3pPR5k3PLyCnKOD7eGlr/f6j+NyiMf5MKqSnaje0NZ9TJNGp0y314eZb8IFctJm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9660
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

Hi Paul,

On 9/26/24 8:31 PM, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
> 
> The reset mechanism used by Linux to reset the SoC is known to only
> partially reset the logic. A mechanism is implemented in
> rk3399_force_power_on_reset to use a GPIO connected to the PMIC's
> over-temperature (OTP) reset pin, which fully resets all logic.
> 
> Hook the associated GPIO where the function expects it to enable this
> reset mechanism and avoid any possible side-effect of partially-reset
> units.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index 43b67991fe5a..cd84269dab48 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -7,6 +7,10 @@
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
>   / {
> +	config {
> +		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
> +	};
> +

We've been using this on RK3399 Puma for a while already, and a similar 
routing can be observed on both boards, therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
