Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1888CCD1296
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 12:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4126F87F78;
	Mon,  8 Apr 2024 14:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nZUCf57d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3227587DEA; Mon,  8 Apr 2024 14:45:40 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1440F88087
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 14:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso700991a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712580336; x=1713185136; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1Rku3nO0NPT6WyRguG2nB6pIHf2RHdiun797pqWLAs=;
 b=nZUCf57dMoEXRVAZME/4ZvWwqq0+UN1EvYXO8atO1OW9RUk7IOCj9TJSmbiJCdsweN
 bqCitPxixoTZ6GEHnJVPJPZbAuXRe1vDKLCxrDKg61XZ2krYePHQg54fcXIYI6iNPSAL
 dmOCZDuB06dOaSR0I/JGULdPF4sK60Qqpx3sqqTGhaQg/TFH8RIvpvbBNMDaB76/HqTP
 rrSFiJtlTFA2OML1lmq8Wk3V5qVKmIsIclfG+WC30cqby3PdzYTIaeJ6cwLgPzi0386C
 tdUxno+CqA42va16oC93C6D01apX0NM0priwt6BPaKDVf24ahGvPd8OoptSR9zF2gtaM
 eQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712580336; x=1713185136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1Rku3nO0NPT6WyRguG2nB6pIHf2RHdiun797pqWLAs=;
 b=bGd0y20hjdiDBzI18TlFL0/2gDFqXOkEmTLmivDSDnTT6KZ3QvKGur6tW1mEjV6tdK
 6uehgfotfeXqRDfOLGnlgXDev1gceE0gDS6E5JJM1ABaTBQLOpT1bMCIWZZ3HB3I4mSd
 6n3F7QEiZHanZiLzoNmjV2GhatHG3ZJ27ymFdXOrlJjYs4vuTGAxPp3g1d4j4zjvy9XX
 ZbdEpJQ1WwHPgPkkprRPK3BODWRObcw9NwBD7wbZIFBpbi7Vk3LFsULqprY2R23ZT4hz
 77J4qTgGbQgyQxIOcdQB2KlvUa46ybdlP0JqeIXM5KoXDsHTkIKJZhHfypxUXu4EhKmY
 m/Pw==
X-Gm-Message-State: AOJu0YzzlGytf5Vv4qW6sG9kLg7gXFPwvTaYrzJXtNi3QZ6OIGyjY+KG
 5PHW0A6QT7JUFOqQWobNkm7LqOceiwo+j6o42mBy5IbxgsLvUxwgpJ6LzuFwFN/IHcIDBxHdLkH
 w9EQ=
X-Google-Smtp-Source: AGHT+IHtLkZUMVAGc11cpVh2hi6kcyuhe/T2vsT3jitOF1pIRBwdXO3YJvBi/t/aOZNo+NK7CTF4XQ==
X-Received: by 2002:a17:907:2d25:b0:a51:beb9:956d with SMTP id
 gs37-20020a1709072d2500b00a51beb9956dmr5153638ejc.66.1712580336404; 
 Mon, 08 Apr 2024 05:45:36 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::570d? ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 kb3-20020a1709070f8300b00a5191b1a8d8sm4462273ejc.142.2024.04.08.05.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 05:45:36 -0700 (PDT)
Message-ID: <acbc544e-c0d2-44b5-b5a4-85f1e701e037@linaro.org>
Date: Mon, 8 Apr 2024 14:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] board: add support for Schneider HMIBSC board
To: Sumit Garg <sumit.garg@linaro.org>, Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
 <20240405090742.4148304-7-sumit.garg@linaro.org>
 <ZhAOtg6dmD_rBaO4@gerhold.net>
 <CAFA6WYOr06N0re===10E8OWo0TUa-umLZCWpsNwQVndFq8Vn-g@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOr06N0re===10E8OWo0TUa-umLZCWpsNwQVndFq8Vn-g@mail.gmail.com>
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

Hi Sumit,

On 08/04/2024 11:13, Sumit Garg wrote:
> On Fri, 5 Apr 2024 at 20:16, Stephan Gerhold <stephan@gerhold.net> wrote:
>>
>> On Fri, Apr 05, 2024 at 02:37:42PM +0530, Sumit Garg wrote:
>>> Support for Schneider Electric HMIBSC. Features:
>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
>>> - 2GiB RAM
>>> - 64GiB eMMC, SD slot
>>> - WiFi and Bluetooth
>>> - 2x Host, 1x Device USB port
>>> - HDMI
>>> - Discrete TPM2 chip over SPI
>>>
>>> Features enabled in U-Boot:
>>> - RAUC updates
>>> - Environment protection
>>> - USB based ethernet adaptors
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>
>> I don't think this is a big deal but this patch would be a bit easier to
>> skim over if you move the (unmodified?) import of the Linux
>> apq8016-schneider-hmibsc.dts to a separate patch with a clear note in
>> the commit message
>>
>>   - where it comes from (link to Linux patch), and
>>   - that it can be removed again with a future update of the upstream DTs
>>     in U-Boot (once it is applied upstream at least).
>>
>> You kind of have that information in the cover letter but I think it
>> would be good to have it in the commit message.
> 
> Although the general practice in U-Boot is to have the board DTS file
> submitted along with board code, if it makes review easier via
> separating the unmodified import of the board DTS file then I can do
> that.

