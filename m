Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B61AC369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73F4826AD;
	Tue, 15 Apr 2025 19:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZWsq4SLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFE682A27; Tue, 15 Apr 2025 19:59:51 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA48B81F7E
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72b82c8230aso1686920a34.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744739987; x=1745344787; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8tiHy/oZ6RPqW+UNTqdFQdeatZWfc5MnOwHjd0vQEEw=;
 b=ZWsq4SLSSZf2oyzl9ZBw5ZDaxAeMzw5Ii2PXAhjeBzD0fEA9Dwjwsuke/SFFivBwIT
 E4kf/1YF7+1JGZYwupZpV0md9FTVYg7X6Gn6JmvGLpJqapSPf6Oj5TOkomvrhYnwQoFE
 lC+SIrcRPm0fgY6mG3Z9kmBErH/bqqEkWFL+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744739987; x=1745344787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tiHy/oZ6RPqW+UNTqdFQdeatZWfc5MnOwHjd0vQEEw=;
 b=vE2WBg8D4kE4PBeXxGyLth7C3vUAYoy7GwgG30Pt+OcwFGFrpHvfHs7MmnGCToJ1yI
 CHK9d09G0mw8Gy8UXy3No/8Gqj72mc2U/EpsOUQBeJ12dLu6r45H3CM9w0d/bTDhca4J
 i5JMTV9WiR1KHVweD+7TZycq6/qr3f9l9bHK4RpE717yTt7leW13PiLuPGwyDrZw9LoA
 cfT3rePcb7GtIihH/5dnOBzAEc0CXOEAi3loi6pQILZtMCek/9kPk7gJ5qBAC0t25e4p
 TJY2e4rHJdN6xtmnjH3szDawTcyB1XmZRLnOJy2GWap0HX/my5miOhDuoLpBriuvUFUy
 eSzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQYWdnmfKBKFqnWwNxqgyyDsO08oXLBGEZAkZSA6TRukzy8CKFjjV5kXHCITq670bgFlhyyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0Hx8J5V8wdVTQ2+Ogd9+zi+jbUx9YhdVikR8WElEbjDWklS1b
 PwKUqcheQfoL00yAXBbXMYaHImc8y40UaSQWX46VPvAA+EnidIC1AYMvjAoXS28=
X-Gm-Gg: ASbGncv5/TN7serLALl8TiLyUdcWzOjlkmcaYg+5RyzCVgWcKOUeGpC9Zt7FPu7I1EX
 g5MhkcfHogIC5qU2VBeYTbgramvLv+c+s1pzMMxSgdHi/8OKpqp/kXPXb0S7h7L3wtqjKRJ3odY
 belwIIXrTOH7+rKdVkIcu4Yq2J7EqXhkecbEY9iXbElydX9291YZ6IfawnSxd8Y4MZQWKO3bXmq
 rbg67pXwURojhJhJEsaNmZNlhCWxZvNS3E3OhsqVOR0a9USE7y7RjPPH7D/58gNIO2GPrvh2g4c
 0q4PYHwyDFbJhjTsAF+/HH8Es4xOKvif6br77apnKcwwQWkGW7PL7yN4o6XsTx/c1colDQNsk7p
 9tQ==
X-Google-Smtp-Source: AGHT+IFiaf40Op04RCia1sJw22D8sElohYqL+KTBmGF5rX+hv4xaO7lUSZ8f98iRnNTZ2Prc5XTvFQ==
X-Received: by 2002:a05:6871:3a29:b0:2c2:3e54:553 with SMTP id
 586e51a60fabf-2d4c3d8ec6dmr82814fac.28.1744739987500; 
 Tue, 15 Apr 2025 10:59:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0968db6d7sm2934629fac.1.2025.04.15.10.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 10:59:46 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:59:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools/make_pip: Use virtualenv when invoking pip
Message-ID: <20250415175944.GA650630@bill-the-cat>
References: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3H5CpI1rYLElxAUw"
Content-Disposition: inline
In-Reply-To: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
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


--3H5CpI1rYLElxAUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 09:46:34AM +0200, Mattijs Korpershoek wrote:

> Recent Ubuntu versions (24.04+) disallow pip by default when
> installing packages. The recommended approach is to use a virtualenv
> instead.
> Because of this, "make pip" is failing on such versions.
>=20
> To prepare CI container migration to Ubuntu 24.04, use a virtualenv
> in the make_pip script.
>=20
> Note: This has been reported on [1]
>=20
> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>=20
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> This has been tested in docker on ubuntu:24.04 after running:
> $ apt install python3 python3-virtualenv
>=20
> with:
> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>=20
> And shows:
> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-n=
one-any.whl
>=20
> Also tested with "$ make pip".
> ---
>  scripts/make_pip.sh | 6 ++++++
>  1 file changed, 6 insertions(+)

So, this ends up failing with Ubuntu 22.04 thusly:
https://source.denx.de/u-boot/u-boot/-/jobs/1103567

And in short, I think your original plan to use venv not virtualenv is
correct, sorry for the noise. I'll post something to install
python3-venv to our container shortly and switch to venv not virtualenv
as that seems to be the long term best answer.

--=20
Tom

--3H5CpI1rYLElxAUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf+nowACgkQFHw5/5Y0
tywW8Qv+PjYr4le5UmqBaa3Qsm63BDTIXOYf4AkJw8+rx0FfNX9P4+41Cn1XkKcm
R5JLFhSPrtOFzm6ZruQGanpj7IWuTNC/W5lSAx4bxuuEPCJgQtZS2GT5nEwHo29r
W8L6bY9vU1s9HxvvoZZ7jQjWQINBLibjY1IWzNqptR1s+HE0rWYSxSdLFPeaYJPq
fi5noRhDOptDrsqSdypHwZIgePbTDMQQp/o3sG/NXkwpoB+xfgSsnFOTB++5mM3p
Ai1IhKCxLGhOHFWd9xh+66QqU0GtXGOdkE0wh2MWz7qvpVmYgz+faCjsREkPaQaH
vv27Ac2x2VhydZQZw+0F6LWYkXo+IM+FF5qx/kyQpEbfrRKSy+/NOvqxTQFKJg7X
+fU/U5NX7Ekhh2WwptJXDFSEvTHtlXTopfmpExJG8ZGtpaYaRcV1J9PN87hLPEsT
Z/wvn2jQfnlz1t7RpHxfUogPGzkSGFHf44YCk6ywOwr/WsO2Eeg8V/vroYXtzHuS
igmoeUOg
=wX1Y
-----END PGP SIGNATURE-----

--3H5CpI1rYLElxAUw--
