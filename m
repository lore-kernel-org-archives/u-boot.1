Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E138EE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 17:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536CC800D7;
	Mon, 16 Dec 2024 18:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="HTr+2HQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092DD80104; Mon, 16 Dec 2024 18:43:10 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4633B800D2
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 18:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvrgbUCvJ+hwcJK2DW0Vvdwx5Ax5YYUn8nDJQpg9WNVha/yw3mzBKChNUdGSjM16gPe5pG+EQm9/Fp2k39ENko/0ViFv2hSMlB05sGZD4Blkwy6EmCg+LkdC9b8zIHMHB8xd31WbCec1Zu1uT1KNxcoX+PFKPkksXc6KxWrqi38mgSeVl9jzZxSLCUn6NW+HOss07GYGR/hmxyBHo/vo0VwcOOnrr0DT1ErRRdcOKYcAg4crlnZFtLwQ+dc51E1wY7BC+w9SCFtQoWnz5cxMIRHLoz42p74biflvt0/QPDJeR1/MAPQzqhGHPEfew0vfbWJKhF5FzyvNgwJ5IHpKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efAFjC+gMRkkjDSywoK9lFNyBp60Zhqea6a4+nDdJGA=;
 b=gnPgxVxpNfhdFQxlE9r67MdiWrnfrXZMkXSNix1kKiLqXAwTBL9uSaVZ/1PlliD9zjnQShCvLhsqFhXnkii07UANjcNV6hHRyCEqsz+mqDpk2G01AK436XSiWYuP9sdvzbplhD4SNwPJ4/UAB+ioZYY3DRtJW/gEbw+me/xJrEWP+ABEiQMU07vSxCG3zgCdszp99JnMN476ZDCKgC6xW0G2/oEYcWAE0suUTyIscKiso2k3wpHcg8AISGUX7rTzDJ2q6nvSQupGH02KtIlk1o06yKmBscaG+J5oqiTjErEBCzNJfeArP7SWIlM+EvVLyKu2O56b7Hh/GRUa7G696w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efAFjC+gMRkkjDSywoK9lFNyBp60Zhqea6a4+nDdJGA=;
 b=HTr+2HQg2laSytSqELyoe/AcoYbSMWFKNoTnN9E6UjB8jsiWmwNPWBm2NN4dDb7o1FooalrrpNUA3+sZk4br2L4/VK5QM6ZSgpzqXG05ydZ9Jvp6HSRBeVtGDw7B+IAD0uFp7P6vaNH/X7xslchnuyFbEAvyTVlKSYNOeuWxxOYHGtdcQilTo72RZ+QXNX1bKvH6M05O480uUfxhFGfMsq5Xp5z4+vQUgKJND3+5dhIWP16EG2fJyf9qkylS7S6o2Er+D8s30Y4jVwjDezRcrOJ9FehlLi0t/HR9TVas1gWabOIiLdnaQLCwOqxpHMyJrJES8mdrlE+MEMIAkjjF0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1PPF84458F39D.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2ba) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 17:43:04 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:43:04 +0000
Message-ID: <dcb8d933-8b61-42fb-b0e3-6389ba3a7f74@softathome.com>
Date: Mon, 16 Dec 2024 18:43:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] test: lib: add test for key derivation
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-9-philippe.reynes@softathome.com>
 <CAEfUkU+dqRHnoTCgwZ6AmrVZYCeE3aG2JzNpRLg0JtWceze_yA@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+dqRHnoTCgwZ6AmrVZYCeE3aG2JzNpRLg0JtWceze_yA@mail.gmail.com>
