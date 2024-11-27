Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF1DD66B9D
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 00:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF36889CE0;
	Wed, 27 Nov 2024 01:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IsKq/UAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F73889CD5; Wed, 27 Nov 2024 01:14:08 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA313895F0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 01:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-466879f84ccso21540231cf.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732666444; x=1733271244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jjPGps0lhjB2EaFANpr58/4wAgQt5ecX6l0RD+4fxhE=;
 b=IsKq/UAWUcadKjisWsYbxpjgYWb+pdKGbV0eB4WYEVd+ybP2ZGfzl9xridWySOthYF
 8QVIkBxqQ1drE6pwWcvsKcMDi4nLEHxWOwEmbPsYt5C/GfhwgMpyJyGppfLaZEeRkwV0
 +PpjLYFHTqubz2VdVESsdPysDEECR8/k+M9wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732666444; x=1733271244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjPGps0lhjB2EaFANpr58/4wAgQt5ecX6l0RD+4fxhE=;
 b=KzKDTf+TR/Tw4RLMqye8dBhjr2gsCM6losyycTTPveV4KGAXFZWNN5OYgOqwRAITag
 AOZAqXYNw8rxhLMo8tQcar/Rp/Qmet8r660xEnrUA4wGKHjMqgIjA9foqTaj3bvCTGeQ
 yT+rvwR5gPNsVkcbWNGJ7MYfQxWKAjtyryeBzhz8Q8jRIzipyb8tAjwvyw/BZwtLrwsw
 Uzl/iW/dujHtaKY82ZksCPSo0t+IZp95sxWtvSQ2oArcffqAcBcvNFfce74YddUsGPiq
 7OVFf7IBNMRynvpWJX3HgjXX5ZfG8rmpY2SqQBfGgkYOkuGkrtXPrRct5/wFYmbtWOTK
 p0mg==
X-Gm-Message-State: AOJu0YysGQf2kxb0+aWHkce67Z87mM+xQslld0CCll1LvXuPHo/Evgdc
 gbRtQfV0ispzyNNO/FmMgOg+PXucy7bPZweDxuZ8XIKwGKwegoagWRv03iHqVGo=
X-Gm-Gg: ASbGncugaHrG+Y99mHmqQu3+MLDiYLZFWzcuDwPBJYiedi/xo7YGEB7U60rp1Ya18bA
 cl7tOxs+0p84vKlPl6RtsAFodpn3aEj2uZsmf8ziC0NpFqcPJI6DGg+qnyi46oJsI9P/WYi8aAF
 A7UjzV8y3di9kGchaJDN7jyrdgAU184qlxaBaW+96LZ6iQ4R3LOZmeD9YCEss6Yp2QQkXIOcm34
 jrrW2R4NQe9+2ovausMsGEKLxYXbTVs8C64NCcRwUwP7/GzwA==
X-Google-Smtp-Source: AGHT+IGSOYYE2fzjIdNm6l/raqNBfYtljSEoZLcMayymF7Pd1OULjil5pTLRCbBXC/QLyzheCTPn2A==
X-Received: by 2002:a05:622a:47:b0:45d:9357:1cca with SMTP id
 d75a77b69052e-466b351e8c4mr12178551cf.14.1732666444577; 
 Tue, 26 Nov 2024 16:14:04 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466aedab15asm8370451cf.66.2024.11.26.16.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 16:14:03 -0800 (PST)
Date: Tue, 26 Nov 2024 18:14:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20241126
Message-ID: <20241127001401.GY3600562@bill-the-cat>
References: <87plmip1m6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aI+T+k+iKcAiP/l8"
Content-Disposition: inline
In-Reply-To: <87plmip1m6.fsf@baylibre.com>
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


--aI+T+k+iKcAiP/l8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 02:26:41PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some new developments for next:
>=20
> Android:
> - bootstd: Implement bootimage v2 support
> - bootstd: Support non-A/B in bootmeth_android
> - Migrate VIM3 and VIM3L to use bootmeth_android
> - bootstd: Additional test for bootimage v2
> - bootstd: Optimize load time when reading partitions
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23573
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 48380f9b2a12e3fc6339d6af5a154bded769d9=
11:
>=20
>   Merge tag 'v2025.01-rc3' into next (2024-11-25 17:34:08 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-next-20241126
>=20
> for you to fetch changes up to abadcda24b100b8eb0f138085cca6595518cec85:
>=20
>   bootstd: android: don't read whole partition sizes (2024-11-26 10:04:40=
 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--aI+T+k+iKcAiP/l8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdGZEkACgkQFHw5/5Y0
tyzP9wv9Fzlng0EllbkrDdRFFmGe0i/nTaZH3/FkghTmOVqH9X2hj26r5xldiOQS
L3uaqGDcA0Q6sQSMWie9kPFidTFIOgXneCYntyL7hFmkvOgFt3nAIcDvXcgKzeov
eNFskgo1GRlye2KLV42DHjBzWQ0ozIXbfgC6n5Pf8bkifYAv6B6xgSG4bcNdx8Oy
Qc8lkNffcuGJBpteB23QJ10JD8WGPqgSF/VHTDdjNWSirIDm8/BCHzz/VR/FfXC0
K8vaZt3+eNgWM1QFwaewdBs+sLaJVHd2uCcqPSjXBUNVrGa9mmFtG3GpTbOO3sB1
Lbpcxxbq4gGrLPhySK+AL5MiAx+hyweHZW96AG3ed/6WqOoRT5ZC3RwpA+bMAfip
STtp8FPkOdVExVDtGY74RLBUtNXXwn5qQlquLzg1ZlvA9zpR14e+mbBL+0onzORs
k3TD7hEYudjHH3R0ZQsW8smxsadSPWyyZGQipLcDAw3SWyTsehTIuDAdCUkfetos
397H1LJV
=Uz2+
-----END PGP SIGNATURE-----

--aI+T+k+iKcAiP/l8--
