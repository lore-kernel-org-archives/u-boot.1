Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E9C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 18:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C67381C64;
	Sun, 23 Mar 2025 19:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jblu4kU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9191081CAF; Sun, 23 Mar 2025 19:38:58 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC2A81B5B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 19:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so2070836f8f.0
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742755135; x=1743359935; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qP6agCMJ/lAdkB8o7Er+r9fige51MKq62K4b/hOmYJQ=;
 b=jblu4kU9JZbXynl28IE+iLfTd3E4+5Qrw3EUn4l0i/6U11WG0ZsiqPLhElKVulDcQx
 AufJnQd0Uabn492lHjc8nY4bS6Gv3IPwXD4ZefpjDAXWlMEIegXbF13meDWGOqOt2E4E
 vXrkyL5Jufzt44HWSS0BZ1QZjtznkRNWzO6lnaoPYc1MDAKJia3DIyZjG4MjCSl9K/mR
 +3F3JlEFBrAvydaaI82ZracnUhvitPq5I4Wr/LjVmb0aUxjMwDLRZbLGneftge+mln1W
 L6BszxVQ43IApQ/OzAkD2JVR+jmB5xx35CAeGiVnqsX8ISUjjpTX8s5BGHyhggngRTcJ
 A4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742755135; x=1743359935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qP6agCMJ/lAdkB8o7Er+r9fige51MKq62K4b/hOmYJQ=;
 b=kE6hMT3UaXp3d4mO5pgT/QR8K5RJ8eIwnxBXygN9m8gxhexsbwmq2trDEnT6Eg0Mf8
 iwvWMZUQL0wJdIFp6kR/xcUduJW3WS4X/q5/LKlTlpI2hNR00Yb1/7mCx7Y1wgBWgpLt
 jN7t/YZn8sqmga1IfEFsb94zBbsfBmBQ54Czl4dWfH8+qT1ARL5kJMlVoQG+b0PXZdmP
 7wXdSNqKP+wV1jOBAJk2wObaL+i0skIjwXrc3YYNjmY8XL7BoKkIpMr4zq0I4vLz8WlX
 xEwQUc2H/Vdjv9m8+kwSeFWMi80EzsDnHQvDijsfrokbUXi1UPDO0wfj8xDGnsKjpfiZ
 NlYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdPV0W2dooLPspzBu8EajeHHT7V1WogL8m3Li87AXqkb8aARONzyik76E67mSj8lproV2kFDU=@lists.denx.de
X-Gm-Message-State: AOJu0YwUGeGW7CgDnAI+rCt4GJW+oBYZb8i8mcRlrwlk4OpiyeNiiL87
 itwqsqDAXCkM1fqwsaVd6ZZs18SgPWV+9FjRsrvA5zp6LuIDZtgcYOn0zhD+h+k=
X-Gm-Gg: ASbGncsV8j8/0vNRK0RzDbSncV8675ecpMEYAIFX1bmHdmBbYsfXgJHwVlyTIet9HZ7
 SUFNz5HfJsEMa3VxeP+AhztBFy6boBANdZY+f0u4KvdL9kilJlMPZ3JTEvi/jiiiVm2VFpJOfAZ
 ziVXL6pRclTHCvfIEw93ovC1kKekfIsphfPONqoXkarcKhWQGY/s8mQlJ5VdRWmrvCQ8ZCacywR
 6AGPXemNS+lH4IsRe3Bi8sFeZ1J8GSTjwIxtBR++XB/owLK4gVvuJLplf+nobA0krwLZ7kei6jk
 6GLlydfvkv7oPHKcQBXex6WFzeUyJyLK4uEqzMDNNlbTPjfU498XfxwrEjlkARo/NXOCNLLVlXk
 =
X-Google-Smtp-Source: AGHT+IFIHjoJDXWEYIx8DbpWrnlhjSNCzkBOypkF+5kQDKrLZpSkt+WFLglzn4H95kK2w4OzW+kJMQ==
X-Received: by 2002:a05:6000:1fa5:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-3997f937d1fmr10247831f8f.38.1742755135201; 
 Sun, 23 Mar 2025 11:38:55 -0700 (PDT)
