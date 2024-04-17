Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E376C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 16:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6F88828C;
	Wed, 17 Apr 2024 18:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E95lmqj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C53878848F; Wed, 17 Apr 2024 18:04:57 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B018F88456
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 18:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b4043b7b3so26044876d6.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713369892; x=1713974692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j78rvKD3W+XlRPVPkYyGw2/6fLHVhlCJ6tpvfH5WPNI=;
 b=E95lmqj3KLo219MAH1eIoG8rhJ3G1gbhWkY2IMF0HPHoxmLuGIyBkpGF+VqwBBoA/M
 Sq6TpFMRQ/BanPt/WNNh8YIztxvlCyfu9unJerbdDtY8tPU/RjYYrLcKUJMFqZHOyolb
 BAeMmJuQ47k6Yay4gw0x3fmcDOH/fK9PEfgjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713369892; x=1713974692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j78rvKD3W+XlRPVPkYyGw2/6fLHVhlCJ6tpvfH5WPNI=;
 b=pzN6UH63i81WGwMzf3eo4ixgsRdL/2K3OF9Xl0t6nCsRkN1SsdBIXNOub7EIImxS0A
 ckjwSptHWkK9Ke5N1wrWDn0TEgZxppxn5Y3vlr4dKMpxTwCaaYttC7s1Wy8B/F50xDaN
 o9jiD6AQ6zX55x7Z+RrqfAAycMXA8Ir2Qfl4VXaYoO0LOG+33I4PUBc4gOp93+LRqrF2
 ye8QpTbLou3aZp3gaDyq8ez1ty4D+XUhtFKUFyB+Nfof65x082nDFPFmT/SDJkoyiY4J
 wa0Zjg6/ixBdMA4knxOlQPNiLoHVOadVzJQliOXJ9IA9Iw1nvpWvmlT+Aq+2hIWbngUa
 wS9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxs3VPlvmSz3ls/2klLjiY1wM7NGr/ZngrLyDKUDpItjebPWvmNLSfxdcTkgKFFRFkJl5mD2LEFeNY8PhmKc7mnKWhvg==
X-Gm-Message-State: AOJu0Yx2z71A/OdMq/q6IzVz4d0UayN+etSIZ0Ox6jr1osOwvCiUSpMF
 U5QLr8DjVo8rxnwHkw29vceR5b+KO+2pimIo8jHughrvayy4sg+CoF7RthyvMoY=
X-Google-Smtp-Source: AGHT+IHE9vnJXUeSB2e/jwH7qZu1aR4MsUujXIuUH6sVLa+j96ps+HoDz1AFlXKbEufkzWysMs1soQ==
X-Received: by 2002:a0c:efc1:0:b0:6a0:4023:2e4c with SMTP id
 a1-20020a0cefc1000000b006a040232e4cmr4538873qvt.24.1713369892520; 
 Wed, 17 Apr 2024 09:04:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 v13-20020a0cc60d000000b0069b75b8633dsm4039899qvi.67.2024.04.17.09.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 09:04:51 -0700 (PDT)
Date: Wed, 17 Apr 2024 10:04:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, afd@ti.com,
 vigneshr@ti.com, dannenberg@ti.com, srk@ti.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, joe.hershberger@ni.com,
 simon.k.r.goldschmidt@gmail.com, sjg@chromium.org, marex@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240417160446.GF1054907@bill-the-cat>
References: <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
 <20240411220741.GJ2493117@bill-the-cat>
 <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
 <20240416170027.GQ1054907@bill-the-cat>
 <97f84067-ba36-47f6-befa-221be47a1d25@ti.com>
 <CADg8p97udLbFvbZ_FZf9Hfwg3R4=YJMNWrAtqvu97mL7vVYREQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FsH+zbFiW2y8cq66"
Content-Disposition: inline
In-Reply-To: <CADg8p97udLbFvbZ_FZf9Hfwg3R4=YJMNWrAtqvu97mL7vVYREQ@mail.gmail.com>
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


--FsH+zbFiW2y8cq66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 05:48:31PM +0530, Sughosh Ganu wrote:
> hi Chintan,
>=20
> On Wed, 17 Apr 2024 at 13:21, Chintan Vankar <c-vankar@ti.com> wrote:
> >
> >
> >
> > On 16/04/24 22:30, Tom Rini wrote:
> > > On Tue, Apr 16, 2024 at 05:52:58PM +0530, Chintan Vankar wrote:
> > >>
> > >>
> > >> On 12/04/24 03:37, Tom Rini wrote:
> > >>> On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrote:
> > >>>>
> > >>>>
> > >>>> On 22/01/24 10:11, Siddharth Vadapalli wrote:
> > >>>>>
> > >>>>>
> > >>>>> On 20/01/24 22:11, Tom Rini wrote:
> > >>>>>> On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wr=
ote:
> > >>>>>>> Hello Tom,
> > >>>>>>>
> > >>>>>>> On 12/01/24 18:56, Tom Rini wrote:
> > >>>>>
> > >>>>> ...
> > >>>>>
> > >>>>>>>> The list of conditionals in common/spl/spl.c::board_init_r() s=
hould be
> > >>>>>>>> updated and probably use SPL_NET as the option to check for.
> > >>>>>>>
> > >>>>>>> Thank you for reviewing the patch and pointing this out. I wasn=
't aware of it. I
> > >>>>>>> assume that you are referring to the following change:
> > >>>>>>>
> > >>>>>>>            if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENAB=
LED(HANDOFF) ||
> > >>>>>>> -           IS_ENABLED(CONFIG_SPL_ATF))
> > >>>>>>> +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL=
_NET))
> > >>>>>>>                    dram_init_banksize();
> > >>>>>>>
> > >>>>>>> I shall replace the current patch with the above change in the =
v2 series. Since
> > >>>>>>> this is in the common section, is there a generic reason I coul=
d provide in the
> > >>>>>>> commit message rather than the existing commit message which se=
ems to be board
> > >>>>>>> specific? Also, I hope that the above change will not cause reg=
ressions for
> > >>>>>>> other non-TI devices. Please let me know.
> > >>>>>>
> > >>>>>> Yes, that's the area, and just note that networking also require=
s the
> > >>>>>> DDR to be initialized.
> > >>>>>>
> > >>>>>
> > >>>>> Thank you for confirming and providing your suggestion for the co=
ntents of the
> > >>>>> commit message.
> > >>>>>
> > >>>> Following Tom's Suggestion of adding CONFIG_SPL_NET in common/spl/=
spl.c
> > >>>> "dram_init_banksize()", the issue of fetching a file at SPL stage =
seemed
> > >>>> to be fixed. However the commit "ba20b2443c29", which sets gd->ram=
_top
> > >>>> for the very first time in "spl_enable_cache()" results in
> > >>>> "arch_lmb_reserve()" function reserving memory region from Stack p=
ointer
> > >>>> at "0x81FFB820" to gd->ram_top pointing to "0x100000000". Previous=
ly
> > >>>> when gd->ram_top was zero "arch_lmb_reserve()" was noop. Now using=
 TFTP
