Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF382C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3F382E6A;
	Sun, 29 Jun 2025 21:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYT/3ai8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC6B82E86; Sun, 29 Jun 2025 18:10:38 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CCB81F6B
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 18:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2363497cc4dso28244135ad.1
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751213432; x=1751818232; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tJf2dqGEnOUUinwhzYlLbnk+5mD1ub+c8YRQwmG9ViQ=;
 b=UYT/3ai87+YxD74yPXaEZv+/rbbBfO/wAQUtWm36B5uFnBMjy/SrPtWmHS9mLJTtNe
 kJFrZ3I3oGQMSc0o7B47bdQY10xcC8BnHHhTQ+5SqAXssvwJX1lugjkrYH86bzD21RhJ
 8rIKSSAomoJpj3JfcanZHN7OR05vCGzRl01rlvRxLfFi/4r1CidGnlQPucR8LVE5P6Jb
 wEwz/5O9GkN9X18tKRAinUSbKaoDCjn5Z6bflrucT/dxPO+Pjj7Ep+dU3FsS2Crpk6/z
 c19QL3Qqm1Q13bIMA08BvUF3X/5R84S0+aAGXcU5Bd1SkCB0fjThm46Uec0+YMp+iSwN
 Wo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751213432; x=1751818232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJf2dqGEnOUUinwhzYlLbnk+5mD1ub+c8YRQwmG9ViQ=;
 b=QdGYBQrClqklQ12CcszHnYGZd8VumuZvXBKEkeWl40cfBETxVelZ/Cae54WueTYM0Z
 0EekEjrivct05bZFLjL/08gdeRAke5o7HxOJ339sq5t8yBx+vYx0r7gcl77DU2dgx434
 GUYZqtGLia43+HlFIThoCbhtxQQeytZyYuE7NDqs/YmCx0EorKM7JZlbKpVDoOsbwZei
 XhQgjsn3nu7aj49bnbscJ+w9CAjtKYaNzQjP2mjSdhLTp9pW6oTn/nP4Xob9W2ZPXuzC
 sAa9uUeswiMKds/KBY7qHEcYOGIsfeh4RAy+Hh63aF3kCKoNfHgWsm1k9JVOslhb7uXd
 qAcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgeoamtiP37NDwKdvpDqtCwCRXwtG2PBYkSaXgbK6tvvjaOih8Mb7Hj92SqNaSxdJyIBEwcb0=@lists.denx.de
X-Gm-Message-State: AOJu0YzcjHZjzO6ukKL7NvuqbxB0Lx+ALslTlF9cTMvoGC3cXuoKCT5Y
 3Kfgt7xtnWsQN4wVCzEaBo8KIDLcGshDkuxhNWEu31DXTGUV3R/qVVFgLMaQew==
X-Gm-Gg: ASbGnctZgPzeytqb2awehaTVbFPqmj+JN9wm08pErM+Yhk4aLERKn6gTXHXOx/XCURi
 AYUfPSNXujADOVbwd4FKJT7bn2dpv5Los0jxIhOI/8FiiHQJ/CFVkSrozH5ubMsJzh2+s98XCB2
 olgny047BCxEKfRdiYz7q34PnQ9FC8NWNcUkvym5CJkwD6w+gnNId8llI2WNBEYwshFzIdNf3Qu
 maFUzHQnKoU6lBiFoiYy5hkuvTJluognKiSQfHOi+LbzAtPP0g12rLG4RQbQ3JywqHTTVcgqnlr
 uu8fdcctF0a8rqq0TDCUZWdb6Mi1s3LWTJd8mujhSlOkpgO2k5DqpC1VweUyfrh+mW6xdR6dd5b
 NWCk3Zyt7BhcMe4wHu8QICXn3IY3ihZN1CI8IC3yvYb+CXBI6N1hXzV0HHQ==
X-Google-Smtp-Source: AGHT+IFgUIklI2jR6+Pli4/2EIL/sYJlY2Cir6KaPLNGeJULGLMY3lCNtvCrBW4UaYIRsANr8CVwyw==
X-Received: by 2002:a17:903:3c50:b0:234:914b:3841 with SMTP id
 d9443c01a7336-23ac460837dmr142199025ad.39.1751213432276; 
 Sun, 29 Jun 2025 09:10:32 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39be0fsm60824625ad.95.2025.06.29.09.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Jun 2025 09:10:31 -0700 (PDT)
