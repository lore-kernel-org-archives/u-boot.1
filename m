Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3CEC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 21:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDB28750A;
	Wed, 25 Oct 2023 23:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QIKOvCzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F6E87510; Wed, 25 Oct 2023 23:22:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC03874D7
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 23:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F38C841353
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698268966;
 bh=qQEs7QsG8+E8v5vUUgo5ngV+VPe2c64JEuDyaGkZ57k=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=QIKOvCzgSkIVi2LkulhS35FMqQOgdUGtyEt1FpOhcZP9aPGUEHRUJavQ+8cAR7o5W
 p+TuSXwCv/qBKyEawG7H3xRylXm732wKk+p6XIH4jAncqV4rmdP0INayOVzEL4cQG5
 1dWB2JTDs675XBiyTGY4vYNL5lqfaIuN+xldZD5pigJjkL12iGtNF1KOx0VB8RcfY5
 U9KL6vOYusehl0RTBGPuKFDxAl+0bk1tKbvtsCrYd9YFsVV3/tvTAue8SSR6dSg8aL
 rEo5e/7yLIwFZpNIsP7JLQfqEZ5sGtiSl3lRvA7Ikfk/djY208olWHBOwVZNrXDr03
 fRl871np0dQTw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40768556444so1078875e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698268966; x=1698873766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQEs7QsG8+E8v5vUUgo5ngV+VPe2c64JEuDyaGkZ57k=;
 b=BuueFLezYqLgg82zst8BLDG+O4Byv2wUeTxQgWxMOrJDyygAIwy25pUoRnQqR9QC7I
 cUzC88ggd+SlMOBfbtyHftMCTROjfSK6eiL9DIcb+ArbpmY9mTqG1twDf464jgW3xNLN
 laZz5Pyh6v7Aep3oh5etqs2j9ndLGMMzDJXFWiAbi2MQdxOjZdiBfXhkwvr22WSaCiCL
 xzni4J/14Ie9aUiem9RMmJxhWg8TpV4RC1AJAG4IM+23XQRNkTcqqHwihyUsWdRXkNxd
 Z5HmpjN58srzJYSGuEtg6OypKtiCsNv3PyAedtIrkzYvEiUGKW8krYOxaGxhCsCaEo9I
 AYqg==
X-Gm-Message-State: AOJu0YyAJ4NjBOeiBhhFWc2WE8TIZd/rDOzyOvHzzrhuYk4LC5z2wrlj
 NbRr9zlj7r/R48qLslSQ01kJ5PlJZ0s3jEvRnGkVRJWKhbciifgBIdEItcrpdod1eZhhy7QRPII
 g5B3hzEERR+T85FCcrxexLdQmSttBErM=
X-Received: by 2002:a05:600c:470f:b0:408:3fae:d809 with SMTP id
 v15-20020a05600c470f00b004083faed809mr12426343wmo.17.1698268966561; 
 Wed, 25 Oct 2023 14:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtDnzpqH/IcDLtVmVRPi2rc6LiPg/H5Vo7XkhWmXiVGqmmdQnNx0+4Hf6WGWXiJyW+KJkSvg==
X-Received: by 2002:a05:600c:470f:b0:408:3fae:d809 with SMTP id
 v15-20020a05600c470f00b004083faed809mr12426325wmo.17.1698268966049; 
 Wed, 25 Oct 2023 14:22:46 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c471000b0040644e699a0sm713506wmo.45.2023.10.25.14.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 14:22:45 -0700 (PDT)
Message-ID: <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
Date: Wed, 25 Oct 2023 23:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: sjg@google.com, ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <20231025211354.GZ496310@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231025211354.GZ496310@bill-the-cat>
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

On 10/25/23 23:13, Tom Rini wrote:
> On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wrote:
>>> Date: Wed, 25 Oct 2023 21:57:44 +0200
>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>
>>> On 10/25/23 20:23, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
>>>>>
>>>>> Hi Heinrich,
>>>>>
>>>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> Forward and backward compatibility of Linux kernel device-trees is
>>>>>> sometimes missing. One solution approach is to load a kernel specific
>>>>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>>>>> The boot loader approach currently requires to know the device-tree name
>>>>>> before first boot which makes it unusable for generic images.
>>>>>>
>>>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>>>> This will allow bootloaders to load a kernel specific device-tree.
>>>>>
>>>>> kernel-specific
>>>>>
>>>>>>
>>>>>> The variable will not be exposed on ACPI based systems or if the
>>>>>> environment variable fdtfile is not defined.
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>> ---
>>>>>> v4:
>>>>>>           Generalize the description of the content of $fdtfile.
>>>>>> v3:
>>>>>>           Add documentation
>>>>>> v2:
>>>>>>           Use a unique GUID to enable future U-Boot independent
>>>>>>           standardization.
>>>>>>           Do not try to add the variable on ACPI based systems.
>>>>>> ---
>>>>>>    doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
>>>>>>    include/efi_loader.h       |  5 +++++
>>>>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 49 insertions(+)
>>>>>>
>>>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>>>>>> index fb16ac743a..702c490831 100644
>>>>>> --- a/doc/develop/uefi/uefi.rst
>>>>>> +++ b/doc/develop/uefi/uefi.rst
>>>>>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
>>>>>>
>>>>>>        Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>>>>>>
>>>>>> +EFI variable FdtFile
>>>>>> +~~~~~~~~~~~~~~~~~~~~
>>>>>> +
>>>>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
>>>>>> +any operating systems. Unfortunately operating systems like Linux sometimes
>>>>>> +break forward and backward compatibility. In this case there is a need to load
>>>>>> +an operating system version specific device-tree.
>>>>>
>>>>> This seems to be a strong statement. Given the effort that goes into
>>>>> the DT, changes are supposed to be backwards-compatible. Is this
>>>>> generally true, or is it just that we want an up-to-date DT for the
>>>>> kernel to enable new features?
>>>>
>>>> Did you see this comment?
>>>
>>> It would have been nice to put the person which made that comment on copy.
>>>
>>> The truth lies in the world "supposed":
>>>
>>> The idea of a device-tree that never needs to change is quite old and
>>> never became true on ARM devices.
>>>
>>> We all know Linux tends to break both forward and backward compatibility
>>> of device-trees. Here is a nice example:
>>>
>>> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode
>>> rgmii-id")
>>>
>>> Driver changes broke forward and backwards compatibility of a lot of
>>> Allwinner boards.
>>
>> Well, that happened in 2020.  Things have gotten better over time.
> 
> Well, yes and no.  Given the brief summary here, I bet this was just
> like when phy-mode and am335x platforms had DT compatibility broken and
> the answer was that it was OK because the DT was incorrectly describing
> hardware. So this is the reminder that there are cases of breaking DT
> compatibility that are allowed. Even if the DT has been out (and wrong)
> for several years.
> 
> That's not the main point of this thread and I don't want to derail
> things further along this point, I just want to note that the details
> here reminded me of when things are allowed to be incompatible with
> previous trees.
> 

You are conflating things:

The EFI variable is a hint to the GRUB OS to find the correct 
device-tree file without scanning hundreds of device-tree. You can not 
build a compatibility check for it into U-Boot.

In distro-boot we are using the same value from environment variable 
$fdtfile. Here you could check the compatible string but this might 
break booting .

Best regards

Heinrich


