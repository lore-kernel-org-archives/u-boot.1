Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B2AC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B417188126;
	Fri, 31 May 2024 17:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0FNmh2/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B688888720; Fri, 31 May 2024 17:28:26 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CA28803A
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7HKjxj084JOxWYWQDW0iMz0QWoNGONHXUcklcsFfK4717eDnS8Es8uQJsIBmlH8sas05eFmsCz0zMvBO44SWEJteZqZF1SB1CIM/blIZtUmFkc5i+e9ttOWDH2pMRYS8g+KLNoTgKZQVCySEXrd0vQzFSsD5mR4XsP65G+o+i3m3l9qdYRC3ogfXxXki3IFAHGxGumok17PK52dtXveOaSeMsjrzRnU4Q/JAgny6AyK9dtL/BlR9THafBXNW1LMUeSWuAd95DDDDOFaNTMHm1MUzKzbCuWQ1ahliRGWv2pD2uU96hSFe1w2wK20nY4Xgv2p5QmhhFz0R5l3l73bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c77WXd+2AYjd74kQ1EOkUFprqtXwrTmsvzVugRUplZs=;
 b=f4MSGTS9oQkPumP7CsSHc0mh2VdD62Olz5EmeV3lc5E5PeFOtijocyHTqn0x7VujQbbOrULjkCgizaXHq6lHYblmhvq1/0EG0u/sU0d1Teu2xd+VCZsrHuUZmExGABpVMFEogTZqzcs4IkvKHpi3SfwC0PhQaacQdjMxpFOuGmIrdGeJ5m+HVesJkXjDu2l2cTszCb6O1OR/KxKw6r5YpvvX3v6SrlG02ZfS4Z9UZNZaMOrMD4VA8I+dAhmrTrsxLOukcip4HpMgCRO+eYagRb83JY7uwLvdCOuADYgOXOloLcT02ZT4Dn1bkAmLMgEKM4oFCfUFsYs44FsPURLx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c77WXd+2AYjd74kQ1EOkUFprqtXwrTmsvzVugRUplZs=;
 b=0FNmh2/FzI9n8jeWKIfntGu1tA4lxBu+hfSBqTCk3Hz51aKXwIPbFeCpHUJxUb4zjE3xswECIK43EtixPNt3oAQurEzikqU+bQ1rdgSm0p6lxZmJDadwlvNXQ9A7l6hknR4EsbLPp/ZhVoHWt0+grfZWlkb6b6P13hOIoggiCDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 31 May
 2024 15:28:21 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 15:28:21 +0000
