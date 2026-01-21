Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D1FD262B0
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 08:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407E38341A;
	Wed, 21 Jan 2026 09:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3PqY/4zM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8513A8397D; Wed, 21 Jan 2026 09:21:58 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244CB82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 09:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQVi61jSH3VhcwQ0UboBV+Y6wAUBJomxX/l8jSDmZV6I/qZ9vmtLv9ioqzweDVyjW6qQ+zWiaVxLoAel1HkG7xPCm/YfonVFeLcck8pfUdtgpayxRpkItnCWzNThORhobL0bDTxXsQ3Cc5mO8YItZYWhxURBwkdOaDZAARuANVHH6Zgv9AcnqnjD9w3x/XZ5k1YYvIrlr3rxNKQp43cqzdj8kFQtW5dhZIuClgh2md1A6REY2CKuL3H/aUXGtqX3elnMlP0vXXeajn1k1//5FnjGh5K1za5RktV4vedB94PMIMWwgO5AFXhXC+cI6A4C3irIEtTr3B1a6dN8Sw7xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSoORm35Pt8HeBfQMF7OnKq18oIk2imylGiBhCjNua0=;
 b=ewN2dwmUNpvqu21T9XYh8QFi3oJ7mff1WRT6y/PY2meLIr09cpeg0KJCcDKXOWIGPG0cEwuDD2VLQFM2uS5eTrgnt8aW9S/H2eGIYRrCaaMJNQYgg2tG5d3KPSxbWe4BExZqksRq3eGP4oIA5RlUaZ36L+LDDHIajLKMDF23ySlDG2CsWwYoBLAM1whD2c2R1GHvPpe2JBDd7VHhYCd7GOh6rwNEi8R97Q/mE3w6zjRUxzOu/OcePIP2euUa73mXNXrzPxfOWYaJhgOs5h2mqFmfmyPOR17iI5rHIRbkFPgDM5cyQ9wan7jux8NuXZWyQuxDb8yTO40t49ufr3pDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSoORm35Pt8HeBfQMF7OnKq18oIk2imylGiBhCjNua0=;
 b=3PqY/4zMplxpYflJetgz0jemExZe9GVVz8UbaxImKyMIOiPiODkOB+5vlr83Jhdx29y8Qcb57OrsuiEfVHwZ6/bKKmJ9gJm/idH+1DZoGssbf0MHf/PALFHZ+evMp00i8ZjH/ThrgQixIwXGHiTeetRLi5wB7psYBjpsylvdVtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:21:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:21:53 +0000
