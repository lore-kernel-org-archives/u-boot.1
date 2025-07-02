Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE616C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E29E81FEE;
	Wed,  2 Jul 2025 09:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOyb/oEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFA982103; Wed,  2 Jul 2025 09:37:07 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81C381E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIWEZLFx/LHUIJZ3hd72yp4afVRfhULRHJef1C1kYQkUCEjkWP/fsUddyL71l2J9zbMaLrgwFPwnKSNRqHxC4tf0FYCC3+MCP95M6ucgVnM+OROxFaIDG+FoJ+cBAEeR3PdJUMt8dO87TQLs2QWVg1LpMVIE7kBlcnPZvkOUHclqfBbVuGvUssLjbBxmE2ONP0L6ajJTCcaIUD6reuWAXZVXJANzJ6xBVvaC95tZYz1LOAmUsY+QHc4dQg7HMp8C9C+n1TU2banLr3b5ABtZA3+iO3T/xbpRHlNMviimvEK0D/TlU9eOk+jYJyYSRPJEsRJuUKgUegZS4GKHV/R0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebv5lDSiBOAgUdzdr2soMb8M1YpdP+AkCqgiUYmws+Y=;
 b=IPD5rGKY2arZxc+QC0xKkQMBTS1wG6NGBrth4HufMG4t3kcPDFYnDEF2+s1oIHRcGqWBIhFI71C3cInQ2HTdkzBgX1J0COofQzg4hWSyH9EqD314XIqAoDeorjY0ONTScw0V3ZV6pNLASI0JbIkRxaKgXHRjlI6p2hQIArD03fPvj1EODqH/YkQZ7qWXkT3nJnnBghOYXD2VcLmTpaWu2apdUL8h8z+jAwKYBmx957kY1WxZYSEu0/0Z/yfqWxvgl7utu4nvfxHx+C1j56vrk854h80F1YG/1izV0Kzd3p+uoxArCYTe495MsZ7WNBvDBg568c8Trv8n/SAh8ALkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebv5lDSiBOAgUdzdr2soMb8M1YpdP+AkCqgiUYmws+Y=;
 b=ZOyb/oEG24u7lqcPUOFy6QOl5v0bwZ/H38I42E9TmdT7cwM/pUKlrsfb1WbQ1/SnDSTK1D/XmkxkFooaBIv81Iyhn/O/C5YNHXvIdscflbFk97985QKTWSrzkKwuYDX7vHKg+lmJyAyzpO9qRsk+/nF6UOX/tYqhP97B5M7HlHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 07:37:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:37:01 +0000
