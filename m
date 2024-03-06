Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0ACC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A8487C92;
	Wed,  6 Mar 2024 14:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z5KTfHp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094CF87CAC; Wed,  6 Mar 2024 14:24:10 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AF6879E2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51344bebe2fso3622295e87.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709731445; x=1710336245; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Nul8XAa6V5Bvn9tnjPsL2EhnebyqmnYbh/kGoXIo4c=;
 b=z5KTfHp7b+P01x2M7YEXPwYjsPT94rBfTEpFYo1eO/RJA9/vmjuIcBI5SOvQlJNEbH
 jA9+xMS8QY4vwvnoGbF4o6a9uVRfRRYhfDJL/Wua6U8g8N9+BRtCWop5TYgF5VUhwwuK
 Bi3ZrpSd44GGGGOR8qqDE6ASL+8TMJlYyvvmuOhsiVSY6mVTefB1Ke2XNcs9iUzayqxf
 N3BWEeFO6hapEBC+Y/tRbqcdMn46Ew8I8KL0nB+JMNPJkmks4noBCZ0CpcY89gmMZiIu
 ayiM/C8Aj8syBjbO9x7sKrvqB6LFromymDRIej6WyR1kIm+SM0JzyEpKsVUqU/2lddZV
 LBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709731445; x=1710336245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Nul8XAa6V5Bvn9tnjPsL2EhnebyqmnYbh/kGoXIo4c=;
 b=Yovok5Xt65SEqLo3Zl0G5TXbVrG1tZ+1nvIbb246PwiIA4jT8ElyL3Agm9SIfBO47f
 xs7meYDeVXrk57qjCb+HM3VAi72OzPvdCPAuxFO+QmSWkyr7iBpLJo/DjEDC1Ejwrsc2
 p1LyXtSalzoLy5ka7pXAXV8fUmGvG5Ort+zEZCD0ECoaSAzrlXP7snwLo1yFKbdOeEty
 8b/EdimY7gpvGz7mTgkjiK4yr4UYSo9LI/HAEqEbQDDYCbaLxj7hE+sen3xd3ndZGM0w
 D4olTCTDpX0QWZjP+GxEMymn1oTBKQml+e+yJQ+BvMSmafNHWHQHKeb/2hvo0jgcALL9
 FHzg==
X-Gm-Message-State: AOJu0YyargTc4Q0duui+EbxkAWRulG4q+NBTw3+G0FmBlx2xt5ELHIey
 aMuu5HgFw9Uct0pfQmkd8ANe4hv1gH65wlobKMvQqjGuay0nmHQVtWu1clf8qrFAKLYVEQzHVhq
 RRzFz74JfHu06sw4xcdzc6mZzQskFD3IxXYSSfQ==
X-Google-Smtp-Source: AGHT+IGHPL/MW7yrb9GiZ7rNSlkdpr5q640tNgVx+uPAPEBRC4KyIkJQhtOBb2y2f6NTBhk4cL0xe5eQT6tqhDTOrsI=
X-Received: by 2002:a05:6512:aca:b0:513:5978:6919 with SMTP id
 n10-20020a0565120aca00b0051359786919mr2448155lfu.68.1709731444632; Wed, 06
 Mar 2024 05:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
 <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
 <CAC_iWj+RGLq1hsYTA8gWxKiNFgWJMzjsfZ62SE-v8xYm0MZYEw@mail.gmail.com>
 <CAC_iWjJaKWjT0LQoqcwt2p765=H1hsXBsbb5AMNBSPO=nPtpUQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJaKWjT0LQoqcwt2p765=H1hsXBsbb5AMNBSPO=nPtpUQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Mar 2024 15:23:28 +0200
Message-ID: <CAC_iWj+VFtJGxiKwX58ZZxrPgu4vMMrqshWH8RYoGR_9BVen_A@mail.gmail.com>
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

