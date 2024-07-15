Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F35C3DA45
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 07:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05872885EE;
	Mon, 15 Jul 2024 09:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AH2Eqqnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C9F882D7; Mon, 15 Jul 2024 09:15:06 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC87D882D7
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 09:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c66so6102696e87.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721027704; x=1721632504; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NdJXQMRWkG1cziX8viWUz4Q9+7ebm8GQmmlkTH0HOq0=;
 b=AH2EqqnmRR8nSw879wgw6YEryB17GUzd2TgqheOEvN1gpKpKRTp9BRAqHTscA9ke36
 Vo4vH9u76MC9G8EijgzoHy0AS7CVLWNFtt359hAP2b8a+TBbjoOWHFaAUFt1sYy6RH7w
 Yo/sXvkn/4E8rh9+SOtTQDoGd+NHE2ENwIPAXjAVzypgnH1etrZHHE/gCn/JbIGDpY0F
 HAIBTjkWA4PhUJsInudjfNiweSsnPpiTPI6hb4yzeRgoXsQtMwi7w83gJfzsigfKf7W8
 AlEXo04EY8h893pqhENkVzZzaphzrVfUSlLcYE5yl5w0OU7uzCW/nQCmdMb95d9iiWGX
 eg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721027704; x=1721632504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NdJXQMRWkG1cziX8viWUz4Q9+7ebm8GQmmlkTH0HOq0=;
 b=vYjmgyLL5fzzy9h8ioxafiAegHRqObvqO9+LJoG5u6ds+z1vethM+xmu53QWuJpESQ
 45qSBI07aTQAT9efSN6J1APos1A1jZsWXOuS3sfWBSEebEi9X1FEIbR1AYQZoJyobWn5
 502SMjU0dVGKoieM3W2L06oCwW+IXn2ernrAostw714UdcWkMQWAAwnViwiHxsLRi3pW
 S0kbRQcldzov8nAlM9X/usH0AGJJXAr3+NbRv93fVf1MvWrmiPtd7N4NRoJ/+aefcxw8
 WLF1LDMo4l3o9Bzg/+xEgL0CNWayojQfPlWwijIJiZzNZpHUerdnqV2vzLcCmuvBUo8H
 vjAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU81uUnqFxJ5GCX/lK4wpuN50xFNwbQVwouqFdK4utjogM0GzlgvFOHOdxMiTmNnqruMWoH+ZuIo1aZUxiKPP8SPgqjVw==
X-Gm-Message-State: AOJu0Yz/3NxBGnkW6/D0LumjKDAeIEHU52ynG5EJnFhBECsAWmjuNCkm
 sq0H6x3IzUI4A1dGjhp1CrkXE/hpWgB4YqDIQbm33+uRgmnQnAZecUyWR52KJ4w=
X-Google-Smtp-Source: AGHT+IFe8BXerwLzSilrYOJvFvB6X1z2pY6U/0Nl5u9XEp8IUwD8ttAWNOwAXjGenJIAsTQwkset3Q==
X-Received: by 2002:a19:7508:0:b0:52c:e1cd:39bd with SMTP id
 2adb3069b0e04-52eb9991e39mr13313950e87.13.1721027703925; 
 Mon, 15 Jul 2024 00:15:03 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a3a52sm192614766b.12.2024.07.15.00.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 00:15:03 -0700 (PDT)
Message-ID: <1424316d-919b-4063-b0ed-72aedef2d40e@linaro.org>
Date: Mon, 15 Jul 2024 09:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Dragan Simic <dsimic@manjaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
 <c8e6a53d96a89e54585bfe28a647f44f@manjaro.org>
 <948a0d04-a0a2-4c36-8c8d-5f3ad70dfdeb@linaro.org>
 <76f99e2dba4a83b36cc3db4ecc8a6fb1@manjaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <76f99e2dba4a83b36cc3db4ecc8a6fb1@manjaro.org>
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



