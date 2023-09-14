Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F245EEAA7A
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 23:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AD4867D6;
	Fri, 15 Sep 2023 01:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tZCSGf2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF90E8657A; Fri, 15 Sep 2023 01:38:33 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D268657A
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 01:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-579de633419so16841957b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694734710; x=1695339510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1eXmHpKknByJWFkh4AexwpT6CSCZXavId6H0tXYKOw0=;
 b=tZCSGf2ePGhOHQ3C2yAnZISUcGSvsfqoWSL2+lZdlzz8RSinhD+l3aDe7IBqG2QOR/
 OnYmRL8ZOU9XNUB2K/Mwoq11x8mORJ7pRup4ym4v0Utxx4BDZH1y81IV40ZQfR4ZQPNY
 +Y8OXTLuUVm+cBfS5f4pL3BqgYh/njOuy/X+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694734710; x=1695339510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eXmHpKknByJWFkh4AexwpT6CSCZXavId6H0tXYKOw0=;
 b=wsW1Hcs8/Xy8nXpi7/l5N0p2+Vh+4oS1SJKoBbsU4AWXgQwBg6ynWvUq1zGbDuFW6i
 BwrKL5kNwChSBt1HSO1lMSKGCXQSQWPoS5Btlb+5vza/FuccDSU8VwObKSeXX7wljanO
 OkxdDRsEe8rE9jzAqCvPxDmWHXXTr2lb4yyhI0DVUR5m/4P8N0pnW1J/MAYgpB0S49st
 HzlyMQPLy/kSNEdQAMDILwzF1raeKxv3lIiK8zKPlVwJRXtGRsnP/hbCexrRYomrXi0H
 xb0ocU8mTB/cxAy3mP2apbPyfMawhEm4Cy0PNAYKSqKBmhChjNtUl+4JHp+GULp+2kMB
 gUhA==
X-Gm-Message-State: AOJu0YyI4Vc+KNsMoONGIj8FMtVPb2fvc0ukWbldMeCxndijWLWNPgng
 uTrYC5+1X9rZylmAvuR0xYvGkw==
X-Google-Smtp-Source: AGHT+IGGl5MmHlytqfjgRbLL4XvU4uYRZ923q9+UOJAWLsbA+ZNP+pMoIKj37buBqQcg1j4eN3vH/Q==
X-Received: by 2002:a0d:d808:0:b0:59b:cff1:a8eb with SMTP id
 a8-20020a0dd808000000b0059bcff1a8ebmr158128ywe.34.1694734710299; 
 Thu, 14 Sep 2023 16:38:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ba48-499c-2259-fcdc.res6.spectrum.com.
 [2603:6081:7b00:6400:ba48:499c:2259:fcdc])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a819406000000b0057085b18cddsm587690ywg.54.2023.09.14.16.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 16:38:29 -0700 (PDT)
Date: Thu, 14 Sep 2023 19:38:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Jassi Brar <jassisinghbrar@gmail.com>, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@linaro.org, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230914233826.GE305624@bill-the-cat>
References: <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
 <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
 <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
 <CAPnjgZ2CaLg2=Bbda0suwP8wYAM7H2iO-9U_Tw9tbxKu-YAnpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cqx1hUF7vqZazUcQ"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2CaLg2=Bbda0suwP8wYAM7H2iO-9U_Tw9tbxKu-YAnpA@mail.gmail.com>
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


--cqx1hUF7vqZazUcQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 04:41:43PM -0600, Simon Glass wrote:
> Hi Rob,
>=20
> On Wed, 13 Sept 2023 at 16:39, Rob Herring <robh@kernel.org> wrote:
[snip]
> > I don't think we should decide what to do here based on said
> > certification program. It can adapt to what's decided. Probably, the
> > /option nodes will be stripped out or ignored for certification.
> >
> > I accepted u-boot options node schema into dtschema, but now have
> > second thoughts on that. Now I'm getting more u-boot specific
> > (perhaps, not clear) stuff and widevine stuff internal to a TEE.
>=20
> Where should these bindings go such that ARM / Linaro are not trying
> to remove them? I would be OK with moving them out somewhere else, but
> how are people supposed to deal with such fragmentation? My
> understanding was that dt-schema was an attempt to set up a neutral
> area where bindings could be accepted that were not just for
> Linux...did that change?

Well, part of the problem here is that I've been talking with Ilias more
about what's intended here and the fwu-* stuff that Rob rejected is
indeed not right.  We should drop it and replace it with something that
really addresses the underlying problem (which is how do you know
how/where to find some GUIDs) and I think we think it's something that
can be shared between projects too and so be easier to convince Rob that
the next form of it is right (or the right direction).

--=20
Tom

--cqx1hUF7vqZazUcQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDmW0ACgkQFHw5/5Y0
tyxgIQwAtWzQi0SNHJUkyLKIb5zwoCp4r3n7LWqMoDpxOOjWPjaNevsCCTagZccE
Cm1JehK1YMPZW6Jy7+GX5E3DPYJ60WznxwxBrWYo8ZyMscx5CN4txeTxm+MQcbmY
Qkbq3Gdrl4fq7ou3BpoMk/U8AXFiYPru8wzbnEYsydg8KPjRD5XRqbSx41liUO80
IXU8up6JvtJjqvFNUeqiof6kb46LT85I1ZO5cmV6BPpzN1J5ZHhbbNDEbFEYVtYU
iT8iZoPi2FuctH+mHOR7R1twPvXYK8Jwxe6SBiFwL1cts1FYTfiOfxoGuEtmBO+k
umD/6VXwfa9AXSHCY5ols4yGwJhSDrli1JF8hSuZGLJ3kvxiM9VRCsjKVQp6Gb8g
RSzwHbmBdU572UuWDleGWiuMHtDYtZ752OQwZRm3RjwCmXPZNZEy6DHHYBL9jx/J
ZksREJy/UtSxvKU9um6lse5NoHtuTiV84d5BVxqw2aJcjWVBfx34zORTJCPHQPRR
mOebUdUB
=nmwx
-----END PGP SIGNATURE-----

--cqx1hUF7vqZazUcQ--
