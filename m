Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FBBEE14BC
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7798F86590;
	Wed,  6 Sep 2023 19:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lhzp8uvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A8F86407; Wed,  6 Sep 2023 19:26:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4411D86611
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B7CCC3F639
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694021210;
 bh=LJ7d5VBHDbIF0UrcYtIoHEwgeLOmtxP4fz4KOI+KYXo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=lhzp8uvs9kj5SyRnztbSMIdWYD/SY57OlLfzoT2t4eO5fGpRcFW5frw5a3EfnOceI
 dP9z6bJUzjFLxL88LfEeq7PT9931NUV1IQkP12rGZCsGxqLsZ3h2wHv2wd1Pv63iL0
 S9hef+WeOrTEmMWl7LHPgoAungPAfQu1e0GWlhHclxzC2QriwfeCYFbzeLPv84M9a1
 VGTa7ytlegWUOn7CNc81+Ff2etejg0hGHWns7jp9d1gwXMQljkxyXF/yUpxilpNbWi
 PGlDhSf+vjXBfF9c2HEVbkhrlVj2Norh+yjjFRX10qtnHvrFmXOc5UfvqePwmsMhSf
 XDDCHDlpPwDxQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31c470305cfso55135f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 10:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694021210; x=1694626010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJ7d5VBHDbIF0UrcYtIoHEwgeLOmtxP4fz4KOI+KYXo=;
 b=LdVI9HElDerEWthN/4BHVIKVJS7GY5PSBBGoSqSTTwcgT3sosOgJ+ipIQJc5sg261u
 Ik6FjhobcyYsOg5Wd1UIzQJ5UIpUdrVzsiYj4sZlTRd3HVJy5BjfnP1lwF4xl/x4QUJU
 rGZn/sbJbWf56QqIsCuw/Dw7pKJEHNj/+lYB11IJiC0fje8VFeJBslfoPu9wY/iKnDOp
 k+wDt9gOrtAhcubgvOG0Lo7MKcxNhmaa6ZRiNFdIyozClVY2IJgCtYLu4XTa22kyDc9S
 K0rArk9X8FjQV/AkK8iseJqySK5S2PIXvHb92lNDxOWY5PW4MbPKTWk0JlIf22Igvv2A
 mdMw==
X-Gm-Message-State: AOJu0YxYChP4FAapMINl0vInRF0enUtc7WBsYsu0eWbdivwEuSJhDa5W
 04OUgyR+w2+8SiHtCBxcmAxoUjiUs91UYNFd/SeStr9vXdo+Z//2gs5cvVKawCSTYwsJTE7EL6K
 oHqM7K2ALo6W942k5l22khMIbrZ7ABrs=
X-Received: by 2002:a5d:4538:0:b0:31c:e933:9590 with SMTP id
 j24-20020a5d4538000000b0031ce9339590mr2698308wra.33.1694021210372; 
 Wed, 06 Sep 2023 10:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAM9wjqj+eerhu9TngKhiomXxLBAsY1IWtPG9KjAnbJw9qV7VHKO9g/Blht63g8BUAm6m+Aw==
X-Received: by 2002:a5d:4538:0:b0:31c:e933:9590 with SMTP id
 j24-20020a5d4538000000b0031ce9339590mr2698292wra.33.1694021209930; 
 Wed, 06 Sep 2023 10:26:49 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 b11-20020adfee8b000000b0031aeca90e1fsm21097048wro.70.2023.09.06.10.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 10:26:49 -0700 (PDT)
Message-ID: <641ab172-256a-4d38-84d8-bdf871adddd1@canonical.com>
Date: Wed, 6 Sep 2023 19:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18@epcas2p2.samsung.com>
 <20230906051814.1393464-4-chanho61.park@samsung.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230906051814.1393464-4-chanho61.park@samsung.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 06.09.23 07:18, Chanho Park wrote:
> timer_get_boot_us function is required to record the boot stages as
> us-based timestamp.
> To get a micro-second time from a timer tick, this converts the
> formula like below to avoid zero result of (tick / rate) part.
> 
> From: time(us) = (tick / rate) * 10000000

Where is the old implementation that you refer to?

> To  : time(us) = (tick * 1000) / (rate / 1000)
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   drivers/timer/riscv_aclint_timer.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
> index e29d527c8d77..73fb87912851 100644
> --- a/drivers/timer/riscv_aclint_timer.c
> +++ b/drivers/timer/riscv_aclint_timer.c
> @@ -6,6 +6,7 @@
>   
>   #include <common.h>
>   #include <clk.h>
> +#include <div64.h>
>   #include <dm.h>
>   #include <timer.h>
>   #include <asm/io.h>
> @@ -44,6 +45,28 @@ u64 notrace timer_early_get_count(void)
>   }
>   #endif
>   
> +#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
> +ulong timer_get_boot_us(void)
> +{
> +	int ret;
> +	u64 ticks = 0;
> +	u32 rate;
> +
> +	ret = dm_timer_init();
> +	if (!ret) {
> +		rate = timer_get_rate(gd->timer);
> +		timer_get_count(gd->timer, &ticks);
> +	} else {
> +		rate = RISCV_MMODE_TIMER_FREQ;
> +		ticks = readq((void __iomem *)MTIME_REG(RISCV_MMODE_TIMERBASE,
> +							RISCV_MMODE_TIMEROFF));
> +	}
> +
> +	/* Below is converted from time(us) = (tick / rate) * 10000000 */
> +	return lldiv(ticks * 1000, (rate / 1000));

I found similar code in drivers/timer/cadence-ttc.c and 
drivers/timer/omap-timer.c with

     us = (ticks * 1000) / rate;
     return us.

Either their code or yours must be wrong.

What I am missing in include/timer.h is a documentation that defines if 
timer_dev_priv.clock_rate and timer_get_rate() yield the frequency in Hz 
or kHz.

Once we have added the missing information in the include we can start 
reviewing this patch.

I really dislike that we have code per architecture and don't update and 
use a implementation in lib/time.c (where we also have an 
implementation) or drivers/timer/timer-uclass.c. Can't we have a single 
implementation which is driver model based and eliminate all others?

Best regards

Heinrich

> +}
> +#endif
> +
>   static const struct timer_ops riscv_aclint_timer_ops = {
>   	.get_count = riscv_aclint_timer_get_count,
>   };

