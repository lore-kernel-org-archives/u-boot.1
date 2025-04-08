Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BA0C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 06:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908C38312E;
	Tue,  8 Apr 2025 08:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XuRQtppU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6DB83156; Tue,  8 Apr 2025 08:51:09 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E9982D2E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 08:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrXt72DDBpfmXZdox7t3qTChA0aSRxwZ9QouZnhmE32WDjM0aopbmlS4UQGdzme7g/JqxUlzQmtg3rP//5rJ86pNEQV9dMt0MuZqaS/f34Udmk/19hGvOcQXKETS8c9khJPIpTBIJzpFT8W6x33AUkRGLyOMsEL4uSUY5jZN1fnTeceprPSrNLrtDzJZHDwv+xYC5aUvVXj5EoRRRhmIeaS3u0Qq1iKYeeXc40CAVmDX8URcUdLmHCoQrd/tsr6Utg0unfbBVUAe+h/dXOXPmcaKkG69AQaQDU9VRfhtt+gw6lCD/mpIEeZBq41qbfYPkHfaqutcaqrsriY6Sdfq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pcW0/kcDNp8d67XjgyHNjO9jmAgLjgpm0ONHmd/5Bo=;
 b=e6dohF+8ISeU+ib9BlAChf6dCWpX5jPEBWSUHWLt8o+9M9VaxiKP+fu4qXpg14lzm1xZJWgNuWXlYuKMGeIBzfAZhYwA0mPgw9PjOA3BJ4VKL+zjRVnjpevOsCNOqI6SoQR4h1GgMGsKsIW6+tbTV6O3mZOfQYd34HNpGT3V+lgWGJY+kSYEtzo84hRJf2EPOOy9tmeSbT8T3KdPFf2hdtJsdgYUoK9ZPRa4D6Ygs5/IISzw6gSEFoHzl9KFfTvybdbWM+PdIyFUHn3ZvlVQbsVGKbMPP5gHMad4XwflWZCJVi7GGHr5RoFzPuxcTiSfluOhhplRnnhaSUVXKIIe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pcW0/kcDNp8d67XjgyHNjO9jmAgLjgpm0ONHmd/5Bo=;
 b=XuRQtppUH2GwB8yaQE86JWh1r+vF4/AIWl7MvQAgLEboBbzCjB4aekN9FYmG5hBqq2eoDt/IGX2JZmoa+CdcBlzQG551TVIrGWPcIuwWMTXVYYapnivruI6610NX8VfFx+E2PMCqCeO+cjkA8VSDP1fBI/Xt1sB2Vleu+rhqPNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 06:51:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:51:03 +0000
