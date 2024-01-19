Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C04FC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F15887D6F;
	Fri, 19 Jan 2024 17:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G2ohd5gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C85187D6D; Fri, 19 Jan 2024 17:10:00 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EA187D32
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff790d41bdso6909337b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680597; x=1706285397; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xc8LHVcjCT3AWGEm+GcH0O0ByayCHQ0Iz9tqpQLxp+k=;
 b=G2ohd5guAbIuHFNSepDwn2gG+fAblbm9BvZw7NVU6iPCYC+tkkhUFpp9aMZrzdsgZG
 QHPHQZTAkOb9Y+2QpWt4a+GTUA9LjmH/t5Ah6UMMm7z3AHDMz5oGtRA95I/9KbpbjRDv
 3RB2HhwoXXN2NW4N6Xe1tVt75ZD7Et9acRogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680597; x=1706285397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc8LHVcjCT3AWGEm+GcH0O0ByayCHQ0Iz9tqpQLxp+k=;
 b=L4osUz+SpdSpLi6ZJpnRthTkPKEAbP6LrTpTf2b+fVtE5iqvNRi0OqZkuupBJpK5Ei
 NZ3TjT/0LTgMLreITQIlPjLxD3zWL0w8/nnQ4//omYwGvqAIesYlk/wiQjPzEtpyAe2S
 9uRJk+kMw41Q8PWMvg5wZ2644cS527NTS6EJtU3uVXnoTPzCaSO/z/T5mQrHn9WC8VoZ
 i147SNIOwgDJXRXtSPOWA3narwfBb2pWS018YSGwb9yi7mj8h4g2hCAsMKuovMT3i3IY
 qeH6m2iBEMw7ufhq+AUlnDRmRwuRwsYLOXQ2PM0LQjllj4iLCkZMmHdxapqdhxzBdEwa
 T7Eg==
X-Gm-Message-State: AOJu0YwqYfC67LMxZIPiW/oqwU4hA5KRh3LNVPnCe7nMQlyqVCTgApFs
 50ijDH4o0nvSuqbWUy+zqPE1Xw9hOSUFxWN+aztN6Y64iBiIJClr2GKerb2VAVU=
X-Google-Smtp-Source: AGHT+IEUVwsFXYv0s8fh4jOcdVPs0C/9SZ7j9Q7Y1kcwH+haGrL+S13PGJntbn7d+EvhMb1poRUXTg==
X-Received: by 2002:a0d:cbcc:0:b0:5ff:478d:29ed with SMTP id
 n195-20020a0dcbcc000000b005ff478d29edmr105218ywd.62.1705680596640; 
 Fri, 19 Jan 2024 08:09:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 s4-20020a0dd004000000b005fb0d1afc7csm7586019ywd.120.2024.01.19.08.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:56 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Hugo Cornelis <hugo.cornelis@essensium.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] image-host: refactor and protect for very long filenames
Message-ID: <20240119160954.GH12635@bill-the-cat>
References: <CAFLszTgUwDUWSRwJZ0Jk8Bw6UUXDt72vnaj4rB72bLFoo3Lozw@mail.gmail.com>
 <20240108142430.301659-1-hugo.cornelis@essensium.com>
 <20240108142430.301659-2-hugo.cornelis@essensium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n2xkwWINu65krRcm"
Content-Disposition: inline
In-Reply-To: <20240108142430.301659-2-hugo.cornelis@essensium.com>
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


--n2xkwWINu65krRcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 03:24:30PM +0100, Hugo Cornelis wrote:

> This patch adds a function fit_image_read_key_iv_data that checks the
> return value of snprintf and allows to generate a sensible error
> message when generating binary images using filenames that are too
> long for the OS to handle.
>=20
> This is especially relevant for automated builds such as Buildroot and
> Yocto builds.
>=20
> Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>

Applied to u-boot/master, thanks!

--=20
Tom

--n2xkwWINu65krRcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqntIACgkQFHw5/5Y0
tywyZwv+OWvhBndEnIIjmanl0JMNANWYx2WJiQOU0hqR19wKfAusUhUNTgE1Xg6V
2EH6NQLaY2iJkmqZM5gH13WUDo17vU6lI+MpZ+EgJEs/xkLfELY5mSyz6fD1MX/k
MnFhEDleyZhBC3YsH3SVBAah26SqNAWkonCex5Z9JL3OK6Xl3Wb/Nft0C311E6wT
JfDzdivB7cDo/XkD8M0WW/FCPXYchFNM2sFN2VpBTatOm9WqveMWQSddEiYz4i3A
M4O8MhBBocEqs8NX6uBReFaG2IrZnNnQKuG8KFv5d3hSBo6Zo6cMGkVSKjs0uIAd
VDetAYvzXo2WBp72C3ik1JdP1z5nD/le6wgVsn0MuIUxOAy6/j2bdfJyBZjGedBk
iCF/i+LNYcxR2WBEHhm+2bEWn5FsUdCcm1yK86HTwNDVRilZNxrIsrIgvxg9rAkV
ycXcJ9xmfGU1/iMUR0vX3cOxMcn69JE0VXJv5hckkgTDU0CF6/LIZisFVJHeZj61
H8AkaDej
=Vypn
-----END PGP SIGNATURE-----

--n2xkwWINu65krRcm--
