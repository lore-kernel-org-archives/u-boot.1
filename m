Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACFCD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A43B84671;
	Fri, 29 May 2026 17:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LXLX3DIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871AE846B4; Fri, 29 May 2026 17:35:07 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB256844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso4543713eaf.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780068902; x=1780673702; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cspysdxtxbVmNmbAtia9cL4979qlTJSo6QPLLmOAWR8=;
 b=LXLX3DIsS/HeGaB1VtduWnya/3ii/+J1+lRKrneBwgVapKlaJG9L8gklnCdJOapayK
 gyZhJ2hWbHt6BgL81EPsmUK0I/QeVrXLavGX8uqmixJ2ToDgQICX0/tXTunPfhaQIteV
 PGQNb7nOl6yfoeXs9X8LXoSD++xKyfVwenn0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068902; x=1780673702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cspysdxtxbVmNmbAtia9cL4979qlTJSo6QPLLmOAWR8=;
 b=O9VjV8keS15vnhoOyBGEWjL+HdiC0kY5P4+OIfwae32/ZOdo2LWuk+2dQrhw4ZE2S9
 2RgFG8HI31M+4YfZ0HVQHM7OraJK4clRMjKcD+MNNPube79wFbpJA9ysdvqnOy0Ujhbt
 lkot6anMk3dAEYPv/lJv3JaRtceGrQTREkbhtiv7PYlu7gLPZs2eT1WeHaO9hCVp4cDu
 gg18a7T2FrvqC5LiFX019EAKJ46BCjXTOmu4OWXTTrQ/rE6ZQewqBgyLNGJ/DU7IRC3O
 K0NfDJFoNsmbpva9liRuQ8TK96Dzq9M4p/WeX1wm5gSihkA3NxBmDv3UrWfyJCX0ClXB
 TYcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7fOXZ1yoy/bvYHuFnGpMCBkTwwKomhfChxUNw10778lpZEy4d4KGdRhgSOcbKP65yqmNH7CE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywl6C2IUz6tQfyZGNycnrQa7utLNgmF8G+UpECNba9Un6x/ELie
 hJ/mt2h4jQJ5meLeKdzsiDxqrrM56Xmjc2BAadfhijI+BIYKAvnDxd5Ok0aXjjRQcu8=
X-Gm-Gg: Acq92OFForb+3zTLu86WcguNLpiCUPIV2Q0VygpfRUv+nE+59OqPMpeaNZvzJCvXFBk
 5j55VCOz/Ob9R+NkWYGvw6LFjZZSfdKY+NjfL5GwNMLLQ8/twxb7HSsC9wKxJdyjGrb6aM8ln2M
 M8Zl4cShA6M7FxR8zdLvG32Lm+BWbJGhsszYYCc7wb88mco8YMbJiOdhiOo9SY0+D1tST1ZBKUB
 SiWaeEJ0CW0Z5ouGY8Fhk176OyUNx1SF1zlwi57KfRe10/+OgTL7C8tScvhBHVXk9i1UX9pEXSD
 7kRypd5kKwA30KBCDO91AqndQn5mMNNFWxUaRpe99FenNdSZd5WmCAU5VNX3z798QlMVIttomCv
 ncxR7nmF9bsM0D0LYis6idnRBqOe3N9s1lpCQxwXUxKIMSGC88jAWy8orndUk7/jnNqNfTKeUZN
 1pAt2Ukinj0KbTSpNyr5/rgHYGgf+y2CT+2hv031XoM1/wM5WsZavmulzzv1jng8sJKXvKdLkgf
 LEK/0EiEExJI6hDWedukjod4qWFVzTeUo+e6xClGU1GJ8DHbKOBozINjIRU9+aw8NA=
X-Received: by 2002:a05:6820:2e04:b0:69d:808d:a442 with SMTP id
 006d021491bc7-69e03f10cc7mr1184126eaf.19.1780068902284; 
 Fri, 29 May 2026 08:35:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e069ba3c6sm1309321eaf.14.2026.05.29.08.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:35:01 -0700 (PDT)
Date: Fri, 29 May 2026 09:34:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: philippe.reynes@softathome.com, marko.makela@iki.fi,
 jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 simon.glass@canonical.com, u-boot@lists.denx.de
Subject: Re: [PATCH v7 01/15] ecdsa: fix support of secp521r1
Message-ID: <20260529153459.GA627328@bill-the-cat>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-2-philippe.reynes@softathome.com>
 <CAFLszTi6bciTi6AU-k6EU0LXEpJ+n4qbM-zdSQrHow4KNcD2-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hTtLPEaz3rl2Ypay"
Content-Disposition: inline
In-Reply-To: <CAFLszTi6bciTi6AU-k6EU0LXEpJ+n4qbM-zdSQrHow4KNcD2-w@mail.gmail.com>
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


--hTtLPEaz3rl2Ypay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 02:16:55AM -0500, Simon Glass wrote:
> Hi Philippe,
>=20
> On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> =
wrote:
> > ecdsa: fix support of secp521r1
> >
> > Current implementation of ecdsa only supports key len aligned on
> > 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> > aligned on 8 bits. In this commit, we update the keys management
> > for ecdsa to support keys that are not aligned on 8 bits.
> >
> > Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> > Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> >
> > lib/ecdsa/ecdsa-libcrypto.c | 65 ++++++++++++++++++++++++++++++++++++++=
+++++--
> >  lib/ecdsa/ecdsa-verify.c    | 65 +++++++++++++++++++++++++++++++++++++=
+++++---
> >  lib/fdt-libcrypto.c         |  2 +-
> >  tools/image-sig-host.c      |  7 +++++
> >  4 files changed, 132 insertions(+), 7 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> questions / nits below
>=20
> > diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> > @@ -41,10 +43,26 @@ struct ecdsa_public_key {
> > +static char *memdup(char *buf, size_t size)
> > +{
> > +     char *dup;
> > +
> > +     dup =3D malloc(size);
> > +     if (dup)
> > +             memcpy(dup, buf, size);
> > +
> > +     return dup;
> > +}
>=20
> Please match the U-Boot signature: void *memdup(const void *src,
> size_t len) (see include/linux/string.h). Making buf const lets the
> call sites lose the (char *) casts. Also note that fdt_get_key() now
> hands back malloc'd buffers - please spell out the caller's free
> responsibility in a function comment.

Simon, I've noticed of late that you're providing a lot of Reviewed-by
tags in the same email that you provide a lot of substantial and
non-trivial feedback. This would normally negate the Reviewed-by tag, so
can you please refrain from providing both the tag and feedback in the
same email? Thanks.

--=20
Tom

--hTtLPEaz3rl2Ypay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahmyHwAKCRAr4qD1Cr/k
CgovAQDceihQhVwgpCETKvLakUMpBeTl+yGVCxiqQfsSpEHWBgD/UAlttOze5kh7
x1tRSsz7u9N/abNCfvRDTTj0HctfxwY=
=EqMg
-----END PGP SIGNATURE-----

--hTtLPEaz3rl2Ypay--
