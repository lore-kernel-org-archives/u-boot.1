Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA7DC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 10:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFA580FF7;
	Sun, 30 Mar 2025 12:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j5R5kDnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA51A8129B; Sun, 30 Mar 2025 12:40:58 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4742D8003E
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeSnijr0s3WEOmspRF0rhXuDuSspysI6l0Dr4YcdDCj9Cjzc94FbqWU3ZqZHCg3HGHw/qYr9V6Nf1BiWudylD/UbK2aEs42TYLgEuXwWduTZQ/iV/Sw8bpJ7k0VCyF43koaUPHQcsbkfZJwpCw2mSQz6rhsOxybUB0vfRE3yVK52ooJkETlZOX4DV1ykI4Om6BbBz0WtGBBSAvqoa57EPh2IekzTsfbXYwKERzP7iFbnPknFCv64jxoU7XEwc3yrOQfQ06+55Mes/fiS8C4dpXbeW96qpBfe+QrJLQwhqh32r02Vj5EpdVfOKjjz+kdk3WlXUrTWJ4vMNR0S83DIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm01sHlatxZjggdeSMtkbDkcJAchcdQlTO+WJ/VYIPU=;
 b=n2NDQiJdBL0GVlUn5ccQyqxhSJa8pw2o8uXOdWfaSR9PRKNefh5ZD+DU1dxD72t391uKuAdb2IDZx/tQoUD+0tNs68OfRYs+TSM+a7uXCAJ8lloY50/Mw6EYeCVDYAH10e4GE17ZjwPoMOEFzdLRRk34ns9qPNYKNTTzawqFaKqMcFPQDSnPc8XvnwhzpGl9EpXwFNHr2G6zFnq1uQURyVbVn/8wOggUulFLSwbQbbrB+hdbkxvWGxrwSsgYc7thSFo5oBAYLVXuUY/nkUG2RNhu6XlsPrWPSKsnBCZUObLeAle3C9aHDyrI0fkmDhFsHP6TwPMMuxufQM0a/N9f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm01sHlatxZjggdeSMtkbDkcJAchcdQlTO+WJ/VYIPU=;
 b=j5R5kDntAj/LGfNsusDxtMqf8uH0D0Z3NAF0u+ESfhl80nYMOW3PXbR7+TCP9ahUXiAXZA73e6P++ikZISzhOVqeEWutW+fUazOyIa1o0z4y8au+NF8OjpCqeWOLejIQ0HmueGOJVjNe8NrUORGFvNxZEMsECduogjvN+xjqLJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Sun, 30 Mar
 2025 10:40:50 +0000
Received: from BL3PR12MB6522.namprd12.prod.outlook.com
 ([fe80::3c2c:3c11:234:fef5]) by BL3PR12MB6522.namprd12.prod.outlook.com
 ([fe80::3c2c:3c11:234:fef5%5]) with mapi id 15.20.8534.048; Sun, 30 Mar 2025
 10:40:50 +0000
