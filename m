Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70385C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797AE87A35;
	Wed, 25 Oct 2023 01:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kJkwihLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573F1879ED; Wed, 25 Oct 2023 01:17:11 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1478887A17
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a82f176860so50179457b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189415; x=1698794215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=itjj59SGq4Mqhew44TY/WvTGuHta/T1sLxQYhGCGlpE=;
 b=kJkwihLzhPYQYLtz013AsIAeGYwnKXK4kfvbBWXbNDGNaDzwz5riSWgKsKiEhOxii7
 4VgabSj//9t3f/2yqUkOtBFT0aRg8dewam5oXBD94N+W7BlVtLUSmwZ55I4m3R20JTde
 QawjlqvMV5L1eCpuRMvrXZrFlQwRZp+FefwP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189415; x=1698794215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itjj59SGq4Mqhew44TY/WvTGuHta/T1sLxQYhGCGlpE=;
 b=wk+bOXWO7VD2ty+6ercbMutrYRFD+ORnRrAajBiyDXV1epwXixBCT94/f9B6Pv28Qb
 blSGRi0uYbuqBmK2UaCF3fwhtS1d18WByyNoTO07t4Z/7hLKDn0SjAJi8VGNSXM7tpgR
 gOoVRbgyFE44YC3YKmXG2Nog2urdemUO/dPS0OpPNps2NsOOmF50CobGSnCgV4B9QTsU
 Uq/35FkNhZMSra7O+s9r5gCRIClwG4mAO8qYKFaB1WSt5rbatpOQKL1147A7hB7W8aVJ
 0w9slMwtKvjiimcIFfQ3LrDhTJlasy2EzJ7akuE4spKpGjac7LKWtYJxlIoEhFIVFJ0u
 pOdg==
X-Gm-Message-State: AOJu0YxDGn77qwIFuklyunJ0zut4D7dSNWbzO+RRetgbopLnXoSHqiFP
 tVa+zsH07y66Qpwn7hs9+1lUaA==
X-Google-Smtp-Source: AGHT+IHdXG+8MwmEqrkSGMYqmBcfMI9p4s0Km38754E0KFgvtOZbLmNAAuusVguAeq0wP/wQVUey4w==
X-Received: by 2002:a0d:ca04:0:b0:5a7:c8a9:79e8 with SMTP id
 m4-20020a0dca04000000b005a7c8a979e8mr14739460ywd.4.1698189414860; 
 Tue, 24 Oct 2023 16:16:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 b190-20020a0dd9c7000000b005a23ab90366sm4471227ywe.11.2023.10.24.16.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:54 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:52 -0400
From: Tom Rini <trini@konsulko.com>
To: John Clark <inindev@gmail.com>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Rong Tao <rongtao@cestc.cn>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] .gitignore: ignore misc include, simple-bin, and
 tools/generated build artifacts
Message-ID: <20231024231652.GC496310@bill-the-cat>
References: <20231013132630.43018-1-inindev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0zICM8LHHHQ0D9P4"
Content-Disposition: inline
In-Reply-To: <20231013132630.43018-1-inindev@gmail.com>
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


--0zICM8LHHHQ0D9P4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 01:26:16PM +0000, John Clark wrote:

> make rock5b-rk3588_defconfig
> make
> git status
>=20
> before
> ~~~~~~~
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
>=20
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	include/autoconf.mk
> 	include/autoconf.mk.dep
> 	include/config.h
> 	mkimage-in-simple-bin-spi.mkimage-rockchip-tpl
> 	mkimage-in-simple-bin-spi.mkimage-u-boot-spl
> 	mkimage-in-simple-bin.mkimage-rockchip-tpl
> 	mkimage-in-simple-bin.mkimage-u-boot-spl
> 	simple-bin-spi.map
> 	simple-bin.fit.fit
> 	simple-bin.fit.itb
> 	simple-bin.map
> 	tools/generated/
>=20
> after
> ~~~~~~~
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
>=20
> nothing to commit, working tree clean
>=20
> Signed-off-by: John Clark <inindev@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--0zICM8LHHHQ0D9P4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UGQACgkQFHw5/5Y0
tyxFKwv/Sm8R8jK3FBbGEED6a9BtvxEN7F0p+vrtCIFwfR3qawh+pDXGl+2if6y1
HjSNydIQEENYe8Yrboa3d5v0Q4tPKc23fWnEF2C0eLpb4dhrfL5lIJJLJQBfYzce
cB2bzPIkTuboPlFR7UiEgSwCKXIEjamWUco4q+d64ktv7mEbgSjbso5Xuclox/vp
ghp60fnuvgcbbPxkkYi9wejOGCcbQErL22aZZThyK2WtWkJEdcPSHo8duRUFmZH9
1tO9m+IDDxnBnpwjUZdY2QBb1aDCnxAZRY1XqQI+18JZQX71jLkm3ig5s1MzhaO5
j75Hi9xLwrxscS9SEY7hhP3LUUhCuRUdI9m9HF4IWEe49W1G2BIOe+uKkdWPxxD0
/Wv0N2gpkeiPHhvC0PjUPIMXLRB5EcMHVhsPGPT1ig1Oc1ZbRxlutHkYo2RHemTt
ywMzi7H7T1acu+Dnsp+DWwpJr/jOj3DXg4fd9W3ztdWmpbH56T+W/iod5pnHcETJ
u0kiU7Y4
=IZQD
-----END PGP SIGNATURE-----

--0zICM8LHHHQ0D9P4--
