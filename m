Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F94C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 23:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2E5870FF;
	Thu,  2 Nov 2023 00:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mIQc6R0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8299875A8; Thu,  2 Nov 2023 00:23:00 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C70870FF
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 00:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cd1fe4645so1389211cf.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698880956; x=1699485756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I/ve4MCFRvTWPwSzul0FpDsXAzgxlc0fbht+L1YnbPs=;
 b=mIQc6R0A5We6MTih+Qb1ECp3ErXGzOjm7+OYBC4vYGFPteweBeGFIhnYFsvJ4wKP3c
 UPTQ49/C1J1HgFs+QzuCwGjzW4gZhA9q4FdmCPyhqrDCb6bmeWpfNBSzAoQD6M6ETTe9
 FkNmghkP7goUmeo9cnG51e4jD+tUB2A8es40I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698880956; x=1699485756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/ve4MCFRvTWPwSzul0FpDsXAzgxlc0fbht+L1YnbPs=;
 b=cd3PDpOnWftKFcniUZJnOn9t/h7u/faOiNOpu0FFPtYDit/RYxIIc+sKAKCRaxqUw3
 qFW1t4yP42EzqAbchNhwpuul9hCBxYskFJ9i+ycXXj00azrzoY2UXLAJMTmuoRiUqkMQ
 4NIPNR1XHnWDjcfUmK9YuLr5EmIaQxuxEXkDTnnRCiFgENWVqTqoiPWdJ9llHx4b9BTA
 E3TeX+xjjt5S+2mCAeobbpRqRNhGkv7EcN4mV33C1P/E0lCDOOjzIeiiFucWRqBTSGhT
 BGHbLYw+W3BfujFG2+5HJU3TgubMIPRXw/VZjOg4RbMIhHA0cMJeIwrEgNxxylg9//vQ
 aiog==
X-Gm-Message-State: AOJu0YzHgUjJ2h99tLxYPfac0DcZAMiyhTaNntq+8SmP13l006a0415Y
 FEvVWywpLfq1SgDHUznZxZ96/g==
X-Google-Smtp-Source: AGHT+IF50R0oDu7YLZTaq7LmUkM13NIc5aHIZHY89otHKIKDk8NPKUpVhtvGqgjYDlhhYYd/8IpeBQ==
X-Received: by 2002:a05:622a:1a8d:b0:41c:c3ad:922d with SMTP id
 s13-20020a05622a1a8d00b0041cc3ad922dmr19310351qtc.52.1698880955967; 
 Wed, 01 Nov 2023 16:22:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 r9-20020ac87949000000b004181c32dcc3sm1793170qtt.16.2023.11.01.16.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 16:22:35 -0700 (PDT)
Date: Wed, 1 Nov 2023 19:22:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Pavel Korotkevich <pawday@mail.ru>, u-boot@lists.denx.de
Subject: Re: cli: Add explicit kconfig dependency for CONFIG_IS_ENABLED macro
Message-ID: <20231101232233.GD496310@bill-the-cat>
References: <24370129-51c8-5a0f-4c3a-3c3a86e65968@mail.ru>
 <142fae2e-7d24-581f-4974-b98237e54681@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OeND2phzpNaswbmn"
Content-Disposition: inline
In-Reply-To: <142fae2e-7d24-581f-4974-b98237e54681@gmail.com>
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


--OeND2phzpNaswbmn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 02:32:06PM -0400, Sean Anderson wrote:
> On 8/5/23 19:32, Pavel Korotkevich wrote:
> >  From fe2ceb7c4365112055ecfc3bbf68ad47330b744d Mon Sep 17 00:00:00 2001
> > From: Pavel Korotkevich <pawday@mail.ru>
> > Date: Sun, 6 Aug 2023 02:00:41 +0300
> > Subject: [PATCH] cli: Add explicit kconfig dependency for CONFIG_IS_ENA=
BLED macro
>=20
> Please add a suitable commit message and use `git send-email` (or similar=
) to send your patches.
>=20
> --Sean
>=20
> > ---
> >  =A0include/cli.h | 2 ++
> >  =A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/include/cli.h b/include/cli.h
> > index 094a6602d7..d6dbbde070 100644
> > --- a/include/cli.h
> > +++ b/include/cli.h
> > @@ -9,6 +9,8 @@
> >=20
> >  =A0#include <stdbool.h>
> >=20
> > +#include <linux/kconfig.h>

This is a hard NAK, that file is -included by the build.

--=20
Tom

--OeND2phzpNaswbmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVC3bkACgkQFHw5/5Y0
tyzvQQv/ZULbs86KCAZJyN6V8RkF12CzHRGC7aD4wZgXirkwQPiIKiG7TJdW2SRn
gjVTzkcaIau6yguyeTZ9fqXsBe6ftD8EDpCaU+Al4kU+2eMYairgSdBHpoowplZG
har3TpbhYE+zvehID/ZF34PXCRRVC8p/pcEkUj8XNMS0D69sg0vI8weZlq6NJ5OX
IpEwLVQacfTtrf14Fckd4JWMEG01vQB/ypSSUDiDqIWR66P86ydko5daEIN57xRz
sJVslOax4CRJ2y1pbVfh5bYCcOpsSizrOdvhrwjtRT1p5ii/SS7+4nTIzVhAxF3l
fL1rc1oI6m2aP4hrkHr74Eb3To8sTy+QfOtDcA5vrzJ64OKpZWG2CyT7J1Irq1wA
rr2wyaOKvJSIaPlWS//u8To/2lJa0rIhwWv+sPqfrE/M7b3T+rM39n1qnBs5rX4h
Tb8z10hOAerd7Vep6rjrgD2+y/PgIJzHosb8QMzSiYF0eShNLTa/x5HOvR+uAI8Z
PGy6SQDa
=hl6A
-----END PGP SIGNATURE-----

--OeND2phzpNaswbmn--
