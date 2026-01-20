Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F620CA5FD1
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 17:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58FB839DF;
	Tue, 20 Jan 2026 18:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YdWypsmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A0083A2B; Tue, 20 Jan 2026 18:56:15 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5CDD8063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 18:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsBslInRGpWL2p7vlKwomZKqD/Hwj9y5csUkdb4UxbINGXE9vPkZmBFTNBSYUsHyvnPIDAg8Ltph44D+2GC+DKcFZVyRCzGu0YpVlikV9SVhd6T8BwGnC7UllTmSQH4d+6lJOWHWXEqp2L640HfZNHjzygAguuDuhCY8XyrOM9/nxq8kn8h/bRJnH49FPKsbN1juE4lIizeQ1Rv+ri/TuMzl1HICpm3TmubJZOVyhMOAZAhyUusmFMNjfopq41+gFSwD/tr/1juZD7SEztlhnHWskm+S9KrfYBTYWSAieynN4BDfU6jFf70BVoR6qdH1eECu8q//8lHGRSbKz1xqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qNdFDcwlgEwPL+KuxjVt9cwBmaX38wFJ67VnaOLd24=;
 b=e4e5wH6ynDixBlv7qHamXMijX/qaOMgUTuy9EuWnK0p+AgIViilLCupgE2sCTeXD/a25qjg/KQHowOYFXBVuLIXAnikp7LS+uT1c9HFjZq2gCTQjMDrgjjiVWavoirhkFcC/ufIu8Z9/2qm5qnfqV5EtW764myM1PyPnepeBDULEOlI0ihW3Ko9h0s6pkQn/1aX7nOnl/GWkRXdh4jYiHvblEcZNNgk9b6/WK+GFAplo5pCm/hJGmumFzsLlaCqhWfDEb0RDF4dITezHOrFlkemzO7qbQ48Db7qQfOruwY+G2UBl5JL6Ch8JUOabYGxs4DiEZyLd8yYuoMMsDWzi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qNdFDcwlgEwPL+KuxjVt9cwBmaX38wFJ67VnaOLd24=;
 b=YdWypsmhg/1w0AM9rN1BzdTUkQwd/euVg+mgG9bzvZu2aDAtoUl0v4WU9t6DF/U3qtGWZWrK+dwJm+a27OWW1WmTDE9z9P36m/uysbDLuALalQDh1NOIfKyLZJCMBdDAhX4/J3bR0kevvGM2D2bZuyMFE2L1GuaWrWbVkP25yE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:56:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:55:59 +0000
