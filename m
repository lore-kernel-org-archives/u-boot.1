Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02568C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0308787DED;
	Wed, 13 Mar 2024 07:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Phl3edXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F1B87653; Wed, 13 Mar 2024 07:42:28 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FB387DF1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlnxXrvCX8dhmPUig2XWkR2QUNEHacY0XHiB69sF1vKopmphXHJiD0Yu0qh91X3ZBJ+ft6D3OhaGhQVX28aDqZnqDIdSZuqu+5hzCFlceQkxLDuGnB0WeYGlmeJSLSk2lLZembfAW40Y3yPwHyIk3pOGhRa01dK78FWTYdAlHypfmBS59yom+Fer1pujJiMOv7QetC2xGPzuRXg+3SAAWCaQS8PE4PLLECqCdxxXpTh/ABy9m1Laz3Ejvl9cxLV4AOZG8zi5u1+/fzc3oFlZMH1TV1TskqLgkn1J9GMzWQ/pcRCHzuTDTcMFnhFU94tI7I68qCkvMjl1qQMwFJ8oRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mV7vc8CbF0G9cWI2zJZ3ZUal5dms8Hv4p1KBnE5SQ0=;
 b=Nc3X6JtyBUPRauE9cVaG09HHUJAeqbjaT8elmhdl4EqNj+kzJvuxxgvOUhmoMKZrCA0Xg+J+WG+KdyOkAx+D7hQIs1DeZkqkhoGRiK348w4s6ud0RwYOschhOr3FfCpA4yKF1XlFM0xsVxfc42Msf4k9rDViN4ET9MFVFONBRSwOY0W2sf/Xo6Edj738Ls31WF1cZduc9FGNNSK1+ggduha1z+E4q2symZDY9MWltn+umdMvqZLScqg454Kh5RO9EF+wjrRbr7jwSakBndT5w3knw6upBWLC1bmw0QTNdHEVFog7QeUdAFavJex3Nx7inq+0XBTD9vTar09hJrfFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mV7vc8CbF0G9cWI2zJZ3ZUal5dms8Hv4p1KBnE5SQ0=;
 b=Phl3edXW4daI2cUu4/e8vxWEmD7XjtWlj3HsRYWdsy0jf667E2QuF+uz3SjCESH/qoMdMXVxfXPFHiU0k5iSNsnlNKtAhdwY2dltLKvjBvauJDM70LRvJR+EnQeEuq5+2TbomgV2CsgPgIHW+rzsmLjHQNVVHnGg3l7ag9llngo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 06:42:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 06:42:23 +0000
