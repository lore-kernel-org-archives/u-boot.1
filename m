Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB73107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A048B8423D;
	Fri, 13 Mar 2026 22:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K+aeh75p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF3184242; Fri, 13 Mar 2026 22:51:18 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE268423C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7653db148so1935627a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773438674; x=1774043474; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oBtUxrxoIYR+RDIWcYsXF14Z8DtexsgZZOEqURicZos=;
 b=K+aeh75ptebDkGfiPqCImopTQxQdw/ibKhInrNZ0ePKiH7Kw8Ckxymr8akIPaNQiCq
 IdfUaK7wOyBEiiwkNZhzwDq1Cl0W/w1AjvNilInDH4MAWHKLz7DgRiEhgunlWGRd+sOR
 ulLOpPYz4yOUaO6zK8xwUgNPH5PLDVtnwowRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773438674; x=1774043474;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBtUxrxoIYR+RDIWcYsXF14Z8DtexsgZZOEqURicZos=;
 b=sX6vwZ00Yw73Zs1kolHao8FTW3UsBDfYFSSIvuffE5PijFHREV1ZuGvMZsnSGaltsp
 H8KPG62yZwrXpiFJV/koKnODB9m4TAVI/92TwQX6RnnPKyw5PZywm7bBEYej1v8jNMWj
 lsUerL8kCuU3JT7oBBtlFgQ3eN6IEFmbQ9qgPQLTx2qPEEZDzPxVTCHZdRJ4sTxqjmXZ
 izgfZXMH5WJlwaoawc+DVt0KQFLRHUyjH8qnUuA9tEHwNNT2XrgvfD79nkhETbm9KKCH
 cMCcqF/Sv5+3Nl/6fOjK8avWu5HyPXqrcPFeMaR81H+MYWTv/q5jvrPKb80PPXYHSTcj
 8Jdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgtClTS9h5H7KZ/Re2uo0T/odWmiUZsfLHRCXnxXy2NM0TDlkU56kWlPKr3NQmfnttsMJ630w=@lists.denx.de
X-Gm-Message-State: AOJu0YyNJ+5q58Gf2OSpP0WQpFOxltK7czavlBmAXkvzaND3BGV27OKG
 ebVCN9gBfe8VCWsS0AIxH5FQJuH27A6AG+MgqboOCXoJKCfuIS5Aoz1tv5ZdK5Tpvm8=
X-Gm-Gg: ATEYQzyP7ns7MVr2BRBjHYKguq7Mj4/RoHVRI+WZjuuKkotGxqjs52LrWehtFdI7bjX
 gbzs60TiEBrUq2Ukv7S3HExnWWxIY2pgt9F7rAwKvhv80Dl7RPbLCUROwf+8w5bVCVwDiTLIgx7
 1uXwjPLMP/HVbaKChqhILUktXm2sZzsGB59bXKxYweoUDGI7zWCwUBLiBtQvjl6EaSTxvUpuMc3
 1M2R94fylMt8k4G6w7Zra3HO9o/83U4Rcm635nJguAU2fXR37gnl+4g/SLZP8qVp2aKnsbFgLrh
 LhMWgIdzs60KxkSdGI7Nlo6RC+EfFavvWy6utCTPtIhfFf+oxeGZBnrUynvpCo+93NC0j2qqFH+
 L+/owONI68Fh0klj2zliUE32qka8/zlQ/KzpazOnaxqzS8YGeFBh1muz9QQUPTTAap25C+KaLmK
 i+UpPViwUwSeLE9vyMC/RxHY3pgrbkRuCyg6VC6uiWtH7xKFylPR3MqEN6fDZBhq+TRubw4Xs1z
 pzvLob0+pEjKcYmDwNCD/ZCpxW2BC5JGeK27ggHQicj8WHh
X-Received: by 2002:a05:6820:1694:b0:67b:c536:c629 with SMTP id
 006d021491bc7-67bda97cc47mr2561341eaf.8.1773438674667; 
 Fri, 13 Mar 2026 14:51:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc8efb85esm5513075eaf.1.2026.03.13.14.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:51:14 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:51:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, u-boot@lists.denx.de,
 marex@nabladev.com, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain version to
 14.2
Message-ID: <20260313215111.GJ502704@bill-the-cat>
References: <20260313210005.781958-1-festevam@gmail.com>
 <20260313210300.GH502704@bill-the-cat>
 <CAOMZO5Bc_Xq2QkYQxMdqa-c8MkHX1h9EJhSExcO0Sq=cBbXu0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n+s0lPB6mmu83Wgq"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bc_Xq2QkYQxMdqa-c8MkHX1h9EJhSExcO0Sq=cBbXu0g@mail.gmail.com>
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


--n+s0lPB6mmu83Wgq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 06:19:13PM -0300, Fabio Estevam wrote:
> On Fri, Mar 13, 2026 at 6:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > As this is no worse than before, OK. But we should really be globally
> > consistent about toolchain wording and that CI runs with the kernel.org
> > community toolchains.
>=20
> These specific Arm toolchains are required to build imx-oei and imx-sm
> binaries only.
>=20
> The U-Boot binary is still built by a standard toolchain.

Right, but we generally tell people to just use the same toolchains they
have access to, instead of relying on specific ones. I'm sure NXP
qualified their binaries on something specific there but it would be a
bit shocking these days if regular old gcc 13.x / 14.x didn't Just Work.
But it's not just NXP with links to specific toolchains, I see it for
other vendors right now in tree too. It just caught my eye as something
that we should be better and more consistent about.

--=20
Tom

--n+s0lPB6mmu83Wgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabSGzAAKCRAr4qD1Cr/k
Co0aAP9azaXdBTvb0e7uZdwb9Sy89OZbu7CjeMi/FQQDvzt1RAD+LS2MlDdMkWNj
f4KXG3KLv41oiC9lOxtoBQRtNYXshQ4=
=apzN
-----END PGP SIGNATURE-----

--n+s0lPB6mmu83Wgq--
