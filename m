Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3E6C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 08:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9C98785E;
	Wed,  5 Jun 2024 10:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fo1PHVJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B388876D3; Wed,  5 Jun 2024 10:41:58 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED84E882E2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 10:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E1D03F2AC
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717576874;
 bh=jMCAngtVZVAeMJ+qTA1Vaxy2JqLQbxVMB2Uk8eIeR+w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Fo1PHVJjpplu6ofPSXjwIoR0TXaFpqx34k6h6KWfMk4UoLPLdcuvixDkVq01eS3ya
 a1TveSqmOsIW6RZJZX5VdUWGcUb8fFl3JO9NvP3OdfyeDcMT71Om0jf5ylqoi1fjnC
 +aZ5tML3Ab/oo5mtI0bTh2PPWXmdpbXDMMr+7oo6VdlPEXsvlt8WZv7Qtaz7X6e83t
 P4RnvHGUmvMpbeS4cvomqCGpPbpO47zdwsM/qHuAfwtI0fJfUh1hMsdI0R6VEgU7bg
 WukwKlMjJ+at4OrjPkmnEL4Fwie1f+71xqhdp+xVX2kkPhNlCaP31D/jFKEUDAkiam
 yZIrB0lTSLO1Q==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so74266466b.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 01:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717576845; x=1718181645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMCAngtVZVAeMJ+qTA1Vaxy2JqLQbxVMB2Uk8eIeR+w=;
 b=LwrnePu4alK58YNX+BW7RWKqecb2eWk5gC6r+nhXyQUc1cwtDgEuCKamiuHLzun0/g
 Z6RmuQkuTDPmopKuvxZZaFh7c2NP1mreSon4FjGjCYilWuwDQSe9Y7wHHV8q9u1qaNrW
 w8Jyf1EhQYFaux0wWJVipjK+AZa7ZAxUU0zat5IhvuiwNt3mYKtZt4SfSZs2AkBDjRCm
 YZfu2yN34DPZKdhHk3QRZi8qgEiTnDQ13+CDfIePNvRZAAbpYAVDPjt6Sc1fAEwNjnPj
 Gi9eZLiSYQsNzGBwpivsLHZXAnY5RgytlM0xIwuX8ZEMepRIUZorKDk+U8bQ13Ilwpqh
 +lCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiYJiN2DRYentBIVyXjjyl6nbFy7N/MySkHzoyLowbzVZwLaqgmnFl3r9XliBBN00tmIr/+ZbtmlSOpKxlZ/QuT1dtFQ==
X-Gm-Message-State: AOJu0YyXjEphsCygKBptTQr6tbD1mtfssdlFcd7jhe6JulgGAAxywpNL
 rYoeTKm3mBrKkvUTZNdBLQqbWVZPNhP5UQvXUQ47d6+9HDQ0K0ap+ApvdSV6V/Q2+fApW4vex0t
 YXANj2LvRCGA5jx/r5VcVlgLotWBPBHCv6AXBCiDNuNv6/iqF+35i0qSfGulH4Kctgfs=
X-Received: by 2002:a17:906:494b:b0:a68:a476:6957 with SMTP id
 a640c23a62f3a-a69546aebeamr385654466b.24.1717576845636; 
 Wed, 05 Jun 2024 01:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4hzWynySta6RqIiNrHflSiz61L5XXC9CfvWwy678VPa4G3B4lnbTApgyBUFGBc7kvO1hFsQ==
X-Received: by 2002:a17:906:494b:b0:a68:a476:6957 with SMTP id
 a640c23a62f3a-a69546aebeamr385652366b.24.1717576845134; 
 Wed, 05 Jun 2024 01:40:45 -0700 (PDT)
Received: from ?IPV6:2a00:20:6:1be1:448d:2f9:f477:9330?
 ([2a00:20:6:1be1:448d:2f9:f477:9330])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6bc9a615absm26130266b.17.2024.06.05.01.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 01:40:44 -0700 (PDT)
