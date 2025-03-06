Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757ADC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49868141D;
	Thu,  6 Mar 2025 15:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a688HxX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FDCE81428; Thu,  6 Mar 2025 15:12:59 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EF380756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4UJ6Jp4Hi6tZVibt4KwsYydy0XC3z66t7Mmvq2CULVavVJNbOs3OKh4ymtp3bFH0nvzfxx9y1vEW6QesIEAIPel9p16TwFq2zhQbF0XyEpB09GJSlny84H0BTJwzIxrYCT3qLfv1Uh/TV2PXVRX8DOHuDsGwqYYqwloiNnYWORqSjSHIqLy/jntwR+UL1Jvnxhp2KK0Pz/JWgeikwfcWrolnt5O7YYKzU6g+Eikkv3g+YYvhCi+OaWjPe2CUbU5ZqAkXWYKmbpx9CDi6bNZGjOI3fi5Fej3cafrCKmr4NUBC7BrTzlf6OhmyuCbfi3wB6p5d8InZjcFJzlcpQZ9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+Ucpx7kYGBmFVQQjLHHTz9g+AE1mTeNuqQWf6sJ4no=;
 b=Efkr1HfbBEwOuzXKQkpLVij4zIy9bQX1wMEo1chHpyXayFws18mmMZAd1NEG1iSXcvNuB5O1Dan1dxSjRXf0ln+EfzzA372OPOkqamlws+VmJcNFWA8sn0A4xBfp8mI56Yel2dVNuMfvRwyhJUoeY5U4wlLevUkhjetY7LM1/JPIsYLIcgS5lfQphlySDI32jKYDKk9rnK/aOuIuGcCR9EYwY7oGbCBfMwSNrgMFGUnIAzaCMJ0DGaiNUYLUwjx9gAAbE5BsRH+S4KzdQ2jNFrlHbSCyl+VUWMvPiZEKtaEfKayIR6P328lyf4jz1wuD6r42ibQqt8KxnWfwb8s6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+Ucpx7kYGBmFVQQjLHHTz9g+AE1mTeNuqQWf6sJ4no=;
 b=a688HxX95RwrvMJ578/8qbE/s+ElblcycTiWFbybumNeq1+PGjq1/TMZEvjuaqVnMAwDzfqPuW1mqiqKcRVruq43IqseaHe6eWXtiaZmpyykM+f65aM1hg01Nj3elliDJnp6MhA6JBexeYIPOHbXgqlZhbDWj76bLqeJfOOcmec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 14:12:53 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 14:12:53 +0000
