Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE76CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 07:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CBF82A9E;
	Mon, 29 Sep 2025 09:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l+8PEa7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6380983071; Mon, 29 Sep 2025 09:08:40 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130B88206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfWv+f1/V0/XN9fZ9NIE9HsOecd6DzayumKEAMF1ru9RiJ9Bq4BypUVsBNhOoBQ/fus65DLCroPf8GfSE2shluEEc9RUBkeI4HSojROybjyMcyILUHjEshhqAZ2xR4PKVg74xHvYfsiCYnjlZaMVIq2p9YCh7Qg5XMHhZL7PdWLxr8gVSCKfT9lnAA9ffTkaqM99K06MQ3kO0vJDw0RLapFJ+SLI1B9d2EisS1Bidn8hNje02vuItOvDGiyXsVHOeBbXMPsmmpABcozdb76L+SjQ0PCFzaR6OldQVU8wyzRdhaut0NpPFp6glj1T60sul2CGjc8398zt0g88vUSGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3BAuDlsJgYD6fUHpeajN4ip48ZuSNwOteTffplVZKs=;
 b=l9qoko+CwhHIHtJwDCMcfDqgtgMvnp8wArJ741ei/Qvtkuex2uqAcC7KH9/Hohf22r9AHeWCUnvcAnN+09qlDI2EiEUzYnWIaZpGJ4ukxT2dItMlP7M96AiBrsik603/LurZ7i+3cvuIez5WbHBgu/vDSY6v+9UN/XraS0plSmyRQuXIO/T8NVbbKElTQn+xkIuX49z7r0Bou7xvXl3nJlDLIcNMeiBSbFV5nsC81TnWdgK5FCfy3O/1tOKvTP0KPoD1zGdNLrEuAwaKIeVzqUNTaRwCeH1osuhFFXSHhQNqgYbTpthB/6e8TvK3TLl7K+rTZwwMJZC7Lf9DzLPBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3BAuDlsJgYD6fUHpeajN4ip48ZuSNwOteTffplVZKs=;
 b=l+8PEa7aSIycDFzg4UvJY4GjwuUU7PqAaIAzq3by8+A0Ivp9qCyNDKRMg+u+1ZTQ8peFnwnyzZcBhnPKC8PSHcAFJfLzHoeZKEVzpgDO76Q0Og4Q7kCsD5wfnsPPKU2XQZQi5Z7m42Ul7FpSwRUSWphmV5lwNBvpX09zVDtbQx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 29 Sep
 2025 07:08:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 07:08:32 +0000
