Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101DFEE0AE0
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 14:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B3383693;
	Sat,  7 Feb 2026 15:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="uv/+OCeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4A8838FA; Sat,  7 Feb 2026 15:58:27 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971678341A
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 15:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZWuc2uAoR3szrs8BJ4gxKYebE5EF7cyJEOlmM8zGWP0x9BUsYUlqyTTBngmX7ljAAlaNoSsE+3WQeRXkGEwcBQdijW0LcdbIQ39tTvBPguyvSbg+bp8SxJ1UuPGgijTo2TnYShbqF4HKiBN6u7S+xZecDJ5ob8N416ZIQ7tS1pefhMJ3osBX/NxfUXg4Okb37b0HxFVMzOBOwA8ZCqa8uDBcTB7ViKRQ/gT3Ztat1FPh05ZUima//9t4qR43cXAi6EFOYRp57DLDBBcVJnV9kNJepwXANKM/YJtHVVZaLZOdfhunzS0xybelKiOz94npClb3hMbE6oHCv/qYyevQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD0dRKOrsFSPQJ7p/6JbcYpQGyq9yzOIYR+e/SxNRB4=;
 b=Qu5egJM3/mh1KhVn77pDlq4Ue+pppWsOdUPtqnwEqXa2DY+XyMe93lt307/G25uSlolYaBv+GesxMT0VpOR/4zhdJOEj74t73f/kiEYdMoX92UeZG4UB3Z4E/Q0Mm6D/lYbkIMjXDk3U36+a4VL+UY5v6yTZcPKhjStZbui95I4mQF6nUOJO+0adVxOiinIxpWnOqGpPZfkHzT+fDruldqPWZ5AwVMD5u5L0inWfL2HKWNgdK20/u4wy7msEyKWBSrZDxKZB+Jc+vV88dz8n5Maf2L7+n5lS/IGqeAbs/A3BNunV6W6SMhHovf/rAEmwkA9lYDjgod0HUVEgTepmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD0dRKOrsFSPQJ7p/6JbcYpQGyq9yzOIYR+e/SxNRB4=;
 b=uv/+OCeVDcbDZfV1uCo/gJr3InJd65Fl9+odSsLvOYTqyY+vgqksXWbv1J2nk3bv97CxipG5KqYAtHXYSoHtrsCZMYRWPrD2HntogfNfMPBGf8G3ce3nPinhWGgBe7ZF8f+ZLZBsjNxdcBsjyGU9Mey/Q+MIdIQWFg084jtZ4H3JI6H9u/pFdImyc9jzJGe2YTuMQTTf9VdXXgbOBW7RJQqekd50e7FzFsMxPv3CjyFtIFEOhMT1geNx6i5r+qNDSHo2svEYr4L54YIWnx46rHQUHnyMSX7y4h4g2mJMVtLUx+Tx3mQcz/8cPcXMRLPGP0UXdYhjmkOhiPYxj0NYeA==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by SEYPR02MB7458.apcprd02.prod.outlook.com (2603:1096:101:1e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sat, 7 Feb
 2026 14:58:20 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::4718:ae53:48d1:20ee]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::4718:ae53:48d1:20ee%6]) with mapi id 15.20.9587.017; Sat, 7 Feb 2026
 14:58:19 +0000
