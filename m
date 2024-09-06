Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D1ACE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 06:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0541D88CFD;
	Fri,  6 Sep 2024 08:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypLkOUwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8039E88CFD; Fri,  6 Sep 2024 08:54:31 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5682A88CF6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 08:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwiDN6J3b0HyX1wEkmTFYqsBAK5S65A0lrPhE0jb4b0LRIdIag03dl0ZFht4YxIdcPTxyGy0QVNaev1Jj/MYcSIzC0Mh2yITNkDNFHaxRo3uttRWf8Mf40sjuxzxyn3BYRB1Fa5tFxBtL29zwJC07Xky7DDHjWSA8tZ1NZopesaaT2h/BkvJQUlQ9q8mNyqt6Xx8RlkfVxaLqytifKsAtJgIgN2qNtDPF4FibRy0X+KvDUfyDCEbQbIon032mv7FBUUkqt1ZN09cRMD5DnIwUfFNslIsqWwCKb6kNHkpgoHz2vruqtxwVN2cCWIOfrImtTiGcKv02/KZK341/jO1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r69bnGF4oWQfmC9AgPvodFgNQmAB8CIDDUCAOhxYRck=;
 b=iC35PSYpR7eU7f2tomDXMeY2zGPmbGkAw7iJRgkJqaMzyWsVozgWxqKYaupYz9oDasSF+EZyOIIvgUew5eyJCRb4Cbq//o1WbOxUzYvMCRoN+eIKy08wi0m9VUmHY0pKpXGvd+WqA2cB1TABQZRhk0482RqR0JcT2G1VtnerI/oHioU4+zFLbKLS7FoObKGrl9L3YSmAJxIg4v58eb7cNSdygonFKCgJPBj/36Dms3mAHDXYcSRwFSN4LsQPxfsLot4absOC2V/LHMAY4UFiVsbJMg98GhYb9ivxRfZaNdpx39Dgkh73JStPFG8cfLPHOe/duHTHPEwCZsykXv7WFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r69bnGF4oWQfmC9AgPvodFgNQmAB8CIDDUCAOhxYRck=;
 b=ypLkOUwSwd64sIKOen7I+I6m3etszgrKOd+bGpvJoR2755IMT/66lvIjnwccUkCiV/xaMyMdPoL3GYTMXYGiy0ddXvrE7enbG8wjeFf1OhUAFAEJT5PTwVlr1u8R2MFdZVcrrX/Zlk+ATKA3cFnrAmnSyrMwk69W22wSszINFrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:54:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:54:26 +0000