Message-ID: <8bcf60a7-ba03-4dfe-926e-f1a77ba4c306@amd.com>
Date: Wed, 13 Mar 2024 07:42:15 +0100
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWj+ZmoTWP9jfwupX4cXrf_36YLW+MiTwj0Wyu2e=dLOwRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0056.eurprd09.prod.outlook.com
 (2603:10a6:802:1::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 664dc486-7e70-4ec3-bed6-08dc4328bd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl2RckqzWaE/VvhE09aEniElVJz7eg19irkioRiFfwuDN0h+Cfc+egEoWAka8f+BKEVk2oLvL3k+7DFN8VTbCFY+Re8tEViHNScU9m9pBS/crJickuwSW2l3+wSrIO0106wYHblRDRvyD/T2mv9HWm7Tqw1+NFXv1l9uKqMFngBglIQ6tYV/P2n39brptrXC7okHIQy8FrK1cke6q4wyPUJG5GIvqYIa/M2LX8njgLTpfH3YBOcHwdqzHvzZoW/1yMyYu28z8UvMESl+90djVMwP3MHWftErR/WcIIiYTioWPVZs7ACuL/EyFXDHGz1/Gvv91dKcR3Y4cZ9ORM/OIBcaBXQUFkPN9Vrwl2AFIZMsRbVmJLX6wzLQJ2T/pFK0q/H2K/7mI8Kcpxd0N4ZOqJNwkNUFq1nmLFhIDnv9kiKmE5LT0Rw0+/rAav69yNBjYwaxvQOARsqKfqPCqL65/tBJ1WTeIqLy1ULDzL6rrg4gYnCiDUc7UDC4dmYs73EQE/QwbnwOpXg4AOHPCY6KP32tcx1YBAW6Xr5LHn37ltzFrUYecLhWiWPhpdIU+jrHUh891KzXv49/XoLCs+IG4pgnaJPHyaHVmFxes0x3/BFr6bhp5XpMHaL1rBB0bOfYQJcY9IVllqmiTP3rPYLqhFpfL08dN1P7rvqoGL4PC7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNOVkZiY0JWdHd6clVVQnc2cEcrS2FjUmRPMVFrdHBhMHI3MndHck5zTzV5?=
 =?utf-8?B?QUsramlWNWhlTlNBZTVLekFZeUdsQzRmV3Z3TUJrZDRtUnZ3WktpWlU0bWlT?=
 =?utf-8?B?SlE0alRabWVWckttU1RtT3BXSmd5elhYWTRmR2cwajR5SVhMRjR4d3BVQWpO?=
 =?utf-8?B?djVPd1ExUTJiZkhNQ01ZN1FGZktCZ3lkeEphdEh3VE5FYkxGUzJ4TjVqRUtR?=
 =?utf-8?B?d1ZoNFNUSURrL09zS2ZJVFlQZnFpYUFRMk5qWDhLN0F3RkJ0dkd0UlIxcTZI?=
 =?utf-8?B?WG1MSnIrUCs0OHdhR0ZrMzdEZ29SSGlwOUNubFV2cG9CdlZVMkRDdzY4OEFI?=
 =?utf-8?B?dENCN3NocDZkMU9XY3FuT2UwOUkzb3NVWDJHRXlxb2F0cmVvWEtSU2RBNENE?=
 =?utf-8?B?OThiL2dOanVpbkpYSVpiNGdBTFpBcWVRai9veC9MMktuYU13a0lxRk05VHFJ?=
 =?utf-8?B?aks3QVlzNUJrZmJUL2JCK2QwWG5qd2tUcllUeDhXeWZZUUZkempvYVduWEpW?=
 =?utf-8?B?YTR0SlpXbXVFcGdjL0czZThCN3Exc0N2Y0RQbzhOM0x5d1JFNTBScjEvYXFv?=
 =?utf-8?B?MmZWK1N2MHp6ZndYMDNpOFJXSmlnY2srVjhoU05RbmJ6TzM0cGZFOVFPb1pD?=
 =?utf-8?B?ekd4UUhhOE5jUWowT241R09ra0VJbzdId0pDdUxraCsyZ2RGczJibXBYaUhW?=
 =?utf-8?B?bVdFcVhZUnNKbGNlM252NVMrNXJRRG9iSHRRZjA2NUQzcStSWkdOSUZUZjdw?=
 =?utf-8?B?ZytWRnByZXRpU1VQK3VOOGJRK0JDdVZTM1RVZ2pvSTdPb2RqSlErbDRabGtk?=
 =?utf-8?B?NlBuQnk5WURsZ01sY0RKamlBRzR1bEJEbURZL3FscE1uUU8xZEFMdVFwUXB3?=
 =?utf-8?B?K2NhQmhVcldEQkRuV1RPN0huMllpM0U5a0kyVnBJOGtpbmxHQ2ZxZW5LOHdm?=
 =?utf-8?B?ZXVTdzRqNGZKbDlrTlJETnQ3SXRYZ1RzeUJIZDhtV2pRRHlSRlJQdjE3VFc3?=
 =?utf-8?B?a1BabE56aXVGMTBVRXhjdlpGT3RkMHdlNVBjVEF1aEFIV3BhamdHZ0phOGRG?=
 =?utf-8?B?YzVUeFU2ZzNxMDlUMVI1UzZ3em5RWHA4WUVHNVZCd2xCZy9WM2l0NmptQ2U2?=
 =?utf-8?B?TFNzZFFoQUUvMVE1TnFKWTVHWjljazZ5T0grNWtOY25xcUh4bVhBMzRQOFBx?=
 =?utf-8?B?bFd4eGo3cFlYaytidWZoZmNscE9pWVltcDA1RXJ5ZUZjMU9FaFVCazFmWlV0?=
 =?utf-8?B?VUlLTUJJVk5DNGR0c3VLZHRqVyt2RmpZVmNVQ3RpQ0FuOC9RckNIUTZlOTly?=
 =?utf-8?B?YUVraW5sVzdLNDFVQUlPdWZnTDdQdVM0NEJuOTNmRVhPQktZeDUzY0RZSFpE?=
 =?utf-8?B?dEtnTldjODZ1Q0NIeS8zM2F3M3phNTF6NVljQXFpYnY3Yk14aFU0Nk44WVdD?=
 =?utf-8?B?UXdoSTREM1diRnVtT3MwQWY4WVB2TXlmdHRmaUNOWTlHYkhnZ29vRUtnMTlv?=
 =?utf-8?B?eFE3b1VFSklpei9pT1dpZnExVDlTenNSZ2xNU2srZFhCRWFFMXA3eHFKYThX?=
 =?utf-8?B?NTN1b21uVXNzSmx5QkpzV3M3NzBzYVR6dC9MMnVOd0JZNFhWemhYM0k2SHVt?=
 =?utf-8?B?eUdhb3REZFo4SGNyZDlqTHZpd0lCTzQyWDNzQjYwV2ZaOHFzZGJiTURndDJR?=
 =?utf-8?B?MHhvL0FELzFkSHRpS1h3VHdURmg4eUF6aDRTdHkrc1BjS2Jxb3BtWVk1SzdX?=
 =?utf-8?B?TjJRN1krdGNJT0xLTFU3eEZ0UU5uWE5BaFNtMHNtZnNHRHdJYkJvQXhIdDJx?=
 =?utf-8?B?eXkvbnA3QVZSYW5KZ1Q0R29CUnBnUU0zVlU1WWtMVFVmN1ozeXFWVnoyUVYw?=
 =?utf-8?B?K01UbWZhdFM1VzhOSXFIc2lORHFoUm5rblEwWlNPa2RXc2o0OVY1ZVJCK0Nj?=
 =?utf-8?B?MDNZUkhuMU5WQllLV0JKbWxiN1UrRmltUzROaCtKVmcxQ0dBWXVNU1QzZlNp?=
 =?utf-8?B?Y01NSnRVdkt1dDMvdWVoWTd5b1VUODByMllqcGhIOUljMFdrZDlqZGFjeDVY?=
 =?utf-8?B?Ulp0M05DdXFKQk1lYk9IM2pQMnlSUysxdC93VVNTMVoxRndqaUtKMVJJelJx?=
 =?utf-8?Q?aFPvR9TGqroKrPD4pGJmvWb7C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664dc486-7e70-4ec3-bed6-08dc4328bd0a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 06:42:23.1634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pmLKMyj7TJIWo3/6zFpptWrngJLbJxNLuVevrt3wbdXKTAlGe/tyhYadXAzODxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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



On 3/12/24 20:12, Ilias Apalodimas wrote:
> On Tue, 12 Mar 2024 at 17:55, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 3/12/24 07:14, Ilias Apalodimas wrote:
>>> Hi Michal
>>>
>>> Apologies for the late reply
>>>
>>> On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/5/24 16:47, Ilias Apalodimas wrote:
>>>>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
>>>>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
>>>>>> much this is cover all systems which are using only boot.bin which contains
>>>>>> all images inside.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>>     board/xilinx/common/board.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>>>>> index 9641ed307b75..4f38b7d27684 100644
>>>>>> --- a/board/xilinx/common/board.c
>>>>>> +++ b/board/xilinx/common/board.c
>>>>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>>>>>>                .image_index = 1,
>>>>>>        },
>>>>>>     #endif
>>>>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
>>>>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
>>>>>
>>>>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
>>>>
>>>> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
>>>> that string is not empty. If name is "" it will return yes and second image is
>>>> doing to be defined.
>>>>
>>>> But I found handling in the code like this.
>>>>
>>>>     36 #ifdef CONFIG_DEFAULT_FDT_FILE
>>>>     37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
>>>>
>>>> which can be used in my second patch not to describe second image in
>>>> set_dfu_alt_info() if string is empty.
>>>
>>> Yes, I think that's ok. The problem is that if we merge this as-is, we
>>> would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
>>> bit misleading
>>
>> As Heinrich said not just this if you want to do it like this.
>> I think you will simply disable the whole SPL which will disable this symbol too.
>> But from my perspective SPL payload name is driving this option. Data can end up
>> on partition or in raw mode but for dfu you need to use the name.
> 
> Yes, but isn't SPL selected by the Kconfig automatically? I can't seem
> to be able to disable it for the kria platforms

Not in upstream but via your/AMD build in meta-ts.

Thanks,
Michal

