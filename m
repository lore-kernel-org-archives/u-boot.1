Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBC2CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 09:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D68582C84;
	Mon, 20 Oct 2025 11:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a92yHb6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2845983043; Mon, 20 Oct 2025 11:38:53 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDB7807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRDutn9yh5nSWsDI2/5wYOclsuZCpsFu9N13B2WubE3pzwnfN6tXCLB6lQJKXi8bkHfAHB8Um4dXCHk9mpjKVeS7zDGI3/A9SHLLBaEhK2A+WI4uOMRm6lKxOTcInHuMdRTo5We1X2Ds3aBf5lnUvL5zC1FA10X5zubmVGiPMTk6FXEDC3SDn7rg25IWzFAK4rom4QXElYo9b2O6tcI123SmY4Q6wULnqDuwkPb4cbdICdF0Q7ucPl9T2WD79Zla/bXeXFPPlZsSjMyjBV1qgzSNNakvBz+NUZs3VXoxRQb0PzsnZ6aBXm2UxdGIk7I5EHBgnGUMXKb8H0VVc6C1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKEIiYQ/loD4db/xvnoW3qbbpTVbofEEJOxAFJDhgws=;
 b=DRufnd5pdf6ZK8XPK8ftdKMR3R3RRM9AfKJ87bBWctj/liBhNWvDlD5HwvsEwbEX5soc7j2qFay45Z9y/0vZ+EML498jxa2MFyUGlxhAWVw/jLIqZf/KkxUR9cw2fEcFW9nZur4FQpZc51IcXO4DMMU5+YLA5BsdxtAFxEeSK6IKwlqdbVsCka6FdVqQQ+Mwvvwd5UM47rWopVaBkgd8ssWqM3iqZsjF+UKKJ0TP1mVbFAVgvzWngA1v0VqHqHz7m+VO2RJfqzXZlMhzew3J6AEFU/IFozwp9KruYLCxOgjiQUaD3DbMUxnt7oqwHI6wHUlTBbSP7wf1v8WcE4R74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKEIiYQ/loD4db/xvnoW3qbbpTVbofEEJOxAFJDhgws=;
 b=a92yHb6Oe4250WkOQhg2OJLv+dkwu2RJARE1UpoXjMmJoHqCAfAYI3SAcD4cl2k79pmih7ciyyO/so/28mJzCev81TJNc0eJKDUm8k9hZ3pJHV5i1/e/H3/UW2bCGgXaCfSFlZsHRl81k8DOr65pySQ6f/3Rkc+hOau9EOJYGdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 09:38:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 09:38:44 +0000
