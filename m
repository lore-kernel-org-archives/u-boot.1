Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F15D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE17683A1A;
	Mon,  1 Dec 2025 04:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CPy4hUJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA0A83A28; Mon,  1 Dec 2025 04:58:50 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2A383966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/F4gmf7YB9Gerx2kYi/r+KNBWJPekWMsDI5htXIyWF9Mem/KPqH5bb/YVASIwWMNAIj0cqYiKUSC5ZrWyL3YaYai+xlfnIDUvjvjrhWSL8TxGlmO6lWF5SuwWqEV+HQ00hh53QAb0OrBFS5/D+TFru0fEe68ka6p665k869t3nTJn5Vp28n58G35Bcs+6rkJ78jylpcSxJ/uC2dUvHRiScomInVADsLdTb4Sgb56mRnFsIluV4abfGSMRZkoOg3qaeg18U+IwSc863CMYr5ERU27HIwRfv7DiIKGmN71zxJEjrfebTbrft1cxgyc1TAPv2Q4hrQfqBRKTdzOhO72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVuqcTuh6UCq+pf+NVbt/+jnXw/z8u7RFTLZvmMBKcM=;
 b=mkXJm6CoOmZitAC50Yyfo4R6Z5jv+cO+Iwdx99C1kKAcnHwi070xi/mlzbhyRajyE5HxwumO1/88U1RBgvlcVhKVWtJZqups3LzUFKximG9NA9BuGq6vNqE+cXiP0JcO4aPRb5ZLUQIvlsj+nWvTI7J36XyBENvEUafIasRCsKQtRbTTaK1cWmcw7Y0XB2s5naHThUtMjo4lVP/hoHFw45lx6MbgDjfqbc3uikI91zjyk3zeNVl4eALsNnqQtJIsORxbZuzPmePdW2pE1fgzCK5g4QYi7Mx8nWuWcDbD0bOahQko4ZvNSxUg+W47En8Xj+NQBwlr7qoJbH883Ik6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVuqcTuh6UCq+pf+NVbt/+jnXw/z8u7RFTLZvmMBKcM=;
 b=CPy4hUJSOj+6HL2aHvtatInVLPWZYR9wpJf/Ver+HPNbPGjSduGT1fVMnjKW3Tgga5IV+eaC5Zi9m8vre6rKuK7qGz0E48rx/OSWTtM4MtyFxlu8PVpH5swAScT1+ngfVPs30iVYXSiHfvw05IPj7oXJaCJw1GdsABt1Ct31dIBJ6oOSLOCqRXiJBs95Y7E0ahd5mIlya+tSJxWX2c3lR57tuG4PU3knb5aTsAWo8dwUIuIs1UnmZYCpa2UcCdE+qYNI1X493ZSfW63svnzBwl8VEdRipYH0Plsg/2hkHfIdshM52zSup9Tr/CFtT4pVTwCc4adPHgPT3FJMalBWxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7509.namprd03.prod.outlook.com (2603:10b6:510:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:58:44 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:58:44 +0000
Message-ID: <3456e9b7-6ba1-4753-840b-5db60e3a95e4@altera.com>
Date: Mon, 1 Dec 2025 11:58:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: softing: vining: migrate to modern LED framework
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251119-led-legacy-vining-v1-1-6107439085a0@cherry.de>
X-ClientProxiedBy: KL1PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::33) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH7PR03MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 6166ca51-890f-44c2-1c36-08de308debc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHV4VXpKdURRallRRTlhN0c3QVBTVS93aFZTTC8xN1BLdldSVmRIMzhGSGRU?=
 =?utf-8?B?NTl2aFI1cjROMks1SjVVNlRlYXlTb0gvcXVtbEpyTzBTd1RwbkgwRDR6NUVj?=
 =?utf-8?B?cjBSSFN2MXROWE1pRWoreGhHaDNhSTJTUUFGVHlPRlpOZ0lRc3hYdklwOHNh?=
 =?utf-8?B?NGVpWEEyTlMyWjFIZ01xd2grQi9idkRhV2RONkVqOHlQTEJnMXFnbW5QRzFy?=
 =?utf-8?B?SXRIVllNdTg0R3JKZnVXYlFUSkJPaW53MUZpRVkyMUhuQjVVR3cvU1R2NjJD?=
 =?utf-8?B?clFhbHdLQXZlUGRvdkgvZU5PVjlVL1lScGt2S25EVFdQdnBMQWdCdGlOdjNv?=
 =?utf-8?B?Y2pncHM5Uit6Y3Zmb3FTUFJsbi9QZG5pNCtYaERwc1VtZ28vaXFCVDV4SS9h?=
 =?utf-8?B?bC9qbno4bjFaRnZKUkRnRkFhWm82QW1yL0pQc3d5N0lNMFRXOENGUU5KSWIx?=
 =?utf-8?B?R1VEWGVIY3ErQllmbWZ4WDZoVkNKbTlBQlIxQ1lOckRURGgvTU5rc3lyb2xn?=
 =?utf-8?B?ZWZOaHphZ1NpZzRBWnQxeU5DTis2bWY5TUFSRHY4OE9XMEgvSSsydzJSRDlP?=
 =?utf-8?B?S2QwNUJFc3lVZjBxcjkxRlNlbmFOY2MxSUFJRjFSY3FPK1RSUndwRWhjVmh2?=
 =?utf-8?B?d0RubjVYTllaT3d4Yy9yMVhNUklMMzViREZlNUdNL1FBVDg1bE5mZVRyM3Qz?=
 =?utf-8?B?emVaR3BUVUpjTWE1NkFOU1BCbjdZd0R6MXBuc2h2aFBJU25xbzZ3a3dwam5I?=
 =?utf-8?B?QjBMd1YveUd6UzR3YzFJYUFTWFRvOHNnU0VRU2hYT3hMdTdpYWtjU2JyanIz?=
 =?utf-8?B?Ti9uNGVNWEsvdHdueFgvZ3FNd0U0cG5uTUxoR1dySEI1dHRYZzRMTjhTOHRP?=
 =?utf-8?B?aXBhbkcwVWVONk9CaE1KYjhuMEZpM2tqa210enB3RDkvMW9BWjZkUjBhK0dK?=
 =?utf-8?B?MThwQm9VN3RuVjJRU3I0WVorOHBjQzNvd3BwdERZOXh5QnkwVUlRNnJ1UEI1?=
 =?utf-8?B?d1ZmT3hMSDBnbUwrblZlSUlCSVFla1RLT1FVbjVnaHQ1VXl5R3pCZ0xPVU82?=
 =?utf-8?B?OGRZS3hkRDhWU3NmUkZKUEdTNXRKT3F1YmRoUVFGc0hEWUpYNUZYbnZlZytx?=
 =?utf-8?B?ZUF6c053Nnd5ZWV0QUZFRjZDaUY2cU1wZWhRUkhuRi82S0s0c0d0Wk84MEJH?=
 =?utf-8?B?eFA3b1B5Mm9qSTFZNjAwYWliVVhjcG11QWtJUmQwNTlmMU9kWkpGbytoQnZQ?=
 =?utf-8?B?WCtKUGdsYStuckZzaDNyRUVZZmFkQmROeDg4THZWQnpydmVMaHdmUytuK1Nv?=
 =?utf-8?B?cENtODV5RXRIOFAyN0x2c04xTUpFT0t3ZUJtUDA4RG5IaWVtWXAyUGFreHlw?=
 =?utf-8?B?ZVF4TFY5Y2pISzJ6eXhVVDBYVTdENldJS2piQXhiVmxsUjdEK0ZyWjdnNEJV?=
 =?utf-8?B?dkxuc2Mrc1BYNXJ6cUNKT3QvTFlrSHZlYmVSUU01enUrRzdLTzV0RDEvRmpU?=
 =?utf-8?B?SG82eVdRU251c1pkUUpUWEFrcThYbEFaSFVYaC8rK1J4UkFmVlMyb08wZUtp?=
 =?utf-8?B?ZENXazZ2RXZWMWtXR1dxUjdJajR0TEVIVEFjV3NodGJvVEMzalMxazFqVk5H?=
 =?utf-8?B?T092RG1MT3RZU3pIREE3TjRtU1V3U0k3aGNyb2gwRFVubStHaTAxZ2JRbjl1?=
 =?utf-8?B?bUtOVllaMWEvamJSWmp1VXlnbWVXQVBtck9FVzZnU29ab1NGZllHOUxzUlpl?=
 =?utf-8?B?ZDQxZ3c2L3NuU2k1dS9xNGpTWVV5YVFqL1BJZEc3a1BWdXVHM29iT2poQ1pK?=
 =?utf-8?B?cHVIR0NmelhydHNLV1pYLzJWb0JqQUVaZTl0RDdhd1FTZzVQQURMWjhWaXo4?=
 =?utf-8?B?NU9ZUWxUam1BRUtsRUNYaUh3SUJRb215MERwd21ITTd6cU9maVZkdEVwTDJn?=
 =?utf-8?B?djZnQmk2ME96b21ZdUhEbTB1b0REVTFJVVpONjBRRUkxM1NxSWl5NHRoTjZ3?=
 =?utf-8?B?bkhESEE0a0RRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHg2N0ZNbjBQaGJiZDdUOFVseDNSOEFKSXl3RStSdnJCVHg5SUp3SzA3KzNB?=
 =?utf-8?B?MWVEWWR0dWhPT1RkV25Kd0UzNHQyUjBPZ3VtRmh2cmZxWDFPWWJOdmNYU1Yz?=
 =?utf-8?B?bmp6dGhrVXgzUGJLNTQxeWI4azFIS3J0QjNJdWlXOUlqYThwQXM3TjNkSnps?=
 =?utf-8?B?cVV2NDk5d0JWS3JuemM5a0gwNW5keUVEclA2QXZrYmlVdzlKdFdaVFR4R0JZ?=
 =?utf-8?B?cytXZ1ZqSGE4amxhUWNjZ0IvQnRFd1h4OEJYRUF3RXphUWp1WnUvUzdybjR3?=
 =?utf-8?B?cXNvWWhHTzE0OUVPOG9MVnpkeUhnejVWSEtZUVNkWlRPNzczSmlRNHkweUEr?=
 =?utf-8?B?dkF5c0xCWFI2aUxoNmsvOXV5TkJ1ZWUvOWZxZGVMYmpjK2pGYUN4aU9pNjdu?=
 =?utf-8?B?VzdybjJhaGxiZUhGendYeE1mMUF3UTlUb2x0dko4K3pxekU5Y2Q4L28vYWZW?=
 =?utf-8?B?M2JrZXJWWnRHNjgxR2laNHhpUm13WTJqa04wb0hFdENXMEluNzVRYzhpbDd1?=
 =?utf-8?B?TG9aU1RwVUhXMGpaaE9pVzB1MjNFWUI0bjRVOFBQVnl4S1hseENTd0lGRHRU?=
 =?utf-8?B?bDd6OHhQR2M5SGZwRWpwNjFTa1F6bys4bkhIaklqdUR6dk5XRlp0UERxQ3lw?=
 =?utf-8?B?WDJhZWYzVG9UMlhTUGxVL1NJcU1wYWV1YnRLMXp4ZC9nMkJQelVCNzdPYjcw?=
 =?utf-8?B?NFB4UU1JTnZNZ0k5QzdTazQyS2lhUHRhVVNMSGtiNEMxTVFIdmNOQ2Vqbzg1?=
 =?utf-8?B?MzZHbFZia0tId1N2d09HRUNmc3JLdC9XQkplditUU3VRcFgyVDI1U0k0THdI?=
 =?utf-8?B?VXArOXRQbUxVSHJGWWFOV1lFV0UwQVl5TkVCcGFNaHQ2Tjg4WXpseUdQUUZz?=
 =?utf-8?B?NXJLQnFWTDN3WWpIWm84b056UlNGYW10SCtMMEN1aEVXSS9iZDJhK04xQWtk?=
 =?utf-8?B?VTVPUTBxcStwaWduWkV4aFZ4UzFER1dONktZbm5zRmQvdmxHSVIyREZkYXpI?=
 =?utf-8?B?dDJCZXZ0eWtHRlJGTWlRc3FJTnZUdzM0b0pnQTU5ckhIdzVRclNjMk1FS0hD?=
 =?utf-8?B?TXkyOGkwVmZ2MGV4K1NYSldjbUl3TUVMNWYxaVVNdG00NlNDRUl2enhqbWZr?=
 =?utf-8?B?V3hEOTQ2clV2K2dPVFFFSi9DR3BkTzZtTmZGZ0RjRmt5TCtiQjV4eFZhUkJL?=
 =?utf-8?B?VWRzUURuTWZEUkVpT0VHclpLWFdGVzlFdk9jYWFER3RmaUJzUjRTeHl0K2Qr?=
 =?utf-8?B?YjNydU12VTFGUXhzSzcyV3BBcHhEMEhDcFQxakY0eS9zOS8xU1Jab2F5M2Qz?=
 =?utf-8?B?MGhUZndQMVNwUkhDTkNPckxINGMxMERLOGdIRCtzU0t1eDh5bE5RdGYwMndr?=
 =?utf-8?B?Ylp6bHIzOGpjdUM4N2pLUnNaWXVGR0RrUitra3JlTHlLYVZEMmVyRWRySW8r?=
 =?utf-8?B?aHlrdC8xbFhtdm1NUEJGR0s4Tm5iWjRKcTBUaTdHakc4b3h6ZVRGV0daeDEw?=
 =?utf-8?B?R0JNd21DQ2lrVm9PNEYzMGI1ajFybGpRbml4S1FDN0dLc3BBUjZaMFEzREha?=
 =?utf-8?B?TjdoUWJ6THJTU0RzMk1ZVmM3ckN3SnhPS2NzQzVXNFJuUzluRG9CZFVkZ2tQ?=
 =?utf-8?B?ZzJrUXFnanBRL3ZoU241UHByZVFURms2cWcwMDdxTndFMHgyaXU0aTlxL0M1?=
 =?utf-8?B?bStSVmhLVGwvdzZxM1dNSXZramNkZHk2RU1EWVp2S3FPYmpla054WjNoS25x?=
 =?utf-8?B?dXNWV1YxV2YwbTduYWEwaWpiUnFXQ2J2NW83bnZ4Y0NCNUtUK0ZCV3lKZmxY?=
 =?utf-8?B?YmVCbGw5THZuSWhIZmdwT05uQWduOHZGb1pVYzB6cDN2YUVaTmVoVTBlN0lp?=
 =?utf-8?B?d21hM1QvVzR6ZWVPaERSRy92eW1mMHpEMS9CdzFIV3VIZS9MT2hnM2MrcnJO?=
 =?utf-8?B?OHpSbWVISkx4RFBuc2lpRzhFVGNsU1pxb244UXlqQVFTQnpySEIzZzZnVDZs?=
 =?utf-8?B?bmZ2ck13cTM5Z2swa0lOZEJMWEF2UHduNytsTHdhVGRmSmhKWkVmVzFESUcv?=
 =?utf-8?B?ZUtkMVh5VnREcU5Ed3BZcUthRXJRWjhaSlc0V0hLWWt6cWdsbkc0eW84dkJi?=
 =?utf-8?B?NllFM1hJc1lKUklKT3FZM2M2SkZxWkRveld5M29lRVZjd3lFaEpDV1hMcCtP?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6166ca51-890f-44c2-1c36-08de308debc1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:58:44.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjryIX+L8HHuS31D2hBH5maa8ScNPJ+zzB++j4TAyjtpFSerAugpuHSIxHet6R/dU4A/gZtZZAUh8mG1kz8jJkj0/P5mdA6RChqcP0JRJ5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 20/11/2025 1:19 am, Quentin Schulz wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Quentin Schulz<quentin.schulz@cherry.de>
