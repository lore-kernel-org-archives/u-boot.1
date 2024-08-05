Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D243AC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 18:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5201884CC;
	Mon,  5 Aug 2024 20:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ri4zpbhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD74884CC; Mon,  5 Aug 2024 20:14:22 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FD9884CA
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 20:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7093472356dso6427429a34.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722881659; x=1723486459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q/OiMiKsO1OHRkP8UPJyCNJop95yAgRHbNSis4+VCxU=;
 b=Ri4zpbhDEaaw1eghEb4HAJwFrNDYVVJQu15s1RVCwZ3U5+3/VWqJgst/99D5H+nZcs
 7CAp2WXU7J4cYLwNQ+xhFsU5QL0W/lqNT8DscILXM1hbvje3ij188Nypd7e1CuOxMP70
 vzvZkqK81n7+jv/tgiKpF/sB15tGNySCeO8XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881659; x=1723486459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/OiMiKsO1OHRkP8UPJyCNJop95yAgRHbNSis4+VCxU=;
 b=paHNrwTh6fkla46J6raPTDT5B7EaQJLafy0SzWgucBA1/xBeEayqNdtLxaBmN9QKTh
 sNf7JC8mvIw1RJQfGInCKZU4QsNig4tqErmDI/I5X9OZgJ6y9J/e3qHdYnYSG/KEFPrq
 HwK/o9km41TNQ9MGb2ajrPRmcdP9Xj2uv6qcNifiOqM/JEQObHp109+b8egqWCYt+++D
 94UNABeAS2wb3pzaE1bD5N7JOydZKCgM414pYAmUYMm/2bBSPZEOX4mXml0INc0aFZBT
 XJbrvijIXxAP6/ELb8N3EsGgRGHinXJU0nvkbGrWiXkotXFNimGEq5n2VDu+GzVCZegg
 7YAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKa/Kh+3WmlgYavxtOAeHsAked96sPJeEyA5r0/sKqKtRZIOa4jRcZLnLiGlY8PQCdbieShZsp0AMKm7O2n1GlrK3vfQ==
X-Gm-Message-State: AOJu0YwtyaKKrG+NGRfqteq/YhNeuf3Z8PdbFGTWPgT5Eefv652KazX7
 AGt4BuCVZlF5CUp9RGq7R8AvDNVYcDdX9aPf1kMqg9dTRuarp/A54bbgc1KQ9oc=
X-Google-Smtp-Source: AGHT+IGftT1IGfYNGIa3a3zDNRVFMpdX0KpBM2YUaPAE8KvmyLqcw3hYAsZEmwDMXjxna3JbLHgkHQ==
X-Received: by 2002:a05:6830:dc9:b0:704:4bb7:af8a with SMTP id
 46e09a7af769-709b3243b1bmr14088641a34.20.1722881658630; 
 Mon, 05 Aug 2024 11:14:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31eb6383sm3180166a34.32.2024.08.05.11.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 11:14:18 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:14:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] board: tegra: convert boards to text env
Message-ID: <20240805181414.GA267004@bill-the-cat>
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240805053343.GB7516@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2OA4aRz2e+MpzXN"
Content-Disposition: inline
In-Reply-To: <20240805053343.GB7516@francesco-nb>
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


--h2OA4aRz2e+MpzXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 07:33:43AM +0200, Francesco Dolcini wrote:
> Hello Tom,
>=20
> On Thu, Aug 01, 2024 at 08:57:37AM +0300, Svyatoslav Ryhel wrote:
> > Move env stuff into dedicated files in boards (1st stage).
>=20
> Is there any plan or expectation to move existing boards to text env file?
> And what about newly added boards?

Long term, we would like to eliminate include/configs/<board.h> and so
yes, conversion to plain text environment is needed for that to happen.
Is every use case 1:1 supported? No as for example, boards need to move
=66rom "distro boot" (which uses tons of cpp macros that we just can't do
in plain text env) to "standard boot" and while no functionality is
intended to change with that, it's a conversion that requires the
developer to check the result and verify it does what's expected in that
case (boards that don't use "distro boot" for example can be if not
mechanically converted, at least u-boot-initial-env compared
before/after and verified to match).

--=20
Tom

--h2OA4aRz2e+MpzXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaxFnIACgkQFHw5/5Y0
tywcdQwAmYikklW+espj/Qur1a4hkin/i5ej81heuG0GOrkl6WIzkCQtU1qyUXvE
no3PPcNZA/kSkb+/Ep1XFQLjtfjVg5yqmjL/mTbEZoJLKQZK97hkc2+qBRnUPwAd
quuerBVGDV5WZ1zF1ko78vBGyqyzYTfMCBbqzFcB56b342I5eZjZgAPstgh8nMyg
P7Dw+I3XKxguBmwvButI4sSs1WlIeVWLygrTm0LFiQDtLLmyIExEBGNWkta9rnfH
1D6Ff0yaCtpAhVaWc/w9D7QA+3pdHGDyZtOt0Jt31GKFwzvHnsYfQxU2+CYr+ePe
wlQ6i0MwHPz22+m+UQO6IyEL1G1IZXPQ4Lz3rBJH4IFXevJ3BxHILkLg5Fei3Ix0
X+B2t7qkFqBC8rs+g0Z7d/NmwFVcwBGyuFjL+mAtRaByNkpJI9Gmx04WP7znCzdJ
suPoshzeMWAnXhMQR8YPKoIPddbF03Z5Qkr9DeZv8BIiApmw0POJHnZYOBV12DG+
udrUsSVg
=pgfn
-----END PGP SIGNATURE-----

--h2OA4aRz2e+MpzXN--