Message-ID: <e919a512-56a2-41c3-b8df-0ceef01e4dcf@amd.com>
Date: Tue, 8 Apr 2025 08:50:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add FPGA configuration when booting Linux
To: muhammad.hazim.izzat.zamri@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
References: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d5c85c-649f-4a1f-01c2-08dd7669baa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGduWU95MVcxWDZ2UnRZOG5rV3lrSmc4TWFsQUhITElxTjFFMzZNKzZPWVBt?=
 =?utf-8?B?djZyeHp2UWxXRFV0Q1B3VmFsWGZEVHkwKzdtRlV2aTNwalVRZHoweGNmcmta?=
 =?utf-8?B?d2V0SWRCKzFzckFBd2Q2K1I3QU83K1FQNW9vY1h3MFpBVjV0cE93a2RoRHpZ?=
 =?utf-8?B?Tms1SzdWYm5YRFZEcEFOamFQdGUrZkFsNDgrYUhPekRjZDVSQzM1NE5SMW9n?=
 =?utf-8?B?dkZUYXEyTmRXMTlNdTFuVk5Eb1NjNVZWU0FhVWNDK0dlQXE2NXVSTXdkMVlr?=
 =?utf-8?B?OE1hSjVjWlpIcnBGNmFFUTdxcWRRQ0MvTi9zeWhvOFVmM0VaaE5VYVZDNmRu?=
 =?utf-8?B?YzBUS1lFNkkyM3hQK3BYRXFVRW90Y1RNL25ubW1GN3pFY1J5aGp3Mjh1VXhN?=
 =?utf-8?B?RnpqT1hWM2VXRThLUnFCUU9TRExuSGRMTUkvSERXTlhoNlBKbVo2UkwvSVgy?=
 =?utf-8?B?NUpyZjNTdUVLWWw0SjJ0a1pKWnFZN0ZVSGM5YmNud3RtZGpmanY1UE9SN05x?=
 =?utf-8?B?QkZERS9KNDkyOUhTcW4xbEUyWGlJSlZMUFVub0JlV3k1NDZpTWJtSE9mTExQ?=
 =?utf-8?B?VWY4OThqSDRNdERJSHo4YjRKWXdYZUMvdDBlaVJzQ1JOK3BPMXBIRXpodENz?=
 =?utf-8?B?TTZHUmlQSmVCNjhUSFBsVTRuSVhQK1BPb3NJOHBzWVdBcWFlVUk5Q3B2aEFM?=
 =?utf-8?B?WWM3WVRjQUpkUndsT1JqSC92ZE5RQXhnN0dQK3E4V0ZHekVVWk9IeVNKbmdB?=
 =?utf-8?B?bnFaeERXOUU3eklRbmJxZHNCVjExcVdRdWNRZnZWclNpM2V5cWFGQ3M3V2hY?=
 =?utf-8?B?ZE9RblBkMGRLUVc0ZFoyaEtabjNUZ1JrUDI0ZkVNY1c4YVhSa1crRGxydG9D?=
 =?utf-8?B?bEw2RlpQRUwrb1hvV1B3RjAvbTNNWW1EMzVLckJJNWJOaWJWRzg0R1FraEtJ?=
 =?utf-8?B?bE1yT21kZVN6Smt0RUc4WG8vTG95czcwdSs0ZzF5aWdWUnpXSVN2bDRta25w?=
 =?utf-8?B?R0NTTHBKK1Z1ek5oNDM2M1lOMG1kRkhuZ3dsMkxvVGltM2J4Y1JETGpyNXNz?=
 =?utf-8?B?elh4Q1hETUtEZmlFM0k0T3R1SHdTZll4am9UUXd1VDlYU1NSTFlZK3RCZ0l6?=
 =?utf-8?B?VlFVR3NzU0kxd2tPNzl2aFhnazB4MXdWU1RsNGRxaXZBSkFEYzBKQWNHajN4?=
 =?utf-8?B?b0d2N1B2bVlxaWg4L0JqZ3FhTGhYcUVHSUU3SG1XVTQwVk0vSWdLQ2RPNnZm?=
 =?utf-8?B?YUMvRUl3RHVCMzdPU2VJYTlRR012VmZFVmR3eVRzODdBKzliYlN6WXlmNW01?=
 =?utf-8?B?K0FQME1VaUxBOFROQk1CazM0WHh1Y1lDT3AyZ21OSjJlenJ3MmN1QUZlSmlI?=
 =?utf-8?B?VWxCYkkrQjVRc05NNy81QnFCckliSHEvWGc2VE9oK2gyOG9jU2NBa3J3ZHRU?=
 =?utf-8?B?SFpkU2cyQmErRVR6ZXdzZk9CMC9kR0dOUEdiak9seHFHeDdtQzNreGVmUmVJ?=
 =?utf-8?B?MVlRUTJXR1VxMElXRVhpVVd5bzNzczZNYWdYbDkyUW0rTVYzYzltQ1EyOS8w?=
 =?utf-8?B?YVdDQlhPVlRIK1JzV0F6dGFkMnlTWU9pMVpMVGYrUXBUakozOXY0RC82R2pK?=
 =?utf-8?B?cGVWTGxqMEl2cDMwUnZvanNidFdocXIyanB2WlhkM0VIeGpLTTZ6bEZHekpY?=
 =?utf-8?B?a09QYkdKVFhaUE9KbWxLVVN2QVd4eWlxOGxJTXNqTUNTY3JES2hVTVo0ZGlL?=
 =?utf-8?B?aHR6VERKSXJnQnBPd1A0N2x0bGFTdjlmTnlFZnhKQVFNTGNFM2duLzl3ditu?=
 =?utf-8?B?d0hHbVBKM0wyeVhzSXNzMDNSTXc4L0Q3TFpKMVlZTGFXTklKamtRKzhYUExP?=
 =?utf-8?B?TUhFNVU2UjJOTnVjdXd2SzRjZnZvdUVsa0xMc1hoWjI2cmpGdDFDeFpaNGs0?=
 =?utf-8?Q?k2VtjKoHh5M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5zayt4NmRUMGNqNjNCczR4MytNTE9IdithbWtQR0o0eStOT3VEYTAyNjJi?=
 =?utf-8?B?YjF6cnJvWFJHNWUvdzRWRU9RZlluTjR4M3pZT0VsdzNOV3Bpa2tzMkkxSzM2?=
 =?utf-8?B?azVtNkh3c3g0YTVUaXdvaHk3elN3YjFjNlNqcDlUNzVHTVRKVnpFbXBuNi9R?=
 =?utf-8?B?MGJyb2piZWplUjdhMHZaaDNybGM4UGRXUlphN0JVS0ZNbGpGSjUrSnp6MEZo?=
 =?utf-8?B?dHM3QkI5ZTFXQitQblB5QXdObTNpU1R0Vk5Ec1Uwc25IeFZ6eWtQY2ZNUGdy?=
 =?utf-8?B?OENGRm5kTjRWWi9qVEJtR0QwRmZiSEVhR0RaTEszWjcxL05tcndMN2VqZ0RS?=
 =?utf-8?B?aHBvL1Z3dnBsRWNQRjFiK0Y5Mm9sa1RDa3kxMXhtTkFuOS9oOENuUUZuM0V2?=
 =?utf-8?B?eFJ3cXhZWVZtS0lsZzY5Q3VNcGJtb3BXVE1HcVN3VHk3d1gyakw2eExTM1hT?=
 =?utf-8?B?ZDZwamNpRXp3QWVxb3FPMFlTclIvNklSZVFKYmNpUWM1c2RNNSs0MGdSbnJi?=
 =?utf-8?B?Qk10bjBLTXUyRENhMVhNS0xLMi91ZDlmOTJ6ZlBubHUvcVJ2RnNaZ1FvZVkv?=
 =?utf-8?B?bTE1Sm5idXNtSXArczR1WmhJeFN2a3ExaFl4MXp3aWl3OVVSbWNqRFEzNGRD?=
 =?utf-8?B?ZFVxY1VveVYxUlBvQkVqZlUvdXB1Qzl1anVGeW1KWjI1MEpQSjlpaTNxY1Z1?=
 =?utf-8?B?ZlMwTTZRTTNrZjhydUlyaVdVYkhMRS9GVzg1b1FGRVZPVGR0WWU2UG5RWVkw?=
 =?utf-8?B?VVJBWGU4Zzh6UmlWenlxZ2s2RjZyanBiMkpjUXBVZjZWWURNS0lEK2NKR3Jl?=
 =?utf-8?B?Q3Z6eDdQQ1lMbEpRdHVnMTR4YUNrYXFNWlpLelNpVWw4RjRyNndyNUJTUXRF?=
 =?utf-8?B?RHBCYmo3dEs4ejNSYlZ3cUZOUmZiS1ZIdklxV2ZQOURxaitDK09HcWFCb0RI?=
 =?utf-8?B?R1JSTmI4MW1jM2FtRFR2bFQ5STI1UklBY3hpN1dPTGYxNmYvOERUUlJkMlgx?=
 =?utf-8?B?NXpFc3BocFlLNHNuMGxsWk1VTTZGNkVUblpIUXY4QTBUbGdIL3crckJFVDJi?=
 =?utf-8?B?QnpmUTlQMldqZ2VvSzZHb0ZDZThPZTVLNGsxNHBJR0xVSG96bng3eGg0Z3F3?=
 =?utf-8?B?akM0eGNIREhXaFpLMFBwWEtITExBTGpSR00vaHpLTFJJMzBvNWtyZmllTUhJ?=
 =?utf-8?B?dHdpMFM0VjNpYUJVL0hHK1B6bUJwQWNrbHV5eTk1SC9KWWNSNnJJMlBCOEJq?=
 =?utf-8?B?K3B5QXlsRTdSOElhaGFzWU5hR3Y3dTJRT0ZMZmRCcmc2OTJscVVaUVAwT0Y3?=
 =?utf-8?B?WGRWRy9yTjhBRWxpWUt1aFY3T2Fhd1Z5ZFhibFR6c0VQZjlYZU01b3greWRj?=
 =?utf-8?B?SEszNUs0R3pTQmJDbmFEWmU2MG8vcHhMdW1qYmdxc0RySXFqUG8yaHFXTWJI?=
 =?utf-8?B?Wm9mQzdNdmFwdnNxekwrTzE3Slh5RW5uNTliVS9JMFFYa2k5c2lISitSLzV1?=
 =?utf-8?B?YkpJYkxCRkpHY3hHbUJYREZPTUFvVVVEcnRkaU1yVm1oOEgzaVpVN29LYnZW?=
 =?utf-8?B?dnpFbzh0OEpyRHVQNkdNSU1sQS81WTJKcFluUVVKSC9IVEFGNGt3aXQzMkw0?=
 =?utf-8?B?RGx2N3ZtNDdhYktxWUowTENFdDVYQjJQWWRBZUpzVWtjZUtNZWEranpoNDhJ?=
 =?utf-8?B?ZlN0dTZrbFdSbUZjaW9oWkhZZW9RbUY5US9kNFdSekxSblRXQ2M1OWxBY1Ny?=
 =?utf-8?B?Mm9NNXBxckxRbzQ1UldEVDMyNmVsZk1RMWZEeWRCR3NDVFdsaXpIZU5GeWtx?=
 =?utf-8?B?UnBPTmlhWTVjMkU4WGlla0kzSnh3aDlIbU43MU5PbDNjV3V4dUVIU3N4aGlU?=
 =?utf-8?B?YURWQndFZUZJdVRkWGh4YUoxYnpnNXRHelQ3dnBVa0xXeDBaOWpaY3pnOFpC?=
 =?utf-8?B?R0pKbTZmblZxSkROR09SMUh6Y0I5Y3BDZ2FHeTdDNVNkY0l3ZDZnYVZsb2hv?=
 =?utf-8?B?MVh6Q1lIbnhFNkNoODRnbjVma1FkakdnSTBkT2t3b09CcGFkNjZ3ejdCK1Q2?=
 =?utf-8?B?Z2ZhM282dXFMb1VMREl3NXpRb0JyVjVva2VEejNQOHBGRTNkazlyUWFNdHVy?=
 =?utf-8?Q?G4TPW+diw5bgz8pUFynmQ8nNB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d5c85c-649f-4a1f-01c2-08dd7669baa2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:51:03.2819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCO6bHqWX8RifYSL/8Bn1lny6leQmBIYQIcZSnNydKwRlUDaM4QU9rc/FKcrNLZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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



On 3/14/25 03:19, muhammad.hazim.izzat.zamri@altera.com wrote:
> From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
> 
> This patchset enable the capability to automatically perform
> FPGA configuration when booting Linux FIT image via bootm command.
> The FPGA configuration bitstream shall be packed within the
> FIT image.
> 
> Second patch is to add additional flag to check whether an FPGA
> driver is able to load a particular FPGA bitstream image.
> 
> Both patch have been tested and able to boot U-boot using
> debugger and QSPI boot.
> 
> Muhammad Hazim Izzat Zamri (2):
>    drivers: fpga: Add FPGA configuration during bootm for Intel SOCFPGA
>    drivers: fpga: Follow mainline to pass compatible flags to fpga_load
> 
>   drivers/fpga/altera.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> --
> 2.25.1
> 

Applied.
M
