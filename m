Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5313C2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E54C86A3C;
	Sun, 19 Nov 2023 01:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Gx5Wde0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97F386BA4; Sun, 19 Nov 2023 01:58:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8455869CA
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2219A3F0CB
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700355511;
 bh=U9HiRZkMeDY22ZAOHkt9fNL4Q7Dx5T/I+u3VV+Irtz8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Gx5Wde0S1ZfneUdx1Xv9hpwNRuHGW3zkxRccHmFX7ergHwj3Z1ryNfsrECZxLYdz+
 EzFwnivF7rUNurSTENOjji31OxeOQ2GEXYpFgfIurb+Gy3FvarjkVO6GRme936OXrW
 zUd/Vi5iQvtHC3k1Ih2hoc1tFeYnCQfAbqZnmWrt4fcdTKweKxLWKTfVJGZ7PaHMTv
 jMZDJgTU99MuCrQCxqMQqJRmykD19lRwlP/1b32gfcxPjzhYyfL38fwSI3F5GmUPKc
 bUAJPRm1gvcrd0OJKGNq5Zd4CNji3Avbw/XLaYFilSFpOMWd5Y65GNErbhQycVaV10
 6ayNdEsYyKZQQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3314bd215ceso1702961f8f.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700355510; x=1700960310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9HiRZkMeDY22ZAOHkt9fNL4Q7Dx5T/I+u3VV+Irtz8=;
 b=mYu9SD3x5N/1AtgyoGkUbM498y0SE4LuDyGDHVHm8FO3Up/XanmudVCMxj83n+GAmE
 IZNg6SYUzNQRAa54JUef4vtCAMYPKTodPdNlqvg+cYSVzONFnB3JTfZtl7cAl8ov4hnY
 XTI0UJRiprLvOEpdf8n2m3U7hElP3QpDN5o2Sx3a4NKeBFXhgTu2xrQYN/MvfVpHVl77
 XnziCZPd+YPFF5baMqLAx3nHG1fuFmm43umtFQmwZAzrNGSEFws3ehH4imnuzBJ6oN5x
 FR0Iom3QiVbG0ddlrXFlaYOAYoGslTb2sNYVEvXr9/nc95lCvNZBHgdbRWuj0qpo1wUX
 6BUw==
X-Gm-Message-State: AOJu0YzOZD2fdm6PyPxRCKHovw0/oAqilbo8/BYJkdx1NXDu9BNhWZ2U
 kkj2e4HI+tXbyQ9NTjk4MvL1zMDOdd9K6Zgyzqyedb/op8+ENFEP/u6/6eCpWG9nUWS4BsYmpEm
 l+MKjDAt7/Qp7cyN1hRJakRdn8IMWQeI=
X-Received: by 2002:a05:6000:1845:b0:32d:a4e5:d3d1 with SMTP id
 c5-20020a056000184500b0032da4e5d3d1mr2858473wri.4.1700355510562; 
 Sat, 18 Nov 2023 16:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfYAfN9koD2d2jVVH/uhsQcuzLZeFRgEPvl08KMX+2vQMBpK/bo2VSgavb9BE0keSsGn60xw==
X-Received: by 2002:a05:6000:1845:b0:32d:a4e5:d3d1 with SMTP id
 c5-20020a056000184500b0032da4e5d3d1mr2858455wri.4.1700355510024; 
 Sat, 18 Nov 2023 16:58:30 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 v8-20020adff688000000b0032daf848f68sm6672643wrp.59.2023.11.18.16.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 16:58:29 -0800 (PST)
Message-ID: <8c68e719-e83a-4150-a872-333830ceeda4@canonical.com>
Date: Sun, 19 Nov 2023 01:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bootstd: Support for distro specific EFI folders
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <CAPnjgZ0vGdszyJaJtU_YqBFR7ZqtnMgkN6EwVT=td7FmPY0k8Q@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ0vGdszyJaJtU_YqBFR7ZqtnMgkN6EwVT=td7FmPY0k8Q@mail.gmail.com>
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

