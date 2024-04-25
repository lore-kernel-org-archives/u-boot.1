Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167EEC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D559887B4;
	Thu, 25 Apr 2024 12:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLzv1JRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D95A886C5; Thu, 25 Apr 2024 12:59:51 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD61887B4
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzSCi+IkAxvbJcdsQGgLQJblCfD28ZA2crG1e+TnDa+eEF7cMC+hzfTAbEomjYWbhbQHCFKy2KDTeqtzx+AN+E+/Z27FAANU6HCsx6WvR7wG1RG62Ovf5FMN0tuILHUmIPOUszqwD7wmVNJQEbLwFSKRFRxqpZSKBkOxMIUdwIqGGB8SnmFSPS6OVW67Bxjyp/w6LPyQ6sVgU1bdJlsFv/SQ45lIyPxCun3v1T5AOMRxhgFeJ7alYaOWSpQ2HXJ18sAJBLcFZ3MkP8vJnU0lHh0BrGGIVp5JlAwabjOGvVmsnPfRBZIuJmdgrL3Jkv/uGlGcT69rgDVECKva0wlHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWFFaK2du+OGlHdocc+7CHV4Ap/cLg6rzsjFKfowsWM=;
 b=leNZ+z6hF8OeYuWDBPp74AlqWQah5KEFeCroTbzpqz70NKaZbsbhs2OITMfXpeogeGMktnlqTudvRRh+9AX5MZo49jD4pSjczuecU5o2kqLNK5z2fQc4llkmGkJOhV6cTe6AtY8L+U6OBXGrkUsjNtkLqWMlEeLOngU+bPCNAkI8AeSNgsR0YILY/iOsUBg2H32YpMoi6OIv1v+ZyIMcmiLyCjLmIr+sMaPCaTRkdtaV1kZ0yxwrPOZHRQK1R3GM7m6dwYB2FTCnK/J+dvDkfMAhl/UNbi7qfKi88BCHk0B8kgN2vQ0zgSHH6b2vwayPVE51TKZW01yMpHt1yN/Oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWFFaK2du+OGlHdocc+7CHV4Ap/cLg6rzsjFKfowsWM=;
 b=vLzv1JRshxM1wlAZbb/sKAFJBuUhzm3oEO/IPQNQlIjejYGNvTBy1vB/UuszNXfvcw8/KHLf7uWxueqfCr6MMqn7KLkJfyz4VHtnOv7Y61bq38omB6PDbEmlTCVCQOADNgHjmz2n3bQ5w6NKGSFQl+THX+BEWvpvgKOZrI7so2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 10:59:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 10:59:40 +0000
