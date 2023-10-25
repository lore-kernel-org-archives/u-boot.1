Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45841C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 20:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699ED87A5F;
	Wed, 25 Oct 2023 22:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="m3dD617U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB6087A5B; Wed, 25 Oct 2023 22:51:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB202874A2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E3753FD3B
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698267100;
 bh=UnPNapnsmQg8nr92wbOV15gzSq9NIoavonK8FYw6nX0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=m3dD617UokG2v+/cFub7rDv5xqkI5mT7Ue8zv4tSCsLel687R5Y9gN2Zle0gRPiIB
 wfCYf+SccU/kxJximLI4Fnc3esiFIJtCqiZ7FfXyNawSoeebo0iXwjj6DJhMk8s5Y/
 l2buY4dq3O34VcHNIZWPGWFyDpVco36HqpBtAaZyRZZQdj4ZOOpZmg5f6arJCPN97J
 553szb9TWsV3P+EO/1jvSMfr0jELzzLqxP+JqJRSWnRaOrTjGf7ayivlSgXhjFyvVG
 F+ej019di03rCz51mO04/4p7Wcl7fxp1hZ+S8xm/kigt32b6kifqNVsHbR6Xz4JdgK
 W1M9RmZa+uFjw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da39f7f2bso80366f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 13:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698267100; x=1698871900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UnPNapnsmQg8nr92wbOV15gzSq9NIoavonK8FYw6nX0=;
 b=bZYdEAdkgyJbJOUXbfDlT+J8pXC4qb+ebIx50CacCRwrBsGohouvrbMJdX1DYucVz7
 fsuH1BMIChw9dJgHH7sjNbMU+DJscyBrlaRHx6vN1/AybIvzTjaQwtd48/iPR4bGf4TH
 WvqbmTdKlMEpxd1kkK/MHicRGLKUHaNwX/IT0N3tSuFtDMJmo15lqiMm6miw1iqqbLMn
 TrUd7GqQXtcQLTEIA8Ldv3YkocPEB8CBqy2UjGvnsxUMWBaM/PLCaUrwmJ3OLcND36JZ
 8jG7ChNVj/nQU/Fb0WX/RfHXXYCgqtJKpvx99jNmziVi9bgO/107YKc0ZIM2FkHvZYtN
 OHjA==
X-Gm-Message-State: AOJu0YyJhE62jnqQTPbK1H+3Qg6F3q/uOwGEIyJIXF6TudtkynX1hKaU
 rWwSMp6T7eG1ub9cof7ELQnvRkLBuCsjkyF1hNmUrvRdxAoFz28rQ4sNtFdVIrsXRPm91YXbLWy
 ecuCkv9Ns9ganef61ft8eDsBB0BmQ2Hk=
X-Received: by 2002:adf:eed0:0:b0:32d:9572:646e with SMTP id
 a16-20020adfeed0000000b0032d9572646emr12546901wrp.54.1698267099772; 
 Wed, 25 Oct 2023 13:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDtirRWhGTIdyrS4dAkle4fvpxkdBYAX4+JAt0JBQdtcIY633XGaupDwGUqpeEIrzaTDF1Rg==
X-Received: by 2002:adf:eed0:0:b0:32d:9572:646e with SMTP id
 a16-20020adfeed0000000b0032d9572646emr12546887wrp.54.1698267099408; 
 Wed, 25 Oct 2023 13:51:39 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 m10-20020adffe4a000000b0032ddc3b88e9sm12835762wrs.0.2023.10.25.13.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 13:51:38 -0700 (PDT)
Message-ID: <10833e97-46ab-4a14-8e4a-c6e3dd5eb376@canonical.com>
Date: Wed, 25 Oct 2023 22:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US, de-DE
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@google.com, ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 trini@konsulko.com, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
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

On 10/25/23 22:28, Mark Kettenis wrote:
>> Date: Wed, 25 Oct 2023 21:57:44 +0200
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> On 10/25/23 20:23, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
>>>>
>>>> Hi Heinrich,
>>>>
>>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> Forward and backward compatibility of Linux kernel device-trees is
>>>>> sometimes missing. One solution approach is to load a kernel specific
>>>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>>>> The boot loader approach currently requires to know the device-tree name
>>>>> before first boot which makes it unusable for generic images.
>>>>>
>>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>>> This will allow bootloaders to load a kernel specific device-tree.
>>>>
>>>> kernel-specific
>>>>
>>>>>
>>>>> The variable will not be exposed on ACPI based systems or if the
>>>>> environment variable fdtfile is not defined.
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>> v4:
>>>>>           Generalize the description of the content of $fdtfile.
>>>>> v3:
>>>>>           Add documentation
>>>>> v2:
>>>>>           Use a unique GUID to enable future U-Boot independent
>>>>>           standardization.
>>>>>           Do not try to add the variable on ACPI based systems.
>>>>> ---
>>>>>    doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
>>>>>    include/efi_loader.h       |  5 +++++
>>>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>>    3 files changed, 49 insertions(+)
>>>>>
>>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>>>>> index fb16ac743a..702c490831 100644
>>>>> --- a/doc/develop/uefi/uefi.rst
>>>>> +++ b/doc/develop/uefi/uefi.rst
>>>>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
>>>>>
>>>>>        Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>>>>>
>>>>> +EFI variable FdtFile
>>>>> +~~~~~~~~~~~~~~~~~~~~
>>>>> +
>>>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
>>>>> +any operating systems. Unfortunately operating systems like Linux sometimes
>>>>> +break forward and backward compatibility. In this case there is a need to load
>>>>> +an operating system version specific device-tree.
>>>>
>>>> This seems to be a strong statement. Given the effort that goes into
>>>> the DT, changes are supposed to be backwards-compatible. Is this
>>>> generally true, or is it just that we want an up-to-date DT for the
>>>> kernel to enable new features?
>>>
>>> Did you see this comment?
>>
>> It would have been nice to put the person which made that comment on copy.
>>
>> The truth lies in the world "supposed":
>>
>> The idea of a device-tree that never needs to change is quite old and
>> never became true on ARM devices.
>>
>> We all know Linux tends to break both forward and backward compatibility
>> of device-trees. Here is a nice example:
>>
>> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode
>> rgmii-id")
>>
>> Driver changes broke forward and backwards compatibility of a lot of
>> Allwinner boards.
> 
> Well, that happened in 2020.  Things have gotten better over time.

The 2020 event struck me because a Linux kernel would not even be 
compatible with the device-tree of the same kernel release.

This year I once again had issues with booting an Allwinner board with a 
device-tree from a different Debian kernel version. Both backward and 
forward compatibility were broken. But at least I could boot with a 
matching device-tree.

> 
>> Distros will continue to load the device-tree that matches the kernel to
>> get the best possible board support and need to do this efficiently.
> 
> Right.  Even if there is full backward/forward compatibility, you
> probably want the latest device-tree to make sure you get the most
> complete hardware support.
> 
> But this shouldn't be used as an argument to not care about
> backward/forward compatibility.

Nobody in this thread suggested to not care about forward and backward 
compatibility.

Best regards

Heinrich
