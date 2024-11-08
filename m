Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72CDD64061
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4161B891E3;
	Fri,  8 Nov 2024 17:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731082906;
	bh=ELBKNsinwE1b/BgYo2kl9Vp+bmrhjTNBXP4bdE82vNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ej1UsMI2exZVOayBRjJrCiY25z7wuFDcEci9t1gnQ5r/9dWIksnltfyOa0WTio3Vg
	 XPfqAHdQ+LO0NLk0bTD+6OQAPVgdebj9FhHrNYO3R7n6ywjbD8XUbol35IpXDwLWmU
	 bmII3a/8V2eGgPfzig9+dAVLoyR4KF3XtjFYrf8votUjwvBbENkaC1rvYrp5R/gdLX
	 /2b2QjtOyqJp5tP86VMavY/z9X25OLVE93nR029W1+3yL8vPylwI0SL7eS8lA+ACwh
	 4I0nGNY1Koia+AkFTAeOUqPMb3cLC+wB0qV6cA3E1aB1EnToEid3ZIrjpuw1j9KIFI
	 hMmKnEOi+p5Kw==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5DC2B88AAC;
 Fri,  8 Nov 2024 17:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731082905;
 bh=ELBKNsinwE1b/BgYo2kl9Vp+bmrhjTNBXP4bdE82vNI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WNUrOIbiDcNZEURBXIGBSFj5a/d7Bwjhv6G9qgjf74v4tivtj7sFWz1gLU+1jfZRK
 oQwOnhydixCbHkAjN6IKVJWuAIugOStR/YLeofvbaOcQBT/9CQ1wXa1W589QVqfNme
 dJtdxc309cdlEvBqTw92Hrnmu6ttPx5OR+ShLjxDX2vdPGCzxxQf1tuMWh1H1urO39
 87phmCji7vYBgjT7SUvy+br+gcwX+nj+dMul1FZGYc2yuWIe4UOfY2jYu9HAtv38Zw
 v77ffZzH361q41UTwRS4DmpLJBVu8QWaIf6TiGRhYhXL/0tJHIpL0OinsHOAmtzOsm
 J3FcLeAqN0A0g==
Date: Fri, 8 Nov 2024 17:21:43 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Andrejs Cainikovs
 <andrejs.cainikovs@toradex.com>, Angus Ainslie <angus@akkea.ca>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, Stefan
 Eichenberger <stefan.eichenberger@toradex.com>, Stefano Babic
 <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: Re: [PATCH 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
Message-ID: <20241108172143.77f0e267@wsk>
In-Reply-To: <bf90d794-7b70-4e9a-ae79-fd9297f2a0fc@denx.de>
References: <20240423183247.335791-1-marex@denx.de>
 <20240423183247.335791-3-marex@denx.de>
 <CAHCN7x+Moru3HsU8VUZ5z53ix2s09qG0UpwgYeh9dPEC81s3uw@mail.gmail.com>
 <bf90d794-7b70-4e9a-ae79-fd9297f2a0fc@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JcRZKdV47CFdsmrP9K7Egm6";
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

--Sig_/JcRZKdV47CFdsmrP9K7Egm6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marek, Adam

> On 11/7/24 2:55 AM, Adam Ford wrote:
> > On Tue, Apr 23, 2024 at 1:33=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te: =20
> >>
> >> Rework the flash.bin image generation such that it uses the new
> >> binman nxp_imx8mimage etype. This way, the flash.bin is assembled
> >> in correct order using plain binman, without any workarounds or
> >> sections assembled in special DT node order.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> --- =20
> >=20
> > This introduced a regression on the 8M Nano with
> > CONFIG_FSPI_CONF_HEADER set.  As is, the board doesn't appear to do
> > anything.
> >=20
> > Looking at the binary blob that is generated, the offset for the SPL
> > phase is missing, so SPL starts at 0x5c0 instead of 0x1000, but
> > adding offset =3D <0x1000> isn't sufficient.
> >=20
> > Adding the offset =3D <0x1000>  starts the SPL phase, but it hangs
> > right away and doesn't past the version message:
> > U-Boot SPL 2024.07-rc1-00155-g37e50627ef-dirty (Nov 06 2024 -
> > 19:16:52 -0600)
> >=20
> > <hangs here>
> >=20
> > I have only tested this on a Nano, but I think the issue would
> > likely affect Plus since their boot ROM is similar.  I currently
> > don't have a Mini in my possession right now, so I cannot verify
> > the behavior on it. =20
>=20
> I think Lukasz was able to reproduce it on Mini. I have a few Mini
> here, but none of them use FSPI.
>=20
> iMX8MP never supported FSPI ?
>=20
> >  From what I can tell, reverting this patch appears to restore boot
> > operation.   I don't know enough about the mkimage tool, but I have
> > tried changing  nxp,boot-from and that doesn't seem to fix it
> > either.
> >=20
> > When I diff the binaries, it looks like a fairly significant about
> > of the values have changed, but the various magic numbers and offets
> > appear correct.  This makes me wonder if setting the offsets being
> > passed to mkimage are getting in the way.
> >=20
> > If remove the references to  CONFIG_FSPI_CONF_HEADER in the device
> > tree, a regular image is built.  I then use dd to create a new file
> > which has the FSPI header at 0x400, and moves the beginning of the
> > rest of the image to 0x1000.  This process boots the board just
> > fine. This leads me to believe that something in the imx8 mkimage
> > tool is doing something different when fspi is enabled. =20
>=20
> [...]
>=20
> > I'd like to rework the binman to build a standard flash.bin without
> > the Flexspi stuff, then create a second file like fspi.bin (or
> > something similar) which inserts the FSPI header at 0x400 and then
> > just places the entirely of flash.bin contents placed at 0x1000 in a
> > way that doesn't pass these offsets to imx8 mkimage tool. =20
>=20
> That looks like a workaround . It would be much better if binman
> would generate suitable flash.bin blob with FSPI header. Maybe the
> FSPI header needs to be generated by binman using yet another etype,
> and the SPL/U-Boot have to be positioned properly according to the
> binman node content in imx8mm-u-boot.dtsi ?
>=20
> (I also have hard time with binman tool)

I've managed to nail down which offsets are shifted by 0x1000. The
"only" only problem is to add this "fix" to binman... :)

Please refer to below discussion/link:
https://lore.kernel.org/all/CAFLszTh65OkyXnG3L7XTJFK69EYdj4DZwYGxizu4877n-m=
Cw-w@mail.gmail.com/T/


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/JcRZKdV47CFdsmrP9K7Egm6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcuOpcACgkQAR8vZIA0
zr07wQf/WENGRbkFFDzo2D/R+WF4s/twhF0BbO2QTWtRj+ITBNpb0BCsWgvvC94d
VhJxejcgzhiohOC5JV9+QlBBEIt+4ttIFtCIBfwF1PCtgTBfITIm8SytA9mO2agQ
dVPfI/T8TR3CersIXkCPdJ5/zC5ix9D0i2FllsMxpFhMJeSkaiNYyT1HJTFVTIxm
Y8RTepXApQIh5qS5as5zRSQW8nQvqjBOdK0PqZJ8EoXb7kQA2eH9PdDKQTSpow9A
/7F7pk/KH0USGxpW5we64XyLOZLQjcxC30Qhg7cFs1KzjQrBh5pVkCGjTSZc8fvW
BWw95J4yKvqRlCiVWw+gR/OOB30L8Q==
=P4/o
-----END PGP SIGNATURE-----

--Sig_/JcRZKdV47CFdsmrP9K7Egm6--
