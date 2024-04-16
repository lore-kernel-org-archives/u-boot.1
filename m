Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3730C531DD
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 06:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B754188287;
	Tue, 16 Apr 2024 08:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ISJW5QGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DAC881B9; Tue, 16 Apr 2024 08:14:16 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD5A888284
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8082A41231
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713248049;
 bh=FE1a6B8RBlsNpq2rYXsO9jDY+jyKhWUOEG1nYUrm+MU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ISJW5QGl00s6c7iRnI/IzMH7AnTqZ7VO0Hnn5xW2eMYdg3g9fdBCKrKXok3zqIHO7
 gRZyLCan+Fjd72ve0JwWyHousPQWJm7XZ53F6vHk+51+yN8dvJZE+DxWsSnh2uV2xi
 B2ScG9AJoSlDRhDKU5lZiJ5kegWNGuLEyFVGQCtvpUPpp4oC8yyLlJ33WvF0NIU2Se
 R5MvERM4Y95WdiTMhMvIgGaorhNh6PbBGmunO9AAtDwav9I1+y4FgZ22FXnUsuW9F0
 XoQWLiUf7tI0RDEylilGY/cbWOjxDnAxbYlySsDs6Yt8zBtx+JPjFuN6tcL44yMPFR
 RiOym75j6ejNg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4183b895ef1so6634315e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713248048; x=1713852848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FE1a6B8RBlsNpq2rYXsO9jDY+jyKhWUOEG1nYUrm+MU=;
 b=vMcw0ZRkyXfPZ9ehrsXdWm0zp5b+LG2+3Ws9YBWlaPfQjTj9xC5TBrJ/YsytJPiuxr
 oiGf8GztsfxUnNTkOmDKwSzfqnIaetwQTDwc0OZr3KeZLGOjd18I6Q0uZC+nYS4MRM24
 5yWZ0D59Wyw/2BO7QOZD8ATSGnYtlgfblITf4pA32FLWp7fVZDr3yFAB+EVBhp5GNpS6
 Qa8RKrtACeZ55yG13KRh1785JTL5WQpULhM/QHX/+g5sAH3awzUO3OuI+ShYsPo1KDHW
 4behTkX9ObUxB7QiLX8tDAJX7iNDhiYpB+mFzRxrDgJ27t7ZlkYsSuJw+S6mFdk1jK0L
 FOsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxeUqlNfdcr1EbvNJQEpWbaUkoPAibfLmCKEdBW79BXiRhXhcZcPzI/DsxrVUv8qWwVuq6Mc/maZT7EJps7W6a4i0Seg==
X-Gm-Message-State: AOJu0YyH9RSqrJe6baM+LYufg+YPtSsXovLfMkK/p6r707+OXalTR1HC
 uMDhCae1uwMXQIVuv4+IC+VUjSpld1Wnfz285fB+Cf9z6W3Vje2TjnhN3XivzzC8kisyDew2ez4
 7ZNHD4I+QXl6zpv89Tof4aDiMS9z+WNc7v7i1RyVBtb08N5fyD1pGYhKH3rHr5tHBVDI=
X-Received: by 2002:a05:600c:1907:b0:418:2636:3152 with SMTP id
 j7-20020a05600c190700b0041826363152mr7468637wmq.6.1713248048533; 
 Mon, 15 Apr 2024 23:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6SlnEnJKGvgK+oJi+o6iJ5EB7/SOQ3HzOc2VQO3FHDmpzGfJMV0YyrVb6cnrSDSz+KMrn1Q==
X-Received: by 2002:a05:600c:1907:b0:418:2636:3152 with SMTP id
 j7-20020a05600c190700b0041826363152mr7468618wmq.6.1713248048131; 
 Mon, 15 Apr 2024 23:14:08 -0700 (PDT)
