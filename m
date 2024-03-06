Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9631C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 09:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A85879E8;
	Wed,  6 Mar 2024 10:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W7TtItKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1A587B41; Wed,  6 Mar 2024 10:35:55 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57DA876A4
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 10:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d28051376eso90888561fa.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709717752; x=1710322552; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mim8mbveTmc8hQsnMj8n2ujqxwuOemqwbyq9gz12iKM=;
 b=W7TtItKkAz4KYrdANY22qqJcCLZr/sK7frPRaCNKp88C7t3slOBzJpuIlW/Hu5ckGS
 59rGtDQB4YO8KBrhHuaTHrOjYPQwlAHrpkYGZZQ/0VyOB2TswHy44xcOC60vnVdN3/Vo
 2cJhAINcXGGdpdC6U+R9B9ka9BR4rGM4Jb23GKONkAol8rZbwKTKrxwQlshBrYyVdmT/
 6mAywNf9QyB6bShCNBeHakYlMihxD3Y4aTqKH4sAZRPhne0qeX10SDnGxe4DtGIdRdH8
 1Oa5o6+Xa92nND1DXBYDBEZcQRlgnFN2EMfMjhyPSODyr1DiRNGjyUpkwiKhzqxe4leJ
 kKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709717752; x=1710322552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mim8mbveTmc8hQsnMj8n2ujqxwuOemqwbyq9gz12iKM=;
 b=KXfVuzVYOi/h2wppTRLuxAUZa8YTJLR3f96P1weJXBwY8VLfx5tO0TPm+UthK/09KD
 nZbwXCLB325pmZhu7rk3R8FRYn8L9fnnIe3knty2BDGbY9x9yqpGibgXLi000WHQLW4k
 vtNfZDrllJE3UzyNXz23De6GXAMiEdnwx33yhdTbA6TbQ9Q0/UwJLhklRsVeU9IFbX57
 MAX4eoklV4OUIG3MaiPH5CGonPOX3URmwTPY43JSrZM+sXqyZFqR51sU/mxyXi2fIIy5
 48P6Mo1CqlfJI5kUtQ8bVwMz2CKES/aehVMxkXdTOJXSV9UZTqYRygrw9mwNW6We6BFw
 WpMw==
X-Gm-Message-State: AOJu0YzIex7BL47HuZlj3x1cne72BCYk8xQpfCX0l18XvacP4egvrPJB
 cV+WaXKBnYTOYSyvO9oOpXOqcdqSfpboYS8/k0yRQTS0rGIQrogRWa6lGynSpBGWwQ05jXnxgVY
 tzOAJ/CbMg40ggczIRRZZbHdS+DNVhr+3SKMz6Q==
X-Google-Smtp-Source: AGHT+IEZ5/Z0CJ1pKeWZqrWcth8apo8QmZhf1O0wR6eJusBjwWNHGxC7nMR7Q40WCKxHgxlHXbdmOsv/fPO5qifUMGo=
X-Received: by 2002:ac2:5193:0:b0:513:5e2f:7bc9 with SMTP id
 u19-20020ac25193000000b005135e2f7bc9mr736307lfi.9.1709717751878; Wed, 06 Mar
 2024 01:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
 <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
In-Reply-To: <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Mar 2024 11:35:15 +0200
Message-ID: <CAC_iWj+RGLq1hsYTA8gWxKiNFgWJMzjsfZ62SE-v8xYm0MZYEw@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm: move image_copy_start/end to linker symbols
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

Hi Sam,


On Wed, 6 Mar 2024 at 10:22, Sam Edwards <cfsworks@gmail.com> wrote:
>
> On 3/4/24 02:01, Ilias Apalodimas wrote:
> > image_copy_start/end are defined as c variables in order to force the c=
ompiler
> > emit relative references. However, defining those within a section defi=
nition
> > will do the same thing.
> >
> > So let's remove the special sections from the linker scripts, the
> > variable definitions from sections.c and define them as a symbols withi=
n
> > a section.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
>
> Since the __image_copy_* symbols are marking boundaries in the whole
> image as opposed to a single section, I'd find it clearer if they were
> loose in the SECTIONS { ... } block, so as not to imply that they are
> coupled to any particular section. Thoughts?

The reason I included it within a section is my understanding of the
ld (way older) manual [0].
Copy-pasting from that:

" Assignment statements may appear:
- as commands in their own right in an ld script; or
- as independent statements within a SECTIONS command; or
- as part of the contents of a section definition in a SECTIONS command.
The first two cases are equivalent in effect--both define a symbol
with an absolute address. The last case defines a symbol whose address
is relative to a particular section."
So, since we need relocatable entries, I included it within a section.

Looking at the latest ld [1] the wording has changed a bit it says
"Expressions appearing outside an output section definition treat all
numbers as absolute addresses" and it also has the following example
SECTIONS
  {
    . =3D 0x100;
    __executable_start =3D 0x100;
    .data :
    {
      . =3D 0x10;
      __data_start =3D 0x10;
      *(.data)
    }
    =E2=80=A6
  }