On Wed, 6 Mar 2024 at 12:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 6 Mar 2024 at 11:35, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sam,
> >
> >
> > On Wed, 6 Mar 2024 at 10:22, Sam Edwards <cfsworks@gmail.com> wrote:
> > >
> > > On 3/4/24 02:01, Ilias Apalodimas wrote:
> > > > image_copy_start/end are defined as c variables in order to force t=
he compiler
> > > > emit relative references. However, defining those within a section =
definition
> > > > will do the same thing.
> > > >
> > > > So let's remove the special sections from the linker scripts, the
> > > > variable definitions from sections.c and define them as a symbols w=
ithin
> > > > a section.
> > > >
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
> > >
> > > Since the __image_copy_* symbols are marking boundaries in the whole
> > > image as opposed to a single section, I'd find it clearer if they wer=
e
> > > loose in the SECTIONS { ... } block, so as not to imply that they are
> > > coupled to any particular section. Thoughts?
> >
> > The reason I included it within a section is my understanding of the
> > ld (way older) manual [0].
> > Copy-pasting from that:
> >
> > " Assignment statements may appear:
> > - as commands in their own right in an ld script; or
> > - as independent statements within a SECTIONS command; or
> > - as part of the contents of a section definition in a SECTIONS command=
.
> > The first two cases are equivalent in effect--both define a symbol
> > with an absolute address. The last case defines a symbol whose address
> > is relative to a particular section."
> > So, since we need relocatable entries, I included it within a section.
> >
> > Looking at the latest ld [1] the wording has changed a bit it says
> > "Expressions appearing outside an output section definition treat all
> > numbers as absolute addresses" and it also has the following example
> > SECTIONS
> >   {
> >     . =3D 0x100;
> >     __executable_start =3D 0x100;
> >     .data :
> >     {
> >       . =3D 0x10;
> >       __data_start =3D 0x10;
> >       *(.data)
> >     }
> >     =E2=80=A6
> >   }
> > both . and __executable_start are set to the absolute address 0x100 in
> > the first two assignments, then both . and __data_start are set to
> > 0x10 relative to the .data section in the second two assignments.
> > So I assume the same behavior persists?
>
> I just tested moving image_binary_end outside the section definition
> and it's still emitted properly. I'll try to figure this out and on v3
> I'll move both image_copy_start/end outside the sections.
> I also noticed that I forgot to change
> arch/arm/cpu/armv8/u-boot-spl.lds and get rid of the .image_copy_end.

Reading the manual again, the symbols will be emitted as relocatable
entries regardless of their placement after that LD bug you mentioned
is fixed.
The only thing that will change when moving it outside the section
definition is that an absolute value will be set, instead of a
relative one to the start of the section. But that won't change the
final binary placement in our case.

I played around a bit and removed the .image_copy_end section from the
SPL in favor of a symbol.
Compiling for xilinx_zynqmp_kria_defconfig which builds u-boot & SPL
(note that I am building natively on an arm64 box)

# Before -- image_copy_end is .efi_runtime_rel and spl still has a
section for .image_copy_end
$:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
  9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_copy_end
 10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_sta=
rt
$:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
     5: 00000000fffe0dc8     0 SECTION LOCAL  DEFAULT    5 .image_copy_end
  1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_sta=
rt

# After -- image_copy_end moved outside .efi_runtime_rel and
.image_copy_end  converted to a linker symbol
$:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
  9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_copy_end
 10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_sta=
rt
$:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
  1349: 00000000fffe0dc8     0 NOTYPE  GLOBAL DEFAULT    4 __image_copy_end
  1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_sta=
rt

Nothing changes in offsets and sizes.

The only thing I won't do right now is move image_copy_start outside
the text region since that accounts for the CONFIG_SPL_TEXT_BASE and
CONFIG_SYS_LOAD_ADDR. Keeping the __image_copy_start in there has an
obvious caveat -- __image_copy_start will end up in .text and
__image_copy_end in .rodata, but since we always had that it's fine
for now.

Thanks
/Ilias






