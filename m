Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E513AE77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E418800D7;
	Mon, 16 Dec 2024 16:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="wN9NOo35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E0780104; Mon, 16 Dec 2024 16:05:31 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07113800D2
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 16:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUD0O/C40DiOY7KHHBX6Vd+T5HDh1PDVXKopGLUclS4fSA7bDveoC15uQY+tWW5RDkmI+nPm+MZ2vDnOFSstuO1ecKBkM2rW1S31fMRGchAysWB52m2H+H92aJ6zQ9z3LsLr9Yh5BF4cuNVPcodSpXLHOrFIc5ARRV/qaJJCeotynnk7u69/ZWDfBiPoHcfhFhWUAv9GDhgwXVOHYD59lYcYtLfHL0QIUlWUWHOgD6NahKlG/aJVU9RtWzSMpUjot3/A14EOYJKTg6DepYUcj9pTOxYeYE+R5vAQFU7F+/eBdq+3+7yNnopraZcfN2woiW1+n8He8pZOp4dz0ou5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imXOgTD5zpAEMie+0IF9QGW4TSf5qsAQfSo8Nb7FXW0=;
 b=bMrz4vOMEmwXq8Ic0GJq2Q3Z1rhH9HVvAU9beSgvaHgHEWsoWzAgT1c6/JCuyybM0WUSz2qTxc2uBi1FgfMcpqzK6o6eoS7OZj6risp2umvl9oc8xc3KHQ/lnxWAu52P92+pJ5ZmYQRamB1rVAUvFGOpfPM36rCjdmFtYXmwzqz23cKhk1shuBcRjdtXo36i7vUnf0X4C+whJuEkt/bZuzPCh55kYN7RpFjoltnErIXsU1d/gapL9F7ItUAlsL8vAjiXSEHbG4PY5YLG6clRE5j1UwFJQRGJpGaWegDxsP2+hAWidduaLPwVOjq0EltipVSexgRSnJDCJVGKlNZFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imXOgTD5zpAEMie+0IF9QGW4TSf5qsAQfSo8Nb7FXW0=;
 b=wN9NOo353EqrfKQd3JLVfVx62OIHEANTCSm1aPt/2KfDPHGWSKrioV4rQSCOBvvKardmhqTRC7bMmRbfUcgnxRNF9oGLAJ100nRKJj0HfGkADFKQENnkUDqtfck8OypK4pzDFyjbz746KaxXlY64AolQViFvmm+jsgsUfag2gjF0nyjcIe2ljloQqUu0UIanzexXkW/kzPlNBCxBnMZuWq5rwOAQ8Ym40jZWn7ol+Miu4jPhI5qZjD9I5/A4Klcb+5ok4p4sHxss2oQ+JwXlgmbgWznTqccXFkpu7mDqZTYVR/gvZEaTVXW5fLJDTatN82thmjkUqRT66YDMuHcs0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PASP264MB4664.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:05:27 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:05:27 +0000
Message-ID: <cd28127a-b6ac-432e-9ed9-a41d4a094848@softathome.com>
Date: Mon, 16 Dec 2024 16:05:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] lib: sha256: add feature sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-6-philippe.reynes@softathome.com>
 <CAEfUkUKiV1dy4iOjmo_46Wg=Dg0Pt93XYJJNB4UFD-08__zxbA@mail.gmail.com>
 <255d5a83-f8b9-4d13-9b76-efb6b8dc18de@softathome.com>
 <CAEfUkU+uegW97fCaOAypasDmS_5g+gvwnT6f2c-zEpenn9SSwQ@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+uegW97fCaOAypasDmS_5g+gvwnT6f2c-zEpenn9SSwQ@mail.gmail.com>
