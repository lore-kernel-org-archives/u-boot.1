Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36864C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FF482E37;
	Tue, 15 Jul 2025 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KUFqE/9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F67D82F14; Tue, 15 Jul 2025 16:29:36 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC6982BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 16:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6159377569fso271656eaf.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752589773; x=1753194573; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F/VG2hxu4L9Em9ceotqs5p8G/HsymAVE81H8bv4apJI=;
 b=KUFqE/9GEsBNzgRx4+datPmbR++oEg2TKu15QaOqfUdWM20dGccXL+5vcfwJZ5Ud+6
 5A4Rz6sZXsJPCr1+saJRAz4OMW2aoIF+qkg+cRZ3x1Vcuo7Uc1pBKAFk6GJK3+NQtcbb
 792tuRu/0TDU2/kGEkMryDsTS5219QUjthjGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752589773; x=1753194573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/VG2hxu4L9Em9ceotqs5p8G/HsymAVE81H8bv4apJI=;
 b=hXyc6A53jGNk+iR8aiNfeAvDrTpCSiu0LdDq20r6aTMUoG4vvmA59On8XO3L/tevWW
 fN6860F6TRv/7Rrtsx5srq+YRtstm3ROKSTL1AK5ktzcUgd+fYes0xRVxI6js2aa3RRG
 AXjJY9C9O+xX1bOgpBQ+HjXAn9cqlyrG95SHe97LlJyx37v3zEc5XBRACbLJBy4AzlvY
 4IdGp3O7/OeA8wwD+NL++p9BIOh67HaidzeTJc2Ao31DVj8Drc21DKAcBcgLhcK4XzBg
 Oyzt8tXu+iC1R05NksAe8qeMSsjpBBY8N+otfF2TnQz6EXuFFh3CuM6BQZpNDUfpFznp
 eaAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmIZS5PZA1kpuXyzmwC4XXpjRrcK7jP5W2UyrRN1s6T6Y7hcrF00nsC96dQrFkxDLPk2RXcaM=@lists.denx.de
X-Gm-Message-State: AOJu0YzUYHmi/vLYiaGUuVMOwvpEhfaA/Gb/hpgf6jj2Qg6mlkLPNQyo
 Rt3OnTGOzg4l4a00EyMYAnExwoS1Uz9cWFw9tbtgc3GmF0ehKl+TsG7xi103ix06sCg=
X-Gm-Gg: ASbGncsri+uX0J8G1jaGceCQmjIYi/Hy82OZKsD+qxfDAHdhGpMfVThFVgZla2qcyKt
 22i6/azpNAXyCRBL10J5vuyzjh1XPDIaMWY84PVQ0s3Yd56Aj6uX4EuykzC3+4PsdcRwOu94XxW
 tipmJzSJTYRk69GTojuq/AgC7fBU/EsbuI/POhApvt31UbNc74q3czqR93SvDM0BZCxQxO+XdSc
 7YlIGfz+TVqDRUD3mWuurebGgXepZ6TCRWQKDFpJRLO+OZn1luprUCSq1E7P+it4Ou8NzCtSA0a
 /b6ibzOi6mlz6LKDjOI3p3463BllkTIj3z3fJ+1uYPh+Eh8WYvKtCT7r6B2Ela8JLfqZ4811ABx
 cNQQcAvEoD1k5k3GE0GQD/5EXa2ll4strRJ5l7JXtxpzIIfr1b+zrsR46
X-Google-Smtp-Source: AGHT+IFqrgXLu0g6l0qqL62EnVN18fvydUubvVqW4v5h3vJJcMt3gCmozbHAFUBVtSIkH4w4G/vVLw==
X-Received: by 2002:a05:6871:430a:b0:2e9:1e11:3183 with SMTP id
 586e51a60fabf-2ff2683bc88mr11484906fac.8.1752589772971; 
 Tue, 15 Jul 2025 07:29:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e63b94769sm30076a34.21.2025.07.15.07.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 07:29:32 -0700 (PDT)
Date: Tue, 15 Jul 2025 08:29:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH] kbuild: Don't mandate gcc as the host compiler
Message-ID: <20250715142930.GD193579@bill-the-cat>
References: <20250712104558.77355-1-kettenis@openbsd.org>
 <87o6tpb5oj.fsf@bloch.sibelius.xs4all.nl>
 <552de3f9-d9cb-4d50-b7bb-9e6b7bc12ed9@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HoxeDcLXsa3MPcqc"
Content-Disposition: inline
In-Reply-To: <552de3f9-d9cb-4d50-b7bb-9e6b7bc12ed9@cherry.de>
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


--HoxeDcLXsa3MPcqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:32:49AM +0200, Quentin Schulz wrote:
> Hi Mark,
>=20
> On 7/12/25 8:54 PM, Mark Kettenis wrote:
> > > From: Mark Kettenis <kettenis@openbsd.org>
> > > Date: Sat, 12 Jul 2025 12:45:58 +0200
> > >=20
> > > Systems that use clang may not have gcc installed.  Set
> > > HOSTCC to cc and HOSTCXX to c++ like we did before to make those
> > > systems work again.
> > >=20
> > > Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> >=20
> > Just realized I forgot my Signed-of-by tag.  So:
> >=20
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> >=20
> > Or should I resend the patch with that included?
> >=20
>=20
> I would recommend resending the patch so that it's less work for
> maintainer(s) when applying the patch.

I "b4 shazam -S" most things, so this is fine with me as-is, FWIW.

--=20
Tom

--HoxeDcLXsa3MPcqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh2ZcYACgkQFHw5/5Y0
tywRjAv/aJyjf8qKTyBQfONIhEYEzwun3jroX2vgfEGviV7dFs3YAQn9od9snw8I
HWFAlC1rRBQm6UYoh66vybp2uDJnfHJN58Syr59E1mDmA2E8n3DmHX6SfQy9pYuc
tf24O0PJetqqsY8leKz9sNr99TOpTd50VuTroohaGZ66rbmdI+DIcnhKcyL8El0t
ELQ2S6edFyk1o838Zit6WnGh9rZEtl/CRb1tr5KhMNkooIdUBtGt+yVJQ7RsYFBb
Xr3CJ0rlqSZdeViMym00WarhqdiOlcoGDAFceE8PG06sIqJOgIWxCUCJkkM7YdHJ
J/j9VKQuFf6VoflUU0VjPidCZITjSFowZDU2g0Xa72LN5BqCoy2ozdKywpxo99+k
clZzFPzBebE23cOh4DVsW3TWeG6axHb4MKE4RIlGrNmUDUgSCKsH365Sh+YVWsD7
uHcw1MKVYv2TkC3lbBHCzQgypiUA3C091FO+QoJcPJb1raAVyubT58cyDZmGFhmQ
FnNXUW8o
=pKzq
-----END PGP SIGNATURE-----

--HoxeDcLXsa3MPcqc--
