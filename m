Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C10C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C50DC8653D;
	Thu, 24 Aug 2023 16:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tBOdV3Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18C1865AD; Thu, 24 Aug 2023 16:44:05 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B73A8077D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59234aaca15so40288127b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692888241; x=1693493041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OZfuQmUaemgj1YsA9ESz7xStgT43u+adgMjQJ+1NMbw=;
 b=tBOdV3CcyLjt23mQxDoagN8BqAQuuLl20R/l5ICgXrdei4MVwF4U3IYqfK30l8AYVx
 XdX3fQhvYqeKQKtBDECt8VOcdrbCYBcnp2EslS8eKuaZDbBW4DCYf8dW2acuBkG/jvuQ
 MU+1s03u0LiVzp58aR8pGDEvpgYy23lOJknTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888241; x=1693493041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZfuQmUaemgj1YsA9ESz7xStgT43u+adgMjQJ+1NMbw=;
 b=jxQVuYDWSbBQUFhkZmNfNsazfUb4ka6GrmmsNk7opGi/ZSQ9dx7xZS5c1P8hO7x4/P
 xzQUjoLLVMm9l0KAI8wWNx8KnVXu/J+oLWR5DxAIHK5k+a6y5DpSrDrEC/StsleLuIFg
 BOTOaMeRhjYlm2SttoUER/kWST+qmUu8QSBanktj5q9Wwfo7cKGNwDxiPGGOTy6dx4So
 rG8HY/6j6r1IpPHMCSQwJcMWKgKpbguG5gf7/O51XgceJXPZXBxeXVUOCWCgyY10xXzU
 sygysDqoq+QazVEypFeFHzSePTuPhW9mVX20xYdo0id8u7mqAaJu10qSPriiV1ErMoTv
 UiEg==
X-Gm-Message-State: AOJu0YwNLepD71nqeq+ruzFXfbIEOfl4+B6fbGv/FAjrXk4ZpV+yEO74
 1hH0clcHz2DvxsPPJY+M8u59Cg==
X-Google-Smtp-Source: AGHT+IHRMogheqoOfI5iSRsaK8Y/PSlnj4lzKbTKs/GUJ9hDK7gcGr84vEZ0gOdSUt6V/1f/wr2+Ww==
X-Received: by 2002:a0d:c243:0:b0:589:f883:c8f1 with SMTP id
 e64-20020a0dc243000000b00589f883c8f1mr15766786ywd.37.1692888241184; 
 Thu, 24 Aug 2023 07:44:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a0dfd02000000b005837633d9cbsm3911919ywf.64.2023.08.24.07.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:44:00 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:43:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230824144358.GO3953269@bill-the-cat>
References: <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
 <a3af68c4-490d-f3e2-a9ed-acd650ac0452@ti.com>
 <20230824142050.GL3953269@bill-the-cat>
 <CAPnjgZ23_aCG6XqJBwnVkrm3kcuwkz=-geQTX5BbX9rP+w49fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PYZjw5PHSEGg5zxp"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ23_aCG6XqJBwnVkrm3kcuwkz=-geQTX5BbX9rP+w49fA@mail.gmail.com>
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


--PYZjw5PHSEGg5zxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 08:41:23AM -0600, Simon Glass wrote:
> Hi,
>=20
> On Thu, 24 Aug 2023 at 08:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 06:46:57PM +0530, Neha Malcom Francis wrote:
> > > Hi Simon, Nishanth
> > >
> > > On 24/08/23 08:57, Nishanth Menon wrote:
> > > > On 21:01-20230823, Simon Glass wrote:
> > > > > Hi Nishanth,
> > > > >
> > > > > On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
> > > > > >
> > > > > > On 17:57-20230823, Simon Glass wrote:
> > > > > > [...]
> > > > > > > > This is how we have a common bit of rST for how to build N =
boards,
> > > > > > > > without having to do a literal copy and paste N times.
> > > > > > >
> > > > > > > How about using this?
> > > > > > >
> > > > > > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext=
=2Ehtml#substitution-definitions
> > > > > >
> > > > > > I was not able to succeed with complex includes such as:
> > > > > > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x=
_sk.rst?plain=3D1#L89
> > > > > >
> > > > > > am62x complete build procedure defined once and reused in other=
 am62x
> > > > > > platforms.. But the am62x build procedure itself is reused from=
 common
