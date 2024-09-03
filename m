Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF0FCD3436
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 13:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1CE889ED;
	Tue,  3 Sep 2024 15:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CSKHqWS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D2788A0A; Tue,  3 Sep 2024 15:52:05 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287868806C
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 15:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bskjrlbzniif3SUPxflSiuZy43d3sBQx0UsAnxLHlardpHFPZNHI1MZnt1uWCc4TddKjdRO17J4oTcSedki+lmNrk+2A7EhI2ZeM0nwfjmMa8v53UOnVWF1N0SdEjcbYBF8LtVla4IRF7bNEEcqjJd6Iya9UO7QxqLUfAMjv5e63+M1mcOCCHf+Lk3xCIMTN4Yt9qTIIm64jP95Ad/KgWB3y9A2/N7XkSFYe92TwCc2jCZnywNc4gy/KWr/K35/DDrztI7eEzsINYuRbOakNANXRgceXdwXVqPsvCrJLH4Z1xg3vZKv2hclh33T8CkeCEFrmn2gZTngkqNBYuaNbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMJeCm8H93BU9h6jHX/YqqsKVffLPzZWsqkfQ48j7g0=;
 b=oMJOEQVG0mRTlAQTffO7lSDVoed4lz/vZtHmQDJAhCRx0UP7zdFQCC4sq6VEOPnlSW9D0PbzmlxtieKu+B1lNruiNOPs37Oy8QCKXm6byp0CU+eQhFD6zZSFjhvP98EUxV5wA2KmWF26gM/6sNRkeWnnTWO1xnOa97mgrIZhwRWySpFjGQUsQToNDHRTfo6LOaezUfQ/v4GgIgZMftZ8fG+kapZs6V7hmyS0k7L6mKRhzjIiPTDCCkHednuNAdQyUCQVB+/WMF1UA0n/vkjzdRuE6HjKSC4FGk7+CW8stHP+2+yXblxS0XP7OEIHf7V8FcKVjK8ZqMaFaDD4BOHkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMJeCm8H93BU9h6jHX/YqqsKVffLPzZWsqkfQ48j7g0=;
 b=CSKHqWS7o4qvJN6VmwVD7SOwgV5KHe4HYKdlDPcVSiqm16YgTE1Dq7yqWZLKCDQ/s6lCpJlqCHN+L2qv4tViZOqjpUKSkKtCjdCdGIE+kfijSM4iCvi13L0PBtaOlTMqswbhI/L1guhJt89wWmi0dl4ntJxEfdujosiOM4uONi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 13:52:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:52:00 +0000
