Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4BBC4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7558716E;
	Wed,  8 Nov 2023 17:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VsoAAyjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 569098716E; Wed,  8 Nov 2023 17:11:43 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F60E86FC1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so959713276.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699459900; x=1700064700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dvuvl16BCcm90M+nqcEsilV7GnXWYjgulFKYyt+KFHk=;
 b=VsoAAyjEkj92QFsnT9RS73ja/ED7Rh0GPwUyevWCyis8mQU8dojcTnVyow1/iH2iL8
 FhBz5/Ezxp3l2u16+zPzV1Ua29RPJifMRQg1iplydoS2OOay7W7A4+PdRYEFO9/yARxe
 DLamozMX85dz/dZ1mD3m8Kfk9NKTQWMqpAqu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699459900; x=1700064700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dvuvl16BCcm90M+nqcEsilV7GnXWYjgulFKYyt+KFHk=;
 b=ronM9doYlgae7LHTJNaRBAi+wTjB7n0/XOfHtwH8I16PGizxz2xw2tIfU0y42rmXKf
 vD4at1f3aF1u+ioYqeUk9eM5eg8ovTS8SJnAHG6w2qMkRrdqWSISgG1XeUnYbpi87GcA
 VaPyB7T3pEbuCIOFMYkZvMEyAxvRCMVWTy4Fr5AAL/QnFcHi3zdNxcEda4QizDwqfnuw
 JclLFoE7P4Lt24i4aFgfUGUcsOvohhOUZdHj14MaFDLUMdVU4eYSmI20XICoAc7yFxjq
 zf+QbZLhNwMuGlxCLLXpoDap6iwGPt3Ssvsb+CWEl2PyARu5cNR6c/89vfeUoJPJojvU
 sf5w==
X-Gm-Message-State: AOJu0YzwgT/SWP0b0R9wR7VDq3Z0glyRvjQz1hUXM323u5hzWmjBNi0J
 omYNhXthDLCRx1RjwJozPq/QKn3f21Vjnal2qcFg1g==
X-Google-Smtp-Source: AGHT+IFG047Lg+7TCPTM3BwPAtiJlJf5u9LnIsXnGZhR0PGonWu4UzImfe46N0UA8Clr/M9jGSEwPg==
X-Received: by 2002:a25:20c5:0:b0:da0:4076:49d with SMTP id
 g188-20020a2520c5000000b00da04076049dmr1686225ybg.15.1699459899829; 
 Wed, 08 Nov 2023 08:11:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a056902020800b00d9cc606c78csm6379553ybs.41.2023.11.08.08.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:11:39 -0800 (PST)
Date: Wed, 8 Nov 2023 11:11:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/6] siemens,am335x: clean up the draco board family
Message-ID: <20231108161137.GP6601@bill-the-cat>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rvUQSbcFRKNKB/G8"
Content-Disposition: inline
In-Reply-To: <20231108145322.302927-1-enrico.leto@siemens.com>
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


--rvUQSbcFRKNKB/G8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:53:16PM +0100, Enrico Leto wrote:

> The boards were not maintained upstream since the development phase.
>=20
> Restore SPL and remove unused settings. We need i2c to read the DDR
> settings from EEPROM, get u-boot from NAND, the console output and the
> watchdog.
>=20
> Restore u-boot up to the user prompt. The complete functionality will
> be restored in future patches.
>=20
> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

I'm glad to see this series and in general it looks fine and is a good
start. As some parts of the future cleanup work I'd love to see a file
under doc/board/siemens for the family and moving to plain text
environment, both of which iot2050 do so there's some in-house
experience I am hopeful you can leverage as well if needed. It would
also be good to reduce the include/configs/ files to as little as
possible, I believe there's a number of dead-comments there, and other
defines that are only needed in a local context and can move to a
specific file or other header.  Thanks!

--=20
Tom

--rvUQSbcFRKNKB/G8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLszYACgkQFHw5/5Y0
tyyurgv8D/Pb7YG60ks8d/WH1OmElv9+2GqL1lE/JUyDLG0oD99vpEZg0AV19AUS
mfbvwo4Zs/fbs6y6rFArhP9+u3vdE9XxU1lR19XtSNLrEzdRaySqNDMpishlPV1G
HWXqnyW0sF89Fa8z2dw1fJnpFDiEXDUa3xdntnadW09kODJsX7dZKbknayvJ7GiZ
Bn5/Q6Ff0zLW7m3i8lafvcq4cLKScF1ZFqx2ibiIQZaCE85YbensAxf0ttdWg/7J
mTk7IkdZwMXzf+mJMow4mxCwuxMYayHmja2n9WrZPPSiR3hUE2Hkr4Im/lX/sx6h
Cflxt9KC4buPwg5iWq5MB6ndmksYq3Cak+TvieWERGHV256YC0WUdZJt9RrB60Du
b2+fouruGf7n4ezwIK4Cfn6/PZUJdndnAMKGzjwCGTTK6FtT+pOBjwg4MUcksALo
lq5C6bFo/kCWULly8U3Iw+l4rDFIaT5DKFJ9A7FPjs9Zs6I4GDG0lNXYVsSJIGff
5Wd3cry4
=D0s0
-----END PGP SIGNATURE-----

--rvUQSbcFRKNKB/G8--
