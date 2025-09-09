Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DECFCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D7D8313B;
	Tue,  9 Sep 2025 07:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4MhReHUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638888313F; Tue,  9 Sep 2025 07:57:50 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BF280422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8K0MsvaUUAzAsXUg+CZxcRPg3mfRhSCtuJNM7xY7cWCn6lg5B9fGSJy/VzeAz8DaRwMJgGthc7/aJYYzbcIe1iEbEzEVdmMnm5PY7UX9YcMDeKG72UQ+wYoM3vsvvE1urQnmy6r3cbyTRY6+3tPaK86ToNqAzDT4f2TsJDJRiklg8cr7N4TCAOrzxeZ5nfBeTmDdTJ9GsitqLS1OBYnLhAkpCHRO/kFZ7D12Ue5lbdL3W6UYiAJcAsVwmb1bWg+GVe2hunAT2jcpWSBzjk5PHphBByumwS3cyhuY+wbrcMl/O9yg6JYUqKrothU8hzEgAZhdXvG2OUk3Uw3k50eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st8QuuAUKO5nDI7Fu2YdLZDC1jBELlUSKCLnrTwfQS0=;
 b=zM1EhFadptqmUDsWHXjGBzWXEEENLB4AJFLOM+AZIiVjTWPEu5l6mVzI4PfwM+yaBe5eVYqYhNh2WOcjQ3FPr1+isPmjXUP0xrqE3p1w074kaAUpA0cEeouwVlINjywrDUUWKCgNzeR9TIF0u8sWOrXTcjiFCdOqRVjH8GP0/7uJTubXf7xSgb23Ru66JzBzgsvhdie+gKg2P/vSPscl+XAYhdigaYIdyQF15DguknSlDBpiXvmwciSmscW5sd+GeGbF3zoxJgQbgihpk80SKxhu3R/vEN0EEi0BV7SS1loDZEXVS7KZfuogjgriTe/rOH14nr/zsvxB42Jwk5r8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st8QuuAUKO5nDI7Fu2YdLZDC1jBELlUSKCLnrTwfQS0=;
 b=4MhReHUJoORqs8Hb+MclH9MuNcH36Q53xiDLq+7NUZIOyhX5whgWy7RytJx/TLfP9GRv+n9MR1ZaXtVqBbH2GZs1Qu0NKMvSoDfxP86Q5lZWWCBAtznxbW9OxpElPx8R9e4eO3CzPfs/unqB0N0j8Dcr2SLGujANOex1czsHBpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:57:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 05:57:45 +0000
