Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9960ED49220
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD028307F;
	Fri, 12 Dec 2025 13:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2jcJr7gW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 082568334F; Fri, 12 Dec 2025 05:22:37 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B088334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 05:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45066bee74aso266013b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 20:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765513352; x=1766118152;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=girAkrg4IlD+rvW9jC1arK73UvUP5YtYzboOWxKNFX8=;
 b=2jcJr7gW0Ah1RE+08u6mMwPSTOUjOeNQBvwLzUmnHKqNDL/FJuzHkLvZoz2anfk2PS
 WsFd9je3x2PsDT/xpXIv2BhDkEARLdDZQHUoZxV8p42yAkdef/7ksd1eNxcDtUeh2Yce
 Urt7hcbe74/OO1r6/4y0Sv9H4/2PkkEbrRUbEfB3aice0fzftDWaESu+PdOJkiOq9Id5
 P0SKqx4k9zs1ZGOwMHAStidi86h2SETEVLR9CpQEPsuEYFeWhiqOrtOv6o46oAyl2uKU
 bkvIRmfL904WWCpktjhiottwMhR3p4IETNJo2yIJeHBF7NpE4Q41RuEcnNLST3D9H/Ng
 9vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765513352; x=1766118152;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=girAkrg4IlD+rvW9jC1arK73UvUP5YtYzboOWxKNFX8=;
 b=PFvw6Mt7N6msLFz6CPt97VPwR/07Dn6SQJYjxqgXmA2MQCSUJdAZhtGdH1Z2FAeAd6
 oEvkiaH6RSC0tmoZLXNPY8B3k2HGLh7A/lJ2P3T6nAVRdtm5SSn1Yn7EQUDSZeYTumZR
 7gH6CKHI2lTaJ/K2DEsAbQpoF233BNkR3Efim5S9zJahYnYIXI63Qs4oa1oR3QuBq5bN
 LNcNE25J9ovGjQ73DDOiCI/5HgekCH9+nn22CyGQcnlX0bJydh0Zyw5AcAjSo57tP3pO
 igqLE8d31O35WMzZSg3avKMwc8f+IhhGPchi6/D7E2pQd2VYpaPd5EucXBL71aM0mQA6
 2I8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2+zrpQIqdHPbnXOuWCtjie1Eq48syOhOSaSOFGp9mSiwi4cU0ivoYdRMW7ouH/1+wbDdqySs=@lists.denx.de
X-Gm-Message-State: AOJu0YxgWZYyRQXvjQ/ebDcMq10WOmtm4mZ8ngfGrHBGblkUC7wQuBxp
 UqyICw23itRKKIVK2uHCzLabt2g3yjdNv3Bz9D46W5G+DIWNP7TvXzKPPCQdK1ufWzc=
X-Gm-Gg: AY/fxX67ed16LeSO2PFKgn1GnjpVtyMAIyR5lWizCJvedRVS9+39Rld7srtF4onz7In
 Q0wYzjIw6vVMaXCC4Vw0yvg55KzPt8Xc/2vLhbQwU76cp1uNXCpRfjwUkRDRzNz5YsqtL+9gR1T
 s9oJpi2qWub0T7pSBTPoyb9HaD8D3izHUC9T5FgbkLdF1F1f33XohoYaDjUTalUXaAPIKpo6+rA
 3OSbe6/5Ni2dw7K1YyYUljjx7FomcWKLdycwnj9R834p9Rf1zEquF0aVjCYyC8cRX/lGZeU+0Xn
 CiyfPd592f2cjYtRrcTi5N6PNgunr4jM6iiI17VMzCLl0Jt+Q8Gk6tPyLLDW+/0Db01ztek1/IJ
 FPaFgQimfSXqA7XiWc3NrU79GLP5u+aUzrx3Pyjib+Lu0XUyeivqnyYjH27ILk7alQdmdmG4ypT
 ALyUp22N79AXsJeeL82FFT5ozgI/Cnl8i+UvxFYH+WoZEGk2xmxBADBMKSdsck
