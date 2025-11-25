Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9CED0EE0C
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 16:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3B2840ED;
	Tue, 25 Nov 2025 17:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZXf69G2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6828984105; Tue, 25 Nov 2025 17:51:18 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4CC840E6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 17:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e8317b1262so6311029fac.3
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764089475; x=1764694275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n92xEnPajb94tGzD2YYouZfAdjso2poTPvdlxbDbOVY=;
 b=ZXf69G2rvLXo2ke7+6wfRc0tRVtHrFnkuXF8HpXdTloxBiTa9MUHgcsgt8cHii3vUA
 l6T4okeOjFQYj0WZiOkZSYiO+rwwSE1/nBqMTwRaHPnGTiECR9dZ3MiRzIjIA7qX8UOo
 3Nv2THKNTFQyWmMZ1YeHjOmUj4mRPqnvfEFvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764089475; x=1764694275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n92xEnPajb94tGzD2YYouZfAdjso2poTPvdlxbDbOVY=;
 b=WcSlv7GAjMgl+bN6uzKcFEclEf2mrjiDVRGtDUAVCs0v9GduSMmZABZ3kDFqdUL2mq
 yJLpBFGVF0l71aiGX4b3fwOqrFaWOgwIi1QgmEqdxOqMe0biQpcHslIpL0lYYSE3fzbb
 YMn5/s1YSw81FaUmOMobHLUzxt5bhDkiv5bhuLBQ5RD3KPrQTXimn7mpJ2iVafqYvAzh
 UeZIFIzQJ1km5RE+/wLgIjuPWpyk/EZ+9UX2Av0nzmwHZCzGaVgYVHqQ3ecaoXkBE5Dq
 9Rky7pd43zLaqLM5f1rRXJMjr+H0E0ZATm7Oc0kK+Sx15SVjXR63gv5yU5aIkP02xOfx
 +SSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgAe9cZJu7vf6kb5FWLGJA4OWXcxPBckg/ZVtxijXRAeiGO2o24o+l47YxpFv5D9uumdCkLsk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/hYNNssA5CyQsCRy9W0ndnhI3Vl4LNAGV8SYLIjcaar9GJRuH
 FDP3QLFofAcgHQJsYodsQvjF1H3HdEFCeEbYMQ9QHFfjd2Wo6dqSzBHjbSio5l+X07/+OQ7aauZ
 /tKUNVVw=
X-Gm-Gg: ASbGncvG1tW3b6fGHQsAzBbgjXT7eOkibP7I2DuTDSTIYfMdbQxvGuuvg6s7x5AgORg
 kGLIuuYyqIaDEgpYv7xweF/u/OVLQc/FVMP008zobH3ULRgSHoAKFKTCAbMgpUFfFbqp4Gdmuwz
 66ZrlTiz8dzijHWvUK+d/eiWR6zNJDPM3J+9rLfwmba2EnXxiKM8Fd7QjJnZGFM50DtJe8C00qN
 DWzwj10ptvIHShi86Sfzyn/ArLYqJqZRYMZ+gYwvXN86C/3RhFYxbCFb4F+Z7SWuOi24SVMImVn
 2Pvkezo1rooKtU//yCb+9Ln4lvCE3SdOMhChwDiCSLI4ALI0orfPfwL2uudbAg/8wjZengRoulA
 /tlb0GOXdJLVxn2QgoJQa5ZeUunH0R6nXSBfAILQbTZTjpTDaHWTC4e8LN9TvK1bhwzxsvhlq/O
 9VcTVezzi6W+Ybx/Gv5lzJirCCLP6YAcQNpP16QOvJUb032GdD3w==
X-Google-Smtp-Source: AGHT+IFqBMQ5CAFmfXWF/TIubG++HjK+aFglg2KDPh1IDI3vXyL4xSZQIJqH6f0bcS7tOCelr58k5w==
X-Received: by 2002:a05:6808:c165:b0:450:ccef:c00c with SMTP id
 5614622812f47-45115b887d2mr5214386b6e.48.1764089474768; 
 Tue, 25 Nov 2025 08:51:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe6893csm4662623b6e.9.2025.11.25.08.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 08:51:14 -0800 (PST)
Date: Tue, 25 Nov 2025 10:51:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: David Zang <davidzangcs@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
Message-ID: <20251125165112.GR2125796@bill-the-cat>
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
 <20251028165056.GG6688@bill-the-cat>
 <CAPLW+4=JOiPk+gOHH4umevJxJweitAn3dpec1xTe9ZrgCAVAMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZEvUomXIMkEyHUb1"
Content-Disposition: inline
In-Reply-To: <CAPLW+4=JOiPk+gOHH4umevJxJweitAn3dpec1xTe9ZrgCAVAMA@mail.gmail.com>
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


--ZEvUomXIMkEyHUb1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 02:49:23PM -0600, Sam Protsenko wrote:
> Hi Tom,
>=20
> On Tue, Oct 28, 2025 at 11:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Sun, Oct 26, 2025 at 07:24:58PM -0500, Sam Protsenko wrote:
> >
> > > Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introdu=
ces
> > > inconsistency in how the countdown is displayed. For example, in case
> > > when BOOTDELAY=3D5, the next output is observed during the boot:
> > >
> > >     Hit any key to stop autoboot:  5
> > >     Hit any key to stop autoboot: 4
> > >     Hit any key to stop autoboot: 3
> > >
> > > That happens due to different printf format (%2d vs %1d). Moreover, t=
he
> > > mentioned commit fails to handle the case when the user is holding so=
me
> > > key before the countdown is shown. E.g. if BOOTDELAY=3D101, the next
> > > malformed output is being produced:
> > >
> > >     Hit any key to stop autoboot: 1 0
> > >
> > > That's because the fast path code wasn't modified accordingly, and st=
ill
> > > tries to erase the number using '\b\b\b' format.
> > >
> > > Fix both issues by introducing a dedicated routine for printing the
> > > whole countdown line.
> > >
> > > Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >
> > This seems the reasonable path, given everything in the following parts
> > of the thread, thanks.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
>=20
> Since there are no new or outstanding comments for this patch, can you
> please pull it for the next release?

I'm going to take this for -next rather than master, soon, as it's just
cleaning up some output. Thanks.

--=20
Tom

--ZEvUomXIMkEyHUb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSXeeAAKCRAr4qD1Cr/k
CmyYAP9jP4azyvoi7S8v6rwcC5Awa3q6Sh+qi+BtutwRg7lW6QEAlCEIyqxovTP9
Zpy7JwkwFJ4BERg1ZYs5hWzZTh1yhQY=
=G/p7
-----END PGP SIGNATURE-----

--ZEvUomXIMkEyHUb1--
