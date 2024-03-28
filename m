Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D7EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92D988168;
	Thu, 28 Mar 2024 13:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711630524;
	bh=VYWF24pbWI//FhlVmKWKz8Eka52DpnfnWBW1PCoEWSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E261Y4E191D+9U9ukr1m70TvOSVP1WdMMHrPelcLAJpJsTHBSlBGQWfHV6OQeghYq
	 i9n99yZknSD5Oww09jvL6xOpI+PRS4TxzrWyOOEJ4Ouk3A8MotHbONPfk7IfhX/49X
	 jR7GzvRX0g23ntmmLa0OUSk+2wfFsu2s+WhOJZjF9t158i1sB+/XG4iHQojv8Oz3C0
	 JtRqci/gfiTOPUdO3NI8fB2gJd+zAqrnm/8gLXhYQSluZ+KBHqmaewtBSSASx/ywRT
	 /A+9GPgArK4h52LZ8Hr4e6sE2OQ+um3Mrmi3yHPXTa2BTnNXgDorPxXEOKQrsw3Zfs
	 nQy6mvpUnFxrA==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D35C188158;
 Thu, 28 Mar 2024 13:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711630523;
 bh=VYWF24pbWI//FhlVmKWKz8Eka52DpnfnWBW1PCoEWSQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=o6xdK15yc0OL/aPLnhtNtj+Q3ITAN6A9oiwbPk1rzb9brSKyJsDefFkPmng8oscWf
 jqP8cvXq9AIZwCG6M51moXcTIT2q9g7H49CcpBt+blyhBJIf93fE+olk8ErYvQ3SI8
 4ejfOyBvoJOZe8netFWxwlxbU7U4lw1HiPPByJADbOJHuuy5fC3EEsQSjVSzCqKM4J
 3zApCB5lA/Jj25a1x+wcy+m/6qewrJWi/VHvHa+QF65lJ39w4Oxz+7WfOc8KWKUdsC
 YQdWYud/M1+QzhaiJ3qCTDgzyPgqTMe6wpq+uxqBCikI5qgaUabQx8eiHRM2GB/FZC
 jljhdjIrNzroQ==
Date: Thu, 28 Mar 2024 13:55:22 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>
Subject: Re: Thoughts about U-boot binary size increase
Message-ID: <20240328135522.4a07002d@wsk>
In-Reply-To: <20240328121832.GL3442575@bill-the-cat>
References: <20240328102049.10108d5b@wsk>
 <20240328121832.GL3442575@bill-the-cat>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qkz/YI+T727=0ebTS=xeYAA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/Qkz/YI+T727=0ebTS=xeYAA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

> On Thu, Mar 28, 2024 at 10:20:49AM +0100, Lukasz Majewski wrote:
> > Dear Community,
> >=20
> > I'd like to share with you some thoughts about growth of u-boot's
> > binary size for SPL and u-boot proper.
> >=20
> > Board: XEA
> > SoC  : imx287 (still in active production)
> > Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).=20
> > 	 Board design constraints u-boot proper size to less than
> > ~448 KiB
> >=20
> >=20
> > When XEA was added (2019.07):
> > 	- u-boot.sb (SPL): 37 KiB
> > 	- u-boot.img 	 : 401 KiB
> >=20
> > Now (2024.04):
> > 	- u-boot.sb (SPL): 40 KiB
> > 	- u-boot.img 	 : 427 KiB
> >=20
> > (With a _lot_ of effort put to reduce the size)
> >=20
> > Hence, the question - would it be possible to take more concern
> > about the binary size growth?
> >=20
> > Maybe CI could catch patches, which enable by default some features
> > and the size is unintentionally increased?
> >=20
> > I'm open for any feedback and thoughts on "stopping" the binary size
> > increase. =20
>=20
> I think that's pretty amazingly small growth for nearly 5 years of bug
> fixes and feature enhancements that it's likely minor to make
> granular.

Those results are after using OF_PLATDATA in SPL and other tricks - like
compression of DTB in u-boot proper, so this caused some extra effort
to keep small.

> If LTO is not enabled on this platform=20

As Fabio pointed out - I shall check if LTO can be (safely) enabled for
imx287.

> you should be able
> to use buildman to give you a "bloat" list from v2019.07 to v2024.04
> and see if anything sticks out as being something that can be
> addressed. But that little growth seems pretty good to me at first
> glance.
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Qkz/YI+T727=0ebTS=xeYAA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYFaLoACgkQAR8vZIA0
zr2P9wf/QlV/Fw+JloU+3DRwM2S/5oW8JL7cNTnseM4toT1jYifI4SosCijAJyFe
pGNNgszCP6iLCxbWbIwnZ5+HBmhXesCLXrS6tPDTIZA+BzBE5pe7OuacwL9gB2RT
Rku62cw9INd0+0n/W5wvA81q9DvaiXXUBInV2QGQimfoSH9p93Oq195tJ5CJsWLs
hQ/Q798mdZYciURfH3/fi72e+A615YJHKxPL59SgbZDVODG0bnuz+UROA1tWjJ9r
s9H5WKhAAPRErCXYBoAv1aAtGjvjU1On6EF0plFh4X6g5Dl0gA6GlTlUDf6Edh5x
/sH+FhDZUGN64mmqCSKAxS9HOhUECA==
=usdv
-----END PGP SIGNATURE-----

--Sig_/Qkz/YI+T727=0ebTS=xeYAA--
