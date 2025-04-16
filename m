Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AF2C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021E082DB4;
	Wed, 16 Apr 2025 13:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vultExAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A9882E38; Wed, 16 Apr 2025 13:51:11 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEAB581F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3wuJFL3zroX1Q7PSvOVycYF1khP8aVhI3WfUqoElxavxfrYgVuAo0gdN0ozngVS8+G5bPS9l8yC+C8KLUFWcw0y81Rlaenvqn1bxlQqyud8lJXaWk9c7GOmUjETwKh9HwVV7QOsp0qK3osjoUkNCLMxX8seqALQdpsi9QcLu2gzF3DxbGdVwjYXCdSq1YDqjMg0QZXRHUcnrrDg3FhfO6klz5C3+8daJGz6ZPi7DDB/2U4vIS+BjV+5i5xDyz94CCGJ8OfZAFeGnqKG2YK2yeC25yxdZ6F+XKqUPipa9MDAaU7ABqb4pX/CJeoScvPcMQeV3jDExMLrv6EUsYSBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeDTuMyOd70x9U6OvJKJGSXZ1nfqysPhb2/x59o0ibg=;
 b=GvIaFVXckcDdQZaQWEVTADVjHS1soKEK24bUe3Ox7Eu9avC8OUjMvQE5FpBcMHL+lD3HYJ6mbMvEk9m+lpKqAlxtsEwh3xL0ZzNEX+SmTBeyS0/naqUiW1r22y+H76ka9o9MryaKvZ+g10A+RKK4vwCJqs75c1uON2ZAWpr/lYz7e7pi2xvqlQQLvtMPliA82sGmYs1gKmx4FC1YGelL1wW6R+Tno+iSh5lb5Zs2PYG5Ut+j9fasg6Upj813G2o/X8ZCZ7HeHgBV/P7hvkw5j8yQsBBfvFVWP9WTcGKbdblY8tO21vHwJ888i6+oD6O7eNx/xG6x5odyrrG5H0Diog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeDTuMyOd70x9U6OvJKJGSXZ1nfqysPhb2/x59o0ibg=;
 b=vultExAZCViNsajWJF2p+x7drrumBSWZ8zQmMu7RbtIhli/8BGa6QrRE90S859ICkSiY+y/im8pjHQdrTk3s/Vtno8GxH+wsyn2X02iYS1nVGzzr3fKMSAZXlvr32S1LPcfvh0DZzkybfKqIbcAf2JoJLnN3gtrGevtKoTiUrKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:51:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:51:04 +0000
