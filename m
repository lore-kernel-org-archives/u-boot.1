Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF70CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 07:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3FA830A0;
	Wed, 10 Sep 2025 09:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NSDAcYQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447558319C; Wed, 10 Sep 2025 09:02:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8249D82B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 09:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e5190bca95so2491302f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757487734; x=1758092534; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uXFQa/A4Z2njAqlDfQQqJbyo9i5R92JyPVXXf1NnNmY=;
 b=NSDAcYQeyvMSbD1jn0CM5Pm2dc+YFXhQ+hPAh6a59YhNAwo7oUAnXOB3Dx6m71qhts
 Db0/cDvkvgLTbZILLuq6nQ62Gj3Zsisl5LIs4A6qcrR0JGoFf2drVKC8n+HQ3BxYwdOr
 VdM4j2GrkZC/5zBFye79oMplq26ZhIaa09SK/sAX7eec9WBIMa5g7+XSQf84sHnCdT8f
 SyzFia4qxrF1h4xPo7exHE+t6eC+MLX4jfqLIMdthG2yrugPXWK3IomjWbpoDju05l3U
 GR2pOSn64cJBtGc1DQTdzcTZW+iKuBP4zweCLRvyn4PvIG3xhLxIhxboikhJkD+WEDrC
 8M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757487734; x=1758092534;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uXFQa/A4Z2njAqlDfQQqJbyo9i5R92JyPVXXf1NnNmY=;
 b=o13vA6ZCQ/y51wR3AnQeurjPpMJDjgI5poNn6Z/n30/s4PYeq7W40KYgTwDLjbU5PU
 Q4tzX5Q0nLmTWc5Q0DDeoKIbKyUwUA3zXCMb1a2K6OFFgkaMhmUrt18iDJWS5UhmbnfO
 2LRRfAodrT3sLgEqeaf7JhwESx8tLuZDfc29Up9AOTinRtFWqcXRltEK2j34JUJ8PGZj
 LvJJW7d7vZkz9hfbcOwmE2b/DJCBB2TmeBeqAYKtBn6KbmJ0NgegwynADRww6B2LvpPR
 kDrSY5+I0QcId3qhZjm2bUdiv6YMpJ1Vq7a3ClYV+7cWHQsF1hzju+Yaf6L5skZ6RO7T
 VASg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTMYQQW7eeDWn0iKkeZ5QipOW15zWIoVTwnEfuh7s2E3xaSWIwg0odeuElyanoNwHaCe8gDoE=@lists.denx.de
X-Gm-Message-State: AOJu0YwDuXH9BxB9Used7dlUdDk+KfHl7qoeJj+YJmgCVSXB9eiYRXL2
 LUITlelMaHMzRpy4+O7YLDIkqGa5u7dy8kWOoMJTnYeviVTdCHQPhQds1Pefw5BgrTs=
X-Gm-Gg: ASbGncuMQAURL/LFI4jOy9bEEPSRtSbGl9ayc6hyeYtgDRxR86ubUwuSEZ+nMs0/R8F
 lEG12Lxbdj/1xSUtkmuaU/28WwtulWSKdkdZA0362Lj2PthZejksGu8KOWjFTK+7tJSCBKajpSN
 L6xEfsWC7FLMPkEV+zCkRn2GTf432oXuMAI7zjqptjgUMDGt189EW9AyAWMxb15hX2QNRQaKg+d
 YGnpwLvZOH9NNwl+v/Pog2iQ1szWfkocN6CDDQNrN+gm3bnOT63xXlHlufuX2KVSQjwK1ALjm+j
 sNZv3wRBtR9Kja4HzzGUR5LtoZTr0ldTaX62MnwfwQsBZ3awmnvebNyxJ+KXwXguEyl5gk1M46U
 VVC/xBU9QZgjXkjTDzWlfRbPBoAPn8yfkuuJKSe0M2+7MXM5sT/EfeZYFB73I0ifFaR2MT6oqCh
 w=
