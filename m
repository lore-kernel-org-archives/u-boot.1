Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9448BC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F604801BE;
	Thu, 20 Feb 2025 14:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HxWI+xcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5428F801DE; Thu, 20 Feb 2025 14:57:40 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4BF8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so1446689a12.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740059856; x=1740664656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Jh++Wxkae6MrGabdq5j7i0fXHnjWEPpTwXGHP3Mumw=;
 b=HxWI+xcHrjsFIWVjRq2yhwnZJuNq0aeWRkDtRbSjq2z8ZqoZ0uSkLr+gYDisB8iQ6T
 1f94bfuHLD35TsalDn0Y6oZIoCp2li7zU7uHVaNyx52aq/UQSeBq12qq4DPSC9kRrI1j
 eZErz4h1yu1MCmVNnqNNx2ul23ZhlZvOw2ge4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059856; x=1740664656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Jh++Wxkae6MrGabdq5j7i0fXHnjWEPpTwXGHP3Mumw=;
 b=ZQP5ooBF9rrO0GzIa3naEWmb0XZu4h1d94P127AzPrf7Y4HH0rS99Sb30ejFccXGtf
 QbG1m4W1RTnwS4vr783eozN5Or2ePNCMVpTxZZR1AkwyWChPDhjdIFfCdMOlwZ4lR4Hv
 yWY7RbSJwnT49jWzl5QZlZlkL2qv1sd5QatAz6Atp6Mr+xXtvqXXmixKdWIR89Td5Iz8
 tkOzyDuUKC/cEAd9fvrFb56VcnviEo7B/F45TJYRdBFvkMYs2ohnTZUA2k0A5WLDlOgg
 jHrMQ0oxgEf4kmE6c12yUSKnmNf64dhp80elVZ0544pZz4mdBopMba4hJSue5ZEyTplg
 9fxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnxEizBnMksdZ8+8DgOwTcXnIovcz1WQE+yOIzIF0zD4QFYoYPItVs5EMRnqQNAVx1YQNHY+Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yy42lX0nS4bxv3XSpWudlLlRiZNle8jn23jQtzkjdI+wueNCrwy
 tAR3lyFgDpZ/Ovf1M+O7mFB61Iz+jObW6Vexh3I2KS4Gu7SCxZUN6VVsosjrA3ueafFG2PAzxSU
 RcTfkNTipuNK2Kk8eCO5n42dVnwJc8ndhIJwFsrkgf+jTffefqw==
X-Gm-Gg: ASbGncsfNT9qZ5QOUSH5nt1PhhdjV1MHBylsXDLI3Bcf0qNvrhGHVJE03JdHwXQ4qFP
 550YPPhkDUOqMLwN/wSBRRWUppvpocX8xzSgBpQqmxFhBX9FaKDq/xLSsugWV7kcdErO3NrykcA
 ==
X-Google-Smtp-Source: AGHT+IFMv1vcjq7Yuyb4/0Umlr+7Vy0VTaU+f3aQ/Oa84FRW0Y1kHJufuEfh081hxoY+1+OIeY28rTob5793nHstrAw=
X-Received: by 2002:a17:907:1c9f:b0:ab6:fee1:60e0 with SMTP id
 a640c23a62f3a-abbcc95ffd1mr917778666b.0.1740059854990; Thu, 20 Feb 2025
 05:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
 <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
 <91b3d701-b624-4c32-a17d-72099e8a71d0@gmx.de>
In-Reply-To: <91b3d701-b624-4c32-a17d-72099e8a71d0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 06:57:21 -0700
X-Gm-Features: AWEUYZlD8x9AGIPh8qpo97iuik6lyBcCzJ3ta0qPaSX6GarhAxshh_QxGb7OBss
Message-ID: <CAFLszTiXZi4qWzE2Yrz1G+uTxrS9KUUPfPpofZ27GnT6SWOtuA@mail.gmail.com>
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Pawel Kochanowski <pkochanowski@sii.pl>, u-boot@lists.denx.de, 
 Gabriel Nesteruk <gnesteruk@sii.pl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Thu, 20 Feb 2025 at 06:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 20.02.25 14:31, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 20 Feb 2025 at 01:21, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 2/20/25 07:58, Ilias Apalodimas wrote:
