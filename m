Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A037C3ABDD
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5979982A0A;
	Wed, 14 May 2025 18:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a3euOXOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C351D82A25; Wed, 14 May 2025 18:50:08 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0ED829E7
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f9832f798aso67433b6e.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747241405; x=1747846205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vp67Ig6y/GGtN7RoiFfhs0Idkic+iXR1W0wsPEVsBAo=;
 b=a3euOXOW4zZQ44i6uwe2PgpFNfEQYp7n3MRb6PW4TfBzEvkQCIxlw8hQXMxiabjl5F
 IQIDa1KZ8L5PfY+p6rzTp3IyqwOzArTHvb7yVvkz6oxUPY6rFhKrIiXo1fQWoQ/gU0ek
 lEduZQwqvwGqjHxeAObhQHBp1m8qkRzMBDFvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241405; x=1747846205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp67Ig6y/GGtN7RoiFfhs0Idkic+iXR1W0wsPEVsBAo=;
 b=dvyeGWuAffefAUKxGUl1t62hjvl1jGKY6BFSCoq1muXwXcwYL/ahcwiJUZtd7AtwIo
 e/ijS3mhzc5+pPJcA2LSiURgGc+euGdIsVONd0NoylKHPm/FBfOmHoI3QZrVRumqMtZi
 FVo9oPm3DrlYCKXqm1KsWxXWC+c+8Df3amocuUqi5UgLytkCFSu1YJ/3IEViwoLFee7t
 E6Ce43cIXuBlb/Wc6B/taIrTjHHjF2Ah24Z+MaxCy8Jg14XBT4QHsTJkv6G/mD0/eMO/
 btMCEC12OPxCUcsOvnTWKesNT5sbIuKA0EboOfTAHqBvb9tOYLbkV6k5OzY7CVZOAnSC
 a5tg==
X-Gm-Message-State: AOJu0Yy/AQMCA5TSnYl3pe9YVJvXubtjC9/5FnU32duiODGEe1s80pv4
 ghPLPzh/4mUwDMAO4nzUImPorZCZdrfpHzMhhrNat3SQI2ysUYaUUKRhphL++cU=
X-Gm-Gg: ASbGncsHxfJ+tkY99FxSeWlvJQSW10NwKZmg2Nhx+0VZCz044sYcaFZjN8Hs0i74QFX
 oOYzX1MuVl3EN1Sz6+mzAVeCR9n55xV6/VtvJiLVC0uS/Qsva7PMTbg+AXH/mMPNa4PaFbK/SVm
 L3YZiXNMWv87f/om/D475jJtyKR3HlLSduw7uYmtnEJ/uQ9tDOrIWNYiV2fsIUHRtIDDQ+fujEa
 AFr6kGfS5TNq/UlK8kH5iLSc5nJ007Tkb6sENChgUC+CPFZ4ao4LhOxVP+2q99jicaEX004UG0r
 8DyAWKV8dvK7iLEUMR0Ufu//vlLUHASPVCbGMsc4hHyrJT4ZTxjcpWyqJjAUxhZIym01rauiC2V
 F816x/IpPLtcw
X-Google-Smtp-Source: AGHT+IHVt26VntyYBpswexrk0ydbxZdX0skLj38fOWb+TSJEWw0vL2iJY4ZvVaY8CCm585re19LvuA==
X-Received: by 2002:a05:6808:22a3:b0:3f3:d802:14f1 with SMTP id
 5614622812f47-404c203664bmr3000734b6e.12.1747241405384; 
 Wed, 14 May 2025 09:50:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7322647eec5sm2403894a34.13.2025.05.14.09.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:50:04 -0700 (PDT)
Date: Wed, 14 May 2025 10:50:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v3 1/2] CI testing: add http server to CI tests
Message-ID: <20250514165002.GZ603748@bill-the-cat>
References: <20250514161841.3591411-1-adriano.cordova@canonical.com>
 <20250514161841.3591411-2-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="01CwthzS+aP3h7p9"
Content-Disposition: inline
In-Reply-To: <20250514161841.3591411-2-adriano.cordova@canonical.com>
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


--01CwthzS+aP3h7p9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 12:18:40PM -0400, Adriano Cordova wrote:

> Add an http server to CI tests so that HTTP booting and
> loading can be tested.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--01CwthzS+aP3h7p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgkybYACgkQFHw5/5Y0
tyy8UAwAjJFPrU/JaX12bOC8Z5V057TrERyGL/qHSBeY9yy6bM4NQ91mll4QhWYN
fy3KB09uAS5iF8phoMRZiaLvR7XGQf6iGW1GCisXIr5HC18+YYs3dmcnSa7dgFRJ
6p8oprGyadPHD6mSQTDe+atu/dwNPR0jJtaAw2YmnHrAvp/zDZtuWML+Z3dsy+6w
irzjbhi0t5qSeGCIRQjhO8M+F9k+zif6tPhDBGdo0DtaO4FQUZvwOk+KBkNuD6qU
CjR509Y2lhRD0unEModyCOOuPv7GeXmeTnEpCjgZeu+yMFaEaTRT7hh7dGPoEaHA
fwz2+1Q7BWZyRIb2ZikWoVn0QENT9bdShe1lKncYkb10JfRlKw8tS1R1ZlEXxwsK
WyP/qLI8zWRhz12PkkpyfP4TGP56YdrEQXA+pNNzuB7jgfFxSkwntIEK2lt8d1EV
WTyURmWmw8ptpiBCdcsU8OmhLa8PwFSqQS/8jLgz4UfcbUWFudWi6Ax5d2F7FPrE
b135olKG
=E8Qp
-----END PGP SIGNATURE-----

--01CwthzS+aP3h7p9--