Message-ID: <9cdc5507-331b-4856-acc0-082765a2293d@amd.com>
Date: Wed, 2 Jul 2025 09:36:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Remove simple-bus description from mini
 configurations
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Paul Alvin <alvin.paulp@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <a51b11fa21c504a19701ebdccc1e61e899e1aed5.1751016029.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <a51b11fa21c504a19701ebdccc1e61e899e1aed5.1751016029.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea0e0c1-2765-4a88-a05f-08ddb93b3bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFhRTzNheEFpb0xUS3NjdUlaU1k4TklxZktWMGRCSXdxTk5pNERzV2R3U3hz?=
 =?utf-8?B?UnBKN2ZJdTk4RmlLalVyWmdtMUkwK2ZNcE54QVF2cHlCRzFJVFYyWWN2aEZ3?=
 =?utf-8?B?NUh0Qk5jS2U0TXV4eTdkY3Y3N1RrYlV6U3IwL1pUOVNmU0FRclFhWmpXYVc2?=
 =?utf-8?B?ejlockJhOE1DcXhhU0xET1AxWVlhWmt1dlVxelYrNmcrSXhwZ1ZzcG15Uk1s?=
 =?utf-8?B?M3o4bnBWUHgxb0dscy9hRE5BSnpkY0J2Vkx1RnMwT3g2NFIxVmw3bkZwNEVS?=
 =?utf-8?B?M2tXZWRsejZweEM0bkpzVGVxTG9FR0h1dFpWS25yQ1N4c1FnY2I0YlZvNXVr?=
 =?utf-8?B?YTJteTlkUS9GenZId1ZxOUVSdlJoeWNDSlVKK3JzelVTQXZxUk5TTmpPRXhk?=
 =?utf-8?B?S0JmMko5QkhkWk5lSERvRG5SdVY5bEVvZHlQazBZZXRad1g2ZXc2VTZHOUlD?=
 =?utf-8?B?dDVDYnlIM1VndkpsNDFVQkQ3Vi8ydmxlM2VJRVhxRmZwaTY3L21Zb1FyNmdL?=
 =?utf-8?B?MjVxYi9yZERjbk9PNXVNSTgrWkRUZk1NZ3lEaythTUZpOE5WQjFtWTI2WEF1?=
 =?utf-8?B?NWRMUjJaYTZsTDR5dkZwNVBvWnNQemc1YXFsS2lMNEc1Zk9RN1RjOGxBSFI1?=
 =?utf-8?B?N0hRYXBGRXdDOGxpM2s1Q3c5ZkFPRS9VWUI3bmRoU1YybXBvdHJReU9OZGNw?=
 =?utf-8?B?ay9DVUJxMGdESjN1UkR1ajQxdHRtQWJnZE5oNkFqU0UxTTZlZ3lIOXN4aGt2?=
 =?utf-8?B?SmZxeEhRZEpEQytidTFHM08zY2FGbnE1VkNHbFptR3JzVGV0cFVmRWFQcDZu?=
 =?utf-8?B?NXVLWklIbnJudXByUEpIY0p2L3RpK2ZHU2Jnb3huMzVBb2NZZ01VbEhSem9T?=
 =?utf-8?B?ZmhIVDdHSGp0cjcvTWtPOXFTUjl2alJXTVhSb2cvYVZTb2tRWmRZSVZnMXA3?=
 =?utf-8?B?eWZTRmp3Z0NtVDNYWEVTVi9MZ01CWk9GaHVxcnRQdCt3akRDMjZuRWJwWUhV?=
 =?utf-8?B?VDRLQlVSODBGbEJYVlNJUlBQTk4vLzFrNTh1Mit4dVFkNE12aXVOL2Fyb0kw?=
 =?utf-8?B?dlVpR3Vua0l0Z0FDMmk0Sm91RWpBR2VaaHZwR3R5UHRkS3hhUnNnNlZwMVRu?=
 =?utf-8?B?YjViMjZYTnZzTXpLWkxoTUY1a3lQcDZjZjNkTWc5UEdEWmNkbnhaNHo4Zmdo?=
 =?utf-8?B?VVRDeGlQdVRRRUJCaHJCeEdOcVVTOXlVck9xSWVNcEJ3bVhjRzduQm5WWkc3?=
 =?utf-8?B?L1dlYS9RUGR4aVhTWTJseDFPLysybmRFczdnK1QwcW56aEtvZTFGdXhHR2pp?=
 =?utf-8?B?TlVVUHFLekRwNUtlSUhNb2lIOHdEUVN0bnNkeDlPYk5PMUNJQWRpMU9aWDlM?=
 =?utf-8?B?cUNsSnJrb1Fmemt6RjNOaFhhMmJEL01QdXJtQnE3VWhlcEF4K0lHTkk4SVZq?=
 =?utf-8?B?VlRxbTZITk9EN0JRVXBIcHVmWXJ4TmNLank2STBoSkRQdDVKL0Q2TFBBejFI?=
 =?utf-8?B?andXdkY3ZWtzMDNaMlY5SFN2bnRBbzcwdEFOUDhad09GMUxvMkhmeW41Ylkr?=
 =?utf-8?B?S2ZrVFNWNkVFWllHSWIzaTNhSElQeEt6MWttclRBYUlMcGdoZnlua1NQRGJF?=
 =?utf-8?B?OVJvdUhHMXU0TVRLeUI2MkFxa2ZwTng3bXhSaVJtWVRNK2xVR25JTk02eDVw?=
 =?utf-8?B?Skc1b0lmb1c3a1RmRU5FTmZkeXoxSXBXZlptdkVFSEw2MDdpbm82ajFwcU1i?=
 =?utf-8?B?SkNRcit5cis3YTk2dm9jNmswVTlqZjZtS2RVc1JxS0RpODJJc0gvNjhxUTRZ?=
 =?utf-8?B?a0hGTzZublhIaGZndEFoVmNaYlZRZFRoNDRodXkwKzlJWXNmZm1sRVladkhi?=
 =?utf-8?B?SFhWbUJGVmVGMmFlUG5vMmh6Q3lELzVZc3RzZ2pxTHlwTzEwTVRMOW45TGN5?=
 =?utf-8?Q?bUAqC4O/6lU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dQSUpyS1p6bjBYTmpYYSt6NnJKMFZoeEhHU3FPRG5FcVAvZFBuMHo5T3pU?=
 =?utf-8?B?bjAyZXYvdC9WaW9RK2psTzdscXZLenpaazc1VS9vWTdkRGQrdW9rd25hUW9C?=
 =?utf-8?B?Sm5ld3FBVU9ETjdsRlN0RDdNQnJ2YTVla2g2UlhyRWtHNHdZN3RVT0lOZ2FE?=
 =?utf-8?B?bnprdHFiTDBEdWNCYmE2aUFMSk5UVC8rV0RrQmpBbnlwbFF1RTAvdXkzdW1H?=
 =?utf-8?B?cGVLRXcxV3dMbk9XREpodEZMak9iM0JNYm9YL3RoaUVwWVg5TkFwYlRkempR?=
 =?utf-8?B?Z3dVWkRYSEtpYWcwOFZKMlZOSlB4a3BmMGVtVzdxUHZ4S2ZhRktRYy9ScWY4?=
 =?utf-8?B?NFloMmxUK3pNalhqclV4SFZ3dytxZHBEOGN4U0FwejdYUGg1ZnVJMHZwa0RV?=
 =?utf-8?B?NWdzMzA0MXdoWmZkZnJQS1FLN08yR0hjRkN1eHgyUk5ZTlNUZldFNGJPWHQ3?=
 =?utf-8?B?N2RoWHRvci9FcHV0SER4dERzOTVzL1ppSzFTV3BqcXRTMUVVUmRUb0t2Q3l3?=
 =?utf-8?B?TG4zMUZZZHdUaU5iSU82ajk2N2pYalRSa3Q0OW1Ibm8xZldvQmdWNVFHM0Va?=
 =?utf-8?B?aUowS0VWNlZTT2ZQeDRYaUQ4SjhvNXFURW0rS25UZ1UvMjd5RjBvNTIzMTJZ?=
 =?utf-8?B?YVlYbDVVVzBUTGNBMG44OW5mZXMzUjRMZXFVbUkzY0lwcWJidTFlV2x0NVdM?=
 =?utf-8?B?VTdlVGg2ZkhiUFBHcitrdlVaWnB4NWNBWFdRN3o0OUxqMTBWcW1BNWFNdVNJ?=
 =?utf-8?B?N0VFMVVaWk00Ky80ZkYrRlRQSXFGUmUyM3FzWXVmQU5lRS9lZXNlVStBNzRK?=
 =?utf-8?B?cXczWGtMTzVXaEZhdk5SZTNaZE90YWpiWnczRnpqb0pDcnQ2ZGxMTFJoTmVE?=
 =?utf-8?B?RUhzY2k4RnVMalBZMDY0VFltTzJZMEt3MkVnbXRjN2g2UjF1N2xseENwU3F6?=
 =?utf-8?B?WWRRMkcrSmxrMFQwcDVsMmFaYitSSU1EV09PVjBKVldIMlUrMjVSbnFvdVRC?=
 =?utf-8?B?RG9kQlFHb3ZZU3ZENFQvRjB6MHBScGxKMGl6ZkZnOUswVGdacjU4YVk1K3FX?=
 =?utf-8?B?UzBIdll2Uk5KUGFqVndkWnFXM1FxTHZ0bTNtV3RoVU1sSm5sdi9tV09JbmFE?=
 =?utf-8?B?b3dSemkvVTB4SVNOZk8wdXhZZ2JvYmpDQlo0WUkrZ1QxNDh4MklBS0xPTjY0?=
 =?utf-8?B?VkVXUkpCVTlrTGdaNUs4QzVNeU9Lc0lpVEIwMjJzSWoxVDlYYXdKbGczWk1n?=
 =?utf-8?B?Y0hmeTNVbUlDaE1CSWtxWGo5dG1mSDVobTkydUxpTk56V0FZNEx4QUZFUFpl?=
 =?utf-8?B?Wm5VN3JUY3cwSlRyd05NYXNVUGRWcm0ydkV0b25ERG9NbmdvOGx6OVlBcG9R?=
 =?utf-8?B?elVjSjJmOG5QbGtRcTNid3NRRVNLVGV3ZzdNckJoQmc4dVJVcjhFRXVUakhl?=
 =?utf-8?B?TmNWTXZ0VmhHbFVPSUJHQkFIekl0SDlyVlo1YjlWSW1qM3JPY2NIMmNXMzY4?=
 =?utf-8?B?enZMM0RWMjBLbFlVWWE2VFlheVI3QW9OUEdxUVYxbFIzeDJ1RjBycHhNeFFq?=
 =?utf-8?B?RHJPZUhZQ2o5cDFyeUVLVXd5bkhCUFdCWHJJS0dnVVB4QW9oc1dQVksvL3Er?=
 =?utf-8?B?SHFzRW1DRTgxdDdkdG1qa2J4VnIrWFFiR2dPaVVhOW50L0lyek04N1FrVjlv?=
 =?utf-8?B?L2lRRHNLQTJuaThTbHhrcmZlakQ4VzdWYmFoWk9OaS90clpnVU1VV2c3ZnZI?=
 =?utf-8?B?cC9NU0lXSE5QNzhJMFNkNVdxeVRjOUhoU0dLTFFZZmdKclJSZ3g3dUtrblJY?=
 =?utf-8?B?Tm9EOFU1SUhIaFJtRXRBTk1GZ0ZkRFlrdW5NTVlZcktlbmMxdWxKdDcxMDYy?=
 =?utf-8?B?cjlRQ3BiUjlCdkY0QUh0dHdzWHdlOGRUUjM1cEl6OUNMUG0wTlk4NnlIZ2Y2?=
 =?utf-8?B?em54RDFWTFpFZm12NVlaOW5wblhQQU1aTnViRkxvWlR0RzRxemVvWE9hYmwx?=
 =?utf-8?B?Z21TOTRScnNLenVibncxR1ZUWVo2dGIwUllCSFNOMHg4bkRnRTFHWXc5NWJ5?=
 =?utf-8?B?TjVSWm9EU0pJdktmNEJLVXl6UWltaS9PM1BsVHlBbm14WDFUNjNGZGtVdHZF?=
 =?utf-8?Q?vcDEILE+NHDInWUcIGP8xPd3u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea0e0c1-2765-4a88-a05f-08ddb93b3bc9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:37:01.6374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5J5Jsp5YrtT9s1AYeuCT6CBs+BfV/35EHCrThegCy710X/hsZq9IQigaJSBcKcl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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



