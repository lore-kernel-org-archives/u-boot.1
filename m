Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B0CC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A79D8756C;
	Sun,  3 Dec 2023 18:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Vr/NLRcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9A887575; Sun,  3 Dec 2023 18:53:20 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8716D87519
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DA7AF3F193
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701625993;
 bh=GU5+08/v0wkvuGmglDcCMguN6vA8547jwD1Sg5aBYX4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Vr/NLRcERVO1tpOxM5ZzXpf6R7E6yr0I2BKCuAKTwKMq5a+4qKWZe6FVuE78SQhN0
 GvIk3gs4Sc95XEc000ArUSH1e0vPnV8JpgOycyEYPNo8GJM7qSvHbB7sYXn/4RFaWc
 lWgDlNx9+EJzSwWQLdkn4Fl3FyUW8xxJbkI/ox9Q5qBnhQLKBmtCRH4/m/3R12jBHC
 nvfdTwCp4lKRjeXZ2r9wjNpzcYIEwngb9K7xOVc7Yb3Dis2iJKaHJmwawfmM8qFYCn
 AEyzSZsosoABn1uXJ9m1xF/PvVqDofPlR/i8EiM5M6WrgB+VSxu4rH65WFllub3XrW
 mOxli/3NnyX/g==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-332fcd4b871so2054153f8f.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625992; x=1702230792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GU5+08/v0wkvuGmglDcCMguN6vA8547jwD1Sg5aBYX4=;
 b=VPo+GMmQi625qykAbZz24PEqqTH36/PsZHOUhMUrzX+HFsIhonyHP/LbWESRCdHjqh
 6Qw1Gv4Yc715iMTGZDtWz21rm6OhWUlCe12AE4gPyMz64O2kg0X/1flIkH0ybSUdq7gm
 J/VKEirZb4gePvHoCIGPdISl3S1ptQLUv35RLkyApI+o/ctpzJyt6NJy4alJyum/o6p+
 umzSH1zNyTBixKIiFaNB0FW7pApqZM/z9Zm/3XD1esCYAeNrTknFmBPX3m/nXhTacQPQ
 bcfJkEL5mYnUT0xAsa5b5zTzq4XFza5cIQw9jmoAHFkMGFZPw3ZYCSqs536N/UrLBIL4
 oK3g==
X-Gm-Message-State: AOJu0YyNr7S97Sn2NmmTbIckufShpZVoPZUn0m0C8Sx2mdXCDkusyImj
 c/R+PeHicP8DeeoB39dnM0DTSt72mBEjOC90UPG+v5ZBg0JKzvZcNQ4iXtMCw0dnlo9La4h6PA/
 +AYQQ4qX0H9Cd4QTskEKTFuXRAf0S980=
X-Received: by 2002:a05:600c:138d:b0:40b:2a46:6f1 with SMTP id
 u13-20020a05600c138d00b0040b2a4606f1mr2428784wmf.2.1701625992392; 
 Sun, 03 Dec 2023 09:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9+PAkUBJXknciZcSLXwBpmN8F5izot7/qgr3/mu/fk8d0hp2bTy5+z4tzZ9W8hOClgL+X1w==
X-Received: by 2002:a05:600c:138d:b0:40b:2a46:6f1 with SMTP id
 u13-20020a05600c138d00b0040b2a4606f1mr2428779wmf.2.1701625991935; 
 Sun, 03 Dec 2023 09:53:11 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 y17-20020a5d4ad1000000b00333415503a7sm2403779wrs.22.2023.12.03.09.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 09:53:11 -0800 (PST)
Message-ID: <671228f5-8a11-4be9-b8fe-1331232e7498@canonical.com>
Date: Sun, 3 Dec 2023 18:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bootstd: Support for distro specific EFI folders
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 trini@konsulko.com
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjJWgTS6Os7fp4jP=u1+osBccndoR+CBgFUt2nb04RWwWA@mail.gmail.com>
 <CAPnjgZ04C=_MoCjKBYUdmBXyQn-zviAMQJxMHQAfj1MwvqOMzw@mail.gmail.com>
 <CAHc5_t2mQGQ4WLSXjh105QXnxMTeF3=x69N28dDiSdRMBHq3kg@mail.gmail.com>
 <1e2bad87-3372-452d-ae27-01c100378ecf@canonical.com>
 <CAPnjgZ05pDOATqw9wha-pOZsgjCF-4dgLL7-a4r-JPUjtMospg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ05pDOATqw9wha-pOZsgjCF-4dgLL7-a4r-JPUjtMospg@mail.gmail.com>
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