Received: from [192.168.1.38] (i5E863AB4.versanet.de. [94.134.58.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b25c9sm8354699f8f.42.2025.03.23.11.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:38:54 -0700 (PDT)
Message-ID: <db43d704-8f6d-4583-9b86-d1d2709f7bf6@linaro.org>
Date: Sun, 23 Mar 2025 19:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Simon Glass <sjg@google.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <20231025211354.GZ496310@bill-the-cat>
 <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
 <CAPnjgZ1zzWZ48nn2ux7yd1pJ4mWVOt4w2ToBZC6MR2wcxbnMsQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ1zzWZ48nn2ux7yd1pJ4mWVOt4w2ToBZC6MR2wcxbnMsQ@mail.gmail.com>
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

Hi all,

Reviving this as it is still very much an issue, and especially relevant 
for Qualcomm platforms.

On 11/3/23 20:44, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 25 Oct 2023 at 15:22, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 10/25/23 23:13, Tom Rini wrote:
>>> On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wrote:
>>>>> Date: Wed, 25 Oct 2023 21:57:44 +0200
>>>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>
>>>>> On 10/25/23 20:23, Simon Glass wrote:
>>>>>> Hi Heinrich,
>>>>>>
>>>>>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
>>>>>>>
>>>>>>> Hi Heinrich,
>>>>>>>
>>>>>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>
>>>>>>>> Forward and backward compatibility of Linux kernel device-trees is
>>>>>>>> sometimes missing. One solution approach is to load a kernel specific
>>>>>>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>>>>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>>>>>>> The boot loader approach currently requires to know the device-tree name
>>>>>>>> before first boot which makes it unusable for generic images.
>>>>>>>>
>>>>>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>>>>>> This will allow bootloaders to load a kernel specific device-tree.
>>>>>>>
>>>>>>> kernel-specific
>>>>>>>
>>>>>>>>
>>>>>>>> The variable will not be exposed on ACPI based systems or if the
>>>>>>>> environment variable fdtfile is not defined.
>>>>>>>>
>>>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>>> ---
>>>>>>>> v4:
>>>>>>>>            Generalize the description of the content of $fdtfile.
>>>>>>>> v3:
>>>>>>>>            Add documentation
>>>>>>>> v2:
>>>>>>>>            Use a unique GUID to enable future U-Boot independent
>>>>>>>>            standardization.
>>>>>>>>            Do not try to add the variable on ACPI based systems.
>>>>>>>> ---
>>>>>>>>     doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
>>>>>>>>     include/efi_loader.h       |  5 +++++
>>>>>>>>     lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>>>>>     3 files changed, 49 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>>>>>>>> index fb16ac743a..702c490831 100644
>>>>>>>> --- a/doc/develop/uefi/uefi.rst
>>>>>>>> +++ b/doc/develop/uefi/uefi.rst
>>>>>>>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
>>>>>>>>
>>>>>>>>         Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>>>>>>>>
>>>>>>>> +EFI variable FdtFile
>>>>>>>> +~~~~~~~~~~~~~~~~~~~~
>>>>>>>> +
>>>>>>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
>>>>>>>> +any operating systems. Unfortunately operating systems like Linux sometimes
>>>>>>>> +break forward and backward compatibility. In this case there is a need to load
>>>>>>>> +an operating system version specific device-tree.
>>>>>>>
>>>>>>> This seems to be a strong statement. Given the effort that goes into
>>>>>>> the DT, changes are supposed to be backwards-compatible. Is this
>>>>>>> generally true, or is it just that we want an up-to-date DT for the
>>>>>>> kernel to enable new features?
>>>>>>
>>>>>> Did you see this comment?
>>>>>
>>>>> It would have been nice to put the person which made that comment on copy.
>>>>>
>>>>> The truth lies in the world "supposed":
>>>>>
>>>>> The idea of a device-tree that never needs to change is quite old and
>>>>> never became true on ARM devices.
>>>>>
>>>>> We all know Linux tends to break both forward and backward compatibility
>>>>> of device-trees. Here is a nice example:
>>>>>
>>>>> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode
>>>>> rgmii-id")
>>>>>
>>>>> Driver changes broke forward and backwards compatibility of a lot of
>>>>> Allwinner boards.
>>>>
>>>> Well, that happened in 2020.  Things have gotten better over time.

(kinda off-topic context on DT version compat)

 From what I've seen, there is not yet very much infrastructure or 
common practise in place in the kernel to handle parsing DTB in a 
backwards compatible way. For example there has been efforts to simplify 
the dwc3 devicetree for Qualcomm platforms with a series dating back 
about as far as this U-Boot patch!

https://lore.kernel.org/linux-arm-msm/20250318-dwc3-refactor-v5-1-90ea6e5b3ba4@oss.qualcomm.com/

Earlier versions attempted to convert the older DTS to the newer format 
internally, but after much discussion it was decided that this wasn't 
really feasible, instead the new approach is to duplicate the entire 
dwc3 driver to maintain DT compatibility.

It's obviously good to see compatibility taken seriously, since it seems 
clear that if we ever want to treat DT as firmware, the kernel will need 
to do this (and eventually vendors could ship laptops with DT out of the 
box which works with upstream -- crazier things have happened).

But I think in the mean time we still want to be able to drive distro 
adoption, and the way I see it teaching GRUB and systemd-boot about a 
new FdtFile EFI variable is going to make that way simpler...
>>>
>>> Well, yes and no.  Given the brief summary here, I bet this was just
>>> like when phy-mode and am335x platforms had DT compatibility broken and
>>> the answer was that it was OK because the DT was incorrectly describing
>>> hardware. So this is the reminder that there are cases of breaking DT
>>> compatibility that are allowed. Even if the DT has been out (and wrong)
>>> for several years.
>>>
>>> That's not the main point of this thread and I don't want to derail
>>> things further along this point, I just want to note that the details
>>> here reminded me of when things are allowed to be incompatible with
>>> previous trees.
>>>
>>
> 
> Unfortunately I was off the list for a week or so, but I see this one
> so will reply here.
> 
>> You are conflating things:
>>
>> The EFI variable is a hint to the GRUB OS to find the correct
>> device-tree file without scanning hundreds of device-tree. You can not
>> build a compatibility check for it into U-Boot.
> 
> Actually we can...and I think that is what we should do.

No, how and where an EFI bootloader app chooses to load the FDT from is 
entirely implementation dependent. It may be extremely costly to compare 
compatible strings for every single dtb, and whether or not to do so is 
the decision of the distro anyways, all we can do in U-Boot is try to 
promote best practise (which clearly isn't compatible prop comparison 
for hundreds of DTBs...)

I'll note that systemd-uki does actually do this compatible prop check, 
but this would not be feasible for regular systemd-boot.
> 
>>
>> In distro-boot we are using the same value from environment variable
>> $fdtfile. Here you could check the compatible string but this might
>> break booting .
> 
> We need to figure that point out. The compatible string is
> programmatically is defined to be correct, so it is the filename that
> may/may not be useful. What am I missing?

Current distro images don't have a way to map from compatible strings to 
a filename, but they ship DTBs as normal files on the ESP.. They often 
have multiple kernel versions installed, and therefore multiple DTB 
directories which are versioned.

U-Boot doesn't know what boot entry is picked (and should not NEED to know).

Providing FdtFile as an EFI variable will make it possible for grub and 
systemd-boot to support the same kind of "fdtdir" property that extlinux 
does, this would simply enable versioned DTB loading for distros and 
make booting wayyyyy easier.

With regards to the design, I think a good follow-up patch would set a 
default value for $fdtfile (and consequently FdtFile) from the 
DEVICE_TREE build variable as a constant (maybe only if OF_UPSTREAM is 
enabled).

This would be correct in almost all cases (and wayyy better than the 
hacky fdtfile generating code we have in mach-snapdragon right now).
> 
> For distro-boot, do you mean the scripts? We are trying to deprecate
> those. Of course we have brought in all the same work-arounds, etc.,
> but with bootstd we can start to clean things up, I hope.
> 
> So let's think about how we can have U-Boot choose the right DT to boot with.
> 
> Regards,
> Simon

Heinrich, since it's been a while, if you aren't super interested in 
re-sending this patch I'd be happy to address the wording feedback and 
re-spin it, along with a patch setting the default $fdtfile (else I can 
send that as a follow-up).

I'll also open an issue for getting support for this added to systemd-boot.

-- 
Caleb (they/them)

