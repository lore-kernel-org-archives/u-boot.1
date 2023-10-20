Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E90FC001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 15:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F77286FBD;
	Fri, 20 Oct 2023 17:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L57/5XT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9202874D7; Fri, 20 Oct 2023 17:40:10 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30BA686E47
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 17:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 588CD3F697
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697816406;
 bh=GaCQMOWIAl+xGu1mI36r3pL0Pbq1hD7kjxIppjKlnmE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=L57/5XT1hCKpNIFeOeSiPYfjv2FqzMecMKOmSfFduWtlDGHSOJbwkIlabG04T0QJA
 e4KimQR4rOV00xkZQNkKT2vIbTkTfDtBOf/jaKMYKctaDxpH+grxamvawPUbFeNQMS
 HS0S9cJGb0Y5t+8KdSsacunKajconwEan34TpaTUQUZocI77YbBvodHs2lkbktInPY
 R9+wzZRPV1RTtOQ2o/cM8FU7+ZGNP+tQyDGvfW4+JFh8kE4S18b0EhJo/s2Vfk13aG
 pRn6+laH9SMK85hzG5LT6NnaBFXN4xA7ikyKaSjB7FnGlNzYriqb58JX7OY6qWsJak
 hywSw7niTFTIw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40839252e81so5720605e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 08:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697816405; x=1698421205;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GaCQMOWIAl+xGu1mI36r3pL0Pbq1hD7kjxIppjKlnmE=;
 b=F6JJqU5kM6pIfOJE+Js519wPS/S4UojB70P16Z8yaHnD0jWlUrxyCAe+FtJaEY/ePU
 QG/sVR6V1byTiXQzkyNrr221vAwSFLoZ3+xkD5jmEiUqElQX4HEWP3a+0xE8lt1fRjNk
 AN2ct1IjULAe0hdkJkxUrWp19QET4Jzvn/uPFrAQNZwhGkAlZT5zS7tnwQkeXnxa4EwX
 VoHGHa28MllnJ8gWx23+N/f0c5ePV2lHqW4Svjj4IqyL3YfEaOwQwrwMRJl7i8IArM1s
 J3hvEcF3pBj6q5hRedVPMk3/EvC86U+xsb2sxURP3K6XZ+r23FwgYen1zwFBAWPznTHy
 rw6g==
X-Gm-Message-State: AOJu0YylL6lOO+JHOUl9xcdwVPnoOFK3nqeFSESK8cIYOX2CAoKBWEEE
 nZzYt+4qpYYfoqpmX5dhm2tDlippdH54W5BIzRj57ZOMAFFPpUtUECO2enFbiPeUN6qHHadwYZT
 7wljnWheM+OuCcZ7qIheR3ozMnzTGRzs=
X-Received: by 2002:a05:600c:3555:b0:3f9:b430:199b with SMTP id
 i21-20020a05600c355500b003f9b430199bmr1753607wmq.15.1697816405470; 
 Fri, 20 Oct 2023 08:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3kWj1dGS7XoPka+7uCeG2bul2XGwTKxZj5EksMKlNfojmfcBGZMsEBmpf4HUd+1vvwqk3nw==
X-Received: by 2002:a05:600c:3555:b0:3f9:b430:199b with SMTP id
 i21-20020a05600c355500b003f9b430199bmr1753588wmq.15.1697816405033; 
 Fri, 20 Oct 2023 08:40:05 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 s3-20020adfea83000000b0031980783d78sm1928301wrm.54.2023.10.20.08.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 08:40:04 -0700 (PDT)
Message-ID: <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
Date: Fri, 20 Oct 2023 17:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US
To: Simon Glass <sjg@google.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
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

On 20.10.23 15:21, Simon Glass wrote:
> +Doug Anderson
> 
> Hi Heinrich,
> 
> On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 19.10.23 15:55, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 10/18/23 05:33, Simon Glass wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
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
>>>>>>
>>>>>> The variable will not be exposed on ACPI based systems or if the
>>>>>> environment variable fdtfile is not defined.
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>> ---
>>>>>> v2:
>>>>>>            Use a unique GUID to enable future U-Boot independent
>>>>>>            standardization.
>>>>>>            Do not try to add the variable on ACPI based systems.
>>>>>> ---
>>>>>>     include/efi_loader.h       |  5 +++++
>>>>>>     lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 35 insertions(+)
>>>>>
>>>>> I was too slow to reply to v1.
>>>>>
>>>>> Does grub load the DT? I was assuming that U-Boot would pass it on?
>>>>> What is the interface between U-Boot and grub?
>>>>
>>>> The device-tree built into U-Boot is often out of date and not usable to
>>>> boot current Linux. A single device-tree can be loaded by U-Boot from
>>>> file and passed on as EFI configuration table. This device-tree may not
>>>> be compatible with all kernel versions exposed by GRUB.
>>>>
>>>> GRUB provides a devicetree command. It is disabled if you use secure
>>>> boot. At least in Debian and Ubuntu GRUB invokes the
>>>> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
>>>> fix-ups after loading a device-tree.
>>>>
>>>> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
>>>> devicetree commands to the boot options in grub.cfg.
>>>
>>> Thanks. I wonder if you could document this somewhere? It seems like
>>> there are a lot of options and it is quite complicated.
>>>
>>> Back to the question, I suppose you are expecting grub to load the DT
>>> using this filename? But why doesn't U-Boot load it instead? It seems
>>> very convoluted.
>>
>> A separate file of this name exists for every kernel version installed.
>> The loaded dtb must match the kernel. U-Boot does not know what kernel
>> version will be chosen in GRUB. And for a generic image GRUB does not
>> what board it is on.
>>
>>>
>>> Also, can we test this interface?
>>
>> Neither the sandbox nor QEMU have environment variable fdtfile. And we
>> don't create the EFI variable with ACPI as used on the sandbox.
> 
> I worry that this is creating another interface that some poor sod is
> going to have to deal with in the future. Is this part of the EFI
> standard?

No, the UEFI standard does not care much about device-trees. It only 
defines the GUID for the configuration table.

> 
> We should really be using the compatible string to choose the
> devicetree. Why are we using filenames at all? What is the
> relationship between the compatible string and the filename? Is there
> a lookup table, or should we create one?

There is no 1:1 relationship between compatible string and filename, 
e.g. the following arm64 device-trees use the same compatible string:

amd/amd-overdrive-rev-b0.dts
amd/amd-overdrive-rev-b1.dts

amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
amlogic/meson-axg-jethome-jethub-j110-rev-3.dts

xilinx/zynqmp-zc1751-xm015-dc1.dts
xilinx/zynqmp-zc1751-xm015-dc1.dts
xilinx/zynqmp-zc1751-xm015-dc1.dts
xilinx/zynqmp-zc1751-xm015-dc1.dts

> 
> The correct way of doing this is implemented in U-Boot with
> CONFIG_FIT_BEST_MATCH. Can we mirror something like that in grub, etc?

Why should we write complicated code to find a *possibly* matching file 
if we already know the filename that needs to be loaded?

Best regards

Heinrich

> 
> Regards,
> Simon