On 11/19/23 01:43, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 18 Nov 2023 at 15:52, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 11/18/23 22:28, Shantur Rathore wrote:
>>> Hi Heinrich,
>>>
>>> On Fri, Nov 17, 2023 at 3:12 PM Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 11/16/23 19:45, Shantur Rathore wrote:
>>>>> On Thu, Nov 16, 2023 at 6:15 PM Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> On 11/16/23 17:52, Shantur Rathore wrote:
>>>>>>> Hi Simon,
>>>>>>>
>>>>>>> Currently bootstd - bootmethod_efi only looks for the default
>>>>>>> bootxx64.efi in /EFI/boot folder only.
>>>>>>> Generally many distros end up putting their bootloaders in
>>>>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
>>>>>>>
>>>>>>> In x86 worlds, the NVRAM is modified and new boot entries are added to
>>>>>>> support these but in the U-boot world the NVRAM variables are
>>>>>>> read-only.
>>>>>>
>>>>>> I guess you are referring to UEFI boot options. These typically are not
>>>>>> stored in non-volatile RAM but on a SPI flash device.
>>>>>>
>>>>>
>>>>> Thanks for correcting me.
>>>>>
>>>>>>>
>>>>>>> What would be the best way to implement this?
>>>>>>>
>>>>>>> I was thinking of having a "efi_prefixes" environment variable which
>>>>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
>>>>>>> all of them. Will bootmethod_efi be able to support multiple entries (
>>>>>>> thinking of multiboot ) ?
>>>>>>
>>>>>> On my laptop I have:
>>>>>>
>>>>>> EFI/Microsoft/Boot/bootmgr.efi
>>>>>> EFI/Microsoft/Boot/memtest.efi
>>>>>> EFI/Boot/bootx64.efi
>>>>>> EFI/Boot/fbx64.efi
>>>>>> EFI/Boot/mmx64.efi
>>>>>> EFI/debian/shimx64.efi
>>>>>> EFI/debian/grubx64.efi
>>>>>> EFI/debian/mmx64.efi
>>>>>> EFI/debian/fbx64.efi
>>>>>> EFI/ubuntu/grubx64.efi
>>>>>> EFI/ubuntu/shimx64.efi
>>>>>> EFI/ubuntu/mmx64.efi
>>>>>>
>>>>>> Obviously each installed operating system provides multiple EFI binaries
>>>>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
>>>>>> debian centos" would not be able to describe which file you are looking
>>>>>> for.
>>>>>>
>>>>>> We already have the U-Boot command line eficonfig and efidebug commands
>>>>>> to set up UEFI boot options which can describe which EFI binary to load
>>>>>> and which command line to pass to it. These are considered by the
>>>>>> existing boot flows.
>>>>>
>>>>> So, I am building a new RockPro64 based cluster and using Canonical
>>>>> MAAS to set them up automatically, booting them up using DHCP and
>>>>> installing them over the network.
>>>>> I configured an Armbian image using Packer to be compatible with MAAS
>>>>> and it happily installs it. As part of installation process, a
>>>>> grub-install is run which installs the grub efi,
>>>>> this EFI ends up in EFI/debian instead of expected EFI/boot.
>>>>> To be able to make it boot, I have to add commands to move it to
>>>>> EFI/boot. I am trying to find a way in U-Boot that would allow me to
>>>>> skip this step.
>>>>> With eficonfig if I understand correctly, it would need manual
>>>>> intervention to create boot entries.
>>>>>
>>>>>>
>>>>>> If you are installing the shim-signed package on Ubuntu, the EFI boot
>>>>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content
>>>>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and
>>>>>> therefore should work with current U-Boot.
>>>>>>
>>>>>> Patches are pending upstream to make EFI variables writable from Linux
>>>>>> if they are stored in the RPMB partition in the eMMC. See this series:
>>>>>>
>>>>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@linaro.org/
>>>>>>
>>>>>
>>>>> Would it be possible to save it in SPI Flash as the U-Boot environment ?
>>>>
>>>> Currently this is not supported by U-Boot.
>>>>
>>>> The U-Boot environment variables can be stored in lots of different
>>>> places SPI flash is only one of these. But none of these locations is
>>>> protected from OS access which would be preferable for UEFI variables
>>>> for security reasons.
>>>>
>>>> To support boards without eMMC the right way forward would be writing a
>>>> new implementation of the OP-TEE standalone MM which writes the
>>>> variables to SPI flash instead of the RPMB partition and ensures that
>>>> the SPI flash' MMIO registers are protected against access from the
>>>> non-secure world.
>>>
>>> Thanks for explaining this to me.
>>> This seems like a long way to go, for now what would be an acceptable
>>> solution, some options are
>>>
>>> 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
>>> debian") variable which is ready by bootmeth_efi and used as
>>> efi/<efi_prefix> instead of efi/boot.
>>> 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
>>> present all them as bootflows to bootstd.
>>
>> As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxxx.efi
>> don't exist. I would prefer not to add any distro specific stuff in
>> upstream U-Boot. Instead we will continue to drive what Linaro has
>> suggested to improve U-Boot EFI variables support in Linux.
> 
> Is there any metadata in the distro which U-Boot could read to find
> out where the EFI file is?

The standardized way to define that meta-data are boot options.

Besides EFI/<vendor>/*.efi installers typically leave a 
/EFI/BOOT/BOOT<arch>.EFI on the ESP which U-Boot will pick up by default 
if no boot option is specified. If Armbian does not do this, it might be 
something to fix there.

Best regards

Heinrich
