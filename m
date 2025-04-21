Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9320EC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD00A81703;
	Mon, 21 Apr 2025 18:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iTAhgj3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CB98171B; Mon, 21 Apr 2025 18:51:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E62815D1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0AD0641A04
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745254274;
 bh=ye7lKoaaT/TMbCUFXV32XJguO/a2CJdeLu1D+LgvAh8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=iTAhgj3zZx3QdAkqiEdHTozfNUX+4VBhZIVGvrL/TG4HEGtO3xsRDsGFjk6YC3T15
 9+IdcUPJ3zQTXgJRU8hYuSoPr2hLILPLbmG/ccKjp0z3aick5TurvDz9xAMr0HxJKe
 ZY8vTUlMaDzLmELFI1omkV1RX2LcNSs6tdLETPQaYmjMvvX4EZORLVJ49kHcDt/lIz
 n9HWIY+ir1p+ODjwXuip8YRVQp3QlnJNolJV/H1gxMPuUbkx3jX2jookkLb14Av+ZP
 rc9VsS0FwfEChUJ9bhUNfPtF9EHFhJa1Y4a8ww0EhryNhhVnVQnL8cijDZAMm/J5hr
 17nPNFI+R0Haw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so1865654f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745254271; x=1745859071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ye7lKoaaT/TMbCUFXV32XJguO/a2CJdeLu1D+LgvAh8=;
 b=IoEK4eofGqssoyAsWxVAawNdpE+9Kd5fosYn00CJRVT2Fgo8kU+CuOLAMtbvrXZi/g
 LK/6bkHmXzs0BH/EB2XQ3Sp7ZOtLZm3GBB3JSElScQoflAAxjuyR/BTFGyE0mSa1T70R
 5uT9PLZlrYcPmyZLadkbs24fbwVHxGlK/5HkZ9cZKJ+aBI4xrjSD5Y61a/Bw3f8ku/3J
 gsQK5r//noOKGBDf9uJ/TuFn5PV5HhXyl1E0yNax+SnoByIk41cRKWNi+vTZBemxLyEX
 FsIJwGGwwdN2LiQQA5RtqZtYAeisyt2Cd4mlfH5ZSnJ/y1InIsOXUrsQY0J+oECYuHMU
 6ThA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYFti8GoyMGwjYNCiLAoh1BL89Ws6ZMZ6I5pfk3E8kh6MWqlW5d9MkPU2wI4/wggLMuR87n5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzGvKeE/e7m7QHd7ex9TnKU2wE1RcfANiyTE27zLTh1L3w9rA1r
 P7CB+sCWfNBQb4VdhlXEQ7Go9g2pn7XpAiZzx7yBtOqI/N8zjmFOiM5yWjUTN6aKLgZa0qfTNCb
 Tx0ma4ZJThmK1ZO3qNmQLAFozbu7UmrLSklxV5ZsUsunpyfbqDWx9RgkwwpvwWn00zCk=
X-Gm-Gg: ASbGncutpfWangw78BrEiveZgnaWvWej/IWRzUXQIpSaUCBp3Hv2Mv8plu5+0Abx5eW
 XEdV/8V6Zfvrj4MBAR8PLN8ixzOFnGJI3Cn7SY9lUiKqUGwqZpJHArjOv6rHs6PQG27l75qeGIK
 9pj1Cif7Mh8ifkzoqVktV7eLTbJP9wkk9AsIcJshHaA1XOqh6Ys4Anz9cgHgnIqdHjeH8pOeT++
 I+OH5JZHDyANVWR5yEujXCiUK36W/B9+/5m65QVr2Rm9B2PTaJFFMXsdNfyIPL7WGCmivOAlaXM
 61F5NRnjjyv0ki2UhgSa2wasZpH40FkMUl65UVL8pEpB5FPSrCPJWlFrkwhLe29qIrIezetZxvA
 JszSo4PkR
X-Received: by 2002:a05:6000:4021:b0:390:f9f9:3e9c with SMTP id
 ffacd0b85a97d-39efba5dd7emr9656932f8f.25.1745254271496; 
 Mon, 21 Apr 2025 09:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOCGZpTO6Lc0Gp+To8+20LoDmaxL00HMTE6/3OS5DpnqK8sByd4l1RVIw97iIXTyh8AMncJg==
X-Received: by 2002:a05:6000:4021:b0:390:f9f9:3e9c with SMTP id
 ffacd0b85a97d-39efba5dd7emr9656916f8f.25.1745254271099; 
 Mon, 21 Apr 2025 09:51:11 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa421c6csm12592178f8f.18.2025.04.21.09.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 09:51:10 -0700 (PDT)
Message-ID: <7b446edc-ec71-4be3-ada6-c677c25afdb6@canonical.com>
Date: Mon, 21 Apr 2025 18:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: BOOTMETH_DISTRO should select
 BOOTMETH_EFI_BOOTMGR
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@chromium.org, trini@konsulko.com, mkorpershoek@kernel.org,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, u-boot@lists.denx.de
References: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
 <87jz7dvjjh.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <87jz7dvjjh.fsf@bloch.sibelius.xs4all.nl>
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

