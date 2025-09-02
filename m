Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271D9CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 22:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFBD832AD;
	Wed,  3 Sep 2025 00:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rDIp8kfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA92833D1; Wed,  3 Sep 2025 00:18:35 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA1C83253
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 00:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2448B3F52A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 22:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756851513;
 bh=CpTm1KuBGKD1g/kZIuql9KnaaFW2/JNQYzZXrgmn01E=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=rDIp8kfW5A0/pjNFZu8U+jKxUchl4wkigx7JduxTqkq7nfzD7n9Scf5G0Qkc7Uju3
 NO9Sd/SX18LkAywBY2zOxhlKe+i9b+Ohg/q02a7mIjjRMiqKzfJ5EG+/935kf+pjBj
 eKauHJ6nDOAMawfMtuVB2PqppXOhxRwNoaeVU1ojpVvAVyBwEqhBBgJ+a0C2/+QIBk
 YCkI3kZkPPGLJX1/evaxIOZPN0BA9HnZNKZkyDoUMEzb5Bqdr9y/+emSSRo/vK35+5
 Rucq91q+22krQmUqFm5l47diURDNnjTDl+6ipTpSHSKtnFWgXEOL0HoRBsAHsmSjwC
 gFLAZpW90/i/w==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b8af0b8deso15579935e9.0
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 15:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756851512; x=1757456312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CpTm1KuBGKD1g/kZIuql9KnaaFW2/JNQYzZXrgmn01E=;
 b=PzEpIIKax0stY1HaONg2n6+Ph+CGYLGeVoVv3xT6ArERs7C9YbEIMz0IGyX0s0Qwte
 jQb/lrw7pEoLfclkzSao5lIULx72FRXRbhFCRt7DpZPYZAUrsQLBXaD/u331Z9qhZeea
 443G+uiPl15mNb623L6UJr04c/D3XZofbf1pl+2Lr+deE3lam39dNWUao9h8rFF2x6Q/
 Bw9mk/OMo205rX9ebuCmiJtTcsmoVnH5/8AtrrGb22usdeTpHVfzp6fgKLIMyD2TXW6N
 AePEWduOpSo1MRCkSvbJ3XDz9UEJu66c+gHTB1VEtPQd3/9ZzR2UfEcEC/LwZ/hGELNh
 1O7Q==
X-Gm-Message-State: AOJu0YwI/jqY4sqd4LJ3BzWJuhVSQ5nOhHd2RFATS6oAERiqRFw+DYX8
 KFJGEe/18Jt1MZ2TanB/IpbPxJ4qeMLODwEejxdyAJBzY+D9psBM7C4vu1xwEx2Y7zz5IYFsgng
 r332j9PvMm3bmjjEz0Ttc2Mm/3odB2igBooH2MLpdA1l0OPEVR1XnXYwWVdR4kTUq6AKsZp4=
X-Gm-Gg: ASbGncv0xDUHpeRol2uZCRkCKFA/BtNnI/OFOSas4tGcbqWJOl1rUYYxcqHfvSkRJmp
 k9RjSDtyD8Xv+DYh0ZyK2a6LyP8vCKwTuRncQlSMSzlYMymuZn1sFClBCrCC7hNkvHD8QO1go5q
 psFOgY80Q314ZBUTusMqXESbQn2VOk6oJsGmouZt2qMAmmgPWG9ckxhNuV1jTGFbAv+nf703IHh
 vfovfQmJQkYQxWbNIwjzumbydGHsJdqMvb2xfmE9qk1qxqWEjIyG7HysIkFJ9iIX5Bp49YG4rZC
 eA2jFNpaXrA5znj1RDiBoCDyWKRZ7izu8bpVj09qhPJhLKRLeXsL1C0o0HBG4on204bT/tsLgWw
 vg8ZRD+al3q3ukiHKvQtjr1+QiM4Z77Fq8cKSVg==
X-Received: by 2002:a05:600c:3ba0:b0:45c:b5bb:7b58 with SMTP id
 5b1f17b1804b1-45cb5bb7d85mr497195e9.34.1756851511920; 
 Tue, 02 Sep 2025 15:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGII632v+MaY8BtDIdwNifExJANYObAwqzNVZ62PDaq4mg3TmECoSIqMNpDAskF5z/iC2lD1g==
X-Received: by 2002:a05:600c:3ba0:b0:45c:b5bb:7b58 with SMTP id
 5b1f17b1804b1-45cb5bb7d85mr497095e9.34.1756851511534; 
 Tue, 02 Sep 2025 15:18:31 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f6cd502sm44184215e9.1.2025.09.02.15.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 15:18:30 -0700 (PDT)
Message-ID: <d86843d2-cf8c-4940-918a-be5b092aca5a@canonical.com>
Date: Wed, 3 Sep 2025 00:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/10] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-4-hal.feng@starfivetech.com>
 <3f7547d9-5abb-42d9-9bf8-02329ced4364@canonical.com>
 <b1a0ad61-f844-408a-81e9-078fd3b52462@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <b1a0ad61-f844-408a-81e9-078fd3b52462@freeshell.de>
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