On 12/3/23 18:44, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 3 Dec 2023 at 03:55, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 12/3/23 00:38, Shantur Rathore wrote:
>>> Hi Simon,
>>>
>>> On Sat, Dec 2, 2023 at 6:33 PM Simon Glass <sjg@chromium.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Mon, 20 Nov 2023 at 00:02, Ilias Apalodimas
>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>
>>>>> Hi Mark,
>>>>>
>>>>> On Sun, 19 Nov 2023 at 19:38, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>>>>>
>>>>>>> Date: Sat, 18 Nov 2023 23:52:11 +0100
>>>>>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>
>>>>>> Hi Heinrich,
>>>>>>
>>>>>>> On 11/18/23 22:28, Shantur Rathore wrote:
>>>>>>>> Hi Heinrich,
>>>>>>>>
>>>>>>>> On Fri, Nov 17, 2023 at 3:12 PM Heinrich Schuchardt
>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>
>>>>>>>>> On 11/16/23 19:45, Shantur Rathore wrote:
>>>>>>>>>> On Thu, Nov 16, 2023 at 6:15 PM Heinrich Schuchardt
>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 11/16/23 17:52, Shantur Rathore wrote:
>>>>>>>>>>>> Hi Simon,
>>>>>>>>>>>>
>>>>>>>>>>>> Currently bootstd - bootmethod_efi only looks for the default
>>>>>>>>>>>> bootxx64.efi in /EFI/boot folder only.
>>>>>>>>>>>> Generally many distros end up putting their bootloaders in
>>>>>>>>>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
>>>>>>>>>>>>
>>>>>>>>>>>> In x86 worlds, the NVRAM is modified and new boot entries are added to
>>>>>>>>>>>> support these but in the U-boot world the NVRAM variables are
>>>>>>>>>>>> read-only.
>>>>>>>>>>>
>>>>>>>>>>> I guess you are referring to UEFI boot options. These typically are not
>>>>>>>>>>> stored in non-volatile RAM but on a SPI flash device.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks for correcting me.
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> What would be the best way to implement this?
>>>>>>>>>>>>
>>>>>>>>>>>> I was thinking of having a "efi_prefixes" environment variable which
>>>>>>>>>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
>>>>>>>>>>>> all of them. Will bootmethod_efi be able to support multiple entries (
>>>>>>>>>>>> thinking of multiboot ) ?
>>>>>>>>>>>
>>>>>>>>>>> On my laptop I have:
>>>>>>>>>>>
>>>>>>>>>>> EFI/Microsoft/Boot/bootmgr.efi
>>>>>>>>>>> EFI/Microsoft/Boot/memtest.efi
>>>>>>>>>>> EFI/Boot/bootx64.efi
>>>>>>>>>>> EFI/Boot/fbx64.efi
>>>>>>>>>>> EFI/Boot/mmx64.efi
>>>>>>>>>>> EFI/debian/shimx64.efi
>>>>>>>>>>> EFI/debian/grubx64.efi
>>>>>>>>>>> EFI/debian/mmx64.efi
>>>>>>>>>>> EFI/debian/fbx64.efi
>>>>>>>>>>> EFI/ubuntu/grubx64.efi
>>>>>>>>>>> EFI/ubuntu/shimx64.efi
>>>>>>>>>>> EFI/ubuntu/mmx64.efi
>>>>>>>>>>>
>>>>>>>>>>> Obviously each installed operating system provides multiple EFI binaries
>>>>>>>>>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
>>>>>>>>>>> debian centos" would not be able to describe which file you are looking
>>>>>>>>>>> for.
>>>>>>>>>>>
>>>>>>>>>>> We already have the U-Boot command line eficonfig and efidebug commands
>>>>>>>>>>> to set up UEFI boot options which can describe which EFI binary to load
>>>>>>>>>>> and which command line to pass to it. These are considered by the
>>>>>>>>>>> existing boot flows.
>>>>>>>>>>
>>>>>>>>>> So, I am building a new RockPro64 based cluster and using Canonical
>>>>>>>>>> MAAS to set them up automatically, booting them up using DHCP and
>>>>>>>>>> installing them over the network.
>>>>>>>>>> I configured an Armbian image using Packer to be compatible with MAAS
>>>>>>>>>> and it happily installs it. As part of installation process, a
>>>>>>>>>> grub-install is run which installs the grub efi,
>>>>>>>>>> this EFI ends up in EFI/debian instead of expected EFI/boot.
>>>>>>>>>> To be able to make it boot, I have to add commands to move it to
>>>>>>>>>> EFI/boot. I am trying to find a way in U-Boot that would allow me to
>>>>>>>>>> skip this step.
>>>>>>>>>> With eficonfig if I understand correctly, it would need manual
>>>>>>>>>> intervention to create boot entries.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> If you are installing the shim-signed package on Ubuntu, the EFI boot
>>>>>>>>>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content
>>>>>>>>>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and
>>>>>>>>>>> therefore should work with current U-Boot.
>>>>>>>>>>>
>>>>>>>>>>> Patches are pending upstream to make EFI variables writable from Linux
>>>>>>>>>>> if they are stored in the RPMB partition in the eMMC. See this series:
>>>>>>>>>>>
>>>>>>>>>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@linaro.org/
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Would it be possible to save it in SPI Flash as the U-Boot environment ?
>>>>>>>>>
>>>>>>>>> Currently this is not supported by U-Boot.
>>>>>>>>>
>>>>>>>>> The U-Boot environment variables can be stored in lots of different
>>>>>>>>> places SPI flash is only one of these. But none of these locations is
>>>>>>>>> protected from OS access which would be preferable for UEFI variables
>>>>>>>>> for security reasons.
>>>>>>>>>
>>>>>>>>> To support boards without eMMC the right way forward would be writing a
>>>>>>>>> new implementation of the OP-TEE standalone MM which writes the
>>>>>>>>> variables to SPI flash instead of the RPMB partition and ensures that
>>>>>>>>> the SPI flash' MMIO registers are protected against access from the
>>>>>>>>> non-secure world.
>>>>>>>>
>>>>>>>> Thanks for explaining this to me.
>>>>>>>> This seems like a long way to go, for now what would be an acceptable
>>>>>>>> solution, some options are
>>>>>>>>
>>>>>>>> 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
>>>>>>>> debian") variable which is ready by bootmeth_efi and used as
>>>>>>>> efi/<efi_prefix> instead of efi/boot.
>>>>>>>> 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
>>>>>>>> present all them as bootflows to bootstd.
>>>>>>>
>>>>>>> As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxxx.efi
>>>>>>> don't exist. I would prefer not to add any distro specific stuff in
>>>>>>> upstream U-Boot. Instead we will continue to drive what Linaro has
>>>>>>> suggested to improve U-Boot EFI variables support in Linux.
>>>>>>
>>>>>> I agree that adding hacks like this is not a good idea.
>>>>>
>>>>> + 1
>>>>>
>>>>>>
>>>>>> The Linaro approach that involves OP-TEE makes for a fairly complex
>>>>>> solution.  And there are plenty of boards that have neither eMMC nor
>>>>>> SPI flash.  If Secure Boot is not a requirement (and I'd argue that
>>>>>> for most "hobbyist" boards it isn't) storing the EFI variables in a
>>>>>> file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
>>>>>> Kconfig option) is a workable alternative.  And this is actually what
>>>>>> the rockpro64-rk3399_defconfig enables.
>>>>>
>>>>> Even in that case, preseeding the variables can enable uefi secure
>>>>> boot. But you have to establish a chain of trust since the
>>>>> authenticated EFI variables are part of  the u-boot binary.
>>>>>
>>>>>>
>>>>>> I noticed that the latest EBBR attempts to standardize this:
>>>>>>
>>>>>>     https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
>>>>>>
>>>>>> Not sure what the status here is.
>>>>>
>>>>> Heinrich and I were the ones who proposed the standardization. The
>>>>> idea is to eventually fix it for all boards and we are working on it,
>>>>>
>>>>>> But if the Linux kernel folks
>>>>>> accept that alternative implementations for runtime EFI variable
>>>>>> access are a thing, then a method that modifies the file would be
>>>>>> possible as well.  Or maybe it is good enough to implement support for
>>>>>> this in the efivar library.
>>>>>
>>>>> Yes to both. I discussed the idea during Linux Plumbers. All
>>>>> approaches have some pros and cons, you can find some details here
>>>>> [0].
>>>>> Implementing support to efitool is straightforward, but a bit too
>>>>> hacky for my taste. An obvious disadvantage is that it's hard to sync
>>>>> the kernel/file view after an update.
>>>>> The plan right now is to investigate overwriting RT functions and use
>>>>> kernel-provided ones that modify the file (which is probably going to
>>>>> be passed in a config table)
>>>>>
>>>>> [0] https://lpc.events/event/17/contributions/1653/
>>>>
>>>> I don't know much about this area, but it strikes me that things are
>>>> getting a little too complicated.
>>>>
>>>> U-Boot wants to show a menu of available Operating Systems. With UEFI
>>>> it isn't even possible to know what is being booted. We just have to
>>>> jump into the .efi file and hope.
>>>>
>>>> Can we work together on adding a new, separate file which lists the
>>>> .efi files and what they are for? Then the user can select one.
>>>>
>>> To add - EFI/BOOT/BOOTXXXX.efi is optional [0] and isn't installed by
>>> generic ARM
>>> distros (debian, armbian.. maybe more)
>>>
>>> +1 for this. This can be implemented as part of bootmeth_efi (in blk
>>> mode) where instead
>>> of checking hardcoded EFI/BOOT/BOOTXXXX.efi, it can follow one of the
>>> following options
>>>
>>> 1. Scan and list all available .efi files - EFI/**/*.efi
>>> Pros - Allows all the possible boot options to be shown to user
>>> Cons - A 'bootflow scan -b' might not boot the system by default as it
>>> might depend on
>>> which efi file is scanned first. Some installs have mmaa64.efi
>>>
>>> 2. Scan and list all available .efi files that match the
>>> "bootmeth_efi_regex" variable if available.
>>> This variable can be configured to allow valid names example
>>> "EFI\/.*\/(boot|grub|fb|shim).*efi"
>>> Pros - Allows to control only efi files that can boot the system by default.
>>> Cons - Might be an issue in environments without CONFIG_REGEX
>>>
>>> 3. Scan all the folders EFI/* for EFI file prefixes controlled by
>>> "bootmeth_efi_name_prefixes" variable
>>> This variable can be a space separated list of all valid prefixes the
>>> user is interested in. e.g. "boot grub fb shim"
>>> Pros - This allows control on what EFI files to look for without being
>>> depended on CONFIG_REGEX
>>> Cons - I can't think of, please do tell.
>>>
>>> After this, bootmeth_efi can set up more than 1 bootflows that are bootable.
>>>
>>> [0] - https://www.rodsbooks.com/efi-bootloaders/principles.html
>>>
>>> Kind regards,
>>> Shantur
>>
>> U-Boot should remain be a compliant UEFI implementation. We shall not
>> scan any other directories than those described in the UEFI specification.
> 
> For the efi bootmeth we can actually do what we like, can't we? Its
> behaviour isn't defined by the spec as I understand it.
> 
> I wonder how this works, if the user installs both Debian and Ubuntu
> on the machine? I suppose each one separately updates its grub.cfg
> with all the OSes it can find on the machine? Then just one of them
> gets to be the initial .efi app?
> 
> Can we work together on adding a new, separate file which lists the
> .efi files and what they are for?

There is already a place defined by the UEFI specification where to put 
that information: the UEFI boot options defined in variables BOOT####. 
And this is exactly what all operating system use. The information what 
the entries are for are in the label part of the boot options. The 
sequence in which to try loading is in variable BootOrder.

There is no point in reinventing the wheel and making it square.

Best regards

Heinrich
