Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6FDC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 21:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4F78811E;
	Thu, 29 Feb 2024 22:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3KxFwKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FEA8811A; Thu, 29 Feb 2024 22:07:45 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C8288120
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 22:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7c403dbf3adso76821839f.1
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 13:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709240862; x=1709845662; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a4ia6j7qrJNATB1xGN1Cj5KI/yJbCt0+r5cEuHhh7AI=;
 b=N3KxFwKiKOf4i6DBu1n7/NgZoqX5yLyUCeTmQ+qXRytD4mLFJooJPMoVWyi4kTo9RI
 RxpX804EmvOxv81kwIVH8jHAMAHJ7EEBgGb2c0/5xpgRb7KbJYk+wEzkoV7U3eadxyN+
 pegr8D7ZXhoVyOXkrPGysqyNjbMnO8JUAkhWZ68C7mHvN78aRHwPMWsxwBvu7v1kZ7lw
 q5d56U39xqNfAq9APMurRJ6WFPJShjcwu+XqmSmjHRHqqpCZPGFYJ9O9cOCK+L7m/Sva
 Iudo2lJ1G/8UgdVcr7W3wkbmeV38QmeNSFlnIVL7rvYoutUtNaQN4YHpU8SNJIvP9lWu
 vdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709240862; x=1709845662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4ia6j7qrJNATB1xGN1Cj5KI/yJbCt0+r5cEuHhh7AI=;
 b=KDN4Lfbsyxw8dSl4BjrSQ5HJnDYxWy/Ka15OUT+poHx+in1xRpeRvIawDG3vsUaPCa
 DixNYj3CJH784VhFPtQPZPsDMN8/yE9v/Do34vVE27dQZTuF91l4b2bxCh5PFlD0BwZ+
 7lACuLbwu8diQ774V8agCgEJKVRla21eFzwGXpCRy/034C1eCM0U4dy1GrlZLT+yu72s
 Pvo2exrjHwbDt8ghgG5rSozLVu+u65h7idvq7wL2A0Sc7whgJJtcWhikRVBFKCXDkoJy
 8qgi7INR2PnRwN8Ans2HRwBFTHg7PNpcpitW/C1bJ3UGCEic+p+5tcVKvclNTOIx5SBF
 miKg==
X-Gm-Message-State: AOJu0Yy/s0P7sjlCIwREW/CH/MayO0WdEPVFEX6XgLdup4Xqy9ZS5mLS
 paTks/mme8PJyvbJoQcHgyxIQFWFOIf+xcbcWbEXN4DClptUKnlv
X-Google-Smtp-Source: AGHT+IGjozqCVcZquGtXpBHAFq8lDHgrNDOYB4teD++oGovAECe8IEsNWIKexl/UxmUUt+Kal4Z2kw==
X-Received: by 2002:a5e:db4b:0:b0:7c8:e2e:da3c with SMTP id
 r11-20020a5edb4b000000b007c80e2eda3cmr193891iop.10.1709240861690; 
 Thu, 29 Feb 2024 13:07:41 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:4cbf:637e:271f:139?
 ([2001:470:42c4:101:4cbf:637e:271f:139])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a02b1c7000000b00474a1ac6434sm482740jah.162.2024.02.29.13.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 13:07:41 -0800 (PST)
Message-ID: <c0c1387a-8bc2-450d-a9f1-5106ac83d67f@gmail.com>
Date: Thu, 29 Feb 2024 14:07:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Clean up arm linker scripts
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org,
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <CALeDE9OGc5ePPThdHc7RwUGkp67HGjZJZwq8GhtwGSBPXRYXWQ@mail.gmail.com>
 <CAC_iWjKAyUs2JrYN9OLrNKaOyChigdi7QH_780ZbXtRSFH2icw@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <CAC_iWjKAyUs2JrYN9OLrNKaOyChigdi7QH_780ZbXtRSFH2icw@mail.gmail.com>
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



On 2/28/24 04:15, Ilias Apalodimas wrote:
> On Wed, 28 Feb 2024 at 13:11, Peter Robinson <pbrobinson@gmail.com> wrote:
>>
>> On Wed, 28 Feb 2024 at 10:58, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> The arm linker scripts had a mix of symbols and C defined variables in an
>>> effort to emit relative references instead of absolute ones e.g [0].
>>> This has led to confusion over the years, ending up with mixed section
>>> definitions. Some sections being defined with overlays and different
>>> definitions between v7 and v8 architectures.
>>> For example __efi_runtime_rel_start/end is defined as a linker symbol for
>>> armv8 and a C variable in armv7.
>>>
>>> I am not sure if this used to be a compiler bug, but linker scripts nowadays
>>> can emit relative references, as long as the symbol definition is contained
>>> within the section definition. So let's switch most of the C defined variables
>>
>> Should we be setting/upping the minimum version of the linker version
>> as part of this?
> 
> The patch that added those as C-defined variables, was in 2013. So any
> linker that's not ancient history should emit those correctly.
> 

