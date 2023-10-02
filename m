Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D4FE7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 19:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71DD86CBA;
	Mon,  2 Oct 2023 21:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QvSmHUcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7998082A; Mon,  2 Oct 2023 21:02:56 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00A980422
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 21:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN5fNNvXp/yzzglfboKI3Xyfiw51sof7Czcd9l+aGjkd3rHeiIzkkDRNeQ6hn7t/We4ROkC/1nQnmwK+wgB2T8aG0h3JN2QVbu7nJ6q6CtS5+1ZkWptgLrjRfO7aXBDo6LWo/RXbOv6lSQQQDR29cqRiS53u/YroBlG89YQrOxPRfA/qedgIiDhp0rl9C8YyQIcVsuHVCzMQTGp1w1e9bpy8yqjs7qdj0/78NilWXdllVEA9vCyVVuA/jGGF+9sk7Akz/P0nN/zHvbWh165tYH7VdaXy4+Zs/zwOtEGcMvWu9TM6ZFfBCEobfTnmy5B/Rya5wjqLQw7lZ6nulZBn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdBFeFyQQv/2qC+iHV3r8CDZ/xF7HUlTc9sA7iDHSyk=;
 b=XaSOJBSNvt1L/yOR2U6DTbitB7JfLDxSQb/R+rq+0XC/EcZCVdPuoguCJqe2JDkhVWfzkzNdHhjl7a1b/6j04yvuxNiB+pulga6p0UUrfyNJcixSjwFQfO8XGNB7AHxnrQT6d4bl9exb+vljQN18uAKd6Q6mGeZKHD0TAjik4akBoCT5S4zBV86GW0vQcAHdfFT4uFQgMQD0LX/gxLByeq6zTqc/2r5PdF5Z9bm/24MFM9ShAK8oOxETH57ngJxrfG2wQJZ7glPa9bsNWjezYyIilIfoUN7CxjdxVbWMVNh4pzRcqfVwwF4kkyULx8RGYsEh3kH9/ITkiBGBFBWdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdBFeFyQQv/2qC+iHV3r8CDZ/xF7HUlTc9sA7iDHSyk=;
 b=QvSmHUcbPqlAQ3r6iIav1CpwdGaehmwGQpxukRk99FMObdv4EVNl5OUuEUn29EWJ3vDdInUUvBVNDDqOfFxlRNtwcQaS1lUwb6DhH+kNe1zsrkTwkIVaEsTVjXhGB4V5W61U52i7iF1G+Wqy2+wEh6q7Y8TPsxuj36P0NmnoN/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB8110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 19:02:50 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 19:02:50 +0000