Message-ID: <2ce195a5-e1af-43d6-82bd-252bccaa8e24@canonical.com>
Date: Wed, 5 Jun 2024 10:40:42 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTikFOL3MCOLr+MVg+sGdt3sxcjq6zhbgZxCMyVf-scRdQ@mail.gmail.com>
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

On 29.05.24 18:30, Simon Glass wrote:
> Hi,
> 
> On Tue, 28 May 2024 at 18:38, E Shattow <lucent@gmail.com> wrote:
>>
>> Hi,
>>
>> On Tue, May 28, 2024 at 7:43 AM Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> In U-Boot EFI boot options can already specify both an EFI binary and
>>> an initrd. With this series we can additionally define the matching
>>> device-tree to be loaded in the boot option.
>>>
>>> With the last patch the boot manager will fall back the device-tree
>>> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
>>> on the boot device if no device-tree is specified in the boot
>>> option or via a bootefi command parameter.
>>>
>>
>> As tested the $fdtfile environment variable has no effect on
>> global EFI boot when i.e. EFI/BOOT/BOOTRISCV64.EFI
>> on EFI System Partition and no user-added boot option;
>> $fdtfile env variable is not used with "mmc 0" or whichever
>> global boot option is enabled by default in the boot order.
>>
>> Adding a boot option for EFI/BOOT/BOOTRISCV64.EFI
>> and giving this priority in the boot order allows $fdtfile to
>> be effective here. This is consistent with what is described
>> by the series. Would the global EFI boot also get support
>> for $fdtfile either with this or a later series?
>>
>>> v2:
>>>          Update efi_dp_concat() instead of new function efi_dp_merge().
>>>          Carve out a function efi_load_option_dp_join() which we can
>>>          use both for the eficonfig and the efidebug command.
>>>          Rename variables id_dp, final_dp_size.
>>>          Rename create_initrd_dp() to create_lo_dp_part().
>>>          Use enum as parameter for create_lo_dp_part().
>>>          Put all related changes into one patch.
>>>
>>> Heinrich Schuchardt (8):
>>>    efi_loader: allow concatenation with contained end node
>>>    cmd: eficonfig: add support for setting fdt
>>>    cmd: efidebug: add support for setting fdt
>>>    efi_loader: load device-tree specified in boot option
>>>    efi_loader: move distro_efi_get_fdt_name()
>>>    efi_loader: return binary from efi_dp_from_lo()
>>>    efi_loader: export efi_load_image_from_path
>>>    efi_loader: load distro dtb in bootmgr
>>>
>>>   boot/bootmeth_efi.c                        |  60 +---------
>>>   cmd/eficonfig.c                            |  83 +++++++++----
>>>   cmd/efidebug.c                             | 130 +++++++++++++++------
>>>   include/efi_loader.h                       |  24 +++-
>>>   lib/efi_loader/Makefile                    |   1 +
>>>   lib/efi_loader/efi_bootbin.c               |   2 +-
>>>   lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
>>>   lib/efi_loader/efi_boottime.c              |   3 +-
>>>   lib/efi_loader/efi_device_path.c           |  40 ++++---
>>>   lib/efi_loader/efi_device_path_utilities.c |   2 +-
>>>   lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
>>>   lib/efi_loader/efi_helper.c                |  44 +++++++
>>>   12 files changed, 445 insertions(+), 136 deletions(-)
>>>   create mode 100644 lib/efi_loader/efi_fdt.c
>>>
>>> --
>>> 2.43.0
>>>
>>
> 
> Can we use the best-match compatible approach as expected by the new
> 'make image.fit' in Linux?
> 
> Filenames should be deprecated IMO. I am happy to help work on how to
> do that if you agree.

Hello Simon,

It is the OS that creates boot options. The OS can determine the exact 
dtb file based on the compatible string and the kernel version once per 
kernel upgrade. This is much more efficient than doing the same on every 
boot.

Replacing $fdtfile by a matching logic could make sense. But please 
consider the effect on boot time if have to read through more than 1000 
arm64 dtbs with U-Boot's non-caching file-system drivers.

Best regards

Heinrich
