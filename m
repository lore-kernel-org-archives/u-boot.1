Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A19C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 21:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C6387EB4;
	Sun, 21 Jul 2024 23:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CPtGK4q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37EC487F5C; Sun, 21 Jul 2024 23:42:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102798789F
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2EF2A3F2B8
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 21:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721598171;
 bh=qmzrxDZ7XnG6iflxdzJJkTsI9LUbZ/O52nxshdhR9f8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=CPtGK4q/j+063kEZ7bpTYg4yWM/WqaNKBbyNe/BXAdNAWAGUIYttivDakXAE6RcvO
 1hWpwPAjPitseR32WyZfMWQyvGnQLisijRNAYf5X1YF6SQKiZqx3stJ3q1ozxtOxBS
 NJJ35Cypc8Oi9PqFkHnDmmz9hHa/snoEyrNaQtPRGShEaYCUxejJDJJBwCIbQTq87J
 oxbO+at7BlX/D+s02m1XJndqvaIIO7ar6gO1HRJ9D9LMRvLxa/IygNKXEk1YG2t+6N
 GEu9LARW6XtQ557fS60xwDOLwvqrnRngVqUdVEqqqePehBNs6IszQlhmK2Ocv5I9Ef
 7/ihKrfU2b9tw==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a77f5dd71a4so283527466b.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 14:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721598171; x=1722202971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmzrxDZ7XnG6iflxdzJJkTsI9LUbZ/O52nxshdhR9f8=;
 b=MSSMxBYtegxfmLt/tayvWL64Q1CVKs/0NJKwWdUnK0vIpZLxDV1PDSZTOl70s8GEe+
 MfEGOiKylPNRnMgD81pMcRSKI29fs7s6Md1r9DmmhHkHVhXw/OGK4l37q76ekmXGxXZz
 evLNtHvLT0aU961YBzJN8GOx9miu5Lg2Z4Zf/O7islUuoAKYxOxQqTp73nwm293YuDZ4
 QlbgZlDStMR7+BmMghgrtcRgk+Bv8uM5zr8o8G8sNwOthAWQJgDkvZtcToN9+zDaYU9Q
 oaVxh3fVSkltA6+kqomuRons5dQ13XjKwfCuOYs6CuS4gHbZEZRTBkXotvfLRhXfdbC5
 pQFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPMjL9fyDVbzDJ9p0EZseDi0byL4YMSii6YDLR50jURFhhcSBijb8jz5bHJDSrpKM2q/TAKar/iQfxP7GcSv+KsdoNig==
X-Gm-Message-State: AOJu0YzIJVbsfyvXpao0qyT1fd96hYTpKPP2d1RybbNZFZ9Vx7A80Pvf
 QscXAgPIWbwK5Wnd2bat8dAHQERCeacudSvEt1XF6XbXbe+71zdLEXPZU8gzDR2q/rC4fUXEz2Q
 d4WIEr4ebtTu7w/si2+ezgeGpVBRCcs7YBPUqEifqTwzkcVHSpFilwbHV0K1rDv6jX+j88Nyiph
 s=
X-Received: by 2002:a17:906:dc8f:b0:a6f:392d:51a9 with SMTP id
 a640c23a62f3a-a7a4bfe6b79mr367671366b.14.1721598170735; 
 Sun, 21 Jul 2024 14:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmwH8HOphDkaRqXxyVNknIfTBv1rsPpz6GbiEzvM/JdCAhQQYblEuY+244Ef8jxck4t/NoZw==
X-Received: by 2002:a17:906:dc8f:b0:a6f:392d:51a9 with SMTP id
 a640c23a62f3a-a7a4bfe6b79mr367670166b.14.1721598170006; 
 Sun, 21 Jul 2024 14:42:50 -0700 (PDT)
