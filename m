Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A0CE9D7F
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D925183F98;
	Tue,  6 Jan 2026 17:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="e89ub/em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1C383FA3; Tue,  6 Jan 2026 17:40:38 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76D983F66
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGq+EGH+teO4lI2Um1jotpqVIvHtzt5dqoXPTpzyxIrIZYaiwfEl3AKTa1PelGbPqKoDr2RgflH+VSH6AWgmvqGqqtH3AYyUgU+ju39naztfAf4MSk5IC0EWOp6uzMsR58Zeh/8ldrAwrFiNTFsMJQsO55MYmS21Tp8KG3BRWtiyJ7UP5dI/S6CLRL5wkNz5aUojRsROuKqCaldF18jk7VwYZDrvqN6KLG12QgPowj9HpD2z21iNDYE15wAE1zeascNBRXHV2+ta6910CPH00vpOm0TIBQyGrP9gflKSJ1qdvRWfP9vupfaYhNGjPUcsa6xEejfjzATGUmdKq6HfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itUE3QHofCKmwH/G9pgf634I7nYJNCjMJ+lyBmSiL2o=;
 b=NL/9wydzzKMENh2MwQ/3cKMb3eJfaeGLHt+emqp1Ihju9NKSorCdfThO7KEai2e1zsYI/jdJ33Kor6hFlS6RXG2A8Fi1RNTic3aPnKnBk7rPIpmPuOlPnr1LYJHGHgSjUM6eOe5u7PEQr27k1E/3lj0PPkhxA5fvQiOdhMOVmeuxctRktThyp3wjipxEeGsF3fx9vQOdp8k5MTmOmcNy1mYdIxoWCwBO05Uebnw9VTFkNG7HrVhuAcVMwOq0Jp/puimVLlq4wHM+yo3y9HmDh6i4h5eL2pR4YMZTmG0O213VBCAZK7xhVg8KI5sB8mOMEG392Y4FCWTi0snxQzY8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itUE3QHofCKmwH/G9pgf634I7nYJNCjMJ+lyBmSiL2o=;
 b=e89ub/emQGfEvAexuZSSzw4OsXSuc4Hgn4bClPCUHuwyQrxSQMib6sdSqZXL6O72NNujV9Yyw5Kx3SqNeGqN9w+/mHhPSE5ts7FuwqsLsszpwILinEQH4f3IiZ2WdM76YlBoZm2XsyX/em7WTpNhOTi8Cjk5aPLkIZqWsDEOP8bKigfuDMR6BTL4FKe658EMuuU2kD3OlIkm/4K7qgsR2hOp6ocndfxKPGtDruHfrL8KzwIJBLsDVVT87XDu1/vNXf1fNPTcIy9habXRfT609/l52n+8JCpJbsLHZj9/gCKz4Hi3LeDK1Gj3+p5qLXKAPA1taofVHN9QiLajIymn3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:40:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 16:40:27 +0000
