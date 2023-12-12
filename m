Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2041DC4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 13:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A27487243;
	Tue, 12 Dec 2023 14:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqiFHEJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A64876CC; Tue, 12 Dec 2023 14:16:10 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4C58718A
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXxZ3r8tOOdYHWBZHP7/vpF7VLHh/uNVzxSmbxAUZV05UiSyfaRHuiAYKVShQn/jqTFhawECg05o5YzQOaJ4TSB66Q8v9yB5qeih46zywCBVVjUIQrsIbY7qYSMkEEtJVEaCputHsOkiHgRCWS17OF+KmRmQcBBBTytVCZqgVXG0BCkHitscIhYbDM/oxZv4miFB30EJl9FX4pLsr4vX9TEAnsy68b6w7+abIM67ApqpOl7MavlMLoHO1jl5hYPhi4Q17ojIV6LWwmU4OHBVXKIaWfnzkTzd4RBc4BYNkGl9SfuTAdV+Um3bipgS7qPpb6DzYc7CdwS3fnz8TP/nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIRlKms32PcQ6rQRshld3F9Z6Ccp833sA9U5gjt/PC8=;
 b=KKctsGmkclseXL4CC6qoDcRA2lBsku3RTl7F/3XymzpUCk/ZY534cV9SiTP48pAWdQ54IJP0ouT70rFrXaFXOMpqJHiBtclOve2gfST3OM09A6hbsM/qIScQMJ9Oy0S25SWBUZURMf/yrKX/FdKvft5xmnZ8jf2wd6wgk8jLr/XN50rPZy8+7uIgwy4Kta6oaJPJBE4it6Es+YkuiOjGemcEeYD4Pbc/EM0gK2tx7ZUxx3zHWhSoAyMmYPcAgTMXj8L5cSFTssl+o0fdFaoo8dH+MqYcFibnhD4v+hrJCt/6YsJuo+wVvljuPfTqdef9AMGcvcXHK9hz+GBGTuRO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIRlKms32PcQ6rQRshld3F9Z6Ccp833sA9U5gjt/PC8=;
 b=sqiFHEJtWxdxTyGzi6aw1c0jISfvYg40Yyh/wfilMYFhymiX8ZSVVMohg3dNANFHHFysFW9oLQsV7RBz5vl7SZCVk7UpnWQAZNZUvPCIgtj1CaKvDLsBOZhBgBwS2FFflyUPixiPeZSsshd0kaZ1CDyiLok0LqY7g2XoK8voq6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.36; Tue, 12 Dec
 2023 13:16:04 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 13:16:04 +0000
