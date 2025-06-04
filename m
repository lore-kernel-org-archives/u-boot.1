Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7304C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 23:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214AA801BE;
	Thu,  5 Jun 2025 01:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UXpQoUeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F85D805D7; Thu,  5 Jun 2025 01:08:15 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FC18004F
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 01:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-60658e1fedfso195622eaf.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749078492; x=1749683292; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JY2ED5XrT0PP7KtKlqeisuF9GMBAH7cF6hz0nAj9oaM=;
 b=UXpQoUeAcwR9czrgZXOLdTEAxqKHlbGD4I71OZmHcSMtZrO1xjMyo00GXMMdYdxXD4
 1PxYO8BMAuCPHmH6Arshwixp4jki8QZZUBBKpDpl+qryec9fKbZzlzI0aPgWdlRf1sDR
 obM3JjO1faWLdxJ+chu8Eo3pq6rw2EAE8JThc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749078492; x=1749683292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JY2ED5XrT0PP7KtKlqeisuF9GMBAH7cF6hz0nAj9oaM=;
 b=XzsEvsryeDZ7fPgHzQAS2mKMTkKY/LaJtje8/E9fueYyQ4s1Ff0/jBJAQaQEFUqFtl
 b1eK8w3/GJUeD7HaK1JSl1OAOCZia99udVMR+gR2RbUkoVUXdM2y4QWlNFO6VWvPAj9R
 PFDqe8+yVvZeVhscUuYk+YTOJEAGFsI1+BrJ+JTV/eUTWUR5u4PzDYjwd3nBxd6g40EE
 55cvt825KlU2J4XDvoP3boTuC1hcsYj8s/QQneW8A5ZL6fK8NbVnbfgLRWU8TkVqXTV1
 kGC48VW8U7FmophrZEHA0umMl/fnz0vNiUaAXDXEqFsnc9vXOjXHVKUeqkxwgOuDBoX/
 n9Jg==
X-Gm-Message-State: AOJu0Yz0hORSV3F3F3+9dcPK15Zon1udsZNhJt0om9JZpFyVkGMvsq+Q
 wlg79+j31E0bfIu5BPSE4ntkLQcgdFtzB3809cjfTXExEO+mkjkjDR1nMZa9dqKDAyY=
X-Gm-Gg: ASbGncvxzsRiJuKOK2iSfFqrvJ6fTMujyetcDdDvdaBLmaAMJuY0kbQlbs4aA5CIQnT
 hLCQkUdvTDcWRFUDC++K8yhycFj3QlbzRU9aTeDvc3t6Bfo2ZS6ZmJY/faSZE603bjobMxF9jJw
 Y4p/V0iNADKrXpraPbfqjbuq1BQFvaT3/Azhcu87CSWPt2w9gYOLmGprP/Y3W9Ot6qJia3hoxRR
 cI3Sm3oXPBvtVBOmnpg+Qo3S84SSXb36eyhSDPkk/Un+LqSPIy3KGH5zBX1gNONTffsG0MbsC0a
 3domIdPArMnxgAGBokPa+Bav0k/umN2M/GIj91XMU/KfZvlGL9BZzaUYPgGrndTAJDD9/gLR4rh
 s8SawkUPRyF/F6gCxJCs24Cc=
X-Google-Smtp-Source: AGHT+IEix4f6bcyqIUM6fCjuh4xaF7Zz7X/W2Fuab0/vU23BI7MqXm3YLLh9w7PDTLO/yT3oDlPQRg==
X-Received: by 2002:a05:6820:987:b0:60f:b11:d920 with SMTP id
 006d021491bc7-60f0c59dcfcmr2790505eaf.0.1749078491745; 
 Wed, 04 Jun 2025 16:08:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c6fbf5sm2462124eaf.10.2025.06.04.16.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 16:08:10 -0700 (PDT)
Date: Wed, 4 Jun 2025 17:08:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
Message-ID: <20250604230808.GU1382132@bill-the-cat>
References: <20250516125430.1361912-1-ravi@prevas.dk>
 <20250604142510.GA1922573@bill-the-cat> <87qzzz1cpu.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mCz0DgR9jyFdVf5F"
Content-Disposition: inline
In-Reply-To: <87qzzz1cpu.fsf@prevas.dk>
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


--mCz0DgR9jyFdVf5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 10:19:41PM +0200, Rasmus Villemoes wrote:
> On Wed, Jun 04 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Fri, May 16, 2025 at 02:54:30PM +0200, Rasmus Villemoes wrote:
> >
> >>=20
> >> While not perfect, we can give a reasonable estimate of an upper bound
> >> on the necessary extra size by simply counting the number of hash and
> >> signature nodes in the FIT image.
> >>=20
> >> As indicated in the comments, one could probably make it even more
> >> precise, and if there would ever be signatures larger than 512 bytes,
> >> probably one would have to do that. But this works well enough in
> >> practice for now, and is in fact an improvement in the normal case:
> >> Currently, starting with size_inc of 0 is guaranteed to fail, so we
> >> always enter the loop at least twice, even when not doing any signing
> >> but merely filling hash values.
> >>=20
> >> Just in case I've missed anything, keep the loop incrementing 1024
> >> bytes at a time, and also, in case the estimate turns out to be over
> >> 64K, ensure that we do at least one attempt by changing to a do-while
> >> loop.
> >>=20
> >> ---
> >>  tools/fit_image.c | 80 +++++++++++++++++++++++++++++++++++++++++------
> >>  1 file changed, 70 insertions(+), 10 deletions(-)
> >
> > I think some tests need to be updated now:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1156824
>=20
> Hm, yes.
>=20
> I don't like blindly just updating such numbers so they match, but in
> this case I think I can at least explain the delta: The fit image
> described in 161_fit.dts has four hash nodes, so with my estimate we
> first try with an increment of 4*128=3D512, while previously we'd first
> try 0 and then 1024. Since 512 is enough, the fit image ends up 512
> bytes smaller, and that is exactly the delta seen in fit:size and the
> other numbers affected by that.
>=20
> Should I fold in those changes and resend, or is a separate followup
> patch better/ok?

Fold them in to a v2 please so we don't break bisectability of the
tests, thanks!

--=20
Tom

--mCz0DgR9jyFdVf5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhA0dEACgkQFHw5/5Y0
tyx8Nwv8Db2cutYqzrZPpDDuAhXK9/DgCqBYrJZhfUUVTM/m7/dblaisga+jh+Eu
r7tX44Y3+u1m1c+yyLQk4LvZ9GZWVlm2Lj8OrmCy+QKP9HfaOVzyJgXepHwvFY2t
Gmb0RuvucRNMhjMaVbdHvRQa3VTwm14HbCwTWeiHU9Bm27xbPX7IBgrF8+IPS6la
lLeisRLuY6B+n9Gd4Shf9Ih62iK6TS6BxU5osS5dSTLdaIgTebWM5gUkIJRA1G2z
8gQfE1Hrb9UL88q/pFpxZtX+9IYFFylVBYLUk18Q1BcUA3YMbNQ/QqsXcX/xPha6
LVwXA4NeINq5tqNWTwrVtvvcMIb+oNx2zxsFtycvJlDmnT/eqPRxaT6qeZ0HCznq
JTAu0lYyvG8GJTMcWQdUGe7WORrjvr9fqFw++i0vMTJI4A3onvC8iWAS6h3KkDQY
SJh8+mBuOShcNcJCcr0oY+YDewZpRHSAvKQWHVak37g3Vl19zSsjwSVOdznFaGyS
TXxcCKae
=yhWp
-----END PGP SIGNATURE-----

--mCz0DgR9jyFdVf5F--
