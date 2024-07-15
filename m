Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE29C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 17:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243038880F;
	Mon, 15 Jul 2024 19:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OnaWnuvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D80288808; Mon, 15 Jul 2024 19:32:21 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE20D885EE
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 19:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70361745053so1794647a34.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721064738; x=1721669538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SyZqurWApxc9yO5C7A/jG5uVgqpr9jGoF02rrz2/kFQ=;
 b=OnaWnuvMZpsGTa4bCO8ekXN/VWUPn88t30nK1MgdXD8jf0gWU4Jc8yB3SBqoBM6Tmw
 9KpOyvvPXT7YlotBHPi1929eWK4FKVgN6FAiI0rSxhw3xRS+V1CfZTJqVHujua829axv
 THZyvRmbQg/zMH7JwERpX4b+90msfaduRPdYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721064738; x=1721669538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyZqurWApxc9yO5C7A/jG5uVgqpr9jGoF02rrz2/kFQ=;
 b=BUrsVofyJ6hAQgn3HuTgOTn5NXaPmes4+81MnxI66ZuDxAeROlQ7SM2HYLSTJGyD3X
 aZ+DTtnZSpIy6vfA12g1FP1krglFttbQTqMnzaVpv8ax1KYa4IckEcP4FEN2YyPCKi1U
 YJOO679VbC6E2az78dcdrZoUDu6eMGHII1P22RaWyWe+lf970PQVr6NaIBl/FNXo41tz
 zSBe+LXFY964WuuyJT3sstNYTVIwXuN6g8wNxfqnIvOqNKwP1r6Z+0jyaPkuf2FcAuJ/
 jrjzyIzLnTMOC58ivQ4mRUZKv4kjMkE0FOwiWLR4mH0izW/GQBXoy203oY74rvegu6Du
 Q31w==
X-Gm-Message-State: AOJu0YyuNXxPFlmi8htn9LUwIxznZyfBb28YXUgQ2Mshqr55j0YpcnCf
 UVaBnxx1fO1nYTmFdym+Gjpytq5U4e/CPobzNXpo37eorpdf7sl4SjLjcuSoTFA=
X-Google-Smtp-Source: AGHT+IECVhBBOSp1n7ofel0jAKKyvjWLEbQ+AKNQApwciREBTkqRzkTqg/oQP3c3B4g82TGrJy8sfg==
X-Received: by 2002:a9d:4542:0:b0:703:629c:5e03 with SMTP id
 46e09a7af769-708b51de68fmr4061272a34.13.1721064737668; 
 Mon, 15 Jul 2024 10:32:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d04f211babsm474831eaf.7.2024.07.15.10.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:32:17 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:32:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: Re: Pull request efi-2024-10-rc1-2
Message-ID: <20240715173213.GJ38804@bill-the-cat>
References: <21695e77-125b-4acc-b45a-d286624c1145@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k0O/hF9gC86aa/4F"
Content-Disposition: inline
In-Reply-To: <21695e77-125b-4acc-b45a-d286624c1145@gmx.de>
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


--k0O/hF9gC86aa/4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 12:53:43PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit b182816c1fb436916661949213c543bf4d4225=
0b:
>=20
>   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-10-rc1-2
>=20
> for you to fetch changes up to da909648e13fdfb5306123f4bc2a89bf2cbf682e:
>=20
>   doc: add bootelf command documentation (2024-07-14 09:56:24 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21597
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--k0O/hF9gC86aa/4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVXRUACgkQFHw5/5Y0
tyzdIAwAuFl0p5RPK3Bcjaalh/GGh1ScbfKI7gy7CsPsEkANTva4MELUeBmQuJf5
II70T6Nx2PJo7JQ8E9It6iDfdVUF56hCdPilKXn0RHl2/daLglVhXhUPasiDdw8K
MSUMaEXDp8pWzbCbFlkQMZ76V1B7JVMUk29aDcTBYD127c+VYO8HP4GWSYBb9t80
/DR+JIbsFjlb/lnLN9shSvTQqyDg4gMNoGDkYjiBoNgZ4tWseme+pmzUNUoi7GIi
WDloErAZTIJVcsiE6gHgEhgZqJf7bMqbLM5EslJlEe4phliTCs23UU68oPOavYZQ
qvf88CQfzasQFZ1DvS2PjAVEuImj7y5dX0MWKfGK21gH93mcinf+5gSyYmI8Uoah
apKbQVMvb3u+4BfEtnCO5NNFAVbBbltTBEyfb4/5hEZ+I/gdocaS7VI51DVBgBmZ
Y1lEepVDR4I68jjiTujSWgb7TrMr+7Fsd6/XRHz9lMbXkmkLoBDtyFiXjd13PoS+
RJaPsge3
=lFFx
-----END PGP SIGNATURE-----

--k0O/hF9gC86aa/4F--
