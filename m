Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EA4D1038C
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A6A8418C;
	Wed, 26 Nov 2025 09:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5CGE+sI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5366484198; Wed, 26 Nov 2025 09:09:23 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A58E84142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvKLAbd1NSIRr4Hg6nQIv/D/3iiS8Nq9dtD4S1yzhrchY2IZdSO7aHgXhi8DG49PCwgX6ssl+LPmqequhB3UaVynLFcCIxSe/9pTNOy3RwKyhpdBYGg4XQ8PzJfETZGV2AsMaGgwFff4YtGrWxwcT7eFC9aGlzwwtbcgLYtSELIbZb6/ZxEEPRtAp0v+IqQkrCEfM7nrmvx2vIWTTJDbDV4Sb7J50pUvMKV3B8TqAcOdMJGKNqJW3OCUBpVV/zhiP9ppa7StmtAprYL7tqurj/Mw73rfRvrN8nNtHUrbr2tK4LP4nN3QgyMooSPBODTvhJKjHch+vuce2fFyncgOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBiAmY/TbCQhet+GQyykVUU2LR+Kr89xVf7vzw2aBgQ=;
 b=VLT3WvhJvlzclfoXGz9ytI2yDhKyyGcqCbcD6mfEg7AVs1hC8r/Pjv1iNkRqf0W83FrLart/HJjLiThTa1cshvYzdwJyJ5Dsh8V4XZllZfaD8fpxnC08uB3gMRvKa0SvcoAKHj/RPttIyf99skFnNSzlMEzpo7iWvyLY5Ym2MRS090B5MnPYDg/fnWKLjjKRmfceMhlYM52MuNl0DYhTMOLPq/MokHFRG4FIAREpLIF/UQcD/ns8I8CuntUdKLo2ty34/pBFVyke8nutHtLacnEb7MSy8vATDz2KSxz3VdmMX2xHTrJ7xxFYIQECe6edDM6gBSHg7ksHl1mOkY2gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBiAmY/TbCQhet+GQyykVUU2LR+Kr89xVf7vzw2aBgQ=;
 b=g5CGE+sIZY6JQdnO/Q9D97GZKDU2p5ZLk1/hOQ9XiQL6f5HQ+rDHMiUz5EBWuzuSWKMXxQfdMmm28vavULsNde16Y2oL8GJHznfbN6QZlNpbvnDrhF7EHNKQl1vuOtrOEAqsB8F6iUq7LJbnOA+rqU8oaSyAZqoPNItvqT+TsmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 08:09:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:09:15 +0000
