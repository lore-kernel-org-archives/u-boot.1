Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D1CC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 22:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C62C83390;
	Wed,  9 Jul 2025 00:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DUulJQNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12CD83394; Wed,  9 Jul 2025 00:58:25 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3B883371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 00:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71173646662so45575017b3.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752015502; x=1752620302; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yOmgDtUd7Y9gNXTFkhAz2joBwi6uPsQVF6WkcAQs3Y=;
 b=DUulJQNUTsdA6EFd/NZVEoObavyoThvHategJD8z6jyqPuXlWycZ7hoQHNs46h8p18
 4tEwpJ/+VuToT3DowJgi1tzXvptuj1pmhb9iCf++9GKYNc2cfFQ0Qyync0Z9U7Bek+zK
 mT6+yVcGEXqfkfni/6990qtZYhbskxmtN4GO06bdMiHU9pHP43oMVLDaMqcMTPvZJvTr
 AP8hOWrbXamgTva+WlWg42sPEr46tPuRc106jfWfQyCK9F7ZdH9zi4IzDdPE3m4degO1
 g/PqQDBmdzLBNHvG2jvJSHdoPsLhizybQoDqK4znnY0UtaqjaMPM5DGFR68qTJmuOJre
 mKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752015502; x=1752620302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yOmgDtUd7Y9gNXTFkhAz2joBwi6uPsQVF6WkcAQs3Y=;
 b=UQrGxZA5DJfOpmGuBVpvNCiki27CpLJgwW48UcjXLcJEQtlmJjzQvf3PGKRXR6bYkG
 MC0gkzbH5rejVm8hP5jam/t8UrjBpg1UyUyzqsIesb6TP1m8CkIsojFmjLV0oC2NNgVl
 RoykskfR11AFhIkdS1mX4+HExPBXknkejhptuo2XQAgqfTB5BMpYLT6vDKtsE7kQ2V+x
 JQE+F2jgOGmpH1WBJPD8MuCGtsawfoZrBg31z5sCySoMzR9imjQWEC2Wa1WZwNrrDAXT
 H6rPEhwdZdhKky3uzinwjS4CvzO3rOafnEcdrZXDgeq0v39xRHlKpDfHrSVsq76m9E7/
 mspw==
X-Gm-Message-State: AOJu0YyLE24J5zmftVha3sv/JQHGLNRN+AyqsaF4Q9o+F0yydV3HTPNZ
 UD9A4CJ2sVBN01q1L7rl5QKklql9pUjcGK/diCK5MmaaUxaLjJF0zZG9ABwHpzTsBklImyRjXYe
 Sro7T0514sZr6g+oCeVSsfasqn0vEn3M1ySdN+nui6Q==
X-Gm-Gg: ASbGncs+vcvBM7iz4mWDa6kKWF/Fw353UJfgeu9+xPxrIt8xNvurjXPNQYB/TpP2mIk
 D9othIiJTeQkwmPsn1CiD5dBez7RStSgIGAs6DhHMK5oO8PqWlUMKmsInKmwv4261VAbViRZmdL
 pNNnQzbL9A9/h7PDx/etG3A0cytK/P9JRMM3/ZG+OfJiRncWR1Qd4c2Imxb+ap6ViTJ4To7jjze
 mHZMA==
X-Google-Smtp-Source: AGHT+IH00Y3C5JKVqVfR2yxui+mOzUi8ILhyCe7NS3IcXj13seuo2oK5PBt1mNSfLy+GTgSZDReXJpMJnkh79jYzE54=
X-Received: by 2002:a05:690c:6d07:b0:70e:1474:63f2 with SMTP id
 00721157ae682-717b166b8e3mr7936317b3.7.1752015502133; Tue, 08 Jul 2025
 15:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250529150213.27149-1-richard@nod.at>
 <174976652550.365589.4489095631856636528.b4-ty@konsulko.com>
In-Reply-To: <174976652550.365589.4489095631856636528.b4-ty@konsulko.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 8 Jul 2025 17:58:11 -0500
X-Gm-Features: Ac12FXxuj22E2vcej-ln9CU9C0NPLI0YMPeuIzLpUXGAQEpQRZLHz8820zD9Y-o
Message-ID: <CAPLW+4kSGfyhd_Bxr+cn=PJV1Zvi2Du5+jLSZSxhqBPZ=PvFow@mail.gmail.com>
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
To: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org, 
 tharvey@gateworks.com, ilias.apalodimas@linaro.org, 
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 12, 2025 at 5:15=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, 29 May 2025 17:02:13 +0200, Richard Weinberger wrote:
>
> > Although if we we don't setup an initrd, there could be a stale
> > initrd setting from the previous boot firmware in the live
> > device tree. So, make sure there is no setting left if we
> > don't want an initrd.
> >
> > This can happen when booting on a Raspberry Pi. The boot firmware
> > can happily load an initrd before us and configuring the addresses
> > in the live device tree we get handed over.
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>

This patch introduces regression in case when U-Boot transfers control
to an EFI app which acts as a subsequent bootloading program. Such an
app might try to set "linux,initrd-start" and "linux,initrd-end" fdt
properties, but by that time those properties are already removed by
the code added in this patch.

Particularly, the issue was observed on the E850-96 board where GBL
EFI app [1] can't run Android successfully anymore. More specifically,
the kernel can't see the ramdisk and panics with these messages:

    /dev/root: Can't open blockdev
    VFS: Cannot open root device "" or unknown-block(0,0): error -6
    Please append a correct "root=3D" boot option; here are the
available partitions:
    Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)

fdt_initrd() function (where initrd dts properties are removed) is
called two times:

1. First it's called by EFI boot manager (e.g. as a part of U-Boot
Standard Boot mechanism) when it's installing FDT:

    fdt_initrd
    image_setup_libfdt
    efi_install_fdt
    efi_bootmgr_run
    efi_mgr_boot

It's already enough for EFI app to malfunction. But then it's also
called second time:

2. From the EFI app, via EFI DT fixup protocol:

    fdt_initrd
    image_setup_libfdt
    efi_dt_fixup
    struct efi_dt_fixup_protocol efi_dt_fixup_prot =3D {
        .fixup =3D efi_dt_fixup
    };

See [2] for specific GBL code which sets those fdt properties and then
runs DT fixup protocol callback.

I don't see any way for U-Boot to know if those initrd properties are
going to be set later by other EFI apps or not. So arguably this patch
should be reverted. But I might be missing something and maybe there
are better options to fix that?

Thanks!

[1] https://source.android.com/docs/core/architecture/bootloader/generic-bo=
otloader/gbl-dev
[2] https://android.googlesource.com/platform/bootable/libbootloader/+/refs=
/heads/gbl-mainline/gbl/libgbl/src/android_boot/mod.rs#208

> [1/1] fdt: Make sure there is no stale initrd left
>       commit: 9fe2e4b46458f9c4ec6b8115ebf18b4b26fe6127
> --
> Tom
>
