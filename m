Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F3D43358
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 21:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB618835C6;
	Thu, 11 Dec 2025 22:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gXVGwyLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40838367F; Thu, 11 Dec 2025 18:55:56 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4753583642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 18:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4507605e19aso219933b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765475752; x=1766080552;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=snXnae9gBbIAkTyS58kiovHvLmpzyhytmEYoPQATCxc=;
 b=gXVGwyLf7anAtl7QO5/eKVYxKEwCCIbmrxdVi/API5H/eOcWnfFOQMsvpp6U0Yuc1i
 tvaKI8My5gQpRz+lxhiRy26jFLiPXv12dbqdNKWgXfNPq5Z+0h5rsR9/sit1qSYvcQPw
 URUYsOzJjG61Mnc//lGcgeUipRhIyrHj7bMref9vSXaceSWL3DnrnXKDjRziXlEQFKIT
 NUiY/oUQr4D8m8PGx4FcY/ixPEj6HL/qAHDnMaobAlmdgMiau0nWXCVLrsRxKXlwOa0V
 jDDMe8JodNHItoZNLZLNmxL1NG7DopPjtp5akWCimaEElrXCxveDvQQtAd3n1WrksVae
 g2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765475752; x=1766080552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=snXnae9gBbIAkTyS58kiovHvLmpzyhytmEYoPQATCxc=;
 b=LKMS493v2KTMRv5kCuuHkqWf+sewrhuoAiHHVDtix0ek4DZzxj69LGgppI9m7mOsyQ
 m/VkDgA/SMp1sSLfKb0b1G4Zs34+aPln5w5Lk+a5JjqnaIvX6TrS9x8jseP3yHgf/fvV
 BtPeSD7zQo52zSZ9TY2P0I8PmrtlZZiEP4q6Eno+Y36xRA+c8tHrIZUHak1J9yt4ivvj
 7Bhff3471fW7f4I+2dH4vxjafRh0WFQh6YjIzJERVeWdzYTJV7rEn63+yVUrHhLRpmrJ
 PauAGfZKz+CPqf0mDddUv/I2feO1EJ+/7dTfI6BgU3E92EUonDKZwXRQei8p7UufZ0+J
 k05Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKKRWFbX92Wtl162IFr2hkvfnng/46b5FNvSLObeP2inw90NqzmESvdXoqRSUWDujcneEwBAM=@lists.denx.de
X-Gm-Message-State: AOJu0YxAxl9wvU2TD8eqQriFKAHIedeP8cNujLu5zqoP5ynvkdrsa82V
 U2gF2WVOklcJ4gWDXAkh5Ow764de7BNmk+2t6j1hqNH5Zwe9VULOmVhuAPShBzZLssI=
X-Gm-Gg: AY/fxX5iH2J/DvYPkB6ORLpUtf8c+vY1lIVPagjmXJ5HhGr55U0I1Q3xqkpgxWUVywu
 iMa/NpAvVOfJ4TmsuAxGDEeGOa7MHBtTeFLKk0nUsRd0UcbEzcA4JxNiZh+wyGiMoCnbGgD4kmA
 3CrpaBCc5q0T3+RjvlUiMn/Sr9ftJWlY0fWJaWScc8p6UvYaW2kyLmDJbAXF9RxtcL7EcTU+GMr
 g6P3ZlKNYGu0h8dgux6WWwdOhCUE/q0/tsuMNuHMaga96Opqxr9baZabQmqGp4JUatEIVPt9UcV
 1H/mv3wdnAVIf6zl1U7ElpJ7D4ymAIpsMnIlqGThVilGm9rOd1Jq1FM67kvGnZoARAAwiBTuXAL
 r5dSdJNw9jv/YWnHa1LYeWKlwJ4/koExDuqQVKoOU/OvQJCjSseKc/6rH+xL1MbPC3RTOhbhDZL
 GZJipkatxXRESKS3MHAh5BYlczxO6p74dhehfgiGJNZKMzo+qQmShR+9GLyDZr
X-Google-Smtp-Source: AGHT+IERU5KoieLDWIw3zXY/GMfXUgCahki7DV9gBULe8DHSkwKKc9FhW01KaCx1pGiB6VNxvAiaSw==
X-Received: by 2002:a05:6808:1496:b0:44f:e7bd:274c with SMTP id
 5614622812f47-45586922b51mr3813624b6e.51.1765475752122; 
 Thu, 11 Dec 2025 09:55:52 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758?
 ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e868e6sm2096823fac.9.2025.12.11.09.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 09:55:51 -0800 (PST)
Message-ID: <6bf9671d-c70b-41ae-b8b0-ec303dfed484@baylibre.com>
Date: Thu, 11 Dec 2025 11:55:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: mediatek: add MT8188 clock driver
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <878qf95s5q.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 11 Dec 2025 22:20:27 +0100
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

