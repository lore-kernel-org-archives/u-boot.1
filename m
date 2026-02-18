Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317F0E9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C33383AA9;
	Wed, 18 Feb 2026 15:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxy0j0dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6188B83CE3; Wed, 18 Feb 2026 15:18:57 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B769E83A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWxp7t1yG0UElPhCUTr/A6qLxRrXIaBLAvAAHQtt2NYLtZ1uPwUeOs2FNYZWu6dQXLLT9DlzuhmmUUBwdQ17QaD7aChWI2jBy3wQmerQ7oFVEuDf/2WOePjUw/WKW5MDScgGREHCoVsbkE9KS6utLUKJXJokL3SYQp0C8QuUA+9GJxnvH7B/dG2ps+GAp74VH0aL/phZ5K4Kww7lGJZNFwO+Tp3Kr0320+8pgPeR5w4/W1Od4SYieZoUfZXufK2uFlVDNsKCfn37vhY+0y2Dx4VrGlIJTK0n4S/cGcCc17nhf/o5BiQ90wL++lvYRSJ3OxATfHqQVCwozpj9Y4muOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/VW9HjhlC7sCdL+qwkuUwSzYeltBLwA5dpcsvw05sQ=;
 b=Cvydpn1MSivB3an9BFa3uGtj6K2P8o98vSE+oAvDRHfPGU6G3pQRNUSys7miOjyF4QaZqHM4QeHKRKj5CmKGVXRpzsDUlQJRVXqrycd1LKjXejGqQ6wQH/AyMjSaYy9Pj2zaQEGbDoo87u4p/hv0pM6oFIfo5uoouUTNrZlGhu3GiGy2RC1hqh8q/mMGL+6Wx9L3UHW/eKk72pWqJdgKik09kh8ybKyAcJB3ng1jIooC1PimWqdVTm4C9HQt5ILI0+tOj5yn1ipXE/lEqnYGel7oYNcXpMZXZmAoRVKqH4wOKuxRhVFQW1G2H8MpMiyrEg0RJ3QvXcOWmsMrmZvDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/VW9HjhlC7sCdL+qwkuUwSzYeltBLwA5dpcsvw05sQ=;
 b=uxy0j0dwa6VeEVhO7N+WlU49J+ZA5EN24kjvDSO2SSc+Aj2SRuuI7pSyrmCtCMcmXqE1/9bQMxgwr7+IA4Pbkx3zKRs1WggIM7jq3lxbeTWoGZ7ysJ6DAADtGSoaCf2zggx/sCdC/paeEeWi62VqaG/+/f/FodL2bNbfGVMdH+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by SJ5PPF816B88375.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 14:18:48 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 14:18:48 +0000