Message-ID: <49902e34-a01d-422b-bd60-e97aef7d859e@amd.com>
Date: Mon, 29 Sep 2025 09:08:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
 <48de987c-1255-4c90-8477-964d153809d3@amd.com>
 <401851f4-36e7-4e11-9d2e-e85753d916bf@mailbox.org>
 <e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0281.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc16f0a-4242-4cb8-9deb-08ddff26fff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2ZaNU40RC9rOGVFZzUxVmtlclNZOUVpVUVlVUV2L0VzbWRPUWNBZVN0MWpz?=
 =?utf-8?B?VksvUkhTTjA4YTFJSmg0Y0l3K3NGbWwwRGxBZDhlYU1aRlNDRzFpNFN4NU1o?=
 =?utf-8?B?MUNIOG9qTVZwQnJiSzlaNnlhR3p2ZXNGSlVLMG5Ea0JEM0RoL0JjTWFNRGp0?=
 =?utf-8?B?d2ZxL040QVNIZnEwOFJOSFJWb2tKbU1xRk1iRFhTSXd5WFVrQ0I4N0hnRnBI?=
 =?utf-8?B?MUxCaStQejFrVktqRFdBYi9FSVNvZXlFS2VHWXM4YVVyT2E4TG1uR3VQeU52?=
 =?utf-8?B?Wm1NVW1YSVlOcXk4emMzb3l5L1l6ekNTei9wcDBqb2s1ZjVkR1pTYU1BQWJu?=
 =?utf-8?B?Sk9OZ1B5c3h0T3lWM2o1WlMrQ09zYnpzWnJEa0xFNnJMYldHQlovM0NDUDhp?=
 =?utf-8?B?amFlOVlCTXFGU3JsVTMxUUkyRW8ybnNYdlFaQ3R1Nnk3UzdUSDM1MzJjQVF6?=
 =?utf-8?B?WmcrcGwyaUJxNDROUHZJaUFLeE1GMXQ0UTZtY2hvN0YvZGhhdVVUZnVQUEty?=
 =?utf-8?B?aEZjVGl5UWRxem1ybEp6dFF4NkUrYkxHWGVjVE0vcVBxWmJyQlpRSDlTMU1o?=
 =?utf-8?B?eUVpbE1zajFIOU5IZUFFZXNYRk9USElvTHVMOGxZYXlnb0JydTRNQVVQaFZI?=
 =?utf-8?B?K3ArRnkyZ1ExNFM5eUs0RVFGQW5nK3VDNmcwNTE5QUR2S1VCdTN6azgxQmJp?=
 =?utf-8?B?QThRaUJIbUdOZ0IvcDkxL3p0aERSekVRZHNLQ3c1eFBXekoyMlZyci9HMDFj?=
 =?utf-8?B?RVF4ZE9TTGtmNVYxTHdxVXF3MjZ6U21Ydk9Wd1Fxb1lNNWxwTGEwQ2p3dVEv?=
 =?utf-8?B?UHFOMGk3R1RER2RFWTMvZURYV25pdENDRkF3OUU5ZFJ5UFlKVU9uU3lFVkF6?=
 =?utf-8?B?NVdwOHFoNlIyQ1EvdnFRb0V0elo4eWJZODVmcGdWUGVEVFBuSU01QXZrZmhK?=
 =?utf-8?B?RE5VSEZZTkhKM0ExTXFXbEM5NTdJYzJsZTBoRDE5TmdRMkxPZTk1QmwzV1pD?=
 =?utf-8?B?L0Qxa0M0S1ZNem5tYm9NbDk1NkREenRISU9XM3k0ckMvU1NyaEJqaDJCYVFu?=
 =?utf-8?B?ckQ3WDhOV0RMdTlWTHJ6RWhScmh1eEs5V29nY3B4ZkdzQkIzVjlQZkJ1a2h6?=
 =?utf-8?B?cjFOdTJqVmxZbER2dmtSOWlhRXlvR0tVY0RUa3lFbGJnenVHdlZmQXA4Z2FN?=
 =?utf-8?B?MmVwZWdGcit6VmdWZTI2TlBsQnJ2OUdzc3Jianhna3BtMUxubHhQUmRVSzlL?=
 =?utf-8?B?MENCWGFMMmFWK2xmOXNyRTlndEJHaUNSd2tSVVBBbUFXQmJmUTdjeUM5dlBH?=
 =?utf-8?B?YVFWVGFXZFpoY3pkVW1yRmx4Umd1UHMrYVFnb0NtNTc0WERLQlh3bVdSSTV2?=
 =?utf-8?B?Y1RmMTdTYW16SEpQM2ZHc3VuVFVBeTVKQis0S1piOVE0d1pTQ2owOThMTzgx?=
 =?utf-8?B?dXZzRlRiUFV3RzRpcWxza3VDcWVkdHBJSHlkeXQxTGRjL0hHYXBkRkdtZjZK?=
 =?utf-8?B?Y0tYVGg5emU2dDB3ejJTOXQ5NTREYmtXaU9VTlZqbnlkSHBYRU5GVXRDeHZq?=
 =?utf-8?B?ZmRiTTBoZS9hTFNEK0tuMEVEd3llQjRSbElDWkNOTVdYZ2Z3WTJ5anNXQVJn?=
 =?utf-8?B?NDF6MHcvbFpPZjE4VVozbnJCWkEwNHdSTDRGRk9kNzQ1Qkt1ZEhJcXYvZjQ4?=
 =?utf-8?B?VkFNYzBxQThxVkNTTUZ4TE5vaHdYMk4yNUhEMHVkR3pFRnFVR3EwTkUvWWE5?=
 =?utf-8?B?M2lma0o4c2ZhS3IrMzcxcVF3cE5yRmlkdWdzOUQyUVJCY3V0dFVNUmNBWkY5?=
 =?utf-8?B?b0o2TUllcWVzZW5veG5YZHkxaUh6ZXZobStVQ2tDUmlGSmV0ZW4vR3h6ZzQ5?=
 =?utf-8?B?eUxwUkpZWk0zTGNWME1UVEhuRVhSRE9Qa2k0djM4b2JsWkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3krWXNFcEl6b0gvR0ZOSVVkcWp1b3BORUIyWC9XWklXU2ZVeXdiL1FwM3dN?=
 =?utf-8?B?OStxM3JsVlFrT25NZ0Jpcytra0R1L1hZOElwWXN2R1RGNEliR3hSQUdLb2NL?=
 =?utf-8?B?SloxNCtVeW92QjdsM0ZsMFI1NFc3d1Nzd202bFJIWVYyMEdET2IxN2tVSWtN?=
 =?utf-8?B?STZQUVNmUnRrWGQvYkZybEV0bm1oTmk4eW5VTmxvTDBQRjVHclNzVHVLU01X?=
 =?utf-8?B?NEhPTUJlcDdxc0xZOTZoQ2lreDVyUUJHMGRieGJDNEZnMWxPTUQ0eEEzeXFn?=
 =?utf-8?B?QjYza1RVTVlMVktKQzRyQ0hSMXRvR1YwWllvbjJYeVE1MjQ5WmV3TnpMNjMv?=
 =?utf-8?B?Q3d6S2RZRHZhQlNGeFQ0azZTbll2alR0MFJTQUFTK1BZcTFya2l0SXNOUUZo?=
 =?utf-8?B?K2doem1PbVY2aElTNXZxZ0c4WjFWYTNpSkRrdTVtb3AxR2U0VGFVWVZYMjM1?=
 =?utf-8?B?RmpNTllrZlR2ekZBNisyTDVNYkxZaHVRbUw4a3VhRU8wWXJqNWt3Wk1Oclph?=
 =?utf-8?B?QXM2aXQzUDl1K25HM1ZUWWFQM1lFVGtEOEZoVnhuOE9qVzlGWmozNnJBQWNP?=
 =?utf-8?B?RW95cURKWnB4QTlRN3kvcCtoWWx4OUFuRmhodHUwazB3TXRzd0xUYnFWdnM1?=
 =?utf-8?B?YlJjcHhsMnhQN3lDbmJ2dEYwd3ZOenNRU2RuL0sxdnVEdjhtSU84Z2RKWmRl?=
 =?utf-8?B?aXNUVVZlWXlxcmliaTV4cDNwWWxFM3FEOXZyNFJLb2JjU25LOEVWUGoyS3k2?=
 =?utf-8?B?Ykd1dllLZTZ6MFlxZitsazMrVGhZUjMwL3NBNXJrK2dvblMyT25MVWV3bGs1?=
 =?utf-8?B?VzFVM2ZuWXhTRWtPUjBZVXRkME1MMWxuamZ4cTJDTVZWQWRmZUo0UkluZjF3?=
 =?utf-8?B?dm9DdGxoZ1NQU01ya2xUM3Q2WkZTUitrZ0N5UFpuMGttN3ZEMDVjWFhMVmVQ?=
 =?utf-8?B?S0RLVE1ZWXZkWjUySWo3L3M5VGVsN29ra29xRk5kQnJndWhOUENwb042Yndr?=
 =?utf-8?B?aUk1NStYS1kzaUVVRTBoWlE4S3ByTFZJTm52UysyaDRXRWs5TS91UmFHYXh5?=
 =?utf-8?B?c2Z6T1R3ZUlta01aYXBPeWNocWRmd2FWMWpsNVc4V2kzU2podCtwRzBXSk9p?=
 =?utf-8?B?UTBRYytPU3pzKzMrVHBkTGVzcWpxb2VzMlJEQlFQaklnVW9iNWRwd1g1UUlt?=
 =?utf-8?B?eE1wdFBDRmxpNy9BNzFqaFR2dnk5YTYzQko3MXIzNnNyQ3RwbmR2ZmtQY1d2?=
 =?utf-8?B?dWZJaCthT1AwTnAyb2R3dG5TSFVDUEZwUDREU0RSTnVhNEQ5aS8vdzVOSytL?=
 =?utf-8?B?VUIrYlBjYVpGK1EzcU9BeUhkLzkxOHZQMzNuVDJkdXNXMnNzdXF2Rmw5c0NG?=
 =?utf-8?B?aXIxOTdUdEZEWGl2aTU4QkVRSjhrVHR5L29wRTNWS05iN0c1VnQxMTR0M2ov?=
 =?utf-8?B?NS9UMytoV0VnTjJOWGpqWnJWQkJFdEZhUnlqNjlxbThIcEQrQUZhQkNRVWhN?=
 =?utf-8?B?SUcwT0ZqSGp2M1FWR3JiV1pRWmRmalpicmVObEpJNjIvWnNLaFV3QzJtdnBj?=
 =?utf-8?B?UEhrWm9tUVdaOGdsV3Bva2RLS2tQcEFQT05QY1BKMTRzQnhsZGdFLzdtc2xq?=
 =?utf-8?B?UC84QWhnM2ErMnR2R3ZyVG45SWNpQnRnaXpJdTFYOG1ha08yZy9YVVJMT1hT?=
 =?utf-8?B?MmJFSytLeFZNeXdOM1pCd1F4TDhENGxrVWFEK25Sazk5Ryt4ZHlRaEQxZUha?=
 =?utf-8?B?SzBZeUtsdTdqcTlsaGhNZmc1bEk1VCtYUjZXMlBiUlp4S2FJakFicTEvZzY0?=
 =?utf-8?B?UFZXM251blEraWNUOG13eDJRdlRnUFQreWttNjdieFNLeCtJdTRvMkgrck5Y?=
 =?utf-8?B?L3dyUkRzK3BnNHlSZllFd3ZlR2tOMDhqRG5qWERKWlBOYUJCOFIrUzlTTjBp?=
 =?utf-8?B?ak1mbnA5TENCWmFoMjdHdi8yRmcyMDMyUUF1Y3FtaVBVSDlUM0FQWUF4QTQr?=
 =?utf-8?B?Sk90RXlmQ2R4RWpGeGpML2NEL21jTDVwL0F6UXNaNHZuOE5iZnIrZGt4TVZm?=
 =?utf-8?B?TlIzRmN1Um03Q05GNG5oNWYzZ0VMSWxzTTVWSzN6UEVPcmdIOWhKRHJMUGpI?=
 =?utf-8?Q?3VX6XOmnjLOA/NPjF9GBXHgd/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc16f0a-4242-4cb8-9deb-08ddff26fff6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 07:08:32.9149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L43XA0um3D4n2lNc7D+t+HPPfJQTtmVrsklu6gywMUmIWoV+mza+YVVotnOUK8Wa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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



