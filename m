Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E82CC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 19:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92AC28033D;
	Thu, 16 Jan 2025 20:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jGzkXZXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A6C8069D; Thu, 16 Jan 2025 20:11:33 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA578022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 20:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6dce7263beaso13050786d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737054690; x=1737659490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OYhY+AWfLes6G1VKtV4dk0MLpUyD16C9VT2Q3huHPRo=;
 b=jGzkXZXErs5ADq0EcSdIZJroV2jyd6UijCxBc/fOYNXkL2CYl63sznwduyQZyMJLP9
 14o0+VpShwLomgh4UNr98ljV4hwnb7aONrtCg8lGPt2jSl7xz9s3mM56530U8Ew0Gutd
 LuI5egn8xwxpewUPjkznZdWHIRzbSYXVgek0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737054690; x=1737659490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYhY+AWfLes6G1VKtV4dk0MLpUyD16C9VT2Q3huHPRo=;
 b=d7c2Wp7pG7zQsDjoiHfZNd2PQYWu94G6Q3B54kRIHTnOVRIay9uG13pSqGFEaslz/J
 PlkL+EG/F2doBHcjlVIEpLciBXkxO7gtf8GN78w47xb9lL0JHYG/RoYxPn0Uh4gUjdEN
 sZbmHghHzCqxIbOA/pyZxm+S+zoSsvjetmsUASSSoWcPMaAtkRB1I/nzQkF8lz+MH+Tw
 7i7qYlNVRdRrxalBjSSUSYg+/0cFMsd9v2nrXptUlwkxD02QPkJqJ28sQX4xwPOubJMm
 6yRn8aMiH2EK9KMkvurlu9EcC3Fp1Uq39N++flFr5IhJ9BqjgUur6JxmpxVzRviEinLo
 esKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWagRE0Pfzgo8OpPo6Z2lGnjG0Kc9UcltQtwiCoGvDbBIzAX03cyrOyiNuuf2HrATdOphoOgTI=@lists.denx.de
X-Gm-Message-State: AOJu0YzR8LQiHJt8ufhMcTU0rF2T0wVq1x08jHds5yllD6Vj2sG4Gj76
 kbhUNQFDrBEnqMbMyJNIbuyGRj8vzL0OZoPJqy2sX00myZvUESa2OHhbiIiK02c=
X-Gm-Gg: ASbGnctP4MAWCFrr+qKV13zmoljCFRqmzWMiOFLpMvOkEkkN5sol0hQ/TiKWhbPL7DF
 IY4+XDohKShtyGup2Bc/ph934mNIdp4WJJdEEVHfPO4AIsWV3Vsfice5t6HrtefuN2JL7JfoxiT
 /hiNl4bXOd9U8FppEJQNTY/qKHrrDThEt5k53eYW/uTT4mBzcYZNkXpjWGUCJlhGcdo3aF9CqiR
 uhmr8l7mzk6XRMsLfOzVBJES/q3xe+pWCXdQxtxuMzA3FJXjMmHHg==
X-Google-Smtp-Source: AGHT+IFAB1PqRD6cGiu3KRHM2wbX0UPO9dDxCN+SJTnHHlOWCb28bMLVPi/JdXqkxjzqV0RKNAnjWA==
X-Received: by 2002:a05:6214:e83:b0:6d4:3437:d858 with SMTP id
 6a1803df08f44-6df9b22e404mr537372756d6.25.1737054690050; 
 Thu, 16 Jan 2025 11:11:30 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc0fd11sm2934956d6.37.2025.01.16.11.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 11:11:28 -0800 (PST)
Date: Thu, 16 Jan 2025 13:11:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, u-boot@lists.denx.de,
 kernel@salutedevices.com, rockosov@gmail.com
Subject: Re: [PATCH 3/3] common: fdt: hand over original fdt bootargs into
 board chosen handler
Message-ID: <20250116191125.GK3476@bill-the-cat>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
 <2d821f40-b52a-44f0-8dc1-5d9ec2992993@cherry.de>
 <yfy4lf54tndnnr4cfttfqngaklv5sg3ttwpycwu2on33vvjg2z@2ptnm3mjusfv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v59VY8NzP6FcNaAb"
Content-Disposition: inline
In-Reply-To: <yfy4lf54tndnnr4cfttfqngaklv5sg3ttwpycwu2on33vvjg2z@2ptnm3mjusfv>
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


--v59VY8NzP6FcNaAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 04:11:40PM +0300, Dmitry Rokosov wrote:
> Hello Quentin,
>=20
> On Tue, Jan 14, 2025 at 12:16:35PM +0100, Quentin Schulz wrote:
> > Hi Dmitry,
> >=20
> > On 12/19/24 10:42 PM, Dmitry Rokosov wrote:
> > > Sometimes, it is necessary to provide an additional bootargs string to
> > > the kernel command line.
> > >=20
> > > We have a real scenario where one U-Boot blob needs to boot several
> > > kernel images: the vendor-patched kernel image and the latest upstream
> > > kernel image. The Amlogic (Meson architecture) tty driver has differe=
nt
> > > tty suffixes in these kernels: the vendor uses 'ttySx', while the
> > > upstream implementation uses 'ttyAMLx'. The initial console setup is
> > > provided to the kernel using the kernel command line (bootargs). For =
the
> > > vendor kernel, we should use 'console=3DttyS0,115200', while for the
> > > upstream kernel, it must be 'console=3DttyAML0,115200'. This means we=
 have