Message-ID: <106009e8-e08b-473d-a093-81acd117636e@siemens.com>
Date: Tue, 6 Jan 2026 17:40:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Drop default y from CONFIG_EFI_GRUB_ARM32_WORKAROUND?
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, cip-dev@lists.cip-project.org
References: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
 <87ms2qah5u.fsf@bloch.sibelius.xs4all.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87ms2qah5u.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aa55fd-00ba-4c2e-5832-08de4d424c57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG1mWFFFcmppQ0lEYTdRL3h3cUs0SU9UeDJsbkZhVERnaUkzZTlSaWlDTVdm?=
 =?utf-8?B?cjZxSG9Pa3RnOWtTaWN1R0k2VnhWcWhKWnNJZEZkTmhzcjJ3MmdTWkM2VEp2?=
 =?utf-8?B?QnFRY29nWjA0bGZRSUYvWXh5Z1p4anFlLzNKb1I0NXpuVVFPOXRjZUtwVjY1?=
 =?utf-8?B?MUFjczlxQ0kxZEZMUGpZTmUyNW9jY0FJUGFDdnlsckdWRlJXSW5VK08wVTZP?=
 =?utf-8?B?SHhRckRGcW5PZjJPRSs4OEgyOXQwU011Y1JYS3g3bmF2U2pja2NjY2cxNCtE?=
 =?utf-8?B?YjVFTUxnQVFJQnJrbDZwaitwWlBZSWFrZUNJdDNadFc1b3lDRkI0RXpYUTA2?=
 =?utf-8?B?SGZKam9kd0FsVG5hS0h3TzFMcWxJQ3dlc0Z5QzUvQjQ4WW4wK1hNOEYxbC93?=
 =?utf-8?B?RXJDN3R3U3hvMkExREU0NjNNbEZiREhWZVVabGp2SVAzb1IranV3Zm9IOVgw?=
 =?utf-8?B?bTVkZEpqREJSQlZhdW1OU1I2S3EzVm05SEhwU3N0aXFKb1FmSitZcWE5a0h1?=
 =?utf-8?B?YWxnZlJUQ1drSVN3dDIwT2lHSGpoS2JBVWkvZDc2eWN3Mjhjak5WTmRxQUlv?=
 =?utf-8?B?OHBjdmFKZGZ6WTZkQlRodFhpTEVzemZ1K1lOa2haVFo2ZCtGbFlTOUZaTkUr?=
 =?utf-8?B?WFhjc2hYb3NtQmpKVlh1Q0FweGdKeThWUGtWT0g3WGxLaWFkc1o2TklFd2VD?=
 =?utf-8?B?QUxFcDBDTGd3MC9qYVlQaVo4ZTlMSkx0YWwxN0ZTTmNrb280V0xZdEdRSkRS?=
 =?utf-8?B?R3N4Y1plQVFaZ2xETUVMTjBGMVJDQ2t6M2Q3WE5ZK0V5cEJqcjdncVZYa2l4?=
 =?utf-8?B?RXluUFh4VnNzdVhEUGIvaEFkV0hEUmw2L0lWajY2SUtuam9Ma3BJN3J3UHBl?=
 =?utf-8?B?dWtVS3VRc2lLeEMyRXZMVWYzZHloZ0dsaThNVkl0RE1EamlHdWNvZE5DcCtr?=
 =?utf-8?B?aFpXMXFDQTNuTjluY1RWSENmOEJTRkN2dmNGVFpkU2gwc25QYXZaS2VmREZp?=
 =?utf-8?B?ZWlpdlMyeGN6dldVd2RGYkJhaUtleXQ3T0s4bU1PL1JqbjliZ3JOMWJBY1dO?=
 =?utf-8?B?bUlKS2N3eStwaWttN1Fwd2VYRmdhS2pBMkw4WFVYSlhqdWwzeEpUQzZ2YjEw?=
 =?utf-8?B?NTFYZHVIdU1QZldWaUEweDVRM0dhOGk3NVhMc2lncjhnT1lDcUx1UGJ6Z240?=
 =?utf-8?B?RHBjZXM5T2ptSG1ZL2xsVGxubjY4K0NCNW5lWCtiTWpkM05GUFZHMXA3aHFw?=
 =?utf-8?B?dGJCVCtlK3VwZnhmV0VQVi9KbEVIeUNLKzVkK0Z1N1ZvdUt6RkwrN25HZTd4?=
 =?utf-8?B?N0RkczhRcXlwaHArZ2U2N0JvTklhcUovdi9yUmNKR25ZZWh6Z2VPNElXbnhu?=
 =?utf-8?B?VllkNWdTRnozWEU4cXcxWGtrVEFqczVIdCtpTENmZFNwbjdzbFpyaTFEV21h?=
 =?utf-8?B?RUlhUytjN3VDdE8wS1pETm1GUjExMjErWkhlRGZET0dHeWZLYVhzWkpjSDRU?=
 =?utf-8?B?UDdTa3kyWnBGNjRmRlBHbkZZdVNySTRhUjcybkkvc3FGSWpZNFV6aGRvdGl5?=
 =?utf-8?B?L1YwZ1BvUXJyOExKTG04RXFaRGZZT1dJaGk5YXB1bjg5ZnZiNHZJRFdxK0R6?=
 =?utf-8?B?Q1RVWUF6Y295aDNYekJUTjJQMzZFUTB4Q1BWK2ZUVU1vSzdFbk1uTEpVc2Vl?=
 =?utf-8?B?VG1DS013bWlFdDlneFc0cU5tNG1JUXR4TkkwQ2N6bGZvMGo3S0JIcXBEK2ps?=
 =?utf-8?B?T1Z0L0hUOGFQKzlTajFhTm54aklDbDlBYmhoclRMS3dFTmZMNUdXU0xtU0w5?=
 =?utf-8?B?VXF0VmlHYXZGejU4d1pEQzNHNDZhK05qSGd1SHVaL0JUakdSaVZyKzlGdm81?=
 =?utf-8?B?ZE5JSjVoak50eG1zeWpFQVExWVFDWTdsVFZiV3N4OUk1ck83UnpiWEFteE9O?=
 =?utf-8?Q?CsIIO1ddlUj7Q6tMs3RPAStgyYpgFmXd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VJdVZGdTNSeS9JdzE3R2tyeGhRM3ZiZTJRUG55cnFxU25rcWlDdm0rVGUv?=
 =?utf-8?B?ZldTL2ptU0o2eURmWWVKVUdwcXZnVlczdGZRZWU5eW05MUxwdG1VK2hlNGJw?=
 =?utf-8?B?ZGNLdUI5ZkhFbUpPbUdvUHNSUFFtK084eDc1UG1ZelIrMEltNHdFeU54M3My?=
 =?utf-8?B?RENGKzBaNWwxSm55UUpXMlQ2eUtzQld2NG50V2JWYUpSZVdxc3NUcERnbDY4?=
 =?utf-8?B?OHFaZ3NoNGIwU1lxWVg2VWd1Q3NlRml2T2RMVTFzb2I5dnZsYzVxYVZtZnNU?=
 =?utf-8?B?Wk1zMXQ1UFZYckcrZm16OWdyVzZJRUFSTkZ0cFRHa2xMZXJvLzVody9JT1Y3?=
 =?utf-8?B?dTBTRmRlUjFHS2pLMW44L1N6QUsxU28yb0ExS0RpS1A3Nzg3blV6Ni9xUVYr?=
 =?utf-8?B?ei83ZTNYekRkL0lONHNFa3NTYk9hQTB0OFJLOWt1ZVFBOHY2QkV4SWNLUDNy?=
 =?utf-8?B?U2wyT3M5TVREeGRwMkVBYkFLQnRMenUzaDJBTmdMMGdQMjJUSmxyQklqMGRT?=
 =?utf-8?B?b3hkKzBoN1N3dU9Za0tRSjI4dE5neGpCd1g1U3dlS2UwRGJORTFoS3FQTjM4?=
 =?utf-8?B?T1BXYXRBQU1SK0IrdXFmWEIwa1VIckxWRmRWVlpwYjlGNlU5MXdhV3BDWUY5?=
 =?utf-8?B?TTJGY1JXN2QrbXBvaDBBOXBrRTV5YW9FaTFvaGdyL3Z4MnBrMjJvMVRhc1E2?=
 =?utf-8?B?Z2IvY1JHcWcwT3d0eXdiZ012WFVONXpXWTFKUWN2azNkSThwcTQyZkJWTDRi?=
 =?utf-8?B?UUhaUG12bjJpL1NuL0xodVo5R1pETm9xRDdneGQrditjdDdPRWhmeWQ2aDk5?=
 =?utf-8?B?UWF3RUxmaWswQ1VKWmhkWk41bWJ2aU82UWZVenpjUUw5TXFTZUZOTlB1bjZ3?=
 =?utf-8?B?M1hCbFFXVzVPMTVxRlcxbjBpVlM1Q211N2xnclNIdmpheE9JZDQ4MUNjY0VT?=
 =?utf-8?B?RW12ciszeW92cnIzQkRJKzd6SE1yUG15bmtxcG1nbUM3OSt0b0VDRHplL2s4?=
 =?utf-8?B?VTVYUk9UdEEySUhIL2VnS1pxU3pUZ1dSVkNaWW1vbk10OEdKNzkybHZEOEI1?=
 =?utf-8?B?UFJhaGZoZ3FIU1VQV003RE4yb1N6VXorS2lwc0Q4MG9zSWd3enBjanJsMkJj?=
 =?utf-8?B?SHhWQVBPbU4wSVlkSHFxTVlXUGdaZHhKOW5Xd1NLMlNXWElremNtS3R3R2JJ?=
 =?utf-8?B?M0lONm02RHd3blk4TWUzNGU4djU0S1ptcjYrZDR5MHlpNHNSRW5TMEc4TzlS?=
 =?utf-8?B?R2kzSVRCQ08wbjFDRG9TUDJsemR0Uzh4aWpmUGs2NWNMZ2QrUDd6S0UyanNL?=
 =?utf-8?B?ejBJZkVUazRXeGJjM00zS0tRMGxsRDhibktBVldBb0xCVExwcGF5Q2FQOStD?=
 =?utf-8?B?bStvbHdWQ09tRWJRdUNSZDNIb0xXY1FBMlFmRjJrR1I5eFNjakVaR3lXVmt5?=
 =?utf-8?B?NTRmZUkybDNPdExhbXlSUm53M3k1bHBkbUpVM3Vkc2RQZkJSN2MzOFpZT2FI?=
 =?utf-8?B?dldJdng4eEtROUZQTjdhSk9aTzNkaC9TVm9mYWUwbXpKc2lMQTcwQlhUc3lq?=
 =?utf-8?B?cjBXWU93YmhpNGNGOXordnBpbDBEZ1c1bVpFRU9rajErV0h6Z0UrNnlkWEEv?=
 =?utf-8?B?cU9YS1dsMkpURU1HWUUzT0hFUGhFVUx1ZWQwRHpOSk9ZR2NaT2pqYi9SdFJP?=
 =?utf-8?B?R2o5UjhhSURBNFFST29ZRHZNRHhYRUp0WGovNllvUVdJT0xKRGk3eURjVzZZ?=
 =?utf-8?B?YnZzNlJLdjJvaE9hdTRmZkRoald6R0NKMTVvcUdMTHMwWjhtdkdDKzdlYjZG?=
 =?utf-8?B?eEN2bzdZYzNaamZQTnp2d0VRRmY0MVVOOEtCb2FQeGlYOS9Lc2ZrZzJQalg1?=
 =?utf-8?B?bGs3dWVJck1LWm51OVQwSGIzMzNoTStoYm9MWU02bEdZSUdxQlQ1WTMwWDFX?=
 =?utf-8?B?V2VFUmYrNU0vaFU2VTNCdmp3Nm1EcE4zVmVzOEtHWXhzYkFFYUlTRG5SZ2xu?=
 =?utf-8?B?d2lMZ1Jndmc3T0JJV1p4cDJySHZUc3FSSXBQRTNNLzgyckREUDlYSUVKYXcw?=
 =?utf-8?B?TVF1NlBFTnhIcVA5WDVzamxxaTR0ZXN2RlpucjdRRWQ2TDVHaSsrNDZJU2Z6?=
 =?utf-8?B?SnNPb1I1cXJuQUdSSHF6VEpGODB0WGhWTGdIY1o2K1dqZVlVY25vZFBkUkFW?=
 =?utf-8?B?NmtBRzIzdUhia01ubCtsb0RUNkNrLzdsQUVIWEF4Q285bEI0Vy9nZllXcjE1?=
 =?utf-8?B?M0dId0hqVkFXME9qdEtQUFVkc2E3bDgreVlva0Rrcm1UcWFZeWRPQjBlaG1o?=
 =?utf-8?B?YklERjYvUk9wL3ZiQ084cE5ueFVBYlBwRmMrWjUrblA1MTVJK3N2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aa55fd-00ba-4c2e-5832-08de4d424c57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:40:27.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrdkk3IwGJpJoVO1+52E1lsyEHIBJCEKYGWn+w8kKu0x0lJDspRaAFtskTgUfbBFM5lRMuciJ5ExnvXP9aoLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6257
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

