Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56585C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 15:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC10A8897A;
	Wed, 31 Jul 2024 17:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tom4NjLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87DA7889D2; Wed, 31 Jul 2024 17:33:34 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8342A88958
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 17:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id AA5CCCE1372;
 Wed, 31 Jul 2024 15:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD5EC116B1;
 Wed, 31 Jul 2024 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722440009;
 bh=puG2uIF0EPLNs3+qhezi037D53oY5dyQtgXehs4Nuzo=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=tom4NjLriK8WDegDlN9FJgJ5SRBR4335uBvFuN1eAzV5PhJaxtOPZEsxBLss85gE1
 VQW5mgw02KjLJpd7OepnQgm/OdvhL8ILyY+e7V1m5SGg91t3bcqyfwOILOB4VvJXGJ
 cem0Dr2aRvTit8AdMf39SN+j94Pl0ezEZ5TSHaPKwFCLwJIIh6QWY39QsFqdGgeJcJ
 2VRyH6ATMbw2y2mWJPVFMkQAl94/Jig8nEd73tUxRIDFrGHPpqPPb+lJgEEPhZmgtz
 XTnQSMxtE8xNwaDVrggNyj7HNzwtSQ32bSXdO26ry5Y48gk+lf5rhIeg+fSb6jp0tq
 c9ryn85ZNhdtw==
Content-Type: multipart/signed;
 boundary=8c07f085817ce1b0adfcde9b23a7fcf9d896ec3a530a3a9f4ef1de11fef7;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 31 Jul 2024 17:33:25 +0200
Message-Id: <D33U0UZY7230.18W0UEVD0508X@kernel.org>
Subject: Re: [PATCH v2] boot: android: fix booting without a ramdisk
Cc: "Tom Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Simon Glass" <sjg@chromium.org>, "Mattijs Korpershoek"
 <mkorpershoek@baylibre.com>
X-Mailer: aerc 0.16.0
References: <20240729213657.2550935-1-mwalle@kernel.org>
 <875xsnqn3q.fsf@baylibre.com>
 <CAFLszTip3uwZLy=jL+-BKwD74Wk8j6So_N9TW_P16gpBvLKQRQ@mail.gmail.com>
In-Reply-To: <CAFLszTip3uwZLy=jL+-BKwD74Wk8j6So_N9TW_P16gpBvLKQRQ@mail.gmail.com>
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

--8c07f085817ce1b0adfcde9b23a7fcf9d896ec3a530a3a9f4ef1de11fef7
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > -                     if (ret)
> > > +                     if (ret =3D=3D -ENOENT)
> > > +                             return -ENOPKG;
>
> We normally use -ENOENT for this sort of thing.

That's the way select_ramdisk() is documented. It was actually
introduced by yourself in commit e4c928792e93 ("image: Split up
boot_get_ramdisk()") :)

-michael

--8c07f085817ce1b0adfcde9b23a7fcf9d896ec3a530a3a9f4ef1de11fef7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqpZRhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j/bwF/RXnYVe3YVsBOrAHWmgjyHz6k+RtS5IWu
SP5khUtke1SRe+8kDVKZDxCYAMh4WQ1KAX4nN+BDxk+ksUxy0D8b6/XvgPPd8LHU
UkO7fYypVktR2ynEtViZobVnoa5+zn0DGxY=
=U8vO
-----END PGP SIGNATURE-----

--8c07f085817ce1b0adfcde9b23a7fcf9d896ec3a530a3a9f4ef1de11fef7--