Message-ID: <33797fdc-dc3c-4156-89df-65c19c07439e@amd.com>
Date: Fri, 6 Sep 2024 08:54:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable SIMPLE_PM_BUS
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <b9f4bb85be502616edf3be2b79e52a0e2c03e821.1725349691.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b9f4bb85be502616edf3be2b79e52a0e2c03e821.1725349691.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0eb1d2-00bf-4b2c-b2ec-08dcce40bf57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnJ2R093byt0eWlmU2dkWHNvdDVTdG9OdjN4ZHNEOHRCZnJRckJ5NHlxSVhV?=
 =?utf-8?B?YU9uQkJSWGZiT29BaWJPS0JaWi83OXVhUWZpV1Z6MVR3dUwyUHpETmhtYm5n?=
 =?utf-8?B?QWlEZG9rUUVKVzFkVW5yYUh4ZFpOaDNHcnh4RnBZUE9yRm1RdmF3NWd0UkV1?=
 =?utf-8?B?bFRiZ2ZubGg2SzZEb3JKS25SSVNQa09udGZxR2VxbDJHeWZzNVRmekxkUEd4?=
 =?utf-8?B?RHRpOFJaeUNiQm9wK0tSeGo5Q0JodG5QYTkreHZKRytQcVFESFdxU0ZybjBa?=
 =?utf-8?B?V093dldkOTVqR1VFcGYvMjJRYndOWGlqa2ZYYlZEMlNBOUJUTHMrcjZWN0Uw?=
 =?utf-8?B?Zzl5V1ppUDRKNWg0cituVDUwdFZ6TXY4Q2hLMWQ3ZTZkN3pnVnZEZHRrdWZG?=
 =?utf-8?B?UEhQbndFdXVQajRQVEdDVXd6ZlJHTTgyRXpaaGpTVkR1MElQUWJMSjB5K2VY?=
 =?utf-8?B?ak9aNERDN0R5TGg1bTI0L0tDekk3NXQ2RHY1UCtqeHhBT3dBM2c2bkl4SnFT?=
 =?utf-8?B?R056RWRvdGlEOUNZUmxLL1l1dEJ6R0JZVzRnTlpLRE53L0RibkFtYkE0YjV3?=
 =?utf-8?B?OGpORUp3d251cUtGQTA4UGhIRnROeUVzSUg4NUZjSFAzdk92SmhXVVk5Uzlt?=
 =?utf-8?B?T1RqeGdFUm5rejhMWXdNRm9rSUIrYTlmcnJiZE4rTWtvZkduWEY3UFVucVVs?=
 =?utf-8?B?TzNnUVZFSis4aVVJWUs2aTdyYzVHclFlTXh6em9sYldYQ1pMZm1NczNVT0ta?=
 =?utf-8?B?NXhBVVp5eE1LemtRa0ZHbTRwVXhqNCs4Z0tMSzhxUy9oZjBFL2NHRml1aWlQ?=
 =?utf-8?B?MVY0MWlGMThJTWF5eVo5TmhWOWtSWUlLc3g0TmQyVmdtck90bWNzbW1SVHNl?=
 =?utf-8?B?dndTWncrVDk1TWNsQUZjWlRhZlNJOXp2SEFvbWRQazJzdTRjN3Z4SUtUT1c3?=
 =?utf-8?B?YWdkcndTdGhGVkxWcW1wR2JZNlEzbU5NWng2TUhCSmx6U0g2cjRpMXFQZUhl?=
 =?utf-8?B?RUFNZzdZMXJYcGZiTW5JOHIwQXRJOEt5VS9yOTh6UlV4RUNwVVgzWXJWZTlx?=
 =?utf-8?B?MFd6ODc0UjhhUHZBcGpTa2lJYWJ0OHRzeWhSQ3VSWTdtVkRFZE1MVDhWMjBl?=
 =?utf-8?B?YkVhNGtaUDM3QzZoWS82Rlp4U05melF2SW5tUzk1RWN0dUdPWnBJSlRCa0tE?=
 =?utf-8?B?TEhrbU13bEZGamNKNkthWVVpMkJDVGZTeG11eDZDYXlwdWZGUG55MXNGbFlx?=
 =?utf-8?B?WWEzVW1IMGFYNnNKQk1MZ0JqTnc3dnVjTFdiMEFwZkh5YTJkZVlWTi9UUVVh?=
 =?utf-8?B?MjZtOTdlMFhMcnFkSmE1WHpXWnpBVWVYUlhwdWs4L1hFWDd6SDhLUk01L3dS?=
 =?utf-8?B?RG1PQXZOOEFzY3FYTzQxNEozbStBaERCNnlwVTg1V1dXQXBNZUJreGR0bmNx?=
 =?utf-8?B?SmozWWU5dHBXem1UTmxJNUprbHZQRi84b1NOR09Ld0dEUFZRcThtRDdYU0k5?=
 =?utf-8?B?TDl2R3N6cURuTi9kNTNzcGVWNEgyVG43Y1hmYmhVOHNWZ0JDWE1Ec0QyVGE1?=
 =?utf-8?B?OW53Y0hTYXVqMndhZnNlSHFLNmh2aW9INXFzTEcrL2hmSytYOUMvZTZuaDJV?=
 =?utf-8?B?UEdyNWF6Unh4c1ViQ24yRzRyLzlyVjE0cVRWRlpMbGh3S1Y1WnVqcjhhVFBO?=
 =?utf-8?B?OG5hNVFCbTZSU1JLUG4vMnZlMlRjcVdkR1FZZml1cUw5U04xcUlzRFVuYWRT?=
 =?utf-8?B?bWJJTk45ZGFaRFpzR1Y5QjA5OCtmajlOUVFWdW8yc1NQWlRubEFZd2Z2YXpy?=
 =?utf-8?B?Nmd1blJHc0pMSzZXakd3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitIWnMwZVJYb3RKZkdReXZUQStYV21WeHZ2bEU2RTBRYjBRV1d4YzlidjJr?=
 =?utf-8?B?Q0NwUmdnOSsyajB2UlBkS1RCWWVJc3ppQ1M2QUMvSlF5KzBtZWtTSXBqYTA2?=
 =?utf-8?B?Z1ZQVVg0aFVmRnpMQ1REaGFDb3Npa2FqenR3MWNCeGFJNUQ5cXpDQVNBbnY0?=
 =?utf-8?B?c2NobUVTMy8wR1FUS1dHSTB2aENmV3hDcnBmSDE2UHdvTzU3My82YTBWSWtV?=
 =?utf-8?B?ejM0R2pHM0dIa2JDb0N5bHNpYm9JaGcybTAyaUpvVzVxbkRxeHNMWnplME1n?=
 =?utf-8?B?RHMzMWgrYnFKMlo5K2laQmZjOTBJdmNBbWlsRVQwcTNoUlNsVTFzdFJZc3ZG?=
 =?utf-8?B?bWRLYytLY1R1a1dkUUh2MHR0a290VU5BMFNZWjRxKzVMTVlLb3hZb0wxR28r?=
 =?utf-8?B?enV0MlhuNXBldDdwMGdzQmtNcHJaN3FoTnpSV2lvY2NDaDlRSk5xK1AzZ25h?=
 =?utf-8?B?Wm1JeFhVUWVybGt3bEtZSG1IRHhHdUx3YXZ0VmNrTFhtOS90K1UyOGFvbVlL?=
 =?utf-8?B?d2p3U3FITjdKbzhJVWVCNUtoSzRSaXlQWDI5Wi81WUZUVlV5ZHRVTGhZVFZx?=
 =?utf-8?B?VkplazdqaW1vc3hjSlhpalpXYXpuejZYUkpBUStUVDRtUjcvSFh0WkVtYThO?=
 =?utf-8?B?T0RrN0tqWXp1eFh5OXNKQjR0MVJ5UjJQZTA4OFdaZTBvb3VDbEhEZmVCL2N4?=
 =?utf-8?B?L1FHMkJlMmxwMUxuaGs4MlFPOTNZemo1Qy9Pd1FlM21Uc01UcW5EN012ZWdX?=
 =?utf-8?B?QkpFQjNqcEoxKy9xcVV5OURLZVE0em5iTmRJSVY1bkM5SkR2Vzd5L2Zmemdi?=
 =?utf-8?B?MlBiOVdEOTh5L1VjSUoycmttWVhVNlJkb1FVSlV1MllyUko4bnFHODlZMnRI?=
 =?utf-8?B?UUp2Q2IxWU0zNFd4U0w0ZXY3RTBsbjlrYktZc0hZaC9VQUdwK0RKNVk3UHk1?=
 =?utf-8?B?Q2NGcUx5WUcxL04vWHRmL3NBcTd3YXJyK3FDNUg4c0d4Z0hYY0lIUlBWaXRW?=
 =?utf-8?B?MlBuWEhROVVvSlg2MGdseEtjV2RPVlZxYXBUQ2UxNU15WjhjQldQYzBnTHFK?=
 =?utf-8?B?M2lHTnpBcFAxRkdWZXl3RzA0NEtLU0FyK01zWThJRHJBY2w1b1c4YVpYbHdF?=
 =?utf-8?B?Zlp0U3pmZmgrWXR2bDBqUDdkdU9pWFVmS2dlUUozWWZZUHZGcFlDNWF5ODI1?=
 =?utf-8?B?bStTVE9XNStZREptODhDcWExenRJaXd6am8xWnJlTlovaXNFSTFJVmYrVWdR?=
 =?utf-8?B?SUFjNXMvUlRzdXVQMmEwS1crODJZbnJQYlI0dHlmcUl5WXorc2JYT3ZrNHVj?=
 =?utf-8?B?QVNUM3ppclNnQ3IzQmo1bmdHRXp5S0w4VmtGVW9PV2plbGh0N0EvakkrRGhQ?=
 =?utf-8?B?TGtOMDFLb0ZHeWdmYzN0T1dHdWJ0YmRrN1RhQk5iRGc2WHM1eUEyMjVGSTJE?=
 =?utf-8?B?YkFwUVNmTE1GRVV1QXo5cHlvcWtOWUVZVDdIMm5iNzZIRFpmNG03T0MwUFpt?=
 =?utf-8?B?SHYyenRqVHBMM3JuUzZnWTJZL3E5Wkd3M1B0NTVEYlRScHZaVjBEQVFiUzF1?=
 =?utf-8?B?Mm40RmVsUysxQnRwV2dRUklSRGUxVEVqUVZYL0Rza3I4cDdmb2xTb0RSODFz?=
 =?utf-8?B?NDN6RHhUNE1FVHVkSmoweTJjMVQ0emNRMUtTOXhBb1BZeVlKcDJqZmkvSjNP?=
 =?utf-8?B?Y20vWTZCV3NmK1g4ZkdTeWxZeDBXZkttK3FMY0ZUd0Y4cG52WEhtN01yN2hB?=
 =?utf-8?B?T0FYK1Z6Ty9rekdidm93SDd2Y3VhMWhzbTQ4TS9vTXBHclB1SlJweVBXVDJa?=
 =?utf-8?B?ZFpDMCtmSlJ5aHlJd0tHQWQwVzVsSlEvK3AvUDJuemU2NWQ1VCtSQUJKMG84?=
 =?utf-8?B?WG5CUjJNU2VSZ2tCamtxY3RtQXZ3Y1BZK2J0N09QdFM2aGc5VWdUME9HdHl0?=
 =?utf-8?B?OGFaSW00QWFTeThxbFNNUFgvblhaRllPZm01MmhIVVpDYjFDeHo0VkxHR08z?=
 =?utf-8?B?OE1XNGRIeHIycVVmenBCc0lKeFIvMmxTeHFxamRJY2oxT1d0Z3ZxSDQxbkw0?=
 =?utf-8?B?MG1kZHhncUF6RGtFd2c0Q1hwM3cyZzlRNlRWbVphc05majFVUzFCU2FwZ0pw?=
 =?utf-8?Q?JLf1C0VGrgoITlUckIvznUcnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0eb1d2-00bf-4b2c-b2ec-08dcce40bf57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:54:26.3814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZP8XRP0jnzroA7523A1EmZWzKnQH2wnpHMOZIygNQdOlBcKG6DGgy3eW2/s8GsJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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