Message-ID: <9a5501c1-359d-4e5c-a25e-7c1631451af5@amd.com>
Date: Thu, 25 Apr 2024 12:59:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynq: Fix EMIO clock use detection for gem0
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Igor Prusov <ivprusov@sberdevices.ru>
References: <20240416084456.2821567-1-megi@xff.cz>
 <ca63cfb0-5e5f-4522-8cda-87dec22588c9@amd.com>
 <5gv2fqik5vtygldqmv23tpcsyaftazblm4atk3igweduivmiqu@aeoflxwzlvx3>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5gv2fqik5vtygldqmv23tpcsyaftazblm4atk3igweduivmiqu@aeoflxwzlvx3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0069.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: e0103ff3-7987-42d4-e82e-08dc6516ce2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnJNeXZNVTVWOG5mVmw2OThIdmZqem8wWmZ1S3ZIRCswaS80OU55aHNpOWly?=
 =?utf-8?B?ZlRFMnFvUEIvdDJuakdndDZoUTBMdjhFV2xxN0FnTzNEcTNEbklKQVB6L2FU?=
 =?utf-8?B?WmxSVHNSTUVxM2s0a3VuVTlZOGNmQjg1eUlkbC9hTjdvYlRvZTNtK01CVWxw?=
 =?utf-8?B?eHhmeWN6VXlPemx2MWhjS2RxTXNhRFlrWUFkSnJXQjQ4YitYVUtNK3ZtUjdZ?=
 =?utf-8?B?L29TM0Y0a2NoZmhkd3dpZWI5MHk3S24zMlcvTFE5bDFUNjdFU0lwaDVCNFpG?=
 =?utf-8?B?Ti81UEFHOTRoWE1oeGxXZld6NVZtaXdFTEdXNGJ3bVV6MjFLM1ZmdlRZaGhZ?=
 =?utf-8?B?b1FKaE9RQTdYVTlZSVUxUVM2TEdPL0UyUHJ6bkFMZTErVktia3BYSGV3c2JR?=
 =?utf-8?B?OTNOUzZEYTVCOFBqM0lCUWthUnFTaGFoWEVpYzJubis4NDRLQVpmWDR2Q0pl?=
 =?utf-8?B?b3FQdzlEVE1xc0F5MXhHUHFOVGNNYVNBdjM2aFFuSFdsQjdUR3pwejVlcTlU?=
 =?utf-8?B?QVZXdjVlWEU3QUo3N0hrbHQ1UDdTdWNKY1J3MWhSSkNHMjZvenZrYWVGTzFr?=
 =?utf-8?B?VTRDYmdFank0UEd1ZWdkUXVMRUpnS20rL2QySnRYVFE0VHE3UmJ5UDZHZng3?=
 =?utf-8?B?bHJoTjNsWUFOL0RBVlNsYjFFQ2czMDY2WHN6K0FIVXVibkRoenZxWHdJcy9B?=
 =?utf-8?B?dU9xYlI5NlA4OTRtNm9HQ1BtRWNoKzVRN2kzbDMzMWZHbTdRcWtKWm9oODR2?=
 =?utf-8?B?cTNpYUdLdHVjaE5PM0FyaERLbkpZeDk2bjl1RFdPT0xpK0VYUVlXT2I0TXky?=
 =?utf-8?B?MG1ndERqUWxMcm9jdUJvL3pRVktJNlIyWG0yOHBSRVB1RGo4NWZLWnVlQ242?=
 =?utf-8?B?T2ZzTGRxNkZjV2xibm5zYTdsSzUyTisvU2N2SUJyUDZEbHk0bDR1UGhUaUdn?=
 =?utf-8?B?ZGljZ0tiQlRzNFBKNzJKRU1kNVlicXVxZWR5bVUrcFoyRk9jaXZVaEdVUSs5?=
 =?utf-8?B?S1dhQStHaXdPdXBuUjZkbzBNcS9PdUd3SmMrVVphT2xVRm1peUk0RlY1M08v?=
 =?utf-8?B?TDlROEJCSlJha2ZVNmFTV2NhOGFBNURXRHcwM2Q5WERFQUthVXlvcHFreEhh?=
 =?utf-8?B?aktnbk1xT25qUGhjbWdDUzZSQnRVVzVKd1FCSnZpcmkxTkNPRHZCdUo1S2FY?=
 =?utf-8?B?dHFrT1hJbkRENkJmWXQyZ3FkUXJIaWRLdDlwQlFMcEs2V0QvTjlYTUM1Wlpi?=
 =?utf-8?B?M3hmZnZ3aHhFMFJwa3c3YURzSlEybThSOGptT0M1aW9UTERmQ2kva1U3NS90?=
 =?utf-8?B?VkhTQklrcDVxdmszSkxHMHJiNFNqM2lOdzVERXFCY0s2ZlVsSWxDMXd1Tjhr?=
 =?utf-8?B?NHovZWh0TVFaQVBSeXBreWNRRzlpNGQxVXM0ZDR0cVN1MEJCRjNPUnFMYi85?=
 =?utf-8?B?SmcrQzNPeXkyTTlYVVNZRmMzdFBlK0tCQmlxTktYRFJaQkpqaWpwMGxOZ2NK?=
 =?utf-8?B?UWJQQ1poaW0yR1FHOStFOWVsL3Y3Y3hGOGx1RFkrbUYrQmlKekNKdlF1elVR?=
 =?utf-8?B?NHFvWjI1Rkw1bTc4UHpRRU1tRkQrd3MyVDRnSWRDM3I5WkxJOGd4TzRCeFN2?=
 =?utf-8?Q?CNbiZic4Wd7FMNfn2p1c27kOwaA96UYGHlkTJyQO1yrY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnVyZDJZZlRvc1N5U043OUpNWnVOU2t5cHdYcnJwT1MwM0NOYmFwLzJOaDV5?=
 =?utf-8?B?YUJwREgrWUF1NUVGTmJtck1sVTdaaFVPZkd2cmltbnM4T0xFN3IycXdKbldE?=
 =?utf-8?B?S0RWSmh2eUhkc0FVUlBYZjBZSk1PSU1jbjBiN3pudGJ6MCtGYis1OElxK3dZ?=
 =?utf-8?B?UDNjdGhiOHh4S09USk43dEN0SXlXN0tqbE8vS3N5Tk9xTmZteElXSThBdE5n?=
 =?utf-8?B?Q0lqMHRKd0tiTU5uTTUyS0VTZ1F0eitqZ2hrUTQ5WjBuMG5KNktHeDViQ25O?=
 =?utf-8?B?TUhrL3NsWlJYT2FJUnRLMHVpRFZ5RjBGc2x2RGg4Vm51NlREem4vWWxoS01n?=
 =?utf-8?B?MWluS2RzcHJ6L3gvTFFtV1Z5T2xxRkFkMFlkUXc0Z1M3S3hIemJZbkxwNWFw?=
 =?utf-8?B?ZzBTc2NVT3k4S05WNmhuVmRaeUZGNlJGM0hHcVpNa2srOUVwRDFGK0c5VUxk?=
 =?utf-8?B?aFpNRzYxVHk4QkwvMlVtQk1tSEhPN0F4TTN0RWo0QnQ4TWVPaDVJcHFUNkNW?=
 =?utf-8?B?OHlhSCs5T1ZDV3ZmY09FOFNJT0Flc1crakZBOUFGUU83cVcxQ21oYUcxYTdJ?=
 =?utf-8?B?VXA0bVJVVjllR2J3dCtxOFprMWhJSS9Id2ZHTm5udjRFS29VclFOKzRVWmhv?=
 =?utf-8?B?U1pPVU44d29jMExxVGtWb1g0YzhSV1JNblNwVGZVSzVid25YdkdtaDRNNDVs?=
 =?utf-8?B?bzZhSm9SaUhmZnNCT1JFMmNiTThqK2lWSktNTjJ5TzZhL0srcFVSQXNBZ3d0?=
 =?utf-8?B?cDRFUG9HckJqcG1VWnRtcFR0aCtxSER6elZ6NUdTZjFKdGdzQlNEVnFmS2V2?=
 =?utf-8?B?RWtRK3JwdEc2TnB5WE0yYzB1MlBJWUJWaG1QV0FCRzhXcndCMjNxYTcxOVJS?=
 =?utf-8?B?ZHZkZmJOcU9SNnpzS1VueG5NWDJKUE5tbHhjKzNzM0dPcmlteGFCM0tIVHlu?=
 =?utf-8?B?UEtvZVhFT2grK2xGbncydzA0N3BEL0RhRy9BTTFRQno0bUtwWDh0UWVzT29k?=
 =?utf-8?B?WFNneGQ2dW05WkRGMjJXRW1IRE5pRDBNK0FDYUJBall1ZE5zY0hSN0pYTkZR?=
 =?utf-8?B?cWhSOG5JZ0JaT3h3alBrOG9NVitGWG5nMERSb3dicUtoZTZTKy8vNEFNVTZN?=
 =?utf-8?B?enF5THZPUGQwWHNDYit3ZHRQeExIbm9ReHZBbmRjZzY1d0s5T2s5cC9YTXRz?=
 =?utf-8?B?aWhHN1l1SDVkcGN5bWg4WEtKRE1qajAwUkVCZnVCY0Via0w4bk9ObU43bXlo?=
 =?utf-8?B?QWZEVDlCRjV5Z2ZUdzMrNUxacnNSNHp5b2FpQ3lPWDF3Z3VsdWo0eUhTS2FE?=
 =?utf-8?B?OUxPenNWellaTjM5bkVhK2dweU5oRGVhd0xvQ1RZOG1ETkJRczV2enhjdjFL?=
 =?utf-8?B?K3BxeTkwMjRXWnVYc3RsRjZ5Z3VKNjQ1aEpmaUV5MXB1WlVsTm1uMTJMa1ZZ?=
 =?utf-8?B?SGFYY0F4TEF5alJvNHBzZU93bko1a1lhT2k2anp0RXltOUNXNjVlVW9kTzRw?=
 =?utf-8?B?ZnZsa2lieXdEcUkxN0s0YzRzcy9SZHpzZE16d1daand2SFFUL1pieHJzOXY2?=
 =?utf-8?B?TGs0MWNlMk9mVHloN1FzMlpucXpBUlI3YzFoYSt3a0hwZ3l3YlpKNTdhbVRK?=
 =?utf-8?B?azkwK1Z4R3kyZkZQc2l1ZW9NbjZKd0U4K21icGdPeTkxSzFOTENTa0VpM3JW?=
 =?utf-8?B?WFoxano4bThJOTgvNDY3YUtOZjA2UjJlQnYyRFlZVTRLYXVJMTdvQjlDR1dH?=
 =?utf-8?B?V1lmK3dlT3NreEVnQkpzU0QvTXpqekZlQlY3VlpYMDZHNzhoSEt3UG16Y1di?=
 =?utf-8?B?eHB5V0ZhVExGY1JCRVA0TGlPNDRuUVRnM3lxY3o3MkNUSjJ3TkJjSjUvb0V0?=
 =?utf-8?B?aGdEOVMvZkhpNUUxcmRKUVMzSGJjR3VIZk5RTDJ5TW1RWWdiZTRYUTlVUVNp?=
 =?utf-8?B?WjhxVmU0VWtqemxtUUJrSVNyM096QXBtT1BYSmsrYlJRM0N5TWlGWittRGl0?=
 =?utf-8?B?dkdabmxFWlowSDZTT0w5a3A1L0FPUVFGWFBaMlVWcVRoZ2pYYU9HR3ROaDBz?=
 =?utf-8?B?b0tmQXNVSlZ5SC9BdHh5TmQ4RXdZLytCS2hpdlArYk9mdGo2MWlWamdZZUNp?=
 =?utf-8?Q?pFsjQ01XmfCJ6emrMtTM8j0yA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0103ff3-7987-42d4-e82e-08dc6516ce2f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:59:40.5353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY+fvkSMHuuT+tES323ecRy+R7rhb1TMju0wH1Tr4aCQ36M0VmCLmrlci5HpE4pt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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



