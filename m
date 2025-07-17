Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D58BC83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 19:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F221783445;
	Thu, 17 Jul 2025 21:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sMrOjSSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98F383496; Thu, 17 Jul 2025 21:02:43 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C1483390
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 21:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40aef72f252so383428b6e.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752778960; x=1753383760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TG2mpEptUV1iZdBkyN5gS3F9UkViZGo5Dri4mFGxqFA=;
 b=sMrOjSSKI84L6BnelR2FkGsoqSzD7QGybOuMxda71XgHlrP38lcjydvjDmVGVi0kq6
 Bv74KY7Eg5dH66M71/8fFZzx+M0pAlRNNymbzbY89ldhll1l0HXWV+5f4SPtpugMTUHp
 EYYvHdnMRJ6H2koTuX2PTz9tqPKN3jjK40pVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752778960; x=1753383760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG2mpEptUV1iZdBkyN5gS3F9UkViZGo5Dri4mFGxqFA=;
 b=LxvXW5gheNYszZLhum6EEVlt45PHxqvqRqCUOLCE3pY1AGlZq/Lw7sl++sfYyD/fhe
 p2FPse9BBLWJ4OLiN1/OH+S6xGdTLHhcK3MyWZGs39RoC7xXGENR8nYYdV1iB5KBwFRk
 mGBzcW+rNZbkzr9KjSF4zfu7ZJ5mYh+6X1iBefAzS6GV/keyu+Es8G516ir3Y/75yOKQ
 ia4u9zEesME2RI4o8dpvOkDN6AtqGCtz/2Ck/erT3l3qZnZNXiCW/nPak2f6AD3wJE7c
 0G2WurIcTJoamU41FVgmmliI4HpEbFjfIn6cUIRMPPDOq3yoCw98ehIDi8Wit/NwLcDM
 kWLg==
X-Gm-Message-State: AOJu0YzFiut8oczUF3uqURwzK58HfkaBbJn24o1sXoNoYQeRKlK1Thv9
 LcNFp4psP5QwThNY/s8/oNth2MAv+PyofZoWqJVvzbTiy+/uDgx9KKc2egAFJ19S+Ls=
X-Gm-Gg: ASbGncvwZvaf3OQaukB95D5w/4xBUregX2pG6HlAdgqSr78FuhpzTig9rZ8yc90F88e
 3iAVy3TuJB2yuZCmBIlYRgu+peaoSWuEgW9xJMH0GYCi22EHXtEtsYsMP159VoIaTPIu1rdtQBo
 GKWXtUKgCMLx/fwtZj4VMoCdwmpG+N47/ThKSSHTTeWemBws/ZDOUkqO99NYAe74pCHTQJDd7An
 GLXTQEboJAkPsnlVRR0a1GTwf4EYPnvYzoR/EolNDdBPpujqHQ8ZOEuW20N2c6IvdQJnnIBQkmr
 3SdBl4pp/au366hhOZDbiZ60ZgAsjTmT7cSF5KktbWG+Ud4DiThK1n6Re8UBB+OqgvZWSh7uoBr
 I67jSlSu/4WhMcygs11r6APBScpFazVM8SbOx1mL4JvGfRXdyP4UTQYc6
X-Google-Smtp-Source: AGHT+IHNfrH9obBib/4qBpxy8MlK/BN9tFYHsuGKgVz9HCWY7oYlnIGrP/jW+O4iushpEpwBOBibRw==
X-Received: by 2002:a05:6808:1204:b0:40b:fe6:569c with SMTP id
 5614622812f47-41cf06d3591mr4986963b6e.33.1752778959948; 
 Thu, 17 Jul 2025 12:02:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41f4b928977sm242536b6e.10.2025.07.17.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 12:02:38 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:02:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250717
Message-ID: <20250717190237.GQ193579@bill-the-cat>
References: <20250717162810.2243435-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xK4eGI5rPFjaPdK4"
Content-Disposition: inline
In-Reply-To: <20250717162810.2243435-1-festevam@gmail.com>
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


--xK4eGI5rPFjaPdK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 01:28:10PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 3b4604a40b9fd61b87e9d059fc56f04d36f1a3=
80:
>=20
>   board: vexpress_ca9x4: Enable D-cache and MMU (2025-07-16 10:56:28 -060=
0)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20250717
>=20
> for you to fetch changes up to 6dc91a840810b7a35c78ac14e9868db462ae2039:
>=20
>   venice: display DRAM MR registers and decoding if debug enabled (2025-0=
7-17 09:58:42 -0300)
>=20
> u-boot-imx-master-20250717

Applied to u-boot/master, thanks!

--=20
Tom

--xK4eGI5rPFjaPdK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5SMkACgkQFHw5/5Y0
tyzoQAv/fZdg5cEF3kY+tZUoQCJ+3waocH/2JWH77TfWNngd2RNsRlFTzXEy4cpe
4Wx45JA5a684tovokHvSf66wGmCqZimlpuln3YuOOabBRGchPkwndWy9oNbXYbEK
5Fusl7iUckmQ0fqY5ElTnYRk9jL2mEomGWBtwX8C59+zMH+wvIsAYvqA+G50wPm+
WSqlyI9xynH4o0jgiVISih0zScnb0aHYOoOMkttAoNxmOzfQLHaGW3owdmYGX1Ve
dnrRb2Xt1q0ff+fUpmtHVeLu5dHlLhPtHxNu19uVYrUsOy2xWZlsQEFnzt0K1IWU
sIOOIpIc/AnYHPGr5RlB/YpokHF8zHVF06CENTMhfi1RQWrHJRE4P2Acp8lSlokr
lmrTUhkP3tRc7G7u3VnF1PMq9Ja1sDTAOmsaoxLuszo3a/LDGjgTQ8puuQgxxhSb
cuIJErn4Y5ZBhg9e3t/VI1deSBwr2b3JO2YJ4hPC6y339icndOtopqzByF+bJBcc
3Hdg+F0D
=M3Zt
-----END PGP SIGNATURE-----

--xK4eGI5rPFjaPdK4--
