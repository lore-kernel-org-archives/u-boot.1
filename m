Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A66E6895A
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 07:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA7A8927E;
	Thu, 31 Oct 2024 08:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ut1mkZE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFECD88DEA; Thu, 31 Oct 2024 08:46:52 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A139D89287
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 08:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlp8O9+a1zwosDUUfQEKUUFgjaiDbG0Z5hBQippfdDCi+j7wzXTyHD9U1V28XfsQ0MOv51irCP7zC+0zLVU1OA3gU9SayhbtwsDbmVp7C584Kb3ynBEuCGEJRPMAJkvsuC+Zwq21fZAxEzzsvzgcAeZwd2kCETY1NeVN7AzoZEj7hoOIc/4y3a28CMHy399DwHwgwf0/stj6kmznZrOwB1NdQqrAUj+xVFpfdePGi0SdgaegWQWhhmv/eElFfyyYyy1iP2Rr9nNMXxFoQ+vM8K0Yqah1C9scKU1j9Ksaj9+v4v2QvvMGGOBKNep/iHpGJ/BCWFaYQcNv91R68Yg7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ceoOqgy2UnKtm9rPGBY+8RP65Hv5i1bvc5vwRHAA54=;
 b=epb1MVqLP3uBAFz5xBFFtkiEwdvkXylmkDminQCpVsJWjYntQbjcMfizOw2xxGODATTapDUTwQeSsf/WH05XkOtdDx4o5swODaniTkfZLyhUiD7hSFb0g+hCQG4otcem7HY9W02C/nBAd9twWJ9XuFU+q7q9iU+mrpAiLLykbgZHpJfASuPrwq+dPelnUaDOxarx4JWxX/n01Q3gOrir/OuIesggftShQGMdb2DOb1KO4Y3pATXOe8HPG8B81w5ZyyYWqxIAy6O5vwNMhKyiJHHWrMKIqJayuBrMwGiilc3yxIj5lr5I0zsdhAWiNJ92pMKzSQV6yNLW4HMvuGIPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ceoOqgy2UnKtm9rPGBY+8RP65Hv5i1bvc5vwRHAA54=;
 b=ut1mkZE65OYRyzHrVSPzkNV9t8WAPtBHIpLygUvt9pTZe1h52IGgZv3vNFAWLVvXiw3G77oGGfPpNfl0+TeJVCOMVjDkK9OTSSOovLTBar0r8fJu0LrI5WQ3OU2cyAcNjXWZH/GCPIcxKYamx6N4hMNwl9+g1La57JDYguOnszw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 07:46:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 07:46:46 +0000
