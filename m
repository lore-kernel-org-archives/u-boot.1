Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38E4C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 08:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692F187F43;
	Thu, 14 Mar 2024 09:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0fUFwQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C2787F4F; Thu, 14 Mar 2024 09:43:18 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D0187EA8
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 09:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQusrGuXcWoRJtJeGQ9cAS0Mgyy4v/XFazq+1ey18y4h6R7IjK9wj1v8NlRJqAwys/ejR0XK7hYiY2qlF8Mmu381MqxXMQ2SRNNBxrMidqkgl/Tv2AAyU8l/bxG1yqLZU/A+wUOvj9bYu2UCiE6MhPVLVu71NpLrTsUn0f35pMZH4bSpduL4vHWr5IPiWbuxwZyTxlXSuho7Mhszd7D8pjI4niov+BBRSk85xAFszt+UhoOX87wT0z+9XLsst60n6Lp2dg9VF0/qcNt9p0kKDRhWbS58/WYLXHnn/eGeR//YKyaulZv8unNy3rxArM7R/MSvR3z5h9Rx3HOCPQAYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhbuu9C5+hw7jjmZa1NZtEkBOnWk/h0Y35zLYl2H+8Q=;
 b=PaHWaYaGauzkw9r70WkgfCDdp0asgkTcrn1Jdwo5Z1fvraYPjAM8FIZuCPII3ZKpk69A8390vQL1BoDj1ordO7+JydQaLBy7uD+GljlbeshVWaAE6W2cowkolenvFQ6KvVB5MZpfp0TI7IwrUtFNFj8y4mbuKOTf2vdUzN1et4eZ+agR9w38N5xZbGPB1IPjYlIX9YYhKOP2oA8bo4/9Xooyejt5isLyRhI4KIzoReOTmwDLMembavpbYtiAz3cYxGMzHYLaAbagnKZOZng6yfSs0eL3gkCvi5O+3uBHFXxlhmn98dH03eLymnkmiu6rGxUbjLv4Rid/2tcPCVJSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhbuu9C5+hw7jjmZa1NZtEkBOnWk/h0Y35zLYl2H+8Q=;
 b=l0fUFwQPGcqInh83MVam9T9Nkp5o1vL8yq9VyF4m9qJG/s301cM1HD+bN/dokJuJCuAJxAKurLO2WwXEQ0+qWOVXohZwSurmnuA87hJESklxLYkxAcabBxyYmMhcdGcGE0BXtX6aekbZrvAGPiN1gqQLQJ5RdBDmnlirTj8N44U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 08:43:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 08:43:10 +0000
