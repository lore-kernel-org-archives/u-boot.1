Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6197C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 16:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8F382B07;
	Mon,  9 Jun 2025 18:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lJtwHLbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8F682AA7; Mon,  9 Jun 2025 18:48:47 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0EA826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 18:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c27166ab3so3089802a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749487724; x=1750092524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j6F5YQVymRSPS/rX0V9X/A9inByf6oQ5kTMB/KfeIbQ=;
 b=lJtwHLbb/N6aPn0HswyTDfYHeFVc3cn4IZW1suNJ7J/IlYAM91nHMM4BZAD84fmQq8
 brJr848BMKUszY1RD59VZJIGK0CvJ8YXn9NwA3zIAcXvkDbtVaFT8zM/BgM4391qG9bM
 Ch44vtA9JRBcha869pc337kq3QYbqw43MQEa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487724; x=1750092524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6F5YQVymRSPS/rX0V9X/A9inByf6oQ5kTMB/KfeIbQ=;
 b=TMkRBe/HWJq8zKKk+ZCKh6VvgRI5Aw6KCJoEK+tjXy8GVUQQ63apmURCyBv9s6oBup
 Wz7Jj8Y63Nt5Z8Mwa3OQOG1c/+ab1tEi6be/a+u4NmAXZcmCsdqgrofKYo1ZHv5QUawz
 yVRnwazc/YJiYh8vVnYwV4PuIPiZULPtlAh4yVYH6+wimBO5IWE6dap0QZY3Lfjr4o8r
 7KtzotXvVpBThOpiQQoWms391ZR1X8xkqGFjnYw1gJZPflxYYz6c4Cz4lrlIxeNfmvtU
 aF8JkoeK9szFsiS7eaokgManJlU0XY9E7Oqk0KNziO4kU08YgMxxYBsRpNnZxAP2gke2
 bzRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVneQDSghkFolIDK/hKlh/ZGNpQBFVzTpVDWzuaVW1LX1kLvXVMQWXPzREvKmr8VWlgdkVccDs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/bNt+vBymr5utMus5dBh0qL4m9x2qvGh7PC4Oj6EIfSbFGI72
 fEdi3JB0pRCYCkJtLWoLasNrzoBv/SAzxUV6nFblQxtoll2tGH8I6uNqb+tLineaBgU6b5YvkRH
 FV6uTVdc=
X-Gm-Gg: ASbGncsfTXp0B42DSO4OVEWorvXX99P3Kgmr+BbtIUNAbQEWHAnv/gDb/aDIj0Up4Iu
 6Ir0D/9mII+XpJ8xuoBRUDAUpxhqK1lMou3azve2PXLNhl72SdI4hKQTSPn2aZrAIr71zAwpFOX
 VDrEN2EWCblbiCKgUKi7x8mNjos+589XXXfMtF/7t9kLrZibKc3wEGjdihRb6Uw+M2tRHKBDowT
 fUFfcjri8bNW1KIqA46YsEcIMxIo6axMdgz0V+3FOSEOO/DXpj3yLkF+kP0bYhk9rZJicZ4+suz
 4j7M2GYlGLZvvQ/dFZX1iJeBkA4WMt/nm1gqSueYuhF/iuyYs0LZWjefk5IgYsLw0SdD2BdnjlR
 voxBsG6b+tOh9Ll5t7lHMbuE=
X-Google-Smtp-Source: AGHT+IHxnnFbrKYoxm1hxkFkF+z3rg2KbgbbG4O5OcylnZOmiQRdweKvB/a06TkI8l7YC6AQVWffmw==
X-Received: by 2002:a05:6830:3c04:b0:735:b4ef:acaf with SMTP id
 46e09a7af769-73888f0ec7emr10519325a34.27.1749487723882; 
 Mon, 09 Jun 2025 09:48:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a089f1bsm1638833a34.66.2025.06.09.09.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:48:43 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:48:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] common/spl: handle properly images with bad
 checksum
