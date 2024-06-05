Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797F0C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB08D882E6;
	Wed,  5 Jun 2024 16:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W9vpTDNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C19882E8; Wed,  5 Jun 2024 16:04:49 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2598E88250
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 12BAC3F2A5
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717596286;
 bh=SPR/A/DHoH1QJ6nBwZWxSLhWDwKjX9P4vLgUO7jjK7w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=W9vpTDNR6qYY4bktTTA47pWIzASBtugrByG9zRA+6RnKXfyhJ+CHh/7VuAOpjWrIA
 tbD06wYHBRLjNv374HxdyX8u6m+OyFTT4HHGMjEofADQDqIVQEoH4cnbxyMKciFcPr
 if8Wlazk7v3TM+yQT2Y/ZUAH5fuCmiUaiMqGwZo/H/88GwbZWd6g0eLdYlOZgemjQ2
 74v03vIJp4CkF7lShTBtHfP758vF8HpKVcJDFoJhFNZhOcKQjy3WVpOUUu0P9HKcKE
 SizWDzZZjs6V7+XvzyvjkktF4ARn+BBz3t/Pc7D8nktTOn/e7C8BugBzhE1UyjAhLd
 4CywMhla8L2mg==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5234e83c4a6so1653897e87.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596285; x=1718201085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPR/A/DHoH1QJ6nBwZWxSLhWDwKjX9P4vLgUO7jjK7w=;
 b=DVMNFUpWcchhJoaImZfMl/AaMa2GnOVH7AhKPKLbSjt0SVUu0M1zjjRpczfYSaOiAf
 Qyc+IAwWEdiwcjZ9OY9abU2ZGI/ZLTIPAOiSwEoEh0mbF9Qkwus8jQFxvyUOMjncFwsM
 nERc0a8JE/GOuZBnh34SrhdW/ZIZhFXG7yf1/Ngvt13NmSEH2ZPGOtCD2q35U5AD6QdW
 so8FWT77HCagXbzshgnM6SByd4icZqi4zu26YCvUGucl102Mwx46NHxAjV0po/boD4xY
 8CxYDv18HgkmrPJEpy5omY5DrH5TNCFgZHWmyQRqnAUR5S+Fpxb/rU3id95X6McuV6us
 hPrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRrsehSwJGW3dF0lDbu5gg78TPZxTMVw+Xxlx8/qfRk4rNkDMp+g36CGaC+GAsluJhTVmp1yjEeIiMkyMCYtLXR70oyg==
X-Gm-Message-State: AOJu0Yyevh4VZOcad1YWXzDaYY9nPaQsiM8MUmkrq4CnBIYRwO32fKQQ
 YHDBSF2E+zR7/HXpfd1/a8ySN0HaCgRZ2LbZVZmO6XgKuKg2qJrnUQfOYnuBNHOvvh1cgNMiPVQ
 mlX8h3FbzNTw8vTn8Qq93wDNNbVg/l7ZgGKIiP3LTuu0FQgJEU2b5rZYVgafoWZ1CEIA=
X-Received: by 2002:a05:6512:481:b0:51c:15fa:b08 with SMTP id
 2adb3069b0e04-52bab510900mr1393913e87.69.1717596284971; 
 Wed, 05 Jun 2024 07:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiPdJba19Av0Xpxaov5LlTX5fmOpmXF3ZEmWbp99UaRdrKjt5uI7YoyfmWfL7rkAn0+ecA6Q==
X-Received: by 2002:a05:6512:481:b0:51c:15fa:b08 with SMTP id
 2adb3069b0e04-52bab510900mr1393889e87.69.1717596284500; 
 Wed, 05 Jun 2024 07:04:44 -0700 (PDT)
Received: from ?IPV6:2a00:20:6:1be1:448d:2f9:f477:9330?
 ([2a00:20:6:1be1:448d:2f9:f477:9330])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066ff17sm14587933f8f.116.2024.06.05.07.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 07:04:43 -0700 (PDT)
Message-ID: <892d2574-37ba-450e-a3bb-43152103e6d9@canonical.com>
Date: Wed, 5 Jun 2024 16:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] efi_loader: improve device-tree loading
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Shantur Rathore <i@shantur.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 E Shattow <lucent@gmail.com>
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <CANV2PTOAc50sXtz2V6s7bgnEk02TV_7+VArxBpHhF_tCGNjsmA@mail.gmail.com>
 <CAFLszTikFOL3MCOLr+MVg+sGdt3sxcjq6zhbgZxCMyVf-scRdQ@mail.gmail.com>
 <2ce195a5-e1af-43d6-82bd-252bccaa8e24@canonical.com>
 <CAFLszTj2aoxmPJUFo7CFq9u5kD2mBRbJxmNVm5xXmjrBGN7=Rg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTj2aoxmPJUFo7CFq9u5kD2mBRbJxmNVm5xXmjrBGN7=Rg@mail.gmail.com>
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

