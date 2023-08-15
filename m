Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9A4C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145FC869A4;
	Tue, 15 Aug 2023 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dTELYE+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9CC86863; Tue, 15 Aug 2023 16:43:09 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3303869A5
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d659ad4af70so4772245276.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110585; x=1692715385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LIajIT4WDcpmPjLujKRYeEUkB0+UdCSGt/z4DSNf3TI=;
 b=dTELYE+77MSS2aK5LVdxARK7poY/abGoPL6XpmGqVaoQPX8Yr60pcbcy5xE7WMuGnq
 GKrsFoz+DUqhDxYM2QKF6PzqOHAEnBgfnzLoBlpt7x2oaPatp+xx4NTirUzJi6JLdFuj
 vqd91Tk1v7tXFuyuqSv6TXifakoweKKG4yYFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110585; x=1692715385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIajIT4WDcpmPjLujKRYeEUkB0+UdCSGt/z4DSNf3TI=;
 b=FXz92I82N2SZ33bbNb+JYMxGKFmEVl/pYKdRnuGshJeVjZrWJBB4N3EcBhj27GorWd
 iDntTb582X1rIVec7aLgmbUdJcmm7TgB82w1ZowUHW9WN03T32JDPWR3toy2d8fBtMYi
 xqvoIfXoQ+waT5PiAT+KhAjVtE03l+rV6/FXiumAZMnmCjNRICyrLZHSHa5xW1e/V5gN
 PPJor4m90CCsFl+0L9FADGwzdspmBnYCEHMjF/wrL1CHomc2r/izYOlb8e7xkz1w8TOh
 +ndH3SGQOIJZ8f0/5KEsl0w8F9lpIEUXjeDPERlyY7Llf/3l1Qkc3E1Wo6RhJF0b5b05
 JMWQ==
X-Gm-Message-State: AOJu0YyTvksww2YVaG57lIj4BNK88tr+3J4BXRfDOyIC3wWCejBKKZQR
 Usj/m5pA3kaS7Coom06XwAuVb5YbL060P4qzYBpmlQ==
X-Google-Smtp-Source: AGHT+IEiZT/NYJG0BVHPLJgWLCEABD5n1fF+1GZqaOf3sBGs9138eyoG0m3vEfPRulS5zhAdAGQUrw==
X-Received: by 2002:a25:e04e:0:b0:d18:5202:44ac with SMTP id
 x75-20020a25e04e000000b00d18520244acmr16641063ybg.18.1692110585470; 
 Tue, 15 Aug 2023 07:43:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 78-20020a250d51000000b00d1b86efc0ffsm2985726ybn.6.2023.08.15.07.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:04 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH] pci: ftpci100: add new driver implementation
Message-ID: <20230815144303.GP3630934@bill-the-cat>
References: <20230730181709.1608133-1-saproj@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GhCPuJGA+TvCJrHu"
Content-Disposition: inline
In-Reply-To: <20230730181709.1608133-1-saproj@gmail.com>
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


--GhCPuJGA+TvCJrHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2023 at 09:17:09PM +0300, Sergei Antonov wrote:

> Add a new DM driver supporting FTPCI100 IP used in SoC designs.
> This implementation is not based on the old non-DM ftpci100 code
> dropped from U-Boot.
>=20
> Enable the driver in sandbox_defconfig to test compilability.
>=20
> Signed-off-by: Sergei Antonov <saproj@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--GhCPuJGA+TvCJrHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjvcACgkQFHw5/5Y0
tywRsgv/ZbSnwfPUYJg5NyO8M+wcUPrwP6RM/4R6vXx43xlHrlRAnPtOzkKHP9/S
OOg4jJ7H3Jesza4OdBBkR/7WeM/N9bSmtgPKRLuZ+MtsDWWo8TLMS3EBXP5u8RI3
GcMFxi+4iXapqzJoDKK9lcOhr2VaiPhfWpgtv0QngYyoVx9JX42okB8DIPoz7t1F
68S7hVNhtVdC/Z1HvGnlF1nsXOQb+CUr/behn0JFsa5YxidCeiCWS7X3j5meU96n
nlfUHYFXZD5n0lbeDdATrZoWwpKpBgmpkgV825FHQXEZ8i2FrRTfrV79Iw1kcuRz
6gyet+N7OUiuBW1TnXbXuhEUwen21/Y131frmaf6TlYHM6SqUSWUDzChQtNJI+bU
CD5LKlvUnc+3pNA9cSQaFoJN2a5rjHGoAftl5cajdmTJRddBinRcInVNcA1+hl+c
UDZRgErZryvLOhWFnrvJ3yr18URXxXgYxbAiahzxE8yDipgwSj7akrSQx27l5Daz
bH3qwjaD
=ZxRs
-----END PGP SIGNATURE-----

--GhCPuJGA+TvCJrHu--
