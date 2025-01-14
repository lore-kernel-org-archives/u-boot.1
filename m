Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A332CC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E2F806D4;
	Tue, 14 Jan 2025 17:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DK9v0Jgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F2C806F4; Tue, 14 Jan 2025 17:59:20 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC958022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6dd049b5428so46305956d6.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736873957; x=1737478757; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bWdK2zoX7xJQAKIVIHe7au4Z1dpngZmkONyVpyBizm4=;
 b=DK9v0JgxbGKkLcfSzgtirGXs8vBWowW+KALEHFAFEqL6UmeYIIR4oenUpfqHSSqnHY
 VyDLiHgVQCXL2CqH18uYsXfuq7Mvz8Cyl5ujHCg0Cin7k+QxZAPnQH4GLJmPmFO0mdoU
 QDbhH5471+Mcl6tf4+pghFetnx7Qi05e9RiDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873957; x=1737478757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWdK2zoX7xJQAKIVIHe7au4Z1dpngZmkONyVpyBizm4=;
 b=tvkvlmzZ05XlxcH2wxV4+P7FFBoMFBS5mp/xdgW9Q2h0Km5tYQoXG9aBwY5kWR0Yoi
 9HVro8ZtrphbQwtkEFf33QgQrrzGKnPDyC8CeOayMFdm7O8hwZDrqULefWTwFRRzacxN
 AGo5z88It+POf1Q/zNR7ozbb2eHOnHkwekHJmMZ6N0oFcySFuKDhivtsrRmTEzMGNfkW
 DWv47ymebj/oxExxc4rNNNF6ZxHUKUOV/TSaeHKPvSkNiEbPFehJg/lPcdlQuLrLVTBg
 XRtYp7A5EWIWuxB9KHZSJS8cPP/cvhpoW+IxBBkTnXBHKmpWfYr3S6iF87p2YAEb4LTN
 24dw==
X-Gm-Message-State: AOJu0YwnZlohAUxphzLZNwXiVByMYd4kd61B1ACcwdF7z/XEM8bxAuB7
 oyOnjgW5RDN7SrZkAKG7L8qOQZpYTToIgMlU7Q/28oUs46BetyGCv+hOQeGHU0DpqoO/4cHjpEb
 m
X-Gm-Gg: ASbGnctKnbtV33/HWTIsFvOILTZKAb5kfewhhaMmnkTrjo0KhzexbEdKAUDvHRs7e6S
 qYEbVuc6y5Vg07ZEo7pXfbehtC5f+iAbBcAYmD5e05QclJ7hlXE0sn780nvQE7+ffG+e0xY+xQP
 sGofP/gh1Ip6uFU3qL7GtDn58gyYlobhBds3Kd7YSEbsz9MS06GO93rO4YyBaasM0yzKQnXNu+U
 rPhwR9pESXiu0oC9Pd/yGH2Bh1X3G4OnjS7EAvpqoD8F4+vQYE44g==
X-Google-Smtp-Source: AGHT+IHmwjL9jIMDDxie8pxeokUu5czP0OyJN39+qogGS4pfOVWgYGBJrRZNKuq+zbhMCM4fUehlLw==
X-Received: by 2002:a05:6214:5004:b0:6cb:c54c:b782 with SMTP id
 6a1803df08f44-6df9b2b3707mr433217266d6.32.1736873957415; 
 Tue, 14 Jan 2025 08:59:17 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad899d64sm54389876d6.31.2025.01.14.08.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 08:59:16 -0800 (PST)
Date: Tue, 14 Jan 2025 10:59:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
Message-ID: <20250114165914.GN3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
 <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VmlPzxB/IelHU+Mk"
Content-Disposition: inline
In-Reply-To: <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
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


--VmlPzxB/IelHU+Mk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 02:53:48PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/20/24 11:22 PM, Tom Rini wrote:
> > Now that block drivers are all selecting the BLK symbol, there's no need
> > for other options to be select'ing BLK so that other required
> > functionality can be enabled. Remove these places.
> >=20
>=20
> We have multiple commands depending on the BLK symbol.

Yes.

> BOOTSTD also depends on it, but I assume we should be able to network boot
> without HW block drivers?

Correct. That's part of the motivation for this series (which I wasn't
clear enough about on its own). Without something like this series if we
remove the BLK dependency from BOOTSTD then some other platforms fail to
build or grow a bunch in size (as BOOTSTD is default y and now it's
enabled on those platforms).

> CMD_UFETCH wouldn't be usable without those drivers as well.
>=20
> Should we do something about that by making them not depend on BLK e.g. u=
se
> CONFIG_IS_ENABLED in the right places? Not sure if all devicess based on
> those archs have at least one HW block driver enabled. I guess checking if
> all .config before and after that change are identical would help us figu=
re
> out if this could introduce a regression?

There's a few options, depending on what the command is. For CMD_UFETCH
it's likely that a small restructure would be needed to not try and
print block devices while preserving the rest of the formatting. For
CMD_LSBLK / CMD_CLONE it's an unfortunate short-hand for "some block
device exists" which is functionally what those commands require.

Thanks for reviewing the whole series.

--=20
Tom

--VmlPzxB/IelHU+Mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGl+IACgkQFHw5/5Y0
tywMLgwAgzXbOR0hLO35uZs1h7j+WMwDCUuCxCu/UxX4Dj9ysqPlxt/4sAJiuZb+
ilYh6PTxoPGS8bjatafrS/CGVxQWbLFlp48+kslWDsTEvrNKD74kEc73jUpjr82U
jh7B6L4sbea9nTCJcvJhz8rc5XL7FJrUI3eFPJvG80PPnheKLPD5zLiy0Q4+fugV
ppOa26VwEio4TNt7+EMAygDd8um1bAk6ZYcEWAwAMjkSDroGgyY2x+fHHx0VPlqw
D11DNHyo/+cL0Op7YGiMW0/0m6uuD4rH19pvzdJjNLyd1vZ40S23s6ukvsWjPBE+
p+VfJnVPkdJWK10eFncISRaKT7f26yyxVqlA21+wGTb6ceZGGvBpc77fnTvPwgCy
nRviOnPBUicOcF2XuW4D6Gk3pfHj0dHmS1K4atqocx0fau/NpQK99FdZeUv1Clau
rnZQ0EUX6K1KytwNrcgFhqm9K1FP0GVBmPuNy45puDs8JrABnvIPi9xub7dbP3j8
I55hftLS
=ilvn
-----END PGP SIGNATURE-----

--VmlPzxB/IelHU+Mk--
