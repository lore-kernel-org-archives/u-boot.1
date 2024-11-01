Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68055E67497
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 08:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A186C88DB2;
	Fri,  1 Nov 2024 09:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DDM7gVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6830788CEA; Fri,  1 Nov 2024 09:28:11 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586958924F
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 09:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS8Skfeku8MJCCDIQha0LJ/yzQnCS6n9uyrxma5w2QH4NVuBktNJM+8spA0WE7k1xOvaVLSV4BtO2FCbyLJtbYMixnzVx9r3k5y3XbhIY2BsCFFbakA/7KmvlYwaayJUwonzQ+ETHz/x0zotTAPe+exeLERoD2VWarIlrfXNJHJfIEgx7IZ0IN5EuWCCwMiwdJWJvj5rXwRZqJAgNjEkQYx6KwdkXWnLBBBR9bUYoha8AfqaMC5kRSgNL/GVaG5OTF5DeD7UvKfUVULHiUN85KSUNXL6f0I5hVZ2WwFmCFtQbrTDw/WXnMSP5OFl9XkftiJJVhR21/yWFYOP3t+hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEKEm2YIkl0xaGQOw3pvmHGGc5EiTk7KX+lGW4D8HRM=;
 b=ts517iAJW43hvRAuR/Pr6PlE0eLb7nO13rE3KegUtOk+ZX4UJrw139XI9r5TQOgx1HlkVzF6jQVBbWjsTstfMGYE0FPoyO4BBW49VVdn31Mt2ts1ZoFQF2oENoSqaAaJM7T6IHDlL0E0GL0WS7I5k+ctv5ldgS1IDduNSNswz1ojZiByyUtD3xq9XN4FrJfZAJwTz+OY0Gx09HQNsZzWzhLxzvI71HBfx6i5QlUtKtge+IBydLRlsSMe3iFjmBZtw4HtfyovF1+65fXvVGtFDLhhZTwfwF6INVmGfsa04l1VL/EUUzsdM2xjGO9oZ11cGzt/BVga/39PRilFZqVIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEKEm2YIkl0xaGQOw3pvmHGGc5EiTk7KX+lGW4D8HRM=;
 b=5DDM7gVKre+IM66uEvdbpvuI+WfehfsEdsgG59r7ZcDCgH9PI999/iougcSNMJyleZ8ZXy1X6CMSPsK/3kJSJHCG+6g1s7LUfgZbiaEA4mqn/YHCQeDuxcu1f6zFUVt49zd8OElIpoVD1zFAJoL/EDpylRbB9jHIiiXe1A31194=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Fri, 1 Nov 2024 08:28:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.035; Fri, 1 Nov 2024
 08:28:04 +0000
