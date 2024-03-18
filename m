Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B86C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 11:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9723B878E9;
	Mon, 18 Mar 2024 12:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZa+7sub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303A887EDD; Mon, 18 Mar 2024 12:07:17 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3066D878E9
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 12:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/+zZz18Waqy/IdAcYTBiqRWVnl3U1hP6mv2E4HhP04Pjc/A2HCx8qQIZTISTJJzV8csh+1Cz9PCUuY5B1xhDJ3EJpJsASti3++af4bcbW4r4rWNB3/KPjDGZUsjxVGK/3GAdlyzJhJGHLZFf1lFGAI804O5mW5kvSQnkU00IZNZ7wFv66V554dTYjLxaIwQv0Lx6+8TCNu4f9xDpQZp2wt0y4SdZL7ksuJ493jYw9HkBVyQYJgZKWiXgkGmHvMXXt5Nij7nTEWaMIp/CRGWcp0Ro4Hoo557EX7Iv9GJ0ycRBz2EGe1kG6+vHmxDx76HPO7Pp/E1hi5VbT/GTIzHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88b4+DpJ3smJmUa9c1glxCdh9FdHWv5MA9HoRMjGF1I=;
 b=bTrzeWoHNvgjfOdrBafGWSAFAhztW1gS6THYK6Ht0d3AGRYQMII8kZZ5CUJqnFfS7ud2XSgKhHcReqS3estPma5kNQTWhCIcLLNSGTZUBH1buSO8Drj5xHe00aPFPUGKpvQLWlVGWWSRXLEkjmuBgTtuIsIRAM/V6wmEBkpwKwr4kbxQ98AL5D8JiT1N4eGQbdOHEfiUtaSzFqqRXIhqZPjmS2OiTH5nb6iLPZFxQtfoNs0IyoRzGs7rLcybc/Lpk9ydxLdTEP5q3MrahnllXr2FXnGT1hvsGn7VofiuIcd+PyZidoEXUf8WlSrlgKHEVXsSYFAaDAyrQI/Ezvdxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88b4+DpJ3smJmUa9c1glxCdh9FdHWv5MA9HoRMjGF1I=;
 b=OZa+7subTaG/UYYmC2TgNFXRockAVdDlncV8xulquzVctktOEJoGdcBO71+ngoiL7OH/qgFPZRveUK+0O/3dyXNxUjROEOKlG5pDagpultlCY2fSIbCKfttXw2i6tBgBN0SoQsveGOT2vpxHcXdHi66Rj8hw/nLFQG/Mmhq570Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 11:07:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 11:07:10 +0000
