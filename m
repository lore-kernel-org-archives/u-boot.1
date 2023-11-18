Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05667C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 23:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E7186EF6;
	Sun, 19 Nov 2023 00:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n2AYI6nM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F1986F40; Sun, 19 Nov 2023 00:06:11 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425F286EA3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 00:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C247B3F884
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700348765;
 bh=KSM27HRcxtY9MlkZuGMXw1qSFI1kJY1PVI+2DVv4Bos=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=n2AYI6nMQsklVKbc45E/r7PEcUQgheVkL8eDXRLdzKn+Yrwuaqh/ZYsHnHEKup1Xo
 VI3muyveThIXs7snJPRTItpH/lPp8Y1PoI+LF7R8o3zR/DK5Priv/u/pAZMkhTgZ/I
 gOuIgTdAlWiT/tfbINNKM2JneLk9/mU5Pl5F2WmewuHegE0Whlo0iKZGjDI90cm2YU
 +3xp4wBfyGix01JdfS3cyyIIumO5F6IzkMeC7jTPKw3mU9dwreKe3+nn9TRWtfa4WP
 e575kxS85XJQVaps1z9kUaDvf/6PlgiPCqV4f+wLcQpz5NoiCxuU+uEaDLwNG7T9DY
 xEnvstTkWgx1w==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32cef5f8af5so2045390f8f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 15:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700348765; x=1700953565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSM27HRcxtY9MlkZuGMXw1qSFI1kJY1PVI+2DVv4Bos=;
 b=I+Hn0jIeuQMXf/G9t7bwUPMSzYEQAui4io8fdrRad4Mn0DDsu+NcnZvcdDpofGAG6U
 RB42k+OmY1SOaLDdK4lycDMdVoP0zXyzCP2eOt5A7lKc0TyjH/oG8AuqycSFFaFK2MST
 ao2MnAeFeSUoqaBJDhUh7E4JzBCUr5sl+1AoqE2GqOwmGJbf0fw0/vrbpSImsLel0erv
 OtLU36jB1ucDtXhHDqXZICqmJmiVZotgucKhRBpg7YgVsWFG6361WNozYv5oWJKASCRE
 fMlWoJPLb+Sf73xzwD5k3A5yEAe7ma99hVGGIMLI+MwymJtAoTB5bA64YkLePb0i+nRB
 T4qw==
X-Gm-Message-State: AOJu0YzmcQFyE762dk6JVV7XddSOPW8xwgICwUElhd9ygWO8CP51Bv0b
 BFVvqiKM9gRcLEDEGY/LWBeNkOw1Ba7nlg7coOEHMIKI7LgylRV7lRJAtg3Omz5/H1NNQ6Up46t
 YvoynuDniTygj2CMvzJrEYkSZ87kSHHk=
X-Received: by 2002:a05:600c:4ecc:b0:406:44fc:65c9 with SMTP id
 g12-20020a05600c4ecc00b0040644fc65c9mr2630733wmq.8.1700348765371; 
 Sat, 18 Nov 2023 15:06:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS85it0mux9ahwvpKap96OoL/CBHVYXj4/Nw7eVd5ogRCdeVtkErYLtCamYQE63snpwVUAgw==
X-Received: by 2002:a05:600c:4ecc:b0:406:44fc:65c9 with SMTP id
 g12-20020a05600c4ecc00b0040644fc65c9mr2630723wmq.8.1700348765037; 
 Sat, 18 Nov 2023 15:06:05 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 c20-20020a7bc854000000b0040a43d458c9sm12119661wml.25.2023.11.18.15.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 15:06:04 -0800 (PST)
Message-ID: <189ebb7f-5b25-475e-b180-8b8d8c21b55f@canonical.com>
Date: Sun, 19 Nov 2023 00:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: create memory reservations in ACPI case
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ27mmK9BYE=rbGKGe9=xvZdG9reU659n-0D_wRfNemX5Q@mail.gmail.com>
 <3dd07df2-a261-47e6-9627-34e4529584c4@canonical.com>
 <CAPnjgZ2kFYiQuwzw5GP8OJteKhhGVRqdnNtAGY5v-C+3c-KZ+A@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ2kFYiQuwzw5GP8OJteKhhGVRqdnNtAGY5v-C+3c-KZ+A@mail.gmail.com>
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

On 11/18/23 18:58, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 18 Nov 2023 at 10:34, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 11/18/23 18:10, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Thu, 16 Nov 2023 at 02:29, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> ACPI tables cannot convey memory reservations for least ARM and RISC-V.
>>>> x86 uses the BIOS E820 table for this purpose. We cannot simply ignore the
>>>> device-tree when booting via ACPI.
>>>
>>> Why is that? I had thought that we had to use one or the other. Isn't
>>> the devicetree irrelevant when booting with ACPI, so we can just drop
>>> it?
>>
>> Linux Documentation/arch/arm64/acpi_object_usage.rst, line 718f
>> describes the mechanism to convey memory information as follows:
>>
>> "For arm64, we will only support UEFI for booting with ACPI, hence the
>> UEFI GetMemoryMap() boot service is the only mechanism that will be used."
>>
>> With the patch we tell the UEFI sub-system which memory areas are
>> reserved (e.g. for TF-A on ARM or for OpenSBI on RISC-V). This
>> information is inferred from the device-tree. The operating system will
>> collect this information by calling GetMemoryMap() immediately before
>> ExitBootServices().
>>
>> Without the patch Linux on RISC-V using ACPI crashed when illegally
>> accessing the memory reserved for OpenSBI.
> 
> OK thank you, I misunderstood it.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Perhaps someone could convert efi_carve_out_dt_rsv() to use the ofnode API?

Is there any ofnode API to retrieve reservations as easily as with 
fdt_get_mem_rsv(), fdt_num_mem_rsv()?

boot/image-fdt.c, boot/fdt_region.c, boot/fdt_support.c, cmd/fdt.c all 
use the libfdt API directly.

Best regards

Heinrich
