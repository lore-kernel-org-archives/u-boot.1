Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B61DEE6457
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 16:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BCF84027;
	Wed, 31 Dec 2025 17:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MV5dwwNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3988840AE; Wed, 31 Dec 2025 17:06:59 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDE883F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65cfb4beabcso6859672eaf.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767197215; x=1767802015; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hbCLdESiI/sHzZYLHfNC23XHNKIlTulC1eur9QO0pew=;
 b=MV5dwwNi9XAKnBSnldwo9c7k/dp7lgAfCRQIYSdDAbQ1rTnGK/RhAltCcGgSCz3LUd
 +0Y+91MhK+WTgEmd2mb6s5BzfVhfUmfALplKtkONFQoJEOSAgK8JObUV02+PQUA582qV
 pNtFkvmYfCyfNKOS8ZphZjDZ/fv989aBOcFz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767197215; x=1767802015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbCLdESiI/sHzZYLHfNC23XHNKIlTulC1eur9QO0pew=;
 b=wI5XBfXz4FXSU603yFrW1W3gWWzTlywVdwJ4R4hpZXvOCCa2dpiBJBhLhyVJ4b0T8Y
 QUhgLBf9SZ+S3sxTNrW3obKmXDGhVgnZXmDmqpXRWouor+Tc4Do9v9hPWulV8iR20bKy
 360u3nv7RTt5/ohnzM/KRCwZjxswtPJ/yM4MG9DOthTEwwqWqbbE4npzakPr0nXZS2Qr
 AZ6zy6XKwE2ERnN7nux6sbtuxJG3Typmp06cJe6HN8TeQK8FVkFrtXRuUvfQj5HAVbCf
 rCRmSKDmCA11o+paeOQpqR/eIH3r/4dW5jSQuoNCx+7jAvHK4AQVhd8/TYlwC5DoS8+h
 xvlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIkdqtuxqit9poB6shH8U9HXgRG7cIdMLDxuURLvl1p/xvDqVjmBms8Rmvch8dqR2HZf/DRV8=@lists.denx.de
X-Gm-Message-State: AOJu0YzcwALM6KcaJcTryCsTUJIskZ3on/4099UEVY6KFMts+q2Ak2xf
 A+mijwn1K2FxBY0wPhLVjY9/nwnByR7I6F5zutZ15lCOEVMSduoUZr3THEPl/Gku2W0=
X-Gm-Gg: AY/fxX4P+HqlmjNjQf3skSmyvEx8oJYbnCUCIvDKziBW0mriVyE7BSMv8EgBooQEofb
 wQcLtauamEukZU9cP480/Z6LNikIZfyb9TVJw1uWbNUwJEcm561ZFNKOaOB++fx79r7kXerumCm
 i3+hEBxIoXD6BZnhnccPNb7bstHSKeTHxtIugJbIspYAowpwmd57T4wF/MFWkNWGpZOfHbSTfH/
 g62av3r0QoZDXPP2KM7lItpwBucqHAhxBb0wrRJWWVknRkfkOv+K6DvafMk4gD9Wa5pijsqIdHd
 EIyjfiut1YWZUG2NYoss4XIjwikhrITxccjlyd1ZVFmDFJhHrjE9BePNXGVTPA3WRjr4U5MF+x5
 4zftZ7JJWMCoJ6lF43UHk/92q2ScwSu9HAiXb+fYh7778G8BB8VP8AVgOfzAe+luw0v/dZh2KLP
 5uL4fv5uATx9Kmh+KQdgxU6sGvfNWQe+RP/t0Uyi5lHcvt9ICwm7V/NMHbT20sSLSO0TVEImxSj
 0fBC61x6SIqL2CjVBWh5YsZztX39Hi5y5eywQY=
X-Google-Smtp-Source: AGHT+IFeb/9e4Rrw80LrfMuksf/a/74FQrnSLekBeGe/hqVStFY1Jh7oWQdAAIkVLBjVZvQWGqWYbA==
X-Received: by 2002:a05:6820:4a83:b0:65d:48c:34c4 with SMTP id
 006d021491bc7-65d0eb93836mr12873154eaf.63.1767197214886; 
 Wed, 31 Dec 2025 08:06:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f1f1caesm21813515eaf.0.2025.12.31.08.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:06:54 -0800 (PST)
Date: Wed, 31 Dec 2025 10:06:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ion Agorria <ion@agorria.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] video: menu "TrueType Fonts" depends on TrueType
 enabled
Message-ID: <20251231160651.GZ710860@bill-the-cat>
References: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dVQBsmVmLIvC0rou"
Content-Disposition: inline
In-Reply-To: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
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


--dVQBsmVmLIvC0rou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 03:13:44PM +0100, Heinrich Schuchardt wrote:

> The Kconfig menu "TrueType Fonts" should only be shown if TrueType is
> enabled.
>=20
> Put all TrueType dependent customization within one if statement.
> Remove `depends TRUETYPE` clauses.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dVQBsmVmLIvC0rou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVVKGAAKCRAr4qD1Cr/k
CvdTAP0QqV3XKON5qCaED/ACkfNtRpcrVUXBzp3NZrj6Ak1ThgEAq3eo71q20zS6
FS8SLE0+DwpFpGdxESJEtSLyjbTu5Ag=
=rGBz
-----END PGP SIGNATURE-----

--dVQBsmVmLIvC0rou--
