Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACCCC19F4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 21:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36896883C8;
	Tue,  7 May 2024 23:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qTozlzWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12E5883C1; Tue,  7 May 2024 23:24:22 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E666883EB
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 23:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f04ec1b501so1561650a34.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715117059; x=1715721859; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5+pwpxnaDuL5N1NYAKB7ZawefRRbzhg68aj9y2pQPXw=;
 b=qTozlzWy8cInUkRbwyrkiue7Ah4zt3nEyXT30m6odk94LeYT+rwe6MJVFTvKfbq6xA
 jtw450K9/Bdz0hWlj5niRuV0/StsDuxV+YRcuVouYAJJtmA6L0hLINy2caCkEiHuKzDc
 FBKe1dZBq5G6dFwiVbvVCf3Hzxi15jpIVa2bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715117059; x=1715721859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+pwpxnaDuL5N1NYAKB7ZawefRRbzhg68aj9y2pQPXw=;
 b=LKHfLOoi2vrYK1ZX7X+1/eJCyojdxZsRG//orvDbgCTls5ozc2YDq9SzIiD2G7Gux5
 zEGq1JaMReFiHS0ouAhgJaUoGVDC9DkpKq223D260K1QDk/YfCmnz8uAk73eDN290qzr
 Rdzos+d44gTd8BmxHNMyszxh3GEiLhW1urgfEGnkLN+f1UOVtHT3gMmZGXEmdwpaMf8l
 MVSyXuvtgmg/Em22spth/c9a6mO4J+HNnIs9GMleO9ODeiw8p1EreQq2ib5/OLen1/eV
 7bGV6sCREclmpgmmOXhJmwBDqXPNUDStdKqx7itlIa86rKgIRrYAlPL+6SqweywI/8ga
 nOdw==
X-Gm-Message-State: AOJu0Yz8cvgPatVfNS95ppi1zrxRnbIXac/s/JFi2f1qlNCXeCiX3lKw
 HqLdh0m8xX10cmCUVQEHKgjO+cMTW4nBNY2N6aSUpxpTWLA4p7bNDLXxVt0mCio=
X-Google-Smtp-Source: AGHT+IEYHWg+ChzNKZ8CG/2jJE5tktUEELQ0jNdeLNlk9gagj9kQ/baqsgqIXQnxZuBOa86XwEhvjg==
X-Received: by 2002:a9d:7643:0:b0:6f0:47d8:8193 with SMTP id
 46e09a7af769-6f0b7962409mr734627a34.18.1715117058767; 
 Tue, 07 May 2024 14:24:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05620a034900b00792a5a70af3sm1386739qkm.18.2024.05.07.14.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 14:24:18 -0700 (PDT)
Date: Tue, 7 May 2024 15:24:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH v2 08/28] md5: Adapt to the changes of md5 header
Message-ID: <20240507212414.GC2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-9-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WA/H2qHp1wzL6dkC"
Content-Disposition: inline
In-Reply-To: <20240507175132.1456512-9-raymond.mao@linaro.org>
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


--WA/H2qHp1wzL6dkC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 10:50:50AM -0700, Raymond Mao wrote:

> The md5 header is updated to adapt to both original lib and MbedTLS.
> Now we need to change the API callers accordingly.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>=20
>  drivers/crypto/hash/hash_sw.c |  8 ++++----
>  lib/md5.c                     | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)

As this brings md5 in to a consistent state with the rest of the
algorithms, going against the normal coding style of not adding typedefs
makes sense.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--WA/H2qHp1wzL6dkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6m/4ACgkQFHw5/5Y0
tyyBZwv9Hvass3M3jP6KqRJNI2PLZ5bStMj61RrgxWO6aZTMNejKGHo2flVjBP4l
6fw/JieNAdCXNYTCfG+YZbJU3IEHiHd6le39ALjxOEk/unsZsNo/i8OE4s7Jl1T3
et8miAT3yobXw1IaI2vnLK/pWOW10123Ru1jxOqu6Qwo4NvXl5jMfgAAnxKRTGLU
q1FzPcTPQU7hWRrijDThQowUzudU+OQ4C5uJ4cZkxTsgHZiQXogPVOpg4xpOk3uA
eMCAqx0XeWMBY2C3X8EWcswfFzlr9kQPyWaPTGmj0mdedvumutVP/JMeZUvVSmlW
7j9nqYb0pzCgLo4OLH3M12dDrcSafVFKMC+6cavXoCOM7WYW1DZwQ5JXCPVr5uhp
lOxQ9WnOaPhsaszFrVLxG6Qn0sL36wbrVdx6VEFEb/rfaksk+d1M475Hi7hlplhI
Fr4dhA0pM+wbc/DmX4o0eMa3+sItJRkm7/4EKIDtLXTdAhEt8/bcLlv+qHrreQ4A
5exTqqFV
=ejdH
-----END PGP SIGNATURE-----

--WA/H2qHp1wzL6dkC--
