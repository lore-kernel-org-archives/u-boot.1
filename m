Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396DDC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B024986598;
	Thu, 31 Aug 2023 16:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KfmR05Vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04AC865A2; Thu, 31 Aug 2023 16:08:23 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4EAD86583
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d74a012e613so1082373276.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693490899; x=1694095699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l1Oh5nyoW/YquTD92gQetDX1Twrr0Yj1dYTzu3bt80U=;
 b=KfmR05VbQ7QpRXXwfR8rwW7SDk7/72sPQQynYDDrwxA/zRduFh6C3Gy5q4TznbAnrm
 3EVR+++Zq2BocmO3qhKxZ6Ln32LDWLcH12gqpIGBsPfLN0JWPXUpxcN5IoiuzACPvF9r
 wcrJx54Ncj5Bw3NJdQXxlCKWEQD2Tn+XIdkyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490899; x=1694095699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1Oh5nyoW/YquTD92gQetDX1Twrr0Yj1dYTzu3bt80U=;
 b=aVZ8VFDAR0VMHXxpSjWLczjQ13a4YFFoUN7QcSCl8N+3erVYOMRtjUrPK3tm67c6Pe
 6lQ/PSGrFaeb824A+lfpJS6wmPjQfZ+L3mdvg8dnHLaZdFy294YyQNneVrSYAPJadI/f
 S2YK+aJgds5180JiFYAMfvq7ji/tMIyI+ceoJ1yRKgcLw+DhwkhhTbf2LZ4nzueWbby6
 wWEq4bE5C8OCrrJMuQ8YPtbgh1Y0a1fq+R4dc32GmrVqr+oi9Hizq01ddZHQdpv645gV
 Yy8kuWJY2gMSSzMDXBeev1kjQLY+6WB42W3st4hQMiosgapdH8sFY3ALivplzwIUPoRH
 h1mA==
X-Gm-Message-State: AOJu0Yw4pvHA/+Idf6xqUnjTwb5eR3ZsHAomVtHrCUjzbRNEUvwTuzxc
 WyW+m7AP85MjqUncT+rDNT52/w==
X-Google-Smtp-Source: AGHT+IEpe/c39J/57UIuNywxNRm8bBVjDtHrG8vIoJmN2G4ygoap0JvbEuDtyWgKi3bUH9vGvMe9OA==
X-Received: by 2002:a25:cb4d:0:b0:d67:46c9:d0fd with SMTP id
 b74-20020a25cb4d000000b00d6746c9d0fdmr2814551ybg.22.1693490899647; 
 Thu, 31 Aug 2023 07:08:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 w188-20020a2530c5000000b00d71c764379fsm327960ybw.55.2023.08.31.07.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:08:19 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:08:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH v2 05/19] net: Move SYS_RX_ETH_BUFFER into the network menu
Message-ID: <20230831140817.GT3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="87LyHHpKVJGCrts0"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-6-sjg@chromium.org>
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


--87LyHHpKVJGCrts0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:52:59PM -0600, Simon Glass wrote:

> Move this Kconfig option into the correct place, so it doesn't show up
> in the top-level menu.
>=20
> Unfortunately this makes the CONFIG undefined on some boards which don't
> enable CONFIG_NET but do include the net.h header file. In fact that
> header is included from a lot of common places. So use a fallback in the
> header file.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

NAK, we leave the option where it is until someone comes and cleans up
net.h usage.

--=20
Tom

--87LyHHpKVJGCrts0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwntEACgkQFHw5/5Y0
tywhRQwAhhcIiUTFR7Tm2BieM+Fmh6NQu/0LW7EDR+THkxEId6OOvdHmFkeXYRly
fK+LfSsMAYCB8cak0wS1j4wqzkQ/QtVyv1jlI9+nvDlKXXEzmiXKp7FnBLxnltgR
uVW5Vqr/PhGNwwi8tWaOalBG3CAVVg7FnBpmpQegzgHiA35qGm1CgcyBaERXqr3p
Nh3oiCZA/XrpZJqYfGyZVeEy6RTASABFBJ2tLImJ3lcQsIw6NcJKSgum+NOAObA0
UXUz9iO496QcFBKfS1pSmpLFJ4ioNzdWgp+CUATPy0A9yHu05MK9J5QAIaBaKw1F
9WcWFg6Lr14YF4Ij8W2xZ0MKcP7ogYt1OdGw5CiVbVjLWJA7AbM+ETsLY48yLKp+
/AHnsXn1oxH8zspRQz3XNmXasWwkbfh9ztvKvIaFEdBPzNoNwp7kKd9hDkwAHccX
Mth4MtMaxsO1cvYO8F25kfU02zSefHikz5Ttnh9YtZIoW/xKERWMuY8rZle1bsCz
WU++pys9
=a77p
-----END PGP SIGNATURE-----

--87LyHHpKVJGCrts0--
