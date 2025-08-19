Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21332CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FBF80FA1;
	Tue, 19 Aug 2025 10:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JwhNccY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1A380FA1; Tue, 19 Aug 2025 10:44:27 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7C1802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXDpEo7Dqo9PKFmWUsuCLDipCZWlCg5cs004t0r4duPWvtHiSJ8j8Aa2e27hAlbWirV8vFvoCErHzTrimD98fDeNYoNoS2MKSdecr4Sp0qogJxt9+xfwodq874iB09G6Yo1omJXKWmoiSgorCgmaaXvC0jcujyYGr2f9AYZbQ/CfjTZav5DdizGiIxiq6/2a3S4Rn5rAOZtaELsCglHxN4ByB94Y8LQJ95odS2ghF9D4+Htzu0DzqkUo2+vlBE14bw4Pc2LGUtsrW3zFDy2FtcZs/yj/SXzbcLhYoCAKtalbdKdmp1l9wH6Z8h7O79nVaL6NOPqNdLZ2ip5aveZrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4ph467/f7D4kuDPgVOlWZi0y7XcSxo+3Fn4G3tk+h4=;
 b=iRBNKmWyA5RHS8bFqL6zvv0XAKrJb6VaES8tK4X9nAnP2cnY4rD10p4Pa/wcc9KCT/ba9wcMfIAWSHmgFDZ0KloMFLVIVGLwhbNciNN8+Nqc40hAiCLvfVZ/PQ/gdQA0mwX16ZGZDe5MRnpxARUFaAPJx750NfJadgu2Lib+RvQzjxPVPD1Pry18m+uswhrGr2SuqLvApNg2dCKznC1yM9FxNEhtuezFU36REyhLqH1wOR4Cl/tUvS8lH1m3pGe7ne23+gdx1waJPF0ODsPJ35OW1dweNLfv7RJTb501by1/bw3eLWMfFKuVeoe+JwstUIgF/NWI9Z8u5u3VJLwSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4ph467/f7D4kuDPgVOlWZi0y7XcSxo+3Fn4G3tk+h4=;
 b=JwhNccY7VtnviChdRx+rSCMAJ9E/ul/d4F8Ot+IpV66zb8Tz7k9i4SIWPsioAV6kMIK+q617bgphKVDcqwjXdw6lWAGKf8SoVaA91n6pvQEwflya7rZ8CC31CXe5KZZrz8pgfFgw99cubaheWmiKnpKw+SAScoaj9yity4DcJGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 08:44:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:44:20 +0000