> > >>>> to fetch U-Boot image at SPL stage results in "tftp_init_load_addr=
()"
> > >>>> function call that invokes "arch_lmb_reserve()" function, which re=
serves
> > >>>> entire memory starting from Stack Pointer to gd->ram_top leaving no
> > >>>> space to load U-Boot image via TFTP since TFTP loads files at pre
> > >>>> configured memory address at "0x82000000".
> > >>>>
> > >>>> As a workaround for this issue, one solution we can propose is to
> > >>>> disable the checks "lmb_get_free_size()" at SPL and U-Boot stage. =
For
> > >>>> that we can define a new config option for LMB reserve checks as
> > >>>> "SPL_LMB". This config will be enable by default for the backword
> > >>>> compatibility and disable for our use case at SPL and U-Boot stage.
> > >>>
> > >>> The problem here is that we need LMB for booting an OS, which is
> > >>> something we'll want in SPL in non-cortex-R cases too, which means =
this
> > >>> platform, so that's a no-go. I think you need to dig harder and see=
 if
> > >>> you can correct the logic somewhere so that we don't over reserve?
> > >>>
> > >> Since this issue is due to function call "lmb_init_and_reserve()"
> > >> function invoked from "tftp_init_load_addr()" function. This function
> > >> is defined by Simon in commit "a156c47e39ad", which fixes
> > >> "CVE-2018-18439" to prevent overwriting reserved memory. Simon, can =
you
> > >> explain why do we need to call "lmb_init_and_reserve()" function her=
e ?
> > >
> > > This is indeed a tricky area which is why Sughosh is looking in to
> > > trying to re-work the LMB mechanic and we've had a few long threads
> > > about it as well.
> > >
> > > I've honestly forgotten the use case you have here, can you please
> > > remind us?
> > >
> > We are trying to boot AM62x using Ethernet for which we need to load
> > binary files at SPL and U-Boot stage using TFTP. To store the file we
> > need a free memory in RAM, specifically we are storing these files at
> > 0x82000000. But we are facing an issue while loading the file since
> > the memory area having an address 0x82000000 is reserved due to
> > "lmb_init_and_reserve()" function call. This function is called in
> > "tftp_init_load_addr()" function which is getting called exactly before
> > we are trying to get the free memory area by calling
> > "lmb_get_free_size()".
>=20
> I have no idea about your platform but I was wondering if there is any
> particular importance of the load address of 0x82000000? It looks as
> though the current location of the SP when arch_lmb_reserve() gets
> called means that the load address is getting reserved for the U-Boot
> image. Do you not have the option of loading the image at a lower
> address instead?

Or using a higher address for SPL stack? You might be able to solve this
just by re-examining which addresses (and RAM size limitations) need to
be considered here.

--=20
Tom

--FsH+zbFiW2y8cq66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYf8xsACgkQFHw5/5Y0
tyxq/Qv/b5QV+wQM07cN8CDIG6p+11WhUh9ekj1mrvvrd41crP/Zv/tD9OJqCoXW
GhE9/iYbot0Fdee46jIXSqUx1SEUjkb6RLAKfnQTql09tmY5tQNqzw/Fjvkak7IJ
JisPq1GOmDYjevflx0ceOhgB8Dvc4Ioo7VsNSfS5xG9ecRneZeJ/3LUzSyVtOqp0
a+oG10rWGEwq+y8sJol3ErtdQ1njepHUKsoh2wVI5FsTpKyEoQady2WrjPrDo1nS
k50yP2eE6hkujMFcVnFV9zTofLS/eTXRFII6HXETwmVkLTuT7TYmA3FmlnqRoKso
dmSMCJ92uIZX1uOZW86wXvkoCpaqWt3nKmzFOFB6ZqajBUOEnmP5rb1lUtmgQY7I
/FcC3VaNGo0klF/6sVIZ+rI8A15yBmkYdO+4Iyk6auH4CBztNXkd3eQohbHdVKmh
AK9AXN5UTVhyhx2X1JP9Lof5D5oocW2GnHln22OMdjdKOXORcEHObbY8QD74Xzs3
DN7m3yHL
=cYBb
-----END PGP SIGNATURE-----

--FsH+zbFiW2y8cq66--