On 06.01.26 16:34, Mark Kettenis wrote:
>> Date: Tue, 6 Jan 2026 14:47:30 +0100
>> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Hi Jan,
> 
>> Hi,
>>
>> it seems that some kernel configs can cause problems with the
>> CONFIG_EFI_GRUB_ARM32_WORKAROUND. Namely, 6.1-cip and 5.10-cip with its
>> current defconfigs [1] no longer boot on the BeagleBone Black (other
>> boards still need validation), both with the more recommendable
>> systemd-boot and grub. I do not have the motivation to debug the reason
>> in the kernel / its config, given that everything works fine once the
>> firmware behaves according to the UEFI spec.
>>
>> Meanwhile, grub reached 2.12 now which is far away from the old, broken
>> version of 2019. So, should we rather make this workaround opt-in in 2026?
> 
> This isn't just about GRUB though.  There is also the issue with the
> the non-architected caches that are typically found on systems that
> use Cortex-A9 cores such as i.MX6.

i.MX6 is a good hint to cross-check with some related board.

But what does that mean exactly? If we turn off the workaround, not
calling cleanup_before_linux() anymore, we will then leave caches for
i.MX6, e.g., enabled, and that would also be against the spec?

 * According to the UEFI spec caches that can be managed via CP15
 * operations should be enabled. Caches requiring platform information
 * to manage should be disabled. This should not happen in
 * ExitBootServices() but before invoking any UEFI binary is invoked.

> 
> The OpenBSD bootloader used to have the same problem as those older
> versions of GRUB.  I fixed that back in 2019, and there shouldn't be
> any users left with a broken version.
> 

That's good.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