Message-ID: <051b12b8-cd2a-418a-bea1-d08ed8b61516@cherry.de>
Date: Tue, 20 Jan 2026 18:55:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: mem: add function for getting ram size for use in
 scripts
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
References: <20260118105021.19760-1-linux@fw-web.de>
 <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
 <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
 <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
 <BC982812-6A96-4B47-A7CB-3F2DE868CCEC@public-files.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BC982812-6A96-4B47-A7CB-3F2DE868CCEC@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: c90bf142-aaf0-4d0c-ddc5-08de584d2b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUZzVHR0UURjbnFtRUVVeDlUMXJ2UjBhU29lUzM3LzBxcE1oWmdWRTYzZ3JC?=
 =?utf-8?B?L1ZrUGJ0QWZFSW5LajV3M1g3ak5uTEpBTnBCTDNaV1FiVFI5YjVVN2t2VTdC?=
 =?utf-8?B?aXB3bWZBQVc3TnFHUTRTQkpzUW1HakhZZUhIaU1JS2dMTzhBRzZQbktaVity?=
 =?utf-8?B?SmNMZEdvYktjSUNDM2c3akJjWjUrVEUxVUJwVENwZ1Zja1dkaStoVWE4N0px?=
 =?utf-8?B?M3lvTVdsSkg2THJqdmF6U0NVR3lRSW0rUDZ3aituMXRIbGcwZjVxdXlrOXV2?=
 =?utf-8?B?UTQ1cGJ6ejhxRTRCUENxOEpMYXZDd2VOOGJVQkhETFN4cHpEazQyUnNVTzBj?=
 =?utf-8?B?Z3pNc0RZajZMMitpWWwyd2VFalRUWDl5dGhsZEZyZTRHVFppcC8rbUFDQUNh?=
 =?utf-8?B?MStyOCtOYzBPckpwRUwvUndMWldEVmFTOHhJNjBmdkNabW5UK1RENWZ0SHgy?=
 =?utf-8?B?enpvZ2hHSU5QaTljcXlnWG5CZDA1UEpud003ZG5UT3Y2aEpzWXczTjdnd0ZF?=
 =?utf-8?B?UVlHY0JndXJvb1JpU2FWMXM5eWR2R1d0RUpIczNSeTdTVElKWEM0ZFZBdEx4?=
 =?utf-8?B?dTVNMEdKbUJ1aVorZWNlRWxVTDcrU05tTFUvSlc3dkxCZko0dXJDY25qRk96?=
 =?utf-8?B?VmhtbjZMV3pRZVdmZzlBZDlySFJiVC9qeWdrMmY1cWNDTW9ZVGR2YWRxbFU0?=
 =?utf-8?B?VHNVRXNjaUFHRXdUMlVZaFBRckJ5bi8zd0RJVUdSOUk0NFpOWjJQdnQ1WVFW?=
 =?utf-8?B?S3hhaWs1ZU9NRy81UUdjbXhnNTZjZ1lPeDVNYVBqRktvSzlOZ3cwQWNSdXdC?=
 =?utf-8?B?SWFMVnY2RmxkY2tLdHZFekoydDVQbitCci9uRWk0ZVZKRzEwL3pDYnNzYlVV?=
 =?utf-8?B?V205dUxyNVNZYXkwSWhLeVFYQzViZWNFYWU2aitKQ3krQW5PZ2tNcTRiY05Y?=
 =?utf-8?B?TVZoUTdEeThYYkxmY3d3T2RLVFpBS0JWbVd1M0w1ZkN4OWFaZzFmWVFrVTlk?=
 =?utf-8?B?Z3pxdzBkZ2NFTWhnMWRrSlBwdHd0NGlUZUdYdUxRelNMYUU0YXpqY21vWDdk?=
 =?utf-8?B?T3ZmSmNNbFNhcXFWYjNKSXJkUGZmcTdKUlI2M2VkTlZGVmgzMkljcDc2ZWpT?=
 =?utf-8?B?Z3hyVDk1a2xGSUxPOHZ3eUJ4d1BrcXZGWlpDNTd4RzI0bklUY21MeUVxbWpL?=
 =?utf-8?B?dXVFenVvODlvK1BkUkhmUitSNlAvcTJLWk1EWDZ2VFZGbjUrbU01dncrOEsv?=
 =?utf-8?B?ZFhYcFllQVgvT0dZay9BakRhUXVIcElJZDVXZG5MTkNobmxQYitlMGlOTms5?=
 =?utf-8?B?dG5ESmZFbFp6clpwQ3BpajdBU0c3NGZBVzVCa08wS09yaVZoN1BzQzdUZUNk?=
 =?utf-8?B?bXFTVGY5MXdRQXpzNWNLRzRmWEVwU1YxRVJUa3pGb053WXNWUGFJUk91dHV4?=
 =?utf-8?B?TUg0em1qT3R5Vzl0TUtFSnBQR0pZUDVMLzZLZzNQY0FkTDE3WFA5d3EyMk5V?=
 =?utf-8?B?T0xiWmg4VnNFV0ZRczB3RmQ0SlBmYWZ5U0dCOWhQTytRT3d2WW5QNnFNNEpj?=
 =?utf-8?B?ZjBnbkJEakIzbnIwbDlraHgvaHl0VmxCWi9Jd2I1clQyNDFMbTd0WUcwZDFR?=
 =?utf-8?B?b1FVVUxFVkdRQ0RJRkhwRVNMMUsxallvdzcrUnZ5VXI1R1hPZHFYTjI2SEdD?=
 =?utf-8?B?UWRhSFdyUll4enhJeXRSaG0xaDFhWk1YMmd5VXBQSkNGcDJpclByT2NtL3oy?=
 =?utf-8?B?b3BZR3RZbmZxWU5CSzdRaFczK3ZLdnNmeGh1WTFORCsvTFlaT1B6bkRnWVZn?=
 =?utf-8?B?S08wMjNwR2lyM285Y2xjaVp1VUpLZ0RYYXdwUHlTWXhHeTFFMWl0WUx2b1pN?=
 =?utf-8?B?R1dTYmROcjRlNDN0V0hERWNERnFMOE9GOEkzOUtvTXl6TU4xWlZsaXo5aVZD?=
 =?utf-8?B?Mm9Lb3YrekUyZEpYK2t1MzV2RDllZUVYWW9rOUxXdUFUL0JnRnpLcS9tNDN3?=
 =?utf-8?B?WlNpUG02ZlJDbllLRFExYlVNNUUvRUFtdjZkYjlNREhMdi9rL3p3MmYvdzM0?=
 =?utf-8?Q?TcWreo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJleWJlTE9YRkloVHYwbWpodG9LYUlkZitLWHNoNlM0NGp3OGhEWk1tRGVs?=
 =?utf-8?B?K1FIRWZDNEllUUJ3dSs2ZU5CNkNSQjVDaTZYZSs4RjVDNnAraVdzcGZLbGhI?=
 =?utf-8?B?UmhDckdxblFsY3JnUkQ0VkhYWVF2YkpybHlSZ0dKUUlSS0RlZ2MwOGRCcE9r?=
 =?utf-8?B?M0hjQmN6THZDaFRQL2ErcEF2YTdIaVpUYjY0bHYwRVFrTlNkd01FWVNncXlo?=
 =?utf-8?B?dXpRY1lXTENrRUFZVFp0cVJHMm1tYUpRekhxZGFQbmFxTk5FazlXaklJeHBP?=
 =?utf-8?B?bTIvaDNVbjF2TXN1aUhsN1NGdVl0MTljMm45bHIvMDFSYzQraU8vS3ZVZVg1?=
 =?utf-8?B?ZVFmLy9QM2dYWk1RMUpXdHd2RGhFN2gvUm5jeEd2OWZEd1ZxVjkzUmY1b2tq?=
 =?utf-8?B?UFNEWDg3NGFPZHoyQVRpaWJybi8wU3ZQSDFCVzJKQlpCZEVMWUpwL0M2em1i?=
 =?utf-8?B?TXI5SjA4VnY4VDBQTjhyRnZPNDFkdlBHV0VXdWZOSWtlZCtZdjZtaFZxSVpR?=
 =?utf-8?B?TG9GR0pwa0FNVVVxdEIrb2dDWTk3dTJJVmprRkRDamltUjdKRzU0TGxRZkF1?=
 =?utf-8?B?WnBDa1o0aXMrK3NEclM5Z1d6cmhQRnR4azRNQlQ4Z2FhaFZKcW9pUHVTbjFS?=
 =?utf-8?B?TThXZUdKVzdVVk9NUkRrSzhEeittNGVaUi9hQWhabXhHWVE0NUFNRW9zUEpL?=
 =?utf-8?B?U3BGTEFqdHFJTW91VmhiSmo5QmJUWFVMdUUyNnJLMG5ZME4vWUhFSTdXM3BG?=
 =?utf-8?B?WmdiOVZLUE9OMXBJN2lXNW4rVmNranB0d3R6Z2QrSGd6OGNkOEdJZGRibmhW?=
 =?utf-8?B?VEZaeG1rNkpuT3dpZG1jTDhoQzFoeE5rd3VCd05UK050S3lYOVQ4TG5ncVVa?=
 =?utf-8?B?bWZmSHc4UlBQV3hFZ040VzN0ejJFT0NRZTRsWDFBV0dJelFKTVV1eW8yVVkx?=
 =?utf-8?B?N3lGOGcyVjZqSi8zMUErVi9xOGdQcVY5K1FmbVZvOU9WM3BWMHprSCs1eGpM?=
 =?utf-8?B?QS9oRWtQT3U1QXhoL1VLNTRwQTR2T0tkUWhTTHY4Qmo4dkNiWVVGYjZmVzdq?=
 =?utf-8?B?ZE1vVmV3bjZpMWVXd0pzY0pSb0lPWU5PTXRHSGRlRkkyUHByb3RhTGRPd2cy?=
 =?utf-8?B?YmVMNTU0N0R2blBvaXdlMjE3ZktiTGVSR25jNU0wL2l4N2lGMCtNdlZmeVNI?=
 =?utf-8?B?b3doOE9GejFmejhmZE9aS0d6c21Za3JnU2YyNFFjM3M2NCtYUXI4b05ZZGdi?=
 =?utf-8?B?dVJQS2NCKzF6ZzQyQnNUdUlqK053MWlla2UxVGs4czlhcUtiOURnR3pwakh3?=
 =?utf-8?B?N2RjNjVRZjAvb3o4M1YvZm5wa0NicjI2ZFRUM0VnRFByRVZDTk9zcFBnMCtj?=
 =?utf-8?B?RzlZeGV2YlQ1Rmw4NCs3Q3Z4SFd0UUUvTXZZaGNDdXg4NTJOQUFTazY1bnFs?=
 =?utf-8?B?MmVsQnFsMmJ5dTUzUW5sV2M3NGF5ODlJM1BubEdLc3NQeE50VFZ3R09BbnJM?=
 =?utf-8?B?TnlmcSsrMVdVbk9OSkExOW5RZDV4Q29TaGwySmZ5OWREOUtKT2QyTG9DSzNj?=
 =?utf-8?B?WXUrRkpKWjZxS24yV3R2SWNpVlZFUHhVK25xMGtDN1VhSUFRVzBqb01hYzNW?=
 =?utf-8?B?N2ZuVzZpOVNuRjgybkluRjZPdThNSG5vNGJzY3hNa1hnOGJtM2NzdE82SjJD?=
 =?utf-8?B?VHBuN21CQTRJY3JwNTNIMUd6djg3ZDdGREJEcDltcUJRdUFKaGJwR3l4bzg1?=
 =?utf-8?B?Nk1lZEl1QUw5UUtiUCtRbDhzUVJFQUF0NWhlTEp2Qm5lelhYdGVIQ1ExQk04?=
 =?utf-8?B?MVlmK2lYUWxlWGRwaGRvcE5KSzRSSkdWeVJzV2hGTnM2NENZMzBwU2VSczUr?=
 =?utf-8?B?UGNjVXpJZUxkRytlbWlOTllJVTNXZzdqQ3JQaW5KNW5PcndxRDZxQkJLaUJU?=
 =?utf-8?B?bCtkN21PbGxNT0J3VWNaU0paV0p6eHgyRmtPUWE5Zll6bUNWeE1TakhnUVFw?=
 =?utf-8?B?L3VaNXBuVkx4SG1QN0ppQTl6aXY1VU9Kb0UyT0EwV0ZON2RYU29taGduNWFH?=
 =?utf-8?B?ZVpvdUNRd2d5ZmZyejgzUkk4cFJWeWVHbEJHUGlZWGhzQ0gxTDVDbE4rUjlF?=
 =?utf-8?B?ZWRXa3JBZTRUalVlYm5LR2xjMC94eEZ4VmFhaTIyRk4yL29GUEJrS2poMWli?=
 =?utf-8?B?Z2NpRTdsVFVtMTB3M0szRmplVjVqVG9ndTN2cUNmN1o1Rkd4NnZJWTdNOXVs?=
 =?utf-8?B?dzl0Q0NCeU83bkdNVzdSUVIraHl3ekUyQkt5Q0R5T3lWbTA3NXdQV2ZaYlE2?=
 =?utf-8?B?NFAxeTFOYk94NGwvaGlsR1NObk9YWmo5ZEJyaGI4RVluU3o5VE14TDZ5YlVM?=
 =?utf-8?Q?dz44QJSOvrLeOQax22Hrl8YM5vw+6U3gHwqFk?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c90bf142-aaf0-4d0c-ddc5-08de584d2b17
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:55:59.2728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF3obzKQpga8jIjRU08csR76SyuygqOHxxOzpDZiFJYrFi7Wrh/gGLaGVmm5YLpQQoYlWN480d9eJvidYnCGuvWcWwKhrN1wQT++0UNT4IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
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