On 4/25/24 10:23, Ondřej Jirman wrote:
> On Wed, Apr 24, 2024 at 04:34:05PM GMT, Michal Simek wrote:
>>
>>
>> On 4/16/24 10:44, Ondřej Jirman wrote:
>>> From: Ondrej Jirman <megi@xff.cz>
>>>
>>> According to TRM, the bit that differentiates between MIO and EMIO
>>> clocks is bit 6. This resolves failure to set clock when using EMIO
>>> clock for ethernet.
>>
>> Not sure which TRM you are using but here
>>
>> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-GEM0_RCLK_CTRL
>>
>> SRCSEL it is bit 4 not bit 6.
> 
> Maybe TRM is wrong? :)
> 
> I have XSA produced by Vivado that has:
> 
> GEM0_RCLK_CTRL:
> 
>      EMIT_MASKWRITE(0XF8000138, 0x00000011U ,0x00000011U),
>      // .. CLKACT = 0x1
>      // .. ==> 0XF8000140[0:0] = 0x00000001U
>      // ..     ==> MASK : 0x00000001U    VAL : 0x00000001U
>      // .. SRCSEL = 0x4
>      // .. ==> 0XF8000140[6:4] = 0x00000004U
>      // ..     ==> MASK : 0x00000070U    VAL : 0x00000040U
>      // .. DIVISOR = 0x1
>      // .. ==> 0XF8000140[13:8] = 0x00000001U
>      // ..     ==> MASK : 0x00003F00U    VAL : 0x00000100U
>      // .. DIVISOR1 = 0x5
>      // .. ==> 0XF8000140[25:20] = 0x00000005U
>      // ..     ==> MASK : 0x03F00000U    VAL : 0x00500000U
>      // ..
> 
> https://megous.com/dl/tmp/20e2593dbe9e0b3b.png
> 
> GEM0_CLK_CTRL:
> 
>      EMIT_MASKWRITE(0XF8000140, 0x03F03F71U ,0x00500141U),

