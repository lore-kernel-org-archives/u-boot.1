Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F2C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6804877AF;
	Thu,  7 Mar 2024 17:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YQYWmx0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A90E8785A; Thu,  7 Mar 2024 17:45:47 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0E3875FA
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 17:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d29111272eso16845611fa.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709829942; x=1710434742; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYsWekhHMdvdH4xVtLSnW4II/FvNdPz2qgyl7PVSeog=;
 b=YQYWmx0CYobw+5I7//IUbbHZBu/6ix+UZ88uDiUITol88Tm9z7Q+mA3chNZ5PPfpGj
 ClT6Dzv8kSxfOs/9irHs0DOSiv0b7iG/vhOe3VQcMhtctCFXzV4BEdJ5IGjP563c2D/u
 q2CRVcAOJS5uwceVrQr+zcsu+xpnCNh8N+y7VlvQP/RiKceGh+np6YkG4DhPQ8W1Wjxn
 SFxFWK98nqVpYmMMuRrc8j7S5pa9X/AOg2BjLDKJ00g2rGpKB6QFMQxd/YVkLYrzJTOf
 LcnWrJBt6LuhU5dFoZ07SvBOoXx6J6Oeaw7J1HWcD2ibAZ6R/ef6GKc9QaMjV+NIxpc7
 nmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709829942; x=1710434742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYsWekhHMdvdH4xVtLSnW4II/FvNdPz2qgyl7PVSeog=;
 b=f4/FOLwoNayg7qkQ/fNcIVQRxDTdb3lTltHpko4zuBs349IXypOC4SE2zHnr0y2TJn
 5V4AQtJ7/DKghwlw9G3ECFhqH4lZDdV+rtrx9q6+qDCSbwOd4MH50K9TjQEopNO0jlva
 536OhB1lmlGRGBL2VqSlBbwSq6P0u3fr6gGq6KPOeYoC1U47qNaiV9RUXYPjRRVukkHp
 2M04zWeI0ou7YD6JWHiJJ4OrZrb0QOaokH+9fdnLXohGkv/R673XDKXV0JanAWZMJnA1
 B+ElTopThtsNcWCftXJobPvFUMCZfxQCVeBAVcwxIj6+oR1za1wLCznX3mf+mz4EOGTx
 QZhA==
X-Gm-Message-State: AOJu0YyFrbWd07zhL/BLOhbItPEQYZKEDiE0Q2FftqmrpYOqazQwgaMg
 yOGo7fnBvhhluVGr2qactS95dzoHimE6zPrDt+TeMYTxaJtSTTDqd04G9Jxrvi6eoMKVVb5hTx3
 vpz3UJiilVDL+MbT0566IOVHF6uRCBa3V5gO92g==
X-Google-Smtp-Source: AGHT+IEfXGXJmX+Due1e9fP0SyJ/6dLYJsKcfNzXSK9v8ghvTSXxJNXFnYCY9k96qHWrOcg+NtHLloWgHCSP+cFbVkg=
X-Received: by 2002:a2e:7a0d:0:b0:2d2:edcc:ccc2 with SMTP id
 v13-20020a2e7a0d000000b002d2edccccc2mr1717172ljc.38.1709829941952; Thu, 07
 Mar 2024 08:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
 <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
 <CAC_iWj+RGLq1hsYTA8gWxKiNFgWJMzjsfZ62SE-v8xYm0MZYEw@mail.gmail.com>
 <CAC_iWjJaKWjT0LQoqcwt2p765=H1hsXBsbb5AMNBSPO=nPtpUQ@mail.gmail.com>
 <CAC_iWj+VFtJGxiKwX58ZZxrPgu4vMMrqshWH8RYoGR_9BVen_A@mail.gmail.com>
 <b1e34692-5d67-48cd-a895-c18fd6c034fc@gmail.com>
 <CAC_iWj+0HMRJ1GkiqiLXLXKcLZvmX+viBShzw_SAJwo=L4Cbww@mail.gmail.com>
In-Reply-To: <CAC_iWj+0HMRJ1GkiqiLXLXKcLZvmX+viBShzw_SAJwo=L4Cbww@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Mar 2024 18:45:05 +0200
Message-ID: <CAC_iWjK7qjpoYSCPV7Tf-moaiZOZ5BPnbpF_SOxc3ABSrq00cQ@mail.gmail.com>
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