Message-ID: <3a17ee85-a464-4308-9d11-17638b6461d5@amd.com>
Date: Tue, 19 Aug 2025 10:44:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Define BOOTENV_DEV_SHARED_XSPI when
 distro is disabled
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <4c195468c0341ddd2aca98f83cdcbd40117cc9ee.1753885919.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <4c195468c0341ddd2aca98f83cdcbd40117cc9ee.1753885919.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dee034e-e458-4f02-9db2-08dddefc9706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUppdnUrZEdrNFpjd2YyVXF1by9Ec0xpN2IxM2pZSnVuRHFiOERlYW0rdDU3?=
 =?utf-8?B?T0I1Zk10SEc4SCtJNEJOVURLSTlqeE9MSGpOME02MGphckViQkd6M1BrM3VK?=
 =?utf-8?B?NXNCZzE5NTA4M3h3NldsamlPaWRVanJ5TkEvMHkzamoxYVdwZEt0Smk1ZkFu?=
 =?utf-8?B?Q3IzNmNqTFhXUm5vc3k1ajNaekY0VS9Oc3VGamVSV2VvRUkrQ3BNZGZLTGkx?=
 =?utf-8?B?dkJIUzEweHIrSEp6TTZlR29zSXQzZHFqV3ozOFZoRXJwcXlIWGUzZm9jY2Vx?=
 =?utf-8?B?SnM0VmdkSlB1MUdPM2VWZ2hTZEo2TlFYaU42ODN2WGtUL29xQmR6TVRRTzB0?=
 =?utf-8?B?UGkyUEU2WTJXTGFIM2NZVE5IMFpVS1I5ZmFJWnF2Nk5LdkU2Vzc0R0g5anVL?=
 =?utf-8?B?OStHVllmZzRha2JzalQxUzdITUJWTVJ4WUJKc0hPUDNKMXYxKzVjUjdLVGcx?=
 =?utf-8?B?QStJYU51SEFkK1RNRjM5dHRsdU1Bbm5PNHBwZ0UvKytJOGdoTW9FQzdTUThG?=
 =?utf-8?B?L1ZLcWlIQ005QWdzS0xFbWNCZTU0Mlh3UmFjM3NMVU5vWEV6dkN2Nkx2d21D?=
 =?utf-8?B?elJST1psSWVKczlmYlI4WXp0WDhjNkt2blcycGx3enUyYjJ6N2o1L0VIOHFH?=
 =?utf-8?B?cVdkbTRSUVV3TkhRa0xFam90NldIdEZTS1FMangwbDdRV2lZUHdqZHRJMnpQ?=
 =?utf-8?B?Wjh5TkNqMVNMcGpvajZBem05dmszd094M0Y0ZU83R1VQZmwwRTkyYzE4TUt5?=
 =?utf-8?B?RTBVQ3pSOU16US8rMFdNaHFxVndtTkx3RTBqRTVjbmpTSG1PbjczMXhwQ3M0?=
 =?utf-8?B?SndCMTBEM2RaOXdPejRmY3c4L0tHM2gzbmRNb0tBV3cxc1BYalhYMFJCRVdm?=
 =?utf-8?B?RVRxRjZFRzVOeVVCS2c2R2ZweEJpYjRmWUR3WTgxL1dRZy9oSnArcGUyMEUw?=
 =?utf-8?B?NStoQmR5cDBzUTk5NVRkRURWNWZMZUxhZEpkRWJRNG1GVXNBdHVzYi9mdmQw?=
 =?utf-8?B?dlU2a01vdlR0bXhWaDc2Q0RTV25Sa3VYdDRNbGZXZW10WXoxSFplS3VHRjFz?=
 =?utf-8?B?RUltNTNiNEY2akNPUGtvUTNLMStUN3JBZi9WVGlDQnBkUGNaQ0V3QzBUZmZz?=
 =?utf-8?B?U2hUaUorb29FTTlJdzhsL1BsRTVKRlhWV0xMaHZWZFJxZTlMbmZPV0FSaTFB?=
 =?utf-8?B?S1pyajRKR0NaVk5IeTZCTHdycnhSM3dodFN4a3RES3pVRVlDUHN2ZHJoTmxu?=
 =?utf-8?B?VzlhQ3JXamk1NXZKd3Q3KzJiUGdrdlJmMTlXVUhDUTFEVEViNGl6Tmt5REZh?=
 =?utf-8?B?Ym9QR1VTUnZML3VIdTI2aU5qYllRSEN5ZlJNbXIxUFpobjNaU1lieGxVQ2la?=
 =?utf-8?B?ZG8rdWxPUzZEbnphL1p0THpSajVJcHJjaGxDbXd5QWZZNWNaamNSN0JERU9s?=
 =?utf-8?B?WDVrRk1sT0kvVXVTR2p6dkZ6NG1jSGVlRHhGRnpPVnMwd0hHSDFBWE05bUo4?=
 =?utf-8?B?dFFjY0hTN083Ymp4UlRPVVdrUzVySFkzTVlveTBTajJzS0IrUzN3cXVJMEdF?=
 =?utf-8?B?RURYRVdIemJTa2lUR3VROENwODBxUlZMZ3g4LzcwTlg2Wjh1RnQvRURDalpR?=
 =?utf-8?B?Sk95S2hYd2NqNFJsVWhDOUdobW9kelJCNFg2cGthNE5rNTF1clRXem93K3ZP?=
 =?utf-8?B?MWRKMXM3NXB5eGV1M0J0RWM3NldFZFFSSURsaGhDVlRMTStabjBOdU9FNXhm?=
 =?utf-8?B?VklzdlBRN2ZmVjVsYVV1eml2QjdlWCsrTDc5QlUyand4dE9iUXpmelN0UmdG?=
 =?utf-8?B?MEJoY0dRQ2huR1FyMHJ2RDh4am1qQUFIODhGc2oxeTYyZnBSRkNRWVdWMWRM?=
 =?utf-8?B?OUlzUDBrMEJ5QTJQU2JzREJxcmMrS2trMmNJbW03L0RzMVg5VTdSelFLaDJt?=
 =?utf-8?Q?41C+c8U+ESQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFloeUJUTlZiTzBkRE5VSnljRERnMkFKVjFibXZSRXM5ZWlBRjBNTkxYcjhi?=
 =?utf-8?B?ZC9QTDZ3cW5xczlOTjl5ZGpYK2JXVkkzR0ZtTzYzNVU4a2JIQ0pNTlBxbDAr?=
 =?utf-8?B?S0xKaVMwcUF0ZmRvc2RRYTNjQXVXVUs2MTZ4YVl4Zk9vUDAzUDdHUE1iMU04?=
 =?utf-8?B?Nm14Njl6SC9oMDJZNG5aZ1JuQnIxeThzVk9JWmpBU2h3RHdQWFZucUNzVXlz?=
 =?utf-8?B?UFcyNllET2NaK3lUMDRpWW9SY3hLT3NhQkVqNDhWUC9GM005Y0VTSktNK3JE?=
 =?utf-8?B?bjIyRy9Xc1hPWHYyaE5xTktTQzg1NVQ5UGNtbmVKY3orcFh5OHhCd1VvcWg0?=
 =?utf-8?B?RXNGaklPZFBaZ1Zjd0haK2g4Mm9sZTIxakJmRUQ0aXBKazc1OFFjZGtwNGlh?=
 =?utf-8?B?Z2ZFcVdvTk1Hak5HS1NuRVNSWStYb2ZDemordzVHTEdJby9JYVNFdm15aTE4?=
 =?utf-8?B?aFh3Y3BqbXhsNGtQWjdRUzVRQXNmVGZGbGZMaXBteGJoaThzV3JERERyS0sr?=
 =?utf-8?B?bWRrbmgzQVBIT25rdnhQNXR0bTh4WnBjT2gydGNyNHczRlBNVTRoNldhMHor?=
 =?utf-8?B?c0xaWTM5SldhZjJaajN6VFlpZmlCODI0TVlHRldBaW1OVlRrZnREM1l1QXo2?=
 =?utf-8?B?b0thM0paODhvcDBNaHFGSDFQYzZWckR1VytjamxIcW94ODNTMFExalR4V1Rs?=
 =?utf-8?B?eEo5VFhOc3hQK2dpQjVsMG9BMG9QSytVcXUwY3VjR1ovbWlKdFlKVVZXMjJ1?=
 =?utf-8?B?N3dEbGVTdnFyR29LQXlDWVcrYzhyR1laUWQ1bUN5N3BiM1I5TE10dFBnS3JI?=
 =?utf-8?B?aTZ6S0IwUDFTZFFuTjJwWURjZFhIMUJxaXp2TDZ2Ti8xRTliTGRiZWtESGZD?=
 =?utf-8?B?SUNnSTYxRW9VTUxZYWd4NzViVmloeU01c1ZhZ3BsVGs5eHRveWJMMzNSM0dq?=
 =?utf-8?B?T2o4ZUhxSTMrRk1DTkQ5NEY3bmJmeHg1bDduUkJ4Wmdtd0g5aHZnSWhQT1kx?=
 =?utf-8?B?eks2Y1NXNzJFN0RDNXJnaWJzSE5JbDA3Y0l3UG12bCtteHB5WUx3NlN1a3l0?=
 =?utf-8?B?aTdaVllsTzllNmwwUWtaQisxd3FGaURoQWdkeUdvb2RubzhxSkJyakZxc1hR?=
 =?utf-8?B?d2pxT0ZKZ05XMkFKNjJrem1NOVg0VlJpUVJtOUlnR1Z2K1BGSTlBU1VidC91?=
 =?utf-8?B?Vkk0V2hVemRxaUExU1hxb1g0OW9sUjFja3FYa0tuVEZtbTVOLzBpdGc0MW1o?=
 =?utf-8?B?VmJDTU45eG4wMHFMTEdkTEFPdVllN3BrbDJzUmJ0RSs4VkJEbjlQdmg2cmpz?=
 =?utf-8?B?QjE0UmZLNW9RRmUrQ3AwdlBsTzI4cW5YdDZaMWVEdXZTN2hJelBETmt2UzRO?=
 =?utf-8?B?TTJlVVpLUjJMcVpxUW1HR21BelB1dElsdkFlbkhyL0lWRkJIU00xYVBzbkhS?=
 =?utf-8?B?ZHBycUYwdnlUNlh6VE5CbzY3K1kxRXY1YUZHOWc5ZU5KYWIyT3J1Y1h0ZDNX?=
 =?utf-8?B?OTBkQzJWWXdaUHhMV1FiSitOcS8ydzlyc2hsc0Y3c1Z6UjNBMlF1c0RIUWNW?=
 =?utf-8?B?UEt2Tk9EcWhSRks1LzRURlIrQVJwYzlTQk1oUWJ1TGdRRGFpTTZHWlFhTkNo?=
 =?utf-8?B?NE45Y0sySGhKUDJ1WXB2YzR4d0h4RVNpTVF1eXI0aUY1cmVFRTB0U1VKeksw?=
 =?utf-8?B?ZGZ1dUZyNkZaNDJPb1pDZnZMNmdhTGpQdzF2WjF2dmRQNDJmVEEvd3p5QVpH?=
 =?utf-8?B?c1VRWTFZRDlKemFzVmxxNzBodjJqblkvbTJLQUpDVk8waEFkbzV1MDhlSXc5?=
 =?utf-8?B?Nko0ZDBROE5UcUllRGlOSkdaUldmd1p5VzRwMVl5cXRpWkNaRnRJZGY5NER1?=
 =?utf-8?B?L1E1UGNiNHVMMG1MNjc3RW9kVkJqM3B3MXZkcGpLaC9xYUoxYU9TVFEvMkNk?=
 =?utf-8?B?bGdvV1lwZ0R0MjVLV3YrK3F0djgxT0dsSExTa2ZVZWtyWDdLK1QwcnJya3F5?=
 =?utf-8?B?UjlhbzBjMkVrWVBSRHlFMWtrRlZtK3huU3F3ME1mQXF2SXZpRFk5citOMXA1?=
 =?utf-8?B?Y1JLeU1sWno1TnlNTVdHOHFuaSs2WWpCTHdmOFJqQ2hrdlExcUgybGJXMERU?=
 =?utf-8?Q?pmeWi4wFhmgAQn9rwpWY2LMtx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dee034e-e458-4f02-9db2-08dddefc9706
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:44:20.4493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaZcWrmfoJ6wA0N88Cy2vgd0n0cz0IJP8jGJVv0HxHRfmuEtR0pUikEwxOmW9svw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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



On 7/30/25 16:32, Michal Simek wrote:
> When DISTRO_DEFAULT is disabled there is missing empty
> BOOTENV_DEV_SHARED_XSPI macro defined.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/amd_versal2.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
> index 1ade6adfa0bc..bd52e5a895f1 100644
> --- a/include/configs/amd_versal2.h
> +++ b/include/configs/amd_versal2.h
> @@ -145,6 +145,7 @@
>   
>   #else /* CONFIG_DISTRO_DEFAULTS */
>   # define BOOTENV
> +# define BOOTENV_DEV_SHARED_XSPI
>   #endif /* CONFIG_DISTRO_DEFAULTS */
>   
>   /* Initial environment variables */

Applied.
M
