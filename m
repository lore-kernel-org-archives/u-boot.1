Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F34FD8746
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8F1841FA;
	Tue, 17 Mar 2026 12:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znWSFW9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BDCE84201; Tue, 17 Mar 2026 12:50:44 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8167841BC
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 12:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYQ941KCx4B9a5ndtBi5aAyW9SbGRxfzAqHxn9flnFEL+pFkLSwNIDG9gJacA3DaclVDqI2XAlSL5CQBNz0DvrJFXgOk9KUmUQiREpA7cs6eY46b3F/zI8r0uV4E4qJvXUp/wJLjMeWC4a4N+su0GbQQgwEJhtIL/Xd0LnbJVnEZOZfnuk6Nj1AwqYGNUM4w6RosN0d2UqAmFsjgQrXVpxoOywZaXUUwLMTZPcxWoyXTSmBIdAuB+7Sk5o99tuEhhPtRSYxZkU75SLHhxK8xKrNb+Bi0SkjFXZY0hUquhsgz+XdeC7QLYbC/NPyrNL9RURkuvCciCoizSCtRizkSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ytpwml1aEwFXd5gOkpxUjZfUWnKZ5g7UMOXcKvaUlYA=;
 b=yzNR9GQoYzdmrODUgLguEtGOvmFxEiY5NSQvUj0SXcHqzCdkYVdDHHPmYMu3Weo52e2LmshC/xdvBWnCZoabuOzrPVyTqejR4IA1tSnunwhOJ4p/NIQ+FyeS5lXYhCUuc/dOqvQXtKTfB4lZGh2A51ll6Na461WcyQlU8AUeurhYcc2b41ZLsjkxAFY8ViKqUhoqp9rAI1tAw4zm2drTQZ89TDezS7CK5Awwgk4NXohTsN0haUhUbAakIm2VRYCH7H6pBYNGMkhK/1T/4iF7ICHowPqjgkY7NyRbIoDnpYuDLIkWYEuBEermQSd3uOruWc2yI2toqDT644zIwChscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytpwml1aEwFXd5gOkpxUjZfUWnKZ5g7UMOXcKvaUlYA=;
 b=znWSFW9cQ7GHW3J9Wl7niE4Y/S2Os0ZW0dubS1TpOsSu0P4WXzqMlLfgecIr+KqucdtOkPtUkrOfHNeZKjZj+ov7QKmhX2gVDizTFNcnNbQiJxNGIt1I9OZR2FgdQju/+jOQ33XzMQQiU9yt+OvukMEI3+wspz0ewwlzHwCE6vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:50:38 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:50:38 +0000
