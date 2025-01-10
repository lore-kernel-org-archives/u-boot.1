Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB1E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAE9801F5;
	Fri, 10 Jan 2025 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NrmNM3AR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97CB8036B; Fri, 10 Jan 2025 17:17:40 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E3D80050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-467a8d2d7f1so17077321cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736525857; x=1737130657; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vlOOScPZQbGdVQ1Av9dLus2ES0R1LmIBC//t/fz1LwI=;
 b=NrmNM3ARdf6j2w7X3ZquxgVyu9lgnh4qZ/OCWK6srdVWOClJf4KapQELDKSPcAczwD
 Hx5lft3/0Xn4pa8WM7YaQz4KU8crRyuBtdKQBQJHyyVMgUObXX/65g3CrFn8Isv70eDv
 2Eo9MUsCKlKDMHzGhGrVWB9EMamITsC2VRWJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525857; x=1737130657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlOOScPZQbGdVQ1Av9dLus2ES0R1LmIBC//t/fz1LwI=;
 b=rg/PQlngyaRUyG98W0jcQOx4AGPUvA3+zLTYiIgxouOIxV8EG8Ls3S9sge9nen+ShQ
 xZZOl0lMkN1hQekHDPOUYNaZZwSHXI70ZTHWLbmLuIiXUUt4GJqLdEFsOijGU6QaKibH
 /uKKiaiauhQu8iFSUKVB/Y4vMFI2u39l8Bb3nVtLvA23h2IN4KMZq5GofrgLgCKfCflS
 65rl9+kkYxVoBuzCZTqtepIlnp3pN8PoUxTzIZXe1FGK8hn/xGJUCGdwePMpfUxKIx3G
 5p3VFRmz5t3UdlOZ0hhhJYNr9Y3ZgIeevaFH1N8Gxo+jmT+kI7U1kUCKXlbt8fhTQG/w
 Ko+A==
X-Gm-Message-State: AOJu0YxbHxGW04Z3bfj9gZpB71OCQvr1Qe0KiiH/poKK29rPtWE8fMNL
 jgwvfId90DyJyJceh5HppsUbb83ZZpHvVfpk4y9pO1fDguJqf2z7nRWUyHC+UUQ=
X-Gm-Gg: ASbGncu651su09SEzOmbLA2tcLTuuGz5Bto/cYjOGsdoDA0QM9Necqn96V/fcCbJHTU
 DGLUIdHU7MmgE3ldsiQxaGnbSoBWrdVQyy+TV9ymuj6VTjbIU7CXmzIRlz/GPqUOfSXhye7EGfY
 HF/s+EE/WNCFR3IRYOvqicScxux+0iWwCAXTMd9VQX00jUaqTotDxm3CHGfcBMnPBwl0r1su0fR
 6bG2mvKCM8XK1u5bxvSjowg7fjl+I09x1jMRSzvhc39zw2TKt5bHsk=
X-Google-Smtp-Source: AGHT+IFvtY44u5FPUs57d1KhslXwYF08GjUkib26yT7fK10NaunAh24VvFqnKExy6hdwEjvdFnSEJw==
X-Received: by 2002:a05:622a:1996:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-46c7107a481mr207339941cf.43.1736525857237; 
 Fri, 10 Jan 2025 08:17:37 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cc5c9sm10525261cf.52.2025.01.10.08.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 08:17:36 -0800 (PST)
Date: Fri, 10 Jan 2025 10:17:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
Message-ID: <20250110161732.GI3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
 <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
 <20250109150954.GU3476@bill-the-cat>
 <CAFLszTg+pyMWMW-9rXe9D=siFpk1bbgTq1yk0g-+cms2aKnEuw@mail.gmail.com>
 <20250109180817.GC3476@bill-the-cat>
 <CAFLszThn-XcHruFe60TH8FnsKsH08NFEco2zt+9JBHkneQgo0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3beDTD9YfYlJwbJU"
Content-Disposition: inline
In-Reply-To: <CAFLszThn-XcHruFe60TH8FnsKsH08NFEco2zt+9JBHkneQgo0Q@mail.gmail.com>
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


