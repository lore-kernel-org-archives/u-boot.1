Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194C0D59D82
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82AA68367F;
	Fri, 12 Dec 2025 19:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AxuVrAKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0554A83984; Fri, 12 Dec 2025 19:32:44 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBFC835FD
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2602840863;
 Fri, 12 Dec 2025 18:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF14C4CEF1;
 Fri, 12 Dec 2025 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765564356;
 bh=iLQYMuwfZOjfZU42CvlrRp/rT+ETIG7Qh1+AhADszFI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AxuVrAKrfzR8C1oeaNSFzBsfUdCiZv41DBL1Vo4fcAJxd2fsicvJs8VGV8pifjnKt
 r2OcmleqwdxoZ042H2QENhFFMn/V/VAW6JEfYQFXHfICZoqMosh2kkGI4ji4Q1EEhr
 FDVLnQFYOkbINSEaeHbtsCUX4B/0HcTyH30GESyY97qd9pODQ7Sua8z1ZHSH/hAVkb
 lXyGasnudCFAthHxhOIWoLN8mXCk+xU5d4XTb9WI3lNVGKPd3JdpSqc3vrL4lcqyq3
 1xQ8T2qyaycRD8KUfmfi7UFftM0/sYgtO3D8LxUtxgy/XHd4xfHCYQM19Mbt7/QJ32
 BfzRyj0d3xB1A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Stefan Roese
 <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, Vasileios
 Bimpikas <vasileios.bimpikas@analog.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Peng Fan
 <peng.fan@nxp.com>, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, Alif Zakuan
 Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Sumit Garg
 <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Sam Shih
 <sam.shih@mediatek.com>, Ian Roberts <ian.roberts@timesys.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Heiko Schocher <hs@nabladev.com>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: Re: [PATCH v2 2/2] clk: mediatek: add MT8188 clock driver
In-Reply-To: <67fdf8ce-41af-4609-a754-8041a4e716dc@baylibre.com>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
 <20251209-add-mt8188-support-v2-2-31dbfcf7303c@baylibre.com>
 <878qf95s5q.fsf@kernel.org>
 <6bf9671d-c70b-41ae-b8b0-ec303dfed484@baylibre.com>
 <67fdf8ce-41af-4609-a754-8041a4e716dc@baylibre.com>
Date: Fri, 12 Dec 2025 19:32:31 +0100
Message-ID: <87345f5z5s.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi David,

On Thu, Dec 11, 2025 at 22:22, David Lechner <dlechner@baylibre.com> wrote:

> On 12/11/25 11:55 AM, David Lechner wrote:
>> On 12/11/25 2:39 AM, Mattijs Korpershoek wrote:
>>> Hi Julien,
>>>
>>> Thank you for the patch.
>>>
>>> On Tue, Dec 09, 2025 at 11:22, Julien Stephan <jstephan@baylibre.com> wrote:
>>>
>>>> From: Julien Masson <jmasson@baylibre.com>
>>>>
>>>> The following clocks have been added for MT8188 SoC:
>>>> apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
>>>>
>>>> These clocks driver are based on the ones present in the kernel:
>>>> drivers/clk/mediatek/clk-mt8188-*
>>>>
>>>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>>> ---
>>>>  drivers/clk/mediatek/Makefile     |    1 +
>>>>  drivers/clk/mediatek/clk-mt8188.c | 1840 +++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 1841 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>>>> index 12893687b68fc6c136a06e19305b1dd0c8a8101a..68b3d6e9610d8e7f4c4c625f52e525174e92787a 100644
>>>> --- a/drivers/clk/mediatek/Makefile
>>>> +++ b/drivers/clk/mediatek/Makefile
>>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_TARGET_MT7981) += clk-mt7981.o
>>>>  obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
>>>>  obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
>>>>  obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
>>>> +obj-$(CONFIG_TARGET_MT8188) += clk-mt8188.o
>>>>  obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
>>>>  obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
>>>>  obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
>>>> diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
>>>> new file mode 100644
>>>> index 0000000000000000000000000000000000000000..55dfadddfe3cf743602533de30275bc93d4f15a5
>>>> --- /dev/null
>>>> +++ b/drivers/clk/mediatek/clk-mt8188.c
>>>> @@ -0,0 +1,1840 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * MediaTek clock driver for MT8188 SoC
>>>> + *
>>>> + * Copyright (C) 2025 BayLibre, SAS
>>>> + * Copyright (c) 2025 MediaTek Inc.
>>>> + * Authors: Julien Masson <jmasson@baylibre.com>
>>>> + *          Garmin Chang <garmin.chang@mediatek.com>
>>>> + */
>>>> +
>>>> +#include <clk-uclass.h>
>>>> +#include <dm/device_compat.h>
>>>> +#include <dm.h>
>>>> +#include <asm/io.h>
>>>> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
>>>> +
>>>> +#include "clk-mtk.h"
>>>> +
>>>> +#define MT8188_PLL_FMAX		(3800UL * MHZ)
>>>> +#define MT8188_PLL_FMIN		(1500UL * MHZ)
>>>> +
>>>> +/* Missing topckgen clocks definition in dt-bindings */
>>>> +#define CLK_TOP_ADSPPLL		206
>>>> +#define CLK_TOP_CLK13M		207
>>>> +#define CLK_TOP_CLK26M		208
>>>> +#define CLK_TOP_CLK32K		209
>>>> +#define CLK_TOP_IMGPLL		210
>>>> +#define CLK_TOP_MSDCPLL		211
>>>> +#define CLK_TOP_ULPOSC1_CK1	212
>>>> +#define CLK_TOP_ULPOSC_CK1	213
>>>
>>> Why are these clock definitions missing from the dt-bindings?
>>> Were they just forgotten, or is there another reason?
>
> It took me all day, but I learned some more. So some of what I wrote
> below is wrong.