Message-ID: <3699bad9-846e-493a-bbbb-436753ccb300@amd.com>
Date: Mon, 18 Mar 2024 12:06:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
Content-Language: en-US
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADvTj4qiTZOf4kDj=v+5p89+-6JPoZRKQ2Vh+0SODS4=mQ=HtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d83e13-3859-4da1-9754-08dc473b8e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucwoqC9ss9ZobbxmYQjkNIs9/QV+JL48A6XvAxXH2wMJyip1EogGORucjskOYveAXRFABAj6PCA+gZavAqWv4OGr2eDDmo+4ZuIudvYpHwS875nDwRNIiXZOLtuFV8KCmFxeNpSjepvEPVrMeL6OG/3tqQ1u4Y8HQhRffEqL61AeJQBBPdG4WIsSd0P/enhSomC8YMtPJKKqc2kFb2qNzVUOFogzgJRU9wLZ49z9AFjoHrSt7STZ6CoUtJfsAxFsghUNDBQZyQ8rSQ6aNlCUlSbkOe3l0MQi0Gx/mvHB657uhgbtMvnDB345X9iZyUjufFv0E5OhsA7a/AiZUKlqm5cDWPm9IUboKopEPWPTPYL3H/H9cPuF7F2uXPLfSUdpF94bJmPtJoSBwK/NQx3YdXM/lgbKI01Dx05LhWAnqn3krYGqf23sTWn168I+iutGCWWfZo6uAP/JRs6PpOq2uY4qtcxMy2AglPREJCqQPTL3iF0AMFtwgxyYrDgGwTGitdBkg+V7Eh6RveA4yQ92vqn15UO4lRjT9LCiWGuuzJZ5jZKrqfEggYQZU7xXYKlntGo8G+h8hFuHNK6W5FFeUOPdOe13bJOFOgOw70w0XP+nTIBLKh+FYMCHTUKzFX0lgyal28+7F2KQbnGvpRhcZxcQ6ZGGRWW7z9R10M6ikgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFNdGI5MzBoL2ZZZGNhSmhwdlh1WjA5UnFDUGFCbnlMdGxSOWUxWUtvWE1Y?=
 =?utf-8?B?Z0dBV3pMS1Y2OG80dVpQb1RZaWNYSjNnWWVJUUk5OW13QXZmang2WldPUjc1?=
 =?utf-8?B?N1NZZC9iWGNFTEM2WjdRMGVPbURRQ2tLWS8xNnpXMFRSRlhQRk1HUEh4dzI5?=
 =?utf-8?B?bFlVT096amt3RzNoTk9TTWdDWkt0U2ZtZFMvZXB5Ti91RFN6bGhuQklWQmxw?=
 =?utf-8?B?ZWdSajdQcXdoNXFMUHVxWmNYMFM5TXZvZlVTWGE2dmxqd2NSUUJLcVhmbVNX?=
 =?utf-8?B?UVR5NVEwL3VvZ085TUdRTDE4NkE2WEZRRlNER1M4MlFBNkRubXBETTI3L2JF?=
 =?utf-8?B?cTh0ODhRdFZYbTNXWWRGeDBKaElLVEdZS1FENVRxQ1dzUzczWUgrd2xlc2gr?=
 =?utf-8?B?S0hzcWg0LzRyNkJPR1NiM09wczkweDZjZjI3eklvU053T2tQc2tCQWFpMjhx?=
 =?utf-8?B?T09wWUtjcndVUDFoSkx5TlNhc3gzUkgyY3dwL0RVWFZSMjlYSzM3S3I4emZZ?=
 =?utf-8?B?SWRwMVZsVUNYZTdhRTRQcFB6enNSUFJxNUdNZnFrN3hTNGdLMUJOZnBUQ1E2?=
 =?utf-8?B?cUN5alVZZkF2QkhUZmpuK0gvVjBSMXNBWXpXNlczSUpLQnpWUjJucHVnZ2Jh?=
 =?utf-8?B?T3RNY3dnM1BHNkh0NTZIRVZRRjV3TVJlaVI2ZmN1d0kza0NYOXRzTnVJUXR2?=
 =?utf-8?B?TnpRQTRMUWVHYzJVbStZZU1jU285VjBISFE2bVRCM2svc0dMMWl1K2FkM2RC?=
 =?utf-8?B?UzNmdTYvZll1U2FSbXFoaURMR1FPTTFyemMxVmI3YStUd05sZldsZ2N2UG43?=
 =?utf-8?B?UlhtbERDT0RMZmJlMWtDT0lwaGoyWWtVNS81dzA1MURWdlVPanV2TlB1WkVL?=
 =?utf-8?B?bHBjNDNuRFVpYnNmaTYwT1VpM0EzSzlnL1lyUU1udldSbFVCWXYwNkJwTzda?=
 =?utf-8?B?V1M5VERRQkVvL2VrcWxIdXJESzFPUzZJUHlDWi9BRURTYVlnVWJrQk5FOWt4?=
 =?utf-8?B?RXA4YVFnd2Z5WWwyazZNRjBYWVhsTFpnYlFQOUhmcUhMVXUxTENuMUNDM05F?=
 =?utf-8?B?OStKeDVTMm5vU3dQZUk5aEpBZXoyZCt0QWVzcEpNNUoxNnVUK3l1dGU3dUxG?=
 =?utf-8?B?S1QwU290TDNqZzR5Y3h3alBKVlZSYXc5L3o3T0hFSlpiejZvRWVoOGpZay9k?=
 =?utf-8?B?dC9ZRkRuOEJHZ1ZRZ3M0UitzbUxPcDdQWDlOS0FkUExNQ2x3ejZndzd4cEFS?=
 =?utf-8?B?QlN2dHYyem9GZWxNakxyZVkzeHZFank0NDkwRk12TnExb1BkU1hXZHRjSVpz?=
 =?utf-8?B?c1UrNDhFRHNFTjg4c2MzV2FtNnBlZDMrMnN4dlNWb05LMmtLL3NxYms3aXNH?=
 =?utf-8?B?R1FteE5HUlFLSUkvaVpNRFpTRXBsRC83TERXTENRY0YvOUtRVE5jcWtvTmQ2?=
 =?utf-8?B?cm9SWVNEclpsdVVGa09kTnh3V0FWOEVKd3hFZlA2MnFQci9GL2lqeS8wOUlp?=
 =?utf-8?B?UUl2cXN5K1JxNGZ4VS9nODVTaGNjM3Q3S2lhSG10bEoxbmg1d00zWlRDRUUy?=
 =?utf-8?B?OU9PL0ZKUnhhSHZ2eWJJNUZLTTJqcWg5NU9tN1Q4QVdDbTN2dVBaY1E4UlBO?=
 =?utf-8?B?K3Ryc1NDcEttZWNxRGE4VEVJUzF4ZExBMmhuOVhrRmV6cG53VXNSZzdDS1d5?=
 =?utf-8?B?K1F5MlJMdGdMRmR1ek40Y1MwaXFtY0U5V21iZFY3TTNkNUU0RDJENFhub0tF?=
 =?utf-8?B?MUF4VGZ2dWN6TmVRNnFoTitVbVlHaGVGWWxvQ3VlaHJ4RzVQR1hpYjV1YzFF?=
 =?utf-8?B?eW40OURYOXdyNVV1YTZTM0lPV0w2bzRsbXY0Rk4rMjl4TU9lWGE4R0xKNW1K?=
 =?utf-8?B?ZHhYQ3NKTG5kYUlmYnhpVU1SSlUxSWQ0clloVVdhL2ZSM1BIb1UzREI4WWt6?=
 =?utf-8?B?RWNWd2l4dDgwZk5ZVVVWWXpyaG94M08vYjh3aCtuYW5nUTFvVHFHMlJuaHBs?=
 =?utf-8?B?YmJGbzJEekpEb0hOdmpzYzVRNmhXRnoyRkZKSmMyVjB0WU4yUkl4Z2UrNzhW?=
 =?utf-8?B?cjJxd0h5NWZvNlhuZXdQZDJUQmtveTFLeGZ1ejJWT0FnMldJaHl5RjBSQVc2?=
 =?utf-8?Q?5u3GZL/5ywtjp0JftV++WgPrF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d83e13-3859-4da1-9754-08dc473b8e6b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:07:10.0184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JTWJ6zz5+1qVErJteZbhXG1LpIhZRf7RqORagdX+KzEH+Fe1VH2mqR/XRmhkuWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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



