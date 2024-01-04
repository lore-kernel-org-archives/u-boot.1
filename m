Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA95CC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 08:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC0F877F8;
	Thu,  4 Jan 2024 09:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hrKV7XKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF2C878E5; Thu,  4 Jan 2024 09:17:04 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5770877F8
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 09:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmYPtwFs1RUjhOnLSadDxlTJCn3OeYZ1IajyePhW29hKGq2KkeYhDpJl4zaUVBpuwEbNOWIcZe02vo1jzpb+k2jMn3NKKZSe5HGxQQ0E+FzGFG/rsWi2sHmB+xF70rEIHafTHSfh+avdNXnB0NXx4gJKcLuh4VmKGUyYQJ2K5uwGfR55QAdUDOvY8cqUz3Xt8fndbVM16y6ur4MhwzpCHCG8+IX4VHfCkl3FsWFuDY/gHIl+wnohZX67EGDsgxmxlJnEaXFMWF57jf8RES3KBuK5TggzeFDNV2owEavEkWyt+xW/INudOvk1ks+rr49xHRHKscZAtiQLcr74nEiZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2sOD+RYGHMvaRs31z8ElygbPdqBuESAx8YpJmf7SyA=;
 b=KX+2A+yXCwJ5Q1hoOOU5xTrx+Zk/gPtTElf6vYpuTQORCySDwvOIhKBSm7XOdJEwlWuALapJedzMVRrny5bQlhmGIU/VfIYCtp2vI4zbGWbghS9Z1uDji18W/jni2Iia0cEwqjXZyIrrYbRfJmv9HqMatRs5Fk1CJ09TBxdq6Zztz+tsEg8ZTiuS9V+fk2IxcGQkWT8cZpAbs1CngTP9mzIPEi6Y78izYLMtlgA+3juK+ITJdBM+N26fSHzCgyIitOusSdK9ob/3fLg24D8BvxbO63rlN3ZtaaUw6KPtSJGAIIvyTp3oz84UMvqZU52dBaZr/dkNOHj+eK+/a5ZuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2sOD+RYGHMvaRs31z8ElygbPdqBuESAx8YpJmf7SyA=;
 b=hrKV7XKQAJP60ktG2OpgsawTa2SU1sq0vffG8kTjiwaCQuynlQnNQdPFGKylk5izfIHFqM0r5Aj78VF7IZ45Q5O18ILN37/ixoXdnugl27/4Rh+Sa3DnJZskZQice9j2lZ+SYx5gYMs70Kb5WGe88yQ30vLJ4H7AhRf32/YlykQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 08:16:57 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:16:57 +0000