>
> Thanks
> /Ilias
>
>
> >
> > [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC1=
3
> > [1] https://sourceware.org/binutils/docs/ld/Expression-Section.html
> >
> > Thanks
> > /Ilias
> >
> >
> > >
> > > Thanks for the cleanup,
> > > Sam
> > >
> > > > ---
> > > >   arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
> > > >   arch/arm/cpu/u-boot.lds                  | 10 ++--------
> > > >   arch/arm/lib/sections.c                  |  2 --
> > > >   arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
> > > >   arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
> > > >   5 files changed, 8 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-b=
oot.lds
> > > > index e737de761a9d..340acf5c043b 100644
> > > > --- a/arch/arm/cpu/armv8/u-boot.lds
> > > > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > > > @@ -23,7 +23,7 @@ SECTIONS
> > > >       . =3D ALIGN(8);
> > > >       .text :
> > > >       {
> > > > -             *(.__image_copy_start)
> > > > +             __image_copy_start =3D .;
> > > >               CPUDIR/start.o (.text*)
> > > >       }
> > > >
> > > > @@ -120,13 +120,7 @@ SECTIONS
> > > >               *(.rel*.efi_runtime)
> > > >               *(.rel*.efi_runtime.*)
> > > >                   __efi_runtime_rel_stop =3D .;
> > > > -     }
> > > > -
> > > > -     . =3D ALIGN(8);
> > > > -
> > > > -     .image_copy_end :
> > > > -     {
> > > > -             *(.__image_copy_end)
> > > > +             __image_copy_end =3D .;
> > > >       }
> > > >
> > > >       .rela.dyn ALIGN(8) : {
> > > > diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > > > index df55bb716e35..7c4f9c2d4dd3 100644
> > > > --- a/arch/arm/cpu/u-boot.lds
> > > > +++ b/arch/arm/cpu/u-boot.lds
> > > > @@ -37,7 +37,7 @@ SECTIONS
> > > >       . =3D ALIGN(4);
> > > >       .text :
> > > >       {
> > > > -             *(.__image_copy_start)
> > > > +             __image_copy_start =3D .;
> > > >               *(.vectors)
> > > >               CPUDIR/start.o (.text*)
> > > >       }
> > > > @@ -151,13 +151,7 @@ SECTIONS
> > > >               *(.rel*.efi_runtime)
> > > >               *(.rel*.efi_runtime.*)
> > > >               __efi_runtime_rel_stop =3D .;
> > > > -     }
> > > > -
> > > > -     . =3D ALIGN(4);
> > > > -
> > > > -     .image_copy_end :
> > > > -     {
> > > > -             *(.__image_copy_end)
> > > > +             __image_copy_end =3D .;
> > > >       }
> > > >
> > > >       .rel.dyn ALIGN(4) : {
> > > > diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > > > index a4d4202e99f5..db5463b2bbbc 100644
> > > > --- a/arch/arm/lib/sections.c
> > > > +++ b/arch/arm/lib/sections.c
> > > > @@ -19,8 +19,6 @@
> > > >    * aliasing warnings.
> > > >    */
> > > >
> > > > -char __image_copy_start[0] __section(".__image_copy_start");
> > > > -char __image_copy_end[0] __section(".__image_copy_end");
> > > >   char __secure_start[0] __section(".__secure_start");
> > > >   char __secure_end[0] __section(".__secure_end");
> > > >   char __secure_stack_start[0] __section(".__secure_stack_start");
> > > > diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/ma=
ch-rockchip/u-boot-tpl-v8.lds
> > > > index b7887194026e..4b480ebb0c4d 100644
> > > > --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > > > +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > > > @@ -24,7 +24,7 @@ SECTIONS
> > > >
> > > >       .text : {
> > > >               . =3D ALIGN(8);
> > > > -             *(.__image_copy_start)
> > > > +             __image_copy_start =3D .;
> > > >               CPUDIR/start.o (.text*)
> > > >               *(.text*)
> > > >       }
> > > > @@ -42,11 +42,7 @@ SECTIONS
> > > >       __u_boot_list : {
> > > >               . =3D ALIGN(8);
> > > >               KEEP(*(SORT(__u_boot_list*)));
> > > > -     }
> > > > -
> > > > -     .image_copy_end : {
> > > > -             . =3D ALIGN(8);
> > > > -             *(.__image_copy_end)
> > > > +             __image_copy_end =3D .;
> > > >       }
> > > >
> > > >       .end : {
> > > > diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-b=
oot.lds
> > > > index fcd0f42a7106..553bcf182272 100644
> > > > --- a/arch/arm/mach-zynq/u-boot.lds
> > > > +++ b/arch/arm/mach-zynq/u-boot.lds
> > > > @@ -16,7 +16,7 @@ SECTIONS
> > > >       . =3D ALIGN(4);
> > > >       .text :
> > > >       {
> > > > -             *(.__image_copy_start)
> > > > +             __image_copy_start =3D .;
> > > >               *(.vectors)
> > > >               CPUDIR/start.o (.text*)
> > > >       }
> > > > @@ -57,12 +57,7 @@ SECTIONS
> > > >               *(.rel*.efi_runtime)
> > > >               *(.rel*.efi_runtime.*)
> > > >               __efi_runtime_rel_stop =3D .;
> > > > -     }
> > > > -
> > > > -     . =3D ALIGN(8);
> > > > -     .image_copy_end :
> > > > -     {
> > > > -             *(.__image_copy_end)
> > > > +             __image_copy_end =3D .;
> > > >       }
> > > >
> > > >       .rel.dyn ALIGN(8) : {