Message-ID: <88a86a2d-edb8-4181-967d-40f93bf6c950@amd.com>
Date: Thu, 14 Mar 2024 09:42:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera> <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
 <CAC_iWjL4buJzzbJrhu7s8py+EOjqrDY+wq4egkzZSUwj=mmNjQ@mail.gmail.com>
 <60fcfb84-0c25-4b81-bed1-281c1a404ba6@amd.com>
 <CAC_iWj+ZmoTWP9jfwupX4cXrf_36YLW+MiTwj0Wyu2e=dLOwRQ@mail.gmail.com>
 <8bcf60a7-ba03-4dfe-926e-f1a77ba4c306@amd.com>
 <CAC_iWjKahx0uJ35J-LcY=hzPnOK2cEzevTRwi0mpAFAgYvnDkA@mail.gmail.com>
 <CAC_iWjKB1qL732uDocmpQx6trb899=4=Ljk4avXMSWzwuZbSaQ@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjKB1qL732uDocmpQx6trb899=4=Ljk4avXMSWzwuZbSaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:802:2::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1cb190-112e-408b-5ef7-08dc4402c6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OObp3DHECpfoEVv3WWWhGftR4HuC26f0jXkeCKn+GCvRePTvRfNHvQLswclXy9BZ8exqgd6ooiIckl7insNJcCF91/3Ef7qUHtxE2kHP+OhKt/aGpMNo4sSnP4KY4uuGbq/i4YqsdSp6nacXOTt3IinJh9mXiJmhhhs4N8WFZXDsJHh3HzVx+WOm+VQhJdsoJqfJrifM7Ja4lhRfTgHDF+9hsf2omFj55vbPrg54nTKTzmhkE/6J77acxjfrzcVojJG/KeCzCp3MIqYjRtZK8gp5eGsHq5/fZmWa1z0NoDn1WUKdoyWWivbLJpYCzwy0fIctFtM98zlk1YU8/H4uG0R8IXdSf95efsLFgkY7tOf/UV2NNicEO1FVhwTqKFri4QqMkecCXICBUbf7uh19lbwericumVdG4Mu2fSSjKMqL8XkEoMDEf2Q15Tsz1YMA49iCWHPi8XrQKUkEtO7skxUCxaQloS3tC2J52xdyxZHcYCSkpdyrlUUClQh/veZLaKChMx0B8f8aHYUsldzPylZPpuec12s6LJRFskIiq6stINIFrNrP5Rkbdami7yy0J0BOtJhaVsOYNNKu2NbyxZYjKa0/aJUO753pSe1N5gWWM/jyaXfF9GJuGqLMbc3sPDTtoVNhAzv08i1KLWszR3Jk1X0eIZh/0qcZfVvvGPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WER4TlBORnh2RFZENUM2dG1uaEt0amxUY2hXKzZkZzJPa2ZnRk1iYUV1OVVo?=
 =?utf-8?B?ZE1IenBHdGlXTFJLcGZQZnh1M3VteHdVVWNmeDFMVHliTHV4QThlTHlOU2R1?=
 =?utf-8?B?SUNGVEl2VlVvOVNQZTFacVFjdHFpbVNjMm1hWnNjSGVQcVhjRkd0cEVDYUlZ?=
 =?utf-8?B?MTFLcVlHUUp4TTZtMDNJQXZaVGo4dlRRVy90MTdNRWVEa2JNMnZyRHErTzBD?=
 =?utf-8?B?Q0kydmE5d1R4QnhzQ21aTm53T09qYzI0TVhkT2F3RWhhUTQwditnSUwvS3dm?=
 =?utf-8?B?c1owQjdBTXR6eGxaUEE2K2RNYkJja0FFTU52SDI3TDhnZU5ObDdMeTBrMjR2?=
 =?utf-8?B?OU0xVmNPM0JKeUJIRkp0emZtcW1WUnNaNkRySktlN0FGMG52UjNOd3FaOXB5?=
 =?utf-8?B?MUVwcEl6VFVRS3JFcVNYUU5DcGVSamwwbzFvUEJGRFppTytIaVFvV1N6YVZI?=
 =?utf-8?B?b0Ivd2k3dEJybG16K1k4T0oySU5IakhQL3JCT1UyMjBpT04zYmZiSkhiRWhk?=
 =?utf-8?B?TXRXSHhXQmtDc0JOd2tZdnVteTcwT3FOSWdtaWV6SkdNeHY3YVFaU2NIYjZR?=
 =?utf-8?B?bHArVUFWc09qMUpHSXZLVzU0dm9jRzltRG5yakV3VGJqM2RaQzZMQkV6eHRm?=
 =?utf-8?B?UGxKSzVLb096S3E2dCtvODZFZk1wZ3l1WnI5ZytpcW01cWJhNEtmZU93TGE3?=
 =?utf-8?B?bFVyV1loUzc2YWVCbTNwa2RvbUpMYVl5QXYvMHRYVTFHWjd1WG5DemcxNG96?=
 =?utf-8?B?dFk0WFRaZlk0YmlHVzh0L1VUWUdQek5oNVM0RnMyNVM1VDlyZEdaSDhYTmVn?=
 =?utf-8?B?RU5DSFM4Yi9BSCs3SlEvaDdxNnJBVUxmTm1OdHozeWNjY1hrMjhkd0dVVDJP?=
 =?utf-8?B?V1lNZGZMd3ZjZGhlZlVGSEs1eEhMZlUwMmc2U0t1TVh4ZytydlRheWVkZU91?=
 =?utf-8?B?aUZLbUZpVldKTTBQK0piRUtKYWFJdmEwTWRkdnZhei8vdEZsNS9VTGpZUVRC?=
 =?utf-8?B?ZjRWQ2tsbFdjK1ZWdmJMVXJHUzFheXdDR2NCU09udjd1Z0U2V1Q5ZHhsK2NM?=
 =?utf-8?B?TlR3TnB1VzQwTGJKMnh0TGswU0pFQUN5WmxCQ1VPcXpTUjZkQWZ6ZFBSOHRj?=
 =?utf-8?B?ZUVzRElTSnpzaFBGR3RuVHl3UVJ1bWdqSGlWaVZ5WWFpSDMwd3ZlMEVNa05h?=
 =?utf-8?B?Mk82Vm5hM2wrR01hZU5VdGtQSisrUVNxWGgvWEx4Mi9MOE1zSGc0RGRycDNl?=
 =?utf-8?B?WGF3MDRBUm43aGNhNjJsUlBUZ2UwY2did0pVbGNjdjZlNWVpcVlBV0pMQ1o3?=
 =?utf-8?B?ejdOS0FWMG8rVEc3KzVpL2ZocUZXdk1ZTERDQ2VMQ3dlNW81Y0JBV2F6VGpC?=
 =?utf-8?B?dHlLUXZVbjh6TktoWWZMWHh0dTE3TVNiRk4vdWxRc1pVbmgzZysyTlhCSld3?=
 =?utf-8?B?OHNrcktkVjFjMGo2Wk1pMXFkM3VrQzFTcmhCNW1VMHd1alhhMmhrd1VUNTV6?=
 =?utf-8?B?K2tnNVJkazBGTDVGMk50ZVVKWUt2VUN1SUU5a0IvTTJmejNqN3Vhd0xZbzdj?=
 =?utf-8?B?aklhQnZOS0o0WThTRU1pMklyWFVNb3h4ck9ZczBxRXJYaWJYTGhZcTJCRUxC?=
 =?utf-8?B?WTBndkxweldMaHpIa2FJdHVEaDBxOFNSWlE4RElYVWdMR0xYT1kwVGVXelUr?=
 =?utf-8?B?TmxmV1JwTjFyam9pMlpWR0Rma1dWc1NQM0w5TEV6TTZTUmJnRlZpNnI0TndK?=
 =?utf-8?B?MW1oVm92VG9PbG1XeFRGeWVzck1CZVhrSW9WZWdSWCttNzZ0M0cxcmM0SlhH?=
 =?utf-8?B?Mnh6d0lsdzFoY1lrSzdOZUtzZ2pBdENZenpyY1JyaVNQcklqYTlldWRsTnFY?=
 =?utf-8?B?b0JKQ3c5RUFmV1BCc2tUd3Q3Rkc4SmZRQnBLU2pXS2FTdkhGYW5tZnptSGxR?=
 =?utf-8?B?dlJSenM3dnFlRWVTdlBISVpoU3haa3JaeW1mZTlyRHg0bGdtSEloWWdRclNx?=
 =?utf-8?B?alZBUkRwTlBidk5SVWNEU0hwb2REWUlmM3ZyUU1GL1pYeG9FM0V0NXhVWU5p?=
 =?utf-8?B?OXpKdFpuTzIxN3c4WUpYMFFxYjJybFBNUHNXeVhOR3FDKzRPZFVQOGVLRjIy?=
 =?utf-8?Q?88E+5zCf9VMpKSvcOW/EEf7ue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1cb190-112e-408b-5ef7-08dc4402c6ed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 08:43:10.0332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IGngnKQrByerVkMYw0Np3vKXpXMC9F7AzVJlx5P1NTQs6xx7uA4g54EQfDJ2ZZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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

