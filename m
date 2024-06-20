Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779C5C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3A8987DD3;
	Fri, 21 Jun 2024 01:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AIQO+373";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE45087DD3; Fri, 21 Jun 2024 01:15:27 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A7A878E2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c9b94951cfso807864b6e.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718925324; x=1719530124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FJLJhWvdWHajAYptqQlVTHNmTl0zaZx/pEXIQiJ+PL4=;
 b=AIQO+373q0dt9kNHmtopyUqZhlnni7ij2CAgatSCuECNwAOUw12cQbFgFWqCwjGytW
 /+ADZ/VJXHBXVXTZXYh5ieZEaHcZsuhl+jlFpzhisBDjc+N1SoOZs8Sstm7aRtyM5yRx
 9ppcYFEomfn9aTwrEtRxAy55DCqK0Bgkkw7sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718925324; x=1719530124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJLJhWvdWHajAYptqQlVTHNmTl0zaZx/pEXIQiJ+PL4=;
 b=g3MCIJW8VPdAfhf5ZE8OwVHKDYgSP8AgoFGYp68NhNNMjTgKBEoWO4zIjrwxN7d9zJ
 6YcWlD8I8rXFIjAJwq0aWZ9PLYhSP0nhRTFOa2UItHJDvizRTE6zc/jcBTeErReS1/1R
 n8IUNOoInUaaHEqkSk+CEKHc/1E+ZTRuHLnjo/uKeo8AMVXGOG7k28cRuSWgZ7ih+Vli
 fJrpNWnN9hlauy8A8xB12uM85sgFbEj4lr2wAJWBWpPNihzffaJCkMEf8JDehTtxy+6X
 XHrKE6ufDgOihplA/GiohCjoLJa15SZipZadgF/Yk+e5LK03N1zy2xsPo18tzgIsaACv
 fGyg==
X-Gm-Message-State: AOJu0YyQdNnLZXK5w1kx8mO1B/r4YR8xanx1hCh7rhocit6Njp0KFfwK
 WTa9Hfl8uQFNeVnqT4AQObNp/+4mUfrtk1HgtpcwoBIlRN4bj/C6gpuQW08DrSU=
X-Google-Smtp-Source: AGHT+IFbLfL4lKsZRGkwZ5Ef2z5DyJSKPBnfKMwEGzBKcevlcSWkk69MCa+sA+ZVW2avcTO3LKPw4A==
X-Received: by 2002:a05:6808:1921:b0:3d2:2e8d:be0d with SMTP id
 5614622812f47-3d51b987714mr7790220b6e.20.1718925324487; 
 Thu, 20 Jun 2024 16:15:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5344086c5sm90468b6e.0.2024.06.20.16.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:15:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:15:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] RFC: Add a tag for the world builds
Message-ID: <20240620231521.GS68077@bill-the-cat>
References: <20240620133346.1135479-1-sjg@chromium.org>
 <20240620143950.GO68077@bill-the-cat>
 <CAFLszThPrA3_B1cwcX208OFZT_GgXrHH4L5NuY9O5sDQwXKyLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Put5J+1JJ4RHnUb"
Content-Disposition: inline
In-Reply-To: <CAFLszThPrA3_B1cwcX208OFZT_GgXrHH4L5NuY9O5sDQwXKyLg@mail.gmail.com>
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


--5Put5J+1JJ4RHnUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 05:05:26PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Jun 2024 at 08:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 07:33:46AM -0600, Simon Glass wrote:
> >
> > > Currently the world builds run on all runners, including faster and
> > > slower ones.
> > >
> > > The difference can be quite dramatic, with some builders 4x as fast as
> > > others, resulting in just one world build taking between 20 minutes a=
nd
> > > an hour and 20 minutes.
> > >
> > > Add a tag so that we can select which builders run these CPU-intensive
> > > jobs.
> > >
> > > With this tag we can also increase CPU utilisation by running multiple
> > > QEMU tests in parallel. Currently these tests leave most machines fai=
rly
> > > idle, since we cannot run more than one world build on a machine.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This conflicts I think with Jiaxun's desire to make our GitLab job
> > runnable on the public runners too, and where we'll end up with 10 world
> > build jobs ala Azure.
>=20
> It probably doesn't actually conflict, although I am not sure if one
> can add a tag to jobs that run on public runners.

I mean conceptually at least as it will likely be slower to build the
world as 10 jobs than as 4 jobs.

--=20
Tom

--5Put5J+1JJ4RHnUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0uAYACgkQFHw5/5Y0
tywqiwv/d06rLRZpIYshu6n7tap+FFdMFKm7oO3EV2/Q1j7Pta686wIZMtypt57K
xxAcoXsUbq6Ibp6LmReBEqOL/zPgSjSeAUWGLUa2SGkY3B9M1W/mWOLtkyFV7ITn
f/o7nam6pLdNpnT5JPhlp6pL//NjZouJRcTu68dSd9KZe7kti5PEBcV5Km5Urt5e
QTfcvi9QhYZV0tCEWSd03DkDKliD8iIrVZgHN0poOnZV5wyTfTy9V7fFvtsHgZ4f
ikKd02KO5wRY9okLvQT4YswiulHtxL590V5yiZu2QW6HByYHR66JOvwa7sTe+RzR
+pw1VC2mt3R8kFmV1o1SLx74RLX4wZEMjDMmVv4lL9CfWa6fzluarhmWN4Nnmr8p
ta2jCdd5ciYsTRN89/F+j2cwA8wR8jD2z2m6GKdzcV5izloVWDzHO0lsmV3LQGiL
U8JH9S8YIMNO0KmDqWM/CtMynND1SZKiRuFUeMPqsJWhaLu2FGXj3kbjrRlaqbXc
3A5N10CD
=dN48
-----END PGP SIGNATURE-----

--5Put5J+1JJ4RHnUb--
