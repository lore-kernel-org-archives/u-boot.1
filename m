Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C08BD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D614683B48;
	Wed, 10 Dec 2025 08:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hcL4ZzAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7FC83C08; Wed, 10 Dec 2025 08:39:01 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F50783655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ271IkxniCrMxkPnfeSV62Q4z8ADmp3lQTj5mglFdTUGefqdnSe4DJKl3KLdA8gO8XYIpPq6cXrCbXq9SwWQ4PCFHePTMg578pE+C+Gli/65AFWL7s7pOVqO5cNzIMs4QUCpKFOaGpD4U9N6JCvcxV1i8CNl1C3mm6sA0JCLGS0ilS1xTjC9exCOLwoDqpAd14nfLVD6b5BGi00Jc7u4raEZ7hhMVK6Otex8Meq4OR1cNiysW1nZZeG9noI6AZVYasZOo+/pG7HFN0FKu9YgAJZaYde7oYbAwawYCamzHcvI8ORNX1i/nF4ojSdKSBpCNEU7PWxLTBknFJ3F+ptdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+L9dODD7XpA4W+vdBV2xfcGNlEgUcnefC2+4lOsqOU=;
 b=KATMpbkxFGJJHgEfJgHeOZUHNe4nGdgDfZ/haXGrU2zybModeMjvxDyTwX8pbNtD7pChQHwYzXXaJwWxLM/82XzIryVskjivab3gowKADgU7yKpedJf1qWkNr99btKwqgfQdGqgeGZok4Oko1OayXyCuvBnLI6eJew68oUU28B+F7Wkn3zLjyRHrKw1QVPAFxiJ1OHJhIQAsSKSpmN3q3YJ6kUVqVPRx8m5S+CJDpSE+GFc6eJfk1A/ja2Ke7YxUc3hAn/Z0888ri6oNGnn9h34H3Vnvk+zerFsFI5u3RMd4r6BgJGCy5YNgzyd6hAChkfDZ4bVNRLi0sKkSDbSQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+L9dODD7XpA4W+vdBV2xfcGNlEgUcnefC2+4lOsqOU=;
 b=hcL4ZzAc6pTJtGiBlzAJVK4S+WyxjkgJSwoH2totty2y2lDkVHQl6hOYOKr8v2cqEcCDzuhYJA/VH4gLkQKCAI/9kG6HcfF22vIWkB4V62nBkWDmpkjwp532IuMQIc2pr5kn/pR5YbU4gUxhhvcO7RWfO5S5INL7+CzNCxOSNqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:38:54 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:38:54 +0000
Message-ID: <7db995d3-6343-40fc-a2a9-a4d75e2aa7ff@amd.com>
Date: Wed, 10 Dec 2025 08:38:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: cdns: Add timeout for RXDV status bit polling
To: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Cc: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>, 
 git@amd.com