X-Google-Smtp-Source: AGHT+IF2KdXnMHB0VfmpzqWd0mwa3P/J53FwftEHviPLyYgqP6rDTUEBGbmIjpwyL7b7tiJIfjIa+g==
X-Received: by 2002:a05:6808:2221:b0:450:b8a2:47a5 with SMTP id
 5614622812f47-455aca60a49mr268955b6e.67.1765513352492; 
 Thu, 11 Dec 2025 20:22:32 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758?
 ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe55e4a6sm227636fac.19.2025.12.11.20.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 20:22:30 -0800 (PST)
Message-ID: <67fdf8ce-41af-4609-a754-8041a4e716dc@baylibre.com>
Date: Thu, 11 Dec 2025 22:22:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: mediatek: add MT8188 clock driver
From: David Lechner <dlechner@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, Ian Roberts <ian.roberts@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heiko Schocher <hs@nabladev.com>, =?UTF-8?Q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
 <20251209-add-mt8188-support-v2-2-31dbfcf7303c@baylibre.com>
 <878qf95s5q.fsf@kernel.org>
 <6bf9671d-c70b-41ae-b8b0-ec303dfed484@baylibre.com>
Content-Language: en-US
In-Reply-To: <6bf9671d-c70b-41ae-b8b0-ec303dfed484@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 12 Dec 2025 13:49:05 +0100
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

On 12/11/25 11:55 AM, David Lechner wrote:
> On 12/11/25 2:39 AM, Mattijs Korpershoek wrote:
>> Hi Julien,
>>
>> Thank you for the patch.
>>
>> On Tue, Dec 09, 2025 at 11:22, Julien Stephan <jstephan@baylibre.com> wrote:
>>
>>> From: Julien Masson <jmasson@baylibre.com>
>>>
>>> The following clocks have been added for MT8188 SoC:
>>> apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
>>>
>>> These clocks driver are based on the ones present in the kernel:
>>> drivers/clk/mediatek/clk-mt8188-*
>>>
>>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>> ---
>>>  drivers/clk/mediatek/Makefile     |    1 +
>>>  drivers/clk/mediatek/clk-mt8188.c | 1840 +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 1841 insertions(+)
>>>
>>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>>> index 12893687b68fc6c136a06e19305b1dd0c8a8101a..68b3d6e9610d8e7f4c4c625f52e525174e92787a 100644
>>> --- a/drivers/clk/mediatek/Makefile
>>> +++ b/drivers/clk/mediatek/Makefile
>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_TARGET_MT7981) += clk-mt7981.o
>>>  obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
>>>  obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
>>>  obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
>>> +obj-$(CONFIG_TARGET_MT8188) += clk-mt8188.o
>>>  obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
>>>  obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
>>>  obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
>>> diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..55dfadddfe3cf743602533de30275bc93d4f15a5
>>> --- /dev/null
>>> +++ b/drivers/clk/mediatek/clk-mt8188.c
>>> @@ -0,0 +1,1840 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * MediaTek clock driver for MT8188 SoC
>>> + *
>>> + * Copyright (C) 2025 BayLibre, SAS
>>> + * Copyright (c) 2025 MediaTek Inc.
>>> + * Authors: Julien Masson <jmasson@baylibre.com>
>>> + *          Garmin Chang <garmin.chang@mediatek.com>
>>> + */
>>> +
>>> +#include <clk-uclass.h>
>>> +#include <dm/device_compat.h>
>>> +#include <dm.h>
>>> +#include <asm/io.h>
>>> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
>>> +
>>> +#include "clk-mtk.h"
>>> +
>>> +#define MT8188_PLL_FMAX		(3800UL * MHZ)
>>> +#define MT8188_PLL_FMIN		(1500UL * MHZ)
>>> +
>>> +/* Missing topckgen clocks definition in dt-bindings */
>>> +#define CLK_TOP_ADSPPLL		206
>>> +#define CLK_TOP_CLK13M		207
>>> +#define CLK_TOP_CLK26M		208
>>> +#define CLK_TOP_CLK32K		209
>>> +#define CLK_TOP_IMGPLL		210
>>> +#define CLK_TOP_MSDCPLL		211
>>> +#define CLK_TOP_ULPOSC1_CK1	212
>>> +#define CLK_TOP_ULPOSC_CK1	213
>>
>> Why are these clock definitions missing from the dt-bindings?
>> Were they just forgotten, or is there another reason?