Message-ID: <8413c7ad-9313-46a9-9174-394435ff6fc1@amd.com>
Date: Thu, 31 Oct 2024 08:46:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
 <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
 <f797cb27-84ca-41c3-83a5-b9044f2d5e5c@linaro.org>
 <3835b139-ae37-423e-8a24-a958ece69c0d@amd.com>
 <20241030165618.GP2558755@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241030165618.GP2558755@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a68a46-36d4-4b3c-cf7a-08dcf9802b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzkyOFVzWkp4cmNyMTJyOWVsakFmVDNvekF5a1MvNHliSSt5RWNKb3JaT0U4?=
 =?utf-8?B?MEswV3Z0OE84UzhHL2lqRTVFb3BYRGwzdlZkbWVKVFRJZXZqa3BDM3kxRk01?=
 =?utf-8?B?V0xzU1VBVEk0T0xRMWFFMWJsVHRYU2JINUM2U1pzbUN4amh2V0Q1NkNYSE9H?=
 =?utf-8?B?ZFhyZmcxV2p4QTQyaklrNFRSRHA4YktnMjcyVC8zc2lWelg0MXE4Snp0N0Za?=
 =?utf-8?B?REs1MGxObjZ3c3lUMnJ4SVlmdUExOHdDVEcvbWpjZm9ZZ0ZmdjI5Sk5lM3BQ?=
 =?utf-8?B?TW5Ea1RwZGU0em9TZzJyZDdiL2tpSldSR2Q2T2lFc1lBbldGVGFkaVM0RVJi?=
 =?utf-8?B?SDhYTnllL3F4Q2txQlNyUzBna0FtWDhweE5PVy8zbnVhV0hnOE1qYkptMW5P?=
 =?utf-8?B?Wmtwa2hDTEZQMm52MnpoWmNzWkNTV0RCcWdUMlY4Z3ROUzlOemRBdFI3Ukt4?=
 =?utf-8?B?OUlJekJMdi9PelZpODhaS2E1eXpBd2hkcnNMRFBrRGVHRTNuZjd0bC85QytU?=
 =?utf-8?B?bDJnWGNuR2plWXJtUmxRbW1vUHV1WElFUHFGSnFSK25LS2Foa0xVam9yZVFC?=
 =?utf-8?B?S0lPT2p4YnNObG5tVGV0QnpKencza2l4RkJoWG5yYWRLVHVwK0RGalhMODVz?=
 =?utf-8?B?VmhXWndnR0ExRGtsWG5NNHViWU42MmlIZCtkU1FrS1lsQ0hxUUZvYlJ1VW1Q?=
 =?utf-8?B?ZmxMODQyVFg0WGFCZHIvMkNyMTZQWWs0V0xXWlB1R3JOTlBlRU5Sb2p0ZzNC?=
 =?utf-8?B?d0Q4dlByVE4xbFdJdHc1NElQQVREd3dPRnlzNHhVQkdkQ0N5Sm9Za2drTVRV?=
 =?utf-8?B?RmRZQkNGVXM3OEQzV3JWcUNKL1piQ2h6M0ZIQ21KM2gzZDl1SVczVjlnTDBj?=
 =?utf-8?B?eVVDdUFqcFkrbW5CMXhSVHhrV0hkbkF1d0dCdjJVZUF3bjFxaS82OTV5dTVj?=
 =?utf-8?B?Y0NBODdUMjNzamNVcENkN2N4QkV3VWlnMFIxaFBlc0FFR2QxUGd6RXdPVkpv?=
 =?utf-8?B?VUhqYVlqdjMyQUtKVkJBZHhwNm03TzFTSCtSekE1MGlFRlNrV1B3UnhVRXNF?=
 =?utf-8?B?Q29pK005RTdEM3hVTVdZSC81dnB0cW5HeGt3SFRCOG5Pczhkam9jeGxTM1B6?=
 =?utf-8?B?ek9IRXp6clVDVmNabW51MG4zazVCaStkNlRrWnNLckc3K2QrRDdNTkovS25F?=
 =?utf-8?B?RkVpTDNqd2poWVJ0enYzWkIrS3BVbEcyZ0xLZVZwY1N5bmpjZzZRVmdQS3d1?=
 =?utf-8?B?cGZGVVRqNkdyeHVwWGsrNFoydVJvZzhHcFZleVJXWkhIK1ovWGVqcFlzZHM2?=
 =?utf-8?B?N1pGL3N1RFRXNmNGMHVLUWJUbFR6V2g5eVhWZy9Za09yNDBQeWxYTjBaVGFW?=
 =?utf-8?B?ckpud3EvSUVnMlZMRXd5QmZPdC9aK1V5UVNyT0Nvam1mNVpvam9ueGVYMkFl?=
 =?utf-8?B?UWNOaVBuQkRPekU4NElkdkxPYkNtQ3J0NFJhdkNrenhNL2xtWHVkK1BzTmZm?=
 =?utf-8?B?TWhYdjdPKzB0Z01MclJrbnZWV2tBd3htbm91MjlocVNmeXVpODB6a1ppR3lF?=
 =?utf-8?B?UkpXbDAwdXRic2lrdWtqalhDRUkvUU5XOXBYUmRNbWd1eTd5bUtuVk5BaXpp?=
 =?utf-8?B?d3d1QmZ3UG5wWFZXQys3SnNiazJaTmx3R2dpSVhRaGpGYWRFMUpQdGtIbjNB?=
 =?utf-8?B?UlRYa2JYU0xTNVVVWXNXVjhuMmEvMi9taDVUV0FwVm8xY3h5Zm1lV3NlUng1?=
 =?utf-8?Q?2bHWxLcn0VbtqNI4r9XwaJh8ApwMWMilRx3pc0I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1UT0JxNGlNWndUcllNWWFjbTJCb29maGNHcUUwWTJ4aFJCVEd5SkNOY1h5?=
 =?utf-8?B?blgwNFo1M0doSEp0S0MrWmNEdXo1dUxsbGRpSTBPZmVPNUI1OFV0VEdZUmcx?=
 =?utf-8?B?b2ZZaGRqYkw1R0xtNDBtd21qMTVLdWNMRGwxTDB5VDgxSXlJZE4vS0FQbVQv?=
 =?utf-8?B?eXNSZHNaOHNaS0NFd251aHphcGxmVmhBakM5WWFUQjc1VC9ScVhnV3ZITDdR?=
 =?utf-8?B?MStLQjhOVkszdWJ1blVnUkVraFR2ck4wUVpBNW9nNkFrVXVybzV6VTBuNnBQ?=
 =?utf-8?B?UFlEZ3JXQmhaUWhFZEhQdmRqTDE1djk4T0NGNlc3bTFJNDV5MTl6VUxXRjdH?=
 =?utf-8?B?dnFQODFPcEE3UkpaM2pPclg2MnY2c3pBZE1YWjBhU0YreEJObTc4a2JwM3Rs?=
 =?utf-8?B?N0RaNHNsUm9sRFFJaXo3ZjlPWC9GUVhrQ0ZlZzlrVjA3RDU1UUlKT1NFUHlF?=
 =?utf-8?B?Wm0yaThtSW13SnJ1cENFQUF6c1Q0RHRnYmtic3BJNS9zTldOeWNhZFAveU1s?=
 =?utf-8?B?N0JSSFFHdjF6cnpxZjFWaTY1bWN4VzQwTFQ3cmNORjRCdW4yY1Zkdkgra0Rt?=
 =?utf-8?B?TnpJc0pjOVRWRVZpUlArT29rRUVpWG1XR0ZqcEVOUkhTNG8vMS9Lc0JXYmM1?=
 =?utf-8?B?dFlZRmt2YjRzYzhUTVUzYWxZRHhRZElqWWpLNVdxazNMM0NJanVCdVp3TFZB?=
 =?utf-8?B?bDZTamZTUmdoNVRkSldXeStuNWtnRm1POE9iMkNGR2RXQUhVMU1DRmhBUmtv?=
 =?utf-8?B?VHBHQlluZGUxZWhvUlVtSzN3SldISmZoNXNyR0xmTklqcEdiL2JITWV6UVl1?=
 =?utf-8?B?NVJ4eG9rNEtDMXU0TnUzQkRqa0lZQStqTDVNTmVVS1Vzemowb09KWWY0YmhL?=
 =?utf-8?B?SndnbS9kT3BNOXRWU1BHREIwUm0wVnlQOVQ4NU1GcGtoeVJick00WHQ1UW1M?=
 =?utf-8?B?TDllSFhzTlhKM2dzSm8wV0wrMXpVMUYxZ2pWejNHTkRTZ2J3enVTc0hLYlYx?=
 =?utf-8?B?enV3RkxaV1NlTEtOQmhBbW9MaFhiajFCc0Y3Skp3dDgreXBlaGxFTHAzemcr?=
 =?utf-8?B?VVd6TDluTWFQeEdIaU51R3l0Z3FqeFJjV3ZtYTJqK0lDMndPUElvMUUzRFR3?=
 =?utf-8?B?MjhKaHdCWXBTRE1nQk5JOFYvem5jNmhtcnowYUg5N1Y3QUl1STdBZkRhOFh1?=
 =?utf-8?B?ejFTUXFQZy9rbVgxQlJFUk1lbFlFTFBVUEY3YkIzYk05SGpya0xneGJkNzZV?=
 =?utf-8?B?TXA0aG5qRk1HcWh6YWN4ZFlNZll3UjVZb2lLS21Ua0ZJaUVTN3ZHQU5iVE0v?=
 =?utf-8?B?NXBJRGgxUU84MzF3M3FKaUFoamc4VUZ3WnJTOUNUZUQ2Tk5sS0lVVXZWeUFu?=
 =?utf-8?B?ejJFM1RCRXJYb2Zwb09NVGt6WmVVZHdZM1VrNlo1SWtSckE0TjIxWU52d0tP?=
 =?utf-8?B?VjJoSy9NdTJwblhmbGdsYzY2YjhXYUlETmxVYXlYYlp6UlF2NXZKVEZwVW8z?=
 =?utf-8?B?MCtWWURzdllIM3FJd01ONjVsY0lWTHErTGlzS09CNm1pU2g1WWVOeWUxMC9X?=
 =?utf-8?B?Qk9WQ1B1VEdqRGZac1p6VkhQOWxvTXZwRjU4OTZJUHVsMlRzdStOYlFxZzEx?=
 =?utf-8?B?UWZIV0R0dkdINm1CbzBLTFJZZXY2NjJWNUdONDJpN0ZQTW1lczFRYlh4V2Zn?=
 =?utf-8?B?MGpCbzZ2dzIvQldmYlYybUg5R1JPd0FXcGpHTmVwQThEZEdkTGtOc2N5QjdZ?=
 =?utf-8?B?OHlVcU9haW9jOGRGRUN2dWhEcXpFWGVnanRMUUUwZkhmKzA5NUxOdm42UXBn?=
 =?utf-8?B?VUpVdmhnMUZTeVdIZzB1MVlUemNkUnI2L2g5WXk2UThCL2YvSUxsa01IeEF2?=
 =?utf-8?B?RnRvSXdMM2tSRlhobENvaFlyRlBscE5KMThZdE85YjNVWU5NdGhPY1VWejZZ?=
 =?utf-8?B?OC93ZlAvYVpEQ0FEdHZNeTFlUjF6SFN1MTFPR0wxNi9DQjVZMkdjb3dYNGpm?=
 =?utf-8?B?Tyt0amc0T09LaGpObWErcEtsWm9md3ZlZUxqOGpIaWFCemI2VjdkZ0JnbW9K?=
 =?utf-8?B?T2RXYVhjb1lRTU43bThYbTVXQnRwQVR1K3VYalVNWFpxV3V2RU4zZVJkdTVX?=
 =?utf-8?Q?nibKzAV7u1GfyvuEAG1pGwb4I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a68a46-36d4-4b3c-cf7a-08dcf9802b4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:46:46.0174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdOdGsLgmeZ7sgGBAV/8E/6vcR/GZ8zFSAF4/LM73Rgx9ZKednntemM/cZYphSAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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