Message-ID: <816e7ef3-681b-3b9d-48dc-e3e2ee415127@prevas.dk>
Date: Mon, 2 Oct 2023 21:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230929160230.GP305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f20ffa-d15d-447f-1062-08dbc37a2c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXoaGAxVkLzl/+bZh/pmVDAvTsv+tdlAelMV1leuRZlkgaQ2fEN233WA3p61cqotHDn1F9EsmO8IYujQKyKfn4a0XASE8Kmpi1GeusXLhQROAT6HI6d2NcsXir/BsuDeDeu4NpBIUXhBCGGDwV7Rsa+MhSe8/0cPmrqcipx821V5ZE2p7nQa5LfiChyr+j7p39Ux1q3hY4WGR6epP73B6qV87L4zntSF1jbovQQ3cbfZT3LAs1RNRsDGvKLXLU35U/hJMr3xBVaU9O6mxrGFokUIIMhuIUgWlpbJYNO/r3VELC62P7nxwQ0mTu0R2C0HTRsuFRxQ0WFdTdDCJQgrbVD3WjOd3yTkIu9J6kaaJChzI0f7ADJUwefLMbf3qXKsElTog9bLkyC4mrsq02ywpJSMHfEGOMqsWC0wFFMNFIiih1OCJKDf89450DR3ZJaPqrFnvZKEcwu5uYg6vkpgfTQJoaTGlIFh2DUiLP2rFSOfp7iiUvAcCHwYHJffNHn2ppl+LrLhUV59xbKR3GIcP7k6roSh7SlBd19w5/MTNcL1KdUBqMfo67LiJ5zytoT7Le9qVDlmbmYyE6hd6eTJqpsW81a+BZeKhJdWv1fLoGhjJIRgKlogy2bCYBoSpwjW8l4oXzuB/ynECDegRz2cTSy+NCU6vnHzbRfgjPRbjdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39850400004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(38350700002)(6506007)(6486002)(52116002)(966005)(478600001)(26005)(6512007)(83380400001)(36756003)(2616005)(8676002)(66556008)(2906002)(41300700001)(316002)(66476007)(8936002)(5660300002)(66946007)(44832011)(110136005)(4326008)(8976002)(31696002)(38100700002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRFZ0p2Vkw2SEFXVTU2YS9YT1lQOTNmQ2ZXZEE5SW4zMkloblkyT3FyU2Fz?=
 =?utf-8?B?NkV0YUlDUWpzRzFLc3h0M0FyM3Z4c01hQUpDY294TXlGK0RvR3BNNkNmV0pM?=
 =?utf-8?B?dHZEOUVFcFE1dDQ0bGZOa0pPMXhIRklWNEVPUGpVZlYwdTk1aXVNZ21RcGhK?=
 =?utf-8?B?UENVNi9WM2g4RWErUnl0VjZ6TURDQmJXSnBDYjhXaEZmLzlFU2hRZ3lJUGs3?=
 =?utf-8?B?K25TcGRVaHZod0YzTlNoMis1cmRGSkZZZWt5Qy9Fc3VRd3d0OWJucEhFWUd3?=
 =?utf-8?B?Nk9SNmhNbjVmWmM4QzlFL05oVk96TythbHVmK1RkQU5aM0l1RWNaM0VCNlIr?=
 =?utf-8?B?WWNibWdGNkxBbSsxUE9qV21GbXNoMXg2dDVZbVRURmZ5eDgrYStLU21sd1d6?=
 =?utf-8?B?YngwUzR4VjFGRXFuRTBZVVo2MWRuWHJDbk5oZEIrOENueEJJaHlqWk5QTjVG?=
 =?utf-8?B?ZVNKWVR2QVFWdTFzcFhkd2RFYlBudVFGL25JS0ZVVmxCSzRXY2t4bzExU3BO?=
 =?utf-8?B?MXp6dURIMjh2dHc3WjVUamJKMjRGV3NTSFIzK0YxbEVBTGtDY2J6ZjdpL2Zp?=
 =?utf-8?B?Rjh2TWNoQzBONnZTWmF1RFo2K2laUFN6amk2RlNWTmdsSXlmR3lLMWYxeHpq?=
 =?utf-8?B?ZVRxQlRTQTl5alhUVzRXWkl4NXRWaGY5ZXI0UHdmYXQxYXRkdW1KbUhRdkpk?=
 =?utf-8?B?ZEh4TEVKMlJwY1MvVUVxWHNab3ptbGZhMm5odzE2K0xhRlFYTjVIZGpHcVZ5?=
 =?utf-8?B?aGdLcTRrZzBWUVVYc1BWY213WHIvYlRmWFhpakdlaXRRK0d4UW94ZDhYMllD?=
 =?utf-8?B?c1pITHVQZ2xiSDViTmpJeGhLa2lHTE5TcmxtaE1ESXM3akNYVVhqeE1xaVMx?=
 =?utf-8?B?UFp3VjRpVmpPcitKWStPazdrM04xTmJZRW9rTEg0TlBXVFFrazR0WDR1SUpP?=
 =?utf-8?B?Vm10Y3pacmNhOFNJcVF2a0taZ3p6RVFEWkhDUGdINTZMbDFBMDlLbWQzTFVi?=
 =?utf-8?B?ajV5YzRTeTlyVVZabGxWZklwbHhQbnVPQ3Zac0lsTnBTSnBjMHJ6SFY3UDFv?=
 =?utf-8?B?MzFjNnVxZEZrUmF0b0s4Y3Ribmx6Q0UzMjFIVWttc2xQYlNhTXQ1Sk9WYlhj?=
 =?utf-8?B?N0s1aWd0SUdOaDY5UmJzdjVPWkorZGFFZ0dKVndBdjBJeUdaaWlDUHA5SVVQ?=
 =?utf-8?B?L1pib05PSVMwbGdPNml3TkNzNEVDb1Bnc1AwQWJZeWh6SllsdFBlY2pMSnBL?=
 =?utf-8?B?MEVwdS9Vd0Fqa3BjR2g2Q3M1cmNwYUEwYkdUdzkrWis2bkNpNUFVYWxGWmln?=
 =?utf-8?B?V0RnZzdtTklwMlFkUjZBMThreDB4UEswY29uRDJucnhSb1o2dE1OSDEwL1VZ?=
 =?utf-8?B?VHYzMUQzTzRsSVBUbkpuSW5FYmpMdmFqQVZyc3cyNWhsSjR4eXBRRUMzcGVl?=
 =?utf-8?B?V1gvczc5anQ3enNKVWRHamlFelRZb0tZeEl0aCtFaXVpZUpYY1RXcnFjSEdP?=
 =?utf-8?B?aTVXcW5wSkNKc2M0Q2JYTGlaUGFManhpN3V6VjJqcFlZMDdLcytvZUJ5U0Rr?=
 =?utf-8?B?bXNiOWk4NzJib3FHVFBHOC9Yc3pNbWM3S2RUUmR1OUVWdmNMdzNsazlCVUFu?=
 =?utf-8?B?Q2dwcE5TZC9FMjRSRkRVbzJMU1daSi9wcEEzcVE0LzlZRzB4MEV4amgxa0Ft?=
 =?utf-8?B?Y1RNd3V3T04yZFRCWDlFTlUraUd2QW9GMVdqU1o4T0JGQ05JQ1lVQXNwcU5r?=
 =?utf-8?B?SWp6aWE1emx3M1NudUV4WkErVFY3MkNVRFEyOGQwM0RJd3VOaHhkQkpUY2ps?=
 =?utf-8?B?ck9uMi8wcEVxZmJMelZkTzFqQUdqcUc5N25LUVl0VTdUSnZURXgreWNWblg1?=
 =?utf-8?B?SFZMdVc5ZnYxdWM2MnZjYUs2MEUyY2tac0lyVngwT2RRck9HSThFNENjVWV4?=
 =?utf-8?B?S0Q4VkkzU0xBOU9Db2Y3RGF0Mjl3RUZDc0k0eEI3L3QrVlJWZkhOVE5OL3k4?=
 =?utf-8?B?QWJGa3A4U0dUZnJpSmZyaVFYUUt1TzNSOWNEWXBtamxiSlAvTFgvYXFpcjdX?=
 =?utf-8?B?bU5mMVJiZEQ2SFZWeEFacys1WlUvTXh5dkhzby8ra3lCeSsxRlZWRExLdE51?=
 =?utf-8?B?SGtFa0pmY3VCSkx6OEFqOE1QYkVMaVYxSE93ZjZnYlNqdmwrVE80ZmJWL2U2?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f20ffa-d15d-447f-1062-08dbc37a2c5c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:02:50.1975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3ZEcWhHQS+LqMNZzTEdsKtN+BqxEnaNS+SwPoNToD9ORX84A+kwCmCTDORH3MWwynu07CuIjc/sbGxsRmMSBKc/MF5/IEj1hxQJLBSHPeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8110
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

On 29/09/2023 18.02, Tom Rini wrote:
> On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:

>> Honestly at this point I've forgotten what this is all about.

Fair enough, let me try to recap, though even a summary is a bit long.

(1) I wanted to do what $subject says, and you seemed to be ok with that

https://lore.kernel.org/u-boot/CAPnjgZ1B+3v_5rCSBnUgZ6cVO4odjjDfeS0rx3iMw4vjXUo0VA@mail.gmail.com/

(2) Tom pointed out that, unfortunately, as-is, the patch caused a bunch
of build failures. With hindsight, that was inevitable.

https://lore.kernel.org/u-boot/c3c94614-9916-7316-e009-04ddbdc205bc@prevas.dk/

(3) I still very much would like the original patch to go in, and so I
pointed out that most of the current arch/*/dts/Makefile are actually
completely redundant, with the logic in scripts/Makefile.dts being in place.

This is when the thread turned away from talking about the original
patch, but rather the cleanup of the makefile logic that turns out to be
a prerequisite for said patch to go anywhere.

(4) Tom tested a patch that nuked most of the arch/arm/dts/Makefile,
which revealed a few defects, partly in Makefile.dts (got fixed in
6923f49d3ac2) partly in a board defconfig (got fixed in 2d158d3c387d).

>> Perhaps the easiest approach is to create a new Kconfig to control
>> whether a board-level .dtsi is included in the list of wildcard
>> searches. Then you can enable it for your board without affecting
>> others.
> 
> That's getting things backwards, from what this cleanup does.  Today we
> have messy lists of "build these device trees" and then don't use most
> of them, and some of the list is just Wrong (listing dts files as an
> output). 

(5) Then a few months passed. I'm still interested in the original
patch, and also the cleanup. So I pinged Tom to redo that build test
with most of the Makefile gone. While revisiting this and doing that
mechanical strip-down of the Makefile, I noticed that the Makefile has
grown not just one but two .dts files listed in dtb-y, which is of
course bogus, and nobody noticed or cared because the
scripts/Makefile.dts logic JustWorks.

So, given that today, each board, in the form of the defconfig used to
build for it, in 99.9% of cases already includes all the information the
build system needs in order to ensure that all relevant .dtb files gets
built [because there's only one and that's DEFAULT_DEVICETREE, or
there's more and those are in OF_LIST or SPL_OF_LIST], and the Makefile
is error-prone to maintain and when adding a new board one chooses some
semi-random-list to add one's .dtbs (or .dts.....) to, we want to simply
stop having all those lists in arch/arm/dts/Makefile (and the other
arch/*/dts/Makefile, but those are much smaller and can be handled
later). No TARGET lists, no SOC lists, no nothing.

Yes, there may still be some 0.1%. We're trying to figure out if they
exist, which they are, and how best to handle them. An easy fix is to
drop the condition on when OF_LIST is settable to something different
from its default (which is DEFAULT_DEVICETREE). But without knowing just
exactly which boards and which .dtbs we're talking about, it's hard to
know what the best solution is or if there is actually anything that
needs to be done.

Rasmus

