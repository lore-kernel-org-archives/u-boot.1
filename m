Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9E2CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 04:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD8F86BF2;
	Wed, 11 Oct 2023 06:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JpoYnDhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEAB86B6D; Wed, 11 Oct 2023 06:43:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A1586C5E
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 06:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DEA563FA69
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 04:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696999395;
 bh=eRmaBQ1+XQYVQ/k6A7bhmAWdon51mlk2sjqliDkZRug=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=JpoYnDhHspB7nlbFJHcv0awik7r0yhp+WdQA83DsDTpa3zlL9lWmiYMY+htQz6D9Z
 vTnxF6VTqhFXkm+oHLeXpM9wLI9xx7mdsvIQpFFrYfr3Ce0uV5V6VNvIXEReDihpVT
 M0jeOrYx0yyfopwPSVaw1Eag6Ok1i1Ro1SZgEz4a1Fa0c/pTAtUTajNiP1GyUt02Xz
 AdhWMHef69gyrTnFWAViYtkZCvW9YcWUZqy7FngQXBK+0oOCrsRscwfe6UQTySdlT+
 GRKZoe2TqrSBHEOdux+HVXDs9SHrbFINdYPcYnSbB6I/DH0fdbkENf9ZdLri2Ic9e3
 OOToX6chCtGew==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso4736632f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 21:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696999393; x=1697604193;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eRmaBQ1+XQYVQ/k6A7bhmAWdon51mlk2sjqliDkZRug=;
 b=I7P9ebcWl3VqzQnSe2gQFu4bBx2cxw2pF3s+rDtxp+9591lxgmAGTZ0GElG9anQKkC
 LfWDxz4uaLKY9tH+6BjthhKLp1iT2ArvrslTPA/K/jX/PDuN0O44dLRUwfWVajpMI/F1
 SVtncOJ5Cc3z3jXStzPXon9Rqd1bF68r+1XkHJI166fP0uFE9X2deUSWwXEkrFTajnVQ
 6hqF411TC5tAMPgkM+7BsH5FIYC1MYp9E6U9CYgTo3gBUR4Lh+eWK6QaGnaQu8/R8jYG
 2N16LPvyW+9fMbcJFxk12ihdyxJbaR4eR9pHVY1yIH0TWHr5wMeCV8Ww+mv92f7dsrZf
 HMAQ==
X-Gm-Message-State: AOJu0YwXKPvolUp6GXL5goTydoZFv2xZAfqx16CvG0+9vhmcBjUylD/b
 yVQiAjadWOJmGaDtMi4/ZTvVcU2V6ct8DyR8bWrRGWavfHDV+UZcjz+WtTg9ez3zmM/l3VoUXg0
 o9okfnW7iNUJ254kqaY8ivRWVHxFQWWg=
X-Received: by 2002:a5d:4cc3:0:b0:321:634d:d01c with SMTP id
 c3-20020a5d4cc3000000b00321634dd01cmr16083838wrt.33.1696999393258; 
 Tue, 10 Oct 2023 21:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvBRyFQiieg3uo53Z3F3ChF4aVduFwid/VST8Ptw3lmXAZLzYizh3lSnit0/n2hM+mMET4A==
X-Received: by 2002:a5d:4cc3:0:b0:321:634d:d01c with SMTP id
 c3-20020a5d4cc3000000b00321634dd01cmr16083825wrt.33.1696999392885; 
 Tue, 10 Oct 2023 21:43:12 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 m15-20020adfe94f000000b0031984b370f2sm14203501wrn.47.2023.10.10.21.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 21:43:12 -0700 (PDT)
Message-ID: <879935ce-43f6-418b-9787-7d78cd04d9a0@canonical.com>
Date: Wed, 11 Oct 2023 06:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] ram: starfive: Read memory size information from
 EEPROM
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heiko Schocher <hs@denx.de>, Emil Renner Berthing <kernel@esmil.dk>
References: <20230615093652.23161-11-yanhong.wang@starfivetech.com>
 <a62045f4-9f1e-4f53-82f7-587b36a037f7@canonical.com>
