Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333ADC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 23:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B012B8033D;
	Thu,  6 Feb 2025 00:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="thBaVaZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AA5807A7; Wed,  5 Feb 2025 22:36:27 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8187D800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 22:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f974a5e5e3so2228807b3.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 13:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738791384; x=1739396184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dgZI0p9UOVBZkdDdX/emUZnk7we896WfsOCwT7yJ6Ds=;
 b=thBaVaZuo5oVGM6XzpKtJ8E/vHBTf6+RqmxnE41XvefAUwPu+OElgyJAsKnX8G3tFu
 ItCZcfV3J6scCokZJ3AMJNN476xvoCyPuZFRWbepJlQ5DHhfbKQCvBIIw4cN1CBrsIt+
 8qPuTE4E6cBoxnIY01QFOejmFoaubiMrkjc4fcAIuv7bHAZiwhjC4rffk3l0cLAkiwW9
 fQwJTYbTwz8GxPzK/QJ/QF2182Io6wEh8zqkTH/nuKvIV+XLU0wf1fagw/+A0dYTXLpi
 Gj+9fD9PPY/fqlsHGZhIcqvX9zw7DvI8pNDzVUS3axS4Hj9Nb7vZKa8LjiNZkxS1ue74
 ZDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738791384; x=1739396184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dgZI0p9UOVBZkdDdX/emUZnk7we896WfsOCwT7yJ6Ds=;
 b=N83O2Pzly9KRrpe1kk3WI25/6bKz7Sfwe2c8kw7Spz/UX7R3cG66Sv3R6UWnYcm7WB
 /0QoUaWkyrVWNSW9sfhSo70RYmH2iNC2qXN0u+FUtmhJo56y5mpZkEN8ubU22QYI04+I
 L5IGxnpsBoHOuf+hQJd1Csc2GJ0s6vWZePxVuwlSZc50y4vYhLSKyKDn6LU7uZdqDPSa
 UpKmV7wTH60obQwF/SlHxD8wz+RVUvdp+HQN+3Tu4y+oxmwX1wx3ywfLBbbtziv+aI1C
 ULTTZ3i/vyCOcNFvCha+73mriLEkOcvRTuusFQSbJCq//kjiBynigFzmBHKdAW7PSKd1
 oD5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3OLCZWnmYUuEot66AO6zFTL+9Yq/7VD+mEin/S1aAC8yYpCYG4oPhqFsOtFXpPGgFW2LqZYA=@lists.denx.de
X-Gm-Message-State: AOJu0YyvtNgy9Aj02OsncZt8DRHz+uj+nCBRQf4NtPNB24+j3EsDEH4O
 6NYAuVD/4u5+i8tXKIL9ejDxJ7H2FW4y2HrAiwaeO7P8ptz8d/ju8OhyJePLSdS9e2kUKiAjaSw
 qN6/Lp5XYMfhGV13C3SGu4RAL9GRp8ynpamzIPg==
X-Gm-Gg: ASbGncvzD2N5C88B8KPO+vs5lDjR4PPiPiiQudxmkf+rgwVeQA5ESAdOFtv/Q0iiPyM
 +t81JjE8e0ZwHcs4mX551bazlnTfYFKKWWGjm7KpnMJIuLEkEIrjl6XnzWTjA6fB8JMB1g8Dl
X-Google-Smtp-Source: AGHT+IGWHR5ABvqNh1f0Id2/vpT3z6gHmOUNFdXsoKP0Zfj1QmpY0BR2q5XaIP7OoyH6yhWChiu9Bww8h2XOOgFE/7Y=
X-Received: by 2002:a05:6902:e0f:b0:e5b:21fe:d9bd with SMTP id
 3f1490d57ef6-e5b259d504bmr4060469276.10.1738791384262; Wed, 05 Feb 2025
 13:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <20250205173336.GY1233568@bill-the-cat>
 <CAC_iWjLVxD13rQcB0gedAUSdgsrvT+fx-ZPYsJVK_UorsXnjhA@mail.gmail.com>
 <20250205192525.GB1233568@bill-the-cat>
In-Reply-To: <20250205192525.GB1233568@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 23:35:48 +0200
X-Gm-Features: AWEUYZn75SIHSU9UXGAvfiBClf9Xiyy45_XBGi6FRkMVmU19JYA6APsJ2uHoIQI
Message-ID: <CAC_iWjJ=zV6EfZ5sn=QvXqQ3zYKSNeB+1MEtF_ivbXE4+qO_MA@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
To: Tom Rini <trini@konsulko.com>
Cc: xypron.glpk@gmx.de, Jerome Forissier <jerome.forissier@linaro.org>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Marc Zyngier <maz@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Day <me@samcday.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>, 
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Feb 2025 00:16:41 +0100
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

On Wed, 5 Feb 2025 at 21:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 05, 2025 at 09:18:50PM +0200, Ilias Apalodimas wrote:
> > Hi Tom,
> >
> > On Wed, 5 Feb 2025 at 19:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Feb 05, 2025 at 09:16:47AM +0200, Ilias Apalodimas wrote:
> > >
> > > > Upcoming patches are switching the memory mappings to RW, RO, RX
> > > > after the U-Boot binary and its data are relocated. Add
> > > > annotations in the linker scripts to and mark text, data, rodata
> > > > sections and align them to a page boundary.
> > > >
> > > > It's worth noting that efi_runtime relocations are left untouched for
> > > > now. The efi runtime regions can be relocated by the OS when the latter
> > > > is calling SetVirtualAddressMap. Which means we have to configure the
> > > > pages as RX for U-Boot but convert them to RWX just before
> > > > ExitBootServices. It also needs extra code in efi_tuntime relocation
> > > > code since R_AARCH64_NONE are emitted as well if we page align the
> > > > section. Keep it out for now and we can fix it in future patches.
> > > >
> > > > Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >  arch/arm/cpu/armv8/u-boot.lds  | 29 +++++++++++++++++------------
> > > >  include/asm-generic/sections.h |  2 ++
> > > >  2 files changed, 19 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > > > index 857f44412e07..35afc3cbe7ec 100644
> > > > --- a/arch/arm/cpu/armv8/u-boot.lds
> > > > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > > > @@ -22,7 +22,7 @@ SECTIONS
> > > >
> > > >       . = ALIGN(8);
> > > >       __image_copy_start = ADDR(.text);
> > > > -     .text :
> > > > +     .text ALIGN(4096):
> > > >       {
> > > >               CPUDIR/start.o (.text*)
> > > >       }
> > >
> > > Shouldn't this be:
> > > -       . = ALIGN(8);
> > > -       __image_copy_start = ADDR(.text);
> > > -       .text :
> > > +       .text ALIGN(4096):
> > >         {
> > > +               __image_copy_start = ADDR(.text); // Or even just '= .;' ?
> > >                 CPUDIR/start.o (.text*)
> >
> > IIRC this will produce the exact same output.
>
> OK, so we don't end up with 8192 worth of alignment here.

We do, but that's because I added an ALIGN(4096) in .text. The change
above won't change that.

But looking at it again, I don't have to do that now. I can remove the
alignment from .text since some efi_runtime services are between that
and .text_start.
Since my current patch ignores efi_runtime, I can skip the .text
alignment, save ~4k and fix the rest when I deal with EFI.

>
> > Given Richards's idea, I'll move the sections around a bit and define
> > rw_start_end, ro_start/end and rx_start/end symbols.
> > It would make other architectures life easier if they ever want to
> > replicate this. So with those new symbols, adding ifdefs around the
> > alignment should be more readable.
>
> Yes, re-organizing things will help too, I agree.
>
[...]

Regards
/Ilias
