Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93527C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 06:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8EF87B7C;
	Thu,  7 Mar 2024 07:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DwwuBQks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3D687E14; Thu,  7 Mar 2024 07:56:15 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36C087B7C
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 07:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5131c0691feso709274e87.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 22:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709794567; x=1710399367; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMN77M82Fo9oFtarD7Cp+RT162RPkbu5AQRbDoMz85Y=;
 b=DwwuBQksx6pRcGwhya27nbLl5PtiKZ7+FFwPTgLObnBfiiXAnL1eED/+rHLJOLnnnl
 0giOkohlbgf8LvbXOy6rp1XwMnzXQ8a6XzSx0zLH+6Mwe+VrOTpxCm/SAn0mlfz/qkvY
 21A7GAOyS2nBR6gSIY02q6/bRGTT8d13GJ0u853ROB2V5p+/CcSFpksZm9Or6YjITXwm
 kOnzy7FwCiuy8JrfD2GGANQyka3B5t4xEP/vCMgH0yQ/cbPTD+/rWPcD4UdJbim5BGyI
 NDiuRI+ouERfZHQMuY6MUM2OuOaMlIVqxDCvgXZyZYuVlHASh52NvHcG3F2N9c/OfR6s
 1uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709794567; x=1710399367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMN77M82Fo9oFtarD7Cp+RT162RPkbu5AQRbDoMz85Y=;
 b=LCYWOL532PRBGM5w2RFWvsMpn8kTsxwpLGP6F5YbBadSkzs6bikHu2bD28W5T98Nqz
 gim5MyZSHHAzZ3Ayjt3XO/YTkyMFQF2shW6C51AsaGDWr05/itrFF6cvy/eSmnZO20p4
 aQavKcAoxyCu5mlvlnWrtrWP1aBqnpjY3t6nttcLLs0PzGNcpMRHWa9EsE9miw3yq2Gk
 7YoP3RXn+O8TCRUjQTyVY00W+PTinbl+K4uQH7i/2lZmR7/IpkBBqLACiUFunSEJRo8R
 lDp7cwTwEJ9M5cJy6AqRFFOiIphs4pzqIDVpgHfB7JP87Xww/lC0cSDYMzUy4Wdz/5kt
 Sycg==
X-Gm-Message-State: AOJu0YyOXIFqntDooKG1OKt3vbQQOqFEbC5OwUlHVa+mzj6dl/SAZEVZ
 A03uEQZQohons66l48hBqTAZ3DOiUGDpceeO616RA7/AwcZfVkCNhkoauh5RILpkCdyphFg4fhQ
 tv3YupuBaqEf/c1/z5nxjq/shBeDpscvlnQjv4Q==
X-Google-Smtp-Source: AGHT+IFsOFS6AgZ8evmN/wUQAxIWrg6b+x8FjlZn8PJ7xzGVV9+AV6uzvpdfR0H7FTL9o1jQAxqOvVEgrr1tOIo9nAw=
X-Received: by 2002:ac2:4e93:0:b0:513:5758:499c with SMTP id
 o19-20020ac24e93000000b005135758499cmr599145lfr.63.1709794567067; Wed, 06 Mar
 2024 22:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
 <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
 <CAC_iWj+RGLq1hsYTA8gWxKiNFgWJMzjsfZ62SE-v8xYm0MZYEw@mail.gmail.com>
 <CAC_iWjJaKWjT0LQoqcwt2p765=H1hsXBsbb5AMNBSPO=nPtpUQ@mail.gmail.com>
 <CAC_iWj+VFtJGxiKwX58ZZxrPgu4vMMrqshWH8RYoGR_9BVen_A@mail.gmail.com>
 <b1e34692-5d67-48cd-a895-c18fd6c034fc@gmail.com>
In-Reply-To: <b1e34692-5d67-48cd-a895-c18fd6c034fc@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Mar 2024 08:55:31 +0200
Message-ID: <CAC_iWj+0HMRJ1GkiqiLXLXKcLZvmX+viBShzw_SAJwo=L4Cbww@mail.gmail.com>
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