Message-ID: <3e04855d-bde4-4f81-ae44-c0108bd33233@amd.com>
Date: Thu, 4 Jan 2024 09:16:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] arm: Get bloblist from boot arguments
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Baruch Siach <baruch@tkos.co.il>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-7-raymond.mao@linaro.org>
 <f7cb982f-66f2-47f1-aeb2-f3fa8e8b8912@amd.com>
 <CAEfUkUL9viRAcWMyjd_=BVVru4hRPV7D9rHhggSBHEEX_D-zDQ@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAEfUkUL9viRAcWMyjd_=BVVru4hRPV7D9rHhggSBHEEX_D-zDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a51867-94c2-4b5b-cda0-08dc0cfd84d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIHpj4bN/QrH9k8GK+sKqkFH0s/5TYYy/NsmnFihx57dBh4STmTD+Izg4hK+fSHL4cO8v5wh+nSAlKma45+VXUvGBx4aF/xUItjzhsxIDo9ZDwBP5LxF35oE3XhUOux850p9XBMF10ytrp1hGLOh9vls3qFnjIrMbBsdlcCjNdEiJUjUEO6ChrUxTxWm6UFHA5Ue7RYlq94TTYmjB7SijbxmJu29CxAnSzOLVzoAn4jNRtcKqHPJvFmVMEwNstqtt3z9wzhBPhr9kMjNULpKmpFPcWFIWSPparq5HR61SnKTE8wpc0y0gWd+oDRqgGA7KP3iccNaam9qO5OGrXw5CHzRw7P2T74hNBhbM7nG9aS1b7KJiJwfIHAbG7U1LOo+3xY21HEJ6fJXCD4qunogBfwmT1GYNJHV4owuaIaXrIdTGjVhzuacmk8FEJKB7dyRHQEd7fcBQ0u22AgFtQZ1I8UcT4YOzFodyW6x/MpX6xq6o3D/0m41BAof0Bmptuox+OTOXpYlU8X8aZ33HpCTRR0HVj9HqSpVlxpl9FPoPf57y9Tg9pCwPWJfKX/CA0bWcFM2MfzPTa1enpziUTCMEmtmfSvjG9mVVj6oGTmoJ/pymIo1iYbEVLZFFhcdj2g8fSZkdmiSgv8B7YLyxGgnRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(83380400001)(38100700002)(36756003)(86362001)(8936002)(44832011)(4326008)(66946007)(316002)(8676002)(6916009)(54906003)(66476007)(7416002)(2906002)(5660300002)(53546011)(6512007)(6666004)(6506007)(6486002)(66556008)(2616005)(26005)(478600001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NlaUxSWVY3WUtyV2JjNlM1V1BrWjdmVy9RdHJtSlJ0UXdhYit2N3dtZUVr?=
 =?utf-8?B?cWJmdEgydjlNOHV2eWVrVStMUE5MeTdoaVNxb1RnOWIvZFpybm41YUxsbXNo?=
 =?utf-8?B?azRZT1ZGR2FWaCtha0kwRHNjOE9jaGw0TXBHcHcrTXNxZTNpZ2Y3NDRPTmNP?=
 =?utf-8?B?NGhiRGtsdDR4TFIwcU5NNTNoTGdGdVVxS3Yyd3RiWnhTQi9BL01Da2d2SXBn?=
 =?utf-8?B?Y1VaNW90WWlSZ2pTcW1mLzI5d1VjN2ZBUjlrVFcwaldvaWJSQkNZaU5PUURa?=
 =?utf-8?B?azdiaDNjVnc1WUtzTExUenNZWjdWVVhhOVhETDNWOHhtTWk3dTNJZy96VUNr?=
 =?utf-8?B?UDFRbVhTS3hyVzdIMDVNODE5RUJ6b3J1aUpKMkduUEM0dkNGU1VUWmNLaGx5?=
 =?utf-8?B?bEZReU9PNGZPYkRGdHF6Wk0xbVZabHY3aEdKbkJOS0hIaFEzbXhnL1d6MW5Q?=
 =?utf-8?B?b2ppdkk2dEpEVy8rMjhIdEI2Qm9xdWswMmloRzJ0QlY5emhZeENiODVza3ky?=
 =?utf-8?B?bFpCcDJKckNmMnFlOEErbmJGWW5lbGhBV3dFeFNrZXlXbDVhMTdRZnNjZSta?=
 =?utf-8?B?RkRPRVRxNUh6eGhaaUd5WGpuamY1TzBqdW1NdHFnbkFCcnNUNFRxQXBIeXRh?=
 =?utf-8?B?Kzh0RjEvY1ZxN1BWVlFTRTFQd3VDM2JKUVYxbnRlVWFpU2h3dHRUelVobStp?=
 =?utf-8?B?ZjFNOUlEbGRsWm12cWE4RE9GMEdxcXowZkxlUUc0cFp6Mmt3OWY5WEhjTG41?=
 =?utf-8?B?eWczLzVPNnlsRVVqV2gwMmxtTGNCMnA5OGNaVkM0K1RSRVZjdGlHQnJBeHNM?=
 =?utf-8?B?dzVrd0VPTlpXRTdIZk95YnFPOGFyM3EzK3lrYVdIMEdxc0pyWTlyMXk4ZUoz?=
 =?utf-8?B?RjQwRXZGQzBJRzBGTy9RNklZM0lUbFlOVFVKeGhCWldxMEJyWDJQd1I1MC9h?=
 =?utf-8?B?ZkVGbW5QVktHditHSzlMSHJkUHl2cGNJemlrc3hidTV4SVdzQ0w0NUpPb2Fo?=
 =?utf-8?B?RUR0eTlHQWM5bDhEZCs5MFMvMVNDbWViMGdRTEZwZnZEajB2dkE1QXkvQTRC?=
 =?utf-8?B?VWZvNUJ3WktlVHZiekJTQXdpU2x3QmhDVzFTSDFKdTRyc09nSldSWUtqcFk3?=
 =?utf-8?B?MDltN1BkcnVBVDB6Y1RveDNSUE1kVkVlMjBTTFliRXZvR25sZDlZWU0xWktv?=
 =?utf-8?B?TDBqeTAwRkhnWFo0UVhaNUFUV1RPc3FWU1JsT2FlcEd5UWtKZEhqSVM1QWhr?=
 =?utf-8?B?dk9DTEY5NmxkTU5DVXkzV2oxVXVDamtoVUlMTVNWbXlhbnpiOVlqUE9FVURG?=
 =?utf-8?B?RHdxUFRSbzhET0xpZ04yNlBSL0ZKbSs1SEdNY0Rna1hQR1VPWkgzSkp5bTZP?=
 =?utf-8?B?aGk0V0FZaU9RaGRLQzdhVHNpYVo3dUloNmZhUHBhYm93anZscy9XbmhaM1Ns?=
 =?utf-8?B?d1krZEp3K1ovSXcvMDc5MVp3SXVMcWZKT3FVTmwzLzRCWkU3eVFycHV1RXVU?=
 =?utf-8?B?YjRQY1o4WEtKZDlVRk1mcDZNaElpL0k1cCtHOUlkVHdpM21wbkVTcTVXVTNB?=
 =?utf-8?B?VmxJOEJDYTNqaGFtd1ZWK0MwZHEyRytzdDBGblJ4ekk5T2RKa2tRZHp5ODJp?=
 =?utf-8?B?OWVDWjJZbzJSYm1sMUNwU0RaNjQzL3NDZFJrN0ZjR0ZoWmNaYzNNWWtoY3BD?=
 =?utf-8?B?U3B4UU9TaldnOXkzZHdiUVJLRDBUMjdkWE1mOGk3ZDVNbGJ6eVJobi93UzI3?=
 =?utf-8?B?c3daUHFSUzlhaFFXU2dOdzNnT09Qc2FnZFd3WVRTR3pXbENPK3A4akJkZlJZ?=
 =?utf-8?B?M2FyUlFqd0RyQTFYb21YRExlVlBhTm1iRGNrbUg3eXBYeURmSlYrN0JjcThy?=
 =?utf-8?B?ZEduOG5pRy9MU212ME1Kem1LWGFmS29TY2puQnJ4S0FVVDJ1QzBwYnRjVFlB?=
 =?utf-8?B?TkdtTEFGcnhUUnBRaEdqMnpHZ1ZJdUE4SzVkbGg1dEF2SVhYYjI3elhBZURP?=
 =?utf-8?B?cWZMLzVTT1FOS2g3U3hlQWErd1RJUzBCZ0pXMzlFU2c3MFlhU3hXUENPSnFG?=
 =?utf-8?B?b2pSVkFSNjFHMmpZWExlOU4yaXpIZjRPMkZlTEFzaDVmNk9kMEZIbGkwTTRK?=
 =?utf-8?Q?KCpbBiSuIBukzr3ddZQmkJRaR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a51867-94c2-4b5b-cda0-08dc0cfd84d3
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 08:16:57.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt7jWYy/xgEw5WcSjj/Y33gDvSQ6cVjUrkJMKivs72I1r0X3OFOFNpowLmqdUIt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

Hi Raymond,

On 1/3/24 18:01, Raymond Mao wrote:
> Hi Michal,
> 
> On Wed, 3 Jan 2024 at 05:46, Michal Simek <michal.simek@amd.com 
> <mailto:michal.simek@amd.com>> wrote:
> 
> 
> 
>     On 1/2/24 23:12, Raymond Mao wrote:
>      > Add arch custom function to get bloblist from boot arguments.
>      > Check whether boot arguments aligns with the register conventions
>      > defined in FW Handoff spec v0.9.
>      > Add bloblist related options into qemu-arm default config.
>      >
>      > Signed-off-by: Raymond Mao <raymond.mao@linaro.org
>     <mailto:raymond.mao@linaro.org>>
>      > ---
>      > Changes in v2
>      > - Remove low level code for copying boot arguments.
>      > - Refactor board_fdt_blob_setup() and remove direct access of gd->bloblist.
>      > Changes in v3
>      > - Optimize board_bloblist_from_boot_arg().
>      > Changes in v4
>      > - Move the function as an Arm-arch library instead of a board-specific one.
>      >
>      >   arch/arm/lib/xferlist.c      | 38 ++++++++++++++++++++++++++++++++++++
>      >   configs/qemu_arm64_defconfig |  3 +++
>      >   3 files changed, 45 insertions(+)
>      >   create mode 100644 arch/arm/lib/xferlist.c
>      >
>      > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>      > index b1bcd37466..0023c55d0d 100644
>      > --- a/arch/arm/lib/Makefile
>      > +++ b/arch/arm/lib/Makefile
>      > @@ -85,6 +85,10 @@ obj-y      += psci-dt.o
>      >
>      >   obj-$(CONFIG_DEBUG_LL)      += debug.o
>      >
>      > +ifdef CONFIG_BLOBLIST
>      > +obj-$(CONFIG_OF_BOARD)  += xferlist.o
>      > +endif
>      > +
>      >   # For EABI conformant tool chains, provide eabi_compat()
>      >   ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
>      >   extra-y     += eabi_compat.o
>      > diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
>      > new file mode 100644
>      > index 0000000000..163d20c11c
>      > --- /dev/null
>      > +++ b/arch/arm/lib/xferlist.c
>      > @@ -0,0 +1,38 @@
>      > +// SPDX-License-Identifier: GPL-2.0+
>      > +/*
>      > + * Copyright (C) 2023 Linaro Limited
>      > + * Author: Raymond Mao <raymond.mao@linaro.org
>     <mailto:raymond.mao@linaro.org>>
>      > + */
>      > +#include <linux/types.h>
>      > +#include <errno.h>
>      > +#include <bloblist.h>
>      > +
>      > +/*
>      > + * Boot parameters saved from start.S
>      > + * saved_args[0]: FDT base address
>      > + * saved_args[1]: Bloblist signature
>      > + * saved_args[2]: must be 0
>      > + * saved_args[3]: Bloblist base address
>      > + */
>      > +extern unsigned long saved_args[];
> 
>     you should put this to bloblist.h. I would say it should be the part of 4/9
>     where you define saved_args for armv7.
> 
> Not sure if I understand your point but this part is for Arm only (v7 and v8) 
> and should
> not be in bloblist.h. It works following the spec from Arm. Other arches should 
> implement
> their own way if they want to load the bloblist from the previous loader.
> 

I am just saying that you shouldn't really have extern in C files. If you need 
to have reference to it put it to .h file.
If this is generic or arch specific that's up to you.

Thanks,
Michal

