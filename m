Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE94C78853
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 14:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF31888C90;
	Fri, 20 Sep 2024 16:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XDZxciV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7BA88BD2; Fri, 20 Sep 2024 16:59:49 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C1D488AA7
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 16:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e03974b6a5so1069680b6e.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726844386; x=1727449186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PXpZgCTsXO6+95SFNgINXXQiw1AiECMuje9QVR5GtCY=;
 b=XDZxciV3iZu4BNDd0sg+/3vOAlrfB+RfUmMjqM8KV+AAIiROw9EOJ/CSv8zBQY2GLT
 KSXyB/6eK5yo1AlWbr5cYiiZbbBCi4xnCGwkZnXXQE0FxrNjFvRQsp2XRh5qXMJ9rjA0
 z4afwezMRx581/LpFJyLvr5vW58XGFinOl7LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726844386; x=1727449186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXpZgCTsXO6+95SFNgINXXQiw1AiECMuje9QVR5GtCY=;
 b=ZNjzgVn228nxd5+ceIiR/HW2EygKDMxGu9Z+gmiQr9PJg5gYZ8s17xqcdSzRTHZs+z
 c3BMqSNShcN38uQDPg47wmw/zUOdsdUQZREivfyAqay9+nEuSnK0jxtlcnBSUE1VwX1l
 sHTQU9VIcJhd2wOooH86FfrgoTsRzRxM5PCh+UvbTNPl1xiZKp5lt6s7j4ELGI71GdnC
 glFOvXvGuzIQ2xtK9GVsE226bJytg8+PNXdUWriG6b0P6x4B6RnavzQptAGC20Ch9yPC
 18W50xrQ2S6q6znKpqglA2rzjmLJjjiV8NP8C2CsB9OUXqhWkw2AQ91p44kDo6QpXKiw
 Zzyw==
X-Gm-Message-State: AOJu0YxPCsVjzBKEElqGAkEXf8IoUi4unXGlPqnxZ5WvXksEpZe+S4dj
 GXFPXkCMVtogt1KpYRG3rX/YGk2IohwQnqsUYIOmX+vtta9tS81z/3HLhlnNcCkUn8DZILbvBOb
 C
X-Google-Smtp-Source: AGHT+IG9uqWfGFCCG95W5KcojYq6rzBMFZrGXM9mITmtwGcBVAg2Z6RtnTqd4YcU/n2PF54dPyxQBg==
X-Received: by 2002:a05:6808:f07:b0:3e0:4722:cf8 with SMTP id
 5614622812f47-3e27293de3fmr1969709b6e.25.1726844385969; 
 Fri, 20 Sep 2024 07:59:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b17867eddsm18386291cf.13.2024.09.20.07.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 07:59:45 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:59:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 06/19] malloc: Show amount of used space when memory runs
 out
Message-ID: <20240920145942.GC4252@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-7-sjg@chromium.org>
 <20240829172626.GK2479150@bill-the-cat>
 <CAFLszThacdwBNMP8Rq3uEXd=MT-8NpVXHOjhcMrdvLR-KrNPXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+SkH9UsMNUbRaomL"
Content-Disposition: inline
In-Reply-To: <CAFLszThacdwBNMP8Rq3uEXd=MT-8NpVXHOjhcMrdvLR-KrNPXg@mail.gmail.com>
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


--+SkH9UsMNUbRaomL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 09:25:44AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 29 Aug 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 08:57:49AM -0600, Simon Glass wrote:
> > > Show a bit more information when malloc() space is exhausted and
> > > debugging is enabled.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/malloc_simple.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> > > index 5a8ec538f8f..f2b3dc53689 100644
> > > --- a/common/malloc_simple.c
> > > +++ b/common/malloc_simple.c
> > > @@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
> > >       log_debug("size=3D%lx, ptr=3D%lx, limit=3D%x: ", (ulong)bytes, =
new_ptr,
> > >                 gd->malloc_limit);
> > >       if (new_ptr > gd->malloc_limit) {
> > > -             log_err("alloc space exhausted\n");
> > > +             log_err("alloc space exhausted %lx %x\n", new_ptr,
> > > +                     gd->malloc_limit);
> > >               return NULL;
> > >       }
> >
> > Since debugging is enabled you should update the error message to say
> > what the values mean...
>=20
> OK, will do. This message is shown without debugging enabled, so I do
> want to keep it short.

The commit message says "and debugging is enabled", so is that the case
or not?

--=20
Tom

--+SkH9UsMNUbRaomL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbtjd4ACgkQFHw5/5Y0
tyyrgAv/dh8Wu3pgVDIULnF6IBOtXwUNtGB+IRb5lm+P1feiq4qFuJDFJDzY2M7p
lKUmKmWiIouNG9MMJmt8KZwQ3zFRn1Oa8g8gdV2McNT2PtUfz42MTW8hU9UcTnCO
0ZPexMarNlGsFB9QhxQSVev36kp3cWbF9/d5HyuuZQAeTrABf9GSRW6bzCWavofC
AhDZsCKmKP4R9yq3NQ36UuppDqH0IZrNZhTWjKKQ+Eao291rUz7McrOLtT3ktC8K
syEVwRDnXOyMkc5jc4v6Ql9FAZCRQjwPjPbhUZSysRL9mal/c7ijlja8O/VHxCsD
E2sna6FF6gSfT7RvzXdjs5XcbOCSX6GM1nozf2zsTyPeY95ecN8PapuDQGlDGH/q
5UIHMo18ngttilzdPuej1dPGCpZlkIcvZ8CAcc+c7urtFc8opEAvMnmenNtckHR8
lPBdXMSBpm/0bYNJhTtMNEHL92iZV6sCJ4mLGlurwz0+DkDs5mGDa1uNOZPE7Oag
OQsTMjex
=gxmT
-----END PGP SIGNATURE-----

--+SkH9UsMNUbRaomL--
