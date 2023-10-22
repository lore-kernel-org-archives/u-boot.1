Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7553DCDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 04:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CAD876AF;
	Sun, 22 Oct 2023 06:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nwCElg4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1866876B0; Sun, 22 Oct 2023 06:53:59 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C50187691
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 06:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 379DF3F69E
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 04:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697950434;
 bh=apZPmQ6aMM41O1U026Hvx8DKPyJlqN5syZWoaSEa900=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=nwCElg4XhXVJIOA333mTVxoXrwD9SKlFdjfzSCq93Sp0Me1XwaiFS/BczuN58oL2r
 ncbSfroHqEevb1a5bk2FRfDlj1YJwGU499EM5OYjHsqbEQlSQPOb0yz3ILxDLETq/U
 Zc9t3MrwhxdCsyJ9WD2eTfMINv16K2O4M9asqz3OtWiu5+0FWQteDBFdVPf9mz46OC
 U9SAXsVyj0GxHjehnu4gSo9dRkvfQ5sOTbfCskbz0pU0e8/gADRVjCoN81gj2uWFiG
 3AP1z+q734zNbPw3iRHvMFgff9cuYtadRU8FLzyuYqNtvsEL2nBuDJBSIySR+A5cTB
 10JcTWPdjP3aw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d9751ca2cso893840f8f.3
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 21:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697950433; x=1698555233;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=apZPmQ6aMM41O1U026Hvx8DKPyJlqN5syZWoaSEa900=;
 b=ilPYAOwam4aA6N5KT1uyktJBiIsbLORpSHGk2VRiwIB7PxSS23BqXo+3CTxwqpKX7H
 ZLgMlTcXm0+OgNMEg6+dSadehdnNomKdJBBg8XxyUEnJHE1kYaQz4KEWT+i2+1N8MiRg
 N+RsPYvKbASYlXdSPP1oT3T2BB9DmEZKHpd6UfpIt7dl3ObDJwmNMnlMqhdtS8zCLyNg
 ENwrdmKDzKtaY4zUaBHbO1cMizEf7cUI/RO5yinTOTVMWdbKO945Y9X2FzPsi/RLQZej
 +FH6SzL8fhRNUe1dIqM0QEoaPWPMf1VVen2yzyvAnwkF7xucsot8AahegNVg141/+XEz
 d9QQ==
X-Gm-Message-State: AOJu0Yzs2lOAf5C8p+2HlZGJwKcBP7L5eCaAh6lavd/9N/+ubNsYwjAh
 ijpcDgqa/xuiFAUWAcDtMCJBGRdrJNCv0gY/wxlv4Bzi61uOJVYcXOI7c8LhvOpGqgzbHhcc4Ih
 5pYG8JvZZT3kKvpyb5Wst9czcYeAL/q4=
X-Received: by 2002:a5d:5b1c:0:b0:32d:a61a:85cc with SMTP id
 bx28-20020a5d5b1c000000b0032da61a85ccmr7111825wrb.8.1697950433360; 
 Sat, 21 Oct 2023 21:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnB/+S+dnR3pQ7VNFn1eUmfjZybDziV5a5AtndRvXaKk0RfKeq3Q/am/2HsrzpluO9cCPnXQ==
X-Received: by 2002:a5d:5b1c:0:b0:32d:a61a:85cc with SMTP id
 bx28-20020a5d5b1c000000b0032da61a85ccmr7111808wrb.8.1697950432822; 
 Sat, 21 Oct 2023 21:53:52 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 s3-20020adfea83000000b0031980783d78sm4888789wrm.54.2023.10.21.21.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 21:53:52 -0700 (PDT)
Message-ID: <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
Date: Sun, 22 Oct 2023 06:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Simon Glass <sjg@google.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Doug Anderson <dianders@google.com>, Tom Rini <trini@konsulko.com>
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
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