On 12/11/25 2:39 AM, Mattijs Korpershoek wrote:
> Hi Julien,
> 
> Thank you for the patch.
> 
> On Tue, Dec 09, 2025 at 11:22, Julien Stephan <jstephan@baylibre.com> wrote:
> 
>> From: Julien Masson <jmasson@baylibre.com>
>>
>> The following clocks have been added for MT8188 SoC:
>> apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
>>
>> These clocks driver are based on the ones present in the kernel:
>> drivers/clk/mediatek/clk-mt8188-*
>>
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>  drivers/clk/mediatek/Makefile     |    1 +
>>  drivers/clk/mediatek/clk-mt8188.c | 1840 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 1841 insertions(+)
>>
>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>> index 12893687b68fc6c136a06e19305b1dd0c8a8101a..68b3d6e9610d8e7f4c4c625f52e525174e92787a 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_TARGET_MT7981) += clk-mt7981.o
>>  obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
>>  obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
>>  obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
>> +obj-$(CONFIG_TARGET_MT8188) += clk-mt8188.o
>>  obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
>>  obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
>>  obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
>> diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..55dfadddfe3cf743602533de30275bc93d4f15a5
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt8188.c
>> @@ -0,0 +1,1840 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MediaTek clock driver for MT8188 SoC
>> + *
>> + * Copyright (C) 2025 BayLibre, SAS
>> + * Copyright (c) 2025 MediaTek Inc.
>> + * Authors: Julien Masson <jmasson@baylibre.com>
>> + *          Garmin Chang <garmin.chang@mediatek.com>
>> + */
>> +
>> +#include <clk-uclass.h>
>> +#include <dm/device_compat.h>
>> +#include <dm.h>
>> +#include <asm/io.h>
>> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
>> +
>> +#include "clk-mtk.h"
>> +
>> +#define MT8188_PLL_FMAX		(3800UL * MHZ)
>> +#define MT8188_PLL_FMIN		(1500UL * MHZ)
>> +
>> +/* Missing topckgen clocks definition in dt-bindings */
>> +#define CLK_TOP_ADSPPLL		206
>> +#define CLK_TOP_CLK13M		207
>> +#define CLK_TOP_CLK26M		208
>> +#define CLK_TOP_CLK32K		209
>> +#define CLK_TOP_IMGPLL		210
>> +#define CLK_TOP_MSDCPLL		211
>> +#define CLK_TOP_ULPOSC1_CK1	212
>> +#define CLK_TOP_ULPOSC_CK1	213
> 
> Why are these clock definitions missing from the dt-bindings?
> Were they just forgotten, or is there another reason?

I was looking at mt8365 clocks yesterday and noticed a similar pattern.
So I am interested in getting feedback on this too. And I can give at
least a partial answer.

Root clocks
-----------

The three CLK_TOP_CLKXXX clocks are in the devicetree as "fixed-clock"
with labels "clkXXx".

These should go in a separate group named "PAD" since they aren't
part of the TOPCKGEN group. And it would make sense to make the
macros CLK_PAD_CLKXXX.

Unless we should be reading these from devicetree somehow instead?

PLL clocks
----------

This is just a guess, but I suspect in Linux, since CLK_TOP_ADSPPL is
just a 1:1 divider clock of CLK_APMIXED_ADSPPLL, they took the shortcut
of leaving out CLK_TOP_ADSPPL from the clock tree and set the parent
of CLK_TOP_ADSPPLL_Dx to CLK_APMIXED_ADSPPLL instead of CLK_TOP_ADSPPLL.

The actual full picture should be like this:

	77, /* CLK_TOP_ADSPPLL */

	...

	FACTOR0(CLK_TOP_ADSPPL, CLK_APMIXED_ADSPPLL, 1, 1),
	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_TOP_ADSPPL, 1, 2),
	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_TOP_ADSPPL, 1, 4),
	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_TOP_ADSPPL, 1, 8),

Instead of:
	
	-1, /* CLK_TOP_ADSPPLL */

	...

	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),

So we could either follow Linux and use CLK_APMIXED_ADSPPLL everywhere
instead of adding CLK_TOP_ADSPPL. Or we could be more correct and add
the missing clocks.

The other PLL clocks seem to follow a similar pattern. So whatever we
do for ADSPPLL would apply to the others.

CK1 clocks
----------

I can't see why these would be different from the same name without the
_CK1 suffix. There is already CLK_TOP_ULPOSC and CLK_TOP_ULPOSC1 and they
seem like they should be the same clocks.

Perhaps we could not add these?

> 
> Could we (long term) add these definitions to the dt-bindings by
> contributing them to the kernel?

I guess it depends on if taking these PLL shortcuts was intentional or
not if upstream would want to add them or not. But clearly the PAD clocks
are fine they way they are upstream.

> 
> Note: I'm not requesting to change this patch, I'm just curious as of
> why we need to add these definitions here.
> 
> Note that I also don't see these CLKs in the linux driver so why are
> they needed for U-Boot ?

I have a feeling someone will be asking me the same question soon. :-)

> (I searched for CLK_TOP_CLK13M in Linux master commit e7c375b18160 ("Merge tag 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs"))
> 