Message-ID: <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
Date: Fri, 1 Nov 2024 09:27:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com,
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0096.eurprd04.prod.outlook.com
 (2603:10a6:803:64::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f80649c-8db7-4811-2d28-08dcfa4f1afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFNiOVlEZkpMUFZPTWJ6VzFlbENnWXlyd3U5ZWcxWHd6ZVoxMTFKZ0NYNHlW?=
 =?utf-8?B?ai9NbHowRDVvVWV2SFZQdGtDYjFkdldpa01GWkhkUi9qdURtV1pZelpFT1p5?=
 =?utf-8?B?bnBET0V6SCtJSExDellTK3FyWGFvNjFRM2g0R3RWWnc4RVh1c3lnWmZlMVow?=
 =?utf-8?B?QkhIY0N6NFJxRVVMeG9OdHBGaVFuWlhkQVkvbG5jRmVZM24xQTIrSGZYVHIx?=
 =?utf-8?B?anZreXdzQXFiL0YwOUI0K3FpM0gyMlRud0MrUFBvTmdrRFVjS2dybXp3ZGlS?=
 =?utf-8?B?RlQ1ckVEQWRCd1hYMVo5K2VPQ3o5OGdMODQyUUlpVkZraHp6Ri9WTUgyWUFT?=
 =?utf-8?B?WUczNkdhaFZDS1c5cEhVTFg1THdqWUM5WGU2Q3FtSjk5VWw0RTVzYnZsZGZC?=
 =?utf-8?B?RHRRYWkxWFZrM3c5VVBXSjFxaVBPV0czZFU3c0JJdmt2VmdpeTBEWDNrY1Mw?=
 =?utf-8?B?bXFMb0dQVWkxMlNsR1BwQ2NpM2YwS1lXTVIzUVpBRm1NNGsrRVpaTjNSV2ZS?=
 =?utf-8?B?c0FMUTNpRkpoYXIzbGw5R0RhWUcwamJMMVdMZWJOWUI5U3d1bkxFREJkcmRE?=
 =?utf-8?B?NkdHOGtpdzBpbEZ3Um1SV0hkbEhGQS8vMXRFaXRwRmZzczVRS1l6OTJadTJ6?=
 =?utf-8?B?eFJ6dndkZzF6eW1NdEE1MW8ydGVWUDZmaEpQenBySFNHblB0M0VNNldETHY0?=
 =?utf-8?B?UkJIVDY3K09lVzNTcW9rNDlGc09sV3NPYkFxU01adWFLUnhETUNhdUtXSEgr?=
 =?utf-8?B?YWIxN2R1MU5GWlBnTlRhd0U1MFpFdFlBZGhISG5PYy9ZbHVNUkZXTnJrYjBs?=
 =?utf-8?B?LzQwbDdqTHhVNHZVSjNGR2xCNm1iYVp5K2l1aXBQYnhVdDBDd0lIZktSRXAv?=
 =?utf-8?B?c2E0MmF0UnVQMEdoS1BHQ3RqUEdadEVKTHA0bU5HWEZkVkFmOHJRREE0czNk?=
 =?utf-8?B?ckNvR2l0UC9DQXk4VnlXcmhXajRsTzZ1UEx2c3JyaHRaQjNpS3dGcllFM1hy?=
 =?utf-8?B?R3VRcytTMWRTd1p4SkVMejNpZmp1OFZsNDVYZVNxVmo4ZE4xR1NUdXNnZHA3?=
 =?utf-8?B?YTlpbWNoaExjZ3pxWGx4SElYeEpPZ214NGpBNTJUVVNIMnJIQ0NqM3QxeXlL?=
 =?utf-8?B?dGJINDNCcVhsSXU3UjdvRlhpWmRiZzBpdWoxQ1RKZkpabEsyVVQrWE5Ed2Jj?=
 =?utf-8?B?UlZZeGs0SnUzM0Q2R1JUdlM1WmxBRzZuRzlGaGRqb2dQMmF1RldsRm5Ibm5O?=
 =?utf-8?B?YVJDRzZnMFVuM0JockFEZWNvYkJrNUdDSldMTy9JSlJrSFRjQjJmVjkrZmVo?=
 =?utf-8?B?aVY4OVJ1Y2w0YWttdThoSGovKzJuUno3dkdWODJSTFpIUmJ2QkZqSnFKMjBl?=
 =?utf-8?B?UkdZK2YwQjlacDNBc0gwR0xIQzdHT3NiTmtUbzNEeWo4a3VNUFpzeTZZQXdM?=
 =?utf-8?B?S1RZOWhLcUUxV1ZZblBwZXBxM0JCVi9acE9ZSFBqWjRabyszQzN4ZjJkTnBs?=
 =?utf-8?B?MGl2bEx6UXZtYUVzWmJXL3BxK1NZRTgzNHpsbWF1T1lyRklXdmdnUlJEdGw5?=
 =?utf-8?B?VUt3NWlsc2d1WDhnNXpIelh0WURJaTZKVDJkN3p1WkRKZzJ4TXhwZkthdlQ4?=
 =?utf-8?B?TDBQTUtBTVBlT2p5U0hNOFNkbVhiQU9tWExZS1pQTENpSllUOTF2bEVOU2Jl?=
 =?utf-8?B?bDIyenpwVC82SjJ5WmljTmdTU1ZiRGpiOGtQbktzR1lTOFpDWUZRY1NNaTJC?=
 =?utf-8?Q?5IzoEU4GE+hFKRsUbjApI6b+RHZH69AOlC5KmKr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhRQmZuNUZ1V2xnWEMraWo0V0FGdDFSSG9oZFVka2ZKaUtpZk40UytXUUo1?=
 =?utf-8?B?TnBjcWJ4QXBQNjRLYmVoQzVZRVlWRXZMaVdocjVJVTBHWk1MOFFYaXdaN1g1?=
 =?utf-8?B?SnR2TjdCRFU5cXB3aWU0THYrS1V6UGdMYmVDNk9pdnF4QVhDQStDYjBKR2lH?=
 =?utf-8?B?WitLUmw2QVQ5T215YnN2eVd0WGc0SUNMZzJ2am1qbEcyUFVXUG8vZkdYQXdW?=
 =?utf-8?B?TlM1SlBhaEpJdVplZmtHb21BN3hRQU12Z0xpTGR5TzBQak1FeXl4aGpSMW1H?=
 =?utf-8?B?UEVmdGJaN3h1aE9XNEhiM1hwdFB6TlBIbXFOcFFOK1pDUWU0TUV4MGdzL0FF?=
 =?utf-8?B?aDhPajh1SG40UnRJc1M3YXBva3FzUE1WOHRBbXlKMkRmc1dpRFRYVko3WTF5?=
 =?utf-8?B?VERwbUVDajZIbHFwTkJEV0tVSXR2NHhjSk1xZnI2M055cHl1WGdtSitHdnpQ?=
 =?utf-8?B?QWp6OVpTajdsSm90clJObU9JOHFVSHBtbGJFUDNQUVhydUNtbHVDOCtEc1Qw?=
 =?utf-8?B?blZ2VElLaHJpdWtjbENOd1lqUWNoL3JOZVRmc2JQQlZhcXFGRHNrY0FsbmN0?=
 =?utf-8?B?VFYxZWlWSHB1MnVyc2JKTXRlT1BkZkZVOGFnbUtJUzlXNG1wdGNDS3ZMOExT?=
 =?utf-8?B?QkJ0VmNwQzcyc2VYdXFWeDYwV2ZDdUlESFpPQUFOenVCakVjcEsxUWlpc3JR?=
 =?utf-8?B?SE9MUWU1SC9jSmNETlhranAzWW5IYU9ObFM3Tm1LOHVlMjk5MVA4S3FvR1h1?=
 =?utf-8?B?STFTaU9JNkxQL0l2bGFtV0hwWUdGN3p6VS9LZUQwU0tNd3VKS2xpWTJSQXdJ?=
 =?utf-8?B?dkdBbDBCOTgyL09OdlB6Szk2VTNPa2hJRzNVNngwUGNjTWRncjFieGtYb0tt?=
 =?utf-8?B?bVVENXVsL1NBR2hJUDFjVmRZenRuOWJZYko3MlpibHBRdVl2M2l6dlZVZXNQ?=
 =?utf-8?B?QnlJUVRtS2JXdlZ5cWhOM3NhS2RNdUpwa2doRGk4VGp0Y3hLZUtkazJwcWU5?=
 =?utf-8?B?VUtuU1g5MHg3eFRMKzRyN3NSQityOHdic084VGFKUnNvNTUyQ0pBUFpXUFFS?=
 =?utf-8?B?dkVmSmxybGZzd2FYQ0R5NklVNUwyT0VBTG9HWXBKRWE2dHlPOGs1RjlKNDhV?=
 =?utf-8?B?UHJoOHp1WlZsc3Z5bmc2S1FZYTNNcnIrNU9VUlo1V2xSSWtadjlEN0hxeERu?=
 =?utf-8?B?UzhDdHdqV3ZOZkl4MEQ0MkRRcnRtUU1LQ25zd05uS1dxc2NJZC84cDhheDE3?=
 =?utf-8?B?LytQNTdqeGdBbW5adFduYzlObnBaVWtoRi9FWTdLRm1EOVpUMFg1NXN4Si9t?=
 =?utf-8?B?WmMzaWFwY1dxR2RjOS9hbXpxMVVYY1R2TkRrRVQ0NS9zV2piNmlpcmJLOXlB?=
 =?utf-8?B?Uk5JUWxjdmdZTThsaVB0T21aUjNqalljVUExRVBldFlmWkNZUTZtanF1bWxs?=
 =?utf-8?B?NEpnY2NOSVA2bGlNaCs5eUdLRTlMS2ZaK3lzODZOekcrcjJkbVovb2h0OFdY?=
 =?utf-8?B?ZUFwUHVweGdJNk1SeGdvYm5mSDBKWmd4TTY4SHFYRDNSRjVCd0pNSWtMaVhK?=
 =?utf-8?B?RmFUUE5COURDY2pYODZqRllUYUZ2Zlg3VjFMaHh2aUVpNlgrWEpHaVo4Y3Vs?=
 =?utf-8?B?b0xDMnJ4OUh0STAwVm5vWlYwRkZsT295NjhTdzgwS3BlZmd2L0Z3bnZ6WTJH?=
 =?utf-8?B?OVRUcmpCaGk4Q3QxTEZIZDl5SzNiUVdSMVZDamh1N1JQSU0wQ1AyeDZUR2E0?=
 =?utf-8?B?MDlqeVkwbzRUdm9SUnF5SVVPanN5NWQ3bGZCVkM3VmQ0bS9ROVI3RForU2I2?=
 =?utf-8?B?SFptOGgwMFVMNDd1TmE0SGV3MlZ5RXpSU0p2SkRveUZiaS9ybzlMMVZubi9s?=
 =?utf-8?B?Ynp4NFR6bHZNM1JqNmFDRE1oR20vbEVLbzVnOUViNjNMLzFBYkIrMHZyRGUy?=
 =?utf-8?B?bllGc1V6cVRIaHhjNy9UTVExS2R6cUNBdkl1SmxidFQ2cEczSXRxOWRSTUFp?=
 =?utf-8?B?NU01c29ndTIzN2FadDh1YmJDbXBiRlFQbGpVeDJjOUJZbThsdk1YTzg5Vjhx?=
 =?utf-8?B?MlZPMFQyOXVjSFNFdXh3cFVSZ0ttRHpXUVFVejlpOU5VbXdOYnBYa1lkY3ph?=
 =?utf-8?Q?VZNBrT1A++b3/WrQSJM5lgZY2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f80649c-8db7-4811-2d28-08dcfa4f1afd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:28:04.4641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs0SxFrjEfzAMztYE48HNd93ArBvFx9A+Xt5CnhoQoFWM/mwrW1jUIJ4x4fkjDAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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



On 10/31/24 19:03, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
>>
>> There is necessary to do some steps to compose boot images. These steps
>> were in scripts in layers for a while. That's why introduce description via
>> binman to simplify wiring and remove all scripting around.
>> This should make sure that everybody is up2date with the latest versions.
>>
>> The first step is to create fit image with DTBs with descriptions in
>> configuration node which is written as regular expression to match all SOM
>> versions.
>> Description is there for k24 and k26 in spite of low level psu_init
>> configuration is different. The reason is that it goes to u-boot.itb image
>> which is the same for k24 and k26.
>> u-boot.itb is another image which is generated. It is normally generated
>> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
>> be deprecated.
>> FIT image by purpose is using 64bit addresses to have default option to
>> move images to high DDR (above 4GB). TF-A and TEE are optional components
>> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
>> by some configurations too.
>>
>> 3rd generated image is boot.bin with updated user field which contains
>> version number. This image can be used with updated Image Selector
>> which supports A/B update mechanisms with rollback protection.
>>
>> 4th image is image.bin which binary file which contains boot.bin and
>> u-boot.itb together and can be programmed via origin Image Selector.
>> This image can be also used for creating one capsule which contains both
>> boot images (in SPL boot flow).
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Currently I have this for testing purpose only to find missing bits and
>> pieces in binman for cases I want to support.
>>
>> This patch depends on
>> https://lore.kernel.org/r/fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
>>
>> ---
>>   arch/arm/dts/Makefile                |   1 +
>>   arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
>>   arch/arm/mach-zynqmp/Kconfig         |  17 ++
>>   configs/xilinx_zynqmp_kria_defconfig |   2 +
>>   4 files changed, 244 insertions(+)
>>   create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
> 
> I'm pleased to see this. My only suggestion is to use '/bits/ 64'
> instead of the macros, for 64-bit values.

When I was playing with it some time ago it didn't work but it works now that's 
why no issue with it.

Thanks,
Michal

