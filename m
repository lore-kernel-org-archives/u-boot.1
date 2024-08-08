Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222F0C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 11:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3469C88ADE;
	Thu,  8 Aug 2024 13:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LFYzSUA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1687488AE3; Thu,  8 Aug 2024 13:19:06 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFFE88ADC
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 13:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEspMWqhYqFOgaOCp4lKlgiNyeNeBjghuaPkEDb7E4JF3CM5gjGmyEjieunx0kixNot+xpyrACGVyYL25pEaA4JlmNrHfm8v109YIzVsWL6Qij7gziQgmpOBPHNwtw9hZv6YurKw6jczkBtPRqPx+jED0Kpta+ettugI5D+3frxgkS/soSw24hKaXRewZ3fntuh+t0j7ov0cVnCavhDfjr3etquNuLd1G6cGfVyB5eVp4MiddiuyZfwTdkhzt1JEovI1qXksSgqJiEMgn+2liyK1MxMXfAishDFh0W51PhQXFxm2DvmgeNbguitlPPVBYjds10nPzgusJwZQfTB8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml424pnHABYvrL3G73lEXbM1qemXga8zXrUPofN+1mo=;
 b=y0UShOIsGjkK+X27V6n89aUfWJBrnnvJoQTKb9eM70PlZK3ZzZ5Uc7MrbGymfdjdRPTRQ6CMMjspDQNV6uXzk4hML2+1Ncd6PdHdXWSgtPMOW43zeu+nrSHm0LynaqGSlA3BFtYzsT4u429Q1dEhLb5YYYTvwVY4bb92eAlsV6k4G4bxu1SMIdYMtLqTO4YLaRH/8OLUQhVaXqaEqB75sES/L6FtDEicQYHVTgpWoRzpwcnrE12Hgiq0tLtf2sauLZpFpAjtfr+EYSRqSuRonFZv/A+aWDv82u0hV4z/TfVzzZ/s4WjKRlpEYVgi6iRaFsb++KcqdRvDEZpdlVVvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml424pnHABYvrL3G73lEXbM1qemXga8zXrUPofN+1mo=;
 b=LFYzSUA8pYHtgps1+s9qaiq65gm57tcZ5inmcZaF6FYbl3JyxBTmBkA2kBSJMkwwJoCeyF5HYQFDXyQsxXzFGjO8D9B9wLkFztfG6u5cmtJkJLXIGRxYc6ImCSdTMAeKxwP1/DUmVrNVKveZqd05xVSV44VkMBjpe6yt7tLiB1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 11:18:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 11:18:52 +0000
