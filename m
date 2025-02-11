Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F98C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D310C80AE5;
	Tue, 11 Feb 2025 15:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UWKWK2R5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5FD80B9C; Tue, 11 Feb 2025 15:10:54 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E11F803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4bbef8a5633so70882137.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739283051; x=1739887851; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iZtjcRkmnCVYAjcrf/it/kgTEDZHkeVmsnCbzfWS4I=;
 b=UWKWK2R5zlfr4XMLSw7XVmLcGQ0yvvEPzk05f7pkqXcNZ4ilSbUZ/X4dzcQLDbRptO
 +PpUfjV6XyHvwXZ92kAqKECAeS3+ZX6DhqTjyjwMoIiQBM4KBqc1I6tBiVWEpeCUWspK
 /eFUPM5nqVDjkH2coCNILI4eLu5skbA4bOJw7UanF0BySIpI1k2MkbFhaiBhqFl9KBMJ
 QqzPkwMfPDsL90ng+4Rv/+foWbmBYzRtiBrMo61mXpuoeIwdon3wymL7gyKZMvKPAuQ/
 OaZQ4CDA7JUTvx+zmLEaCEpNB20kthfyk+GMpps7gTbjmMTrF0VDRyShMKk4zNb+4NMB
 s0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283051; x=1739887851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iZtjcRkmnCVYAjcrf/it/kgTEDZHkeVmsnCbzfWS4I=;
 b=iFRWwIN2RlQio3CAo/fX0Yuuk9P3ni/5D/246n9IxQXEHnuOWPf6EXPu7pZbfOD2NU
 QdOUa4G0OFlQybIMUnaK6Abk1rmBwchQIJDcNf+tV0E9ryl/OnDShCo+cwt2Zn2mlsMy
 LKCzf125U1W8jirA0I9dzdI6vncLC5gf098A7WnUitR2Sqv0hJxIi1P15fDgJ8srCKFj
 W7GlagY+ZSOjth1PI7Ek5TueVKBta0DrKIBt+giLZQpBZfm566ujJytIRj5Ew3MdMfNC
 03Pxn9RaQxxab7eGHv/jMvUyGL9BKRo+tJvukZgkECsOykYTAu8R7y+4yPjiiuurnPp+
 WdfA==
X-Gm-Message-State: AOJu0YxqRb9K1fW4hTrt2Kw11CLnZtWFL4TZ0pybwJMButD/Q2+G/5b7
 ihv+Ipabuiai5qoJbr8ipepWoQCSBGelgwCtkbU6+WJtBpUe0pkMG43MyIWoS1t5K1UGPqaZFzi
 99BRBe6LMzPRtkPoiFDhx82BMr1Ro+Htathy9qQ==
X-Gm-Gg: ASbGncvGxIQ3XAYYOwH5B5qzlA7XYc8+J9nHzNVuj/mY12Lo5bCkvRj4Th8CBbHwYzp
 V6yMhsv84MH82O7JEEQFprMREx9XkeRsec6MZoj5oMM0+pPtnChPGXhG8k3etRTpd8AVJX39V
X-Google-Smtp-Source: AGHT+IGt7rr7HEBqm5njxHCYU1eyFaO1oC4zs5A6IPtn5EaxiocSnRG1c5hSb/o4NUtnJ29iraRzf8aS4ORlEZTA5eQ=
X-Received: by 2002:a05:6102:4194:b0:4bb:cf34:3757 with SMTP id
 ada2fe7eead31-4bbcf3441a7mr4533239137.17.1739283051194; Tue, 11 Feb 2025
 06:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
 <20250211135407.GY1233568@bill-the-cat>
 <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
In-Reply-To: <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Feb 2025 19:40:40 +0530
X-Gm-Features: AWEUYZlQi_EoyhCYhogSX0eYQBYdZ1AD2s-1FvjdpyjcuCJYXx2HSPyFp7ExPVM
Message-ID: <CADg8p95xSTpDE_6zKnKHCkJmv0_rqicFXRAXA54D0hzKG_pDaA@mail.gmail.com>
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

On Tue, 11 Feb 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 11 Feb 2025 at 19:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> > > On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wr=
ote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com=
> wrote:
> > > > > >
> > > > > > [=E2=80=A6]
> > > > > >
> > > > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEB=
UG=3Dy for
> > > > > > > > me.  In a usual non-debug build, everything is fine.  Howev=
er in a
> > > > > > > > debug build now I get this error:
> > > > > > > >
> > > > > > > >       UPD     include/generated/timestamp_autogenerated.h
> > > > > > > >       GEN     Makefile
> > > > > > > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > > > > > > >       CC      common/version.o
> > > > > > > >       AR      common/built-in.o
> > > > > > > >       LD      u-boot
> > > > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `=
lmb_map_update_notify':
> > > > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined ref=
erence to `efi_add_memory_map_pg'
> > > > > > >
> > > > > > > Can you share the details of the toolchain that you are using=
, where
> > > > > > > can I download it from. And the target that you build which s=
hows this
> > > > > > > up. Thanks.
> > > > > >
> > > > > > Although I'm actually building with ptxdist and
> > > > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom =
board,
> > > > > > you should be able to reproduce the behaviour easily with build=
man on
> > > > > > master when building for boards sam9x60ek or sam9x60_curiosity =
like
> > > > > > this:
> > > > > >
> > > > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_D=
EBUG sam9x60
> > > > > >
> > > > > > My output when running the above is this:
> > > > >
> > > > > Sorry, I haven't spent time debugging this issue, although this i=
s on
> > > > > my todo list. Btw, since you already have a working setup, can yo=
u
> > > > > please reset your tree to the following commit and then check if =
that
> > > > > fixes your issue.
> > > > >
> > > > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> > > >
> > > > Does not change anything.
> > > >
> > > > Note: my tree is not special in any way, it's a clean mainline u-bo=
ot
> > > > checkout and I'm building for a board with an in tree config.
> > > > Everyone should be able to reproduce this by using
> > > > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > > > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > > > downloaded by buildman, which is also mainline u-boot tooling.
> > > >
> > > > My assumption is: some efi code is pulled in unconditionally here,
> > > > but efi is not enabled on armv5 and it can not be enabled,  efi is =
not
> > > > needed on this target anyways.  Furthermore: I assume the code is
> > > > optimized out when doing a normal build without CC_OPTIMIZE_FOR_DEB=
UG,
> > > > which is basically building without optimizations and keeping debug
> > > > symbols.
> > >
> > > Okay. Please give me some time. I will try to spend some time on the
> > > issue this week. Thanks for your quick response.
> >
> > Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
> > optimizations that we normally rely on to avoid having to #ifdef the
> > code. In this case, lmb_should_notify() causes this to normally be
> > optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and the
> > compiler will do the right thing. The "fix" is to instead make most of
> > the body of lmb_map_update_notify be guarded with #if
> > CONFIG_IS_ENABLED(EFI_LOADER) ... #endif
>
> Yes, that would be the obvious thing to do. But I suspect that because
> there are no optimisations with the said flag, it might be needed to
> even protect the function calls with the ifdefs. Which I am hoping to
> avoid.

If we cannot do without using ifdefs at the function call sites, what
is your opinion on disabling lmb with the CC_OPTIMIZE_FOR_DEBUG flag
enabled? Maybe this can be converted into a config flag. There are
existing configurations like xilinix mini which too are disabling lmb.
Thoughts?

-sughosh

>
> -sughosh
>
> >
> > --
> > Tom