Message-ID: <3702a956-e66a-4d03-aaf4-550c26596372@amd.com>
Date: Wed, 16 Apr 2025 13:50:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Store board info data in data section
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com
References: <20250409162553.588285-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250409162553.588285-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df11c19-1fe0-4088-2338-08dd7cdcf751
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akxMVVhZRWN6cXRTcnhDdXR2TDM0QlhLbVY5UE9qMmhma1dscSs2dUFDOHA4?=
 =?utf-8?B?RWxnV1VLS2JUVzRaMkZMdDlsdHpOT3cvSDcva2ZwaWpZZWNnbFBraW9wSHh1?=
 =?utf-8?B?cFFab21RWHhmWW1wUzJhNE5jVyt1ZVBlMElnUVYwaGtCcFdjemE3RExnbkhF?=
 =?utf-8?B?dk9IRHQ5NjBSczBkei9QcnVPd2NlZWN6RWpreG5VTmFaNFhHM29wRnFIa3lL?=
 =?utf-8?B?aWNSTzRZVzZucEZjMFM2Y2xSeGZSQ29LeVlyUTh6QWdmNHFZcHNrYm15eFVq?=
 =?utf-8?B?RURaTjd2NGxSUWhsUGxvV3VCeStwM0lrVFRmcGxJdkpPYy9zSm5vT3h1aWtt?=
 =?utf-8?B?cGluRE9uME1HOE02TGVrTG0wUjJrc0FtcGNKUXVSSUV1L3RjVzlEUkZUVVp1?=
 =?utf-8?B?ZWlLdVB6ZjROenhXeTY5SmRNV0JxOXVYQ1BBNFFqUERPcEoxR3JIaXNjS29I?=
 =?utf-8?B?L3V1SExROHQwbUtXbU54Wk43VndlYUpJT3NNSkg1ZFdRNEpSMmdiVXVZUlZS?=
 =?utf-8?B?b1ZTR0ZLWkRvTUNvNWlJN0c3clhFaUcvdEJaTXZQYnFNcFZzTkNHMUpWbFJF?=
 =?utf-8?B?T0lqTTVaQnQ1YTd1R2ZMU0JzSjNMM1NRNEE2a3huYjhBRzd1Zzg5TGtBaGxi?=
 =?utf-8?B?RDc5L3dsQmIwSHZlK1F6bG4rNzNyZEpXODdGdFdIZ0VjT3lDMXR3K2RhMWRH?=
 =?utf-8?B?SWtFQVJoNDNCZkliVTZlZ2JVNDV2a3NDR2picDEyWk9ob0hmeFhQbmYwc1h2?=
 =?utf-8?B?VlpSZndkT216eFdIeGtwdkQ2YlBSRkpDR25YT3ZuK1hud05pK21aYVBka25V?=
 =?utf-8?B?WkJCWnZVeklja3RNUUlYOVk0RzNRUUVESWtpWHdNSlNHbW5pUEtUMXJueEhJ?=
 =?utf-8?B?eThLU1B4M3p6MDhTRENSakpwVXhUMUJZMEJnZzFES3dkeDlYYzkybkJua0Y0?=
 =?utf-8?B?bTJ0WXNtNjhoaFNVTHBPS1NUYjgya010dlNyVTBiYTd2S0IrZkdBNWhmb0cw?=
 =?utf-8?B?UTFRaVFoa1FxOEtFWnJIMDFBWnl6U1NHUnpLbGx1U3RSa1VLNVR0bGptUWR2?=
 =?utf-8?B?ajlzSDNiR3ZuTFRDL2JoelArTVBRZXVDTjZ2RWwvSmx4RENJMjBUa3FtOHNo?=
 =?utf-8?B?a244UnFSVHJHRlFKVzY5cVhCbTJWMFYrVm5POThVMUR0eEdVb3ErM1NDZi9n?=
 =?utf-8?B?Y0cxWG5XYkY5TUVlU3M4aHkyZGs3bzR3VWVCOGJwZ005dnZlbStxTnp2aTJG?=
 =?utf-8?B?WFJoRWc1U003RG92Qm8wcGFlSm1vQWlNblNWblNvd0plTUN1aGF3Y3J0RVo1?=
 =?utf-8?B?WTJQaTlxZzFVdTlnc3RLUXhlVlRyU0M2aHRaT0ZkTldxUm9sbzhrU3BYaldv?=
 =?utf-8?B?T1ZLV2l1R1h2WmZBd0k0dmtTZjJaTEt5azhyeS80dmdtMG5xQzIvQU5Rbjdw?=
 =?utf-8?B?NnBtTDhoYloxRFMwbUtDcGxPYldkWEJsdkpWamVPRm5ydnVDbi9xMjc2d3o2?=
 =?utf-8?B?Y0J0K2lYWHNHcmw1bXdxallCVGdOamxGaXNWL3ZnTzRFY2ZQeWZhNVBKMWxN?=
 =?utf-8?B?UFlNUzlsb0pEYm9UeTQxckJjNWVxUzRkRlV1NjllMzluK2hsZ0hlZU9jWE8z?=
 =?utf-8?B?NEpQclp1RkhQaHlpbjVBanJiQWZWcitPdy9UdFU2ekxCcEZxK3ZiUW1SOGZm?=
 =?utf-8?B?RC90QTRCTUJDQ0cxUUVYenZGV0NJTWVsSmo5NGpVVVg0Q2QrYVlRYXBFemJL?=
 =?utf-8?B?Y2NYN0pvWWpWZGZ1NEJHcGZPdkF3cFNpYmdxVUVaNmxPaWMyZXRObHNxdTdJ?=
 =?utf-8?B?RmtsYW5PSTIxNDNWZTVTYWR0cHdlRXBkd3hnV2xtNC9nNTFYYVV5ZEZvY3l5?=
 =?utf-8?B?WE9WaHI0dGpVWFVHSkdGdmVYazNLaG56RC9kSk1GRnVVV2lOT3NSbWhsSGZQ?=
 =?utf-8?Q?SuMSnl10c+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhxUHo0eUdTa0VCREJHY0FXTEVRVGFvdDN0R25uL2lObWpkRFQrODJ2WEx5?=
 =?utf-8?B?Vi8rY0x0NW9UUVdpT0U1akwwM1pOZFJ1bHFLWGZEaGxnZkRzbDFDbEdHY2xq?=
 =?utf-8?B?TzIvYlJUOFkzQlhHRWQxbWFDT0FhTGVVOFhXSVlONFJTTThjS2RVQUt6MGRw?=
 =?utf-8?B?MkI5YXBPc0VJWmpnSHBsZFVacU1ibEV3MUJwdHZvekZ3a3VKQlNXbEd1cURB?=
 =?utf-8?B?elM3cndVVEdhVEtHTzZ6WUZTZTZDSUdJMElpYXpwZWYxZkMvQzIzNGw5d1Fr?=
 =?utf-8?B?Nythc1pEUnQrK1pqck41RVhLb0VwcWtzKzhmSHZqWlAyTS9FOVJFaDhjbk5m?=
 =?utf-8?B?SVgvWkJVYUhpSUVCR3o3OWFEMDZFSmJpUG5qWUtscS9Vc2t2bzhWYW00UXZo?=
 =?utf-8?B?cWUxK002ZW9xUGJiQWZndzFiYVBkbjlnR0p6N1BJZ0NleXFoSWc3aFVEdEJh?=
 =?utf-8?B?ZzBTejVBS1I2SXBncUVERVdxWmdINUpISS9wVENDSzFka1dJSjR5eWVpUmV2?=
 =?utf-8?B?cU5CUFVRK25UNzEwdUtPK2p1MWgrd3JUVTVWOTNNWlNPVlVwYnVSTHdmYWl6?=
 =?utf-8?B?eVZZQks3MFUzQVhWcFRlZlBmR2NjcGFJVFFHWDRHU3BjRlIvaW5hUW95dnVq?=
 =?utf-8?B?cEp1VlFOV1VMWWMrZ0Fka01TR0k2TzRKSldPSXc3OFFjOC9tVkhNZ1pDYnJ2?=
 =?utf-8?B?YStpSXpEL1JWVm9uUGYwYTVIOTFSTzh3K3lWS0ttZ3Fkc3JwMm02ck9kTFpq?=
 =?utf-8?B?a0V2Y0pCbHdBZitqYzN5WEROVjB5cmVxZDBKZ1V4UmZ3Sy9tK2dBZ1R3dkdl?=
 =?utf-8?B?eXVoSm1MT2g0NGRXc3ZzVXE2NXFCUlVyZUNNVkY2azFlcTNnRFBuYVExRzd2?=
 =?utf-8?B?UmZnUmxvcCs3UEJnaEsxQmxvS0ZSL3p6Tkg4NFUwZmJLOGdYSi9EQ0pZRVhI?=
 =?utf-8?B?RjJhcUJFeXpkV2NOR1NzdW1NQnJ4RmUwYUtjZ1YxbUFKblZuQ3JoWGVybHJu?=
 =?utf-8?B?QUtuZlJLVWlGK0J2aVhCNk5qSGpSd0lZc2FXT09wWCtnKzBKK1dLbWh2ZUlC?=
 =?utf-8?B?QUYyWmdXbklpTmozOWlQZU90Q2ZIcGdiTDR0WjkwazJRWjQ3K3oyMWl1K25z?=
 =?utf-8?B?ZGVWa2t5ZnVmUjkrM2tHV2hPQ3AvY1ErdXZkWXAvck9kUnAxblYza3N6UjMw?=
 =?utf-8?B?dkFQQ21MVXZGY0tvVzdENDZ0SHRVWjQ3WW9zdlQ2YUU1bExxTG5rZmR6OCs4?=
 =?utf-8?B?NzhNYlNTUm02bFhmeStyQm9JYkRGdDl6bXc0NWRnK0ZKb1RFZVdhdUlvWEY1?=
 =?utf-8?B?OGw1ZmNuQmEyMEVEdHBkRnVDNW9TMWNzZDhaQUZGUXBRNWJQMnEyN3p5ZTRI?=
 =?utf-8?B?VjFaME5QOW5PdEhZR1hTYmxPUTVpSk15NG1DVGVzQTBLTzVibE9pc0djZUV4?=
 =?utf-8?B?RitUM1VPdW5MdmRzWGtDQnlSZTAyZDF3VkRKYklJU0RDWHVxRW9CTHlhQy9z?=
 =?utf-8?B?OVdQYStBTGhUemZpOCszZmpXMkVHNS9OTitnRU1HRkFwNk9RcE1KTmZiZDcz?=
 =?utf-8?B?OC9kMDlvbUF6YVprc1N6Q1pTQ2I4UUhBNVVqT29zcFRKWUp1VC9ma1Y5S1Yr?=
 =?utf-8?B?ZjdjQ1pvc1U5ZFpGMHdvS2M2STB3LzNOaDQ3bU45NFVtRndnQ0h3TjZnNUxB?=
 =?utf-8?B?Y3pmc3VKNTJWMkt5V3hYVWl2bkhvNjA1OWZBeWsxQUJBOVJYa0ZXZnpkcDJQ?=
 =?utf-8?B?Vkh1S1FqeXJybXNKT0J6emVPSXlMMllPeCs3azA1bXhXTlZ1OVRLSXVvazdU?=
 =?utf-8?B?Z1BqaEUvSGlSY2ErckpUZnllYXBLU3J2U2ZEcWk2NXBMNnRJYWRDM1BEVmJD?=
 =?utf-8?B?eVlKd1dLcnZXa0NEUCtXN3VGU0JmVE0wZWVwS0crRkNsQjZaT2pDcm1KSFJp?=
 =?utf-8?B?ZGRGK0tONGVGWmdrMGg3aTRGeEpoS2YwbHZDMkZkMFJRYUhiNTlPcXowQlhL?=
 =?utf-8?B?WEVvODgxZ3dLUXlsSmRjaW8wbGlqVXVqdWNTYXBucE41TWxHNDllZ2hIVVV1?=
 =?utf-8?B?MFlrNTBwUW5nK1RMV3pXeDg2SzZpbGV4Rk1BeEhRSWdicXRjRWpuUkRyRmdi?=
 =?utf-8?Q?ON4MBFbPFp2oxgWE2/a7HSe4U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df11c19-1fe0-4088-2338-08dd7cdcf751
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:51:04.3154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W5rKED0Du9Gd4nszQ3m6d+OpzTbFnEVBBEI3ESdI6mHFx3oOi8b8yBAuw8yjiqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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



