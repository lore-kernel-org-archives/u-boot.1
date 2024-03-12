Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72654C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D242287DE3;
	Tue, 12 Mar 2024 16:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q2oywVBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C6887DE3; Tue, 12 Mar 2024 16:25:58 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068928709C
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpJSB3iriXkoB8bUEQvyJJTvkz3HNzUoRG9k+IL2UP4AHvOEwkFARmD3cuKb8DWWLNHej1KXRd4HWcg/p3akyCrjBah2erBRdbOJalv4zAA75osO5l3fHcijm6MAW1dBFnhB/FHn7Udria2x37vhxf9d60yhWNjkjeXoYjUUoX4n2TXwTszZcgFdt9GmiThb6etThD0X95ru9dW1cm0M4kkibYHbaJNC5jGQ2fIcG+aEdrEz3xNSehLKjO8HFeyaKSrDdyZibBfC1A+ync9buwcFzDKKZ5VCijXN95vyRj2VHgQ0JjDtorgPyNGjBEZXxRbiLry/mg/dw+h9vVgRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoGK636meXe4fdQ/x9v7UgFdJv4kpy2wA+keD3Zz7Gg=;
 b=ZR+Xl7WX4XYNpRbLgXpWoZloS4523bMNvX/dYyBvnwr6JbM0jbk3VPvbV3AX/2LV8yZlP9kD+wy2VZau8j+Viu5nQn3u1u97y9KKu1s2Xco/qQ4YwXJgsSrZHwKxe5/CIJ66VyZkw72zQqe+xE0UtNfnb52R6av7imQqmuowF8Laappmq+QbGMz4EX5vBacOoXdEjhOWQwE4IpLkXXMcYU7owahrEwyB81fyJz2ZIbAzSvDVyPY+65vx6ZPkkBKhDnU+8Iz8xrOzNNoDxWL1UKgocGf56djcjrbKQTzXcAMoWhKD8cYtIM1oeOEOTR3JvGnLEioWP8Vb5nnLTmHWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoGK636meXe4fdQ/x9v7UgFdJv4kpy2wA+keD3Zz7Gg=;
 b=q2oywVBYw7rd0dcHQ3iCKlM0dCT/rdSC+CcoUTPODMHgcLgKOZgYZvEx19GG7f/h8ftCF8mmn4UIpJgDc+ZP3Sxdzoq9wZoVHU6meGznFKq06Y6Gzi7Z847i4cm4bIY1CzcE2i/u+rzuINiw0QZqEE+qGWY30eKyUWn7ukinryA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:25:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:25:51 +0000
