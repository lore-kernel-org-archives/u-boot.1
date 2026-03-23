Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3194F483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 18:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97788410D;
	Mon, 23 Mar 2026 19:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DdnhT/Wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3003B8410D; Mon, 23 Mar 2026 19:18:25 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A40C84099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 19:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-415e568a7ecso982774fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774289901; x=1774894701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9J6tPbaU9lUGaOpcJr91E2VcnmeFqaQQ10L6Gw+5ymI=;
 b=DdnhT/Wa6fn0tlABUa11iKpPH3CEwHV4TqS2nr7W3Cvy5bJN+pJa5+w4qFO1/WmGsD
 jQjILNI3mEZ/tP7+sBFuc3f8xfFty7Ud0CoaINGCPBVUKkZSK5z/o1/IkRgyGJj76X4D
 0SwwAgIze8Zqv7y2nTw0Hf/r18XqnUAMim1xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774289901; x=1774894701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9J6tPbaU9lUGaOpcJr91E2VcnmeFqaQQ10L6Gw+5ymI=;
 b=KFqpfJjOMG2St2EEdYwp/7gVjYyD5H8h3oAzvj79YB8eVJpTgKq0y8+sBuyGBPTni8
 uPGAPlUE1x3VIcak2+XYcLplnRmrhCCwH1v6pVMzgJEa1Yl3302NfYX0Yg5s/TDREX0R
 7Ay8du18njLpaS1WT5KBg/t80U5AQz8rCmBOQdUZEzrJeN5JxDz3aWJDcUZco/+xYVHh
 vsXaxS366HYdPTZHcUtfeR9ZLGrHu75sjkpQXDn+U4tsx0U4l8EQf5Ny6rzcAlD1OHqg
 g3HVPHl6jxqcBq08bUlOkf/5olpxoFV4nIR0SLdYz9LkBW4n0pBMaOMJ/fqerx+xHG4r
 ASDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZZGOSROWlXSrgtZ+DkTi+52m6M95xCOkvnwkD+S8EV7t8IvAb2qT7fJLF3qg4YsuM8Iw9rqA=@lists.denx.de
X-Gm-Message-State: AOJu0YykGuElkLx0TjpuDxInpBalZ/AnYXC3/PWlVdBykzdLzq3DMQNH
 9xb/PLRW9ZQL56uPyNBDpMhYgIE8B5DxMk4nU3rCo8TMNX7GRd9kH+qLMSUlxl85TFk=
X-Gm-Gg: ATEYQzyjvG9zA0Zx+CH1MuB1qgl8y1uaLuWLB2Eg0NH+5uMLPHnUUG7YG7MtU+B8HXb
 iBQ+dRYC6Lj43pJwIsGjlhf9nNBGKP29iXu2HilYo201FQ5PJ6JCebeBt1OL+CBvwRtwMW473Li
 Vnp6Tp+wjRL3eapIf6lnUGWcL1DLwjjErcTxe7Oi6D9fu1oIwvqQfx7phSJZLrgpxIP+wOaZwye
 uaTdSYQl85pF8sdlQPaBgEMOWZLuXQOpkW22vmTqdA7Bp+eSS4IS5fajglSp5pYdm4EJDW3dO89
 2xoDFcgL3AcTxOcQHG6JFAhBKMiNCvjguWVBGMzcEUjYSoQByOTu67aNE0S/xYnJVQToMqSvGfg
 4UHxcJfOaQj4avW+rDn9oEYx1V7l/b454mdYjuq4e7UYTGENpzodk7j49zPF1j5dlUMz5WtpJxR
 /VMpeRhS55OV1IjXGl61xakBdAI5IkBHN8jl8bRS6GlycZURJh4FjTJ5R0V82JYBK3chn9S0Y0i
 uSy5VmcawwqED7cyGATeMU4ygoOKg8vlur5cdtoUsc6dzXu
