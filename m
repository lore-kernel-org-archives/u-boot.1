Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE24D74970
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 09:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEBE80077;
	Fri, 19 Dec 2025 10:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d4pwMXfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55A380433; Fri, 19 Dec 2025 10:57:57 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E518003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 10:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpJLjOYcJZpzfsgVL0/bEfoF2E7zHeul1lhkbgRtwDRJBv6wvEpGJeidhPOOSNUiA4zI9M0+sN4ycbOu9kSeIuGuexD4oTCm2C+0fNtH/cU2lU+Fsf01mQHUr1TuYCo6shaOtou7M1ogI72FS6Aa6n4iKl8iTmzMpHYx9qEYqPbPlFJzxjHnozeT6YJtsc8e21VhmfZR14GSEtkEL3Pmkw/FrL5PCUR6vOTL8omYhJRxTlUMyssNd5dqn3tNAMNhVDuV83lsp75Jg2jNwEoZsD4RNzT0WISFw6Pqx04+QgS8PcHTFTVgf+Li58Evy0it3TdgjfZHgPTe2ksP8ZNV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8PJvgVHHoIZVkEDL59dt5l9vUV89ABiY+oJs8FPdaA=;
 b=vLzJDc0tekGg69knmovF95V7l5IvPQxAyqlSEOC0WRqiTzLGaWynWWKN9ZKqWIpZ5Sgv9KyBSqU2i/7cjS/LPMYQBfQboouNajYAhsYzoiuU+TRQ6xWKa3QNDMD7Ilr2cSNDlpIiijDrsQe9lAdoW5K0Oj7DIAxp1UqZp8RukDBbVymTW1N/7Fp4lMgiIgQReOP4ZaHLiSAVaWFh6jHY/XV88qL4W+9pB9Hb/srvGQrFcSBGD2duBNoArZcQwKV8petYPKZG1ZajC4rR3hggd0iNPpTcm9SJuVBECczu/tlI7OtXx+m/VCd3lBcoRzkLGvmB1dZ22HA1nsH9IIQGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8PJvgVHHoIZVkEDL59dt5l9vUV89ABiY+oJs8FPdaA=;
 b=d4pwMXfEdDsHxh62DyggXFETZPhMItCt/1jBZm9a6qp9Zjo1IeZtc7CToBxK5tGSlDJXCn1L/UsUb8Ux7PU9Qa6FphN90el5cT/WADuGaJj0ScYJHaNJF+5ljPiRXUTX1X2wSCMojR7nIz0gkySmkq1FtznTPCImzT3lYSySpPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 09:57:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 09:57:48 +0000