Here you have 0x140

>      // .. CLKACT = 0x1
>      // .. ==> 0XF8000148[0:0] = 0x00000001U

And here 0x148


This is what I see for external clock

   265     // .. CLKACT = 0x1
   266     // .. ==> 0XF8000138[0:0] = 0x00000001U
   267     // ..     ==> MASK : 0x00000001U    VAL : 0x00000001U
   268     // .. SRCSEL = 0x1
   269     // .. ==> 0XF8000138[4:4] = 0x00000001U
   270     // ..     ==> MASK : 0x00000010U    VAL : 0x00000010U
   271     // ..
   272     EMIT_MASKWRITE(0XF8000138, 0x00000011U ,0x00000011U),

and this one for io pll

   265     // .. CLKACT = 0x1
   266     // .. ==> 0XF8000138[0:0] = 0x00000001U
   267     // ..     ==> MASK : 0x00000001U    VAL : 0x00000001U
   268     // .. SRCSEL = 0x0
   269     // .. ==> 0XF8000138[4:4] = 0x00000000U
   270     // ..     ==> MASK : 0x00000010U    VAL : 0x00000000U
   271     // ..
   272     EMIT_MASKWRITE(0XF8000138, 0x00000011U ,0x00000001U),

It means even Vivado is generating it as BIT 4.