X-ClientProxiedBy: PAYP264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::10) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PASP264MB4664:EE_
X-MS-Office365-Filtering-Correlation-Id: a16dbb88-bdf1-436c-3c87-08dd1de31332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlJ2dUFrdkZIMEFkcEVYTWhHTC9VanBpN3dSTDF2ZjIrMWFXL3FQb3VRdkg0?=
 =?utf-8?B?bU9jd1Q5MWRHekJKOXJ0SUJCTlE2aHl4dklla1BvYTl1VlZwYnVoNGVoSXFT?=
 =?utf-8?B?R3g2Z2RWUW9LalNoMlRkN2dQYXJCN0R6Y3oyWWtHU01zamZmeGtkMjR2a3dT?=
 =?utf-8?B?MFRrOTBtRk4wRmViK2I2ZmFDcmxVb2RTejkvV25UeFVCNUpQYTM2ZEFvZTlU?=
 =?utf-8?B?NWQ5V3B2QzQwUkJTNzI3Y29UYlg3b0dqRlhTV05VWlIrbUE1MmpqblFOakJP?=
 =?utf-8?B?MzNUby9pK0lxRlhBK0NLemQ5MG92UERjYTRiNjZXL1Z1d0tJQzJjRXhXcWlD?=
 =?utf-8?B?Wm9PZkFRU2k0MkFUSW1VaWlXQlZZdFBJQ3Nuc29oa2lnZEpZQVpqcDdFSFo3?=
 =?utf-8?B?RWk3WXYyZWs4dGxPemcwY2NYdjdRN0UxNFRnVjdldHFrejM4MGJCeXp6cTZw?=
 =?utf-8?B?ZFAyUXpucGZBellzd2RpR1hTNGRGZHFhQitEL3RRSml6czlqQy81ZVI2OVNh?=
 =?utf-8?B?SGV1VitoRHg4bnd2V2p4bnJUR25jN0E2a3JCRUJOck5wdkprQmJ2OFRBRkZB?=
 =?utf-8?B?czJuZi9Mb3Q1aDF2RE0vb2I3TWJPU0ZsaTdvK2srT1IzaWRjZkREaTNEcUpP?=
 =?utf-8?B?S05uNmdaT0dHd1czM0o4aUt1QXllSzF1Y2J4aDRpRUFVSnA5NzRnS0xLdzJx?=
 =?utf-8?B?TDU1TWJ6eVovQlZLbHZhWDdpdEhXSGtXMmJnLzB5RDlDZDNLUTdWekdMcHhH?=
 =?utf-8?B?bFVEVTFtUDNYb2JxdHhFSGVjb2ttSUdJVmU1UU9VclFJMHZ6ZFlzWUhWUUZx?=
 =?utf-8?B?WjNORFBmSzUydlZnZ0tuZ0lRMGJDdlZsYndyUnIvakRHeVJjRTNOcDlQcGtq?=
 =?utf-8?B?MUQ2ZGdtaDIraEpvNEJqU2duVEFkL21jOStLY1hFaDNWOE5vUGdTNzkxVnU4?=
 =?utf-8?B?SWZNSnh1NDFZZDFDb0UwYmxUcUNMcjFKTWk2R3U4czc2bjBtMDNXSHpFcU5E?=
 =?utf-8?B?UmJRVGJacTRYTlhpaU1hSy9ZTVVsMlgrdzZ0V3FIS2tpMml1QWt4MG9ZYm1E?=
 =?utf-8?B?N0pJN25nQTg2dTFFWFdlMFZ6eHVsSUNSeHgzcmlWVS9zeXJaL3h3ei9tVTd6?=
 =?utf-8?B?WVFVVlNjMElKcWs3UlpzMVhlblRPUWpYUWhVU1dTS1h6bDh3Mjc5TlFjbFZt?=
 =?utf-8?B?TnUwQ0l0VFV0cHBtNkE1ekEreFNVU2c2Y2pKcDAvT3ArQnNjNnIwRFRWZzhi?=
 =?utf-8?B?cU1WWHIvNGs1MnpLMGdtRkxaaTNMcWFYNnJIQTE4bzV0TWo0cmsvbVo5OVVW?=
 =?utf-8?B?aVhBeDlwc2EzcXdaUzU1V1BIN0RsdTJSWDRWeTBNRUIrU241d1VtYjRveTRD?=
 =?utf-8?B?MUEwbk5kR21lQkgrL0xxQ2kzZ1Fia0U0Mm1weDduZmsreUZ3SzRmUlg5MmVn?=
 =?utf-8?B?M3VNWG9FSEc3eUhBZ3FqWE5XbUgyUWtrdzF4NVZydXJpdDhUZkhPQzBRUVNW?=
 =?utf-8?B?QWIzRFVsRnhUYjhlVzFHU2lhd2NHNHhTY3dSUTJiYmNDWFFCYlZsZ1lYaFIz?=
 =?utf-8?B?Tm1qTGlJM0JiUU85d3A5dnU3djBNcWtXLy9oYVhvdlN4TXJFVkxHZmIxMG90?=
 =?utf-8?B?MmRkaXdOeTR3dFYxUDZvRVcxd29Db0IxbzBJTktTK21aR25Zcy9NSFVwV1Z3?=
 =?utf-8?B?ZDJrMWdqOU9na3JEZlp0T3FyNGlzdWh1dWU1L1JZcG5zZ1IycHgzVHpoVmt4?=
 =?utf-8?B?V3BKSzBHelBwSGhHNkZBenNydENxK0QrU3VnSzN1VzlrSC9HSGpFMUtBb1Fk?=
 =?utf-8?B?Mzl1VHBieEoveFdJMkI2eVlDYTluWi94L3M4MlNwSXhKL0d2V25iRlN6aDgw?=
 =?utf-8?Q?2yWrANdFT7QC/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxKei9mblhlVmxaa2x6R3QrTXhxNFBldkxMRXExSU5LV2c1em14dXBwKzdx?=
 =?utf-8?B?SmIxanJLdUhBc1JubVk2L3lUNjBHeVk2aW9oeENQWDNHVmJFY0RRRnlWblgw?=
 =?utf-8?B?b1JHYit6enRNWEkwa01tdVptckdxa0l6RzJtREd1SVNMWUk5T3pjSWZJc2Zy?=
 =?utf-8?B?cUx5ZG8vT3UrdytzUkE5QytwYzVUL2tyTUt2NmlOdEtFWG8rbHJGUFRIQTNB?=
 =?utf-8?B?TTN2elpmcTFVY2ZwN004RU9JUGxBdU5OK2VKQ2dxd3I1ZFRQRXRWRkQrTXBw?=
 =?utf-8?B?WDNmN2t6Qlg1NXpqSjkxckQ5YjIvOUoxakRWTktvMmdoOVcwNjd6aWFpK1Fp?=
 =?utf-8?B?NEx1aUpTV2hoWnRNcEtNclBwMUorTlpwcmovZzRTZHF6NW83UE83cGI0aW93?=
 =?utf-8?B?Tm8rSURTOWJ2TFFlZEl5NmpsVHlvSWFsOFpYN3hLSm95VlN2aW5PdzRYWjBv?=
 =?utf-8?B?WGx2WElFZ0hiL0g0cGFmbURIT2lsTkh0bGFPdkVLZlh4eXhKYmJoZ2hNWm9z?=
 =?utf-8?B?bVpUR3k2NUhYQjFFVFk4bENYcXB4ekZ0K2FHb3I5ZjFmVWxZSkdycG9vUnE0?=
 =?utf-8?B?eWtBZFdldTUxby9hTDRWWkc1empYK2U0UDBvaTNmUTFVcVlMeXlWMnpzclps?=
 =?utf-8?B?YXNQbmhITU1HS2N3V0FqNHp4NnFPWjZrMGhoQ1k5Z2Jrb0xMdU1zRmZMbndZ?=
 =?utf-8?B?ZGVYRUhvMVRFV2NOSC9INzdmc3dGaGhySUg0QnY1dEJRMmt0OE8ramVJd3Ix?=
 =?utf-8?B?NXZLbFNHVC9pcG1BSi9uVjlWQStkTUNlNmpwVEs4SEdBdlYxcTdNOGNhMGR0?=
 =?utf-8?B?bTNGdmdFaHE3eHg4c0lxWFU0V2dRV3psMEVaMzdSTXhjd28rbUFVR0h4ZGJN?=
 =?utf-8?B?K2lIdnRUUmlFamN3Y2dJUFpGK1BVV3RWZUxzWTlvNE4vMURRTnBHbDBIVFlo?=
 =?utf-8?B?a1JUYk5pRldPTmJPZ083NHVvazdVWTd5Wno3Q3oxSUN0bDJCaW5yc2pVVVBw?=
 =?utf-8?B?S2swRUJIT3JIWTNobW93ajU2NGMraVUzcmpYWk5NcTVtYUJVamUwd1o4ZThx?=
 =?utf-8?B?U0RnT3A3VjRFdHhCZWVXMGN4aHNpc21mbW1ER1JoaXgxbW8wcnd2VXkvOHh5?=
 =?utf-8?B?UEE1VlBaRENOMmZiUzdXeU84amQ2cG0xQlkzQkpqWHZzUDFweC92Y0s4ckpu?=
 =?utf-8?B?YndlQ3Q3eE9HaHBVUmIwZEY5dTVnczdXMnJmSnJuakhzdy9XYXk0QzdXS0lB?=
 =?utf-8?B?Q1FHcklKOTVmZ05MRStmQi9QYjhDT1k5VzFiblVWM2hZaHREMGR1V3dzUk9t?=
 =?utf-8?B?TGxiMk90blZLTmhvNHZiNTZ0cU92N29HTzBROHEvNVNQMWlXM2xYTmhtcEo1?=
 =?utf-8?B?UVdLTVVnOWhCY0NFWFZKVmJMbFdoZXkxN3ZRVGZrbzYvMmRRWVdSOCtNUTdI?=
 =?utf-8?B?NE84Nk5qYnpXK3djTkpqUWJpVmxCYVl2ZDVwbkFubmlyclpRaFc2SDREclho?=
 =?utf-8?B?Uk4vUjR2YVc1ZTZOSzlUODZYWUFLMW9ZR1BxL04zVS9kaDhIRlEvYjVxVW5X?=
 =?utf-8?B?TkdnZVZCSHA0QmdocW51OWFXY3hlQkZlaWpmM1hUL3pHSmZCL3ZPQVVBNWRS?=
 =?utf-8?B?S3ZHMHBwK0FhK2FRR3ZPT2ZuMXhDMTNkdFdobmg2a05FUVk4Wm1UTTdMclor?=
 =?utf-8?B?bzBjVjBNWEkzUmRHZ1l4WllCZkJvVVFDZUNZYnlMK3BZSE5oRVNpWHRRQlFm?=
 =?utf-8?B?VzFTTjd0NkZlTzd1ZDZNaGVsZFZuRW5hVGJtWXc3WnphWWZuck1SQnlxU3Ev?=
 =?utf-8?B?TUhxakM4RkZYaFhscDVMQlMrZU1xaDc0RmIvUnlMQ3JONlYrSGV6aGpPaDF6?=
 =?utf-8?B?SU5MOE4yL3UyNmZnbXJvdjB3clgzT0F0ekQxdkJhVXFaL2wyeGw4Q3g0dXN4?=
 =?utf-8?B?a2gwbEFWMmR4TGt2NlRrUFBwazE3NjF4MzNTZlcvZXd5L3FOQ3JwZFlRaDkz?=
 =?utf-8?B?dXA4THhVL0JlVWdURHgyanBCWWF0QlByNXZuVTcwTldERVdlZE9iRE1SSjZu?=
 =?utf-8?B?clZVZHBSWGV4STRLbytMdnplV1g3SjArcUhZSG0zNm9jQ0RJWDR4MmYwR2kx?=
 =?utf-8?B?dEwrNkZoRjBPeVBRaFJqNmZrd042d0VZK1hRbkdCVkJYVHZ5aUdhV3ZiRy9J?=
 =?utf-8?B?b0kvdHp3bmZxMExFSll0elBWeUUvMTBMOTBKMHZrODR6V0NvaWgxYk1KclB5?=
 =?utf-8?Q?NcX0FVeRWcJe6DTyLwolsxG/nTgHkBAO15yYB+lKTM=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16dbb88-bdf1-436c-3c87-08dd1de31332
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:05:27.5736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2GlQRkp7hlu53vB11xh95Upo/xn67XZA0nVo6ICRsui/5n0J4ALvaU+B9DUgVU6CrLIawYDWTMWcLfFM4m/husIOrTonp4m4xeU6T5qTsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4664
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



