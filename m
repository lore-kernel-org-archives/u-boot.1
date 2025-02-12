Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51BFC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2521880BAD;
	Wed, 12 Feb 2025 10:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hp6ZNMWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08EB580C6F; Wed, 12 Feb 2025 10:41:31 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3681C80842
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-867129fdb0aso2882513241.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739353287; x=1739958087; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z29f/nPboNb8gcqMeoYtd7jUYThB8C19SgiCsXa0dQ=;
 b=hp6ZNMWP+LH16yhrEGPg40zpkTP0z3Cy5U3wZm48XzdCfE0mmV1EQNF3WXgQI+TuIo
 wWB2PfcGySIxla9vnsXYIH1HzBOtr5NRE/aFBZifaPkKq759PY88hPZgMvkYo1+n4u4P
 2eLLWAzxYESQ+8Yn6wbn5kVhz3TdkiQJidCWwBfTKGf63VcpSVu2GWJzuCjf6kdTKyxX
 LkozpzkOc6PF4b0fNRfGQbvfoA5cQBfCzvcZDwDqdPE0qecSJWvrVh2dpIKIvVqmQzLb
 pcXKKaLMyy6litegvPZtzkK6P/AxAnmQ0JSEOK83w8YUbCVd5o5nSSIlr1BOi+buPsFy
 Q5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739353287; x=1739958087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2z29f/nPboNb8gcqMeoYtd7jUYThB8C19SgiCsXa0dQ=;
 b=GiCu2RXYteiplaP37UWthPl/d+32wSZKEmWOIunLI3QakmmIcgGBVC0mrS0JxhDbJO
 1dVfC3dlLjOhONiX7pwyeMZXGkF7kvlPvbFqa45aovNaIvgzRoiLd7H2iRLHTxzHrK3T
 ddIeKeXFRxfQwUgMaDx4Dg7vLJ+JXPq101WsvycruEY/iFe/L5Zzg3ZMxLZF8HjAlYD6
 CMZ8zrV3rIIp/jhBRrz4SWZgKuLlyE8/T5uh/6FHi5jpAMb4q4920CMClr0nX6zwWYmi
 uds+3I/9DHX4n9QRNuouH9vTand1W/qlV25lmHb5QXXF97o/apyTXpyALvnNqNTml7on
 3cug==
X-Gm-Message-State: AOJu0YxmYxZa5nBEEjwbc9+rkasQWX19FVAjFAf+fYjQnZwi44eR1nZo
 WMXV+CVNWO9ao2qGbB66QtBp/+GF1aS5tWj+jZGuGF7RrHQLfvIRZj738oIwraj90fsxA3QiSYy
 nvmKaYC/LoTy56zmy4CECCa0lj8ihMGmNnQ08eQ==
X-Gm-Gg: ASbGncsXjaeM1axxbPH4MbbJ/qCYoTyYsw/m9Zj/EJJIIFwKWHGr+MfzdDeRFjNpqRE
 och2/yNR1Y9cgiqWJJok6W2WfxbmYUm+rxE2nn1ebMTNZe8GRmDzZJkcfSHFg/JLApNJO01U24Q
 ==
X-Google-Smtp-Source: AGHT+IFGO0jrg4/q1xw1tQugawCWI4yrXJyHXcp0ZAgLzy/cioNH+lKL1BPfrNHPgncLBccGAJBWcYNlPKuaB4aVyJY=
X-Received: by 2002:a05:6102:2ac1:b0:4bb:e5bf:9c79 with SMTP id
 ada2fe7eead31-4bbf223abbdmr2157247137.22.1739353286910; Wed, 12 Feb 2025
 01:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
 <20250211135407.GY1233568@bill-the-cat>
 <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
 <CADg8p95xSTpDE_6zKnKHCkJmv0_rqicFXRAXA54D0hzKG_pDaA@mail.gmail.com>
 <20250211145459.GC1233568@bill-the-cat>
In-Reply-To: <20250211145459.GC1233568@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 12 Feb 2025 15:11:16 +0530
X-Gm-Features: AWEUYZkhlpoWYyIFgS5eL7c-VJzxjM-4rydsSafHyEqkk9mNAF6Qj_epkG7kpqE
Message-ID: <CADg8p94uShNqQuWg2BuWToDiwNfWcbd7JTNAmDs+b6WLy=u9Qg@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

On Tue, 11 Feb 2025 at 20:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 11, 2025 at 07:40:40PM +0530, Sughosh Ganu wrote:
> > On Tue, 11 Feb 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > On Tue, 11 Feb 2025 at 19:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> > > > > On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wr=
ote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > > > > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com=
> wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ga=
nu:
> > > > > > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis=
.com> wrote:
> > > > > > > >
> > > > > > > > [=E2=80=A6]
> > > > > > > >
> > > > > > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR=
_DEBUG=3Dy for
> > > > > > > > > > me.  In a usual non-debug build, everything is fine.  H=
owever in a
> > > > > > > > > > debug build now I get this error:
> > > > > > > > > >
> > > > > > > > > >       UPD     include/generated/timestamp_autogenerated=
.h
> > > > > > > > > >       GEN     Makefile
> > > > > > > > > >       Using /mnt/data/adahl/src/u-boot as source for U-=
Boot
> > > > > > > > > >       CC      common/version.o
> > > > > > > > > >       AR      common/built-in.o
> > > > > > > > > >       LD      u-boot
> > > > > > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in functi=
on `lmb_map_update_notify':
> > > > > > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined=
 reference to `efi_add_memory_map_pg'
