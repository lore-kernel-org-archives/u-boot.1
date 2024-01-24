Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C15C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 11:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B5087C3D;
	Wed, 24 Jan 2024 12:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="jNS7y19r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DEF87C49; Wed, 24 Jan 2024 12:12:22 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA2E87C39
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFn/IBLJiVApBL1f0KeS4+/4sfgOssFqyuCu6Z+qY5iJGUkGw20LDKZESJU2C9k6SRyWO3s5bxZfa82F7w342K3W9lI2A++hoBAVF0thvNw+lK1dcZwT1x9NosSou7ujd+QATcZ+f6tbuib5xPppXMFwd8NshrynxuZFdxSyBeLSO1jNLfefSbB8sDmWEKYtFt58PHOZ1/bUPqjR8U6wtKZVpDzmD2SuVVPzhzKb5VIVG3fkjPb+r/KttwT7ootG/KiwvoBLjdUGmEh1e30sRj261UuUUahLLdssiw180Ia1wPobH8mkFPuVKjKjiD69no70UC4SGOLHg33s8ma82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjzQmYFGmAMVv6lmBrBR5Z4mfLPfpw7lGS0kHAX1VRc=;
 b=i8CX0QQ/GU2RgD8hWZCfft8o0n8bZh/m7WejbCzdXIuPhkHRYm7fp2D2MgcAm+n6KjdRsG45eDXyn3BFVNvGfkOsb74vRHyBb+TAUfgTd4Bi/fZq5RzlVDUh1rz7X6rZ4GYWSfjwpmtAZ45dcsPl3a/eYAaQvFHY2OtfpqsM336h91IDJK44yhzauNDWqdRudt6mj6SPriNuSCOMjwC/ugC+32nDGO6urj1ubl6tLlJ0fhFInwI75zM/CQfO5qZf/VHMIW7bDp68F/9Yc22HVUQ3Jjm0VcICcGr8B0HC4bqoU5bMZxOezF1UIRuJGK7Rm7z754Y7Yp7Z0PkQ6ntXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjzQmYFGmAMVv6lmBrBR5Z4mfLPfpw7lGS0kHAX1VRc=;
 b=jNS7y19rzxb52dVjY0xhYoQ7AThx1Z+DDUzukdlV5ktjzJyHJ+M7sLCGw6uN4vyu8EVgKU41IoQpcB3WbBxfjCm96zzFrX6fsqsJxekH7l9okrPqG45ydHk3quATsgThh+2IWGhBtUPvE6XBY2s3kk3EnD1i2bOcwqv6uL4O26aM8U8CM2q26UU7/SZudMUq6oZs+xZDC0grhBGSLDp1vVVeREiC69KBi004rpsAT4Vc9oIE2mv/HpUlK47xlixQwmdI7UwP44QZ0b1dP+Ecr+lIos7OffA5evR9pnmpQP8wMZpY/uPY8wNsPqljEdRCjAFh9AATQal8w+pNRzosKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 11:12:17 +0000
