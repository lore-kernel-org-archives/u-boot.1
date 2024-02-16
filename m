Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192A1C48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 13:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103248780A;
	Fri, 16 Feb 2024 14:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="plSPaJcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4E68780A; Fri, 16 Feb 2024 14:20:13 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865968718A
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 14:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-60802b329c4so3490727b3.0
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 05:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708089598; x=1708694398; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=21DHrkd0gPTIM7IMYZsvfLH1rONQnhQcv+tZobwSfc4=;
 b=plSPaJcRYVnDF6pIY6hOdl1/OLs08amz297/SVx9CuHlkS6XnzRyE71SxITcU4f+Qd
 ur1BRgbNiKhirDJcm15Jcv3goTx03qWbk9orBJjVn9OkYBptDd3bPig231HZZzdqha9S
 YoVJcGR7C+m0b0lJ9UijejlNFnf5kcbtbOtw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089598; x=1708694398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21DHrkd0gPTIM7IMYZsvfLH1rONQnhQcv+tZobwSfc4=;
 b=qV9H0ioopwOivoDxfU2J9ji4MOlPUAK2tV7J20CmqAwtM2SjmwCoEx+VS7Eb9Ow57B
 OR0EDJGQy5HCYISC97o0PdDTd5xk2NQKulieYcB5kPH2Y2r0Ay0DjCXyGUHjskP2eGfO
 Sa4bubFhIoPgFNdospGGdDTFaySLn0XvFPFJZmU8tlKNA8LqgHEPkmdb1n6dSZNbuO/O
 5OZyajS+rpqjyRf2WIJ5DioWebY8P9xzVzzTmXvpiKPQAQEhyFZMdUv7BTZjcC9Dikt6
 0HXjXGlFKuIFYVXs+KmAwOz6rZUXrkJByMFr8sblew7UbEAhb8wNitsdi/Y/VnoofHii
 hH/A==
X-Gm-Message-State: AOJu0YxmUhDWbKnjw3GYP+HXCw1eawJV6rlv578INnAG2dzluXGJRNYI
 /3xUY1Kvqol5OOxZGMPPbce0lkuMe819fFbYcaW32ohyDYW7mz+3kxL2UVo9GmjInzZeXXvOerG
 f
X-Google-Smtp-Source: AGHT+IEU73j59UCeKtw1H8Frp1RU0dFVLUU6kDGwKvuYv/emJlKn7KOZ/MgE8R8tpJGl0zuhDxNFqQ==
X-Received: by 2002:a81:ac60:0:b0:607:d9f7:e883 with SMTP id
 z32-20020a81ac60000000b00607d9f7e883mr3752949ywj.14.1708089598225; 
 Fri, 16 Feb 2024 05:19:58 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d12-20020a0ddb0c000000b006078c48a26csm338189ywe.25.2024.02.16.05.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:19:57 -0800 (PST)
Date: Fri, 16 Feb 2024 08:19:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Message-ID: <20240216131956.GJ3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <626503f4-8109-44d1-b3c7-8e32e7b33f30@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E7yOXbKlVaiLmzGC"
Content-Disposition: inline
In-Reply-To: <626503f4-8109-44d1-b3c7-8e32e7b33f30@bp.renesas.com>
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


--E7yOXbKlVaiLmzGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:10:19AM +0000, Paul Barker wrote:
> On 15/02/2024 21:10, Tom Rini wrote:
> > The first big issue is that the "gcc" file talked a lot about the
> > general build requirements as well, but was titled in a gcc-centric
> > manner. Solve this by renaming the file to compile.rst and more fully
> > reflecting that it is general build instructions. Next, add a section
> > about the prebuilt toolchains that are recommended (as they are the ones
> > we use in CI), and update a few places to reference these vendor-neutral
> > tools.
> >=20
> > Next, we can include the reproducible builds section directly in the
> > compile instructions rather than as a small standalone file.
> >=20
> > Finally, we update the sandbox document to reflect both the name change
> > as well as what is specifically required to build sandbox.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  doc/arch/sandbox/sandbox.rst       |  5 ++-
> >  doc/build/{gcc.rst =3D> compile.rst} | 64 ++++++++++++++++++++++++++--=
--
> >  doc/build/index.rst                |  3 +-
> >  doc/build/reproducible.rst         | 27 -------------
> >  4 files changed, 61 insertions(+), 38 deletions(-)
> >  rename doc/build/{gcc.rst =3D> compile.rst} (73%)
> >  delete mode 100644 doc/build/reproducible.rst
> >=20
> > diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
> > index 5f8db126657f..f2ed5a25c115 100644
> > --- a/doc/arch/sandbox/sandbox.rst
> > +++ b/doc/arch/sandbox/sandbox.rst
> > @@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
> > =20
> >  Note that standalone/API support is not available at present.
> > =20
> > -
> >  Prerequisites
> >  -------------
> > =20
> > -Install the dependencies noted in :doc:`../../build/gcc`.
> > +In addition to the normal dependencies shows in the :doc:`general build
> > +instructions <../../build/compile>` to enable display support SDL2 lib=
raries
> > +need to be available.
>=20
> I find this a little unclear. Perhaps:
>=20
> To enable display support, SDL2 libraries need to be available in
> addition to the normal dependencies shown in the :doc:`general build
> instructions <../../build/compile>`.

The issue is that SDL2 is required by default, so I'll try and reword
this a bit more still, thanks.

--=20
Tom

--E7yOXbKlVaiLmzGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXPYPwACgkQFHw5/5Y0
tyzSpwwAoEUBcKV401UcZkRxWE2C8eYPpKP3eM7UccIj2PFuKvzAAssMzxhKRpYX
/GFkZkBTBVEb3+J7IKTiBO002tdRxDKiISYvSqrE2rikdMi0AxxS/WxwTwP3uzFv
SJttR1w2B8JhyqxcLU567YuRscPkgVFNttEidImvbdTAY+3iqZP7A6T48yZw3SD8
tz90doFBQQRV2HWsXWsGHXWDZh8WI5YQZaU1e1mUELECwKGwK505KyJvWaUhOm1K
94R6Fa4Ii67d96C9iaZWE7BhOwVbwgvF3x51ZJ6GY+vNy465PGKbm8DXCLbhYJyq
3D65KGYfX1pyVBRJ92t4Qi7eYDjNJSAsvopL5ajWAq4+MZ/mtiIZsWc7lPianjMy
VQi9EeF4o09d1zIExtjMhqntUeA9NWgJTpCED5Kr9T/U0id4ldwq/wOqeVTl1Mw+
OgQoGvPP5QPsEF7fZMnY1YyU/MEENNMG+xDkkvmv2viOPRjtPsbP2cgMVQiOiqBC
KW/SgPOW
=true
-----END PGP SIGNATURE-----

--E7yOXbKlVaiLmzGC--
