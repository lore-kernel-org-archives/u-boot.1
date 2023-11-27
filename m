Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0431C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8678752B;
	Mon, 27 Nov 2023 11:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701079216;
	bh=bjCF/wQS8nA7Gv5XMpBwfAO4ZVR6X5iwhOsZeD+0LXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpiL5UVG8raw93zxFpeMj0dGzxdznLcrefKC2R6J3t1yVsuMX8+SyFi6zi+sdVQjG
	 /P5OAC9rW0lz8wG8HQLqXQrFVaRvnFbtZHNjLDWFMBsjcIaFpnRWZlmx7OjCvKMeql
	 D9qnJ9fZpNE5RCYedQbfItPMvc3UHbL698mDIOTedqoW00tgbhh705Pg1ns4bCsD/c
	 vtN3BZ0/PExlalpSq45kLmTM8jHylDEx2815iBAWcrH6ngzlL9K/6ZT94w1jF5dpLT
	 aAFhnvGLSWGLN4zl4cMN8UmQObRfd45D3igKIkmeem2WdpyOQjuBR/M8ufOp7qFqKJ
	 6exHC7xYkOhBA==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 82E438654D;
 Mon, 27 Nov 2023 11:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701079214;
 bh=bjCF/wQS8nA7Gv5XMpBwfAO4ZVR6X5iwhOsZeD+0LXE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EB9AXnHtDEHi9BsNQdN/zN69c/QUNmthRGl1gLedD+eOUdKQ9k64idpHEw5NfrKVg
 ng6MFAFoWSpb0As4kFkYlKDU9jHlWso4hnilrxeKMiyfAPqFGvR0zqZ+NfUBWFkDdu
 nNOe+Oxxp49OciGb6GUu62+4seCKZckn8TtgJnSgrBW3KCUZL9PS67hB6xC1hmv/mK
 dm29VLqftRBP+CwU/Q3qPo6sqRsonuI2AWpli5tNnlDp8sIR35wRKus7TCdfuHlJVc
 gq2AYlcvf9T9c0BQESoLinU+iQ48fElj31DEVusELdwkGNixOwYxLXlC1Phrq1+33L
 92xTRIhviU6fQ==
Date: Mon, 27 Nov 2023 11:00:08 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Marek =?UTF-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 tharvey@gateworks.com, marek.behun@nic.cz
Subject: Re: [PATCH] net: mv88e6xxx: add missing SMI address init
Message-ID: <20231127110008.1f1114ee@wsk>
In-Reply-To: <25ix2yb4s6tkydcl6ollfckxxklmybz6sgvyvpfacrcrxemqpn@4cjkqymjfmpe>
References: <4t2ccomf4epfozf2o5uzkp7c5lzzqhgkfpcfofojomssmzh5kw@76ljhmdjzla4>
 <20231122163841.09d1c6e8@wsk>
 <25ix2yb4s6tkydcl6ollfckxxklmybz6sgvyvpfacrcrxemqpn@4cjkqymjfmpe>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mt9yWxankgL4jqCQCs.d5jP";
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

--Sig_/mt9yWxankgL4jqCQCs.d5jP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marek,

> On Wed, Nov 22, 2023 at 04:38:41PM +0100, Lukasz Majewski wrote:
> > Hi Marek,
> >  =20
> > > Driver does not currently initialize the smi_addr field, but
> > > instead keeps the default value. This leads to issues on systems
> > > with different hardware configuration. We can fix this problem by
> > > reading the SMI address from device tree.
> > >=20
> > > Signed-off-by: Marek Moj=C3=ADk <marek.mojik@nic.cz>
> > > ---
> > >  drivers/net/mv88e6xxx.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> > > index c073f81e72..4636dbf156 100644
> > > --- a/drivers/net/mv88e6xxx.c
> > > +++ b/drivers/net/mv88e6xxx.c
> > > @@ -753,6 +753,12 @@ static int mv88e6xxx_probe(struct udevice
> > > *dev) return -ENODEV;
> > >  	}
> > > =20
> > > +	priv->smi_addr =3D dev_read_addr(dev);
> > > +	if (priv->smi_addr =3D=3D FDT_ADDR_T_NONE) {
> > > +		dev_err(dev, "Invalid or missing SMI address\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >  	/* probe internal mdio bus */
> > >  	ret =3D mv88e6xxx_probe_mdio(dev);
> > >  	if (ret) =20
> >=20
> > I've posted some time ago patches for this driver:
> >=20
> > https://patchwork.ozlabs.org/project/uboot/cover/20230601100005.2216345=
-1-lukma@denx.de/
> >=20
> > Unfortunately, those were not pulled...
> >=20
> > Maybe you would find fix for your issue, or prepare new version of
> > it? =20
>=20
> I looked at your patches, but they don't fix the issue with smi_addr
> initialization. But i may try preparing a new version for them in
> future.
>=20

No problem. I just wanted to share some insights. Moreover, I've also
posted some patches to the Linux kernel driver for this chip family.

> Regards,
> Marek




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/mt9yWxankgL4jqCQCs.d5jP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmVkaKgACgkQAR8vZIA0
zr2Pgwf/ZuJTPSGGMBLsjR4UQdsUp7TR8r9JPpH9F+NsPMg+xtUjlPR0QnQkvowl
3pUHkDMh/9zmrmcfg68zrBp6H/0v1ZS3OZkNb2C7We27LPgQsMm1gwAWu8hXsich
1qE8Hf+8q0jKFn8g7+tLq3tC/oGZp0VraABbtPAztt3eaSSSs72jypnxkgX5sFB0
fu/dz7BoIkXMmIIm83T0yRRIuUCotiT4Axpi2q4KXjDMYuUBez2fWp7GOG2TVFM6
Vs5fPD+7gm/onblWUJdkrGxKYZiYSy+85Vhr9vEaTaonLXNbWIxUztSJeVIdTnaD
zwbc14EU+RDlhPaNhOnlD8YG9dC3hw==
=RcOm
-----END PGP SIGNATURE-----

--Sig_/mt9yWxankgL4jqCQCs.d5jP--
