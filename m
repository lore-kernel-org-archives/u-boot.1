Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A45CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 13:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8E488363;
	Tue, 24 Sep 2024 15:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="evg2kzss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF2C88363; Tue, 24 Sep 2024 15:21:37 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8898814D
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-456757d8871so32503291cf.0
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727184093; x=1727788893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GBspt73M+v5ImW+U2jlO4nDxAJc+S46P7qQBHEUd+0A=;
 b=evg2kzss7xTjdA5VECjYOBrn9HXzHkBShsRErMoyr2/LbrFS8rXcO1Dsf/ENy9yIaf
 k0cvAYWwpgJdVWT61YI+C0UmIGULutWqP0hOmssVhUb/a+CDE319cG/ty5egY+LC5Oyj
 p4RsDE5blH05SNAI8uYrRt5eJe2gduYWIflm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727184093; x=1727788893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBspt73M+v5ImW+U2jlO4nDxAJc+S46P7qQBHEUd+0A=;
 b=iO3TAODJbUHzSuhKpz88ToXJ1MfU1qPU/I4dh2kFWViG4KuoI8mUKzZYwh70W/WJdA
 qf6IdxdYUCihu+Y4sMfguFteEvyURpRJ7ZzqTpseGqQ1uz099DBQjK1A+M40w7FuMfHO
 mkWpfYjHi6JB8ofAUPiEwidqz0wSv7K6HNt661QKOCP7KA17KS4qM6ii2aRqgN7/WXVv
 Fb5jIDBIE4ysnsLCAgXpFaLsAt72cng6gHicLeQXOfeKX9ui8w7Eh+oFBierJeur/WRB
 A5XYTc+EoRE3LHCb20MkDc61gl9op6ppvD3ApouznYgwLPEv9B5k09ZL8plyFnsnKOd0
 5G0A==
X-Gm-Message-State: AOJu0YyycTUsPpMipuvL52vvGraSKPwzkQFVSQnv6pDFSIPKhKn/dsRm
 W1BY5elGVsbWlYRclFQ4bbe1XezadE0ujOCF6UF5s4ZAmYdj+aQaNAq8V/19CMY=
X-Google-Smtp-Source: AGHT+IFsVSRaGb7Ze31LasAAy6WLN9z05PlouNisECQPD4QbbU9cS+k9vmVlwR3AtnWLfAamngniAg==
X-Received: by 2002:ac8:580a:0:b0:458:2e21:e422 with SMTP id
 d75a77b69052e-45b228cfbfbmr239846221cf.50.1727184093113; 
 Tue, 24 Sep 2024 06:21:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b526c6d67sm6156511cf.96.2024.09.24.06.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:21:32 -0700 (PDT)
Date: Tue, 24 Sep 2024 07:21:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [u-boot-test-hooks][PATCH] travis-ci: Add qemu-arm-sbsa-ref
Message-ID: <20240924132130.GV4252@bill-the-cat>
References: <20240924084935.431168-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kKEjcq/Lg60y/egE"
Content-Disposition: inline
In-Reply-To: <20240924084935.431168-1-patrick.rudolph@9elements.com>
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


--kKEjcq/Lg60y/egE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 10:49:35AM +0200, Patrick Rudolph wrote:

> Add support for testing sbsa-ref via QEMU. sbsa-ref has two SPI
> NOR flash, one for Arm-TF and one for unsecure firmware, providing
> ACPI tables to the OS.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--kKEjcq/Lg60y/egE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbyvNYACgkQFHw5/5Y0
tywOiAwAshAA3VQMQkFWmkMULGxF6HkiSsTkD9W3wFahzHdtCHpZTJnEwO4Qbh+v
osIXcTTMVo6RncQc8H9Q2awESt4/qHLy0d7gx/cNKUjSdy855fObqMj9kyqXxJ1M
dXIQ/AerKZlf8w+rYU4fALU38aD1GLdvsFWQB7++NRkv/DvwnhCxCoY7eeIua9O3
EScvCqll/piTRTuH3SBi9GB6IQNO+98dH7pVnEH2nnt1vziGzFGPFuk9MB1p9MGT
QmnOQLOZIEwZOLc5kJgJgub0VAvcP5MH3V/dfpNV3ctM7aAaSw0psp66yvsCwqW8
c4m8IPInAM5LQWmtPoV+a4yQUEwOyOvBDQw0ylJAgQn4Li3fsqnQGVs3QqsuNVAz
sV5dECet5Fltz6QXWz+JRHT4ElqlXjGa6E7itiIahbfr9ltX6xuTuCuywojoYyYS
ngtzwv2SRlfu6DcMnfKu/4P2TrAyHN3yywU0n56IMoCJTbQCbJKsbkenY27YXOWM
zDuC0I9B
=SolM
-----END PGP SIGNATURE-----

--kKEjcq/Lg60y/egE--
