Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0512FC47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC4F87C0D;
	Thu, 25 Jan 2024 17:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OyjaSqRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E87B87BE4; Thu, 25 Jan 2024 17:14:54 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE9787A2A
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ffb07bed9bso44307227b3.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199291; x=1706804091; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KtZXY7SreYcAdIeQ8CQPS8AOJVTaGwPn1JRavgBaCJI=;
 b=OyjaSqRZh0gXiXcOtyYQt4V8jlQ8wwCynEoTiWI13XfvPNyXS0mbGCe3Z2B43ZFHj0
 CQF0KoBdJSULAlQOo0JOs910JXn0IW+fmsz1IBoB1WedJC2tUOFjQZSjkYRy7mapC3uc
 6WTFe76cEJm9fxFN+mPbOKr+OJx9c97oQpELo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199291; x=1706804091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtZXY7SreYcAdIeQ8CQPS8AOJVTaGwPn1JRavgBaCJI=;
 b=NCeoZhEXMO1xWusJ9Mg74rGVpdB9vnxNZnOyFlCRUiUKjCe3GAcJnqV2T3XoLcK3BY
 jD1hxWRkfv6BjuoFBxrqU2M7bCH/thUkMd0/2UMQ2yrxluDn+8/Wm6AoB7sw8XtPWhWL
 scrxgfIjQRrbdj/H/wHR3CzvOwKpx++3Rkh7aZdZniQqbeGBnbPRwBYR076s2DwLHE0s
 HxCoqZb4NPBU/iIEgG30vSnMJKTw2Y8o95HzKouVDZ6d0nYUMoiLMHZ8UsVCYsqyiJoj
 3jZJjDV2tvBN4yJJhX67rChLD8Tlajb76IjJuLSuK3d+642zum2urDVRjJAX1KdVTgmz
 LwlQ==
X-Gm-Message-State: AOJu0YwQ+a3mBO3haEzQRBBhYB9KE+Jq4j7XnQwUJWBt6UwskL9QTj6V
 GBLoCwudZOQNze/aoy9VTGGd6K7Rj0L6Q1ROTCX1Kfnzb5HcBaSlDaar7JeBd1+3T+GEalruoxB
 a
X-Google-Smtp-Source: AGHT+IEYsiuMrztnrOiR0nGUWxxxcybwSa4+UqMVfp6agn2seprO3RnDrPDw0ZUm4767tYHGDfN/fw==
X-Received: by 2002:a05:690c:3383:b0:5ff:6175:bd0e with SMTP id
 fl3-20020a05690c338300b005ff6175bd0emr34769ywb.79.1706199290778; 
 Thu, 25 Jan 2024 08:14:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 dt2-20020a05690c250200b005ffde38415dsm745909ywb.15.2024.01.25.08.14.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:50 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:48 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] docker: Add tools/buildman/requirements.txt to the cache
Message-ID: <20240125161448.GU3652023@bill-the-cat>
References: <20240118171007.2595536-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+4gKhaUSaiDr0qft"
Content-Disposition: inline
In-Reply-To: <20240118171007.2595536-1-trini@konsulko.com>
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


--+4gKhaUSaiDr0qft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:10:07PM -0500, Tom Rini wrote:

> As we have had this file for a while now, we should include installing
> and populating our pip cache from here as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--+4gKhaUSaiDr0qft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiPgACgkQFHw5/5Y0
tyzQlQwAqD79CXLGuuiv8okHmqFb+H74E+t3jfdYw8ShmFfpFnmJDgpoWRp+LNoN
RxyOX8FUBI7sLBidcbsOl+neumAwPgmwkDBj0BZMAzrxynXAL5hp+4Vu8b9AMFZv
n7WKp24a1I3g0lijtPabo+7SvvfbBO42NVCcYRvtjs2WteJOK1lSEPnWIRwnmynf
QivhOo6t4LftSS1fGJbr+h87c38F2lacnqv8UmphVM+MC62c2jK2V42i3ogia9Qw
QcGqddnLWeW6xiAb/lEaJzR0XRNGPxvnQ/WTXAlUIDUo26fu3RtlSsudc9nH3tFs
gPLecOXQPeQ0qCbiTS66YUZUFpb7i4E9UELqjQGp19bA5fsHm2exprxBRLyPhniM
482/PhY7A8aAwsTnSD1fvhTEVwrSTAeXWe5FAGyLFI81mDyK7vzPa2EzXsIrCpo7
L2Ib+1A9jkz5N6QAyCnmofHtHXw/JyXXaZl/P0bUPTpP2M5MjF5pNR/fS4KC8GZk
8z2xcTP4
=6lsT
-----END PGP SIGNATURE-----

--+4gKhaUSaiDr0qft--