> >>> On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> wrote:
> >>>>
> >>>> From: Gabriel Nesteruk <gnesteruk@sii.pl>
> >>>>
> >>>> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> >>>> in `copy_fdt()`, which may not be sufficient if additional nodes
> >>>> (such as FMAN firmware) are added later.
> >>>>
> >>>> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
> >>>> to allow users to define the amount of extra space reserved for FDT
> >>>> expansion. The default remains 0x3000.
> >>>>
> >>>> This change prevents potential corruption when resizing FDT after
> >>>> EFI boot, especially when firmware like FMAN requires additional
> >>>> space.
> >>>>
> >>>> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> >>>> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> >>>> ---
> >>>>    lib/efi_loader/Kconfig      | 9 +++++++++
> >>>>    lib/efi_loader/efi_helper.c | 2 +-
> >>>>    2 files changed, 10 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>>> index d4f6b56afaa..bd2cbe995c9 100644
> >>>> --- a/lib/efi_loader/Kconfig
> >>>> +++ b/lib/efi_loader/Kconfig
> >>>> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
> >>>>             No additional space will be required in the resulting U-Boot binary
> >>>>             when this option is enabled.
> >>>>
> >>>> +config EFI_FDT_EXTRA_SPACE
> >>>> +    hex "Extra space to allocate for FDT expansion"
> >>
> >> Hello Pawel,
> >>
> >> Is this problem really EFI specific? Wouldn't you have a similar problem
> >> when booting via booti?
> >>
> >>>> +    default 0x3000
> >>>> +    help
> >>>> +      Defines additional space (in bytes) reserved for expanding the
> >>>> +      Flattened Device Tree (FDT) when passed to the EFI system.
> >>>> +      Increase this value if your firmware (e.g., FMAN) needs to add
> >>>> +      more data to the device tree after U-Boot relocation.
> >>>> +
> >>>>    endif
> >>>>
> >>>>    source "lib/efi/Kconfig"
> >>>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> >>>> index 04b2efc4a3b..91b2a5b8653 100644
> >>>> --- a/lib/efi_loader/efi_helper.c
> >>>> +++ b/lib/efi_loader/efi_helper.c
> >>>> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
> >>>>            * needs to be expanded later.
> >>>>            */
> >>>>           fdt = *fdtp;
> >>>> -       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> >>>> +       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI_FDT_EXTRA_SPACE);
> >>
> >> This is not the only place where the configuration value needs to be
> >> considered:
> >>
> >> lib/efi_loader/efi_dt_fixup.c:171:
> >>                                 0x3000;
> >>
> >> Could you, please, send a new revision of your patch.
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>>           fdt_size = fdt_pages << EFI_PAGE_SHIFT;
> >>>>
> >>>>           ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>
> >
> > Let's do this instead, as it is generic:
> >
> > https://lore.kernel.org/u-boot/20241206131113.2865416-3-sjg@chromium.org/
> >
> > I believe the copy_fdt() function can just be removed, as the FDT is
> > already in reserved memory. Putting it in the ACPI_RECLAIM region is
> > wrong, too, as it is not an ACPI region.
>
> Hello Simon,
>
> UEFI specification 2.11:
>
> 4.6.1.3 Devicetree Tables
> The DTB must be contained in memory of type EfiACPIReclaimMemory.
>
> EBBR:
>
> The DTB must be contained in memory of type `EfiACPIReclaimMemory`.
> https://github.com/ARM-software/ebbr/blob/75112a58a5eacdfee758ce1b93ef3692b225fc36/source/chapter2-uefi.rst?plain=1#L396

Ah, I see, thanks. Confusing.

>
> We need the copy as the original device-tree which may be at
> $fdtcontroladdr will not have the required space for expansion.

That's the subject of the patch I linked.

It would be nice if EFI could use common code to update the FDT *e.g.
image_setup_linux()), then copy it into the new 'ACPI' region after
that.

Regards,
Simon