Message-ID: <SEYPR02MB5557614A996414970C90C11A9667A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Sat, 7 Feb 2026 22:58:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] clk: support arbitrary clk_register() sequence
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <simon.glass@canonical.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260202201706.GA4073175@bill-the-cat>
 <TY0PR02MB5551507C4879363FBB96E946969BA@TY0PR02MB5551.apcprd02.prod.outlook.com>
 <20260203161559.GN2603314@bill-the-cat>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20260203161559.GN2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <a9757bed-fedb-46e2-8fea-329ad1adf241@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|SEYPR02MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 158bc0b0-b6eb-4a7d-41ab-08de6659549b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|6090799003|5072599009|23021999003|19110799012|12121999013|51005399006|8060799015|461199028|41001999006|40105399003|3412199025|440099028|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJjK3kxZ2ZsS0pyanp0Y1VvQWJyZDI0bDhXNVBEVmhCT2xIeWhnQ2d5NGtD?=
 =?utf-8?B?RGJaekpnMDIwb3Z1aW5JdnAvZjJYM1NXMlp0MTI4ME4zdXBGNGF5TytURlJI?=
 =?utf-8?B?NTVSOTJCZERWTmVodXdKeXVLL0JzL2VoNkN1Q05OZmpwMFZST28zK1pERWxj?=
 =?utf-8?B?SzBVRXg0OHJwT2ZzNnl0U2dJMDV3bVJ6N0NvSUdnekZ6Z1F4SDAxUFYrNWtK?=
 =?utf-8?B?VHJuMDNWdTZDaWtQR3pzZlY0UXdRUjJyYzVRREVBdVdMTWExRityOHVydFEw?=
 =?utf-8?B?M3JyTU5zQlNIdHZybkVSZk1GTk93ZWVxQUlCSjVPYi9GVDJXV0ZsUXlsc2JF?=
 =?utf-8?B?U05CSW9aU2QzM0F2aXh4YUs0ckk3SUprcytqcjh0U3hEWjBKdnAwTnRFTG5D?=
 =?utf-8?B?R091eU1wUGdNV0ljeGh3dS9tMlkwUHZGMXQxaHZsK0FJM2FyTVZBMVA3eXl5?=
 =?utf-8?B?ZXZzSnRwUlhTSWw3Z3NuQWsxTEpENHBTR01NM0F3MWxwQ3N2U2tmUmozL3lv?=
 =?utf-8?B?S1h4czFWaXVKRHMvTkFBYVo3bVRBMHR2UHQreHF4MjUzRWRoYVUvS2JOV2ox?=
 =?utf-8?B?UVVvR0NKeFJwTjk0aHRnMUhnN01XZ1hKRUhsY2NIbDBZWnFreFd4K0FxcENS?=
 =?utf-8?B?R3Q3R2c4a0VBQzF0L3dJYk5rK01ncVpaOVVPdHBKdTZsbVJpRDZPVThBOXYx?=
 =?utf-8?B?dUZHNWJEZ005MGRuT2Vha3djY0F6TENoaS96YTNtanovVU55UEJhblNEc2cy?=
 =?utf-8?B?TE5MSnZURHlxK2xrSlMxSkxMNzVGZklFWm9DdTdOSTA2dmdTc3hrMHBKYmxH?=
 =?utf-8?B?dFpLMmhXTlhhdW5meWg1MUxkc3A0MGhLSWdadHZlazllK2praTczVU9SQlh4?=
 =?utf-8?B?V0dnMnJSY1BpYTk1R24xeU1yYUlOUWgxMzROaDRkQkVxNEdiMDdzOURaakJE?=
 =?utf-8?B?TlB3RXF4UktBZjhoU05TWEd4YmtKcEhKT3FDenRVS2lGSFplbVMvM3dIc1pM?=
 =?utf-8?B?THBRSkJ5ajNwYVRqM1o0WG5JclQwUjViSUF0WnpnUWQ1OUhNd3BIZWpXU0Nv?=
 =?utf-8?B?RmZpRkhxOW84TTliT2FkSER4bHN0WXFmcUJNQnZmOGNwSUNRN1h2YjNpc1Rk?=
 =?utf-8?B?aElZT3dlMjl2MzBQZ3YvM1Rtb1VjLzRMbGd0NHJQUGdNdE0wQkN6QjNsbmZK?=
 =?utf-8?B?aWxTZm5qdE91Y0NoeDR5Qlk2d1owblYzTVEzb0Y0czROdDNJdVFncUJpUGVZ?=
 =?utf-8?B?cDJKOWtkMk5yd0NQbmpmMVh0VGp0R2JhblVkeExXbVpIa0o2MVRKYkF2YXE3?=
 =?utf-8?B?ZjRqRjBucHZvY1ZvVTIwcEhwb0F3SkVkcEF1WWx5bXhhTmxVUTF3R3NiSHJz?=
 =?utf-8?B?aUpnbE1ET0JRZXpzMUMvbVVyNjU5Q0QxRlpWdEU4QktEZ05RNXJKMFhySnAr?=
 =?utf-8?B?ck1DTFI1bHIwRlZ1NXRrdzlaVUMvdGc1MGFOSzA4WEZNTzYvd0J6dHN3bFVy?=
 =?utf-8?B?eGYzOVRtTXdsb1B1cGQ2TWZmenBXYVVSYU14NmcxYU5iWjhpZDZBUG5jaVVZ?=
 =?utf-8?B?RnNQWHhmY05rd3lFSGlGam5BNGpNTWVISTlGampISXNuVm5adzlVQ1Q1SkJC?=
 =?utf-8?B?ck14cEFWVGt6NFJ4Z0Q4L2FPWjRWVytFVDNoR1Y4bG1oUCsybUV1anNINm9p?=
 =?utf-8?B?NFBISXVoQXhodWFZMkM3Z3Qvb0JldTVZVkR5ZGZITnE1eWdkMk1XK0NaRkhC?=
 =?utf-8?Q?tDq6dwUshlGaosSkSjcIX3zifDDeabczk6J/rlh?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWJoaEVZaGdVV0dBVVpiQ3MvQVQ0R0h1ZEhNS1UwS2RVcFRBWS9wL2FvYTYx?=
 =?utf-8?B?SC9rN2VtdHp3U28rYWppNjBrUTJ1RjJuTjdxanhxM1c2NDJYQ1kzRmtjekVW?=
 =?utf-8?B?dUZCRzdmZ2lxUFNIb1dPUkp0NXZNREthRGExZ29FR0dPSnVHMnJhcXgybWgr?=
 =?utf-8?B?TmdIcVl5NDJvWkpmQjVJTFlackFIaCt6TGlhMmUyaUhWMU9nZkd2M1ZPMmV4?=
 =?utf-8?B?UndqWUlmZHY0R3JSYVJSMTk4Q3NmcGxPZXVnUThaTm5EWkxNZEVsK1o0UW44?=
 =?utf-8?B?VFVzTjloQ01zbXFXN0RZS1pZclM3YkxjS0o3Z3k0cFVlWDlVQnVxQ2ovR1pW?=
 =?utf-8?B?V0MxeVZNREZRN2NtQXBub2R0c053b2V0SmtPUDM3d2djdnpFOGtmM3REekx1?=
 =?utf-8?B?c3dwVVpPYU8vcnQzUXhSN3RDMFllRkt6TkUyOXdDU3VwVXRadjBPRnFoaGJ6?=
 =?utf-8?B?b21WNFpha0x2YVoxVDRwb3ppdVJWZnY0bWdDd1BsaEpabUlGVlg3bWpINlJj?=
 =?utf-8?B?UkpmNXp1Z1RhQ1g2Y09TVVFSa0Jwa29lY3Uybk5LTjB1UUZLZjI0MHpaYnZp?=
 =?utf-8?B?bkZFejhWTGVjcjVaTzNDa2lmUGZ5OFVXSkNzdkNzZWxScDVYcm9kZXJxTy9y?=
 =?utf-8?B?TEtPRHZMZ1JxYnpWVVZ5QytmUGlMRFRWR1c1bWZFOE1QS3RGYXY1empTMERu?=
 =?utf-8?B?dXFTdE5PZ1VFZytGSmh3eExpc3hWVkRaL25VTll6VVcwYkdCL20wcTY3RlBu?=
 =?utf-8?B?S1YrVEF5N01DbG5XVzhBOURPT0NPMWtkM1dUM3FQbnRXSkp4RUluV3RuTGpE?=
 =?utf-8?B?UU1yRjd4NXY5SjZjVlZ4aG1SV1l5dVZtNXVBdFlmOVJ4R2xZWlByWFJtTTVz?=
 =?utf-8?B?M3Y5UDVHUlE4S0JJcGhoMktHWnMxaTQ3YlJWM0RxSDJOMzhGWk1iYmZqMnJL?=
 =?utf-8?B?SWVNUFpVNHo0MTh6QW5kZmtFNENXZllDMStqSFI4SlBQbnllTC85c0ovVFN5?=
 =?utf-8?B?b1M3QXJrTnY4MWdkYXdZQ1k4Ry9zZ3pEK2RHb3BpMnV6dGhpSE0xamJrVWE4?=
 =?utf-8?B?QUk2cG15YlJuUGRJamF3aGx4SU5LbStjNnpzd0xnZWNTanhHUlkrL1hqQXhz?=
 =?utf-8?B?Ym1uN1VMOTlVSzZ1L2tXZDUzV1hXd2syc04xWCtvSzAvZkZqcmY3Z1VTYldq?=
 =?utf-8?B?QUgwYjVUallOODFSbFY3N3RuWEhWakpVcXk2OVZ1K0V4NFFUMVBleTlRTHRn?=
 =?utf-8?B?eHlySm00UHhOR0NHa2hzK3l6azl2L2tFbGJmTWx0SHJSano4Tzl2YmJvM0tj?=
 =?utf-8?B?alFTYzArZDJ5TnQ0bUEyMkF1SjBaeEppcmtMdWFoTHpVU21jcUxIM0RhZDlC?=
 =?utf-8?B?WmtpRjFCeDM5N3l0YWozYVlHUkdkeEgvQmhJN3hFSGpjaXRRSVdxN3ZwdHd2?=
 =?utf-8?B?U3lIa1ZPUitUNHZkenA4VDNXZFhGd3pWRWh4U3NBRDVJSVhLaXZ2RnVXUS9n?=
 =?utf-8?B?aHdNditFdElkYUR1YTBZTDM2bFl4NW1lS1EyYnlMU0JubFNGT1JIS1J2VE5r?=
 =?utf-8?B?UkRDdGMxWTdYMzQ1Wmh3MXZyK3FtRHFhN3FiblZ0dEFVZGc5cE01Z1BWSnFw?=
 =?utf-8?B?bTBEV2xTZG5zN0hRc2tRY29WSE5XaSs4QnVmNXNsdVBHMktnK3FDNXVWdFA2?=
 =?utf-8?B?bUh5STdCNW40V3pjUkg1NzZnbzBVU0R1clF2VTFoWmlMdFc5SGpBU0FoelBB?=
 =?utf-8?B?Z05HUERteXdSQWJINE9iNGVMUERpb3NRQ0dRMDROaCtXZ001ZFR3NGJ6TDI4?=
 =?utf-8?B?S3dDMG9BNEsweUtqZTRyeFM4Wm1zUnFsOG5RTStTdnhhSGUvbHBFcGxnbTdD?=
 =?utf-8?B?cC9na2JHVDRuYjhWQ0lkUlN4eFcxODRVdFlXNTlIT01kWXdaWk9jbWprT3B1?=
 =?utf-8?B?Y0xocEpnTGtGbDJEMm5XUXNhOXFOaCtxWUpueXJyNEpjSlpXL21DYno1Zzdq?=
 =?utf-8?B?WHprbEY5QkVnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158bc0b0-b6eb-4a7d-41ab-08de6659549b
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 14:58:19.4719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7458
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