On 9/2/25 23:28, E Shattow wrote:
> 
> On 8/29/25 00:33, Heinrich Schuchardt wrote:
>> On 29.08.25 08:09, Hal Feng wrote:
>>> Directly return the DDR size instead of the field of 'DxxxExxx'.
>>> Move the function description to the header file.
>>>
>>> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>    arch/riscv/cpu/jh7110/spl.c                     |  2 +-
>>>    arch/riscv/include/asm/arch-jh7110/eeprom.h     |  8 +++++++-
>>>    .../visionfive2/visionfive2-i2c-eeprom.c        | 17 +++--------------
>>>    3 files changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
>>> index 87aaf865246..3aece7d995b 100644
>>> --- a/arch/riscv/cpu/jh7110/spl.c
>>> +++ b/arch/riscv/cpu/jh7110/spl.c
>>> @@ -41,7 +41,7 @@ int spl_dram_init(void)
>>>        /* Read the definition of the DDR size from eeprom, and if not,
>>>         * use the definition in DT
>>>         */
>>> -    size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;
>>> +    size = get_ddr_size_from_eeprom();
>>>        if (check_ddr_size(size))
>>>            gd->ram_size = size << 30;
>>>    diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/
>>> riscv/include/asm/arch-jh7110/eeprom.h
>>> index 45ad2a5f7bc..6d0a0ba0c4a 100644
>>> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>> @@ -10,7 +10,13 @@
>>>    #include <linux/types.h>
>>>      u8 get_pcb_revision_from_eeprom(void);
>>> -u32 get_ddr_size_from_eeprom(void);
>>> +
>>> +/**
>>> + * get_ddr_size_from_eeprom() - read DDR size from EEPROM
>>> + *
>>> + * @return: size in GiB or 0xFF on error.
> 
> No. This is not consistent with get_mmc_size_from_eeprom() return value
> which uses 0 as short-circuit return value if read_eeprom() fails.
> 
> It is not important to make the distinction here if eeprom read failed
> or the data was not a valid size (i.e. zero from successful eeprom read).
> 
>>> + */
>>> +u8 get_ddr_size_from_eeprom(void);
>>>      /**
>>>     * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
>>> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/
>>> board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>> index 17a44020bcf..3866d07f9d4 100644
>>> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>> @@ -550,23 +550,12 @@ u8 get_pcb_revision_from_eeprom(void)
>>>        return pbuf.eeprom.atom1.data.pstr[6];
>>>    }
>>>    -/**
>>> - * get_ddr_size_from_eeprom - get the DDR size
>>> - * pstr:  VF7110A1-2228-D008E000-00000001
>>> - * VF7110A1/VF7110B1 : VisionFive JH7110A /VisionFive JH7110B
>>> - * D008: 8GB LPDDR4
>>> - * E000: No emmc device, ECxx: include emmc device, xx: Capacity
>>> size[GB]
>>> - * return: the field of 'D008E000'
>>> - */
>>> -
>>> -u32 get_ddr_size_from_eeprom(void)
>>> +u8 get_ddr_size_from_eeprom(void)
>>>    {
>>> -    u32 pv = 0xFFFFFFFF;
>>> -
>>>        if (read_eeprom())
>>> -        return pv;
>>> +        return 0xFF;
> 
> No, inverted logic, see above return of 0xFF as an error condition is
> suspect.
> 
>>
>> Let's assume somebody cleared the EEPROM and the SPI flash.
>>
>> Would it make sense to assume the minimum encodable RAM size (1 GiB) in
>> this case, just to let the board boot to the console to allow writing
>> the EEPROM with valid data again?
>>
>> The current patch to simplify the code looks correct.
>>
>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>>>    -    return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
>>> +    return (hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL) >> 16) &
>>> 0xFF;
>>>    }
>>>      u32 get_mmc_size_from_eeprom(void)
>>
> 
> Yes, later fallback to 2G size configuration makes sense. Compatible
> products with less than 2G do not exist and probably never will; there

I wrote 1 GiB because this is the smallest size that can be encoded in 
the current EEPROM scheme. 1 GiB is big enough for reaching the U-Boot 
console and reprogramming the EEPROM or even booting into Linux.

> may be some developer boards with 1G but none I have ever heard of
> directly in conversations since 2023. The other common situation with
> zero or uninitialized EEPROM would be a failed read of eeprom i.e. RTC
> module at same i2c address or missing devicetree nodes at SPL phase.
> 
> 1. DDR size detection heuristic should happen first without need of
> eeprom, if possible.

We have get_ram_size(). According to a comment 
arch/arm/mach-stm32mp/stm32mp1/spl.c that function has a problem with 
speculative access.

I don't see an urgent necessity to move away from EEPROM as the only 
method to determine the RAM size.

Best regards

Heinrich

> 
> 2. Else warn DDR detection failed and read size from eeprom config
> 
> 3. Else warn eeprom memory config invalid and set size set to default 2G.
> 
> -E