--3beDTD9YfYlJwbJU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 06:39:11AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Jan 2025 at 11:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 08:14:53AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Jan 2025 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 05:36:03AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 8 Jan 2025 at 11:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > This function uses separate arguments for data and size. Use =
the new
> > > > > > > abuf instead, so that they are paired and in one place. In so=
me cases it
> > > > > > > also saves an argument, thus potentially reducing code size.
> > > > > >
> > > > > > This is one of the commits that globally increases size in both=
 full
> > > > > > U-Boot and SPL/etc.
> > > > > >
> > > > > > Is all of the "abuf" changes just a "tidy up" that increases th=
e code a
> > > > > > bit?
> > > > >
> > > > > Yes, a tidy-up which I hope will help overall. I have been thinki=
ng
> > > > > for a while of how to avoid having addr/size and ptr/size passed
> > > > > everywhere. For now abuf seems to provide some sort of solution.
> > > > >
> > > > > I see this:
> > > > >
> > > > > 18: boot: Update fit_image_get_emb_data to use abuf
> > > > >    aarch64: (for 1/1 boards) all +4.0 bss -24.0 spl/u-boot-spl:all
> > > > > +16.0 spl/u-boot-spl:text +16.0 text +28.0
> > > > >
> > > > > so growth on firefly-rk3399 but not with rk3288. I am not sure if=
 the
> > > > > growth will tail off as there are more users, though. We might ev=
en be
> > > > > able to be more clever with static inlines.
> > > >
> > > > Yeah, lets not do this now then and worry about some "clean up" lat=
er
> > > > when we can show that it does, or does not, improve size.
> > >
> > > Oh.
> > >
> > > > And there's
> > > > something wrong with your numbers:
> > > > 01: Fix neighbor discovery ethernet address saving
> > > >    aarch64:  w+   firefly-rk3399
> > > > +(firefly-rk3399) Image 'simple-bin' is missing external blobs and =
is non-functional: atf-bl31
> > > > +(firefly-rk3399)
> > > > +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (=
atf-bl31):
> > > > +(firefly-rk3399)    See the documentation for your board. You may =
need to build ARM Trusted
> > > > +(firefly-rk3399)    Firmware and build with BL31=3D/path/to/bl31.b=
in
> > > > +(firefly-rk3399) Image 'simple-bin' is missing optional external b=
lobs but is still functional: tee-os
> > > > +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (te=
e-os):
> > > > +(firefly-rk3399)    See the documentation for your board. You may =
need to build Open Portable
> > > > +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and bui=
ld with TEE=3D/path/to/tee.bin
> > > > +(firefly-rk3399) Some images are invalid
> > > > 37: dm: core: Provide ofnode_find_subnode_unit()
> > > >    aarch64: (for 1/1 boards) all +324.0 bss +32.0 spl/u-boot-spl:al=
l +16.0 spl/u-boot-spl:text +16.0 text +292.0
> > > >             firefly-rk3399 : all +324 bss +32 spl/u-boot-spl:all +1=
6 spl/u-boot-spl:text +16 text +292
> > > >                u-boot: add: 6/-1, grow: 4/-4 bytes: 516/-224 (292)
> > > >                  function                                   old    =
 new   delta
> > > >                  ofnode_name_eq_unit                          -    =
 160    +160
> > > >                  ofnode_find_subnode_unit                     -    =
 116    +116
> > > >                  fit_image_get_data                          80    =
 176     +96
> > > >                  fit_image_get_emb_data                       -    =
  84     +84
> > > >                  ofnode_write_prop                          224    =
 236     +12
> > > >                  ofnode_add_subnode                         232    =
 244     +12
> > > >                  abuf_init_const                              -    =
  12     +12
> > > >                  abuf_init                                    -    =
  12     +12
> > > >                  abuf_addr                                    -    =
   8      +8
> > > >                  fit_image_print                            780    =
 784      +4
> > > >                  image_locate_script                        696    =
 692      -4
