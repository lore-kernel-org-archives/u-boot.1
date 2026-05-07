Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8F8CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A09A846A1;
	Thu,  7 May 2026 18:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N6o4SCFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA4C846B1; Thu,  7 May 2026 18:17:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E726684099
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihgw6VTDuUb3QyA+37yIosRLyJV7drASq0vUwxrOPqsXeZLDAVzPpstaQgsQQxL/x+z8ZTpIxZmbX/IMtY0EdLUE+LpAkqqrx1ETf3UwVP09BXLF+cEtIR+OxCfBc2PmRXMMMWjBR9rTBUNi5WLX42/DlTuPy/NSRmsf5KS5v8CJ1fFqHxa1tZS4ZULdEujxhKqE+97A4kQibeiOMajIqOZioNi9E/9DJ+7NSJb86p582RyP5FlfSU5aV/l2xfrQ9ccIgREnW5Eby/vE6L6z7h61fjgT0xtZ3ckJfT/1USSzqz4HoIpLKijBLHbcqtSO9lMjSuwQY2nc/z76xdXizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWB4yjN5SHY0Oj6h4Ji5m7SH35CvoXadXcVjNckl8xY=;
 b=yrdWsndBqxWTlOxI2Tp2ltEPpTE5yuQ25ckzAjL/neI0px1nEK6m12dmVzLzypgBomzzhK42bMjaQz1FXs9I1/xno+MJ2ksKlNifjIxa74lTzigSBNUNp3fe/VgeS+BSKPwvasrns/+rHMUljHWjrT+5U7kIhrwG4WjB6gkhOWtY3dawtL4M+CdZfSReHrWl2S9XS6+PhVKt1lsYvtYN0/Q9VfWv0jk+dwCJz/4WlvASJOArBe4AaTdGPPlJ3nuvwc68BWP8ru4iFy828Lhi9TVpn+ZvzHL0hWyfG4gZqJ2RCTLCggDm/W+Z/BL7TrNnP2FGmOcIz66jXWrUDv/vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWB4yjN5SHY0Oj6h4Ji5m7SH35CvoXadXcVjNckl8xY=;
 b=N6o4SCFngw/MOqGBrChNdA4lPobmXL6R4VPSz5XrtHnceWIFUhWM0sZPWsWE3mk+3D8iBhDYJOcX5dIzezYI0LdhVRXugl32zI5HmgzwLRruSvb56Mw7HQrzZeX1LLxICt/eOKADmORUEhCZswXMwh1Ihjf8PEjRdg5Z0Gi5Mao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AMDPR04MB11620.eurprd04.prod.outlook.com (2603:10a6:20b:717::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 16:17:36 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:17:36 +0000
Message-ID: <bcef111f-56a8-4935-b234-0e9558cf13e6@cherry.de>
Date: Thu, 7 May 2026 18:17:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] boot: fit: enable FIT image post-processing in SPL
To: Francesco Valla <francesco@valla.it>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Dhruva Gole <d-gole@ti.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, Michael Walle <mwalle@kernel.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-3-dde63beeaab1@valla.it>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260428-spl_fit_full-v1-3-dde63beeaab1@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AMDPR04MB11620:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e5b309-718c-4692-ff56-08deac542704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ru+eulb95lr3qbsdZw5me8a8YxZayo6RYsVDCbvn8/5EPfEchMgv6rhTCtDdmRU1jZckIUH2ot/+Kn1aM1m/VTzWANaoNbUJuPNkuzHtlDIHCP+i/nBiO7Z4+30KvYXOZOapnr6CZATscmtmmQ3vKrB/xjTtMcCP+dkmEA5lJHKqzfMK97pwS7JtChp6iw/nnfB8cyq1IAiS8D/0VQuhPS7Oz/FHatV65S6AJjgcZGHyAjBeWC9Q780Wj4V2b8dMpatwsWTG0FgOGuYGgQJsMTiVF37iyLw+OIzqjkXX1WIBwUKdWn6tX2qKCnKz+9Dsu+F0N4dYlZG+PswPf3MAK0fFMbOUcX1RwfY9sTHrmB4DSTXAFz4PiWJTl4g8/CKdmZl4VWCaertIo2EHPmxtFFxL4vkM4DORtXV12Rvi8sQTiLaBhTpjr9zaOxDu469DnIjrK7xCIgZbWD0K6jC7VDkWAvTOzgfa179jBP2kndJYIzSFDBvE1QYnO47qRamD7tTME+nhPZCRt9amjSuy27g5aO3sUB3cF3lZ/BcU3aKuPaN2+PSPQdsLURuWuSqJXjtnjGfiPwuR+Lk996LA1/1ZOTNoW83vqfS1sL4exeA7UJGYsF2FQzObdQ7gtwZSoEwIspFIooUv6ugVE+WeUNHWXKp0XmHT+ExqcLS8VBUAeEGrdf+kTOLJfL+prf9n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9RS1BBdlZBYnhraVR2NENiaG5OSFRidGRyMDc3Y1haVXdmSDREWnB2RzBh?=
 =?utf-8?B?MEVnUFVnUUdCWGxBdkc3a0hIUVZ4Mld6U2piejlsZVB4dXA1VXJNaGRIY0p3?=
 =?utf-8?B?aUs0dTcvclRBSklVQm9UNzRuUFhNMjFLSlovVGxoUGUzTkc2RlNCYkloQVRv?=
 =?utf-8?B?UTZNQ21NSkt0U1ZUdlNzQzZuQkFremp2cEZwdm83aTJ3emtVMWo4WEc4dFVC?=
 =?utf-8?B?OG9MbkNiSW93SmRwZWc1clhHRGV6RkdDaFAyM3hvektnMVpwZ3BWZTU3a1ll?=
 =?utf-8?B?dUpBbmE4UjdmMjZ0WVlSNlZXamNaTHFDdW5EY0dhMU0wb3BxTUxQZy9UcUJC?=
 =?utf-8?B?cWlxRmpZdXdiZFJncXFSSFZ6WVRHTXZ6cFMvWURIakdaWmRKZitvbDNUOXpa?=
 =?utf-8?B?am9YU1ZnRElEajdvdkV5ZHdPcDcyVzVMTThYZDk1R09wS3Jqam5GMFVIMkxw?=
 =?utf-8?B?U0lWSVlFOWs3eTEyWUpyMStOZXplMzdJOVZOSE1hU29rdjB0cVpiR1luYW0w?=
 =?utf-8?B?MFIvUVVZUE5QMklhc0NDei8rSHRYNE5DbmtXcVdoRjloTkZhVUkrZndsMVky?=
 =?utf-8?B?K2ZDeXdtekNoaTJkbGd5ZERxVXNWNGNZbWJnYkFFN0UrR0pyK01ndmlmQXBY?=
 =?utf-8?B?NjZ1SGZ2RTc4YTRobVM1Mnc5MDZZK0dlTVlqbUJ0eTBpMjV4UDdGUTVsTVdh?=
 =?utf-8?B?ZnhGWlZQSTIzV3FQTXBGaHoxeW9aclJabXhSdi9Va1RLbmJjcmthUExXN1BV?=
 =?utf-8?B?aTcwL0xZOUFLVFNBSklMQUxmTTNoSFBFaWZKR0ZMbW5QeFlKbFFITFJ5RU1o?=
 =?utf-8?B?OWZQUm94UHdHcjdXM09QYzNZcmVUbVhrb0czNVVDalBsbWhiUnZVUkNxdXg4?=
 =?utf-8?B?eHFtajMreE5LS2pOc2plWnlqTjkrUlNBM3VpY3c2R2ZQdnowTWdRUlpiSGxV?=
 =?utf-8?B?dXNkMDE0QXg0YWpDVS9NRTFxdWhqOGpNTXZhZ2tobmduRXBhVVRvVmdYSG4w?=
 =?utf-8?B?RDJHcjYvZG15SFBvZUxtZGFzVDR6S1BkcENxcC9PcTRqNVNaMmUxUUJ3TjFY?=
 =?utf-8?B?RVREV2ZRU1haeVZyZm5kM1JaZGozQThzWnFUZEZCeWpUUDV3MThSd0RBYS8x?=
 =?utf-8?B?TmVSZjFqTC93aGN4VEkvbXJBVTZvVC9GdC9TbHJJVlI0T2ZmOENtNXYvSm14?=
 =?utf-8?B?S1BkTTFhVVhQMkt0anRVV2pna3Rld1ZaVlBVQlVnbnZPMXZxUmZWblI3TDIz?=
 =?utf-8?B?S2g2S2svZ1EwVWk5ZG9WbExmWXREbDRhTGdJNWJYczJDNG9FRHZEeEhEcE81?=
 =?utf-8?B?UVIzeXVFODI0a2RyZ3VwME1CMDQ4NGxUWlJnbGF1eVowZWJBOWlEcVVBZ2xM?=
 =?utf-8?B?dXE0aGV6ZXN1ZjhJZDBCSW1HVm1YdFl3YzZkTEg2TU8rY0pDZFp5NloxeUh5?=
 =?utf-8?B?VExDWVNwbmN6clVpdkhmd3dlK0JUZHFobnVJR3BENGpkc05rUWR1Qnl1anl3?=
 =?utf-8?B?cWQzUEo0UnRnVm5xNmEvRitaeXhwRmp4SUttaUcxVmREOHkvSXdTekZ5ODVO?=
 =?utf-8?B?UGZrQ0x1KzUzaTVKVy9sUWZsOUcvNzQrMTJiWFBxS2xiTkJNSXVTNjJ3eFMy?=
 =?utf-8?B?dVVTYnBpdlE1UE5zODZDMHJGdUZxTEpyNEJaZi9rQVVqbzJtYlVSQkE3S1ly?=
 =?utf-8?B?c0JOaDJhOE15ajZCeFhKTUpJUGNZYzhFZ1J5cjhwSWsrbGJNNmY1Zzg3Mzgr?=
 =?utf-8?B?RzFQQmIzRldkYnRDQ3lNRmxNMzRWTmdMMEtUR05oU0JhMytnWXBBNWVuWHpw?=
 =?utf-8?B?a2tHOVVpN0N1cFluRWRIaFVYWFVwblZxYm1POFRHOGR6UEIxMUYyQVBKNHh1?=
 =?utf-8?B?VkNua3dzVm9CYklZZjdzTncwQkZHbEN0MEFmejZpdDVaVjhFaGxoOGo3bnBI?=
 =?utf-8?B?REdMc1lFcnVBeVN2TkpXeU14WVExK1UrTzM1Y0RPM3EvZXVSZFdWUjZZOEVO?=
 =?utf-8?B?akI2SllNVmZnZHNpbGVUaWZ4blp1VmJ0NU5JVEZpaUcyckMxcnFzZXBLWHpS?=
 =?utf-8?B?TnJrR2tMSDk5QnB3a1BmZzgvYlo1NEcvRW5HamZ3NFJaTW5Ea3NSa0ZkcUlh?=
 =?utf-8?B?cys4VE1uL2hFNlN4bzVZc2Zpd1NoUWIwMTFqcmZBN201VDFoRjNyRS9QVFVR?=
 =?utf-8?B?Mm1mRkdUVzd1WnFTd0dLaDArdi9URDJEM25DWEo0MkNXbmZPTVhrMEVIVnZP?=
 =?utf-8?B?UzhUVmNFT2R1QkVpM0FYZlNUM2crQUUrc3VuU2JlSGU0bEY5M2l3VUppczlW?=
 =?utf-8?B?Sy9GdjJGcUpadkxXeThLdUlKdkowNU1TZURsNFU2dzRxVkFZSDhtUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e5b309-718c-4692-ff56-08deac542704
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:17:36.6447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOAwlFs3V2/ZvhJGTUBO4RrNgeBtwSRGAXvCxOIJPH5DydPgIiSpfGRXOQxuN+3JMvC0QnCuKjohwyRrgvgRinzAhqaA7k5FGatTYOb4tQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11620
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

Hi Francesco,

On 4/28/26 10:24 PM, Francesco Valla wrote:
> Since CONFIG_SPL_FIT_IMAGE_POST_PROCESS is a valid configuration, allow
> it to be used when using the "full" FIT loading logic in SPL.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   boot/image-fit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index f3ddee940dbd..347304956a99 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2243,7 +2243,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>   	}
>   
>   	/* perform any post-processing on the image data */
> -	if (!tools_build() && IS_ENABLED(CONFIG_FIT_IMAGE_POST_PROCESS))
> +	if (!tools_build() && CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))

I think this can be reduced to

if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))

as tools_build() is true when building for the host (tools), and 
CONFIG_IS_ENABLED prepends CONFIG_TOOLS_ when building for the host 
(tools) and we don't have a TOOLS_FIT_IMAGE_POST_PROCESS.

Cheers,
Quentin
