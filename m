Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E500C83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 19:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6818A86479;
	Sun,  3 Sep 2023 21:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z6t9Xi3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138C48647B; Sun,  3 Sep 2023 21:25:29 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B79A857BF
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 21:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-58e6c05f529so7658097b3.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693769125; x=1694373925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aiwq3ejZ+g3V3Lfq39lNA9QsyV8KDXGcFKHQI++qSr4=;
 b=Z6t9Xi3dsOLbTsG+ZPnBO2PfnA2I0faeEuAyDmVs1eCEBGeivjFHFVRgUYhESkCURh
 2jduCUbCsb8M5sPQQeDfR7mIdQGwDuGBxK/EHlcLXaRb5IqivTaVz9vekiL6LQWPB/In
 JK+Cf95QhPfHe2gbc4KOHnxltc69y5ccrJJUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693769125; x=1694373925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiwq3ejZ+g3V3Lfq39lNA9QsyV8KDXGcFKHQI++qSr4=;
 b=IfixF3yC1nqY1RYQK45LQZlO2RWA5h8YGR6DXdzqRKToZwzHyVfn7EeYPRIfjCX16l
 cHN7BG/V00dsPkIWo4V534d8HOWDjxsTID5zLrHH6VNhVWzC+NflJgqf66MEmOfeZpVX
 awODn5/zWWGs9nCsz+t7UjJJa2/d8K3qfWO9O8hCS07zg4mVybkiZxTpHddyC/4tFJo4
 CqKqqj34voM+G9m7jTwUqwDIWOi0t6THqGBcBlzQDRBwFABOIMnOF0SB4FqwKa6WuxL7
 ByB+PHi2nHPeIyoKAiGJKcPYxCofkzXtjN8VdnrhJtFMnNL9pIot1kyVXXKTY0MHXMUo
 IpVg==
X-Gm-Message-State: AOJu0YxJFT7TmXm9q5qGcEVSSHQln+FsDa0EdMyRbP0kfkTPH+wwag0t
 L0QomDrd65Ajd/hQBtYWxh/wnQ==
X-Google-Smtp-Source: AGHT+IFPeSCkBdmQ1iLck52TaBAlGtXRllPMKghWADwXtLoPp3730WyQ6mHSXdFWjC5R2Tn9fvSAsA==
X-Received: by 2002:a0d:dd16:0:b0:583:3c7e:7749 with SMTP id
 g22-20020a0ddd16000000b005833c7e7749mr9481418ywe.41.1693769124845; 
 Sun, 03 Sep 2023 12:25:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-e2c8-2093-3a74-c444.res6.spectrum.com.
 [2603:6081:7b00:6400:e2c8:2093:3a74:c444])
 by smtp.gmail.com with ESMTPSA id
 a66-20020a818a45000000b005844ae2bfa3sm2265611ywg.95.2023.09.03.12.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 12:25:24 -0700 (PDT)
Date: Sun, 3 Sep 2023 15:25:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
Message-ID: <20230903192522.GZ3101304@bill-the-cat>
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
 <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YUkBHOJh79TcwdaF"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
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


--YUkBHOJh79TcwdaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 12:06:13PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > > >
> > > > > When lmb runs out of space in its internal tables, it gives error=
s on
> > > > > every fs load operation. This is horribly confusing, as the poor =
user
> > > > > tries different memory regions one at a time.
> > > > >
> > > > > Use the updated API to check the error code and print a helpful m=
essage.
> > > > > Also, allow the operation to proceed.
> > > > >
> > > > > Update the tests accordingly.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > [snip]
> > > > > +     if (ret =3D=3D -E2BIG) {
> > > > > +             log_warning("Reservation tables exhausted: see CONF=
IG_LMB_USE_MAX_REGIONS\n");
> > > > > +             return 0;
> > > > > +     }
> > > >
> > > > This isn't the right option.  Everyone has CONFIG_LMB_USE_MAX_REGIO=
NS
> > > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > > >
> > > > But it sounds like what you've found and fixed is an underlying pro=
blem
> > > > as to why 16 regions isn't enough in some common cases now?  So we =
could
> > >
> > > I don't think I have fixed anything. But I'll send v2 and perhaps it
> > > will be clearer what is going on here.
> > >
> > > > possibly avoid the string size growth here and have a comment that =
also
> > > > matches up with the help under LMB_MAX_REGIONS?
> > >
> > > I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> > > about 400 bytes. There seems to be a lot of code to save not much
> > > memory.
> >
> > What do you mean here?  The alternative is not unlimited ranges but
> > instead to define the limit of memory regions and limit of reserved
> > ranges.
>=20
> A better alternative would be not to limit the number of regions, IMO,
> i.e. have an array of regions that can grow as needed.

That's not something that we have in the code today, however.

--=20
Tom

--YUkBHOJh79TcwdaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT03Z8ACgkQFHw5/5Y0
tyzNgwv9EtNL4gW8RbYto/nOPgBsX2AkEalB9ZHrTE170vYd386qfJ6NQk4+1v4z
1LKbpk/77SfmGfIOScRDH1YniI9cCQZxTooC3S2iA4y9OxhsbugJ2np8s8d3gP1Q
oUVySWEFI11iUV2/gikb/T/Y0ibhcDBrLVW7VWZhUhUNFloxTyZh+ODhQov6tMr1
IttvsZTwTLkepMr1SuiFlM16ImCbNfI0foC27aEmO6vFSo7kcBTAyooTRc7rb/SF
fE9mPpj+7KgXyU22coxstvWxONfBxYy6wTyE+XNpu4ILCTBEhRpmstEF43t2nnnT
Qmxi0NU5gZSc56jm6RmyrZK3VycOzD4JtO9E8emSwcO2Q6km7ZKXoDL6Tz/HqUVK
SmCnp1rLQ31N0xmQvi6souxsJC0DaA2QUo2K186JjmHaT36i+EOdbnDvNKsQw4ha
vj8UKIIN0b5M5bxOcH4E74JTLcrrAT3Dv90wSSSTpdjreTXFvRKOMlMAzJBivMZg
kybRldu5
=eT5N
-----END PGP SIGNATURE-----

--YUkBHOJh79TcwdaF--