X-ClientProxiedBy: PR0P264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::17) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1PPF84458F39D:EE_
X-MS-Office365-Filtering-Correlation-Id: 347ecbc9-cd78-4a4c-2ea4-08dd1df91800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VCtMOHI3Y0NFTTdhTVVWbXg2eWNuSitERVU4VmxyMyszbVRrbm13eFBCaDls?=
 =?utf-8?B?K3YwYlJSRnpCVldXbzV1OEhjendRQ0M4Yjl6UG1QaitFZFBRN2VQdUVESmZC?=
 =?utf-8?B?NUJ4cXlkOVgzNVVyeVhEK0Rlb1FJaWg0YjVuKzByWFlwRWlRb0kzYlRCMWhB?=
 =?utf-8?B?VHpRdlJHRHh2MWRKVDRucERtSzFhYUROYXd2OHZxaVR5bWFpZnNHNTRxRmZl?=
 =?utf-8?B?TTA1dWpEeGlLeDE5UjUvL2F3Z3RNb1M5Y0NpamttNHd5dDNydDVxRVlCYitS?=
 =?utf-8?B?dm9MWEphL2JZek1DTTVVYnh0V05ZOG40Z0JKOVpVUDNCbkFsbE9nOEFhQnJJ?=
 =?utf-8?B?cTJqKytrMnAzdDNZUTlDVG1jc09kelk3V0lkK1Jzd0dIa0FwQkcyZGV2aEo2?=
 =?utf-8?B?ZUFSaG5zcExpYno0dVUxb0dvSjl3bW83NTBOU042RTJQWmNiM3RzM3p0MWlW?=
 =?utf-8?B?SlpFMWFobklrSkFVQjFxeGpQY3NkWXdBQUJNY2p6YWN3eG00am9GVmQraDlL?=
 =?utf-8?B?TXJqa1FRYm94Vk1ZbWxWc2tXZ2FORmYycWdnWW9hU25tRy9Xa1Jsc2phLzdl?=
 =?utf-8?B?U0llaWE0YkZyTHNqbGdsczRIM3IxckFnaWkvMHluaTRONEJDdEs1YkZrTTdQ?=
 =?utf-8?B?Y0hYNlZmYUlDb1VaenlEYWxoMlZXUE5ibGRmQUE5TEFqanplRms3MHdOeDJr?=
 =?utf-8?B?aW9WakJoMjk5cmdSeENsYktReXRrZWVOTWdaeit4SUsxOHBZcWlSdnBuUlVB?=
 =?utf-8?B?dFNPbXBkTlBQSVpuOUluQWRMUHJpYW5DUkE5UEtXM0tFYjhoV0prODVkdFFZ?=
 =?utf-8?B?aWJJTXkrMlVDSEg5K2JSeW1IcVhxKzMyT1Q5SjVVaFgwdzI1Tk4xd3E0c0ZI?=
 =?utf-8?B?YW82SEdLcHNEUm1Eamt0bC8rdEt5VHZmbTYwTjBsTTNOcitCRFd1WEl6cnF1?=
 =?utf-8?B?NE82am5kbGw5a2dYekw0d09WN2RGNmRSNEhPRHp1dnZ0ODFPUk9iQldkSW55?=
 =?utf-8?B?b1VGQ3l1UGdJKzUyb3hWTERQSTMyZ0hzR29vZ3VnTG5EOXF6Q2tqVjJCaDhH?=
 =?utf-8?B?K3lRN2Q3N1RnTXNDc3orY2VraFIxTzVhUWllRFZMT3dLMmd4Skk2blI1ZTFL?=
 =?utf-8?B?RlJGSzZZaURvS0k3ZzNWdEdTZ1VQaUpBSFVuNEk5WjVHOUlVUVRWMVA2Z0h2?=
 =?utf-8?B?MjN4VlhKOG50UGpDNW54U1JtVEgrM005R3lhNlI4NXdreDJnYkhRSFFEcG4r?=
 =?utf-8?B?VE5NYjNaTGdHY0dxUURoQWVEOHNHYWh4Tk5XNjJWOXRKeFNnVGU5UUdRVGdE?=
 =?utf-8?B?empiRjdRZ0FQT3hpRm9KbTh1TURPV0htOGFTYnVkMW9rTENjbWlJZWh0V29P?=
 =?utf-8?B?UkluVEhBSkYxMHZOMUZ5L0E4aGg3OWFRb08xdHFudEZTMkVFbngzV3Y0NzdU?=
 =?utf-8?B?RStpYm8yMFFqeUFEZnZvUWRHdHI5d2Y2MGJKQmdxc3hRRmdabVJodlA5UkJF?=
 =?utf-8?B?bmhGUjdYKzZxbFVSd0xRYzF2T2NBVUJ0VHRuRGNheUZZZEtRcGxjamxXMTYy?=
 =?utf-8?B?Q2FIS3ZzTTZwL3NMenYwZVV1RHFRMnB6QUpHMmFDaXJZTmZFTlMzZCtvV25M?=
 =?utf-8?B?Q0ZNVnZjRE5MM0tleW1rYXE1U0lxaDhnRk1YNHBxdkFxU245Y0NtQ2hqc2FH?=
 =?utf-8?B?V1p5QXo1aU94dnNwdjN5aGMzU0ZibzFjVFR5MGlqU0VvSUgyeENmcjVMaTh1?=
 =?utf-8?B?MEtFVnBFSWlEZjMvR2VXMitaSzdENUk3YTJPNFpTNzlJS2NTbWdIVko0cDE3?=
 =?utf-8?B?WW1OV3NxczFOMWhCMDlCQTJ1RDV4YlY0TVBnNUZoaHRtdFIyMFlvRCt4eWYx?=
 =?utf-8?Q?EftjqfISF7Sw7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZNV1cxSzltUEdQME5rSTFsUWNxVkRaN0ZRTU1LVHY1MFIzZVhQV2NnaTkv?=
 =?utf-8?B?V09EVVduY1phMzliZ1Y3Z29RVHcyWEFUN09QMWE0WTBQaE1hWFlYRldVVjA1?=
 =?utf-8?B?dnA5N0luVkI4a04yWmJYWVpkTzk4VG1vSG1nV1hLVVRuV3V2SUgyUHRJZ3V2?=
 =?utf-8?B?MXQ4RkE2aTh0a205eU1JK2JWbXY3NUQ5WUlSbVd0UGtydlpsRVMyMkJreUxx?=
 =?utf-8?B?R2hVYzhKNmYwVHFBWHZlOGJpWExCK3h2Qkpqb0lPR2lsSFgxa1JRYmFiNzZV?=
 =?utf-8?B?bVBMajk3RVJsbkVMdWZXMmNaTXV4KzlmN0t1R2FYclU4VmJJZjd2MnA2dnpj?=
 =?utf-8?B?VzhXSy9lRmV3YmIvRFBHOXhkS0JkSnMzRG5UT211UGNzRU9kR3NIYk54YS8v?=
 =?utf-8?B?OEN2ZEpuMzloYytPMjFWQi9QT2dDRGswbHh0UkdKSS9od0tTNERLQlhsb3lX?=
 =?utf-8?B?c1dEL2d5bks1elJoaFFsT2Yva0UvemQ3NERGVzNIemN1clE1NW5ERld3U3dT?=
 =?utf-8?B?cmIyVjBtSmRMaUhnUFJlb3Q1Znl6S0F3VmFBSlpYT3ErZ2VxQ2FLeUlmaHor?=
 =?utf-8?B?V21KZVp4dHZWU0Vud04yWWxhMHRENGhpTEoxZjJYRmJiK3RiWlJOZHB4b2N1?=
 =?utf-8?B?MTljZ0ZNMXNERzBUWit5ZWluaDduZitqT2tEbmRaS2dvMjJvS2sxdHR6Rnlz?=
 =?utf-8?B?ejVVOGhaVHdLSHJHNE13bUgyUGI4Mm1MYXpZb0JvMEhCVFZqL2hGUG80WEhV?=
 =?utf-8?B?QWhrZzlqMG5DME5LeHc4dzcxTWVjUnBVMk5HaVhWVEVxYS8vSlgzSEJmZ2hj?=
 =?utf-8?B?bW1tdk1BNEhnZURTRzV0ZXB6MGxoWnF2bStjN0pjdjZHS3l2R0pMcWZRL0xk?=
 =?utf-8?B?dHJXZlFoaVNhaXJESmVCWjZxOE1sN3ZWdEhLK09odnZxQkZFYm1yN3pPYUxp?=
 =?utf-8?B?elZoa2ZyUUd3dzhzbzFjZVNlOWJPVTFNUGo2VXg0YmxxaytCRzFxVmN1TWJu?=
 =?utf-8?B?Q2M4dUtvdm15cHZFMTFCMmV0MlV5MEtydkNkWjUxVjY1OGxsLzViLzh6dmts?=
 =?utf-8?B?WU5VdUNjc0htY2V1NEhPT3YwUzdmaC9sZTlZb1NwdFBwTW5ib1RJUi9PZDNY?=
 =?utf-8?B?U1NEWUlCWVJrNlQ1K0RabGZ2M2kxekFCOG13MXJQUUlIclRZM1QycytIenkw?=
 =?utf-8?B?MEJGcGRGb3Z4cno4ZkpLQVpGUnhxZWJPQWtmNnIyaEFXM2FkM3dlTWZRbVh3?=
 =?utf-8?B?ZmVFdGJIV3ZoY0hxY3JjV1IxVmFhM3p6RlptOXNmWE00a0xWVXFLSXVXdDA1?=
 =?utf-8?B?TDd1R2NzQ01LMEs2Y2hHK2RkdTN5K2FKd3RGREhXTU9uU1FVNXZHR2RBM0hz?=
 =?utf-8?B?MllIRVV4YXVFVFRvb0R6cDN2WGR0QTMrOGw2TjVFRnVTY004cWhGeWhxWS9F?=
 =?utf-8?B?dlU4WFpEVldkL1NlMk5GaHBmUFhoNFJ2aTF4UnNwNDRtRlFYelNNdVFyQmFM?=
 =?utf-8?B?ZzdBOHhELytpYUVkb20wWXJWSndnUDBEcENvekR3a2RCdUhsSEVwZGpDOEFs?=
 =?utf-8?B?b0NXdmdqcWRnbXF2ZFgwR0d6TGxYL01HK0tHVWg2R1d5ZTZOZFJKSTgyT0N6?=
 =?utf-8?B?YXp1MHMxQ2FCNTVDU05rQ3dpQkZDWjFUaTV6RlBSM2cza0dMeEVSTExYUTd3?=
 =?utf-8?B?YlE3ZG1HSStoMGliVFlCVUVKYmJLTFZCcUh2Z3dxYTRENmU4RHpDSEJRUTQ4?=
 =?utf-8?B?RmgvM0lWOVhuL3hQdnJrZEVjZENENUp1MmEzTlNxMXBJOHMzemthSzB0V0pQ?=
 =?utf-8?B?TjQzUWV2Vy9yNlFhRzJzV2xmWFJoVlhWb0hwVlk2QlFsYWVyRldLSnI3YnFO?=
 =?utf-8?B?MWlidlNFcmovYWRIUkN2eWZWV0NBS1FVT1BqMjN3YjdWM2hpaWhROGtHWE5Y?=
 =?utf-8?B?MHZENjVwRVpVMDJ2Ym5JNUI5SURLbmlsN3FBczV1cFlTUjErUjVHTGVEaTJL?=
 =?utf-8?B?bW5HRWEzSWRuN09HYmtHQ0V5d040MFlQMlY4MVpYWVhid3J3VWtUSUNMYUZL?=
 =?utf-8?B?N0JpUkZiN0xUZm5EQUswWWRLRkFFcHhjMUh2clZQNTJTTTJYUEx0ZDNrZHE4?=
 =?utf-8?B?cTAxbGJhdytBcEtMNVU2VU1ON2IrYWdlUm0vaDdGanBRSU5GRlJESFdhUG9t?=
 =?utf-8?B?TC9udUo5NWlIYS9hbTh1b0o0cm9RU1hra2xLS2cxcmtrY3BTcnd3emtvd2hJ?=
 =?utf-8?Q?oW9lvAayM2njGyMaXrUxIkH60oXynZKJkoHQ+PteGM=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347ecbc9-cd78-4a4c-2ea4-08dd1df91800
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:43:04.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8a+xzXiTjL4aMQ09nK+JIpb4TiRLNfxoPdEQOiV0IXGWC0ru6vtjVu5dZyli67mf0yhKZzIIg1faAWSh46yFo9n6YRnCcF+fn3BG8RNavM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF84458F39D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 13/12/2024 à 18:00, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Thu, 12 Dec 2024 at 08:37, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hkdf.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hkdf.c | 107
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 108 insertions(+)
>      create mode 100644 test/lib/test_sha256_hkdf.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index 4c0abcba81a..24ce6ed8f00 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -25,6 +25,7 @@ obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>      obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>     +obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hkdf.c b/test/lib/test_sha256_hkdf.c
>     new file mode 100644
>     index 00000000000..00090ffbc24
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hkdf.c
>     @@ -0,0 +1,107 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hkdf functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hkdf_s {
>     +       unsigned char *salt;
>     +       int saltlen;
>     +       unsigned char *ikm;
>     +       int ikmlen;
>     +       unsigned char *info;
>     +       int infolen;
>     +       unsigned char *expected;
>     +       int expectedlen;
>     +};
>     +
>     +/*
>     + * data comes from:
>     + * https://www.rfc-editor.org/rfc/rfc5869
>     <https://www.rfc-editor.org/rfc/rfc5869>
>     + */
>
>
> Shall we consider more test vectors for:
> Zero-length salt.
> Zero-length info.
> Maximum-length output.
>