On Thu, 7 Mar 2024 at 01:08, Sam Edwards <cfsworks@gmail.com> wrote:
>
>
>
> On 3/6/24 06:23, Ilias Apalodimas wrote:
> > On Wed, 6 Mar 2024 at 12:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> On Wed, 6 Mar 2024 at 11:35, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >>>
> >>> Hi Sam,
> >>>
> >>>
> >>> On Wed, 6 Mar 2024 at 10:22, Sam Edwards <cfsworks@gmail.com> wrote:
> >>>>
> >>>> On 3/4/24 02:01, Ilias Apalodimas wrote:
> >>>>> image_copy_start/end are defined as c variables in order to force t=
he compiler
> >>>>> emit relative references. However, defining those within a section =
definition
> >>>>> will do the same thing.
> >>>>>
> >>>>> So let's remove the special sections from the linker scripts, the
> >>>>> variable definitions from sections.c and define them as a symbols w=
ithin
> >>>>> a section.
> >>>>>
> >>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identica=
l
> >>>>
> >>>> Since the __image_copy_* symbols are marking boundaries in the whole
> >>>> image as opposed to a single section, I'd find it clearer if they we=
re
> >>>> loose in the SECTIONS { ... } block, so as not to imply that they ar=
e
> >>>> coupled to any particular section. Thoughts?
> >>>
> >>> The reason I included it within a section is my understanding of the
> >>> ld (way older) manual [0].
> >>> Copy-pasting from that:
> >>>
> >>> " Assignment statements may appear:
> >>> - as commands in their own right in an ld script; or
> >>> - as independent statements within a SECTIONS command; or
> >>> - as part of the contents of a section definition in a SECTIONS comma=
nd.
> >>> The first two cases are equivalent in effect--both define a symbol
> >>> with an absolute address. The last case defines a symbol whose addres=
s
> >>> is relative to a particular section."
> >>> So, since we need relocatable entries, I included it within a section=
.
> >>>
> >>> Looking at the latest ld [1] the wording has changed a bit it says
> >>> "Expressions appearing outside an output section definition treat all
> >>> numbers as absolute addresses" and it also has the following example
> >>> SECTIONS
> >>>    {
> >>>      . =3D 0x100;
> >>>      __executable_start =3D 0x100;
> >>>      .data :
> >>>      {
> >>>        . =3D 0x10;
> >>>        __data_start =3D 0x10;
> >>>        *(.data)
> >>>      }
> >>>      =E2=80=A6
> >>>    }
> >>> both . and __executable_start are set to the absolute address 0x100 i=
n
> >>> the first two assignments, then both . and __data_start are set to
> >>> 0x10 relative to the .data section in the second two assignments.
> >>> So I assume the same behavior persists?
> >>
> >> I just tested moving image_binary_end outside the section definition
> >> and it's still emitted properly. I'll try to figure this out and on v3
> >> I'll move both image_copy_start/end outside the sections.
> >> I also noticed that I forgot to change
> >> arch/arm/cpu/armv8/u-boot-spl.lds and get rid of the .image_copy_end.
> >
> > Reading the manual again, the symbols will be emitted as relocatable
> > entries regardless of their placement after that LD bug you mentioned
> > is fixed.
> > The only thing that will change when moving it outside the section
> > definition is that an absolute value will be set, instead of a
> > relative one to the start of the section. But that won't change the
> > final binary placement in our case.
>
> As far as I know, the linker is smart enough to understand that *any*
> symbol defined in terms of a memory location (e.g. `.` or
> `_other_symname`, ...) cannot be absolute when linking a PIE. The [1]
> documentation excerpt you cited seems to be saying that the exception to
> this rule is when a linker symbol is assigned to a constant value loose
> in the SECTIONS block -- and that apparently within the context of a
> `.section : {...}`, number literals are treated as offsets from the
> section's beginning, not absolute addresses: so we get relative symbols
> once again. This seems to be what your [0] documentation excerpt is also
> trying to say: "numbers in a section definition are relative to the
> section," not "relative symbols must be assigned in a section definition.=
"


Exactly. I somehow misread that at first and assumed that 'absolute
address' loose in the SECTIONS block also implied absolute
relocations. But that's not the case so we can move it outside the
section definition