Thank you for investigating. This is very helpful.

I'd say that we should update the above comment to include something
like you wrote below:

/*
 * Missing topckgen clocks definition in dt-bindings
 * Note: we can't add these to the upstream bindings without
 * breaking the ABI so add them here instead.
 */

>
>> 
>> I was looking at mt8365 clocks yesterday and noticed a similar pattern.
>> So I am interested in getting feedback on this too. And I can give at
>> least a partial answer.
>> 
>> Root clocks
>> -----------
>> 
>> The three CLK_TOP_CLKXXX clocks are in the devicetree as "fixed-clock"
>> with labels "clkXXx".
>> 
>> These should go in a separate group named "PAD" since they aren't
>> part of the TOPCKGEN group. And it would make sense to make the
>> macros CLK_PAD_CLKXXX.
>> 
>> Unless we should be reading these from devicetree somehow instead?
>
> I see now that this driver is using mt8188_id_offs_map to correct
> these issues, so the suggestion to rename to "PAD" is wrong. Don't
> do that.
>
> (Conceptually it made sense, but it doesn't match how the drivers
> are implemented for other mediatek clocks already.)

Ack.

>
>> 
>> PLL clocks
>> ----------
>> 
>> This is just a guess, but I suspect in Linux, since CLK_TOP_ADSPPL is
>> just a 1:1 divider clock of CLK_APMIXED_ADSPPLL, they took the shortcut
>> of leaving out CLK_TOP_ADSPPL from the clock tree and set the parent
>> of CLK_TOP_ADSPPLL_Dx to CLK_APMIXED_ADSPPLL instead of CLK_TOP_ADSPPLL.
>> 
>> The actual full picture should be like this:
>> 
>> 	77, /* CLK_TOP_ADSPPLL */
>> 
>> 	...
>> 
>> 	FACTOR0(CLK_TOP_ADSPPL, CLK_APMIXED_ADSPPLL, 1, 1),
>> 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_TOP_ADSPPL, 1, 2),
>> 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_TOP_ADSPPL, 1, 4),
>> 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_TOP_ADSPPL, 1, 8),
>> 
>> Instead of:
>> 	
>> 	-1, /* CLK_TOP_ADSPPLL */
>> 
>> 	...
>> 
>> 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
>> 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
>> 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),
>> 
>> So we could either follow Linux and use CLK_APMIXED_ADSPPLL everywhere
>> instead of adding CLK_TOP_ADSPPL. Or we could be more correct and add
>> the missing clocks.
>> 
>> The other PLL clocks seem to follow a similar pattern. So whatever we
>> do for ADSPPLL would apply to the others.
>> 
>> CK1 clocks
>> ----------
>> 
>> I can't see why these would be different from the same name without the
>> _CK1 suffix. There is already CLK_TOP_ULPOSC and CLK_TOP_ULPOSC1 and they
>> seem like they should be the same clocks.
>> 
>> Perhaps we could not add these?
>> 
>>>
>>> Could we (long term) add these definitions to the dt-bindings by
>>> contributing them to the kernel?
>> 
>
> Since these values are devicetree ABI, we unfortunately can't really
> fix them upstream. The problem is that the order matters, so we can't
> insert the missing values in the correct position and change all of
> the other numbers. We only get away with adding additional numbers
> here because we have mt8188_id_offs_map to workaround the problem.
>
> Most of these "missing" ones are only parent clocks of other clocks
> so wouldn't be used in the devicetree anyway. (Maybe they were skipped
> intentionally for that reason).

That is a little unfortunate but I understand.

Adding a more detailed comment next to the additional clock definitions
would be enough then. (In my opinion)


>
>
>> I guess it depends on if taking these PLL shortcuts was intentional or
>> not if upstream would want to add them or not. But clearly the PAD clocks
>> are fine they way they are upstream.
>> 
>>>
>>> Note: I'm not requesting to change this patch, I'm just curious as of
>>> why we need to add these definitions here.
>>>
>>> Note that I also don't see these CLKs in the linux driver so why are
>>> they needed for U-Boot ?
>> 
>> I have a feeling someone will be asking me the same question soon. :-)
>> 
>>> (I searched for CLK_TOP_CLK13M in Linux master commit e7c375b18160 ("Merge tag 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs"))
>>>
