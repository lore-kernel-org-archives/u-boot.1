Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FF4C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 13:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254ED80BA8;
	Wed, 23 Apr 2025 15:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="A4xYO9gf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E96080F03; Wed, 23 Apr 2025 15:02:44 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF58803DF
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 15:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D41AE3F2A8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745413361;
 bh=R6nnu/apLzslbGQSQDJsRPOS2nGi/IusCqrXMar0h0A=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=A4xYO9gfI1qL+nFqxrhgRHOG3Vy+i9PxtFAyViP2Z8aeJ3pdLQbF7wNR514V6LMDd
 KOxUDL3aoKD1e8+Aq8aklZtkLDuhawVGlCF42LL1fbDuTYtpQqGIti6l1fwABGv5PW
 YfPz/Zk9Dk/37wjbo/7pnX4e9oSjGxUfaOjc1tgwNKtf9cMNYGxYMhpk0heT8NygVM
 RNBq9rH5Svi6AIaFfODTkOoPHK1/iys1Au26XD6FT2GnY+E60Suw72f8FIk0+KXwDi
 AnrES4AIlOq9SOh7zzGWmqSMQpV4eACjD2pQGS8C2tEyZN4NjcruQH8EjoPg3xIvSB
 5dkEjWp6UFmJQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eed325461so35869105e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 06:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745413361; x=1746018161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6nnu/apLzslbGQSQDJsRPOS2nGi/IusCqrXMar0h0A=;
 b=Gz2JHJFPqPExz2Inl9b+tv0pMmRV3zH2GzJTwdpHtKc/DExmiYimdK73wS6K2EwZ4N
 hvHytZkBecMlNbl/k6AqjjMf6je8hXpcklRQGQ7INGVnIf+g1vXGLzkz1diqZHjYQQJi
 C47TBAsB3N9+nBQUbI7QTnaHY89c9cttzmf1l7nwW/c6pU1pwREZWDqBQDm1tIDybV2D
 ylHLZutPgYA4R49u0IuUThS3fUMuL6a+4+FebZYpw4FS87sAVhAlkAKqNTAl1KAQUIXg
 RI562mvd7wd9KS6pImk4ylrGSj6eqXWvhhgjp624YoqLv+pU0UxW2CIwlr9YNhMZ8zVG
 RsHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPgQp5I99kkflOzUYxSFxcEmhREoFB6kdWQ8Lo1pdGZb4AFlxUm+nQ5RDvyIY3JICqBD4PhKA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl7eOiuRe+u/xwUvaPznbZjo/B6N2pvJMZaF0vVxZWA4sh/Z1a
 4KqzBfZRald7woG8Rn35L0CskssQC++iMVC84kb7cpCSInRwkhG/lFeMUvIcPZ5mp5FxwAAZJq7
 mwzFMqE4DlAKNMLSNrMC3A7ILDE3dS0EUs79U8WuO+H1Eugi3MUn3WrmDn/YjV9/o74M=
X-Gm-Gg: ASbGncu7pgwruuyjP7ZZ4LoQ34t6pcF3hH5d7IdzOqwq6lR4VgyKk+RjNdCLSdZ2USU
 /6Jcz59Lw+dLt5FJHRiRvbs3d1gUtIrUW0UNU30ZQShOSvwUbaGMO7RMeEzt2Gdngo8AnvpdRYC
 IeOci/7pbXSUbE14Tty8MOV8NXPEAkFWE1krdVeiBZD0A7Ff9AIp6GcbdCiq3UeGwkY96K5VFjx
 52/LTtSR+YZ9rVvZ+qq7/rOLI1C5tZWIl7NI0F8NMRfpp1one42ueWQ13s3qHhm8/F7fkuXE107
 KCeirg0vTi1nVlSGCBMAoNNxwZg/uZ6cdHhKxXCw2KxseBElH3717Zli6Ixh2QL7Z1Pcr0Obld9
 LQYw+h/h/
X-Received: by 2002:a05:600c:1906:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-4406ac11581mr159268015e9.33.1745413361230; 
 Wed, 23 Apr 2025 06:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK6LFlHab5L6JEn8GrSYgWVmcYIC+l0xFMgQMjEpKYrteWH4rHcyXYNOutVKSS+QY77MLMSA==
X-Received: by 2002:a05:600c:1906:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-4406ac11581mr159267235e9.33.1745413360397; 
 Wed, 23 Apr 2025 06:02:40 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c8b0ea0sm28049345e9.2.2025.04.23.06.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 06:02:39 -0700 (PDT)
Message-ID: <ecde0d49-f04a-4a75-bacf-a170c2ebb0df@canonical.com>
Date: Wed, 23 Apr 2025 15:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: BOOTMETH_DISTRO should select
 BOOTMETH_EFI_BOOTMGR
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgeJ_kvdUrBC=btzKAQGVZDtyJzk1LuD4t58n0zMmvU8w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgeJ_kvdUrBC=btzKAQGVZDtyJzk1LuD4t58n0zMmvU8w@mail.gmail.com>
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

On 23.04.25 14:28, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 21 Apr 2025 at 03:43, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Distros expect the EFI boot manager to run. It falls back to launching
>> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
>>
>> BOOTMETH_EFILOADER is obsolete.
>>
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
>>          imply CMD_TFTPBOOT if CMD_NET
>>          default y
>>          help
>> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>> +         launching EFI\BOOT\BOOT<ARCH>.EFI if no boot option matches.
>> +
>>            Enables support for EFI boot using bootdevs. This makes the
>>            bootdevs look for a 'boot<arch>.efi' on each filesystem
>>            they scan. The resulting file is booted after enabling U-Boot's
>> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
>>          select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>>          select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>>          select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
>> -       select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>> +       select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>>
>>   config SPL_BOOTMETH_VBE
>>          bool "Bootdev support for Verified Boot for Embedded (SPL)"
>> --
>> 2.48.1
>>
> 
> I don't want to make this bootmeth obsolete. What is the motivation for that?

This method was written in a way that per se violates the UEFI 
specification as it does not set up required UEFI variables.

You must never run this before the boot manager as booting 
EFI/BOOT/BOOT<ARCH>.EFI if there is a boot option violates the UEFI 
specification-

The boot manager covers the functionality of this bootmeth.

Best regards

Heinrich
