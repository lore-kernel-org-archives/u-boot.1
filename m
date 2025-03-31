Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A4FC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4EC88171B;
	Mon, 31 Mar 2025 18:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nIJ0byqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9930681DE3; Mon, 31 Mar 2025 18:39:48 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFD681026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3AD5E3F5BA
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743439185;
 bh=2vXu8lLdXZOYVKA/R9oTSd3ZN0U/4HGlTz3ok5+QIG0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=nIJ0byqka10tO75MHY0gClXyBjT4fIIr5uSrfn36gBPU7lLhtXd7RIJ24BGZt5qpY
 lKiV0UaHRgtU8lkSXgpCamsye+k0CTq6dOGUB+eyi2aCbnbkUGAbKPeS9uHzqUJm15
 T+ayu7VWZ5KPZP39GCDvX0OUgPWtCdjyd5yVEa/zvAt7mPIzN+Os6lb4BgDC25VGPy
 kWD23HrdWM/BnOnB7cbKIJ3KmYrXismOQmdFIOFbC0/v0Z2V3vz8Z8iygnd6JsKcyD
 BZrEIgOBqYOU22/RMPwajWaeCOy4zC23TM7AxUc/suxE4vEkibL40YXeds5dx6PpVt
 tUuh+q0HcecyQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912d9848a7so2837521f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743439184; x=1744043984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2vXu8lLdXZOYVKA/R9oTSd3ZN0U/4HGlTz3ok5+QIG0=;
 b=DhCQAo87+rRNVVWVLRpD96Ex+CFLYHcubYTtFAQI48dOf7C1AjBBjVgElyajbB8XcA
 wzhtBjjV4Jd/QPxQ/yV1dxPrU6AuAElz4dGVkO80Yv0YuwV3kfnVaZdyawGrD6+j8diB
 APG02qKuNy961SbcrhTZFxrcBQfYdEacL8Jjp1r9MFGkZV/5ycGm553TnsNvKb4YGvdy
 rTdsutoyyvs2fQKVmG7IfMXwotRT/IF1pk5qbvYWIfTkflETqpZMuzJOd9GAHOq9tv1S
 SB+947rV6DS0E5KPSnIFRIkDcJ1nSTsrw+VgIOvQCLz0O/8LqK0fzbpp0vKz+MtGsGFy
 oU+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm3WLrpLF1yx21DEUO3Smd/Dyh9DoToNwMwcUvxSeRIzZ4P8Vsg4d2L5fqurFya1ZY7pfC9V8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy75jnIcJaOJQcKxhVpWcghlgkPFdcsblf+8xyWTN1INI8JAxe
 xV8lmWnNxqDZx4m4bxlJcq6wssKFC69nJZW38Tsr+2LU+eQHcLmqm00Mt+bSAepS+tiQYCpurT7
 /HkYP+B19JFtwuqp/tFUxBo6JM2vwQDJlyMkZekKGbjbgRkNQJqmetvPuyFBvwxgr9/s=
X-Gm-Gg: ASbGncu5uJuMPG72/jwppYiwqb/b5Bg6MFkGbZc9NYlYGd0+UFyd+yPcU94HWIdwc4Q
 szEw9eYLRAc+zfnCo9CA4tfWNJMC1aKABk4TCdSPGQjZ+pnckT9QTG2+ooF9vXYk9shwN22ykCW
 4Kr97QAYCHTXK+FmBWByabcb+51U4CiQ0EfaOhDbMZBTz+ItY/Gt3TFsbZnq55cF0MJnsjlbl9A
 NctOFr8vpXlRgBS8E2WbZr932RHc0N/B0Inw36KOHrGvF8gwD5+Sd1NDsOpyvV02akh7IDYoj4E
 Rtyb8AzoLw9gKq3MgPW5w0L+9VgFkgSxZM5Dl6GrzrM3UtgDUYoWQdUo4Xq0e/n2bGMRTQVl9kF
 eNGRsI/3WcOh1
X-Received: by 2002:a05:6000:4284:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c0bf23245mr11739964f8f.2.1743439184526; 
 Mon, 31 Mar 2025 09:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgUH9Bmt92eSzUdf8RZ9t0WLXFfULa4UHPq5MKyQ/bb7hHOTZL+9WYtKbYxFFZ0F67yRrP4Q==
X-Received: by 2002:a05:6000:4284:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c0bf23245mr11739939f8f.2.1743439184124; 
 Mon, 31 Mar 2025 09:39:44 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba3ee4sm129081655e9.8.2025.03.31.09.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 09:39:43 -0700 (PDT)