On 9/23/25 23:18, E Shattow wrote:
> 
> 
> On 9/22/25 07:51, Marek Vasut wrote:
>> On 9/22/25 4:02 PM, Michal Simek wrote:
>>>
>>>
>>> On 9/11/25 07:40, Michal Simek wrote:
>>>>
>>>>
>>>> On 9/11/25 05:28, Marek Vasut wrote:
>>>>> On 9/10/25 9:26 AM, Michal Simek wrote:
>>>>>> In case of ENV_INVALID (uninitialized variables) the first env
>>>>>> location
>>>>>> should be used for storing variables.
>>>>>> That's why change the logic how env_valid is setup to be aligned with
>>>>>> offset calculation.
>>>>>> This will also fix the print about Valid environment is showing proper
>>>>>> location where variables are saved for the first time.
>>>>>> And also fixes behavior where the first two writes were going to the
>>>>>> first location instead of the first to the first location and
>>>>>> second to
>>>>>> second location.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Simplify commit message
>>>>>>
>>>>>> Origin commit message with more technical details.
>>>>>>
>>>>>> When both location for variables are not valid (or empty) gd-
>>>>>>> env_valid is
>>>>>> 0 (ENV_INVALID) which is setup by
>>>>>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>>>>>
>>>>>> When saveenv is called in case of SPI env_sf_save() is called which
>>>>>> contains logic which describes new/old variable locations.
>>>>>>
>>>>>> if (gd->env_valid == ENV_VALID) {
>>>>>>           env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>           env_offset = CONFIG_ENV_OFFSET;
>>>>>> } else {
>>>>>>           env_new_offset = CONFIG_ENV_OFFSET;
>>>>>>           env_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>> }
>>>>>>
>>>>>> In case of ENV_INVALID option the first location is used (else part)
>>>>>> and variables are saved with ENV_REDUND_ACTIVE flag.
>>>>>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>>>>>
>>>>>> And
>>>>>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
>>>>>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
>>>>>> but that's not correct because the first location has been written
>>>>>> and not
>>>>>> the second one.
>>>>>> That is confirmed by
>>>>>> printf("Valid environment: %d\n", (int)gd->env_valid);
>>>>>> which is showing number 2 (ENV_REDUND).
>>>>>>
>>>>>> That's why change the logic how env_valid is setup to be aligned with
>>>>>> offset calculation which also cover the case where initial state is
>>>>>> ENV_INVALID.
>>>>>> Then print about Valid environment is showing proper location where
>>>>>> variables are saved for the first time.
>>>>>> But also it is fixing behavior where the first two writes are going
>>>>>> to the
>>>>>> first location instead of the first to the first location and
>>>>>> second to
>>>>>> second location. Alternation is happening after it.
>>>>>>
>>>>>> v1: https://lore.kernel.org/
>>>>>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
>>>>> Sorry for not being clear, the original commit message structure and
>>>>> technical details were fine, it only needed slight rephrasing, in
>>>>> the original form it was very hard to understand. Can you please
>>>>> reinstate the original commit message and only clean it up slightly ?
>>>>
>>>> Can you exactly point me to part which wasn't clear? It has a lot of
>>>> details about flow and obviously it makes sense to me that's why I
>>>> would like you to point me to exact part which should be improved.
>>>
>>> What about this?
>>>
> 
>>> When both SPI environment locations are invalid (gd->env_valid ==
>>> ENV_INVALID), the first call to saveenv writes to the primary location
>>> and sets the active flag. However, the logic for updating gd-
>>>> env_valid incorrectly sets it to ENV_REDUND, which does not match the
>>> actual location written. This causes the first two writes to target
>>> the same location, and alternation only begins after the second write.
> 
> nit, the use of word "alternation" here reads as splitting (no
> duplication) the data one-by-one into multiple targets. I would give the
> game analogy of 52 playing cards and alternating to deal the cards to
> players, each player gets one card in a sequence of alternation; if
> there is more than one player in the game then no player will get all
> the cards from the action of dealing the cards.

