Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAF1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 22:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACB286FBC;
	Tue, 14 Nov 2023 23:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G1BEMpjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B6186EEC; Tue, 14 Nov 2023 23:36:40 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8792D86BDF
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 23:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so38840571cf.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700001392; x=1700606192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=74YsWQUbO02NbLnIjBH7cnjGrs4Ak+TUcTnUpluFgas=;
 b=G1BEMpjJRo28QH+yJP0pK+jU3t3KmBOpPXIqwXHAByTIInEHD4M1u+kU8bTunCaYuI
 Yq57zCtQ959pz3lnp6STHVHjrgvwZWSyOOGo79NE1+jZsnqYrbedCM+CgTA9vZuy4aKV
 ndyV+rn/4EcJ/l98EEJ02moiBaASeeAD05F/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700001392; x=1700606192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74YsWQUbO02NbLnIjBH7cnjGrs4Ak+TUcTnUpluFgas=;
 b=dQM0E5NOGjNQlyXEzvqUN/akqyUaI13odZ0MRwP6TYR2i+4/G4o+8GUQ88YQEOk8iC
 M1YLiWW/O5VRB8DJ4yDw0Ai3Jt/bExxFFb/dWpNvEHMLAtNY1cS9gsqoFqHXOzTbIxbM
 xqGsFfgl9wVyTsDu8Z1OfvQx6jPW83rGxLSax+1NY/EsHqJP9DF0zXIql21WkWl6QOnK
 ZqYhLygZZ+MtxXpQUOjhNbn2v4GnHF5iPED7TjAyQZj9xktWRcD+OEiCb8DQmCpeCGkj
 a0qLy9FoLGUqXAsctWTCns9dPFlS0KsKAd02JmcZF/YZnrwtVVXJMxYtB6Mef5fTqNtO
 vSlA==
X-Gm-Message-State: AOJu0YwD+8kueUPKm/hoGUcd/nyhSRrimc23K1tFJK76Z4pUkx9SMKiG
 Eaz6g1TiLA92PGnCEG7jnNyLWQ==
X-Google-Smtp-Source: AGHT+IHQGdZD0KPgIcx067NMndLFVjWGR5W1NjsFInvL04zta/vMN34XDJJZ1uNcsq+/mEWYhvVZGw==
X-Received: by 2002:a05:622a:105:b0:418:f70:df1 with SMTP id
 u5-20020a05622a010500b004180f700df1mr3878000qtw.42.1700001392123; 
 Tue, 14 Nov 2023 14:36:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 t2-20020ac86a02000000b0041e9f3c3be8sm3040294qtr.23.2023.11.14.14.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 14:36:31 -0800 (PST)
Date: Tue, 14 Nov 2023 17:36:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v2 2/5] image: Show the load address when decompressing
Message-ID: <20231114223629.GB6601@bill-the-cat>
References: <20231112035001.103897-1-sjg@chromium.org>
 <20231111204954.v2.2.Ie1c352a32eff905cf333491bf3d7d315e25e3f31@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ho8ZD5HKSFfDpWdv"
Content-Disposition: inline
In-Reply-To: <20231111204954.v2.2.Ie1c352a32eff905cf333491bf3d7d315e25e3f31@changeid>
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


--Ho8ZD5HKSFfDpWdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 08:49:54PM -0700, Simon Glass wrote:

> The destination address for decompression (or copying) is useful
> information. Show this to the user while booting, e.g.:
>=20
>    Uncompressing Kernel Image (no loading done) to 2080000
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ho8ZD5HKSFfDpWdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVT9mQACgkQFHw5/5Y0
tyyIngv9HctHVnf5knJM/k2d2zscSvvwnKvwXtioMpdZfrCZWMQmo+12nXfnfyk1
Be1e708cZruK5nXQdXGRMA1hL9ewqUP9hUJlPGmD5WCfllZ8f1llX+lis5jQ+zcM
sxvTJ6Iq9CS6D4seD63SHRtNYs3nXr+SluNqkjwzn18TUg+XvZxcHaAg4jgDgOWl
8Wz9iFoF7tniRp8BO8clA1717GC+3/Q9vBkmV4r96eUEb5U119X+7lPYYHz0nQii
7NmCa9Bqr5MmMRq544F3E0xYvlp98K2u2D1KDnJygRstMS88ztQLr9Uz2GX5qSGz
sQIOvjh/Br4PPFzqyxk3rTqK/EUCZqoPDk20Xuevg7akJfKNPOBU16veOadrv02P
PUuc+DylAzywbhqsjAh0Qvrb1LtF1guIJx6wo12ZnFCDJ1nsmHwv8s/ULNdU8Bi7
Jovye9POym65OfGDmqQjXGVb036w6kVDJpU2iTziBoNPrunsY+VaRCTSVBpl1yWC
mXMz8EUM
=MGz7
-----END PGP SIGNATURE-----

--Ho8ZD5HKSFfDpWdv--