On 21.04.25 13:30, Mark Kettenis wrote:
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Date: Mon, 21 Apr 2025 11:43:10 +0200
> 
> Hi Heinrich,
> 
>> Distros expect the EFI boot manager to run. It falls back to launching
>> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
>>
>> BOOTMETH_EFILOADER is obsolete.
> 
> I don't think this is true yet.  For one thing, on my Apple systems I
> still get:
> 
>    ** Booting bootflow 'nvme@34bcc0000.blk#1.bootdev.part_4' with efi

There is also a bug in the EFI boot manager:

[RFC 1/8] boot: EFI boot manager does not depend on BootOrder
https://lore.kernel.org/u-boot/20250421162555.1200687-2-heinrich.schuchardt@canonical.com/T/#u

> 
> even though
> 
>    CONFIG_BOOTMETH_EFI_BOOTMGR=y
> 
> Not sure what's going on here yet.  Maybe this is related to:
> 
>    Cannot persist EFI variables without system partition
> 
> (There definitely is an EFI system partition on this system).

It seems that the block device is not scanned at that point.

> 
> To me this points out that something is broken again.
> 
> But I also think that there are other ways in which the integration of
> the EFI boot manager code in U-Boot is flawed, and frankly I don't
> think the idea of having a self-coontained EFI boot manager is
> compatibe with what some users expect from U-Boot.  And I think
> keeping something like BOOTMETH_EFILOADER is part of the answer.
> 
> I meant to explain my thoughts in a reply to earlier messages, but
> could find the time until now.
> 
>  From eralier discussions I have composed the following (incomplete)
> list of requirements:
> 
> 1. Some users want to contiue booting using "legacy" boot methods.
> 
> 2. Some users care about booting as fast as possible.

This is why we need to move the boot manager after booting from block 
devices.

And we should not try to run EFI/BOOT/BOOT<ARCH>.EFI before running the 
boot manager.

That is why I am working on this series:

https://lore.kernel.org/u-boot/20250421162555.1200687-2-heinrich.schuchardt@canonical.com/T/#m9bc0236cffe70ee06df4c482a958303faff3a32c

where I have included the current patch.

Best regards

Heinrich

> 
> 3. Some users want to be able to boot from a specific device but don't
>     really care about the boot method (EFI or "legacy").
> 
> 4. Some boards have sepcific boot methods (FEL on sunxi, maskrom on
>     rockchip) that need to to be tried first.
> 
> The biggest issue is requirement #2.  The related issues in the EFI
> subsystem and EFI boot manager are:
> 
> a. Scanning for ESPs to find the file that contains EFI variables when
>     EFI_VARIABLE_FILE_STORE is selected takes time.  Unfortunately this
>     is the only way we can support EFI variables on many boards.
> 
> b. Scanning for ESPs to boot from takes time as well.
> 
> Of course the way bootstd looks for additional boot methods by
> scanning filesystems as similar issue.
> 
> Originally the EFI boot manager only handled the case where the user
> explicitly configured EFI boot options.  The "fallback"
> EFI\BOOT\BOOT<ARCH>.EFI loading was handled later when the distro boot
> scripts looped over the list of configured boot targets.
> 
> Later code was added to the EFI boot manager to do that.  I believe
> that was done as part of supporting an EFI boot menu, which to this
> date isn't really used by any board, at least not in the default
> configuration.  And the way that code works is by creating "default"
> boot options for all devices with an ESP.
> 
> I think the way to fix this is splitting the EFI boot manager into
> different phases.  The first phase should only look at the boot
> options configured by the user (either explicitly or automatically by
> an OS installer).  That still requires us to read the EFI variables.
> So I think we should restrict EFI_VARIABLE_FILE_STORE to only scanning
> the device from which we booted U-Boot.
> 
> The "fallback" EFI\BOOT\BOOT<ARCH>.EFI should then be done in a later
> phase, after some of the other boot methods have been explored taking
> into account preferences set by the user.  But that pretty much is
> what BOOTMETH_EFILOADER already does.
> 
> Cheers,
> 
> Mark
> 
> 
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/Kconfig | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index fb37d912bc9..89076220adb 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
>>   	imply CMD_TFTPBOOT if CMD_NET
>>   	default y
>>   	help
>> +	  This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>> +	  launching EFI\BOOT\BOOT<ARCH>.EFI if no boot option matches.
>> +
>>   	  Enables support for EFI boot using bootdevs. This makes the
>>   	  bootdevs look for a 'boot<arch>.efi' on each filesystem
>>   	  they scan. The resulting file is booted after enabling U-Boot's
>> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
>>   	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>>   	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>>   	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
>> -	select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>> +	select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>>   
>>   config SPL_BOOTMETH_VBE
>>   	bool "Bootdev support for Verified Boot for Embedded (SPL)"
>> -- 
>> 2.48.1
>>
>>

