Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E996EE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 17:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070A680714;
	Mon, 23 Dec 2024 18:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="avUTVJQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489A580730; Mon, 23 Dec 2024 18:29:50 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D017C80711
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 18:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467b74a1754so55042221cf.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 09:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734974986; x=1735579786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oAgFyKGCuIn9t0lh742mc4aQo7PGKMl6mDMlSWX5ikA=;
 b=avUTVJQwqC5+n9i3YsFPeS0OeVu5cEdh9JYC5WUH8WYHFRRgMJXYNSMbdyrfh6muH0
 hoSu+SSCqsJBnIkhs3ivqO5MYTm71aGixwdNizqaPrQ5CmmO9nR6nonS4LiO0puZIMHH
 qi/tgy3MpGjp563gUGSrC+Q/OTrlhEgn2B4C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734974986; x=1735579786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAgFyKGCuIn9t0lh742mc4aQo7PGKMl6mDMlSWX5ikA=;
 b=HUNsSF5onq/T7N/ps2bDbLZ/HZDSA1VNo9u/MG9AkEs6QzhpIae+7CGoCo67IeCZK2
 T86tsoKGOfg6B2mfUF9WDgyeDf527dsjLq3BauSwv1lmLG0pGzNTbNYsjWLcpFmjGUTJ
 7FYldtJAG+F9TK7FPon7jxgjanGKf7+ZE04FFFN0u8pRwqmCsNUtv+RToG6vsAdKEi9T
 /QKrhDGL/XVqZCgmLrJ9BXNZ6oWEmjEKAHTat9MpMLK/Nms9slrt0orTt/pTsS1oza+v
 c71Y6EcUtA4kiXyZWeOB5VIcckVOumoM8iJ7j57BoBsIRJRgAm63nbVEVAWk4xxhRc7O
 H5Mg==
X-Gm-Message-State: AOJu0YyGCSEKq6yCsDw5xwdJ1005OwLeSfutTs3azhyD2SZJWsL46q9y
 J874t0aTaCCHxZjiYDiPLPa07hZzRIpwd+OtFhd7H5adT3NGfWDyMuwx+um6ywY=
X-Gm-Gg: ASbGnct8BC0p66O6JUjxdjt91whgaJwRVMaxwM9PEd44T5anjosanOt7ZQFs+KcN/VP
 QbaIwCeZFeRRU76FsiKYRQSvC5k3O17g0qaU1KYCbCtoFsUE8937d19MPdBnkVKRKAll+jA7H1F
 x13N1w9gAuiTCiH4oG1RMBKomghw4815w4h8GGvfojOIUSY/4Dg14yfdD+8Fl3qBSQIQ3/OVUD8
 n7vMXdWTP6KYCyuPz4/qEtzF7rE1rywO8MfLbioWPr1bgA21Oouw+A/Rw==
X-Google-Smtp-Source: AGHT+IE1fEdrLpGLuRDNExtJ4kmc7t4N8Vq+4Jm7Lq0bqZIdurRL7OLPoMuj9zMTkAgG/iA/gY6wog==
X-Received: by 2002:ac8:598d:0:b0:467:60a8:8a9d with SMTP id
 d75a77b69052e-46a4a8bae0emr202271011cf.8.1734974986673; 
 Mon, 23 Dec 2024 09:29:46 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e684ac3sm45818051cf.32.2024.12.23.09.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 09:29:45 -0800 (PST)
Date: Mon, 23 Dec 2024 11:29:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241223172942.GR1505244@bill-the-cat>
References: <20241222224506.237322-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SUwoxTc/0ZJ+kBwD"
Content-Disposition: inline
In-Reply-To: <20241222224506.237322-1-marek.vasut+renesas@mailbox.org>
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


--SUwoxTc/0ZJ+kBwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 11:44:52PM +0100, Marek Vasut wrote:

> The following changes since commit cfe57427c28763fd94e5bdcf89de9dabca4b16=
84:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-sh (2024-12-21 09:45:30 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 70da4f28592d0a2296b27a9126da97cc3b30891e:
>=20
>   net: rswitch: Do not register disabled ports as ethernet devices (2024-=
12-22 22:34:32 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--SUwoxTc/0ZJ+kBwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdpnf8ACgkQFHw5/5Y0
tywq1wv+J+SE+wHNsK9sR2jT7edip6m3LiwQEvBdoUUq1IfHFQ7JR4OI5RFbgIz2
9RwiTGoHwgi97Dp8latGP6dWJKNduB6scY4GNdV0YU0D0WtJaTzqTWVIOJEW3Dp4
3Klh/5dDWMoLKyjPjPllqMdNdwezNpmb/avgsXINHeXCUYg0l0ErPNMBgTTYEn20
axGmCztxSQN5l7YaMGHkvUc2wlx6U3WHUMVj10ixlRNew2kfPDh9UPUwyun/yQUk
Eh3yAGHbwPXCMjMAGIToHMw5gyUifK/ja3i6gHJHKAnC9zh05NbUiC4ofPyQ2nS5
mNTe8AfRBdnGeZxTcDiuz8XFN7A2nulKuPuDMEvstQGHIJiPR+F0y1yz59D3uyMT
ME3GNNqIBkLDY0CTWSXFH/6h0EMuKfSQi7xTDFwqVcZAGyCcg2XagSDqHVGsKoiU
Zz+TulBzgZrEF4X2DKWTYWs3XbLQTI2dYYPteHSoJZF+WPNor6hEb8G/ISS/eHid
JJmmyXd/
=5jin
-----END PGP SIGNATURE-----

--SUwoxTc/0ZJ+kBwD--
