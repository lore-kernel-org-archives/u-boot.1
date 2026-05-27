Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47717CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 14:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6BA4844CF;
	Wed, 27 May 2026 16:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lGQpFku0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC579844CF; Wed, 27 May 2026 16:45:19 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA96839A8
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4855003fa6cso3513718b6e.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779893116; x=1780497916; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q+THcAUaNN4gwUB/TEGFFTlHiRtwcRY5v0H/wfIF7Hg=;
 b=lGQpFku0fhnrspLRXJ2Tt6vUH6+z2RQFUbrov8U7OvOfM+bOWPPvaa9BcV17ksyhIo
 ln2Qyf/8XtjDe642gyk4CQzYaNfpXwAXWCXu2rD7tIbpJ7obBSBJHibeg1pjUMrglllY
 HZ3aHY6MTAMcPX8xY1GppE41elnrJCJI37aqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893116; x=1780497916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+THcAUaNN4gwUB/TEGFFTlHiRtwcRY5v0H/wfIF7Hg=;
 b=sUWcqr/qu8zO+ZM/N0/JaAK4CpvSJsvgf2weNw1DVxz2JJ8+qeB8gff8DnLEHFPDtD
 MYMRjM6lGzvS6QXxvr+v2OprQxPCd9/RPnY4AkQ1J0Peun/5MAx+ID216kWcL6GR4fu8
 nl12UJhnAw7YFW+3lwNTtpIgRPt48AR9e321OK9atPdcsaNaoqY0K3K9dVaA1kpGAe6f
 WiMyzeX04MmzdhlFzm28NklIVG/C2Yn+2TX1haoCOJN0DAZqsMg8vcJ3tcCHuRy+QjdU
 qaFBmQcykUqNXeOxZYM2UeAI4zFKK+LEOMwK7r2mH5Cjd0orfNtjdRqsrZgBSvzgXzTh
 RuHg==
X-Gm-Message-State: AOJu0YzH6kFJPO78lWw2BjonCr9zfnwkJrNXfqSP6HgGj8akRhxuzRjr
 ZAo7XVL63Sogga+fl7Xr3wEEao0EVuZJz3AAKqBGnMSkhEB/XX11WN1yGFheUEGKwAg=
X-Gm-Gg: Acq92OFu1Fo70olzP5WTNV8oY5qX0TIvEoV2MWZ0pTNqr2cTUDYwj6rR+2AgjMj3GGX
 yHNRbpn+q3kFf+rWN2WmOSNLfVSu2ElLYtY8ZJWHIt9FVP2LulUqL2br948rFzEBYdBPRYNam5L
 py82wYK1Kn1qVUKBAyZzYo8Rtg1vNaxFJcvEmzsHjP9aPXpN13aDKOWiFz+WUhykuKwZfC57526
 QcTmVqts27Q5MF2HCu4Q1lXSknLjOC6ihAdjSi5Z6Abh9VE/hdVuiBwuSjsbxq+jjm+CW8yjnKE
 XYmq+0NoibHi2pYBxLtiw4OUZsWekWV7dvjAVoku+ywpRDLTEXcSrxftr26ZWjbbSbZ2ENN1Y6v
 Uuu6f7CZA6o3K9Tz3bEwE5WhGD9WeG/GP1UDCojBsZcCFxovNZ7ksBdgJ+ObiVWyuFAB5zkMT+2
 PG3qaBS0EC+t0YbXquYuUVAceMbu3nu7oLrGwlQ4RXH0RjyGb+pZXnGjzzRYDFAyHSjhIO6z2y3
 8YOWnCjMc7zzYYbtMqkkx+Vg/XkMOQ6+QGUugjVRoYQKrICJmwHrvhv
X-Received: by 2002:a05:6808:191a:b0:47b:d914:48c3 with SMTP id
 5614622812f47-48549cfca30mr12680040b6e.10.1779893116500; 
 Wed, 27 May 2026 07:45:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b639fd705sm17801688fac.15.2026.05.27.07.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:45:15 -0700 (PDT)
Date: Wed, 27 May 2026 08:45:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>
Subject: Re: [PATCH 2/2] dtc: libfdt: Introduce a can_assume check in
 fdt_check_full
Message-ID: <20260527144514.GE1858239@bill-the-cat>
References: <20260526202218.4004070-1-trini@konsulko.com>
 <20260526202218.4004070-3-trini@konsulko.com>
 <87a4tlji6v.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7+ChDf3utLhv4HmU"
Content-Disposition: inline
In-Reply-To: <87a4tlji6v.fsf@prevas.dk>
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


--7+ChDf3utLhv4HmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:49:28AM +0200, Rasmus Villemoes wrote:
> On Tue, May 26 2026, Tom Rini <trini@konsulko.com> wrote:
>=20
> > The current upstream method of having a function omit various tests is
> > to use the can_assume macro. Take the logic we had previously been using
> > and instead make it a can_assume(PERFECT) check within fdt_check_full
> > itself.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > I will be submitting this change upstream and will follow up if needed
> > here.
> > ---
> >  scripts/dtc/libfdt/fdt_check.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/scripts/dtc/libfdt/fdt_check.c b/scripts/dtc/libfdt/fdt_ch=
eck.c
> > index a21ebbc9239f..7509c11d8580 100644
> > --- a/scripts/dtc/libfdt/fdt_check.c
> > +++ b/scripts/dtc/libfdt/fdt_check.c
> > @@ -21,6 +21,8 @@ int fdt_check_full(const void *fdt, size_t bufsize)
> >  	const char *propname;
> >  	bool expect_end =3D false;
> > =20
> > +	if (can_assume(PERFECT))
> > +		return 0;
>=20
> Is this right? I think that would require changing can_assume() to test
> if the given mask is a subset of FDT_ASSUME_MASK, not merely intersects
> it. When called with a single-bit mask, those are of course the same
> thing.
>=20
> Because as-is, can_assume(PERFECT) is true if FDT_ASSUME_MASK has any
> non-zero value, but I don't think FDT_ASSUME_MASK=3DASSUME_LATEST, for
> example, should imply "perfect".

Honestly (and I mentioned this to David in his reply on the
devicetree-compiler list) the usage of the mask today is either 0xff or
0x0 and nothing in between. Which means yes, I wonder a little about the
can_assume macro as opposed to how the mask was used originally.

--=20
Tom

--7+ChDf3utLhv4HmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahcDeQAKCRAr4qD1Cr/k
CnD7AQDksMrvA5JwcCSz9wOTiwhWoYfAFKio/WPXuoiRRubbkQEA6/P/TX+C0cP8
egLO4fmTzXqjzTdKDdVeIJVLhFTr/AE=
=pR16
-----END PGP SIGNATURE-----

--7+ChDf3utLhv4HmU--