Hi,

On 3/14/24 09:34, Ilias Apalodimas wrote:
> Hi Michal
> 
> On Wed, 13 Mar 2024 at 09:01, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> On Wed, 13 Mar 2024 at 08:42, Michal Simek <michal.simek@amd.com> wrote:
>>>
>>>
>>>
>>> On 3/12/24 20:12, Ilias Apalodimas wrote:
>>>> On Tue, 12 Mar 2024 at 17:55, Michal Simek <michal.simek@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 3/12/24 07:14, Ilias Apalodimas wrote:
>>>>>> Hi Michal
>>>>>>
>>>>>> Apologies for the late reply
>>>>>>
>>>>>> On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 3/5/24 16:47, Ilias Apalodimas wrote:
>>>>>>>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
>>>>>>>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
>>>>>>>>> much this is cover all systems which are using only boot.bin which contains
>>>>>>>>> all images inside.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>>      board/xilinx/common/board.c | 2 +-
>>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>>>>>>>> index 9641ed307b75..4f38b7d27684 100644
>>>>>>>>> --- a/board/xilinx/common/board.c
>>>>>>>>> +++ b/board/xilinx/common/board.c
>>>>>>>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>>>>>>>>>                 .image_index = 1,
>>>>>>>>>         },
>>>>>>>>>      #endif
>>>>>>>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
>>>>>>>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
>>>>>>>>
>>>>>>>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
>>>>>>>
>>>>>>> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
>>>>>>> that string is not empty. If name is "" it will return yes and second image is
>>>>>>> doing to be defined.
>>>>>>>
>>>>>>> But I found handling in the code like this.
>>>>>>>
>>>>>>>      36 #ifdef CONFIG_DEFAULT_FDT_FILE
>>>>>>>      37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
>>>>>>>
>>>>>>> which can be used in my second patch not to describe second image in
>>>>>>> set_dfu_alt_info() if string is empty.
>>>>>>
>>>>>> Yes, I think that's ok. The problem is that if we merge this as-is, we
>>>>>> would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
>>>>>> bit misleading
>>>>>
>>>>> As Heinrich said not just this if you want to do it like this.
>>>>> I think you will simply disable the whole SPL which will disable this symbol too.
>>>>> But from my perspective SPL payload name is driving this option. Data can end up
>>>>> on partition or in raw mode but for dfu you need to use the name.
>>>>
>>>> Yes, but isn't SPL selected by the Kconfig automatically? I can't seem
>>>> to be able to disable it for the kria platforms
>>>
>>> Not in upstream but via your/AMD build in meta-ts.
>>>
>>> Thanks,
>>> Michal
>>>
>>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Trying to compile xilinx_zynqmp_kria_defconfig with CONFIG_SPL unset
> blows up with
> 
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>    HOSTCC  scripts/dtc/dtc-parser.tab.o
>    COPY    u-boot.its
> cp: missing destination file operand after 'u-boot.its'
> Try 'cp --help' for more information.
> make: *** [Makefile:1405: u-boot.its] Error 1
> make: *** Waiting for unfinished jobs....
>    HOSTLD  scripts/dtc/dtc

That's because u-boot.itb is selected in .config as target binary.
Because that entry is string, setup by default when SPL is enabled via 
defconfig. Then when you disable SPL via defconfig default setting is not 
changed and is still at origin value.
CONFIG_BUILD_TARGET="u-boot.itb"

If you do sed -i '/CONFIG_SPL/d' configs/xilinx_zynqmp_kria_defconfig
you will get that CONFIG_BUILD_TARGET=""
which is correct value without SPL.

Thanks,
Michal