Message-ID: <df818160-3ffa-49ad-959d-3df22fae9100@amd.com>
Date: Mon, 20 Oct 2025 11:38:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
To: Ronald Wahl <ronald.wahl@legrand.com>, E Shattow <e@freeshell.de>,
 u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
 <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
 <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
 <d710f2d3-4044-4a64-a85a-2650b3ca6238@amd.com>
 <2b3d068d-4888-4594-a75e-6c2729bf28c4@legrand.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <2b3d068d-4888-4594-a75e-6c2729bf28c4@legrand.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6c8da2-f472-436b-ee37-08de0fbc7650
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVdydDBKUWFiQnZ2YVV4Z2JCd202ejlVbWNWOVFoT1FlaUVnNkdBdUY3RDNS?=
 =?utf-8?B?YUwwMjN4NUdCVGJUZ1VudHVrMWUwZmR3TTQwV2Y5R015MUtZdDkxTjViMEdT?=
 =?utf-8?B?N0pNSWtUVkJkZGZnVHRiRWZYQTJ3TDdKMFpWM3VwTjdXYURJSHV4bGNKdGV1?=
 =?utf-8?B?bENmNmZaUGxXQkxRZktiNmFoUzJ6ZXY3ZGw0d3JBVnUxQVZEcGE2RXRnbjdj?=
 =?utf-8?B?VXhoWkcvWmp1VVcwRG1xZ3c2LzhSL2lHVzJ0b0lKekdZSW5pa0IyQ3ZsTW44?=
 =?utf-8?B?QlZOMWpxdzdteDlPazNRM0J3RmZrUDlFM1plalRYczFiVm81Ylk4bXc0SFdi?=
 =?utf-8?B?OUtmc0ZCUm9INkZ5QmFpeVBqUDVKOG9kWEVTYmRWY2Foc2xublZWT0U1LzJj?=
 =?utf-8?B?TURNY1R5NUFIa3RRMjkxQldJcHA3N2pFcGV0WHZIczBIMTRPMWFselpxTUJk?=
 =?utf-8?B?VWZhUmJlYkZrRHRmQkwrY0h3SmVMVXZMdGp6aVhGckg3aSt5YXJJTmRPRUFm?=
 =?utf-8?B?dTE5WG5sU095RkNVUHdsQlEzeUIvOUl0ODQ2bFExbkxRTFZYUHhQYjZENEYz?=
 =?utf-8?B?ejhUYlpCWk1ZRlUzK0dCSENqcVhiemhZeVZnYm9BM08vREtTMkNlZHd2bHBq?=
 =?utf-8?B?aU5KUFduM0p0c3A3Qm5xem5KaytwdElRR2xqSzFmdEJNRDVvRGFQbzEydVZ1?=
 =?utf-8?B?d3ByYkd2K0h5QXBWNjRvQTRZNmJudWNvRnI4MUkreVdLUy9PMmVSS1M0Kzd4?=
 =?utf-8?B?WWdGc2hiK2dwSlFOWlRQSE9CVU1PaUJSQWpucExOZ0JoMVNvVXdtUTRTbWF0?=
 =?utf-8?B?T0drbENaZm02cVBpbjRRSWlPQlV0b0thNWdyUFdHa0J4Vkttb29IcjRyMjlO?=
 =?utf-8?B?WEt0ejd1cEtpVy9GVTdvZ3I5akVSNmxzUXRETzVqcHhSWWxMZk9Ed2k0d21k?=
 =?utf-8?B?a3J3bVZhVDcxZ25HaGNOSVo4bHV0Mk9FclpTVlc1UzQ3eUxNem1pZzE3US9X?=
 =?utf-8?B?dk5NVDdXaVlCTm5SNEVSY0QyMWFiVkl1cDdtd3Q1TEN0N0lGNWxRZ0xvLzNu?=
 =?utf-8?B?bmxJMTZXamJ0THlRU09jclMzRXNQM2NuaFBvUHJXU0ROb2pHZnRUNldJRzFD?=
 =?utf-8?B?eHh1VFVqT3VydXAxTW5vSGRNMnRzbWNOQUp6VXlvWUoyUENGM3F3UmJFazJo?=
 =?utf-8?B?UzB0akttRVVPQTBOSDFkSFdzQ3JGTW1iY1JXdmFiOFNQVjdGRWUxYkNKRXd2?=
 =?utf-8?B?NzR5THU2Z3YzVmw2L1A2ano1dm1jNUNaNmVvTHI0c1VpZ1VJdnRiOVVVWlZr?=
 =?utf-8?B?RitRc1VOcW1UUUhWRlBUMjJQVlp1d0N4ZnBNT0c0V2pITWxqZGNCK3BNUmRN?=
 =?utf-8?B?dlJrUGRRSkovb0VxSU9ZeUNpWEpTOVh2bHBjRGlueVkrdlNpRnlHbGFDWHlG?=
 =?utf-8?B?V0lHdW5JeXo3UEJ4eEdzQk5DRmZXOElJRFFURkZHMXpWRExISmgzT1pUQkRs?=
 =?utf-8?B?aDl5TkZPakxQVWRBM2dBQmRKZmM0cUxmVWlZckF0ZUExdTNMRjNERmRkUE1h?=
 =?utf-8?B?U1FhODZWVDVodTFnWGVWSWVMNCtZSVR1NE1mclJYWE1ndVdFVytiTjMxVlJv?=
 =?utf-8?B?cXpSMDI4eWZDOXB4ZXVhOEZxaXBVT3FvUmtBcTQwNG9JVTdvNHc0enNQRzN6?=
 =?utf-8?B?MnBnQndmbjV3TzdsdjYwQlE4cmZWd25EM01IRVBJOGVyRVZNUmVMeTc5Mmwv?=
 =?utf-8?B?dDJtNHVSaDV2WnJYbVcwcUlocXVLcWkvbUQ2bzRjWnFTRS91alVVM1JRdHFE?=
 =?utf-8?B?Q2dwOElOM1lOUEFLalV6TjVHWmVDNTl3cWRVcFkrTnd0d3JZdW90U0ZaejF3?=
 =?utf-8?B?VkQ0QjA2OHBqalJTN290QXhNdTgvdFUrSXYwWlRTNEtZRFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9sbmNveU8xRysrUDBRQkF4ZlRQSHU2UG1Zbnoxc05rWUw1em1sL0hmR0lC?=
 =?utf-8?B?anppdWxuOGZMb2p0eSsza3RoV0taZFd5eUNJNnJCaC9vKzBGdVMxV3dRa2tC?=
 =?utf-8?B?THZYSGNraXYrWFIxSTFzaVdmUzNlKytqcWJOdkpsT09KcUhoNXJlZ1Ardkl6?=
 =?utf-8?B?UGdQU0tIY2x5T3dEMzVtSmdZREtWNWNjZnBXT3NIQzJta1NGV1ZreTNjMFdM?=
 =?utf-8?B?UEQ3bjBiZGhXbmZza0c5djhxNjFhNVlDM00rc1NPRGhVUmR4ZVRKdzZWak55?=
 =?utf-8?B?b1I0UVg3eEZaaHBkV1MrUU91andkVTgwazFZY2hwVEl6RmR6aEt5TGtWMnhY?=
 =?utf-8?B?SmNRdWVUSmRJSkdtNDUvaFM3QSt4dFVkUGQxQ2diNkkraVhPUW9mNkFwS3Mr?=
 =?utf-8?B?aisrbVhLZU9sREdFeWovZHR5V20zVG9Kc0k2N0VOUlZ5ZUUyb0RablFwUnpP?=
 =?utf-8?B?QS94Sk1ESW5uM3VSZ3B4MFZtTWlXLzJjRnFoNXNJcEtZbDFFNU5VWmhuSEV5?=
 =?utf-8?B?a1dxdlYyMzlheG1zZG9JWkFma2hGRFRPSzM3N3czUTRkV2w2czIwRk1kdk9Y?=
 =?utf-8?B?bThWT2dUd3VNU1BFcmZPb3lXdHhwYmpNWXBvUkhIZW93QWJtNmhYcnRHYm5m?=
 =?utf-8?B?UE12UXI4ZGFLalJ0ems2RDhKamttYzBKNXR5MkhQMjNtK3d5aHpGeFIrRC9D?=
 =?utf-8?B?NWU0ekNydVNWZE1wZ2ljVmljbEtPUGUvMkFVT1FvQlRyQllJYk5qYW5EVTht?=
 =?utf-8?B?UVNWVWlIeEc4eVZZMTVWT1RqdFBqREt2Z3FqWEx5MmlDbUFuanlxTDZpcmNF?=
 =?utf-8?B?eWZsZG5XRFJ0eXltM1ViZ2UxaWhveTBNSnQ4L1NoVzhCT0VNZmFZc1lwbGlD?=
 =?utf-8?B?VlFWMnFBdDlscHJEaXhIaXFFR3NGRXJjWWt1bjc5T21qTUJzM29Dd1JXZjNj?=
 =?utf-8?B?QVRGN0NGRWMzYlNsVnNkU0dNN0owVlgydlo5anovWTdzWnRuREZyTzJDNXpw?=
 =?utf-8?B?NWVob3JjZytlV0xtVlpxZmUyeGFyYUQ0Wk9OOERhR2plQVlRMDdKQlh2aGEw?=
 =?utf-8?B?UG11MWNxUVBJcDZ4eHVNRXZpbUxzcmc4RlR6dlVtb3NLdzBpMjNxanFhRDhw?=
 =?utf-8?B?ZWlsK25tM3I2QXhFUG56ZVlqOGF4cGFWMDFKZmVTcFlkTVBHNHJPM0FSL05p?=
 =?utf-8?B?M3U2Z3dxa3FoTnlURWhZU2JyUDBNdHN2cEVNRXZqSkJjWDhRY0pCRWRld0Nr?=
 =?utf-8?B?SjNHSDR1Z1ZQNVZmRnBrNjhyZUR4U1VxV01JUy9IUzIyK0ZZLzFqeGVqSHov?=
 =?utf-8?B?QVoyQStSQStqcnYvSVA3ZEV1aHFnOXdtNXdsZStSZXU0L2dlRU1RMGdFbnlO?=
 =?utf-8?B?WFRPZlJYM01sWGt4MXMyOG8zLzc4clI3MERJZnRYeHg2dURRM3V0WXhpZUYr?=
 =?utf-8?B?dmlZRXNhVlViK0NTMHNvTnZ3UitCY1lOTFBINlRDcmxYZHNESG5aM3UwMWh0?=
 =?utf-8?B?OXZFOHEvMmdLby9ad0s1SXB4dE5tRkJvRW01dm51RVIwMXFycUtRQTBvQmJN?=
 =?utf-8?B?U1dQb3puNGRqWUp2akh3bXhwSXUvR0hoUi9EY21hdWsyVDNacjRVemIwbERG?=
 =?utf-8?B?ZEc0czhhdy85bWpwbzFsdU1NMytPdmg1VHRMcGpWR0REVWdnSUtZV1VCaU9P?=
 =?utf-8?B?bXgrZFZSVFV0YlJoNFBjK2pTNXhSSkdTNi9HNFlreVNFekxERnYvKzIwYUI0?=
 =?utf-8?B?RTZ4V1FYbVd2ZmYvRTgrY21WOVAxK21YUm11dGN3YUtCV3M5OUNYZ2tVTmNa?=
 =?utf-8?B?SEM4Q0V3VnljYklRazgrSWt5RlVQeThacU9JYWxqR3F2M3UyVjRDaWw3UkN2?=
 =?utf-8?B?YjdyMXBHd2J5RTljcU0zVm5uTVhabnp1YXQvYUZhWHpqOS9xV1NZZmZKb0V5?=
 =?utf-8?B?d2JYUXVFbEhhbWNQSXY1aEpmd0hEMzdIVTQ2NWo5YkQ1Yk1KNnJTbGJqQTM1?=
 =?utf-8?B?RkxrRGdUZTV6aUNabmgzRnNCZ0NOREVlYW9ONFhzSlRib2xqZUFsaSsrak9m?=
 =?utf-8?B?S1gycWQzeXZVTENrRnRHWnJJRXpJOVRtbGp6OGMwWGdWeEhhWFhKdkl0MUNh?=
 =?utf-8?Q?ixjHYcK0/LWbtszoASLRniaKJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6c8da2-f472-436b-ee37-08de0fbc7650
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 09:38:44.7536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6izwUn64CmRP1soJkLa0dN9626n7N3eViFpncAOebS5B91/jk/wcC5X+BJVMSme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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