X-Google-Smtp-Source: AGHT+IE9ZavL/ztBraMd1QoIIpu3iaoc10nfyD+No9Yd2V9KFFWzsT/zLBMjFTulOS0v/bH9zvoOtA==
X-Received: by 2002:a5d:5f48:0:b0:3de:78c8:1223 with SMTP id
 ffacd0b85a97d-3e6440ef6cemr11833256f8f.31.1757487733841; 
 Wed, 10 Sep 2025 00:02:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2?
 ([2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7521bfdc6sm5544336f8f.8.2025.09.10.00.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 00:02:13 -0700 (PDT)
Message-ID: <c1012805-6f06-4855-be4e-6167409c80a0@linaro.org>
Date: Wed, 10 Sep 2025 09:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 5/9] arm: meson: initial u-boot SPL support for GX SoCs
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
 <b6d9c116-f37d-4793-ba53-f94ed95130dd@linaro.org>
 <DCNKQM04PWE0.35QSN1T1Z5CEZ@postmarketos.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <DCNKQM04PWE0.35QSN1T1Z5CEZ@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 08/09/2025 18:53, Ferass El Hafidi wrote:
> On Mon Sep 8, 2025 at 8:24 AM UTC, Neil Armstrong via groups.io wrote:
>> On 07/09/2025 16:36, Ferass El Hafidi wrote:
>>> Add initial boilerplate for U-Boot SPL support on Amlogic.
>>>
>>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>>> ---
>>>    arch/arm/include/asm/arch-meson/clock-gx.h |   1 +
>>>    arch/arm/include/asm/arch-meson/gx.h       |  36 ++++
>>>    arch/arm/mach-meson/Kconfig                |  42 ++++-
>>>    arch/arm/mach-meson/Makefile               |   5 +
>>>    arch/arm/mach-meson/board-common.c         |  11 ++
>>>    arch/arm/mach-meson/spl-gx.c               | 278 +++++++++++++++++++++++++++++
>>>    arch/arm/mach-meson/spl.c                  | 123 +++++++++++++
>>>    7 files changed, 495 insertions(+), 1 deletion(-)
>>>
>> <...>
>>> diff --git a/arch/arm/mach-meson/spl-gx.c b/arch/arm/mach-meson/spl-gx.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..65b301bc9ed89b7ca2156b7fa672ed4ef3f8633b
>>> --- /dev/null
>>> +++ b/arch/arm/mach-meson/spl-gx.c
>>> @@ -0,0 +1,278 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
>>> + * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
>>> + */
>>> +#include <hang.h>
>>> +#include <image.h>
>>> +#include <spl.h>
>>> +#include <vsprintf.h>
>>> +#include <asm/io.h>
>>> +#include <asm/arch/boot.h>
>>> +#include <asm/arch/clock-gx.h>
>>> +#include <asm/arch/gx.h>
>>> +#include <linux/delay.h>
>>> +
>>> +/* Meson GX SPL code */
>>> +
>>> +#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
>>> +#if defined(CONFIG_MESON_GXBB)
>>
>> I think you should indicate why it's only needed for GXBB
>>
> 
> Sure!  I will also explain here to clarify.
> Basically this is sending the SCP firmware (aka. bl30/bl301) to the SCP.
> Historically (in GXBB) this was done by bl2.bin, but (to save space?) it
> was moved to BL31 in GXL:
> 
> - https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a/+/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#129
> 
> and BL2 would give image info for bl30/bl301 to BL31.  I patched this
> upstream so we don't have to do that in SPL:
> 
> - https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a/+/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#105
> 
> Whether we can move SCP fw loading to BL31 on GXBB is .. an interesting
> thing that could be considered.  That way we could possibly also save
> some space in U-Boot SPL.
> 

Would be nice, but keep it as-is for now!

>>> +void meson_power_init(void)
>>> +{
>>> +	/* TODO: Support more voltages */
>>> +
>>> +	/* Init PWM B */
>>> +	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
>>> +
>>> +	/* Set voltage */
>>> +	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
>>> +		writel(0x02001a, GX_PWM_PWM_B);
>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
>>> +		writel(0x040018, GX_PWM_PWM_B);
>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
>>> +		writel(0x0e000e, GX_PWM_PWM_B);
>>> +
>>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
>>> +		clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
>>> +	} else {
>>> +		clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
>>> +		clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
>>> +	}
>>> +
>>> +	/* Init PWM D */
>>> +	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
>>> +
>>> +	/* Set voltage */
>>> +	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
>>> +		writel(0x040018, GX_PWM_PWM_B);
>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
>>> +		writel(0x0e000e, GX_PWM_PWM_B);
>>> +
>>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
>>> +		setbits_32(GX_PIN_MUX_REG3, 1 << 20);
>>> +	} else {
>>> +		clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
>>> +		setbits_32(GX_PIN_MUX_REG2, 1 << 12);
>>> +	}
>>> +}
>>
>> Seems much of the code is duplicated between GXBB and GXL, so I wonder if it would'nt
>> be cleaner to have spl-gxbb an spl-gxl ?
>>
> 
> You mean separate power init functions (meson_power_init_gxbb/gxl)?  Should be doable.


I mean even separate files, it would avoid any #ifdef stuff

Neil

> 
>> <...>
>>
>> Anyway it's really clean !
>>
>> Thanks!
>> Neil
>>
> 
> Thank you!
> 
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#2757): https://groups.io/g/u-boot-amlogic/message/2757
>> Mute This Topic: https://groups.io/mt/115113902/8399868
>> Group Owner: u-boot-amlogic+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [funderscore@postmarketos.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
> 

