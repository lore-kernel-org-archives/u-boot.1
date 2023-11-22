Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E813C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2701A87664;
	Wed, 22 Nov 2023 21:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VS2sWwRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF26587613; Wed, 22 Nov 2023 21:49:30 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC03A87655
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cca00db7f0so1986457b3.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686167; x=1701290967; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z00K9rPy481joIs0B4CgmCRtACXami+aT5uHm+QRu1o=;
 b=VS2sWwRthu12XvBJhwrOIMj86HRz2Pgi7qpBMlWpnu5QtAhyxsxeDkaTKc7oGtSASw
 QVZknxwR+LYRCQ3qHS6e+LaLuBCp6rgjWttdkQTWNV51IDjpEtLVxvAC9WVZ/v9Ip1iK
 fFo5vUREAeLvmPxcoSUPYiqOXVJuEowo0zin4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686167; x=1701290967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z00K9rPy481joIs0B4CgmCRtACXami+aT5uHm+QRu1o=;
 b=GAYZoc+duzpw2iBc2RpN3sHWz8X8bBmKpjVVpDpvsUjRyICLDo681D0t2lTAIRmgbZ
 M6uXSTRXdpJJpKhuh7zr0sT5mvZtS5rSmly49c4dl/qRRZgwtA9rdhPoAUZP2m6rC03t
 UWZ3yBUN/OJ6HLbisNi0l6Tw7hFLi+t1wS+ydOpKUqFAOEg4IH8C9au7h8oR+rIC2M/6
 UUVRTPnSmZMGhwup4zJNN1PvNhbIVMgrC6PMd54Cl44AoIsLXyOzNm0yf6UMuXqKStRH
 LAN1bWoXty4ZjIWu/jy9EDaus3clOlL+wWRsIIucl6Y7jqMslEyO8i4CVDqbdL8Ly14d
 pm4g==
X-Gm-Message-State: AOJu0YwgbmETh4EQEQ3tmBhMkVsI9cCb2NghGG4rE/JIIj1zTlF+H4N7
 +bPZ8E+xstASkA+OUKO3flG3QIDWrzawwmTTd2FvPQ==
X-Google-Smtp-Source: AGHT+IE9QQrGTQoZqfbTxcmWILBGapVJkkYxtHiklEcL/XBsJ2Nsz8RMY0Popxnep7Z2CHibyzlHkA==
X-Received: by 2002:a81:6c07:0:b0:5a9:30c3:c664 with SMTP id
 h7-20020a816c07000000b005a930c3c664mr3774730ywc.19.1700686167744; 
 Wed, 22 Nov 2023 12:49:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 u205-20020a8184d6000000b005a0a57cb089sm92705ywf.5.2023.11.22.12.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:27 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
Subject: Re: [PATCH V2 01/12] board: ti: j721e: evm: Drop unused headers
Message-ID: <20231122204925.GC2513409@bill-the-cat>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AQ4IVAZZkXUBi5RB"
Content-Disposition: inline
In-Reply-To: <20231104072150.3339-2-nm@ti.com>
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


--AQ4IVAZZkXUBi5RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 02:21:39AM -0500, Nishanth Menon wrote:

> Drop headers that are no longer necessary for build
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--AQ4IVAZZkXUBi5RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaVUACgkQFHw5/5Y0
tywATAwAoNVC7ZbquHe23qr2egnkacOoBcZ46CY8hGDpTFfYph8eIzC0V/DI+x8E
dQvvDVoiCJWqgYU1iHia610WgvWBp+JHlerasKNr4HCZqXOLJvCzG3IhJPEEDS+q
2Mrx620a2zhI9vKUSndChfW7fNhluMjQhuzfWybhEXs/fTAXLzsUG+q4c5MLDH8P
tIGSE08QDjX5+cOBufo0QuBX+v1EgblEAjXlwNDMeDjthW2N0N1I2DdbO3Ssmcum
f4hwm1edxE8mCnhlLOoF1Q/AB3vYuuWfbjZeZTU1Xl6+UOjdOmGJFU/vW4/LLv/p
8jloJT3PEQhR8IfeiHPser+Son6KLd2+tAAnhg5GdDe7VHkFX7upozxpt8ucXNDS
X5WgEyfPJRMrDoQyhtzqS36FRdscigcpAoj3/2uU3rc+APAcJBfGKvdy3OTmtmpu
u4Ldxvd8fvhe5FUMs/ZBEBIDV+TgKK2xmTCBBGZRnMVLamlW55DGHw9TGmd2MLH6
pRd1kEu5
=k4nc
-----END PGP SIGNATURE-----

--AQ4IVAZZkXUBi5RB--
