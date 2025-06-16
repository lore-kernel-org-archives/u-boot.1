Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440BC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A3081760;
	Mon, 16 Jun 2025 15:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZUBsgt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA0881E18; Mon, 16 Jun 2025 15:41:57 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 109FC80C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a510432236so3350088f8f.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750081314; x=1750686114; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gPd+YoGafkQh3TSxPWi3CzV9x0UEvkMu7rByBWRPiJQ=;
 b=dZUBsgt6VfL4n5GNv8bPIif8GeHcUS+onV9jHEI690LFKkC4kq1KGIb1JP/7MzvQ5F
 x9sobhRXF+W7/pMWAqo1iGC3qa4YR8oW94QcotVfWDWl7apJ9n2Oy2F/qB22oerrioV+
 I0HTo7VhMrDVcB6RtaA5MqIxQLN6t40oPp5FFjRcabMO0xb8LQ5YsBTB+4PWwVBd0OCn
 6yW+RuCTwLmtIicN9BiAv7680lLjDV19KHX+X9ckXILQYASF7wwCl66cIvzswAI8Cdvy
 c+GtJrK22VDMASwwgzGgCiqhrv1XU/t2LfmQn+YmG2c7fzbbcxUMEuPhVT8stMIBdx/H
 MnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750081314; x=1750686114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPd+YoGafkQh3TSxPWi3CzV9x0UEvkMu7rByBWRPiJQ=;
 b=gxYbVXyopLdIr3HSDyNTKeYY9CPp33+gjxzuJMNB8na5lUYA2+X/QIzPC9VPoykuaT
 DzoUyhzMSKy8v86AV/zkxsUY2besz6bNL6zatdUWeaXVYNgV0jY/IQ4tVdGJMQKOqjKD
 iQVebZeFiacfw7XYbfYk1v4m7jAqD/4i8RUGtWk89MpgSnDxkLQcRkg5morZ1qojleOn
 TBg6xDZ/aDd/cs6uWlPoy5nVu2O2d9Ai+owJYbtPDzdvANk9lRK5/WkMGSpTA7qQz2ZB
 t48S2epJ8B80W6VOprBedPuQ30zHkwq1Ud3W7ymg/YfRTqQjZg5uJNt61gq91t2pQM+f
 BUPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjfuk2MP7LyFRk5kHh9tlLprNuTOcq+VuD6lfNcpGdiAXJMSu3+LO7+YEuA4O2NBfHW65dtjk=@lists.denx.de
X-Gm-Message-State: AOJu0YyHlYIi4aM1cLUyKUCVGVdOj3cHSIcrNGODy6mRfWE73hXTVrVl
 bnBpW57W/PVobn/C8/dlrqo7sHhW5KV2nbvXC5t1QX7sPUTtq3ZecCvGSN9qFQURRyU=
X-Gm-Gg: ASbGncu/agkJFhndo4GajFYUj08Y8poAmX8Iy5vIBGfgnE8OD7er2zCJu5McOX6+6kx
 u/pvXJc5GAmJjazUSSNPKxBwgnVIJDeNEHXeSn9VLC7bvIss5n1NnkCI7Ki8wH4kIsE801JSZGO
 Qewihxa4PidWVb0clyK1+4E5D4QvTQ9oZUK7rxkGZaX2Qlb3yvePbfKgDyXE+VJNRGC3e5hukJP
 HdxiUtZrl4JFsM/Mp8SIU/1wI0MDexDaIugI58E8CoDukvaqz0g7aXhZkawupktO/JOFhmdJNBm
 z9AdA++ROF0fxGcV3dybWDIMUHzZaEwIwo1iMRrzhymAy3rS5PcsiEP1fTjmuf0oe+BpoVbtdKa
 4CZLp5dtQ8pFmQmD0mdGD8ttpgs6qJNhCkQmDLYtIJIXvAjR/DQ==