On 05.06.24 15:17, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 5 Jun 2024 at 02:40, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 29.05.24 18:30, Simon Glass wrote:
>>> Hi,
>>>
>>> On Tue, 28 May 2024 at 18:38, E Shattow <lucent@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, May 28, 2024 at 7:43 AM Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> In U-Boot EFI boot options can already specify both an EFI binary and
>>>>> an initrd. With this series we can additionally define the matching
>>>>> device-tree to be loaded in the boot option.
>>>>>
>>>>> With the last patch the boot manager will fall back the device-tree
>>>>> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
>>>>> on the boot device if no device-tree is specified in the boot
>>>>> option or via a bootefi command parameter.
>>>>>
>>>>
>>>> As tested the $fdtfile environment variable has no effect on
>>>> global EFI boot when i.e. EFI/BOOT/BOOTRISCV64.EFI
>>>> on EFI System Partition and no user-added boot option;
>>>> $fdtfile env variable is not used with "mmc 0" or whichever
>>>> global boot option is enabled by default in the boot order.
>>>>
>>>> Adding a boot option for EFI/BOOT/BOOTRISCV64.EFI
>>>> and giving this priority in the boot order allows $fdtfile to
>>>> be effective here. This is consistent with what is described
>>>> by the series. Would the global EFI boot also get support
>>>> for $fdtfile either with this or a later series?
>>>>
>>>>> v2:
>>>>>           Update efi_dp_concat() instead of new function efi_dp_merge().
>>>>>           Carve out a function efi_load_option_dp_join() which we can
>>>>>           use both for the eficonfig and the efidebug command.
>>>>>           Rename variables id_dp, final_dp_size.
>>>>>           Rename create_initrd_dp() to create_lo_dp_part().
>>>>>           Use enum as parameter for create_lo_dp_part().
>>>>>           Put all related changes into one patch.
>>>>>
>>>>> Heinrich Schuchardt (8):
>>>>>     efi_loader: allow concatenation with contained end node
>>>>>     cmd: eficonfig: add support for setting fdt
>>>>>     cmd: efidebug: add support for setting fdt
>>>>>     efi_loader: load device-tree specified in boot option
>>>>>     efi_loader: move distro_efi_get_fdt_name()
>>>>>     efi_loader: return binary from efi_dp_from_lo()
>>>>>     efi_loader: export efi_load_image_from_path
>>>>>     efi_loader: load distro dtb in bootmgr
>>>>>
>>>>>    boot/bootmeth_efi.c                        |  60 +---------
>>>>>    cmd/eficonfig.c                            |  83 +++++++++----
>>>>>    cmd/efidebug.c                             | 130 +++++++++++++++------
>>>>>    include/efi_loader.h                       |  24 +++-
>>>>>    lib/efi_loader/Makefile                    |   1 +
>>>>>    lib/efi_loader/efi_bootbin.c               |   2 +-
>>>>>    lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
>>>>>    lib/efi_loader/efi_boottime.c              |   3 +-
>>>>>    lib/efi_loader/efi_device_path.c           |  40 ++++---
>>>>>    lib/efi_loader/efi_device_path_utilities.c |   2 +-
>>>>>    lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
>>>>>    lib/efi_loader/efi_helper.c                |  44 +++++++
>>>>>    12 files changed, 445 insertions(+), 136 deletions(-)
>>>>>    create mode 100644 lib/efi_loader/efi_fdt.c
>>>>>
>>>>> --
>>>>> 2.43.0
>>>>>
>>>>
>>>
>>> Can we use the best-match compatible approach as expected by the new
>>> 'make image.fit' in Linux?
>>>
>>> Filenames should be deprecated IMO. I am happy to help work on how to
>>> do that if you agree.
>>
>> Hello Simon,
>>
>> It is the OS that creates boot options. The OS can determine the exact
>> dtb file based on the compatible string and the kernel version once per
>> kernel upgrade. This is much more efficient than doing the same on every
>> boot.
>>
>> Replacing $fdtfile by a matching logic could make sense. But please
>> consider the effect on boot time if have to read through more than 1000
>> arm64 dtbs with U-Boot's non-caching file-system drivers.
> 
> The suggested option here is to use FIT, which is very fast at
> scanning the files. Please see [1]
> 
> Failing that, we could implement a way (in FIT) of specifying that the
> FDT is in an external file. In that case FIT would become a mapping
> from compatible strings to filenames.

FIT has no place in UEFI.

Best regards

Heinrich