>
> This migrates from the legacy LED API to use the modern LED framework
> which makes use of the FDT.
>
> Signed-off-by: Quentin Schulz<quentin.schulz@cherry.de>
> ---
> This migrates the Softing VIN|ING FPGA board to use the modern LED API.
>
> I do not own such board so I cannot test it. I'm a bit unsure about the
> port and pin in the port to use for the GPIO LEDs. The numbering for the
> GPIO controller in arch/arm/dts/socfpga_cyclone5_vining_fpga.dts seems
> incorrect too (29 pins in GPIO0 means 0..28, 29 pins in GPIO1, means
> 29..57). I'm unsure about the polarity as well.
>
> The GPIO LEDs are only automatically probed (and controlled) if they
> have a default-state. In our case, the LEDs are init to off as far as I
> could tell, so we add the default-state property to each node and set it
> to off. To be able to lit LED_STATUS1 and LED_STATUS2, we need to access
> them via their label.
>
> This is only build tested as I do not own the board. Would appreciate if
> anyone could test it. As far as I understood, all LEDs should be turned
> off automatically during boot by U-Boot and then two LEDs should be
> turned on. One should be able to control all 4 LEDs from U-Boot proper
> CLI with the led command.
>
> This is a follow-up to:
> -https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
> -https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
> -https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
> -https://lore.kernel.org/all/20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de/
>
> to continue the effort of getting rid of the legacy LED API. This series
> depends on the series listed above.
>
> Multiple other smaller series are coming. I split the whole thing into
> different chunks as separate series:
>   - "shot in the dark" migration of Socfpga Softing Vining board (this
>     series)
>   - removal of LED support for a board with no easy migration path
>   - make Sunxi community bear the cost of maintaining the last part of the
>     legacy API by making it Sunxi-specific,
>   - migrate Olinuxino to new API (which requires net/bootp.c to use the
>     new API at the same time) + remove everything related to legacy LED
>     API,
> ---
>   .../dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi   | 26 ++++++++++++++++++++++
>   board/softing/vining_fpga/socfpga.c                | 12 +++++++---
>   configs/socfpga_vining_fpga_defconfig              | 13 ++---------
>   3 files changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi b/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi
> index 330949c0184..bf5e12ec90c 100644
> --- a/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_cyclone5_vining_fpga-u-boot.dtsi
> @@ -13,6 +13,32 @@
>                  spi0 = "/soc/spi@ff705000";
>                  udc0 = &usb1;
>          };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               led-0 {
> +                       default-state = "off";
> +                       gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +               led-1 {
> +                       default-state = "off";
> +                       gpios = <&portb 25 GPIO_ACTIVE_HIGH>;
> +                       label = "status_1";
> +               };
> +
> +               led-2 {
> +                       default-state = "off";
> +                       gpios = <&portb 26 GPIO_ACTIVE_HIGH>;
> +                       label = "status_2";
> +               };
> +
> +               led-3 {
> +                       default-state = "off";
> +                       gpios = <&portc 7 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
>   };
>
>   &mmc {
> diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
> index ec2c7ea3631..475c19f2781 100644
> --- a/board/softing/vining_fpga/socfpga.c
> +++ b/board/softing/vining_fpga/socfpga.c
> @@ -8,7 +8,7 @@
>   #include <env.h>
>   #include <init.h>
>   #include <net.h>
> -#include <status_led.h>
> +#include <led.h>
>   #include <asm/arch/reset_manager.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> @@ -24,10 +24,16 @@ DECLARE_GLOBAL_DATA_PTR;
>   int board_late_init(void)
>   {
>          const unsigned int usb_nrst_gpio = 35;
> +       struct udevice *dev;
>          int ret;
>
> -       status_led_set(1, CONFIG_LED_STATUS_ON);
> -       status_led_set(2, CONFIG_LED_STATUS_ON);
> +       ret = led_get_by_label("status_1", &dev);
> +       if (!ret)
> +               led_set_state(dev, LEDST_ON);
> +
> +       ret = led_get_by_label("status_2", &dev);
> +       if (!ret)
> +               led_set_state(dev, LEDST_ON);
>
>          /* Address of boot parameters for ATAG (if ATAG is used) */
>          gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
> diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
> index f3b6cb717b3..396b7a9715d 100644
> --- a/configs/socfpga_vining_fpga_defconfig
> +++ b/configs/socfpga_vining_fpga_defconfig
> @@ -78,17 +78,8 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
>   CONFIG_DWAPB_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_DW=y
> -CONFIG_LED_STATUS=y
> -CONFIG_LED_STATUS_GPIO=y
> -CONFIG_LED_STATUS0=y
> -CONFIG_LED_STATUS_BIT=48
> -CONFIG_LED_STATUS1=y
> -CONFIG_LED_STATUS_BIT1=53
> -CONFIG_LED_STATUS2=y
> -CONFIG_LED_STATUS_BIT2=54
> -CONFIG_LED_STATUS3=y
> -CONFIG_LED_STATUS_BIT3=65
> -CONFIG_LED_STATUS_CMD=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_SYS_I2C_EEPROM_ADDR=0x50


Acked-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