Message-ID: <f28ff2f5-4dae-4d1f-b5d7-b9290341459a@amd.com>
Date: Fri, 31 May 2024 10:28:18 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] arm64: zynqmp: Update rproc node
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
 <abadef65-e76d-4954-af91-952da6785608@amd.com>
 <14b6cbc7-9f1d-4105-8df9-605b657c286e@amd.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <14b6cbc7-9f1d-4105-8df9-605b657c286e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cc5235-557c-41b3-63c1-08dc81864df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjVnWHBjRWhaMWU4blgxYk9WQ3V3YmZBS3JxTEpYbDZBOUlHNjVZWCtReklq?=
 =?utf-8?B?a0NRa1dBanRYL2U1SDlzd3ZqWWJwQ3lxWStiOE8zcWdkNklJeDlSRldJTmFL?=
 =?utf-8?B?VzJTTlpYMjd3ZlAvTXJ0N3pPY2JMYmVmMjF4K1pnWFQ1b3U1T2RiNFlVdHZr?=
 =?utf-8?B?MnczSTF6OVpnV3YwcytEUGdoenFkU2M2dWo0VGZkUE5zV2tWQTVZOSs2U0dH?=
 =?utf-8?B?dHQ2NmRFMk5iQjd0K0k4MnVRZ0FPRnJIdkRHbFI0Mk15aHltUVJUZTd2dlRD?=
 =?utf-8?B?UjZsOW5sdURjMlE5UTFrUlVWc2FlNW40c05QNW5ENGxUTjZiZ2dNaElBeHlR?=
 =?utf-8?B?VDY5dG4vZWhtMnA2UmVHRGw1NU8yRmt6a0VaTVRtWDBQRC95VkNVNXdVMzNt?=
 =?utf-8?B?RHMrYnRlMmtneTNvRUY3blpFbnd4RTlxVWE4TldtWFpSM2VNWWFKbmN6QlpY?=
 =?utf-8?B?djA3WGpOVTR6bDY1elV3azNjRjA1VlJxWDEvNmxQVmQ2N3JkNW5EWk14ZWs0?=
 =?utf-8?B?ZGg3cG1JMWwzRURvTjdpT2MxMThieTZQR3NwZTJUKzBBankyNlIvekxyMy9Q?=
 =?utf-8?B?cEhydTh3OExvVEpLYWFTUjlmdU5YcDJoMjdhOTVKSkN2ditsZzJkRml5UVNR?=
 =?utf-8?B?RTQ5ZW4zZWNkQmk0UkZBQ2VDcGVwazkzNDBtc3dYa2FKaHF3RVZxNXhRMEhz?=
 =?utf-8?B?V2NJTitFVURaR0pVQ3VqSlJPSkM1RUNrc3h1RUpMRzdnc053YytkOWhMM2tS?=
 =?utf-8?B?Vm9telhXMHJZS1dRZDlOZk1WMC9nZmQzZm9lQWYzQlZCZkw5L1NPQlFsMmQv?=
 =?utf-8?B?ajNQbm9FNlk4aTNoNUpQdDFVTGxUWHBFNEFzbjJPcDlMY3NnUGlMMmljMjEw?=
 =?utf-8?B?V3NOYWlOWHN1WDJJUmkwRWUzdEpvMklSSVJYRU5hclJUM1dMc3JGVHd5YlV4?=
 =?utf-8?B?SWFSM1NHSmtDZk1oVGJtWC9hZzllRWhNSTJOcHl2N3hjekZhNVhFRS8wZWtk?=
 =?utf-8?B?VTB4VlhtMTdkVUZ4dFVOQkpMeXFGczl0ZjFHKytIU3lwOERsb0ZqM2RRb3o1?=
 =?utf-8?B?NWZSOFJISDJIWDJKMnlsNDROU3hucHNTbnZIeTB5ejFJOEJsd2laeUJhUmtw?=
 =?utf-8?B?T3d1QnFqWlE5UE9JNmFjLzV6OGVqQTFacUZYY1E1UmgzMzhBd1BOY215UmxS?=
 =?utf-8?B?eG5DTmFOakczc0FGeW5UbjQzdTBWZXBFdEkzVW5UYWowVXBYdVlDNGYvZUxB?=
 =?utf-8?B?YjhZTS9PZGxFTHFJYXhpSHNFbE9oS3d4VjZUR0h0UmpnZjM2NUptUUZ6bkwy?=
 =?utf-8?B?Q3l0TERWSFkxRUU3UFR2SzhlRnJqVURPTS9HdUJqT0I2QzlkV0lWcHdWcWEx?=
 =?utf-8?B?dkg1TXNSdVA2VmVjT1I2aGlSR01Za3RuY2NpeDdHcWtIcFNVZ0gyTWpHVXVG?=
 =?utf-8?B?bm83NGwvMHVvQnFhcE1hZ1lhNGJjY2JENlo2VkRwT1FVSlFxSERGZ2tHeElR?=
 =?utf-8?B?RVo0NXd4WlBxWFh0M2MvZGlzcVVSUkFMKzVkRWNRblJXQ21WZ1ptZktVNDdt?=
 =?utf-8?B?dU1VZ3krTHNKM3hjdHNveEpiNDZ5QzVYcTcxV0VtWExWVC9CM0VDaDNuVkxU?=
 =?utf-8?B?djZrQ2hxR3lvVGR4UDd5STZYZUNSMzI3cERsSFFMbGh5cjdWMkNVQUJvSVF4?=
 =?utf-8?B?cWxSdzlMbTIrVmpBSzk5UE84a0FERUlMbFpUenY4TjZNL3BWbi9LL0l3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5874.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRJVGR3WHNBR1padEFNK0hIN3VUYW1nY3h4SHdBMDNSQUNhc09uWUg5YVda?=
 =?utf-8?B?a281WEhtdVF0OXJUdFNJTTRhWWFqYzkyZ3d5VmdnakFvWE4wcStjanJMaDJm?=
 =?utf-8?B?NVB5VEgyV3M2RmZDM0FQTE9oV3dMQUQyWUR0VDhCVGtlbTd5VnpJTEJXelV3?=
 =?utf-8?B?SU5kSDdsM3daY0tMMFYrMkszSEpHczZ5VXFYSXdPV1dnZ1JYMHV6cXYzcHQ3?=
 =?utf-8?B?V2pLMkRJNXMzZFR1S2RodlVqTEQ2Sko4eTlUOHVHUjVYZ2RqajZrTGNyR2M1?=
 =?utf-8?B?TmpNZlVJZURELzhseVZtdmNzWXFCOElPVFg4TWNXSVdXanJ4dUIzNEhPVUdC?=
 =?utf-8?B?V0NRdXN4YStSOXR0dVRDbzdIczVkMDg2QmY0cFpFWUsyRWl5YlZkNVNzQ3lX?=
 =?utf-8?B?KzVEU05qV05Xenozd0FkRjE0YklnUGExN3Q3bERaRXZDYUZPeUpZNUc2U01r?=
 =?utf-8?B?bitpcm5ZRklYd2lWejM0ZHBJc1hpTEE3MEh0SmU2MDNmYnZJOW1pVHRWME5a?=
 =?utf-8?B?cXJmOVlxRVRnc3lOa2VNTDBuY0tLSzlhWHhoWHc3RWlnZkEvK1IzSDczdFQy?=
 =?utf-8?B?T1RYV1VOMGRzS0t6cjFDYW9sbGJxVUh6M201cyttNnRBNWRFb3JiYXF3bEZY?=
 =?utf-8?B?aU1ZMDZibTlOeTREMDhldHkrR0xra1BEWWQ2dnBRQkZCUDNrU05OS2VmRXg1?=
 =?utf-8?B?NktqU2ZHVTBWVzRFaW13U2k5RjhCTmg3Q2p2Q0kwamxZT1lyNWlra0xWV0Jn?=
 =?utf-8?B?RTZiWVdUODd0U3hTaUpwQjBZSldHdTdMeGJ5ZkozakFMSVNXb2lvNWwwWS9M?=
 =?utf-8?B?ZXhDV1pRYVMxLzE5MkJXTG02MHdsUFo5TEpaZTB4eEhReEdKVzVlWU92WEtK?=
 =?utf-8?B?MlQ1RWQxNzJwaFVqamNuYm1DMXFNNEdWRks4RjR5MGpMUDJLMkZlS2pwbnFE?=
 =?utf-8?B?WmUyemJjWGVxVnpidEsyTW9XalhaT1EvaTl6V21YU0RsSFR2MkllYjFKdzlo?=
 =?utf-8?B?a2IwRkRLYkw2ODlwR2JSYkxqQk12elJieUphR0Z5bm9nOFdVUUttajBVd1Jw?=
 =?utf-8?B?aGFiNkxobXZqcXNWWmpwcVgrV0NIRml3OUVac2dieVBZMWc3VG84SkJVNlZX?=
 =?utf-8?B?N2FjYTh5UzRCZTFHREpUb3BTZEluTnFTeHBlbHJHZnRoWDRLY0JXY0FESS9Y?=
 =?utf-8?B?NndhSjRNZXE1RnczUmE0cGNBaTlEZTc2MFd4REc0eG1sM3l5VzVHMjFkZ0kz?=
 =?utf-8?B?MmxNUXBKNmFhcE5kZ3ViMVEyRzdqd3ExSWg2WjNqdDFJaVFqRjFlZnN1c1NX?=
 =?utf-8?B?eXl1M2pkUWtpdWNNY0VldWFMSmhPdTBUYytxM3lMZ2Mzb2pKc0xtWDkxeDQr?=
 =?utf-8?B?YzFNbkp6SWFyZ3lpZ3ZMdVN2UjJES2dMUFptb3NYdUFwZnE5eGE2NlBwajF2?=
 =?utf-8?B?WjRvaDRrMVMrWWEyTEtLZWt3MUtyWXF4RWdyMW0wckxmOFJKS3dEWDZKdCt6?=
 =?utf-8?B?WmNQZXlhN1MyRmN4UnpFR2lCcHV5STFtekM3cTlPV1hCd0RIZ1d3ZzFiVitP?=
 =?utf-8?B?TzZSbURkalFvTUdJOXpuRzRPSjdSTXVqbHQzUDhtaGl5Wk9VcXkwc0hHMEcz?=
 =?utf-8?B?aVdQc3BEOVd5d0pmWHJVbHVjQmJ3VTAyZ3JTcHJuamlGbldIYTZ3UEI1U2g1?=
 =?utf-8?B?RmRvbm01aW92Z1UwbkJNVmFkYkpqZ0hYelhqUmlnK05jUjVxMXk5ZlNseWdr?=
 =?utf-8?B?MnY5T0pkYWt2RWJMVEhlWVdvYkdtYTNsYU5ETTBKTGlPTHMwNHBIcUhuVzc3?=
 =?utf-8?B?SjkwaFhIWDYrN1Q5T3prRFlMOXRRcnk3V2xLUFVFdFNxbUJlN3M2akpzY05C?=
 =?utf-8?B?QXdqTmN6ZGpLWHR2VDFjU3NUSHRHdThQRU9Rb1c5akdqazNtclltZ0g5UWtE?=
 =?utf-8?B?R1ZoSU9VRkJQK1dVNFA3Wm5MUWZFbXZmbE1GVXYra1NqL1JuUThXVG5VNjNu?=
 =?utf-8?B?aWFXMlRwWnJzT0ZDaUFvUnFFdjBYenFRZEx1S0NRam5CY3FQVmRpTnlMR05P?=
 =?utf-8?B?cmNISWFWSGJpV3g0VU04a084VFhKejlabExTdUo2dy9HSHdYNVY5RmxFL2NS?=
 =?utf-8?Q?Y42IHrKjKrTGBPnVfDc2C0YKt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cc5235-557c-41b3-63c1-08dc81864df0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:28:21.4322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHWpkgwPZ7IJ8uFxF4IONARzJhB86St00EuCkerN0q5Xn5kBzdnlWctQWzSHVYoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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


Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>