It took me all day, but I learned some more. So some of what I wrote
below is wrong.

> 
> I was looking at mt8365 clocks yesterday and noticed a similar pattern.
> So I am interested in getting feedback on this too. And I can give at
> least a partial answer.
> 
> Root clocks
> -----------
> 
> The three CLK_TOP_CLKXXX clocks are in the devicetree as "fixed-clock"
> with labels "clkXXx".
> 
> These should go in a separate group named "PAD" since they aren't
> part of the TOPCKGEN group. And it would make sense to make the
> macros CLK_PAD_CLKXXX.
> 
> Unless we should be reading these from devicetree somehow instead?

I see now that this driver is using mt8188_id_offs_map to correct
these issues, so the suggestion to rename to "PAD" is wrong. Don't
do that.

(Conceptually it made sense, but it doesn't match how the drivers
are implemented for other mediatek clocks already.)

> 
> PLL clocks
> ----------
> 
> This is just a guess, but I suspect in Linux, since CLK_TOP_ADSPPL is
> just a 1:1 divider clock of CLK_APMIXED_ADSPPLL, they took the shortcut
> of leaving out CLK_TOP_ADSPPL from the clock tree and set the parent
> of CLK_TOP_ADSPPLL_Dx to CLK_APMIXED_ADSPPLL instead of CLK_TOP_ADSPPLL.
> 
> The actual full picture should be like this:
> 
> 	77, /* CLK_TOP_ADSPPLL */
> 
> 	...
> 
> 	FACTOR0(CLK_TOP_ADSPPL, CLK_APMIXED_ADSPPLL, 1, 1),
> 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_TOP_ADSPPL, 1, 2),
> 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_TOP_ADSPPL, 1, 4),
> 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_TOP_ADSPPL, 1, 8),
> 
> Instead of:
> 	
> 	-1, /* CLK_TOP_ADSPPLL */
> 
> 	...
> 
> 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
> 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
> 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),
> 
> So we could either follow Linux and use CLK_APMIXED_ADSPPLL everywhere
> instead of adding CLK_TOP_ADSPPL. Or we could be more correct and add
> the missing clocks.
> 
> The other PLL clocks seem to follow a similar pattern. So whatever we
> do for ADSPPLL would apply to the others.
> 
> CK1 clocks
> ----------
> 
> I can't see why these would be different from the same name without the
> _CK1 suffix. There is already CLK_TOP_ULPOSC and CLK_TOP_ULPOSC1 and they
> seem like they should be the same clocks.
> 
> Perhaps we could not add these?
> 
>>
>> Could we (long term) add these definitions to the dt-bindings by
>> contributing them to the kernel?
> 

Since these values are devicetree ABI, we unfortunately can't really
fix them upstream. The problem is that the order matters, so we can't
insert the missing values in the correct position and change all of
the other numbers. We only get away with adding additional numbers
here because we have mt8188_id_offs_map to workaround the problem.

Most of these "missing" ones are only parent clocks of other clocks
so wouldn't be used in the devicetree anyway. (Maybe they were skipped
intentionally for that reason).


> I guess it depends on if taking these PLL shortcuts was intentional or
> not if upstream would want to add them or not. But clearly the PAD clocks
> are fine they way they are upstream.
> 
>>
>> Note: I'm not requesting to change this patch, I'm just curious as of
>> why we need to add these definitions here.
>>
>> Note that I also don't see these CLKs in the linux driver so why are
>> they needed for U-Boot ?
> 
> I have a feeling someone will be asking me the same question soon. :-)
> 
>> (I searched for CLK_TOP_CLK13M in Linux master commit e7c375b18160 ("Merge tag 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs"))
>>