>
> >
> > I played around a bit and removed the .image_copy_end section from the
> > SPL in favor of a symbol.
> > Compiling for xilinx_zynqmp_kria_defconfig which builds u-boot & SPL
> > (note that I am building natively on an arm64 box)
> >
> > # Before -- image_copy_end is .efi_runtime_rel and spl still has a
> > section for .image_copy_end
> > $:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
> >    9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_cop=
y_end
> >   10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_cop=
y_start
> > $:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
> >       5: 00000000fffe0dc8     0 SECTION LOCAL  DEFAULT    5 .image_copy=
_end
> >    1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_cop=
y_start
> >
> > # After -- image_copy_end moved outside .efi_runtime_rel and
> > .image_copy_end  converted to a linker symbol
> > $:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
> >    9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_cop=
y_end
> >   10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_cop=
y_start
> > $:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
> >    1349: 00000000fffe0dc8     0 NOTYPE  GLOBAL DEFAULT    4 __image_cop=
y_end
> >    1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_cop=
y_start
> >
> > Nothing changes in offsets and sizes.
> >
> > The only thing I won't do right now is move image_copy_start outside
> > the text region since that accounts for the CONFIG_SPL_TEXT_BASE and
> > CONFIG_SYS_LOAD_ADDR. Keeping the __image_copy_start in there has an
> > obvious caveat -- __image_copy_start will end up in .text and
> > __image_copy_end in .rodata, but since we always had that it's fine
> > for now.
>
> I see what you're saying: the .text address is specified by -Ttext from
> Makefile.spl, so we don't know it in the linker script, and we can't
> rely on a `__image_copy_start =3D .;` assignment right before .text
> because the linker isn't going to place .text contiguously.

Exactly and apart from that that __image_copy_start will probably end
up @ 0x0 instead of the actual start address

>
> For what it's worth, `__image_copy_start =3D ADDR(.text);` *does* work
> (and produces a relative relocation). It might also be preferable to
> call attention to the fact that the .text section's start address is not
> determined/known by the linker script.
>
> Up to you though! I'm fine with either approach, I just want to make
> sure that they're both considered. :)

Ah good point, I completely forgot the ADDR directive. I'll switch to
that since I also think having those loose in the SECTIONS block is
far more intuitive

