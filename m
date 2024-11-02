Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA8AE67814
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 21:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621A089080;
	Sat,  2 Nov 2024 22:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QTL3qsb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A633A89080; Sat,  2 Nov 2024 22:39:22 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C4289066
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 22:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so21345016d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730583559; x=1731188359; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HdxmGV85UUGBhDRYRzzobiUbkS/CES1SJLk81tgXnRI=;
 b=QTL3qsb3KSC+z6oZFC2lbHwU5V104oGMTOx6c59t0sejr2O0m+UVPAy/nisypnEXCP
 7kch1uaCWdM+KiIiCtv9dmo1nM6jbl0hW8wfHudyVeA9zDXTDekR/x9ZRjIIIvUlMQen
 pqKPWtJJejNweYaTnY6Mbb0j2dLSyYCR/9jUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730583559; x=1731188359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdxmGV85UUGBhDRYRzzobiUbkS/CES1SJLk81tgXnRI=;
 b=wS3P5uheH/hKh+gr2PWnRH+3Tx4C4nbQWeu7YVS8e3DTfOxPyjhJajUVZ6llashrYB
 cUshRq5IgGZkjsMJvH+J6mzB2C+zBYvHNZ1hWLjGTiO/Nneq22zWZxLrFsMGQLc6mu3m
 cCb3i50gpzDhWBApRY2hfq+COaLSsxW/1xJQ7DZbacU/6RHFTr/yroG62a1nYpR+ppja
 nDeBfSEFpIoXTSe1WIZ0WXzfeVAtwFlBw+g8mLXDHErvhkk+aFV9VHl4Tkcs5SfYPtJp
 u3wygWLUAh4M5cKBzMK50JlJJXP1G8NVze7VlhpMB0Yn8ZWKLKdN5tJOsipodWbkmzbc
 tARQ==
X-Gm-Message-State: AOJu0Yy2lt/X5WJIZxkVFIm5cfoKeRJtJ0SoxiQeuqBB4M68b0IDoyxl
 A1b/NnRaYMdd3VU5QHkPBy9BH26QFqBFcdMrhyBzWiC4qusu7KL+iyyhXCh846U=
X-Google-Smtp-Source: AGHT+IH1INMMU7wb9m5ex1pUc7h5APfwPxX0Bud/OrKzmylozEbMiVd6BiEZlxTjTTXOnB3F2YXqgw==
X-Received: by 2002:a05:6214:4386:b0:6cb:5f28:6b73 with SMTP id
 6a1803df08f44-6d345faca85mr204040306d6.9.1730583559401; 
 Sat, 02 Nov 2024 14:39:19 -0700 (PDT)
Received: from bill-the-cat ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fc636asm33059646d6.51.2024.11.02.14.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 14:39:18 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:39:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Message-ID: <20241102213915.GU3600562@bill-the-cat>
References: <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
 <20240925172601.GA4252@bill-the-cat>
 <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
 <20240927025159.GR4252@bill-the-cat>
 <CAFLszThvvU8uEYSBh_F6NQViNJ+bFr6mMYzd8yrTAwOp9dhLLw@mail.gmail.com>
 <20241031182822.GA3600562@bill-the-cat>
 <CAFLszThB8urxxjBZcvO8teuu5M+eLaRBb0UHEwoRm+GVyF0CdA@mail.gmail.com>
 <20241101190221.GS3600562@bill-the-cat>
 <CAFLszTgkVRkkyPDm_Kvb8-3dP6s7R9edZzmx3k43gBaiwc2N3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bNxrkuMxyTsoH8Fr"
Content-Disposition: inline
In-Reply-To: <CAFLszTgkVRkkyPDm_Kvb8-3dP6s7R9edZzmx3k43gBaiwc2N3g@mail.gmail.com>
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


--bNxrkuMxyTsoH8Fr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 10:32:18AM -0600, Simon Glass wrote:

[snip]
> My workflow for larger things is that I create a load of local
> comments. Some of these are real, some are just wip. Then I start
> turning into patches once I have something finished and working. Yes I
> should add more details of why something didn't work.
>=20
> Please let me know what can be done to get this integration in.

I think adopting a suffix to your scripts, along with seeing what ever
else of the feedback that was in that long thread on v3 you can
implement will help. Maybe also audit your commit messages and see if
any other details about needing X in order to work around problem Y
spring to mind, or concrete examples. Which is not because people don't
believe you found a problem, it's because we're all a bunch of engineers
and so enjoy solving a problem too and maybe have an alternative idea.

--=20
Tom

--bNxrkuMxyTsoH8Fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcmm/8ACgkQFHw5/5Y0
tyykxAv/QowzmmyYVGZxWX4O2x3m8WaJ3NbopapWsGC8dpk1hfu0LmcZdFBjZXbe
lnBRdVhGCEGwbLxClWhro67dZXBjOQKs6PLw9tZOFF1Uu2S32mygEW0+LWia4mt9
yu95JaFQtZDzOjXCcup6bUEISJ1n5ODbezyPtlCKlnkr7gsOYqIRCwmDffBQIUYM
djmaOYmjFCW/T8fKR5enXxDjzMuXW/F0lYSUM98kIiyMxlIT3Ou1k+h0X2k5F19Y
nA7Fw6Q7Ys+mbCc2x9eXTN9forwKrO96d2tqofO4vIkZ6ASNuOcTSQPLoJz/JAgh
LOmbF3mP6tLrIz7HTCyaOTtTSjA4f7LBJYwA0C7Ghh4JJS1pfDb1au9K6pCUvLuf
Ba9Yeg1QMz+AcN9ksX0OVSdCFjKB29bsn9iyRunMKKbHX7XVzxzIJbg2cPISguY+
86WnRpSq2gn0t9YH4UEASJRLrEYIKSaOB3Z7epUZS2BsqI8wvmfnM76hwnnfEevq
vh7qYyaa
=X/i7
-----END PGP SIGNATURE-----

--bNxrkuMxyTsoH8Fr--