On 15/07/2024 09:03, Dragan Simic wrote:
> Hello Caleb,
> 
> On 2024-07-15 08:24, Caleb Connolly wrote:
>> On 14/07/2024 22:47, Dragan Simic wrote:
>>> On 2024-07-14 21:49, Caleb Connolly wrote:
>>>> We don't have audio support in U-Boot, but we do have boot menus. 
>>>> Add an
>>>> option to re-map the volume and power buttons to up/down/enter so that
>>>> in situations where these are the only available buttons (such as on
>>>> mobile phones) it's still possible to navigate menus built in U-Boot or
>>>> an external EFI app like GRUB or systemd-boot.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>> Cc: u-boot-qcom@groups.io
>>>
>>> Very nice, thanks for this patch!  Looking good to me, with a few
>>> suggestions available below.  Anyway, please feel free to add:
>>>
>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>>>
>>>> ---
>>>>  drivers/button/Kconfig         | 11 +++++++++++
>>>>  drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
>>>>  2 files changed, 32 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>>>> index 3918b05ae03e..6cae16fcc8bf 100644
>>>> --- a/drivers/button/Kconfig
>>>> +++ b/drivers/button/Kconfig
>>>> @@ -8,8 +8,19 @@ config BUTTON
>>>>        U-Boot provides a uclass API to implement this feature. 
>>>> Button drivers
>>>>        can provide access to board-specific buttons. Use of the 
>>>> device tree
>>>>        for configuration is encouraged.
>>>>
>>>> +config BUTTON_REMAP_PHONE_KEYS
>>>> +    bool "Remap phone keys for navigation"
>>>> +    depends on BUTTON
>>>> +    help
>>>> +      Enable remapping of phone keys to navigation keys. This is 
>>>> useful for
>>>> +      devices with phone keys that are not used in U-Boot. The 
>>>> phone keys
>>>> +      are remapped to the following navigation keys:
>>>> +      - Volume up: Up
>>>> +      - Volume down: Down
>>>> +      - Power: Enter
>>>> +
>>>
>>> Frankly, "phone keys" sounds a bit strange to me, maybe because there
>>> are also tablets that have the same style of reduced-set keys.  Thus,
>>> I'd suggest that the following language is used:
>>>
>>> - "BUTTON_REMAP_PHONE_KEYS" instead of "BUTTON_REMAP_REDUCED_KEYS"
>>> - "reduced smartphone-style keys" instead of "phone keys"
>>
>> I would have assumed that anyone working on a tablet would immediately
>> guess what this option does and that it might be useful given the
>> name. I would argue that seeing "BUTTON_REMAP_REDUCED_KEYS" instead
>> makes it harder to guess what this option does.
>>
>> I think of it not as "this option remaps the keys on your phone" but
>> as "this option remaps the keys that phones have", as in, the volume
>> and power buttons.
>>
>> If you'd prefer, maybe we can meet somewhere in the middle with "mobile"?
>>
>> how's BUTTON_REMAP_MOBILE_KEYS?
> 
> Hmm, if I had to choose between BUTTON_REMAP_PHONE_KEYS and
> BUTTON_REMAP_MOBILE_KEYS, I'd still choose BUTTON_REMAP_PHONE_KEYS.
> As you're against BUTTON_REMAP_REDUCED_KEYS, for which you provided
> valid arguments, I'm still fine with your original word choice.
> 
> In other words, there are no reasons for the word choice to hold
> this nice patch back from becoming accepted.

Ok, thanks :)

Sorry for the tone, I'm afraid I misread your original email.

Kind regards,
> 
>>> Using "reduced" would also allow us to have this remapping logic more
>>> easily extended to also cover some other buttons found on some other
>>> devices with reduced-set keys.
>>
>> If such a device exists and gains support in U-Boot, the switch/case
>> could be extended, or a new option added if it doesn't make sense to
>> lump everything together. Without knowing about such a device I think
>> it's impossible to make a judgement here.
> 
> I see, but I just tried to make it a bit more future-proof by using
> more general terms.  However, as I already wrote above, I'm fine with
> keeping the patch in its original form.
> 
>>>>  config BUTTON_ADC
>>>>      bool "Button adc"
>>>>      depends on BUTTON
>>>>      depends on ADC
>>>> diff --git a/drivers/button/button-uclass.c 
>>>> b/drivers/button/button-uclass.c
>>>> index cda243389df3..729983d58701 100644
>>>> --- a/drivers/button/button-uclass.c
>>>> +++ b/drivers/button/button-uclass.c
>>>> @@ -9,8 +9,9 @@
>>>>
>>>>  #include <button.h>
>>>>  #include <dm.h>
>>>>  #include <dm/uclass-internal.h>
>>>> +#include <dt-bindings/input/linux-event-codes.h>
>>>>
>>>>  int button_get_by_label(const char *label, struct udevice **devp)
>>>>  {
>>>>      struct udevice *dev;
>>>> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct 
>>>> udevice *dev)
>>>>
>>>>      return ops->get_state(dev);
>>>>  }
>>>>
>>>> +static int button_remap_phone_keys(int code)
>>>
>>> Pretty much the same suggestion as above applies here.
>>>
>>>> +{
>>>> +    switch (code) {
>>>> +    case KEY_VOLUMEUP:
>>>> +        return KEY_UP;
>>>> +    case KEY_VOLUMEDOWN:
>>>> +        return KEY_DOWN;
>>>> +    case KEY_POWER:
>>>> +        return KEY_ENTER;
>>>> +    default:
>>>> +        return code;
>>>> +    }
>>>> +}
>>>> +
>>>>  int button_get_code(struct udevice *dev)
>>>>  {
>>>>      struct button_ops *ops = button_get_ops(dev);
>>>> +    int code;
>>>>
>>>>      if (!ops->get_code)
>>>>          return -ENOSYS;
>>>>
>>>> -    return ops->get_code(dev);
>>>> +    code = ops->get_code(dev);
>>>> +    if (CONFIG_IS_ENABLED(BUTTON_REMAP_PHONE_KEYS))
>>>> +        return button_remap_phone_keys(code);
>>>> +    else
>>>> +        return code;
>>>>  }
>>>>
>>>>  UCLASS_DRIVER(button) = {
>>>>      .id        = UCLASS_BUTTON,

-- 
// Caleb (they/them)
