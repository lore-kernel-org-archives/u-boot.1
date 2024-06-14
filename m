Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61DEC27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 15:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2764A889F1;
	Fri, 14 Jun 2024 17:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dVkXIqf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E678E889FB; Fri, 14 Jun 2024 17:43:02 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C62A5889EA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 17:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so1078409fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718379779; x=1718984579; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Bl6/59m2Gzdu6t+2qDCDEoQidh/Z683f2lbrruL24M=;
 b=dVkXIqf3GFGpZEEGtmfUTTYqNHkihaHd90J9mVL2mzrP0ZIr8EdyidFXTAdmslQAYv
 GeHBJwKvjK4jeyupqBalgMfcdHyChhUbO5KFxJwu6M+qEtA0lE5JVpBdBleiLBkB4hHU
 xFaPFc+MBz1e5ofqQRv1TQEbMvl7+L1tkalgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718379779; x=1718984579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Bl6/59m2Gzdu6t+2qDCDEoQidh/Z683f2lbrruL24M=;
 b=Y7nYLT2OCI1K0MEqXqocsxzARymHPg5tL09/9TrrENupgoN76FstYVyjOY7Qrb9nkY
 D04g288JBSy0I8Gfee4Wg2NBUYKNNTODlW4wMA3lBfWKSMeEqSGGmt92iBRss9BQJeVP
 O0T0rSfBY0FHbxiAGu1al6Wnbpi9XGjuUp/Bd9A+1IpNb//6vxPAtVGluMmPeJ5A+xL4
 QaTS4CG+gZl1rNKiUBfEZ6cVMC7QmehtmUG8f1b7NOmlkJfQsrin08n/FKI//4PG/omk
 fzUg41HlKzSEdPx9y1PG21qG/IEDHae4PABcTlvppH1LoQz/Wz7GUZc/K19QIrj3vn6T
 M2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Dq6n8JZzihBsiVQpOBLHjLA9FJf3is0nXDTGWnvOGnXFDYD2o/BHQi2Soo5gr1M0nE/axK/KfwBMuXuQ+w2aSCObaA==
X-Gm-Message-State: AOJu0YxQnK2DA3TGTwUIENq5OdToLBLjykRACJgZYAnhwkxhRVC074d/
 46+A1Vz8At93CW5Ka+Jnir8B6FEhWC+pNZMt4yFGStyPIzLOplKoZ1uJObJxMU0=
X-Google-Smtp-Source: AGHT+IEt5OmPtuwbpwv4TwrTlkyo5/i4uobh9mo1g7Ec4QAqTrGEKxd5V9LvTwx5e9/dYILmZNAqag==
X-Received: by 2002:a05:6870:f712:b0:254:7211:424b with SMTP id
 586e51a60fabf-258428b4dc7mr3616550fac.6.1718379779479; 
 Fri, 14 Jun 2024 08:42:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5afab83esm623593a34.1.2024.06.14.08.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 08:42:58 -0700 (PDT)
Date: Fri, 14 Jun 2024 09:42:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v6 00/24] EFI: ti: Enable EFI capsule updates
Message-ID: <20240614154255.GA2659731@bill-the-cat>
References: <20240607223858.1971290-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aQgBEciwcvZ7f0e+"
Content-Disposition: inline
In-Reply-To: <20240607223858.1971290-1-j-humphreys@ti.com>
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


--aQgBEciwcvZ7f0e+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 05:38:34PM -0500, Jonathan Humphreys wrote:

> Enable on disk capsule updates, which includes defining the firmware
> components (tiboot3, spl, u-boot) and enabling processing of raw capsule
> updates.
>=20
> This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
> AM69, BeaglePlay, J7, and BeagleboneAI. The configs to enable this are in=
 a
> single base config file. This will make it more scalable to add additional
> EFI capsule features (like authentication) across all TI boards that have
> capsules enabled.
>=20
> This series also includes enabling serial flash DFU for AM62 and MMC DFU
> for beagleplay.

Please collect Ilias' tags and rebase on top of current -next, thanks.

--=20
Tom

--aQgBEciwcvZ7f0e+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZsZPUACgkQFHw5/5Y0
tyy/0gv/aXn4eMHeKAZRYwaOwzzm969emlsJjNjCqoFAF7Tksa5SBFcE3woPlgEt
C3hJF+omVZO/1C3+XpPdqyz1xc2Eh4cuvFkOR26PsEuXoJYgxKLtfMYsI06jKxMK
b90RhgFdMi02Gg2OHqbD/BagXbF+B9gmfHG1bTM4nwgsYQd5gSzYSjvf8XXvw2h7
KvqLunTM9TLH/dSn3mNVaLTtEn4j0/X4ri8lp5VHjSW0+4QaKbI/A6yoLWDNOE8u
Ohekqw1rjT8s36ZoZqRuJq1cIg8ehoixj33GBruZVCwTEC1nO8J/ACscs0BHuwjI
yk6CGWOkFsMFAue4ImlBO0wPKYdaTZvTKTKBaEFMePKLNpakmMKCXUfSgB8we4FF
7B21zrjugqDDXFjVP4mLpFUYw1dyV84GHUWBVExIQdJFUEJuXhRQ7cFxAO6nJiBE
TMOkhZ5xsgiUOIK42Ud0qy8fYZXxy6ldIFPuj1rzLU1jhrEeh4qHKdPjFR1a5oih
QWr8gGao
=YlcP
-----END PGP SIGNATURE-----

--aQgBEciwcvZ7f0e+--