Message-ID: <6e5c61cc-5d90-4d2d-bcb2-d854bdb0db1f@amd.com>
Date: Thu, 8 Aug 2024 13:18:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de, git@amd.com, venkatesh.abbarapu@amd.com,
 git@xilinx.com, jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com,
 Simon Glass <sjg@chromium.org>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <20240807211221.GK1626301@bill-the-cat>
 <e62e3c69-e9c4-4a0a-bf65-c21082ce7e27@amd.com>
 <CADg8p95DQvRAXdon_Hx+mYst-u9HTfprQ=6jwgSQThWX=GDSZg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p95DQvRAXdon_Hx+mYst-u9HTfprQ=6jwgSQThWX=GDSZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:930:69::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc8fcc4-eb85-4667-989e-08dcb79be267
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHE1c0Z0eG1Fa1ZUWm5mMlR5d1A4SDdZK25KZU1WQ2xhL1R3YVczNnFRY21F?=
 =?utf-8?B?ZElmM3ZjVWtwb2dXRlQ5UkNSMnNubTJEbFZmOWxsN3FEVmJZampGOXUrMm9I?=
 =?utf-8?B?MVNZMHU3SmFGSzVtSEVPNDZ2RkNLQUt2VUk0WjZiSW1aSHpyUi9BRldVMjFI?=
 =?utf-8?B?YWtPVTMrNlhYM3JITnhROGk2dkh0cHc0MjNLZHdBZDRJYytVZmpxYm1kei9H?=
 =?utf-8?B?WGZaN1VlMnU2YkpVUUFWdUs0THM0K2puK2QzdUEzczZ3TmI5b1F0Z2pZNzhF?=
 =?utf-8?B?ZkJaZ2pVWGVLbjZJSnZOQTdyNFRSTk5VeDlKZDZRTkF3WmdQekdHVmlPQmZM?=
 =?utf-8?B?dVhHajBubVFEVnF0WlVnR21yRzJsYUdvZzdWK3VySmUweWRwRDNLTDdJdDI1?=
 =?utf-8?B?Wmx0UWpRdzI5aW9jMGFrQ0tMYnY5K2YyenY5dWNsN0lSSi9ucndvckFWODVU?=
 =?utf-8?B?dU9LWUVXdk54N3EwT0ltOUxLV3FQSUdCTEVvWEN3TzlZU2pKMlh4ekppZmtJ?=
 =?utf-8?B?UC82a0tlN1BYR1JDeFRacXdodXRMQzBOYXczcWY3K295b0tDb3dIMm1yTWNY?=
 =?utf-8?B?cVZoc04xV3NJV2Y2NCtnTTZBTlFIK0F3T1ViQ29ENGx5Qmh6NGNrVHVzMUVo?=
 =?utf-8?B?TElsS29oNFNwdWhRcEpDbng4eng1ak95M1laREx1aHVFSTZ6c25TbGxuRUxm?=
 =?utf-8?B?c0o1bDNQRWo1VmZyNFoyaDI1cHNMWWhML2l5eklzb0NBWU1WMGk2U3gzdDF0?=
 =?utf-8?B?emRPTjM5SmErSkJ0cGZhaUpjcnZWQitPMVlqTnJnaHdCZ3FVTTlUdkVzZFFJ?=
 =?utf-8?B?OXNGSDFYSDZySmg3OFIxajc2ZUJrZEhKY3creklZUzZtdkZpVEphVjNqVHZX?=
 =?utf-8?B?RC9OdEtCNC9idnhidlJrVWQ5UnFHV3BvdHRtbHFmSmZTK1ZkUGt5aTJ2NHYy?=
 =?utf-8?B?MStQRHNVajRsQ3JQSkJYVWdwWnQvNEhFSkVDVFEzYS8zNTAyK2tyOXFSK3Ba?=
 =?utf-8?B?anBGMEt4dEpKa3NadlQ0VXFZRjc2SkRuZTRLSnM5Y2J6SW8wUEhkNWxqbTdT?=
 =?utf-8?B?VktMSTJiR2FxQXc1ckptTUdLaTNHeEpzZTR4c1N0cys2bE9oTjhHemdxOXp1?=
 =?utf-8?B?bk4zK0ZqTHVMMmRVRzltZ3c3ZHllMVkzYzRNOXVyVytsOUhlSEV0WEQyc0d6?=
 =?utf-8?B?OGQyQjhoZ2xQWGNEZUtHOUFZbWdrdWJWMEYyZ2FlQWRFZW9wZVNxb1BUK2xX?=
 =?utf-8?B?M2NPVVFYbktzWlQ1TDNlS28yZ2JlQXV5SERUZlV3WFNZU2NjTnpVOThEYktR?=
 =?utf-8?B?SEFpOHJtRWxSUnlaKzg4UFE0ZFEyVnhoZjJCVnQ0Q2hWTEJWeStlUGEwN0Zs?=
 =?utf-8?B?MG5VZWJSME8xMmRmTWZUVGhIcmIrTVRPV1AwQ0hCSldvNU01andxbUFHSzJE?=
 =?utf-8?B?dWNLSUN1akNZcVduSU9qQmcwSnFOUFVwS3Y4SWxSWjZERk01bStQbWpWSXFM?=
 =?utf-8?B?RThWRkhUNkZwUVl4bHJVa3pNc2lOVUs3NlNjYXA0NmlHeHZBbVJWb0J4Tmgr?=
 =?utf-8?B?WXp2RWdYaXRCd21LcUM1MFdyRGNJN1hCN083MXNiNU5UKzk5NzFEY2NCT2lX?=
 =?utf-8?B?YTArL1FPbVFvM29sZlB5WlIvazBOVCtkTzIyTVBDU0ZhNGlqMFNCZGRYTkVz?=
 =?utf-8?B?Y2tPUlFlaFFWdExnN2dEOXlmSzZpUzNWdHg0V1JUYzRpczkvK1dmMUFXKzMx?=
 =?utf-8?B?Nm0xWWdJQTNaK1dVR3pZdDFaV0FwYkQ1bVhUejRNZ3dhK0JvZWQzZ2NkK3Rs?=
 =?utf-8?B?NjhWN0dUVlRZSFhmQ3V6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L29LS1J4Sko1dFdvODVGK0cwQVpBMDFzM1pFTHJ0L2NMMzFmbFpIU2w5VGE4?=
 =?utf-8?B?TTNFY09WVUp2b3BPTlRxQlhUY0ErcEZQeDNTQytJbjFmVlpSaHB5WTJUcnZV?=
 =?utf-8?B?cVFZbHN2THdkU2w5Z09hS29VbWRPMmQ3Z0MxQ0Jwa0RIanZvbVdzbkdoRlc1?=
 =?utf-8?B?RStXS240dC9EYkpSM21ZWWdPQ1REdlRmbmtKWHlYaWFPS1Z5Nkh4RlRvT1RL?=
 =?utf-8?B?V1lWQ1o0c0tpVVJLZVZQY3ZpRDBCRS9MbXExNnlVR29ZT3RVSTJqaXlyeCtO?=
 =?utf-8?B?RFkrdzd1eEh6N2hBM1Z2UnRlSEROdTU2bW1LT2VZZWZKRy9yTUV2K2ZFaTVn?=
 =?utf-8?B?bHd5aEJpdEc3MUo5RHBzeFB2WjdGaEowSGpQY1Y1bE1XUllDOFFFL3JwQjgy?=
 =?utf-8?B?S3hrL3ZYUFg4UkhQSGJTTS9wS050QlB0Y0lFdEFRamdYN0ZIOFlsYVF4cGF3?=
 =?utf-8?B?YmN4RlljZHZXMmk4d3BFZU5sQ3AxMlI5RGNjSVZ2SXhPSXp3UUxwVzhKUUZs?=
 =?utf-8?B?c1ZZcjZRWU82Z25JN1crVGNRWlJmNTdqUElwTUs0dnpvakdSTHdmNVhYRytF?=
 =?utf-8?B?d2RZRDREWVhTeDFmYVdiZHlqQUNNR1I4ZmpGY0N4Y0RqMHBibGRhL2RHcjEz?=
 =?utf-8?B?ZGcvNTJOdFFvSnlVTlJvbWdUKy8zWHN5Q29NdkpZcFhCUllWWW9WUFg5SERO?=
 =?utf-8?B?ZjQzays3bEYvTjZnKzhJTkptemNDY0JSQVV6c1QrY2pqb0hTQVdnMjVDaks4?=
 =?utf-8?B?d2N0TzVYbnZwOW9PckRGOWp4K0R4Y29MNVhuZ1czKzJjQWp1Vkl3WTdYRThR?=
 =?utf-8?B?NGNiZmh2Sk9VU0FrTVkvaDB5ZUJSVDZGbXFLY0ZQYVJBb3crdG9saFhrTkZw?=
 =?utf-8?B?dzhUd016UndiU3o5b1NYb0doYnVkVlRLY1lDOExJeXZHaVdjYTRxVk10WWwy?=
 =?utf-8?B?aXZvbHRBSkpKVjlqZUx5T3hxck5oQVljVyswSG1OQ0RGQ0RiVzRwaXFRb2Vm?=
 =?utf-8?B?b2ZNdWVEOW1JWndlNnRwR0JzamZML1RoMS9rZ3NHaUVPb0Y5dWRoVm5HQmZz?=
 =?utf-8?B?bE02ZnFUWmVWS1FxM1lBSmoyT2VjSk1vNEh6TjNjYkNJV3IwdVV0d0xCS3FP?=
 =?utf-8?B?aUFVZDVPSGhrSHdoTkUyajZmNXZsbHlQMVlTWEQydFZJY211SHhJMEVucGdE?=
 =?utf-8?B?QU9xMld6TFFpbi9IT01NMURFQ1dhS1pBdmJQK1ZObk1FM0dUQ01ycElsS2Ro?=
 =?utf-8?B?NkJ5K3hlYlRrQk1QVG4yeVhCL21CQ1ZUcEN4cml1alpnWnV0dDJSOEpNNDFy?=
 =?utf-8?B?M0ZoM2ZFNXRDRXJRRHpVd0dVcVNHRlAybnczekhPL01uMWhxa0QvVWRFRjJD?=
 =?utf-8?B?Z3J0SkZ3Q2dKcDdkbGRXSkdQdWF5NHpCOFBRYy9xT0ViM2pVdUkrRmRkSmk4?=
 =?utf-8?B?aGg4SVhMdEhOaWhtQmRHaWNjTmNMUkhnWEpDT3BOZFBabjl2d2xPVFBZaVhv?=
 =?utf-8?B?Nml5OHpDeFJwc0lyQkNDcFdWNjFSM1ZkK2lBeW16Uk1CQVhjNUlFcitoTmR6?=
 =?utf-8?B?U3lGQ3c0VXZqU3VRNDFTU2NwRjBVblVXNFdObXpOem93Tmt5OVlwTlp4bFU3?=
 =?utf-8?B?TUpQUXA2UjJqUExGYjY2U3ZUWlJNalRkNmtuTkhFeVc4NldmVHBUNzRTUldt?=
 =?utf-8?B?b25ST3puYmVzVFlTZkoyMGVSdXhwL2xFS0hqQUVNeklDRG5EMkVSa0lqbVlR?=
 =?utf-8?B?ZFVjSTJvNURKRlpzdXVZZ0RqbGpkZFJFemNqOStadXAyVVA2Ym1LejdRU1Y1?=
 =?utf-8?B?U21KWXNJTC9paWl5Q1lVSEtJRDFKN0lXaVhaWEU4aUdBZ041aTJoVC9uRFFz?=
 =?utf-8?B?d3FoNEJ5Q2hGT1NRYkF1azNnYkF5TVFYUzJWR05nU1NUUk1WWHBNK0F4OUxr?=
 =?utf-8?B?Vm83dnN5YlhFNVZ2clVBVDA3NW5WM05VWVFiZ0xPNnRJUkk0d0xWWVRIU0Vn?=
 =?utf-8?B?SXNUVTU5TnljNTVBeVlYT3VOUlo4RUM2bkRMN2RPTDBGZnNxREt4L1pJUzh6?=
 =?utf-8?B?MWs5ZUgrM0pEZWNJV0plT1hVcWlsZkhpc0dqRm5XMjFwVUVmV3pVWnVVS3VG?=
 =?utf-8?Q?aDpzSyp1qfV/VQvRQhJEfoLQf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc8fcc4-eb85-4667-989e-08dcb79be267
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:18:52.6847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbhqW7kxXqZGztFn0150ojM8yoVZi1VUhThG5waC7fEUsLmOz2w5RO7P4581JliQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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



