Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C61C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C74B686538;
	Tue, 24 Oct 2023 20:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p9SpjAeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B0586BA4; Tue, 24 Oct 2023 20:10:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01F8803AC
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40859c466efso26953305e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698171008; x=1698775808; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0M9vvBTWlUsUtqVaSVw8otJ+YW0mTjuWR1B9FtL+47k=;
 b=p9SpjAeH6h34Ml18GyGTGOWS8T+5mE9JWfUpf2R1PgK0tsU2MulR9MtG3GkILBeb9F
 9+QiG/k3IRIUlJbxXVTnwTS6Ub9dSzFh2IU0NBt89Q2iaONHBTyIoffGR5ExdJSQ70cx
 iQXvNz4GONlRvEglaWctGWlf/GOcln5c5a/XOSS543bxvAEgdT5wIpmGA4Q50TnGf+1J
 QZrE58BU+8O2UCD+3VZNwc3ehH8KM3oHmgI6kRTab4uWEQgWnKVfUwywvhQ+RPI9K9wL
 aomFxAW4ZFXBbuhz14TT3HM3sv0sxgS4X5E/Zq0MWO5Vmesv38XM2qNBuMYpaK/OvCTa
 ZrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698171008; x=1698775808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0M9vvBTWlUsUtqVaSVw8otJ+YW0mTjuWR1B9FtL+47k=;
 b=XU3ZwdrmuoQzu96kMyhxQFKfexmXx5X1PA+Ik0JmewByK71QYuFSkLEuVhO7TNDNfY
 4wAXitcQlgn2iG8ZdPMSoLlwyC5I2h743rcIA9Pq7aaqlIDEbyCt2xyr49tBmoYvGExB
 q3miwWf+sg7VTdkoHdAZSso72JZ8/GA4WMqXTmnWbIJzc0b4WqPrM6oIsXt0Udgs023t
 BOeUcJsN/uK2WJ7Tow9vKHVy9ojl/qqFhERwLCK5TEbSFpyEg6tAv2XCa0agW9tKG39W
 WtmfUsI6Z3L10y+FzsGHrnkhH7iN4jXuidBDoKcic4ECXAgLhvfh+5BDwZU2Y25NscMU
 x/3A==
X-Gm-Message-State: AOJu0YxrZYHglp/TnafFh1smUx8RHOfSPnegG3phYDG5vfDTvYMRB1h3
 XS6DFeL7DAAI7b+UAf9Xvprfvw==
X-Google-Smtp-Source: AGHT+IEO5XXaLKsZyxSLH6oQ7uWUCRTmB3fvlx63MNytUc3bX+K/+fdieUPS6FEKMkuFZ/vvF8GrVw==
X-Received: by 2002:a05:600c:548d:b0:409:136:469f with SMTP id
 iv13-20020a05600c548d00b004090136469fmr5548966wmb.38.1698171007991; 
 Tue, 24 Oct 2023 11:10:07 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b004053a6b8c41sm12594723wmq.12.2023.10.24.11.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 11:10:07 -0700 (PDT)
Message-ID: <df7c8647-abfe-43a8-869d-6a570a109f9c@linaro.org>
Date: Tue, 24 Oct 2023 19:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
 <CAPnjgZ3mcyST+6dLk1r=cXwQDFT1CNAfOXXfbMaSFGt+HqCiCg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ3mcyST+6dLk1r=cXwQDFT1CNAfOXXfbMaSFGt+HqCiCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 24/10/2023 19:03, Simon Glass wrote:
> Hi Caleb,
> 
> On Tue, 24 Oct 2023 at 04:32, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Add a new config option to allow u-boot to reuse the FDT provided by the
> 
> U-Boot (please fix throughout)

Will do!
> 
>> previous stage bootloader when available.
>>
>> On some boards the previous stage bootloader can populate
>> platform-specific parts of the devicetree such as the memory node, this
>> allows us to avoid hardcoding it in u-boot and instead determine it
>> dynamically at runtime.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> This patch will improve generic support for Qualcomm boards by enabling
>> us to configure the memory map at runtime rather than having hardcoded
>> maps on a per-device basis. I've gone for this approach initially to try
>> and avoid introducing board specific code where possible, but I'm happy
>> to rework this into mach-snapdragon if that's preferred.
> 
> Do you think it could use bloblist instead? I did send a patch to use
> the FDT in the bloblist:

If it would require changes to the previous stage bootloader then
unfortunately not. We're mostly stuck with the behaviour that we've got
for now...

This mechanism of retrieving the DTB is also used on the apple M1 I
think, and any other board where we're booting U-Boot as a drop-in for
the kernel on arm64.
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20230926141514.2101787-40-sjg@chromium.org/
> 
> Regards,
> Simon
> 
>> ---
>> base-commit: e65b5d35c9116485366bb08138043d51220551da
>>
>> // Caleb (they/them)
>> ---
>>  arch/arm/lib/save_prev_bl_data.c |  7 +++++++
>>  boot/Kconfig                     | 10 ++++++++++
>>  include/init.h                   |  9 +++++++++
>>  lib/fdtdec.c                     |  7 ++++++-
>>  4 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
>> index f7b23faf0d66..b0608502535e 100644
>> --- a/arch/arm/lib/save_prev_bl_data.c
>> +++ b/arch/arm/lib/save_prev_bl_data.c
>> @@ -45,6 +45,13 @@ bool is_addr_accessible(phys_addr_t addr)
>>         return false;
>>  }
>>
>> +phys_addr_t get_prev_bl_fdt_addr(void)
>> +{
>> +       if (!is_addr_accessible((phys_addr_t)reg0))
>> +               return 0;
>> +       return reg0;
>> +}
>> +
>>  int save_prev_bl_data(void)
>>  {
>>         struct fdt_header *fdt_blob;
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index a01e6cb8aafe..c127ba254589 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -1599,6 +1599,16 @@ config SAVE_PREV_BL_INITRAMFS_START_ADDR
>>           If no initramfs was provided by previous bootloader, no env variables
>>           will be created.
>>
>> +config USE_PREV_BL_FDT
>> +       depends on SAVE_PREV_BL_FDT_ADDR && !OF_BOARD
>> +       bool "Use the FDT provided by the previous stage bootloader"
>> +       help
>> +         When u-boot is chain-loaded from a previous bootloader, enable this option
>> +         to use the FDT provided by the previous bootloader instead of any built-in
>> +         to u-boot.
>> +
>> +         If no FDT was available, u-boot will fall back to its internal FDT.
>> +
>>  menu "Configuration editor"
>>
>>  config CEDIT
>> diff --git a/include/init.h b/include/init.h
>> index 4e7fe26c2004..58604cd98758 100644
>> --- a/include/init.h
>> +++ b/include/init.h
>> @@ -168,6 +168,15 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
>>   * Return: 0 if ok; -ENODATA on error
>>   */
>>  int save_prev_bl_data(void);
>> +
>> +/**
>> + * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
>> + * of the FDT passed by the previous bootloader.
>> + *
>> + * Return: the address of the FDT passed by the previous bootloader
>> + * or 0 if not found.
>> + */
>> +phys_addr_t get_prev_bl_fdt_addr(void);
>>  #endif
>>
>>  /**
>> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
>> index 7a6916764835..85425f2dc1ee 100644
>> --- a/lib/fdtdec.c
>> +++ b/lib/fdtdec.c
>> @@ -1222,7 +1222,7 @@ static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
>>   */
>>  static void *fdt_find_separate(void)
>>  {
>> -       void *fdt_blob = NULL;
>> +       void *fdt_blob = NULL, *prevbl_fdt_blob;
>>
>>         if (IS_ENABLED(CONFIG_SANDBOX))
>>                 return NULL;
>> @@ -1234,6 +1234,11 @@ static void *fdt_find_separate(void)
>>         else
>>                 fdt_blob = (ulong *)__bss_end;
>>  #else
>> +#if defined(CONFIG_USE_PREV_BL_FDT)
>> +       prevbl_fdt_blob = (void *)get_prev_bl_fdt_addr();
>> +       if (prevbl_fdt_blob)
>> +               return prevbl_fdt_blob;
>> +#endif
>>         /* FDT is at end of image */
>>         fdt_blob = (ulong *)_end;
>>
>>
> 
> Regards,
> SImon

-- 
// Caleb (they/them)