Received: from AM9PR04MB8539.eurprd04.prod.outlook.com
 ([fe80::708e:e38f:c656:8325]) by AM9PR04MB8539.eurprd04.prod.outlook.com
 ([fe80::708e:e38f:c656:8325%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:12:17 +0000
Message-ID: <b14eb7bd-2dbd-4f79-b4c4-fa080b96cf2b@theobroma-systems.com>
Date: Wed, 24 Jan 2024 12:12:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] rockchip: migrate hardware.h inclusion into
 appropriate files
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-15-1eec1c34953c@theobroma-systems.com>
 <b0720d07-764d-4da6-aef4-c6c5a10fb0cf@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <b0720d07-764d-4da6-aef4-c6c5a10fb0cf@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AM9PR04MB8539.eurprd04.prod.outlook.com
 (2603:10a6:20b:436::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8539:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4196ee-ddea-4162-2ae5-08dc1ccd533e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5LjhmIL4MTMxNfhFm2o2YofhfojWzfOjjS+wmy2hS/Nqj4Rcu9XzvN1eMz/BYBw8QC8ehXMxox05wuKmyMBtzZtCbTkLpdCEqXu8Ih1nMhW8HvGlm7acGmuXDJrgv12DfVP6XgEMH4uAMIOWM9bc8lcIwH3lqWY1M39e9sOOC+n+slYqeCl7wq1/UnRsiG5zGIi/1sS4b2OotokfY97CpA/SV9tW0VfcM1WwliBFjBcrLdRwI4M9pbej/JJc52e0X3AaU+B5dg5ZkibCVK3HlkJyu6tKTAKgPn5hqQiz677xpzVMU4M+w5ICf/wSjYtkwj+abZpZmoDaYRnjgEpRUNyLhzqu4ipR4mvH4ehD2Jt8Vyo1IISzah0vrMAFLuQtroynj6R9/uQ9N18Vlhk6s7p/akYV006lKaz5HuFyeSIXZ+UoHRk046/lgZPw2eZEmJpXEixNZj5S7jf2yeUZSyw998Qw7fi1i2kNw0GJJCfqvSG8YcWBRn5Spl36XLOEeyh5UsmvZfr5JWEVxJ4M8zMbalyhcc+/OSTHazq0gMf+Igk66IKpRJ7aOnQ1tCzb/xcdcJ4eT4fzzxGHRdz0MNNrNPMkN3j8O9hhVqqwi0BsJ3G9Aq7D8DiHuV7rQGG3iWpQTKsGry8U7lqGKCpJovRl0OBfJpyvbsrHsKCoTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8539.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(478600001)(6512007)(53546011)(41300700001)(8676002)(36756003)(6506007)(6666004)(2616005)(66476007)(5660300002)(110136005)(316002)(66556008)(66946007)(4326008)(7416002)(8936002)(2906002)(44832011)(38100700002)(31696002)(966005)(86362001)(921011)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkIwbEM4QWdCZDVvMGUzK1Y5NEwvaXUyTG4zbjJpVURMdmVSc0Z6eTUvUUpy?=
 =?utf-8?B?VWRtZzlOZTV5RFN5UFlOdDF5WURSeitMUWloQzFtYzFrWGpiSDJ0UVFGSUF5?=
 =?utf-8?B?SXpTM1c1UTFycUQ4QkpVejZKZzRtYmNRS2s0b1E2TGtXOFZ3VHZJRUoyWEJW?=
 =?utf-8?B?cVRVODBlZkpkamhBR0RGOHNCcXMvT1BYTGNYTmZEZ20xZzdzWmpLc21IbHIr?=
 =?utf-8?B?SkZXYzlxNktqWm1vWGlrcUpkb0RQcEYvVXd5ZHpGdTFMK0ErSEdwRzJwaXRn?=
 =?utf-8?B?KzNQdDVNM2J0MGZLc0ZsWUVkNDZMblIzUzVxdjlCcFBxRW5lQVNxRVc5OFFE?=
 =?utf-8?B?RzV5VXBvSnVpM1dsb3hZSHllYlZ5d0R1N0hOMFFmVHVDL1lhSXN3Z0ErT2VL?=
 =?utf-8?B?TEc1c3ZxQk5RUStHOWpQWEdJT0xpZXdQY3YwSm52ZEhWMGQrVWxWUllieVJn?=
 =?utf-8?B?cTdXdEZRbk1EQWluRUhpTlJTSEJVUHdqOHB3VzgwK0xjb1U3ZGl6THFDS1dl?=
 =?utf-8?B?KytjZDI2MkQ2b09mdjB4bzRuMzB2N2F6MzlUdWtGUnJuUE9uc0VVbC9sNjRN?=
 =?utf-8?B?ZC9NdStYQVBhdzhBaFEyQ1A4R0FGRlAyb3pSaTJxaUpNb1grUVZOV3NwUDVV?=
 =?utf-8?B?aUkrYzE0cFhTQVF1cWtsSitibjNvckQvSnN5SGc2NlpUNWU0QjhsaWNVbGZU?=
 =?utf-8?B?Q3ZZS3Q2ODc0RVdZK1pKby9Ud0loYVdaMTl1TmFRY25ZK1pIL3QrR2NzZkpV?=
 =?utf-8?B?ZjJOZWZLL1QyQUpmT1h2V25rZlAyWGVkZ3NSMUUxaUlXZE9NUkFFOTBWT0xG?=
 =?utf-8?B?bmdpcmRPenU4a3VwSW9SU2RvSWk3ck1sVWs5VnZKT3pSQmxaQTlOa2VlbFll?=
 =?utf-8?B?dCtHaEtoazVER1RVWklMM2h0eGZ2ZVhvZlVGZStUOVJkUWpzbDVJdkxzS2lw?=
 =?utf-8?B?K1VHS1BSY1RORmc1dXNsWEdVN0hydEpieUdGWmx6a1F3YWZpVkVaa1Y0VGpK?=
 =?utf-8?B?MitnbVpqUzhBcDNRWVBKeUdmcGVUb0ZiaEtlZ1VFOEtlK0RyUGprRXUwSzhW?=
 =?utf-8?B?NW9yK3RkaUdqZEZ2aDVHMzArVlRDVTJ0ejVFYVBOUmdiUTQ1ZHZlWFgwRjJy?=
 =?utf-8?B?eHdpKzhxRXIvMHFBNk9yVkNSNG9lRHFiWm5YM3JTSGliZ2kzdlNBS1ExeFpu?=
 =?utf-8?B?eGdtYnBoYnJ1Z0ZaTlMwWXlNa3ZBRUc4WmNTUFdPNzBFU3BLbEdUbXI0WTlH?=
 =?utf-8?B?MVhxSWJBaU9jV0E3Wkg5UnV0RFFibzRiMGlNMWEzTy9mS1o4Tm5pbjAwYWhR?=
 =?utf-8?B?MUErUGQwNzRpbGN2MUZWUW11RDhLeW83cUtsa0EzeWRKVmpEWFlPOUJhdXVU?=
 =?utf-8?B?aVlrOVJrbDBNWkVTb2EyMEpEVHVqeVBNakVJSWtZQXZ1cnEyNVRUdEs1bXk1?=
 =?utf-8?B?b095WGZPVkNaNk1UeENxYWNpaThEUWU5WFJZcnExaTRFTkd4cVFIZzFkNEpv?=
 =?utf-8?B?VFhYRk9qekFBRG9OUnlHVWpqc3VuVzc5cjB4SmFqRHhpdllQYjBkMkVIM3p4?=
 =?utf-8?B?WDF2akhTY1hSbzhkcDZ3Nk52Y3lFUk5tazduNVhpellLY2RoWjRuYzZseFhz?=
 =?utf-8?B?Y2xuREhyRnRiTWdyeVMxWEdQRDZRWGFFRVBlblkyTGpmTmZVZXJXUUk5OUVi?=
 =?utf-8?B?N0RpYTdQYUROc2JqYk12bEd5Tk9jVUhscHZ1R2lkR2xsMW01RlN1SDRualhZ?=
 =?utf-8?B?VDN4SU1tYlJhcjJTRVRkUlhRMGtUYk02b09qV3ZTSmNNOFFDN1VrVGZOaFVW?=
 =?utf-8?B?bVQraU5iUWplWDFLUVBMd0s0MjZ4dU5ySWFrY3E4VHJ2WGtFMlZBYXJZaHo3?=
 =?utf-8?B?cGdXbk1vQ0RsdnZMa1VXQm1hY0M3bnRyWTVmZlNTYWdwckNQWDlJa0dmWFlC?=
 =?utf-8?B?RDhhdzYwSk93aWg4WHRmNnBueU1ucFlmbStYWmxxbTRkeUEyOWZFMTZHajFp?=
 =?utf-8?B?UXZDQmNBMWI2aDJEbTNxdHdNTlNJc1UxUUFObjFUSTcyb0h6bVFuRlFhdlBl?=
 =?utf-8?B?REUzT1BYVThwNm9LN0tuNklqM1VoaU02R0ZSd2hoQUJ5QlViNnhSRTN0MExQ?=
 =?utf-8?B?M1dpMEpUNTA0NVFLd0g2M0sxOTczMXl0SXhtTjFBVTQ0Y2szcUV0RFJENGs0?=
 =?utf-8?B?WlpKMlAvUlFYZTVVUS9KTU5KMEVlN2ErK0ZPN1pnS0llb2tKamZSQ0J2bktx?=
 =?utf-8?B?UmtoUzhETlMxdlJpSm94N0cxRVdnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4196ee-ddea-4162-2ae5-08dc1ccd533e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8539.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:12:17.3158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pYpu2DOD3YRgm1TmFn9pLrlsG+81rBRpQR1KS4wdpVOQrwBOO9Eh3D+Mu6NlKT8jWedqpmRiRnd+re3DBS9HRDW2skbS90hc1lEYz2W4HOLHBNWScd/D1fETJ8e+9xT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135
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

Hi Kever,

On 1/24/24 11:46, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/23 22:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Nothing of the hardware.h is used in include/configs, therefore, let's
>> move that include to the files that actually require this include.
> 
> hardware.h is one of common header for soc level, it's reasonable in the 
> soc_common.h.
> 

hardware.h is only defining macros which are "wrappers" around writel().

writel() is NOT available in hardware.h, we need to include <asm/io.h>. 
Which means someone who wants to use the wrappers defined in hardware.h 
also needs to include the <asm/io.h> header, which doesn't make much sense.

Why this is done is because if I include <asm/io.h> in hardware.h but do 
not remove hardware.h from the SoC configs header files, some boards 
stop compiling in arch/arm/cpu/armv8/u-boot.lds with a non-existing 
ALIGN signature (expects two arguments instead of 1). I assume this is 
because there's an ALIGN macro somewhere in asm/io.h that redefines the 
ALIGN assembly directive (c.f. 
https://developer.arm.com/documentation/dui0473/m/directives-reference/align) 
and that u-boot.lds somehow includes the SoC config header file (because 
IIRC this is also included in the autogenerated include/config.h which 
is included by "everything" ?)

Basically, if I don't do that, then I need to manually add <asm/io.h> to 
any file that also include <asm/mach-rockchip/hardware.h>, which isn't 
really nice (but doable, we've done this until now).

If you still prefer to keep hardware.h include in the SoC config header 
file, then lemme know and I'll drop the hardware.h and io.h patches from 
that patch series.

Cheers,
Quentin
