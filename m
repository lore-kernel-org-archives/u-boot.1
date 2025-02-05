Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD77C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC36A807E4;
	Wed,  5 Feb 2025 22:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rkqoyY5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217E080562; Wed,  5 Feb 2025 20:19:30 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15E8800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so78482276.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738783166; x=1739387966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LedA6jWSkCcwfy91Wn2RsWacSPMTlDEDGHrAD2xtoUU=;
 b=rkqoyY5ZEaxzSyX+BxqTYtxEiLPVI846FSaixktKa2+q689Uo/hkKNwfEYIHCJX9eB
 2e5TKBanx8HauFmbf/cACUFrjdWz0kHBaanUmnYkltkiW1PXBaI41I19s9I2A9dCb778
 Xpr1sywGmiY9vR5eKFmKd6ooYOYf2Jea6ERTzmndc4yX7yn89vH2z28ennqABzj7BzDr
 ttduXhfSAXECXRJLwNs36vGyvnRBl9JaCWPDdfnGqXuFJrb/40r+i0bahbRSu5Fj/uX2
 /lNeX8uQno/88ellc7MKo1brQ4aUcRkGygyhpL+4jor14iL2wEEl2X+VKPrZktOoHIoq
 x+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738783166; x=1739387966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LedA6jWSkCcwfy91Wn2RsWacSPMTlDEDGHrAD2xtoUU=;
 b=Bfs/BEkymDcxRpiHeRyZUzHYIS1rZr8VxeRwVyJqYppytcEo0Q507j9KdKvcc08Ghs
 5GvFghyokC6nmFqLUx4A0sMRvMr13uvEcQct4zsPzmAPL8A4NIQcO6tj59byRgIhTZxN
 W2RcAeUVLoOC1DSLZ3jqXk1TpfViqZtAD6+hRoSdKMcan75oRp1lZNV4/co/LuL4nH6t
 TdmR5ZkfmdpYS804mqHsckkMO+e1dya075gwsc0ybKLMVb4sXXsGEQJq66tZ+sReAPmx
 xuI1P/2ba8hq8rEq+xLNqyXPDdjSgdD/+nXO3HO2a4te7vCR6U8opfOXlTRBIlVTjFiM
 j5sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTJDRUKc7SUy+11jUiQiGrA4l+BQIrj1m38Etppt/phfVOl6LwrWY5PWkw/7jbqUK/t7DKIiY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7jRFb0zCsqksweji3bJJH4DmJQmICsCie1Gg0bs+oMABus+Me
 0EDemmGyCnaLATwkhvgNA+qe/Hi4GnLcMKQ6Zy0yU5TbSnRQQuUpW+I5H+d8BcL8yfeogJ/iUFR
 sXBbFjLWyJWVXx7Jo6RYb9NJhbnwGP/MgzJY6Yw==
X-Gm-Gg: ASbGncsNqn2gbHSmGcLkbFeDlHRZMa3xW4dm3iLpQyHYE+yIeaPB1cde4vek05EYbeI
 0YW7F8caeoR3RAuYpMjh3bcCYYxU4GALoEL3698EcRMT8pJXCHT5WlwmoZkrmIC+lf+UydP5m
X-Google-Smtp-Source: AGHT+IH4IboABaXPmsNMKnqJj1nLYSVDQmVcAUZyRVlct9gL+G+Jw0qWpGWGRtHm0JTQAZrNgHe2VYCFEUxC3qVZ2Vc=
X-Received: by 2002:a05:6902:a85:b0:e5a:e7ec:2752 with SMTP id
 3f1490d57ef6-e5b25b36a65mr3457271276.27.1738783166372; Wed, 05 Feb 2025
 11:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <20250205173336.GY1233568@bill-the-cat>
In-Reply-To: <20250205173336.GY1233568@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 21:18:50 +0200
X-Gm-Features: AWEUYZmfzUqCk1JBuZGbRCReB9qGoMdtW0Vleo6rbAvngMronmVpY5R0mbizo50
Message-ID: <CAC_iWjLVxD13rQcB0gedAUSdgsrvT+fx-ZPYsJVK_UorsXnjhA@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:30:51 +0100
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

Hi Tom,

On Wed, 5 Feb 2025 at 19:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 05, 2025 at 09:16:47AM +0200, Ilias Apalodimas wrote:
>
> > Upcoming patches are switching the memory mappings to RW, RO, RX
> > after the U-Boot binary and its data are relocated. Add
> > annotations in the linker scripts to and mark text, data, rodata
> > sections and align them to a page boundary.
> >
> > It's worth noting that efi_runtime relocations are left untouched for
> > now. The efi runtime regions can be relocated by the OS when the latter
> > is calling SetVirtualAddressMap. Which means we have to configure the
> > pages as RX for U-Boot but convert them to RWX just before
> > ExitBootServices. It also needs extra code in efi_tuntime relocation
> > code since R_AARCH64_NONE are emitted as well if we page align the
> > section. Keep it out for now and we can fix it in future patches.
> >
> > Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/u-boot.lds  | 29 +++++++++++++++++------------
> >  include/asm-generic/sections.h |  2 ++
> >  2 files changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > index 857f44412e07..35afc3cbe7ec 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -22,7 +22,7 @@ SECTIONS
> >
> >       . = ALIGN(8);
> >       __image_copy_start = ADDR(.text);
> > -     .text :
> > +     .text ALIGN(4096):
> >       {
> >               CPUDIR/start.o (.text*)
> >       }
>
> Shouldn't this be:
> -       . = ALIGN(8);
> -       __image_copy_start = ADDR(.text);
> -       .text :
> +       .text ALIGN(4096):
>         {
> +               __image_copy_start = ADDR(.text); // Or even just '= .;' ?
>                 CPUDIR/start.o (.text*)

IIRC this will produce the exact same output.
Given Richards's idea, I'll move the sections around a bit and define
rw_start_end, ro_start/end and rx_start/end symbols.
It would make other architectures life easier if they ever want to
replicate this. So with those new symbols, adding ifdefs around the
alignment should be more readable.

>         }
> Or so? Something like that would also make it easier in v2 to have a
> Kconfig about page align / min align for sections in the linker script
> and then ALIGN(CONFIG_FOO) or #ifdef CONFIG_FOO #define MINALIGN 8 #else
> 4096 #endif, or so. Also I guess today we're not going to worry about
> bigger than 4KiB pages?
>
> > @@ -36,9 +36,12 @@ SECTIONS
> >                  __efi_runtime_stop = .;
> >       }
> >
> > -     .text_rest :
> > +     .text_rest ALIGN(4096) :
> >       {
> > +             __text_start = .;
> >               *(.text*)
> > +             . = ALIGN(4096);
> > +             __text_end = .;
> >       }
>
> Here and elsewhere in the patch, does that really need two ALIGN(4096)
> lines? Or am I totally misremembering how these symbols work in a linker
> script?

Yes it does, the first one guarantees the start of the section and the
latter the end. IOW if I commit the second align, there's no guarantee
we'll end up page aliged. Our mmu code assumes that it's operating in
page boundaries.

Thanks
/Ilias


>
> --
> Tom