On 10/21/23 17:42, Simon Glass wrote:
> Hi Tom,
> 
> On Fri, 20 Oct 2023 at 09:24, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Fri, Oct 20, 2023 at 05:40:03PM +0200, Heinrich Schuchardt wrote:
>>> On 20.10.23 15:21, Simon Glass wrote:
>>>> +Doug Anderson
>>>>
>>>> Hi Heinrich,
>>>>
>>>> On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> On 19.10.23 15:55, Simon Glass wrote:
>>>>>> Hi Heinrich,
>>>>>>
>>>>>> On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>
>>>>>>> On 10/18/23 05:33, Simon Glass wrote:
>>>>>>>> Hi Heinrich,
>>>>>>>>
>>>>>>>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>
>>>>>>>>> Forward and backward compatibility of Linux kernel device-trees is
>>>>>>>>> sometimes missing. One solution approach is to load a kernel specific
>>>>>>>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>>>>>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>>>>>>>> The boot loader approach currently requires to know the device-tree name
>>>>>>>>> before first boot which makes it unusable for generic images.
>>>>>>>>>
>>>>>>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>>>>>>> This will allow bootloaders to load a kernel specific device-tree.
>>>>>>>>>
>>>>>>>>> The variable will not be exposed on ACPI based systems or if the
>>>>>>>>> environment variable fdtfile is not defined.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>>>> ---
>>>>>>>>> v2:
>>>>>>>>>             Use a unique GUID to enable future U-Boot independent
>>>>>>>>>             standardization.
>>>>>>>>>             Do not try to add the variable on ACPI based systems.
>>>>>>>>> ---
>>>>>>>>>      include/efi_loader.h       |  5 +++++
>>>>>>>>>      lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>>>>>>      2 files changed, 35 insertions(+)
>>>>>>>>
>>>>>>>> I was too slow to reply to v1.
>>>>>>>>
>>>>>>>> Does grub load the DT? I was assuming that U-Boot would pass it on?
>>>>>>>> What is the interface between U-Boot and grub?
>>>>>>>
>>>>>>> The device-tree built into U-Boot is often out of date and not usable to
>>>>>>> boot current Linux. A single device-tree can be loaded by U-Boot from
>>>>>>> file and passed on as EFI configuration table. This device-tree may not
>>>>>>> be compatible with all kernel versions exposed by GRUB.
>>>>>>>
>>>>>>> GRUB provides a devicetree command. It is disabled if you use secure
>>>>>>> boot. At least in Debian and Ubuntu GRUB invokes the
>>>>>>> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
>>>>>>> fix-ups after loading a device-tree.
>>>>>>>
>>>>>>> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
>>>>>>> devicetree commands to the boot options in grub.cfg.
>>>>>>
>>>>>> Thanks. I wonder if you could document this somewhere? It seems like
>>>>>> there are a lot of options and it is quite complicated.
>>>>>>
>>>>>> Back to the question, I suppose you are expecting grub to load the DT
>>>>>> using this filename? But why doesn't U-Boot load it instead? It seems
>>>>>> very convoluted.
>>>>>
>>>>> A separate file of this name exists for every kernel version installed.
>>>>> The loaded dtb must match the kernel. U-Boot does not know what kernel
>>>>> version will be chosen in GRUB. And for a generic image GRUB does not
>>>>> what board it is on.
>>>>>
>>>>>>
>>>>>> Also, can we test this interface?
>>>>>
>>>>> Neither the sandbox nor QEMU have environment variable fdtfile. And we
>>>>> don't create the EFI variable with ACPI as used on the sandbox.
>>>>
>>>> I worry that this is creating another interface that some poor sod is
>>>> going to have to deal with in the future. Is this part of the EFI
>>>> standard?
>>>
>>> No, the UEFI standard does not care much about device-trees. It only defines
>>> the GUID for the configuration table.
>>>
>>>>
>>>> We should really be using the compatible string to choose the
>>>> devicetree. Why are we using filenames at all? What is the
>>>> relationship between the compatible string and the filename? Is there
>>>> a lookup table, or should we create one?
>>>
>>> There is no 1:1 relationship between compatible string and filename, e.g.
>>> the following arm64 device-trees use the same compatible string:
>>>
>>> amd/amd-overdrive-rev-b0.dts
>>> amd/amd-overdrive-rev-b1.dts
>>>
>>> amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
>>> amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
>>>
>>> xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>
>>>>
>>>> The correct way of doing this is implemented in U-Boot with
>>>> CONFIG_FIT_BEST_MATCH.
>>>
>>> Why should we write complicated code to find a *possibly* matching file if
>>> we already know the filename that needs to be loaded?
>>
>> I think that is the unfortunate key here. We can make a guess, or best
>> match, but it might not be right. And we need a reliable way to find and
>> use the correct tree. And the U-Boot portion of that may be "set the EFI
>> var if it's not already set" rather than "and now load it".
> 
> That is not my understanding of how it works. The compatible string is
> how Linux knows what the hardware is...if it doesn't match, then
> things are going to go wrong. It is also how U-Boot works, e.g. with
> FIT. I don't believe this is a 'guess'. The compatible string is used
> programmatically and must be correct.