I have added all tests from the RFC. So now, there is 3 tests.
The second test use longer input/output, and the third use
empty salt and info.


>     +static unsigned char salt_test1[] = {
>     +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
>     +       0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
>     +
>     +static unsigned char ikm_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     0x0b, 0x0b };
>     +
>     +static unsigned char info_test1[] = {
>     +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
>     +
>     +static unsigned char expected_test1[] = {
>     +       0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
>     +       0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
>     +       0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
>     +       0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
>     +       0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
>     +       0x58, 0x65 };
>     +
>     +static struct test_sha256_hkdf_s test_sha256_hkdf[] = {
>     +       {
>     +               .salt = salt_test1,
>     +               .saltlen = sizeof(salt_test1),
>     +               .ikm = ikm_test1,
>     +               .ikmlen = sizeof(ikm_test1),
>     +               .info = info_test1,
>     +               .infolen = sizeof(info_test1),
>     +               .expected = expected_test1,
>     +               .expectedlen = sizeof(expected_test1),
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
>     +                                    unsigned char *salt, int saltlen,
>     +                                    unsigned char *ikm, int ikmlen,
>     +                                    unsigned char *info, int infolen,
>     +                                    unsigned char *expected, int
>     expectedlen)
>     +{
>     +       unsigned char output[64];
>
>
> Please use SHA512_SUM_LEN to avoid magic numbers.


For the second test, I have increased this 64 to 256, as the output must 
be bigger than
the maximum output size of all tests.
I don't really know which constant I can use... so I have kept 256.


>     +       int ret;
>     +
>     +       ut_assert(expectedlen <= sizeof(output));
>     +       ret = sha256_hkdf(salt, saltlen, ikm, ikmlen, info,
>     infolen, output, expectedlen);
>     +       ut_assert(!ret);
>     +       ut_asserteq_mem(expected, output, expectedlen);
>     +
>     +       return 0;
>     +}
>     +
>     +static int lib_test_sha256_hkdf_run(struct unit_test_state *uts,
>     +                                   struct test_sha256_hkdf_s *test)
>     +{
>     +       unsigned char *salt = test->salt;
>     +       int saltlen = test->saltlen;
>     +       unsigned char *ikm = test->ikm;
>     +       int ikmlen = test->ikmlen;
>     +       unsigned char *info = test->info;
>     +       int infolen = test->infolen;
>     +       unsigned char *expected = test->expected;
>     +       int expectedlen = test->expectedlen;
>     +
>     +       return _lib_test_sha256_hkdf_run(uts, salt, saltlen, ikm,
>     ikmlen,
>     +                                        info, infolen, expected,
>     expectedlen);
>     +}
>     +
>     +static int lib_test_sha256_hkdf(struct unit_test_state *uts)
>     +{
>     +       int i, ret = 0;
>     +
>     +       for (i = 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
>     +               ret = lib_test_sha256_hkdf_run(uts,
>     &test_sha256_hkdf[i]);
>     +               if (ret)
>     +                       break;
>     +       }
>     +
>     +       return ret;
>     +}
>     +
>     +LIB_TEST(lib_test_sha256_hkdf, 0);
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


btw, I have enabled mbedtls in the config sandbox to have at least one 
config with mbedtls and hkdf.


Regards,
Philippe

