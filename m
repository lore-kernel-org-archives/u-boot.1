Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2BEC4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 20:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD5387B77;
	Sun, 11 Feb 2024 21:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iq6vlwrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CAE687BCB; Sun, 11 Feb 2024 21:59:17 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9867878F4
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 21:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-429de32dad9so17416671cf.2
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707685153; x=1708289953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kyzUvKvsADI9vGbHKcqn0feYLyqruQyGjhzMC5M2anQ=;
 b=iq6vlwrt0ROrdnKdGDL5wERJxOnJXcCJjRRaCQqA0PHd7fhvoBsaXuK95H+FmmewiS
 FNBlieg3W8nNPcs5kYkTYO8xNwDQb3PupEglZzJUwohQsz2zc4+24LkIvGxGioVSX+20
 pQNgerQa8wcw4QC0WUbY5mNWrJiNDi/SOhtgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707685153; x=1708289953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyzUvKvsADI9vGbHKcqn0feYLyqruQyGjhzMC5M2anQ=;
 b=IwcVx5qMpd1HGrLDwzNvgoxSEck0BA2Fl1cMFLcDe7A62fr3FQVVY37xI5PF6xvkG7
 Fvpr5gzj1VMDC8E/vDI07OV0HXHVujbc00Mbz3K/z/eS7B4MUG7YcxZKnoSASbf1WoM2
 IPKmW0nM3NzHPrHIyVaR/E8EhtPuA3/bSQ2iMgfhZDZyMupJ5INbtHCve1TRrKQdun8H
 SJm4T8ocQK6Jm1DNg4z+m7k9HpXromhrbd2SZ/7uXkCmEc0ejMnWTPdt3ccCSeXlyMM9
 SBHNu5YaG74uyMXr8/+yKjTDM4Bwd+RkI9/ponqDNNqpftx4i3HjEh9AMZr0aqGTlJVe
 4TSw==
X-Gm-Message-State: AOJu0YwqGPU6Or4qxF/MZB64Sd520jrTaHIr9dHZFoecFmCgxn5Nwpn8
 I9cKJDRh8Tzo45y8e7FycQGDJO8ayBOn/vVkTgfs+yaMmn5cpBKbfXDyyOEKF3Y=
X-Google-Smtp-Source: AGHT+IGeWFlrGr4Sw+LW0aOW6duGYQKHeDDqfqC/MxOj5ATyJojhsdMn9Ks61okOMA8P54UpdOF+dA==
X-Received: by 2002:a05:622a:142:b0:42c:6cb3:3287 with SMTP id
 v2-20020a05622a014200b0042c6cb33287mr5214828qtw.14.1707685153386; 
 Sun, 11 Feb 2024 12:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUezCeS5E4CCkJWvqtZnqaKKbu4732NHNhxwYRbOl5fGLy7D45GWt/HxOuTI4KL4Yu8qokCHKdo2fybFYSxvDyP+9c3POSlpDXhZuy87tIXWyBY0ZpoyGWOjgmTPdt+P3dgkg==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 i11-20020ac8764b000000b0042c6ec8247bsm997550qtr.94.2024.02.11.12.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 12:59:12 -0800 (PST)
Date: Sun, 11 Feb 2024 15:59:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Duy Nguyen <duy.nguyen.rh@renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>
Subject: Re: [PULL] u-boot-sh/master-779h0-r2
Message-ID: <20240211205910.GC3040305@bill-the-cat>
References: <20240211173301.7077-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+hSBsfS+qZ2wS3m+"
Content-Disposition: inline
In-Reply-To: <20240211173301.7077-1-marek.vasut+renesas@mailbox.org>
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


--+hSBsfS+qZ2wS3m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 06:31:59PM +0100, Marek Vasut wrote:

> The following changes since commit d7aaaf4223d0a2f9f8c9eed47d7431860b3116=
d8:
>=20
>   Merge tag 'u-boot-dfu-20240209' of https://source.denx.de/u-boot/custod=
ians/u-boot-dfu (2024-02-09 09:00:42 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-779h0-r2
>=20
> for you to fetch changes up to 53066deccbedf02439309b0d4aca9f0be853a8da:
>=20
>   ARM: renesas: Add Renesas R8A779H0 V4M Gray Hawk board code (2024-02-10=
 17:08:06 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--+hSBsfS+qZ2wS3m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXJNR4ACgkQFHw5/5Y0
tyyVpAv+O3BRvRH0ag08NGNRxXLv3topd0mwe6ienye+l0Bj+eWPZSvOzvwXETqG
gbrr9oeul63LV/V8EtOE8QNPxhOsr5O53moOOBULntmy5unTi1FRUP6fltYyCy0Z
8agJSuvm2RjKL/GE7Kpfm3MSwr+/nGA9LAAhcXUI+0LfCdWVBqWrybWHoSK/Msyo
Gry8RmDXSVdWb442yW85AFKUxyfXlhmOPkqmxD6MAGfC8nyARIkJntq+qRrK8uji
ScT3D8HCfJjX0RWYN9JtatUEcnsP8nagVwjj83Cs5kEW7p9RVH+LuLo3seVNlfTb
N9PYCARrfAM39B0vc6CanWld5sXcLJCFC1wenreh0/z23n05mp4JD36WV8N7A5vg
LxvmfvTmgqgNab6C0jyUyWB7JU4XPKQRDVJgLnk04cs6RIojRdNbKdPlodJ9HzSu
dq29LknINZ3DUochS8aLYCSdj5tr3e2BEM7hdCWV/30iQQ1ORGO8u3HixphoNujJ
LMJtYr89
=xbU/
-----END PGP SIGNATURE-----

--+hSBsfS+qZ2wS3m+--