X-Google-Smtp-Source: AGHT+IE95vCu51pe3NjWV9aoRIAhecwLPwM38sRHSuD6zwGJOAMDu8HfjmrF069XrTHV/rd7g4E0hw==
X-Received: by 2002:a05:6000:230e:b0:3a4:e740:cd72 with SMTP id
 ffacd0b85a97d-3a572396df6mr7733643f8f.13.1750081314407; 
 Mon, 16 Jun 2025 06:41:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199?
 ([2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232e4asm143653905e9.11.2025.06.16.06.41.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 06:41:54 -0700 (PDT)
Message-ID: <7f8cb72d-ba9a-4317-adc3-5c17bdcfb80a@linaro.org>
Date: Mon, 16 Jun 2025 15:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: io.h: Fix io accessors for KVM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, mikko.rapeli@linaro.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
 <c7d2a64f-1415-4481-9c2c-072e0abb2698@linaro.org>
 <CAC_iWjJxE_XSbHAZcxf2bVssnyqesT5td3XxAAvs80-PSMQOjQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJxE_XSbHAZcxf2bVssnyqesT5td3XxAAvs80-PSMQOjQ@mail.gmail.com>
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



On 6/16/25 15:11, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> [...]
> 
>>
>> If I'm not mistaken, this patch is doing two things that are unrelated:
>> (1) fix the KVM issue and
>> (2) get rid of the __arch_*() macros in favor of the __raw_*() macros
> 
> I can split it, but I don't see much point since we redefine the raw_macros.

Just to make it easier to review.

> 
>>
>> IMO this should be two separate patches.
>>
>>>
>>>  /*
>>>   * The compiler seems to be incapable of optimising constants
>>> diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
>>> index f2393c041f44..545561ad1169 100644
>>> --- a/drivers/spi/fsl_dspi.c
>>> +++ b/drivers/spi/fsl_dspi.c
>>> @@ -123,8 +123,10 @@ static uint dspi_read32(uint flags, uint *addr)
>>>
>>>  static void dspi_write32(uint flags, uint *addr, uint val)
>>>  {
>>> -     flags & DSPI_FLAG_REGMAP_ENDIAN_BIG ?
>>> -             out_be32(addr, val) : out_le32(addr, val);
>>> +     if (flags & DSPI_FLAG_REGMAP_ENDIAN_BIG)
>>> +             out_be32(addr, val);
>>> +     else
>>> +             out_le32(addr, val);
>>>  }
>>
>> Unrelated change
> 
> Due to the the new do {} while(0) macro this doesn't compile, so it
> needs to go together.

If you make all the __raw_*() macros compound litterals, i.e., ({ ... })
it should not be necessary I think.

> 
>>
>>>
>>>  static void dspi_halt(struct fsl_dspi_priv *priv, u8 halt)
>>> diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
>>> index 3ac226879303..1c363115beb2 100644
>>> --- a/include/fsl_ifc.h
>>> +++ b/include/fsl_ifc.h
>>> @@ -803,29 +803,29 @@ void init_final_memctl_regs(void);
>>>       ((struct fsl_ifc_fcm *)CFG_SYS_IFC_ADDR)
>>>
>>>  #define get_ifc_cspr_ext(i)  \
>>> -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext))
>>> +             ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext)
>>>  #define get_ifc_cspr(i)              \
>>> -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr))
>>> +             ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr)
>>>  #define get_ifc_csor_ext(i)  \
>>> -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext))
>>> +             ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext)
>>>  #define get_ifc_csor(i)              \
>>> -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor))
>>> +             ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor)
>>>  #define get_ifc_amask(i)     \
>>> -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask))
>>> +             ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask)
>>>  #define get_ifc_ftim(i, j)   \
>>> -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j]))
>>> +             ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j])
>>>  #define set_ifc_cspr_ext(i, v)       \
>>> -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v))
>>> +             ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v)
>>>  #define set_ifc_cspr(i, v)   \
>>> -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v))
>>> +             ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v)
>>>  #define set_ifc_csor_ext(i, v)       \
>>> -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v))
>>> +             ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v)
>>>  #define set_ifc_csor(i, v)   \
>>> -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v))
>>> +             ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v)
>>>  #define set_ifc_amask(i, v)  \
>>> -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v))
>>> +             ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v)
>>>  #define set_ifc_ftim(i, j, v)        \
>>> -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v))
>>> +             ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v)
>>
>> Same.
> 
> Same here, both of the changes are needed
> 
> Thanks
> /Ilias
>>
>>>
>>>  enum ifc_chip_sel {
>>>       IFC_CS0,
>>> --
>>> 2.43.0
>>>
>>
>> Thanks,
>> --
>> Jerome
