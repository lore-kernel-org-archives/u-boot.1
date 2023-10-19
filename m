Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A908BCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F3586F2A;
	Thu, 19 Oct 2023 18:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="f8G66714";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A7486F6D; Thu, 19 Oct 2023 18:10:00 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4C686801
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B15DD3F04C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697731797;
 bh=Ze6nII3IW/oZdQBl7OO08wgfXt656zPpfg4DxrIIe/g=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=f8G667148Tm08mYEAQ6GnfEnje2iyX74ic0/wFK0RlX8POMl9s6NRBKqYGgKgw1AN
 8uxeV/wJ9tkG3e6FJC3vEfrLmlGwQAZNw5+CJywUXLBE8ZSiRTLNflbrgrIbZlfM3C
 KIovsCKQH9ot/XbhRjwWbQnUZkLIDUcl2w1QOi7GkOOax0jZd2xYnfFFjilPkqCncQ
 B3fOho4NHflppWLlff5RPZcMPx+D47T3een3NsQhc9ebKkIAR+a2+YPgEhZ2dgak9f
 7BJUMQFC6VTfei6geO/B1FnMZBY1EU4xfBJ57Pai1FVySHgGepmqHzSsYKNKtTE6Mq
 FNaThH0ac6lbQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso11286785e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 09:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697731797; x=1698336597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ze6nII3IW/oZdQBl7OO08wgfXt656zPpfg4DxrIIe/g=;
 b=GKh+wmI6/IVg5esrD5XXPOZPXNj5a/tQmyc3sS+XXIjlvJ6rTfpuBQDCq9y39/lNZM
 XshBr8sOq6DfXmKdOKubR47O+mDk+SLSYgdvwxGm65nk5oHk2G87G9CQlGG0T2hX6ntg
 Ih0gY1lX0xSc/rfBqNgjU88RMRRPO3drb004Ny1u+LyfLlOjlqbWjUBr2OE/FwED46iW
 hIQKMxoZuQSvePPfV8xy4iLu7qsUa2HRQZQ3ORMbTPIVsZct5O/uIL6RAuUc9tnElckd
 46hohVbRumzt/QRO+s2ilqWjMr43/OFZEbrVcET/B4tKNVcUnjXftp3PcLqcyvJ6UEYw
 MGMQ==
X-Gm-Message-State: AOJu0YyHhEaUKnQk8NQtcjdjUXsoy5UiVkXfDFyHmDn/X7OwYYg5CuHQ
 5IfaS3yOzDqKxM2Ly4Y3dobeCM2Wu2FIE+JzrVpjriUEee9hhMHGJFZ+U4zHdZ+m7pv4JquH/k2
 xhFwocIsg1ibcROF+FICpHcKvPgal91o=
X-Received: by 2002:a05:600c:46d1:b0:405:3e9a:f1e3 with SMTP id
 q17-20020a05600c46d100b004053e9af1e3mr2233411wmo.11.1697731797262; 
 Thu, 19 Oct 2023 09:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZd0+mJEIlOzIY/12CNuFz1qjDDbMCZaxvtxNZFp5aWsuJDzjHYxbzxKXEHzJTwlSg499Bg==
X-Received: by 2002:a05:600c:46d1:b0:405:3e9a:f1e3 with SMTP id
 q17-20020a05600c46d100b004053e9af1e3mr2233398wmo.11.1697731796874; 
 Thu, 19 Oct 2023 09:09:56 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 d3-20020adfef83000000b0032dc2110d01sm4782528wro.61.2023.10.19.09.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 09:09:56 -0700 (PDT)
Message-ID: <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
Date: Thu, 19 Oct 2023 18:09:55 +0200
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
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
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

On 19.10.23 15:55, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 10/18/23 05:33, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> Forward and backward compatibility of Linux kernel device-trees is
>>>> sometimes missing. One solution approach is to load a kernel specific
>>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>>> The boot loader approach currently requires to know the device-tree name
>>>> before first boot which makes it unusable for generic images.
>>>>
>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>> This will allow bootloaders to load a kernel specific device-tree.
>>>>
>>>> The variable will not be exposed on ACPI based systems or if the
>>>> environment variable fdtfile is not defined.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>> v2:
>>>>           Use a unique GUID to enable future U-Boot independent
>>>>           standardization.
>>>>           Do not try to add the variable on ACPI based systems.
>>>> ---
>>>>    include/efi_loader.h       |  5 +++++
>>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>    2 files changed, 35 insertions(+)
>>>
>>> I was too slow to reply to v1.
>>>
>>> Does grub load the DT? I was assuming that U-Boot would pass it on?
>>> What is the interface between U-Boot and grub?
>>
>> The device-tree built into U-Boot is often out of date and not usable to
>> boot current Linux. A single device-tree can be loaded by U-Boot from
>> file and passed on as EFI configuration table. This device-tree may not
>> be compatible with all kernel versions exposed by GRUB.
>>
>> GRUB provides a devicetree command. It is disabled if you use secure
>> boot. At least in Debian and Ubuntu GRUB invokes the
>> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
>> fix-ups after loading a device-tree.
>>
>> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
>> devicetree commands to the boot options in grub.cfg.
> 
> Thanks. I wonder if you could document this somewhere? It seems like
> there are a lot of options and it is quite complicated.
> 
> Back to the question, I suppose you are expecting grub to load the DT
> using this filename? But why doesn't U-Boot load it instead? It seems
> very convoluted.

A separate file of this name exists for every kernel version installed. 
The loaded dtb must match the kernel. U-Boot does not know what kernel 
version will be chosen in GRUB. And for a generic image GRUB does not 
what board it is on.

> 
> Also, can we test this interface?

Neither the sandbox nor QEMU have environment variable fdtfile. And we 
don't create the EFI variable with ACPI as used on the sandbox.

Best regards

Heinrich