Message-ID: <f6c4b95b-9748-4cbb-b3f8-7f69b6c4c451@amd.com>
Date: Tue, 3 Sep 2024 15:51:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fwu: v2: perform some checks before reading metadata
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd4eb4b-6b49-4866-c496-08dccc1f9571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmNwZjlyQlVsblRkZ2twdDVaOUFsM1F6bVYrcEJSZ2lFOHBWSGJTNjRuZU42?=
 =?utf-8?B?bU5TcVYrT090ZFBpcmxic1g3WS9GZDEwMVlMUTZUVktQNkdaaEIxSGk0b2hu?=
 =?utf-8?B?ZlJ4NkhCc0k4b25Hd0s3RHVQUW9SWm4yZSt6a0NSZmMyRkxGdFJHYUdIUjY2?=
 =?utf-8?B?R2ZRUUZnMW90ckpPWklIaExKNGdtUExXd0ZDb3pNUWo2Y2prQzlycmFXdCtz?=
 =?utf-8?B?eWViSTd2UThGWmY5Z2ZiMjYzd2lBWnBtNE5md0ZEMnNIVEN2LzQ4MDkyUytS?=
 =?utf-8?B?Z2tNcTNRMElNbnJHSnRmWVdSUGJBck0raktFWC9GQjVlNDFOZk1sMlVCYVpR?=
 =?utf-8?B?NnkzRk1KZkhwV2c4QU9qQ0MrS2M3SEpUdkNTR2oxNVRMSmtLVWJqb2hpZXNa?=
 =?utf-8?B?YXpxSmkzOXZtQWRvdUdBdGxXN1hib09vVkFtY1Z4SEg5MkJhUDV5VTRRc0Zt?=
 =?utf-8?B?OFh3RG93Y1MzdC82SExWczBmVjlVeTdiMC9xeWsyYjd6S1pGZUg1Z2JWaFlO?=
 =?utf-8?B?UDdCSkJUKzBDOXRLZnQwRS9pUGY4cnJsWTdVWTZCZVlKa0ZGTkdyMTRQWXBK?=
 =?utf-8?B?anVsS2w0Wm5uN050TFZ5MFBiQmxuTjQ3RzFtOUFhVysvMlhacU5nSGNsejF3?=
 =?utf-8?B?ZWMzR29wWE9FY2k1UFZFejNSQzd3RW1LSU5Dc1N5YU9Sd3k0UFBDN3k1SXda?=
 =?utf-8?B?VUhmWXFWZXo3VStsVVhoRVhmTUdPQ3BJaWNpSEJaL0FWbUI1WmFTNmVvaEtN?=
 =?utf-8?B?L001VWE0UVB4a2pvUnoyUkV3d3BTWVUxdEtGTHVZclJ5Zi8zSTNNUjZhVDhT?=
 =?utf-8?B?NTVFaXM4d1lnRy96NXN1MGo0K3RDMUhybkFTbFhyWEhySU5XSENBOWJjZWdP?=
 =?utf-8?B?RWhxNXlvUWtnMStDYnlxZUhrSC9VTmFGajZkREw3cXBGa1U4eHpzZzlwbmhD?=
 =?utf-8?B?UGVYQXRQQUlET3BZR2h4MVEzN0ltZm5kVm1nV3BncDRqNFdkQVJuV1B0Tm5H?=
 =?utf-8?B?QjdTT05GcnVHc2cvU3RZNWR3QlR0NFZncWxXN3M3SXRaSnNjV3o0d21iTCs0?=
 =?utf-8?B?aVBERjVKL1R3STdFb1MvVzNBb25kVmFxSEhOMXNXc2VNNkdrWXU4SGpoODEz?=
 =?utf-8?B?SmRneDJPZnpQN0xLTTAvRDlOV2s4TmpLa1lDRWZuVE1iTGtSdXhpdHZKbngz?=
 =?utf-8?B?b08ydng0RVNQNnZGZ2sxdVExaHhxRllSTFA2L1VjR2pOaWxzU1k0amZ4bUZN?=
 =?utf-8?B?QlZueW5ZUHFHNzZ1cFhaQlB1bGFLaG9GYi96cG9FTU1La3cyRGlDQmdYWkFi?=
 =?utf-8?B?eXFCQmJGTDdGYWpwbmp0Q1VHMk1tenZhS3UxcnBLR3NqUGU1L2RxTnN1RWEw?=
 =?utf-8?B?YXFpTWgxb2JpMDJsdG84NEthbERSRVQxMUlGR3VYUUhWeE5pQzZ1VmxZZ0pp?=
 =?utf-8?B?V21kNGU2VUVSRFFEN2hqdUZNZThJL3ZGZ2h4NEFqS2duRTU2dG1aSjdzU0c3?=
 =?utf-8?B?UDR4TVJNS3RlSHBKWXJnejNUdDZ4aXI3M1R3NVVZVk5vREN1cHBnbXg3RWts?=
 =?utf-8?B?bGpVQ2pqaFl1N0QwaVBlYnk2WVVVM1EweHI4VysvQURjbGxBdks3dWx4R0Y4?=
 =?utf-8?B?L095Zlk3dnQ4cGhycHVMZzVkQk4wQUE2bWFNR1B5VHpBdFp5ZHRUVHBuNFpF?=
 =?utf-8?B?cUd1alREUXg0aDk2VkZRb2NzbG90UjFQQTZkMzRCdDVIR21ISnVpRkZSL1NJ?=
 =?utf-8?B?VjFSb3l2dVhPTS9TYWRrWjhzZDJBbGtnaTQzVGN2UFJlbFozVXc2ZUIyYjdU?=
 =?utf-8?B?VHJ3TzVFOVFGdTRKRzZ1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9CNkxkeitQalAzRWJQQnVWTnIycGhIRkxmZ1RUeXdOVloyYXJNS282RU9O?=
 =?utf-8?B?MW44Tm1YcitMbTl1d0pycWFBdFRPMXhXUUNGL3dRclNMeUdvUHNRT2c4OWdw?=
 =?utf-8?B?UXhDb2hGSmJSUzR1cmpNT0w2M04xMDN0LzNFR3dVUEdkdFQ2MC9ZeXFHeC8z?=
 =?utf-8?B?cE9yOG9wODBOSTVHMVJYUDg0VVJMMTFIeWRUeEtQQlMrbDloNFlPNDZ3d1Nj?=
 =?utf-8?B?NWthY2pzemtRYWtkbTlCbTFPVFJkNEc5V0l5VDVtU1JCYTVPYVlXMk9pcTQ4?=
 =?utf-8?B?c1NFYzZVRHd1Y2VuSWF3RCtFWkVZM0E3bzZaNkhDLzluS2kwWHI5NTB0enR3?=
 =?utf-8?B?dFVwQStlYjVleFl6SG5oUXNFSjF2R2M2TlA0UHpoNDVjdmtmamFiTWNycXNt?=
 =?utf-8?B?MkRuczRNTHdxWHFleDYyTXQvSmpJeFZPRXVRVDdjYVIvZWJ1bGhHRHgvM2VV?=
 =?utf-8?B?Zk9FVVE5U0tNUG1Ua0dSTGxvYjh2QkhKWUtzMnZqZjJVYW93L2ZaUEFaMVky?=
 =?utf-8?B?SjNYQWNjc0NTeE1wbXF4b2RYUGR3SWZEVHZ6Nk01UGFjd2M3RlgzM3VwYTNI?=
 =?utf-8?B?M2lJRzd0dW5nSG1LdHhCRjNybFVCV0pMd09xZnczQTB4czl6R2R0bDJEMmt1?=
 =?utf-8?B?MUcxdy9EWXl1ZmhreVVSczI3L3paZFZQM2FCd3h2VXRUcDBneGY3TllRQVl2?=
 =?utf-8?B?aGNYOGpiYU1SVXU4YzMzdUhLbTg5cVJpQ2ppZWV2YTA4Nno5MjdVMEN6QzFS?=
 =?utf-8?B?NXNobkF2ZkFIbGYzOGZzL1lxN0hXS0Z1YWdyVE94MUJWSHE2cnN1WVdzdWpo?=
 =?utf-8?B?RlEwK2pRYko1L0JqUjVaSi9kZE50UEdqNmJ4VXIyVmlUWUY5SkgvVEpFVEhK?=
 =?utf-8?B?SGNROXZpYVpBcVpLTmlLdlo4MUhOTjRVcTdDZjJXa2J5UGp0YjRPQmRYaTE1?=
 =?utf-8?B?UHQwSk1TUW1jL1pNcW5mMWR1VWFJQk9WWWdBdFd1Nmx2TDRlM1RMV1o4WlRu?=
 =?utf-8?B?SVBmTExpWUNoSzU4ck82LzRsWmxFZGxNQTlHZnR6SkcwTlhTQ284dXBORDQ2?=
 =?utf-8?B?NVdwbVVFTW9qQ2FCaHZjSElSTkNCQnZVcjA0bk5xYXY5ajMyZkMzSVhVMVNJ?=
 =?utf-8?B?MW9sd2ZnVU1pSngxMUpSMDNzTENmak1jQktkdnlqaUYwR3NnbzZYZkFLTlo3?=
 =?utf-8?B?Z0w4ek44YTUzZkZKb3JQNXYrQTdROWVvbXZWQmNlcVdxbkliY2N5amhjQzM2?=
 =?utf-8?B?Rjl5ZXdMR3ZjOHErYkxlRVJPWGJzVER6djY5TkdKZlNBMmNFQUtidzh3WWtD?=
 =?utf-8?B?cmgwVitXUUJkY1ZmeUE1WEZMTWpBSkc0MDBDSnl1VGNsZkFaVVBrRS9IaUZI?=
 =?utf-8?B?TGpydmZLRUN6QmVyS0NPNS9MMVFlN0NkakliRTRyRVg4ZjMzUXlmM0dxRWlU?=
 =?utf-8?B?eXVHbHJTRWxHaWI5RksrOXg2Q2Fyd2pEZitoQXA1ZzNmdVM4N1NmL3BHaFBH?=
 =?utf-8?B?TS9hQmZTY1hJY21DQjRyZ2FFQmJQMmJRKzEwb3ZrZjlpN3Z2OWQ1NG9tMk00?=
 =?utf-8?B?aVdZNHlUdEpmdllaV3lJNk01dXg1SjhsSERRMUg3Q0VYSzN2Mk1QeU1oN3hF?=
 =?utf-8?B?VUVBZWdDaWM1MTBqekNKcU82Z1puS2tDQjNyT0pLaWQ1NXBiTCtiOFozODB6?=
 =?utf-8?B?MmtuRHF6WnRvWEZjVTRHSGdTRzRZUER1dzRSc1hsZGkvMGhicVIzdlJ6UE4v?=
 =?utf-8?B?MEp3OHZ3VFBybEdNa0JtSDhMUFl0dm45VVRMWkg5akxuQVJ0c0xabUFYSllz?=
 =?utf-8?B?MzRROHdpUkt2bHpxNEx3U1h6alhNeVUyZVJSeGxGYnRvQndnNFFZTWxaWE5q?=
 =?utf-8?B?S1llZHd5ejZ3dG9paGVYd2hqMldhOTUySi8xUGZVQi96S2MySHhxTjgrVTV1?=
 =?utf-8?B?YjZoWXBiUk5MV05qb2dBZkwrUHcyY2YxWHJOZDlVblJnWUIxeEZMMi9WdExO?=
 =?utf-8?B?eDFlQ0VCVkdiWWRMeHRLV21vTDBSNWFDVUhxWTlDUUZCb09zQ1gvOVZMSWxy?=
 =?utf-8?B?ckgrd05pRzl5K1lFUlM3RlpublJhTk4yZ08wWVdkMTlYT1hEbWJadUF5VlFh?=
 =?utf-8?Q?PqqLdUhzKbyvipD3/31CfWMB1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd4eb4b-6b49-4866-c496-08dccc1f9571
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:52:00.4461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfNAHVTrcUjZZFVZk5X48OeHp260l1fzJ5akolJbS5NaPnx54fWihXVX7h3xbJEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> The version 2 of the FWU metadata has a top level structure, followed
> by optional information on the updatable images. Perform some sanity
> checks on some of the fields in the top level structure to determine
> if the rest of the structure has to be read.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/fwu_updates/fwu_v2.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> index 108bc9bb4a..d0d8a25929 100644
> --- a/lib/fwu_updates/fwu_v2.c
> +++ b/lib/fwu_updates/fwu_v2.c
> @@ -58,24 +58,6 @@ static int fwu_mdata_sanity_checks(void)
>   	struct fwu_data *data = fwu_get_data();
>   	struct fwu_mdata *mdata = data->fwu_mdata;
>   
> -	if (mdata->version != FWU_MDATA_VERSION) {
> -		log_err("FWU metadata version %u. Expected value of %u\n",
> -			mdata->version, FWU_MDATA_VERSION);
> -		return -EINVAL;
> -	}
> -
> -	if (!mdata->desc_offset) {
> -		log_err("No image information provided with the Metadata. ");
> -		log_err("Image information expected in the metadata\n");
> -		return -EINVAL;
> -	}
> -
> -	if (mdata->desc_offset != 0x20) {
> -		log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
> -			mdata->desc_offset);
> -		return -EINVAL;
> -	}
> -
>   	num_banks = fwu_get_fw_desc(mdata)->num_banks;
>   	num_images = fwu_get_fw_desc(mdata)->num_images;
>   
> @@ -238,6 +220,24 @@ int fwu_init(void)
>   		return ret;
>   	}
>   
> +	if (mdata.version != FWU_MDATA_VERSION) {
> +		log_err("FWU metadata version %u. Expected value of %u\n",
> +			mdata.version, FWU_MDATA_VERSION);
> +		return -EINVAL;
> +	}
> +
> +	if (!mdata.desc_offset) {
> +		log_err("No image information provided with the Metadata. ");
> +		log_err("Image information expected in the metadata\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mdata.desc_offset != 0x20) {

In 2/6 you are introducing this macro
+#define FWU_IMG_DESC_OFFSET	0x20U

I think you can do it directly here and just use it in 2/6.


> +		log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
> +			mdata.desc_offset);
> +		return -EINVAL;
> +	}
> +
>   	ret = fwu_mdata_copies_allocate(mdata.metadata_size);
>   	if (ret)
>   		return ret;

M