Received: from ?IPV6:2a00:20:3:e380:42:1c25:2ef0:b6e9?
 ([2a00:20:3:e380:42:1c25:2ef0:b6e9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c7bddc6sm335512766b.69.2024.07.21.14.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 14:42:49 -0700 (PDT)
Message-ID: <61c16b44-90cb-4834-a81d-c1a90ab2117d@canonical.com>
Date: Sun, 21 Jul 2024 23:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board: fix compatible property Milk-V Mars CM
To: E Shattow <lucent@gmail.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de
References: <20240719231158.50416-1-heinrich.schuchardt@canonical.com>
 <CANV2PTPOesJWcbYhVeiQWonccy3rWdQmN5qfuJtFN+JpnYNzbA@mail.gmail.com>
 <CANV2PTOWVCTWiyQoA4vEro61WwFSPBaGbrsBN-zXVwm2daHvJg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTOWVCTWiyQoA4vEro61WwFSPBaGbrsBN-zXVwm2daHvJg@mail.gmail.com>
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

On 7/21/24 23:27, E Shattow wrote:
> P.S. my suggestion below
> 
> On Fri, Jul 19, 2024 at 5:06 PM E Shattow <lucent@gmail.com> wrote:
>>
>> On Fri, Jul 19, 2024 at 4:12 PM Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> For the Milk-V Mars CM (lite) we have only been copying sizeof(void *)
>>> bytes to the compatible property instead of the whole string list.
>>
>> This const char array must be so that we may get an accurate data
>> length with sizeof() but it highlights there are helper functions for
>> get of fdt stringlist and not for set of fdt stringlist.
>>
>>>
>>> Fixes: de3229599d4f ("board: add support for Milk-V Mars CM")
>>> Reported-by: E Shattow <lucent@gmail.com>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   board/starfive/visionfive2/spl.c | 15 ++++++++++++---
>>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
>>> index b794b73b6bd..f55c6b5d34c 100644
>>> --- a/board/starfive/visionfive2/spl.c
>>> +++ b/board/starfive/visionfive2/spl.c
>>> @@ -170,23 +170,32 @@ void spl_fdt_fixup_mars_cm(void *fdt)
>>>   {
>>>          const char *compat;
>>>          const char *model;
>>> +       int compat_size;
>>>
>>>          spl_fdt_fixup_mars(fdt);
>>>
>>>          if (!get_mmc_size_from_eeprom()) {
>>>                  int offset;
>>> +               static const char
>>> +               compat_cm_lite[] = "milkv,mars-cm-lite\0starfive,jh7110";
>>>
>>>                  model = "Milk-V Mars CM Lite";
>>> -               compat = "milkv,mars-cm-lite\0starfive,jh7110";
>>> +               compat = compat_cm_lite;
>>> +               compat_size = sizeof(compat_cm_lite);
>>>
>>>                  offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
>>>                  /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
>>>                  fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
>>>          } else {
>>> +               static const char
>>> +               compat_cm[] = "milkv,mars-cm\0starfive,jh7110";
>>> +
>>>                  model = "Milk-V Mars CM";
>>> -               compat = "milkv,mars-cm\0starfive,jh7110";
>>> +               compat = compat_cm;
>>> +               compat_size = sizeof(compat_cm);
>>>          }
>>> -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
>>> +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
>>> +                   "compatible", compat, compat_size);
>>>          fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
>>>   }
>>>
>>> --
>>> 2.45.2
>>>
>>
>> -E
> 
> What about something like as follows?
> 
>   void spl_fdt_fixup_mars(void *fdt)
>   {
> -       static const char compat[] = "milkv,mars\0starfive,jh7110";
>          u32 phandle;
>          u8 i;
>          int offset;
>          int ret;
> 
> -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible",
> compat, sizeof(compat));
> -       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
> -                          "Milk-V Mars");
> +       offset = fdt_path_offset(fdt, "/");
> +       fdt_setprop_string(fdt,    offset, "compatible", "milkv,mars");
> +       fdt_appendprop_string(fdt, offset, "compatible", "starfive,jh7110");
> +       fdt_setprop_string(fdt,    offset, "model",      "Milk-V Mars");
> 
>          /* gmac0 */
>          offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
> @@ -164,30 +226,31 @@ void spl_fdt_fixup_mars(void *fdt)
>                                  break;
>                  }
>          }
>   }
> 
>   void spl_fdt_fixup_mars_cm(void *fdt)
>   {
> -       const char *compat;
> -       const char *model;
> +       int offset;
> 
>          spl_fdt_fixup_mars(fdt);
> 
>          if (!get_mmc_size_from_eeprom()) {
> -               int offset;
> -
> -               model = "Milk-V Mars CM Lite";
> -               compat = "milkv,mars-cm-lite\0starfive,jh7110";
> +               offset = fdt_path_offset(fdt, "/");
> +               fdt_setprop_string(fdt, offset, "compatible",
> "milkv,mars-cm-lite");
> +               fdt_appendprop_string(fdt, offset, "compatible",
> "starfive,jh7110");
> +               fdt_setprop_string(fdt, offset, "model", "Milk-V Mars CM Lite");
> 
>                  offset = fdt_path_offset(fdt,
> "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
>                  /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
>                  fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
>          } else {
> -               model = "Milk-V Mars CM";
> -               compat = "milkv,mars-cm\0starfive,jh7110";
> +               offset = fdt_path_offset(fdt, "/");
> +               fdt_setprop_string(fdt, offset, "compatible", "milkv,mars-cm");
> +               fdt_appendprop_string(fdt, offset, "compatible",
> "starfive,jh7110");
> +               fdt_setprop_string(fdt, offset, "model", "Milk-V Mars CM");
>          }
> -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible",
> compat, sizeof(compat));
> -       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
>   }
> 
>   void spl_fdt_fixup_version_a(void *fdt)
> @@ -235,6 +298,7 @@ void spl_fdt_fixup_version_a(void *fdt)
>                                  break;
>                  }
>          }
> +
>   }
> 
> 
> And similar changes to the other "string1\0string2" settings in the
> same source file.
> 
> -E

You did not mention why you would prefer three function calls (including 
strlen()) instead of one.

Your code should work too but results in a larger code size.

Probably the shortest code would use a common function with parameters 
'model' and 'compatible_1st' for each of the boards and then use 
fdt_appendprop_string() to append the common 2nd compatible string.

Best regards

Heinrich