GNU ld fixed the problem on 2016-02-23, with this entry in the bfd 
changelog:

	* elflink.c (bfd_elf_record_link_assignment): Check for shared
	library, instead of PIC, and don't check PDE when making linker
	assigned symbol dynamic.

It looks like the change was first included in binutils 2.27, released 
2016-08-03. I don't know where the minimum linker version requirement is 
memorialized but there's a good chance that U-Boot already requires a 
version more recent than that. (Someone who knows where that is will 
have to check.)

In either case, I strongly agree: sections.c is an unnecessary 
workaround with any reasonably recent linker version, it's 
fickle/incompatible with non-GNU linkers such as LLD, and the marker 
symbols belong in the linker script. This patchset is a big step in the 
right direction!

> 
>>
>>> and clean up the arm sections.c file. There's still a few symbols remaining --
>>> __secure_start/end, __secure_stack_start/end and __end which can be cleaned up
>>> in a followup series.
>>>
>>> The resulting binary (tested in QEMU v7/v8) had no size differences apart from
>>> the emited sections and object types of those variables. I've also added prints
>>> throughout the U-Boot init sequence. The offsets and delta for 'end - start'
>>> section sizes is unchanged.
>>>
>>> For example on QEMU v8:
>>> $~ ./scripts/bloat-o-meter u-boot u-boot.new
>>> add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
>>> Function                                     old     new   delta
>>> Total: Before=798861, After=798861, chg +0.00%
>>>
>>> $~ readelf -sW u-boot | grep bss_s
>>>      12: 00000000001029b8     0 SECTION LOCAL  DEFAULT   12 .bss_start
>>>    8088: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
>>>    8376: 00000000001029b8     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
>>> $~ readelf -sW u-boot.new | grep bss_s
>>>    8085: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
>>>    8373: 00000000001029b8     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start
>>>
>>> For QEMU v7 the differences are a bit bigger but only affect the variables
>>> placed in the .bss section because that was defined as an OVERLAY in the
>>> existing linker script.
>>> For example:
>>> $~ nm u-boot | grep tftp_prev_block
>>> 000ca0dc ? tftp_prev_block
>>> $~ nm u-boot.new | grep tftp_prev_block
>>> 000e0a5c b tftp_prev_block -----> The symbol is now placed into .bss
>>>
>>> It's worth noting that since the efi regions are affected by the change, booting
>>> with EFI is preferable while testing. Booting the kernel only should be enough
>>> since the efi stub and the kernel proper do request boottime and runtime
>>> services respectively.
>>> Something along the lines of
>>>> virtio scan && load virtio 0 $kernel_addr_r Image && bootefi $kernel_addr_r
>>> will work for QEMU aarch64.
>>>
>>> Tested platforms:
>>> - QEMU aarch64
>>> - Xilinx kv260 kria starter kit & zynq
>>> - QEMU armv7
>>> - STM32MP157C-DK2
>>>
>>> [0] commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
>>>
>>> Ilias Apalodimas (6):
>>>    arm: baltos: remove custom linker script
>>>    arm: clean up v7 and v8 linker scripts for bss_start/end
>>>    arm: fix __efi_runtime_rel_start/end definitions
>>>    arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
>>>    arm: fix __efi_runtime_start/end definitions
>>>    arm: move image_copy_start/end to linker symbols
>>>
>>>   arch/arm/cpu/armv8/u-boot-spl.lds         |  14 +--
>>>   arch/arm/cpu/armv8/u-boot.lds             |  45 ++------
>>>   arch/arm/cpu/u-boot.lds                   |  74 +++----------
>>>   arch/arm/lib/sections.c                   |  10 --
>>>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds  |  22 +---
>>>   arch/arm/mach-zynq/u-boot.lds             |  72 +++---------
>>>   board/qualcomm/dragonboard820c/u-boot.lds |  41 ++-----
>>>   board/vscom/baltos/u-boot.lds             | 128 ----------------------
>>>   include/asm-generic/sections.h            |   3 +
>>>   lib/efi_loader/efi_runtime.c              |   1 +
>>>   10 files changed, 58 insertions(+), 352 deletions(-)
>>>   delete mode 100644 board/vscom/baltos/u-boot.lds
>>>
>>> --
>>> 2.37.2
>>>