It is not how U-Boot works. In distroboot U-Boot uses environment 
variable fdtfile to load the correct device-tree.

Your suggestion would mean that distroboot or GRUB would have to sift 
through literally hundreds of device-tree files which would considerably 
increase the boot time. The process might end up with multiple dtb files 
that match.

> 
> fdt_node_check_compatible() does most of the work...then you need to
> check which FDT has the most specific match (i.e. latest in the string
> list). That handles things like board revisions, variants, etc.
> 
> My concern is about adding a feature when there is already a defined
> spec and mechanism for this to work. What happens when we load the
> file and the compatible is wrong?
> 
> At best, I see the filename as a hint.
> 
> [Perhaps this is the wrong time to ask, but why are kernels +DT not
> shipped in FIT on ARM?]

FIT is U-Boot specific. For Linux distributions it is easier to use a 
firmware agnostic method of booting.

>>
>>>> Can we mirror something like that in grub, etc?
>>
>> I'm splitting this part out because no, having to have N projects write
>> the same bit of code, but with its own quirks and bugs doesn't sound
>> like the right direction. It's why today we have a few different sets of
>> logic to try and find / set the right device tree, so that whatever
>> follows after doesn't have to also do that, and get updated for every
>> new platform too.
>>
>> And of course yes, ideally, boards would be manufactured with an up to
>> date and correct device tree on them.
> 
> OK, well I perhaps have the wrong end of the stick here.
> 
> As I learn more about how distros boot I see a great need for
> information about what is actually being booted. For example, the
> current 'bootflow menu' mostly shows useless information when EFI is
> used to boot, since it doesn't know what the things are. We have to
> jump to grub (or whatever) to find out. Grub knows because the OS set
> up a grub menu.

The menu should show the EFI boot options. Then you can decide which of 
the multiple operating systems on your device you want to boot.

The bottleneck is secure boot. As Red Hat did not want Microsoft to sign 
every single kernel they came up with shim. Now we can only have one EFI 
boot option per operating system. It is only after shim that you can 
load one of multiple kernels.

> 
> Really we need to see this standard boot thing to the end. Each OS
> should provide information from /etc/lsb_release as well as info from
> menu.grub (sorry can't remember the right name), so that we know what

/boot/grub/grub.cfg

> can be booted. Having to jump to an OS-specific bootloader to even be
> able to show a menu is a pretty poor show.

With secure-boot you still would need to load the OS specific shim. 
Further you would need a means to communicate your decision to whatever 
program loads the kernel.

> 
> Anyway I think I understand why this variable is needed. Please add
> some documentation on all this.

Yes I should add a paragraph on the variable.

> 
> My main concern is whether this sort of thing is going to make it even
> harder to boot in a simple, standard manner.
> 
> Re Heinrich's comment:
> 
>> There is no 1:1 relationship between compatible string and filename,
>> e.g. the following arm64 device-trees use the same compatible string:
> 
>>> amd/amd-overdrive-rev-b0.dts
>>> amd/amd-overdrive-rev-b1.dts
> 
> That just seems like a bug to me. The compatible should include the
> board rev as it does for xlnx,zynqmp-zcu102-rev1.1 etc.

Yes, here it is a bug.

In theory you could have different device-trees for different device 
configurations (e.g. USB OTG vs USB host). In this case having the same 
compatible string would be correct.

Best regards

Heinrich

> 
> Regards,
> Simon