>
> Cheers,
> Sam
>
> >
> > Thanks
> > /Ilias
> >
> >
> >
> >
> >
> >
> >>
> >> Thanks
> >> /Ilias
> >>
> >>
> >>>
> >>> [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SE=
C13
> >>> [1] https://sourceware.org/binutils/docs/ld/Expression-Section.html
> >>>
> >>> Thanks
> >>> /Ilias
> >>>
> >>>
> >>>>
> >>>> Thanks for the cleanup,
> >>>> Sam
> >>>>
> >>>>> ---
> >>>>>    arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
> >>>>>    arch/arm/cpu/u-boot.lds                  | 10 ++--------
> >>>>>    arch/arm/lib/sections.c                  |  2 --
> >>>>>    arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
> >>>>>    arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
> >>>>>    5 files changed, 8 insertions(+), 31 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-b=
oot.lds
> >>>>> index e737de761a9d..340acf5c043b 100644
> >>>>> --- a/arch/arm/cpu/armv8/u-boot.lds
> >>>>> +++ b/arch/arm/cpu/armv8/u-boot.lds
> >>>>> @@ -23,7 +23,7 @@ SECTIONS
> >>>>>        . =3D ALIGN(8);
> >>>>>        .text :
> >>>>>        {
> >>>>> -             *(.__image_copy_start)
> >>>>> +             __image_copy_start =3D .;
> >>>>>                CPUDIR/start.o (.text*)
> >>>>>        }
> >>>>>
> >>>>> @@ -120,13 +120,7 @@ SECTIONS
> >>>>>                *(.rel*.efi_runtime)
> >>>>>                *(.rel*.efi_runtime.*)
> >>>>>                    __efi_runtime_rel_stop =3D .;
> >>>>> -     }
> >>>>> -
> >>>>> -     . =3D ALIGN(8);
> >>>>> -
> >>>>> -     .image_copy_end :
> >>>>> -     {
> >>>>> -             *(.__image_copy_end)
> >>>>> +             __image_copy_end =3D .;
> >>>>>        }
> >>>>>
> >>>>>        .rela.dyn ALIGN(8) : {
> >>>>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> >>>>> index df55bb716e35..7c4f9c2d4dd3 100644
> >>>>> --- a/arch/arm/cpu/u-boot.lds
> >>>>> +++ b/arch/arm/cpu/u-boot.lds
> >>>>> @@ -37,7 +37,7 @@ SECTIONS
> >>>>>        . =3D ALIGN(4);
> >>>>>        .text :
> >>>>>        {
> >>>>> -             *(.__image_copy_start)
> >>>>> +             __image_copy_start =3D .;
> >>>>>                *(.vectors)
> >>>>>                CPUDIR/start.o (.text*)
> >>>>>        }
> >>>>> @@ -151,13 +151,7 @@ SECTIONS
> >>>>>                *(.rel*.efi_runtime)
> >>>>>                *(.rel*.efi_runtime.*)
> >>>>>                __efi_runtime_rel_stop =3D .;
> >>>>> -     }
> >>>>> -
> >>>>> -     . =3D ALIGN(4);
> >>>>> -
> >>>>> -     .image_copy_end :
> >>>>> -     {
> >>>>> -             *(.__image_copy_end)
> >>>>> +             __image_copy_end =3D .;
> >>>>>        }
> >>>>>
> >>>>>        .rel.dyn ALIGN(4) : {
> >>>>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> >>>>> index a4d4202e99f5..db5463b2bbbc 100644
> >>>>> --- a/arch/arm/lib/sections.c
> >>>>> +++ b/arch/arm/lib/sections.c
> >>>>> @@ -19,8 +19,6 @@
> >>>>>     * aliasing warnings.
> >>>>>     */
> >>>>>
> >>>>> -char __image_copy_start[0] __section(".__image_copy_start");
> >>>>> -char __image_copy_end[0] __section(".__image_copy_end");
> >>>>>    char __secure_start[0] __section(".__secure_start");
> >>>>>    char __secure_end[0] __section(".__secure_end");
> >>>>>    char __secure_stack_start[0] __section(".__secure_stack_start");
> >>>>> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/ma=
ch-rockchip/u-boot-tpl-v8.lds
> >>>>> index b7887194026e..4b480ebb0c4d 100644
> >>>>> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> >>>>> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> >>>>> @@ -24,7 +24,7 @@ SECTIONS
> >>>>>
> >>>>>        .text : {
> >>>>>                . =3D ALIGN(8);
> >>>>> -             *(.__image_copy_start)
> >>>>> +             __image_copy_start =3D .;
> >>>>>                CPUDIR/start.o (.text*)
> >>>>>                *(.text*)
> >>>>>        }
> >>>>> @@ -42,11 +42,7 @@ SECTIONS
> >>>>>        __u_boot_list : {
> >>>>>                . =3D ALIGN(8);
> >>>>>                KEEP(*(SORT(__u_boot_list*)));
> >>>>> -     }
> >>>>> -
> >>>>> -     .image_copy_end : {
> >>>>> -             . =3D ALIGN(8);
> >>>>> -             *(.__image_copy_end)
> >>>>> +             __image_copy_end =3D .;
> >>>>>        }
> >>>>>
> >>>>>        .end : {
> >>>>> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-b=
oot.lds
> >>>>> index fcd0f42a7106..553bcf182272 100644
> >>>>> --- a/arch/arm/mach-zynq/u-boot.lds
> >>>>> +++ b/arch/arm/mach-zynq/u-boot.lds
> >>>>> @@ -16,7 +16,7 @@ SECTIONS
> >>>>>        . =3D ALIGN(4);
> >>>>>        .text :
> >>>>>        {
> >>>>> -             *(.__image_copy_start)
> >>>>> +             __image_copy_start =3D .;
> >>>>>                *(.vectors)
> >>>>>                CPUDIR/start.o (.text*)
> >>>>>        }
> >>>>> @@ -57,12 +57,7 @@ SECTIONS
> >>>>>                *(.rel*.efi_runtime)
> >>>>>                *(.rel*.efi_runtime.*)
> >>>>>                __efi_runtime_rel_stop =3D .;
> >>>>> -     }
> >>>>> -
> >>>>> -     . =3D ALIGN(8);
> >>>>> -     .image_copy_end :
> >>>>> -     {
> >>>>> -             *(.__image_copy_end)
> >>>>> +             __image_copy_end =3D .;
> >>>>>        }
> >>>>>
> >>>>>        .rel.dyn ALIGN(8) : {