On 3/18/24 09:48, James Hilliard wrote:
> On Mon, Mar 18, 2024 at 2:26 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 3/15/24 20:25, James Hilliard wrote:
>>> There are situations where we may want to let U-Boot modify the FDT
>>
>> please use imperative mood.
>>
>>> nand partitions for the kernel, such as when supporting multiple
>>> sizes of NAND chips.
>>>
>>> Lets also refactor xilinx common board support to have a
>>> ft_common_board_setup which gets called by the ft_board_setup for each
>>> specific board so that we can add non-common functionality to each
>>> ft_board_setup like FDT_FIXUP_PARTITIONS as needed.
>>>
>>> This pattern is modeled after the one used by tdx-common.c.
>>>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>> ---
>>>    board/xilinx/common/board.c     |  2 +-
>>>    board/xilinx/common/board.h     |  2 ++
>>>    board/xilinx/mbv/board.c        |  9 +++++++++
>>>    board/xilinx/versal-net/board.c |  7 +++++++
>>>    board/xilinx/versal/board.c     |  7 +++++++
>>>    board/xilinx/zynq/board.c       | 17 +++++++++++++++++
>>>    board/xilinx/zynqmp/zynqmp.c    |  7 +++++++
>>>    board/xilinx/zynqmp_r5/board.c  |  8 ++++++++
>>>    8 files changed, 58 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>> index 9641ed307b..629ba2b902 100644
>>> --- a/board/xilinx/common/board.c
>>> +++ b/board/xilinx/common/board.c
>>> @@ -686,7 +686,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>>
>>>    #ifdef CONFIG_OF_BOARD_SETUP
>>>    #define MAX_RAND_SIZE 8
>>> -int ft_board_setup(void *blob, struct bd_info *bd)
>>> +int ft_common_board_setup(void *blob, struct bd_info *bd)
>>>    {
>>>        size_t n = MAX_RAND_SIZE;
>>>        struct udevice *dev;
>>> diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
>>> index 64d657673e..73f576952a 100644
>>> --- a/board/xilinx/common/board.h
>>> +++ b/board/xilinx/common/board.h
>>> @@ -18,4 +18,6 @@ bool board_detection(void);
>>>    char *soc_name_decode(void);
>>>
>>>    bool soc_detection(void);
>>> +
>>> +int ft_common_board_setup(void *blob, struct bd_info *bd);
>>>    #endif /* BOARD_XILINX_COMMON_BOARD_H */
>>> diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
>>> index ccf4395d6a..d8af1eaa90 100644
>>> --- a/board/xilinx/mbv/board.c
>>> +++ b/board/xilinx/mbv/board.c
>>> @@ -5,7 +5,16 @@
>>>     * Michal Simek <michal.simek@amd.com>
>>>     */
>>>
>>> +#include "../common/board.h"
>>> +
>>>    int board_init(void)
>>>    {
>>>        return 0;
>>>    }
>>> +
>>> +#ifdef CONFIG_OF_BOARD_SETUP
>>> +int ft_board_setup(void *blob, struct bd_info *bd)
>>> +{
>>> +     return ft_common_board_setup(blob, bd);
>>> +}
>>> +#endif
>>
>> Any reason not to put directly to board/xilinx/common/board.c?
>> All xilinx boards are kept in sync from user perspective that's why generic
>> pieces should be added to common location.
> 
> I assumed the device tree node "arm,pl353-nand-r2p1" was specific to boards
> using xilinx/zynq/board.c since it seemed only those were the only ones to use
> that node. Have any idea if that assumption is accurate?

Configuration around xilinx boards are quite generic. Normally nand controller 
is by default connected on Zynq SOC. But because chips are highly configurable 
you can connect it also from Microblaze or Risc-V but

I think you can simply do changes in common location and put there proper ifs 
and it should be fine.
Also keep in mind that you should avoid using #ifdef as much as possible and use
if (IS_ENABLED(...)) instead.

M