Message-ID: <e7b64664-6273-4f6b-a229-0f8616157661@amd.com>
Date: Tue, 12 Dec 2023 14:15:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, sjg@chromium.org, git@amd.com
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
 <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
 <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
 <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
 <20231212123404.GY2513409@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231212123404.GY2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0064.eurprd02.prod.outlook.com
 (2603:10a6:802:14::35) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: abb3ec04-6721-4829-e01c-08dbfb147e13
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8N7XBfp/cXMcp8Us1u1chpMaZLP6HJE9bPK8biBNPhlSA26xtejQN5G0i/XqPYkwmokxAbNvu0YuUU46RwXB4AVrgYRfnr6RwaYHnkOXqXet+R6g6Lrp7gaXunVNNsWBVUpQN6hZowKMrDdcSTy0Q6fR0W6xMn6PTL3QtkEPHbOi0BhDUHYKV1z9VSKRXtRwCp9hjtlsxkN0G0gFcKjMsdwePg5RFDAJ7N4EFZslYFtfIXNSIO6Dpqg3JnpsZYHprqwrM/eDMY2lo6gWyxXdcKnCGNw00m3dbm+jgapAWQdJy+31uB/93wodNpHGPs37p0UVt1nu/HFCfegjirbYyLx0Ny/h4H7WoHH5Hty7cJl6fqDN6mWB7Zcx5OII5UxL/moWv3J8jDgHLR5otEL86gGD/kl51Bcz9hREO58olSRgUQdixEuB8YDIhJRgbkHBdiwSaHBNLOHIfUnMN3Bd7EbpyUJXFO2e8jG+c2n7J1vtKsNpXfzuuOIPjYKbxHnyZx4WLAD1qY+vzps/xY2gtxON7uVfxcMQ9eQY2qZqhLd6KytyNeauekNBKkxtNF9lJSODJakHE4bBEVgfXIJWmFsLxBn0Iu5Z69N38joneywYzbGr094s7Xx+dSbxJApI2wL86VeQJBcsMKBVaUMl9LKC28z7jJ7fgzu8G6fFKx8xQrpizLQQmN1X829SXIH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66476007)(66556008)(66946007)(110136005)(41300700001)(53546011)(6666004)(6512007)(6506007)(2616005)(26005)(36756003)(86362001)(31696002)(38100700002)(83380400001)(966005)(478600001)(6486002)(44832011)(4326008)(8676002)(8936002)(2906002)(31686004)(5660300002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25QQm40bGxOS0JNSHJVOS90ZTQwNlowbFZFY0swei9IR09Zb1hOMzgxSyti?=
 =?utf-8?B?TEZqRmptSEhsSWN5aGw2QUNhbXBsRmVKRHNoaFJJdVZhQ0ZaVW5ZOXd5eE9D?=
 =?utf-8?B?ZTVkbkVCZktqZyt3TU8zZ2EvcDMrcS93Q3lhUGFERlYvdFp6RlltbTNtalJq?=
 =?utf-8?B?NGZrMXppTndldVRnYndOaEo2WjN2N3hqYXYvWmJrWXEyZnNlSVlWUkFtSW5I?=
 =?utf-8?B?Zy84QXhuM0s4Mm42L0doaUN1cU1DUWRLNExLQUE3b1JneWhGcldvWi8xUTFv?=
 =?utf-8?B?WHlBaURBS0M4dURHVThONzVPK3lhUVk4U0l6S0ZkWS96NE9WZFFYcWpPblRP?=
 =?utf-8?B?d25tRWJ6R0pHVG1RU1NmTmVoRXdtR0ZVbXRHbld6aGdYZ3hZczRiT3JaTDdu?=
 =?utf-8?B?MGdDclNVT0plaGF3WjVMU0JudmJSM08zNzFRNFltbE1jMmQ2K3AxYUZSVVN2?=
 =?utf-8?B?THJqbTlGMEtCTjFvcEdwSDFyWkd4THduRlZxSldYcGYvb1UzckxPZHJIOEZC?=
 =?utf-8?B?MVE1dDRrWVVUc214ejlNeklBZkM1dFFhelViZ1VuSzVHV0VSenV6VWFhMVU2?=
 =?utf-8?B?dzRsb2cwQnB5QzNUdllSU2JPNjQ2cU5IWXZ6TEdTZE1SUC9TZWt1MjIvN2xl?=
 =?utf-8?B?UjQxby84RHpvV1cveWpXTExpUS8zK0FOTXprL3FIWkdlVzJYZzlVWlZMUjFu?=
 =?utf-8?B?VE90RnFvcnNka2JNUnFSMVJsbEk2SVpoeGVJQWlQZzV5VkRXRHo3VlZLRm4w?=
 =?utf-8?B?a1JjdjVOelYxbnRteEd4SjMvK3Q3d1hiSWYrMWh3VHZsTGhxRnlmRzdvMGM0?=
 =?utf-8?B?ZHRsWmZlRjExWG1BWmVnMG1MdExYTzJVemlyeVVZQ1pnZmtXTGJudzRmdjZt?=
 =?utf-8?B?RTVpcWppcG1zRWt4NElHMVRGcldVZDFIV1IyU0ZWYjhEdExaTkw1ZUluMzdh?=
 =?utf-8?B?VDdSWjBzRDEzMEpibDBwbXpHV1VRMkM1ZDJhR1ByS3hMd2d2TGtiS2podlR4?=
 =?utf-8?B?akFBNndSMnZ0bWludWlmRWZIenZaSnAyZ0tnN2dZb3Y4RmdOb2krNVBvd3BH?=
 =?utf-8?B?VkFOd0NWb0hQbjVUVi91NmcwQTJ1akxnUHlVQk0zNHV3cEg4QmZUQXNMMmEx?=
 =?utf-8?B?UFRGMmpkM3JraXkvZ3I1TjM4YnArRWllV3FqMFRxV1N6dlhIMWl3azZRaDlx?=
 =?utf-8?B?WGdXQUNsWGViRHhiOFVzRHA0VjhvVmVtQUNVSndhd1VRd0RvTXRqVVlEd1lh?=
 =?utf-8?B?WittbW5YQUhzd3l4bVpWRm4xaTJQbE9QYjI5cFZwUEFBN25lMHJrTXJoUGtG?=
 =?utf-8?B?NzVPNXZQSzJGZUtFS3FBcCtnY3d0aHdja1hXWXBCdU03R1JhQ2RkY1k1V0x3?=
 =?utf-8?B?SjhYd3B6Q25tVnVzaVVIb0h6MU1CVnBNeHNpNi9pQU9oMGVpbXQ5bytRYUlk?=
 =?utf-8?B?dFMzTWdxZkZjYW1HSGhtVWt3anVXSXMxMmViUEhhanF2dHNHMm5GVDRHSlAy?=
 =?utf-8?B?c0RTT1VJQ29teEpseUNvU3JkNE14ZlhNU01uQ3lSWkVITUE3VnMzNXZMalFP?=
 =?utf-8?B?eWE3dS8zM0xxSlcwZm5GdFEyRTA0L244L3llWHI5REJFRnJ6VmpHL3FLY29K?=
 =?utf-8?B?ZlhweVR6TjJBU3VFQUk0cmFoN216U0praTlmdXNZS1Zia2JzNkVBQnVFcVZw?=
 =?utf-8?B?dUt2YkFnTWRZNDRWV2luOFB6TlVNUXFBKzNyQ0FWU0xEd1RCakJuaDdnWlVV?=
 =?utf-8?B?VUcrNVpZMnlJMjk5MjRIS2JIQkVnM3dGdVI4Mlc3R21EOFQzNHYvNUdwL2pK?=
 =?utf-8?B?QldSbU1SQzlIOVJ6aXFadmxhbFFjM2FLSUJWM3Z5N0J6MWJEUlAxdmNIWTQz?=
 =?utf-8?B?azVlMTJyZng5eitFVlVSaXB0UXhFSGhxNGwwR2NjQzcwcWVTcFhhclI0NTZE?=
 =?utf-8?B?UHBIbEhIYUdvNEtWRGpMa0JsK2JGMHBkOFpEN09RMFEvVDNYQzgzcGdGZCtZ?=
 =?utf-8?B?Zk54Q25WYkFrQk1PRWFjM2VZM0JVV3dPdlVjcHRHS3hwT0hKaUpFamx0ZFdD?=
 =?utf-8?B?QVMvMjZWdTYyZU1Zakd0V2NWUkhEbGNmdXhQQ09NZTdTd1lXODJWWEZBaEx0?=
 =?utf-8?Q?AqreJ7bHNWRN3Apcf3TeewwXS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb3ec04-6721-4829-e01c-08dbfb147e13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:16:03.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkmfJt2DQ/ena3R5TNv45YcaUKU02FHYtJtw6z6tSDzYt3bQ1TEZkoEZu7pxlcop
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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



On 12/12/23 13:34, Tom Rini wrote:
> On Wed, Dec 06, 2023 at 06:58:14PM +0530, Jagan Teki wrote:
>> On Wed, Dec 6, 2023 at 6:11 PM Michal Simek <michal.simek@amd.com> wrote:
>>>
>>>
>>>
>>> On 12/6/23 13:24, Jagan Teki wrote:
>>>> On Fri, Aug 18, 2023 at 9:51 AM Ashok Reddy Soma
>>>> <ashok.reddy.soma@amd.com> wrote:
>>>>>
>>>>> This series adds support for Xilinx qspi parallel and stacked memeories.
>>>>>
>>>>> In parallel mode, the current implementation assumes that a maximum of
>>>>> two flashes are connected. The QSPI controller splits the data evenly
>>>>> between both the flashes so, both the flashes that are connected in
>>>>> parallel mode should be identical.
>>>>> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
>>>>> nor->flags.
>>>>>
>>>>> In stacked mode the current implementation assumes that a maximum of two
>>>>> flashes are connected and both the flashes are of same make but can
>>>>> differ in sizes. So, except the sizes all other flash parameters of both
>>>>> the flashes are identical
>>>>>
>>>>> Spi-nor will pass on the appropriate flash select flag to low level
>>>>> driver, and it will select pass all the data to that particular flash.
>>>>>
>>>>> Write operation in parallel mode are performed in page size * 2 chunks as
>>>>> each write operation results in writing both the flashes. For doubling
>>>>> the address space each operation is performed at addr/2 flash offset,
>>>>> where addr is the address specified by the user.
>>>>>
>>>>> Similarly for read and erase operations it will read from both flashes,
>>>>> so size and offset are divided by 2 and send to flash.
>>>>>
>>>>>
>>>>>
>>>>> Ashok Reddy Soma (7):
>>>>>     dm: core: support reading a single indexed u64 value
>>>>>     mtd: spi-nor: Add parallel and stacked memories support
>>>>>     mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>>>>>     mtd: spi-nor: Add parallel and stacked memories support in read_bar
>>>>>       and write_bar
>>>>>     spi: spi-uclass: Read chipselect and restrict capabilities
>>>>>     spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>>>>>     spi: zynq_qspi: Add parallel memories support in QSPI driver
>>>>
>>>> This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
>>>> and let Linux approve the parallel and stacked otherwise it is very
>>>> difficult to maintain.
>>>
>>> Linux thread is here and it is pretty close to be merged.
>>> https://lore.kernel.org/all/20231125092137.2948-1-amit.kumar-mahapatra@amd.com/
>>>
>>> DT binding is already approved but have no clue how big effort is to synchronize
>>> it. When was it synchronized last time?
>>
>> It wasn't. U-Boot spinor has its own and makes changes accordingly. It
>> would be better to sync the Linux. This is what I'm referring to here.
> 
> Is anyone actively working on that? Under the assumption that no one is,
> I really don't want to block all progress in this subsystem until a new
> person steps up to start reworking everything.
> 

Glad to hear it. Actually I have already reported to Venkatesh that there is 
still issue for sandbox reported by CI in v5.
And v5 version is available here.
https://lore.kernel.org/all/20231201031839.239567-1-venkatesh.abbarapu@amd.com/

Thanks,
Michal