Message-ID: <363a86e6-8ebc-4b76-8bc9-34e317362b71@amd.com>
Date: Wed, 18 Feb 2026 15:18:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv: Update stack, heap, and OpenSBI memory
To: Tom Rini <trini@konsulko.com>, Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com
References: <20260218063329.396968-1-padmarao.begari@amd.com>
 <20260218141224.GA3233182@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260218141224.GA3233182@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIXP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::9) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 386bdf72-d369-4e3a-cc9b-08de6ef8a21f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXUxdWYybTU5bEV4aTE5R1R6UnlxNU1KbnZWYVFkY2xjNklETDY5U054RGla?=
 =?utf-8?B?bVMrZFAwLzhhSWRocGpyVlB2anZ5Wi80dXBtNHp6eGRWR21WZ3VGUGt1S3h1?=
 =?utf-8?B?dnk2WTlSNlRSeTdnY0h2Nzk4QUlrVnNvWnAvMkhFbnh4TGNyU3llVDJzclZP?=
 =?utf-8?B?T2duZmRzaXVpYitISm5zWEFBNk5RS2p3QTd2cFhSNG5RWG5FaGNzVHZETDVR?=
 =?utf-8?B?cU5JbVh0MEw0SWJiR1ZNbURFcG1sZHV5RWtPSDVybEMxSHgrZ3VlVlhFb3l3?=
 =?utf-8?B?OUVXNTFYdHd1U0VhMi9VNW5VdFlNZVJYSnR1Ty81L1BOM0Y3aXovNzBvWTFy?=
 =?utf-8?B?ZStaOE9PK0FNbnBVNFFlQW5pN3RXcVJGa1phNFN0eE9yT2VWbWRoUWlCNWNo?=
 =?utf-8?B?M0d1Sm9icHlVQW5ldmNuRncrT1VnMTUzeUkwZkVyVE5wQ1JXRCs0bTQ3alNy?=
 =?utf-8?B?Y2NjZGlYbjJLQ0ZXRjFuWm1tK0VVc3NJdWwyUmZSbWs5MU1DdUdxNnJWaUdm?=
 =?utf-8?B?a2gxdDFiQ2t3cW0rVVBPVmRtbEdLeE9lalBKNWFVUFBwd2t1R1JjZkpkT09n?=
 =?utf-8?B?N0U4U3k1MDNrWnRCQmlNQnZmdWFJOXhoZGhpSlFLdlZTTmlrV3VXM2dKQXdS?=
 =?utf-8?B?ZTlZaUR4ZXdMWms4bS92MlI0eWI3S0FkR3dZbFRObXpzUnZyM3hhMUh4NWND?=
 =?utf-8?B?K1lPZGZpRHdVYnc1MU1lQi9CUWxjUFZtR3JXd1RGNWVQbnVHMzk2dGg3c0Rw?=
 =?utf-8?B?dWx0aUllNEVVbDlOTzI1V2FOZHNXUVdocFgyWStMQXd3UnBBQ0VCZ3FrRUo3?=
 =?utf-8?B?ZGdxNnY0WjRvNzNwUTkyZ21sd2tMTzNDTUFjQ3drY2FUaWp1dEtFM3JWUEdl?=
 =?utf-8?B?M29NODVIVEdpWjlaV3hadzBzZ3pvNDFYSXlhb2lldTFsZGl1NWRJL2xpQjk0?=
 =?utf-8?B?d0VuNkR5azdVTW91S0FxNzlmQ3E3QkRFSTNKbldzUjJIMzlOQi9keThURTd6?=
 =?utf-8?B?enVCd2VhbWpwS0pyNHgrZ2xwRW10ejRHb2NwajlTVUZlRUIzVHQ2VWFLN0Z1?=
 =?utf-8?B?OWhOVmV2bEUyV2RXRTQ3K2FBTStYVm9tRkx6OFFkUEI4ZWl1Z2ZLU3daVzhO?=
 =?utf-8?B?eHZCR1Rzbm9OTlY3bHl0ZHluQi8zRzBpOVh1SjR5SHRmZFR3MDBHUG1DOGpC?=
 =?utf-8?B?L2pYbHorODliaWdYOFpOUU5HeTAyaGtuR0hWVjluQ3oyWWI1S1N4RC9vTWpl?=
 =?utf-8?B?R3hYOHN5N2E3Tm9LVEpDQlZ1eTlnYTRtSU1lYnk0Wjdla1cvRzl2bG45Q0xC?=
 =?utf-8?B?UW01bTVvaXk0K3EvRDNjTFg4dDBWWlRDQlpPMnRUUE1JYS9rMFZWQ3hXYVZN?=
 =?utf-8?B?MnhtTFM1U0RvRFNqaVhxbmRJVWs3WWZ6REpqQjdXT2IvQVN4cFI0MU5la2V3?=
 =?utf-8?B?bnZxQysyMnZ0UUgzdmtIcUNtMmQ0MUN5eUpjalNFcHRXcW9FZ1czWVNpOWNt?=
 =?utf-8?B?MmFBRXFmaGFLUWRtQkFIVEhGTHlVaTlpd3NDZnFiTFM3SnBiVjhGWXNlbldj?=
 =?utf-8?B?cVVxRzc2ek5VbU9jUjlXUFJKK0w1TEp3Yy82S2RqWDMwUkY2cFFBWE00Wklm?=
 =?utf-8?B?ZE0rbCtiUi90dHR5LzgxSWZIUG5rZ09UZGpRckZYTEtYaVNZL2ZNQnhvTVlR?=
 =?utf-8?B?MHlTaW9wYkx6YW9UQWdGSlRPWWlTWUF4d2FQY3Q3RUZlYzlQZXdNSHJuOWhj?=
 =?utf-8?B?OWsvaEIwL3luclYzMDJ2bWhqbmhkTW9YaHJmV2ozeVJBWE9XQkFvZXVHZVVJ?=
 =?utf-8?B?VVB3aUoxaXZUYis5bk5MSmFCMlpneS9IcklMU0VsTUVxQVlXUEhyN2lrTFMr?=
 =?utf-8?B?WE5BbDVmNlUwVzN1b2hPUzYwYTk4QkRhSXlqamNyOHQwc1dRQTJVbGR1SzYr?=
 =?utf-8?B?Z3U2L3UzNENlK0w3NmdYVHhWUGdia0J6VHVNYTJhS3A0a0orK3grbVBGNjFT?=
 =?utf-8?B?Ym5TczYrMW5nbW5hRXVkTGZzV3dqQ3BpRk94cldPZGZDMHhQUkZDS1Z0Ukxh?=
 =?utf-8?B?bnNJMzMvQWZIWitUekZPOTZmdFl4V3pIb0dQUmQwM0lROG5nUVVIMS9TNnVk?=
 =?utf-8?Q?Yin4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZEZFN6ZzhLT1NueVJiODk0c2lqYmNxV3g1QjNPQ1c4azRUWFJCV2RHRjRr?=
 =?utf-8?B?U0Z1MzA5MzlkNEZIZ3ZoUHptbDlaV09WbnR4RXlpS0hKMmlZcWZLZGlrZW93?=
 =?utf-8?B?ZHE2SldidDJvMHk2SzAzcGt6VC9TU0s0RmtuTS91VzFzRVFaaGFKWjJvRkNP?=
 =?utf-8?B?aEN0R2s3SU1pNHBnMzc1WGpmamhnajZJcGptc2o3Zzg2eDZYSTVzdkxOZmh4?=
 =?utf-8?B?dXhPMUtHazFvWVZTNGZCWTlFN1RlVnd0VllqRzgrcjE1TTVuU2VmcVNrRXJV?=
 =?utf-8?B?WGxoZmZGMENuUk9PUEJKb1lWaHZmd0ZPTk1SQ2lZRVIveStwSmJjYWpHcVZl?=
 =?utf-8?B?b2NYUlNtVjhJRjNxWEtQUzhld0NFY2JXTFpHYks1TEJIcUtKcE1iZ25Wc0tX?=
 =?utf-8?B?YjFKQklCL2lBNUg0djVoKzBWMlZRS0dpTVJkRU5Kc2FaUytZNll3cTdOT3o1?=
 =?utf-8?B?enRGVUZlVjJiTU5pNDBmU2VlYm1PS0RZZjZ0VDh3aldFZmVVNVpKUTdadlFp?=
 =?utf-8?B?U0hVUkk3U3pZam9vNzlpLzJCWW4ra0VlZGVjcnVEZXkvNDZoZVZSWURJRUJP?=
 =?utf-8?B?cGxKeGcrY2JRUURwekpvQWVIVDJjWGtEb2ZKT1JLM3RGSWNlUk9VUGlhRGkv?=
 =?utf-8?B?UnhzSzdIY1Y5UlFITXJQUlM2TjFDVXl5KzVLcG9sNVpMdGptUzMxZC9XRkR6?=
 =?utf-8?B?Z1I1eVh2YlVNQlFJclRaSE15TmhPcTN4MWliQ09SOEM4WUF5WWRNVEZPTVRX?=
 =?utf-8?B?TDF6MnAycTd4dUxlWFR4U041SDNSNUFNZDNHNUdPam9JQktpam9ZRCtnTElr?=
 =?utf-8?B?QVhzMnNOSTJlaTVNYUZ3ZU5Gdzlnd2gyTUVGRWZtYjZRQmd6WUpDN0RHRmRG?=
 =?utf-8?B?eW1uT1pUZXhVQnJOZzRMazNITW1hSVNUQ3N2dzJWZkhOMXY1R2tQTDdpT21G?=
 =?utf-8?B?bXNQajFyY2xLKzMxNklzT3VPRXo3SG5XUFJacktwOVY3UU1hNWxVcWVaVU1s?=
 =?utf-8?B?WUhyb2x0YjBhQ2JQMkxvWC83cmpVMWkzczlBU2g4c3c5eTVtNmlXTVJNMklP?=
 =?utf-8?B?anZ0dXBjbDZPZ2YyUmF6MEFja1J3UTdTUXVPcDBTTnRiK0p4NUpodmZodDlz?=
 =?utf-8?B?K0FvVGN5Ukl3ZWFGRWdYbzQ0cHhDTElBSGQ1SGV4VDh0RjBSbzRPdGFMVVVk?=
 =?utf-8?B?M25nejcvRytmeUF5MC9UeVJtdjBFZ1l1K0ZLQVpNUU1ZbUw2NjdJYkovRTNF?=
 =?utf-8?B?N1ZLbWc2bHVOOUIzSyszRkpQT3ZJQ0Rab2tlRzJsVlF2aTh6emt1elRqR2hH?=
 =?utf-8?B?MG9UVGVLZk9xdWVCYXRTUC9mTHZBS3lCZWp4NTJBeFpJVFgvYkZIYUFjT3Uw?=
 =?utf-8?B?L2tFYTJOVkZtc293UCtkbitaQ01iYThIK0V4YU0zTFdDb1V3R28zVGNzOVZm?=
 =?utf-8?B?ZDB6c3VDK1ZSa0JyM3hDWlZZRm1kZ3JHN1FqYUZZL29lN2F6QlNFVzVhZE9J?=
 =?utf-8?B?VTh4d21EcVlnZFl5RzcycTVjN0NFcHVuZEZtWDRnQ3FiQzJsVy9Gc2RBd3VT?=
 =?utf-8?B?NXFLcUxUanVwYjF6U2NkKzZMRzc5bkxoTHBiVHU5ZFVKcklUcFZyQkhqYXhB?=
 =?utf-8?B?R0YzeXNpSVpNcWV2c0xSUWRmYlFRR0p3QThsSzdGR1EvWXdxbTBPL1Rhd0dj?=
 =?utf-8?B?c1RSYlM0R2k1d0xGN2lyV0J4ejRJMXpXWXdUdG1oelVxcWdiQjZkRElZZjNt?=
 =?utf-8?B?RFYxSUg5TENpTThPWk41QkxEeXBtYUZ1NXVlVXl1eFlSR3RWZW9rbzVpZURQ?=
 =?utf-8?B?VnBMMWM0Qmxhdmhic0VVdXJzZVh4R3NONXRySVZXa1o2S0xmc0VjaDJ1Y2xo?=
 =?utf-8?B?YkNMdERDcTJXMTFab2FhMU1xMmJYNm12cXdJMk1naUhmcitvcU82aSszWTZJ?=
 =?utf-8?B?TmdEdmFVR0psWUE5K01hbE9qWnY5bDBGNXlTKytVbmZpVXRGU09EN0VvYmFI?=
 =?utf-8?B?TkRzMnkvU1ZDRHg4YkZ6bkdMaGRaR0o5dDArd2tDeTIyWUcvdUdtaURYUEZU?=
 =?utf-8?B?Ylg1L0tWZURLREFPb3Mxa2U2ZXlhMi9Zcnp6bWJEWVdFVXNZY2swNEhzaDIw?=
 =?utf-8?B?L0hUbXV3WG9WMlNPQWt3RGlzMUI5VkhCejNLVlVPYlpDRUlOMHY2L0hUNng5?=
 =?utf-8?B?cnF5SjBQN1UxVGc2cFVoUzNHYTNuM2FlbTFOeXFIRm5GTkRUa3hCSWF3N3lL?=
 =?utf-8?B?eUhjZ29jcndkQ1Ewb2VuMlJOcHBlYllkbzNlRnk0RW9jQytBL29PZDNCWWVp?=
 =?utf-8?B?Qk5ITnBOMnBUZGJPZy85b1VlRm5HVUZlOWxVVjcrczlEUWQ0Q2NlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386bdf72-d369-4e3a-cc9b-08de6ef8a21f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 14:18:48.6843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctn9H0HdcKQOF/5lWM3EiZr1Er2IMY4lLqFm+l4svcZjMiMicCxEtkX1A4gPtuub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375
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