On 10/20/25 10:30, Ronald Wahl wrote:
> On 20.10.25 07:51, Michal Simek wrote:
>> [You don't often get email from michal.simek@amd.com. Learn why this is
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>> On 10/20/25 00:36, Ronald Wahl wrote:
>>> On 20.10.25 00:03, E Shattow wrote:
>>>> On 10/9/25 03:34, Michal Simek wrote:
>>>>> Remove cdns,is-dma DT property handling. Property is not the part of DT
>>>>> binding and it is also hardcoded to value 1 in all DTs that's why
>>>>> remove it
>>>>> because none is also testing value 0.
>>>>> If there is any use case when this configuration should be supported
>>>>> this
>>>>> patch can be reverted.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - Remove other functions which are reported as unused by gitlab CI.
>>>>>
>>>>> v1: https://eur01.safelinks.protection.outlook.com/?
>>>>> url=https%3A%2F%2Flore.kernel.org%2Fr%2F&data=05%7C02%7Cronald.wahl%40legrand.com%7Cedf1107fa8c143a9738c08de0f9cc246%7C199686b5bef4496087867a6b1888fee3%7C0%7C0%7C638965363122564250%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=wloMzuMKR6AGQHJ%2FMurQdgiZrPsQkHvsewR5%2F48TsZM%3D&reserved=0
>>>>> c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com>>> ---
>>>>>   arch/arm/dts/versal-mini-ospi.dtsi     |   1 -
>>>>>   arch/arm/dts/versal-net-mini-ospi.dtsi |   1 -
>>>>>   drivers/spi/cadence_qspi.c             |   8 +-
>>>>>   drivers/spi/cadence_qspi.h             |   5 --
>>>>>   drivers/spi/cadence_qspi_apb.c         | 119
>>>>> -------------------------
>>>>>   5 files changed, 1 insertion(+), 133 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/
>>>>> versal-mini-
>>>>> ospi.dtsi
>>>>> index eec2a08e7c70..6991f6a51db0 100644
>>>>> --- a/arch/arm/dts/versal-mini-ospi.dtsi
>>>>> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
>>>>> @@ -38,7 +38,6 @@
>>>>>                num-cs = <1>;
>>>>>                cdns,fifo-depth = <256>;
>>>>>                cdns,fifo-width = <4>;
>>>>> -             cdns,is-dma = <1>;
>>>>>                cdns,trigger-address = <0xc0000000>;
>>>>>                #address-cells = <1>;
>>>>>                #size-cells = <0>;
>>>>> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/
>>>>> versal-
>>>>> net-mini-ospi.dtsi
>>>>> index 1c94b352dc97..d2d5ec8e5cbf 100644
>>>>> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
>>>>> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
>>>>> @@ -52,7 +52,6 @@
>>>>>                num-cs = <1>;
>>>>>                cdns,fifo-depth = <256>;
>>>>>                cdns,fifo-width = <4>;
>>>>> -             cdns,is-dma = <1>;
>>>>>                cdns,is-stig-pgm = <1>;
>>>>>                cdns,trigger-address = <0xc0000000>;
>>>>>                #address-cells = <1>;
>>>>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>>>>> index 599596f9f087..849bd930edf0 100644
>>>>> --- a/drivers/spi/cadence_qspi.c
>>>>> +++ b/drivers/spi/cadence_qspi.c
>>>>> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
>>>>>
>>>>>        priv->regbase           = plat->regbase;
>>>>>        priv->ahbbase           = plat->ahbbase;
>>>>> -     priv->is_dma            = plat->is_dma;
>>>>>        priv->is_decoded_cs     = plat->is_decoded_cs;
>>>>>        priv->fifo_depth        = plat->fifo_depth;
>>>>>        priv->fifo_width        = plat->fifo_width;
>>>>> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct
>>>>> spi_slave *spi,
>>>>>        case CQSPI_READ:
>>>>>                err = cadence_qspi_apb_read_setup(priv, op);
>>>>>                if (!err) {
>>>>> -                     if (priv->is_dma)
>>>>> -                             err = cadence_qspi_apb_dma_read(priv,
>>>>> op);
>>>>> -                     else
>>>>> -                             err =
>>>>> cadence_qspi_apb_read_execute(priv, op);
>>>>> +                     err = cadence_qspi_apb_dma_read(priv, op);
>>>>>                }
>>>>>                break;
>>>>>        case CQSPI_WRITE:
>>>>> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice
>>>>> *bus)
>>>>>        if (plat->ahbsize >= SZ_8M)
>>>>>                priv->use_dac_mode = true;
>>>>>
>>>>> -     plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
>>>>> -
>>>>>        /* All other parameters are embedded in the child node */
>>>>>        subnode = cadence_qspi_get_subnode(bus);
>>>>>        if (!ofnode_valid(subnode)) {
>>>>> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
>>>>> index 879e7f8dbfb8..10c4ad14cc05 100644
>>>>> --- a/drivers/spi/cadence_qspi.h
>>>>> +++ b/drivers/spi/cadence_qspi.h
>>>>> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>>>>>        u32             tchsh_ns;
>>>>>        u32             tslch_ns;
>>>>>        u32             quirks;
>>>>> -
>>>>> -     bool            is_dma;
>>>>>   };
>>>>>
>>>>>   struct cadence_spi_priv {
>>>>> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>>>>>        bool            ddr_init;
>>>>>        bool            is_decoded_cs;
>>>>>        bool            use_dac_mode;
>>>>> -     bool            is_dma;
>>>>>
>>>>>        /* Transaction protocol parameters. */
>>>>>        u8              inst_width;
>>>>> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct
>>>>> cadence_spi_priv *priv,
>>>>>
>>>>>   int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>>>>>                                const struct spi_mem_op *op);
>>>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>>>> -                               const struct spi_mem_op *op);
>>>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>>>                                 const struct spi_mem_op *op);
>>>>>   int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>>>>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/
>>>>> cadence_qspi_apb.c
>>>>> index 4696c09f754b..58be017720bc 100644
>>>>> --- a/drivers/spi/cadence_qspi_apb.c
>>>>> +++ b/drivers/spi/cadence_qspi_apb.c
>>>>> @@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct
>>>>> cadence_spi_priv
>>>>> *priv,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv
>>>>> *priv)
>>>>> -{
>>>>> -     u32 reg = readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
>>>>> -     reg >>= CQSPI_REG_SDRAMLEVEL_RD_LSB;
>>>>> -     return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
>>>>> -}
>>>>> -
>>>>> -static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
>>>>> -{
>>>>> -     unsigned int timeout = 10000;
>>>>> -     u32 reg;
>>>>> -
>>>>> -     while (timeout--) {
>>>>> -             reg = cadence_qspi_get_rd_sram_level(priv);
>>>>> -             if (reg)
>>>>> -                     return reg;
>>>>> -             udelay(1);
>>>>> -     }
>>>>> -
>>>>> -     return -ETIMEDOUT;
>>>>> -}
>>>>> -
>>>>> -static int
>>>>> -cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
>>>>> -                                    unsigned int n_rx, u8 *rxbuf)
>>>>> -{
>>>>> -     unsigned int remaining = n_rx;
>>>>> -     unsigned int bytes_to_read = 0;
>>>>> -     int ret;
>>>>> -
>>>>> -     writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
>>>>> -
>>>>> -     /* Start the indirect read transfer */
>>>>> -     writel(CQSPI_REG_INDIRECTRD_START,
>>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>>> -
>>>>> -     while (remaining > 0) {
>>>>> -             ret = cadence_qspi_wait_for_data(priv);
>>>>> -             if (ret < 0) {
>>>>> -                     printf("Indirect write timed out (%i)\n", ret);
>>>>> -                     goto failrd;
>>>>> -             }
>>>>> -
>>>>> -             bytes_to_read = ret;
>>>>> -
>>>>> -             while (bytes_to_read != 0) {
>>>>> -                     bytes_to_read *= priv->fifo_width;
>>>>> -                     bytes_to_read = bytes_to_read > remaining ?
>>>>> -                                     remaining : bytes_to_read;
>>>>> -                     /*
>>>>> -                      * Handle non-4-byte aligned access to avoid
>>>>> -                      * data abort.
>>>>> -                      */
>>>>> -                     if (((uintptr_t)rxbuf % 4) || (bytes_to_read %
>>>>> 4))
>>>>> -                             readsb(priv->ahbbase, rxbuf,
>>>>> bytes_to_read);
>>>>> -                     else
>>>>> -                             readsl(priv->ahbbase, rxbuf,
>>>>> -                                    bytes_to_read >> 2);
>>>>> -                     rxbuf += bytes_to_read;
>>>>> -                     remaining -= bytes_to_read;
>>>>> -                     bytes_to_read =
>>>>> cadence_qspi_get_rd_sram_level(priv);
>>>>> -             }
>>>>> -     }
>>>>> -
>>>>> -     /* Check indirect done status */
>>>>> -     ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>>>>> -                             CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
>>>>> -     if (ret) {
>>>>> -             printf("Indirect read completion error (%i)\n", ret);
>>>>> -             goto failrd;
>>>>> -     }
>>>>> -
>>>>> -     /* Clear indirect completion status */
>>>>> -     writel(CQSPI_REG_INDIRECTRD_DONE,
>>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>>> -
>>>>> -     /* Check indirect done status */
>>>>> -     ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>>>>> -                             CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
>>>>> -     if (ret) {
>>>>> -             printf("Indirect read clear completion error (%i)\n",
>>>>> ret);
>>>>> -             goto failrd;
>>>>> -     }
>>>>> -
>>>>> -     /* Wait til QSPI is idle */
>>>>> -     if (!cadence_qspi_wait_idle(priv->regbase))
>>>>> -             return -EIO;
>>>>> -
>>>>> -     return 0;
>>>>> -
>>>>> -failrd:
>>>>> -     /* Cancel the indirect read */
>>>>> -     writel(CQSPI_REG_INDIRECTRD_CANCEL,
>>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>>> -     return ret;
>>>>> -}
>>>>> -
>>>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>>>> -                               const struct spi_mem_op *op)
>>>>> -{
>>>>> -     u64 from = op->addr.val;
>>>>> -     void *buf = op->data.buf.in;
>>>>> -     size_t len = op->data.nbytes;
>>>>> -
>>>>> -     cadence_qspi_apb_enable_linear_mode(true);
>>>>> -
>>>>> -     if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
>>>>> -             if (len < 256 ||
>>>>> -                 dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
>>>>> -                     memcpy_fromio(buf, priv->ahbbase + from, len);
>>>>> -             }
>>>>> -             if (!cadence_qspi_wait_idle(priv->regbase))
>>>>> -                     return -EIO;
>>>>> -             return 0;
>>>>> -     }
>>>>> -
>>>>> -     return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
>>>>> -}
>>>>> -
>>>>>   /* Opcode + Address (3/4 bytes) */
>>>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>>>                                 const struct spi_mem_op *op)
>>>>
>>>> Your patch results in corrupted SPI NOR flash writing from U-Boot on
>>>> starfive_visionfive2_defconfig target board Pine64 Star64:
>>>>
>>>> a040578d8270ed8788d7663808ea63ce5ffd7840 is the first bad commit
>>>> commit a040578d8270ed8788d7663808ea63ce5ffd7840
>>>> Author: Michal Simek <michal.simek@amd.com>
>>>> Date:   Thu Oct 9 12:34:48 2025 +0200
>>>>
>>>>      spi: cadence-qspi: Remove cdns,is-dma property handling
>>>>
>>>> Steps to reproduce with Star64:
>>>>
>>>> 1). Set JH-7110 SoC RGPIO configured for UART BootROM loader mode
>>>> 2). Power on and Transfer U-Boot SPL by XMODEM as prompted by BootROM
>>>> 3). Transfer U-Boot main by YMODEM from U-Boot SPL prompt
>>>> 4). Having `(cd $HOME/build/u-boot && python3 -m http.server 6789)` or
>>>> similar for serving U-Boot SPL and U-Boot Main to save some time with
>>>> UART transfer:
>>>> 4a). wget $loadaddr http://host:6789/spl/u-boot-spl.bin.normal.out && sf
>>>> update $loadaddr 0 $filesize
>>>> 4b). wget $loadaddr http://host:6789/u-boot.itb && sf update $loadaddr
>>>> 100000 $filesize
>>>>
>>>> Repeat steps 4a and 4b, note that each time all bytes are written and no
>>>> bytes are skipped. Written data is wrong and device unsuccessfully boots
>>>> in SPI NOR flash BootROM loader configuration showing wrong information
>>>> to output.
>>>>
>>>> Please follow up with your analysis of why these changes have this
>>>> effect.
>>>
>>> I guess this is because the committer didn't take into account that when
>>> a DT did not mention the property then it is 0 (false).
>>>
>>> I assume TI K3 hardware is affected as well. So I think the patch must
>>> be reverted.
>>
>> Are you using cadence-qspi in non DMA mode? DT property shouldn't be
>> introduced
>> in the first place that's why it was removed.
> 
> cadence_qspi_apb_dma_read is only implemented for versal HW and otherwise
> a NOP. This does not mean that DMA is not used on non-versal HW, it is just
> implemented differently.

ah ok. I see. Can you please send revert patch or do you want me to send it?

Thanks,
Michal

