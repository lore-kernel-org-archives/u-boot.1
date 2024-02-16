Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E58C48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 13:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 706F287E4D;
	Fri, 16 Feb 2024 14:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sr6keoVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF5787E4F; Fri, 16 Feb 2024 14:19:13 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EDD98718A
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 14:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-607ec539525so12373817b3.0
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708089548; x=1708694348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H7qtNFRgLJEzf66qxJonL+utTsWIihAdurCOfzX1ubs=;
 b=Sr6keoVX2XOIm794CZOlrPVmATCA1hAoJQ0+zICjVYlFjZ2L0ZPPF/PC2Yx1xELkcT
 PZuaMGCUpCikV3GiH4zvPOcKoEAPK0ycrgzXt/DXuVeHtRxp7Me4vLHdFEwSwWBQuPWI
 SkZ84GnJCs0B+CBobAkezmaKnx+PvNBrBOuOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089548; x=1708694348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7qtNFRgLJEzf66qxJonL+utTsWIihAdurCOfzX1ubs=;
 b=CE+nvE4UjN3+N1/xFvt8AlVgYC1Vj4uSy2ewku91YW6klcMnAry29QZvwmzhvmgzO6
 6hp0DMJk6fntaUq8Zio6OaB4cj1FNbdn1PhkZlfRgJZR95T4sqvPUXJABLdu8pUtm15q
 19XjeHduhihoJSP0jtS8MXwpHZbaHUWp7Qr6FjO9Dm0KlELkhSYxPQx6k6FW9whtHDZT
 RrwBAkl0mkrw1QC2dMnEotmE4fhEjOmeZNqfKHHz3Cxiu1Wg9s7GRIIYukL5b0QQCSSm
 WVS+OsXayXu8ehmZDvi7h+mk6uwbmmCltLS8ja7T/5OJE/n2a4yEXFaX3S8gb8OXBF6F
 jzOw==
X-Gm-Message-State: AOJu0Yzbk3gvJyz+JLV00ERMNobkQkuWQUk1HaNsfWDublfqsqHwRMYi
 m27QF4cRp3G1amSYwFVilDOaYvSu5hhZm2Lvz5IslFUh8fEWJ7g1qWTnzhL7XEU=
X-Google-Smtp-Source: AGHT+IEmshBMqnuMNEUtoMm9M5aWZ9JIf4217fb/2GXNcq9FMTdeLCS4pUhPiTnq6gvBwnt5RAnEhQ==
X-Received: by 2002:a81:92cb:0:b0:607:eed3:510d with SMTP id
 j194-20020a8192cb000000b00607eed3510dmr3071239ywg.29.1708089548084; 
 Fri, 16 Feb 2024 05:19:08 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 e185-20020a0dc2c2000000b00607e72b478csm337390ywd.133.2024.02.16.05.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:19:07 -0800 (PST)
Date: Fri, 16 Feb 2024 08:19:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH 1/2] doc: Update our clang documentation to reflect
 current status
Message-ID: <20240216131905.GI3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <016b8379-08aa-4e72-bcde-33b17c5a2d35@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z/WoP6gc4UNgIutV"
Content-Disposition: inline
In-Reply-To: <016b8379-08aa-4e72-bcde-33b17c5a2d35@bp.renesas.com>
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


--z/WoP6gc4UNgIutV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:06:03AM +0000, Paul Barker wrote:
> On 15/02/2024 21:10, Tom Rini wrote:
> > First, since this document was written the biggest challenges at the
> > time are simply not applicable anymore. Second, we need to list the
> > challenges which are preventing more platforms from being able to be
> > built with Clang today.  Next, we update the general wording to be host
> > distribution agnostic. Finally, the section about xenguest_arm64 issues
> > is not present anymore.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Mark Kettenis <kettenis@openbsd.org>
> > This does leave the FreeBSD section unchanged and should likely be
> > looked at again by someone with a BSD build machine available.
> > ---
> >  doc/build/clang.rst | 85 +++++++++++----------------------------------
> >  1 file changed, 21 insertions(+), 64 deletions(-)
> >=20
> > diff --git a/doc/build/clang.rst b/doc/build/clang.rst
> > index 09bb988e9236..d8c554982567 100644
> > --- a/doc/build/clang.rst
> > +++ b/doc/build/clang.rst
> > @@ -1,34 +1,27 @@
> >  Building with Clang
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -The biggest problem when trying to compile U-Boot with Clang is that a=
lmost all
> > -archs rely on storing gd in a global register and the Clang 3.5 user m=
anual
> > -states: "Clang does not support global register variables; this is unl=
ikely to
> > -be implemented soon because it requires additional LLVM backend suppor=
t."
> > -
> > -The ARM backend can be instructed not to use the r9 and x18 registers =
using
> > --ffixed-r9 or -ffixed-x18 respectively. As global registers themselves=
 are not
> > -supported inline assembly is needed to get and set the r9 or x18 value=
=2E This
> > -leads to larger code then strictly necessary, but at least works.
> > -
> > -Debian based
> > -------------
> > -
> > -Required packages can be installed via apt, e.g.
> > -
> > -.. code-block:: bash
> > -
> > -    sudo apt-get install clang
> > -
> > -We make use of the CROSS_COMPILE variable to derive the build target w=
hich is
> > -passed as the --target parameter to clang.
> > -
> > -The CROSS_COMPILE variable further determines the paths to other build
> > -tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)a=
s'
> > -instead of the LLVM integrated assembler (IAS).
> > -
> > -Here is an example demonstrating building U-Boot for the Raspberry Pi 2
> > -using clang:
> > +In general terms, U-Boot support building with Clang as the C compiler=
 and
>=20
> s/support/supports/
>=20
> > +building and booting our "sandbox" target is part of CI.
>=20
> Are you saying that building the sandbox target with Clang then booting
> it is part of CI? I think this sentence needs re-wording to make it a
> little clearer.

It is so I'll reword this a bit more then, thanks.

--=20
Tom

--z/WoP6gc4UNgIutV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXPYMkACgkQFHw5/5Y0
tywYgwwAlVn/G9j1t4qrNMyJK3D/LPA39MI8GTP8h+UaSJc6l/tqEbPkvcsPDtNW
daT1EyjK79gTZS0HU6vTLci89Lbhqur0/HVa4y8K0qP1QszXfZh/2s+NFnIOuCGK
q4NzPrRYCv/YX+tDmc4ow21kmXY/Xhru/qPBmzw5YaX52huwfxUXHde4D3+201mX
R2nrRD7R2zqOyBbIhwyR8eGWRI8GPCdk9qDnFXnk9pL7BrtQaSbNIdSBLQpQrJa8
4lQyK64wmK9VoYYpAzzffbbFbZKV8NxDXAAiku+1NY6vR6l9ExaEwJMSMX5Wt5Ak
MMEQopN6TrA5Tqn9l2MiIEjjx1QLYjH4xnJL5PIGaz79zVBX9wwLlLVdlkmlxk1x
tcKhT/mBMWiDWLZqwKB94n+7UiglcKmOmSjXSNu2g/QZFYjl+DIuK8Gu1fbu2RzH
zEQJ9KFjWneN1CAMRguQ4KK6zFpbtv1Y98hiuBp8CqQEo+E5Swwx5jl9GYVvbDma
5qnD4h/B
=5S++
-----END PGP SIGNATURE-----

--z/WoP6gc4UNgIutV--