X-Received: by 2002:a05:6870:1649:b0:404:31c3:9b8e with SMTP id
 586e51a60fabf-41c110bc266mr8169431fac.16.1774289900586; 
 Mon, 23 Mar 2026 11:18:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d63aa9sm10407374fac.10.2026.03.23.11.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 11:18:19 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:18:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Gary Guo <gary@garyguo.net>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com,
 yuya.hamamachi.sx@renesas.com, andrew.goodbody@linaro.org,
 casey.connolly@linaro.org, xypron.glpk@gmx.de,
 holger.brunck@hitachienergy.com, ilias.apalodimas@linaro.org,
 jonas@kwiboo.se, kettenis@openbsd.org, semen.protsenko@linaro.org,
 sughosh.ganu@arm.com, u-boot-bounces@lists.denx.de
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Message-ID: <20260323181815.GJ502704@bill-the-cat>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
 <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
 <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V8PMpAQqzCdyYDjH"
Content-Disposition: inline
In-Reply-To: <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--V8PMpAQqzCdyYDjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 06:26:01PM +0100, Marek Vasut wrote:
> On 3/23/26 6:11 PM, Gary Guo wrote:
> > On Sun Mar 22, 2026 at 11:25 PM GMT, Mark Kettenis wrote:
> > > > Date: Sun, 22 Mar 2026 22:59:53 +0100
> > > >=20
> > > > On 3/22/26 10:45 PM, Gary Guo wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > > > Is your malloc area by any chance above the 4 GiB boundary ? Or=
 how come
> > > > > > does EFI allocate pages from above 4 GiB range? It should not b=
e doing
> > > > > > that and that is what should be fixed, at least until the DMA32
> > > > > > allocator is in place.
> > > > > >=20
> > > > > > Please keep in mind, that revering this patch breaks other use =
cases,
> > > > > > like loading into the DRAM above 4 GiB.
> > >=20
> > > Well, technically it doesn't break things as this is new
> > > functionality.
> > >=20
> > > > > Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/=
efi_memory.c)
> > > > > whenever it allocates, which calls efi_allocate_pages, which call=
s into
> > > > > lmb_alloc_mem. There's no malloc here.
> > > > Does something like this make the issue go away ?
> > > >=20
> > > > "
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memor=
y.c
> > > > index b77c2f980cc..44eccc0cf35 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
> > > > efi_allocate_type type,
> > > >           flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
> > > >           switch (type) {
> > > >           case EFI_ALLOCATE_ANY_PAGES:
> > > > +               addr =3D map_to_sysmem((void *)(uintptr_t)0xffff000=
0);
> > > > +
> > > >                   /* Any page */
> > > > -               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_S=
IZE, &addr,
> > > > +               err =3D lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_S=
IZE, &addr,
> > > >                                       len, flags);
> > > >                   if (err)
> > > >                           return EFI_OUT_OF_RESOURCES;
> > > > "
> > > >=20
> > > > If so, then maybe we need a temporary config option which limits the
> > > > EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitat=
ions.
> > >=20
> > > Note that some arm64 systems (e.g. Apple Silicon) have *no* memory
> > > below 4 GiB.  So that change must indeed be behind a config option and
> > > care must be taken on what systems to enabled it.
> >=20
> > Perhaps a good short-term fix it to use gd->ram_top here rather than ha=
rdcoding
> > 4 GiB. This way it should work on all systems without a config option.
> Looking at my notes from last DMA32 investigation, this may indeed do the
> trick in the meantime. But it would be really good to have this temporary
> workaround guarded by some Kconfig symbol, so it can be fixed up once the
> DMA32 allocator is available.

As my recent patches show, I'm digging around a bunch of Kconfig things
at the moment and I want to cauation against thinking that a symbol
guard will lead to someone doing some required fixup work. At least
filing an issue under https://source.denx.de/u-boot/u-boot/-/issues/
means we can track it for later and put links to relevant threads as
comments, when someone has time and interest in picking it up.

--=20
Tom

--V8PMpAQqzCdyYDjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacGD5AAKCRAr4qD1Cr/k
CsYFAQD6k2v/NwH7ocz233lRT4xI2GmvYv8YH45sqEBMGFL35AEA2MQkLbL2oTiq
EoAKWst05Y9O/CZdfvWMbucNx+uvrQo=
=Jouf
-----END PGP SIGNATURE-----

--V8PMpAQqzCdyYDjH--
