Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E244DC52D6F
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 18:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7229288CE1;
	Sat,  3 Aug 2024 20:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KaL+88xO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1DB88C45; Sat,  3 Aug 2024 15:17:32 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B138D88765
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 15:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52f01afa11cso13489640e87.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722691050; x=1723295850; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TjzCxN7QX7A7Fdp5rXu/tHFcPV/kLDqrzhHdDqlW1oU=;
 b=KaL+88xO1fSCF4OlBXjksYfS1wkAGv5VMgBrjAtV9msVVwY4BwhAgT7+UK65C6vpR6
 UvUUuTNIiykKFEYgbVWpS2LnEhLuXBFuBrsbKqdhiJpISKV+u6XklL80QjtRZU38zILX
 Oa87H/hEUrSDDl4FaHjzEy2c9CGsx64sL6bfc9UzcCjOpsfolklLtNPYz4P5K35wens0
 Vl75LGH7xzMQiChECtJsRIhhBHU5xSR3IvFVWXamOtLU78kipSk4+ojveHyA4BpWi30x
 1WA0ZmVUcmkOi+x9k9tU3zGeixW16QTjJbKYH5xWRDv5VRsoXnEmwchUtQe5NCip+rWo
 Uk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722691050; x=1723295850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TjzCxN7QX7A7Fdp5rXu/tHFcPV/kLDqrzhHdDqlW1oU=;
 b=tb/dqqT43ombA62ESph5cdQ3/IvMaiMn8ffudaoMA9cNIofmVHxdr6Hy4DmgfOlAFh
 VFzpsMdKUfc1CP1EAaTmkXp/9Pecaa3j0iJYwufSn2KZaRpM1gpLOx1BGWvOUIL2lEyD
 HaiOJofXJ7RpDlahRdYNdxR4aYO1QcQ6IzvpuI4utYbKbWjos30Ad4dJsMEkHlBOoFW+
 OEcD+wi98IPJnU/LLqIPO3FJmFyRWa1l7x3jdYUY7HNbvH18kwx61yYYGpN5w3tRnHHL
 nYdR8rxnHiult60Y8giuSRSUi8ft3IYICis9KRdCe83t044tkH+Cg8pirb8L9GY/AxzR
 EhbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTznBcb1aDdN2HnmS9fQYLo/zGMRxjTenl7xfaOke1Iq2hpMdFhfs3LfS8oo82ttU48y+R3LY=@lists.denx.de
X-Gm-Message-State: AOJu0YyhLO5oaYc/86VYLacIq5/xhl2CHi3ceGT/a5DD9v0NyV5pDbz+
 Bc5n4n+zEaHexSQUJyDBURWk95AmqRgdZ5dfFzzwWUNX512Q3Z79
X-Google-Smtp-Source: AGHT+IEfPb3oofN+6VYor6bbfO8lfJCTvlO8LvaMOxpEAns53vDrjA/DsBuHndaVnd11IwJVT9F3kA==
X-Received: by 2002:a05:6512:3041:b0:52c:cc38:592c with SMTP id
 2adb3069b0e04-530bb30790emr4074168e87.0.1722691049479; 
 Sat, 03 Aug 2024 06:17:29 -0700 (PDT)
Received: from [192.168.99.248] ([94.143.198.76])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-530bba3cbb5sm503174e87.252.2024.08.03.06.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Aug 2024 06:17:29 -0700 (PDT)
Message-ID: <4c003cab-c8b8-484d-924d-084e71fe666e@gmail.com>
Date: Sat, 3 Aug 2024 16:17:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] sunxi: H616: dram: LPDDR3: adjust settings
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20240801225519.336667-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 03 Aug 2024 20:55:08 +0200
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

On 02.08.2024 01:55, Chris Morgan wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Adjust H616 LPDDR3 DRAM settings to be in line with vendor driver.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-sunxi/dram_sun50i_h616.c         | 2 +-
>   arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 37c139e0ee..a20264d8b4 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -945,7 +945,7 @@ static bool mctl_phy_init(const struct dram_para *para,
>   		val = para->tpr6 & 0xff;
>   		break;
>   	case SUNXI_DRAM_TYPE_LPDDR3:
> -		val = para->tpr6 >> 8 & 0xff;
> +		val = para->tpr6 >> 16 & 0xff;

This is the correct change to match the factory tpr6 parameters.

I think, we also need to change the default value in 
arch/arm/mach-sunxi/Kconfig:

from: config DRAM_SUN50I_H616_TPR6
hex "H616 DRAM TPR6 parameter"
default 0x3300c080
to
default 0x33c00080

>   		break;
>   	case SUNXI_DRAM_TYPE_LPDDR4:
>   		val = para->tpr6 >> 24 & 0xff;
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> index ce2ffa7a02..82b86084a6 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> @@ -24,8 +24,8 @@ void mctl_set_timing_params(const struct dram_para *para)
>   	u8 trrd		= max(ns_to_t(6), 4);
>   	u8 trcd		= ns_to_t(24);
>   	u8 trc		= ns_to_t(70);
> -	u8 txp		= max(ns_to_t(8), 3);
>   	u8 trtp		= max(ns_to_t(8), 2);
> +	u8 txp		= trtp;

I think Jernejchanged this value using RE. I checked the 047fb104 
register (dramtmg[1])

on my t98-h2b-lp3 tvbox, it has not changed and is the same as the 
factory value.

=> md.l 0x47fb100
047fb100: 10141811 0004041c 04070d0d 0050500c .............PP.