In-Reply-To: <a62045f4-9f1e-4f53-82f7-587b36a037f7@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11.10.23 04:54, Heinrich Schuchardt wrote:
> On 15.06.23 11:36, Yanhong Wang wrote:
>> StarFive VisionFive 2 has two versions, 1.2A and 1.3B, each version of
>> DDR capacity includes 2G/4G/8G, a DT can not support multiple
>> capacities, so the capacity size information is recorded to EEPROM, when
>> DDR initialization required capacity size information is read from
>> EEPROM.
>>
>> If there is no information in EEPROM, it is initialized with the default
>> size defined in DT.
>>
>> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
>> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
>> ---
>>   arch/riscv/cpu/jh7110/spl.c         | 32 ++++++++++++++++++++++++++++-
>>   drivers/ram/starfive/starfive_ddr.c |  2 --
>>   2 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
>> index 104f0fe949..72adcefa0e 100644
>> --- a/arch/riscv/cpu/jh7110/spl.c
>> +++ b/arch/riscv/cpu/jh7110/spl.c
>> @@ -3,19 +3,49 @@
>>    * Copyright (C) 2022 StarFive Technology Co., Ltd.
>>    * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
>>    */
>> -
>> +#include <common.h>
>> +#include <asm/arch/eeprom.h>
>>   #include <asm/csr.h>
>>   #include <asm/sections.h>
>>   #include <dm.h>
>> +#include <linux/sizes.h>
>>   #include <log.h>
>> +#include <init.h>
>>   #define CSR_U74_FEATURE_DISABLE    0x7c1
>>   #define L2_LIM_MEM_END    0x81FFFFFUL
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +static bool check_ddr_size(phys_size_t size)
>> +{
>> +    switch (size) {
>> +    case SZ_2:
>> +    case SZ_4:
>> +    case SZ_8:
>> +    case SZ_16:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>>   int spl_soc_init(void)
>>   {
>>       int ret;
>>       struct udevice *dev;
>> +    phys_size_t size;
>> +
>> +    ret = fdtdec_setup_mem_size_base();
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Read the definition of the DDR size from eeprom, and if not,
>> +     * use the definition in DT
>> +     */
>> +    size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;
> 
> On origin/master for a 4 GiB board with a serial number 
> VF7110B1-2253-D004E000-4000xxxx this always fails. This results in 
> memory reported as 8 GiB and Linux crashing.
> 
> i2c_get_chip_for_busnum() returns -EINVAL in read_eeprom() 
> [board/starfive/visionfive2/visionfive2-i2c-eeprom.c:335].
> 
> Is the driver model really expected to be fully initialized before 
> setting up memory?
> 
> Best regards
> 
> Heinrich

The root cause seems to be in dw_i2c_calc_timing(). Probing of the 
i2c_designware device fails with:

dw_i2c: mode 0, ic_clk 1000000, speed 100000, period 10 rise 1 fall 1 
tlow 5 thigh 4 spk 0
dw_i2c: bad counts. hcnt = -4 lcnt = 4
device_probe: i2c@12050000 failed to probe -22

When I change the hcnt timing calculation, by replacing the offset of 7 
to 1, the device is probed correctly and I get the correct memory size 
for my board.

Best regards

Heinrich


> 
>> +    if (check_ddr_size(size))
>> +        gd->ram_size = size << 30;
>>       /* DDR init */
>>       ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>> diff --git a/drivers/ram/starfive/starfive_ddr.c 
>> b/drivers/ram/starfive/starfive_ddr.c
>> index 553f2ce6f4..a0a3d6b33d 100644
>> --- a/drivers/ram/starfive/starfive_ddr.c
>> +++ b/drivers/ram/starfive/starfive_ddr.c
>> @@ -72,8 +72,6 @@ static int starfive_ddr_probe(struct udevice *dev)
>>       u64 rate;
>>       int ret;
>> -    /* Read memory base and size from DT */
>> -    fdtdec_setup_mem_size_base();
>>       priv->info.base = gd->ram_base;
>>       priv->info.size = gd->ram_size;
> 