>      // ..     ==> MASK : 0x00000001U    VAL : 0x00000001U
>      // .. SRCSEL = 0x0
>      // .. ==> 0XF8000148[5:4] = 0x00000000U
>      // ..     ==> MASK : 0x00000030U    VAL : 0x00000000U
>      // .. DIVISOR = 0x10
>      // .. ==> 0XF8000148[13:8] = 0x00000010U
>      // ..     ==> MASK : 0x00003F00U    VAL : 0x00001000U
>      // ..
> 
> https://megous.com/dl/tmp/65c6ee01818a06ea.png
> 
> So the PS init sequence in XSA suggests that GEM0_RCLK_CTRL layout
> actually matches the GEM0_CLK_CTRL documentation.
> 
> I guess Vivado is right and TRM is wrong, since HW works as expected
> with the PS configuration that doesn't match the TRM.
> 
>>>
>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> ---
>>>    drivers/clk/clk_zynq.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
>>> index e3cefe2e0c72..78e6886a000c 100644
>>> --- a/drivers/clk/clk_zynq.c
>>> +++ b/drivers/clk/clk_zynq.c
>>> @@ -42,6 +42,8 @@
>>>    #define CLK_CTRL_DIV3X_SHIFT	20
>>>    #define CLK_CTRL_DIV3X_MASK	(ZYNQ_CLK_MAXDIV << CLK_CTRL_DIV3X_SHIFT)
>>> +#define CLK_CTRL_GEM_EMIO	(1u << 6)
>>> +
>>>    DECLARE_GLOBAL_DATA_PTR;
>>>    #ifndef CONFIG_SPL_BUILD
>>> @@ -161,7 +163,7 @@ static enum zynq_clk_rclk zynq_clk_get_gem_rclk(enum zynq_clk id)
>>>    	else
>>>    		clk_ctrl = readl(&slcr_base->gem1_rclk_ctrl);
>>> -	srcsel = (clk_ctrl & CLK_CTRL_SRCSEL_MASK) >> CLK_CTRL_SRCSEL_SHIFT;
>>> +	srcsel = (clk_ctrl & CLK_CTRL_GEM_EMIO);
>>
>> Definitely using SRCSEL_MASK is not ideal solution because mask is 0x3 and
>> in gem case it is single bit. But based on description you should be getting
>> correct values even with 0x3 because SHIFT is correct.
> 
> Well, it doesn't help that the code is almost all refering to CLK_CTRL while
> actually accessing gem1_rclk_ctrl in the struct.
> 
> In any case it can't detect the case when sourcing the clock from EMIO and
> not one of the PLLs, apparently.
> 
> The failure I'm talking about is here in zynq_gem.c:
> 
>          ret = clk_get_rate(&priv->tx_clk);
>          if (ret != clk_rate) {
>                  ret = clk_set_rate(&priv->tx_clk, clk_rate);
>                  if (IS_ERR_VALUE(ret)) {
>                          dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
>                          return ret;
>                  }
>          }
> 
> And all I get is "failed to set tx clock rate" from U-Boot and no ethernet.

Zynq is quite a old device but I expect you have external clock out of chip or 
you generate it in PL. For that you need to describe it.

How does your DT looks like for external clocks?

Thanks,
Michal