Message-ID: <8957dd86-88ab-4332-9527-c852238b2b0a@amd.com>
Date: Fri, 19 Dec 2025 10:57:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Enable dynamic MMU page table sizing
From: Michal Simek <michal.simek@amd.com>
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20251212102621.2888015-1-pranav.sanwal@amd.com>
 <c237df33-5f3d-4478-a698-0fafbaf65754@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c237df33-5f3d-4478-a698-0fafbaf65754@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: b0997852-9aef-4918-ff5b-08de3ee510be
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1FvOFdWM0cyL3k3RnpHemIxd0w1ZHZXK2NuVFQvN1R5RU9WL0p5c3M0bE54?=
 =?utf-8?B?VUlRVFlkeEtPeXlHbkNncmZnRTl3L1dFL3lJTmF3WSt3QkFBNVpTUlYwaUVD?=
 =?utf-8?B?VmZ5d2ZjRU90T2laVkNmUUVGN1NKRkQwem9uVE9FOWx1WGhyanYvMEhUdmY3?=
 =?utf-8?B?UmpLQmVVOXRqZDNROGRhR0RyMUNwR1lMMEhlY2g5bDVwOTNwK0c2VmJES1ZO?=
 =?utf-8?B?TXJFek9pZzVDN1R0emlTaTNBVjBXeGdoUFdTbDRBTjFOZzJpMHIvczJ5bnJq?=
 =?utf-8?B?Yy9PWlZXMHJXOHJCaHgxQXZidWJvMHhSUi9qWjhmNkkvLzZpR2VrUFBuVFBQ?=
 =?utf-8?B?UTZCUkdQUlFXYmE2eTFOMWU1VFVxbFhYZElqQll0UWxla2dMOTFOckpjK3Nu?=
 =?utf-8?B?ano3aHNyQVFtdTkwcGxCY2psYktibVBUd3hxcHUyMnhWbHdUUW5OUHB5VEtu?=
 =?utf-8?B?VlU5M0I2dlRYWnVDT2I1d3RWVVJySFh4Q1V1SnFJUzRWZXFlNXBkMGV5dzJm?=
 =?utf-8?B?Qk5wNGhJVEg0eVBWTFRNNmN1eExRT1B5dWxSSFlUUGljODBzSHhBM3diU0lj?=
 =?utf-8?B?N1AwRkhITWVMNDBDZHJCK2xVYkhoNTRieE9sV29FYXFmUDNvT0k2Q1JFL0FS?=
 =?utf-8?B?czRtVGFBa2xuUWkxUUV5TkRPMHJVVWNLSHZkelJSZjlqcXh2V1lyQWdsS2I1?=
 =?utf-8?B?Z0gveVlySGdOSTVFdDJFZUpDZDlYbGZRNnlRa3p5RWM2aDMwQ281Z1dRQ3J3?=
 =?utf-8?B?QkpXOUNWdkRzbU4vS2ptOWxpdllzeHRuYXMyRE9abnlCdVROdFA1eUhOU3o3?=
 =?utf-8?B?R3FGUVBYWlMrNXNSdVRSanhPcllkRWhTbnFobkhWWkQrbkRGK3J1MlVCMWM4?=
 =?utf-8?B?aS92Sm5rZFRSN3F3V2hoSm5kYTZNZkNMQld4VklvOHRoRmkxUkdTemVnOVhz?=
 =?utf-8?B?WUxHZkQvQUlSR2o4REdkYmhhMHNUTjVyVlhTRm12dGRzLzdHQ1ZlSndSeTdT?=
 =?utf-8?B?c0hSL2FXeER5YjJjN2RyZnY0MXltL0FhSFNGWVd1dGtNdHZQcktCQzZhVHZi?=
 =?utf-8?B?TlJxOU52QVFzaHVKY2ZXMDh6SHFDSWRveGhUYmFJK2F4ckZWME80VlowZVdD?=
 =?utf-8?B?bEpRQVB0Vkc3eUxMcHg1WkY4Z1RyM0FQRWdFQjRKN0FIMnpWVzRRS0lldFNy?=
 =?utf-8?B?UytDV01ESC8xMVlFWU9Wdm52U3hNMzZKZ3FqRGVSR1BFNlREcTNTaUtOQ3No?=
 =?utf-8?B?cThCZmJ5RmRncjNFUU5CT1JnVEt6REg5NFF4MVhRVXMzU2NxeHg0d2VaWnJt?=
 =?utf-8?B?Y3AySGlKQklUSVdsWlFuQlE4LzVKOC9ITkQybVowbU5VVmNKYkF4ejBwSmFp?=
 =?utf-8?B?eWJyaXdxREx2Nlh2a0oyck1LWmtUWFZ2b294Q3A2aHBQTTRreEFVOE1tc2Yz?=
 =?utf-8?B?SUJKeDlmZ1l5TzcxdHIvQWtENldNR1dmZ0ZEWFVhN1hMQVB6ZXpMbFNkWGsw?=
 =?utf-8?B?VUVMdDIxWGNzUHJ5QTRGMCsyNENFTWJWczFKSFNRd0JaUVlCeUdOWE8zbjd5?=
 =?utf-8?B?LzhmbEU4WWNVQ00reEdLWk9vRkN0and6OGJMYlg3N2hZOEZXeFFlT3FvZEF4?=
 =?utf-8?B?eEx4bE1DSllYWWtFdHlhM0pVMm80OSswcEZUdzUwVlZkS0lkbjdJRCtKTEZv?=
 =?utf-8?B?SmlNRlQyaGZvYVhSd3VySWltSXpuUHViZFVDV1IvQnptV21PM3NqN3Bpdmlz?=
 =?utf-8?B?eFZ3YTR5cFd6V1hSdTdNUjRFbzR4NW94d1FqZVZTbmRBYlVQM2RZWnVoL0hl?=
 =?utf-8?B?M3EvTDc1TTlyczZ4TmZHODduNFdpTkx2K2xRN3JCU3ZkVXkwZGRwZ1VPdTc1?=
 =?utf-8?B?aHI3eHp5UGxNK0g2QmFWSWRzZ2Y1SlMvb2NqOVFWY2k1Qzk0T1JDcXpIL2dF?=
 =?utf-8?Q?//L7k32IdtO2tEcdQKWD3RvDv/BK//Mj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJ5Z2Fta3JpUkRXeUVxY0VHbTBHQzdBRWlBZGdIRTNjeFhRWDNyYjJkMXFG?=
 =?utf-8?B?ZFc2RjluLytJMjNwUzhQWGtaTThDODhtSEx3bzBXcUw0Z1ZTRGZPbDg0WGhE?=
 =?utf-8?B?U2pSaE1yWTd0Vis3UFlOTDdqMFd4SThYUDZSM29Mc1VGS1cvNEVBU284dTJy?=
 =?utf-8?B?WXFCOW1sR1ROWnNjNDlxOGhTck1YaXRSaHNIWUZ3bHpVQUp5cDY2a3ZGSEdW?=
 =?utf-8?B?V1FnMEtVOU9xS2J4OUJjVWlUM3ZjQlFVU0l2MEpHYXphb2E4MndnYU1QUnRl?=
 =?utf-8?B?eFRMTy9ydjFqVzBCeGMwUzNrb0hEbGE0OExUVi9pR2NudlJtY0dJcnNQeWVa?=
 =?utf-8?B?c3owNTczU3VzaUpMdnRyYUh0VDA0YlRsZWdMdDVlRldQa0lwYVJ3MEdCaTVI?=
 =?utf-8?B?QTZXNGFkODdubXMyVEYxZy9zV1hObGk4blMwaWdJQ1MzR1ljUGhJdkZGcFcr?=
 =?utf-8?B?YUpTUFpXekp3dmhMMTR2VFFUd0VRSVppYWg4NCtnUzlHNmhXRXZDVHN3QmJY?=
 =?utf-8?B?OXhIT3E1VFhxV1g4SjUwemdHWDlsSmFpZXRTUGs2ZnVXaWFaQnNNemNEbExw?=
 =?utf-8?B?dmtaUzBFNS9zak1Bc2QxM1lLRSt2cG5ZN1dWMjZjazhpcXZLOE1vMXo1Z2Ex?=
 =?utf-8?B?UTB1eTd2dnRrUjA1SXNDUjUxQ1NnMVN4c3EwRFhKaGZ6cnRIT0tqK3VVUDMx?=
 =?utf-8?B?L1FyK0hPQU9kaDdZcnJsL2xIaUdDOGJRVHJpQ0U0NUhiRFAzRzZRWkJGdFBz?=
 =?utf-8?B?MnZWSEFMYXVNNG1ERXBaK2hLTHpVM0l1d3Z4cnM2QlZUbnhMNXFSNlA5L2E5?=
 =?utf-8?B?Q3hZVHNpZ2tUWFFTK3pJc2FWbXk4ZXhwdE95dWs5alk5Zkk3WXo4RGNMOGpn?=
 =?utf-8?B?d21VTHVvQ1BLRTZ6aTBYbVBiVVJCcmxjZWtNcnlMcUI0ZHVZRzRpNjBBZkpV?=
 =?utf-8?B?S0dUeDUyRTdjdnNOcnZodDZ6MHhpZEtxTXJvQlc3OXRTNFpMeS93M25sQmJH?=
 =?utf-8?B?a0IvZi9tR0Y0WFVzaW8vUm4ra2piRENvUEdiZDFDZEYxbzBhNkN5cGxOaGg1?=
 =?utf-8?B?RFBHVFFWSmhqa2cyNVdGYmE1eGp2OUJXT1RFY3VOcEhqOFVqZXVGU2xMWlpt?=
 =?utf-8?B?bHk4NUtRWXpQemNwRTY4NkhueHNEVFVlV2RvSy9EaERqOXNwTCtEem96V25z?=
 =?utf-8?B?M3QwYlQ1VEdjWis5SXRwRDlZMmMwNXhkb0dwanFCTWlTK2RLUm5YZjFlSjcr?=
 =?utf-8?B?c2RVcVQ1YVpOOVlDcytJNnUwYU50cEt0UkE2aisvV1VmVlVVcmZKL2lzZ1o0?=
 =?utf-8?B?TDEyZ040Tk9QY1VyR1gwZ0lyWE13S0tkbFdaNTNoL3lTRW5YWjFkbGkra1F6?=
 =?utf-8?B?MWxlUkF6STRXK0Zjc1l2MjBxQlV5TjlYaTdwWitJc3NMZXZBamVsTjB3Nm1r?=
 =?utf-8?B?a0ZMN1k1MG9XaXVGVVdPVEI0NUJadmc2UE0yMDlnWTJpdm5aRmlINS9VK3JM?=
 =?utf-8?B?d1RwaFhLby9sdVdFOVUxUm5OckJBaEpRem02a2lqUDZGUlNZUXJ1elZQVWJS?=
 =?utf-8?B?RHlFZktmQ0VLSjdqb3pLQkJHUnZLMElTcmE5V3kzVkxKcTc0N3NLemF3UTF4?=
 =?utf-8?B?QWNpcGJCaTEzbXh2U2MvZFRrVTkrYzBvU2JQajgyemE3RlYyMkl2ZDEzeHFJ?=
 =?utf-8?B?cDhaTWlxemF2NGFwVGY5Q2w0QzlNcVBmL1NzVmZuY29GbEhydW5jcThnR0U1?=
 =?utf-8?B?NkZ4OHZQbFZmMzJaL01qMitzcE96M3lmNFFZamdIMWFEZVVpWG12OXduSmkz?=
 =?utf-8?B?SEJDQnYwTDhRaTlsc1NFQUsvSDRiUmpyaVdMQ1FkMFdZWjF1N05ZcisyR0hh?=
 =?utf-8?B?S0NXa1U4dVY4WDhYNHRud1BKZFpCVGY5ZkZmbjdkNlEwNEJUeVp5Y3BUSEZH?=
 =?utf-8?B?V0t5NmVySFd5T3MrQXZyVXdTMFE1WURVZ29FN1FrY3RSdWU1b0VVY2h6UjBw?=
 =?utf-8?B?VVFmZkltT0Z0R3FPV2Z3YXN6djJiZ2ZwcWFXdEU0SmJtRTNFTHlrcGNNNlBQ?=
 =?utf-8?B?ZjVGY0hIaFVhc1Qzd2hTSzJIREtZTDBER0hYQTl1ekhzU0FJZWQ1ZlFFNlhJ?=
 =?utf-8?Q?HH8xwtf7nc7wwZHPYbur6vrrr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0997852-9aef-4918-ff5b-08de3ee510be
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 09:57:48.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxPBQ20SVrhKLuTzvC3tyDd1AJtIhWniZbxAluhkYWUjBMscRmFQy5l0ZXlG6h8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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