both . and __executable_start are set to the absolute address 0x100 in
the first two assignments, then both . and __data_start are set to
0x10 relative to the .data section in the second two assignments.
So I assume the same behavior persists?

[0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
[1] https://sourceware.org/binutils/docs/ld/Expression-Section.html

Thanks
/Ilias


>
> Thanks for the cleanup,
> Sam
>
> > ---
> >   arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
> >   arch/arm/cpu/u-boot.lds                  | 10 ++--------
> >   arch/arm/lib/sections.c                  |  2 --
> >   arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
> >   arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
> >   5 files changed, 8 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.=
lds
> > index e737de761a9d..340acf5c043b 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -23,7 +23,7 @@ SECTIONS
> >       . =3D ALIGN(8);
> >       .text :
> >       {
> > -             *(.__image_copy_start)
> > +             __image_copy_start =3D .;
> >               CPUDIR/start.o (.text*)
> >       }
> >
> > @@ -120,13 +120,7 @@ SECTIONS
> >               *(.rel*.efi_runtime)
> >               *(.rel*.efi_runtime.*)
> >                   __efi_runtime_rel_stop =3D .;
> > -     }
> > -
> > -     . =3D ALIGN(8);
> > -
> > -     .image_copy_end :
> > -     {
> > -             *(.__image_copy_end)
> > +             __image_copy_end =3D .;
> >       }
> >
> >       .rela.dyn ALIGN(8) : {
> > diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > index df55bb716e35..7c4f9c2d4dd3 100644
> > --- a/arch/arm/cpu/u-boot.lds
> > +++ b/arch/arm/cpu/u-boot.lds
> > @@ -37,7 +37,7 @@ SECTIONS
> >       . =3D ALIGN(4);
> >       .text :
> >       {
> > -             *(.__image_copy_start)
> > +             __image_copy_start =3D .;
> >               *(.vectors)
> >               CPUDIR/start.o (.text*)
> >       }
> > @@ -151,13 +151,7 @@ SECTIONS
> >               *(.rel*.efi_runtime)
> >               *(.rel*.efi_runtime.*)
> >               __efi_runtime_rel_stop =3D .;
> > -     }
> > -
> > -     . =3D ALIGN(4);
> > -
> > -     .image_copy_end :
> > -     {
> > -             *(.__image_copy_end)
> > +             __image_copy_end =3D .;
> >       }
> >
> >       .rel.dyn ALIGN(4) : {
> > diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > index a4d4202e99f5..db5463b2bbbc 100644
> > --- a/arch/arm/lib/sections.c
> > +++ b/arch/arm/lib/sections.c
> > @@ -19,8 +19,6 @@
> >    * aliasing warnings.
> >    */
> >
> > -char __image_copy_start[0] __section(".__image_copy_start");
> > -char __image_copy_end[0] __section(".__image_copy_end");
> >   char __secure_start[0] __section(".__secure_start");
> >   char __secure_end[0] __section(".__secure_end");
> >   char __secure_stack_start[0] __section(".__secure_stack_start");
> > diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-r=
ockchip/u-boot-tpl-v8.lds
> > index b7887194026e..4b480ebb0c4d 100644
> > --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > @@ -24,7 +24,7 @@ SECTIONS
> >
> >       .text : {
> >               . =3D ALIGN(8);
> > -             *(.__image_copy_start)
> > +             __image_copy_start =3D .;
> >               CPUDIR/start.o (.text*)
> >               *(.text*)
> >       }
> > @@ -42,11 +42,7 @@ SECTIONS
> >       __u_boot_list : {
> >               . =3D ALIGN(8);
> >               KEEP(*(SORT(__u_boot_list*)));
> > -     }
> > -
> > -     .image_copy_end : {
> > -             . =3D ALIGN(8);
> > -             *(.__image_copy_end)
> > +             __image_copy_end =3D .;
> >       }
> >
> >       .end : {
> > diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.=
lds
> > index fcd0f42a7106..553bcf182272 100644
> > --- a/arch/arm/mach-zynq/u-boot.lds
> > +++ b/arch/arm/mach-zynq/u-boot.lds
> > @@ -16,7 +16,7 @@ SECTIONS
> >       . =3D ALIGN(4);
> >       .text :
> >       {
> > -             *(.__image_copy_start)
> > +             __image_copy_start =3D .;
> >               *(.vectors)
> >               CPUDIR/start.o (.text*)
> >       }
> > @@ -57,12 +57,7 @@ SECTIONS
> >               *(.rel*.efi_runtime)
> >               *(.rel*.efi_runtime.*)
> >               __efi_runtime_rel_stop =3D .;
> > -     }
> > -
> > -     . =3D ALIGN(8);
> > -     .image_copy_end :
> > -     {
> > -             *(.__image_copy_end)
> > +             __image_copy_end =3D .;
> >       }
> >
> >       .rel.dyn ALIGN(8) : {
