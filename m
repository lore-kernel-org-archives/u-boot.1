Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F892C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CEA82A76;
	Fri,  4 Jul 2025 23:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4y6bMLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD0882F30; Fri,  4 Jul 2025 23:04:27 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A2E82063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so1983800a12.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751663064; x=1752267864; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qU/oCfAkGT0sv4k8GaOkbC/4f8zTOA5RMlB1YMvI/oI=;
 b=m4y6bMLwrs2YE5OFRr9yCExRRV30Ry7BYhSLJmBHOmr7aCNBdEN2vHyswhpInTHqii
 xQzNcftQK82Ni8d5OWX2tDRnt9gNpNOsc2DcXo7HsP3FOr2B3V19Ewjqj4IEM7aSaMjH
 +u+P6K7Nks7yzR3P1C3d/+AD/ZHRRTrNrOBDXM1EIf8+IOC4NOlLAcuFnqwXPAPydkZO
 JrIeIePyyOWKstMDxWSFxVG+3yIwzo4C7/638pBYezNCXtevjE/PZOhjop/V26569CPl
 PUMb4nPV6u1ZeYV2ZgXjm2xKW0akI7k1fr1V5bWZ40apIssel9PH614luOT+0WxDFhhy
 eF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751663064; x=1752267864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qU/oCfAkGT0sv4k8GaOkbC/4f8zTOA5RMlB1YMvI/oI=;
 b=xL4u7ipOJr7WWTZbslkY47+/0V+3mvG/7/K2PfaULzNxlSKivX/Nx4lLUSkpl7cYne
 BjyvEHa++gLvfjv1LipBcgEh8cpf4B/qKpWFQts5FQ9E7v3dGXTwbyIkusuRLyu44/Oq
 9BUyDc9PtHkBsMQRGcNNMAImbsFRpvFnDe2YTTMqamut6kYofbBaO8IInrNznIHitOKn
 nn8G793S0i6TwG1y62g88/XcazzaNthtZNFTBZtZ41K5p+8jdOQcqgGWWnI0Zc0jt9NF
 5eBfr7yBt9BtqIxbkPkOHJ1y/IzVm6c8JjPFr6K99XMAbQCqOFfep1GGAey8dl0wTkiW
 2ekA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUpGhHTKj10cdOtM5dBO/MsZWfm/hf5bq5YFVFdZBjhSV7TS2qbPAZhQlBSZFn8MgmsOUh8eA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw70ZP1OamPaHVQsSG5dCtg2in/Ltizr/Xi0JprWGutUpAMypCG
 aumvppZwkHQ2IuIL3sAqhwcv1GyEHuCXdjdCCiHwwKBG5sw8ue5eQxzPKnNznbrc0F+aNncmvaJ
 YNLGnHolfknQHAr4OfwHoM6Tfv2flRv3z1tPj
X-Gm-Gg: ASbGncuSHfVay6mK5T6VvxYOU9vHyzredKRsXc0xLfg09SPK+rn3yMjBZSAjIuJG5Av
 G58tXVQ7qb7UFDr/vT8AjH3aXMLC2xaLC8iDUBVOlvKJKmwQL3tbBsNVt+pGGt1rgt4ngxvmrMr
 PBQJyNmZ5CsnLtMGTibuvGpQjA0aG70VNERHOfDS6zaGV+
X-Google-Smtp-Source: AGHT+IFP9s+OSFG4TpCiEk0/wPBVEIRjJH7Qg/TiohDlx52RLGfCORqJkS6QpANUq8stU6OlEw/XezehhMfwi5Kc7Hg=
X-Received: by 2002:a05:6402:440a:b0:60c:40bd:885a with SMTP id
 4fb4d7f45d1cf-60fd6d508e0mr3326692a12.17.1751663064018; Fri, 04 Jul 2025
 14:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
 <eb06107f-2a8b-4347-9937-89d099f22c89@linaro.org>
 <CAJaLiFwW_=GZcyS8qEyCepkYyHsGs-3hOiS6ubNbN=2=WC9ReA@mail.gmail.com>
 <20250621013656.GP216500@bill-the-cat>
 <2b144700-371c-4492-9244-41539457050b@linaro.org>
In-Reply-To: <2b144700-371c-4492-9244-41539457050b@linaro.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 4 Jul 2025 14:04:12 -0700
X-Gm-Features: Ac12FXz_5dr10FCRXbEDgkF7RO10P9VdRz-PqtnX4tlj2ykZu9P9S46f5AIUtnM
Message-ID: <CAJaLiFwc-aV67oYnRTHcEeDZByqr_LeS_uOv2O60QXGJ4ByEhQ@mail.gmail.com>
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jerome & Tom,