> > > > > > > > >
> > > > > > > > > Can you share the details of the toolchain that you are u=
sing, where
> > > > > > > > > can I download it from. And the target that you build whi=
ch shows this
> > > > > > > > > up. Thanks.
> > > > > > > >
> > > > > > > > Although I'm actually building with ptxdist and
> > > > > > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a cus=
tom board,
> > > > > > > > you should be able to reproduce the behaviour easily with b=
uildman on
> > > > > > > > master when building for boards sam9x60ek or sam9x60_curios=
ity like
> > > > > > > > this:
> > > > > > > >
> > > > > > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_F=
OR_DEBUG sam9x60
> > > > > > > >
> > > > > > > > My output when running the above is this:
> > > > > > >
> > > > > > > Sorry, I haven't spent time debugging this issue, although th=
is is on
> > > > > > > my todo list. Btw, since you already have a working setup, ca=
n you
> > > > > > > please reset your tree to the following commit and then check=
 if that
> > > > > > > fixes your issue.
> > > > > > >
> > > > > > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> > > > > >
> > > > > > Does not change anything.
> > > > > >
> > > > > > Note: my tree is not special in any way, it's a clean mainline =
u-boot
> > > > > > checkout and I'm building for a board with an in tree config.
> > > > > > Everyone should be able to reproduce this by using
> > > > > > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > > > > > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > > > > > downloaded by buildman, which is also mainline u-boot tooling.
> > > > > >
> > > > > > My assumption is: some efi code is pulled in unconditionally he=
re,
> > > > > > but efi is not enabled on armv5 and it can not be enabled,  efi=
 is not
> > > > > > needed on this target anyways.  Furthermore: I assume the code =
is
> > > > > > optimized out when doing a normal build without CC_OPTIMIZE_FOR=
_DEBUG,
> > > > > > which is basically building without optimizations and keeping d=
ebug
> > > > > > symbols.
> > > > >
> > > > > Okay. Please give me some time. I will try to spend some time on =
the
> > > > > issue this week. Thanks for your quick response.
> > > >
> > > > Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
> > > > optimizations that we normally rely on to avoid having to #ifdef th=
e
> > > > code. In this case, lmb_should_notify() causes this to normally be
> > > > optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and t=
he
> > > > compiler will do the right thing. The "fix" is to instead make most=
 of
> > > > the body of lmb_map_update_notify be guarded with #if
> > > > CONFIG_IS_ENABLED(EFI_LOADER) ... #endif
> > >
> > > Yes, that would be the obvious thing to do. But I suspect that becaus=
e
> > > there are no optimisations with the said flag, it might be needed to
> > > even protect the function calls with the ifdefs. Which I am hoping to
> > > avoid.
> >
> > If we cannot do without using ifdefs at the function call sites, what
> > is your opinion on disabling lmb with the CC_OPTIMIZE_FOR_DEBUG flag
> > enabled? Maybe this can be converted into a config flag. There are
> > existing configurations like xilinix mini which too are disabling lmb.
> > Thoughts?
>
> It should just be a single set of #ifdef ... #endif, and possibly adding
> a __maybe_unused.

Like I suspected, just a single set of #ifdef ... #endif does not
help. Get link errors like such

arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `_lmb_alloc_base':
/data_sda/linaro_work/lmb_efi_fixes/lmb_qemu_test_setup/u-boot/lib/lmb.c:73=
6:(.text._lmb_alloc_base+0x66):
undefined reference to `lmb_map_update_notify'
arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_add':
/data_sda/linaro_work/lmb_efi_fixes/lmb_qemu_test_setup/u-boot/lib/lmb.c:66=
4:(.text.lmb_add+0x20):
undefined reference to `lmb_map_update_notify'
arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_free_flags':
/data_sda/linaro_work/lmb_efi_fixes/lmb_qemu_test_setup/u-boot/lib/lmb.c:67=
6:(.text.lmb_free_flags+0x1e):
undefined reference to `lmb_map_update_notify'
arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_reserve':
/data_sda/linaro_work/lmb_efi_fixes/lmb_qemu_test_setup/u-boot/lib/lmb.c:69=
6:(.text.lmb_reserve+0x2a):
undefined reference to `lmb_map_update_notify'
make: *** [Makefile:1824: u-boot] Error 1


This is with the CONFIG_CC_OPTIMIZE_FOR_DEBUG enabled.

-sughosh

>
> --
> Tom
