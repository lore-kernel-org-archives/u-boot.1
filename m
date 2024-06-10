Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3ACC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349578864A;
	Mon, 10 Jun 2024 18:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZL0ye9ZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A054388648; Mon, 10 Jun 2024 18:10:14 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBEBC88652
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 36C663F6A6
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718035811;
 bh=cOy/0TsxFSpW/sxHkB9VG+15vNzExiUXhNIXnbcTHos=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ZL0ye9ZSdO+wF9V6WkSUVsqmAR8CdRnSvyRaEej5qNBPOCS3CsassG8iTENffb/m2
 aDvp4lzcMbXl9nThfqCMSYe2/JYrFO7iFLwmhmDP3FkTT9rbVNWGEvL0GgW8/tqeq6
 tJOg/mQqtYQTBNa4qMKNdGpzlbXW8U6twTpWMZkK2WHVjDWHMdi0/LSwAl6BIEiM56
 WdKUDOjnqggn6luBC+OVHCIJWBfeBX4fwz/0B+89ixk3FBSSHM/2ecywpxzpefzQO9
 8RwZ4mEg+/uvbQi4muzNruNeCFv1VKRlYkc1vBA2qqFcLWHgXKnUz2jVzxbyVHSd7+
 AkMcYqwsQ+mnA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35f2730d114so660117f8f.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718035811; x=1718640611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cOy/0TsxFSpW/sxHkB9VG+15vNzExiUXhNIXnbcTHos=;
 b=Cq5ptrFGhavpGNi3CzXIcFiiMmw54XdcHhGQH0z94wi0kragCV5FdBEzmPFLXPQhg1
 vGSz7Na19RYWG1kbEZ3cHhMqzI9D53UHgDhzpwETGJ89PQrKDe9aCw6dTJr5h/83clK4
 f+FS2E18HuH+v7kNyIQJ6zoJA7RYhy+vewqv/YbmaKPy1tkSSd74u0IMCgHWWASeuuFo
 WQi7tt7Ul0C9VFQooUpqpZu4uLo63Ja4+aanlzTjXvgbwLwOfCODbmCFWpJ4a34vKXT4
 FUdnYCH0R4tjjwuRqcEkxDC4Gf4HB9eciC+AFjg69xG1LFOPg8CB1l8rxO1/zNoUQOsK
 StAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXj+VkqtkR2TQN5b7BWc+wYXiGbcksQHPhN1RcWS431SSY/Oy5hHv6zC3e8yd06Dm3Z7wpRiZuQJUiijLdefhAkSVQBQ==
X-Gm-Message-State: AOJu0Yx+8ge4L+ZeLwjZTvWVOg7HGRuOUUGo5djRBbmdAYs8o2Rn0Kzs
 BunJxpvsPTIIGsF2LfBkrLyzXQoyjIO3jB0OIAd5edMlsHX5NxIZrlOObW6lrFvtEhLy5+DbBTF
 ndILHUgAvrC4mobDKVH73Q5XIsbrAZ7NRyskU+fyg/725yLFNAT6aCGwSgeSANjX9ymI=
X-Received: by 2002:adf:ef06:0:b0:35f:1796:3394 with SMTP id
 ffacd0b85a97d-35f2b27bd92mr122630f8f.8.1718035810879; 
 Mon, 10 Jun 2024 09:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzHR3K2+P/hEimY+oCGnsZGcBztPryVyk8FOJzz1WzZUZPP58pNPwxqjCCYBV1BdAZ4aLKDQ==
X-Received: by 2002:adf:ef06:0:b0:35f:1796:3394 with SMTP id
 ffacd0b85a97d-35f2b27bd92mr122597f8f.8.1718035810439; 
 Mon, 10 Jun 2024 09:10:10 -0700 (PDT)
Received: from ?IPV6:2a00:20:43:88b5:6b2b:e162:4c45:5c4c?
 ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1dc8e2a2sm4998425f8f.106.2024.06.10.09.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 09:10:09 -0700 (PDT)
