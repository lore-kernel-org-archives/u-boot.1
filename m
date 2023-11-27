Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D384AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 12:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EAD8753C;
	Mon, 27 Nov 2023 13:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kCIy6fIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DD087540; Mon, 27 Nov 2023 13:55:14 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C50087515
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 13:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77a453eb01cso222975385a.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701089711; x=1701694511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EGHOTmzWXn35FnoQclpHtFA9HXKSz6S+O6SBElhLyNg=;
 b=kCIy6fIaSvrXQqd4Z81j1Prot85K8Wuw0CH5M7j/a/IZykDutC6kFiRwYxEEldeOJr
 UsBwm2K+3DieWwnHjALooAe/Tmxftbm8xZTm64Ye6+ySwV+Ze6O3+qU1A/cEGKsicKcG
 nBij32srWWnmB3sN/0qXJzKxrn8OWAPguqUwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701089711; x=1701694511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGHOTmzWXn35FnoQclpHtFA9HXKSz6S+O6SBElhLyNg=;
 b=BYhMTLcQPFH7hYklvdS0iXNoRJm4BL/Y4CCvFjJFy3Sb7zUH7VOgMs3Ev12ARb7r4E
 1/Pd2g33ESFPv8Scz7DfKyWwHQUxJAyeHdv3sRyd06OxwUmFKtptmm6F9HmLp0dRyujB
 Fv2c4L6OHit7oKQJOp8V0Jw3bkDHVL+PJRzrfu2sOmAzG/Cuu6rLP0zZlc3ezt1Kd6ja
 Zy3k4hpdUpOPzTt381RQ5Q0jE8B5OsWNsZuDsYH7Fd6c0Ps6VUFhNtzlQY35Um4TpMOX
 Khp5AWkR8RNeCU925cO+fvQA9bCbb6V7ixSCCeC4w25uzlYG9aA5m8/qi0PXXC4qaMTw
 ZNOg==
X-Gm-Message-State: AOJu0YxNfd2Q5wMlaz1bCfZVG7/SOUG7e/HzzSm05YVEZit5v8UEKpWt
 ww0Trwrk53xQcuUHptiLlxs6fA==
X-Google-Smtp-Source: AGHT+IEisdumt/zcPv/S4QqwvsPA9ZsCVskDvKgewB6IbeDyPj/1fq8C94+jXsoTEXIXt0Vq5XPm2A==
X-Received: by 2002:a05:620a:4b4a:b0:77d:515e:e84 with SMTP id
 su10-20020a05620a4b4a00b0077d515e0e84mr10807216qkn.23.1701089710854; 
 Mon, 27 Nov 2023 04:55:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 c13-20020ae9e20d000000b0077890c8896bsm3632998qkc.134.2023.11.27.04.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 04:55:10 -0800 (PST)
Date: Mon, 27 Nov 2023 07:55:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH 1/1] i2c: Bugfix in i2c_get_chip_by_phandle()
Message-ID: <20231127125508.GB2513409@bill-the-cat>
References: <20231124140400.32027-1-pro@denx.de>
 <27d8c4e1-3a5c-360a-a59f-31a38e2e34b8@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2QsIj/5S3M5WJkP"
Content-Disposition: inline
In-Reply-To: <27d8c4e1-3a5c-360a-a59f-31a38e2e34b8@denx.de>
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


--h2QsIj/5S3M5WJkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 07:12:35AM +0100, Heiko Schocher wrote:
> Hello Philip,
>=20
> On 24.11.23 15:04, Philip Oberfichtner wrote:
> > The "i2cbcdev" sneaked in when implementing this function for the
> > bootcounter use case. Obviously the intention was to use prop_name
> > instead.
> >=20
> > Fixes: b483552773 (i2c: Implement i2c_get_chip_by_phandle())
> >=20
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> >  drivers/i2c/i2c-uclass.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Indeed!
>=20
> Acked-by: Heiko Schocher <hs@denx.de>
>=20
> @Tom: Do you want a pull request from me, or can you pick up this?

I can get just this, thanks.

--=20
Tom

--h2QsIj/5S3M5WJkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVkkakACgkQFHw5/5Y0
tywzywv/ZVX+3OMb4NFcasEXH7y5tbhL/E9mgE6OfEygRXEGQs7ZkKbHBCdhmYqU
kKTb0LISJ6PVtuKUaMH13bg3zaa2JB3VVhwvFZ7Va7Fw6vDRLbbRQv9Y8QPfXMpa
MZMmuhtxOt8c5fAFVPi9xYsIUbJQfrn0pgj2OxG0/Eq4Yv7GJzpDJiy4fR+7sTio
Y1wFzQwDR26N3upzSCdXEqSKpJPjTeBpRiBNMSLzT+vuANQByjwDTJ10UeV4DR8M
yUeNedm9nmCNZCcUIIa3PZ7l4wg2zKGmgI/1/6pDHyIsSy/94PNyLmbrY4yGT/RQ
2qBNHhYVOP3WpwjH4Hbg3J/zYrCwl2fWx/yZwP14ZilXlEQ0f8mEX0ao6gCEJDcB
+tsypFmkuJwfayes4xrltFgUKwQnA7smmwQV9sYvA21wg0eUDzE0DxGEA4SSa7bM
AKnYVKZB5VBrQQorRJmjYNlJKTW4Dfj+Ps2HXuC18B+O49+1GKlg+wgkXf1HLKLY
8bYp9vr6
=wIth
-----END PGP SIGNATURE-----

--h2QsIj/5S3M5WJkP--
