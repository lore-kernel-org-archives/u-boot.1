Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3800CC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 15:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263D586FA7;
	Fri, 17 Nov 2023 16:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z462mGTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2286186F5C; Fri, 17 Nov 2023 16:12:12 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E85D86F5C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D442D3F886
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700233925;
 bh=DEsMz1XLKjtFX+lxWhbGbJ3aHhEilF9AjAyYn1Gb4uk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Z462mGTfIGRfi102b+2wDPo2VXb0QtApt9/FAjHCc14wNMG7yopElC3U2BTl61d1R
 N/Sf9EXwNZqVErtPH6wub0YAioWQzPCVr3e3VvZ2oXnPU6JdPWxMARQ+AN61HIMPgM
 JSkT2bnqeSUEAe0eX+rj4jORNJdHb5A/3z3pZu4Xzjg/fifeDT4Lm/aPaxjVZJDdff
 Lvb1yax28hUFCeEY/r2qNQpv0RGySbRBdz/JQ8/Co8eHoMqLCwLDJfoU0zVx2kHfSr
 QQGvsI7M9c8g0uZVLOCfyVI6LZ44o6Nn0mCMB6Ju+XSwS+/r4QO/zBCz80WEiN6l2F
 3tJ6G0rLOseeg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40839252e81so12212405e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 07:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700233925; x=1700838725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DEsMz1XLKjtFX+lxWhbGbJ3aHhEilF9AjAyYn1Gb4uk=;
 b=d1YW38BGnhkrL9BZ4igFGAd7rzwXm8B4e40PW9gTNHibjWGRnE4V+7+DWKhnn14LLz
 yGPDg5Nn60Tyq2YCcgFuc6YdiDZBMkzgT3otyNljX+qCc0TjwGc9R9AnsOIPhXTHtjl+
 +uG9M4WdLzfjwkYv19lAmZ4P/aP7OaUCISvYILZIH2zoiUjJ/q8bJFbjAMF3QatEXnAm
 yUkKRfZQIOcrL+RGBLB0Uj5XR1lQIcyewxlXOJZwrWz0ALTpAJQPnahJf9rFNJfzDseL
 kvv5pbtw8JI0F7stKHXfnCg+NJ1zt+/aEQdG8BpMjrPAB5F1ptoc1C77WoXG/Zw2rF0r
 ko3A==
X-Gm-Message-State: AOJu0YxdsT+hZ+W/t+86kU766imDU+HhCzXqkFe4K5Pqv3+YUZ440DvL
 eHRpkCq6iSLJdizc61dQTIEVH7ftfLF7jRTppGAslqAwsM/Pd3lDllB5/a0uJ7fmJMMXsMOojJh
 9mprKGzBqCJI8f3Igb5wTiT/hzxIaKEM=
X-Received: by 2002:a05:600c:4e86:b0:405:9666:5242 with SMTP id
 f6-20020a05600c4e8600b0040596665242mr16166925wmq.31.1700233925314; 
 Fri, 17 Nov 2023 07:12:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/PKP+WODst9NsbJBf3pXdjXbdBLlPwQ7mVIYYm8SOMJZ6RoRlJCxfhP0YXDhcosN1QqUQCw==
X-Received: by 2002:a05:600c:4e86:b0:405:9666:5242 with SMTP id
 f6-20020a05600c4e8600b0040596665242mr16166908wmq.31.1700233924860; 
 Fri, 17 Nov 2023 07:12:04 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 f10-20020adfdb4a000000b0032da35baf7bsm2555175wrj.113.2023.11.17.07.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 07:12:04 -0800 (PST)
Message-ID: <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
Date: Fri, 17 Nov 2023 16:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bootstd: Support for distro specific EFI folders
Content-Language: en-US, de-DE
To: Shantur Rathore <i@shantur.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
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

On 11/16/23 19:45, Shantur Rathore wrote:
> On Thu, Nov 16, 2023 at 6:15 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 11/16/23 17:52, Shantur Rathore wrote:
>>> Hi Simon,
>>>
>>> Currently bootstd - bootmethod_efi only looks for the default
>>> bootxx64.efi in /EFI/boot folder only.
>>> Generally many distros end up putting their bootloaders in
>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
>>>
>>> In x86 worlds, the NVRAM is modified and new boot entries are added to
>>> support these but in the U-boot world the NVRAM variables are
>>> read-only.
>>
>> I guess you are referring to UEFI boot options. These typically are not
>> stored in non-volatile RAM but on a SPI flash device.
>>
> 
> Thanks for correcting me.
> 
>>>
>>> What would be the best way to implement this?
>>>
>>> I was thinking of having a "efi_prefixes" environment variable which
>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
>>> all of them. Will bootmethod_efi be able to support multiple entries (
>>> thinking of multiboot ) ?
>>
>> On my laptop I have:
>>
>> EFI/Microsoft/Boot/bootmgr.efi
>> EFI/Microsoft/Boot/memtest.efi
>> EFI/Boot/bootx64.efi
>> EFI/Boot/fbx64.efi
>> EFI/Boot/mmx64.efi
>> EFI/debian/shimx64.efi
>> EFI/debian/grubx64.efi
>> EFI/debian/mmx64.efi
>> EFI/debian/fbx64.efi
>> EFI/ubuntu/grubx64.efi
>> EFI/ubuntu/shimx64.efi
>> EFI/ubuntu/mmx64.efi
>>
>> Obviously each installed operating system provides multiple EFI binaries
>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
>> debian centos" would not be able to describe which file you are looking
>> for.
>>
>> We already have the U-Boot command line eficonfig and efidebug commands
>> to set up UEFI boot options which can describe which EFI binary to load
>> and which command line to pass to it. These are considered by the
>> existing boot flows.
> 
> So, I am building a new RockPro64 based cluster and using Canonical
> MAAS to set them up automatically, booting them up using DHCP and
> installing them over the network.
> I configured an Armbian image using Packer to be compatible with MAAS
> and it happily installs it. As part of installation process, a
> grub-install is run which installs the grub efi,
> this EFI ends up in EFI/debian instead of expected EFI/boot.
> To be able to make it boot, I have to add commands to move it to
> EFI/boot. I am trying to find a way in U-Boot that would allow me to
> skip this step.
> With eficonfig if I understand correctly, it would need manual
> intervention to create boot entries.
> 
>>
>> If you are installing the shim-signed package on Ubuntu, the EFI boot
>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content
>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and
>> therefore should work with current U-Boot.
>>
>> Patches are pending upstream to make EFI variables writable from Linux
>> if they are stored in the RPMB partition in the eMMC. See this series:
>>
>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@linaro.org/
>>
> 
> Would it be possible to save it in SPI Flash as the U-Boot environment ?

Currently this is not supported by U-Boot.

The U-Boot environment variables can be stored in lots of different 
places SPI flash is only one of these. But none of these locations is 
protected from OS access which would be preferable for UEFI variables 
for security reasons.

To support boards without eMMC the right way forward would be writing a 
new implementation of the OP-TEE standalone MM which writes the 
variables to SPI flash instead of the RPMB partition and ensures that 
the SPI flash' MMIO registers are protected against access from the 
non-secure world.

Best regards

Heinrich
