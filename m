Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F4C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0878A87D55;
	Tue, 12 Mar 2024 16:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0YuZzYdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7110487C86; Tue, 12 Mar 2024 16:55:10 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B244387C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiT/qe9o6dfDjt27Z7DcuGaqrkCR5xObGbGKaGv0k0ETKgT+TOpa8CZusKXHj7W8iL8TvQJrcUkgJnEewQEwgocHOipvvbuyWQ23gRdmjiAensKhoJVf6gIMLOapbQwv7r2cd7nS/z+ozHjT/9WTbYyU19B1UJOspf666x6HShD2E/AWFGIcvpQGCNcuSQyAD7fzh8aoJptiasc5Kx0Y3ioDzPZv+vPsN8xUHlymlPl+sVzA0yFU8d+ocGd5tb7w/uxITQM7HAdT1UOuUq3pMyVYLh9iGHLmhSv4HdeA+KLQCPiZFsBhu/Xjuj0EeC11bUNOVwXgaMZxuA/vBuRAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fwgSZc8/0ituRtE62TiKIXPFcxPsy3S9bK5MKUgwRk=;
 b=dCfV3JD2uaDjBC6F2I8OugzXYSDJLalGN+QUiMyEAqA+CDYxgw0xmQJEZBQa+cCCXULQ5+dtgQ5XeGJVPCkbBwyDOJMZ29A9tiH059tb7gnIreu/CTppJWkgep46qY5AcfDflIyLzmRb+CT5Kg+qmZQ6XTdA+f1u6ugJfnOu6rypvGNFYsuAX4YohvrBuDeEcbG/jFIwUVyqg7OAvI2YESUoZKDBCUp9NdTxD2PvzOHaZMn8ttjxm1EP5aPJkWY23OHoGESuHOmIqPDmjgIT39ptCODQLHPT9cSZdQwVvUdI62PTcbsSn/aLArzRZKn21da9s4a1UFP/AvWKfePX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fwgSZc8/0ituRtE62TiKIXPFcxPsy3S9bK5MKUgwRk=;
 b=0YuZzYdvQq7ovlINYCowcb0d5gyzkyYGtwqOkFwni/qf6Isge3rhP9O8U0NTLoP/oqimZX57JTI5JI3pO5vswQ/MX4ICoLMQTEDKbCeS46X8sxEXEJlLBb3UQ213ZJGtUsEkUCO8FueRw+XKn2L4Pkb1/GvqGDOpaz15eDU1xo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:55:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:55:04 +0000
