Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA73C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 16:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9FF8798B;
	Wed, 31 Jan 2024 17:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="kC3mzyvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D02F8799C; Wed, 31 Jan 2024 17:25:38 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A5D87964
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 17:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d057003864so30242161fa.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706718336; x=1707323136; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1AG12KtR6ke4ZjVDEwe5vb3LV65DDly51UW1Kwfdug=;
 b=kC3mzyvKPDSQIdL51X/DEmAy5xY3lKLh4BCBxqj45XRA59tT0amA4j7DWjHdcyscAd
 cDM5vCTdbhgQjiTQHXZ5/ZLpRAFuqGQ1yVAdexG4QayQVH+60DirZzx/pAi+GzrGjhpL
 vryzOXybnXs1iPOKwb2rGE8vzk5P66Olnhh/r67az6iMlFxZUp5bNsVjI0crrEnoP0rL
 SRXlhXKOD3XhPZTJYrg/umuvXUqJhGXldO5cb7LkkoCzGAzkDODzTHqN4srTQUYiX/VU
 CVY65fHJ9Yb6eBgzz1p/Iznp1uEq99IuSO5SOcAKVsNOkUWyNiqrTVFRSY/VUeHZCuJw
 6Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706718336; x=1707323136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1AG12KtR6ke4ZjVDEwe5vb3LV65DDly51UW1Kwfdug=;
 b=foX8eAu2iyNLapsDZSk87VS5x4N3GyVNdAelohGNFTYUCZ01sYabnCYeCYo9bRfOhh
 DPxFRdxVl3FkklfrgmBznuAXohs+kkU1p5W92YJtjQ78Ci6jDnRnJ4cc5jsxP49JtsbK
 D2cmICiK9nK0wpkZ0VszfYZF9u4RcDamuo8OVL4ilg5A+60Kvb9ligwtyclrhgarDAIu
 c9RqwblyACcQNBiOynSMWClCBUQYpM9fX875rdjErlz1oZs+gbk36udrwzkY9AbFlAWM
 DKeX9KztA1fF0+dgtCDS61M4YGPy3UF+/A6s0YwS4xAKNN6DymOEhxKP/CFXNUOqLp0n
 PDiQ==
X-Gm-Message-State: AOJu0Ywzj9njyCkreleo/6ZYzdWWYSC966nw0ovnMGg1WctMtIKNIrdE
 MnN4MwBdT9tLsMV3Ed45NJjOHzxLpfhv17khe6qcfVxVuOE6uFJsndRfJTenZzYvzkK1gH5u1HL
 gXjUJeqsf+A8L3bcpLTRWbbl5btnkIenFDa3XjQ==
X-Google-Smtp-Source: AGHT+IENDJXsrWZTBqykVSvLEaOzCchmGeviQhcvQZe4vhdDKl7mfP7SEUjnbIZuSXlJvfs3a8B7QQmLpmFwC/b2aUw=
X-Received: by 2002:a2e:2c01:0:b0:2d0:4e22:cc99 with SMTP id
 s1-20020a2e2c01000000b002d04e22cc99mr1478091ljs.24.1706718335526; Wed, 31 Jan
 2024 08:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20210211120426.159999-1-igor.opaniuk@gmail.com>
 <0c73452b-96b7-e58d-b1ec-7630dad9e94b@gmx.de>
 <CAMj1kXEcq6pxbFYtKA_ZO8KSx2JHB6oShEyY1XL459UVDyyw1A@mail.gmail.com>
 <986a6edd-b53b-969d-6153-91db9227665c@gmx.de>
 <CAL6CDMFAaaQ7rj5yBJ62ik-i+pJ6=vZAkNzejbDohEMyncJ09w@mail.gmail.com>
In-Reply-To: <CAL6CDMFAaaQ7rj5yBJ62ik-i+pJ6=vZAkNzejbDohEMyncJ09w@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Wed, 31 Jan 2024 17:25:23 +0100
Message-ID: <CAL6CDMFgNh+Ywpz8XFHA6LuJbpJZThVqZa8o_biY6icYnbaGTg@mail.gmail.com>
Subject: Re: [PATCH v1] qemu-arm: round down memory to multiple of 2MB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hello Ard,

Just a quick follow-up for this old thread,

I've again stumbled upon the same issue recently and it turned out
that I've already sent a fix for that here :)

Considering Heinrich's comment about memory granularity, does it still make
sense to land this patch? If not, what objections/suggestions do you
have in mind?

Thanks!

Regards,
Igor

On Thu, Feb 11, 2021 at 4:39=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundrie=
s.io> wrote:
>
> Hi Heinrich,
>
> On Thu, Feb 11, 2021 at 5:34 PM Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> >
> > On 11.02.21 15:56, Ard Biesheuvel wrote:
> > > On Thu, 11 Feb 2021 at 15:18, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > >>
> > >> On 11.02.21 13:04, Igor Opaniuk wrote:
> > >>> From: Igor Opaniuk <igor.opaniuk@foundries.io>
> > >>>
> > >>> When LPAE is enabled, 1:1 mapping is created using 2 MB blocks.
> > >>> In case amount of memory provided to QEMU is not multiple
> > >>> of 2 MB, round down the amount of available memory to avoid hang
> > >>> during MMU initialization.
> > >>>
> > >>> How to reproduce:
> > >>> qemu-system-arm -machine virt -m 1058 -nographic -bios u-boot.bin -=
 boots
