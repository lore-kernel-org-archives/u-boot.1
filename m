Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71747C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 06:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4729187150;
	Tue, 19 Mar 2024 07:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HjM/EdV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF1387572; Tue, 19 Mar 2024 07:59:37 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E815487E6F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHqO41bbFb6ylt/ELMh/Z3T3N0hqkscbf9m6N+KapextMfBcRtFBzzIhhiF5gapF0DQtNeLXbQphSLglZIwnER0MMrbTbB+k/B6LZLBV99St7JcQwuLPIeD/VTSbroSkWOHiivk+B+gDx5cREVsFNT2fhRWb7gSG/FNGXFPVr8kr01cYy6M/VG+ogMR4akPUjtV9ZcwPT7w5YxMmzMuLh9Ydx2qGJR+/zfdjBIRotEG0JDs65cUTEv9PtJojG/qgtkIHzWA9j9aJp4L7AdWIpycba04quvlz3fYf2i4s72Z4aemGcdUP+R0tlX7mjQZqY+Jw5ckHJru/D/CsLOWO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8znsJF/XkrrrVuql7CaOKh9UEpOpkfGCC2jDJhhnb8=;
 b=Oc32he3xatyY78Eu0Y7IwXGqU4dxPl8fri+rN2u649ORH0IbX6qV4nhhJaxZzWhl//VcOh1uXuf6E1ZzmwmSAUchhrgBGyF94RihKhP2yUY8atck+Idn3CU3X9IJVyfcu6lx+fC2i+7caXTFSOEqTuXxgT3XNsgzEB0kEl1dhULI1pfu6gjBYHJ0po8jgpRa9DyDBvl2t2FXxI4xRlXYxny0aHBrXEN4npgsxpwJYb4oHihdQDjCgELh0rRddqxqQoE1YTqAKCG8Ttji/wjQsH+CXFwv4Rke3sGodsB+7ghGcCmAYpieTqtnuNXJfD9yhBBBDqTfSXauAYuSnLkw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8znsJF/XkrrrVuql7CaOKh9UEpOpkfGCC2jDJhhnb8=;
 b=HjM/EdV//wye5JiWTQhek6ufyHjBb0AHYc4oDGLEsqJccT8xaIAzN4FTQd7tfkJK1wv7GWtRaqCMlbtKb08fh+F92ADU0vWzi8gSWzuAIakcvRNSzpwOphMThyqXjR+fo9ahrc5ruXa8/GqKMnzfCbTzeaHstHjNzGa/Nw20K+s=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 06:59:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 06:59:31 +0000
Message-ID: <726167be-2072-42c6-b2c3-b1801b8e8579@amd.com>
Date: Tue, 19 Mar 2024 07:59:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Stefan Roese <sr@denx.de>,
 "Polak, Leszek" <LPolak@arri.de>