Message-ID: <3daf81b6-3955-4097-9dda-128469e2e871@amd.com>
Date: Wed, 26 Nov 2025 09:09:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: versal: Add support for CLK_AUTO_ID
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Lukasz Majewski <lukma@denx.de>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson
 <seanga2@gmail.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <647f1d2c7d274c1106558a655386ef92e0baf2c8.1762778011.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <647f1d2c7d274c1106558a655386ef92e0baf2c8.1762778011.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1fe717-23af-4319-2c93-08de2cc3171f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2dPQnBLMmdsc0JHOWxHV0RkR0p0NDZvLy9NeE9SN3ZyMFdmK0VXYlJvRXBp?=
 =?utf-8?B?SDY1K284bm1ld1NVMjA2WVc2TnQ4ZkJXRGM3R0pMZFRCaitiY1NoejRDZUVr?=
 =?utf-8?B?cGVaR1FZK2hSaEJRRU9UbVp0clpGSmhsRU5nUnpOVHE3YU5jT2FUSGlSRTFT?=
 =?utf-8?B?cG84UTExZ3M2bVJtZ3lMYVRhdkhzQkcyZThDZGk2ZmNGN0NzNHFBZzFudnpt?=
 =?utf-8?B?WmhFblBhVnpqa3EzekhkNVNxVFRKbFBHd0J3V2JoeGo2NkJCYlgrcDNDNk96?=
 =?utf-8?B?MUwvbU5Xei9rM0I5NEZhRlN5V2lUTmQwZEwyZTVjenhhNWc3U0EwUDRwZmxn?=
 =?utf-8?B?TTA2TEVyRFA0Z2tHQXRKY2dKaUNsRmloNDRGc0JVRE0xTDlhMFc5bmFPQzlC?=
 =?utf-8?B?VWZPTjR4ZWdESDVsb2VDYU5QekZpVW1mYXFkUlBHM2d5bzFndTZ3bDlZeFBt?=
 =?utf-8?B?eDd1T1J5eCsxVE5jRFV6R2VFeXJubHZxaDFVeC90Y2orNi9HV0lJUEJ0ZjRy?=
 =?utf-8?B?dEw0QWdsdnlWVjFNb3o0NXY1VklGd2tNa2NvNjlETVFrcVRVS0w3UzhtdGJ5?=
 =?utf-8?B?bkorQnpRV0xQZk1MeVU5S05XbEJlTlRHcE5xaGd1VlZ2bnhoYXdXcVJzQVJ4?=
 =?utf-8?B?MDdmb1ppN3hLdGZ5SHEzMEkrbDFQY2lwKzExWGxTVS8yeVFFdVhUOUd0N2VK?=
 =?utf-8?B?SFA5Mi9xQzZXd1VXMVZMM09sai8vY1hncmoyUzM2RE1qcGhuODZPYnVSNmU1?=
 =?utf-8?B?Wm92dmdJelF3UDZzajlObVZIMFdWRmJRcCtEbS9NU0oyOVg4ZWl0QjR2RVJl?=
 =?utf-8?B?dEhzUzNTd3lXaWNBYzBiTnQzd0R4Ymk3MkcxUlhuaDlnKzZIRWlOYmlONFRK?=
 =?utf-8?B?cS85ZG1aUDdMYWtGZndDMDUzRS9uc0R2c0lMZ0dvdVZSR0I3czM4eDVBWlds?=
 =?utf-8?B?Ly8yenZyS0tncnJMS0F1emRibDRSdVRUT0F4elM1OTRJUzJhV3A2YnE2NjdV?=
 =?utf-8?B?UURZemJYRGZHWTVmL00reHg2d3pSQ0ZUNTJ1eWppQ2EyNUVvMVVITUtxU1hK?=
 =?utf-8?B?dWlGS0U5YTVvUDVVcGhBTWxmUE51Z3ZYOE9UMWcwSERRS2Z3dHRLbGdYYXZP?=
 =?utf-8?B?dUlreDlQUy9rTVhXSlY4Wmh4dWZQZWJjbGdGdGNMaWRLMEdtVHV5aHdkdVhR?=
 =?utf-8?B?amFsaktOYWxMYTUrYTJ0cnhqVEVpQksxbmcwUjRNU09nYitXNUZrS0pyZWRE?=
 =?utf-8?B?RUxmWEJaN0JQdWo2OGNUc2FXSFFBM3FJM1Q1L2FvRVFQd3NPSjVLaGZ6OTFK?=
 =?utf-8?B?YVBiQi9kaGpna050eGhyOFdJN2dad1g2MlR3WG5RU1BFUk10UWpIUVBob2JQ?=
 =?utf-8?B?VEtXZ1luVlpsYm9CbW1sL2FFdnd6MkJWdUhKaHVnTDFvK1YrRFU1UXFIeTFK?=
 =?utf-8?B?LytqOWhsc2h4ZzRQR2tqZ3ZLS0VjTkswUE55SG0zUjNjaThEQmxwcWltUEsw?=
 =?utf-8?B?Ti9Bak52bTZvRWNXUVlPOXJVLzRGbEJDcTErYWl5aGNsTmNkTUN3Yi9IeG5C?=
 =?utf-8?B?NzBjTHd6NzZZRkIzSHZ6SnAwRUdBNG5GWnNzQWNLdmhRcnNBcDk2YWhqTGpn?=
 =?utf-8?B?L3VGVi9nVlVDVjR2UWZLRnB1RDVvdDNQV2hlRTNPNkQzZzBvSmNCVGw2Y1Jr?=
 =?utf-8?B?dVFHLzBGN3doNVBVWmgvcktaRTlVMzhnUkNRT3VPcVNiWWJDQjFkTHVCTlMz?=
 =?utf-8?B?bVhSemUzLytidFFLR1c3QUtZQlE4YUlJVGdRNHdpMzUzRWNlemE3TENpMlQ3?=
 =?utf-8?B?aGozdzY1Q0ZESjB4WVVhTWQ4ajFESEVUQXJ4Rnd5ZnJ1KzgwUWJrVktBQ0Ro?=
 =?utf-8?B?dE5tbkJ2OG9yTjVZRU5rMEdqbzVzY3Q1YnBtVk91YnZFQ1FxUkRYTVhrTm9S?=
 =?utf-8?Q?UqK495CDmfVs0x+aEwpyrtS/XOC+7kNE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzBmOVRUOUh1RUwvREdKQ2RuWi9Rb1dyRXF3NGhhTjZyYTgvdm1NcnBnMWRS?=
 =?utf-8?B?dk8xMXRVTWFVMlo2MWxCVDFqU1JUU2NIc0ZqSzByL2V6SVlvVGE4S09kc2JG?=
 =?utf-8?B?U2VFVE93R3QwelN0RW5uOVdUcEhDc3owMFZzYlUxVGhEK1o2bWZrWnBBbWV1?=
 =?utf-8?B?bHFjR0RBZjFTdUZtV1Y4dG5tODMrOUtLVjVtdWxEN1VNK3pnZkxUSW8wRG5J?=
 =?utf-8?B?dTVHc3BaZExSM3NlbnFFSE12YUhqQk1YSDI1MWhJU0lnejc2REdIZ1ZrL2hm?=
 =?utf-8?B?NStVYlU4WHdDbW5pcVBRMnpWdXNjU3lJbmJHbEpoR3pqMjVJMks2L2crN0tJ?=
 =?utf-8?B?cTBlR3BodTI5c0YvMjFwbWxJWmc1VGJjUXFZYXVmSjUrRXpBTVV3cWd4dE9r?=
 =?utf-8?B?U2dpUG1pUldFU0FhdzJDa0hRVUJlNGphMUd2UEkvS1FDMUNUbHQ1RHliQnFC?=
 =?utf-8?B?Y09NWGF6c0h6MHZDZHAxaVJvN2FWcHg2dGxpSmlzQVY1UytxYk5nREg5RDhS?=
 =?utf-8?B?aHZXWTlOWnA1YmJyTythbDlZK1N5SmVxcDVGN0dtR0JnVVJybWpob0pmRWFO?=
 =?utf-8?B?b3lKeGpLMVRwL2lSaWtQNWZVS0VLNWVWNkI2Z2l2S3U5T1VpQ3NYampqNUJU?=
 =?utf-8?B?alcvSE5GSHhXM28rdU8wZk1ENjY5MmJ3T0tjZVp6ZTE4V3ZaMytYUGZpRzBB?=
 =?utf-8?B?cFpFY1dqOC9abVNiRERqaldwbzFnZjhpUlEyUGZ4Ym5SWlZ1UTQvMEpQRm5p?=
 =?utf-8?B?enBMRHRDdDlIRnpkcWdGS29rRGlsNWErWEN6L0NWcDU1WjM3aTg5NjRvQTg0?=
 =?utf-8?B?WFBQenZpdVR2UlNocG05aGNWeTkzMVlYUVQzTXBSRVhNdmNBMFZiZlA0Rllj?=
 =?utf-8?B?YXJTZ0srU0JGTVNsSEFXUElrSzFVVkZwZEJ3dXNzdmJMSWJYaUZ4ZzZoeWZl?=
 =?utf-8?B?RldVQktRRVdSSGlWTUpIUVpRd080SGNJTk1DdU1hT1BENThTclNldzFrOURq?=
 =?utf-8?B?V1R2SGlmdFE1dU9WR2pzTEtLWEptRVlBKzlMTEI0bERWaUVvZHYyQ1ZjN2t4?=
 =?utf-8?B?N2J4VW1la2xtK0ZJZ21WbUk0THBwTEhQVUZPK250dkJqS2FPbmJic3hqaUw5?=
 =?utf-8?B?b3FLdW5hOTJFeEdUV09yOE1iYzNadk9Td0FoRVd1eUx5ZHEvekE1cDd1ZklU?=
 =?utf-8?B?TTVYMUw1R0VjanZ1cVAvc3FCS2JsUS9jWnR3alVNbGczOC9BQTdEa1JtMVhL?=
 =?utf-8?B?ckVQT1FCODliTVRSUmtyZjMrazY4ZUpTbzFmR2l2aFRhL3QxbXA0MnlOK245?=
 =?utf-8?B?WjQyRzZ5T2h3MVREK1FJM3MrTW42RHJyM1lPM1k2SzFtTW5vRXNhLzlqVEVk?=
 =?utf-8?B?SjlzR2pMM1VmZThqMVNvcXdZOG1tNjkzYTBCY3pFVzVWN2JPUDR1TmZUdi9T?=
 =?utf-8?B?NjZ3T2U3bnZMZnZyYWk5MTNYQXI1Vkg1Nk1IWWZqanBNUDNuLzQvbXAreTBB?=
 =?utf-8?B?cmY4V09TdHF0d3l2ZUdSOXVkZWdFRGdnL2FQYm5NbXp0R29lWlc3VGVWZHZI?=
 =?utf-8?B?aE9YaHJOQkpDQlFJb0Rkb2R5d2VmTExWN2xDMHRTU0VKUWVnQzVQbmVwVURW?=
 =?utf-8?B?N3BRcitKVTRUTU16SFQrdlJNbXhxTTBNemdKN3JFT0FhdVdBWVdLWUs0V3ZI?=
 =?utf-8?B?b3hYbUEvRnBNSU9vQ1V0aGtmSEcxUXVSL2tKbUFDN1FFZ2JheXZTS3p6V0pL?=
 =?utf-8?B?blFyTGs0MVlNOHdkZFJUTEY5cXcrSDlzVEFSZUZQc2wzNjZWT25vTlJKZExi?=
 =?utf-8?B?MGsyYlNYb0RuUTZnRXM5alUrcVY5UWNCTnlqYkRYSHVpM1lXamp1WWRRa3VQ?=
 =?utf-8?B?cDRZUVZDSG5QWGtuMzVPWVUyQ1VmT0Y5clZJcXkwamN4YWhxd3pEOWlVRU1T?=
 =?utf-8?B?UGI4TThQam9hNUNTM1d0L0gvMGt3bnMrUVFmSTU3UWgrM0tOL2UwNDJPV2py?=
 =?utf-8?B?c3VLSnYwWnVPemk2R3ZZb1J5RVBxaUZmMXJZNjNxNDR6NktLZ2hZUlB6SjlC?=
 =?utf-8?B?cVp6clZyWFNjWUVsT3VvRFlLZG4vYTg1VDBleVk4ZzRWaS9sOHY2RU9VL1Yv?=
 =?utf-8?Q?AM0qfsCCKC7rGQu84eOzCZSFt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1fe717-23af-4319-2c93-08de2cc3171f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:09:15.3927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nykvvkr6bPm5QWmGu3zWC0eRJsPYx4Jofc0jFoYH2HAMY6Wlurc5lX4MdvPQmc/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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



