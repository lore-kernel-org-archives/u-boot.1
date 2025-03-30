Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5311C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 19:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343E7812BC;
	Sun, 30 Mar 2025 21:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TbxkKYOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7968129B; Sun, 30 Mar 2025 21:30:17 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8B28129B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so643778866b.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743363014; x=1743967814; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sf8y5PUwM2WDGGC9jSeGiQhbWED8SUTFS9/912q1t9M=;
 b=TbxkKYOo1rEsFK0GRssjUbuip5V9Pwt/SDHanXRbRP6XZB5WXqlgbrCVzXpYvAZ52z
 jyA66K1Fp+EcdtojedaOWT7Zi4yhckqT0pO+P8v0C4Eg2/LivhUzmw8cyHflqUO1Irfa
 rcdzkXdOLE2AgL8bBfw2X6vbGVZR5zfm6L/9BPVMfaXrd2ctRfLYyK95O2SFH4hAxDKj
 qkX704ejXnp97hosrnGZBIIOOWuikLuL1+1/mpoHRQpD7Yh+rCXfmzTLDqDZQ7SuOaoB
 XIsmgI6OzXKprJZNuNPMCh9+ZyvdXS0Skb7A8ZUo3OOpEKQhXN28Cqt3vo6+f64r6YAH
 8jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743363014; x=1743967814;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sf8y5PUwM2WDGGC9jSeGiQhbWED8SUTFS9/912q1t9M=;
 b=gZPVm40h2xP/G4kLkNhy00Q4fAzidkXYUlHOjoFbgirRoeSiUamztKLh2nOHkDbVE7
 MJRTd5vKVYnpIKFzzEO1pD0BWTL2CIU3PKv6wWhh4muZp+blSx5mkb/dUg/i6rN6dwOC
 0rvkFNwvq1/CWHgk+gXoO0sbF2X3EUaHOSZz7A2z6y7yAiJN0O5VDJAVAUS9zl7+6BBt
 rPn6pNReHm3aBHCN36j8eWT/qYLAtRuUNzUYTOVEJjvEXgnmG+NdYLJLImeVP5JdEA25
 jbnJ4c5j+XecuNxLMuA8yDRuOWbNllQU+CwGMm+xdmnBdr7XqWN5cRZ47TomwHl9y3no
 auhQ==
X-Gm-Message-State: AOJu0YwGoVyTc1cGTTqOJPtRG81PRo0KFU4JKFqrKBCT1PfCHMCwCpTb
 dHuDexKjcGA9ic6qF8JBwGNjItQK66k4j6Bf3KUtTt6rYQbMAL3L
X-Gm-Gg: ASbGncvatMmTTMsz8tSwJQkkQdSODZYMzXuSogXgJzPU/rl0r2xfJ27H1MC8Gil44Y8
 567f0LlgG06Z0BVGlcqGPNhS4CctTtnZNNhKPayXl/JoeAeXukQ/8SPXPC8jfIwQXni/NVz+Nc3
 o+Z3wxbU3TKe5Kb7LFQClD9pAfBIYidrz7SNKxYaeNJvm3qxG9F/16pFA3/FVj72dI2Lv6ICrLG
 m8qu+F3ol3hpxVKpK3UvvQByfdV6m/o8nAAY6GQUW3OgXB+WnNykW6XzyvYPEG6ZWJJ97OJLtPh
 OcZmwro/mQNgupR3mdzZJJgUK8a7TamsarBvlK5s3FTsGw3HzfEu9+IFexpEPDmAuITabFBxADB
 sISmGY/g+NJAqvOKM7LP6
X-Google-Smtp-Source: AGHT+IF5f3J9r99y/J1U1A4+wLjCh+/BHYfls1zf0/mOgMdZkJXnbhfq1objSW0ILJxivN/Pvndjmg==
X-Received: by 2002:a17:907:6d19:b0:ac6:e33a:6a0d with SMTP id
 a640c23a62f3a-ac738bae06cmr527784466b.55.1743363013238; 
 Sun, 30 Mar 2025 12:30:13 -0700 (PDT)