> > > > > > k3 build steps.
> > > > >
> > > > > I followed through these instructions. I find the env vars quite
> > > > > confusing, since I don't really know what it is doing. It feels l=
ike a
> > > > > script:
> > > > >
> > > > > do $a $b $c
> > > > > do $f $e
> > > > >
> > > > > it is pretty hard to follow. I think it would be better to write
> > > > > everything out in full for each board, like rockchip does.
> > > >
> > > > Unfortunately, this is a few major steps that is repeated for
> > > > (currently):
> > > >     AM62x SK
> > > >     Toradex Verdin
> > > >     (pending: beagleplay - )
> > > >     (once all the dust clears up, hopefully phytec)
> > > >     SK-LP
> > > >     ....
> > > >
> > > > I have no reasonable way to offer to keep them all in sync.
> > > >     https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
> > > > is kind of why I went down this path.S
> > > >
> > > > >
> > > > > Some other minor feedback:
> > > > >
> > > > > - The 'make' lines should really have -j $(nproc) added
> > > >
> > > > Different styles of shells..
> > > >
> > > > > - The $ signs at the start of each command in the docs are a pain
> > > > > since it stops me copying the commands into the terminal - can you
> > > > > remove them?
> > > >
> > > > hehe.. "dont" let people blindly copy paste without understanding w=
hat is
> > > > going on argument?
> > > >
> > > > If folks are OK, I sure can send a different patch series for that.=
=2E (or
> > > > maybe motivate someone to do that instead of me ;))
> > > >
> > > >
> > > > > - It doesn't build for me:
> > > > >
> > > > >    BINMAN  .binman_stamp
> > > > > Image 'ti-dm' is missing external blobs and is non-functional: bl=
ob-ext
> > > > >
> > > > > /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_releas=
e_strip.xer5f):
> > > > >     Missing blob
> > > > >
> > > > > Some images are invalid
> > > > > make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files=
/Makefile:1115:
> > > > > .binman_stamp] Error 103
> > > > > make[1]: Leaving directory '/tmp/b/play'
> > > > > make: *** [Makefile:177: sub-make] Error 2
> > > >
> > > >
> > > > ^^ Neha: This is what I was complaining about.
> > > >
> > > > https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?high=
light=3Dam62#sources
> > > >
> > > > source: https://git.ti.com/git/processor-firmware/ti-linux-firmware=
=2Egit
> > > > is missing, we never used to break build previously binman converte=
d now does.
> > > >
> > > > I am wondering if I need to explicitly call out git clone instructi=
ons
> > > > out..
> > > >
> > >
> > > Right... this does seem to be a complaint that keeps coming up.
> > >
> > > Simon, my intention at the time of sending out the patch was that any=
one
> > > building the board should "not NOT" have the DM binary. The way we
> > > structured the filename was that it looks at BINMAN_INDIRS to find
> > > ti-dm/ipc_echo_testb_mcu1_0_release_strip.xer5f but I guess this is a
> > > confusing way to put it across. Maybe we should rework that. Or not t=
hrow an
> > > error at all when DM isn't found.
> >
> > Well, is DM required or not? If it's optional, we have flags to mark it
> > optional.  If it's required, we have flags for make and buildman to tell
> > binman "fake it".  I am wondering if we still have the ability to have a
> > more verbose "need it, can't find it" error message, and so that's where
> > it should say that you forgot to set BINMAN_INDIRS or clone the firmware
> > repository.
>=20
> If it is optional, use the 'optional' tag on the entry You will get a
> warning but not an error. At the moment it is saying that the image is
> non-functional, which is not good.

Yes, and I believe these are non-optional firmwares, so do we still have
the ability to produce a more specific and verbose error message?

--=20
Tom

--PYZjw5PHSEGg5zxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnbKgACgkQFHw5/5Y0
tyyN9Av+IW83l+HMCe1SMLF2ftB2+DPfT/006v7c2hJVBwNM5hNMX8SXX3GMs3Bg
4bxD739X1a4cafZSM8rXwIDqU/sxWLiNWBvCY2blITTlc9yVOjB22mmYC2EL7XFY
SrgGElAQCHO76/HrYeQWJ8756D7ZuZ0IznNsIXytptYjFqN/Q8+TlUm7nBJ4EuCe
2TX+5zV/lNhWyzxqblCQ4TI+cjlbbGdn3N63iw4iqrw93ECYstuGXpqpU8ViSzhJ
kt2ELFp4F2zUsLTNghTBrI/CoM2844o7TLuecN4r+vAf7sVK9HIKWwTLco9EOeKt
W991VUUpl1Y18ZgTaKvcbvCb87JD/4jnSFdbYU3XWoehVfMhDkbpgMfn1Xu7K92O
QjFLjD1xC05JVKNCdgI2jrQP0eL0XYG3tQ86cEIj8i7d909mQZY5xwRaDqI9xaL8
KmDKqJNh117DKfN6H6eYnJwvElHNBUXZRJOw19JiZ8t2XoBGIgvPqexBT0tCLGIu
iZoTEVAF
=llI4
-----END PGP SIGNATURE-----

--PYZjw5PHSEGg5zxp--