On Mon, Jun 23, 2025 at 1:10=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Tom,
>
> On 6/21/25 03:36, Tom Rini wrote:
> > On Fri, Jun 20, 2025 at 02:21:59PM -0700, Tony Dinh wrote:
> >> Hi Jerome,
> >>
> >> On Fri, Jun 20, 2025 at 4:03=E2=80=AFAM Jerome Forissier
> >> <jerome.forissier@linaro.org> wrote:
> >>>
> >>> On 6/20/25 12:53, Jerome Forissier wrote:
> >>>> Hi Tony,
> >>>>
> >>>> On 6/19/25 22:37, Tony Dinh wrote:
> >>>>> Hi Jerome,
> >>>>>
> >>>>> While fixing some ext4 file system problems on 2025.07-rc4, I ran i=
nto
> >>>>> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> >>>>> image,
> >>>>> and then u-boot execution was frozen without anything going to the
> >>>>> serial console. I did a bisect and found the commit that caused it.
> >>>>>
> >>>>> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc=
02b8a75c1940
> >>>>>
> >>>>> When I tried to reverse this commit, I had a build error like this
> >>>>> "{standard input}:24246: Error: selected processor does not support
> >>>>> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
> >>>>>
> >>>>> Currently, the only way to boot Kirkwood boards is to disable eithe=
r
> >>>>> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
> >>>>>
> >>>>> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> >>>>> know if I can help with testing to troubleshoot this regression.
> >>>>>
> >>>>> All the best,
> >>>>> Tony
> >>>>
> >>>> The problem seems to be that some arm32 instructions are inlined
> >>>> inside thumb code and that's not allowed on this CPU without some
> >>>> interworking instruction (bx, blx etc.). For example, consider
> >>>> board_init_r(), is is mainly 16-bit instructions (Thumb):
> >>>>
> >>>> 006186a0 <board_init_r>:
> >>>> board_init_r():
> >>>> /home/jerome/work/u-boot/common/board_r.c:799
> >>>>   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
> >>>>   6186a2:       b0ab            sub     sp, #172        @ 0xac
> >>>> get_gd():
> >>>> /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
> >>>>   6186a4:       464a            mov     r2, r9
> >>>> ...
> >>>>
> >>>> but then suddenly:
> >>>>
> >>>> /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
> >>>>   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
> >>>> writefr_extra_feature_reg():
> >>>> /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
> >>>>   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
> >>>>                 ^^^^^^^^
> >>>>                 32-bit arm instruction
> >>>>
> >>>> I would expect some call to a *_from_thumb() veneer, such as in:
> >>>>
> >>>> 006009dc <do_bootm_qnxelf>:
> >>>> [...]
> >>>> /home/jerome/work/u-boot/boot/bootm_os.c:379
> >>>>   600a02:       9501            str     r5, [sp, #4]
> >>>> /home/jerome/work/u-boot/boot/bootm_os.c:384
> >>>>   600a04:       f04a fc7c       bl      64b300 <__dcache_status_from=
_thumb>
> >>>>
> >>>>
> >>>> 0064b130 <__dcache_enable_from_thumb>:
> >>>> __dcache_enable_from_thumb():
> >>>>   64b130:       4778            bx      pc
> >>>>   64b132:       e7fd            b.n     64b130 <__dcache_enable_from=
_thumb>
> >>>>   64b134:       e59fc000        ldr     ip, [pc]        @ 64b13c <__=
dcache_enable_from_thumb+0xc>
> >>>>   64b138:       e08cf00f        add     pc, ip, pc
> >>>>   64b13c:       fffffb28        .word   0xfffffb28
> >>>>
> >>>> We may need to move the inline functions with mrc/mcr to a .S file,
> >>>> making sure it's built with -marm on CPUs that do not support Thumb2=
.
> >>>> Then hopefully the proper interworking sequence would be inserted by=
 the
> >>>> linker as is the case when Thumb is calling into object files result=
ing
> >>>> from .c files built with -marm (for example: arch/arm/mach-kirkwood/=
cpu.c
> >>>> which has CFLAGS_cpu.o :=3D -marm).
> >>>>
> >>>> In the meantime, could you try the following patch?
> >>>>
> >>>> diff --git a/common/Makefile b/common/Makefile
> >>>> index 35991562a12..a509675335a 100644
> >>>> --- a/common/Makefile
> >>>> +++ b/common/Makefile
> >>>> @@ -19,6 +19,8 @@ obj-y +=3D version.o
> >>>>  # # boards
> >>>>  obj-y +=3D board_f.o
> >>>>  obj-y +=3D board_r.o
> >>>> +CFLAGS_board_f.o +=3D -marm
> >>>> +CFLAGS_board_r.o +=3D -marm
> >>>>  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
> >>>>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
> >>>>
> >>>> I think it should resolve the issue, but is does also increase the
> >>>> size of the binary (+4 KiB). So the .S solution would definitely be
> >>>> better if it works IMO. I'll try to propose something ASAP, will
> >>>> likely be on Monday, feel free to give it a try by yourself though :=
)
> >>>
> >>> Or maybe this which is a bit less radical:
> >>>
> >>> diff --git a/common/Makefile b/common/Makefile
> >>> index 35991562a12..f0b7eadf7d2 100644
> >>> --- a/common/Makefile
> >>> +++ b/common/Makefile
> >>> @@ -19,6 +19,8 @@ obj-y +=3D version.o
> >>>  # # boards
> >>>  obj-y +=3D board_f.o
> >>>  obj-y +=3D board_r.o
> >>> +CFLAGS_REMOVE_board_f.o :=3D $(LTO_CFLAGS)
> >>> +CFLAGS_REMOVE_board_r.o :=3D $(LTO_CFLAGS)
> >>>  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
> >>>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
> >>>
> >>> Still results in +1 KiB.
> >>
> >> The above patch works great! I've tested it on 3 Kirkwood boards: the
> >> Pogo V4 (88F6192), Zyxel NSA325 (88F6282), and GoFlex Home (88F6281,
> >> same SoC as the Sheevaplug).
> >>
> >> The Sheevaplug is now 498K, which is well under limit. All these
> >> boards see only 1K increase in binary size.
> >
> > Can we please get a patch of the latter option now for the release and
> > look at doing the .S file for the future? Thanks!
>
> https://lists.denx.de/pipermail/u-boot/2025-June/592785.html
>
> Regards,
> --
> Jerome

Just a heads up, in a few days I'll be away for a few weeks. And not
sure I can access my development box to do the testing for the
upcoming .S patch. If not, I will do that late next month.

All the best,
Tony