Message-ID: <f8f8c6f4-87ca-42b1-a561-0de81dbf3ced@amd.com>
Date: Tue, 12 Mar 2024 16:25:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera> <503983a7-89a2-4673-a2f5-1d6396ea63b4@gmx.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <503983a7-89a2-4673-a2f5-1d6396ea63b4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 54982be5-5803-4750-4503-08dc42a8b310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USsajdnn6J9dlfbasqQLbqsPr2TuMvHSAVFZB/0ON+KtbaOg/4WWeXMt3mBi1oRsODpMjjV45uR4bKqATUHDvoVvtCFLiqaxXQCwKI4Is3JM9cQPqnUyf8fURUCdmN9NPStUUyFx8Jf21KxC0BXQy1r7ioOVFQoZWS7osKnTHll+n9OFzeC9GYrtRhxeom0f+zdHl1bPfr8R/5wnHtD7UQKCEifNcvS6IOYppRQu3KbkOzehsCsEIerFDycfItOE2NPSI0NuCf1aHlRfwvt1vOg4V2GYzdXkCT4EzNvktya2qDp93QueBDVudI6T35Hd5hDY4v5wonQYbHzp3JQ33fpnIRTQ42J3RdbysQMLUvSGSYqccIQbtLqLr6Yd1UNlntIYkRCZKA2BkY03FkYkLooqg23Suth6ENKzi7+zNVto3KQgilZ6NnRLcbaxfkhfZNIYg0iAHHAtv0mcAkH6Wq4EtWCm0kXnyFUglRWcG+5SmV6IEcPSx1h+YdzHLzzBWy1Rh63W4CEcmnOwBYrd9L08e7HoMlAA9BcrcIc2gHS1ymYO+WkGQO+awKdUjXYmqOoFLBnKyKsoBlJ597qH+T5cPbMKfMIRl6xbhxvdx5Wm1TrFursXJAlyb52cMFUwBDudgl7egHArdNYpTJXwkavKsw9K6QTSJp7E7OnYwWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVHb0hUWHVxbCtndXduRkRQeVJZcGhnZStOQlVnNk9UWW1rZVJYMDQ2VU9x?=
 =?utf-8?B?NHZkcDlaTzN5RVNQY2dDYzNoRnl2MFZHek1lTjAyblJiWG5KNCthb1JaUWJi?=
 =?utf-8?B?S1RDTW9HaW0wcktQMkVud1EyOXN1S3R6cjVaVGp5NWlkd2MrZktodGh6NlY5?=
 =?utf-8?B?NStRUUZOaXdWYnlGNTFSSlNISHNDeG4yMnY5cjlzRzVscDhyN2JiM3FSdFp0?=
 =?utf-8?B?TlZNN2QwNktCZGJRWHd4QXZFV1hXSWNoanVJRXVvODdJaERsNkVoMkVhOFJH?=
 =?utf-8?B?QVRiRXBsV0U5dXIyUVNCSk5BbWs3SzZGNXZ2MkpDWlVpUWhUVGtsUDE5OExH?=
 =?utf-8?B?dE42dVBpRWQ1NklCNVNram83aUhFSlMxUDFjaU9lK0ZPbkZRSjBOcWhUS2Js?=
 =?utf-8?B?Tk5EMWU4elN1djZOc3VkcUdvLzFveW1oQmhUQkZCMFRrbGJaaUR1c1V1UHdn?=
 =?utf-8?B?eEs3aU9JZzJQWWJuUklLK3RvdDhrSm45bTllWkROVGRPQ0g2SldqZ2xCZ2p5?=
 =?utf-8?B?MFF6bmRWRnZWNFRLUkgyYkVvYTUrL0p5WFpQc2RFeHVwd1cxSzdzMEZwMmNX?=
 =?utf-8?B?QkxvaTFPSCt4OTZOb3RZd2dNU0tkWUQ3VVBONlB2bzZVNDVIdWFHT3FDdlJ6?=
 =?utf-8?B?NTROUUozOExxWmFEL2VuZE5sMnowWVVyYjlodkZSaFF1b29KWGR5ZTdCbzFX?=
 =?utf-8?B?ZVpyeGFFN0FpeXA5MFp3UHh5dDNLbWtLMkpBcmRrVUZJVzR5SDNBWVY3Y20y?=
 =?utf-8?B?M244dWdoZmVjVytsVlVUQmdTdFE3dW9kTXpBZG9LR3JIZmdVL3lrREdjZndl?=
 =?utf-8?B?c2lGQ05UK3RDUTRNdTM2VDB4bXpEODZzdC9Kd3JMMGlmWDVNQk5BYUN5Rzcr?=
 =?utf-8?B?OWRqWE11T0hUUXl6MG1lSlpvUjJyTVZDckRoMWJaMGNlZ3B6TFRaTFQ2ak9S?=
 =?utf-8?B?Y2pWVE9TdEMvc3ZrQ2lGcmRLNEN4L243YzlhSVBJVGpzSXp3L0hKNnltc0sv?=
 =?utf-8?B?cHFoWWZ1NW1WWEVVT0JFYnFOME9xMEs3aEVyN2JlNHhJdGdLVXRsdjFRMkkw?=
 =?utf-8?B?cWtubExjdjhXbVpYaENrb1ZhYjJ6blFTdmxrUkRuY2xpWUo2N1crUmltMDNP?=
 =?utf-8?B?cDNJc3VaakdNTnF6Y09rcE5oL2k5YWQwVGFCS2hQWGttTnZyNE5LRVBITDRt?=
 =?utf-8?B?c3NBcTF5V3ZxcWRvSzZGZVNCQkFXVmZTMEJuVHpwU3c5d1FPMU1kSS9DSFdO?=
 =?utf-8?B?MjhhR2JtMzh2NTNLUVVFTkpHcHNxeFA1dFg2ci8wY1JTbm5POXE2NTB0UFNW?=
 =?utf-8?B?SGJXcVBWcG9NVGlsMy9CSGdKSnZneXFGQkl4UVhhVjE5R1lyR1Z5Zkw0a3cw?=
 =?utf-8?B?YVJsRTlKMmxwL1pUMlkwSTdxSE5vdEMrR3pJK0ZZeEhIcExYd0t4ZU95NUpz?=
 =?utf-8?B?VlVVd1g2bkRRdkRoa25rODd3L3NTWGc2QVBVbVNJbDJRTWQvL2dwRG4zdTdE?=
 =?utf-8?B?bHZWQUlOWnNQOWJaRGZnaHFGUkMzaTR1TlNQeXZrOUZTMlgzd1c3NUwwcEJS?=
 =?utf-8?B?TDViaFQ1VFJ3UmJ1dVJieEs0YnQyQlVjVGxaUjdZSG1pMDZaUHZqUEdXdU5S?=
 =?utf-8?B?RGpFR1cwc21sc3hZMEFEYnJMK1JsQ1RXTzEzQklQYmdkV0psbmVmSm9xd0hJ?=
 =?utf-8?B?RUs4YktrNWoxOGlVYjNNQmdzSkhYaHdqSEV6dDV5Ni9KOGZsODdkMU55Zk44?=
 =?utf-8?B?WnUycFhUVS95cjhNVkg2YXNNMHJ5V0E5LzJ0WTRuOWhNNDZTU3U4SUVQYnFy?=
 =?utf-8?B?VTFOVktEUjA4V1VSZGI5c1FyU0drcnJSdk52WnhSWEQ2Q2ZRU0dpS2d2bHcz?=
 =?utf-8?B?NzVqdlB1WXAxZTN0QmJCeWQvUlVJUFJoU2MvSHZWaG4rVE5aaEJpS3M5U3F3?=
 =?utf-8?B?NzlObGw4YzYvc21mc1UrYWVKOVh3NEZFVkc5eHJSN01zaGlmMjkvakJrcTVY?=
 =?utf-8?B?cUhNSlRpMC9XaURlTmoxK0Q4TDRPTU1tdnJCRDFqc0lvbTQwMXVEWlIwbnRy?=
 =?utf-8?B?dndzSFVPUnU3dnNWZGQyaUd6Skg0RXR5VXhxUVlBbUZBSU9TTDdBYmVBM2Yx?=
 =?utf-8?Q?OEyxFdCJPDv2XfucdIUIyUOZ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54982be5-5803-4750-4503-08dc42a8b310
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:25:50.9793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcobdDXnWGyMy+bMdG01LrNzoiXgc4Xn4OnXBHL3nH4VHENljJWvwd5NE6Vx1jmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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



