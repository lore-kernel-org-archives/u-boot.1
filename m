Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4840BC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 23:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA0188398;
	Tue, 18 Jun 2024 01:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bd3q38Yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21EA80805; Tue, 18 Jun 2024 01:29:11 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CD288398
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 01:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b5254f9c32so2351057eaf.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718666947; x=1719271747; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C8iQo9Cg+HlMpSZMojW9PgzfnPqaN12BTRMO+/RYeEo=;
 b=Bd3q38YuAC9DDci8FvtIV1+PJ88KVntfbPd6IC1vgOX0xAmK90pqS298BElBXPqFBZ
 Fo+ddGisiBWVLrLLBHkgAAwvUqhYSNOGmoFadN6epvK+/cNG2jx4AgEBh/j9jjcxH+N0
 N7Gsw8qy/deoEfiZrgAX3p7+IFw1p7NttRIaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718666947; x=1719271747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8iQo9Cg+HlMpSZMojW9PgzfnPqaN12BTRMO+/RYeEo=;
 b=lT35y85rnfE/7/O9pT3UBCUdNkUEZPk4LMaMaBe6TEKz4ZHM7pZKbyKF4J6/RsDH3v
 15KVXR86WcKefydaNmCVBEsMR3epQurffBTQdl4CPDCeZOpTy24QiSz73STSjTSLz6Dq
 qWvIqRhZWzAbmHRty8eGA/afRZnveIHQ960XZ3nu9AJW4cQHf25GJncpKcTbiSzHhaMC
 FCTa0W16FTslu7ewOTlIqvhqHgD5ocArUO5Uo8pWNNf0lEV40x5ek9CWxw3/R3/grohk
 GBL65Lsw+aR0ueFy01BUgf/CbHCJXM6+xGFgH5GLoiG7Iu4xSTa7FYNusXJmn76z0ZZW
 Zumw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM89ugEiXAuc7SY6iFUUFlxhwqhLhgWcBAOGsN/wfQ89jVwYWjL535JlGbWMlqKUdN6hSzg76iX8zVXUWz+lVmUhmA2A==
X-Gm-Message-State: AOJu0Ywsi952ZBnpm14u4XcRqWkvUZ2Jrwda4Me3gDKaUMto+wIOTVCq
 ub5poWJv/ZHbubGaVe4AvNGQk94slQNEczdkH58rzwHQbjap0iEIMJwzS82q8VI=
X-Google-Smtp-Source: AGHT+IFu+hAgudm0CzV6+HLz8wtmR4xBBiWsHVgPAbkl9wJ1O1xRAdI3D1/Nv1rND0x6nYq6DMQ0Gw==
X-Received: by 2002:a05:6820:1624:b0:5ba:e995:3efa with SMTP id
 006d021491bc7-5bdadb9a27emr10809283eaf.1.1718666947064; 
 Mon, 17 Jun 2024 16:29:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5671c719sm1199447eaf.0.2024.06.17.16.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 16:29:06 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:29:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Message-ID: <20240617232904.GL68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kO+qfMj+umSr6yFy"
Content-Disposition: inline
In-Reply-To: <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
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


--kO+qfMj+umSr6yFy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 04:13:54PM +0200, Stefan Roese wrote:
> On 6/12/24 18:50, Tom Rini wrote:
> > On Wed, Jun 12, 2024 at 05:13:37PM +0100, Jiaxun Yang wrote:
> > >=20
> > >=20
> > > =E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=
=8B=E5=8D=885:00=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > > [...]
> > > > >   configs/octeon_nic23_defconfig | 1 -
> > > > >   2 files changed, 1 insertion(+), 2 deletions(-)
> > > >=20
> > > > This seems similar to:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.195=
3298-1-rasmus.villemoes@prevas.dk/
> > > >=20
> > > > at least for CI. And for outside CI, I'm OK with just having the va=
lue
> > > > be changed in the defconfig as needed. We do support using config
> > > > fragments, so keeping such changes locally isn't too hard.
> > >=20
> > > So the default value is a little bit too hard even for some of the ac=
tual
> > > hardware.
> >=20
> > Right, there's some platforms where it's too small and we should just
> > bump it up. I think for now the default is what we want it to be for
> > most platforms.
>=20
> The current default value is definitely too small, especially when CI
> is involved (I did not have this in mind when implementing), so:
>=20
> Acked-by: Stefan Roese <sr@denx.de>

Can we please get either this, or
https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-r=
asmus.villemoes@prevas.dk/
merged for master? The number of false negatives in CI due to this is
big issue for getting more contributors to use CI. Thanks.

--=20
Tom

--kO+qfMj+umSr6yFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwxrwACgkQFHw5/5Y0
tyxFMAv/RNato7dL635gdi+ku/fC7doYyb5LzX2+ZlOpLgG8pfWlKjl0E3Ydrfal
vAdtmHdI4XD/zIFgmcCCAgFIwoTvvv/VSR3KRUgacFre41KiABEIojjbEc2o7TC2
GL25iCkawJXoCxeYYh8Adlz9QOQRRwmcj69XOtJ/DW0S0MAoIvPccp1s2dZUO2mn
i3Uyh8qJpEX2ofT20Z3vYcxdewhEwzPg/Bj9j6qszNyNunWeOJhQXw1bpP/akF6g
yUntqqYoyeTZn2b+WQYzk+Dc9+8nlJTG/sP800FEC34C4GGjR0eKbzYh0oQ4oaCF
tfmMOz/CxwR1vr0GTaRyxMsEn1xTesLjTXYf9BRHRyYgGANiToyUjZI/l586n1YS
9BXCZPpiwHiY0jjfiLhxzBA9PBO+cH7LUnz3yOIHatqTujcQSKQuzkXo8REehSHy
m3ZkdoalRTA+WC9VpKIKY6Ni3W/IKCPykWeKU6Ui4PNzkzENLIRCZC903kGx4FZa
I02SNMJW
=Y8LS
-----END PGP SIGNATURE-----

--kO+qfMj+umSr6yFy--