On 2/4/2026 12:15 AM, Tom Rini wrote:
> On Tue, Feb 03, 2026 at 11:28:03PM +0800, Yang Xiwen wrote:
>> On 2/3/2026 4:17 AM, Tom Rini wrote:
>>> On Tue, Jan 20, 2026 at 03:07:17AM +0800, Yang Xiwen wrote:
>>>
>>>> Currently, the U-Boot clk framework mandates that clock registration
>>>> begins at the root and proceeds to children. This creates an additional
>>>> requirement that does not exist in the Linux kernel, making the porting
>>>> of clk drivers more difficult.
>>>>
>>>> This series handles the dependency entirely within the clk framework,
>>>> allowing drivers the freedom to register clocks in any order.
>>>>
>>>> This is achieved by assigning the parent "lazily". The framework caches
>>>> the parent name in the core clk struct and attempts to resolve the
>>>> actual parent when clk consumers call clk_get_parent(). The process is
>>>> transparent to clk consumers as long as they use standard clk framework
>>>> APIs.
>>>>
>>>> I've run `ut dm clk*` and verified these commits do not break any
>>>> existing test cases. It also passes the new test case.
>>>>
>>>> This feature is disabled for xPLs by default. I have not found a clean
>>>> way to enable this separately for xPLs without introducing a repetitive
>>>> Kconfig entry (e.g., xPL_CLK_LAZY_REPARENT), which looks very ugly.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> This, like some previous clk reworks, leads to run-time breakage
>>> (failure to boot) on TI K3 and likely other platforms (I want to say
>>> some rockchip was broken last time) as well.
>>>
>> It's sad to hear that. Could you please provide the log so I can try to fix
>> that? This also means our testcases can't cover all cases.
> On am62x_beagleplay_a53 + am62x_beagleplay_r5:
> U-Boot SPL 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:07:42 +0000)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'T'
> SPL initial stack usage: 13464 bytes
> Trying to boot from MMC2
> Starting ATF on ARM64 core...
>
> NOTICE:  BL31: v2.10.0(release):v2.10.0-729-gc8be7c08c
> NOTICE:  BL31: Built : 14:04:51, Jun 24 2024
> I/TC:
> I/TC: OP-TEE version: 4.2.0-22-g16fbd46d2 (gcc version 13.2.0 (GCC)) #4 Mon Jun 24 20:04:07 U
> TC 2024 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guide
> lines.html
> I/TC: Primary CPU initializing
> I/TC: GIC redistributor base address not provided
> I/TC: Assuming default GIC group status and modifier
> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> I/TC: HUK Initialized
> I/TC: Primary CPU switching to normal world boot
>
> U-Boot SPL 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:09:31 +0000)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> SPL initial stack usage: 2048 bytes
> Trying to boot from MMC2
>
>
> U-Boot 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:09:31 +0000)
>
> SoC:   AM62X SR1.0 GP
> Reset reason: POR
> Model: BeagleBoard.org BeaglePlay
> DRAM:  2 GiB
> I/TC: Reserved shared memory is enabled
> I/TC: Dynamic shared memory is enabled
> I/TC: Normal World virtualization support is disabled
> I/TC: Asynchronous notifications are disabled
> Core:  112 devices, 33 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
> Loading Environment from nowhere... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Net:   "Synchronous Abort" handler, esr 0x02000000
> elr: 00000000808c1b28 lr : 00000000808357b0 (reloc)
> elr: 00000000fffd2b28 lr : 00000000fff467b0
> x0 : 00000000fdef7340 x1 : 00000000fffd2b28
> x2 : 000000000000000a x3 : 0000000000000000
> x4 : 000000000000000d x5 : 0000000000000064
> x6 : 00000000fffb088b x7 : 0000000000000044
> x8 : 000000000000000a x9 : 0000000000000034
> x10: 0000000000000002 x11: 00000000ffffffff
> x12: 00000000fdede730 x13: 0000000000007040
> x14: 00000000fdede730 x15: 00000000ffffffff
> x16: 00000000fff53ac8 x17: 0000000000000000
> x18: 00000000fdef1e10 x19: 0000000000000000
> x20: 00000000fdef7340 x21: 00000000fffccfc0
> x22: 00000000fffd4ed0 x23: 00000000fffd4000
> x24: 00000000fdefac18 x25: 00000000fdefac18
> x26: 00000000fff7bcfc x27: 00000000fff7bdb4
> x28: 00000000fffaa8f0 x29: 00000000fdede5b0
>
> Code: fffd2b08 00000000 fffd2b08 00000000 (fffd2b18)
> Resetting CPU ...
>
> resetting ...
>

