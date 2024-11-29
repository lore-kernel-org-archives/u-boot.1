Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19143D6EC13
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 14:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2158935C;
	Fri, 29 Nov 2024 15:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Twb2Nfcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D785C8935C; Fri, 29 Nov 2024 15:36:20 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991528932A
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 15:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8878ec049so4466986d6.3
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 06:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732890977; x=1733495777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NZsvLbjCuyaTTiNH5VVBcnOfljUyKrBTlFmgc8K+q/Q=;
 b=Twb2NfcyhahvVlWLNEMWYfI9BVpWMauI//SVfzOkRcq9x9VSg5ZwedAH+Nchmxo/Gk
 YIxsVmI8DBSydcf43DiXYshHR4aW/HmHYzkUHcNU3pRvTXyjl94OSvRUgK5VUAk32qul
 8HAnczYjOWLcRIgxdlL9perDmITfZ6yuRWeB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732890977; x=1733495777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZsvLbjCuyaTTiNH5VVBcnOfljUyKrBTlFmgc8K+q/Q=;
 b=lKERn9/66LuqBNOjgpsd5Dc5ZmpEy5eu6oI+oqSH5RcFR+wih/HWRDCNBghRGUC6ao
 QzD+CaVlJgzp/QLizIf1J3mLk9hZcfWg/KWW0YfQ4X+QUCanIzt2LNy86l7uMN1udpMX
 2n6a6RYOy2Gd3OZzuRkZIMqDe3OrxEoQCxvEAVFmIt6QILehiMNvnmroB0XNh7/AteT6
 +YY7UdXN770QGsHtLSe2fQho4UXBZ2aF7rN82Fj4+EJL1ab5T4Lgj0PmprsDwNJx+lo2
 sqp6n0q5gqPkKAqS7JwzQG5VsOGXREUJ5G0s+1SauLvl2BTut2e8hBqJXzXGMYtJAZMF
 xQYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhN+xaz8KKTJLjeDfY2TDUoDcJg/YfqPgZJQvcvya2WhtjQHikX4Q+l8wOYzOUbHC3zwc1ux8=@lists.denx.de
X-Gm-Message-State: AOJu0YxJq8tl1n5xBU+IpVZOJXrXfWjuJXp4R13EOcwBdlEbzlwzpukS
 Jc5yaHX1AAEiFGNmVWEOFZ3gGIlNYUIMhMeuLGrb3pmZHpRT5o0ihisIZvnShJ0=
X-Gm-Gg: ASbGncvYJBS4QIvbisd5YrnREsATLvI6YppE8rfehLnCUXcJzo89sjQEOZQ6YyFdq6I
 sw7aSnQreV05IOvUrs5kTQ0P8AM6E2eU/M/NSlykgqwMIZQVHxJVl9MYFX59/2roNbFbQpKEKgh
 m8+wdWVyQZc+hvOpWgwkBBnFdv9vx4HGdWyqBt70+69cfAIvjWuKERfvsak2Kwo9ClVr3ZCroWs
 wa6tEQmrdSYfxcCMX0RweLCuox4WPljKEpYNus/O78kNKwLnQ==
X-Google-Smtp-Source: AGHT+IEo7BLC5O+M29p4wi4WxlQlKzIibOxpec3Qsdeg2TeuTh4+YJVczlRS6TIFra3ojpLQ/piOWA==
X-Received: by 2002:ad4:5ccf:0:b0:6d4:1e43:f3a5 with SMTP id
 6a1803df08f44-6d864d1abe1mr147383686d6.13.1732890977459; 
 Fri, 29 Nov 2024 06:36:17 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d875195da6sm16787126d6.57.2024.11.29.06.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 06:36:16 -0800 (PST)
Date: Fri, 29 Nov 2024 08:36:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Environment: Change reporting "nowhere" as "magic hat"
 to user
Message-ID: <20241129143614.GK3600562@bill-the-cat>
References: <20241128151233.1962926-1-alicja.michalska@9elements.com>
 <85619442-4c18-4cec-8176-d7239e023474@linaro.org>
 <CAOMZO5AsTCxvO+QuB7CGPu9nLeNmywo6N4XkNukTWtd7KtDZ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="31lJPDK4UkmFHzKS"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AsTCxvO+QuB7CGPu9nLeNmywo6N4XkNukTWtd7KtDZ6g@mail.gmail.com>
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


--31lJPDK4UkmFHzKS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 08:23:57AM -0300, Fabio Estevam wrote:
> On Fri, Nov 29, 2024 at 7:35=E2=80=AFAM Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
> >
> > On 28/11/2024 15:12, Alicja Michalska wrote:
> > > Make string more user-friendly
> >
> > I disagree. I can make a guess as to what 'Loading Environment from
> > nowhere' means. To me it suggests that it has not found anywhere
> > additional to load an environment from. It is a bit awkwardly phrased
> > but it can be understood and it at least sticks to reality.
> > As for 'Loading Environment from a magic hat' - I have no idea what that
> > is trying to convey and that lack of meaning is not, IMO, user-friendly.
>=20
> I have the same opinion as Andrew.
>=20
> It is easy to associate "Loading Environment from nowhere... OK" with
> CONFIG_ENV_IS_NOWHERE=3Dy.
>=20
> Changing it to 'Loading Environment from a magic hat' will not make
> things better or clearer, IMHO.

Yes. As I mentioned on IRC, there's one match for \"nowhere in the
sources and it's in env/nowhere.c so it's easy to see where that line
comes from.

--=20
Tom

--31lJPDK4UkmFHzKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdJ0VoACgkQFHw5/5Y0
tyx1Xgv+KIugw4X6kMA7c0Qyjd1qeTAqUVLHY7bIYxM/oYV8YBXvCuMLN3BdMjvu
20+rbLd6PG6LKwIcyJU2cfydN8wDzMURnayXRE74JLtLerbO8aHtj+YJqYkxqFC5
aogOwg0hy7vU7TYyEV/HTVxLVunvH+iElbDiXRuFYxvR8OD2H+5SR9G5uYb686DK
BpASTpkF293MUgBS7cWi2iSHEJXn4RV1TS5rFdbcX5Y+QUFtTMVQteH4RohBAXJD
J48MaHlrAZueaXA/5JM5Re5ZCbJRthuFgPzUXsJ7kHzDOGNFmIMQ1b4NBaWuKEtZ
mEvGR7NBEneCfkRVI7Y3goL/IZBUAGgI4DvPPTiK4gSZ9nFMiWEtA7qXoTysf8Ef
o3NbG+UhsO6saQpyiOk+jbRoXv61bLLkA0r3wFJDi/I2am+EADci8lMdofVNWh/I
8ccAsDjDsf2t8peJW1viCFajAQbPd7eaDFYbYPTu7mRiR4kFIwaxVdEMSB0OqpfL
sL5DMMck
=OLYn
-----END PGP SIGNATURE-----

--31lJPDK4UkmFHzKS--