Message-ID: <60fcfb84-0c25-4b81-bed1-281c1a404ba6@amd.com>
Date: Tue, 12 Mar 2024 16:54:49 +0100
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjL4buJzzbJrhu7s8py+EOjqrDY+wq4egkzZSUwj=mmNjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0054.eurprd03.prod.outlook.com
 (2603:10a6:803:118::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: a6967e4b-98e5-4b6d-b805-08dc42acc815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfXHMV0w90bl+Bv09jef07w2+3kPYbdaF8ih7VAYQYrZUQWVPo/Os5HdE6VkoIg1U0Zdw0+5gavLsjhhDb+MCYcmnKZkErfmT2sSjRhhMuPqJpsHJKCkxe6hAmtW4oAP+2knds3LdCs9tItxQbbD4gxsBTZ8UrY16E9VOEdalQsMD3rqV9DMyxrflON7eo2HpXstmbIOxzSzwnzRlbX6meoIvn3ivdngkD8utPLJskaPxRCpBGw/j46UAoJoZFYgb5QwgdzB8ungRYBKep8KCnZJH/Gu8//GzC4+W7PkSp97Klt+AIE1ajk7PgvI3MEGalYJR076r2quvw2toNOre4lJiZKTknKi/gvcSKJr9vbgkC98gdgg0yB8lde+rudDx1kLo8yra3jgfR5tS4ZZoqXMo4qWi/hJIHypPnV6qPZ0a+bIIzFEpafuF7xkmk0TBZ34hzUFu9TSlT2uDCLOa4Vyjh4y8Rd0QNWQxtRvzJWzhCpBfG9HpvsBzgRg8saYM2hLpEUGv+xE9Mrel/u9vXuEMc1VMI+5pJhy4LH2f5P7iFHvHzqtVG3kSz922Xkzr0ma6PYaFBLNbbyQSJhh6G1jV/7bHKJ82mhWKJ8BNJugLXObAnQFHnjZZGIWOQ3VJthvjHQ6NrAFebPzG8FBBuTTAMHefJ880RQo2AY8O8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhsbWl4eGh4RDdyQ0dhcHFnTmxCOGw1cGlLRWk0U1dkQitwekExdlFDUkNX?=
 =?utf-8?B?QUl0TWhiRlcrdUFCMzZZNmpGVWl0ZnZlTVEzc2g0NkJQUWtoNm5rK05xdjUy?=
 =?utf-8?B?bkhhTStFYWZBQjcxbEdnOVluMzNMc1MwZ3hTdnYweFRRNWRLVDQwYjlIZFZK?=
 =?utf-8?B?SmRkUTlQUDBkSUdZZGsrYU1zclVRclR5Uzlha2srY29MbnRDTFBpZmpERUhk?=
 =?utf-8?B?aGFKRlBrN2VKQStjZHkwZFpsRmRObU9tcHRnUEE2aE5CRW5wZlVQdWF6U0d2?=
 =?utf-8?B?VjhyYkI0K3pVNVNUVWZ4c1VNSGVpZHZnLzdzdGE2T0VWRUFKM04wa1RGRkhO?=
 =?utf-8?B?NXYzUG5VT1pONU9JRC8yV0U1L1VXOEp3YVI2OGdHWHEyUDQ3Z1BoUHoydUIv?=
 =?utf-8?B?TVZzT3pCcm03ZFljUXp3eDZ5c2ZWNklxOEsvV25weWFBdkZMU3VFWU9sL05J?=
 =?utf-8?B?aDhmbldRajR0RDFEN1VjNXA1bDRtZVJYZC9pNm4xcEZvZzFQTHJIcks1ZFVt?=
 =?utf-8?B?dDhtOFFYMldROCtFRjNMcm0zbndFa0pQblZjQlRJSWRXM1JzS2VEazc0aDRM?=
 =?utf-8?B?WkZheVZPaXBWNnhFSFFsTU0zQVVFN1lQM3QwVkNjYzkxcHcyaVRuTEFtQzc4?=
 =?utf-8?B?WkpJQ21mOWZYRVRvTEs3SUNPa0xmZXVheVhuQVRocnRwZkUxVzVwT3FlaDd1?=
 =?utf-8?B?aktRZHg1eXNDaHh4Q2lOdVYyaVRyczhDNWRxWTAzSTFtbTdQbVNWNXhIT0RW?=
 =?utf-8?B?T0pxdEUzaHBNMC9jclRKWUJucnptVjhIY1JYcmRxMC9NY20yaFZIWGdVbUVw?=
 =?utf-8?B?aUdBc0c0WmQzZnY1VmFDSFpod0ZJUXBzbGcxTTZ4ODZlUGV3ZUlLZURuRXBH?=
 =?utf-8?B?dVlBUnhKVUV6TDlLb0FySFdEVDdOU0lYQk1WekNhUzRaVkh6YTdtWlczRzQx?=
 =?utf-8?B?R1VFTXIrWlYxclEwRFJDTUk5ZEdwbGR1NzRIc0NqRkIwSFhtcjNrenlYbmth?=
 =?utf-8?B?dGVWMmxCWjAxL2drZEY1TmVSaUVCSDF2bU1vbWlld3ZGUVZJbXYxZlZQQ2hs?=
 =?utf-8?B?ajZnampCZmFUemlqWWlrVWphaHdzYkIzeG04aVVscWVzcDd3N1RqSVliUXJU?=
 =?utf-8?B?djhUNU1uOTNxckduSExGdHJhVnBid3ZMQWVLdFgvbUJ6cFlSdlplL0ZwTVpN?=
 =?utf-8?B?cDU4cmJJR1l3QnVLZVd6SWYvMXJtUm1DRTA4Z0wvMXNXb3N2dnBxZEcwUXdF?=
 =?utf-8?B?YWdSbDFqdk4ybC9VSkxMQUxsUXY4VGZlTktoODFCZjB6UHZoTVZFMUxRZzBZ?=
 =?utf-8?B?ak9mTEM2S0FDaHVhOXhhbUxDcWI5KzJ3MzJwN0E5RDlrZk9MVGdDNXdaZHpn?=
 =?utf-8?B?UVh4aXVETXlSK2VZaGZUM3hpYlRjanpMU3BXWUlwRzRvQWRuK3UxUWFYSmRp?=
 =?utf-8?B?VURhZDFleHBmWDFUY1hmTHNGeWg1TzQ3ODFmSzVKdlV5NHIvTFA5UnJ5elFE?=
 =?utf-8?B?UlRHY0hTZHp1Y1Y2cVB4dlhxa2NSWDFpbTllN043RXczNFRzNE12eXB3M3lm?=
 =?utf-8?B?R2FCVXFVbzRyemU4eFMwNmdOT1g4N0ZxOHBWSlcxOEE3ZkpDeVEwQUNFak54?=
 =?utf-8?B?SFlMTGdPVlFlTWlhU201WjlhUkdQTzI3Zm12REZXYStXeVlOV2hpNkN5d08x?=
 =?utf-8?B?VGxmMGdRdWxRUFZSZ3d4cUsybG1PR0pjVENWQ05OeFpXNWFHTUlUR1dzU3l1?=
 =?utf-8?B?UG45aVRaUThBdW5LNGlMRUE0KzNQL2htMyt3V3JDUGV0Q3VlbjhUUFBnYjZw?=
 =?utf-8?B?djlCT3NZMkM1Q0ZGbGVjV1hpTjgvNUNzQTVKTkhjSzZvdDA5VlNGMkQ5c0xr?=
 =?utf-8?B?OEM1NlBiMmhuRzd0eE1OV3BOZ2sxNGlFYzdWZytudEU5ZVB0cnVqUE8zdGwy?=
 =?utf-8?B?d0plMjllSG9pdHVxV3FVRGprc2JDNzMvTEQ1V2VjMGM5N3hON1YxelZKMnRi?=
 =?utf-8?B?VUpYemh1Y2xFVlBPWGp0YWxNMkNxYzI3dnI3Z1c1cG5UYWtwUEMvNnhoS25m?=
 =?utf-8?B?dDJkQzZxRkliaUlVOWpVdmRCd2tlSDJZdDhnQWE4R2FxamlkQmlPd3VFM3ow?=
 =?utf-8?Q?S2rjixjwI6rkZBYpDTs0Jm9br?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6967e4b-98e5-4b6d-b805-08dc42acc815
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:55:04.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWYdoggVYNLMyNmaEbApsTexC2Af64iCMEjlfxobpqrLh1/zU6NZZBSGq5ES9fVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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



On 3/12/24 07:14, Ilias Apalodimas wrote:
> Hi Michal
> 
> Apologies for the late reply
> 
> On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 3/5/24 16:47, Ilias Apalodimas wrote:
>>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
>>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
>>>> much this is cover all systems which are using only boot.bin which contains
>>>> all images inside.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    board/xilinx/common/board.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>>> index 9641ed307b75..4f38b7d27684 100644
>>>> --- a/board/xilinx/common/board.c
>>>> +++ b/board/xilinx/common/board.c
>>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>>>>               .image_index = 1,
>>>>       },
>>>>    #endif
>>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
>>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
>>>
>>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
>>
>> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
>> that string is not empty. If name is "" it will return yes and second image is
>> doing to be defined.
>>
>> But I found handling in the code like this.
>>
>>    36 #ifdef CONFIG_DEFAULT_FDT_FILE
>>    37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
>>
>> which can be used in my second patch not to describe second image in
>> set_dfu_alt_info() if string is empty.
> 
> Yes, I think that's ok. The problem is that if we merge this as-is, we
> would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
> bit misleading

As Heinrich said not just this if you want to do it like this.
I think you will simply disable the whole SPL which will disable this symbol too.
But from my perspective SPL payload name is driving this option. Data can end up 
on partition or in raw mode but for dfu you need to use the name.

Thanks,
Michal


