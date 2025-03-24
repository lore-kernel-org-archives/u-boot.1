Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C88C3600C
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D0B805C3;
	Mon, 24 Mar 2025 18:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bVjvsHQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACF0810E8; Mon, 24 Mar 2025 18:21:06 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2609F800C1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso50304805e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742836862; x=1743441662;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ziH7egsmUVwb4bGMppR+yAvGTk3X0TR6pk27g8ocg8Q=;
 b=bVjvsHQGz6b1UyLcRWd39bcGwnQercgwAUqjG8X76VORAAVQ2910QKxC495QviQbf0
 CXORFAX5nfIY2jW0wTX//aOsGfOWfjNlsVK+TadN7l36os/LQOUmS+xlAkC041iQkpRr
 ReDlfB9K12PcZtU4fE1v/Ho0DZgdk9of1MLfYH2/czKKJ1p0+jlQQROyJruSaW0XgexR
 BRdP1URCinL4R8QMHdB4/1TM3tFUuMTpCrFkez9QJsKpOczRIzDJQH41KX8bZ+MytQvw
 tSGFvjRIuDFqQyYujxMet09LF8zXK9XEJw35QLfAgPz1PexeBodDtoh7Uza+oNVsoqRz
 Uv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742836862; x=1743441662;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ziH7egsmUVwb4bGMppR+yAvGTk3X0TR6pk27g8ocg8Q=;
 b=eHZnosGuKYUPasAa1yyAC6cpdDK/UO1QoEXYuIeD7a+OW9MECCI0Cx6CVp6Bk6vL95
 avxzmLeGy9KabYVeIdL+FpNMrZkth/jjI5yeLGB5Xo1PSdtxnj0nj+ILtgJ1Uo76mvnZ
 lHOxm80yAvvQbJCIvDTRWQmJGataSklMymzYa6X6KqIFVmCh8Ht6GJYNcesfIrpIPmYQ
 p3RMsPXAqr9aPOiujnNCyexA6uSFvAK3iwfgucfiarkj7+DIFh/9bIG5OciH10MFYS+r
 rK98S9sMFURDMYzDsJYFD+jwyvBALugyf/ssre/N6YvMwvWWDvZOUir3fobI2H58w7L0
 34Qg==
X-Gm-Message-State: AOJu0YwJanVpECfPf7jQx249ItZNqW84/w75q5RvPU4wC2mfdlx2CziG
 gp30QtJQOhNnJ5/A4N8dVNBmAvfnyf1wOgJFerUXWFlbvXX3tzlxfG9oUSt0vgwxKG/bzm0nrMo
 9
X-Gm-Gg: ASbGncvNBd1w4oILesabSKZakI0d3FlqH2k4qgSurFcBohr16tZR/xG6LhhgJga2a5+
 GAsYNI8iIPHU40orAaU8aN25yNZgwP9w7QhJosVdvAiTpLgUpHv5kqyffgwiwBD8PED5keFGZwF
 tIVJvXa3O/mbU5tryLUbJ34heTgDQk9/2My58qLWM9YuspxQMNu9psRGpZ37Vx/pnYM6TSrQP4y
 Q0ptriwseOsIHKp/PDEpYsNJRF2th2U26OmANmK+3dt2eHs2EmV/p4OsmrHGQHxAIvCSkl0e3uF
 D6RGwiKU5Uu9VI7lxqpj/RBD90NHguX/OU80EG/W788oUwGmuaFxCA==
X-Google-Smtp-Source: AGHT+IGdJNLjp0nN24FJvsOwQAMnKC6tCBzYvYqjtf9u+tEA7o5xj+ZitbcnAp/dWfYUcT3P6NtlrA==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-43d50a1d1ebmr110576385e9.22.1742836862435; 
 Mon, 24 Mar 2025 10:21:02 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9e96bsm129023315e9.25.2025.03.24.10.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:21:01 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>, Lukasz
 Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: usb:composite: data abort on second ums launch
In-Reply-To: <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
 <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
Date: Mon, 24 Mar 2025 18:21:01 +0100
Message-ID: <87v7rypcoy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi,

Thank you for the report.

On lun., mars 24, 2025 at 15:03, Marek Vasut <marex@denx.de> wrote:

> On 3/24/25 11:42 AM, Zixun LI wrote:
>> Hi,
>> 
>> I encountered a data abort on the 2nd "ums 0 mmc 0" command on
>> u-boot-at91 2024.07 with sam9x60-curiosity board.
>> 
>> U-Boot> ums 0 mmc 0
>> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
>> CTRL+C - Operation aborted
>> U-Boot> ums 0 mmc 0
>> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
>> data abort
>> pc : [<27f93428>]          lr : [<27ef7e80>]
>> reloc pc : [<23f16428>]    lr : [<23e7ae80>]
>> sp : 27ef4cf0  ip : a5200000     fp : 23f6915c
>> r10: deadbeef  r9 : 27ef7e80     r8 : 27f7d2a0
>> r7 : a5200000  r6 : 00000000     r5 : 00000000  r4 : 27f01668
>> r3 : 00000000  r2 : 00000000     r1 : 27fe1d88  r0 : 27f01668
>> Flags: nzCV  IRQs off  FIQs off  Mode SVC_32 (T)
>> Code: 45ac d017 68c5 4667 (60fd) 60af
>> 
>>  From backtrace the abort happened in fREe_impl(), with some debugging
>> I've localized the abort in fact happened in fsg buffer allocation in
>> fsg_common_init() [1]
>> 
>> It looks like the buffer is not freed on driver unregister since
>> fsg_common_release() is only called if fsg_common_init() met an error.
> Can you reproduce this on u-boot/master too ?

I've tried to reproduce this on master (2025.04-rc4-g244e61fbb7f5) and I
don't reproduce this with the VIM3 board using khadas-vim3_android_ab_defconfig:

U-Boot 2025.04-rc4-g244e61fbb7f5 (Mar 24 2025 - 18:15:36 +0100) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (effective 3.8 GiB)
Core:  407 devices, 36 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... MMC Device -1 not found
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot:  0
=> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
|crq->brequest:0x0
CTRL+C - Operation aborted
=> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
CTRL+C - Operation aborted
=>

I'll try to understand why it's behaving differently between the
sam9x60-curiosity and the vim3.

Thanks,
Mattijs