On Thu, 7 Mar 2024 at 08:55, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 7 Mar 2024 at 01:08, Sam Edwards <cfsworks@gmail.com> wrote:
> >
> >
> >
> > On 3/6/24 06:23, Ilias Apalodimas wrote:
> > > On Wed, 6 Mar 2024 at 12:37, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > >>
> > >> On Wed, 6 Mar 2024 at 11:35, Ilias Apalodimas
> > >> <ilias.apalodimas@linaro.org> wrote:
> > >>>
> > >>> Hi Sam,
> > >>>
> > >>>
> > >>> On Wed, 6 Mar 2024 at 10:22, Sam Edwards <cfsworks@gmail.com> wrote=
:
> > >>>>
> > >>>> On 3/4/24 02:01, Ilias Apalodimas wrote:
> > >>>>> image_copy_start/end are defined as c variables in order to force=
 the compiler
> > >>>>> emit relative references. However, defining those within a sectio=
n definition
> > >>>>> will do the same thing.
> > >>>>>
> > >>>>> So let's remove the special sections from the linker scripts, the
> > >>>>> variable definitions from sections.c and define them as a symbols=
 within
> > >>>>> a section.
> > >>>>>
> > >>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >>>> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identi=
cal
> > >>>>
> > >>>> Since the __image_copy_* symbols are marking boundaries in the who=
le
> > >>>> image as opposed to a single section, I'd find it clearer if they =
were
> > >>>> loose in the SECTIONS { ... } block, so as not to imply that they =
are
> > >>>> coupled to any particular section. Thoughts?
> > >>>
> > >>> The reason I included it within a section is my understanding of th=
e
> > >>> ld (way older) manual [0].
> > >>> Copy-pasting from that:
> > >>>
> > >>> " Assignment statements may appear:
> > >>> - as commands in their own right in an ld script; or
> > >>> - as independent statements within a SECTIONS command; or
> > >>> - as part of the contents of a section definition in a SECTIONS com=
mand.
> > >>> The first two cases are equivalent in effect--both define a symbol
> > >>> with an absolute address. The last case defines a symbol whose addr=
ess
> > >>> is relative to a particular section."
> > >>> So, since we need relocatable entries, I included it within a secti=
on.
> > >>>
> > >>> Looking at the latest ld [1] the wording has changed a bit it says
> > >>> "Expressions appearing outside an output section definition treat a=
ll
> > >>> numbers as absolute addresses" and it also has the following exampl=
e
> > >>> SECTIONS
> > >>>    {
> > >>>      . =3D 0x100;
> > >>>      __executable_start =3D 0x100;
> > >>>      .data :
> > >>>      {
> > >>>        . =3D 0x10;
> > >>>        __data_start =3D 0x10;
> > >>>        *(.data)
> > >>>      }
> > >>>      =E2=80=A6
> > >>>    }
> > >>> both . and __executable_start are set to the absolute address 0x100=
 in
> > >>> the first two assignments, then both . and __data_start are set to
> > >>> 0x10 relative to the .data section in the second two assignments.
> > >>> So I assume the same behavior persists?
> > >>
> > >> I just tested moving image_binary_end outside the section definition
> > >> and it's still emitted properly. I'll try to figure this out and on =
v3
> > >> I'll move both image_copy_start/end outside the sections.
> > >> I also noticed that I forgot to change
> > >> arch/arm/cpu/armv8/u-boot-spl.lds and get rid of the .image_copy_end=
.
> > >
> > > Reading the manual again, the symbols will be emitted as relocatable
> > > entries regardless of their placement after that LD bug you mentioned
> > > is fixed.
> > > The only thing that will change when moving it outside the section
> > > definition is that an absolute value will be set, instead of a
> > > relative one to the start of the section. But that won't change the
> > > final binary placement in our case.
> >
> > As far as I know, the linker is smart enough to understand that *any*
> > symbol defined in terms of a memory location (e.g. `.` or
> > `_other_symname`, ...) cannot be absolute when linking a PIE. The [1]
> > documentation excerpt you cited seems to be saying that the exception t=
o
> > this rule is when a linker symbol is assigned to a constant value loose
> > in the SECTIONS block -- and that apparently within the context of a
> > `.section : {...}`, number literals are treated as offsets from the
> > section's beginning, not absolute addresses: so we get relative symbols
> > once again. This seems to be what your [0] documentation excerpt is als=
o
> > trying to say: "numbers in a section definition are relative to the
> > section," not "relative symbols must be assigned in a section definitio=
n."
>
>
> Exactly. I somehow misread that at first and assumed that 'absolute
> address' loose in the SECTIONS block also implied absolute
> relocations. But that's not the case so we can move it outside the
> section definition
>
> >
> > >
> > > I played around a bit and removed the .image_copy_end section from th=
e
> > > SPL in favor of a symbol.
> > > Compiling for xilinx_zynqmp_kria_defconfig which builds u-boot & SPL
> > > (note that I am building natively on an arm64 box)
> > >
> > > # Before -- image_copy_end is .efi_runtime_rel and spl still has a
> > > section for .image_copy_end
> > > $:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
> > >    9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_c=
opy_end
> > >   10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_c=
opy_start
> > > $:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
> > >       5: 00000000fffe0dc8     0 SECTION LOCAL  DEFAULT    5 .image_co=
py_end
> > >    1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_c=
opy_start
> > >
> > > # After -- image_copy_end moved outside .efi_runtime_rel and
> > > .image_copy_end  converted to a linker symbol
> > > $:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
> > >    9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_c=
opy_end
> > >   10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_c=
opy_start
> > > $:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
> > >    1349: 00000000fffe0dc8     0 NOTYPE  GLOBAL DEFAULT    4 __image_c=
opy_end
> > >    1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_c=
opy_start
> > >
> > > Nothing changes in offsets and sizes.
> > >
> > > The only thing I won't do right now is move image_copy_start outside
> > > the text region since that accounts for the CONFIG_SPL_TEXT_BASE and
> > > CONFIG_SYS_LOAD_ADDR. Keeping the __image_copy_start in there has an
> > > obvious caveat -- __image_copy_start will end up in .text and
> > > __image_copy_end in .rodata, but since we always had that it's fine
> > > for now.
> >
> > I see what you're saying: the .text address is specified by -Ttext from
> > Makefile.spl, so we don't know it in the linker script, and we can't
> > rely on a `__image_copy_start =3D .;` assignment right before .text
> > because the linker isn't going to place .text contiguously.
>
> Exactly and apart from that that __image_copy_start will probably end
> up @ 0x0 instead of the actual start address
>
> >
> > For what it's worth, `__image_copy_start =3D ADDR(.text);` *does* work
> > (and produces a relative relocation). It might also be preferable to
> > call attention to the fact that the .text section's start address is no=
t
> > determined/known by the linker script.
> >
> > Up to you though! I'm fine with either approach, I just want to make
> > sure that they're both considered. :)
>
> Ah good point, I completely forgot the ADDR directive. I'll switch to
> that since I also think having those loose in the SECTIONS block is
> far more intuitive