References: <20240315192528.464849-1-james.hilliard1@gmail.com>
 <03cf43b0-e9bc-4174-b9bf-3c380e388203@amd.com>
 <CADvTj4qiTZOf4kDj=v+5p89+-6JPoZRKQ2Vh+0SODS4=mQ=HtA@mail.gmail.com>
 <3699bad9-846e-493a-bbbb-436753ccb300@amd.com>
 <CADvTj4rc0hrJXXtjiV+oZwHYYeU7StvNM6wH+131ECtMz9zwmw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADvTj4rc0hrJXXtjiV+oZwHYYeU7StvNM6wH+131ECtMz9zwmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8083:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXB1l7e3gr2maijgaEgPGxlgtVxVUcuPVZt0/Zmzfjyfjt49vILASqOZ14W2bTkQRyX1agFXumKKEekD9umXNzK84hTtx7xjnR6mQClaZtHiGsiiGCXhhlle8E0NtPrDUKUDswSSTP81BONFOfqmK5/Me3yLOMtS3cf1P9V/+kr/4dPx8HaJCh4iwsSStf7oi7XQXhm+TdIITe0FqkVQCy2kSlifZg2fEAIhCIgJwq899sEqLG5+iJg7a0kEGiehCwUUV9aUhDOwxF5h5m8lrAe4raAnqkPSS8CxE1jUntCQgRP+2ti46p8Zsg5g0inZ5LfTsGreZAq/d3cShN2DTECeXThd2OTL/WzVXxXG+kLAZKLQxgscYGuefjUy6OGW04peeedn+HJiHg/+z39TPq+xQbJPsE75ingBi8fLH610RYo/B+6+amYq78w3MZQ9Xw3tb5KxfOnPO5Soq9KCXwUviq6NKpUh9abkzBZjk11Rzt+xpRnClSLnK4TrLS4GNd/ectnhpjoJEvGW3g2KoqUxjzw0AP2lYNDso41BagR4vNKxBnm52wqD1l/QYAtep/fqKiUTUy05IOPmVx6clJcJITLIdU47HwkVpg015fNXmd5tI8cYC5mLuvRpxyyAxMUh8GqenZG/9q/MxVIYiDnAhonLywuTQUo5gJ5IAKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NOVmlCZ2lVYldjMlV1SW1Cd2crb3lGbFRVK2VRQnBEUU5jQ3oyWStJYWVo?=
 =?utf-8?B?MnNhV0REdXBtTmV1TmVYbCtDQjA4ajZGQ1JrMUVDNHJZZG1mSGE5NFBGQ09N?=
 =?utf-8?B?SURFL3YzamV0eEhlZnhJa0tIRlN6M2JYQ0hHdTJqV0t0dmFiQk4zZUZtWm82?=
 =?utf-8?B?bGZEbWNsMEhkK3FEbkQ2WHRJTFN3UkN2MWsxZ1BtYzRMZENjOGxIUG9GSGpS?=
 =?utf-8?B?a3JuVEozdEFKRFc2OHVOZTU1WXRzYkVZOXZJT2RyWWhHWDhkd1UvOC96UE5M?=
 =?utf-8?B?SURaUmtRcnh6dU5OQURWWS9lWTFRZmxUZUVHKzRUOTFibXY3NXdqNnB0djc4?=
 =?utf-8?B?ZGR4aGpHUEt2bVRoZys1RXVYKzNwVnA5Y1l0V0dUTEhxQm1EN2orL0dDdUVi?=
 =?utf-8?B?OFIwbU5ZYWZJcmpQNTJCYXUvbnpmMVdaQUM3MCtjUStJMGFPL1BUTlVtZUlJ?=
 =?utf-8?B?M1F2MXlBMDBDNlpoUkliVVkxUlFFdGU0QlRtVkRRRmlweHJVU0M1cUQvM2NN?=
 =?utf-8?B?b3NRMWliV0xFZlBPWmljM0dvMGwrWEtxbDJFVFhaNnREM2QrRW1IcC9HM0th?=
 =?utf-8?B?UW1mbVIwWkh1R0ZhMGdnMDY1M25CdVN6MmhxRXV0VDFjcExEOVYzRTFlbVh1?=
 =?utf-8?B?OGltSHZReFRQckN1MUFKbEhrakxBQVNTdEJ0dEdPaDZKa0FINExXWFd4MWlw?=
 =?utf-8?B?WjF3eHY5MVlTdUhONzdMeE1NOW40cHBRalVJNHl2RWMwTDd5WlMwbEllM005?=
 =?utf-8?B?SXNVeENZbU9BT3JWMjVUdkJpR2h4SzdmNVl3azR6NEFBMDJTRENIOVk4c1hs?=
 =?utf-8?B?Ykd0dVFFN0ovTTh2QUxWTE1XdnUzYzNIYVRGNkt6SGR1YUY3UW9lS1U0Qnda?=
 =?utf-8?B?aktaZU43TzVDbFhuT2daQjdZMElZNWJvbUhxeUY4eEE0VU1GNU90RDBiekda?=
 =?utf-8?B?Q2l3eVdnL1EyWlZLa2d1Lzh1N2hvbkZCZWtmUVI5UXk1SFo2UWVnSUU4S1gx?=
 =?utf-8?B?L1NXWHFwdjIzNWV3ckVUZ1RBSWFIRFE1OGJ2UnpkdGVhQmtlZFlrQ09KU0Uw?=
 =?utf-8?B?aHBub3MwMERlM2IrTTFRWTJLc2Y2Z2dIbWxEemNjR0JaN044L1k1c3ZSaGRG?=
 =?utf-8?B?YVgxREoxczZuKzNPYnE5ZnZlaHYyRjdYQjlYR09sdGNtd01vTUN0L3FWbnd3?=
 =?utf-8?B?VHByRjlzWjB4TTlyZm9CdXVEbW9RS0NYM2p3MWFzbVZqMHRtMFU3TmgydkQ5?=
 =?utf-8?B?VEF0d1A2WVBJRjk2UUh1NWRFWkhvSVd6Q0VselZHdlgwVXN3TVlxSUNOV0V6?=
 =?utf-8?B?Z3g2YTNjZElDTHFlTjJDa2hIcDdzcEMzRG9WNThwSWlQc0EyYkxmbjhsdThY?=
 =?utf-8?B?bGJHeHhZQVdSalVtckNVaVlhU1VEWDlIZElNZmNsZjdJNzRZR3FzYmMyM2xm?=
 =?utf-8?B?Z05JR3M5Q1pVd0NUYXVpejI0eXVLN2lkZkFKem5zUU9NdDA1WjRzcEhaeWF3?=
 =?utf-8?B?R2F4R1Q0VlBqSVFDeXlRQlRWbjVwUkpBcldrZ1YxVUhlVUo4R0tOQ2lIblVZ?=
 =?utf-8?B?RU9nVUoycUdRUDlnNWVKTlgxclFOckhjTTljNStXcmZpSTh2NXFpQXlYQW5v?=
 =?utf-8?B?Q3NLSWhoTkNvR0pXOG1uQlRwTk81VkpwQ1FVRkdOaHNUK3FoQjkrLzAxS21W?=
 =?utf-8?B?bXRmc2ZCWUNpbUx3bDVHclhXVWdWcnA3VzE1WWxMaVV1VlNwYnRaeXRZdllm?=
 =?utf-8?B?MlZJbCtNbDhHaTRxM2JhUmF2TkxWMGFTOGVVWHhxMVRzcTZERmd4dHZaK09z?=
 =?utf-8?B?K05TTUd3Z0NkQVZNUTRqdWN5M1MrTi9YMGdXTlEvZnQ2ODBhdzNTb3VadDF1?=
 =?utf-8?B?WWxxdEx2Y05wRnlaTXVjMXZVbFducjhaQ2NNdmhBOURxOWxLcXdVdm9kYUg2?=
 =?utf-8?B?YUc1S2lHMjZoVXBtTWxFaG4weVNDZ1JBeVlyRGdhQjlXMlNaWElYeWhiaHhN?=
 =?utf-8?B?Mno1TWsyWTZHQkdkOEk4ZCsrcTc2REZqMjkxQ0Q3K0R4NUd1dnZHRXZGanhv?=
 =?utf-8?B?VUNJMXgreWpYT1lGc25uaXhkMkJQNmwycTczd0VGaG9GMGlmRFNYTXZyeDZU?=
 =?utf-8?Q?+At1XScAf1C2v55nOIxz6CWuP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4be101-91c7-4521-7cd1-08dc47e22025
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 06:59:30.9811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pumoaxbAmujYhjp16J7a34nxFLMlGZBtEW9+oyv9MMd05KtvwmJpUJWFGa/xBq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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



