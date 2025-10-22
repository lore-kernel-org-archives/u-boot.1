Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909DACCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0851D8334F;
	Wed, 22 Oct 2025 15:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WrWYl4u9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6E0833F6; Wed, 22 Oct 2025 15:49:35 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F008323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c28bf230feso917803a34.0
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761140972; x=1761745772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LhJMyclE1bcM2jB0HiAw83elh7+1YrFt/22U6jeyZyE=;
 b=WrWYl4u9J7fFclRGJF92jUxFHt9fz+BQQxXuYqUlMOK2Wv1jx3MF5/aQ94knob5YAx
 rOqjup/8YzepJNu/TvZfjElllG+6aISKrfzrZTGrf0rgS8loidkCCYAIkvkodO1jLZtP
 XqzEDrA+GgXdHGbGey2j2lW+FWNtk08nGvB/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761140972; x=1761745772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhJMyclE1bcM2jB0HiAw83elh7+1YrFt/22U6jeyZyE=;
 b=cLrizbfmz/kItEZNpjOZ6BYbS8DJcSsAYUyMVnjdU4o3TJRe3vaARf6ADLoMOa6RDX
 pvf1nhJ3C0FjrSp4yhCPAElYWSk2DnM00r/0Tm9/aiczaww9WgQZAYNAbEbmgp8yTt2N
 YBVuvVI23JzdupB2gBE2/XgYgVUC6q/qzLIaVLRe4DCVoRkp4ex8LniesvYN6/LhM0Br
 gT1UEkYNRd/C6Cucjm5GVrJmBai/u4yVCj5OXqwbwGQOdYn4+IKN3nACyAuv8RCefwXr
 GjUfkMtlUUjDvcVTgtRWrxyqJm9BXnFDlOi3CLgLVuJrLgR6QCf/Rw5XuRo4EiCB/lg5
 v6Xg==
X-Gm-Message-State: AOJu0YxQkvq+z2Buo0g23HBt2a2f2mISfwRk6LknA7TzHBt5pW+71SzU
 rmN7pDMVjjJYSOXpTLxnIVe8JtN1U14eBEDCBktFCVsfjKSQcPnEb7h6v74aSw+OhD8=
X-Gm-Gg: ASbGnctaN+mnTcgbsD0PV5dyAM10iODrrbpdiJfNI3mEgNDCVXABFKNdqRzqpfCd2g/
 qOdbSk7cScunnvmpFjZlgfoz4fhBLQu8AodExDdsLVB9BtGnm9NfT9bD6PtXFgRrKyXmUnpGJfa
 xunTa4lxxSCMX+nkCqn3bBFcvYXgi1hKgCmojFhgl+o8kY9JrA/aIiWUvPGVp0AKbDsmrNXne5a
 HVwGDuPQ80VAme72mw8CUAtasQb+4lb8kirEk8HXwTnZGFYaJ0FbGd7b+MpT1DGqrW9oDv2kXmx
 hPmNn7ku7/rXQ7QSDjRx22xxJN4pPmx5PDjpxO6qrB2deU0YORCNNAu7HaVWvSxjNrEUNJ5qCvz
 B+rlEJTNjtzqPnd3z0ck5WkvKSeW24J47IDPF77kWBBTI9/7bfUPvpml2YH5AHkuVGI7iQs1MG4
 DS6OIVMSOhgn/hmc1QjtCfmHYCeb2pET37PlaD6TM=
X-Google-Smtp-Source: AGHT+IETI4Dlw/k6QVv4HcooFg6XiulsyurOVP75HvqLh3z2LO0L0DPV0QWp9BLO/LiW/eUeUs/NUQ==
X-Received: by 2002:a05:6808:3196:b0:43d:2e4a:e5c0 with SMTP id
 5614622812f47-44bbc476d43mr576317b6e.1.1761140972156; 
 Wed, 22 Oct 2025 06:49:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28890f2a6sm4613216a34.24.2025.10.22.06.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 06:49:31 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:49:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/3] doc: askenv: Reword and remove return value
Message-ID: <20251022134929.GH6688@bill-the-cat>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-3-trini@konsulko.com>
 <0fb1e175-6e50-4f2a-a1e2-98ffe3108998@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JAbqGweWPJ0S21l7"
Content-Disposition: inline
In-Reply-To: <0fb1e175-6e50-4f2a-a1e2-98ffe3108998@cherry.de>
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


--JAbqGweWPJ0S21l7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:28:15AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 10/21/25 10:25 PM, Tom Rini wrote:
> > With the addition of general text about how the return value is handled,
> > remove the examples from the askenv documentation as they are all normal
> > expected results.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   doc/usage/cmd/askenv.rst | 27 +++------------------------
> >   1 file changed, 3 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
> > index e2b3c5379aea..a8867ce4d266 100644
> > --- a/doc/usage/cmd/askenv.rst
> > +++ b/doc/usage/cmd/askenv.rst
> [...]
> > -Return Value of askenv command, when used without any other arguments:
> > -
> > -::
> > -
> > -    =3D> askenv;echo $?
> > -    askenv - get environment variables from stdin
> > -
> > -    Usage:
> > -    askenv name [message] [size]
> > -        - display 'message' and get environment variable 'name' from s=
tdin (max 'size' chars)
> > -    1
>=20
> Shouldn't that be -1 here to match the expected return value when the syn=
tax
> is incorrect?
>=20
> If it is 1, then it's a difference to the expected return value and thus
> should be documented below?

This was included seemingly to include the built-in help message
in-text. If desired, we should figure out how to do that automatically
and for all commands.

This is separate from what I see this morning right now of any invalid
usage returning "1" and not "-1".

This is from sandbox build yesterday on top of tree:
=3D> loadm y y y y y y
loadm - load binary blob from source address to destination address

Usage:
loadm [src_addr] [dst_addr] [size]
     - load a binary blob from one memory location to other from src_addr t=
o dst_addr by size bytes
=3D> echo $?
1

--=20
Tom

--JAbqGweWPJ0S21l7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPjg5QAKCRAr4qD1Cr/k
CtYvAP9+iWehAajj8KS6MwGvf21Mwcja9r2aOub5IBCNsPBmPwD+NrHZ+SvDTAP+
/v9pO8OpJLmodQbYOipCMy8R4QWneAc=
=sVH9
-----END PGP SIGNATURE-----

--JAbqGweWPJ0S21l7--