Message-ID: <20250609164841.GU1382132@bill-the-cat>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606223109.502055-3-mikhail.kshevetskiy@iopsys.eu>
 <82a14d8e-c444-45b1-aa99-ec6ef0fb064b@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PEHv/FdNn7Ip4QUj"
Content-Disposition: inline
In-Reply-To: <82a14d8e-c444-45b1-aa99-ec6ef0fb064b@kwiboo.se>
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


--PEHv/FdNn7Ip4QUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 10:00:49AM +0200, Jonas Karlman wrote:
> Hi Mikhail,
>=20
> On 2025-06-07 00:31, Mikhail Kshevetskiy wrote:
> > load_simple_fit() returns -EPERM for the images with broken signatures.
> > Unfortunately this may conflict with image loaging selection on the base
> > of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
> > ("spl: Support selecting images based on phase in simple FIT").
> >=20
> > Thus loading of
> >=20
> > 	configurations {
> > 		uboot {
> > 			description =3D "u-boot";
> > 			firmware =3D "atf";
> > 			loadables =3D "atf", "tee", "uboot";
> > 		};
> > 	};
> >=20
> > with damaged "tee" image may finish without errors. This may results in
> > board bricking. This should not happen.
> >=20
> > The simplest way to resolve an issue is returning the different error
> > code for the cases of broken signature.
> >=20
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > ---
> >  common/spl/spl_fit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index ab277bb2baa..783bb84bdb5 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -322,7 +322,7 @@ static int load_simple_fit(struct spl_load_info *in=
fo, ulong fit_offset,
> >  		       fit_get_name(fit, node, NULL));
> >  		if (!fit_image_verify_with_data(fit, node, gd_fdt_blob(), src,
> >  						length))
> > -			return -EPERM;
> > +			return -EACCES;
>=20
> I think a proper solution would be to fix the bad use of EPERM in the
> commit 873112db9ce6 ("spl: Support selecting images based on phase in
> simple FIT").
>=20
> That commit should never have used EPERM in the first place, it should
> be reverted or its use of EPERM could be changed to something that is
> currently NOT used to block loading images that fail e.g. a signature
> check.

Instead of EPERM in the case from commit 873112db9ce6 how about
(skimming linux/errno.h):
#define EBADSLT         57      /* Invalid slot */

And use EBADSLT ?

--=20
Tom

--PEHv/FdNn7Ip4QUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhHEGUACgkQFHw5/5Y0
tyywkwv/eL4CfNx+HIZClPgVZ+3Qhj2oCS+iwVtm9k+X0fUCy4vs9s5i85MQMheK
bwZ5UZU9OuBEHncqEZS4Of5W8N6s7J6Zi87OE+LGwsPUMw0XzXjw/TGXQMucd3Fb
JYwG/la0FLfeIHVOygxdr0kYf+iNkMdhBaEh16uLsmwXSdzKeOBkoUp92p9EImwL
zJZRhq43FRfbzA4IvS8xnp5K71eQCWFmbpIir5lU3PVWbOWPZS6vRON0GEchR79M
evFMkZZHypqqQ1251Y5jm2aj3MJAwNhRAXXzyNNfd+78ZjdvE5i7iNqIyPbnNOY3
W+he+VK4B3eqpenX1pujbeGvPNkFHOXWZA6B2TuzWSNJ3jqEjFXG2AQd/M07vA/t
za+LPQM0qUaAMw+PgU+ZIfvwKGFiZGAiRjNzvVSNaErs6765LwI9m4YdE9rXR94V
6RV5vj0zCgeyfPqfQlkcAMx23W2HqInAd9W167D5Gx01Pn6H1OkJEE9YSagpyNGq
n8SCOiLm
=zCqC
-----END PGP SIGNATURE-----

--PEHv/FdNn7Ip4QUj--
