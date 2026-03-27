Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D1110F286F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 20:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67E583C5E;
	Fri, 27 Mar 2026 21:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eqvOf0d9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45FC83DA7; Fri, 27 Mar 2026 21:46:29 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F7688394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 21:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67c1b8b1f96so1567041eaf.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774644386; x=1775249186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XKX4LWO6Mh3hHiDt7mj4gEgl5DeR/XNl6vtkKF4r9BQ=;
 b=eqvOf0d9eDqv6n+FFtsUwnm8LMpb8HFvnjaqX1roB1C2d2+1pdtCus4tQLTjJE6sy+
 ASgSKThfJPx3HCGLu8vHtgEleK1fxnwvc/2zwujYlmVaY1FFIgQabkIavWDVu7BLyH4j
 2vBP+HxI9iBrE2uHJjJswnVrC0UxVgl6n57ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774644386; x=1775249186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKX4LWO6Mh3hHiDt7mj4gEgl5DeR/XNl6vtkKF4r9BQ=;
 b=oORBTm4P5k1oM+tApNca/hYXuJkvYt2Ur/XK0RuRKa9rvoQJNPki0g/xK58trxbw1i
 gGv1VrfBtRi3r3Kz2UAkNFZPjKM24dKXQzcbw1DgCP9i3yarrIlxwTBofD2mA7ntustE
 zDCccYfaK9OSgQRwdSFUBta/tm1Ad0hXiG2t/sbO00JZ8uqTCbCwFhf0yOmUvnJEozX+
 pYxll2JLuPKWLJK7UqlxsvCSrFiGKtTLsUd671oyeg5W+AhtzbviJ3kj+MuxaBTG6lMn
 KBs7kpSyFuT9MrLGpiTAz9QEoOOxPvtDNwiuC/GU71RWvOj2K/m4A8N6mhmXxa4zHKWL
 8PHw==
X-Gm-Message-State: AOJu0Yz1YtNtDDpOK3S265ed1s5HON1cRb7VxABIKDD8m0gEQ9XHjN90
 M9EjM0EWPpexMe7GCgwCgjVGXLrnqGWEFbnMJTV0USkbcIE+DFpBq5VY53arjessEkw=
X-Gm-Gg: ATEYQzwFhIR7pWEr371p9wH69z6ojWmu1s88VTGiNRMqTypn6yW4yGRdwrvWLQ5xz3t
 G4+W6TPZ4HTOmNkuL74Noq06eus0M5hWmWpZ3Bk2vKYMnFH8vzZwGmthowD38SGSW/uX4SehEuo
 HeUa/2fg3g+Zb8VJ3w1D1OR9a2fLRUJNQj9DM6CA2Hsi2xePQV04MaFuo4M3LkRWw4ch5Sn/fkU
 H38M5QNhaU7LK5Wv3/LtZUkeBWKFYaVzGXzrH7BaYWj3K82AaJAeolnsERsw1vD1GDY278thwOh
 Aj5byM6c359YJ74rY1vmtrnxGifuCfgTv1hSb+U8RNNcmERjyFFR69jkmoiaRxGMeWMzLpWC652
 UBIgZdxzUC5PMUoNrY53txuV+04itJEOPUrydwbuxKfOGvr8aiXANNRfTV82pEg9RD+SkDjcGHU
 pPPc8GlbzZpfx2BTuN+GJYqAGPWqrIXGqH01tsxewUhQqJ8oqHl3CGyRZ0zPcrKbJdHc0C36lLP
 4Es7FmRkkInlMxn5F355Eumi3O2jh3DnPZqtzHvVpHRnC3l
X-Received: by 2002:a05:6820:2082:b0:67d:e552:922e with SMTP id
 006d021491bc7-67e187059bcmr2205495eaf.35.1774644386264; 
 Fri, 27 Mar 2026 13:46:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e230a7f7csm248338eaf.7.2026.03.27.13.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:46:25 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:46:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/6] test: Refactor FIT test for clarity and extensibility
Message-ID: <20260327204623.GF502704@bill-the-cat>
References: <20260324194323.2335679-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zqdQVPiwziJShRaY"
Content-Disposition: inline
In-Reply-To: <20260324194323.2335679-1-sjg@chromium.org>
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


--zqdQVPiwziJShRaY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 01:43:15PM -0600, Simon Glass wrote:

> This series reworks the FIT test (test_fit.py) to make it easier to
> maintain and extend. It avoids unnecessary U-Boot restarts, renames the
> main test for easier selection, adds a missing-kernel check, fixes
> Python warnings, converts the test to use a class, and splits into
> separate test functions.
>=20
>=20
> Simon Glass (6):
>   test: fit: Avoid restarting U-Boot
>   test: Rename test_fit() to test_fit_base()
>   test: Add a check for a missing kernel
>   test: Update fit test to fix a few Python warnings
>   test: Convert FIT test to use a class
>   test: Add fsetup fixture and prepare helper for FIT test
>=20
>  test/py/tests/test_fit.py | 403 ++++++++++++++++++++------------------
>  1 file changed, 216 insertions(+), 187 deletions(-)

This overall seems fine. Now that we've fixed the problem with
readthedocs and pytest, the next follow-up should include adding
doc/develop/pytest/test_fit.rst (which based on all the others should be
minimal) and any needed changes / corrections to the docstrings / etc so
that the output renders well.

--=20
Tom

--zqdQVPiwziJShRaY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacbsmwAKCRAr4qD1Cr/k
ChLMAP91U52eMg+Lpleau9yX7AbB1UYtv01T0xqhtbZp3i08oAEA0PuySS4mDMub
z3KynPeAblilAcmVTak1gPenXcIjpgE=
=qBwU
-----END PGP SIGNATURE-----

--zqdQVPiwziJShRaY--