On 3/18/24 17:17, James Hilliard wrote:
> On Mon, Mar 18, 2024 at 5:07 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 3/18/24 09:48, James Hilliard wrote:
>>> On Mon, Mar 18, 2024 at 2:26 AM Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/15/24 20:25, James Hilliard wrote:
>>>>> There are situations where we may want to let U-Boot modify the FDT
>>>>
>>>> please use imperative mood.
>>>>
>>>>> nand partitions for the kernel, such as when supporting multiple
>>>>> sizes of NAND chips.
>>>>>
>>>>> Lets also refactor xilinx common board support to have a
>>>>> ft_common_board_setup which gets called by the ft_board_setup for each
>>>>> specific board so that we can add non-common functionality to each
>>>>> ft_board_setup like FDT_FIXUP_PARTITIONS as needed.
>>>>>
>>>>> This pattern is modeled after the one used by tdx-common.c.
>>>>>
>>>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>>>> ---
>>>>>     board/xilinx/common/board.c     |  2 +-
>>>>>     board/xilinx/common/board.h     |  2 ++
>>>>>     board/xilinx/mbv/board.c        |  9 +++++++++
>>>>>     board/xilinx/versal-net/board.c |  7 +++++++
>>>>>     board/xilinx/versal/board.c     |  7 +++++++
>>>>>     board/xilinx/zynq/board.c       | 17 +++++++++++++++++
>>>>>     board/xilinx/zynqmp/zynqmp.c    |  7 +++++++
>>>>>     board/xilinx/zynqmp_r5/board.c  |  8 ++++++++
>>>>>     8 files changed, 58 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>>>> index 9641ed307b..629ba2b902 100644
>>>>> --- a/board/xilinx/common/board.c
>>>>> +++ b/board/xilinx/common/board.c
>>>>> @@ -686,7 +686,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>>>>
>>>>>     #ifdef CONFIG_OF_BOARD_SETUP
>>>>>     #define MAX_RAND_SIZE 8
>>>>> -int ft_board_setup(void *blob, struct bd_info *bd)
>>>>> +int ft_common_board_setup(void *blob, struct bd_info *bd)
>>>>>     {
>>>>>         size_t n = MAX_RAND_SIZE;
>>>>>         struct udevice *dev;
>>>>> diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
>>>>> index 64d657673e..73f576952a 100644
>>>>> --- a/board/xilinx/common/board.h
>>>>> +++ b/board/xilinx/common/board.h
>>>>> @@ -18,4 +18,6 @@ bool board_detection(void);
>>>>>     char *soc_name_decode(void);
>>>>>
>>>>>     bool soc_detection(void);
>>>>> +
>>>>> +int ft_common_board_setup(void *blob, struct bd_info *bd);
>>>>>     #endif /* BOARD_XILINX_COMMON_BOARD_H */
>>>>> diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
>>>>> index ccf4395d6a..d8af1eaa90 100644
>>>>> --- a/board/xilinx/mbv/board.c
>>>>> +++ b/board/xilinx/mbv/board.c
>>>>> @@ -5,7 +5,16 @@
>>>>>      * Michal Simek <michal.simek@amd.com>
>>>>>      */
>>>>>
>>>>> +#include "../common/board.h"
>>>>> +
>>>>>     int board_init(void)
>>>>>     {
>>>>>         return 0;
>>>>>     }
>>>>> +
>>>>> +#ifdef CONFIG_OF_BOARD_SETUP
>>>>> +int ft_board_setup(void *blob, struct bd_info *bd)
>>>>> +{
>>>>> +     return ft_common_board_setup(blob, bd);
>>>>> +}
>>>>> +#endif
>>>>
>>>> Any reason not to put directly to board/xilinx/common/board.c?
>>>> All xilinx boards are kept in sync from user perspective that's why generic
>>>> pieces should be added to common location.
>>>
>>> I assumed the device tree node "arm,pl353-nand-r2p1" was specific to boards
>>> using xilinx/zynq/board.c since it seemed only those were the only ones to use
>>> that node. Have any idea if that assumption is accurate?
>>
>> Configuration around xilinx boards are quite generic. Normally nand controller
>> is by default connected on Zynq SOC. But because chips are highly configurable
>> you can connect it also from Microblaze or Risc-V but
>>
>> I think you can simply do changes in common location and put there proper ifs
>> and it should be fine.
>> Also keep in mind that you should avoid using #ifdef as much as possible and use
>> if (IS_ENABLED(...)) instead.
> 
> Is there a way to do that with the static const struct node_info nodes[] part?

Just like this:

int ft_board_setup(void *blob, struct bd_info *bd)
{
	static const struct node_info nodes[] = {
		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
	};

	if (IS_ENABLED(FDT_FIXUP_PARTITIONS) && IS_ENABLED(NAND_ZYNQ))
		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));

	return ft_common_board_setup(blob, bd);
}

M
