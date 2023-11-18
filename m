Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301AEC54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AFC186DEE;
	Sat, 18 Nov 2023 23:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Jf8t8UY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB0A86EB8; Sat, 18 Nov 2023 23:52:23 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A892686BFA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2A49F3F6E6
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700347935;
 bh=f5Xp49B1lRu4VSmuEQyP50AUQ+NPhb/PrMOW1P18h+k=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Jf8t8UY+cq7QdRo1m0X+y57Ki/odm3SQs6/66OelCZfGZYnV5u9CFt+zTBo4ZAM2h
 QIfq4WGPPxR9WIzJ6+45udyAOnUK2DMzO0AeMZYtlCXCiYymaQKDhfYma1fFaR/BAR
 yh3qV4LgO9Q24Lips9+GVig8rnBxhNDgN/LfyEtGanxnO5E3QL1UOCOCsYua+63add
 XbUBP3tby34W26ZNwljR3k2+VHc/d7POY1fl4jzcNidc5lRJrUaCnljJNIB/BQXB5c
 Zsg6FTQBFTPTFWmlRAxteBkY0l0/H112DWHgjEIyDEjYyDcF2EMPGiOFtvYm2bEgTW
 JG1KMAxYlRNRQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-332c282a409so108482f8f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 14:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700347934; x=1700952734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5Xp49B1lRu4VSmuEQyP50AUQ+NPhb/PrMOW1P18h+k=;
 b=NgHTyZ1McjxohXLNbh76Izy3XHbFelrXpGWA/P7zxU9TzTRSqeYH123Xyb+1JmvV7E
 w17KktnfSb3FOv6ntsjMUo8gCk7H2sXhLbFJ0bCGTkvWBFea1bDv1ZYuLPZurjWkzbrx
 g5NgX8zhUPKvoAEFvVdwahDk7UEVbWXG4cDyh4/+grivKxA5dIHNJpOu3xJzSCvjFO1G
 y/qbp6oXwGVkdGtlOBakzz0aHEAPiDkbc1f4ncw3rGIdBV+wDh8KTO/3vN0nb/qTn/EO
 LhdoQeJeoGpH7EPc409z7oa8StEp8dBweZ6NqS9wQI3vh9mPCujXmfB+F5xBoxUTk/5G
 FXMw==
X-Gm-Message-State: AOJu0YyRcSZJA0o6Rs3MEV4gX0ZpWDK0mTImwRknFuLiQyP1RLGQsCoD
 8VXDOuewl+EbPLi1cznCSUScN+ny39/grLqXax0f6Bza1Cgfz0NnMkQJHHtkvZ+IXjdK53sGloN
 nsAL75MJLBYRPZrAbeAwvNKBiTHeT1Po6B10cNzI=
X-Received: by 2002:a05:6000:2ab:b0:32f:bed7:ed82 with SMTP id
 l11-20020a05600002ab00b0032fbed7ed82mr2600784wry.4.1700347934463; 
 Sat, 18 Nov 2023 14:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFART4C63YkCRrQhGckSG7BoCrapgjHgwuexXULZg6AmND+Tg0SlZYJqM9CIeRj79vUDDMrrg==
X-Received: by 2002:a05:6000:2ab:b0:32f:bed7:ed82 with SMTP id
 l11-20020a05600002ab00b0032fbed7ed82mr2600773wry.4.1700347933912; 
 Sat, 18 Nov 2023 14:52:13 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 z16-20020adfe550000000b0032db4e660d9sm6449006wrm.56.2023.11.18.14.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 14:52:13 -0800 (PST)
Message-ID: <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
Date: Sat, 18 Nov 2023 23:52:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bootstd: Support for distro specific EFI folders
Content-Language: en-US, de-DE
To: Shantur Rathore <i@shantur.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
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