References: <ba53d57c179f3390b32bc6094f3ffb5f4cde931e.1764169953.git.michal.simek@amd.com>
 <0f467b11-0b5c-9a95-149f-255c32ca69a2@nabladev.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0f467b11-0b5c-9a95-149f-255c32ca69a2@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f97b8b4-1afb-4ab3-7fb1-08de37bf2b5d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFd1L1hRaDdDQllDOGR2NDV4OTdyaUVhS1ZJMVpRbUdBWE1rU3RZUzBwZzNZ?=
 =?utf-8?B?MDhUYTd6SXRnWXkwVS9ETHI2ZkYyNU92eGQ3dG5JaHZrVHJaYW4xbGxVTVNY?=
 =?utf-8?B?MHgzV3VaQVdHaVdmSGhsVW5QVW4zR1h6WVFFelFGdEg3NUtMOXZ5MjNxbU5O?=
 =?utf-8?B?Z2pRRnYzWDkxT01xZHRtaWo3MGlXK2pyTXN0SFNPSFNZTVRoZUJQYmp0SFUr?=
 =?utf-8?B?dWxjL1ZvQ2dkOUpFRjNEYjdxOEJ6cXBMbUMxZjVSV1IvK3J4SDdCZDRIdVph?=
 =?utf-8?B?NE1Lc2IxOE9QcFBtdXNweWxrb1h6VEFsbHVkMjFYbTAwczJTb3p4N1YrbGcr?=
 =?utf-8?B?Z3RxOWh3SmRPQ0Noa1pHUTJYT3YvdXlTbHZUeisrZmRPQnkxdE9BdTdNMHRt?=
 =?utf-8?B?Ukk0bFZTWDBFOUZ1T3UxYWtiQkJUNkZaR1RWeU1GVnNwU3Rjbk5iRUxyT1pT?=
 =?utf-8?B?d1pubVNyWk5Sb0huVjI3Z1ZLWUVWeG9HZ1hTWHBXWFhlVDQ2d1VuTDdJSDVr?=
 =?utf-8?B?YVRtMDRDdzBBQTh1cVpUSTBBbTlOVnhuUDdjQnVNODd4SjRsRmVubFNPMW01?=
 =?utf-8?B?Z0wyTk9sTDZoTGNHZ1BLbUZzaGt1TG9HOTNPSkJ5Mkh5dGN2SFdNbGtxZlVB?=
 =?utf-8?B?THdaZG1mOGlOcXNxanhjdDRNbHdMMkxDSmhyYUl4NEsrWkVwMEczaWFOUE0z?=
 =?utf-8?B?REJVN0NlRDdzS1c5eWx6akNTL2lTSGN0VVh2Vld4cHVOY3VUVWR0WUw2R0xJ?=
 =?utf-8?B?Szhha203RktYNGFFZWhHSFZwVTBsWm5EY0FVWjhsbHZmSkdkQnUyaGJMUmF6?=
 =?utf-8?B?K0JRTnZsVWg2TytuS1Zrb2FBY2QyZUNabUxQTUhRZk1SenpDTTVHUXg4dnVD?=
 =?utf-8?B?SFpreG5Icjc0eERDazNMMnllcHEyd1YzT2ZHdGJNOVhrRzh6SlJHSndKZ3Yw?=
 =?utf-8?B?c1BNZ0Yvc1hJV1FmOFNRdE82Q1NBa3R0NXJncUpENmV6WGlEbUVqbHhPNnJi?=
 =?utf-8?B?QkorcEl6eWk1YnZ4UjBSQTZSNkFHWDdrRXFubTU0TXBYMmtUU3NZN0ZZMVYx?=
 =?utf-8?B?OWN5WFVMSUI4YlpUR3dNZmpyeVFTTFpMbUtEc0lOd2NEUUVRWE5VKzJIK0Y0?=
 =?utf-8?B?Y0o2YkdSN3dUQy92b3VPcmFZQmE4QjlPTmZldml4WllVRWt0a3BCL0FMdzNI?=
 =?utf-8?B?eEpVOWxXU2VRbnRmL2lGR3VjWlF2ZVlRdGJ0dkpCWXhNb3JIYTZXRkJXdUxB?=
 =?utf-8?B?WmQ3YXUwekpDdWJ3dko2aVYrRHgvU1o1bzh1ZUxrZjVqWTdSdjZ4azVGRlVH?=
 =?utf-8?B?UEtFNkloRlZkNE0vNmhxZUxEdlJ4cXdKeEk3SWVyTnBIOG9ZaU83RHFqWlZz?=
 =?utf-8?B?alk1SCttVXJhakxJaVNKMitwZjlvTk1pYWgzQktveHlRSW5XMU4weThta1Jn?=
 =?utf-8?B?b3BwOVpQT3NRSitzQTRnd1FWNWVoUU5TSURsNEUzcXZ2QWJNR1ZPN2JWQkh3?=
 =?utf-8?B?TXdidjJiamhxY0dBeXlLSllHd1phZkJybmd0RTJGaFpOejkyY1lJeDhaTTFp?=
 =?utf-8?B?aFRJOEdtc0FoZjN5WTViWkNRcnYrTVovV3dmZ1RvZERKR3I3dlFpb2RnQ3FU?=
 =?utf-8?B?aXY4QXMzWTJGRlRiQnB5Y0NNdG1Zd2I4WElkcjBaS1RUN29tdnVRcUl6TjJ5?=
 =?utf-8?B?MThEd0l1eC9BeXA3TngwZVRHNDk4ZHR6NVUrSnExeEVOWnBob1VhYTNseVRk?=
 =?utf-8?B?RkJaVXhOd1NPUll2UW9kTkx4elRCTGVLMjN5aGhGSFNocEw3bmlNc3E4TDVj?=
 =?utf-8?B?MFo5VlZuSUx4MnBWNW5qYkNGVFA4c3NyL1JwTEd5VnJaZ1R0QnI3K1JlbVJR?=
 =?utf-8?B?UFAxRTZFMkVBS0FwQWNGcVNFdEVOalNteU5QWXFIZUNSRzRKbFI1Z05VSEpP?=
 =?utf-8?Q?32VDWMwjPO5w8MBC2eAUoDIAmL0Pzjyn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2U2cE50a3VKbG9PVW5Cc1pKQXVYckhqYjZHalVVZnQ5a1VRS1QzWDMwRytV?=
 =?utf-8?B?bVc5WlkzNWJBWnAxODBPOXM0dnZZeEgyRDZLZVowQTVuTVpEdHk4bmZLOHkx?=
 =?utf-8?B?dzE4bDJRc1RsMng0N05GYVU5cXJCSmp4RW9aZDkwZEM3VzVTMmlHSC9hcHlR?=
 =?utf-8?B?Y0JNZ3Q0cDlWUU85RFFjYllhS0FjVlN5bzVoRkRNa0NjU1UwYjBicjBGL0Yx?=
 =?utf-8?B?VDREZlFUZmFrUHBJSDBhVHZzaFpWV2JxVUM1bHVrSk82TDZCN1F5N2w1RkYy?=
 =?utf-8?B?SFNzblhYUU8wbEhySjRrZm54N1dxZGpjcXc4L3BqRXJNVVVTRDMxRGptdi9Q?=
 =?utf-8?B?S09MblpiT2JPbTVaZ2tGNGpiTHRRdG1sb1dVR3ovR1BMVlZkNzhHR3lEQXpa?=
 =?utf-8?B?a2UvTHdXWVlMQUlwalcrSWZIdkRld0thTWtJRmVFazRIeEIyVEVxY3M0WDJP?=
 =?utf-8?B?MUpjUUY0NDZqZ2tzQWg3NVU3dnNDbFV4Y01lQWtGOXVZZVZlc3dqRnh3V2JO?=
 =?utf-8?B?QjFYLzd5Z29ZaEo1bVlMaDUrREI2R212Q29Mbnh4RGdjM01JLzltUDkraER5?=
 =?utf-8?B?WHM3NWVtdzZHQTVVbXpneDVmTnkyd0ZzZUoyZUtLNnJTaUd3Y1hWVjBxc1JZ?=
 =?utf-8?B?R2toRHpRdm9JdnV5bnp4Sy90TWdzanoyd01pVmtnMFpIZHg1eHk0Vk1YbWlo?=
 =?utf-8?B?MTUxNGVkbXdtT1cxM3pnN1JZZ2I4V1JkZnpVUStJT3JtY09rb1VzNTJVTFRZ?=
 =?utf-8?B?N0l0OGFpMjBxUk5SSEFSV08xdUJDU1NwQnJaaitDZC9ZcHQrbXZmYXl2YWNl?=
 =?utf-8?B?QTNsKzV3cjZEc0VPOHVFNUZ4Ym9EMkVpWVMrUmVKUEc5eUV6ZzI2c0RSb0Ev?=
 =?utf-8?B?QkFjV1NuQTJ5ZTgvbHpqalo3eUNHVGwzQzF6ekQ2TnRTeHZ1OFY2Sm9yemhB?=
 =?utf-8?B?SC91SDNuYUt6UUljeWQ5TmNRQmUrL0RiZHZlajVUYnhMWnU5THdCMS8rZjk5?=
 =?utf-8?B?akYzVDZqOGZwYm9IM25HenlGZGtGQ3lxamxYN0Z1a1lFeFdGKzI5aW5JaWFl?=
 =?utf-8?B?V3BOY3VEMnBMSXpRZU1ZZ1RpNkhFNXBvTW14c2d4eldrOTZRdndBcWMweGhr?=
 =?utf-8?B?R2ZWeXlrL09CK2RWVFUvVERVQ1JwbGs4dUI2L3hZN2RUckxkNUk0MmMzcUxm?=
 =?utf-8?B?L3k0R3ZMZVNiMkxpb1ZTekljTGNiOUxnQnd2VTRUbjU2U2pBV2sxV0xVSVZN?=
 =?utf-8?B?UnkxbUJJK1dKMkRac0VpWG9EK1psSVJETEw2bjBQZFdWVFpXSFBkT3M4QnFG?=
 =?utf-8?B?STVmdDlaZ0JRbzlLbkptNnp6UTJiYnhoZC8remxJQUdTdDZmdW14eTJUN0Z5?=
 =?utf-8?B?KzhCTVlXa2pzSDRCMnYvaVZYb3o1TTVSemhZYVFCRFAwZm5nMTJOUStXM2pw?=
 =?utf-8?B?bFBEVUhQQ0xNVkpZYVBsb1hFRWFpNnNpZU1ubXBZTFRvckZBNzgyUHJyS1dH?=
 =?utf-8?B?UFVBdTYrd2dSaWUxdFByc3NaL3Vpb0pyaStxN2E3QVJXd1dlSHQvc1YzeHZJ?=
 =?utf-8?B?a3plVnpLV1l3MExySXhWMzFvUndGZ1JjMGJ0bDdLTEtHekYzUmdzdlZvamVK?=
 =?utf-8?B?MExCbDBONE1GK2o5TG1yN1RrbEdIcmNZTjFxVXdnakVrSHdXdHRETm1hMEZt?=
 =?utf-8?B?UXlRZi9VcDRBV0JDdXdMWklvR2ZPNHZmUTByaXNTTTI4Y0xPRjZqaDZSZzlr?=
 =?utf-8?B?ZDRHUG4vSWJBbENYbjM2UDRGZHh3eTEwL2d3Q1ByVzlaSG5WaXFscU1iMDRJ?=
 =?utf-8?B?THNpcnhyN1BnTFV0Q0dacHNtVVNLT2xLUmYvQWttQXk3TXdidmczay9OY3dL?=
 =?utf-8?B?Z1ZzeG5XYTlGeGpqNXNkckhQVjhvcjdsZVpreURibFJXaFRoRWxBUEhvNWMy?=
 =?utf-8?B?OGRZQVFsQVhnQmNOdzBjOW40VnptOGN3anBNOHBKQWRvMWJTMGxIRi8vbHhy?=
 =?utf-8?B?U3dJeWRORXllTEpWVkFYMk5CVjFwK21xYlUxV3VRUkxLNTd0MWtYUk1jRzZ2?=
 =?utf-8?B?eEN5SUFFSXVmOHVLNmhTWlNielM1N2R3andBQ2dycHRPTXpWb1NhS01wcGVq?=
 =?utf-8?Q?A286JmUvhvFcoOOjLqsR3sWH/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f97b8b4-1afb-4ab3-7fb1-08de37bf2b5d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:38:54.0368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M29nyVK4iSRJVhgJ/TZLjpY1pkvz9QxizzhzLJCwO52nTANgjTgwlDtQo7Kv48Iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

Hi Heiko,

On 12/1/25 06:53, Heiko Schocher wrote:
> Hello Michal,
> 
> On 26.11.25 16:12, Michal Simek wrote:
>> From: Padmarao Begari <padmarao.begari@amd.com>
>>
>> Add a timeout mechanism when waiting for the RXDV (Receive Data
>> Valid) status bit to be set before reading data from the FIFO.
>> This prevents infinite polling loops that could occur if the
>> hardware doesn't respond as expected.
>>
>> The timeout is set to 1000ms (CDNS_I2C_RXDV_TIMEOUT_MS) and uses
>> the wait_for_bit_le32() function to poll the status register. If
>> the timeout expires, an error code is returned.
>>
>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   drivers/i2c/i2c-cdns.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>

I will take it via my tree. Please let me know if you want to take it via your 
tree and I will remove it from my queue.

Thanks,
Michal