> > > >                  fit_image_load                            1584    =
1580      -4
> > > >                  fit_image_verify                           176    =
 164     -12
> > > >                  ofnode_find_subnode                        140    =
 116     -24
> > > >                  fit_image_get_data_and_size                180    =
   -    -180
> > > >                spl-u-boot-spl: add: 3/-1, grow: 0/-1 bytes: 108/-92=
 (16)
> > > >                  function                                   old    =
 new   delta
> > > >                  fit_image_get_emb_data                       -    =
  84     +84
> > > >                  abuf_init_const                              -    =
  12     +12
> > > >                  abuf_init                                    -    =
  12     +12
> > > >                  load_simple_fit                            580    =
 568     -12
> > > >                  fit_image_get_data                          80    =
   -     -80
> > >
> > > Yes, that's the whole series, so not related to this change.
> >
> > Yes, that's the whole series including this change, so it's related to
> > this change.
>=20
> Right, but it is due to ofnode_find_subnode(), etc.
>=20
> >
> > >  I elected to have two versions of ofnode_find_subnode() to avoid the
> > > size growth in the previous version. But the cost is larger size
> > > growth when OF_LIVE is used.
> > >
> > > Without OF_LIVE, the size growth is tiny.
> >
> > And even worse in SPL, somehow. But you want more OF_LIVE users, not
> > less, yes?
>=20
> Well, OF_LIVE is always quite a bit larger, at least at the moment. It
> has both Linux's of_access stuff and libfdt. It's not OF_LIVE I am
> bothered about, but I do want people using ofnode. Unfortunately
> people still send patches which use libfdt directly.
>=20
> >
> > > So...what to do?
> >
> > Well, if you drop the abuf changes for now, SPL won't change at all for
> > most platforms and that'll be an improvement.
>=20
> Yes, I'll look at that. This is one of many examples where I have a
> problem and realise that we need a nicer way of dealing with it, then
> implement it in the series, but then the series loses focus. So then I
> take it out again, then forget about it until next time, but I never
> actually make the change.

I hate to start to derail this, but refactor for "nicer code" is very
much subjective. Especially when it also grows the code (and it's not
clear that wider usage would result in shrinkage). So yes, this really
needs to be put aside and also part of why I keep asking for one thing
at a time.

> > And I'm going to keep complaining about size growth here because a
> > non-trivial subset of users just wants things to boot quickly and be
> > small.
>=20
> Yes, you won't get any complaints from me on that. I did propose some
> automated checking a few years back, but it never went anywhere.

It be great if buildman size comparison had some way to csv the output.
That's what's missing imo from being able to have some automation or
even just nicer tooling.

--=20
Tom

--3beDTD9YfYlJwbJU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBSBQACgkQFHw5/5Y0
tyw8fAv/X5zP9du0b+p+o4m5PohpnObT9DHfjW/B5KAd4n7lnJSc7YxofcLnHOAb
KVUO/CNwzEGIwp+q930DkARozQJTkknL236ipzXXsBVwsJpx7kaNIXEWsLWY2rQg
NJL/ZAk4j6iLjsaDbrFsf3K3wrjxlMCqtUM7UtQ2wyYcvoCOxuSZmL3PKd99jo2P
GpkfAO+OpOo9QCg3LngBTdEMqlEtK27UjKwzfzaEXed2c2H+Ie6u+4DS3pM9O8UP
N2g8taZJNfGCTHwDTQjYcoTDV/9GbmY2K8vkjgx++gBy8xe83s1AmN+TuJu7ofpA
usuGUPITUPe5POOCreHWvTzYdqKcSVPHF4pHaudkl3wIGrqtKW8FHJeJqdVdK6Sf
d5FsHEYfdo0C83R4vLWDtvK8ECtGQcVXp8pFpmlfUm/nDRSfFFtcsgnu6p5k8/Gy
Sv02+X8M296ycotYfloyQgueOIjUQGme6DvHgC470TKyT3dkce7PGXy1uIMNv8T1
v8TQ/12V
=UL1v
-----END PGP SIGNATURE-----

--3beDTD9YfYlJwbJU--