Is the uboot image built by buildman toolchain or some other toolchain? 
I've tried to generate the image with `tools/buildman/buildman -M -k 
am62x_beagleplay_r5` and debug it with `gdb-multiarch 
../current/am62x_beagleplay_r5/u-boot`. But the result doesn't seem correct.


The output of gdb:

(gdb) disas/r 0x808357b0
Dump of assembler code for function menu_destroy.isra.0:
    0x8083578c <+0>:     b5f8            push    {r3, r4, r5, r6, r7, lr}
    0x8083578e <+2>:     4605            mov     r5, r0
    0x80835790 <+4>:     4604            mov     r4, r0
    0x80835792 <+6>:     f855 3f24       ldr.w   r3, [r5, #36]!
    0x80835796 <+10>:    681e            ldr     r6, [r3, #0]
    0x80835798 <+12>:    42ab            cmp     r3, r5
    0x8083579a <+14>:    d108            bne.n   0x808357ae 
<menu_destroy.isra.0+34>
    0x8083579c <+16>:    68a0            ldr     r0, [r4, #8]
    0x8083579e <+18>:    b108            cbz     r0, 0x808357a4 
<menu_destroy.isra.0+24>
    0x808357a0 <+20>:    f7d6 fae6       bl      0x8080bd70 <free>
    0x808357a4 <+24>:    4620            mov     r0, r4
    0x808357a6 <+26>:    e8bd 40f8       ldmia.w sp!, {r3, r4, r5, r6, 
r7, lr}
    0x808357aa <+30>:    f7d6 bae1       b.w     0x8080bd70 <free>
    0x808357ae <+34>:    f853 0c08       ldr.w   r0, [r3, #-8]
    0x808357b2 <+38>:    f1a3 0708       sub.w   r7, r3, #8
    0x808357b6 <+42>:    b108            cbz     r0, 0x808357bc 
<menu_destroy.isra.0+48>
    0x808357b8 <+44>:    f7d6 fada       bl      0x8080bd70 <free>
    0x808357bc <+48>:    4638            mov     r0, r7
    0x808357be <+50>:    f7d6 fad7       bl      0x8080bd70 <free>
    0x808357c2 <+54>:    4633            mov     r3, r6
    0x808357c4 <+56>:    6836            ldr     r6, [r6, #0]
    0x808357c6 <+58>:    e7e7            b.n     0x80835798 
<menu_destroy.isra.0+12>
End of assembler dump.


-- 
Regards,
Yang Xiwen