Message-ID: <41f1ec1b-2c36-4ab1-9e99-77459deff366@amd.com>
Date: Thu, 6 Mar 2025 15:12:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
 <20250306140250.GX2640854@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250306140250.GX2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: f69f8ee8-fbb9-47bd-b4eb-08dd5cb8fc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjRDVFp6VDFENHRQamxLbzRZQUcyYmlTUkxVYWUvTHhZNzVGOFR2WFczZi9o?=
 =?utf-8?B?MmcwUHBZTmVhRXBSeUhkK080aE8ybTRqTVB0dEMrMWZwMUtEOEpBNWJqV0xB?=
 =?utf-8?B?dGNaWFdWdnEyenc3REU0K05rMVE5R084R3JhQ1plZkVPdmlGZENndEVZSUxj?=
 =?utf-8?B?TjNEb3NWaWpHOUh3L0ZyQzJkRmplVHljS0pWZkc5SWgxRW5jTUpRV0E4R3NB?=
 =?utf-8?B?ZE8xQUVIN05qVVJ6NjFwNm83QjEyRGsvWUUvdS9ldFZtbUZObzh3SXM0UXRz?=
 =?utf-8?B?aktKMGZqYVIyQzAyNFNUR2x1V1V4OGVPVDUrRmFyaVU4T210QnducjFpbENo?=
 =?utf-8?B?d0ZsM2E1dTdDL1pQL1A2b0Q2bmZRNVlWN1NHR3hBYndESjIwQkIyZnRJZHQ2?=
 =?utf-8?B?ZUx4UndYVjhzM3Mybks4L2tuQ25KSWRpKy9UODBTeXJiaUNaL0tzeDAwTUFt?=
 =?utf-8?B?RlQwMmhXQmd0RExPdlcxUzJkbHNWQkpJRk5yZHN0OUVkMDc3QnRPdFRMdlkr?=
 =?utf-8?B?NVRpcUQ1ZVBQSTRaQUMwKzB3ckN6Z0VGZ3VPL3c2UFlhNG9CK29zR29ndzVa?=
 =?utf-8?B?TlBtWS9FWklQZ1k5WkJDOUtrdmdWMWd2SEV1eGtlM2NsaGtwMmdvRWxBM0k3?=
 =?utf-8?B?U0dxVlV5ZmNRbS9URENyR0tKMVNWMzc1c1JIYmc3cXF3T1JYcmxoWWhuRlI2?=
 =?utf-8?B?N2JHZnVJczhMU3haVVNEeEFrN2NYU0N2MnRQTjBaS1RWQmwvbFQ4YTQ2blNN?=
 =?utf-8?B?YjZ0aEVMalRxR1JzOGpPdkVXbzI4TVhqUXk2TGRuUis1Z1hSNzBGWmtGcVNT?=
 =?utf-8?B?WVBqbzlrUGlqNEtqb1dKb3BnRytiWnlkUjdCcXk2MzNyMER3T3ArQVZMK3lU?=
 =?utf-8?B?cmE5dnh1bWJ2LzhQL0c1Tk8xMWw1SjUwRXVMamdvOFQ0Q0owek5VbUJwY3hw?=
 =?utf-8?B?VnFyajMxTzhiaGp0WHNrWHRHSDYwSVQ0d2FPVmlDdm95TDFzZE1pdmh3bjRS?=
 =?utf-8?B?Z1ZsU051a0diZXVUQUVieW4zdmQ1a2JkZU1vSFZFVE8yYlc3MUJGSGIvaUtC?=
 =?utf-8?B?UHNSOVZCUitveXpZaWJiKzJQdm0xeExhTzRsblRhOFh6WFQyc2NiU2JBT2Rw?=
 =?utf-8?B?T0Z0NUYxSzErZWIxclRnM0Y3bU9PbWRTS3RsTElZaTdlZjNvdWhuemZBRW5k?=
 =?utf-8?B?U3d4NWpkdHJjbjVBV3VsRHFqTm9BYWcrY3pxYXZraC9EMVpmSXJTaDltMUdx?=
 =?utf-8?B?Y1UyazdIL2Vhb3NRdEJQN2xza2dVSkZOalFneXJjN3crVnNtRGVUS0twMEFo?=
 =?utf-8?B?dzBaeHBmbEpOb2pDUGNUVHU2cVB4VmNHV1g5TmdFMC8rOC9VSWhBWklTSHRa?=
 =?utf-8?B?c01ORXRCTmlLclM0Zi9NRjNVajlBdDJrQnJDTHVtbjY5VmJqTk9oK1FmK0Rr?=
 =?utf-8?B?UGhiamppanE5Skx5dldwSEMzMjJCL3hzQTJBMkpUUURqc3hHbGk3ZlE1Tk11?=
 =?utf-8?B?T1E0U0dyNkRWZk5kNTQvNnZzR01FMHdFZ0l1WGVCeHhlR3Q3VmZTRWNLb041?=
 =?utf-8?B?a0RMS0FsYkEwUHFiU3U5b0xDZUZGVkx5c3BMZ0tRSU45OStQMU5QR2phbWxK?=
 =?utf-8?B?WTNWcHlYWFRHT1J2V2ZmMmJhLys3bkwxZlp1aktudUhVeG1INTJUb28wT3Y5?=
 =?utf-8?B?KzJ1RDFIcXV1YklmaTB3MkJLUVZKSDVYdFhkR1MvdXhvRmhocnEwVUFIbElW?=
 =?utf-8?B?T1U1b0lpeXY3dElVV1dPM05hL012c2N2SjVvWVBsYXJSSkVmV2ZsNjdoVEd5?=
 =?utf-8?B?bDBid0J0cjY5NDErdHdGZ0RMemFEWkp6RnB0a0tZZXI2ZjBuT3luakFJNWl5?=
 =?utf-8?Q?mrsa/va49paWA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVxL3d5ZzF1Mzg5L2hRdlVaMEZVek16S2FZNjMwY2hnL2NNeTVCN09NS3Vu?=
 =?utf-8?B?NFIvV2cvNytybEVwMTloRE0zTUthQlNWUDNsSXp0TDI1TmVBRmFPQ1hobzZ3?=
 =?utf-8?B?VkNOampVZk51MHB3aHhhMGFNWERzbGVoQWJ0blhIRldUWnc5ZmxoTlV2OEFC?=
 =?utf-8?B?dGl6aEpXUmVGTWt3Z1JDampaMzZ5QjhnK2k2aGdwM05ibE40czRRZEJHT0k0?=
 =?utf-8?B?b0NGcjMyakdWejQ0VGhydzdORG82T0UyRHcxbUlLV3FIekVuSkh2SG1PUk9n?=
 =?utf-8?B?UzE3S0pmcDhmUFoxa0JWYVNqUDhRVS9POG5KbFpXMDQxeUtMeWlNdlNtVWZq?=
 =?utf-8?B?ZTROTFh6N2hCbVlDcnF3eXV0ZDBIbWt6RkNzZ2RwSTZ3VmpXd3NPZDB5Z1or?=
 =?utf-8?B?T1FoZXNmYkhNelZFOXJwY0luamdxREhEQ1lCcTlrNTU3d21vZUEwL3RDQnZs?=
 =?utf-8?B?YTkxMGczUmZZYWxTbFpNM3paU2k3Zjl1UE5RR3U2MGo5WEQwbWl6TjF3RkdP?=
 =?utf-8?B?d0lYVjB4eDNEV0UyOE1uMXB1N0FiRWVoMWU4bkQ2RnVXWlhDYVdVSy9SbDhD?=
 =?utf-8?B?RU9wREhVRnZDNU5oYkNnNVBsbWtGVlZ2bThmVDd3Mk5CN05jU1NFQWg3aHds?=
 =?utf-8?B?dmhjbDlicEUycVM2d0JDNGVmNHNwb3pXS2wyWm01U0Z4VDZRR3IyQS9JTDdL?=
 =?utf-8?B?UFpmNlMrU0p3SnpjbTlDbVJ5bFR6dmc3YlYyUzZ4TzUvQ0U0OVUxOEU0T0g5?=
 =?utf-8?B?b3hOQlVzVlZDTS9nYkVrNG5QemtTU0VldWZRWmNXUC9SanpJNWtsUlE1dW9l?=
 =?utf-8?B?bTVBV0djTjNaVmt3czZjRXBWMGQwMlRycmxwV1ZPbUg4NnlZUGFudzJ2Mnc0?=
 =?utf-8?B?bUdNVitGdWlpc05naHRiRjkvcGVPSzZobFhiOE5mTGJqRThuM1JFSXVWdjNO?=
 =?utf-8?B?ek9nWWRzcUdjOHVIUFdiUGl3OFpscWpSQWVVQTFDdDgyU2QvSlhmTENVeDBs?=
 =?utf-8?B?TWU3RnFPMTJGV1Y5YUZIbVRBc2REQmwydFZLL1pWMHFXemt6SHF1UGZqR0E1?=
 =?utf-8?B?TENNQ1FDWWZCUWVsY0o5ZFVXeis3L3VmR2Z6ZTV4RGtUNGdnWEtYM3BtN3RI?=
 =?utf-8?B?NkJEQVF0STcyVFp6RklJQVZzT3dweWQvK0JRMVhGYWoxUUx0N3B2V2IvUko1?=
 =?utf-8?B?YXpOU25sZlExUzdRck1yaGY3emRUWnBkNWFkMDJqMmw3blhKNnNMUGQwTjBi?=
 =?utf-8?B?aUYyRS9ybVBnQllUczJsdGVjd2wxZXh4ZzNIdW9KV3hkcDlaOU9aZFNjUU5B?=
 =?utf-8?B?YmRuM3ZFVk9kNS81ZzdrdEFGanhPWjJETGk4M0lnelErZkE3dmliYkwxUHpm?=
 =?utf-8?B?T09lVTlMR0dmUytCVmlDTWRuNGM3WCtRSUsrTjZIelljQ1A1dWVIZC9YQVh3?=
 =?utf-8?B?aXlEbU4xMmpCT3NuQ3FQcEdJRDhhWmtXOXFTU3dsNnppeXRGVllMRzA5MURn?=
 =?utf-8?B?ME14b1NveGt5Y1NjUnF0T3lTQ0dQdUQ3NVFHSzdWVXp3TVVtN3hGQ3FhenFM?=
 =?utf-8?B?cVJJWm02ZnZHWnIvaTZlNVVlUHZIN3I2V2xQaWp6WXRGaGIvemZJVVFXUDdl?=
 =?utf-8?B?bmRFajMwL05EQXJqWWQxTzlYR1JIcmZFRkpxbDZ2dnQ1MmtCaFlsNlUwdS9T?=
 =?utf-8?B?dzF2M3hqMHBKaVN6NUZaYng5TUt1dVdxOEwvQnFYbUtESTBQVk1FQTZzcGJL?=
 =?utf-8?B?N3NxdGlhZHdQaVVpNE1aKzRnUFhNVm80RmdUZzBWK1VIcnliRzd1K3RNRkZm?=
 =?utf-8?B?d1J1YXdHU05xR0xLQ3NiRmlBV2cvMjRId3dlaGlJeDdiaXRCQzhWUEVUd2RE?=
 =?utf-8?B?WG0xdmtRV2NzY21GOWc1dHNZL1QzUUxJaHRnQVFVTjBxK0NuUnQ4QjB6UWNH?=
 =?utf-8?B?c0lKcHVkRHZ5S3k0amIwdlJ4N0JWdGJlcUxyNVZNeUdWZUI1QWtjc2dYdEpW?=
 =?utf-8?B?ZWR2Y1ZSZ20yNE1Ub1RrbDFDYlVjUEZUdXNnN0xZelJEdVNYd05kdHJxbTNI?=
 =?utf-8?B?T252NFRGcVN5SE55SzhiYTlHTEZWSDVkUnFDR3c0Z1ArYU4xZndVUjcvNTB1?=
 =?utf-8?Q?kNBYwDpD6zA4UAcpn8PMtbjh6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69f8ee8-fbb9-47bd-b4eb-08dd5cb8fc58
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:12:53.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABeOVJBKqnl0YZntGgT5iYhh/URUN9TYDua6gt86Ja4B0gFV54Imv/wG6WjjCV6B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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



On 3/6/25 15:02, Tom Rini wrote:
> On Thu, Mar 06, 2025 at 11:12:30AM +0100, Michal Simek wrote:
>> U-Boot version command is no longer showing information about GCC and LD.
>> The reason is that version.h has been removed that's why CC_VERSION_STRING
>> and LD_VERSION_STRING are not pass.
>> Values are generated to generated/version_autogenerated.h which is sourced
>> in version.h.
>>
>> Fixes: 54ecce2cbf90 ("version: Separate our version string from the version command")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Tom: Not sure if this has been done on purpose or not but this issue has
>> been reported by our regression team.
> 
> It wasn't on purpose, no. Did you put this through CI / confirm
> sandbox_nocmdline still builds?

Nope I did not.

M