Message-ID: <da11224f-1ab6-415b-badf-94da9cf3018a@amd.com>
Date: Tue, 17 Mar 2026 12:50:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] timer: Correct Kconfig entry for XILINX_TIMER
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260317012446.4162630-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260317012446.4162630-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b49e5d-d8ae-4bbf-0af0-08de841b6856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: YFvfPrjxtKW/MR2t8BlZdq0Y9A6NHtPfH60CF7S/bNzdjX0D/lczF4+l8fp12kN+iwiRzdxU03hcse5NQbrEz3kq7Qw1RAfidif+5SvvlnzsI2+d0mS96z4LqUsl1n8Ah7bIKs/9ozO6M/E7nWMrDIkVKqpCYRKrUxFPPS/uPBE6tohX3YIYSxIApxQ42/Qb0ZIj0MQg7zET7Y4Msd3MUVuJhrDbx1kXx/0EQ1AXGQg6h2cP5GC/Mza5FUUFzl4qMERx6F0IirFPSyTyU6NfZuW87Rn+YGVarzKhx7jQAd9/xnDVP+OLCQ3rowJvcJcV9RxJyTMFwVS8lDepnv6+QzZJB1mTdFB1CoRZ0NLkHAC8DWOsGgQb6cNJdj2uEGgFPxRaRJRAuCElErZgfnCBM44uAu6UetkAaf3+MJXFR8XacqYLA0gA095FLabGjz4lJnhXlsipVAFCJ94NXkpZ1q/6WuUf3h06AvPhZGRy+wvzoVnORz4MUkI3usfr3hK2v9ZOXteCc5N6t8kpfBkfEAIZg7HAnD7MoCUpROh3RhP5pebTTUml6yg25q7AUpogtULJOYZwD8cjcm0R/Z6d9uNEj/VM7EkTumrZ7Lgbf5HhCODdZjapN+l0YGAy/Y5sve8w385kTvpFKvprWNABx+2race/Rt9M4z/GB3Pcebz837zhInoQZKM16SDl7s/iPYxWU4sxSUqwRi3evmDalEVTJSkGk4my4bDX+ogJTrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pkUUZIcVFMalZVNVdnNjhNN3p4NncrYjJXcHhITkRJaW1TVkI2RTVrQ2NF?=
 =?utf-8?B?ekZRWUM5cFhvbFJ4c2hoY1RBbWlKMW5PMjlDa3prY2NrUFJ4TnVqQTFkdGpJ?=
 =?utf-8?B?djdNNWw5R2dNbXRFSE5IbTlhTlhOaEtMTGtyK2FXU0NndmVHZXRVekZUNDVV?=
 =?utf-8?B?ZXBKSzBMUnNpbjZETjEySXllRFNKcFdlbFVYU2d1dmx6ODhGYTc1L1hIL2JT?=
 =?utf-8?B?UnprNnJjOUhUaDJ5NVBVUVZTQmR1eXpzL0IvV3E1MHdkbmRac0dNZk5CbDZ4?=
 =?utf-8?B?Sm1VcC9rYU53VEVTQWMyWW1TN1hWUHpwYzh0WStkcU9RZmRNZlpiMDVXSm9n?=
 =?utf-8?B?bFpJYnJieUxiZzNJMjQ2Q0NwcHZwQ3FXaElRbzRhVGViaWRKajhZY1MzOGVt?=
 =?utf-8?B?Vm4raGtleTJuWHk3N3ZMNVNrUnEwWTVkUVZZclBNeUJxT3ZRZ0xvLzdHUm44?=
 =?utf-8?B?MDNMc0MvZFQ4eXFGdkNDOHBETWw1dmlzNm94WkRHSi8ybldKdVMvMHdjL1hW?=
 =?utf-8?B?VG9tQ0UvQUZiZ3ViMTlMY0s0eUQvNUpjdGQ5by9LTjB6ZE5tcmNWU0ZCTktX?=
 =?utf-8?B?by9Mdk8vdWw1cnA1K1lHZHdOSHg0TlR4dkdIb1NRQnpZclJYa2I2QUkzTlcy?=
 =?utf-8?B?ME9iaFRRbWtoZHJHamhGOGZrdllUR2t6QVJsN045MnJ6Tnc2dXZHM241MGUr?=
 =?utf-8?B?NmluN1Rjazk4amQvNVAzalJVYkRzS0plRlRuQnE5ZUZkQWVzYzdPY1ptaGdo?=
 =?utf-8?B?d2tVeVN1djl2Z0ljR1VXK1VleEtWdWJ2dzloUE4zTksveEk0OXdSckF2SkJp?=
 =?utf-8?B?ZTBVS2E3RVdaOGZJVmNnNE9zbzZMT0dQcElUZnZzZ0RkRWZuTW81dHlDK0E3?=
 =?utf-8?B?bElUQVNXRTUvdUQvSmxBbmdxUldRYTZxWSttK3B2aTU3RmxJRyt5TFlUVjQ4?=
 =?utf-8?B?c0tySmdacmxiNnRZNTVTY0dGUUsyb3BPYnhMMXIwaW1qWFdYOGd0OFlIMks0?=
 =?utf-8?B?aXF2U2xxcDRWc3lTYXZkM0c3Sk0wZXBUc1FjZG1xaTZ5L1dtYUZyVndiS3lX?=
 =?utf-8?B?YnR6WU94R2RjVG41VVpDYjZ4M3VJL2Mwc2x5R2dxWXowcHEyakg0WkdNQ2hh?=
 =?utf-8?B?RjJmY1Z3bVBYSTZyYVNMNXVoRU11RWxza1Z0RTdHNDlEclpZb29lWlZOanVI?=
 =?utf-8?B?VXhwVGhjMWkwZnRQV1ZuQ3Evak1yWEZsWTBRc1h5blA0aVdvck92MEhVWGFV?=
 =?utf-8?B?YkFJMlF3aXp0MCs0ZW52cER2bWs4UVBIWVQvTzZwamMvUzN0b3Rta1A0bzZ5?=
 =?utf-8?B?VGZhRmlGbjUvbkt5MlBLNkRUWVdldFFHOE9Ic3Jaek90L25QNUxqcUgxQkVi?=
 =?utf-8?B?eFNMYlN6cTRaN2NqSEdNek5xV0ZDMEkrdXhJZ29KODk4VjROL3pVZDlHek9T?=
 =?utf-8?B?MkUyREs5UjlLVGphYzNIM1pBMVhNaXFqTXhOMzVvZ0VjajJxRmZza1ZFK3hm?=
 =?utf-8?B?eTV4OExxajNoM0ZvdmU3OGdkblROaU4xeVQzQzQyT1A3b0RCdWlvRTNZWmNX?=
 =?utf-8?B?dEJ3WGNHb24wNDgxNERuSXlTMVNQZGg1ME1lZFNtQnJMUDFibG1XUzJlbTU5?=
 =?utf-8?B?V2c1dVlpeDBrcWpkUnBpL2kzV3JNMXJwLzJvZzJ1bDhROHRBNnFXNHFkVk9j?=
 =?utf-8?B?TmNOT2F6NHNZZ1ZZcDlVaVpUaWZGb0FtV1dITFk2NnduaGsvbVlhMkhBMjly?=
 =?utf-8?B?S0wvUjZib0lQejNjcm1aaDUyUzhvcTVBL2szMHBIVjc1dVFPQkFDSnIxQ01s?=
 =?utf-8?B?dGg4OGIxNlJOUWw0S21aR1AzTWMraHFTVFhKMGUvVWxxR3JhWTFobWVHZGxL?=
 =?utf-8?B?SzRVVHpLOEVsR2tZMFJETUZyYU5qK3N0b05pUFFJODRIK3cweElCcjRzTElh?=
 =?utf-8?B?d3ZTajg4YUh0ZlJmS0cyN3k4VU9MeXJYU2FXTzFmK0YxK3ZMY1NCMWVVQlMw?=
 =?utf-8?B?b0JhS1lXdGlkNm1jcDcwMC9WVy83K1p3V2w1bldxWHYyMVF1Q3ltdE5FT1Bx?=
 =?utf-8?B?bXcrdnZreUxtNCtXdTdRNWVnQW85L2dnOTRrNXcvMnV5N0h3Ly9OVktRVzNI?=
 =?utf-8?B?RC9BOG5Ha3UzWW5rdlVPbmtQU0UvNk5KNytTNHVkYTdNVlRZbXhVUzFUWWNr?=
 =?utf-8?B?VXB4bVZxSmNaZE03MnY1eWtTRlVPVnF3UEozN1g2VWRFUXdNdlVZNE1TVnVD?=
 =?utf-8?B?Wk1lTEdHS1kxMDQ2R2lDNWdPbVl2QTJtYTBDV0NQalcvMkI1bEkyTkZCajRQ?=
 =?utf-8?B?ZkpGQ0VrODFoZFdRWjVtdkVIVXlkUTRyQU80MnFjU1hYNjBKVzZYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b49e5d-d8ae-4bbf-0af0-08de841b6856
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:50:38.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xVOEYPZnEOl5sJPGY70w/6X9bPwY+0UAS2yJqX3Oxn22HybwoT9ur51Pxqdp769
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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



On 3/17/26 02:24, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for XILINX_TIMER. This symbol is a case where we have one that covers
> both main U-Boot and SPL. In this case, we need to select SPL_REGMAP not
> when SPL is enabled but rather when SPL_TIMER is enabled (and in turn,
> SPL_DM).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   drivers/timer/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index 24c141c60ae9..500a25638a96 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -328,7 +328,7 @@ config XILINX_TIMER
>   	bool "Xilinx timer support"
>   	depends on TIMER
>   	select REGMAP
> -	select SPL_REGMAP if SPL
> +	select SPL_REGMAP if SPL_TIMER
>   	help
>   	  Select this to enable support for the timer found on
>   	  any Xilinx boards (axi timer).

Applied.
M