On 8/8/24 08:22, Sughosh Ganu wrote:
> On Thu, 8 Aug 2024 at 11:05, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 8/7/24 23:12, Tom Rini wrote:
>>> On Tue, Aug 06, 2024 at 05:37:00PM +0530, Prasad Kummari wrote:
>>>
>>>> Added LMB API to prevent SF command from overwriting reserved
>>>> memory areas. The current SPI code does not use LMB APIs for
>>>> loading data into memory addresses. To resolve this, LMB APIs
>>>> were added to check the load address of an SF command and ensure it
>>>> does not overwrite reserved memory addresses. Similar checks are
>>>> used in TFTP, serial load, and boot code to prevent overwriting
>>>> reserved memory.
>>>>
>>>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>>>
>>> This is a much more generic issue that should be looked in to with the
>>> LMB rewrite that Sughosh is working on.
>>
>> yes. And is it going to be the part of his series?
>> I expect that if he accepts this will be done on the top of it and there is
>> likely no reason to wait.
> 
> This change would be needed, but in a different form. The patch, since
> based on the current master branch, is assuming a local lmb memory
> map. My series is doing away with that, and so we will no longer have
> the lmb_init_and_reserve() API, for example. I would suggest that the
> patch be put out either on top of my patches, or ideally, once the lmb
> patches get merged.

I care that we can't overwrite reserved memory by any of load commands.
Better to be fixed earlier rather than later but up to Tom to decide.
 From my perspective this is incorrect behavior which is fixing issue and likely 
this can go to 2024.10 version.
Your LMB series is likely going to target 2025.01.

>> We find the issue out on system which has more dynamic behavior that spi pytest
>> read the whole memory and rewrite TF-A.
>>
>> And currently we are in situation where some commands are checking reserved
>> location and some of them not.
> 
> Like you mention in another email, there are instances where we have
> commands which are loading images to memory, but are not considering
> the lmb reservations. These should be fixed, similar to what this
> patch is attempting. Maybe we need a common function where the load
> address gets checked with the lmb module, similar to
> fs_read_lmb_check(), and then have this called from the various
> commands?

yes, it make sense not to have 4 different functions in different drivers but 
call only one. Definitely nice to have it on the top of your LMB series to be 
able to use it in nand cmd for example.

Thanks,
Michal