Message-ID: <c2add900-50d5-44bd-bab3-52737e739b2f@amd.com>
Date: Wed, 21 Jan 2026 09:21:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/clk/Kconfig: fix "related" typo in help text
To: Peter Korsgaard <peter@korsgaard.com>, u-boot@lists.denx.de
Cc: lukma@denx.de
References: <20260119095437.2775081-1-peter@korsgaard.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260119095437.2775081-1-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a40bc8-eadb-4397-d125-08de58c62202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHNpRmNic25JV2RnV1RVOUdya1RpUUVJSUFiY0c2QWJBb29nM1RnMlhMT1Er?=
 =?utf-8?B?S3YzUURmcGhBU09NbysrNzluREorNTJ2bFBoeUwvWllLUEsrS2FJcW9FR3Na?=
 =?utf-8?B?V0d4bFk0Q1U3Z1RRWWJiWDZGbGNwNjNCejFJUWpUZjlNTjJOVXI1aHlEZzhM?=
 =?utf-8?B?U1FjVEVxUWpvSFY4NHJKNzE1NjNKU1B5R3J1ZTJqWHhFYXVOQ3FQS1RrV1N6?=
 =?utf-8?B?TXZDTFlGQmY1RXczdEE4RE90UnFOWDdRWU5tYmdHdGtTc3dpbzRYWTJIWjRX?=
 =?utf-8?B?OTFWT3JzWTdSUnladEZqVU9MeUM5VzVJRnhCTWVtalFYOCt3SHpqako0RlBk?=
 =?utf-8?B?Y0xYYzh4bDdpaXArOGxvOWJBS1NYUTdDOVdQUzRzWU9ZZHBacVM2TmRmeEF5?=
 =?utf-8?B?cEoyV1pXUm5YWXFVRk5DQU5RbHZqdUdJanhpaE82aExYSDk0anRvRy80WVEr?=
 =?utf-8?B?dVJZZ0NvTmxzQlZ5K0RPdVBSclZ4czBJUXk1djkyd1BURWwzc2czcVNaSkZH?=
 =?utf-8?B?SkwxRTRNSTBmWkdEdmEvc1ZnUFdqWXJHd3grcGhhVkVib0VLMzNBRmdrczdN?=
 =?utf-8?B?dkd5NWY0Ukdvd0lIQkQ2ZWhDcE0zWlNmMWR4TUcyS0JRcG9uZzhLWmQyd3JD?=
 =?utf-8?B?VzVqekI5eCttYjY0ZU1aandKcHRlL3lVaGxpKzdGbzFHeFM3RTU4STJpYkVp?=
 =?utf-8?B?V3B1UmdNb0NmWFYxMjRrSW5rVXBRV0s2S1VneTV2amd1WkU3dFNLUDYyZGZO?=
 =?utf-8?B?QlNZVCthQUt5SjkvME5ycEFTSGlFNTRDaHAyWk5lVE84a1JBK2tueTRud1dI?=
 =?utf-8?B?dlVyK1Y0VXVWa0RiZ2htNGo5SFZ0Q3lTSVp5SHRYNUJjU2p0RWNQNFU4WWNa?=
 =?utf-8?B?TzR2WXQ0SzFPaUNtRmJOdy9lVlNGZ0VyUFJlVEtPRGFZNThHMXNSSUgvWEta?=
 =?utf-8?B?TDdXRFlEQWlhbmlFemR6bGt6QXIwaUV0NmVqVzE3dnh5cDNJTitNSVcvRjBH?=
 =?utf-8?B?YTUvQkgwdHQrWmdoOEpRS1J3dTFCUmpWWnFHTCtucDVGQkNXeTY4Nk5tYm5O?=
 =?utf-8?B?Sm1uYWRKaTgyY3FERFJRTTBGT0JJMGtzeHExbDJlMnQzNXVZYW95SnZwZkhO?=
 =?utf-8?B?QzZWTU1JTHZpL3ZIRERFMzgzYS9qaDZ5YkxhUGJLZDdCS3k5a3ZDMjk1OENw?=
 =?utf-8?B?T29DVzgrVE1Yb0NTRmNpWFFhNFlIZXdhWXFvWmdMK3U3NzZTREw1bTFrZWNE?=
 =?utf-8?B?bXc4blJhd0VUaUlVR3E5UDRNQU5wS3FyTWRYakl1V0k1QUx5MWZ4eW8zRjVl?=
 =?utf-8?B?ME1BSStMUW92SWNPRG82RlhoR2hNWlRVekJtVXFDTXZkOU1qeExSTzRUVlR6?=
 =?utf-8?B?ejlpZjV4U0FNV3BHVCtRd0lhYVBJK1ErRnJvWCsyQ3A2VFR1V1BVdmdzQy9o?=
 =?utf-8?B?ZStoWFlPU2k4YjBEM2RpMSs2Y3NXcC8yM2x4NWFXbE5rclgzVURnbk5IMlcr?=
 =?utf-8?B?WnV5a0tyV1Qvc3lXUm1ERE9MRlFrVE5zVEhHc2xYS2hCN0VKVTVJb2diaW9t?=
 =?utf-8?B?ZHM2RWhCQkhsNU9yTit6Z0FmcHduck5XdWtORThPd3RVRENQMmdGb2JBKytV?=
 =?utf-8?B?ZmNESjNQTDBFcjAzVFMwOTBycTlKRll1UURkOS8zTkdXTmtyY0VBMm1EdFRi?=
 =?utf-8?B?NmRjdU5uczNsSStzQ2dXcHoxK2R4bEIxS0ZLRkJzeElzV2pVbVFSSVo5UEo5?=
 =?utf-8?B?aldBcTJLdnRNTzZITHphWTl1UTN3a1hNb2JKajUvMnZOQ2lQWUtESUljTkFN?=
 =?utf-8?B?dDIvd0FPNDJwcmNaUHNYbWhjdnEvbFgyTGhadmJtWlhlczN2VjBXVTFvQWJW?=
 =?utf-8?B?bFJZM2xsU3M4dGdTRUNxWnlWRjgzcEhadGNEdFFaOXAwYWhBWGdTUTJKWk5Y?=
 =?utf-8?B?N1ZQQXl0RVF4b1B5L1pncTRudFdWTDRaOUlPQlhmb0NFNndKM29lWkppMjdn?=
 =?utf-8?B?cVY3UU5KdVVTZTF3cElQVmlpRGRCbFV3ZWgweGtyVDVWUEkvZ2NKNjJuL3Yw?=
 =?utf-8?B?bjFGNWY4RzY2YTlqWW01d0xFZzQ1eGs0OEZjaWFhKzZkbHZtMFBjaXZsSEFJ?=
 =?utf-8?Q?bku0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1c3MVpNSkJ5bEVSdDl6RUhTYUlaVnlUcjhKbWdMa2VTOTAzTktSY1BHODhj?=
 =?utf-8?B?ZXhSbitkaVBsRzY5ZG5walBuV0NGUW9YeTNUVndGMW1LK3lGOWVrZ095aVgx?=
 =?utf-8?B?T2wwSnMzUlBpK1Q2VlhKZjNmWlRzRjFRTG12clZHNHhwUjRvQmJmTTIycVdL?=
 =?utf-8?B?UUk3WXZRNzNIQzdBOFgrQkhJVEl2UE92cFJsUkFKd0VSb1l1WThBelRlbGw0?=
 =?utf-8?B?dkhoYXdrL1ZkSzVjRXdSQmJ2cUpqS09NK1piMHhNUStjdmVjS3pyRW5acU8r?=
 =?utf-8?B?MjNKbFBVQ2RNbXgwT2lLbWRQY1hqUGRwdFZXcHNpbTNXV0RFa3UybEFpS1pT?=
 =?utf-8?B?YjgvNHZiZERiZHl5cEEzbEpHRlJaK2M4TWlIdUZOTnllWC9CakJ0Vk9RaEZN?=
 =?utf-8?B?TnozVzNCaGxWWG1RSml6QXhuYllnYlkrUnBOZzcycjl1clFDRjFQVUM2dzhW?=
 =?utf-8?B?eHZoQzlzR0lWRDlmRGpFUkIzdXorL0lnRlU0TCtRQmwwNVdHL3U3ZUpTcnc3?=
 =?utf-8?B?MEFWSW1XRWNndnVOSk1SM1lHRWNoVTBTU09vMkJlZmZrT09tU0VwUFU5ajJh?=
 =?utf-8?B?QlJyN1JKcnh0VldHb1daVmhRaUlUMU1UTW92RXg5Mzd2ZVNmbjBIdld4NEM2?=
 =?utf-8?B?T0ZuZGFVLy9mKyszOGMwZHFGcDZWU0l0TU5GVGlxblNrZ1c5NFNSMlRuZW8w?=
 =?utf-8?B?Y3RrclIyWWRydHJtQ1BZTEwyZ2hmSmR2SEorc1RjSitoOWZpTmo0NUtJaVhr?=
 =?utf-8?B?S25aaVZXNUV4bG5hNVVObWtobXdrVjJLeS9VNjc0ZjI2ZnpaeStRQS8rQ1hX?=
 =?utf-8?B?ZEZTRVByM3FKRDlYZk9ad3lpcWtZY1k4bWV6NVk2ZE4vUEl3YW4zd2NrZW9q?=
 =?utf-8?B?ZUMzaWNjQW1NMGJ1MncxajVyeWpGaFAyclJoejNTTzhqL3E3ZDg3M1B6YnlB?=
 =?utf-8?B?TGR1b3poVEhRNUtFSFQ2NjlDSkhXbGJpNTFVdy9GQnBieDNGTWRzZDNPdyts?=
 =?utf-8?B?clY3K01Tdm9WWWdzSDYwVjF0Q0Z3MVBaMk1GNkxiRmdlSFhJdTg1OXlqdWRO?=
 =?utf-8?B?NEY1U3dJRFZFZnVoOS9hRyswdE1qcnE5TFYrbG5ZRElwdlpPclBkd1BMelVk?=
 =?utf-8?B?Q0hNNHFPNUU1VVhGNWgvMU5oTzF2U3NEc05aTXJ0TWZ1d0dyRjF3UXRwdXZY?=
 =?utf-8?B?OThoR0F0aGMyRkV5TXMwZ2loT29PMGYwaEUxbFp4MVN3UEJad0tzRjdNME9C?=
 =?utf-8?B?dkJVeGxwMmQwZVZqNE95VzVYRzhKUThRd3NySmVvNDRpR1FkU3RGZmpvenZS?=
 =?utf-8?B?dTY4VU5KWmROWURoem5Wc2tPeE04SGdWaGNMNTFTV0tSTGlwRC9pVm9VQnBF?=
 =?utf-8?B?WDRpcW1kRmxUdGpBeGRiNm9PSGpuK3F3VVNWQUNrSGNCRm83MHcwTlpWeElp?=
 =?utf-8?B?QnYyRncxYnpLWDVEYkNjMFlFU2tYcVRiWEwxa0NLQW5CbGJ4TFdzTnFmV1Nz?=
 =?utf-8?B?dThFMGlsVnFGY3FTdDJORVQvNnZtUG5pS0JWT3lVNWFJb1E5L0I1WElhd2Y5?=
 =?utf-8?B?NUJNWlBYQXltZERLejhIcDNDSm1YV2UvYS9BN1lzdWVTZ1ZlNVVWYzk1aTNx?=
 =?utf-8?B?VVlTR0VBckc0YnpybDJXTktoRWhPL3B5UUtHQjRlL2toOVBoWGQxc0QybG94?=
 =?utf-8?B?QmZTbDJDRVZkSGllOHZJZUdJTE5BSXFSUk9mNFZUb2FheHJYY1pzOE1XOTFR?=
 =?utf-8?B?Vm5BYURQMWNjTC9BSWdKOUpJd3dVVEdJY1RHQTVFMnlWdjhkRnVHb3pOc0pI?=
 =?utf-8?B?eDRXWGd2b1JNSDQ3b3N3N2x4SSsyRlBualhNNlhsRE04Y2FzdVVyaWEvRmcw?=
 =?utf-8?B?OFAzMnk0ZFRoOWZyaWRvWnpoTWErU0hpTkNvVUNhTFB1cU1LVktUMUtSa01h?=
 =?utf-8?B?bk5DRlM3bVh3UXpReWdydDNEbVdqTXNkVTFNdERFUFphWk4vYlZtWnZ0UmRr?=
 =?utf-8?B?Ri8zSkxEbWNkZ0lvTXNSU3B1QjBrUXlIRS9uS0tOU0FTM3gvRWtLNVdGWFhq?=
 =?utf-8?B?RnpFbXFyMkQ3ZHJKc1p6VGY3N1htNUNWUVg3eEp4RnhwK0hCVnVxWU1IZnF3?=
 =?utf-8?B?aDhBNE5UdnQwOWtwVUJSUGNhNklzbkJkbEdTQ2IxS1NhM3JBMERTMm9PVGNO?=
 =?utf-8?B?YjBvS3pVVFlNemFpUFRHYXJ2eW5EVFJqbkU1TnE2aGR4YnZGaEVuK2duQmla?=
 =?utf-8?B?SlBtRXJUZnlhZm9WbUFRZENCcGlJKy9TdGNwU29mc3N5OHUzVTlLY1hSMnoz?=
 =?utf-8?B?VVFkK3MzekE4U1VNVGVnVGxKejMrWVl4Q3g1alRlaVQ0dytKdFpNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a40bc8-eadb-4397-d125-08de58c62202
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:21:53.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEHp64h+VUuOjvY/nsIbsonXR+h9MM3CwIJz0Ll6QcABg3eDE30R9G5hDP+cCc8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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



On 1/19/26 10:54, Peter Korsgaard wrote:
> It looks like the original zynqmp typo was copied to versal as well.  Fix
> both.
> 
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
>   drivers/clk/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index ae783254008..c88931c8ec4 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -228,7 +228,7 @@ config CLK_VERSAL
>   	depends on (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
>   	depends on ZYNQMP_FIRMWARE
>   	help
> -	  This clock driver adds support for clock realted settings for
> +	  This clock driver adds support for clock related settings for
>   	  Versal platform.
>   
>   config CLK_VEXPRESS_OSC
> @@ -262,7 +262,7 @@ config CLK_ZYNQMP
>   	depends on ARCH_ZYNQMP
>   	imply ZYNQMP_FIRMWARE
>   	help
> -	  This clock driver adds support for clock realted settings for
> +	  This clock driver adds support for clock related settings for
>   	  ZynqMP platform.
>   
>   source "drivers/clk/adi/Kconfig"


Applied both.
M
