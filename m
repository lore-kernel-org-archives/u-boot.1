Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949C5E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2471989662;
	Tue,  3 Dec 2024 20:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZ5V32Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5A18961F; Tue,  3 Dec 2024 20:57:22 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A2B78967D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ef81222be7so34554507b3.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733255839; x=1733860639; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RbSKqeotoiCrpLyHCJrlzDQyCJc+E0j44alVHtUQE10=;
 b=uZ5V32WpfsD1rad3jhVi9c4RuK3cIevt9knQugYpMfex9UnJu3qYTn5H2eB6ry9yBx
 Lg4ioAzfIxgnqMlOLyLFNlCiXNV7SeYMPGKYNSaJnkJwirwsh7ZJEaTnWAe1JTNRjNPx
 oyvvUH3s0lm7q9qCwWXwQcEQrhBamuwp1H6Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255839; x=1733860639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbSKqeotoiCrpLyHCJrlzDQyCJc+E0j44alVHtUQE10=;
 b=ZUtUiuLtXL7C33OiKacf6G7WWEz/xThqZ3wvOBoiQc3uF/jWDPzOuAoGtOK74ieOgu
 AfgXFbNaLGUPL154pYebYxPHD8dZYYk4ANOpx5wUXtkdpmQkut9yXdeSgot53P1GQGzz
 fTieIglSbD+Y9A8oYvVg/fmH7T5vGm3IVvzhQmPkDXcgJ8w1tSNtJUN8xrxAc1tGKyMN
 Fa5PwcgHr8+WvsTaOXA3Z1Aax/JuhJkBzeDHIc6HDpdWfW4+WGf/XVa2nbkfV7Ipf5o8
 M5LFHvu6Rvg6y0SLWKxtsm+1x1hq7znPx/ryLFVPXktwWBJJxOVXnSSsJWYEe0R1zt6p
 2zmw==
X-Gm-Message-State: AOJu0YzElwE1fOmwcsZEBh3AZIxhrDCikkBzvAxSe9jXCSDpo0ePPgtC
 VV+s9Yiqp13e72uR8Ras58ysZZ1JhG0lPd7sccldWKoJ9GY076RPD6TqhuG7t7tgAieSoOn9UtB
 1thQ=
X-Gm-Gg: ASbGncs71CVSEX+J0EnOuUYE4jepJbjNqMrmUFXmEC832O/8KkJT5GomCTGX2F9vzJD
 hjgjACsKfZgxURRLryW9ACvle7Cm4LfRQ5+kdnjOwY1Yq/3B4e4AGRVVr0OP6YWMx/593uR/gv6
 SqlYyHoEMWkqK611GobLopb/Q4U5UB33PPO+ioS7jEe5SGasNRJsK0Lvr2VFzkJbde3aG4l0sBH
 ujhBN2zmQF00uuiRVThlwtzTZLqyit1DyHB0gz7jDcgswn0XA==
X-Google-Smtp-Source: AGHT+IHbaw2sTTnNN/C39EYZO5bDrs5ZrTFmzmJyX2KvtR8MNdN0QHgkdYRQqaPwZGGcWV1C8pRDtw==
X-Received: by 2002:a05:690c:6913:b0:6ef:7290:d478 with SMTP id
 00721157ae682-6efad2f7338mr54982377b3.40.1733255839454; 
 Tue, 03 Dec 2024 11:57:19 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d89fb3b366sm34406376d6.90.2024.12.03.11.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 11:57:18 -0800 (PST)
Date: Tue, 3 Dec 2024 13:57:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20241203195716.GZ2457179@bill-the-cat>
References: <CGME20241203063944epcas1p45e5c757403cd06ebd265a93e7fdbbeff@epcas1p4.samsung.com>
 <24da01db454e$23517c30$69f47490$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rXd/0MvEaZTeX3Ix"
Content-Disposition: inline
In-Reply-To: <24da01db454e$23517c30$69f47490$@samsung.com>
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


--rXd/0MvEaZTeX3Ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 03:39:43PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd2=
71:
>=20
>   bios_emulator: fix first argument of pci_{read,write}_config_* function
> calls (2024-11-04 18:01:58 -0600)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 0bbc17f06bf3ecee019090b76c8c20480516945e:
>=20
>   configs: e850-96: Disable PSCI reset (2024-12-03 15:14:53 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rXd/0MvEaZTeX3Ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPYpwACgkQFHw5/5Y0
tywUyAv+NbNvQ+XR32jMIQCNPF5EEGhMnlktbdrJPfr777DCIWHtLTw1iu29dS1z
q70bD1hlFLHyAabWZxRi3Qh1AuD/8VNBD9rY6I2YhWZ3w3N+fLGjE545+L3iogPD
a5xV7m4xoel5FeO8Kw6nj5FENihSAurB1h/8C9HQiPBFPB4Llr+U3I5dDX3TpX4n
4WzlabsMYFlHUTjbPOPpAi7I77jmNFsgNydpxzHF05Pr7pkxs10lAtCFNkK2BEhg
KVqM1huP7BDQzeVyX4g5uX9JX54voqX6AQD4IcDRNux6cCmrIyQQykaX24ES3WCh
IAW9/K4MIaqnXyjqJnfc++sZLcOAe46qcc+6LEQbpVpvdkpeiJPtaP5RrnkLRK5o
Jn4HIr2MBtV9PKy19ioloA0ddGmTM3jwdoIXpow0uGkBDw9bAANdi7dhrQcux1an
3mJ8GA5mtUMx5I/hZADOK1rFmp9jv9iCU/UiNLJs2rah69OgKlVeEF2q1NdB/Ytt
Hx6DslKy
=Z03K
-----END PGP SIGNATURE-----

--rXd/0MvEaZTeX3Ix--
