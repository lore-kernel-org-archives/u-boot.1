Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC07C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC2586519;
	Thu, 24 Aug 2023 16:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tTQU+0me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA37386529; Thu, 24 Aug 2023 16:20:57 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8570E864B4
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58dfe2d5b9aso13496217b3.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692886853; x=1693491653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ofN5TlA+Ll0pSdKxUa6Wr4Ahc+A/BjhCzNP+5vUN0PU=;
 b=tTQU+0meiwHWyXDF0EOv6v9SwFZ7Q41/OOzXK7Ynf77NHLMRZMWYVnb9xnL2q/pKMV
 Frypbvx399nBxMtt7e7AZPKjzaS7ZDvTBsmepDk6ApkUG3uXA/jjptnxtHbOMGcUYB5G
 eyRida3Y2phkgQDyyQ00Vuu6ECf41mIQ5+7sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692886853; x=1693491653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofN5TlA+Ll0pSdKxUa6Wr4Ahc+A/BjhCzNP+5vUN0PU=;
 b=Ayk7lLAxtVcQY2jnHwa7gTi0PzWGqSI9QzJifch9YGBvr1ykaFp/Q0fHu65oiM2Ix2
 FWbnBAB433pUJxeNsKmgjbnz6WP1NSyRFYFyFZhjj/wfaUUbE6leILHPtxK0Ot59knjH
 EJXLE2j3RxO2STYcHA+PPTBJCihchQLSkwQwkW7Vk8bkEoIHs4uJvlcg7AyL+PhDkxJZ
 mfU+9pPDVtaQYKTnRKgG3UfUVKi5F6AKPP2JciRvYZ95Vl6yyYVgsC09O9ygRhwqmLBF
 CWkLObQbd4gh3lVGnUWhi+PdOHhGKpA2m56pvel1/Y3s/lyk9LAaMPLeysEeRTOG4l0H
 QwdA==
X-Gm-Message-State: AOJu0Yx+k1iZ3iXMNw0CZW1jKvSg+itVoulWjxYRIdkO8lwMwaKwmo/y
 nTpan4PDzRAlQ5lttp0vbCTbrw==
X-Google-Smtp-Source: AGHT+IFfC6tTmFHHdbG2DYUJT+j+AqlNU43jmW7sVNn5C65zdso5JnX1hcldp7IWf4L57avUH7JsDg==
X-Received: by 2002:a0d:d415:0:b0:586:d468:f57e with SMTP id
 w21-20020a0dd415000000b00586d468f57emr15051220ywd.0.1692886853276; 
 Thu, 24 Aug 2023 07:20:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 n138-20020a0dcb90000000b0057a560a9832sm3940600ywd.1.2023.08.24.07.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:20:52 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:20:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230824142050.GL3953269@bill-the-cat>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
 <a3af68c4-490d-f3e2-a9ed-acd650ac0452@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lQAReNAjW4yq9cB4"
Content-Disposition: inline
In-Reply-To: <a3af68c4-490d-f3e2-a9ed-acd650ac0452@ti.com>
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