Hi Frank,

On 1/20/26 5:09 PM, Frank Wunderlich wrote:
> Hi Quentin,
> 
> Am 20. Januar 2026 13:47:00 MEZ schrieb Quentin Schulz <quentin.schulz@cherry.de>:
>> Hi Frank,
>>
>> On 1/20/26 1:09 PM, Frank Wunderlich wrote:
>>> Hi
>>>
>>> Thank you for your review
>>>
>>> Am 19. Januar 2026 11:22:07 MEZ schrieb Quentin Schulz <quentin.schulz@cherry.de>:
>>>> Hi Frank,
>>>>
>>>> On 1/18/26 11:50 AM, Frank Wunderlich wrote:
>>

[...]
>>>> - what if I want to save the byte size in a variable? With the current implementation, only mebibyte or gibibyte sizes can be stored. I would suggest to argc-- if m or g is passed, and then compare against argc > 1 in which case you'd use this third (in case m or g is passed) or second (if they aren't) argument to store the value.
>>>
>>> Good idea, thinking about how to implement this the correct way :) as varname could be "g" or "b" too.
>>>
>>
>> You could also force the use of the first argument to be able to dump to a variable.
>>
>> memsize
>> memsize b|m|g [varname]
>>
>> memsize would be an alias to memsize b.
>> memsize b var stores the byte size in var.
>> memsize m var stores the (truncated) mebibyte size in var.
>> memsize g var stores the (truncated) gibibyte size in var.
> 
> I could also drop the first param and always handle as MiB...uboot also prints ram as MiB and not GiB on initialization.
> 