> > >>> qemu-system-arm -machine virt -m 1057 -nographic -bios u-boot.bin -=
 hangs
> > >>>
> > >>> DRAM:  1 GiB
> > >>> initcall: 60011df8
> > >>> initcall: 60011904
> > >>> New Stack Pointer is: 80fffe90
> > >>> initcall: 60011a20
> > >>> initcall: 60011bcc
> > >>> initcall: 60011bd4
> > >>> initcall: 600119b4
> > >>> Relocation Offset is: 22042000
> > >>> Relocating to 82042000, new gd at 81001ed0, sp at 80fffe90
> > >>> initcall: 60011b8c
> > >>> initcall: 82053ea0
> > >>> initcall: 82053ea8
> > >>> initcall: 60012040 (relocated to 82054040)
> > >>> dram_bank_mmu_setup: bank: 0
> > >>> --- hang here during mmu init ---
> > >>>
> > >>> Fixes: 3fa914af82("arm: qemu: implement enable_caches()")
> > >>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> > >>>
> > >>> ---
> > >>>
> > >>>  board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++++
> > >>>  1 file changed, 12 insertions(+)
> > >>>
> > >>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/=
qemu-arm/qemu-arm.c
> > >>> index aa68bef469..841dd7af0e 100644
> > >>> --- a/board/emulation/qemu-arm/qemu-arm.c
> > >>> +++ b/board/emulation/qemu-arm/qemu-arm.c
> > >>> @@ -84,6 +84,18 @@ int dram_init(void)
> > >>>       if (fdtdec_setup_mem_size_base() !=3D 0)
> > >>>               return -EINVAL;
> > >>>
> > >>> +     /*
> > >>> +      * When LPAE is enabled (ARMv7),
> > >>> +      * 1:1 mapping is created using 2 MB blocks.
> > >>> +      *
> > >>> +      * In case amount of memory provided to QEMU
> > >>> +      * is not multiple of 2 MB, round down the amount
> > >>> +      * of available memory to avoid hang during MMU
> > >>> +      * initialization.
> > >>> +      */
> > >>> +     if (CONFIG_IS_ENABLED(ARMV7_LPAE))
> > >>> +             gd->ram_size -=3D (gd->ram_size % 0x200000);
> > >>
> > >> Is the problem LPAE specific?
> > >> Couldn't you provoke same problem using an odd memory size without L=
PAE,
> > >> e.g qemu-system-arm -m 536870908 (512 MiB - 4)?
> > >>
> > >
> > > The above value means 512 GiB - 4 MiB, so that shouldn't be a problem=
.
> > > I don't think QEMU's -m option takes fractional megabyte values.
> > >
> >
> > $ qemu-system-arm -machine virt -cpu cortex-a15 -m 100005k \
> > -bios denx/u-boot.bin -nographic
> >
> > =3D> fdt addr $fdt_addr
> > =3D> fdt print /memory@40000000
> > memory@40000000 {
> >         reg =3D <0x00000000 0x40000000 0x00000000 0x061aa000>;
> >         device_type =3D "memory";
> > };
> >
> > Granularity seems to be 0x2000 =3D 8 KiB.
> I've just run some tests (including the mem=3D100005k ) with LPAE disable=
d
> and haven't faced any issues:
>
> $ cat .config | grep LPAE
> # CONFIG_ARMV7_LPAE is not set
>
> $ qemu-system-arm -machine virt -m 1057 -nographic -bios u-boot.bin
> U-Boot 2021.04-rc1-01218-g85e959f09c-dirty (Feb 11 2021 - 17:31:31 +0200)
>
> DRAM:  1 GiB
> Flash: 128 MiB
> ...
> =3D>
>
> $ qemu-system-arm -machine virt -m 1058 -nographic -bios u-boot.bin
>
> U-Boot 2021.04-rc1-01218-g85e959f09c-dirty (Feb 11 2021 - 17:31:31 +0200)
>
> DRAM:  1 GiB
> Flash: 128 MiB
> ...
> =3D>
>
> $ qemu-system-arm -machine virt -m 100005k -nographic -bios u-boot.bin
>
> U-Boot 2021.04-rc1-01218-g85e959f09c-dirty (Feb 11 2021 - 17:31:31 +0200)
> DRAM:  97.7 MiB
> Flash: 128 MiB
> ...
> =3D>
>
> >
> > Best regards
> >
> > Heinrich
>
> Regards,
> Igor
>
> --
> Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations
>
> Igor Opaniuk
> Embedded Software Engineer
> T:  +380 938364067
> E: igor.opaniuk@foundries.io
> W: www.foundries.io



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