On 2/18/26 15:12, Tom Rini wrote:
> On Wed, Feb 18, 2026 at 12:03:15PM +0530, Padmarao Begari wrote:
> 
>> A 2 MB region of DDR memory is allocated for U‑Boot SPL, with the
>> heap starting at address 0x80000000 and the stack at 0x80200000.
>> However, U‑Boot fails when using OpenSBI v1.8 because OpenSBI begins
>> execution at 0x80100000, causing an overlap between the SPL stack
>> and the malloc region.
>> To resolve this conflict, the SPL heap and stack are moved to
>> higher memory addresses, and OpenSBI is relocated to 0x80000000.
>> The SPL heap now starts at 0x8C000000, and the stack is placed
>> at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.
>>
>> 	_________________
>> 	|		|0x8FFFFFFF
>> 	|_______________|
>> 	|  SPL- Stack	|0x8F000000
>> 	|		|
>>      	|		|
>> 	|  SPL - Heap	|
>> 	|_______________|0x8C000000
>> 	|		|
>> 	|		|
>> 	| Full U-Boot	|
>> 	|_______________|0x81200000
>> 	|Load FIT Image |
>> 	|_______________|0x80200000
>> 	|   OpenSBI     |
>> 	|_______________|0x80000000
>>
>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>> ---
>>   configs/xilinx_mbv32_defconfig       | 4 ++--
>>   configs/xilinx_mbv32_smode_defconfig | 2 +-
>>   configs/xilinx_mbv64_smode_defconfig | 2 +-
>>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> As general feedback, this is something that ought to be in doc/board/
> somewhere too. One such existing example is doc/board/ti/am62x_sk.rst
> and follow-up patches are fine.

Just curious. Memory layout is something what every platform has to deal with.
Don't we have any script for it?

Thanks,
Michal