> > > to use different command line strings depending on the kernel version.
> > >=20
> >=20
> > Can't you have both in bootargs to handle both versions of the kernel w=
ith
> > the same bootargs?
> >=20
>=20
> In this case, modifying the kernel source code is necessary, which falls
> outside the scope of this review.
>=20
> > > To resolve this issue, we cannot use the CMDLINE_EXTEND kernel
> > > configuration because it is considered legacy and is not supported for
> > > the arm64 architecture. CMDLINE_EXTEND is outdated primarily because =
we
> > > can provide additional command line strings through the
> > > 'chosen/bootargs' FDT node. However, U-Boot uses this node to inject =
the
> > > U-Boot bootargs environment variable content, which results in U-Boot
> > > silently overriding all data in the 'chosen/bootargs' node. While we =
do
> > > have the board_fdt_chosen_bootargs() board hook to address such issue=
s,
> > > this function lacks any FDT context, such as the original value of the
> > > 'chosen/bootargs' node.
> > >=20
> > > This patch introduces a read-only (RO) fdt_property argument to
> > > board_fdt_chosen_bootargs() to share the original 'chosen/bootargs' d=
ata
> > > with the board code. Consequently, the board developer can decide how=
 to
> > > handle this information for their board setup: whether to drop it or
> > > merge it with the bootargs environment.
> > >=20
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > ---
> > >   boot/fdt_support.c    | 5 +++--
> > >   include/fdt_support.h | 4 +++-
> > >   2 files changed, 6 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > > index 2c39b2dd14b7c447bc4c7c8fad64e22cb00e88e0..49efeec3681f7c97341cc=
dce596bcaa4e1f037eb 100644
> > > --- a/boot/fdt_support.c
> > > +++ b/boot/fdt_support.c
> > > @@ -321,7 +321,7 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
> > >    * board_fdt_chosen_bootargs - boards may override this function to=
 use
> > >    *                             alternative kernel command line argu=
ments
> > >    */
> > > -__weak const char *board_fdt_chosen_bootargs(void)
> > > +__weak const char *board_fdt_chosen_bootargs(const struct fdt_proper=
ty *fdt_ba)
> > >   {
> > >   	return env_get("bootargs");
> > >   }
> > > @@ -364,7 +364,8 @@ int fdt_chosen(void *fdt)
> > >   		}
> > >   	}
> > > -	str =3D board_fdt_chosen_bootargs();
> > > +	str =3D board_fdt_chosen_bootargs(fdt_get_property(fdt, nodeoffset,
> > > +							 "bootargs", NULL));
> > >   	if (str) {
> > >   		err =3D fdt_setprop(fdt, nodeoffset, "bootargs", str,
> > > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > > index f481881ce640797e0f6204d599f008d0e5dc2bf7..7731feba5f068f82c8ee2=
5f18a9f0e57729e2bd8 100644
> > > --- a/include/fdt_support.h
> > > +++ b/include/fdt_support.h
> > > @@ -231,12 +231,14 @@ int board_rng_seed(struct abuf *buf);
> > >   /**
> > >    * board_fdt_chosen_bootargs() - arbitrarily amend fdt kernel comma=
nd line
> > >    *
> > > + * @fdt_ba: FDT chosen/bootargs from the kernel image if available
> > > + *
> >=20
> > Missing leading /
> >=20
> > /chosen/bootargs
> >=20
> > +property
> > to highlight what this path refers to.
> >=20
>=20
> Agree with that, but looks like patch series is already applied...
> Sorry..

I saw that and made those changes in the merge commit.

--=20
Tom

--v59VY8NzP6FcNaAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJWdYACgkQFHw5/5Y0
tyy6qgv/YPK2uLzqneWdFA2exzh76RM1lq0WKu+X3bmB9zA8yLjMtEX22cD/CCUI
9jnuEihJ/fKnFHbUAgr1KvtnxPBXFEJZC+A71OzXKhjtJ095nvztQxjYeNoF9mp6
nypYff31z+IJSr8Dae+h71z3MeWJYdqM8ySdvKSpMzxdYC21xHUdD9FZFnhm+sNL
9BB6fzGexBL74MYbwgg4BZgLy9LXAx/oX1ylXYQQC5DCZMtTc+dSj12TvuEfkU5k
PaI308IdX/RK2weaB9FIZq2bNt5g17lj5aI+2jQlzrJYyrjOYjH7Qlq9njUYDg82
fncx27MNCF/tMKSxoGadrBL+QNZrTJECzpwMOQMAECHHjkdsPPqZdjbF5r9TK2jN
Pjh4cgMvx+cjM3ZKZzrcsNzMBNQNON4tEUh9BIKQPHYDO+t7lJ6yeFiePhovXKA3
wO5EfptSZnrY1dzgy1twTog3CFgoenwokiEfKwVy7yPuSYVXmLQjF8HvoBtIDBjk
O7lWnonM
=LQZP
-----END PGP SIGNATURE-----

--v59VY8NzP6FcNaAb--