On 3/12/24 13:29, Heinrich Schuchardt wrote:
> On 05.03.24 16:47, Ilias Apalodimas wrote:
>> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
>>> There is no reason to describe u-boot.itb on system without SPL. Pretty
>>> much this is cover all systems which are using only boot.bin which contains
>>> all images inside.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   board/xilinx/common/board.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>> index 9641ed307b75..4f38b7d27684 100644
>>> --- a/board/xilinx/common/board.c
>>> +++ b/board/xilinx/common/board.c
>>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>>>           .image_index = 1,
>>>       },
>>>   #endif
>>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
>>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && 
>>> defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
>>
>> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
> 
> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME depends on SPL_FS_EXT4 || SPL_FS_FAT ||
> SPL_FS_SQUASHFS || SPL_SEMIHOSTING. So it is only defined if SPL could
> load a file.
> 
> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME defaults to a non-blank name. If a user
> provides an invalid name, SPL will not be able to load the file.
> 
> What is wrong here is to assume that *.itb has to be load as a file. We
> can configure U-Boot SPL to load the itb from a raw partition.
> 
> The check might be too restrictive.

I am not sure I fully follow what you are saying here.
All current dfu rules via set_dfu_alt_info() (board/xilinx/zynqmp/zynqmp.c) are 
using CONFIG_SPL_FS_LOAD_PAYLOAD_NAME for second location description.
Obviously in qspi boot mode it is description for RAW. In sd one it is 
description with using fat.
Description for two guids make only sense in connection to using U-Boot SPL 
only. Because if SPL is not used likely you are going to use standard Xilinx 
solution which is pretty much all in one inside boot.bin which is described 
already.
This patch is just trying to get rid of description for second firmware if non 
SPL bootflow is used because pointer is likely not correct.

Thanks,
Michal