Given that in a few cycles we intend to drop the DTS you're adding here, 
having a commit we can just revert will make that much simpler.
> 
>>
>>> ---
>>>   arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
>>>   board/schneider/hmibsc/MAINTAINERS        |   6 +
>>>   configs/hmibsc_defconfig                  |  86 ++++
>>>   doc/board/index.rst                       |   1 +
>>>   doc/board/schneider/hmibsc.rst            |  45 ++
>>>   doc/board/schneider/index.rst             |   9 +
>>>   include/configs/hmibsc.h                  |  57 +++
>>>   7 files changed, 695 insertions(+)
>>>   create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
>>>   create mode 100644 board/schneider/hmibsc/MAINTAINERS
>>>   create mode 100644 configs/hmibsc_defconfig
>>>   create mode 100644 doc/board/schneider/hmibsc.rst
>>>   create mode 100644 doc/board/schneider/index.rst
>>>   create mode 100644 include/configs/hmibsc.h
>>>
>>> [...]
>>> diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
>>> new file mode 100644
>>> index 00000000000..66dfa549ce1
>>> --- /dev/null
>>> +++ b/include/configs/hmibsc.h
>>> @@ -0,0 +1,57 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>> +/*
>>> + * Board configuration file for HMIBSC
>>> + *
>>> + * (C) Copyright 2024 Sumit Garg <sumit.garg@linaro.org>
>>> + */
>>> +
>>> +#ifndef __CONFIGS_HMIBSC_H
>>> +#define __CONFIGS_HMIBSC_H
>>> +
>>> +/* PHY needs a longer aneg time */
>>> +#define PHY_ANEG_TIMEOUT             8000
>>> +
>>> +#define HMIBSC_BOOTCOMMAND \
>>> +     "setenv devtype mmc; setenv devnum 0; " \
>>> +     "test -n \"${BOOT_ORDER}\" || setenv BOOT_ORDER \"A B\"; " \
>>> +     "test -n \"${BOOT_A_LEFT}\" || setenv BOOT_A_LEFT 3; " \
>>> +     "test -n \"${BOOT_B_LEFT}\" || setenv BOOT_B_LEFT 3; " \
>>> +     "setenv raucslot; " \
>>> +     "for BOOT_SLOT in \"${BOOT_ORDER}\"; do " \
>>> +     "  if test \"x${raucslot}\" != \"x\"; then " \
>>> +     "      echo \"skip remaining slots...\"; " \
>>> +     "  elif test \"x${BOOT_SLOT}\" = \"xA\"; then " \
>>> +     "    if test ${BOOT_A_LEFT} -gt 0; then " \
>>> +     "      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1; " \
>>> +     "      echo \"Found valid RAUC slot A\"; " \
>>> +     "      setenv raucslot \"rauc.slot=A\"; " \
>>> +     "      setenv raucpart A; setenv distro_bootpart 6;" \
>>> +     "    fi; " \
>>> +     "  elif test \"x${BOOT_SLOT}\" = \"xB\"; then " \
>>> +     "    if test ${BOOT_B_LEFT} -gt 0; then " \
>>> +     "      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1; " \
>>> +     "      echo \"Found valid RAUC slot B\"; " \
>>> +     "      setenv raucslot \"rauc.slot=B\"; " \
>>> +     "      setenv raucpart B; setenv distro_bootpart 7;" \
>>> +     "    fi; " \
>>> +     "  fi; " \
>>> +     "done; " \
>>> +     "if test -n \"${raucslot}\"; then " \
>>> +     "  setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot}; " \
>>> +     "  saveenv; " \
>>> +     "else " \
>>> +     "  echo \"No valid RAUC slot found. Resetting tries to 3\"; " \
>>> +     "  setenv BOOT_A_LEFT 3; " \
>>> +     "  setenv BOOT_B_LEFT 3; " \
>>> +     "  saveenv; " \
>>> +     "  reset; " \
>>> +     "fi; " \
>>> +     "load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
>>> +
>>> +#define CFG_EXTRA_ENV_SETTINGS \
>>> +     "loadaddr=0x90000000\0" \
>>> +     "bootcmd="      HMIBSC_BOOTCOMMAND              "\0"
>>> +
>>
>> The "text-based environment" [1] is preferred nowadays, i.e. defining
>> these inside board/schneider/hmibsc/hmibsc.env instead (similar to how
>> DB410c has its environment defined in
>> board/qualcomm/dragonboard410c/dragonboard410c.env). This should also
>> avoid all the crazy escaping to encode it as C string. :D
> 
> That makes sense, I will convert to that.
> 
>>
>> However, I suspect that right now it would attempt to load this file
>> from board/qualcomm/hmibsc/hmibsc.env since you do not seem to have
>> CONFIG_SYS_VENDOR set correctly. It looks like Caleb removed the option
>> to customize CONFIG_SYS_VENDOR in commit 059d526af312 ("mach-snapdragon:
>> generalise board support"). It might be easiest to add a prompt in
>> arch/arm/mach-snapdragon/Kconfig to allow changing it (similar to
>> CONFIG_SYS_BOARD).
> 
> Although the restriction for Qualcomm being the only vendor for boards
> based on snapdragon SoCs shouldn't be added in the first place but
> since that patch did a lot of things in one go made its review harder.
> However, we can always fix it which I will do for the next version.

CONFIG_DEFAULT_ENV_FILE can be set relative to the source tree root, so 
you can put your .env file anywhere you like and specify the full path.

I'm fine with allowing CONFIG_SYS_VENDOR to be overriden in the same way 
CONFIG_SYS_BOARD can be.
> 
> -Sumit
> 
>>
>> Thanks,
>> Stephan
>>
>> [1]: https://docs.u-boot.org/en/latest/usage/environment.html#text-based-environment

-- 
// Caleb (they/them)