Le 16/12/2024 à 16:01, Raymond Mao a écrit :
> Hi Philippe,
>
> On Mon, 16 Dec 2024 at 07:48, Philippe REYNES 
> <philippe.reynes@softathome.com> wrote:
>
>     Hi Raymond,
>
>
>     Le 13/12/2024 à 17:49, Raymond Mao a écrit :
>>
>>     *This Mail comes from Outside of SoftAtHome: *Do not answer,
>>     click links or open attachments unless you recognize the sender
>>     and know the content is safe.
>>
>>     Hi Philippe,
>>
>>     On Thu, 12 Dec 2024 at 08:37, Philippe Reynes
>>     <philippe.reynes@softathome.com> wrote:
>>
>>         Adds the support of the hmac based on sha256.
>>         This implementation is based on rfc2104.
>>
>>         Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>>         ---
>>          include/u-boot/sha256.h |  4 ++++
>>          lib/sha256_common.c     | 48
>>         +++++++++++++++++++++++++++++++++++++++++
>>          2 files changed, 52 insertions(+)
>>
>>         diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>>         index 44a9b528b48..2f12275b703 100644
>>         --- a/include/u-boot/sha256.h
>>         +++ b/include/u-boot/sha256.h
>>         @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx,
>>         uint8_t digest[SHA256_SUM_LEN]);
>>          void sha256_csum_wd(const unsigned char *input, unsigned int
>>         ilen,
>>                         unsigned char *output, unsigned int chunk_sz);
>>
>>         +void sha256_hmac(const unsigned char *key, int keylen,
>>         +                const unsigned char *input, unsigned int ilen,
>>         +                unsigned char *output);
>>         +
>>          #endif /* _SHA256_H */
>>         diff --git a/lib/sha256_common.c b/lib/sha256_common.c
>>         index 7041abd26d9..46262ea99a2 100644
>>         --- a/lib/sha256_common.c
>>         +++ b/lib/sha256_common.c
>>         @@ -48,3 +48,51 @@ void sha256_csum_wd(const unsigned char
>>         *input, unsigned int ilen,
>>
>>                 sha256_finish(&ctx, output);
>>          }
>>         +
>>         +void sha256_hmac(const unsigned char *key, int keylen,
>>         +                const unsigned char *input, unsigned int ilen,
>>         +                unsigned char *output)
>>         +{
>>         +       int i;
>>         +       sha256_context ctx;
>>         +       unsigned char keybuf[64];
>>         +       unsigned char k_ipad[64];
>>         +       unsigned char k_opad[64];
>>         +       unsigned char tmpbuf[32];
>>         +       int keybuf_len;
>>         +
>>         +       if (keylen > 64) {
>>         +               sha256_starts(&ctx);
>>         +               sha256_update(&ctx, key, keylen);
>>         +               sha256_finish(&ctx, keybuf);
>>         +
>>         +               keybuf_len = 32;
>>         +       } else {
>>         +               memcpy(keybuf, key, keylen);
>>         +               keybuf_len = keylen;
>>         +       }
>>         +
>>         +       memset(k_ipad, 0x36, 64);
>>         +       memset(k_opad, 0x5C, 64);
>>         +
>>         +       for (i = 0; i < keybuf_len; i++) {
>>         +               k_ipad[i] ^= keybuf[i];
>>         +               k_opad[i] ^= keybuf[i];
>>         +       }
>>         +
>>         +       sha256_starts(&ctx);
>>         +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>>         +       sha256_update(&ctx, input, ilen);
>>         +       sha256_finish(&ctx, tmpbuf);
>>         +
>>         +       sha256_starts(&ctx);
>>         +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>>         +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>>         +       sha256_finish(&ctx, output);
>>         +
>>         +       memset(k_ipad, 0, sizeof(k_ipad));
>>         +       memset(k_opad, 0, sizeof(k_opad));
>>         +       memset(tmpbuf, 0, sizeof(tmpbuf));
>>         +       memset(keybuf, 0, sizeof(keybuf));
>>         +       memset(&ctx, 0, sizeof(sha256_context));
>>         +}
>>         -- 
>>         2.25.1
>>
>>     The sha256 hmac common implementation now sounds good.
>>     Do you have a comparison of performance with the MbedTLS
>>     high-level API
>>     mbedtls_md_hmac()?
>>     I am wondering if it is worth using this API specially when
>>     MbedTLS is enabled,
>>     since it significantly simplifies the implementation.
>>
>     I have done some test, and the legacy implementation is the fastest.
>     To do my test, I have run 1 000 000 times the unit test for hmac.
>     here the result:
>     common + legacy => 7 seconds
>     common + mbedtls => 17 seconds
>     mbedtls => 17 seconds
>
>     I have kept common + mbedtls for the v5.
>     But I may use a pure mbedtls if you prefer.
>
>
> If my understanding is correct, "common + mbedtls => 17 seconds" means 
> mbedtls enabled and with your patch,
> while "mbedtls => 17 seconds" means using mbedtls_md_hmac(), right?
>

Correct


> If this is the case, I would prefer to use mbedtls_md_hmac() since it 
> brings more simplicity.
>

Ok, I do the change.

Thanks for this fast answer.


> Regards,
> Raymond


Regards,

Philippe