Message-ID: <dc2809fb-487b-4c22-86d9-d9db9ffd7039@amd.com>
Date: Tue, 9 Sep 2025 07:57:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: xilinx: Call generic smc_call_handler()
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Lukasz Majewski <lukma@denx.de>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson
 <seanga2@gmail.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: bef5d65e-dcee-4366-9984-08ddef65cc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V21HekRraXhVRUtDRERhQXlGSFFpVENYTmZGNWZMd1NQZTBHcU1aK3NxSGNq?=
 =?utf-8?B?ZldteFBhS3JZZFUvQTd5a25PQURacHFuaG5jUy81bW12VTM3YWFPNnVDNnFv?=
 =?utf-8?B?YmpxM01UdThVTlBiMFJWZlVOTUpENjFYVmlEZlg4eTVnUGNvRUZoYldaa2R6?=
 =?utf-8?B?dE9iS09ueTVNVkViSTFnb0tTQmIvSGJvV2xzWjZzSmhzNEVGeGtSaWNadEd2?=
 =?utf-8?B?UEJVUnJKU3pIcllZb3k3UWZhRHJHRHJheUJUblNlT3l5U1BPQ21ZWTNhUkYx?=
 =?utf-8?B?ZVdnTFU2cUVMeDdxb21jQlBLSnhVbi9FNGU0L2QzZlVPTWp2M0JkRnpLTWp5?=
 =?utf-8?B?aUxJUlRRR2RTNkJmOSt5dGMxaFQvRW5IczFpcEFZNHlRY0U5bGlDelNhcHRN?=
 =?utf-8?B?U1JjY29VbXV3VnZpY3ozTjF2NTdONmJKbzRSS0Z2RlJHVU9RODd0QWtaMzUz?=
 =?utf-8?B?ME1EcXgwYVF0NlBZQjNxTDIzOHRZeEN2NGxUR1FsdHhHNU9rQ1BpZWtERm1K?=
 =?utf-8?B?aEcwNW12VmZlU0Z6NTUwQ0U2YjdML0oyL0JIMkVML0t5N21vdGNjd0lYdHlr?=
 =?utf-8?B?KzZpV1g0T2NuRVVuMjJOWkZ0TExqUXN6dkNxTU42bW85UEVNc24rb3hyWjVS?=
 =?utf-8?B?bjB3bk12SDRsN3VHZ0FnNDZ2a2t1UFVma3p2aVRpS1ljTEtnaFFydTE5TFpQ?=
 =?utf-8?B?V2srNzFTMmNJVHBCK3FvbGxSSFRWM08rMEFSSzhVVFBLRG9ybXB5S281T0tN?=
 =?utf-8?B?ZlNndDhTdEpYblpIZStaclN4bjBwY3hab0dsbVk0SmRUbVozY3RlK0tHSno1?=
 =?utf-8?B?QWlXOE5tbk0yY1pIdjBhWEROeGlCeDRHS2lCeUJ2cEM1MWRTdDlhZitKK0wr?=
 =?utf-8?B?K3dXOTJseE9CTFZxamFpeVcyS0NvYnJOOCtxc3JiVzVPb2VXRVRRY2ZGUlhn?=
 =?utf-8?B?WHZjVWJXT3B5YkYrdnl0WU9kS2s1Y3pGNjdvRWhmT3loc3lHMGdLUllmUy8y?=
 =?utf-8?B?LzBqZG4xVHdjS2R1U0R5Z0FYREtmb3lhYVFWYjhoY1NmU1ZWOEZyVk5DVEdz?=
 =?utf-8?B?c1NxMzJSUnNvUkhQMVZGd0lDU3Z5Vzh2RXluNmZyRlk4azMzdHdmdWkrcDFx?=
 =?utf-8?B?clVvalEwK0hMa1dlMk55OGNHbGx3VjZNVmV4ZElpTmhPS2R0ajdWVE9sbU90?=
 =?utf-8?B?YUgrVy82RzI2cFYwNXdMbENldXc0eFMvbm5OaFdBVmxncXF5aXFoekJuYURY?=
 =?utf-8?B?cnhuNHFFb1VTblg2aEozcldUTDZYb0x2dTJNdGNPaUJhWklzZExxd1QwSEJv?=
 =?utf-8?B?TFlYU2IyV1M3MHZXU2MzUXpLeGIwTFNQUFlvc3o4U0t6bjNmditRbUtudG0v?=
 =?utf-8?B?RFhVYTE5WHFpbWxhZ2N3Z0FWTTc3V0pWWW0zRlRtMEdrbXdNWUdOVFEwd2pR?=
 =?utf-8?B?NTlWU3BUL3NtKytSeURld2hyS2d3bGdsR0Y1QS9TdXR6UitFVzdVd2d4cEtT?=
 =?utf-8?B?RkhUODlsNWJKbjUxVDROVWhmWTlnOWtNVUNNSms0eStUeHdPS0k3Y1JJREpQ?=
 =?utf-8?B?ekRVYk9pTHJPb0JPVGcxbFlTMkRXYTN6emJ5Y0Jpd2ZDakc4TkhzTlo0OEJC?=
 =?utf-8?B?eElVaU9qVWljN1p6Z3ZJaWdyUkNybDJQdzJlTklSYjRMa3NQZVduNmJNVXEr?=
 =?utf-8?B?OHdpQnZCWmlDUm5saktBdkhPbjkwbk9LWFhNR1FxZ3FKUXI5RG5LUnNaWGpj?=
 =?utf-8?B?T3JWRVgydWFNcFYyZ1pBZVl5aVQrQmpTZTBvTWc2a052MlpYWjBxUWRtSkNo?=
 =?utf-8?B?QzRzZDZXaDhkL3NDRldvUUZXM21kL3FEK0pCTmMrQVZkT1hzV0hmQUgzcmpo?=
 =?utf-8?B?Mkp2dzh4WmVVaFZET21Cd0RXNTN3OWF5TER0U25VS0hPMERSbnBWaGc4bHhv?=
 =?utf-8?Q?TQT/BhijZCI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhma3lKSmVQSmRucFJYeDlDWVV5RmlzdGZhRkhYWk9hZlhnUDJOazMzVWM3?=
 =?utf-8?B?VkI3NXlxVUNYMTlaekZRbXZtVXRzclZod0F2QTMxQ0pTYU44clp4a2VRSE9B?=
 =?utf-8?B?eFV6QWk3OFFSc0V3TzUvUDQ5cHhuTExHc1M1UVJFWm81UUt1R0Q2WUFCZDVG?=
 =?utf-8?B?ajJtTDJKaUQrYzF0TDBDTDVodHB1U2dCVjI5NlU1WUJzdVZ2YUdCVmFlYzFo?=
 =?utf-8?B?VlpQT3l2ZWtJbHpqMEVxUVk0RG5qOXhNVm0yWkZ3OUxFdEhlZVRGRFRha3lH?=
 =?utf-8?B?bXB6OGNUSE1Wdkg3bkRXeTlRNmhZUjdCN0lReEtwUFM2eG5VRm83cnRWUnp4?=
 =?utf-8?B?bkNmeUhVOUowRUN0U1NhMldKR3E4SWExZzAyZ2dESGVBbzJ1ZlgrZGZWc002?=
 =?utf-8?B?WWRkQjBqTlZkYkxwbU00YisyakdTTlZWMVJOTjBPZjRFdHNuU3R1S0hKV3Bi?=
 =?utf-8?B?dXl0WnNjRXFrU0Fnc1djTExvWHFnMHpIU2RpMGZXVEVKeTlRYkZOMjVHN2Rk?=
 =?utf-8?B?L2R2emNsZkUyL0hQWkdmRzVCSkFhTVFlS3dTbnFEQmU5eEIyTVZCclFLSkJL?=
 =?utf-8?B?YnJzMVk1amFvVHFlYlo1WCtYZ1RyM1JDM09DZjZrbnNmbFlEWXZYWVJlUjVr?=
 =?utf-8?B?clFSV2t6WnVGb3p1YlRpSDdnckgxMWN6Q0xkZjhuT3BBbjE5K0Q4RTRubVpo?=
 =?utf-8?B?ZTlhYlVpSFl1YzdtMkFLb3lvMDFqcXF5c0pmSmJwSkpFZytYa1NtRlNBVnFG?=
 =?utf-8?B?VnBXOTNSbnRrVUIvQktGUy9rZ1hiRUcvbzV1NUdLSVlhOFFndEdqU2hmcFNO?=
 =?utf-8?B?OGZTc3FqOHp1cG1BNThjSXk3ejVMdUVMcXBoUkhuYnFmc1V5OTNxK29qU1NR?=
 =?utf-8?B?cWZJais2dmFmSWhCOEdLOVlwTWJMQWhxdDkwbkpCS0g1QmJsZ290VkRkMzFH?=
 =?utf-8?B?UnBoWUpWVDlYaDVVaXVnV3JidnNJVFJWenVLaWFRdlNkWEptck5OTkgwOU9K?=
 =?utf-8?B?V3ZLd1JOVlZjbVRjSjRHWVdoczI5N1d3TlVkcEVObXptcGhLK3ZwRHFPUWha?=
 =?utf-8?B?ZWY1cFVGVFdidFRtd0NXVkNJRkhreHlTUTZBcnM2bEZ2WkV5VjRXWWhaSm5D?=
 =?utf-8?B?dEV3NmhDVTUvZS9Kdkk2UXBvWnVRaGc0bDY4K3V1ZHpGdEl3T29aN2tEU0t4?=
 =?utf-8?B?OHQyTzhidm8xalAyMjZVNUdXeXhjd09uVGFDUGlCMG05NGk2bHBWaDU4K1lE?=
 =?utf-8?B?ekVXR2tTZ3lFUzk3M2tzYzB5T1hYc05XNmhUN0l3NFY5a1dkZURBc2phaXVq?=
 =?utf-8?B?Z2piZE1JcUI0eGE5Q2RoTVhMcm01NCtDZmo3UmRTNDZlSXRjc283ZGk1bnlB?=
 =?utf-8?B?cXR0bEhxdlBnOGlIS1JaYThHS0VpbVBHQkFGVVoyMUx5ZFc2dnFzWWNwQ3Nv?=
 =?utf-8?B?Vk1pV1Iwdk85U1A3dTU1NENac3EzR0JWSDZBazd3ck1DbEtUN09Lb1VhekFJ?=
 =?utf-8?B?cXR2QU5PaVdOYmRxM0hmbWdQUENrSnVFTVdFYkpKQmhPWmVxd3BIdHhBTXRU?=
 =?utf-8?B?U21IYlF3K1lsaWZSU0xqSmVsR0YyQ2I4c1FBaldqWXpCZDNqN09CMWhacHo0?=
 =?utf-8?B?dWFTeHIwOGFZdXk1ZFFzdklHb3FNeXlzTWFLd3FOQ3pGbzlZenVUb2h1RHZm?=
 =?utf-8?B?SEtTVDdDV0RTOHJMcFIzNEM1YjdyNDJsQXR3REFjM2p5dExxbkxUNUM1eGdm?=
 =?utf-8?B?QldUWlBDMU9GbWZLbmk3MkM5dXA4WjYrNTBtRGNTay9YT0tJcUtoc3M3NG93?=
 =?utf-8?B?UkkyYnNkOWhTSzQwNGJSTXdWTVBrODBQN0ZGemwwanZseTA4U3RSZHJzRTZh?=
 =?utf-8?B?TWVwUTh6ZXpIYmhjSm1XRTN3cTJjNWpGT3RjbFFDYlhtWWkyeFNNYWcvYSt4?=
 =?utf-8?B?VzdWb2RXMngzSk52RlBoenVTMzBLeXkwNklrMkNRYzFzMVY2aTREeUZvWmp6?=
 =?utf-8?B?TFZpODFXQ1ZzWGNucjVhMjNZRkZoa1MrOHpBeFF5M25HL0U5VFB6Vk1ZeDJE?=
 =?utf-8?B?NStDc2lMZ0JoL1JveDdBMmNhckxDck43bHZwZVppRWdCT2FTNDA4Yk8wRFdK?=
 =?utf-8?Q?bU0jSKdPNiENQ9SqSWr7I3Idh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef5d65e-dcee-4366-9984-08ddef65cc6a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:57:45.8766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2v+uU23Tl785fuYuOAdKobeolKV79IadQxYtvsYau97cs/oxaGZfGwNQ85hElAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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



