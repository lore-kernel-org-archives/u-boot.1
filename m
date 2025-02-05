Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591D7C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E01080812;
	Wed,  5 Feb 2025 22:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KEix/U+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E17180562; Wed,  5 Feb 2025 20:25:36 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02216800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f169e9595so2782875ad.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738783532; x=1739388332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JH6A60GAaIh7a9PwS00SIF6Zw/xpX6WrO+NnCmw13kM=;
 b=KEix/U+pNLlZeUVVbeyt+wn39lYWgPgjpZRekcMNNm3G0t41KHjSdopGTmMHJOcNCk
 zRoh1RbJhDPQDhQzLj8mVjEZxqstfcTCnzhyf/U1zL+8DJmDgkVoPLdZwy5w4yj5Cm7H
 5jfY0Avyy2yYZLrrzfiz0DDNCJQZTNGC1V3JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738783532; x=1739388332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH6A60GAaIh7a9PwS00SIF6Zw/xpX6WrO+NnCmw13kM=;
 b=WdUaTV3odaIbCK8eY7DF0qhjEZ9+HEEvkwCLUeJeRGFUP/orf6SNaN+Wi8+i4jRxF8
 vf6/j7EHATaonFgnGAceQMEyDEfOYgRhNEuycxJaC8tSPI4b5e5QnAUWcB+yKB60qyT6
 /7MuBEbah77X985W01xhXTBXkqj4wEoTgz4XRjT/aDKeZm9qqfWsM1ojBDpJr6SxLFhL
 HuQh63Uk5ESHSmvCB65E+MCkTLEaJ184lmVvbzMCV/3bTws3FY6C8JQi6SA8o7sx0hkb
 6IUp91AjB/rKs0E0SW2VxmRM2Z7ROaLcZRWilxeg25rz/PyYHy5y2Wo0ahKHKt3FYCEp
 7gEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO1x+Ndv7pYP5WTLsmcNDlQdh9X2xS3n00gIgeTrQsdCBVln/FkQAZIRGuv0tQkAUOEwvi29I=@lists.denx.de
X-Gm-Message-State: AOJu0YwRZ1VA3P/RlDi3IiNzbOpP1E/35E7uGCsoxszZXFNaxrkStFzm
 mNAndh7+X/E3l62gLsGrYPyXy7HtHlwc4p+2bIzyJEl1B95UMoh7L8USKymRWOc=
X-Gm-Gg: ASbGncsxb4wcUSLQYBYNDF8vNoKCgFelqMBhiFcKsExtEVrjGrZL9VS6+nw5AuhLQtZ
 Ig877SWgvQFYXd2FoxfK4DpzhVhj8KDfwCCnBVZcfoyD6mdHyDzhSZaKlbFnuQDiAQ1cP4rHLMp
 8xf8PRRxK/P8B6Vhf2mEU1O9SThjMBFVmW27/O9rW8/saUt5i3M3fJRgtV9C1LjcHx64FonTsZp
 3ZbMWzn2SpI5dWn3mBQzZtuAVwoRYut9xvHqVAia3MzTMNiU+zoR0NBVin/wUcuVwWUjqsZrZbh
 Gh2sG+ZEJ9fvCgE=
X-Google-Smtp-Source: AGHT+IHM6gBJ7LDft+Y9qhO9WcnsMzEryu9ADnSl2K/r8p2sF/KZLJLZ2JlwCot7PlBDVv/4Cutmsg==
X-Received: by 2002:a05:6a20:9f8b:b0:1e1:cdff:5f18 with SMTP id
 adf61e73a8af0-1ede8810600mr6916770637.4.1738783532385; 
 Wed, 05 Feb 2025 11:25:32 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba428sm13303446b3a.94.2025.02.05.11.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 11:25:31 -0800 (PST)
Date: Wed, 5 Feb 2025 13:25:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
Message-ID: <20250205192525.GB1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <20250205173336.GY1233568@bill-the-cat>
 <CAC_iWjLVxD13rQcB0gedAUSdgsrvT+fx-ZPYsJVK_UorsXnjhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qnbLDzBXHIDeQcOg"
Content-Disposition: inline
In-Reply-To: <CAC_iWjLVxD13rQcB0gedAUSdgsrvT+fx-ZPYsJVK_UorsXnjhA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:31:05 +0100
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


--qnbLDzBXHIDeQcOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 09:18:50PM +0200, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Wed, 5 Feb 2025 at 19:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 05, 2025 at 09:16:47AM +0200, Ilias Apalodimas wrote:
> >
> > > Upcoming patches are switching the memory mappings to RW, RO, RX
> > > after the U-Boot binary and its data are relocated. Add
> > > annotations in the linker scripts to and mark text, data, rodata
> > > sections and align them to a page boundary.
> > >
> > > It's worth noting that efi_runtime relocations are left untouched for
> > > now. The efi runtime regions can be relocated by the OS when the latt=
er
> > > is calling SetVirtualAddressMap. Which means we have to configure the
> > > pages as RX for U-Boot but convert them to RWX just before
> > > ExitBootServices. It also needs extra code in efi_tuntime relocation
> > > code since R_AARCH64_NONE are emitted as well if we page align the
> > > section. Keep it out for now and we can fix it in future patches.
> > >
> > > Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  arch/arm/cpu/armv8/u-boot.lds  | 29 +++++++++++++++++------------
> > >  include/asm-generic/sections.h |  2 ++
> > >  2 files changed, 19 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boo=
t.lds
> > > index 857f44412e07..35afc3cbe7ec 100644
> > > --- a/arch/arm/cpu/armv8/u-boot.lds
> > > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > > @@ -22,7 +22,7 @@ SECTIONS
> > >
> > >       . =3D ALIGN(8);
> > >       __image_copy_start =3D ADDR(.text);
> > > -     .text :
> > > +     .text ALIGN(4096):
> > >       {
> > >               CPUDIR/start.o (.text*)
> > >       }
> >
> > Shouldn't this be:
> > -       . =3D ALIGN(8);
> > -       __image_copy_start =3D ADDR(.text);
> > -       .text :
> > +       .text ALIGN(4096):
> >         {
> > +               __image_copy_start =3D ADDR(.text); // Or even just '=
=3D .;' ?
> >                 CPUDIR/start.o (.text*)
>=20
> IIRC this will produce the exact same output.

OK, so we don't end up with 8192 worth of alignment here.

> Given Richards's idea, I'll move the sections around a bit and define
> rw_start_end, ro_start/end and rx_start/end symbols.
> It would make other architectures life easier if they ever want to
> replicate this. So with those new symbols, adding ifdefs around the
> alignment should be more readable.

Yes, re-organizing things will help too, I agree.

> > Or so? Something like that would also make it easier in v2 to have a
> > Kconfig about page align / min align for sections in the linker script
> > and then ALIGN(CONFIG_FOO) or #ifdef CONFIG_FOO #define MINALIGN 8 #else
> > 4096 #endif, or so. Also I guess today we're not going to worry about
> > bigger than 4KiB pages?
> >
> > > @@ -36,9 +36,12 @@ SECTIONS
> > >                  __efi_runtime_stop =3D .;
> > >       }
> > >
> > > -     .text_rest :
> > > +     .text_rest ALIGN(4096) :
> > >       {
> > > +             __text_start =3D .;
> > >               *(.text*)
> > > +             . =3D ALIGN(4096);
> > > +             __text_end =3D .;
> > >       }
> >
> > Here and elsewhere in the patch, does that really need two ALIGN(4096)
> > lines? Or am I totally misremembering how these symbols work in a linker
> > script?
>=20
> Yes it does, the first one guarantees the start of the section and the
> latter the end. IOW if I commit the second align, there's no guarantee
> we'll end up page aliged. Our mmu code assumes that it's operating in
> page boundaries.

And I had mis-read the context. Yes, we need to make sure the end is
aligned so that we don't have incorrect permissions for the next
section. And with re-organization of the areas we'll have less extra
padding too.

--=20
Tom

--qnbLDzBXHIDeQcOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejuyUACgkQFHw5/5Y0
tyyRkQv7BJCkij/X0BM+Oy9XUOakYA6+MKqAkY7rfMYcr22WWkNUm4nY2GtEX2o0
eHmSMc0SMd7mNR60UTDQJeaJtgnAWmSFBGYNbhtrHYIyZm1kHPbfIEt6l229I/e0
RMTEkiAauOfSkv1koKli6pVkFmChM9t/eZx8fFLumCzo++2t+Tea1z3f9mCuC7yR
FAAQ3m23jmD42THIQ0skD9X6+Ct44R70TdsJLMB8W2RngyIz9EbtBJUgD5lvVcUl
sAs8AXRaHB6uNTh1zDQjQPQqA/WL4aZvm54DeYk9l2VH27nKlrrU+ZS3b69Ouwf5
Bfmgf7A7CarxfLOrAGlVCKWoDyMVAtEbn9wkibieybqWTcVbZTFF0As/rn0Ke9MD
6wNWx54AncpRMAgUubkmMj5upeaAjk2mlqil+bMSg+CyqZbLgzGj/W5wDbGURb5k
NKSs38Vd+dTNrwMN4TrWQqHHz1yHOow9hLw8SZ2cY7J8pxfyeHp1FevE6gadOxQ8
isQkZt+4
=w6aI
-----END PGP SIGNATURE-----

--qnbLDzBXHIDeQcOg--