Message-ID: <24750b55-0d68-44c0-aed6-c69c7a40dafb@gmail.com>
Date: Mon, 30 Jun 2025 00:10:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v2, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: Marek Vasut <marek.vasut@mailbox.org>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250615131243.30770-1-lucienzx159@gmail.com>
 <995a016a-f873-440c-acb7-b18568003e41@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <995a016a-f873-440c-acb7-b18568003e41@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Jun 2025 21:00:02 +0200
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


Marek Vasut 於 2025/6/29 下午 10:31 寫道:
> On 6/15/25 3:12 PM, Lucien.Jheng wrote:
>> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
>> 100/1000/2500 Mbps with auto negotiation only.
>>
>> The driver uses two firmware files, for which updated versions are 
>> added to
>> linux-firmware already.
>>
>> Locating the AIROHA FW within the filesystem at the designated partition
>> and path will trigger its automatic loading and writing to the PHY 
>> via MDIO.
>> If need board specific loading override,
>> please override the en8811h_read_fw function on board or architecture 
>> level.
>>
>> Linux upstream AIROHA EN8811H driver commit:
>> 71e79430117d56c409c5ea485a263bc0d8083390
>>
>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
>> I have modified the relevant process to align with the U-Boot boot 
>> sequence.
>> and have validated this on Banana Pi BPI-R3 Mini.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>> ---
>> Change in PATCH v2:
>> air_en8811h.c:
>>   * Fix: Indentation and coding style
>>   * Fix: Invert conditionals in some APIs to reduce indent.
>>   * Correct en8811h_read_fw(): Integrate malloc to allow other users to
>>     fully override the loading process and return a buffer containing 
>> the firmware from its source.
>>
>>   drivers/net/phy/Kconfig       |  43 ++
>>   drivers/net/phy/Makefile      |   1 +
>>   drivers/net/phy/air_en8811h.c | 857 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 901 insertions(+)
>>   create mode 100644 drivers/net/phy/air_en8811h.c
>>
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 3132718e4f8..f053f8196c2 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -79,6 +79,49 @@ config PHY_ADIN
>>       help
>>           Add support for configuring RGMII on Analog Devices ADIN PHYs.
>>
>> +menuconfig PHY_AIROHA
>> +    bool "Airoha Ethernet PHYs support"
>> +
>> +config PHY_AIROHA_EN8811H
>> +    bool "Airoha Ethernet EN8811H support"
>> +    depends on PHY_AIROHA
>> +    help
>> +      AIROHA EN8811H supported.
>> +
>> +choice
>> +    prompt "Location of the Airoha PHY firmware"
>> +    default PHY_AIROHA_FW_IN_MMC
>> +    depends on PHY_AIROHA_EN8811H
>> +
>> +config PHY_AIROHA_FW_IN_MMC
>> +    bool "Airoha firmware in MMC partition"
>> +    help
>> +      Airoha PHYs use firmware which can be loaded automatically
>> +      from storage directly attached to the PHY, and then loaded
>> +      via MDIO commands by the boot loader. The firmware is loaded
>> +      from a file specified by the PHY_AIROHA_FW_PART,
>> +      PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.
> I ran into the same firmware loading problem recently. I took a 
> different approach, have a look at [1] and specifically function 
> rcar_gen4_pcie_load_firmware() . This invokes U-Boot shell script , 
> which has to be defined by the user, and which loads the firmware by 
> whatever means necessary, from whatever storage or location . I think 
> that might be the generic approach to U-Boot firmware loading . If the 
> user needs to change the firmware loading location, they do not need 
> to rebuild the U-Boot itself, they simply update their environment and 
> the matching script. What do you think ?
>
> [1] 
> https://patchwork.ozlabs.org/project/uboot/patch/20250617081641.8385-5-marek.vasut+renesas@mailbox.org/ 
>

Hi Marek

I've looked at the `rcar_gen4_pcie_load_firmware` API. As you mentioned, 
it allows users to set the storage and location from the U-Boot shell, 
meaning they don't need to recompile U-Boot.

However, I recently checked out `FS_LOADER` and realized it's 
essentially the same approach as how I'm currently placing firmware on 
eMMC, just with a unified API(request_firmware_into_buf).

I'm wondering if there's a future possibility to integrate U-Boot shell 
scripts into `FS_LOADER`?

Also, given that the Kernel has a built-in firmware mechanism where 
files are compiled directly into the Kernel image, I'm curious if U-Boot 
might adopt a similar approach in the future. I'm also considering if 
`binman_sym` could be a viable alternative.

For the short term, though, I'll go ahead and submit the EN8811H 
firmware loading method using the `rcar_gen4_pcie_load_firmware` 
approach. I'll then explore potential improvements later.

Thanks!