--lQAReNAjW4yq9cB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 06:46:57PM +0530, Neha Malcom Francis wrote:
> Hi Simon, Nishanth
>=20
> On 24/08/23 08:57, Nishanth Menon wrote:
> > On 21:01-20230823, Simon Glass wrote:
> > > Hi Nishanth,
> > >=20
> > > On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
> > > >=20
> > > > On 17:57-20230823, Simon Glass wrote:
> > > > [...]
> > > > > > This is how we have a common bit of rST for how to build N boar=
ds,
> > > > > > without having to do a literal copy and paste N times.
> > > > >=20
> > > > > How about using this?
> > > > >=20
> > > > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.htm=
l#substitution-definitions
> > > >=20
> > > > I was not able to succeed with complex includes such as:
> > > > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.=
rst?plain=3D1#L89
> > > >=20
> > > > am62x complete build procedure defined once and reused in other am6=
2x
> > > > platforms.. But the am62x build procedure itself is reused from com=
mon
> > > > k3 build steps.
> > >=20
> > > I followed through these instructions. I find the env vars quite
> > > confusing, since I don't really know what it is doing. It feels like a
> > > script:
> > >=20
> > > do $a $b $c
> > > do $f $e
> > >=20
> > > it is pretty hard to follow. I think it would be better to write
> > > everything out in full for each board, like rockchip does.
> >=20
> > Unfortunately, this is a few major steps that is repeated for
> > (currently):
> > 	AM62x SK
> > 	Toradex Verdin
> > 	(pending: beagleplay - )
> > 	(once all the dust clears up, hopefully phytec)
> > 	SK-LP
> > 	....
> >=20
> > I have no reasonable way to offer to keep them all in sync.
> > 	https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
> > is kind of why I went down this path.S
> >=20
> > >=20
> > > Some other minor feedback:
> > >=20
> > > - The 'make' lines should really have -j $(nproc) added
> >=20
> > Different styles of shells..
> >=20
> > > - The $ signs at the start of each command in the docs are a pain
> > > since it stops me copying the commands into the terminal - can you
> > > remove them?
> >=20
> > hehe.. "dont" let people blindly copy paste without understanding what =
is
> > going on argument?
> >=20
> > If folks are OK, I sure can send a different patch series for that.. (or
> > maybe motivate someone to do that instead of me ;))
> >=20
> >=20
> > > - It doesn't build for me:
> > >=20
> > >    BINMAN  .binman_stamp
> > > Image 'ti-dm' is missing external blobs and is non-functional: blob-e=
xt
> > >=20
> > > /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_st=
rip.xer5f):
> > >     Missing blob
> > >=20
> > > Some images are invalid
> > > make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Mak=
efile:1115:
> > > .binman_stamp] Error 103
> > > make[1]: Leaving directory '/tmp/b/play'
> > > make: *** [Makefile:177: sub-make] Error 2
> >=20
> >=20
> > ^^ Neha: This is what I was complaining about.
> >=20
> > https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highligh=
t=3Dam62#sources
> >=20
> > source: https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
> > is missing, we never used to break build previously binman converted no=
w does.
> >=20
> > I am wondering if I need to explicitly call out git clone instructions
> > out..
> >=20
>=20
> Right... this does seem to be a complaint that keeps coming up.
>=20
> Simon, my intention at the time of sending out the patch was that anyone
> building the board should "not NOT" have the DM binary. The way we
> structured the filename was that it looks at BINMAN_INDIRS to find
> ti-dm/ipc_echo_testb_mcu1_0_release_strip.xer5f but I guess this is a
> confusing way to put it across. Maybe we should rework that. Or not throw=
 an
> error at all when DM isn't found.

Well, is DM required or not? If it's optional, we have flags to mark it
optional.  If it's required, we have flags for make and buildman to tell
binman "fake it".  I am wondering if we still have the ability to have a
more verbose "need it, can't find it" error message, and so that's where
it should say that you forgot to set BINMAN_INDIRS or clone the firmware
repository.

--=20
Tom

--lQAReNAjW4yq9cB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnZ0IACgkQFHw5/5Y0
tyxSVAv9HRmAY0E1J/PvbBE64pVWlQEVSDYCH5yTpFB0vDR1l9p6T2/oo2EjpUKz
a33qY/3Zy2kSsa//ukvpQ9pKBvfMC2BLmP4SxWn8z0jpwmfEwdbajAYw29bSg/2u
wSTsyoc7veaoEOEUnMK/19x0EtQ9NDXGi7OdK20wC9q57xfGdgOl18Kb2nMsvnjZ
HX2ymUs8emMESdaAqhA2F2GB73dJyyxCH4zezb3khvO+4ItlVogX4NOxwiRKnQco
5nX9mL1NcSjyNGJD0FqEcJFgWFYcz8IFMNNhzvbX+s4Zzzabv6Ad+9efMWWNERpw
Hg68J0/zLrr1eLQQuZ+Sj3qgxJiIDPyWhhM6DnUQM12j2b1kBtmb0D9iZoOyj4jW
eLgSjSDKYKGrZrPtXrSXJNABeJXEPeAzmTyuaRVEd5jb2qtBMn1EL9mRkPsg1//o
erO2bq5XTOjMxb8ehYNtzzz6Fu9ULIpnhvmWWXHpjDEChes1pn6nPFFbqoj2j/DJ
7a1Qr86y
=OMTd
-----END PGP SIGNATURE-----

--lQAReNAjW4yq9cB4--