Message-ID: <b0eaacea-d1a4-4e6e-ad2e-01f87c18e177@canonical.com>
Date: Mon, 10 Jun 2024 18:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] efi_loader: improve device-tree loading
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Shantur Rathore <i@shantur.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgcnftK=GqZ0LGue2Y8-YkRhOKzPuc4Yf1CvhzAGO+MTg@mail.gmail.com>
 <a9462414-c8f7-4a2a-9dd0-f39ee24876f8@canonical.com>
 <CAFLszThgyRrWnjDa9iXB14Lcm1LPeh+5M7p_YKDg9ZjFmr0JXA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThgyRrWnjDa9iXB14Lcm1LPeh+5M7p_YKDg9ZjFmr0JXA@mail.gmail.com>
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

On 10.06.24 17:54, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 10 Jun 2024 at 08:00, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 10.06.24 15:53, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Mon, 10 Jun 2024 at 03:11, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> In U-Boot EFI boot options can already specify both an EFI binary and
>>>> an initrd. With this series we can additionally define the matching
>>>> device-tree to be loaded in the boot option.
>>>>
>>>> With the last patch the boot manager will fall back the device-tree
>>>> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
>>>> on the boot device if no device-tree is specified in the boot
>>>> option or via a bootefi command parameter.
>>>>
>>>> v3:
>>>>           Add missing '@' in EFI_LP_DP_PART_FDT description.
>>>>           Use calloc() instead of malloc() in load_fdt_from_load_option().
>>>>           Add missing '@' in load_fdt_from_load_option function description
>>>>           Rename struct efi_initrd_dp to efi_lo_dp_prefix.
>>>>
>>>> v2:
>>>>           Update efi_dp_concat() instead of new function efi_dp_merge().
>>>>           Carve out a function efi_load_option_dp_join() which we can
>>>>           use both for the eficonfig and the efidebug command.
>>>>           Rename variables id_dp, final_dp_size.
>>>>           Rename create_initrd_dp() to create_lo_dp_part().
>>>>           Use enum as parameter for create_lo_dp_part().
>>>>           Put all related changes into one patch.
>>>>
>>>> Heinrich Schuchardt (8):
>>>>     efi_loader: allow concatenation with contained end node
>>>>     cmd: eficonfig: add support for setting fdt
>>>>     cmd: efidebug: add support for setting fdt
>>>>     efi_loader: load device-tree specified in boot option
>>>>     efi_loader: move distro_efi_get_fdt_name()
>>>>     efi_loader: return binary from efi_dp_from_lo()
>>>>     efi_loader: export efi_load_image_from_path
>>>>     efi_loader: load distro dtb in bootmgr
>>>>
>>>>    boot/bootmeth_efi.c                        |  60 +---------
>>>>    cmd/eficonfig.c                            |  83 +++++++++----
>>>>    cmd/efidebug.c                             | 130 +++++++++++++++------
>>>>    include/efi_loader.h                       |  24 +++-
>>>>    lib/efi_loader/Makefile                    |   1 +
>>>>    lib/efi_loader/efi_bootbin.c               |   2 +-
>>>>    lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
>>>>    lib/efi_loader/efi_boottime.c              |   3 +-
>>>>    lib/efi_loader/efi_device_path.c           |  40 ++++---
>>>>    lib/efi_loader/efi_device_path_utilities.c |   2 +-
>>>>    lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
>>>>    lib/efi_loader/efi_helper.c                |  44 +++++++
>>>>    12 files changed, 445 insertions(+), 136 deletions(-)
>>>>    create mode 100644 lib/efi_loader/efi_fdt.c
>>>>
>>>
>>> Somewhat related, what work has been done to support FIT, or to locate
>>> a DT using the compatible string?
>>
>> CONFIG_BOOTM_EFI allows booting a FIT image containing an EFI binary and
>> optionally a device-tree. You can manually select a configuration when
>> invoking the bootm command. I am not aware of any automation for this
>> selection.
> 
> Thanks for the info.
> 
> Can we perhaps require FIT_BEST_MATCH and then provide a way? All this
> filename stuff is missing the point, really. It isn't going to get any
> easier, either.
> 

Thanks for the pointer. FIT_BEST_MATCH would allow to select a matching 
device-tree from a FIT image. But any solution using FIT images will not 
not be compatible to other firmware.

As a distro I would prefer a solution that runs on any EFI firmware, 
e.g. EDK II. Being able to use the same image on all boards of the same 
architecture was the motivator for Suse to start U-Boot's EFI 
implementation.

Best regards

Heinrich