On 9/3/24 09:48, Michal Simek wrote:
> Enable simple-pm-bus driver to handle case where axi bus coming between PS
> (fixed) part to PL (programmable) part has own clock or power domain.
> That's why enable driver to be ready for this configuration.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig       | 1 +
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynq_virt_defconfig       | 2 ++
>   configs/xilinx_zynqmp_kria_defconfig     | 1 +
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   6 files changed, 7 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index c4bf77186cd5..78f6ffcc3a74 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -72,6 +72,7 @@ CONFIG_NETCONSOLE=y
>   CONFIG_IP_DEFRAG=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_TFTP_BLOCKSIZE=4096
> +CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_CCF=y
>   CONFIG_CLK_SCMI=y
>   CONFIG_DFU_RAM=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 40a9b16b9cf5..776af9ae29fe 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -73,6 +73,7 @@ CONFIG_NETCONSOLE=y
>   CONFIG_IP_DEFRAG=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_TFTP_BLOCKSIZE=4096
> +CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_RAM=y
>   CONFIG_ARM_FFA_TRANSPORT=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index dc1754f6d18a..0d4591411e1e 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -72,6 +72,7 @@ CONFIG_NETCONSOLE=y
>   CONFIG_IP_DEFRAG=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_TFTP_BLOCKSIZE=4096
> +CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_TIMEOUT=y
>   CONFIG_DFU_RAM=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index f8b6a3f1aa2a..b2921df1d0da 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -94,6 +94,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_NETCONSOLE=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_DFU_TIMEOUT=y
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_RAM=y
> @@ -138,6 +139,7 @@ CONFIG_PHY_XILINX=y
>   CONFIG_DM_ETH_PHY=y
>   CONFIG_MII=y
>   CONFIG_ZYNQ_GEM=y
> +CONFIG_POWER_DOMAIN=y
>   CONFIG_ARM_DCC=y
>   CONFIG_ZYNQ_SERIAL=y
>   CONFIG_ZYNQ_SPI=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 4c66c536d0f6..5a07edf5cd21 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -117,6 +117,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_NETCONSOLE=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_SATA=y
>   CONFIG_SCSI_AHCI=y
>   CONFIG_SATA_CEVA=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 1133134e3fee..491206998da0 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -118,6 +118,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_NETCONSOLE=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_SATA=y
>   CONFIG_SCSI_AHCI=y
>   CONFIG_SATA_CEVA=y

Applied.
M