tbh before this patch I though that both copies are the same but that's not how 
it is implemented.
It is switching from Location A to B and then to A, etc.

> 
>>>
>>> Update the logic to alternate gd->env_valid based on whether the last
>>> write was to the primary or redundant location, ensuring the first
>>> write sets ENV_VALID and subsequent writes alternate as expected. This
>>> aligns env_valid with the actual storage location and fixes the
>>> alternation sequence from the first write.
>>>
>>> With this change, the "Valid environment" printout correctly reflects
>>> the active location after each save, and the alternation between
>>> primary and redundant locations works as intended from the start.
>> Yes, perfect.
> 
> I do not understand what this description is saying because alternation
> of write operations to multiple targets would not be redundant.
> Alternation with the meaning of "fail-over" is similarly not redundant.

How the code is written is that you have location A and B.
And when you call saveenv variables are written to A.
And next saveenv variables are written to B.
Next to A, etc.

It means unless you call saveenv twice you never get data in A and B equal.

It means it is not alternation of write operations to multiple targets.
It is alternation of location where one complete write is done.

> 
> An alternative method has the meaning of "do something else, do not do
> this". In the common use, an alternative may have the meaning of "do
> something else if needed as fail-over from what is first being
> attempted". Do you intend for the meaning of "fail-over" and "duplicate"
> or "duplication" where you have written "alternate" and "alternation"?
I am not a native speaker but the word alternation between A/B sounds the best 
for me.
Feel free to suggest how to describe it better.

Thanks,
Michal