On 12/19/25 09:36, Michal Simek wrote:
> 
> 
> On 12/12/25 11:26, Pranav Sanwal wrote:
>> This patch series fixes a boot sequence issue in AMD Versal Gen 2,
>> where DRAM banks are populated too late during MMU initialization.
>> The fdtdec-based approach doesn't provide memory information
>> early enough.
>>
>> Changes in v4:
>> -Better debug logs alignment.
>>
>> Changes in v3:
>> -Fix DRAM base detection boundary condition (text >= bank_phys)
>>
>> Changes in v2:
>> -Address boundary case where U-Boot is loaded at the
>>   beginning of a memory region.
>> -Export get_next_memory_node() helper from fdtdec for reuse
>> -Split previous monolithic patch into two focused patches
>> -Add comprehensive documentation for new functions
>> -Include proper header dependencies (dm/ofnode_decl.h)
>>
>> Pranav Sanwal (2):
>>    fdtdec: Add declaration for get_next_memory_node() helper
>>    arm64: versal2: Populate DRAM banks before page table size calculation
>>
>>   arch/arm/mach-versal2/cpu.c                   | 57 ++++++++++++---
>>   .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
>>   board/amd/versal2/board.c                     | 70 +++++++++++++++----
>>   include/fdtdec.h                              | 23 ++++++
>>   4 files changed, 130 insertions(+), 24 deletions(-)
>>
> 
> Applied.
> M

Actually I have to remove it from my queue because there is compilation failure 
on xenguest_arm64.

+board/xen/xenguest_arm64/xenguest_arm64.c:63:12: error: conflicting types for 
'get_next_memory_node'; have 'int(const void *, int)'
+   63 | static int get_next_memory_node(const void *blob, int mem)
+      |            ^~~~~~~~~~~~~~~~~~~~
+In file included from include/dm/ofnode.h:11,
+                 from include/dm/device.h:13,
+                 from include/dm.h:13,
+                 from board/xen/xenguest_arm64/xenguest_arm64.c:12:
+include/fdtdec.h:222:8: note: previous declaration of 'get_next_memory_node' 
with type 'ofnode(ofnode)' {aka 'union ofnode_union(union ofnode_union)'}
+  222 | ofnode get_next_memory_node(ofnode mem);
+      |        ^~~~~~~~~~~~~~~~~~~~
+make[2]: *** [scripts/Makefile.build:297: 
board/xen/xenguest_arm64/xenguest_arm64.o] Error 1
+make[1]: *** [Makefile:2133: board/xen/xenguest_arm64] Error 2
Please fix it and send v5.

Thanks,
Michal

