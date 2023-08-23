Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5EAEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B428645B;
	Wed, 23 Aug 2023 17:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ITE4hCRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD038645D; Wed, 23 Aug 2023 17:56:03 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C796886422
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5922380064bso32525127b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692806160; x=1693410960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F0yCl05F1nO67zAT5ywnWWFlbxkIpbCen9FLcdQ11kU=;
 b=ITE4hCRMnWrPL5GI5Al3yngfQV2n5T9bAzFa37Zo7TRwhyWJEU60fcRFKd2kZnA2KX
 oRi0uDUYwZRWGLsneHSjAJua5rq5QNBXekayyis5uC/En1fx7/rcjJucp3j774R/ulAz
 UPfG+y2U1ylvrLogJDxLrgq7VHvYLGIRSvdQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692806160; x=1693410960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0yCl05F1nO67zAT5ywnWWFlbxkIpbCen9FLcdQ11kU=;
 b=ClshkcSgUophtqrd/DXbl8C9OQf6svTh+K9944eATj0Jizgug21i7SzaSGPbzyQ9u9
 dDQou6I4F4qA4Oe6y5b6NalP2d0AGN7x99w6ClcQ498VkFgc8wzPlQ9j++GdiABZPDfo
 aBaJVkIowrz7em6sDfD5LiprI+aDakY6tgr5nCksIEDaD8YH4KSfSOpL7B3U9ruxfRQA
 /IXKVPqdH4dV2RkMzt9JnULaqkB0Btt/tuyNgLwtT6QRQOtek/+82BIDoqo2wbY16xsx
 WQ340qy54U8mCLz12COh3GDplYQMW59Uf3A91JcygxY1eUebASwGKaF8jt5IN9l0aZaW
 iKHw==
X-Gm-Message-State: AOJu0Yyr5H0L0gnatrAZEc47HiQAH1j8yOdVZUqDHAwbUALT5RRFcyku
 NWxA037ZfbSEaNPUh85Bq6kANg==
X-Google-Smtp-Source: AGHT+IHlyz8MFxx1p+i1wEyI8ba/oFIk+NUnJLxnvZ8OA6yBnP1yhU5PbwgwN75o7g3FIb8c5CTtaQ==
X-Received: by 2002:a0d:e502:0:b0:56d:330d:86e2 with SMTP id
 o2-20020a0de502000000b0056d330d86e2mr13072241ywe.28.1692806160438; 
 Wed, 23 Aug 2023 08:56:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a81df0a000000b00577044eb00esm3334391ywn.21.2023.08.23.08.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:55:59 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:55:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: Config fragments
Message-ID: <20230823155558.GM3953269@bill-the-cat>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/fdG/pHCUYh/VMwq"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
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


--/fdG/pHCUYh/VMwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:

> Hi,
>=20
> Up until 2023.04 it has been possible to build all the defconfigs but
> with 2023.07 that changed. Tom mentioned this to me recently.

I'm adding Svyatoslav who is the person that brought in all of the
config fragments that are going to be in v2023.07.

> Up until 2023.04 we can enumerate all the board configs that can be
> built. We can build any of them using a single name and a single
> defconfig. The boards.cfg file which buildman creates contains a full
> list of things that can be built.
>=20
> From 2023.07 this changes and we now have random .config files
> sprinkled about the place. I say random because they are not connected
> to anything. For example, here is

They aren't random.  They're, just for v2023.07, in configs/ and then
moving forward, they're in the board directory.  I would like to see
them in more places possibly, but that's not something I'm sure enough
on right now.

> board/ti/am62x/MAINTAINERS:
>
> AM62x BOARD
> M: Dave Gerlach <d-gerlach@ti.com>
> M: Tom Rini <trini@konsulko.com>
> S: Maintained
> F: board/ti/am62x/
> F: include/configs/am62x_evm.h
> F: configs/am62x_evm_r5_defconfig
> F: configs/am62x_evm_a53_defconfig
>=20
> BEAGLEPLAY BOARD
> M:     Nishanth Menon <nm@ti.com>
> M:     Robert Nelson <robertcnelson@gmail.com>
> M:     Tom Rini <trini@konsulko.com>
> S:     Maintained
> N:     beagleplay
>=20
> In most cases the MAINTAINERS file tells us about each board and until
> [1] I had assumed that was the case. With that patch reverted, these
> are the only 'orphaned' MAINTAINERS entries (buildman
> --maintainer-check):
>=20
> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> ending at line 8
> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending at =
line 44
> WARNING: orphaned defconfig in
> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at line=
 6
> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at line =
15
>=20
> But Tom advised me that MAINTAINERS is not intended for this purpose,
> so the check has been dropped. I am not suggesting we bring it back,
> necessarily, but if we did, we could use it to specify the .config and
> defconfig files which are used by each board.

Note that the "N" syntax has been in use, for defconfigs for a lot
longer, and is why the CI check for unmaintained / orphaned boards
stopped working.

> *Failing that*, I suggest a new 'name.brd' file in the board directory
> to contain this information, e.g.
>=20
> # Contents of board/ti/am62x/beagleplay.brd:
> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
>=20
> This could be parsed by buildman and other tools, to produce a list of
> available boards and to build each using a single name (e.g. make
> beagleplay-r5_defconfig)
>=20
> What do people think?

I'm not sure I like this direction honestly.  Do we want CI to cover
these configurations?  Maybe.  But it's just for CI.  Using the TI
examples, I don't know that you can use buildman today to generate a
functional binary (and if you can, if --keep will retain the right
files).

Maybe we just need to make it clear that if you use config fragments
then you're opting out of CI for that specific platform.  That should be
fine for example for the TI ones that will be built in OE a bunch
anyhow so accidental failure to builds will be caught.  I don't know
about the Tegra platforms.

--=20
Tom

--/fdG/pHCUYh/VMwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmLAgACgkQFHw5/5Y0
tyxWwAv8DZP7ypileqIdFN0UJYbzbC1o2F4BF2TJp43SSglX9wvOs8Kc3mG9+s/M
9G2OMoaK65UjbE9mmI0hStAjRCScmgt6lQXg1gticGvWSSfx2zz1wrbZ7uvbDCoq
NEHhpXpiXdpzW0B/x3NY4Scl80RjjQTHlR3RlE+SN3Wawj8O6AgompEBXCjwcq9E
2Ct+mch4ohgaJojNRCVU4qFOcBMs6WuWWhRU85oojST8vgElv06IqvMmiSJoI7Ra
/nQXRM9sjSaKGz2pOXAOYfxGjsc6MmwymfkkugHA7ZHiLa3TnWyht+UilFXqaysE
2is+WhF4Gv152azE5G3m4qZr0u8djgXLVeCj6hgP+WOcznwfa+wueasbdwuXIugb
oFdo//aQ+GejxN7HOqTxrdx2QRzHfBqJgNYUcH33W7KNBdNly3vU4nn1uMPt5iT6
M7JwZxoUUCxhsW/QeHfPlPB98j1tlsKdtDpVU+gG0XnLMS3LDsNfuE/X/h5BJJHv
p+O3w9/R
=VhLF
-----END PGP SIGNATURE-----

--/fdG/pHCUYh/VMwq--