On 4/9/25 18:25, Padmarao Begari wrote:
> Line 171 in README is describing that before relocation no code
> should use global variable because global variables are placed
> to BSS section which is initialized to 0 after relocation.
> 
> In the case of ZynqMP, where DTB reselection is enabled, the EEPROM
> is read again after relocation. This prevents the issue from being
> observed. However, in Versal Gen 2, where DTB reselection is also
> enabled, the EEPROM is not read after relocation because it is not
> yet wired in board_init(). This leads to a situation where the code
> accesses an incorrect memory location, because none is really
> checking the board_info is valid or not. To fix, move the board_info
> into the data section and also check whether it is valid or not.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   board/xilinx/common/board.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index deea6c71103..8ffe7429901 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -80,7 +80,7 @@ struct xilinx_board_description {
>   };
>   
>   static int highest_id = -1;
> -static struct xilinx_board_description *board_info;
> +static struct xilinx_board_description *board_info __section(".data");
>   
>   #define XILINX_I2C_DETECTION_BITS	sizeof(struct fru_common_hdr)
>   
> @@ -468,6 +468,9 @@ int board_late_init_xilinx(void)
>   	ret |= env_set_addr("bootm_size", (void *)bootm_size);
>   
>   	for (id = 0; id <= highest_id; id++) {
> +		if (!board_info)
> +			break;
> +
>   		desc = &board_info[id];
>   		if (desc && desc->header == EEPROM_HEADER_MAGIC) {
>   			if (desc->manufacturer[0])

Applied.
M