Received: from [192.168.0.15] (89-64-21-122.dynamic.chello.pl. [89.64.21.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196dcf14sm509962066b.156.2025.03.30.12.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 12:30:12 -0700 (PDT)
Message-ID: <b8601ae3-479f-46fc-aa55-304e44026442@gmail.com>
Date: Sun, 30 Mar 2025 21:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support UART over MicroSD slot on Transformer T20
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
References: <20250318083103.63250-1-arturkow2000@gmail.com>
 <CAPVz0n3JF78RQYbckMcwN6JZC+adUG+oHNzof7Wkxd+EqeBkJA@mail.gmail.com>
 <af1c79f6-cfd1-45d2-8382-f68ad84276ea@gmail.com>
 <CAPVz0n3zveefuPCY8nvcqyeQ_NqZ=woq0ZqLja2AtfBLTVC-3w@mail.gmail.com>
Content-Language: pl
From: Artur Kowalski <arturkow2000@gmail.com>
In-Reply-To: <CAPVz0n3zveefuPCY8nvcqyeQ_NqZ=woq0ZqLja2AtfBLTVC-3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

W dniu 25.03.2025 o 08:14, Svyatoslav Ryhel pisze:

> пн, 24 бер. 2025 р. о 22:01 Artur Kowalski<arturkow2000@gmail.com> пише:
>> Hello
>>
>> Thanks for quick response. I know UARTD is the dedicated UART for
>> debugging on TF101, but exposing UART over microSD
>> is a handy trick useful for development. As I'm doing development on
> It is a handy trick indeed, but it is still just a trick and not smth
> that fits mainline. Maximum I can propose is picking funcmux change
> along with uart over sd section in transformer t20 documentation.
>
>> this tablet (bringing U-Boot's UEFI support and latest
>> Linux), and also still using the device on old OS I'd like to avoid
>> disassembling and reassembling it over and over again.
> I am not sure what are you doing but TF101 has full support of U-Boot
> as primary bootloader along with full mainline support till 6.14
> including. It uses extlinux boot method and needs no intermediates or
> chainloading.
>
> If you wish to use U-Boot for tethered booting that is perfectly fine as well.
Booting with UEFI didn't work, I have solved that problem locally by 
forcing LMB allocator
to not allocate at 0x0, any platform where RAM starts at 0x0 could be 
affected by it. Soon I
will send patches. I want to use UEFI so that I can take advantage 
systemd-boot features such
as one-time boot for system updates, some other software I plan to use 
also depends on UEFI.
Also, with extlinux I can't use verified boot, but, eventually I plan to 
program PKC and have full
secure boot with hardware RoT.

When bringing UEFI support I also made some changes so that U-Boot works 
with
CONFIG_OF_UPSTREAM, I also plan to upstream the patches soon.

Linux lacks GPS support and possibly camera, also sorry for my mistake, 
I meant a complete Linux
distro rather than the kernel only, which is lacking GPU acceleration. 
Also, when running preemptible
kernel I can see multiple "scheduling while atomic" errors and random 
system freezes under load.
>> Others too may find the feature useful e. g. to avoid having to solder
>> which requires specialized equipment, skills and
>> is potentially dangerous for the board. Also, there already seems to be
>> support for that on Sunxi platforms through
>> CONFIG_UART0_PORT_F.
>>
>> Apart from pinmux changes, would it be acceptable to include an option
>> to allow switching UARTA mux to
>> SDB/SDD (currently this has to be selected from board's Kconfig file).
>> Doing so would allow to enable UART
>> over microSD without patching U-Boot's source without changing any
>> existing configuration. Then I would
>> keep DTS overlays and config changes local.
>>
> I am fine with any changes which may simplify debugging for you as
> long as they do not invade into completed device configuration without
> a valid reason. Device must expose a dedicated UART for debug, not a
> mux which breaks some device features just because you do not want to
> contain them locally.
>
> For example, patches which add UART-E support along with funcmux
> change which exposes uart-e over usd were accepted, but patch similar
> to yours which would reconfigure usd to uart for surface rt or p880
> would be rejected.

I've sent v2, which besides few other fixes, adds dedicated Kconfig 
option for enabling UART. If disabled, the config is the same.

>> Also, today, after running U-Boot with debug enabled, I discovered some
>> failed assertions in pinmux code probably
>> caused by my changes, I will get that fixed before sending v2.

Turns out it was something else. I've sent a patch to fix that:

https://patchwork.ozlabs.org/project/uboot/patch/20250330211153.RFC.1.Iebf436d41ff5f52c0b11aaf9e8f98d6a2d4d56bc@changeid/

>> Best regards
>> Artur Kowalski
>>
>> W dniu 18.03.2025 o 09:54, Svyatoslav Ryhel pisze:
>>> вт, 18 бер. 2025 р. о 10:31 Artur Kowalski<arturkow2000@gmail.com> пише:
>>>> The first patch in the series brings general pinmux support for exposing
>>>> UART over SDB/SDD pins on T20. The following patches bring support
>>>> Transformer T20 allowing to enable UART over uSD by setting
>>>>
>>>> CONFIG_TEGRA_ENABLE_UARTA=y
>>>> CONFIG_DEVICE_TREE_INCLUDES="tegra20-asus-transformer-uart-usd.dtsi"
>>>>
>>>> Similarily, support for UART over uSD could be brought to Ventana which
>>>> has uSD on the same pins as TF101, and other Ventana-based boards.
>>>>
>>> Hey there, thank you for looking into U-Boot for Tegra. If something I
>>> will say hurts or offends you, I am sorry it was not intentional.
>>>
>>> Anyway, apart funcmux changes, all other changes you propose are
>>> redundant. Asus dedicated uart for logging and console is UARTD any
>>> other uart configuration must not be added since it will disrupt
>>> existing configuration. If you need uart and cannot resolve an issue
>>> without it you can always solder to uart-d or locally mux sd to uart
>>> console fix your issue and remove it. Uart is not intended way to
>>> interact with Asus TF101 and doesn't need to be exposed, panel and
>>> fastboot console are and can be used to resolve most of issues.
>>>
>>> Best regards,
>>> Svyatoslav R.
>>>
>>>> Artur Kowalski (4):
>>>>     tegra: add funcmux for exposing UART over uSD slot on Tegra 20
>>>>     tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
>>>>     ARM: tegra: expose UART-A over uSD on Transformer T20
>>>>     board: asus: transformer: add DTSI file for enabling UART over uSD
>>>>       slot
>>>>
>>>>    .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++++
>>>>    arch/arm/include/asm/arch-tegra20/funcmux.h   |  1 +
>>>>    arch/arm/mach-tegra/board.c                   |  4 ++-
>>>>    arch/arm/mach-tegra/tegra20/Kconfig           |  4 +++
>>>>    drivers/pinctrl/tegra/funcmux-tegra20.c       |  9 +++++-
>>>>    include/configs/transformer-t20.h             | 10 ++++++
>>>>    6 files changed, 57 insertions(+), 2 deletions(-)
>>>>    create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi
>>>>
>>>> --
>>>> 2.48.1
>>>>