On 6/27/25 11:20, Michal Simek wrote:
> simple bus node and drivers not bringing up any value for mini
> configuration that's why remove it and disable drivers for it to save some
> space.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/versal-mini-emmc0.dts            | 36 +++++-------
>   arch/arm/dts/versal-mini-emmc1.dts            | 36 +++++-------
>   arch/arm/dts/versal-mini-ospi.dtsi            | 52 ++++++++---------
>   arch/arm/dts/versal-mini-qspi.dtsi            | 40 ++++++-------
>   arch/arm/dts/versal-net-mini-emmc.dts         | 36 +++++-------
>   arch/arm/dts/versal-net-mini-ospi.dtsi        | 56 ++++++++-----------
>   arch/arm/dts/versal-net-mini-qspi.dtsi        | 42 ++++++--------
>   arch/arm/dts/versal-net-mini.dts              | 26 +++------
>   arch/arm/dts/zynqmp-mini-emmc0.dts            | 31 ++++------
>   arch/arm/dts/zynqmp-mini-emmc1.dts            | 31 ++++------
>   arch/arm/dts/zynqmp-mini-nand.dts             | 35 +++++-------
>   arch/arm/dts/zynqmp-mini-qspi.dts             | 25 +++------
>   configs/amd_versal2_mini_defconfig            |  1 +
>   configs/amd_versal2_mini_emmc_defconfig       |  1 +
>   configs/amd_versal2_mini_ospi_defconfig       |  1 +
>   configs/amd_versal2_mini_qspi_defconfig       |  1 +
>   configs/xilinx_versal_mini_defconfig          |  1 +
>   configs/xilinx_versal_mini_emmc0_defconfig    |  1 +
>   configs/xilinx_versal_mini_emmc1_defconfig    |  1 +
>   configs/xilinx_versal_mini_ospi_defconfig     |  1 +
>   configs/xilinx_versal_mini_qspi_defconfig     |  1 +
>   configs/xilinx_versal_net_mini_defconfig      |  1 +
>   configs/xilinx_versal_net_mini_emmc_defconfig |  1 +
>   configs/xilinx_versal_net_mini_ospi_defconfig |  1 +
>   configs/xilinx_versal_net_mini_qspi_defconfig |  1 +
>   configs/xilinx_zynqmp_mini_defconfig          |  1 +
>   configs/xilinx_zynqmp_mini_emmc0_defconfig    |  1 +
>   configs/xilinx_zynqmp_mini_emmc1_defconfig    |  1 +
>   configs/xilinx_zynqmp_mini_nand_defconfig     |  1 +
>   .../xilinx_zynqmp_mini_nand_single_defconfig  |  1 +
>   configs/xilinx_zynqmp_mini_qspi_defconfig     |  1 +
>   31 files changed, 196 insertions(+), 269 deletions(-)
> 
> diff --git a/arch/arm/dts/versal-mini-emmc0.dts b/arch/arm/dts/versal-mini-emmc0.dts
> index 179060c56eee..9044ef1889bb 100644
> --- a/arch/arm/dts/versal-mini-emmc0.dts
> +++ b/arch/arm/dts/versal-mini-emmc0.dts
> @@ -28,28 +28,20 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <0x2>;
> -		#size-cells = <0x2>;
> -		ranges;
> -
> -		sdhci0: sdhci@f1040000 {
> -			compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> -			status = "okay";
> -			non-removable;
> -			disable-wp;
> -			no-sd;
> -			no-sdio;
> -			cap-mmc-hw-reset;
> -			bus-width = <8>;
> -			reg = <0x0 0xf1040000 0x0 0x10000>;
> -			clock-names = "clk_xin", "clk_ahb";
> -			clocks = <&clk200 &clk200>;
> -			no-1-8-v;
> -			xlnx,mio-bank = <0>;
> -		};
> +	sdhci0: sdhci@f1040000 {
> +		compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> +		status = "okay";
> +		non-removable;
> +		disable-wp;
> +		no-sd;
> +		no-sdio;
> +		cap-mmc-hw-reset;
> +		bus-width = <8>;
> +		reg = <0x0 0xf1040000 0x0 0x10000>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&clk200 &clk200>;
> +		no-1-8-v;
> +		xlnx,mio-bank = <0>;
>   	};
>   
>   	aliases {
> diff --git a/arch/arm/dts/versal-mini-emmc1.dts b/arch/arm/dts/versal-mini-emmc1.dts
> index ffcc33345296..47f3b74c0655 100644
> --- a/arch/arm/dts/versal-mini-emmc1.dts
> +++ b/arch/arm/dts/versal-mini-emmc1.dts
> @@ -28,28 +28,20 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <0x2>;
> -		#size-cells = <0x2>;
> -		ranges;
> -
> -		sdhci1: sdhci@f1050000 {
> -			compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> -			status = "okay";
> -			non-removable;
> -			disable-wp;
> -			no-sd;
> -			no-sdio;
> -			cap-mmc-hw-reset;
> -			bus-width = <8>;
> -			reg = <0x0 0xf1050000 0x0 0x10000>;
> -			clock-names = "clk_xin", "clk_ahb";
> -			clocks = <&clk200 &clk200>;
> -			no-1-8-v;
> -			xlnx,mio-bank = <0>;
> -		};
> +	sdhci1: sdhci@f1050000 {
> +		compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> +		status = "okay";
> +		non-removable;
> +		disable-wp;
> +		no-sd;
> +		no-sdio;
> +		cap-mmc-hw-reset;
> +		bus-width = <8>;
> +		reg = <0x0 0xf1050000 0x0 0x10000>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&clk200 &clk200>;
> +		no-1-8-v;
> +		xlnx,mio-bank = <0>;
>   	};
>   
>   	aliases {
> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
> index 9ca0cf3c027f..eec2a08e7c70 100644
> --- a/arch/arm/dts/versal-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
> @@ -28,37 +28,29 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <0x2>;
> -		#size-cells = <0x2>;
> -		ranges;
> -
> -		ospi: spi@f1010000 {
> -			compatible = "cdns,qspi-nor";
> -			status = "okay";
> -			reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
> -			clock-names = "ref_clk", "pclk";
> -			clocks = <&clk125 &clk125>;
> -			bus-num = <2>;
> -			num-cs = <1>;
> -			cdns,fifo-depth = <256>;
> -			cdns,fifo-width = <4>;
> -			cdns,is-dma = <1>;
> -			cdns,trigger-address = <0xc0000000>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> +	ospi: spi@f1010000 {
> +		compatible = "cdns,qspi-nor";
> +		status = "okay";
> +		reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
> +		clock-names = "ref_clk", "pclk";
> +		clocks = <&clk125 &clk125>;
> +		bus-num = <2>;
> +		num-cs = <1>;
> +		cdns,fifo-depth = <256>;
> +		cdns,fifo-width = <4>;
> +		cdns,is-dma = <1>;
> +		cdns,trigger-address = <0xc0000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>   
> -			flash0: flash@0 {
> -				compatible = "n25q512a", "micron,m25p80",
> -					     "jedec,spi-nor";
> -				reg = <0x0>;
> -				spi-tx-bus-width = <8>;
> -				spi-rx-bus-width = <8>;
> -				spi-max-frequency = <20000000>;
> -				no-wp;
> -			};
> +		flash0: flash@0 {
> +			compatible = "n25q512a", "micron,m25p80",
> +				     "jedec,spi-nor";
> +			reg = <0x0>;
> +			spi-tx-bus-width = <8>;
> +			spi-rx-bus-width = <8>;
> +			spi-max-frequency = <20000000>;
> +			no-wp;
>   		};
>   	};
>   
> diff --git a/arch/arm/dts/versal-mini-qspi.dtsi b/arch/arm/dts/versal-mini-qspi.dtsi
> index 57427e099f9e..ec4eef74020b 100644
> --- a/arch/arm/dts/versal-mini-qspi.dtsi
> +++ b/arch/arm/dts/versal-mini-qspi.dtsi
> @@ -28,31 +28,23 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <0x2>;
> -		#size-cells = <0x2>;
> -		ranges;
> -
> -		qspi: spi@f1030000 {
> -			compatible = "xlnx,versal-qspi-1.0";
> -			status = "okay";
> -			clock-names = "ref_clk", "pclk";
> -			num-cs = <0x1>;
> -			reg = <0x0 0xf1030000 0x0 0x1000>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			clocks = <&clk150 &clk150>;
> +	qspi: spi@f1030000 {
> +		compatible = "xlnx,versal-qspi-1.0";
> +		status = "okay";
> +		clock-names = "ref_clk", "pclk";
> +		num-cs = <0x1>;
> +		reg = <0x0 0xf1030000 0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&clk150 &clk150>;
>   
> -			flash0: flash@0 {
> -				compatible = "n25q512a", "micron,m25p80",
> -					     "jedec,spi-nor";
> -				reg = <0x0>;
> -				spi-tx-bus-width = <4>;
> -				spi-rx-bus-width = <4>;
> -				spi-max-frequency = <20000000>;
> -			};
> +		flash0: flash@0 {
> +			compatible = "n25q512a", "micron,m25p80",
> +				     "jedec,spi-nor";
> +			reg = <0x0>;
> +			spi-tx-bus-width = <4>;
> +			spi-rx-bus-width = <4>;
> +			spi-max-frequency = <20000000>;
>   		};
>   	};
>   
> diff --git a/arch/arm/dts/versal-net-mini-emmc.dts b/arch/arm/dts/versal-net-mini-emmc.dts
> index 20e4e2994048..567ceeb36a0b 100644
> --- a/arch/arm/dts/versal-net-mini-emmc.dts
> +++ b/arch/arm/dts/versal-net-mini-emmc.dts
> @@ -2,7 +2,7 @@
>   /*
>    * dts file for Xilinx Versal NET Mini eMMC Configuration
>    *
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    * Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> @@ -42,26 +42,18 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		sdhci1: mmc@f1050000 {
> -			compatible = "xlnx,versal-net-emmc";
> -			status = "okay";
> -			non-removable;
> -			disable-wp;
> -			no-sd;
> -			no-sdio;
> -			cap-mmc-hw-reset;
> -			bus-width = <8>;
> -			reg = <0 0xf1050000 0 0x10000>;
> -			clock-names = "clk_xin", "clk_ahb";
> -			clocks = <&clk200>, <&clk200>;
> -			xlnx,mio-bank = <0>;
> -		};
> +	sdhci1: mmc@f1050000 {
> +		compatible = "xlnx,versal-net-emmc";
> +		status = "okay";
> +		non-removable;
> +		disable-wp;
> +		no-sd;
> +		no-sdio;
> +		cap-mmc-hw-reset;
> +		bus-width = <8>;
> +		reg = <0 0xf1050000 0 0x10000>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&clk200>, <&clk200>;
> +		xlnx,mio-bank = <0>;
>   	};
>   };
> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
> index a9bf7cc42484..1c94b352dc97 100644
> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * dts file for Xilinx Versal NET Mini OSPI Configuration
>    *
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    * Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> @@ -42,38 +42,30 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <0x2>;
> -		#size-cells = <0x2>;
> -		ranges;
> -
> -		ospi: spi@f1010000 {
> -			compatible = "cdns,qspi-nor";
> -			status = "okay";
> -			reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
> -			clock-names = "ref_clk", "pclk";
> -			clocks = <&clk125>, <&clk125>;
> -			bus-num = <2>;
> -			num-cs = <1>;
> -			cdns,fifo-depth = <256>;
> -			cdns,fifo-width = <4>;
> -			cdns,is-dma = <1>;
> -			cdns,is-stig-pgm = <1>;
> -			cdns,trigger-address = <0xc0000000>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> +	ospi: spi@f1010000 {
> +		compatible = "cdns,qspi-nor";
> +		status = "okay";
> +		reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
> +		clock-names = "ref_clk", "pclk";
> +		clocks = <&clk125>, <&clk125>;
> +		bus-num = <2>;
> +		num-cs = <1>;
> +		cdns,fifo-depth = <256>;
> +		cdns,fifo-width = <4>;
> +		cdns,is-dma = <1>;
> +		cdns,is-stig-pgm = <1>;
> +		cdns,trigger-address = <0xc0000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>   
> -			flash0: flash@0 {
> -				compatible = "mt35xu02g", "micron,m25p80",
> -					     "jedec,spi-nor";
> -				reg = <0>;
> -				spi-tx-bus-width = <8>;
> -				spi-rx-bus-width = <8>;
> -				spi-max-frequency = <20000000>;
> -				no-wp;
> -			};
> +		flash0: flash@0 {
> +			compatible = "mt35xu02g", "micron,m25p80",
> +				     "jedec,spi-nor";
> +			reg = <0>;
> +			spi-tx-bus-width = <8>;
> +			spi-rx-bus-width = <8>;
> +			spi-max-frequency = <20000000>;
> +			no-wp;
>   		};
>   	};
>   };
> diff --git a/arch/arm/dts/versal-net-mini-qspi.dtsi b/arch/arm/dts/versal-net-mini-qspi.dtsi
> index e29a3f36d6e4..97cc39c73e0d 100644
> --- a/arch/arm/dts/versal-net-mini-qspi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-qspi.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * dts file for Xilinx Versal NET Mini QSPI Configuration
>    *
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    * Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> @@ -42,31 +42,23 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		bootph-all;
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		qspi: spi@f1030000 {
> -			compatible = "xlnx,versal-qspi-1.0";
> -			status = "okay";
> -			clock-names = "ref_clk", "pclk";
> -			num-cs = <1>;
> -			reg = <0 0xf1030000 0 0x1000>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			clocks = <&clk150>, <&clk150>;
> +	qspi: spi@f1030000 {
> +		compatible = "xlnx,versal-qspi-1.0";
> +		status = "okay";
> +		clock-names = "ref_clk", "pclk";
> +		num-cs = <1>;
> +		reg = <0 0xf1030000 0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&clk150>, <&clk150>;
>   
> -			flash0: flash@0 {
> -				compatible = "n25q512a", "micron,m25p80",
> -					     "jedec,spi-nor";
> -				reg = <0>;
> -				spi-tx-bus-width = <4>;
> -				spi-rx-bus-width = <4>;
> -				spi-max-frequency = <20000000>;
> -			};
> +		flash0: flash@0 {
> +			compatible = "n25q512a", "micron,m25p80",
> +				     "jedec,spi-nor";
> +			reg = <0>;
> +			spi-tx-bus-width = <4>;
> +			spi-rx-bus-width = <4>;
> +			spi-max-frequency = <20000000>;
>   		};
>   	};
>   };
> diff --git a/arch/arm/dts/versal-net-mini.dts b/arch/arm/dts/versal-net-mini.dts
> index f98f95a5c2fc..0f0a82e3aa3f 100644
> --- a/arch/arm/dts/versal-net-mini.dts
> +++ b/arch/arm/dts/versal-net-mini.dts
> @@ -3,7 +3,7 @@
>    * dts file for Xilinx Versal NET
>    *
>    * Copyright (C) 2021 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -45,22 +45,14 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		compatible = "simple-bus";
> +	serial0: serial@f1920000 {
>   		bootph-all;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		serial0: serial@f1920000 {
> -			bootph-all;
> -			compatible = "arm,pl011", "arm,primecell";
> -			reg = <0 0xf1920000 0 0x1000>;
> -			reg-io-width = <4>;
> -			clock-names = "uartclk", "apb_pclk";
> -			clocks = <&clk1>, <&clk1>;
> -			clock = <1000000>;
> -			skip-init;
> -		};
> +		compatible = "arm,pl011", "arm,primecell";
> +		reg = <0 0xf1920000 0 0x1000>;
> +		reg-io-width = <4>;
> +		clock-names = "uartclk", "apb_pclk";
> +		clocks = <&clk1>, <&clk1>;
> +		clock = <1000000>;
> +		skip-init;
>   	};
>   };
> diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
> index ad4b3c5f8b1d..05f61d6bb359 100644
> --- a/arch/arm/dts/zynqmp-mini-emmc0.dts
> +++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
> @@ -41,25 +41,18 @@
>   		clock-frequency = <200000000>;
>   	};
>   
> -	amba: axi {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		sdhci0: mmc@ff160000 {
> -			bootph-all;
> -			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> -			status = "disabled";
> -			non-removable;
> -			no-sd;
> -			no-sdio;
> -			cap-mmc-hw-reset;
> -			bus-width = <8>;
> -			reg = <0x0 0xff160000 0x0 0x1000>;
> -			clock-names = "clk_xin", "clk_ahb";
> -			clocks = <&clk_xin &clk_xin>;
> -		};
> +	sdhci0: mmc@ff160000 {
> +		bootph-all;
> +		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> +		status = "disabled";
> +		non-removable;
> +		no-sd;
> +		no-sdio;
> +		cap-mmc-hw-reset;
> +		bus-width = <8>;
> +		reg = <0x0 0xff160000 0x0 0x1000>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&clk_xin &clk_xin>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
> index fd421b4fe7ed..7857106260e1 100644
> --- a/arch/arm/dts/zynqmp-mini-emmc1.dts
> +++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
> @@ -41,25 +41,18 @@
>   		clock-frequency = <200000000>;
>   	};
>   
> -	amba: axi {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		sdhci1: mmc@ff170000 {
> -			bootph-all;
> -			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> -			status = "disabled";
> -			non-removable;
> -			no-sd;
> -			no-sdio;
> -			cap-mmc-hw-reset;
> -			bus-width = <8>;
> -			reg = <0x0 0xff170000 0x0 0x1000>;
> -			clock-names = "clk_xin", "clk_ahb";
> -			clocks = <&clk_xin &clk_xin>;
> -		};
> +	sdhci1: mmc@ff170000 {
> +		bootph-all;
> +		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> +		status = "disabled";
> +		non-removable;
> +		no-sd;
> +		no-sdio;
> +		cap-mmc-hw-reset;
> +		bus-width = <8>;
> +		reg = <0x0 0xff170000 0x0 0x1000>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&clk_xin &clk_xin>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
> index 5e2135158cd5..1ece39997912 100644
> --- a/arch/arm/dts/zynqmp-mini-nand.dts
> +++ b/arch/arm/dts/zynqmp-mini-nand.dts
> @@ -35,27 +35,20 @@
>   		bootph-all;
>   	};
>   
> -	amba: axi {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		nand0: nand@ff100000 {
> -			compatible = "arasan,nfc-v3p10";
> -			status = "okay";
> -			reg = <0x0 0xff100000 0x1000>;
> -			clock-names = "clk_sys", "clk_flash";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			arasan,has-mdma;
> -			num-cs = <2>;
> -			nand@0 {
> -				reg = <0>;
> -				#address-cells = <2>;
> -				#size-cells = <1>;
> -				nand-ecc-mode = "hw";
> -			};
> +	nand0: nand@ff100000 {
> +		compatible = "arasan,nfc-v3p10";
> +		status = "okay";
> +		reg = <0x0 0xff100000 0x1000>;
> +		clock-names = "clk_sys", "clk_flash";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		arasan,has-mdma;
> +		num-cs = <2>;
> +		nand@0 {
> +			reg = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			nand-ecc-mode = "hw";
>   		};
>   	};
>   };
> diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
> index 917603dec61d..ddcc39b4e942 100644
> --- a/arch/arm/dts/zynqmp-mini-qspi.dts
> +++ b/arch/arm/dts/zynqmp-mini-qspi.dts
> @@ -42,22 +42,15 @@
>   		clock-frequency = <125000000>;
>   	};
>   
> -	amba: axi {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		qspi: spi@ff0f0000 {
> -			compatible = "xlnx,zynqmp-qspi-1.0";
> -			status = "disabled";
> -			clock-names = "ref_clk", "pclk";
> -			clocks = <&misc_clk &misc_clk>;
> -			num-cs = <1>;
> -			reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> +	qspi: spi@ff0f0000 {
> +		compatible = "xlnx,zynqmp-qspi-1.0";
> +		status = "disabled";
> +		clock-names = "ref_clk", "pclk";
> +		clocks = <&misc_clk &misc_clk>;
> +		num-cs = <1>;
> +		reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>   	};
>   };
>   
> diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
> index d224583f56ae..155b554d6c21 100644
> --- a/configs/amd_versal2_mini_defconfig
> +++ b/configs/amd_versal2_mini_defconfig
> @@ -63,6 +63,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
> diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
> index 3afc6cb2736b..90907dfb72cf 100644
> --- a/configs/amd_versal2_mini_emmc_defconfig
> +++ b/configs/amd_versal2_mini_emmc_defconfig
> @@ -54,6 +54,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
> diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
> index 54328e85784a..3b4c6205da4b 100644
> --- a/configs/amd_versal2_mini_ospi_defconfig
> +++ b/configs/amd_versal2_mini_ospi_defconfig
> @@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
> diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
> index 48fb7ae0e7f3..72e6f613cd56 100644
> --- a/configs/amd_versal2_mini_qspi_defconfig
> +++ b/configs/amd_versal2_mini_qspi_defconfig
> @@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
> diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
> index 561459befb61..cd5eebabf9a6 100644
> --- a/configs/xilinx_versal_mini_defconfig
> +++ b/configs/xilinx_versal_mini_defconfig
> @@ -60,6 +60,7 @@ CONFIG_SYS_ALT_MEMTEST=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_MMC is not set
>   CONFIG_ARM_DCC=y
>   # CONFIG_GZIP is not set
> diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
> index 21f241e07b14..ffa1395fea71 100644
> --- a/configs/xilinx_versal_mini_emmc0_defconfig
> +++ b/configs/xilinx_versal_mini_emmc0_defconfig
> @@ -59,6 +59,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
>   CONFIG_ARM_DCC=y
> diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
> index 6cb654c7a4bd..4d438a9b5cdd 100644
> --- a/configs/xilinx_versal_mini_emmc1_defconfig
> +++ b/configs/xilinx_versal_mini_emmc1_defconfig
> @@ -59,6 +59,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
>   CONFIG_ARM_DCC=y
> diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
> index af9ce4991690..cac691c92cee 100644
> --- a/configs/xilinx_versal_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_mini_ospi_defconfig
> @@ -54,6 +54,7 @@ CONFIG_SYS_PROMPT="Versal> "
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_MMC is not set
>   CONFIG_MTD=y
>   CONFIG_DM_SPI_FLASH=y
> diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
> index ecb3b16033cb..220daa894ea0 100644
> --- a/configs/xilinx_versal_mini_qspi_defconfig
> +++ b/configs/xilinx_versal_mini_qspi_defconfig
> @@ -56,6 +56,7 @@ CONFIG_SYS_PROMPT="Versal> "
>   # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
> diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
> index 04dd0cdb507a..7f2b1fbc88e7 100644
> --- a/configs/xilinx_versal_net_mini_defconfig
> +++ b/configs/xilinx_versal_net_mini_defconfig
> @@ -64,6 +64,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
> diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
> index ab201566407d..ba2c76c480b9 100644
> --- a/configs/xilinx_versal_net_mini_emmc_defconfig
> +++ b/configs/xilinx_versal_net_mini_emmc_defconfig
> @@ -54,6 +54,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
> diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
> index 18ec73722586..a8d0c5fc1287 100644
> --- a/configs/xilinx_versal_net_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_net_mini_ospi_defconfig
> @@ -53,6 +53,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_MMC is not set
>   CONFIG_MTD=y
>   CONFIG_DM_SPI_FLASH=y
> diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
> index 5241da6c63bb..1a3df99f65ed 100644
> --- a/configs/xilinx_versal_net_mini_qspi_defconfig
> +++ b/configs/xilinx_versal_net_mini_qspi_defconfig
> @@ -55,6 +55,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
>   # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set
> diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
> index 8aa4c8dc77dc..1f9fc71062f2 100644
> --- a/configs/xilinx_zynqmp_mini_defconfig
> +++ b/configs/xilinx_zynqmp_mini_defconfig
> @@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_DM_MAILBOX is not set
>   # CONFIG_MMC is not set
>   CONFIG_ARM_DCC=y
> diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> index 66e0d5242821..4310412bed99 100644
> --- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> @@ -72,6 +72,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
>   CONFIG_SPL_DM_SEQ_ALIAS=y
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_DM_MAILBOX is not set
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> index cded70f8f2f1..142d3643ba7a 100644
> --- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> @@ -72,6 +72,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
>   CONFIG_SPL_DM_SEQ_ALIAS=y
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_DM_MAILBOX is not set
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
> index f5c79779df3d..cb474697f518 100644
> --- a/configs/xilinx_zynqmp_mini_nand_defconfig
> +++ b/configs/xilinx_zynqmp_mini_nand_defconfig
> @@ -52,6 +52,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_DM_MAILBOX is not set
>   # CONFIG_MMC is not set
>   CONFIG_DM_MTD=y
> diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
> index fa58f2a73c0d..717b66f8d384 100644
> --- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
> +++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
> @@ -52,6 +52,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_DM_MAILBOX is not set
>   # CONFIG_MMC is not set
>   CONFIG_DM_MTD=y
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
> index f2d0d6f16edd..2f6135144791 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -73,6 +73,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
>   CONFIG_SPL_DM_SEQ_ALIAS=y
> +# CONFIG_SIMPLE_BUS is not set
>   # CONFIG_FIRMWARE is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set

Applied.
M
