Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F5C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 21:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDE6886F9;
	Wed, 12 Jun 2024 23:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QMj4L49z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B18883D3; Wed, 12 Jun 2024 23:40:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78854885D0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 23:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f9b5bc97baso195389a34.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718228406; x=1718833206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9FkzPBlnrYrHFw5Kl8yb7LlXjGUKJVPCnoNkijx9QpA=;
 b=QMj4L49zwRIdmqrRnA77o9CusEmMv9H643iG+uag/SXtQsO316iuh8tgHfh2g7e8ph
 V7FtyBfZqIWff2mAMp2dWLBXh2LLYimf8iJactdzKt7/yO3MirlaqdlyX3u7GvQMymBC
 y0KTvnSqpm92BgLtcqLMLloWzu6ln96aGvjAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718228406; x=1718833206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FkzPBlnrYrHFw5Kl8yb7LlXjGUKJVPCnoNkijx9QpA=;
 b=vdkqS4ksdr0NY/b+5L2tnJiUi4eftx1ne4HD737CeObsHAu8y2QiTUMsgPe4sB+D2T
 ocw3LR1u/odekxRuN9YU0XKYxCOJhn6mEt6ozfSmJ8bSiShN1uH2KqRySKufZxSBlKxT
 ugSuHyv8eWEgyb9gbpOhH2QzKGkjLUYIb4StcNlscrFwT6aiADiMhhKIyG/9LWIPe1ji
 8NwbUaxCkd/KAAuFqP1pszDCFfxvZQ1qhjq/xhIE6Dj7o/QTQ6PH6AbXpm3voi3XthN1
 +NHCHY0wT4uptELErT2fdBDuJlO4ANmHhHpBmoVY7fJ+Tv9N1XHCLZ3bvVYAlBBvxzGd
 cQqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6ttNplnY+ExA7sBS556xros0ErvZGaLTYM+9+kTmcfpnVELMKxN5Ka6nx8FCjzcfx+y4QdrDrw7TDp+tX88v2VLhCag==
X-Gm-Message-State: AOJu0YwT3ksJN0PmVKkFTos3hI1/6sT+Zg7AjfjA65RqVmPXZpCYiPAy
 mXDIHSI0YOuPyk7U0UWvvYAZ2gS6HadW2IRv00sFbnLzW8f7EuUNXHUt4QBeK8w=
X-Google-Smtp-Source: AGHT+IEwOpfwA6V6qhjwLFuwdQ2HaO8sUCq8UdoJ+JKIuWDZYveTLtIP7y7gwlzMBwLIr7zrChA9dw==
X-Received: by 2002:a05:6870:a2d2:b0:255:1bb8:8603 with SMTP id
 586e51a60fabf-2551bb889a1mr2595495fac.3.1718228405912; 
 Wed, 12 Jun 2024 14:40:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94e3dbsm26995fac.3.2024.06.12.14.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 14:40:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:40:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
Message-ID: <20240612214001.GI68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VU9ut0uuEh9jo7p4"
Content-Disposition: inline
In-Reply-To: <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
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


--VU9ut0uuEh9jo7p4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> >
> > [snip]
> > > Also IMO there is only really one LMB list today. We create it at the
> > > start of bootm and then it is done when we boot. The file-loading
> > > stuff is what makes all this confusing...and with bootstd that is
> > > under control as well.
> > >
> > > At lot of this effort seems to be about dealing with random scripts
> > > which load things. We want to make sure we complain if something
> > > overlaps. But we should be making the bootstd case work nicely and
> > > doing things within that framework. Also EFI sort-of has its own
> > > thing, which it is very-much in control of.
> > >
> > > Overall I think this is a bit more subtle that just combining allocat=
ors.
> >
> > I think this gets to the main misunderstanding. The problem isn't
> > handling bootstd, or EFI boot, or even assorted scripts. Those are all
> > cases where things are otherwise (sufficiently) well-defined. The
> > problem is "security" and that a "carefully crafted payload" could do
> > something malicious. That's why we have to do all of this stuff sooner
> > rather than later in our boot process.
>=20
> That's the first I have heard of this, actually, but a bit more detail
> would help. How does the payload get loaded? I'm just not sure about
> the overall goals. It seems that everyone else is already familiar -
> can someone please take the time to point me to the details?

Well, the short version I believe of the first CVE we got (and so
started abusing LMB) was along the lines of "load an image near where
the U-Boot stack is, smash things for fun and exploits".

--=20
Tom

--VU9ut0uuEh9jo7p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZqFa4ACgkQFHw5/5Y0
tywUPwv+JJ9SNSmgsjmu672Hhpm2p2bBpmLsXHJSwXOUFBOde781JIEpR2y6+387
JCCtrJnrbHpL45EJDEvQD0g6R+HEps7gvj89LzmB2DgHB/D6eNgO2lfUSD0jq6Sv
O7IkKjfbcEynTuz9iAmfxRWkvmk00ufMrvYxUtVZI+OJzrpwRmEMvhkhBnBDoaXR
Uosd/1b24Q7p5aA7sWMmvAqFNdVrS/14sFH++s2tEYDrydx8aEIKXRN0wqBHLpHX
qH2mF7DV9TIpjNykzxnzbEZjqiyuGKQuCDsGlwVSZ9pWoOByvazadnSMerkjRKb+
mGmvJSrb8Kjf0lcGEOyqLYTECa3u+kjgaek/bMbPcxlW5D/ayebVD5TIwt/CuEox
a/ovDrq9hQPzuAssyFlG5UZ1XPfJlIUln/Blpnq8fJZ/E3arKHWxehihMWtWOjmk
McMlos/YkOcq/9+MuQ1Q35Yyt/wz/ui5Ee1eOaYRlxNeXIPFreToka6s2XTap6sC
oKotxT/q
=J63V
-----END PGP SIGNATURE-----

--VU9ut0uuEh9jo7p4--