FWIW, I completely forgot your RFC trying to clean the same mess.
I'll add your Suggested-by on v2

[0] https://lore.kernel.org/u-boot/20230520205547.1009254-11-CFSworks@gmail=
.com/

Cheers
/Ilias
>
> >
> > Cheers,
> > Sam
> >
> > >
> > > Thanks
> > > /Ilias
> > >
> > >
> > >
> > >
> > >
> > >
> > >>
> > >> Thanks
> > >> /Ilias
> > >>
> > >>
> > >>>
> > >>> [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#=
SEC13
> > >>> [1] https://sourceware.org/binutils/docs/ld/Expression-Section.html
> > >>>
> > >>> Thanks
> > >>> /Ilias
> > >>>
> > >>>
> > >>>>
> > >>>> Thanks for the cleanup,
> > >>>> Sam
> > >>>>
> > >>>>> ---
> > >>>>>    arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
> > >>>>>    arch/arm/cpu/u-boot.lds                  | 10 ++--------
> > >>>>>    arch/arm/lib/sections.c                  |  2 --
> > >>>>>    arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
> > >>>>>    arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
> > >>>>>    5 files changed, 8 insertions(+), 31 deletions(-)
> > >>>>>
> > >>>>> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u=
-boot.lds
> > >>>>> index e737de761a9d..340acf5c043b 100644
> > >>>>> --- a/arch/arm/cpu/armv8/u-boot.lds
> > >>>>> +++ b/arch/arm/cpu/armv8/u-boot.lds
> > >>>>> @@ -23,7 +23,7 @@ SECTIONS
> > >>>>>        . =3D ALIGN(8);
> > >>>>>        .text :
> > >>>>>        {
> > >>>>> -             *(.__image_copy_start)
> > >>>>> +             __image_copy_start =3D .;
> > >>>>>                CPUDIR/start.o (.text*)
> > >>>>>        }
> > >>>>>
> > >>>>> @@ -120,13 +120,7 @@ SECTIONS
> > >>>>>                *(.rel*.efi_runtime)
> > >>>>>                *(.rel*.efi_runtime.*)
> > >>>>>                    __efi_runtime_rel_stop =3D .;
> > >>>>> -     }
> > >>>>> -
> > >>>>> -     . =3D ALIGN(8);
> > >>>>> -
> > >>>>> -     .image_copy_end :
> > >>>>> -     {
> > >>>>> -             *(.__image_copy_end)
> > >>>>> +             __image_copy_end =3D .;
> > >>>>>        }
> > >>>>>
> > >>>>>        .rela.dyn ALIGN(8) : {
> > >>>>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > >>>>> index df55bb716e35..7c4f9c2d4dd3 100644
> > >>>>> --- a/arch/arm/cpu/u-boot.lds
> > >>>>> +++ b/arch/arm/cpu/u-boot.lds
> > >>>>> @@ -37,7 +37,7 @@ SECTIONS
> > >>>>>        . =3D ALIGN(4);
> > >>>>>        .text :
> > >>>>>        {
> > >>>>> -             *(.__image_copy_start)
> > >>>>> +             __image_copy_start =3D .;
> > >>>>>                *(.vectors)
> > >>>>>                CPUDIR/start.o (.text*)
> > >>>>>        }
> > >>>>> @@ -151,13 +151,7 @@ SECTIONS
> > >>>>>                *(.rel*.efi_runtime)
> > >>>>>                *(.rel*.efi_runtime.*)
> > >>>>>                __efi_runtime_rel_stop =3D .;
> > >>>>> -     }
> > >>>>> -
> > >>>>> -     . =3D ALIGN(4);
> > >>>>> -
> > >>>>> -     .image_copy_end :
> > >>>>> -     {
> > >>>>> -             *(.__image_copy_end)
> > >>>>> +             __image_copy_end =3D .;
> > >>>>>        }
> > >>>>>
> > >>>>>        .rel.dyn ALIGN(4) : {
> > >>>>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > >>>>> index a4d4202e99f5..db5463b2bbbc 100644
> > >>>>> --- a/arch/arm/lib/sections.c
> > >>>>> +++ b/arch/arm/lib/sections.c
> > >>>>> @@ -19,8 +19,6 @@
> > >>>>>     * aliasing warnings.
> > >>>>>     */
> > >>>>>
> > >>>>> -char __image_copy_start[0] __section(".__image_copy_start");
> > >>>>> -char __image_copy_end[0] __section(".__image_copy_end");
> > >>>>>    char __secure_start[0] __section(".__secure_start");
> > >>>>>    char __secure_end[0] __section(".__secure_end");
> > >>>>>    char __secure_stack_start[0] __section(".__secure_stack_start"=
);
> > >>>>> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/=
mach-rockchip/u-boot-tpl-v8.lds
> > >>>>> index b7887194026e..4b480ebb0c4d 100644
> > >>>>> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > >>>>> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > >>>>> @@ -24,7 +24,7 @@ SECTIONS
> > >>>>>
> > >>>>>        .text : {
> > >>>>>                . =3D ALIGN(8);
> > >>>>> -             *(.__image_copy_start)
> > >>>>> +             __image_copy_start =3D .;
> > >>>>>                CPUDIR/start.o (.text*)
> > >>>>>                *(.text*)
> > >>>>>        }
> > >>>>> @@ -42,11 +42,7 @@ SECTIONS
> > >>>>>        __u_boot_list : {
> > >>>>>                . =3D ALIGN(8);
> > >>>>>                KEEP(*(SORT(__u_boot_list*)));
> > >>>>> -     }
> > >>>>> -
> > >>>>> -     .image_copy_end : {
> > >>>>> -             . =3D ALIGN(8);
> > >>>>> -             *(.__image_copy_end)
> > >>>>> +             __image_copy_end =3D .;
> > >>>>>        }
> > >>>>>
> > >>>>>        .end : {
> > >>>>> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u=
-boot.lds
> > >>>>> index fcd0f42a7106..553bcf182272 100644
> > >>>>> --- a/arch/arm/mach-zynq/u-boot.lds
> > >>>>> +++ b/arch/arm/mach-zynq/u-boot.lds
> > >>>>> @@ -16,7 +16,7 @@ SECTIONS
> > >>>>>        . =3D ALIGN(4);
> > >>>>>        .text :
> > >>>>>        {
> > >>>>> -             *(.__image_copy_start)
> > >>>>> +             __image_copy_start =3D .;
> > >>>>>                *(.vectors)
> > >>>>>                CPUDIR/start.o (.text*)
> > >>>>>        }
> > >>>>> @@ -57,12 +57,7 @@ SECTIONS
> > >>>>>                *(.rel*.efi_runtime)
> > >>>>>                *(.rel*.efi_runtime.*)
> > >>>>>                __efi_runtime_rel_stop =3D .;
> > >>>>> -     }
> > >>>>> -
> > >>>>> -     . =3D ALIGN(8);
> > >>>>> -     .image_copy_end :
> > >>>>> -     {
> > >>>>> -             *(.__image_copy_end)
> > >>>>> +             __image_copy_end =3D .;
> > >>>>>        }
> > >>>>>
> > >>>>>        .rel.dyn ALIGN(8) : {