Message-ID: <4523d02c-bfca-4d75-b643-05cae8850a65@amd.com>
Date: Sun, 30 Mar 2025 16:10:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: memtest: Fix test for non-trivial parameters
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, michal Simek <michal.simek@amd.com>
References: <20250328163037.24594-1-andrew.goodbody@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250328163037.24594-1-andrew.goodbody@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To BL3PR12MB6522.namprd12.prod.outlook.com
 (2603:10b6:208:3be::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6522:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: cda0336b-516e-4a70-5a50-08dd6f775692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0tjb29POWJHaXFTSTllem0yZjJCNFp6cldKeVZ3bmNpSWRMQzZNZ05vRTZs?=
 =?utf-8?B?M1kwSXplVFdXMWd4Q0FtSGh1Q3orNHRoSVRkV1FWbHozYk1MTkw4RzBIbEs2?=
 =?utf-8?B?SGNIV3ByQzA1eEIzUTZ5S0tCTEkrNy9MaEJKUnpQMXNJMWhPdDFPNmxyM0Y1?=
 =?utf-8?B?VDc0K2ZMN2d2OXNlMXpPSjFTQjlhcGtMT0NmdmEzVXlPNHNaUTdCZElJQjRK?=
 =?utf-8?B?ajIwck11VHp1K1JHQkNpd3dOTzJSNGF2cVFjbU8vMUM3K2c0SWE5WUN4NkFh?=
 =?utf-8?B?eE1DNmpLL3NIRlJzMUNDNTBrWmpMN3VhV21VKytWcmxzbG9TbTN1T01VUDE2?=
 =?utf-8?B?dEh0SG1uQnp5TVovbVFYLzdDR205ZG9hVWhSRlBEVFBoK0RZVUU1aU9wSmg2?=
 =?utf-8?B?emkra3dPQk55RmpDdllvTXlHOXBZUzZBTWZqbUhXNVhmU0tuRnNCRTNiNTZV?=
 =?utf-8?B?SVZoalFEMVNtY0JFR3V2cXFDakRvR2ZJYytVZEdkMWZhcDFhb3J3bCtrWEVE?=
 =?utf-8?B?L0xUVmk3SEVZcXBWbjRDZGNvT1hDSCtVMUVza0FpbCtGQjJKblZ3dTVoK3dl?=
 =?utf-8?B?S1RuN1VRcnd5MlEvbHo0WWUvOG1EWUU2MklIS1VIL0NtU3h6cE9sYyttMkVE?=
 =?utf-8?B?Tks3Vm83clJXNUVGMXhtNkZKdDB0OXpodkhZeWkzSEJ3VDlBdDNiYWJEbUM0?=
 =?utf-8?B?aVZ0MFA0YUN1ZGdjem1ZbDZ0bmgyM3dTdlY5VXZtWVNaVmRUejc0VTRmU2dD?=
 =?utf-8?B?TmxPbmtEN2tteUZRRWJTQmVtOTg1ZWtCZ1lYUmFwSEhLNDI1aTZJL3lFKzZo?=
 =?utf-8?B?STkzaUhHbEhPWExzMCtXTHJBOVgxdjhZdEFidDlnOGhwdGZqTWNPb1Z6YllR?=
 =?utf-8?B?enFzbEdiYWQ2LytQenN3c2h3OXZvV2FMaTM5NWxQOWM1WHkzWXRLMW93Vzdy?=
 =?utf-8?B?WmxSVHVlREo5N3pDMHpLdlJkQWVtWkM1Z2FJTmEwbC9sMGE5cGUwZk1GUFF4?=
 =?utf-8?B?UjVzYXdzN3Z2UnRxU1dwZXVuSTFxYXliQTBjY1BGVjFGcCt1RzIxeFRJVzFU?=
 =?utf-8?B?VW1wQnQ3dGZwMnVQZzZrb3J5VzNtR3hyZ0sxS2N0aEFjVHo2QWRUdytCRGZq?=
 =?utf-8?B?bHlvMnpaeVQ1Q0xRbWN0anY2Z1hNM3dpWmxaSDhONlAyZ01YVkdtUkFpaUZQ?=
 =?utf-8?B?RGhiaG16Q09ESVhlZUg4VHVWQ3paRUZpbWIyMUNYN1JueERwZmx0SDNQV3pV?=
 =?utf-8?B?OW84WU1RanYvSWdIbzZMaU44aEFsWWhCUnFQZllRc1RlNWlpVVhLYlkwVmk3?=
 =?utf-8?B?WVRzQ3RwQzh6SE5KUFBYTnB0ajdTSHFTcHQ4aGR6c0hKL1JKTnp0TkxRMG81?=
 =?utf-8?B?TXp0NUdTZlRsNzBzMkNyYUFSTmZzb0lmZHQxdXZuK25CbU9rYjQ2NkFJMWFs?=
 =?utf-8?B?eGxjaUxMb0l3Vm9DMnh4MkxFMUZFMm1NaFMzU01odldqRE94RzhKL3pKanRS?=
 =?utf-8?B?M2xEZFREYkxhZ0xNQWo1WVFXR3BWMkJadHRuL3NQQ08vTzBYZjMwaTM3bnFQ?=
 =?utf-8?B?c3UwcEg0cE9LajUyT1pXM25vNk1tdkxuRHlvS1o0TVBEV3h2Q3h3SGJ6Ullj?=
 =?utf-8?B?Y1ZJTVdhM0g5U0I5WVpjNUlTWFN6VEJxUUpGd2w3TDNtVjVicEtlcXNYOXdH?=
 =?utf-8?B?ZGZXenU4b1NPVXYyeTM2NHpvNW44UnRnL01LemdjYWIxejd5VU12OUh1L1F4?=
 =?utf-8?B?cHdwa3U4VkFjYXh4UlZrbXpNSFhWb3R1K3FWTk84YlRaQThWUlZkdHFZZVNl?=
 =?utf-8?B?clpFeWFCSFJZWlN5dW5KdjhTVldmSXBleWxOc3R4ZW5tNHpKNnVxK0RmYjBF?=
 =?utf-8?Q?HNjZNQA9ezkUE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6522.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnQ4NXZuVDJxWk9IU3pCeXMvQno4bnAra3VvTERmaUVEZERldStYWUhxMXE4?=
 =?utf-8?B?T2NzcDNTWnp5NC93OUxjREVhZXlnY3pQRmNacUFYclNYTkdXd0l3MVF0VUdt?=
 =?utf-8?B?dlVtQkdSS3hENkFLQStKMFgvOXQvdi9WYWh2dWkxNXZSQUFNTFpQU0ZlVXU2?=
 =?utf-8?B?K212azZFL1F3dXFMU0RrWCtXTjE1OUNhUitnT3RCQWJpVVdLOHRLVGJSL1lj?=
 =?utf-8?B?NGc4NUN3N1BlVnRwSjBXVVdOZzRoVmZlemw5b0o4VkttemhESGR6Q1hiNkZM?=
 =?utf-8?B?cHo1TTVnM0dpM2N4U2czY00vQW9PUG9jcGhud1N6NmdvN2pNdGtseHM3TFlW?=
 =?utf-8?B?d3FwVTdiWkNPYzczU0pacU1tdytCL0FLWTlqY1dka2NVNW9oeUpXd085elNY?=
 =?utf-8?B?TnlWWTl6OGYyZU5tVyt3NTJpYVIxbUZmcUpveTREUVZZY3kxT3VaRjhMYlFj?=
 =?utf-8?B?NHdNVTBWTkNhZ1BaVW9uTGE5eEVWVTR6VnFMVnNCVEhBYVpMTUdFY1hBT0M5?=
 =?utf-8?B?OTNxcFJ1eURyUnR4RlBwbVpZem1GQXpXMjlnOEplVWpwY3E5aXFuNFpQUm5T?=
 =?utf-8?B?YXdGWXB0aEFISmxRL0drWWo1K1lBb0Q5ZUJibDMwRkRYM3FIVTNFc3I4YzN2?=
 =?utf-8?B?Q2FWUGRzMVVRR2dxdlF6a0dTTVVBalR5U1RRQzIvUlUrL2NKYTdvNXZDUmh4?=
 =?utf-8?B?UDErRG5XR00vdkRMY2p5anRvdHdzUnV1NHJPdXdsVlNjcStGS0JFb21zcXp5?=
 =?utf-8?B?Z2JoRFdBZ2Z6amRtMXYxdjFvRStYUmdkWkNhNTRvalUxUjMxOUlGZFB4cUQy?=
 =?utf-8?B?VU1YTTBGNzdvR01DYTFsaE1PWDhpaXVlb0VZTk9vU3o5YjV3QmhDeHF6bnJL?=
 =?utf-8?B?T1FHZTkwSDliNkdPR1BVOXYrMll0U3NTcTZ4Q3BsK0JIRnJmZGdwV1h0bHA2?=
 =?utf-8?B?dWxwajlCWngrQUlnR1RFNW1KZWdvMXVHaEVhY3AzQW9qSnNvcytCSHRzaER2?=
 =?utf-8?B?MVhPa2lucDF1UHBqQTFyMCtIelRYdnEzL2R3WlFNQjJFVzdEVEQrUnBPaEpV?=
 =?utf-8?B?SjdlMDdrVzc1YmxSTTRVOU9YVVNoRXYrWDRIK0g2bjJjSWpxa0tpMTVsemR4?=
 =?utf-8?B?NTJteFExMzRUZEhHVU9sUW1rZjlSbzJicm5vbytqd096NlhSazJPanFVbkFy?=
 =?utf-8?B?anhETlQ3YnRJamJ5eHZIR3hSQUZERjBMNWUyM1FQemdKSFpsTjV5cHhENWhU?=
 =?utf-8?B?amZteDVkbVY3Z1VUNzhXTTRmVkl1U1p0cTBIZHExdHF2b2ZZTjdkN3h6emsx?=
 =?utf-8?B?MHdlUkJpOUJTL3oyU2tNdFF4MU9URjRhbkNueDZTMUZCNGFHMnZianh2d0dU?=
 =?utf-8?B?cG5IZWt5Si9ZQXI4Wm1sQlFPNjBidjlZcysrdVVUV251aGtkNFp0WUNoNVZX?=
 =?utf-8?B?ZmUvamphZE5nZFlKS1JxZG1HQ25nMk55V1R4YmQwMzExTURhZ3RHdyttVnZq?=
 =?utf-8?B?NGRpYkdpQXJHMTM1bjNZc3FBRWNDNzdVNGVKLzhSRHBWL0x6WmZhK0RDWEpD?=
 =?utf-8?B?bWpqNlJpeWNwWHBuRGhyRHc0YWNDbjhSUkNJZ3hTMy9KUW1vR0JaZzhnRVVZ?=
 =?utf-8?B?WUlRWFkyWXhNT0NwNCtUSEZSTVhGdmlnSC9OaWk4d3FnYkVZU2FGVTY1K3lM?=
 =?utf-8?B?YWNURmdjUlRjSk5TU3QxY01GYXdKVXY4dERKZEJqM3pocndXRkVjS2hOZTdF?=
 =?utf-8?B?TTNCTHB1Y0lyV25sSWQwQ1c2aFVZMThLMHlSdG1mbE4zclpDZ0lGc0g3dGRO?=
 =?utf-8?B?NHBmNGtYblpWUUVoT3kvYU9vOFRaK3NTZ2N1RkZ2Nmd2SUZpYWFqYmFHbUx3?=
 =?utf-8?B?Y0VKbW9yN2Frei9hRUFMR1kxTU1KNlB5SWpjWG9kZHhOS0x0UWtOaGVXNzNO?=
 =?utf-8?B?U2I1TGJNdk5yQWpIOUU3VVpjcHNQR3VPemphUDVNbk9zNDRQNmh2RnV0eU9Q?=
 =?utf-8?B?cWJvVjNxYTZxdTF4TlZQUnJZSXU0YXlZakVlTitzQmRoYlBldlE4cjBtYlhw?=
 =?utf-8?B?dnc4RUZtYndNYlEyaXdLMXVEYVdCeTBPZkdyVTVFQXExQ3FKZG1GL21TV0Rl?=
 =?utf-8?Q?32NE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda0336b-516e-4a70-5a50-08dd6f775692
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6522.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 10:40:50.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58RUXjvbym5NmGSfY1X/DQWMwz6ZjdAp77RpWkjHUxybWZtHwUxKjQ2CLWcz70Pw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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



On 28/03/25 10:00 pm, Andrew Goodbody wrote:
> When using non-trivial values for parameters for this test it
> will cause a spurious failure as the test passes a decimal value
> to the mtest command which will interpret it as hexadecimal and
> result in failure as below.
> 
> test/py/tests/test_memtest.py:66: in test_memtest_ddr
>      assert expected_response in response
> E   AssertionError: assert 'Tested 16 iteration(s) with 0 errors.' in 'Refusing to do empty test\r\nmtest - simple RAM read/write test\r\n\r\nUsage:\r\nmtest [start [end [pattern [iterations]]]]'
> ----------------------------- Captured stdout call -----------------------------
> U-Boot> mtest 134217728 0x8001000 90 0x10
> Refusing to do empty test
> mtest - simple RAM read/write test
> Usage:
> mtest [start [end [pattern [iterations]]]]
> 
> The fix is to ensure that all the parameters to the mtest command are
> passed as hexadecimal values.
> 
> Fixes: 22efc1cf276c ("test/py: memtest: Add tests for mtest command")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> ---
> 
>   test/py/tests/test_memtest.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/test/py/tests/test_memtest.py b/test/py/tests/test_memtest.py
> index 0618d96f1be..f03e23db2e4 100644
> --- a/test/py/tests/test_memtest.py
> +++ b/test/py/tests/test_memtest.py
> @@ -29,12 +29,12 @@ def get_memtest_env(u_boot_console):
>       if not f:
>           pytest.skip("memtest is not enabled!")
>       else:
> -        start = f.get("start_addr", 0x0)
> -        size = f.get("size", 0x1000)
> -        pattern = f.get("pattern", 0x0)
> +        start = hex(f.get("start_addr", 0x0))
> +        size = hex(f.get("size", 0x1000))
> +        pattern = hex(f.get("pattern", 0x0))
>           iteration = f.get("iteration", 2)
>           timeout = f.get("timeout", 50000)
> -        end = hex(int(start) + int(size))
> +        end = hex(int(start, 16) + int(size, 16))
>           return start, end, pattern, iteration, timeout
>   
>   @pytest.mark.buildconfigspec("cmd_memtest")

Reviewed-by: Love Kumar <love.kumar@amd.com>