Received: from [192.168.123.161] ([62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c310700b00417e4add806sm17505899wmo.7.2024.04.15.23.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 23:14:07 -0700 (PDT)
Message-ID: <29ed60ea-82f0-49fe-9135-343c0979373d@canonical.com>
Date: Tue, 16 Apr 2024 08:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] board: starfive: function to read eMMC size
To: E Shattow <lucent@gmail.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, u-boot@lists.denx.de
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-2-heinrich.schuchardt@canonical.com>
 <CANV2PTPX43Kwwyff_3cuzyG2DVe8qaWn3C4DxA9ppv0m5o3c-A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTPX43Kwwyff_3cuzyG2DVe8qaWn3C4DxA9ppv0m5o3c-A@mail.gmail.com>
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

On 4/16/24 06:09, E Shattow wrote:
> On Mon, Apr 15, 2024 at 4:50 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The EEPROM provides information about the size of the EEPROM.
> 
> "The EEPROM provides information about the size of the eMMC."

Thanks for catching this.

> 
>> Provide a new function get_mmc_size_from_eeprom() to read it.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/include/asm/arch-jh7110/eeprom.h    |  7 +++++++
>>   board/starfive/visionfive2/Kconfig             |  9 +++++++++
>>   .../visionfive2/visionfive2-i2c-eeprom.c       | 18 ++++++++++++++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
>> index 62d184aeb57..17395d4269e 100644
>> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
>> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
>> @@ -12,6 +12,13 @@
>>   u8 get_pcb_revision_from_eeprom(void);
>>   u32 get_ddr_size_from_eeprom(void);
>>
>> +/**
>> + * get_mmc_size_from_eeprom() - read MMC size form EEPROM
>> + *
>> + * @return: size in GiB or 0 on error.
>> + */
>> +u32 get_mmc_size_from_eeprom(void);
>> +
>>   /**
>>    * get_product_id_from_eeprom - get product ID string
>>    *
>> diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfive2/Kconfig
>> index 2186a939646..d7e8a7a7d78 100644
>> --- a/board/starfive/visionfive2/Kconfig
>> +++ b/board/starfive/visionfive2/Kconfig
>> @@ -50,4 +50,13 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>>          imply PHY_LIB
>>          imply PHY_MSCC
>>
>> +config STARFIVE_NO_EMMC
>> +       bool "Report eMMC size as zero"
>> +       help
>> +         The serial number string in the EEPROM is meant to report the
>> +         size of onboard eMMC. Unfortunately some Milk-V Mars CM Lite
>> +         modules without eMMC show a non-zero size here.
>> +
>> +         Set to 'Y' if you have a Mars CM Lite module.
>> +
>>   endif
>> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>> index ddef7d61235..cd3d8bd51a6 100644
>> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>> @@ -548,6 +548,24 @@ u32 get_ddr_size_from_eeprom(void)
>>          return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
>>   }
>>
>> +u32 get_mmc_size_from_eeprom(void)
>> +{
>> +       u32 size;
>> +
>> +       if (IS_ENABLED(CONFIG_STARFIVE_NO_EMMC))
>> +               return 0;
>> +
>> +       if (read_eeprom())
>> +               return 0;
>> +
>> +       size = dectoul(&pbuf.eeprom.atom1.data.pstr[19], NULL);
>> +
>> +       if (pbuf.eeprom.atom1.data.pstr[21] == 'T')
>> +               size <<= 10;
>> +
>> +       return size;
>> +}
>> +
>>   U_BOOT_LONGHELP(mac,
>>          "\n"
>>          "    - display EEPROM content\n"
>> --
>> 2.43.0
>>
> 
> Fixed-position parsing on a data format of ordered variable length
> hyphen-delimited fields. Notable is that some Pine64 Star64 and Milk-V
> Mars CM Lite boards shipped with uninitialized or wrong EEPROM data;
> further the EEPROM Write Protect can be trivially disabled and
> arbitrary data written i.e. with a paperclip then `mac` command. Could
> this code be generalized to split fields on hyphen character better
> expressing the expected data format or is that unwanted complexity and
> code size?

The boards that I have seen up to now are consistent in the string 
layout of the boards that I have received up to now:

VisionFive 2 1.2B   VF7110A1-2239-D004E000-xxxxxxxx
VisionFive 2 1.3B   VF7110B1-2253-D004E000-xxxxxxxx
VisionFive 2 1.3B   VF7110B1-2253-D008E000-xxxxxxxx
Pine64 Pinetab V    VF7110B1-2230-D008E000-xxxxxxxx
Pine64 Star64 v1    STAR64V1-2310-D008E000-xxxxxxxx
Milk-V Mars         MARS-V11-2340-D008E000-xxxxxxxx
Milk-V Mars CM Lite MARC-V10-2340-D002E016-xxxxxxxx

The example of the Pinetab V and of the first batch of the Milk V CM 
Lite shows that the trustworthiness of the EEPROM data is limited.

As you mentioned such deviations can be fixed by rewriting the EEPROM. I 
don't think that this is problematic for the parsing of the string. It 
might be an issue for warranty claims.

Retrieving the RAM size already relies on positional data. The eMMC size 
is just a sub-field of what is read in get_ddr_size_from_eeprom().

Changes would have to start there if wanted by the StarFive maintainer.

Best regards

Heinrich