On 11/10/25 13:33, Michal Simek wrote:
> When CLK_AUTO_ID is enabled 8 higher bits of clk->id is unique clock
> identifier in clk uclass that's why it is necessary to mask lower bits
> which are clock ID.
> Also check that ID not bigger then maximum supported clock.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/clk/clk_versal.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index 339676f1e4f4..139f429d609b 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -731,10 +731,13 @@ static int versal_clk_probe(struct udevice *dev)
>   static ulong versal_clk_get_rate(struct clk *clk)
>   {
>   	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
> -	u32 id = clk->id;
> +	u32 id = clk_get_id(clk);
>   	u32 clk_id;
>   	u64 clk_rate = 0;
>   
> +	if (id >= clock_max_idx)
> +		return -ENODEV;
> +
>   	debug("%s\n", __func__);
>   
>   	clk_id = priv->clk[id].clk_id;
> @@ -747,7 +750,7 @@ static ulong versal_clk_get_rate(struct clk *clk)
>   static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
> -	u32 id = clk->id;
> +	u32 id = clk_get_id(clk);
>   	u32 clk_id;
>   	u64 clk_rate = 0;
>   	u32 div;
> @@ -755,6 +758,9 @@ static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
>   
>   	debug("%s\n", __func__);
>   
> +	if (id >= clock_max_idx)
> +		return -ENODEV;
> +
>   	clk_id = priv->clk[id].clk_id;
>   
>   	ret = versal_clock_get_rate(clk_id, &clk_rate);
> @@ -785,9 +791,13 @@ static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
>   static int versal_clk_enable(struct clk *clk)
>   {
>   	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
> +	u32 id = clk_get_id(clk);
>   	u32 clk_id;
>   
> -	clk_id = priv->clk[clk->id].clk_id;
> +	if (id >= clock_max_idx)
> +		return -ENODEV;
> +
> +	clk_id = priv->clk[id].clk_id;
>   
>   	if (versal_clock_gate(clk_id)) {
>   		return xilinx_pm_request(PM_CLOCK_ENABLE, clk_id, 0, 0, 0,

Applied.
M