On 10/30/24 17:56, Tom Rini wrote:
> On Wed, Oct 30, 2024 at 04:20:32PM +0100, Michal Simek wrote:
>>
>>
>> On 10/30/24 15:49, Tudor Ambarus wrote:
>>>
>>>
>>> On 10/30/24 2:17 PM, Jagan Teki wrote:
>>>> On Wed, Oct 30, 2024 at 4:15 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 10/30/24 10:33 AM, Jagan Teki wrote:
>>>>>> Hi Marek,
>>>>>>
>>>>>> On Sun, Oct 27, 2024 at 1:48 AM Marek Vasut
>>>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>>>
>>>>>>> Remove undocumented nor->addr_width == 3 test. This was added in commit
>>>>>>> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>>>>>>> without any explanation in the commit message. Remove it.
>>>>>>>
>>>>>>> This also has a bad side-effect which breaks READ operation of every SPI NOR
>>>>>>> which does not use addr_width == 3, e.g. s25fs512s does not work at all. This
>>>>>>> is because if addr_width != 3, rem_bank_len is always 0, and if rem_bank_len
>>>>>>> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() returns
>>>>>>> -EIO.
>>>>>>>
>>>>>>> Basic reproducer is as follows:
>>>>>>> "
>>>>>>> => sf probe ; sf read 0x50000000 0 0x10000
>>>>>>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>>>>>>> device 0 offset 0x0, size 0x10000
>>>>>>> SF: 65536 bytes @ 0x0 Read: ERROR -5
>>>>>>> "
>>>>>>>
>>>>>>> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>> ---
>>>>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>>>>> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>>>>>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>>>>>> Cc: Michael Walle <mwalle@kernel.org>
>>>>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>>>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>> Cc: Sean Anderson <seanga2@gmail.com>
>>>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>>>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>>>>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>>>>> Cc: u-boot@lists.denx.de
>>>>>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>>>>>> ---
>>>>>>
>>>>>> Is this patch-set next version for 'previous' reverted series?
>>>>>>
>>>>>
>>>>> my 2c: I think I lean towards reverting the stacked/parallel support.
>>>>> The only one that benefits of is AMD, while affecting the core code
>>>>> quality. It also slows down further contributions and I assume it
>>>>> hardens maintainer's job.
>>>>
>>>> I did try this before and it is hard to separate from the core. and at
>>>> the same time it is hard to maintain the core too.
>>>>
>>>>>
>>>>> Even if I (we?) haven't made my mind on how to best implement this, it's
>>>>> clear that it shall be above SPI NOR without affecting current devices.
>>>>>
>>>>> Not sure if it's fine to revert everything, haven't followed u-boot
>>>>> lately, your choice to make.
>>>>
>>>> If we find a way (not sure if it's possible) separate like a wrapper
>>>> or fix the things without revert - these are two points I can see as
>>>> of now.
>>>>
>>>
>>> Then this set shall help move in this direction. Some involvement from
>>> the stacked/parallel authors would be nice here, and some commitment
>>> that the current status in just a temporary situation.
>>
>> I hope that by authors you mean SW owners not really HW authors of this wiring.
>> Jagan is aware that we are using this configuration for quite a long time
>> and we are still here and not leaving.
>> As you know Amit is trying to find a solution in Linux but nothing has been
>> agreed yet. If there is agreement to separate it to own driver or so we will
>> be definitely working with u-boot to get it to the same state.
>>
>> This patchset is using the latest approved DT binding created by Miquel and
>> if new binding is accepted we will be working to align to it.
>> Also intention is to bring this functionality to customers and not break
>> others. That's why these patches are pulled into rc1 to get better test
>> coverage.
>>
>> And to be fair to say version which has been merged was v14 and anybody
>> could comment it before and we are definitely here to help to resolve issues
>> on other boards caused by this patchset. But we need to have help from
>> others because obviously we don't have other boards and they are likely also
>> not wired in CI.
> 
> To be clear, we need to resolve the problems that have shown up now on
> all of the hardware that was working in v2024.10. 

And I hope you understand that we need also that board owners to start cooperate 
on testing on their HW which we don't have access.

Thanks,
Michal
