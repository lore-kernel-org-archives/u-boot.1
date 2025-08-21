Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18F2CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 00:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D320281E13;
	Thu, 21 Aug 2025 02:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qyaQuq7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE3282B07; Thu, 21 Aug 2025 02:22:30 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E182801DD
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 02:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3e56ff1c11eso2204105ab.0
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755735747; x=1756340547; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Faxh2bENrFBPLwgc0NxHNsPPbVzBZA5K0Gv4fpYpCg=;
 b=qyaQuq7wuz8yOgpp5ZeumaSnEHYP6PFvPl3OuHLO4ibBAo0WhHnA9p2wU7te4n0bOb
 JWUZuIngUt3C74rCXHnKzVBroPnBEobVtvsflSwT7CXrA0vKBWEFanQ6JNDB/tEc2nNf
 mXiRATF6newyOBgysXATIe7rMQeDVMOQH3K/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755735747; x=1756340547;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Faxh2bENrFBPLwgc0NxHNsPPbVzBZA5K0Gv4fpYpCg=;
 b=V2ShpCb7hgnrD0Krqc9J3DamNHw/RK46uXonshSms6bxg1wkY9615Nlwp9Q6n7Xfr6
 v7CJytwhNBu/QRZ0OCd6Pv/SayAbNYyc+f21J+heyWyXCIQNb/9uVoxxFBDNMHWO6UXb
 qUmA83tMPJ5m03FsStjUGANWdqf4whs9tjQTqcfaozTK/6sFQYlvOLi+vwh3Ycf3PSCx
 46oOuYTrFdzeEdQv5hh997I0CNX2QkDhHWVGdXLy6E3Sv9Z7PtEaL/saUAXQisma+EAJ
 qVO9Qd8pn3yg81o716vgeG6mdcvykgzSb7znhmuqZvQ1R2Outc/NoM35c3bLQxYtI1WB
 ufTA==
X-Gm-Message-State: AOJu0YzdHQ5iA2fiXH0LMWD9k9dcX1Z7Q81ovmoRoyltSYx8EMKK2ZP+
 0Lgp3leE/i/cOflMIp/rKZRvY7FOSNGId5WPQbr4yzVjNpOzPbMRcqTn/wwnRE9ooI8=
X-Gm-Gg: ASbGncsrjAk+GGEr1VN5fmGEJcUygvQXtdQ3Np5ws0P2fBRlG3slCwNeiLzQZGhPOKY
 iev3IvTZEVEY0JIRo+TArOiTjVlyBTcpgDFGB+TDCtK5Mo/oXVrsOWYGSGHPtSXLXc/PGVflI5Q
 5hYGASJROcVd1e5wrbbAosUx9BonkOeoRhSVj4FGApBQEuEqe/695+Lm6eU2efnx9hdaV/4p+/Z
 MHZ/TdDVQfD08B1qIXVoXnilxxaoa0x4866T6cduEUJCb/xYOYQTy4hEvzrBpM8/XN3W1BgDWhe
 qOAXOV2UouZDIAiK3EOgp7gJrgPZhKjSor48yTBrl6AQfSHBL/Sppbgw+cPVQVKQ23XxKspRryr
 sgqYAmbX9KrbXGULLozorM0n39Ia5v1axlxCqVk6iXH1fprg69mSo3m16
X-Google-Smtp-Source: AGHT+IFPs53dudlN2C4ei5uvj7ogSXfNLotBFYYL/ZDoPTimU08NvKz2f9+9QBw6/J6F/hn48IaJnA==
X-Received: by 2002:a05:6602:6692:b0:884:552:d2be with SMTP id
 ca18e2360f4ac-886b48a0e4cmr124185339f.12.1755735747105; 
 Wed, 20 Aug 2025 17:22:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8843f7fec8esm589495839f.4.2025.08.20.17.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 17:22:26 -0700 (PDT)
Date: Wed, 20 Aug 2025 18:22:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] lib: use utf-8 as encoding for C includes
Message-ID: <20250821002223.GJ124814@bill-the-cat>
References: <20250820231711.45677-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f/QxtQM8urZQf4Lf"
Content-Disposition: inline
In-Reply-To: <20250820231711.45677-1-heinrich.schuchardt@canonical.com>
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


--f/QxtQM8urZQf4Lf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 01:17:11AM +0200, Heinrich Schuchardt wrote:
> Correct spelling of name 'Joan Lled=F3' in copyright comments.
>=20
> This avoids warnings in CI:
>=20
>     Skipping file './lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h'
>     due to unicode error
>=20
>     Skipping file
>     './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/sockets.h'
>     due to unicode error
>=20
>     Skipping file
>     './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h'
>     due to unicode error
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h  | 2 +-
>  .../lwip/contrib/ports/unix/posixlib/include/posix/sockets.h    | 2 +-
>  lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h            | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Which test does this and can we just tell it to ignore what are
essentially untouched upstream files?

--=20
Tom

--f/QxtQM8urZQf4Lf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKZmuAAKCRAr4qD1Cr/k
CvfLAP4rrznXdvDSG3uH/XJlgNgjh/qgPV7jdnO7YGxe7twLYgEAxXBmTnIVpmOm
dHLCHjjexVY1vZH0x2Y2Z87Hwthq+Qc=
=VTQx
-----END PGP SIGNATURE-----

--f/QxtQM8urZQf4Lf--
