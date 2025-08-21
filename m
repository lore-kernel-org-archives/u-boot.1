Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D6ACA0FE2
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 19:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7708006D;
	Thu, 21 Aug 2025 21:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q0l0h9SO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE1A80422; Thu, 21 Aug 2025 21:12:39 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DBC8004F
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 21:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-435de838484so943144b6e.3
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755803555; x=1756408355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QJ6mzgt0xendzwkj695o9TM0fjAGp+tHvvYSJhCbFUU=;
 b=q0l0h9SO1J+CaoiEtWkMsrQvYqjRkuVm0A+nvTWim+gRDrAUTw5HcD06YDfZ0ChpUA
 eYS8qNf2j4WRt3q/vAeEbGC00NlSGCVm2XRpjCnQ9NfnCyjj6Jdzg0uFJdDB3BzSzJeP
 KiEii9mDcAhM5cJp8Vn418oEYrS0sXakAiFd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755803555; x=1756408355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ6mzgt0xendzwkj695o9TM0fjAGp+tHvvYSJhCbFUU=;
 b=HSORUI6JOwh2lwpgUmHKaN1YEJJf35OkfXdA346+CXnajwh9g8GvXo7mJDSQ0FK+vz
 u10+NLdhCYbzpV2RF69eqYRltegi6jpuJXrvgHnncnlf6dv0lOtYkGaeiUDpUbIhjF/E
 1ENhXlisx9oPECWd89+4iNucFEDo3p8tAuXvhjHdLbCKWGvxRPhrZtYxzYd3CqYSqzFX
 1p4l4uvniLwUn7b0L6Eey9m+6gki5Ln1q1vfrMivtDYW+kI79hwUmix3eFk9Zqzyc4GL
 tbwPvFH5A6diZAKDy7RwhGLJjgQ3WdIy4wLkj/SuI3DjaVNsnB9az/ZGP0IdNHuHfCcW
 J8uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/gJ24/AbScShYSTrBQYlFne8XIjon9X3y0xmwZ/pYOgAY7lA9vOO1jSD01luWsSW5vZEWprk=@lists.denx.de
X-Gm-Message-State: AOJu0YxbEb8zkzCpq+CXCMMRArTZSzEZw9kfbMUnOfaomqryykiXT/q9
 s47cUBSvZ0LFU8L/fVv14nqf8pE2x3kAiC3WFO49CiBBE5sC1cE0rjdkk1BzNVEnqM/OIs1mXXC
 Qh2b8dgc=
X-Gm-Gg: ASbGncuB73DU2TrxXCWRsjsg1A8CjwkfoegtiH3oxTBUCM9YyozgFnPixh948RDkci5
 tD8ypBUtObNdsBw81bJ5JgoVtyjLnDDpPNXk6HrgNpcsNkPNC4Z5ucHPonvMuJSkKvmk8eMTkTx
 YQw02Z5bwQvVy8qq7bi0rynxtJZiYqjDO6y6aVFYMGaWR8v6igZPpBpgRzB0waOcwUGmWm0Ab/t
 mulXRttnpzScp99mXD1nf5BE6uLyogS0mhxE8jGivVfLIJdb+3WP11UnTZnN9uYW060Jic8HCeB
 NIZUf03cQdSL2RsOS6RNy2kaKpLbXUWJV2g0C8sHriK8bqUBSx3FtS0Mgsk8++7mrdMxkh3jxDX
 V3dvTozTwODUPX7qzwVVMirA43tSd70E1QWArVmwCjVYDNJqI9lr3OG1S
X-Google-Smtp-Source: AGHT+IEz9DdFb7EwhZuDQNX6OTmjMmpm5Nrm10uyL39wEJVcFCyG3pUYBpSC5TkmCFX+BxIEQoRnUQ==
X-Received: by 2002:a05:6808:2101:b0:434:231:3e2c with SMTP id
 5614622812f47-43785009150mr351078b6e.0.1755803555273; 
 Thu, 21 Aug 2025 12:12:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204d621sm3653937a34.40.2025.08.21.12.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 12:12:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:12:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] bloblist: fix missing OR between licenses in the
 SPDX-License-Identifier
Message-ID: <20250821191232.GA917481@bill-the-cat>
References: <20250814120029.234237-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="viloPxx2VZPZn9Oe"
Content-Disposition: inline
In-Reply-To: <20250814120029.234237-1-Max.Merchel@ew.tq-group.com>
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


--viloPxx2VZPZn9Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 02:00:11PM +0200, Max Merchel wrote:

> Currently, the conditions of both licenses (GPL 2.0 and BSD-3-Clause) must
> be met. However, the original commit message states that the BSD-3-Clause
> was added to allow use of the files under a less restrictive license than
> GPL 2.0. Therefore, the required OR between the licenses has been added.
>=20
> While at it update the SPDX-License-Identifier to SPDX version 3.
>=20
> Fixes: 6c9e3d1f ("bloblist: Relicense to allow BSD-3-Clause")
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> ---
>  common/bloblist.c  | 2 +-
>  include/bloblist.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

So I'm going to defer this as the outcome of
https://patchwork.ozlabs.org/project/uboot/patch/20250101195817.995321-1-sj=
g@chromium.org/
was that it's fine to relicense but a v2 with a differ commit message
is needed. And while I thought about doing the v2 myself now, I think
this is something that really must come from the author.

--=20
Tom

--viloPxx2VZPZn9Oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKdvnAAKCRAr4qD1Cr/k
CthcAQDP81Od4lX4lcCZzyIMIoWPHaPqVvB7yjaDnhirn8VSngD/QUhSDaLxolvw
qrvghprQ3uLXNDvKXtLO11kGgqNNxQk=
=1RGM
-----END PGP SIGNATURE-----

--viloPxx2VZPZn9Oe--