On 11/18/23 22:28, Shantur Rathore wrote:
> Hi Heinrich,
> 
> On Fri, Nov 17, 2023 at 3:12 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 11/16/23 19:45, Shantur Rathore wrote:
>>> On Thu, Nov 16, 2023 at 6:15 PM Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 11/16/23 17:52, Shantur Rathore wrote:
>>>>> Hi Simon,
>>>>>
>>>>> Currently bootstd - bootmethod_efi only looks for the default
>>>>> bootxx64.efi in /EFI/boot folder only.
>>>>> Generally many distros end up putting their bootloaders in
>>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
>>>>>
>>>>> In x86 worlds, the NVRAM is modified and new boot entries are added to
>>>>> support these but in the U-boot world the NVRAM variables are
>>>>> read-only.
>>>>
>>>> I guess you are referring to UEFI boot options. These typically are not
>>>> stored in non-volatile RAM but on a SPI flash device.
>>>>
>>>
>>> Thanks for correcting me.
>>>
>>>>>
>>>>> What would be the best way to implement this?
>>>>>
>>>>> I was thinking of having a "efi_prefixes" environment variable which
>>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
>>>>> all of them. Will bootmethod_efi be able to support multiple entries (
>>>>> thinking of multiboot ) ?
>>>>
>>>> On my laptop I have:
>>>>
>>>> EFI/Microsoft/Boot/bootmgr.efi
>>>> EFI/Microsoft/Boot/memtest.efi
>>>> EFI/Boot/bootx64.efi
>>>> EFI/Boot/fbx64.efi
>>>> EFI/Boot/mmx64.efi
>>>> EFI/debian/shimx64.efi
>>>> EFI/debian/grubx64.efi
>>>> EFI/debian/mmx64.efi
>>>> EFI/debian/fbx64.efi
>>>> EFI/ubuntu/grubx64.efi
>>>> EFI/ubuntu/shimx64.efi
>>>> EFI/ubuntu/mmx64.efi
>>>>
>>>> Obviously each installed operating system provides multiple EFI binaries
>>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
>>>> debian centos" would not be able to describe which file you are looking
>>>> for.
>>>>
>>>> We already have the U-Boot command line eficonfig and efidebug commands
>>>> to set up UEFI boot options which can describe which EFI binary to load
>>>> and which command line to pass to it. These are considered by the
>>>> existing boot flows.
>>>
>>> So, I am building a new RockPro64 based cluster and using Canonical
>>> MAAS to set them up automatically, booting them up using DHCP and
>>> installing them over the network.
>>> I configured an Armbian image using Packer to be compatible with MAAS
>>> and it happily installs it. As part of installation process, a
>>> grub-install is run which installs the grub efi,
>>> this EFI ends up in EFI/debian instead of expected EFI/boot.
>>> To be able to make it boot, I have to add commands to move it to
>>> EFI/boot. I am trying to find a way in U-Boot that would allow me to
>>> skip this step.
>>> With eficonfig if I understand correctly, it would need manual
>>> intervention to create boot entries.
>>>
>>>>
>>>> If you are installing the shim-signed package on Ubuntu, the EFI boot
>>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content
>>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and
>>>> therefore should work with current U-Boot.
>>>>
>>>> Patches are pending upstream to make EFI variables writable from Linux
>>>> if they are stored in the RPMB partition in the eMMC. See this series:
>>>>
>>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@linaro.org/
>>>>
>>>
>>> Would it be possible to save it in SPI Flash as the U-Boot environment ?
>>
>> Currently this is not supported by U-Boot.
>>
>> The U-Boot environment variables can be stored in lots of different
>> places SPI flash is only one of these. But none of these locations is
>> protected from OS access which would be preferable for UEFI variables
>> for security reasons.
>>
>> To support boards without eMMC the right way forward would be writing a
>> new implementation of the OP-TEE standalone MM which writes the
>> variables to SPI flash instead of the RPMB partition and ensures that
>> the SPI flash' MMIO registers are protected against access from the
>> non-secure world.
> 
> Thanks for explaining this to me.
> This seems like a long way to go, for now what would be an acceptable
> solution, some options are
> 
> 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
> debian") variable which is ready by bootmeth_efi and used as
> efi/<efi_prefix> instead of efi/boot.
> 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
> present all them as bootflows to bootstd.

As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxxx.efi 
don't exist. I would prefer not to add any distro specific stuff in 
upstream U-Boot. Instead we will continue to drive what Linaro has 
suggested to improve U-Boot EFI variables support in Linux.

Best regards

Heinrich