On 5/31/24 1:06 AM, Michal Simek wrote:
> 
> 
> On 5/31/24 00:16, Tanmay Shah wrote:
>> 
>> 
>> On 5/30/24 5:39 AM, Michal Simek wrote:
>>> remoteproc node should be updated to be aligned with the latest dt-schema.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> Once we push all dts to Linux we can change to OF_UPSTREAM but till that
>>> time we need to keep DTSes in sync.
>>> ---
>>>   arch/arm/dts/zynqmp.dtsi                      | 67 +++++++++++++++++--
>>>   include/dt-bindings/power/xlnx-zynqmp-power.h | 17 ++---
>>>   2 files changed, 68 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
>>> index 53a606c340a4..34f592c1a85f 100644
>>> --- a/arch/arm/dts/zynqmp.dtsi
>>> +++ b/arch/arm/dts/zynqmp.dtsi
>>> @@ -314,19 +314,76 @@
>>>   		ranges;
>>>   	};
>>>   
>>> -	remoteproc {
>>> +	rproc_lockstep: remoteproc@ffe00000 {
>>>   		compatible = "xlnx,zynqmp-r5fss";
>>>   		xlnx,cluster-mode = <1>;
>>> +		xlnx,tcm-mode = <1>;
>>>   
>>> -		r5f-0 {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +
>>> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
>>> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
>>> +			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
>>> +			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
>>> +
>>> +		r5f@0 {
>>> +			compatible = "xlnx,zynqmp-r5f";
>>> +			reg = <0x0 0x0 0x0 0x10000>,
>>> +			      <0x0 0x20000 0x0 0x10000>,
>>> +			      <0x0 0x10000 0x0 0x10000>,
>>> +			      <0x0 0x30000 0x0 0x10000>;
>>> +			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
>>> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
>>> +					<&zynqmp_firmware PD_R5_0_ATCM>,
>>> +					<&zynqmp_firmware PD_R5_0_BTCM>,
>>> +					<&zynqmp_firmware PD_R5_1_ATCM>,
>>> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>>> +			memory-region = <&rproc_0_fw_image>;
>>> +		};
>>> +
>>> +		r5f@1 {
>>> +			compatible = "xlnx,zynqmp-r5f";
>>> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
>>> +			reg-names = "atcm0", "btcm0";
>>> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
>>> +					<&zynqmp_firmware PD_R5_1_ATCM>,
>>> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>>> +			memory-region = <&rproc_1_fw_image>;
>>> +		};
>>> +	};
>>> +
>>> +	rproc_split: remoteproc-split@ffe00000 {
>>> +		status = "disabled";
>>> +		compatible = "xlnx,zynqmp-r5fss";
>>> +		xlnx,cluster-mode = <0>;
>>> +		xlnx,tcm-mode = <0>;
>>> +
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +
>>> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
>>> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
>>> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
>>> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
>>> +
>>> +		r5f@0 {
>>>   			compatible = "xlnx,zynqmp-r5f";
>>> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
>>> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
>>> +			reg-names = "atcm0", "btcm0";
>>> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
>>> +					<&zynqmp_firmware PD_R5_0_ATCM>,
>>> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>>>   			memory-region = <&rproc_0_fw_image>;
>>>   		};
>>>   
>>> -		r5f-1 {
>>> +		r5f@1 {
>>>   			compatible = "xlnx,zynqmp-r5f";
>>> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
>>> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
>>> +			reg-names = "atcm0", "btcm0";
>>> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
>>> +					<&zynqmp_firmware PD_R5_1_ATCM>,
>>> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>>>   			memory-region = <&rproc_1_fw_image>;
>>>   		};
>>>   	};
>>> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
>>> index e7eb0960480a..618024cbb20d 100644
>>> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
>>> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
>>> @@ -6,16 +6,12 @@
>>>   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>>>   #define _DT_BINDINGS_ZYNQMP_POWER_H
>>>   
>>> -#define		PD_RPU_0	6
>>> -#define		PD_RPU_1	7
>>> -#define		PD_OCM_BANK_0	11
>>> -#define		PD_OCM_BANK_1	12
>>> -#define		PD_OCM_BANK_2	13
>>> -#define		PD_OCM_BANK_3	14
>>> -#define		PD_TCM_BANK_0	15
>>> -#define		PD_TCM_BANK_1	16
>>> -#define		PD_TCM_BANK_2	17
>>> -#define		PD_TCM_BANK_3	18
>>> +#define		PD_RPU_0	7
>>> +#define		PD_RPU_1	8
>>> +#define		PD_R5_0_ATCM	15
>>> +#define		PD_R5_0_BTCM	16
>>> +#define		PD_R5_1_ATCM	17
>>> +#define		PD_R5_1_BTCM	18
>>>   #define		PD_USB_0	22
>>>   #define		PD_USB_1	23
>>>   #define		PD_TTC_0	24
>>> @@ -45,6 +41,5 @@
>>>   #define		PD_CAN_1	48
>>>   #define		PD_GPU		58
>>>   #define		PD_PCIE		59
>>> -#define		PD_PL		69
>> 
>> This last change looks unrelated. Other than that looks good to me.
> 
> You are using new PD_R5_1_ATCM, etc that's why also this part is needed.
> 
> That removing PD_PL is unrelated. I can split it but not sure if it is worth of 
> separate patch but can be done for sure.
> 

Yeah I meant removing PD_PL. I am okay to include in this patch as well.

> Thanks,
> Michal
> 