It does print GiB on Rockchip SoCs, so there doesn't seem to be a 
"standard" for that.

> So only choose between print or set variable and no "floating point" calculation needs to be
> done...and result is simply an int. Afaik there should be no more boards with less than 1MB
> ram,or am i wrong?

Not aware but that would be quite the headache (you need to load *some* 
stuff in RAM, e.g. U-Boot itself (well maybe it could be in SRAM only?), 
the kernel). I would say, it's fine to truncate at MiB level.

> I think this makes most sense..and keeps code small and clean.
> 
>> You could also decide the prefix your size argument with a dash and if no argument with a dash is passed, it means it's a variable name and the default is in byte size.
>>
>>>> - missing documentation on the base for the environment variable. We have some commands setting hex digits in variables, some others in decimal, so this needs to be made explicit so that people know if they need to translate stuff before using it (or how to compare two numbers against each other). Here it's decimal according to the code (maybe we should have it in hex instead? I am not sure what is the expected base for variables :/).
>>>
>>> As i want to use it in scripts to choose correct bl2 file for bananapi r4. Imho decimal is better to read here,but it should be mentioned in doc.
>>>
>>
>> OK. Considering test (https://docs.u-boot.org/en/latest/usage/cmd/test.html#numbers) compares numbers assuming they're decimal if they don't start with 0x, this is fine to do (we would need to prefix the number with 0x if we were to store it as an hex value).
> 
> But this means numbers can be no fload and filesize is wrong as it returns hex value without 0x prefix.
> 

Yes to both. I was actually agreeing with your implementation (using 
decimal) being the best option because we can directly use it with the 
test command.

>> Can you tell us more about the initial issue and how you plan on fixing it here?
>>
>> That sounds like a board file (board/....) would be potentially more appropriate for this? What is this bl2, why does it need to be different based on DRAM size, isn't there anyway for U-boot to pass the DRAM size to bl2 and only have one bl2 binary for example?
> 
> BL2 is bootloader after bootrom (ATF). The board can have 2 different ram hw

Is this a typo? You say later that you want U-Boot to select the proper 
BL2, so necessarily U-Boot is loaded before BL2 by the BootROM?

Do you mean ATF to be "bootrom" or bl2 here? (I'm assuming the latter).

> configurations which require BL2 compiled with different options set. The purpose for uboot
> command is checking available ram for updating the BL2 via tftp and picking the right
> file based on current installed bl2 via detected ramsize.
> 
> The issue is that 4gb board does not boot with 8gb ram bl2, 8gb board boots with 4gb bl2,but
> cannot use the 8gb (only 4gb). So i tried to make a detection mechanism to select the right
> file (tftp,usb,...) for current ram configuration.
> 

If BL2 is TF-A, do you have an open-source implementation for your board 
(maybe https://github.com/mtk-openwrt/arm-trusted-firmware?)? Would it 
be possible to pass e.g. a Device Tree to TF-A to pass some information? 
I'm assuming we must be configuring somewhere the DRAM address ranges so 
the kernel knows where to put stuff. On Rockchip, we use the Device Tree 
in TF-A (ATF) to know to which serial controller to write to and at 
which baudrate (downstream TF-A blob from Rockchip doesn't support 
that), wondering if we can do something similar for Mediatek? This way 
you don't need to know at runtime what to do, it'll automagically do it, 
and that for every board with the SoC supported in TF-A.

>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +#endif /* CONFIG_CMD_MEMSIZE */
>>>>> +
>>>>>     #ifdef CONFIG_CMD_MEMTEST
>>>>>     static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong end_addr,
>>>>>     			  volatile ulong *dummy)
>>>>> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>>>>>     );
>>>>>     #endif /* CONFIG_LOOPW */
>>>>>     +#ifdef CONFIG_CMD_MEMSIZE
>>>>> +U_BOOT_CMD(
>>>>> +	msize,	3,	1,	do_mem_size,
>>>>> +	"get detected ram size, optional set env variable with value",
>>>>> +	"[m, g] [envvar]"
>>>>
>>>> Explain m and g so the user knows when typing help msize.
>>>>
>>>> We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for this new command.
>>>
>>> I see this note in checkpatch,but as i rely on dynamic value and i saw no test for mem yet.
>>>
>>
>> There's one for meminfo, but honestly I'm not sure it's a test that makes sense (just checking whether some fixed strings are printed and not associated values that are printed afterwards). I haven't written a C unit test in U-Boot so far so won't be able to help there. But we really do want docs in doc/usage/cmd for any new command.
> 
> Not sure if such test makes sense except checking if function returns a string based on unknown gd->ram_size (which depends on the host running the test i guess),or can it set before runing the test so that i can just check the formatting/calculation of the string?
> 

I don't know. It's fine for me if you don't write a test for this, I'm 
not sure if you can mock the DRAM size for example. The point would have 
been to check you're properly truncating and reporting the right size as 
well as writing to the specified variable the appropriate value in decimal.

Cheers,
Quentin
