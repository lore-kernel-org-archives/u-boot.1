Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BACCF9C5A
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F2E88753;
	Fri, 20 Sep 2024 18:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RZODKlkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCB6886DF; Fri, 20 Sep 2024 18:35:17 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED05B8891B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a9ae0e116cso223938285a.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726850114; x=1727454914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Qko8wVpI5sy0x3m3sRCPcEIB+BQ1uuZhZ/cpoA76ic=;
 b=RZODKlkbQJCcxD5sg0bVUcyqyf7NLZNnyQLCZyL70Q6cUpclBkP2UB7jHqtmDLMO0r
 AGa4+XI4ASa1BujM28d6IknoLB3VEbJKv+8sGwl6YspI9tql2UaLajv32v8MaHc77Wt7
 CcEEvH0t5w5A8FdmPO3A5iJOBA4xtsD1DEFrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726850114; x=1727454914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qko8wVpI5sy0x3m3sRCPcEIB+BQ1uuZhZ/cpoA76ic=;
 b=S9y/RwtBB8g5bi9ihTsWHLQgUQBBcrfnBz9Lgsm6pb/CrPMG1veT+G87/J8aTynkRF
 ql7PT8UjnG9aDrgkrUS2ITiPK+dZTa+P5YsyQR3wH9YkeiGP9hpUvClfjnEO7A73rGgj
 7uzmFlo0eKkqqwuFwmV/QTneZczCDZqUqPe9BAIYcazOkWdWa0JsGpUOqvn6OiTp/22R
 WcYbTlBqLj8E3zZp+8f8wg3/GFfSFiikkWv1NwPg+CYWuRQ8ta8bSkeERFzPIGspgKAE
 FIWnhDdRjqv8XIi0LwKtkMxWTuT5lt6ol4XLJWarZfl5Fo3XfjUWPzPueCCDaRvxvAss
 LUpw==
X-Gm-Message-State: AOJu0YxCvopbP+AlGtTkRz0NDvobqNNWd3BzP00rB+n+aSOPaq7h+d/m
 7AZ8b3dWABw9qQhHMvhvYZpE0HSjibHa67uGvdZDnFwQNMDpC7mjKXg/LrDOkWU=
X-Google-Smtp-Source: AGHT+IFnylby2ZKxaHsDQsLa+1Kqq4sdJZi1IcZ6oTZalCzVnxhwbn9EJcz7hcM+Oqmi8kSrtnRx0Q==
X-Received: by 2002:a05:6214:4b0c:b0:6c5:2fce:4904 with SMTP id
 6a1803df08f44-6c7bc6d3235mr54331026d6.12.1726850113780; 
 Fri, 20 Sep 2024 09:35:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e461464sm19609036d6.38.2024.09.20.09.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 09:35:13 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:35:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 06/19] malloc: Show amount of used space when memory runs
 out
Message-ID: <20240920163510.GG4252@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-7-sjg@chromium.org>
 <20240829172626.GK2479150@bill-the-cat>
 <CAFLszThacdwBNMP8Rq3uEXd=MT-8NpVXHOjhcMrdvLR-KrNPXg@mail.gmail.com>
 <20240920145942.GC4252@bill-the-cat>
 <CAFLszThSLXLOxMVQBCwpuLEOm6CPx0N-p2taz9Z6NEw1-P86Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NDgfQoXeKQNsibpX"
Content-Disposition: inline
In-Reply-To: <CAFLszThSLXLOxMVQBCwpuLEOm6CPx0N-p2taz9Z6NEw1-P86Gg@mail.gmail.com>
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


--NDgfQoXeKQNsibpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 06:04:01PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Sept 2024 at 16:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 09:25:44AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 29 Aug 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 29, 2024 at 08:57:49AM -0600, Simon Glass wrote:
> > > > > Show a bit more information when malloc() space is exhausted and
> > > > > debugging is enabled.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  common/malloc_simple.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> > > > > index 5a8ec538f8f..f2b3dc53689 100644
> > > > > --- a/common/malloc_simple.c
> > > > > +++ b/common/malloc_simple.c
> > > > > @@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int ali=
gn)
> > > > >       log_debug("size=3D%lx, ptr=3D%lx, limit=3D%x: ", (ulong)byt=
es, new_ptr,
> > > > >                 gd->malloc_limit);
> > > > >       if (new_ptr > gd->malloc_limit) {
> > > > > -             log_err("alloc space exhausted\n");
> > > > > +             log_err("alloc space exhausted %lx %x\n", new_ptr,
> > > > > +                     gd->malloc_limit);
> > > > >               return NULL;
> > > > >       }
> > > >
> > > > Since debugging is enabled you should update the error message to s=
ay
> > > > what the values mean...
> > >
> > > OK, will do. This message is shown without debugging enabled, so I do
> > > want to keep it short.
> >
> > The commit message says "and debugging is enabled", so is that the case
> > or not?
>=20
> Oh, I see. It should say 'not' :-) I will send a new patch.

Thanks!

--=20
Tom

--NDgfQoXeKQNsibpX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbtpD4ACgkQFHw5/5Y0
tyx6ywv9GdHC3BiGNw0h3/z2D2+bRWjQqInQ07ab/5TaSJIWAu7H7N5+DCFtIkDO
XC48b0c+rJ6oWD4YTRvbcvfOzmBPMz4+dULgtZ81+CZVNkY/lobOrVWsGR+TkGH9
PYjeYwB0Bm418lGUnkOahafl52bhiOt0voiWyO0ciZpVpjgSupt103Mp9rdIZCkL
LJyZNDPaHlhB0IHtkyPf3/Bpwvgj9ZeOB4qm4XIXvH1ioNYAUgvzpAOvcSU3L5+v
oMKTfQWDO/25yOXM0Mv+uDZ7wDG1yjhJXdcOklxeBLJt2glW+jmapKFOCp9aqpOr
Fc8RCaR0Rt795T2TG4k3gi0/WYHhTgRx6EZBfiRc0WahsOZYgAqrgbRAcf0yQecp
FhgVPhoPFQ4cnks3Vo/OaWZJdEur6ww4wB3soQGX+JgBw/WaxcDF5r24A2S5yKUW
YM4rX/L8wrQzEOEVF9Ajo2QM6QPwuzGntzsUYINHF/oBdDWbdHeZlDBbr/yhDK0k
8FLwMaVw
=00S/
-----END PGP SIGNATURE-----

--NDgfQoXeKQNsibpX--