Message-ID: <51ed9b8a-c69f-4ed8-b611-a0a42c9354d0@canonical.com>
Date: Mon, 31 Mar 2025 18:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <20231025211354.GZ496310@bill-the-cat>
 <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
 <CAPnjgZ1zzWZ48nn2ux7yd1pJ4mWVOt4w2ToBZC6MR2wcxbnMsQ@mail.gmail.com>
 <db43d704-8f6d-4583-9b86-d1d2709f7bf6@linaro.org>
 <CAFLszTgaZC6eOdtSV5Ukny3zffiixVep14iSiYzc8RpykmBE9g@mail.gmail.com>
 <657308f0-bc64-49c3-bd14-c932a88e5ccd@linaro.org>
 <9c6ac5b0-8a4d-47fd-8be3-d9d49f9cb644@canonical.com>
 <98a9629c-a6b4-4e01-8f2b-694ee6ca7c06@linaro.org>
 <20250331163045.GF93000@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250331163045.GF93000@bill-the-cat>
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

On 31.03.25 18:30, Tom Rini wrote:
> On Sun, Mar 30, 2025 at 04:38:12PM +0200, Caleb Connolly wrote:
>> Hi Heinrich,
>>
>> On 3/28/25 15:18, Heinrich Schuchardt wrote:
>>> On 28.03.25 14:00, Caleb Connolly wrote:
>>>>
>>>>
>>>> On 3/28/25 13:01, Simon Glass wrote:
>>>>> Hi Caleb,
>>>>>
>>>>> On Sun, 23 Mar 2025 at 12:39, Caleb Connolly
>>>>> <caleb.connolly@linaro.org> wrote:
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> Reviving this as it is still very much an issue, and
>>>>>> especially relevant
>>>>>> for Qualcomm platforms.
>>>>>>
>>>>>> On 11/3/23 20:44, Simon Glass wrote:
>>>>>>> Hi Heinrich,
>>>>>>>
>>>>>>> On Wed, 25 Oct 2023 at 15:22, Heinrich Schuchardt
>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>
>>>>>>>> On 10/25/23 23:13, Tom Rini wrote:
>>>>>>>>> On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wrote:
>>>>>>>>>>> Date: Wed, 25 Oct 2023 21:57:44 +0200
>>>>>>>>>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>>>>>>
>>>>>>>>>>> On 10/25/23 20:23, Simon Glass wrote:
>>>>>>>>>>>> Hi Heinrich,
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Heinrich,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
>>>>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Forward and backward
>>>>>>>>>>>>>> compatibility of Linux
>>>>>>>>>>>>>> kernel device- trees is
>>>>>>>>>>>>>> sometimes missing. One
>>>>>>>>>>>>>> solution approach is to load
>>>>>>>>>>>>>> a kernel specific
>>>>>>>>>>>>>> device-tree. This can either
>>>>>>>>>>>>>> be done via a U-Boot scripts
>>>>>>>>>>>>>> (like the one
>>>>>>>>>>>>>> generated by Debian package
>>>>>>>>>>>>>> flash-kernel or by a boot
>>>>>>>>>>>>>> loader like GRUB.
>>>>>>>>>>>>>> The boot loader approach
>>>>>>>>>>>>>> currently requires to know
>>>>>>>>>>>>>> the device-tree name
>>>>>>>>>>>>>> before first boot which makes it unusable for generic images.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>>>>>>>>>>>> This will allow bootloaders
>>>>>>>>>>>>>> to load a kernel specific
>>>>>>>>>>>>>> device- tree.
>>>>>>>>>>>>>
>>>>>>>>>>>>> kernel-specific
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The variable will not be
>>>>>>>>>>>>>> exposed on ACPI based
>>>>>>>>>>>>>> systems or if the
>>>>>>>>>>>>>> environment variable fdtfile is not defined.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Heinrich
>>>>>>>>>>>>>> Schuchardt
>>>>>>>>>>>>>> <heinrich.schuchardt@canonical.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> v4:
>>>>>>>>>>>>>>              Generalize the
>>>>>>>>>>>>>> description of the content
>>>>>>>>>>>>>> of $fdtfile.
>>>>>>>>>>>>>> v3:
>>>>>>>>>>>>>>              Add documentation
>>>>>>>>>>>>>> v2:
>>>>>>>>>>>>>>              Use a unique
>>>>>>>>>>>>>> GUID to enable future U-Boot
>>>>>>>>>>>>>> independent
>>>>>>>>>>>>>>              standardization.
>>>>>>>>>>>>>>              Do not try to
>>>>>>>>>>>>>> add the variable on ACPI
>>>>>>>>>>>>>> based systems.
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>       doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
>>>>>>>>>>>>>>       include/efi_loader.h       |  5 +++++
>>>>>>>>>>>>>>      
>>>>>>>>>>>>>> lib/efi_loader/efi_setup.c |
>>>>>>>>>>>>>> 30 +++++++++++++++++++++++ +
>>>>>>>>>>>>>> ++++++
>>>>>>>>>>>>>>       3 files changed, 49 insertions(+)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git
>>>>>>>>>>>>>> a/doc/develop/uefi/uefi.rst
>>>>>>>>>>>>>> b/doc/develop/uefi/ uefi.rst
>>>>>>>>>>>>>> index fb16ac743a..702c490831 100644
>>>>>>>>>>>>>> --- a/doc/develop/uefi/uefi.rst
>>>>>>>>>>>>>> +++ b/doc/develop/uefi/uefi.rst
>>>>>>>>>>>>>> @@ -916,6 +916,20 @@ So our
>>>>>>>>>>>>>> final format of the
>>>>>>>>>>>>>> FilePathList[] is::
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>           Loaded image - end
>>>>>>>>>>>>>> node (0xff) - VenMedia -
>>>>>>>>>>>>>> initrd_1 - [end node (0x01)
>>>>>>>>>>>>>> - initrd_n ...] - end node
>>>>>>>>>>>>>> (0xff)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> +EFI variable FdtFile
>>>>>>>>>>>>>> +~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +Ideally U-Boot would always
>>>>>>>>>>>>>> expose a device-tree that
>>>>>>>>>>>>>> can be used for booting
>>>>>>>>>>>>>> +any operating systems.
>>>>>>>>>>>>>> Unfortunately operating
>>>>>>>>>>>>>> systems like Linux sometimes
>>>>>>>>>>>>>> +break forward and backward
>>>>>>>>>>>>>> compatibility. In this case
>>>>>>>>>>>>>> there is a need to load
>>>>>>>>>>>>>> +an operating system version specific device-tree.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This seems to be a strong
>>>>>>>>>>>>> statement. Given the effort that
>>>>>>>>>>>>> goes into
>>>>>>>>>>>>> the DT, changes are supposed to be backwards-compatible. Is this
>>>>>>>>>>>>> generally true, or is it just
>>>>>>>>>>>>> that we want an up-to-date DT
>>>>>>>>>>>>> for the
>>>>>>>>>>>>> kernel to enable new features?
>>>>>>>>>>>>
>>>>>>>>>>>> Did you see this comment?
>>>>>>>>>>>
>>>>>>>>>>> It would have been nice to put the
>>>>>>>>>>> person which made that comment on copy.
>>>>>>>>>>>
>>>>>>>>>>> The truth lies in the world "supposed":
>>>>>>>>>>>
>>>>>>>>>>> The idea of a device-tree that never
>>>>>>>>>>> needs to change is quite old and
>>>>>>>>>>> never became true on ARM devices.
>>>>>>>>>>>
>>>>>>>>>>> We all know Linux tends to break both
>>>>>>>>>>> forward and backward compatibility
>>>>>>>>>>> of device-trees. Here is a nice example:
>>>>>>>>>>>
>>>>>>>>>>> d0c6707ca423 ("arm64: dts: allwinner:
>>>>>>>>>>> H5: NanoPi Neo Plus2: phy- mode
>>>>>>>>>>> rgmii-id")
>>>>>>>>>>>
>>>>>>>>>>> Driver changes broke forward and
>>>>>>>>>>> backwards compatibility of a lot of
>>>>>>>>>>> Allwinner boards.
>>>>>>>>>>
>>>>>>>>>> Well, that happened in 2020.  Things have gotten better over time.
>>>>>>
>>>>>> (kinda off-topic context on DT version compat)
>>>>>>
>>>>>>    From what I've seen, there is not yet very much infrastructure or
>>>>>> common practise in place in the kernel to handle parsing DTB in a
>>>>>> backwards compatible way. For example there has been efforts
>>>>>> to simplify
>>>>>> the dwc3 devicetree for Qualcomm platforms with a series dating back
>>>>>> about as far as this U-Boot patch!
>>>>>>
>>>>>> https://lore.kernel.org/linux-arm-msm/20250318-dwc3-refactor-
>>>>>> v5-1-90ea6e5b3ba4@oss.qualcomm.com/
>>>>>>
>>>>>> Earlier versions attempted to convert the older DTS to the newer format
>>>>>> internally, but after much discussion it was decided that this wasn't
>>>>>> really feasible, instead the new approach is to duplicate the entire
>>>>>> dwc3 driver to maintain DT compatibility.
>>>>>>
>>>>>> It's obviously good to see compatibility taken seriously,
>>>>>> since it seems
>>>>>> clear that if we ever want to treat DT as firmware, the
>>>>>> kernel will need
>>>>>> to do this (and eventually vendors could ship laptops with
>>>>>> DT out of the
>>>>>> box which works with upstream -- crazier things have happened).
>>>>>>
>>>>>> But I think in the mean time we still want to be able to drive distro
>>>>>> adoption, and the way I see it teaching GRUB and systemd-boot about a
>>>>>> new FdtFile EFI variable is going to make that way simpler...
>>>
>>> There was a discussion in the context of EBBR if this is the right way
>>> forward. And the general opinion was that the compatible string should
>>> be used for matching the dtb files.
>>
>> Ideally, the file name should contain the same information as the compatible
>> string, or more. Currently in upstream there are devices with different
>> display variants that have identical compatible strings but different dtb
>> files.
> 
> I've asked before for clarification on if that's allowed or a bug and
> not really gotten an answer. It sure feels wrong and I think the
> argument is that devices doing things like that aren't likely to be
> general purpose anyhow.
> 

Multiple device-trees in Linux having the same compatible string is a 
bug as indicated by the device-tree maintainer in earlier discussions. 
It should be fixed in Linux.

Best regards

Heinrich