On 8/28/25 15:42, Michal Simek wrote:
> There is no reason to call SMC from clock driver directly when clock driver
> is a child of firmware driver which is providing it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/clk/clk_versal.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index cb98f34b5ecb..116dfc98f416 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -123,23 +123,12 @@ static unsigned int clock_max_idx __section(".data");
>   
>   static int versal_pm_query(struct versal_pm_query_data qdata, u32 *ret_payload)
>   {
> -	struct pt_regs regs;
> -
> -	regs.regs[0] = PM_SIP_SVC | PM_QUERY_DATA;
> -	regs.regs[1] = ((u64)qdata.arg1 << 32) | qdata.qid;
> -	regs.regs[2] = ((u64)qdata.arg3 << 32) | qdata.arg2;
> -
> -	smc_call(&regs);
> +	int ret;
>   
> -	if (ret_payload) {
> -		ret_payload[0] = (u32)regs.regs[0];
> -		ret_payload[1] = upper_32_bits(regs.regs[0]);
> -		ret_payload[2] = (u32)regs.regs[1];
> -		ret_payload[3] = upper_32_bits(regs.regs[1]);
> -		ret_payload[4] = (u32)regs.regs[2];
> -	}
> +	ret = smc_call_handler(PM_QUERY_DATA, qdata.qid, qdata.arg1, qdata.arg2,
> +			       qdata.arg3, ret_payload);
>   
> -	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : regs.regs[0];
> +	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
>   }
>   
>   static inline int versal_is_valid_clock(u32 clk_id)

Applied.
M
