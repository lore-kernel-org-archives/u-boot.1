Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC94C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C745C80EF4;
	Sun, 26 Jan 2025 00:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nWJDUxPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9FD80F10; Sun, 26 Jan 2025 00:01:06 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE46F80EB5
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4679eacf25cso19563321cf.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737846063; x=1738450863; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m4iIpC7wVHtqFaO9FoWRNCf0Bk54LMgO2Pok9FwWKlo=;
 b=nWJDUxPlGm0B1b/m0cRkAGN+maGCDHU7b71z7dmHaa1/KY82QHhXjFfSwIQPFOCerK
 UW2KhVZWfqFUl8aomWzjUxAOP+gBaSFC1IFjwDLlXpnv0nV2ARxHsySXWbo1dDT9Yaic
 YPx7d29MozJ2gK5j+tSVmojfwlsA6kkRJAOpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737846063; x=1738450863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4iIpC7wVHtqFaO9FoWRNCf0Bk54LMgO2Pok9FwWKlo=;
 b=Fb3ZEMQAkIRET6FEmElYFntrZZEW+Sf2yi+9Dj3fEK/RAsbomq6wpu5aEoYdUQm3E6
 ZaYSbClsA0fvGWscR7Be32+ktAPw9LPhcnFSL8wzKhyyptTl2TvY2Ae9uX2sS02GbJ7b
 6NSVP2JZKXllnHtx/lEc8Fd0aFHyI44bcbqTjFEwhhFzv5oTs03VxvhBSn5+R3u2wkwl
 Ym/++2aWrIqoLqAedw5xDrtP59m6cbBKVlD0kkurUA+EiV7F+FcdcMfFTOKAIKTxtKAt
 wq+G4ltXn7GN2+An5G03wyJO7hHOPxmau8CofwfAmE7GXwPCdaWOVOEe5Xeuv9Pniyac
 z6Og==
X-Gm-Message-State: AOJu0YwHYKyHsH8+GTxVtJfUnWVsjy/GYCl7S36tDy3EaApm5lPm2jpn
 INfvA4LKaPKNyBRkMka2HD5uWYqtNExarI4ckuOuxUR0YKdHHqnwDyaJLsuRCT4=
X-Gm-Gg: ASbGncsFJ6K6svaJF345DEyLyp25c5TED8lYukSOMJhuvp5VBjxBLe6tYkV9x4CuHxZ
 DLektMP9AfBlI15odHRZj5Za5a8i9Ngowz1xXOWAO4elbklrmMMeaJn3MnZ575WmDGXLbETWaH/
 g4Jnd7MjBpN0C9FwrfaT7zEVoCnrQjZ8nROJLZ6ALn/XiokOWpaBk+X8igLeyv3v8UxbgXk+N9f
 /Rrztg02bSyozqI3ghERxdM2bnTPIbo1mHTh45q9RKZuiEtY8RN5SHarBZAR1kXepkKZ9eWkchq
 MEnd
X-Google-Smtp-Source: AGHT+IEW00KkcgJEg2vmUs+Tz8FtI/sr39w0OGgwXKBoJ9FSLTZHE/YP/kQBkwzPY62eufH4E49/qQ==
X-Received: by 2002:a05:622a:1a25:b0:467:50d0:8866 with SMTP id
 d75a77b69052e-46e12a55b71mr453401851cf.19.1737846062733; 
 Sat, 25 Jan 2025 15:01:02 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm24841621cf.41.2025.01.25.15.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:01:01 -0800 (PST)
Date: Sat, 25 Jan 2025 17:00:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
Message-ID: <20250125230058.GL60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
 <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
 <20250125225042.GH60249@bill-the-cat>
 <CAFLszTgc4=gFuDuZrN0LYRrN28w6QZPQRWdvKSzn4rq27RyEUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q1lel9kWH5/ldV/4"
Content-Disposition: inline
In-Reply-To: <CAFLszTgc4=gFuDuZrN0LYRrN28w6QZPQRWdvKSzn4rq27RyEUQ@mail.gmail.com>
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


--Q1lel9kWH5/ldV/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:56:02PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 15:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 03:47:26PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > > > > This fails on samus_tpl as there is no 'net' command.
> > > > >
> > > > >    =3D> net list
> > > > >    Unknown command 'net' - try 'help' !
> > > > >
> > > > > Fix it by adding a condition for the test.
> > > >
> > > > For this part,
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >
> > > > > Add a blank line to keep pylint happy.
> > > >
> > > > Can we silence that pylint? I don't look forward to the churn of ad=
ding
> > > > more blanks everywhere especially since imo it doesn't improve
> > > > readability either.
> > >
> > > Yes, but we would want to do it globally. But it isn't really a good
> > > idea IMO. We are trying to use PEP8 which loads of tools expect...e.g.
> > > my IDE shows warnings in this case. It might be better to just fix the
> > > problems.
> > >
> > > As to readability, I'm on the fence...in practice it doesn't matter
> > > much as few non-trivial programs have a lot of top-level functions. I
> > > would rather keep the tool happy and use the Python style that people
> > > expect when coming into the project.
> >
> > Yes, we should do it globally. Can we not globally also tell tools the
> > deviations from PEP8? I remember back when people would argue about if
> > we should tell file editors what to expect for whitespace, etc :)
>=20
> I'm sure we can do anything. But why deviate? Is it just that you want
> to avoid churn, or do you actually not like this part of PEP8?

I think it looks bad (personal preference) and we have that in almost
none of our tests I suspect so adding blank lines to make PEP8 happy
rather than adding hopefully a line to a common file normal tooling
reads seems the wrong direction. But I don't care enough to not apply it
if someone else does it. I'll add missing blank lines when needed
assuming the pylint CI job complains once it's done.

--=20
Tom

--Q1lel9kWH5/ldV/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVbSoACgkQFHw5/5Y0
tyzb+Av/WRL6GU1rGOUxDDMAs2SSqd2tJZ80K4CmsdcTcsWkI9wa+HDbYIiQyHpi
5NnGLSchPWXgkfWbDBbxJwG4lSM/cKQGfYtLbe7Q60I3Jr+aZAqxUcGoRUDqzHuu
ZsBt9qZnSZQ66Tb3oa9Vbnu20DZz4g2DyPQxnpyBlQTRe0W4Tx1LwCCm4mu1nMkE
4g2X6IRAVAuCsdFUGCQRaTrzgYABYr0x4D48kJAeuln0lAUKRFWXXcFdK3Rb6wdT
A6e7NnznUFNFSwXDQUSKC8H6UdxWObJMgn9H9VT3C1F3KdCC+XZM2zm5sEwzAISt
DALJXLRtTfvUj7WO0JDzCH0boiyjo+SAAyGtnzWZDZJYhpa0TFz6Y5RSNcJBDtCs
6c5T5bYgXJ1miOJ284b0iMaadOFZ9ALH12Ajr0iphzvUu0o9fq2dDjjDnfFlohyO
sz3ptTgHm6S9Hz3rOKLHYz5PUo6XIvC2xt4/9sQ1drBor3uloV4CguMSFHQdD49o
hZTXMrwh
=e25l
-----END PGP SIGNATURE-----

--Q1lel9kWH5/ldV/4--
